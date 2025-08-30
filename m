Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410ADCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNsX-0004OC-9H; Sat, 30 Aug 2025 11:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usCRO-00055X-ID
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 23:39:46 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usCRM-00053t-OS
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 23:39:46 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b4cf40cd0d1so1145089a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 20:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756525183; x=1757129983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nAYrTiHACzTy9Y3gPDsiHUk0bVXAiu9l8x+fFNC+2QA=;
 b=bHAg+pwVRO+ll8WZuWa6fx2Y83cvDzHEmu8edWHLMKdAdb2EJCnw/kcPTSRcI5QwT5
 4SwchTNH55iABizBvQz95tTUjwvlnbmjACUSWDrtJUGivWCemvo7F4A72BDEPTZxQ7w1
 ZKj52/nnsETtvifBiP7j3Qr7y1pcZxMDxy8LppOWUStexlZTQg7S6Rj+c/Xe4dLpE6qP
 dBJ+RDffe58IA6myKqm91ANq+Fb2/OugoOE0dz+DX39xlI1ZhlmzvqQLBHmnYzu5VHQB
 1gA1MrDO6pRj2G5zUaZyRArBjAdr2GKBwXVPakhM9i5WxU2fJmmE2zBEtvXsdGgmwMIE
 TFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756525183; x=1757129983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nAYrTiHACzTy9Y3gPDsiHUk0bVXAiu9l8x+fFNC+2QA=;
 b=LkGTLHYi2+Mc97ewPbJgklLg1cvhYpTuZEbXV2Xvm8H3m0a9ZJczzU8hBeecT405QJ
 iJ3PoIKWhgGafC2TyWXbqB0T6nWA3+R5peNU/M82sJWuLrb6whdeXh9XoxUi4OlkIhHo
 /lJXegS8eaWDNP4JLbFGHcI3Llr6oSCeZxat9Opbv+IdN/GmQxCs8MVrx92fwFg6z6kF
 ltrrRA/PAMlaMtANs1zgpTgxPUg7IXLJpJ9ZcO9juli7mZUZHBFGASrmbFvRSbCDJ3t3
 wZlqjRGqgEui+H26K/4xS4EBGuhRm8V+qyA+UVi0Y4xogXKIZPKRZJ8CXJgfXE8zLhpI
 bMig==
X-Gm-Message-State: AOJu0YworDz4h5JSinX8sZjcgEqJvDP2xRJlRiE3hQTc0bFirMlrkio9
 TxUyZspgz/YtHAnDEuBbIJ+2fYnvnTYjckosEUItGnO4tc79aL9lE43+dFHGWjyCwsF0X8o0jwv
 x6x1lFyE=
X-Gm-Gg: ASbGncuRf01pu6WTqheG1ktR219vZObxE7L6EKGr0CeTmFkAa29r4YkmdNlRH8vgtsw
 fiocCnYKDl+3xWrmXTjpV6hB3zS0vheEfuPaAUgLHiPjw2SpigQxws57KkLlt59XhBmjV9x0bds
 wBom4xi23uiQ5Bemjvroq2L6Wqr6O8SwyUBxTGUc0SI4AXcXgGJdCpK1MxTEwTUaJv1W/XiKpgF
 cZHUoz+vdC1Q6B0omXCW70RRLLY5XOvvrzeacCefLNauxAVZOeji3IwloRd7dW+mIT5keFvShMH
 V9qihSn14WHIK+vvbdxedXf38oX4aCOGvHrS4m62tju8A6adEg7auBO1B8y3qDj4GP6nks46Tgt
 km6PEOsuDOd2cQxNCzHnD8jaMyhVo0K25wL0KXGeNvcZZTZhid+r+WTZMVos/QPM=
X-Google-Smtp-Source: AGHT+IGz6szenwtmKvZg41WMGRsbkPwl7zGz5EjJTwckeYYOpYBmbos+I8D5v/8D3ZI3G890rZKSpA==
X-Received: by 2002:a17:903:ac8:b0:248:7878:cee9 with SMTP id
 d9443c01a7336-24944ad05a0mr8941335ad.42.1756525183134; 
 Fri, 29 Aug 2025 20:39:43 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24905da4784sm39551685ad.90.2025.08.29.20.39.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 20:39:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] tcg/i386: Use vgf2p8affineqb for MO_8 vector shifts
Date: Sat, 30 Aug 2025 13:39:26 +1000
Message-ID: <20250830033926.372955-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830033926.372955-1-richard.henderson@linaro.org>
References: <20250830033926.372955-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

A constant matrix can describe the movement of the 8 bits,
so these shifts can be performed with one instruction.

Logic courtesy of Andi Kleen <ak@linux.intel.com>:
https://gcc.gnu.org/pipermail/gcc-patches/2025-August/691624.html

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 75 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 4 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index efaca0ca67..ee27266861 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -4342,12 +4342,46 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     }
 }
 
+static void gen_vgf2p8affineqb0(TCGType type, TCGv_vec v0,
+                                TCGv_vec v1, uint64_t matrix)
+{
+    vec_gen_4(INDEX_op_x86_vgf2p8affineqb_vec, type, MO_8,
+              tcgv_vec_arg(v0), tcgv_vec_arg(v1),
+              tcgv_vec_arg(tcg_constant_vec(type, MO_64, matrix)), 0);
+}
+
 static void expand_vec_shi(TCGType type, unsigned vece, bool right,
                            TCGv_vec v0, TCGv_vec v1, TCGArg imm)
 {
+    static const uint64_t gf2_shi[2][8] = {
+        /* left shift */
+        { 0,
+          0x0001020408102040ull,
+          0x0000010204081020ull,
+          0x0000000102040810ull,
+          0x0000000001020408ull,
+          0x0000000000010204ull,
+          0x0000000000000102ull,
+          0x0000000000000001ull },
+        /* right shift */
+        { 0,
+          0x0204081020408000ull,
+          0x0408102040800000ull,
+          0x0810204080000000ull,
+          0x1020408000000000ull,
+          0x2040800000000000ull,
+          0x4080000000000000ull,
+          0x8000000000000000ull }
+    };
     uint8_t mask;
 
     tcg_debug_assert(vece == MO_8);
+
+    if (cpuinfo & CPUINFO_GFNI) {
+        gen_vgf2p8affineqb0(type, v0, v1, gf2_shi[right][imm]);
+        return;
+    }
+
     if (right) {
         mask = 0xff >> imm;
         tcg_gen_shri_vec(MO_16, v0, v1, imm);
@@ -4361,6 +4395,16 @@ static void expand_vec_shi(TCGType type, unsigned vece, bool right,
 static void expand_vec_sari(TCGType type, unsigned vece,
                             TCGv_vec v0, TCGv_vec v1, TCGArg imm)
 {
+    static const uint64_t gf2_sar[8] = {
+        0,
+        0x0204081020408080ull,
+        0x0408102040808080ull,
+        0x0810204080808080ull,
+        0x1020408080808080ull,
+        0x2040808080808080ull,
+        0x4080808080808080ull,
+        0x8080808080808080ull,
+    };
     TCGv_vec t1, t2;
 
     if (imm >= (8 << vece) - 1) {
@@ -4371,6 +4415,11 @@ static void expand_vec_sari(TCGType type, unsigned vece,
 
     switch (vece) {
     case MO_8:
+        if (cpuinfo & CPUINFO_GFNI) {
+            gen_vgf2p8affineqb0(type, v0, v1, gf2_sar[imm]);
+            break;
+        }
+
         /* Unpack to 16-bit, shift, and repack.  */
         t1 = tcg_temp_new_vec(type);
         t2 = tcg_temp_new_vec(type);
@@ -4422,12 +4471,30 @@ static void expand_vec_sari(TCGType type, unsigned vece,
 static void expand_vec_rotli(TCGType type, unsigned vece,
                              TCGv_vec v0, TCGv_vec v1, TCGArg imm)
 {
+    static const uint64_t gf2_rol[8] = {
+        0,
+        0x8001020408102040ull,
+        0x4080010204081020ull,
+        0x2040800102040810ull,
+        0x1020408001020408ull,
+        0x0810204080010204ull,
+        0x0408102040800102ull,
+        0x0204081020408001ull,
+    };
     TCGv_vec t;
 
-    if (vece != MO_8 && have_avx512vbmi2) {
-        vec_gen_4(INDEX_op_x86_vpshldi_vec, type, vece,
-                  tcgv_vec_arg(v0), tcgv_vec_arg(v1), tcgv_vec_arg(v1), imm);
-        return;
+    if (vece == MO_8) {
+        if (cpuinfo & CPUINFO_GFNI) {
+            gen_vgf2p8affineqb0(type, v0, v1, gf2_rol[imm]);
+            return;
+        }
+    } else {
+        if (have_avx512vbmi2) {
+            vec_gen_4(INDEX_op_x86_vpshldi_vec, type, vece,
+                      tcgv_vec_arg(v0), tcgv_vec_arg(v1),
+                      tcgv_vec_arg(v1), imm);
+            return;
+        }
     }
 
     t = tcg_temp_new_vec(type);
-- 
2.43.0


