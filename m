Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6466AC369D7
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 16:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8LVa-0006Av-5J; Fri, 25 Apr 2025 12:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8LVG-0005pf-MH
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:02:18 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8LVC-0008Kg-Nk
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:02:13 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b074d908e56so1795466a12.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 09:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745596929; x=1746201729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EkJ/iUGr9j0bS9GADPEzLCdejduU+F7nVyD9oU685W0=;
 b=cMmJ+hZuIe/iCf5NSPxWCpuQ08Ncou2k9aIWRn1HMTdrfsJCQjTujobYLpMCIoOhXN
 bYEvVvsPgYaiSNBLG8SxWvMaMDApVLiy8SDQOWZoeRLIaGMIXDYyjM95OJyzT7oZy69W
 C+pLkedPCEOMZKHK37OyZYmdBdAT5OfBhPP+3/nYnL09+rdjWbLk39+jOFCuY+gJTiLW
 ZIgeugm/XjXdt92kHAgji5XUrb2CR1ISc0zq/4qIvZZS8s6KjW4oVm3lgl0mwQkkQKSS
 aksPt94i9ka4K/yq9RbJFRJ91bnSXAtDEkcKU77xwG0+kFaZl2UJy/c0D/1YBjBbbCra
 H35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745596929; x=1746201729;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EkJ/iUGr9j0bS9GADPEzLCdejduU+F7nVyD9oU685W0=;
 b=Cf+7tsYyJ2xcNc196wN6yhsVfj+C5sAzfaQwePEj3TvWeWb5ZefLEM8ikYZALHyjnH
 rd0K6N9fmTsq/Xbn1+iqwzWeu7K0MitAXxuJM4FUIZNcUx87DY6oOat4WL2TJQqZ+//F
 H0M3RyCXiUNIgyVTfhefIL7aSZgXEFuR3uFe/JLY1ZscPSBFmOHIHuZDAzdEqKXst1WQ
 1JxNm9t+GNl+MHqtiTjHSifcDUNw9ldsZX97Vkh1rvu/h7eZG+KsjoEwKpCPMvVakXKr
 XyzB7AeTTfj5VNOMwY7V+rC/VZMFm7WgjJVHOZaYSB2Ddy4JKK9xmB8t6JZCWc4cjJli
 ofKw==
X-Gm-Message-State: AOJu0YwHEx6M/DlJ3rR7LuKAfzjRczk62FpW6cKPseLzA0CmZoDOreYS
 UyeaiGAk0PG3y+bY5Mu+cKgrWrAMFHEdzut/L6ITwnqngcNIDxRhaOxx4Vji2MWcO6p6q/e4wei
 C
X-Gm-Gg: ASbGnctoU1Do9nOdNi6pnLk/nKYTvTJZxEm0CUOASyU2ELrsJpZX9+77Sk3yo54+Yj2
 xyyWkBD1R1jfIrnHIiThsTRR+ZplcIhYMzXGRiUlOsAxc0Sz5cQPATTituIzan48QYyVYqXqmb7
 RKwmcnVl8JdWOepIept7JqWAe+5qsdjdZNEIWcTdW6uCVUxZW/otgSXnCPi/mlWfQoq13VsLbku
 1haJsX/UwuVJKNtHvFCWH1XOKjm5ALTxQmAYlTTdk43wBd5qs1ivqMl3GpzblgdKyp5Od3nRfjO
 aC88YP3i0Hs9ETADBrWomHeQ9NBnzZKlSi4SxiZQ5R/KnlfrWVbDwFwbX7tbfNVtsRRp
X-Google-Smtp-Source: AGHT+IFfcyat/z6PFfxRAo5CSHXVoe8P063qxHi2fc2SgXnffFsfW0RgeSqMJq25FnrmIVlXOWUzsw==
X-Received: by 2002:a17:90a:d647:b0:2ff:5714:6a with SMTP id
 98e67ed59e1d1-30a01340e04mr151341a91.19.1745596928615; 
 Fri, 25 Apr 2025 09:02:08 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f774e534sm1820005a91.17.2025.04.25.09.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 09:02:08 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 0/9] target/riscv/kvm: CSR related fixes
Date: Fri, 25 Apr 2025 13:01:54 -0300
Message-ID: <20250425160203.2774835-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi,

In this version, aside from minor adjustments suggested by Drew in v2,
the most relevant change made is left mcounteren untouched in patch
8. We're just changing scounteren to target_ulong as required by KVM.

Patches based on alistair/riscv-to-apply.next with a KVM build fix [1]. 

Patches missing review/acks: patch 8.

Changes from v2:
- patch 2:
  - changed 'g+malloc' to 'g-malloc' in the commit msg
- patch 3:
  - changed commit subject: sed s/in/into/
- patch 4:
  - changed commit subject: sed s/in/into/
- patch 5:
  - kvm_cpu_csr_get_u32() now returns an uint32_t (for real this time)
  - tabulate kvm_csrs_cfg[]
- patch 6: 
  - mention kvm_riscv_init_cfg() in commit msg
- patch 8:
  - added comment explaning why we're changing scounteren
  - left mcounteren untouched
- patch 9:
  - add scounteren in the same order as it is shown in kvm_riscv_csr
- v2 link: https://lore.kernel.org/qemu-riscv/20250425113705.2741457-1-dbarboza@ventanamicro.com/

[1] https://lore.kernel.org/qemu-devel/8f3bae37-e1f3-4e55-9dc6-b7876992b47e@ventanamicro.com/

Daniel Henrique Barboza (9):
  target/riscv/kvm: minor fixes/tweaks
  target/riscv/kvm: fix leak in kvm_riscv_init_multiext_cfg()
  target/riscv/kvm: turn u32/u64 reg functions into macros
  target/riscv/kvm: turn kvm_riscv_reg_id_ulong() into a macro
  target/riscv/kvm: add kvm_csr_cfgs[]
  target/riscv/kvm: do not read unavailable CSRs
  target/riscv/kvm: add senvcfg CSR
  target/riscv: widen scounteren to target_ulong
  target/riscv/kvm: add scounteren CSR

 target/riscv/cpu.h         |  10 +-
 target/riscv/kvm/kvm-cpu.c | 331 +++++++++++++++++++++++--------------
 target/riscv/machine.c     |   6 +-
 3 files changed, 221 insertions(+), 126 deletions(-)

-- 
2.49.0


