Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0CBCD8CA8
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfCx-000118-G0; Mon, 08 Jun 2026 15:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCm-0000y6-6m
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:13 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCj-0006bT-28
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:11 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7e6f922e49fso3380509a34.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 12:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780945208; x=1781550008; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=99YbXwU+QZjVpPSGzU0gdv9rBjyJynqi/nBLawDCdQk=;
 b=X9nM19lppP/ewfh9zV+iElhCjOjUju41dfRiYqIYiKqNEZ1fv/ZXaWuE7velWxCb3Z
 kYSca6GMQgOpZPtsRRqngSNey8YMT33GYpMIha6LFQkfU20tzKKkyXhetI7LaKhMGBjf
 dZUW7GF7SWY0Ftff2ln2tqshKQjsKqAFznXXyaRDkRywnaAr28yLutGn2lVxi679peY/
 6qt7EWC4tuynDN7Jo4JZscxVkUldKHe+AYkBdpDcXOFFwZcbH+lFFUTtRlOgXx8UJsun
 Fb9Sfm1FncuJ/jOff9dURG5J4ScETC0zkEoxX+rqWB6nnH14LGF42oJCLTPNNlh4DZTJ
 S6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945208; x=1781550008;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=99YbXwU+QZjVpPSGzU0gdv9rBjyJynqi/nBLawDCdQk=;
 b=DN0hlqBXsGmfvg9TgpOoqCTff6B6tYRn9PsoM3ZnoOUor4ehtnt7q1V0G9xBdTgCwU
 22UM8wnqbsVK1Zd+msQbYyM2fzZLN5aTeib3rdFD4RM5/XqFDNC6vErKDjnBPeb1BHpH
 fFmD0M8HRs5XTNGv5huVUAvli9B9nJO6hqGv6nvsAr917RwCFDFAA6IgK0c/T2HvnHAY
 9FvCze7GLFYoOn7UaPUd1QJ59uBNbPK6XU5G3QxnAXlaou8Rk/zr1X42uMFLXZ2UWBoh
 +ZLNUxVX+Us4f+cl8O/Z2koEoQutnJCMTtcIxZpW5lamf2N4jl6eIMceiNQ616vko4Sv
 hFpg==
X-Gm-Message-State: AOJu0YxygRdr3nKNxhxV0HlrbMnmJ7elvNFk4Tujd9f4te589J219zus
 b9kp+AAwl6l3NGPUjA63+SdWEFo24OknZeHWAZtLpDn01xBW54sbtZeWnp+OeR9ydhk=
X-Gm-Gg: Acq92OE79CN0CxhJJTvbmlLO9V4OVIhkizasJxqp9YmYt3HnlhzfAPszq0oTuzeIl1F
 yPxCbFF0P15ySctxPZyZ1k/PCk8+Vj7krWZ7AALIcs4b6pedu2tPeTUdcKjCmL9K6g8Lj4y53qJ
 HYC3nidjaTirFT8ZCgS3ks3A/HVY8/irjdqs32W4GwIbMhJXNRT+uiOPk9luRFT9iOpSystYKF1
 88qgAZM43s+jnf1Jj0XMDTOCqqrjskW9xnZ1hdmP73ecAP26iACCvR5gIRDjGS34qAiHt0TKFTu
 WBsrpaxZBuQl+TXE1AQE+OyyTI+EvmcP0VHVvoxT6vZLsxQVVkCCOQautdPpUhZa4IUoXZUhDfC
 q0nth6WjlH32HZAyPgxrwTaI6Z+CiNIVQs5jkKyNZdli1vd4afwfYBhBfmiHH5/6jHrSdNbk/ij
 tlA74hUviZnmqrDBPWLAJrbGg83K6bEcaNQrKHSy4L0jCEL7Lkr1Gc+bFTZOcsQ3lRFjYYsYjOO
 NfyVocv0Q5WwLXEKBc/37bw1Pc0cQbjRBqQPPQozDCAMoEVWw6yAfUsk6DoO50NgJrdDLIBRvTA
 DM1cAlSbvaj4rkGG4b/ltDilp7X8hxwzPODrii25e+k=
X-Received: by 2002:a05:6830:398b:b0:7dc:de56:d75a with SMTP id
 46e09a7af769-7e70c5ac213mr10587099a34.4.1780945207842; 
 Mon, 08 Jun 2026 12:00:07 -0700 (PDT)
Received: from mac.localdomain (97-118-5-210.hlrn.qwest.net. [97.118.5.210])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e75db138sm12397777a34.11.2026.06.08.12.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:00:07 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 08 Jun 2026 12:59:28 -0600
Subject: [PATCH v16 03/21] target/mips: add Octeon CRC COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-mips-octeon-missing-insns-v2-v16-3-daef7a0d8b04@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x334.google.com
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

Add helper support for the Octeon COP2 CRC register interface. This
covers normal and reflected CRC state handling, byte/halfword/word/
doubleword/variable-width update selectors, and the reflected IV readback
operation.

Register moves that can be represented as direct TCG loads/stores do not
need helpers. Add only the side-effecting CRC helper implementation here.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
Changes v9 -> v10:
  - Mask variable-length CRC writes to CRCLEN<3:0>.
  - Add Richard's Reviewed-by tag.

Changes v8 -> v9:
  - Split CRC selector operations into their own COP2 helper patch.
  - Expose per-operation helpers instead of a generic selector helper.
  - Add matching helper.h declarations with the helper implementation.
---
 target/mips/helper.h            |  14 +++++
 target/mips/tcg/octeon_crypto.c | 131 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index e2b83a1d19..e802f50fd6 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -25,6 +25,20 @@ DEF_HELPER_3(crc32, tl, tl, tl, i32)
 DEF_HELPER_3(crc32c, tl, tl, tl, i32)
 DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 
+/* Octeon COP2 selector operation helpers. */
+DEF_HELPER_1(octeon_cp2_mf_crc_iv_reflect, i64, env)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_iv_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_byte, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_half, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_word, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_byte_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_half_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_word_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_dword, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_var, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_dword_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_var_reflect, void, env, i64)
+
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
 DEF_HELPER_4(swm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index df5b0449ae..811f36f46a 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -14,3 +14,134 @@
 #include "crypto/sm4.h"
 #include "qemu/bitops.h"
 #include "qemu/host-utils.h"
+
+static inline uint32_t octeon_crc_reflect32_by_byte(uint32_t v)
+{
+    return bswap32(revbit32(v));
+}
+
+static uint32_t octeon_crc_state_reflect(const MIPSOcteonCryptoState *crypto)
+{
+    return octeon_crc_reflect32_by_byte(crypto->crc_iv);
+}
+
+static void octeon_crc_set_state_reflect(MIPSOcteonCryptoState *crypto,
+                                         uint32_t state)
+{
+    crypto->crc_iv = octeon_crc_reflect32_by_byte(state);
+}
+
+static void octeon_crc_update_normal(MIPSOcteonCryptoState *crypto,
+                                     uint64_t value, unsigned int bytes)
+{
+    uint32_t crc = crypto->crc_iv;
+    uint32_t poly = crypto->crc_poly;
+
+    for (unsigned int i = 0; i < bytes; i++) {
+        uint8_t byte = value >> ((bytes - 1 - i) * 8);
+
+        crc ^= (uint32_t)byte << 24;
+        for (int bit = 0; bit < 8; bit++) {
+            if (crc & 0x80000000U) {
+                crc = (crc << 1) ^ poly;
+            } else {
+                crc <<= 1;
+            }
+        }
+    }
+
+    crypto->crc_iv = crc;
+}
+
+static void octeon_crc_update_reflect(MIPSOcteonCryptoState *crypto,
+                                      uint64_t value, unsigned int bytes)
+{
+    uint32_t crc = octeon_crc_state_reflect(crypto);
+    uint32_t poly = bswap32(crypto->crc_poly);
+
+    for (unsigned int i = 0; i < bytes; i++) {
+        uint8_t byte = value >> ((bytes - 1 - i) * 8);
+
+        crc ^= byte;
+        for (int bit = 0; bit < 8; bit++) {
+            if (crc & 1U) {
+                crc = (crc >> 1) ^ poly;
+            } else {
+                crc >>= 1;
+            }
+        }
+    }
+
+    octeon_crc_set_state_reflect(crypto, crc);
+}
+
+uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
+{
+    return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
+}
+
+void helper_octeon_cp2_mt_crc_write_iv_reflect(CPUMIPSState *env,
+                                               uint64_t value)
+{
+    env->octeon_crypto.crc_iv =
+        octeon_crc_reflect32_by_byte((uint32_t)value);
+}
+
+void helper_octeon_cp2_mt_crc_write_byte(CPUMIPSState *env, uint64_t value)
+{
+    octeon_crc_update_normal(&env->octeon_crypto, value, 1);
+}
+
+void helper_octeon_cp2_mt_crc_write_half(CPUMIPSState *env, uint64_t value)
+{
+    octeon_crc_update_normal(&env->octeon_crypto, value, 2);
+}
+
+void helper_octeon_cp2_mt_crc_write_word(CPUMIPSState *env, uint64_t value)
+{
+    octeon_crc_update_normal(&env->octeon_crypto, value, 4);
+}
+
+void helper_octeon_cp2_mt_crc_write_dword(CPUMIPSState *env, uint64_t value)
+{
+    octeon_crc_update_normal(&env->octeon_crypto, value, 8);
+}
+
+void helper_octeon_cp2_mt_crc_write_var(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    octeon_crc_update_normal(crypto, value, MIN(8U, crypto->crc_len & 0xf));
+}
+
+void helper_octeon_cp2_mt_crc_write_byte_reflect(CPUMIPSState *env,
+                                                 uint64_t value)
+{
+    octeon_crc_update_reflect(&env->octeon_crypto, value, 1);
+}
+
+void helper_octeon_cp2_mt_crc_write_half_reflect(CPUMIPSState *env,
+                                                 uint64_t value)
+{
+    octeon_crc_update_reflect(&env->octeon_crypto, value, 2);
+}
+
+void helper_octeon_cp2_mt_crc_write_word_reflect(CPUMIPSState *env,
+                                                 uint64_t value)
+{
+    octeon_crc_update_reflect(&env->octeon_crypto, value, 4);
+}
+
+void helper_octeon_cp2_mt_crc_write_dword_reflect(CPUMIPSState *env,
+                                                  uint64_t value)
+{
+    octeon_crc_update_reflect(&env->octeon_crypto, value, 8);
+}
+
+void helper_octeon_cp2_mt_crc_write_var_reflect(CPUMIPSState *env,
+                                                uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    octeon_crc_update_reflect(crypto, value, MIN(8U, crypto->crc_len & 0xf));
+}

-- 
2.54.0


