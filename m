Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AD2CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 02:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRhMO-00041T-DM; Mon, 25 May 2026 22:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wRhMM-000417-2v; Mon, 25 May 2026 22:17:34 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wRhMK-0004LL-DS; Mon, 25 May 2026 22:17:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuPoCTym5u4Oc8wXq4Kb/wGmUa8gjMprhwMK71TIb8vA8PAveuWq5l1FW5YTCyNH2BFmUPQxkyR3ABI7alJl8OEAp/vOKTLGfQ7Q9uCR43TI0fzeH39jDuM2MLYkKeOBuV/1S5wMO6BX9DCToMclVhKZUK6ZTeVWy9VIODfZIM7/S9CiR6C6Gt25ZQ8UQe2DLpQa3QqLyrgYV3BXyBR27/Oo8XCG3XPpC0fNA6J8ZZyF6ufSbiDCY2O3eaiI5bsu7Ke9LEgiapOwOzeBJWd+yexfoWhox612fkf65WRKhAxR6u8l9ttCVVv+LODcvKSRT0VzkK2AMgR2peEgzzeIoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SE4ol2fq3o4hjaNDMUhxlWNOy5Tgu7X42DS4WG15FNo=;
 b=QhkdICfz22sw1BPzy42e2U5Roh35A8ScUK7EzEIXLCHcFwnmX51W7l4bWwal2NhovL1znj0oC7gKHgV4Ev39ADHl22xFn6xZpH2L4UT4QbuvFUqYRABJY4PRMcnCIRk5DBnHxHAckndpIxhSOtw2bYYyEtnZHSPkApBhdE+ALyupeiJbnYPCblHP8Fg9yFOnsEv4tMsBAj/cn5MIegLqPZESG8x6qo2KHM7rHJUPQH2XY6+guFZgU1QUtELiLbZfS8CIgkQsJMiDSJFxtaPfG3nOnhmf4ATIG7ftD2SvJU80HddjuVJ06yPiAJs5Xtu0sjFPdbCNfZZ4iIwVrgTPpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SE4ol2fq3o4hjaNDMUhxlWNOy5Tgu7X42DS4WG15FNo=;
 b=pcZeoCaksZC1Gv4xTrFaQMJKnNxBFKjhk457/XbRRVYW1GO5TzEgcPYT2k4VJdXYA9yZydwei2Ows/sXuv2ZVjeQNp2qI8ghV8OnyZ2qX5eHPfPd34nzHJv4uqttXQXSvihPZhHGw9BST69n1Wlgz3aFGP0edOQGC01/KAyng1T6bxATBcVaby5ogg20tRrrKpnHrlP/VtZeiHbXSsbDpQUK4waXXgjwOKK7XtMDHVEuqF55tKM36/IJ3Vd6qRh5bci77QSzjMMNZqcs65My0s6/vnpgG+d9TXTQ8CIGfJ3dYLGC6Ud9zMPmmeJ2ciVDr7jYGyMwHmTVEGHccv/X0w==
Received: from CYXPR02CA0030.namprd02.prod.outlook.com (2603:10b6:930:cc::19)
 by SJ5PPF7B9E98CB6.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 02:17:23 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:930:cc:cafe::31) by CYXPR02CA0030.outlook.office365.com
 (2603:10b6:930:cc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Tue, 26
 May 2026 02:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 02:17:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 19:17:08 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 19:17:08 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 25 May 2026 19:17:07 -0700
Date: Mon, 25 May 2026 19:17:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: Re: [PATCH v5 16/32] hw/arm/tegra241-cmdqv: Emulate VCMDQ register
 writes
Message-ID: <ahUCoZKjYiVaTf8L@Asurada-Nvidia>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-17-skolothumtho@nvidia.com>
 <73b4f204-41d5-4997-8d02-5fc9ba3d0c67@redhat.com>
 <CH3PR12MB7548A230C9165D12CDD2EEF2AB012@CH3PR12MB7548.namprd12.prod.outlook.com>
 <2d49ceda-4416-4044-8323-18104cc52e1d@redhat.com>
 <CH3PR12MB75488280F37BAC8F152671E7AB0A2@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB75488280F37BAC8F152671E7AB0A2@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|SJ5PPF7B9E98CB6:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6be500-0860-477d-3352-08debaccec25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|56012099003|18002099003|6133799003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: NMIZ0U3O3qeeIZog7L3zxFiTa8Etoy1qjsFimUftIxKcJIZXb/N0iJG4uHOWVz6VV56b8RFiU37rS/7tHgX4HWu6FkQDQw2QoXPrn2Ko5DMAH4E1qTIDvsOtPgXvmWztD50nU0Yl9vGHGcJYH3jo6+911XhamWzWizZU2pofeue77EOi5HAtG7ZByUs2nYU/DrkQs6rfKmJbk/97UcbtIGW+uvrbWCjVQG9w+lWhNh4sB18zQSf1YLbFSLHR7zqRvetq22Z2yIOXqzTcU6pumBWInkhQl4isclsKpasNSUfNjyX3aVn6wH3sdlzoL1q+G/EytwrJbUlZLndk3vXai+5yPlIPy6z/2pq5pw5smAZaPDeqiDLYM22cn10/A4HJw5MmgGSG9/KXD8vyKHqVs63U9zi4RIOZjcGxSXSNV32RSlkU+krgau8fY8//n58ICEcIuxIkKRZ6ZCtGkqYbbqyJzUClQceuIRQp1kgxb5+NLBN4utCDm6PCDGTcbeg37R3cGELuzYVdgaJp5Ot+nMtpN2jG+K5SYxaOPj3q9TVptA4Rb2SyG3tTcNXC/6PxLGgzYk8QCWzeB2+g7fCWlS4lMsqdsRg0ZxV6kUk9PNdl+DyU6OwCS1hkPyxPsaagXE0j21AYfZgz6D/fgPPA3VUDSmD7sDLqhz3vkxLqdTP0lb/jYcvOhnQWLpjlcH/yaWkouxqnKX1AAxSZ1CkctsLHL5O+efck3ad0h8X3jko=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(6133799003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4VBWamwS6yhMSiuZ1wBUpHvRU9WDUmlG+uRZ5bswIAyVOd2oBVR4WmL9u+Oooc6O2ZmcOHvCj5KwkabVAI9tPRUB4USWimag1D3VmGXe3sACPKSlVQS4Dx9DktUHFxM9FGoRlZ+arnZA6X3vAOe65/yF0Smz0nvll56T1qwW1qhjBliJX+pY/1C0ymRoQRUsQCNngwdysbrurI68eSh5j7R8DpA5y0Rg4uHjepiot5du2YYv1FfLUOgAoteH/ToyCNAEuRSts/jKObu6LduazQU4I4xM3IwkMxdeNA2Lr3p5nJJ5TibwIqKPgZOsQtQ5qvb3ImMV8VQ92FUkzrdXT3ugTytoA9PxZOBXKBfl92qaogmE1NMG0l6ubBFNcFZmvcOy9fn13//+vWyi9DptPp6uOU7eQIxSesU41VHGTi5owsWJAlmQH4DwKrRb77GD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 02:17:22.9524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6be500-0860-477d-3352-08debaccec25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7B9E98CB6
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=nicolinc@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Mon, May 25, 2026 at 10:29:36AM -0700, Shameer Kolothum Thodi wrote:
> I did a hack to the host kernel driver to see how the HW behaves if we
> reprogram the BASE after the VCMDQ is enabled:
> 
> +       /* HACK: re-write BASE after VCMDQ_EN */
> +       {
> +               u64 orig = vcmdq->cmdq.q.q_base;
> +
> +               printk("%s: Shameer: re writing base after vcmdq enable..\n", __func__);
> +               writeq_relaxed(0, REG_VCMDQ_PAGE1(vcmdq, BASE));
> +               pr_info("Base : wrote 0, readback=0x%llx GERROR=0x%x STATUS=0x%x\n",
> +                       readq_relaxed(REG_VCMDQ_PAGE1(vcmdq, BASE)),
> +                       readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERROR)),
> +                       readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, STATUS)));
> +
> +               /* Put it back before something tries to use it */
> +               writeq_relaxed(orig, REG_VCMDQ_PAGE1(vcmdq, BASE));
> +               pr_info("base: restored, readback=0x%llx\n",
> +                       readq_relaxed(REG_VCMDQ_PAGE1(vcmdq, BASE)));
> +       }
> +
> 
> From the boot logs, the HW accepted the BASE rewrite:
> 
>   [    1.504735] tegra241_vcmdq_hw_init: Shameer: re writing base after vcmdq enable..
>   [    1.504737] Base : wrote 0, readback=0x0 GERROR=0x0 STATUS=0x1
>   [    1.504739] base: restored, readback=0xfa000013
> 
> So writes to BASE after enable are not ignored at the register level.
> But I don't think command processing will work if we change
> BASE on a live queue.
> 
> From the QEMU side, the current setup_vcmdq() frees the existing
> hw_queue before calling IOMMU_HW_QUEUE_ALLOC again, otherwise the
> kernel returns -EEXIST. So if we allow BASE rewrite while the VCMDQ
> is enabled, it will trigger a destroy+alloc cycle in the host driver.
> 
> I tried removing the tegra241_vcmdq_enabled(cmdqv, index) restriction
> and rewriting BASE triggering a setup_vcmdq() again, and the guest
> ended up with:
> 
>   arm-smmu-v3 arm-smmu-v3.0.auto: CMD_SYNC timeout at 0x00000023 [hwprod 0x00000023, hwcons 0x00000000]
>   arm-smmu-v3 arm-smmu-v3.0.auto: CMD_SYNC timeout at 0x00000025 [hwprod 0x00000025, hwcons 0x00000000]
> 
> I think it is probably better to keep this behaviour (let the rewrite
> go through and surface as a CMD_SYNC timeout) than to silently ignore
> the BASE reprogram.
> 
> @Nicolin, thoughts?

You're asking about guest writing the direct MMIO space (trapped):
VCMDQ_EN and then BASE?

If so, yes.

Nicolin

