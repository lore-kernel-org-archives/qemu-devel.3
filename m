Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF5FC25B77
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 23:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9CXC-0006rP-PX; Mon, 20 May 2024 19:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s9CX5-0006gA-A9; Mon, 20 May 2024 19:35:07 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s9CX0-0001j6-Qc; Mon, 20 May 2024 19:35:06 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vjv2m41Wyz6K6jV;
 Tue, 21 May 2024 07:31:12 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
 by mail.maildlp.com (Postfix) with ESMTPS id 25A5F1400D4;
 Tue, 21 May 2024 07:34:59 +0800 (CST)
Received: from 00293818-MRGF.china.huawei.com (10.126.174.235) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 00:34:36 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <oliver.upton@linux.dev>,
 <pbonzini@redhat.com>, <mst@redhat.com>, <will@kernel.org>,
 <gshan@redhat.com>, <rafael@kernel.org>, <alex.bennee@linaro.org>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <npiggin@gmail.com>, <harshpb@linux.ibm.com>, <linuxarm@huawei.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Shaoqin Huang <shahuang@redhat.com>
Subject: [PATCH V10 4/8] hw/acpi: Update GED _EVT method AML with CPU scan
Date: Tue, 21 May 2024 00:32:37 +0100
Message-ID: <20240520233241.229675-5-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240520233241.229675-1-salil.mehta@huawei.com>
References: <20240520233241.229675-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.174.235]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhrpeml500001.china.huawei.com (7.191.163.213)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

OSPM evaluates _EVT method to map the event. The CPU hotplug event eventually
results in start of the CPU scan. Scan figures out the CPU and the kind of
event(plug/unplug) and notifies it back to the guest. Update the GED AML _EVT
method with the call to \\_SB.CPUS.CSCN

Also, macro CPU_SCAN_METHOD might be referred in other places like during GED
intialization so it makes sense to have its definition placed in some common
header file like cpu_hotplug.h. But doing this can cause compilation break
because of the conflicting macro definitions present in cpu.c and cpu_hotplug.c
and because both these files get compiled due to historic reasons of x86 world
i.e. decision to use legacy(GPE.2)/modern(GED) CPU hotplug interface happens
during runtime [1]. To mitigate above, for now, declare a new common macro
ACPI_CPU_SCAN_METHOD for CPU scan method instead.
(This needs a separate discussion later on for clean-up)

Reference:
[1] https://lore.kernel.org/qemu-devel/1463496205-251412-24-git-send-email-imammedo@redhat.com/

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Xianglai Li <lixianglai@loongson.cn>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
---
 hw/acpi/cpu.c                  | 2 +-
 hw/acpi/generic_event_device.c | 4 ++++
 include/hw/acpi/cpu_hotplug.h  | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 473b37ba88..af2b6655d2 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -327,7 +327,7 @@ const VMStateDescription vmstate_cpu_hotplug = {
 #define CPUHP_RES_DEVICE  "PRES"
 #define CPU_LOCK          "CPLK"
 #define CPU_STS_METHOD    "CSTA"
-#define CPU_SCAN_METHOD   "CSCN"
+#define CPU_SCAN_METHOD   ACPI_CPU_SCAN_METHOD
 #define CPU_NOTIFY_METHOD "CTFY"
 #define CPU_EJECT_METHOD  "CEJ0"
 #define CPU_OST_METHOD    "COST"
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 54d3b4bf9d..63226b0040 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -109,6 +109,10 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
                 aml_append(if_ctx, aml_call0(MEMORY_DEVICES_CONTAINER "."
                                              MEMORY_SLOT_SCAN_METHOD));
                 break;
+            case ACPI_GED_CPU_HOTPLUG_EVT:
+                aml_append(if_ctx, aml_call0(ACPI_CPU_CONTAINER "."
+                                             ACPI_CPU_SCAN_METHOD));
+                break;
             case ACPI_GED_PWR_DOWN_EVT:
                 aml_append(if_ctx,
                            aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotplug.h
index 48b291e45e..ef631750b4 100644
--- a/include/hw/acpi/cpu_hotplug.h
+++ b/include/hw/acpi/cpu_hotplug.h
@@ -20,6 +20,8 @@
 #include "hw/acpi/cpu.h"
 
 #define ACPI_CPU_HOTPLUG_REG_LEN 12
+#define ACPI_CPU_SCAN_METHOD "CSCN"
+#define ACPI_CPU_CONTAINER "\\_SB.CPUS"
 
 typedef struct AcpiCpuHotplug {
     Object *device;
-- 
2.34.1


