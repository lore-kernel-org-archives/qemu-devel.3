Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126F7C624CE
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x11zo-0001te-9s; Mon, 31 Aug 2026 09:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1x11zl-0001rQ-LH; Mon, 31 Aug 2026 09:24:17 -0400
Received: from [115.124.30.132] (helo=out30-132.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1x11zc-0006px-Gc; Mon, 31 Aug 2026 09:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1788182637; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=wO62s2Pr7FdPaT1mifIp2d4AflcsLpR3tVxK/tc9v+M=;
 b=snSXz5qPBz20X7Le80x+GWFpFArBILabMJxjDIbHK6efRXLcM3IKIstbEOHwztt1Y9knImPmEnHegMBFz3imA5z8pCR+gdVkVBOIFzgrHdAhYa8Y+n973lJIJjvAfPlEr+1U8tmA244fGSwEixUZkxZE5q/MODRvNBjjCCTCnxY=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R791e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=cp0613@linux.alibaba.com; NM=1; PH=DS; RN=19; SR=0;
 TI=SMTPD_---0X9znfr5_1788182636; 
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0X9znfr5_1788182636 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 31 Aug 2026 21:23:57 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, jic23@kernel.org
Cc: pbonzini@redhat.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 anisinha@redhat.com, dave.jiang@intel.com, alison.schofield@intel.com,
 junjie.cao@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: [PATCH v5 5/6] tests/qtest: Add RISC-V ACPI bios tables test for CXL
Date: Mon, 31 Aug 2026 21:23:36 +0800
Message-ID: <20260831132340.5345-6-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831132340.5345-1-cp0613@linux.alibaba.com>
References: <20260831132340.5345-1-cp0613@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.132 (deferred)
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=cp0613@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Add test_acpi_riscv64_virt_tcg_cxl() to verify that enabling CXL on
the RISC-V virt machine produces correct ACPI tables, including the
ACPI0017 CXLM device with _DEP in the DSDT and the CEDT table.

The test boots with cxl=on, one pxb-cxl bus (bus_nr=12), a CXL root
port, a cxl-type3 device and a fixed memory window, mirroring the
existing x86 q35 CXL test pattern.

Since pxb-cxl is a root bus, using -cdrom causes QEMU to auto-plug the
cdrom drive into pxb-cxl, triggering "Only PCI/PCIe bridges can be
plugged into pxb-cxl".  The ISO is instead attached explicitly via a
virtio-scsi-pci controller on pcie.0, following the same approach as
test_acpi_aarch64_virt_tcg_pxb().

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Tested-by: Junjie Cao <junjie.cao@intel.com>
Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 tests/qtest/bios-tables-test.c | 54 ++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 5cc526510a..d2b18d8ecb 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2214,6 +2214,56 @@ static void test_acpi_riscv64_virt_tcg(void)
     free_test_data(&data);
 }
 
+#ifdef CONFIG_POSIX
+static void test_acpi_riscv64_virt_tcg_cxl(void)
+{
+    gchar *tmp_path = g_dir_make_tmp("qemu-test-cxl.XXXXXX", NULL);
+    gchar *params;
+
+    test_data data = {
+        .machine = "virt",
+        .arch = "riscv64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-riscv-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-riscv-vars.fd",
+        .ram_start = 0x80000000ULL,
+        .scan_len = 128ULL * MiB,
+        .variant = ".cxl",
+    };
+
+    /*
+     * While using -cdrom, the cdrom would auto-plug into pxb-cxl because
+     * its bus is also a root bus, triggering "Only PCI/PCIe bridges can be
+     * plugged into pxb-cxl".  Attach the ISO explicitly to a scsi controller
+     * on pcie.0 instead, following the same pattern as
+     * test_acpi_aarch64_virt_tcg_pxb().
+     */
+    params = g_strdup_printf("-cpu rva22s64"
+                             " -machine cxl=on"
+                             " -device pcie-root-port,chassis=1,id=pci.1,bus=pcie.0"
+                             " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
+                             " -drive file=tests/data/uefi-boot-images/"
+                             "bios-tables-test.riscv64.iso.qcow2,"
+                             "if=none,media=cdrom,id=drive-scsi0-0-0-1,readonly=on"
+                             " -device scsi-cd,bus=scsi0.0,scsi-id=0,"
+                             "drive=drive-scsi0-0-0-1,id=scsi0-0-0-1,bootindex=1"
+                             " -object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M"
+                             " -object memory-backend-file,id=lsa1,mem-path=%s,size=256M"
+                             " -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1"
+                             " -device cxl-rp,port=0,bus=cxl.1,id=rp1,chassis=0,slot=2"
+                             " -device cxl-type3,bus=rp1,persistent-memdev=cxl-mem1,lsa=lsa1"
+                             " -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,"
+                             "cxl-fmw.0.interleave-granularity=8k",
+                             tmp_path, tmp_path);
+    test_acpi_one(params, &data);
+
+    g_free(params);
+    g_assert(g_rmdir(tmp_path) == 0);
+    g_free(tmp_path);
+    free_test_data(&data);
+}
+#endif /* CONFIG_POSIX */
+
 static void test_acpi_aarch64_virt_tcg(void)
 {
     test_data data = {
@@ -2963,6 +3013,10 @@ int main(int argc, char *argv[])
                            test_acpi_riscv64_virt_tcg_numamem);
             qtest_add_func("acpi/virt/acpispcr",
                            test_acpi_riscv64_virt_tcg_acpi_spcr);
+#ifdef CONFIG_POSIX
+            qtest_add_func("acpi/virt/cxl",
+                           test_acpi_riscv64_virt_tcg_cxl);
+#endif
         }
     } else if (strcmp(arch, "loongarch64") == 0) {
         if (has_tcg && qtest_has_machine("virt")) {
-- 
2.50.1


