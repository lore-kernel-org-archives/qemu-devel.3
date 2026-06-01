Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C3DCD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTzy5-0003kj-EC; Mon, 01 Jun 2026 06:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wTzy3-0003kb-F6
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 06:33:59 -0400
Received: from mail-centralusazon11010017.outbound.protection.outlook.com
 ([52.101.61.17] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wTzy0-0005mF-VC
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 06:33:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOSd7YABCNWO8NxSas0J61ad/WOp10FuRjMEsKHya/JLurjoAaPY7ZmgoLJbW0JNsGgf9yZT3n+tZkKzzGsoUMkEq58DZz75HsVXOosZoPRG5Z4ZkY80SV1JNPWbw+n0OVU/4C2KOi4oZw0HfrCzaDDydzfLLSGajL4tsfaIkUTzOO3MlgzimrU13rW00qGcxh5NKrUDRWTGVP2oJ/ZhCEeBjZKXFo4O/ehO9WV1dBH1kohYJe0/28mAAlNc3BIE1L1ZhIj5Zn9SIqUKrdkiEVnlzSP+dkJ5Hu/tcYo4H2e9kivvX3CjOJ6/TY5JD/uHpV4oiCr8+Q6T9VT00R2DDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7b0oCGIMyf6Z+zRIK3VSX1cTY/UzV4q6KNCeAcM9Zc=;
 b=K+bFhHfc00GiYTcKeXAkyFZRo7yoB4s+qHpYbPWWrVuXbR4lqYijj73lBOyBtk1gbkgbvRr5XbGPNi0ZCotwediTbgvnGSj4uRRnpL15K6ZxumQ+EB0llKK+siYnFaQ4CoDpNqDxjETEr9yoy85cUfmExpsiRzclJRDsEw7XGnEETYldWR41W/24VtN/ap2F+fO5woNWriAclYEdEGo2e8wnZmSWUnQjO/2qZWL+wzIe7SjqGz/DPp4N1v4bsvvT+5596Pfr1MLKzqZlLRZMvArp+g4OALA589f5Jf/iBijoQaKPSTQ2JZzUtnIozr7iXmlVoE/C1qKALn6YaSZ3sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7b0oCGIMyf6Z+zRIK3VSX1cTY/UzV4q6KNCeAcM9Zc=;
 b=gBtUTe+J4OmcjtiCN3ELFSdJNNsGB8X6Jdft0lM83SS6ul7h3qt4WtTXiAAo0NQ3fmEGt52H80aCBJlweBjiTP22rnZ/nLLeop/iUtHzrITtSr4rZsLlmSsbiloOgAYWfauHmKpeCBxnhn1EQwur08h3x8G7q6mjjlL3WYEF9lc=
Received: from SJ2PR07CA0024.namprd07.prod.outlook.com (2603:10b6:a03:505::14)
 by PH7PR12MB5832.namprd12.prod.outlook.com (2603:10b6:510:1d7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 10:28:47 +0000
Received: from MW1PEPF0001615A.namprd21.prod.outlook.com
 (2603:10b6:a03:505:cafe::15) by SJ2PR07CA0024.outlook.office365.com
 (2603:10b6:a03:505::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 10:28:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615A.mail.protection.outlook.com (10.167.249.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 10:28:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 05:28:46 -0500
Received: from [10.65.96.188] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 05:28:44 -0500
Message-ID: <78d0eeee-d6b4-4d7d-8219-36ddb5057721@amd.com>
Date: Mon, 1 Jun 2026 18:28:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/1] hw/mem: add spm-memory device for Specific Purpose
 Memory
To: Igor Mammedov <imammedo@redhat.com>
CC: <qemu-devel@nongnu.org>, <david@kernel.org>, <gourry@gourry.net>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
References: <20260527074215.229119-1-FangSheng.Huang@amd.com>
 <20260527074215.229119-2-FangSheng.Huang@amd.com>
 <20260601105057.2d764e55@imammedo>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <20260601105057.2d764e55@imammedo>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615A:EE_|PH7PR12MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: cc91a871-60d7-4111-cf1a-08debfc89059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|6133799003|3023799007|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: N3CpE+bh8iFtecpVnsLDZ+G/pIAq4MKZldQAWbBFSw2r4pph/Z1nE3tYZFRJe3d5C5SRYzLafcZ/WjpFThsjAVr5LfMcIm5ba5+6EskziW2FNUqq2faAizFsUzj2it7N0VkA/D3MVpxim7AlLUgMQuXkdoRLHhcksuzGoziUVaBH+AfCuxRE8zOya56xm5UlJXWEX9DyNFZ6m4hvtSw+3pFO8VKxuDxU0eG8mXOS2/VVu+R4SxHehGba8TmATIA0Bz6giU0J7EV+IYP1wbSP1s0+jR/l8JoqtVGuqgfhD3xG5NuyTWb+a/ygvwbNs85ii4ltupT572Mb/7etCEKnC1FMK7e1qL3nldLpNVVR0nIL/4ScDLdIxOCHhJ2fFaXkZmmzyGZaQ5Kl981YCdccZXBCw84b6fGYE4l7u4xZlQs2+2b1GCSvnqiprNUX7o1fldaobIa0O1aIPutIWAK40dvvxzn8EhelrNpLGtZb8vpZOs9zbUEe0+q3uSsbQKeU+FxUsMp47SoKUnnu7yEqqK4avUbpVNFmLVhIn/UYo6l7vJJaultDm+oTXIbH4bjXxEYMuki4EgE5Df1U7dfpKmpal7giCDW+JyPnDzvtvWjyf+4lpLGzsRl46Q1JIif7grzxzrrUISm+tSf0KcJIs+1TqWIMoIQ3pl3xA7OUxMMs5ZkdgrYuHmGMyY8djszDhdRHDeXKbXD/Cq49q1xTSy1t55bJbFHk7SqqNyenUN8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(6133799003)(3023799007)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q/tUABM1ROwa3hpiBYEXOBEcR/Bm0Fsyzvomi0DS+Fnm/bN1BkKNA24j2SdRAuQL0Fh682fdZntncbYnQWNVggYpE/lzJ9EBh5GoV4t37NP1N1o1ZSTSYnLXTFb+fGlmJW5Fb149l2G2ihQ87piVwTqDFPso3jMx1uTIrbqZmfCMj2nNZjzkGUHWNW2l00m1WmsKYeeQeWHF4QHWELUsJUSJ1LwcKFuRMk8kxaGOt4TBimdZrlzfMgNcHZ7rI4YUOdCNYW+EV8qNDSJTOU9koaKzdZLo7zXaqZ52xEUjN7Ebq1FRNoQrbkfdhg6LoZucdHY/UGCI5Dxn2NVLBaWycszGebaNYbzCtvRhAUB23YYNOM4VujBHcgSayQCygBXfATv6TXm/w20jsJrJepaKouPH9oG3p0ULvYoSqUZl6cDzC7bxZO8pacqcElZG/fm3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 10:28:46.8012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc91a871-60d7-4111-cf1a-08debfc89059
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832
Received-SPF: permerror client-ip=52.101.61.17;
 envelope-from=FangSheng.Huang@amd.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Thanks for the detailed review.  Inline.

On 6/1/2026 4:50 PM, Igor Mammedov wrote:
> On Wed, 27 May 2026 15:42:15 +0800
> fanhuang <FangSheng.Huang@amd.com> wrote:
> 
>> Introduce a TYPE_MEMORY_DEVICE subclass `spm-memory` for boot-time
>> SOFT_RESERVED memory exposed to the guest with a per-device NUMA
>> proximity domain.
>>
>> The device targets accelerator memory (HBM and similar) that the
>> firmware hands to the guest OS as SOFT_RESERVED memory, so a driver
>> in the guest -- rather than the kernel's general allocator -- owns
>> the range.  Per-device NUMA placement matches the natural shape of
>> multiple HBM blocks (one block == one driver claim == one PXM).
>>
>> [...]
>>
>> CONFIG_SPM_MEMORY is selected by the i386 PC and Q35 machines
>> (same as DIMM).
> 
> this pass is mostly high level review.
> patch is doing too much things at once,
> Suggest to split it on several pieces,
>   1. introducing spm-memory boiler plate code
>   2. SRAT mangling
>   3. adding E820 entry
>

Will split as (1) spm-memory boilerplate, (2) SRAT mangling, and
(3) E820 + pc.c plug-handler integration; MAINTAINERS becomes (4).

>>
>> MAINTAINERS gets new file entries under the existing "Memory devices"
>> stanza.
>>
>> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
>> ---
>>   MAINTAINERS                  |   2 +
> a separate patch, pls.
> 

Yes, will be patch (4) on its own.

>
> [...]
> 
>> +    cursor = ms->device_memory->base;
>> +    end = cursor + memory_region_size(&ms->device_memory->mr);
>> +
>> +    object_child_foreach_recursive(qdev_get_machine(),
>> +                                   collect_spm_ranges_cb, ranges);
> it's not an objection, but could we do better here, i.e. idea would be:
> instead of full machine scan, take  ms->device_memory and go over
> children regions -> pick only SPM device owned ones.
>

Noted -- I'll stay with the current full-scan pattern for v9.
The subregion's owner is the backend rather than the device, so
a clean device_memory walk would need an extra backend->device
reverse lookup.  Happy to add that if you'd prefer.

>> -    /*
>> -     * Entry is required for Windows to enable memory hotplug in OS
>> -     * and for Linux to enable SWIOTLB when booted with less than
>> -     * 4G of RAM. Windows works better if the entry sets proximity
>> -     * to the highest NUMA node in the machine.
>> -     * Memory devices may override proximity set by this entry,
>> -     * providing _PXM method if necessary.
>> -     */
> 
> don't just delete comment,as it still stands true. we should keep reminder
> why we adding place holder(s) and its quirks.
>

Will keep an adapted version of the comment alongside the new
partition logic.

>
> [...]
>
>> +static void spm_memory_realize(DeviceState *dev, Error **errp)
>> +{
>> +    ERRP_GUARD();
>> +    SpmMemoryDevice *spm = SPM_MEMORY(dev);
> 
>> +    MachineState *ms = MACHINE(qdev_get_machine());
> 
> pls do not use machine from device proper code.
> we do have plug handlers that provide it at the time when necessary.
>

Will remove the MachineState reference; machine-level work moves
to the pc.c plug handler (see below).

>> +
> 
>> +    if (phase_check(PHASE_MACHINE_READY)) {
>> +        error_setg(errp, "spm-memory: hotplug is not supported "
>> +                         "(boot-time-only device)");
>> +        return;
>> +    }
> 
> shouldn't be necessary, dc->hotpluggable in class init should be sufficient.
> 

Confirmed -- will drop the check.

> 
>> +    spm_memory_check_node_exclusive(spm, ms, errp);
>> +    if (*errp) {
>> +        return;
>> +    }
> 
> As far as I understood fro previous discussions, so far it's our
> own precaution.
>
> I'd drop that, well, if you find a spec requiring it then
> it should be a separate patch pointing to spec (or something else that
> justifies it).
>

No spec to cite.  Will drop the check and the associated helpers
in v9.

>> +
>> +    memory_device_pre_plug(MEMORY_DEVICE(spm), ms, errp);
>> +    if (*errp) {
>> +        return;
>> +    }
> 
>> +
>> +    host_memory_backend_set_mapped(spm->hostmem, true);
>> +    memory_device_plug(MEMORY_DEVICE(spm), ms);
> 
> That's basically code duplication,
> that doesn't belong to realize_fn, see how it's used by other devices.
> 
> The gist is mapping into address space, generic checks, machine related
> steps go into machine handlers.
>

Will move pre_plug / plug / set_mapped into pc_spm_memory_pre_plug /
pc_spm_memory_plug in hw/i386/pc.c, hooked via the existing
pc_machine_device_{pre_,}plug_cb dispatch (same pattern as pc-dimm).

> 
>> +
>> +    QLIST_INSERT_HEAD(&spm_memory_list, spm, next);
> Don't use global list, unless you have to, see below.
>

Goes away with the plug-handler move below.

>> +
>> +    if (!spm_machine_done_registered) {
>> +        spm_machine_done_notifier.notify = spm_memory_machine_done;
>> +        qemu_add_machine_init_done_notifier(&spm_machine_done_notifier);
>> +        spm_machine_done_registered = true;
>> +    }
> 
> e820 part should also go to machine specific plug handler,
> that will also hel with getting rid of spm_memory_list.
> That also should let you get rid of adding machine_done handler,
> the machine plug handler, would do the job instead (and much earlier).
>

Yes -- e820_add_entry moves into pc_spm_memory_plug(), eliminating
both the global list and the machine-init-done notifier.

> [...]  
>

Will respin and post v9 shortly.

Best regards,
FangSheng Huang (Jerry)



