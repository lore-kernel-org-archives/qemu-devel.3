Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C74C3DA42
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2024 22:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSlSL-0006lq-H6; Sat, 13 Jul 2024 18:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sSlSJ-0006kU-0o
 for qemu-devel@nongnu.org; Sat, 13 Jul 2024 18:43:03 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sSlSH-0006nd-C1
 for qemu-devel@nongnu.org; Sat, 13 Jul 2024 18:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=Cpa8qJudHsTSWsZv6cMwLiWU9CQw9vUQkcWj+M1oYoA=; b=EyVWzrzERtDNruiYY0XxjN5rYK
 BnmLOPCvcR1cYSiGL/MzWfI4dd48NTy22iq8CuHpQeJSqA2pVKA8e0nwGVVV+N1x3rqDs2VQtXKE/
 O0vRcgo6jFVQ5dqO51LRgli3iOKQuID/6UcD/hOceBSQkL0e02TepZzTVa/st1VbX0W7Wzh6uk0nU
 Aa2Wh9qxYkk0QCfmhd+zOa1ZHQbLZ/dV54rzL7F2JQiirE81/M81/V+y33u+mflGRjmX33lbhkSnC
 PSUECUzxc5gLc4QFWTfFz/ny7YqKbb9ByutX/U6Qtktk76ehPJL5VSuQbQVm7Zz3MVXFzfXP6WdE/
 YOkPdw+Oruku9nY5Yy4G+zhdocUlC/2yCai5ZHWXYKlBCTYSwRKo4F0PINX40kYf9QFFpBy20BTdI
 zYU3z1ey0plCQRpzGRV9PFuTtSovwJkKAZaOky66TfVbNhDuqgqcFSR/24i83PLRtiwj99+4fPILe
 TEtoCmt6yBfDXcgiirl/8c5QdiBaNjEfSH/2PaUJVWXdSmn0ISxjws8Gj6T8FGs08CxbLUHAQExkX
 YmTldYkW2wvKDlZKAsUSxTn/BydWgh/qvSA3Zcs3hj3GzqnmqJmxbmyiV001aIQSX10tT3hLAVmcs
 0MXVD6dV8FxqBSIka25FJmI/K3XX1unl5JiLioEgM=;
Received: from [2a00:23c4:8bb4:4000:dd76:681a:1698:b27a]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sSlQj-000AL0-BI; Sat, 13 Jul 2024 23:41:29 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	pbonzini@redhat.com,
	fam@euphon.net
Date: Sat, 13 Jul 2024 23:42:49 +0100
Message-Id: <20240713224249.468084-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:dd76:681a:1698:b27a
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] esp.c: remove transfer size check from DMA DATA IN and DATA
 OUT transfers
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The transfer size check was originally added to prevent consecutive DMA TI
commands from causing an assert() due to an existing SCSI request being in
progress, but since the last set of updates this is no longer required.

Remove the transfer size check from DMA DATA IN and DATA OUT transfers so
that issuing a DMA TI command when there is no data left to transfer does
not cause an assert() due to an existing SCSI request being in progress.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2415
---
 hw/scsi/esp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 5d9b52632e..8504dd30a0 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -594,7 +594,7 @@ static void esp_do_dma(ESPState *s)
         if (!s->current_req) {
             return;
         }
-        if (s->async_len == 0 && esp_get_tc(s) && s->ti_size) {
+        if (s->async_len == 0 && esp_get_tc(s)) {
             /* Defer until data is available.  */
             return;
         }
@@ -647,7 +647,7 @@ static void esp_do_dma(ESPState *s)
         if (!s->current_req) {
             return;
         }
-        if (s->async_len == 0 && esp_get_tc(s) && s->ti_size) {
+        if (s->async_len == 0 && esp_get_tc(s)) {
             /* Defer until data is available.  */
             return;
         }
-- 
2.39.2


