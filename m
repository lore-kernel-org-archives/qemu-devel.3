Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D247CD4F5B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 05:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQIJY-0003RM-Sc; Fri, 22 May 2026 01:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJN-0002zZ-P7
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:44 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJL-0002D7-NE
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:41 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-47c6f914617so3331399b6e.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 22:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779427238; x=1780032038; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZO1MBdUXHdYjIwpDW060x9EGMTOHxaiqAsOMNIUXc2o=;
 b=q2TbU6ZBqEcVfzmigeievwGQaejXFjoCHvGbbuPKS3CMygcMgCS6IiCcPL9woC4+om
 JNXGFpdzgXLu4/E0/2YQLzrM77fhPgKrWw/q/00b7y597urO5xQC27FK1KcuMHtNddjG
 44VC1Or9u/OEMlM8EZm/FJDCykDXy/h0LupVishnPXDMQreRENNlLq36FNrpBVBSKL48
 OAeJDwCyGMotMUMbkDgvchxJ3hwPu7QGkOD3DsPRhwG6jGVzLnt1/91u7nCmSNbi0oMQ
 LB0PgbeRaFsOOHqYy5EGF044CpTLdh2BhLQuQ7fYDLBCxSmds+1A52GXffce/J8jt/JS
 nKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779427238; x=1780032038;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZO1MBdUXHdYjIwpDW060x9EGMTOHxaiqAsOMNIUXc2o=;
 b=JTjyZahE06IxaWEikBn/e6hFkzGAMwiwrLegL2T1uX0D956emDzZgAJR6aE2xSeb/n
 CLlO1wG+40IiBNsQ+lOLBzbk9qiKMNdW06s1WgEZC50Sjtoq2X4tbfGK1oAAux0VQvsY
 1WMzaQb/19gcZMTI3pBBGWDbBlKgVbvGxmsQKcVsJ8Gs1tM8/kQ9IrrcsHlganPqxiZu
 7vxDPEX3BEGJU/O55i56uSzuuOYf2K0BX6HZ983EXJEkAtIqFBpbkTL0unQTQ5SmUzgU
 xdKPOTHuJCpol9CAMqr6TIIzrweud/H0B9qf5sL+ktFdvd9WU1muhpNi5xt9J9FdNWvH
 NmYQ==
X-Gm-Message-State: AOJu0Yw88f95Dneq9tFZzBJ92TA4DtkWr6lcLaZxgZVSOQ2S6UxzSOt9
 6dOTzvah0dUJ1hYyYeR3xovBj1bBpmS/ilZL6MyyPo2jXg8zFIPQvluu
X-Gm-Gg: Acq92OE3Q1GH1Huw2ssYE654mptYk85vHCUA8TK+xIKwVp/3l2BM4gwiDmWcTFczc/n
 sl5ee0S+jHieFuczRqaSs9ryJ1P4ckn3qFTh6iJBH3/5OtvUCyDY0UvmiJB2c1qrF8YM3cp7gp3
 J9foHDLvOdzXfFYDlYskYS30wJKAH1w6Y8fL7M1stoBeghwpAyf5lfF83rVh71XvjTBX6vkYC2F
 qMG06BPZOYD7q3+ewvlsJixq1PbvUAKsMLYCIcNEhVl/EPxKWlxD9Mjs+bYvdGS3i22AK7ware3
 tGahLm5Gzin7Z/Rv6u2Ly/oWWM8eD528y5/afZ0BiLK9juE+ue10X0H5eG4zsdK2425j1h0WPBs
 wcIGhbfYeKh1TIXfpgx9A61eFMxKCdRLNoH8pe9uvaIGsU8Cf8pGBjZrC5omLE6ac+6w4xbr0TP
 aETpNYV3prZ4U/rkltsR8QIpJdd1qOUq+qroTaM7eCGb7bqJdmI2mSlAS1tfJUH+oCCmxLw19ji
 hhc3D5eKVXs/HnY3IqQIdFjdJ3NuRovx4p07QfhHXqGz0gCy01tP9QSM06et+cRXjIw
X-Received: by 2002:a05:6808:191a:b0:485:467f:a321 with SMTP id
 5614622812f47-48549d46712mr1142544b6e.12.1779427238334; 
 Thu, 21 May 2026 22:20:38 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4855476ab77sm59690b6e.17.2026.05.21.22.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 22:20:37 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 23:20:02 -0600
Subject: [PATCH v14 20/22] target/mips: decode Octeon CHORD and LLM COP2
 selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v14-20-fbf08e164830@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x232.google.com
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

Add explicit decodetree entries and translator bindings for the Octeon
CHORD and sparse LLM COP2 selectors.  CHORD and LLM use their own COP2
selector window rather than the crypto engine windows covered by the
preceding decode patches.

This completes the explicit COP2 selector coverage by adding the
remaining CHORD and LLM register and operation selectors.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes v13 -> v14:
  - Leave the CP2_Undef fallback in the register-selector patch and keep
    this patch limited to CHORD/LLM selector additions.

Changes v9 -> v10:
  - Split CHORD/LLM selector decode out of the monolithic Octeon COP2
    selector decode patch.
  - Kept sparse LLM operations helper-backed.
---
 target/mips/tcg/octeon.decode      | 13 +++++++++++++
 target/mips/tcg/octeon_translate.c | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 4ac38d264c..a8c944e668 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -167,6 +167,9 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MF_GFM_RESINP0                   010010 00001 rt:5 0000 0010 0101 1010 &cp2
     CVM_MF_GFM_RESINP1                   010010 00001 rt:5 0000 0010 0101 1011 &cp2
     CVM_MF_GFM_POLY                      010010 00001 rt:5 0000 0010 0101 1110 &cp2
+    CVM_MF_CHORD                         010010 00001 rt:5 0000 0100 0000 0000 &cp2
+    CVM_MF_LLM_DATA0                     010010 00001 rt:5 0000 0100 0000 0010 &cp2
+    CVM_MF_LLM_DATA1                     010010 00001 rt:5 0000 0100 0000 1010 &cp2
     CVM_MT_HSH_DAT0                      010010 00101 rt:5 0000 0000 0100 0000 &cp2
     CVM_MT_HSH_DAT1                      010010 00101 rt:5 0000 0000 0100 0001 &cp2
     CVM_MT_HSH_DAT2                      010010 00101 rt:5 0000 0000 0100 0010 &cp2
@@ -261,6 +264,16 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_SHA3_XORDAT15                 010010 00101 rt:5 0000 0010 1100 1111 &cp2
     CVM_MT_SHA3_XORDAT16                 010010 00101 rt:5 0000 0010 1101 0000 &cp2
     CVM_MT_SHA3_XORDAT17                 010010 00101 rt:5 0000 0010 1101 0001 &cp2
+    CVM_MT_LLM_READ_ADDR0                010010 00101 rt:5 0000 0100 0000 0000 &cp2
+    CVM_MT_LLM_WRITE_ADDR0               010010 00101 rt:5 0000 0100 0000 0001 &cp2
+    CVM_MT_LLM_DATA0                     010010 00101 rt:5 0000 0100 0000 0010 &cp2
+    CVM_MT_LLM_READ64_ADDR0              010010 00101 rt:5 0000 0100 0000 0100 &cp2
+    CVM_MT_LLM_WRITE64_ADDR0             010010 00101 rt:5 0000 0100 0000 0101 &cp2
+    CVM_MT_LLM_READ_ADDR1                010010 00101 rt:5 0000 0100 0000 1000 &cp2
+    CVM_MT_LLM_WRITE_ADDR1               010010 00101 rt:5 0000 0100 0000 1001 &cp2
+    CVM_MT_LLM_DATA1                     010010 00101 rt:5 0000 0100 0000 1010 &cp2
+    CVM_MT_LLM_READ64_ADDR1              010010 00101 rt:5 0000 0100 0000 1100 &cp2
+    CVM_MT_LLM_WRITE64_ADDR1             010010 00101 rt:5 0000 0100 0000 1101 &cp2
     CVM_MT_CRC_LEN                       010010 00101 rt:5 0001 0010 0000 0010 &cp2
     CVM_MT_CRC_DWORD                     010010 00101 rt:5 0001 0010 0000 0111 &cp2
     CVM_MT_CRC_VAR                       010010 00101 rt:5 0001 0010 0000 1000 &cp2
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index ad71c0a8aa..15a71bc7c3 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -210,6 +210,9 @@ CP2_MF_I64(CVM_MF_GFM_MUL1, gfm_mul[1]);
 CP2_MF_I64(CVM_MF_GFM_RESINP0, gfm_resinp[0]);
 CP2_MF_I64(CVM_MF_GFM_RESINP1, gfm_resinp[1]);
 CP2_MF_U16(CVM_MF_GFM_POLY, gfm_poly);
+CP2_MF_I64(CVM_MF_CHORD, chord);
+CP2_MF_I64(CVM_MF_LLM_DATA0, llm_data[0]);
+CP2_MF_I64(CVM_MF_LLM_DATA1, llm_data[1]);
 
 CP2_MF_HELPER(CVM_MF_CRC_IV_REFLECT, crc_iv_reflect);
 CP2_MF_HELPER(CVM_MF_SHA3_DAT24, sha3_dat24);
@@ -281,6 +284,8 @@ CP2_MT_I64(CVM_MT_GFM_RESINP0, gfm_resinp[0]);
 CP2_MT_I64(CVM_MT_GFM_RESINP1, gfm_resinp[1]);
 CP2_MT_HELPER(CVM_MT_GFM_XOR0, gfm_xor0);
 CP2_MT_U16(CVM_MT_GFM_POLY, gfm_poly);
+CP2_MT_I64(CVM_MT_LLM_DATA0, llm_data[0]);
+CP2_MT_I64(CVM_MT_LLM_DATA1, llm_data[1]);
 CP2_MT_U8_MASKED(CVM_MT_CRC_LEN, crc_len, 0xf);
 CP2_MT_U32(CVM_MT_CRC_POLYNOMIAL, crc_poly);
 
@@ -370,6 +375,14 @@ CP2_MT_HELPER(CVM_MT_HSH_STARTMD5, hsh_startmd5);
 CP2_MT_HELPER(CVM_MT_HSH_STARTSHA256, hsh_startsha256);
 CP2_MT_HELPER(CVM_MT_HSH_STARTSHA, hsh_startsha);
 CP2_MT_HELPER(CVM_MT_HSH_STARTSHA512, hsh_startsha512);
+CP2_MT_HELPER(CVM_MT_LLM_READ_ADDR0, llm_read_addr0);
+CP2_MT_HELPER(CVM_MT_LLM_WRITE_ADDR0, llm_write_addr0);
+CP2_MT_HELPER(CVM_MT_LLM_READ64_ADDR0, llm_read64_addr0);
+CP2_MT_HELPER(CVM_MT_LLM_WRITE64_ADDR0, llm_write64_addr0);
+CP2_MT_HELPER(CVM_MT_LLM_READ_ADDR1, llm_read_addr1);
+CP2_MT_HELPER(CVM_MT_LLM_WRITE_ADDR1, llm_write_addr1);
+CP2_MT_HELPER(CVM_MT_LLM_READ64_ADDR1, llm_read64_addr1);
+CP2_MT_HELPER(CVM_MT_LLM_WRITE64_ADDR1, llm_write64_addr1);
 
 static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 {

-- 
2.54.0


