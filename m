Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EDAC52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 07:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZQL9-0002Xs-QD; Thu, 01 Aug 2024 03:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1sZM2W-0007Id-HG
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 22:59:40 -0400
Received: from mail-sn1nam02on2084.outbound.protection.outlook.com
 ([40.107.96.84] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1sZM2U-00005l-Av
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 22:59:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9xamc5qVqNGuwmVvGQGS0rV+PbNsvw36Hts0IeuWVnmOhHd2M74yCwrW6D3+nHyFTugZt9bO3LdBK59lDNJNCnq6Qy15WI9xquugTvsG8s2RUYD6e6kiBWZvvVobED7wlwbHudtJdi0P4nWzK/QpOC7cdRpDUwDzcBk4Xc/XKgos25MvA/Yg4EERdIEvD1JrVQLKzGrNs2kU4A6vgH5meUk4lt9dDuCFTXpp308YBYRBG098aBwPLY85Jjb8AkWINV8uswoX+AmZVhH33RrD5xX8Q/KXLZcD7UQciy5Bj97rYxcXS4a4qK/o0PggvEpXrM69bxP8AUZSeV2SbdxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEyp91BPa1yfxNezhgfvY/5qVTDiZ2g0iNDgBTUTqe4=;
 b=yAirWQDBYSGyE6tXkBYyxrWIdPGOTEDqlN3qJg9RtLNL2RpTaqcIkz5flF7aY5xhMlRmsICNICoNSROyKHZRkxfcqHd5T1Drg/ITF34jjnti4wQJ920OOgQkRNo1FXSzKPf1akj9E8Hlgaym2YAhM1X6IosrA8f9iJlgBT3bzOvURmp9BujG9RQzhpdn+tuU7jdlF8X2h2tyYcN2bti3qWtAgeXu4UEv5qMSY/niumgSD/4KaNbxqbQlaPC8Zc1mF5TmDl9zGL4/0Xgmeahixg4QdpslH8BM2taQNFmYDHN+jCIHZZuHeve8smElAWQoEk9/2u/fgiWGU6AZnJ1Saw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEyp91BPa1yfxNezhgfvY/5qVTDiZ2g0iNDgBTUTqe4=;
 b=J8O1J4Z/c9JXtvwiIBjXssCSjlEMtIkmuNI7xIvSqO0ixAXHwrOrr0mevoYyDJOmDE9HmwJPjtkmUaRpXLjFwezqZ13wZf96JwYnTct3WgVbQfqxJhWcAKGkeok3sTsOxLniKpbwv8ae2BPJFJ0nhUBLh2ArbSkSx592MS6OHPE=
Received: from BN0PR10CA0019.namprd10.prod.outlook.com (2603:10b6:408:143::8)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 02:54:30 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:143:cafe::ff) by BN0PR10CA0019.outlook.office365.com
 (2603:10b6:408:143::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Thu, 1 Aug 2024 02:54:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 02:54:30 +0000
Received: from SHA-L-LEIHUANG.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 21:54:09 -0500
From: Lei Huang <Lei.Huang@amd.com>
To: <mst@redhat.com>
CC: <leihuang@amd.com>, <pierre-eric.pelloux-prayer@amd.com>,
 <ken.xue@amd.com>, <qemu-devel@nongnu.org>, Lei Huang <Lei.Huang@amd.com>
Subject: [PATCH v2 0/1] Brief description of the patch series
Date: Thu, 1 Aug 2024 10:53:32 +0800
Message-ID: <20240801025334.1610-1-Lei.Huang@amd.com>
X-Mailer: git-send-email 2.44.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: bafedf0c-461e-463b-bcfe-08dcb1d54414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vrGc4FHLa9IJ6/P9adlL5S2kBp40/5O5ER5glXMXZCsf+86o69gLs3Ebcmyd?=
 =?us-ascii?Q?JNZ69LtYmD29b0l8tANLdzm678kuzCis6wKcV5CIfJpqLHvJvfLG6rPiYGus?=
 =?us-ascii?Q?+5AOpMkKaxgGpX/IS6Yx8/MrRgTnWYu6R9jOxc63f0cIbTOuBovZxPnczf9i?=
 =?us-ascii?Q?dfIA2IncqsYcDjgjT3ZEZycBTo0FBmMGYvOIN6TACtlNE2KF/ohDsIT4g3bE?=
 =?us-ascii?Q?K3kfAVXBn//DalfAAo9mMawwh6C+Ac1n5kF6oiKt5EqQsATRs2GZZ4IW5Yoj?=
 =?us-ascii?Q?pZRABzzKRlNqQu3ryreLOayuFw9ai0eLTabTiy7fMFbjIU2fsj8r1XIHM5wO?=
 =?us-ascii?Q?ZdyidvMw3b7I3KLFqh/fB6+P2n/vow0ZstYyLg435ZJFZg1Tp7OKpFAFVGW0?=
 =?us-ascii?Q?3A7eTwb2nLBd7+BcoFk50x2sSXX3hklMr+9soyH2mhImWIS79P4CVQkg0JBH?=
 =?us-ascii?Q?qUE+fqPg1IGZJXMO9IsBAYxV5zkv2U7qI/P4my5AW8foNK9A43M/HnpzpW3U?=
 =?us-ascii?Q?a7P0gFYfOBg1NLLsJtVAsUFjt+iMuKYcifz2J52wNT/5cXUUXAba+iVlw0pY?=
 =?us-ascii?Q?DF9Tq5G0sugeY6+RI0PfXPftnFndmdv4pUZ8fm4tCE9sgmPJ9K4ovCva19Ft?=
 =?us-ascii?Q?y7y6Ca5Jqiuj8s6RXZfd2KjPyNqSJ4lrk9y9Vyy9PXMq78SAp0lYyR/46BQy?=
 =?us-ascii?Q?PVfrnkrnBtkqcs4rTXATJJ9pAtTgp3D+jLq/RjEjppdzqPhu73CokGdTDeda?=
 =?us-ascii?Q?94WgblvZqoroPoYKj7SLWHrUEVJrh7VLqPxk+mhb2421/PHBhbPLjuYi/oDt?=
 =?us-ascii?Q?9uLImlDByWddATOjwfYV0W/UCvpiiOec1wQrYBnjBcbQvH8fw1paN4COh86Q?=
 =?us-ascii?Q?ll9URk3rAevKj0HbBERVfleGjsW7mcfCa9pAeUbCAfONdIcOr16awQPEuOfW?=
 =?us-ascii?Q?iCQ930omd178HaAR8x+K8Te1MlirjZR3KTiwghswQC54jfE3xvbkefrTM7HM?=
 =?us-ascii?Q?ZZ01HY3UGznST89N7u0nZP5OGvwjHuTfYeXZGr6Yqcchbkej7miz6dl77dAm?=
 =?us-ascii?Q?VgE1bqaNWTPH5kHdS1EhICkDwKYj2zPy6FCzgvlkUxQ2twyE0O0np3EyVyYz?=
 =?us-ascii?Q?317Z+NtgzXoLiTQ1+hCQhgjsqtOALKIEO4LL5+Jy3YznxVwZ8zX5O54bJxE3?=
 =?us-ascii?Q?dni5P4jd9r1jgKgIbvzlFsKgcWoqgyx3dciNzjVyri80VWr54QDTASojKg7h?=
 =?us-ascii?Q?cwhqxr8eRZZ2XSTE+FpHc4oWw6ZDTRk06XTE65BsdL9G+VD1DISuxBS/075F?=
 =?us-ascii?Q?82LxmGA5kk1TauModtOm09butn38isJccAKZ7SrPiAlFpjNLCcHGxW6OL5Qt?=
 =?us-ascii?Q?m7CE9opFFs3W1WfRoDFq3V0v1Buo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 02:54:30.7190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bafedf0c-461e-463b-bcfe-08dcb1d54414
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
Received-SPF: permerror client-ip=40.107.96.84; envelope-from=Lei.Huang@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 01 Aug 2024 03:35:07 -0400
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


