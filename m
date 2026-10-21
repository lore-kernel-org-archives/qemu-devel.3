Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3518606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 06:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=TK+793X6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJQ6G-00082q-GF; Wed, 21 Oct 2026 02:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJQ6B-00081c-Sr
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 02:46:58 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJQ68-0005nR-BQ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 02:46:54 -0400
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792565211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VADKjaDaUbQlY+CISwDylRGHvSYb/adK4QD4ORmVAT8=;
 b=TK+793X69lPB+TnAT5xSC29C5PHVguREekWW59I3SHdaEeJt37cbwdWjBKGeRrTs3ElxZv
 C93ccZg0PsJUebINynJXKzh0yYtFB6bBbEkSHihCS9mn1YrlC6TeouRalXJC8Qhn0i8K73
 DjakgKSomFImYuqLn96UVO1qXOTKa90=
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>, Stian Halseth <stian@itx.no>
Subject: [PATCH v2 3/7] target/sparc: Add the eight AES round instructions
Date: Wed, 21 Oct 2026 08:46:36 +0200
Message-ID: <20261021064640.3591682-4-stian@itx.no>
In-Reply-To: <20261021064640.3591682-1-stian@itx.no>
References: <20261021064640.3591682-1-stian@itx.no>
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

Implement the eight AES round instructions by using QEMU's shared
crypto/aes-round.h, gated behind the crypto CPU feature:
- AES_EROUND01/23 and last variants
- AES_DROUND01/23 and last variants

Based on OSA (Oracle SPARC Architecture) 2011, section 7.3:
AES Cryptographic Operations (4 operand)

Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Stian Halseth <stian@itx.no>
---
 target/sparc/crypto_helper.c | 89 ++++++++++++++++++++++++++++++++++++
 target/sparc/helper.h        |  8 ++++
 target/sparc/insns.decode    |  9 ++++
 target/sparc/meson.build     |  2 +-
 target/sparc/translate.c     | 16 +++++++
 5 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 target/sparc/crypto_helper.c

diff --git a/target/sparc/crypto_helper.c b/target/sparc/crypto_helper.c
new file mode 100644
index 0000000000..7dd4dd5144
--- /dev/null
+++ b/target/sparc/crypto_helper.c
@@ -0,0 +1,89 @@
+/*
+ * SPARC crypto instructions for QEMU
+ *
+ * Based on Oracle SPARC Architecture 2011
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "exec/helper-proto.h"
+#include "crypto/aes-round.h"
+
+/*
+ * SPARC four-operand AES round (Section 7.3).
+ * s2:s3 holds the state; half selects output columns 0-1 or 2-3, and
+ * key supplies their round key. dec selects decryption; last omits
+ * MixColumns/InvMixColumns. Return the selected 64-bit half.
+ *
+ * Note all 64-bit values (state and key) hold AES bytes in big-endian
+ * order, i.e. the most significant byte is the first state byte.
+ */
+static uint64_t aes_round(uint64_t key, uint64_t s2, uint64_t s3,
+                          int half, bool dec, bool last)
+{
+    AESState st, rk, r;
+    const unsigned first = HOST_BIG_ENDIAN ? 0 : 1;
+    const unsigned out = first ^ half;
+
+    st.d[first] = s2;       /* columns 0-1 */
+    st.d[first ^ 1] = s3;   /* columns 2-3 */
+    rk.d[out] = key;
+    rk.d[out ^ 1] = 0;
+
+    if (dec) {
+        if (last) {
+            aesdec_ISB_ISR_AK(&r, &st, &rk, true);
+        } else {
+            aesdec_ISB_ISR_AK_IMC(&r, &st, &rk, true);
+        }
+    } else {
+        if (last) {
+            aesenc_SB_SR_AK(&r, &st, &rk, true);
+        } else {
+            aesenc_SB_SR_MC_AK(&r, &st, &rk, true);
+        }
+    }
+
+    return r.d[out];
+}
+
+uint64_t helper_aes_eround01(uint64_t key, uint64_t s2, uint64_t s3)
+{
+    return aes_round(key, s2, s3, 0, false, false);
+}
+
+uint64_t helper_aes_eround23(uint64_t key, uint64_t s2, uint64_t s3)
+{
+    return aes_round(key, s2, s3, 1, false, false);
+}
+
+uint64_t helper_aes_dround01(uint64_t key, uint64_t s2, uint64_t s3)
+{
+    return aes_round(key, s2, s3, 0, true, false);
+}
+
+uint64_t helper_aes_dround23(uint64_t key, uint64_t s2, uint64_t s3)
+{
+    return aes_round(key, s2, s3, 1, true, false);
+}
+
+uint64_t helper_aes_eround01_l(uint64_t key, uint64_t s2, uint64_t s3)
+{
+    return aes_round(key, s2, s3, 0, false, true);
+}
+
+uint64_t helper_aes_eround23_l(uint64_t key, uint64_t s2, uint64_t s3)
+{
+    return aes_round(key, s2, s3, 1, false, true);
+}
+
+uint64_t helper_aes_dround01_l(uint64_t key, uint64_t s2, uint64_t s3)
+{
+    return aes_round(key, s2, s3, 0, true, true);
+}
+
+uint64_t helper_aes_dround23_l(uint64_t key, uint64_t s2, uint64_t s3)
+{
+    return aes_round(key, s2, s3, 1, true, true);
+}
diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 3a7f7dc129..9bfd643b09 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -122,6 +122,14 @@ DEF_HELPER_FLAGS_2(fchksm16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmean16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fslas16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fslas32, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_3(aes_eround01, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
+DEF_HELPER_FLAGS_3(aes_eround23, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
+DEF_HELPER_FLAGS_3(aes_dround01, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
+DEF_HELPER_FLAGS_3(aes_dround23, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
+DEF_HELPER_FLAGS_3(aes_eround01_l, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
+DEF_HELPER_FLAGS_3(aes_eround23_l, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
+DEF_HELPER_FLAGS_3(aes_dround01_l, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
+DEF_HELPER_FLAGS_3(aes_dround23_l, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 #define VIS_CMPHELPER(name)                                  \
     DEF_HELPER_FLAGS_2(f##name##8, TCG_CALL_NO_RWG_SE,       \
                        i64, i64, i64)                        \
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 55f8528ffe..99c9147e7d 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -596,6 +596,15 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
   NCP           10 ----- 110111 ----- --------- -----      # v8 CPop2
 }
 
+AES_EROUND01    10 ..... 011001 ..... ..... 0000 .....     @d_d_d_d
+AES_EROUND23    10 ..... 011001 ..... ..... 0001 .....     @d_d_d_d
+AES_DROUND01    10 ..... 011001 ..... ..... 0010 .....     @d_d_d_d
+AES_DROUND23    10 ..... 011001 ..... ..... 0011 .....     @d_d_d_d
+AES_EROUND01_L  10 ..... 011001 ..... ..... 0100 .....     @d_d_d_d
+AES_EROUND23_L  10 ..... 011001 ..... ..... 0101 .....     @d_d_d_d
+AES_DROUND01_L  10 ..... 011001 ..... ..... 0110 .....     @d_d_d_d
+AES_DROUND23_L  10 ..... 011001 ..... ..... 0111 .....     @d_d_d_d
+
 ##
 ## Major Opcode 11 -- load and store instructions
 ##
diff --git a/target/sparc/meson.build b/target/sparc/meson.build
index 46289c8669..af65c933bf 100644
--- a/target/sparc/meson.build
+++ b/target/sparc/meson.build
@@ -12,7 +12,7 @@ sparc_ss.add(files(
   'win_helper.c',
 ))
 sparc_ss.add(when: 'TARGET_SPARC', if_true: files('int32_helper.c'))
-sparc_ss.add(when: 'TARGET_SPARC64', if_true: files('int64_helper.c', 'vis_helper.c'))
+sparc_ss.add(when: 'TARGET_SPARC64', if_true: files('int64_helper.c', 'vis_helper.c', 'crypto_helper.c'))
 
 sparc_system_ss = ss.source_set()
 sparc_system_ss.add(files(
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index a1562f5047..16907b1085 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -101,6 +101,14 @@
 # define gen_helper_xmulx                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_xmulxhi              ({ qemu_build_not_reached(); NULL; })
 # define MAXTL_MASK                             0
+# define gen_helper_aes_eround01         ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_aes_eround23         ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_aes_dround01         ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_aes_dround23         ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_aes_eround01_l       ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_aes_eround23_l       ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_aes_dround01_l       ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_aes_dround23_l       ({ qemu_build_not_reached(); NULL; })
 #endif
 
 #define DISAS_EXIT  DISAS_TARGET_0
@@ -5418,6 +5426,14 @@ TRANS(FNMSUBd, FMAF, do_dddd, a, gen_op_fnmsubd)
 TRANS(FNMADDd, FMAF, do_dddd, a, gen_op_fnmaddd)
 TRANS(FPMADDX, IMA, do_dddd, a, gen_op_fpmaddx)
 TRANS(FPMADDXHI, IMA, do_dddd, a, gen_op_fpmaddxhi)
+TRANS(AES_EROUND01, CRYPTO, do_dddd, a, gen_helper_aes_eround01)
+TRANS(AES_EROUND23, CRYPTO, do_dddd, a, gen_helper_aes_eround23)
+TRANS(AES_DROUND01, CRYPTO, do_dddd, a, gen_helper_aes_dround01)
+TRANS(AES_DROUND23, CRYPTO, do_dddd, a, gen_helper_aes_dround23)
+TRANS(AES_EROUND01_L, CRYPTO, do_dddd, a, gen_helper_aes_eround01_l)
+TRANS(AES_EROUND23_L, CRYPTO, do_dddd, a, gen_helper_aes_eround23_l)
+TRANS(AES_DROUND01_L, CRYPTO, do_dddd, a, gen_helper_aes_dround01_l)
+TRANS(AES_DROUND23_L, CRYPTO, do_dddd, a, gen_helper_aes_dround23_l)
 
 static bool trans_FALIGNDATAi(DisasContext *dc, arg_r_r_r *a)
 {
-- 
2.43.0


