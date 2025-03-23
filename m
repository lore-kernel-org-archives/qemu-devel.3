Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A565DC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPGc-0005tP-CF; Sun, 23 Mar 2025 13:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGb-0005sd-66
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:45 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGZ-0002vc-JK
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:44 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-223a7065ff8so55787375ad.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 10:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742751462; x=1743356262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yV8UPagoDasIkYgoCkaTjilWFltLUaMj7KB+817IG98=;
 b=Tl3PuUJJnRg3U19qvXlXGVzXUcNoiI3RsMvDS94oQzDP4v1rkkDbpJ9W7lkdD0mCJq
 qWfekwmMzS4hBRVN1OXIvAHrPk+mhswf+YfnHqqhnXFKRLkioQtuTbvukeDo6pH2zw8F
 PA8aNX6KiySWi/gtWsyQQs3xUdn1TugKcV7slSRmf8/n+lhsiqc+H/bPghZPWYGaGHC9
 yB1Lt/IZ9UGFJXjBYXP/NJdzjrHgG8497dJXZuyyKUEXa2edszSt4N0+6Tp5JSbcdV6H
 hDl1b9TDMtr/JxFw+69yizr9gBzVgPlbnAltwaj43TyviUriB62f3dvhOSa3KzQFrlJT
 c4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742751462; x=1743356262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yV8UPagoDasIkYgoCkaTjilWFltLUaMj7KB+817IG98=;
 b=XWqtfwi+AIWPSq72mMqAPlkzrE1TUsIsm3MnYWhZjOK+Ds6DOuKrfesJh1zlZU/VO8
 4PMvTfnDEuoJ9Z3RY55zVXrpCbPIprlbIPhgCAXwT07wADj79y0sEuGiDDwEMtMEhMPQ
 djeDpuvj6Me9pf8KJfHI16C6er+AMS88vT3J8zZLl/413XStxwhMGODAMNGkj8oNOSzS
 fGRBWLe9llQLeD0L3zu0S3eqAK3aYGOG/y5f0QTMlENLhaLf/Jn7q0X4CIa1GQ3CYMb3
 GPLwYUvaGi/zDkFbOuibKbNAQlcd4hgvzIiC+QR7nl5337Oru6alcSfqawq2Pr9ww4qw
 0kSA==
X-Gm-Message-State: AOJu0YxcBZzCyoHcsAO3V9CPE47GpXkUARV9ee1MPbu1aD9mNEtdvoBc
 NnMftLppBNmal/Q7pWh4hcmjHwyjgfA8s/Y1EsH5C9VBzROgKkAsrfVhAIvcrG/fL154u5NQz7f
 U
X-Gm-Gg: ASbGncsuwHC8/k6c80elYmHcC+xtq4rugg/iWOPMLOrEY7W5emwgW5URGKe9PUox4Fq
 WF/JzdqX5+uBkXibxDkd52MT8UKsoOTzHl9xtgsmLL9IS1edNjcu5TsIiGjLHMfSVdD/KXfCaQ0
 WqOTyOEwmhjpnbifGc174x5sy1LpwkOlqlxHqRDxPpPYG3RjJX/AcHcxaDQOwscgVXktnv49x+j
 pVZz240RKvOlTMhOad5zM+8ZrPgZD4IcBN/sv27ZMITw3XdebOBnLeNHQ4X9ct5A+Ua/+CVyr3O
 AqnCsn3viR9OvB1KR0gv08F6fD82A3C6hCrkTzv4NDSYlcNioIW1vqXmke0C+Jxxk93CDuWAp1X
 c
X-Google-Smtp-Source: AGHT+IE9oDlQco/2y1TGo8E15QrNuI5/Mx2hOuD4VZZ3dLMJinx76SxGrg2+fqvGdftllnWFWiucxg==
X-Received: by 2002:a17:902:f642:b0:21d:3bd7:afdd with SMTP id
 d9443c01a7336-22780ba18cdmr166709665ad.0.1742751462263; 
 Sun, 23 Mar 2025 10:37:42 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22781209ff3sm54075165ad.257.2025.03.23.10.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 10:37:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH 15/17] hw/avr: Pass mcu_type to class_base_init via .class_data
Date: Sun, 23 Mar 2025 10:37:27 -0700
Message-ID: <20250323173730.3213964-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323173730.3213964-1-richard.henderson@linaro.org>
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

We want to be able to do more common work on MachineClass.
Pass the class name as a string in .class_data.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/avr/arduino.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
index 48ef478346..29cb776848 100644
--- a/hw/avr/arduino.c
+++ b/hw/avr/arduino.c
@@ -69,6 +69,13 @@ static void arduino_machine_class_init(ObjectClass *oc, void *data)
     mc->no_parallel = 1;
 }
 
+static void arduino_machine_class_base_init(ObjectClass *oc, void *data)
+{
+    ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
+
+    amc->mcu_type = data;
+}
+
 static void arduino_duemilanove_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -80,7 +87,6 @@ static void arduino_duemilanove_class_init(ObjectClass *oc, void *data)
      */
     mc->desc        = "Arduino Duemilanove (ATmega168)",
     mc->alias       = "2009";
-    amc->mcu_type   = TYPE_ATMEGA168_MCU;
     amc->xtal_hz    = 16 * 1000 * 1000;
 };
 
@@ -95,7 +101,6 @@ static void arduino_uno_class_init(ObjectClass *oc, void *data)
      */
     mc->desc        = "Arduino UNO (ATmega328P)";
     mc->alias       = "uno";
-    amc->mcu_type   = TYPE_ATMEGA328_MCU;
     amc->xtal_hz    = 16 * 1000 * 1000;
 };
 
@@ -110,7 +115,6 @@ static void arduino_mega_class_init(ObjectClass *oc, void *data)
      */
     mc->desc        = "Arduino Mega (ATmega1280)";
     mc->alias       = "mega";
-    amc->mcu_type   = TYPE_ATMEGA1280_MCU;
     amc->xtal_hz    = 16 * 1000 * 1000;
 };
 
@@ -125,7 +129,6 @@ static void arduino_mega2560_class_init(ObjectClass *oc, void *data)
      */
     mc->desc        = "Arduino Mega 2560 (ATmega2560)";
     mc->alias       = "mega2560";
-    amc->mcu_type   = TYPE_ATMEGA2560_MCU;
     amc->xtal_hz    = 16 * 1000 * 1000; /* CSTCE16M0V53-R0 */
 };
 
@@ -134,24 +137,29 @@ static const TypeInfo arduino_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("arduino-duemilanove"),
         .parent        = TYPE_ARDUINO_MACHINE,
         .class_init    = arduino_duemilanove_class_init,
+        .class_data    = (void *)TYPE_ATMEGA168_MCU,
     }, {
         .name          = MACHINE_TYPE_NAME("arduino-uno"),
         .parent        = TYPE_ARDUINO_MACHINE,
         .class_init    = arduino_uno_class_init,
+        .class_data    = (void *)TYPE_ATMEGA328_MCU,
     }, {
         .name          = MACHINE_TYPE_NAME("arduino-mega"),
         .parent        = TYPE_ARDUINO_MACHINE,
         .class_init    = arduino_mega_class_init,
+        .class_data    = (void *)TYPE_ATMEGA1280_MCU,
     }, {
         .name          = MACHINE_TYPE_NAME("arduino-mega-2560-v3"),
         .parent        = TYPE_ARDUINO_MACHINE,
         .class_init    = arduino_mega2560_class_init,
+        .class_data    = (void *)TYPE_ATMEGA2560_MCU,
     }, {
         .name           = TYPE_ARDUINO_MACHINE,
         .parent         = TYPE_MACHINE,
         .instance_size  = sizeof(ArduinoMachineState),
         .class_size     = sizeof(ArduinoMachineClass),
         .class_init     = arduino_machine_class_init,
+        .class_base_init = arduino_machine_class_base_init,
         .abstract       = true,
     }
 };
-- 
2.43.0


