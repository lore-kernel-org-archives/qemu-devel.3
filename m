Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60222F513FD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 05:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyO2y-0003xs-6W; Fri, 06 Mar 2026 00:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vyO2w-0003xU-ED
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 00:48:22 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vyO2u-0005Da-84
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 00:48:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=As8vAer9UsE1dKw484WVUwy2lZ9OCNOK4crgHT592kGI57WQ0MzXAXStWb3NZ4zn6+IxKbmCbkdTtLE5Y032czOyfu3lP13TMlmRSxtKY0wIiqfRynNypgjKr9Ivcb0lg6Nd7fuTLa6YtHVPBAELD8QgmYufcDx1HeFDdvYpdGN8QwzdyETcnjZL/iaKUpl2EXayRU3DxLFSBWBCbfAIVvx6GcL9wypeB8hfX2HdDoEJ1IPgUY8qDaGyTt2C3ZJlQX5E2rocXFPve36Kwf0L9vmkXcpHaCE9RlQPeMOpPu7WgrDSitwwHHzbpReaKGqOyOgV5ZljKnNlXPLyrOcBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53wq43cHJoDLWTLNCKVd8jYetPF11SBEL1C8KI3B/wM=;
 b=T4ZwsuQVdpkQC6Zt68B+K5MsB/0XIUkyV6eGhy3I8FJlcdt2FkaZT2EPVCEq7OrPhv424kSI4Uu66jwCWphvMzPcGE2OPNqk6tpk9WWRp3qG8gdm75AyEdiGgFCgiC5jB94316s2XPvhW8V9D7uzapOG7PWp44OBs1qUorHkJ5L+o0TcfapTcs++vB5DpYP7HNHayi/xvHCZ6+UXGE38VDP4Zz+OAUFyHnNFMmjMgz9WbL7zspgNeGbVbwZi65uAnDn8r22ZM8Q4Da03Sskcvj7xzHICR3755BvHHVK++Kjdw2k6+ES4Qm5AeCGx502RiV7nNzDhYGEVWiDjMQH4Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gourry.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53wq43cHJoDLWTLNCKVd8jYetPF11SBEL1C8KI3B/wM=;
 b=oFhWF6dqIOsydRUIFvxYQsgdrQAmM1gh2v+A4PPPypfiXCWdpf4iwctXkZOOR2nxbujns3PkfF0QN0f1YSKBuopB++KGTyP/ICa/wcRuhBj9DKoOfx6Qi9AALP5czkDgVgqdWPzX0XiSGtF1rOFBN3ZZDGNTcEEBZE0+8oxuTkc=
Received: from SJ0PR05CA0053.namprd05.prod.outlook.com (2603:10b6:a03:33f::28)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 05:48:10 +0000
Received: from MWH0EPF000C6187.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::64) by SJ0PR05CA0053.outlook.office365.com
 (2603:10b6:a03:33f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 05:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6187.mail.protection.outlook.com (10.167.249.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 05:48:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 23:48:08 -0600
Received: from [10.65.97.244] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 5 Mar 2026 23:48:06 -0600
Message-ID: <90b8dc39-fab1-48b8-8e34-a7b6a96e4abf@amd.com>
Date: Fri, 6 Mar 2026 13:48:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] numa: add 'memmap-type' option for memory type
 configuration
To: Gregory Price <gourry@gourry.net>
CC: <qemu-devel@nongnu.org>, <david@redhat.com>, <imammedo@redhat.com>,
 <jonathan.cameron@huawei.com>, <apopple@nvidia.com>,
 <dan.j.williams@intel.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
References: <20260226105023.256568-1-FangSheng.Huang@amd.com>
 <20260226105023.256568-2-FangSheng.Huang@amd.com>
 <aanwTUHMIh5cJCiR@gourry-fedora-PF4VCD3F>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <aanwTUHMIh5cJCiR@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6187:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6bfa37-19bf-4eda-5e71-08de7b43f282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: vJbohyur+rOfJ6K9/gEYamIu6m/0RtQCGRYzeL0GILsMYL/KfqRPVnVSlyxa24bxJDnROhncIN54gckGPcnV54AkoRc9a6WqZWp1OyO/9b8k86fl2TtLLDUqr1yD0pdpY1L/UJaNhUUhU7TzGXTMv3keTsqLXOYKwqfMZUVAlJ/OHkmzwE0XhnKC64KHiVvo6gRSos+nsIH7gj7SukCJ6J4gU4CwRVtqZXbh00tXofg1YSswA8rkzAp2gj2yFTAJvPc+HI/F0HHYLLVDOM0UwcHEaOXdosdmlnPv+eiaZOarNJRKGEWd7e0srp0sWuvOt+pXOoNcLRAI6c4KqbGzgNw+rhzLWWNIbKKwBsgvOdoZOltRltKk0TMt1H/jF7TS7fvbLG0w28Lpbs5eMb4s/yp2Dwrbfb+VsaAjp9BnzgCzstiNEeNipZSD6c2jXtbZhxf4IOYqiYUja8JqAoDb7s6HFj/7NmFtM4s5sFfTHRylZcvk37UUBpDZMlW3kyqOGCWa+gi/s8R0kC1wVKagV2USWPL9Bkq8G3si0cYOYTWe+aSUrzfFzqImQ1b00Hk8OlwMEaToa1wgAZ69HX3ofVPpmSSejMvkC16PuBJoZ3782FBx20vycFazz5OEyOvgs/O1EIxsQ+0jVE/MAOOWF5lrAysMLLi0ndA+exwUZBzuv6xKzcSDF9/MzVvLJUt8oTXf2Pr6fPuLXoq1aomP/f56pc1auvsmGCKIWu2QaIIsTPYYpVbTChjzLlW7+yUtVmF1BauaqaKKhroIi0a0VA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vFgpDe5qteQHa6h54WxBvNdO3s9YNmhNnWD4eHTludoxFE7ah7IEfMz6LSRViX0EFQb6X8+1r1My4JcmCdMXwZWurN3S6qzJ++gtvNKkUgi5XAdoLvZWWXAFc5uONc9yAQDrSHx/UHwXHCjYyxal5j4u0Hi8ZSauKGgFylG95cf9vlp8cUcoJxFyFrYW22lFHXP1Yw1N4wEvWPKBm+T5kdXnYQX8IKhTf4e8aB1qtIK+tvB+kBuvwAEpKy/xgn+sZHnm9GPSqdH1NgAaUCrEOfak3pMlDMYPXZMfTR7AWvDEAHAxaOgU63Rx9fKYhgIQ7sldtSNk9dff+UNoLshQ/FKWL52M0DjC/MmQqY2zBjB+AIQWUIPPj2zylWjbp7SVcHBBm02SV4FgNThQJL6NfEdKgLfrDdGUZaWsMwNhArkiSAb+0OhpZwBkwDvt2Xm/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 05:48:09.4106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6bfa37-19bf-4eda-5e71-08de7b43f282
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6187.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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



On 3/6/2026 5:06 AM, Gregory Price wrote:
> On Thu, Feb 26, 2026 at 06:50:23PM +0800, fanhuang wrote:
>> +
>> +            if (addr < x86ms->below_4g_mem_size) {
>> +                if (addr + node_size <= x86ms->below_4g_mem_size) {
>> +                    guest_addr = addr;
>> +                } else {
>> +                    error_report("NUMA node %d with memmap-type spans across "
>> +                                 "4GB boundary, not supported", i);
>> +                    exit(EXIT_FAILURE);
>> +                }
>> +            } else {
>> +                guest_addr = 0x100000000ULL +
>> +                            (addr - x86ms->below_4g_mem_size);
>> +            }
>> +
> 
> I missed this on my first go around
> 
> Should this be:
> 
>    guest_addr = x86ms->above_4g_mem_start +
>                (addr - x86ms->below_4g_mem_size);
> 
> Or is there a reason for the hard-code?
> 
> ~Gregory

Hi Gregory,

Good catch, thanks for spotting this!

You're right, there's no reason to hardcode 4 GiB here — on AMD
hosts with IOMMU, above_4g_mem_start gets relocated to above 1 TB,
so the hardcode would produce a wrong address.

You're right, it should be:

   guest_addr = x86ms->above_4g_mem_start +
               (addr - x86ms->below_4g_mem_size);

I'll send a v7 shortly with this fix.

Thanks,
Jerry Huang

