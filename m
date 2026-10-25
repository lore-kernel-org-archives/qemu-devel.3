Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0289606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=nVaqk8UL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKxyK-0003vH-7o; Sun, 25 Oct 2026 09:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nkwilson@sina.com>) id 1xKuW3-0006oc-UU
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 05:27:48 -0400
Received: from r3-22.sinamail.sina.com.cn ([202.108.3.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nkwilson@sina.com>) id 1xKuW0-0006WY-9x
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 05:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1792920464; bh=wkrnTKMcZBFIx7104ekCrdGYPTYRNR6H6LRzv3GQwQI=;
 h=From:Subject:Date:Message-ID;
 b=nVaqk8ULfiCqYINfV8PmTI36lLX2H7PfHpZwaorwVC4sGmfLOYl7b0k+or8632a2S
 4wwvBQDPHPtjoHOUkTRbDYNQJ5ojEsmvR9nv/uOGHNqSa6KObKOJH+kaoEb0RjtbwZ
 iRFl9w37iPjvrLgD8YHhAfMkYMAsJuJgL75qxLqI=
X-SMAIL-HELO: 192.168.1.19
Received: from unknown (HELO 192.168.1.19)([123.118.215.42])
 by sina.com (10.54.253.33) with ESMTP
 id 6ADDC80200001CC6; Sun, 25 Oct 2026 17:12:36 +0800 (CST)
X-Sender: nkwilson@sina.com
X-Auth-ID: nkwilson@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=nkwilson@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=nkwilson@sina.com
X-SMAIL-MID: 9306196685410
X-SMAIL-UIID: BDF829662FAC4DA9B2087C5D80596014-20261025-171236-1
From: Yu Bin <nkwilson@sina.com>
To: qemu-devel@nongnu.org
Cc: slp@redhat.com, pbonzini@redhat.com, yubin1@chinatelecom.cn,
 Yu Bin <nkwilson@sina.com>
Subject: [PATCH 1/1] hw/i386/microvm: reserve firmware area when loading
 kernel with ACPI
Date: Sun, 25 Oct 2026 17:12:34 +0800
Message-ID: <20261025091234.81072-2-nkwilson@sina.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261025091234.81072-1-nkwilson@sina.com>
References: <20261025091234.81072-1-nkwilson@sina.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.108.3.22; envelope-from=nkwilson@sina.com;
 helo=r3-22.sinamail.sina.com.cn
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 25 Oct 2026 09:08:49 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

microvm places its ACPI tables at the top of low RAM (guest e820 shows
the top 4 KiB page reserved), but loads the kernel/initrd with
acpi_data_size = 0, unlike PC which passes PC_FW_DATA (160 KiB).

With exactly 2048 MiB of RAM this breaks boot: the kernel's
initrd_addr_max is 0x7fffffff, one byte below the 0x80000000 RAM top,
so the initrd_max clamp in x86_load_linux() never engages and the
initrd ends exactly at 0x7fffffff, overwriting the RSDP/ACPI table
page. Guests then hang in ACPI core init, fail to power off via \_S5,
or (with KASLR) enter a decompressor reset loop, depending on the
random placement.

Move PC_FW_DATA to the shared x86 header and pass it from microvm as
well, so the initrd always stays below the firmware area. microvm
currently needs only one page, but keeping the reservation identical
to PC leaves headroom and keeps the two machine types consistent.

Reproduced with both KVM and TCG; fixed for both. Only exactly
2048 MiB was affected (the clamp engages at 2047M, and the RAM top is
above initrd_addr_max at 2049M and beyond).

Signed-off-by: Yu Bin <nkwilson@sina.com>
---
 hw/i386/microvm.c     |  2 +-
 hw/i386/pc.c          | 10 ----------
 include/hw/i386/x86.h | 10 ++++++++++
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 721b7dd5b1..fd7525df13 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -414,7 +414,7 @@ static void microvm_memory_init(MicrovmMachineState *mms)
     rom_set_fw(fw_cfg);
 
     if (machine->kernel_filename != NULL) {
-        mmc->x86_load_linux(x86ms, fw_cfg, 0);
+        mmc->x86_load_linux(x86ms, fw_cfg, PC_FW_DATA);
     }
 
     if (mms->option_roms) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4b53b5be4a..2e3fcd8c2f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -178,16 +178,6 @@ const size_t pc_compat_4_2_len = G_N_ELEMENTS(pc_compat_4_2);
 GlobalProperty pc_compat_4_1[] = {};
 const size_t pc_compat_4_1_len = G_N_ELEMENTS(pc_compat_4_1);
 
-/*
- * @PC_FW_DATA:
- * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
- * and other BIOS datastructures.
- *
- * BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K
- * reported to be used at the moment, 32K should be enough for a while.
- */
-#define PC_FW_DATA (0x20000 + 0x8000)
-
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
 {
     GSIState *s;
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 71fe6b5e12..da62befc95 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -127,6 +127,16 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
                        MemoryRegion *rom_memory, bool isapc_ram_fw);
 void x86_bios_rom_reload(X86MachineState *x86ms);
 
+/*
+ * @PC_FW_DATA:
+ * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
+ * and other BIOS datastructures.
+ *
+ * BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K
+ * reported to be used at the moment, 32K should be enough for a while.
+ */
+#define PC_FW_DATA (0x20000 + 0x8000)
+
 void x86_load_linux(X86MachineState *x86ms,
                     FWCfgState *fw_cfg,
                     int acpi_data_size);
-- 
2.54.0 (Apple Git-157)


