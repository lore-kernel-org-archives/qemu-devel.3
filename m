Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68115C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 05:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhNem-0004PU-6B; Tue, 05 Mar 2024 00:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rhNek-0004Os-8k
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 00:48:02 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rhNei-0003aU-ED
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 00:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709617680; x=1741153680;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8o9PzPxYWHyGA94uYLgZFj1vQmFnu0Bc2BJBZXqmcdg=;
 b=ecGCpAyl7acuWspOUGg3sez98tm3kRNPNkUgE8ts7qdgKxnspkRXpf13
 iUHr5X6U+s/5hzmyRheOvYuViW9n1OL/C6jQ/rSscKYcQQTBYEHNW7RcG
 KVgWXDE4bS4gMTTEiP8iju3EFNmcRGPzb1WrYLtDR3chup+VZQC8qfEMU
 YfhdXc7HeghKWJuFoA6ZJFb+DsHKttfZPaYNYzzrfBR0qrMkHSfYK6HK9
 aHShI04r6NISpxOuw5JBKo5cjuaG4ZPnAtH1txgPQyShKzsUf3qOCAYI+
 Q+BZ3u6sh6KE0TMwCuOxPas13Ny9S7FlUPCYyIft44yHoUUvA9+qzZg68 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4006205"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4006205"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 21:47:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; d="scan'208";a="40135883"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa002.jf.intel.com with ESMTP; 04 Mar 2024 21:47:57 -0800
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org, hao.xiang@bytedance.com, bryan.zhang@bytedance.com,
 yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: [PATCH v4 2/8] migration/multifd: add get_iov_count in the multifd
 method
Date: Mon,  4 Mar 2024 22:00:22 +0800
Message-Id: <20240304140028.1590649-3-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240304140028.1590649-1-yuan1.liu@intel.com>
References: <20240304140028.1590649-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.571, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

the new function get_iov_count is used to get the number of
IOVs required by a specified multifd method

Different multifd methods may require different numbers of IOVs.
Based on streaming compression of zlib and zstd, all pages will be
compressed to a data block, so an IOV is required to send this data
block. For no compression, each IOV is used to send a page, so the
number of IOVs required is the same as the number of pages.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
---
 migration/multifd-zlib.c | 18 +++++++++++++++++-
 migration/multifd-zstd.c | 18 +++++++++++++++++-
 migration/multifd.c      | 24 +++++++++++++++++++++---
 migration/multifd.h      |  2 ++
 4 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 012e3bdea1..35187f2aff 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -313,13 +313,29 @@ static int zlib_recv_pages(MultiFDRecvParams *p, Error **errp)
     return 0;
 }
 
+/**
+ * zlib_get_iov_count: get the count of IOVs
+ *
+ * For zlib streaming compression, all pages will be compressed into a data
+ * block, and an IOV is requested for sending this block.
+ *
+ * Returns the count of the IOVs
+ *
+ * @page_count: Indicate the maximum count of pages processed by multifd
+ */
+static uint32_t zlib_get_iov_count(uint32_t page_count)
+{
+    return 1;
+}
+
 static MultiFDMethods multifd_zlib_ops = {
     .send_setup = zlib_send_setup,
     .send_cleanup = zlib_send_cleanup,
     .send_prepare = zlib_send_prepare,
     .recv_setup = zlib_recv_setup,
     .recv_cleanup = zlib_recv_cleanup,
-    .recv_pages = zlib_recv_pages
+    .recv_pages = zlib_recv_pages,
+    .get_iov_count = zlib_get_iov_count
 };
 
 static void multifd_zlib_register(void)
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index dc8fe43e94..25ed1add2a 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -304,13 +304,29 @@ static int zstd_recv_pages(MultiFDRecvParams *p, Error **errp)
     return 0;
 }
 
+/**
+ * zstd_get_iov_count: get the count of IOVs
+ *
+ * For zstd streaming compression, all pages will be compressed into a data
+ * block, and an IOV is requested for sending this block.
+ *
+ * Returns the count of the IOVs
+ *
+ * @page_count: Indicate the maximum count of pages processed by multifd
+ */
+static uint32_t zstd_get_iov_count(uint32_t page_count)
+{
+    return 1;
+}
+
 static MultiFDMethods multifd_zstd_ops = {
     .send_setup = zstd_send_setup,
     .send_cleanup = zstd_send_cleanup,
     .send_prepare = zstd_send_prepare,
     .recv_setup = zstd_recv_setup,
     .recv_cleanup = zstd_recv_cleanup,
-    .recv_pages = zstd_recv_pages
+    .recv_pages = zstd_recv_pages,
+    .get_iov_count = zstd_get_iov_count
 };
 
 static void multifd_zstd_register(void)
diff --git a/migration/multifd.c b/migration/multifd.c
index adfe8c9a0a..787402247e 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -209,13 +209,29 @@ static int nocomp_recv_pages(MultiFDRecvParams *p, Error **errp)
     return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
 }
 
+/**
+ * nocomp_get_iov_count: get the count of IOVs
+ *
+ * For no compression, the count of IOVs required is the same as the count of
+ * pages
+ *
+ * Returns the count of the IOVs
+ *
+ * @page_count: Indicate the maximum count of pages processed by multifd
+ */
+static uint32_t nocomp_get_iov_count(uint32_t page_count)
+{
+    return page_count;
+}
+
 static MultiFDMethods multifd_nocomp_ops = {
     .send_setup = nocomp_send_setup,
     .send_cleanup = nocomp_send_cleanup,
     .send_prepare = nocomp_send_prepare,
     .recv_setup = nocomp_recv_setup,
     .recv_cleanup = nocomp_recv_cleanup,
-    .recv_pages = nocomp_recv_pages
+    .recv_pages = nocomp_recv_pages,
+    .get_iov_count = nocomp_get_iov_count
 };
 
 static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] = {
@@ -998,6 +1014,8 @@ bool multifd_send_setup(void)
     Error *local_err = NULL;
     int thread_count, ret = 0;
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    /* We need one extra place for the packet header */
+    uint32_t iov_count = 1;
     uint8_t i;
 
     if (!migrate_multifd()) {
@@ -1012,6 +1030,7 @@ bool multifd_send_setup(void)
     qemu_sem_init(&multifd_send_state->channels_ready, 0);
     qatomic_set(&multifd_send_state->exiting, 0);
     multifd_send_state->ops = multifd_ops[migrate_multifd_compression()];
+    iov_count += multifd_send_state->ops->get_iov_count(page_count);
 
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
@@ -1026,8 +1045,7 @@ bool multifd_send_setup(void)
         p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
         p->packet->version = cpu_to_be32(MULTIFD_VERSION);
         p->name = g_strdup_printf("multifdsend_%d", i);
-        /* We need one extra place for the packet header */
-        p->iov = g_new0(struct iovec, page_count + 1);
+        p->iov = g_new0(struct iovec, iov_count);
         p->page_size = qemu_target_page_size();
         p->page_count = page_count;
         p->write_flags = 0;
diff --git a/migration/multifd.h b/migration/multifd.h
index 8a1cad0996..d82495c508 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -201,6 +201,8 @@ typedef struct {
     void (*recv_cleanup)(MultiFDRecvParams *p);
     /* Read all pages */
     int (*recv_pages)(MultiFDRecvParams *p, Error **errp);
+    /* Get the count of required IOVs */
+    uint32_t (*get_iov_count)(uint32_t page_count);
 } MultiFDMethods;
 
 void multifd_register_ops(int method, MultiFDMethods *ops);
-- 
2.39.3


