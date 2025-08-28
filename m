Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD36FCA0FF2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraug-0004JK-Tg; Thu, 28 Aug 2025 07:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauM-0003hI-E1
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:35:14 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauK-00065y-5B
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:35:09 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3c6743a10e3so419766f8f.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380906; x=1756985706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZQrm7QYldVzvYXlm3oou4nEhjLJT00tZjC2U4TRau+Y=;
 b=I1ftlSUJoh4cF1/lbx/+xlt/FG4MsQzDK7pJwqqC0cn3xseWNObpoI/NUmwHuYjNsG
 qjS4HYiTf9j+h7QsX4QuzD50V1jhDm0oc3Y6rVNpEGDZ3VsOsVAHId2FMtDuKR3ER421
 lWVwH2qm5qYupkpQ4UOGE8dFmh4tURjJHAXegfRqQuVcjzEPn49GIREEWb6/u01OELnC
 VKYZBp9nnqj4dn86sUMq7vll5MywNcT1CriMaoMHj+t5UuJe8QckJPJrJBczSi2f6Vub
 TR99vxDSjCWMzvnSdicAo0Lz90imVj9j20AD2TLkXjqiRbfUUQnMk89NMKudUcZyKqna
 rLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380906; x=1756985706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQrm7QYldVzvYXlm3oou4nEhjLJT00tZjC2U4TRau+Y=;
 b=hS7Ww7b1ipsX1ds/cP0a4zcM8XFVWAk57YpIG8bl7gPmX22rMCStpEE8+0CtaibhUX
 nLeRUvPbjGl7CRlx2RYit+Z2KoHjtBGAO00EA3+dEc6YKZSPtqp1AAfEV5xOmpQULBhf
 5DFvaw6xp5gWLmdD+fVPDWI2aPhuvd0mgXAfDSHV0skYYJfVY+inYbq2nF5l7T1I2GLG
 MiuHshQfWUAIU+tMbEmGW3Z5vPqKvrg2WnZpxkXNdxD4ZXKyjFOeQwJxgVi8bNn++uKe
 kFtaQcQncQD9wjrZhAHAjw4zZGf/+lLs7wRF3iReMFdIRsYZtlU4Mcp09OXQMwjIMDMv
 KjbA==
X-Gm-Message-State: AOJu0YwUYiZadXe//3W3gXYnUA7az2IEp8v1Xv9xNVQI7psmPiWCyPiH
 LSYniyTc6Hr3P++pl0kjvIfI8f9iDpGRsplL7jAbRslCUxWiQGS5G+8JqaYHd+REIWUAiwR4ItX
 QzeDW
X-Gm-Gg: ASbGnctoFSz+H8R94TW3jmazloIoG0k1PzGSV3P4UX+y5aZQkUtxh2T8P0c/GqDdVMe
 ASHctUfn02KyEsg/1NvG4su6+CX6/Yf1r0Nmj38vMOA2fpnlirTXcQiXgjKHAYnVtLBIn2ZNMAu
 BFZ09RfklsU94mbsP1w/NcuWS+QYpiIds2i/wFcrpq46lJ9SINa+vdi8mhwiMGa0stl0bHioTue
 3iCRB/EMhX3lARvyyNKMIvJKOzXIxJuCmsw9SrBK1tusp18Bc8Hw6wUaUDx7mE1cktpKo2v37j0
 /KbGGLImXtq7ydMQzjWSrV6BKdHinnqbUwJQlld1BLMeBIZm7yz11Y3LdxRMHeeiliXWuVard91
 ruiZm+N1BfTKaap8RTyXrLmx22jOhiloPDdGCAqcJMx5Vo9Oe6Q==
X-Google-Smtp-Source: AGHT+IF3SUjYvhzkWMCFiaLv4kCOZT9jDQxvu7JjXvT6ZDtd0zTnX5W4f1WnItvYpZBphCKkzCk63Q==
X-Received: by 2002:a05:6000:40dd:b0:3b7:dd87:d730 with SMTP id
 ffacd0b85a97d-3c5dcd03eecmr16610257f8f.52.1756380906081; 
 Thu, 28 Aug 2025 04:35:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.35.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:35:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/32] target/arm: Implement FEAT_LSE128
Date: Thu, 28 Aug 2025 12:34:27 +0100
Message-ID: <20250828113430.3214314-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This feature contains the LDCLRP, LDSETP, and SWPP instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250815122653.701782-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h      |  5 ++++
 target/arm/tcg/a64.decode      |  7 +++++
 target/arm/tcg/translate-a64.c | 49 ++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 451b37b5b39..e49e0ae3af0 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -411,6 +411,11 @@ static inline bool isar_feature_aa64_lse(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ISAR0, ATOMIC) >= 2;
 }
 
+static inline bool isar_feature_aa64_lse128(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, ATOMIC) >= 3;
+}
+
 static inline bool isar_feature_aa64_rdm(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ISAR0, RDM) != 0;
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 766c610c019..55ff6c504f1 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -546,6 +546,13 @@ SWP             .. 111 0 00 . . 1 ..... 1000 00 ..... ..... @atomic
 
 LDAPR           sz:2 111 0 00 1 0 1 11111 1100 00 rn:5 rt:5
 
+# Atomic 128-bit memory operations
+&atomic128      rn rt rt2 a r
+@atomic128      ........ a:1 r:1 . rt2:5 ...... rn:5 rt:5   &atomic128
+LDCLRP          00011001 .   .   1 ..... 000100 ..... ..... @atomic128
+LDSETP          00011001 .   .   1 ..... 001100 ..... ..... @atomic128
+SWPP            00011001 .   .   1 ..... 100000 ..... ..... @atomic128
+
 # Load/store register (pointer authentication)
 
 # LDRA immediate is 10 bits signed and scaled, but the bits aren't all contiguous
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0ba537268cd..37bedc3780b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3753,6 +3753,55 @@ TRANS_FEAT(LDUMAX, aa64_lse, do_atomic_ld, a, tcg_gen_atomic_fetch_umax_i64, 0,
 TRANS_FEAT(LDUMIN, aa64_lse, do_atomic_ld, a, tcg_gen_atomic_fetch_umin_i64, 0, false)
 TRANS_FEAT(SWP, aa64_lse, do_atomic_ld, a, tcg_gen_atomic_xchg_i64, 0, false)
 
+typedef void Atomic128ThreeOpFn(TCGv_i128, TCGv_i64, TCGv_i128, TCGArg, MemOp);
+
+static bool do_atomic128_ld(DisasContext *s, arg_atomic128 *a,
+                            Atomic128ThreeOpFn *fn, bool invert)
+{
+    MemOp mop;
+    int rlo, rhi;
+    TCGv_i64 clean_addr, tlo, thi;
+    TCGv_i128 t16;
+
+    if (a->rt == 31 || a->rt2 == 31 || a->rt == a->rt2) {
+        return false;
+    }
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+    mop = check_atomic_align(s, a->rn, MO_128);
+    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, a->rn), false,
+                                a->rn != 31, mop);
+
+    rlo = (s->be_data == MO_LE ? a->rt : a->rt2);
+    rhi = (s->be_data == MO_LE ? a->rt2 : a->rt);
+
+    tlo = read_cpu_reg(s, rlo, true);
+    thi = read_cpu_reg(s, rhi, true);
+    if (invert) {
+        tcg_gen_not_i64(tlo, tlo);
+        tcg_gen_not_i64(thi, thi);
+    }
+    /*
+     * The tcg atomic primitives are all full barriers.  Therefore we
+     * can ignore the Acquire and Release bits of this instruction.
+     */
+    t16 = tcg_temp_new_i128();
+    tcg_gen_concat_i64_i128(t16, tlo, thi);
+
+    fn(t16, clean_addr, t16, get_mem_index(s), mop);
+
+    tcg_gen_extr_i128_i64(cpu_reg(s, rlo), cpu_reg(s, rhi), t16);
+    return true;
+}
+
+TRANS_FEAT(LDCLRP, aa64_lse128, do_atomic128_ld,
+           a, tcg_gen_atomic_fetch_and_i128, true)
+TRANS_FEAT(LDSETP, aa64_lse128, do_atomic128_ld,
+           a, tcg_gen_atomic_fetch_or_i128, false)
+TRANS_FEAT(SWPP, aa64_lse128, do_atomic128_ld,
+           a, tcg_gen_atomic_xchg_i128, false)
+
 static bool trans_LDAPR(DisasContext *s, arg_LDAPR *a)
 {
     bool iss_sf = ldst_iss_sf(a->sz, false, false);
-- 
2.43.0


