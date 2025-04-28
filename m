Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212E8C369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 11:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9MOJ-0007Td-34; Mon, 28 Apr 2025 07:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1u9MNi-0007BT-V5; Mon, 28 Apr 2025 07:10:40 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1u9MNg-00022s-8P; Mon, 28 Apr 2025 07:10:38 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZmLKZ3cxrz6L4y1;
 Mon, 28 Apr 2025 19:08:34 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id 37D9D1402EF;
 Mon, 28 Apr 2025 19:10:33 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.203.177.99) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Apr 2025 13:10:32 +0200
To: <qemu-devel@nongnu.org>
CC: <philmd@linaro.org>, <alireza.sanaee@huawei.com>, <anisinha@redhat.com>,
 <armbru@redhat.com>, <berrange@redhat.com>, <dapeng1.mi@linux.intel.com>,
 <eric.auger@redhat.com>, <farman@linux.ibm.com>, <gustavo.romero@linaro.org>, 
 <imammedo@redhat.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>, <mst@redhat.com>,
 <mtosatti@redhat.com>, <peter.maydell@linaro.org>, <qemu-arm@nongnu.org>,
 <richard.henderson@linaro.org>, <shameerali.kolothum.thodi@huawei.com>,
 <shannon.zhaosl@gmail.com>, <yangyicong@hisilicon.com>, <zhao1.liu@intel.com>
Subject: [PATCH v10 5/6] tests/qtest/bios-table-test: testing new ARM ACPI
 PPTT tables
Date: Mon, 28 Apr 2025 12:07:53 +0100
Message-ID: <20250428110754.48-6-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428110754.48-1-alireza.sanaee@huawei.com>
References: <20250428110754.48-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.203.177.99]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500003.china.huawei.com (7.182.85.28)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Test new PPTT table with cache representation.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tests/qtest/bios-tables-test.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 0a333ec43536..8218b39de7cb 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1846,7 +1846,10 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
 
     data.variant = ".acpihmatvirt";
 
-    test_acpi_one(" -machine hmat=on"
+    test_acpi_one(" -machine hmat=on "
+                  "-M virt,smp-cache.0.cache=l1i,smp-cache.0.topology=core,"
+                  "smp-cache.1.cache=l1d,smp-cache.1.topology=core,"
+                  "smp-cache.2.cache=l2,smp-cache.2.topology=core "
                   " -cpu cortex-a57"
                   " -smp 4,sockets=2"
                   " -m 384M"
@@ -2123,6 +2126,9 @@ static void test_acpi_aarch64_virt_tcg(void)
     data.smbios_cpu_max_speed = 2900;
     data.smbios_cpu_curr_speed = 2700;
     test_acpi_one("-cpu cortex-a57 "
+                  "-M virt,smp-cache.0.cache=l1i,smp-cache.0.topology=core,"
+                  "smp-cache.1.cache=l1d,smp-cache.1.topology=core,"
+                  "smp-cache.2.cache=l2,smp-cache.2.topology=core "
                   "-smbios type=4,max-speed=2900,current-speed=2700", &data);
     free_test_data(&data);
 }
@@ -2142,6 +2148,9 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
     };
 
     test_acpi_one("-cpu cortex-a57 "
+                  "-M virt,smp-cache.0.cache=l1i,smp-cache.0.topology=core,"
+                  "smp-cache.1.cache=l1d,smp-cache.1.topology=core,"
+                  "smp-cache.2.cache=l2,smp-cache.2.topology=core "
                   "-smp sockets=1,clusters=2,cores=2,threads=2", &data);
     free_test_data(&data);
 }
@@ -2227,6 +2236,9 @@ static void test_acpi_aarch64_virt_viot(void)
     };
 
     test_acpi_one("-cpu cortex-a57 "
+                  "-M virt,smp-cache.0.cache=l1i,smp-cache.0.topology=core,"
+                  "smp-cache.1.cache=l1d,smp-cache.1.topology=core,"
+                  "smp-cache.2.cache=l2,smp-cache.2.topology=core "
                   "-device virtio-iommu-pci", &data);
     free_test_data(&data);
 }
-- 
2.34.1


