Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05897D78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6WC-0005MT-17; Mon, 02 Dec 2024 08:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6HB-0003In-CG
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:49 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GY-0003QM-US
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:37 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434a1639637so39752815e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145283; x=1733750083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eg5CLJnIGFMP+7pRukJjMkkCwPMh6g96Ep2h3Ltgz5o=;
 b=SHxdBlKI8lzA4bdclnx97YqShFw4jmFeVRkc/zNKmeT46cQx+gf2pKYwkF1u2FXCnQ
 YRRf46LVK4PSc31Dnx/yHqvCBAxr4Fcu/x0i9Kc5VXv9xH1I3SVB0biq7/UiHkp5SGw+
 tegqU/XkeqwZ84h16maHbo+68tQx9jTMNlfRhdZeyPuLInilfzk8IKsVbEU/dGvGAL2t
 TUeMek1wjGS3NxGUp5HYv6y7M1A63gvxl4vq3RFdGQiA3cAUhPwTkwcXTLxjd5EjVeM6
 mc3CnIJMnDfomHSdqs2jLCe7A1O4F2bca1dSboyJ1syh9xr4ViRDF05fDtDpHH9vywDp
 c5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145283; x=1733750083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eg5CLJnIGFMP+7pRukJjMkkCwPMh6g96Ep2h3Ltgz5o=;
 b=aBfUC++Hb9qEr9U621eN6hpEhyn8jz78Qh9GL7/HS3czUX+Q84hx4MgV89eJ0GnDZ3
 Q06pgl9pq5ZUBzmqVF+iILeQr/qB84e+lCbGkrfi8Jq3I3QIPluKG2RfgtPHNhDW4Yrt
 vGlMbHoi9meG+RQAeHVxY4+WPWASffoobde0+QoHcmP8JjYJE8w8DXlSLXptVB8W/q/A
 oB4DJWSlds7xjUeqNO1vbLAet2eFwI+PU7Bx+JEn+95LYcZuPFA3gxd+G72+sRPReBzw
 r3zabQV4rpnW7Xde+Yb0MiJdZtcsW+l0qPcQ1EUrIFz5RmZJnio64htoMy8TWNq75utT
 L1RA==
X-Gm-Message-State: AOJu0Yz8t4HPiDj5Dt1ZieUjav4i1PzzKDwITxX04bbA7TkUY//XOGtv
 /hR5salh2pXTsbpY45YbeNNLf6yOCy6t+PnPkCQBAZOnF/5eWLWTcUzIkvfwsb4ktPwmu2agz/J
 5
X-Gm-Gg: ASbGnctPkkHxfZ87L0S7q7YRcsYRxiHer9+JK8Nsx5GR8t+PijsZbvUsj2bcjOhlmWa
 Uan85b3XP3ToEQV8TpyH0VBLBSI1cU9RVPBTCviycQbUayjtejp+Yo3lSlPPYw/vNkwRFgiBBGE
 4lCYQeTkrRz93BFpJvan0yIu3LUlAt2YagwNA6G5GIibbjm6vveQdGRcLTxFcfHTntAQWALvNlZ
 J1czAswliVLuwzgZl0qbarHCxY1n/JtAHPNrePKm6HWWhqGsn1/tQI=
X-Google-Smtp-Source: AGHT+IGmlpAUQ7RrQZuvyRgb2/PxGBA8A9Osg4UR1KnKKv3AR4gZEx/FzXh11xp1F7xPsGgXaZ4/jQ==
X-Received: by 2002:a05:6000:1865:b0:382:4a3b:5139 with SMTP id
 ffacd0b85a97d-385c6ef598emr19334141f8f.59.1733145282505; 
 Mon, 02 Dec 2024 05:14:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 36/54] target/microblaze: Set default NaN pattern
 explicitly
Date: Mon,  2 Dec 2024 13:13:29 +0000
Message-Id: <20241202131347.498124-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Set the default NaN pattern explicitly, and remove the ifdef from
parts64_default_nan().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/microblaze/cpu.c        | 2 ++
 fpu/softfloat-specialize.c.inc | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 710eb1146c1..0e1e22d1e8e 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -207,6 +207,8 @@ static void mb_cpu_reset_hold(Object *obj, ResetType type)
      * this architecture.
      */
     set_float_2nan_prop_rule(float_2nan_prop_x87, &env->fp_status);
+    /* Default NaN: sign bit set, most significant frac bit set */
+    set_float_default_nan_pattern(0b11000000, &env->fp_status);
 
 #if defined(CONFIG_USER_ONLY)
     /* start in user mode with interrupts enabled.  */
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index b1ec534983c..d77404f0c47 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -139,8 +139,7 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
 #if defined(TARGET_SPARC) || defined(TARGET_M68K)
         /* Sign bit clear, all frac bits set */
         dnan_pattern = 0b01111111;
-#elif defined(TARGET_I386) || defined(TARGET_X86_64)    \
-    || defined(TARGET_MICROBLAZE)
+#elif defined(TARGET_I386) || defined(TARGET_X86_64)
         /* Sign bit set, most significant frac bit set */
         dnan_pattern = 0b11000000;
 #elif defined(TARGET_HPPA)
-- 
2.34.1


