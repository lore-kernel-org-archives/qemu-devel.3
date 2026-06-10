Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440FBCD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXD3z-0002MK-AA; Wed, 10 Jun 2026 03:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wXD3t-0002M4-N8
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:09:17 -0400
Received: from mail-southcentralusazon11012061.outbound.protection.outlook.com
 ([40.93.195.61] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wXD3p-0006t9-SI
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:09:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxdNg53ofb57DzCkuM5d8gJsrUN+qvM5XiDYDS7d5v1C9DEmkVARqHKDzk1qCWkItEDse6USfATIJBNaxp/dH11OTjvT9rPbTbIqsO7yMi2oaAA/yUSBV3mTN6j66Zxz/GBMLjOKbOZNdTHRAW9uTZ++DxSTnIXjdg1rkUzkX46740kmeRNINvdAxnsHU4s9KLZtzpGRHiZSAKo3qw6GWJT1qALXs/mrPDd/5mQgUG3nbMIZlN5q9rnF43yoWTwKgBbL96vQtA/gCtPqjeOCdjFiDE4j5RABVQoRcuEiDXHFWgKExZAvI9zkA344+JDYpEjSV8fFTWGBl4uwGUE0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v91Clxwxs2jNrxAAy1r+GYqp1fR3e+3Xp2VSuAGhKgM=;
 b=EAsD7pdfxEqa/Z13RDHwoElYutoS8zlvVD+Vk63Ux9VVhZtmSjbkfdE607wqZJohJ2Dxoq32Zl3fzo8xzBM36S0QILluyvGSV9N2bx7OvKqNvGVg7sxsx1q7dCzmW8/v6wykEFsmcoB9MY7vIJOhCLZDGJiu7N6iL8kWn+c39Ia0Uqsi4QCzjmXqSQIgA9KlbJfEVK5zgox1G/jctkp7SCcLb/Otg+Q6Yk68NhDHi6yJsD7YVjvOwksVB0KJJ155dRDiZcoeTftEFwE+V/Lq1nBUtqaK3aFrVaM9P+yXPZLRyCyC7DXo3tfkeWxJx+OrekMsllRjnTApUGegq4ZssQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v91Clxwxs2jNrxAAy1r+GYqp1fR3e+3Xp2VSuAGhKgM=;
 b=zR/VbZuVlO8azQKnb1U6u4yFPR4jVrhRvXSH4nSuG/tlaNEoSa4lu+4CB9dXMi0Y2v7KVvBlmGBiQUY7/s6deYh1CrgmOYLBQ1CbRvnCwslNc5LA2nGvSG5dqi46QvcJHiaPxIypuwkuHX54upc21XHSeUzRa9uY85q/hTWQjtQ=
Received: from CH0PR03CA0081.namprd03.prod.outlook.com (2603:10b6:610:cc::26)
 by CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 07:04:02 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::14) by CH0PR03CA0081.outlook.office365.com
 (2603:10b6:610:cc::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Wed,
 10 Jun 2026 07:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 07:04:02 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 02:04:01 -0500
Received: from [10.65.98.222] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 02:04:00 -0500
Message-ID: <f50e7303-e600-410a-bec7-58f756e0efa7@amd.com>
Date: Wed, 10 Jun 2026 15:03:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/4] hw/mem: add sp-mem device for Specific Purpose
 Memory
To: Igor Mammedov <imammedo@redhat.com>
CC: <qemu-devel@nongnu.org>, <david@kernel.org>, <gourry@gourry.net>,
 <philmd@mailo.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
References: <20260605104609.1739911-1-FangSheng.Huang@amd.com>
 <20260605104609.1739911-2-FangSheng.Huang@amd.com>
 <20260609110324.41b410c0@imammedo>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <20260609110324.41b410c0@imammedo>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: 07bce79b-9ca0-47be-0cf5-08dec6be73ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: oD/Ja4hzYg3r0SyJ1cUXN3t2DA++1yLPl/63jK5o5M2fIrBvAs0y8wceqVCoq3PGAWBfgP4DTynmsjKyRpvdn/b7GjlmTuGqlsd6Ha6OkRcwOUSrfXb+AJdJsQ7jo19vnqWoVU1WCX3SrxHdam2p/wRdENev+g6CLolHxOuJ3Znf9Lrrnk02I4Kr/nniY8L41vPBgE4Y/rdCZLAr5lueUOyCzVmEFteX4g8/WezsCeae/X92MvtHicFlLcA8vI0bAi8BitX6vwi6UNTD6JLGxCn2uwnF50recZy9o2odqXhMQgmlQEkP9IezwvDjXIYAZp37g/2t9Q6dBA1o0OwdGPT0553Or51gSWpmmW8yF4zVDb3kEjlPlgMAD5LhJ3UPVrXAjq7dcBE/pqTZfvnkiGEhf9F8iTRu5GmDr07WnPtoq3L7ZuVOV0FWVOk81Vg9j3W89LqKVU8RuUrPSmdIJLm6KHHHNmGIIdAgzoe8FnbjKyiqAmb9eOyoolmclYmS8ISKbKvs83lYLmlSyHjass3BGVJQrTv12Zi3Tt6+/aeZZbhpBD13I6kNQUrhjwQpIlsySLyOo836zUOmedtxYp0MynYHkwOUkxqffanUK7G7yynpwBmFaJmgHNW7tEKnmRfyZe22cWb8y2PdB+dlYidmf0Rob/Ez7tyk9J6aoqcTSLGDEZ1AZPHeSms1CXJAwMs1bS6AC+dk5y+3G6sBThZvK+SrnprgaNoriEil3/U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o6snFHFjvctJNv9AEgg3AGxJdfHXWvkbO4bpNH3FLujZjj/PQ5dMMz737bIgcKCum+RPPbIfG0x2tfBB8ZZRZPBuAORCX/b9wKWZn3SfxFqb/7ofvDVwlnnE2moQtAjgBCBqiQOxa8MtGrd44/a24/4dbcboxf1tchJJfhBJKLnFsT9RVbRZiAxKDTnMaKRr3kqaSGFMJ85F70ZNXQ8XKYIf3z3mKTtdZ7A3Dr6hnGk6o4KaqZx0pDLK6miOGufZFF5vPooe5M5884AhNYuHJFIjoBQmNK7sqSiAZdwy/IiTd8Wjn30JRYLsMA10UuV7IS3ay2r89mZdeXBPtdiOkyjo0Pl88pBuNECiv3eqFnd7FFLllSSqeK5HeTQwj5uhXiRL5ZKOv0H0ybknwjzUMkZl7AMDKS6hxffXjc1TG052ZdWCI9Em4FC7BPQyqFjq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 07:04:02.0583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bce79b-9ca0-47be-0cf5-08dec6be73ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491
Received-SPF: permerror client-ip=40.93.195.61;
 envelope-from=FangSheng.Huang@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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



On 6/9/2026 5:03 PM, Igor Mammedov wrote:
> On Fri, 5 Jun 2026 18:46:06 +0800
> fanhuang <FangSheng.Huang@amd.com> wrote:
> 
>> +            'memaddr': 'size',
> 
> why not 'addr', like DIMM?
> 

Will rename to 'addr' to match PCDIMMDeviceInfo.

>> +static uint64_t sp_mem_get_addr(const MemoryDeviceState *md)
>> +{
>> +    return SP_MEM(md)->addr;
> 
> device cast + deref, should be separate. or even better look at
> pc_dimm_md_get_addr()
>

Will switch to object_property_get_uint(OBJECT(md), SP_MEM_ADDR_PROP,
&error_abort), and set_addr to object_property_set_uint(), matching
pc-dimm.

>> +}
>> +
>> +static void sp_mem_set_addr(MemoryDeviceState *md, uint64_t addr,
>> +                            Error **errp)
>> +{
>> +    SP_MEM(md)->addr = addr;
>> +}
> 
> ditto
> 
>> +    di->size = spm->hostmem ? memory_region_size(
>> +                   host_memory_backend_get_memory(spm->hostmem)) : 0;
> 
> why conditional?
>

Dropped — hostmem is guaranteed set by realize() before
fill_device_info() runs, so the ternaries on di->size and di->memdev
go away.

>> +    di->node = spm->node;
>> +    di->memdev = spm->hostmem ?
>> +                 object_get_canonical_path(OBJECT(spm->hostmem)) : NULL;
> ditto
> 
>> +    mdc->get_plugged_size    = sp_mem_get_plugged_size;
>                                     ^^^^
> wouldn't memory_device_get_region_size() do here?
>

Yes — dropping the custom sp_mem_get_plugged_size() and using
memory_device_get_region_size directly, as pc-dimm does.

>>   
>>   stub_ss.add(files('memory-device-stubs.c'))
> 


