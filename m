Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18DDC2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 03:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMJ0w-0008CJ-3S; Tue, 25 Jun 2024 23:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMJ0u-0008Ba-Aa
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 23:08:04 -0400
Received: from mail-dm6nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2417::600]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMJ0s-0006HF-Bq
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 23:08:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQpUWcYsTqYUMnXMxg7nDwYgnGCBub8wUrq6C+tdHPldTDAIaOfyNepsgmyiH0sy62X5QeW502Dn5wt2j5tqlKas72ILykKkFEIG6FBO8Wlet3YkbavSB57T05D+VbKoizsiiojQMFIoJ30PC/HAsBW9eYCzIkUQnKJp6LN5RXvQEMqB/jHW6ZSbV4L+Aj5lr3P4x7m2ESYQUOf3+BbHjS/XqZtruxSt4VPI0YAjQM035aHbRqROasOp042N+dYVEALf6UrwaHBmekk6VJNdG7GwnFKtfbSHtZ6hV7KNKnOeSnmtPkVRi3WeH4gIYV680qIu4yL+mVelv8gTr9lOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Va3s+7gnprUj+TGnEupq8zdY2m42H+UaaRV6cxAQFw=;
 b=NhWct2g5FUhdFrojE0ide86VsWZHS6sohVeb1u47njU0XmQKb9VyhH7dv4TJK05J7gvp2SLasVu5OoCppl7I099ama+XWBqTdw2JmKCeIo9rv9H5V4Va7V3RokCdabzSQH8/8KezIcqv04Y0pKY/JEDMCApXWcIhhaDTLkQcFWalI6fpkqrn+tiV1Eoa06uLm0vV0caxzXB0h+ntHCCbyR3NoK7m6mSVTWMsALUDx6TjtdQfdLTDYoArewAf/Gl6+rMfZQx3f17cYW/+7/NwOzPXytdAvg/tjcsFTL356KUauLPFjIU6xYGmN5O5nmJ8iFWC3JuDG0o83ZLGvr5tXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Va3s+7gnprUj+TGnEupq8zdY2m42H+UaaRV6cxAQFw=;
 b=VO7rBSo2idipVwimQOPFO4KwcGshAHk/PmRxO6JFqV2jlUeM5yTL/eOSaGgc6dtYuPsrh8kQSoY44WOz0ONB8XtEjUBQsvNThFHkC6PXONLPru9Ts0S7TuukPIwVa9BIt+I/bdtGntZODXJtQNia/j9QEbHw6O3BgPpCfrxigwPkwch8S5y2SnefmM1b9yaW/3tJu+as0lQzfmM3/G6TAkQfo7g1Z2+P+/Zk0QBG5XtOD36ffIZOpX0jBKSuIEN8jBkTqwjSjGhS9caqNveiBshzNV2yzpj11Yl33v3I8qREjMDNd63pJUNYrClfBwg9vmj3xr62g+pFBlqcC4MuUw==
Received: from CH2PR15CA0020.namprd15.prod.outlook.com (2603:10b6:610:51::30)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 00:29:36 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::17) by CH2PR15CA0020.outlook.office365.com
 (2603:10b6:610:51::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 00:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 00:29:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 17:29:27 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 17:29:26 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 17:29:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <mst@redhat.com>, 
 <imammedo@redhat.com>, <anisinha@redhat.com>, <eric.auger@redhat.com>,
 <peterx@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <jasowang@redhat.com>
Subject: [PATCH RFCv1 03/10] hw/arm/virt: Get the number of host-level SMMUv3
 instances
Date: Tue, 25 Jun 2024 17:28:30 -0700
Message-ID: <886883c4cb43117ef26e6c9434247b75cd827f31.1719361174.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719361174.git.nicolinc@nvidia.com>
References: <cover.1719361174.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: e4176d2e-2eb2-4127-b7e4-08dc95770f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230038|36860700011|376012|7416012|1800799022|82310400024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MYczyI3t1jNqYZr48bHtUKt6okTBpV69GpnZLQVqL0p44rkz7xG7Xek+NTTI?=
 =?us-ascii?Q?w1QeojpBUIxDQRIZ45bcjbIljOjWHBbYi6XdnASz4jP+dn024/rscYrcsgda?=
 =?us-ascii?Q?oRzNESgxtjBR0sFy5k5kRgLG6sAAZ9DH8Gb62453iI1NLve0QP6VyoQDkZhM?=
 =?us-ascii?Q?I2/GLQZ00Hp0zxsVFuYiaiLZ4HBJIEMF8EcDuo5kmPWwLTOYeq+yDQsFSREz?=
 =?us-ascii?Q?dWa+dG3UlPTbJOtOFbNV8rcGmu8KihQFJMj7gwj18UlAzSPQtS02E+51zmwB?=
 =?us-ascii?Q?AtcPv/mTO1NIkZdgihXcjnBjP4AESaFnK04VvUtzG4X/WZ2zDq471WZVH28N?=
 =?us-ascii?Q?fSJklopd/ig9PrGcKcR4b/EUeJyHdsHlfbz/12MHQLcjlsD8FMOvyi/jS8t9?=
 =?us-ascii?Q?QZzhGRw9kD2EQqzPOt2vP59X8qkhc9ZoGLtBZwEvzHnpsr4JzXuvRRkiOHNT?=
 =?us-ascii?Q?U+siJndeEhdRNG4TpwmC0Ydqrpo4EOyGpmqFIK/7h63kRvIvf2+odO05ip3q?=
 =?us-ascii?Q?qZzHlUTnA4H4FBU2LgKR5Hbqt7pspuVqC4K60MiRa1JCS+ghR2hKP03O/UqI?=
 =?us-ascii?Q?Ae6TOdRAuSUT1T1GsfC3CCYWu94YImmOzdTvN/oYE9EJe5BHmAUkG3stPYOu?=
 =?us-ascii?Q?5iwEItZnNVmLsyvpU2ZXxCc5oi53DOoAqjAqvC65qOnDc+UejtQFQrWCXNLK?=
 =?us-ascii?Q?uWEjPZdxn0WW3th6J0kMc4oFgFi+sZ7W/kKK8DOQI/94KtUogfIIHA08wJU4?=
 =?us-ascii?Q?IvWOMGZkM0TnDLT7QwZBuhxsSspvzxloXOAwYQLqSPtrVuw0BHYItBBAFT0K?=
 =?us-ascii?Q?5v2Cw2vppJEpb648PA124QVrEv399VbYErwzNzqdQ4iAeq8L6w0ZZeb9u2DA?=
 =?us-ascii?Q?ikLFZiO9tcdHQdfjhc/4n2d1mDgw0CL60cnKGeuQEo5b8RIgDNhk+pjoSnUx?=
 =?us-ascii?Q?LTdfUowCH1cubAFMtiOcGwarrqP2XMLWbhDGieYmTtEk84IjfECh4MjQ/vao?=
 =?us-ascii?Q?avJvhm6jlmDm4TgxN8aRwk+LRii5xqDnAU5skYZKqjAuYkGiE4ITl2iuH/QE?=
 =?us-ascii?Q?mYjsYrP8MOK21IZxS8yYAwZCO1WnmjK7oyCg5G+c7KsIU1U8o8nu8nwKY/84?=
 =?us-ascii?Q?F3A8cfYwx4zWso+8QeM+AoH4fuV1rNMuHVuyGvG3+EmTZD8H8ddsCgFrTkF7?=
 =?us-ascii?Q?j72iBO/DA6BI/lTQa/ETsvhZG6+uI8TO8gYwnElmGbICnKcmObliIj8ttNdF?=
 =?us-ascii?Q?/HJqHLX2JtZjzTVZiGqoxTn9NmVg0eVq3BqrvEvpfgrSx8Y9H1aUfiJnpx2c?=
 =?us-ascii?Q?Z7pOI97yItsXuMahIQyA1rhQJn+BUrqLXnHGn21CHWCVihpWoA2EhbQXGBs2?=
 =?us-ascii?Q?n+nA4/jhrISc9/+CXUoiaw0uKon/+gD443Q8Zd0NWMnAL5El+CLyGa2djmH0?=
 =?us-ascii?Q?eXq8SJygDNFaAkq124fFyLmMlgzkHXZ2?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 00:29:36.5654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4176d2e-2eb2-4127-b7e4-08dc95770f20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185
Received-SPF: softfail client-ip=2a01:111:f403:2417::600;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

Nested SMMUv3 feature requires the support/presence of host-level SMMUv3
instance(s). Add a helper to read the sysfs for the number of instances.
Log them in a vms list using a new struct VirtNestedSmmu.

This will be used by a following patch to assign a passthrough device to
corresponding nested SMMUv3 instance.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 hw/arm/virt.c         | 35 +++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h |  8 ++++++++
 2 files changed, 43 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 71093d7c60..be3d8b0ce6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2668,6 +2668,37 @@ static char *virt_get_iommu(Object *obj, Error **errp)
     }
 }
 
+static int virt_get_num_nested_smmus(VirtMachineState *vms, Error **errp)
+{
+    VirtNestedSmmu *nested_smmu;
+    struct dirent *dent;
+    DIR *dir = NULL;
+    int num = 0;
+
+    dir = opendir("/sys/class/iommu");
+    if (!dir) {
+        error_setg_errno(errp, errno, "couldn't open /sys/class/iommu");
+        return 0;
+    }
+
+    while ((dent = readdir(dir))) {
+        if (!strncmp(dent->d_name, "smmu3.0x", 7)) {
+            nested_smmu = g_new0(VirtNestedSmmu, 1);
+            nested_smmu->index = num;
+            nested_smmu->smmu_node = g_strdup(dent->d_name);
+            QLIST_INSERT_HEAD(&vms->nested_smmu_list, nested_smmu, next);
+            num++;
+        }
+    }
+
+    if (num == 0) {
+        error_setg_errno(errp, errno,
+                         "couldn't find any SMMUv3 HW to setup nesting");
+    }
+
+    return num;
+}
+
 static void virt_set_iommu(Object *obj, const char *value, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -2676,6 +2707,7 @@ static void virt_set_iommu(Object *obj, const char *value, Error **errp)
         vms->iommu = VIRT_IOMMU_SMMUV3;
     } else if (!strcmp(value, "nested-smmuv3")) {
         vms->iommu = VIRT_IOMMU_NESTED_SMMUV3;
+        vms->num_nested_smmus = virt_get_num_nested_smmus(vms, errp);
     } else if (!strcmp(value, "none")) {
         vms->iommu = VIRT_IOMMU_NONE;
     } else {
@@ -3232,6 +3264,9 @@ static void virt_instance_init(Object *obj)
     /* The default root bus is attached to iommu by default */
     vms->default_bus_bypass_iommu = false;
 
+    /* Default disallows nested SMMU instantiation */
+    vms->num_nested_smmus = 0;
+
     /* Default disallows RAS instantiation */
     vms->ras = false;
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index d5cbce1a30..e0c07527c4 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -135,6 +135,12 @@ struct VirtMachineClass {
     bool no_ns_el2_virt_timer_irq;
 };
 
+typedef struct VirtNestedSmmu {
+    int index;
+    char *smmu_node;
+    QLIST_ENTRY(VirtNestedSmmu) next;
+} VirtNestedSmmu;
+
 struct VirtMachineState {
     MachineState parent;
     Notifier machine_done;
@@ -153,6 +159,7 @@ struct VirtMachineState {
     bool ras;
     bool mte;
     bool dtb_randomness;
+    int num_nested_smmus;
     OnOffAuto acpi;
     VirtGICType gic_version;
     IOMMUFDBackend *iommufd;
@@ -178,6 +185,7 @@ struct VirtMachineState {
     char *oem_id;
     char *oem_table_id;
     bool ns_el2_virt_timer_irq;
+    QLIST_HEAD(, VirtNestedSmmu) nested_smmu_list;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
-- 
2.43.0


