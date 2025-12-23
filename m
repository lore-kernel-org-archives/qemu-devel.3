Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00C6E6FE21
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 15:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY4fU-0000PD-JY; Tue, 23 Dec 2025 10:51:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vY4fC-00008Q-O2
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:51:08 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vY4fB-0005UD-8S
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:51:06 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A886D40DD0;
 Tue, 23 Dec 2025 15:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD523C113D0;
 Tue, 23 Dec 2025 15:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766505061;
 bh=CSOduKJZsEP2Kp7t2StaP9LitgZ64zGhAlx63dao0n0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kfu3Cuyz1BkI3bkgrz1MpnzmaJpXUEEdq3wp6ERpeBeUhvhSIYSmsz57FjKoUeMgx
 3ndfd/uWM6m459Yll/fATQqeE16bMGZja2sQLCrqo/EywDrAP6mtzbiBubjL4jOR9S
 74DNf4GZrJXyj25jRfUPVsuarQ7B/b8KQ3WBhwSzbSdqA/TmmqVpP4cORTVAyjQ6PJ
 0DmubIAoJgjiktn5BSfsh0DhBR/j1xoml0Fz/vVuIIq55FsEapXv4BQb2rKWE1eHom
 OVbWkQ2h/pitBaXkZUrfkOWuf+jBQ/61lrvbKiaccVZvssLvk++FWZlrFbmBUhqE8e
 LfU0gp1Q8rfyg==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fam Zheng <fam@euphon.net>
Subject: [PULL 11/12] scsi: ncr710: Fix CTEST FIFO status
Date: Tue, 23 Dec 2025 16:50:30 +0100
Message-ID: <20251223155031.7110-12-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223155031.7110-1-deller@kernel.org>
References: <20251223155031.7110-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
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

Update CTEST1 FIFO status when CTEST8 is written, setting to 0xFF when
FIFO is flushed, otherwise clear to 0x00.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Tested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/ncr53c710.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 0ea1fc43a3..cdc365478c 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -2161,7 +2161,11 @@ static void ncr710_reg_writeb(NCR710State *s, int offset, uint8_t val)
         if (val & 0x04) {
             ncr710_scsi_fifo_init(&s->scsi_fifo);
             s->dstat |= NCR710_DSTAT_DFE;
+            s->ctest1 = 0xFF;
+        } else if (s->ctest8 & 0x04) {
+            s->ctest1 = 0x00;
         }
+        s->ctest8 = val;
         break;
     case NCR710_LCRC_REG: /* LCRC */
         s->lcrc = val;
-- 
2.52.0


