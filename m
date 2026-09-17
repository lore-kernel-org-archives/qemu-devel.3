Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2717AC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 10:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x795l-0005Ny-Bo; Thu, 17 Sep 2026 06:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x795j-0005Ng-9J
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 06:11:43 -0400
Received: from mail-pz2-x2a.google.com ([2607:f8b0:4864:3b::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x795h-00061O-Fx
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 06:11:43 -0400
Received: by mail-pz2-x2a.google.com with SMTP id
 41be03b00d2f7-cc1cea4c7a0so337589a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 03:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789639899; x=1790244699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8t+YKskkKCjHmw92Je/nI6T+ryRQwAzm9Vfd8kK7XtA=;
 b=OcqoVcF6nMSZyjo1CcJKxErf9c6tOxDtinvnk9uaVr31BRxod3EoKOiZmVZtr2dfuK
 Ul92J8YYxBa0JXGZK0xat33Boa2z6B7DwY/CHt+xA6foy3bxUwgMkl/SutIL4lBaFlxB
 32Hvsc1dAGDA0JF3SBwEiy9QldO0NQdP9QOyhbP2YOnF7c7h6HTfYA+SRoduDl7Qc0V8
 2jZoZ7d0GUtMIr161iwlR5BTvZpwCJWY7K9udXWkYaWnKg2kmur1H1omjvdZw8v/wt5J
 J9A/pWskgNvVwCNDjETf5P/VywCqEWdmik5ui+PnSTx3GW4JLgwbvsYspFqxXYsBCmMq
 L54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789639899; x=1790244699;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8t+YKskkKCjHmw92Je/nI6T+ryRQwAzm9Vfd8kK7XtA=;
 b=djai+eLE7+C2oCy+9c5WUTXeLDNN/h6ITW6hbJP6wY165VwUd74jH57eTitS4P0ox0
 RRBvfakECjupP1UIaB22+qV5XnEOTXyUyyeqPaBk5SMYr1z1PkdH/J4Ajwe/fiq/Q1eP
 Tuy2Dj/8nOVuaMdOuRgCrbKdNe59Yaw1jZEdMk7l2bxPKedD54g/AOq+1DROIET7fvXj
 YyOc7HiTmAxfVt0bGSIGalns3u/OWLPAcjyieeLyiBJGwuRLAkjAXrB2BhGjAVDfXAE7
 c11xt07Ukwim0dW5Pevc8QT+PtgePx926Wwhn1QbpSGmvqBx7qPkd1ez26Jnh8CCBPdk
 IHHg==
X-Gm-Message-State: AFuF++lyw1bc5pAgtAFNrKo9vOoM2hLiLKe9KrtY+J6a10hQliFfq4pZ
 eTvYzq5qrrZUxGzvoei4rKkusy/MkffyXVRfrJv1OMMUC8FY0//CTAdRwErXuZHgNt29A6w9f1P
 oB/x20m0=
X-Gm-Gg: AYBFou1xcJU13XvLUi/y7WMGphKBBHeino3bT8iD1sMC3JxlXyRunJ/YABqchDsivKK
 XO/02i2E4A51+EQvEm5gScVfmmNBdRItc2MAp50+OOKyV/c9uPXrpTv9ALvBZ4bzVJaLqioMwq/
 Lp/XvyFmEi0PD908nReoCXjWjjyk+fayLREqC4yIsSv2v2aYCSvoJQyMOD845zxo2Gt2QfBbzro
 m1cjW8zhUbLy6pXEEbINBsVOhqHjvit1KJzt/SpVRbH38dp91vjm70EbTIpNHNQzD1HQ2Ck9SGu
 Z3KStQ1HkU2wOf8ODYvZwlNQGrVslsLTTHR5Y+yki6vAKKQn2I1stav5O1RjAj9aYga3gMpwuoC
 BoPxKaw2JEQANBjUfjHD8iDMrJgX/y1doQqvR44+TuPHnksgwfqz2anHQaVOmtGrVsBOc7p7Y2l
 zgXoV1Lpj5ItYLRxTsXK5hZ9BqjfFarup0gTUhLZ/OpP0kGYPsdC0R1jfEVoj2s9ZU0SBOsbeQ6
 5I4tZu/y0XEys1PUQ==
X-Received: by 2002:a17:90a:501:b0:39e:25c2:b9e0 with SMTP id
 98e67ed59e1d1-39e25c2ba53mr7281076a91.25.1789639898510; 
 Thu, 17 Sep 2026 03:11:38 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c00ede586sm11900847eec.10.2026.09.17.03.11.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 03:11:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tcg/x86_64: Use the mulx insn from the bmi2 isa
Date: Thu, 17 Sep 2026 00:11:36 -1000
Message-ID: <20260917101136.1105179-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This vex encoded instruction can be used or either mulu2 or muluh.
This replaces the highly constrained mul insn from the base x86 isa.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/x86_64/tcg-target-con-set.h |  2 ++
 tcg/x86_64/tcg-target.c.inc     | 36 ++++++++++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/tcg/x86_64/tcg-target-con-set.h b/tcg/x86_64/tcg-target-con-set.h
index 458d69c3c07..7df9bf49177 100644
--- a/tcg/x86_64/tcg-target-con-set.h
+++ b/tcg/x86_64/tcg-target-con-set.h
@@ -42,6 +42,7 @@ C_O1_I2(r, 0, reZ)
 C_O1_I2(r, 0, ri)
 C_O1_I2(r, 0, rI)
 C_O1_I2(r, L, L)
+C_O1_I2(r, r, d)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, re)
 C_O1_I2(r, r, ri)
@@ -56,5 +57,6 @@ C_O1_I4(r, r, reT, r, 0)
 C_O1_I4(r, r, r, ri, ri)
 C_O2_I1(r, r, L)
 C_O2_I2(a, d, a, r)
+C_O2_I2(r, r, r, d)
 C_O2_I2(r, r, L, L)
 C_O2_I3(a, d, 0, 1, r)
diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
index 2c8f1f3e580..8e0d8e08146 100644
--- a/tcg/x86_64/tcg-target.c.inc
+++ b/tcg/x86_64/tcg-target.c.inc
@@ -274,6 +274,7 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define OPC_MOVSLQ	(0x63 | P_REXW)
 #define OPC_MOVZBL	(0xb6 | P_EXT)
 #define OPC_MOVZWL	(0xb7 | P_EXT)
+#define OPC_MULX        (0xf6 | P_SIMDF2 | P_EXT38)
 #define OPC_PABSB       (0x1c | P_EXT38 | P_DATA16)
 #define OPC_PABSW       (0x1d | P_EXT38 | P_DATA16)
 #define OPC_PABSD       (0x1e | P_EXT38 | P_DATA16)
@@ -2732,19 +2733,48 @@ static const TCGOutOpBinary outop_mulsh = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_muluh(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    /*
+     * Note from the architecture manual:
+     * If the first and second operand are identical,
+     * it will contain the high half of the multiplication result.
+     */
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_vex_modrm(s, OPC_MULX + rexw, a0, a0, a1);
+}
+
+static TCGConstraintSetIndex cset_muluh(TCGType type, unsigned flags)
+{
+    return have_bmi2 ? C_O1_I2(r, r, d) : C_NotImplemented;
+}
+
 static const TCGOutOpBinary outop_muluh = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_muluh,
+    .out_rrr = tgen_muluh,
 };
 
 static void tgen_mulu2(TCGContext *s, TCGType type,
                        TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3)
 {
     int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
-    tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_MUL, a3);
+    if (have_bmi2) {
+        tcg_out_vex_modrm(s, OPC_MULX + rexw, a0, a1, a2);
+    } else {
+        tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_MUL, a3);
+    }
+}
+
+static TCGConstraintSetIndex cset_mulu2(TCGType type, unsigned flags)
+{
+    return have_bmi2 ? C_O2_I2(r, r, r, d) : C_O2_I2(a, d, a, r);
 }
 
 static const TCGOutOpMul2 outop_mulu2 = {
-    .base.static_constraint = C_O2_I2(a, d, a, r),
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_mulu2,
     .out_rrrr = tgen_mulu2,
 };
 
-- 
2.53.0


