Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AE7606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=NtCwDwBZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKDgK-0003hs-6Z; Fri, 23 Oct 2026 07:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xKDgB-0003h4-2K
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:43:24 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xKDg7-0006oL-F3
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:43:22 -0400
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792755797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G72Ty5s5MZE1t0UB1o8UW1dNTu+Fa9Rzkj1yQvMWqjg=;
 b=NtCwDwBZQ3rN9Eq4S5U4Zx4Hug5ivNMtumLvyGjpZUvCErFzAwKdeckN9MVG9/zb8RCfao
 tqyJ7rPIxNIWYkuFCkBR1S1EwQpbhtOS+MzVZozTnXn74b9UCj9Bp58ggFnoNmMO+aQmnm
 y5zs+UwK4IQz8otOE5mFqU7SVfcvfag=
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>, Stian Halseth <stian@itx.no>
Subject: [PATCH 1/2] target/sparc: Model block-initializing stores
Date: Fri, 23 Oct 2026 13:43:01 +0200
Message-ID: <20261023114303.576319-2-stian@itx.no>
In-Reply-To: <20261023114303.576319-1-stian@itx.no>
References: <20261023114303.576319-1-stian@itx.no>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=91.189.121.228; envelope-from=stian@itx.no;
 helo=mx.itxnorge.no
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On T4 and later, a block-initializing store to the first doubleword of
a 32-byte block zeroes the rest of the block (measured on a T4).
glibc's niagara4 memset and Linux's NG4memset rely on this, and
OpenSSL's T4 AES code uses the FP form, stdfa.

QEMU only accepted the integer form, on HYPV CPUs, as a plain store, so
with the crypto hwcap a multiarch glibc memset leaves stale data. Accept
both forms when the CPU has the crypto feature, which implies T4 or
later, and zero the 32-byte block as T4 does.

Signed-off-by: Stian Halseth <stian@itx.no>
---
 target/sparc/translate.c | 42 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1fc8439a47..009340a3bb 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1853,6 +1853,26 @@ static void gen_ld_asi(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
     }
 }
 
+/*
+ * On T4 and later, a block-initializing store to the first doubleword of
+ * a 32-byte block zeroes the rest of the block. glibc and Linux memset
+ * rely on this and store only one doubleword per block when zeroing.
+ */
+static void gen_blkinit_zero(DisasContext *dc, DisasASI *da, TCGv addr)
+{
+    TCGLabel *skip = gen_new_label();
+    TCGv t = tcg_temp_new();
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    tcg_gen_andi_tl(t, addr, 31);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t, 0, skip);
+    for (int i = 0; i < 32; i += 8) {
+        tcg_gen_addi_tl(t, addr, i);
+        tcg_gen_qemu_st_i64(zero, t, da->mem_idx, MO_UQ);
+    }
+    gen_set_label(skip);
+}
+
 static void gen_st_asi(DisasContext *dc, DisasASI *da, TCGv src, TCGv addr)
 {
     switch (da->type) {
@@ -1863,12 +1883,19 @@ static void gen_st_asi(DisasContext *dc, DisasASI *da, TCGv src, TCGv addr)
         if (TARGET_LONG_BITS == 32) {
             gen_exception(dc, TT_ILL_INSN);
             break;
-        } else if (!(dc->def->features & CPU_FEATURE_HYPV)) {
-            /* Pre OpenSPARC CPUs don't have these */
+        } else if (!(dc->def->features &
+                    (CPU_FEATURE_HYPV | CPU_FEATURE_CRYPTO))) {
+            /*
+             * Pre-OpenSPARC CPUs lack block-init stores. Crypto
+             * instructions imply T4 or later, which has them.
+             */
             gen_exception(dc, TT_ILL_INSN);
             break;
         }
         /* In OpenSPARC T1+ CPUs TWINX ASIs in store are ST_BLKINIT_ ASIs */
+        if (dc->def->features & CPU_FEATURE_CRYPTO) {
+            gen_blkinit_zero(dc, da, addr);
+        }
         /* fall through */
 
     case GET_ASI_DIRECT:
@@ -2169,6 +2196,17 @@ static void gen_stf_asi(DisasContext *dc, DisasASI *da, MemOp orig_size,
         }
         break;
 
+    case GET_ASI_DTWINX:
+        /* stdfa with a block-initializing ASI, T4 and later */
+        if (orig_size == MO_64 && (dc->def->features & CPU_FEATURE_CRYPTO)) {
+            gen_blkinit_zero(dc, da, addr);
+            d64 = gen_load_fpr_D(dc, rd);
+            tcg_gen_qemu_st_i64(d64, addr, da->mem_idx, memop | MO_ALIGN);
+        } else {
+            gen_exception(dc, TT_ILL_INSN);
+        }
+        break;
+
     case GET_ASI_BLOCK:
         /* Valid for stdfa on aligned registers only.  */
         if (orig_size == MO_64 && (rd & 7) == 0) {
-- 
2.43.0


