Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40C3CD98C7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 01:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXqwM-0002Ik-5i; Thu, 11 Jun 2026 21:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wXqwK-0002IG-2i
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 21:44:08 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wXqwI-0003ME-Do
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 21:44:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZ3QXwzD8snmg1Yv8WhKhKf44RSq4MFojVH6uGUsNrHoABAuqTzlgOfQRazqGv4I9M1Xf/l2CwVkpME+QisCJjw7w+L2RiCvWz4PeYy60j9ljDk0Xip8rKNFtBuQvJQ1qF51Xxhhz/DhmJTjjkwwRTeSncf5CfT/QSqaMnszkBPeqoVbNOU/LwovXlj5UbSTZr0jMh3NGUfhPUZHdLWM+0L/QqaTjR0nDIe1lWGN2aYTN6t/QAr7h99gXjM7Q2u06r+q+wLX3KWRfqYwnrFDWae3albL1zrrw3nG40L9kyP3XkIIszxxzH3Sq+tQg3UgdMNoG+eHXxst6qniDAOWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgVEYXhr/eWwsYwNvElyWReTpgth9Umyd4mArU27F34=;
 b=utOisqBwNM+S/FLjZYakz3QQM0IBw1DEBp+agzIoFl8u2tl2YRgREpV7hgV6n2O+MLGxsmEvU6KAZArHVeaY2h8poZkeYAVPsGMUThA4yhKUuI7Fgd8rmPka1qyImsG609SDP0LvidydfFeL8AdmFKec3SfXLu0+0tu5Fnee2GB+jLCnOTyA+i0EC4UNsSoD+E9jZ4I2LDX0Dj2C+EtnC1obrM9lTXH/+8HvqM226YAGsJsfjLGvc1r0Ewk9rnX/6tbm74aorKmYHoAWLj6U66uECH+FqvE08xslcHgJhGQZxhRkA0r57hKHhCuvqcyzCGzAL8cPNu6Z9EPfY+CrLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgVEYXhr/eWwsYwNvElyWReTpgth9Umyd4mArU27F34=;
 b=ZPXr1xVdx05QvdsFM3CjMqRjxXIeNBKaNHWrXt5C8A3fNnpyaThC/0QyFLEwsZiJZYqEHwayfE/67Vjiu0n56K0odkjcDCBI9JQFvoE540Nkd6HwgID9M1s+VOadVG2GUjHjvoaxtT0lD+9ImjAjn+cHptOsOmHI80kInNx3bgP2/PesHIBEqwP5EWNrxR+kGpMeomtANe1BaJ2YZfTSmwgpx+BPPe2fuva19ZxT5JE3C77r+v9Zfzro0etu8EvHDzV0JCf7OhNSAxz8X1xIbYB6w+UMz8TsFzJY6CGvUHDOUNUaOywf047pV526Er1gXaJ4sdQhkZCJoqEEYLjivw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5377.namprd12.prod.outlook.com (2603:10b6:208:31f::21)
 by DS4PR12MB9746.namprd12.prod.outlook.com (2603:10b6:8:2a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 01:43:31 +0000
Received: from BL1PR12MB5377.namprd12.prod.outlook.com
 ([fe80::6432:69b9:5b85:d190]) by BL1PR12MB5377.namprd12.prod.outlook.com
 ([fe80::6432:69b9:5b85:d190%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 01:43:31 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH 2/3] vfio/pci: Add ats property
Date: Thu, 11 Jun 2026 18:43:21 -0700
Message-ID: <20260612014322.2918836-3-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612014322.2918836-1-nathanc@nvidia.com>
References: <20260612014322.2918836-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::24) To BL1PR12MB5377.namprd12.prod.outlook.com
 (2603:10b6:208:31f::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5377:EE_|DS4PR12MB9746:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d9a4b8-bef0-416c-9548-08dec82401e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: x/3un4LLGoQNc0JyIajlqV055zN/1EPpCs0sMiHQu005BA9D9NOgajbTspXwqEdX5niLu1kjk/tsaeqU4Ta3SK7HWZPoMddvkMoByZ1no17nvCscmFny+bHDLaQQrF0obZK4wsDYYw2FxjFamhF9rDrBFu0N474LJ1hENhk6YMBtmGLGgMN9Qln4IBZNcUxC68Vl9rjPiemcv3OVJn38aJXjuj8svYETTRjPHuB2PZOdYEnBVmsaeXbGCTo2x/IFfop3G3xQDgpd1VvNzFwNbOlo6bs2ELMK0LtvY8DSpVD/e8Tlv2Qta4JqAUU2gWMm27GYwRd3GOc+MwNafsk81mVrlq7BamPEor7VuED35LQP/odtwxyrU0Ty3c05peWpRfNDSLPaXgM6Tc3uomWLVtYptTXc3oimPsdi36PDuH1u0/BlQJC84RbNN0JDiYNf+ORCd92ySCvas8hNgA/2zcEPAp/roByuljDYeT8OUcQHnPiTmRYw9xnnNVyw9DwEpRxNtoNx8nWzuVpEFTGzbH5y1FPfxX3QmA/qyhV32jl9i4YXVHPtKJvXdFcOJZR8ztcbtOJ8x/K7rXAxp7EDUpYevfFmTB66Q8ZCA4gBeyjuDxg1wlwc0qNG2duEwNUUiPfoNiHtUI6SDsT8asslDVGkOLRQxmwsAEAahtYyGf3HVIpXdFuv0YY1sQ9Nv2w/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5377.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bxEezABm5vMvBRWeN35aNnB8wgpQKwlq2v5EArVlUearvU3hsORUxOooYiY9?=
 =?us-ascii?Q?BmpA7wPlYVwvQJ+pyGex7NKln7K7Hl5z3rlGk/pOz+WWiIacedqkLF7c5lLL?=
 =?us-ascii?Q?K0XIdSYOdZxeIgLqgHIsWprUUoKbl6ZIXL/j+R0HM6PN87lQppA/+qgeH7jB?=
 =?us-ascii?Q?ZCLYy6cvXHoKhdjqz6Uwg3/J1s74tVC12uhtTYyJk1lhL9FY5VFjfqP7nZyp?=
 =?us-ascii?Q?SHV5f6psf6MkhEy6/+FHV5DXh8VuKhCeIv84t4XQ4Abk1tmfS79yNRu+TPok?=
 =?us-ascii?Q?xXyKo056Gf0g7GI6eqHjTFPgc7JQKaTRCwMCWmgqy8TkFGpkbHCA1juPZ7B0?=
 =?us-ascii?Q?MVrXlnWc1whhG5E9dncPM1rzz5bMsekryEwmymtgnbmwnGCwArJZF2owGF/+?=
 =?us-ascii?Q?AkuAROmOEeHo3uBp3u6YpkMsYVv6xHotlG7Cp7Kr9ylVWg3HjFX9ZQ20gm0T?=
 =?us-ascii?Q?ABV9NBvtC1KPoR72RE+kZP6Te+4G6LwivS1gxFyHTxq2+20rwxvwbiCjGyvL?=
 =?us-ascii?Q?LfaIuaHlVNTapPhaDil3nXHihtW/cAIa/+toGwu/ZdZzCS4f5vzS2DcX+PCX?=
 =?us-ascii?Q?yDte2hPFHiBZEdw6KGarMPdnUCmjsEwFLCDkwAGsn/umZuD9kLo3ptZGpzGf?=
 =?us-ascii?Q?pm9x9KJWCwdIebZMD6FT5jd2aDvtX0lkWsMR6QdqSc0wfRONJ3zq+wUVLMlF?=
 =?us-ascii?Q?QMa4OsDEcUTTDeM5EfL3YhU1e3c53cVQKWEU/MJ5sPPlvdhQKNdmL3pD3GXy?=
 =?us-ascii?Q?MWdPhwlMfvSIonRq9N15tiAyY04VNeXk/Jy3mvzHhr6wFTyt6BPwjcdLdxRs?=
 =?us-ascii?Q?RlxkAXwo9FrcmNWlvEK2bVvN3KMh9yoyCkyguszL1X1oU71cXUyetl/19o1g?=
 =?us-ascii?Q?i8m1xrc3cFCDq4Cr98hBA2oa5Kyg3hTZ863ju0vp4PTwExD3Ki6sWBcOuvvY?=
 =?us-ascii?Q?hva7Rza7xDbePsnjsMxZCdKqplSyl7sIm4UyY27vzHcQ/dcWPBbw5+XG3v0n?=
 =?us-ascii?Q?hJVvEWD+FHbOJKL+SLV9Ub8zKEXosBIjbIgfR/JNTafUNn/LaqTEkVlBf+Ux?=
 =?us-ascii?Q?90P56tZCLJaSG0KjHlzC/ODsNuRYebDAgLkfnGkLGbkc/Fos+dUbdSLSCCdV?=
 =?us-ascii?Q?mwOpxupot8omWNjGva836yKGQl5OfMbG9pmpAAGqlLKpG/J/I4TJQTpZEMch?=
 =?us-ascii?Q?Mo9alRVpcN/xOvCsoFOq7sug2ssL+F8cwVhx4TvZRZrPbMRZltBcPcbnQBY5?=
 =?us-ascii?Q?XOVVVez5IOWtBXIy0KFpzLNqyVIBM/s5ZzF6oNitceF9EBF77FFeY+/GrqZg?=
 =?us-ascii?Q?YKE9UeYVxh0df6VfITvSUYXhVqO6+ys3wYvfOE1B3Q6xHTPzcGlNRPHNki0x?=
 =?us-ascii?Q?qTOfSXKSj2XA11V9lQTfeZz0cD+N25AcWgT0BFOATSILRct2cgXJ+ueeOg0F?=
 =?us-ascii?Q?1QyZqrGPA3VTfvBRES6+pAuBW2Knd9gXHabmJlW6zaGmoUUd6guvgnIA93JU?=
 =?us-ascii?Q?9nFhu3TSZFNO+pgIqCUw+B4t9ulksajBXuhdbzp1MirZ57GkIaWAfdw+1wIZ?=
 =?us-ascii?Q?6EzYNsMmgL4uh+/uZ2XV/fRvrKACv9VCYB6jvMi9hztIS3Frl7Xbl2MeaT6W?=
 =?us-ascii?Q?IfVmrlhCDD4sj+dFD8MVaT6Ab7yLe6DiceVPYNR/QFx+NYMiVjJZN+Prgvhy?=
 =?us-ascii?Q?aJSIENNaYTIUzyxnkc7ZvM/+M3etfd4oG5xa20hBmWVodd2t2+BC+58Mwicc?=
 =?us-ascii?Q?ObGE2YqXKQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d9a4b8-bef0-416c-9548-08dec82401e6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5377.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 01:43:31.0225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /md1YKbZkn1E7M5Ee8RGb41fHgyLZL60/7NLtlnPnoicLMCa8g7Vp+CLPrJciT2FCLrDQ1xemYYYc5LA/qdL1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9746
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=nathanc@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Nathan Chen <nathanc@nvidia.com>

Add an "ats" OnOffAuto property to vfio-pci. When the device has an ATS
extended capability in config space but we should not expose it (ats=off,
or ats=auto and kernel reports IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED), mask
the capability so the guest does not see it.

If ATS is explicitly requested but not supported by the kernel, fail
device realize.

This aligns with the kernel's per-device effective ATS reporting and allows
vfio-pci to mask ATS when the host kernel reports ATS as unsupported.

Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/vfio/pci.h |  1 +
 hw/vfio/pci.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c3a1f53d35..b48138870e 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -191,6 +191,7 @@ struct VFIOPCIDevice {
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
     VFIOPCICPR cpr;
+    OnOffAuto ats;
 };
 
 /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9c06b25e63..6edb3bf5db 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2546,7 +2546,49 @@ static bool vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
+/*
+ * Determine whether ATS capability should be advertised for @vdev, based on
+ * whether it was enabled on the command line and whether it is supported
+ * according to the kernel's IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED bit.
+ *
+ * Store whether ATS capability should be advertised in @ats_needed.
+ *
+ * Returns false only when ats=on is explicitly requested but the kernel
+ * reports IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED. Returns true in all other cases.
+ */
+static bool vfio_pci_ats_requested_and_supported(VFIOPCIDevice *vdev,
+                                                 bool *ats_needed, Error **errp)
+{
+    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
+    HostIOMMUDeviceClass *hiodc;
+    bool ats_supported;
+
+    if (vdev->ats == ON_OFF_AUTO_OFF) {
+        *ats_needed = false;
+        return true;
+    }
+
+    *ats_needed = true;
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
+        *ats_needed = false;
+        return false;
+    }
+
+    *ats_needed = ats_supported;
+    return true;
+}
+
+static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
     bool pasid_cap_added = false;
@@ -2635,7 +2677,18 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
          */
         case PCI_EXT_CAP_ID_PASID:
             pasid_cap_added = true;
-            /* fallthrough */
+            pcie_add_capability(pdev, cap_id, cap_ver, next, size);
+            break;
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
@@ -2657,6 +2710,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
 bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
+    bool ats_needed = false;
 
     if (!(pdev->config[PCI_STATUS] & PCI_STATUS_CAP_LIST) ||
         !pdev->config[PCI_CAPABILITY_LIST]) {
@@ -2667,7 +2721,11 @@ bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
         return false;
     }
 
-    vfio_add_ext_cap(vdev);
+    if (!vfio_pci_ats_requested_and_supported(vdev, &ats_needed, errp)) {
+        return false;
+    }
+
+    vfio_add_ext_cap(vdev, ats_needed);
     return true;
 }
 
@@ -3815,6 +3873,7 @@ static const Property vfio_pci_properties[] = {
     DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
     DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
                        vpasid_cap_offset, 0),
+    DEFINE_PROP_ON_OFF_AUTO("ats", VFIOPCIDevice, ats, ON_OFF_AUTO_AUTO),
 };
 
 static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
@@ -3973,6 +4032,15 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
                                           "a vIOMMU. A value of 0 (default) places the capability at the "
                                           "end of the extended configuration space. The offset must be "
                                           "4-byte aligned and within the PCIe extended configuration space");
+   object_class_property_set_description(klass, /* 11.1 */
+                                          "ats",
+                                          "Control guest visibility of the ATS PCIe extended capability. "
+                                          "Valid values are on, off, and auto (default). "
+                                          "'off' always masks ATS. "
+                                          "'on' requires ATS support for the device and fails realize if the "
+                                          "host kernel reports IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED. "
+                                          "'auto' masks ATS only when the host kernel reports "
+                                          "IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED.");
 }
 
 static const TypeInfo vfio_pci_info = {
-- 
2.43.0


