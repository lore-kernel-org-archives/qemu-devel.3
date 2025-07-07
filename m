Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4065C83F07
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 09:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYiA8-0006H7-QP; Mon, 07 Jul 2025 05:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1uYiA6-0006FF-2H; Mon, 07 Jul 2025 05:29:22 -0400
Received: from mail-bn7nam10on2061c.outbound.protection.outlook.com
 ([2a01:111:f403:2009::61c]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1uYiA2-00055y-SU; Mon, 07 Jul 2025 05:29:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKTc+pZ+k83Wfcu/7pTy8uk77JVdk/q8mR8QxYKEzY0Iq4aQ+bNcplwxx8MCL0fBlyooqmp6wLAkJ/ynZqyRQ4bjIgv/IBsxiBIWf3CmLdL+pBNsjmZElYbC0HUsY0CcTBkxuBP0f+qxN6m4V0JyrjoC/J78lMxR8cBAOIcfR8QIrmpRRFqW9USV+gj1crZXwIFY+z0JCKFED6pp6ZYBy4L3n/67Mpr1wWnikB3dn0nF5YPJorHcQ51cefCXZI774YQvTlx2mSdk97k+hDHz82L7ecIwVm+rGcsa1XPXerY9bxJvvKzWxgU/vjR0LsWjwc7ZtMz0piEKirG/7ZtdEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNRLgwfZAeQVpviHzgCyuw+GjxXTdVEAQokgs7UVSSg=;
 b=mUon8gniESpf0VkD+v3YccgrmzYHVbBxUe1F91D2/8IJl1bLRELJ9iMSc4qA74JzfQ9Dd6e3ushB8umTvjH5RvlrvMETVGxhkV1bGbhCfszQtWmzLRbKdO0L64zP+sww0H/CG3NLQUauFmPTnvps8kTer94/P7YSN08a83ltGuiIstRVaLuv0z78y1sRMNt5H7bw0KCyStYtXIZLFx/3bSyDgrP6KdOouMwPf9XVxOOzfkhcl+XMd1RpIq/YdsFdCQ93ht5/TNBEgS79rrq33SiRnSzVlIyIsqfO/Bmu0CUmsp/SxbrpWuhOlklQC7UKo8SL7uP8seqNNA0GiuZUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNRLgwfZAeQVpviHzgCyuw+GjxXTdVEAQokgs7UVSSg=;
 b=LpGV3wOfWDXNbzk/eHJe5lPN+Bei+MoSolbWwCYdpZq7mj1m3UsA6awDRNM32/eS+VWyMiVgo4JJ+/6d7uHe8VylLUg+6HyeYYImNP9u2ul51E8PwV/JmIrQkDrJYGMxQ3DuPUBo8RiTsq8CkZ+D4hpG/EecPVaTh6xGR3/hAgBsdQD5TR21mTVYovqGhLCWo4CRu5i+QX9dh5AlWfsgzU3xKRNmyO+q6bntFwO/WymNKMjs3E5VF5uwsOrPMuH/zDvT/oi6OtlI4IUWKVXLeXSNW2wCDfe/wIe5m7mPA3nA1E2V0HCUGmw3P1x8nRqiUM0JQfQrSFJ7qdm2UsvxHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA0PR12MB8424.namprd12.prod.outlook.com (2603:10b6:208:40c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 09:29:12 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 09:29:12 +0000
Message-ID: <4fbc3288-edb4-4942-b3dc-df7beb1e3f24@nvidia.com>
Date: Mon, 7 Jul 2025 12:29:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] vfio/migration: Max in-flight VFIO device state
 buffer count limit
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <cover.1750787338.git.maciej.szmigiero@oracle.com>
 <0e88a253e06647f6c01bdeba45848501b3631bd3.1750787338.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <0e88a253e06647f6c01bdeba45848501b3631bd3.1750787338.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA0PR12MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 89df8789-fb80-46c6-cd45-08ddbd38bb6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1Zvd3hqNlloeFdhc09LUGdQVGE3OXJKZGhsc1YxOFVIOGwrWXRLdE5HTXRY?=
 =?utf-8?B?NzBmU0hrZUljRDZUQVJ0QWJnQU9TOHZrRWg3elZRYUhQRnFZMUVNS2lmUzc3?=
 =?utf-8?B?MXdaeC91Y1V1YkI4RjBib3NLcDY4MFFpcEZCSkhmbnE3bW9hdWMyd0hJNS91?=
 =?utf-8?B?a2dZSTJ0cHhaUnM5eU5FZUg3MkVQY2dmbS80NUZ6KzlzclZsWjB4OGtOd2Rx?=
 =?utf-8?B?UDllOWVzdjlqdU1DT29PYXlJd1d4MzJFeGJ4M21xVHJaYmRSM2YzSlJQa01S?=
 =?utf-8?B?TElaTjc3c3JkaEsvNTlwbWlPMW8xOHUzVWFZNlFRY3RrS0l2cHZ5VWR1Y3h1?=
 =?utf-8?B?R1RqQjc0WjZmTzVyOE9sWlpiVy9DOW9IZU5IdEFmYUVtZmFsRWpuNE05dzVD?=
 =?utf-8?B?VFREOHZaR0svZGpaemEwbWRWYXRHQk0rNUUvc0MyV2hTY05iUnpVNURKa3Yr?=
 =?utf-8?B?UUZCVXdVem5QUnpXSDhBZTVQYW1jWGI4b0F2d1FrbGt1SFlvWGVNUjNUbHE0?=
 =?utf-8?B?S2hTa2UyT0pRYUxKUGpjZHNPWE42dDZaMjFDRnRHZnFjMTBLcmlrN1FHRFdp?=
 =?utf-8?B?K0pmbmhVTFdiWlZLZFJDQ3d4MUV1MWM1SjFkcmVZYkhWMWYzWkxsZzkyZ1Y4?=
 =?utf-8?B?RGlmUTljNURyYTIzK1VVcEE2c1loWHdRbkxCckhCNXZKTnlOZ285dFNNaW8w?=
 =?utf-8?B?cmhRc0lrQnRHc2tCSHcxQU1wR0o1TWFFOGJhTjlpUmxIdU9BTm4wRmluK3Jk?=
 =?utf-8?B?ZFBxNkd4Um0yblNIVWUzeWxudm9PZHpqOGoyS2ZiYVZLMDZicWhFWVhQMElq?=
 =?utf-8?B?b0krV2NEMHQyamlaeWlwU2JTZjNrc05LVUY3czFvaDM2MTV5TFpaWFRUdjlE?=
 =?utf-8?B?NDE3QTlaSlBwalhqQTgweC9jY3JocXlXRU5jdG9tMFBFUDZuV0lCM1RMbzBl?=
 =?utf-8?B?TE1mQlNXc2FuN2ZuZjZEbHlrVzUyb2hVc0UxYXBlakxMT082SWkxT1hPYnZL?=
 =?utf-8?B?STVFNU9vQU1PdzRGSXQ1NWZHVWE1dGtpSHZmVWo1akpoRTFBdFNxVFZHdDdk?=
 =?utf-8?B?ZXhoM2JndWRtVUtNakNSSHhmcktrSkl1RW9qbUxQZ2lqNE9oNnVWbDVzQkdW?=
 =?utf-8?B?TWdybmQ1L1A0aTd5czkrZ1NhMEZsSUNnK3RJeldUY0FTU3JvbVhUT3lUTXlB?=
 =?utf-8?B?dUJLN1ltd1FVbmhoeFVRSmwxT0k4VEorR1JvS2YzcGp4VmVNU2pvclpuS3lU?=
 =?utf-8?B?MGxIdmE5RnJrR3hkUVhCbHp3ejN2S1h5TXNTK21pL3U2cVh1UEcxZ2pVOWho?=
 =?utf-8?B?a281ZFZwZGJBVHFuNXBmOGhNUFVHSVo5S1dRQnF1Q1dMN1JWdVFSWGVyTWtF?=
 =?utf-8?B?VWVPMGJYb2tYbklQTmNOaDV5YmVXSkQ4VEhxSFFZZWZHNVZ3TmE2ZTdUSkMr?=
 =?utf-8?B?ZGlaNlU3VnVkdmcrWmtaS3lsdUkzbUZDWEJrSnlYSE1BT1dEOXQrVUY0cmlL?=
 =?utf-8?B?Snl0VFV3S1hsVkh5WnVwSmJDcGowS3c5bzk2U2lGVVpGTFpuVTRvcHBsOUVK?=
 =?utf-8?B?K05MMVlybmxRZ3M2QkthT1NXNGFRcW9zTy8vN293bkttUnZ3ZFd1YUxoRjhu?=
 =?utf-8?B?b3VWZ2lpTFRjZjQrMWtSSmVRcy9RNVlOZDBYQzJSSm1jVFlweTE5TVV1R1Rk?=
 =?utf-8?B?T3FnK1lRbVF4TnNQSXVoN0pZTjJzVXI1RUgyWGtEQ2taQ0FNeG0zemY3WFlD?=
 =?utf-8?B?TGUxZTVITnBadmZMNmM5dEpqcUFIOU5BWUhXNHluQVB1c0xUSzZ6YWxmT2pm?=
 =?utf-8?B?M25jcDdJTm96ZG1ZMEhxY2dESXhmbTl0N0g5NUVMS1hMQ21vN2JzMUd6TVdW?=
 =?utf-8?B?dUtFbWVUbDU2RFNBb1N0aDNCVW9Cb3drZUNoK1orQWppMDNIamh1UVNqRWg0?=
 =?utf-8?Q?ULE7ZT63ve4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG9wcFMwbHpUalZHMHJGS25oRlpJK0pkNHA2ODNGUmpjNWV3alRqL0xwVXdG?=
 =?utf-8?B?Q3hJSmlvQ1FrUVBxRlpETW9BV0ljbkE2ZUU1djZ3dzUyQzhpalFYcjVpNFpX?=
 =?utf-8?B?VENCbjFGWnl5QWNlT1ZPUnhCL09RRnRmYXhNMjBQSlFJeTRnRHpNS2c4Zklm?=
 =?utf-8?B?TG1CV3kyNVlTcFJsZEZ2bXE1KzBOOFFwL2hva3VwanZaVVNCMHRvRkw5aG80?=
 =?utf-8?B?ZHRPVDhKRkl6eWkyRjQzd1krczhkbXk4YzIwYmYyRFlpTmRGeUV6cldxWFBN?=
 =?utf-8?B?Y3duVStqQnlWKzV1S0RZeGY4QWxsK3F5T2VoU1U1UVVZNitxeHJNbzAxTU9p?=
 =?utf-8?B?WGpkclErUTV1UTF3dHFialhRSGhsbGFKSFM5VTN1TEZlQ09RN2pGbGt4SGo0?=
 =?utf-8?B?Z1grL3RJQ25KRnhpOGpvUFYxTHFXQTBQN2dNYis0Qk82Z0FuRzRQNmtuaHBt?=
 =?utf-8?B?M3puNUQxbHFpWDM1UU5QWVRSVTJyNHV5QzRrTjlpU2QyNnd6d3NKV0JWemhJ?=
 =?utf-8?B?dUx4TEEyOXNTRGlySWFMTjZlNU1oSytwTXpJZlZkTDhDVExSL3QrR0ttNEJv?=
 =?utf-8?B?UFRRc3dFVXM0b2Y2Rnl2U2xieFZZV0lpUmFRTkx5THlSZS9ONWlqUWFlSkhP?=
 =?utf-8?B?ajkwWkRjYW1uL21WRUZ2M2Evc05MRFJYNWc3dDA5bFVabGFoOHhRTUcrMG8y?=
 =?utf-8?B?dnVUMC9sbTRYd2Y2ZkpVRTB3ajdINGFUZ1d6b1dzSHJjUUlncTQrdFNucXNW?=
 =?utf-8?B?YWhsVXF4WGoyM0tkdE5LR1IvY1psT2lvRlZOMG44Q2ZQUDZuVmNtVVNvTDBn?=
 =?utf-8?B?VkI4YTJsUVNGNEptY2NKWElEclRTWVlLcXhxeS9ZNitvM0V5ZlpDMnR6TVRZ?=
 =?utf-8?B?TjhTNDJjMldhWlpRN3NyMGt0N3V1MHFUNzJXaFErbXlrejZkUlYxRGtoK2dG?=
 =?utf-8?B?L2FkU3hCaDJxVEs2bzJ6SGdoUG1LQTB5TG44ZTIyMWJmYkQ2ZUlOS3pQS09B?=
 =?utf-8?B?ZGxka1NRdGIvaFdGQloxbjVWZHRhckEzZU91OU1QVFBkRHp3YWc2MEw4bFdI?=
 =?utf-8?B?L1Y1THZ6MnJPQXNXclIxc2p5TFNXMjM5MjZDZTBJUHE2b3g3aDdwTUt0OWlQ?=
 =?utf-8?B?a1p0eGgwclYydXQ1bFdVOXpMb0VKOVBZYTFISGhWdkZlOUUwcEszUlJPSU1D?=
 =?utf-8?B?dzh4ejFzck4rZlc2bWZtNEtVbS9HZjVZQ0pwZjVTMzBIWHNVcUUraWtmVFVU?=
 =?utf-8?B?R2FkYnQ5YjJvdTNJSzQvYi9zQ1dpc2E4cUpWcC92a3BDYjVZUGQ2VVV2L1BW?=
 =?utf-8?B?V2hjQU1lVU42UDRodHlLQ0tYbWpLWFlwSDZXeUZudmtaN2FkajV2MGxTdUVY?=
 =?utf-8?B?b3hac3J5bzBnd2w4a2RkdktUM2sxS3pLSkQzWXlvaWpOcXNrNGx5WEFTVG4z?=
 =?utf-8?B?RlhOTTR2WENRZnM0czlMMjh3SkxDRVVjcWZvdXoraXJaYS9SVTBZVFdSTTNY?=
 =?utf-8?B?MGFONm1pS2xMOStLTTBhbzFlSXdWZXAwbVdKSFFnSEgxZG1NSmRGVmtUSVRR?=
 =?utf-8?B?ZWpSalhjcmtRd1RpUEFJZExiNHZSQ3I1dWlOWFI1aHF5bitvZGh6bktBdEpV?=
 =?utf-8?B?dUZvZmpWbncrRitzZmpTR2JzWlhaVXpNb2w2N1IydG41elJRNUJCejY5OE4v?=
 =?utf-8?B?RTdDNEFZVGpvblZxSkl6K2Nnb1I5QWFsWHBQMnVhQVlteStPZ2dCUDkyL0lh?=
 =?utf-8?B?aXhqMzdTdWxzaEdjVmxnMys4V0krNTdhVGdCd1pWaENVWUpkRERNNTNmZTRs?=
 =?utf-8?B?TGs0ZHZGMndFNnpmRXRrOExILzVjZ3hkMFpRdEFrcldzcHQ4YXlsVnZvWDdj?=
 =?utf-8?B?aThtWWQwRy9kTjRwNXN0Q0hobXZEUXFHV2xtZE1sVkhoZ1E3alVFUFpLaU1S?=
 =?utf-8?B?NEFjaUF1VVk3dERkeTV3d2JreXBIM2t4RjVGdDFtSnFKNVlPSDAzRDFPSlll?=
 =?utf-8?B?V1U3VnQ5MlNFMmlaMUJjVlFTTkFhUSt4bTFtS2lmQ2VJNm1DN1ZrblZWUnJi?=
 =?utf-8?B?dW1UdFdJbGJ0MndhQTVQVE10dlg4VlgvblY0SmI3aTZSTEhETGtCTWdrU1FU?=
 =?utf-8?Q?G58UZUQ4RI0sbVi4B5DGNiV4M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89df8789-fb80-46c6-cd45-08ddbd38bb6f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 09:29:11.9897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAHLiHshkru9yhe39B1Q2jZILRgUWcxsKYVjsHPrTrH6zdBT2dL47uCj3OpiJssY0qZH7B+Eg2txAOp54r9XrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8424
Received-SPF: permerror client-ip=2a01:111:f403:2009::61c;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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


On 24/06/2025 20:51, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Allow capping the maximum count of in-flight VFIO device state buffers
> queued at the destination, otherwise a malicious QEMU source could
> theoretically cause the target QEMU to allocate unlimited amounts of memory
> for buffers-in-flight.
>
> Since this is not expected to be a realistic threat in most of VFIO live
> migration use cases and the right value depends on the particular setup
> disable the limit by default by setting it to UINT64_MAX.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Reviewed-by: Avihai Horon <avihaih@nvidia.com>

But do we really need both x-migration-max-queued-buffers and 
x-migration-max-queued-buffers-size?
I think one is sufficient.

I vote for x-migration-max-queued-buffers-size as the actual memory 
limit won't change depending on VFIO migration buffer size.

However, if you pick x-migration-max-queued-buffers, maybe it's worth 
mentioning in the docs what is the size of a buffer?

Thanks.

> ---
>   docs/devel/migration/vfio.rst | 13 +++++++++++++
>   hw/vfio/migration-multifd.c   | 16 ++++++++++++++++
>   hw/vfio/pci.c                 |  9 +++++++++
>   include/hw/vfio/vfio-device.h |  1 +
>   4 files changed, 39 insertions(+)
>
> diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
> index 673e354754c8..f4a6bfa4619b 100644
> --- a/docs/devel/migration/vfio.rst
> +++ b/docs/devel/migration/vfio.rst
> @@ -247,3 +247,16 @@ The multifd VFIO device state transfer is controlled by
>   "x-migration-multifd-transfer" VFIO device property. This property defaults to
>   AUTO, which means that VFIO device state transfer via multifd channels is
>   attempted in configurations that otherwise support it.
> +
> +Since the target QEMU needs to load device state buffers in-order it needs to
> +queue incoming buffers until they can be loaded into the device.
> +This means that a malicious QEMU source could theoretically cause the target
> +QEMU to allocate unlimited amounts of memory for such buffers-in-flight.
> +
> +The "x-migration-max-queued-buffers" property allows capping the maximum count
> +of these VFIO device state buffers queued at the destination.
> +
> +Because a malicious QEMU source causing OOM on the target is not expected to be
> +a realistic threat in most of VFIO live migration use cases and the right value
> +depends on the particular setup by default this queued buffers limit is
> +disabled by setting it to UINT64_MAX.
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 850a31948878..f26c112090b4 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -56,6 +56,7 @@ typedef struct VFIOMultifd {
>       QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
>       uint32_t load_buf_idx;
>       uint32_t load_buf_idx_last;
> +    uint32_t load_buf_queued_pending_buffers;
>   } VFIOMultifd;
>
>   static void vfio_state_buffer_clear(gpointer data)
> @@ -127,6 +128,17 @@ static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
>
>       assert(packet->idx >= multifd->load_buf_idx);
>
> +    multifd->load_buf_queued_pending_buffers++;
> +    if (multifd->load_buf_queued_pending_buffers >
> +        vbasedev->migration_max_queued_buffers) {
> +        error_setg(errp,
> +                   "%s: queuing state buffer %" PRIu32
> +                   " would exceed the max of %" PRIu64,
> +                   vbasedev->name, packet->idx,
> +                   vbasedev->migration_max_queued_buffers);
> +        return false;
> +    }
> +
>       lb->data = g_memdup2(&packet->data, packet_total_size - sizeof(*packet));
>       lb->len = packet_total_size - sizeof(*packet);
>       lb->is_present = true;
> @@ -387,6 +399,9 @@ static bool vfio_load_bufs_thread(void *opaque, bool *should_quit, Error **errp)
>               goto thread_exit;
>           }
>
> +        assert(multifd->load_buf_queued_pending_buffers > 0);
> +        multifd->load_buf_queued_pending_buffers--;
> +
>           if (multifd->load_buf_idx == multifd->load_buf_idx_last - 1) {
>               trace_vfio_load_state_device_buffer_end(vbasedev->name);
>           }
> @@ -423,6 +438,7 @@ static VFIOMultifd *vfio_multifd_new(void)
>
>       multifd->load_buf_idx = 0;
>       multifd->load_buf_idx_last = UINT32_MAX;
> +    multifd->load_buf_queued_pending_buffers = 0;
>       qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
>
>       multifd->load_bufs_thread_running = false;
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index fa25bded25c5..2765a39f9df1 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3524,6 +3524,8 @@ static const Property vfio_pci_dev_properties[] = {
>                   vbasedev.migration_multifd_transfer,
>                   vfio_pci_migration_multifd_transfer_prop, OnOffAuto,
>                   .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_UINT64("x-migration-max-queued-buffers", VFIOPCIDevice,
> +                       vbasedev.migration_max_queued_buffers, UINT64_MAX),
>       DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>                        vbasedev.migration_events, false),
>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
> @@ -3698,6 +3700,13 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
>                                             "x-migration-multifd-transfer",
>                                             "Transfer this device state via "
>                                             "multifd channels when live migrating it");
> +    object_class_property_set_description(klass, /* 10.1 */
> +                                          "x-migration-max-queued-buffers",
> +                                          "Maximum count of in-flight VFIO "
> +                                          "device state buffers queued at the "
> +                                          "destination when doing live "
> +                                          "migration of device state via "
> +                                          "multifd channels");
>   }
>
>   static const TypeInfo vfio_pci_dev_info = {
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index d45e5a68a24e..0ee34aaf668b 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -66,6 +66,7 @@ typedef struct VFIODevice {
>       bool ram_block_discard_allowed;
>       OnOffAuto enable_migration;
>       OnOffAuto migration_multifd_transfer;
> +    uint64_t migration_max_queued_buffers;
>       bool migration_events;
>       bool use_region_fds;
>       VFIODeviceOps *ops;

