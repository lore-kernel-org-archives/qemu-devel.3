Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B104C48BF3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 21:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb5Qq-0006Ok-KJ; Fri, 16 Feb 2024 16:07:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5Qn-0006Eg-2A
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:07:37 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5Qd-0005QA-05
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uvd6nXwhTYTsEf+BMYvVSp2xRCX7/yZoN//4EaZsgTM=; b=iOD8e87U9cKfkYr/gHE7xhFMPQ
 qi6bhM7rgeXLaV+6n5xOspvoxX5z5XETi7ZpY553UbjLptPhFwB0wsw83LpaIEiVe7FImsb+1BOrN
 Br8Hp5Y1BVYHroTJ28DlDJuYojgECg1pO3zzE2ZjrDx5tuSgQeRwu1Zd4YgDhEV5BBisxoh0JtHbU
 LqJCMJxZE75HNx85oq4d6Iz97pdaPWjQsiz7UniXcnKDLCIIiGxUaA4JxyZPbPwY+Lz/7guTyGkG1
 Tdre+bQwH2CQo+sO1SNTwoIwueWhVm5SBop+MWk5fmwVa/zxEBTzNnZJynnd3d4QN+LsXXvoOsH/7
 PMwkMGR/t4oECkYOkrKwfFsDFBBHDRg4R+V5QetYbX1+BhdjPg43OaNpMA0SZH+kpLg/7PINpW9qP
 DrGQLOztIQRhI/Y7v+SpcY8l6NQXNBOHMQMCZ7Uw0z0+Z+7LA29DZWBypwQeOFk4lcdhf1EjeUWcS
 WT9IY9uPKkkodsy0uwuMOQmee69lq9krwY7DLw3YB/3U/cmbVZNkUPsAYZ9wate99ZasidKvNeCpT
 8gKvhecQWI871HRL9aH/dPHCOFOQF5QzZ6USyus5qO4255sRIplEOrIH1/XSu42gvDTjKvCW7khjz
 5NrvJEepKHvG8XYjCy7HicJ9iLjVQuO2pxp99j6Tc=;
Received: from [2a00:23c4:8bb2:1300:b76e:9764:d1ca:4e3f]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5Pr-0000vT-3v; Fri, 16 Feb 2024 21:06:43 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Fri, 16 Feb 2024 21:06:32 +0000
Message-Id: <20240216210633.1376066-13-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216210633.1376066-1-mark.cave-ayland@ilande.co.uk>
References: <20240216210633.1376066-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:b76e:9764:d1ca:4e3f
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 12/13] esp.c: ensure esp_pdma_write() always calls
 esp_fifo_push()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This ensures that esp_update_drq() is called via esp_fifo_push() whenever the
host uses PDMA to transfer data to a SCSI device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 2150cd457b..a147509885 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -276,14 +276,12 @@ static void esp_pdma_write(ESPState *s, uint8_t val)
 {
     uint32_t dmalen = esp_get_tc(s);
 
-    if (dmalen == 0) {
-        return;
-    }
-
     esp_fifo_push(s, val);
 
-    dmalen--;
-    esp_set_tc(s, dmalen);
+    if (dmalen && s->drq_state) {
+        dmalen--;
+        esp_set_tc(s, dmalen);
+    }
 }
 
 static int esp_select(ESPState *s)
-- 
2.39.2


