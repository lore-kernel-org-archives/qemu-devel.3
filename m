Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECBAE9A053
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7fV-0005QQ-13; Thu, 19 Feb 2026 12:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fQ-0005NG-Rz
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:21 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fP-0000Rf-9W
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:20 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-65c0d2f5fe1so1880986a12.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771521498; x=1772126298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FPbEe6rl2yKmSfHI3D0ZBNoF06K4sgdbd3ruNGI9+Bw=;
 b=cyTJHChAA9BSydym/HDWkLwchNsFNwf8HrsxDyzqNViix6EQgr4kHtXCVMVMpOJdrU
 C9Du45n9FI3te4pFVuPozB6lnjYYh789yklfa+/2qJW7Y0Xq8Uc6oGK/HTtwQA5rqAc1
 PnPFqTOBMV6MJEZNpTlI8z+OjDEVy6p8bozx93sdPSId5q34TkE5shTMx+ChSG5g6I/4
 leGfF0eXJVBqXQSSUpgt7hPx7riSB/Gq1ga952D+XkiGpsViV8+MTNSxPJ8zAt3kTMM2
 Jspi6fuHCmgBIk3jSR4LZc0olvXFY8Jyj53OthUKifGXW62wceAj9DYRvftNjl8hItSJ
 RxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771521498; x=1772126298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FPbEe6rl2yKmSfHI3D0ZBNoF06K4sgdbd3ruNGI9+Bw=;
 b=OnOOa2rglGyrP5q0K+JuUHcyEcEq5VYHzIpqC9XJazYSHmpBsKb/VTqnQy9s65JpwW
 +wvGk0AIqxNVXRhvnUaPCv2TSGhFZt7e7v13kGFi/57TzlLP/2/S6EvBffY1b+iKsktJ
 155VgEbPytQJUb6KwXu3DZqiT0RNC8zDtP6sik/u4RlM7UUVVVAFaoKPJcUAPV40YlCi
 zSzaXNsFAcLIuW+3dMhGBw8HdCu79WGtvuoAmKtxs6vSc59QdRR+GG3SINEbAVFam5Ob
 N/7iHepptHRmQ8KgtkZBpshZvQA7N2MePptczr9C3D/osUaM2znYoNLhCAvQFN+D9wy9
 Ba7g==
X-Gm-Message-State: AOJu0YyHn+houi7dU4yKZwy9Ufs/leSMEokr3LnqcVCmbXOQsnaPzqiA
 4yGjbrH+lRcqVm7Ec0hj07D2kQgWzzuVfUVOj8daHFmsyw5Fq2yyiT93jSbp5zmGie0=
X-Gm-Gg: AZuq6aIxzoweGJinI/uU3FHw6+gjeIfbBxpXaTxVIWpW2+igiAsbIy6Svgjr/oJ+ON+
 53f0MM2/BouDLu3XAP4qrAqgqtWbLGAwQAND6IA0R7RYhT+FSj5sH3k5GwopTZ/b+cp7BNJYBrc
 B2Fliyjg/uJUkq7GC5xlfuWoVbttL6pWrlQXbLcHjXXqNqaTcQjFgZMk+O9/f3byaKZ7OQgvZsw
 j6+DdHXCOatggSAq9YG8rfNxStThuKwKX/yJ+3oxREmdm0106LAqgx3VlUAYblveTey29okOFP2
 aVc12VRyp0o2JemkaMVZR2OvfBb3+ImLQlw7a6WH26yB3EaJv+AkXyWUG+YSDCQBOyOEz3ptn4x
 X34gAgyHy1kEbu3uviXmkod7NjDlr42lflyb3tc0/DvqA62io6h+O4EAqm8h/1LWcXtkqAjHuMg
 2kWTcNN1JmVsZTza6uCVXm0WKmP75Yd2dfvw==
X-Received: by 2002:a05:6402:2787:b0:658:11c3:4221 with SMTP id
 4fb4d7f45d1cf-65c76959b25mr3583625a12.7.1771521497211; 
 Thu, 19 Feb 2026 09:18:17 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65bad3e39bfsm4190716a12.22.2026.02.19.09.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:18:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 534E35F8D3;
 Thu, 19 Feb 2026 17:18:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH v2 09/14] target/tricore: move cpu_reset from
 tricore_cpu_realizefn
Date: Thu, 19 Feb 2026 17:18:05 +0000
Message-ID: <20260219171810.602667-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219171810.602667-1-alex.bennee@linaro.org>
References: <20260219171810.602667-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

Implement a proper cpu reset handler for tricore cpus.

Message-ID: <20260108143423.1378674-11-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/tricore/cpu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 04319e107ba..c3dda9f6a54 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -24,6 +24,7 @@
 #include "qemu/error-report.h"
 #include "tcg/debug-assert.h"
 #include "accel/tcg/cpu-ops.h"
+#include "system/reset.h"
 
 static inline void set_feature(CPUTriCoreState *env, int feature)
 {
@@ -81,6 +82,12 @@ static void tricore_cpu_reset_hold(Object *obj, ResetType type)
     cpu_state_reset(cpu_env(cs));
 }
 
+static void tricore_cpu_reset(void *opaque)
+{
+    CPUState *cs = opaque;
+    cpu_reset(cs);
+}
+
 static bool tricore_cpu_has_work(CPUState *cs)
 {
     return true;
@@ -120,8 +127,8 @@ static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
     if (tricore_has_feature(env, TRICORE_FEATURE_131)) {
         set_feature(env, TRICORE_FEATURE_13);
     }
-    cpu_reset(cs);
     qemu_init_vcpu(cs);
+    qemu_register_reset(tricore_cpu_reset, cs);
 
     tcc->parent_realize(dev, errp);
 }
-- 
2.47.3


