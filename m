Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D026BCD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXD2X-0001Uz-Ra; Wed, 10 Jun 2026 03:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wXD2W-0001Ud-4B
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:07:52 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wXD2U-0006Z6-A5
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:07:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpQH4JzpTC/mUqTRXGBk0fq5GlVGelCwB3RA9Cf5lL0Ms5SdBY+4HtxrhrZv09kqEdwS5rNozEBuJKg2icaBoJq6vTKjp1wQkP9NLMfNy+wSn5ZGrFHgOn/nXrwZoUSh4hzcKF6yru1FnwFQgAo5Vwc8mY6JsTWmh7LShqN3R6h/yrnQmxSrxKo2bzbf8yVWrpMMPKwrDhD01uTd7dfTzRV1u5qKoVwTmsuNiHeCxsIaXjVE+yQ45vBhFlNARTZTnHWXfVs137D0L06Jw/JipYYz21T8eXKy4utkiU2n2wcHWYXab4PcXmaBfuWg86Bv3NOmI9Ap8r5zqBjffdpz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yV0q2Gh+5DNcpw0A7QtcAKbD8C/9Td1xmTYOLKFK7CA=;
 b=JytiyrJereI3zQQtKuGBncobT5e/bLgXCeKIsJ8wTrYYHYfFbxg0fpzCDPCQX/iimtKTLAMGf+k13p/rs6xeEEEExhFcrIfxINJR878rlxyO/K1DbcDJMZ0DiLdMHa30n0bBLfB/b5E64kLAvjVIGO0Vlqs+5gOavwpvp+ff7304GBOSWivNDDKSDvT9sF4TlnQZyMBC6dg4EdFuw+bdlxk5uvh4AnYuq4SmQaFusJAawfyxfjHB2z5FWrQxzdfeSVG705Vfe/OCn8o4wKAziuMxYMthJHNjOXAoPtVbxakD7974Vy3ULzaVOi1lHXXmT3SPJhuB5/RD51IOuapcTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV0q2Gh+5DNcpw0A7QtcAKbD8C/9Td1xmTYOLKFK7CA=;
 b=coIwqmIhyrwWRhJ7ObzqkeA6pvRyzZJnVxAzbPAI8RXWAOh3h5SR7t8HB3O8FY88VVg//TJ2TvL+gM6yyjoGh9aUYIhg/g1AW+wwdBIfq2yrxOJdYDo1/+hNDv5o/M3wHbax/8MZAteGZRSEWWU07OZaMj9atbrRMaMIodELKjg=
Received: from CH2PR17CA0001.namprd17.prod.outlook.com (2603:10b6:610:53::11)
 by SA1PR12MB999228.namprd12.prod.outlook.com (2603:10b6:806:4db::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 07:07:44 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::3f) by CH2PR17CA0001.outlook.office365.com
 (2603:10b6:610:53::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 07:07:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 07:07:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 02:07:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 02:07:43 -0500
Received: from [10.65.98.222] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 02:07:41 -0500
Message-ID: <d4d36fb2-f57b-4bd8-b0c4-0b81a8f0e2ea@amd.com>
Date: Wed, 10 Jun 2026 15:07:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/4] i386/acpi-build: partition device_memory SRAT
 umbrella for sp-mem
To: Igor Mammedov <imammedo@redhat.com>
CC: <qemu-devel@nongnu.org>, <david@kernel.org>, <gourry@gourry.net>,
 <philmd@mailo.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
References: <20260605104609.1739911-1-FangSheng.Huang@amd.com>
 <20260605104609.1739911-3-FangSheng.Huang@amd.com>
 <20260609131435.34646220@imammedo>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <20260609131435.34646220@imammedo>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|SA1PR12MB999228:EE_
X-MS-Office365-Filtering-Correlation-Id: a6575005-a96a-4635-40e5-08dec6bef7f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SOTKfGgcZ1B5QWIPYT3tLfrZ0CIbJeg5wynVeOgqbEc7Vj7oSro1bxc7pj1+dwa0XYGyk/QSt7LBXhH0FsNeUi8sCQwCgSj/YUmVAG2Lgz7NLsH+ShLJffDJWNDvx/XnXJGz0MqqX3pbIznqE+wovqppLObbWsm4JYc07IYDsf6/ElPIe6gFCK6+r9/07jojdrOUR7Q0kjMvXBHosa3zUPpsHMZVCsiSOM4NHANptwwMB7aml4khOQA/lxnZnFCLxUaMK1KkdrZNtI1dxQODYmg6Yf0p25ermrhRuUuox2UdU7+Zj2E+/DBg0tBgqqWd3KB3v0cuLIl0DUaZXxuGxBcHLEo1MQYB+NmoeJNgJQcehSfOspom5WLxDv1e5KKrjsegkSFWE9v5plXJjXhOT1ZSSNTkOyKU3mWBWxXg60e1sPkWG7DiynQKAU9pKKY5lXnmlTZiAjRbsObjemRhhWuDABszwLPCP8GMhdcCEPN1yTdtzDwuOOl1/uqbaAhBm9qU9w8adiUIFpcRotRse4IJ95dwFd5+J8cpmDDm5rYYTZn7E5VyqCA3FlN0mv49lWojdWNrkyumxoHMajaYpMxbML8SGwksqlRA1SXoZdS391H+IRaTAe0zMuaeO/fy6LCA8YwSWda6JE5eFcrDAHhu4/ixfRIvHl6idjuJm9T9Nz8yVmJlGDwUN3GP/rG3sQFctB/Qp1TxkmXcroWuW2a4s4+GzUpfCQYF6IS/SNw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wrt8Pn7pxUR9pS0Fk9u6PVLnhhkgOMvaiXV1lkTeB1AMUFtNcdb+2rPf1i1xrthSr+9/XpvFbC2w79UpFwElcvLjrRQ8tsUvdJ86ShxZCmYXg24c37Kh7pq6JBc1uMe3GCQjH5UJGnRzH4jyUmKB9mQMg54aWs2TrrPwZRbHpBWrzQadsWIi142Dhzg2ip5+hNv5F3nsy9sodL35JeOCRnpy0x3i9IzpoPawUhOjD2DSf+0n3eawnMIiP1nJuM+dCcH3Eru+UiM8EfESYBNVDV7pwBuDihIKIuLRoUBtuufR57SwTKeJQtJZ2KMdgmHEo3frelDCe2MDCMTqSdDBzHn23GnrmV9ZYfSkF4ECs1k0jX3gyjIdaiNTOKW0yESWUuyhHMpMfDaS/ZAj0+i3tkYocIn0zTeJDc3czF29htg7JMhi8XVqKq7syedj1hnL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 07:07:43.8696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6575005-a96a-4635-40e5-08dec6bef7f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999228
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=FangSheng.Huang@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 6/9/2026 7:14 PM, Igor Mammedov wrote:
> On Fri, 5 Jun 2026 18:46:07 +0800
> fanhuang <FangSheng.Huang@amd.com> wrote:
> 
>> +static int collect_sp_mem_ranges_cb(Object *obj, void *opaque)
> sp_mem_collect... maybe
>

Will rename to sp_mem_collect_ranges_cb.

>> +    uint64_t cursor, end;
> region_start, region_end
>

Will rename.

>> +    int nb_nodes = ms->numa_state ? ms->numa_state->num_nodes : 0;
>> +    uint32_t hotplug_pxm = nb_nodes > 0 ? nb_nodes - 1 : 0;
> 
> when function is called ms->numa_state->num_nodes is always > 0, isn't it?
>

Correct — build_srat() already dereferences
machine->numa_state->num_nodes unconditionally, so the guard is dead.
Will simplify to ms->numa_state->num_nodes.

>> -    if (machine->device_memory) {
> keep it here, and drop one in build_srat_device_memory()
>

Will guard the call in build_srat() with if (machine->device_memory)
and drop the check inside build_srat_device_memory(), so there is a
single guard at the call site.

>> -        build_srat_memory(table_data, machine->device_memory->base,
>> -                          memory_region_size(&machine->device_memory->mr),
>> -                          nb_numa_nodes - 1,
>> -                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
>> -    }
>> +    build_srat_device_memory(table_data, machine);
>>   
>>       acpi_table_end(linker, &table);
>>   }
> 


