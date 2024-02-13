Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F21EC4829F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZz0G-00043P-Po; Tue, 13 Feb 2024 15:03:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyyW-0002Hq-C1
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:01:53 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyyR-0001uz-IC
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u/8TH5HgQOszsQHe2cvReXCj23ynFx2AMdVoG5FQJ3c=; b=uX+0cBmw3HPNs219Ee6KosNZ0L
 UXa0fHd415Fg1w18V3qCznwZp2ylQiUuSYw83y5QP4LNSfJOCdomUw1f+kmFtiHiJqJxQlOh5e58Q
 HBi+mCisdoBb0hn7crp1lME8DosAhE+15c/US71kdv18imvE7Hu1fpUfB+G5MfnER85pilbF08i69
 8KTdZC1euH2TKo92zNcQ2Atumw6ZVYZlacu9SLg1TkNdmP/lKmsUIaHVs44H5mlxy7gIdk+Pbd5mA
 eKUtrF1QWqQbUuf+9QNR3vBHYq2Tg/q64PPIoi/vWlSutLcoubFb5rYzQJOQxQqcOXGp9ajlcd8WK
 23Dl837qvPrYlylrcCkRdwhgxP3gSszYAYEDmQ1NiVL16uHElH0+7AGy5msirrZr9Oor1TD0mkQ/d
 o0t/FmL4OcpJMITSZPG8yrZ6/mgUQARv6h27aZpDKpQVLweBIKuhjOAYLRSvC01t0AdaR3zriSkXo
 jdHG35g0hlLr3QlwuJK72OXhadY9WbJ4wT+AQh3KaOQ3iYbUqcAAwKZ+IEYEK8BwPs2VkubZVPWTi
 pLf/XB65rqMDGjlqCVoGwVGTeTqrY1nhJq3cndVPPdny53aEYtoZGYiFC3qbplaLHBLRnitzHfI2e
 Et0Hl8+tuUtdCTW6v2q1o/Kr2Xjk1CAbGcRS9+Qyg=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyhW-0008m4-DO; Tue, 13 Feb 2024 19:44:21 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:38 +0000
Message-Id: <20240213194052.1162753-75-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 74/88] esp.c: handle non-DMA FIFO writes used to terminate DMA
 commands
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Certain versions of MacOS send the first 5 bytes of the CDB using DMA and then
send the last byte of the CDB by writing to the FIFO. Update the non-DMA state
machine to detect the end of the CDB and execute the SCSI command using similar
logic as that which already exists for transferring the remainder of the CDB
using the ESP TI command.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-75-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index f9d848171f..aa7dec71e3 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -787,6 +787,16 @@ static void esp_do_nodma(ESPState *s)
             }
             break;
 
+        case CMD_SEL | CMD_DMA:
+        case CMD_SELATN | CMD_DMA:
+            /* Handle when DMA transfer is terminated by non-DMA FIFO write */
+            if (esp_cdb_length(s) && esp_cdb_length(s) ==
+                fifo8_num_used(&s->cmdfifo) - s->cmdfifo_cdb_offset) {
+                    /* Command has been received */
+                    do_cmd(s);
+            }
+            break;
+
         case CMD_SEL:
         case CMD_SELATN:
             /* FIFO already contain entire CDB */
-- 
2.39.2


