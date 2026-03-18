Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E48103E189
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 14:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2rSz-0002rh-M5; Wed, 18 Mar 2026 10:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1w2rSy-0002rK-Ce
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 10:01:44 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1w2rSw-0005oH-T7
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 10:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773842503; x=1805378503;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=90kUuCitCAIs4715mOIY03O2iNep11NxIP4ar18j9X4=;
 b=ZBOsFV5HgA8zm//AWWAN5/3fthjfvdOp6yNet530e00iFl+D0V92Uyp0
 cosZMmB74NZ5L7Y3vFwNTe0fZqMD/QACeegsZ8hEzWy4+Zv8UliCZdKrT
 PGIndz/+9KF9rsmov9FxmbU8hyH76IeQfCmPiTnuCR1uwzP4BKChtC0li
 w/TWLhdv9IciX1xMvf230EWHAYmS/S12WS6r1fkg0dezsVbjYEX39NpMk
 oPdpD/PauXM+yRDJkEQZuSobAUWbUJT2buV6wPsrxRisJNZJfmpihov68
 veTLdjY5//S2O5uG5oeYJkyFwe7ojF9DwxZZzmloIZgwoprhe1iR1Qfu4 A==;
X-CSE-ConnectionGUID: GDJ0cuX7RK+f3K/i3vA3KA==
X-CSE-MsgGUID: /3ewt5Q7TlqSuQVV9XSdGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74925792"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="74925792"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 07:01:42 -0700
X-CSE-ConnectionGUID: 30ehs/XVSkawEEgxCN7PdQ==
X-CSE-MsgGUID: FytE+OzFTLipGayDVGS1UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="218205230"
Received: from junjieca-mobl.ccr.corp.intel.com ([10.124.242.111])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 07:01:40 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 junjie.cao@intel.com
Subject: [PATCH v2 2/3] migration/file: fix type mismatch and NULL deref in
 multifd_file_recv_data
Date: Wed, 18 Mar 2026 22:01:12 +0800
Message-ID: <20260318140113.434-3-junjie.cao@intel.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20260318140113.434-1-junjie.cao@intel.com>
References: <20260318140113.434-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=junjie.cao@intel.com;
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

Fix both issues by switching to qio_channel_pread_all() introduced in
the previous commit, which retries on short reads and treats
end-of-file as an error, so the caller no longer needs to check the
byte count manually.  Add ERRP_GUARD() so that error_prepend() works
correctly even when errp is &error_fatal or NULL.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 migration/file.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index 5618aced49..b0d3affa4c 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -254,16 +254,15 @@ int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
 
 int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp)
 {
+    ERRP_GUARD();
     MultiFDRecvData *data = p->data;
-    size_t ret;
-
-    ret = qio_channel_pread(p->c, (char *) data->opaque,
-                            data->size, data->file_offset, errp);
-    if (ret != data->size) {
-        error_prepend(errp,
-                      "multifd recv (%u): read 0x%zx, expected 0x%zx",
-                      p->id, ret, data->size);
-        return -1;
+    int ret;
+
+    ret = qio_channel_pread_all(p->c, (char *) data->opaque,
+                                data->size, data->file_offset, errp);
+    if (ret < 0) {
+        error_prepend(errp, "multifd recv (%u): ", p->id);
+        return ret;
     }
 
     return 0;
-- 
2.43.0


