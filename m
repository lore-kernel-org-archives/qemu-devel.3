Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B331FCA17B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 19:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzgC7-0005Ex-5K; Mon, 09 Mar 2026 15:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1vzgBY-0004yz-Bm; Mon, 09 Mar 2026 15:22:38 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1vzgBV-0003e9-97; Mon, 09 Mar 2026 15:22:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmek/Y6Csg04CT6S1pyOXADI2E1EN0gAHG24MrlWYyEO0Z32KJGjJ96GzpBNxcCalmNFLFo0YVwRDn1C88n8P39Uzvh+Fdpk9zQDHtScl0rFEjalsBja6HVKsYYRjPp9QF0onP0ahfhPgF8+HyAuc7wFg4X/v6tG/sWoN2h2I+sn/0p1RZEP8F2nmA2FMnKU1XNMTArYqJAP1bFo/iW7IxAWLc9no0nB2gek0RqhMphw0I8ORDWxmgwFT8RdyzRaqWw3JHaawfTUL2QwYmwEaDxNm10nd0Omri2yL7ewy3Y3F8+fgGWMstVf25r1GWw1mnhAIj095E0IhNpRr5pXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoOg7kN8Lt7eNK4pDZYGeIbKP9uSFQ8GNqUtq/BJNGw=;
 b=AgIKJ5sMIgmZA1fM3/zJ28H5JGKXeonDotxwLZD6qbwn9sOVamI1uz6iVxPCR/6omWQUoCVTyadIX7phcVy6vyKMUd6IjOgXWXibI5ONPaK3wTP0NP5hhfS17xACprsrdkrxDH4N+L4UrDFxjduN8zrH+Wf7kO/Rl6ACWWQQCXmoYzgN/3EOh2PrJMuXW9DGLMTBkUGSjvWOqRTXu0E4uSVweN9izzf9mwvdqxmG9d1tgRagj4ZXABtq9bqDiWRWdbe6EByLajUTQ/PcwAsYLF5vS21693uaqCwCRswWDfEidIa30Ns1NGVGmUFpMNavFmXa2DLUCZkCOek9mc2aOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoOg7kN8Lt7eNK4pDZYGeIbKP9uSFQ8GNqUtq/BJNGw=;
 b=bl3OvHel633FkQek3d2cYNhFixY/BMwEqYDGMbReqZooNt/P87ufLN/YDinXKskUvVUYgYhnIX6I9bT1FMLurdYMiEi9ris8nUh+63UGbwPEn+mvT/KKJCyOq/N3m7Ti2CZBq2ksHGOEMN6+f3qBbEgL6k8uGcrJc1ulNx9WsATaKAi2JK1kVdOtuYmPUsAUHD7eqxDw4PW7N7MPi5tR2Zb/0D1HXif1MRAc5o12h8GkCbm6yosJ5Dq/0iE3deRahnhhWVDE+U10WNRWkObgpnMLguqo9+CnfKwseJ5g/Ul68Fo0biLKYyrOIpcQe/EQCTuXKh6v3SFad17AYCrALA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Mon, 9 Mar
 2026 19:22:23 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 19:22:23 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Nathan Chen <nathanc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
Subject: [RFC PATCH 3/8] vfio/pci: Add ats property and mask ATS cap when not
 exposed
Date: Mon,  9 Mar 2026 12:21:14 -0700
Message-ID: <20260309192119.870186-4-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309192119.870186-1-nathanc@nvidia.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0108.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::49) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 776dc2af-f7cb-4619-7948-08de7e1130c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: oF7vPge2p5gwOpMEHcmtMGiOCjV1tjHb3KnSUUk7Ea0VnBS+LUKxwcYVw9wunecg4CPfDSfbc6OzEQbRtPas6b5Gi/7U2svE3Tj0BYdEHt873dBk4ddJ0I8BKGPuTV9ljy1UpFzCpNI6nvHAPZTsQeUVklGOjoFPuVWJl4sl/XXfrls3/vpMyJ7tm6FKV2/a6zMUCs4MnnPQ4Q+pKxaq05qX5aMNa5JS9rZw2I6lXsWp1UddhYZviuOqGNVcZNbbrqdc6WFSQZ2z71LSLWndtR983xm9eCt+iZVQOxN19mrRkHZPaK/R2C657woF8cDYDPabsHD9Cvowpw9LCXdLZsQWoY87LbLhxoeHdcrv1SQdSrkP85lJcApPYEdRgXN4Ga6Ykt962yN0b9wfa8TRIF2kxOnTauwJE9wy/bBjNPacEdSmHgCK/aUeRNHmfZsrh8Y2/Hs4AyMRyQ75DdEhuSqrHSjqQNIrwORnxPBmhCzm6AvZXzBbWYx4YHyVxafsqSYB31iWHN3oLiyvWGsgO/7NNkr0qt/ZPzDfl1l46MD+8EHJkaelf4xlLMkvP75Bp0igUBfcH175PgKKKtf6cUEEMeuTdH1lgfubfmWQJoh4sJB2yC7DKtwTTixEQSwEiuENZefUVM1sKFPbOnZxPRzTocAq9/SXOwTuqCzNeeRr3HGHZzyKTcjsN8o0smae8BJ1IBtIfw5ccwoph2suieP65BJGpMKgXL27cqD7JPE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GqjnQ2ocpEdGWeLxwI0JJvBA86wfHw3rNdwhZiRNZoUWLhQ0AhY9do8BQJg1?=
 =?us-ascii?Q?uGXs7An7TDXkt9EBl+Oj8KEPbx9XJ/C7Em6KY8EsQJY2gIX+0h/oqHrXrcuW?=
 =?us-ascii?Q?hLHtPu+BXPPLvIiarSjGBpjzPhSt1nH5uxXn9ANeSdx2VVKYraTHo9WrZZa9?=
 =?us-ascii?Q?6SaAYul++hZRDyy60qAABJXt4u1Kr0ev/pPSOF8MU/dd2u3Hi7K4Uk9KyrRQ?=
 =?us-ascii?Q?ZM4ULRzPWJLJ8pb2cyae17hUZ/Tz72RGkw24g1UD/BVpoZWaqQxUvdDPXUUc?=
 =?us-ascii?Q?L3M+8C2YbRvaKferoja9o3iWp3uLlEq9rXPAZZPt9oEryZTHbuz9oD8QKMkw?=
 =?us-ascii?Q?Ab9xLCU4BioNKuh1G1Mm9Im+n+Szu5iHK9d6i+DcCfwJZYM9JFCWOPmFUv+3?=
 =?us-ascii?Q?fdv6CbWwt9YGUFoAP6LUIBqL5h5FzzXQKhCk4E/vM5kbFZc/U0zylx2HAjCO?=
 =?us-ascii?Q?bJGZn7FI0945RJLk9RJb/VIGQE8IC31WDDHnkv9NctIE7eve3sqXMK7+mC/m?=
 =?us-ascii?Q?Yco0vUNGtC3nCr9+ReDj8Wt2ADHWWJYivJ2BxrH77dGkiU4KDtP1w2bENcSR?=
 =?us-ascii?Q?+MFZoaZry3Q/ZMn7VFPK2Foxj135IMhxMbAZIoVnSe6REff015Hi9Jpww3bL?=
 =?us-ascii?Q?kldVF9nE0TL6wFUysuiX8kkgvyNiqgYwb8NrqIPhWis/koSl+s+VsmM21mYk?=
 =?us-ascii?Q?SvHZUz97PpFD3BWd/3tKXojQk7emUriSqmQ0IvbYg8AAbl77Jyc6J/O8kWG/?=
 =?us-ascii?Q?K1uxIZngHedfwZJ7I5CKuNHA8YoUp21dB/PSW4GWgwXLrcgekA/jq9682TDT?=
 =?us-ascii?Q?qZyTYE13H0Hb5c/sx8VUN9ZgHZbBaE7no/adatCvnE79gl06us7+rhJPf3lw?=
 =?us-ascii?Q?iMO3yu+lH7EmROXbZBM1hnxDCVSE3ry0wB5AmEBTtrsoksodLPiw5YguFITm?=
 =?us-ascii?Q?5SPjhtwYt3r9C/yoCrUZyr9HdElFsWY1Hg9hvktc0IX8S8JjV1i6MRSSx330?=
 =?us-ascii?Q?ENsjTvd8KVoUxazX+NaWAbwSb6RgAeNo4y0yRorbm/GTQwVyPmTdidkb9RO1?=
 =?us-ascii?Q?pXzn6Hmsw1niwpDipvhM5ABN1PCFh9RHnoP60pEcZPzKx6vAjKIAXxiwwteX?=
 =?us-ascii?Q?yIL5/jwkBpMu6oDYqq4JmFxx4CkzxmwYjN8HHZIBxPRz2pUa42Iq4wF+qRBE?=
 =?us-ascii?Q?k/zIx+nES9LrOD+p+wyj85o5e/UWZfA9JAN9eAxPdak6MkF3FbNyabz0u+wF?=
 =?us-ascii?Q?djzKnv2aXCrNFqfnYXNYuVJO9NxAQDxeO6AcFfEBHsk/JYMOgnr3I9KZTLnw?=
 =?us-ascii?Q?3bZ7/2fqe1hI45Sp9jtj/U7y/ICDel6KODWtinJKzh2xEuk0vgANfHRO29rZ?=
 =?us-ascii?Q?le/5SIhXTNu61AvjZ6mbXZbobfxV7ylAdyRyqi4afASMtiIar86qqyUg4h+A?=
 =?us-ascii?Q?pfjJ6kuEqf2shw/zQsyPiA+Gbpfida5ccfxu3aL7dfQhe2Sl5KqsFO8I1j3q?=
 =?us-ascii?Q?/ElvpV+KLiFpNxUjDO518A+BcENCFOJZxCX478Ssl8d/n9Q3RWMQdc1nk6WS?=
 =?us-ascii?Q?qtaMkEQlX5gd1D0mnC4L5ASLtXs2bIWVzt4Uo7j2jp5+B7YD8evkAajBDjUO?=
 =?us-ascii?Q?/N5nkr0Xb54fMaBHso10UBXV7nw2ILpnZVliaSEbWTxZNCXBzX6c0pCPw0e0?=
 =?us-ascii?Q?79So1+sj6W5ytK++TN8YHKyBNnT153lFyvVE0/FBfTT6cQPqF0GfBkJ15pJV?=
 =?us-ascii?Q?1KPYZx+LIQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776dc2af-f7cb-4619-7948-08de7e1130c8
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:22:23.2482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ioqb7F2OOyY3oyWoJoRoLFWPIgBXrsWX101QsrIxU4wfUAUwbrI5rfVzZjdJ17lLaf4Nn8ZmYy6pl/GB9K8MjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=nathanc@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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
index acfab907c0..d1e9d4dec3 100644
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
@@ -570,6 +577,13 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
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
@@ -592,6 +606,7 @@ static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
 
     hioc->get_cap = hiod_iommufd_get_cap;
     hioc->get_pasid_info = hiod_iommufd_get_pasid_info;
+    hioc->support_ats = hiod_iommufd_support_ats;
 };
 
 static const TypeInfo types[] = {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c89f3fbea3..62b7cc08e6 100644
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


