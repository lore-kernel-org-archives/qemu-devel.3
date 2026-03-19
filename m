Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262A81090257
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 17:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Gr2-0000z0-EH; Thu, 19 Mar 2026 13:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w3Gr0-0000yH-5a; Thu, 19 Mar 2026 13:08:14 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w3Gqy-0003e0-HI; Thu, 19 Mar 2026 13:08:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYRkDpyz8rn+Gc5keF6QLJhEAo63OQW6/CcooTHtpaZzsZUa6e5+NYUqkRow/Ja9JSyT/YmH7HbOizQM2jx2DUVxODriGgPRs280IX4hJcnpi7A0ar9NMhn1VtafSrgmwY6iQi1xpqpV3GxGH+lJOnASxN3/0zff6xU+g0DPgocVOCbjLdD33ruVn1ZqyuBMWvAcr2BBbyevGNldCTNfRJfgjYqlt8Sm027uSzZMY7FMP6wjGFCWBKpBRBjTel4ZPp2m5WI1WQaG4sAfJjebqhYdmbOTi1QgAyF8KHQggwYqnkxy9VOb6Pvtnbrx2HmqcVrwVIPt/Oje6JQ1HKPw1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzR2Eibr0sDJTqi1b5hqIU2kKs/qVcdf3xvMhYhci74=;
 b=ELVjUhHCboYo/T0S827Hx7OBOB53yFdNfoVTh+GxRQbhXmUaq4MRcgfBVnvPDz82BKnmILy4+4CNFoVDX0ppuZgUHdXSpj64tchBQw//GivFzpsf94Jqw8cOULTNXUoJsc00lxfwwQSHETkZ8TkzS5uqL5xMVeF2B6pUdQGGbsG18q5cG+eLSQr8uiInupUyVpr0LF4zsplmvzN0tX1Ah10yEq4eik9bEDe3u8tcAKgxUC8VyH/h/OGgDMymdC1BwAqt1al1UQvzyrQhBQsWlPvyEoa8M6RlX8sKUptpj0n0V2Yn99CxAyXy8VQZsxXijdrXQuNGm/E0gMNo1xjvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzR2Eibr0sDJTqi1b5hqIU2kKs/qVcdf3xvMhYhci74=;
 b=tlHw0ar0ClMeApS03HjamZ9lLAGVQ5wDJVGmj9GPUityW8CBB77uUpNQiSz/XpcLEGcofesR3oNd9MUypGzb9tz66EPTohQbRlvfkwELhpVl1rMXPUTx0huXuGaORah73gKFGkXbVwY0dT2QRBKh8/Et1ucJT5QdFFgvcUwHnV8Zt2XO6P3x06LK86KUth/h76keo/Khm+57741MnmHz8guCcbgGNFlMTAhftEeNK0U05Jcs/s0XzmAAjo2Kua/6enBNNBFtDU5998bk32X3tuE+/yS+l/wrd6i5rwOEBbHBHRxHPu1svO8oJ0bJwaktkib3tPnB7ceEB6IPiK6xog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 17:08:02 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 17:08:02 +0000
Message-ID: <5fc29013-3ce4-4cb8-b6f7-db3db60b7077@nvidia.com>
Date: Thu, 19 Mar 2026 10:07:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] qemu-options.hx: Document arm-smmuv3 device's
 accel properties
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260318184907.4060030-1-nathanc@nvidia.com>
 <20260318184907.4060030-9-nathanc@nvidia.com> <87ldfo80xs.fsf@pond.sub.org>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <87ldfo80xs.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::13) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|CH2PR12MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b69948-6db1-4a3b-99f9-08de85da140e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: xO9xM4ThLSLamvyt0XNmJ926/Fj/pUcckJnCM/XV3xuC/S+HF2N0FhgHtjZqgDcUlFnGu5uU2mEnUUlyYMgChqCrRGr3o+c9JcDG0hLY/vW5VVYaTYGCklb2yv7yy49dzGK70rFu0wx2Ojx2sfZ8mAhWYW1H9lFLpgOnLPpoCK+R9XkC6JVNYOkgT8GY3Bf+lcM5E/Mad5VblIinamt4FYlVx2phm9k26EaQx5D8rqqoTN6t31ehqgIV/0haTT33yX/cDlND1MYglcOXeejzrOOETNwfpuBwXq7Px5dC6s6QRGSaiQJgNeq/adPkVIxF/nMpl5sxN5ya9gpdySa5yCVaFC5cCe1heqFKWCBkEFytltAM8kKjaPFnLJkYQA+sO4WI8ild5510RXLwdA017aaRC8i7nks+ZhT/WzaMLmQlckFq8VAkz4mZXqivkm4t/xEOW0lUTGWOTx1U22M4kQmw0xkSOxCLMVm6ntEKz1hRn7IxJnwC3vJhe87sqskl5tEe7WXpzF6kfC6MtSH+iYoLCCNM2f4+rcUoM00qE7HgxipNHZqMPAMOsu5leM8afS81nGEwWwAl5IG8ndWldHIV+Yxg9pprmHRHGsN+2RTyHmMQ4Jiy6Gl7E/7tRTMElnAAeAS5yWc1edp+VdnBvrERh9jBPRvgSZMfSeSwCCNU86KNfCHnf5IJCB6mWLbIO2oyt+wyrEU9AJD9mlYK6Pskg2/zLjcd3J++HQ2xZUw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MklCZDRSZkdJUll6em9yQVlNWVJhUTA0TWozbllyb1dGQkIwME1nZk9WTnlZ?=
 =?utf-8?B?d042UFM3Wjl5M0F5N2drN0ZkazhUc2RBbXNtOCs2Vk5iWmowNjlEOWVLMC9Z?=
 =?utf-8?B?cHh5djUzazlaUW9EbWw5OWMrTE1sUGhGelN2QkZRNUZ3TzhLcDBncG91UVRG?=
 =?utf-8?B?RGpWQnIvRmNXVko3cFRzeWtwb1VFVTY4V1VCaUNLamlQTlhiakgyaHRDcE10?=
 =?utf-8?B?OC9TaUVVaFJyUVFVT2dKV284VDFiZDkybEp0aWUrRkFscGdlOUc3L1pGd0Fj?=
 =?utf-8?B?MWEwNDliNWtidlF4SmtwUjRUOW51d1p3Tm1jb29vOXJSY1Zvc3dibmFqWGtr?=
 =?utf-8?B?ZzBIcEJKZXlqMDdoZGwydnJuQTBaWTRsRHhjbUhmdGpaTHZDb3NDc3VxVUZz?=
 =?utf-8?B?eklrY0R6QW9xUytPZ0ROT041L0VJWHA3Q3V4TmhlOG4yamt6Z09DZVo4anpW?=
 =?utf-8?B?R3IxNW9uWVNzRWlFTnlvRTd2d05LazRNQ0VEVVd0b3BFaExXK01NTDNIUzkv?=
 =?utf-8?B?Ni9oL3VpdXZxUjNDNExQSVZwQkdOUzV6ZERGc0tvU1RVR2Iycy8xTTFFOVBi?=
 =?utf-8?B?WEZCSFJEaDNHU3dQUGN0RTBCeVBWeUc0V3RGL0E0MkcrSVRlR3AxbW0zSFZ5?=
 =?utf-8?B?TTRiQ1BZc01OVTQ1cUltUEtLc2lXeE1rcnFsRXRjSHBTY0JvcE1xSlNkQnp6?=
 =?utf-8?B?ek9kdGpuVml4VmVEZC9pN3hBWjlPS3N5R1ptWDZkYmdqMGlPSVdzKzF0VzNu?=
 =?utf-8?B?QjJFUE1yV0pzUEtBajBTMTE5b1lFYmpCOUNwZnVxR2R1UWd6aWUxSHRyQW1E?=
 =?utf-8?B?bGhMUXc1SEtPNk9aanFGUnplQWtXN1FYY0VIT2dqQUdVMmdWUlZjVU4rNFNk?=
 =?utf-8?B?SWNSSWlHeGtPNHEvRkV5K29HVzFVZzZCMXVWUzR5V3hCODFDdGQwcU1SbzNL?=
 =?utf-8?B?YjFDbk9Qa2ttSUFDdEhRQldhZ3FVdGNDMUt3UGhVYVF0cXJFOXRuRkFHNWx3?=
 =?utf-8?B?ZzdsZEVsVmZWZ09mcUhacTNleExLcWJSOUFiRDJJYktGQlZmQi9PZTFHUGg3?=
 =?utf-8?B?QUs5TG0vc3FralVJdHo5RWZNUzZBZXpLZVkxeEZLenZPU05qOStwSDdOdENQ?=
 =?utf-8?B?UXZHNUVRWjYvY2NaNWFnWG0rbXg3UzdTdDJYamc4N3NIclhKQVJ4SGhGQTlM?=
 =?utf-8?B?MEdLaEJZTldrZkRyblRDQ0Vtaml6cEh4Tk5kT0g5RElnVG9qR3dRL080QTZq?=
 =?utf-8?B?QW9RYXdLejFrTmZWb1hTcEdWS0pmeXo4S05lWVFRRGlpS1V3V3cyVUQ5cWpi?=
 =?utf-8?B?TktnaHUyNmFvbDgzelBoU053bEpocWlFN1RGcm9jdkt2Q1pVbTdrMytTdkFk?=
 =?utf-8?B?aWttWnRvV1kyWmsvRGpHcnorWFNBZG16SmxESkdYb2pzbXEvZklyNVF2WU54?=
 =?utf-8?B?dmJzMG9iR3MvU0ZiZ081ekUzd3JTYUhVNml3dWs1bzBWcksvNGswM3hwYTRx?=
 =?utf-8?B?MFRUUzFZY0pHbTQ2RWxCMWFRc1VqQnkzY0hPV0xRZ0V1bDFQSUk5MDBQK2R6?=
 =?utf-8?B?Z2F3UU9TMDkyREVWWjRQUjZ4MXdrK3VZa0V1QXk4SzlNbU96djlkenJySUhy?=
 =?utf-8?B?dXBMMU04cHZtMzA5ZG12VFlJUE02dGJMUldPZWZ6QlBKVVExM2NPemtVMEdB?=
 =?utf-8?B?ditkdmMwTmc3UVRCS2hSMjlydUgzUGFGc3hhalRzM2ZKUGM2QWs0MFRPOUti?=
 =?utf-8?B?RUI1RlhFdFArSVFvMkZZREtZZEZKVktFT1lRNDZKaXoxNndTR21NMTVxZmR3?=
 =?utf-8?B?L0swN1NsWWNobVUwcmkzV0FPbGo4eDFaV04vV1plNmQ5WUJsZm1kdVU4bHRu?=
 =?utf-8?B?TFZhd2FkK2FNTW9rMy8vaFJsRlZCeVQ4L240Vnd3MjJ2cTkxNGdpS3NUUXlr?=
 =?utf-8?B?VTZKRGw1TWxwc2pNNTFnQXZOSXhmdHczOFV4YzZoRFZCSk5PMEcxMVdTbmFZ?=
 =?utf-8?B?VFlnTE9TcjZDV0lHK00yTXp0aUxvdE1heExWRGl4SFh0RE9abVJqUm5wVjlu?=
 =?utf-8?B?aXdUalcyV2NNUDN6Nkl1d0hLTzNxeHZUSDdBaUxWbC9TQmVRc1dOVVFGZ2ty?=
 =?utf-8?B?TjNLQldFR29ZMzc1dHpZdi9qeXpHVkhjcHlCNmRXaXhGc0cxK2RiNlNNU2FP?=
 =?utf-8?B?dzYvZi9JRWlHRHNUUCs0RXVFbzY3QTdobGdxMmIvVVNQeUROcU95aHB5dlNm?=
 =?utf-8?B?amlPRXlVL1NuM1ZwSVRtNlUvWTIxVGxvdnZZRkVNTTFhcDRvSXRyVmgzOWhB?=
 =?utf-8?B?WGU1aUdLbEJhSmlKdG4vQnRDZTZTNlg3Q3F1RVg0akpHeTFYRDV1Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b69948-6db1-4a3b-99f9-08de85da140e
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 17:08:02.0670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZ3Syz/SrY5dbw/HCr6IGu+WLEqRN8Nw0ZzujD/6ZZ7Agpx3gSEQth9FOmT3yKPllOWY+a47bZOVQ9x9PBYC8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=nathanc@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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



On 3/19/2026 5:21 AM, Markus Armbruster wrote:
> Nathan Chen<nathanc@nvidia.com> writes:
> 
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Document arm-smmuv3 properties for setting HW-acceleration,
>> Range Invalidation, and Address Translation Services support, as
>> well as setting Output Address size and Substream ID size.
>>
>> Reviewed-by: Eric Auger<eric.auger@redhat.com>
>> Tested-by: Eric Auger<eric.auger@redhat.com>
>> Reviewed-by: Shameer Kolothum<skolothumtho@nvidia.com>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   qemu-options.hx | 32 +++++++++++++++++++++++++++++++-
>>   1 file changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 69e5a874c1..f8da35513a 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -1279,13 +1279,43 @@ SRST
>>       ``aw-bits=val`` (val between 32 and 64, default depends on machine)
>>           This decides the address width of the IOVA address space.
>>   
>> -``-device arm-smmuv3,primary-bus=id``
>> +``-device arm-smmuv3,primary-bus=id[,option=...]``
>>       This is only supported by ``-machine virt`` (ARM).
>>   
>>       ``primary-bus=id``
>>           Accepts either the default root complex (pcie.0) or a
>>           pxb-pcie based root complex.
>>   
>> +    ``accel=on|off`` (default: off)
>> +        Enables guest to leverage host SMMUv3 features for acceleration.
>> +        Enabling accel configures the host SMMUv3 in nested mode to support
>> +        vfio-pci passthrough.
>> +
>> +     The following options are available when accel=on.
> What happens when you try to use them with accel=off?
QEMU will error out and prevent VM boot if accel=off while trying to set 
these properties to a value different from the default.

For instance:
qemu-system-aarch64: -device 
arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1,accel=off,ril=on,ssidsize=20,oas=48,ats=on: 
ats can only be enabled if accel=on

Thanks,
Nathan

