Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367C7CFC283
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ede-0004K2-3m; Tue, 15 Oct 2024 06:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0edV-0004EL-9R; Tue, 15 Oct 2024 06:18:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0edT-0003l0-AG; Tue, 15 Oct 2024 06:18:41 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XSVQ356K0z6FGyW;
 Tue, 15 Oct 2024 18:16:59 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id E8EA91404F5;
 Tue, 15 Oct 2024 18:18:36 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.48.146.149) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 12:18:17 +0200
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <peterx@redhat.com>, <eric.auger@redhat.com>,
 <will@kernel.org>, <ardb@kernel.org>, <oliver.upton@linux.dev>,
 <pbonzini@redhat.com>, <gshan@redhat.com>, <rafael@kernel.org>,
 <borntraeger@linux.ibm.com>, <alex.bennee@linaro.org>, <npiggin@gmail.com>,
 <harshpb@linux.ibm.com>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>,
 <gustavo.romero@linaro.org>
Subject: [PATCH RFC V5 30/30] hw/arm/virt: Expose cold-booted vCPUs as MADT
 GICC *Enabled*
Date: Tue, 15 Oct 2024 11:18:00 +0100
Message-ID: <20241015101800.254351-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015100012.254223-1-salil.mehta@huawei.com>
References: <20241015100012.254223-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Hotpluggable vCPUs must be exposed as "online-capable" according to the new UEFI
specification [1][2]. However, marking cold-booted vCPUs as "online-capable"
during boot may cause them to go undetected by legacy operating systems,
potentially leading to compatibility issues. Hence, both 'online-capable' bit
and 'Enabled' bit in GIC CPU Interface flags should not be mutually exclusive as
they are now.

Since implementing this specification change may take time, it is necessary to
temporarily *disable* support for *unplugging* cold-booted vCPUs to maintain
compatibility with legacy OS environments.

As an alternative and temporary mitigation, we could introduce a property that
controls whether cold-booted vCPUs are marked as unpluggable. Community feedback
on this approach would be appreciated.

References:
[1] Original UEFI/ACPI proposed Change Bugzilla – TianoCore
    Link: https://bugzilla.tianocore.org/show_bug.cgi?id=3706
[2] Advanced Configuration and Power Interface (ACPI) Specification, Release 6.5, Aug 29, 2022
    Section: 5.2.12.14 GIC CPU Interface (GICC) Structure / Table 5.37: GICC CPU Interface Flags
    Link: https://uefi.org/sites/default/files/resources/ACPI_Spec_6_5_Aug29.pdf (Pages 138, 140)

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c         | 16 ++++++++++++++++
 include/hw/core/cpu.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 15d9c2d8ac..d1172151be 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3174,6 +3174,10 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         virt_update_gic(vms, cs, true);
         wire_gic_cpu_irqs(vms, cs);
     }
+
+    if (!dev->hotplugged) {
+        cs->cold_booted = true;
+    }
 }
 
 static void virt_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
@@ -3248,6 +3252,18 @@ static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
         return;
     }
 
+    /*
+     * UEFI ACPI standard change is required to make both 'enabled' and the
+     * 'online-capable' bit co-exist instead of being mutually exclusive.
+     * check virt_acpi_get_gicc_flags() for more details.
+     *
+     * Disable the unplugging of cold-booted vCPUs as a temporary mitigation.
+     */
+    if (cs->cold_booted) {
+        error_setg(errp, "Hot-unplug of cold-booted CPU not supported!");
+        return;
+    }
+
     if (cs->cpu_index == first_cpu->cpu_index) {
         error_setg(errp, "Boot CPU(id%d=%d:%d:%d:%d) hot-unplug not supported",
                    first_cpu->cpu_index, cpu->socket_id, cpu->cluster_id,
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 4a74c383ab..7b7ca2c32c 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -571,6 +571,8 @@ struct CPUState {
     uint32_t halted;
     int32_t exception_index;
 
+    bool cold_booted;
+
     AccelCPUState *accel;
 
     /* Used to keep track of an outstanding cpu throttle thread for migration
-- 
2.34.1


