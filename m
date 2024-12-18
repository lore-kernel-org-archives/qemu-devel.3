Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79847E7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2c1-0006fN-2l; Wed, 18 Dec 2024 17:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2ZV-0003NO-As
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:15 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2ZT-0003HH-Kz
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:13 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2156e078563so1508615ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561069; x=1735165869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZnQvDJEi7HXlOXLCKLwDPej2YMr4PBU00RujiRp/TU=;
 b=ZHI9/FhR3BKQvde8hUjT4fNdJVmzwFX9iouo7eRGW4xHiEXI/uj+YLPqrJC/++1rGQ
 YrdpesfBJDmOQ/btk3Egbk43wWwOM3R09jyCNoLU7i7KDlQ2O6bTOTmF74wPU9g0IG4y
 NuN9CSqlm7MmHSI7WraZpTjqgAfV4JYBB+Sz2LmvfdEgYvqLghD8lQWazkaSwE7SERXj
 IcmgbpqmUc9P+vDuR9UyQHh9rB3HFpacoxs3f+qv45qPjNQcDcGEAwWPI6gAgtODcIbf
 Kcz4oFF1guBA0O8VO7D0RSo7WDq+/Ih01cRP56b0V9vBvPqxetGUE3Ia89oDOsjcXOAi
 +AZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561069; x=1735165869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NZnQvDJEi7HXlOXLCKLwDPej2YMr4PBU00RujiRp/TU=;
 b=C0qoUPYVDNIwyZqZiyRd+ID2Yj9roCtEYih8gebVvE6CLxmDLMOwptJFuFMT00ZbZv
 VfuK9BUa/rOa3S0WoCc/euJ5sX+1klyCdimraF85EbQE8JycL1pz7ftUmiZg6pSm4np5
 i1Kqngx1UxOScwjFaqkliNtmDzVuSgPLlT+MSbrFM4dfPm6ncASvzwuiiqBS1PqNn3iV
 TGxsEj7L2nzZZOQ0DXRAt8Us//u8y1KmuxjTJBV9my+GY1aS0rGnVOuEl8s2XS5yJkRd
 Pszsz4Ixv2DXWB2UgaFWA60Z3asVeJx+HhU2cvFa/Hg1J4mtUzX/ibVRJ8wPheS1shZf
 bodQ==
X-Gm-Message-State: AOJu0Yz9Ugrl6kUeWhuQ75WZcIVfDy3WEqd8Qubs/Ox22Qm/Mvyxfffr
 tLJBBU/JoycthDZXmXySwY+8n/9gLDVier2JfqCkdkiRGOZiVid2R3pG/HRk
X-Gm-Gg: ASbGnctBgvKkRjTN5/yWpJNdpL7/WbsDSxyx1I6yWrAGNyAbUZcQFUpzINq0WSkZ3MV
 ZE+LAYHrWgXxJvnIWyHwE42vmzd9AvpM9A+9IPvq/lVchlb7cG4hVoN7glaLG+2k8R7zHL7OF5A
 416E0atKmzAn4/qDAFFw305RV/G3yKtYpidruq6OPrp4U+SmJZIU1UyaTpZbfWaXh3386GX1CUN
 3W3JEOtseahlhgiVe8G62IeUOiFaBj0bdycCFH/RlepSW93FP/iFY+enC+eLgmVN83wpTseu6xT
 dEfnSWvyUWP7G618yXJ9jkl2nCeBevduIJyVgYdCRI7BwpZcNCLrqj5CHh/PNQ8=
X-Google-Smtp-Source: AGHT+IG0f75gXePw1ESh1kSdjuCv3aKSIzB8YVGGUH5dc7e3OriVD4tKoy1OsIlYR/nHW1K2/NXHLA==
X-Received: by 2002:a17:902:da89:b0:215:e98c:c5c1 with SMTP id
 d9443c01a7336-218d722cf3amr69630515ad.30.1734561069068; 
 Wed, 18 Dec 2024 14:31:09 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:31:08 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 18/39] docs: update riscv/virt.rst with kernel-irqchip=split
 support
Date: Thu, 19 Dec 2024 08:29:48 +1000
Message-ID: <20241218223010.1931245-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Also add a new page, docs/specs/riscv-aia.rst, where we're documenting
the state of AIA support in QEMU w.r.t the controllers being emulated or
not depending on the AIA and accelerator settings.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241119191706.718860-9-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/specs/index.rst       |  1 +
 docs/specs/riscv-aia.rst   | 83 ++++++++++++++++++++++++++++++++++++++
 docs/system/riscv/virt.rst |  7 ++++
 3 files changed, 91 insertions(+)
 create mode 100644 docs/specs/riscv-aia.rst

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index ff5a1f03da..d7675cebc2 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -37,3 +37,4 @@ guest hardware that is specific to QEMU.
    rapl-msr
    rocker
    riscv-iommu
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
index 537aac0340..60850970ce 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -129,6 +129,13 @@ The following machine-specific options are supported:
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
2.47.1


