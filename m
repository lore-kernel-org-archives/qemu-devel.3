Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199FAECE584
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniC4-0005Mc-Ki; Mon, 09 Sep 2024 13:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBz-0004zq-Li
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:48 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBx-000643-9o
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:47 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20543fdb7acso31749265ad.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902924; x=1726507724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IVrsW+o3FMgR3VpWI1k5gdQknpFqVu925X71ufmaWs0=;
 b=N2vxc4UUsy+T8XRSG/OH953qawfbJ36AN+SDxOihMj1uEwXqbxz1J4tcii+KrElJgR
 i3sRFYL4h2WuNGos3lYZLtyijREeuEyYsRcE0x7SGytm/rIz4aNm3p/exGDxC3kHud4c
 PHov+sSja3kiJ91iAIWS0sphdmYgOl9AYP5tw2EIsAlVhzn0+dxzVVd3+Akx9b24XJ7H
 7HLiPwK435rGCIrEKZo9B8nw5aUjyynf+14zuNPJNYX+GABNUJ00e7ydxbNZo58KfAuO
 0+pLgtksRUXDjgtmfgaGyrqe0ga5vHZlPXaoTVesCg/DlkXxrkvS+KItTvxE5MmXgrtx
 4jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902924; x=1726507724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IVrsW+o3FMgR3VpWI1k5gdQknpFqVu925X71ufmaWs0=;
 b=wnMfgpOhM/ZGNT3C5VVJekYnhCZFzR3gslyr1UVtblw2DYshHbjBA7ygpHAcNyVRCh
 epDvWWT4kQbJk4cuXs5AKUii/4ObRM3hq5MahaDMP9yNV9rG9U5loCoIQ9O4fLNtjkvK
 Fe67knW3UUO2paPgAQ5yCJFVPiWySpKYC07Q3UZqnZyNt3X+GaTd6BdUbuLQDmXAs27F
 WA2xnNKtHXHeETI0AlcnUwNw/Srznfd4iXnqj1w6d7qn9aXY/gtwsVRjZSOjBERyIg+d
 2sNW7+ItiitFv2xmCAxn7PsIlb4HMe5nLh0PNVj9Z9Xpdz+y/mZ5uhwMT8ZGEr9WWSc+
 f0Sw==
X-Gm-Message-State: AOJu0YxbLfQzORWYLjRJEuPJJMcabH6cMphhrs2mfhi3/XKwedwwLjlj
 qNn5QL6q+kkrWLVOmAUakbDFEKtbWNJ/3qWImZW0zQ/7xWVOce9oMV0AC+iP8YWyvufYin0W0uX
 S
X-Google-Smtp-Source: AGHT+IFXJD+ataaLMgV8niKGD6kVjHer/7ZL6KW5ck7HBUMsTeusaXbauvHUQ1Eko1QZAqgH5KqG2A==
X-Received: by 2002:a17:903:22d0:b0:206:cbf0:3089 with SMTP id
 d9443c01a7336-206f062366emr118764175ad.54.1725902924060; 
 Mon, 09 Sep 2024 10:28:44 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 21/26] target/m68k: Merge gen_load_fp, gen_load_mode_fp
Date: Mon,  9 Sep 2024 10:28:18 -0700
Message-ID: <20240909172823.649837-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 104 ++++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 53 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index df886ed062..e966d2c929 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -901,53 +901,6 @@ static void gen_fp_move(TCGv_ptr dest, TCGv_ptr src)
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
@@ -995,8 +948,8 @@ static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
     }
 }
 
-static bool gen_load_mode_fp(DisasContext *s, uint16_t insn, int opsize,
-                             TCGv_ptr fp, int index)
+static bool gen_load_fp(DisasContext *s, uint16_t insn, int opsize,
+                        TCGv_ptr fp, int index)
 {
     int mode = extract32(insn, 3, 3);
     int reg0 = REG(insn, 0);
@@ -1083,10 +1036,55 @@ static bool gen_load_mode_fp(DisasContext *s, uint16_t insn, int opsize,
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


