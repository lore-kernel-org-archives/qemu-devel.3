Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2CACD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNaEE-0006z8-AW; Thu, 14 May 2026 13:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wNaEC-0006yo-5B; Thu, 14 May 2026 13:52:08 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wNaEA-0002kj-DG; Thu, 14 May 2026 13:52:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dy8HW5RgjudlnBdnqrtIuv2eO2RHGigcBLVYn2geofnAcbnSCgVcW0Wo0lP8YEF58xM+KH1RBrnplTnmSk74X9atcMx1trOiFpmX+2MUKlUtV2zcTjhCjejLZQO5xPA2YyHDee0zXmSw95LIW9qB0HqT9V5AdpbyGg/D82BHTeGJOdinzsGygO8Ni7faxwcrARzRdR3/eFYa1xyc52GN7DKAB67ewl6bx49awArOUXN6JWpgfmbXBDjJMVYQN6tc3iBvnC0eBASGq6zQE8p+ZOVeY3qhJnJxHToi0RxvaJLrQ+ZhwSrAjGuQuX4L+2ljdf6ja276PsEkZI4STpU8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0Uz5iPk/NZDrbkF1DjdQELcnPQbpAqaLDKgR8Yn5YM=;
 b=ewvVR3wx+rRYQGtzZ1cQIaiEP7IZVAht5qFwYwdDyurjOX6iyrlIPF+yU+cPBHc8mhzB46RTylTpAje1p67cjhme9Od6zCi9M8gEMlEq3FXE7SgLYjKJV0plOS1V2X7PDFyNu+U+JkrVYTmZVHOeHb8NaznGbVcKGRRyKzI8UpEQb4AFIgoAltRThnOCa39fcntVRlg4KpC866HhtvoDGBXewTKFVsuw/79tidYLFWVbB3HZ7gpioTaRo8pIdqRD6CpXEApZKXi62lVG2wNDxYcu/jZKAUX9icMUUQf9C5hMQeZBQjWJhtUdPzD3RSqXe1HQjtWYrfP06hSbDtFCQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0Uz5iPk/NZDrbkF1DjdQELcnPQbpAqaLDKgR8Yn5YM=;
 b=XYVCIJniDUcPkLhcalHsvsDJ3J9jc896TjIvmkBM6kEwJRUtM+qsFObWo64zWXRe02Tty8qRmJ882ixP8xHX7CTdzIYc0oJjeQG88CocQ8eDnMZ6HDRJMtENLTdrv/hu+z8D6mut8E5uxLY6DU3Jc+w6Zk0Q3cOBJsUKSqkjYXbmmEnJmTmeQeFNns9hO3zRse33nRmrqVQy617CcVTHdmq/j3KrvSxX4J/ILfjJiXohIF+km8RQ8AnoYa6xCY3PP98pZ5zlurbjmv5gkQ4KLpnJnjqwqAMcAScUy9EcdUS3N0ZozrgFy7dJAa2kfuUvl3xStq6g1e92NhHHWKVlxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by PH0PR12MB8050.namprd12.prod.outlook.com (2603:10b6:510:26e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 17:51:59 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 17:51:59 +0000
Message-ID: <edda4830-bb64-49c5-b822-9f3871c3c8c0@nvidia.com>
Date: Thu, 14 May 2026 10:51:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] hw/arm/smmuv3-accel: Resolve AUTO properties
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
 <CH3PR12MB7548F7B7FE3A5FEAB2F4A836AB072@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <CH3PR12MB7548F7B7FE3A5FEAB2F4A836AB072@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::34) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|PH0PR12MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c8e2ee6-06bb-4bcd-02b0-08deb1e17f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info: oeo3LcO+xjJFKKb9W+Pcm9mELnx4abJz4hR7+BTYPsuU1lV2WqMrbfx/wSN0rFoobOwIN7YSMDe3whUD/FR1ocCJEXZhTKWd6OeRX3BmgAzWygQdyLvpJ9SX50IXHeujeCIvc03Y54t8weNt7PP6Uu/Rexjmnovg5GpLheq8/TXsF6eBzyt2wxun8WkOVxtrNNvHjRtdRy2Z6TbO6Hx+e1TAdYOIlbHgLiHYWvqE764BEcQSIEbpzYFMPAoC93iSzq0M/wfiSjWG//Rlx9P7pVCTM2dgE7bNjEXvHYxqei6mVIc9VP1nFpTEcpi/juzLw8lO1dpWe3ZH8ZTIVqmYqIrVzHh+8GQOK/uZT4swDLfxBk22pR1zBnv7qP868PNsi0MPZ8+KaWEIpf/LYFJOySnULuBkFwb15+hOG70jO9vIBwIGCRp224ZZh8j10SUj8j/TueAeem2qFvLR71rYRBbJG72l6BKRxsiy254W9R7pHF0F/jEDypI4QbpJoYdPmsLjtIlHqkjZh57/1ZdUXQ2X0bm3cv3QKJBor/au1pcXPpCmRq8JEpMrzj2x4CcS5bC/iyIX0OGD3UCFwlzpFx/FlropZM5Qky3OuHs41h2OVDLjNDJjGeCSj96l4TSZtN5Gogl9s8fdYqcWp0LCwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(4143699003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHh5c2FMNGNPZkkvL3lIaGQyRnM4SFREeWIzaXFqc2dFOUNubitBZkFHVG4x?=
 =?utf-8?B?cklabFFYOHoxb2NTcFdGMEhoazljT1BVMDBDV21ickVxdlNjWGQvenFMSnB5?=
 =?utf-8?B?NHlyNURkUFF0M3QycG1ZTDV2M2FYeGRZOEFtODNSMlBuNmhibmYxUHpxbElD?=
 =?utf-8?B?Z25GYU94US9kalNzVzFDUWFraFlqN1VDbTZFV2dkY2hZSUQ1dEJKdk4vWEpu?=
 =?utf-8?B?RlNHWUk2MCtRK01ERlltaW9NZ1cySWdzWXR5Y0pPY2J2TTA0a2J1ei9hTmhG?=
 =?utf-8?B?S0xWZi9HajBMYzZWSWNQQTlFbDZzZFlnZWtNaWtsM0Z5L2MrK3M4ZHlLeTFF?=
 =?utf-8?B?UTNLNko0NmNVakdhZHJ1Q2ZUeGlyTzE0N1oraDV1L0NwTHN2WmxtOVdwVmZl?=
 =?utf-8?B?QTZnWnZJM2VsWE0rMzRDcmwyRStabTIyKzdtL1ZyOWVnMk1qRmlvbmhLR1FF?=
 =?utf-8?B?QU9HSGpESFgrRW92UFphUkpwdTQrNytjNDF3UDZsV01XWFduQlpXaG9hbHEx?=
 =?utf-8?B?dy9pWERjeDRLcG0yc1lMVnhQQmZlRkcxZ3VZRHFmZ2lVbWdoOFAwbkZLVUZk?=
 =?utf-8?B?K3lEaTFocmRkVGNOcE1na01Cck1Rd21XZGM3U253K0RVZWsyanYwbWhCSmtK?=
 =?utf-8?B?NmpENnBwTzdUY0UyWkVPQncrUUdIZk9DZ0h2cGVZV3FVc1lMbjcwYTBWYTE0?=
 =?utf-8?B?UEp6Y2w4MFBJd2FnVDFIM2R2bXIzZVMwTXlTdy8zcFlFUGx2TzQyald0SzN2?=
 =?utf-8?B?a1JOTGcyZWIyMUpiYUlZME9zYlJkWUlpeFg0eUR0bHZzbDRaMTJmZjBWZHZ3?=
 =?utf-8?B?R0lWU0dObUJobWpTdUIxeUlxUkxkV3hrZi9COFBKYXlybjRRczRKWG10eUgr?=
 =?utf-8?B?RC82SFNKSVB3SUFOOTQxZXdodmpnbVlZdFYxTkk3R3hNdlUzd0ZDN2RpaHhH?=
 =?utf-8?B?RzdnOGlVRG9FckxQTkNPRU51cVZ1WldoZU9ZYkNnb1EyZUsvbWp4bCt4b1hq?=
 =?utf-8?B?TVF5SkFwSjczSm54Nk95U3V2Sk5yenpnWTBBZGx4cHZIUm5vVyt5Si9EY1BL?=
 =?utf-8?B?Tm5kZDkxMnFUWDE3dWw0WU80UFN0OStRZlJmTmpUZ3lHK1pUL1RDdFR3SCto?=
 =?utf-8?B?RndMUUs4OUFPek5BTW1yRkorTmJCZFYyS21vYW92MnVGNmphR2pIV0lGRTBP?=
 =?utf-8?B?TTFETHFqdXBOOTRESVd5eVduT3B0NmlMV2VINTBIekhuM1RBVms3R3dyUWwy?=
 =?utf-8?B?SDdEcWRBQWJoVWN1RXVtUys4V0RLZTl5YVFYVUpHd0xUNmtTMkhReHp5bUdu?=
 =?utf-8?B?SXRPUG83SUN1aFF6SGhub3FrR08zY3gzWkNuV2lOek10bDV2K1laWWgzQ2ov?=
 =?utf-8?B?UThLTDVUWXhlTGM1Q2Vqem9VMUFxMHNVV0FXN1VPOW1IKzNWdCtWUVJNYXBs?=
 =?utf-8?B?dm5wYjNETnFFckFqRzlQTUg3RmIzSWtQcWxjczlOTGN6alRuUHNnYVB6dmd6?=
 =?utf-8?B?TXZTNldIcDJmekV3b285NHZ1QWY1dVk0VitKN1JyeDVrMjJXZTYrMlBFWkJv?=
 =?utf-8?B?Vi9Ra0ZwUkRQcEN3TGZpQzlPVm1nVktPR2d6M2lvNGRGZjg1S1JNdGxOSk00?=
 =?utf-8?B?aXlJdlJDNko3VmpBVEJDeHc3ZGNQdU9MNmFHOVNza21FakUvOC9GVW5ESUNm?=
 =?utf-8?B?UWF1T3VYK1FzWXRXNFYyaVo3eXc3aE1VZFN6eG0vR21Qb0lPa1FMOHFqRmJH?=
 =?utf-8?B?dktRdk1oeGVLMUtvVzRqSDNOU3NYdE9wa0NXREdlQ0U4dm41bVpiZG9hOERa?=
 =?utf-8?B?QTZjVnM2SlFpbzcra0Q2a2IxTldYYzU1VTNycGIrdThjMEdPWUVQWnpiRmtL?=
 =?utf-8?B?ZTRVN2JGY1VvbDZKQm81MndIRUhYU3MwM1ZRYkZncWxhU0NFLzFlRzM0dWUy?=
 =?utf-8?B?aDhyRlZ6Q2xVbWdRaHlNSzdEcXJYUGJWT0t2ellqVTEycWttMEpzWWJvcXZs?=
 =?utf-8?B?OFhSdHhyRDhINVJTYm5MVXZKMjJTYkg3cUI2VTBaM2pmT3NOanRjajY1Rld2?=
 =?utf-8?B?SGFxU0VCK0gxd3c1SmQ3cVp3ay82UHZyc3ZiUVQ5T09CbU1WcFgzZlVKYWQv?=
 =?utf-8?B?MFhOYUZmYUdNZlVLMFljMDFLL2hDUmtrRWp6eXoyL2JEZXZjbnBmdFU0NE5C?=
 =?utf-8?B?THBNZmZsQTViWThrdE1sNXZUaEtMUms0YnY1RkhUQ0dPUkRBY0krRzAvMEpn?=
 =?utf-8?B?OUE3ZkxkME16WERMSk9WMnVIYktjMEpDYjFxUmgyMTRmMXdUaDlveUNySTg3?=
 =?utf-8?B?eHlGcnVwKzgrZnlBNnlFdzZrNnZaSlFhRVJnbmMwaGRBNUEzbFBGdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8e2ee6-06bb-4bcd-02b0-08deb1e17f02
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 17:51:59.2014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnJnl9mejv7uqQ4PAoNQm/AD1u1JOVP3N0XRM3Uer836aXX20rB49WvABiNPskewxoKr8Z5qGLWWBM7cf1Ua7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8050
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=nathanc@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi Shameer,

On 5/14/2026 9:37 AM, Shameer Kolothum Thodi wrote:
> Hi Nathan,
> 
>> -----Original Message-----
>> From: Nathan Chen<nathanc@nvidia.com>
>> Sent: 12 May 2026 20:35
>> To:qemu-arm@nongnu.org;qemu-devel@nongnu.org
>> Cc: Eric Auger<eric.auger@redhat.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Philippe Mathieu-Daudé<philmd@linaro.org>;
>> Zhao Liu<zhao1.liu@intel.com>; Matt Ochs<mochs@nvidia.com>; Nicolin
>> Chen<nicolinc@nvidia.com>; Shameer Kolothum Thodi
>> <skolothumtho@nvidia.com>; Nathan Chen<nathanc@nvidia.com>
>> Subject: [PATCH v3 0/7] hw/arm/smmuv3-accel: Resolve AUTO properties
>>
> [..]
> 
>> Changes from v2:
>> - Added R-by tags, thanks Eric, Shameer, Cédric for the feedback!
>> - Re-worded descriptions in qemu-options.hx and smmu_validate_property()
>> - Emphasize accel=off auto behavior in a comment for smmuv3_properties[]
> Just in case you missed it, there was a query regarding the corresponding VFIO
> ATS support patch here:
> https://nam11.safelinks.protection.outlook.com/?
> url=https%3A%2F%2Flore.kernel.org%2Fqemu-devel%2Fad0dac7a- 
> cd60-4735-8ece-23fe526ca883%40redhat.com%2F&data=05%7C02%7Cnathanc%40nvidia.com%7C0a5c91b9729d461a53b208deb1d71a46%7C43083d157

Yes, thanks for jumping in on that thread while I was out. I am working 
on a separate series for the VFIO ATS support.

Thanks,
Nathan

