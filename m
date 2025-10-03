Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997A2CCA470
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WU1-0007g7-P9; Thu, 02 Oct 2025 23:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTz-0007ee-7P
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:29:23 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTq-0001WU-LF
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:29:21 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-781ea2cee3fso1751792b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462146; x=1760066946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ddXRWO1h/Uc4kTIpeeGU0VwoGKslsob3N7dhy8RDHoQ=;
 b=Xiyn3GfOZUg2vzYN3qZL7eUMragKiAxM6yNdqpiYglkWnWCT2QtvvKGkddx7G9fbXD
 0ESGYv5X5XI81uNXIA8OopWjyhG6fwvtH+iueHxDHhUArNFZNhb24cl6gx1tX2QpA8Xe
 +B37hkd5RQOE48XQdMxzpEvdfCtG5VrH4E2Xau+MCpLeY0lYFnbau02HJ9GLoj9sMye/
 qPzwmurHflkFQNkSWmLwQCKW0QHkhFF2wvQDY0Qz/+oA8scR9EwRosnIWTNc4U57lUFv
 B+S3lNaAb5i2xK/TSxFfPYRhdKbvTmnYnLkLBoToYUalN902/cCLsJaq6jPhtv9NdtLj
 11ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462146; x=1760066946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ddXRWO1h/Uc4kTIpeeGU0VwoGKslsob3N7dhy8RDHoQ=;
 b=GpUq42dGtIXUwAia1Vo4VXXPtYs0YnUYCdVC8UDWt00fED6H2kwWWjorzOjWIChaJU
 vVEa5YnPyh0Rx2tmPsWZMJPnUIey30fWayqMXVU99SB1R7YyE/2It04I7CyBdsZL5D8V
 RaiC8OXutkFY16544DpAi3d5QliyHvrC3sv2tgTLZV04gjlleY0QhWBLgCGW208JrLaj
 NcAmCmJ/hVnWbH9y97wcmDFsjiMEM1XfqSaOf8NNA/vxsFDwlo/BHgQRZGu9baEGa6vc
 ezmY2O5r8NmPfcQnWJlc1bbfIWSJCyC1zmp/h4rZ40CIoaLfWhSn00b0HoFxplo4LV3n
 lRFg==
X-Gm-Message-State: AOJu0YzmjsRWoJx3MMpc12IUidA4GGv5ksj8xL9ZZiNesPDXFGQfjHwO
 5/nZDCRoXuuuLSZg+IvbkMb0skST20N1RoI57+Ge4ZDqey5clWuT1swz/I3oEA==
X-Gm-Gg: ASbGncvpswZFogBXI/fWtER/FHrSS43DMMIQgR5FS7nt4eIyBnKWvNyIXPk7r5F0JLh
 Uex8Cp2eAFEI4/dx+tFCwghT69R3AfoaaGQukTxWu0SdLY+j3MFdqWZec4bdRiEFA5aBZCX5OFZ
 pZJJuQgez8wtrL+Tdqc+A0KWeCByDMLKcCEz6cNAuXe6CNiVmd0Fbgc9tfAUZI+H34ZdZyIUCUQ
 HFWMvjcWG+iHHVRYawRKCjUg2EFTyX8ALX0DkEHw3Mjnv/z7ITI3Y8+1m2/6RYdyBLrdesT7P5g
 AghiZZgTLFtkO70YcZHV78/RJYT855Su2zt3nIM5FIUhVzvoEZ+FGsU81+KkGQuM9009aDvkGgj
 CccfJq+rW6em+HmB6lindsiLrlA6CaMIXH43V2FjHB62K/+zGGxK1kMpISNHFF37AjVgRy6gTHt
 BisufAftZQi3UvgDXXtWMyKguXiTpfMdenDXeecgCEH1RCi7GI4c1GM4BkhiT5/ao=
X-Google-Smtp-Source: AGHT+IFvJ4NLE53uIwE6aaIWOWbUOD+42jx28RZS4+TZT/smXrpC7bl33VI04I3D6om7lf+g6JoSSA==
X-Received: by 2002:a05:6a20:12ce:b0:2b7:e136:1f02 with SMTP id
 adf61e73a8af0-32b61dff849mr2054108637.10.1759462145596; 
 Thu, 02 Oct 2025 20:29:05 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:29:04 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/26] docs: riscv-iommu: Update status of kernel support
Date: Fri,  3 Oct 2025 13:27:18 +1000
Message-ID: <20251003032718.1324734-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
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

From: Joel Stanley <joel@jms.id.au>

The iommu Linux kernel support is now upstream. VFIO is still
downstream at this stage.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20250814001452.504510-1-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/specs/riscv-iommu.rst | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
index 991d376fdc..571a6a6cc9 100644
--- a/docs/specs/riscv-iommu.rst
+++ b/docs/specs/riscv-iommu.rst
@@ -30,15 +30,15 @@ This will add a RISC-V IOMMU PCI device in the board following any additional
 PCI parameters (like PCI bus address).  The behavior of the RISC-V IOMMU is
 defined by the spec but its operation is OS dependent.
 
-As of this writing the existing Linux kernel support `linux-v8`_, not yet merged,
-does not have support for features like VFIO passthrough.  The IOMMU emulation
-was tested using a public Ventana Micro Systems kernel repository in
-`ventana-linux`_.  This kernel is based on `linux-v8`_ with additional patches that
-enable features like KVM VFIO passthrough with irqbypass.  Until the kernel support
-is feature complete feel free to use the kernel available in the Ventana Micro Systems
-mirror.
-
-The current Linux kernel support will use the IOMMU device to create IOMMU groups
+Linux kernel iommu support was merged in v6.13. QEMU IOMMU emulation can be
+used with mainline kernels for simple IOMMU PCIe support.
+
+As of v6.17, it does not have support for features like VFIO passthrough.
+There is a `VFIO`_ RFC series that is not yet merged. The public Ventana Micro
+Systems kernel repository in `ventana-linux`_ can be used for testing the VFIO
+functions.
+
+The v6.13+ Linux kernel support uses the IOMMU device to create IOMMU groups
 with any eligible cards available in the system, regardless of factors such as the
 order in which the devices are added in the command line.
 
@@ -49,7 +49,7 @@ IOMMU kernel driver behaves:
 
   $ qemu-system-riscv64 \
         -M virt,aia=aplic-imsic,aia-guests=5 \
-        -device riscv-iommu-pci,addr=1.0,vendor-id=0x1efd,device-id=0xedf1 \
+        -device riscv-iommu-pci,addr=1.0 \
         -device e1000e,netdev=net1 -netdev user,id=net1,net=192.168.0.0/24 \
         -device e1000e,netdev=net2 -netdev user,id=net2,net=192.168.200.0/24 \
         (...)
@@ -58,21 +58,11 @@ IOMMU kernel driver behaves:
         -M virt,aia=aplic-imsic,aia-guests=5 \
         -device e1000e,netdev=net1 -netdev user,id=net1,net=192.168.0.0/24 \
         -device e1000e,netdev=net2 -netdev user,id=net2,net=192.168.200.0/24 \
-        -device riscv-iommu-pci,addr=1.0,vendor-id=0x1efd,device-id=0xedf1 \
+        -device riscv-iommu-pci,addr=3.0 \
         (...)
 
 Both will create iommu groups for the two e1000e cards.
 
-Another thing to notice on `linux-v8`_ and `ventana-linux`_ is that the kernel driver
-considers an IOMMU identified as a Rivos device, i.e. it uses Rivos vendor ID.  To
-use the riscv-iommu-pci device with the existing kernel support we need to emulate
-a Rivos PCI IOMMU by setting 'vendor-id' and 'device-id':
-
-.. code-block:: bash
-
-  $ qemu-system-riscv64 -M virt	\
-     -device riscv-iommu-pci,vendor-id=0x1efd,device-id=0xedf1 (...)
-
 Several options are available to control the capabilities of the device, namely:
 
 - "bus": the bus that the IOMMU device uses
@@ -84,6 +74,7 @@ Several options are available to control the capabilities of the device, namely:
 - "g-stage": enable g-stage support
 - "hpm-counters": number of hardware performance counters available. Maximum value is 31.
   Default value is 31. Use 0 (zero) to disable HPM support
+- "vendor-id"/"device-id": pci device ID. Defaults to 1b36:0014 (Redhat)
 
 riscv-iommu-sys device
 ----------------------
@@ -111,6 +102,6 @@ riscv-iommu options:
 
 .. _iommu1.0.0: https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0.0/riscv-iommu.pdf
 
-.. _linux-v8: https://lore.kernel.org/linux-riscv/cover.1718388908.git.tjeznach@rivosinc.com/
+.. _VFIO: https://lore.kernel.org/linux-riscv/20241114161845.502027-17-ajones@ventanamicro.com/
 
 .. _ventana-linux: https://github.com/ventanamicro/linux/tree/dev-upstream
-- 
2.51.0


