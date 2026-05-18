Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D834CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqZB-0000Td-1z; Mon, 18 May 2026 01:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqYE-0006vz-77
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:30:06 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY7-0003X1-R3
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:58 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-479d593a0c3so1599780b6e.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082191; x=1779686991; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QcezPWso4Qdwu4OK1T86jH1Q/rQNOvJ7hp2bK2PwYVM=;
 b=tK0a5RP8fhxCLObCZsjSgH64b2okn/0ZPXRCPi2ZoHqXqoe1+zcVO4xRDXpjrfHVTL
 xZ0upxunk0m9BGHcD7wM6EaujIIdeSMdcnagcSE6eFYU5rrsSYliwvp5WW3UT9EcO6lz
 3j2rWZxMX23Yb6jAtlMHKMor6foSqU0S6hqqGpePdE9QaiLHRlC4zprskOb4eNkPwd7a
 cJ73K4ZFOowtT8CFERh6G3GIX29Bc28Oh1qXWV/oKxxnTD2n3TUScppfItlgZqu3Fr4/
 C0j029xQChFeGbstQuHOylbbiY+V2uaJfPwClFF6njW/K6Z3MuB7zItAYVzrxyzct3Qz
 Andw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082191; x=1779686991;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QcezPWso4Qdwu4OK1T86jH1Q/rQNOvJ7hp2bK2PwYVM=;
 b=fjZS/U8dAM6KinH6wH2CNuHbvBjAE5gHjSJ/xi+aN4VBYT+rxsnq8eVaQOpe/wLE7+
 +ZVbP9VhKjetLhaC5y0wFpWFA5w6nPkBdgumd6LoLUF5AzRd8g327Q9eBl9pNMDBqq5F
 jPIAXIvtXfCXvcrzRiBl6tYiL8kjNeHsrUucystPlJdmHrifWND+GtawWKvpMVZxb9na
 ebKlVwvVIxpO8ZP1WJhF9aWOgcqU20rLg4KrROWKSsFNRWs6vYsQx6COtsdKJdQRCEEp
 phwTntr6Jsdt5hQ/+y2Sh1J/teo2g2mUyDaB86h/PnMIord8Tj25bjIhBzNiMzXXRpVj
 xlWw==
X-Gm-Message-State: AOJu0YzyvyfC0IUEXGLK+QH/6li0QtdjN7Rk7aX/1xjHwvl4P4/MRS1D
 zOZ2zJmbVI3LF3sGmOmcc8qT15nJmT81se2C5CnOg9rF6s3RkFQpRs7u
X-Gm-Gg: Acq92OHiu0ngGutaiN4pvRADN+CU9IuvjnxzSctfGaW3rRO0r4xPCRvct00eNpq+e/o
 INhZc0PXK4HFluKm9looKTwjyfwngsRLAa3nuAbxptqpx+TIM4NXhj+sVOsmPUIxnlYH9FBfFV5
 gYAarpGIwIJ1UTXZzG4qTuFJ0ggn7gP7dWW59DJA2coLcbmJeC8f9jQMhLowChVsbwSSlV8WRhk
 2XH7tPJKsiGs3H0J68qjDWg/Y9wIOMEdfOLHiBx/zR0g4B4vt3SP38lcNbrsC+uBlNRFdtzjP0o
 ZWpEdEiO2MZwGXEoVtmQca9oO917S9AGBRuh0H6m3RlDMJ/JkJpWPxAGqD6l0pojrGLvZ1+i3+W
 ls9qXkVcfUhUKvIuy6frLxuHuoDQG1ENOpVAcMMTrfJjds8aXYQ3nNzYsgDR/ndWZZygBHloh87
 OiCAKVz25V4Hokmb2YvubIFgISb6cNuLIReL1AWl6q0c3CsLDIV9b9uA60a4YOPfGtYckSXbv9h
 5aR6UTgBLs9F6R4fJ0/IN1wwJ1GLMFrJDMwTSaDfzYcvMoSBfLTamAluasBJ3j5klXmlzI=
X-Received: by 2002:a05:6808:158c:b0:463:a42c:503a with SMTP id
 5614622812f47-482e46468e3mr8211797b6e.14.1779082191061; 
 Sun, 17 May 2026 22:29:51 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:50 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:23 -0600
Subject: [PATCH v8 26/35] target/mips: add Octeon SMS4 crypto support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-26-206151ee77ec@gmail.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22f.google.com
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

On Octeon, the SMS4 engine is exposed through selectors that alias the
AES register bank. Add the missing selectors and model the shared
RESINP, IV, and key state so the hardware interface matches the
processor behaviour.

Use the in-tree SM4 tables to implement the block operation without
adding a host crypto dependency.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Add selector dispatch updates in octeon_translate.c after moving
    COP2 decode out of translate.c.  (suggested by Philippe
    Mathieu-Daudé)

Changes v5 -> v6:
  - Use RESINP wording for the SMS4 shared selector aliases.
---
 target/mips/cpu.h               |  18 +++++++
 target/mips/tcg/octeon_crypto.c | 109 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 1c552b8134..1a23994c78 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -593,6 +593,20 @@ typedef enum MIPSOcteonCop2Sel {
     OCTEON_COP2_SEL_AES_DEC0 = 0x010e,
     OCTEON_COP2_SEL_AES_KEYLENGTH = 0x0110,
     OCTEON_COP2_SEL_AES_INP0 = 0x0111,
+    /*
+     * SMS4 reuses the AES RESINP, IV, and key banks and only adds
+     * operation selectors for ECB/CBC encrypt/decrypt.
+     */
+    OCTEON_COP2_SEL_SMS4_RESINP0 = OCTEON_COP2_SEL_AES_RESINP0,
+    OCTEON_COP2_SEL_SMS4_RESINP1 = OCTEON_COP2_SEL_AES_RESINP1,
+    OCTEON_COP2_SEL_SMS4_IV0 = OCTEON_COP2_SEL_AES_IV0,
+    OCTEON_COP2_SEL_SMS4_IV1 = OCTEON_COP2_SEL_AES_IV1,
+    OCTEON_COP2_SEL_SMS4_KEY0 = OCTEON_COP2_SEL_AES_KEY0,
+    OCTEON_COP2_SEL_SMS4_KEY1 = OCTEON_COP2_SEL_AES_KEY1,
+    OCTEON_COP2_SEL_SMS4_ENC_CBC0 = OCTEON_COP2_SEL_AES_ENC_CBC0,
+    OCTEON_COP2_SEL_SMS4_ENC0 = OCTEON_COP2_SEL_AES_ENC0,
+    OCTEON_COP2_SEL_SMS4_DEC_CBC0 = OCTEON_COP2_SEL_AES_DEC_CBC0,
+    OCTEON_COP2_SEL_SMS4_DEC0 = OCTEON_COP2_SEL_AES_DEC0,
     OCTEON_COP2_SEL_CRC_POLYNOMIAL = 0x0200,
     OCTEON_COP2_SEL_CRC_IV = 0x0201,
     OCTEON_COP2_SEL_CRC_LEN = 0x0202,
@@ -661,6 +675,10 @@ typedef enum MIPSOcteonCop2Sel {
     OCTEON_COP2_SEL_AES_ENC1 = 0x310b,
     OCTEON_COP2_SEL_AES_DEC_CBC1 = 0x310d,
     OCTEON_COP2_SEL_AES_DEC1 = 0x310f,
+    OCTEON_COP2_SEL_SMS4_ENC_CBC1 = 0x3119,
+    OCTEON_COP2_SEL_SMS4_ENC1 = 0x311b,
+    OCTEON_COP2_SEL_SMS4_DEC_CBC1 = 0x311d,
+    OCTEON_COP2_SEL_SMS4_DEC1 = 0x311f,
     OCTEON_COP2_SEL_HSH_STARTMD5 = 0x4047,
     OCTEON_COP2_SEL_SNOW3G_START = 0x404d,
     OCTEON_COP2_SEL_SNOW3G_MORE = 0x404e,
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 8b3260c4d6..2d2b19ad30 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -12,6 +12,7 @@
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
 #include "crypto/clmul.h"
+#include "crypto/sm4.h"
 #include "qemu/bitops.h"
 #include "qemu/host-utils.h"
 
@@ -745,6 +746,57 @@ static int octeon_aes_key_bits(const MIPSOcteonCryptoState *crypto)
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
+
 static const uint8_t octeon_des_ip[64] = {
     58, 50, 42, 34, 26, 18, 10,  2,
     60, 52, 44, 36, 28, 20, 12,  4,
@@ -1198,6 +1250,47 @@ static void octeon_aes_store_block(uint64_t regs[2], const uint8_t *block)
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
+
 static void octeon_aes_encrypt_common(MIPSOcteonCryptoState *crypto, bool cbc)
 {
     AES_KEY key;
@@ -1614,6 +1707,22 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, uint64_t value,
         crypto->aes_input[1] = data;
         octeon_aes_decrypt_common(crypto, false);
         break;
+    case OCTEON_COP2_SEL_SMS4_ENC_CBC1:
+        crypto->aes_input[1] = data;
+        octeon_sms4_crypt_common(crypto, true, true);
+        break;
+    case OCTEON_COP2_SEL_SMS4_ENC1:
+        crypto->aes_input[1] = data;
+        octeon_sms4_crypt_common(crypto, true, false);
+        break;
+    case OCTEON_COP2_SEL_SMS4_DEC_CBC1:
+        crypto->aes_input[1] = data;
+        octeon_sms4_crypt_common(crypto, false, true);
+        break;
+    case OCTEON_COP2_SEL_SMS4_DEC1:
+        crypto->aes_input[1] = data;
+        octeon_sms4_crypt_common(crypto, false, false);
+        break;
     case OCTEON_COP2_SEL_GFM_XORMUL1: {
         uint64_t in[2] = {
             crypto->gfm_resinp[0] ^ crypto->gfm_xor0,

-- 
2.54.0


