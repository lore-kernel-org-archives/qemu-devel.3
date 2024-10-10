Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74212CFC5F7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 19:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syySy-0006XB-37; Thu, 10 Oct 2024 15:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1syySL-0006A1-Rb
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:04:18 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1syySK-0004kz-9Y
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:04:13 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71df4620966so1205400b3a.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 12:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1728587049; x=1729191849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PUee2NQrvjsGKbH1dpkkylkOYkQbKE2imhmGuff3t2o=;
 b=OEf2wg2VBusX/nstOBrYk19Zh9FCv8ZNsXn3w1PA01iCQPmTDc3P+LObB/YhtOW4vu
 jXymc/EwUACslIiLjCnH3z4wjiR6+0gCGl5EiKbjV9TcZATkoCuP3dqMIjDDBLRAZewr
 sALDjGl5kp94WjqPZH2BnTzUxS4ColU41wO0WZH82La8k1mLVfQSKcqSLg+qJXnlpAFQ
 eu9JlsV8aPvV5Bb2ap0Qbu0im6cH1t7+gyzVyH5n6UcYwBK3bvMjKoKIPrFR6ogVolM7
 ImDh/C5XazUf5nDiqv0Zw4tdTVOi6GGf52mGNrX4y+/8T1TPkgCkHJPEQuR5n2PqoqTX
 7fOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728587049; x=1729191849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PUee2NQrvjsGKbH1dpkkylkOYkQbKE2imhmGuff3t2o=;
 b=AZdgYk+b+PF4OAtPMQF3Z/3Zc0d+fLzI5IT3gQQaZ7glmZRN3lQmx8+DlgFE3KtdnK
 sByN50w0GwSfuL1g3UQQPz7WR7gfyRuoBEzwrVMZtRZpgQ1TEZ9+PQe0fYCBZxOVH1/C
 FhKkhpojfdlCDF8hwIuNWliwPij3KC6STnxl7gjZHlLtRVTHnjixA54i2Wv8CSTxRyxt
 myBlB0Cs++GgTzcWT0ayThHYVR9LTowhBeA+mr4ZBDVbCe5sSrSJ2sUnpXzIS92ml3tl
 57qlfThwnPY1gDvaO3LKn5CJsR56hTPKbPXwLbT6kUQ4f/BeOpZ5o+9SGv96KINIcqTY
 Mx0g==
X-Gm-Message-State: AOJu0YynswaPXflpwKnmXMnjJLgEZbYPg3IgqY85lK7wo6Ekoc9bPxTx
 1xLIkAKdbm6vX2SrcDD6d7jfEYLT/3szL08N9rzdZ4iZeaHAwg9HdbOvfi9T6srXUXsUrlL0ijU
 n
X-Google-Smtp-Source: AGHT+IF4Xei35zUQ8hRY/TdCvyvNusWYc9A56aQqDUKJ0WFf+/iEbc04bycPwJj13+5mzuCCiG2+/Q==
X-Received: by 2002:a05:6a00:2d9b:b0:714:1ca1:7134 with SMTP id
 d2e1a72fcca58-71e37f4eefdmr74136b3a.18.1728587048971; 
 Thu, 10 Oct 2024 12:04:08 -0700 (PDT)
Received: from grind.. (201-68-240-198.dsl.telesp.net.br. [201.68.240.198])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e2a9f5263sm1354532b3a.62.2024.10.10.12.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 12:04:08 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 8/8] docs: update riscv/virt.rst with kernel-irqchip=split
 support
Date: Thu, 10 Oct 2024 16:03:37 -0300
Message-ID: <20241010190337.376987-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010190337.376987-1-dbarboza@ventanamicro.com>
References: <20241010190337.376987-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
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

Also add a new page, docs/specs/riscv-aia.rst, where we're documenting
the state of AIA support in QEMU w.r.t the controllers being emulated or
not depending on the AIA and accelerator settings.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 docs/specs/index.rst       |  1 +
 docs/specs/riscv-aia.rst   | 83 ++++++++++++++++++++++++++++++++++++++
 docs/system/riscv/virt.rst |  7 ++++
 3 files changed, 91 insertions(+)
 create mode 100644 docs/specs/riscv-aia.rst

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 6495ed5ed9..9a7d61161f 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -36,3 +36,4 @@ guest hardware that is specific to QEMU.
    vmgenid
    rapl-msr
    rocker
+   riscv-aia
diff --git a/docs/specs/riscv-aia.rst b/docs/specs/riscv-aia.rst
new file mode 100644
index 0000000000..8097e2f897
--- /dev/null
+++ b/docs/specs/riscv-aia.rst
@@ -0,0 +1,83 @@
+.. _riscv-aia:
+
+RISC-V AIA support for RISC-V machines
+======================================
+
+AIA (Advanced Interrupt Architecture) support is implemented in the ``virt``
+RISC-V machine for TCG and KVM accelerators.
+
+The support consists of two main modes:
+
+- "aia=aplic": adds one or more APLIC (Advanced Platform Level Interrupt Controller)
+  devices
+- "aia=aplic-imsic": adds one or more APLIC device and an IMSIC (Incoming MSI
+   Controller) device for each CPU
+
+From an user standpoint, these modes will behave the same regardless of the accelerator
+used.  From a developer standpoint the accelerator settings will change what it being
+emulated in userspace versus what is being emulated by an in-kernel irqchip.
+
+When running TCG, all controllers are emulated in userspace, including machine mode
+(m-mode) APLIC and IMSIC (when applicable).
+
+When running KVM:
+
+- no m-mode is provided, so there is no m-mode APLIC or IMSIC emulation regardless of
+  the AIA mode chosen
+- with "aia=aplic", s-mode APLIC will be emulated by userspace
+- with "aia=aplic-imsic" there are two possibilities.  If no additional KVM option
+  is provided there will be no APLIC or IMSIC emulation in userspace, and the virtual
+  machine will use the provided in-kernel APLIC and IMSIC controllers.  If the user
+  chooses to use the irqchip in split mode via "-accel kvm,kernel-irqchip=split",
+  s-mode APLIC will be emulated while using the s-mode IMSIC from the irqchip
+
+The following table summarizes how the AIA and accelerator options defines what
+we will emulate in userspace:
+
+
+.. list-table:: How AIA and accel options changes controller emulation
+   :widths: 25 25 25 25 25 25 25
+   :header-rows: 1
+
+   * - Accel
+     - Accel props
+     - AIA type
+     - APLIC m-mode
+     - IMSIC m-mode
+     - APLIC s-mode
+     - IMSIC s-mode
+   * - tcg
+     - ---
+     - aplic
+     - emul
+     - n/a
+     - emul
+     - n/a
+   * - tcg
+     - ---
+     - aplic-imsic
+     - emul
+     - emul
+     - emul
+     - emul
+   * - kvm
+     - ---
+     - aplic
+     - n/a
+     - n/a
+     - emul
+     - n/a
+   * - kvm
+     - none
+     - aplic-imsic
+     - n/a
+     - n/a
+     - in-kernel
+     - in-kernel
+   * - kvm
+     - irqchip=split
+     - aplic-imsic
+     - n/a
+     - n/a
+     - emul
+     - in-kernel
diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 9a06f95a34..8cbedf73ef 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -110,6 +110,13 @@ The following machine-specific options are supported:
   MSIs. When not specified, this option is assumed to be "none" which selects
   SiFive PLIC to handle wired interrupts.
 
+  This option also interacts with '-accel kvm'.  When using "aia=aplic-imsic"
+  with KVM, it is possible to set the use of the kernel irqchip in split mode
+  by using "-accel kvm,kernel-irqchip=split".  In this case the ``virt`` machine
+  will emulate the APLIC controller instead of using the APLIC controller from
+  the irqchip.  See :ref:`riscv-aia` for more details on all available AIA
+  modes.
+
 - aia-guests=nnn
 
   The number of per-HART VS-level AIA IMSIC pages to be emulated for a guest
-- 
2.45.2


