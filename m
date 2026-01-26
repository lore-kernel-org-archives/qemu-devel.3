Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4364BC88E6D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkHSp-0000IZ-91; Mon, 26 Jan 2026 02:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vkHSj-0000GH-OI
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:56:42 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vkHSh-000670-2S
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:56:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGncuDqA9TJ3Msg6/foO1wTRzUYD5hns1hZNFFTLBd+I6q/MXUInNI2fobwXRTCBtsbIcLUl9detOviC91nrzkEX2J5YjTWIT7eixEWjwdxV4fglLR9peCJ0w+/J1b/EEtMgeh4cCTJej68n4TH19vzqfWiIlKn2kS+9+CG9+Cqu5CuEMYMEXufcDRYQEJc8AJumCCmJUow0Qwr61LSAOEMXHZl8JzVkVvi9LapNRRhZdjjyeKFp3qzFgVPs/YCC/GvYORj6GVxSCEKz8fJ7oo0Kde9OsX0/LRtDPk7ATFoPy11JyMJkqE31mG4sLcRbBnLUafJGOfRmNCyZinYIPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3ZyFZP09O/uf62VrJ2UmuRHAxsWrWcAl3SCjA/RRr4=;
 b=A20nAy043dXJu2gVm6aEIbf1V80QWP6YyTdKqTCQpPeEmbnHrM8X3NsswzBVTOpfbiJd10qR0v3KzpkpxuGHMdtVMrGnHqLZ7m+bSvCKusMpzZh8+HJuIfUopQdIFpsflalOc5EjzdQdCxrWmnmOmNmanevzRvtqDt65IQ4BRZij3yPfYjZn/MEzKtNn8LnYgc0jnJT56kxVreby13gyJHJaWCHHjFu3yjBo2BHiD457+rvrU/y59XWJ1aGqab2kdoxZ1sJCXgy8jE+Jgl4nMPlov3XHDhVBwDSw3TByH29ML4vxqhlCQ4aLuYWZgmNiA1rH+BilJFoU97KMCkE6EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gourry.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3ZyFZP09O/uf62VrJ2UmuRHAxsWrWcAl3SCjA/RRr4=;
 b=1PjM7kwo0aVN4xSvftb1sTL/Mfj1xmc+HDNEVh9PIqVxpvOHo39sX7vDeq6hC0D7En+/69xBZSJuJ77oOcdq5dg8Az96y3yne544kNiZgc0WIFYEXsmABfVRaLUPT1t8QwFH9rQfvVwBjCAVkdV0mr7rnE1Ou9d/7UlXbAVeBUA=
Received: from SJ0PR05CA0082.namprd05.prod.outlook.com (2603:10b6:a03:332::27)
 by SJ5PPFDF5E260D0.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Mon, 26 Jan
 2026 07:56:33 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::e8) by SJ0PR05CA0082.outlook.office365.com
 (2603:10b6:a03:332::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Mon,
 26 Jan 2026 07:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:56:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 26 Jan
 2026 01:56:32 -0600
Received: from [10.65.98.30] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 26 Jan 2026 01:56:30 -0600
Message-ID: <eccd84c5-a2ce-46d1-b821-645e339ce69a@amd.com>
Date: Mon, 26 Jan 2026 15:56:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] numa: add 'memmap-type' option for memory type
 configuration
To: Gregory Price <gourry@gourry.net>
CC: <qemu-devel@nongnu.org>, <david@redhat.com>, <imammedo@redhat.com>,
 <jonathan.cameron@huawei.com>, <apopple@nvidia.com>,
 <dan.j.williams@intel.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
References: <20260123024312.1601732-1-FangSheng.Huang@amd.com>
 <20260123024312.1601732-2-FangSheng.Huang@amd.com>
 <aXOb7xOKNR62d7oy@gourry-fedora-PF4VCD3F>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <aXOb7xOKNR62d7oy@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|SJ5PPFDF5E260D0:EE_
X-MS-Office365-Filtering-Correlation-Id: a61deb15-bb00-4db1-a331-08de5cb06c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXZ2bTNCNXF0YnJYYWlrb3U3TXhxVzRKL1ZGQ016WGM5Tk42OHJTMzJlc2Zv?=
 =?utf-8?B?Q3M1T2N3WXFJT0w5Qm5XajljT2FQYjBKQkh0VjBKTVdGTTZFbzEvM1RPNklD?=
 =?utf-8?B?eXJ6eXdlTE81ZmtoR0dXR2E0enQ2aFIwTkJOTFZvaVE4SlZGdnZzMEMraFVm?=
 =?utf-8?B?eDk1TzljUHB3OEVnQk5maFI3R3owN0tEOUdzeUs2ejZ5VlgrZTVpclJzdHph?=
 =?utf-8?B?RkxDMkF5YjMzbmRwci9yaG84SlA1OCtNRGsxQ0pHMzNMZ2xQRHFPdWJKcklC?=
 =?utf-8?B?WUxlTHdYRk13UjBrYmhRa2Fnd3B2QXVIS1Y3VDdyT2NyMENub1BRc2Urbk5L?=
 =?utf-8?B?NDRCRkpMVU82V2t3R3B0WmJOaTMxc2VYNFR3ZC9BYXlvc2RUZlExRFcySENQ?=
 =?utf-8?B?Y0ZjQXJUK2plSzdIT1VCTExLZGk2S05ROHBQLzZIWVVBNEo0V1NVdi9nYU16?=
 =?utf-8?B?cldOZVh5ZDVBWExwMExkSyt5bVJaeWhLaHY2Y0NxMWFDVWVvc2tIODR0RGJ4?=
 =?utf-8?B?N2R0dEdsMlZtaEhhVmlycmtsR2lYOVFGQ3VFeFpZelQ5cTVFYUVmTTk0LzIx?=
 =?utf-8?B?SzMrdVd3RUEwYzcrYXJpMkl6MjJSZXNqVUtLOTI3VzBJbmJFb3p6QmRpNWZ1?=
 =?utf-8?B?S1VNVmZMaU5OdUZuMGE5S20yVXBIWW5QazNHcU1vN2VnMlVZR2gyd3FHQ1d3?=
 =?utf-8?B?RmN0YXV0Yk5qUnFQdzRhWGdyVFJTam9VTUQvdUFhWjQrcjV6ZVR6M00yemdK?=
 =?utf-8?B?WDBWdDFMNElLS2lJR0hrSjNXaGJab0tocktQSmpqaElOdjhjUDFYQmNjNm5a?=
 =?utf-8?B?dDVVWDVVQldVakVqd1orZmswNXhDclR5d3Nhdld0ckRmZVpFemdtajdMTTZq?=
 =?utf-8?B?eDBMUzNTWUlEblVMbmpYNmQrNkZyZ0g1dStPbCswbVd5RGpVS3VyWi9NQm4x?=
 =?utf-8?B?ZXByY0RaMzIxZGJ1SGxGUTJDYXBlNCtkOEFjWjlhb1hvWi9mbHZEeDg0MTZs?=
 =?utf-8?B?TDl3aVRlMGtPUElOb2syclYxcnBxNFdlSVFwazMxRVNUTGtYSmprNlFFTmYv?=
 =?utf-8?B?OUltYW9UUHpZUzUyMzZFdE1DRGlMMDBJN1c0WHloeWxjS3piaWlwR2Z4Wkhn?=
 =?utf-8?B?b0xVcEs3bStjZlI3djFaRWZkWjhtU1BvbVN2MnN1RFBTZUkybFl3K3pnR0ZO?=
 =?utf-8?B?V00zZGpRWkg1UWN0b0p2TFFWc0YvMUQxTG5IdmY2a1IwYURRL1NGdHVSK3JD?=
 =?utf-8?B?YnIzb1lMdkYzUDM3UXYycXFyY3BQcHNCNk1yN01mOEdGUWJ1L0VJZ2Znb3Ux?=
 =?utf-8?B?NnJvVlZURkxDNGg3UEZaSytVRUs2VjVROS9tVElFT3h5amgzL0tXQjVBWndV?=
 =?utf-8?B?UDlJbkhiTTduYXlOUTAwTHd1YlowOHJqUTc4SHc5YjJsaFE0Q0s1UVVVcmIy?=
 =?utf-8?B?V0liU29YUmlxWVpBU2pnZ3J6ZXMwNGxYeU9UN3lYbVBIOENjSit2b1RCcXla?=
 =?utf-8?B?Y3FndVpJMk9uY1NJMDZ3dEwycUxBVENhK2NxVFhjQmlHLzdMMzVBVVhWU0c5?=
 =?utf-8?B?aXhEQm44UHFpVWl1VzFPL3diNUdRdnNtZlA3V0ZBOVljYWpmVlN3ZjBuNUtn?=
 =?utf-8?B?cFRIVXRxS09hc1VEaWN0bzZjZC9OK3VUZTJTcGV6QzhLSXhGVkI5UTRnRFV0?=
 =?utf-8?B?Z0ZwWEhlN3I2aU9qMUxMQTg4bTdsRDhZdkZiTWxrTVRFY0ZxdGhGbXhyTHFT?=
 =?utf-8?B?U055S0tiMVNQZlJGcGplbWtCK2hWQTNSbWtjS1J4emsyaW5BZkkxU0cxa0RG?=
 =?utf-8?B?RWNkQjhubkRaR2FodHlYVDM0cnp0UUhYTENDUWFWYmYzMVNlU09UWEl0RWF0?=
 =?utf-8?B?Nms5NkhTV1RxTjJmaXZRWXdyeVJ4MkYxYlExbVFFY3VxZzgrUHRzbVg4MWZa?=
 =?utf-8?B?Sk9mK0p6MFhIcFpjS0hnQnIxNXVPNUNKaUJtMzJLTURqNFloWjdWTENIb1VG?=
 =?utf-8?B?N3QwMWxjeGJMRmQvZmhvZEhuVFB5dWJDUmI0cWIxVkRXcmxZeG1pS1owSVp6?=
 =?utf-8?B?cnEzT0NaR2FZTkxGbzFXeitsT0VPYWFFMm1xSXY5TzVNbkkrSWF4QWdIajha?=
 =?utf-8?B?dTVVZTdNZ3RGRTNNblZ3UUJCKzNMYTNXK3M2MVZ2bHFyME1YcFozSElFbFFV?=
 =?utf-8?B?ZGo2SUpCNEF3MkNwSjJadUc0a0VlNUM3VndaL2NhTDhwZWFQMDVja3o4VjVy?=
 =?utf-8?B?alUrN0taMHRrQUU0SkMyYXRweW5BPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:56:32.8111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a61deb15-bb00-4db1-a331-08de5cb06c03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDF5E260D0
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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



On 1/24/2026 12:03 AM, Gregory Price wrote:
> On Fri, Jan 23, 2026 at 10:43:12AM +0800, fanhuang wrote:
>> +bool e820_update_entry_type(uint64_t start, uint64_t length, uint32_t new_type)
>> +{
>> +    uint64_t end = start + length;
>> +    assert(!e820_done);
>> +
>> +    /* For E820_SOFT_RESERVED, validate range is within E820_RAM */
>> +    if (new_type == E820_SOFT_RESERVED) {
>> +        bool range_in_ram = false;
>> +
>> +        for (size_t j = 0; j < e820_entries; j++) {
>> +            uint64_t ram_start = le64_to_cpu(e820_table[j].address);
>> +            uint64_t ram_end = ram_start + le64_to_cpu(e820_table[j].length);
>> +            uint32_t ram_type = le32_to_cpu(e820_table[j].type);
>> +
>> +            if (ram_type == E820_RAM && ram_start <= start && ram_end >= end) {
>> +                range_in_ram = true;
>> +                break;
>> +            }
>> +        }
>> +        if (!range_in_ram) {
>> +            return false;
>> +        }
>> +    }
> 
> ------- nit --------
> this can be shortened: (j == e820_entries) implies not found.
> 
>      if (new_type == E820_SOFT_RESERVED) {
>          for (size_t j = 0; j < e820_entries; j++) {
>              uint64_t ram_start = le64_to_cpu(e820_table[j].address);
>              uint64_t ram_end = ram_start + le64_to_cpu(e820_table[j].length);
>              uint32_t ram_type = le32_to_cpu(e820_table[j].type);
> 
>              if (ram_type == E820_RAM && ram_start <= start && ram_end >= end)
>                  break;
>          }
>          if j == e820_entries: /* Not found */
>              return false;
>      }
> 
> Haven't looked at the surrounding code, this seems like you might define
> 
>     static bool e820_has_ram_region(start, end) { /* above code */ }
> 
> then the 820_update_entry_type lines can just be
> 
>      if (new_type == E820_SOFT_RESERVED &&
>          !e820_has_ram_region(start, end))
>          return false;
> 
> only worth it if e820_has_ram_region() deduplicates other stuff.
> -------------------
> 
> I don't see anything else immediately concerning and the above is more
> of a nit than anything.
> 
> I haven't tested this, you might at least add the OS-facing results to
> the changelog so someone can replicate your setup.
> 
> For example the early-boot print showing E820 and ACPI SRAT data.
> 
>     [reasonable memdev definitions]
>     -numa node,nodeid=0,memdev=m0
>     -numa node,nodeid=1,memdev=m1,memmap-type=spm
>     -numa node,nodeid=2,memdev=m2,memmap-type=reserved
> 
> resulting in:
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x00000000afffffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000c04fffffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000c050000000-0x000001004fffffff] soft reserved
> [    0.000000] BIOS-e820: [mem 0x0000010050000000-0x000001006fffffff] reserved
> 
> [    0.003409] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0xafffffff]
> [    0.003410] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0xc04fffffff]
> [    0.003411] ACPI: SRAT: Node 1 PXM 1 [mem 0xc050000000-0x1004fffffff] hotplug
> [    0.003411] ACPI: SRAT: Node 2 PXM 2 [mem 0x10050000000-0x1006fffffff] hotplug
> 
>    (fake entries above)
>    (i don't actually know if RESERVED gets added to SRAT)
> 
> This would at least show the node-association and the types are correct.
> 
> Thanks,
> ~Gregory

Hi Gregory,

Thanks for the review and feedback on v5!

Regarding your suggestions:

1. Simplifying the range_in_ram check:

I've updated the code following your suggestion, with one adjustment -
since the loop variable 'j' is declared with block scope in C99/C11, it
needs to be declared outside the for loop to remain accessible after
the loop exits:

   if (new_type == E820_SOFT_RESERVED) {
       size_t j;
       for (j = 0; j < e820_entries; j++) {
           uint64_t ram_start = le64_to_cpu(e820_table[j].address);
           uint64_t ram_end = ram_start + le64_to_cpu(e820_table[j].length);
           uint32_t ram_type = le32_to_cpu(e820_table[j].type);

           if (ram_type == E820_RAM && ram_start <= start && ram_end >= end)
               break;
       }
       if (j == e820_entries)  /* Not found */
           return false;
   }

This saves a variable, though it slightly trades off readability.
Would you prefer this approach, or do you think the original
'range_in_ram' boolean makes the intent clearer? Happy to go either way.

2. Extracting e820_has_ram_region() helper:

I searched the codebase and found that the other places using E820_RAM
(fw_cfg.c, tdx.c) are iterating to collect all RAM entries, rather than
checking if a range falls within RAM. Since there's no other code that
would benefit from this helper, I'll keep it inline for now. If similar
logic is needed elsewhere in the future, we can refactor then.

3. Adding OS-facing test results:

Great suggestion! I've replied the E820 and SRAT output examples to the
v5 cover letter, so reviewers can verify the expected behavior.

Thanks,
Jerry

