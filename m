Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41069C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKEUG-0007Hq-Am; Wed, 28 May 2025 06:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1uKEU9-0007Dt-Ki; Wed, 28 May 2025 06:58:14 -0400
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1uKEU6-0007uu-EU; Wed, 28 May 2025 06:58:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1748429676; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZKF18XAFk0kG7laTR6kFGuQvE/ikl97/K2HAjjgQmSbnaBa8t4XpjgICCCz30mq8NwfPZXG5DeNibDg/LxMJVE8IXfBj4OK3yppEXS8IfBhXfmay2QJ5Tn59sQWno+dHZHZvoXVKwjKhjYcjrMacGiEZKFUC0DI3zyUqj+iqkng=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1748429676;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2c0O9T1s6X8/ZTemOXWayC8UqGgBEItGWgmlUlE7g6Y=; 
 b=GSay3zsNvR/wGAbijItLYpZxCsUQK3WBmipgeHTbA6mlY51etaBibfqgon89X8vUJwl/QIIMBxaLLnZTwZO3F/sGuatg+9ktPLbv3xwYg7h8SdYQRE5l15VGVwu8CSPYc8lN5vbwD8ovaaJDTnl1n1hWT7bCjRrSQ7BEmgOpwcg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748429676; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=2c0O9T1s6X8/ZTemOXWayC8UqGgBEItGWgmlUlE7g6Y=;
 b=U+m7GROlVgSXmakrLzdtYLpkyIc9LhIi5NYpUmD2tVcH5pCWoiJ6qSl3zcFyH62A
 TlO96rxitS4HzZmmjorbhCf1m6OPsc+nJyuS6Nz/Vmy6lWWuHmA500z2/y8X/i/fXPa
 Nyy3SVf6/oxL+8VUF1rWTg9CjRVWfg9Fivg0laUU=
Received: by mx.zohomail.com with SMTPS id 1748429673760272.6198314666002;
 Wed, 28 May 2025 03:54:33 -0700 (PDT)
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
Cc: Li Chen <chenl311@chinatelecom.cn>
Subject: [PATCH REPOST v4 2/4] tests/qtest/bios-tables-test: Add test for
 disabling SPCR on AArch64
Date: Wed, 28 May 2025 18:53:36 +0800
Message-ID: <20250528105404.457729-3-me@linux.beauty>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528105404.457729-1-me@linux.beauty>
References: <20250528105404.457729-1-me@linux.beauty>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.15; envelope-from=me@linux.beauty;
 helo=sender4-op-o15.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add ACPI SPCR table test case for ARM when SPCR was off.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 tests/qtest/bios-tables-test.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 0a333ec435..d2a1aa7fb3 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1789,6 +1789,24 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
     free_test_data(&data);
 }
 
+static void test_acpi_aarch64_virt_tcg_acpi_spcr(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "aarch64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 128ULL * 1024 * 1024,
+        .variant = ".acpispcr",
+    };
+
+    test_acpi_one("-cpu cortex-a57 "
+                  " -machine spcr=off", &data);
+    free_test_data(&data);
+}
 static void test_acpi_tcg_acpi_hmat(const char *machine, const char *arch)
 {
     test_data data = {};
@@ -2583,6 +2601,8 @@ int main(int argc, char *argv[])
             qtest_add_func("acpi/virt/pxb", test_acpi_aarch64_virt_tcg_pxb);
             qtest_add_func("acpi/virt/oem-fields",
                            test_acpi_aarch64_virt_oem_fields);
+            qtest_add_func("acpi/virt/acpispcr",
+                           test_acpi_aarch64_virt_tcg_acpi_spcr);
             if (qtest_has_device("virtio-iommu-pci")) {
                 qtest_add_func("acpi/virt/viot", test_acpi_aarch64_virt_viot);
             }
-- 
2.49.0


