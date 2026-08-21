Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3171FC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxKUK-0005bE-7p; Fri, 21 Aug 2026 04:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wxKUH-0005am-M4; Fri, 21 Aug 2026 04:20:29 -0400
Received: from [115.124.30.97] (helo=out30-97.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wxKUD-0002g6-Iw; Fri, 21 Aug 2026 04:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1787300406; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=uPFtdyIyB1y6rq9kijS0z4R04SetuCdqU+O6N/T/+3M=;
 b=eUEQdFbdScmnrGV9rYooAxO5lfGMcXo6/q+pdD7H6O+0N+KWhytcHjaFZi/Vwg9rbMRQ2mUu8h1kioaAB3Sa7m5a0TnRMTRsp2FAiOUYba0WeCH9FnAsrKCqbkq6GsUbnWfpMVIZhBPDjsrL/ULbAGXyCm3i5qKL2atxyfu3j4o=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=cp0613@linux.alibaba.com; NM=1; PH=DS; RN=19; SR=0;
 TI=SMTPD_---0X9LmLuX_1787300405; 
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0X9LmLuX_1787300405 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 21 Aug 2026 16:20:05 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, jic23@kernel.org
Cc: pbonzini@redhat.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 anisinha@redhat.com, dave.jiang@intel.com, alison.schofield@intel.com,
 junjie.cao@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: [PATCH 4/4] tests/qtest: Add RISC-V ACPI bios tables test for CXL
Date: Fri, 21 Aug 2026 16:19:54 +0800
Message-ID: <20260821081954.1171-5-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821081954.1171-1-cp0613@linux.alibaba.com>
References: <20260821081954.1171-1-cp0613@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.97 (deferred)
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=cp0613@linux.alibaba.com; helo=out30-97.freemail.mail.aliyun.com
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
port, a cxl-type3 persistent memory device, and a fixed memory window,
mirroring the existing x86 q35 CXL test pattern.

Since pxb-cxl is a root bus, using -cdrom causes QEMU to auto-plug the
cdrom drive into pxb-cxl, triggering "Only PCI/PCIe bridges can be
plugged into pxb-cxl".  The ISO is instead attached explicitly via a
virtio-scsi-pci controller on pcie.0, following the same approach as
test_acpi_aarch64_virt_tcg_pxb().

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 tests/data/acpi/riscv64/virt/CEDT.cxl | Bin 0 -> 108 bytes
 tests/data/acpi/riscv64/virt/DSDT.cxl | Bin 0 -> 6212 bytes
 tests/qtest/bios-tables-test.c        |  54 ++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)
 create mode 100644 tests/data/acpi/riscv64/virt/CEDT.cxl
 create mode 100644 tests/data/acpi/riscv64/virt/DSDT.cxl

diff --git a/tests/data/acpi/riscv64/virt/CEDT.cxl b/tests/data/acpi/riscv64/virt/CEDT.cxl
new file mode 100644
index 0000000000000000000000000000000000000000..81d746dfb09ccb147e26bb64060404ca3191d097
GIT binary patch
literal 108
zc-nJzbqUE~U|?VjaPoKd2v%^42yj*a0!E-1hz+6{7!(+IKx!BefCEf2LP-snumA^?
O0aMEg#QH!C(hmS*@&^F`

literal 0
Hc-jL100001

diff --git a/tests/data/acpi/riscv64/virt/DSDT.cxl b/tests/data/acpi/riscv64/virt/DSDT.cxl
new file mode 100644
index 0000000000000000000000000000000000000000..4587f682c0c2053d4fb01b566e8e1782220c6bd5
GIT binary patch
literal 6212
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
C^C(OJ

literal 0
Hc-jL100001

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


