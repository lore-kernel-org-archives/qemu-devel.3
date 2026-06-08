Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE98CD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfDD-0001A2-VF; Mon, 08 Jun 2026 15:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfD0-00013a-27
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:26 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCx-0006sk-Om
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:25 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e6cee520ccso3324279a34.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 12:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780945222; x=1781550022; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H4fbpAWrwvWrzQHeEihm7BL4TjivtpObCtoA8m34nPQ=;
 b=Xt2kQjsbu5NAXgiv29IayhQYH1ib0ZlFAmzoIcbYCYSjzrlusHn8ogefTRpM/EVTcK
 g6YkrhAQBf/IVSU7H/fQWHkH+BI89Qn5DtCDw4wOl84p30gNaR6p/2Bv838QvQGMHqiw
 e9axigsgWA3yD6Fw+WvxHnv1pNVh26mt0IwfSwxRGmd9ny3SpWjLSor36jFbkqq547xZ
 A+aDM8fe0M14QKsWiI7B3R6xKgaegnkamK2M6AJipqOIJ6cQEd8//JVnYhMkFVBEVaTZ
 9MIEz2fQH7GFY9WJz58JIX19agFMOJCuqvEeLH0udcVChYpVabf4v+k3rZ83oSrhcivF
 TTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945222; x=1781550022;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=H4fbpAWrwvWrzQHeEihm7BL4TjivtpObCtoA8m34nPQ=;
 b=LEh9CVCZFVy5LQzl64RvwUOzFOAsyNi2ki2pEfNW4dqZEkI1LgGkAo4webu3D66Z4u
 Ku1z13wB1mJEJwHuzh/iBVS2txtdq79DoZwnrtlVu0/sGrgmD+skBRsqf9yYQvP0wqw5
 tKFXe6QpYT6Zmrn7NxuW/omT5ObLcrrhuge19FWfbU7tgkCrD5WZu/ca+2RZLyRc2aIx
 SGfSk3QWjFvwsw7LGz22NQvsOIHL2a/x14EWBsrdFm/meCOT2y7QbAJgeL4MBFNHRtM4
 KCh10fpLWVEkNZgSRC6yKs6OMBk/txwgeAdxsnL1jVjJ7S97XuxMfhZjOB5xnPbkQ+1l
 cQ6A==
X-Gm-Message-State: AOJu0YyDGYrj8+mV+i+wY3XWWw7e1gvhKeUJ7wu+MKKI/U9cezNmKTNy
 eO+jS3FQDtjNh2mH16gb3mCuzi7MBCzfThkFGCLMHi4eNieuC9c/xQLsDA2wCKl81iw=
X-Gm-Gg: Acq92OF+RTMm4Sa7pHzqjaJSAWvfNZNgN67Ah/M9GdCwAS7Ooe16W0N2WsPCotAiB8z
 wKisNVO4b9KmpCdVI+dRfQmz9K4o4nJRAvwTVrL3LRGV/3+tr4E31sbyxeZhLuNv8+U34NyvhoD
 QVL0iz9XZdtA340Zes2z0+AsmfxSfnAWsxgPz9NkSOKC3EjXODVTxdm4AST/Ohto3a0kTHS+ZPU
 UBZwmD1vuBMyEFEA+WPJajLlD0vlm5CBrYUItFM26luUHN5AuPNP4I75TSwrn9UpWLABSTyH//Q
 CoRqJo0A9MJjDBAsbMIHgVBgZ1yiNm6LdRjFtvpAbIlzodMKHq4SBVOzlT7vLubxNWxd0Iaj1GL
 LOBdfuxZ32PAoteq4I8QVD/whVD/8Qe211b2T4cZYFpNQMCL954UBWWrVukLNUaG9NIudeDV2Jd
 zvDRX0EQCUfyYGj6XAqAxgWa3V72zAFzxXOK7wodg62sshvQ929Fv+mwBo9pLGCaSLwPPecmyge
 loWZgn4rv+lF7D2Wf7ORp5Q/mbbpTJydRd9V466KBF6OzSlnEIceipNKXaccOGFgTDT5cj+wmIA
 AmLZFzBRZcPWcdDQoUegCkBFLcEbqEOWfOZqADvPPAg=
X-Received: by 2002:a05:6830:82b6:b0:7e6:50c4:e954 with SMTP id
 46e09a7af769-7e70f43bc7amr7232865a34.11.1780945222476; 
 Mon, 08 Jun 2026 12:00:22 -0700 (PDT)
Received: from mac.localdomain (97-118-5-210.hlrn.qwest.net. [97.118.5.210])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e75db138sm12397777a34.11.2026.06.08.12.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:00:21 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 08 Jun 2026 12:59:44 -0600
Subject: [PATCH v16 19/21] target/mips: decode Octeon CHORD and LLM COP2
 selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-mips-octeon-missing-insns-v2-v16-19-daef7a0d8b04@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32a.google.com
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
Acked-by: Richard Henderson <richard.henderson@linaro.org>

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
index 76792c9c87..a0db6630c7 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -235,6 +235,9 @@ CP2_MF_I64(CVM_MF_GFM_MUL1, gfm_mul[1]);
 CP2_MF_I64(CVM_MF_GFM_RESINP0, gfm_resinp[0]);
 CP2_MF_I64(CVM_MF_GFM_RESINP1, gfm_resinp[1]);
 CP2_MF_U16(CVM_MF_GFM_POLY, gfm_poly);
+CP2_MF_I64(CVM_MF_CHORD, chord);
+CP2_MF_I64(CVM_MF_LLM_DATA0, llm_data[0]);
+CP2_MF_I64(CVM_MF_LLM_DATA1, llm_data[1]);
 
 CP2_MF_HELPER(CVM_MF_CRC_IV_REFLECT, crc_iv_reflect);
 CP2_MF_I64(CVM_MF_SHA3_DAT24, sha3_dat24);
@@ -306,6 +309,8 @@ CP2_MT_I64(CVM_MT_GFM_RESINP0, gfm_resinp[0]);
 CP2_MT_I64(CVM_MT_GFM_RESINP1, gfm_resinp[1]);
 CP2_MT_XOR_I64(CVM_MT_GFM_XOR0, gfm_resinp[0]);
 CP2_MT_U16(CVM_MT_GFM_POLY, gfm_poly);
+CP2_MT_I64(CVM_MT_LLM_DATA0, llm_data[0]);
+CP2_MT_I64(CVM_MT_LLM_DATA1, llm_data[1]);
 CP2_MT_U8_MASKED(CVM_MT_CRC_LEN, crc_len, 0xf);
 CP2_MT_U32(CVM_MT_CRC_POLYNOMIAL, crc_poly);
 
@@ -395,6 +400,14 @@ CP2_MT_HELPER(CVM_MT_HSH_STARTMD5, hsh_startmd5);
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


