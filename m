Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8A8CD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 04:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN1Rx-0006Ey-HI; Wed, 13 May 2026 00:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wN1Rv-0006Ef-LT
 for qemu-devel@nongnu.org; Wed, 13 May 2026 00:43:59 -0400
Received: from mail-westus2azon11012050.outbound.protection.outlook.com
 ([52.101.48.50] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wN1Rt-0005Z8-Dq
 for qemu-devel@nongnu.org; Wed, 13 May 2026 00:43:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMblIIF/dfTroG1A0S42Sect8s79WUyvU9hTtsdK18lB2bpdJiavFpWu5m0JIyGMnqpBmuHNjhyjcD/uXDpX6DzCWR4miHqaVgxOT1OH1AUl0e1WKuF6hrvSN4nutq+oJ5q5phrO5+6qFyj2jb74rkmwotSBTvv3/shvXDVZFC4gKEkWZz7sB7r8G39CkKKT5IpWVJb900LzPRyM4Y+98Y2bjGcgfnIxRnj+uXoW2SnIQ0tZVNGPSubuapFhroWjlB+sJq6hiGgEQxL40D3YI2ccGjvDr+EP63fWY9OGcNulBYUdQBpNQpgzGe7D+API3GUEBCjEvPmyVhgnFK2YIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhnLGyF1AgmGBqtUkV2sq2GoWJAruyXKwuuy7P9gWyE=;
 b=ma3pcGZbGFBAU8a6GhYz8WQ6+/fZmfNCwUmbbXUzzI/P4e3kqCLkwu+LxxUoZ4zXPMAhF7UcZH2Rr56TXZ8YWMf355mcQtRxamqirJwPgPGvQJu2fMGC44Oehl4VF5NjnA7D64w3Tl3K0MxPxXOazQ7pbe0PX/Fpw1xbWy36y7aOUCa9JuKVNdM9791DmGsQkKLe72irIFyWjKywU17LC0SJwenGDXfulsbOYSmuBYIuLHuxpxTcoXGXl0bwkKR9vbR+G+5BmVe5xvLJEReQUQAc7DOX2vZCP2PwmpjtjNs44tgKXvS3QI7pEzQ3/bLi7v0q04y+dm0BJPHPwV9Yjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhnLGyF1AgmGBqtUkV2sq2GoWJAruyXKwuuy7P9gWyE=;
 b=sRDwnm9sb1D4c1ZxA9WTQP0/LTUdk51D3VlopgHTKujtB6VPO3PraRMOQW0VhEbOvIdtK+FvQTviHvGk7KFRJY+hVt3sEnM5hIUtb1jNn2yJO0TEggna1rURKbsxO2VfuDWo25UozsuagOB6vj291KcYdEUSiw9llz/RuctT1tY=
Received: from MN0PR03CA0009.namprd03.prod.outlook.com (2603:10b6:208:52f::14)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 04:38:50 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:52f:cafe::e9) by MN0PR03CA0009.outlook.office365.com
 (2603:10b6:208:52f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 04:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Wed, 13 May 2026 04:38:50 +0000
Received: from [10.252.204.230] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 23:38:47 -0500
Message-ID: <ddab5f5d-4f5f-42d0-a08f-c3e20ca20f84@amd.com>
Date: Wed, 13 May 2026 10:08:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <pbonzini@redhat.com>, <mst@redhat.com>,
 <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 1/1] amd_iommu: Update command buffer head ptr in MMIO
 region after wraparound
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
References: <20260512150044.334867-1-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260512150044.334867-1-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|MW3PR12MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: d070abc5-5779-4312-1b72-08deb0a98772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: AODyxBgiIBzHdWCzrDIBfdIcGMXY1Z3z1EBLWi6DssBcNsjDh1NxvivJdpfLGWn4DZ1wCYFb1SetpKhvmODHUdrQNfS/r08cLb28S/uENP3949HZQ24ztnbtzP6TRs8j2isHqG7HgE4zxj4WlrQ5GkusDcYBFwjC/k7mffAMrciQGlLSGjxV47gQMDtRf7SKSitp7s3mZiRN6HnlRfVIowtPoOfCEWt8ApXKmHL687SMQp/7pn4YS5beqtM+5GLIVGymYXO0QjwiITHmx8apRHe72WrIidnLf3yc36FObReECyi1TsuuZlVdRXZyCP8cU64Wza45x2rgms59hZjMT2Pvfa9cXL1+026AoXrbGAq1ngBXHEck6/jx+vA8h8MBo5CkA3gfZ2xjr3OFVWsKWJFijD0RLrvCd8wv2yw7a7HduJ6NrpqVtDnogsB/3VfQQ7eLImuOI3QnGMVQDTizdBaU2P0ilWyHmPv/7BS7nbBiTzicdg47Fb/rxp+WUnnkQdb9/WePV9p3KJ/Z1iM7ipFliISgmY1PCSB1xRoj7xy7yA74wnfUI5q2xRiUK0mEUXugkpMfJ/eXfvlDN6a8rgoNkW6cNx6InnDNqkmPZgnzssQ98zXFSKIVminvSlioyHtz+sBPjiFbiUtSN+W545zXoaQNrXlKr+dMls1up3+JhZY6pjnH4Ai1toK/C3xbssTkT0kgl8NwBzKULQ1ZRMfMB0yJ42A8nqqOQCpcJRg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n0/oQR83wYTf/5DNK/UKmYlNvIXOZqw/7ALGRA0lFoYamRhtgD70Ar15cQja+W3JSrAwP4pDtkS7ytdAdvbxD1fXvNc5S+YBdr4F2MRkWQ1jE+XTObGp0LUxjkI2wBBlc7zzBw2U4TfNYtRw//4hKleQOcw4nF3r9z3y28+Alk11s4e7k1incJpPFpVJRkkl/QM+PYmz5+3btsDNQADK5138KNI1Azlzm3EASKqT/oMC+B99q+XJCE6QAFX6+XcNLT3S3vkHVAsr2Nt6O6yCIbFARH4j+acRLO1RFTES/KcsLyX5H6UCWxoUZdFqpt+ApAvIJrxxqMeMVk+lxHo0VnQkfeE4H/s8669xqCdBUGowDv33KeLf351lZCcf1nA0B4cfYY2TxN+Gu4A7dQSdljMDDjc9oGwJ9nLsLorHtV0rXiSUzb8gGfIX2Vkol+iG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 04:38:50.1119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d070abc5-5779-4312-1b72-08deb0a98772
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442
Received-SPF: permerror client-ip=52.101.48.50; envelope-from=Sairaj.K@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 5/12/2026 8:30 PM, Alejandro Jimenez wrote:
> When processing a command, amdvi_cmdbuf_run() increments cmdbuf_head and
> writes it to the emulated MMIO register space before checking whether it
> has reached the end of the command buffer.
>
> If the incremented value reaches the end of the buffer and the tail pointer
> is zero, the loop exits and the COMMAND_HEAD offset still contains an
> unwrapped value. There are no errors in command processing since internal
> cmdbuf_head state is always correctly updated, but the spec defines the
> CmdHeadPtr field in MMIO Offset 2000h Command Buffer Head Pointer Register
> as RW i.e. guest-visible, so it should be kept consistent.
>
> Wrap cmdbuf_head before updating COMMAND_HEAD so the MMIO-visible register
> always matches the internal command buffer head pointer position.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 197e452e3c..5d6a405263 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1475,12 +1475,12 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
>           trace_amdvi_command_exec(s->cmdbuf_head, s->cmdbuf_tail, s->cmdbuf);
>           amdvi_cmdbuf_exec(s);
>           s->cmdbuf_head += AMDVI_COMMAND_SIZE;
> -        amdvi_writeq_raw(s, AMDVI_MMIO_COMMAND_HEAD, s->cmdbuf_head);
>   
>           /* wrap head pointer */
>           if (s->cmdbuf_head >= s->cmdbuf_len * AMDVI_COMMAND_SIZE) {
>               s->cmdbuf_head = 0;
>           }
> +        amdvi_writeq_raw(s, AMDVI_MMIO_COMMAND_HEAD, s->cmdbuf_head);
>       }
>   }
>   

Hi Alejandro,

Maybe we can clean it a little bit by using modulo operation
s->cmdbuf_head = (s->cmdbuf_head + AMDVI_COMMAND_SIZE) % s->cmdbuf_len * 
AMDVI_COMMAND_SIZE; This will eliminate the if condition. Thanks Sairaj
> base-commit: 8333dba7326d89ce180221c4d0c6d34826a9a4a3
> prerequisite-patch-id: df656299f90e928acad39d99e3701c5641e972d5


