Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E157CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDs-0006qb-H4; Tue, 19 May 2026 12:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDq-0006oP-Fe
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:10 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDo-0000o6-Iu
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:10 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e568ab0bc5so4273235a34.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207787; x=1779812587; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=evbNxhCtg9xYMHfeUJZnoO+ymh7Qiu1fHqdZXQRYFrE=;
 b=NWh/IPdOVJwliLVk0odlZ/TqPA6ogMLXQym/ey19a0fGjbikcoWkeM81TRYu6wfpAj
 21A05UjPoYVsOGUgaf71IM6ZvY27yPdR4sR/3WTBUA3fpznN8A6PTodmHbxUxdVXnZ7u
 wfWCiVfqGOSv7qhQUdCyoDl3BuooMALTo5tTyQYI/MrkM3ph9ib7u6FHkMWB9m8qyxxj
 Tzu3zof97+MawHoqvtH1u/U2SpAx7A7SIomKVdwLeP6zDr19pLDx1PWzXCkxZKqcKCG6
 TRWBWjpGi1aS2viVHuIGus9cCGiYDJZcP4bBVOxyxUrxFQXvhockwGh7y3v3nfo/1+z2
 9ZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207787; x=1779812587;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=evbNxhCtg9xYMHfeUJZnoO+ymh7Qiu1fHqdZXQRYFrE=;
 b=hCVjOt0i+k8a6ft6Rh11jd/v/ZQQnCTyuh+7r+I8VxmXYPghoTJOC3SMExMLJNj7D1
 QDO3iI40OEfthXFW+HujkixVG9Q6Tn+V7LmncckyTktvJ+nfQY6zBBnhS9R3ViLsanWU
 RTuIfxfu5Ykv3iXlwlyUsEmg/KNek53Y4+0b+lFEAPYfBZgBOwqTfMocN9WFZsA4N8WC
 omKppsKmTwZ0SRfArcTlHiVPq9Fwq+O0sfuhBGV5v444iwETjxJPKwyvxF5tmsGA/wIN
 vosyhsv1ONJLQCJoIa4JeWr1BUzlTGHBikdlrMr9jdf9a3Xx1jhknpHtOYchYWUW6nSh
 uXzQ==
X-Gm-Message-State: AOJu0YxexbY/qUNSEx8mOiaIQwR7TZjVg5AL2vtsW1cx13NVHUDAYLrd
 029dBbcwSgNTmS5hhecvvZPqq/ms3y1ul8F80Hc7yiTZtM5bLYURXB3z
X-Gm-Gg: Acq92OFribWMWbqdyYBD1aydEhVABsD132qBd+7Hk7QTtZXJgdqAxFWGV8I1M/pv4YW
 Pl/cNGZHNgmjc00w85gAxRAc+jqNlQSujo78MxwTODLvt4KuQ4QpzZ2Hm9LCkC5yv/pHXFVEKHm
 VgcaQH8XKmRS4oSdMdCEJvFOH7lW8kS8xHATKH+/jpXAOJbvYxzj4rOghJ0ox5qYoUfzxM+FWMe
 e2RzvAQvvyCf0FwI5QzpLRgTRZdNCIrUqQheiwuYODf1VenPWZGAavcxKtZBY73CUrXv7byEXsf
 f6aHfuMHXHb0a9fmwfMYmnnCHyLYSs/Gq8ykMSrEEQwpjcrq06KbbQCrd7S1TXTXHSsUZfuaV8d
 DkCobF1EHkdd43JmsQw1UF8YG0UvVuDHfrNbhlpJRjRIrDAhRafMjx7ZfyFheZ4RCbNwrqNHXk2
 B2owDgWIrHsYVlu8YgZftSTRRnUUCHTg5ql/Qqfcmof93CvFKNNTZ+fTp7M9vwCfkMlwYR8aXZm
 Efbi9r9wnUOPtD1eCDaQHFXzLHJx6Vtehb/wl8jWCGewT67gQhBJz/zYSxfLjK2Unhw
X-Received: by 2002:a05:6820:13a:b0:696:72e9:f92e with SMTP id
 006d021491bc7-69b87f3c306mr9917165eaf.10.1779207787392; 
 Tue, 19 May 2026 09:23:07 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:23:06 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:34 -0600
Subject: [PATCH v9 32/40] target/mips: add Octeon SMS4 COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-32-d7dd735ecddd@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32e.google.com
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

Add helper support for the Octeon SMS4 operation selectors. SMS4 reuses
the AES RESINP, IV, and key banks, so the helpers share the existing AES
state while implementing the SMS4 ECB/CBC encrypt and decrypt operations.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Split SMS4 operation selectors into their own COP2 helper patch.
  - Replace generic selector dispatch with per-operation SMS4 helpers.
  - Add matching helper.h declarations with the helper implementation.

Changes v1 -> v2:
  - Add selector dispatch updates in octeon_translate.c after moving
    COP2 decode out of translate.c.  (suggested by Philippe
    Mathieu-Daudé)

Changes v5 -> v6:
  - Use RESINP wording for the SMS4 shared selector aliases.
---
 target/mips/helper.h            |   4 ++
 target/mips/tcg/octeon_crypto.c | 121 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index d8ba1f19dd..d6231917ed 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -70,6 +70,10 @@ DEF_HELPER_2(octeon_cp2_mt_aes_enc_cbc1, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_aes_enc1, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_aes_dec_cbc1, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_aes_dec1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sms4_enc_cbc1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sms4_enc1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sms4_dec_cbc1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sms4_dec1, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 55d8818ee2..296a507ba1 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -782,6 +782,56 @@ static int octeon_aes_key_bits(const MIPSOcteonCryptoState *crypto)
         return 0;
     }
 }
+static inline uint32_t octeon_sms4_t(uint32_t x)
+{
+    x = sm4_subword(x);
+    return x ^ rol32(x, 2) ^ rol32(x, 10) ^
+           rol32(x, 18) ^ rol32(x, 24);
+}
+
+static inline uint32_t octeon_sms4_t_key(uint32_t x)
+{
+    x = sm4_subword(x);
+    return x ^ rol32(x, 13) ^ rol32(x, 23);
+}
+
+static void octeon_sms4_expand_key(const uint8_t *key, uint32_t round_keys[32])
+{
+    static const uint32_t fk[4] = {
+        0xa3b1bac6U, 0x56aa3350U, 0x677d9197U, 0xb27022dcU,
+    };
+    uint32_t k[36];
+
+    for (int i = 0; i < 4; i++) {
+        k[i] = ldl_be_p(key + i * 4) ^ fk[i];
+    }
+    for (int i = 0; i < 32; i++) {
+        k[i + 4] = k[i] ^ octeon_sms4_t_key(k[i + 1] ^ k[i + 2] ^
+                                            k[i + 3] ^ sm4_ck[i]);
+        round_keys[i] = k[i + 4];
+    }
+}
+
+static void octeon_sms4_crypt_block(const uint8_t *in, uint8_t *out,
+                                    const uint32_t round_keys[32],
+                                    bool encrypt)
+{
+    uint32_t x[36];
+
+    for (int i = 0; i < 4; i++) {
+        x[i] = ldl_be_p(in + i * 4);
+    }
+    for (int i = 0; i < 32; i++) {
+        uint32_t rk = round_keys[encrypt ? i : 31 - i];
+
+        x[i + 4] = x[i] ^ octeon_sms4_t(x[i + 1] ^ x[i + 2] ^
+                                        x[i + 3] ^ rk);
+    }
+    stl_be_p(out, x[35]);
+    stl_be_p(out + 4, x[34]);
+    stl_be_p(out + 8, x[33]);
+    stl_be_p(out + 12, x[32]);
+}
 static void octeon_aes_load_key(const MIPSOcteonCryptoState *crypto,
                                 uint8_t *key, size_t keylen)
 {
@@ -806,6 +856,46 @@ static void octeon_aes_store_block(uint64_t regs[2], const uint8_t *block)
     regs[0] = ldq_be_p(block);
     regs[1] = ldq_be_p(block + 8);
 }
+static void octeon_sms4_crypt_common(MIPSOcteonCryptoState *crypto,
+                                     bool encrypt, bool cbc)
+{
+    uint8_t key[16];
+    uint8_t in[16];
+    uint8_t out[16];
+    uint8_t iv[16];
+    uint8_t next_iv[16];
+    uint32_t round_keys[32];
+
+    /*
+     * SMS4 aliases the AES state onto the RESINP, IV, and KEY banks,
+     * with only the operation selectors remaining distinct.
+     */
+    octeon_aes_load_key(crypto, key, sizeof(key));
+    octeon_aes_load_block(crypto->aes_input, in);
+    if (cbc) {
+        octeon_aes_load_block(crypto->aes_iv, iv);
+        if (encrypt) {
+            for (int i = 0; i < sizeof(in); i++) {
+                in[i] ^= iv[i];
+            }
+        } else {
+            memcpy(next_iv, in, sizeof(next_iv));
+        }
+    }
+
+    octeon_sms4_expand_key(key, round_keys);
+    octeon_sms4_crypt_block(in, out, round_keys, encrypt);
+    if (cbc && !encrypt) {
+        for (int i = 0; i < sizeof(out); i++) {
+            out[i] ^= iv[i];
+        }
+    }
+
+    octeon_aes_store_block(crypto->aes_result, out);
+    if (cbc) {
+        octeon_aes_store_block(crypto->aes_iv, encrypt ? out : next_iv);
+    }
+}
 static void octeon_aes_encrypt_common(MIPSOcteonCryptoState *crypto, bool cbc)
 {
     AES_KEY key;
@@ -1083,6 +1173,37 @@ void helper_octeon_cp2_mt_gfm_xormul1(CPUMIPSState *env, uint64_t value)
     }
     crypto->gfm_xor0 = 0;
 }
+void helper_octeon_cp2_mt_sms4_enc_cbc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_input[1] = value;
+    octeon_sms4_crypt_common(crypto, true, true);
+}
+
+void helper_octeon_cp2_mt_sms4_enc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_input[1] = value;
+    octeon_sms4_crypt_common(crypto, true, false);
+}
+
+void helper_octeon_cp2_mt_sms4_dec_cbc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_input[1] = value;
+    octeon_sms4_crypt_common(crypto, false, true);
+}
+
+void helper_octeon_cp2_mt_sms4_dec1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_input[1] = value;
+    octeon_sms4_crypt_common(crypto, false, false);
+}
 void helper_octeon_cp2_mt_snow3g_start(CPUMIPSState *env, uint64_t value)
 {
     octeon_snow3g_start(&env->octeon_crypto, value);

-- 
2.54.0


