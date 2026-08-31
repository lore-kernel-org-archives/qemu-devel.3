Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF67CC61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0xHC-0006vv-2S; Mon, 31 Aug 2026 04:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1x0xH9-0006vY-RP
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:21:56 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1x0xH8-0007cT-07
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:21:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdPZzGduCoL8g+HQPckQUUhdA44nZDkhq7pAaGyLn2OXswA0vno7rJvBvoPxTSCq4Dtt3Wpr1bcgp5AsceVXPnMe8IyrEneaclGEaexEq/zb8bwq//6ggDPUlHKq00AeF4F3nouIR9GE/9w71Q7r6n5SVKT5Ymw2XE4tBk43YL/KwJ1e19Q/5x9U5YS5MLfJTXeinQ/wpZaOaw2WI/RD1C/GHetLfQJihlgRjAzEPfbXK0ZoPFmyB4qp0ps3ut8N08krqQwvJwpauhqe0/ShP4C3o9S3wLfztR7UWkEXdDpub/XmKiAZHH31CbDo8XzJHJ7pgvJC16I5IaMefcJGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyGgcp0NLuDRV8iq4ckl+8VzsGmofEoFFYas7ohuW1Y=;
 b=RnSiiFXfng86I1yD6oSTefP5uU5GEJw4MVS5i/4agO1VpLFdQUvJQLTgOw7+FNauczQFBAh0FEVmkdZN5kzcav8bAdOpljjtJuSU7wjW0eRb1xdy0EtWndoYggu2RwAj61tqOk55L4NEbEzgS0IxCiG85DqjqCh4ew7dlJ/AROe57lebPiquZRl5yCphwZ8g1ockTLdXM0NjycxQAoZOx80LwDHfAp5nrdOWz5XI6tBoaenpf8MfYt1wttUbN35F1esldr2r6QZeLG23E9zYpHYsTO10CGo2ep0m3YBO5SSYI7hSwLac/LIWZf90bztCwpzHbKKi4ovX5yvrt1Xhew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyGgcp0NLuDRV8iq4ckl+8VzsGmofEoFFYas7ohuW1Y=;
 b=KlxKZHay3PEWa212gEYjI8N6JdPdxYOw96BeNEirjYCQ577h1SUKKtxXmrPfw1JdEZRRpKSPVnPdWv6VwKXzQOGRHV5V9ga7qWDG4o5IBYivHzSub47ab1lau73d+3FMMhjzmzpnPYeLSA0udF4YwKovsjs7JJUVKgwdXKEujrU=
Received: from MN2PR01CA0053.prod.exchangelabs.com (2603:10b6:208:23f::22) by
 LV0PR12MB999068.namprd12.prod.outlook.com (2603:10b6:408:32d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 08:21:49 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:208:23f:cafe::15) by MN2PR01CA0053.outlook.office365.com
 (2603:10b6:208:23f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 08:21:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.0 via Frontend Transport; Mon, 31 Aug 2026 08:21:49 +0000
Received: from [10.85.43.97] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 03:21:44 -0500
Message-ID: <562166dc-1b95-4d78-a9e4-f95754033f50@amd.com>
Date: Mon, 31 Aug 2026 13:51:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <mst@redhat.com>,
 <joe.jin@oracle.com>
Subject: Re: [PATCH v2 4/5] amd_iommu: Make extended feature register read-only
Content-Language: en-US
To: Dongli Zhang <dongli.zhang@oracle.com>, <qemu-devel@nongnu.org>
References: <20260724223216.108667-1-dongli.zhang@oracle.com>
 <20260724223216.108667-5-dongli.zhang@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260724223216.108667-5-dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|LV0PR12MB999068:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c66fc51-c116-42e8-6b6d-08df0738e765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: fYaorkezeVOB2KVJWssMddUz8QRom08J4wGS8qSSdaXQ209XIvm+8rjUvKskAygmnfKqbcOuBFNe/y8LinAWA3Ol6lh/oPYOfGng8SwcbkeMZ5qosYMbKjMekCdANTmjN7nTLflsVQFY31lP6n4hN4EqPitPuUq4BeBxhiyPsCuNcXWf8MDpPo3AjR61FgO2t0Ug9mmPTGTc3lir0HoCOl8MtONAtlUjqt2gtW9TlXBioM09Svg78ad0M3CNUnAku6CAYSFs8YxMlxFbjw/wv3OIYtxEFSAIboNB4wk9NhR8ATbznY49979x4WOrpyCwuYNxye/cgQi7kuOBVCFVuNpgsgELzu6uIfLHa6jCJrLik1eDo/uPxxQCPRtR28pJG1DlEocXfq2/OIpdTTjF3DffsknF8tmuUr0WwYX047ZVvoqxZ4QHSVf9wnEQU8umSgAu1n26RVvjsuhM3coU6bBAeLxEz6CvlPPRXP+a0Oyr4hc2jVTSVNCnTPdCdVRRFVW48+P5R8pQuHjOv8ezH+wK4u7tzEsbNlXglIBeo3aOxaAA3Y6MKVkuSdjCw4EBvNcus2BPpx3t+Q5BBpAHNsvImO1sGCUxTf67Rfau7M6Vgv7kVq5pxyIIuCNx+UGdwo4rxC/fIXa+BqyfKpcBDTxAnToLPpNqk/zhelULShw2k/PaejIAQPhHzKpphFC7H3TfGiEeVqDlZFDXIRcMFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Gx2zh0rP6jMgUj0y/k6nk0VuGzWzNrP8Qjo7mP01CqLLAnzpKETwtbrPyq0OaVg6kIAB9PYbGOJaFyl7LYqYTvaCluUdvjVREZRzy36S9u5BkmiDiF0rQ1ssAVenfKaQEmLFhoLMGgqDfTr9A2saTZQD2hRp2ZZ1AtuAxSyDTjg/iffRYTMRyMgD7usfoJWvLl0qeXpCIttaxF9OmQ6avpDdGnxSM0CXhNKYvTaa1ete7Va2oKE0rBkWecVI2RYHJCQ7C/W7wLJkBTcO1PiGLIctQCldUV+tfJyOUk3xqn/Yqut0TJpNktt3XEPJ8ozL6+tnQw2b5d4LIbmtc4AcZtOug6o791fNKZDlN3pZf5Sf8kkm2oDPGtowGYhyxRtI3WWzWBsT4iru7VgBgksKNDk4zqtDO9OrPNf+www8rzOtGG1qIeSArEbu2QP4k3Qk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 08:21:49.1232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c66fc51-c116-42e8-6b6d-08df0738e765
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999068
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=Sairaj.K@amd.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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



On 7/25/2026 4:01 AM, Dongli Zhang wrote:
> AMDVI_MMIO_EXT_FEATURES is populated from QEMU's advertised AMD-Vi
> extended feature set during reset. Guest writes to this register do not
> enable or disable any corresponding QEMU emulation behavior.
> 
> The current mask leaves bit 4 writable, which only allows the guest to
> modify the stored feature value without changing the device model. Make
> the register fully read-only so the visible feature bits remain controlled
> by QEMU.
> 
> According to the AMD IOMMU SDM, bits 25:24 (DualPprLogSup),
> 29:28 (DualEventLogSup), and 37 (USSup) are not specified as RO.
> This commit modifies only bit 4 (GTSup), while leaving the rest as they
> are.
> 
> Suggested-by: Sairaj Kodilkar <sarunkod@amd.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  hw/i386/amd_iommu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index f86e37fe93..9cd510d790 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -241,7 +241,7 @@
>          AMDVI_FEATURE_IA | AMDVI_FEATURE_GT | AMDVI_FEATURE_HE | \
>          AMDVI_GATS_MODE | AMDVI_HATS_MODE | AMDVI_FEATURE_GA)
>  
> -#define AMDVI_MMIO_EXT_FEATURE_RO_MASK 0xffffffffffffffefULL
> +#define AMDVI_MMIO_EXT_FEATURE_RO_MASK (~0ULL)

Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>

Thanks
Sairaj

>  
>  /* capabilities header */
>  #define AMDVI_CAPAB_FEATURES (AMDVI_CAPAB_FLAT_EXT | \


