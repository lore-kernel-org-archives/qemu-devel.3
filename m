Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A61CFD30C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 10:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szCZU-0005IG-7W; Fri, 11 Oct 2024 06:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1szCZS-0005I7-Df
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 06:08:30 -0400
Received: from mail-co1nam11on2055.outbound.protection.outlook.com
 ([40.107.220.55] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1szCZN-00081N-Nv
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 06:08:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1I24LDYZC2XG5oA6z5gohYKBMjpujatQ3ffZSXb3ynesBoaF0G/NK/xkHYPNhBNHXEq3xw10ec7JTD/F/xQvhLaZUs8yMST1Kxd3Xqg2aTop9ChGIrHRPcsRSx5Yay+WJhFyqwfMmjPAX9VY7CexqhHxGO1EuirLjlW21fEmWzR440NQ/Y9ilmECsI7Mk9lSsKATb+F6iab+96gOH8m5z0FuePl3oeTV4PTKlu+M507Oruj8XbyNrMmsvcWDgNxvCWmn90+xK3zzsZQ3aaRWjGB5isKQ3eT6arOhqMRIw2KA36rlAjfM57cyhSjIqBHSmkVfPffDyqJR2pxQz2fCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85v01MAxjgxk89pSgOyeYvGpSiw5VcbM8ggP/p6PXTg=;
 b=EhMcsgV887UQVo/3Gg00lYEYIxraNGRDaDFycZSwL86Rrj7JUY2+gVeO4M4XSKH5Q7gxU1fexl9FECJyw35TVBOksX09MJYBeUo3B9UvsD+aQPRl40wjgX0648LBKSCBrzVHV+lnVYt/hqomswJSnxq2i/fizeEu//T9iucEdW9r5VJaNrtBMHQ8icRliSaKDyIl30S1PlGMfHXhxIq7S8BrNSS962kFiwPIkYYyEG4vUiWXEny+wSDqTsYsxNMAmZu1v3YAlnaufbq7ieaJYtFL0Mut+wQ7xPYw0GsAlgMnMoy3+PdFL3kzb8csBMU0+vezBJEQZALikXichq3iTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85v01MAxjgxk89pSgOyeYvGpSiw5VcbM8ggP/p6PXTg=;
 b=VHxlvSjEZxjqFXKDAuKHDo7xHfvY36o6vmsNHmyVhV9TguHAFQIM5U9kr4kGZNUizFnywCxULoy35KidWXx9yWYGGps0eL/FlD02Ncgq+ZgcYOMZ4E871C9Fvl4QEYrqhlshb4rmTv3wrUDf/DCzPHhwjlvwVrDeb0qGyeZ67QA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 10:03:18 +0000
Received: from IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48]) by IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48%6]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 10:03:18 +0000
Message-ID: <a6066901-f4e1-c710-9935-a2a34cb97955@amd.com>
Date: Fri, 11 Oct 2024 12:03:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] accel/kvm: check for KVM_CAP_READONLY_MEM on VM
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Tom Dohrmann <erbse.13@gmx.de>
References: <20241011085044.19004-1-pbonzini@redhat.com>
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20241011085044.19004-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::15) To IA1PR12MB8189.namprd12.prod.outlook.com
 (2603:10b6:208:3f0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8189:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c524a2d-5026-46db-fb6b-08dce9dbee42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVJHRkV5c1dnZlUxd2NWSE5QTlZCQnFqVXB2WjdCeGh3ZndoQzJwOG4vUXpW?=
 =?utf-8?B?NTNBUTY2dXhoZmwwYjdISGV6d3JVS08vUTJHV09GNFp5clZGTVcyZDRDeDhU?=
 =?utf-8?B?ejBXcTFEUW5GQndEb3FDUlh1TUR3cFI4M0VmSXVOTGgrbWw5NWVtb3lUNlFs?=
 =?utf-8?B?bXRJcHRBVDZnWHVmQmJjV0FEUUZQQTVnTkdmYk5rUUUwUXMxaUZNWlh2WE4r?=
 =?utf-8?B?NnU4bXh5RHdPNXhqRmJ6b1ZuVzBFWEhNU3F2eXMyUmZQNzBhb0xlTWE5aStx?=
 =?utf-8?B?bWJXemxoR1UxS2JGbVduQUpSZmRLa0x2YkRGcXpWME1Fd203QzN5bS84cTd3?=
 =?utf-8?B?UFBLd3pwK1NHQnF0TitTc3h6UFhXUGM4akR0TkNYSVllRDFmNUJOSCtPR0JX?=
 =?utf-8?B?QWN0Q2p3RjIvVk5SRndDUEZ5YXdIelA5emZJYVBSK2kxbkZuTEpkdDNYTTZJ?=
 =?utf-8?B?NEM2bnUxWkU4enJLbnRkbFZVUEZseEZ5clE3OVlwWWNnOXJKa3pvUGNtdm1j?=
 =?utf-8?B?bGwrc3I1b29KTlhqK29MWitDR3gyVEl0aGF4Mi84YUJHMlFGdUFhaUI0a2hP?=
 =?utf-8?B?NjFhem80UkxPSnV5bER4WlJwVnMwUlZjaEtmcVFTNlNOYXkraFo2anpKc2Uy?=
 =?utf-8?B?akdMYnVlNWdIRWRLM1pQOExacENBaWlSRUpDZEdld3krZnlFQ3ZXWkhGWDN6?=
 =?utf-8?B?SEswSE1acnpiOERmSVowZnpnYlduNmdMd09IbjhaRVNDOFowc01rM1p6Qkty?=
 =?utf-8?B?VWtmY3hQY2UvRUNnVzIrVmVsOXQxbXduVEdySDllNmhwc2JpQXZiQ1F1cTd0?=
 =?utf-8?B?MTIvTURBQmYwM29Zei9Fd1EwSlE0Wk9RclhjdG1qRm45UUFTbjIwVDV4UWJx?=
 =?utf-8?B?WU1Kbmd3L3puYmRYVUhVYU5pVEdBU1M0NnNQRXFwc1I0bjBYelY0RXhyV2Yv?=
 =?utf-8?B?ME1WVkR0MW4xUGJWRHI4SzJnUDVEbkNaNXJEMmszRHd5Rjd5dEp3ZkJkbXdR?=
 =?utf-8?B?eHQzTEdRdVAwQVd4ZFlHZ1NKSy83MlBRQ3ZDRXZvSmlUdDJscTNRNUF1WGYz?=
 =?utf-8?B?T2FoUDNhNG9kQmtva2ZGdllra0NKS3VUUnpyUkkrTW1ld2FhTzhHNENENW41?=
 =?utf-8?B?dzVNRXRxWTQxSklESEorTmF3ZFF2Wkc1T2UrKzdaYytjc1NoUXljMlJNOFU5?=
 =?utf-8?B?c1dQSlE5elk3L0ZPbWpkVDZ4WXRxdEIxS1VTSFJnQUxaRnZaQlZyM1JxSjc3?=
 =?utf-8?B?dzNONisrbFhMZ2drckdNM3RoSVpESDRmOHNhQjc2V05hRGJLSGl5a1ZyL0wr?=
 =?utf-8?B?U2ttcWVmRExESlp3OUhjMEpqRnpLeDFjUTdZUjFTZjVXNEdMMlp2NlNqS1Vk?=
 =?utf-8?B?dEZ2RUUwbGJnMGpwRGJnT2ZKMkEvcnJYSWFqT1l5NzFpUkVJcWhITjNqcmxQ?=
 =?utf-8?B?a2xMQkpFbThXSFJFMytTalowUzZ6MkhqbE1jWEdtWWRlY3RjN1U4S1lIRnpE?=
 =?utf-8?B?UWNxaWZpWERqbVlLWXU2OGdISUQrdzk0dGFwenJNSlRnYmxCOEcvVTZXbEZ5?=
 =?utf-8?B?SlRuV1BTazZoQXUwdzYxdSsvbTQxQ1VyRkQzS1Vzdkw0Ui9tdnpZa0JoajJy?=
 =?utf-8?B?YXM4Mm5YWUJDOE82QVpzWGRjeWNTRG41L25PMkFnY1NQcTJIcDdRSTRNQklH?=
 =?utf-8?B?ZVlSZG5PeCtHSGhUSUQ0bzVPNHhpOC9mY2Q1ZStIRVJJMzQvclBtU3RON1Fx?=
 =?utf-8?Q?qoi8WfN2XA6a1bRGjU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFB2UGpXYzZSckVLS25YMk1sTnRXeUV4cG9hWG81dDBYViszblRQRWsyeTQ3?=
 =?utf-8?B?VUZ5U1VCMTBRMzdVWjNtVWpJK2R0Zzh0U1Z2Q0dSQ1FzVUE3ZHdTTElmTUFy?=
 =?utf-8?B?aDI4QjNMUGNBRlpObmRUczljUStlTWFYNHZhZUNKWWt4Z2QxU2VIQ1RGazZj?=
 =?utf-8?B?ekVONlZSQjZVT24rSW4xNjYrdjNCVElVQU1Fc2VUZGhiMFVHSjNGbjBZZjdO?=
 =?utf-8?B?Z2ozTTU1aVQraHJaVTZNbkRJVHZWdjF4Q3hXUnhKRGRMUENhaWtLQWtKelhB?=
 =?utf-8?B?UzhxZWFTS2hsOG9kc09KOEliWjVXVmwzeENFOFRxRTBxTTJCNm52dzhXQlpL?=
 =?utf-8?B?M3FTV1BuL1BONVFYVy9Sa1BJd216U0ZQaUhEYi9rcVZ1R0tqUEVPY1E4amdF?=
 =?utf-8?B?MEw3cENiWWsrQ3pFbnQ1VUJsT3R2M0x0UFFHSXpuWjlqcU5JMWo0SzgvUHhG?=
 =?utf-8?B?dXpoVG05d2FWMVU1ZU8xWXZBejRqaDdVamhsUnduWjlHOUpuZyt3V0E4VXZt?=
 =?utf-8?B?cG1YT2htckNySHk3SWtEVW4wei96UHNLS09kZ2FTNExXWWdnZmhqL25XbWlk?=
 =?utf-8?B?QVR0VUdGMWc1U2g0TTl1aVNUYjg5T3I0REZBMC8xK2IxLytBbWNIdWFxeFhI?=
 =?utf-8?B?enJ5eXgzVEIxY0Zua2NEODlvR25ZMUp4c0dpL05sUlZNelBmK2dZbkxJYVdj?=
 =?utf-8?B?eUtoY0lMN1gvSC9uMnBIa2xQNVhUL1FkcG8yODRHTURIWDJaL0R4RkJIb2xr?=
 =?utf-8?B?RDVob3V5NE9Hb1VKQXR5Z3M2eUhuLzl0WkM3VWVuc2xoUW91NU9KQXFzdGhT?=
 =?utf-8?B?RTc2YWthWG96U3lzOURRZCsvbVAyM3FYNUNFN2ZTeEhJR0pUby9SNWhTVEVY?=
 =?utf-8?B?cFBXdU53Nm1pMmRTMVloZjRscVZGTGNhKzJzcXpiL1RzWUtra01QdGEyY1dJ?=
 =?utf-8?B?SHluTnZ4TVBaZkdsR2ZjNFNwL3N4TkljOWM1K3BDTnJzbURoSVJoTnBNYzRx?=
 =?utf-8?B?dmdUazdnSmh5QkxkOXpZMFhMTFhNZmRPYXhTS2xPNTBQU0FOcHV6b1d3Qy9s?=
 =?utf-8?B?UUx5MkZhRGcrVEpYL2RZbXJMUEhCZlhJWWhxOG12Q3pUMWtXS01Gc3haU05C?=
 =?utf-8?B?Z3lXcWh1Umt2N2t5SjRocXM2aE82c0lWbWJRdlF4TmpCSWZXaFhGaWlUY1ov?=
 =?utf-8?B?a1A1Y3VGWThKZDU0aStIY1FvUHhkcEltTEpmYXdlVmpuK3VGSHEweVlOM3pq?=
 =?utf-8?B?ckVuZlM2amVzOXIwbExvV3d5TGo5LzkwaGpmMkM1U3RlZFB4MGI3Zjc1d0FZ?=
 =?utf-8?B?aXZVOTh2ZEM1dzFkWHN1SEwxd1FOQXJsZmxMZ3RkZEh0SU1zaDlLTFl6L0Nl?=
 =?utf-8?B?aXVNYUhZWXJyOFNTUnVSZ2NpdHFRQXRhV292R1ZHZDJwTHNkZ0d3L3MwQmtn?=
 =?utf-8?B?a2VDbHJIdEh6Y1hRMHFuZnA1bFU1NWdmUmpuNnRQMExLNHRvRm9QRUdjR25l?=
 =?utf-8?B?c3BkaEkwUEJaTldlNjFLSEhBcUtsakVkS1dPTU9KUFZOKzBhbC9HWGVWcjVv?=
 =?utf-8?B?Mnc1SEEwNHp1UW5DTHVGOXREaUdUcnJrc3RlbmZqMVdZU1FYTEYyL1Z6K29u?=
 =?utf-8?B?emh1c2NIckpTVkJkMWlhVzdxa2JqYnVEdmNxVk01SHR3ZzJocVlLU2Qwd2ll?=
 =?utf-8?B?dHgwaTl6eW9kMTd3MXNwM0dVMTNXMFAyaDRwdjRhUk80NWs5R05kNlpiY29E?=
 =?utf-8?B?TmNUZldqekxGaGpYdmhNbUdyaXRiVjUySGVlT2MzZ1plazAyV3FXYlViWFkx?=
 =?utf-8?B?eWdlUFo3Qmt0ZlJDZXdTSzZPU3ZSczQ4eVZieWt6ZmFQalBkRnBkMUVyTFN0?=
 =?utf-8?B?NmxVdnp5NGJTYlgrOGw4bmV1ZlZPVFFFOVgwMkRNYUU5WDE0d0V3alV5MTh6?=
 =?utf-8?B?dm5pdTdYdU5qTjhVOGdSNWZtRmxqdHN1QnNocGNBRHprOUNjSnFqRUxFWWd2?=
 =?utf-8?B?c0xuR3dZNHNEY3Q1eEdqYWdnbmlXVElNZjJrcy9vaDdwYmpsdmQzTEwvclpC?=
 =?utf-8?B?Q3pocUJPM3d1WVJYM0hzcEF6WG5EeEtsa0Y1UzhiQzR1djRoT2pJOWExMC9H?=
 =?utf-8?Q?9C27OMLV6BwXpS6dSL81tGAaU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c524a2d-5026-46db-fb6b-08dce9dbee42
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 10:03:18.5984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z72Dc+jH4CtKsOMr9N+c/pcH7jsHkN7zVOvNKaMdzvi1Mj9b5k1AMDlZ77JadPzXDIxvjNS6KeTWnEPsxP179Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806
Received-SPF: permerror client-ip=40.107.220.55;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.806, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


> KVM_CAP_READONLY_MEM used to be a global capability, but with the
> introduction of AMD SEV-SNP confidential VMs, this extension is not
> always available on all VM types [1,2].
> 
> Query the extension on the VM level instead of on the KVM level.
> 
> [1] https://patchwork.kernel.org/project/kvm/patch/20240809190319.1710470-2-seanjc@google.com/
> [2] https://patchwork.kernel.org/project/kvm/patch/20240902144219.3716974-1-erbse.13@gmx.de/
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Tom Dohrmann <erbse.13@gmx.de>
> Link: https://lore.kernel.org/r/20240903062953.3926498-1-erbse.13@gmx.de
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

> ---
>   accel/kvm/kvm-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 482c5b24cf6..801cff16a5a 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2683,7 +2683,7 @@ static int kvm_init(MachineState *ms)
>       }
>   
>       kvm_readonly_mem_allowed =
> -        (kvm_check_extension(s, KVM_CAP_READONLY_MEM) > 0);
> +        (kvm_vm_check_extension(s, KVM_CAP_READONLY_MEM) > 0);
>   
>       kvm_resamplefds_allowed =
>           (kvm_check_extension(s, KVM_CAP_IRQFD_RESAMPLE) > 0);


