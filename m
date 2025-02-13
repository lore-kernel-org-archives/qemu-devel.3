Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548F4C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiaeg-00066c-74; Thu, 13 Feb 2025 09:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tiaeX-00062N-IY
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:57:22 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tiaeU-0003k4-5q
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:57:21 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21f92258aa6so25048845ad.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 06:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739458636; x=1740063436;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xmNcB0h8FvwC5Sw/FgDlp5/VO2PWTeM+sjfDIwJaVLI=;
 b=rqAjc1+xOT3Igxq7Oo/Wnu2ZOTDh9PrGPU8GeD2iKrVS76jj7wXRuxoXCcgZZ3ZQX8
 ej8/yL8XRT9kgPtinBhaHDCbtskG0ZjO4HE01/2f2duBL7jHy6a4+iNSu7in0qUf19N8
 dwU4IS+yBQUm1dIF4Bx4ny58kUHc5R8XrVY6TvPRqoteVyjFjjk3wPq3+utyqpx051kO
 VCsB7cwptAJUr7WbCrONYiwB0yO7f81mnbA/0WwudVh4qSJLsRofpikq6iLUiiWC2Gvx
 LUgm0A/SxJlJ1BGlEv1bXZT55eNkpq4FRevMSXQIQlJNeSky2p00RJnzhiteIo5Wrd6W
 atXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739458636; x=1740063436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xmNcB0h8FvwC5Sw/FgDlp5/VO2PWTeM+sjfDIwJaVLI=;
 b=rwQU6CUme7Yo7pWLGokMz+N1B0wXNdoVAgL1TtjL33Ai7NkcgiFilhox/oT5vPu5MC
 UkxeoJW8BF5wpMehXNwwGPdZAu5Dt3ZvV4yzRw41Bsa36rAKNR9ErbAa3LQKkoKDm9UQ
 Pf9BCqOLaQXPw+6m1QPmxhHSj9aP1uDTX1G9J6AVNQa0ZgiSrKvGbZ4FuJu9o+pAH2kg
 6NM3HgUCgOZHpm+Pzzs8M9v7iOPWFUwZXVMmcwJa841hvYrPr6TucqEDo9b2XdUNGAfI
 OgrEqBHkFbfjYs+soxUcp6TVHzkzAnjzRFaHEAqYiSimEDKSDaKdzqugi857zEo1njLH
 D4Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTu3VrOyQFPQfbXKKkayZr4jcMh1TUu8DOQNLadnSlg5FBk0qPmIDZo7+raUWVtuD5ekfdDN7WThy1@nongnu.org
X-Gm-Message-State: AOJu0YyJVg/gU3SEOaqCL2oGlVWcu5DBWahk20CQw9zrel7YuHeCk8fp
 g+hUmnCYNg5dcGXEhk9tRfG5W5mu6ZD5Vaa5LQAa4Eh4PFuevPbmd1NwFyNGQUI=
X-Gm-Gg: ASbGncsS5PAuf017C8ToxtEBGULSSH2/PVfmZDmSIsyaUSSZaTX3CKF93a29QB0jV9H
 7Id4Wt2zdYzguLtLqkrgSYsT4Yx7xvQI1Ga29IrAm0uBa2G61e1gkMRdR11sDtziLCrZQGpyBAC
 R6VwLSNWpywI8X3MVG+ug0L1rw22AW+NT88wvgUFoYtd9R+jzvFanoC42rs1cOBloj1XHk/z38a
 XtvtPoLxsTxY0vOJJz36iNDJuUu2jA6wOCSyVVhIft4wtcslUder1FdBSYS2IFCnkKX9gYk0EXb
 o7BWzLzrfMiu2JL+
X-Google-Smtp-Source: AGHT+IGIQSwSe9tSqrsS/uO3AUAGdeOrFP+mr+XXpNrd6m2pcjqXGP+8GGytqczcOh13hF182jSFlg==
X-Received: by 2002:a17:902:cec8:b0:215:6e01:ad07 with SMTP id
 d9443c01a7336-220bbab3cf5mr99498455ad.6.1739458636618; 
 Thu, 13 Feb 2025 06:57:16 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366984sm13437105ad.60.2025.02.13.06.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 06:57:16 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: [PATCH v2] target/riscv: remove warnings about Smdbltrp/Smrnmi being
 disabled
Date: Thu, 13 Feb 2025 15:56:31 +0100
Message-ID: <20250213145640.117275-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=cleger@rivosinc.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

As raised by Richard Henderson, these warnings are displayed in user
only as well. Since they aren't really useful for the end-user, remove
them and add a "TODO" note in the leading comments.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---

v2:
 - Remove Tommy bouncing mail from the recipient list
 - Entirely remove warnings and add "TODO" in the leading comments

 target/riscv/tcg/tcg-cpu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 0a137281de..94bfafd7db 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1432,22 +1432,20 @@ static void riscv_init_max_cpu_extensions(Object *obj)
     }
 
     /*
-     * ext_smrnmi requires OpenSBI changes that our current
+     * TODO: ext_smrnmi requires OpenSBI changes that our current
      * image does not have. Disable it for now.
      */
     if (cpu->cfg.ext_smrnmi) {
         isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
-        qemu_log("Smrnmi is disabled in the 'max' type CPU\n");
     }
 
     /*
-     * ext_smdbltrp requires the firmware to clear MSTATUS.MDT on startup to
-     * avoid generating a double trap. OpenSBI does not currently support it,
+     * TODO: ext_smdbltrp requires the firmware to clear MSTATUS.MDT on startup
+     * to avoid generating a double trap. OpenSBI does not currently support it,
      * disable it for now.
      */
     if (cpu->cfg.ext_smdbltrp) {
         isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smdbltrp), false);
-        qemu_log("Smdbltrp is disabled in the 'max' type CPU\n");
     }
 }
 
-- 
2.47.2


