Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D8BC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 10:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7YCe-0004Jn-80; Thu, 16 May 2024 06:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1s7YCc-0004JC-8i
 for qemu-devel@nongnu.org; Thu, 16 May 2024 06:19:10 -0400
Received: from mail-bn8nam12on2074.outbound.protection.outlook.com
 ([40.107.237.74] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1s7YCX-0002Qs-KO
 for qemu-devel@nongnu.org; Thu, 16 May 2024 06:19:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIS2bynvrcPvBeM+VaQRh76BhfeoIkwdC3SEo7XPhoUFY8jJuGuDDjb/4CpalRc41NDbjVqAvA4jl4mvzjxPpFer24ra6dy8zUxuREU8A57DMfQ0d/ddH/hVTWYWpQLoBWD9bmXypQ6l0krPvhjGD4mOY3d7ar+/aO+laha+wsBJ7PMkPvWp9Hf8fXhMlaWW4A3BjfuHM5aVFRDJkf7i9z5zWjDnvDp2+PEE2E7PlzO6d5cgmvnkGxOWqPd8GemzyoRKjgSqqxrrXkORU1mqvFnlmPe4/cuaGU7DW4DAW+AvN7TCKJC59DZwDD8hEbhlgNCLUycViiupKGeHx1N+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgznFSSStOfkFRmozyGTygvqO4riUbrmtAZEM7Wq7T4=;
 b=EtYNf7J6Tb56LCbvepZP4mpWRkaQFpQtJUG8PLrkseZdAP/ttuajQJre0YLj8j/0zN6OOQWIhLCYHEbXmZ5L8ZDbDMC3bbOf7djslzbzpf3xw6yIucd1p3/P1IrrUIj9NjoNBXUQtFdfQGRO9Kjef20svEyd1boBQWm1aAqoAlgmZU3XVLk/KORU8dMWAfOh0HUA0xwEnPJnO45lGIe1+0xylFTRSrdjxpoNbBvcupc1GQEuVQaxdnoE9jdBC+t7BeLtTFv7LP3qDFnmFBWL8X2vTy7tXKLUdvdVcsdhVbbk458F/ryD2hbt10mHP9v0J2Wtl1t/7+I2++SUjoBWoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgznFSSStOfkFRmozyGTygvqO4riUbrmtAZEM7Wq7T4=;
 b=VLRxx7kQLk42gY0kX+b2uHWdVKYhmnP1qjiRFd+BH6HNbyfAzBmjeaA8o0gw76nUI/F/fu6qViMMwBttNrf9Bcf2HUEYK554IxB2D8wk1jylKEnmZEkk0bhJDaE5zPMldZ59X7pKsc7XNG+AmuLmedT32EJm4fOIuT4wjbNKSj4=
Received: from MN2PR20CA0056.namprd20.prod.outlook.com (2603:10b6:208:235::25)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 10:13:59 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::69) by MN2PR20CA0056.outlook.office365.com
 (2603:10b6:208:235::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Thu, 16 May 2024 10:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 10:13:58 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 05:13:56 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>
CC: <xen-devel@lists.xenproject.org>, Huang Rui <Ray.Huang@amd.com>, "Jiqian
 Chen" <Jiqian.Chen@amd.com>
Subject: [RFC QEMU PATCH v7 0/1] Support device passthrough when dom0 is PVH
 on Xen
Date: Thu, 16 May 2024 18:13:37 +0800
Message-ID: <20240516101338.86763-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|PH7PR12MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 1337c990-1155-4805-3e5d-08dc7590e6cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TB4dredHahDU2xvntDyE4vjxnaPkImyt3qC1CzaQsHMfXr4mpTVN4H3XF7+F?=
 =?us-ascii?Q?UD7ULUaY0PV9QRSRc58FdfUwQ8XOJ3IGSBVpQJ55uG3gGsEnpWDRMslYPXje?=
 =?us-ascii?Q?MYYf2AysAadC74fawVChRd66SeqH6aQlfZETjxv70lJ13I2yVAAQfMxNwGnW?=
 =?us-ascii?Q?Uffu9z0QltnePeagsBkS2ast92sUy/5A+tRBvgepe1ekdJU7VT6VDu786QjU?=
 =?us-ascii?Q?dBJMTgn+Dws6TV24O1kbRzwAITt+TWQbb5nLWVRdRmnJ8+2rMC0pKOtushOh?=
 =?us-ascii?Q?bVP81ABqywMgxFFTEWkRKU69D8Ya2VoamIN4QYA64uo5orxza2mXmvEp5dGx?=
 =?us-ascii?Q?clKYfoXjSXdZvMEa7IPM6fE8imED+GQ8lEbc46BFpa8+NyiRdn89YBwPW9j/?=
 =?us-ascii?Q?eZVVal2fIy0st9h3mCA7Xngzr1dVK45bg6uOYnWyBf2zQWwVLrEmQQriegl6?=
 =?us-ascii?Q?Br5EZU1LnHQ3+eKZ+sJ6CvI+kSK3L+qxPXdkU25PUlRq+gtpfMrw0EHxcfAx?=
 =?us-ascii?Q?Vb3rO2sryyFeciowFhx0ZX/VMf1Nelv9R9ZxVDmLbdHlSsFLzr0oP4PKJtbt?=
 =?us-ascii?Q?r091qHNNgKmb0UkftRVJj5EiA+JMSjR0kWwLcCTGhx6augaioAFO/yqA47oI?=
 =?us-ascii?Q?CZKyjoEOGOsLgEf+SclO3a107KVfs5lFUNDw04YTmyKtdd+jl1RdacwJb51G?=
 =?us-ascii?Q?CBRpVdLoTe7rjQduHnW3+Mdzk9SKVmW5bZko2m0VIfyQmRnCqTHGcfqxxaNW?=
 =?us-ascii?Q?3QoXJfls6v3yKlwlLCsc0bcHwH+FiJmVIH21N58HYGcOG1DD1hbkVd0ZGXfc?=
 =?us-ascii?Q?xvhvwhqiNKHnuMbdg+uUlLddCE+55QkXlxkaG3g+q0f/JxDjjrpbcbetWJeX?=
 =?us-ascii?Q?ZZwJFA3GCS/n0rTTmDMBAaJ0eEXFM0uu74YXC7I3YjVGdDcXY1XsnRIZolr9?=
 =?us-ascii?Q?2XBV9XkSySMdZ3Q/SaGuX/ChCCec7p+t5HurEh8f4h4UdbZxcRNRp8nQjoGX?=
 =?us-ascii?Q?Pu3FKFHPBIbdG2iiuQpkEAeM5O8SisFyMK1VSp4RDlK5TDoVZk7lMZppl/57?=
 =?us-ascii?Q?EzjBh+OqjgRON2b/eIbOto1czBn7NMCWldy/Ao/9Eq1lNOJbnFXa0VfU8iZF?=
 =?us-ascii?Q?JHrsTEdeH4MKIZjVLVj268FKiT3Yo8R6yNO9Lq7pA+fo6VPEapbIhsZcfaqS?=
 =?us-ascii?Q?B+Ffhaspc/MX4VTUiDgiTCtsZSolHf08AsTp2jqy1eithAQNrbRxan8tM3pc?=
 =?us-ascii?Q?7pW3z45bl5SpJHLymd0FUfGbi4F7pvvpZQGqaIqRRuznJekF5UHaCZ+INrHb?=
 =?us-ascii?Q?nfyRJV0jcn8agoQzgfMgu3A2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 10:13:58.7340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1337c990-1155-4805-3e5d-08dc7590e6cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594
Received-SPF: permerror client-ip=40.107.237.74;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

Hi All,
This is v7 series to support passthrough on Xen when dom0 is PVH.
v6->v7 changes:
* Due to changes in the implementation of obtaining gsi in the kernel and Xen. Change to use
  xc_physdev_gsi_from_dev, that requires passing in sbdf instead of irq.


Best regards,
Jiqian Chen



v5->v6 changes:
* Due to changes in the implementation of obtaining gsi in the kernel and Xen. Change to use
  xc_physdev_gsi_from_irq, instead of gsi sysfs.


v4->v5 changes:
* Add review by Stefano


v3->v4 changes:
* Add gsi into struct XenHostPCIDevice and use gsi number that read from gsi sysfs
  if it exists, if there is no gsi sysfs, still use irq.


v2->v3 changes:
* Du to changes in the implementation of the second patch on kernel side(that adds
  a new sysfs for gsi instead of a new syscall), so read gsi number from the sysfs of gsi.


Below is the description of v2 cover letter:
This patch is the v2 of the implementation of passthrough when dom0 is PVH on Xen.
Issues we encountered:
1. failed to map pirq for gsi
Problem: qemu will call xc_physdev_map_pirq() to map a passthrough device\u2019s gsi to pirq in
function xen_pt_realize(). But failed.

Reason: According to the implement of xc_physdev_map_pirq(), it needs gsi instead of irq,
but qemu pass irq to it and treat irq as gsi, it is got from file
/sys/bus/pci/devices/xxxx:xx:xx.x/irq in function xen_host_pci_device_get(). But actually
the gsi number is not equal with irq. On PVH dom0, when it allocates irq for a gsi in
function acpi_register_gsi_ioapic(), allocation is dynamic, and follow the principle of
applying first, distributing first. And if you debug the kernel codes
(see function __irq_alloc_descs), you will find the irq number is allocated from small to
large by order, but the applying gsi number is not, gsi 38 may come before gsi 28, that
causes gsi 38 get a smaller irq number than gsi 28, and then gsi != irq.

Solution: we can record the relation between gsi and irq, then when userspace(qemu) want
to use gsi, we can do a translation. The third patch of kernel(xen/privcmd: Add new syscall
to get gsi from irq) records all the relations in acpi_register_gsi_xen_pvh() when dom0
initialize pci devices, and provide a syscall for userspace to get the gsi from irq. The
third patch of xen(tools: Add new function to get gsi from irq) add a new function
xc_physdev_gsi_from_irq() to call the new syscall added on kernel side.
And then userspace can use that function to get gsi. Then xc_physdev_map_pirq() will success.

This v2 on qemu side is the same as the v1 
(qemu https://lore.kernel.org/xen-devel/20230312092244.451465-19-ray.huang@amd.com/), just call
xc_physdev_gsi_from_irq() to get gsi from irq.

Jiqian Chen (1):
  xen/pci: get gsi for passthrough devices

 hw/xen/xen-host-pci-device.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

-- 
2.34.1


