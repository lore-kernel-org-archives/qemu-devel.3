Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D45E77184
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSV-000114-Ku; Wed, 11 Dec 2024 11:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPST-0000u2-6Y
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:05 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSR-0007oj-Gq
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:04 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434f80457a4so5277395e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934062; x=1734538862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HIBxigbccU9+srEWhsNqTCAiXYWvyJ1k1YE9ZXRBOPo=;
 b=pFZzpuNVGMlxnpu8Eevj1DEw6e9DFU4Rg1KQU6ptjj5QWgx/+kqfdvNZN1VUDdsz4P
 XsKE07LTYpHJ5U1fGaC9077DP2NJCDvkUdZlx5FRz63RzyMVEhZ6tRhI+b4pEviQ4sdc
 vCMDX62Nfbosy0SbYIE1wxprzjqmEjVrjGv2g9oPlZMjgCpalUym86d4pEJfQIoeRQIb
 idVzCbimjJovtXemMZ4itS5pR6Cw3W3PPKGv+20g4kZRsC7Vd3IRyMXiK99LVFprKCQx
 im3MjtjkCVVAAw/jpn6HFxnw1pXZ4TyDAJfTM4xNEp+AEL7j4RgHUFvUoQyW9L2W4Rqz
 kvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934062; x=1734538862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HIBxigbccU9+srEWhsNqTCAiXYWvyJ1k1YE9ZXRBOPo=;
 b=DI0RrfE4UfBTwqaFT3utkQ7SMAhrRUa+Sp6cy3fiFn6KbQXJn5Mz6hisuVLKHgxuuA
 WCLSz3yi0r53JQOksSPVDaZpMGZDVWlc/SyXHGUb7qk9eaWlKfIRKER4FTkDxAqoLcq2
 bzOj/55sB0SyWTjud3gHBNSwYezC2qPBSPq4ZIDzACnAqazBub4NbgI2P7qO6Ufpgblo
 hP3DJtKsgsIKyVedFKveX/b7uvgHetMnVbgdaAdp0YofMg/heQzCSDB7XhPmdx+c0QIv
 xb67zYa7hbtJMQ8l397yEZPLnFeS9HSB6k0HaGbG/L49sigzx5rmMB12p6E3tgD6siq+
 wc2w==
X-Gm-Message-State: AOJu0YyAA0aXfKCJbANFm5AaTdKw/M8iNZZJQWZOUcq/t2RSEuKzkSxi
 n2nTjcarK+0Gu+NXwagEG+/CvBksBrJS4qnmtz1DzzjCa5EtBovwdM/EwLbvfl/VDLZxhwdTeX3
 9
X-Gm-Gg: ASbGnctmnN8hg20vSwdJsbMcKBukGZU4+rOogs/TpxMWDvUzRVRGjeqrkYS6MCjWGgz
 pLCx1G0oXUAmBytQXMJ4QepQukHGW1JlB7ZWBrD5OmCVqOb33uc1NoyaYf3q7eB+nx0yv6FDIZ9
 BCi/JG4OCAYhgASbl1r0JcIkLw/X4B3CQWLOJC6qdWNTjEpay5wjalTH78/7FuSzKJXxPu0cNlF
 ZlRSgcySOGuERt0tUa9m76FWPFx1sWUW2Qul3CfVRt2FmJPl6laMNFmMvZt
X-Google-Smtp-Source: AGHT+IGygqbbCn1Jp9P4lAi40VvkMrtCkLfXMP9gKPqOgQVEPWCjnH9TouyPrWl7qrG6I4zcKphR8A==
X-Received: by 2002:a05:600c:a0f:b0:434:9e17:190c with SMTP id
 5b1f17b1804b1-4361c49e9c7mr23039425e9.0.1733934061989; 
 Wed, 11 Dec 2024 08:21:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/72] target/m68k: Set default NaN pattern explicitly
Date: Wed, 11 Dec 2024 16:19:40 +0000
Message-Id: <20241211162004.2795499-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Set the default NaN pattern explicitly for m68k.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-43-peter.maydell@linaro.org
---
 target/m68k/cpu.c              | 2 ++
 fpu/softfloat-specialize.c.inc | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 13b76e22488..9de8ce67078 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -105,6 +105,8 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
      * preceding paragraph for nonsignaling NaNs.
      */
     set_float_2nan_prop_rule(float_2nan_prop_ab, &env->fp_status);
+    /* Default NaN: sign bit clear, all frac bits set */
+    set_float_default_nan_pattern(0b01111111, &env->fp_status);
 
     nan = floatx80_default_nan(&env->fp_status);
     for (i = 0; i < 8; i++) {
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index b5ec1944d15..ecb7a52ae7c 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -136,7 +136,7 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
     uint8_t dnan_pattern = status->default_nan_pattern;
 
     if (dnan_pattern == 0) {
-#if defined(TARGET_SPARC) || defined(TARGET_M68K)
+#if defined(TARGET_SPARC)
         /* Sign bit clear, all frac bits set */
         dnan_pattern = 0b01111111;
 #elif defined(TARGET_HEXAGON)
-- 
2.34.1


