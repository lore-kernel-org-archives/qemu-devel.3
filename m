Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5C4CD8CA8
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfCy-00012H-Kg; Mon, 08 Jun 2026 15:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCq-0000z9-S4
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:18 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCn-0006dJ-T8
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:16 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-43cce34c881so3622932fac.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 12:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780945211; x=1781550011; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KwEzXgen8Gnp7u/7KMDnkud2zgJHwWnpe+PU5S+vNIo=;
 b=kdDYXeMBaBciBLYPzdYU0JFyElR7FZAlxfPhk1Xph2vFZOeeFIMFSCEhPWkARnbF33
 fVN9Dzku2J+Mq5geml2fMeb40fRmAdVKWeZAua09TaqpIzj0KTJQYC+3hbx5ucOY8EfX
 LpgIEZNifihsGAZKWGOLTXNEGuDRzHNfowYVCgqDXn0V8xeodjTfJ817hmZc8OQxwzhP
 PmZ1NB92ebGgVrPv408ugRfYOcnNKmtu/9A3a7Gs2+afq/N6XSBU0vu9S5c8lUL0TIBm
 TVFcJwHxgMCufWltEjPUB8U7DvVzdEXZ+d2QGpmmws05vnsB3lxkold+a8Y1QAiGA8fZ
 VSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945211; x=1781550011;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KwEzXgen8Gnp7u/7KMDnkud2zgJHwWnpe+PU5S+vNIo=;
 b=M/rOsu8C1LcowfiFiCcqX5royxE3iAEZGDMyR13OQA/ccu09u1yKvZTv61bGgTzOkR
 O7KNYFLEwcdv9htUL9tuutEN3r0mNqJzNnKT/cBAVDRfrirXzNxoHOJyd83MWUXQGpsT
 743fCW+rld7CRH9CEL5nRGjknitLc527blRXoEy20RdeQpLusEGNqpg1ir+f3ZpjHhCY
 Hg84BGrX7Xp5Costv63JEwAg35AbrZ9AzCVUyqVYw6f3052bHDvC6VjB2pJeJZgVJpv4
 tUbzfIDa7ze/ontzjrtFGmpsi05n6KPpV+hGfZ4EEKdeiJS8b1ZC34I5BKRCy6YMg/sT
 1Bgw==
X-Gm-Message-State: AOJu0YwNI9+SbNENSJKNCY/N0OAsRSr2igC5ne101+1SLptPTbdwvBiX
 EAC9taV33um3xR89x7Z4M7Kc4lGgK2OSltMIizyxcfu+BAJgZtMWAL6E7/Mt/NPqXK0=
X-Gm-Gg: Acq92OGT94hYXMHEw6+fgZJmrh1uNjiKan2xB2b+NqMzkI8/NSplFJljon3k6JjfxnI
 UEQKDyg3I4nFXtzUuVvUYkC4MAJqvelTX5BC4ftNspw1CbShrr7bqp3NPRBbjo1qLF8wIHFhbiW
 PTlylrPk2ziQbhxu0tsQ/8ETINbQXe0N8e/B7AxIY5nxtgzvG2fEHN12Qt1f0l0Ta7Fut6A+kz/
 nyrJemPFKbQU5ZncrqPjrlnHyPj2OuanZi1JJr0QJPftVQrUdJhidrArlqEdex5rEZx2oUPEXcZ
 tG0loSH941UraXzMKlFWEtj1X9D7Y1OYlR1/b38wTubT6oCrUSlhlUuL8J8JSDQRskNVGqVAiW5
 6tex7ddt3/1ca2RIUzekI1UlxyDnTw/nbQEstPA04vZC4OqR8P57RhaB/Zuhf3hgmj+3oz+J8gl
 ZJQczqIwxWBzfqPk0RvbOk7JoSa0vXyRj9LElIJ9Y0j0TBQE/NnGNTvIM521Kb244j9g9HXVP6r
 nEoRN/72KliiWGMBiPPzVR1KA/L7K1S6QfyPvJ3YeJCHd2d2tEL3ykjGwMpskGe/CTPGVoGigjb
 2zPK/dqeD8gOhlJO1GS+iNCa5jmdVgIS
X-Received: by 2002:a05:6808:3095:b0:486:87e4:bdb with SMTP id
 5614622812f47-4868de4511amr9727941b6e.23.1780945211079; 
 Mon, 08 Jun 2026 12:00:11 -0700 (PDT)
Received: from mac.localdomain (97-118-5-210.hlrn.qwest.net. [97.118.5.210])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e75db138sm12397777a34.11.2026.06.08.12.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:00:10 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 08 Jun 2026 12:59:32 -0600
Subject: [PATCH v16 07/21] target/mips: add Octeon SNOW3G COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-mips-octeon-missing-insns-v2-v16-7-daef7a0d8b04@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x30.google.com
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

Add helper support for the Octeon SNOW3G START and MORE selectors. The
engine state and result are represented through the architectural HSH IV
and DAT register banks that SNOW3G aliases for save and restore.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v9 -> v10:
  - Drop non-architectural SNOW3G shadow state and shared-mode tracking.
  - Use the architectural HSH IV/DAT register banks for aliased state.

Changes v8 -> v9:
  - Split SNOW3G selector operations into their own COP2 helper patch.
  - Replace generic selector dispatch with per-operation SNOW3G helpers.
  - Add matching helper.h declarations with the helper implementation.
---
 target/mips/helper.h            |   2 +
 target/mips/tcg/octeon_crypto.c | 275 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 277 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 292336ec62..c4e7693df6 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -50,6 +50,8 @@ DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1, void, env, i64)
 DEF_HELPER_1(octeon_cp2_mt_sha3_startop, void, env)
 DEF_HELPER_2(octeon_cp2_mt_zuc_start, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_zuc_more, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_snow3g_start, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_snow3g_more, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 0205ed5af5..b8157c9a8e 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -577,6 +577,281 @@ static void octeon_zuc_more(MIPSOcteonCryptoState *crypto, uint64_t data)
     octeon_zuc_advance_window(crypto, z2);
 }
 
+static const uint8_t octeon_snow3g_sr[256] = {
+    0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5,
+    0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
+    0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0,
+    0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0,
+    0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc,
+    0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15,
+    0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a,
+    0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75,
+    0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0,
+    0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84,
+    0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b,
+    0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf,
+    0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85,
+    0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8,
+    0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5,
+    0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2,
+    0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17,
+    0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73,
+    0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88,
+    0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb,
+    0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c,
+    0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79,
+    0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9,
+    0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08,
+    0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6,
+    0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a,
+    0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e,
+    0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e,
+    0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94,
+    0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf,
+    0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68,
+    0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16,
+};
+
+static const uint8_t octeon_snow3g_sq[256] = {
+    0x25, 0x24, 0x73, 0x67, 0xd7, 0xae, 0x5c, 0x30,
+    0xa4, 0xee, 0x6e, 0xcb, 0x7d, 0xb5, 0x82, 0xdb,
+    0xe4, 0x8e, 0x48, 0x49, 0x4f, 0x5d, 0x6a, 0x78,
+    0x70, 0x88, 0xe8, 0x5f, 0x5e, 0x84, 0x65, 0xe2,
+    0xd8, 0xe9, 0xcc, 0xed, 0x40, 0x2f, 0x11, 0x28,
+    0x57, 0xd2, 0xac, 0xe3, 0x4a, 0x15, 0x1b, 0xb9,
+    0xb2, 0x80, 0x85, 0xa6, 0x2e, 0x02, 0x47, 0x29,
+    0x07, 0x4b, 0x0e, 0xc1, 0x51, 0xaa, 0x89, 0xd4,
+    0xca, 0x01, 0x46, 0xb3, 0xef, 0xdd, 0x44, 0x7b,
+    0xc2, 0x7f, 0xbe, 0xc3, 0x9f, 0x20, 0x4c, 0x64,
+    0x83, 0xa2, 0x68, 0x42, 0x13, 0xb4, 0x41, 0xcd,
+    0xba, 0xc6, 0xbb, 0x6d, 0x4d, 0x71, 0x21, 0xf4,
+    0x8d, 0xb0, 0xe5, 0x93, 0xfe, 0x8f, 0xe6, 0xcf,
+    0x43, 0x45, 0x31, 0x22, 0x37, 0x36, 0x96, 0xfa,
+    0xbc, 0x0f, 0x08, 0x52, 0x1d, 0x55, 0x1a, 0xc5,
+    0x4e, 0x23, 0x69, 0x7a, 0x92, 0xff, 0x5b, 0x5a,
+    0xeb, 0x9a, 0x1c, 0xa9, 0xd1, 0x7e, 0x0d, 0xfc,
+    0x50, 0x8a, 0xb6, 0x62, 0xf5, 0x0a, 0xf8, 0xdc,
+    0x03, 0x3c, 0x0c, 0x39, 0xf1, 0xb8, 0xf3, 0x3d,
+    0xf2, 0xd5, 0x97, 0x66, 0x81, 0x32, 0xa0, 0x00,
+    0x06, 0xce, 0xf6, 0xea, 0xb7, 0x17, 0xf7, 0x8c,
+    0x79, 0xd6, 0xa7, 0xbf, 0x8b, 0x3f, 0x1f, 0x53,
+    0x63, 0x75, 0x35, 0x2c, 0x60, 0xfd, 0x27, 0xd3,
+    0x94, 0xa5, 0x7c, 0xa1, 0x05, 0x58, 0x2d, 0xbd,
+    0xd9, 0xc7, 0xaf, 0x6b, 0x54, 0x0b, 0xe0, 0x38,
+    0x04, 0xc8, 0x9d, 0xe7, 0x14, 0xb1, 0x87, 0x9c,
+    0xdf, 0x6f, 0xf9, 0xda, 0x2a, 0xc4, 0x59, 0x16,
+    0x74, 0x91, 0xab, 0x26, 0x61, 0x76, 0x34, 0x2b,
+    0xad, 0x99, 0xfb, 0x72, 0xec, 0x33, 0x12, 0xde,
+    0x98, 0x3b, 0xc0, 0x9b, 0x3e, 0x18, 0x10, 0x3a,
+    0x56, 0xe1, 0x77, 0xc9, 0x1e, 0x9e, 0x95, 0xa3,
+    0x90, 0x19, 0xa8, 0x6c, 0x09, 0xd0, 0xf0, 0x86,
+};
+
+static inline uint8_t octeon_snow3g_mulx(uint8_t v, uint8_t c)
+{
+    return (v & 0x80) ? ((v << 1) ^ c) : (v << 1);
+}
+
+static uint8_t octeon_snow3g_mulxpow(uint8_t v, unsigned int n, uint8_t c)
+{
+    while (n-- > 0) {
+        v = octeon_snow3g_mulx(v, c);
+    }
+    return v;
+}
+
+static inline uint32_t octeon_snow3g_pack32(uint8_t b0, uint8_t b1,
+                                            uint8_t b2, uint8_t b3)
+{
+    return ((uint32_t)b0 << 24) | ((uint32_t)b1 << 16) |
+           ((uint32_t)b2 << 8) | b3;
+}
+
+static uint32_t octeon_snow3g_mulalpha(uint8_t c)
+{
+    return octeon_snow3g_pack32(octeon_snow3g_mulxpow(c, 23, 0xa9),
+                                octeon_snow3g_mulxpow(c, 245, 0xa9),
+                                octeon_snow3g_mulxpow(c, 48, 0xa9),
+                                octeon_snow3g_mulxpow(c, 239, 0xa9));
+}
+
+static uint32_t octeon_snow3g_divalpha(uint8_t c)
+{
+    return octeon_snow3g_pack32(octeon_snow3g_mulxpow(c, 16, 0xa9),
+                                octeon_snow3g_mulxpow(c, 39, 0xa9),
+                                octeon_snow3g_mulxpow(c, 6, 0xa9),
+                                octeon_snow3g_mulxpow(c, 64, 0xa9));
+}
+
+static uint32_t octeon_snow3g_s1(uint32_t w)
+{
+    uint8_t x0 = octeon_snow3g_sr[w >> 24];
+    uint8_t x1 = octeon_snow3g_sr[(uint8_t)(w >> 16)];
+    uint8_t x2 = octeon_snow3g_sr[(uint8_t)(w >> 8)];
+    uint8_t x3 = octeon_snow3g_sr[(uint8_t)w];
+    uint8_t r0 = octeon_snow3g_mulx(x0, 0x1b) ^ x1 ^ x2 ^
+                 octeon_snow3g_mulx(x3, 0x1b) ^ x3;
+    uint8_t r1 = octeon_snow3g_mulx(x0, 0x1b) ^ x0 ^
+                 octeon_snow3g_mulx(x1, 0x1b) ^ x2 ^ x3;
+    uint8_t r2 = x0 ^ octeon_snow3g_mulx(x1, 0x1b) ^ x1 ^
+                 octeon_snow3g_mulx(x2, 0x1b) ^ x3;
+    uint8_t r3 = x0 ^ x1 ^ octeon_snow3g_mulx(x2, 0x1b) ^ x2 ^
+                 octeon_snow3g_mulx(x3, 0x1b);
+
+    return octeon_snow3g_pack32(r0, r1, r2, r3);
+}
+
+static uint32_t octeon_snow3g_s2(uint32_t w)
+{
+    uint8_t x0 = octeon_snow3g_sq[w >> 24];
+    uint8_t x1 = octeon_snow3g_sq[(uint8_t)(w >> 16)];
+    uint8_t x2 = octeon_snow3g_sq[(uint8_t)(w >> 8)];
+    uint8_t x3 = octeon_snow3g_sq[(uint8_t)w];
+    uint8_t r0 = octeon_snow3g_mulx(x0, 0x69) ^ x1 ^ x2 ^
+                 octeon_snow3g_mulx(x3, 0x69) ^ x3;
+    uint8_t r1 = octeon_snow3g_mulx(x0, 0x69) ^ x0 ^
+                 octeon_snow3g_mulx(x1, 0x69) ^ x2 ^ x3;
+    uint8_t r2 = x0 ^ octeon_snow3g_mulx(x1, 0x69) ^ x1 ^
+                 octeon_snow3g_mulx(x2, 0x69) ^ x3;
+    uint8_t r3 = x0 ^ x1 ^ octeon_snow3g_mulx(x2, 0x69) ^ x2 ^
+                 octeon_snow3g_mulx(x3, 0x69);
+
+    return octeon_snow3g_pack32(r0, r1, r2, r3);
+}
+
+static uint32_t octeon_snow3g_lfsr(const MIPSOcteonCryptoState *crypto,
+                                   unsigned int index)
+{
+    uint64_t pair = crypto->hsh_dat[index / 2];
+
+    return index & 1 ? octeon_crypto_lo32(pair) : octeon_crypto_hi32(pair);
+}
+
+static void octeon_snow3g_set_lfsr(MIPSOcteonCryptoState *crypto,
+                                   unsigned int index, uint32_t value)
+{
+    uint32_t hi = octeon_crypto_hi32(crypto->hsh_dat[index / 2]);
+    uint32_t lo = octeon_crypto_lo32(crypto->hsh_dat[index / 2]);
+
+    if (index & 1) {
+        lo = value;
+    } else {
+        hi = value;
+    }
+    crypto->hsh_dat[index / 2] = octeon_crypto_pack32(hi, lo);
+}
+
+static uint32_t octeon_snow3g_fsm(const MIPSOcteonCryptoState *crypto,
+                                  unsigned int index)
+{
+    return crypto->hsh_iv[1 + index];
+}
+
+static void octeon_snow3g_set_fsm(MIPSOcteonCryptoState *crypto,
+                                  unsigned int index, uint32_t value)
+{
+    crypto->hsh_iv[1 + index] = value;
+}
+
+static uint32_t octeon_snow3g_clock_fsm(MIPSOcteonCryptoState *crypto)
+{
+    uint32_t fsm0 = octeon_snow3g_fsm(crypto, 0);
+    uint32_t fsm1 = octeon_snow3g_fsm(crypto, 1);
+    uint32_t fsm2 = octeon_snow3g_fsm(crypto, 2);
+    uint32_t f = (uint32_t)(octeon_snow3g_lfsr(crypto, 15) + fsm0) ^ fsm1;
+    uint32_t r = (uint32_t)(fsm1 + (fsm2 ^ octeon_snow3g_lfsr(crypto, 5)));
+
+    octeon_snow3g_set_fsm(crypto, 2, octeon_snow3g_s2(fsm1));
+    octeon_snow3g_set_fsm(crypto, 1, octeon_snow3g_s1(fsm0));
+    octeon_snow3g_set_fsm(crypto, 0, r);
+    return f;
+}
+
+static void octeon_snow3g_clock_lfsr(MIPSOcteonCryptoState *crypto,
+                                     bool init_mode, uint32_t f)
+{
+    uint32_t lfsr[16];
+    uint32_t s0;
+    uint32_t s11;
+    uint32_t v;
+    int i;
+
+    for (i = 0; i < 16; i++) {
+        lfsr[i] = octeon_snow3g_lfsr(crypto, i);
+    }
+
+    s0 = lfsr[0];
+    s11 = lfsr[11];
+    v = (s0 << 8) ^ octeon_snow3g_mulalpha(s0 >> 24) ^
+        lfsr[2] ^ (s11 >> 8) ^ octeon_snow3g_divalpha((uint8_t)s11);
+
+    if (init_mode) {
+        v ^= f;
+    }
+
+    for (i = 0; i < 15; i++) {
+        octeon_snow3g_set_lfsr(crypto, i, lfsr[i + 1]);
+    }
+    octeon_snow3g_set_lfsr(crypto, 15, v);
+}
+
+static uint32_t octeon_snow3g_generate_word(MIPSOcteonCryptoState *crypto)
+{
+    uint32_t f = octeon_snow3g_clock_fsm(crypto);
+    uint32_t z = f ^ octeon_snow3g_lfsr(crypto, 0);
+
+    octeon_snow3g_clock_lfsr(crypto, false, 0);
+    return z;
+}
+
+static void octeon_snow3g_queue_result(MIPSOcteonCryptoState *crypto)
+{
+    uint32_t z0 = octeon_snow3g_generate_word(crypto);
+    uint32_t z1 = octeon_snow3g_generate_word(crypto);
+
+    crypto->hsh_iv[0] = octeon_crypto_pack32(z0, z1);
+}
+
+static void octeon_snow3g_start(MIPSOcteonCryptoState *crypto, uint64_t data)
+{
+    int i;
+
+    for (i = 0; i < 14; i++) {
+        octeon_snow3g_set_lfsr(crypto, i, octeon_snow3g_lfsr(crypto, i));
+    }
+    octeon_snow3g_set_lfsr(crypto, 14, data >> 32);
+    octeon_snow3g_set_lfsr(crypto, 15, data);
+    for (i = 0; i < 3; i++) {
+        octeon_snow3g_set_fsm(crypto, i, 0);
+    }
+
+    for (i = 0; i < 32; i++) {
+        uint32_t f = octeon_snow3g_clock_fsm(crypto);
+
+        octeon_snow3g_clock_lfsr(crypto, true, f);
+    }
+
+    (void)octeon_snow3g_clock_fsm(crypto);
+    octeon_snow3g_clock_lfsr(crypto, false, 0);
+    octeon_snow3g_queue_result(crypto);
+}
+
+static void octeon_snow3g_more(MIPSOcteonCryptoState *crypto)
+{
+    octeon_snow3g_queue_result(crypto);
+}
+
+void helper_octeon_cp2_mt_snow3g_start(CPUMIPSState *env, uint64_t value)
+{
+    octeon_snow3g_start(&env->octeon_crypto, value);
+}
+
+void helper_octeon_cp2_mt_snow3g_more(CPUMIPSState *env, uint64_t value)
+{
+    (void)value;
+    octeon_snow3g_more(&env->octeon_crypto);
+}
+
 void helper_octeon_cp2_mt_zuc_start(CPUMIPSState *env, uint64_t value)
 {
     octeon_zuc_start(&env->octeon_crypto, value);

-- 
2.54.0


