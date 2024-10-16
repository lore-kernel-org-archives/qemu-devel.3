Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B85AD2069E
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 06:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0xbe-0001iv-MI; Wed, 16 Oct 2024 02:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1t0xbZ-0001ib-AE
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 02:33:57 -0400
Received: from mail-bn8nam11on2046.outbound.protection.outlook.com
 ([40.107.236.46] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1t0xbX-00086e-By
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 02:33:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qO7E1qqV6uQ0YAsF7C5wMyvq7qyhuN7qBOL0mYExYZPSV4ZdCOT05yXiI0MgmhHwVcITACChkUeYA/kJKuM0bPHS8uOT4GFqh9q55oqM0kk/x6bKGy58ldsSyZp/yWzp2cJKz51C7vLh/gFnvUu67s1plDOsW4R7+2LftafJCqOu4A90xb5Yk9C/xeM4OWRAG8eAPwRDKTm+6TDv7QS/HHBzKA7JQCTdYhZaz28pA+N8HeoUc8SLuosZCi0gMXerrDheBu2FvYUMSDoYw31+K/B7VAFVRSxPiBW0L5csHyh69Ygw7XwlrFTlULaOwXsa9pI2NnI23xv5qyxevAktYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Qa+/Vrr5vYV8N9Hqm6E9aPfl5zi0iD1R8OkMk0hb40=;
 b=ofaIzaWoXsprLXAqBAIFrVie0Evko9XiuASyuxwzsHB9wH51A7rGXrs7dqAiXvgeABo/QjXqrYZ3pYinW56UE0CVv2k5ktUtlcgDdvBlIxzTB4j1LwXfea7QkrDSfewpUr3SLaO7eI1pvW1Y4paEUi2YzNyN2LHHpaAMjTSe5HPleEynUkRy8ycqN6Z/d196+Pns1cnngfAk0ytfnewA8I0Im9U8ig9RJ2Dbcadt6YcMI+9mrOpTOzS7jb8Gudz5fMVOmwJRFUpsZl7v9FC//9ZTHHCZvw4Wg3aYLY4c+Ywd2q4UIDfXtZjQC+xqLUR4BapbHH7sITPB2qnHyq+zYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Qa+/Vrr5vYV8N9Hqm6E9aPfl5zi0iD1R8OkMk0hb40=;
 b=XG1Ly6/2nCr09Ej5oKJcsJG3d6P2J3vq/udR0dCJL7+zYK2jl60NQ1KY89Gxq3j1dTSn77ootzmTBcLPZhYwsDfCDL23f5pt8P+lzFbYRnM+fM4Ay7ZO5Ipkc+anfjPqBB0A0g8QP45RkHKp/MnF5w6gVHeOCrOpaHRG57g7QJI=
Received: from SJ0PR03CA0090.namprd03.prod.outlook.com (2603:10b6:a03:331::35)
 by PH0PR12MB8797.namprd12.prod.outlook.com (2603:10b6:510:28d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Wed, 16 Oct
 2024 06:28:43 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::68) by SJ0PR03CA0090.outlook.office365.com
 (2603:10b6:a03:331::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 06:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 06:28:43 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 01:28:40 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD
 <anthony@xenproject.org>, Paul Durrant <paul@xen.org>, "Edgar E . Iglesias"
 <edgar.iglesias@gmail.com>
CC: <qemu-devel@nongnu.org>, <xen-devel@lists.xenproject.org>, Huang Rui
 <Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>, Huang Rui
 <ray.huang@amd.com>
Subject: [QEMU PATCH v8] xen/passthrough: use gsi to map pirq when dom0 is PVH
Date: Wed, 16 Oct 2024 14:28:27 +0800
Message-ID: <20241016062827.2301004-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|PH0PR12MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: 9348a513-3acd-4696-da8e-08dcedabc815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PE3p22gpaIpl7KxYAt6w7HoXWIp/AsCVFvkKFmHG4bXdjeQ6OMSi4ze2G0wJ?=
 =?us-ascii?Q?zCg/BNz9KrG2CIXLFWunrCo9EQza9dI/am5ctwk88WbJ/Y5kyzQpPJUNhhUB?=
 =?us-ascii?Q?eiPkoP31zW02CosRHdApmri3aS1vd/dBhH3EuEuq5SC1P8njaQiKl9rSFfXC?=
 =?us-ascii?Q?grWIo1bAzo1nYxx9ZtIPY0+uzc07jZhGzbaEQoazkUWSFY3oE1FxLc4RxLay?=
 =?us-ascii?Q?d488+JFfG4hEO098a6ccmCrGI0HacnRW7tUtLX2AI87gf0ciRM5UA+EeY+Kq?=
 =?us-ascii?Q?O6ggfG9xW+4pz61pnBHZ/08zzOVu3LEJq7qHc030e0qXaiRsieSOnHRXCOiO?=
 =?us-ascii?Q?4OztvwaaSXH7nk1E/rR/MrhKaxOtHanmNBZomAg+a4LWVVKWtxjxSZ6ONpaE?=
 =?us-ascii?Q?t5EgKhCYp2pIkUeXlYRXAUNBidBPa4DEAQPuX7FGooJz5OqfvO464ttbD6c4?=
 =?us-ascii?Q?Y23Kl9TGhuMLqAEHG7djb9YJc/USeADslyb9zK+OlPKnQh+yQIlObM/F4DPy?=
 =?us-ascii?Q?Pbw698+zzwToeyjaXHYnm0GqmBtrwxtiWLlPiaHnfSv3vl7rucz1R2cZ/5Ed?=
 =?us-ascii?Q?d+OAKovRhnFncvg0li5y/5ivkz0XT2zN5k4VUdjofo4MIEoU/Ly77JCfwQgD?=
 =?us-ascii?Q?0YKDXEz5HW5izgIYkD0rWJ3JNU8c3BNOp8xpqqKnubJQOx+YfuQoL/LBlNei?=
 =?us-ascii?Q?5roahadnt5Cdt7VyB3Ywd9U2gQZzFDNlv9p21mAn+D3F1xoxfE2e5KTpGWJE?=
 =?us-ascii?Q?uYjMKX4qv2pKubqX8jwtu0Pzd7BcCfSCLa9Ds3bZkefUnobmSkpoXocRSk0c?=
 =?us-ascii?Q?pYRQ0A5mVbLLaNNTU3lL+WK8MEGYoWOdtkqtgqswHmCuALWNBpC9tn6hpM6m?=
 =?us-ascii?Q?9oJDOflE9yMLpsKgk/les6FY67wnH8OC4HHTCSJ/gy4doruAhYTg3XXhtaFY?=
 =?us-ascii?Q?0A/SFVLNWBXyTp8YNrWZhgt4NrzNZgwNcB0m4TeSEABp4EnGFnf8LTngauix?=
 =?us-ascii?Q?0iC+dRbsYAz2Nsj1syL9ZbiHUSNjlxazuTCiaVL3z+E9QcEehQlJi/Ctjq/G?=
 =?us-ascii?Q?xFt0EH5DxbCV3YZ9587bEf0+G1X3fq8ehYmHzS6SSmGBNekVvpSdH0bGmkbx?=
 =?us-ascii?Q?AFivVhdZJdhajFYAFGu3JCuRNnfoJdoHBGKsymoej5jrTUjFaM+7wuXmtQFN?=
 =?us-ascii?Q?xm1WwK/ZHKWib+OiTJUXjm7whx+PKsKHV5Ugg28MDNMHJcx+jEj3FKTRxvgK?=
 =?us-ascii?Q?rzdhla4iMLaBXYrxqLTzcVjYijYcemT/aA7onBZwDChiiBp9ZGd/R2igp9Ex?=
 =?us-ascii?Q?7ym7FZi/p7u63iRmTEaT7YEjYhbU4eZamgro81FRSF3VSMsZnCtA3QuOE2GX?=
 =?us-ascii?Q?4LQxXRd8jJASkqs1ONk1dHJ5pnKJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 06:28:43.0427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9348a513-3acd-4696-da8e-08dcedabc815
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8797
Received-SPF: permerror client-ip=40.107.236.46;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-1.249, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In PVH dom0, when passthrough a device to domU, QEMU code
xen_pt_realize->xc_physdev_map_pirq wants to use gsi, but in current codes
the gsi number is got from file /sys/bus/pci/devices/<sbdf>/irq, that is
wrong, because irq is not equal with gsi, they are in different spaces, so
pirq mapping fails.

To solve above problem, use new interface of Xen, xc_pcidev_get_gsi to get
gsi and use xc_physdev_map_pirq_gsi to map pirq when dom0 is PVH.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
Hi All,
This is v8 to support passthrough on Xen when dom0 is PVH.
v7->v8 change:
* Since xc_physdev_gsi_from_dev was renamed to xc_pcidev_get_gsi, changed it.
* Added xen_run_qemu_on_hvm to check if Qemu run on PV dom0, if not use xc_physdev_map_pirq_gsi to map pirq.
* Used CONFIG_XEN_CTRL_INTERFACE_VERSION to wrap the new part for compatibility.
* Added "#define DOMID_RUN_QEMU 0" to represent the id of domain that Qemu run on.


Best regards,
Jiqian Chen



v6->v7 changes:
* Because the function of obtaining gsi was changed on the kernel and Xen side. Changed to use
  xc_physdev_gsi_from_dev, that requires passing in sbdf instead of irq.

v5->v6 changes:
* Because the function of obtaining gsi was changed on the kernel and Xen side. Changed to use
  xc_physdev_gsi_from_irq, instead of gsi sysfs.
* Since function changed, removed the Review-by of Stefano.

v4->v5 changes:
* Added Review-by Stefano.

v3->v4 changes:
* Added gsi into struct XenHostPCIDevice and used gsi number that read from gsi sysfs
  if it exists, if there is no gsi sysfs, still use irq.

v2->v3 changes:
* Due to changes in the implementation of the second patch on kernel side(that adds
  a new sysfs for gsi instead of a new syscall), so read gsi number from the sysfs of gsi.

v1 and v2:
We can record the relation between gsi and irq, then when userspace(qemu) want
to use gsi, we can do a translation. The third patch of kernel(xen/privcmd: Add new syscall
to get gsi from irq) records all the relations in acpi_register_gsi_xen_pvh() when dom0
initialize pci devices, and provide a syscall for userspace to get the gsi from irq. The
third patch of xen(tools: Add new function to get gsi from irq) add a new function
xc_physdev_gsi_from_irq() to call the new syscall added on kernel side.
And then userspace can use that function to get gsi. Then xc_physdev_map_pirq() will success.

Issues we encountered:
1. failed to map pirq for gsi
Problem: qemu will call xc_physdev_map_pirq() to map a passthrough device's gsi to pirq in
function xen_pt_realize(). But failed.

Reason: According to the implement of xc_physdev_map_pirq(), it needs gsi instead of irq,
but qemu pass irq to it and treat irq as gsi, it is got from file
/sys/bus/pci/devices/xxxx:xx:xx.x/irq in function xen_host_pci_device_get(). But actually
the gsi number is not equal with irq. They are in different space.
---
 hw/xen/xen_pt.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 hw/xen/xen_pt.h |  1 +
 2 files changed, 45 insertions(+)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 3635d1b39f79..7f8139d20915 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -766,6 +766,41 @@ static void xen_pt_destroy(PCIDevice *d) {
 }
 /* init */
 
+#define PCI_SBDF(seg, bus, dev, func) \
+            ((((uint32_t)(seg)) << 16) | \
+            (PCI_BUILD_BDF(bus, PCI_DEVFN(dev, func))))
+
+#if CONFIG_XEN_CTRL_INTERFACE_VERSION >= 42000
+static bool xen_run_qemu_on_hvm(void)
+{
+    xc_domaininfo_t info;
+
+    if (!xc_domain_getinfo_single(xen_xc, DOMID_RUN_QEMU, &info) &&
+        (info.flags & XEN_DOMINF_hvm_guest)) {
+        return true;
+    }
+
+    return false;
+}
+
+static int xen_map_pirq_for_gsi(PCIDevice *d, int *pirq)
+{
+    int gsi;
+    XenPCIPassthroughState *s = XEN_PT_DEVICE(d);
+
+    gsi = xc_pcidev_get_gsi(xen_xc,
+                            PCI_SBDF(s->real_device.domain,
+                                     s->real_device.bus,
+                                     s->real_device.dev,
+                                     s->real_device.func));
+    if (gsi >= 0) {
+        return xc_physdev_map_pirq_gsi(xen_xc, xen_domid, gsi, pirq);
+    }
+
+    return gsi;
+}
+#endif
+
 static void xen_pt_realize(PCIDevice *d, Error **errp)
 {
     ERRP_GUARD();
@@ -847,7 +882,16 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
         goto out;
     }
 
+#if CONFIG_XEN_CTRL_INTERFACE_VERSION >= 42000
+    if (xen_run_qemu_on_hvm()) {
+        rc = xen_map_pirq_for_gsi(d, &pirq);
+    } else {
+        rc = xc_physdev_map_pirq(xen_xc, xen_domid, machine_irq, &pirq);
+    }
+#else
     rc = xc_physdev_map_pirq(xen_xc, xen_domid, machine_irq, &pirq);
+#endif
+
     if (rc < 0) {
         XEN_PT_ERR(d, "Mapping machine irq %u to pirq %i failed, (err: %d)\n",
                    machine_irq, pirq, errno);
diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index 095a0f0365d4..a08b45b7fbae 100644
--- a/hw/xen/xen_pt.h
+++ b/hw/xen/xen_pt.h
@@ -36,6 +36,7 @@ void xen_pt_log(const PCIDevice *d, const char *f, ...) G_GNUC_PRINTF(2, 3);
 #  define XEN_PT_LOG_CONFIG(d, addr, val, len)
 #endif
 
+#define DOMID_RUN_QEMU 0
 
 /* Helper */
 #define XEN_PFN(x) ((x) >> XC_PAGE_SHIFT)
-- 
2.34.1


