Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765E2C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJZV-0001UH-TD; Mon, 01 Jul 2024 12:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZF-0000pU-PC
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZC-0005UK-KJ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42567ddf099so23097765e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850063; x=1720454863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9uXU1vzi0vhcsx2TB1L2j4c0uA3H0oIo7+Hi7Wb/bB0=;
 b=ek6OHYSqNryR/d9WKcmHwNuqA/h1H/upU8q58ytfQg2nCXEUmxAS12lj+4OqeoJqHK
 4EvOqi95MkAOlSmeh0twFBs+6M67booCgF1ynfi25VUksxRBjOf3TdjDZcLXzmljY3C/
 ZGunQmqy/nGpWn6u+NS2osWGn8l4ylg+Lo0xQ80d4F8ngcVsAda5WfbCwZ2yRPXSK2mf
 G5N2iaUjtmjDeN1iDWyaeeV2Umjp+xODk+A+ZrCLiGMyk/OHLBCo25uiVNPKFbUl4kA7
 y0omek1m9HYuRXKzlkiEFqKGO2l+UgLikXzSAlZl50zEcjHjAo1SnQMNxagcCuzOxJCl
 ZszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850063; x=1720454863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9uXU1vzi0vhcsx2TB1L2j4c0uA3H0oIo7+Hi7Wb/bB0=;
 b=JdkLYTuO6/14Vt3KIpvr8F9dYMC2fjtSJIHoRjMSvsvgo3trMNfxlWY021FmmiXSNG
 5cNM/LnHIlLiU72OlMSd/2ug04NCDV9KFnfhPh6v1Va6ER43g4KDpgbQo94TjGa8rB9o
 08VDCybw+Tv4bg75DDvh/LV2tkR6oQ/k0J2sxz++gaifRg2E5oDHsrg8SN1xq8+nCQty
 VFMOkVAevAOnBtkwmHKa3ZIBEfyNaknFx/YnoEJeVtvNUtsGnE1+HPnPsgcdjqazl5Ju
 eSEpqYS+gDBxULqfDT5GMXMCi++20Unn9lOTAl4V8YZyS3HkdnA8MlnGN59//0F913Ea
 VRWQ==
X-Gm-Message-State: AOJu0Yza2Hrd1CKJoGKxFVWcpWTJyr6yq4ljffLFvax+fzObmnZvzuqy
 D28fQLV7OqUSFs47R1ilVSekjpno2G+o+ptT0zDdHeFHeRvU7eleD0OQbbJAEiU8xc7z51+01EO
 y/f4=
X-Google-Smtp-Source: AGHT+IH1HEYxMCvAqRD5L9B0oFyFKXFkyG9Pcewl0q8oUzrRE9oKW3KtdisyKy47GVs0ZfySysMZcw==
X-Received: by 2002:a05:600c:4f52:b0:425:65b1:abbc with SMTP id
 5b1f17b1804b1-4257a00aae8mr38071535e9.1.1719850063632; 
 Mon, 01 Jul 2024 09:07:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/29] docs/system/arm: Add a doc for zynq board
Date: Mon,  1 Jul 2024 17:07:26 +0100
Message-Id: <20240701160729.1910763-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>

Added the supported device list and an example command.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Message-id: 20240621125906.1300995-4-sai.pavan.boddu@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                   |  1 +
 docs/system/arm/xlnx-zynq.rst | 47 +++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst    |  1 +
 3 files changed, 49 insertions(+)
 create mode 100644 docs/system/arm/xlnx-zynq.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 13255d4a3bd..6725913c8b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1033,6 +1033,7 @@ F: hw/adc/zynq-xadc.c
 F: include/hw/misc/zynq_slcr.h
 F: include/hw/adc/zynq-xadc.h
 X: hw/ssi/xilinx_*
+F: docs/system/arm/xlnx-zynq.rst
 
 Xilinx ZynqMP and Versal
 M: Alistair Francis <alistair@alistair23.me>
diff --git a/docs/system/arm/xlnx-zynq.rst b/docs/system/arm/xlnx-zynq.rst
new file mode 100644
index 00000000000..ade18a3fe13
--- /dev/null
+++ b/docs/system/arm/xlnx-zynq.rst
@@ -0,0 +1,47 @@
+Xilinx Zynq board (``xilinx-zynq-a9``)
+======================================
+The Zynq 7000 family is based on the AMD SoC architecture. These products
+integrate a feature-rich dual or single-core Arm Cortex-A9 MPCore based
+processing system (PS) and AMD programmable logic (PL) in a single device.
+
+More details here:
+https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Zynq-7000-SoC-Technical-Reference-Manual
+
+QEMU xilinx-zynq-a9 board supports following devices:
+    - A9 MPCORE
+        - cortex-a9
+        - GIC v1
+        - Generic timer
+        - wdt
+    - OCM 256KB
+    - SMC SRAM@0xe2000000 64MB
+    - Zynq SLCR
+    - SPI x2
+    - QSPI
+    - UART
+    - TTC x2
+    - Gigabit Ethernet Controller x2
+    - SD Controller x2
+    - XADC
+    - Arm PrimeCell DMA Controller
+    - DDR Memory
+    - USB 2.0 x2
+
+Running
+"""""""
+Direct Linux boot of a generic ARM upstream Linux kernel:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M xilinx-zynq-a9 \
+        -dtb zynq-zc702.dtb  -serial null -serial mon:stdio \
+        -display none  -m 1024 \
+        -initrd rootfs.cpio.gz -kernel zImage
+
+For configuring the boot-mode provide the following on the command line:
+
+.. code-block:: bash
+
+   -machine boot-mode=qspi
+
+Supported values are jtag, sd, qspi, nor.
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 870d30e3502..7b992722846 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -109,6 +109,7 @@ undocumented; you can get a complete list by running
    arm/virt
    arm/xenpvh
    arm/xlnx-versal-virt
+   arm/xlnx-zynq
 
 Emulated CPU architecture support
 =================================
-- 
2.34.1


