Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F66CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ7nF-0000JI-4S; Thu, 21 May 2026 14:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7n4-0000Gx-E3
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:38 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7n1-000265-NV
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:37 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dcd17e19b6so3691234a34.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779386795; x=1779991595; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3W8L3d1jgTNrLin8Af2Qsvt1R+EvdZP5sJcQl4W1RO0=;
 b=AxMI+XYSlcHXIboJlujbnHW7p/dfScK33SCoTp+WMLzAZ6lusuFCb52hJnnW24ZoKd
 BfQ/eAeuwGysVOClJ0mFaWV+srZBHzDCWUKkqtwRQkhMiCHLzFNZdSESAvg0y6rMeYZv
 ZDM0ylJpK8mITD5V+sePba1MtFT+fCkMlyAdNwdW6yYCgYzbFTIcJgNZAQQriMoIksfg
 AZWvx9bc2BqIZhGuE6yLUs2zpMnHh/lfg64QoWl263C6NUeo93PhOeZ0QDLa1pMWAZKb
 tGRkF5+7wG48h3zp+tK4Eoy/2BOp/CNbk/hm01hWs4cBlU7x0+6fLoiy2HTnHiPOFLgv
 6Rjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386795; x=1779991595;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3W8L3d1jgTNrLin8Af2Qsvt1R+EvdZP5sJcQl4W1RO0=;
 b=rQTzN1aATG/XVnG9nNFll2zJojUo641nJ/bDsyCI0wnE5XejbmGt95SfnikEgPgQbS
 5wUTykNWs5d84L89co4odgpVKhjhQm6rfhzOMS0Z9oiD0HOFscfMkFSKhlA/4KMBAx1C
 nvP2Ck0c62iKZ8oTc7msThxYpgu99fUICU5/c8dWT8Ks3TsEmt5cFS+Vv/uWe1HtC5SS
 crg2/dNfYJpetXj1oHdZ5JU5dbUaE/SfRVUjQHL0rds6+MF60DtAFjIzTE8Z+axQu6gQ
 eJbKxThjEu7A+vtXmfZ40PkQoNLPq68xqZOrKsrReu2cxydlzxoOjJB7SphkQYPZK7gr
 6Weg==
X-Gm-Message-State: AOJu0Ywt5Hljps4TeeJuCZA1ITf4L9S1d2iUGqxWosarE42fp4anJTOQ
 rT5poGEYYnnXl5YrFm/wFntiXeGHjSW2DX0plHrihNdmEj9y4pdHS1/P
X-Gm-Gg: Acq92OF1QsJ7SnN/llMgFYp7v71/oVOMoar2gjzbt6Q3sVHgvy+9ijqdo82HTdHq7vI
 Ln3Wqjkh04LD7YYcZOkswsPBTjhrPlaYF4rtojiiUsQjdlZHqfH5iMH5VmRQOxZRzGHN/q5Vraz
 Z0V6+/Q9Eajv6qiseYELLJda/BetmVrgDPtn+IXoTRA1SB1Xma2s8VyWLNBOrb9aAv26JW7j9yo
 2xUp80oXufaa7ntKEZfDANwI3bRE3xzz5hF7AxOxQKv+LePiyxcy6fS6+5EE8n6nOyImyQLOjSG
 9P+a0qvRA0V0m1YY3AcCaO2C1YQDaRRSeJQMDIt9j1XwUqA3x6TPj6mnYPu24mEBx/iTiu56lCy
 GmVZ2ZYO/AOA1B9UaU3rBgfAkmtieJaCNV4xmtojKhHh1RaQZYBBh/rATamM4hDiiABPbv/0FwO
 jW779z/spUh1gqVzPq66C+jrdHhBTIZ8xprFzs6jNXo+R1e4fXkvw7WfT2DCcFKp6zvFBTFFmaE
 zgfzWkB7rLp+uZB4DhXS2y/b5kJfuwQy1NSONZ8Stym4yx6nFTixBffyL67fbQUlSSr
X-Received: by 2002:a05:6830:82fc:b0:7e3:fa27:c176 with SMTP id
 46e09a7af769-7e5feecbb2bmr138517a34.16.1779386794585; 
 Thu, 21 May 2026 11:06:34 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e5f6ee286fsm903089a34.25.2026.05.21.11.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:06:34 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 12:06:10 -0600
Subject: [PATCH v13 17/22] target/mips: decode Octeon HSH and SHA3 COP2
 selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v13-17-5a4cb8ec9cd3@gmail.com>
References: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x330.google.com
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
HSH shared-window selectors and SHA3 operation selectors. These paths
need helper calls because HSH/SHA3 selectors alias the architectural hash
register window and operation selectors have visible side effects.

Keep HSH/SHA3 decode separate from direct register transfers because the
shared hash-window aliases require helper-mediated state updates.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v10 -> v13:
  - Keep this patch limited to HSH/SHA3 selector additions; CRC/GFM
    selector finalization stays in the CRC/GFM selector patch.
  - Name the 0x0057 SDK compatibility selector as STARTSHA1_COMPAT and
    document why it is kept despite not appearing in the public manuals.

Changes v9 -> v10:
  - Split HSH/SHA3 selector decode out of the monolithic Octeon COP2
    selector decode patch.
  - Reworked the shared HSH/SHA3 register-window transfers around the
    architectural hash state instead of DATW/IVW shadow state.
---
 target/mips/tcg/octeon.decode      | 77 ++++++++++++++++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c | 77 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 4809f74a86..31c857fa89 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -106,6 +106,7 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MF_HSH_IV1                       010010 00001 rt:5 0000 0000 0100 1001 &cp2
     CVM_MF_HSH_IV2                       010010 00001 rt:5 0000 0000 0100 1010 &cp2
     CVM_MF_HSH_IV3                       010010 00001 rt:5 0000 0000 0100 1011 &cp2
+    CVM_MF_SHA3_DAT24                    010010 00001 rt:5 0000 0000 0101 0000 &cp2
     CVM_MF_3DES_KEY0                     010010 00001 rt:5 0000 0000 1000 0000 &cp2
     CVM_MF_3DES_KEY1                     010010 00001 rt:5 0000 0000 1000 0001 &cp2
     CVM_MF_3DES_KEY2                     010010 00001 rt:5 0000 0000 1000 0010 &cp2
@@ -130,6 +131,30 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MF_GFM_MUL_REFLECT1              010010 00001 rt:5 0000 0000 0101 1001 &cp2
     CVM_MF_GFM_RESINP_REFLECT0           010010 00001 rt:5 0000 0000 0101 1010 &cp2
     CVM_MF_GFM_RESINP_REFLECT1           010010 00001 rt:5 0000 0000 0101 1011 &cp2
+    CVM_MF_HSH_DATW0                     010010 00001 rt:5 0000 0010 0100 0000 &cp2
+    CVM_MF_HSH_DATW1                     010010 00001 rt:5 0000 0010 0100 0001 &cp2
+    CVM_MF_HSH_DATW2                     010010 00001 rt:5 0000 0010 0100 0010 &cp2
+    CVM_MF_HSH_DATW3                     010010 00001 rt:5 0000 0010 0100 0011 &cp2
+    CVM_MF_HSH_DATW4                     010010 00001 rt:5 0000 0010 0100 0100 &cp2
+    CVM_MF_HSH_DATW5                     010010 00001 rt:5 0000 0010 0100 0101 &cp2
+    CVM_MF_HSH_DATW6                     010010 00001 rt:5 0000 0010 0100 0110 &cp2
+    CVM_MF_HSH_DATW7                     010010 00001 rt:5 0000 0010 0100 0111 &cp2
+    CVM_MF_HSH_DATW8                     010010 00001 rt:5 0000 0010 0100 1000 &cp2
+    CVM_MF_HSH_DATW9                     010010 00001 rt:5 0000 0010 0100 1001 &cp2
+    CVM_MF_HSH_DATW10                    010010 00001 rt:5 0000 0010 0100 1010 &cp2
+    CVM_MF_HSH_DATW11                    010010 00001 rt:5 0000 0010 0100 1011 &cp2
+    CVM_MF_HSH_DATW12                    010010 00001 rt:5 0000 0010 0100 1100 &cp2
+    CVM_MF_HSH_DATW13                    010010 00001 rt:5 0000 0010 0100 1101 &cp2
+    CVM_MF_HSH_DATW14                    010010 00001 rt:5 0000 0010 0100 1110 &cp2
+    CVM_MF_HSH_DATW15                    010010 00001 rt:5 0000 0010 0100 1111 &cp2
+    CVM_MF_HSH_IVW0                      010010 00001 rt:5 0000 0010 0101 0000 &cp2
+    CVM_MF_HSH_IVW1                      010010 00001 rt:5 0000 0010 0101 0001 &cp2
+    CVM_MF_HSH_IVW2                      010010 00001 rt:5 0000 0010 0101 0010 &cp2
+    CVM_MF_HSH_IVW3                      010010 00001 rt:5 0000 0010 0101 0011 &cp2
+    CVM_MF_HSH_IVW4                      010010 00001 rt:5 0000 0010 0101 0100 &cp2
+    CVM_MF_HSH_IVW5                      010010 00001 rt:5 0000 0010 0101 0101 &cp2
+    CVM_MF_HSH_IVW6                      010010 00001 rt:5 0000 0010 0101 0110 &cp2
+    CVM_MF_HSH_IVW7                      010010 00001 rt:5 0000 0010 0101 0111 &cp2
     CVM_MF_GFM_MUL0                      010010 00001 rt:5 0000 0010 0101 1000 &cp2
     CVM_MF_GFM_MUL1                      010010 00001 rt:5 0000 0010 0101 1001 &cp2
     CVM_MF_GFM_RESINP0                   010010 00001 rt:5 0000 0010 0101 1010 &cp2
@@ -146,6 +171,10 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_HSH_IV1                       010010 00101 rt:5 0000 0000 0100 1001 &cp2
     CVM_MT_HSH_IV2                       010010 00101 rt:5 0000 0000 0100 1010 &cp2
     CVM_MT_HSH_IV3                       010010 00101 rt:5 0000 0000 0100 1011 &cp2
+    CVM_MT_SHA3_DAT24                    010010 00101 rt:5 0000 0000 0101 0000 &cp2
+    CVM_MT_SHA3_DAT15                    010010 00101 rt:5 0000 0000 0101 0001 &cp2
+    # Cavium SDK code uses 0x0057 as a STARTSHA1 compatibility alias.
+    CVM_MT_HSH_STARTSHA1_COMPAT          010010 00101 rt:5 0000 0000 0101 0111 &cp2
     CVM_MT_GFM_MUL_REFLECT0              010010 00101 rt:5 0000 0000 0101 1000 &cp2
     CVM_MT_GFM_MUL_REFLECT1              010010 00101 rt:5 0000 0000 0101 1001 &cp2
     CVM_MT_GFM_XOR0_REFLECT              010010 00101 rt:5 0000 0000 0101 1100 &cp2
@@ -175,19 +204,67 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_CRC_BYTE_REFLECT              010010 00101 rt:5 0000 0010 0001 0100 &cp2
     CVM_MT_CRC_HALF_REFLECT              010010 00101 rt:5 0000 0010 0001 0101 &cp2
     CVM_MT_CRC_WORD_REFLECT              010010 00101 rt:5 0000 0010 0001 0110 &cp2
+    CVM_MT_HSH_DATW0                     010010 00101 rt:5 0000 0010 0100 0000 &cp2
+    CVM_MT_HSH_DATW1                     010010 00101 rt:5 0000 0010 0100 0001 &cp2
+    CVM_MT_HSH_DATW2                     010010 00101 rt:5 0000 0010 0100 0010 &cp2
+    CVM_MT_HSH_DATW3                     010010 00101 rt:5 0000 0010 0100 0011 &cp2
+    CVM_MT_HSH_DATW4                     010010 00101 rt:5 0000 0010 0100 0100 &cp2
+    CVM_MT_HSH_DATW5                     010010 00101 rt:5 0000 0010 0100 0101 &cp2
+    CVM_MT_HSH_DATW6                     010010 00101 rt:5 0000 0010 0100 0110 &cp2
+    CVM_MT_HSH_DATW7                     010010 00101 rt:5 0000 0010 0100 0111 &cp2
+    CVM_MT_HSH_DATW8                     010010 00101 rt:5 0000 0010 0100 1000 &cp2
+    CVM_MT_HSH_DATW9                     010010 00101 rt:5 0000 0010 0100 1001 &cp2
+    CVM_MT_HSH_DATW10                    010010 00101 rt:5 0000 0010 0100 1010 &cp2
+    CVM_MT_HSH_DATW11                    010010 00101 rt:5 0000 0010 0100 1011 &cp2
+    CVM_MT_HSH_DATW12                    010010 00101 rt:5 0000 0010 0100 1100 &cp2
+    CVM_MT_HSH_DATW13                    010010 00101 rt:5 0000 0010 0100 1101 &cp2
+    CVM_MT_HSH_DATW14                    010010 00101 rt:5 0000 0010 0100 1110 &cp2
+    CVM_MT_HSH_DATW15                    010010 00101 rt:5 0000 0010 0100 1111 &cp2
+    CVM_MT_HSH_IVW0                      010010 00101 rt:5 0000 0010 0101 0000 &cp2
+    CVM_MT_HSH_IVW1                      010010 00101 rt:5 0000 0010 0101 0001 &cp2
+    CVM_MT_HSH_IVW2                      010010 00101 rt:5 0000 0010 0101 0010 &cp2
+    CVM_MT_HSH_IVW3                      010010 00101 rt:5 0000 0010 0101 0011 &cp2
+    CVM_MT_HSH_IVW4                      010010 00101 rt:5 0000 0010 0101 0100 &cp2
+    CVM_MT_HSH_IVW5                      010010 00101 rt:5 0000 0010 0101 0101 &cp2
+    CVM_MT_HSH_IVW6                      010010 00101 rt:5 0000 0010 0101 0110 &cp2
+    CVM_MT_HSH_IVW7                      010010 00101 rt:5 0000 0010 0101 0111 &cp2
     CVM_MT_GFM_MUL0                      010010 00101 rt:5 0000 0010 0101 1000 &cp2
     CVM_MT_GFM_MUL1                      010010 00101 rt:5 0000 0010 0101 1001 &cp2
     CVM_MT_GFM_RESINP0                   010010 00101 rt:5 0000 0010 0101 1010 &cp2
     CVM_MT_GFM_RESINP1                   010010 00101 rt:5 0000 0010 0101 1011 &cp2
+    CVM_MT_GFM_XOR0                      010010 00101 rt:5 0000 0010 0101 1100 &cp2
     CVM_MT_GFM_POLY                      010010 00101 rt:5 0000 0010 0101 1110 &cp2
+    CVM_MT_SHA3_XORDAT0                  010010 00101 rt:5 0000 0010 1100 0000 &cp2
+    CVM_MT_SHA3_XORDAT1                  010010 00101 rt:5 0000 0010 1100 0001 &cp2
+    CVM_MT_SHA3_XORDAT2                  010010 00101 rt:5 0000 0010 1100 0010 &cp2
+    CVM_MT_SHA3_XORDAT3                  010010 00101 rt:5 0000 0010 1100 0011 &cp2
+    CVM_MT_SHA3_XORDAT4                  010010 00101 rt:5 0000 0010 1100 0100 &cp2
+    CVM_MT_SHA3_XORDAT5                  010010 00101 rt:5 0000 0010 1100 0101 &cp2
+    CVM_MT_SHA3_XORDAT6                  010010 00101 rt:5 0000 0010 1100 0110 &cp2
+    CVM_MT_SHA3_XORDAT7                  010010 00101 rt:5 0000 0010 1100 0111 &cp2
+    CVM_MT_SHA3_XORDAT8                  010010 00101 rt:5 0000 0010 1100 1000 &cp2
+    CVM_MT_SHA3_XORDAT9                  010010 00101 rt:5 0000 0010 1100 1001 &cp2
+    CVM_MT_SHA3_XORDAT10                 010010 00101 rt:5 0000 0010 1100 1010 &cp2
+    CVM_MT_SHA3_XORDAT11                 010010 00101 rt:5 0000 0010 1100 1011 &cp2
+    CVM_MT_SHA3_XORDAT12                 010010 00101 rt:5 0000 0010 1100 1100 &cp2
+    CVM_MT_SHA3_XORDAT13                 010010 00101 rt:5 0000 0010 1100 1101 &cp2
+    CVM_MT_SHA3_XORDAT14                 010010 00101 rt:5 0000 0010 1100 1110 &cp2
+    CVM_MT_SHA3_XORDAT15                 010010 00101 rt:5 0000 0010 1100 1111 &cp2
+    CVM_MT_SHA3_XORDAT16                 010010 00101 rt:5 0000 0010 1101 0000 &cp2
+    CVM_MT_SHA3_XORDAT17                 010010 00101 rt:5 0000 0010 1101 0001 &cp2
     CVM_MT_CRC_LEN                       010010 00101 rt:5 0001 0010 0000 0010 &cp2
     CVM_MT_CRC_DWORD                     010010 00101 rt:5 0001 0010 0000 0111 &cp2
     CVM_MT_CRC_VAR                       010010 00101 rt:5 0001 0010 0000 1000 &cp2
     CVM_MT_CRC_DWORD_REFLECT             010010 00101 rt:5 0001 0010 0001 0111 &cp2
     CVM_MT_CRC_VAR_REFLECT               010010 00101 rt:5 0001 0010 0001 1000 &cp2
+    CVM_MT_HSH_STARTMD5                  010010 00101 rt:5 0100 0000 0100 0111 &cp2
+    CVM_MT_HSH_STARTSHA256               010010 00101 rt:5 0100 0000 0100 1111 &cp2
+    CVM_MT_SHA3_STARTOP                  010010 00101 rt:5 0100 0000 0101 0010 &cp2
+    CVM_MT_HSH_STARTSHA                  010010 00101 rt:5 0100 0000 0101 0111 &cp2
     CVM_MT_GFM_XORMUL1_REFLECT           010010 00101 rt:5 0100 0000 0101 1101 &cp2
     CVM_MT_CRC_POLYNOMIAL                010010 00101 rt:5 0100 0010 0000 0000 &cp2
     CVM_MT_CRC_POLYNOMIAL_REFLECT        010010 00101 rt:5 0100 0010 0001 0000 &cp2
+    CVM_MT_HSH_STARTSHA512               010010 00101 rt:5 0100 0010 0100 1111 &cp2
     CVM_MT_GFM_XORMUL1                   010010 00101 rt:5 0100 0010 0101 1101 &cp2
   ]
 }
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 8c58bc7007..e975774332 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -181,10 +181,35 @@ CP2_MF_I64(CVM_MF_GFM_RESINP1, gfm_resinp[1]);
 CP2_MF_U16(CVM_MF_GFM_POLY, gfm_poly);
 
 CP2_MF_HELPER(CVM_MF_CRC_IV_REFLECT, crc_iv_reflect);
+CP2_MF_HELPER(CVM_MF_SHA3_DAT24, sha3_dat24);
 CP2_MF_HELPER(CVM_MF_GFM_MUL_REFLECT0, gfm_mul_reflect0);
 CP2_MF_HELPER(CVM_MF_GFM_MUL_REFLECT1, gfm_mul_reflect1);
 CP2_MF_HELPER(CVM_MF_GFM_RESINP_REFLECT0, gfm_resinp_reflect0);
 CP2_MF_HELPER(CVM_MF_GFM_RESINP_REFLECT1, gfm_resinp_reflect1);
+CP2_MF_I64(CVM_MF_HSH_DATW0, hsh_dat[0]);
+CP2_MF_I64(CVM_MF_HSH_DATW1, hsh_dat[1]);
+CP2_MF_I64(CVM_MF_HSH_DATW2, hsh_dat[2]);
+CP2_MF_I64(CVM_MF_HSH_DATW3, hsh_dat[3]);
+CP2_MF_I64(CVM_MF_HSH_DATW4, hsh_dat[4]);
+CP2_MF_I64(CVM_MF_HSH_DATW5, hsh_dat[5]);
+CP2_MF_I64(CVM_MF_HSH_DATW6, hsh_dat[6]);
+CP2_MF_I64(CVM_MF_HSH_DATW7, hsh_dat[7]);
+CP2_MF_I64(CVM_MF_HSH_DATW8, hsh_dat[8]);
+CP2_MF_I64(CVM_MF_HSH_DATW9, hsh_dat[9]);
+CP2_MF_I64(CVM_MF_HSH_DATW10, hsh_dat[10]);
+CP2_MF_I64(CVM_MF_HSH_DATW11, hsh_dat[11]);
+CP2_MF_I64(CVM_MF_HSH_DATW12, hsh_dat[12]);
+CP2_MF_I64(CVM_MF_HSH_DATW13, hsh_dat[13]);
+CP2_MF_I64(CVM_MF_HSH_DATW14, hsh_dat[14]);
+CP2_MF_I64(CVM_MF_HSH_DATW15, hsh_dat[15]);
+CP2_MF_I64(CVM_MF_HSH_IVW0, hsh_iv[0]);
+CP2_MF_I64(CVM_MF_HSH_IVW1, hsh_iv[1]);
+CP2_MF_I64(CVM_MF_HSH_IVW2, hsh_iv[2]);
+CP2_MF_I64(CVM_MF_HSH_IVW3, hsh_iv[3]);
+CP2_MF_I64(CVM_MF_HSH_IVW4, hsh_iv[4]);
+CP2_MF_I64(CVM_MF_HSH_IVW5, hsh_iv[5]);
+CP2_MF_I64(CVM_MF_HSH_IVW6, hsh_iv[6]);
+CP2_MF_I64(CVM_MF_HSH_IVW7, hsh_iv[7]);
 
 CP2_MT_I64(CVM_MT_HSH_DAT0, hsh_dat[0]);
 CP2_MT_I64(CVM_MT_HSH_DAT1, hsh_dat[1]);
@@ -223,11 +248,13 @@ CP2_MT_I64(CVM_MT_GFM_MUL0, gfm_mul[0]);
 CP2_MT_I64(CVM_MT_GFM_MUL1, gfm_mul[1]);
 CP2_MT_I64(CVM_MT_GFM_RESINP0, gfm_resinp[0]);
 CP2_MT_I64(CVM_MT_GFM_RESINP1, gfm_resinp[1]);
+CP2_MT_HELPER(CVM_MT_GFM_XOR0, gfm_xor0);
 CP2_MT_U16(CVM_MT_GFM_POLY, gfm_poly);
 CP2_MT_U8_MASKED(CVM_MT_CRC_LEN, crc_len, 0xf);
 CP2_MT_U32(CVM_MT_CRC_POLYNOMIAL, crc_poly);
 
 CP2_MT_HELPER(CVM_MT_CRC_POLYNOMIAL_REFLECT, crc_write_polynomial_reflect);
+
 CP2_MT_HELPER(CVM_MT_CRC_IV_REFLECT, crc_write_iv_reflect);
 CP2_MT_HELPER(CVM_MT_CRC_BYTE, crc_write_byte);
 CP2_MT_HELPER(CVM_MT_CRC_HALF, crc_write_half);
@@ -241,6 +268,56 @@ CP2_MT_HELPER(CVM_MT_CRC_DWORD_REFLECT, crc_write_dword_reflect);
 CP2_MT_HELPER(CVM_MT_CRC_VAR_REFLECT, crc_write_var_reflect);
 CP2_MT_HELPER(CVM_MT_GFM_XORMUL1_REFLECT, gfm_xormul1_reflect);
 CP2_MT_HELPER(CVM_MT_GFM_XORMUL1, gfm_xormul1);
+CP2_MT_HELPER(CVM_MT_SHA3_DAT24, sha3_dat24);
+CP2_MT_HELPER(CVM_MT_SHA3_DAT15, sha3_dat15);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT0, sha3_xordat0);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT1, sha3_xordat1);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT2, sha3_xordat2);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT3, sha3_xordat3);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT4, sha3_xordat4);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT5, sha3_xordat5);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT6, sha3_xordat6);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT7, sha3_xordat7);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT8, sha3_xordat8);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT9, sha3_xordat9);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT10, sha3_xordat10);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT11, sha3_xordat11);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT12, sha3_xordat12);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT13, sha3_xordat13);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT14, sha3_xordat14);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT15, sha3_xordat15);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT16, sha3_xordat16);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT17, sha3_xordat17);
+CP2_MT_HELPER(CVM_MT_SHA3_STARTOP, sha3_startop);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA1_COMPAT, hsh_startsha1_compat);
+CP2_MT_I64(CVM_MT_HSH_DATW0, hsh_dat[0]);
+CP2_MT_I64(CVM_MT_HSH_DATW1, hsh_dat[1]);
+CP2_MT_I64(CVM_MT_HSH_DATW2, hsh_dat[2]);
+CP2_MT_I64(CVM_MT_HSH_DATW3, hsh_dat[3]);
+CP2_MT_I64(CVM_MT_HSH_DATW4, hsh_dat[4]);
+CP2_MT_I64(CVM_MT_HSH_DATW5, hsh_dat[5]);
+CP2_MT_I64(CVM_MT_HSH_DATW6, hsh_dat[6]);
+CP2_MT_I64(CVM_MT_HSH_DATW7, hsh_dat[7]);
+CP2_MT_I64(CVM_MT_HSH_DATW8, hsh_dat[8]);
+CP2_MT_I64(CVM_MT_HSH_DATW9, hsh_dat[9]);
+CP2_MT_I64(CVM_MT_HSH_DATW10, hsh_dat[10]);
+CP2_MT_I64(CVM_MT_HSH_DATW11, hsh_dat[11]);
+CP2_MT_I64(CVM_MT_HSH_DATW12, hsh_dat[12]);
+CP2_MT_I64(CVM_MT_HSH_DATW13, hsh_dat[13]);
+CP2_MT_I64(CVM_MT_HSH_DATW14, hsh_dat[14]);
+CP2_MT_I64(CVM_MT_HSH_DATW15, hsh_dat[15]);
+CP2_MT_I64(CVM_MT_HSH_IVW0, hsh_iv[0]);
+CP2_MT_I64(CVM_MT_HSH_IVW1, hsh_iv[1]);
+CP2_MT_I64(CVM_MT_HSH_IVW2, hsh_iv[2]);
+CP2_MT_I64(CVM_MT_HSH_IVW3, hsh_iv[3]);
+CP2_MT_I64(CVM_MT_HSH_IVW4, hsh_iv[4]);
+CP2_MT_I64(CVM_MT_HSH_IVW5, hsh_iv[5]);
+CP2_MT_I64(CVM_MT_HSH_IVW6, hsh_iv[6]);
+CP2_MT_I64(CVM_MT_HSH_IVW7, hsh_iv[7]);
+CP2_MT_HELPER(CVM_MT_HSH_STARTMD5, hsh_startmd5);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA256, hsh_startsha256);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA, hsh_startsha);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA512, hsh_startsha512);
 
 static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 {

-- 
2.54.0


