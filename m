Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64844CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 07:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrYZw-0000to-Fc; Tue, 02 Apr 2024 03:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rrYZt-0000tA-Q1
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 03:29:05 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rrYZp-0004Eb-Pc
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 03:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712042942; x=1743578942;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EKRCfhH2Tdu0fKht1BCj/62GFmoHAFkgYa8nT4MMzlw=;
 b=mjXmZcSMvpoZRVkRNv9M5hUlJzhb24fj5k3ahtqhhFXf5vUuJGjyqIWY
 6KaYeSjo3CgbUmKpBpfBXbVYpBfpfJyc74Af+6Qjv9qqreRg9VOVWX6Dg
 YhZ/jAgsM88QgtQN+Xf0Tz+qmb1nJhnfH0Ho0nZX8BXV6IAkr7K8JmGCn
 NLldqIXEOwh61q/9KZ3W1yuGLeWxNOUpMs7jTbvw79dVj6PFRUuVzy6+j
 WQfdaTXC+uz/2e1gmemRzkNBojHH0qFJ8dAk21Rxl9FC9EmBnvluD1ihy
 TYNFPL3J9MF1VM75CkGuiJK4htFbjaLJYlmhmPmuZLx3HFNoj33CWXaWV A==;
X-CSE-ConnectionGUID: afBKY5+ESe62iSkPbXu8rg==
X-CSE-MsgGUID: 9hAtjNQ0ShS0M/gdDjp48A==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7063840"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7063840"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2024 00:28:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; d="scan'208";a="18434395"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa006.jf.intel.com with ESMTP; 02 Apr 2024 00:28:49 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org, hao.xiang@bytedance.com, bryan.zhang@bytedance.com,
 yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: [PATCH 1/1] migration/multifd: solve zero page causing multiple page
 faults
Date: Mon,  1 Apr 2024 23:41:10 +0800
Message-Id: <20240401154110.2028453-2-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240401154110.2028453-1-yuan1.liu@intel.com>
References: <20240401154110.2028453-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implemented recvbitmap tracking of received pages in multifd.

If the zero page appears for the first time in the recvbitmap, this
page is not checked and set.

If the zero page has already appeared in the recvbitmap, there is no
need to check the data but directly set the data to 0, because it is
unlikely that the zero page will be migrated multiple times.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
---
 migration/multifd-zero-page.c | 4 +++-
 migration/multifd-zlib.c      | 1 +
 migration/multifd-zstd.c      | 1 +
 migration/multifd.c           | 1 +
 migration/ram.c               | 4 ++++
 migration/ram.h               | 1 +
 6 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
index 1ba38be636..e1b8370f88 100644
--- a/migration/multifd-zero-page.c
+++ b/migration/multifd-zero-page.c
@@ -80,8 +80,10 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
 {
     for (int i = 0; i < p->zero_num; i++) {
         void *page = p->host + p->zero[i];
-        if (!buffer_is_zero(page, p->page_size)) {
+        if (ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
             memset(page, 0, p->page_size);
+        } else {
+            ramblock_recv_bitmap_set_offset(p->block, p->zero[i]);
         }
     }
 }
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 8095ef8e28..6246ecca2b 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -288,6 +288,7 @@ static int zlib_recv(MultiFDRecvParams *p, Error **errp)
         int flush = Z_NO_FLUSH;
         unsigned long start = zs->total_out;
 
+        ramblock_recv_bitmap_set_offset(p->block, p->normal[i]);
         if (i == p->normal_num - 1) {
             flush = Z_SYNC_FLUSH;
         }
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index 9c9217794e..989333b572 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -282,6 +282,7 @@ static int zstd_recv(MultiFDRecvParams *p, Error **errp)
     z->in.pos = 0;
 
     for (i = 0; i < p->normal_num; i++) {
+        ramblock_recv_bitmap_set_offset(p->block, p->normal[i]);
         z->out.dst = p->host + p->normal[i];
         z->out.size = p->page_size;
         z->out.pos = 0;
diff --git a/migration/multifd.c b/migration/multifd.c
index 72712fc31f..c9f544dba0 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -277,6 +277,7 @@ static int nocomp_recv(MultiFDRecvParams *p, Error **errp)
     for (int i = 0; i < p->normal_num; i++) {
         p->iov[i].iov_base = p->host + p->normal[i];
         p->iov[i].iov_len = p->page_size;
+        ramblock_recv_bitmap_set_offset(p->block, p->normal[i]);
     }
     return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
 }
diff --git a/migration/ram.c b/migration/ram.c
index 8deb84984f..3aa70794c1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -275,6 +275,10 @@ void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr,
                       nr);
 }
 
+void ramblock_recv_bitmap_set_offset(RAMBlock *rb, uint64_t byte_offset)
+{
+    set_bit_atomic(byte_offset >> TARGET_PAGE_BITS, rb->receivedmap);
+}
 #define  RAMBLOCK_RECV_BITMAP_ENDING  (0x0123456789abcdefULL)
 
 /*
diff --git a/migration/ram.h b/migration/ram.h
index 08feecaf51..bc0318b834 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -69,6 +69,7 @@ int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
 bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_offset);
 void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
 void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr, size_t nr);
+void ramblock_recv_bitmap_set_offset(RAMBlock *rb, uint64_t byte_offset);
 int64_t ramblock_recv_bitmap_send(QEMUFile *file,
                                   const char *block_name);
 bool ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb, Error **errp);
-- 
2.39.3


