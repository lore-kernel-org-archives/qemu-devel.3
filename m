Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65165F36C58
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEnSP-00069T-7Q; Mon, 20 Apr 2026 08:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wEnSK-00066J-57
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 08:10:25 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wEnSH-0004MY-Cv
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 08:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776687022; x=1808223022;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=co6/EQDKeNJbkhw8y9V//WgV6dqwIupeKLjGfA2y7iY=;
 b=SXEpMtJ5UqQxpMdbPkGyM0+hY/IqfHSVzFrAWGrzu67P+BTxNVtOZ9p3
 6Oma0RvlmMYuHR4bYck1SaqYBFVkQdo130jP9GssHEWsDZl1fmQyUPpsb
 OJiMKk8iqYHk5YNyMzj/SjE2zywSLOR9akahNkPOthXrWfpm5WVqEeeaC
 a1CMM5G5+diazWJPzHNV2a5GpH0LHAnJSUhanlWlS2dG1asM8ohuLH6Hk
 khOxnji10zNMJqXY40P6hXtBLC8P2Kuog4iiqYiCbKPGoHKJpHJ58GaEC
 dZvRoTxD3X30i8KxVzxzg1FJcd5W5LZ3V3izaUcBbb2WJpxRvW7PMJgpN Q==;
X-CSE-ConnectionGUID: dnb50RiMSTejaZSkqJdhUA==
X-CSE-MsgGUID: Ne/jMz14Q3yXDA6BXyCtVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88674219"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="88674219"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 05:10:20 -0700
X-CSE-ConnectionGUID: KwNelD88S9S0NFWqQHEElg==
X-CSE-MsgGUID: 8JVGcnV3QB+kHj3nYjU63Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="235708261"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by ORVIESA003-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 05:10:18 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de,
	junjie.cao@intel.com
Subject: [PATCH 1/3] migration/qemu-file: switch buffer_at functions to
 positioned I/O _all helpers
Date: Tue, 21 Apr 2026 04:13:15 +0800
Message-ID: <20260420201317.30199-2-junjie.cao@intel.com>
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

qemu_put_buffer_at() and qemu_get_buffer_at() have the same pattern as
the bug fixed in multifd_file_recv_data(): the ssize_t return value from
the channel layer is stored in a size_t variable, and a short transfer
would be mishandled rather than retried.

Switch to qio_channel_pwrite_all() / qio_channel_pread_all() which
handle short transfers internally and make the code more robust and
consistent with the rest of the positioned I/O call sites.

Fixes: 7f5b50a401 ("migration/qemu-file: add utility methods for working with seekable channels")
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 migration/qemu-file.c | 35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 9cf7dc3bd5..9dfb202203 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -535,28 +535,13 @@ void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
                         off_t pos)
 {
     Error *err = NULL;
-    size_t ret;
 
     if (f->last_error) {
         return;
     }
 
     qemu_fflush(f);
-    ret = qio_channel_pwrite(f->ioc, (char *)buf, buflen, pos, &err);
-
-    if (err) {
-        qemu_file_set_error_obj(f, -EIO, err);
-        return;
-    }
-
-    if ((ssize_t)ret == QIO_CHANNEL_ERR_BLOCK) {
-        qemu_file_set_error_obj(f, -EAGAIN, NULL);
-        return;
-    }
-
-    if (ret != buflen) {
-        error_setg(&err, "Partial write of size %zu, expected %zu", ret,
-                   buflen);
+    if (qio_channel_pwrite_all(f->ioc, buf, buflen, pos, &err) < 0) {
         qemu_file_set_error_obj(f, -EIO, err);
         return;
     }
@@ -569,31 +554,17 @@ size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
                           off_t pos)
 {
     Error *err = NULL;
-    size_t ret;
 
     if (f->last_error) {
         return 0;
     }
 
-    ret = qio_channel_pread(f->ioc, (char *)buf, buflen, pos, &err);
-
-    if ((ssize_t)ret == -1 || err) {
+    if (qio_channel_pread_all(f->ioc, (char *)buf, buflen, pos, &err) < 0) {
         qemu_file_set_error_obj(f, -EIO, err);
         return 0;
     }
 
-    if ((ssize_t)ret == QIO_CHANNEL_ERR_BLOCK) {
-        qemu_file_set_error_obj(f, -EAGAIN, NULL);
-        return 0;
-    }
-
-    if (ret != buflen) {
-        error_setg(&err, "Partial read of size %zu, expected %zu", ret, buflen);
-        qemu_file_set_error_obj(f, -EIO, err);
-        return 0;
-    }
-
-    return ret;
+    return buflen;
 }
 
 void qemu_set_offset(QEMUFile *f, off_t off, int whence)
-- 
2.43.0


