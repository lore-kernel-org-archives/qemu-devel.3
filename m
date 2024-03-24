Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC536C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 19:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roTMe-0000Tu-3G; Sun, 24 Mar 2024 15:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTMa-0000Jz-T1
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:18:36 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTMZ-0005O2-EQ
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t2ivluwEzP4cw/9li9sCgRZcBnQJzg/KNGDrncbzT60=; b=SROTWrY00FyJZsh4iMn2HoLQYq
 RbluxDvxjhdOf///JOMHDcZBL7nVRy1RWKklGjw6q88mzFHGqajyvb7Z3/Ma3aCwPBXsitVjAO9M0
 aJhFrmcVJnYNH9uijln/q4wPBJ2I6P/OAlRdwrpeFw3TsFlimo5TGpqjJg7Ls/QADjDTL4d6I74Dj
 sbVwpMC0lUPv9l/9BK3q+1uRXt4NCcd7HRfDsnTOj/21lZcND0B1R0avsdYcnQFDGc2P8ZkpQoQaj
 oVwcekPMjx31BrSNcNUGLlXEwclAyCGz/YtZ7L2NT8LgOOMm02jxtOkhvnpVzCn2LNKrVUMyNSSU4
 Y+WSPz2tpCiu7w8Wk+jZZAoLTmkorIlUUuUvrL+7BBgXQNl15wwxRQzFVMsSWjpp/wVaHeKRF2c1R
 WWGpi/Sjyes0Vq5hv2UDjidn9UxtFvVE4wlsR+V+qc4Aj/acdI/kIxmbCvDz70W1BnB8CtP4Kcoez
 LGMaLRMdPyiAPnmiF8hIcWBRpEbUWz8n7kJoJO6AYoaW/Hlb4MccGH8YV5nTYw8/om/TmxGrPK8yf
 vjWdTyJqYTgk45ohCTGPAJuY2PUH9PQzT29W+dziuQZIxMZ5eRzo1MLz4TNd2dVrfO2McUtmlk+r4
 sfuaXwjtvMVqpQjRNZAKZ7qTijYV306a1abLwoa88=;
Received: from [2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLQ-0000dj-3z; Sun, 24 Mar 2024 19:17:28 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Sun, 24 Mar 2024 19:17:05 +0000
Message-Id: <20240324191707.623175-17-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 16/17] esp.c: ensure esp_pdma_write() always calls
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

This ensures that esp_update_drq() is called via esp_fifo_push() whenever the
host uses PDMA to transfer data to a SCSI device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/esp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 4895181ec1..04dfd90090 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -282,14 +282,12 @@ static void esp_pdma_write(ESPState *s, uint8_t val)
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


