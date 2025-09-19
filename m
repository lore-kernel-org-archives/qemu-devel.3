Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8C9CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 08:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzWqX-0004aT-WC; Fri, 19 Sep 2025 04:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uzWqV-0004a0-FT; Fri, 19 Sep 2025 04:51:59 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uzWqM-0007bC-E4; Fri, 19 Sep 2025 04:51:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ooErnbxWG98fdN7WLGpXzOUi5Gt3Zd7IvxQP+QWiIg7of0bWJS1w1Pf04WULfj/p6Q0MwHuQD/i1IYAl2+e3xyBmvbylqs2kUNDx3CAHriWlHrxTXiPS4Z8zPCzqGF5k6mkv6mxJ6CUWMr6VJSMg2u5sYJavu3hjaOgfpekC3j9D6jzxHTL0tgE9h8scM6a8IfP6PZhFSxKvOpA2ilc0RNHkL+yD7U39P8pCqbaSoSnQpGRiZVjI4O3lkB95uTS0af4nrT3kiMQ+pzBiBjpDDahaTBfCm+Yzova7o/mkkcykIZ7m2WkoLfByk5wjApU7H6ucMIw2sJ8YSLiUCgcNTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHCyj1EZu+DYhZsKwqSfG6yMS59iWSI1Sa46LlZ50UA=;
 b=KptppjU75OypCbe7P49Hn7li7/TpzQ5EtuLn1K7lf28Fqj1/u5ikZnbEpMB5Nfi3XGnkhZxV4kInoDAx4Rq7lfIGPCgI07DCgJI3LGQ0zd75rAd4evOhYf18e1DVSc6nvP60q/NqB8hmEH8pOlMCj1W3btnqIDSFCiByWDL/QVHBCnlAD/LxPjLvJMblot8uJNGZ2rsnskNcwWRruZkqT993D6DyHzEaRZ+MwG1V2+ha/zBylk/mBbv+aGzLjj/cj4saHIRyZRL6ZQvwJd1LBENVEETnvukc5ASL5hmdxLTVCf090G97N9OmNp8mn6homKRyIf+/TeoTRXhgiM2PFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHCyj1EZu+DYhZsKwqSfG6yMS59iWSI1Sa46LlZ50UA=;
 b=dt/2sR2cVQAZW5+9DWhu2Wzv4h/NqbfyZ6Yo6thPOkrHMgmNd1xdd/ynEMpDKWp+9lNYbLyzA3rxQ7s5BjzKtFdDeacV6HawJyh/SiQiUcM26NVcMfFOZlsR9J8HmH3j8V5EopAHx+pyEi+li8T4dma1bHHQkX+gALq1aSQ6i4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 08:51:46 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%5]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 08:51:46 +0000
Date: Fri, 19 Sep 2025 10:51:40 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH 3/7] hw/core/register: remove the calls to
 `register_finalize_block'
Message-ID: <aM0ZnDBkFn98YuBD@xse-figlesia-l2.amd.com>
References: <20250917114450.175892-1-luc.michel@amd.com>
 <20250917114450.175892-4-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917114450.175892-4-luc.michel@amd.com>
X-ClientProxiedBy: FR4P281CA0376.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::19) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b92317-8882-4929-1a7d-08ddf759c35a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dklCS3FoWWRneDZsNDZHRXBzL08yaCtIMldZMWFYalU5V1RVWDk2MEw1TDBU?=
 =?utf-8?B?L3Y0Sk8zQXRLVXJRL2RFSkxYMnNkbThSTnhzWDlYRlR5WmdsVytaSTNNT1VG?=
 =?utf-8?B?dmcwV2svQTZQMUNHcm1qRlV3WlpsbHEyb2NTZTdwWWp2UlBNVmgrS0JKV001?=
 =?utf-8?B?amNob3ZQMjV5cnJFa3Z3aWR1ZC9BOERtbVZKN2xkUm1qYmJTR3ZRSmk5Nnhn?=
 =?utf-8?B?Nm1yVG5NSUlmNDRTUkQ5eHkvczAyTTRXVjl0aXNYRk5zTGJSb1d3T2hlS20y?=
 =?utf-8?B?SUUrMWcwWmJ5MXBjNmx1dlc3cEpObTl3NjFDUXU5ZlBnZHcyN3Z1Uy9BeEk0?=
 =?utf-8?B?a21GV0I1Z1JGYlAwRklXU3FxQ01rek5iNEQ4VENVOEZoNlpXQ3dGVGxlNVFT?=
 =?utf-8?B?U1VTU2tiT1VDejZCNzVMbmZWcDkyd052YTZ0Q2kyMDhSb0QxWEFldFNFbk9J?=
 =?utf-8?B?NG5VVUJacEpqQktRdWM4eUd0WmhjUHk1OHRUaUJhcDNKU3hScTltd3k5V2Jv?=
 =?utf-8?B?YVNiQVhRQ3Vla1E4cTNSSnRsQlJSb3dxTjBqWEJwRGc3RkZaWUxKZEZNZjJV?=
 =?utf-8?B?dlNxRFVNTng2a1NSS0FGR3E3Z1h2Q2tSVGhheE5XN0EvQ005amxrUll3UW9I?=
 =?utf-8?B?YTBWM0wvMEdWajZNT01pUjBLNnJDQ0Q2Tjk3RDRXekxieGdFbUw3UXNTQlJT?=
 =?utf-8?B?RmxzUUN0U1FMYlBGNTlCSVlhZGVXUEs1dGhuTEk2MVd6STZvelhJTnNCZS85?=
 =?utf-8?B?dzhzaEVGTkYrMlhERGZ5cTVHUERFaDFucHJpc2JwVTB4cmdwZXVnNWpJcFhq?=
 =?utf-8?B?ZVIzc09MOHBIcGNuY1RoNU1vTGpac1lDMGJSYnJMK1htQ2hZNVJsTG5ySW5X?=
 =?utf-8?B?alEvKzVFNEZLYytuc1kvc0tKMkpObldtSjVzTE1UNEhJaFdoM2dFOW9pQldl?=
 =?utf-8?B?dEtZZUVndmpxdjBrK2VsWTZlWkhYNithc2trdjRzaGUyUXBmNWszSmFLUlFG?=
 =?utf-8?B?eDduZ0habEErN1F0WmZyY0tlUHRSMVN0UTYxWDJyYW9xN2FwTEQwZ0Y2VE4w?=
 =?utf-8?B?UHNGTUVIT01NeUZPQnk4cjlLc2ZlQThJeEs0a0hrNXZ0Z0RiakN4ZmQvSk5Q?=
 =?utf-8?B?R1VqZHJVakE2cndPbFJhYXQralczcWQ3aHRRakQ1c1pYMVBzd2N3STl6L0xW?=
 =?utf-8?B?TG9VRUI0eStic2I5Q01OMWorVzBVY0dhdGh0c0FBWFh3UWlHMlpFSVJEQkVn?=
 =?utf-8?B?TlNRRnUxMGxOemxKdGwzd08rYWRjOHU1dzVudVk0Mm1aWkZ6TEhiOERWNU9I?=
 =?utf-8?B?bm0vRDVKdVI0TWg1eFViNUxpc2VHMkVSNEY4TGY0SHlmT3pENnBYajNTSUdt?=
 =?utf-8?B?TWVZbHkraVJiMC92d1BLbmRyY3dWM1RBZHN5T0xGWTFhbVpJYTRnSCs3VHQw?=
 =?utf-8?B?dFI1RHkxTlJkQXhsOWZsR05ZdXlCWVc2YXk2bU9QUGtZUVhpMHhtckJ3MWV4?=
 =?utf-8?B?cXVDWWZxRFNUMDZzSnZQUTk1MEpZTXBlSDNFTy8rcXJiQ1kxZDFLVlJrNnZL?=
 =?utf-8?B?d1hNVkNpM1I4c2RYbm1ndUZVN1F0N2RlNWhoQUdOQStiTFlrc1RrQ3E1Y1Jq?=
 =?utf-8?B?dWc4K3BmZ3FKeHZqc3lwVmEwUi9VZEJhVm5uQ3laaHJPRHFsbEhDelh4Mk1K?=
 =?utf-8?B?d1ZSNlVqY3pIS1BmbWJaakNNY2ZtbnAwd3ZWdjJ4MmI5dTl5Z3pUUXp4dkh6?=
 =?utf-8?B?MUJkc3BJU2pNK2xUZlJaU0QwSFNRSHJYV0tkUG9PSjJVSG5LYVdNdDNVbnla?=
 =?utf-8?B?ZUljdzYxd1ExYkJ6emlOQnZGTkVETlhvQ3pXQXFOSFdsQ0NoMnlWMlAxd0h5?=
 =?utf-8?B?aHNxbnIzKytxNmJQTVJGTVc5c2NUaTdsN1NjRjBoU1ZEL1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXVJeVZxOTdYUHUzaEoyWWRDYVhZYmxibWxRVFE3RGpCVjhCOHJLeEJUb3Bj?=
 =?utf-8?B?RlRaQk83SkRCcGRSQ3VNN090Y0xFNVozUVRBMmV6VHN5Tk5aVk5QdDIzWTFh?=
 =?utf-8?B?L1RuWWpVdkx2RzQzWDlWaVN3RXlOME1SK2NVamtMTkVZRisvTU4vZ2NkSENT?=
 =?utf-8?B?SXV3RWEwOGNGeUhvMmozQ1UveklHc2F4UGRjK0VXYzRqcnpHVUJkVWF5ZytJ?=
 =?utf-8?B?WmFCejBNczFJelJYTlVZNTArQ2YzY2NrQU9rNkh4c2lLempVYmJkZlFKbkYy?=
 =?utf-8?B?a1VURU1uQnBVa2FWTFBaRWxIcUJvKzBpZnRmdjYvQi9KSHlBd1hraTNzOVpn?=
 =?utf-8?B?emZlQkJFYWIwRFlRcVVPTEk3cURKZHQxa1JLRmdzdHlXbHZGYUNVYk9CMXF5?=
 =?utf-8?B?Zmt4YXRmVGYxS1U3V1hnRFBJTWxDV3VtbFkwdEFYV1JjSUwyTW02R3ZHYnUr?=
 =?utf-8?B?WG9yTFJQemhsUzc1L1MxdlIyb3RKZjVmVGpUd3NycmhoTlRaa29jdVJURVpR?=
 =?utf-8?B?TDB4Mmpvb2JjemJhVWpMUCthSW9yejRoOEVSQUo1bjIzMWlMejJCTnNtOXJS?=
 =?utf-8?B?ay9HSFByS09LdzVDdDhDZk8yWldZamFqNHJwMlJUSFRDMUtySHhhdXRaWmk3?=
 =?utf-8?B?QXJ6TEF1dlA2THlUU1I5eHBNcmJiNUEzbDA2Vlczb1huQkRTUVRmclhac2VT?=
 =?utf-8?B?cElTT0h2eEthK2twYjQ3RlBhL2F1YjNHckN1VW4rSm10T0NjbFJZYnkvTi93?=
 =?utf-8?B?M092VWwzVkZNeEFuNWNKdFhGVGZLNm1BZmlYYmxuZkQvVno3NkJNNTBOQjBm?=
 =?utf-8?B?V2xKRlhpdVZxTFhDQWljc2Vpbjk4QjAzdU9SVzN0aG9CVnJVSlBJemRVeEwx?=
 =?utf-8?B?RjYxZFF1K1p5MDZpcExLM3BDUTRaN1NkOXI1Yno0SVV2WXRjaWVmQTZMQ2k1?=
 =?utf-8?B?L0Mwc05UOGpzZnphUTRFQkdCMjk3aHdWKzJhNGhwSXJNYXFULzd3WElhMjRu?=
 =?utf-8?B?dFl0R081Z3VFNDlOWXI4VnRBcUxacEtEN1IvNW5kWCtqeE9hN3dRRXJVVVRY?=
 =?utf-8?B?VlV4bTdyT1FCbkk2eDhzbXlodU9NcnRkSkFxMUV5ODFWeHBYOUZuYTdqT1oy?=
 =?utf-8?B?M1hyQjRZZVpvcm5wZ0p1ci9NZ1RNbnA4RU50eXJtLzk0Rm5SOEZHalpEVEk2?=
 =?utf-8?B?djVqdzFhNDBUKytnQlJ4L282Z2xZVXpLTzdNU3drYllYTVk4TEVTRWd3c280?=
 =?utf-8?B?M0tsQWtDZlJveks1K0FlcW43aEJhVjlCMDRlUmFFeGJzcUJTVitkdFMwTDNI?=
 =?utf-8?B?S3RMUUhXZ2sxZWJrSG5zNWFZUTBuWGxoakNJQ0VIbHczMENnRnBMZkFJQjha?=
 =?utf-8?B?MEgvejBBdjRNZ3dzNnhSenBlT0ZBZHhFamZNRkxMMlBPd3NicVh5QkNlblUv?=
 =?utf-8?B?RDdhQzY0bzFBLzRuNUdBKzlId0o4SGxPWDhaYk1wazZOMEd2STY4d1ZkbkU2?=
 =?utf-8?B?T2RKcU1EM2xZbWNxQkxaSlFhWU1janNGNnRvSWFsaW0wcU1nbkxPbDlPY3M3?=
 =?utf-8?B?ZnBDU3ZpdUhUM0hPSVI0KzNicVl4dEpvMEtwbjhVYnpmdS9DNmI1YTFKbUpT?=
 =?utf-8?B?M3dyRzQzVC9zUERiRThlclEwOFBaVjNJa2ltWVFLTjRkTWV2b1hjWUlCUGNC?=
 =?utf-8?B?dWRvbGtTYUNzeTdyOWZaNk02RkVSdFdoZ3hZbHpWVWlNME9ISlJ4TE1mdGpB?=
 =?utf-8?B?Smw5YjJCOVkzSmhJNmhtbFd3K2dqMXRlcmdiOEtjTlY2MmV2eGpTZG9xRTdG?=
 =?utf-8?B?N1l1cFM2NldTSkpieG5UWmhOZDFxYWxzYWlIMFl4b25SbHM0VXJheFVSZUNw?=
 =?utf-8?B?R3VWRDQ5RHlTdWJDdlVmdmIrUEpuUjQ2N1AzblpFaW5TSFNBd3d0V0h2YjNU?=
 =?utf-8?B?OHB5VDR0R0lFaklvWmJkcFZETTI0RWRucHdOOW9pR2ZZSEVxNXMvcm5tb1pp?=
 =?utf-8?B?VU1sVkpBb1B1cXpEaFVXQVlYd0JjSXdEZ3I3S1dTUWZKSVJ2U1JIYkg2NWRL?=
 =?utf-8?B?WE56RzdUc1l0Zm5MajJhejl0WHZhUEcvWkZPYldMQXA0RHZhRUFRMVN4U29v?=
 =?utf-8?Q?w9R6Je/+kGs4ZP/+duld9j3gf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b92317-8882-4929-1a7d-08ddf759c35a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:51:46.0791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bymHhhTEwYSXGZLNvPu8DDiCzCSI6RiNLvO9VY/pXO4NlM/2mclHy/ZkUUFDf/nDkfq5Z514PbwJrW6Xvaa4zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=francisco.iglesias@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 17, 2025 at 01:44:44PM +0200, Luc Michel wrote:
> This function is now a no-op. The register array is parented to the
> device and get finalized when the device is.
> 
> Drop all the calls to `register_finalize_block'. Drop the
> RegisterInfoArray reference when it is not used elsewhere in the device.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> ---
>  include/hw/misc/xlnx-versal-crl.h      |  1 -
>  include/hw/misc/xlnx-versal-xramc.h    |  1 -
>  include/hw/misc/xlnx-zynqmp-apu-ctrl.h |  1 -
>  include/hw/misc/xlnx-zynqmp-crf.h      |  1 -
>  include/hw/nvram/xlnx-bbram.h          |  1 -
>  hw/misc/xlnx-versal-crl.c              | 38 +++++++++++---------------
>  hw/misc/xlnx-versal-trng.c             |  1 -
>  hw/misc/xlnx-versal-xramc.c            | 12 ++------
>  hw/misc/xlnx-zynqmp-apu-ctrl.c         | 12 ++------
>  hw/misc/xlnx-zynqmp-crf.c              | 12 ++------
>  hw/nvram/xlnx-bbram.c                  | 13 ++-------
>  hw/nvram/xlnx-versal-efuse-ctrl.c      |  1 -
>  hw/nvram/xlnx-zynqmp-efuse.c           |  8 ------
>  13 files changed, 28 insertions(+), 74 deletions(-)
> 
> diff --git a/include/hw/misc/xlnx-versal-crl.h b/include/hw/misc/xlnx-versal-crl.h
> index f6b8694ebea..49ed500acde 100644
> --- a/include/hw/misc/xlnx-versal-crl.h
> +++ b/include/hw/misc/xlnx-versal-crl.h
> @@ -531,11 +531,10 @@ REG32(VERSAL2_RST_OCM, 0x3d8)
>  #define VERSAL2_CRL_R_MAX (R_VERSAL2_RST_OCM + 1)
>  
>  struct XlnxVersalCRLBase {
>      SysBusDevice parent_obj;
>  
> -    RegisterInfoArray *reg_array;
>      uint32_t *regs;
>  };
>  
>  struct XlnxVersalCRLBaseClass {
>      SysBusDeviceClass parent_class;
> diff --git a/include/hw/misc/xlnx-versal-xramc.h b/include/hw/misc/xlnx-versal-xramc.h
> index d3d1862676f..35e4e8b91dd 100644
> --- a/include/hw/misc/xlnx-versal-xramc.h
> +++ b/include/hw/misc/xlnx-versal-xramc.h
> @@ -88,10 +88,9 @@ typedef struct XlnxXramCtrl {
>      struct {
>          uint64_t size;
>          unsigned int encoded_size;
>      } cfg;
>  
> -    RegisterInfoArray *reg_array;
>      uint32_t regs[XRAM_CTRL_R_MAX];
>      RegisterInfo regs_info[XRAM_CTRL_R_MAX];
>  } XlnxXramCtrl;
>  #endif
> diff --git a/include/hw/misc/xlnx-zynqmp-apu-ctrl.h b/include/hw/misc/xlnx-zynqmp-apu-ctrl.h
> index c3bf3c1583b..fbfe34aa7e5 100644
> --- a/include/hw/misc/xlnx-zynqmp-apu-ctrl.h
> +++ b/include/hw/misc/xlnx-zynqmp-apu-ctrl.h
> @@ -83,11 +83,10 @@ struct XlnxZynqMPAPUCtrl {
>      qemu_irq irq_imr;
>  
>      uint8_t cpu_pwrdwn_req;
>      uint8_t cpu_in_wfi;
>  
> -    RegisterInfoArray *reg_array;
>      uint32_t regs[APU_R_MAX];
>      RegisterInfo regs_info[APU_R_MAX];
>  };
>  
>  #endif
> diff --git a/include/hw/misc/xlnx-zynqmp-crf.h b/include/hw/misc/xlnx-zynqmp-crf.h
> index 02ef0bdeeee..c746ae10397 100644
> --- a/include/hw/misc/xlnx-zynqmp-crf.h
> +++ b/include/hw/misc/xlnx-zynqmp-crf.h
> @@ -201,11 +201,10 @@ REG32(RST_DDR_SS, 0x108)
>  struct XlnxZynqMPCRF {
>      SysBusDevice parent_obj;
>      MemoryRegion iomem;
>      qemu_irq irq_ir;
>  
> -    RegisterInfoArray *reg_array;
>      uint32_t regs[CRF_R_MAX];
>      RegisterInfo regs_info[CRF_R_MAX];
>  };
>  
>  #endif
> diff --git a/include/hw/nvram/xlnx-bbram.h b/include/hw/nvram/xlnx-bbram.h
> index 58acbe9f51b..af90900bfc6 100644
> --- a/include/hw/nvram/xlnx-bbram.h
> +++ b/include/hw/nvram/xlnx-bbram.h
> @@ -45,11 +45,10 @@ struct XlnxBBRam {
>  
>      uint32_t crc_zpads;
>      bool bbram8_wo;
>      bool blk_ro;
>  
> -    RegisterInfoArray *reg_array;
>      uint32_t regs[RMAX_XLNX_BBRAM];
>      RegisterInfo regs_info[RMAX_XLNX_BBRAM];
>  };
>  
>  #endif
> diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
> index 10e6af002ba..5987f32c716 100644
> --- a/hw/misc/xlnx-versal-crl.c
> +++ b/hw/misc/xlnx-versal-crl.c
> @@ -632,21 +632,21 @@ static const MemoryRegionOps crl_ops = {
>  static void versal_crl_init(Object *obj)
>  {
>      XlnxVersalCRL *s = XLNX_VERSAL_CRL(obj);
>      XlnxVersalCRLBase *xvcb = XLNX_VERSAL_CRL_BASE(obj);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    RegisterInfoArray *reg_array;
>      int i;
>  
> -    xvcb->reg_array =
> -        register_init_block32(DEVICE(obj), crl_regs_info,
> -                              ARRAY_SIZE(crl_regs_info),
> -                              s->regs_info, s->regs,
> -                              &crl_ops,
> -                              XLNX_VERSAL_CRL_ERR_DEBUG,
> -                              CRL_R_MAX * 4);
> +    reg_array = register_init_block32(DEVICE(obj), crl_regs_info,
> +                                      ARRAY_SIZE(crl_regs_info),
> +                                      s->regs_info, s->regs,
> +                                      &crl_ops,
> +                                      XLNX_VERSAL_CRL_ERR_DEBUG,
> +                                      CRL_R_MAX * 4);
>      xvcb->regs = s->regs;
> -    sysbus_init_mmio(sbd, &xvcb->reg_array->mem);
> +    sysbus_init_mmio(sbd, &reg_array->mem);
>      sysbus_init_irq(sbd, &s->irq);
>  
>      for (i = 0; i < ARRAY_SIZE(s->cfg.rpu); ++i) {
>          object_property_add_link(obj, "rpu[*]", TYPE_ARM_CPU,
>                                   (Object **)&s->cfg.rpu[i],
> @@ -686,21 +686,22 @@ static void versal_crl_init(Object *obj)
>  static void versal2_crl_init(Object *obj)
>  {
>      XlnxVersal2CRL *s = XLNX_VERSAL2_CRL(obj);
>      XlnxVersalCRLBase *xvcb = XLNX_VERSAL_CRL_BASE(obj);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    RegisterInfoArray *reg_array;
>      size_t i;
>  
> -    xvcb->reg_array = register_init_block32(DEVICE(obj), versal2_crl_regs_info,
> -                                            ARRAY_SIZE(versal2_crl_regs_info),
> -                                            s->regs_info, s->regs,
> -                                            &crl_ops,
> -                                            XLNX_VERSAL_CRL_ERR_DEBUG,
> -                                            VERSAL2_CRL_R_MAX * 4);
> +    reg_array = register_init_block32(DEVICE(obj), versal2_crl_regs_info,
> +                                      ARRAY_SIZE(versal2_crl_regs_info),
> +                                      s->regs_info, s->regs,
> +                                      &crl_ops,
> +                                      XLNX_VERSAL_CRL_ERR_DEBUG,
> +                                      VERSAL2_CRL_R_MAX * 4);
>      xvcb->regs = s->regs;
>  
> -    sysbus_init_mmio(sbd, &xvcb->reg_array->mem);
> +    sysbus_init_mmio(sbd, &reg_array->mem);
>  
>      for (i = 0; i < ARRAY_SIZE(s->cfg.rpu); ++i) {
>          object_property_add_link(obj, "rpu[*]", TYPE_ARM_CPU,
>                                   (Object **)&s->cfg.rpu[i],
>                                   qdev_prop_allow_set_link_before_realize,
> @@ -748,16 +749,10 @@ static void versal2_crl_init(Object *obj)
>                                   qdev_prop_allow_set_link_before_realize,
>                                   OBJ_PROP_LINK_STRONG);
>      }
>  }
>  
> -static void crl_finalize(Object *obj)
> -{
> -    XlnxVersalCRLBase *s = XLNX_VERSAL_CRL_BASE(obj);
> -    register_finalize_block(s->reg_array);
> -}
> -
>  static const VMStateDescription vmstate_versal_crl = {
>      .name = TYPE_XLNX_VERSAL_CRL,
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (const VMStateField[]) {
> @@ -802,11 +797,10 @@ static void versal2_crl_class_init(ObjectClass *klass, const void *data)
>  static const TypeInfo crl_base_info = {
>      .name          = TYPE_XLNX_VERSAL_CRL_BASE,
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(XlnxVersalCRLBase),
>      .class_size    = sizeof(XlnxVersalCRLBaseClass),
> -    .instance_finalize = crl_finalize,
>      .abstract      = true,
>  };
>  
>  static const TypeInfo versal_crl_info = {
>      .name          = TYPE_XLNX_VERSAL_CRL,
> diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
> index f34dd3ef352..2b573a45bdb 100644
> --- a/hw/misc/xlnx-versal-trng.c
> +++ b/hw/misc/xlnx-versal-trng.c
> @@ -625,11 +625,10 @@ static void trng_init(Object *obj)
>  
>  static void trng_finalize(Object *obj)
>  {
>      XlnxVersalTRng *s = XLNX_VERSAL_TRNG(obj);
>  
> -    register_finalize_block(s->reg_array);
>      g_rand_free(s->prng);
>      s->prng = NULL;
>  }
>  
>  static void trng_reset_hold(Object *obj, ResetType type)
> diff --git a/hw/misc/xlnx-versal-xramc.c b/hw/misc/xlnx-versal-xramc.c
> index 07370b80c0d..d90f3e87c74 100644
> --- a/hw/misc/xlnx-versal-xramc.c
> +++ b/hw/misc/xlnx-versal-xramc.c
> @@ -188,28 +188,23 @@ static void xram_ctrl_realize(DeviceState *dev, Error **errp)
>  
>  static void xram_ctrl_init(Object *obj)
>  {
>      XlnxXramCtrl *s = XLNX_XRAM_CTRL(obj);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    RegisterInfoArray *reg_array;
>  
> -    s->reg_array =
> +    reg_array =
>          register_init_block32(DEVICE(obj), xram_ctrl_regs_info,
>                                ARRAY_SIZE(xram_ctrl_regs_info),
>                                s->regs_info, s->regs,
>                                &xram_ctrl_ops,
>                                XLNX_XRAM_CTRL_ERR_DEBUG,
>                                XRAM_CTRL_R_MAX * 4);
> -    sysbus_init_mmio(sbd, &s->reg_array->mem);
> +    sysbus_init_mmio(sbd, &reg_array->mem);
>      sysbus_init_irq(sbd, &s->irq);
>  }
>  
> -static void xram_ctrl_finalize(Object *obj)
> -{
> -    XlnxXramCtrl *s = XLNX_XRAM_CTRL(obj);
> -    register_finalize_block(s->reg_array);
> -}
> -
>  static const VMStateDescription vmstate_xram_ctrl = {
>      .name = TYPE_XLNX_XRAM_CTRL,
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (const VMStateField[]) {
> @@ -239,11 +234,10 @@ static const TypeInfo xram_ctrl_info = {
>      .name              = TYPE_XLNX_XRAM_CTRL,
>      .parent            = TYPE_SYS_BUS_DEVICE,
>      .instance_size     = sizeof(XlnxXramCtrl),
>      .class_init        = xram_ctrl_class_init,
>      .instance_init     = xram_ctrl_init,
> -    .instance_finalize = xram_ctrl_finalize,
>  };
>  
>  static void xram_ctrl_register_types(void)
>  {
>      type_register_static(&xram_ctrl_info);
> diff --git a/hw/misc/xlnx-zynqmp-apu-ctrl.c b/hw/misc/xlnx-zynqmp-apu-ctrl.c
> index e85da32d99c..08777496d56 100644
> --- a/hw/misc/xlnx-zynqmp-apu-ctrl.c
> +++ b/hw/misc/xlnx-zynqmp-apu-ctrl.c
> @@ -177,20 +177,21 @@ static void zynqmp_apu_handle_wfi(void *opaque, int irq, int level)
>  }
>  
>  static void zynqmp_apu_init(Object *obj)
>  {
>      XlnxZynqMPAPUCtrl *s = XLNX_ZYNQMP_APU_CTRL(obj);
> +    RegisterInfoArray *reg_array;
>      int i;
>  
> -    s->reg_array =
> +    reg_array =
>          register_init_block32(DEVICE(obj), zynqmp_apu_regs_info,
>                                ARRAY_SIZE(zynqmp_apu_regs_info),
>                                s->regs_info, s->regs,
>                                &zynqmp_apu_ops,
>                                XILINX_ZYNQMP_APU_ERR_DEBUG,
>                                APU_R_MAX * 4);
> -    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->reg_array->mem);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &reg_array->mem);
>      sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq_imr);
>  
>      for (i = 0; i < APU_MAX_CPU; ++i) {
>          g_autofree gchar *prop_name = g_strdup_printf("cpu%d", i);
>          object_property_add_link(obj, prop_name, TYPE_ARM_CPU,
> @@ -206,16 +207,10 @@ static void zynqmp_apu_init(Object *obj)
>                               "CPU_POWER_STATUS", 4);
>      /* wfi_in is used as input from CPUs as wfi request. */
>      qdev_init_gpio_in_named(DEVICE(obj), zynqmp_apu_handle_wfi, "wfi_in", 4);
>  }
>  
> -static void zynqmp_apu_finalize(Object *obj)
> -{
> -    XlnxZynqMPAPUCtrl *s = XLNX_ZYNQMP_APU_CTRL(obj);
> -    register_finalize_block(s->reg_array);
> -}
> -
>  static const VMStateDescription vmstate_zynqmp_apu = {
>      .name = TYPE_XLNX_ZYNQMP_APU_CTRL,
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (const VMStateField[]) {
> @@ -239,11 +234,10 @@ static const TypeInfo zynqmp_apu_info = {
>      .name              = TYPE_XLNX_ZYNQMP_APU_CTRL,
>      .parent            = TYPE_SYS_BUS_DEVICE,
>      .instance_size     = sizeof(XlnxZynqMPAPUCtrl),
>      .class_init        = zynqmp_apu_class_init,
>      .instance_init     = zynqmp_apu_init,
> -    .instance_finalize = zynqmp_apu_finalize,
>  };
>  
>  static void zynqmp_apu_register_types(void)
>  {
>      type_register_static(&zynqmp_apu_info);
> diff --git a/hw/misc/xlnx-zynqmp-crf.c b/hw/misc/xlnx-zynqmp-crf.c
> index cccca0e814e..d9c1bd50e4f 100644
> --- a/hw/misc/xlnx-zynqmp-crf.c
> +++ b/hw/misc/xlnx-zynqmp-crf.c
> @@ -209,28 +209,23 @@ static const MemoryRegionOps crf_ops = {
>  
>  static void crf_init(Object *obj)
>  {
>      XlnxZynqMPCRF *s = XLNX_ZYNQMP_CRF(obj);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    RegisterInfoArray *reg_array;
>  
> -    s->reg_array =
> +    reg_array =
>          register_init_block32(DEVICE(obj), crf_regs_info,
>                                ARRAY_SIZE(crf_regs_info),
>                                s->regs_info, s->regs,
>                                &crf_ops,
>                                XLNX_ZYNQMP_CRF_ERR_DEBUG,
>                                CRF_R_MAX * 4);
> -    sysbus_init_mmio(sbd, &s->reg_array->mem);
> +    sysbus_init_mmio(sbd, &reg_array->mem);
>      sysbus_init_irq(sbd, &s->irq_ir);
>  }
>  
> -static void crf_finalize(Object *obj)
> -{
> -    XlnxZynqMPCRF *s = XLNX_ZYNQMP_CRF(obj);
> -    register_finalize_block(s->reg_array);
> -}
> -
>  static const VMStateDescription vmstate_crf = {
>      .name = TYPE_XLNX_ZYNQMP_CRF,
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (const VMStateField[]) {
> @@ -253,11 +248,10 @@ static const TypeInfo crf_info = {
>      .name              = TYPE_XLNX_ZYNQMP_CRF,
>      .parent            = TYPE_SYS_BUS_DEVICE,
>      .instance_size     = sizeof(XlnxZynqMPCRF),
>      .class_init        = crf_class_init,
>      .instance_init     = crf_init,
> -    .instance_finalize = crf_finalize,
>  };
>  
>  static void crf_register_types(void)
>  {
>      type_register_static(&crf_info);
> diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
> index 5702bb3f310..22aefbc240d 100644
> --- a/hw/nvram/xlnx-bbram.c
> +++ b/hw/nvram/xlnx-bbram.c
> @@ -454,30 +454,24 @@ static void bbram_ctrl_realize(DeviceState *dev, Error **errp)
>  
>  static void bbram_ctrl_init(Object *obj)
>  {
>      XlnxBBRam *s = XLNX_BBRAM(obj);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    RegisterInfoArray *reg_array;
>  
> -    s->reg_array =
> +    reg_array =
>          register_init_block32(DEVICE(obj), bbram_ctrl_regs_info,
>                                ARRAY_SIZE(bbram_ctrl_regs_info),
>                                s->regs_info, s->regs,
>                                &bbram_ctrl_ops,
>                                XLNX_BBRAM_ERR_DEBUG,
>                                R_MAX * 4);
>  
> -    sysbus_init_mmio(sbd, &s->reg_array->mem);
> +    sysbus_init_mmio(sbd, &reg_array->mem);
>      sysbus_init_irq(sbd, &s->irq_bbram);
>  }
>  
> -static void bbram_ctrl_finalize(Object *obj)
> -{
> -    XlnxBBRam *s = XLNX_BBRAM(obj);
> -
> -    register_finalize_block(s->reg_array);
> -}
> -
>  static void bbram_prop_set_drive(Object *obj, Visitor *v, const char *name,
>                                   void *opaque, Error **errp)
>  {
>      DeviceState *dev = DEVICE(obj);
>  
> @@ -540,11 +534,10 @@ static const TypeInfo bbram_ctrl_info = {
>      .name          = TYPE_XLNX_BBRAM,
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(XlnxBBRam),
>      .class_init    = bbram_ctrl_class_init,
>      .instance_init = bbram_ctrl_init,
> -    .instance_finalize = bbram_ctrl_finalize,
>  };
>  
>  static void bbram_ctrl_register_types(void)
>  {
>      type_register_static(&bbram_ctrl_info);
> diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
> index 90962198008..6f17f32a0c3 100644
> --- a/hw/nvram/xlnx-versal-efuse-ctrl.c
> +++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
> @@ -726,11 +726,10 @@ static void efuse_ctrl_init(Object *obj)
>  
>  static void efuse_ctrl_finalize(Object *obj)
>  {
>      XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(obj);
>  
> -    register_finalize_block(s->reg_array);
>      g_free(s->extra_pg0_lock_spec);
>  }
>  
>  static const VMStateDescription vmstate_efuse_ctrl = {
>      .name = TYPE_XLNX_VERSAL_EFUSE_CTRL,
> diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
> index 5a218c32e84..ce35bb0cc1f 100644
> --- a/hw/nvram/xlnx-zynqmp-efuse.c
> +++ b/hw/nvram/xlnx-zynqmp-efuse.c
> @@ -814,17 +814,10 @@ static void zynqmp_efuse_init(Object *obj)
>  
>      sysbus_init_mmio(sbd, &s->reg_array->mem);
>      sysbus_init_irq(sbd, &s->irq);
>  }
>  
> -static void zynqmp_efuse_finalize(Object *obj)
> -{
> -    XlnxZynqMPEFuse *s = XLNX_ZYNQMP_EFUSE(obj);
> -
> -    register_finalize_block(s->reg_array);
> -}
> -
>  static const VMStateDescription vmstate_efuse = {
>      .name = TYPE_XLNX_ZYNQMP_EFUSE,
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (const VMStateField[]) {
> @@ -855,11 +848,10 @@ static const TypeInfo efuse_info = {
>      .name          = TYPE_XLNX_ZYNQMP_EFUSE,
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(XlnxZynqMPEFuse),
>      .class_init    = zynqmp_efuse_class_init,
>      .instance_init = zynqmp_efuse_init,
> -    .instance_finalize = zynqmp_efuse_finalize,
>  };
>  
>  static void efuse_register_types(void)
>  {
>      type_register_static(&efuse_info);
> -- 
> 2.50.1
> 

