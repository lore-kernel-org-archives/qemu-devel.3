Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E64E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 17:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLmam-0007hw-S1; Thu, 12 Dec 2024 12:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.lucero-palau@amd.com>)
 id 1tLmaX-0007Tu-Pb
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:03:03 -0500
Received: from mail-dm6nam11on20602.outbound.protection.outlook.com
 ([2a01:111:f403:2415::602]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.lucero-palau@amd.com>)
 id 1tLmaS-0000kS-Ux
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:02:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+pbCbztrTtBVotgEpJbwxUjHcU42JqAoUDzMvxo/Hs64s36nDrwX2aKehIrxqqDH8AV3xScXm6cv0ULXxse94Uko+MO9KgR8AgHllZcBUR6sLVroO43Tc8rAorJTxK8jtkgO4nHEUzZMHY4uPRsiAcLcSSuvnF6RNtgXMEzhSFrhs+UpKF4XkeeA62CT2av5bSlJUxEHtEOaCrvrWX99knfTRDUIaqYvZT2Cxd8GFAf17NchxQABN1A+Ho7x0JWPOflkoQYvMzh8DeVO8ve2+e0gHGvI02dmac8CJ3RxFvycZVDRgx+A/ko3yYkj+TEyE69PFWy0yFvoU7wNBkCrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icwB5xjjmRaOZDAbvgIc8uH+Y6sfjyiphSqt21zH2sg=;
 b=HB8J7SpBpgnJal6f6k1Af4Yv1EiS4GuPvjFqQBSavLDZfTmClwsDv0DQ5xKlAREiMsjtVYfZAogahtnpbMOdmKOWctpBkMO+DT2xJ6XAnPyvHMafFmoPcRyP3Vj9C+0yqzt7h2yNG6HjoeELbNwvK+7A15hZ5igy8eq0rz6RRCH/Qx5/VtglELuELjJtbaR3gEgfz0LzLPy1t4HMt0tO1QNlAggc99yXsxHYiSwiNqBAlVaQll93m0TGtYcb+vLRzc5Z8Hol32ThiyJBI9W85wYFwicXry5jdFDOUiToYvBSJuf3pP7kvycTh5cugSuXDbROmbfyisKIp7UDPirR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icwB5xjjmRaOZDAbvgIc8uH+Y6sfjyiphSqt21zH2sg=;
 b=kkAsjWatyDCNyzkniUkznnNRoaXmjcTK6QFv3Q++cu7mUoW3xQ/AfZfQXz/cX9jYH6nkYQ7bttmmZ6QbdwN+334cx3QgD4tvSGX8qmdNE1P5LzHagoNM4OmHa/OfTDxqXpjiLGK0/PFJSiZ/dmaHTcQ6LLU7VGBsQvi7VN0X89o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB8965.namprd12.prod.outlook.com (2603:10b6:806:38d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 17:02:42 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 17:02:42 +0000
Message-ID: <1658c46f-ae3a-7eb8-1718-e5305bc50678@amd.com>
Date: Thu, 12 Dec 2024 17:02:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] hw/cxl: introduce CXL type-2 device emulation
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>, qemu-devel@nongnu.org
Cc: dan.j.williams@intel.com, dave.jiang@intel.com,
 jonathan.cameron@huawei.com, ira.weiny@intel.com, fan.ni@samsung.com,
 alex.williamson@redhat.com, clg@redhat.com, acurrid@nvidia.com,
 cjia@nvidia.com, smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com,
 kwankhede@nvidia.com, targupta@nvidia.com, zhiwang@kernel.org
References: <20241212130422.69380-1-zhiw@nvidia.com>
 <20241212130422.69380-4-zhiw@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241212130422.69380-4-zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0009.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: 603c2a8f-ba7f-4886-ba44-08dd1acecad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2FVUFhxMGs0elNrYUVEQ2dGMC9nMnIvZktydkhxWFUzYy9GTkZFak1pK053?=
 =?utf-8?B?TXl3RFZ3UlBKUFpVczYwRUN6R0ozWDNlQVN6VWt3K0l6c0p4aVFaeWtOYjNn?=
 =?utf-8?B?dnBSSnEycnhWV21wYlhZazdTMjcwRnhDMmpIMUNZYUFCUHBMQmhJL0pCNGt1?=
 =?utf-8?B?UGFMMElTWUp6ZTNlSkRHVyt4U0tzNnRhQldiVUk1WHhabG8rd2dQaWpKWnRD?=
 =?utf-8?B?TFhIb3FPcWJVVm91MmtSallsNS9qTjhLbDQyd2kwMlNYd0doall2R1NnWDgy?=
 =?utf-8?B?NWlqbTEvekVyUlhSOTJVQVorY1RoNjA3cXJBRlNaQWZwTTBCc1ZNTzNmSjc4?=
 =?utf-8?B?b3d1cHF6QmpKZktYMnh0azlWQ1lKZ2wwSTMydTN5anp2aUhHZytDbXBZK0hV?=
 =?utf-8?B?T2hrNjVJWFhUSTBVdWRESG1kTmU1Q0l1MVozZWxyRDJ1dWhpU0RFVjVnQ2Zn?=
 =?utf-8?B?NElJTVN6aTYvSUJqaUMzM2M1K01KTDVUbWNyL2EyRURuQS9XN3RLWHBiV0hH?=
 =?utf-8?B?WEpxSldWYUtBck9UanZ0YVkvVU1JbjZGWWNGU0NKL3h4YTN5aFpSYmNIem1u?=
 =?utf-8?B?Z1I5L3NFQzhJaHBmKzlFSFJQK0pBMkcxWXZKQjJlNm4wRDVHODZCQWVMd1BY?=
 =?utf-8?B?SVlRUk9PbS9SMTNINnVFc3hyWXExL2MrdmtZZnhkV2ROZGlLb0g5Y0dJaFRu?=
 =?utf-8?B?VWRFSGdQRkRvZHZrRitRVUVCcm02QWxLVW1MNjlmRlErYXduKzZTSEdiRXRN?=
 =?utf-8?B?bzhyVHF5REpEOFNkNHZhai9IUjVqSUdoWmhNSVh0YmZTbGh1WmVEL0xoenZG?=
 =?utf-8?B?UzFBWDRmVkdDQUZSalNGZUFHM0JleXo4TWZLZXpYU2djeWYrQ3UrOXNteEQz?=
 =?utf-8?B?TkM3MDdEcFpiWHVYU2o0dGJRblptTEVBWmxKYU5TZnRVL0M0OGJWZUFrZXFy?=
 =?utf-8?B?YTJSUVFFZmIzZ0dZek1EbnVyaVpLcmcvd2tIRnpESSs3VWVCckYvV2JlL29k?=
 =?utf-8?B?WDcxeVh5RHVIUmtwUEtLSWJ5RDBXS0dsTzBxSWNSU2JHc3Nnclc4US9sQnRH?=
 =?utf-8?B?Y3E0TXRNSG9keVJuT3JMcXVQOHczc1pGSnZtSExKTkxjWkRVbEEzZ2NNSHBa?=
 =?utf-8?B?bkVCVE5YUEJPZnVrSHRoYmZwOVlGWlZRTE1ET1NuQkFOelF0ejNNMXJseDhj?=
 =?utf-8?B?TnNmNElIeGRTVHhpOTdmZitoenZCMVQxaWJmSjEzYlJZbno3VmtrK0dOc3BU?=
 =?utf-8?B?NkRhMGVOc0NFUW1LUVBkbEpNbENWR3RWeG1kT0p0U3Z2My8wZ1lVYk9nWDBG?=
 =?utf-8?B?QmNQa0Rod25zTzRKcThtMTZyWjkraFdDNU1FZG5MbnQ1alRCbi9WUkdrdGhV?=
 =?utf-8?B?eVB3b0dYd01KZURMTWY5S3U2ZUZyVDZJbm16dHllYXIvSGY3RFR2SzlnQjVp?=
 =?utf-8?B?dUVLNWlhTlpBTlArOHBQS1dkV1U4aFJEaDg0RjlqZUJFaXlWNlFmbWFvOWpY?=
 =?utf-8?B?UHFJUHBnVFovTFNJT2tVSTdDQlhoOGJEWVlLbE9kRWxxdmtINGJUTGVvMHh1?=
 =?utf-8?B?MjJuQjMxRlJqWXN3M3FsVW43bThyNFBoYzVUU0gzMDlLWWlqSVVYNUU3Vko3?=
 =?utf-8?B?dFYwOE1sOWJQbVZPMS9CTnhwejRKNzZMVGg4L0lvVTdvSEtiU3NjcWNzOXkr?=
 =?utf-8?B?ZWMwK0k3bEE0MGw5MVF6QWFpSG9oTFVzSnU5cFgvTTNObFFLOW5OOWgvQ0RM?=
 =?utf-8?B?WllDT09vSzRuWkRwNEhrb1NwMTFlNGZUQVlUaU45UTVpRnhveUJvdEY3K2pK?=
 =?utf-8?B?U2RBbGlWQ1BYajZiUlo3Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4202.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGZoZlFHeHN5SzFyVGh5eUlEc2dicmt3SHc2dFVNSHRqWTN4VVJFck1uazRr?=
 =?utf-8?B?NjRQU0cxNldCakdicklRWFkzazFBdnB1YUZqVEZkY0RzNmlicS9mZ0E4M21F?=
 =?utf-8?B?eWZjZVM5eXF0WDZkSnU2SCtZaXZYZVZlVUdhbDNwMjV2S2FnN1hOVklXSHVi?=
 =?utf-8?B?ZUpjWFgzdzZqbnRLVVdFcHZHUnhlQytpN3h5M0xIdzUrMnhvR3VLa1pMSjhQ?=
 =?utf-8?B?SGRSNFZtMk5CL1BxQlFBU3NzMHlXVll6RDF5OWNFcDhaNEMwYU14YTJFNWlG?=
 =?utf-8?B?VzZLWHNneGx5Q1NZU1lucWlxS3A4ZDhuOWhyWVhEOGtqTFdtYmIyOWtjT05y?=
 =?utf-8?B?aUkzUWxpUEZFM0ZuUXRKSXE5OXVnSzJ6L0d2TTQvSzdBRHhDWW1iRkluekU5?=
 =?utf-8?B?ZDZRdUJjcXZpZ2t2cVQrUFZ2bGJSRHZaa2xxN3ltOHdaalpXZTg2c2FTOEFE?=
 =?utf-8?B?V25WR3c5S21hcDVoOGQxUnJNalhyNE45M3o5bDlPUHo1cEhuNXVCeHlOdWxr?=
 =?utf-8?B?L3dZaFhPNFF5SXBQU0M1UDFjVDh5NjFEVERsKzNQZmNPdHM5VTMyNTh2K3g2?=
 =?utf-8?B?V0E0NnJyQlNnQkF3S3J2azZXZlFQNS9JbHJ1RXVJSG9rZ2Vmdlk4UHNXV2lp?=
 =?utf-8?B?elJPMGsrc0daR2J3OVVzT2xvcVpuN0tCc2RkNHRDVVBLRjgxNHp0VEROR1lE?=
 =?utf-8?B?Mi9qNGRmaDNGZks4RWNEMkppMHQ3T3FuMmRpUy9iT2h5Y29UdkhnMmptQTB0?=
 =?utf-8?B?dVNEeDdZZ1Rxc24yWGpYWjR4V2Q0MGJ0RkVGNDBXNWszWjZKOExjeXd1SFB3?=
 =?utf-8?B?eUF4cDlDNGg0d0dRUmw4WVRKejhMMWMzeFZxYTFsZGdjOU1YUUVWVWFJWFps?=
 =?utf-8?B?NGJkZzdDOWhpSFpXVDNGY1c1dUNhWVh0M2NlbjZlMjZidDZoMjQ5eDcwbjhU?=
 =?utf-8?B?bEVqYzFLZjNsVWRUYkVPZ2R0ODBkekd2dG16YjM4eU95U1lCTDllYS92ZkYz?=
 =?utf-8?B?WGJNZ0YxWnNiMm9USHVxNkQwaTFNQmI1OHg0aUxjT2hFNTFVY0VsVXVZVERT?=
 =?utf-8?B?cnU2RjIyOVlBRWsrczFMMGFROWoxSjdhejAwZFR4cFlKbGlObkpkR1JyUkdo?=
 =?utf-8?B?RVNoZEwrWE5KSEJuZWdPTkJuSHI0SWk5TFA4akJ6T3NQUGVpdTdtV1daQUlj?=
 =?utf-8?B?bVV3c1FFSW1WT2tpV0owb20yRlZNTjhYd3BVcFlZNWlaM21QQ29qWTBFT00z?=
 =?utf-8?B?bW1MQnVhVFhsbU1wRkhSaXNrWm1jZ0NIRjdWR3IzMitsOEIyN1FLdXdlaHNP?=
 =?utf-8?B?MlRicEN3cDVKdlk0d0FqZkZzQWx1RXZLcXFMak5tY3FSSFJBZ2gzV2tkZjY3?=
 =?utf-8?B?d3BPSGVGbzZLYXdZZklZcHpmVUFyZ0RFS2dJQ1haSUpxZHBmei82V0JUcDVj?=
 =?utf-8?B?OFhTZmhuS0pYaUR0TEc4d093WW1TN0VXU0J0VlZiUHNmQVgzQ2NJVkRTV0dH?=
 =?utf-8?B?SFNHQTZ3eUh3WlJjNncvblR3VHd0dHJRRytoTTRJeG9FMjg5M0lhNTc0TU02?=
 =?utf-8?B?cHlCcGpxODZTZSsvMit5ZE9HYVpkaVVGc0lnWlk4UHVhS2l4SU9SNjhGUjJK?=
 =?utf-8?B?eEpEa3pKdEVwbDVVYkhjNThkZGoyaGNsSVFaZnRqNTBOT2JpdmFVNVNWYWlp?=
 =?utf-8?B?MFJuS25jWGNmTmV6ZEo0VVcwbzcyMHdiV2llMGJCNjJHZHNhTkRNVXloNHpI?=
 =?utf-8?B?R3lvS0tuZWYwTVBzMGFOVWE4VnpkTGlUWU8zbDA5Y0J3TTRMa20vS1AwWGU1?=
 =?utf-8?B?Wk1lWGsyTkQ1Sitta25mK3orTWlKYWhHc0pYdEpqSmxSOGNISFZqZjZJU2tq?=
 =?utf-8?B?RXB4aXFyeS9EdmEyYzN0UWRtaHdUZ1VsdDJvN1dYYWJEVEMvcE5qL0oweHQ2?=
 =?utf-8?B?NnlGK2FJakxkQVIzTEIzbWs1MWxxdWh3d3lSYVMxS2tnVitLY2ZNeTdXQmJN?=
 =?utf-8?B?NldxSU9tK2tFUTF5eWlON0Z6eithYkFiN2w1akdZNWw0Mm1RUC9jNGsxOUVo?=
 =?utf-8?B?NDNBWTBOUGQ4Yk5GSkRMclVnRC9ic2p3ckVYN1B1QkZVd1d1OTgxUG9OWmQ1?=
 =?utf-8?Q?ftybqIrSawlwhzDBxhtweKfrm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603c2a8f-ba7f-4886-ba44-08dd1acecad1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 17:02:42.6242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUuWzay6MZznYbeDgQJP8RpQ0ih/vbiQc8CplTeE3SPkUyIZuYH65tLvvhaOrhkDdUU+a/G9WvXOXkcs8zdaRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8965
Received-SPF: permerror client-ip=2a01:111:f403:2415::602;
 envelope-from=alejandro.lucero-palau@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.217, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 12/12/24 13:04, Zhi Wang wrote:
> From: Zhi Wang <zhiwang@kernel.org>
>
> Introduce a CXL type-2 device emulation that provides a minimum base for
> testing kernel CXL core type-2 support and CXL type-2 virtualization. It
> is also a good base for introducing the more emulated features.
>
> Currently, it only supports:
>
> - Emulating component registers with HDM decoders.
> - Volatile memory backend and emualtion of region access.
>
> The emulation is aimed to not tightly coupled with the current CXL type-3
> emulation since many advanced CXL type-3 emulation features are not
> implemented in a CXL type-2 device.
>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Zhi Wang <zhiwang@kernel.org>
> ---
>   MAINTAINERS                    |   1 +
>   docs/system/devices/cxl.rst    |  11 ++
>   hw/cxl/cxl-component-utils.c   |   2 +
>   hw/cxl/cxl-host.c              |  19 +-
>   hw/mem/Kconfig                 |   5 +
>   hw/mem/cxl_accel.c             | 319 +++++++++++++++++++++++++++++++++
>   hw/mem/meson.build             |   1 +
>   include/hw/cxl/cxl_component.h |   1 +
>   include/hw/cxl/cxl_device.h    |  25 +++
>   include/hw/pci/pci_ids.h       |   1 +
>   10 files changed, 382 insertions(+), 3 deletions(-)
>   create mode 100644 hw/mem/cxl_accel.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aaf0505a21..72a6a505eb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2914,6 +2914,7 @@ R: Fan Ni <fan.ni@samsung.com>
>   S: Supported
>   F: hw/cxl/
>   F: hw/mem/cxl_type3.c
> +F: hw/mem/cxl_accel.c
>   F: include/hw/cxl/
>   F: qapi/cxl.json
>   
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index 882b036f5e..13cc2417f2 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -332,6 +332,17 @@ The same volatile setup may optionally include an LSA region::
>     -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,lsa=cxl-lsa0,id=cxl-vmem0 \
>     -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
>   
> +A very simple setup with just one directly attached CXL Type 2 Volatile Memory
> +Accelerator device::
> +
> +  qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
> +  ...
> +  -object memory-backend-ram,id=vmem0,share=on,size=256M \
> +  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> +  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> +  -device cxl-accel,bus=root_port13,volatile-memdev=vmem0,id=cxl-accel0 \
> +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
> +
>   A setup suitable for 4 way interleave. Only one fixed window provided, to enable 2 way
>   interleave across 2 CXL host bridges.  Each host bridge has 2 CXL Root Ports, with
>   the CXL Type3 device directly attached (no switches).::
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 355103d165..717ef117ac 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -262,6 +262,7 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
>           write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] = 0x13ff;


You are not changing this write, but I did, based on Type3 or Type2:


-        write_msk[R_CXL_HDM_DECODER0_CTRL + i * 0x20] = 0x13ff;
+       if (type == CXL2_TYPE2_DEVICE)
+               /* Bit 12 Target Range Type 0= HDM-D or HDM-DB */
+               /* Bit 10 says memory already commited */
+               write_msk[R_CXL_HDM_DECODER0_CTRL + i * 0x20] = 0x7ff;
+       else
+               /* Bit 12 Target Range Type 1= HDM-H aka Host Only
Coherent Address Range */
+               write_msk[R_CXL_HDM_DECODER0_CTRL + i * 0x20] = 0x13ff;


It has been a while since I did work on this, but I guess I did so 
because it was needed. But maybe I'm wrong ...

Bit 10 was something I needed for emulating what we had in the real 
device, but bit 12 looks something we should set, although maybe it is 
only informative.


>           if (type == CXL2_DEVICE ||
>               type == CXL2_TYPE3_DEVICE ||
> +            type == CXL3_TYPE2_DEVICE ||
>               type == CXL2_LOGICAL_DEVICE) {
>               write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * hdm_inc] =
>                   0xf0000000;
> @@ -293,6 +294,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
>       case CXL2_UPSTREAM_PORT:
>       case CXL2_TYPE3_DEVICE:
>       case CXL2_LOGICAL_DEVICE:
> +    case CXL3_TYPE2_DEVICE:
>           /* + HDM */
>           caps = 3;
>           break;
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index e9f2543c43..e603a3f2fc 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -201,7 +201,8 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
>           return NULL;
>       }
>   
> -    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_TYPE3)) {
> +    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_TYPE3) ||
> +        object_dynamic_cast(OBJECT(d), TYPE_CXL_ACCEL)) {
>           return d;
>       }
>   
> @@ -256,7 +257,13 @@ static MemTxResult cxl_read_cfmws(void *opaque, hwaddr addr, uint64_t *data,
>           return MEMTX_ERROR;
>       }
>   
> -    return cxl_type3_read(d, addr + fw->base, data, size, attrs);
> +    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_TYPE3)) {
> +        return cxl_type3_read(d, addr + fw->base, data, size, attrs);
> +    } else if (object_dynamic_cast(OBJECT(d), TYPE_CXL_ACCEL)) {
> +        return cxl_accel_read(d, addr + fw->base, data, size, attrs);
> +    }
> +
> +    return MEMTX_ERROR;
>   }
>   
>   static MemTxResult cxl_write_cfmws(void *opaque, hwaddr addr,
> @@ -272,7 +279,13 @@ static MemTxResult cxl_write_cfmws(void *opaque, hwaddr addr,
>           return MEMTX_OK;
>       }
>   
> -    return cxl_type3_write(d, addr + fw->base, data, size, attrs);
> +    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_TYPE3)) {
> +        return cxl_type3_write(d, addr + fw->base, data, size, attrs);
> +    } else if (object_dynamic_cast(OBJECT(d), TYPE_CXL_ACCEL)) {
> +        return cxl_accel_write(d, addr + fw->base, data, size, attrs);
> +    }
> +
> +    return MEMTX_ERROR;
>   }
>   
>   const MemoryRegionOps cfmws_ops = {
> diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
> index 73c5ae8ad9..1f7d08c17d 100644
> --- a/hw/mem/Kconfig
> +++ b/hw/mem/Kconfig
> @@ -16,3 +16,8 @@ config CXL_MEM_DEVICE
>       bool
>       default y if CXL
>       select MEM_DEVICE
> +
> +config CXL_ACCEL_DEVICE
> +    bool
> +    default y if CXL
> +    select MEM_DEVICE
> diff --git a/hw/mem/cxl_accel.c b/hw/mem/cxl_accel.c
> new file mode 100644
> index 0000000000..770072126d
> --- /dev/null
> +++ b/hw/mem/cxl_accel.c
> @@ -0,0 +1,319 @@
> +/*
> + * CXL accel (type-2) device
> + *
> + * Copyright(C) 2024 NVIDIA Corporation.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. See the
> + * COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-v2-only
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qemu/error-report.h"
> +#include "hw/mem/memory-device.h"
> +#include "hw/mem/pc-dimm.h"
> +#include "hw/pci/pci.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu/range.h"
> +#include "sysemu/hostmem.h"
> +#include "sysemu/numa.h"
> +#include "hw/cxl/cxl.h"
> +#include "hw/pci/msix.h"
> +
> +static void update_dvsecs(CXLAccelDev *acceld)
> +{
> +    CXLComponentState *cxl_cstate = &acceld->cxl_cstate;
> +    uint8_t *dvsec;
> +    uint32_t range1_size_hi = 0, range1_size_lo = 0,
> +             range1_base_hi = 0, range1_base_lo = 0;
> +
> +    if (acceld->hostvmem) {
> +        range1_size_hi = acceld->hostvmem->size >> 32;
> +        range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> +                         (acceld->hostvmem->size & 0xF0000000);
> +    }
> +
> +    dvsec = (uint8_t *)&(CXLDVSECDevice){
> +        .cap = 0x1e,
> +        .ctrl = 0x2,
> +        .status2 = 0x2,
> +        .range1_size_hi = range1_size_hi,
> +        .range1_size_lo = range1_size_lo,
> +        .range1_base_hi = range1_base_hi,
> +        .range1_base_lo = range1_base_lo,
> +    };
> +    cxl_component_update_dvsec(cxl_cstate, PCIE_CXL_DEVICE_DVSEC_LENGTH,
> +                               PCIE_CXL_DEVICE_DVSEC, dvsec);
> +
> +    dvsec = (uint8_t *)&(CXLDVSECRegisterLocator){
> +        .rsvd         = 0,
> +        .reg0_base_lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
> +        .reg0_base_hi = 0,
> +    };
> +    cxl_component_update_dvsec(cxl_cstate, REG_LOC_DVSEC_LENGTH,
> +                               REG_LOC_DVSEC, dvsec);
> +
> +    dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
> +        .cap                     = 0x26, /* 68B, IO, Mem, non-MLD */
> +        .ctrl                    = 0x02, /* IO always enabled */
> +        .status                  = 0x26, /* same as capabilities */
> +        .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
> +    };
> +    cxl_component_update_dvsec(cxl_cstate, PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH,
> +                               PCIE_FLEXBUS_PORT_DVSEC, dvsec);
> +}
> +
> +static void build_dvsecs(CXLAccelDev *acceld)
> +{
> +    CXLComponentState *cxl_cstate = &acceld->cxl_cstate;
> +
> +    cxl_component_create_dvsec(cxl_cstate, CXL3_TYPE2_DEVICE,
> +                               PCIE_CXL_DEVICE_DVSEC_LENGTH,
> +                               PCIE_CXL_DEVICE_DVSEC,
> +                               PCIE_CXL31_DEVICE_DVSEC_REVID, NULL);
> +
> +    cxl_component_create_dvsec(cxl_cstate, CXL3_TYPE2_DEVICE,
> +                               REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
> +                               REG_LOC_DVSEC_REVID, NULL);
> +
> +    cxl_component_create_dvsec(cxl_cstate, CXL3_TYPE2_DEVICE,
> +                               PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH,
> +                               PCIE_FLEXBUS_PORT_DVSEC,
> +                               PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID, NULL);
> +    update_dvsecs(acceld);
> +}
> +
> +static bool cxl_accel_dpa(CXLAccelDev *acceld, hwaddr host_addr, uint64_t *dpa)
> +{
> +    return cxl_host_addr_to_dpa(&acceld->cxl_cstate, host_addr, dpa);
> +}
> +
> +static int cxl_accel_hpa_to_as_and_dpa(CXLAccelDev *acceld,
> +                                       hwaddr host_addr,
> +                                       unsigned int size,
> +                                       AddressSpace **as,
> +                                       uint64_t *dpa_offset)
> +{
> +    MemoryRegion *vmr = NULL;
> +    uint64_t vmr_size = 0;
> +
> +    if (!acceld->hostvmem) {
> +        return -ENODEV;
> +    }
> +
> +    vmr = host_memory_backend_get_memory(acceld->hostvmem);
> +    if (!vmr) {
> +        return -ENODEV;
> +    }
> +
> +    vmr_size = memory_region_size(vmr);
> +
> +    if (!cxl_accel_dpa(acceld, host_addr, dpa_offset)) {
> +        return -EINVAL;
> +    }
> +
> +    if (*dpa_offset >= vmr_size) {
> +        return -EINVAL;
> +    }
> +
> +    *as = &acceld->hostvmem_as;
> +    return 0;
> +}
> +
> +MemTxResult cxl_accel_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
> +                           unsigned size, MemTxAttrs attrs)
> +{
> +    CXLAccelDev *acceld = CXL_ACCEL(d);
> +    uint64_t dpa_offset = 0;
> +    AddressSpace *as = NULL;
> +    int res;
> +
> +    res = cxl_accel_hpa_to_as_and_dpa(acceld, host_addr, size,
> +                                      &as, &dpa_offset);
> +    if (res) {
> +        return MEMTX_ERROR;
> +    }
> +
> +    return address_space_read(as, dpa_offset, attrs, data, size);
> +}
> +
> +MemTxResult cxl_accel_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
> +                            unsigned size, MemTxAttrs attrs)
> +{
> +    CXLAccelDev *acceld = CXL_ACCEL(d);
> +    uint64_t dpa_offset = 0;
> +    AddressSpace *as = NULL;
> +    int res;
> +
> +    res = cxl_accel_hpa_to_as_and_dpa(acceld, host_addr, size,
> +                                      &as, &dpa_offset);
> +    if (res) {
> +        return MEMTX_ERROR;
> +    }
> +
> +    return address_space_write(as, dpa_offset, attrs, &data, size);
> +}
> +
> +static void clean_memory(PCIDevice *pci_dev)
> +{
> +    CXLAccelDev *acceld = CXL_ACCEL(pci_dev);
> +
> +    if (acceld->hostvmem) {
> +        address_space_destroy(&acceld->hostvmem_as);
> +    }
> +}
> +
> +static bool setup_memory(PCIDevice *pci_dev, Error **errp)
> +{
> +    CXLAccelDev *acceld = CXL_ACCEL(pci_dev);
> +
> +    if (acceld->hostvmem) {
> +        MemoryRegion *vmr;
> +        char *v_name;
> +
> +        vmr = host_memory_backend_get_memory(acceld->hostvmem);
> +        if (!vmr) {
> +            error_setg(errp, "volatile memdev must have backing device");
> +            return false;
> +        }
> +        if (host_memory_backend_is_mapped(acceld->hostvmem)) {
> +            error_setg(errp, "memory backend %s can't be used multiple times.",
> +               object_get_canonical_path_component(OBJECT(acceld->hostvmem)));
> +            return false;
> +        }
> +        memory_region_set_nonvolatile(vmr, false);
> +        memory_region_set_enabled(vmr, true);
> +        host_memory_backend_set_mapped(acceld->hostvmem, true);
> +        v_name = g_strdup("cxl-accel-dpa-vmem-space");
> +        address_space_init(&acceld->hostvmem_as, vmr, v_name);
> +        g_free(v_name);
> +    }
> +    return true;
> +}
> +
> +static void setup_cxl_regs(PCIDevice *pci_dev)
> +{
> +    CXLAccelDev *acceld = CXL_ACCEL(pci_dev);
> +    CXLComponentState *cxl_cstate = &acceld->cxl_cstate;
> +    ComponentRegisters *regs = &cxl_cstate->crb;
> +    MemoryRegion *mr = &regs->component_registers;
> +
> +    cxl_cstate->dvsec_offset = 0x100;
> +    cxl_cstate->pdev = pci_dev;
> +
> +    build_dvsecs(acceld);
> +
> +    cxl_component_register_block_init(OBJECT(pci_dev), cxl_cstate,
> +                                      TYPE_CXL_ACCEL);
> +
> +    pci_register_bar(
> +        pci_dev, CXL_COMPONENT_REG_BAR_IDX,
> +        PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64, mr);
> +}
> +
> +#define MSIX_NUM 6
> +
> +static int setup_msix(PCIDevice *pci_dev)
> +{
> +    int i, rc;
> +
> +    /* MSI(-X) Initialization */
> +    rc = msix_init_exclusive_bar(pci_dev, MSIX_NUM, 4, NULL);
> +    if (rc) {
> +        return rc;
> +    }
> +
> +    for (i = 0; i < MSIX_NUM; i++) {
> +        msix_vector_use(pci_dev, i);
> +    }
> +    return 0;
> +}
> +
> +static void cxl_accel_realize(PCIDevice *pci_dev, Error **errp)
> +{
> +    ERRP_GUARD();
> +    int rc;
> +    uint8_t *pci_conf = pci_dev->config;
> +
> +    if (!setup_memory(pci_dev, errp)) {
> +        return;
> +    }
> +
> +    pci_config_set_prog_interface(pci_conf, 0x10);
> +    pcie_endpoint_cap_init(pci_dev, 0x80);
> +
> +    setup_cxl_regs(pci_dev);
> +
> +    /* MSI(-X) Initialization */
> +    rc = setup_msix(pci_dev);
> +    if (rc) {
> +        clean_memory(pci_dev);
> +        return;
> +    }
> +}
> +
> +static void cxl_accel_exit(PCIDevice *pci_dev)
> +{
> +    clean_memory(pci_dev);
> +}
> +
> +static void cxl_accel_reset(DeviceState *dev)
> +{
> +    CXLAccelDev *acceld = CXL_ACCEL(dev);
> +    CXLComponentState *cxl_cstate = &acceld->cxl_cstate;
> +    uint32_t *reg_state = cxl_cstate->crb.cache_mem_registers;
> +    uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
> +
> +    update_dvsecs(acceld);
> +    cxl_component_register_init_common(reg_state, write_msk, CXL3_TYPE2_DEVICE);
> +}
> +
> +static Property cxl_accel_props[] = {
> +    DEFINE_PROP_LINK("volatile-memdev", CXLAccelDev, hostvmem,
> +                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void cxl_accel_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
> +
> +    pc->realize = cxl_accel_realize;
> +    pc->exit = cxl_accel_exit;
> +
> +    pc->class_id = PCI_CLASS_CXL_QEMU_ACCEL;
> +    pc->vendor_id = PCI_VENDOR_ID_INTEL;
> +    pc->device_id = 0xd94;
> +    pc->revision = 1;
> +
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +    dc->desc = "CXL Accelerator Device (Type 2)";
> +    device_class_set_legacy_reset(dc, cxl_accel_reset);
> +    device_class_set_props(dc, cxl_accel_props);
> +}
> +
> +static const TypeInfo cxl_accel_dev_info = {
> +    .name = TYPE_CXL_ACCEL,
> +    .parent = TYPE_PCI_DEVICE,
> +    .class_size = sizeof(struct CXLAccelClass),
> +    .class_init = cxl_accel_class_init,
> +    .instance_size = sizeof(CXLAccelDev),
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_CXL_DEVICE },
> +        { INTERFACE_PCIE_DEVICE },
> +        {}
> +    },
> +};
> +
> +static void cxl_accel_dev_registers(void)
> +{
> +    type_register_static(&cxl_accel_dev_info);
> +}
> +
> +type_init(cxl_accel_dev_registers);
> diff --git a/hw/mem/meson.build b/hw/mem/meson.build
> index 1c1c6da24b..36a395dbb6 100644
> --- a/hw/mem/meson.build
> +++ b/hw/mem/meson.build
> @@ -4,6 +4,7 @@ mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
>   mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
>   mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
>   mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
> +mem_ss.add(when: 'CONFIG_CXL_ACCEL_DEVICE', if_true: files('cxl_accel.c'))
>   system_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_false: files('cxl_type3_stubs.c'))
>   
>   system_ss.add(when: 'CONFIG_MEM_DEVICE', if_false: files('memory-device-stubs.c'))
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index 30fe4bfa24..0e78db26b8 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -29,6 +29,7 @@ enum reg_type {
>       CXL2_UPSTREAM_PORT,
>       CXL2_DOWNSTREAM_PORT,
>       CXL3_SWITCH_MAILBOX_CCI,
> +    CXL3_TYPE2_DEVICE,
>   };
>   
>   /*
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 561b375dc8..ac26b264da 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -630,6 +630,26 @@ struct CSWMBCCIDev {
>       CXLCCI *cci;
>   };
>   
> +struct CXLAccelDev {
> +    /* Private */
> +    PCIDevice parent_obj;
> +
> +    /* Properties */
> +    HostMemoryBackend *hostvmem;
> +
> +    /* State */
> +    AddressSpace hostvmem_as;
> +    CXLComponentState cxl_cstate;
> +};
> +
> +struct CXLAccelClass {
> +    /* Private */
> +    PCIDeviceClass parent_class;
> +};
> +
> +#define TYPE_CXL_ACCEL "cxl-accel"
> +OBJECT_DECLARE_TYPE(CXLAccelDev, CXLAccelClass, CXL_ACCEL)
> +
>   #define TYPE_CXL_SWITCH_MAILBOX_CCI "cxl-switch-mailbox-cci"
>   OBJECT_DECLARE_TYPE(CSWMBCCIDev, CSWMBCCIClass, CXL_SWITCH_MAILBOX_CCI)
>   
> @@ -638,6 +658,11 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
>   MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
>                               unsigned size, MemTxAttrs attrs);
>   
> +MemTxResult cxl_accel_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
> +                           unsigned size, MemTxAttrs attrs);
> +MemTxResult cxl_accel_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
> +                            unsigned size, MemTxAttrs attrs);
> +
>   uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
>   
>   void cxl_event_init(CXLDeviceState *cxlds, int start_msg_num);
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index f1a53fea8d..08bc469316 100644
> --- a/include/hw/pci/pci_ids.h
> +++ b/include/hw/pci/pci_ids.h
> @@ -55,6 +55,7 @@
>   #define PCI_CLASS_MEMORY_RAM             0x0500
>   #define PCI_CLASS_MEMORY_FLASH           0x0501
>   #define PCI_CLASS_MEMORY_CXL             0x0502
> +#define PCI_CLASS_CXL_QEMU_ACCEL         0x0503
>   #define PCI_CLASS_MEMORY_OTHER           0x0580
>   
>   #define PCI_BASE_CLASS_BRIDGE            0x06

