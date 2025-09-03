Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00807CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utn7x-0005L8-D9; Wed, 03 Sep 2025 09:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1utn7i-0005Au-IT
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:02:02 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1utn7g-0000Wb-8z
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:02:02 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-32b5d8bea85so724414a91.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 06:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1756904518; x=1757509318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nd1CFSqBPyT+ku8Fo0AM5AoNQDImOsroqwPkGFgKXHQ=;
 b=de+isoOYET3e5C/ApOgOOiwNPyKnWNobY/seSedXwM5ttNRzFSzdf0Aa6suLQcXq7r
 W9xIIh8dD+5PiOvUv/MsnagfHYyBuqtD1ZM1d7UeD1OJD1KLsGz8zC3knhRRtFQUAsPT
 8e3ZcC8n4QJ3BiKBuIqJfnAxH6+kqgQdSyE1wcv4K/L2le0y9R3ASt+HKlHd3qYwMK2s
 pNk186B0s5EEbFmFawVqYYW58M+cUMOflxiCq09HMuhB0ceYT47Y9Fu7jP8rsG5engXk
 dMYhJDdkwhsfMtLU0pY6Val10d5dMLj3KPVjxM9Nch0qwqkjhP4UZFJHeSTX7sTjlO8b
 JflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756904518; x=1757509318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nd1CFSqBPyT+ku8Fo0AM5AoNQDImOsroqwPkGFgKXHQ=;
 b=jW5l4WcWtZu511sYBNZgiOb8i8fwQOWRE6c9MPq3BzXbaZMFVw8JmoU9KKuJHMl/es
 tOOxFZZbVGuZyXNyg9sLAINDlywPW9i/QynsP6Hoql/2Mc9sXeTmRkgdxdxAC7JOdD/H
 kis47Crtp3mGEhwjur5dac/jQFjGbq7Ij+zKs0hkmoGT8IJbFJuvzE8A6xlGEnIs3+n2
 3YdhI7eJo/EY1wq/2UjnZYja+ivsuwQftrVQiX24m+oT+FVmQcjxruFeVnN2Vwz8LOc1
 eW5u9afoYSm9cUx/YmHuce3ZlR4YR9rLPBuGobu4Nhpi5yfJRfxZkejG7fRev4gal6qZ
 r02g==
X-Gm-Message-State: AOJu0YxYJ/tD2/QqrXjiiUNFDOF89Jpk0nCZrMcTl5CGud3d7VOUrKKG
 WR8KToco2fZzGh7PfrbDNt7yTfFfTO2hlfn0sSmkYU5/eO8psmfmbbARnQuvSF0ntGbZQgl4P4i
 P0LPmgkRYjb0G4MfAibi5nYaZ2fsi2Kxr/VGqd20HQqtnFWRUqtmjBsyuCB1ubc0omzF+q5vYkL
 hGW/7XLv6zzgH5ATBHgXfrD2IU+PFUe6H+9oDGXU6/4w==
X-Gm-Gg: ASbGncsaqzXSBP5Nhx4tHa2t3kCHNRrNKCaec7l1+C7uhQEDgWiTr/zG3q04Xb+c0R+
 Q3o9NLYv5vsKZx394AcseK31JjPlSItIsj1lYbU5MU74Nh7XxW4ru4W0GgJy+QP5UGHEdHORQVp
 g8BpxmYoI0qRBc2FzObZ9B7twVnzyCCZ0FipxW/QvkoDmDki7lKM6v9nSyGf/Z+rU3XsWGuJClf
 2P6HoFwDeW2LAqXbozep+FBS4TllrhxRkyEkjpF2uQ+wzyRfpRAd7s/5YwAK67Y7VFIguqvVfLC
 ZDxs3MRjdk9akftkD0YoIUJU7hlvvP9vtsZsh8T2+6koyTNo6fDXzOLWntyOsIC5CTpeXiMiZGs
 Q3gAae9pnZFjwe4w62naFsEEqC9iyEwMwGGZ2Vtt7wA7f0DU4TjUPwxtTl4Rh9QTclxE=
X-Google-Smtp-Source: AGHT+IH3pMkJ8WUqog3cVllcYm/keq3w5jbOQpv8LxPOQ9vmMH+/yRH64N36QKt0MhoM/omy0ujIow==
X-Received: by 2002:a17:90b:3d8f:b0:325:e31c:4c6c with SMTP id
 98e67ed59e1d1-3280d2ba979mr20404553a91.2.1756904516446; 
 Wed, 03 Sep 2025 06:01:56 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-329e23858ecsm5472278a91.14.2025.09.03.06.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 06:01:56 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v2 2/3] target/riscv: rvv: Add Zvqdotq support
Date: Wed,  3 Sep 2025 21:01:24 +0800
Message-ID: <20250903130125.1701363-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903130125.1701363-1-max.chou@sifive.com>
References: <20250903130125.1701363-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1035.google.com
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

Support instructions for vector dot-product extension (Zvqdotq)
- vqdot.[vv,vx]
- vqdotu.[vv,vx]
- vqdotsu.[vv,vx]
- vqdotus.vx

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/helper.h                         | 10 +++
 target/riscv/insn32.decode                    |  9 +++
 target/riscv/insn_trans/trans_rvzvqdotq.c.inc | 61 +++++++++++++++++++
 target/riscv/translate.c                      |  1 +
 target/riscv/vector_helper.c                  | 61 +++++++++++++++++++
 5 files changed, 142 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzvqdotq.c.inc

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index f712b1c368..80274f1dad 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1284,3 +1284,13 @@ DEF_HELPER_4(vgmul_vv, void, ptr, ptr, env, i32)
 DEF_HELPER_5(vsm4k_vi, void, ptr, ptr, i32, env, i32)
 DEF_HELPER_4(vsm4r_vv, void, ptr, ptr, env, i32)
 DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
+
+/* Vector dot-product functions */
+DEF_HELPER_6(vqdot_vv, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vqdotu_vv, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vqdotsu_vv, void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(vqdot_vx, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vqdotu_vx, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vqdotsu_vx, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vqdotus_vx, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index cd23b1f3a9..50a6156667 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1066,3 +1066,12 @@ amominu_h  11000 . . ..... ..... 001 ..... 0101111 @atom_st
 amomaxu_h  11100 . . ..... ..... 001 ..... 0101111 @atom_st
 amocas_b    00101 . . ..... ..... 000 ..... 0101111 @atom_st
 amocas_h    00101 . . ..... ..... 001 ..... 0101111 @atom_st
+
+# *** Zvqdotq Vector Dot-Product Extension ***
+vqdot_vv    101100 . ..... ..... 010 ..... 1010111 @r_vm
+vqdot_vx    101100 . ..... ..... 110 ..... 1010111 @r_vm
+vqdotu_vv   101000 . ..... ..... 010 ..... 1010111 @r_vm
+vqdotu_vx   101000 . ..... ..... 110 ..... 1010111 @r_vm
+vqdotsu_vv  101010 . ..... ..... 010 ..... 1010111 @r_vm
+vqdotsu_vx  101010 . ..... ..... 110 ..... 1010111 @r_vm
+vqdotus_vx  101110 . ..... ..... 110 ..... 1010111 @r_vm
diff --git a/target/riscv/insn_trans/trans_rvzvqdotq.c.inc b/target/riscv/insn_trans/trans_rvzvqdotq.c.inc
new file mode 100644
index 0000000000..80134874e9
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzvqdotq.c.inc
@@ -0,0 +1,61 @@
+/*
+ * RISC-V translation routines for the Zvqdotq vector dot-product extension
+ *
+ * Copyright (C) 2025 SiFive, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+static bool vext_zvqdotq_base_check(DisasContext *s)
+{
+    return s->cfg_ptr->ext_zvqdotq && s->sew == MO_32;
+}
+
+static bool vext_vqdotq_opivv_check(DisasContext *s, arg_rmrr *a)
+{
+    return vext_zvqdotq_base_check(s) && opivv_check(s, a);
+}
+
+#define GEN_VQDOTQ_OPIVV_TRANS(NAME, CHECK)              \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)   \
+{                                                        \
+    if (CHECK(s, a)) {                                   \
+        return opivv_trans(a->rd, a->rs1, a->rs2, a->vm, \
+                           gen_helper_##NAME, s);        \
+    }                                                    \
+    return false;                                        \
+}
+
+GEN_VQDOTQ_OPIVV_TRANS(vqdot_vv, vext_vqdotq_opivv_check)
+GEN_VQDOTQ_OPIVV_TRANS(vqdotu_vv, vext_vqdotq_opivv_check)
+GEN_VQDOTQ_OPIVV_TRANS(vqdotsu_vv, vext_vqdotq_opivv_check)
+
+static bool vext_vqdotq_opivx_check(DisasContext *s, arg_rmrr *a)
+{
+    return vext_zvqdotq_base_check(s) && opivx_check(s, a);
+}
+
+#define GEN_VQDOTQ_OPIVX_TRANS(NAME, CHECK)              \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)   \
+{                                                        \
+    if (CHECK(s, a)) {                                   \
+        return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, \
+                           gen_helper_##NAME, s);        \
+    }                                                    \
+    return false;                                        \
+}
+
+GEN_VQDOTQ_OPIVX_TRANS(vqdot_vx, vext_vqdotq_opivx_check)
+GEN_VQDOTQ_OPIVX_TRANS(vqdotu_vx, vext_vqdotq_opivx_check)
+GEN_VQDOTQ_OPIVX_TRANS(vqdotsu_vx, vext_vqdotq_opivx_check)
+GEN_VQDOTQ_OPIVX_TRANS(vqdotus_vx, vext_vqdotq_opivx_check)
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9ddef2d6e2..6f43ed1ffd 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1190,6 +1190,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvzfh.c.inc"
 #include "insn_trans/trans_rvk.c.inc"
 #include "insn_trans/trans_rvvk.c.inc"
+#include "insn_trans/trans_rvzvqdotq.c.inc"
 #include "insn_trans/trans_privileged.c.inc"
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 7c67d67a13..e706e29909 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -921,6 +921,10 @@ GEN_VEXT_ST_WHOLE(vs8r_v, int8_t, ste_b_tlb, ste_b_host)
 #define WOP_SSU_B int16_t, int8_t, uint8_t, int16_t, uint16_t
 #define WOP_SSU_H int32_t, int16_t, uint16_t, int32_t, uint32_t
 #define WOP_SSU_W int64_t, int32_t, uint32_t, int64_t, uint64_t
+#define QOP_SSS_B int32_t, int8_t, int8_t, int32_t, int32_t
+#define QOP_SUS_B int32_t, uint8_t, int8_t, uint32_t, int32_t
+#define QOP_SSU_B int32_t, int8_t, uint8_t, int32_t, uint32_t
+#define QOP_UUU_B uint32_t, uint8_t, uint8_t, uint32_t, uint32_t
 #define NOP_SSS_B int8_t, int8_t, int16_t, int8_t, int16_t
 #define NOP_SSS_H int16_t, int16_t, int32_t, int16_t, int32_t
 #define NOP_SSS_W int32_t, int32_t, int64_t, int32_t, int64_t
@@ -5473,3 +5477,60 @@ GEN_VEXT_INT_EXT(vsext_vf2_d, int64_t, int32_t, H8, H4)
 GEN_VEXT_INT_EXT(vsext_vf4_w, int32_t, int8_t,  H4, H1)
 GEN_VEXT_INT_EXT(vsext_vf4_d, int64_t, int16_t, H8, H2)
 GEN_VEXT_INT_EXT(vsext_vf8_d, int64_t, int8_t,  H8, H1)
+
+
+/* Vector dot-product instructions. */
+
+#define OPMVV_VQDOTQ(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2)          \
+static void do_##NAME(void *vd, void *vs1, void *vs2, int i)            \
+{                                                                       \
+    int idx;                                                            \
+    T1 r1;                                                              \
+    T2 r2;                                                              \
+    TX1 *r1_buf = (TX1 *)vs1 + HD(i);                                   \
+    TX2 *r2_buf = (TX2 *)vs2 + HD(i);                                   \
+    TD acc = ((TD *)vd)[HD(i)];                                         \
+                                                                        \
+    for (idx = 0; idx < 4; ++idx) {                                     \
+        r1 = (TD)(*((T1 *)r1_buf + HS1(idx)));                          \
+        r2 = (TD)(*((T2 *)r2_buf + HS2(idx)));                          \
+        acc += r1 * r2;                                                 \
+    }                                                                   \
+    ((TD *)vd)[HD(i)] = acc;                                            \
+}
+
+RVVCALL(OPMVV_VQDOTQ, vqdot_vv, QOP_SSS_B, H4, H1, H1)
+RVVCALL(OPMVV_VQDOTQ, vqdotu_vv, QOP_UUU_B, H4, H1, H1)
+RVVCALL(OPMVV_VQDOTQ, vqdotsu_vv, QOP_SUS_B, H4, H1, H1)
+
+GEN_VEXT_VV(vqdot_vv, 4)
+GEN_VEXT_VV(vqdotu_vv, 4)
+GEN_VEXT_VV(vqdotsu_vv, 4)
+
+#define OPMVX_VQDOTQ(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2)          \
+static void do_##NAME(void *vd, target_long s1, void *vs2, int i)       \
+{                                                                       \
+    int idx;                                                            \
+    T1 r1;                                                              \
+    T2 r2;                                                              \
+    TX1 *r1_buf = (TX1 *)&s1;                                           \
+    TX2 *r2_buf = (TX2 *)vs2 + HD(i);                                   \
+    TD acc = ((TD *)vd)[HD(i)];                                         \
+                                                                        \
+    for (idx = 0; idx < 4; ++idx) {                                     \
+        r1 = *((T1 *)r1_buf + HS1(idx));                                \
+        r2 = *((T2 *)r2_buf + HS2(idx));                                \
+        acc += r1 * r2;                                                 \
+    }                                                                   \
+    ((TD *)vd)[HD(i)] = acc;                                            \
+}
+
+RVVCALL(OPMVX_VQDOTQ, vqdot_vx, QOP_SSS_B, H4, H1, H1)
+RVVCALL(OPMVX_VQDOTQ, vqdotu_vx, QOP_UUU_B, H4, H1, H1)
+RVVCALL(OPMVX_VQDOTQ, vqdotsu_vx, QOP_SUS_B, H4, H1, H1)
+RVVCALL(OPMVX_VQDOTQ, vqdotus_vx, QOP_SSU_B, H4, H1, H1)
+
+GEN_VEXT_VX(vqdot_vx, 4)
+GEN_VEXT_VX(vqdotu_vx, 4)
+GEN_VEXT_VX(vqdotsu_vx, 4)
+GEN_VEXT_VX(vqdotus_vx, 4)
-- 
2.39.3


