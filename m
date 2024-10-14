Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A96D1813D
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 19:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Qfs-0003PI-H2; Mon, 14 Oct 2024 15:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0Qfr-0003Kg-8x; Mon, 14 Oct 2024 15:24:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0Qfp-00055b-Io; Mon, 14 Oct 2024 15:24:10 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XS6Z02Wphz6K6T7;
 Tue, 15 Oct 2024 03:22:32 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id B124A1400D9;
 Tue, 15 Oct 2024 03:24:07 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.48.146.149) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 21:23:48 +0200
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <will@kernel.org>,
 <ardb@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <gshan@redhat.com>, <rafael@kernel.org>, <borntraeger@linux.ibm.com>,
 <alex.bennee@linaro.org>, <npiggin@gmail.com>, <harshpb@linux.ibm.com>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>,
 <gustavo.romero@linaro.org>
Subject: [PATCH V1 4/4] hw/acpi: Populate vCPU Hotplug VMSD to migrate
 `is_{present, enabled}` states
Date: Mon, 14 Oct 2024 20:22:05 +0100
Message-ID: <20241014192205.253479-5-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014192205.253479-1-salil.mehta@huawei.com>
References: <20241014192205.253479-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.146.149]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The ACPI CPU hotplug states `is_{present, enabled}` must be migrated alongside
other vCPU hotplug states to the destination VM. Therefore, they should be
integrated into the existing CPU Hotplug VM State Description (VMSD) table.
Depending on the architecture and its implementation of CPU hotplug events
(such as ACPI GED, etc.), the CPU hotplug states should be populated
appropriately within their corresponding subsections of the VMSD table.

    "acpi-ged (16)": {
        "ged_state": {
            "sel": "0x00000000"
        },
        [...]
        "acpi-ged/cpuhp": {
            "cpuhp_state": {
                "selector": "0x00000005",
                "command": "0x00",
                "devs": [
                    {
                        "is_inserting": false,
                        "is_removing": false,
                        "is_present": true,
                        "is_enabled": true,
                        "ost_event": "0x00000000",
                        "ost_status": "0x00000000"
                    },
                    {
                        "is_inserting": false,
                        "is_removing": false,
                        "is_present": true,
                        "is_enabled": true,
                        "ost_event": "0x00000000",
                        "ost_status": "0x00000000"
                    },
                    {
                        "is_inserting": false,
                        "is_removing": false,
                        "is_present": true,
                        "is_enabled": true,
                        "ost_event": "0x00000000",
                        "ost_status": "0x00000000"
                    },
                    {
                        "is_inserting": false,
                        "is_removing": false,
                        "is_present": true,
                        "is_enabled": true,
                        "ost_event": "0x00000000",
                        "ost_status": "0x00000000"
                    },
                    {
                        "is_inserting": false,
                        "is_removing": false,
                        "is_present": true,
                        "is_enabled": false,
                        "ost_event": "0x00000000",
                        "ost_status": "0x00000000"
                    },
                    {
                        "is_inserting": false,
                        "is_removing": false,
                        "is_present": true,
                        "is_enabled": false,
                        "ost_event": "0x00000000",
                        "ost_status": "0x00000000"
                    }
                ]
            }
        }
    },

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/acpi/cpu.c                  |  2 ++
 hw/acpi/generic_event_device.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 23ea2b9c70..d34c1e601e 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -340,6 +340,8 @@ static const VMStateDescription vmstate_cpuhp_sts = {
     .fields = (const VMStateField[]) {
         VMSTATE_BOOL(is_inserting, AcpiCpuStatus),
         VMSTATE_BOOL(is_removing, AcpiCpuStatus),
+        VMSTATE_BOOL(is_present, AcpiCpuStatus),
+        VMSTATE_BOOL(is_enabled, AcpiCpuStatus),
         VMSTATE_UINT32(ost_event, AcpiCpuStatus),
         VMSTATE_UINT32(ost_status, AcpiCpuStatus),
         VMSTATE_END_OF_LIST()
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 15b4c3ebbf..a4d78a534c 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -331,6 +331,16 @@ static const VMStateDescription vmstate_memhp_state = {
     }
 };
 
+static const VMStateDescription vmstate_cpuhp_state = {
+    .name = "acpi-ged/cpuhp",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_CPU_HOTPLUG(cpuhp_state, AcpiGedState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_ged_state = {
     .name = "acpi-ged-state",
     .version_id = 1,
@@ -379,6 +389,7 @@ static const VMStateDescription vmstate_acpi_ged = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_memhp_state,
+        &vmstate_cpuhp_state,
         &vmstate_ghes_state,
         NULL
     }
-- 
2.34.1


