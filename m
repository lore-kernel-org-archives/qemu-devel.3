Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CC2C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 09:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYM72-0008Fy-MY; Thu, 16 Jan 2025 04:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tYM70-0008AQ-Sc
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:24:26 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tYM6y-00075G-Qg
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:24:26 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so5865515e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 01:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1737019463; x=1737624263;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n4tO2lpWLUlWhElOcxn349LZsfQHzK7a0FiyfdeojG0=;
 b=EA2WLkHMjjEJ54nOa0F9om2VAi0ao5h8VAKOWEqm99N/tx0ysxI1Rq/kTQ/mLp1CQW
 Ad80qfdWQ2/h3fAXKPzCzqzFWW9plRuUuIzrcAdcM0T/6zG3vjdKw/oiCYeVbQWUu9Hm
 0qMdMaIDbQtO3fwRmEXWkOqFpzHPNPyvL936cP+86GJmBli842nltrvNXgVrFctPzN6H
 8yr+hGP7G5GQJSqb8wiQu7XuxPZSy1NQ4lvUm6WdE/PwckHYh21zzdumLoT7BqLdEIrP
 E/GwG7tjT9Jh5OfLMgwmfPGNcUK5WEkwjQN67wlObwIJdVaD4U9Qj2OmV0KKyvIWZtLd
 0Ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737019463; x=1737624263;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n4tO2lpWLUlWhElOcxn349LZsfQHzK7a0FiyfdeojG0=;
 b=CAVCbwWKDCW+yDYZr2cof0ptpypDOGtL38eoxdqF8QwIBcGH4jzFS5QtXwVhRERQIn
 OeC11yPai6+fGndx9KeZjFeFBUbh9U4m6TICcCUski65duwBPFzWAYJSBEc4Ysj0ZK8w
 2yROLj06RNN0zghgmXdzhBlB1YONIEo4JgQt5itY3rbNsKI4IaLpExiGwm9qAZMB9JTL
 BzW6w48Wa4SwWYyndTQ9nwDlJ/JLpxQjsPHqPZTzukMvOMM2jNKSa3BSuHRg6e5Yi9QP
 MzVvuYekuyU5nRBaiSGop1zMMUypvN4xsGCgeZnt/wgPekv2xglmjaOkE5R4VTkUdHnG
 cT5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV30vIJgTuciZFvXQrFkhFl70h/YlvJ7UB1DWMlBjeuUF42RzLv2Yv/YiVud8Rr4eg2DVpDGUIXiUXi@nongnu.org
X-Gm-Message-State: AOJu0YxybUfhrIeEJkORKINb5Ddb32gsRGV8gXGMUf0zUE1sMhCq3t7V
 6S6KeWn4JudQMDXpgxwxYkhdUm1CjawRMlnlefhVSSNcORvReYL0MEKmkMgaPcE=
X-Gm-Gg: ASbGnctzWzVTwvrgLLlXn0fmq20WU2ssDLfh4Kk9yH0i5odVjAxo32dvDzODB29FwGK
 MAipV34bSMMe+1y8rVStVKYnYu1Df55AAlbeLAiCAqGLHM7S43h8nKvXR2vzrVPrGMVosmDqjdB
 r+eu8ZyRrn67tYGFkacsFdersmx5nO8VMmaO12EOiMbZNoDrc5pHtxXaykLftbLpaSxYngub10h
 6EjstxnBov6l5h9cGV1Gz3aa2Rm/H+0ZJWMwiB/f2udcqelbGTPMCrZNQ==
X-Google-Smtp-Source: AGHT+IGzECVt+hIOy0AQktvrXyKxuw2pm8Ehw6Lrm2mWldlU0RH4XsvxuUG21oXWUIEIaU0fXGEAwg==
X-Received: by 2002:a05:600c:c0e:b0:436:488f:4d8 with SMTP id
 5b1f17b1804b1-436eb9a154amr295847425e9.11.1737019462656; 
 Thu, 16 Jan 2025 01:24:22 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74aca93sm53391365e9.13.2025.01.16.01.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 01:24:22 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH] riscv: disable Smdbltrp for the max cpu
Date: Thu, 16 Jan 2025 10:23:45 +0100
Message-ID: <20250116092352.1630278-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x32e.google.com
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

When present, Smdbltrp is enabled by default and MDT needs to be cleared
to avoid generating a double trap. Since not all firmwares are currently
ready to handle that, disable it for the max cpu.

Reported-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Clément Léger <cleger@rivosinc.com>

---
 target/riscv/tcg/tcg-cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 48be24bbbe..0a137281de 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1439,6 +1439,16 @@ static void riscv_init_max_cpu_extensions(Object *obj)
         isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
         qemu_log("Smrnmi is disabled in the 'max' type CPU\n");
     }
+
+    /*
+     * ext_smdbltrp requires the firmware to clear MSTATUS.MDT on startup to
+     * avoid generating a double trap. OpenSBI does not currently support it,
+     * disable it for now.
+     */
+    if (cpu->cfg.ext_smdbltrp) {
+        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smdbltrp), false);
+        qemu_log("Smdbltrp is disabled in the 'max' type CPU\n");
+    }
 }
 
 static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
-- 
2.47.1


