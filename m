Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC4DD3B98F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFw96-0005QV-QZ; Tue, 26 Nov 2024 09:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw8Z-0004P7-HS
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:01:57 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw8X-0005S7-7W
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:01:55 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3824446d2bcso5019777f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629711; x=1733234511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3fOe9GoFLYt+HQ4wA9ZmjXBnKqHxlAaym1zhWSkKtJ8=;
 b=YWIILNZgbCqifq/W4ZXc2h0oWDrvOHOAAaOOLd92wgVmRTCoSUp/Mx2vQpJOieURfC
 /k8WF0hm91+I9dcKGDni0ekJxgFPXXOUMx5fa5yNPk80/viUmv5jPmHJh+nHQiIW+ep1
 WHE+MHcoLjtGc9Lfp/n/N/syu5SAGHJ26b6GscVEelYdfLvU1Wn0DvwHJmA788gqvnfn
 rzv9SLKnf8Y4fYlMMvZXJIbsG4uhg9j9DOgbxGZQeuqERxW1C9XKK0M1Zbzp/g2NNd5P
 ChmF2Vg4cluk8vg7ls4m59kJqofoARpQALLOc9VLEGDvc5inINaIoTBcuwf1zgf3qiUx
 fuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629711; x=1733234511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3fOe9GoFLYt+HQ4wA9ZmjXBnKqHxlAaym1zhWSkKtJ8=;
 b=nCEkrm8u+BKNm10cuRRS+5V4m5RR3jbkGDZePc1rdIrgbE9LckVt5akyA5fX+dwAAp
 lp4BCMLycd5XK/yrtmUwsNsZpk1rhMsNxGSeho0NAIWgO3ljPBqB1ZBNywXF5dT4crMd
 lTx9cg6Uq73dgGJ4L0Mx4UEWAQ62GLHrdsDArbH+/hAe7yV5apcManlb42aYOW6A/JSZ
 wj1pLscCrR2nLyrXsMZCNHdGlLrwh8ei2ZF3eysshiukckX7D54aVGSx5zzp3CMZcJW3
 qG7bOQET/Eq/3+xEH7JVP+PG33FOL5MTkXeK5L/RsyhZQi9rMPEJ0MKWMJiZySe11CcW
 GyoA==
X-Gm-Message-State: AOJu0YyxPvKKmW3VO54CADrPASVyga8qLOHz6etOP28uC8tc14qbEtPn
 P0SLFQFrgskPPkHOYc2NFWoyO7BiN0S92L2zI824L6RmblK529wJxGy4JryQHLEyDSXI92tAEnL
 i
X-Gm-Gg: ASbGnct19TcyxvQM3pekdq31EtMhK/Tyd0opZOPXbQxtcNCIHqVn+M+49wFfUfvnRJs
 z1gJKkZqfq/wDEiEuWfB1OfDN0Vgmcjb0NZWHo/2Q3D5D8WJBoqADnbcdNDJEfwNATo9/5OVfco
 uKN/J4yd64RE2GvKyTXpq5Y0URZYxjIDm2STxF0z1Eiz7jXJFr3X/1wNoae4XB7UwEuzroPU2j2
 laPZH+LgH8csw99vDgnrnKM4t5uszcUA34YAhbXbU9Lq9G6TwhB+TLS4znINKcZybdyItCi
X-Google-Smtp-Source: AGHT+IFmxZqo1TagrKfzLiCQauCNGTlVVBBvGSi7Nstc+sWljnw+LpWDb+OtkrqitwvQzWIGzlME8w==
X-Received: by 2002:a05:6000:184d:b0:382:465f:336d with SMTP id
 ffacd0b85a97d-38260b3cabbmr19463595f8f.1.1732629708695; 
 Tue, 26 Nov 2024 06:01:48 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbedfccsm13310438f8f.101.2024.11.26.06.01.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 06:01:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 15/16] target/mips: Convert MIPS16e LI opcodes to decodetree
Date: Tue, 26 Nov 2024 15:00:01 +0100
Message-ID: <20241126140003.74871-16-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126140003.74871-1-philmd@linaro.org>
References: <20241126140003.74871-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Decode the destination register using the xlat() helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mips16e_16.decode       |  8 ++++++++
 target/mips/tcg/mips16e_32.decode       |  9 +++++++++
 target/mips/tcg/mips16e_translate.c     | 14 ++++++++++++++
 target/mips/tcg/mips16e_translate.c.inc | 11 -----------
 4 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/target/mips/tcg/mips16e_16.decode b/target/mips/tcg/mips16e_16.decode
index 82586493f68..bae7bfbb522 100644
--- a/target/mips/tcg/mips16e_16.decode
+++ b/target/mips/tcg/mips16e_16.decode
@@ -7,3 +7,11 @@
 # Reference: MIPS Architecture for Programmers, Volume IV-a
 #            The MIPS16e Application Specific Extension
 #            (Document Number: MD00076)
+
+&rd_imm         rd imm
+
+%xlat_rx8       8:3  !function=xlat
+
+@ri             ..... ... imm:8             &rd_imm   rd=%xlat_rx8
+
+LI              01101 ... ........          @ri
diff --git a/target/mips/tcg/mips16e_32.decode b/target/mips/tcg/mips16e_32.decode
index fc429049e18..248ee95706d 100644
--- a/target/mips/tcg/mips16e_32.decode
+++ b/target/mips/tcg/mips16e_32.decode
@@ -7,3 +7,12 @@
 # Reference: MIPS Architecture for Programmers, Volume IV-a
 #            The MIPS16e Application Specific Extension
 #            (Document Number: MD00076)
+
+&rd_imm         rd imm                                          !extern
+
+%immx           0:5 21:6 16:5
+%xlat_rx8       8:3  !function=xlat
+
+@ri             ..... ...... ..... ..... ... ... .....          &rd_imm rd=%xlat_rx8 imm=%immx
+
+LI              11110 ...... ..... 01101 ... 000 .....          @ri
diff --git a/target/mips/tcg/mips16e_translate.c b/target/mips/tcg/mips16e_translate.c
index 6de9928b37e..a66f49fe8ed 100644
--- a/target/mips/tcg/mips16e_translate.c
+++ b/target/mips/tcg/mips16e_translate.c
@@ -9,6 +9,20 @@
 #include "qemu/osdep.h"
 #include "translate.h"
 
+static inline int xlat(DisasContext *ctx, int x)
+{
+  static const int map[8] = { 16, 17, 2, 3, 4, 5, 6, 7 };
+
+  return map[x];
+}
+
 /* Include the auto-generated decoders.  */
 #include "decode-mips16e_16.c.inc"
 #include "decode-mips16e_32.c.inc"
+
+static bool trans_LI(DisasContext *ctx, arg_rd_imm *a)
+{
+    gen_li(ctx, a->rd, a->imm);
+
+    return true;
+}
diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index a57ae4e95b1..f3f09b164ae 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -24,7 +24,6 @@ enum {
   M16_OPC_SLTI = 0x0a,
   M16_OPC_SLTIU = 0x0b,
   M16_OPC_I8 = 0x0c,
-  M16_OPC_LI = 0x0d,
   M16_OPC_CMPI = 0x0e,
   M16_OPC_SD = 0x0f,
   M16_OPC_LB = 0x10,
@@ -582,9 +581,6 @@ static int decode_extended_mips16_opc(CPUMIPSState *env, DisasContext *ctx)
             break;
         }
         break;
-    case M16_OPC_LI:
-        tcg_gen_movi_tl(cpu_gpr[rx], (uint16_t) imm);
-        break;
     case M16_OPC_CMPI:
         tcg_gen_xori_tl(cpu_gpr[24], cpu_gpr[rx], (uint16_t) imm);
         break;
@@ -839,13 +835,6 @@ static int decode_ase_mips16e(CPUMIPSState *env, DisasContext *ctx)
             }
         }
         break;
-    case M16_OPC_LI:
-        {
-            int16_t imm = (uint8_t) ctx->opcode;
-
-            gen_arith_imm(ctx, OPC_ADDIU, rx, 0, imm);
-        }
-        break;
     case M16_OPC_CMPI:
         {
             int16_t imm = (uint8_t) ctx->opcode;
-- 
2.45.2


