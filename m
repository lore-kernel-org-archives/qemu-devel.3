Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BCECD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYh7-0001JL-Ad; Wed, 20 May 2026 00:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYh4-0001Ib-8K
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:38:06 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgy-0003uc-Hw
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:38:02 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dbe437b072so2203844a34.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251879; x=1779856679; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S8M4T3KbUASgSh1fBSVXJFYEPC5HjOIzY026NSgJcvE=;
 b=W6DFIVWx23ppNXunzxDPtRFoOk2WvKRhZMS0W2gXUeoZ6lrN8CeeE7BHojB0SAwIo8
 +cgSrvj/bNyCD9PaGjpfWgPVXZ+J3Owz02RwWYpBDUiinDl0an5cW5Ry+icfsAoUm+tP
 kdoSetQm7Jr1AIyblTpeHzUg86cA+CO6wu25C4Rld5aBOw0EuSurGxEqf+YrIBctvdNe
 A1wLaybaot612m4zT/ujM1eJZwtHgGCZaxWV2A/QsNJk0h5juzAqTDR2wv59U4w7RsA9
 Xg0n7NpaDt01iFxN9khKxwL8hRH4kqL5fo8jssg/zb8+VixD394hyXTtALySzM1dYbAO
 usAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251879; x=1779856679;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S8M4T3KbUASgSh1fBSVXJFYEPC5HjOIzY026NSgJcvE=;
 b=qhwKfJSrYgeCtW0B2f0LMFph8NGijWqO8EcK4ktfjuQMeayEnlu0eI7QwtqtRRUA30
 SmpL7aK7IvKGy72ytuQAV23bqQSBI38Vth33dOfcjrMRqCvVM63Za56kjIBQrDgmeYem
 e6hdOTJM9if0fcLZ2tQM2tHOr9gwWatLLBPdhLcGfQL8/cO02DJdjI+0mB4YOseteiHa
 7oXbmCkZK3FNrBPCnxVcajVsNgvYFc4RxEAnnoztumDedyC/7kcvjBCehbMkLb5Ah3uz
 /Tl00HDQv0+F7qwAIhU+ykgofTlbOztFMIsecigUYNvkaTuk0oc/JkY6IDFU8+OvKkrS
 vFPw==
X-Gm-Message-State: AOJu0YzTGWO+1hNELqL5Y/2MVPdQyjv0INVxCLSILsLrXItpF9CAeN9O
 KLwrs/qIYRsQaG+qar50Qukk3ohGXLSItPWv49X6YODIoc8k7hK+MIPk
X-Gm-Gg: Acq92OE4DBJFv0rVW+vSAUAmL0fkl736hrKl5KIchzwnyXlnCxIbZhVQNqh2DWJbrsd
 jY5YObzUeglQzPONf9Cn024jMs32tXIH9gu0NJ2yDcZJF9LIneNg5ifTLXevw53cPf9NpVNHxxa
 1g8XdQyDraRnSeyfmdDaRl+5Hc7G9wM8hkGG8yeTp8a9SjH3x7wXpqvvUach7lBaLYPMyEDg2kj
 4Kb7UlTdylhu0Ks3Pc0FJQmPLXcPL5k4Rs1cEqwWiXtpM/vxBXZI3m8SLPFnZQVBKPbUPdsTI3P
 KqM5oyTq14OBzJbukf5NF0G+f24NHOXY/MfcvuzvAfkG8S7OwrMv8gBfcgEyb1EJeFuLKpMvQh9
 mUPGxAzL+vdF0AMn0UuF1X6FGcjkrLLQoWNvTb1nzCIZTD3tM2rVJNXTL7zTg0o46KHyEAoulBv
 LbbJVeQ7BEcj7Icu+A1ibY3DR5FmXVohVbB/m/sArvVvOd0/bwWsvhA+oulhdNlI4CkL8T5XCI5
 +icvzE/ZiNRkbQ4y/yx+ATAMkuNOJ9sBo7COSHcP7JRBy2uHd0tO9LbBLpS8vQBVKez
X-Received: by 2002:a05:6830:4387:b0:7dc:c43b:9599 with SMTP id
 46e09a7af769-7e4ea07a52emr15048800a34.7.1779251879424; 
 Tue, 19 May 2026 21:37:59 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:58 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:32 -0600
Subject: [PATCH v10 38/45] target/mips: decode Octeon CRC and GFM COP2
 selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-38-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
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

Add explicit decodetree entries and translator bindings for the Octeon
CRC and GFM COP2 operation selectors.  Unlike the simple register moves,
these selectors update CRC or Galois-field state and therefore remain
per-operation helper calls.

Keep CRC/GFM decode next to the helpers that implement these side
effects while avoiding a monolithic selector-dispatch helper.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 target/mips/tcg/octeon.decode      | 16 ++++++++++++++++
 target/mips/tcg/octeon_translate.c | 17 +++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 01fdbfec7a..fe9c97e380 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -129,6 +129,7 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MF_CRC_POLYNOMIAL                010010 00001 rt:5 0000 0010 0000 0000 &cp2
     CVM_MF_CRC_IV                        010010 00001 rt:5 0000 0010 0000 0001 &cp2
     CVM_MF_CRC_LEN                       010010 00001 rt:5 0000 0010 0000 0010 &cp2
+    CVM_MF_CRC_IV_REFLECT                010010 00001 rt:5 0000 0010 0000 0011 &cp2
     CVM_MF_GFM_MUL0                      010010 00001 rt:5 0000 0010 0101 1000 &cp2
     CVM_MF_GFM_MUL1                      010010 00001 rt:5 0000 0010 0101 1001 &cp2
     CVM_MF_GFM_RESINP0                   010010 00001 rt:5 0000 0010 0101 1010 &cp2
@@ -147,6 +148,7 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_HSH_IV3                       010010 00101 rt:5 0000 0000 0100 1011 &cp2
     CVM_MT_GFM_MUL_REFLECT0              010010 00101 rt:5 0000 0000 0101 1000 &cp2
     CVM_MT_GFM_MUL_REFLECT1              010010 00101 rt:5 0000 0000 0101 1001 &cp2
+    CVM_MT_GFM_XOR0_REFLECT              010010 00101 rt:5 0000 0000 0101 1100 &cp2
     CVM_MT_3DES_KEY0                     010010 00101 rt:5 0000 0000 1000 0000 &cp2
     CVM_MT_3DES_KEY1                     010010 00101 rt:5 0000 0000 1000 0001 &cp2
     CVM_MT_3DES_KEY2                     010010 00101 rt:5 0000 0000 1000 0010 &cp2
@@ -166,13 +168,27 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_AES_DEC0                      010010 00101 rt:5 0000 0001 0000 1110 &cp2
     CVM_MT_AES_KEYLENGTH                 010010 00101 rt:5 0000 0001 0001 0000 &cp2
     CVM_MT_CRC_IV                        010010 00101 rt:5 0000 0010 0000 0001 &cp2
+    CVM_MT_CRC_WRITE_IV_REFLECT          010010 00101 rt:5 0000 0010 0001 0001 &cp2
+    CVM_MT_CRC_WRITE_BYTE                010010 00101 rt:5 0000 0010 0000 0100 &cp2
+    CVM_MT_CRC_WRITE_HALF                010010 00101 rt:5 0000 0010 0000 0101 &cp2
+    CVM_MT_CRC_WRITE_WORD                010010 00101 rt:5 0000 0010 0000 0110 &cp2
+    CVM_MT_CRC_WRITE_BYTE_REFLECT        010010 00101 rt:5 0000 0010 0001 0100 &cp2
+    CVM_MT_CRC_WRITE_HALF_REFLECT        010010 00101 rt:5 0000 0010 0001 0101 &cp2
+    CVM_MT_CRC_WRITE_WORD_REFLECT        010010 00101 rt:5 0000 0010 0001 0110 &cp2
     CVM_MT_GFM_MUL0                      010010 00101 rt:5 0000 0010 0101 1000 &cp2
     CVM_MT_GFM_MUL1                      010010 00101 rt:5 0000 0010 0101 1001 &cp2
     CVM_MT_GFM_RESINP0                   010010 00101 rt:5 0000 0010 0101 1010 &cp2
     CVM_MT_GFM_RESINP1                   010010 00101 rt:5 0000 0010 0101 1011 &cp2
+    CVM_MT_GFM_XOR0                      010010 00101 rt:5 0000 0010 0101 1100 &cp2
     CVM_MT_GFM_POLY                      010010 00101 rt:5 0000 0010 0101 1110 &cp2
     CVM_MT_CRC_WRITE_LEN                 010010 00101 rt:5 0001 0010 0000 0010 &cp2
+    CVM_MT_CRC_WRITE_DWORD               010010 00101 rt:5 0001 0010 0000 0111 &cp2
+    CVM_MT_CRC_WRITE_VAR                 010010 00101 rt:5 0001 0010 0000 1000 &cp2
+    CVM_MT_CRC_WRITE_DWORD_REFLECT       010010 00101 rt:5 0001 0010 0001 0111 &cp2
+    CVM_MT_CRC_WRITE_VAR_REFLECT         010010 00101 rt:5 0001 0010 0001 1000 &cp2
+    CVM_MT_GFM_XORMUL1_REFLECT           010010 00101 rt:5 0100 0000 0101 1101 &cp2
     CVM_MT_CRC_WRITE_POLYNOMIAL          010010 00101 rt:5 0100 0010 0000 0000 &cp2
     CVM_MT_CRC_WRITE_POLYNOMIAL_REFLECT  010010 00101 rt:5 0100 0010 0001 0000 &cp2
+    CVM_MT_GFM_XORMUL1                   010010 00101 rt:5 0100 0010 0101 1101 &cp2
   ]
 }
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 7a670053c6..ee69c7c652 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -181,6 +181,7 @@ CP2_MF_I64(CVM_MF_GFM_RESINP0, gfm_resinp[0]);
 CP2_MF_I64(CVM_MF_GFM_RESINP1, gfm_resinp[1]);
 CP2_MF_U16(CVM_MF_GFM_POLY, gfm_poly);
 
+CP2_MF_HELPER(CVM_MF_CRC_IV_REFLECT, crc_iv_reflect);
 
 CP2_MT_I64(CVM_MT_HSH_DAT0, hsh_dat[0]);
 CP2_MT_I64(CVM_MT_HSH_DAT1, hsh_dat[1]);
@@ -195,6 +196,7 @@ CP2_MT_I64(CVM_MT_HSH_IV2, hsh_iv[2]);
 CP2_MT_I64(CVM_MT_HSH_IV3, hsh_iv[3]);
 CP2_MT_I64(CVM_MT_GFM_MUL_REFLECT0, gfm_reflect_mul[0]);
 CP2_MT_I64(CVM_MT_GFM_MUL_REFLECT1, gfm_reflect_mul[1]);
+CP2_MT_HELPER(CVM_MT_GFM_XOR0_REFLECT, gfm_xor0_reflect);
 CP2_MT_I64(CVM_MT_3DES_KEY0, des3_key[0]);
 CP2_MT_I64(CVM_MT_3DES_KEY1, des3_key[1]);
 CP2_MT_I64(CVM_MT_3DES_KEY2, des3_key[2]);
@@ -218,11 +220,26 @@ CP2_MT_I64(CVM_MT_GFM_MUL0, gfm_mul[0]);
 CP2_MT_I64(CVM_MT_GFM_MUL1, gfm_mul[1]);
 CP2_MT_I64(CVM_MT_GFM_RESINP0, gfm_resinp[0]);
 CP2_MT_I64(CVM_MT_GFM_RESINP1, gfm_resinp[1]);
+CP2_MT_HELPER(CVM_MT_GFM_XOR0, gfm_xor0);
 CP2_MT_U16(CVM_MT_GFM_POLY, gfm_poly);
 CP2_MT_U8(CVM_MT_CRC_WRITE_LEN, crc_len);
 CP2_MT_U32(CVM_MT_CRC_WRITE_POLYNOMIAL, crc_poly);
 CP2_MT_U32(CVM_MT_CRC_WRITE_POLYNOMIAL_REFLECT, crc_poly);
 
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_IV_REFLECT, crc_write_iv_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_BYTE, crc_write_byte);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_HALF, crc_write_half);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_WORD, crc_write_word);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_BYTE_REFLECT, crc_write_byte_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_HALF_REFLECT, crc_write_half_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_WORD_REFLECT, crc_write_word_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_DWORD, crc_write_dword);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_VAR, crc_write_var);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_DWORD_REFLECT, crc_write_dword_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_VAR_REFLECT, crc_write_var_reflect);
+CP2_MT_HELPER(CVM_MT_GFM_XORMUL1_REFLECT, gfm_xormul1_reflect);
+CP2_MT_HELPER(CVM_MT_GFM_XORMUL1, gfm_xormul1);
+
 static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 {
     TCGv_i64 p;

-- 
2.54.0


