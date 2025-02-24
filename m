Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5A2C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc3I-00079O-DJ; Mon, 24 Feb 2025 12:15:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc34-000756-Fe
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:18 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc30-0005n3-B5
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:17 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22114b800f7so92451335ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417312; x=1741022112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sP3MiI/R5fBBqm7rHp/ZeTQAN7ydNNsQ2qvXr3+RxNg=;
 b=nXsdO3oh6v13LtADw4nLoQRKm+pjmcWQSeKVKEkDH0kcVeL4Bi71sQ+l4kcIWe57vA
 Q3nIpYeuhEcCROHZEe8mGq3dzFJgqL+iOXivUH/hh7nBWCcHd8n4/u+2CjEMhEFpuIMg
 tSOoFXnMl1NC0rJsuCYnUGZX0hBf8Kg5v7wp+WKUCXVmkmfEDZdQIaNIiS8q54HnbxEe
 ut5DGWz3Dl5AAfJTh2/PFCY3ejYszR1SLBnlDEFmimWMkbhF5ZEiFkA7CMU8Ur1ylyX5
 z//yhPGvCwI7e4rpVBRF2X0Tiy0GrNAOCeitp4ZC48YLQ4P6yo+5q8UBlYucxArMUWMi
 /Ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417312; x=1741022112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sP3MiI/R5fBBqm7rHp/ZeTQAN7ydNNsQ2qvXr3+RxNg=;
 b=H7StBiH4yRI7cqQZsICuQGcpjhIJA27pSIk+Lxdi/sEfqs7cGixSK5LSj6HWTpCCxM
 OLupSODcA7ZCGOYc/k+fgs9QWhnri2MhVf4vnbgmB6Vhujr4RGKck7q7RXhO85UNODeY
 rRnsWlvUWpH3AXnS9PfR82IPwFLdxwiwXixxijwH/uRKbWyytSw5jhBe62jFMMm2vlcm
 vco1u4l1SUIyrarSvE8uNlYR2z0KtnRs53uqVrBzKT45Ti1bJQ6VAGWKbPTFyhcXjuQy
 3SDT+bafKQlQuiOQQ6It+2OZr0UTTKUWzTXhiXIbQzJkVt4lTLmHOUhcbdtx6WVImPDM
 0fFA==
X-Gm-Message-State: AOJu0YzAOoDFqz8Tn7gaMGpC7RAnlwpJc+KWoNWgqFyxFUCbyF7mlfdq
 XojfNSu0maaaBDsFpLln2+IURkuML9nSVgrLnT0+OMZdrpndC1nGjUlPf+pT2M5pc3efA0O+Pm2
 C
X-Gm-Gg: ASbGnctvHqiQaEe2YIzCL7SgUyqWq5/LtcyW+Vyk23mBpTgovu+IO8rIqyXjG9LJzo5
 bEnyhzo4xxmSQJBBlpo/2ecUx6eSe8IS0ph2p4SXsTkDIxxynA6rCExorla+Ib1uRPq1xk1whRZ
 vMiYO8eyTddJ2kf+jQ2VfBu3KLT/jDKJLXKV+HRJQIShmVFw3kHyVcEdH4OxlFCfA/W2lCQcTDk
 0S2i59CqgNQj7kUIlpnuZuyZyLSeX2KbmjzrQHNhDKZc8CiBPG560mAf3SFa2WS9i4QpGMnSqnn
 ReCRsUFbYTIZ5LknInKtZ0WiCcgi42DXoms=
X-Google-Smtp-Source: AGHT+IHt5hOGs8BcJNFMww5xGllOX8B0f52sMybdw/q9ANhGCd7LPSEU8subbs3fo4eNwAzx5RZQzw==
X-Received: by 2002:a05:6a00:17a4:b0:730:75b1:720c with SMTP id
 d2e1a72fcca58-73426d96c7amr21809874b3a.23.1740417311713; 
 Mon, 24 Feb 2025 09:15:11 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:15:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 19/24] target/m68k: Merge gen_load_fp, gen_load_mode_fp
Date: Mon, 24 Feb 2025 09:14:39 -0800
Message-ID: <20250224171444.440135-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224171444.440135-1-richard.henderson@linaro.org>
References: <20250224171444.440135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

This enables the exceptions raised by the actual load
to be reflected as a failure.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 104 ++++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 53 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 69e1118aa1..47311a8579 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -902,53 +902,6 @@ static void gen_fp_move(TCGv_ptr dest, TCGv_ptr src)
     tcg_gen_st_i64(t64, dest, offsetof(FPReg, l.lower));
 }
 
-static void gen_load_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
-                        int index)
-{
-    TCGv tmp;
-    TCGv_i64 t64;
-
-    t64 = tcg_temp_new_i64();
-    tmp = tcg_temp_new();
-    switch (opsize) {
-    case OS_BYTE:
-    case OS_WORD:
-    case OS_LONG:
-        tcg_gen_qemu_ld_tl(tmp, addr, index, opsize | MO_SIGN | MO_TE);
-        gen_helper_exts32(tcg_env, fp, tmp);
-        break;
-    case OS_SINGLE:
-        tcg_gen_qemu_ld_tl(tmp, addr, index, MO_TEUL);
-        gen_helper_extf32(tcg_env, fp, tmp);
-        break;
-    case OS_DOUBLE:
-        tcg_gen_qemu_ld_i64(t64, addr, index, MO_TEUQ);
-        gen_helper_extf64(tcg_env, fp, t64);
-        break;
-    case OS_EXTENDED:
-        if (m68k_feature(s->env, M68K_FEATURE_CF_FPU)) {
-            gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
-            break;
-        }
-        tcg_gen_qemu_ld_i32(tmp, addr, index, MO_TEUL);
-        tcg_gen_shri_i32(tmp, tmp, 16);
-        tcg_gen_st16_i32(tmp, fp, offsetof(FPReg, l.upper));
-        tcg_gen_addi_i32(tmp, addr, 4);
-        tcg_gen_qemu_ld_i64(t64, tmp, index, MO_TEUQ);
-        tcg_gen_st_i64(t64, fp, offsetof(FPReg, l.lower));
-        break;
-    case OS_PACKED:
-        /*
-         * unimplemented data type on 68040/ColdFire
-         * FIXME if needed for another FPU
-         */
-        gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
                          int index)
 {
@@ -996,8 +949,8 @@ static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
     }
 }
 
-static bool gen_load_mode_fp(DisasContext *s, uint16_t insn, int opsize,
-                             TCGv_ptr fp, int index)
+static bool gen_load_fp(DisasContext *s, uint16_t insn, int opsize,
+                        TCGv_ptr fp, int index)
 {
     int mode = extract32(insn, 3, 3);
     int reg0 = REG(insn, 0);
@@ -1084,10 +1037,55 @@ static bool gen_load_mode_fp(DisasContext *s, uint16_t insn, int opsize,
             gen_addr_fault(s);
             return false;
         }
-        gen_load_fp(s, opsize, addr, fp, index);
-        return true;
+        break;
+
+    default:
+        g_assert_not_reached();
     }
-    g_assert_not_reached();
+
+    switch (opsize) {
+    case OS_BYTE:
+    case OS_WORD:
+    case OS_LONG:
+        tmp = tcg_temp_new();
+        tcg_gen_qemu_ld_tl(tmp, addr, index, opsize | MO_SIGN | MO_TE);
+        gen_helper_exts32(tcg_env, fp, tmp);
+        break;
+    case OS_SINGLE:
+        tmp = tcg_temp_new();
+        tcg_gen_qemu_ld_tl(tmp, addr, index, MO_TEUL);
+        gen_helper_extf32(tcg_env, fp, tmp);
+        break;
+    case OS_DOUBLE:
+        t64 = tcg_temp_new_i64();
+        tcg_gen_qemu_ld_i64(t64, addr, index, MO_TEUQ);
+        gen_helper_extf64(tcg_env, fp, t64);
+        break;
+    case OS_EXTENDED:
+        if (m68k_feature(s->env, M68K_FEATURE_CF_FPU)) {
+            gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
+            return false;
+        }
+        tmp = tcg_temp_new();
+        t64 = tcg_temp_new_i64();
+        tcg_gen_qemu_ld_i32(tmp, addr, index, MO_TEUL);
+        tcg_gen_addi_i32(addr, addr, 4);
+        tcg_gen_qemu_ld_i64(t64, addr, index, MO_TEUQ);
+        tcg_gen_shri_i32(tmp, tmp, 16);
+        tcg_gen_st16_i32(tmp, fp, offsetof(FPReg, l.upper));
+        tcg_gen_st_i64(t64, fp, offsetof(FPReg, l.lower));
+        break;
+    case OS_PACKED:
+        /*
+         * unimplemented data type on 68040/ColdFire
+         * FIXME if needed for another FPU
+         */
+        gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
+        return false;
+    default:
+        g_assert_not_reached();
+    }
+    return true;
 }
 
 static bool gen_store_mode_fp(DisasContext *s, uint16_t insn, int opsize,
@@ -4911,7 +4909,7 @@ DISAS_INSN(fpu)
         /* Source effective address.  */
         opsize = ext_opsize(ext, 10);
         cpu_src = gen_fp_result_ptr();
-        if (!gen_load_mode_fp(s, insn, opsize, cpu_src, IS_USER(s))) {
+        if (!gen_load_fp(s, insn, opsize, cpu_src, IS_USER(s))) {
             return;
         }
     } else {
-- 
2.43.0


