Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C1ECD98E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZEJt-0005lr-OK; Mon, 15 Jun 2026 16:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wZEJs-0005lV-0Z
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:54:08 -0400
Received: from mail-westcentralusazon11010014.outbound.protection.outlook.com
 ([40.93.198.14] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wZEJq-0006aa-9z
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:54:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ur1/+pHbg4QuJVRMooCR9ojrjYNxLvH3jh/4M0tkdjDFUZ9rpwOuFOZ8pCRDtm63U2p5b51rOCwJvcI5VKhRkrKp6vOUR+0iUqtG7TFhi+81+CyBPt57IZnG3DhxrAiYa5oY5CJRlEEVxfhXjX5wcaO/5Ofdt0ARI4wucNgzc5L2gceWvmWitGs+R1Zjjg+zOTY5JA5jDqFJD7yfcLuUp3hpb7T35pKVLi90Y6Gdc/wMiu8ZnxQIl9/12iw31H8FcRlLA6Nu6kl2r6nEaQMNhCTn1ZtiZ6QXMgiPME2eET+DKMUB/y44TMh3x1myLAwPwlqHwp2UYK7+socqUelmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKw0nTkGL8Azbtgs79SjZIPnO8mqN2jqKomejdgDtlo=;
 b=wkRvZ8eoXPCWIBVPtsVNfWmYkCY6IFAjurpHovLUE+AS/ahY2U0Tf1ULLvK5L8irFQgpd2bGwt2VrlNJxEKu7F8Gr0Y7IAdNjf48CEYCRPaavG6HouTyVkwnRGNvvmTO9eDRCIkhq6xbiV83VU0A6cJw84u9uOvfhou3p/Iy86+SdZIKTSXE0oFHb2bx+awwlmbBmpfpVGlXn+wGQ52nXuqCvFBMb0598vsWZ7x3UnkR/CU9MHO+9OzOwwhANSlbZf5CDHOfcott4kSFv5sBfpNuwe8SYDLDLHZYupdXS+eYq7BnpBCD6gzW/ThiPz1axDxceYOP1Qr830qZ8Gr/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKw0nTkGL8Azbtgs79SjZIPnO8mqN2jqKomejdgDtlo=;
 b=UNn4M+GO9Nx+9v5jQ7mt15rteMNp0IdcE26LZgJpdm37EkhAhsNSyyy9vztXyDSkHxGDLJVz/rrnVfc1CbBuNf6pabTZWR6MyuMu5t39a1UkRs70fN3z03GaK5uhNnLutn2pdu368IQXK//rD81gZNkhW9gaZSQyqO1KFi1PHr+NbpLpl+tU5xU6YJOQpK5Llg921nAgjedQTa3YOLGxUq7jAgnZp/quonoCElYOAMuHzjDhm4OPByP0lDYIMpNMlmoDuXmZipGscC2WfHc8mey+gAKBBVxdGPtrJ1bc7zFhHcffmYNyz9yB1CjA9dfOsgHV4X+Ge7FL+gZ6ZvWXhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 20:48:58 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 20:48:58 +0000
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
Subject: [PATCH v2 0/3] vfio/pci: add vfio-pci ATS control property
Date: Mon, 15 Jun 2026 13:48:46 -0700
Message-ID: <20260615204849.3659647-1-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:a03:255::21) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: e56b6b6e-cb0d-4359-b1b9-08decb1f85c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: qBabyVlzAQQkWFGppyCu5kyB/iSlypsBPjmHn9Rlqpsw4X93GrFNJnGLZ7EpJ4IZaL5bgwDtsu36WhSIkG8ShhdPkxrOiXzumwm9QReYCHpwLxFFdIYmlWeJgfQlQlZKNrUh2NNMtXLkJ9N9This7CLM8G3bti1cG1QuSJqPkO8a/S6LigUuFNNnz57m31gvMtTZpBT+RQgph+SfbpOlIkaHiNTLirmwn3Ik9Wzm7eeVEJdWq4+ar3zpwFnxfX9AykzQ3yJWNINWUUq4mQzpriUCr2/KeS01mVqZcgiNFRoTpEnS/h4CbEe3TZHeFSVmd8bcTiGl1swFVomKu1RJOV2FSPjWKg76G0iHWidpMIS0rHayzwSgDOtBxUUozUYhJVzJsEITYukLdXsCtJ/eSz+DUNnx786Wj7JXs6AhnfNGH9ZZ/iNn5YKuMIpCnFKBeDH62H1pZ77gVJQdY2HjgCL2wTIOm7mR+Zs1bDgFKgcL43Vypjwj8fMOZP3/r0jXKIRPN0P6IQlvkygsis9eacQCzJglNZDZk/mRSqCxhDv1ejp/a2Gic3DN/KVBpv62AR0GN1c4W3+elPOUR1tszoRhB6OIDW3xExfWXxNZMUcdANSxHVCUjrRw5ebyX3aTY6UBTRal/VSn1HAXKyaP1aKP0fXxA0afcRxxiAPZSOXeLDGVJ9VJdlfl0YU2OhFo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WV55FkoW/Fz+eyk1/rqERBSMC865AgXUUpAK31TnC3mBxzyaaR88VX25s6vO?=
 =?us-ascii?Q?GlbwpiAZZGIXcdqJ6Hy3fOqQRUP7N7Lx9gbPW2DZqN6Q00xCiK8T0zaHVxa/?=
 =?us-ascii?Q?7irmNFpCl2PSFmxUbdqY9Xff2DhKY+UfmocKQgrw4cP4BnG1Fvju0zuTP2Z9?=
 =?us-ascii?Q?0Nq/ph/xV3fVTYvoCQ5j+vDOfGzuc1oXGaY9/Vm8hlNm6NOujt5Blk51Azr4?=
 =?us-ascii?Q?6ScArL4mgxRYikA9SCeKo0YL2TP0L/DN+E9xUn8hVbMR6jtYERg8ZKTE+3EJ?=
 =?us-ascii?Q?XCHvmiVk1Ivry6GyhhBoDJDFu3A+/WMFbhGZ7fIB0WXKKpMiFWQmMcvMaVyd?=
 =?us-ascii?Q?KqI3nti6RfSQQzNy/6+w3tPynS6kJEA8w+wxrsgxMjavnbRnX6BsE3r8x0OF?=
 =?us-ascii?Q?WUtUyI0Iq/BvoYWtgrpvGYS+mRQVPBLe25aUzMuCdLrOfwGDALY6qoZ6OHCD?=
 =?us-ascii?Q?rdUaxyi8+EdkCN8/E0ymEsidG1NipyPd16VVEJCYe7i8PAnTij0kmbOchoKD?=
 =?us-ascii?Q?Riab0X5ygTvXRe+7l2XecArcgUspRlcc98Z7ifZiER+ZlWHsup5pktP2jbmH?=
 =?us-ascii?Q?76H+ENWlbbDq8Ssxi/D8TT1ETciSjo004Iw/2JPS9Dl4Cb2PaoB0gFWe7slj?=
 =?us-ascii?Q?E19677VCo9o5x9GNgtNXT7VIXs0sHvmWCPqenx8PEJ2Ef5l79/08I+CABXe+?=
 =?us-ascii?Q?dtxPCl5a3I3n08atGppurqzgZzOG0kAFiVf0aVifKL2fosDENRacLb2XyrwS?=
 =?us-ascii?Q?j5sxtBCmAUoP4s6PVRlf4OmxJXh93haARjBG9uvZK0DI1/eupLVmqWW2Ryn5?=
 =?us-ascii?Q?WDEmYNnhlnvZ4eF1SpmIltOvgiYg+n57tXj2owEikEkBF2o+6ciBk/CLepxj?=
 =?us-ascii?Q?J5BPhwQJ7OfzwLhAVRBwKKEaRiVEnEI3pfhjOhJ+qIy14CgBbShhX3upV7Ik?=
 =?us-ascii?Q?uUMMQgXMZTjhODCuI5i4YqlcpiBovIuCPQLP2jUSUWZra4sCJGul4ks/7PzJ?=
 =?us-ascii?Q?0rwj0hePdpE01l08fJy9j0e9R5PubB1ZAgqeDQXvBz8gCWRlNEd0R1QFN+eX?=
 =?us-ascii?Q?e4yYt0LoHuXe0wpp7ImNw5pE0iJaMxOmgkhlinHzQxTr4IrVsENPmA0tsdac?=
 =?us-ascii?Q?ENB4c3vqbktBGS3Y/yOMTu9tcNKMw7iovOZEHZ6el0Yl/FLZL2486KqOItC1?=
 =?us-ascii?Q?PzCW0bv55U1Xh1WAwghIxmSBZCI2j59t4rU9n5/+7fDl8MmiF0d7P7wq3nHf?=
 =?us-ascii?Q?Je/G5R1HQziaSqwMwsi3FJ/qn1JbwglCSizxZ1ALV34/Rl8MOO+6i2+Y+vxJ?=
 =?us-ascii?Q?qax/VrzXoI2sM/f5z0/kb8ZcbGLRqKVTO6HHsoZYdSRiRXcTxSStmq7baNpG?=
 =?us-ascii?Q?AqFBWGUQjXQEvMHdDPXNYK7ZfRonRmTbX5oEn6fc/tduwq+XhIAB9JcUrXhn?=
 =?us-ascii?Q?zEQC1BX86fOKLshdQlHc7HRipICTRd0EJSKTIHoEPBGYnPqmzXnATWM/AOk4?=
 =?us-ascii?Q?snv3qTK5v6S6KpZhNBfvTnIGe1Bxnxlm1nr4RwlrvoWaO0WICrtM8RxBexUT?=
 =?us-ascii?Q?Xd5CUnyj1TSzLhP329qgA1gMlZ6uPDERAItWtFu+udPzFOaxGFZg7WcwQCX2?=
 =?us-ascii?Q?26gO1bVTg4d5MMR8/sygVDh/F47BEmJTdGTg/WC1hafPZ9276kyGh3QLNEu3?=
 =?us-ascii?Q?FXTWERY8nyL+9lotsMhTUPYllKbKks1zExGCMMYo7xmMxsiylR9Ky3pv8Eqs?=
 =?us-ascii?Q?dDI+Ois9Iw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56b6b6e-cb0d-4359-b1b9-08decb1f85c1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 20:48:58.2854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DD31MZ2iaP2eaNMh26/Ifv1gg57s5Vj/c0VwP3TZ7cJekamPQ5mXuboTFarRLQBb+bxIUF2d61u0Zdih+jAUog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807
Received-SPF: permerror client-ip=40.93.198.14;
 envelope-from=nathanc@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Hi,

This is a follow-up to the series [0] that adds an ATS control property
to vfio-pci and wires iommufd support reporting so vfio-pci can decide
whether to expose the ATS PCIe extended capability to the guest.

The new vfio-pci property is:
  ats=on|off|auto (default: auto)

Behavior:
- off: always masks ATS from guest view
- on: requires ATS support; fails realize if kernel reports no ATS
  support via IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
- auto: masks ATS only when kernel reports no ATS support via
        IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED

To preserve machine compatibility for older machine types, this series adds:
  { "vfio-pci", "ats", "on" } to hw_compat_11_0.

Please note that no linux-headers sync patch is included in this series
because IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED is already present in
linux-headers/linux/iommufd.h in the current base.

Testing:
Verified ATS capability visibility changes with vfio-pci ats=off/on/auto
on an NVIDIA Grace system:
- ats=on + ATS supported by kernel => propagate ATS extended cap to
  guest view
- ats=auto + ATS supported by kernel => propagate ATS extended cap to
  guest view
- ats=on + hiod_iommufd_support_ats modified to return false (mimic
  kernel-reported unsupported ATS) => realize failure
- ats=auto + hiod_iommufd_support_ats modified to return false (mimic
  kernel-reported unsupported ATS) => ATS masked
- ats=off => ATS masked
- ats=on + no ATS support in physical device => warning + no ATS ext cap

Changes from v1:
- Set ats_needed to false by default in
  vfio_pci_ats_requested_and_supported()
- Revise log prefix from "vfio" to "vfio-pci" in
  vfio_pci_ats_requested_and_supported()
- Squash compat update patch into patch for introducing ats property for
  bisectibility
- Revise comments and descriptions for support_ats(),
  vfio_pci_ats_requested_and_supported(), and vfio_pci_class_init() to
  be more generic, removing references to
  IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
- Emit a warning when ats=on and no ATS support in physical device

Changes from "Resolve AUTO properties" series:
- Split into separate patches for support_ats() handler introduction and
  iommufd implementation, "ats" property addition, and compat property fix
- Rebase on vfio-next
- Remove unnecessary includes for hw/vfio/pci.c
- Rename ats_need to ats_needed for vfio_pci_ats_requested_and_supported()
- Move the vfio_pci_ats_requested_and_supported() call to
  vfio_pci_add_capabilities() so we can propagate the Error **, and then pass
  ats_needed as a new input arg to vfio_add_ext_cap
- Fix indent error in vfio_add_ext_cap()
- Break and add a pcie_add_capability() call for the PASID case in
  vfio_add_ext_cap()
- Update comment about return value for support_ats()

Thanks,
Nathan

[0] https://lore.kernel.org/qemu-devel/20260612014322.2918836-1-nathanc@nvidia.com/

Nathan Chen (3):
  iommufd: Introduce handler for device ATS support
  vfio/pci: Add ats property
  vfio/pci: Warn when ats=on but host device lacks ATS cap

 hw/vfio/pci.h                      |  1 +
 include/system/host_iommu_device.h |  9 ++++
 backends/iommufd.c                 |  8 +++
 hw/core/machine.c                  |  1 +
 hw/vfio/pci.c                      | 81 ++++++++++++++++++++++++++++--
 5 files changed, 97 insertions(+), 3 deletions(-)

-- 
2.43.0


