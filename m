Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8054FD42BB5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuZl-0003UZ-D6; Tue, 12 Nov 2024 12:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAuZV-0003Id-Fd
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:20:58 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAuZT-0003je-6D
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:20:56 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-37d5689eea8so3500866f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 09:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731432053; x=1732036853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nVHYeh1YDzWSED7TwW1/YlH+4Ccsrjl+CRCHaxyGxEU=;
 b=NG3FPliJ4ryYo5GMmpe4EsFE+618dosTs/sSJGAyvyM0M/OYPKknPl1PGBbqJp1aER
 0DHTebSd7qJAPNhrA2GNXUQsryar2hd6EsXBmpceKq1HeRyXvD0qBK4APNmQAjQYlBzK
 5p2w+8fiNtG9v9MxSltL3L/O7+wNOXdQDARUJ94ZyFrSuMwo4rrZEK3RSK4eJ+Dt2EUy
 i5DU3PbyzjSrBz0tzpQMYhAeQej5vJSbabw1nAWoL49Ovkl+dclaWWP37PSzgSN9xaOe
 sD0ewtzX2O1jgx7VAGa1k/GaSUfOgaq1eAoUzvc1RdPbSu90EK+GolkvnEV+YN4aZ7ho
 /Lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731432053; x=1732036853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nVHYeh1YDzWSED7TwW1/YlH+4Ccsrjl+CRCHaxyGxEU=;
 b=RnpHy2d6vqcuPOmKP5HNTIAqinBmUQhYFK4cXTrxB61BGI65A3ZrBAHvaiOJY9SEJj
 PD5/pH8N7SxROM037gUF1D6LWcWKOQxXk6NAkE5rFEqHFBjmWWIvztHXOlM0zugsJl5N
 TOeew5IIBq+0iR9caCn+I2onRpm9SE6uohcYoKEXWuD3xwDBbMgklvrPO6AbWlIBNCNR
 iiH1x8hZrnhUkrINu74eGlXyxIXdcGTu7C4y/VJi2AUfcvW12xdzCuH3SLHJR4JNcJyM
 vIWoeJYKeQkpxlNQ3ppyccTfgmPfn6/qyxs/CFqhuZepm3B0WUE0seX03PWY2PWuBVXn
 ujEw==
X-Gm-Message-State: AOJu0Yy2nJwQhEWREGSSGUiTu8889DKiMv1PCIFdkul4bo+6gzlNEuRc
 xFxBJYXLVmIs5cy2Hpdq0PvB5giU4I4V8wX8r2EeaBGeHUewFklCZfpJswC3b9HlfpU8bPj9ySO
 Y
X-Google-Smtp-Source: AGHT+IE6u3sfJEhBBn7cjY0i6tmzDCe85gJ1qP8pY/puTpnUnjdXucYnGZT9hrmiHpf3tSBAZABS5Q==
X-Received: by 2002:a5d:64e5:0:b0:37d:481e:fca with SMTP id
 ffacd0b85a97d-381f186fa0bmr16431218f8f.27.1731432053215; 
 Tue, 12 Nov 2024 09:20:53 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa70a234sm256216705e9.34.2024.11.12.09.20.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 09:20:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 5/6] target/mips: Convert microMIPS LSA opcode to decodetree
Date: Tue, 12 Nov 2024 18:20:21 +0100
Message-ID: <20241112172022.88348-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112172022.88348-1-philmd@linaro.org>
References: <20241112172022.88348-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Simply call the generic gen_lsa(), using the plus_1()
helper to add 1 to the shift amount.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/micromips32.decode        |  8 ++++++++
 target/mips/tcg/micromips_translate.c     | 10 ++++++++++
 target/mips/tcg/micromips_translate.c.inc |  5 -----
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/target/mips/tcg/micromips32.decode b/target/mips/tcg/micromips32.decode
index c115ed2eab..958883ce84 100644
--- a/target/mips/tcg/micromips32.decode
+++ b/target/mips/tcg/micromips32.decode
@@ -7,3 +7,11 @@
 # Reference: MIPS Architecture for Programmers, Volume II-B
 #            microMIPS32 Instruction Set
 #            (Document Number: MD00582)
+
+&r                  rs rt rd sa
+
+%lsa_sa             9:2  !function=plus_1
+
+@lsa                ...... rt:5  rs:5  rd:5  .. ... ......  &r sa=%lsa_sa
+
+LSA                 000000 ..... ..... ..... .. 000 001111  @lsa
diff --git a/target/mips/tcg/micromips_translate.c b/target/mips/tcg/micromips_translate.c
index 49e90e7eca..f0b5dbf655 100644
--- a/target/mips/tcg/micromips_translate.c
+++ b/target/mips/tcg/micromips_translate.c
@@ -9,6 +9,16 @@
 #include "qemu/osdep.h"
 #include "translate.h"
 
+static inline int plus_1(DisasContext *ctx, int x)
+{
+    return x + 1;
+}
+
 /* Include the auto-generated decoders.  */
 #include "decode-micromips16.c.inc"
 #include "decode-micromips32.c.inc"
+
+static bool trans_LSA(DisasContext *ctx, arg_r *a)
+{
+    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
+}
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index e8ec5a0ff2..4b4550872f 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -191,7 +191,6 @@ enum {
     /* The following can be distinguished by their lower 6 bits. */
     BREAK32 = 0x07,
     INS = 0x0c,
-    LSA = 0x0f,
     ALIGN = 0x1f,
     EXT = 0x2c,
     POOL32AXF = 0x3c,
@@ -1793,10 +1792,6 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
         case INS:
             gen_bitops(ctx, OPC_INS, rt, rs, rr, rd);
             return;
-        case LSA:
-            check_insn(ctx, ISA_MIPS_R6);
-            gen_lsa(ctx, rd, rt, rs, extract32(ctx->opcode, 9, 2) + 1);
-            break;
         case ALIGN:
             check_insn(ctx, ISA_MIPS_R6);
             gen_align(ctx, 32, rd, rs, rt, extract32(ctx->opcode, 9, 2));
-- 
2.45.2


