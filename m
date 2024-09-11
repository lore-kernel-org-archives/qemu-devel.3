Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA82EE57C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQYn-00032K-9x; Wed, 11 Sep 2024 12:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYa-0002Uw-PA
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:51:04 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYY-0003gY-V2
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:51:04 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71790ed8c2dso6096634b3a.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726073461; x=1726678261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zmsViYQuZcRw3+Xw3xnkrlUzHZT6vqkjOcHzmQVj1eI=;
 b=K+6c07qMAeWsb/aUfoN1xs232iauJXkiIzfL7sNkj1x4SSkgL9MPmcSwaZJQuQLu3u
 hFrCvq2vnrYJBtdrVmMrnque1d0mfgOL7DgS36rkPt94av9xFvlBi4TOmMb8frqOGQiI
 IY3vysIIJWcmgtskbIDCTpmmFfPt7ilpCuOlFld9I5N1U48RvlqrdwDkoxbQTsEAWFoS
 ymMXAxmTsxnuyzM72VdTpeAunSwpaa/99HNw5iwTaAqp8yrjWYsQ+NIdvpCzoeB2Coui
 ZgE14P0K/cHb83LY8LMybAgvjsburHUMkHiYjVGYq8AbKHs8Osvw8SutjvGUiWc+/YU8
 dsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726073461; x=1726678261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zmsViYQuZcRw3+Xw3xnkrlUzHZT6vqkjOcHzmQVj1eI=;
 b=fP0QBsBoqodmLJYQkFbhkboP2WoSfuu67V2o7t0KrLMSs/OdZbhuP7oKcCLnoW4sxL
 iHP7iGqPV832bkoGSEyLfI2/QIdWXQnI9FIHnkh9rcHKxLi0ipngqlOt4qvqxS6ZFH36
 j1yXMj7GLYPDbQvJSoBPfx7TT8m389bdn8A8GcGPDWiEIaJrPR775LtybhTw7U1P9UIR
 Sy57tXhDO3T+EN1cNIx0yDP4ecin6HhJeW1ybMn1gM7tqvEvm8vy7kOCtBFBms3FJYbg
 EQ9D8mrDF1r2NTWktVCYNkzI94clrLX2pVSizQZRZK5Lbn5GyukRfqrTO+XoIVg6zoj0
 0K+g==
X-Gm-Message-State: AOJu0YzNfrJBz18Qjm3cvpsX5Lju/rmUj+TNHbrBcYTk+b7DeLX6K1oq
 o7evtUX0uslrgnszBp0MdsvUpXLicJjzTqm6CT1WHJg0PBEP5mZdGRunr16Hb6CHn5G0VCueZn8
 V
X-Google-Smtp-Source: AGHT+IE6NjEYdSTgX3awPXzNLWY1wgb/qkt4rZEyTSNYsc74ZE/sU+YKHHoN8ApBWQDXH7+gmcektQ==
X-Received: by 2002:a05:6a00:218f:b0:70d:2892:402b with SMTP id
 d2e1a72fcca58-7192608123fmr18890b3a.7.1726073461551; 
 Wed, 11 Sep 2024 09:51:01 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe4e7esm3186947b3a.80.2024.09.11.09.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 09:51:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 philmd@linaro.org
Subject: [PATCH v2 13/18] tcg/i386: Implement cmpsel_vec with avx512 insns
Date: Wed, 11 Sep 2024 09:50:42 -0700
Message-ID: <20240911165047.1035764-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911165047.1035764-1-richard.henderson@linaro.org>
References: <20240911165047.1035764-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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


