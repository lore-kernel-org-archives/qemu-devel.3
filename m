Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760F1C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 02:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scFhU-0001wY-HO; Thu, 08 Aug 2024 22:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo1.xu@intel.com>)
 id 1scFhS-0001qJ-2a
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 22:49:54 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo1.xu@intel.com>)
 id 1scFhQ-0000ec-4N
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 22:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723171793; x=1754707793;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Eg1txdz+0hc3DXwfbky73p7lGo01rRlG8pItxjq6qtc=;
 b=e/Unk0m9UaeCztFT73kSwI7n/leQjw1j5gZuv7dBz54QgbmtGjfUs2cK
 kBHYfW14+w4tEbF3ekA0JftPWDYxLeJ/EHBa4LA6N84ioe+3oG00gLMXm
 HwndW10zZlQekVBiV+T2M3MpNUAhb7tcXYNacLqVIjJwF71War2GqBU5I
 T4zJow/pJf7xEUK8hSr+iBOXYpuHHctQmA8sbIFrOqoDTHPCi5NNh3K79
 7N5MbN2mS4ojgs+9Zw2GgMnbZYeCffEANcH6gIGt2ohRxkoimJwSYdiny
 tKDoi2Nt3BFnEoq60dM7R14S+uetx3surcbe51asyzHNmKC1iIf0WxMYX w==;
X-CSE-ConnectionGUID: Lp3+FTyvSxWjOr9pe078jA==
X-CSE-MsgGUID: Bd5En9xhQLiyFW3R//Olag==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21484103"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; d="scan'208";a="21484103"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 19:49:49 -0700
X-CSE-ConnectionGUID: wTmXT3muRfC5XTyjVPkwVQ==
X-CSE-MsgGUID: V2PtPF9yQ4a1JNDXX2LMkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; d="scan'208";a="62377622"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.153.94])
 by orviesa004.jf.intel.com with ESMTP; 08 Aug 2024 19:49:46 -0700
From: Haibo Xu <haibo1.xu@intel.com>
To: sunilvl@ventanamicro.com,
	alistair.francis@wdc.com
Cc: xiaobo55x@gmail.com, Haibo Xu <haibo1.xu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 2/3] tests/qtest/bios-tables-test.c: Enable numamem testing
 for RISC-V
Date: Fri,  9 Aug 2024 11:09:48 +0800
Message-Id: <a6f7e1a4b20ff7eb199e94ca0c8aa2e6794ce5b2.1723172696.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0e30216273f2f59916bc651350578d8e8bc3a75f.1723172696.git.haibo1.xu@intel.com>
References: <0e30216273f2f59916bc651350578d8e8bc3a75f.1723172696.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=haibo1.xu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Add ACPI SRAT table test case for RISC-V when NUMA was enabled.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tests/qtest/bios-tables-test.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 36e5c0adde..e79f3a03df 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1706,6 +1706,32 @@ static void test_acpi_microvm_ioapic2_tcg(void)
     free_test_data(&data);
 }
 
+static void test_acpi_riscv64_virt_tcg_numamem(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "riscv64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-riscv-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-riscv-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2",
+        .ram_start = 0x80000000ULL,
+        .scan_len = 128ULL * 1024 * 1024,
+    };
+
+    data.variant = ".numamem";
+    /*
+     * RHCT will have ISA string encoded. To reduce the effort
+     * of updating expected AML file for any new default ISA extension,
+     * use the profile rva22s64.
+     */
+    test_acpi_one(" -cpu rva22s64"
+                  " -object memory-backend-ram,id=ram0,size=128M"
+                  " -numa node,memdev=ram0",
+                  &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_aarch64_virt_tcg_numamem(void)
 {
     test_data data = {
@@ -2466,6 +2492,8 @@ int main(int argc, char *argv[])
     } else if (strcmp(arch, "riscv64") == 0) {
         if (has_tcg && qtest_has_device("virtio-blk-pci")) {
             qtest_add_func("acpi/virt", test_acpi_riscv64_virt_tcg);
+            qtest_add_func("acpi/virt/numamem",
+                           test_acpi_riscv64_virt_tcg_numamem);
         }
     }
     ret = g_test_run();
-- 
2.34.1


