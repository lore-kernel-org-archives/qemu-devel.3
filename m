Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B52CCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYh3-0001IO-UB; Wed, 20 May 2026 00:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgy-0001HX-AZ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:38:00 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgv-0003tr-4Z
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:59 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dcdaf06498so2937095a34.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251876; x=1779856676; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LzsLE7V3yJR1YDCQoTm+nmXNU5W5m+tBzWuEu872kcw=;
 b=kUPUWoejPAyuk1kaZ0J6i4t0lqI6KjJLkTVE90JC7O2H4BBSFRJsbsRfENom2GDfvm
 y5djYpEG+bWu2Y4ZaGiYSWB2XQHAAWJhrnd5fbWQmNQnxmM/ANLemx688zHlUFbY9Ubn
 2L615YgmZKi+TWMuXF8xXgwO7OdCnoOMQiBcO2VhGUNX+Z6qRyzJLeBGwZNUOBzNCPrw
 hws0OwRDdCreSia6xxmTU8+7db0vBZryyBJ5twHuEqdxNKhN58LkiEN61Rw0PRE7ohmd
 Dhtr4qk2Jh3BkyNjvm9lvWRvrivdirTmaqJAJ4jF6qLKec9ehwKPmCqMNe/QMeb4uASk
 68CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251876; x=1779856676;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LzsLE7V3yJR1YDCQoTm+nmXNU5W5m+tBzWuEu872kcw=;
 b=HN9NiU4AdCTneKmu4plZVbd1KwyOotrJquObWo2QMEld/KOCQgrcvZ5OWA897/WHV+
 hCG/0BPdlQuM94s8hHJgd0dRxMkSCs/ME/nT+NIuE3NPxjE/7yM5FrEz06exxB9MGpsC
 8vCKat2yOzX/osBFqLV/Oz3rWzrDMTFSf7XYL3Ephcip3f8i2p3WU2jiEj3f0zoJbkNA
 a10/Msdr2ys5VH53PTvQdUWB1dqew4jioI5LHGfQLag/z3CLQuI5Qln+qsHGN/FWfHJ7
 RB7hA6C4VuIOFMrREH8L6NSGVmM1AY6edOGAAmLfRLbNDAyYxT53lDxdFS3lCx5l+IPm
 Oriw==
X-Gm-Message-State: AOJu0YySP0G0SRBBfW2PVlhwtHZAeLxfeLw4AeIbkF4TD1LIxaW7y4zz
 ujfKoKTpT09oZdtwIewUKTNCe4I+Ds8X24T3mQGLkta5rIn+ErkvYUfxLFDnti1j
X-Gm-Gg: Acq92OFTbHjTPpON+i+fUSJCnvtD1q2Maofrf2DZcAJ9KCC1rpRWCA1y2Y9jR2KbS6n
 s3mX3VL6dJVAUTbPsvRjSE86BOhRfoz85Am7+04rFQJHM7eWmlwv8Hmx7mOJaSt7Mawybarcxld
 1mD2nCLuJ6iuD45kUS6eJrceL7ZowazDI1uBh1A7YmvZ+lB8qqtO7R2tcOhPI8YfjrjK+SYG+BI
 iQd4GdLh8YxuH/ZR2o6hg6Mdzj+5uoy3hbZqEcfYysy4p+17Iy6VILiCv4/NqtjQz2JLAeHwaNO
 Ow08QdYl8+7zYLIK1Gcevjjyzlzy1M1IgC343L7KbZjQGTL7nUuKKUGQ6ZC3boLxSmBrSV5gODt
 sLTt5nLG/MZniv89jGQbtgrZ5LpQfgsM3HKM2hgUXaaeAOLxMn5+mZC1z/0R/NQ3XpD3iv7JOgI
 PgtUZcxyEKZqVkYQ2xh5Ao0NEsEtDhvEEYb9i613gDPizGvP4tT6tRr6BWib0CYSAVT8yCMzbvY
 C85MKKAGfed72qLRytSemcTOmBmXIVq2RiRPh/uI4Nv5lffUaCd4IXsb+OZ8t0tgOSM
X-Received: by 2002:a05:6830:8289:b0:7dc:3db6:eef with SMTP id
 46e09a7af769-7e4ea031b66mr14491409a34.2.1779251875872; 
 Tue, 19 May 2026 21:37:55 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:55 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:29 -0600
Subject: [PATCH v10 35/45] target/mips: add Octeon HSH COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-35-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add helper support for the Octeon HSH hash selectors. This includes the
base HSH data/IV windows, MD5, SHA1, SHA256, and SHA512 transform paths,
and the shared HSH/SHA512 register-window readback and write operations.

The SHA512 path shares the wide HSH register bank with SHA3, SNOW3G, and
ZUC. Keep the aliased readback and write paths centralized so selector
decode can route register accesses through these helpers when side
effects are required.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v9 -> v10:
  - Remove references to shared-mode tracking; aliased state is kept in the
    architectural HSH register banks.

Changes v8 -> v9:
  - Split HSH/SHA helpers into their own COP2 helper patch.
  - Replace generic selector dispatch with per-operation HSH helpers.
  - Keep shared-window readback and write helpers grouped with HSH.
  - Add matching helper.h declarations with the helper implementation.
---
 target/mips/helper.h            |  53 +++++
 target/mips/tcg/octeon_crypto.c | 486 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 539 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 10f47d4fe0..436a61b2d1 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -28,6 +28,30 @@ DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 /* Octeon COP2 selector operation helpers. */
 DEF_HELPER_1(octeon_cp2_mf_crc_iv_reflect, i64, env)
 DEF_HELPER_1(octeon_cp2_mf_sha3_dat24, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_dat0, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_dat1, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_dat2, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_dat3, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_dat4, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_dat5, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_dat6, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_dat7, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_dat8, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_dat9, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_dat10, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_dat11, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_dat12, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_dat13, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_dat14, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_dat15, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_iv0, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_iv1, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_iv2, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_iv3, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_iv4, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_iv5, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_iv6, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_iv7, i64, env)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_iv_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_byte, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_half, void, env, i64)
@@ -85,6 +109,35 @@ DEF_HELPER_2(octeon_cp2_mt_des3_dec, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_camellia_fl, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_camellia_flinv, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_camellia_round, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_startsha_compat, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_dat0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_dat1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_dat2, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_dat3, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_dat4, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_dat5, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_dat6, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_dat7, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_dat8, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_dat9, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_dat10, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_dat11, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_dat12, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_dat13, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_dat14, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_dat15, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_iv0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_iv1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_iv2, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_iv3, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_iv4, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_iv5, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_iv6, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_iv7, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_startmd5, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_startsha256, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_startsha, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_startsha512, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 8613bdd6c8..aea9a24f0c 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -168,6 +168,368 @@ static void octeon_gfm_mul_reflect(MIPSOcteonCryptoState *crypto)
     crypto->gfm_reflect_resinp[1] = revbit64(out[1]);
 }
 
+static inline void octeon_hsh_load_reg_words_be(uint64_t reg,
+                                                 uint32_t *hi, uint32_t *lo)
+{
+    uint8_t buf[8];
+
+    stq_be_p(buf, reg);
+    *hi = ldl_be_p(buf);
+    *lo = ldl_be_p(buf + 4);
+}
+
+static inline void octeon_hsh_load_reg_words_le(uint64_t reg,
+                                                 uint32_t *lo0, uint32_t *lo1)
+{
+    uint8_t buf[8];
+
+    stq_be_p(buf, reg);
+    *lo0 = ldl_le_p(buf);
+    *lo1 = ldl_le_p(buf + 4);
+}
+
+static inline uint64_t octeon_hsh_store_reg_words_be(uint32_t hi, uint32_t lo)
+{
+    uint8_t buf[8];
+
+    stl_be_p(buf, hi);
+    stl_be_p(buf + 4, lo);
+    return ldq_be_p(buf);
+}
+
+static inline uint64_t octeon_hsh_store_reg_words_le(uint32_t lo0,
+                                                      uint32_t lo1)
+{
+    uint8_t buf[8];
+
+    stl_le_p(buf, lo0);
+    stl_le_p(buf + 4, lo1);
+    return ldq_be_p(buf);
+}
+
+static void octeon_md5_transform(MIPSOcteonCryptoState *crypto)
+{
+    static const uint32_t k[64] = {
+        0xd76aa478U, 0xe8c7b756U, 0x242070dbU, 0xc1bdceeeU,
+        0xf57c0fafU, 0x4787c62aU, 0xa8304613U, 0xfd469501U,
+        0x698098d8U, 0x8b44f7afU, 0xffff5bb1U, 0x895cd7beU,
+        0x6b901122U, 0xfd987193U, 0xa679438eU, 0x49b40821U,
+        0xf61e2562U, 0xc040b340U, 0x265e5a51U, 0xe9b6c7aaU,
+        0xd62f105dU, 0x02441453U, 0xd8a1e681U, 0xe7d3fbc8U,
+        0x21e1cde6U, 0xc33707d6U, 0xf4d50d87U, 0x455a14edU,
+        0xa9e3e905U, 0xfcefa3f8U, 0x676f02d9U, 0x8d2a4c8aU,
+        0xfffa3942U, 0x8771f681U, 0x6d9d6122U, 0xfde5380cU,
+        0xa4beea44U, 0x4bdecfa9U, 0xf6bb4b60U, 0xbebfbc70U,
+        0x289b7ec6U, 0xeaa127faU, 0xd4ef3085U, 0x04881d05U,
+        0xd9d4d039U, 0xe6db99e5U, 0x1fa27cf8U, 0xc4ac5665U,
+        0xf4292244U, 0x432aff97U, 0xab9423a7U, 0xfc93a039U,
+        0x655b59c3U, 0x8f0ccc92U, 0xffeff47dU, 0x85845dd1U,
+        0x6fa87e4fU, 0xfe2ce6e0U, 0xa3014314U, 0x4e0811a1U,
+        0xf7537e82U, 0xbd3af235U, 0x2ad7d2bbU, 0xeb86d391U,
+    };
+    static const uint8_t s[64] = {
+        7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22,
+        5, 9, 14, 20, 5, 9, 14, 20, 5, 9, 14, 20, 5, 9, 14, 20,
+        4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23,
+        6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21,
+    };
+    uint8_t block_bytes[64];
+    uint32_t m[16];
+    uint32_t a, b, c, d;
+    uint32_t aa, bb, cc, dd;
+    int i;
+
+    for (i = 0; i < 8; i++) {
+        stq_be_p(block_bytes + (i * 8), crypto->hsh_dat[i]);
+        m[i * 2] = ldl_le_p(block_bytes + (i * 8));
+        m[i * 2 + 1] = ldl_le_p(block_bytes + (i * 8) + 4);
+    }
+
+    octeon_hsh_load_reg_words_le(crypto->hsh_iv[0], &a, &b);
+    octeon_hsh_load_reg_words_le(crypto->hsh_iv[1], &c, &d);
+    aa = a;
+    bb = b;
+    cc = c;
+    dd = d;
+
+    for (i = 0; i < 64; i++) {
+        uint32_t f, g, tmp;
+
+        if (i < 16) {
+            f = (b & c) | ((~b) & d);
+            g = i;
+        } else if (i < 32) {
+            f = (d & b) | ((~d) & c);
+            g = (5 * i + 1) & 0xf;
+        } else if (i < 48) {
+            f = b ^ c ^ d;
+            g = (3 * i + 5) & 0xf;
+        } else {
+            f = c ^ (b | (~d));
+            g = (7 * i) & 0xf;
+        }
+
+        tmp = d;
+        d = c;
+        c = b;
+        b = b + rol32(a + f + k[i] + m[g], s[i]);
+        a = tmp;
+    }
+
+    a += aa;
+    b += bb;
+    c += cc;
+    d += dd;
+    crypto->hsh_iv[0] = octeon_hsh_store_reg_words_le(a, b);
+    crypto->hsh_iv[1] = octeon_hsh_store_reg_words_le(c, d);
+}
+
+static void octeon_sha1_transform(MIPSOcteonCryptoState *crypto)
+{
+    uint32_t w[80];
+    uint32_t a, b, c, d, e;
+    int i;
+
+    for (i = 0; i < 8; i++) {
+        octeon_hsh_load_reg_words_be(crypto->hsh_dat[i],
+                                      &w[i * 2], &w[i * 2 + 1]);
+    }
+    for (i = 16; i < 80; i++) {
+        w[i] = rol32(w[i - 3] ^ w[i - 8] ^ w[i - 14] ^ w[i - 16], 1);
+    }
+
+    octeon_hsh_load_reg_words_be(crypto->hsh_iv[0], &a, &b);
+    octeon_hsh_load_reg_words_be(crypto->hsh_iv[1], &c, &d);
+    e = crypto->hsh_iv[2] >> 32;
+
+    for (i = 0; i < 80; i++) {
+        uint32_t f, k, temp;
+
+        if (i < 20) {
+            f = (b & c) | ((~b) & d);
+            k = 0x5a827999;
+        } else if (i < 40) {
+            f = b ^ c ^ d;
+            k = 0x6ed9eba1;
+        } else if (i < 60) {
+            f = (b & c) | (b & d) | (c & d);
+            k = 0x8f1bbcdc;
+        } else {
+            f = b ^ c ^ d;
+            k = 0xca62c1d6;
+        }
+
+        temp = rol32(a, 5) + f + e + k + w[i];
+        e = d;
+        d = c;
+        c = rol32(b, 30);
+        b = a;
+        a = temp;
+    }
+
+    octeon_hsh_load_reg_words_be(crypto->hsh_iv[0], &w[0], &w[1]);
+    octeon_hsh_load_reg_words_be(crypto->hsh_iv[1], &w[2], &w[3]);
+    w[4] = crypto->hsh_iv[2] >> 32;
+    w[0] += a;
+    w[1] += b;
+    w[2] += c;
+    w[3] += d;
+    w[4] += e;
+    crypto->hsh_iv[0] = octeon_hsh_store_reg_words_be(w[0], w[1]);
+    crypto->hsh_iv[1] = octeon_hsh_store_reg_words_be(w[2], w[3]);
+    crypto->hsh_iv[2] = (uint64_t)w[4] << 32;
+}
+
+static void octeon_sha256_transform(MIPSOcteonCryptoState *crypto)
+{
+    static const uint32_t k[64] = {
+        0x428a2f98U, 0x71374491U, 0xb5c0fbcfU, 0xe9b5dba5U,
+        0x3956c25bU, 0x59f111f1U, 0x923f82a4U, 0xab1c5ed5U,
+        0xd807aa98U, 0x12835b01U, 0x243185beU, 0x550c7dc3U,
+        0x72be5d74U, 0x80deb1feU, 0x9bdc06a7U, 0xc19bf174U,
+        0xe49b69c1U, 0xefbe4786U, 0x0fc19dc6U, 0x240ca1ccU,
+        0x2de92c6fU, 0x4a7484aaU, 0x5cb0a9dcU, 0x76f988daU,
+        0x983e5152U, 0xa831c66dU, 0xb00327c8U, 0xbf597fc7U,
+        0xc6e00bf3U, 0xd5a79147U, 0x06ca6351U, 0x14292967U,
+        0x27b70a85U, 0x2e1b2138U, 0x4d2c6dfcU, 0x53380d13U,
+        0x650a7354U, 0x766a0abbU, 0x81c2c92eU, 0x92722c85U,
+        0xa2bfe8a1U, 0xa81a664bU, 0xc24b8b70U, 0xc76c51a3U,
+        0xd192e819U, 0xd6990624U, 0xf40e3585U, 0x106aa070U,
+        0x19a4c116U, 0x1e376c08U, 0x2748774cU, 0x34b0bcb5U,
+        0x391c0cb3U, 0x4ed8aa4aU, 0x5b9cca4fU, 0x682e6ff3U,
+        0x748f82eeU, 0x78a5636fU, 0x84c87814U, 0x8cc70208U,
+        0x90befffaU, 0xa4506cebU, 0xbef9a3f7U, 0xc67178f2U,
+    };
+    uint32_t w[64];
+    uint32_t a, b, c, d, e, f, g, h;
+    uint32_t orig[8];
+    int i;
+
+    for (i = 0; i < 8; i++) {
+        octeon_hsh_load_reg_words_be(crypto->hsh_dat[i],
+                                      &w[i * 2], &w[i * 2 + 1]);
+    }
+    for (i = 16; i < 64; i++) {
+        uint32_t s0 = ror32(w[i - 15], 7) ^
+                      ror32(w[i - 15], 18) ^
+                      (w[i - 15] >> 3);
+        uint32_t s1 = ror32(w[i - 2], 17) ^
+                      ror32(w[i - 2], 19) ^
+                      (w[i - 2] >> 10);
+        w[i] = w[i - 16] + s0 + w[i - 7] + s1;
+    }
+
+    for (i = 0; i < 4; i++) {
+        octeon_hsh_load_reg_words_be(crypto->hsh_iv[i],
+                                      &orig[i * 2], &orig[i * 2 + 1]);
+    }
+    a = orig[0];
+    b = orig[1];
+    c = orig[2];
+    d = orig[3];
+    e = orig[4];
+    f = orig[5];
+    g = orig[6];
+    h = orig[7];
+
+    for (i = 0; i < 64; i++) {
+        uint32_t s1 = ror32(e, 6) ^
+                      ror32(e, 11) ^
+                      ror32(e, 25);
+        uint32_t ch = (e & f) ^ ((~e) & g);
+        uint32_t temp1 = h + s1 + ch + k[i] + w[i];
+        uint32_t s0 = ror32(a, 2) ^
+                      ror32(a, 13) ^
+                      ror32(a, 22);
+        uint32_t maj = (a & b) ^ (a & c) ^ (b & c);
+        uint32_t temp2 = s0 + maj;
+
+        h = g;
+        g = f;
+        f = e;
+        e = d + temp1;
+        d = c;
+        c = b;
+        b = a;
+        a = temp1 + temp2;
+    }
+
+    orig[0] += a;
+    orig[1] += b;
+    orig[2] += c;
+    orig[3] += d;
+    orig[4] += e;
+    orig[5] += f;
+    orig[6] += g;
+    orig[7] += h;
+    for (i = 0; i < 4; i++) {
+        crypto->hsh_iv[i] =
+            octeon_hsh_store_reg_words_be(orig[i * 2], orig[i * 2 + 1]);
+    }
+}
+
+static void octeon_sha512_transform(MIPSOcteonCryptoState *crypto)
+{
+    static const uint64_t k[80] = {
+        0x428a2f98d728ae22ULL, 0x7137449123ef65cdULL,
+        0xb5c0fbcfec4d3b2fULL, 0xe9b5dba58189dbbcULL,
+        0x3956c25bf348b538ULL, 0x59f111f1b605d019ULL,
+        0x923f82a4af194f9bULL, 0xab1c5ed5da6d8118ULL,
+        0xd807aa98a3030242ULL, 0x12835b0145706fbeULL,
+        0x243185be4ee4b28cULL, 0x550c7dc3d5ffb4e2ULL,
+        0x72be5d74f27b896fULL, 0x80deb1fe3b1696b1ULL,
+        0x9bdc06a725c71235ULL, 0xc19bf174cf692694ULL,
+        0xe49b69c19ef14ad2ULL, 0xefbe4786384f25e3ULL,
+        0x0fc19dc68b8cd5b5ULL, 0x240ca1cc77ac9c65ULL,
+        0x2de92c6f592b0275ULL, 0x4a7484aa6ea6e483ULL,
+        0x5cb0a9dcbd41fbd4ULL, 0x76f988da831153b5ULL,
+        0x983e5152ee66dfabULL, 0xa831c66d2db43210ULL,
+        0xb00327c898fb213fULL, 0xbf597fc7beef0ee4ULL,
+        0xc6e00bf33da88fc2ULL, 0xd5a79147930aa725ULL,
+        0x06ca6351e003826fULL, 0x142929670a0e6e70ULL,
+        0x27b70a8546d22ffcULL, 0x2e1b21385c26c926ULL,
+        0x4d2c6dfc5ac42aedULL, 0x53380d139d95b3dfULL,
+        0x650a73548baf63deULL, 0x766a0abb3c77b2a8ULL,
+        0x81c2c92e47edaee6ULL, 0x92722c851482353bULL,
+        0xa2bfe8a14cf10364ULL, 0xa81a664bbc423001ULL,
+        0xc24b8b70d0f89791ULL, 0xc76c51a30654be30ULL,
+        0xd192e819d6ef5218ULL, 0xd69906245565a910ULL,
+        0xf40e35855771202aULL, 0x106aa07032bbd1b8ULL,
+        0x19a4c116b8d2d0c8ULL, 0x1e376c085141ab53ULL,
+        0x2748774cdf8eeb99ULL, 0x34b0bcb5e19b48a8ULL,
+        0x391c0cb3c5c95a63ULL, 0x4ed8aa4ae3418acbULL,
+        0x5b9cca4f7763e373ULL, 0x682e6ff3d6b2b8a3ULL,
+        0x748f82ee5defb2fcULL, 0x78a5636f43172f60ULL,
+        0x84c87814a1f0ab72ULL, 0x8cc702081a6439ecULL,
+        0x90befffa23631e28ULL, 0xa4506cebde82bde9ULL,
+        0xbef9a3f7b2c67915ULL, 0xc67178f2e372532bULL,
+        0xca273eceea26619cULL, 0xd186b8c721c0c207ULL,
+        0xeada7dd6cde0eb1eULL, 0xf57d4f7fee6ed178ULL,
+        0x06f067aa72176fbaULL, 0x0a637dc5a2c898a6ULL,
+        0x113f9804bef90daeULL, 0x1b710b35131c471bULL,
+        0x28db77f523047d84ULL, 0x32caab7b40c72493ULL,
+        0x3c9ebe0a15c9bebcULL, 0x431d67c49c100d4cULL,
+        0x4cc5d4becb3e42b6ULL, 0x597f299cfc657e2aULL,
+        0x5fcb6fab3ad6faecULL, 0x6c44198c4a475817ULL,
+    };
+    uint64_t w[80];
+    uint64_t a, b, c, d, e, f, g, h;
+    int i;
+
+    for (i = 0; i < 16; i++) {
+        w[i] = crypto->hsh_dat[i];
+    }
+    for (i = 16; i < 80; i++) {
+        uint64_t s0 = ror64(w[i - 15], 1) ^
+                      ror64(w[i - 15], 8) ^
+                      (w[i - 15] >> 7);
+        uint64_t s1 = ror64(w[i - 2], 19) ^
+                      ror64(w[i - 2], 61) ^
+                      (w[i - 2] >> 6);
+        w[i] = w[i - 16] + s0 + w[i - 7] + s1;
+    }
+
+    a = crypto->hsh_iv[0];
+    b = crypto->hsh_iv[1];
+    c = crypto->hsh_iv[2];
+    d = crypto->hsh_iv[3];
+    e = crypto->hsh_iv[4];
+    f = crypto->hsh_iv[5];
+    g = crypto->hsh_iv[6];
+    h = crypto->hsh_iv[7];
+
+    for (i = 0; i < 80; i++) {
+        uint64_t s0 = ror64(a, 28) ^
+                      ror64(a, 34) ^
+                      ror64(a, 39);
+        uint64_t s1 = ror64(e, 14) ^
+                      ror64(e, 18) ^
+                      ror64(e, 41);
+        uint64_t ch = (e & f) ^ ((~e) & g);
+        uint64_t maj = (a & b) ^ (a & c) ^ (b & c);
+        uint64_t temp1 = h + s1 + ch + k[i] + w[i];
+        uint64_t temp2 = s0 + maj;
+
+        h = g;
+        g = f;
+        f = e;
+        e = d + temp1;
+        d = c;
+        c = b;
+        b = a;
+        a = temp1 + temp2;
+    }
+
+    crypto->hsh_iv[0] += a;
+    crypto->hsh_iv[1] += b;
+    crypto->hsh_iv[2] += c;
+    crypto->hsh_iv[3] += d;
+    crypto->hsh_iv[4] += e;
+    crypto->hsh_iv[5] += f;
+    crypto->hsh_iv[6] += g;
+    crypto->hsh_iv[7] += h;
+}
+
 static const uint64_t octeon_sha3_round_constants[24] = {
     0x0000000000000001ULL, 0x0000000000008082ULL,
     0x800000000000808aULL, 0x8000000080008000ULL,
@@ -1778,6 +2140,130 @@ void helper_octeon_cp2_mt_zuc_more(CPUMIPSState *env, uint64_t value)
     octeon_zuc_more(&env->octeon_crypto, value);
 }
 
+#define OCTEON_HSH_MF_DAT(N) \
+uint64_t helper_octeon_cp2_mf_hsh_dat ## N(CPUMIPSState *env) \
+{ \
+    return env->octeon_crypto.hsh_dat[N]; \
+}
+OCTEON_HSH_MF_DAT(0)
+OCTEON_HSH_MF_DAT(1)
+OCTEON_HSH_MF_DAT(2)
+OCTEON_HSH_MF_DAT(3)
+OCTEON_HSH_MF_DAT(4)
+OCTEON_HSH_MF_DAT(5)
+OCTEON_HSH_MF_DAT(6)
+OCTEON_HSH_MF_DAT(7)
+OCTEON_HSH_MF_DAT(8)
+OCTEON_HSH_MF_DAT(9)
+OCTEON_HSH_MF_DAT(10)
+OCTEON_HSH_MF_DAT(11)
+OCTEON_HSH_MF_DAT(12)
+OCTEON_HSH_MF_DAT(13)
+OCTEON_HSH_MF_DAT(14)
+OCTEON_HSH_MF_DAT(15)
+#undef OCTEON_HSH_MF_DAT
+
+#define OCTEON_HSH_MF_IV(N) \
+uint64_t helper_octeon_cp2_mf_hsh_iv ## N(CPUMIPSState *env) \
+{ \
+    return env->octeon_crypto.hsh_iv[N]; \
+}
+OCTEON_HSH_MF_IV(0)
+OCTEON_HSH_MF_IV(1)
+OCTEON_HSH_MF_IV(2)
+OCTEON_HSH_MF_IV(3)
+OCTEON_HSH_MF_IV(4)
+OCTEON_HSH_MF_IV(5)
+OCTEON_HSH_MF_IV(6)
+OCTEON_HSH_MF_IV(7)
+#undef OCTEON_HSH_MF_IV
+
+static void octeon_hsh_mt_dat(MIPSOcteonCryptoState *crypto,
+                              unsigned int index, uint64_t value)
+{
+    crypto->hsh_dat[index] = value;
+    if (index == 15) {
+        octeon_sha512_transform(crypto);
+    }
+}
+
+static void octeon_hsh_mt_iv(MIPSOcteonCryptoState *crypto,
+                             unsigned int index, uint64_t value)
+{
+    crypto->hsh_iv[index] = value;
+}
+
+#define OCTEON_HSH_MT_DAT(N) \
+void helper_octeon_cp2_mt_hsh_dat ## N(CPUMIPSState *env, uint64_t value) \
+{ \
+    octeon_hsh_mt_dat(&env->octeon_crypto, N, value); \
+}
+OCTEON_HSH_MT_DAT(0)
+OCTEON_HSH_MT_DAT(1)
+OCTEON_HSH_MT_DAT(2)
+OCTEON_HSH_MT_DAT(3)
+OCTEON_HSH_MT_DAT(4)
+OCTEON_HSH_MT_DAT(5)
+OCTEON_HSH_MT_DAT(6)
+OCTEON_HSH_MT_DAT(7)
+OCTEON_HSH_MT_DAT(8)
+OCTEON_HSH_MT_DAT(9)
+OCTEON_HSH_MT_DAT(10)
+OCTEON_HSH_MT_DAT(11)
+OCTEON_HSH_MT_DAT(12)
+OCTEON_HSH_MT_DAT(13)
+OCTEON_HSH_MT_DAT(14)
+OCTEON_HSH_MT_DAT(15)
+#undef OCTEON_HSH_MT_DAT
+
+#define OCTEON_HSH_MT_IV(N) \
+void helper_octeon_cp2_mt_hsh_iv ## N(CPUMIPSState *env, uint64_t value) \
+{ \
+    octeon_hsh_mt_iv(&env->octeon_crypto, N, value); \
+}
+OCTEON_HSH_MT_IV(0)
+OCTEON_HSH_MT_IV(1)
+OCTEON_HSH_MT_IV(2)
+OCTEON_HSH_MT_IV(3)
+OCTEON_HSH_MT_IV(4)
+OCTEON_HSH_MT_IV(5)
+OCTEON_HSH_MT_IV(6)
+OCTEON_HSH_MT_IV(7)
+#undef OCTEON_HSH_MT_IV
+
+void helper_octeon_cp2_mt_hsh_startsha_compat(CPUMIPSState *env,
+                                              uint64_t value)
+{
+    env->octeon_crypto.hsh_dat[7] = value;
+    octeon_sha1_transform(&env->octeon_crypto);
+}
+
+void helper_octeon_cp2_mt_hsh_startmd5(CPUMIPSState *env, uint64_t value)
+{
+    env->octeon_crypto.hsh_dat[7] = value;
+    octeon_md5_transform(&env->octeon_crypto);
+}
+
+void helper_octeon_cp2_mt_hsh_startsha256(CPUMIPSState *env, uint64_t value)
+{
+    env->octeon_crypto.hsh_dat[7] = value;
+    octeon_sha256_transform(&env->octeon_crypto);
+}
+
+void helper_octeon_cp2_mt_hsh_startsha(CPUMIPSState *env, uint64_t value)
+{
+    env->octeon_crypto.hsh_dat[7] = value;
+    octeon_sha1_transform(&env->octeon_crypto);
+}
+
+void helper_octeon_cp2_mt_hsh_startsha512(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->hsh_dat[15] = value;
+    octeon_sha512_transform(crypto);
+}
+
 uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
 {
     return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);

-- 
2.54.0


