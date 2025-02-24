Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599C0C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc3I-00079N-BX; Mon, 24 Feb 2025 12:15:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc3C-00076h-6F
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:26 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc39-0005os-Tn
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:25 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-220e83d65e5so89278215ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417322; x=1741022122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wACa546aE/nM20s3+KlDu5wR+UoWJX4NTRRrZ8hS8Vo=;
 b=NeGuaibCK4uoO65KUXYvxUwkH+SHwTnlLnUGMrSo0/KifQtDMh8Pr3aDnrWZIDjK6J
 MiUzUPCzZ7nBcnKovnezQZveN650rhkANr0yvCvAN1Ngdq6aeTtgzxAyTFAH9KERAeQr
 AqS62U7dcq9w77NyYaoX6QSrMbXDfoXF34mPHzWR7UZlma+S2QkC54iCM/CgDxYrvg/Q
 oxUR8RgAxsdU5wkWiu+Pb8j4eNOaRJrTWM92J+zL2SKKcCcPyeaSQUuo+l4fshxkzRuC
 kvNZ5sYDYbpItIFPJ3K2b/zWXAQHyA+hdIXJaKLMg+eQWUM2MjJJkgT6XmyAuKyWa5xH
 XVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417322; x=1741022122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wACa546aE/nM20s3+KlDu5wR+UoWJX4NTRRrZ8hS8Vo=;
 b=MhmZb5Wel4lix2ViLaUlzVak30FAckWYn6P7M7D+pXWePZqwxmWGEfcTbNZHhzyQ5u
 FBb5owLZPxJXnXPUn4ZGo7KQv51mXFA/SiipkOC9Xgjozhew/ynH4nn8TWjXBV/IeHs/
 qVcKmpwd99lOUz1XqNhoJkJfqeJPYo5DbauCzyyCCO9hfxLx6hXslknyCR6uUIBBs7D7
 uJnkY5DfZKebyjlb5gSnPSydsZMy8GnVQ+6H4zna1pBvhxjDu3hqQs+dpAB1M8SlfTgj
 +xo+nhU/LW/cKlThHq0FKa8gYrBSu5vLIK20dY4SkTj1NGo8DUrGiRnK4HGAwMJ1zO5S
 c2nA==
X-Gm-Message-State: AOJu0YxXCKBdyYaMxX81ieSyxnSMaf9L7ERU+QY8sD/BF30xmaQpn9Kk
 Hn6zIi+mhli5oGnRhqFihqdF32YKk1E25h92+mNsOXR4sMzCkShVklT/RV+TlyIv6F2Gi7GJJsI
 Q
X-Gm-Gg: ASbGncsn7rm2Pd3QlOZwLgHHJa7QBKbXnxwHqKxwHW3LiXc7iv4FKr9cWKoY97iSldD
 A97UOVGHqF4hrOsmNGuDJAg0Q4GvqA8KMGVWuRsZngFBkhDZCcAuN0x3B7GEfPVgB/oDgpu/80c
 5U2lpEX/ZiBARR5tVKdt976P6BN7x+ktYaBDg37n6rTJfbZXMsI5A9eCGnOzk7sFqsUmlV23tAY
 oCQf2skf+VJiSevE4Z1S5FqcgshY9MobZ5vIsvdiBf4rt320wQzbEjwD0ZGgIKZXuHJm9TYtLXM
 DxQWc8E+uT4Minq+Rw2HUT/q6YfEFjVs360=
X-Google-Smtp-Source: AGHT+IEMmyMMolW0LYR/s4aCidamjOs9b4pFKYQYIzo/4K6LO6aeJs5armfv/IbmzZrGNvD30BQB9Q==
X-Received: by 2002:a05:6a00:1387:b0:730:8768:76d7 with SMTP id
 d2e1a72fcca58-73426d72ae6mr20026471b3a.17.1740417322320; 
 Mon, 24 Feb 2025 09:15:22 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:15:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH v4 24/24] target/m68k: Implement FPIAR
Date: Mon, 24 Feb 2025 09:14:44 -0800
Message-ID: <20250224171444.440135-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224171444.440135-1-richard.henderson@linaro.org>
References: <20250224171444.440135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

So far, this is only read-as-written.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2497
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.h       |  1 +
 target/m68k/cpu.c       | 23 ++++++++++++++++++++++-
 target/m68k/helper.c    | 14 ++++++++------
 target/m68k/translate.c |  3 ++-
 4 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index c22d5223f0..0bb26720cf 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -110,6 +110,7 @@ typedef struct CPUArchState {
     uint32_t fpsr;
     bool fpsr_inex1;  /* live only with an in-flight decimal operand */
     float_status fp_status;
+    uint32_t fpiar;
 
     uint64_t mactmp;
     /*
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 21ebc198cd..18d5e6a98c 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -412,6 +412,23 @@ static const VMStateDescription vmstate_freg = {
     }
 };
 
+static bool fpu_fpiar_needed(void *opaque)
+{
+    M68kCPU *s = opaque;
+    return s->env.fpiar != 0;
+}
+
+static const VMStateDescription vmstate_fpiar = {
+    .name = "cpu/fpu/fpiar",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = fpu_fpiar_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(env.fpiar, M68kCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static int fpu_post_load(void *opaque, int version)
 {
     M68kCPU *s = opaque;
@@ -432,7 +449,11 @@ static const VMStateDescription vmstate_fpu = {
         VMSTATE_STRUCT_ARRAY(env.fregs, M68kCPU, 8, 0, vmstate_freg, FPReg),
         VMSTATE_STRUCT(env.fp_result, M68kCPU, 0, vmstate_freg, FPReg),
         VMSTATE_END_OF_LIST()
-    }
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_fpiar,
+        NULL
+    },
 };
 
 static bool cf_spregs_needed(void *opaque)
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 6e3bb96762..bc787cbf05 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -45,8 +45,8 @@ static int cf_fpu_gdb_get_reg(CPUState *cs, GByteArray *mem_buf, int n)
         return gdb_get_reg32(mem_buf, env->fpcr);
     case 9: /* fpstatus */
         return gdb_get_reg32(mem_buf, env->fpsr);
-    case 10: /* fpiar, not implemented */
-        return gdb_get_reg32(mem_buf, 0);
+    case 10: /* fpiar */
+        return gdb_get_reg32(mem_buf, env->fpiar);
     }
     return 0;
 }
@@ -69,7 +69,8 @@ static int cf_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
     case 9: /* fpstatus */
         env->fpsr = ldl_be_p(mem_buf);
         return 4;
-    case 10: /* fpiar, not implemented */
+    case 10: /* fpiar */
+        env->fpiar = ldl_p(mem_buf);
         return 4;
     }
     return 0;
@@ -91,8 +92,8 @@ static int m68k_fpu_gdb_get_reg(CPUState *cs, GByteArray *mem_buf, int n)
         return gdb_get_reg32(mem_buf, env->fpcr);
     case 9: /* fpstatus */
         return gdb_get_reg32(mem_buf, env->fpsr);
-    case 10: /* fpiar, not implemented */
-        return gdb_get_reg32(mem_buf, 0);
+    case 10: /* fpiar */
+        return gdb_get_reg32(mem_buf, env->fpiar);
     }
     return 0;
 }
@@ -114,7 +115,8 @@ static int m68k_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
     case 9: /* fpstatus */
         env->fpsr = ldl_be_p(mem_buf);
         return 4;
-    case 10: /* fpiar, not implemented */
+    case 10: /* fpiar */
+        env->fpiar = ldl_p(mem_buf);
         return 4;
     }
     return 0;
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 29e64d3908..fdda7aeb99 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4674,7 +4674,7 @@ static void gen_load_fcr(DisasContext *s, TCGv res, int reg)
 {
     switch (reg) {
     case M68K_FPIAR:
-        tcg_gen_movi_i32(res, 0);
+        tcg_gen_ld_i32(res, tcg_env, offsetof(CPUM68KState, fpiar));
         break;
     case M68K_FPSR:
         tcg_gen_ld_i32(res, tcg_env, offsetof(CPUM68KState, fpsr));
@@ -4689,6 +4689,7 @@ static void gen_store_fcr(DisasContext *s, TCGv val, int reg)
 {
     switch (reg) {
     case M68K_FPIAR:
+        tcg_gen_st_i32(val, tcg_env, offsetof(CPUM68KState, fpiar));
         break;
     case M68K_FPSR:
         tcg_gen_st_i32(val, tcg_env, offsetof(CPUM68KState, fpsr));
-- 
2.43.0


