Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEA3FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHHi3-0008Mu-Ox; Mon, 27 Apr 2026 04:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wHHhw-0008Ly-42
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:52:50 -0400
Received: from mail-westusazon11010051.outbound.protection.outlook.com
 ([52.101.85.51] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wHHhr-00035b-Md
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:52:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1F8sMealRF3SWBVQKqEhRuFA8tGWHWkmQ4S08ot5GSd6dCSQKwDQSRCpksWG8lasrpvLdpGF4OXP8PjqX1+eaLw+zuvdxDArBN4aHMqsS+8wbwiG792ah9tjJmyZt4dom58XD2sV//oBuYIEce125GlQ0pafeWeOmcRObzdurIoPwRw6Hkfo+7F0dpSD5m0vYx1BOG1aRKY9UjfUY8qzhlzkx1YVZgSLVrx1jnDM4usTU7dcZkqBwl5QK9maUwg4NIM6fQ9EVgU9P2GtGeK2ZJ2HSITxGMNDwNfU8YtYiayxU/O+huZ+ZWfuLAVcn1m21AyW1X6nzlkilazYn4tFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pE1t1d6FzyXOe7keeHbd9/i68z31Gs7AB/NnMHjm6KY=;
 b=vWiDyEJ2e3zzBFEBSOlsiO8V/t73/y4hcDqh/RdxUBL4Q1UXauJgSTVC8qv2fVUzjqPBhBMcaw+PSwfyCI9n+yGIiz99oATkOnUfL1FzfYZ/XHX2pvBdDnrPdjvdocWqJHg4KwXhQgvI2R4DRWaE5EgPezZkursx/ggVXWSNKnHLsgYf9T+v6lH4YxYqQFHqHxmOVhKib90uRcAD58H3bH7X7Hb1/0QHXTF5H0lCjc49d3kzp816cTOmGx1V4eeD+QVif61NmFlQTzw1Ki5hlKkYOKUi6dnKS+41qpTGOVyo8mY0jRydtfwET0HsQQNb3SsbDOfOdo6kCncAmLOjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pE1t1d6FzyXOe7keeHbd9/i68z31Gs7AB/NnMHjm6KY=;
 b=yY6KJBRTwgBkmwuw0tR8AkO5mxFSs5/h8wc1PFylwddHMjeMtQP6N+7iK3283A+hZzoU3U1LJPKp7BOhqACM+T0V9km2nKcpydls2kJynXO6NyTWMeAdDnK+Cta+kUK3Toum4fbO6sa3MbzJHWs34N3bcrr02HH/6+qVi4eKlTI=
Received: from IA4P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::8)
 by BL3PR12MB6572.namprd12.prod.outlook.com (2603:10b6:208:38f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 08:47:35 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:558:cafe::92) by IA4P220CA0004.outlook.office365.com
 (2603:10b6:208:558::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 08:47:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 08:47:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 03:47:33 -0500
Received: from [10.65.96.84] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Apr 2026 03:47:31 -0500
Message-ID: <c3b8cd60-73c6-4498-9e9e-facd9c3cfef9@amd.com>
Date: Mon, 27 Apr 2026 16:47:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/1] numa: add 'memmap-type' option for memory type
 configuration
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Gregory Price
 <gourry@gourry.net>, Igor Mammedov <imammedo@redhat.com>
CC: <qemu-devel@nongnu.org>, <apopple@nvidia.com>, <dan.j.williams@intel.com>, 
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, <david@redhat.com>
References: <20260306082735.1106690-1-FangSheng.Huang@amd.com>
 <4609b0dc-4510-48c7-8190-e8fd5c53b658@amd.com>
 <abQquiWHPoVgw-jt@gourry-fedora-PF4VCD3F>
 <20260313161429.00003ace@huawei.com>
 <f43d8a68-62e3-472e-80e4-f018a91d7eaa@amd.com>
In-Reply-To: <f43d8a68-62e3-472e-80e4-f018a91d7eaa@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|BL3PR12MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: 402dd7c4-040e-4a6f-8e20-08dea439a047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: TcjJ3NNDXBRChoROvZ/HKbvoNASQwLOf+wid5f3Y7kQvYHEA7E7ZR1gfpN3Z91+vXCYtNMGKJWdl8BG5ca8I0qIIxzZAGNyLkIZeEFKgNSCk2ZUaKU+Cbypcxl2oeRBNHZDt7Hh7QJpgi+f4Eees6AD3ix3711N19eeuPErwVqWir3RafG5oszixvyAodjv6X35EliJ2YctOkKZrvHHAsYddjGrCoAxhPDmYki85Hoi+UwKKNS/m5iBwq/4xAJSS3WGhVtrD8GfFSxXCA4ITKa02Q8QDmhy4rrLj5Xfn7GMe5nU6t+rG+uV++cGXumT23xEouI7Ya96ZgLLO0lMuA2KWLyVHAwJRbjZO6/mUbNY+CtRmVBDc4kWKC9ijZ6pS05W4t9bOMyhiXlLFOLgTEpwPrGXcFvkqn9BgkvQ+1t0oOBS/Ge1Xmj1CtiONsLUDsMx8f9YZxsQK218rK5WxGO4xd0aZGxIVhX13wWN/ROAWTvN781cvD7AjwyJEOp3EBECLmhAo66vxseFq77O5YBg2vf3braXcRYTAqFKE9Qt3pdrVqXqnYSpLw+UjgKuoQuOeOL+LRfLqk4jWc0YhLr+XUb18M3NXlri6aIWckImh9JLy7OtAVzYQsP8P6LbhG0xljN53LnepdOLM2fA0sfEobvsH9/z/eEM6BdTeup0w2IyYlwjJrzQMk9SOfzxSimoMZN2U7TF+IY1/nPTVibhyH1UTGDhfhAvc5lCE6uM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(13003099007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MQTi2HwP7ztnZmaqlzCIiae/FF78/u/3l3IKKTSiunmlD6gtKLHw0vVEgnZnxgdkSc2fqtsOFyIUVpACD4kjovy64hMAh/Ku0o2EhvpM/rpbTezRkRDghUVDhbJEX2JRjs1XfmvFeA2RAvYZqgi3lwLPNlWh6ts8QjfBISoqxQ4i9GyY+yjgT7Pr2WSdGpPFX0U63DNz/VFi9TiNw+xei64thNnvMcLFIH6fhwFRd3u1Sltz16zj/QIoYYKdmSn/OnDjKHdDUzPPZ95QNXbOfRJQe1rezMUKU7bpoRlWR6gQ9uYtxFCFgoZXnBGyyb6XjIoh97NKDxBr2OQX4syDCW8edpUy6YSYVeoQXTT87gEbZY6yV+xCEBkWC9gMBXh32+RtNgAstOyANErQgEFR/hRDZ67xkiOGSAMo/GWTOMygNQLExZdTRZEqkiO+77qK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 08:47:34.1897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 402dd7c4-040e-4a6f-8e20-08dea439a047
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6572
Received-SPF: permerror client-ip=52.101.85.51;
 envelope-from=FangSheng.Huang@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

Hi Igor,

Gentle ping on this v7 patch. The QEMU 11.1 development window opened on
April 24, so I wanted to follow up as discussed in the previous round
(Jonathan suggested I reach out once 11.1 was open).

The patch carries the following review tags from v7:

   Acked-by: David Hildenbrand <david@redhat.com>
   Reviewed-by: Gregory Price <gourry@gourry.net>

Patch link:
  
https://lore.kernel.org/qemu-devel/20260306082735.1106690-2-FangSheng.Huang@amd.com/

Could you take a look and consider queuing it for 11.1?

Best regards,
Jerry Huang

On 3/16/2026 3:17 PM, Huang, FangSheng (Jerry) wrote:
> 
> On 3/14/2026 12:14 AM, Jonathan Cameron wrote:
>> On Fri, 13 Mar 2026 11:18:18 -0400
>> Gregory Price <gourry@gourry.net> wrote:
>>
>>> On Fri, Mar 13, 2026 at 04:30:20PM +0800, Huang, FangSheng (Jerry) 
>>> wrote:
>>>> Hi Gregory,
>>>>
>>>> Thanks again for the thorough review on v6 and for catching the 
>>>> hardcoded
>>>> address issue — v7 has that fixed, now using x86ms- 
>>>> >above_4g_mem_start as
>>>> you suggested.
>>>>
>>>> Just wanted to follow up and check if your Reviewed-by still applies 
>>>> to v7,
>>>> since it's a minimal change from v6 (only the one-line fix you 
>>>> identified).
>>>
>>> Yes sorry, we're good to go
>>>
>>> Reviewed-by: Gregory Price <gourry@gourry.net>
>>>
>>> Thank you for this, this will be very helpful for testing
>>>
>>> Jonathan would be able to answer more questions re: upstream
>>
>> Can provide general details, but specifics of this patch is probably
>> something for Igor as it's not CXL specific.
>>
>> Soft freeze for 11.0 has passed, so this will be a 11.1 feature.
>> https://wiki.qemu.org/Planning/11.0
>> Is the 11.0 timeline. (11.1 will go up around time of 11.0 release).
>>
>> Jonathan
> 
> Hi Gregory, Jonathan,
> 
> Thank you both!
> 
> Gregory — much appreciated for the Reviewed-by and your continued
> support throughout the review process.
> 
> Jonathan — thanks for clarifying the timeline. Understood that this
> would target the 11.1 cycle. Will follow up with Igor when the 11.1 
> window opens up.
> 
> Best regards,
> Jerry Huang


