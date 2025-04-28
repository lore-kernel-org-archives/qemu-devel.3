Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06736C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 19:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9U4n-0003Yk-RX; Mon, 28 Apr 2025 15:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9U4m-0003Y8-2U
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:23:36 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9U4k-0007Kh-CO
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:23:35 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-879d2e419b9so4549822a12.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 12:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745868212; x=1746473012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mWa8M+jcdIj4I+o7cJgNjEFcfy2rtqk3rV3yk5pofAg=;
 b=byDM/WtG7aP0pYo6gBtubZYpk888JaTjQ6QCuzHteUf6JjBtAkCk86Ms5b1b4tkvxw
 n81Y+ZHKyZNNvi4LtFLGA/5vE+K01GIkWH2YjO6WnTYizYRZ1rvuM8mB5rVspLyZI5Du
 UaIwHDVNGWtFH0QPLxxBZEmqivw+e6Jj3QeDgSdpP2E4VeUkiuOVumSxb5w95FmsRs6v
 ga6sxhMFcZRpQF/wAdPbIVqXODV6d0LYkUQ+DqfoWbLrV72hIhUxyV0+tcx5ItM369ld
 sePP/Ol41B76SlxGZiLfKVthEtVmzH8M7HciNHlaAUh1IvrP+weyOkJXpODhb9dunhDe
 kFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868212; x=1746473012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mWa8M+jcdIj4I+o7cJgNjEFcfy2rtqk3rV3yk5pofAg=;
 b=Pg8eALvw3yeKR+I32qKJXkAP4YvmfJJncaIwDm0Gtdr8yVo/WHoYPqzjz0a/Y1wPcu
 kBBe6pnQQN3AndE2hvNX/BQ5/A4q4/ZpCdjMWL1MPf4+2qTU6toHlrfnqAe5VZ8kuTEc
 Y120di+1LqDjh/9xYSGFILw+ObMzY0TjHIicuHb6DBgllFFvtW6AQlZ2dYwrWIYRQ7SV
 x6I4asBrAQCLazupeL52xORHVbgc4Y26pEGPgA/KL/x/goqXrseyWCQGl3bLB5vWWztM
 mUM58vP3hl+MXSgPwTa6Re41FlaWOwAj5rUEzNqY+AcpweGOApLRm7tp3AU6arrRxrji
 +V/w==
X-Gm-Message-State: AOJu0Yw7D5cPJKO2VxggRqg2hNfnDgKzxqusDGbDRY2zX67mJVPgffuW
 yeUshNtbO/nrZwI0cITbCg0g0prQqhagL2e1yqlrLZL7YuoV5YHdXBCbyJmik5s5hDw58U2df5m
 aWJQ=
X-Gm-Gg: ASbGncvgoKb0EmIAB4x3JZxxcyh6eFYlIZgCnWx4IBPirsLel6aDIxj1VSli0g7E2RP
 od8uD7CVJbwsM9EFac2zwFhGoWt/rbrXblGnjIRrGvRDDCc76dWgFZVM/NmU5xyZUCPgi9Kz5tI
 SgyHmNcxGtgyIewle6gOhJm6arFum+SZcEqSf3XHlpWVp8NNvhjLxGGMvq7q5awCarauD/AXku7
 J14B08RMPvMAnrxFPOoEnkn9a9mL30O8NBKk5GK9GsYYiz7UHPSXc0J6bMxT/uCgHjfgEnpEWIb
 5m0CPkE1X6/iHbGZS1NSK3b0N7vZaGCzHeiIGzZfqGHY
X-Google-Smtp-Source: AGHT+IGntd4aw4O12QiSFQ17+t8ziQKbMdORJCVtZLcg6PpVSzkIEa0UPk+hkhlUs3g2lt6eezsyvg==
X-Received: by 2002:a17:90b:270e:b0:2ff:4e90:3c55 with SMTP id
 98e67ed59e1d1-30a22142cc6mr656630a91.27.1745868211984; 
 Mon, 28 Apr 2025 12:23:31 -0700 (PDT)
Received: from grind.. ([2804:7f0:bcc0:906e:57d5:dca2:1ab3:20de])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4db99d3sm87300565ad.53.2025.04.28.12.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 12:23:31 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 0/9] target/riscv/kvm: CSR related fixes
Date: Mon, 28 Apr 2025 16:23:14 -0300
Message-ID: <20250428192323.84992-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52c.google.com
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

In this new version a change was made in patch 8. Instead of changing
scounteren to target_ulong, change the current logic to honor the QEMU
env storage instead of the KVM reg size. 

This will make QEMU the authority when deciding how to read/write the
CSRs in the env flags instead of KVM.

We're doing this change in patch 8 but it could also be squashed into
patch 4. If the code in patch 8 is good to go I don't oppose merging it
with patch 4 if desired.

No other changes made. 

Patches missing acks/review: patch 8.

Changes from v3:
- patch 8:
  - instead of widening scounteren, use the QEMU storage size instead of
    KVM reg size when reading/writing KVM CSRs
- v3 link: https://lore.kernel.org/qemu-riscv/20250425160203.2774835-1-dbarboza@ventanamicro.com/

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
 target/riscv/kvm/kvm-cpu.c | 335 +++++++++++++++++++++++--------------
 2 files changed, 214 insertions(+), 122 deletions(-)

-- 
2.49.0


