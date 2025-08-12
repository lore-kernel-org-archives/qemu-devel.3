Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC51C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 14:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulplY-0003dw-Ea; Tue, 12 Aug 2025 10:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1ulplV-0003d4-Ju
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 10:14:13 -0400
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com
 ([40.107.92.68] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1ulplL-0000xR-RK
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 10:14:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ngy0Uk+un/9tAfTqftf9hkySc/dP/AYmO5d0JfK5SwBZDIpML0AWJvq8hDrzPTixtbfUHdWJ8A6qHo/J76x8/JRmB9PyqVzljtLu1YpF3/MQgCEzlIT9/2UTyMZBgOj3MxcaygngfNmvkfl6Azt1jrAmoa2kMCd5rrxQVZwbKZpGmUlVqh1kLrM+BwvBxuNNC8F/9D6VlEKbGfU0cij7FmsvVbYTfzEZGJjOeyrpkIzWpriq2KEckl62ybWFGN+ZejaPK6OpDJ+xOh9+zSjRH6zQHlaKCOAdv1ou2g5vtE4lkqIOWXvw6/YVGupOdwmoVfwfjsi2tkgARd19iVRRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNEPCo4XypqQoX1mganJlqsJW+naLgRX0Bc4o6CjYK4=;
 b=EASSGcNyZ5vYGcsB2TDJHNBCY2tdqf0KtuPOe1ObpB4LGRsAl4g7xuU59Y6Xq1xG906eOdtG0m9W+lb8utJPMr+i8sfaCgGhmPyh8YMkCSdJ4Bv9YgIQSSpceqV8qvCSSjyahugkKV5aTAygSw96fvx3xVif6A8648Js0PGp9L/H1gFH1lbQn2DKp+BKHjyjvVHNw2lCNO0QNgjeVsmI9nr6GpmfUxKFCCZM2fgSpqfA9tq4Be463ySLOs2vXXN57Ny48b6D+wWFHanP6LI7S1n3luxULPkr0p8OcRqNer2B7IE7Gq/OMIHxSnEtc2TUu9VyQdcVSYLNKqvZaWcbpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNEPCo4XypqQoX1mganJlqsJW+naLgRX0Bc4o6CjYK4=;
 b=aLdl4GEnRkn4WdPubL8wyTbPmTZAmKXIkmXm5MFgUtK6VDileAT4Nc6Y09cGPpWC+GILg4Nym+1nyig3d17xW/xhf/vz/56hQkpmwEhgkoUflLlLLqLTxEXzvaFKeqykPHuvuMji16IKgk5kVHp7u3RXb40u3sSivdE+gvB0/O5hdIVGaT+mViB9I+FMEAsNpJVgicyXl64dI+F+dZO7Ew5c3SzSK5TDx3fn+dE94a85SPnulbb9aqFTVuLk3lJGzSiZpnGoz/1G+cgILQTjiQvLvIie/R6umCHNeULMoas7H9QNBj/HYMizubwKTcfYs0Bo+GUfcMTGO4A+KpWp8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 14:08:51 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 14:08:51 +0000
Message-ID: <506cab2c-35aa-4c68-ba94-b26ba1b315bc@nvidia.com>
Date: Tue, 12 Aug 2025 17:08:46 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] VFIO migration will not be aborted in a corner scenario
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Kunkun Jiang <jiangkunkun@huawei.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 wanghaibin.wang@huawei.com, Zenghui Yu <yuzenghui@huawei.com>
References: <6f64724d-7869-1283-bb75-193c7fba5576@huawei.com>
 <f6c1cff4-a0ca-436a-b8d7-3d19ce49e848@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <f6c1cff4-a0ca-436a-b8d7-3d19ce49e848@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 4deaaad6-3ccd-4f02-4203-08ddd9a9c348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzdDait3UkN3OXB6YVN2bG80dzdGSElzc1FCK0F2K3lDRVNWcmZVNytLUzBU?=
 =?utf-8?B?K1czRHZ5cjBrY0laYWdMSG4xMm93ei9senY0VXQrU2p3Z0hRYTkrT3RHdzhG?=
 =?utf-8?B?eElsN0NzMGpONGY1Nm5sYWtiaUt6VzJZeUpoT2ZXVU02eUdKcUxZaXlyRWQv?=
 =?utf-8?B?RnhuQWNrKytZczI3Y0s2WmY1Y2N0K0RtUjYwRTJQdzR2LzRHYkJUMUQyaGs3?=
 =?utf-8?B?M2JOT0ZLNTVIaW52YWF3UXd3c1FPNVVVU1B4cTFYUVhkbFNZRVJHcndSNWxI?=
 =?utf-8?B?NTJEUGlHR0hvbWZ0L1d1bWhObFRtdk0yZGI0ME83N1lqakhCZkJSSk5vSzVL?=
 =?utf-8?B?VCs4enNFcDhPRGdLNUlVOXI5QUF0c2FsZmZlK3UwZk5FOCtha1lsTHNxVkYv?=
 =?utf-8?B?K0htTzF1TngxZTZHbWptZ1ZWdExIdmZuVDFsUkpXb2tFY2JjVUYvTzFBK0wy?=
 =?utf-8?B?bGczeXFVS09HeWlXNnVvUHhKbkNRVVhkL2tIM0ZFNDF2WkNIV3k4NEpKZ05C?=
 =?utf-8?B?QXFlUmY2Wlp3RERSQ2NmcnRQMWlvVzYwaWVxM09wMmJnc2g0VFlyUVlvSm5Q?=
 =?utf-8?B?NEVScy9kSEZoS0gwTHBrNE53MUVyMXk2L0Z1ek9nS211ckVSZlZpZFNNN2ZW?=
 =?utf-8?B?Y2Voa0RLOVVoUDNsdnVMczdXN2Q3WFpadTJDR21zZmVqQ2RteS9yL2VKRzJZ?=
 =?utf-8?B?Q2YxcnQvK2hmejYwZ1Izams4M0tMN1publB6dTFRcGsrc2EvSzNEQVZGdUhp?=
 =?utf-8?B?b3E3c29iM0tJNnN5ek5XdmhlOUFHRnBIT2RKMExOSVJscUIrWXJib1dvRUl5?=
 =?utf-8?B?dUFnV1FQOEJPdkNSTnlIZG5WVGZQN3NQYTVMMUgvR0Y3Y2RlSFluMU1ZTFpo?=
 =?utf-8?B?bTFNRDVIRURXZDRtZFAwWGVUK0JYbmZNTHJwOUNlK0ZGTmY3ZFVGb0xMdGNV?=
 =?utf-8?B?SUtuVzYrMzJVS1kxRUVKY2ZZRWRwNFZPYk9aTzQ3azVBaVNMQWNucUovMnhH?=
 =?utf-8?B?bnRNdmh2UG81UEpMVGtmSHQrMjJEY3FmYWQ3NVRBVDZWOU1lSm1VcDN6bTlx?=
 =?utf-8?B?SHNwV2k1ZHFNamhqeWNOc3M3RDlKUmNidVZYL3QvRkR5cWpXdmNpWVNYWElV?=
 =?utf-8?B?MXF6QXJpalNzZFdxUCt4TmNDMlFXM3lxUGxTSWdIOWtSem05VnpHOUkva3pG?=
 =?utf-8?B?NzhBZ2NYeHM0R0F1OFNxeG5BeXNzT3JaYTFCNFNpU04wRERDRXZsQXBRd0Fh?=
 =?utf-8?B?UVZDcEZHRWZOcW1ySDV3SXVieW1NSGVyZkxTL1Y5aTZhZW0vSUpqam5rcnZP?=
 =?utf-8?B?K2Y0MUdldHNEWWt1U1JqV2U2VlF5emRDelZVZGNPQVgrTEFzUGhZSitxc0p0?=
 =?utf-8?B?OVA3QW51OEl4S2pLZ2Y0MWFva2gzSG11L00xdjh5RXdpOTloL0h4NUY0bXhy?=
 =?utf-8?B?cVdHRTZNNlN4THNlUmJ2T252Y2RZRU5qdzZ4YXdFeGR5RlN4aFo4TnErbXl6?=
 =?utf-8?B?V2tLSGtBWWhEeml3MThqL25KM3ZjY2k2SEpLVjV0V0tKV2Q0QTl1WEt2TE5v?=
 =?utf-8?B?bDNobmFJNzdhZzVBVlZYMGJwZWdEbkNKZGlkOXdCTC9jUDNVS2VpMDEvTHVD?=
 =?utf-8?B?YnIwOEwwL2N4eDdUKzl4Q055UGdpY000aGRHT2JaRGtlRUxKcG1aT0JuS3R6?=
 =?utf-8?B?QU1TWjQ5R244ank2RmNJZmJxYTErS015YTVvMWRGV2pOSXBYbDZNc1RzNmRO?=
 =?utf-8?B?QUlUVlh2alZqTkJIY0pFWnZtTEpuaFgrYzJZd1dONnlGQXVPcTdBMytWTWdK?=
 =?utf-8?Q?GLHbg8bDrbf0r9hiwzt/SMsjkaxiTp50hUTI4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGFRenBpdHRYalprbWFuS09FQlhEd2lSNjJERHpSczYyblFSY0N4K2lnbUs0?=
 =?utf-8?B?TnJFNzFNTDJ1WmU4TE1sYkxtbWt2MGdibTY4dFN4bnI3UEZGWTA5NkxSMVBi?=
 =?utf-8?B?ZUFHZmNrWi9BTjRhVXFVNWJtaEhSTGNQTHNhOEVua1cyVStJZVVxMU1pME9K?=
 =?utf-8?B?QzErZlh4c2c3TytyRVJVTmJmTVFOblBKMnZyYzQwK1pMNUV0alljMzJBT2p5?=
 =?utf-8?B?UzBOK3BHMk9jWHlQdVBqY3ZQQmNodmJFZzNDUE9KQytZZTR4eUN1a3NJZDh6?=
 =?utf-8?B?ZDArdks1anJ4OVMzUnEwOVBOM3RwOGlubTRHNG9FMVB1LzI2OG5Mc1Q5Ulhk?=
 =?utf-8?B?M2gzdmgvdTQzQWF2MnBXQzRYa2ZPb0Z0WDFxeWZVMEFWSGRTZTdZdUZPV2F1?=
 =?utf-8?B?b0JKM3FvQTlMMC9IMGpGVUFvb2kyN0VXR0dyMjdra01YdGFpN2tUVUVnKzl0?=
 =?utf-8?B?eVVtU0VIWTl6ajdSNklUQTkzODl6UVNNL1ZTMUpzbXNtdG9zZzlBWEcvVGVE?=
 =?utf-8?B?M0RENjBSOS8ycnVTS2JseTk3MnUzdFBvNUQ0MFZKR24vMGVaQ2FzbkFqdjRi?=
 =?utf-8?B?Qnk4SGl4T05jYWxhQ1BqdUFhZm50RXNBSUdqTTg0NzlEK0tCbllMbmN6TW9D?=
 =?utf-8?B?aTkvcEpnYy9RUEtVclo0R09DVWpjandqdmttUE1KbTNDK3E2TzRhZTF4dzhC?=
 =?utf-8?B?ZXpaVHFGUkVhNzZmYWN5Tmw4cE1qV0Z5aC9BWjc4TEJqYjd4eTR0ZWRkUmR0?=
 =?utf-8?B?dDJLZU0xSWxkdk1UL3FoMnpZaVhZRDlZU1FidGxEbmNBa3htbCtOVEJQY05l?=
 =?utf-8?B?TTN0TE5CM0hVWHVOazRHZGY2T3Z1ZXdhbVBhTWw0Q0pjZU5hRGdRQ1VFcmFT?=
 =?utf-8?B?eXFGZFU3b2ozT2NaMEM5ZW5uaS9aVlJnbllQTFBwU3VvL1hFT1R3YVg0VmRP?=
 =?utf-8?B?aG1pRGtJQ1lNZVFyUURLeTAvekxQL3orQ0VId2NkdWowWlRzSUFBL2VuakF6?=
 =?utf-8?B?KzF6U0FkdGFyNUtacURmYkx4cEFrTUl4Nk9VYkpoTHEzWW1EQk0rZHVPam5w?=
 =?utf-8?B?MXdjRWZuMVhqdzFqTktabS9OVzlRLzJXVmxVQzJUZDZCdURmMjgrSnlTRUpx?=
 =?utf-8?B?OG5GYVBTQ0dFVFdyeTgyT0FwOW04N1JUME0wYURIQnVkMTNUWUhtZmZiM0tC?=
 =?utf-8?B?MEowdW9raG5hL1pwZ3FPSytMbXNIbTdzRWlaR2E4QmZBeTRNSHExTVpHV3BY?=
 =?utf-8?B?L2NlVkVIeit0WkcxNndHMG5sK1E2ZkVVblBDZDNkaXgvYmo2anB1YW1mTG5V?=
 =?utf-8?B?NWh5WUxtSWZTMDBtSm1uRWRWRVNiQk5BOUk5QWVxeXdqbDk4aG1VSTFQazZs?=
 =?utf-8?B?VmVhTUp0eURGUnlnY2VCbDVpcjVnVU5IS3BBMHVrK0Q4VXlOU3ovOXgwSkMv?=
 =?utf-8?B?RnFONXRVVk4wQk5UWE4yYWhRUU9CQlhOR3FHSFRWQW55dS81QURZcWg4ckZO?=
 =?utf-8?B?aERreThSUEhXZG11QTU1Y1VKNTJTQU0ySU1sUVhjQU1rN0hLZ0VzREZNMlRw?=
 =?utf-8?B?cHZqcGpvdE95enV4VTZFRDFBS0JKbXVNZGx3WFo3TitnbWhBcW9XbWorTW8z?=
 =?utf-8?B?OHI0eGw5Qk5ZS2Rnc0hCWjJvRC9QY1Mya3RHZlVaR2NZcmJ5eVMxK2diVnlo?=
 =?utf-8?B?Q0I3ZFRabUttaGF0Q2dsaWQ3NmREQXdwNkc3d2JWcmVsRUNRZktQdnMyR1Br?=
 =?utf-8?B?SXRVVldLLzBCYkFiVmc2Snl1eko5OXRPVVEyMnlQOEpNUXBWVytPTktxWWRV?=
 =?utf-8?B?ME82R3oyY2EvWDcybjg5YVlUa3lESjAyN1VuWVFNTlFoUlhzY2dLeWs2S2VI?=
 =?utf-8?B?K0RNN0lwVkZZcUlXWEJGd0ZWM3ozemN2Ri9xSUx4aFZZTXpsUTJiOWtwZG13?=
 =?utf-8?B?V3J5Z3p5VVRpZnVSRHIrcXJGaEhPTmNPcjh5elpuWUdPNkpGdjU5byt4OGN2?=
 =?utf-8?B?WHIzREV4S0hIeTV3bjlSeUxDalJBZER5MkxLL09DUGtCWm91SmFnWkxZeDhX?=
 =?utf-8?B?WVZrNmhtSUI4cW1VMnhHNkh0ckRsOUdpSUN4Ym9zT3FrS0NNbC8wRW5aOFVB?=
 =?utf-8?Q?cWbQOw3yzmhDLJaNKsaCyHtG4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4deaaad6-3ccd-4f02-4203-08ddd9a9c348
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 14:08:50.8659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPqKCbK7D3hmGreDfr4fKO3x9C2bdITAd6uPSJp/xTK8/hcSxb8EhKzcQJQI5C3wvYyEkxa9fLL2rDX53vV3yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507
Received-SPF: permerror client-ip=40.107.92.68;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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


On 11/08/2025 19:34, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Hello,
>
> + Avihai
>
> On 8/11/25 18:02, Kunkun Jiang wrote:
>> Hi all,
>>
>> While testing VFIO migration, I encountered an corner scenario case:
>> VFIO migration will not be aborted when the vfio device of dst-vm 
>> fails to transition from RESUMING to RUNNING state in 
>> vfio_vmstate_change.
>>
>> I saw the comments in the vfio_vmstate_change but I don't understand 
>> why no action is taken for this situation.
>
> There is error handling in vfio_vmstate_change() :
>
>         /*
>          * Migration should be aborted in this case, but 
> vm_state_notify()
>          * currently does not support reporting failures.
>          */
>         migration_file_set_error(ret, local_err);

Hmm, I think this only sets the error on src. On dst we don't have 
MigrationState->to_dst_file, so we end up just reporting the error.
But even if we did set it, no one is checking if there is a migration 
error after vm_start() is called in process_incoming_migration_bh().

>
>> Allowing the live migration process to continue could cause 
>> unrecoverable damage to the VM.

What do you mean by unrecoverable damage to the VM?
If RESUMING->RUNNING transition fails, would a VFIO reset recover the 
device and allow the VM to continue operation with damage limited only 
to the VFIO device?

>> In this case, can we directly exit the dst-vm? Through the 
>> return-path mechanism, the src-vm can continue to run.
>>
>> Looking forward to your reply.
>
The straightforward solution, as you suggested, is to exit dst upon 
error in RESUMING->RUNNING transition and notify about it to src through 
the return-path.
However, I am not sure if failing the migration after vm_start() on dst 
is a bit late (as we start vCPUs and do migration_block_activate, etc.).

But I can think of another way to solve this, hopefully simpler.
According to VFIO migration uAPI [1]:
  * RESUMING -> STOP
  *   Leaving RESUMING terminates a data transfer session and indicates the
  *   device should complete processing of the data delivered by 
write(). The
  *   kernel migration driver should complete the incorporation of data 
written
  *   to the data transfer FD into the device internal state and perform
  *   final validity and consistency checking of the new device state. 
If the
  *   user provided data is found to be incomplete, inconsistent, or 
otherwise
  *   invalid, the migration driver must fail the SET_STATE ioctl and
  *   optionally go to the ERROR state as described below.

So, IIUC, we can add an explicit RESUMING->STOP transition [2] after the 
device config is loaded (which is the last data the device is expected 
to receive).
If this transition fails, it means something was wrong with migration, 
and we can send src an error msg via return-path (and not continue to 
vm_start()).

Maybe this approach is less complicated than the first one, and it will 
also work if src VM was paused prior migration.
I already tested some POC and it seems to be working (at least with an 
artificial error i injected in RESUMING->STOP transition).
Kunkun, can you apply the following diff [3] and check if this solves 
the issue?

And in general, what do you think? Should we go with this approach or do 
you have other ideas?

Thanks.

[1] 
https://elixir.bootlin.com/linux/v6.16/source/include/uapi/linux/vfio.h#L1099
[2] Today RESUMING->STOP is done implicitly by the VFIO driver as part 
of RESUMING->RUNNING transition.
[3]

diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index e4785031a7..66f8461f02 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -267,6 +267,12 @@ static bool 
vfio_load_bufs_thread_load_config(VFIODevice *vbasedev,
      ret = vfio_load_device_config_state(f_in, vbasedev);
      bql_unlock();

+    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP,
+                                   VFIO_DEVICE_STATE_ERROR, errp);
+    if (ret) {
+        return false;
+    }
+
      if (ret < 0) {
          error_setg(errp, "%s: vfio_load_device_config_state() failed: %d",
                     vbasedev->name, ret);

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 4c06e3db93..a707d17a5b 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -737,6 +737,8 @@ static int vfio_load_state(QEMUFile *f, void 
*opaque, int version_id)
          switch (data) {
          case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
          {
+            Error *local_err = NULL;
+
              if (vfio_multifd_transfer_enabled(vbasedev)) {
                  error_report("%s: got DEV_CONFIG_STATE in main migration "
                               "channel but doing multifd transfer",
@@ -744,7 +746,19 @@ static int vfio_load_state(QEMUFile *f, void 
*opaque, int version_id)
                  return -EINVAL;
              }

-            return vfio_load_device_config_state(f, opaque);
+            ret = vfio_load_device_config_state(f, opaque);
+            if (ret) {
+                return ret;
+            }
+
+            ret = vfio_migration_set_state_or_reset(
+                vbasedev, VFIO_DEVICE_STATE_STOP, &local_err);
+            if (ret) {
+                error_report_err(local_err);
+                return ret;
+            }
+
+            return 0;
          }
          case VFIO_MIG_FLAG_DEV_SETUP_STATE:
          {

diff --git a/migration/migration.c b/migration/migration.c
index 10c216d25d..fd498c864d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -91,6 +91,7 @@ enum mig_rp_message_type {
      MIG_RP_MSG_RECV_BITMAP,  /* send recved_bitmap back to source */
      MIG_RP_MSG_RESUME_ACK,   /* tell source that we are ready to resume */
      MIG_RP_MSG_SWITCHOVER_ACK, /* Tell source it's OK to do switchover */
+    MIG_RP_MSG_ERROR, /* Tell source that destination encountered an 
error */

      MIG_RP_MSG_MAX
  };
@@ -884,6 +885,11 @@ process_incoming_migration_co(void *opaque)
      ret = qemu_loadvm_state(mis->from_src_file);
      mis->loadvm_co = NULL;

+    if (ret) {
+        migrate_send_rp_error(mis);
+        error_report("SENT RP ERROR");
+    }
+
  trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");

      ps = postcopy_state_get();
@@ -1126,6 +1132,11 @@ bool migration_has_all_channels(void)
      return true;
  }
+int migrate_send_rp_error(MigrationIncomingState *mis)
+{
+    return migrate_send_rp_message(mis, MIG_RP_MSG_ERROR, 0, NULL);
+}
+
  int migrate_send_rp_switchover_ack(MigrationIncomingState *mis)
  {
      return migrate_send_rp_message(mis, MIG_RP_MSG_SWITCHOVER_ACK, 0, 
NULL);
@@ -2614,6 +2625,10 @@ static void *source_return_path_thread(void *opaque)
              trace_source_return_path_thread_switchover_acked();
              break;

+        case MIG_RP_MSG_ERROR:
+            error_setg(&err, "DST indicated error");
+            goto out;
+
          default:
              break;
          }
diff --git a/migration/migration.h b/migration/migration.h
index 01329bf824..f11ff7a199 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -553,6 +553,7 @@ void 
migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
                                   char *block_name);
  void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t 
value);
  int migrate_send_rp_switchover_ack(MigrationIncomingState *mis);
+int migrate_send_rp_error(MigrationIncomingState *mis);

  void dirty_bitmap_mig_before_vm_start(void);
  void dirty_bitmap_mig_cancel_outgoing(void);

> I suggest you open an issue on :
>
>   https://gitlab.com/qemu-project/qemu/-/issues/
>
> with a detailed description of your environment :
>
>   Host HW, Host OS, QEMU version, QEMU command line, Guest OS, etc.
>
> A template is provided when a new issue is created.
>
>
> Thanks,
>
> C.
>
>
>

