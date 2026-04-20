Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACDBF36C5F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEnSd-0006Fi-1f; Mon, 20 Apr 2026 08:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wEnSR-0006FD-2D
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 08:10:31 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wEnSP-0004Rl-EH
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 08:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776687030; x=1808223030;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CUDka3bP53CRZaZv32S7MqGXZ/SM72d8bEpuI1Piopo=;
 b=ItEY6DrrQqCXTvVGELAfMRomF4dm3hwZyOAzF9qQZUCEiQzHFYXdpmrO
 5iyu67jPt7u5m8Ff2fPgditcQ43937kMW4eJ4TfqL8fwGww+Cc+ed8Myg
 1Za/kmsmxEbcmrz2cMNE0Ztqn1JTdCmZPdvXa1/2cEXSkxgEm+Wu8ewYd
 KooYwIHacBTw5ORWv/CTwsFDQ3v0RwZNhhH8VC4Ev//APYI2bWhop1QIG
 1+EAw8uAVNtM5SFVu1yiZ7PuENN9wFLtN8kk7MX5Sez+VSnKg/owH7wtm
 lxL3S3A9RfSmeOUpMAnzVSwncrWAssRjSofdBXIa8+IxXUHgCvsV8dPg2 A==;
X-CSE-ConnectionGUID: NJ/yu9czScqvlmYg5useOQ==
X-CSE-MsgGUID: REwC9txnQNePC5zRVwpl4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88674250"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="88674250"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 05:10:29 -0700
X-CSE-ConnectionGUID: ZAxxBapDSL2tunq1GIsgbg==
X-CSE-MsgGUID: n/4TiuQ2SO6jNX998X1NEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="235708274"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by ORVIESA003-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 05:10:27 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de,
	junjie.cao@intel.com
Subject: [PATCH 2/3] migration/file: switch file_write_ramblock_iov to
 pwritev_all
Date: Tue, 21 Apr 2026 04:13:16 +0800
Message-ID: <20260420201317.30199-3-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420201317.30199-1-junjie.cao@intel.com>
References: <20260420201317.30199-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

file_write_ramblock_iov() uses single-shot qio_channel_pwritev() and
only checks for ret < 0.  A short write (0 <= ret < requested) would be
treated as success.

Switch to qio_channel_pwritev_all() which retries until all bytes are
written or an error occurs.

Fixes: f427d90b98 ("migration/multifd: Support outgoing mapped-ram stream format")
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 migration/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index 0853188601..3729728dfe 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -200,7 +200,7 @@ void file_connect_incoming(FileMigrationArgs *file_args, Error **errp)
 int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
                             int niov, MultiFDPages_t *pages, Error **errp)
 {
-    ssize_t ret = 0;
+    int ret = 0;
     int i, slice_idx, slice_num;
     uintptr_t base, next, offset;
     size_t len;
@@ -239,8 +239,8 @@ int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
             break;
         }
 
-        ret = qio_channel_pwritev(ioc, &iov[slice_idx], slice_num,
-                                  block->pages_offset + offset, errp);
+        ret = qio_channel_pwritev_all(ioc, &iov[slice_idx], slice_num,
+                                      block->pages_offset + offset, errp);
         if (ret < 0) {
             break;
         }
@@ -249,7 +249,7 @@ int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
         slice_num = 0;
     }
 
-    return (ret < 0) ? ret : 0;
+    return ret;
 }
 
 int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp)
-- 
2.43.0


