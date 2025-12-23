Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E938E6FE21
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 15:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY4ev-0008Ul-37; Tue, 23 Dec 2025 10:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vY4er-0008TP-P1
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:50:45 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vY4eq-0005Op-85
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:50:45 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A4C4460139;
 Tue, 23 Dec 2025 15:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFEDC113D0;
 Tue, 23 Dec 2025 15:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766505041;
 bh=ZbScq6ApZmYfAJAyYzPEfZNaXIoiZr9Ogb8TMMT9ors=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UOLyZcrKWBnCF5yxb2mnksyhxrgEY7nHKOQ1IRHwNXk98sMlT5wkYc6J6qpnKe3Tm
 0sME81KpRWurHlZqunMRrbp3B5Z2EpzCXxmKRZIzGTDMX0ns7EDR68/Z4H0u0MsofE
 lw2HmJLttARL8X/d7OF6QS5p+qhneKcg6MEDe88c3VriiycQq3CiGd/o9qPHU9h/vr
 QqtZJy01UrKK0+oYauVj0diRAfl7PpyVZo7VU3BnG8OZ2a8wcF0PQadB0S9tAX7U2K
 aRX6fSaDM8xWA9lfF84KdAvgkKSVPDBisWIpfaOjdIJwumE6w3+T/5jtFEgntudeB+
 pB2K4ZhaCk46w==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fam Zheng <fam@euphon.net>
Subject: [PULL 02/12] scsi: ncr710: Add null pointer checks
Date: Tue, 23 Dec 2025 16:50:21 +0100
Message-ID: <20251223155031.7110-3-deller@kernel.org>
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

Add nullpointer safety checks in ncr710_request_free() and
ncr710_request_cancelled() to prevent crashed while handing invalid req
structures.

Added to preventing memory corruption, which occured during device
initialization.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/ncr53c710.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 47a6983491..bab2ea7210 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -737,6 +737,12 @@ static void ncr710_add_msg_byte(NCR710State *s, uint8_t data)
 
 static void ncr710_request_free(NCR710State *s, NCR710Request *p)
 {
+    if (!p) {
+        return;
+    }
+    if (p->req && p->req->hba_private == p) {
+        p->req->hba_private = NULL;
+    }
     if (p == s->current) {
         s->current = NULL;
     }
@@ -747,8 +753,11 @@ void ncr710_request_cancelled(SCSIRequest *req)
 {
     NCR710State *s = ncr710_from_scsi_bus(req->bus);
     NCR710Request *p = (NCR710Request *)req->hba_private;
-    req->hba_private = NULL;
-    ncr710_request_free(s, p);
+    if (p) {
+        req->hba_private = NULL;
+        p->req = NULL;
+        ncr710_request_free(s, p);
+    }
     scsi_req_unref(req);
 }
 
-- 
2.52.0


