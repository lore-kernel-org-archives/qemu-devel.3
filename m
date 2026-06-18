Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EBECD98E2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 09:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa9DK-00052e-H8; Thu, 18 Jun 2026 05:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wa9DG-000507-5h; Thu, 18 Jun 2026 05:39:07 -0400
Received: from [115.124.30.131] (helo=out30-131.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wa9D8-0007I6-GX; Thu, 18 Jun 2026 05:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1781775519; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=VV94c9wtKw6ZwOmBFRfajEdtwdPPb2DI7A490RggnXw=;
 b=GVH+Ll/DrrMq1RaXjeurNaMC7TGB67QPo2U+VJdoIE8NbmttwiaSDK2Hm7K7qqiFQOAbl9VU44Ti92+qMVcsf6zAOt7am+Zxmnmd0IkMQQ8WGEkzSn5l2aEOq4nKh7KUZPPK7pbQo2bzTMheDYsY0sKv1Ym/BlipRuEvT+GYnRs=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=cp0613@linux.alibaba.com; NM=1; PH=DS; RN=17; SR=0;
 TI=SMTPD_---0X56RwN9_1781775517; 
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0X56RwN9_1781775517 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 18 Jun 2026 17:38:37 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: jic23@kernel.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, sunilvl@ventanamicro.com, dave.jiang@intel.com,
 alison.schofield@intel.com, imammedo@redhat.com, mst@redhat.com,
 guoren@kernel.org
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH v2 4/4] tests/qtest: Add RISC-V ACPI bios tables test for CXL
Date: Thu, 18 Jun 2026 17:38:26 +0800
Message-ID: <20260618093827.3507-5-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618093827.3507-1-cp0613@linux.alibaba.com>
References: <20260618093827.3507-1-cp0613@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.131 (deferred)
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=cp0613@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
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
index 0000000000000000000000000000000000000000..45999636a05a16f68d1f418a58d9b80a8a62c9bd
GIT binary patch
literal 6212
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
Cu_#Oc

literal 0
Hc-jL100001

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 510751799e..4625b76692 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2194,6 +2194,56 @@ static void test_acpi_riscv64_virt_tcg(void)
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
@@ -2888,6 +2938,10 @@ int main(int argc, char *argv[])
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


