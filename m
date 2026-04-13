Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5030F34C49
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 13:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCHcY-00057K-B6; Mon, 13 Apr 2026 09:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wCHcX-00056l-1g
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:46:33 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wCHcV-0002H1-GE
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776087992; x=1807623992;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jRIYr/DJPikQoTUtLLf24NEzeIOFia6aU6GKa/BmoKA=;
 b=JuPavCBXydKLribUPiYNn7ONXxn6tvNffsOv1MzoYyZdX+uIPCFWBHq6
 a7QcWHekemdFdKBsBUtnkQbYtMvVAtw4yXW/UuLU+DlzBv7ahdBi3AMev
 cVgxd2Gm3+uLfAUHIjREqucHL2keofRuiS0V/DMBliHrZeMIBqjGC/gaI
 UvED3JHS5YWSjrOwmXRiqM7TgElYr6s0XhIcKVIA+IWps4SiVPN/XcF8o
 FsGEjAgw3eDyqgx/ZMHNzG0KhnPR/ZBaZVnI1KKXv7O+Dcl77g52TNsFD
 fWjV2vhHjwMrNWfNJKEV0RLZq9Zvtyneeq198rc8uMh8LDIMCqjiZ9sIu Q==;
X-CSE-ConnectionGUID: HFgKHtr+TIC+F5/5Z6eEiA==
X-CSE-MsgGUID: 8M0HvRKgSwqlJyA52+tIxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="80885675"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="80885675"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 06:46:30 -0700
X-CSE-ConnectionGUID: mRaTV8cTR++7NbeU2U3tEA==
X-CSE-MsgGUID: ffP93G3MQ9SAB2yOrdMGKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="234770429"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by orviesa005-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 06:46:29 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, peterx@redhat.com, farosas@suse.de,
 junjie.cao@intel.com
Subject: [PATCH v3 3/4] migration/file: fix type mismatch and NULL deref in
 multifd_file_recv_data
Date: Tue, 14 Apr 2026 05:45:48 +0800
Message-ID: <20260413214549.926435-4-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413214549.926435-1-junjie.cao@intel.com>
References: <20260413214549.926435-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.54, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

multifd_file_recv_data() stores the return value of qio_channel_pread()
(ssize_t) in a size_t variable.  On I/O error the -1 return value wraps
to SIZE_MAX, producing a nonsensical read size in the error message.

More critically, a short read (0 <= ret < data->size) is possible when
the migration file is truncated.  In that case qio_channel_pread()
returns a non-negative value without setting *errp.  The function then
calls error_prepend(errp, ...) which dereferences *errp -- a NULL
pointer -- crashing QEMU.

Fix both issues by switching to qio_channel_pread_all() introduced in
a previous patch, which retries on short reads and treats end-of-file
as an error, so the caller no longer needs to check the byte count
manually.  Add ERRP_GUARD() so that error_prepend() works correctly
even when errp is &error_fatal or NULL.

Fixes: a49d15a38d3d ("migration/multifd: Support incoming mapped-ram stream format")
Suggested-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 migration/file.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index 5618aced49..0853188601 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -254,15 +254,16 @@ int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
 
 int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp)
 {
+    ERRP_GUARD();
     MultiFDRecvData *data = p->data;
-    size_t ret;
+    int ret;
 
-    ret = qio_channel_pread(p->c, (char *) data->opaque,
-                            data->size, data->file_offset, errp);
-    if (ret != data->size) {
+    ret = qio_channel_pread_all(p->c, (char *) data->opaque,
+                                data->size, data->file_offset, errp);
+    if (ret != 0) {
         error_prepend(errp,
-                      "multifd recv (%u): read 0x%zx, expected 0x%zx",
-                      p->id, ret, data->size);
+                      "multifd recv (%u): ",
+                      p->id);
         return -1;
     }
 
-- 
2.43.0


