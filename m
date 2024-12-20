Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DE8E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSF6-0006aD-RS; Thu, 19 Dec 2024 20:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSF4-0006Wg-LM
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:51 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSF2-0004Vy-80
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:50 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-728e78c4d7bso1114962b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659746; x=1735264546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZnQvDJEi7HXlOXLCKLwDPej2YMr4PBU00RujiRp/TU=;
 b=jHfse1ZNXwx4kx53k9HNz4TSPKZ/tPTZ71v0VM1UPez8MobyT5NeE8kN67U5xYGZJI
 hVw2d9hjF4wqdIoYf2TxoI3FfT2a3tLyQrx0oclErd/kqrO4rHfBXBt92KAn+6l3k0es
 jKj09PPxQZxb1flRIJXI9ml66SiPSXB8E1NWl7brwnYGwMY6wc1w+nBz+ySIF5WQ1ZfJ
 SBN2rtAHV9hp+6xzX1Mwe75Hhzpo28oY40Hq33L68HtFz0hKXqOj83Kr33UJ3w+rEVdM
 ZcZztyLoJ8/en3fFl2I+xBv7+VbeynnPdGI1LpL+8uPfptVVo18TatHWVCgig75TE/yo
 bdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659746; x=1735264546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NZnQvDJEi7HXlOXLCKLwDPej2YMr4PBU00RujiRp/TU=;
 b=ayjXCnt+nooMM1UdEEpKC8u4p1WTbl68B78+m9HoJLciLD4k96e2Gsl0moQ+yZr2zh
 OuLPOrzjYFwDKsBHTFCHLnrP5XoaAloYE+7tUN4LrKpIohJsCORqGWPkbrkh0yDJiTXh
 30jlQxr1w2VxeK1qWEmV/zWy2USexOh5r0zCAYDKSA8Vn40wkehSmm2s309f8pmdbnIp
 KQox3kpfle9KjvHeNGFekb5t/yDnq6eavd1T7IeMyI4bYPbPQRGeEyAvvYBqKBZorEpT
 W/S+Q05iibVDxS9sxCvsyUAsr+fMOW1RwiHs8Qwa8tpmMVz4YS6rT9k/Am2WPfwnySnp
 RS2g==
X-Gm-Message-State: AOJu0YyWnQmGAUJZFr0cFbUAcS3X2cJlvWJ9aSSVTd02npMTZl3hzoJU
 rjw/Re4Yz/PhzaID9dOHbBYpCSAFsHAZ6b6wpUkVZtO5NIUFN6ffKPrl5YJO
X-Gm-Gg: ASbGncshg77DbSv0gHlLwEZfO785ohDspcPtcc+21KOhxBmW28ht/JzTQ/1kVpf4M50
 HOteg71qG9Oh3OxBWdlD4wV3dSoFkSvFaaU/IAiASid+KlibkmQVUFgNdIlf2VWmAlXS4q7fD7d
 4tG+8MbGBWX0BIFkEhnRU/FDAMUC0LZijd6JsFMqTuw6FOEbnbXIub1pQVLWP/hX71OThphYeFJ
 sVUlrY/lRT+SvIWmU8fX3ty0xZ4D7ThNQDQNLXDEzAUzWWarJEo4Nl7xmi8Qcuu/JNJd/Rj1s26
 x8qM7ltDcUH0KeK6QW8F3leRvRhUg3RPKGVeCDatPMBO5Olu+xjjKzQOMsVEpkY=
X-Google-Smtp-Source: AGHT+IGaHjTq81upYeE7JJJGXwYqFasBVSRbOjiYfGS75PLHdIX79Ur0yh9/uI89L7Do0NFxDqJKhg==
X-Received: by 2002:a05:6a00:21c6:b0:725:4915:c0f with SMTP id
 d2e1a72fcca58-72abdbd7f45mr1241071b3a.11.1734659746536; 
 Thu, 19 Dec 2024 17:55:46 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:55:46 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 18/39] docs: update riscv/virt.rst with kernel-irqchip=split
 support
Date: Fri, 20 Dec 2024 11:54:18 +1000
Message-ID: <20241220015441.317236-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
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


