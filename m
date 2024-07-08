Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4071AC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 17:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQsHc-0008Ey-Ot; Mon, 08 Jul 2024 13:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sQsHZ-00084H-Mq
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 13:36:10 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sQsHW-0008Fh-23
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 13:36:09 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70afe18837cso2424759b3a.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 10:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1720460157; x=1721064957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ybl4nvVqnampJxkKuJ8/OQ5kDOcVjbQC5dv9c96s0KU=;
 b=eebzaZR4NkTGS0uDwzR+uuBm2i9WBBvIPLur+PhfYD2PbM5SKg9KYE5qyOyqK1Ofk6
 CnG5UxTJOsI6z/Mww/pTKFMhkOQ7c9H1G88wRwyQYTCBqNifozoFLhmIt1m8LjrJ34H7
 Dr+j8L848dnhu4J2R7tMDyxORe/3UJe+yV4ZgkctEqmNEs14CUAIiwlYJra/SD6Zg36S
 8KWsM3vdVc+qq9HN59Gm5Oyz6WjMBH7cDaSQPj7FB5e3FZUMAH1WYPjN/I7MGA+Q9dvy
 Ks8mp97NLH67n/TqD/FZwPe3BIJ5V5ZCIxndqCOEAjFi3tNLfX9GR6w69xzU0+LLHV6A
 YX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720460157; x=1721064957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ybl4nvVqnampJxkKuJ8/OQ5kDOcVjbQC5dv9c96s0KU=;
 b=gn0OQ9NPrW7vsy2iSf5ZmriN42cZv855sNku39ASTIQNw/qA4J1yYsS4Z+aisoNv1m
 3YF74PK0B03ktwwaiBlekJ57occq9MH7qFsio5Cr0wQfmU2bAJu4bcZG+OSAvmjdDB2N
 elV3lwBxMoob6UkPKe8vgbpG1cV0vVC8oARatrJ3rd8/qF3KLZejmm+NTXjv4Rr6pWPo
 LVBsDAxYVG8Uwhyv5pVKwTuW64yPx5M8gcNLgq4/56ZNUIYI/0Yb1aWispV5o9zGqflO
 wjf4f2EtwOBpVGEpVxu2QjdWkfZ3Mef6r1AodUsa3XDK2NTu98IWK1X4G4NW3WAXg9dx
 poSA==
X-Gm-Message-State: AOJu0YzzVdRipzt46oxeBzr9EZKZGp/WnBtkAHFKdKd6vjrVlnEPgdmJ
 ZlRlMMht2MBRFli9CgOEs+5T2bJsI15oEkpGIj5YlOEgYU2YtPcdD5G+vCaczkMDehzlK4gYKxK
 Y
X-Google-Smtp-Source: AGHT+IHDKQSftbcFxl5ayeD2AEv/Mj+QS744+RJURbFPXBIRqmejk/qlFjhXZN/ZoIvHmC5zZ6/6dQ==
X-Received: by 2002:a05:6a20:7f96:b0:1c2:93a7:2556 with SMTP id
 adf61e73a8af0-1c2984cf106mr84529637.41.1720460156715; 
 Mon, 08 Jul 2024 10:35:56 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6ad3829sm1153765ad.299.2024.07.08.10.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 10:35:56 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 frank.chang@sifive.com, tjeznach@rivosinc.com, jason.chien@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 13/13] docs/specs: add riscv-iommu
Date: Mon,  8 Jul 2024 14:35:00 -0300
Message-ID: <20240708173501.426225-14-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708173501.426225-1-dbarboza@ventanamicro.com>
References: <20240708173501.426225-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
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

Add a simple guideline to use the existing RISC-V IOMMU support we just
added.

This doc will be updated once we add the riscv-iommu-sys device.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 docs/specs/index.rst       |  1 +
 docs/specs/riscv-iommu.rst | 55 ++++++++++++++++++++++++++++++++++++++
 docs/system/riscv/virt.rst | 13 +++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 docs/specs/riscv-iommu.rst

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 1484e3e760..c68cd9ae6c 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -33,3 +33,4 @@ guest hardware that is specific to QEMU.
    virt-ctlr
    vmcoreinfo
    vmgenid
+   riscv-iommu
diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
new file mode 100644
index 0000000000..fa38ff7667
--- /dev/null
+++ b/docs/specs/riscv-iommu.rst
@@ -0,0 +1,55 @@
+.. _riscv-iommu:
+
+RISC-V IOMMU support for RISC-V machines
+========================================
+
+QEMU implements a RISC-V IOMMU emulation based on the RISC-V IOMMU spec
+version 1.0 [1].
+
+The emulation includes a PCI reference device, riscv-iommu-pci, that QEMU
+RISC-V boards can use.  The 'virt' RISC-V machine is compatible with this
+device.
+
+A platform device that implements the RISC-V IOMMU will be added in the
+future.
+
+
+riscv-iommu-pci reference device
+--------------------------------
+
+This device implements the RISC-V IOMMU emulation as recommended by the section
+"Integrating an IOMMU as a PCIe device" of [1]: a PCI device with base class 08h,
+sub-class 06h and programming interface 00h.
+
+As a reference device it doesn't implement anything outside of the specification,
+so it uses a generic default PCI ID given by QEMU: 1b36:0014.
+
+To include the device in the 'virt' machine:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 -M virt -device riscv-iommu-pci (...)
+
+As of this writing the existing Linux kernel support [2], not yet merged, is being
+created as a Rivos device, i.e. it uses Rivos vendor ID.  To use the riscv-iommu-pci
+device with the existing kernel support we need to emulate a Rivos PCI IOMMU by
+setting 'vendor-id' and 'device-id':
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 -M virt	\
+     -device riscv-iommu-pci,vendor-id=0x1efd,device-id=0xedf1 (...)
+
+Several options are available to control the capabilities of the device, namely:
+
+- "bus"
+- "ioatc-limit"
+- "intremap"
+- "ats"
+- "off" (Out-of-reset translation mode: 'on' for DMA disabled, 'off' for 'BARE' (passthrough))
+- "s-stage"
+- "g-stage"
+
+
+[1] https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf
+[2] https://lore.kernel.org/linux-riscv/cover.1718388908.git.tjeznach@rivosinc.com/
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


