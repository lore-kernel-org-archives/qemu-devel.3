Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19D6FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wICyy-0002S2-6U; Wed, 29 Apr 2026 18:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wICyw-0002Rs-VD
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:02:10 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wICyu-0006YZ-Tl
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:02:10 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2b461310af5so1178425ad.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777500127; x=1778104927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R7Wk5btcmFDHj4pe/s6HKx/H5jKdmVWvW8UZ5Xb+GWg=;
 b=rFAhLFVprmGzDGBUTUhzRtrfaGL7b6PldKuPfKjYy/AUq2pg4P1WwaqPinDIkhBGI8
 Wfi/N7wkJvW7++YeyFWgrtWy2a3TAKkgBp+nWscHaj6zHyUzG6rMFVee+Wd56lUjvmfi
 viKzESzQe8/8wRitIPw9uHE4WAJ6YvMbfTUGJg2G8OJ5cqLDlNxJ1VaAetGxbp1RAB2S
 D/B2Y0zOXri/Y5ApxLDmDVTgEydzjmpSsZPOyXCUxrhEXxm34IAg6sSgpnYgA2PZ3UHV
 3qOodjAjLtsxxA433f5jGM5gvpb1BeZ4T67PcjqtRwTJf5CNzzCDVfoytEjbntlPGuyv
 Z8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777500127; x=1778104927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R7Wk5btcmFDHj4pe/s6HKx/H5jKdmVWvW8UZ5Xb+GWg=;
 b=KfursUhb+sxgL8cXgRSJUdj41+gQlcDGrUjZgDN2tdND08vIv6nAM3Kz9pj0w4qdC8
 PlHPQ3NL42NmbBp0yVQ5yqkV3ovyv/tn+ADhtANHUhM8O73E846lQ4uezawkRQG6o46T
 NkZbQ+aweX3DJ+K/2FK83x2PR9uBha3yvIz4ByDMpst08AiD2GAm4w4C11uN0V3cF7Jy
 ix3lJma88QkyHgCQuq4vcngNttz4Io9Cp0TBzt0EcRmpclNSERIRNmXFBnIEy88KbhJl
 R9oEzdmn6WJ5t9p8D5G8WfkqhAD7r5Bl2d8ZfpoV4/6EvA/m6lzyAki7kioY+HWcX5ne
 2hYg==
X-Gm-Message-State: AOJu0YyIcsFrwL+B0CEZDwX5XeslM8bu35S9l/Vi+5CQVnnLJTP+SPoV
 dwNPT/5Z5P+jV1AzQ6l0QqMzmjD22oD8N5HaLPNW58YNNTv8Nymi5TnTHLbr+d6fbSCI5uRbkGq
 YUhWw6ek=
X-Gm-Gg: AeBDies7W5KNV6OexMoYt1xnB6gNN+qB0fAcfe1JoH51QHN+PfBn2u60nKZ59WY0B1a
 htrNBcSWuZDTEXDM/uLjWW/GyUOMVXJ7z+BHwI7/PdI5LQslFSCbcOagrDY4AWyW/oftmVB9/KK
 8vJq6kWwHVmVWjyWO354bmDKaaWxhfyG7mjfPYCFWFy5woY4jyvROz0f0Fl/jfb+UAELXNCoXHX
 o1WfLJ61uj0HQhhPUq7yU+jCsHUa4OwZ+PRG5gngRbkxPQujtlqVF+4XA+48B25waI5VBaG55qS
 eOfoaRbhbXItfDSm4fLzqwIM33+5LMeFFWkVioT/QNXxMYt3Y6kTH5YcdhlNZNACRoyJmylYdyt
 Dte0ac2TN3FcO3+OtjjmDT8rNd06ObyJ9MFeEiUfRanBD3/wEm9y9rDGPe+HtegMAuubKWWI3U1
 hnLVYyIjfr3pxN4MawPrnjs7HCtqq0pLauxTxy3P3/
X-Received: by 2002:a17:903:8cc:b0:2b4:6320:8d0a with SMTP id
 d9443c01a7336-2b9a2bc5474mr1054015ad.0.1777500127169; 
 Wed, 29 Apr 2026 15:02:07 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b98895ca58sm32162095ad.60.2026.04.29.15.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:02:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PULL 2/3] tcg/aarch64/tcg-target.c.inc: Manual replace of I3310,
 I3313
Date: Thu, 30 Apr 2026 08:01:54 +1000
Message-ID: <20260429220155.24546-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429220155.24546-1-richard.henderson@linaro.org>
References: <20260429220155.24546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jim MacArthur <jim.macarthur@linaro.org>

These are not formats in themselves, but extra constants to OR in with
the existing ldst_imm format.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260402-aarch64-tcg-instruction-format-rename2-v1-2-0998a08a515c@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 64 ++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 23d96a7960..cc9c2a5158 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -458,8 +458,9 @@ typedef enum {
     Ildst_imm_LDRVQ  = 0x3c000000 | 3 << 22 | 0 << 30,
     Ildst_imm_STRVQ  = 0x3c000000 | 2 << 22 | 0 << 30,
 
-    Ildst_imm_TO_I3310 = 0x00200800,
-    Ildst_imm_TO_I3313 = 0x01000000,
+    /* Additions to the ldst_imm format */
+    ldst_imm_to_reg  = 0x00200800,
+    ldst_imm_to_uimm = 0x01000000,
 
     /* Load/store register pair instructions.  */
     Ildstpair_LDP    = 0x28400000,
@@ -880,13 +881,13 @@ static void tcg_out_insn_qrr_e(TCGContext *s, AArch64Insn insn, bool q,
               | (rn & 0x1f) << 5 | (rd & 0x1f));
 }
 
-static void tcg_out_insn_3310(TCGContext *s, AArch64Insn insn,
-                              TCGReg rd, TCGReg base, TCGType ext,
-                              TCGReg regoff)
+static void tcg_out_insn_ldst_reg(TCGContext *s, AArch64Insn insn,
+                                  TCGReg rd, TCGReg base, TCGType ext,
+                                  TCGReg regoff)
 {
     /* Note the AArch64Insn constants above are for C3.3.12.  Adjust.  */
-    tcg_out32(s, insn | Ildst_imm_TO_I3310 | regoff << 16 |
-              0x4000 | ext << 13 | base << 5 | (rd & 0x1f));
+    tcg_out32(s, insn | ldst_imm_to_reg | regoff << 16 | 0x4000 | ext << 13 |
+              base << 5 | (rd & 0x1f));
 }
 
 static void tcg_out_insn_ldst_imm(TCGContext *s, AArch64Insn insn,
@@ -895,11 +896,11 @@ static void tcg_out_insn_ldst_imm(TCGContext *s, AArch64Insn insn,
     tcg_out32(s, insn | (offset & 0x1ff) << 12 | rn << 5 | (rd & 0x1f));
 }
 
-static void tcg_out_insn_3313(TCGContext *s, AArch64Insn insn,
-                              TCGReg rd, TCGReg rn, uintptr_t scaled_uimm)
+static void tcg_out_insn_ldst_uimm(TCGContext *s, AArch64Insn insn,
+                                   TCGReg rd, TCGReg rn, uintptr_t scaled_uimm)
 {
     /* Note the AArch64Insn constants above are for C3.3.12.  Adjust.  */
-    tcg_out32(s, insn | Ildst_imm_TO_I3313 | scaled_uimm << 10
+    tcg_out32(s, insn | ldst_imm_to_uimm | scaled_uimm << 10
               | rn << 5 | (rd & 0x1f));
 }
 
@@ -1203,9 +1204,6 @@ static void tcg_out_addi_ptr(TCGContext *s, TCGReg rd, TCGReg rs,
     g_assert_not_reached();
 }
 
-/* Define something more legible for general use.  */
-#define tcg_out_ldst_r  tcg_out_insn_3310
-
 static void tcg_out_ldst(TCGContext *s, AArch64Insn insn, TCGReg rd,
                          TCGReg rn, intptr_t offset, int lgsize)
 {
@@ -1214,7 +1212,7 @@ static void tcg_out_ldst(TCGContext *s, AArch64Insn insn, TCGReg rd,
     if (offset >= 0 && !(offset & ((1 << lgsize) - 1))) {
         uintptr_t scaled_uimm = offset >> lgsize;
         if (scaled_uimm <= 0xfff) {
-            tcg_out_insn_3313(s, insn, rd, rn, scaled_uimm);
+            tcg_out_insn_ldst_uimm(s, insn, rd, rn, scaled_uimm);
             return;
         }
     }
@@ -1227,7 +1225,7 @@ static void tcg_out_ldst(TCGContext *s, AArch64Insn insn, TCGReg rd,
 
     /* Worst-case scenario, move offset to temp register, use reg offset.  */
     tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, offset);
-    tcg_out_ldst_r(s, insn, rd, rn, TCG_TYPE_I64, TCG_REG_TMP0);
+    tcg_out_insn_ldst_reg(s, insn, rd, rn, TCG_TYPE_I64, TCG_REG_TMP0);
 }
 
 static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
@@ -1764,28 +1762,32 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, MemOp memop, TCGType ext,
 {
     switch (memop & MO_SSIZE) {
     case MO_UB:
-        tcg_out_ldst_r(s, Ildst_imm_LDRB, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_reg(s, Ildst_imm_LDRB, data_r, h.base,
+                              h.index_ext, h.index);
         break;
     case MO_SB:
-        tcg_out_ldst_r(s, ext ? Ildst_imm_LDRSBX : Ildst_imm_LDRSBW,
-                       data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_reg(s, ext ? Ildst_imm_LDRSBX : Ildst_imm_LDRSBW,
+                              data_r, h.base, h.index_ext, h.index);
         break;
     case MO_UW:
-        tcg_out_ldst_r(s, Ildst_imm_LDRH, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_reg(s, Ildst_imm_LDRH, data_r, h.base, h.index_ext,
+                              h.index);
         break;
     case MO_SW:
-        tcg_out_ldst_r(s, (ext ? Ildst_imm_LDRSHX : Ildst_imm_LDRSHW),
-                       data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_reg(s, ext ? Ildst_imm_LDRSHX : Ildst_imm_LDRSHW,
+                              data_r, h.base, h.index_ext, h.index);
         break;
     case MO_UL:
-        tcg_out_ldst_r(s, Ildst_imm_LDRW, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_reg(s, Ildst_imm_LDRW, data_r, h.base, h.index_ext,
+                              h.index);
         break;
     case MO_SL:
-        tcg_out_ldst_r(s, Ildst_imm_LDRSWX, data_r, h.base, h.index_ext,
-                       h.index);
+        tcg_out_insn_ldst_reg(s, Ildst_imm_LDRSWX, data_r, h.base, h.index_ext,
+                              h.index);
         break;
     case MO_UQ:
-        tcg_out_ldst_r(s, Ildst_imm_LDRX, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_reg(s, Ildst_imm_LDRX, data_r, h.base, h.index_ext,
+                              h.index);
         break;
     default:
         g_assert_not_reached();
@@ -1797,16 +1799,20 @@ static void tcg_out_qemu_st_direct(TCGContext *s, MemOp memop,
 {
     switch (memop & MO_SIZE) {
     case MO_8:
-        tcg_out_ldst_r(s, Ildst_imm_STRB, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_reg(s, Ildst_imm_STRB, data_r, h.base,
+                              h.index_ext, h.index);
         break;
     case MO_16:
-        tcg_out_ldst_r(s, Ildst_imm_STRH, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_reg(s, Ildst_imm_STRH, data_r, h.base,
+                              h.index_ext, h.index);
         break;
     case MO_32:
-        tcg_out_ldst_r(s, Ildst_imm_STRW, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_reg(s, Ildst_imm_STRW, data_r, h.base,
+                              h.index_ext, h.index);
         break;
     case MO_64:
-        tcg_out_ldst_r(s, Ildst_imm_STRX, data_r, h.base, h.index_ext, h.index);
+        tcg_out_insn_ldst_reg(s, Ildst_imm_STRX, data_r, h.base,
+                              h.index_ext, h.index);
         break;
     default:
         g_assert_not_reached();
-- 
2.43.0


