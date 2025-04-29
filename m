Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEE3C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 12:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kKB-0001px-BL; Tue, 29 Apr 2025 08:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kK7-0001h0-66
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:44:31 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kK4-0004Ke-Rn
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:44:30 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-309d2e8c20cso7234672a91.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 05:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745930667; x=1746535467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TgDMy+NEFM5kSm1KRexC1us+iTsp+cwve3912j6CUv0=;
 b=OhBCruC1Px+ySgAC2oRQkEu8FNCRmkrfgbWVPvoFlaeXbtIGA9Q9mv/KHV72T4tLeB
 esBW6KVAoEW7gji+D7f4Ji1BrsBgFmaq+dnqE3tvsMzp3IfbUXNMxMtAogWmWGzHqj13
 seUOtIaIeET8im+bIXO7zJunGXFfIYxF4PFoXwF+SoMpshDq2ipiJxx3SuxZ6+YOwz3P
 YHoEjbyJRLU+UI7i5O5k6yjmuMqve0QkBcECZs/eyN7k7gtFnyLP/UcWmUJRDKnpJl+X
 JxOxegVBbcBb7iCuXmAW9R9DQ24eLsdClzQn9n2y0oibMUfVrwXGRzzQZvdbimEc7nRT
 H23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745930667; x=1746535467;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TgDMy+NEFM5kSm1KRexC1us+iTsp+cwve3912j6CUv0=;
 b=tJn23nXvy6/i46NyRijHJJiRQkwRFyOlDK0/jyeGxOTdY0PIL0E1+cXowYOQtYNTvv
 qY7xuq34f3pVvMLsqQAL1ldXikW/LYrJ4RAp4g0+iodTWNhN9k2izRuPnCg2XSebOd4J
 qwMc4sGx8ApvsNplFaU2Pswd7KXjHtA6mBTNpd+gQR22GA6WglGk5411dzSaIZIMjzEE
 lVDrDn68AdAuJM+/333cEpwDDkeFl7q8GPfdh70him96IgyhlVY9ZqfvcofgXqwc3Rb8
 1obGtRfKWkUAKT5d2/MuwRX9YIydXO48ZhRrMmSiLaKlIP9GKfo5X4P1Wm2VzTIu6a7j
 lo3w==
X-Gm-Message-State: AOJu0Yxp3B5yo0XudK/THxaDp5g0MfXfV3Y8ESt7rvyTbNgDCOVJbHUv
 ZOyh19CfOUbnurJzYqo1hIQwP91EgiWuH5RH1XtqCZhApAm49sGrhNKxl5BE+zdnuO8HeIUP6ps
 D
X-Gm-Gg: ASbGncuChHHhcpcZ3/P5n9zhc58oz+J1LJaRVXLkn1eTBlrcyyVp3JZ5jAa6OANofGC
 jChm3AcDYBSz62zj6cDRznUZaXCANYVaXzT2Hhe4PA3awEBOfwAW1uVhxRhCwdyoSKSasmlJ+o+
 GzGnAQG52QWNYafajfSZdjHL1cSyFOAEhXyn9GsFTX9b7a6kLdO5k3H8VRvYYs6ZQsMbpGTj0ru
 l23Jh0F1cMcONXoiARTgkfYvH1ooD8fVDQvYk9Q/8q6EYInUWBvrnbLxGQY0fg6iFllbxNtHd5D
 Kn9d7I8xlfji0Moe4wcMPHU6UTQ5KLbEWAaxyOUR3h0=
X-Google-Smtp-Source: AGHT+IG1YgLg0rFi+YPVKhoY4z2ROj27wAmktATXjTMsgwk/0d8P+47iJVhMgnhJBs0Z9Tex28xUhw==
X-Received: by 2002:a17:90b:4e83:b0:2fe:ba82:ca5 with SMTP id
 98e67ed59e1d1-30a23dd9dfemr3837025a91.11.1745930666587; 
 Tue, 29 Apr 2025 05:44:26 -0700 (PDT)
Received: from grind.. ([152.234.125.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309ef04ba89sm11001161a91.10.2025.04.29.05.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 05:44:26 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 0/9] target/riscv/kvm: CSR related fixes
Date: Tue, 29 Apr 2025 09:44:12 -0300
Message-ID: <20250429124421.223883-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1031.google.com
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

Hi,

This version has a fix on patch 8 where I did use an extra variable and
happened to set the wrong mask too.

We'll let the compiler cast the uint32_t from an uint64_t reg. A cast
was added for extra clarity when reading the code, although some picky
toolchains might require an explicit cast in this case too.

No other changes made.

Patches missing acks/reviews: patch 8.

Changes from v4:
- patch 8:
  - remove the 'reg32' variable and add an uint32_t cast when passing
    the uint64_t var 'reg' to kvm_cpu_csr_set_u32()
- v4 link: https://lore.kernel.org/qemu-riscv/20250428192323.84992-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (9):
  target/riscv/kvm: minor fixes/tweaks
  target/riscv/kvm: fix leak in kvm_riscv_init_multiext_cfg()
  target/riscv/kvm: turn u32/u64 reg functions into macros
  target/riscv/kvm: turn kvm_riscv_reg_id_ulong() into a macro
  target/riscv/kvm: add kvm_csr_cfgs[]
  target/riscv/kvm: do not read unavailable CSRs
  target/riscv/kvm: add senvcfg CSR
  target/riscv/kvm: read/write KVM regs via env size
  target/riscv/kvm: add scounteren CSR

 target/riscv/cpu.h         |   1 +
 target/riscv/kvm/kvm-cpu.c | 333 +++++++++++++++++++++++--------------
 2 files changed, 212 insertions(+), 122 deletions(-)

-- 
2.49.0


