Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA358EFCBBB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w226Y-00083v-Dg; Mon, 16 Mar 2026 03:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1w2268-0007aY-27
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:10:46 -0400
Received: from mail-southcentralusazon11012071.outbound.protection.outlook.com
 ([40.93.195.71] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1w2264-0007nj-Cg
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:10:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsvJBymVR1bbeOYC4dZ9v42pvYD6F9ajSgJOEU3qd/kVY4Y8hySl3EVC96AEW7FwzU7waMzuD77RTl7U0U8O8dH5aWCiEeuwXYfcJmjwanchmR00u3eXEPlT+F6LIIjSlPKIJhw0afWQusdJNbK1jQj/+ODBcFVeMprFdfNyAeE8B54rbjJioc+M0KdggornBdpFCJDevcs2eoOg1ZG/PKC1DbDPU5y/ERq+/sBfYIAKZg91ORyNxqaErgS9m3IR5kXGsC8kQlST9xGWuw4AtATLXISppVtJ6h4dJmPuMvYEjB7ykmPk8SDah0/tuB+H/rGm8ctAtBlVSLGhL58aYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofsjGDpc7/WvovXEdOww7r8ElCsZH0SUrFtEgRrhk9Q=;
 b=vf7eFlyl79alyZ9vt+zkO0gW7hHRFRYbi1in1ThIOiII0HGRFCUgOnT9Mp+xdzaJygxKf6Fr7Rd6WuxD2wM1G4MFgxcWM4FLndKLe4F0XqG4UjqO+BasJdRfJxBmsoCWbodwsv4tkiOyU2tLZ4Y6DwIiPTrNO5kUqK8N9Oe9HmWFozkDcm/aXjb2eJxL1+zdmqlPajAoGR8Kqm000Jt+QiNPutK7YarzeLJrmtXKMG0XgvW/2OmvqmvAHuKi5jt7WDTaIiRdNmQG2ePTHtb0UqSQ20BIqSyw2KVniYhi5BC09LaxuOlEa9Vm4IznMPXuVo+VbCHnxQpN0mitM9XLNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofsjGDpc7/WvovXEdOww7r8ElCsZH0SUrFtEgRrhk9Q=;
 b=nluPXW1M/UGkf6qlkxZ3PW7L8bR6HlgRDckw/ZdvyPYTxk2rxpOoNjfjEqXfPxBQh/8AYOUZej/kCfmdcA6trO5eCJUKNT6G+AhnvaOliGdUc++dd/CPeurSJbhAyUFuxwh0Yx2uLQ/loJPH972TCGZFLGqRIt44dvItAQnQAGA=
Received: from BN9PR03CA0316.namprd03.prod.outlook.com (2603:10b6:408:112::21)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Mon, 16 Mar 2026 07:05:16 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:112:cafe::34) by BN9PR03CA0316.outlook.office365.com
 (2603:10b6:408:112::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 07:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.0 via Frontend Transport; Mon, 16 Mar 2026 07:05:16 +0000
Received: from [10.143.201.178] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 02:05:11 -0500
Message-ID: <7d8ec79f-e042-4253-b164-77c43f3ee049@amd.com>
Date: Mon, 16 Mar 2026 12:34:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>, 
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <clement.mathieu--drif@eviden.com>
Subject: Re: [PATCH v3 3/3] amd_iommu: Generate XT interrupts when xt support
 is enabled
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Vasant Hegde
 <vasant.hegde@amd.com>, <qemu-devel@nongnu.org>
References: <20260302115130.5903-1-sarunkod@amd.com>
 <20260302115130.5903-4-sarunkod@amd.com>
 <2c022a3c-f0e0-42be-a946-760a6e938de5@amd.com>
 <6bb7196c-3f0e-4164-ae3b-fd780c40c933@amd.com>
 <a04f4989-20b9-4bf0-b69d-350bd5982394@oracle.com>
 <a5fb1eef-2602-4333-ad9a-cd82f90c4d71@amd.com>
 <e9d191dd-e988-49ec-844b-3267a837b5fb@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <e9d191dd-e988-49ec-844b-3267a837b5fb@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8e038b-00c9-4d5b-bd53-08de832a6093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: 66c/XUegCM2/nbYLfzi26uo4JxYF0UMUjYsHncnNVpmMmsOvxwNQSz97lPfBLzrtiVeSSuOfs7cthf455vn495BiSKnA5uCrZGKc/ncDCN7NHt9jeVh5PdmX/zn/qY8YsnIki7TQiZjRRw+/rvLpNGDPovJkSpoca8e4hpKv5f5VNplfC6HLmeUj+zLihMDGqNkIwKyYokvOragCKBBa7XIoamDiVnxqtlH8dlnssLXwoSkbizbWbwMcru1Ru5MXF9+e/mVjRopkL+IO3Bf0G5HTCOfLkMLhyHHVWB9j23nCjHdqIvUvpOP6gEzbWWCjoxsJijMyE7cMY4NfpR6hUYZ0MKOyuHHynbmTu7ie0dmXndh9E0MuuzFSfyQlKUCuYcPjyRHHPBYB/xPPlo4OW4Epv0wkhO5hm+CrgFzFr+8+B1oI//cjiwVV6YFpxMdIJK4Ou6+v0kvbi95WkAF33kaDivh9y61mymGQ4mo6oUbiufHzeZ9vTV5ZV00JjEZUcu9B3s049IaMFzbCgotoS0md5j4s364qolXVk2XkEhQkxPQevpPivX5kDqlzmVa3a5FQQG+ZKybzitKkUOn2k2pNBFeMMulFQHdB+8jIH9EbmDhhfh3KsLUMI9cS3R+MQQvqH9PGjhe2wx5HgYjzPlT5Rjc571wu07pEqgRSorA8/UnOqjVgwsuj1pSD55tRReaVjyOUhWo9ofXYmTWAoZyon528BFDtX1A1QIcNfnBQ4PkzlsPav6gQi+1ZnmR3SgyuGWJXoG+pt9KRAhcMkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QGz+iyZwwjoaG/YpSMcXlFr7/JsyXmpfr+gv5QUGpWoJq5XeTygDvRcm0kLIiFz+a4Iek7+0HIHfpuMgo3leJH1ARYENs3aRzKZd3KLRBwqqKaTu6YHMC7VC0bZhS94YxfEk3tZQIZy01uOSm6SClcqCdA0ijh9YJyTM9c4Cy6KxDWPwDFtbDn3MCh790Z6ibgmj8RwPOTd4n+vZubY7ymI8X7qMcrD7B3FLFud04DNEtxhD4scz5EInzkeq+SkNI9+fnjf7aeIp78n6uzd4JyCiNmbXDu92RWVbvJtIZ1ccef/ZO+a+xnh+5Cjk0jOoicWB8zSS2UvhgOaLw4MbbiLmNLzXRzsPiGYGXdzg3K5DxGleVDZ51pFuAB4XcRD7zA5vTGFthGTC8eqratuvvkELIgC4ZD6cCVKWb/jn0ymK13whtVgK0FMjRsoN03Jc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 07:05:16.4920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8e038b-00c9-4d5b-bd53-08de832a6093
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
Received-SPF: permerror client-ip=40.93.195.71;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

>>>>>> When MMIO 0x18[IntCapXTEn]=1, interrupts originating from the IOMMU
>>>>>> itself are
>>>>>> sent based on the programming in XT IOMMU Interrupt Control Registers in
>>>>>> MMIO
>>>>>> 0x170-0x180 instead of the programming in the IOMMU's MSI capability
>>>>>> registers.
>>>>>> The guest programs these registers with appropriate vector and
>>>>>> destination
>>>>>> ID instead of writing to PCI MSI capability.
>>>>>>
>>>>>> Current AMD vIOMMU is capable of generating interrupts only through PCI
>>>>>> MSI capability and does not care about xt mode. Because of this AMD
>>>>>> vIOMMU cannot generate event log interrupts when the guest has enabled
>>>>>> xt mode.
>>>>>>
>>>>>> Introduce a new flag "intcapxten" which is set when guest writes control
>>>>>> register [IntCapXTEn] (bit 51) and use vector and destination field in
>>>>>> the XT MMIO register (0x170) to support XT mode.
>>>>>>
>>>>>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>>>>>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>>>>>> Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>>>>>> ---
>>>>>>     hw/i386/amd_iommu.c  | 47 ++++++++++++++++++++++++++++++++++++++------
>>>>>>     hw/i386/amd_iommu.h  | 17 ++++++++++++++++
>>>>>>     hw/i386/trace-events |  1 +
>>>>>>     3 files changed, 59 insertions(+), 6 deletions(-)
>>>>>>
>>>>> .../...
>>>>>
>>>>>>           /* update the flags depending on the control register */
>>>>>>         if (s->cmdbuf_enabled) {
>>>>>> @@ -1732,6 +1762,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr
>>>>>> addr, uint64_t val,
>>>>>>         case AMDVI_MMIO_STATUS:
>>>>>>             amdvi_mmio_reg_write(s, size, val, addr);
>>>>>>             break;
>>>>>> +    case AMDVI_MMIO_XT_GEN_INTR:
>>>>>> +        amdvi_mmio_reg_write(s, size, val, addr);
>>>>>> +        break;
>>>>>>         }
>>>>>>     }
>>>>>>     @@ -2382,6 +2415,7 @@ static void amdvi_init(AMDVIState *s)
>>>>>>         s->enabled = false;
>>>>>>         s->cmdbuf_enabled = false;
>>>>>>         s->xten = false;
>>>>>> +    s->intcapxten = false;
>>>>>>           /* reset MMIO */
>>>>>>         memset(s->mmior, 0, AMDVI_MMIO_SIZE);
>>>>>> @@ -2452,6 +2486,7 @@ static const VMStateDescription vmstate_xt = {
>>>>>>            .minimum_version_id = 1,
>>>>>>            .fields = (VMStateField[]) {
>>>>>>                VMSTATE_BOOL(xten, AMDVIState),
>>>>>> +           VMSTATE_BOOL(intcapxten, AMDVIState),
>>>>> Do we need to increase the version no?
>>>> No, because we have introduced a separate subsection, the older and newer
>>>> qemu are compatible.
>>>>
>>> I thought that was the case because the changes will still be part of the
>>> same "release". I don't believe we guarantee migration compatibility
>>> between random/intermediate commits, but...
>>>
>>> If we are going to follow the guidelines strictly then I think Vasant's
>>> observation is correct. The patch changes the layout of the subsection so
>>> we are in the same scenario that lead us to include a subsection to begin
>>> with.
>>>
>>> Because the two new values are still part of the same xt support domain, I
>>> think it makes sense to keep them in the same subsection and the simplest
>>> way is to do:
>>>
>>>    static const VMStateDescription vmstate_xt = {
>>>        .name = "amd-iommu-xt",
>>> -    .version_id = 1,
>>> +    .version_id = 2,
>>>        .minimum_version_id = 1,
>>>        .fields = (VMStateField[]) {
>>>            VMSTATE_BOOL(xten, AMDVIState),
>>> -        VMSTATE_BOOL(intcapxten, AMDVIState),
>>> +        VMSTATE_BOOL_V(intcapxten, AMDVIState, 2),
>>>            VMSTATE_END_OF_LIST()
>>>        }
>>>    };
>>>
>>> That change is on top of your current patch. There seems to be precedent
>>> for this based on my search in the git log. If you are ok with this
>>> approach let me know and I'll apply it, no need to send a new revision.
>> I am not sure if it is really useful here. Because without this patch
>> xt-support will not work and migrating from vm which only has first two
>> patches to the vm which has all three patches does not make sense to me.
> I agree it doesn't make much sense from a practical standpoint, unless we
> are bisecting a migration issue, and we don't want to fail between these
> two commits.
> But again, adding a new field to the subsection does change the payload
> that is sent "on the wire", and increasing the version like in my example
> above is the minimum change that keeps it all fully correct for migrations
> going forward (just like we ensured when adding the subsection in the first
> place).
>
>> I think we should treat three patches as a single unit, let me know what
>> do you think about this ?
>>
> I considered just moving the creation of the entire subsection to the last
> patch, but I think it is unnecessary. The approach of incrementing the
> version ID above doesn't have any downsides other than little additional
> complexity, and it is the "technically correct" way to do it.
>
> I don't want to introduce new subsections, since that has basically the
> same effect as the method I proposed, and it makes more sense to keep all
> of the XT-related fields in the same subsection (appropriately named
> "amd-iommu-xt")
>
> So unless you have any correctness concerns, we should go with my initial
> suggestion (actually it was Vasant's). I get the usefulness is limited, but
> it is the proper way to do this based on my interpretation of the docs.
Hi Alejandro,

I don't have any correctness concerns. I was trying to understand pros and
cons of this method. I am ok with this change.

Thanks
Sairaj



