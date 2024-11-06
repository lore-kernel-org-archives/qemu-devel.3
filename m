Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C15D3E78C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 06:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8ZQl-0002OX-IN; Wed, 06 Nov 2024 01:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1t8ZQi-0002OG-QH
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 01:22:13 -0500
Received: from mail-dm3nam02on2073.outbound.protection.outlook.com
 ([40.107.95.73] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1t8ZQf-0005tV-Fo
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 01:22:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKw5yUWjj5LnMWGzFUgpz1chd3kSgUdMA28C801bJlWf+B+KClXD72nhtApisZYOMc3S7qoDJmR/PtiK4zYLqLliRye8A5wlFUhmUQ2zIBMb7Oot4tgKr03X+dCGGQ0QLMfQvZZpYN4rUyavWVDoTua0u/sEHM6DElbn6S+tqfAUlaaFj9g0t4n330EELz/1ik5Zy6Oic4kUK9M8UhmbtAsTBPxoB5OywtI3CeyQaa821+iXNc4jCqBA1jXHh/JY0dgCNg043PITRwSkLtX+78lfg75A+6xnZdPsGjfKI52xip2eHJMY7Q9Ua9L6J12aaY+IPtNuMnzvZ8x9WXee3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/yFvXqsoiXHrBBPosOdrUbPPJTAhrEOBVR0YQqMyMw=;
 b=b9Pvg+gOpwaBxBXAYc/DZKpbDb1BCilo0aCptIhG4wfauGaur0bUKgYImvZjOeupmnHRFW6iLgh47WyEOA/KVDHm4akd2Q3cf9iWe0hXg5nSIrJ7s4sXlTP5TEdx/WCF5K/3mgU7Ij5cuWe3AqfyB4gpmxI1S2gq1Hri+nkSLcZjBTvjKiRSM9Bdt9rqHq0dc/M1bbCICcYCDNs1frO/cscGZCQSwX7oM+uBUV/mzlTfFIaAMvQzpKaZzgfOX6g72QxHLOWkEfAJj2X+LfeCVIRqJlElCL3ugDSC1MJarqnJKzEhHIIPw2gUrA49jCBoVvAD9osGZK18v4X+RSDUow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/yFvXqsoiXHrBBPosOdrUbPPJTAhrEOBVR0YQqMyMw=;
 b=MtUhI5x8E6qJwk2kXe9eEhH0MCWZPQoAPuTV9cgu0KVQPbTy38UV6+xQDJ40b1dhmXg40Pvlo+9rr+ghNq3dV6U1K3V1HUUYVcG3oA6V9LZFeyFW8uUseDGMnun4IE0qLPCpp9Fqauf4gv8HChbnEjACmU3Qre/KcsafR/IneLk=
Received: from SA9PR13CA0086.namprd13.prod.outlook.com (2603:10b6:806:23::31)
 by MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 06:16:59 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:23:cafe::66) by SA9PR13CA0086.outlook.office365.com
 (2603:10b6:806:23::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.11 via Frontend
 Transport; Wed, 6 Nov 2024 06:16:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 06:16:58 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 00:15:13 -0600
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD
 <anthony@xenproject.org>, Paul Durrant <paul@xen.org>, "Edgar E . Iglesias"
 <edgar.iglesias@gmail.com>
CC: <qemu-devel@nongnu.org>, <xen-devel@lists.xenproject.org>, "Stewart
 Hildebrand" <stewart.hildebrand@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>,
 Huang Rui <ray.huang@amd.com>
Subject: [QEMU PATCH v10] xen/passthrough: use gsi to map pirq when dom0 is PVH
Date: Wed, 6 Nov 2024 14:14:18 +0800
Message-ID: <20241106061418.3655304-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|MN0PR12MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea4a54c-d44b-4519-3300-08dcfe2a9ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Evt0MQeRA3d1BcAZs/uSvql9sDZl21PtyYkV+ncMfYP2Z5HeNQVEVARsvaLH?=
 =?us-ascii?Q?ZhAPQtYHn8q/K0WWuXcIMFGN5zrbml02GyeZbjUb5VnNPUTGLwC6ayEV8KYm?=
 =?us-ascii?Q?Ckysm/UyJqpbfVO2i3idCz6zsRBbbUl8XbCboTum1uW87WXsm5wpOemG7Gg/?=
 =?us-ascii?Q?YVol9sSu6+pb7QsSY2+56nCIwICUHACLebvO6+X2Io0D/D4ZFyo32umtKPM0?=
 =?us-ascii?Q?CuPhNcRb+jLTB8AUv1Mom7CQXoHBylUbNPFwsnK6mxYNbcpGeoNZjYpFRBBb?=
 =?us-ascii?Q?BLG2zZSgSzbXoyCZKnYkrOFe8mj27nD9F3Dmfx+xEWUe4db334rs5SZoTbHr?=
 =?us-ascii?Q?rrBt/h/9+1LlFTCzrXP9wkGdb9fvfuCZ6WhcMYLuBYHyACi3LHJNIWUniEMf?=
 =?us-ascii?Q?F4pDF+h1Dhkwnc4t3Qd5Hc7XsZQ8vIBXz3CGIv7iKlbQ76FEML3S1g3CRaK1?=
 =?us-ascii?Q?kPPj09F5cm/D2NUerptEa9pdvOtG/KyblgarMy9B1hT6pwBew0XTeznkdo81?=
 =?us-ascii?Q?jJUPrMPsjU2LPmSDCdj/PTNgNYeT8cOIcKX/b9pQU8Uw4sLnLe4mrFYR5+Oz?=
 =?us-ascii?Q?OCLfrZmANvkGt6KrzmHKg3oCJPJlLBzPn6bWlws4rsjf0QoMW4IOvZ0WiLHb?=
 =?us-ascii?Q?t9cDrbxrGkYFAsVeOevappIkNMYVnibhXlA5QtDUdqAx87DjhO092cGixAFv?=
 =?us-ascii?Q?c8OgMgniZNYe6lcECsouN8U2QsD8Hn/fUgzUk4JuEY4SNP3kYMKJd6qtxXUU?=
 =?us-ascii?Q?nbeeqDtDpuTfnOwr1Zaj0WWnscaW1x7E3twiayEvpb9cRSgYVUjfiUHioMDf?=
 =?us-ascii?Q?Y27vSZlvh2HEMJPlpF4oJChdl93p7sq5Cjm1c0BI4OvX5gr4lCZvRXgEyZak?=
 =?us-ascii?Q?sRU6Zpzkyt5/xv40rhtAaaNB+v5TKhGNPM7Lm53L718VqngIu2SSkJiTxBf4?=
 =?us-ascii?Q?wpyxWTngaUWhnZKPSgW9r1QPY4l0Fhwl5unHMl1awhZ98kLrI5+1pkSJt4WU?=
 =?us-ascii?Q?NyvFHDgQMDixp+yTy6cIZL8RzmDhG/UHrX5QBZ7pYCjMGpH+hZfHnBmEgjmO?=
 =?us-ascii?Q?zuxpPYeFRb079sa8tldcM7o1STWK3IlBpr1lf7LfU/MiT7nyjReGL6KSldZR?=
 =?us-ascii?Q?ZKAhoXd6Xva+4NQpMKUnn4CwoxXFD+6MwIH3XQXbts6uW/yULfRNMcF3UnbI?=
 =?us-ascii?Q?pT9irGacFC9e+jZBGQPto7bYTQlrYduttroPFmXiMqG1AuYD/XFBrarvD2uB?=
 =?us-ascii?Q?YAHKhrLeTbM45ONTL96+EaK4aTKaPjYpw07hT6Aqy9sKUFdj9x4IMrk1o13O?=
 =?us-ascii?Q?x7nvI1g94Qnk2mGgB3XZO5poUemzK4x+XWQsvFw/k+heKmvu113aYWq/aXjE?=
 =?us-ascii?Q?sPL2k4uNYO8OjypOorT02Rhelhrdl8CR06YoTuloZATZeCcDMQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 06:16:58.2276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea4a54c-d44b-4519-3300-08dcfe2a9ea1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5859
Received-SPF: permerror client-ip=40.107.95.73;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
This is v10 to support passthrough on Xen when dom0 is PVH.
v9->v10 changes:
* Check the return value of function fgets.
* Added comment to explain why set the length of array 'type' to be 10.

Best regards,
Jiqian Chen

v8->v9 changes:
* Moved the definition of PCI_SBDF from /hw/xen/xen_pt.c to /include/hw/pci/pci.h.
* Renamed xen_run_qemu_on_hvm to xen_pt_need_gsi.
* Renamed xen_map_pirq_for_gsi to xen_pt_map_pirq_for_gsi.
* Through reading /sys/hypervisor/guest_type to get dom type instead of using xc_domain_getinfo_single.

v7->v8 changes:
* Since xc_physdev_gsi_from_dev was renamed to xc_pcidev_get_gsi, changed it.
* Added xen_run_qemu_on_hvm to check if Qemu run on PV dom0, if not use xc_physdev_map_pirq_gsi to map pirq.
* Used CONFIG_XEN_CTRL_INTERFACE_VERSION to wrap the new part for compatibility.
* Added "#define DOMID_RUN_QEMU 0" to represent the id of domain that Qemu run on.

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
 hw/xen/xen_pt.c      | 60 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h |  4 +++
 2 files changed, 64 insertions(+)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 3635d1b39f79..5e6230c4a60f 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -766,6 +766,57 @@ static void xen_pt_destroy(PCIDevice *d) {
 }
 /* init */
 
+#if CONFIG_XEN_CTRL_INTERFACE_VERSION >= 42000
+static bool xen_pt_need_gsi(void)
+{
+    FILE *fp;
+    int len;
+    /*
+     * The max length of guest_type is "PVH"+'\n'+'\0', it is 5,
+     * so here set the length of type to be twice.
+     */
+    char type[10];
+    const char *guest_type = "/sys/hypervisor/guest_type";
+
+    fp = fopen(guest_type, "r");
+    if (!fp) {
+        error_report("Cannot open %s: %s", guest_type, strerror(errno));
+        return false;
+    }
+
+    if (fgets(type, sizeof(type), fp)) {
+        len = strlen(type);
+        if (len) {
+            type[len - 1] = '\0';
+            if (!strcmp(type, "PVH")) {
+                fclose(fp);
+                return true;
+            }
+        }
+    }
+
+    fclose(fp);
+    return false;
+}
+
+static int xen_pt_map_pirq_for_gsi(PCIDevice *d, int *pirq)
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
@@ -847,7 +898,16 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
         goto out;
     }
 
+#if CONFIG_XEN_CTRL_INTERFACE_VERSION >= 42000
+    if (xen_pt_need_gsi()) {
+        rc = xen_pt_map_pirq_for_gsi(d, &pirq);
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
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index eb26cac81098..07805aa8a5f3 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -23,6 +23,10 @@ extern bool pci_available;
 #define PCI_SLOT_MAX            32
 #define PCI_FUNC_MAX            8
 
+#define PCI_SBDF(seg, bus, dev, func) \
+            ((((uint32_t)(seg)) << 16) | \
+            (PCI_BUILD_BDF(bus, PCI_DEVFN(dev, func))))
+
 /* Class, Vendor and Device IDs from Linux's pci_ids.h */
 #include "hw/pci/pci_ids.h"
 
-- 
2.34.1


