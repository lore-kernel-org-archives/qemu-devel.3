Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D73DF013DC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 08:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w23b8-0007jt-4f; Mon, 16 Mar 2026 04:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1w23b5-0007jk-Uw
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 04:46:47 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1w23aw-0003R5-S6
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 04:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773650799; x=1805186799;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dtFnDZoak+gWqOvvm18INxB8nDqcCSBBe/kQuZPrV2I=;
 b=RhKGrn1LQdUNj/UqnoIP1jCH7mkhn9Coc5sSIjFzRJkQo2nFmjLikGtR
 3p03QXS6YVWSUmJ6A8ceRAVslGsJNvR/4Ea6RzT4ydkzGoxy3dumoJJ8i
 Klr/WcSdBwXNPnnh3nnBvvsQA+iLY6HP1jcmoSsI4YTXwa/bDIRuEBJVd
 sQ/wQ7IGG99iDN1v5BgIGOGC9qRP96LinnbQv9nf9cmO/3yY/h5bNzfpb
 d6O4bdBTlcmXcJP2HdT+l+KMV267DTxvznUgxikHER3RgV96u8GWNBJTs
 HD4i2YbB0N1PffWl4VR/kKxE01praMRK8MzCmu8unifE1Kfv2tnRET15f w==;
X-CSE-ConnectionGUID: WneSnzSXRhaNMPM8NMDD1Q==
X-CSE-MsgGUID: /JSX8PXqQGmneSCCtNBqKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74634360"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="74634360"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 01:46:32 -0700
X-CSE-ConnectionGUID: O++ba2MXQRCb3jSB3tU5FA==
X-CSE-MsgGUID: 1iHkKGeOS6+RiX6fyD69wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="252363919"
Received: from junjieca-mobl.ccr.corp.intel.com ([10.124.242.111])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 01:46:30 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org,
	peterx@redhat.com,
	farosas@suse.de
Cc: junjie.cao@intel.com
Subject: [PATCH] migration/file: fix type mismatch and NULL deref in
 multifd_file_recv_data
Date: Mon, 16 Mar 2026 16:46:18 +0800
Message-ID: <20260316084618.52-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.53.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

multifd_file_recv_data() stores the return value of qio_channel_pread()
(ssize_t) in a size_t variable.  On I/O error the -1 return value wraps
to SIZE_MAX, producing a nonsensical read size in the error message.

More critically, a short read (0 <= ret < data->size) is possible when
the migration file is truncated.  In that case qio_channel_pread()
returns a non-negative value without setting *errp.  The function then
calls error_prepend(errp, ...) which dereferences *errp -- a NULL
pointer -- crashing QEMU.

Fix both issues by changing ret to ssize_t and splitting the error
handling: use error_prepend() only when qio_channel_pread() itself
has populated *errp (ret < 0), and error_setg() for the short-read
case where *errp has not been set.  Add ERRP_GUARD() so that
error_prepend() works correctly even when errp is &error_fatal or
NULL.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 migration/file.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index 5618aced49..78b274dc32 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -254,15 +254,21 @@ int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
 
 int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp)
 {
+    ERRP_GUARD();
     MultiFDRecvData *data = p->data;
-    size_t ret;
+    ssize_t ret;
 
     ret = qio_channel_pread(p->c, (char *) data->opaque,
                             data->size, data->file_offset, errp);
+    if (ret < 0) {
+        error_prepend(errp, "multifd recv (%u): ", p->id);
+        return -1;
+    }
+
     if (ret != data->size) {
-        error_prepend(errp,
-                      "multifd recv (%u): read 0x%zx, expected 0x%zx",
-                      p->id, ret, data->size);
+        error_setg(errp,
+                   "multifd recv (%u): read 0x%zx, expected 0x%zx",
+                   p->id, (size_t)ret, data->size);
         return -1;
     }
 
-- 
2.43.0


