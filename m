Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED439CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZn9f-0003O1-6T; Wed, 17 Jun 2026 06:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wZn9c-0003Nn-CY
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:05:52 -0400
Received: from mail-westus2azon11010020.outbound.protection.outlook.com
 ([52.101.46.20] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wZn9Y-0007wg-R8
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:05:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jS8G7RJx/aKr9+pxabvgJW8MRHlDiHieZo00ghrrzAxOtvTXhDsV2z0BKjbJVArhpyf4bMhazPdlHzqtRs2d02Y0yxsNkgRzpg/iOjuqZyRmAXCQQz6qwi0FdhfpMsGz5KTfTuENH7iTsGWeKsb8zDRKJlgqYqXQnrrJFX8OIgC3jeDuEw6YEFWXpghQx7bpThqlSsdNtlSZwipfBnd3mGEq5+3+bO7qz3bROKHzgHrDTR1QjX/KcP9+q4ngsdhwmlVNQKudkBJk5CiG/cZz+7MbTox6EAaUJvKSmZvQ2WoaSGeuV4u4wkoT/yw9xyynWJIVeX0eTNSuF2xS+hVGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWK5pM2SgzhKPbD+1KRSeeKFxL7QAcIQpBfInQNcqMM=;
 b=ww4A5Rh08N81/Rf8lI3QC9LOnmfSyc7mkovC/SphYnoVS42f8aVZGGCfd8wUolpqB/gBamOtvCuk0vNgaR94yYOOeH2x/evk6VHue7qjrgd3OYIwdS7YT7U00W65gUXVcY64SrNKzkTyx04354vAE08ggq9oZ4WDgnWpHcoziqYAzOMSdAjuKZzWYAP9Ope7xOupL0AMoj3gx0qoij/RPnJxzjywOeyXhO/4AAC6X9K/MgSG/TkDfWlURcEoykQ6pq3PFscnWSYvpnSUl5vGf259/qUZfQRcb8C+c1USBM6amG60fQkdRttvn1XLljhrYEBpvQwUWca9zjlFI5NFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWK5pM2SgzhKPbD+1KRSeeKFxL7QAcIQpBfInQNcqMM=;
 b=vWiQ6Bg6jeWXle0D58Hh33eRxD+EPkFJ/0C2XKN2Ao2NnE0SVvQn/pyRjNA65molMBOYAyt8UhCOMe2y1KN0z2r6qB/VqRsw3OQUbZMRsVJXZUS4lk0v5TeVbQ/eKq4h4yGkjsb9dRtzssbEQCu8aPsogsfhjdiOIaHenA4EXo0=
Received: from DM6PR06CA0075.namprd06.prod.outlook.com (2603:10b6:5:336::8) by
 MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Wed, 17 Jun 2026 10:00:36 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::24) by DM6PR06CA0075.outlook.office365.com
 (2603:10b6:5:336::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 10:00:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 10:00:35 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 05:00:35 -0500
Received: from [10.65.97.187] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 05:00:33 -0500
Message-ID: <731fdc4c-3029-4dc8-a483-fdd0be4729e7@amd.com>
Date: Wed, 17 Jun 2026 18:00:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/4] hw/mem: add sp-mem device for Specific Purpose
 Memory
To: Igor Mammedov <imammedo@redhat.com>
CC: <qemu-devel@nongnu.org>, <david@kernel.org>, <gourry@gourry.net>,
 <philmd@mailo.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, Peter Xu
 <peterx@redhat.com>
References: <20260616090808.3047939-1-FangSheng.Huang@amd.com>
 <20260616090808.3047939-2-FangSheng.Huang@amd.com>
 <20260617111652.1bb4d2d4@imammedo>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <20260617111652.1bb4d2d4@imammedo>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dbcc394-2e23-416f-f784-08decc57471b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BK0Mp2wQyR216TSOvusB8O/qEViLDbOaP5McUTIxi9Y48XgiD3pJDr/nZtktjkXhkrpyss+RhaaO53mnI7MQ5Z+jKTqBZXt+qXEKLmhxNGSWDC7jYllHvVrFltuL10ELJd8rHJ28uzj/eADiyi/gr5IeezAEEpSg1buGzI7zE1C3cC2wzwy4kbf6Up/+faukGAfAlfkLv7hbe5/FGectJWmj7es647CM3MxVP1UdETmg0Wjz+fbwejLiqZVZc9QNpXB4hQ2t8qM8tzFzBAN6/w4/M66BuUCAOoWoMyBCIrE5R6WOJFCDfW7AwN8oySBOYmzoFGeTkZDSiepNgiGtwrUsupfgqC9phoG5/n++2v80AAsDcVjjqA3U+0VYcN/rogtGWUwhfr3quPXPm2KE1bQedA2twiAYPtZlScR+V6FYt7eX71Om9FOoRNv+tIdPftH3pFW628pwulZ4VTQpxOzX5Dr7ier70ILJ3LBmzr6be1A3LmuIfQbQppq5jeQNGYNTqiLSc+iropM4ew8hBaTg6/g1zBxVGOptIqG/7n80DVM3afisLpA91NhgiUkh3PW4k+ZB9xjy2EvfhdzlMG8TB83feLmdxQgdZKD8UgIL4i6B3ane1MFBADG1j88JHDMNZnMCnQBEpNWpcMny67UEytWEwMQfXHZzWEjfQLY/JIq8W4/059PfussHWJHZrTeHTqra4iXRYJRuaGejRJjSket/1Xy7A4QA7XmxlDw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M95mzbY6EOymrQlBlcNLbwMqVFgos8qChKooBkSHz53uGswjY6XyQLCE/57BKZpRCu19SI3a/8M7HJxODZiGXZWBDJCh0QxnCMQiKGCYLEXL3C61kcd4xOpXLOqas0MXqeRhpgFslHgClhHL/jhhPUOEMQKS3kEMDn1+Qc/8guxK9GP5YbzIL/78jkOtEx1Yxj26VQ67ocnvf+e/NI/9c3oon4bjAh8GaSMiuhd5d0VAVYxUawCWrxXtCRt7CXyO7TlfTGyxSdwH5uhY7jyjkzIULfohD1xGXpkBjOewe39NCzHXKJhp34cq/HY8cwMpJaz3ehEpmHou/Pxco8OjNj/UddIrwWLC+LI0HOJX8roi0r0LGFq687uErfzFHDwUQ7ZlXf0jGX0DboR00jGIZl+JmnOCQTY76p9YW/AYrq9zy2abVJha7oIA1BqFEkUr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 10:00:35.9695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbcc394-2e23-416f-f784-08decc57471b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246
Received-SPF: permerror client-ip=52.101.46.20;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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



On 6/17/2026 5:16 PM, Igor Mammedov wrote:
> On Tue, 16 Jun 2026 17:08:05 +0800
> fanhuang <FangSheng.Huang@amd.com> wrote:
> 
>> Introduce a TYPE_MEMORY_DEVICE subclass `sp-mem` for boot-time
>> SOFT_RESERVED memory exposed to the guest with a per-device NUMA
>> proximity domain.
>>
>> The device targets accelerator memory (HBM and similar) that the
>> firmware hands to the guest OS as SOFT_RESERVED memory, so a driver
>> in the guest -- rather than the kernel's general allocator -- owns
>> the range.
>>
>> Usage:
>>
>>      -object memory-backend-ram,id=spm0,size=$SIZE
>>      -numa node,nodeid=$N
>>      -device sp-mem,id=dev0,memdev=spm0,node=$N[,addr=$GPA]
>>
>> The device is boot-time only (no hotplug).
> 
> Modulo nitpicking/patch splitting and a migration question LGTM
> 
>> +            case MEMORY_DEVICE_INFO_KIND_SP_MEM:
>> +                spmi = value->u.sp_mem.data;
>> +                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
>> +                               MemoryDeviceInfoKind_str(value->type),
>> +                               spmi->id ? spmi->id : "");
>> +                monitor_printf(mon, "  addr: 0x%" PRIx64 "\n", spmi->addr);
>> +                monitor_printf(mon, "  node: %" PRId64 "\n", spmi->node);
>> +                monitor_printf(mon, "  size: %" PRIu64 "\n", spmi->size);
>> +                monitor_printf(mon, "  memdev: %s\n", spmi->memdev);
>> +                break;
>>               default:
>>                   g_assert_not_reached();
>>               }
> 
> hmp could be a separate patch.
> 
> 
>> +static void sp_mem_fill_device_info(const MemoryDeviceState *md,
>> +                                    MemoryDeviceInfo *info)
>> +{
>> +    SpMemDeviceInfo *di = g_new0(SpMemDeviceInfo, 1);
>> +    SpMemDevice *spm = SP_MEM(md);
>> +    DeviceState *dev = DEVICE(md);
>> +
>> +    di->id = dev->id ? g_strdup(dev->id) : NULL;
>> +    di->addr = spm->addr;
>> +    di->size = memory_region_size(
>> +                   host_memory_backend_get_memory(spm->hostmem));
>> +    di->node = spm->node;
>> +    di->memdev = object_get_canonical_path(OBJECT(spm->hostmem));
>> +
>> +    info->u.sp_mem.data = di;
>> +    info->type = MEMORY_DEVICE_INFO_KIND_SP_MEM;
>> +}
> 
> if missing this doesn't break anything, I'd bundle it together with hmp patch
> 
>

Will split the introspection bits (fill_device_info + the HMP
printer) into their own patch in the next respin.

>> +
>> +static void sp_mem_realize(DeviceState *dev, Error **errp)
>> +{
>> +    SpMemDevice *spm = SP_MEM(dev);
>> +
>> +    if (!spm->hostmem) {
>> +        error_setg(errp, "'%s' property is required", SP_MEM_MEMDEV_PROP);
>> +        return;
>> +    }
>> +    if (host_memory_backend_is_mapped(spm->hostmem)) {
>> +        error_setg(errp, "memory backend '%s' is already in use",
>> +                   object_get_canonical_path_component(OBJECT(spm->hostmem)));
>> +        return;
>> +    }
>> +    host_memory_backend_set_mapped(spm->hostmem, true);
>> +}
>> +
>> +static void sp_mem_unrealize(DeviceState *dev)
>> +{
>> +    SpMemDevice *spm = SP_MEM(dev);
>> +
>> +    host_memory_backend_set_mapped(spm->hostmem, false);
>> +}
>> +
>> +static const VMStateDescription vmstate_sp_mem = {
>> +    .name = TYPE_SP_MEM,
>> +    /* boot-time only; no plug/unplug state to migrate */
>> +    .unmigratable = 1,
> 
> this is explicit migration blocker, isn't it?
> are we sure about setting it un-migratable, if yes/no than why?
> 
> I don't see how plug/unplug is involved here,
> but I'd speculate that we would want to migrate memory content itself.
> 
> CCing Peter,
>   for a look from migration pov
> 
> 

You're right that the "plug/unplug" wording is off.

The device carries no per-device migration state, so with a normal
RAM backend it would migrate like pc-dimm. I'd originally marked it
unmigratable out of caution, being unsure whether the backend could
be migrated -- but on reflection that's a property of the backend,
not of sp-mem: a backend that can't be migrated can express that
itself, independently of this device. So dropping the flag and
letting sp-mem migrate like pc-dimm, leaving any restriction to the
backend, looks like the more flexible choice.

Peter, does that match your view, or is there a reason to keep a gate
at the device?

Best regards,
FangSheng Huang (Jerry)
> 


