Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700D7D1AD45
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 20:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Apl-0004cZ-AS; Wed, 16 Oct 2024 16:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t1Apk-0004c0-Kn
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 16:41:28 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t1Api-0004iM-ME
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 16:41:28 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e2bb1efe78so157909a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 13:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1729111285; x=1729716085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4xBP2QStnLr7rsEthjKQX61QbXunCSIN41n1uqfLQg=;
 b=FgZM/aml9ic+0YEgZlhRa3N/DlKr8DjHqHrkVUPneXToKT9Sp0w+U5en+LBMrpTUd9
 0xLeJJ/0fZ/Ysj2b0E/jBh8+Tmg3+rEP2bDF9qzDHFbvMEud3IyJCoM2yB94LIECBmyl
 S83JDJ8f0UXsi3Tec22EYAI1mFcZN8+dycsOdI5jbKGzgCYVslQdZdbsB3cg1JKNeEd9
 BwHyTNU9ZIlyIxDhuhzdUUnwhkNJhpxW7NUmod3/pphvXssfhRSM4YpXuo6EAi6D+1Gu
 EEghLdqfYg1eEgMlMbF+UVG3v2yhz9wFAO05p+rcC1TsisHvsEA8pDI6vnTtCloDBmTL
 5MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729111285; x=1729716085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I4xBP2QStnLr7rsEthjKQX61QbXunCSIN41n1uqfLQg=;
 b=UVLtsoiDI/FnTSGUj2UyhZNGaqq5bjtGsoehDzajAWAf7r3UdUOq72BZhNmEPvvTXu
 VjmQhZzCWe3G8iHk9Br75/uykbwyNKLPARp4ZQ9a4W2yGnZrFilhntBSsCtiWWxuL+8j
 ojM54p4GeQJFssmouxQTfiP7gynggbcST43IcA1cI7/0s0jIvzUG3UXHoKg/t32mcZQj
 igt+AJmy2J1OWeFGZp5XREC4lIy2V6M47CusLXcCXoNrZRBD8SkMLKOtzAd//SIb/EnM
 W1O43naFiJtja/E95F/HxBeGba3WS/OtgD7QJ3DfDt3+hB0RLLKNSmee4DkbeRMAVIGn
 Dedw==
X-Gm-Message-State: AOJu0Yzjji52FY+43mnIC7iBpliQ6cYR66pW4KOptX4UYdZZOh8Qug5r
 ZIztk681V3qVNLl64rV6NqaJxZgnDSjAfUav+5bIZkPPGZ1H9V/lWSJfjnz/Jhrlsa5EVuV7YNC
 8
X-Google-Smtp-Source: AGHT+IEhJOOXG8gdPWb0gJ7hTfUSuLX9TYmLeMf0GlFNruu8KtJBPpi+UHRprZrYBdfYcWYWdBPoTA==
X-Received: by 2002:a17:90a:fa98:b0:2e0:8780:ecb with SMTP id
 98e67ed59e1d1-2e3dc277e05mr1324536a91.12.1729111285016; 
 Wed, 16 Oct 2024 13:41:25 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.188.133.9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e3e09085cfsm242158a91.54.2024.10.16.13.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 13:41:24 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v10 12/12] docs/specs: add riscv-iommu
Date: Wed, 16 Oct 2024 17:40:36 -0300
Message-ID: <20241016204038.649340-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241016204038.649340-1-dbarboza@ventanamicro.com>
References: <20241016204038.649340-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1030.google.com
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

Add a simple guideline to use the existing RISC-V IOMMU support we just
added.

This doc will be updated once we add the riscv-iommu-sys device.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/specs/index.rst       |  1 +
 docs/specs/riscv-iommu.rst | 90 ++++++++++++++++++++++++++++++++++++++
 docs/system/riscv/virt.rst | 13 ++++++
 3 files changed, 104 insertions(+)
 create mode 100644 docs/specs/riscv-iommu.rst

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 6495ed5ed9..ff5a1f03da 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -36,3 +36,4 @@ guest hardware that is specific to QEMU.
    vmgenid
    rapl-msr
    rocker
+   riscv-iommu
diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
new file mode 100644
index 0000000000..463f4cffb6
--- /dev/null
+++ b/docs/specs/riscv-iommu.rst
@@ -0,0 +1,90 @@
+.. _riscv-iommu:
+
+RISC-V IOMMU support for RISC-V machines
+========================================
+
+QEMU implements a RISC-V IOMMU emulation based on the RISC-V IOMMU spec
+version 1.0 `iommu1.0`_.
+
+The emulation includes a PCI reference device, riscv-iommu-pci, that QEMU
+RISC-V boards can use.  The 'virt' RISC-V machine is compatible with this
+device.
+
+riscv-iommu-pci reference device
+--------------------------------
+
+This device implements the RISC-V IOMMU emulation as recommended by the section
+"Integrating an IOMMU as a PCIe device" of `iommu1.0`_: a PCI device with base
+class 08h, sub-class 06h and programming interface 00h.
+
+As a reference device it doesn't implement anything outside of the specification,
+so it uses a generic default PCI ID given by QEMU: 1b36:0014.
+
+To include the device in the 'virt' machine:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 -M virt -device riscv-iommu-pci,[optional_pci_opts] (...)
+
+This will add a RISC-V IOMMU PCI device in the board following any additional
+PCI parameters (like PCI bus address).  The behavior of the RISC-V IOMMU is
+defined by the spec but its operation is OS dependent.
+
+As of this writing the existing Linux kernel support `linux-v8`_, not yet merged,
+does not have support for features like VFIO passthrough.  The IOMMU emulation
+was tested using a public Ventana Micro Systems kernel repository in
+`ventana-linux`_.  This kernel is based on `linux-v8`_ with additional patches that
+enable features like KVM VFIO passthrough with irqbypass.  Until the kernel support
+is feature complete feel free to use the kernel available in the Ventana Micro Systems
+mirror.
+
+The current Linux kernel support will use the IOMMU device to create IOMMU groups
+with any eligible cards available in the system, regardless of factors such as the
+order in which the devices are added in the command line.
+
+This means that these command lines are equivalent as far as the current
+IOMMU kernel driver behaves:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 \
+        -M virt,aia=aplic-imsic,aia-guests=5 \
+        -device riscv-iommu-pci,addr=1.0,vendor-id=0x1efd,device-id=0xedf1 \
+        -device e1000e,netdev=net1 -netdev user,id=net1,net=192.168.0.0/24 \
+        -device e1000e,netdev=net2 -netdev user,id=net2,net=192.168.200.0/24 \
+        (...)
+
+  $ qemu-system-riscv64 \
+        -M virt,aia=aplic-imsic,aia-guests=5 \
+        -device e1000e,netdev=net1 -netdev user,id=net1,net=192.168.0.0/24 \
+        -device e1000e,netdev=net2 -netdev user,id=net2,net=192.168.200.0/24 \
+        -device riscv-iommu-pci,addr=1.0,vendor-id=0x1efd,device-id=0xedf1 \
+        (...)
+
+Both will create iommu groups for the two e1000e cards.
+
+Another thing to notice on `linux-v8`_ and `ventana-linux`_ is that the kernel driver
+considers an IOMMU identified as a Rivos device, i.e. it uses Rivos vendor ID.  To
+use the riscv-iommu-pci device with the existing kernel support we need to emulate
+a Rivos PCI IOMMU by setting 'vendor-id' and 'device-id':
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 -M virt	\
+     -device riscv-iommu-pci,vendor-id=0x1efd,device-id=0xedf1 (...)
+
+Several options are available to control the capabilities of the device, namely:
+
+- "bus": the bus that the IOMMU device uses
+- "ioatc-limit": size of the Address Translation Cache (default to 2Mb)
+- "intremap": enable/disable MSI support
+- "ats": enable ATS support
+- "off" (Out-of-reset translation mode: 'on' for DMA disabled, 'off' for 'BARE' (passthrough))
+- "s-stage": enable s-stage support
+- "g-stage": enable g-stage support
+
+.. _iommu1.0: https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf
+
+.. _linux-v8: https://lore.kernel.org/linux-riscv/cover.1718388908.git.tjeznach@rivosinc.com/
+
+.. _ventana-linux: https://github.com/ventanamicro/linux/tree/dev-upstream
diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 9a06f95a34..8e9a2e4dda 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -84,6 +84,19 @@ none``, as in
 
 Firmware images used for pflash must be exactly 32 MiB in size.
 
+riscv-iommu support
+-------------------
+
+The board has support for the riscv-iommu-pci device by using the following
+command line:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 -M virt -device riscv-iommu-pci (...)
+
+Refer to :ref:`riscv-iommu` for more information on how the RISC-V IOMMU support
+works.
+
 Machine-specific options
 ------------------------
 
-- 
2.45.2


