Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4739EC54F32
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 12:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjHhs-0006PS-Ks; Wed, 28 Aug 2024 08:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHhm-0006OD-JI
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:23:18 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHhl-0001AA-7a
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=hB6ok8jCC61uJuqfFDuAoy++TNZ8tvK5rSvS1kFCYBI=; b=YUyyFCpSIlSbh2h/wPUD+TyFkt
 vjrZo9ItGM/iFQS9zDJNkEGXBMhWTTljo3zlM145ZCMRUedgH0wAgS2DsTgjJn+FmLjO1PX6Ay4BC
 SpFND1WnBc7ypVDFlQqwPBD2mde8yap+wncCrXxEcLt3M8VSRrMudA9Q7H4oSYQr2bIlskgk6SW2Z
 A/wf+pPGNianJ5jAgaSGrfzl8AhMyhD0W3kWZQ5C3R/MV8ylzfcCPNtEzx8oydLywlDb/g7+2wT72
 rTOK3ysuXorbRkc/1ecc3nI0fvij9sLzZfit0eRL4Q8NXsn/m68QmMNHMyzxnIohMRLsIl0ehPuXk
 QiuHCUbc3CrLMOJC9QKBt7d/F8Sr/tFd2ZXSyUuir0b1ppXljbtL26f5JacdG/kzl4MhYcEcSdGQV
 Ftf5K2qiiqaiW5Wdgg8LPoN6SgeYF1qmNI+XvxwBAeLbNEQkfRhzhJD4r1volB1fLAmhdFi4jpU/F
 rjZbyhRo12Y446slHPkrnqt6Im/XggQBavjPNNuwZxZdRhYtVrSB9LrETErINEhhaz4RT8pIOy9e+
 qfXo7WRZSuHsAzsmNy2L341hvYoWh/YwHx2kEXv3Yx4QF2KRovWhjGHfg9tDK4z4dVQusivKWyzlY
 tGreRrZnZBHH91USuS0gqdTrXHlLRQ1/BgjblCOKI=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHhR-000B8d-BO; Wed, 28 Aug 2024 13:23:01 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: philmd@linaro.org, Alistair.Francis@wdc.com, tavip@google.com,
 qemu-devel@nongnu.org
Date: Wed, 28 Aug 2024 13:22:50 +0100
Message-Id: <20240828122258.928947-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 1/9] fifo8: rename fifo8_peekpop_buf() to
 fifo8_peekpop_bufptr()
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

This is to emphasise that the function returns a pointer to the internal FIFO
buffer.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 util/fifo8.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/util/fifo8.c b/util/fifo8.c
index 1ffa19d900..61bce9d9a0 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -71,8 +71,8 @@ uint8_t fifo8_pop(Fifo8 *fifo)
     return ret;
 }
 
-static const uint8_t *fifo8_peekpop_buf(Fifo8 *fifo, uint32_t max,
-                                        uint32_t *numptr, bool do_pop)
+static const uint8_t *fifo8_peekpop_bufptr(Fifo8 *fifo, uint32_t max,
+                                           uint32_t *numptr, bool do_pop)
 {
     uint8_t *ret;
     uint32_t num;
@@ -94,12 +94,12 @@ static const uint8_t *fifo8_peekpop_buf(Fifo8 *fifo, uint32_t max,
 
 const uint8_t *fifo8_peek_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
 {
-    return fifo8_peekpop_buf(fifo, max, numptr, false);
+    return fifo8_peekpop_bufptr(fifo, max, numptr, false);
 }
 
 const uint8_t *fifo8_pop_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
 {
-    return fifo8_peekpop_buf(fifo, max, numptr, true);
+    return fifo8_peekpop_bufptr(fifo, max, numptr, true);
 }
 
 uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
-- 
2.39.2


