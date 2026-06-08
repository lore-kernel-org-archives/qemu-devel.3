Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E62CD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfCw-00010x-Nl; Mon, 08 Jun 2026 15:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCu-000107-1a
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:20 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCq-0006fe-B0
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:18 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e6b5c374e5so4546874a34.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 12:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780945215; x=1781550015; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m/O78Va3qO+h5+mpTOassVF0XL1MRob9oT7c7KbS470=;
 b=KjtwtIxAFAyeVgTJrr9wmSy+KKFaHmaIykXWq0VpAi6IBOp9nJd3i7LZEu4ggECTwa
 mggz8V3oK+lAiXmVSDrW8wT+/DPYYnWAjwa9gKGw4YMkWZheDob6Gpd077IQ2EAWOmEa
 eI+mVbsnfZf0B6nDVALcf9XzopmlkwV14ov3iC7kFDGALxlQKfd6BYye8fLPj3HaaWuy
 mlpSZnNlm7uEb2/5TROx0G3++JMumcTd/qqLipDy2/zuew4SQrjk3anIPWOU+VvT7WPI
 WgpGs/E2dUmDYogLniSQDX2HeGR/3jDyV1C57rVPctamWgbfo19ACbgr+IyJ36+LknZf
 bnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945215; x=1781550015;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m/O78Va3qO+h5+mpTOassVF0XL1MRob9oT7c7KbS470=;
 b=sQ6oqV1TDzl400CSJcixVBt4mlbnWPrp5Nvg5RccX5AEng6LhqYlRYXfdM9Er/Wtmk
 gWeLIYGmBB5njsX4knqMYfjV8yzWmdseSPbVb5z9Rvbbwe4McTNDVc01AdgnVVS80FwA
 CiMqRiYGVM8knApNjuRVOETEGYA3adtbceH8pll2hLXuvoaIx+7aBDiy2BJ3oiObi2Wp
 kICDifXBL6UgyIT44wsiuCRva8/J44ff3bxG1P3WZduPKYjSwUG0JZvhBQn67OG2Bp7N
 xzMJkRPeXUHAKZJoI25hb/OECCfYEW5evcaw0dquzwgsPJhxOtliESClgd5xcn5ZpvAe
 xIxw==
X-Gm-Message-State: AOJu0Yw9RrET+QwHadCR1p2HwHHn2eZDncG6gAbPwfmszdZ7THQ3Wfk9
 yKNKKUtapXOvJvF3VKhTXvTUAbFsllWvaYHtMz7zLc89pJggXZDVC0/GGKMbcKkRAS8=
X-Gm-Gg: Acq92OGMJUV0VEREYMlneaRkqmIwHiZaZc82oLFp3fdbDeR7KWVjfnZi3o1KQ1Rz5ch
 LM97HRFWTMEu0LkzZL+w52ofV+5zttGc7eEggLWTxJjq/RQQxmhOebHDCCUvq7eNvvxnucfoBmW
 IvMc5gqYzub6f6ccQlODVCtuB3zXOUwV7Rs9uhFzh1fqntm5qAJzMjgZueKV3T2/GRGytkgqQ6y
 5yGkFF2Tm7Xuus8xFmUOTaej+5fRR7T90wMbTFMe3XWoGBijQPS+haMcJydS2y/RIGkodebV1mD
 ABtg9/yJZJsPGBwlhW/KE+s1LMMTOM6aDIZnhcu6XUPw1tBrf1MdB5SX1bK//5bD+3rKqistqAt
 KpEO/77pMB1d+PZ+XY2sPiuzI09OyjE1zwrP0lXxXl+5uSgNNCBAGNnSjFp747LCx1NsinqWCaK
 BHXWEcZ62kyCBUsjASqjPk0I/Msy2DsdYzLs15sAHXz3iRHZuFsD4+vCu7a+Jy91EYR1rkSuF8Y
 FH3dDTlPGf1GKE1F1+UK6wX4OwmN334padC68aXsp9mEZ4Z5EdnxWJxUN/GSGs0ok1DZrFyiCtb
 929HAkRMv2RG7qUHCmIyvGGp6QvWCFjH
X-Received: by 2002:a05:6830:67e4:b0:7e3:be56:e0e7 with SMTP id
 46e09a7af769-7e70f3f4464mr7396046a34.11.1780945214726; 
 Mon, 08 Jun 2026 12:00:14 -0700 (PDT)
Received: from mac.localdomain (97-118-5-210.hlrn.qwest.net. [97.118.5.210])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e75db138sm12397777a34.11.2026.06.08.12.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:00:14 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 08 Jun 2026 12:59:36 -0600
Subject: [PATCH v16 11/21] target/mips: add Octeon Camellia COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-mips-octeon-missing-insns-v2-v16-11-daef7a0d8b04@gmail.com>
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

Changes v5 -> v6:
  - Use RESINP wording for the Camellia shared selector aliases.

Changes v1 -> v2:
  - Drop the Octeon prefix from generic Camellia helper routines.
    (suggested by Philippe Mathieu-Daudé)
  - Add selector dispatch updates in octeon_translate.c after moving
    COP2 decode out of translate.c.  (suggested by Philippe
    Mathieu-Daudé)
---
 target/mips/helper.h            |   3 +
 target/mips/tcg/octeon_crypto.c | 126 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index c9332c5c52..71b7a2b30e 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -66,6 +66,9 @@ DEF_HELPER_2(octeon_cp2_mt_des3_enc, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_kas_enc, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_des3_dec_cbc, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_des3_dec, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_camellia_fl, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_camellia_flinv, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_camellia_round, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 3365d1380e..67959618cc 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -1568,6 +1568,132 @@ void helper_octeon_cp2_mt_des3_dec(CPUMIPSState *env, uint64_t value)
     octeon_3des_crypt_common(&env->octeon_crypto, value, false, false);
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
+    uint64_t left = crypto->aes_resinp[0];
+    uint64_t right = crypto->aes_resinp[1];
+
+    crypto->aes_resinp[0] = right ^ camellia_f(left, key);
+    crypto->aes_resinp[1] = left;
+}
+
+static void octeon_camellia_fl_layer(MIPSOcteonCryptoState *crypto,
+                                     uint64_t key, bool inverse)
+{
+    uint64_t state = crypto->aes_resinp[inverse ? 1 : 0];
+
+    crypto->aes_resinp[inverse ? 1 : 0] = inverse ?
+        camellia_flinv(state, key) :
+        camellia_fl(state, key);
+}
+
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
+
 void helper_octeon_cp2_mt_snow3g_start(CPUMIPSState *env, uint64_t value)
 {
     octeon_snow3g_start(&env->octeon_crypto, value);

-- 
2.54.0


