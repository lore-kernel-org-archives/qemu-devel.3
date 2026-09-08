Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3EDC79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 19:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x41D3-0005Dn-TW; Tue, 08 Sep 2026 15:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x41D2-0005BM-P1
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 15:10:20 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x41D1-0007sr-4s
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 15:10:20 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4956869750eso44754375e9.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 12:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788894617; x=1789499417; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ILDFocp8XbkildFlNZGYgLM/xTHm0Yrbe5s7uDVZwlA=;
 b=JnccAVtDYn5urMQF7Am6ItnXpm8Ij4ntLagulrhU8igknx5KOs10jbdyCIoIOSeee3
 34pw/ejbd6+iW6omLBaKGyCcvqSYZMTPZt1iNdKjgQpJFrOGTV0kp2rlLMRfJQdNOyTz
 EtPZhUYK0LiLldM4zP/P6CpP/7JlqboHJW32DVLrXPyc3q+WduNfhjD8KgSybxHwRTsb
 /nKMrvgVYU2nd/SBWT/4HU2R7Vts/Hoj+XHJkObQxuvp793gm41sDfvlnb/dBZ9N4NMj
 gmcBo3piDMeZERHiTKMhePSL9Er7WMCDB0QizHLsD8QgMapea+iFfXeay7Ow0USrB4G5
 v4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788894617; x=1789499417;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ILDFocp8XbkildFlNZGYgLM/xTHm0Yrbe5s7uDVZwlA=;
 b=CzzxN7kss9sV1itVHO3hGIpy3Cl9X6O/M/872gxEkV446BdLWaRNARnuizrvuy7Cnc
 iMVB7766PvPDRBnUioTcVrB+5DtO0Jyvsx1CqNnKYvoPqKesigU20/h2eHN1w7Qq4VW/
 acnvU2fFxAbExLF+/yJVDQge9PWELCXENSgZwRriJNw9HRkdNTS2b1Ed8UNzjHG/LguO
 /MHi0sLqUXek3ue7TpCrTkD4REkr0hOMhjgfCmZEXup5CjVpBVyxD+CSyeIEZ8qGD1wV
 jCzLaMsBSA8C7MybyPZQcWJyk2/vAj4WGzIDsDAoIsgqF75K5bFGxWF2iwimM+WipOEr
 iDKw==
X-Gm-Message-State: AFuF++kDmjdSqL+vbS/om6isDQEUP5I2exJkF+pD6/pTt52ExD180RE1
 7d2203BmlRo9koXHebt5540H7fqBsNCCLJIYm/R3eeg+080Er7yTrUChq7STk4TQBaU=
X-Gm-Gg: AYBFou3A9cQRhQnrKKkablDwGtGFF0JJQ25jcCk/4InV7wlzWH9sPZsUFGHN45OSYHs
 LB2pWRXhRTv5P8Tz5isBLlL5urms6wU6AFFwzaA9oTkWiiScH94NhfPvujOmLVT/5U2rYi/5Qev
 JSlmMeSpbi6kpOY6DCi2xy71TQezq82VKVA3bPtZrE5jFPEN8V6FPQCBb4o4r2YV8ZczBqR2ASq
 iGo06EHBvfqfsksCb+jKTOKEmNlE2ThzNfD8440KBSbSmpHG+g2AfepyLced2WaDVcpd7PwCN62
 23QQ6I2TmQxx6CzccSxfk00W87cAPdw1xlY3uBPNUQvvK+C5QvFXtGQskaa9bHfiaSjbvT21mr1
 +WNCh5JLmNqlRh0xnwz53l5ZbiJJNPkj1YMA8hTTN2bKYEi3nIVcu/nRayNY0ghbj98nOtbmlZx
 i6aQe9zo54EQe4Ts5oAnTHoF5s97N9GfMRVZIFzp52Mzk8q1qNGvnjfBQu8veOlA==
X-Received: by 2002:a05:600c:4713:b0:49c:fa20:cc00 with SMTP id
 5b1f17b1804b1-49cfa20cd4dmr294834545e9.23.1788894617082; 
 Tue, 08 Sep 2026 12:10:17 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5f912esm512831255e9.4.2026.09.08.12.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 12:10:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A58935F845;
 Tue, 08 Sep 2026 20:10:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-arm@nongnu.org (open list:STM32F205)
Subject: [PATCH] hw/adc: add default vref and defend against DIV0 for npcm7xx
Date: Tue,  8 Sep 2026 20:10:11 +0100
Message-ID: <20260908191011.4089504-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Googling seems to imply vref is usually expected to be somewhere
between 1.6V and 2.5V. For lack of any better idea default it to the
internal reference voltage. While at it guard against div0 which in
the real world is likely going to saturate the result.

Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/550
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/adc/npcm7xx_adc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/adc/npcm7xx_adc.c b/hw/adc/npcm7xx_adc.c
index 3584c27c75a..54d3cfaa813 100644
--- a/hw/adc/npcm7xx_adc.c
+++ b/hw/adc/npcm7xx_adc.c
@@ -57,11 +57,14 @@ static uint32_t npcm7xx_adc_convert(uint32_t input, uint32_t ref)
 {
     uint32_t result;
 
-    result = input * (NPCM7XX_ADC_MAX_RESULT + 1) / ref;
-    if (result > NPCM7XX_ADC_MAX_RESULT) {
+    if (ref) {
+        result = input * (NPCM7XX_ADC_MAX_RESULT + 1) / ref;
+        if (result > NPCM7XX_ADC_MAX_RESULT) {
+            result = NPCM7XX_ADC_MAX_RESULT;
+        }
+    } else {
         result = NPCM7XX_ADC_MAX_RESULT;
     }
-
     return result;
 }
 
@@ -244,6 +247,7 @@ static void npcm7xx_adc_init(Object *obj)
         object_property_add_uint32_ptr(obj, "adci[*]",
                 &s->adci[i], OBJ_PROP_FLAG_READWRITE);
     }
+    s->vref = NPCM7XX_ADC_DEFAULT_IREF;
     object_property_add_uint32_ptr(obj, "vref",
             &s->vref, OBJ_PROP_FLAG_WRITE);
     npcm7xx_adc_calibrate(s);
-- 
2.47.3


