Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEBDCF9C64
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLHh-0001ld-CU; Sun, 22 Sep 2024 08:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHP-0000x3-SW
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:37 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHJ-0002OE-A5
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:28 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-374c4c6cb29so3366370f8f.3
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006483; x=1727611283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zmsViYQuZcRw3+Xw3xnkrlUzHZT6vqkjOcHzmQVj1eI=;
 b=MP4NSeIyjYva+V6FtEDCSRoJ1qPDZ9Jpd0muitCpiI04CpYZW+LbEuarELScOJh+fD
 j5vXyCpHyJiEXlZx7BevkP7miu7/1kc82Jo2uNc+WEqUHEfVD1n5Dq/T9AufLy7TXwHm
 pqD2xcZ7iytFmQ+HI20X6SgD4ZjINh5j7FEOrT3LnAXmtKSgF5tZmyRhjz+P4c9kjqlv
 ISI7EAlQjtig0kbxLKEvHLQXgeCb3O7MzPPOP4XmTSvs0SiT61x7zhcRMORxVSaJRYmH
 otTaUEPf2f/oL8tS2Vh0CkIdNi/3Y0i2qtYUIytZxa39fGmWYkXcy10bAbQ0jM+6Og+k
 zuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006483; x=1727611283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zmsViYQuZcRw3+Xw3xnkrlUzHZT6vqkjOcHzmQVj1eI=;
 b=rGwiXq+dyUtnmkr6FJrTcxK9GK49zARbiC1V2AYjFJE8ZS9PzEk7ci5l+afaCRAJHu
 5vnR7yK+HX6gFgc5aBDSVF7o5oF8ykbnYe8L6HbFxxnyvzjEV0UFYiH4WIKdusk7IQH2
 v3EL5374D2Kk+KkZlwxbVnExk8467mkKcwHdZsJojeJpJ/Og8Tlc0bJDEFVs3uhvurbW
 IXZmkfzl6p2Z9DYjODMXeQwz16u+fuOIVVKxUQANzUkAfBswvHer96bvMA7IqnBYoysw
 5859iOab36LpCiykzPnGv6ZPUITUN69LvAgAczqeEPpXtftAJ8SWGy5Xs1XNjII8c/UL
 l5Hw==
X-Gm-Message-State: AOJu0YzB3TmmNfYX+80nN1XXorQ7MJM38O1DcR4aZVy+kmwDNIgPUGRY
 UYcxp6x8hMtisZlgHnQTPXgV7To1q0tX0yLWXSXCU66ChTvKUdf5XnYEK+BvmkuZF2peWzwko2D
 GX9o=
X-Google-Smtp-Source: AGHT+IEoNkkxv2ovsiWy/21Jwwdy7wSGEHziUzMOWA+HRNM3ewz6227oJfn6J0I9cdkBE6AC3BkOSA==
X-Received: by 2002:a5d:45c3:0:b0:374:c318:2190 with SMTP id
 ffacd0b85a97d-37a424b019bmr6903800f8f.59.1727006483351; 
 Sun, 22 Sep 2024 05:01:23 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 16/31] tcg/i386: Implement cmpsel_vec with avx512 insns
Date: Sun, 22 Sep 2024 14:00:57 +0200
Message-ID: <20240922120112.5067-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
References: <20240922120112.5067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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

The avx512 vpblendm* instructions exactly implement cmpsel,
using a predicate input.  Of course this matches nicely with
the avx512 predicate comparison instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 44 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index f94a2a2385..d473dc7a5e 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -413,6 +413,10 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define OPC_UD2         (0x0b | P_EXT)
 #define OPC_VPBLENDD    (0x02 | P_EXT3A | P_DATA16)
 #define OPC_VPBLENDVB   (0x4c | P_EXT3A | P_DATA16)
+#define OPC_VPBLENDMB   (0x66 | P_EXT38 | P_DATA16 | P_EVEX)
+#define OPC_VPBLENDMW   (0x66 | P_EXT38 | P_DATA16 | P_VEXW | P_EVEX)
+#define OPC_VPBLENDMD   (0x64 | P_EXT38 | P_DATA16 | P_EVEX)
+#define OPC_VPBLENDMQ   (0x64 | P_EXT38 | P_DATA16 | P_VEXW | P_EVEX)
 #define OPC_VPCMPB      (0x3f | P_EXT3A | P_DATA16 | P_EVEX)
 #define OPC_VPCMPUB     (0x3e | P_EXT3A | P_DATA16 | P_EVEX)
 #define OPC_VPCMPW      (0x3f | P_EXT3A | P_DATA16 | P_VEXW | P_EVEX)
@@ -738,6 +742,16 @@ static void tcg_out_vex_modrm_type(TCGContext *s, int opc,
     tcg_out_vex_modrm(s, opc, r, v, rm);
 }
 
+static void tcg_out_evex_modrm_type(TCGContext *s, int opc, int r, int v,
+                                    int rm, int aaa, bool z, TCGType type)
+{
+    if (type == TCG_TYPE_V256) {
+        opc |= P_VEXL;
+    }
+    tcg_out_evex_opc(s, opc, r, v, rm, 0, aaa, z);
+    tcg_out8(s, 0xc0 | (LOWREGMASK(r) << 3) | LOWREGMASK(rm));
+}
+
 /* Output an opcode with a full "rm + (index<<shift) + offset" address mode.
    We handle either RM and INDEX missing with a negative value.  In 64-bit
    mode for absolute addresses, ~RM is the size of the immediate operand
@@ -3183,11 +3197,39 @@ static void tcg_out_cmp_vec(TCGContext *s, TCGType type, unsigned vece,
     }
 }
 
+static void tcg_out_cmpsel_vec_k1(TCGContext *s, TCGType type, unsigned vece,
+                                  TCGReg v0, TCGReg c1, TCGReg c2,
+                                  TCGReg v3, TCGReg v4, TCGCond cond)
+{
+    static const int vpblendm_insn[] = {
+        OPC_VPBLENDMB, OPC_VPBLENDMW, OPC_VPBLENDMD, OPC_VPBLENDMQ
+    };
+    bool z = false;
+
+    /* Swap to place constant in V4 to take advantage of zero-masking. */
+    if (!v3) {
+        z = true;
+        v3 = v4;
+        cond = tcg_invert_cond(cond);
+    }
+
+    tcg_out_cmp_vec_k1(s, type, vece, c1, c2, cond);
+    tcg_out_evex_modrm_type(s, vpblendm_insn[vece], v0, v4, v3,
+                            /* k1 */1, z, type);
+}
+
 static void tcg_out_cmpsel_vec(TCGContext *s, TCGType type, unsigned vece,
                                TCGReg v0, TCGReg c1, TCGReg c2,
                                TCGReg v3, TCGReg v4, TCGCond cond)
 {
-    bool inv = tcg_out_cmp_vec_noinv(s, type, vece, TCG_TMP_VEC, c1, c2, cond);
+    bool inv;
+
+    if (vece <= MO_16 ? have_avx512bw : have_avx512vl) {
+        tcg_out_cmpsel_vec_k1(s, type, vece, v0, c1, c2, v3, v4, cond);
+        return;
+    }
+
+    inv = tcg_out_cmp_vec_noinv(s, type, vece, TCG_TMP_VEC, c1, c2, cond);
 
     /*
      * Since XMM0 is 16, the only way we get 0 into V3
-- 
2.43.0


