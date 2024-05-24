Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16F2C25B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeEH-0006U9-H3; Fri, 24 May 2024 19:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeE7-0006Oe-4M
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:31 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeE4-0005hE-F8
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:30 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f44b5ba445so12727895ad.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716592887; x=1717197687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gL2CcQSQHBX9UC9WbyVew+g6mF+g5maBBhC3HZ00Z54=;
 b=OrdE2hP8YeZw2eePamhfDzUN4Qb/vrRug7++O99H/+uJvmmkzl7zo2bSo06lEYCc29
 dUc6qLQuhP1X7KWFVDcKag3AcvcFtCkQhVshbn3WLMzt1we/tYHM7oVYtcoJVXwjjZuT
 lj/1gOPFOwzfROS4bnIkD7gD9IvPRM7jye+RgWym9pFR6fpWjNYn2tv53nrQ7Li5Gf0s
 BwPNz9vGjdJWXsD2qe3A8FdRy+fYthuviuObyNC2FaH0uYWNLzgVs3wkLFz7zHv/Ki+9
 1txzibA1xQVCvbqKR0tisFAnBfztAIwaSps7MrCO5REvvTj9nRSe7yAGE8QlrJlzhXEC
 wGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716592887; x=1717197687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gL2CcQSQHBX9UC9WbyVew+g6mF+g5maBBhC3HZ00Z54=;
 b=JKWLfJV6tnCdPj3/xdr1VuwPTi6M2sXIy/aLU5vBNoF80w3PraRpXWp9lkNXJ/JvJ9
 Z9ZG1Trg6JW0gTpOYCl+VD7tgXVUeW87yVoTNuHn5Z1LSENolJVRggzS5eEVcKRBJNxS
 OwfVKvdHg1XZRt5U9TQz5qn2YEaarITnIdpFoVmMIHC0rVsgO/Tu7p8D2ngtymDH76rL
 0mWp/iTaT1KiqIs/S+dy0Nr+PRvLCttoWhpithpNG5p1cNXQZTByVVk0dGjrUXSLXQg8
 vm6hj4p/OD/JtvcqjigmhlP0z2g7CGT7eiyMmNZcS/ljERu1pJSepGmRMVQY9xrliXCH
 SVTg==
X-Gm-Message-State: AOJu0Yz8HledhSt9TntSgRsug3ucKWlMhrfSoAe8gjMYJIiED9z34i/s
 kOusYMhgssWY3OUrtyfTnMZa5HO8yHAiiWnhxanuvqiwjTfe38nJ+U7nXE0tk7i9H72SPVdngoN
 E
X-Google-Smtp-Source: AGHT+IF+MPw0RRYzvW9j8ypRbyZTQsEqg17q1XeNYF6teWALGxAibHfPFahQqwJk62PfznJmlfsRIg==
X-Received: by 2002:a17:903:181:b0:1f2:e14b:3d91 with SMTP id
 d9443c01a7336-1f4498f09bbmr47181005ad.59.1716592886979; 
 Fri, 24 May 2024 16:21:26 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm19178305ad.10.2024.05.24.16.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:21:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 05/67] target/arm: Fix decode of FMOV (hp) vs MOVI
Date: Fri, 24 May 2024 16:20:19 -0700
Message-Id: <20240524232121.284515-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

The decode of FMOV (vector, immediate, half-precision) vs
invalid cases of MOVI are incorrect.

Fixes RISU mismatch for invalid insn 0x2f01fd31.

Fixes: 70b4e6a4457 ("arm/translate-a64: add FP16 FMOV to simd_mod_imm")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d97acdbaf9..5455ae3685 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7904,27 +7904,31 @@ static void disas_simd_mod_imm(DisasContext *s, uint32_t insn)
     bool is_q = extract32(insn, 30, 1);
     uint64_t imm = 0;
 
-    if (o2 != 0 || ((cmode == 0xf) && is_neg && !is_q)) {
-        /* Check for FMOV (vector, immediate) - half-precision */
-        if (!(dc_isar_feature(aa64_fp16, s) && o2 && cmode == 0xf)) {
+    if (o2) {
+        if (cmode != 0xf || is_neg) {
             unallocated_encoding(s);
             return;
         }
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    if (cmode == 15 && o2 && !is_neg) {
         /* FMOV (vector, immediate) - half-precision */
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            unallocated_encoding(s);
+            return;
+        }
         imm = vfp_expand_imm(MO_16, abcdefgh);
         /* now duplicate across the lanes */
         imm = dup_const(MO_16, imm);
     } else {
+        if (cmode == 0xf && is_neg && !is_q) {
+            unallocated_encoding(s);
+            return;
+        }
         imm = asimd_imm_const(abcdefgh, cmode, is_neg);
     }
 
+    if (!fp_access_check(s)) {
+        return;
+    }
+
     if (!((cmode & 0x9) == 0x1 || (cmode & 0xd) == 0x9)) {
         /* MOVI or MVNI, with MVNI negation handled above.  */
         tcg_gen_gvec_dup_imm(MO_64, vec_full_reg_offset(s, rd), is_q ? 16 : 8,
-- 
2.34.1


