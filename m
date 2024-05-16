Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49FAC25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 08:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Whb-0001aj-0c; Thu, 16 May 2024 04:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7WhS-0001VQ-N0
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:42:54 -0400
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2412::601]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7WhP-0004Kp-GV
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:42:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hS1lFMN2C+NNr4yl6r21OfFNCaKxZbwsZNcl3GAC8DjYTiD5P+5f5mhah9Tcrib45cMUON4DcLivuj41k9/Rp89+r2YFnJZ4PoZ9j6rjvv+unNOEak5J5lFq+EtAVTSE3bl8Z6xtx0ZbDV5hIKq7YdfStKFkJI5fT6/O12kSVvzxKb2Ji4eD2fzPbqm/f4cz00T2AHQkIdAw7rFx+DSZ2a+X8dM7JZumFyqbkG6rXATComM0bHh5vuzy1G84gG0gaDl1XjTc8/bhfhhbzeKccSwSboi0S85IKSYV7Hf56E35bA0gejsC+0S0WGbSqml0AUm0VEfRHJrIJ6epUNIFmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIjOlxtzFbicP2TE1YSXo+CBaDKR4Zm6ibPtY6d2zzc=;
 b=arQlr71U/rr8c3XdQj7zJLYXht8fb5VXYS5PMz9F0J8AVHdSOGOXH7qdAZV8u8m8xCnqU0uMmtzZwP+QETpA+XwTXnRTtORMPkG9iNDEuiaRndwc4UQcPEaUq6AzXAMYPnXOpW2biM5RIsjA+nJ3GaXdb48l4465ubGqAOVsMc8zLud4ad3SRjBb6Ne5hJASqbZaswrp8dqr6cuBnNmJOAzlTuv+0IorQZcCkF/1UUiB+ZL792U73RgGSppq+UENr7ZlJ1EHnZJm3kMZQ0n9pjJmSLiKHGJQFyjqDkPOJ8kFwFfHG/Z64+ghbU8cADNtNWvsZZ2oUZR+oSbKuZjRtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIjOlxtzFbicP2TE1YSXo+CBaDKR4Zm6ibPtY6d2zzc=;
 b=PlHLTD44tV97vlaHzRBGuBFMheMvfajcc/atgvI3WMjM010NRvI8ai9ybepS4zf3w3EkrX7MUyYSBn0+Nu87wxDT62+CKE4rgL+NqYRWCe13LmI5jblerqX95NFtqyzgMhbiT1w+K5SzuLofEMqw/qFFSWyFYycj7phDUiKmyVI+RGWvvQk2hWrPUJAWYF0L7rT5TtXTo5bICgyXq74QayoJku2SJV/+VW7sCuj2AlsXEUA46shYQEwWtMGAA1JPoPJejXLRJqfrSdZzQ9qCARZdchwVz7aJ0NuK+E2IqotQ6T7a9hM7Q4gWSLjiLyiAb1X6um6FLzmBYg61XYln7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA0PR12MB7723.namprd12.prod.outlook.com (2603:10b6:208:431::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Thu, 16 May
 2024 08:42:46 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 08:42:46 +0000
Message-ID: <ea701c4d-9cae-4c56-bbcf-c143c25c6799@nvidia.com>
Date: Thu, 16 May 2024 11:42:39 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/9] vfio: Add Error** argument to .get_dirty_bitmap()
 handler
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240514153130.394307-1-clg@redhat.com>
 <20240514153130.394307-9-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240514153130.394307-9-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0271.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::6) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA0PR12MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: 0276623e-e4a6-43e0-e1bb-08dc758428a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEkzQ1pGMHFyVTJUeTdWQkVMLzVrUHVzQldpSDh4Y0FVajJXRGxXbHNDazM1?=
 =?utf-8?B?TUFmQ1ZwR1V4SmcwN2g3K0NZNWpUemE4aUVya3ZXSUlWRTJOdEtCV01ZLzgx?=
 =?utf-8?B?YVl1aHdqZit3VHlVV3RtL2V0eWdhUFNXUExIZWhHeGhwaGVxYzFtbXArN0NI?=
 =?utf-8?B?U09rU3M4UW5SZHZXbWlRTU9Nd3VTZGpkWDJydDZiYzdIWmxPT2E4THpRdzlo?=
 =?utf-8?B?TUhDUUtkb0sycGJKU2VkeG53YnZvUGd6THhSNzlEdERZVFJNRitMQmd3MkMz?=
 =?utf-8?B?cjZnY0J2RzZNbEtPd0RwaFllZXB1eDVPMEY5QjVQUWFxTjM4TjZ5VTBlREcy?=
 =?utf-8?B?QjI2UmJhMDRveVFvWWdjd2lvV2RzL2JpN3VnY0NkR0paVGhtbDZyNkVtOE9Y?=
 =?utf-8?B?MysybnhHQVdndC9IbmRoblBvNlozdHUrUWdjK2wxaThJWUtzVVJka1VIOGRK?=
 =?utf-8?B?SHEyU092TlZkUjEwQml6WU5oVWJpeWZjNEkwYmhCd1FYNEdZd2M3b3BkalA0?=
 =?utf-8?B?eEszUERMTVlYbklReWNGODB2aGY5TmpvV2lsbytzVDRsOFlwR0RCYVhWc0E0?=
 =?utf-8?B?Ums3ckNoTHY2cWU2Z01iR2Q4bWI3WEFXbWt1dDJRajBhdmoyMmVxTVgxMkJQ?=
 =?utf-8?B?cHBkYUtLT0lzZUZLcDIvdzhmUzVXUmo2WlViSXAxRWthaU1VTmREZ3hxVnhB?=
 =?utf-8?B?ck5wZ1FxVjdNYmRIVVhKNm1KRU53YW1sbEtpR2N2SUJRVEYwOW9PTmE5b1VU?=
 =?utf-8?B?cE9XOTh5djNzdVZ4NmVvalFlQmI0cmdVRktreU1oNlE5TldCWUdFc1pPaENk?=
 =?utf-8?B?SlY5eXByTTlHcWEwRHI5OVpxZjF6amNzL1NHZGlkQXgrSlBOaVVNanJrZkd6?=
 =?utf-8?B?TWVrbnVlbjVVSzh4eDJPdU04dm9MdEFsRVVtT3lZVkcwWjBLV2w5dW8vVWZN?=
 =?utf-8?B?RzZGT29kWWJOUGVFaXg3bnBXTkJ4K21FZUIyallGZ05Rd1N4VTFhS0FzZUEr?=
 =?utf-8?B?d2VsQUZuYmxqRlJFd2RCRnFoS0RMTWgyRUFKNEVqdEpNaVZrbkY5bE9jZEt3?=
 =?utf-8?B?MHZPNjY3a2FNUlZHWFg5aUZqblRZZnRpNjNiM3ppVFgzNXRIdWduZjBzVWF5?=
 =?utf-8?B?a0xabTVJQ1VTQmhyenZVbTRNbWxCSkVGc1ZBQnJrYlVVWnpPbnRGcTBxeURk?=
 =?utf-8?B?NWhwcVFOaUZmSHdUN3pzZG13eDJ6TVI2bHFzT3JMQmgrMjFxTGY5ak9XSmhr?=
 =?utf-8?B?NTl3THFveFFQVDFaWExsSzR6NkNQODREK0w2WTRQYXd2Snp5cHZHNHo4Tith?=
 =?utf-8?B?eTJhZzZMbmFSQ2t0REliT1A0LzRIbmRsdmxKTFdVUFQ2a05sQkE5Zm9wVTAv?=
 =?utf-8?B?cjdHcVF6RHBUbm9LMlJWMlpKYmVUTGh4K0NqL0YyYlBzOGhNWUZkNFdad01X?=
 =?utf-8?B?RmJkUGNYeWZwM1Vld2syVC9FY2ZIQmpyZ3RxSW5MYUVNclBBUlNGVE9lbEVh?=
 =?utf-8?B?ZDQ0b1h5ZEdxcTgzQWlFOU5VRXAvVFY4RUlVbTZHYVJ5SStTcU8vczMzQ1hN?=
 =?utf-8?B?UEMwL3hJTnJKKzhVSHZ0aU5hMzE2ZCtUQnBRNDFVWDl0SkFIeU9ab0xwK3hL?=
 =?utf-8?B?bnFzTlJ4NHRVeEQraWNFdlEvY2xyVjhiMExMb3V3eW9UYkJGSVEvaTdETHZC?=
 =?utf-8?B?dGF5Mk9tZmdMQ21Wa2s2MGNmMFpxdXA3YWFhTi9Nc2ZRcGF5bW1RblhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enNGN0FLRUtIcm9SbzBDS2hYOFNjaGx1blpKK3ZWcFhXZ2VMU0xvNzhxM1Mw?=
 =?utf-8?B?YytVdG9uSGhma1IyK1VSak5UTyszSTl5azcxM1VNR2VLdklQaWtJbEhEK0Zz?=
 =?utf-8?B?SXZWck5CRVJuUDUzQ1FEb1dVazJsNTVKM1o1VHFmTU1veGVXdmwxUnkvTmVM?=
 =?utf-8?B?YVgzSE9TQVZWQU1TYTRoSXk4U1UxYWN4Ri9iTEtyTXVoYXk3c1JHUmNNcWdN?=
 =?utf-8?B?bjZzUzRlcHAvOTV1ZEFZa2NFTDRMUnJMRE9FZ0lNQm9rdk1PS0MwbDI0SXBV?=
 =?utf-8?B?QisyaWtQVCtDcFFWb0U0OEJEZG1mUEVrbEhXYkNpYStmZ0dQaEZFMWhRL1JQ?=
 =?utf-8?B?SU5oZGFidlBSNTR1Vk5KVmpLS1JDRVVFUGszL2RyZ215MWRsV1AxTmlrVEJZ?=
 =?utf-8?B?V25pY0VMTGFLL3c1V3Ayb1pmYmwxNkZObURqUnlDQUhhN1lod2lOMWJFUjZw?=
 =?utf-8?B?YU1WdExURU5zZkgvelNWcUt2d1RJdGxiNnFpcHB3bTJndEtFN2VkUitXYjRm?=
 =?utf-8?B?WlhBK3Z6NGJoa094RnhKeWY1ZXNnQmw2SDF2RXRYZjlZRzMzSkd3S1dYVVY3?=
 =?utf-8?B?S0xKQ3JjVlIzYTBYYlJkdENOeEh3cUxNS3BmMFR2UGZvWXVidDQvQU1aNXdD?=
 =?utf-8?B?M0V2SWpGMThkcXZGajBvY25CbkZVc2xqMmFITE5JOWhEbU5FYjZ2anlVSHJI?=
 =?utf-8?B?dkJiWG5NR2RVNFRPN3BoQ3lMeGtVWXYrMmgzRDVzY1BNTTlPR0hud2VpMXlD?=
 =?utf-8?B?em1rT09Zb1RpZGtSSnJJT1JXL3Y2czE4QkpmdzZPMzZHZ2tOVVpua2Zmd3dy?=
 =?utf-8?B?NkZ6czlFYWlaZE8wTWV2c2pYZVEvME14bnlMMThwUVh4K2Q3dGlFb1c2ZXNr?=
 =?utf-8?B?eEJYcmNkOWg2VXg1RmlmTGFaQ0M2VTFaV0RWb1YvcmNMUjY4MzlKSHV0WXp4?=
 =?utf-8?B?WE5vY1dGSEtsdUw2ZHBVMUV3QngrZDdZS2tKOGRiaEZCMHdTRzRJN1ZiM2Q0?=
 =?utf-8?B?N2RzS3gyaXJFVXV4U1dKc0ZaWVd6L0VFVlE3UWhoWXZCN1N5MGN1WmRndDlo?=
 =?utf-8?B?aUxldVhVU3R3MmQ2NGxKZ2xIL0kxbE9yTmtGblB1UmVRMTBVWFFkUmliZTR1?=
 =?utf-8?B?R2lJWGZ5S2drelZDUlZ4SHdUYVNwNEtoM2MyczlJaThIZHJERjVOWjBmb3JG?=
 =?utf-8?B?d1dHMmpIamtaQnhOV0trRmJnVUpjVjBuZTFYV0Y0eWo5MmZxc3BuaTFsZWpU?=
 =?utf-8?B?ZTBiL243RVdVU2E4ZnhoRG9XNXRnTGJLb3lNNFBaM09DUlpBaC9NTytmQVlT?=
 =?utf-8?B?U0dpSGRKdTNMUUwrV3NjcE5FZHNIWWsyeUxLUlQzRHRrZ2ZIUXFHMHZrU0J5?=
 =?utf-8?B?WlBFT2thN3IzSEVaZjI4cUF4QXNLekF4ZnVHL2pTVnYzckIwQ3kvZGd6U1Bz?=
 =?utf-8?B?ZURWempGVzI2aVlsdDRaUFhFU1cwOVB1eUpRbWxjdVV2ZHVKeFlkMTQyQjhh?=
 =?utf-8?B?a0xWcFZyUERFWEJESnhEajBGcjRMMGxGSTF0ZDBCbUxRTzJIdWswSFZ4QWVa?=
 =?utf-8?B?REVBdVRma2NXVWU3bElhb2FZRkJkR2R3NkNBWnFsa2R4TktlZzF1bE9hSFZa?=
 =?utf-8?B?bWoyKzNBRUJUM2NhWi9CUFIycFpVa0VOVVVUZHNpOVJBbTFUTElXdDJRV1dx?=
 =?utf-8?B?Y1J1YXd6bEx6WkJTd0NyOXVSS2RacHI1TVE5Mjk2TDNQZWF3K0E4bG03a29H?=
 =?utf-8?B?Y2F1eFdMVFRYVmRjNmg0Q2FNb0d6Mm40cEZ4Q2JKNFF0RlVYS3FqbnU5Sy9L?=
 =?utf-8?B?dWJRSklOa0N5TGorVFJ4Zlk2bXlnWG0wZGlNU3B3d0h6UHRnZlVhMU45amZP?=
 =?utf-8?B?VldpVWRSZUp0VzVMQTJzeGgzTW5iM3l4OHlDVU82cUpEdm1qMWN6QWppMzZG?=
 =?utf-8?B?WnRJdGhVdm1FSS9vL2pNWkpreGd4RzlaUFdIbk03NGQ2ei9KV21PUlZGUmJQ?=
 =?utf-8?B?RkVuVnUrSHdwdHUrcGRkZmdUS0MyVDJEK0xIN1Nsam1FT0tQejA4YzByQ3gy?=
 =?utf-8?B?aEd2aHlyNHdKWHlrKzhQampNdDVsUmtiUnBuWnNEd0hESFFCNk5JeWxMWDJq?=
 =?utf-8?Q?k1CCX1BWzTOaFMU2Lnyup7MJX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0276623e-e4a6-43e0-e1bb-08dc758428a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:42:46.0000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iga7iu9Cwu2DHUc1iGBtQ6TLdPRAolwdoa/uQNRu9EwIfZ1dsO+njHNLeHB0vN1Co1qLVPI0G6wb6QUYxQOIVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7723
Received-SPF: softfail client-ip=2a01:111:f403:2412::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 14/05/2024 18:31, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Let the callers do the error reporting. Add documentation while at it.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>
>   Changes in v6:
>
>   - Fixed the line wrapping (Avihai)
>   - Fixed query_dirty_bitmap documentation (Avihai)
>
>   Changes in v5:
>
>   - Replaced error_setg() by error_setg_errno() in
>     vfio_devices_query_dirty_bitmap() and vfio_legacy_query_dirty_bitmap()
>   - ':' -> '-' in vfio_iommu_map_dirty_notify()
>
>   include/hw/vfio/vfio-common.h         |  4 +-
>   include/hw/vfio/vfio-container-base.h | 21 +++++++--
>   hw/vfio/common.c                      | 61 ++++++++++++++++++---------
>   hw/vfio/container-base.c              |  7 +--
>   hw/vfio/container.c                   | 14 +++---
>   5 files changed, 72 insertions(+), 35 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 46f88493634b5634a9c14a5caa33a463fbf2c50d..68911d36676667352e94a97895828aff4b194b57 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -274,9 +274,9 @@ bool
>   vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
>   int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                       VFIOBitmap *vbmap, hwaddr iova,
> -                                    hwaddr size);
> +                                    hwaddr size, Error **errp);

[*] Can be wrapped like:

int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
      VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
              Error **errp);

>   int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
> -                          uint64_t size, ram_addr_t ram_addr);
> +                          uint64_t size, ram_addr_t ram_addr, Error **errp);
>
>   /* Returns 0 on success, or a negative errno. */
>   int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 326ceea52a2030eec9dad289a9845866c4a8c090..42cfbf32dc737606c3f620d126f35d85d4833534 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -84,8 +84,8 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>                                              bool start, Error **errp);
>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> -                                      VFIOBitmap *vbmap,
> -                                      hwaddr iova, hwaddr size);
> +                                      VFIOBitmap *vbmap, hwaddr iova,
> +                                      hwaddr size, Error **errp);
>
>   void vfio_container_init(VFIOContainerBase *bcontainer,
>                            VFIOAddressSpace *space,
> @@ -138,9 +138,22 @@ struct VFIOIOMMUClass {
>        */
>       int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
>                                      bool start, Error **errp);
> +    /**
> +     * @query_dirty_bitmap
> +     *
> +     * Get bitmap of dirty pages from container
> +     *
> +     * @bcontainer: #VFIOContainerBase from which to get dirty pages
> +     * @vbmap: #VFIOBitmap internal bitmap structure
> +     * @iova: iova base address
> +     * @size: size of iova range
> +     * @errp: pointer to Error*, to store an error if it happens.
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>       int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
> -                              VFIOBitmap *vbmap,
> -                              hwaddr iova, hwaddr size);
> +                              VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
> +                              Error **errp);
>       /* PCI specific */
>       int (*pci_hot_reset)(VFIODevice *vbasedev, bool single);
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 919c4c52bc1590fd6c0bda37ba5881f58ff2ffff..9b5123d45fc1f9d5be4bbbf92898f89cd11e1363 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1140,8 +1140,8 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
>   }
>
>   int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> -                                    VFIOBitmap *vbmap, hwaddr iova,
> -                                    hwaddr size)
> +                                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
> +                                    Error **errp)
>   {
>       VFIODevice *vbasedev;
>       int ret;
> @@ -1150,10 +1150,10 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>           ret = vfio_device_dma_logging_report(vbasedev, iova, size,
>                                                vbmap->bitmap);
>           if (ret) {
> -            error_report("%s: Failed to get DMA logging report, iova: "
> -                         "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx
> -                         ", err: %d (%s)",
> -                         vbasedev->name, iova, size, ret, strerror(-ret));
> +            error_setg_errno(errp, -ret,
> +                             "%s: Failed to get DMA logging report, iova: "
> +                             "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx,
> +                             vbasedev->name, iova, size);
>
>               return ret;
>           }
> @@ -1163,7 +1163,7 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>   }
>
>   int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
> -                          uint64_t size, ram_addr_t ram_addr)
> +                          uint64_t size, ram_addr_t ram_addr, Error **errp)
>   {
>       bool all_device_dirty_tracking =
>           vfio_devices_all_device_dirty_tracking(bcontainer);
> @@ -1180,13 +1180,17 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>
>       ret = vfio_bitmap_alloc(&vbmap, size);
>       if (ret) {
> +        error_setg_errno(errp, -ret,
> +                         "Failed to allocate dirty tracking bitmap");
>           return ret;
>       }
>
>       if (all_device_dirty_tracking) {
> -        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size);
> +        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
> +                                              errp);
>       } else {
> -        ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size);
> +        ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
> +                                                errp);
>       }
>
>       if (ret) {
> @@ -1234,12 +1238,13 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       }
>
>       ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
> -                                translated_addr);
> +                                translated_addr, &local_err);
>       if (ret) {
> -        error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
> -                     "0x%"HWADDR_PRIx") = %d (%s)",
> -                     bcontainer, iova, iotlb->addr_mask + 1, ret,
> -                     strerror(-ret));
> +        error_prepend(&local_err,
> +                      "vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
> +                      "0x%"HWADDR_PRIx") failed - ", bcontainer, iova,
> +                      iotlb->addr_mask + 1);
> +        error_report_err(local_err);
>       }
>
>   out_unlock:
> @@ -1259,12 +1264,19 @@ static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
>       const ram_addr_t ram_addr = memory_region_get_ram_addr(section->mr) +
>                                   section->offset_within_region;
>       VFIORamDiscardListener *vrdl = opaque;
> +    Error *local_err = NULL;
> +    int ret;
>
>       /*
>        * Sync the whole mapped region (spanning multiple individual mappings)
>        * in one go.
>        */
> -    return vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr);
> +    ret = vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
> +                                &local_err);
> +    if (ret) {
> +        error_report_err(local_err);
> +    }
> +    return ret;
>   }
>
>   static int
> @@ -1296,7 +1308,7 @@ vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
>   }
>
>   static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
> -                                  MemoryRegionSection *section)
> +                                  MemoryRegionSection *section, Error **errp)
>   {
>       ram_addr_t ram_addr;
>
> @@ -1327,7 +1339,14 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
>           }
>           return 0;
>       } else if (memory_region_has_ram_discard_manager(section->mr)) {
> -        return vfio_sync_ram_discard_listener_dirty_bitmap(bcontainer, section);
> +        int ret;
> +
> +        ret = vfio_sync_ram_discard_listener_dirty_bitmap(bcontainer, section);
> +        if (ret) {
> +            error_setg(errp,
> +                       "Failed to sync dirty bitmap with RAM discard listener");
> +            return ret;
> +        }

Need to move "return ret" out of the "if (ret)" branch -- we need to 
immediately return from the else if branch also on success.

With that,
Reviewed-by: Avihai Horon <avihaih@nvidia.com>

(Nit: there are 2 more places where line wrapping can be improved, if 
you want. Marked them with [*])

>       }
>
>       ram_addr = memory_region_get_ram_addr(section->mr) +
> @@ -1335,7 +1354,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
>
>       return vfio_get_dirty_bitmap(bcontainer,
>                      REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
> -                   int128_get64(section->size), ram_addr);
> +                                 int128_get64(section->size), ram_addr, errp);
>   }
>
>   static void vfio_listener_log_sync(MemoryListener *listener,
> @@ -1344,16 +1363,16 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>       VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>                                                    listener);
>       int ret;
> +    Error *local_err = NULL;
>
>       if (vfio_listener_skipped_section(section)) {
>           return;
>       }
>
>       if (vfio_devices_all_dirty_tracking(bcontainer)) {
> -        ret = vfio_sync_dirty_bitmap(bcontainer, section);
> +        ret = vfio_sync_dirty_bitmap(bcontainer, section, &local_err);
>           if (ret) {
> -            error_report("vfio: Failed to sync dirty bitmap, err: %d (%s)", ret,
> -                         strerror(-ret));
> +            error_report_err(local_err);
>               vfio_set_migration_error(ret);
>           }
>       }
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 7c0764121d24b02b6c4e66e368d7dff78a6d65aa..4fa250c46fd16333d2e2358ede8b0a0afdb185b3 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -64,11 +64,12 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>   }
>
>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> -                                      VFIOBitmap *vbmap,
> -                                      hwaddr iova, hwaddr size)
> +                                      VFIOBitmap *vbmap, hwaddr iova,
> +                                      hwaddr size, Error **errp)
>   {
>       g_assert(bcontainer->ops->query_dirty_bitmap);
> -    return bcontainer->ops->query_dirty_bitmap(bcontainer, vbmap, iova, size);
> +    return bcontainer->ops->query_dirty_bitmap(bcontainer, vbmap, iova, size,
> +                                               errp);
>   }
>
>   void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index c35221fbe7dc5453050f97cd186fc958e24f28f7..e00db6546c652c61a352f8e4cd65b212ecfb65bc 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -130,6 +130,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>       };
>       bool need_dirty_sync = false;
>       int ret;
> +    Error *local_err = NULL;
>
>       if (iotlb && vfio_devices_all_running_and_mig_active(bcontainer)) {
>           if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
> @@ -165,8 +166,9 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>
>       if (need_dirty_sync) {
>           ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
> -                                    iotlb->translated_addr);
> +                                    iotlb->translated_addr, &local_err);
>           if (ret) {
> +            error_report_err(local_err);
>               return ret;
>           }
>       }
> @@ -236,7 +238,8 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>
>   static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                             VFIOBitmap *vbmap,
> -                                          hwaddr iova, hwaddr size)
> +                                          hwaddr iova, hwaddr size,
> +                                          Error **errp)

[*] Can be wrapped like:

static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase 
*bcontainer,
           VFIOBitmap *vbmap, hwaddr iova,
           hwaddr size, Error **errp)

Thanks.

>   {
>       const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>                                                     bcontainer);
> @@ -264,9 +267,10 @@ static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>       ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, dbitmap);
>       if (ret) {
>           ret = -errno;
> -        error_report("Failed to get dirty bitmap for iova: 0x%"PRIx64
> -                " size: 0x%"PRIx64" err: %d", (uint64_t)range->iova,
> -                (uint64_t)range->size, errno);
> +        error_setg_errno(errp, errno,
> +                         "Failed to get dirty bitmap for iova: 0x%"PRIx64
> +                         " size: 0x%"PRIx64, (uint64_t)range->iova,
> +                         (uint64_t)range->size);
>       }
>
>       g_free(dbitmap);
> --
> 2.45.0
>

