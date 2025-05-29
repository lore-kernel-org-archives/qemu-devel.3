Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8E0C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 05:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKVn0-0005tK-QD; Thu, 29 May 2025 01:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uKVmz-0005t7-Hr
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:26:49 -0400
Received: from mail-bn8nam11on2061e.outbound.protection.outlook.com
 ([2a01:111:f403:2414::61e]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uKVmx-00017b-7O
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:26:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3iqgvLS73XOu1Yvg/xDScd5EhXT13QNPdcB3cBYfCgl0fWMf/iU8vWdTNdT5gjDf2QCe5RpVty/7+6RfUvN3CKrmMUl983XgM6TEaTdmDg21hxGhgaJNsgloGd9DflFBBbzFMtWYWKS29bZR4dIsPkzGmXuuqYFNYhiUf7u4o8zeBQVRN9c2sPncj9Yv9u1J3xn5TzeftqEk167LUeplRaWfGarhKKKpnThVqu4m53BJwBjzqn7iifBVY//3kW7oWHy0OKnrS02lzQwuXoeA8hwqGltW8IilYQ703w2M89cTtwKPIVECPpQbZYCirqi/Iq2x1gQuiPNHkL+pw8Dbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuFONq5DqoI/p8MLkXJmQyX1MuEIIla83QxmRgjL9i0=;
 b=ICz7A0J4U3zejpjRS53fC0OxLJ+mOmHLvg9V+9PQbG4aTVukYAoNyBQj2B+F50Dk2dIvIdbtWT9rW8OvuinrUDeUXBhSMt6o8jSytl/mUeO9CXwxqry3EkEbv9/+CK61aSgM7GSbM7fo5QCKY/ioPBsy0gWLvG7jfjyMnqUlbjzN4ZVHdFMeturY/d3NX4QO6+QXJGA7dkUALFXXpcz3SltxoOoJXPZd8ul7ovKYUIRAIyCFY7f7dhWxxmrt6AJh9RA0z9zeRlB7J0moOGMFITOj2K9CO1y8wC/kLpqyVOV/KKPHTr0i+/raTSQrhk/7dCpYcfG3P/qfbw9aLGg5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuFONq5DqoI/p8MLkXJmQyX1MuEIIla83QxmRgjL9i0=;
 b=BK91RUjqPOPvePgC9yOfOo2o5JhP+NNhg5lVa/g044jODY2u7nuAc8fsGuwBCWt+8hsg3OwAKEXmCg96Imrv9JipPB2oMiigPMeVkRBkQ0whu8sNUsSNQQ2pBXnCv5zXLxGKnBslQPzwCpgl6oTBR9VRSEzgf1QCPbkw5PhcNqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS5PPF5FAA0E762.namprd12.prod.outlook.com (2603:10b6:f:fc00::651)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Thu, 29 May
 2025 05:26:42 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 05:26:42 +0000
Message-ID: <573444be-8ca2-43b4-b732-dc35648a5940@amd.com>
Date: Thu, 29 May 2025 10:56:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] amd_iommu: Fixes to align with AMDVi specification
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, richard.henderson@linaro.org,
 eduardo@habkost.net, suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250528221725.3554040-1-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250528221725.3554040-1-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS5PPF5FAA0E762:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f406c3f-5643-4f3a-f19b-08dd9e716542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWZsL2JZQy94SGVhK3lOV3huVnNxZldHai9ZeVdlN2pYdTBOOFdwOHFMQzhv?=
 =?utf-8?B?cUFiY3lhRE9peGNjMTFJaWhBd2tldS9uQ1FaNWdtT3lrU0dYRFR4Um15emhE?=
 =?utf-8?B?Wko3eSs0Uk1BUC9vaDcvNFRmcm5CVE5FNHkwdG9UWXBzNHVZZFpNM0JCWFdV?=
 =?utf-8?B?eWJJbWlwZmlGai82Q3V6RGZlMloxS2NXNzFYaTVBNkpnZlNNYW9xOFNxY1ZQ?=
 =?utf-8?B?YmxqNXZlM1VyVTFwSG9ET2pRcDFLbHNITzVTWDF0Z2daWHlQN2J2b1IvNzRl?=
 =?utf-8?B?MGhwRDI3UEdpdTVnb0ViaytOVEh0MlBYNHpGR1NnSDJEbURkaXh1cGVVOXZ1?=
 =?utf-8?B?UlVkSSszMkQ3QjliWWxoRCtyU1ExM2w2TUpEbU5UVjlhdW9BQWFwMmZGMHUr?=
 =?utf-8?B?bVB6N3dZSGpjRk1qNVI0b1NKQzZlMkt3ODN0bTlncjdVNUYwcUJNcm1wUGJ2?=
 =?utf-8?B?WEJ4bVA3RlhwcjNaLytxUjNRK0c1NndYbk5qbTVhZXdIdUlrYUNHRURES1Fw?=
 =?utf-8?B?WjM1YzZTMnN3SHh0bzZGMkhoa2w2V0NsL3ZvcGhaTzhVYm5iSmFEV2hPcWJ4?=
 =?utf-8?B?WThrMTl5eHdIZUdDR0w5eER3SHlmYVl0YUVvT2J1VFZUL0IvYnlxSndGRUZE?=
 =?utf-8?B?K014eGluWlFXclVwQmZrT2ZmcWdzdG5nRFFaTlhDQnRFRTdHeW9uRTJjNXdI?=
 =?utf-8?B?UnljN2ZUUW13NzNWb1FGM09nbm8zWE5ybHIyTTV4OFc5Um9vbmZIM2NaRDl4?=
 =?utf-8?B?UFZXZkp0VFdnNGlKaEw0ekF1TVdON0F0TGJOdTNoekZ2L0Z2dFhVZnJvUVA5?=
 =?utf-8?B?cU5aREZZc0lqSW1odFZ4NWVnQXBNNmVLTEl1VWJHUWdqZmZDeURFK2Y5ejdi?=
 =?utf-8?B?NXFBUmZaSVh2Y2lTZDZCSk95ZUtOQUNDR3p1SzhjZzVOdVo3bldhYU9XV3dD?=
 =?utf-8?B?Ri9FZjBnS0EyZDltY0FiZzBPS2N6cmFHS1ZBZkx2QlUrZUx5OEtVdWJOSWlz?=
 =?utf-8?B?WWFTZk5hMEdWWW51WlF3S0xxY202RERIWmdzcW5IQ2JjTWJKVnlObEVTbyt0?=
 =?utf-8?B?SktZc0hwTVoxWW9xOC9YNFU1c2RtSkJBcGxYMk5CUnZCUWY4d2oweWVnSXl5?=
 =?utf-8?B?N1BKS3BPUkE1OXNPb2Z6UzV3dDN2dCs0SUFoaCtWZmUyZyswSUtudXVCcHQw?=
 =?utf-8?B?YXBGZjlWZDNnelFGc04ybEc1YUV0VW51bXFUa0c3Wi9kY1pWdFpLeGJGek9R?=
 =?utf-8?B?UDhlVkdmS1MrZEpDVXkwajZWTzhoSkNwZS9nMG1tK2wrclZvMjdxa0RUZlY2?=
 =?utf-8?B?UFduNzl6S1Z1YjlIT3oxN2NNenRLT1pZYi9VRWE0bDc5b0gxTERudmpaZ2RB?=
 =?utf-8?B?K0RoKzFIK1pUWnovYmtYZmNyeVFvdU92WTg3RUdpbmF1U1cza0ViZjhTQWNh?=
 =?utf-8?B?SXEwd05Ob2kwVUNQeGExTGVyWjJBQ2xxVm9JN0V0bnA5Ti81bzFHWUpsN0Vs?=
 =?utf-8?B?d3FQanQ5NGZlSVNLVXg3ai9yOE04c1crVTNFNEpqOHBoYVVKMGFPSGgwWTdm?=
 =?utf-8?B?UjlwSXVCM3U1Sm5sZ0RKOFY5NU5uUElmd1VySGMraVc0SlFmMjJ1R1p2Mkgw?=
 =?utf-8?B?a0lRQ0FyTFZtU003cFpoZXJNdzlDV1JYTHBCenhQUkdZUnNMcS9sTk05czF2?=
 =?utf-8?B?UzVKYy92dnY2ZEtjYzF1UWJJS215Wm1JR01FR0dYTmVtditKTXNVcHBublU2?=
 =?utf-8?B?ZFdEdVN1VGdhSEhUa0FCV0xGV3hpOEw5cDVLNmN5MzJjWVhyNFVoY0VtRjNz?=
 =?utf-8?B?Q1dtZlJ1VkVwWjNxQStaU1AvQTJLMjRmaWJNMlJvYnQvMS9rMmRmMS9HVXVF?=
 =?utf-8?B?dk5sQWFRRmtXRnBvZEJKQUFKRFlDcVI4V2YyNzdhODA5TUJ0ekdUeW9YR1pI?=
 =?utf-8?Q?JpXgNUKSfAwenYr2iJkzFOs/PX/miu2b?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a05LNEZweXpMemJTaFhkVm5QTmR2Qi9JYlNHaW5GdENPK2pZckVMWEhCajdE?=
 =?utf-8?B?R3IvZllBMFhpd05rTWRra2VDU2NScGFQSUEwTWs4RFJoQVRlYS8yWW1Hd2Fq?=
 =?utf-8?B?OHpMbDZhU3A3TGl4ODEwR00rRllkV1g1NUt0WlZCNGsraWcwdTgxbzhMU0xn?=
 =?utf-8?B?TnhoWTJkbzB4eG1VbUZWNkJ1dXBJdWhMNFZNQlFHcXJmdVZMSVhhMHhtUlc1?=
 =?utf-8?B?eTN3SHlOV3Z4MndZQWZJMHpwc01URkp3eFI5VXo2SkhKbnc5d1k1V3F2Qkwr?=
 =?utf-8?B?NDJmVkJ3TEpCZFhkSVcyNkF1QkpwOW9Kc1FsYmVyL3dqV3Nwa0ErNjBidEFa?=
 =?utf-8?B?OTZKYmU2ZmtlOHh4bVZsSGI0d3MwU2hxdWRyWWJFWDRDNWgvbEFUSGpCazR2?=
 =?utf-8?B?Y0hodURPdDdJcjVSSXZTejNTcTBlNXI5QjBuN2ozLzdrSmF1ZmxMRHJCSkFD?=
 =?utf-8?B?NG5GV2c5dVRlZ01zYXJyUDZ5WStQelhrMmxxelBvc1ZjRHJHdk16V2NsRjhY?=
 =?utf-8?B?alN0TVBLWjlZNE5rZDJ2OGI4SGxTVEpldFFFb2JRMnMzdnN4M00zUCt2YUg5?=
 =?utf-8?B?bWlTZlJ4eE5aSzRJWFpaWUwzaEtpekpTS2oyZ3V0MlpQL1hwT2FKZzFuT00r?=
 =?utf-8?B?Y2N1RW5ZZlZWYkZ4dXgvaElkUS90cHNVVVFQQW03cXpkTjFQVXBUK21hcTdM?=
 =?utf-8?B?YVRCTWNGZnlnSkYvcnhvWmUzeWVNUW9JbG5GYU1LSGJDVDFoRkxsb0dIWHJB?=
 =?utf-8?B?RlhlOTZXNW15SWwzWVdYYVFic0xMK0RZMm9TWEJ4M28wTTJjcERsRDd2Zi9C?=
 =?utf-8?B?QlhZRlVNMUpQb2VmeE5xRGNQcmV0dXBmUUtYdXI1dnJZdkZ5MTgxSGdBMEJu?=
 =?utf-8?B?dTZuNnRZZXZvOCs3U3Q2Q2s0bGhtTFp1WGwzbXNzRlJJVmFVRllabTlnQzMw?=
 =?utf-8?B?QklYcVZsWlEreXozNHFiMTdmalllc1R6Q2FNaFpRM0g0YzBYWlN5YTdwcC80?=
 =?utf-8?B?S1FSdHlZVUd6QWN3eTRNQ0VhUndPRHpEbXlwR0JtVUVFK0NDdjRkaE43YTYy?=
 =?utf-8?B?aTJoWXp6WEtmMnYzY2hIdWUxSnZXN1kyM3cvYW1aSzJKVFQ3M3FnY1lOeHlQ?=
 =?utf-8?B?MmdnVHBpV25pNlVlVUFXa1ljaXNKQlJUeTB4a3R6WkIvOVIxYjFPd1VDUm9z?=
 =?utf-8?B?amY0SHkrbndGSVF5MlgrT3g0bkNiSzVpOVVCTnBCZWt4d3YxUm9Xd1g2SGFM?=
 =?utf-8?B?dTdKMGpmZlBtYkpOOHRKWm50L2duSDRCbTBMK3RJT0RsTUloSnRhSHNHdmRl?=
 =?utf-8?B?a08yZmhuZjFVWFJpbCtFa1ZUdThRNFE1TzlkT253U2NKdEwvZFY2TmNWa1Ru?=
 =?utf-8?B?UHEwb3JFWVFXaklPdEQ1TlFYZVkrdVJzSDJTeDhoQkhxbU5rRGV4TFVSS3dU?=
 =?utf-8?B?WGdEcm05aWpGZFgyY1BOdWRGWXBoSXY4OVBsU2hGb2hSU2M3SXAzaUJmTkN1?=
 =?utf-8?B?YXA2dk0zMGJJTk44NDJ0NTRwdXhQQWVKd3kyVWdFT1pTYis1TVBOTFJENWNE?=
 =?utf-8?B?dnVBOHRBdmZFZVhRb2FyUXlmdDRlelBxc1ZQTXZoRjhuWTc2QngvSytoQ1JR?=
 =?utf-8?B?T1lMTE5KbjJUYnI5TVM0djBqc2NGRTQ3N24vQnBBYlRCQUVJWDZucTJCbFZv?=
 =?utf-8?B?cjFOeHh4N1lVRzJRUk9TMGxPd1owbVMwUXlFUyt0dlVDaUZLaDYxa3QxMmlt?=
 =?utf-8?B?dTlSQlh3OGlkZ0tNNlpEUG8xdHZxWVUrblQ2ZElBSGhSRlFWNVFiR1hzVjl6?=
 =?utf-8?B?MU8yeHFmQUl3T0U5U3VoeFd2T25abWVQb2Ura2hyZ1gvSnh5ZG9mbzNtUnNY?=
 =?utf-8?B?N0Y1eWw2cTF3Vy9VY3Q4Z1h2eGF5NXVKcFJQME9YZDFQU3c2UkFKb0sxbHhw?=
 =?utf-8?B?OTAwZ2N5UDRaU20yYjBabEtUdTlFUk1JYjA5RmRjWnVLUzVaSGlWbDRURUFG?=
 =?utf-8?B?Ujl6RjJzWHRUZDc4clY2bmZnTU1aMG50ODNydEV5K292cjJRSzJPV2JKejkr?=
 =?utf-8?B?Q2JjR2lQT2xGVkRZa2pqQ3lEVzlyL2tZbTA0M3drKzkrU3htendleEZuTUpi?=
 =?utf-8?Q?sUq0qQdjhtySm7gQeiTanYqU9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f406c3f-5643-4f3a-f19b-08dd9e716542
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 05:26:42.7661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HY78d1TEIunfUvbRlOUpCUmhXX0reL5ZbzdVg5lES+AuXUMVBFtxwA6G2k0hq7kTObhWJzJFLobhVzTlgcFefA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5FAA0E762
Received-SPF: permerror client-ip=2a01:111:f403:2414::61e;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

Hi,

On 5/29/2025 3:47 AM, Alejandro Jimenez wrote:
> Correct mistakes in bitmasks, offsets, decoding of fields, and behavior that
> do not match the latest AMD I/O Virtualization Technology (IOMMU)
> Specification. These bugs do not trigger problems today in the limited mode
> of operation supported by the AMD vIOMMU (passthrough), but upcoming
> functionality and tests will require them (and additional fixes).
> 
> These are all minor and hopefully not controversial fixes, so I am sending
> them separately rather than including them on the DMA remap support
> series[0].

Thanks a lot Alejandro. These are very useful/important cleanup/fixes.
We have some more cleanup/fixes. We will base it on top of this series.

-Vasant



> 
> It is unclear how relevant these changes will be to stable releases
> considering the state of the AMD vIOMMU, but the fixes on this series should
> be simple enough to apply, so I Cc'd stable for consideration.
> 
> Changes since v1[1]:
> - Added R-b's from Vasant on PATCH 1-3, 5.
> - P3: Match the spec, although vIOMMU case does not use DTE[3] (Vasant)
> - P4: Fix more definitions using GENMASK64 for consistency. (Sairaj, Vasant)
> - Dropped PATCH 6 from v1 and included it in DMA remap series[0] (Vasant: I
> didn't want to assume approval so I dropped your R-b for this patch when
> moving it to the other series).
> - Fix issue with mask that retrieves the IRT pointer from DTE.
> - Remove duplicated code. Although trivial, I didn't want to sneak this into
> other unrelated commits.
> 
> Tested booting guest with AMD vIOMMU and guest kernel in passthrough mode.
> 
> Thank you,
> Alejandro
> 
> [0] https://lore.kernel.org/qemu-devel/20250502021605.1795985-20-alejandro.j.jimenez@oracle.com/
> [1] https://lore.kernel.org/all/20250311152446.45086-1-alejandro.j.jimenez@oracle.com/
> 
> Alejandro Jimenez (7):
>   amd_iommu: Fix Miscellanous Information Register 0 offsets
>   amd_iommu: Fix Device ID decoding for INVALIDATE_IOTLB_PAGES command
>   amd_iommu: Update bitmasks representing DTE reserved fields
>   amd_iommu: Fix masks for various IOMMU MMIO Registers
>   amd_iommu: Fix mask to retrieve Interrupt Table Root Pointer from DTE
>   amd_iommu: Fix the calculation for Device Table size
>   amd_iommu: Remove duplicated definitions
> 
>  hw/i386/amd_iommu.c | 15 ++++++------
>  hw/i386/amd_iommu.h | 59 ++++++++++++++++++++++-----------------------
>  2 files changed, 37 insertions(+), 37 deletions(-)
> 
> 
> base-commit: 80db93b2b88f9b3ed8927ae7ac74ca30e643a83e


