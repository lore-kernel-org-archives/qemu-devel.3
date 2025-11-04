Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A10CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 13:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGGrU-0002vK-2q; Tue, 04 Nov 2025 08:14:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-2025110413035315aaa1fd07000207fc-ELuPtv@rts-flowmailer.siemens.com>)
 id 1vGGrN-0002qw-D9
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:14:06 -0500
Received: from mta-65-226.siemens.flowmailer.net ([185.136.65.226])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-2025110413035315aaa1fd07000207fc-ELuPtv@rts-flowmailer.siemens.com>)
 id 1vGGrG-0005VS-S0
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:14:05 -0500
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 2025110413035315aaa1fd07000207fc for <qemu-devel@nongnu.org>;
 Tue, 04 Nov 2025 14:03:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Aa16IkTRH9wGRMcu8vItbojNNj/gEEQnYnW57vAlPSA=;
 b=H3l6VBrh1DY426vkI8yN4v8MnXz9awskKkbmP5DjNV+gy6cueUMXbNdT/IsjfjTOLR3FZM
 GNiu5O2i5WMI8hEMe1yBJ05Al60TcfwVJ+MPsb9/cVLJD5DU0CKL/cpyxYrTYnFETAWXV9oS
 kGFA5QattwXCXRXT9/jqXptRcfxPsMqwq17tyi99AJ3xwCpwXV3bqaiUtzWnSewb44OXEHzX
 h1biCcd0AsUgJZTfegmAt8GIAgFHDL+1kGvQ52FNOdPcQyhXLIxzk/5G5HJ7OE14k+QskqxD
 QdigAU77+yDv9JurU2+56JgC0ZVrItMnUHItNy4W5tdzT0rtsptIvVqQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Jan=20L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v6 6/6] docs: Add eMMC device model description
Date: Tue,  4 Nov 2025 14:03:50 +0100
Message-ID: <b9c3ff21e7170fef5d0e7d08698a113d2a64e649.1762261430.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1762261430.git.jan.kiszka@siemens.com>
References: <cover.1762261430.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.65.226;
 envelope-from=fm-294854-2025110413035315aaa1fd07000207fc-ELuPtv@rts-flowmailer.siemens.com;
 helo=mta-65-226.siemens.flowmailer.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 docs/system/device-emulation.rst |  1 +
 docs/system/devices/emmc.rst     | 53 ++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 docs/system/devices/emmc.rst

diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index db714ad47a..971325527a 100644
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
index 0000000000..7e15b62270
--- /dev/null
+++ b/docs/system/devices/emmc.rst
@@ -0,0 +1,53 @@
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
+    scripts/mkemmc.sh -b firmware.img -r /dev/zero:2MB os.img emmc.img
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


