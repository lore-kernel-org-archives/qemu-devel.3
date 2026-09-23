Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85816C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Tgn-0008JO-Fh; Wed, 23 Sep 2026 16:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9TgA-0008B0-LL
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:35:00 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tg9-00051P-0M
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:58 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-8674704dab1so1284536b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790195695; x=1790800495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PsKFn4pRALYWaoNgjaJtEuJl3huqiCPhAS0dlA5jb+M=;
 b=Xo0PT5PshtghWCteUDXzchdj5YfARYFGi1NsdBH4qlCN2kttmmb1SrzZ7DdAQylr7J
 cCMpLtvVulmY8badoDeTmLxEW4FTJf0NXEDuL1q8/tlTZA+MyCzet4kwANgSsjx/gjx2
 3+YSJgGND/EuTWl+9qoLNMsiC+iFdZwTiWBskxYzfl7Yj+gbFznnpNqulASS9iGfl4l2
 ULyipZKYlrzqyVY/OJ7qtBZtQY4+uNrAy6BMvFd+xiar7j7/ksOdPf1H7iUbSpsyAzx8
 Sd3/ReRuBTZPoDdhCnMbutMKYXYKt2jAxTzcjnLvVKfLiJ8HsSHJyc/jIcJIGwMbHIuz
 6jhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790195695; x=1790800495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PsKFn4pRALYWaoNgjaJtEuJl3huqiCPhAS0dlA5jb+M=;
 b=YHELgafXGi1NXrCot/6iNRAsdLIFruZ11KhTdUTXkA/FOLVW3K9yvq54oyoINqHaB/
 T+8G2TcGh8kdBsFRl81aft2EccJfAxLKbRSEBjcVjrcsw0OKD+8idGkEdP/TJz54851R
 1VvF2QdPdab8voglm38qjBrR75QBuWJUIV63eB57JZ2u6hMtkZfO7As3GKehTqrkpDR3
 ajgOaKUG6ndxd8OarUsk/OCedUpSbOSSWJgvsSttKa4y+WN4u+oM6h2yGbRkvYA9R7Pj
 k+zcPTl/6G1bb6J07+BjqHcreIbiVfmnRo/DrFP9jadscVgtLoD0cSKK7gBdd5H3tTZi
 oeSA==
X-Gm-Message-State: AFuF++mtIEb5s4bqsBbts2+na2CifKr59F3OgbI3K7x4AT1gr5biaNjl
 TkWe47LTn8mJtTwjrJ793ftRewZEWPRCUq4KVxBDA6t1jvmys+IcZiWRWXxYv3buFm+Pe3OWVki
 EAB4d
X-Gm-Gg: AYBFou3T7RtrMzmn5RLkCcqnzXYRIntBP3UxwzToSr7DPxRd91fsuKIs8/827fA+7Qi
 IbJDSRX7Zv5WyBLvXD2I6HCSOEyK9DJVuFKrBUHLsKrAh68HnxpqccEdpVqQ12J2QHq463lAzIB
 9rpn03oG3XtmSfUSJGXimgmUIjksIZc88XmlweEp0pypKHadMPn2skD8a/DgwDwjUISPWE1E9do
 oCTkcCGSYhuL8RRmvD5GBZojVAhu9LdtI+ReAz8EtKAOt20v2YrYfeFwD39IYrJGpcwB8Oi7j2p
 U/i9yY4J9oW2rAglDLE2EbubrtByA1DFShcw0P+KHpR5wgnAxGytF94D0Fp/Hbz0DrLxziooA16
 wM9jqUI3oG0Mp4Xldm9TFJrJCh+l6BbElF8FeNh48v/8+FclsEcfQyD74sqW89tXsvFIasFW1+E
 ZV3YQkAG9DuGA7JrIuNuvlKjDtBsl+EEesVcZ29NAF+tag97b4qQLru/JzMjW4rPgjZiDINCL4w
 dbyZpiZVeKOXMjJpFStodqFYwOQ9FY=
X-Received: by 2002:a05:6a00:3d0a:b0:874:32d1:d3db with SMTP id
 d2e1a72fcca58-87e9c543f70mr237263b3a.10.1790195695163; 
 Wed, 23 Sep 2026 13:34:55 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d3894211asm1678638b3a.36.2026.09.23.13.34.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:34:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/16] tcg/x86_64: Use the mulx insn from the bmi2 isa
Date: Wed, 23 Sep 2026 13:34:38 -0700
Message-ID: <20260923203441.31276-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923203441.31276-1-richard.henderson@linaro.org>
References: <20260923203441.31276-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
index 2c8f1f3e580..590c9c24020 100644
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
+        tcg_out_vex_modrm(s, OPC_MULX + rexw, a1, a0, a2);
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


