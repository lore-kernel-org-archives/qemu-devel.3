Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7085C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 06:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXE5X-0000Bk-AW; Fri, 26 Jul 2024 02:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1sXDvs-0004kO-At
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:56:00 -0400
Received: from mail-dm3nam02on2048.outbound.protection.outlook.com
 ([40.107.95.48] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1sXDvq-0005rZ-82
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:56:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qh7ewCMAZmVq5opGIjQKAhxW1txhHfx3ARcZ0Od5QVbltVVi3G6yPtODJ3y/Ode0QE/GMjEBQWub7SDq47Dr/9ih6WPI4ai10zmcqa4tJYiQel02EEIYRyLEJsl5qLHFzMPn2qi44LriC6S5Dc6CQE+d0cWk9vMs9+2ZncaVzrTPI0CQQL0CdJ59cdwNgPo00ZYPsNP4PaJ19fZ//FpI6J4dvIfkM2uXlr2kz6Po/BFFBuZEU2wBlBCMyWf+MnVi+NdlgXPTy+L8PcDJ5vzoIqzpJfvu6QRE8JkGOa2HEBfnra5jRP8QEgcua/w8xz1UU+dtudZEn3qSJXEj7Ego9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEyp91BPa1yfxNezhgfvY/5qVTDiZ2g0iNDgBTUTqe4=;
 b=YKpI9WoA3kYhVCzlX9UuOzYWUY6mUShBKaRT39p8yco0qxqqQp54fHAiN1wOIcCsUHAn4n5EJ3LXpVXCRWhSWFVTlMb0pfNPEQjWzhOm94UeocBCWL9yWYBx4js/6ZFM/++J9zAU0xvOW9kD2P+JsPrOdXXRm2gC9JVYy7Q2lblku3wZKA3H7xnFE11VJeLooUSv4JfH0TuwPxqUV2r/I9YjlXNwiR6/bpowUSwsTVxhN9IgMi+eG5CbQO4/fTwj8L/Wu9Yx47D2uk6aOK5TfvWb/lS/A8hbp0hGzkIp+Cn/5NvAcxpgM8sn5TXT5dIt3sYB5hO6qe9cFrpDlZndHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEyp91BPa1yfxNezhgfvY/5qVTDiZ2g0iNDgBTUTqe4=;
 b=wFe19rgNOfcdrSq8GJV9g8p/5WDdh3JU6Cj+CoSLZ5Zn86342y7TmAFj11OqaNapB20c8CzStMrRrz/bvlu08mX0SJ66aS3PNVur3XMTkHCZLVPw+jURCakydPesvLjnnpjg+iteh8JjNs0cGEhVZG8f2rnmeNU3MhDm7N0lz1o=
Received: from CH5P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::26)
 by PH7PR12MB6540.namprd12.prod.outlook.com (2603:10b6:510:213::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 05:50:51 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::47) by CH5P223CA0012.outlook.office365.com
 (2603:10b6:610:1f3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Fri, 26 Jul 2024 05:50:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 05:50:50 +0000
Received: from SHA-L-LEIHUANG.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Jul
 2024 00:50:48 -0500
From: Lei Huang <Lei.Huang@amd.com>
To: <mst@redhat.com>
CC: <ken.xue@amd.com>, <lei.huang@amd.com>, <qemu-devel@nongnu.org>, Lei Huang
 <Lei.Huang@amd.com>
Subject: [PATCH 0/1] Brief description of the patch series
Date: Fri, 26 Jul 2024 13:50:28 +0800
Message-ID: <20240726055029.946-1-Lei.Huang@amd.com>
X-Mailer: git-send-email 2.44.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|PH7PR12MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a896a4-cfe7-4e82-bc65-08dcad36e7dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/RgFHyElyg/9dLpGCG1382N1xvvvAzESV2JHmIAm4TGCrx4FKv3U0M7hJyAO?=
 =?us-ascii?Q?EFy2qsjEzeDTf3UiK1qNLmtk9qIxG+nG3zwEEnxWWHzaldJhecKjsbAsNdpk?=
 =?us-ascii?Q?gt4Jzl1AZu+r1aGlO7SakqjPuSl/wd4vGVI+OYvYNx6Qvn/4FWIaiYwx27rY?=
 =?us-ascii?Q?cB2j+f/vj4CIkde/SenHWuc+mDIXzr+OxIv9iLOTjAp/ixw94F0QqxgyM8cu?=
 =?us-ascii?Q?UAPEonMd3rqOAO3z0RSXIHhmWb3YHZk//PekFSdY+6bEUZc2egxIi94PJYiZ?=
 =?us-ascii?Q?JfJlha33URlzS1FhJULpbzORu1bmYCx3LGFzKmzBYezdAmrn4z2fck/Ux+zf?=
 =?us-ascii?Q?PYmvJFPK9RWTwXfxGgSTfQVStxldjUm8ne5i8KwI0XI6o75aVnO1u35XPzhk?=
 =?us-ascii?Q?2M8t08ndzwyZhYgJM5oM5Dbg2J9+FSZ9NuX3ZJ1wDJuhFE/H8ZBogzXZnOnX?=
 =?us-ascii?Q?J0YWUC/WcvQymSPFXTANJmvI3lIHFKU33pBruaXuZRaVOMKv49ZPGjQS4bJi?=
 =?us-ascii?Q?3a00c20+VR3eqmLpw+AC/+5FyaNKnQNaI+7khgA23Q/NhUahJAJ4bPkwqHIS?=
 =?us-ascii?Q?liDV3dDtI5W/HFM1Jt1j0BOARKDGqFpfg0ZSHf8P3FcIrUswTdjcM6lagWeH?=
 =?us-ascii?Q?K9cZGN1fNvV68plDKDcmFjeAQvh6n+22GsA2/RI9e2Ks3VwC0fNTpN+/k3ZC?=
 =?us-ascii?Q?AsJM2jpTTWd3+obti26TEQU9vmaiu6jtaBv0L38hZEGDK1N7tcx8uYxGaI99?=
 =?us-ascii?Q?K3Ye8sYRQLZbVCKXkE2z9gUDYMUmG0BI7e18bltWBaQQzSflkgqfQxt/X9Jf?=
 =?us-ascii?Q?sbS9GGyD+l/y6G90ohJp6huDYw4o8SpArRDBF8Bht1ztRgVV4P7S5E8ZWLA+?=
 =?us-ascii?Q?S5iH/T+PLpOQ4hgTB6hlGuwvc5DisfguOnUrL6NMIQT+cwCLiQLURwkarH54?=
 =?us-ascii?Q?yW9MrpDVC2WpgSCi+eaMEV45qziDlmpiNVgP4xsaFAqm1h+rwkeBjTlyRiCk?=
 =?us-ascii?Q?5hdluVeUYkmPb01rxD5flmf+yzHdSTljMwzaTD/x/J8uZuNVdxLAP5G2EMAf?=
 =?us-ascii?Q?bwEw3XWmxht3ocldJxlwF+t87yWX0LKp9IidFF74fr0NXkk/qwc6W8K7ppJB?=
 =?us-ascii?Q?TsbWT6n+QO7vULbRgPGFITh5Et7b62Jz69jietkjITqBccab4p5KCenktT/3?=
 =?us-ascii?Q?Sz4lXs8Njaw4r7WUVwei1emasj/k2vm6FmsctPhmY0TNj0XwbJ8YvH2+97NW?=
 =?us-ascii?Q?72DjazKVak1w4A6lya/7zaBFZZuQfbU9/V9yFww/N5IYLBABHRjyBLfwT7PX?=
 =?us-ascii?Q?0yazfiaupE6Qsu0nJWlrrDHNqKCeYGUvJJIHYmI1FvboXnEBB9bbvAoDg/se?=
 =?us-ascii?Q?ISo6AsXO+Js8LT0Bs7QBTPej9xFy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 05:50:50.8425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a896a4-cfe7-4e82-bc65-08dcad36e7dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6540
Received-SPF: permerror client-ip=40.107.95.48; envelope-from=Lei.Huang@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 26 Jul 2024 02:05:56 -0400
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

The purpose of this patch is customize refresh rate and resolution 
for the guest VM instead of being limited by the actual resolution 
of the host.

Although it is possible to configure the VM kernel cmdline to set the 
EDID, such as with drm.edid_firmware=edid/1920x1080.bin, this approach
is very inconvenient for three reasons:

1.Some systems, like Android, cannot dynamically set the kernel cmdline 
and require recompiling the Android image.

2.If the guest VM's DRM driver is built-in, the EDID file also needs to 
be built-in. If it is placed in the filesystem, the DRM driver will fail 
to load the firmware because the filesystem is not yet mounted when the 
driver starts.

3.Some tools for generating EDID files
like:https://github.com/akatrevorjay/edid-generator.git have a limitation 
where the maximum main clock can only be 655 MHz, making it impossible to 
generate an EDID file for resolutions like 3840x2160@120Hz.

The following patches are included in this series:

1. [PATCH 1/1] virtio-gpu: customize EDID for vms

Thank you for reviewing these patches.

Best regards,
Lei Huang
Lei.Huang@amd.com

Lei Huang (1):
  virtio-gpu: customize EDID for vms

 hw/display/virtio-gpu-base.c   | 41 ++++++++++++++++++++++++++++------
 hw/display/virtio-gpu.c        |  1 +
 include/hw/virtio/virtio-gpu.h | 26 +++++++++++++++++++++
 3 files changed, 61 insertions(+), 7 deletions(-)

-- 
2.45.2


