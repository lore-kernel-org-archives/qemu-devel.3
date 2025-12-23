Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1402CE6FE20
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 15:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY4fQ-0000KH-Vp; Tue, 23 Dec 2025 10:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vY4f6-00006s-Dn
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:51:00 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vY4f4-0005SZ-Kc
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:50:59 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E2A960141;
 Tue, 23 Dec 2025 15:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3EAC116C6;
 Tue, 23 Dec 2025 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766505054;
 bh=mE7xjASObDRc9yGF3stRQMbI4vx6tSe+e4asccvv24Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CzbYM9Y7yB/5koiEhEJAwwTCRc5GrTUW7T6s/xhkf/kOsgorP5y1Z83cL2828cOVn
 vlLZYRHOMKgYsoh/m3FDgOB5EHg/O+o3sACzCgWzzTooKhtWMq8k3ckFcXaY/NaAQE
 in8TecmaIZIUqKEk+ByNFZNpZGasVzDD5S8JEGKPO1zwxE2lBwol16mAL4cQRNu/Dd
 1UgcpQopC0y7UANdiVUYQu9yKa4XzGa3lTDD5Sg/jVPrdpMgTcKtZThPy7Elvl4PDI
 aq6ttLt5lpd3fW3ietba53njvokSl8d/omuzC+RKPE5whJw3aoCAkLPvFOapO0+hAy
 5tsG2Q14MjBrQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fam Zheng <fam@euphon.net>
Subject: [PULL 08/12] scsi: ncr710: Add LUN scanning
Date: Tue, 23 Dec 2025 16:50:27 +0100
Message-ID: <20251223155031.7110-9-deller@kernel.org>
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

Add multi LUN support by scanning all 8 LUNs when ANT bit is set.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Tested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/ncr53c710.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 3d7318c12e..277aa2c3d3 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -1422,8 +1422,30 @@ again:
                         s->dsp = s->dnad;
                         break;
                     }
-                } else if (!scsi_device_find(&s->bus, 0, idbitstonum(id), 0)) {
+                }
+                bool device_exists = false;
+                if (insn & (1 << 24)) {
+                    /* ATN set - scan all LUNs for this target */
+                    for (int lun = 0; lun < 8; lun++) {
+                        SCSIDevice *dev = scsi_device_find(&s->bus, 0,
+                                                           idbitstonum(id),
+                                                           lun);
+                        if (dev) {
+                            device_exists = true;
+                            break;
+                        }
+                    }
+                } else {
+                    /* No ATN - check only LUN 0 */
+                    SCSIDevice *dev = scsi_device_find(&s->bus, 0,
+                                                       idbitstonum(id), 0);
+                    device_exists = dev != NULL;
+                }
+                if (!device_exists) {
                     ncr710_bad_selection(s, id);
+                    if (!(insn & (1 << 24)) && addr != 0) {
+                        s->dsp = addr;
+                    }
                     break;
                 } else {
                     /*
-- 
2.52.0


