Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626F7CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGL9y-0004en-B6; Tue, 04 Nov 2025 12:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGL9W-0004Or-Q4
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:49:17 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGL9V-0005mC-7E
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:49:06 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6409e985505so5249126a12.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 09:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762278543; x=1762883343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aiadY5QJPEYHmcpiUboyh5r4o+/TwBKt8ckhTG3KysA=;
 b=TD6O04HiXvVlCDlf6XMLBoZvbEN26/YFzM2G14A7qAiIpNlIBDR4ogzZ5x5y5s/xQC
 zfYOUASmHtpWvtYTf1CjfRpozU2Z5g5E80TO0cgkJSM2f84bj+SIfhoG8oZ0OnWmtsWq
 3dw2HWdBlUY2MBEOtiQQF2077d7YYJ8SHQSTSwkXoSymSmnzRme3n9hqOjGs/KFbc8fD
 2by2oZ24ZqUd6ZbgFFby6k1j0aZ+sH/U89qv5IcLBzxNfF0VptL0+l8CUlKLaZn/go70
 by8bxwJ8Zi1LaKHE141XE14WhCYc+da0u/vAlFi8DTGuJ9nwZM9k2srAi4IsK6nAKJYa
 lusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762278543; x=1762883343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aiadY5QJPEYHmcpiUboyh5r4o+/TwBKt8ckhTG3KysA=;
 b=nSOCbgIzkR8nOkvWaRAuSFjHB9Oabyj4hoO5ytLIAX8WqzPiO1pvTTrgVeOZ3RpqOr
 2rwZapJoNueagmq69hQInLtcJtXXTSh2CvWCfINiX1LLklaUsRO/4ISiqbmn92cXeGpH
 sXg+JdTGCiKvguN+pc0asUCTVwb3yLvuO9WGstcb6c/gMW4JjSRCuSj7D/8lpwSiYprc
 0oIQYzF5R95qzmE0Vnu8iOZjlm0TgBjV7pG2V5UKh7AStTLOmygBJpICX2RQOL0oFAxa
 a7272UXkvlg9BbWiDHrM6cWUJEiLvh/uek+/4MBM9fHKABac5dDjoUAuymqNvi4/3iLC
 Lhbg==
X-Gm-Message-State: AOJu0Yx8G13euni09NvejEYU6RzFQ/mWDXEpKdHJ7tQyHzdmMdnD50SQ
 aI0UYzO5g16jE5gJzrEKZraudeB4mg1D0NHyWcoLPKVTid7dHSUwbYpYgqSPNkrMl8QIb3dahda
 A84EChKesbg==
X-Gm-Gg: ASbGncvD/SWy8C3RYUXsZ8H+uXTTKvmtQVvpZLvt2EC4YFYmq2fvjT9/NzpirrLWX5L
 7D6jTCC70oZ5K0Wx+56J4EnRU8qyYB9TBzWw0z5aBm+fY8BrVdCGD400vqES0/PhSInjw2NMJWl
 Ix8lqKucWicUOtwi16W6Z9PBts3+suVX5XEck98ek9TFBmtBaV32OYyg17KmfTBKEcPkyEiUyny
 +Vbtn6uLZZxZqT2QMeyhZghchhTJXAur4wcnTjntXru4Ncrsh4IZd232pxLzXexkiLVGdDZx3Z+
 5tUniCXXw9870qDar80/8xgu55BOgrKws/FBejO8ikkTYEZFGbB1iQl6S0kKAIfP0wsMGVVubT1
 M7mQT68yASdXvdepvKENt4yZvX1kHO20LHI7R2drqVGhsv9f5GrtxqMml1jGPXkcJUk4Tl4fh+f
 DcJTshgDc1RxNp8/sqnXHeOQ==
X-Google-Smtp-Source: AGHT+IEbkuoF8c4UWfjH5v02tUeqKNe63ReKszxvf2TayKaOa6IZUGpWv3VNl5uJ8jwmdPEoJLq7IQ==
X-Received: by 2002:a17:907:3f1d:b0:b70:d149:c33d with SMTP id
 a640c23a62f3a-b72652981b1mr1926066b.18.1762278542928; 
 Tue, 04 Nov 2025 09:49:02 -0800 (PST)
Received: from localhost.localdomain ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723f6e06edsm282860366b.47.2025.11.04.09.49.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Nov 2025 09:49:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/8] docs: Add eMMC device model description
Date: Tue,  4 Nov 2025 18:48:21 +0100
Message-ID: <20251104174823.92412-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104174823.92412-1-philmd@linaro.org>
References: <20251104174823.92412-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <b9c3ff21e7170fef5d0e7d08698a113d2a64e649.1762261430.git.jan.kiszka@siemens.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/system/device-emulation.rst |  1 +
 docs/system/devices/emmc.rst     | 55 ++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 docs/system/devices/emmc.rst

diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index db714ad47aa..971325527a1 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -88,6 +88,7 @@ Emulated Devices
    devices/canokey.rst
    devices/ccid.rst
    devices/cxl.rst
+   devices/emmc.rst
    devices/igb.rst
    devices/ivshmem-flat.rst
    devices/ivshmem.rst
diff --git a/docs/system/devices/emmc.rst b/docs/system/devices/emmc.rst
new file mode 100644
index 00000000000..e62adfd68ed
--- /dev/null
+++ b/docs/system/devices/emmc.rst
@@ -0,0 +1,55 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+==============
+eMMC Emulation
+==============
+
+Besides SD card emulation, QEMU also offers an eMMC model as found on many
+embedded boards. An eMMC, just like an SD card, is connected to the machine
+via an SDHCI controller.
+
+Create eMMC Images
+==================
+
+A recent eMMC consists of 4 partitions: 2 boot partitions, 1 Replay protected
+Memory Block (RPMB), and the user data area. QEMU expects backing images for
+the eMMC to contain those partitions concatenated in exactly that order.
+However, the boot partitions as well as the RPMB might be absent if their sizes
+are configured to zero.
+
+The eMMC specification defines alignment constraints for the partitions. The
+two boot partitions must be of the same size. Furthermore, boot and RPMB
+partitions must be multiples of 128 KB with a maximum of 32640 KB for each
+boot partition and 16384K for the RPMB partition.
+
+The alignment constrain of the user data area depends on its size. Up to 2
+GByte, the size must be a power of 2. From 2 GByte onward, the size has to be
+multiples of 512 byte.
+
+QEMU is enforcing those alignment rules before instantiating the device.
+Therefore, the provided image has to strictly follow them as well. The helper
+script ``scripts/mkemmc.sh`` can be used to create compliant images, with or
+without pre-filled partitions. E.g., to create an eMMC image from a firmware
+image and an OS image with an empty 2 MByte RPMB, use the following command:
+
+.. code-block:: console
+
+    scripts/mkemmc.sh -b firmware.img -r /dev/zero:2M os.img emmc.img
+
+This will take care of rounding up the partition sizes to the next valid value
+and will leave the RPMB and the second boot partition empty (zeroed).
+
+Adding eMMC Devices
+===================
+
+An eMMC is either automatically created by a machine model (e.g. Aspeed boards)
+or can be user-created when using a PCI-attached SDHCI controller. To
+instantiate the eMMC image from the example above in a machine without other
+SDHCI controllers while assuming that the firmware needs a boot partitions of
+1 MB, use the following options:
+
+.. code-block:: console
+
+    -drive file=emmc.img,if=none,format=raw,id=emmc-img
+    -device sdhci-pci
+    -device emmc,drive=emmc-img,boot-partition-size=1048576,rpmb-partition-size=2097152
-- 
2.51.0


