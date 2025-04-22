Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DBCC369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 13:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7DLk-0004FG-IO; Tue, 22 Apr 2025 09:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1u7CPi-0000SK-7f; Tue, 22 Apr 2025 08:07:46 -0400
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1u7CPe-0002sD-1m; Tue, 22 Apr 2025 08:07:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1745323641; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fmFbhfJyfECqQmrJkiLYGUNQb0nQlMks/6J04uHDP3zA32Xs1un+ZH7kh9sFwZng6Joj06shogwSh9S4lYnWFR0OCeSzEljnuqpAMP4QxPMg1yrC8ImmQy4RqYGXb47UqNAA4ZSd6lurblvRx46F1vzMHcZtjP7cCc1ZJGTCXl8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1745323641;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=/stvQ7CKfZG2qrLmD8V83vEdkR/vmhNKv8wtTQoJZjI=; 
 b=j1PSDk2B9mOBMgTROQTmcR0vOzLXUnSjHhq6fXBNycUdbPfjOy0LvNz3nTgdV+DGEAoUWmTGD4wE22BRPMYwcVgKozYYoGtpHDbVuXVLtMFN1KO8KCKcDrCGy0c+dY9eElLfAgTBvwrjrThpX4hNi5DpN1DiXbvhA12BQ3mOM8Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745323641; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=/stvQ7CKfZG2qrLmD8V83vEdkR/vmhNKv8wtTQoJZjI=;
 b=VR0VB6fDB+WPlN3KrTa9j/E/a4iZBWcyyJmFkjYhZTx7qqriqOxYgYT8BISpFf4C
 XWnDqmR0QThRym3BUNuTniFzZoftxW9eId6Ju0tgv0mOpKAFMD/TJfmRSuf2PjG+Hfa
 vVjMMCaAnIlXr05rC3hEOnnUqigDZaEOBWEhXA4g=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1745323639301266.73560620235014;
 Tue, 22 Apr 2025 05:07:19 -0700 (PDT)
Date: Tue, 22 Apr 2025 20:07:19 +0800
From: Li Chen <me@linux.beauty>
To: "Peter Maydell" <peter.maydell@linaro.org>,
 "Shannon Zhao" <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Igor Mammedov" <imammedo@redhat.com>, "Ani Sinha" <anisinha@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?=22Philippe_Mathieu-Daud=C3=A9=22?= <philmd@linaro.org>,
 "Yanan Wang" <wangyanan55@huawei.com>,
 "Zhao Liu" <zhao1.liu@intel.com>, "Song Gao" <gaosong@loongson.cn>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Sunil V L" <sunilvl@ventanamicro.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alistair Francis" <alistair.francis@wdc.com>,
 "Weiwei Li" <liwei1518@gmail.com>, "qemu-arm" <qemu-arm@nongnu.org>,
 "qemu-devel" <qemu-devel@nongnu.org>, "qemu-riscv" <qemu-riscv@nongnu.org>
Message-ID: <1965d6541ea.102a06ad4912575.3151797857612362065@linux.beauty>
In-Reply-To: <1965d621e25.fafa759e911037.825810937022699867@linux.beauty>
References: <1965d621e25.fafa759e911037.825810937022699867@linux.beauty>
Subject: [PATCH V2 3/3] tests/qtest/bios-tables-test: Add test for disabling
 SPCR on RISC-V
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Received-SPF: pass client-ip=136.143.188.12; envelope-from=me@linux.beauty;
 helo=sender4-op-o12.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 22 Apr 2025 09:07:38 -0400
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
---
 tests/qtest/bios-tables-test.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index d2a1aa7fb3..44de152a36 100644
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
@@ -2612,6 +2632,8 @@ int main(int argc, char *argv[])
             qtest_add_func("acpi/virt", test_acpi_riscv64_virt_tcg);
             qtest_add_func("acpi/virt/numamem",
                            test_acpi_riscv64_virt_tcg_numamem);
+            qtest_add_func("acpi/virt/acpispcr",
+                           test_acpi_riscv_virt_tcg_acpi_spcr);
         }
     }
     ret = g_test_run();
-- 
2.49.0



