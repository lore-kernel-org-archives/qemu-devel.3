Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3E8C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzg7c-00021D-RS; Wed, 24 Apr 2024 13:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzg7V-0001zh-Nx
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:09:22 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzg7T-0005NL-QR
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:09:21 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e3ca4fe4cfso229835ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 10:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713978558; x=1714583358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5odWkAYeVMNCe6Cty3EzFB4YygxLZJZYtuimpCAAowk=;
 b=w0NXHGyst2MBcklpeOWnqA9xZASv4SNFQyu/cCYj2yvahdzFp3h8G0QI5mQjxnh1uT
 mfzn0CwYlomMnWtP3VGuZZzKwyF77jtc2aVTI7jtIs2Zd7H/5kpwDMlysbk69LqluxXv
 uT8qGgfmywCluU/WptqN0ir51ewGD2IpJY11Mcve9I/gvyZSGhlaYkilA5pA6NXK1faF
 U1K8nOdmFXE0sGoQZbMxDqhzp+FEtKjgdCfI/6XIc0vu8X+r6EqeTY1Du0C9nz8fhVBF
 GO/lh/rbcLYlQIqzTLqg57iBtpe8WUTqa9P/cW/I7IN1QfuKIKDCcDARVnZ8jmCIoMW7
 nYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713978558; x=1714583358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5odWkAYeVMNCe6Cty3EzFB4YygxLZJZYtuimpCAAowk=;
 b=t9GA2HqV5nq48LGqhzHWQ/dquTUNNucvt8wsFEKNe7QjkXj95MjxEf0tArunOHpGuN
 lFSYo4rPELa+zeY7/JomsELsTzgNhHSj/XH9GBv5V7A+T+ul2JKY7z23Yx0T94A3l0mU
 DtIrlayyX/Rs+/bvXuSwoutjdMlaXh7VhSg6FWc/NKoNIOvbfQ0K18l4cq8DqFhFThxd
 PtmHnaDHepi8qCnqAASCUxjSBwekyiof71YeQEYVOiKUTKN1x/cht+dpoNQRDdQguN1b
 OGsgCTWab/zG3gB0Y0FCiUme4xyK10JCPAGJea0qbt2qOjUDHCCAkDrlYocwelnIaSq3
 n4HA==
X-Gm-Message-State: AOJu0Yw60s5rO9YXsh+gXlegPcmu3hms6o+x992WEHGRsahEaQHp2HU7
 rNk9m4ls9UnrxcuxRYARjR+L3DfgPWbPWZx8pMg0AfVXBLo1olLcSRlKXzXCUwnF0IRLdAQCgvF
 f
X-Google-Smtp-Source: AGHT+IEG5mkJaOUXDGH5Lh2fZO5v15uZ/cATGc+mxF/W2E8EqUarBb0u8jCpVioujWSjdjQYq0nkLg==
X-Received: by 2002:a17:902:e944:b0:1e3:dfdc:6972 with SMTP id
 b4-20020a170902e94400b001e3dfdc6972mr4491816pll.9.1713978558138; 
 Wed, 24 Apr 2024 10:09:18 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 u8-20020a170902e80800b001e0b5d49fc7sm12215489plg.161.2024.04.24.10.09.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 10:09:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] tcg/optimize: Optimize setcond with zmask
Date: Wed, 24 Apr 2024 10:09:07 -0700
Message-Id: <20240424170908.759043-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424170908.759043-1-richard.henderson@linaro.org>
References: <20240424170908.759043-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

If we can show that high bits of an input are zero,
then we may optimize away some comparisons.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2e9e5725a9..8886f7037a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2099,6 +2099,108 @@ static bool fold_remainder(OptContext *ctx, TCGOp *op)
     return false;
 }
 
+static bool fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
+{
+    uint64_t a_zmask, b_val;
+    TCGCond cond;
+
+    if (!arg_is_const(op->args[2])) {
+        return false;
+    }
+
+    a_zmask = arg_info(op->args[1])->z_mask;
+    b_val = arg_info(op->args[2])->val;
+    cond = op->args[3];
+
+    if (ctx->type == TCG_TYPE_I32) {
+        a_zmask = (uint32_t)a_zmask;
+        b_val = (uint32_t)b_val;
+    }
+
+    /*
+     * A with only low bits set vs B with high bits set means that A < B.
+     */
+    if (a_zmask < b_val) {
+        bool inv = false;
+
+        switch (cond) {
+        case TCG_COND_NE:
+        case TCG_COND_LEU:
+        case TCG_COND_LTU:
+            inv = true;
+            /* fall through */
+        case TCG_COND_GTU:
+        case TCG_COND_GEU:
+        case TCG_COND_EQ:
+            return tcg_opt_gen_movi(ctx, op, op->args[0], neg ? -inv : inv);
+        default:
+            break;
+        }
+    }
+
+    /*
+     * A with only lsb set is already boolean.
+     */
+    if (a_zmask <= 1) {
+        bool convert = false;
+        bool inv = false;
+
+        switch (cond) {
+        case TCG_COND_EQ:
+            inv = true;
+            /* fall through */
+        case TCG_COND_NE:
+            convert = (b_val == 0);
+            break;
+        case TCG_COND_LTU:
+        case TCG_COND_TSTEQ:
+            inv = true;
+            /* fall through */
+        case TCG_COND_GEU:
+        case TCG_COND_TSTNE:
+            convert = (b_val == 1);
+            break;
+        default:
+            break;
+        }
+        if (convert) {
+            TCGOpcode add_opc, xor_opc, neg_opc;
+
+            if (!inv && !neg) {
+                return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
+            }
+
+            switch (ctx->type) {
+            case TCG_TYPE_I32:
+                add_opc = INDEX_op_add_i32;
+                neg_opc = INDEX_op_neg_i32;
+                xor_opc = INDEX_op_xor_i32;
+                break;
+            case TCG_TYPE_I64:
+                add_opc = INDEX_op_add_i64;
+                neg_opc = INDEX_op_neg_i64;
+                xor_opc = INDEX_op_xor_i64;
+                break;
+            default:
+                g_assert_not_reached();
+            }
+
+            if (!inv) {
+                op->opc = neg_opc;
+            } else if (neg) {
+                op->opc = add_opc;
+                op->args[2] = arg_new_constant(ctx, -1);
+            } else {
+                op->opc = xor_opc;
+                op->args[2] = arg_new_constant(ctx, 1);
+            }
+            return false;
+        }
+    }
+
+    return false;
+}
+
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
     TCGOpcode and_opc, sub_opc, xor_opc, neg_opc, shr_opc;
@@ -2200,6 +2302,10 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
     if (i >= 0) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], i);
     }
+
+    if (fold_setcond_zmask(ctx, op, false)) {
+        return true;
+    }
     fold_setcond_tst_pow2(ctx, op, false);
 
     ctx->z_mask = 1;
@@ -2214,6 +2320,10 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
     if (i >= 0) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], -i);
     }
+
+    if (fold_setcond_zmask(ctx, op, true)) {
+        return true;
+    }
     fold_setcond_tst_pow2(ctx, op, true);
 
     /* Value is {0,-1} so all bits are repetitions of the sign. */
-- 
2.34.1


