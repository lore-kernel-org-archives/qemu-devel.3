Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2EFCD5BB6
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 19:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQVgE-0001i5-Ld; Fri, 22 May 2026 15:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVg8-0001fs-S5
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:37:04 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVg2-0000T4-SO
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:37:01 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-484cf882ce5so5536099b6e.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 12:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779478618; x=1780083418; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XC3KOmfiBf3uOHhOBkXrSekokX1Dg+EUGg6cXmaFlII=;
 b=aVNU47CFpcY+xCUYuz6DA3Tdh2+yzTMq+1EJqW7yodmhjp8pcARKdYBOfa0ET/ElKP
 tLxwjkbQdvRG3zkb1ldJa/187+B2F0fJRZrw3HhX/lacD0R+vjo61MMv/nkuR6S1A4gS
 OSMOb57Bw0QyixcxFTjvrT/s+Aw6mI++0xWIwP3b+rH92V53VHY5nLs7/jIUZyo+SIL3
 8sXKsQRAmEnO7ZUF8aMwI3hPufiS9ofdgAHTRHA/CgW9/0eAxX25Rv8Ac8bzRilmV9I4
 MPPkl+jjyzchT89DzX3k/6hPhqPY8yW5nuWx0dssEpxKCsbutMJPueuNdnX0OH52HRn3
 2c/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779478618; x=1780083418;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XC3KOmfiBf3uOHhOBkXrSekokX1Dg+EUGg6cXmaFlII=;
 b=B3fngB2pJraNqXkQFQbklgESQsCgv/+cg4AZo1CWf7LUSR3oox+WSQXqYeW5FKp1M0
 EYD1wvsoMhKLwSxru3x+8ynvJiKXgYivFTmQlFIY3Nl7a41RIb6uj98VnXNMb8R9Qe0e
 02DXFKdUV5zAzVFHlGRbHQ3jqHhnWBqVUscxjN1tOaOyU/n8WZLExOr1Sf0VcQE/dJi0
 hsm/H8o0hJhUFIHbc/GHuMhHHqMX3dDSh1CkWDU3XMeFVU4qD6KbtQObIx52J2Km2BxO
 jLQK0tF7gNHl6ya9nDcbYj0Ocbi23c3IO0McAdXLZHW+B7er7Oiq6UzJSgLztKGU4pVG
 HveA==
X-Gm-Message-State: AOJu0YxIM0HeuyPMiRRT/4jpAaEFjlsSR9aa6A0/6p58nlNV8HHY1akr
 oljzXIl6uXFtOktgWhbYh8uGTxVKWai6/BmuZCUbvvuWj5Nf/rb+GBV4
X-Gm-Gg: Acq92OEAif1B2spMeIwmA2EOMnw/shyzFg/cHVQuA6p+7wKxyiffmdVy9jhKNdqdl17
 MFIzrxwixXqDfVL2uguu/sb7ZsiJdKJYAG20NXUDXV2BaJoJQQtbWOYUO011V9if/7QMXKKepNy
 prXORH0t3UQDG4xS2nA7O9F600J7VGwctCMx9tyJJYHeJ3w8uEZViyrcNlyLIPg9IMkeRG9PO4F
 UsHQecvrUthwUEqPkiTvGGIsT73a5ylho8q7Do6bTflOyx1iGvS4sk6zGHQOa4iZD6FQOk6COQS
 vHTY1dIflvnCUju71/TX4p8ajFCOrH2IBFEQzyu10kNlAIBZBYu1A5hXkIfkh4pcrbYanD00XDy
 dsHgawCeMsJBpBneYeRyFVXHXBj7GjVIesuRJqdRhmZXuOiBNtez4s5Jm9nPNU0vTL6CWs6A2/M
 N33MaRlWFALRnAMuqvniaRjtSJAgjdNx4FAqPaAz0fQoLpzWDmtr52QMn1tT6Yj5R8BYe6dm29G
 5LT5cqE+9sWFuZZWEnU0YxvE4HkntBjjXqVpr1bN0H80nfnSjk6x4oGtev/7ADFVs8/
X-Received: by 2002:a05:6808:1591:b0:479:faf5:ef56 with SMTP id
 5614622812f47-48549cfce05mr2901935b6e.5.1779478617725; 
 Fri, 22 May 2026 12:36:57 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-48554757d5dsm995297b6e.15.2026.05.22.12.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 12:36:56 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 22 May 2026 13:36:40 -0600
Subject: [PATCH v15 09/22] target/mips: add Octeon AES COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mips-octeon-missing-insns-v2-v15-9-f8731a588dc2@gmail.com>
References: <20260522-mips-octeon-missing-insns-v2-v15-0-f8731a588dc2@gmail.com>
In-Reply-To: <20260522-mips-octeon-missing-insns-v2-v15-0-f8731a588dc2@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x232.google.com
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

Add helper support for the Octeon AES operation selectors. Direct
register-transfer selectors do not need helpers; the ECB/CBC encrypt and
decrypt operations consume the AES input, key, IV, and key-length state.

AESRESINP is modeled as one architectural register bank; operation
helpers consume the current AESRESINP block and write the result back to
the same bank.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v9 -> v10:
  - Drop the non-architectural AES input/result split.
  - Model AESRESINP as a single architectural input/result bank.

Changes v8 -> v9:
  - Split AES operation selectors into their own COP2 helper patch.
  - Replace generic selector dispatch with per-operation AES helpers.
  - Add matching helper.h declarations with the helper implementation.
---
 target/mips/helper.h            |   4 ++
 target/mips/tcg/octeon_crypto.c | 145 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index c4e7693df6..39c226ded9 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -52,6 +52,10 @@ DEF_HELPER_2(octeon_cp2_mt_zuc_start, void, env, i64)
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
index b8157c9a8e..3de7ad31bf 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -841,6 +841,151 @@ static void octeon_snow3g_more(MIPSOcteonCryptoState *crypto)
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
+
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
+
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
+    octeon_aes_load_block(crypto->aes_resinp, in);
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
+    octeon_aes_store_block(crypto->aes_resinp, out);
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
+    octeon_aes_load_block(crypto->aes_resinp, in);
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
+    octeon_aes_store_block(crypto->aes_resinp, out);
+    if (cbc) {
+        octeon_aes_store_block(crypto->aes_iv, next_iv);
+    }
+}
+
+void helper_octeon_cp2_mt_aes_enc_cbc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_aes_encrypt_common(crypto, true);
+}
+
+void helper_octeon_cp2_mt_aes_enc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_aes_encrypt_common(crypto, false);
+}
+
+void helper_octeon_cp2_mt_aes_dec_cbc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_aes_decrypt_common(crypto, true);
+}
+
+void helper_octeon_cp2_mt_aes_dec1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_aes_decrypt_common(crypto, false);
+}
+
 void helper_octeon_cp2_mt_snow3g_start(CPUMIPSState *env, uint64_t value)
 {
     octeon_snow3g_start(&env->octeon_crypto, value);

-- 
2.54.0


