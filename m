Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF3FCF043B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 03:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syNKm-0006RS-97; Tue, 08 Oct 2024 23:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNKj-0006NG-TR; Tue, 08 Oct 2024 23:25:53 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNKh-0004xj-OU; Tue, 08 Oct 2024 23:25:53 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNdZ50ghQz6K98k;
 Wed,  9 Oct 2024 11:25:33 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id B7C8C140A34;
 Wed,  9 Oct 2024 11:25:49 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.126.173.89) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 05:25:30 +0200
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
Subject: [PATCH RFC V4 19/33] target/arm: Force ARM vCPU *present* status ACPI
 *persistent*
Date: Wed, 9 Oct 2024 04:18:01 +0100
Message-ID: <20241009031815.250096-20-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009031815.250096-1-salil.mehta@huawei.com>
References: <20241009031815.250096-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.173.89]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The ARM CPU architecture does not permit changes to CPU presence after the
kernel has booted. This is an immutable requirement from ARM and represents a
strict architectural constraint [1][2].

The ACPI update [3] reinforces this by specifying that the `_STA.Present` bit
in the ACPI specification cannot be modified once the system has booted.
Consequently, the firmware, ACPI, and QEMU must provide the guest kernel with a
persistent view of the vCPUs, even when they are not present in the QOM
(i.e., when they are unplugged or have yet to be plugged into the QOM after the
kernel has booted).

References:
[1] KVMForum 2023 Presentation: Challenges Revisited in Supporting Virt CPU Hotplug on
    architectures that don’t Support CPU Hotplug (like ARM64)
    a. Kernel Link: https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf
    b. Qemu Link:  https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf
[2] KVMForum 2020 Presentation: Challenges in Supporting Virtual CPU Hotplug on
    SoC Based Systems (like ARM64)
    Link: https://kvmforum2020.sched.com/event/eE4m
[3] Check comment 5 in the bugzilla entry
    Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 target/arm/cpu64.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 2a517fdb9f..a84f312ae2 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -794,6 +794,13 @@ static void aarch64_cpu_initfn(Object *obj)
      */
     cs->disabled = true;
     cs->thread_id = 0;
+    /*
+     * To provide the guest with a persistent view of vCPU presence, ACPI may
+     * need to simulate the presence of vCPUs even when they are not present in
+     * the QOM or are in a disabled state. This flag is utilized during the
+     * initialization of ACPI hotplug state and during vCPU hot-unplug events.
+     */
+    cs->acpi_persistent = true;
 }
 
 static void aarch64_cpu_finalizefn(Object *obj)
-- 
2.34.1


