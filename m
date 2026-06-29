Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D988EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgK-0007Np-0x; Mon, 29 Jun 2026 08:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAg9-00076H-73
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:33 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAg7-0007iN-Cn
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:32 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4624a44e152so2961535f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734490; x=1783339290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mMvYRb9ZsQhXZoGUOGkoiHa6AnRq4mGKiU2SO2LgH2k=;
 b=E4PnGVPx8jnb65cNKQ/gGq7NqeYQpO8TYW+3OqP6zbQH9WTqng7i+PiGHlmDCl0KB5
 gQNb5UJC7mXdM/RDxK6F4IhBYdfS3gpif9S9JoAmpf9cp9aK28N35foLsj5VqJMGYTp1
 DBWTDjkAtDdnswO1WeSkQtzkLDzBzrg0OLr8w7ZoLxyucWWD0AtfoHc7wbeT4iXUIhMl
 yrc6qaK2MsXcyoxuV7dqBDMrpypzTK8P+tYsiaFyzbELxQtRV4ft2uOxe6vxptdeJFpI
 3Sucwc3MZ4SzsYPXmHm6ADcdFZPWZaJy1fzX1wfcZzwbZotnYGhrVJbH0W81HgoTrFuO
 j/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734490; x=1783339290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mMvYRb9ZsQhXZoGUOGkoiHa6AnRq4mGKiU2SO2LgH2k=;
 b=FO1Jo3RzrKW4rDBFsQmYQr1zfkg2SfyrEKMUHsFTwNETvAVvzHJmkAyP3lg2lioHZ7
 UXRTGyErj3QH959ejlAb/ihVz9hD08isE0fop89qa43zZ1/m3dOV7Wh2tzBj6fe7xe4U
 VOztDWDl+DCmyFx8nnRrfV7qECzzJ0dNOt/c9tboMywVHPpDapf5xuknOygmfXbuJPkX
 T4aN/TcIfWvDdIT+QeYDertSR0QjzeybTylzPeeA8AKbVasD1fuhBFt6jkuGLaWP5Fm6
 7pPhvAfx/UO2t/Lh/f12rl5KZsXFrVntJQEQOkSmh53yGrXWEYa1Ziv57G1RgDSICY1s
 bCBg==
X-Gm-Message-State: AOJu0Yyg399QN9ZGHmv3An4jUwccXzDIFd0u5xZNQgQG+VLmwy6Nrad8
 5k5ZTByCLlhS+90O7UghoDuGkt3SnloMkIHRJmjYrx8H3PH3oSMnkKIQxnNd92WHlzKONJIJtqT
 ONbtA
X-Gm-Gg: AfdE7ckprm9jOLAEjtC/lcTqvar6+o1nZrgWOvvXs3GmOBqVFa+3WRyDSMIEZey005Z
 ErCIm88J7beioIIYhbBxAe0GOkhkzDtJsQokXWGtiEsGtDe7ICyq4MGCjfjbAeNdR7kdlwsPWIV
 qQOBF8TAYy6UUTR5evUTN1cBizaRL47zxnqeftasdf13zJTu/bOgTBobLTHZNZ6B5clFxTg9/r2
 FL+mNX8V38F3m/DcGyVK/WA6LDWnnhEO7aqSjjrgZ7n2N2gAcCz7nZBiSJR+/wO/wGLRbs7O1Fw
 xHjs2e4djArNDon0PKHH7xvfZjdRVTxtwMK93uW3YYEI8riSKayY10X/c7FuO5rVDhyYMaDwC8D
 FpiRVKRf9BhEtODsD+b2YXXgoFVwhnfH2FyWdBYZWe1n3e/sHQh+j1O201w9laRHsPeH6Blz7F0
 +s4B1UjgqxdoC7TptuIGcjakviVHRxM2SAWRgN+j/8QsLxMU3lVPpe/7l+C72IKtFk5OLB/837s
 HTd0cFAK3IFyYeLjmjSXg==
X-Received: by 2002:a05:6000:4816:b0:472:55a:ef90 with SMTP id
 ffacd0b85a97d-472055af4a5mr10875317f8f.8.1782734489663; 
 Mon, 29 Jun 2026 05:01:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/54] docs/system/arm/virt: Document accelerated SMMUv3 and
 Tegra241 CMDQV
Date: Mon, 29 Jun 2026 13:00:32 +0100
Message-ID: <20260629120032.1645265-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Add subsections for accel=on (nested Stage-1/Stage-2 translation) and
cmdqv (Tegra241 CMDQV hardware command queues) under "User-creatable
SMMUv3 devices".

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260623104003.36590-1-skolothumtho@nvidia.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/virt.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index f811e662d6..ae0be35d57 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -288,6 +288,32 @@ User-creatable SMMUv3 devices
       -device pxb-pcie,id=pcie.1,numa_node=1
       -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1
 
+  *Accelerated SMMUv3 (nested translation)*
+
+  The ``accel=on`` option enables hardware-accelerated nested translation
+  for vfio-pci passthrough devices. In this mode the guest SMMU driver
+  programs its own Stage-1 page tables, with the host SMMUv3 handling both
+  Stage-1 (guest) and Stage-2 (host) translations in hardware. The host
+  SMMUv3 must support nested translation. This mode requires the iommufd
+  backend and is only supported when booting with ACPI (not device tree).
+
+  When ``accel=on``, QEMU automatically derives the values for the
+  ``ril``, ``ats``, ``oas``, ``ssidsize`` and ``cmdqv`` sub-options
+  from the host SMMUv3 capabilities unless they are set explicitly.
+
+  Example::
+
+      -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0,accel=on
+
+  *Accelerated SMMUv3 command queues (Tegra241 CMDQV)*
+
+  The ``cmdqv`` sub-option enables NVIDIA Tegra241 Command Queue
+  Virtualization (CMDQV) on supported hosts. With CMDQV, each accelerated
+  ``arm-smmuv3`` device gets dedicated hardware command queues and the
+  guest issues SMMU invalidation commands directly to real hardware,
+  bypassing QEMU and improving throughput for workloads that issue many
+  invalidations. Without it, every invalidation command traps into QEMU.
+
 Linux guest kernel configuration
 """"""""""""""""""""""""""""""""
 
-- 
2.43.0


