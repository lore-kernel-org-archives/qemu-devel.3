Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DE5CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXKIg-0006k6-F7; Wed, 10 Jun 2026 10:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1wXKIf-0006js-3Z
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 10:53:01 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1wXKId-0007C5-7P
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 10:53:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfNmquZXxsR0xDwpUp0/TGO0/mbcefKGp134NJTY1XaqJoBXex90ICC3MZNkm8I7UtWbAkWsL3qQ4y/sGR3QHF/88e38kUv/cl080XKW2tOP2Ml54UFGhS2uD+gouQejH+b0E09LDWib5XZkX8lGmyKUuqPOOJPIfQoN/kL6YDpVslmGnOSLQNlwS2UqWySphy4A0NmFc35O5nuygqZUsnprvaypiFlR3bCSIWVzxYYOCiRkVKlgwKaIyv0KA9bXS4JT+qcG7/SfJ+NzsM266dHz0O5/yuIgqOsc5xt0rj4w/4+ARfr0tNK8hA75QlfwaKk560Kict0MzwwOAZTr6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3b0YMC+/CrGcx87KQCuGQ2dHXFTqtR+FQy9cbJujnw=;
 b=h2jswx12XgBOlEP/pjhHK0eYDm3ejU6WkUqSh1/mQEpH8Vcdx8Un2fR61u9ATP4DmrgjvzQifEdSAYBAtRVO9R1+HrFiKh2A7z1tf7zwhL/wmQW2klFwn93xfRAFD9lu2eRL/y+RQd0uOCFKijG96uqM4CuZ8/EyNd34T78xp6L6Uc7UT8mJNqtjZgRjNL//f6D8yM0l61uLfnrpdULS2U6gWxPq3hHEpTW9XbI8JrJo+KFW/C8Gdnyih6A1FosY4qg2adA6fpQlSQN1HOZYxOvopsDnyTPakyrxLsMQHDvPylSVXYxrxF2jO2Wyvsr1EkeLgxTcJNzzhA3Oz7OlEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3b0YMC+/CrGcx87KQCuGQ2dHXFTqtR+FQy9cbJujnw=;
 b=gAtWhC3OWuDqZJ2QRjMczyQzrKTqfN3AbbZPu/5+RzOkdSXPzBrOLeOCwcSsyyGJh0gx42Kz6KWR+eYSWU99YgW7+dngJIMa63JWV3K6QTIrcrBTXXZ2wGEwHaJv7EN2J7kmMYQPoXyt5V8q2P5iuR8jQFSYnwpaLRC6xQGLECQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by DS4PR12MB999077.namprd12.prod.outlook.com (2603:10b6:8:2f9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 14:52:54 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 14:52:54 +0000
Message-ID: <1850ceaf-dfd0-43e6-a799-0da08e2b0bda@amd.com>
Date: Wed, 10 Jun 2026 09:52:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/i386: SEV: Allow pflash devices with SEV-ES
 guests
From: Tom Lendacky <thomas.lendacky@amd.com>
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
 <88d332b0-8756-444a-9d32-53299a0ebfa8@amd.com>
Content-Language: en-US
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <88d332b0-8756-444a-9d32-53299a0ebfa8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0381.namprd03.prod.outlook.com
 (2603:10b6:610:119::16) To SN7PR12MB8131.namprd12.prod.outlook.com
 (2603:10b6:806:32d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8131:EE_|DS4PR12MB999077:EE_
X-MS-Office365-Filtering-Correlation-Id: deefe6fd-ab7d-42f4-4a62-08dec6fff3fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|23010399003|376014|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: 8l1cwHiPvZ7PSHE61Z0CweB+czn9jKaLPFZfypE+cxPhkCjzRS9AsxT0PDtLYjsfj5GUAPVm+OXxBCo54rUNJk3Qta2Po6QUdGHJoTh6B/z+PDP6q+/PO7rx8lyVq7F12+WBhEMTZfGZw9IGfQmTPJVa4DysNytYSXVioOhF+rmgZVeM7a7oxOrnYIIZJLTfui3KJZx3aXtX5Wk5/jd5xJtdQoA77pbLpTi4kz1UGfao9cZGRUXWAAQ7UnVXZEwy1oVfAKtlA2kO5j+kSyKdama4YaVHg18jB7duECGGjcnWRNScs4IOj+KrFXwNRDCNT1VmXU9JqTstQWmvyZf2MUQ0g7wvgcEYIWcpsa9pEdZ7FqtGJu93DRp5V+xqltbPg6wsFM54xA133Jk6FLHWe3RTm2jaYVRugfQ2Q0vnko9nXnWMgRIXE0g4eHNb5xxfnfTXbgZe37fBaTLjLrMuMGJoK0vSAA46gOEV1kDwgRBm2DebxfkLnYmNpTHV0U2mqBeczl8coZbF0RnjnpZNM244OqVlOQ80dw4LFi5jU30xNkbfo7gFjWiJlDWQOkLp3D1f3DLAbLc3e+XrPmjUzGVdekNf/qmxpY8t8y5Vd/Urtepj3Y9hvLP45t/SM1baZ3o8TtwS8YcOPtLH0ypLzf6EaLd7dnXeO0of7myz3DpzzeC9q9BzUfx34Sw0mAWw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8131.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUVkRG50VEcrL3M1alhCWndQSkMwbmxtRUY5UkNUS2NGTUZZNmkrWDRvL29S?=
 =?utf-8?B?eE1vYXJLZDd2STFkZzdzZDFtR2FPQjRQZU5nODJBamdpVWZLQ1hXN3plN2Nk?=
 =?utf-8?B?aWxyQS9xYXlrdEoreEVaaTFlMDloSUFLbHRTNWt2Snc3NWxnQjhoenJtM0lx?=
 =?utf-8?B?Z2prSCt3NXdCQXB4K1VqNmI1TndTemIzMWxZRytOaUxNVGZyRnRaZldRZ2hh?=
 =?utf-8?B?QXR1Y25qMmxyMUg0WlhwMktnTjFQRlp5TjNMU2V0Q3VkQVhxQnhYTzljZmZ0?=
 =?utf-8?B?blM3WEIva2d2Y3RMZThmbGpQZlY1a21tUUg4Zzc5YktqeUhzQnNoMUpZMDhs?=
 =?utf-8?B?UFBCOHBXUGVuak5HbXF1VUJab3BwKzI5WWU3b2s2Z3krWnhFeTM3SjM0UzRX?=
 =?utf-8?B?YzN1Q3ZSMEtheG1JaWNjNkI2RW5wK3d4cXpJRkRHdXM4QUJTWVVpZnVWeC80?=
 =?utf-8?B?U1lNVGxxSzlJdDRSTXJUNjk5MDk2cWN5c1lXa3pjM2dhcS9HNjFyM0REc3hn?=
 =?utf-8?B?RWtvK2V1SXNKT0tRY1BrR3hpZXByaVhDZWkyNVNKbHZlUy9rK0hmYVgzQURa?=
 =?utf-8?B?dDFiWE81V0hjcVpUN2xLd2k1aUpmSlNuL3NRUkhYZG9iY0xpamZrNVVyRTl5?=
 =?utf-8?B?WW91cGJONHg1K29pTklEcGE1OGptWTdmaDhscUpETXZmOTN6bDkrMnRtWmxs?=
 =?utf-8?B?L0IzU3RHNGxJZUg0OXhWQzVqdkRJNHljdDJnYU9zSWZNT2E4cHV3QldRcElJ?=
 =?utf-8?B?bktvL2lWZ0Fob0JDcUg1V3l0ajR2WWZoNEFYNmZ4ODZrVnZ4WnhXVHh0Ykli?=
 =?utf-8?B?UENmZWpOazhoSXZ6bXVZNi91Z0MxcWtwS3NINDczNzVQWW94eHhQMU91MFFD?=
 =?utf-8?B?cjJzcExwQWtZb2NuZGNaWDJ1VUk5RWk3d2NRdVB6VExTRnh3MlNZV2hrcmxM?=
 =?utf-8?B?Q0RiSGphRjUrRFQxYnRrNjJXSXNOcU55bFA1bDNGdUtMTW5lLzJFeWkwSWxj?=
 =?utf-8?B?VEhuOXdPWHd0TVRUNW9LTUVIcVMvZVVCNDlMYVpQalp0ZWZQbDg2RjJCVzd5?=
 =?utf-8?B?RlBvSGs5M2IyTTNTNlNWT29yWHFSWEYyOUsyckJGMSs0UnowMkpPb21Od1Ur?=
 =?utf-8?B?Mlp4TngzQjZiTjQ0VHRTcmR6SEhxdjl5UGtDWlhCaGgzRXZMUlgrbEJFSGNz?=
 =?utf-8?B?RDlmTzlwYWRoSEYyWG9qeEtyVGdUeHlSZVEwajRjK2FnTlBVNGNUT0txWDh5?=
 =?utf-8?B?aUhqc3FhQTYzMjZ2WGlnRDdRQmxoT2JOQThTQThlUXhqbWhIeFZDa0VDR2NB?=
 =?utf-8?B?Zk01TFQ5LzNFOGNncEU0VlBMWUtMVTlJQkp1MXpjT3R4NmQzZHdLOS8vWnAw?=
 =?utf-8?B?TEhrTFFaWjZlMzZkR0w4VXUyeVc1WGlNL2tkZVMvaytBQ20yNk5nVmtYMTJo?=
 =?utf-8?B?THJKK0poWlgyZmM3VVU0SURtdlVEYTFseGRoUi9ZQm5xa2EyUlJ4UU10eGJs?=
 =?utf-8?B?Y1lRUFErcmZjYnBSVkh4b3lmN2lkNVc4N01Gbm5JeGZQb2tkTjU0YVdNbUxR?=
 =?utf-8?B?dWVKc2crbmNCNGR2M3hHbWlHMmpvOU5adHFrTDJBYTRrNWV6Skg3MjRYUHNO?=
 =?utf-8?B?aVM3dDRMdVhHTS9wMVhiTXNSRXVrNW9YTTFHeXJIK1cza0hyZXloOXJ6VE9a?=
 =?utf-8?B?QzgvSk4rZXVDSTNxc2l1cHdpRXNkOW8zTkN2azBWY3ZhTG9oT01iOVd1OVYx?=
 =?utf-8?B?akFZMWsvWEZqSkowT3N0OCsxSWFsTjcxNEVIajZlRVBxS3lDOHJhYTZVREt6?=
 =?utf-8?B?Z0NRZ2xNRVgweUl1YVJFZGduNHZPd3VDZkpGUXYwZGg5eW1TYjZwVGxxdlZ0?=
 =?utf-8?B?aGo4ZU56Y3Y2RVFXc3Y3K1RsTWZwK0JqSXhUSVNjY1AyczdHSVk0WEFHZXFJ?=
 =?utf-8?B?emFZMlF6ZFdZOEJjdW1UeXJSQnAvU21jQ29jQzQ0alcrWkpvNG9ZSTZ0dGZm?=
 =?utf-8?B?UVlSUWowcytrN3lKcER1N2dqU1BpWmNqM3ExZ3JXSlFGc2RmWnRtSklURTA4?=
 =?utf-8?B?a3lJVGIxdGlsdThlbDdKZis1bUpKU0d5SURsTWdOQ1RXejZ4aXIxdzNuTlp4?=
 =?utf-8?B?dnFCOVpXR1MvQUpGS295TDRhMEg4cEtoVFllZ1RlU2p5Y2VTVEhscUVMNmJK?=
 =?utf-8?B?cG5xTVdRRnp1bThZRVFISS9Ha1ZVVG90NHJqYUdLMXRFTXdxT0VTeC96ajll?=
 =?utf-8?B?b3ZTbkZydEd2UzhDQVUrMngyUEZnci95d1NJUUQ2b2pHSVBOWndqdFJ0Ykdl?=
 =?utf-8?Q?DQXY8wR+gIa46QraAf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deefe6fd-ab7d-42f4-4a62-08dec6fff3fd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 14:52:54.6948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7mqrU3vBHrseq0rejioDTl7OY93341kNP2BiSVZwfyaTkgRioDtESM0NLlpxMGG2r9pUyn+hW2mwdXbwxm8xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999077
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 6/10/26 09:52, Tom Lendacky wrote:
> On 6/10/26 06:30, Naveen N Rao wrote:
>> [+Sean]
>>
>> Hi Mike,
>>
>> On Tue, Jun 09, 2026 at 07:35:46PM -0500, Michael Roth wrote:
>>> On Tue, Jun 02, 2026 at 12:42:13PM +0530, Naveen N Rao (AMD) wrote:
>>>> KVM commit 66155de93bcf ("KVM: x86: Disallow read-only memslots for
>>>> SEV-ES and SEV-SNP (and TDX)"), and the subsequent commit d30d9ee94cc0
>>>> ("KVM: x86: Only advertise KVM_CAP_READONLY_MEM when supported by VM")
>>>> stopped advertising KVM_CAP_READONLY_MEM support for encrypted guests
>>>> (KVM_X86_SEV_ES_VM and KVM_X86_SNP_VM), but not for KVM_X86_DEFAULT_VM
>>>> type SEV-ES guests. As a result of this, it is no longer possible to
>>>> start SEV-ES guests with any SEV feature enabled (in particular,
>>>> debug-swap) with pflash devices.
>>>>
>>>> This is an issue since SEV-ES guests have historically used pflash
>>>> devices for OVMF. Guests on older KVM+Qemu are able to enable debug-swap
>>>> while using pflash devices, so work around the KVM limitation by
>>>> switching to using a VMA-based write protection. This allows
>>>> well-behaved SEV-ES guests to continue to work with pflash devices and
>>>> enable debug-swap. Mis-behaving guests trying to write to the protected
>>>> OVMF area will be killed.
>>>
>>> Based on Sean's description, a write access to a read-only memslot would
>>> cause the vCPU to permanently spin on #NPFs if trying to write to it as
>>> MMIO due to #VC handler not triggering, and that's why we don't support
>>> read-only memslots. But since SEV-ES was previously working with pflash,
>>> it seems like it does not rely on this functionality...
>>
>> Right, normal well-behaved SEV-ES/SNP guests work just fine as they 
>> don't write to any of the read-only areas.
> 
> Yes they do. There is specific support to make a direct GHCB MMIO
> request because of the lack of the #VC exception (see
> OvmfPkg/QemuFlashFvbServicesRuntimeDxe/QemuFlashDxe.c).

Specifically the QemuFlashPtrWrite() function.

Thanks,
Tom

> 
> Thanks,
> Tom
> 

