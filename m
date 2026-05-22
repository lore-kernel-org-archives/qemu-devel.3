Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD0BCD5BAC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 19:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQVgU-0001rn-Nz; Fri, 22 May 2026 15:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVgM-0001kc-NG
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:37:18 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVgJ-0000a6-6S
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:37:17 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-464bba3a9easo4883543b6e.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 12:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779478632; x=1780083432; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H4fbpAWrwvWrzQHeEihm7BL4TjivtpObCtoA8m34nPQ=;
 b=M0rKRtr2/ZdoAlM8nogPEBjBbiFmDm99ePmm61SJjvBt8KIoCvvUgCzwxt3Sa8pYz6
 rSp+6/G9x9ysY0kN0rAR5WKuvDSv7iNaIzx3VU4bkesASAR/5mfJe09feTHfgPjRqtAS
 hkSXQ/rEmPFvZUJkxSZO6bYGiF9lQ8TZHG6NcLamDtVpJ2Clw16Xzup+RFcFK1utWpY2
 LwDPWdAKm7zkpuCSW74Y8yw59M0Ks36LePJl+OZGSRbXf8HH3xlF/234c4d2O4U8v8BL
 2OXswa/k0ydgdlIowtiV8t1szUNQ2pQ75d8yFtpAUGcJTwlVGtx+Atihk0jHAtvQReAd
 fJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779478632; x=1780083432;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=H4fbpAWrwvWrzQHeEihm7BL4TjivtpObCtoA8m34nPQ=;
 b=r7y5E0ae/pHTVWeU1pWltXOxUGegYorhFLlMYmc1wpLeMx+YObsE7/YaQl6iKoGyb4
 g5BqDiLJdUk1YVezpvVvCXYu5g4aB7vM3G682DUlGzcBZknllUOVOI8kuNuuqRIPZhIE
 jRdFEMtd8HjpMXbWp3798nyyWSJoC/b1ADWW9DO1Guy9WmAfVoQBz0ATbvOcCEpYoQY5
 cUz37GavIqFt5n/ZbhU1KfKLuKebhaKBYE6g2lL9RSV2ICijbGCXpdamiv046c6WDpmt
 KPCa0b/xZGhzbeoCzEYsgk2PgCr2kgSwPqVDlrQzlQ2EbgZl+cfghUgP0cQInj4/r03D
 S6Ng==
X-Gm-Message-State: AOJu0Yzgzye9hTRfkQd3ZXppiJZPqtYRgZV4t17M2mfs6qJjuYXaxHsq
 fdnk3nfn3jQhLsKQh86imxBXbbCsYwdLqZWJLQzmTcjK/54aDbdgkRd8
X-Gm-Gg: Acq92OEy43g4BPbRbgi30ziDOj54ozjdNj7G8tYUb2X+LvieYtq567dOl/pqoCsOzPN
 f+7VFBonglsXw9u4ZqmbOELuq6VGWXXSFOCcfu2QNCEYTC0nBvDk76WNsvQFFEgWb0c3mxOG9vU
 9kh6gcYmctBQOxeARw+hE6kJqCS0L/Cl9GK4+ZDhZG9dOuTusxU1KwRWWQqO4mkj6vGTLBSHwF+
 ORFnTz/PgfBCcZIs09FwTcfuU7o0qrYerQJtVgwX+nKrZAINP19xNNt4yOnLjtictvomBcVkTG8
 2/9HeUknDSeSupjgJrYmN29Ko0Tc3iS3CSEWgCYdn5N9YPGCslT2mjFSGxxiRdr94Udv4e7pES0
 3LRb3F1iIdU4O3hfFjVhxcg20zO68rrhKj4/TPbij5utt1iU1sEoatgUyHplyXzsQj4lv/mWC5I
 7H826m9SI0a0/zrMKIny+hpqQu/oDCWTuLLqBXfhbq4PCdExkCh3N0DLXHmK/y256gBUmqGB+p6
 3SLG4sK34sdAryHAz+4UWsH1Wl+l10nEeUO9ViixJ2olTWJgPgtnuM8DiW1Ya0//LDB
X-Received: by 2002:a05:6808:1693:b0:479:f131:c4f2 with SMTP id
 5614622812f47-4854a0fe77bmr2402921b6e.14.1779478632519; 
 Fri, 22 May 2026 12:37:12 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-48554757d5dsm995297b6e.15.2026.05.22.12.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 12:37:12 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 22 May 2026 13:36:51 -0600
Subject: [PATCH v15 20/22] target/mips: decode Octeon CHORD and LLM COP2
 selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mips-octeon-missing-insns-v2-v15-20-f8731a588dc2@gmail.com>
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


