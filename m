Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8618C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9TZl-0005z0-AZ; Wed, 23 Sep 2026 16:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x9TZi-0005yh-FH
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:28:18 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x9TZg-0004PZ-BA
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:28:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjhyuc9ynZiTCpB/npC22Mt/FMrCAftVub34meM95MMVoRTDfXghAki1/vO9YikPC1A1El1b+buGc5v9I3FD7LmcTMg0w6aEGFFEsrhILona252Z2j5Umr/vT8F5LEzwWwXRMg0hy3mO1XZtByL2CT7ngUoJRpr96MzotWNC/QlNx5w4icdfcDn7Y4PtJq2VXSdTcvKz/AYG9tO/NiOYMVkmSaWRyG/zT1q2k1HnocJ/0GTl6O4cR8ulSBbe9/EDkl5rcu5YevHmqlyx5pondUSZWVhFMU5p8NkTwu5pK7/ERA09P6wNc70kmfIIvSmvPrvaoyJflknEBczWEYbLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QK6YW/TP6vmAAGUHs4KwcIa7L4lOHi8ZQnNZNOuBezA=;
 b=Aelc2vSPBh/5nyI4RhykkPUGSi4l2S2+3Rzn5BWHKgUjCts64lHLGmfmG7B+f43g1FfRwSKUxbm+aamirjXNEoBXGKTV6pV18o+5zG1q+xMotm/cTG8OJpfXfZT5OyaHDQ4bFLHSA86g723MJYvrZx09369tyfO406zfxZecC/7gzffX0ysKv3nr2g+nbmQ89cHyXHJlDNDpVSY5oAb06POdgqprwAZhaoSqjykJwteJLx/FUhYlDlndcU7TR/kX6SEPblxsdDr+RB5MHu0b/bz0qOOU0iOrz3yIGPXoU9KKS38J712SiBaG6m3mvnWh0lykC7cNmI9UuYwGl6ex8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QK6YW/TP6vmAAGUHs4KwcIa7L4lOHi8ZQnNZNOuBezA=;
 b=FSVRA4A1/QZJkkC192XIqiicua3rGpncwrovjSA3lEp6AgtG1aTqjvvZN7tbQzveWmvq9ig7Clt/WNMjiKN7qNT/rzLQ12KMiDgRFCzRoCuqydC5Wu2VnApbaYd1ajQxG7aNjc/EnUavOz6eF7uBgQyZkxlnbUB6IeWklPH2VIvDAW1tY61VRn0y4pOBiFY7FXybTv53zHh8YqVt5wx8ZtY2QbNWM0byh1rSzs0usI1dsRmCXPge/cv3tU49Wa2mRDVkihrp72IOau4sjFucxr5uedE8yYuVOi0dCpBxzzgDLUOlMzWwkZAmpryUg7LJ1IYDQ9lulooL1qKOBMPHow==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by LV0PR12MB980390.namprd12.prod.outlook.com
 (2603:10b6:408:3ef::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 20:28:11 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 20:28:11 +0000
Message-ID: <5f83de55-0bd5-48f8-92c7-95f5d40dc00f@nvidia.com>
Date: Wed, 23 Sep 2026 15:28:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] MdeModulePkg, ArmVirtPkg, OvmfPkg: fixed PCI BAR
 placement
From: Tushar Dave <tdave@nvidia.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: devel@edk2.groups.io, gaoliming@byosoft.com.cn,
 ardb+tianocore@kernel.org, sami.mujawar@arm.com, jiewen.yao@intel.com,
 qemu-devel@nongnu.org, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com
References: <20260916192408.928411-1-tdave@nvidia.com>
 <aq06JQWs6KszJI9w@nucbdw.ghoffman.csb.home.kraxel.org>
 <7c826624-113a-40b9-841b-1bd8c375a9bc@nvidia.com>
Content-Language: en-US
In-Reply-To: <7c826624-113a-40b9-841b-1bd8c375a9bc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::16) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|LV0PR12MB980390:EE_
X-MS-Office365-Filtering-Correlation-Id: e1eaa06c-a9b8-4f61-14c3-08df19b13003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|6133799003|22082099003|18002099003|5023799004|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 0qZJ6z/Pj8E1p0a5Q/oHnTlCaCIEIAbq+GZiHuzPT0AD+duDugtogCE6UuMbLGUkWpj5z8LSbu45kZ5rGELdMlJZRHhDI5NPj6pncPotiwfcRyoB7+zD+t2h+PNnsZz7YyJWGCKJF9BOZBfUXYru8Mz5ruiFrXK2z75YW2MSN4CqlOtVMSRMZxJkwcjUlSOZG+7uU17GMMgd4cHSK9r3neTASYnsMjyyFf6aG3QP3JyiQakLlkKLgqJIVdF1dLX9+TqrSa5K8WwKo1DFwmRd4m8yxk3zuTfbNIZWaPgikBfaqfavciNmXGKDkh/s0S4n8KbyR5tfkQQ2h4sBoYpdfvxy8ZdQ+5nKDzJgENX6+IKEBmWZJrodAFAZIjGNwFo+PjupfDm5Rg7ySVGRvWw7QGxqGqht7jFtFjtVf4KxWyQ6Iq+x0SGS3EGGTAfpqeqH0YVkF/5haoMal4lvG4zJKKqTr3z/FFbqtWYjr4zsTKd+cF32Xcozj7VI6TFBc3UoyIjSbobLTsUPRa1GvcGp45K5bU8wsJq6R3d4kqcG2gIK03X33JiMQJBr8N5wSjN+H7zNcYlmcil7p4VlZc5itSIFQo64LbtuJQU+VuK4WhkDNSOwP1efPhxo0VWxREVSnfG6f65uXfjvtAnSIbu/6feoVePGMTdVYQikNRiL/tI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(5023799004)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWJFUzVWbU5IV2RxYTJxMXN5MDhEWThIb3ZGcGVyYW9penc3M3NySFRmbGhS?=
 =?utf-8?B?Ukl0bDdRMFFSdzIvRDFDcDRmdy84ZzRTcjVNem5iRjJXNjcyVUN6bWtBSEhq?=
 =?utf-8?B?UmE2c2pxTnVQdWx4STF4a2JVc0poeE0zWEtHK3Vob0dpN0szd3k0ZDlaeVhl?=
 =?utf-8?B?LzBvVlFCYUVUSHJld0ZaMkd0d0tpcDNUTm9OUkNONlEzZERFRC8zbnNUR1N0?=
 =?utf-8?B?OE0wZFRvcitmelNsS0ZCUVRzdHYyUGpkSndTeDZhVzFMRXNYT3ZmRlhmMEhZ?=
 =?utf-8?B?Vm81ajFOS2VGM2VjSnhYL3Z1NGl2NURHK3BLY01ib1pDM0ZnT1VuYmI0YUhr?=
 =?utf-8?B?Yi84dkhSUmdRekFEaThxanV5SkhXYVh1VG9WQkt1d0R2bm11U1BsQVZ5ayt2?=
 =?utf-8?B?L3Q1bWpYQW1XTFRXOCtqRW5yakk2K04vNkgzL2o4Vk9QcXhSOFJiOFpBMi9o?=
 =?utf-8?B?TC9uc05jb1c4S1c3OWtyQmxOZVpMRjdVWHYrNjVrWFREZUNaMHJjcTFSREZj?=
 =?utf-8?B?YitFL1VzanlUVWorY3ZGZ1dOWElXU1VEdWRYeGl6dXBZK3M0ZlVvSzFxZVBP?=
 =?utf-8?B?UzJYVE40YVhGRFJqcTV4VVlQVjdsWFhqcnJtL0ZxNTV5Si9JUGFTSk5hRjVP?=
 =?utf-8?B?eTRqcEsvaXhTU08xbWYwWDErY1J6VUpyVXpCV2huY2hUdU5rMWZnL3VCNTNQ?=
 =?utf-8?B?aW9ydFJNL0xxMFYySWh4N3AzWXdhdHRYMGQ1NWdqYUZ4dnU4clJDQm5HY3Vs?=
 =?utf-8?B?OUp0SWp5Um85Yk56VHZ4UzJOYUNEbk5FU1lyZTFEcFhrclo5K0tDb2tXcFFP?=
 =?utf-8?B?QnMrUFdVcnlPWWRScDl3RHFVS1JZZmhxZWQyN1hQUlAxK21DWDdSenBkK0VG?=
 =?utf-8?B?UUNyK2ZpNHZUUmlLWDRwTzMxRURnWTlCQUhUclJqd2N4QmkvUk1UbHBiREpU?=
 =?utf-8?B?YkVOZC94dVJxN3ZLUmRzK3RiRTVFV2xGRkNWcldNMEs5MEFSZmZ6VFdQUGoz?=
 =?utf-8?B?cEVHZmlOdXo4bFY2TG5IWVlMbFdVTmRSdkQrR1hwcWdPSU9kZC9Bdlp1UmJn?=
 =?utf-8?B?eXc2QUw2UTlTdFozUklNVXBaMUpuSjEwNjRiczJzMFQyZDZ4NGxHRndBaHo5?=
 =?utf-8?B?Mkp1cUpCWDFBK2NqY01XalAraGpEQlhHa1hkUHdRMytqYTJqZ2FjOU82WU00?=
 =?utf-8?B?cHd2WWVXV3Flb05mNzlBV0xLd3Y0YXMyQ2RncGZzN3hNaTA3Q1lmMTY0cEpM?=
 =?utf-8?B?R01MWFE1RHBTcVJET1RzTVZTU0tQcjFFOW10NURGT2JFbUNlMittQ3BuTUVF?=
 =?utf-8?B?WDlhWGd2bGlsMXFrY3VwVUU5TWxBSVlzSTE5OGtxVkpFZzE1UjR1ZTA3YkZV?=
 =?utf-8?B?VDBYVko5b2FFNER1RmpOTDIzYlhXNmNtNFU4ekFRZjVya0VnVmo3YTNaVFM0?=
 =?utf-8?B?S3FtQ2YxN1o3Q09jYmxvd2d5YXRoNkxoTTlDMElDUlNaMTcwMkp1MlJQU0RT?=
 =?utf-8?B?NVRZQ0pPYmw1STRscURXUytJSjdhZW5QS0tqNmFzVTZYTzdjNEQ4SEhZeW1P?=
 =?utf-8?B?YXVrSHR1UVZseUxyVEI0dU0yVUVET0NaU0p0bnZNT3FxUUkxWGNVMVAzWTFx?=
 =?utf-8?B?SXhrMWNub1dLanNkOVJ1eG41R0svWXNySDNhbk9mMGszSlJvNFViZzIwUmNq?=
 =?utf-8?B?ekRRK0lhbHNuRWxCQ2c2YWxTT3hLSHZXTFRZVFBwY1pQYnROUWwvVnBjVlRN?=
 =?utf-8?B?bVBaWlpkLzFoUk5qaWppcUo4QklWdWUwNUl3cHZKUUc3L2htOExVekJhZ0dT?=
 =?utf-8?B?d0EzbStMb2ZFL2JOVVdkWnB6UUxVNmFYelRobjJYajNWRmtYUlQ0bFAvWnZ4?=
 =?utf-8?B?Nnl5WTMrSVdZTEJ4Vy85Z3BBMjlvZ2o4UGVwNWJoYUtHWm02Snk2WDNlaFdW?=
 =?utf-8?B?ekZLZkZzbEJTVVRmTTFNWFFSQ2V5V2hCdG1FWnRYVTNlU0kvTlVYbzFRMVJs?=
 =?utf-8?B?N3J5eVNpM29sRlFGNDE2SzlKbzFJK2dUeTNGMmEwcEd5czJtelRGMU1MNU9G?=
 =?utf-8?B?T3RkMnFJUENMZFJrWUczRG9jWkRtUVNWaThqbW1wVlJGSHNMc3laNFVtTEJL?=
 =?utf-8?B?c0RTM2QrZ3IrU2RwK0pySVV5NmdSZ1dzeUp4eU5JRGdtNXBNdXNjTVkwSEZq?=
 =?utf-8?B?ZGQ2K3ZEdVBhZWF5VFBHWTZHWm1ESG51R3dhSElWSjNTOWRWTUl1dWI3dU5o?=
 =?utf-8?B?SExMc1RLUzlMTTBpeHd4MmNkQ1RaREpvOFY2N1ZVaWdqREluWXBMc3BpMkdE?=
 =?utf-8?B?UDFCOW1KTnRQc3gyMjhRUktTWnJXc1Jialc1eEppdllYUWN3UkphQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1eaa06c-a9b8-4f61-14c3-08df19b13003
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:28:11.6858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c22AatGOlRDyTGEELbrXb1IodpWhtgAQ+4UAvepAMZlqQQ//nCLkQIg7RdCqz0OK3/rjWHSnqR+IJtfIJIM3wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB980390
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=tdave@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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



On 9/18/2026 1:22 PM, Tushar Dave wrote:
> 
> 
> On 9/18/2026 8:24 AM, Gerd Hoffmann wrote:
>>   Hi,
>>
>>> The series was tested together with the QEMU companion patches on the
>>> AArch64 virt machine across a range of PCIe topologies: emulated devices,
>>> VFIO passthrough devices, PCIe switches, single and multiple fixed-BAR
>>> endpoints under a shared root port, and fixed BARs behind nested bridges.
>>
>> Given this is active for both aarch64 and x86_64:  Any testing with OVMF
>> on x86_64?
> 
> Gerd,
> 
> Thank you for the review.
> 
> Yes — tested on x86_64 OVMF (OvmfPkgX64, q35). There's no fixed-BAR
> placement to actually exercise on x86 since nothing on the QEMU side
> populates the fw_cfg blob there, so this was really a check that the
> fixed-BAR addition to IncompatiblePciDeviceSupportDxe is a correct no-op
> when that blob is absent. And it is — existing behavior is unchanged,
> without any regressions.
> 
>>
>> Overall this looks good to me.  edk2 has switched to github PRs, so
>> please open a PR there.  edk2 has a policy that patches should not touch
>> multiple packages, so patch #2 should be split into two for ArmVirtPkg
>> and OvmfPkg.
> 
> Sure, I'll open a GitHub PR for this series and split patch #2 into
> ArmVirtPkg and OvmfPkg patches.

PR submitted https://github.com/tianocore/edk2/pull/13183

Thanks.
-Tushar

> 
>>
>> take care,
>>   Gerd
> 
> Thanks.
> -Tushar


