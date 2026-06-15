Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43414CD98E2
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZEFe-0003w2-Tu; Mon, 15 Jun 2026 16:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wZEFc-0003vP-Ks
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:49:44 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wZEFa-0005Aj-My
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:49:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+qrsfhtbol+O3pU4SLerDoRs23/oPMM91zw3lsI0wK3fdsyqU+hJd8sRC/5U9eH1oHNG5Yi1m0lp7Llh7HqolZ6WE3qTdr/N/kCM1RbGfmSNBCHKq3zbGIXi9pHqKsSlp5r9fyNbdNGuQH+jXqMUEbnhgExM0ZH1rfH7ODq85LUfYksCMEG27U/xGtfMX25UESXMSa+l+EpTuKMz0+WQgx8hl7GpW+gCzS/GMGMsyGK5N+i559UkGEp4KSUDmzh04esEvO5MuebRqJXIv0/1MxZrlNUUyEUiokcadZ/kVezPXr6FWSVasPaSAMInZGv4Klo1namfLMGKok97dIcLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyYjY3gZAnNn0ZyZbYr1yOYVXqMB6ggMJxBKIdN1Om0=;
 b=C5EY86NV86wpd6dKbSHcPa1q5qQ7xfhNzJUDqWNaZmzbLFxdJcdENTYrDDxOaSFS+bsV3/5uS2NcOyZkDT34npCIvUQOejNDkhg//imBg8rEeT6BdUXmu1itDklgtRUi+ZBeGnyw17x53f7R4avXbJGqIRS0tuNyybNlXNO9cfGMniG+CQNUoC4Y9hZpGFhmtlZ2AjHup8JDbnrqG0cenUNKD3JmqrczzhDCh5Z+/xBHJe3YVCWaFSegbvq13EjH80DwLu3Y5r8SS6/aw4mOwKsuhj665By6+dYUTNnSRHibnpBFGEBpRbMIFEKFITw2kdHuugGq+7IdoPoeuoLyMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyYjY3gZAnNn0ZyZbYr1yOYVXqMB6ggMJxBKIdN1Om0=;
 b=A4JFaIABL1ogsxJw9iqmY5T/kDFRCcRTCvvI7awz+asp2bCUbkY5ejb3sRVxz+oAx6Ao0a1pYfPxuIDOWpkbiIxwIyN2USXz6Kj0Vc5m4BMtKCiJaPc+xVVJPdePbeAVcqa+N+VMLUXH3mL47zhgECFIl1DnLu1OubesVS5PxXUiQeV77Gc39g00TPeWe3Av7c9oOBBJxb/acgn3ldXG55KEvu8lVwLbCGm4hK1iakIn8tOLiR3SW7hDe2qkcK/zpX686p6tBzTKBQnUrrC+prdEADcyOQxIbNnvFW+1Fz/b8ugO7RDYLyxKRS6GDJAmCnuvfA/kihy2HIdBFoZJwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 20:49:02 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 20:49:02 +0000
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
Subject: [PATCH v2 2/3] vfio/pci: Add ats property
Date: Mon, 15 Jun 2026 13:48:48 -0700
Message-ID: <20260615204849.3659647-3-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615204849.3659647-1-nathanc@nvidia.com>
References: <20260615204849.3659647-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b60880-24a2-402d-3cae-08decb1f8808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: +KnJphicjQ56sQKfHSxyjvrXViFYLrwvu274VGQEfbLMpCPoI2oaxTheTT1zEzsLAodbbBVWKtyQg+6xW0u/fyq0g5jlg98pEqkfQdVXCKxWN3pYVOnqEUQ0LYWSNgDPc90WV42T6VVUEetytn8Y03Xd1ijOEiTQowOBja3fTGEgt3x3hMw6fhFdpWuR3X8LMk1Y1JBRAzTK2PSDo8A8AOCTaZ3Kr3hWkeiXoE7NmZavKOxpV2iq5ArSCG6O3PklyJLk02hLnsjXslZbtQfK+4IQr0U3Lf+Ed6upYyEFcyMVRQJUFi/Oa/dEwlovX1b5vWPFz0Gwm4b9aevC2g/XElFdMBrROk1zVV/yTzgu+Ro6LfsP7eltbUDXn1pm8ccUF9BziCgPPHQHaDrjF+V6G0QeHvbK67/QkVvLMy4XqX9j0cBXKn4+feRqMLUkfMG00+ftrlCRVOsg7BeOzsflEwbEGNBoN/feUh6iNaoqpAe8jQfxv3C/PAc2JSF82pRFFZHTgMTrEjwvhQlcmCFI/mUsjSVUKnfZwuGAiYhtlG7Ia2X/Gs60hdLq/ecHYgQERqyGqpwRoOCNjRpHBEsDUehS1CsbPOxu+x+WfgkboMpinuSQdV1RZkYkB6n9v0TiHQ5WuFhJPq/cx9U2FhcBKQpwmjj1tBrqByYIaYiIWHbohX6vrPXB5XrmQY4QNcy7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WPLFvtkz4DDTuSzaNL4RukFf3+CgszB+8SPt9q4wE8HxaWOpYNjh0AUgVdor?=
 =?us-ascii?Q?t8gCikW3YINL9naWCaA917XWcAIFCGvWblBM3siCHGHsClfv/zUlvgwNJrR/?=
 =?us-ascii?Q?8eQa6BwBagC4Vjo0gkpimcw2NnrCQbZ5uCwdacXq5Ga3KfxQ4P2JUJ7yJJNl?=
 =?us-ascii?Q?zO1T6X3W3dVVhsb/k0CVluEOjOfB39tu6MaNcUcWNbI95S55mVFRWPbNXqfB?=
 =?us-ascii?Q?FYQ7NSNJoXF92lLGFhjX9QgqKRP/aObkYt8Ga12xX5f6ine0zOm41xF8SHzi?=
 =?us-ascii?Q?FWnSPXyfQFcR2h/gT6QTPhJ341pB7ooSUsjpbwGGZBBUOqvjGj7nhlIEU6/N?=
 =?us-ascii?Q?DDIHxT+PZivUp/9MpgCYSyu1fnc5oY7R85ruOhPPE1xBd5XtKEZOfILKp6bN?=
 =?us-ascii?Q?f6WgsitN+vT4CujQjBzABFoECx46vWBdjyhqrFcE2ckoZm6ZcAHJL7R36u2D?=
 =?us-ascii?Q?JKFiQNnWS413KpXqXz4rhcDiL9QbDcKpbO10m3sbFHHiq+n6WQZKEGepsCEG?=
 =?us-ascii?Q?TRaTNsOmjdyEIECrMjab3Oa+3HNtRDZThZ539gg/UB5SQWfO/De4MX0LEAff?=
 =?us-ascii?Q?HNur7kla60MWu6SnT9hgIP9McI48xK1xTa+dfHToIWVAlxX9zo2RPbcBB7v+?=
 =?us-ascii?Q?qxQ9BVUI+63eTGvXfzReFd84iRM7l7SyjR/fJPl2KrbFu/aJKHA0lUVHyvO1?=
 =?us-ascii?Q?ECZTyWPofimfBjo1UL5yFgth+JIRXTxGNn+GnRLW3ox9BjY0upE3h0jDiEhC?=
 =?us-ascii?Q?g+j1jgmTi7EOVqhi++UZn2LbxKYV3SGUANMItHdvYtIv/A43ZA7MTq14PPWf?=
 =?us-ascii?Q?csna454nSuxQX3a4kyIMh2kQ12WIu88GwV8eB9o+mYyAytMHLkSX52Oo+/2E?=
 =?us-ascii?Q?4Qm0gYfOWXgp/A6+x4DxA19uaW1qyDkVbu31Do465AmoNDdnIgsUek7UEqax?=
 =?us-ascii?Q?Zv+sZEFELoeyh9kAOrKT6QKLxjrjZNpPrRNpbcbsB4KVhGpkOVDGnQgQijR7?=
 =?us-ascii?Q?Trdl/GVVuvde/fF0ntIg4HCMEdtMM/KQ5O/3je4QWeGdLnAk3fRTx12yAOjm?=
 =?us-ascii?Q?lAFE6kEv2jua7sKamB+3uEFmxbQxiY/6L7/oXh9eLac5kOYButlulShu4kMR?=
 =?us-ascii?Q?hTJkLH+xO/ML65bkAEhjWxIs+XCWCd+FdxI3kre3/bNuFJYZKVSkkvdmA9+C?=
 =?us-ascii?Q?aqjonTxOJ4ONvqUMvYps94FvZBgaBlWDwvFELriNBGt1WeUc+C9ghoVwgprt?=
 =?us-ascii?Q?RSH13vPquyP56nC4nWieGAibWCNMYsBy3acMg0IwFknX4U4b60+LSRA+zx9U?=
 =?us-ascii?Q?eE07mXPdi0R/DI7o38AgdA5OJCuV/S9hqUCTAES7PO6A7rAWK4+TIEKHIOVU?=
 =?us-ascii?Q?CzgfyYv3q2sGr82JPfkB9Bd4G0czeMKRLm/FWGY2tTr5Fly6Vgi+RtQudny7?=
 =?us-ascii?Q?OGLSmnv8xEUJt6Rm7GCSY2WEe3AOUSWLFBvtMc0vV0YIujt0jx6xDIkdgI+D?=
 =?us-ascii?Q?nJNmHfpwA5/6PhKrzCV7WmsdpavEk5AErddjWFhytj17NIzIBe//NPL6AoT5?=
 =?us-ascii?Q?dJ3hohLZjcQSjwSaoGK9cyPnyvvWwt926qmSYTgvhXizbon3IJhDu/I/VEFu?=
 =?us-ascii?Q?EnEskuYH8Hy2+lCfrMwbLLFKiFCC3r5DWLREBbj3QmDp4cMTc8Lhfx8jLHkh?=
 =?us-ascii?Q?vshx2pUV8dbvPSnHB7SCZ6rhyHQV1v6sRX3PoAXot8KHqQFQj0oqHL04a+zF?=
 =?us-ascii?Q?PDfplpxuNg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b60880-24a2-402d-3cae-08decb1f8808
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 20:49:02.0754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSDWvbc7lXSe1WKzctYNPiLBWbpuMscaecqGOy6ppKitTWrVmEDdvGqNq2K3nFk3HbHDgBv5AF8m9MDO11eDtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807
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

Introduce a new compat for the changed default for vfio-pci device ATS
property, from "on" to "auto".

Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/vfio/pci.h     |  1 +
 hw/core/machine.c |  1 +
 hw/vfio/pci.c     | 74 +++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c3a1f53d35..f2934f2d84 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -188,6 +188,7 @@ struct VFIOPCIDevice {
     bool clear_parent_atomics_on_exit;
     bool skip_vsc_check;
     uint16_t vpasid_cap_offset;
+    OnOffAuto ats;
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
     VFIOPCICPR cpr;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4d8b15d99e..c0cdf7c9da 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -43,6 +43,7 @@ GlobalProperty hw_compat_11_0[] = {
     { "chardev-vc", "encoding", "cp437" },
     { "tpm-crb", "cap-chunk", "off" },
     { "tpm-crb", "x-allow-chunk-migration", "off" },
+    { "vfio-pci", "ats", "on" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9c06b25e63..0f592ada89 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2546,7 +2546,49 @@ static bool vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
+/*
+ * Determine whether ATS capability should be advertised for @vdev, based on
+ * whether it was enabled on the command line and whether it is supported
+ * according to the kernel.
+ *
+ * Store whether ATS capability should be advertised in @ats_needed.
+ *
+ * Returns false only when ats=on is explicitly requested but the kernel
+ * reports it is not supported. Returns true in all other cases.
+ */
+static bool vfio_pci_ats_requested_and_supported(VFIOPCIDevice *vdev,
+                                                 bool *ats_needed, Error **errp)
+{
+    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
+    HostIOMMUDeviceClass *hiodc;
+    bool ats_supported;
+    *ats_needed = false;
+
+    if (vdev->ats == ON_OFF_AUTO_OFF) {
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
+        error_setg(errp, "vfio-pci: ATS requested but not supported by kernel");
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
+                                          "host kernel reports ATS as unavailable for this device. "
+                                          "'auto' masks ATS only when the host kernel reports "
+                                          "ATS as unavailable");
 }
 
 static const TypeInfo vfio_pci_info = {
-- 
2.43.0


