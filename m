Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18D2CD4F5B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 05:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQIJL-0002xL-4R; Fri, 22 May 2026 01:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJH-0002hG-Pn
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:35 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJF-00029n-7G
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:35 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-48544e7ba58so669189b6e.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 22:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779427232; x=1780032032; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YQl/+OEhwF4NoyNWyxodfcJAzFD2ZvuV+faGp0XUU/Q=;
 b=QTX24Ot8TFVZnDsayRIhbgPEiNX5uDMiVMOL7jUT5yjqTzpxcuE6YFQloi6oj3Dvw7
 rOBzwzZ+pblplX65Lj3XbM3sdZ6WsLWXzcFdtSQz9AFfCe6kjn91uzaV/YJkkC1q4N++
 gn30SQnpmZYJeVGxlIsHRD4P5fN3YPSCICIqZV9zfrnFJN2pVkAZkTUmXtUpQ7YRYInS
 gz01/TfFVZaVaxTFGQfyFJLFsdOOviD+c0979KKG0vgC3i5TM8sMg6WRh35NorImsOrN
 fIZQ8GOM7lYSfJBhKjYcmXj3SplMUtVE5c8EhareHj93g57w5kRmbLmmi0IyMAWODu+H
 kkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779427232; x=1780032032;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YQl/+OEhwF4NoyNWyxodfcJAzFD2ZvuV+faGp0XUU/Q=;
 b=a6wC32lcDVV4eyNzKLVcBModY5v1MMpp46G7u8nGPyF2qE0dCwWTk170J2ym02vOS6
 lsFXcIGTy07BldQXgdFRJfh9PLRj/u1Sg07C4krDo+SNgs2nk6laOIOXLZ/Is8v2NkGk
 3IY1cmPkTmLrTwXkVXtrl+E9sfDjAyhJEKMh8xlp2Bd3UmE+LoX3UYg5KoyyoQq7U3qw
 A/3Ip/aMNt11cAhSbMWwLcTJsRTvh1bgNNM2/oom6ZqX1gJHSaGPdYxvbCB1bcccg/OW
 A2tjjmRhE+isFdYoemo86MMAeq+sY08HD378TvFKij3OIDlPzsAhvJK2avt9NZ2lEuyt
 nJnQ==
X-Gm-Message-State: AOJu0Yw5X39vRd/Bl3YYWLkOCmEbDuYUlK0yttz4x1Ohi4+Ej6CNWAXY
 gvrnQ0mP8iw8viPSm5KExX6G/a1bbUS9gPs5Tg9c+DvxDdJ0WO4r2mAn
X-Gm-Gg: Acq92OEVoGYLyhS06K0FnFCdQyceSKXRQoF7i8lQJQJiCu7E2LjVh+Z3He/U80GBiP1
 wABnHeZFiVjZZm393r2pMQXh88hk37Z9T/0y7NxITGU2VEHeSPyvD3W92IeSKP3DkdvPOeJxi/D
 5jOY0qaMtOH/Z7WBaowOyPSzQ6RWQ6Nf4RqIRLLcCQHvY4+Ny7AA0puCUodWMsCCLGWoRXMjtrG
 vZU0pO2fCS+6yLJ6jChsqYPSrQphravdi1hmZ0c5S0sLtvw7thkzIj/mC7lxanK5o7gA5Jmt2YY
 j40wgjgOl+daoxTeepX7Y/Y/Lo0unk4pqd6eYdu7E/kQ7Y8PLSupLL1GY8s90omAtPKToaElVXi
 8RuNQABtcuxvuY2kTEITQr/my7EUg8uvwf268S8iAp7FuIiIhz2/rXGfo3JHpG+Z1oT1NnkVbLk
 R5rs05BSIbh/HSf/lPy/u/+9CjnSXKCdQgDKHVP0sdlMRSRku2qFHqh48KW5yrThYvffzu0mLYn
 gfPVHr0F8z/Gfk5T1L7PqQScXnpczmL6lRPczuT9WxjcT6sZMoQLT2lDkpbYgzl93nN6M9qp+Cq
 peE=
X-Received: by 2002:a05:6808:1b2a:b0:479:c81f:8e18 with SMTP id
 5614622812f47-48549d6daa6mr1273512b6e.3.1779427231961; 
 Thu, 21 May 2026 22:20:31 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4855476ab77sm59690b6e.17.2026.05.21.22.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 22:20:31 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 23:19:57 -0600
Subject: [PATCH v14 15/22] target/mips: decode Octeon COP2 register selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v14-15-fbf08e164830@gmail.com>
References: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
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

Add explicit decodetree entries and translator bindings for Octeon
DMFC2/DMTC2 selectors that are simple COP2 register transfers.

Emit direct TCG loads and stores for register moves. Use signed 32-bit
loads for 32-bit DMFC2 readback and mask narrow writable fields such as
AESKEYLEN and CRCLEN on DMTC2.

Keep operation selectors with side effects in later functional decode
patches.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v13 -> v14:
  - Add missing HSH DAT readback selectors.
  - Implement HSH DAT/IV selector transfers as paired low-32 architectural
    word moves using tcg_gen_concat32_i64().
  - Move the CP2_Undef fallback into this selector patch.
  - Remove the redundant AES RESINP translator path.
  - Add HSH DAT readback smoke coverage.

Changes v10 -> v13:
  - Keep simple register moves in their own selector patch.
  - Use final KAS result naming and final CRC register selector names.
  - Mask AESKEYLEN and CRCLEN direct writes.
---
 target/mips/tcg/octeon.decode                 |  80 ++++++++++
 target/mips/tcg/octeon_translate.c            | 210 ++++++++++++++++++++++++++
 tests/tcg/mips/user/isa/octeon/octeon-insns.c |  89 +++++++++++
 3 files changed, 379 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 1e44c588dd..09fbc6c1e3 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -97,3 +97,83 @@ LBUX         011111 ..... ..... ..... 00110 001010 @lx
 LWUX         011111 ..... ..... ..... 10000 001010 @lx
 LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
+
+# Selector-driven DMFC2/DMTC2 interfaces for Octeon COP2 engines.
+&cp2          rt
+{
+  [
+    CVM_MF_HSH_IV0                       010010 00001 rt:5 0000 0000 0100 1000 &cp2
+    CVM_MF_HSH_IV1                       010010 00001 rt:5 0000 0000 0100 1001 &cp2
+    CVM_MF_HSH_IV2                       010010 00001 rt:5 0000 0000 0100 1010 &cp2
+    CVM_MF_HSH_IV3                       010010 00001 rt:5 0000 0000 0100 1011 &cp2
+    CVM_MF_HSH_DAT0                      010010 00001 rt:5 0000 0000 0100 0000 &cp2
+    CVM_MF_HSH_DAT1                      010010 00001 rt:5 0000 0000 0100 0001 &cp2
+    CVM_MF_HSH_DAT2                      010010 00001 rt:5 0000 0000 0100 0010 &cp2
+    CVM_MF_HSH_DAT3                      010010 00001 rt:5 0000 0000 0100 0011 &cp2
+    CVM_MF_HSH_DAT4                      010010 00001 rt:5 0000 0000 0100 0100 &cp2
+    CVM_MF_HSH_DAT5                      010010 00001 rt:5 0000 0000 0100 0101 &cp2
+    CVM_MF_HSH_DAT6                      010010 00001 rt:5 0000 0000 0100 0110 &cp2
+    CVM_MF_3DES_KEY0                     010010 00001 rt:5 0000 0000 1000 0000 &cp2
+    CVM_MF_3DES_KEY1                     010010 00001 rt:5 0000 0000 1000 0001 &cp2
+    CVM_MF_3DES_KEY2                     010010 00001 rt:5 0000 0000 1000 0010 &cp2
+    CVM_MF_3DES_IV                       010010 00001 rt:5 0000 0000 1000 0100 &cp2
+    CVM_MF_3DES_RESULT                   010010 00001 rt:5 0000 0000 1000 1000 &cp2
+    CVM_MF_KAS_RESULT                    010010 00001 rt:5 0000 0000 1001 1000 &cp2
+    CVM_MF_AES_RESINP0                   010010 00001 rt:5 0000 0001 0000 0000 &cp2
+    CVM_MF_AES_RESINP1                   010010 00001 rt:5 0000 0001 0000 0001 &cp2
+    CVM_MF_AES_IV0                       010010 00001 rt:5 0000 0001 0000 0010 &cp2
+    CVM_MF_AES_IV1                       010010 00001 rt:5 0000 0001 0000 0011 &cp2
+    CVM_MF_AES_KEY0                      010010 00001 rt:5 0000 0001 0000 0100 &cp2
+    CVM_MF_AES_KEY1                      010010 00001 rt:5 0000 0001 0000 0101 &cp2
+    CVM_MF_AES_KEY2                      010010 00001 rt:5 0000 0001 0000 0110 &cp2
+    CVM_MF_AES_KEY3                      010010 00001 rt:5 0000 0001 0000 0111 &cp2
+    CVM_MF_AES_KEYLENGTH                 010010 00001 rt:5 0000 0001 0001 0000 &cp2
+    CVM_MF_AES_INP0                      010010 00001 rt:5 0000 0001 0001 0001 &cp2
+    CVM_MF_CRC_POLYNOMIAL                010010 00001 rt:5 0000 0010 0000 0000 &cp2
+    CVM_MF_CRC_IV                        010010 00001 rt:5 0000 0010 0000 0001 &cp2
+    CVM_MF_CRC_LEN                       010010 00001 rt:5 0000 0010 0000 0010 &cp2
+    CVM_MF_GFM_MUL0                      010010 00001 rt:5 0000 0010 0101 1000 &cp2
+    CVM_MF_GFM_MUL1                      010010 00001 rt:5 0000 0010 0101 1001 &cp2
+    CVM_MF_GFM_RESINP0                   010010 00001 rt:5 0000 0010 0101 1010 &cp2
+    CVM_MF_GFM_RESINP1                   010010 00001 rt:5 0000 0010 0101 1011 &cp2
+    CVM_MF_GFM_POLY                      010010 00001 rt:5 0000 0010 0101 1110 &cp2
+    CVM_MT_HSH_DAT0                      010010 00101 rt:5 0000 0000 0100 0000 &cp2
+    CVM_MT_HSH_DAT1                      010010 00101 rt:5 0000 0000 0100 0001 &cp2
+    CVM_MT_HSH_DAT2                      010010 00101 rt:5 0000 0000 0100 0010 &cp2
+    CVM_MT_HSH_DAT3                      010010 00101 rt:5 0000 0000 0100 0011 &cp2
+    CVM_MT_HSH_DAT4                      010010 00101 rt:5 0000 0000 0100 0100 &cp2
+    CVM_MT_HSH_DAT5                      010010 00101 rt:5 0000 0000 0100 0101 &cp2
+    CVM_MT_HSH_DAT6                      010010 00101 rt:5 0000 0000 0100 0110 &cp2
+    CVM_MT_HSH_IV0                       010010 00101 rt:5 0000 0000 0100 1000 &cp2
+    CVM_MT_HSH_IV1                       010010 00101 rt:5 0000 0000 0100 1001 &cp2
+    CVM_MT_HSH_IV2                       010010 00101 rt:5 0000 0000 0100 1010 &cp2
+    CVM_MT_HSH_IV3                       010010 00101 rt:5 0000 0000 0100 1011 &cp2
+    CVM_MT_3DES_KEY0                     010010 00101 rt:5 0000 0000 1000 0000 &cp2
+    CVM_MT_3DES_KEY1                     010010 00101 rt:5 0000 0000 1000 0001 &cp2
+    CVM_MT_3DES_KEY2                     010010 00101 rt:5 0000 0000 1000 0010 &cp2
+    CVM_MT_3DES_IV                       010010 00101 rt:5 0000 0000 1000 0100 &cp2
+    CVM_MT_3DES_RESULT                   010010 00101 rt:5 0000 0000 1001 1000 &cp2
+    CVM_MT_AES_RESINP0                   010010 00101 rt:5 0000 0001 0000 0000 &cp2
+    CVM_MT_AES_RESINP1                   010010 00101 rt:5 0000 0001 0000 0001 &cp2
+    CVM_MT_AES_IV0                       010010 00101 rt:5 0000 0001 0000 0010 &cp2
+    CVM_MT_AES_IV1                       010010 00101 rt:5 0000 0001 0000 0011 &cp2
+    CVM_MT_AES_KEY0                      010010 00101 rt:5 0000 0001 0000 0100 &cp2
+    CVM_MT_AES_KEY1                      010010 00101 rt:5 0000 0001 0000 0101 &cp2
+    CVM_MT_AES_KEY2                      010010 00101 rt:5 0000 0001 0000 0110 &cp2
+    CVM_MT_AES_KEY3                      010010 00101 rt:5 0000 0001 0000 0111 &cp2
+    CVM_MT_AES_ENC_CBC0                  010010 00101 rt:5 0000 0001 0000 1000 &cp2
+    CVM_MT_AES_ENC0                      010010 00101 rt:5 0000 0001 0000 1010 &cp2
+    CVM_MT_AES_DEC_CBC0                  010010 00101 rt:5 0000 0001 0000 1100 &cp2
+    CVM_MT_AES_DEC0                      010010 00101 rt:5 0000 0001 0000 1110 &cp2
+    CVM_MT_AES_KEYLENGTH                 010010 00101 rt:5 0000 0001 0001 0000 &cp2
+    CVM_MT_CRC_IV                        010010 00101 rt:5 0000 0010 0000 0001 &cp2
+    CVM_MT_GFM_MUL0                      010010 00101 rt:5 0000 0010 0101 1000 &cp2
+    CVM_MT_GFM_MUL1                      010010 00101 rt:5 0000 0010 0101 1001 &cp2
+    CVM_MT_GFM_RESINP0                   010010 00101 rt:5 0000 0010 0101 1010 &cp2
+    CVM_MT_GFM_RESINP1                   010010 00101 rt:5 0000 0010 0101 1011 &cp2
+    CVM_MT_GFM_POLY                      010010 00101 rt:5 0000 0010 0101 1110 &cp2
+    CVM_MT_CRC_LEN                       010010 00101 rt:5 0001 0010 0000 0010 &cp2
+    CVM_MT_CRC_POLYNOMIAL                010010 00101 rt:5 0100 0010 0000 0000 &cp2
+  ]
+  CP2_Undef                              010010 ----- ----- ---- ---- ---- ----
+}
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index b0af2f4838..b33252dd1f 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -13,6 +13,216 @@
 /* Include the auto-generated decoder.  */
 #include "decode-octeon.c.inc"
 
+#define OCTEON_CRYPTO_OFFSET(FIELD) \
+    offsetof(CPUMIPSState, octeon_crypto.FIELD)
+
+#define CP2_MF_I64(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mf_i64, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MF_S32(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mf_s32, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MF_U16(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mf_u16, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MF_U8(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mf_u8, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MF_HSH_PAIR(NAME, FIELD, INDEX) \
+    TRANS(NAME, trans_octeon_cp2_mf_hsh_pair, \
+          OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX)]), \
+          OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX) + 1]))
+#define CP2_MT_I64(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mt_i64, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MT_U32(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mt_u32, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MT_U16(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mt_u16, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MT_U8_MASKED(NAME, FIELD, MASK) \
+    TRANS(NAME, trans_octeon_cp2_mt_u8_masked, \
+          OCTEON_CRYPTO_OFFSET(FIELD), MASK)
+#define CP2_MT_HSH_PAIR(NAME, FIELD, INDEX) \
+    TRANS(NAME, trans_octeon_cp2_mt_hsh_pair, \
+          OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX)]), \
+          OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX) + 1]))
+
+#define OCTEON_LO32_OFFSET (HOST_BIG_ENDIAN ? 4 : 0)
+
+static bool trans_CP2_Undef(DisasContext *ctx, arg_CP2_Undef *a)
+{
+    generate_exception_err(ctx, EXCP_CpU, 2);
+    return true;
+}
+
+static bool trans_octeon_cp2_mf_i64(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    tcg_gen_ld_i64(value, tcg_env, offset);
+    gen_store_gpr(value, a->rt);
+    return true;
+}
+
+static bool trans_octeon_cp2_mf_s32(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    tcg_gen_ld32s_i64(value, tcg_env, offset);
+    gen_store_gpr(value, a->rt);
+    return true;
+}
+
+static bool trans_octeon_cp2_mf_u16(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    tcg_gen_ld16u_i64(value, tcg_env, offset);
+    gen_store_gpr(value, a->rt);
+    return true;
+}
+
+static bool trans_octeon_cp2_mf_u8(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    tcg_gen_ld8u_i64(value, tcg_env, offset);
+    gen_store_gpr(value, a->rt);
+    return true;
+}
+
+static bool trans_octeon_cp2_mf_hsh_pair(DisasContext *ctx, arg_cp2 *a,
+                                         int hi_offset, int lo_offset)
+{
+    TCGv_i64 hi = tcg_temp_new_i64();
+    TCGv_i64 lo = tcg_temp_new_i64();
+
+    tcg_gen_ld_i64(hi, tcg_env, hi_offset);
+    tcg_gen_ld_i64(lo, tcg_env, lo_offset);
+    tcg_gen_concat32_i64(lo, lo, hi);
+    gen_store_gpr(lo, a->rt);
+    return true;
+}
+
+static bool trans_octeon_cp2_mt_i64(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    tcg_gen_st_i64(value, tcg_env, offset);
+    return true;
+}
+
+static bool trans_octeon_cp2_mt_u32(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    tcg_gen_st32_i64(value, tcg_env, offset);
+    return true;
+}
+
+static bool trans_octeon_cp2_mt_u16(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    tcg_gen_st16_i64(value, tcg_env, offset);
+    return true;
+}
+
+static bool trans_octeon_cp2_mt_u8_masked(DisasContext *ctx, arg_cp2 *a,
+                                          int offset, uint8_t mask)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    tcg_gen_andi_i64(value, value, mask);
+    tcg_gen_st8_i64(value, tcg_env, offset);
+    return true;
+}
+
+static bool trans_octeon_cp2_mt_hsh_pair(DisasContext *ctx, arg_cp2 *a,
+                                         int hi_offset, int lo_offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    tcg_gen_st32_i64(value, tcg_env, lo_offset + OCTEON_LO32_OFFSET);
+    tcg_gen_shri_i64(value, value, 32);
+    tcg_gen_st32_i64(value, tcg_env, hi_offset + OCTEON_LO32_OFFSET);
+    return true;
+}
+
+CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT0, hsh_dat, 0);
+CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT1, hsh_dat, 1);
+CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT2, hsh_dat, 2);
+CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT3, hsh_dat, 3);
+CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT4, hsh_dat, 4);
+CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT5, hsh_dat, 5);
+CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT6, hsh_dat, 6);
+CP2_MF_HSH_PAIR(CVM_MF_HSH_IV0, hsh_iv, 0);
+CP2_MF_HSH_PAIR(CVM_MF_HSH_IV1, hsh_iv, 1);
+CP2_MF_HSH_PAIR(CVM_MF_HSH_IV2, hsh_iv, 2);
+CP2_MF_HSH_PAIR(CVM_MF_HSH_IV3, hsh_iv, 3);
+CP2_MF_I64(CVM_MF_3DES_KEY0, des3_key[0]);
+CP2_MF_I64(CVM_MF_3DES_KEY1, des3_key[1]);
+CP2_MF_I64(CVM_MF_3DES_KEY2, des3_key[2]);
+CP2_MF_I64(CVM_MF_3DES_IV, des3_iv);
+CP2_MF_I64(CVM_MF_3DES_RESULT, des3_result);
+CP2_MF_I64(CVM_MF_KAS_RESULT, des3_result);
+CP2_MF_I64(CVM_MF_AES_RESINP0, aes_resinp[0]);
+CP2_MF_I64(CVM_MF_AES_RESINP1, aes_resinp[1]);
+CP2_MF_I64(CVM_MF_AES_IV0, aes_iv[0]);
+CP2_MF_I64(CVM_MF_AES_IV1, aes_iv[1]);
+CP2_MF_I64(CVM_MF_AES_KEY0, aes_key[0]);
+CP2_MF_I64(CVM_MF_AES_KEY1, aes_key[1]);
+CP2_MF_I64(CVM_MF_AES_KEY2, aes_key[2]);
+CP2_MF_I64(CVM_MF_AES_KEY3, aes_key[3]);
+CP2_MF_U8(CVM_MF_AES_KEYLENGTH, aes_keylen);
+CP2_MF_I64(CVM_MF_AES_INP0, aes_resinp[0]);
+CP2_MF_S32(CVM_MF_CRC_POLYNOMIAL, crc_poly);
+CP2_MF_S32(CVM_MF_CRC_IV, crc_iv);
+CP2_MF_U8(CVM_MF_CRC_LEN, crc_len);
+CP2_MF_I64(CVM_MF_GFM_MUL0, gfm_mul[0]);
+CP2_MF_I64(CVM_MF_GFM_MUL1, gfm_mul[1]);
+CP2_MF_I64(CVM_MF_GFM_RESINP0, gfm_resinp[0]);
+CP2_MF_I64(CVM_MF_GFM_RESINP1, gfm_resinp[1]);
+CP2_MF_U16(CVM_MF_GFM_POLY, gfm_poly);
+
+CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT0, hsh_dat, 0);
+CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT1, hsh_dat, 1);
+CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT2, hsh_dat, 2);
+CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT3, hsh_dat, 3);
+CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT4, hsh_dat, 4);
+CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT5, hsh_dat, 5);
+CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT6, hsh_dat, 6);
+CP2_MT_HSH_PAIR(CVM_MT_HSH_IV0, hsh_iv, 0);
+CP2_MT_HSH_PAIR(CVM_MT_HSH_IV1, hsh_iv, 1);
+CP2_MT_HSH_PAIR(CVM_MT_HSH_IV2, hsh_iv, 2);
+CP2_MT_HSH_PAIR(CVM_MT_HSH_IV3, hsh_iv, 3);
+CP2_MT_I64(CVM_MT_3DES_KEY0, des3_key[0]);
+CP2_MT_I64(CVM_MT_3DES_KEY1, des3_key[1]);
+CP2_MT_I64(CVM_MT_3DES_KEY2, des3_key[2]);
+CP2_MT_I64(CVM_MT_3DES_IV, des3_iv);
+CP2_MT_I64(CVM_MT_3DES_RESULT, des3_result);
+CP2_MT_I64(CVM_MT_AES_RESINP0, aes_resinp[0]);
+CP2_MT_I64(CVM_MT_AES_RESINP1, aes_resinp[1]);
+CP2_MT_I64(CVM_MT_AES_IV0, aes_iv[0]);
+CP2_MT_I64(CVM_MT_AES_IV1, aes_iv[1]);
+CP2_MT_I64(CVM_MT_AES_KEY0, aes_key[0]);
+CP2_MT_I64(CVM_MT_AES_KEY1, aes_key[1]);
+CP2_MT_I64(CVM_MT_AES_KEY2, aes_key[2]);
+CP2_MT_I64(CVM_MT_AES_KEY3, aes_key[3]);
+CP2_MT_I64(CVM_MT_AES_ENC_CBC0, aes_resinp[0]);
+CP2_MT_I64(CVM_MT_AES_ENC0, aes_resinp[0]);
+CP2_MT_I64(CVM_MT_AES_DEC_CBC0, aes_resinp[0]);
+CP2_MT_I64(CVM_MT_AES_DEC0, aes_resinp[0]);
+CP2_MT_U8_MASKED(CVM_MT_AES_KEYLENGTH, aes_keylen, 3);
+CP2_MT_U32(CVM_MT_CRC_IV, crc_iv);
+CP2_MT_I64(CVM_MT_GFM_MUL0, gfm_mul[0]);
+CP2_MT_I64(CVM_MT_GFM_MUL1, gfm_mul[1]);
+CP2_MT_I64(CVM_MT_GFM_RESINP0, gfm_resinp[0]);
+CP2_MT_I64(CVM_MT_GFM_RESINP1, gfm_resinp[1]);
+CP2_MT_U16(CVM_MT_GFM_POLY, gfm_poly);
+CP2_MT_U8_MASKED(CVM_MT_CRC_LEN, crc_len, 0xf);
+CP2_MT_U32(CVM_MT_CRC_POLYNOMIAL, crc_poly);
+
 static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 {
     TCGv_i64 p;
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index 9153e37e9e..7a7445c40a 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -186,6 +186,86 @@ static uint64_t octeon_mtp0_zeroes_p1(void)
     return rd;
 }
 
+static uint64_t octeon_cop2_key0_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80104\n\t" /* dmtc2 $8, AES_KEY0 selector */
+        ".word 0x482a0104\n\t" /* dmfc2 $10, AES_KEY0 selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_key2_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80106\n\t" /* dmtc2 $8, AES_KEY2 selector */
+        ".word 0x482a0106\n\t" /* dmfc2 $10, AES_KEY2 selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_key3_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80107\n\t" /* dmtc2 $8, AES_KEY3 selector */
+        ".word 0x482a0107\n\t" /* dmfc2 $10, AES_KEY3 selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_keylength_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80110\n\t" /* dmtc2 $8, AES_KEYLENGTH selector */
+        ".word 0x482a0110\n\t" /* dmfc2 $10, AES_KEYLENGTH selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_hsh_dat0_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80040\n\t" /* dmtc2 $8, HSH_DAT0 selector */
+        ".word 0x482a0040\n\t" /* dmfc2 $10, HSH_DAT0 selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
 int main(void)
 {
     assert(octeon_baddu(0x123, 0x0f0) == 0x13);
@@ -199,6 +279,15 @@ int main(void)
     assert(octeon_vmm0(5, 13, 7, 11) == 59);
     assert(octeon_vmm0_zeroes_mpl1() == 0);
     assert(octeon_mtp0_zeroes_p1() == 0);
+    assert(octeon_cop2_key0_readback(0x1122334455667788ULL) ==
+           0x1122334455667788ULL);
+    assert(octeon_cop2_key2_readback(0x8877665544332211ULL) ==
+           0x8877665544332211ULL);
+    assert(octeon_cop2_key3_readback(0x0102030405060708ULL) ==
+           0x0102030405060708ULL);
+    assert(octeon_cop2_keylength_readback(0xa5) == 1);
+    assert(octeon_cop2_hsh_dat0_readback(0x0102030405060708ULL) ==
+           0x0102030405060708ULL);
 
     return 0;
 }

-- 
2.54.0


