Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805B5C48295
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvay-0000FM-Ha; Fri, 02 Feb 2024 10:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvax-0000Co-7S
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:47 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvav-0004Sc-Ib
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:46 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-51124d43943so3541082e87.2
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888204; x=1707493004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3IztTFtTp/gI4kdSRMU2w+rciRT9b75JC4Gb/82o25A=;
 b=mTRrMiMaTpkHCqF7CArygW0SRSW3VgY0bFZtEYqvzL0V/GzT5L13MXkMlYi448zWTV
 Jg0kK7jVDnX0k4kU8WjFgLeQ5C7758LUYpstTuPR8ikDmGZssY/NpOxI7Y86WbXeQDrf
 uouBzWg52zN8N6dN69EdkUc3EMxjS0nRf6IKxpoSLgbb04TOJ/LXxn9YFMpQIu/H9Cy+
 HLIoRJAeIa0i8zqG8HajeQkeMkHGQm4UxGg86ahpvf4DXAa2doM+m5u1xyZheo/bweq8
 jDuNg2G4/RLNq/wh2VrHM5rxEdT6vEasBQ+diuvb5URPOWbVEYuLCb3lcJr1KbmbUzHg
 Ru0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888204; x=1707493004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3IztTFtTp/gI4kdSRMU2w+rciRT9b75JC4Gb/82o25A=;
 b=OIMLEJojyUBLJwB+RpjZSmylp8pJmqc40sMrlPG9sH6XYcqwq1iBSpMfzRQcivZNko
 bUTmiHx8BecG8pz4FeoxGC94eJUGTDOkT2DWvpsCcxHNSZHOUjLl7SQ6DAV5v07Xtw+7
 32mDazIPGHxKPMhSPnW+Y1cEpppPdhnR+P9BKYSzfVpybWLAFuwZCJS2jaCo0m3ZJv0f
 nAO4hmOUK/ZTJBUbYL5+TM8jsHspNLlhrUMb1rv1/7/NUhOiI3ye5xkKW/mQBrWX58Oi
 4RGja7f6VsOubQOW9fN5l2os6ih0cQLsMdopaMd1h/LZpRnJNOsRETkqrIyApgB8PvUQ
 xkPg==
X-Gm-Message-State: AOJu0YwKoKzPqo4w71kg/fRam3ijg2SriZT7Ve4kX0/XqMw20/8hkESc
 sOcQTQ81HKQbjhb9U/XeL4ZLXypy5jaQG1218jN21MBiasMnZ89rTVW4842OqJWdtATq8LCuzQ1
 4
X-Google-Smtp-Source: AGHT+IH5K5agyRF3XA0wL7daLZr55qopu1G8ldkRoZhK6UPe2SHFrLirVYF2kWK9gbGGZT+v2oH9fg==
X-Received: by 2002:ac2:5049:0:b0:511:2ebe:a5f3 with SMTP id
 a9-20020ac25049000000b005112ebea5f3mr1653849lfm.60.1706888204042; 
 Fri, 02 Feb 2024 07:36:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/36] target/arm: Reinstate "vfp" property on AArch32 CPUs
Date: Fri,  2 Feb 2024 15:36:12 +0000
Message-Id: <20240202153637.3710444-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In commit 4315f7c614743 we restructured the logic for creating the
VFP related properties to avoid testing the aa32_simd_r32 feature on
AArch64 CPUs.  However in the process we accidentally stopped
exposing the "vfp" QOM property on AArch32 TCG CPUs.

This mostly hasn't had any ill effects because not many people want
to disable VFP, but it wasn't intentional.  Reinstate the property.

Cc: qemu-stable@nongnu.org
Fixes: 4315f7c614743 ("target/arm: Restructure has_vfp_d32 test")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2098
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240126193432.2210558-1-peter.maydell@linaro.org
---
 target/arm/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6a96b245f2c..1ce26e56e32 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1627,6 +1627,10 @@ void arm_cpu_post_init(Object *obj)
         }
     } else if (cpu_isar_feature(aa32_vfp, cpu)) {
         cpu->has_vfp = true;
+        if (tcg_enabled() || qtest_enabled()) {
+            qdev_property_add_static(DEVICE(obj),
+                                     &arm_cpu_has_vfp_property);
+        }
         if (cpu_isar_feature(aa32_simd_r32, cpu)) {
             cpu->has_vfp_d32 = true;
             /*
-- 
2.34.1


