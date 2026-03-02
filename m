Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C257CC624C2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwzEd-0000I2-Gq; Mon, 02 Mar 2026 04:06:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vwzEW-0000HB-IR
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 04:06:33 -0500
Received: from mail-westus2azon11012052.outbound.protection.outlook.com
 ([52.101.48.52] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vwzET-0005WT-UJ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 04:06:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIsgtuS4ivnY3jYoN3Lv6V3o0LpaRmIazFZtBgI+6+3bJE+dFKHCzmWE+EbSKdxKcnGSLyKiXTZs2Eigpw6ylwyP/yVSqnw7+CDTci9CgAYLqBRfQ4kWCO0bwaPhs4DVaIu3h1uIPQHWRT4yVvkbTYD8KA0DXMBngGnUzuuRQCgjFw2UU2ok20tYZZRlHFY+KGttaIeZYqAKtiRXm5OBXoBZAVzr6SS7RTkO0nuAElFmyv1dILV4UTcTz+hwR/oGghp/pggg50DIjdgjhJyCwVjj0Mq6r/SqKzeYP9sux1/ifG3iqdpd/C6zUMz6L5zzs1EpOywd6JgnwmXYJOMxpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAkXad9qIFw7BEgbB7EHoGzH/It6En6XoYHZYTGCOwo=;
 b=eWpFk37XBdFz3Q5QO6EJVMyWeyemQrl60/jNTfwVyq7uDBbmUUsUi07QnEhe6ioI4deQ0hO8dKABgnmqPhHuyAdfKpEm9XNNi8feX6ardmmwOxAjpevlUQCNL6UJVgiiVUNOvSy3l6oGFZO5r9RFYUbCU1CLynt4z6Ffpp+Vbps8q/8jwC3Q9cTk6zbS1LlmpT387nwFPTMp1HomPgaLg+gc/r1fOKm3nbg/inI5RurXp1dB9Oj6mH5n8z0c20k45Vs1/ao+DtNfxySLZ/S4nq30jZKijbTXPxt+1BiU+DCUwJH5BKQMqvabMC2iFKlFIZ0QTyAxWHm2viOCf0yChQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAkXad9qIFw7BEgbB7EHoGzH/It6En6XoYHZYTGCOwo=;
 b=0QgRG0DcgSEWWzUX4C4UepwZ/rPgh7IgsX4UxfAkBZAbz6mDX1CRPPCEysCGZEoZvalxobdOu5TvGSrPVgcwt8ImgPlqzgig8tH+3jQ21mAMcvxMxr3d+aojnW2JiHg0NvpdUV9/ncM9tEILMePhRc+IkpBYaBbgn4qRWqShQ3s=
Received: from CH0PR03CA0333.namprd03.prod.outlook.com (2603:10b6:610:11a::7)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 09:01:22 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::d1) by CH0PR03CA0333.outlook.office365.com
 (2603:10b6:610:11a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend
 Transport; Mon, 2 Mar 2026 09:01:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 09:01:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 2 Mar
 2026 03:01:21 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Mar
 2026 03:01:11 -0600
Received: from [10.65.98.227] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 2 Mar 2026 03:01:09 -0600
Message-ID: <f36e249f-820d-4033-81c3-2b172453d1aa@amd.com>
Date: Mon, 2 Mar 2026 17:01:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] numa: add 'memmap-type' option for memory type
 configuration
To: David Hildenbrand <david@kernel.org>, <qemu-devel@nongnu.org>,
 <imammedo@redhat.com>, <gourry@gourry.net>, <jonathan.cameron@huawei.com>
CC: <apopple@nvidia.com>, <dan.j.williams@intel.com>, <Zhigang.Luo@amd.com>,
 <Lianjie.Shi@amd.com>
References: <20260226105023.256568-1-FangSheng.Huang@amd.com>
 <20260226105023.256568-2-FangSheng.Huang@amd.com>
 <7facab80-c59f-4869-a68d-2e61acd15cb3@kernel.org>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <7facab80-c59f-4869-a68d-2e61acd15cb3@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 809dc539-6796-43d5-a698-08de783a469f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: wlqiMw04UIECqUidQInY1FEyTMKeKWBcGf1CKYk+Acv+aUFaI9R4NkuPHnbHJ/PK/2OrHJimlrLlW/BMEmzcL5cy2kG4WVNd3NQ+yhMtL0J0rGuLdd4ItbUHJ4Cq5US4Bcum1i6TFPHip1+tjx8YCt7aXMr8tluya8edWnoDosMLHNMvnEWzeCOw3sQtQ1m3/rkabNJIOebL8tWo7d4U6QLiC77pAzV5AL8J4WrAvIFGDf5pxo7/U73C1fI88DzRNegdFluZwZItm6Dymz8hdTFoYo0ln2wDUATBQ3Cnq0DndZtor28MdaYMVF7K7sMGHed+o6ksLVhf60E635rIdiHYnFQhbYBHo3snVwNt7cTMm23TUFK+vHqjRaXK0BHRWXOa5tBfR8BU6CILiNgeRFfM8ZodveI3c7GzOGxZl3fL8OzJZaqEpYLo5deYA7mzGvamYW6HU1EIovGC5fzQN+a5SaDwo8uuDIK340hCdydWTUt5B9fYPomByBTwBgjpvIR0CdPM8Os2vZRflneQhnokGxpaaAAPeBBbX/s37lEacDxmAmNkk1BVXhlQ/aV0IIbWdpXK9LFx/+44GfvbJTR1umNS7XMo1SB7ZzOEIYiSJGlGUi+E/qSHbLYDAc3vUX+LY7Q3XQJ1lzzqTTPUR0AnAQRgXocsCPoy7rUnSSugw2Hc3hvGvMRsROTIs10R0+6E6cgA4DGiy1+dfbTneOtr89Crp+maaQzMEGEfhZCbZQF33Ffhtbwi7ORfLI3gQUKMj+lt/TEo8YYKoULRKOPl02KB4LYU0OTHn5jTkVo9COW3lTCcYzaLNfPO27kHf8qdMPiMUhK1rIbLj5Hs8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lt/1kKIvoUZqDnU4emOeS76Kk+kotjhYvhVG5oKoqgjRHWy5j7FDhNDEyfeMNzXmiFKVW8y99mNEhH6+OrDhGPtcoUeZ8YZc77x9pjOp8Mkjh4tt3PxNDfdZkVM8gOrDqeKq2kyoux4I1J/0eWsYjlFK8ilOQqnaZvo4AhR3ZT+avhngf69rNmHRFxY8XPnDCgnkrcqqHH3vtRZS6WeyTT8Lry310fQ201id0mZNdvyMmaqB+lmw21+7WqM1EbCyvqy3X1i+lFv4MLhDNhy0/sEzICmbNhsUCT+KyjMvcz7E2i8xsiYjW6nbXbyJml7P7fkACVvax+wrJ6A24H0tyeRXg31XBPzxSbfA5+dQGROn3Kl16OjK//jDNgb2sg5jimo5712H01Yfdvm5wTYKKZyO8eHsG17wJIL1DkKL0MSNx6w5D5/MBRcNPQKZfp3j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 09:01:22.1178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 809dc539-6796-43d5-a698-08de783a469f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579
Received-SPF: permerror client-ip=52.101.48.52;
 envelope-from=FangSheng.Huang@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 2/28/2026 4:34 AM, David Hildenbrand wrote:
> On 2/26/26 11:50, fanhuang wrote:
>> Add a 'memmap-type' option to NUMA node configuration that allows
>> specifying the memory type for a NUMA node.
>>
>> Supported values:
>>    - normal:   Regular system RAM (E820 type 1, default)
>>    - spm:      Specific Purpose Memory (E820 type 0xEFFFFFFF)
>>    - reserved: Reserved memory (E820 type 2)
>>
>> The 'spm' type indicates Specific Purpose Memory - a hint to the guest
>> that this memory might be managed by device drivers based on guest policy.
>> The 'reserved' type marks memory as not usable as RAM.
>>
>> Note: This option is only supported on x86 platforms.
>>
>> Usage:
>>    -numa node,nodeid=1,memdev=m1,memmap-type=spm
>>
>> Signed-off-by: fanhuang <FangSheng.Huang@amd.com>
>> ---
>>   hw/core/numa.c               | 24 ++++++++++++
>>   hw/i386/acpi-build.c         |  8 ++++
>>   hw/i386/e820_memory_layout.c | 72 ++++++++++++++++++++++++++++++++++++
>>   hw/i386/e820_memory_layout.h | 12 +++---
>>   hw/i386/pc.c                 | 48 ++++++++++++++++++++++++
>>   include/system/numa.h        |  7 ++++
>>   qapi/machine.json            | 24 ++++++++++++
>>   qemu-options.hx              | 14 ++++++-
>>   8 files changed, 202 insertions(+), 7 deletions(-)
> 
> I didn't take a look at the x86 implementation bits. The high-level
> concept LGTM.
> 
> In an ideal world, we'd only indicate the property if actually supported
> by the machine. Not sure if that is easy to achieve with the "-numa"
> option. So I guess this has to do :)
> 
Hi David,

Thanks for the review and the LGTM on the high-level concept!

Regarding the per-machine property visibility — agreed, it would be
cleaner. Currently we handle it with a runtime error when memmap-type
is used on non-x86 machines, which seems like a reasonable compromise
given the "-numa" option structure.

I was wondering if there's anything else you or the other maintainers
would like me to address in the current v6? If the patch is in
reasonable shape, it would be great if it could be picked up, as I
have a follow-up OVMF patch for soft reserved memory support that
depends on this QEMU change being merged first.

Happy to make further changes if needed — just let me know.

Thanks,
Jerry Huang

