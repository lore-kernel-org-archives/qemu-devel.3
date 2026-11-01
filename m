Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F899606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=xEhxojOF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNWT5-0004SZ-Qs; Sun, 01 Nov 2026 09:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xNWSz-0004Ry-QH
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:23:26 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xNWSw-0007aS-84
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=PyVwOcN/hhc1g3laVb5jXTXsEpSrES2SHBXCp7jARMs=; b=xEhxojOFi/PuGcyRhTgqsRbT94
 Mz4v8Sa1L144ywhCg8rSQrKq/H/QuYkGGYbwtiEbimFuK5luFZZu05Z9P1ZRVwJXV9F2VBKdzts0U
 TJ7RnP0uJfVUCoRw6qIwl89zITUDUsJKXGYjysW32ALfJx19mFfUkUz76aXo7M5yGp7jg02bCu5SB
 XSEJ+DIVV8qV7u5oZ2btseWPj/Evluptl0M+AepjGBp0hMmkQIPxbLahMZJA33Av4iy1foCUmt+53
 ke1hfPA2c3+J8KHy02pWNLxTpIJ98L6iEkNcuY4567TV6l4Ee9Q1P+T5NojNvPrGHf/iE1BEZKpYB
 At3ZLo0BXBLxGMgRj/uRHsvJzeajtCkKpLvnlv0XLxLENe0tfc8K9zwHzNVbUm15HCdOwIaGBnnKO
 UIJfESDLDThe4vMjK4+haHZttTRd5+IpbvJ5mRnVgB1byXg+eKHWFxAwywi6I+QbukbGsJMin8Bo3
 7CofJ4ltPpxIMFtTnA8e5H0H77kiXul+Tlpq1CxNvvwu5KwXwMEaD+CaB7/j11pc1gRFGj55M3mtd
 /SedqvP+uYuXSGPq++OztygiNGO6Wq2WWA/h+yjySZcBJNPHUU22GYpSOSr0pi6O4vm5YZE6wFlCa
 uuwSBjtfwQ5auq//JIHaP+SqsgkUeB7Cs4HQ60BKQ=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1xNWS7-0055Ed-EN
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 14:22:31 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org
Date: Sun,  1 Nov 2026 14:22:51 +0000
Message-ID: <20261101142312.983515-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101142312.983515-1-mark.cave-ayland@ilande.co.uk>
References: <20261101142312.983515-1-mark.cave-ayland@ilande.co.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 1/3] target/sparc: Model block-initializing stores
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stian Halseth <stian@itx.no>

On T4 and later, a block-initializing store to the first doubleword of
a 32-byte block zeroes the rest of the block (measured on a T4).
glibc's niagara4 memset and Linux's NG4memset rely on this, and
OpenSSL's T4 AES code uses the FP form, stdfa.

QEMU only accepted the integer form, on HYPV CPUs, as a plain store, so
with the crypto hwcap a multiarch glibc memset leaves stale data. Accept
both forms when the CPU has the crypto feature, which implies T4 or
later, and zero the 32-byte block as T4 does.

Signed-off-by: Stian Halseth <stian@itx.no>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261028113816.1651212-2-stian@itx.no>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/translate.c | 43 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1fc8439a475..416625c6dc9 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1853,6 +1853,27 @@ static void gen_ld_asi(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
     }
 }
 
+/*
+ * On T4 and later, a block-initializing store to the first doubleword of
+ * a 32-byte block zeroes the rest of the block. glibc and Linux memset
+ * rely on this and store only one doubleword per block when zeroing.
+ */
+static void gen_blkinit_zero(DisasContext *dc, DisasASI *da, TCGv addr,
+                             MemOp size)
+{
+    TCGLabel *skip = gen_new_label();
+    TCGv t = tcg_temp_new();
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    tcg_gen_brcondi_tl(TCG_COND_TSTNE, addr, 31, skip);
+    /* A narrower store also zeroes the rest of the first doubleword. */
+    for (int i = size == MO_64 ? 8 : 0; i < 32; i += 8) {
+        tcg_gen_addi_tl(t, addr, i);
+        tcg_gen_qemu_st_i64(zero, t, da->mem_idx, MO_UQ);
+    }
+    gen_set_label(skip);
+}
+
 static void gen_st_asi(DisasContext *dc, DisasASI *da, TCGv src, TCGv addr)
 {
     switch (da->type) {
@@ -1863,12 +1884,19 @@ static void gen_st_asi(DisasContext *dc, DisasASI *da, TCGv src, TCGv addr)
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
+            gen_blkinit_zero(dc, da, addr, da->memop & MO_SIZE);
+        }
         /* fall through */
 
     case GET_ASI_DIRECT:
@@ -2169,6 +2197,17 @@ static void gen_stf_asi(DisasContext *dc, DisasASI *da, MemOp orig_size,
         }
         break;
 
+    case GET_ASI_DTWINX:
+        /* stdfa with a block-initializing ASI, T4 and later */
+        if (orig_size == MO_64 && (dc->def->features & CPU_FEATURE_CRYPTO)) {
+            gen_blkinit_zero(dc, da, addr, MO_64);
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
2.47.3


