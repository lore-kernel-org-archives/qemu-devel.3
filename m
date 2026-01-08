Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE9FD1489F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdidM-00005H-Pr; Thu, 08 Jan 2026 00:32:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdicN-00082Z-JT
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:38 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdicL-0005XY-WF
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:31 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b553412a19bso1490706a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850289; x=1768455089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MdgLoN6x1cBTaJH7gh4cM0KUMVcgp66uVrMpd4cKO/c=;
 b=togyrYYbYTg8M7H4I5U4TX5d1C+uEfbEP7WykSSmEnMY1t91Ty0dzT0sMHAJecyIG6
 NWMpGqbf6BrzJdGq9GBltB/V1swFsOqmAk8eyPIvUQ6vvJ/tsf4xcCik0PVPg2+fcH46
 mb4S5J+A/umFq0cpe38UBqoCHMmBtG14R7D27xlEQuCKrXIBkRZ7I10fKAfTsGrKOh3C
 faIvOge7fh9uJWtBLC/S1tKBwIRxGs6vjRNOwd89otCdjXqAXFjKRHsMNMJHpsLkwync
 K4blhQHcvm06a+bHIiloucpivbWV6XD9QUdF8FZtmJrSbczotuuCXnaJpFnOHObBXqQ9
 AKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850289; x=1768455089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MdgLoN6x1cBTaJH7gh4cM0KUMVcgp66uVrMpd4cKO/c=;
 b=UPV230MXtpSGKVHyEj6mOdBwgZgqy8yaNZk9GUo6lodUht8IKbhLf7wR2LRDptFS1q
 lkYd1zeWzbfUC8Jq8RnG6zZwhViZpDucbVCBK3yUw0nKV2GgSWyXp2msRTcoRrIqY4FJ
 y//Yb/RgvABX/hOJGnLUPGZGjDfUHGUFmxx+pgKuGscsUWo+Izrv5KuewdOBNg80TW5p
 a2p7Xc2oZ8Nz3yuyecDAKP4ojwxS4AeinNC4ddkGcU9NV8M+blNNZk8DY3DGKVHLIlJh
 o9XvNiGYBpK+No9crYVDKnrUwcVZc6Ngmi76xNR/dMZ/JoXCgIho/sty4THEM4hZlU0k
 Ysmg==
X-Gm-Message-State: AOJu0Yz4HzjTUqkfVAslVTRRJdPOz43TvHzjTu33zTDDJZjFepoXqMhH
 IQbCiRNM+k3qC/4dQyZBaVi+xrKGSquzKbw5E7YxoBOWh5u+BGS1Cipkaeo0nBdwXHCi8xzsUYk
 WOSR9Yn0=
X-Gm-Gg: AY/fxX6Bm9MyxcZpGNSwDWWqSLxNyaqyU8TQtlg0wndUp4Q3flmHlYEBNTnPiQwsDKo
 I0YYonLZXFsX8RP02hxbGiQrDboX+H7Z+vfODjYXMssqdY5J+vsj8iHwEpm47Tm30E4GI/ZBJMg
 ES15l01Thodz9K18EfzjhUgRG3wDv9Fm9dGgVU5qXtbPDu7HjZ1+o7gqWDcCQPFQDnju1tFRxpE
 AB0tac9m7UOVZW46qeFW2rvRgR2pxztx5Aua1SyEGJiA0zP2pB6Egpz093RjfUFQZuKQekN4tKU
 MG5KpkiXi2H/AKmS3BP5L0qDnfZfRv76lpBQ8eJm6vZQHRiH8e4gZl/0yFmgKBshXQ9jJhZMENb
 LMdFKt5mSbwb9k5loVLfy1FlozaKg6T8f51eNHrd7RC/EPHWy+dSNvrh6SlFZoPTPIfh/rcSn1h
 Urdkvx5x7qeApjieOZGg==
X-Google-Smtp-Source: AGHT+IE1lNqfrhZIVuysOhSuDhmwiG+Ku6HG1cA8XpV6Zg49P0r0+xZiqA8J8TZOCl8KOvCGqploLg==
X-Received: by 2002:a05:6a21:27a2:b0:366:1926:1e1d with SMTP id
 adf61e73a8af0-3898f8f578amr3583919637.4.1767850288609; 
 Wed, 07 Jan 2026 21:31:28 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.31.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:31:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 33/50] target/riscv: Drop TCG_TARGET_REG_BITS test
Date: Thu,  8 Jan 2026 16:30:01 +1100
Message-ID: <20260108053018.626690-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 54 ++++++-------------------
 1 file changed, 13 insertions(+), 41 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index caefd38216..4df9a40b44 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1181,60 +1181,32 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
      * Update vstart with the number of processed elements.
      * Use the helper function if either:
      * - vstart is not 0.
-     * - the target has 32 bit registers and we are loading/storing 64 bit long
-     *   elements. This is to ensure that we process every element with a single
-     *   memory instruction.
      */
 
-    bool use_helper_fn = !(s->vstart_eq_zero) ||
-                          (TCG_TARGET_REG_BITS == 32 && log2_esz == 3);
+    bool use_helper_fn = !s->vstart_eq_zero;
 
     if (!use_helper_fn) {
-        TCGv addr = tcg_temp_new();
         uint32_t size = s->cfg_ptr->vlenb * nf;
         TCGv_i64 t8 = tcg_temp_new_i64();
-        TCGv_i32 t4 = tcg_temp_new_i32();
         MemOp atomicity = MO_ATOM_NONE;
         if (log2_esz == 0) {
             atomicity = MO_ATOM_NONE;
         } else {
             atomicity = MO_ATOM_IFALIGN_PAIR;
         }
-        if (TCG_TARGET_REG_BITS == 64) {
-            for (int i = 0; i < size; i += 8) {
-                addr = get_address(s, rs1, i);
-                if (is_load) {
-                    tcg_gen_qemu_ld_i64(t8, addr, s->mem_idx,
-                            MO_LE | MO_64 | atomicity);
-                    tcg_gen_st_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
-                } else {
-                    tcg_gen_ld_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
-                    tcg_gen_qemu_st_i64(t8, addr, s->mem_idx,
-                            MO_LE | MO_64 | atomicity);
-                }
-                if (i == size - 8) {
-                    tcg_gen_movi_tl(cpu_vstart, 0);
-                } else {
-                    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 8 >> log2_esz);
-                }
+        for (int i = 0; i < size; i += 8) {
+            TCGv addr = get_address(s, rs1, i);
+            if (is_load) {
+                tcg_gen_qemu_ld_i64(t8, addr, s->mem_idx, MO_LEUQ | atomicity);
+                tcg_gen_st_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
+            } else {
+                tcg_gen_ld_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
+                tcg_gen_qemu_st_i64(t8, addr, s->mem_idx, MO_LEUQ | atomicity);
             }
-        } else {
-            for (int i = 0; i < size; i += 4) {
-                addr = get_address(s, rs1, i);
-                if (is_load) {
-                    tcg_gen_qemu_ld_i32(t4, addr, s->mem_idx,
-                            MO_LE | MO_32 | atomicity);
-                    tcg_gen_st_i32(t4, tcg_env, vreg_ofs(s, vd) + i);
-                } else {
-                    tcg_gen_ld_i32(t4, tcg_env, vreg_ofs(s, vd) + i);
-                    tcg_gen_qemu_st_i32(t4, addr, s->mem_idx,
-                            MO_LE | MO_32 | atomicity);
-                }
-                if (i == size - 4) {
-                    tcg_gen_movi_tl(cpu_vstart, 0);
-                } else {
-                    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 4 >> log2_esz);
-                }
+            if (i == size - 8) {
+                tcg_gen_movi_tl(cpu_vstart, 0);
+            } else {
+                tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 8 >> log2_esz);
             }
         }
     } else {
-- 
2.43.0


