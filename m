Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D00C021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 00:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjS6f-0007lZ-9X; Sat, 15 Feb 2025 19:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS6J-0007eA-25
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:35 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS69-0006H7-0Y
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:27 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-220f048c038so32686915ad.2
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 16:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739664083; x=1740268883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+QFcPwjE+/PZmsE+ZNS1uNg3roQJkJdP7G2ngjxuz4=;
 b=ElXmiMu6YiN5SRC7/wBCFYs8sqR2Jb4bkLtghMMMHeC+TsCw0VZ3k3K42trG8ZpCMz
 aVAAafYh0rWc3h6XiCRL/jQmOPlWlSBjrLJhFEB8xCrtpYWATu6UThGnOGGPRs03u56t
 Kht+zjMpsZ1vgmpCXPGmzrblXbmj9n1v51H889RMS4ydxr+eca0MvdK5UH+8JvYoV0WJ
 /E8qkMIwrlaZW80k4PWAT1KFMfkp89wYrTtx+r1Urx9J9JDRVyyOMz77g4rEpO98pN2h
 jaaF5Mt3m+3jV5VWfy197fvZd3DMJ3h+N4wc1S4LwYQP7mKvP9+EwDb48quUjf9pdtYA
 wFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739664083; x=1740268883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c+QFcPwjE+/PZmsE+ZNS1uNg3roQJkJdP7G2ngjxuz4=;
 b=emEhy21ZDVey4+2yWuf6986h4UMZnmgVYc3l9BhBKxYhTePri76y00MCR0hsf0RfL4
 EQuMQsHsRMj4dieSC1hP6y/MreoHl38ftxKdxDfYy1kWV0XKcnb7zm/7kq919Pyi/Wlt
 RMPgZcM4FVxPg25AkrI4WEFZpFROTDz/jaV8fGcsYr9rYIJSpkGKoIjP98gaxpiOF/+A
 1MxRTA04H1QnZS/pokzM9Zh6k2MhXJb0sodiKsq1jrDKSydvqomAONdrawzSR8+frSDO
 PPb/DuCYnoE61tTnJR7QaT4PHbNvSmzeDh60ZA8sPX6as2lvJMoCvtpIMnc4lZBvFV4d
 d8Qw==
X-Gm-Message-State: AOJu0Yxz5qfDbxXnUQeO+0/bdw6Gx6pUHgWnke0iRDHxdauKaaHyuhj0
 NepgdjAg/jASdcKU82NNSNbYgfpNyF057zVl25TzPK9y43toT6+quyx8amacfw9cqkMJupNAl3O
 n
X-Gm-Gg: ASbGncvUYTT282OePGO+MmkkLrK6NkWnuykE5cTJipNvo3elaXc4ZCNhw+t18xpkkJx
 ybOOz0gVjgFJAnMskYv7DBUZTjSa3gzVuiYJbcTdF79CtgHU4qmg5TXVSFLaxnr05DUrEbY1mPe
 7cSfVEZKaqqDht3zvcEBar0WRdLoqjS7f/0r5MLHLiq27q3lEQnHWTZcOqx3iOHafnpSOm371D7
 BdXI3wMiFM7qih/6khVtC5bu8ABMs3JFXXPIanNgJxqK3BWjf7wGeKSDKfzWY0cywaz3Drfjpf0
 Kp1nQ+lYq8m6B4DG8FgnYThWYnDLRAzRwdOMMHrz1DdDla4=
X-Google-Smtp-Source: AGHT+IGXQN8hr0xVmFfWOyMLsA9ZNt3gz7aF4dp0QlOihXtFZ41hGQeU5tsQyLEB8uaxKB+f8YzqHQ==
X-Received: by 2002:a17:902:fc4e:b0:21f:71b4:d2aa with SMTP id
 d9443c01a7336-22103efeebcmr82139545ad.5.1739664083453; 
 Sat, 15 Feb 2025 16:01:23 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366729sm48960315ad.79.2025.02.15.16.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 16:01:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/24] tcg/loongarch64: Use 'z' constraint
Date: Sat, 15 Feb 2025 16:01:00 -0800
Message-ID: <20250216000109.2606518-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216000109.2606518-1-richard.henderson@linaro.org>
References: <20250216000109.2606518-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Replace target-specific 'Z' with generic 'z'.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target-con-set.h | 15 ++++++-------
 tcg/loongarch64/tcg-target-con-str.h |  1 -
 tcg/loongarch64/tcg-target.c.inc     | 32 ++++++++++++----------------
 3 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index cae6c2aad6..8afaee9476 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -15,8 +15,8 @@
  * tcg-target-con-str.h; the constraint combination is inclusive or.
  */
 C_O0_I1(r)
-C_O0_I2(rZ, r)
-C_O0_I2(rZ, rZ)
+C_O0_I2(rz, r)
+C_O0_I2(rz, rz)
 C_O0_I2(w, r)
 C_O0_I3(r, r, r)
 C_O1_I1(r, r)
@@ -28,14 +28,13 @@ C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rJ)
 C_O1_I2(r, r, rU)
 C_O1_I2(r, r, rW)
-C_O1_I2(r, r, rZ)
-C_O1_I2(r, 0, rZ)
-C_O1_I2(r, rZ, ri)
-C_O1_I2(r, rZ, rJ)
-C_O1_I2(r, rZ, rZ)
+C_O1_I2(r, 0, rz)
+C_O1_I2(r, rz, ri)
+C_O1_I2(r, rz, rJ)
+C_O1_I2(r, rz, rz)
 C_O1_I2(w, w, w)
 C_O1_I2(w, w, wM)
 C_O1_I2(w, w, wA)
 C_O1_I3(w, w, w, w)
-C_O1_I4(r, rZ, rJ, rZ, rZ)
+C_O1_I4(r, rz, rJ, rz, rz)
 C_N2_I1(r, r, r)
diff --git a/tcg/loongarch64/tcg-target-con-str.h b/tcg/loongarch64/tcg-target-con-str.h
index 2ba9c135ac..99759120b4 100644
--- a/tcg/loongarch64/tcg-target-con-str.h
+++ b/tcg/loongarch64/tcg-target-con-str.h
@@ -23,7 +23,6 @@ REGS('w', ALL_VECTOR_REGS)
 CONST('I', TCG_CT_CONST_S12)
 CONST('J', TCG_CT_CONST_S32)
 CONST('U', TCG_CT_CONST_U12)
-CONST('Z', TCG_CT_CONST_ZERO)
 CONST('C', TCG_CT_CONST_C12)
 CONST('W', TCG_CT_CONST_WSZ)
 CONST('M', TCG_CT_CONST_VCMP)
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index dd67e8f6bc..cbd7642b58 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -173,14 +173,13 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 
 #define TCG_GUEST_BASE_REG TCG_REG_S1
 
-#define TCG_CT_CONST_ZERO  0x100
-#define TCG_CT_CONST_S12   0x200
-#define TCG_CT_CONST_S32   0x400
-#define TCG_CT_CONST_U12   0x800
-#define TCG_CT_CONST_C12   0x1000
-#define TCG_CT_CONST_WSZ   0x2000
-#define TCG_CT_CONST_VCMP  0x4000
-#define TCG_CT_CONST_VADD  0x8000
+#define TCG_CT_CONST_S12   0x100
+#define TCG_CT_CONST_S32   0x200
+#define TCG_CT_CONST_U12   0x400
+#define TCG_CT_CONST_C12   0x800
+#define TCG_CT_CONST_WSZ   0x1000
+#define TCG_CT_CONST_VCMP  0x2000
+#define TCG_CT_CONST_VADD  0x4000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
@@ -197,9 +196,6 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if (ct & TCG_CT_CONST) {
         return true;
     }
-    if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
-        return true;
-    }
     if ((ct & TCG_CT_CONST_S12) && val == sextreg(val, 0, 12)) {
         return true;
     }
@@ -2229,7 +2225,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
     case INDEX_op_qemu_st_i32:
     case INDEX_op_qemu_st_i64:
-        return C_O0_I2(rZ, r);
+        return C_O0_I2(rz, r);
 
     case INDEX_op_qemu_ld_i128:
         return C_N2_I1(r, r, r);
@@ -2239,7 +2235,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return C_O0_I2(rZ, rZ);
+        return C_O0_I2(rz, rz);
 
     case INDEX_op_ext8s_i32:
     case INDEX_op_ext8s_i64:
@@ -2332,14 +2328,14 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
         /* Must deposit into the same register as input */
-        return C_O1_I2(r, 0, rZ);
+        return C_O1_I2(r, 0, rz);
 
     case INDEX_op_sub_i32:
     case INDEX_op_setcond_i32:
-        return C_O1_I2(r, rZ, ri);
+        return C_O1_I2(r, rz, ri);
     case INDEX_op_sub_i64:
     case INDEX_op_setcond_i64:
-        return C_O1_I2(r, rZ, rJ);
+        return C_O1_I2(r, rz, rJ);
 
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
@@ -2355,11 +2351,11 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i32:
     case INDEX_op_remu_i64:
-        return C_O1_I2(r, rZ, rZ);
+        return C_O1_I2(r, rz, rz);
 
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
-        return C_O1_I4(r, rZ, rJ, rZ, rZ);
+        return C_O1_I4(r, rz, rJ, rz, rz);
 
     case INDEX_op_ld_vec:
     case INDEX_op_dupm_vec:
-- 
2.43.0


