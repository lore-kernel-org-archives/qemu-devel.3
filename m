Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFB8C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77JI-0002gD-Rz; Thu, 17 Sep 2026 04:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77J7-0002dk-59
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:25 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77J3-0001st-Ng
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:24 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466ccdd77e2so180084fac.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789633040; x=1790237840; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9oUkHaIbiUoGRNxUQDMr8hy1BjJZ/w2mYIh6pr4GPPg=;
 b=T/LmWZg09bLRCMLDMWQqfElo45CMN+ej1ONQb0CwsC5IpgZoPHsxFRG+SzaZm6MX6a
 wXKXy5YwStzq+sDq+vMtsdgCp4hZEgQShnC5lh7YnqXRQ/nH0AU1VgH4637ynZenBjqE
 gNhaQiiwnKVIQZdxAu8sS92tT9rUnMqA7JDF4oIz6aSvtkmx/aOXgp3XEEeq9mqJ8jWo
 UhbPsXdrN8gFXN+PFSIOP2PUflhwc6pVDa5F5geVQBbYzgL9zOW4R0e3DNJmNPfh7vCh
 TG1OfRzY2nTqFzOspmdxTli/apNw2z6P8I1i02RxHWU0v4n4/8kq1YD/I2SUgJckmoj2
 tRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633040; x=1790237840;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9oUkHaIbiUoGRNxUQDMr8hy1BjJZ/w2mYIh6pr4GPPg=;
 b=t0d3CkXHw0qnFEv73JIremELx9yY3hebxDUdXz/jkI9NDCP4oRXqYp5NyuQGrAd8mm
 yxu7dBWaI8/P+d4urGD+UNfxZ/iG43Gp+J5yQpDvK6eByha/Zr43HdXAGjFJ7qG5ecvv
 8IQ/1PSJcT8HxAL+skYa96HGgl/KKc9k69CMwh78Y+pCNweZMKBWFQmPD0w4eAnGuiYl
 nfVH8Y1BAfINcgBy2g7MXhKy6mTNFgSQEaAr/OVWoOePYjRwKUtL0/1x98PzSSyxLY25
 Z/06zxXFjztaYenQISBB0agN9VRSWs5FrDUjX4ptvDYXPkMB5rC9vqbifSL9CAXY2fLL
 pQdA==
X-Gm-Message-State: AFuF++lZ2pqF72zozdj2smZO6BxAa+TCVh4eL0yh2jRhzJ2o7AyrG5Eu
 8ZX2H2XQuYfxYyY/NsBjVSqur5Szdz6O4zC+p/hSdoW9mtOum/RTgyYc0o1r0vHERpB+U/JGV5t
 htrceeCc=
X-Gm-Gg: AYBFou0YgZiW5vpdzhBjT0DFeGaBMrOm9PWiJ0rpV72OFpx9RxbbIedOAYdC9c8ukR+
 +kB41h2yrwKoMeBlWjvlcmNzc1ig0GLdz9RCM0H0IV/0osiQs12USQMUwdrNggXsjt73EW8gNKY
 Tb9VAqKSm9dAm9p0Tiju3tV0Tu+0sQnO/v0GeMXBlaR0GnokCD9NAk9xpt4rayF/XXb5zFXATIK
 CoWN1UPA6jajIHWBEtbKHlXs2p+QxkR0AyfOIbd0icwJhPQStqoVQRT1Zxn4hEasNRgbUbjdLc3
 FA3EUWNRXk5vfKBRDtmFzgnFVulRtauyD9F11Z6Ubb8B8X7FDNS8U0ePQRzFj5Txt6DrdzjXUa6
 R++Ygg1hz7tNZEtCZt6evRquvy7wUj5/n6c3EoBCJD0ukeaLX0B4IO13dsUNxSEN3t5RWalDkd+
 ngLNl4NUNJfPR4UGyOJDPXGX0uEIqaGx0XEAnyAiYKBpgDjpq2bzIztwnnfdan9ijqkNNnkaoos
 PgZfvM=
X-Received: by 2002:a05:6820:2908:b0:6b7:46e9:96f8 with SMTP id
 006d021491bc7-6c7d39fa681mr5248263eaf.40.1789633040158; 
 Thu, 17 Sep 2026 01:17:20 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c1943f4bcsm127638eec.21.2026.09.17.01.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:17:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 01/16] tcg: Add INDEX_op_lea
Date: Wed, 16 Sep 2026 22:17:01 -1000
Message-ID: <20260917081716.946668-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917081716.946668-1-richard.henderson@linaro.org>
References: <20260917081716.946668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:30::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa2-x10.google.com
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

Add an opcode for compound address formation.

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/tcg-ops.rst           |  4 ++++
 include/tcg/tcg-opc.h            |  1 +
 tcg/aarch64/tcg-target-has.h     |  3 +++
 tcg/loongarch64/tcg-target-has.h |  3 +++
 tcg/ppc64/tcg-target-has.h       |  3 +++
 tcg/riscv64/tcg-target-has.h     |  3 +++
 tcg/s390x/tcg-target-has.h       |  3 +++
 tcg/sparc64/tcg-target-has.h     |  3 +++
 tcg/tci/tcg-target-has.h         |  3 +++
 tcg/x86_64/tcg-target-has.h      |  3 +++
 tcg/tcg.c                        | 22 ++++++++++++++++++++++
 tcg/aarch64/tcg-target.c.inc     |  4 ++++
 tcg/loongarch64/tcg-target.c.inc |  4 ++++
 tcg/ppc64/tcg-target.c.inc       |  3 +++
 tcg/riscv64/tcg-target.c.inc     |  3 +++
 tcg/s390x/tcg-target.c.inc       |  3 +++
 tcg/sparc64/tcg-target.c.inc     |  3 +++
 tcg/tci/tcg-target.c.inc         |  4 ++++
 tcg/x86_64/tcg-target.c.inc      |  4 ++++
 19 files changed, 79 insertions(+)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 88d48a1f99a..51fa183e911 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -524,6 +524,10 @@ Misc
 
      - | Reverse the 64 bits of input *t1* with output in *dest*.
 
+   * - lea *dest*, *t1*, *t2*, *sh*, *imm*
+
+     - | *dest* = *t1* + (*t2* << *sh*) + *imm*.
+
 Conditional moves
 -----------------
 
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index f3a81d5d7fb..884345afe56 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -64,6 +64,7 @@ DEF(ld16s, 1, 1, 1, TCG_OPF_INT)
 DEF(ld32u, 1, 1, 1, TCG_OPF_INT)
 DEF(ld32s, 1, 1, 1, TCG_OPF_INT)
 DEF(ld, 1, 1, 1, TCG_OPF_INT)
+DEF(lea, 1, 2, 2, TCG_OPF_INT)
 DEF(movcond, 1, 4, 1, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
 DEF(muls2, 2, 2, 0, TCG_OPF_INT)
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 69e83efb69d..86672b2eab4 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -57,4 +57,7 @@
 #define TCG_TARGET_sextract_valid(type, ofs, len)  1
 #define TCG_TARGET_deposit_valid(type, ofs, len)   1
 
+#define TCG_TARGET_lea_sh_valid(type, sh)          0
+#define TCG_TARGET_lea_imm_valid(type, imm)        0
+
 #endif
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 32abc6f4574..31e6ea9632d 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -54,4 +54,7 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
+#define TCG_TARGET_lea_sh_valid(type, sh)          0
+#define TCG_TARGET_lea_imm_valid(type, imm)        0
+
 #endif
diff --git a/tcg/ppc64/tcg-target-has.h b/tcg/ppc64/tcg-target-has.h
index a3711feeae2..d11d82f1844 100644
--- a/tcg/ppc64/tcg-target-has.h
+++ b/tcg/ppc64/tcg-target-has.h
@@ -66,4 +66,7 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
+#define TCG_TARGET_lea_sh_valid(type, sh)          0
+#define TCG_TARGET_lea_imm_valid(type, imm)        0
+
 #endif
diff --git a/tcg/riscv64/tcg-target-has.h b/tcg/riscv64/tcg-target-has.h
index aef10c2d9d6..93f8baad09f 100644
--- a/tcg/riscv64/tcg-target-has.h
+++ b/tcg/riscv64/tcg-target-has.h
@@ -69,4 +69,7 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 
 #define TCG_TARGET_deposit_valid(type, ofs, len)  0
 
+#define TCG_TARGET_lea_sh_valid(type, sh)         0
+#define TCG_TARGET_lea_imm_valid(type, imm)       0
+
 #endif
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 0aeb5ba01a9..58e3afe5266 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -77,4 +77,7 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
+#define TCG_TARGET_lea_sh_valid(type, sh)          0
+#define TCG_TARGET_lea_imm_valid(type, imm)        0
+
 #endif
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index b29fd177f69..4182a7c1aae 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -19,4 +19,7 @@
 
 #define TCG_TARGET_deposit_valid(type, ofs, len) 0
 
+#define TCG_TARGET_lea_sh_valid(type, sh)          0
+#define TCG_TARGET_lea_imm_valid(type, imm)        0
+
 #endif
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 64742cf0b71..f4f9ddf595f 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -17,4 +17,7 @@
 #define TCG_TARGET_sextract_valid(type, ofs, len)  1
 #define TCG_TARGET_deposit_valid(type, ofs, len)   1
 
+#define TCG_TARGET_lea_sh_valid(type, sh)          0
+#define TCG_TARGET_lea_imm_valid(type, imm)        0
+
 #endif
diff --git a/tcg/x86_64/tcg-target-has.h b/tcg/x86_64/tcg-target-has.h
index d249c1b3e7f..6ffae51f923 100644
--- a/tcg/x86_64/tcg-target-has.h
+++ b/tcg/x86_64/tcg-target-has.h
@@ -105,4 +105,7 @@ tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_extract_valid  tcg_target_extract_valid
 
+#define TCG_TARGET_lea_sh_valid(type, sh)          0
+#define TCG_TARGET_lea_imm_valid(type, imm)        0
+
 #endif
diff --git a/tcg/tcg.c b/tcg/tcg.c
index df1590166e7..b88ee847039 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1095,6 +1095,12 @@ typedef struct TCGOutOpSubtract {
                     TCGReg a0, tcg_target_long a1, TCGReg a2);
 } TCGOutOpSubtract;
 
+typedef struct TCGOutOpLea {
+    TCGOutOp base;
+    void (*out)(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                TCGReg a2, unsigned sh, tcg_target_long imm);
+} TCGOutOpLea;
+
 #include "tcg-target.c.inc"
 
 #ifndef CONFIG_TCG_INTERPRETER
@@ -1191,6 +1197,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_ld16u, TCGOutOpLoad, outop_ld16u),
     OUTOP(INDEX_op_ld32s, TCGOutOpLoad, outop_ld32s),
     OUTOP(INDEX_op_ld32u, TCGOutOpLoad, outop_ld32u),
+    OUTOP(INDEX_op_lea, TCGOutOpLea, outop_lea),
     OUTOP(INDEX_op_movcond, TCGOutOpMovcond, outop_movcond),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_muls2, TCGOutOpMul2, outop_muls2),
@@ -5990,6 +5997,21 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_lea:
+        {
+            const TCGOutOpLea *out = &outop_lea;
+            int sh = new_args[3];
+            tcg_target_long imm = new_args[4];
+
+            tcg_debug_assert(!const_args[1]);
+            tcg_debug_assert(!const_args[2]);
+            tcg_debug_assert(TCG_TARGET_lea_sh_valid(type, sh));
+            tcg_debug_assert(TCG_TARGET_lea_imm_valid(type, imm));
+
+            out->out(s, type, new_args[0], new_args[1], new_args[2], sh, imm);
+        }
+        break;
+
     case INDEX_op_goto_ptr:
         tcg_debug_assert(!const_args[0]);
         tcg_out_goto_ptr(s, new_args[0]);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 4ebdef7e077..76adb2256f9 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -3081,6 +3081,10 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
                            const TCGArg args[TCG_MAX_OP_ARGS],
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 69e76807d6e..17784d8bbe2 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2098,6 +2098,10 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg rd, TCGReg rs)
 {
diff --git a/tcg/ppc64/tcg-target.c.inc b/tcg/ppc64/tcg-target.c.inc
index cd1c2343672..99f4469f4b9 100644
--- a/tcg/ppc64/tcg-target.c.inc
+++ b/tcg/ppc64/tcg-target.c.inc
@@ -3633,6 +3633,9 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
 
 int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
 {
diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 2ce9d47a633..df4c4a9789b 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -2725,6 +2725,9 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
 
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 4d1a779c47c..2fd7012d047 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3187,6 +3187,9 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
 
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg dst, TCGReg src)
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 35cd14a5b65..cb457453ff9 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -2120,6 +2120,9 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
 
 static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 4cd1c1431ce..6942fdbb4e0 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -1220,6 +1220,10 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
     return false;
 }
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 /* Test if a constant matches the constraint. */
 static bool tcg_target_const_match(int64_t val, int ct,
                                    TCGType type, TCGCond cond, int vece)
diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
index 2c8f1f3e580..660350b963d 100644
--- a/tcg/x86_64/tcg-target.c.inc
+++ b/tcg/x86_64/tcg-target.c.inc
@@ -3327,6 +3327,10 @@ static const TCGOutOpStore outop_st = {
     .out_i = tgen_st_i,
 };
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static int const umin_insn[4] = {
     OPC_PMINUB, OPC_PMINUW, OPC_PMINUD, OPC_VPMINUQ
 };
-- 
2.53.0


