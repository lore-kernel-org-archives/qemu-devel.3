Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A86CE77160
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 23:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIc6Z-0001IN-4q; Tue, 03 Dec 2024 18:14:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6V-0001Fx-Tf
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:14:51 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6S-0001Hw-Gf
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:14:51 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-215b13e9ccbso21336465ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 15:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733267686; x=1733872486;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3sbbrb3u3w1ShGoF78/nxrI4WgGN/FndqIitCD43mSY=;
 b=G4UiumtFmZJzMmTojZOLI4e7CffsnpICDGvTRex05WicdHT4sUWLMYJU7Wv77Fp1Zf
 3lPIct6cUAU0uZVBsHQOExaz23ufU0ydndT/XPuOGf6M7bjes6hDTE80P6jQkHZl3T/W
 HUQvQKCkNhN4T9t9F7UoG8ljAVZ9BuW80A3hCGnc0KSkxtacnH2I9NOgA5KIY3rxZ1nz
 jEGW9Ir7Gd2M0JmaUKxWPm0bDv+newLkxb3KRMkAkOCX+MIbmOXhEJr+SiIoMRgxrJSm
 J7GcY1N7I3i/Y1upj02tPHVhz9iimpSnpX+mhSb4FGcoB1TFGW7yMSav/phdeDfw8e8L
 Jfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733267686; x=1733872486;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3sbbrb3u3w1ShGoF78/nxrI4WgGN/FndqIitCD43mSY=;
 b=lJlhHvzKO5iTmV0FrDJksdoz4kvfxvgQn3tyxrluxMox1IOPH8eiDo2XMgzKQ6555m
 jMrfVw+c7cXYwRvqQ+HxIsF44qhu27yhbhkceYgly5UfPcc0nkXdsA5NOs75paiXA4hK
 0ohp04jyebuqTUxXewq23Dxn8Zw71dNg24/EuwXEsHz5JZ3+5qhb0/K1kaPqJopZsoul
 +ZSJ9WiBeArWzhCaB85GC4j1CU7l4nFzwCPZ0hk3ZfP5fZHAk+3Xak2kX4idqFvF9ukS
 al4X+rTaBRjX0cctIbO0q5MAsBoe+lf7UepFccDSALZOogROZq7JJDFPJU0040viQgST
 ZcoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkGiucadi/hqVX1Dd5sacmFK6EZRybQJQdqdHFtifUoiPg4F/nTi/fBFZzzIc6pa925bUzCND7yWq0@nongnu.org
X-Gm-Message-State: AOJu0YzEPI5o8WzrQTPRDDyVoyJ6Q5Szf1D/kL8aXfRGrJNkCBOIClY4
 nqjEd6UoxlEK3Q+3BaCFjTR3X6zIuSJmDC/iGPuYSxm3SU801Px2nKOg+WOPP/Q=
X-Gm-Gg: ASbGnctA/LzKeqHCw0h6pFnZpZNk3dwmnv+iMacksBnXtAYNLy9xbIiwiketYUcF3EZ
 KF6h6k5dkV6leSERv9oT/MoNFUW4xod3U7adPKlYajbX8udBdbKigPMWM7f9uRl++mpoLV0QIha
 u8YkF5IInNqR0eeJSrDFpbhPFs2ff4wsmehntAwPS8fy8/HvdEYSXgeRJEUcuw3P1mNH9ciJRPA
 Zli8sVitXs1AK9n21L0PBsmmQ2QbijrE5XRYYuwfV3xLCgiRwWhMZu55AbGgTs=
X-Google-Smtp-Source: AGHT+IE1ywDm8+110NOOWtztl0N4xNHSVat+WdY38Pz4zltROOFs+j1UOpVk8Gl0B10084vyfCivzA==
X-Received: by 2002:a17:902:ecc7:b0:215:7b7b:5cc9 with SMTP id
 d9443c01a7336-215bd0e035emr57597915ad.22.1733267685691; 
 Tue, 03 Dec 2024 15:14:45 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254180f78asm11032133b3a.133.2024.12.03.15.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:14:45 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v4 00/11] Add RISC-V Counter delegation ISA extension support
Date: Tue, 03 Dec 2024 15:14:38 -0800
Message-Id: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN6QT2cC/23NSwrCMBCA4auUrI3k1aa48h4iEifTNqCJJDUop
 Xc3LeJCuvyHmW8mkjA6TORQTSRidskFX0LtKgKD8T1SZ0sTwYRimtcUwtOPGC8Wb9ibsaxTzsx
 VKdBWACPl8BGxc68VPZ1LDy6NIb7XH1ks0y8n5BaXBWUUFNfM1FK1YI7R5ZCchz2EO1nELH8K5
 1xvKrIoSje26WSDEto/ZZ7nD74BaWD9AAAA
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x635.google.com
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

This series adds the counter delegation extension support. The counter
delegation ISA extension(Smcdeleg/Ssccfg) actually depends on multiple ISA
extensions.

1. S[m|s]csrind : The indirect CSR extension[1] which defines additional
   5 ([M|S|VS]IREG2-[M|S|VS]IREG6) register to address size limitation of
   RISC-V CSR address space.
2. Smstateen: The stateen bit[60] controls the access to the registers
   indirectly via the above indirect registers.
3. Smcdeleg/Ssccfg: The counter delegation extensions[2]

The counter delegation extension allows Supervisor mode to program the
hpmevent and hpmcounters directly without needing the assistance from the
M-mode via SBI calls. This results in a faster perf profiling and very
few traps. This extension also introduces a scountinhibit CSR which allows
to stop/start any counter directly from the S-mode. As the counter
delegation extension potentially can have more than 100 CSRs, the specificaiton
leverages the indirect CSR extension to save the precious CSR address range.

Due to the dependancy of these extensions, the following extensions must be
enabled to use the counter delegation feature in S-mode.

"smstateen=true,sscofpmf=true,ssccfg=true,smcdeleg=true,smcsrind=true,sscsrind=true"

This makes the qemu command line quite tedious. The previous version, I tried
to introduce a preferred rule to enable all but it was decided that an user
should opt to use max cpu if they don't want to enable all the dependant ISA
extensions by hand. This series got rid of the preferred rule and added 2 
patches for specifiying the mandatory ISA extensions via implied rule. 

The first 2 patches decouple the indirect CSR usage from AIA implementation
while patch3 adds stateen bits validation for AIA.
The PATCH4 implements indirect CSR extensions while remaining patches
implement the counter delegation extensions.

The Qemu patches can be found here:
https://github.com/atishp04/qemu/tree/b4/counter_delegation_v4
The Linux kernel patches can be found here (WIP version due to onging upstream
dependant patches):
https://github.com/atishp04/linux/tree/b4/counter_delegation_v2

[1] https://github.com/riscv/riscv-indirect-csr-access
[2] https://github.com/riscv/riscv-smcdeleg-ssccfg

Cc: kaiwenxue1@gmail.com

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
Changes in v4:
- Fixed the comments recieved on v3. 
- code style comments and removed 1 redundant if else block.
- Link to v3: https://lore.kernel.org/r/20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com

Changes in v3:
1. Updated the priv version in extensions
2. Fixed minor issues pointed out in v2.
3. Dropped preferred rule and added an implied rule for AIA and counter
   delegation.
- Link to v2: https://lore.kernel.org/r/20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com

Changes from previous RFC version:

1. Renamed sxcsrind to csrind to align with other function names.
2. Enable sscofpmf by default for virt machine.
3. Introduced a preferred extension enabling rule strategy for generic
mult-extension dependencies.
4. Enables all PMU related extensions if ssccfg extension is set.

RFC Link:
https://lore.kernel.org/all/35a4d40c-9d0d-4a0a-a2c9-5d5f7def9b9c@ventanamicro.com/T/

---
Atish Patra (5):
      target/riscv: Enable S*stateen bits for AIA
      target/riscv: Add properties for counter delegation ISA extensions
      target/riscv: Invoke pmu init after feature enable
      target/riscv: Add implied rule for counter delegation extensions
      target/riscv: Add configuration for S[m|s]csrind, Smcdeleg/Ssccfg

Kaiwen Xue (6):
      target/riscv: Add properties for Indirect CSR Access extension
      target/riscv: Decouple AIA processing from xiselect and xireg
      target/riscv: Support generic CSR indirect access
      target/riscv: Add counter delegation definitions
      target/riscv: Add select value range check for counter delegation
      target/riscv: Add counter delegation/configuration support

 target/riscv/cpu.c         |  20 +-
 target/riscv/cpu.h         |   1 +
 target/riscv/cpu_bits.h    |  34 ++-
 target/riscv/cpu_cfg.h     |   4 +
 target/riscv/csr.c         | 718 ++++++++++++++++++++++++++++++++++++++++++---
 target/riscv/machine.c     |   1 +
 target/riscv/tcg/tcg-cpu.c |  28 +-
 7 files changed, 753 insertions(+), 53 deletions(-)
---
base-commit: 27652f9ca9d831c67dd447346c6ee953669255f0
change-id: 20240715-counter_delegation-10ab44c7d2c0
--
Regards,
Atish patra


