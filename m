Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613D7C0219E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 05:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti5Yw-0002un-Bs; Wed, 12 Feb 2025 00:45:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1ti5Yu-0002uO-Jb
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 00:45:28 -0500
Received: from mail-bn8nam12on2060f.outbound.protection.outlook.com
 ([2a01:111:f403:2418::60f]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1ti5Ys-0006GL-Eo
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 00:45:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzF/SamQSvR7VSZFHcEoGUzR66QFRlrA6RD2Fj8BJZVjlibZt5KepkKiCnT/86pp4xG12caRmwqqnKVQHVngTnIaS0r81UNLcmjwaPzfyo4jj1EdnW/6RtCbzvSoYZSYowVaPYWA4YXxYmh4rmderYUqORGTFCBpW2FtbQT4vCb2MiYqmjav9ntqE3mfhKlSsqrtsmJG8+qNk2jzW+LUvzGlWAb/Q2FPhA6W2vJFuJSCcKWNqRKSDhBVQE5pIWMkxlWEVeK0V1ppRlzvMPi1n16k2ZlyeKFiLnimeepz0XgwZc42ffyMjOJMbbKPg5Kj9Aon8Y/cEpbO43fraQoyZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+37t8iaREdbfp8pbnpzOY527WTZu5ToKMS/xwtLprPA=;
 b=L0ROHPfr3xKchz7GhqZnMcGdeBfb5d0nTXYI499o3pZLUGagBmCJ8NW8RVvc3Rtklc3hlo+6q5uhGGjgXkeoUrAvjsKraCT5EQ7IDkjrNTmxgANWF/pWOIstzYlGdp5z9B6GiPNdZZigHiidOPkosANjO4TU6hXezTmi8FoD5l4WyNRt0LdiJGJDTBMna6NmpUQviomahTMJxw7MGO+FafTgiFedabPW9Sp1j6xPmfipFdV2l5t8IK15XpNGbqLXBdDSGzzXElYssyc9WaLwdUv+NEswG9ZEAGtqQbdv4AZQYk6O2mg0miR+C9RiwBdFghBZYnr8Gi1LMbqJA/H8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+37t8iaREdbfp8pbnpzOY527WTZu5ToKMS/xwtLprPA=;
 b=qUSkU27CBzn295x0O0nxBDj4MMggCwGMRG2FP1ZKfJACMuEL0vSUY7Kmb13UhTLIZreCFqT7eeMK31PNvNfq+mlwm8UBYfgnNA39yGCLUc4644V6JCCPiR7SAUQV97cNjXXP1OghDC13g6FR99i2Np37+gxKvLC3ws9czodEbak=
Received: from SN1PR12CA0043.namprd12.prod.outlook.com (2603:10b6:802:20::14)
 by SJ0PR12MB6736.namprd12.prod.outlook.com (2603:10b6:a03:47a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 05:45:20 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:802:20:cafe::2) by SN1PR12CA0043.outlook.office365.com
 (2603:10b6:802:20::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 12 Feb 2025 05:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 05:45:20 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 23:45:15 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
 <vasant.hegde@amd.com>, <Wei.Huang2@amd.com>, <bsd@redhat.com>,
 <berrange@redhat.com>, <joao.m.martins@oracle.com>,
 <alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 2/2] hw/i386/amd_iommu: Allow migration when explicitly
 create the AMDVI-PCI device
Date: Wed, 12 Feb 2025 05:44:50 +0000
Message-ID: <20250212054450.578449-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212054450.578449-1-suravee.suthikulpanit@amd.com>
References: <20250212054450.578449-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|SJ0PR12MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: 95876053-1180-431e-7bf6-08dd4b286fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Oxb4G01gV8YlJfmufGdH0M0RVC3/eDgzMaNV63nvxt+6xTnQQnJqpnhVUUvI?=
 =?us-ascii?Q?wsuwdXUzvsDxiwU9+gA/5S7R0Yy8Kr375x6dHZVMUkyZblih6DGuRnU+dLzU?=
 =?us-ascii?Q?Wu8m0HsYxHfHa/XOIbDNLsVAmbba3s369PQCGTVLRUEtpIQSFZ85l4rhImYw?=
 =?us-ascii?Q?kCp0UTd7qfGyaaLn5L7RfvPmOJDO5E0FgRqfVbQQfuW8ERK6jc8QPmd8TZfZ?=
 =?us-ascii?Q?U/vE+HpNsjudogg7RtIWFXWdi4kiypW/2lFO7TU5qGVSZOkcqIDrHsrEemg1?=
 =?us-ascii?Q?YFX7O6ad523Cx54A85wzTWb3b1bhpSR3tE+Qv/0dTIvItfOORxL8IgIDgt5o?=
 =?us-ascii?Q?oTJXTvxTuy6lr4eBjlboec2P5q+2vvesMbMSmEDgE2pOuY5gdaYwlRqixzMR?=
 =?us-ascii?Q?t4U7yiQ8u4G2L0pYZ+bnwRZZKSPxKV/4/RLLmOhxh2IPuxRxzuoS0L9sJqso?=
 =?us-ascii?Q?rKIADLpRmaFI2Jm4+PUpAolI/3XKxkJbQ+tMQbcgisjTsPBHAj7EhC32cSfi?=
 =?us-ascii?Q?//LEhCHMGMzPeGr8krKtqzajlnTee3L9TaXfm2pYhALhshBVx3YfrKSM8Vx9?=
 =?us-ascii?Q?m8OcBBbSt8x1VMzv1dpT3IVdUgo/7bqTgiQHuyzScVMvPqTK8mMbKrscmNLm?=
 =?us-ascii?Q?CYYczDjM7uMFT1n/YoTJLyQbSGDbCC4NJe81ZvpCRU7uxoY7aACfir1sQKvc?=
 =?us-ascii?Q?Y+S2EV/VHEPztXVzAHG36XNOU8vDNN7pkHwjx0Qga+Bs9eqH87J56ba6KAsG?=
 =?us-ascii?Q?D93wJZzuPT1ch07AcL9tfmsBkMFnDd5Nv+jeuL/QXd97+nY+62nUegWQ5hHC?=
 =?us-ascii?Q?0puTm6tnS2VPSdXfZTSeXQ2rCmrgWy4lhGiHEZEDFuam590VO9XVne5e8cec?=
 =?us-ascii?Q?1uSVfdXU561V+l2OFOi4CV1VKIFKEblXK/dnB73RAeoqZCDFl2eJIPO7Vz62?=
 =?us-ascii?Q?ZZvpZ9hmBuWAWbCnMd5VeRVz7fxHx9O2EHv+QgllfvfWpTz1FDaXwJejCA4N?=
 =?us-ascii?Q?Cj9PqHXFmg3dzPfs0MHHrPU9ma5UYGTjgwYcAHl+Yb5HUG/AymGSG5iD7mMS?=
 =?us-ascii?Q?5bXaWjo+a4U/02RwqMRcqLAhlha4Wcgw69cYO8zPRssaJPIQkaXDAvcUeXi3?=
 =?us-ascii?Q?H3VjNvediXTs5Sac+GggURJxjRDfHEoxeHsYRq332RLxt7PfvCUkXRJJ3W5/?=
 =?us-ascii?Q?H7v9ksYAsqX1+gUtl2hac0fNKcQqq3TMbI3Qrcnpxu9H4/On+hGMJES+PFpM?=
 =?us-ascii?Q?2lGFFWX9a6ZAdbOscu0EjpOJKUHAq2CZzZpZAe77uCax6J7prGWAw/WELzkx?=
 =?us-ascii?Q?DhKGGUGYemJk2sP18A5oLAGFU0BBtqJGvF6xvPAF5sB3Sn0dQbWfd0WwciFD?=
 =?us-ascii?Q?UaulsBJ/XltCDnQIPyOq/Fu76VKq9ADiiBBPLgh7QHmZ3DkVAm2oEG3nD4hR?=
 =?us-ascii?Q?zazUpfq4D4w0+nQW0J0RrvPHZU6JKvZHzXQhwmfxq17BAqK6bNfcy5rU0wY+?=
 =?us-ascii?Q?9gPhRf16Y6sJSsE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 05:45:20.1685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95876053-1180-431e-7bf6-08dd4b286fc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6736
Received-SPF: permerror client-ip=2a01:111:f403:2418::60f;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add migration support for AMD IOMMU model by saving necessary AMDVIState
parameters for MMIO registers, device table, command buffer, and event
buffers.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 hw/i386/amd_iommu.c | 58 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 0f552bafa0..dda1a5781f 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1611,6 +1611,57 @@ static void amdvi_sysbus_reset(DeviceState *dev)
     amdvi_init(s);
 }
 
+static const VMStateDescription vmstate_amdvi_sysbus = {
+    .name = "amd-iommu",
+    .unmigratable = 1
+};
+
+static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
+    .name = "amd-iommu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .priority = MIG_PRI_IOMMU,
+    .fields = (VMStateField[]) {
+      /* Updated in  amdvi_handle_control_write() */
+      VMSTATE_BOOL(enabled, AMDVIState),
+      VMSTATE_BOOL(ga_enabled, AMDVIState),
+      VMSTATE_BOOL(ats_enabled, AMDVIState),
+      VMSTATE_BOOL(cmdbuf_enabled, AMDVIState),
+      VMSTATE_BOOL(completion_wait_intr, AMDVIState),
+      VMSTATE_BOOL(evtlog_enabled, AMDVIState),
+      VMSTATE_BOOL(evtlog_intr, AMDVIState),
+      /* Updated in amdvi_handle_devtab_write() */
+      VMSTATE_UINT64(devtab, AMDVIState),
+      VMSTATE_UINT64(devtab_len, AMDVIState),
+      /* Updated in amdvi_handle_cmdbase_write() */
+      VMSTATE_UINT64(cmdbuf, AMDVIState),
+      VMSTATE_UINT64(cmdbuf_len, AMDVIState),
+      /* Updated in amdvi_handle_cmdhead_write() */
+      VMSTATE_UINT32(cmdbuf_head, AMDVIState),
+      /* Updated in amdvi_handle_cmdtail_write() */
+      VMSTATE_UINT32(cmdbuf_tail, AMDVIState),
+      /* Updated in amdvi_handle_evtbase_write() */
+      VMSTATE_UINT64(evtlog, AMDVIState),
+      VMSTATE_UINT32(evtlog_len, AMDVIState),
+      /* Updated in amdvi_handle_evthead_write() */
+      VMSTATE_UINT32(evtlog_head, AMDVIState),
+      /* Updated in amdvi_handle_evttail_write() */
+      VMSTATE_UINT32(evtlog_tail, AMDVIState),
+      /* Updated in amdvi_handle_pprbase_write() */
+      VMSTATE_UINT64(ppr_log, AMDVIState),
+      VMSTATE_UINT32(pprlog_len, AMDVIState),
+      /* Updated in amdvi_handle_pprhead_write() */
+      VMSTATE_UINT32(pprlog_head, AMDVIState),
+      /* Updated in amdvi_handle_tailhead_write() */
+      VMSTATE_UINT32(pprlog_tail, AMDVIState),
+      /* MMIO registers */
+      VMSTATE_UINT8_ARRAY(mmior, AMDVIState, AMDVI_MMIO_SIZE),
+      VMSTATE_UINT8_ARRAY(romask, AMDVIState, AMDVI_MMIO_SIZE),
+      VMSTATE_UINT8_ARRAY(w1cmask, AMDVIState, AMDVI_MMIO_SIZE),
+      VMSTATE_END_OF_LIST()
+    }
+};
+
 static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
 {
     DeviceClass *dc = (DeviceClass *) object_get_class(OBJECT(dev));
@@ -1635,6 +1686,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
         }
 
         s->pci = AMD_IOMMU_PCI(pdev);
+        dc->vmsd = &vmstate_amdvi_sysbus_migratable;
     } else {
         s->pci = AMD_IOMMU_PCI(object_new(TYPE_AMD_IOMMU_PCI));
         /* This device should take care of IOMMU PCI properties */
@@ -1685,12 +1737,6 @@ static const Property amdvi_properties[] = {
     DEFINE_PROP_STRING("pci-id", AMDVIState, pci_id),
 };
 
-static const VMStateDescription vmstate_amdvi_sysbus = {
-    .name = "amd-iommu",
-    .unmigratable = 1
-};
-
-
 static void amdvi_sysbus_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-- 
2.34.1


