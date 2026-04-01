Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC9F10F92EC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 01:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7jzF-0007yI-5C; Tue, 31 Mar 2026 21:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jyz-0007kf-L7; Tue, 31 Mar 2026 21:02:58 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jyx-0007bB-Pb; Tue, 31 Mar 2026 21:02:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaxJ5H8eDxWeFvid8+UKhbgpnnCmMOUERDLcxX/7H5dveghzB8qFhy4DAkzbEaIXAKnRaT7iEE29sdK7w6S0cdklyKRfOqIaYNBMnJJDJUsBbsahcRrRz5aJLYMpYOcK6Z/m2hFeridGH074bDPaJWmpTqK0KsYEeoeQg+t+cJ4iSp4crfCftDXES27fsUtxTqCQjuOum0VQ+5YIIntn5DwCH8E9mhdGsQbGXHUOib7MqiFDnIxqefQ53O1Gf4k9B/O+URpsa3s5ejaz7jbBM7h4TQ1RmWlCIdUw3EhkDjZr+HpRiMe253SH3G0T5sqVZXNPxo/tirbvXyr7I41slg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuQI7z3NsOxpkKRptWijvCAUccDmjyqmCCM/xxp03qw=;
 b=vr+UY+Dqe69k4iWsnH6Jji4zJ7ywQG2N4HlrJIN9f0GjdXkA05+iyYv9aFyWLENsicDiJ3VxydoN3vJebDb+VYdyMPs7e3M9EAuyQnL9G07evI8kMwEtO4RapCwZH1T5H9LGPKH64Y2xt3p2f2ypfxcOtM8JVm8kYZI0azradgSXYQh6OIl0PTSzrF20dhjcCMYGMDmDqhEH+Jeu1rGudfX9xKUzlIl2xyd79y57124C0AJNJ4aW/tJORkc6kx1tYXMVjUTj3ifAMNKqpU6kBGBgPJb+IgJWUCELYkk0Igt+qr91cNQmKuUKKRFHxyVPAODLicG5GRhKgFV/fqB4cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuQI7z3NsOxpkKRptWijvCAUccDmjyqmCCM/xxp03qw=;
 b=gLSJE1i5YkP9jspoHXG37WYZUHLW38UPqijMU+ochKPdWilMATwpnrwDxd0tvGx+gwFdk5WmCWlwEvxAJ650/fWvePHedYhhyp0mqL2Zo06XlImxLdljqwIfogZ1kqBdGdmH4nvSIzietD30XuC1k2hq7DE6gl6IpdAr51iFRHn5rSCYxvFRGpmWELG76wb/6oom9T52AlFsHAwJrIrEVLD7ImQPmKSNx0qbgqZNK6b6R6hROJz5/tWtzeQJoZWVDMh34vJjYxuWA2nA7NcY/LMXTsRRkN6nX/ztW4sfZ/8siO/Bvsz7CNPDIdeLhso5D10yxBS0JuccORu72rJC/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 01:02:42 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 01:02:42 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH 04/11] vfio/pci: Add ats property and mask ATS cap when not
 exposed
Date: Tue, 31 Mar 2026 18:02:24 -0700
Message-ID: <20260401010231.4166776-5-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401010231.4166776-1-nathanc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a03:505::12) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: 33273364-cc49-4ab6-dbb1-08de8f8a6088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: qJrCcfEh1/m4d9FJjzZ9RkzYH9e85IWOKwL8DyQ/ZJX2lHAtMl+8Q7p7dr6pTpvhLqJfYeRhWNoL/xnVoFhndNj1UeBzFSmBuLluRGsbkjnEsMkHFdNc1ydAY00l4Lzq3jC54O3J1gmiPq3gFad685jAe40K2FO/5O6coKBKK1hPejl33SHkPsDqwn6BE8WiBVzaUgxyhrGsI1wHjCSKG6EALbDfcm1CuH3JpNCgQtr4IQvdNB4dRTCbIutz7BeYe4N6nk04qJvlmxRQ/5U6j7wJ7ToS96kG4EEhV3yrYXjeZP7WqNcx/6k/HRg4h8ngMbYWi9WFRNUuH/xf0cjNOmUCQFWh6g80Hk4Ef5jcEwtUPBTnSdnGL/hr3y97bAZBimM93HxmqHqqQypMA1w27r03dUSbw3Yt4WXHXcejPOJyWITUAk1FgU+vdPSsjtEzpghPANTVIGhBrNm9OqB90P5hYdE71sPA8Hk7y1EMvOwyS2uPO8viSi8H7GqEAreDk9dsgBSAP0M2BKRG3sn2RwKmj+gA6vuGuJ7yq/qFfKV3DAAAEgRejac174Z45Zq0Bdky4uGlvt1YHVUvk4z1skmaoYlzt2ztzt5nBqctvNTD9bk0hNgLvPJhixS42s1svTmJzZ9lXTbdOgrbMrHIhvwla0dYLxcefCQtL+qlTya43RU+JOhhs75ZsKaTN2o6GpTkbIR396HPoTrhr5i0iYhK3X1zfx92BpxvtcuLcSQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZgtpDxzfX7KojBxTfKsXVi10gqR9CElXCb73dq/nLSJ7Pe1oYEdZppCYXDGX?=
 =?us-ascii?Q?VDSYAMq5mHFGsTCxKzdKizFN/Dm5qSGNb7G8lSZemlUNzYdRpvCxsQttWeLt?=
 =?us-ascii?Q?T3qrH6XBkfkYB+5qP6WB0jGMB5rQaZw40HxIRe/ZuAHRSho1w8arUgl6ga1K?=
 =?us-ascii?Q?l1PLthZBCiBS+l8E0sKAyVZCNrTywUSky1mEnyxx7UvNfdO9MRGL7vRKRtr4?=
 =?us-ascii?Q?MgMU1pSghd592FTMgSRlHY5M11Vm68R0tfRef1iK6ZwWGtWrW7qNCXWEqRbh?=
 =?us-ascii?Q?RXBePpzofGhAS7Mge9RY0EXjIif5yiurFg9sxMMorGF57U/MN0N4krQ14Dp4?=
 =?us-ascii?Q?RE3a9FdGmahi/aLM1iFq/sA2bGjitYa1R6UGtfNW1CHsuwu9PEvfeR90dqIa?=
 =?us-ascii?Q?pjbsj/x/zDa4FCKHDx8vxpQt79tdyxzn1Dyl/GYjxmV1CFBsFXYl2rmEG9Wq?=
 =?us-ascii?Q?f08aqVjLQjGioa6OccGESTBVGB1rYdpVLn2pMy+EG/cc+fGfY2UlSppIMaeL?=
 =?us-ascii?Q?E79wjUjQPDleq6jZy5hEsy20IINYX4TS+xl8lYhUYsiV7UQOhOrSm7GAXDHD?=
 =?us-ascii?Q?5GYOLeMtcuMrntafJBLMCaNQKoAmT0jlT4DwmoBPZgC0pPa6UgqgutbdPelD?=
 =?us-ascii?Q?g163dh4WtLNHISCy9mbSPEZkGEpm1yYq3f5RybSpbJ2Ci9kUduFO169NbZox?=
 =?us-ascii?Q?FrtyP6Vv7Lc4tIF7r9B8PVHxRdkAgo9PLsrbjIelScnAr3plXrV1ejLekK22?=
 =?us-ascii?Q?f0K00xd/YeIn4b1xA4icHHwEtNL7kUCPehR8WIYLUk8WNEHwy/gHcAY+SqtF?=
 =?us-ascii?Q?BVeZcUrPNqAxU758xItYmWrlPlXN0bknzrjgLJ2ufq4ABF2p01p0xuH9evd7?=
 =?us-ascii?Q?3I4p99rk22jpS9c531jRfhKALFaA2Bdy80Wz1uRDHL3JfV+UFl5LKIVfatab?=
 =?us-ascii?Q?DnKK3RoUjvYXcPx+OKXHXjBuaf2I0RTMXdatYsYTKlztlhVfd6uZBeuKGEoQ?=
 =?us-ascii?Q?HZYFgyLs7VCx+19M4lisP9U8tBvOsq+dCDNBsYzIBdfEDcjfsoh06+7XW0XV?=
 =?us-ascii?Q?faW29vxEUlYe00kmt141kqIuJwpdnxhTgOXTJhvIUiIbmxX5P0WpyephSw0a?=
 =?us-ascii?Q?dCYwR+bP9eJWmwOg53E6c2L2JuXqXcP2lIbpsaZkOjllLlty9rPUpEqpAD5B?=
 =?us-ascii?Q?nR2hEHPJWvfTx7EkNfHXtAn99P6lOibnBxa/pYzhFHJMC4acdlhfT2zmaSej?=
 =?us-ascii?Q?v7oipxySobtmYJJ0k0LdHIAmOogTOCqnTNJBDuxH4SK2MAyIlzQ9Q67cfpOG?=
 =?us-ascii?Q?fRn51TiBBrB4f77mC7LUTV//G3WX9aB05Wd7jo+RIg9BP2p0kjPOM9CBipWf?=
 =?us-ascii?Q?oHlypVSp6KCBH34ZJsq1fEOphqD3bSsvcgtxislHpfRjc1LUBZn3h76cCdRS?=
 =?us-ascii?Q?xaFEUmut7e4R82tV38151jmHO7QJnIQ9z4h1ienGu55FT3p3gb2HKEQbrx5n?=
 =?us-ascii?Q?BRma+DoSUod+np5k9/cX+JrmT6+GxCwnz0ddC7NW7x1SEY5tGCgVNyg46+fT?=
 =?us-ascii?Q?qsmz57p5O1GpIiOWIrwfApt0DxjOvTXxwqPGnKRou7+sjr3t9Z9zXSaOUFnL?=
 =?us-ascii?Q?Zt8UFThFuMcXWRi110je1kM8BzSZmya1XL6cBirkIVR4vm/p4WCJhklGOJdM?=
 =?us-ascii?Q?1VrHwbuOZ3zw2wVwPO2DS/h5a7sfHyEERWcPfiYvOHZDpyGu+e1ARzPD7Rea?=
 =?us-ascii?Q?eMBMwcVjrg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33273364-cc49-4ab6-dbb1-08de8f8a6088
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 01:02:42.2729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLVNXhZTidk37onXVSNT04w55DZQZFsKll8bsAcn4f5nGk3BWjgueTtuNr0+xEIkNLf+u5KZAOlx6PVpLTtvFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=nathanc@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

From: Nathan Chen <nathanc@nvidia.com>

Add an "ats" OnOffAuto property to vfio-pci. When the device has an ATS
extended capability in config space but we should not expose it (ats=off,
or ats=auto and kernel reports IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED), mask
the capability so the guest does not see it.

This aligns with the kernel's per-device effective ATS reporting and
allows omitting ATS capability when the vIOMMU has ats=off.

Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 backends/iommufd.c                 | 15 +++++++
 hw/vfio/pci.c                      | 63 ++++++++++++++++++++++++++++++
 hw/vfio/pci.h                      |  1 +
 include/system/host_iommu_device.h | 10 +++++
 4 files changed, 89 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index e1fee16acf..52cb060454 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -22,6 +22,13 @@
 #include "hw/vfio/vfio-device.h"
 #include <sys/ioctl.h>
 #include <linux/iommufd.h>
+/*
+ * Until kernel UAPI is synced via scripts;
+ * matches include/uapi/linux/iommufd.h
+ */
+#ifndef IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
+#define IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED (1 << 3)
+#endif
 
 static const char *iommufd_fd_name(IOMMUFDBackend *be)
 {
@@ -573,6 +580,13 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
     }
 }
 
+static bool hiod_iommufd_support_ats(HostIOMMUDevice *hiod)
+{
+    HostIOMMUDeviceCaps *caps = &hiod->caps;
+
+    return !(caps->hw_caps & IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED);
+}
+
 static bool hiod_iommufd_get_pasid_info(HostIOMMUDevice *hiod,
                                         PasidInfo *pasid_info)
 {
@@ -595,6 +609,7 @@ static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
 
     hioc->get_cap = hiod_iommufd_get_cap;
     hioc->get_pasid_info = hiod_iommufd_get_pasid_info;
+    hioc->support_ats = hiod_iommufd_support_ats;
 };
 
 static const TypeInfo types[] = {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1945751ffd..2d408e1d9a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -49,6 +49,10 @@
 #include "system/iommufd.h"
 #include "vfio-migration-internal.h"
 #include "vfio-helpers.h"
+#ifdef CONFIG_IOMMUFD
+#include "system/host_iommu_device.h"
+#include "linux/iommufd.h"
+#endif
 
 /* Protected by BQL */
 static KVMRouteChange vfio_route_change;
@@ -2550,10 +2554,53 @@ static bool vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
+/*
+ * Determine whether ATS capability should be advertised for @vdev, based on
+ * whether it was enabled on the command line and whether it is supported
+ * according to the kernel's IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED bit.
+ *
+ * Store whether ATS capability should be advertised in @ats_need.
+ *
+ * Return false if kernel enables IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
+ * and ATS is effectively unsupported.
+ */
+static bool vfio_pci_ats_requested_and_supported(VFIOPCIDevice *vdev,
+                                                 bool *ats_need, Error **errp)
+{
+    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
+    HostIOMMUDeviceClass *hiodc;
+    bool ats_supported;
+
+    if (vdev->ats == ON_OFF_AUTO_OFF) {
+        *ats_need = false;
+        return true;
+    }
+
+    *ats_need = true;
+    if (!hiod) {
+        return true;
+    }
+    hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
+    if (!hiodc || !hiodc->support_ats) {
+        return true;
+    }
+
+    ats_supported = hiodc->support_ats(hiod);
+    if (vdev->ats == ON_OFF_AUTO_ON && !ats_supported) {
+        error_setg(errp, "vfio: ATS requested but not supported by kernel");
+        *ats_need = false;
+        return false;
+    }
+
+    *ats_need = ats_supported;
+    return true;
+}
+
 static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
     bool pasid_cap_added = false;
+    bool ats_needed = false;
     Error *err = NULL;
     uint32_t header;
     uint16_t cap_id, next, size;
@@ -2603,6 +2650,11 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
     pci_set_long(pdev->wmask + PCI_CONFIG_SPACE_SIZE, 0);
     pci_set_long(vdev->emulated_config_bits + PCI_CONFIG_SPACE_SIZE, ~0);
 
+    if (!vfio_pci_ats_requested_and_supported(vdev, &ats_needed, &err)) {
+        error_report_err(err);
+       err = NULL;
+    }
+
     for (next = PCI_CONFIG_SPACE_SIZE; next;
          next = PCI_EXT_CAP_NEXT(pci_get_long(config + next))) {
         header = pci_get_long(config + next);
@@ -2640,6 +2692,16 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
         case PCI_EXT_CAP_ID_PASID:
             pasid_cap_added = true;
             /* fallthrough */
+        case PCI_EXT_CAP_ID_ATS:
+            /*
+             * If ATS is requested and supported according to the kernel, add
+             * the ATS capability. If not supported according to the kernel or
+             * disabled on the qemu command line, omit the ATS cap.
+             */
+            if (ats_needed) {
+                pcie_add_capability(pdev, cap_id, cap_ver, next, size);
+            }
+            break;
         default:
             pcie_add_capability(pdev, cap_id, cap_ver, next, size);
         }
@@ -3819,6 +3881,7 @@ static const Property vfio_pci_properties[] = {
 #ifdef CONFIG_IOMMUFD
     DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
+    DEFINE_PROP_ON_OFF_AUTO("ats", VFIOPCIDevice, ats, ON_OFF_AUTO_AUTO),
 #endif
     DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
     DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index d6495d7f29..514a9197ce 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -191,6 +191,7 @@ struct VFIOPCIDevice {
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
     VFIOPCICPR cpr;
+    OnOffAuto ats;
 };
 
 /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index f000301583..44c56e87bb 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -133,6 +133,16 @@ struct HostIOMMUDeviceClass {
      * Returns: true on success, false on failure.
      */
     bool (*get_pasid_info)(HostIOMMUDevice *hiod, PasidInfo *pasid_info);
+    /**
+     *  @support_ats: Return whether ATS is supported for the device
+     *  associated with @hiod host IOMMU device, checking if the
+     *  IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED capability bit is set.
+     *
+     *  @hiod: handle to the host IOMMU device
+     *
+     *  Returns: true on success, false on failure
+     */
+    bool (*support_ats)(HostIOMMUDevice *hiod);
 };
 
 /*
-- 
2.43.0


