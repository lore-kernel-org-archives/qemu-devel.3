Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F425F54ADA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w54uI-00004s-Cu; Tue, 24 Mar 2026 12:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w54uG-0008Un-Bw; Tue, 24 Mar 2026 12:47:04 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w54uE-0006OG-CD; Tue, 24 Mar 2026 12:47:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNf9rSpJgyDwK24qSjG3+bmauKhxEHEFyK+/SpKNVCVsG7dAxnVY/tSM9AGFYa/AFuwJuHfTUAN66c8AnY4oA+CIJzdyfJxnQNqiTdL3PNd5TBzamg2djqpeKaZZ65I6RMT2GisPk0cEAAanZU8ier1Ysi7jPDHUYQ8zFpSFvl4BqDlEAHbwIn7RruavJFHgaGtkdka2YI9Gu+5JGjjDD/dwuURHoa8vygQyYvMz65Xr3d3qGs5sn7gbIlIZvrSHvFS2SheGmaeblDDeW6Pyf0XLplhf7ivTuSlXf/KXZpJJDcUL1pHY0XSpaEj+SlxyRX5IK+5U0yLyEdgIa002Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtPyaaEZ5Y4uWRri9u2RsCoJH8yTqObbiqRmj1ctF9c=;
 b=KH0JCwGBxU/j6bnwzDNiVKYneLUCzbrkJRzhKwcR7X6WxnDSRRFPoOfupxT5TfnwUh0chMVpRjXAcbszdrBalHrZqBm+DoZfG8sFtX0iEg/jDTrJflnF6Atntxaz2uXZ9+Qs3loVlUNDcBl5WjdmZNwariNgPI0fURprcyAvDnWp4zWo1QD7Se6EZsbCp5OkUJzpFOmgbVhzm3alMyQkGyDkSCYPVT1g7NqCX8oWdkNX+C7Mh1NXWKFjjvTaVzWrzUktENqMg7GuSMWQafWASv9cIu+6PZw31z9aXARIHBNlgsgwP0W59nm8QwcGI3Hp47sMs853gebMxqBeJTzXuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtPyaaEZ5Y4uWRri9u2RsCoJH8yTqObbiqRmj1ctF9c=;
 b=QgpEOCok84MQnQmp2iC703lZ6sDx5PYmGu0a59HBXo2BsnvKHueU8XRN0U+z3DVRBcr0OEvU5kRtdIzKEIsNSnQkDAa6EEBcCm9g6vZGHejDMkuZZC0SAX5sbwyO4S4tagEp4FbHX8wY+a7HMGBZmqSj5jFztzCzitrjag+PQPAOUFLuJX8mv2hvjbNzKR9xkFSZd8/3bH4J8lKbhVf8Pop87U0Y52wkuIUSISEvuPhVsTzfPYYwbecfD6Cjp78nH2fKHsooogVTFw7fmN4hNqXQ6Hbh+UCOS/unZrTjoEyrixALutWMx/o5nS+sorz2d5KkeyryKnm/mGFjbCtEAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA0PPF6E99B1BC1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd1)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Tue, 24 Mar
 2026 16:46:56 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 16:46:56 +0000
Message-ID: <c09e3fa9-f942-4a18-99b1-d28116b20937@nvidia.com>
Date: Tue, 24 Mar 2026 09:46:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 v5 0/8] hw/arm/smmuv3-accel: Support AUTO
 properties
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260323182454.1416110-1-nathanc@nvidia.com>
 <CAFEAcA-TC8zpKivJ-Um14qHEbcrdCtT9GabkM_+m=B08esyaWQ@mail.gmail.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <CAFEAcA-TC8zpKivJ-Um14qHEbcrdCtT9GabkM_+m=B08esyaWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0052.namprd11.prod.outlook.com
 (2603:10b6:a03:80::29) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA0PPF6E99B1BC1:EE_
X-MS-Office365-Filtering-Correlation-Id: 9696ba2a-ebbd-49ae-b2ef-08de89c4f576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OHpIQ6qrUKTWR58dz33vaA7tck1JaU/BGwoVagt2SDy7+YCUXL0RxUXjwETBA/uPEwsFFQd+ljqFg5dglWwgb5cQ7Zko3Fsp3Uk/IkG+jvfZGxAtgXNU/DGhbjo3zY8lYUJtgyLkomd0EE/QdqxPF0PujuRXMP73QBgn83l6h4MIp1aEy1oK1fSAjMzPPe6gsbc0L2VhPoxsIaiw1uRWhYOm5Nkuo3pzR8Eb4qtTr/S3bH35rcyoCIDUtnTXatSw5Mn35vHR8YrI4Uy1ChCFjHXPWs/aJc0Av6GQSpZbOk2F6axHRHAghpk1jJRwWVTWEfTu/erT9bYR0RLubTE2s42D3ER8VqkBQl2hxBEP5938/161YlvH6k77ltMIrWa7u1sfOEXQQ+kcb929gG7mDAPNmuJ/m9ChiZihQzhBy8jX/i/FmGoT+ceslcq6nd/guJn8CWMHiYnyaEcJ2ZSA9wbwi6LEq39rH454SGRDy6msn3LEz3PAE3iabx9btIWT1g9uhmR7SrsajxTTywu8ApyCQW40M4NCXVFvaUkpjui7HygIGh70MaY7vl9BUcf3NcXO4IvvkTLTYULA7nqFSXGREC6kUuqHDEa0NHN1Pqcb+knanEc2LEkxRhRA7W3m9GeugKxaRVC5HIab9PGQfV8F6NjH89OhmWjp0cyw4q2NLEjXAFRVBn/KBmNqbVDJSu/OTOfX7KDUafVzVPoAo74ThPW2tqZHwgUVNMsqyCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUJiNnYyMlc2bVNBZ1I2VzZrTmJNUUVnTWhUZzhUZDB3TXFXeVpVV05nTVls?=
 =?utf-8?B?WWMrc1hqMjM0cmlqMkdZd3RUUmFubVJiTkorZUpjc1Fmb3h1bEV5OTc4TVE0?=
 =?utf-8?B?SVdndnROaGF0YkZaemNhN3poVUVoK1pWdU9NSXRtWCtCUWNQVDJMNlpiUXRH?=
 =?utf-8?B?VGdCaDhKeFB1Q0lCT3VacVozUXBQTDNra3pJWmUrWlBYUzQ2NjZteEh1b2Nj?=
 =?utf-8?B?UEdmQ1BzWXVNOVN0bVY0UlZKZXBpTzlEZkNjbWVGSENzY1dTQy9ZWUQyRkRG?=
 =?utf-8?B?RkZZUHNGa1R3U2psOTErVmx3L1p2aytmczdiYU42VmswL2xHcmg1VzBPS2lG?=
 =?utf-8?B?R1BGcUM5ZnI5QjVaVWVqS0dKN005dVlMZkpRakxvNHBsNVNNU040SHhPMUtF?=
 =?utf-8?B?KzJqbVNsSHk0dFlxOEh0OUoxTVFWQ0dqL1EyRGdCR0xwYldPeWxEcU42dEhC?=
 =?utf-8?B?bHlyZGRsdiszN1BEWURKYWQ4ZFowaUVjYWVRaUptcFVQWG5ySkF0M1RtcVR5?=
 =?utf-8?B?Z29VY1Myb1k5MVFHR2Y0Um0yYU1kZW8rNkI5YTcvaXV5MkFLSmwxeXJ3eXBo?=
 =?utf-8?B?YTdMK3RqcVZtM3Z2MGN4UEVTa0ZmQXYrdVNqVjkxSHpOVDRJZUNycys4SDRF?=
 =?utf-8?B?NjVxWXE5NVFLc05TT2tvNjZXaE1pd1FaWUQreGoxL0dzRE56ZFBQSmxKc24w?=
 =?utf-8?B?Um42aGRGU0xPTW5kZlVLTGdib0NCTVRyRFJmZ2FETUkxRUNGN3Z0SktMR0tP?=
 =?utf-8?B?eTRKUjNkL0E1S1lhV2pYdWt6SW1qbi91aWxzdTYrMVp6T1pINk5tYUNtZm4y?=
 =?utf-8?B?dFJjZlI0b2p1R2ZuNU03RzRYenMxYnh5VG81Y0lmSXp3MGt1RmpvazJsRUxP?=
 =?utf-8?B?dEtiYktmRSs4TDUvSGljWFd0STFYa010c0RrRmdxTFR6cHZ3Qk5tN01DemNN?=
 =?utf-8?B?UGl2VmF3cjdUQXo3dGFJb3YrZmR3ZUlMWC8raDk5RkhaclNnMXU5bS9DK24z?=
 =?utf-8?B?aitMZlN5aEdBMk00c3AxM3RCRmRheDVPUSt5T0laVFVrZDRNYlNJZFFuZXA4?=
 =?utf-8?B?VkZrR1ZNVHNsVGkydjBxcmNUR2RJQ3JFUVBLQ1ZPa1l6Nk0yN05uL283UVAr?=
 =?utf-8?B?Q1FvWWtPK1Q1aGlIM3RMMjZ5bS9mdzdXUk45c2dmK0pvRW81U3o0Y2tLSVBy?=
 =?utf-8?B?cWV6QkJ2Q2FvTElwUFpMbFZ3MDV3QkliNjY4VVJmQzVkbHlJUTMzNE8wbmMz?=
 =?utf-8?B?Z0ZZNjNvVGdOOEpvb2s0L3lMSnFpZkpJQ0g4cERxMWtvWGxyMFA5MHVmTXpq?=
 =?utf-8?B?QjZ4NG5jK1FzZHo5NGh6YnZmVktFbzJTUUxHZnZmcnBzeStmUDFMeENPQ0Zi?=
 =?utf-8?B?Y1ZLbUNTRTV4WFRUUC9OUE92R2xzTXF1TDZUNFFoZ0szQlB5LythVVZPQ0Vm?=
 =?utf-8?B?aytIcURnbWIyR0lVUGNwZzJhVVJoZDl0WlE0YnE0RmV5K1lqN0RIOXJRTCtP?=
 =?utf-8?B?bWVydzVMVmxUQzdrL1JuMitaN3lJWVpvN1FJV0lVOGNDaFFzZExXTDVBbnRm?=
 =?utf-8?B?dWYzUzlBYWZMRkovZVlScEU3bVV4d1RXNnpMNzkvRlVxdisvTGpjK0lHenM0?=
 =?utf-8?B?YmJiUkM5RjZPc1ZmeE9FT2Q1bkVWOUI3Y1lDNTNRYmcwM3ZMay9sbGRwV3dm?=
 =?utf-8?B?K2h2RExsdWFQaXFpYlVGSERHcVluQmdvM2liYUFVcWJaZEg3Yzgyc1BJZnQr?=
 =?utf-8?B?bzhPaG91OHdVVmFLYWkwYS8raURaaEpVdTZCMXc5cU9selBDT0VDOE5wS3Bv?=
 =?utf-8?B?eTVMbjJwQlJKUVRnS3F1bWNlSmRBcUdwSlVabld2c0ZHK0VPUmRFU1ZKd0N6?=
 =?utf-8?B?MkxmY1ZxWkhZSVBSbTh4R1c4clVRdFpKRWg3bnhINHo2dFFIeWRMRWpQQlY3?=
 =?utf-8?B?S1g1SE9xVnRDd1Axc2RLazcrc0tqVEJJNVNpTU9yc0hpMFkvdkNxM2diK2h6?=
 =?utf-8?B?cnQvTGVDeHJ6ZmI3TTh2cDJPaGNjK2tMWDBYdTl6dlNINHp0K0FWTWZON1J3?=
 =?utf-8?B?OXZaUTFsejZTRWE2NU16eUhIc0JnMHVLR1JaNENMaXVubHNyNlkzTXROVjJJ?=
 =?utf-8?B?YkFXL0NKZzFJRGFBTDFoZ2l5TWNxbWYzb00vczB1MDU4cE9CcllhQUhwd1lh?=
 =?utf-8?B?RmxXZWtkdmdTUzZxeC8xYjV3NW84OWRabDdTTDdSM3htNllPYUZxblBqQmpZ?=
 =?utf-8?B?WG9lNDFrQkJiSERCVU5TRFNxajMrN2M5WExLODBqWlcvRWNYWGlKM3JuenJO?=
 =?utf-8?B?OEt2OEhUNlFJenJRT1dtcGdjOWdvVngvN3gxM3JaSHpYZEdRY1lDQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9696ba2a-ebbd-49ae-b2ef-08de89c4f576
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 16:46:55.9467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3seL7hZ9dlz/nyPC8OtblNfOHZDJeH35CK/zbkmuckL8HhpyBMsMR9ur+ZJKm3okHCxu11S8gu9/1VwsG80Ifw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6E99B1BC1
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



On 3/24/2026 6:30 AM, Peter Maydell wrote:
> On Mon, 23 Mar 2026 at 18:25, Nathan Chen<nathanc@nvidia.com> wrote:
>> Hi,
>>
>> This is a follow-up to the previous series [0] that introduces support
>> for specifying 'auto' for arm-smmuv3 accelerated mode's ATS, RIL,
>> SSIDSIZE, and OAS feature properties.
>>
>> In QEMU 11.0 we introduced new options for vSMMU [1], but feedback received
>> when starting the integration of layered products shows the need for
>> auto/host-retrieved values. To avoid breaking JSON/QMP compat, we want
>> to fix the option types so that they can later support the auto mode. At
>> the moment the auto mode is not supported though.
>>
>> A future series will introduce support for resolving the 'auto' values
>> based on host SMMUv3 IDR values, as well as setting per-device ATS
>> capability.
> Hi; I'm picking this up for target-arm.next because it looks to
> me like it's been reviewed, and it seems to me better to take it
> for rc1 and if necessary make any last minor tweaks with a
> separate patch in rc2, rather than let it sit on list for a bit
> longer and take the whole thing in rc2.
> 
> Let me know if you'd rather it wait longer.

Hi, I also think it makes sense to pick it up for rc1 as all review 
comments so far have been addressed in this refresh.

Thanks,
Nathan

