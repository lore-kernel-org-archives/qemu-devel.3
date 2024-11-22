Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FB9E65D10
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 01:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEIVs-0002E4-OB; Thu, 21 Nov 2024 20:31:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@rivosinc.com>)
 id 1tEIVp-0002Dh-4X
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 20:31:09 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@rivosinc.com>)
 id 1tEIVj-00070X-N1
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 20:31:08 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7242f559a9fso1591848b3a.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 17:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732239061; x=1732843861;
 darn=nongnu.org; 
 h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
 :subject:from:to:cc:subject:date:message-id:reply-to;
 bh=92YAmZw5ycp/h77RXNXa7Lv4KjKlLVQ4bfD0i3NvNdc=;
 b=qUDJ0OtxFqQdrkP8ZY+XjGY/Uw+I3GJKkE03ZeamjDIAw8+TiSNEYkhNnqe3HPzhIF
 CkWvJnQLvOTR7N1ib0FGAavTnSR05sRSXYB19DtfGIUju6uct8cBwLkonYLYSlCYZHVG
 aR7Rg59XwKKwz6uo8biEjCuKC/+IsjiAeZVPXPm/u2Wg1vgqpvMrz2QeHN3UXrUfzAAL
 pw/vpuGRHLvT3ok2QNnTs8NI3wPpN87bOxrsGtdfIBSw3wm+rfxYlrS5R2XwnbTHkeKu
 XS5r2MBhnx9mPSQ8eqmdrYO9E8NEwcolDDgYG40Rx1aoUWeIAlPzV1bnenG2EIPIdrUF
 LPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732239061; x=1732843861;
 h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
 :subject:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=92YAmZw5ycp/h77RXNXa7Lv4KjKlLVQ4bfD0i3NvNdc=;
 b=JQ7Q/ibWtHSMMQeDgbYNvJCdRUxCdrWdfjzsvH3PLew6Ig+J+dhg5dFLukX6MIgPXG
 tszaZBmozxw3j+ulZRere6YMK8MgNFDFRK+vYez2QFxC6CEd6kHFUMACkR6ChN6aPJem
 7YSC1d4qenraZp9zJd2yAl+OBKZJQvnorlnZ/4fHBBMt5EndMeqI2TJW7YGfbAr7v22N
 DEfTZOllgPa1tpCXq3zEqEemuQDpujaGEpbWMRQeyp8n3TseCFmzYhrjvDmig27poNea
 QlBorDwq1ZIgmKRgoTGmjNDKm6v7/THjuqLvLR9fYeTrSTt0I5jG/FDeMcN4bR/abb5q
 Q97Q==
X-Gm-Message-State: AOJu0Ywbmj7CF9RSc45CzT7iydGNeSJHUIY0V4AoIt+aK0ckVVPFUBi1
 Rg6BTJVQQrprxX6VD4AXuWVbeo8VgdjTKx39HgH4P9KgKkyEIC4iz5yTDFY4tWk=
X-Gm-Gg: ASbGncsdOgJqTlVFcUHt1iOFRf69WCl3ONrNTaLuA80oTUE7mLdxjfBm6q0f1F//app
 VJyJ+X6N2Et9bWpeQ8wKSvmwgJfT7FMIXntcgv7mDAXgt3nZ8tWYJbF/tnV94ufFeXiMJCqX+Zq
 VTdBYKE7hx61th8PBclhFqSQIWvHDHPrqUzZ9YOypxGpwbBoqtClaIXsIbTZNLzNhxqcvG9azdI
 lRmlijjSyqD50AbKTNtSQDIIZLCTP0JGkC3hScbE2R2c2WV
X-Google-Smtp-Source: AGHT+IEraRndVoO1zvu8MHa7qYvE/Qugp/gtQeTysZzb9dbUuE1lJ1SvzyreBMgx5juzR/eijjl3XQ==
X-Received: by 2002:a05:6a00:4990:b0:724:e1bc:367e with SMTP id
 d2e1a72fcca58-724e1bc36admr646588b3a.23.1732239060802; 
 Thu, 21 Nov 2024 17:31:00 -0800 (PST)
Received: from localhost ([192.184.165.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de5312fdsm439681b3a.125.2024.11.21.17.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 17:31:00 -0800 (PST)
Subject: [PATCH] target/riscv: Don't start user-mode with VILL
Date: Thu, 21 Nov 2024 16:32:47 -0800
Message-ID: <20241122003247.8955-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Palmer Dabbelt <palmer@rivosinc.com>
From: Palmer Dabbelt <palmer@rivosinc.com>
To: qemu-devel@nongnu.org,          qemu-riscv@nongnu.org
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=palmer@rivosinc.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is still under discussion in the psABI, but it's looking like we're
going to forbid VILL in userspace in order to maintain compatibility
with binaries that don't expect implementations to trap whole register
moves under VILL (as in QEMU before 4eff52cd46 ("target/riscv: Add vill
check for whole vector register move instructions"), for example).

Fixes: f8c1f36a2e ("target/riscv: Set vtype.vill on CPU reset")
Link: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/pull/454
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 target/riscv/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f219f0c3b5..d19a44de99 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1022,7 +1022,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     cs->exception_index = RISCV_EXCP_NONE;
     env->load_res = -1;
     set_default_nan_mode(1, &env->fp_status);
+#ifdef CONFIG_USER_ONLY
+    env->vill = false;
+#else
     env->vill = true;
+#endif
 
 #ifndef CONFIG_USER_ONLY
     if (cpu->cfg.debug) {
-- 
2.45.2


