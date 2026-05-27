Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA4DCD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBYn-0005bj-Rh; Wed, 27 May 2026 06:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBYm-0005Y1-HO
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:32:24 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBYk-00013B-P9
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:32:24 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso20212615e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877941; x=1780482741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9L0ueGtStpkrmE808+1WPNJAWWpUUBVZi53smlvSXPI=;
 b=QOC1SQwK/WjRDcn/beoMtVdx0vIHRC5zMvSb1pqO6XhEbkexhE6lN3FSW0OO87rOD1
 TvuxeswpXb+d9sajvRXb+qi0qn4dSFvmHVskpTxm8DeY5spQ/0tkvDS6mIvCsyH6atts
 MKf8vfbiulzPlLvYXRxYO3QkR2R3g3P+RJeWNtM/EQ6gOUkszIn1rE5xqI8XtoPkfNa+
 /dTJxAD7Lviw2CoUbHiMoTGSl7I2eofKyCAIOHtP26e2tVQFpAmvYgiBMEb6dFb1qsL5
 pCi+E49xPVR+9Qj2gLGk2q4rA+Lu+aq46/8MaTR6kX3IBbicwcWtjILF6xaGydP5El+y
 JwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877941; x=1780482741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9L0ueGtStpkrmE808+1WPNJAWWpUUBVZi53smlvSXPI=;
 b=lwDSjEPbJSIkoQqvHowet+UkkRG4QkBrvaMInVkcZBTGRItcmUpJXJu3ZHwxMlnnPj
 tTkAgDQGYDtay1SLj+X1No18J1Y3ILTNARPTYZPPQsZEwZm4zRp97u6JHadvsHw0BEDP
 aRnH1TuOYPggml880sdhC5w065vHlDe1mOdyef25a09BC26yL4p9935SM4Z2+NVGcDCR
 PsUTsdwPghv/laldReKbEsglQYJR9nl/a0WZGgpZpI8JNI2iV9BcNH7hVNRbUlW24unk
 K1y1+JaC+0HcXbgiEAztsIxXdm7yd8ad2jmCt2KJCQAoXwKN9BPhia/FYAJU6rPU2vdi
 Ib1A==
X-Gm-Message-State: AOJu0Yxmi8vPsckJWh6AA9JdcC2ptNT7hTCIR+UpzbG8zCvUGsKtDXMp
 6qYVLSfgfcbB0qVMFFmKLBfR2FBenjWtk8/urAx288CWTaMAjUtiGwPsoSBlX8BT12wpt+djDQQ
 2aqwJRsdR9Q==
X-Gm-Gg: Acq92OGx/kMyt8VIIhQUrp6o3U2dsQRBrCWHWenZ75t//3bn/3/iZXlZ3Tj2R8OygJC
 D8VHDK4aNM5FNhl7x/HL6nNt1++Bveak217wgIFx/oh2cUSJbFjwc2AVHvV2XMRcygMVtZfDoeZ
 K7R1U2uZSgfzMd3Je+WJJpKISKgh98DWhP7juPC3idqr/0A/BZIMIKxnxPJxzHYLNF0sW2oIQSw
 k5SZFlg4PDJkVgv5do058Hi6VAEoBsXfQRehmL5g3GFIwdpiv4rLpTkirQPCNuKzIIjSA3Jr4N7
 cfDO9m+iJdurvigUzdbhlj2HA/ts9u80cxYbco8auqX8s0Kqenqw8aks3zrScTvn+Tq8zd5EaT8
 6piS/UzRa9zfR2N4aipT+yNEy2GqX9P38AcGgqfpv4x7CiGdEVnFl1HbfBuWBgY1hGCJ7YPX1pK
 w6mJvue40/MhD1bve2ZIT6sn8hHPfdyL4SSaJuQPAR15W2y9If8/pZjH4=
X-Received: by 2002:a05:600d:6451:10b0:48f:d5e8:758c with SMTP id
 5b1f17b1804b1-490426d1a78mr276212885e9.16.1779877941129; 
 Wed, 27 May 2026 03:32:21 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490456274ebsm368639495e9.15.2026.05.27.03.32.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:32:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/32] hw/arm/aspeed: Build objects once
Date: Wed, 27 May 2026 12:30:19 +0200
Message-ID: <20260527103037.4461-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Commit 064f1ce95fe ("hw/arm/aspeed: Split AST2700 EVB
machine into a separate source file for maintainability")
remove the last TARGET_AARCH64 use.

Now than Aspeed machines can be filtered when running a
qemu-system-arm or qemu-system-aarch64 binary, we can
compile the aspeed.c file once, moving it from arm_ss[]
source set to arm_common_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260526203722.79463-5-philmd@linaro.org>
---
 hw/arm/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index f149ed68d09..22e8ad924a2 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -43,7 +43,7 @@ arm_common_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c', 'x
 arm_common_ss.add(when: 'CONFIG_FSL_IMX25', if_true: files('fsl-imx25.c', 'imx25_pdk.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX31', if_true: files('fsl-imx31.c', 'kzm.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6', if_true: files('fsl-imx6.c'))
-arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
+arm_common_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed.c',
   'aspeed_soc_common.c',
   'aspeed_ast2400.c',
@@ -69,8 +69,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast10x0.c',
   'aspeed_ast10x0_evb.c',
   'aspeed_ast1040.c',
-  'aspeed_ast1040_evb.c'))
-arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
+  'aspeed_ast1040_evb.c',
   'aspeed_ast1700.c',
   'aspeed_ast27x0.c',
   'aspeed_ast27x0_evb.c',
-- 
2.53.0


