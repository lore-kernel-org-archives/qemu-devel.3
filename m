Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6330C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 11:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc0KQ-0001nZ-Nw; Wed, 16 Jul 2025 07:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1uc0Cy-00034A-BV; Wed, 16 Jul 2025 07:21:56 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1uc0Cw-0001An-BD; Wed, 16 Jul 2025 07:21:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1752664821; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gyoebC35v+ys6LSvZo11XETOECJweIaILQ4LVYcLReqxOyYx0PHBPHxyqFGplMdOpEIcqwruk0Xo8rl1jt1/2BFt9q3KCV/984xNAL2NBkDR9vEQ5HjZf5bP6NkMbboA822ZXnecmOHnpaSOKDU31wtr1srnW9C2YZoC59kReXI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1752664821;
 h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=hpzfBSOA39ym1MCPK/wVMzJwkjoefykvPuXbZzLpGMc=; 
 b=jH81O11gzUcI4CMdXuwOGqdar0jQUQWpWB0o+zPNj18HPJSEQPhQVsAIv6VIHc/YEeO72YxE4efjwV/AG9dvRtOxlGiFhsy5+q5gEEL+TSkqTEDP7hSsX79it6kBeG3xtZFNIj/eD3K52bdysMOQ0lI/+RMTIRGf83XzpS+9fic=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752664821; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=hpzfBSOA39ym1MCPK/wVMzJwkjoefykvPuXbZzLpGMc=;
 b=JZTJSaY2zRbDXMaHZmOkaGL9nZdaNWeb/iSB7XKHJg8FaB8Mk4gwmQJeqkMMWFjx
 2mmLVJpaA9nsCkk/QKdE/Fbr9kxsxcbekMxbkofUBPcXUNRUWFUOzH2Wo3dCGuFMjQ8
 Jmd5UWBdzaHKOSwCk58z6b1ywDvic/RLBTM+AhBk=
Received: by mx.zohomail.com with SMTPS id 1752664819828742.8670461414554;
 Wed, 16 Jul 2025 04:20:19 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "Peter Maydell" <peter.maydell@linaro.org>,
 "Shannon Zhao" <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Igor Mammedov" <imammedo@redhat.com>, "Ani Sinha" <anisinha@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Yanan Wang" <wangyanan55@huawei.com>, "Zhao Liu" <zhao1.liu@intel.com>,
 "Song Gao" <gaosong@loongson.cn>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Sunil V L" <sunilvl@ventanamicro.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alistair Francis" <alistair.francis@wdc.com>,
 "Weiwei Li" <liwei1518@gmail.com>, "qemu-arm" <qemu-arm@nongnu.org>,
 "qemu-devel" <qemu-devel@nongnu.org>, "qemu-riscv" <qemu-riscv@nongnu.org>
Subject: [PATCH v5 3/4] tests/qtest/bios-tables-test: Add test for disabling
 SPCR on RISC-V
Date: Wed, 16 Jul 2025 19:19:55 +0800
Message-ID: <20250716111959.404917-4-me@linux.beauty>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716111959.404917-1-me@linux.beauty>
References: <20250716111959.404917-1-me@linux.beauty>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112; envelope-from=me@linux.beauty;
 helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Li Chen <chenl311@chinatelecom.cn>

Add ACPI SPCR table test case for RISC-V when SPCR was off.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
---

Notes:
    Changes since v3: Add Reviewed-by from Sunil V L <sunilvl@ventanamicro.com>

 tests/qtest/bios-tables-test.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index ede846f905..04a9d8a4da 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1807,6 +1807,26 @@ static void test_acpi_aarch64_virt_tcg_acpi_spcr(void)
                   " -machine spcr=off", &data);
     free_test_data(&data);
 }
+
+static void test_acpi_riscv_virt_tcg_acpi_spcr(void)
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
+        .variant = ".acpispcr",
+    };
+
+    test_acpi_one("-cpu rva22s64 "
+                  "-machine spcr=off", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_tcg_acpi_hmat(const char *machine, const char *arch)
 {
     test_data data = {};
@@ -2633,6 +2653,8 @@ int main(int argc, char *argv[])
             qtest_add_func("acpi/virt", test_acpi_riscv64_virt_tcg);
             qtest_add_func("acpi/virt/numamem",
                            test_acpi_riscv64_virt_tcg_numamem);
+            qtest_add_func("acpi/virt/acpispcr",
+                           test_acpi_riscv_virt_tcg_acpi_spcr);
         }
     }
     ret = g_test_run();
-- 
2.50.0


