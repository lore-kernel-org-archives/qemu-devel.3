Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAEDC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 16:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riGvP-0007Ex-UE; Thu, 07 Mar 2024 11:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1riGvJ-0007As-5q
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:48:49 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1riGvC-0002Uy-AB
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:48:47 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxqvDk7+llBwEWAA--.54419S3;
 Fri, 08 Mar 2024 00:48:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxnhPj7+llNmpQAA--.27604S2; 
 Fri, 08 Mar 2024 00:48:35 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v6 00/17] Add boot LoongArch elf kernel with FDT
Date: Fri,  8 Mar 2024 00:48:18 +0800
Message-Id: <20240307164835.300412-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxnhPj7+llNmpQAA--.27604S2
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
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi, All

We already support boot efi kernel with bios, but not support boot elf kernel.
This series adds boot elf kernel with FDT.

'LoongArch supports ACPI and FDT. The information that needs to be passed
 to the kernel includes the memmap, the initrd, the command line, optionally
 the ACPI/FDT tables, and so on'  see [1].

Patch 2-8 : Create efi system table, and three efi configuration table
            boot_memmap, initd, FDT.
Patch 9-17 : Fixes FDT problems.

Test:
  - Start kernel
    See [2] start_kernel.sh
  - Start qcow2
    See [2] start_qcow2.sh

V6:
  - Fixes test/compilation failures; 

V5:
  - Rebase;

V4:
  - patch 3 change slave_boot_code[] to const, and 'static void *p ' to
    'void *p';
  - patch 4 fixes build error;
  - patch 10-13, add project and commit link.

V3:
  - Load initrd at  kernel_high + 4 * kernel_size;
  - Load 'boot_rom' at [0 - 1M], the 'boot_rom' includes
    slave_boot_code, cmdline_buf and systab_tables;
  - R-b and rebase.

V2:
  - FDT pcie node adds cells 'msi-map';


[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/arch/loongarch/booting.rst?h=v6.7-rc4

[2]: https://github.com/gaosong-loongson/loongarch-binary/releases

Please review!

Thanks.
Song Gao

Song Gao (17):
  hw/loongarch: Move boot fucntions to boot.c
  hw/loongarch: Add load initrd
  hw/loongarch: Add slave cpu boot_code
  hw/loongarch: Add init_cmdline
  hw/loongarch: Init efi_system_table
  hw/loongarch: Init efi_boot_memmap table
  hw/loongarch: Init efi_initrd table
  hw/loongarch: Init efi_fdt table
  hw/loongarch: Fix fdt memory node wrong 'reg'
  hw/loongarch: fdt adds cpu interrupt controller node
  hw/loongarch: fdt adds Extend I/O Interrupt Controller
  hw/loongarch: fdt adds pch_pic Controller
  hw/loongarch: fdt adds pch_msi Controller
  hw/loongarch: fdt adds pcie irq_map node
  hw/loongarch: fdt remove unused irqchip node
  hw/loongarch: Add cells missing from uart node
  hw/loongarch: Add cells missing from rtc node

 hw/loongarch/boot.c                | 333 ++++++++++++++++++++++++++
 hw/loongarch/meson.build           |   1 +
 hw/loongarch/virt.c                | 363 ++++++++++++++++-------------
 include/hw/intc/loongarch_extioi.h |   1 +
 include/hw/loongarch/boot.h        | 109 +++++++++
 include/hw/loongarch/virt.h        |  14 ++
 include/hw/pci-host/ls7a.h         |   2 +
 target/loongarch/cpu.h             |   2 +
 8 files changed, 665 insertions(+), 160 deletions(-)
 create mode 100644 hw/loongarch/boot.c
 create mode 100644 include/hw/loongarch/boot.h

-- 
2.34.1


