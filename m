Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C61FC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 14:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuu3V-0008J5-Uh; Wed, 19 Mar 2025 10:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tuu3P-0008ID-RR
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:05:58 -0400
Received: from mail-bn7nam10on20612.outbound.protection.outlook.com
 ([2a01:111:f403:2009::612]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tuu3H-0005gS-Gn
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:05:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRY1BguwuhzCpvXDmfvHXkj39AsAYs0GsusLp+fbc8LFZrpDfUWjrjV6MrPZkjVeoCKwAXexVSHKMk5/z0fyM6P2tRpkBwivwqgC0Jhi77f8NTw14GeZT7qQ76EiE01bSkhzDsHlpvCbOQifMymWwAJuMAnj6Yaf7HgrxBpvgP0iLwKoYBhFoqYEpj9coKQi/d2ly35iLmMx6gNfDt6VG7/ltgeoc2s4u67fbBTzBb5OVoJHvbey8+mgc7sTDBu8GJV7f/6hfmVTkq/6uBquPJQkURNu+xXxjmMqxKKnsvpwNmNV4hszTlnyHrtvKLyTeMuWNTXlsDx0bxBn8A7Xlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFK73yZHxIIcXH7P3ZNI3BBX9m+pE4+PvvlgRc1SVps=;
 b=qLdFhtp1boKS9Qown2bSK/merMvWcD6R3CeCImUsoB4BM+no3fUE48N8/6eLGfu8NmTAWWRO4NJUioogKuwJNoAN1uLjx5NoIUj/U0Kn+k6EJkMxWUcg6BwVR/4fKfFAtIhxlBGheI1/Gh0dpcfYYrrR0WWN7FKwHU97maRqAwaSGWh8tgiLjSrMcVHFT1s1flPym3/MKse5Ve6fHJ72CXHgmnAMLKiFCP7yD+9RwYlMPXR+1fqxUed9j0qrd1qDInT92EEeeYx9r5WFIj9WDpAm0AisqSwUH5BUEhNeP5x9/ZuRBuDW/S/Xxaf9bIqUP7RsbSrOLekEW/+ENfUPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFK73yZHxIIcXH7P3ZNI3BBX9m+pE4+PvvlgRc1SVps=;
 b=lEqkMOdIYjCRxSW8vAGbUW21osl3HMnfPx6vmBJlYprrCvuYkNOCjToOYQBZXDRdyk0AKwfXwgtemxEvzb6NDegC+9vl6wxrMBxDk2Irc/fzlysjeGsq3JimvDP/5YSMr2SjYv//Vb9a2v3ddbVg6z3AMopHmLClCJ4eav88AoBGz5cqjVdoEh+lzRCP7iA8g1sZ1aui64jDN3zx18QTJcHExrdgoCxOa5O0/D8LHvu8oy5qqP37Sfg8gS3Y3NTHnTyUn6eWstgwN7EM7xoYwYMs9l4EEo2fAEiOf3XNP+TTZDa79CwTsOOwIj607T8p3YsZzBn+oUsRm5I9QoAxwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SA5PPF0EB7D076B.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 14:05:40 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 14:05:40 +0000
Message-ID: <cb0ad36a-8a3f-4385-8bd7-83abd0901c4d@nvidia.com>
Date: Wed, 19 Mar 2025 16:05:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 06/32] vfio: Introduce a new header file for
 internal migration services
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-7-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20250318095415.670319-7-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0320.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::13) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SA5PPF0EB7D076B:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c05db64-09e8-433b-5a25-08dd66ef2135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZThjTmliMmg4bGVWUWZhVE5DZFRsSklqczhVTm1BMXVzc3dqOVBUbi9NUW9s?=
 =?utf-8?B?WGtrNVluWjJvSmFtbGdDTWVKRU0vbmNCTWZWcWVyNzd0SGdzSUUyWU9MNmRP?=
 =?utf-8?B?VC93SW5ibm1uS2tYOUJtcEpBUktEbUh6V3QrSWs5ZnR3NG1WdjB3b3dVRlNr?=
 =?utf-8?B?VS9JQm1NdFZ6bDZJUzhuOE9FNjlvMkh2cHlwb3lvek1LWXRML005ckdDNkwx?=
 =?utf-8?B?U0Z4Q29yLzdNVzdMc1Z1Y3hVUVVzZmtIVmUrajlnVEJHWG9oNjRWRU9uNXE1?=
 =?utf-8?B?UmxTNWhJWDZydWZHc0pKU1I5SWxnK0x1WGtTbU1ldWRoeXJGcitnY3NEMWE3?=
 =?utf-8?B?REQ4Ny9ubjBoaTUyRklqWTJyak81YWtiaVRFK0sxRFl3QU92SklOL09aMmVG?=
 =?utf-8?B?QVNHcGFHTXBDWkNrdFh6NWl2RGFmM1pqaVFKWVBZbC9Lak1UV2dqdm1QOE10?=
 =?utf-8?B?WEo2UzVQMlkvV1YyQ013TThjbXpXeTg2SThKL0o3VC9vOEF4K0RKZGsxcjQz?=
 =?utf-8?B?Nlh4WXNoVUR4QUhRZUxhRjdEY1F6S0hoTXZIR0wycHpsWVZCSDJKeFJZMkxO?=
 =?utf-8?B?MnlnbC8zMzN3NEY1TVJ5c2V6VFFiT3Bic1ZXbkVVRmRXZk0rcGFxWnhFVXF6?=
 =?utf-8?B?N3kvNEs3UThjSVpJam8rQWpjWXFPZnpNM0VUWFhGdEtBdngvL1Z5RXhyMGxs?=
 =?utf-8?B?cGJFSzhVWjRKaDRiREM5N2EvZnJ1ZHorN2t6YkJzNzRWUk41VW1yQ3JFd0ZE?=
 =?utf-8?B?S3YrRVc3S2FHamFoZkJUV2gwV0t0TFpJa25IZFR0YmZMaTNFWkxqTEpxbThh?=
 =?utf-8?B?cm5Fc0g2TTRaWmtsdDJFNVRBY04rOUFsSVBlSWFFWjhpRDBwN2xCYzFkU21D?=
 =?utf-8?B?aTBhZmx3N2k0YSt6N2lwWFF4WW1naFVwSkpGTW5hVlFORXdHaklhQkE0Z0pU?=
 =?utf-8?B?NDgrVnBXemJKdXB6a1ZKUDBua29xZGN6dVVSdjlyc2lLYWY0am13bENWZXd3?=
 =?utf-8?B?dGF0Rmtya0FMUmJnZUIrSjIrdVFEQXM3ZmI0WHZ0WXBmMm9CVy9zQ3djejFH?=
 =?utf-8?B?R2x0WEFMdGRkaUdQeVg2dTQzUnBwUUcxVXY4Q2lhWTRkS3JITitSbkdnNTlE?=
 =?utf-8?B?SXJ0MUFjdnpjM1NqdTNMeUJCNGRlNHNheXUyOU5LcnFQaUk4emNJN2ZnZDlC?=
 =?utf-8?B?RW01UmVpL0xDUmNiQmlHbXZ4TEoyZnNHdWU0eUVFYjB4WkJPYjkvQ1BkZGJk?=
 =?utf-8?B?MXVJVVpLbmg1aHF4THhnU2xQMjl4d0tXdllXR1lXM2VieWx4Mlhnb25ESFh2?=
 =?utf-8?B?TFR1TCs1cGRRL1E5OTVsMXNycnVXemZSbUdFOFhPUzBBckQrVURWVlpKQ0lp?=
 =?utf-8?B?UFFqeDNrQ1c4L2FyZ2FZaWhLci9VZlRnRnNBYzNuQ3NtL1pCb2hWOTUzS1NZ?=
 =?utf-8?B?cmwwWmhVRnRkTm9RZmFWZ3BicEFybFBMVHAvKzNqYkl0UWRzd2gvZlVTb0hD?=
 =?utf-8?B?R24vYk5zd0g0OEhwa3Y0Rlh2OEVzUEhRMFUzT213U3lJd3V0Z283RlVpdlJ5?=
 =?utf-8?B?dzVhdys0QXBEM3ZINkhzcWl0YUNzQ3NVRG1iSzVtcEswbUd6TktMbFNZS3NP?=
 =?utf-8?B?dDVaN0JBYXRac0k3Q0xhVU4xSjAxZXN1SS8wUVBTcFZIMW5HQWwvV0hrZVg4?=
 =?utf-8?B?YlFXdzJabXlXNTluaFNlTkxNSG1BNS9TSFI0Y05VdkIwOGJZRWhUMHkvWnpk?=
 =?utf-8?B?dFdLZ056eXNrNHgrNG5hT2huZUcveTAyVDUvdEhUR21JSFlEYnVlOWdmUEVX?=
 =?utf-8?B?aWo3cVMwQ0ZQUUpIcmg0M04rNVJWZEdFVVl0bGdGdDFNRUY1dFVqT0ZaZEd6?=
 =?utf-8?Q?p/Fi921nhQLwe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0daVEoxOGUyS1YzcURZekJIT2VOeUdubGg5clpRalpONlFTaDVETExPeEpQ?=
 =?utf-8?B?RzhHTkpwUUQ3anFoWTNCYUU3SEZUNmtucXFLREYyT1J2SVhTOWZIbXdsRUNn?=
 =?utf-8?B?MTVISkg3YWRQeksyMEpseUdYUnlFS1lrVkpRZDVVK09Xb0J2M2FiK0duZkZt?=
 =?utf-8?B?Mk14ODJMSlcwVGdxTlFKZXVHUEJEZk5CSEI4UHU1MVlhK3BwWUgrMjV2TkZP?=
 =?utf-8?B?Y21JV0xvSFY0aExCN1pBRVlubXdVUWtPQVN1SzFzUXJvTk9zMjJ0NkFQaHlx?=
 =?utf-8?B?bVQ4M3lDalBTS3Vyb2dMWmQ5eGVJV1orTHkrWjIycjRpRFBzdW5XdEMwdlp2?=
 =?utf-8?B?R1VsTWIzNHNxSi9IWEtDMGJYdUVHNVNQSkxkU01kS0RXeFVYWHYyeWJqeG9v?=
 =?utf-8?B?ejNNMEM4YUVtY2dvUDRDMnZlRGJxNURNOVBQQ29Ea1BISVhEek1QK2tuK3hI?=
 =?utf-8?B?STRSdUcxMzQreC9mQThOQmhvYUFUWU5zYnlOR0xaUlBsdFVhSHVFR28yRWlo?=
 =?utf-8?B?NzNqSkFHVUN0aXc2M2I5cnQyeE5aRmRxYXVEVFFScUNoNXc5emErdTA0WG9L?=
 =?utf-8?B?V3A4aXh5aitmRThGZ0ZxakgyNjZ6UE9GTDFUMCtWeE9EVFVrQ2t5bHlCQXZM?=
 =?utf-8?B?d29WSCtlT2Nqa0pkRktNZGRVNlJkS1lrWmpZUlR4OEpCNEhMZWRucmx6Nksx?=
 =?utf-8?B?RzB6QmVIVzk4aU1KRFFYazR3Umpka29MeW4xeUNLd0ZheVVRa1J5MWRJclBq?=
 =?utf-8?B?VWRTYUNJZlo5NFZSenprNndzajRZNmUzV1A2NW9PNU51Rk9GSzYxREJDdE4y?=
 =?utf-8?B?YzZsOEJJbGovdjVwYlQ5TGJIcXBsZU9sV1k0TVE4VUVrS1oyNG5FY1paTUx5?=
 =?utf-8?B?bzVwRkNxN2xqdVBzVjhEb1FlNWovcFFjNnRaeEJZbGZNenp2ekxxQUpKTzYr?=
 =?utf-8?B?T2hsZ0Nab0FJMWpobnB6ZkVPeFNoRTA1WHArRWFoNFo0bXUxTGpQaWxkVmY2?=
 =?utf-8?B?Y0ZrVzhhMWpINElsVzVWYnJLdmJOVUlJdWQxZVRjeEY2V3F4Qm9wblpEQnpo?=
 =?utf-8?B?QTZpVHZ3THo2NG9qd0NkMU9USmpSd1MvUUxGS2lzTUIvckQ4d05iTFpmTUxm?=
 =?utf-8?B?NnphUWd2ZGJ6ZjhqQ29uWTZJZi80OXVTa2IwdkRwc3NIOVdra09Gd1ZoRFZl?=
 =?utf-8?B?clo3RDRBOFRmU21Oamc4ajhpQWFOcVJxMElIZkpLVHlSdFVQcmVmSTU0aHg5?=
 =?utf-8?B?Z3pHNGZDWW9yb0tTLzdJSUJZMDNJZWVhRzFqZi9ueDFmd0I3bTd3NS9QRjlG?=
 =?utf-8?B?Qk5wekxmTFFBVkxCZStIeU8wUWhIQkdKQzV2Y2J6QnlST2Z4aVNMcDFzeFVG?=
 =?utf-8?B?UkFUUEZUMGNCNk12MGJJSEN6VHd3dzZrR3BCeHkxclNFWFBwd1VmcnBBeVps?=
 =?utf-8?B?M0xObUYreUV3OTlvaUpGRmNyaUJmdittdGxjY1RsQUFlRExBMm5Hb3NNdjZP?=
 =?utf-8?B?QlVXQnE0cFZVZEkxRXZlV1BtakN2QkFVd05OMzZOenM3aFpMK3p1cERURmNC?=
 =?utf-8?B?NWFTZFprYzdWTG43Mk5ZUEhvSk5mNnBVMDFmSUNzcU94RE9renRMSGEyMnNC?=
 =?utf-8?B?R2NXcUNxbWJMUVNDWmlPZzZyZGJRSWRJaW1aYUdQZ2psY1hSZCszczFtcHNj?=
 =?utf-8?B?K0lHclRLTjh3K1JYV3FFY25YWjl1cldNT1ZTQWlObmpUUkNGTVdtQ0IzR2pz?=
 =?utf-8?B?VVZEWlF0YjB1WUdtMGFOU0FnUWhQQlV1OHpjaWFJMXc5QUppd3dQOVh5RVFB?=
 =?utf-8?B?aERXUWFiTEU5VmxwMXVnTGRIbXlZS21JcXVQU29LRFM4ZTZ5OWJOYUlZQzRv?=
 =?utf-8?B?NWNadW1jQi9PUnlRMWNta1FWcTh3TEgxNmM5K2l4QzgyOFJIcmdidXZvZUNm?=
 =?utf-8?B?Ti9lTmY1MFpobk53OHlrb1JSdUwxVytRQ1JtYmdZWkswZFI2TG1LN2RBR0No?=
 =?utf-8?B?QmQydk42bG9TbUNielhrZUVydk1mY0VzN3RIakdzajVmN1NEOFlYR0xjZC90?=
 =?utf-8?B?RWZReGMxUW1ZV25ldkxFY3JQMmsveWtLWk56QWlsTFJKNzFFdTFEOTdCOGZj?=
 =?utf-8?Q?m3ySkmx3bOGOn/y9TEd2dodTs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c05db64-09e8-433b-5a25-08dd66ef2135
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 14:05:39.9187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cebdJlkvxg05lkVI5SucBJnmIPNjypi1iy1ItGqJgm2lKPccCEIq7PL/xL7ZqA78VjRFelqBSLxIQ0X9WfPLHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF0EB7D076B
Received-SPF: permerror client-ip=2a01:111:f403:2009::612;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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


On 18/03/2025 11:53, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Gather all VFIO migration related declarations into "migration.h" to
> reduce exposure of VFIO internals in "hw/vfio/vfio-common.h".

Reviewed-by: Avihai Horon <avihaih@nvidia.com>

Two nits below.

>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/migration.h           | 72 +++++++++++++++++++++++++++++++++++
>   include/hw/vfio/vfio-common.h | 54 +-------------------------
>   hw/vfio/common.c              | 17 +--------
>   hw/vfio/iommufd.c             |  1 +
>   hw/vfio/migration-multifd.c   |  1 +
>   hw/vfio/migration.c           | 17 +++++++++
>   hw/vfio/pci.c                 |  1 +
>   7 files changed, 94 insertions(+), 69 deletions(-)
>   create mode 100644 hw/vfio/migration.h
>
> diff --git a/hw/vfio/migration.h b/hw/vfio/migration.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..7ad2141d06a7c97f034db908f9ce19fd06f415b9
> --- /dev/null
> +++ b/hw/vfio/migration.h
> @@ -0,0 +1,72 @@
> +/*
> + * VFIO migration
> + *
> + * Copyright Red Hat, Inc. 2025
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_VFIO_MIGRATION_H
> +#define HW_VFIO_MIGRATION_H
> +
> +#ifdef CONFIG_LINUX
> +#include <linux/vfio.h>
> +#endif
> +
> +#include "qemu/notify.h"
> +
> +/*
> + * Flags to be used as unique delimiters for VFIO devices in the migration
> + * stream. These flags are composed as:
> + * 0xffffffff => MSB 32-bit all 1s
> + * 0xef10     => Magic ID, represents emulated (virtual) function IO
> + * 0x0000     => 16-bits reserved for flags
> + *
> + * The beginning of state information is marked by _DEV_CONFIG_STATE,
> + * _DEV_SETUP_STATE, or _DEV_DATA_STATE, respectively. The end of a
> + * certain state information is marked by _END_OF_STATE.
> + */
> +#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
> +#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
> +#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
> +#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
> +#define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
> +
> +typedef struct VFIODevice VFIODevice;
> +typedef struct VFIOMultifd VFIOMultifd;
> +
> +typedef struct VFIOMigration {
> +    struct VFIODevice *vbasedev;
> +    VMChangeStateEntry *vm_state;
> +    NotifierWithReturn migration_state;
> +    uint32_t device_state;
> +    int data_fd;
> +    void *data_buffer;
> +    size_t data_buffer_size;
> +    uint64_t mig_flags;
> +    uint64_t precopy_init_size;
> +    uint64_t precopy_dirty_size;
> +    bool multifd_transfer;
> +    VFIOMultifd *multifd;
> +    bool initial_data_sent;
> +
> +    bool event_save_iterate_started;
> +    bool event_precopy_empty_hit;
> +} VFIOMigration;
> +
> +

Extra line break.

> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
> +void vfio_migration_exit(VFIODevice *vbasedev);
> +bool vfio_device_state_is_running(VFIODevice *vbasedev);
> +bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
> +int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **errp);
> +int vfio_load_device_config_state(QEMUFile *f, void *opaque);
> +
> +#ifdef CONFIG_LINUX
> +int vfio_migration_set_state(VFIODevice *vbasedev,
> +                             enum vfio_device_mig_state new_state,
> +                             enum vfio_device_mig_state recover_state,
> +                             Error **errp);
> +#endif
> +
> +#endif /* HW_VFIO_MIGRATION_H */
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 0aae88131cffda1a90b8ccd0224387133c0fa83a..799e12d43747addbf444c15052f629b65978322f 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -23,7 +23,6 @@
>
>   #include "exec/memory.h"
>   #include "qemu/queue.h"
> -#include "qemu/notify.h"
>   #include "ui/console.h"
>   #include "hw/display/ramfb.h"
>   #ifdef CONFIG_LINUX
> @@ -36,23 +35,6 @@
>
>   #define VFIO_MSG_PREFIX "vfio %s: "
>
> -/*
> - * Flags to be used as unique delimiters for VFIO devices in the migration
> - * stream. These flags are composed as:
> - * 0xffffffff => MSB 32-bit all 1s
> - * 0xef10     => Magic ID, represents emulated (virtual) function IO
> - * 0x0000     => 16-bits reserved for flags
> - *
> - * The beginning of state information is marked by _DEV_CONFIG_STATE,
> - * _DEV_SETUP_STATE, or _DEV_DATA_STATE, respectively. The end of a
> - * certain state information is marked by _END_OF_STATE.
> - */
> -#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
> -#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
> -#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
> -#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
> -#define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
> -
>   enum {
>       VFIO_DEVICE_TYPE_PCI = 0,
>       VFIO_DEVICE_TYPE_PLATFORM = 1,
> @@ -78,27 +60,6 @@ typedef struct VFIORegion {
>       uint8_t nr; /* cache the region number for debug */
>   } VFIORegion;
>
> -typedef struct VFIOMultifd VFIOMultifd;
> -
> -typedef struct VFIOMigration {
> -    struct VFIODevice *vbasedev;
> -    VMChangeStateEntry *vm_state;
> -    NotifierWithReturn migration_state;
> -    uint32_t device_state;
> -    int data_fd;
> -    void *data_buffer;
> -    size_t data_buffer_size;
> -    uint64_t mig_flags;
> -    uint64_t precopy_init_size;
> -    uint64_t precopy_dirty_size;
> -    bool multifd_transfer;
> -    VFIOMultifd *multifd;
> -    bool initial_data_sent;
> -
> -    bool event_save_iterate_started;
> -    bool event_precopy_empty_hit;
> -} VFIOMigration;
> -
>   struct VFIOGroup;
>
>   typedef struct VFIOContainer {
> @@ -136,6 +97,7 @@ typedef struct VFIOIOMMUFDContainer {
>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
>
>   typedef struct VFIODeviceOps VFIODeviceOps;
> +typedef struct VFIOMigration VFIOMigration;
>
>   typedef struct VFIODevice {
>       QLIST_ENTRY(VFIODevice) next;
> @@ -290,12 +252,6 @@ extern VFIODeviceList vfio_device_list;
>   extern const MemoryListener vfio_memory_listener;
>   extern int vfio_kvm_device_fd;
>
> -bool vfio_device_state_is_running(VFIODevice *vbasedev);
> -bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
> -
> -int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **errp);
> -int vfio_load_device_config_state(QEMUFile *f, void *opaque);
> -
>   #ifdef CONFIG_LINUX
>   int vfio_get_region_info(VFIODevice *vbasedev, int index,
>                            struct vfio_region_info **info);
> @@ -310,16 +266,8 @@ struct vfio_info_cap_header *
>   vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id);
>   struct vfio_info_cap_header *
>   vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
> -
> -int vfio_migration_set_state(VFIODevice *vbasedev,
> -                             enum vfio_device_mig_state new_state,
> -                             enum vfio_device_mig_state recover_state,
> -                             Error **errp);
>   #endif
>
> -bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
> -void vfio_migration_exit(VFIODevice *vbasedev);
> -
>   int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
>   bool vfio_devices_all_dirty_tracking_started(
>       const VFIOContainerBase *bcontainer);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 0b9b071cd0490867bb6aa4ceb261350ccd6e1125..0e3746eddd1c08e98bf57a59d542e158487d346e 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -44,6 +44,7 @@
>   #include "migration/qemu-file.h"
>   #include "system/tcg.h"
>   #include "system/tpm.h"
> +#include "migration.h"
>
>   VFIODeviceList vfio_device_list =
>       QLIST_HEAD_INITIALIZER(vfio_device_list);
> @@ -72,22 +73,6 @@ static void vfio_set_migration_error(int ret)
>       }
>   }
>
> -bool vfio_device_state_is_running(VFIODevice *vbasedev)
> -{
> -    VFIOMigration *migration = vbasedev->migration;
> -
> -    return migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
> -           migration->device_state == VFIO_DEVICE_STATE_RUNNING_P2P;
> -}
> -
> -bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
> -{
> -    VFIOMigration *migration = vbasedev->migration;
> -
> -    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ||
> -           migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
> -}
> -
>   static bool vfio_devices_all_device_dirty_tracking_started(
>       const VFIOContainerBase *bcontainer)
>   {
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 42c8412bbf50724dddb43f9b19a3aa40c8bc311d..2fb2a01ec6d29dbc284cfd9830c24e78ce560dd0 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -25,6 +25,7 @@
>   #include "qemu/cutils.h"
>   #include "qemu/chardev_open.h"
>   #include "pci.h"
> +#include "migration.h"

I think iommufd.c doesn't need migration.h.

Thanks.

>
>   static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                               ram_addr_t size, void *vaddr, bool readonly)
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index fe84735ec2c7bd085820d25c06be558761fbe0d5..285f9a9a18dd8f0847ac5ac3fdaa304779a2d0db 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -22,6 +22,7 @@
>   #include "io/channel-buffer.h"
>   #include "migration/qemu-file.h"
>   #include "migration-multifd.h"
> +#include "migration.h"
>   #include "trace.h"
>
>   #define VFIO_DEVICE_STATE_CONFIG_STATE (1)
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index a1ba993ce549fce0d2a9a60ba07d4782c87c0c09..46c4cfecce25ba1146a1d8f2de0d7c51425afe8e 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -31,6 +31,7 @@
>   #include "pci.h"
>   #include "trace.h"
>   #include "hw/hw.h"
> +#include "migration.h"
>
>   /*
>    * This is an arbitrary size based on migration of mlx5 devices, where typically
> @@ -1222,3 +1223,19 @@ void vfio_migration_exit(VFIODevice *vbasedev)
>
>       migrate_del_blocker(&vbasedev->migration_blocker);
>   }
> +
> +bool vfio_device_state_is_running(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    return migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
> +           migration->device_state == VFIO_DEVICE_STATE_RUNNING_P2P;
> +}
> +
> +bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ||
> +           migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
> +}
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 7f1532fbed9aed2eae2c98f6fd79a9056ff1e84f..3612f6fe7d0864fe3789f4ea221da01ef87d0664 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -44,6 +44,7 @@
>   #include "migration/blocker.h"
>   #include "migration/qemu-file.h"
>   #include "system/iommufd.h"
> +#include "migration.h"
>
>   #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
>
> --
> 2.48.1
>

