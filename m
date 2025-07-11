Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022C6C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua96z-0003Vy-1o; Fri, 11 Jul 2025 04:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8y6-0005YS-B2; Fri, 11 Jul 2025 04:18:55 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8y4-00045U-3w; Fri, 11 Jul 2025 04:18:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 200FB1356DA;
 Fri, 11 Jul 2025 11:17:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 11DE123FA4F;
 Fri, 11 Jul 2025 11:17:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Vasant Hegde <vasant.hegde@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 15/39] hw/i386/amd_iommu: Fix xtsup when vcpus < 255
Date: Fri, 11 Jul 2025 11:16:11 +0300
Message-ID: <20250711081745.1785806-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Vasant Hegde <vasant.hegde@amd.com>

If vCPUs > 255 then x86 common code (x86_cpus_init()) call kvm_enable_x2apic().
But if vCPUs <= 255 then the common code won't calls kvm_enable_x2apic().

This is because commit 8c6619f3e692 ("hw/i386/amd_iommu: Simplify non-KVM
checks on XTSup feature") removed the call to kvm_enable_x2apic when xtsup
is "on", which break things when guest is booted with x2apic mode and
there are <= 255 vCPUs.

Fix this by adding back kvm_enable_x2apic() call when xtsup=on.

Fixes: 8c6619f3e692 ("hw/i386/amd_iommu: Simplify non-KVM checks on XTSup feature")
Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Message-Id: <20250516100535.4980-3-sarunkod@amd.com>
Fixes: 8c6619f3e692 ("hw/i386/amd_iommu: Simplify non-KVM checks on XTSup feature")
Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
(cherry picked from commit 0f178860df3489a9d3c19a5f7f024e6aa6c26515)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index df8ba5d39a..af85706b8a 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1649,6 +1649,14 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
         exit(EXIT_FAILURE);
     }
 
+    if (s->xtsup) {
+        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
+            error_report("AMD IOMMU xtsup=on requires x2APIC support on "
+                          "the KVM side");
+            exit(EXIT_FAILURE);
+        }
+    }
+
     pci_setup_iommu(bus, &amdvi_iommu_ops, s);
     amdvi_init(s);
 }
-- 
2.47.2


