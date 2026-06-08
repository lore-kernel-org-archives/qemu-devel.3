Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB822CD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfD0-00013u-Bv; Mon, 08 Jun 2026 15:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCu-000108-1J
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:20 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCp-0006fD-Fe
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:17 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7e6d14aaef8so2085441a34.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780945213; x=1781550013; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4cvv9uFzIlix0aHZHW7IXUB7h+HGXq8FdmHAt2uF7zY=;
 b=aY9VutirsEsTTpxmCtX9aW/Uo6y2bnUhdT7aGGy6n621euO1w154bMNkVdpjQBq3Ur
 LzLDoOKynM/w2n5x7RyFJYv6fIOrxIZE366f/N4Qrn7wyDZdV7Ym3E2R+EA2rRqR4QNA
 UPV3MhhzEbOL0Jd+IzP9IvIAtLTLbQSiQQ0V1PD5Kqz2Vv4PubaqTqLCmEDV1oItpyLu
 yD/lIHRRSRXnjCR3RVHalYuuu0qpHSW5QNWRVdE4p9BV1weQYNpWbqHfdUP/M8LqKcZ+
 cGkJn/8ZaX9A6UQyWmTDfesw3mheMShlYrTwPAF4BQw9qPVMbFOMuiJ9ZzJrlsYoF+sG
 CmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945213; x=1781550013;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4cvv9uFzIlix0aHZHW7IXUB7h+HGXq8FdmHAt2uF7zY=;
 b=sazp6xKPBC4f9KIKDKsYDo7GtYZr199qe818i2eq1XG5m4RN/Iobq7RsUWHRYj4vDb
 CC93tMMSXN2UNffJgyvDKBID2WcUoSr7cn/REGAvs9kajEHP1nb6MK/8liTSp+JNADEO
 ZMHFnlcNDzcQcN+wp+B2aeWzyPjV8N6y07gTZY+PW/5Us549lvuVpUYr7t4cyi4ntiyp
 VWLAAJafrCOFLF6BlPNl4jUJQC63kvLrtsYvFufGJT+ptdlX94P4lhugIEAt9eo6pbDl
 SmTzhW8F0NSEz/aRkfi6ME8j/IPtWXo4e0O1dhoTr50+/ZouZLzGH0WUrpb2rILY3LBX
 gBjA==
X-Gm-Message-State: AOJu0YwngQmE4VDa5JfmFNMQtifErKQUy/nqjc0SDDGYYSwmrRrt90OY
 sXQOGKkijtcVxzYyV0TVKm6Vv54WgBqIub7F8bwRztpMoqerDwNmjThu/FGaxD7EV2s=
X-Gm-Gg: Acq92OFZf/4Phhckxfw6knNZaDpZ6sTTK0aKp2ScrgcKNG67MCV7HMXq9W+B34vg+7/
 r3j1j8RQet5y5rx8/Wt7KCXo/szT5Z5tP1MjGYdTCdD54hOe0LY0okkkNBkBB1yO0/E/mYyjx+8
 F2L+0blGjDrhZSSoP1k90ijpeZXo2Bv1GQN7YfJgWoaZNXVIeA+oOupGjwegT3W7NsI9vRVzaEW
 Je7+qPFvtSUoqCenGElfRWWUYydkqHmJC2v4ydeC5tudmDoXs13jUxdqPQnTB2vfK8wVLCidwcH
 3rmz/mcIcOaglHckVQWzpaNxBtMgoCpkezwwAwwNLLeiSGcxgpFsUxi7ueQn6rImcyVVi6F5mmE
 bwEL1YE3UpRXrxiI0gmPCc6gwlZXa0UNIDGSO2HQ10EXuk0BFkexilCjiWHxlV3uLPDQcSMI86U
 We8u3nyJ6K+FKC98EhnUFcD/JzkMk43YwOICO+hO4ZdOvSsno3Y7A+bBwGNcPU5osfATEVEtqx/
 psALQI/b/FcY8f6suUYOYXoam9D8p13eaSfuNlSMGmyjgR0QBpr1aoImcYpEZo0ZAI91KuzFAVf
 PT5WDgiebi2/ZYjY/lLCsdaFdH0BKiqG
X-Received: by 2002:a05:6830:2b0b:b0:7e6:ff83:4b36 with SMTP id
 46e09a7af769-7e70c68c90cmr10033566a34.8.1780945212836; 
 Mon, 08 Jun 2026 12:00:12 -0700 (PDT)
Received: from mac.localdomain (97-118-5-210.hlrn.qwest.net. [97.118.5.210])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e75db138sm12397777a34.11.2026.06.08.12.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:00:12 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 08 Jun 2026 12:59:34 -0600
Subject: [PATCH v16 09/21] target/mips: add Octeon SMS4 COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-mips-octeon-missing-insns-v2-v16-9-daef7a0d8b04@gmail.com>
References: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
In-Reply-To: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
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

Add helper support for the Octeon SMS4 operation selectors. SMS4 reuses
the AES RESINP, IV, and key banks, so the helpers share the existing AES
state while implementing the SMS4 ECB/CBC encrypt and decrypt operations.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Split SMS4 operation selectors into their own COP2 helper patch.
  - Replace generic selector dispatch with per-operation SMS4 helpers.
  - Add matching helper.h declarations with the helper implementation.

Changes v5 -> v6:
  - Use RESINP wording for the SMS4 shared selector aliases.

Changes v1 -> v2:
  - Add selector dispatch updates in octeon_translate.c after moving
    COP2 decode out of translate.c.  (suggested by Philippe
    Mathieu-Daudé)
---
 target/mips/helper.h            |   4 ++
 target/mips/tcg/octeon_crypto.c | 124 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 39c226ded9..4949b94657 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -56,6 +56,10 @@ DEF_HELPER_2(octeon_cp2_mt_aes_enc_cbc1, void, env, i64)
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
index 3de7ad31bf..abc16754e0 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -986,6 +986,130 @@ void helper_octeon_cp2_mt_aes_dec1(CPUMIPSState *env, uint64_t value)
     octeon_aes_decrypt_common(crypto, false);
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
+
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
+    octeon_aes_load_block(crypto->aes_resinp, in);
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
+    octeon_aes_store_block(crypto->aes_resinp, out);
+    if (cbc) {
+        octeon_aes_store_block(crypto->aes_iv, encrypt ? out : next_iv);
+    }
+}
+
+void helper_octeon_cp2_mt_sms4_enc_cbc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_sms4_crypt_common(crypto, true, true);
+}
+
+void helper_octeon_cp2_mt_sms4_enc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_sms4_crypt_common(crypto, true, false);
+}
+
+void helper_octeon_cp2_mt_sms4_dec_cbc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_sms4_crypt_common(crypto, false, true);
+}
+
+void helper_octeon_cp2_mt_sms4_dec1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_sms4_crypt_common(crypto, false, false);
+}
+
 void helper_octeon_cp2_mt_snow3g_start(CPUMIPSState *env, uint64_t value)
 {
     octeon_snow3g_start(&env->octeon_crypto, value);

-- 
2.54.0


