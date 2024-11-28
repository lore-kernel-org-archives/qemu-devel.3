Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B79CD690F7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc1D-00048t-VE; Thu, 28 Nov 2024 05:45:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGc01-0002Ev-Ut
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:44:00 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzu-0000i1-Ma
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:50 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-382423f4082so508488f8f.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790614; x=1733395414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TrVJRkkr5D+N0aBUkmYJt1MSRdpl5FRuyVmIZ66utw=;
 b=aFqv7/QcygN3bY0RWqQhVGeEi48O/RVQkVp5yNM03o9nBoVaKyBOaxDk/0eymw7ZVU
 eegs/6tDlwYnfHnImjtmpuJ1Si91JSUp8xfeUMowqqVaL1hy25X9hcb4Pe6ZTxFP684N
 dJE//60qw95ncsMRiTuGRFzCZTMkfRjj83BH7whILqHbBXuqk9ZaziNoynv9o5gYy92g
 2izRLjjuwajKTO49mJjATDg/CPf4/lno+wLz7W5w+I6yJ5YSwZ63IVUcbopfZ2SgoM+C
 PF8d44IoEBgrJKwzFYLq6O0YDa94Xy83To/4LnJa/a6RFxSpQgKpbFedyTgMnaTJ8jzG
 1URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790614; x=1733395414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2TrVJRkkr5D+N0aBUkmYJt1MSRdpl5FRuyVmIZ66utw=;
 b=C2Tp6XTzznAwyl9nuhzU48h9EkSApbQkdZJSGJIJ05rgT1vYZph9EYUwRJgb4j6gpi
 4thfGE2RPG9lDpFublRO/S0q6Y8QBsLgnTnGHDOU+qUZRbkOjECd0CJ9wgAXj2bA8FfT
 XnjQxK9M2QlOoDaxtvHOL8285UfJgBpM+qaByI9qpSJEz/Vqij0xq47LvV+4qjlta6yC
 cG1X+b1C5+aiCBnYtP4uqI7IZD10y4f3BRWSeIlYO/8zC3isN8XKk4TGWCjy7GHQSAuj
 icEfZLRN6Dh+CN2+pimQEWxpzIt0Fft+0fsvGCKG0aUSEeXD08vGMxLVfmBSxt9CeYiI
 vFHw==
X-Gm-Message-State: AOJu0YzCUMHWT9eIk4qIRn+GSy/kYiBLBfkC3mRtMPPJOgN3ffEvz6Ij
 jWrGqKaRacrsgXzKH2czJx2ZETvSQ+rCyhTEin/X6fQPQqsuvbT1hK9Ypf7281W2mvm4moIV/v6
 a
X-Gm-Gg: ASbGncvNlvzjJrHNr5fizOywtD3MUhtIChz/Dk0aMV7CiSQmAMEpdR1bmAJ9hX4aFZN
 Q8678UiBOtREEAFXwBDwnPlxnPOtkuwMph6zF2lNumuU5LRVB22G3g/GJgWCohyjAuj0BS7ntF9
 ue0qSKPB5PaOTiXr/e22UH0MDw+tg+WKKOYN7dvhDhgggUd018QwBHLdnZ6x8QSknAIJZapCcU7
 3FKyMnf3fMUrMz4ksD5V03gE3geRRO819ou3Inywubgv4KO1AHU8sI=
X-Google-Smtp-Source: AGHT+IEbfVCLYtPqt/qOPnH2qT981nHuA4VnsdG2pgMYEFf5EZYOEna96GoFM7XW2C+4P/qqEtZwEA==
X-Received: by 2002:a5d:47cb:0:b0:382:22c6:7bcb with SMTP id
 ffacd0b85a97d-385c6eb4c32mr6479070f8f.3.1732790614335; 
 Thu, 28 Nov 2024 02:43:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:34 -0800 (PST)
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
Subject: [PATCH for-10.0 21/25] target/mips: Set Float3NaNPropRule explicitly
Date: Thu, 28 Nov 2024 10:43:06 +0000
Message-Id: <20241128104310.3452934-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Set the Float3NaNPropRule explicitly for Arm, and remove the
ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/mips/fpu_helper.h       | 4 ++++
 target/mips/msa.c              | 3 +++
 fpu/softfloat-specialize.c.inc | 8 +-------
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/mips/fpu_helper.h b/target/mips/fpu_helper.h
index be66f2f813a..8ca0ca7ea39 100644
--- a/target/mips/fpu_helper.h
+++ b/target/mips/fpu_helper.h
@@ -29,6 +29,7 @@ static inline void restore_snan_bit_mode(CPUMIPSState *env)
 {
     bool nan2008 = env->active_fpu.fcr31 & (1 << FCR31_NAN2008);
     FloatInfZeroNaNRule izn_rule;
+    Float3NaNPropRule nan3_rule;
 
     /*
      * With nan2008, SNaNs are silenced in the usual way.
@@ -44,6 +45,9 @@ static inline void restore_snan_bit_mode(CPUMIPSState *env)
      */
     izn_rule = nan2008 ? float_infzeronan_dnan_never : float_infzeronan_dnan_always;
     set_float_infzeronan_rule(izn_rule, &env->active_fpu.fp_status);
+    nan3_rule = nan2008 ? float_3nan_prop_s_cab : float_3nan_prop_s_abc;
+    set_float_3nan_prop_rule(nan3_rule, &env->active_fpu.fp_status);
+
 }
 
 static inline void restore_fp_status(CPUMIPSState *env)
diff --git a/target/mips/msa.c b/target/mips/msa.c
index cc152db27f9..93a9a87d76d 100644
--- a/target/mips/msa.c
+++ b/target/mips/msa.c
@@ -66,6 +66,9 @@ void msa_reset(CPUMIPSState *env)
     set_float_2nan_prop_rule(float_2nan_prop_s_ab,
                              &env->active_tc.msa_fp_status);
 
+    set_float_3nan_prop_rule(float_3nan_prop_s_cab,
+                             &env->active_tc.msa_fp_status);
+
     /* clear float_status exception flags */
     set_float_exception_flags(0, &env->active_tc.msa_fp_status);
 
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 565790b1834..2d029de7baa 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -502,13 +502,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
     }
 
     if (rule == float_3nan_prop_none) {
-#if defined(TARGET_MIPS)
-        if (snan_bit_is_one(status)) {
-            rule = float_3nan_prop_s_abc;
-        } else {
-            rule = float_3nan_prop_s_cab;
-        }
-#elif defined(TARGET_XTENSA)
+#if defined(TARGET_XTENSA)
         if (status->use_first_nan) {
             rule = float_3nan_prop_abc;
         } else {
-- 
2.34.1


