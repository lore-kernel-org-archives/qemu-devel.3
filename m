Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F99DC36005
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPGe-0005uZ-GM; Sun, 23 Mar 2025 13:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGb-0005tE-UN
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:46 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGa-0002vr-FQ
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:45 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22398e09e39so70809985ad.3
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 10:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742751463; x=1743356263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3YwrBfdlhs0bOKiaJCFIoQFWS0HOXf48uYuIIHVmYZU=;
 b=e/VPuBzoxb+UjFwMs1qYY0FGYXzFQZB1geC6H9rHkjlaNFneSxKIMhozkPyneoNICo
 mYWYgyIBw2JIGV+jjRrKp6SDl4jxBPsx2D7J7UtA8hlCz/XmCiV0wCo5q+q/GClY+HUS
 v8DwcmeN0gSdu8XYSZjYZjtmZ3M/uion1+eUWqfqE/S2be2BKRfQS/yGm3rsd8wxBEyO
 akqzYIGQsK8XfvDXrpJfaxZkmyHJ4oOdvZcmUsnqfJFojANOl6OiUVPUrsOd8S/M/Mb5
 8BF9f6hc6NJOIvUJTEVVaAO1USsWw5N13tIf9zHX+CFylF5CLTOQ70PLy7VpSXV98gfk
 /kIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742751463; x=1743356263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3YwrBfdlhs0bOKiaJCFIoQFWS0HOXf48uYuIIHVmYZU=;
 b=FFEwXaQSZulz4Pf1kl+fCrDILH7t4sn029rbU3QGq1rSGA1ROTRf1xpP5HP52FdDX0
 dSq6ndx88WglybKvZ6LgVSupBSzer+Ir1b4dWG/hAzwNOupJ9Ig75rfPVGwfAR9mCeIM
 Rdr4iCzxMtIXaR+qQ5U+lPrxyCRduacZAuIS/FZeQMDiHqVbfP5b5btb7RM/g42Czvjh
 mNHfjGmI4/rz9msrPnmOsC8i/CA2VEgwJsP6pywGgmU9tMV52vhRZMGa3Z2EMm1k4wOr
 Jq3P5qnGuH4lbdpStjpDhea66Ne+aGr5jF4Bwm31UoTZn4vfhbwkxGHXbClIeyUtFRJO
 OUvw==
X-Gm-Message-State: AOJu0YwRfomXQCa/ecYktiNRggXqRUW53DvjF9kRHFofvMyzLc+TRkn2
 d2DCa4YZ+1aC3lvCx06n0x3V2x55VvCZ553RSTGZbrzKMtmft+9UFz+wnrXHtfNzBpfpGrg+iov
 I
X-Gm-Gg: ASbGncuqfTD1dzLrXLDDcEqfVw/dPs4irmNg7Ik12VMbg+YxxQRsODWGqHf8P4+J9SC
 dqmm625ZE+RQd/VYjTKfvldTVRYucIN8wd0GpFC8afOUe9Hl04qO8HN2LhG6ZsuDXUDKh4wl+1T
 V6hfmdBXVLaUzVsLanuo7IT48gYq0d4mW9pax7/DXaNVPpX+H9QTxXodkU/6a4OFsDzR0qGan2V
 VjkxbJac3xwiQg2GMl4jaX9KVXpSE5rRlpgCVSHOrgL9ITVVlZg34ef/6Cq445i0A3AU+IGbsOv
 wvdII8UQWjpjDXpc+ETGpsBsOL/iFHxFCghg2U+yVzfOfOJz6y5aCC41DVE5h+u24Q/fOu36cab
 3
X-Google-Smtp-Source: AGHT+IE3LQU+yoQQmB6CpDVl/ZEpqmAOalsnE1/3HPyLTd8o9Org15gCW/f4UA6JkyuFQs8uyNoSsg==
X-Received: by 2002:a17:902:dad2:b0:223:2361:e855 with SMTP id
 d9443c01a7336-22780e17b3amr161552435ad.39.1742751463093; 
 Sun, 23 Mar 2025 10:37:43 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22781209ff3sm54075165ad.257.2025.03.23.10.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 10:37:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH 16/17] hw/avr: Move AtmegaMcuClass to atmega.h
Date: Sun, 23 Mar 2025 10:37:28 -0700
Message-ID: <20250323173730.3213964-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323173730.3213964-1-richard.henderson@linaro.org>
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/avr/atmega.h | 20 ++++++++++++++++++++
 hw/avr/atmega.c | 22 +---------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h
index a99ee15c7e..f031e6c10a 100644
--- a/hw/avr/atmega.h
+++ b/hw/avr/atmega.h
@@ -23,6 +23,10 @@
 #define TYPE_ATMEGA1280_MCU "ATmega1280"
 #define TYPE_ATMEGA2560_MCU "ATmega2560"
 
+typedef struct AtmegaMcuClass AtmegaMcuClass;
+DECLARE_CLASS_CHECKERS(AtmegaMcuClass, ATMEGA_MCU,
+                       TYPE_ATMEGA_MCU)
+
 typedef struct AtmegaMcuState AtmegaMcuState;
 DECLARE_INSTANCE_CHECKER(AtmegaMcuState, ATMEGA_MCU,
                          TYPE_ATMEGA_MCU)
@@ -32,6 +36,22 @@ DECLARE_INSTANCE_CHECKER(AtmegaMcuState, ATMEGA_MCU,
 #define TIMER_MAX 6
 #define GPIO_MAX 12
 
+struct AtmegaMcuClass {
+    /*< private >*/
+    SysBusDeviceClass parent_class;
+    /*< public >*/
+    const char *uc_name;
+    const char *cpu_type;
+    size_t flash_size;
+    size_t eeprom_size;
+    size_t sram_size;
+    size_t io_size;
+    size_t gpio_count;
+    size_t adc_count;
+    const uint8_t *irq;
+    const struct peripheral_cfg *dev;
+};
+
 struct AtmegaMcuState {
     /*< private >*/
     SysBusDevice parent_obj;
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index d4fc9c4aee..96e36743bc 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -36,7 +36,7 @@ enum AtmegaPeripheral {
 #define TIMER(n)    (n + TIMER0)
 #define POWER(n)    (n + POWER0)
 
-typedef struct {
+typedef struct peripheral_cfg {
     uint16_t addr;
     enum AtmegaPeripheral power_index;
     uint8_t power_bit;
@@ -46,26 +46,6 @@ typedef struct {
     bool is_timer16;
 } peripheral_cfg;
 
-struct AtmegaMcuClass {
-    /*< private >*/
-    SysBusDeviceClass parent_class;
-    /*< public >*/
-    const char *uc_name;
-    const char *cpu_type;
-    size_t flash_size;
-    size_t eeprom_size;
-    size_t sram_size;
-    size_t io_size;
-    size_t gpio_count;
-    size_t adc_count;
-    const uint8_t *irq;
-    const peripheral_cfg *dev;
-};
-typedef struct AtmegaMcuClass AtmegaMcuClass;
-
-DECLARE_CLASS_CHECKERS(AtmegaMcuClass, ATMEGA_MCU,
-                       TYPE_ATMEGA_MCU)
-
 static const peripheral_cfg dev168_328[PERIFMAX] = {
     [USART0]        = {  0xc0, POWER0, 1 },
     [TIMER2]        = {  0xb0, POWER0, 6, 0x70, 0x37, false },
-- 
2.43.0


