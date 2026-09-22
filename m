Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED31DC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x98OL-00010m-MS; Tue, 22 Sep 2026 17:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x98OJ-000109-IS
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:51:07 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x98OH-0000Wf-NL
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:51:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+aQKMVNWLr6+irRaoBX1iYFjDs9v3R+fQtYASQyYI4zIySYZVwQfJl7Bu3M+XbkmPyaHSAjvmeLeK1AZyPNqNc5UEAUBG1tEVy+ziNg/+5tX/bf1U9u/Qshpn/ZAaYgHIauDnIjsOD7egZY29IUsK8SU2Y/qt6MJUdSoeospdnMGUaFwZ7d6kzVSm4Jhq/b9IV798rKIKWeqCvaPau6kbrcgwnwkeCS22uF6AVa9+bTz2g+v8+x8d01TBuW6dyz7HDQjT7iCRmf2DZDbOvClU187Jhh46tPns7sqKSA3CmuwD1iS6s6Iml2SRhHyFPnJRttQ0JBi5Z/kksIqJCpxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdoyOHYMtUjK6wycTBT5jAXmD3BGFt1Co9DP5TDfifw=;
 b=BlOFe62Msdccup7K1esd80ENRNugOheJXdqbQOc7eRrHBxZjLMT2VLw5TOXhxOhKydluohcPXCkg1agH/t3wZ2XcpRTXvzmwmcObpmSZbe4fOtzCOygz58o0ZQlejhDm0k13mKojFOO87G6/GWUNJZZkn5iQ+cGlOHuNcFfwpZkr4b9aeIB8m/3ak8plBzo7oG9E0ReW07tlhrD/fXDGjE8j3WuFw+j94t/9TYlPS2AA2n3rrpKcLmpxN/2Qf4szv2yOR4ivG2zNpumymz//DBRrMPhHq4Botn7yojjz8MoIHW50kUGLNWSI1bCIYvnkgnpok9ETIFGEvy7nDcMx9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdoyOHYMtUjK6wycTBT5jAXmD3BGFt1Co9DP5TDfifw=;
 b=C/nChoHbYRMPUlTqX0/vQBOmhsnQbhZGlaGb64fVyRpCdrs3irEyJSfB6qvdBH4DeXLOF06r0NLA/cbGfZQdSxshdr9n+dQpl1RDSFVnHuMVd7Q6BpZ1cadr8TrH2NGrULFrYoWEHQ70N5HAU4asOc7rupQilFPdzx6XRobMEtB86OFyQjStqGIEfwykl02Jw1tIcAYezfH1tQI8YCigTR1jn9xmhPVXX6/esYyYFad69lZlPpdjF6ybxkmPjtW6Jh2YKJktqYwvPhOblXXGeUlnkJImIW5Wu08CRP6b2IdLMHwkqY1waph7kuNZ45LevShOQXTFPrvIDKh/zgltJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by PH0PR12MB8126.namprd12.prod.outlook.com
 (2603:10b6:510:299::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Tue, 22 Sep
 2026 21:50:20 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 21:50:20 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, philmd@oss.qualcomm.com, zhao1.liu@intel.com,
 yishaih@nvidia.com, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com
Subject: [PATCH 2/3] hw/pci: Expose ACS ctrl on Guest as configured by the HYP
Date: Tue, 22 Sep 2026 16:50:07 -0500
Message-Id: <20260922215008.2554402-3-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922215008.2554402-1-tdave@nvidia.com>
References: <20260922215008.2554402-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::10) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|PH0PR12MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ff06d97-f5da-4e35-6756-08df18f37f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: q16ZazGx4cpj2Jo98ITi5fzuMfWNOGo+1Kt4YwM03VNdAsJpjh5ydlINiqOsAuVytRz8K+FsZUVRP+GfcI+Ax9ll8p0ur50znHewljKy1h4NCnD0PBVznMVAK7XvMO18/UrqkF0yjcS2Sib8YAezCRROb91F600BFgpimhsvQNZ4Hug3+8exrSrVyIkAllj9c2gtM1ugHrhqsIJWu6DW9GvM9HHTLP39j/GtakfYPtfkpph7ETj4iDmuqqVPrOoeFcO9Q+mNyvOzc2uprUYO2tYoKqyDpuCWmfdzzcLXu0lVegUS1hC4+fCr/sUAun5LYFNzUAOi1yKQ8KlsmGlip5wvF7X7YYWhprEpS5IcE4ffMiwcm4fEFuTsm3heKgVHGbbUoM6dE62nbYOqh/7H4zXWz0luf5sgkXD3A7OhC8edIiWQjvc8xmDRWuHP383SkXPmpx/Kqkq/GQKUynZCY3LWdk/M5bciTCtFk8ehYBQ4sPq/eX0HMyx4IzV3D+WP/PdjSdi/lqSb8DRfrVi1RZjO63inVJSeKMOmF/7t13QQ1MocXO18+WknvlM6fOwXQc4lek2a2dTcR4iAeacsIK4BBfIrqmGDSm8UuI06MsPFireIBVE0fimpVvLtDo3F6WE3TEOC4LPiXqPUza48qP2NhLJtqBcv9iPTZ/q5Cyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5t4r/AcKFR3bJ8SctOrD7Tx0yILgniw+KHI5c7AlBpaTVbRRy8CpOeoZMPty?=
 =?us-ascii?Q?FeVPD+tWhNl4QZtZBughSkzlHgVbjrKstQI5YHi3GILxGgRIuCgv/VhxKXtA?=
 =?us-ascii?Q?hKcPWfJmpYI20TKTcW8/ciST5A1lg1yL+lxwAJzgiONpffrTcjVSMkR62HCO?=
 =?us-ascii?Q?uhc4VhO8CfVYTzd2nFWofbjgs/wYsK8FcQ/J1AYEu5ufV2XUk6sjfR4YwA9l?=
 =?us-ascii?Q?gN+/m+xSG5yUVHYISy40CBbIeBkAaMXAnZ2xaDukuvdKsbJbSKPXzCob+el1?=
 =?us-ascii?Q?7CIUYcKlyAl8HHfeS2evxlqnweo9EMQiHyCNOxtVkDMT3WR/iD3AGEkplw6D?=
 =?us-ascii?Q?ApCnurVvgJR1NtxAc839tkdCy1/id+pvO+6yxiq0OQzIb8WuORoogFODFpxt?=
 =?us-ascii?Q?mkUpzT3ayCJV71lxp1RVR5VvCoh1EpPRejgtD3q2AHEjunseNHTyR1sMbvJH?=
 =?us-ascii?Q?tDqkdUfJ5QPg1NldHXeZ4rcWmTGDp16SQurB6aQHc/WPuqhguLMLbRnTVxQd?=
 =?us-ascii?Q?4DZUwpv56xUNiZnU+H1I1bOscWibDBJyXATJOq5OVHpHs9K4gDV9gUHyl12o?=
 =?us-ascii?Q?+GXEbAN0FqoqwDkMc/mN5dpaPenEAHaeFurDMHPMOHwADEH1iBzYYGb/RPK5?=
 =?us-ascii?Q?85eHMXc+3d8OOIw8YaVS4wKGC92lRoniCapULVXUunc8HcZjJuTCnxNCvEpP?=
 =?us-ascii?Q?BvNmOIihm2OQT6QaFdHVAdfyWnWtsD55xIJiUbrHQvfiM042LRAVvXpR0rQ4?=
 =?us-ascii?Q?7sMiPM60gNoDNRyLDPzvx0ccciuVxl3DnBvg7cp5Q6G0OQXZlCoIHT99EptZ?=
 =?us-ascii?Q?l1Yb+oI50ZoMVvOYOtEwNZXhaXtSFdsHtdZCwfJHUw+NKGU7WfQVQUQhQLYZ?=
 =?us-ascii?Q?tU29sl4aAsZTiaHgCHLNsicmHhTU5fkTrL0IxVVOEYwGGJMnIqDtf2BrDm4D?=
 =?us-ascii?Q?tZdArIQ998kFn8vbSM7uKz1g+xA8BhMskDRq2jqpUOv+L32TgyStfzn9PYs5?=
 =?us-ascii?Q?4Xq7Aym1eQIDSS4MfP2TPULAgd3HX+KhwXcO4QMzHvELWO0CKA4zJeSJR5/p?=
 =?us-ascii?Q?IGQTDlvBmOzAOzJEPenZFJ1eBt3n8ihu05zPLOcwJ0uevheAjZBnsLlus3/R?=
 =?us-ascii?Q?US/t5Tn8GsxFyqAGDDFpvYQHn8RrAUC8/tXGMN6Uw/2EVa3z+wamqWJqq48m?=
 =?us-ascii?Q?BNuiSKhVWJhdMXKS0rpCeRsQSMlDZdO10sWt9b6jJbAe1hE7VVOwa7JDft+M?=
 =?us-ascii?Q?iwGND2KGRtDvXV+khQqCMfLFc46h29nWlw6FPJhdy5KgqP7KxtxshyPm7a2n?=
 =?us-ascii?Q?WQrf86UeaLQUF8bwr9IszoEnek57SwpznwyElidJpdk3RLJ9RUp0PClNLLD5?=
 =?us-ascii?Q?4Z6wVHmtmswN0cpSd2HTpclKxdHzcTLzRyXlOVnqnn0Ux2bsKuP2b1sZn5A4?=
 =?us-ascii?Q?xLXDCfKpWwbfTgLL9/i1Soca1JVfhyu/LPGbNzBF7ck9M7cfLlgrCbsO/RIK?=
 =?us-ascii?Q?fvOqwdIGLHgd6DC4wLyriElhmDcnHbLeWuZkL9JxulTPxKIZEvBtfYozwOSE?=
 =?us-ascii?Q?EROXzku43fG5dVqte4CTVVTcykq+P+a4ufI4mWo7KuBEMCPxoCIQ2f/osUx7?=
 =?us-ascii?Q?ayF51Ctz3hYReBNjmJUSvCU0N7SolBzYaTC8/M/qBh9So02Pqwv5ntTyyrFf?=
 =?us-ascii?Q?JxUQHPse+H0lr0wqp513KB1JbpMYFCPEoXCo1RPTARb36K1i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff06d97-f5da-4e35-6756-08df18f37f70
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 21:50:20.4598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzAaQh2u/r6mcgtWTEWtbYrIVPaYaQ16mwrkeDWEszDqQbKxifioYKJOyxWOnU8J2ieNNdf4lEpTPvnvDgskGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8126
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=tdave@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Yishai Hadas <yishaih@nvidia.com>

To support P2P on Guest we must expose to the guest OS the actual
PCIe topology and configuration as set by the HYP.

Otherwise, the behavior is considered as un-defined.

It might fail by SW or HW.

Extend both root port and downstream port to get acs ctrl bits that
should match the HYP and use them in the guest.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/pci-bridge/pcie_root_port.c     | 10 ++++++++--
 hw/pci-bridge/xio3130_downstream.c | 10 ++++++++--
 hw/pci/pcie.c                      | 18 +++++++++++++++---
 include/hw/pci/pcie.h              |  6 +++---
 include/hw/pci/pcie_port.h         |  1 +
 5 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 7c3e78010b..3ae0b75146 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -46,6 +46,7 @@ static void rp_write_config(PCIDevice *d, uint32_t address,
 static void rp_reset_hold(Object *obj, ResetType type)
 {
     PCIDevice *d = PCI_DEVICE(obj);
+    PCIEPort *p = PCIE_PORT(d);
     DeviceState *qdev = DEVICE(obj);
 
     rp_aer_vector_update(d);
@@ -53,7 +54,7 @@ static void rp_reset_hold(Object *obj, ResetType type)
     pcie_cap_deverr_reset(d);
     pcie_cap_slot_reset(d);
     pcie_cap_arifwd_reset(d);
-    pcie_acs_reset(d);
+    pcie_acs_reset(d, p->acs_ctrl);
     pcie_aer_root_reset(d);
     pci_bridge_reset(qdev);
     pci_bridge_disable_base_limit(d);
@@ -118,11 +119,15 @@ static void rp_realize(PCIDevice *d, Error **errp)
     rp_aer_vector_update(d);
 
     if (rpc->acs_offset) {
-        pcie_acs_init(d, rpc->acs_offset);
+        rc = pcie_acs_init(d, rpc->acs_offset, p->acs_ctrl, errp);
+        if (rc < 0) {
+            goto err;
+        }
     }
     return;
 
 err:
+    pcie_aer_exit(d);
     pcie_chassis_del_slot(s);
 err_pcie_cap:
     pcie_cap_exit(d);
@@ -151,6 +156,7 @@ static void rp_exit(PCIDevice *d)
 static const Property rp_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
+    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
 };
 
 static void rp_instance_post_init(Object *obj)
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 87ba30eb36..9829832c39 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -58,11 +58,12 @@ static void xio3130_downstream_write_config(PCIDevice *d, uint32_t address,
 static void xio3130_downstream_reset(DeviceState *qdev)
 {
     PCIDevice *d = PCI_DEVICE(qdev);
+    PCIEPort *p = PCIE_PORT(d);
 
     pcie_cap_deverr_reset(d);
     pcie_cap_slot_reset(d);
     pcie_cap_arifwd_reset(d);
-    pcie_acs_reset(d);
+    pcie_acs_reset(d, p->acs_ctrl);
     pci_bridge_reset(qdev);
 }
 
@@ -115,12 +116,16 @@ static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
     }
 
     if (d->cap_present & QEMU_PCIE_CAP_ACS) {
-        pcie_acs_init(d, XIO3130_ACS_OFFSET);
+        rc = pcie_acs_init(d, XIO3130_ACS_OFFSET, p->acs_ctrl, errp);
+        if (rc < 0) {
+            goto err;
+        }
     }
 
     return;
 
 err:
+    pcie_aer_exit(d);
     pcie_chassis_del_slot(s);
 err_pcie_cap:
     pcie_cap_exit(d);
@@ -144,6 +149,7 @@ static void xio3130_downstream_exitfn(PCIDevice *d)
 static const Property xio3130_downstream_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
+    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
 };
 
 static const VMStateDescription vmstate_xio3130_downstream = {
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 42bcb9206d..c36f8c58c6 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1260,7 +1260,8 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset, bool aligned)
 }
 
 /* ACS (Access Control Services) */
-void pcie_acs_init(PCIDevice *dev, uint16_t offset)
+int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
+                  Error **errp)
 {
     bool is_downstream = pci_is_express_downstream_port(dev);
     uint16_t cap_bits = 0;
@@ -1284,16 +1285,27 @@ void pcie_acs_init(PCIDevice *dev, uint16_t offset)
          */
         cap_bits = PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
             PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT;
+
+        if (ctrl_bits & ~cap_bits) {
+            error_setg(errp,
+                       "Unsupported ACS capabilities 0x%hx were supplied. "
+                       "Supported capabilities are 0x%hx",
+                       ctrl_bits & ~cap_bits, cap_bits);
+            return -EINVAL;
+        }
     }
 
     pci_set_word(dev->config + offset + PCI_ACS_CAP, cap_bits);
     pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, cap_bits);
+    pci_set_word(dev->config + offset + PCI_ACS_CTRL, ctrl_bits);
+
+    return 0;
 }
 
-void pcie_acs_reset(PCIDevice *dev)
+void pcie_acs_reset(PCIDevice *dev, uint16_t val)
 {
     if (dev->exp.acs_cap) {
-        pci_set_word(dev->config + dev->exp.acs_cap + PCI_ACS_CTRL, 0);
+        pci_set_word(dev->config + dev->exp.acs_cap + PCI_ACS_CTRL, val);
     }
 }
 
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index ec25e7a7de..1ab7b3eee5 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -137,9 +137,9 @@ bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
                             uint16_t offset, uint16_t size);
 void pcie_sync_bridge_lnk(PCIDevice *dev);
 
-void pcie_acs_init(PCIDevice *dev, uint16_t offset);
-void pcie_acs_reset(PCIDevice *dev);
-
+int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
+                  Error **errp);
+void pcie_acs_reset(PCIDevice *dev, uint16_t val);
 void pcie_ari_init(PCIDevice *dev, uint16_t offset);
 void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
 void pcie_ats_init(PCIDevice *dev, uint16_t offset, bool aligned);
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index b28af067a6..2ad9a563d9 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -36,6 +36,7 @@ struct PCIEPort {
 
     /* pci express switch port */
     uint8_t     port;
+    uint16_t    acs_ctrl;
 };
 
 void pcie_port_init_reg(PCIDevice *d);
-- 
2.34.1


