Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320E1C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wykOc-0001fc-7n; Tue, 25 Aug 2026 02:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wykOZ-0001dy-Fz; Tue, 25 Aug 2026 02:12:27 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wykOW-0003yf-Q7; Tue, 25 Aug 2026 02:12:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzm02Nfdt9CnelgcDCQEBPGQ04hdC+KCQbBIpsTb4ntDNQ6FJtuGQ5zta8J26qWCeCHab0UPvqjqqcdIPmQSAaAlkQqUY51iCWXWmE0i6gXzRm/VW2dNUYF548BQ4kbRV6pa5XzVv1Lohp9QmDn4x/ziRbhkWw1dclvvOONmUNN4f8GlLnK8GyIhKzwuixp0CruOiKpAWe/DnifplpLWwnsuXgzeJgRynIFvxmysVM72E3u+PQKHQbaGW0xFiAdHP1LZCO+tjA6byBfcnilZli+BHyUWiZaWYXrNTysNfVhFgRMKF7YJSuUOm05BgMQtm5bDPtw+O0euE94gw0C2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cM/+iRQHFFy5HVna8WEcRJgocxv39dGTKLjVCdeSfQ=;
 b=ynIplXvCwMIYBiAi7pyvnymslje+55+eVfLXTSyo1kioSYRVqqJCM1HScUoODimLzh9TJ2JTUBaE+Inw9OftXD75SpLcbGClimdtjkZFTq62AOhRu3TlFsEscCZYeQpCF+3yET7NMNUtzopLueTdaWuq6TTB67Lg7DZW/JgPF4a9hjFolPR2m9KfbOr00WJe9kGpdXnuAuaYozdGDa9Cmcn2Ualxh9KCwWCRRfAArrbVwwmC2hEQoI6Qv6YSFDfmxe8z2dtl8qQ00wQnf26ZZv8UyI6g4uDyAUdytlAVXord1QYo5wO7sVPY/qWN8RtOT6E7uugKQ3lhedEzpnUyVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cM/+iRQHFFy5HVna8WEcRJgocxv39dGTKLjVCdeSfQ=;
 b=WoQttdKSGp0x7EppdBHMwd96EpiLC8TELcM+gyxsUDqJyJQ5T0Ljln2ZRswB6YDWsvLxtEgEweYXnKsG6lpVwNifiNjHmBUK+/tO8Xk6WNVVlFOcR0kormFPCOgz3iaXVch2/ftgpwQ4smvaYeQOkZJsKQ1uctvJk8Pb+2oiLE4ioHj5wgsnEnEWdVoFJz70KPzJBBwpEp2bogILej6b9tEywcYCcxbIsG2sPs6MqySfFS7Vr+JCWy1i0mndfU1Mhhjmz6Uziu+dAnfoHgD32+Qr2/6jOw3T8rvOzklr9pibr724r+eUeSohSe/P0hhvoONr4R9CaRGNbn1d3yyPSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by DM6PR18MB3521.namprd18.prod.outlook.com (2603:10b6:5:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Tue, 25 Aug
 2026 06:12:21 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 06:12:21 +0000
Message-ID: <e2701793-b7d7-4b96-9835-1e173d479747@axiado.com>
Date: Tue, 25 Aug 2026 14:12:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] hw/sd/axiado_sdhci: Add header guard
To: Jack Wang <163wangjack@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org
References: <20260825021155.2475879-2-kchiu@axiado.com>
 <67241963-D3E0-40B1-96F4-7557904C082D@gmail.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <67241963-D3E0-40B1-96F4-7557904C082D@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0058.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::17) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|DM6PR18MB3521:EE_
X-MS-Office365-Filtering-Correlation-Id: 33bc0cca-7828-490c-4512-08df026fd2a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|5023799004|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KeufimWiJsy51onF8TkjXRnKVcxzZqEJXOGUepz+sgc0q8QPJ634Nb9lPlkklBnDVFYaWOc7YTP6aCZeI+AkDuTlQYEMjiNxnGhdO8XsWcz6GZJWNNuuySuw/aPqTaIzFA6eDpTjoQpMwNqnQRyaQTIz8IvoPkl4j3Lk6DBGxiv26547tPIrlFIsnzHIUeF/Z/GNThQc0LPZqjqGRE+jBirkNDyxyYzF/cU/A3acU5vrsVi6+dCHoSgBJSbgDAlOGUo6amNKf13s+nnBivy6dFwQY76Pt3vbm8ufM4gjalX1+BdM9ng4+poC7CTwNywp0deJmZIMHiv6CmXw+manShtzCAq87pRa/P3RfJh5ISup+WZermU8mIdMMa1OgxDqmgoRHiENbhkvFYU3SU2XtkAHGrvn6qrwSUSXTA4/TF72dUO4QvYnlzxao67kYVbmfNAzaXY9KANW0DtiqgW7mMLGGbO5FxTWgWVsOHeAP7W3d7CwIYP52CZghcxTsG3sF/yIITyisSGgu42G24iOHvAi1zBn6AleMZbY5fZRCfn8uNjoPcmbvLG1eVrkujDTnADvPSMDP0qkGyINxKBYhFVBWdnCCnoIdUTKyGNtiltwXIBS4FQtOzEllnWJAfu1Ffd6lyNrgj8Z+SBqqh3uElJhrMupG+mXLGNmny+GUQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(5023799004)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3ltNlVXUHQzNUloNjA5MWp2RE42enJIWktMM0lBVnlQTjRSV1A0UFJ1YkYz?=
 =?utf-8?B?a3NEeStDSDBXSkR5bitJTGVWc1ZFRFczWmhEWnFoU3NwT2wvYlp5QzZiM1pO?=
 =?utf-8?B?QXZYRjdvM2xxSWkvaWF3UlgyaDJzQmRnN1VBNW5PRWp6MVhKcU44dEs4bFRr?=
 =?utf-8?B?REhsSjhuaWUrNDBhSVFVN1ZuNkFBM2QvV1dWdGlnWWNQYnlrY2VoNnBqanFO?=
 =?utf-8?B?NksyZHI2NFM1M1BRNmFUcVFBamtnUE0rQjBoVnpPQWpPRG1uTU5iYnVuR3Y2?=
 =?utf-8?B?UnBobkVPOWkyL1o1eTdqUjVRN0NPWWRINnhwTjZ1L2ptaWpEMlVrc1dwTFZK?=
 =?utf-8?B?TDU1OEdEKzRVWG1sNnQ3TkJrclVhaGdHMWNKV1BqMmYyQ2FQUU1ZWmRhR2l2?=
 =?utf-8?B?bzd1ZFNEMXYwemxZR3ZvdHI0czg4WTg3ZTNhMEdXWkVhb1UyUHczbEVRRE1E?=
 =?utf-8?B?VzZsUmZyUkpwZ2VyeUlGODJkYmx0blNkNWtJMXlRcXRmbEJ3NjBqL0xTTG9B?=
 =?utf-8?B?ajY0K2VsKzcwV0RZYzdnMHFFajRsNHBzdkpjRkNCZUJkY1MxdG9IV0xPYVlC?=
 =?utf-8?B?VHNLbTFLQkNnQ3JCRWRtZlVhZlcydWtHL01MZm1PSzVxVW94MmRXTWhFRTQ5?=
 =?utf-8?B?N0V2azZmK0xUTlF1bzNFdjE0YXlwWTFiOUxIN0lYR1BzdWVuWDFaQ0dxV2V0?=
 =?utf-8?B?ZTcwZGk5L21tSDBwRlNESG5XY0FKMmNRT0VpOUR4S3ZObk1ZR0NUVmM0MDFP?=
 =?utf-8?B?dzgxNnNuMWVnUkZwWkxtT2MzQnMzK3NFdThVT3M5ekl2djMxUXdJMmZJd3kw?=
 =?utf-8?B?ZCtYUHdycW9VUE4zeTlxY3U5Z3NRaDcxZWluK2ZKNVN0UXRSTFpzK3ljNmRU?=
 =?utf-8?B?V0tOU2Fad2l0Q05COTFFdkVIWnR4VG5rNzNubFRtbGM3eGNDYmRiVkJnKzF4?=
 =?utf-8?B?ekZkSTlGM0dReDhFdnJqaXRncjJmQVk1akhlU2M5TEZWbUVvVy80eEpKZ0Iy?=
 =?utf-8?B?UXJlZlRMNlBvbU9qdzFrQk4xZUZ1Y0RCQ0xtbk05SEF6SUwyM3ZtUGgvYjh3?=
 =?utf-8?B?bzlhODRUNkxiZkxJdlV5aHVGaTRLN1daMHR6MFV5K3BGSEhXdURnZC9vZE5Y?=
 =?utf-8?B?M254SkF1ZVozREZVSnpCeGNGaDMwd0FmbHVlQis2cjVkbmlNcjZ6Y1VqSVFp?=
 =?utf-8?B?YzNNRm9qVXNhbW9hQkZTTlNQeEp6ZzA1dm4raTlHSzlsMjNMay90TGsrbjhu?=
 =?utf-8?B?cnJxODZ1Zms3NlEyRXlYcWgvUFVpbWszc2VTSDhjQmcrdUo5K2tYWUJzN25E?=
 =?utf-8?B?bjgwWGZ4RVZiTjIyMnVNdnlLOFZhU3RackllcUxmSWY3QVZsMUIreTRycmtD?=
 =?utf-8?B?RUhkTi9nbGQyY3lyQm9iOHFJdThMRHhDRzZseFdZcytURk1HUG42Z2JvbDNh?=
 =?utf-8?B?RHlqcmFOYnhRcERaNCtoT2FzN1dxTUt5Slp4NXRQZFlNejdPNVUzU21xNUY2?=
 =?utf-8?B?RzlYZmVlSmRRd0J0SFdXZUhPdUt4TzdlUjNQKzNYbFBpTklLbjRaQ1pOK1V2?=
 =?utf-8?B?SWRnRjEwaENKMmhNeXFvVDZ4ZXR5aGJMTVB5dVl4Q3RrNW9XaDc4bHpUNFdS?=
 =?utf-8?B?czRFNzBLcjhLWmxqZXRldHp1R1pvTnBRMnNYQkwweVh6b0NzbVVsditqeEZC?=
 =?utf-8?B?MjVFdjhHS3ZBaDNWSWQ2L202Z0hsVy9xdnJHTmJjT0wvbFR0MTdKZ3BZKzRS?=
 =?utf-8?B?WWZuN29vTSswZEdWcUhaVmExRGlXRFlRMDJHY2g3a2sxaytpcG1HUVNDZEQv?=
 =?utf-8?B?SEhzcFA1V2p5eHp5aFp3TElEQVQ2WlpjRWU0QkNrUXdGMXJuRVJNYU1JN1R6?=
 =?utf-8?B?blA5bXFZaWJCMkVZY0hCWlhPenZVdGljcU85WXc4M0ZtZWlBT1NxQkxTTjky?=
 =?utf-8?B?cEhhcGpEb1p1UWlOWFdHNVZzbktzQTJGbXNkZ0ZXV3JZS0duZDFrYmJkUVNC?=
 =?utf-8?B?MXBWMkJ5Z25HeWNWTDJ2MUE4Wm5xZExBUjViRkcrUWRwTFY4YkV3Nm5STUJp?=
 =?utf-8?B?bEMvTFQ1K3BjV0tsYUhSTFNoanNQU0lSblZVYTZwOUdXeXhmWjVrOXRENm9k?=
 =?utf-8?B?RStCYm9IOHJPS1JZeTRSdWJKRkFtZzlFT0hXc1RiaERGUXVXVWVKbGZvT3dy?=
 =?utf-8?B?eFMxOXRxU2F6Q2dLS1FzdFc2YUxYMHVCY3Q0VGd3V003WVFCMEg5RThlWHBE?=
 =?utf-8?B?Z25xM1VkR2QrQ2JEanAwZmVlN3FtMGN0dG1xRldickVpdkxPcEtPWlJtQ1Y5?=
 =?utf-8?B?QndOdkU2bVZrcmlhMzJDeUhhLzdjWDJFanlBRmN4blNrRVFiREZDUT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bc0cca-7828-490c-4512-08df026fd2a4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 06:12:20.9462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ebg/xAwkQ9/1BoARqSoTTpsrYLMD2kJhzkNFEikxW1k9BgzFN6YD22z246hSCd34D3qJndwUPq/XmhmdEG4LzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3521
Received-SPF: pass client-ip=2a01:111:f403:c112::5;
 envelope-from=kchiu@axiado.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Jack

I did not add commit message because this patch is too simple so that I 
don't know what the additional explanation I should add for it ...

B.R.

Howard

Jack Wang 於 2026/8/25 下午 02:06 寫道:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
>> On Mon, 24 Aug 2026 19:11:51 -0700, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
>> ---
>> include/hw/sd/axiado_sdhci.h | 5 +++++
>> 1 file changed, 5 insertions(+)
>>
>> diff --git a/include/hw/sd/axiado_sdhci.h b/include/hw/sd/axiado_sdhci.h
>> index 85afebad93..ab52eb8185 100644
>> --- a/include/hw/sd/axiado_sdhci.h
>> +++ b/include/hw/sd/axiado_sdhci.h
>> @@ -6,6 +6,9 @@
>>   * SPDX-License-Identifier: GPL-2.0-or-later
>>   */
>>
>> +#ifndef AXIADO_SDHCI_H
>> +#define AXIADO_SDHCI_H
>> +
>> #include "hw/sd/sdhci.h"
>> #include "qom/object.h"
>>
>> @@ -19,3 +22,5 @@ typedef struct AxiadoSDHCIState {
>>      MemoryRegion emmc_phy;
>>      BusState *sd_bus;
>> } AxiadoSDHCIState;
>> +
>> +#endif /* AXIADO_SDHCI_H */
>> --
>> 2.34.1
>>
>>
>>
>>
> LGTM if you could add commit message the better
>
> Reviewed-by: Jack Wang <163wangjack@gmail.com>

