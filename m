Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C28D690F2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGbqW-0007Oa-4t; Thu, 28 Nov 2024 05:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tGbqU-0007Nq-8s
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:34:02 -0500
Received: from mail-co1nam11on20629.outbound.protection.outlook.com
 ([2a01:111:f403:2416::629]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tGbqS-0004D5-2Z
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:34:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcizoOEQqHRNvGGxTcvSywgJ1KN/bOV3JS7fAMTPZsKO/4237w6tlb1ayZ6QmtqA9hZxNTt+eNNE8ZYmg5zidTBqBQ4S97VIJvbGbvaop6H85NGFLZ46JiHKm/1N4JFxUsmWDusigRgWgdvdKJzGuoAHGw7pEUYzp54L+oXn1ISCkm8kHWfdUE4NKYeXyDqN6i4M05Sn8o4r+1crJwOPZH/GhnhmKAATJDo2THycH7fgLVXM8+KIiHP9sLEuz8/+aKhid0vA0dVWuCwc1k/yEzLsu5gs6j+kPAADFY20V7ONKNTbl5YY8gcLSrwgFIcQ44sG7hlrYvuwfnwB7mI4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxQ64B388csvMEoROuxtojAzXqyVyD5j2XWSVLUic1A=;
 b=ECK2qv4pym8Zo8NlG696tBOH8Dkitvi0jFTaaLX4xUvkMlpkmLPE6hvXRAipXScF9v6mnik3WNAuWuOT5FYEBwU55ewAMfNNgN8omEz7mQfOfQ7xNJMPg1YbujTetNCBN5tG8P9UuxS1afEr5DCG6JEt+2Onumzmc1mta5Icq0CJRZBMujrC8pz8HkKCe1JedGrxVgfto3j12wRqdsrvB8mJCzGKTnGV0mmJp0yWLjLORKYRf/cwbPI06QHBfmMS6juf1Ih5Abezf7coXzsDYB8Hzk+9jL3sX7cpgQjR/+QedMzJ52cdgrvIjcKwNYiMoPG8DBDj6xlY2a8riHDFgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxQ64B388csvMEoROuxtojAzXqyVyD5j2XWSVLUic1A=;
 b=aA6MVo+a2ffrV+5Oz6kn47/6kCqUdrJHB2k9ZHRAlo7V5dY/4vh5DAnBeZMljQjDLV1Q/Qt0vhUU5u/uAP4peIF/rX73V4ffkLhk4DrChBSiEI8S1bLzpRUI8jT/SIpefbTsj7JyZm6dRs0v2r9iRws+Z7Kl5//zeeNakxHpmRjqzEy6Gy5v94h9Fr349g1A2s/lmplB+PHlKDsLZ1Xey3M+WFg4XHvkprdx1RpTFXZ0nSkLbGz85hkaVXz4mAX0fdgsO1RGYA76QKN/8BdWl2hcW+egNa/hjJimp7+z6NK9k3vPI8MJxwzUhIs62UbUQQl91r9vQvYpQ37xlkIE/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CH3PR12MB8284.namprd12.prod.outlook.com (2603:10b6:610:12e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 10:33:54 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8207.014; Thu, 28 Nov 2024
 10:33:54 +0000
Message-ID: <75ce2d3b-9abc-4dcd-a221-48d2935715c9@nvidia.com>
Date: Thu, 28 Nov 2024 12:33:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/24] migration/multifd: Add
 migration_has_device_state_support()
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <ca43afdc742ccf8070b1146014ce33c333e85d8b.1731773021.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ca43afdc742ccf8070b1146014ce33c333e85d8b.1731773021.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0593.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::8) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CH3PR12MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb0ad89-05d4-4365-91a8-08dd0f9827f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djVEWjZjRnNxL2JTRUdEQ3NLNEc2dXBZMmtPWGorQ0YxY0hRa3RjVWQyQmVR?=
 =?utf-8?B?TkhoTDFkdHJDNkROK1R6WFVKRmUyV3Q0b25zOTE3WjNxU0ZPaC9KUlhGUnFq?=
 =?utf-8?B?Y2djR1NSUXpBa3NnMFVHLytkd3NVZm9UYXV5ejJkYXZMY1NUWFNQM0J0UTlI?=
 =?utf-8?B?ZUYwWjhUM3J3Z2VYaWlBZnJrd1NoQjZHMXRWeVY2TFpVMXplMXRsYkZZQXR4?=
 =?utf-8?B?T1F1U1ZJVHVPWkpxSGRPcEt6MktYRDRhdVoyY0VCMnFUSW5zQmtnS0FFZGpa?=
 =?utf-8?B?KzdUWTRnOHF4UFphaGQ3V2N1MXlIWlRRaHl6V2VKNVNsazVnSm9SMEc4aFpi?=
 =?utf-8?B?VW03LzZFbjNjZFhZRE1mS2hMTVA1S1YwUWRLK01UWjVsdHk2bndwT3NrS1hv?=
 =?utf-8?B?VksxSm1rRGNkY0YyLzdna1dGTVpUYW1Cek0xOTZSYTdFUHp4VWJnRzlCRU16?=
 =?utf-8?B?U1lDeTA1RUhtWnkwbFdxbWx5Si9qc05hQnNMK1RUVld4RE9vTDZzOG4wWXpY?=
 =?utf-8?B?ZUVKSHBtSElWd3RKTjcvY0VYWlRLNTFadm5GWHpWQzlRNkJoSzRtUVhHS05L?=
 =?utf-8?B?V21kL1M2N1dOSTh3U0tKcVprRC9XcVJDc0h3OEJlODQrOE5ISDVNd240aVhh?=
 =?utf-8?B?WWNjcGFHVmFxV0tJa2JEM1ZhQUpySks0QVBqL0FETlVuN014MlRtUVUwR05n?=
 =?utf-8?B?MWxWbGtqckgyV2FybTRzZWZoK1ZSMmV5RlNtbkN3KzNKd0FlNVlWNGthVDZr?=
 =?utf-8?B?VTJrT0ZJQUZ3clRzcUduTnJ4eFNMY1RLSDh6OUF0ZzNJSWVhcjNLV1M3ejc3?=
 =?utf-8?B?cGM1OExmK0RGUGhWbzRKOGtnZzJFRGlqdkMzZ2lQdUNEVWxBTGdBM0lrVGpP?=
 =?utf-8?B?bE84RmdXZmlCQ2dFRjY4TVlFOGtBcGhIMitVMHJrYUpFRWhwK2dJRm84RUpo?=
 =?utf-8?B?QmZCVW0wSXFkMEhaU0hSU2lMSnNTcTBYZXBuTVA2dlJWTGVjMGJPODgyeTVj?=
 =?utf-8?B?ZWpXK2x6N3phbG9FN3N4L2E1VUVRU1RoS2UwOWRzbm1kM08wQmRvSGhCUVpV?=
 =?utf-8?B?SHBxaVRSQ1AzSXVMa1NZcUxobzF6b0RlTm1LazBBN3FRbFhrakVWWkIzYjJ0?=
 =?utf-8?B?dmsxTEFxRHVGUTYvTVIvRFpqZ2hMWHVwQnBuakRyd3RoYjZZM212TXh3R1NR?=
 =?utf-8?B?ekR2Zkxhd0tVeWZtdHdDOWlGVzlzalluR0svN21WSU1PRE1ranlQbmRNMTEx?=
 =?utf-8?B?UE1neklDMjZtelprWHRFTmhnTnhTMno2dC9yL05XbEwxdHlNc3RxL1crOFlV?=
 =?utf-8?B?M2V5NlcwNFdVbHg0d25CRmpHaGx6azZQUTI3aVZvYXFVb1F4VnVNbldiekQ0?=
 =?utf-8?B?d0dFamVuNnE0bHBWRnFUaHNyOVZFaFEvUVRRWlBHU2pkTEY1cVZRR0FSOTc1?=
 =?utf-8?B?aGRvQklPa1JSejhrSzFHc0tBZldZa3p0NXcwbTVYTWl0eGJsOWNwQlRNSVJM?=
 =?utf-8?B?TkRMYSsycHNlbDdRam5jSnFoNEIzT2hickhQWEVhM0ttRHZOczBUNDBLV1V3?=
 =?utf-8?B?Y3JMNGduanhlbC9ncWtRUWJnem9YZW1SZzdIN3dtUlFZNHFsd2FWZDZ6N2hQ?=
 =?utf-8?B?SktrU24wd1dwcUpwZnpSbThWektTc1ZmdXpUMzQ5VVFBTEhGVGxrOVVqOWI2?=
 =?utf-8?B?TnhFQVRLRnJieHVma0R1ckNLcTIwMjVFWkpYRjFPWVVPcnphYTFvQXpGRndN?=
 =?utf-8?B?dzBMUWtSTVA1b3NyR1JMWW81QVM2Qmc5YkJQQU9OUjcyU3JhNXlNaER1aDRL?=
 =?utf-8?B?U3BvU0dGWHU2SEt5N0hIdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVVWN2R3bXhnRHkxR1puS2hkMUtRTHl5T2lYSlBaT3JGSGp1TEh4emt1a3Rt?=
 =?utf-8?B?aktmY05nSEdjVFBYQnlDcnM2ZnRzcDF2WkIwejhjYVZ1NEVWVWhiZUhUenZq?=
 =?utf-8?B?UlVFcmw0WDFkVlFxSHp5V09zc3VLeXhTQVM2UzdoWXZaSWpUSHRUa213bHN0?=
 =?utf-8?B?dXBsQkw4ZFhpbTB0S3RvS1h3R1N2VGJpa1hmSWk2aCsrVzdzWFFvTkx4c2Mr?=
 =?utf-8?B?ZGp2cE54dE1YUGZ3U0pVVVJvN0IxcDFEdTFvUnB6cHlxdTVCb0VuQzBSZVRa?=
 =?utf-8?B?NC9GS2F4RTRiMDQvdG01ajB3TmZHSG5LMHdaa3B4UmNMOHhaZGpOeWF1MFIw?=
 =?utf-8?B?aS9SeWd1SUNGZGZFTEFWbWsrcm10bHlsWGxMcjlGaUVGQkxESm5MeVIxa0E1?=
 =?utf-8?B?K0NTSHlLWlJoeDJPMFJuaDd1L2hTb2NCL2J2eWpsQUd1dExEendYSklPUjNH?=
 =?utf-8?B?WWlXdEFCUXVrNnRYY2xST0VPZXkrQ3hYMWxDZkF4R05QelJOUGkvL29PWTRX?=
 =?utf-8?B?WHUrajBFMW5aY3RrakdZUEd5bGE1YVppNFZPUlEySFkwZ2Y5WlB4MTJ1eHEv?=
 =?utf-8?B?WXJ6WmdEdGx6UkpwVk13elFrY2VENEFTRzBBdmh1TjNuZkhENElRREJsRWFR?=
 =?utf-8?B?MDVsZitzWUVRODV3TkhYd2ZNWGppSEdVNUlFSTVwS3piWGQrN3Z0QmFYWXRE?=
 =?utf-8?B?V3Z0YTNWWm1vTkxXbVZiU25RNU8ySVRPTHJLMmg5bnl1WTZnT2I0c3BBL3lZ?=
 =?utf-8?B?aHd3eGFmcUNibGN4eUFqN0pnck1HNnlUajlnMXpFU2pCUTF6eC9ubER2NEx0?=
 =?utf-8?B?dDE4a29SY3JWalNjM3cyOFE4K0FVMTg5MUxlRm1IU2U0Ty9oRHhHWUh3ekM5?=
 =?utf-8?B?REthNk9NZTUxcThiWDVVUXZ6c3JpVmZCanVZSDhiZ25xaFJvcmVqbjRPTUdM?=
 =?utf-8?B?TG9LbDhzd0c4T3FtWG5tdGc1dldENjBnWTIzQUhFY2VlWHhNK0ZqUFRqTHlu?=
 =?utf-8?B?MWkveWp0UTI3cndvd3gwSlpXa1JQZ0VESnQwSDVmdlhqcFFBVnpXQnlpcS9q?=
 =?utf-8?B?UWZqdytScU1tdnZzYkdXdWdaWnFSaGtUb0daa3BKTzlLR3dJeFhmWE43VjUr?=
 =?utf-8?B?UkZqY25WQmVtdS9EYnJ0dEFSRTR1cUg4bFZ4Y0tmUHoyOFdGbjRoK1pLQjNS?=
 =?utf-8?B?bGpNc0hzZGxiMFRxZEZrWW1MZ1kraEQrRkdHOEMrbTRscDhFQVZrSzhJVnlp?=
 =?utf-8?B?cnFGOFVkc1ZwUXBrYlZBcFM1UWxWQnowdS91Z3JnajBEaXpYeTdVRVVXSSto?=
 =?utf-8?B?dGZCREVnUTlGNnVIYXJzT2duckhZcm5DRHpuczRFdVpML1lZMnlWZE5RTEJM?=
 =?utf-8?B?TGRPOXE4SWFRcDUrUEpRbitYYjFub0h3YlBrVnN3U1A4UkJUb1dvVkUzS21n?=
 =?utf-8?B?N2FsV1dOL1Y0cGdIdDA5SjFtTE9VU2k1RFpJd05KYThTWmNSRDJmTzNyNkhn?=
 =?utf-8?B?NG91NnoyOHo4NXI1S0pZUzg2N2YzcGd2ZzZ0ZzBaeDdQMnovejR1WWtBUmdH?=
 =?utf-8?B?b2tBMUJldGxoZzgvd1MxMk5aeWFQWVFmS25KaHFDN1loTkZkSVZIcHRhZUNm?=
 =?utf-8?B?K0Jpdy91L0Z3MGF2cVJIM0hTaVpFWXg0ZlV0UkFyNjJtOGltUGhyMTM1ZnI0?=
 =?utf-8?B?REN2blJnRzRtOGNLRzlhTE9tTEpieVVmRm1Jb1Zndm9iK3V2QmVIZUlyR3BN?=
 =?utf-8?B?UnVBUDZrMlpCNmRWSzdHdTN2ZkszQ0FLS0FwVDJFMUkxa2wxcG1WVFNnUlEv?=
 =?utf-8?B?cjlnWkhycEFDeHViTGJjK21ZelZMVkZhZS9ETW1vMVMwdlViQjByQUFjSFNx?=
 =?utf-8?B?TXIvNjBpQWNuRjFxcytXMnBGSlJVZnpaWEo0c3NZSGVtK2FibTVObGQybXRG?=
 =?utf-8?B?LzRpVWZQcjd0SFdxTTQ1VjB4ZFBReEwrYXFrdkFPNWY0cFdFaG85ejA0VEpU?=
 =?utf-8?B?S3ZVeWdpVmZiWGR4OGovakY2YVhzNzNYbXhhTHpFRXB0NUNTTG15V3VqdkdN?=
 =?utf-8?B?N1JjZzh4NkVqUkx2SVEvVG1SMUN0ZDZ4RUdaVnBHcjBLV1NzNjdHdDVCOENn?=
 =?utf-8?Q?PPMU1HwXrI2J0qN1pmlObG1bS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb0ad89-05d4-4365-91a8-08dd0f9827f2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 10:33:53.8255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+NYtSMhSc+AcipfhqyL66IRiKLLAJ5lu8QNcglx2kH80MGBpinaZwm340MZr1JV8OZRIZLsXj/NjubOYokQNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8284
Received-SPF: softfail client-ip=2a01:111:f403:2416::629;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


On 17/11/2024 21:20, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Since device state transfer via multifd channels requires multifd
> channels with packets and is currently not compatible with multifd
> compression add an appropriate query function so device can learn
> whether it can actually make use of it.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   include/migration/misc.h         | 1 +
>   migration/multifd-device-state.c | 7 +++++++
>   2 files changed, 8 insertions(+)
>
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 118e205bbcc6..43558d9198f7 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -112,5 +112,6 @@ bool migration_in_bg_snapshot(void);
>   /* migration/multifd-device-state.c */
>   bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
>                                   char *data, size_t len);
> +bool migration_has_device_state_support(void);

Nit: maybe rename to multifd_device_state_supported or 
migration_multifd_device_state_supported, as it's specifically related 
to multifd?

Thanks.

>
>   #endif
> diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
> index 8cf5a6c2668c..bcbea926b6be 100644
> --- a/migration/multifd-device-state.c
> +++ b/migration/multifd-device-state.c
> @@ -11,6 +11,7 @@
>   #include "qemu/lockable.h"
>   #include "migration/misc.h"
>   #include "multifd.h"
> +#include "options.h"
>
>   static QemuMutex queue_job_mutex;
>
> @@ -99,3 +100,9 @@ bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
>
>       return true;
>   }
> +
> +bool migration_has_device_state_support(void)
> +{
> +    return migrate_multifd() && !migrate_mapped_ram() &&
> +        migrate_multifd_compression() == MULTIFD_COMPRESSION_NONE;
> +}

