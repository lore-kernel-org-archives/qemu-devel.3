Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E03DC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 21:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb5QM-00066o-8E; Fri, 16 Feb 2024 16:07:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5QL-000658-26
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:07:09 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5QI-0005LW-Uz
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u58i1+LLPuxvI3guGDd39J9e/skbnTykrkeX11/aaS4=; b=zM9CedDtpp6gLarlzLPv2/IgbF
 dfVrNfs2rufXOPeiJpNuZx70O0BzRsNLjcZ9Y2Op6VFR4E01a/GSfEc5f3sCIx52DkMoYaliCwtUo
 Xy+DkojzlhQZ2klIrJ3UY89Lm+FImp/GTpJDF/imROx9I35z+nX6WNmATSnzEbIwPQS96lCyelM8/
 9ONrZSQZ0lXiOysXea/7yZCIMj6+9e91nqBGMOo+X6JKQHMspR3ppKQqiSvcbOvGtH27igzDKlQyX
 lRsT4nafYmICgneXvqzCV+lYXZGoAmDhirD6D9Ds43NxEBu0BCs0QsqV85S8ZNfrzRze2BPbtcXVr
 01slea9afQ8Vji1C4alCI38zNfVNuYJ3qmiEdS4p//qFoHbcMigfqdlb8YZKsogDwK8ARSi9HF/EX
 O/8QRv/KfioUU7NVISKCTtHBHrYWoTP6kAKZXbjcfnHyvqnvt2g5HNE2lDtPAEkMan77ongkLqvj1
 6OYx5rE94KRy1N5OoE4GLD1p6vSzUUKi1vOr47oZbKXixCdn+2meqD++uYn8q0EiMxq+VqVHnLIVo
 +YVjcCTksaK9KcfS/rBRM1n1cK0PwOMwn1vuSLp4rWnPkIRkldaDENISDAQAGrfsGw87bOr/mvth5
 Pm6WhfWc6iVVNmUykdmGEbbPSPW394bpj5gBzeQcs=;
Received: from [2a00:23c4:8bb2:1300:b76e:9764:d1ca:4e3f]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5PU-0000vT-T3; Fri, 16 Feb 2024 21:06:20 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Fri, 16 Feb 2024 21:06:24 +0000
Message-Id: <20240216210633.1376066-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216210633.1376066-1-mark.cave-ayland@ilande.co.uk>
References: <20240216210633.1376066-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:b76e:9764:d1ca:4e3f
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 04/13] esp.c: change esp_fifo_push() to take ESPState
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

Now that all users of esp_fifo_push() operate on the main FIFO there is no need
to pass the FIFO explicitly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 7a24515bb9..b898e43e2b 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -106,14 +106,14 @@ void esp_request_cancelled(SCSIRequest *req)
     }
 }
 
-static void esp_fifo_push(Fifo8 *fifo, uint8_t val)
+static void esp_fifo_push(ESPState *s, uint8_t val)
 {
-    if (fifo8_num_used(fifo) == fifo->capacity) {
+    if (fifo8_num_used(&s->fifo) == s->fifo.capacity) {
         trace_esp_error_fifo_overrun();
         return;
     }
 
-    fifo8_push(fifo, val);
+    fifo8_push(&s->fifo, val);
 }
 
 static uint8_t esp_fifo_pop(Fifo8 *fifo)
@@ -224,7 +224,7 @@ static void esp_pdma_write(ESPState *s, uint8_t val)
         return;
     }
 
-    esp_fifo_push(&s->fifo, val);
+    esp_fifo_push(s, val);
 
     dmalen--;
     esp_set_tc(s, dmalen);
@@ -1240,7 +1240,7 @@ void esp_reg_write(ESPState *s, uint32_t saddr, uint64_t val)
         break;
     case ESP_FIFO:
         if (!fifo8_is_full(&s->fifo)) {
-            esp_fifo_push(&s->fifo, val);
+            esp_fifo_push(s, val);
         }
         esp_do_nodma(s);
         break;
-- 
2.39.2


