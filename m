Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CF2ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniC5-0005QW-6g; Mon, 09 Sep 2024 13:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniC0-00051q-7y
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:48 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBy-00064D-Eh
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:47 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2055136b612so55185945ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902925; x=1726507725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OgSS4vpluCfU+sZVifaIEPstx7ZGy8wKpnske9+/2+o=;
 b=XQg+f6Hb59TBBnna97CzjZIZMmHN4O3Go+eORgObPo3gDToOZr94tegIQvamxG5daB
 v0jWrqoQEps0BxRcQKeaIGNa72jhkqNahBaA9t/V7m033zz5emcIkT8f02ZLpDiX0/x8
 eWiwJOcpNUUeUeE9od52WExxpXyp//8fLdG8VVBHrKUR5bUr7AnftCnXZNEnOKNLp76B
 CrmI5arAHMM4JeK7zz1EhyrHcRiFd9cJTW7qbbBn84615A4rKNmkb5gJaAKSPxwBLkzH
 yJFozI7aELZKBzzXVuYNqeWRslXmtB8XEmHEbyA6wcxVnzLFQK84PM5Ucc+YcmzpRZlL
 pqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902925; x=1726507725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OgSS4vpluCfU+sZVifaIEPstx7ZGy8wKpnske9+/2+o=;
 b=CjAr+2Fp5XZlzdB+K8V2TyRWc0RiGa/WY3K0VOVAgobyKMdXNxa2lV026X6VAZHR3W
 p29kr61W5FlIzBCOn7Mto/qnydbl6bg1deyUElOlb3nHO713n2Ck8N9CSUWCrQWJOVm3
 0S3rXqGqdIXDzpFdRZP+EfnTTGu4Nmy/7YJaCWa59clRfUY8VkOb/zrAMKtLdZrOFPIw
 cSsXWcii3Go1xwawCpSsg1j5bgyDFFgzWQAZF4kdv+UjFb6cOXeEzAalNCsQVc5uHmvu
 LDHqhiUIk6a3+IpwUtMLXk3SUEPuGW3Q2glyEsgImBme5Cs2LUzNRiUowmfgMxGkXu/F
 5Grg==
X-Gm-Message-State: AOJu0YzRB8sjw5n2yEwYJMewIy7W/+h4N6phbLAzmMnao40A14BEbixT
 aEFtyQ2yVlOglobJ8GuVNh3c68jITxowjZTuImSkbDmrwV+kClhEyGNWIbNbVxjBQ6aLrgsdokm
 I
X-Google-Smtp-Source: AGHT+IHpEWdxNXtr9X4V/qQH5insJ1EKmTQxp9MTzAtV/2gNza20aNTFkKk7AERHB/vj12KRNphi7w==
X-Received: by 2002:a17:902:e5ca:b0:202:60e:7700 with SMTP id
 d9443c01a7336-206f04c9985mr200281375ad.7.1725902925094; 
 Mon, 09 Sep 2024 10:28:45 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 22/26] target/m68k: Merge gen_store_fp, gen_store_mode_fp
Date: Mon,  9 Sep 2024 10:28:19 -0700
Message-ID: <20240909172823.649837-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

This enables the exceptions raised by the actual store
to be reflected as a failure.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 107 ++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 54 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index e966d2c929..9b1d39d7df 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -901,53 +901,6 @@ static void gen_fp_move(TCGv_ptr dest, TCGv_ptr src)
     tcg_gen_st_i64(t64, dest, offsetof(FPReg, l.lower));
 }
 
-static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
-                         int index)
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
-        gen_helper_reds32(tmp, tcg_env, fp);
-        tcg_gen_qemu_st_tl(tmp, addr, index, opsize | MO_TE);
-        break;
-    case OS_SINGLE:
-        gen_helper_redf32(tmp, tcg_env, fp);
-        tcg_gen_qemu_st_tl(tmp, addr, index, MO_TEUL);
-        break;
-    case OS_DOUBLE:
-        gen_helper_redf64(t64, tcg_env, fp);
-        tcg_gen_qemu_st_i64(t64, addr, index, MO_TEUQ);
-        break;
-    case OS_EXTENDED:
-        if (m68k_feature(s->env, M68K_FEATURE_CF_FPU)) {
-            gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
-            break;
-        }
-        tcg_gen_ld16u_i32(tmp, fp, offsetof(FPReg, l.upper));
-        tcg_gen_shli_i32(tmp, tmp, 16);
-        tcg_gen_qemu_st_i32(tmp, addr, index, MO_TEUL);
-        tcg_gen_addi_i32(tmp, addr, 4);
-        tcg_gen_ld_i64(t64, fp, offsetof(FPReg, l.lower));
-        tcg_gen_qemu_st_i64(t64, tmp, index, MO_TEUQ);
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
 static bool gen_load_fp(DisasContext *s, uint16_t insn, int opsize,
                         TCGv_ptr fp, int index)
 {
@@ -1087,12 +1040,13 @@ static bool gen_load_fp(DisasContext *s, uint16_t insn, int opsize,
     return true;
 }
 
-static bool gen_store_mode_fp(DisasContext *s, uint16_t insn, int opsize,
-                              TCGv_ptr fp, int index)
+static bool gen_store_fp(DisasContext *s, uint16_t insn, int opsize,
+                         TCGv_ptr fp, int index)
 {
     int mode = extract32(insn, 3, 3);
     int reg0 = REG(insn, 0);
-    TCGv reg, addr;
+    TCGv reg, addr, tmp;
+    TCGv_i64 t64;
 
     switch (mode) {
     case 0: /* Data register direct.  */
@@ -1126,10 +1080,55 @@ static bool gen_store_mode_fp(DisasContext *s, uint16_t insn, int opsize,
             gen_addr_fault(s);
             return false;
         }
-        gen_store_fp(s, opsize, addr, fp, index);
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
+        gen_helper_reds32(tmp, tcg_env, fp);
+        tcg_gen_qemu_st_tl(tmp, addr, index, opsize | MO_TE);
+        break;
+    case OS_SINGLE:
+        tmp = tcg_temp_new();
+        gen_helper_redf32(tmp, tcg_env, fp);
+        tcg_gen_qemu_st_tl(tmp, addr, index, MO_TEUL);
+        break;
+    case OS_DOUBLE:
+        t64 = tcg_temp_new_i64();
+        gen_helper_redf64(t64, tcg_env, fp);
+        tcg_gen_qemu_st_i64(t64, addr, index, MO_TEUQ);
+        break;
+    case OS_EXTENDED:
+        if (m68k_feature(s->env, M68K_FEATURE_CF_FPU)) {
+            gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
+            return false;
+        }
+        tmp = tcg_temp_new();
+        t64 = tcg_temp_new_i64();
+        tcg_gen_ld16u_i32(tmp, fp, offsetof(FPReg, l.upper));
+        tcg_gen_shli_i32(tmp, tmp, 16);
+        tcg_gen_qemu_st_i32(tmp, addr, index, MO_TEUL);
+        tcg_gen_addi_i32(addr, addr, 4);
+        tcg_gen_ld_i64(t64, fp, offsetof(FPReg, l.lower));
+        tcg_gen_qemu_st_i64(t64, addr, index, MO_TEUQ);
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
 
 typedef struct {
@@ -4889,7 +4888,7 @@ DISAS_INSN(fpu)
     case 3: /* fmove out */
         cpu_src = gen_fp_ptr(REG(ext, 7));
         opsize = ext_opsize(ext, 10);
-        if (gen_store_mode_fp(s, insn, opsize, cpu_src, IS_USER(s))) {
+        if (gen_store_fp(s, insn, opsize, cpu_src, IS_USER(s))) {
             gen_helper_update_fpsr(tcg_env, cpu_src);
         }
         return;
-- 
2.43.0


