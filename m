Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7A3C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 13:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuA5z-0001Dr-An; Mon, 17 Mar 2025 09:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tuA5b-0000vv-FQ
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 09:01:12 -0400
Received: from mail-bn7nam10on20621.outbound.protection.outlook.com
 ([2a01:111:f403:2009::621]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tuA5R-0002Zc-VR
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 09:01:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+7L6tTjJwHUtbzWh5FNfhtB2DWs9i3mTnbt9YjlfnjOhQkSBvYJXm/Xfo8rV6f6xp66Tj52ygNKzI1UGJwY2nZFRNnOqZmiuNFY+xiGq3GgogUj0nJWZz5V90YXUkBoBCFOZpNO0SsQCItvbxcE9o/19DJJ5KEQJJua3lqpfRibWe60PIIQgYX5RNgTNq6jQ8GRFeVs6WTamml8efTlRk4+AgYU7N87BIxaq2Lj6vdI1w1t8YTdnlz40d/9TXcShHSuuqgH6IbRmoEhqxYahxZkNa9dUKqi3dnAelOiTUrPMavrTMaA7jCNd0XJ5LJdzz1xwoD2TxrkRtbRUjN05A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOrX/D6K2ULJkuKVHJjufCKypfAGyRfS3wizblBiPN8=;
 b=VUA0cVMLXqAhsmmN0b2XwhRJdagM62gqDwC4NvE4UoDT4ZOtGRCkpMnQ4GBJ/H9Xn6ckem38G/4qNRni+8pA1vpU33z8q4qCo6SzXcQcN0+utRurR8DP2rp3lqQKB7BeUYiI88eiX2gzU6ujMrvDQMyUYWiJKBViEVABWDeZPkSuqipfJglwpBe/cp71+lSNzh7jYfvkgv7wg3GiI7/051FykyyJ7k53u5x8Oga0cbeA4IK/mClbAxFiGGSdhvf4H2MUYUs9YLrsZjtxD0nj/ocDHfO87QewT7HPZ/WY1zCcEXQ/O0qHkSsKt5EUZkGdtBT+KA/7WDooNyGT0PP+dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOrX/D6K2ULJkuKVHJjufCKypfAGyRfS3wizblBiPN8=;
 b=PXK+Idbl/Hc0CTizdemS3f+myU4QVuywdVPZAgnmm47UXvS+dYD7ragCLjoQGzFQjEKP05UOpE6McFLw0Rl1n+OejWQXO9E9ybreuf2krvXYWO0zz6+/CyeAxMwh5QQEDXXiAWnu7yly6cf2oKKCnuX8IXEIg7s6snIJ/+NaqJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 13:00:50 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 13:00:50 +0000
Message-ID: <35b2bae2-b3bd-44f0-ba5b-9afd95762d7c@amd.com>
Date: Mon, 17 Mar 2025 18:30:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] amd_iommu: Fix the calculation for Device Table size
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
 <20250311152446.45086-6-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250311152446.45086-6-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 05335c60-55fa-4388-3ef6-08dd6553bdcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3BxZWVFSjBtQkd0Uk5LdVNOdTF2aXllSFpYMStUckp1YWl3ekJQSDlsSmRN?=
 =?utf-8?B?VWJteW1HL1VKWmdQZEpHSTc4NGJrTWhuL3lqaEczWTdrQ253L2N2Z3FCU2g5?=
 =?utf-8?B?UnhPMG0xaGo2cGFraTcvOTFraytuWmJ6OUVYV1FYaXRCaUpKYmREb0lGNWNW?=
 =?utf-8?B?SmVRU2kwZjNQaXo3K01VektjUlhKQzgzVURZZTk1QXVCU09Hc1I5c3A3ZjB3?=
 =?utf-8?B?WlpCWnc3MDZNRFl2dkJURm1jNVRKempPdE1mMXM0cjR1L3UzcnFKVEplc1Fo?=
 =?utf-8?B?QUJFWGZ6b05WeGlVZGNyaUdrRlg4Uk5oVUpveVA1MHNLcmhITjRtbGt3Wkth?=
 =?utf-8?B?bFZiSUY1ZlJWQnYwOWZNUVVDakVPZ081dHhsMU5PSkd2anVDRjZYcnIySE83?=
 =?utf-8?B?MkhDcWNGWGdyUTZZVE9TVUJxTVpwTTlDZ25sVHpmZVdFZkZ4V2VmVy9XKy9v?=
 =?utf-8?B?UEhlTDlWSG9jMjNpKzJ6MjZZUzJtQWNHeGtIeUpPaHN4RS9PSXpwRnh1TnlH?=
 =?utf-8?B?V0VWQnVWUWxXOVc4YzdZNEFOcFFzei8wMEFQd3o4aGQvTE1ya2lYOUpMOENr?=
 =?utf-8?B?NEJEeDUyRDd2ckEzQmk1TG5nc2NOVEpTY0xsSi9rTHg0R2VXNnROVWZCL0Fx?=
 =?utf-8?B?RGJoYVdNVzg5aUZ1Q2dTajN1S1ByQ3Zhc1VTSjluWUN0T052dXFpSGpjTTV6?=
 =?utf-8?B?UVVKKzlCc3hPV0hVOUZBaUVZZGQya3FBV2xTMEYzeW52Q1duYmVZVjR3SUpY?=
 =?utf-8?B?dlJsNFVmc0tJZDlyU0taZm5XblVzbUlKNG16MjNuWERQVm45dTFETER5c2NZ?=
 =?utf-8?B?WU5UU1BPL2Jnd1hPak5mblRUcFZNK2F2cERiT0ZWQ240UVN0alVxUWYzc0hK?=
 =?utf-8?B?WlhqSWlaM3ZkS1Q5RytCaVpYM2ZMZDFyWFRiRTR4alN5dGpvN3dEQ3JrenBN?=
 =?utf-8?B?ZHViZDMrNCtKSEtidG5nVW5TMXdxeG40bE5XWEtNN1BSY2xYazdoZkZIKy9J?=
 =?utf-8?B?cXkzaVRpYjJwQzRKVVlDY2tvSlVyeHVQcGtZZ2NYMVA1cTBZbjhrODdsTTEw?=
 =?utf-8?B?Mis3WVdIenpCL0M0UE5ERVN2OXM4azBIU0hkQXI2ZG8wbjJUQVcxaFdEVlFB?=
 =?utf-8?B?VjFWUi96NVVzSDFNa05DNjVubEJNSy9RMThiekdBYTBuZ0psSUNWZjNBTlJT?=
 =?utf-8?B?cmM1R1hvZEplTzZRY0Z5dG1LYlUyM0hKSlIvWWsrL2lZbitFSE1RS0wzc1Vm?=
 =?utf-8?B?eW5kdUpPa3dVaS9Zd01UUkV0RExHNnRDa2JSakNOMHhqYjFVTVVhUXAyc1ps?=
 =?utf-8?B?WG5QVjVuS0w2V09JMVBSVjJYZGplMHVnMFlxUFFtYlJETVV1bzNTUGdyd3cx?=
 =?utf-8?B?TW5zWFJGUGRHRlZYeElseHJ2a2hKWG54MG5aSjdsQTN6dm1DM3ZrT29ONHFW?=
 =?utf-8?B?bUt3S0poS0I0d21Vbi95NHhodXFGVG1iT1hPNm9BWWtqNUgreCtMMmFxL3lJ?=
 =?utf-8?B?U2YxTlpnazdrdmxDdzd2cW9oT1hPUGpDbmcrNzFveDFBdGltbllPaTlTRkgv?=
 =?utf-8?B?aU14eTJQcVlXUzZuUTRLVjVCQUU3QUlhd0xTSFR2Wk1XQ0QyZGZjdlhaRnFq?=
 =?utf-8?B?cjNKRGFlb1NZRzcrNGgvWlpTdHcrTHVmUGZvT0pvNjZXN2tZNEl0Y1dWeEFk?=
 =?utf-8?B?aFY0a05Rdis5WDBlTXBwaXRHcENoTzd4VXdYVUJ4TEd6S3JSa2JwZGJCSTZW?=
 =?utf-8?B?YWpDVXBYNHRpeWZnOENBM3lHdzBqakRtVFZPczg3U2ljYmt5MnlIZXF0MFZ3?=
 =?utf-8?B?NDBQdzdwWUJDajczekp6ZXlzVERGR1dna2VicTVaTEo3QldadlJibUVUOVJC?=
 =?utf-8?Q?doBpvnf15WqpU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0RMNmM2emZ5bmZLakVlOEFUa1RtRnZUYkJPbjY5dURLd0xyak1INlpadXly?=
 =?utf-8?B?WjZhcGxvOVNWVy92S1VWZXU4WmlhNUppU2FaWkZ6SjJiZGFSdk5zT0NYWDZR?=
 =?utf-8?B?R3R1bE5YaHF2MGl0andWTU82Ry9zQTQ1SlUzT2ZMekN3VmtYbFB3QjFQdEZX?=
 =?utf-8?B?YmlML25hczQ0dnNYdzU3aTJnejgxaG9WN0NCU2F1VzZrTTh6YzhscW9KU3h0?=
 =?utf-8?B?K29FMENSWCtPYk5UMFVISm0vaGdoMnJsTWRWZS9pT1VFU2xsL1BSbG5uRmRY?=
 =?utf-8?B?aW9BVFRDWWRkYk1Ib2Y0a29kOVNCd0oyQTJWNGc1SHNsQlpUMVFmR1FkL2Nr?=
 =?utf-8?B?cm1vbk9rTjd2QXJZNTc2UThGSW43bFpJd3k3bGtmNVMrbURXeXpNbm95SUE5?=
 =?utf-8?B?Rk1iT2ZGUGdqVXd5T1RkdXpEK3lRWXNFc1MwT1docEhiSTZhc20yOEhtVXhs?=
 =?utf-8?B?NmJaYTZ3bWtpQmR5NVhRNE1RUmsxWklxRWM5SWlWVkpGUzlKdmQ3dE5oelc3?=
 =?utf-8?B?SmZhQTVSYWRYcUZXc1dSQnE4OG9aNUxhcElpU0dpS0RSZVk5emRpbWhNQXZs?=
 =?utf-8?B?ZXcvaCtkZXRWT0JZamRvUlhqS3VNS3djTnhFT0NvRnFsdmFCQ2pRTkcyNUJQ?=
 =?utf-8?B?REp3c3dCZGtVNk1XcUJBb2lObnJHS2RJb3YrbU9Jdnd0cFJ0Q0NOSXNvVkN1?=
 =?utf-8?B?NVd0aFFDaGZIbWQzbDJwN01GWmNSR1NmRHVEcHdvV2tRc2F2NndmNjUyMVg2?=
 =?utf-8?B?SjhXMXhhV3d3cHJRMmkrdnE3bDJrSW0xeG54cS9EaHNicE5ybmRjenZZb3ll?=
 =?utf-8?B?aGxTZXlRZTdqOHlwU1NHMUVBWjJldVg4U25wcVZCRGJaY2toVlZ0dURQK1ZW?=
 =?utf-8?B?NHVUVzdCRGQvQWo2Uzg1RG5EWDBYWE5rMUFZUy9nZjJLU2hlUWx3UzNJenNF?=
 =?utf-8?B?M3pwbUtaSzJCQ1JtSFVXU2I5K004SFN4U24wRzNlNkdUcUwrSHY2T2l1dytx?=
 =?utf-8?B?dkhrYy9Wbzg0aDdsRVdzOXV2OWpWVDZ4UUpPTTBEc3NiN3V0QUpXdTBNcjN5?=
 =?utf-8?B?OHhlSzVVTk9yQVlqY0ZZbW4yc0k5eUw3Yk83REU0RkRsN2F2MEo2WEhPNVgw?=
 =?utf-8?B?ajljOGVzejg2dy85anlmdWNiRDdwaGtGRWdEalBYSW1qUzNmTXlTSDhSb2t4?=
 =?utf-8?B?NU5BSVNJZ3NNdm1GdExQQThmUkJZOTFrM2UvMjMrZCs4TldTTHZEdDVIMTBl?=
 =?utf-8?B?L1RxR3hISGRlTDhkZkpaRXpnTG05N0tMc2FhVXJjc1QwNk8yVm9uMHpaRnVZ?=
 =?utf-8?B?ZkRzbWtnSHRZY282WlliZlV2anNSQVZrQmJHZE5GUkNNT1JJOTJra2JGbkU0?=
 =?utf-8?B?RGpsaXkzZHFBZWtSQVl4aU82bTNwQkxQYXc1cmFtcG83c2szb2VORFhoa0o1?=
 =?utf-8?B?cDNKblhieTkxRUFwcU5JRW0rell2TkhwdG1ySitOUEJDNWJHV05jRzQwNDR2?=
 =?utf-8?B?dFRSRVlWa0xzV3pscHVwcjVaWlY5RXRDZTFWL0wvbU9rcm5lenBYZkhCbDNS?=
 =?utf-8?B?WE00bGVaVjFyQWVQZGJYSlVVYnVYR0QzNHBYVCtwTGZkdEFQcGJRVUNBd1M0?=
 =?utf-8?B?YWtWNklQenpXRGhUYTdXY0djNVFuZDIxdE8wOHcxU20zZTY0a2lUZzRjaTBJ?=
 =?utf-8?B?N1RRNVBJZm8vdmtuMTdOYVV4T091M2pBbXRMOERwZjNJZ0txMFo2dS9BaFd2?=
 =?utf-8?B?Y3R5Y3NtRnkwY1VxSXU3b3VCZHp2NkNvYUNzT1crQ0hLVjNqSUlyVGl1WmpC?=
 =?utf-8?B?VGZ4aUVneWhZZ3ovbTl0VVltSEc5aERtVDJtV3pHaXFnSGtEcmY3bGhjZUIz?=
 =?utf-8?B?VWVvc21GTVBXaEQvRmUwS1hHbUpodnZjVnlVNkVOb2FZVWZZUFc0aE1kcGtW?=
 =?utf-8?B?TXFIVXhnbDd6ZFRkNXQrZEREWFlRdEZXV2dmbjJkUVFBYmxzYWxVaXh1aHl4?=
 =?utf-8?B?cVFldGZCZSs0aHI2eWQ4MGlsMGI2Y2xwQVB5Q2hua3lITFQwd0QyVmE2Mjlk?=
 =?utf-8?B?ZzRZSjh6QllFc3RxdTJmRUpxT2xQZFlla3FkTDk4RjRzSVA1WG1xUHNZcnp3?=
 =?utf-8?Q?S0YJBtQ5nhyf+DbxOdhVIWmai?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05335c60-55fa-4388-3ef6-08dd6553bdcc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 13:00:50.1302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfRpw4V2mZajSQYnMq/fEYg9goY5ABdUhno4XyrU1Qu++30ryXKhMQd3VQ86Yl2eD9P1z0D72WEvortG9FegZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
Received-SPF: permerror client-ip=2a01:111:f403:2009::621;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Alejandro,


On 3/11/2025 8:54 PM, Alejandro Jimenez wrote:
> Correctly calculate the Device Table size using the format encoded in the
> Device Table Base Address Register (MMIO Offset 0000h).
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")

I understand its a fix. But its not breaking anything. So not sure whether its
worth to backport.


> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant



> ---
>  hw/i386/amd_iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 8b97abe28c..cf00450ebe 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -665,8 +665,8 @@ static inline void amdvi_handle_devtab_write(AMDVIState *s)
>      uint64_t val = amdvi_readq(s, AMDVI_MMIO_DEVICE_TABLE);
>      s->devtab = (val & AMDVI_MMIO_DEVTAB_BASE_MASK);
>  
> -    /* set device table length */
> -    s->devtab_len = ((val & AMDVI_MMIO_DEVTAB_SIZE_MASK) + 1 *
> +    /* set device table length (i.e. number of entries table can hold) */
> +    s->devtab_len = (((val & AMDVI_MMIO_DEVTAB_SIZE_MASK) + 1) *
>                      (AMDVI_MMIO_DEVTAB_SIZE_UNIT /
>                       AMDVI_MMIO_DEVTAB_ENTRY_SIZE));
>  }


