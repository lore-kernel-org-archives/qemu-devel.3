Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196AED7831B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Tz-0007qb-IQ; Mon, 02 Dec 2024 08:28:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Go-0002gV-Dj
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:27 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GX-0003IZ-4q
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:19 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so1803652f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145270; x=1733750070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=74ZFmjtVXHtNex2HC0gYU65u2vZGTycqwogjuvw6ju4=;
 b=Gc9PmP/YovdJH4HWXy/98SFsqTHUDTsErfG9ScmxULAZ6FzByalju071nyMMiJ9JvE
 vGT8VpF08IPCsCUeIv2djbsHk/tUicPCkE/g6jy7zVUIktUKVO9n8ASRSgdHuFMDBTo3
 VHeBIyETCwGLT5Ys4fhMkFsea6XVYr1HdopibKNOIRy8/wSVByfcbZpxCvUADui+n3+R
 SWH5VOrvtU90ZDxr8GcTKc6l1u6gjDqh+5vai6NWYs7lco6/97wc6ChaMPVHI45C3sex
 8I3IWL3s198P7WUHT4yuRafGxhU22FC7MKHjZznkwZ4rvCWLIlncrNtQxOWIhKgJAoGk
 lj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145270; x=1733750070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=74ZFmjtVXHtNex2HC0gYU65u2vZGTycqwogjuvw6ju4=;
 b=FAzkU/a+IMuXSId2TjC5CspfTYyeRgU3Cw7zg0fqSRASJuGR/MbB6rN8xnnse5D4qk
 9EdAiWfYshDhEF1gsQjEzVkn/Q2dv4mNNSBKVqhI0GXdVOz3Ij3xMkPVYWIvzul7oiiO
 7Hodg09DNKqHR0xbHWSOmt14d79C8a8raFTlsCRhKm3gA3iQmrKXo2r2gLxV7tpJPF44
 k9mrpfujGorEvVzadwDtPl0znxP+GpnwGnl6hsaAOtTDVoannBpNs3eJqhVgKuN2DcRU
 YR3irgqaZmIHzuKvOP0+FmAUqlYO6b5VdjXAEywroKPhPW8dOpLUnh5Qt3t9XLIjJsW2
 NM/Q==
X-Gm-Message-State: AOJu0YzCzQk7Dh1bBu4RRikulN/ZMu4gpbeFrZmWpdjt3bhvq2DXtENE
 X3hZxju2Gm/gEI07uHFFshbsMH42GY6YShqbGQwFYfcri8CuYMBrOAW9xFjIYfIkLvImypAkcAz
 v
X-Gm-Gg: ASbGnct7FC1Ph4tJ81tlz9IHZn5PA0JbEfd0GZ7jx0eV02cukirWuzhO7eJnt0j15nE
 dYRGXSZdUhiDRFQd4bfNx/HCLpMQvkQ1tLnPfbHx9IHwDT+gsBKX9bsR+gR9KBuiHkjE8KQQa+L
 X/ov6+I31AefFcjfmA95klgwH6/lEYb8T3VjQndQwOf4P+cvorZCSflY4nGe6wnSoLHH+BY0N3d
 KxoBYCUjPEV4XQJ2ZzPoO2zMe301LQ0qxAbCEwo4cRmBZ+KcZLnbwE=
X-Google-Smtp-Source: AGHT+IFTXydxmNqzHUMrjLYeqi7UUKW4Cm6RESZeQThmbS95R5edyOboW/pND1+LCIW51N2TZjvQnA==
X-Received: by 2002:a05:6000:156f:b0:385:f0c9:4b66 with SMTP id
 ffacd0b85a97d-385f0c94ea6mr4495634f8f.33.1733145267678; 
 Mon, 02 Dec 2024 05:14:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:27 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 22/54] target/mips: Set Float3NaNPropRule
 explicitly
Date: Mon,  2 Dec 2024 13:13:15 +0000
Message-Id: <20241202131347.498124-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index c4d8d085a98..28db409d22c 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -505,13 +505,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
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


