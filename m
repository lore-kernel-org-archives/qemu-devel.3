Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D17C021B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 08:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmTlf-00008f-K5; Mon, 24 Feb 2025 03:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmTlQ-0008WQ-Pr
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 03:24:35 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmTlM-000193-Ny
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 03:24:30 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-220ecbdb4c2so111231255ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 00:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1740385467; x=1740990267; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZm4SwnsHhX6IEyNbi5W4P1owMVuTwdxKu0UJCplLGw=;
 b=SXPdA+FYhg25795R/hqnfDf/zgCbBQBtJDzyFBTToHkpwBH64/kwanioHch8xismBt
 pYAWJYXfFJrEBmq1tiTH4ftlqPVV8inreE3GvkcJgOI0GH6gizrPs/qlTdM/MauegTx/
 /mMKNcNmDE/uSfMNC3kIoedp+cFBeXjckHIxvqzTNWdzTjT8zH54kYwnAXS2jtqpQKND
 UE/z3XOXff8tyM8qasK8G+rCfwrJ9uqwYh6ykw0DaA3vqaiyxmHuQ8oz9cuV3TxSSC9/
 bzBLNaYwvSd1RhucV4Eeu0u31/eVf4PoBUgshuluQGNada8hcqTqRn6FsFNsoXC1SrfA
 e/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740385467; x=1740990267;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hZm4SwnsHhX6IEyNbi5W4P1owMVuTwdxKu0UJCplLGw=;
 b=r5X7G3r5OqBiLxOLIwNZOZHKSGciAXbqnPcblYDgN91PT4/S/s8+cTMRyaqGdUBNPf
 aMB6JQr+OYPZa2O0OyObcthlIiLpsTcrbz38td5dgDcHDvzRgm61CrrQl9sIw5k8z7Rm
 MzSlgPcS0DmW2O7fTskcvkBNga5ODHCUoPfSMEqUyLX7pNvunBXdWzXKtXcVadPus+dw
 J9U1kE1RGT+QV1cl2rGe+ju7B7m2mpu5HdumXhaZ32+JMGM1Y+AqzKr9ImBW78hXta10
 Vn7Xg+oaRkqoicXZBdDEVsgJIOI8MVj28UezCBm/dbTham6r0x5dVx+sQ7umUaV0wYPx
 wrKg==
X-Gm-Message-State: AOJu0YyKmKaZHPfLs5aNPNR98Peg5EwFsZUBbLDQKoArGLG53/SggsVJ
 RUBrvE8UprAVoca9ptQYfs3H/4vvYtQjDhui0XKT/kAXW2Q5CiIcL8/c0E90wdOElRqYvYPvIhb
 4XajMrFE0hzxvnSa23bYoh7lefkqpzWwyB7N2F8ow9z1zhrs6Dx2EP8Qap4w15YlEBv6rB9BpYm
 u1gxNXvagnHbdtHnMBXSsIZKGifvZi7vdx8chEpcC8/g==
X-Gm-Gg: ASbGncuHj/rftAwj8F+SGBL1j6dMlF86EcIZte7JLEW8E9+DPhWuD23IyOUN61lS2GQ
 XkhtvOop6OSokIJrrLULtGGT6GnVaSTNNoDq4DOoDIqm2ODVeBBxBnEg+QkHsCg/gtxP1RGIXTg
 wyRXdNf+M7gPC7HG+NzhzK9xNz3llWn8EkEnWUCf0xTdvLVv41nkY2f7y5ZY738kqXlibUHpzkZ
 +daIbzdp7KSaL/BJXr7nJ5PMrVkTYhkGi0b84lpGUY/yQaX5VCKKkr88hBAsXNpN8IZ99e5sYpa
 /RWRmsydCtTsm33z7N475set3iRgBA1dYkZaj5QaWcDDtBxPAGwOm2St
X-Google-Smtp-Source: AGHT+IGCbWT9LauH6yPFHhdqxuev0ZMS2teK5/iEimQuh3/6jvQU7seQBjtlXcG55CtEm8HEZ9s19g==
X-Received: by 2002:a17:902:d552:b0:21f:b483:2ad5 with SMTP id
 d9443c01a7336-221a0ed78d8mr160268165ad.20.1740385466658; 
 Mon, 24 Feb 2025 00:24:26 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7325c88d74esm17714914b3a.149.2025.02.24.00.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 00:24:26 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH v2 0/8] riscv: AIA: kernel-irqchip=off support
Date: Mon, 24 Feb 2025 16:24:07 +0800
Message-Id: <20250224082417.31382-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x62f.google.com
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

This series introduces the user-space AIA MSI emulation when using KVM
acceleration.

After this series, RISC-V QEMU virt machine with KVM acceleration has
3 parameters to control the type of irqchip and its emulation method:
- Machine prop "aia" controls the type of irqchip
  - none: use PLIC and emulated in user-space
  - aplic: use AIA wired and emulated in user-space
  - aplic-imsic: use AIA MSI, emulation mode is determined by
    "kernel-irqchip" and "riscv-aia". This can only be used
    when the host machine support the AIA extension.
- Accel prop "kernel-irqchip", effective with AIA MSI
  - on: in-kernel APLIC and in-kernel IMSIC
  - off: user-space APLIC and user-space IMSIC
  - split: user-space APLIC and in-kernel IMSIC
- Accel prop "riscv-aia", effective with in-kernel IMSIC
  - emul: use MRIF as in-kernel IMSIC
  - hw: use hardware guest IMSIC file as in-kernel IMSIC
  - auto: use the hardware guest IMSICs whenever available otherwise
    fallback to MRIF

Glossary
- PLIC: Platform-Level Interrupt Controller
- AIA: Advanced Interrupt Architecture
- APLIC: Advanced Platform Level Interrupt Controller
- IMSIC: Incoming Message Signaled Interrupt Controller
- MSI: Message Signaled Interrupts
- MRIF: Message Routed Interrupt Facility

---
v2:
- Add glossary of RISC-V irqchips in cover letter (Kashyap)
- Add assertions in riscv_get_csr_name() of PATCH4 (Andrew)
- remove the changing of property name (Andrew)
- Add PATCH8 to prevent the usage of IMSIC devices when the host
  machine doesn't support the AIA extension.
- fix typo in cover letter

Yong-Xuan Wang (8):
  target/riscv/kvm: rewrite get/set for KVM_REG_RISCV_CSR
  target/riscv/kvm: add KVM_REG_RISCV_CSR_AIA
  target/riscv/kvm: add KVM_REG_RISCV_CSR_SMSTATEEN
  target/riscv: add helper to get CSR name
  target/riscv/kvm: rewrite kvm_riscv_handle_csr
  target/riscv/kvm: add CSR_SIREG and CSR_STOPEI emulation
  docs: update the description about RISC-V AIA
  hw/intc/imsic: prevent to use IMSIC when host doesn't support AIA
    extension

 docs/specs/riscv-aia.rst   |  24 +++-
 docs/system/riscv/virt.rst |  10 +-
 hw/intc/riscv_imsic.c      |  17 ++-
 target/riscv/cpu.h         |  10 +-
 target/riscv/csr.c         |  30 ++---
 target/riscv/kvm/kvm-cpu.c | 235 +++++++++++++++++++++++++++++++------
 6 files changed, 254 insertions(+), 72 deletions(-)

-- 
2.17.1


