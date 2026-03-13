Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98B4106FD9A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0xzx-00089Z-Oj; Fri, 13 Mar 2026 04:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1w0xzu-00086Q-J3
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 04:35:54 -0400
Received: from mail-northcentralusazon11013066.outbound.protection.outlook.com
 ([40.107.201.66] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1w0xzs-0004Vt-9S
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 04:35:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+GUuFf3zj2+XQGZtc56BVw5XMen+2lheU6h1R4TzbxeC74TShJ5xQ84FL3IfyuIrBieYtFZWIJGLcWmd5id6N9A3CyPJxv8Eov+LKlgx6xF4cqKawwlliGjps/vEJpDMAznkidolsh3e79MvAt863IlmjJIt44HpwNEMs2bVKy+H6lQIWdCBcsazoAMBlj7tsE8zFeJ/EL29dWiYEKewW8raCRUhIEwoOciSH0lrwOY75y5+6vFiER6XAGQvF5EkdcVOoyRuzdygEMpqRnzwpjgJUcyJUQyRgodXBX8H1GzeXWDnoJiYH1laPOUWUKWYs9M/01XY3YeQdVo0HAs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQA4QJOW6fX64TweTzJMwBR9suOdIx6nNvjnPTXBjLQ=;
 b=lMhsfAyNLP+eTDLz5LbZvOnDfNc1YTSErzE5tPMncES3mVKlx+PdX3CCWimeUxpNcJxQG05h4OkzJLwmPIjhRdlB8wYHsbTSa5w/dv3ql7m9EiQ/rhoqsLPDvJ0H2RHO5/1A8s8dlpufRn7eGR3kS+fNNdeGSLoiLV3eItU70asKoO5MUykIwlYLT+slgf4NB/5tUU2QheeeEQ4lnkKiZFcfiQ5j9K4jLj9Sd1sTo2xvGfK/tC3QHKss0TELgawPjdIyIg+PFLydJIwPy2QHiD/LbA3a8r7SxqXGXwn4xr5/RGeBxPm9Ru0oYVyazqY3fh+nJ6XTW9p8ltl7uhJjgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQA4QJOW6fX64TweTzJMwBR9suOdIx6nNvjnPTXBjLQ=;
 b=0nOqh+uj6HPmSXuJ+i2AbHowyrK0qDTJq+WmffKEXb4DoGIiKu7xRBQl/ZBDHencBCAk9cziL3eMuuvTMXpi/doS1R4/4UNy5p+q+BkdhOH64P9NAorwMFuXkvKm/R1OzfDnl5uTfor69hfEym6keZuHoa8N6mRWU/KLZb6B5hQ=
Received: from BYAPR07CA0054.namprd07.prod.outlook.com (2603:10b6:a03:60::31)
 by CY3PR12MB9608.namprd12.prod.outlook.com (2603:10b6:930:102::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.6; Fri, 13 Mar
 2026 08:30:44 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::b1) by BYAPR07CA0054.outlook.office365.com
 (2603:10b6:a03:60::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Fri,
 13 Mar 2026 08:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 08:30:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 03:30:42 -0500
Received: from [10.65.97.79] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 13 Mar 2026 03:30:40 -0500
Message-ID: <4609b0dc-4510-48c7-8190-e8fd5c53b658@amd.com>
Date: Fri, 13 Mar 2026 16:30:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/1] numa: add 'memmap-type' option for memory type
 configuration
To: <qemu-devel@nongnu.org>, <gourry@gourry.net>
CC: <apopple@nvidia.com>, <dan.j.williams@intel.com>, <Zhigang.Luo@amd.com>,
 <Lianjie.Shi@amd.com>, <david@redhat.com>, <imammedo@redhat.com>,
 <jonathan.cameron@huawei.com>
References: <20260306082735.1106690-1-FangSheng.Huang@amd.com>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <20260306082735.1106690-1-FangSheng.Huang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|CY3PR12MB9608:EE_
X-MS-Office365-Filtering-Correlation-Id: dee7555e-d614-4e9f-6d00-08de80dad16f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KpRfi7ywsyvN5MWpVYNoxd/enKf/4hw6abR10s8Acx+vEu5mh7CQdES9ceB+yA3Hpczy5LZBsIVj3+vCfIcyNvZMN8NDO3tJKlndTR1tU1lCRyxHn1/d34mBsJJXGQsG+5PhoDvywZXLtLCDpMlWXqeqUL+GMYlVtx835UVykWWnsYlJviRfRaGV3hi4+TijhpHhTmSMCmFz0YmQ1Ne63+kbeQwEZ8dwlTkzui0RclS98/Z0SzXqNpMPSe/rPlP89d9qZOAZl27ocYokyL5rhaS1RIXLqrftFEhEStD4TuhV65cpemhI7wFPaPUaJq1FMj8kexZw/rdb7zz7I9fzvDJgTntKZZTPt3aTnFff/wM1+5z+XywAJNw7KcQ35UHR+zupMFPGbty4xoElvyLE9RV1jx2hMC4ryfFP/ZtK5Ymmb4510ox1p5O5Wn13L1xhCNKrLv+vbFDLgLKnRxRE6Fn/Nbm99MtkRqqcijO+Y3LyGDrkN/Cuzhb24cWyvtgIL/pd8PgyYmsYrMQhbsqyK+qYs43DqiGDBr3u1J5E8Dx/kqT1zqANx2GZMKUpoCj+0+roFmd8aEWxlGJt2+f9zVLtA8udtDLdyWEvFQQGO9U24EnsCQlcDk34I6uRoZi2IffHDBZozxH79QNKRxhYbFhcLRdr8X/OSeJnvBeu/cO+tygHcUnbiFYK7yEovrHLGnf1FYegnQvPHqfH6lBWgq0GJt7UMHp5IIB+4tIyiboRGV/MJEhkVnx8wBkjIL48/U54X2KFOfVZIxUWwZ3R+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3euWrVRlJf5PXVkaZJor7X2EU0BI3Vs5bhnbMTUv1TZKcRmVFw4sRxwLvBj1nGv95JKxKZMJrogqw9GORvn+winwHXL+w9wEk2r1vp+tfFWSgorAKtv9FNFqDo0LzC7ONxj2iBWZFGFp7Geqfk7puL3XoGdaHN51iIJTIvrePN1aKnDXSExlRmleJ6n1g2y427VZpvgqSzkDsmLbapYhYYsjv/xFuVQ7rbpdMVRPNazJSZd6HO9C2RG3sV/cnVwHAftNXHJ8mQqGH7MNh/TwycTLZ8k8SrP4Obn06hgyd2jf23h8t4chl7TnPSABlVLsoirTf/dseoXIdHOaWzNxejN6bRnRR7RW1C2kzvwK0WoCYKilgL/sb0hZ6mPuDcetp2FU5sPEcFiGE90M6ejbhHL56XoXJVFPj3aSngqnXj212AiZHtkbWicS/w/tzcte
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 08:30:43.6803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dee7555e-d614-4e9f-6d00-08de80dad16f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9608
Received-SPF: permerror client-ip=40.107.201.66;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 3/6/2026 4:27 PM, fanhuang wrote:
> Hi all,
> 
> This is v7 of the SPM (Specific Purpose Memory) patch. Thank you
> David for the Acked-by, and Gregory for the Reviewed-by and for
> catching the hardcoded address bug.
> 
> Changes in v7:
> - Fixed pc_update_numa_memory_types() to use x86ms->above_4g_mem_start
>    instead of hardcoded 0x100000000ULL (4 GiB). On AMD hosts with IOMMU,
>    above_4g_mem_start is relocated to above 1 TB, so the hardcode would
>    produce wrong guest physical addresses. (spotted by Gregory Price)
> 
> Changes in v6:
> - Added validation: memmap-type now requires memdev to be specified,
>    to avoid misconfiguration on memory-less NUMA nodes
> - Simplified pc_update_numa_memory_types() by replacing switch/goto
>    with a direct conditional expression
> - Reserved memory nodes are now excluded from SRAT memory affinity
>    entries, since E820 already marks them as reserved and SRAT should
>    not report them as enabled memory affinity
> 
> Use case:
> This feature allows marking NUMA node memory as Specific Purpose Memory
> (SPM) or reserved in the E820 table. SPM serves as a hint to the guest
> that this memory might be managed by device drivers based on guest policy
> 
> Example usage:
>    -object memory-backend-ram,size=8G,id=m0
>    -object memory-backend-memfd,size=8G,id=m1
>    -numa node,nodeid=0,memdev=m0
>    -numa node,nodeid=1,memdev=m1,memmap-type=spm
> 
> Supported memmap-type values:
>    - normal:   Regular system RAM (E820 type 1, default)
>    - spm:      Specific Purpose Memory (E820 type 0xEFFFFFFF), a hint
>                that this memory might be managed by device drivers
>    - reserved: Reserved memory (E820 type 2), not usable as RAM
> 
> Please review. Thanks!
> 
> Best regards,
> Jerry Huang
> 
> fanhuang (1):
>    numa: add 'memmap-type' option for memory type configuration
> 
>   hw/core/numa.c               | 24 ++++++++++++
>   hw/i386/acpi-build.c         |  8 ++++
>   hw/i386/e820_memory_layout.c | 72 ++++++++++++++++++++++++++++++++++++
>   hw/i386/e820_memory_layout.h | 12 +++---
>   hw/i386/pc.c                 | 48 ++++++++++++++++++++++++
>   include/system/numa.h        |  7 ++++
>   qapi/machine.json            | 24 ++++++++++++
>   qemu-options.hx              | 14 ++++++-
>   8 files changed, 202 insertions(+), 7 deletions(-)
> 
Hi Gregory,

Thanks again for the thorough review on v6 and for catching the hardcoded
address issue — v7 has that fixed, now using x86ms->above_4g_mem_start as
you suggested.

Just wanted to follow up and check if your Reviewed-by still applies to v7,
since it's a minimal change from v6 (only the one-line fix you identified).

On a related note, the corresponding OVMF patch for E820 Soft Reserved
support has been merged upstream (edk2 PR #11964), so the firmware side is
now in place. The QEMU patch is the remaining piece to complete the 
pipeline.

Could you also advise on the next steps for getting this merged?
is there a target merge window? Happy to provide anything else that's 
needed.

Thanks,
Jerry Huang

