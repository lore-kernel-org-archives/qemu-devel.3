Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DB6C624D8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONG-00015r-5F; Tue, 01 Sep 2026 09:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONE-00014z-NQ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:00 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1OND-0007Cc-2q
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:00 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c252c7270faso793189866b.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268678; x=1788873478; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OCnS1TSwyGi8oae/WH470zGgu7DaGQ2CJrcgjTVsuBE=;
 b=jH6tv8K+YHS8IsDBGPs6nJLgtjCcLFiYCSrigRpI8sEQgWlJSzIvkfBqNSpYWeSdfW
 oL8zJkRWL2qP/2GE9AmVkQq2xcgSNZH0acF2UnJsj/nDHDH2B9ZEBnqcYKbOEa1G2UtH
 rnNxe8DHHTrbxivp8mNo5z/QRTBuLZ7tHUPY6becyheaQhaK94914FWOa6VCociW7LGk
 IFLpYiQMMHm7Gt4fRV+XOIF3ATdZaOugQBykWE/RaOg2Z+7lQ9g2OzzwcF6n2T4wBxeg
 YpPvRYn126EKAHH7VLgTzoaEyhEU1Z9MxxnP1FvQ6o9i20XniUnczTn5M8WbTt+L3CLd
 6yGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268678; x=1788873478;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OCnS1TSwyGi8oae/WH470zGgu7DaGQ2CJrcgjTVsuBE=;
 b=WxT4ijw+ZyxHHSF1eSV8965kpi1f2kNCsXzDZt8nyOdVGaSTvrW5Qp8ucTd3ODfSwM
 KSTP4hG160hxoJgDXDjnKMLGnqfAWOaK58cGBUsfyuVXFEXE1lC1Ef/9xzjWPkOaeZCo
 G7TTA/XYXRqqO17OsU9SA9P6eT9pdpvnZR+yY39WgwQvTn/vWnLUnomXqvCzVQvJ6U/E
 CUZZGYg1FEpNtG50UcOX+/krrYwYSSzj9lxb3VbiIZ0vbUVtN+c9jsSpx6yela8Gy4kW
 YZ13nqNH0iFw3mfn8RqGr7+GgtoGZlGmglY4XvwTaDzrtAbeqWFJl5QjC1iQTgPtB9xz
 KSxw==
X-Gm-Message-State: AFuF++k6H0+6BkX5mBgUYZi/0/7Fs1wHWCwf2Z/mXQGS2QuFjWBzf4Sp
 pTnFTMbw3/knZ+jhrV4XivQeQ9eSIeJ0Q2Qzp+ZuDn1EWbl4QrHG4p2CAoht7xbXzi5rjUl1GQz
 Cc1ph4gY=
X-Gm-Gg: AR+sD13dXYE3JfwwgQ9NQd9+IyJyxqwCna1OTg93Z9xgXhsd6OEHP5fXGB3M0R85rfF
 QspQd30i3ClRu9wbuQjL1yixUKtTBZmkupHt+DwMtVg9rIooTTD8jkvErW+oRX2SucDbf4hAlWi
 b8sCOgBL+Ai2XCFhotp59WnmZ12ts+Cfr5oM+NI3MNm9A0DRxxMXErmIRbi+L+Be/MZYRvw8bZi
 7Y3+BCIC0/QPdTrivE4ddMea9bTosFFYN0ZxEAP2Y5iWxUnWAnY4l/o5LEJHNPD4weQLI7V4HnX
 HRbBJoImEA9SBXyulePB40ZJff8TY4Fwn2iVWj7bi5fxgorHlEZOTYQWaF1eWJlFjoGP2i7lkUs
 ChmgzdkLYsXEvamtyswnAAZkVHnsBAs5NrR6WdcRWMWlvfdDDWUAbK8ae8ZG3Ge6Kwpi6Ag+Mcm
 LvncpRN98KD1lwUrnSnbXlX/rS4U6mVWP8xrUHiMI10RvJtWCt1CL+RYvu67DW9xZTsELGjl5uT
 rWwIhafh1PbtAJ1wqsN1rLIEeL4IcN8po3NO72Mg5Mp0L7p7xM6y9NgGO7Kk2lQQQ76CilPnk7G
 J712
X-Received: by 2002:a17:906:170b:b0:c24:d6f0:1223 with SMTP id
 a640c23a62f3a-c25b3cba78bmr438952966b.12.1788268677665; 
 Tue, 01 Sep 2026 06:17:57 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/58] target/arm: Build cpu32.c once in system mode
Date: Tue,  1 Sep 2026 14:16:57 +0100
Message-ID: <20260901131732.2263947-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

"Move" the ifdef to meson.build rules.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260827041557.775080-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu32.c     |  5 -----
 target/arm/tcg/meson.build | 10 +++++-----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 94a705e8066..f292a269bf2 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -19,9 +19,6 @@
 #include "cpregs.h"
 
 
-/* CPU models. These are not needed for the AArch64 linux-user build. */
-#if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
-
 static void arm926_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -756,5 +753,3 @@ static void arm_tcg_cpu_register_types(void)
 }
 
 type_init(arm_tcg_cpu_register_types)
-
-#endif /* !CONFIG_USER_ONLY || !TARGET_AARCH64 */
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 35e70b004d9..a3e9d55e853 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,10 +30,6 @@ translate32_d = [
 arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
 arm_stubs_ss.add(files('stubs32.c'))
 
-arm_ss.add(files(
-  'cpu32.c',
-))
-
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'gengvec64.c',
   'translate-a64.c',
@@ -49,7 +45,10 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
 ))
 
 arm_common_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
-arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
+arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
+  'cpu-v7m.c',
+  'cpu32.c',
+))
 
 arm_common_ss.add(zlib)
 arm_common_ss.add(files(
@@ -86,6 +85,7 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
 ))
 
 arm_common_system_ss.add(files(
+  'cpu32.c',
   'cpregs-at.c',
   'gicv5-cpuif.c',
   'psci.c',
-- 
2.43.0


