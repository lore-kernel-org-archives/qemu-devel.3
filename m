Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C752F8D76E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 19:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDSnR-0005SW-PX; Thu, 16 Apr 2026 15:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wDSnL-0005PS-95; Thu, 16 Apr 2026 15:54:35 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wDSnJ-0005LF-Hj; Thu, 16 Apr 2026 15:54:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZsOoA3c0Xogdq4pfNA4bfNUXb+uazglnZ4/fNu3mAW/vdQV/MZXSL//npYKkknh8430PQLuBPrVWT+fkvr/ghru6hrrwfAhmtO/bQgytEUAAZmwCIqmR0OI8Pk2d+BjGddWyUX/VxYzpmkhUFfR64Ktx3ytiyRtHBHaCsszgtz31xyc/5iMK3py1wj1e7V/ctMY3Qazqq2UWzhDAfU73mLnVRuZnrlPRJMLOBN0xACEI7WNxpWVtHXnfmSxrP77GBB+mTvqW13LNJALgBA138NESc9styz/RaSys4IvefSzobm4ymJa7NIrkdECJo+3sDdxTrh/UZu07IEiTalKPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nrl4D63K8ciNbixlSSpm/wDbmBWgwWKdpS2XFB/gu0c=;
 b=qnD4LPUMwX36iC52XXeZvZfqTyRfw7tUtP4SylL9iQNscw9ueBlOkdV0+PmkE6uBXa7HYPb5dlnVXG3GrHTejdIZiS5g4te7C2HJQhwWOUIcDc9wxL1Bwfv3/dEd/D616bDbdHBdJdevfK8MXDubd/tpDztKap5cmfpU2oQPXNYU/tm3/BZFJTWXEiSXE46nsV9dAYKUVxPKqWlLqqy5Hd9y+2Q/uzyWDdKxa5NIjGpjUZ2wYQeukgBZ5uzJWUH+ipbSGt/Jmfa0Cp7w2dJArb+cPQuFDLPZzPISekT2jP40Xj7DTiFQAqyJzkECmjFVwuLdBgAhZaR+01UCOvB8tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nrl4D63K8ciNbixlSSpm/wDbmBWgwWKdpS2XFB/gu0c=;
 b=bcLmxhrFplpxnHcHQoosdH5Oynjkg4hAuiQT89+mgKEWru2rsoeZoWKrrI9fiWGM0pWUjuca9yG6dZFwqTCXtbYWdI0v5DPFpUQ6rsXQBIeCfWgTEBLfQF6VY9CYYu6bsAciEt36Wz7uzy9BI1LNBfkqgz22ilGUZO+mWjVFN7R6pmaBt9NPD+tPvzlDwvSxBUqfSx8yg0YYYWcLVVoEZJu0TDEiEok+haM5+HD+5F+lkRq6iopg0Ns0olUen7ebIAwSD/YthpdaStt0LXSKQTpvfF+FDwNfMoEv4jLMlYtaLYJyfKHWuODblFeKVycge8CdpyrEX3m8KCRejRjVZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 PH0PR12MB7010.namprd12.prod.outlook.com (2603:10b6:510:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 19:54:25 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9791.032; Thu, 16 Apr 2026
 19:54:25 +0000
Message-ID: <bd176044-f05d-4872-855d-75bd8e7d68c6@nvidia.com>
Date: Thu, 16 Apr 2026 12:54:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] qemu-options.hx: Support "auto" for accel SMMUv3
 properties
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
 <20260401010231.4166776-12-nathanc@nvidia.com>
 <CH3PR12MB7548054E649B96F63DF1E56AAB232@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <CH3PR12MB7548054E649B96F63DF1E56AAB232@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::10) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|PH0PR12MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dbe650c-9f57-4984-6f2d-08de9bf1f5d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: IIYN6hxX2YeYvhdWZ/6q73fQThti69y1NTX12f7V/kM+fhxwjMchJCLNUtINLMYJKMiCGKSuE5iw9D6TErMrmwan5TPzeYAwHzwMYtiAQCqvjtqYebwr+pM5bcuVdaVsJVl48xyTFiwj8uZdcY5ikHKIJFRM1U3trIswHQoKS8KaUKKWPMVq3MYr3/Ehkzmjsam6Tzzcg8DwiyV0hEtI4dFXQttX5WAzGlA27NBqhjnCYX9HVHvntyqqak60tBNBFI8S43xVN4jT1dQkff8ihPzd89OSqNq9jX0hT/Uo+a4OTVC6NrNlBXUoW0z36tu22FlJ+dyzgCg6hg5SH6PNpk5MYhJf6I755FtMbm91jA6Rpt5UveOsMk+VLhCNnHhD4wL/LoDq0t7R59V4bZfmnMihONNa6gxcmscFccBEPoiCw3dZwAZ+RYPKP7tDzLj+jLlrzqSiHUbkfGBnA3Od3ahLnpgGAsB4JGCw+BpmABE/1wv44kgLo0mUkubzo2GNIUYzF3LmiS4RDMJBSTc5l/B8L/Rm8eXodmUJrO004STCe92AzrNGVunMPYlGT1vbCCLxR7w5/PUItFTPELnHsUyYNHj0hp3eegvqw11cuFX2Uo4DOxrgcPn/dllIaYvlv8XC8Rf8NakZ6hQQCYdPAPp0DfBIYA+pyLgdaUgFnP9cih5z4i9WMpjA2MBSbOrQhOfptuwvEItlyCVRvPK1WlA6a2WbdPrK4jXcQmdQw18=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXR3SGRMU25LUkF4azVXMTVWTXBUMlpVaDZtRTFSd1QrNWdyd1kxYjhYczlj?=
 =?utf-8?B?TDdocnRheTJ6RjhZYXBRKzNzRlVRK1ZaVFIrTXJXM1NHQVEraGVwSklBQjVl?=
 =?utf-8?B?bWVQeGYvUVdRdWZ6c1M2K3pON1F4TS81UlNibjlONHBlRGtOcXkyOVJFeCs3?=
 =?utf-8?B?SFVFdlc5cTg3TTBmMnlrMWl5ZWU3ZnBDMFpOYngxcUVQZk0zdlBUR3doY0FT?=
 =?utf-8?B?MW5rZHg0RGo2SDVDbWRVS3Jzc1ZIdzZucEhNMlRRMkFIQjMxekRld21mMUFr?=
 =?utf-8?B?ZlZKZkFRTDBwcVJRNUtEckNrbS9rMGtXRGZjTnEwME96Z0dlbzFwWDVUb0w1?=
 =?utf-8?B?V0JnYzNFdkJ4aVNKdzh1TzNCb3lIeVYwNTBxdUw3aUhRYWxnOGhBVFdqSTh5?=
 =?utf-8?B?VVhNaXAvMGRYMjBIRFhiTlZWQmRNLzVPRGZhZDlNWHpKSWNmUE13RitJMkpZ?=
 =?utf-8?B?RUJjbGNoUEdKN2MzN2FIY05jSUdzT0ZaZGJ0K0RNZEsyZXFMaEpjMnJLOEtm?=
 =?utf-8?B?S1dKOERnZlh3TTN3WFB0dlgzRWRIQ1ZKK1N4Q1ExcDkvWkw5VUlpNnRVZmJQ?=
 =?utf-8?B?amdhcGt3MSs0WXpGS2I5cHZZcDhKSmVsV0NlYTBvU3lzUFFtNHlNaHc1QlI2?=
 =?utf-8?B?a1BNaFJiR05mOGgxVkZuUzFBMS9oNHZKcnZMMnYwVS9aRFd1NmpEbTVFeFQ5?=
 =?utf-8?B?UmxacHluajNjTEFpLzJIcW1rYlpUODFhV2dRM2JFT2lrVmdrQUhNdmFtUHRM?=
 =?utf-8?B?bE5RN1p5bGVONU91Vzd5aDFrOGhQa0JJcVQ2ZmJJeXpnd045ajBsUy9PdThn?=
 =?utf-8?B?MWdnMlljelZqMFFQOG9JK1ptUm0ySEVCMEJTaDFlSDRZUlZCREgxSVZlekI4?=
 =?utf-8?B?dTc0SHM4a0FyVmpPc2pGbHhtckVHZU9qME0rR1VROFBKQ1pTbE5mME9zVXZl?=
 =?utf-8?B?bko3dnFXUXNkcFV3ZWNJNVNSOFMwNVpjRmZnNFRYVm5VN2RrcVZUZjNmN3ZK?=
 =?utf-8?B?c2JwQVpjQnE3N0F5T2JUNW5NSGxWb0VCcW9jZ2ZMQ1dLOTJ6TXBBNjc2L0Zp?=
 =?utf-8?B?aERTRlErcEgxSEZxNDZjMDVGcEpkdFRGY3VkTW1ueEplQjVpWEgwZEpka05i?=
 =?utf-8?B?L3k0UVdBNXlhNHBVdGdiTGJSeElMUEtZdDFXSWt2c3VlR3lnNnFMbmNaZnVq?=
 =?utf-8?B?eGxwV1dYNVpCd1RkQVp3L0dQeE5PdlJrNGEwamZtYmdwQUZObURIWEFzUkJZ?=
 =?utf-8?B?UlFpdTV4d3FGWnBja1pTT2ZNM3FvVnpJWkRkeVRJdW9EeldPZnBOeXNrY2NK?=
 =?utf-8?B?OGRDY0xMVUU0dGExb1FtRkl4TlZJcHROTnplQ1l2MEY0ZU1jd0dlUkREL1U3?=
 =?utf-8?B?UksxUEdaT09aZTl6RExlaHhTak1Vb3RnQWZCMXRSUkdtdzNYVjdlQ2k4dk9z?=
 =?utf-8?B?dlUyYVUxZHM4Y1phVWcwQ2ZlVTlRN3RSNlVxTTNaQnY1UVcwK2xNcDk2M1g2?=
 =?utf-8?B?ZThyUFRJY2NDS1hqcXUxanMyNzBlVklyR1VzT1RNTFZzZjIrZUNIWlllblpK?=
 =?utf-8?B?b0o3RmlNeDlxM3ZTNDdGTTNnbUwvNEVnZ2xuWk9FREtNZ1hGRkhEejdtVTl3?=
 =?utf-8?B?a0Y4UXZrQnZ1L09WSVZBSEExblErMHduTlQ0a0s2aVY3YStUdzd3bnE4NVpE?=
 =?utf-8?B?ZnRuOXBDZ0xyRDRQL0NIc0YvZVkxc2taemsxMEpldVFXVXU5YzZ1Tk1ETlFY?=
 =?utf-8?B?SW9kV0hackxFcmtsRS9VTnFlZXZFdmNyTlB5TGlFM1BVcXZQazdacTNVakpC?=
 =?utf-8?B?NkVwcEJib09sVWhiSEFCWUtZd2I5M1BOWlZpdmplSkFkSW4zaUIyVzhXcG5W?=
 =?utf-8?B?ZkkvTmRxK0hkb08vQUFaZDA5R1ZnYXJlWkdqMmxjeGNPSDdYOUt0VXVGWnFZ?=
 =?utf-8?B?MUh5S3VSVkp0aDQxZVZiSjNFRFR3MzNibXhudEhWb3pyaTBCeGo3QUFnTGdO?=
 =?utf-8?B?eERXM2JUaVFkMlVuMTNoWGtWL29OZXJQZGg2dDVnS29YWjJQMm02VldBa0VJ?=
 =?utf-8?B?RytMTFZiQldTV2FLQnJyRXN6eVZRV3NnRUdnSDZsT2xFTTdCdklSejhxTmRm?=
 =?utf-8?B?M3RkYnhaTkppenExMjNQTWxYaWFVVUVyM3JsaU9reWF0RDl0bUJpdnFCZnBj?=
 =?utf-8?B?dURqUHh4a25ncGxyZVhwMGg1NVQ5c0JGUWgwa3ZTcWZ4aDBBTFQxVVNKWU9s?=
 =?utf-8?B?VjhmQWNrZy95QmorbXdGbmxiOUJOUmd2VXIxWStvRDBIdVhpNmdDbzlFeUZF?=
 =?utf-8?B?RUF2K0xvYWQ4MFQ3MVdvc3ZjUXJvN0EyS1kzUVc2U2xXbUw0M0Zkdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbe650c-9f57-4984-6f2d-08de9bf1f5d7
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 19:54:24.9051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsVRFiX1HZ7ruQHwS8kpwqWnhuje3dJ1EgywuqS6qeNvijhJNdW13G/ChtaQzQ2crYyIpuf6O5eK9wAo0WDf1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7010
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=nathanc@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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



On 4/16/2026 7:19 AM, Shameer Kolothum Thodi wrote:
> 
>> -----Original Message-----
>> From: Nathan Chen<nathanc@nvidia.com>
>> Sent: 01 April 2026 02:03
>> To:qemu-arm@nongnu.org;qemu-devel@nongnu.org
>> Cc: Yi Liu<yi.l.liu@intel.com>; Eric Auger<eric.auger@redhat.com>;
>> Zhenzhong Duan<zhenzhong.duan@intel.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Marcel Apfelbaum
>> <marcel.apfelbaum@gmail.com>; Philippe Mathieu-Daudé
>> <philmd@linaro.org>; Yanan Wang<wangyanan55@huawei.com>; Zhao Liu
>> <zhao1.liu@intel.com>; Alex Williamson<alex@shazbot.org>; Cédric Le Goater
>> <clg@redhat.com>; Shameer Kolothum Thodi<skolothumtho@nvidia.com>;
>> Matt Ochs<mochs@nvidia.com>; Nicolin Chen<nicolinc@nvidia.com>;
>> Nathan Chen<nathanc@nvidia.com>
>> Subject: [PATCH 11/11] qemu-options.hx: Support "auto" for accel SMMUv3
>> properties
>>
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Update documentation now that "auto" is supported for accelerated
>> SMMUv3 properties.
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   qemu-options.hx | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/qemu-options.hx b/qemu-options.hx index
>> 21972f8326..bd43258445 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -1292,7 +1292,6 @@ SRST
>>           vfio-pci passthrough.
>>
>>        The following options are available when accel=on.
>> -     Note: 'auto' mode is not currently supported.
>>
>>       ``ril=on|off`` (default: on)
>>           Support for Range Invalidation, which allows the SMMUv3 driver to
> default: auto ?
> 
> This applies to all other properties as well.
>   
> Also, it may be useful to clarify the "auto" behaviour, something like:
> 
> When set to auto, the value is derived from the host SMMUv3
> capabilities via IOMMU_GET_HW_INFO. This requires at least one
> cold-plugged   vfio-pci device; if none is present at machine init,
> QEMU will abort.

I will update the default to auto and clarify the auto behavior, thanks 
for the suggestion.

Thanks,
Nathan

