Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BDBCFA468
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 08:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMMIN-00066n-IG; Fri, 21 Nov 2025 03:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMMIK-00065x-Az
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 03:15:04 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMMII-0003ri-2c
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 03:15:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SV2h7atPJsAdLt8feaJEip1tgylbhBIIW0jbH/0fmak23786gAoT/ooN/6p/GSB6Sur+jHry5QuzgT9XuR/+EbcolFOXiDk01FDww3VSpgzyf162qaM7VTUNp1DT9StVhER4NP+1jV0L2SuribRO9XC3siZoGukWXkO5qQVMoYisGjNZiGY9Yf/e52V3JWVPLJMZgCP+CVNon52AfKWINSaLheM7s1D+F5gPAz0IbsHgE773/9eV1Z2qbTtOQORjras3vBCKQVoZQ2CWuE48GJ8nRzvCP/waqQ0OlX53UATsNHINJTHQQ6LacwjoOiLswWTrgATdoGYWGoP7Xz31kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbhjIHvirw6dovhhwTH72Iw7LTypKkz2ObV/TNtMGHg=;
 b=hQxw7L0ivq7JTssaY3MlCQglOc85CpTgxlus4NqfwzCnPIHYpACmhlJnAvIxX8uBGf5cBeli9NUsxr2+Jtd2UFx91PnnF3SCKN5Aa5JP3Tnz7Wz3W3RHo1Kwkuh+pxkwtB8SAr1nMRf9l6Q0Btyc/TmxfYqEmB+grAWHJtU8vXefuoXj1Q03pz8MYVTyTqrllDq6f38zs7p6OD5HI94WnuvyM/EYSTBD5qUj9cf939wJLxqB26V0sCNAiQZfBLnzG23quuyvQnuXox3Tsho5Rxv6F04HTWUQehalimXasKus+O4+i73t6Ep3dw8K8XXzbNGlsrNSoVu+sNAwO4xl0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbhjIHvirw6dovhhwTH72Iw7LTypKkz2ObV/TNtMGHg=;
 b=XFqRgmKzWSVDwDsGkLP1UCDWVs4l8xpYIuxeORSYKVzI6IoGUDFwEQWaPE4h+I/+a+sWYfVIcIeVxfwF1AenBl7lu5JZADA4PabLu504HX6flYLOvL4pPGKOcq0oa3g8pslbVypKqUJhR1NIpN4S9TCu3xqYq8If3tJkRNGsL5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by CH3PR12MB8548.namprd12.prod.outlook.com (2603:10b6:610:165::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 08:14:56 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941%3]) with mapi id 15.20.9275.015; Fri, 21 Nov 2025
 08:14:56 +0000
Message-ID: <0ef0b85a-d45b-4efc-ac1e-b562b1d34786@amd.com>
Date: Fri, 21 Nov 2025 16:14:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v4] virtio-gpu: use consistent error checking style for
 virtio_gpu_create_mapping_iov
To: alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 odaki@rsg.ci.i.u-tokyo.ac.jp, armbru@redhat.com
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com
References: <20251121075802.1637598-1-honghuan@amd.com>
Content-Language: en-US
From: Honglei Huang <honghuan@amd.com>
In-Reply-To: <20251121075802.1637598-1-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|CH3PR12MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f2c2d6-b323-4cd0-8062-08de28d60e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b05nOHgwZGZnZUd6UmVrN0pZQjJvZHFvdDRzemFHenNibVZsN0lXWW44SUJS?=
 =?utf-8?B?ZzRMenhGbk4xWHVEd2I4bnhHd2NSb0NPYW85aGVLWWpJK1I1Q1VYYTNDR1FV?=
 =?utf-8?B?dVJrNDloTlVkTUtXTkJuNlJvd1FnR3Z4TUptRWhJTFMwRE5oTTJ2ZHBVeTRS?=
 =?utf-8?B?SG42K0NnYXBTcmc4SnpQWTFuK0txQ2Z1eGloSGNBYmtGZkNESEcydVRPT0J1?=
 =?utf-8?B?cWRpUkNwajJSQVpHWFRNNXRaMVlWdDBjajA3dm5ZeklnQnpMNEQyRmNkODRQ?=
 =?utf-8?B?bjlBSDZrU05ZSXQ0ZFRBN1ZlcEZEMXVPWlpqUmttY2hSK0NieG9GRCtEMnAy?=
 =?utf-8?B?TDc3eFhNTzJVcGNKTXMreGluQlVVRi9TSVVCWmFUL0VlZkJJeGFta05wR3No?=
 =?utf-8?B?STI0TDJLdDFMcTkyVlU3ZldOTkdUaWhseWRROGxIcmR3OHdSazlva29LTFlM?=
 =?utf-8?B?aFEzTkFROVRFMnpiYmFkbVh5OThUM00zMEN2a1gzY0crbTR0SW8vWHJlWEZB?=
 =?utf-8?B?V1lpNmxHUGFuMS96Q3o2NTFBdjFlMGVqbUtIaHpUcTN6bTRiMURaVFZvemhP?=
 =?utf-8?B?OFRlcGFRc2pDWEVBZVhRYmdvUmo4NWVaYlZuUXZuckJNV0RPaC9xV0Uwem94?=
 =?utf-8?B?cE52SFZ2Sk1uSjNGNWozSDU1em0yUW5yZmNPVG5FM0kxOTNVaU84a0kwOGRa?=
 =?utf-8?B?Z3BJU0ZFNlZDL0xrSlM2RGpJNXRDdU9NdWxmSFRSaGVrT0RKMEM5RTBKTm5D?=
 =?utf-8?B?a0FSRHFhcHlrSFErdGhPMFlsbFRsaGVSS09YMjRhU0czVVFWRzZyZ3lTcnF4?=
 =?utf-8?B?T3FSZWZaRVNaYWdVRWlmZW5PV3F0K0U3dWYxUFhSRnZRTDVZNlVtTGJ6MzBj?=
 =?utf-8?B?Tzl6d2tVYlRPeFY0NFlEQW5ObkdWRERaakpoeFFTQ0JHbEx3WWJOL0ZzSFNB?=
 =?utf-8?B?NUh2OVNZYnk2M1lKR2QzSUZpczRZWHBSQ01DUWMxdDNNT0h6ZDNUbFgySXNC?=
 =?utf-8?B?ZExTa3ByZ09NaXBVR05aZS8yV3d2bFFMRFY2K3lGZllFNUZVVkhTWjhQNytW?=
 =?utf-8?B?UzJrRXRPTVhvOVIzNzlqTEFDMGl4ZW1BalJEbEtTVGdiNk5MU2kxQTRoZG03?=
 =?utf-8?B?cTM1V2c3eG9wVFpSMHlyMjVJdDVDREduS1pUdTZhSzIrOTRJV1dDb1VuSTRR?=
 =?utf-8?B?WStMRUY0blNqcHlidmtUbmthZU1jR2trV0ZNTDJLREpNTnUzdCt6T3VyVHlu?=
 =?utf-8?B?Yit5MzU4cnlIVTkyYkwxa2w3dmtXZDNLMmNkV2NUMFdDc1cyeHZreDdVdks5?=
 =?utf-8?B?SFNpTFl0SGFsbVpBN1lsK2xKM1hZSldrOElTMU5oWWdtbUlDSmRsREg5RzM4?=
 =?utf-8?B?dGhGVmJmdlVmQ3l2dFRLRWtNaFZ3TDJucjQrVWR3QUdnUEVnS2VGQnhIVjVB?=
 =?utf-8?B?U0pRWFNJd0lldFZEMjVJQzdDVE9YZmF5MVE2RXVidktFVnhBMlF5bHB3MDF6?=
 =?utf-8?B?UHNEQ2ZPN2NZWXdidWFveXZSTzBMc2NVbldIWjAraDdvQW5TWXFkYWU1QVFW?=
 =?utf-8?B?ZDhQTXdtR1ZicVZ3SHM1SVhqT0FPbGZiekZubkhqQUtocUJxTEZnSWZsK2g2?=
 =?utf-8?B?azdHbE02R1gwUGtaZ25CS3Y3RUZydUpJa0pPdE9jUUlHRGpma0pUYVFlR1Nt?=
 =?utf-8?B?MlBrQTBhUXlvTGxmUHdCY1JHVnNKMGk3aFhkaG9DVTlmdHNkbVNUakpHd1FK?=
 =?utf-8?B?SjJpZVpkL2JKc0dXTkJxYmhWanFOL0luUit1aHRvWEFwdGxOak9BRXUzeGls?=
 =?utf-8?B?YTFYdFQ0elJuTkwvaGJmMmI3MHBoMExBSlE2cFVoaFJ1bm1XMUhLVk81WDZ5?=
 =?utf-8?B?eUpIT1RsdlBCUStBcmRzMzJyT1pEMVNiV0FTVHNoamJkdCtCc3hOeitKTkcv?=
 =?utf-8?Q?P3/olN4nLKS49qbNWKtJBVsGiSt+kPIH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajBKRG9lRFRZV2pmV3dkaTExQ1FhM3hOWHVhSjhTdkRTd1FwMEpWcDZpWmNw?=
 =?utf-8?B?YlcyV1RBQ05ka0hnNkMxaTdtM2ZBOTlua0o4RHJpZXFqYWNnZjBSVE5TZnBW?=
 =?utf-8?B?OUVsamttNm5nWXI4VW5WejUxS3ZxU2JxL1p0L1MzTzNBTENzRXVPTWhzOHZm?=
 =?utf-8?B?OTNER0ltQjN4WGFPcFZwdG5ZTDNhL2NjUkVaZUtKYnREeWVTOG5DYmdXNTNo?=
 =?utf-8?B?b0dxMGtLWHcwb0lSR1pCRlpsTWJxOHZuR2tRaG9paW94K01QY2dxdnIrSFhk?=
 =?utf-8?B?QU9oT2szUklFakQ4c0NjL2czYlJQY2FjUFR6T20zME1KRjN0dTd4U1BBWk56?=
 =?utf-8?B?K2E0amZpcW1CN0NPY2gzdDlOM3JGUFAzdXhrSjRSYTRtNHRsSHRLT2NyTkJN?=
 =?utf-8?B?RWJObjc0R2ExbCt0YUEraDU1d0EvWld6U0MrbmNLaDNsTVRpbktxTjlzUG5z?=
 =?utf-8?B?S25VTmUvT3h5M0YvdWZVbEFtOWd2SnAvdzJzaU5vVEQ3eWFaUjUvVS9SeVd1?=
 =?utf-8?B?dEt2ZDQ3SWFrbGdhUGszbXZYQWtzaXRtejVOemtScmFZa25QTEczNldTNENG?=
 =?utf-8?B?WERrR0s3ZmY2REVhMFZaU3lzTzNiSTlTSkZDQnUrUHdhWHZyQ1R6eHNKNHkw?=
 =?utf-8?B?eVRlV3JIdE9HOEEwRG56V28ralVMOGZvRFRxQmp1WTFhbk91d2VycldEM2Ry?=
 =?utf-8?B?YUtxdDhyMGk2VGo2RGJGRkpjQzhnVWhzZ0FHb2RaN0lSbXJlaUROU2ROZDFO?=
 =?utf-8?B?d3FaV0ZIS3djTHlRcnFZYlpNK1RlSzBlN0FKU2lzYmh1M3dqYzdEeXNNSDlZ?=
 =?utf-8?B?TGEwQWJGSWFVVWlWbEk2d1hWR0tqaGxDWVhmdENtcStDazJYcEhqT292Mkty?=
 =?utf-8?B?SW5HblVUdVA2V0M3ajIzYzl4MUJCWVB5NUwrZjlOR0ZJNDdEb0owdkVpdmZT?=
 =?utf-8?B?Z2RNQjZEVkNFK0diZnFiYVRCN2dUdTZQYzlSQnB3eloyTS9IM0M2NWhCYVdO?=
 =?utf-8?B?d1lRazQzbFZCb1dXTkVOOEZWZkJTNlpsUlh6TzlPMWd6dlc5VjY4akxQb3VU?=
 =?utf-8?B?dzgydDRMZllhUGxQeVJWOXlZeVJqNXNmaHhMbDRoZE5aZWpheVpaR2h0YkNu?=
 =?utf-8?B?WVp5MCtjQ0h4S09yWEtuK3JIa2JDZThJTHlFRmcvMi94U2MwMDdTamEyenc0?=
 =?utf-8?B?aUx0OGlaaG1ibU8zWFVnUUE0d0pTOE9CRUJNUVQ1cUF0VkxtYzE4TWU2KzNj?=
 =?utf-8?B?M1YzSmRIZ1FtZHRJOVVtTXE0R01lQWQ4WWcveWVvZWRPMGdyVjBiRkhGVGhi?=
 =?utf-8?B?K2tJQTVJM0dtd1FDME5XQlZvandpb2w3OWxGeTFIZUpiTnMyaG1TRmR6aEI3?=
 =?utf-8?B?TGtuRkd1WEpsRU13dHI1djVPTjZpZ0JuYUovdEVhVW04SWY5UTlHOXB5K3NX?=
 =?utf-8?B?b29LUDBXTTdGVUFrT0E3VUpBRi9RM2JlZFFuOGlnWG5yZ0hvV0FCRE51aVA1?=
 =?utf-8?B?ZDJnQkc5MldndVVJV1pXcjNrQ1hFSklUYkxaWDl2U1VjV09wd011TUMxV2px?=
 =?utf-8?B?SURvOGZmaE9zdEhrcUdRckVCbkh4eEkzaVRWMTRsek5HL0hFWUM5ckZYZkhp?=
 =?utf-8?B?bFdiU255V3E4UG9LTzJETnZudHl5U3NXVFNwWWFjVE9NUDJsdUgybkEvUzVJ?=
 =?utf-8?B?ekp0eCtsTldjenpkbXJlT1IvajM4U2NwdVJRSjhrRGpHSnVKcWx5dFY1aXhL?=
 =?utf-8?B?c0xIYU5oaFFsOTN1M09FMUtXSkV5M0wwZVNzS25jelNGYWlDS29udGdJeTVO?=
 =?utf-8?B?K2lOZ05qVHdEdklYYjVYOFlicU11MkpPVFNwcHhDTjJPN29NRVdFZXo1elFI?=
 =?utf-8?B?dmR2cmlONFVVc3J1RExwcTlReE0wclFvVXZmQ3dBL2lPZUx0N2hLaDJ5YjVu?=
 =?utf-8?B?aWt6Q293WmFubnQxUFJaaVoyVG1uUVl5NndLNFN1ZFU2Q0ZMNGM5K3FzRDEx?=
 =?utf-8?B?V1grWktMdUNzT09xR2RqTjErUk8waWNJSlRmSTQwSTdWUC9Vc0ZyM3BqUXcy?=
 =?utf-8?B?aUhEcmo5ZkVsS1R1aE5uZDhKbkU3UUM3NzREa0xUOXY4aThBZERpc2J4U1BX?=
 =?utf-8?Q?RfM8eBnHJg3Pv84g80ctaTGcu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f2c2d6-b323-4cd0-8062-08de28d60e14
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 08:14:56.0772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wA6l14KA7GRNMBOyg1rLCXo+b50fP350i+H4vLiv2euPocx1MRT5ZQFFGmDo+3phEgJxEi32J0aPLaKzVM6nmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8548
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=Honglei1.Huang@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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



On 2025/11/21 15:58, Honglei Huang wrote:
> Fix error handling logic in virgl_cmd_resource_create_blob and improve
> consistency across the codebase.
> 
> virtio_gpu_create_mapping_iov() returns 0 on success and negative values
> on error, but the original code was inconsistently checking for error
> conditions using different patterns.
> 
> Change all virtio_gpu_create_mapping_iov() error checks to use consistent
> 'ret < 0' or 'ret >= 0' patterns, following the preferred QEMU coding
> convention for functions that return 0 on success and negative on error.
> This makes the return value convention immediately clear to code readers
> without needing to look up the function definition.
> 
> Updated locations:
> - hw/display/virtio-gpu-virgl.c: virgl_cmd_resource_create_blob()
> - hw/display/virtio-gpu-virgl.c: virgl_cmd_resource_attach_backing()
> - hw/display/virtio-gpu.c: virtio_gpu_resource_create_blob()
> - hw/display/virtio-gpu.c: virtio_gpu_resource_attach_backing()
> - hw/display/virtio-gpu-rutabaga.c: rutabaga_cmd_attach_backing()
> - hw/display/virtio-gpu-rutabaga.c: rutabaga_cmd_resource_create_blob()
> 
> Changes since v3:
> - Extended consistency improvements to virtio-gpu-rutabaga.c
> - Changed CHECK(!ret) to CHECK(ret >= 0) and CHECK(!result) to
>    CHECK(result >= 0) in rutabaga functions for consistency
> - Now covers all virtio-gpu files that use virtio_gpu_create_mapping_iov()
> 
> Changes since v2:
> - Use 'if (ret < 0)' instead of 'if (ret != 0)' following maintainer's
>    feedback on preferred QEMU coding style for error checking functions
>    that return 0 on success and negative on error
> - Updated all similar usages across virtio-gpu files for consistency
> - Expanded scope from single function fix to codebase-wide style consistency
> 
> Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/display/virtio-gpu-rutabaga.c | 4 ++--
>   hw/display/virtio-gpu-virgl.c    | 4 ++--
>   hw/display/virtio-gpu.c          | 4 ++--
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
> index ed5ae52acb..ea2928b706 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -466,7 +466,7 @@ rutabaga_cmd_attach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>   
>       ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
>                                           cmd, NULL, &res->iov, &res->iov_cnt);
> -    CHECK(!ret, cmd);
> +    CHECK(ret >= 0, cmd);
>   
>       vecs.iovecs = res->iov;
>       vecs.num_iovecs = res->iov_cnt;
> @@ -616,7 +616,7 @@ rutabaga_cmd_resource_create_blob(VirtIOGPU *g,
>           result = virtio_gpu_create_mapping_iov(g, cblob.nr_entries,
>                                                  sizeof(cblob), cmd, &res->addrs,
>                                                  &res->iov, &res->iov_cnt);
> -        CHECK(!result, cmd);
> +        CHECK(result >= 0, cmd);
>       }
>   
>       rc_blob.blob_id = cblob.blob_id;
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 94ddc01f91..6ebd9293e5 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -557,7 +557,7 @@ static void virgl_resource_attach_backing(VirtIOGPU *g,
>   
>       ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
>                                           cmd, NULL, &res_iovs, &res_niov);
> -    if (ret != 0) {
> +    if (ret < 0) {
>           cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>           return;
>       }
> @@ -701,7 +701,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
>           ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
>                                               cmd, &res->base.addrs,
>                                               &res->base.iov, &res->base.iov_cnt);
> -        if (!ret) {
> +        if (ret < 0) {
>               cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>               return;
>           }
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 0a1a625b0e..1038c6a49f 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -352,7 +352,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
>       ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
>                                           cmd, &res->addrs, &res->iov,
>                                           &res->iov_cnt);
> -    if (ret != 0) {
> +    if (ret < 0) {
>           cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>           g_free(res);
>           return;
> @@ -931,7 +931,7 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
>   
>       ret = virtio_gpu_create_mapping_iov(g, ab.nr_entries, sizeof(ab), cmd,
>                                           &res->addrs, &res->iov, &res->iov_cnt);
> -    if (ret != 0) {
> +    if (ret < 0) {
>           cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>           return;
>       }

This v4 patch started as a bug fix for error handling in 
`virgl_cmd_resource_create_blob()` but evolved through community 
feedback to include comprehensive code style consistency improvements, 
unifying error checking patterns (`ret < 0`) across all virtio-gpu files.

  This version appears to have gained community consensus and may be 
ready for acceptance.

Correct me if I am wrong.

Regards,
Honglei



