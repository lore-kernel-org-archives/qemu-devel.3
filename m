Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B183FF483D7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4jNX-0003Af-N4; Mon, 23 Mar 2026 13:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4jN9-00038Q-Tc; Mon, 23 Mar 2026 13:47:33 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4jN8-0007U3-Co; Mon, 23 Mar 2026 13:47:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y58WthGH8apJcG0sQwH/a/JIN8TgV5IEdSA2U1Cnq4IWx45fWOHGcrWUrtcDcny1uMB4YpzvUJwIi5lHqgyD8EngVOID+N13f8/L0B/N34f8N1NtWi+cdbyVg4rYh+0r0nC5e86D2Eby30bjqdalcAAc8LSeWufQ/AhyMs43ZaoFjJ07MUJl3NnlHHWzoxWM6+r41hwomZP8JXZhXN2ii98tcLPpB3u19K0NSm7NKURvLXzckX2mfXUhHTvzENRQOrOJaqKuCfTwMJThpeOfTIZHnSsMrtUKIis6Anrmx4hKP+JCtZeS2CtwPfjslSkqCDHcSV3rfwhDWAvSe4i8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNMdcX2vhHkXPV+9UNA0SwIMW6mu1NSiqO/ErV0Dw8I=;
 b=DK+zpZN8iu/w8rtgJPJjyvfKnFMUCUaz7bSPDsJeadV/Npu19/RyPtpZpe9I0IRn+f7GmSCFd3X1tKqGn9evRYB9JaqaCswVFIruKuV3Qiz/kUC4a7zbqtu12QoUj75Qloza8DibkHiLIqtwu1MPdC5D/qHnUWrltQNjmFIKFllpUCl2UTWTyrCx25w9PlrUQZPaLeMjn7vHL7reH6CkyG6yVbfHdFtIJpko4b8JNZRbCjtKADUgrK2wHN2xsekABYni/qFPYdi1vgNfDCKazgcxULGdV8Y8/SYrxYh20k3hjfpGFwJuejKlSei+40tyhqYOp+Z+QkEiqmhlTwj0SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNMdcX2vhHkXPV+9UNA0SwIMW6mu1NSiqO/ErV0Dw8I=;
 b=V/Pt0qZPFc8tHWC/f/UaZqrMIaapXqV0RpFd0D+TgfA1LzXUg1w+33O1vuftaxjVRVh4w0wWNbvu2B8KQivYXS9Du5imFaY0cke2ZCs2690Vac5+shSR3mBIyLUKfAshJpW1sgFyYVSHp5kFouX7rR/RTXfE9YhYZJY+21zGJFI0ryJep9rh/jbBXN+a5ZJVSGnTtac1nyy/oEIFVh/L7Gp8m8Df3nKJqtu8t+ehsw35i53HYzejPieReVy+Tj1/EIDokYjecbl30UfOdcVYWZkDLkBGEvkyMSA2xjQbH2EKw+LzCqh7auT/mYxC9Yo4sdma6WEnetS5TooLlNi4Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.9; Mon, 23 Mar 2026 17:47:20 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 17:47:20 +0000
Message-ID: <d936100a-e670-4db7-91e7-6e84247588d5@nvidia.com>
Date: Mon, 23 Mar 2026 10:47:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] hw/arm/smmuv3-accel: Change OAS property to OasMode
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
 <20260318184907.4060030-8-nathanc@nvidia.com> <87pl5080zl.fsf@pond.sub.org>
 <654cb406-93fd-4c20-8dec-d01fc7d245ee@nvidia.com>
 <874imbj5rf.fsf@pond.sub.org>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <874imbj5rf.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:a03:331::22) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|MN0PR12MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 221e40e0-5e0b-497b-10f0-08de89043b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: UklU7XGej9t+rFdTf5GITg5DzP4wEyanKJRf3oVne7smfIjYtuKym0P7HOI6pp9IrrDdIAWFKBibxIcKUbLn/cD5kAbJm5rA0Z1UUUrwwS4dUPXSp/GgHzFl9I5lqAh1i5eKgHXLxA5A3YSuvbhQ5bzx2rHASzogOFHmganD5izCC1m5EJ2Ql+WONJjaqmaWwq/9yWTFxC5X/J1/q8uYOEqve3AWrucdw/sCUTswT2Fi8YTAh1HfHOH7KS6gIcAgdSKvo/ewBjpHVfy4ohS+mrWaG7Se2i21RPP2ebz1BHC/h32bXQGJZEOs5WK2gHfaEREB5h5Sxo5w20tCjrwSG4pUv82EQrbGMWEPUzwMxEODjj09x2TGxpL57m8aY5vJEeRg2Jl+D0rDIDlRi7AiOFInS8QA/y55afQTxPQ6cNVK9yCw/fV8b6XVJv8jFVsWBgjLITmb0k76wqhNJRC4whVrqiT/SrtHI1ccsjl+EIuxsFbYQJeFqwQFxOIRbmsNfYe46uALuY5KtWEXYl7ZK1avvDmPaX4zD1sPDct2XE1JujoBv4LI9Rxmucl/LI4E2rBeIcJUaheMUiRRF/zzldL3RibDpCWhsrQI9xMQPj3LU1d8Ix3WRG7Ny3Op4fWsYxpm0BfKpQ/qOKAoO74pJGOpxtTWaXLRNKtLVAW7fgZ1vevFVabjnZVtZBJ6qZjrex+qHmW8AEwXNCFjCS6oOTrhESk06akCPEAsNG9YgXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlNYSWU0L3RNeXZFdGdEV0hBenk3VGpGeW94M1owUVlGNHl5Z0pKOE5QWWVX?=
 =?utf-8?B?SVhaRkpFK1kxNlpZKzJKcGR3bWE5ekY0U2hNRXJMb0VuNTQyWlUzV3lzMUVF?=
 =?utf-8?B?dGRYSzhPcjNEN3hXenpWajZaSHR1aW0rRWJPTFk1ZERLRHJmNVVmd1E4WkR4?=
 =?utf-8?B?OFU4bGc0amhzZFRJQm1nUHY5OXpFRitiZ1VvRi9wNlQyY2pKSlhiaFg3WUZW?=
 =?utf-8?B?RENEQTdxamFjQWx5aldUOXRaYlZqTGlWbVdHSnd6ZnhMdkt6cEhaWG9ERGsw?=
 =?utf-8?B?c3gxbXN6ZnMrZkxUdldxNzJpYVFMZXZDOHBZV3NHSm1wcWRZSTZyR3FvL1lV?=
 =?utf-8?B?bTlXcFpLWEgyaGtHSjZpZW11YXYwWTVUSWZGM2liUkRLSmJadnptYm5mR09q?=
 =?utf-8?B?czJyeUlUQ0RWU21oa1RWR2s1ZUVsbWRLQk94cXNaY0cxc0k2NG45Zzh1WG9n?=
 =?utf-8?B?aFFuOTgrTTRrQm1McnRucWFYNVYxZVRwSlAzMGRJczBIU0pmRHpqc3hUeFN4?=
 =?utf-8?B?dHV5Y2ZybVpVY0Nyb3BqY094aFJVUlhyTEc2SVNJNVc1RTh1NzdZN3FDWEN2?=
 =?utf-8?B?bjlXbGNwb0wzK1kyVit1NUlGc2lyQ2pmRFdVM1RCRDJTR1BadmpXVWNjaUtK?=
 =?utf-8?B?NzlVVXdMZWpyRVF5Q1FkRTRuME9pZi9PajNvWVg2bTdNY1pjaXVpR0RwTzQz?=
 =?utf-8?B?allqZXlZeGMyUDJJUDF5dzhJWGpabGdDR2kvd3hyYVVPNjBROHVKU3hZYzVa?=
 =?utf-8?B?Mnd0VHlDTDkrTnhIclZraGFwTS9GZ0NjdW5mOWlwdkpFdW94amUvVHArOVNH?=
 =?utf-8?B?eWFPKzl5bHdYRHlQMHZlVnA4WmFKU2RCaFN4MDRRclE3ck04OWVoWFZhOHYz?=
 =?utf-8?B?bEFYeVZUVmV4eFFwaisxV0ZXUnhWdUVXSkdTN2NycUVxWnhiTTZBaTltZlUr?=
 =?utf-8?B?N05KN2FFWEFHekVpN3lLdXhaUUFBVWd4Kzg4a2U5aG1kS3Y4emlrM1NYa1JJ?=
 =?utf-8?B?bVNRTHUrK01sbXk2K0JUN3Eza00xSkw2aGE2ZG5CSnFRM2VrOXVma0pabHNs?=
 =?utf-8?B?TnlJdmQyeEhIZkY4TzFFcUZvQnFHcUVReWVWa2E1TGJ5c29TaUJFZVlEZ243?=
 =?utf-8?B?dnErSkZxMXhta1N1MnBqWEZYSEpRb2t3cXVuTXlDTEFrbFpNK2d0SUdLc2Zx?=
 =?utf-8?B?ckE1WnY3ZDRzTXBaL2czd001amYvVXFXazFWZllMZ2RVT25yNHRRVmFNWFIr?=
 =?utf-8?B?emJFUjZ2TTNIdVpnKzhDdEtpWWZ4c0JEK2pUS3dzbDhyU202YlZhOUFUZGhs?=
 =?utf-8?B?amtuMjRFVThObkRwOUZObDlJdVVPbTZrYWNnTlVFd1FraEptYzczVU13Sm84?=
 =?utf-8?B?TmlrZDJxN2IybUpCSVAzTkljTGQ1UjQzY0p6REF2SXlNY2pmSEgyZCtGbmNJ?=
 =?utf-8?B?U2pKQWZuYjhBMEZDWW9qbjZJNzV0Y3JRcHRjN0M2STlWUnVDYlFMK1Y1N1lq?=
 =?utf-8?B?c2t3bmkwNi9ocDVKYkFOa1dnMTdEUVcxOXBQMTFsSXNNbGtKL0g0MlE4bUdH?=
 =?utf-8?B?MHVybE5Rai9WeUNOVFFaaTJvZmhNNHpuNktlcCttaE9OcWdOd2ptUVZwOEsr?=
 =?utf-8?B?bWt6V1pqZEkvMXZHSFpDcEFFc3RzS29YRkxPRDhDMXJpV0V6aDkraDhnSDc3?=
 =?utf-8?B?Tk15cFZzOEliU214N3hNZitoMmRVSDdhSzE4RG5Db2lyclN5ME1Ia296L3pm?=
 =?utf-8?B?Z2FyQytyTGFpVFRwVkZpRHJBZDJBZEpEY3NYd0s3WFdVZUhNY2lTZGV0OW83?=
 =?utf-8?B?QVp3aEs5NXRPY0x6aHVPZFJQL1F0UWJNb0p6Wjc4SzU0OXI4dndkZDdVS2hF?=
 =?utf-8?B?eG5zNlc3SUdIVUI0bmtqdGIxUlRSUDBSWXR5L1d3T2d2SWdTSUw5akV5Z1c0?=
 =?utf-8?B?SXpEVW9oSXh5ZTRzL3ZqWDdQUEdkQVZ3MDhNS2dnaWZRa1JwcGVZem9KRC8y?=
 =?utf-8?B?ZEs5OFhIZlBzMWlHWktSR3ZyV3Z3WVQxekkwOU1Uays2WlpVbnp0WGErUkR2?=
 =?utf-8?B?eC8wa1NHb3hXak5kTEVwaCthTnRQY0tjNUx3WG1tWXBrc1FYT3NON2VxMEZ3?=
 =?utf-8?B?dUZ6dEgzWXdFazZ1OG1rVlo3MzdOZzdqRmU5Y2d6V0xYdDJwSmx2THQxUHBF?=
 =?utf-8?B?Y3pTa2YwakNpRWNtMU5xc29vRHJ3YVVHbHdzK3h2d1FCUmJKK0FRN1I5cnFw?=
 =?utf-8?B?bTdqREZOMTA5VXMxZ2hHZEpmb3dtakZzdndyZTM5VE9JUEVNU3YzalA5NlVz?=
 =?utf-8?B?T1o4ZE9sTTZodk9EUHZNQXAva3lTenVLUjBQYVFWSTR6RGVjQ29UUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221e40e0-5e0b-497b-10f0-08de89043b88
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:47:20.6786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QM+WGEiECNI5O5/+NRMarhRykxoAGMQs92GdCItR3JqMEepuPj/ye5qHB6wf8cV0DEgb051t30sjSAff/TzrOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=nathanc@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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



On 3/20/2026 12:53 AM, Markus Armbruster wrote:
> Nathan Chen<nathanc@nvidia.com> writes:
> 
>> On 3/19/2026 5:20 AM, Markus Armbruster wrote:
> [...]
> 
>>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>>> index 79018f8d66..c67819d6f2 100644
>>>> --- a/hw/arm/smmuv3.c
>>>> +++ b/hw/arm/smmuv3.c
>>>> @@ -1984,6 +1984,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>>>>            error_setg(errp, "ssidsize auto mode is not supported");
>>>>            return false;
>>>>        }
>>>> +    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
>>>> +        error_setg(errp, "OAS can only be set to 44 or 48 bits");
>>>> +        return false;
>>>> +    }
>>> So, OasMode values other than 44 and 48 are currently useless.  Correct?
>> Yes, in an earlier version we had only implemented auto, 44, and 48 for OasMode, but we included the other OasMode values according to the SMMUv3 spec after receiving feedback to do so.
> I'm not sure that's a good idea.  Not an objection, mind.  I'm just
> giving you something to consider.
> 
> If we define exactly the values that work, query-qmp-schema can tell
> management applications which values work.  Whether that's useful I
> can't say.
> 
> It falls apart as soon as different devices implement different values.
> Do we expect that to happen?
> 
> If we stick to defining all values, maybe rephrase the error message to
> express it's an implementation restriction?  Entirely up to you.

Thanks for the feedback, I agree that we should update the validation 
error to state clearly that only 44- and 48-bit OAS modes are supported 
by this implementation. If other values are implemented we’ll document 
it in the device docs and adjust validation and the error message 
accordingly.

Thanks,
Nathan


