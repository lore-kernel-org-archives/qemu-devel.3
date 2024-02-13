Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3394C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyfp-0004nb-2H; Tue, 13 Feb 2024 14:42:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfY-0003lo-Vb
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:18 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfU-0006LF-N9
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SiPqZDoxN/9au4TtZYiE2hyFQvJj4ZHJhzc5lZsATWs=; b=eXPXS7sQMPFZJGLKn4eThDtCTN
 KKVkH5rCv9OHV9X5TTMeTwLFn4C03QI9yAlEPiCi9eKF9oUZZt1dv4/YdKGEGwoQBFAkWJ/FN4tWA
 ElPmHJv8bKiLsCBU2QVIPDl8wE+VZ8uKeb60NkeCNhGLB4297LwRfMlcDRc/z2jQ81bBfcacqgTXG
 N9Jy0Gf7+eO/Ux9jwb3T5JpaAPq8vPu8qJgVZWafNbwiAAw6jIIW8xa5vNu1Rb6dyTd2fQNpXJh4G
 RQqEFA8DBn4jgml6BKa/ZUC9bfn406cpwNCIjfxZg54Asw9YB4vd2rpev+6Ge4/SZNS2LR9I2pAZ7
 70eBnp7Wl1QnsZZRIZKLsNvEweBynTyaJK5TzEoM+ioYuMxuXvJBLFGVsJaM9C1DZe1Lo3cTs7Sgg
 9QVQ3s5JhZU3r5O0ScHFsZKq3NPU/OJprDXTjwnOVoI4schpj1Ykn3gGTQa22625D6Z8YmVSKQoxv
 oohC6+GPCXCpw5XL6ThWdi95FWW+njRNV4grHYCfPB/tr4n6E7T++8r8eQK64k+M0ueeBk3PNQzfM
 OFFzMdR73RAyHi5kLRYhD0YznxXVClS0JBppxSQKoBhLVfKeDIV3mQQ3VNdV/HA1jfOKZ2V2LbBNs
 0y97J3AhMqnHvt57LpJM0hbwk4LyCYGf/z3wELZqM=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyec-0008m4-G3; Tue, 13 Feb 2024 19:41:21 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:41 +0000
Message-Id: <20240213194052.1162753-18-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 17/88] esp.c: don't reset the TC and ESP_RSEQ state when
 executing a SCSI command
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

There is no need to manually reset these values as the ESP emulation now
correctly handles them within its existing logic.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-18-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index f41b2421f9..a4a1f41a40 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -319,10 +319,7 @@ static void do_command_phase(ESPState *s)
     s->ti_size = datalen;
     fifo8_reset(&s->cmdfifo);
     if (datalen != 0) {
-        s->rregs[ESP_RSTAT] = STAT_TC;
-        s->rregs[ESP_RSEQ] = SEQ_CD;
         s->ti_cmd = 0;
-        esp_set_tc(s, 0);
         if (datalen > 0) {
             /*
              * Switch to DATA IN phase but wait until initial data xfer is
-- 
2.39.2


