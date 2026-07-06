Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E30AC44501
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggih-0007FK-AH; Mon, 06 Jul 2026 06:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggic-0007Ay-Ph
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:30 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggib-0003Ty-5c
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:30 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-493b1710405so17303235e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334308; x=1783939108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oT5S3GEKtizBkY8GbjowFd2v2R+00DKmaQ0uG/Z2jX0=;
 b=s0srTzHR0LEyPmKejAM1kESqDaCvLAOh3DXevVg9jsDwmyN0Pq/oZfhvlj8NKzRqdp
 ELwhPMrqMqZZCsLX8t22nvFYdfY1BiSkO+gbydosvIe/lZkILt1QS0lHd3fowxyoKM1/
 WHbdeZdC2793aX1C3DLA2RZjI4hutf/n7pg/FJy+jYityoEowbhHcgIQmNBvOxHggRyT
 iZA6B3GUE/oPTPj+153dzOMtGmsmmfZepCDSOftfSoSN8XXukXdcZU3MsaKb7xmJQczP
 n0yWAbFBgywzmc9y/a56urhLSOt3Y4p0vkSeK0zuWmgTHZEG4ANRwFKay1z+mLGzIaHj
 t16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334308; x=1783939108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oT5S3GEKtizBkY8GbjowFd2v2R+00DKmaQ0uG/Z2jX0=;
 b=WLmvW9JRtq7tBbYSjwPSFzfepQyRSwAUga4eYJ/Nx2uunPmBN17J3Z/DGIqndunN47
 RxrEkPSq5LagK+QbMhqJYs3jfRiE87hbv+ARgjEhknFY4KY2MOUsY2OafjzhDN1yGud5
 R696KpkeLo3uDv0WwiGvs8BoD7qZEvEUGeivn2yd4cu5pXEbxaFubf43N2dModZXVaGN
 i99xxrVCQxgVHCFURjhl8k/6xaEFrtI8zOgjL4H/fBuugurraVbNB7Fd1ntn3nxh52y2
 4Aft5e4JJV4FYhn4luuo/LC7mkobF/6EtUWjMOGv4psdClap0/0L5Vi8tmFsjAaM9io2
 OwvQ==
X-Gm-Message-State: AOJu0Ywq4iMe1U1Dtq8v2gzgVs9ugdxwFEA4xkPcIbR/4N4UxZo+4kdh
 5ZbyvSsEy13d4c1uw5TWwFryIMSIKjdR+aLQKnnvrmMCvsUMIzpxSTlJjh/2z/1RnhUnqpC4z9j
 z9F0Gw4G4gQ==
X-Gm-Gg: AfdE7cnWBQO/5PPHIbhNB26XQWlzyaBkx1+9+9xmHgsv4S0vEtvnOvSt8+WgH8geKeS
 JMyQBSVq+B2oxWocrMVRznZ8BoGFFCBiD2cHecCMtRhoLyrLlp1XKUpdYZCPQN+29vB+ILC05Ii
 PU999fXeDEBbI6ssGXfiU8JXkMjGCo3GrYYpi6Bzeux2jeOPJQpu6Gy7rwVuf3dM9e5Qzdzvgo2
 MoeKPFthTyEKXtGVS6SavAkA1IjM9DeKrQPa6K00mkylarfocjGx4t+RJI5GyWtu2i3YRgUY9Wy
 vNAnXNUTASHTF+kQ8DCVj2dDWWJbfAo5taHRrn9e1pdlgjt5lCU00a1NaxkSSJ0Q4L4oUh2WVVD
 LzXOryXFdmDYauPuHbFrrKC3qg7EYWTyePNkeKN/6qmpYKSi5otPYeloLgIOYfn5E1kMYr1BTdm
 rQyLA2+9T5i1eI2uaiKEZtoqgiVvEkWwSUmU4kTyfOYUSVXwOSwcywz4tp9MCJ4K5o6MxXkk8xQ
 eDLUgpBFI4oe5lV5/zPKhD9M8fsXZfS
X-Received: by 2002:a05:600c:34c2:b0:493:d9f7:a3cf with SMTP id
 5b1f17b1804b1-493d9f7a46emr43559225e9.17.1783334307697; 
 Mon, 06 Jul 2026 03:38:27 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/49] docs/system/arm: Document Zynq Buildroot boot
Date: Mon,  6 Jul 2026 11:37:33 +0100
Message-ID: <20260706103752.320511-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Bin Meng <bin.meng@processmission.com>

The Zynq board documentation only showed a generic direct kernel
boot command.

Add Buildroot ZC702 commands for booting through U-Boot proper
with the generic loader and for direct Linux boot from the
generated SD image.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20260628114925.418293-1-bin.meng@processmission.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/xlnx-zynq.rst | 54 ++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/docs/system/arm/xlnx-zynq.rst b/docs/system/arm/xlnx-zynq.rst
index aa37df2926..95538cd32f 100644
--- a/docs/system/arm/xlnx-zynq.rst
+++ b/docs/system/arm/xlnx-zynq.rst
@@ -30,16 +30,56 @@ The QEMU xilinx-zynq-a9 board supports the following devices:
 - DDR Memory
 - USB 2.0 x2
 
-Running
-"""""""
-Direct Linux boot of a generic Arm upstream Linux kernel:
+Running Buildroot ZC702 Images
+""""""""""""""""""""""""""""""
+
+Buildroot has a ZC702 defconfig. Buildroot 2026.05 release is tested at the
+time of writing. From the Buildroot source tree:
 
 .. code-block:: bash
 
-  $ qemu-system-aarch64 -M xilinx-zynq-a9 \
-        -dtb zynq-zc702.dtb  -serial null -serial mon:stdio \
-        -display none  -m 1024 \
-        -initrd rootfs.cpio.gz -kernel zImage
+  $ make zynq_zc702_defconfig
+  $ make
+
+The generated files are in ``output/images/``. The examples below use:
+
+ * ``u-boot.bin``
+ * ``uImage``
+ * ``sdcard.img``
+
+QEMU's SD card model requires a power-of-two image size. Work on a copy
+of the Buildroot SD image and resize the copy, not the original output:
+
+.. code-block:: bash
+
+  $ cp output/images/sdcard.img sdcard-qemu.img
+  $ qemu-img resize -f raw sdcard-qemu.img 128M
+
+To boot through the U-Boot image generated by Buildroot, use the generic
+loader device to place the raw ``u-boot.bin`` at the address it was linked
+for and start the CPU there.  The ``zynq_zc702_defconfig`` U-Boot image is
+U-Boot proper, not a Zynq boot ROM image, and is linked at ``0x04000000``:
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M xilinx-zynq-a9 -m 1G \
+      -machine boot-mode=sd \
+      -display none -serial null -serial mon:stdio \
+      -device loader,file=output/images/u-boot.bin,addr=0x04000000,cpu-num=0 \
+      -drive file=sdcard-qemu.img,if=sd,format=raw
+
+Direct Linux boot of the generated Buildroot image is also supported. The Zynq
+ZC702 DTB is generated by Buildroot and is located in
+``output/images/zynq-zc702.dtb``. The kernel image is generated as a uImage:
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M xilinx-zynq-a9 -m 1G \
+      -display none -serial null -serial mon:stdio \
+      -kernel output/images/uImage \
+      -dtb output/images/zynq-zc702.dtb \
+      -append "console=ttyPS0,115200 root=/dev/mmcblk0p2 rw rootwait" \
+      -drive file=sdcard-qemu.img,if=sd,format=raw
 
 For configuring the boot-mode provide the following on the command line:
 
-- 
2.43.0


