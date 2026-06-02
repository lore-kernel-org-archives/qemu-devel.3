Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA2ACD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 10:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wULy5-0001gr-G9; Tue, 02 Jun 2026 06:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wULxx-0001cp-Qi
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 06:03:23 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wULxw-0000Qu-08
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 06:03:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxLENcdsDpveB65zYWTLciEfQTWZPC6G1GR9tGV9ev7u0FPniVIXwsOe7p6HpBBPUiahTlFTRxiDCnjcPwsfnku9+No/f6EORfCwCs9facIp/3I0VSqQWl05TDfNEGIE7l3obn5C4oTBwb4J751EbmgH4B/9NM5zoPO+b5rBaLqVCCNYJ+7BsyzL2/SuMW5kHAaMkFvYXMpJlASSYpwcazy5Ujg07LWlh7IZ4AQ+KS3tfwJlMSeBYM255nyEplkrshozB4E8+bgvAhPDpCXs83M5U5awmv0Cbr7IbiZrV080KOU8hAN9Qc/GPudTb8MWfs3di7STyzrPvDtU1/3EQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPAxgI6WnAnoehogrTAGeuOeLNElAzhBP+juyut2Pw4=;
 b=M2FSv2t7ZdofKzdOT6j+h+YrJEmxsq65WjSlHDSq4FIV0gTe61rHFng9+q6QDKcj8udeViTd+N0AC8heouFrP7TJVQZwHxKip2zQrojo/UGzuh+8klO32Q8PYjXNb4PGhRz9QQXyup0GFIHpIpLHTT0G0yu+9KBAaGx7nOQzXrXjlMaNWMsVWbeb52eepQ2IXkHJKhuG++59pFWGwapAuQGFzExHP+mRR/qfGVde91dt6/QnlvchIk/oT/EWj4e64wX/0HF9hTPawzZ1Nr3nwNR9d+eER7lcgWK2Q+bZEpx+ZkoZ2n1Smtb4OEkSz7DbplDRrf3ieoogHRpLGjB9nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPAxgI6WnAnoehogrTAGeuOeLNElAzhBP+juyut2Pw4=;
 b=pv3ySeBR44HjsXS+ZmBxyLzPjlLEWx60Pu63jt22FHgYHhIiGexM/6cQ/XSu4UKGmEEzGbnlHCRgQDTsfRoIrRLRfU65HlScp1S+GL8L11UuBPsWOzog0wVIbFTVeK1RcYn3vtvf7p464MnHYCx8+L8eOepTF3szxpD+372VlyM=
Received: from PH7P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::19)
 by BN7PPF3C1137D8A.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 10:03:10 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:326:cafe::54) by PH7P220CA0012.outlook.office365.com
 (2603:10b6:510:326::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 10:03:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 10:03:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 05:03:10 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 03:03:00 -0700
Received: from [10.65.99.184] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 2 Jun 2026 05:02:59 -0500
Message-ID: <5ff45049-d96e-428c-915d-fc14cbcb5e58@amd.com>
Date: Tue, 2 Jun 2026 18:02:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/4] hw/mem: add spm-memory device for Specific Purpose
 Memory
To: David Hildenbrand <david@kernel.org>, <qemu-devel@nongnu.org>,
 <imammedo@redhat.com>, <gourry@gourry.net>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
References: <20260602084447.1100554-1-FangSheng.Huang@amd.com>
 <39411489-1473-44ad-ad56-392aa27990ab@kernel.org>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <39411489-1473-44ad-ad56-392aa27990ab@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|BN7PPF3C1137D8A:EE_
X-MS-Office365-Filtering-Correlation-Id: 878fd3c5-645a-4751-3721-08dec08e26fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: hbo8D2bxHZxiNfVy6IaG7KNBexFFVnSnCcNtbgMtC2jlc9kbPimDiGPZ4yWLwA4mIYDX7JRc+gJoEFJx9MqwLa3GdyO2Cad6lyIDwfqN7qQOKG7kz10vgTx9MQxhH84DWFWM7mzohdjBQFthxv2VB8Pqj0wE+JGAxlVavup4911SHa+xUgm//jmGhpruvCMmxhe6Yghq0XfVH4Vn/dhmRei2iONbj+kEpZMyT241zuiFLtMlz6DafHCnJSQW0no/XPFGyfEBDZA0H4P3uMYQJOW79GPk6Rx8CldeRZ5ujYdDW9KJosMApf0VKfKpT5zf5S94Qzn1dpQxa0wXCU5SawnZkXh7vQCF8WbmDxaTX8gxkZdk6tNpsf4FGBq3Cz1icaFvh1CtofikWwetjkC3DJAdWRcbgFVVryC6McNzwKA1ZJDyDHTlN1yIoidvCDuRu8HORB6sqRQxPv5xca2AAUzu1JWwGGNVd+hMbM5Q6flMh4HD01EBxS6ai+PJGF5jzxQrunvNojL50VYzR0wYOuIJvBeDWqDRHPZ56xVYAVR9BSbUVOj0Ji4LkLdtXn5VSSS3cubdyQhN0vCJdhlGF2IvWOw8ZESILF8YtBmKwm5ke4ss8oCHqhQckXvDDTz64m08aJ8slwnvgK59FiSM0uzkqLiP3Hz3WMaj7NFKDA998Tn7I1RMqsGLuj5l/BoGAkZt43lsoIlMsOG//ubAMPa3tLIpZxt+tvCU+9X5tXQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RnhCAr/Qf6NQX+HTESqBwYtlC8M92hzcCgjKmmpQLQ3ls3SH26D6DqZO4xPVlgUmQ8gQYr8e9+rGZpz35LyXej//xBXH3ISFa6anTR5DVVZtPXMrLmZC+6Y0dz5wcBPqMC/5Q9F8DMt9ZW83qN4/dLAmTtAyI1KfYscidCUH6aRZID8j4jHyGu6KQ0On6eC8q5rcWnfV+iFWk9yCQRJtq0rjniW+oHCKRE6TI9JhvPk0bWm3d2iogKx5BqIzNZ9/npYbSro1nJNzjRcR8zhwde1gs4jzhyVFRSdEn9oTaxqbRjC9duvgtcK1qDZluEXZIbDBd2cEX0E9WRm4UTtiLckf1S5R4ENI0eA+ZweMR5a13KTJQkx7MCA4r9tz4w5sB11kSSQzoO/iuGcMLhXFpWKgihTBJf0mzzWRJ5hFaihfTqvzKVlfvyCv7BMX0r7W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 10:03:10.4526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 878fd3c5-645a-4751-3721-08dec08e26fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF3C1137D8A
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 6/2/2026 5:36 PM, David Hildenbrand wrote:
> On 6/2/26 10:44, fanhuang wrote:
>> This series adds a TYPE_MEMORY_DEVICE subclass `spm-memory`
> 
> Very nitty: but spm already includes "memory". And I think most things on the
> cmdline use "mem" as abbreviation.
> 
> "sp-mem" ? or simply "spm" ? Thoughts?
> 
Good point — the duplication didn't quite register when I named it.
I lean toward simply `spm`: matches the `dimm` / `nvdimm` acronym-only
pattern. Will go with that in the next iteration unless you'd prefer
`sp-mem`.

Best regards,
FangSheng Huang (Jerry)

