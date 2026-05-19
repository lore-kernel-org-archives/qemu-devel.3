Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C68CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDq-0006oN-Fd; Tue, 19 May 2026 12:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDp-0006o5-SK
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:09 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDn-0000nj-Iz
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:09 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-40946982a78so1162863fac.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207786; x=1779812586; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VHLIfK+38fqBZdETISwd7QkQU8tnCZw4bWsHAd0fwUg=;
 b=RrZ6tHVwQaoE19qLOsRbpL1Lm6jWJ1ZOIgAT3bP4efN0O7rwIU1LB5CqMGREZcPe+M
 FU18uTCpQgFYf4n4CKvUgdrWy1sBr2aOKkCCtKeXk37zW5p74V6AH37x8BKIUA32I/rM
 sgnpwgbBXsNHRYfrq4S9djigpZLoRl/uGuxSrTyuBBgJQwvx7P4hBCOkGBi9S0eiwzs3
 WxLCPR67B5/S7XpV8ClcVihMlAaa/RhznG0x7w8sK0AL7+yRajiRzkIfgleNzaze1AM+
 UCj6Z1oth4Sb5j1B3Y2GDwrat2XHbnM5QJl3/KzFP6zlfzy89DW3FRnVkgYWULyXX4Wl
 Dmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207786; x=1779812586;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VHLIfK+38fqBZdETISwd7QkQU8tnCZw4bWsHAd0fwUg=;
 b=RLs0UG00ci3dVGdx0lNGQsA575mAQsqT1P3C5X/BNJzW1PghoP15Wo8DOgqZy7oWRN
 QLwKV/s/WJPv/Z5RchvBArToVKQdxRA9kX0sx18XAa8OdBdtRCtuB0pZQQMMBR130fsC
 jGAzW4MDZWq+7IpsRqgFDkDhSo4SHEIXh63sX2fItRrHtiWouOZMW7mBAThPZx0tpqOR
 H8LJa+CQg/ZvXs78UEaCx3rc7bNlxbJTdr4vePGFVKUVBscCo5z4dW6TK2/atXTYAA38
 GM7PCTUH1394mhxLCNoxnwETrJ/oSPPakobGsNSvgqMLiGDAN6VR5FP8qllDy5a3fVL8
 ZcNQ==
X-Gm-Message-State: AOJu0YzBifCSUi5Ovl9xFulSj5goGVXuC4F2o2h1GhUIwEsKZd4P3rAZ
 5K2METkD3EP7Oy46KkOV7XiQ7ZLp+wrbVEp2nXEHmW9oMRwjCHZFzrUz
X-Gm-Gg: Acq92OFOYDahLYYqUkX8JQOYX82WkIE/uBoX1M3GcsbHZQR9Jecwv3S2ta1Vagg7IXJ
 pwoNT9CllvVmEMUnHmpQ5aVxgS/Nx+uYIhtcyPwEb7iMiz38uCZrgr+a7D+rwou1DtLphCct+UT
 pkhC0HKmpTc1leLwU59DtUHMnF8Gv19LuwEhamNrto6bgFV7MsbyQJewsi/n+kE4dw6ndr8Hbrv
 pgDjjJGycwcZELp//yFkdWuXNUnm9myQrw9bNIf1hkwj5ZrOTnYb8Z+aTAzQUAuQINFkLnjNXD9
 q+I5MsLsH8lOE2YCj0qjtIaxcTE8VE/Dc4yI8UJvOCU/eilsGbXXXKYEAYwZ77OV0G8e21Ys+IX
 6VfY9gZyt3w3R5LeRBw7NgQkaElzFK87G8qRioN0K5ltv83hY1O1XPv2OgoN7KMuiYUaXp9H/yP
 F2XhCVeCqrrZMOj1NewwYGuXZAdDwEYXN47zA5MLaN3eth38PyRRm3TtPip3f/uBRrCqSXg9H7w
 0+KQ5PHwLPWTCJYSz9+ZzpGJFSY9OaoC/umAF/rofIFPWnooOPlAbs7hTMFSrOZzZAT
X-Received: by 2002:a05:6870:ff04:b0:42f:fc34:78bd with SMTP id
 586e51a60fabf-43a2de7ba6cmr12120552fac.33.1779207786435; 
 Tue, 19 May 2026 09:23:06 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:23:06 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:33 -0600
Subject: [PATCH v9 31/40] target/mips: add Octeon AES COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-31-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x30.google.com
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

Add helper support for the Octeon AES operation selectors. The direct
register-transfer selectors are handled later by the explicit decode
patch; this patch adds the ECB/CBC encrypt and decrypt operations that
consume the AES input, key, IV, and key-length state.

The AESRESINP direct write path keeps a separate input latch and readback
view. Later translator comments document that split where the direct TCG
stores are emitted.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Split AES operation selectors into their own COP2 helper patch.
  - Replace generic selector dispatch with per-operation AES helpers.
  - Add matching helper.h declarations with the helper implementation.
---
 target/mips/cpu.h               |   5 ++
 target/mips/helper.h            |   4 ++
 target/mips/tcg/octeon_crypto.c | 141 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index b57a7a0584..801893b67f 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -556,6 +556,11 @@ typedef struct MIPSOcteonCryptoState {
     uint64_t sha3_state[25];
     uint64_t aes_iv[2];
     uint64_t aes_key[4];
+    /*
+     * AESRESINP is one architectural selector bank.  Keep a separate input
+     * latch so operation selectors can consume a pending block while DMFC2
+     * reads expose the latest result/readback value.
+     */
     uint64_t aes_result[2];
     uint64_t aes_input[2];
     uint64_t gfm_mul[2];
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 056a9d3fc8..d8ba1f19dd 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -66,6 +66,10 @@ DEF_HELPER_2(octeon_cp2_mt_zuc_start, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_zuc_more, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_snow3g_start, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_snow3g_more, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_aes_enc_cbc1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_aes_enc1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_aes_dec_cbc1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_aes_dec1, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index ee4d33c24f..55d8818ee2 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -763,6 +763,116 @@ static void octeon_snow3g_more(MIPSOcteonCryptoState *crypto)
     octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SNOW3G);
     octeon_snow3g_queue_result(crypto);
 }
+static int octeon_aes_key_bits(const MIPSOcteonCryptoState *crypto)
+{
+    enum {
+        OCTEON_AES_KEYLEN_128 = 1,
+        OCTEON_AES_KEYLEN_192 = 2,
+        OCTEON_AES_KEYLEN_256 = 3,
+    };
+
+    switch (crypto->aes_keylen) {
+    case OCTEON_AES_KEYLEN_128:
+        return 128;
+    case OCTEON_AES_KEYLEN_192:
+        return 192;
+    case OCTEON_AES_KEYLEN_256:
+        return 256;
+    default:
+        return 0;
+    }
+}
+static void octeon_aes_load_key(const MIPSOcteonCryptoState *crypto,
+                                uint8_t *key, size_t keylen)
+{
+    stq_be_p(key, crypto->aes_key[0]);
+    stq_be_p(key + 8, crypto->aes_key[1]);
+    if (keylen > 16) {
+        stq_be_p(key + 16, crypto->aes_key[2]);
+    }
+    if (keylen > 24) {
+        stq_be_p(key + 24, crypto->aes_key[3]);
+    }
+}
+
+static void octeon_aes_load_block(const uint64_t regs[2], uint8_t *block)
+{
+    stq_be_p(block, regs[0]);
+    stq_be_p(block + 8, regs[1]);
+}
+
+static void octeon_aes_store_block(uint64_t regs[2], const uint8_t *block)
+{
+    regs[0] = ldq_be_p(block);
+    regs[1] = ldq_be_p(block + 8);
+}
+static void octeon_aes_encrypt_common(MIPSOcteonCryptoState *crypto, bool cbc)
+{
+    AES_KEY key;
+    uint8_t in[16];
+    uint8_t out[16];
+    uint8_t iv[16];
+    uint8_t raw_key[32] = {};
+    int bits = octeon_aes_key_bits(crypto);
+
+    if (!bits) {
+        return;
+    }
+
+    octeon_aes_load_key(crypto, raw_key, bits / 8);
+    octeon_aes_load_block(crypto->aes_input, in);
+    if (cbc) {
+        int i;
+
+        octeon_aes_load_block(crypto->aes_iv, iv);
+        for (i = 0; i < sizeof(in); i++) {
+            in[i] ^= iv[i];
+        }
+    }
+
+    AES_set_encrypt_key(raw_key, bits, &key);
+    AES_encrypt(in, out, &key);
+    octeon_aes_store_block(crypto->aes_result, out);
+    if (cbc) {
+        octeon_aes_store_block(crypto->aes_iv, out);
+    }
+}
+
+static void octeon_aes_decrypt_common(MIPSOcteonCryptoState *crypto, bool cbc)
+{
+    AES_KEY key;
+    uint8_t in[16];
+    uint8_t out[16];
+    uint8_t iv[16];
+    uint8_t next_iv[16];
+    uint8_t raw_key[32] = {};
+    int bits = octeon_aes_key_bits(crypto);
+    int i;
+
+    if (!bits) {
+        return;
+    }
+
+    octeon_aes_load_key(crypto, raw_key, bits / 8);
+    octeon_aes_load_block(crypto->aes_input, in);
+    if (cbc) {
+        memcpy(next_iv, in, sizeof(next_iv));
+        octeon_aes_load_block(crypto->aes_iv, iv);
+    }
+
+    AES_set_decrypt_key(raw_key, bits, &key);
+    AES_decrypt(in, out, &key);
+    if (cbc) {
+        for (i = 0; i < sizeof(out); i++) {
+            out[i] ^= iv[i];
+        }
+    }
+
+    octeon_aes_store_block(crypto->aes_result, out);
+    if (cbc) {
+        octeon_aes_store_block(crypto->aes_iv, next_iv);
+    }
+}
 static void octeon_gfm_mul(const uint64_t x[2], const uint64_t y[2],
                            uint16_t poly, uint64_t out[2])
 {
@@ -919,6 +1029,37 @@ void helper_octeon_cp2_mt_sha3_startop(CPUMIPSState *env, uint64_t value)
     octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SHA3);
     octeon_sha3_permute(crypto);
 }
+void helper_octeon_cp2_mt_aes_enc_cbc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_input[1] = value;
+    octeon_aes_encrypt_common(crypto, true);
+}
+
+void helper_octeon_cp2_mt_aes_enc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_input[1] = value;
+    octeon_aes_encrypt_common(crypto, false);
+}
+
+void helper_octeon_cp2_mt_aes_dec_cbc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_input[1] = value;
+    octeon_aes_decrypt_common(crypto, true);
+}
+
+void helper_octeon_cp2_mt_aes_dec1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_input[1] = value;
+    octeon_aes_decrypt_common(crypto, false);
+}
 void helper_octeon_cp2_mt_gfm_xormul1_reflect(CPUMIPSState *env,
                                               uint64_t value)
 {

-- 
2.54.0


