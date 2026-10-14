Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AACCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpqv-00067b-DG; Tue, 13 Oct 2026 23:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqs-00061h-Iu
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:26 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqq-0001dQ-RD
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:26 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cd5cd8d89a7so1351106a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949223; x=1792554023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=onxH5xaXGYs06cR0g4oHf9Uk1UJ4V7TLXfKObSt2hvA=;
 b=WA23b5OzGAuBf/hKGvIt05hry91DjRohwpxbs98Q9X9yr5K+MCOUAKHxSw6Fh8Bjxs
 hCbJOQFfO2+ApsSDxuvvycmxPCOlmvMXT8NZDcU2TO5q3dCEX2p2Zmyulwo6gYEMIF1e
 rCUF3Iu/WKEbZA/NXvGIUl0yHpnGETEmrOCbvSH9kqVxhG/isksbqLntH6SRdgI048np
 izaxZXePOFesbm5Z2zzLql1nvecAeQ7IadiyUgsrWUZp9Y13178cJ4F23xm/Ca9ZzRHp
 K1PZ9g5usfQYm+oGxcQ9TEer3OH5KKHg0zazd13sofaN5STV1p1Ot+b85lrpcBfOj/h0
 QuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949223; x=1792554023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=onxH5xaXGYs06cR0g4oHf9Uk1UJ4V7TLXfKObSt2hvA=;
 b=AlevNSJJj1WmV0ZmS3drIlewl8AVy0JtDA4hbatWjbREvem9UWanicrMF3M8ff40Gq
 T2j5FllBkgdgwGelYMeysqeUsTIDqfBccGml7D/5zV3dHDa4/3McdG7aRknQzCQGJ3XK
 qEhBjsZrHQcA60q6LQc4C0+dZiPnvspTDVs945ncqQrWI4vnOHEZ8SPnmk9t7NHFpB3h
 cIy8JNUA1dRqL9HpL32C+acz2ze0VDos9NhAOl5383AaFw/Y/VFkN/uZa+zz9X6+gNF9
 Ona8cNRnT3S1JhWLjaY20flDQgckPiu2AkDb/xOZ0YBUCGDcfbJb0mmtMl4SvMy8+Qbl
 Jptw==
X-Gm-Message-State: AFq9FYL9f8oFdqAKd9jN4vYxJv8Rmqee33jqXobbzs2HBJBEuEusSUsy
 Rnfo0ET8MgjDWYg3hys4fJa/y+ObOAVCIciMRPpsb51DKx2PLH4v17OnQEQR4Q==
X-Gm-Gg: AYBFou3MQ6zwfY+KMHUweMPDLPYjgjiC6Z4qdS5Fbu0/qpYSZnuPSaPtkw+c+gY63V2
 zyIuTJB874NngrPCs32J1KMAYwun6q5mcW1CRPoDBhvwd8N65W959F4M6Yypn2AGVnyIGvpbjFk
 dV5fL2yAwNIfA5MsmwWnKzyojV2DJ9bUgwuBAILFNCFpwh0085OkZQiEulzyB4vZZc1OJO9FhV/
 cd0aZmZdRj6DqZKMFTZ/6OMMtJOwqZQRWWA8Hgf8CVTioPuXuheQ/rQZ8m5rii1ULApcOE1h1jn
 DEJ7or+kV5p0B/wcvvvSci2E2jqWJkL+8sxvCwbgia3M/XMHhsalpvE1+vKbNv929gUHnX+ikAR
 D/0JOFw90/sv07eyaPWW279yJiUqm9RYjdxY9HwNPRdNT+rqJKbp+KX2RPDvWLJrotxaLYogITN
 HFUavABcHClzm1KwiNVK8IWePFveSPfZ0DnKYLPjt3k9cayal/QQ7iyQY2s7sHOEuz17DYawGKN
 4wwLXn9QrE8m6gI
X-Received: by 2002:a17:90b:3b90:b0:3a8:5543:5572 with SMTP id
 98e67ed59e1d1-3ab3a3654admr13256237a91.1.1791949223410; 
 Tue, 13 Oct 2026 20:40:23 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:40:22 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/52] docs/system/riscv: Add Milk-V Duo board documentation
Date: Wed, 14 Oct 2026 13:38:35 +1000
Message-ID: <20261014033907.3332383-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kuan-Wei Chiu <visitorckw@gmail.com>

Add documentation for the Milk-V Duo board. This includes a brief
overview of the hardware, a list of supported devices, and practical
instructions on how to boot the machine using OpenSBI and a Linux
kernel with an emulated SD card.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260927201326.650943-8-visitorckw@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                     |  1 +
 docs/system/riscv/milkv-duo.rst | 49 +++++++++++++++++++++++++++++++++
 docs/system/target-riscv.rst    |  1 +
 3 files changed, 51 insertions(+)
 create mode 100644 docs/system/riscv/milkv-duo.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 4092228bea..cebc287fdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1878,6 +1878,7 @@ F: tests/qtest/k230-decomp-gzip-test.c
 Milk-V Duo
 M: Kuan-Wei Chiu <visitorckw@gmail.com>
 S: Maintained
+F: docs/system/riscv/milkv-duo.rst
 F: hw/misc/cv1800b_clk.c
 F: hw/riscv/cv1800b.c
 F: hw/riscv/milkv_duo.c
diff --git a/docs/system/riscv/milkv-duo.rst b/docs/system/riscv/milkv-duo.rst
new file mode 100644
index 0000000000..1758db2c1e
--- /dev/null
+++ b/docs/system/riscv/milkv-duo.rst
@@ -0,0 +1,49 @@
+Milk-V Duo board (``milkv-duo``)
+================================
+
+The ``milkv-duo`` machine is compatible with the Milk-V Duo development board.
+
+The Milk-V Duo is an ultra-compact embedded development platform based on the
+Sophgo CV1800B SoC. The CV1800B features T-Head C906 RISC-V processing cores
+along with integrated peripherals.
+
+For more information, see <https://milkv.io/duo>
+
+Supported devices
+-----------------
+The ``milkv-duo`` machine supports the following devices:
+
+* T-Head C906 cores
+* Core Local Interruptor (CLINT)
+* Platform-Level Interrupt Controller (PLIC)
+* DesignWare APB UART (dw8250)
+* SDHCI controller
+* CV1800B clock controller
+
+Boot options
+------------
+The ``milkv-duo`` machine supports direct boot using a generic RISC-V OpenSBI
+firmware and a Linux kernel. The root filesystem can be provided via the
+emulated SD card.
+
+Running
+-------
+To boot the machine, you need a Linux kernel (built with CV1800B support), a
+device tree blob (DTB), and a root filesystem image (e.g., built via BusyBox
+or Buildroot).
+
+Use the following command to boot the system directly to the Linux shell:
+
+.. code-block:: bash
+
+   $ qemu-system-riscv64 -M milkv-duo -nographic \
+      -bios pc-bios/opensbi-riscv64-generic-fw_dynamic.bin \
+      -dtb /path/to/linux/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dtb \
+      -kernel /path/to/linux/arch/riscv/boot/Image \
+      -drive file=/path/to/rootfs.ext4,format=raw,id=sd-card \
+      -device sd-card,drive=sd-card \
+      -append "console=ttyS0,115200 root=/dev/mmcblk0 rootwait earlycon"
+
+This command boots the generic OpenSBI firmware, loads the Linux Image and the
+specified DTB, and mounts the ext4 root filesystem from the emulated SD card.
+The console output is routed to the ``ttyS0`` serial port.
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 2639866a3e..1e49055e29 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -69,6 +69,7 @@ undocumented; you can get a complete list by running
    riscv/k230
    riscv/microblaze-v-generic
    riscv/microchip-icicle-kit
+   riscv/milkv-duo
    riscv/mips
    riscv/shakti-c
    riscv/sifive_u
-- 
2.55.0


