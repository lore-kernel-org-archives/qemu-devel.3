Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCBFCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgu-0001GC-Mx; Wed, 20 May 2026 00:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgt-0001Fq-0Q
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:55 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgq-0003sN-QM
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:54 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7de7dc85b74so4360814a34.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251871; x=1779856671; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z5c2GfZvhYAkQR0XFUCFYjnXKW2wx/zZbOkbepyTfX0=;
 b=A37g8/TJ6brY14RmmOLIGWD3SAT2PmcNZQIx1YZnvtFNiiN8khhycrhx/vyRb87KQP
 hpJACcHNbGxVONAAN1PzCIPhJgiMaTgdrRcRHyafpqBnozZ+stxP9XFGCI0ktVb6eeja
 BuXhiQoDeC+SB3dghN8HYvlpe4TQbp90hE9yS890yQteeDHyvAV2VWJR3gqGJNlpNMc/
 bhGgaBn8Nmw7+PKKRfZAcwZTOmGj4wOFo59XJsDZuxz28qVnKEQnCnP0rvzPtw9DL7cX
 bMQZCUp81Bl2um8pQKwh/mda6M1Nj64uAiVumgE3jgpLX1nfCkQNbuAuYWg76bEJ3B7B
 eKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251871; x=1779856671;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z5c2GfZvhYAkQR0XFUCFYjnXKW2wx/zZbOkbepyTfX0=;
 b=iMrsycgF3VSYDvwo/d+mm4NFkEkTOLDplhgZjQw92YrAln02osudm+vtI61O01lQeX
 wEmObbsbFFiVmXzepbwux1zTPYEmMARXmFafN6s53Hfz7M7L1P7TSYVfHlZc8PWVOqZw
 FWi15nDTIQS7DYWnFWUsAZHedgKtrYo8ymLmpbENVH9eQ4bERI/MEsI8dDoby6/VhNPq
 IVZ6jr/qf22QVuUH8D7WTItFHWo7f27cSVG9CyVDCf9ZBbFK+etMVynSBNIDtKodkT/c
 pGY5w8WywEVCaJOE/DPJGPMYKdheCTRtUC5kRyTyMuCBYaPv72glZo1uLBBOB817CSHj
 xJtA==
X-Gm-Message-State: AOJu0YwJtHtAxDCD6gvi1dHoV76YAhLWuqvw+AyagTatC1UcK4Q1lv+U
 +YETWE/bdHffny5fCwSv38L3Bsyh/mVt6ipT5X0Tbc/1ED/Qxp6pkU4p
X-Gm-Gg: Acq92OFMjsl6jpHxsN+s+99sQmRgtN4WCqtPRr8PMpkZw7GeNZmRCRau8zcveEgl3//
 KZAi6x9hGcb5pqcyCkEgv5wnWYSkKJ3/oGNvjKt5wPWw20rN/7wX7PPeEZsZBcUEd26En9tXLlv
 1tFLnUjXOXPP9scgM3Lye2ZQb5zATtKKrl3+5+zSLvy28eqpIWCBtRWy6Ra9htbRRfwkV4NMjuO
 lju2uApyMU4cimNTjaEdwGM7XsZs6GCjAnPWhxeut4hxMmdNSkIC+MQ/WdQmrDz2ITKOHG44kRW
 nbnGT9mEB9Wukxq790975+n6k8dEuerWZjf8vxHs3gbXrRn5Ts+okUYIwj1iswtTty0VO2/oReh
 1N2BxotY7vsqT4zIC8MtmJixQNbi0xXt1TtT+zaI/WKD4Zt19MTYrUFb9uHok3VZVlgWwb95Jyd
 a7oGPaCUEPxBE1sJDcFMKNUhq15whXtVFQpLBF/9jpOX0r9Nsmc80Ch3FGmgHgzV8PKaggdgG+D
 eL6Ko1160xNG8C3cozQhET5rT6kmYS+7x6GQHgf8UG0PhSvtkg/5YOwQpOXAfXK2gfR
X-Received: by 2002:a05:6830:6a15:b0:7d9:b338:a695 with SMTP id
 46e09a7af769-7e4ea028c6dmr14478480a34.5.1779251871620; 
 Tue, 19 May 2026 21:37:51 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:50 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:25 -0600
Subject: [PATCH v10 31/45] target/mips: add Octeon AES COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-31-306f9edfe15b@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x332.google.com
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
index 7fa4014fce..82b4a6b099 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -68,6 +68,10 @@ DEF_HELPER_2(octeon_cp2_mt_zuc_start, void, env, i64)
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
index 199893c11a..a8f46cc398 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -904,6 +904,151 @@ static void octeon_snow3g_more(MIPSOcteonCryptoState *crypto)
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


