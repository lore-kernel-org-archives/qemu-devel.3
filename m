Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DF0E6FE20
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 15:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY4ev-0008VE-RD; Tue, 23 Dec 2025 10:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vY4es-0008Tf-Bq
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:50:47 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vY4er-0005PD-0Y
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:50:46 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DF6976013A;
 Tue, 23 Dec 2025 15:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1E6C113D0;
 Tue, 23 Dec 2025 15:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766505043;
 bh=6Hs5Xpfju4NFUCsUbYBJkDYqwqK5L0Tna0ewspw/aEo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RTABkSpBuXeH4L/WWeiOw5z2wUA+S3MwZ79I9+YoGcV0PY6U7SXU1ikB0JbvoiRq/
 cBp3B9LuK6z9aYxMN2mBYJvTEK1zf6Corx5mgG3RGJLJptVGgziKSXXwdIkfi7qVQp
 1rYTXudju/ADsceIO0WF9of8/5hB3JSGacOR4Wxi1/Nm6w/jsZlTNOFw4t31UOEaiY
 SACeeXrRCqMPn0C5/Mcrf3/ckhz3KvQiNBCHyRiZaVPscpZ6R9sRtXciQQyeoJ8ecB
 yi16cl34mlUAcJ6DmhdRpG/MhftOHc4BWBm65Rij18xC8xr9txs/eCinztw4CmsPSj
 6opRtCfo/PmsQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fam Zheng <fam@euphon.net>
Subject: [PULL 03/12] scsi: ncr710: Fix use after free in command_complete
Date: Tue, 23 Dec 2025 16:50:22 +0100
Message-ID: <20251223155031.7110-4-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223155031.7110-1-deller@kernel.org>
References: <20251223155031.7110-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

Add proper hba_private pointer cleanup in ncr710_command_complete.
This prevents use after free errors from occuring.

This was causing memory corruption in NetBSD device initialization
when commands complete and the request structures were freed while
still being referenced.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/ncr53c710.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index bab2ea7210..ac1ca4cef8 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -798,7 +798,13 @@ void ncr710_command_complete(SCSIRequest *req, size_t resid)
 
     ncr710_set_phase(s, PHASE_ST);
 
-    if (req->hba_private == s->current) {
+    if (p) {
+        req->hba_private = NULL;
+        if (p == s->current) {
+            p->req = NULL;
+        } else {
+            ncr710_request_free(s, p);
+        }
         scsi_req_unref(req);
     }
 
-- 
2.52.0


