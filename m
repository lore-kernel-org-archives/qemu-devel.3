Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F220CC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 22:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf67X-000207-Ba; Tue, 27 Feb 2024 17:40:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1rf67T-0001yf-Jp
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:40:16 -0500
Received: from mail-bn8nam12on2053.outbound.protection.outlook.com
 ([40.107.237.53] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1rf67R-0003Z2-8S
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:40:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcWE7DEMKDsASQKk1Jpbac1wXeeO4/LG964aXQOj5CwEQ5w9c5+fJwuA7v6MV6GCXgevbtxBrwTzSWZceNxm9GPxwbKnXh7MDU3FVOBR8SZtJEJVdoPQ7CkCduq0JRO/0Vcj/07EmPvCAHWAzJvqJNYcmbQyMt2jExaK2VFPOQKhDbkh+vj9EeliTJiBFT0pdC5sMB8lkQhj/mSG+MEbnz8Ty19sStVbMCukkm4BNy/ok73bfPypLf1QwH1VdALOTA9miVJuKq9PioTQvy9xRR5+KZ43Xo8sn/eKJiyd0ZB71Hiwg5ucNmLE/2xGSdO/Brg17w8OLaWLLYiUYJy2WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUD4ZGMFU0i38ZU5gCCcFQkjxFH5k3l43obvPxs0h4M=;
 b=OvoeD69PeGa8tm2sMWlv3865+TNcw1f+dnbTSg0b6y9XORYp22LCl81AAZPoZOuOqG+pQKjgo/KoIP/J/CaZurRLGSpiwICqru5eU3UgHE/z/OEebAJqIIB9A2oqguE30spthE/1gt39ZVILiw+v2h1N2BYB+vHETYioMQUOOtfIWh2IG4AV3i5kfZbnbnKb5ISG+HcPkv0Q2yS3SKPqBB0FvDqMvTePgOMDFnWeryEAuYM0Padz+vnIBtaq4HULbCJx19qZkQQFi5DUFtFWocGnk+207F14uYzm2T9AmUo/XiHWQkvQxJDTJfUJciVsxroEOWUjUkXr1SbiKAqWDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUD4ZGMFU0i38ZU5gCCcFQkjxFH5k3l43obvPxs0h4M=;
 b=3Mzqh36yHsWdKekGsIwo6ptOo7Q3JurPvvHeLU2RSXHG+gKGSn/G0G8mPNO6nM8EadMaZ5ppGmeS3Vy/LzgbQcYPkaUfUfFAqFsRjdBtLNp+BCQ7vVtJmIY4/r+pN68sSUYOtMj0KRbzi/yGqqrbPqaCsxzLyGeW+AZ1WFiBxNo=
Received: from BN0PR04CA0156.namprd04.prod.outlook.com (2603:10b6:408:eb::11)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Tue, 27 Feb
 2024 22:35:06 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::11) by BN0PR04CA0156.outlook.office365.com
 (2603:10b6:408:eb::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Tue, 27 Feb 2024 22:35:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 22:35:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 16:35:05 -0600
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 16:35:05 -0600
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, <jgross@suse.com>
Subject: [QEMU][PATCH v3 0/7] Xen: support grant mappings.
Date: Tue, 27 Feb 2024 14:34:54 -0800
Message-ID: <20240227223501.28475-1-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: vikram.garhwal@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: b6488d6b-4eaa-4465-7a81-08dc37e458da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHfU80uLP7n53oah5NDk7hkgq37wJy0VrCb1kIlFYujp/2vc/Z2rzk7iaYnmO8bDL/H9zyZ9uQTzFXKplNL/edM154W0t6LJBtbkBTjInhb8vJExjsBITNJ9ZsUcDrwN5CFzJnJrqIYPrCAie2ESwOCdUvKBw6EP2gjWmlRqWKfat5/vvCJ52KD3CgQMcF9Tj2eirO+Rt+qAtSHPodWSgsiCp2oU6JJo/MOSx0U72QK/lGpyurB4CfzEPqIskWPCL2XIWLfHpNwmEkmiRoaFU3FqHVpp+CUZbAdBKzfby2NoUS169tmsctU8nrofXlm0ke1Cm7NBvFA6Pe9Ph0EBLCwiej/DWeZYAR5lKXzUy9vZyhysrY+QWU6UD2wCSta6En9o35KKiM6n0CUMCyYOVQWvwFF7lRlfqj2HCVbmGnJGrcRT6Vskc2xZYeD37HXz40YhpylACkF/h1/fgpONT4tlpb0eyc1oPtLpvDJm9DK/RWXfDFm3N6LcxZzg6iFRIQJ3WEu/NVVVhUcLVl2Y4QnNxXRMUxesTxpDNKXd1VgVf3pytHKYnR70LggYl8Wyn/dnWD+3ZeUwL9WP2DnS6jZLgszWGIkb1j3DJ3c1zr8BvPBWiz2Vw98v9BAexH0mrh3dx2qr/KcJ79rPNIlpg62zS6HvphJKT4QlN3w+Ggp+WgnKBYlLm8PTD/j12JGzpR+RzICNpvTIh3k+8Q6uGKJmxZg2tjsYEtBY4o+fAVdNb46ZKrEzwDwfbgchL0qa
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 22:35:06.2239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6488d6b-4eaa-4465-7a81-08dc37e458da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
Received-SPF: softfail client-ip=40.107.237.53;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,
This patch series add support for grant mappings as a pseudo RAM region for Xen.

Enabling grant mappings patches(first 6) are written by Juergen in 2021.

QEMU Virtio device provides an emulated backends for Virtio frontned devices
in Xen.
Please set "iommu_platform=on" option when invoking QEMU. As this will set
VIRTIO_F_ACCESS_PLATFORM feature which will be used by virtio frontend in Xen
to know whether backend supports grants or not.

Changelog:
v2->v3:
    Drop patch 1/7. This was done because device unplug is an x86-only case.
    Add missing qemu_mutex_unlock() before return.
v1->v2:
    Split patch 2/7 to keep phymem.c changes in a separate.
    In patch "xen: add map and unmap callbacks for grant" add check for total
        allowed grant < XEN_MAX_VIRTIO_GRANTS.
    Fix formatting issues and re-based with master latest.

Regards,
Vikram

Juergen Gross (5):
  xen: add pseudo RAM region for grant mappings
  softmmu: let qemu_map_ram_ptr() use qemu_ram_ptr_length()
  xen: let xen_ram_addr_from_mapcache() return -1 in case of not found
    entry
  memory: add MemoryRegion map and unmap callbacks
  xen: add map and unmap callbacks for grant region

Vikram Garhwal (2):
  softmmu: physmem: Split ram_block_add()
  hw: arm: Add grant mapping.

 hw/arm/xen_arm.c                |   3 +
 hw/i386/xen/xen-hvm.c           |   3 +
 hw/xen/xen-hvm-common.c         |   4 +-
 hw/xen/xen-mapcache.c           | 214 ++++++++++++++++++++++++++++++--
 include/exec/memory.h           |  21 ++++
 include/exec/ram_addr.h         |   1 +
 include/hw/xen/xen-hvm-common.h |   2 +
 include/hw/xen/xen_pvdev.h      |   3 +
 include/sysemu/xen-mapcache.h   |   3 +
 system/physmem.c                | 179 +++++++++++++++-----------
 10 files changed, 351 insertions(+), 82 deletions(-)

-- 
2.17.1


