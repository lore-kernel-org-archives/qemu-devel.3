Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A402BFEC119
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 20:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w58h9-0000wv-A9; Tue, 24 Mar 2026 16:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w58h2-0000uq-Ik
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:49:41 -0400
Received: from p-west2-cluster2-host4-snip4-1.eps.apple.com ([57.103.68.154]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w58gz-0004fs-Ok
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:49:40 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-0 (Postfix) with ESMTPS id
 76D4C180046D; Tue, 24 Mar 2026 20:49:35 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774385376; x=1776977376;
 bh=Slu9+iHyMdVhlhZuw5M4rGv9gIxHstRiINTWvh1+tLk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=g0rUetWkfuPh+krfQ0OntROUfPH+BBntQ53f0G1JqJbyVfJTqDKUyhekMVjNS5urMcvQz7Raf+aaWkAgMhVq3Cf+Koa2l5K3CFDSZBxKVeSOJ9vaB/UfGyTwZCFWoaWD9FsM+J2CthUJP1t/ihNoAS/S+HZzsysRFksYmwG1r59O6q1tOb7WI4Pu0VUtX4thOpT5bNX4gtIu1RLgjHHhhXLFq29MIv+R4TKMeQZFwCroHmRhEb55PYVg/4D5a39w1CXW+BQNF+sAAFXI60FUnE7LrYPs5T2NQAgrmK4zMGr5m4HNs8MqDqLgB6b3XFb7tLp0FHjkxzOfxiaKVYfS5A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-0 (Postfix) with ESMTPSA id
 124C51800488; Tue, 24 Mar 2026 20:49:31 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC PATCH v7 5/7] vmapple: add gicv2m
Date: Tue, 24 Mar 2026 21:48:53 +0100
Message-ID: <20260324204855.29759-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324204855.29759-1-mohamed@unpredictable.fr>
References: <20260324204855.29759-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2MSBTYWx0ZWRfX1gPOuHeGFlRV
 U5YShwoep0alvLF1P9dl5hTva3dJ6x38NdT4AgfFjrijWwKPtXXKxVbEBnr4wMU6UKjWdsTFPXP
 AcjWKPfeb/3DPDoN/xq243MNxOux4rXQV0HSh6AR2lE0zDYDdh78qM6UcjIUyxB1n/x1LGeWVZ/
 z7lCtiaVZu0Y8eOJPTHIOZtZFhZm+/qENZoUdAAdMU09n2ToFSzeCib740oXhXshx/ZLqD+gqX4
 xQ7ZUVHSBUIhLG3LF4Zdo/4Z9aIKoN9BjBm9c4RCCvqW1DdLa3UqiRSaMMgL/hxhmSD+vMVwBIN
 022CU/H/ryLWbpc9RKIq/xUL7vNdqMK4AB+9OOe/t7t3mqz7lLnJLvdWU4vsWU=
X-Authority-Info-Out: v=2.4 cv=cZXfb3DM c=1 sm=1 tr=0 ts=69c2f8df
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=sAlVIecbGMDsLuTEZI0A:9
X-Proofpoint-ORIG-GUID: QDDtq6uyBio8YFPQ3s-IXTYtZmWlvc4p
X-Proofpoint-GUID: QDDtq6uyBio8YFPQ3s-IXTYtZmWlvc4p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=818 lowpriorityscore=0 clxscore=1030 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603240161
Received-SPF: pass client-ip=57.103.68.154;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/vmapple/vmapple.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index 48d1ebc7d1..f2a6fda2e5 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -84,6 +84,7 @@ enum {
     VMAPPLE_MEM,
     VMAPPLE_GIC_DIST,
     VMAPPLE_GIC_REDIST,
+    VMAPPLE_GICV2M,
     VMAPPLE_UART,
     VMAPPLE_RTC,
     VMAPPLE_PCIE,
@@ -105,6 +106,7 @@ static const MemMapEntry memmap[] = {
 
     [VMAPPLE_GIC_DIST] =           { 0x10000000, 0x00010000 },
     [VMAPPLE_GIC_REDIST] =         { 0x10010000, 0x00400000 },
+    [VMAPPLE_GICV2M] =             { 0x1FFF0000, 0x00010000 },
 
     [VMAPPLE_UART] =               { 0x20010000, 0x00010000 },
     [VMAPPLE_RTC] =                { 0x20050000, 0x00001000 },
@@ -130,6 +132,7 @@ static const int irqmap[] = {
     [VMAPPLE_APV_GFX] = 0x11,
     [VMAPPLE_AES_1] = 0x12,
     [VMAPPLE_PCIE] = 0x20,
+    [VMAPPLE_GICV2M] = 0x80
 };
 
 #define GPEX_NUM_IRQS 16
@@ -287,6 +290,26 @@ static void create_gic(VMAppleMachineState *vms, MemoryRegion *mem)
     }
 }
 
+#define NUM_GICV2M_SPIS       128
+
+static void create_gicv2m(VMAppleMachineState *vms)
+{
+    int i;
+    int irq = vms->irqmap[VMAPPLE_GICV2M];
+    DeviceState *dev;
+
+    dev = qdev_new("arm-gicv2m");
+    qdev_prop_set_uint32(dev, "base-spi", irq);
+    qdev_prop_set_uint32(dev, "num-spi", NUM_GICV2M_SPIS);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VMAPPLE_GICV2M].base);
+
+    for (i = 0; i < NUM_GICV2M_SPIS; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           qdev_get_gpio_in(vms->gic, irq + i));
+    }
+}
+
 static void create_uart(const VMAppleMachineState *vms, int uart,
                         MemoryRegion *mem, Chardev *chr)
 {
@@ -497,6 +520,7 @@ static void mach_vmapple_init(MachineState *machine)
                                 machine->ram);
 
     create_gic(vms, sysmem);
+    create_gicv2m(vms);
     create_bdif(vms, sysmem);
     create_pvpanic(vms, sysmem);
     create_aes(vms, sysmem);
-- 
2.50.1 (Apple Git-155)


