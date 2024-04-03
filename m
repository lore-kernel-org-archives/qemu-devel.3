Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE11CD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 10:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrxuX-0006Ps-Lu; Wed, 03 Apr 2024 06:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rrxuW-0006Mt-1a
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 06:32:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rrxuU-0004dl-5e
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 06:32:03 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8gxs2pFRz6J9nb;
 Wed,  3 Apr 2024 18:30:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 70EC2140A36;
 Wed,  3 Apr 2024 18:32:00 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 11:31:59 +0100
To: <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>,
 <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Dave Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>,
 <imammedo@redhat.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 5/6] bios-tables-test: Add complex SRAT / HMAT test for GI GP
Date: Wed, 3 Apr 2024 11:29:26 +0100
Message-ID: <20240403102927.31263-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403102927.31263-1-Jonathan.Cameron@huawei.com>
References: <20240403102927.31263-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a test with 6 nodes to exercise most interesting corner cases
of SRAT and HMAT generation including the new Generic Initiator
and Generic Port Affinity structures.  More details of the
set up in the following patch adding the table data.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tests/qtest/bios-tables-test.c | 92 ++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index d1ff4db7a2..1651d06b7b 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1862,6 +1862,96 @@ static void test_acpi_q35_tcg_acpi_hmat_noinitiator(void)
     free_test_data(&data);
 }
 
+/* Test intended to hit corner cases of SRAT and HMAT */
+static void test_acpi_q35_tcg_acpi_hmat_generic_x(void)
+{
+    test_data data = {};
+
+    data.machine = MACHINE_Q35;
+    data.variant = ".acpihmat-generic-x";
+    test_acpi_one(" -machine hmat=on,cxl=on"
+                  " -smp 3,sockets=3"
+                  " -m 128M,maxmem=384M,slots=2"
+                  " -device virtio-rng-pci,id=gidev"
+                  " -device pxb-cxl,bus_nr=64,bus=pcie.0,id=cxl.1"
+                  " -object memory-backend-ram,size=64M,id=ram0"
+                  " -object memory-backend-ram,size=64M,id=ram1"
+                  " -numa node,nodeid=0,cpus=0,memdev=ram0"
+                  " -numa node,nodeid=1"
+                  " -object acpi-generic-initiator,id=gi0,pci-dev=gidev,node=1"
+                  " -numa node,nodeid=2"
+                  " -object acpi-generic-port,id=gp0,pci-bus=cxl.1,node=2"
+                  " -numa node,nodeid=3,cpus=1"
+                  " -numa node,nodeid=4,memdev=ram1"
+                  " -numa node,nodeid=5,cpus=2"
+                  " -numa hmat-lb,initiator=0,target=0,hierarchy=memory,"
+                  "data-type=access-latency,latency=10"
+                  " -numa hmat-lb,initiator=0,target=0,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=800M"
+                  " -numa hmat-lb,initiator=0,target=2,hierarchy=memory,"
+                  "data-type=access-latency,latency=100"
+                  " -numa hmat-lb,initiator=0,target=2,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=200M"
+                  " -numa hmat-lb,initiator=0,target=4,hierarchy=memory,"
+                  "data-type=access-latency,latency=100"
+                  " -numa hmat-lb,initiator=0,target=4,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=200M"
+                  " -numa hmat-lb,initiator=0,target=5,hierarchy=memory,"
+                  "data-type=access-latency,latency=200"
+                  " -numa hmat-lb,initiator=0,target=5,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=400M"
+                  " -numa hmat-lb,initiator=1,target=0,hierarchy=memory,"
+                  "data-type=access-latency,latency=500"
+                  " -numa hmat-lb,initiator=1,target=0,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=100M"
+                  " -numa hmat-lb,initiator=1,target=2,hierarchy=memory,"
+                  "data-type=access-latency,latency=50"
+                  " -numa hmat-lb,initiator=1,target=2,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=400M"
+                  " -numa hmat-lb,initiator=1,target=4,hierarchy=memory,"
+                  "data-type=access-latency,latency=50"
+                  " -numa hmat-lb,initiator=1,target=4,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=800M"
+                  " -numa hmat-lb,initiator=1,target=5,hierarchy=memory,"
+                  "data-type=access-latency,latency=500"
+                  " -numa hmat-lb,initiator=1,target=5,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=100M"
+                  " -numa hmat-lb,initiator=3,target=0,hierarchy=memory,"
+                  "data-type=access-latency,latency=20"
+                  " -numa hmat-lb,initiator=3,target=0,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=400M"
+                  " -numa hmat-lb,initiator=3,target=2,hierarchy=memory,"
+                  "data-type=access-latency,latency=80"
+                  " -numa hmat-lb,initiator=3,target=2,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=200M"
+                  " -numa hmat-lb,initiator=3,target=4,hierarchy=memory,"
+                  "data-type=access-latency,latency=80"
+                  " -numa hmat-lb,initiator=3,target=4,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=200M"
+                  " -numa hmat-lb,initiator=3,target=5,hierarchy=memory,"
+                  "data-type=access-latency,latency=20"
+                  " -numa hmat-lb,initiator=3,target=5,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=400M"
+                  " -numa hmat-lb,initiator=5,target=0,hierarchy=memory,"
+                  "data-type=access-latency,latency=20"
+                  " -numa hmat-lb,initiator=5,target=0,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=400M"
+                  " -numa hmat-lb,initiator=5,target=2,hierarchy=memory,"
+                  "data-type=access-latency,latency=80"
+                  " -numa hmat-lb,initiator=5,target=4,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=200M"
+                  " -numa hmat-lb,initiator=5,target=4,hierarchy=memory,"
+                  "data-type=access-latency,latency=80"
+                  " -numa hmat-lb,initiator=5,target=2,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=200M"
+                  " -numa hmat-lb,initiator=5,target=5,hierarchy=memory,"
+                  "data-type=access-latency,latency=10"
+                  " -numa hmat-lb,initiator=5,target=5,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=800M",
+                  &data);
+    free_test_data(&data);
+}
+
 #ifdef CONFIG_POSIX
 static void test_acpi_erst(const char *machine)
 {
@@ -2304,6 +2394,8 @@ int main(int argc, char *argv[])
             qtest_add_func("acpi/q35/nohpet", test_acpi_q35_tcg_nohpet);
             qtest_add_func("acpi/q35/acpihmat-noinitiator",
                            test_acpi_q35_tcg_acpi_hmat_noinitiator);
+            qtest_add_func("acpi/q35/acpihmat-genericx",
+                           test_acpi_q35_tcg_acpi_hmat_generic_x);
 
             /* i386 does not support memory hotplug */
             if (strcmp(arch, "i386")) {
-- 
2.39.2


