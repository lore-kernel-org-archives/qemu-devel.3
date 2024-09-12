Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A37EED601
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 13:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sojZo-0003Rb-BS; Thu, 12 Sep 2024 09:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sojZg-00030j-Qf
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 09:09:28 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sojZb-0004pV-0m
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 09:09:25 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dx1ugA6OJm5uQFAA--.12514S3;
 Thu, 12 Sep 2024 21:09:20 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front2 (Coremail) with SMTP id qciowMDxl8Xr5+JmR8MFAA--.9219S4;
 Thu, 12 Sep 2024 21:09:20 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 2/7] hw/loongarch: Remove default enable with VIRTIO_VGA device
Date: Thu, 12 Sep 2024 20:51:27 +0800
Message-Id: <20240912125132.268802-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240912125132.268802-1-gaosong@loongson.cn>
References: <20240912125132.268802-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qciowMDxl8Xr5+JmR8MFAA--.9219S4
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: Bibo Mao <maobibo@loongson.cn>

For virtio VGA deivce libvirt will select VIRTIO_VGA firstly rather than
VIRTIO_GPU, VIRTIO_VGA device supports frame buffer however it requires
legacy VGA compatible support. Frame buffer area 0xa0000 -- 0xc0000
conflicts with low memory area 0 -- 0x10000000.

Here remove default support for VIRTIO_VGA device, VIRTIO_GPU is prefered
on LoongArch system. For frame buffer video card support, standard VGA can
be used.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240823073050.2619484-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index 0de713a439..9c69170968 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -5,7 +5,6 @@ config LOONGARCH_VIRT
     select DEVICE_TREE
     select PCI
     select PCI_EXPRESS_GENERIC_BRIDGE
-    imply VIRTIO_VGA
     imply PCI_DEVICES
     imply NVDIMM
     imply TPM_TIS_SYSBUS
-- 
2.34.1


