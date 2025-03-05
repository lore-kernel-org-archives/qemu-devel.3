Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52F5C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tprMm-00037u-HO; Wed, 05 Mar 2025 11:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tprMl-00037c-5I
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:13:03 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tprMj-0007aE-Gs
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:13:02 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43bcc85ba13so17092335e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741191179; x=1741795979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=orvtcKfihVUFCViVDE72hkVKr7ZPDEWfYMWfWKQWuPY=;
 b=ja5xZk/2aA57HeG2bu1heOs6gjoh9rd6PMPqAsWADnDrkTY6L1ImC+icBwNKCNecTf
 0cj0B1Mj1FhdaOSsCuu0qzYNUweALUFtJh5EgufzOjIXNU/3K1b3rc5JaImpJ9Bi/Yzr
 Qjv4JFhLdSsVxuZDX2bDyLqBLM0gsQRreZFzt+vBlAyrl3HqFSnif3cbSg/zqYZL82Fl
 Z/1h/9L8dk+0E2p9BxYgP6jOq3xHNcksukj9uGPzGUcjeOhYhdZc6vlXXA+OKRW/8l6V
 /6/8TaR86Q10TbMerrk35Hz3ByiBDqa4xvF76Ival/ULKuxLgWXz/ZAYeID/bNmQHd4M
 MY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741191179; x=1741795979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=orvtcKfihVUFCViVDE72hkVKr7ZPDEWfYMWfWKQWuPY=;
 b=tCebPA11YmOydwYQG22zeFc+ALYI4OexfAhJIWzX+P6u/+IjhonngMOnsyiTekxx+g
 YhTzwNJifySPgSJjahRL/+84pnqCPPqnQeBmKHVxQR2cXpR+B1XoHBeTJLjQTMMYn7xh
 6lxgwgTZPWhhUVGFAS+STW9vQpXW7EOUWD+EdCHIrkzn3wzzcC9oXoNV7umTA/16QaDT
 mkjCLVaPbTVkg2/6AsO0PipsRKLRUcnHU6PQA+sXibHo0XDaZANsvDqPkY5qQvzEhDqE
 oaadY429R/FBPdnJOgqtUIEpHonfSNYKeENpixdK6rx3oCy+LFF6EYUZ67K+W6S6q4Bl
 lNvQ==
X-Gm-Message-State: AOJu0Yz/WiHPI/oHTolv77iCfamTK7kQRyoGVDT4dxndXYNdZ0YKF6vE
 wSfOFfNN5IFxyuhLH9umRLcuPb0f1H5MjJIRKuy8CWqck7269gOnb3UDbxisJlQ/cvS4Y9rd2yl
 wZH8=
X-Gm-Gg: ASbGncuVm7pSXWtmC7EJIhvU+nScGGfXCPVMoED19V8TLVCsqA1xIegfJOzyYWdz7ue
 lF5TsEtakxr6U7juqNCIS/6ASxsRbckiu6+7cNSNZM13v7AuzdeIWTbUjdLgNs3cVX4sf5G6YMN
 MePgyDmR4MYwaAD+nGhbWPKTI//pyZ4Zd8hHUMWSYgH4ip8nPu7EWeb/rVUCHMjCkFQPBMGM6vE
 iixauI0VYuBsOow1MWmq8uLV+JoWBMNRXM37wVPWPAgtm7SssTHjvHhmhWVpCOvlS9jvL3Gc+YY
 CuaVvHeRieYfohwoC0OHjZADMMpeQjlNwo3EmUj/7fKgTZrFLU1XxWtY5BI+nbKASTmT38kBA0X
 zm3oY2YHQcOeOIzvUydo=
X-Google-Smtp-Source: AGHT+IHdItuvKX+lQ1X4oGvok1OXlpr6c8Tv3ERZvjrwMhvQRnaiHtRHrPNICpMnfkrfYNsFJGPflA==
X-Received: by 2002:a05:6000:18ab:b0:391:241d:a13e with SMTP id
 ffacd0b85a97d-391241da3c8mr2108327f8f.48.1741191179375; 
 Wed, 05 Mar 2025 08:12:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4795d1asm21143947f8f.4.2025.03.05.08.12.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 08:12:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 2/4] hw/arm/raspi: Replace TARGET_AARCH64 by
 legacy_binary_is_64bit()
Date: Wed,  5 Mar 2025 17:12:46 +0100
Message-ID: <20250305161248.54901-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305161248.54901-1-philmd@linaro.org>
References: <20250305161248.54901-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

For legacy ARM binaries, legacy_binary_is_64bit() is
equivalent of the compile time TARGET_AARCH64 definition.

Use it as TypeInfo::registerable() callback to dynamically
add Aarch64 specific types in qemu-system-aarch64 binary,
removing the need of TARGET_AARCH64 #ifdef'ry.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/bcm2836.c | 6 ++----
 hw/arm/raspi.c   | 7 +++----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 95e16806fa1..88a32e5fc20 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/legacy_binary_info.h"
 #include "hw/arm/bcm2836.h"
 #include "hw/arm/raspi_platform.h"
 #include "hw/sysbus.h"
@@ -195,7 +196,6 @@ static void bcm2836_class_init(ObjectClass *oc, void *data)
     dc->realize = bcm2836_realize;
 };
 
-#ifdef TARGET_AARCH64
 static void bcm2837_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -208,7 +208,6 @@ static void bcm2837_class_init(ObjectClass *oc, void *data)
     bc->clusterid = 0x0;
     dc->realize = bcm2836_realize;
 };
-#endif
 
 static const TypeInfo bcm283x_types[] = {
     {
@@ -219,12 +218,11 @@ static const TypeInfo bcm283x_types[] = {
         .name           = TYPE_BCM2836,
         .parent         = TYPE_BCM283X,
         .class_init     = bcm2836_class_init,
-#ifdef TARGET_AARCH64
     }, {
         .name           = TYPE_BCM2837,
         .parent         = TYPE_BCM283X,
+        .registerable   = legacy_binary_is_64bit,
         .class_init     = bcm2837_class_init,
-#endif
     }, {
         .name           = TYPE_BCM283X,
         .parent         = TYPE_BCM283X_BASE,
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index dce35ca11aa..f7e647a9cbf 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
+#include "qemu/legacy_binary_info.h"
 #include "qapi/error.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bcm2836.h"
@@ -367,7 +368,6 @@ static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
     raspi_machine_class_init(mc, rmc->board_rev);
 };
 
-#ifdef TARGET_AARCH64
 static void raspi3ap_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -387,7 +387,6 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
     rmc->board_rev = 0xa02082;
     raspi_machine_class_init(mc, rmc->board_rev);
 };
-#endif /* TARGET_AARCH64 */
 
 static const TypeInfo raspi_machine_types[] = {
     {
@@ -402,16 +401,16 @@ static const TypeInfo raspi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("raspi2b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi2b_machine_class_init,
-#ifdef TARGET_AARCH64
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
+        .registerable   = legacy_binary_is_64bit,
         .class_init     = raspi3ap_machine_class_init,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
+        .registerable   = legacy_binary_is_64bit,
         .class_init     = raspi3b_machine_class_init,
-#endif
     }, {
         .name           = TYPE_RASPI_MACHINE,
         .parent         = TYPE_RASPI_BASE_MACHINE,
-- 
2.47.1


