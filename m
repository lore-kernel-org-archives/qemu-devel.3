Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A32CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 19:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQVgQ-0001lG-IG; Fri, 22 May 2026 15:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVgG-0001iY-0D
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:37:12 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVgB-0000YP-SJ
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:37:10 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-484ba8bc89eso5297009b6e.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 12:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779478626; x=1780083426; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=60vDrTtu03Dkv5co10/ZNAS0pVxGb0206vl0fyGgH+0=;
 b=IX5gy2als+PfjzOy/UGKswCzNC6rwGs4ORnOdgwa8si9OcaabndCzXDZwplbm19kkg
 /yAF/stGJMVpQOBpj93nl+jRBmR4MIQ/o/0tU7cRAnpJSwwUojso8bruHvpHIfjh8aNs
 8DMghkp9o9cDLgfbpFQ+7XjVf1c9Q8iyhSK9tdFrRBpIwqFzItr+e+ehLQA4ggSVnc3w
 3tx0SAeDBRttXyTAyRsbWnKFhGtktOSFkQBRec6rdjTfW/Q8pGXxZ948ykGZkoLD3kfO
 46Lqd7Pr8U0YSohdQ1TBuCs8FerUGt5AIiHwbidB2+lieJTnOlS3t5Tiw7deoc+kLpml
 889w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779478626; x=1780083426;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=60vDrTtu03Dkv5co10/ZNAS0pVxGb0206vl0fyGgH+0=;
 b=M2CnUnmqggUoKfZy2OWdfAMxR7Cz5OVSIpQx4cULubtmY6hGaTMVAUAR0+2i8OTpQ7
 PqqBevA66tQLsCYSGIzLnUWKwaM7iJ40dN6tkKXlzGkduF29w7uNydyfKGYHa2+0HkaM
 GkE/AK1bZY7A9WpyIXihCm7IzQUsb45Bqe0OORBL1juf7DJ61ns0Oyzklh85dBkcH8Ki
 FF8nm/mak1KlUtwkKePTX+y45oFWUF2A+a6mL3GVHnmrUgfjlxXtq9nelQcXHLwy7kCv
 nXgjvdcR8yHwGVpMD3jOF5aSnHzMLYFWJl7H8E3DoYFKIO1Cv4osqDuxm6obI7KAaW4Y
 ylRA==
X-Gm-Message-State: AOJu0Yxrcl7Rz0qOcgFJL/64XHx/RHhrsAnt+Kl+3iznrkJX5rsrGt48
 YWWoADN1QtaVhH+2qhglL/+4LRO8uPjM/6UN/KtUM2izx4C8033lTsdi
X-Gm-Gg: Acq92OH9RLZVCIpX0vnuWbt2UQRwynsaN+uwfZLvARt59oqPOK0uSs886sc/UW7a6u6
 j3MXvzXdiYg0RRdk/noOQhjm5p4lCicl+tcasAHVeP8GylcmFGmh5IB7NoQI/6w9xYOfAkU2UkF
 GZvnGgU0gDB5OzlhrD8323BNFB6DVsmYqfAOSbeTmbTdDwnhtva9Sl0dGSH2c6dZ5Ws3Ymq6hFy
 qkbGY2vzcJAhOOm0SRUvs31pmkUpJOQ6kl8wr8ZAiB3OTUIveRIHqF0L3lldFkDrUbhpqBicdJR
 MU05z66qD2NccvVQz/eN25v9K/2R0u2Kt2qRNR7hV4U8Mni+yH1BnNVP6NRjZxNfKcqYHhe3zHQ
 fdEUN8ZkucJpYrfH7cR8ln4cLzTuY8prSOavXguU/jUq1FfNKZO4los7oD80VkrcE4yFy3r3Qqv
 L4JX0ehoqNczv1MuluuaiyoqvEfDvlTHIifsThMC36R+epVsvi3FTyTLKTawDmUdv4LgaRhx+b2
 huBAskinDA2jB8859d81QwDtvKwt3VJ7c+NZqh47MdFiV6I+wxD0jHU3e1UtobPW0zYrdimkysL
 IUs=
X-Received: by 2002:a05:6808:c2f9:b0:47a:ae7:b604 with SMTP id
 5614622812f47-48549edb06fmr2956868b6e.21.1779478626471; 
 Fri, 22 May 2026 12:37:06 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-48554757d5dsm995297b6e.15.2026.05.22.12.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 12:37:05 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 22 May 2026 13:36:46 -0600
Subject: [PATCH v15 15/22] target/mips: decode Octeon COP2 register selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mips-octeon-missing-insns-v2-v15-15-f8731a588dc2@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x231.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


