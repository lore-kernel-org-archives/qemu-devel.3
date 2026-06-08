Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D70ECD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfCz-000138-Am; Mon, 08 Jun 2026 15:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCv-00010f-Rm
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:21 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCp-0006fN-SN
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:19 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-48673dc56a8so3988311b6e.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780945214; x=1781550014; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UpAj8TSllj8xHkTWAPTgWFWUvutDMhgIJNlRyodTd8E=;
 b=OzW8o1NTqitvcBEBRGuYcMC24HBfJxEKeeJ8l80d59t+detVCI1oo9LE2qc1jLZRU9
 XwFs9qG2ycAn534FBx55oInPY9rMDKUi1KLY0YvoEzt8OE9jP4zNnkltcl4PI398Y/9N
 TCMElCOUTS+EbPGw2CggF7iUQJO6wVYxMwIWenCEx5Idcu6G+LU39BCZ7Grn3BBDcOS/
 Cg0sfQybHJEWPNNnjW23hATKBGEiyHMQUzLA5goJXNLut8ZVYBqoXOq6WjywJWz0BAZM
 35apY7aZVXg9gXAhB3rd44LJscQKJJEbj60wuLaWup8Daezo+BIaT5jangS97K/lurhc
 vr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945214; x=1781550014;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UpAj8TSllj8xHkTWAPTgWFWUvutDMhgIJNlRyodTd8E=;
 b=OGwu8RW69zJG6WgYWqJmHp7NYUncUhme6mi/GocWzX6BS8rRjrN6d1pcyMd/Bgybd/
 C+FN8P/Xv6OPyI+ml/VlmLht0fTtUPDSDLEDXRJE9xGzFYqyhsNQrxpzJ1KdcIbgj1yj
 +Ubs12VnyYirpCD55D2h1aaDk8tdK8xpxSXhpiNcHIi96/v0FQIZTCvx9zpgY+9tgWhy
 rcMN8+7/gAzqBAOfK8M/f+z+1/MOAbmUKCc999Gse1kFbATTYUw9jbcZuEgdMyu9JiPb
 wI1Czbji9xRn0WL4aq6TVwV7Gh2gIhDpQmAGSR3v3FrcuNwOrY/L89PILGEFXvyi6FTI
 GZdw==
X-Gm-Message-State: AOJu0Yw4tVLF7bgsRkftjGxdieTrNkokruTR0jvf1QORzbszaoqqXEOw
 kzaqV8/vY/SuCZlHBiQ5ri6u/orSV/oH5CBKFtvyI2FZ456h/mvnkmNm/wzMNBsCCSg=
X-Gm-Gg: Acq92OF5FIFVqmLaXx+K18giZoC9Ho1jALathlyuuJ5VWBQk70ma8/gzsMxgItvwjd6
 rxcTbUclXEPPBOLeLTJfLBxutGcQPY97AmzlXP3tEUF8pMrHDnos0bUHBxN466BXjyuVn5fpuMT
 7Gy9DdUW7HxC8iMKyDlRgyPm+qnldJeaF2kJxzpwoLTxUHdkP058rZrpMEYgfCBolFoa3ZbwLWr
 3vwn7MrjXZlLo8zNiPci7knpRlGukhayXORQJ7nobtyxa6VQQjsXSi0IQu48eq7gaU4D7FlUtLM
 E8H5xk01InT07N+xQE2J+ioe4BRsDjNnce/fX0AqWQkZ0l1CADDiR+PExQVeAfv3XuHlKKr3hff
 q+g8S5Qc4/svS4raD9jKQ7pSkiRg7dwoJ/vkUJ3AY6xhBPGfX0mN+TW+xoMdKgxy2Xl4iZ1qEa2
 zXLUBoRQHGFnvcE5+XZlyFemwFDnGJYaRNqISVlWkP6GFj0yeSqu4mlstLfePeL/bWu4Y82dKbM
 VqTU7QNgG2G2MH00cPbKv9JGrTTKDKsBmdgKpG2+ERZQx7zf8Oue2ZdlmAWHeBIc0+nQgLM2lD8
 /2xTiqSml2yQA4W+XEHtU4AvdTj0+BP2
X-Received: by 2002:a05:6808:344b:b0:46a:cd63:96ca with SMTP id
 5614622812f47-4868de8414dmr9669383b6e.27.1780945213811; 
 Mon, 08 Jun 2026 12:00:13 -0700 (PDT)
Received: from mac.localdomain (97-118-5-210.hlrn.qwest.net. [97.118.5.210])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e75db138sm12397777a34.11.2026.06.08.12.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:00:13 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 08 Jun 2026 12:59:35 -0600
Subject: [PATCH v16 10/21] target/mips: add Octeon 3DES and KASUMI COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-mips-octeon-missing-insns-v2-v16-10-daef7a0d8b04@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22e.google.com
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

Add helper support for the Octeon 3DES and KASUMI operation selectors.
The 3DES helpers implement ECB and CBC encrypt/decrypt over the shared
3DES key, IV, and result bank. KASUMI reuses the same register bank and
adds its own encrypt selectors.

Only the operation selectors require helper code. Simple key, IV, and
result register transfers are handled by direct selector decode.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Split 3DES/KASUMI operation selectors into their own COP2 helper patch.
  - Replace generic selector dispatch with per-operation 3DES/KASUMI
    helpers.
  - Add matching helper.h declarations with the helper implementation.
---
 target/mips/helper.h            |   6 +
 target/mips/tcg/octeon_crypto.c | 458 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 464 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 4949b94657..c9332c5c52 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -60,6 +60,12 @@ DEF_HELPER_2(octeon_cp2_mt_sms4_enc_cbc1, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_sms4_enc1, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_sms4_dec_cbc1, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_sms4_dec1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_des3_enc_cbc, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_kas_enc_cbc, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_des3_enc, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_kas_enc, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_des3_dec_cbc, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_des3_dec, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index abc16754e0..3365d1380e 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -1110,6 +1110,464 @@ void helper_octeon_cp2_mt_sms4_dec1(CPUMIPSState *env, uint64_t value)
     octeon_sms4_crypt_common(crypto, false, false);
 }
 
+static const uint8_t octeon_des_ip[64] = {
+    58, 50, 42, 34, 26, 18, 10,  2,
+    60, 52, 44, 36, 28, 20, 12,  4,
+    62, 54, 46, 38, 30, 22, 14,  6,
+    64, 56, 48, 40, 32, 24, 16,  8,
+    57, 49, 41, 33, 25, 17,  9,  1,
+    59, 51, 43, 35, 27, 19, 11,  3,
+    61, 53, 45, 37, 29, 21, 13,  5,
+    63, 55, 47, 39, 31, 23, 15,  7,
+};
+
+static const uint8_t octeon_des_fp[64] = {
+    40,  8, 48, 16, 56, 24, 64, 32,
+    39,  7, 47, 15, 55, 23, 63, 31,
+    38,  6, 46, 14, 54, 22, 62, 30,
+    37,  5, 45, 13, 53, 21, 61, 29,
+    36,  4, 44, 12, 52, 20, 60, 28,
+    35,  3, 43, 11, 51, 19, 59, 27,
+    34,  2, 42, 10, 50, 18, 58, 26,
+    33,  1, 41,  9, 49, 17, 57, 25,
+};
+
+static const uint8_t octeon_des_e[48] = {
+    32,  1,  2,  3,  4,  5,
+     4,  5,  6,  7,  8,  9,
+     8,  9, 10, 11, 12, 13,
+    12, 13, 14, 15, 16, 17,
+    16, 17, 18, 19, 20, 21,
+    20, 21, 22, 23, 24, 25,
+    24, 25, 26, 27, 28, 29,
+    28, 29, 30, 31, 32,  1,
+};
+
+static const uint8_t octeon_des_p[32] = {
+    16,  7, 20, 21, 29, 12, 28, 17,
+     1, 15, 23, 26,  5, 18, 31, 10,
+     2,  8, 24, 14, 32, 27,  3,  9,
+    19, 13, 30,  6, 22, 11,  4, 25,
+};
+
+static const uint8_t octeon_des_pc1[56] = {
+    57, 49, 41, 33, 25, 17,  9,
+     1, 58, 50, 42, 34, 26, 18,
+    10,  2, 59, 51, 43, 35, 27,
+    19, 11,  3, 60, 52, 44, 36,
+    63, 55, 47, 39, 31, 23, 15,
+     7, 62, 54, 46, 38, 30, 22,
+    14,  6, 61, 53, 45, 37, 29,
+    21, 13,  5, 28, 20, 12,  4,
+};
+
+static const uint8_t octeon_des_pc2[48] = {
+    14, 17, 11, 24,  1,  5,
+     3, 28, 15,  6, 21, 10,
+    23, 19, 12,  4, 26,  8,
+    16,  7, 27, 20, 13,  2,
+    41, 52, 31, 37, 47, 55,
+    30, 40, 51, 45, 33, 48,
+    44, 49, 39, 56, 34, 53,
+    46, 42, 50, 36, 29, 32,
+};
+
+static const uint8_t octeon_des_rotations[16] = {
+    1, 1, 2, 2, 2, 2, 2, 2,
+    1, 2, 2, 2, 2, 2, 2, 1,
+};
+
+static const uint8_t octeon_des_sboxes[8][64] = {
+    {
+        14, 4, 13, 1,  2, 15, 11, 8,  3, 10, 6, 12, 5, 9, 0, 7,
+         0, 15, 7, 4, 14,  2, 13, 1, 10,  6, 12, 11, 9, 5, 3, 8,
+         4, 1, 14, 8, 13,  6,  2, 11, 15, 12, 9,  7, 3, 10, 5, 0,
+        15, 12, 8, 2,  4,  9,  1, 7,  5, 11, 3, 14, 10, 0, 6, 13,
+    },
+    {
+        15, 1,  8, 14, 6, 11, 3, 4,  9, 7, 2, 13, 12, 0, 5, 10,
+         3, 13, 4, 7, 15, 2,  8, 14, 12, 0, 1, 10,  6, 9, 11, 5,
+         0, 14, 7, 11, 10, 4, 13, 1,  5, 8, 12, 6,  9, 3,  2, 15,
+        13, 8, 10, 1,  3, 15, 4, 2, 11, 6, 7, 12,  0, 5, 14, 9,
+    },
+    {
+        10, 0,  9, 14, 6, 3, 15, 5,  1, 13, 12, 7, 11, 4, 2, 8,
+        13, 7,  0, 9,  3, 4, 6,  10, 2, 8,  5, 14, 12, 11, 15, 1,
+        13, 6,  4, 9,  8, 15, 3, 0, 11, 1,  2, 12,  5, 10, 14, 7,
+         1, 10, 13, 0,  6, 9, 8, 7,  4, 15, 14, 3, 11, 5,  2, 12,
+    },
+    {
+         7, 13, 14, 3,  0, 6, 9, 10, 1, 2, 8,  5, 11, 12, 4, 15,
+        13, 8,  11, 5,  6, 15, 0, 3,  4, 7, 2, 12, 1,  10, 14, 9,
+        10, 6,  9,  0, 12, 11, 7, 13, 15, 1, 3, 14, 5,  2,  8,  4,
+         3, 15, 0,  6, 10, 1, 13, 8,  9, 4, 5, 11, 12, 7,  2,  14,
+    },
+    {
+         2, 12, 4,  1,  7, 10, 11, 6,  8, 5, 3, 15, 13, 0, 14, 9,
+        14, 11, 2,  12, 4, 7,  13, 1,  5, 0, 15, 10, 3,  9, 8,  6,
+         4, 2,  1,  11, 10, 13, 7, 8, 15, 9, 12, 5,  6,  3, 0, 14,
+        11, 8,  12, 7,  1, 14, 2, 13, 6, 15, 0,  9, 10, 4, 5,  3,
+    },
+    {
+        12, 1,  10, 15, 9, 2,  6, 8,  0, 13, 3, 4, 14, 7, 5, 11,
+        10, 15, 4,  2,  7, 12, 9, 5,  6, 1,  13, 14, 0, 11, 3, 8,
+         9, 14, 15, 5,  2, 8,  12, 3,  7, 0,  4, 10, 1, 13, 11, 6,
+         4, 3,  2,  12, 9, 5,  15, 10, 11, 14, 1, 7,  6, 0,  8, 13,
+    },
+    {
+         4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7,  5, 10, 6, 1,
+        13, 0,  11, 7,  4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6,
+         1, 4,  11, 13, 12, 3, 7, 14, 10, 15, 6, 8,  0, 5,  9, 2,
+         6, 11, 13, 8,  1, 4, 10, 7,  9, 5,  0, 15, 14, 2,  3, 12,
+    },
+    {
+        13, 2,  8, 4,  6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7,
+         1, 15, 13, 8, 10, 3,  7,  4, 12, 5, 6, 11, 0, 14, 9,  2,
+         7, 11, 4,  1,  9, 12, 14, 2, 0,  6, 10, 13, 15, 3, 5, 8,
+         2, 1,  14, 7,  4, 10, 8,  13, 15, 12, 9, 0,  3,  5, 6, 11,
+    },
+};
+
+static const uint8_t octeon_kasumi_s7[128] = {
+     54,  50,  62,  56,  22,  34,  94,  96,  38,   6,  63,  93,   2,  18,
+    123,  33,  55, 113,  39, 114,  21,  67,  65,  12,  47,  73,  46,  27,
+     25, 111, 124,  81,  53,   9, 121,  79,  52,  60,  58,  48, 101, 127,
+     40, 120, 104,  70,  71,  43,  20, 122,  72,  61,  23, 109,  13, 100,
+     77,   1,  16,   7,  82,  10, 105,  98, 117, 116,  76,  11,  89, 106,
+      0, 125, 118,  99,  86,  69,  30,  57, 126,  87, 112,  51,  17,   5,
+     95,  14,  90,  84,  91,   8,  35, 103,  32,  97,  28,  66, 102,  31,
+     26,  45,  75,   4,  85,  92,  37,  74,  80,  49,  68,  29, 115,  44,
+     64, 107, 108,  24, 110,  83,  36,  78,  42,  19,  15,  41,  88, 119,
+     59,   3,
+};
+
+static const uint16_t octeon_kasumi_s9[512] = {
+    167, 239, 161, 379, 391, 334,   9, 338,  38, 226,  48, 358, 452, 385,
+     90, 397, 183, 253, 147, 331, 415, 340,  51, 362, 306, 500, 262,  82,
+    216, 159, 356, 177, 175, 241, 489,  37, 206,  17,   0, 333,  44, 254,
+    378,  58, 143, 220,  81, 400,  95,   3, 315, 245,  54, 235, 218, 405,
+    472, 264, 172, 494, 371, 290, 399,  76, 165, 197, 395, 121, 257, 480,
+    423, 212, 240,  28, 462, 176, 406, 507, 288, 223, 501, 407, 249, 265,
+     89, 186, 221, 428, 164,  74, 440, 196, 458, 421, 350, 163, 232, 158,
+    134, 354,  13, 250, 491, 142, 191,  69, 193, 425, 152, 227, 366, 135,
+    344, 300, 276, 242, 437, 320, 113, 278,  11, 243,  87, 317,  36,  93,
+    496,  27, 487, 446, 482,  41,  68, 156, 457, 131, 326, 403, 339,  20,
+     39, 115, 442, 124, 475, 384, 508,  53, 112, 170, 479, 151, 126, 169,
+     73, 268, 279, 321, 168, 364, 363, 292,  46, 499, 393, 327, 324,  24,
+    456, 267, 157, 460, 488, 426, 309, 229, 439, 506, 208, 271, 349, 401,
+    434, 236,  16, 209, 359,  52,  56, 120, 199, 277, 465, 416, 252, 287,
+    246,   6,  83, 305, 420, 345, 153, 502,  65,  61, 244, 282, 173, 222,
+    418,  67, 386, 368, 261, 101, 476, 291, 195, 430,  49,  79, 166, 330,
+    280, 383, 373, 128, 382, 408, 155, 495, 367, 388, 274, 107, 459, 417,
+     62, 454, 132, 225, 203, 316, 234,  14, 301,  91, 503, 286, 424, 211,
+    347, 307, 140, 374,  35, 103, 125, 427,  19, 214, 453, 146, 498, 314,
+    444, 230, 256, 329, 198, 285,  50, 116,  78, 410,  10, 205, 510, 171,
+    231,  45, 139, 467,  29,  86, 505,  32,  72,  26, 342, 150, 313, 490,
+    431, 238, 411, 325, 149, 473,  40, 119, 174, 355, 185, 233, 389,  71,
+    448, 273, 372,  55, 110, 178, 322,  12, 469, 392, 369, 190,   1, 109,
+    375, 137, 181,  88,  75, 308, 260, 484,  98, 272, 370, 275, 412, 111,
+    336, 318,   4, 504, 492, 259, 304,  77, 337, 435,  21, 357, 303, 332,
+    483,  18,  47,  85,  25, 497, 474, 289, 100, 269, 296, 478, 270, 106,
+     31, 104, 433,  84, 414, 486, 394,  96,  99, 154, 511, 148, 413, 361,
+    409, 255, 162, 215, 302, 201, 266, 351, 343, 144, 441, 365, 108, 298,
+    251,  34, 182, 509, 138, 210, 335, 133, 311, 352, 328, 141, 396, 346,
+    123, 319, 450, 281, 429, 228, 443, 481,  92, 404, 485, 422, 248, 297,
+     23, 213, 130, 466,  22, 217, 283,  70, 294, 360, 419, 127, 312, 377,
+      7, 468, 194,   2, 117, 295, 463, 258, 224, 447, 247, 187,  80, 398,
+    284, 353, 105, 390, 299, 471, 470, 184,  57, 200, 348,  63, 204, 188,
+     33, 451,  97,  30, 310, 219,  94, 160, 129, 493,  64, 179, 263, 102,
+    189, 207, 114, 402, 438, 477, 387, 122, 192,  42, 381,   5, 145, 118,
+    180, 449, 293, 323, 136, 380,  43,  66,  60, 455, 341, 445, 202, 432,
+      8, 237,  15, 376, 436, 464,  59, 461,
+};
+
+static const uint16_t octeon_kasumi_constants[8] = {
+    0x0123, 0x4567, 0x89ab, 0xcdef, 0xfedc, 0xba98, 0x7654, 0x3210,
+};
+
+typedef struct OcteonKasumiSubkeys {
+    uint16_t kli1[8];
+    uint16_t kli2[8];
+    uint16_t koi1[8];
+    uint16_t koi2[8];
+    uint16_t koi3[8];
+    uint16_t kii1[8];
+    uint16_t kii2[8];
+    uint16_t kii3[8];
+} OcteonKasumiSubkeys;
+
+static uint64_t octeon_des_permute(uint64_t input, const uint8_t *table,
+                                   size_t output_bits, size_t input_bits)
+{
+    uint64_t out = 0;
+
+    for (size_t i = 0; i < output_bits; i++) {
+        unsigned src = table[i] - 1;
+
+        out = (out << 1) | ((input >> (input_bits - 1 - src)) & 1);
+    }
+    return out;
+}
+
+static uint32_t octeon_des_rotate28(uint32_t v, unsigned shift)
+{
+    return ((v << shift) | (v >> (28 - shift))) & 0x0fffffffU;
+}
+
+static void octeon_des_expand_subkeys(uint64_t key, uint64_t subkeys[16])
+{
+    uint64_t permuted = octeon_des_permute(key, octeon_des_pc1,
+                                           ARRAY_SIZE(octeon_des_pc1), 64);
+    uint32_t c = (permuted >> 28) & 0x0fffffffU;
+    uint32_t d = permuted & 0x0fffffffU;
+
+    for (int i = 0; i < 16; i++) {
+        c = octeon_des_rotate28(c, octeon_des_rotations[i]);
+        d = octeon_des_rotate28(d, octeon_des_rotations[i]);
+        subkeys[i] = octeon_des_permute(((uint64_t)c << 28) | d,
+                                        octeon_des_pc2,
+                                        ARRAY_SIZE(octeon_des_pc2), 56);
+    }
+}
+
+static uint32_t octeon_des_f(uint32_t r, uint64_t subkey)
+{
+    uint64_t expanded = octeon_des_permute(r, octeon_des_e,
+                                           ARRAY_SIZE(octeon_des_e), 32);
+    uint32_t out = 0;
+
+    expanded ^= subkey;
+    for (int i = 0; i < 8; i++) {
+        uint8_t sextet = (expanded >> (42 - i * 6)) & 0x3f;
+        uint8_t row = ((sextet & 0x20) >> 4) | (sextet & 0x01);
+        uint8_t col = (sextet >> 1) & 0x0f;
+
+        out = (out << 4) | octeon_des_sboxes[i][row * 16 + col];
+    }
+
+    return octeon_des_permute(out, octeon_des_p, ARRAY_SIZE(octeon_des_p), 32);
+}
+
+static uint64_t octeon_des_block_crypt(uint64_t block, uint64_t key,
+                                       bool encrypt)
+{
+    uint64_t subkeys[16];
+    uint64_t permuted = octeon_des_permute(block, octeon_des_ip,
+                                           ARRAY_SIZE(octeon_des_ip), 64);
+    uint32_t l = permuted >> 32;
+    uint32_t r = permuted;
+
+    octeon_des_expand_subkeys(key, subkeys);
+
+    for (int i = 0; i < 16; i++) {
+        uint32_t next = l ^ octeon_des_f(r, subkeys[encrypt ? i : 15 - i]);
+
+        l = r;
+        r = next;
+    }
+
+    return octeon_des_permute(((uint64_t)r << 32) | l,
+                              octeon_des_fp, ARRAY_SIZE(octeon_des_fp), 64);
+}
+
+static uint64_t octeon_3des_block_crypt(uint64_t block, const uint64_t keys[3],
+                                        bool encrypt)
+{
+    if (encrypt) {
+        block = octeon_des_block_crypt(block, keys[0], true);
+        block = octeon_des_block_crypt(block, keys[1], false);
+        block = octeon_des_block_crypt(block, keys[2], true);
+    } else {
+        block = octeon_des_block_crypt(block, keys[2], false);
+        block = octeon_des_block_crypt(block, keys[1], true);
+        block = octeon_des_block_crypt(block, keys[0], false);
+    }
+    return block;
+}
+
+static void octeon_3des_crypt_common(MIPSOcteonCryptoState *crypto,
+                                     uint64_t input_reg,
+                                     bool encrypt, bool cbc)
+{
+    const uint64_t keys[3] = {
+        crypto->des3_key[0],
+        crypto->des3_key[1],
+        crypto->des3_key[2],
+    };
+    uint64_t block = input_reg;
+
+    if (cbc) {
+        if (encrypt) {
+            block ^= crypto->des3_iv;
+            block = octeon_3des_block_crypt(block, keys, true);
+            crypto->des3_iv = block;
+        } else {
+            block = octeon_3des_block_crypt(block, keys, false);
+            block ^= crypto->des3_iv;
+            crypto->des3_iv = input_reg;
+        }
+    } else {
+        block = octeon_3des_block_crypt(block, keys, encrypt);
+    }
+
+    crypto->des3_result = block;
+}
+
+static inline uint16_t octeon_rol16(uint16_t value, unsigned int bits)
+{
+    return (value << bits) | (value >> (16 - bits));
+}
+
+static void octeon_kasumi_key_schedule(const uint64_t key_regs[2],
+                                       OcteonKasumiSubkeys *subkeys)
+{
+    uint16_t key[8];
+    uint16_t key_prime[8];
+
+    key[0] = key_regs[0] >> 48;
+    key[1] = key_regs[0] >> 32;
+    key[2] = key_regs[0] >> 16;
+    key[3] = key_regs[0];
+    key[4] = key_regs[1] >> 48;
+    key[5] = key_regs[1] >> 32;
+    key[6] = key_regs[1] >> 16;
+    key[7] = key_regs[1];
+
+    for (int i = 0; i < 8; i++) {
+        key_prime[i] = key[i] ^ octeon_kasumi_constants[i];
+    }
+
+    for (int i = 0; i < 8; i++) {
+        subkeys->kli1[i] = octeon_rol16(key[i], 1);
+        subkeys->kli2[i] = key_prime[(i + 2) & 7];
+        subkeys->koi1[i] = octeon_rol16(key[(i + 1) & 7], 5);
+        subkeys->koi2[i] = octeon_rol16(key[(i + 5) & 7], 8);
+        subkeys->koi3[i] = octeon_rol16(key[(i + 6) & 7], 13);
+        subkeys->kii1[i] = key_prime[(i + 4) & 7];
+        subkeys->kii2[i] = key_prime[(i + 3) & 7];
+        subkeys->kii3[i] = key_prime[(i + 7) & 7];
+    }
+}
+
+static uint16_t octeon_kasumi_fi(uint16_t in, uint16_t subkey)
+{
+    uint16_t nine = in >> 7;
+    uint16_t seven = in & 0x7f;
+
+    nine = octeon_kasumi_s9[nine] ^ seven;
+    seven = octeon_kasumi_s7[seven] ^ (nine & 0x7f);
+    seven ^= subkey >> 9;
+    nine ^= subkey & 0x1ff;
+    nine = octeon_kasumi_s9[nine] ^ seven;
+    seven = octeon_kasumi_s7[seven] ^ (nine & 0x7f);
+    return (seven << 9) | nine;
+}
+
+static uint32_t octeon_kasumi_fo(uint32_t in, int index,
+                                 const OcteonKasumiSubkeys *subkeys)
+{
+    uint16_t left = in >> 16;
+    uint16_t right = in;
+
+    left ^= subkeys->koi1[index];
+    left = octeon_kasumi_fi(left, subkeys->kii1[index]);
+    left ^= right;
+    right ^= subkeys->koi2[index];
+    right = octeon_kasumi_fi(right, subkeys->kii2[index]);
+    right ^= left;
+    left ^= subkeys->koi3[index];
+    left = octeon_kasumi_fi(left, subkeys->kii3[index]);
+    left ^= right;
+
+    return ((uint32_t)right << 16) | left;
+}
+
+static uint32_t octeon_kasumi_fl(uint32_t in, int index,
+                                 const OcteonKasumiSubkeys *subkeys)
+{
+    uint16_t left = in >> 16;
+    uint16_t right = in;
+    uint16_t a = left & subkeys->kli1[index];
+    uint16_t b;
+
+    right ^= octeon_rol16(a, 1);
+    b = right | subkeys->kli2[index];
+    left ^= octeon_rol16(b, 1);
+    return ((uint32_t)left << 16) | right;
+}
+
+static uint64_t octeon_kasumi_block_encrypt(uint64_t block,
+                                            const uint64_t key_regs[2])
+{
+    OcteonKasumiSubkeys subkeys;
+    uint32_t left = block >> 32;
+    uint32_t right = block;
+
+    octeon_kasumi_key_schedule(key_regs, &subkeys);
+
+    for (int i = 0; i < 8; ) {
+        uint32_t temp = octeon_kasumi_fl(left, i, &subkeys);
+
+        temp = octeon_kasumi_fo(temp, i++, &subkeys);
+        right ^= temp;
+        temp = octeon_kasumi_fo(right, i, &subkeys);
+        temp = octeon_kasumi_fl(temp, i++, &subkeys);
+        left ^= temp;
+    }
+
+    return ((uint64_t)left << 32) | right;
+}
+
+static void octeon_kasumi_crypt_common(MIPSOcteonCryptoState *crypto,
+                                       uint64_t input_reg, bool cbc)
+{
+    const uint64_t key_regs[2] = {
+        crypto->des3_key[0],
+        crypto->des3_key[1],
+    };
+    uint64_t block = input_reg;
+
+    if (cbc) {
+        block ^= crypto->des3_iv;
+    }
+
+    block = octeon_kasumi_block_encrypt(block, key_regs);
+    if (cbc) {
+        crypto->des3_iv = block;
+    }
+    crypto->des3_result = block;
+}
+
+void helper_octeon_cp2_mt_des3_enc_cbc(CPUMIPSState *env, uint64_t value)
+{
+    octeon_3des_crypt_common(&env->octeon_crypto, value, true, true);
+}
+
+void helper_octeon_cp2_mt_kas_enc_cbc(CPUMIPSState *env, uint64_t value)
+{
+    octeon_kasumi_crypt_common(&env->octeon_crypto, value, true);
+}
+
+void helper_octeon_cp2_mt_des3_enc(CPUMIPSState *env, uint64_t value)
+{
+    octeon_3des_crypt_common(&env->octeon_crypto, value, true, false);
+}
+
+void helper_octeon_cp2_mt_kas_enc(CPUMIPSState *env, uint64_t value)
+{
+    octeon_kasumi_crypt_common(&env->octeon_crypto, value, false);
+}
+
+void helper_octeon_cp2_mt_des3_dec_cbc(CPUMIPSState *env, uint64_t value)
+{
+    octeon_3des_crypt_common(&env->octeon_crypto, value, false, true);
+}
+
+void helper_octeon_cp2_mt_des3_dec(CPUMIPSState *env, uint64_t value)
+{
+    octeon_3des_crypt_common(&env->octeon_crypto, value, false, false);
+}
+
 void helper_octeon_cp2_mt_snow3g_start(CPUMIPSState *env, uint64_t value)
 {
     octeon_snow3g_start(&env->octeon_crypto, value);

-- 
2.54.0


