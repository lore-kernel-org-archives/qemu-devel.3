Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AD6606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=QvY+9boR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJmoI-0002x8-Rf; Thu, 22 Oct 2026 03:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJmnl-0002p4-GZ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:01:29 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJmni-0005vn-4p
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:01:24 -0400
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792652469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Klyy6f51u+zXBdawzmvctyasq9zfdOiKeiqql16F1L8=;
 b=QvY+9boRFHAOxdzFhmHqhpa6n+TipGfwOY1WHQkSd0SuzMTu44xnGH+X+tGlH8OEg5Tiwn
 QgQjiH0v5CYZBBTicrWwP3reTlU0k/gW6FlhNSrWqxaTFnsFzhZ7r2e+et/BXfbfoTPAuO
 hKVamnKZzSqNmL2fc0Dz68YJriWtJEU=
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>, Stian Halseth <stian@itx.no>
Subject: [PATCH v3 5/8] target/sparc: Add the CRC32C instruction
Date: Thu, 22 Oct 2026 09:00:56 +0200
Message-ID: <20261022070059.3861291-6-stian@itx.no>
In-Reply-To: <20261022070059.3861291-1-stian@itx.no>
References: <20261022070059.3861291-1-stian@itx.no>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Implement the CRC32C instruction according to OSA
(Oracle SPARC Architecture) 2011 section 7.19 and
set the CRC32C bit in the CFR.

Using QEMU's crc32c.h and bswap.h.
Gated behind the crypto CPU feature and disabled for sparc32.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Stian Halseth <stian@itx.no>
---
 target/sparc/crypto_helper.c | 21 +++++++++++++++++++++
 target/sparc/helper.h        |  1 +
 target/sparc/insns.decode    |  1 +
 target/sparc/translate.c     |  4 +++-
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/target/sparc/crypto_helper.c b/target/sparc/crypto_helper.c
index f04bd3569d..7189814b75 100644
--- a/target/sparc/crypto_helper.c
+++ b/target/sparc/crypto_helper.c
@@ -10,6 +10,8 @@
 #include "exec/helper-proto.h"
 #include "crypto/aes-round.h"
 #include "crypto/aes.h"
+#include "qemu/bswap.h"
+#include "qemu/crc32c.h"
 
 /*
  * SPARC four-operand AES round (Section 7.3).
@@ -145,3 +147,22 @@ uint64_t helper_aes_kexpand2(uint64_t rs1, uint64_t rs2)
 {
     return aes_kexpand(rs1, (uint32_t)rs2);
 }
+
+/*
+ * CRC32C Operation 3-operand (Section 7.19)
+ * Accumulate CRC32C over the eight bytes of rs2, most significant first.
+ */
+uint64_t helper_crc32c(uint64_t rs1, uint64_t rs2)
+{
+    uint8_t buf[8];
+    /* IV and result are byte-swapped in the register. */
+    uint32_t crc = bswap32((uint32_t)rs1);
+
+    stq_be_p(buf, rs2);
+
+    /* Undo crc32c()'s final inversion for the instruction's raw result. */
+    crc = crc32c(crc, buf, sizeof(buf)) ^ UINT32_MAX;
+
+    /* Result lives in the low 32 bits; upper half reads as zero. */
+    return (uint64_t)bswap32(crc);
+}
diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 685b89d9c5..1320f5ebba 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -133,6 +133,7 @@ DEF_HELPER_FLAGS_3(aes_dround23_l, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_2(aes_kexpand0, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_3(aes_kexpand1, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
 DEF_HELPER_FLAGS_2(aes_kexpand2, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(crc32c, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 #define VIS_CMPHELPER(name)                                  \
     DEF_HELPER_FLAGS_2(f##name##8, TCG_CALL_NO_RWG_SE,       \
                        i64, i64, i64)                        \
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 96791c7658..05c1e73d7f 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -577,6 +577,7 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPMAXU32    10 ..... 110110 ..... 1 0101 1111 .....    @d_d_d
     AES_KEXPAND0 10 ..... 110110 ..... 1 0011 0000 .....   @d_d_d
     AES_KEXPAND2 10 ..... 110110 ..... 1 0011 0001 .....   @d_d_d
+    CRC32C       10 ..... 110110 ..... 1 0100 0111 .....   @d_d_d
 
     FLCMPs      10 000 cc:2 110110 rs1:5 1 0101 0001 rs2:5
     FLCMPd      10 000 cc:2 110110 ..... 1 0101 0010 ..... \
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ad32b53cc3..562bfb506b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -111,6 +111,7 @@
 # define gen_helper_aes_dround23_l       ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_aes_kexpand0         ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_aes_kexpand2         ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_crc32c               ({ qemu_build_not_reached(); NULL; })
 #endif
 
 #define DISAS_EXIT  DISAS_TARGET_0
@@ -3041,7 +3042,7 @@ TRANS(RDSTRAND_STATUS, HYPV, do_rd_special, true, a->rd, do_rdstrand_status)
 
 static TCGv do_rdcfr(DisasContext *dc, TCGv dst)
 {
-    return tcg_constant_tl(CFR_AES);
+    return tcg_constant_tl(CFR_AES | CFR_CRC32C);
 }
 
 TRANS(RDCFR, CRYPTO, do_rd_special, true, a->rd, do_rdcfr)
@@ -5438,6 +5439,7 @@ TRANS(AES_DROUND01_L, CRYPTO, do_dddd, a, gen_helper_aes_dround01_l)
 TRANS(AES_DROUND23_L, CRYPTO, do_dddd, a, gen_helper_aes_dround23_l)
 TRANS(AES_KEXPAND0, CRYPTO, do_ddd, a, gen_helper_aes_kexpand0)
 TRANS(AES_KEXPAND2, CRYPTO, do_ddd, a, gen_helper_aes_kexpand2)
+TRANS(CRC32C, CRYPTO, do_ddd, a, gen_helper_crc32c)
 
 /* AES key expansion with RCON selected by the 5-bit immediate in imm */
 static bool trans_AES_KEXPAND1(DisasContext *dc, arg_r_r_i_r *a)
-- 
2.43.0


