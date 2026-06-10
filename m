Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F729CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXKNV-0008Ck-4O; Wed, 10 Jun 2026 10:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1wXKMr-0007xi-2r
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 10:57:29 -0400
Received: from mail-westcentralusazon11010064.outbound.protection.outlook.com
 ([40.93.198.64] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1wXKMm-0001xZ-Rj
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 10:57:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLFO1Q/JtTBDdXoCXMQ0G9i3FNMuuxvrW3EBEtDaXGh5moWpDHwEv6MiUSdEp/2kToYvoqa4/0CMXa9Idpd1cEitR7KyZ+dJo+JDFwVtxjgNgrTyGlFEClvB3axVTVM8AmN62LfmgR/qXvbziJiSPFfHyNYiZponc7yOs2ZRZhpjWHWzAvNEgv6z/ArWwxOb8zxK6NqS5Xi6SKLqbN28jMknVqy1dwHRBO9rUigIZfBLLwMNaPPJV0yGxwyRbj9OcCnRKKzGPILw0BkvgFBrt54YS8pDt6NNqrxNxtTdyhXBfhjEdOg1Vg3L5HJGyp31S81pLgfEugE0mtFQVzXl5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5mXIW0UUPWPmzCwqlAHKz4Swe6/zA2VWj2PJTCNiDc=;
 b=yPKWJM6uvIEMc0Xz8x6woHMpJd+yMrhVRlF29JouWEq87PMeU6X2LiCkGzbCKtGFf55AClQr3/L28OPc/P3J+LFONHzbW2DEOaEdhL0Xx3LA8hl7m3u1J4ztA1pTS/yFlzCOS25Q9cyp7OpcxWJ+iBmrCPxbUsbtPzJtjZJ7I/4zOyZaI5HyZzCOgZMiYYmloSh4rNx9LW/4ioCEXWmUWYUDE+tju4FNdQhLm0wnjhuhkib8NSUSHkSlxfRGM1ATpcXFTyNH/KC9Eq80xYqB+6SPMwS1lLD4h+8RxU1cMvThNoR88XWdM4QkVgVa7vHJQ/avIlP5K9mzUThO11RLWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5mXIW0UUPWPmzCwqlAHKz4Swe6/zA2VWj2PJTCNiDc=;
 b=NbDtMnvUQiEgxmhhFeWIFFmgq+Q+9OlvWX2+Go4bRVyfaX2ytBjCm4gVIjHTFNAFP2gBzhwfQNTPGBdbokjGbV+tYlmPK9sliPesvz6/olrlmk1He9w/EEJ0dJMXUS10AJCZ5YXhx+D9UIoXo9XlBndLQwidqGS5GqrLxJrM5tU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 14:52:05 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 14:52:04 +0000
Message-ID: <88d332b0-8756-444a-9d32-53299a0ebfa8@amd.com>
Date: Wed, 10 Jun 2026 09:52:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/i386: SEV: Allow pflash devices with SEV-ES
 guests
To: Naveen N Rao <naveen@kernel.org>, Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Roy Hopkins
 <roy.hopkins@randomman.co.uk>, Srikanth Aithal <srikanth.aithal@amd.com>,
 Joerg Roedel <joro@8bytes.org>
References: <20260602071213.2084388-1-naveen@kernel.org>
 <b7xwzrdt4zg5g45ufhqj46d3f4uezpy733gnsc7bv4cploxevz@rw327aciq2cg>
 <ailAARL2xS7qSNzL@blrnaveerao1>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <ailAARL2xS7qSNzL@blrnaveerao1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0371.namprd03.prod.outlook.com
 (2603:10b6:610:119::19) To SN7PR12MB8131.namprd12.prod.outlook.com
 (2603:10b6:806:32d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8131:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c5913d2-1a90-4f71-a0ed-08dec6ffd589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|366016|1800799024|376014|56012099006|11063799006|3023799007|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1lL3k5ZHaDMrgCad3LtfUow/wYTsD7Aqp4j5urH5fvwWrDBTsStbJiSp8gw4NtUpHLcv0l2oK7dipBAc6H+kj2e1G2CVyQ/jRBYLteigTgmi4qSeUfV6kLoLZ8Sd21bU87BXCOr04eFRvaY7NlA7x6XOw/AzJvDJKSPQD/QhPuiC6lzoxu0ha9CGofK3wsyqURWqGq/qOC419VmREt0K1BCmnl/zrPyz+DwrI76ivp8e7Cs5hH9PzqvlGcAObzTyMuYnXsFp3vGkpf/sNLnpCZcSQVEoJfoitUO+PEH5TZx1pBITm8RtQHNt7COP9GoQ6gnbiglVaukBH/DhlfrytniRxCilt8jOmI6wqtnTPmCkAMPFPe3zT1S3rq5+hke9thAulXJnbmNFctoA8undVGXFwPZmMKsIrM4SaQQl/k6j9RhuHZxWskA6OjyBYcNPL6H7vj4zjM37JkubqgGH1RFre2YIHzLNbhQpnw8gUmiRHYVYVa2pD4cw/pz6L0Gx9RtFOc4qX2dgoCLneJXGzzbIJvo7gsghpJ1Uw80FTYVHFBksCWy5wpVDsJbLukMijZkrm6PPPoEnrzJRBMfA9vyWTLnLvvLHKib62PQJqRCkJlEnkDc7REHSiIXb5+QEbULCS3EwJ3DYKr2eKp/WR9Xzkt9yHje22yifN+BsMBuED7qDMtH0aKZXkfKRhO+6BiFsKiglW3oUWc//Z47xyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8131.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(376014)(56012099006)(11063799006)(3023799007)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG9RZHByMnVtNTVJU0NIUEdkYWk0Nnp6eXZsbmlVT0xES3hyMlRuVXBjbzVR?=
 =?utf-8?B?VWJPaVZjaDhkL0xTRmNtVFJFV1k1SEpPamFYUDRicVV3VzdZOTBDTzRuNnhU?=
 =?utf-8?B?aWphaWhSVStUU0NQNit5c2ZhNDBCQk5XL0g0dG5KTys2NGxBczJqSXVjVnNr?=
 =?utf-8?B?dG5aWlRNWjVsTGw0Y0RkbDdxRWNiU29pUllSMjE2S0tCNzFGY3VDNWpaNUtw?=
 =?utf-8?B?WS9DcEVHQzlldGU1bVFEZkxFeEJtWUFaZERjU2pOekQyWFVxYUpsRU90emVN?=
 =?utf-8?B?Q004dm5QcU1IbTJJOFNBNW92b3ZINXpQSUo4SXJHSnpsdklFaTFaZzI5VEE4?=
 =?utf-8?B?WTRwS0lpRk5KWEwweWVwTXN4VXNUaGNrazlpSHJnaTFhVm43VXZNUnBaMVVO?=
 =?utf-8?B?MzM5SGJoeFI0bUdRckx4dFRydjlDSTJlVE40ZXNrUk8rc0g2cWNsZlpPUmJD?=
 =?utf-8?B?Yml4dkZXUFZNM1VqdnAzMWRXOS9wS0NwVytTSThsYXpzUkZlOUlhdlNMa1FK?=
 =?utf-8?B?dkFWQndkUXltZWpDdXpFNVFKQnhrK2RjM0NKL0tBNDR4VWVKRFRDcEMxVGtU?=
 =?utf-8?B?emVYc2VBMXAzNFE1WGtFbXlLNG93YUs1bFFRQms3bzZCQ3R0NmpIL0kxTnF1?=
 =?utf-8?B?WXhsQlVMbVAyK0hMbmdRL1YzTXhuTURUck9ydzh3clgzbXVnQXJwVnBaa3lz?=
 =?utf-8?B?SDNZOXJyL3NSdzRlN0xoTEhtNlB6SUt5L0VkQndEOXRySVRIdjdaQ0c1YnpU?=
 =?utf-8?B?TnByQ2tzYVQ0clhUN2dIUzhQdGtUbitYSjZaWFp4a0NNbHc2WCt6Sy9CcUE4?=
 =?utf-8?B?eGh4QmVUR2tNV0VBOFJYSUtqR0VnamhtdGJrRkJSZklrNG5FNFBmU2xWdVc5?=
 =?utf-8?B?VTZsZUd2Z1c1ZndSdFdObzFEWm9rUGtvTXJ1L1ZjampDSHNCWlpJV1Ntaktj?=
 =?utf-8?B?NFp2NkkzT3RrbkFMVnQvYndlK0pnR3crU1pBTWVXamI5V1V3M1Y3Vzl5MnNp?=
 =?utf-8?B?UXdCQTdoODN2Sjg3TzM4UW5FSE9kTnc1Sld2VFVBR1AraUZMRnZvUnZWbW91?=
 =?utf-8?B?U3IyWlNzd3dHSHJ4MnovTXVmbjNsNFlBbi84aUlqbzFldWx6T0RFVmhZa3BT?=
 =?utf-8?B?eDN0RTlnc1lrNDlNZHNjQ3Bvd2YyMDIycm5vNVdyM1VHVklYR01pMEhkZHNY?=
 =?utf-8?B?WHRjdjhtekdxSldYRWlGWmQreVRlNHRZMVgyUzRwQlpuNVlWU0c4eWVoNjh5?=
 =?utf-8?B?VTN3Z1YvUnZtbmVySEhCYmRJNmZwVnhVRUtMdlZzdGhCOW53SldOSEhRK1M4?=
 =?utf-8?B?bGZrbnF3bEUzTWlER1BMVnd3RlJXMTVCL0hQc2pOYlJROTlWUWtpWUkvQTVU?=
 =?utf-8?B?MUpwZ1ZRK3plc3Fqb2RXeDlQdEYxS1V0aWg2dThRU0hPV29UdEJGdm81ckNo?=
 =?utf-8?B?U3pZaUJMM2JubUYrdCs2SnFSS2pLNG8yVUN6K3lrNGlyd3BGSFBma2ZFREFM?=
 =?utf-8?B?SlR0K1FPdTBQd3Z6TnF1L0IrOVZNWGJyVDZOK0NrV2UySjB6RVg5VzY4UnRM?=
 =?utf-8?B?VnJkdDI4aERaVlpKVlk4R1VvLy9SenF4ZEtHWFlYc055SHFrTUlIaGxDYVcv?=
 =?utf-8?B?QUJRWC85YXVlVGp2eXZjOUJxNFhOOEpmYWVZaTRNc3B3anZrZWd6aURiSnMv?=
 =?utf-8?B?SzdjSzc4R0ZEK2VJVlZsVFozc05ISml1cy9aV1JBQzNvbjhvK0hNbm4wYVZB?=
 =?utf-8?B?K1FUNk12RjhjT1lBQ21Bdlh2cmg0SnB4dkhTNElDNDVRZmdoa0NtaUhISEp1?=
 =?utf-8?B?bnkzNWtqSVFTYWx6UGQ2TDhvRi9sZm1ybE1zNVZIYk85V2YxUGRIVmgrbDJV?=
 =?utf-8?B?Sk85bVBGVC9lUThLNWFWMTBXVjEzVXYwcGlNSUd4ZWY2UXdsRDJNYXRXeXBY?=
 =?utf-8?B?WDlNK0s0R2hLeE93cm5CNlU2VHBDOXNxNm1aL0FDVUM0Zm1CcHNmYnZiU0d5?=
 =?utf-8?B?Q0djQTR6TGRnVVo5TCtMeWZvZStnZGYyMTZpdDh0d2QyYXF3aEQ1dmJEN1hS?=
 =?utf-8?B?ajFYeEpidGsxTjRVVmt6UC9YcDlwME5JOCtYdkh0ZDJQci9NODFaS3RhY2xy?=
 =?utf-8?B?NE9BV0pNM2lJM0VlZXNHSENrcktleWtJK0JWa0Q3ZjJzUUxyQzZKRzhsTk9s?=
 =?utf-8?B?bDBOZkg3SmlUQjVjeU5wWDc3MzcxMnplOUdYbFNyWVNWYkE4b1ZsUHROcEJZ?=
 =?utf-8?B?U29VVm1JMmdrbmI2Mi9zS2xKV0lnKzhPSzBTaTFGc1loUFBtcWdleDI0M2hm?=
 =?utf-8?Q?fewEj7FEVWwmZnio+L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5913d2-1a90-4f71-a0ed-08dec6ffd589
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 14:52:04.1226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdbXJNT9YUZubuEYjYH7YRPyDKTwr4yfM0TGVjmaf61Qfw5TF1CHswZ2ACNiojtzXioSn4yVtIZmRNG0jYA5vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
Received-SPF: permerror client-ip=40.93.198.64;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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

On 6/10/26 06:30, Naveen N Rao wrote:
> [+Sean]
> 
> Hi Mike,
> 
> On Tue, Jun 09, 2026 at 07:35:46PM -0500, Michael Roth wrote:
>> On Tue, Jun 02, 2026 at 12:42:13PM +0530, Naveen N Rao (AMD) wrote:
>>> KVM commit 66155de93bcf ("KVM: x86: Disallow read-only memslots for
>>> SEV-ES and SEV-SNP (and TDX)"), and the subsequent commit d30d9ee94cc0
>>> ("KVM: x86: Only advertise KVM_CAP_READONLY_MEM when supported by VM")
>>> stopped advertising KVM_CAP_READONLY_MEM support for encrypted guests
>>> (KVM_X86_SEV_ES_VM and KVM_X86_SNP_VM), but not for KVM_X86_DEFAULT_VM
>>> type SEV-ES guests. As a result of this, it is no longer possible to
>>> start SEV-ES guests with any SEV feature enabled (in particular,
>>> debug-swap) with pflash devices.
>>>
>>> This is an issue since SEV-ES guests have historically used pflash
>>> devices for OVMF. Guests on older KVM+Qemu are able to enable debug-swap
>>> while using pflash devices, so work around the KVM limitation by
>>> switching to using a VMA-based write protection. This allows
>>> well-behaved SEV-ES guests to continue to work with pflash devices and
>>> enable debug-swap. Mis-behaving guests trying to write to the protected
>>> OVMF area will be killed.
>>
>> Based on Sean's description, a write access to a read-only memslot would
>> cause the vCPU to permanently spin on #NPFs if trying to write to it as
>> MMIO due to #VC handler not triggering, and that's why we don't support
>> read-only memslots. But since SEV-ES was previously working with pflash,
>> it seems like it does not rely on this functionality...
> 
> Right, normal well-behaved SEV-ES/SNP guests work just fine as they 
> don't write to any of the read-only areas.

Yes they do. There is specific support to make a direct GHCB MMIO
request because of the lack of the #VC exception (see
OvmfPkg/QemuFlashFvbServicesRuntimeDxe/QemuFlashDxe.c).

Thanks,
Tom

> 
>>
>> So if OVMF isn't writing to write-protected memory, then it wouldn't be
>> triggering the MMIO emulation path in the first place. And if we don't
>> care about enabling the emulation path in this case... then I'm not sure
>> the original reasons for not allowing it for SEV-ES/SNP are applicable.
> 
> Guest (not just OVMF) could try and write to the read-only area 
> triggering this issue. A simple write to 0xc0000 from within the guest 
> triggers this.
> 
>>
>> It feels like KVM_CAP_READONLY_MEM is more like KVM_CAP_EMULATE_ON_WRITE,
>> whereas we literally just need as actually slot that's permanently mapped
>> in the NPT without write access.
>>
>> Is that an accurate summary of the situation?
> 
> Yes, that sounds right to me.
> 
>>
>> If so, maybe we can introduce a KVM_CAP_READONLY_NO_MMIO that captures
>> this and simply errors out if it hits the KVM_PFN_ERR_RO_FAULT.
> 
> That would certainly work.
> 
>> Or, for
>> a QEMU-specific workaround, just have a pflash implementation that doesn't
>> rely on KVM_MEM_READONLY for cases like this where we don't need MMIO
>> emulation.
> 
> Not sure I follow that... are you suggesting that pflash use regular RW 
> memslots and just let the write through?
> 
> 
> Thanks,
> Naveen
> 
>> There's actually another case in hw/nvram/nrf51_nvm.c where this
>> would be applicable. I guess it could be done automatically for the
>> confidential VM case to retain cmdline compatibility...though you're
>> wanting to add the debugswap feature anyway so not sure how important that
>> aspect is.
>>
>> Thanks,
>>
>> Mike
>>
>>>
>>> Enable VMA protection and set the memory to be RO when adding the KVM
>>> memory slot. Because pflash devices support command-mode, change VMA
>>> protection to RW when tearing down the KVM memory slot. KVM
>>> SEV_LAUNCH_UPDATE also requires memory to be RW, so disable the
>>> protection when calling that.
>>>
>>> Print a warning when switching to VMA-based protection so that it is
>>> clear that KVM itself isn't supporting readonly memory, and that a
>>> workaround is in place. Users can plan on switching to using '-bios'.
>>>
>>> Finally, drop the check rejecting SEV-ES guests with SEV features so 
>>> that debug-swap can be enabled.
>>>
>>>
>>> Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
>>> ---
>>> Background discussion on this issue:
>>> http://lore.kernel.org/r/aUq9_cUDWeEW_qli@google.com
>>>
>>> This series depends on VMSA features support:
>>> http://lore.kernel.org/r/cover.1779281646.git.naveen@kernel.org
>>>
>>>
>>> - Naveen
>>>
>>>
>>>  include/system/kvm.h     |  5 ++++
>>>  include/system/kvm_int.h |  1 +
>>>  accel/kvm/kvm-all.c      | 52 +++++++++++++++++++++++++++++++++++++++-
>>>  hw/i386/pc_sysfw.c       | 19 +++++++++------
>>>  target/i386/sev.c        | 21 +++++++++++-----
>>>  5 files changed, 84 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/include/system/kvm.h b/include/system/kvm.h
>>> index 5fa33eddda38..585058bd6f1c 100644
>>> --- a/include/system/kvm.h
>>> +++ b/include/system/kvm.h
>>> @@ -555,6 +555,8 @@ uint32_t kvm_dirty_ring_size(void);
>>>  
>>>  void kvm_mark_guest_state_protected(void);
>>>  
>>> +void kvm_enable_ro_mem_vma_protection(void);
>>> +
>>>  /**
>>>   * kvm_hwpoisoned_mem - indicate if there is any hwpoisoned page
>>>   * reported for the VM.
>>> @@ -568,6 +570,9 @@ int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
>>>  
>>>  int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);
>>>  
>>> +void kvm_set_memory_readonly(void *addr, size_t len);
>>> +void kvm_set_memory_readwrite(void *addr, size_t len);
>>> +
>>>  /* argument to vmfd change notifier */
>>>  typedef struct VmfdChangeNotifier {
>>>      int vmfd;
>>> diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
>>> index 0876aac938d3..0e083a56ce2a 100644
>>> --- a/include/system/kvm_int.h
>>> +++ b/include/system/kvm_int.h
>>> @@ -123,6 +123,7 @@ struct KVMState
>>>      OnOffAuto kernel_irqchip_split;
>>>      bool sync_mmu;
>>>      bool guest_state_protected;
>>> +    bool guest_wants_ro_mem_vma_protection;
>>>      uint64_t manual_dirty_log_protect;
>>>      /*
>>>       * Older POSIX says that ioctl numbers are signed int, but in
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>> index 96f90ebb240f..4208df5b25ac 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -1629,6 +1629,42 @@ int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size)
>>>      return kvm_set_memory_attributes(start, size, 0);
>>>  }
>>>  
>>> +static void kvm_set_memory_flags(void *addr, size_t len, int flags)
>>> +{
>>> +    if (mprotect(addr, len, flags)) {
>>> +        error_report("failed to apply memory protection "
>>> +                     "(0x%" HWADDR_PRIx "+0x%" PRIx64 ") error '%s'",
>>> +                     (hwaddr)addr, len, strerror(errno));
>>> +        exit(1);
>>> +    }
>>> +}
>>> +
>>> +void kvm_set_memory_readonly(void *addr, size_t len)
>>> +{
>>> +    if (kvm_state->guest_wants_ro_mem_vma_protection) {
>>> +        kvm_set_memory_flags(addr, len, PROT_READ);
>>> +    }
>>> +}
>>> +
>>> +void kvm_set_memory_readwrite(void *addr, size_t len)
>>> +{
>>> +    if (kvm_state->guest_wants_ro_mem_vma_protection) {
>>> +        kvm_set_memory_flags(addr, len, PROT_READ | PROT_WRITE);
>>> +    }
>>> +}
>>> +
>>> +static bool kvm_mem_wants_vma_protection(MemoryRegion *mr)
>>> +{
>>> +    if (!memory_region_is_ram(mr) &&
>>> +        (mr->readonly || mr->rom_device) &&
>>> +        !kvm_readonly_mem_allowed &&
>>> +        kvm_state->guest_wants_ro_mem_vma_protection) {
>>> +            return true;
>>> +    }
>>> +
>>> +    return false;
>>> +}
>>> +
>>>  /* Called with KVMMemoryListener.slots_lock held */
>>>  static void kvm_set_phys_mem(KVMMemoryListener *kml,
>>>                               MemoryRegionSection *section, bool add)
>>> @@ -1642,7 +1678,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
>>>      void *ram;
>>>  
>>>      if (!memory_region_is_ram(mr)) {
>>> -        if (writable || !kvm_readonly_mem_allowed) {
>>> +        if (writable || (!kvm_readonly_mem_allowed &&
>>> +                         !kvm_state->guest_wants_ro_mem_vma_protection)) {
>>>              return;
>>>          } else if (!mr->romd_mode) {
>>>              /* If the memory device is not in romd_mode, then we actually want
>>> @@ -1697,6 +1734,10 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
>>>                  kvm_slot_sync_dirty_pages(mem);
>>>              }
>>>  
>>> +            if (kvm_mem_wants_vma_protection(mr)) {
>>> +                kvm_set_memory_readwrite(mem->ram, mem->memory_size);
>>> +            }
>>> +
>>>              /* unregister the slot */
>>>              g_free(mem->dirty_bmap);
>>>              mem->dirty_bmap = NULL;
>>> @@ -1746,6 +1787,10 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
>>>              }
>>>          }
>>>  
>>> +        if (kvm_mem_wants_vma_protection(mr)) {
>>> +            kvm_set_memory_readonly(mem->ram, mem->memory_size);
>>> +        }
>>> +
>>>          start_addr += slot_size;
>>>          ram_start_offset += slot_size;
>>>          ram += slot_size;
>>> @@ -4771,6 +4816,11 @@ void kvm_mark_guest_state_protected(void)
>>>      kvm_state->guest_state_protected = true;
>>>  }
>>>  
>>> +void kvm_enable_ro_mem_vma_protection(void)
>>> +{
>>> +    kvm_state->guest_wants_ro_mem_vma_protection = true;
>>> +}
>>> +
>>>  int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
>>>  {
>>>      int fd;
>>> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
>>> index 1a41a5972bd0..9590458e00c5 100644
>>> --- a/hw/i386/pc_sysfw.c
>>> +++ b/hw/i386/pc_sysfw.c
>>> @@ -254,13 +254,18 @@ void pc_system_firmware_init(PCMachineState *pcms,
>>>          }
>>>      } else {
>>>          if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
>>> -            /*
>>> -             * Older KVM cannot execute from device memory. So, flash
>>> -             * memory cannot be used unless the readonly memory kvm
>>> -             * capability is present.
>>> -             */
>>> -            error_report("pflash with kvm requires KVM readonly memory support");
>>> -            exit(1);
>>> +            if (sev_es_enabled() && !sev_snp_enabled()) {
>>> +                warn_report("pflash not supported with SEV-ES guests, "
>>> +                            "attempting VMA based protection");
>>> +            } else {
>>> +                /*
>>> +                 * Older KVM cannot execute from device memory. So, flash
>>> +                 * memory cannot be used unless the readonly memory kvm
>>> +                 * capability is present.
>>> +                 */
>>> +                error_report("pflash with kvm requires KVM readonly memory support");
>>> +                exit(1);
>>> +            }
>>>          }
>>>  
>>>          pc_system_flash_map(pcms, rom_memory);
>>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>>> index f04ae4e91f3e..82cf2c562729 100644
>>> --- a/target/i386/sev.c
>>> +++ b/target/i386/sev.c
>>> @@ -550,12 +550,6 @@ static int check_sev_features(SevCommonState *sev_common, uint64_t sev_features,
>>>              return -1;
>>>          }
>>>      } else {
>>> -        if (sev_features && sev_es_enabled()) {
>>> -            error_setg(errp,
>>> -                       "%s: SEV features are not supported with SEV-ES at this time",
>>> -                       __func__);
>>> -            return -1;
>>> -        }
>>>          if (sev_features & SVM_SEV_FEAT_SNP_ACTIVE) {
>>>              error_setg(errp,
>>>                         "%s: SEV_SNP is not enabled but is enabled in VMSA sev_features",
>>> @@ -2024,6 +2018,15 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>>>          return -1;
>>>      }
>>>  
>>> +    /*
>>> +     * Use VMA-based protection for SEV-ES guests that enable any
>>> +     * SEV feature, since KVM does not advertise readonly memory
>>> +     * support for non-default type SEV guests.
>>> +     */
>>> +    if (sev_es_enabled() && SEV_COMMON(cgs)->sev_features) {
>>> +        kvm_enable_ro_mem_vma_protection();
>>> +    }
>>> +
>>>      if (!cgs->ready) {
>>>          /*
>>>           * SEV uses these notifiers to register/pin pages prior to guest use,
>>> @@ -2111,7 +2114,13 @@ sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
>>>      if (sev_check_state(sev_common, SEV_STATE_LAUNCH_UPDATE)) {
>>>          int ret;
>>>  
>>> +        /*
>>> +         * KVM requires these pages to be RW, so remove VMA RO protection
>>> +         * for the duration of SEV_LAUNCH_UPDATE if using SEV features.
>>> +         */
>>> +        kvm_set_memory_readwrite(ptr, len);
>>>          ret = klass->launch_update_data(sev_common, gpa, ptr, len, errp);
>>> +        kvm_set_memory_readonly(ptr, len);
>>>          if (ret < 0) {
>>>              return ret;
>>>          }
>>>
>>> base-commit: 5611a9268dae7b7ff99d478ed134052a9fc7e9f7
>>> prerequisite-patch-id: dc27ad6297d47d063b04fa797c1b8203ee97d9c8
>>> prerequisite-patch-id: 603eff49233c4b0483e7c405754b95aa455dd38c
>>> prerequisite-patch-id: d4085e72ecfb0fbf977f7358d1edd29951b93784
>>> prerequisite-patch-id: f6f201825b1e56f89a87a26bc457b3e6018aee49
>>> prerequisite-patch-id: 08d79cec4c3f117178be8f6c866ff1be08e971f3
>>> prerequisite-patch-id: c112bccab9ab9cee2d0227516fc857590b99a75b
>>> prerequisite-patch-id: f42fd829d0ea4909537e722477057a4013a247ab
>>> prerequisite-patch-id: 67136368ed1d2fa0ae55fee4368a7bd1fe394368
>>> prerequisite-patch-id: 08349bb1e0e11ee1518a9041771302c97866b5cd
>>> -- 
>>> 2.54.0
>>>
>>>


