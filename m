Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D2ED44D58
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 13:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8fiI-0005vu-Io; Wed, 06 Nov 2024 08:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t8fiG-0005qt-Ho; Wed, 06 Nov 2024 08:04:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t8fiE-0000Wr-S4; Wed, 06 Nov 2024 08:04:44 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xk5293Kzxz6K7Hj;
 Wed,  6 Nov 2024 21:01:53 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id B738D14011D;
 Wed,  6 Nov 2024 21:04:40 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.126.170.112) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 14:04:26 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>,
 <imammedo@redhat.com>
CC: <salil.mehta@huawei.com>, <jonathan.cameron@huawei.com>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <anisinha@redhat.com>, <eduardo@habkost.net>, <marcel.apfelbaum@gmail.com>,
 <david@redhat.com>, <philmd@linaro.org>, <peterx@redhat.com>,
 <pbonzini@redhat.com>, <gshan@redhat.com>, <borntraeger@linux.ibm.com>,
 <alex.bennee@linaro.org>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>, <zhao1.liu@intel.com>, 
 <linuxarm@huawei.com>, <gustavo.romero@linaro.org>
Subject: [PATCH 2/3] Fix: Reverse CPUs presence check logic for x86 backward
 compatability
Date: Wed, 6 Nov 2024 13:03:30 +0000
Message-ID: <20241106130331.205020-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106130331.205020-1-salil.mehta@huawei.com>
References: <20241106130331.205020-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.170.112]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Checking `is_present` first can break x86 migration from new Qemu
version to old Qemu. This is because CPRS Bit is not defined in the
older Qemu register block and will always be 0 resulting in check always
failing. Reversing the logic to first check `is_enabled` can alleviate
below problem:

-                If ((\_SB.PCI0.PRES.CPEN == One))
-                {
-                    Local0 = 0x0F
+                If ((\_SB.PCI0.PRES.CPRS == One))
+                {
+                    If ((\_SB.PCI0.PRES.CPEN == One))
+                    {
+                        Local0 = 0x0F
+                    }
+                    Else
+                    {
+                        Local0 = 0x0D
+                    }
                 }

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20241106100047.18901c9d@imammedo.users.ipa.redhat.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/acpi/cpu.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 23443f09a5..b2f7a2b27e 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -490,22 +490,22 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
             aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
             aml_append(method, aml_store(idx, cpu_selector));
             aml_append(method, aml_store(zero, sta));
-            ifctx = aml_if(aml_equal(is_present, one));
+            ifctx = aml_if(aml_equal(is_enabled, one));
             {
-                ifctx2 = aml_if(aml_equal(is_enabled, one));
-                {
-                    /* cpu is present and enabled */
-                    aml_append(ifctx2, aml_store(aml_int(0xF), sta));
-                }
-                aml_append(ifctx, ifctx2);
-                else_ctx = aml_else();
+                /* cpu is present and enabled */
+                aml_append(ifctx, aml_store(aml_int(0xF), sta));
+            }
+            aml_append(method, ifctx);
+            else_ctx = aml_else();
+            {
+                ifctx2 = aml_if(aml_equal(is_present, one));
                 {
                     /* cpu is present but disabled */
-                    aml_append(else_ctx, aml_store(aml_int(0xD), sta));
+                    aml_append(ifctx2, aml_store(aml_int(0xD), sta));
                 }
-                aml_append(ifctx, else_ctx);
+                aml_append(else_ctx, ifctx2);
             }
-            aml_append(method, ifctx);
+            aml_append(method, else_ctx);
             aml_append(method, aml_release(ctrl_lock));
             aml_append(method, aml_return(sta));
         }
-- 
2.34.1


