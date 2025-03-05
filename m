Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9C4C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tprMt-00039g-BQ; Wed, 05 Mar 2025 11:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tprMr-000397-Mv
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:13:09 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tprMo-0007as-1v
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:13:08 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43bc6a6aaf7so27647445e9.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741191184; x=1741795984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qg/30+ydc7IJRGhxhQY+axZZcsxzMfsJFGVXHCMQm/4=;
 b=qT3lE5TU6Wz6aKfb09qDS3Q6OTYQWt4fBNGPTB2RblvMhVGaFcK38G2VsxMrMb3g+T
 sGUrGUnSKD+gaCicHyq1371VD7HpuAblllENyprwYLgM4cbLVQhBYSNkfzzDVYkn/+K/
 oICh+1JAEbIoztq6wxjXa1H4rPsI7PaSXzMFJK5RF0kiK44/sEjS6ibUBnH1KW0NH7nn
 BfWchRqrQ4sWfXgaS8RWG+tuZ3FVP51ms6CyNKurpN8sn2HfEiOacGkgOsMrBI0g1Rxu
 ZB1cKEPhzqCM4dD2R2jccdtZcCqATQBm09Bjsmcycq2ScCT3e39EJ+rc5ercLTMtKBTK
 azQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741191184; x=1741795984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qg/30+ydc7IJRGhxhQY+axZZcsxzMfsJFGVXHCMQm/4=;
 b=uCKaGZp/hTzeYHdceyDFegKVLYsawkWeAVH/1rE3HkvCGPvMDZCD0ip+cgaglYO90E
 KjsOIoUmW7yMxUFgFssbPd5XJ8Wsu9He4khG0a9aQcfCuWctWVyKCiIk2yuRUdq0yLiv
 dQp1E7UyxVxKc+mXuoOIalopizKUUVNqfGDFbx3/wEUb6/FIlq5HhgYGj3Xo9R+TdIz+
 +dpMLTnC+Iv/LmAS87FeKgnVYnbCZ1gOirivlPhNOrx9LXIZKYBOrv+8WGdjYPi7QHEj
 u681Z5gdMcxbTCwEwGwM/i3FsS6XNu/4FWsdsonxEovlqHawB92nQX9OhIEPkoVD12dG
 7Cwg==
X-Gm-Message-State: AOJu0YwZ2jlOOIjtTdqndxOe0S2rj31FhHTn6FA5rkbmLxgXJZLPrAsn
 iTuHTvvmVQODcTIpm4/PjP3mSemBbQUlPU3vFbtQuQ7cs6R+YG3ScSnmIf2yMWDCRbLkiD+xWDJ
 044Y=
X-Gm-Gg: ASbGnct4UJV6gRss+8sWaOjQbuADqPo+g/uAB91Y5BdjmXWRhDrRyRQACD95mIl4jwr
 X2/sztw4/CfJ661uzwCC0pMhqS9zt9Vyl1+Uai9bGy2kNrgz7c4l1R7OyGOBgkdgfYCI6gA5Red
 l6ssO9XVjQ2o4pXoqCu2l5GdpsSSYmVnLNfpuWK+dgaCt3AOGXBAYdNVnwdsDcG8TKr6wVmLri+
 h5Q6lPXhk62+XwhycwRlbl1sHsV5G8GljYNub7bTR6cb9hLrhyWCED4VKeHdrNelHWhtGFBuk5I
 wuKKoDaZQeWkqXi6/NpVxvbzU5/+32jdohBIk+vMuFDOnYo4HH3QtXblx+X/XtbYefeBfSsUQFX
 anJk6EXvJvGAfz7Xt0Z4=
X-Google-Smtp-Source: AGHT+IFxDeN876InatIsSjSDZ80/TUSkTjwZpHJWITAgNTNUaTC/7w/dc/lOxL2VwxyFs/KwQhqeEA==
X-Received: by 2002:a05:600c:35cf:b0:43b:ca8c:fc76 with SMTP id
 5b1f17b1804b1-43bd29a84f1mr29527715e9.18.1741191184087; 
 Wed, 05 Mar 2025 08:13:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c6203sm21718385e9.24.2025.03.05.08.13.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 08:13:03 -0800 (PST)
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
Subject: [RFC PATCH 3/4] hw/arm/aspeed: Replace TARGET_AARCH64 by
 legacy_binary_is_64bit()
Date: Wed,  5 Mar 2025 17:12:47 +0100
Message-ID: <20250305161248.54901-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305161248.54901-1-philmd@linaro.org>
References: <20250305161248.54901-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
 hw/arm/aspeed.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 98bf071139b..3f18a4501e0 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -28,6 +28,7 @@
 #include "hw/loader.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
+#include "qemu/legacy_binary_info.h"
 #include "hw/qdev-clock.h"
 #include "system/system.h"
 
@@ -179,11 +180,9 @@ struct AspeedMachineState {
 #define AST2600_EVB_HW_STRAP1 0x000000C0
 #define AST2600_EVB_HW_STRAP2 0x00000003
 
-#ifdef TARGET_AARCH64
 /* AST2700 evb hardware value */
 #define AST2700_EVB_HW_STRAP1 0x000000C0
 #define AST2700_EVB_HW_STRAP2 0x00000003
-#endif
 
 /* Rainier hardware value: (QEMU prototype) */
 #define RAINIER_BMC_HW_STRAP1 (0x00422016 | SCU_AST2600_HW_STRAP_BOOT_SRC_EMMC)
@@ -1661,7 +1660,6 @@ static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 }
 
-#ifdef TARGET_AARCH64
 static void ast2700_evb_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
@@ -1690,7 +1688,6 @@ static void aspeed_machine_ast2700_evb_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
-#endif
 
 static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
                                                      void *data)
@@ -1813,12 +1810,11 @@ static const TypeInfo aspeed_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("ast1030-evb"),
         .parent         = TYPE_ASPEED_MACHINE,
         .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
-#ifdef TARGET_AARCH64
     }, {
         .name          = MACHINE_TYPE_NAME("ast2700-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
+        .registerable   = legacy_binary_is_64bit,
         .class_init    = aspeed_machine_ast2700_evb_class_init,
-#endif
     }, {
         .name          = TYPE_ASPEED_MACHINE,
         .parent        = TYPE_MACHINE,
-- 
2.47.1


