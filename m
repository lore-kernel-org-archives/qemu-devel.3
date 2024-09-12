Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2EDEE644B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socQk-00052k-5C; Thu, 12 Sep 2024 01:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQN-0003kc-KF
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:25 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQJ-00035n-Gj
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:21 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7191f58054aso453604b3a.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119078; x=1726723878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8QtNUqA5hzjqHQ1utnO5lqd/Ye1GPhrNMIuM3vhjm+0=;
 b=B0g+g8jFB3lI0305ng+TqcInwe2LYe+xdSgiH37+wrdCyEnePmMPKfcfM9Pdq6TWMU
 K8UDFFBzdty8aHBW3XifgmpumRxBDQcjVD+dEaWX/H7xI++Zxh5KfGsRnX5YnUDrqsKR
 glFik/wmBLT+brI2FqFJKc/sFsWh+DK1JHRgQbVnU8uHGRK6u87sgtDxdG2N3pJlm9/W
 G6ACeDe/sK+d8A0AR5HwZMWd/zIVNJYCkmZRNy51n9iCAtBav9rprP3ow3D0erKDF67X
 vmArcz6CHYZ+wsmCF5mohti4+phvHD9GsF5rG0I44XzpAadE4jlOvGafhVzF3i7skIhn
 079g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119078; x=1726723878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8QtNUqA5hzjqHQ1utnO5lqd/Ye1GPhrNMIuM3vhjm+0=;
 b=tv4CgKszLRuOVkmP325fFi/LHMbuOslYjrlNy7Dq9MAxs3zm3HlCTjmYMrU4H0KX04
 HABuj4rXFYWkDt4empCBVLoj+LNJ9ZNk54XIJ+y9/6Rkri+uxwTVEA1ZKIYQYcGtX3DT
 +NBZu6rjvRWaHdCKDcv7ZvTJHBFEQUTrGAlimYgfHCcenuaPDmf8vetUQGZbZFrLHIyf
 33htrjK4h2VtEjjUHZYd2PLPVFdo4vVhfFdwbrBUyOfNrjO91SuawkQlhf98CMPNOeUT
 aG9Kj6itxIhuM/6oXsJnL9NudqdT2veB74+hD/Ij17Uw3jlQI1vMNYIZCBF06zCBCVha
 zVnA==
X-Gm-Message-State: AOJu0Yw1HAn86erGdDAV71xEs/OuH1/2IeYAyW+d/cku2d0bCe2+j550
 bQniZaSB7cwFKA9Iuaduhk+Rs74AbPW+f/55Tkve+vjXR5Gk+6XvgeZ8EA==
X-Google-Smtp-Source: AGHT+IHH95tQmZCBxavcXX2jMWDZ/OxbWcvZxPjMZjLVJLd/qUz9NzVgoxebllCydgb5wnSJ18N7Og==
X-Received: by 2002:a05:6a20:db0a:b0:1d0:3a28:d2ad with SMTP id
 adf61e73a8af0-1d03a28d330mr311102637.33.1726119077660; 
 Wed, 11 Sep 2024 22:31:17 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:31:17 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/47] docs/specs: add riscv-iommu
Date: Thu, 12 Sep 2024 15:29:30 +1000
Message-ID: <20240912052953.2552501-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
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

Add a simple guideline to use the existing RISC-V IOMMU support we just
added.

This doc will be updated once we add the riscv-iommu-sys device.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240903201633.93182-13-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.46.0


