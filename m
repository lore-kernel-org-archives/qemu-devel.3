Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C72CD4F5E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDw-0006x9-B9; Tue, 19 May 2026 12:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDs-0006qg-Fq
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:12 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDq-0000ou-H4
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:12 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-439a8366831so1529127fac.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207789; x=1779812589; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UPICKVB8e8S6y4T95y/ZuKKTfFnkhWoVNrB3TcHrnm4=;
 b=DBLUi0Tu/DDbQl4T3py9/buZrN0xPFrpAESsDI2QwhQopnqgjCSBYq9YYDOdv/c+k9
 wtKKs6zhoe7Abbwxmvf7ADqRgQh29jfoJQ2Fqf5N1y1b7XLKmFNbiu0kgwbUkE8QJFOc
 EcobEGRLfRA7AVC6G+7fJ6V99DhVmfE0aHtS824z963/Fofa0UtApJg++nrg7vN7rm8k
 6CSdKJnR2qCA2voICiDuRIqs33bUs6q0cUnMyv3QjPneYKl0UlrYOqswfPEsFFn6Fjrx
 qRpJRsleAixvAWHwvLiA88Lutj9U4opTFs8zMFbyf37/2TqqCrCKDKd35Ha0yULCHl5Y
 VWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207789; x=1779812589;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UPICKVB8e8S6y4T95y/ZuKKTfFnkhWoVNrB3TcHrnm4=;
 b=bbXFuVVC6Y8spbXf9SvoKxjgQB37bDyw/7htGk6vedEz2tJr5vsKMK/opTKBRMteYT
 0vWqBUUxfYfvlg2psZfuLhp65qyduuYdGNX3q2eSx+QTzOqHONkOf/005QDKqUf6CsxV
 MSy47xKSlVVaWw63/WwXMp0qprSKAOa+/u9s0a4lDfTpfsDfGdurzm+dSKnsi4Nxb2Zb
 jD7rEV6k4JZJxwbxBDQ4jkcButGTduT1q/CVdFyLELtqYHp96xrMPHl4PMRHPIYbJi4+
 W8/BqPktW4A8CD+IG7XhMrnus9pEjPITX6YKslY10CHsiCC3ituX7B83WZaoV9GD6OPp
 emhA==
X-Gm-Message-State: AOJu0Yy3FVvTVlLWWQYoOHQdqJB8/TP1ks9yVcb5GSbOmpAPRYPwQ6WC
 wxCXkagXiZ9gc4Sqcbb90YhoFtH7AJ7R/K8iGtFdMwQLEX2MWNyYQ/7g
X-Gm-Gg: Acq92OFzbqpNWvibkzlkAhlFxxyILETpejDeJD+BdT4El4ioIdflD/WzDYNH6gKOjDF
 24h9DjG9Z0qyM07O2qxX0NBSxC6riWrBCGxhfdzNY/E9zlT+ki33cqaETUiLBQbtVdVOzVtOQie
 /xurgeiT1SCBrMs//g4Z6Hk+c/PS0jSYqcF31x3qQlPcqyWhA/hh809zULG9uiKYhYkIGVONHID
 lw1NvIPXJ7IHdJSnfxqzbd+Ev7ebFhW5uGviR3pOEM9xjNfGDZnGGh9Wo9Ba+8Bqn+DP2wE+m0Q
 qFcSZRI+mNMD6Wj+/mfT8qS5+pvWDsUTD5/WqqzVUJEmrS4svV1dtKW0iHfQ+zHuWOueBRZDtKd
 IUumOHHEHsBr4DLWSu2ArXHGUvoGrBK0qa9V0L8FUwLY7+C3gWRXKL0MsjIFdXfEy03NP+mRJPx
 SUiK/HLpLxRoiuwz3Soe3kLlW961g5dY6E834jcXP9M1xxH8xP+0YBgQYJrkOtUCI9rc/mI78PC
 11e5ZgmpWbvmatY6xMskKa7rK4gW0L6Qz7dZJNXsP98YjUQPY3fyI+j0ql8015PUvwS
X-Received: by 2002:a05:6870:a0b6:b0:430:29f5:285f with SMTP id
 586e51a60fabf-43a2dedb1cdmr13358525fac.35.1779207789322; 
 Tue, 19 May 2026 09:23:09 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:23:09 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:36 -0600
Subject: [PATCH v9 34/40] target/mips: add Octeon Camellia COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-34-d7dd735ecddd@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x2b.google.com
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

Add helper support for the Octeon Camellia ROUND, FL, and FLINV
selectors. The engine reuses the AES RESINP bank, and guest-managed key
schedules drive the Camellia F-function and FL layers through these COP2
operations.

Implement the Camellia F-function and FL layers directly from RFC 3713.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Split Camellia operation selectors into their own COP2 helper patch.
  - Replace generic selector dispatch with per-operation Camellia helpers.
  - Add matching helper.h declarations with the helper implementation.

Changes v1 -> v2:
  - Drop the Octeon prefix from generic Camellia helper routines.
    (suggested by Philippe Mathieu-Daudé)
  - Add selector dispatch updates in octeon_translate.c after moving
    COP2 decode out of translate.c.  (suggested by Philippe
    Mathieu-Daudé)

Changes v5 -> v6:
  - Use RESINP wording for the Camellia shared selector aliases.
---
 target/mips/helper.h            |   3 +
 target/mips/tcg/octeon_crypto.c | 124 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 9a13f00de8..23c712cfb7 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -80,6 +80,9 @@ DEF_HELPER_2(octeon_cp2_mt_des3_enc, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_kas_enc, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_des3_dec_cbc, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_des3_dec, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_camellia_fl, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_camellia_flinv, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_camellia_round, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 851a3cbdea..d26dd2924d 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -1283,6 +1283,116 @@ static void octeon_aes_store_block(uint64_t regs[2], const uint8_t *block)
     regs[0] = ldq_be_p(block);
     regs[1] = ldq_be_p(block + 8);
 }
+static const uint8_t camellia_sbox1[256] = {
+    112, 130,  44, 236, 179,  39, 192, 229, 228, 133,  87,  53, 234,  12,
+    174,  65,  35, 239, 107, 147,  69,  25, 165,  33, 237,  14,  79,  78,
+     29, 101, 146, 189, 134, 184, 175, 143, 124, 235,  31, 206,  62,  48,
+    220,  95,  94, 197,  11,  26, 166, 225,  57, 202, 213,  71,  93,  61,
+    217,   1,  90, 214,  81,  86, 108,  77, 139,  13, 154, 102, 251, 204,
+    176,  45, 116,  18,  43,  32, 240, 177, 132, 153, 223,  76, 203, 194,
+     52, 126, 118,   5, 109, 183, 169,  49, 209,  23,   4, 215,  20,  88,
+     58,  97, 222,  27,  17,  28,  50,  15, 156,  22,  83,  24, 242,  34,
+    254,  68, 207, 178, 195, 181, 122, 145,  36,   8, 232, 168,  96, 252,
+    105,  80, 170, 208, 160, 125, 161, 137,  98, 151,  84,  91,  30, 149,
+    224, 255, 100, 210,  16, 196,   0,  72, 163, 247, 117, 219, 138,   3,
+    230, 218,   9,  63, 221, 148, 135,  92, 131,   2, 205,  74, 144,  51,
+    115, 103, 246, 243, 157, 127, 191, 226,  82, 155, 216,  38, 200,  55,
+    198,  59, 129, 150, 111,  75,  19, 190,  99,  46, 233, 121, 167, 140,
+    159, 110, 188, 142,  41, 245, 249, 182,  47, 253, 180,  89, 120, 152,
+      6, 106, 231,  70, 113, 186, 212,  37, 171,  66, 136, 162, 141, 250,
+    114,   7, 185,  85, 248, 238, 172,  10,  54,  73,  42, 104,  60,  56,
+    241, 164,  64,  40, 211, 123, 187, 201,  67, 193,  21, 227, 173, 244,
+    119, 199, 128, 158,
+};
+
+static inline uint8_t camellia_rotl8(uint8_t v, unsigned int shift)
+{
+    return (v << shift) | (v >> (8 - shift));
+}
+
+static inline uint8_t camellia_sbox2(uint8_t x)
+{
+    return camellia_rotl8(camellia_sbox1[x], 1);
+}
+
+static inline uint8_t camellia_sbox3(uint8_t x)
+{
+    return camellia_rotl8(camellia_sbox1[x], 7);
+}
+
+static inline uint8_t camellia_sbox4(uint8_t x)
+{
+    return camellia_sbox1[camellia_rotl8(x, 1)];
+}
+
+static uint64_t camellia_f(uint64_t input, uint64_t key)
+{
+    uint64_t x = input ^ key;
+    uint8_t t1 = camellia_sbox1[x >> 56];
+    uint8_t t2 = camellia_sbox2((x >> 48) & 0xff);
+    uint8_t t3 = camellia_sbox3((x >> 40) & 0xff);
+    uint8_t t4 = camellia_sbox4((x >> 32) & 0xff);
+    uint8_t t5 = camellia_sbox2((x >> 24) & 0xff);
+    uint8_t t6 = camellia_sbox3((x >> 16) & 0xff);
+    uint8_t t7 = camellia_sbox4((x >> 8) & 0xff);
+    uint8_t t8 = camellia_sbox1[x & 0xff];
+    uint8_t y1 = t1 ^ t3 ^ t4 ^ t6 ^ t7 ^ t8;
+    uint8_t y2 = t1 ^ t2 ^ t4 ^ t5 ^ t7 ^ t8;
+    uint8_t y3 = t1 ^ t2 ^ t3 ^ t5 ^ t6 ^ t8;
+    uint8_t y4 = t2 ^ t3 ^ t4 ^ t5 ^ t6 ^ t7;
+    uint8_t y5 = t1 ^ t2 ^ t6 ^ t7 ^ t8;
+    uint8_t y6 = t2 ^ t3 ^ t5 ^ t7 ^ t8;
+    uint8_t y7 = t3 ^ t4 ^ t5 ^ t6 ^ t8;
+    uint8_t y8 = t1 ^ t4 ^ t5 ^ t6 ^ t7;
+
+    return ((uint64_t)y1 << 56) | ((uint64_t)y2 << 48) |
+           ((uint64_t)y3 << 40) | ((uint64_t)y4 << 32) |
+           ((uint64_t)y5 << 24) | ((uint64_t)y6 << 16) |
+           ((uint64_t)y7 << 8) | y8;
+}
+
+static uint64_t camellia_fl(uint64_t input, uint64_t key)
+{
+    uint32_t x1 = input >> 32;
+    uint32_t x2 = input;
+    uint32_t k1 = key >> 32;
+    uint32_t k2 = key;
+
+    x2 ^= rol32(x1 & k1, 1);
+    x1 ^= x2 | k2;
+    return ((uint64_t)x1 << 32) | x2;
+}
+
+static uint64_t camellia_flinv(uint64_t input, uint64_t key)
+{
+    uint32_t y1 = input >> 32;
+    uint32_t y2 = input;
+    uint32_t k1 = key >> 32;
+    uint32_t k2 = key;
+
+    y1 ^= y2 | k2;
+    y2 ^= rol32(y1 & k1, 1);
+    return ((uint64_t)y1 << 32) | y2;
+}
+
+static void octeon_camellia_round(MIPSOcteonCryptoState *crypto, uint64_t key)
+{
+    uint64_t left = crypto->aes_result[0];
+    uint64_t right = crypto->aes_result[1];
+
+    crypto->aes_result[0] = right ^ camellia_f(left, key);
+    crypto->aes_result[1] = left;
+}
+
+static void octeon_camellia_fl_layer(MIPSOcteonCryptoState *crypto,
+                                     uint64_t key, bool inverse)
+{
+    uint64_t state = crypto->aes_result[inverse ? 1 : 0];
+
+    crypto->aes_result[inverse ? 1 : 0] = inverse ?
+        camellia_flinv(state, key) :
+        camellia_fl(state, key);
+}
 static void octeon_sms4_crypt_common(MIPSOcteonCryptoState *crypto,
                                      bool encrypt, bool cbc)
 {
@@ -1577,6 +1687,20 @@ void helper_octeon_cp2_mt_aes_dec1(CPUMIPSState *env, uint64_t value)
     crypto->aes_input[1] = value;
     octeon_aes_decrypt_common(crypto, false);
 }
+void helper_octeon_cp2_mt_camellia_fl(CPUMIPSState *env, uint64_t value)
+{
+    octeon_camellia_fl_layer(&env->octeon_crypto, value, false);
+}
+
+void helper_octeon_cp2_mt_camellia_flinv(CPUMIPSState *env, uint64_t value)
+{
+    octeon_camellia_fl_layer(&env->octeon_crypto, value, true);
+}
+
+void helper_octeon_cp2_mt_camellia_round(CPUMIPSState *env, uint64_t value)
+{
+    octeon_camellia_round(&env->octeon_crypto, value);
+}
 void helper_octeon_cp2_mt_des3_enc_cbc(CPUMIPSState *env, uint64_t value)
 {
     octeon_3des_crypt_common(&env->octeon_crypto, value, true, true);

-- 
2.54.0


