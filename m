Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840CDCA0EE8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 12:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umtWu-00017R-8k; Fri, 15 Aug 2025 08:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umtWi-00015i-5l
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 08:27:24 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umtWd-0007Yf-C9
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 08:27:19 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-76e2e60433eso1537013b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 05:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755260834; x=1755865634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aOj+DAaeetKjJupolvA9t6VmPiMUrpueVj6erK/0Xn8=;
 b=IUaarlGhjfwHe1Vzil/piSERzvNEbXwXB/QaPnC1xA187CN7NCQVYDRNeLi7VyssXw
 7FP7knLmQAH4llJSClX/Dm9/cmkOEb5WObI1OyWEuAer4ke3G325N1PPe9T46jodPq1S
 fPuU0UJAVQLXdIPIU5IMwkro8ddjoGa2NgAPpD6za7p/2v8AZcCaQ2m1uQL6Z8r117jG
 psgIJs6LMA9CzsNWoWc3QVRV8Gr1k4Mufy8Z/oUtRh2C3f4tzKvkdpBF8Zzt+b+cLfKa
 WDmLuDwElYeCTgM4FZb3PxzSvoXyKMJt3q3NZNLnQ06BkHA6T5J4DaNDODHeL9zb9HbS
 gRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755260834; x=1755865634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aOj+DAaeetKjJupolvA9t6VmPiMUrpueVj6erK/0Xn8=;
 b=nThvQxFxKswVZoqf1YLKHEe3rI2FNyLSzshPziWCoti75BCLVUv+LtBA3jkRhhmzIx
 a0z8skMw/EKOOtSmmG/FgWNzN5dXJ0s4VjJQr6ZsgsDAhOG5WgD8oeXiCNIaacOIeyHu
 FZ7QCQWJPfafBtIOTV4vdLWRlkYoMBpxKqaUeK0ZImSBNwCfCCGJHJNov4AdP3n5i4+F
 0tsrJ0HZC5VDfKyP5OHUbWbm5Ta1+g1FIAHSmHnw/qSoElx7XLSQPwbIiPZecYrkvS1q
 Ib+17y4Z+VOYq3xg3B0spSYCtj3cKEBceN5Nj7FpJepMH2szkW9v84kHQJPJDJOdnWtK
 MWWw==
X-Gm-Message-State: AOJu0Yz4LyGW/O/YjGhFZRCC9iPFZB+Wx38scoRf4ShFIqCCUun5OUeZ
 yCQ1LBNKgqENbCltW6d+joj+ymuQmmSzdWASeRvWe1LHj4VM74F7ZjYAP5seBrFqAQNdIptJaUw
 /eDnC504=
X-Gm-Gg: ASbGncsUMbFr3u7453cpurgxenidR6qTOAktQp/DaCzjXMRKfigYCLbgvlAUuODfkg/
 d4CBXvxnjYDL0Hg0TScZkiAGyNJJ30F2KoYXgwvwtSG3LqIf6unKHahHJzj4ERvxtCmOLvvHfcb
 HXGoRxdbxuhT6mr6UfuwRtD4Fcae/i2QFKz+CwYr19lTldmTESrFU0JrE/GHCb1X8eH6p3yX+Tu
 mdhpESlnI3kUZVfytyZQdr0O6/StE9/j37mccM3mBfqZaWn9+52FjcpRFNzqqdmOFvUzcNG/iDn
 3+p77BVmfmMMVgWhRB4hDY2O0WI2vIjtxSgJcUdCjttCDZIE3FhvFsQo1nZezEG4UULE46BQy/w
 0N+IC2xb6DD9RtoLRb2909Os3I0tFUXTMxA2WmIH3Fl8qiEYQFSvHXkCdDQ==
X-Google-Smtp-Source: AGHT+IGp3B1bVyBHwiVNJnZBhlua/dk1ppVDoBh7gVkc3CP6acBER4t9hJtXlARjwFKNY3poGgveTg==
X-Received: by 2002:a05:6a20:3949:b0:234:4b39:182c with SMTP id
 adf61e73a8af0-240d2f214ebmr3762884637.38.1755260833923; 
 Fri, 15 Aug 2025 05:27:13 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e45292c86sm1053475b3a.48.2025.08.15.05.27.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 05:27:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] target/arm: Implement FEAT_LSE128
Date: Fri, 15 Aug 2025 22:26:52 +1000
Message-ID: <20250815122653.701782-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815122653.701782-1-richard.henderson@linaro.org>
References: <20250815122653.701782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

This feature contains the LDCLRP, LDSETP, and SWPP instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  5 ++++
 target/arm/tcg/translate-a64.c | 49 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/a64.decode      |  7 +++++
 3 files changed, 61 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index e3d4c3d382..182b301c86 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -411,6 +411,11 @@ static inline bool isar_feature_aa64_lse(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ISAR0, ATOMIC) != 0;
 }
 
+static inline bool isar_feature_aa64_lse128(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, ATOMIC) >= 3;
+}
+
 static inline bool isar_feature_aa64_rdm(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ISAR0, RDM) != 0;
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d0639e29cf..976bf4df32 100644
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
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8c798cde2b..70ed9610af 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -536,6 +536,13 @@ SWP             .. 111 0 00 . . 1 ..... 1000 00 ..... ..... @atomic
 
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
-- 
2.43.0


