Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C52E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkG9-0003kK-Aa; Thu, 12 Dec 2024 09:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tLkG1-0003jv-AP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:33:37 -0500
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2414::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tLkFy-0000bd-2c
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:33:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTVSFuh8Sd7plQ7CeHXSGE9n+z4D0j3PWczH//VZPZTvrHnT6NikeB/VVlIJg8wgUIGqDb4C6AQQDCeLNfGs0BU77DYhfSxcOu1qesL282plml8g9W+tZZ9P6a5/Ir5s7Qb0xyHCeDFD/mE7wKRMCBOVii4l1r0yu/jJFiavAPBGithEkB5BapvgBynGDJRb3tEtLj5ykBqyvGBiF7jiS2L0qRRLsj3nehXOw8SSXmyp15tdd0ddjkuDBQrgWRgz7UZ58g3y21NJmmrK6GqG3/7uRX0dOUc/mX0li/PNHBCANkyeIJaOwte7ibGgfpsMZ93FwIx0RHVExHGy5g3Avw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRlik7RqkIsRiUnRKb7KwLPHNsywl2KmCpisPIZR4SY=;
 b=G5Viz1VcWCyvv2GIH6Vo4pHuf5tEsITcehjP7T9Q/cX/U2XYB4BGeMSKF26Ke7JgVa5f9jLQM0YYsQEJY1o1Bhw0fLis1zFrcsnUtlvN1ksWNL92+D4mELDBkXAPS12wbvyBAqNvgMqWeCjm8lDLe8l5qv9Tg5dx2veO4/pz4PgDg0qko6yFy+EpEEg1Ro/iyJtoNC+Zecb4dftwnMens0yNtJK0TJMDyiTvaV5EnZkW3uUDiS4nlp4qtm3nIIjwIjJa2htBHG6E6d6mTSVJSgWVK4HpNEyxd1LBtkdYXodMDcgAKUELzQPbH+0ICHBsLr3m2YlSymoCz8T3bqMUQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRlik7RqkIsRiUnRKb7KwLPHNsywl2KmCpisPIZR4SY=;
 b=fTjNSfrm/AL4crVbdh4KVbIrrj0sbL2WRVkYDR0Om/aFLqpjC0N4sj3fE0QuNbhJydvWLdOSCscsDZYVcFm5KTVXqq/WHxPqKvPH8ga9PjrFd7UyETyLCXWbEh7MQMGignGop0Dy3ETYsDi/Q9Za6iDYd4UNp4P6ypPIvCejkjo5VqJ1gELT2SE4PfFMa/fxpTxF19prqd/Lc2NF2lkgt2rZ4C23p0nmwrQqz3SydPCPwcsHs5HcR5pZzCmO6KGLNS2P+Koz3UJqtLFbN+Lm4X7jkbeDeN7tFQj4BcXW6WXf0BDGVLsGWBZNY2+VPof/X/9AEDY6xrDWGJOVZxDk0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 14:33:26 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d%4]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 14:33:26 +0000
Message-ID: <1d12915f-c576-4d13-9706-830c54d11172@nvidia.com>
Date: Thu, 12 Dec 2024 16:33:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/24] vfio/migration: Multifd device state transfer
 support - receive side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <0567baf58cd68716d06cbe4db360149322e0cfcc.1731773021.git.maciej.szmigiero@oracle.com>
 <579c8131-0554-4ea4-b222-36a8a350df02@nvidia.com>
 <9106d15e-3ff5-4d42-880d-0de70a4caa1c@maciej.szmigiero.name>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <9106d15e-3ff5-4d42-880d-0de70a4caa1c@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::18) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: 09911e34-c70a-4b07-2757-08dd1ab9efd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zlg0WWxLQlIwMmhhVWZpYi9oZTFodnVGVkxpVDhQdTRUSDFZdHFwajdUczlT?=
 =?utf-8?B?U0xoZ3IvdmFjeDU5dzBacFVIRTlDbkd1UDFMVWRyMEFMeEFZNmxzV3pPWE9o?=
 =?utf-8?B?TFAvMVpDdjNRc1MrbzM4eS9yZmJ2cFBLMXNsQnFHcUx2elNKc2RxY1l1dWd2?=
 =?utf-8?B?aHpMUDFLc0ptNjJiSnZxTXpiVVd1ZDJWOUIvRkE2VlczaWtpWndTZEhVSy9j?=
 =?utf-8?B?NnVkNFhxYzFIY2IwbG8yQkMxSGFLd2xPTWxVWGVLNUdEaUtab1dKbUh0OGdr?=
 =?utf-8?B?NUx1Y0lnbVBYN0FvelF3VGhpbVlab0xiTnI0L1AraXMvLzJWN0tHOU1KczUx?=
 =?utf-8?B?VnZXOUwycTFrSkllNmc3ZUxpRnZFdkpkQlFxZ2wwUXhJUXpXUmFGdEIrVmlY?=
 =?utf-8?B?SzlKdS94YlFhb0gwdzBJN0pXaFBHVi9MUW1JRWVhMFovbkNUQnA4Zlg2UkJM?=
 =?utf-8?B?NUFzcFZsK3NUTWt4elZ4VE9GRC9OTDVCMGQ3cG5BdVRNbUhSTjNTRlE4ekxI?=
 =?utf-8?B?RHNJZVdNR1BYSUlKUE1Lc3kzR3p2TGdrL1VualRNMHB5TDdJcHJDVHNBbXBP?=
 =?utf-8?B?YTE2Z0VqdFBncS9sUVJmTnpWY216L1R5VmcyVXYwU0FhbUJXRzhuOWFsWEZj?=
 =?utf-8?B?TGVTRTVUMEN3KzRyNWRsaUhVNC9Mdkt6N29weVQrOTMveVl5ZWpySUVFa1Z3?=
 =?utf-8?B?c1IwZlk3S21VazBrUHFneXd6WjhSdU5vc3RLMDJDdUczRGlqNlFVVHd4aVdG?=
 =?utf-8?B?anpCNGdNb1RMbEpZcGVYQ253UHRONzdLWWdCWTRkaElzSmExdlhFcmc1S0V0?=
 =?utf-8?B?UTYxZnhpSjBPaUVuS21TQ1BkSjZ1YXlNMVJDOHFPSFRFaFNjTks0NVFJUEpo?=
 =?utf-8?B?a0drNmkzWENzeGU2a1lzUTJqVk5kZk1qUXZzRVZMZ0orODVsUUtmallBZElU?=
 =?utf-8?B?aElhMVpaRjBXRkNiK3p1bFppa1BPN1B5Z3JqK3FCcmNhSWt4aUExWmpyVGhP?=
 =?utf-8?B?QkFVR2F2RW9BVTBLZnlWdTJJcUZubjBhMndlRTAvay9JRUhER2t3R1cwZk5m?=
 =?utf-8?B?akFtYUV0NXJKL05GSlZScXprRmxNVlkwVUtYSmNhUnprZ3ppSXhsbTVBb0wx?=
 =?utf-8?B?QWFTaXljc3lNZGsvUTV2ZjYzTVB4c0JLTnVuc0NrN3orTndqUkhqWTM2Rk5r?=
 =?utf-8?B?cHZHNGdkRU1hV05MdFd3UmJBd1pqSExPVG1QdVVON055VGNKekRKN1pla0NH?=
 =?utf-8?B?VGttaDhFREgxdzlYSi9GOTJUSkYvMkZ1RmsvQ2NyRkhhRlhSK2N5d2p6VjN1?=
 =?utf-8?B?SERQYldTa1lRcHplTS9IL0prdlNNdFJSZno5cEkzRUhYRisyejd5RHlSYU9W?=
 =?utf-8?B?RGhsRnpOVnBieFhRR3Nyd1RVWEErbGZLZlU0UkR4eFZRMlVQWmtsSFlGNGww?=
 =?utf-8?B?dGVBRHZlbWkzVEQ5V0FTOWRrZjZTUHRZVzNWYklva0JDcmFJZkhqa0djN2I0?=
 =?utf-8?B?Q3BiRGlvL3QzQmhTc3l6L2FISG12TlgrOExFbGgyejJLdERtU1lVOUZsdjgy?=
 =?utf-8?B?QXlhWEdHOUJIRnBzV3htVUFrSGd3RDN3Q1JjL0lmaEIvbDlMeThqVnBwNVNl?=
 =?utf-8?B?L0JSUVpuSVNHMFVXLzJoUDc2SmN4d21uUEtSY2VSYmIrUEd2WkxUd00yOFFt?=
 =?utf-8?B?VFAvQjVNRGJLZ2VTb3BwR0VJZTg0alBXWVRZZ2pGekFCTHRFYVd4S1VyZ293?=
 =?utf-8?B?SWd6YnBLeG1iVHBxdEtHTVQ5cmhXWHpqR3NDelV6dUt6Qm1pb3ZGMldZUlJZ?=
 =?utf-8?B?aUpES2phSEVhVUpQVzJKUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW9pUC9yb1N3Tlo2SVkwaFEyb1dXS3ZBa2lEQjBQYkhwbDBrNjRRb1MrVkU5?=
 =?utf-8?B?b3VRMXZpcVgwSDdUNUVHNDJxSzRkMEU4NGFmK1JRNkw2U1dCS3BXVDNIR0ty?=
 =?utf-8?B?Mm1neFNRUi8rVnM4d2wzR1R3NE9WRWlRczc3WVY5Q21kQkRyNExPQ1JPZkRD?=
 =?utf-8?B?T1FuOWlJVVdBdkEwSlMxc3prUVd0ekkyeGFUMWxvZUhQZ3FGU2tSVWFYbGln?=
 =?utf-8?B?SCtpVzc2bFZUK3dYeURONnNpS3k2ZThGbW9BUFhleVFySXpXV25rUFZSOEJx?=
 =?utf-8?B?TkJORUUwN1BhMGpXNkJ1Y1g4ekZ3THVOVkNmbURCaktyTGlvbmFVR1llTksw?=
 =?utf-8?B?ZGxialBzYXdPbWRzdUJZcHNxaGNjTVFMUU9XUjRtai9yb0pobmFGckNxbk51?=
 =?utf-8?B?YlBLbUhFQXJZaDVSdVl3Y3lJSDg4dHNieWZhNy9TTmFRTEdWNEJVY1kySU10?=
 =?utf-8?B?a0UybmVvcHlObXc5bXd2SjVvd1BTNjFvWlJvOEdEaDJITUlwZ0NhSDc3eVM3?=
 =?utf-8?B?TVcvODc5cno5cHpLakdlRWw5QktxZklWdXU5UmhkQVpzdUVuV2g5czMrWW95?=
 =?utf-8?B?b204SWtacDVQbGV4WHRtRFlFVnM5MnZRR0RlM2c1KytDYkYrWGZrMXVYNFlz?=
 =?utf-8?B?UVA1Yy9mL3Z3YUtEUzZUczB3VHBDSFVjd3dWQVg1U0lxT0t1Ui8rNXBQOFVP?=
 =?utf-8?B?eFo1T0ttdHc2ajFnWDYrOWN0ZUtsemNYNEJNb1JLMTA0d3ZNNHpaVWdjNUR3?=
 =?utf-8?B?Wk1zNUxyWVhNU1EybFh4RG54eC9mSnV5NEF4QjM1dXdIUEtHR2g2b0Npaldk?=
 =?utf-8?B?c3Q4WjVOMXJGRW4wd2J4SlVuZUlGTVpqRTdYZ1ZhOGovamVpMEI3NE5rNlds?=
 =?utf-8?B?SmRldE9sUWxMYWRZcTMxd25ybi96SHo2dGsvN0Rlc3VYdmNzdVBtZmJ6VTJq?=
 =?utf-8?B?RExVaWdDMVZOc25EZDZUK2pVRjltY1pORWNSaWdrV2w1KzUyS0d5TmVZM1hX?=
 =?utf-8?B?ZmVsZHRkRmllYmlPbWdWdHNOc0UrcUhWLzZOK1NYclFaU08vT3FSRzdIc1dZ?=
 =?utf-8?B?RTBhaEhPQlBhMWdnMU5FbWpKT1pVeGt3YVJuK0lBTTZkWXVBam5JZ3NSZTN5?=
 =?utf-8?B?RDFBS3d3K2JtWHF0d1RZN3dwMzBqSkJHdlZlaGR0TWdmR2ZuWGVBZlVqZXV4?=
 =?utf-8?B?R2E0aHNmanluS2JKNjQ3bW83SEFxK2NZY0NjSS8raEo4elNQZis5TEJPZyts?=
 =?utf-8?B?MjdVSk94UlY4MEF5RmlYaFNUZ0t6ME5iOVVNY25XMkhmRHJ3R2crK0doeVRN?=
 =?utf-8?B?RmdEODl0SHBXeEw5aEhpQVdkWC9LUkJySHgrRmNWUFNQckJoZXJKRC9oWWZw?=
 =?utf-8?B?Yld5OTRMczFIL2FTZjJnbStSbytYOE9VTUtqSUd5d3pxb0tQZDNwblZZN0dJ?=
 =?utf-8?B?QnRPalZ0K0pVVEVSRFVPbFdsblJvT1dFekxlM25yZ3VTVkFaaWdmOXhmbTNj?=
 =?utf-8?B?Y1VuVk9CMjA1SXNQd01pcnh6MWFkcENKTnlkVENZVk5yU080WVpMSnljTEE1?=
 =?utf-8?B?NzFySGtCT2ovKzRYcVFnOG9yd24veFNEc3hTTkRIZ1JoUHN2dXU4NlVwaG0r?=
 =?utf-8?B?WFYraWlYSUNtc1pmQlNWUlhCSWxSY3BDVzMzM2dIbjhzRUNtbFUvMXJWdW9l?=
 =?utf-8?B?UkM5QXN1QmxZUFZVbzJaaGhIL3B6WG80OEJWV2RkdFlTZUtYNmtTajNoUnJi?=
 =?utf-8?B?dXJha1gyeXdFTDN0WUZ4WWViTDg2Ky9wN3ZqOFVzTlI3RWpkc2Y2SWlObit0?=
 =?utf-8?B?VlpBdE9WWStQU3pCNnMxNThOaUd4L2oydlh0NE8wbE5Mcm1TUldIQVdNRUo2?=
 =?utf-8?B?Und3MENzQXhVZjI3WmFTaHg0a1lid29DZUgrbnh3TzBEd2s3TGh2MnFFbDFD?=
 =?utf-8?B?d1BvU3ZkOGFlbW00ZjZmMVl5Z056RXFHUWJWL2VXd2ozdVRjRHhabGc0bU94?=
 =?utf-8?B?NTRnQmVQOU1oZ1RYS0ZYQ3czVXM0b2FabHBqRTlQdndXSmxhN2JyVEhlR01q?=
 =?utf-8?B?dGZOMEI5bCszOHk3aHBXUWJHOXpoMjBQS0YxNjVWdmc0N3l3Rm8zdDRDZjRh?=
 =?utf-8?Q?WDPGtYLXOlFtmnYCoG404iMPs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09911e34-c70a-4b07-2757-08dd1ab9efd0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 14:33:26.4222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvDRMyufHZbdgZstKq8+3y8qJILrG1vA/Qpb1I89ilzYU/0AzRytkO72cvyVi7toP0Bmqy+0u59UaLAusG3kJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399
Received-SPF: softfail client-ip=2a01:111:f403:2414::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
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


On 11/12/2024 1:06, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Avihai,
>
> On 9.12.2024 10:13, Avihai Horon wrote:
>> Hi Maciej,
>>
>> On 17/11/2024 21:20, Maciej S. Szmigiero wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> The multifd received data needs to be reassembled since device state
>>> packets sent via different multifd channels can arrive out-of-order.
>>>
>>> Therefore, each VFIO device state packet carries a header indicating 
>>> its
>>> position in the stream.
>>>
>>> The last such VFIO device state packet should have
>>> VFIO_DEVICE_STATE_CONFIG_STATE flag set and carry the device config 
>>> state.
>>>
>>> Since it's important to finish loading device state transferred via the
>>> main migration channel (via save_live_iterate SaveVMHandler) before
>>> starting loading the data asynchronously transferred via multifd the 
>>> thread
>>> doing the actual loading of the multifd transferred data is only 
>>> started
>>> from switchover_start SaveVMHandler.
>>>
>>> switchover_start handler is called when MIG_CMD_SWITCHOVER_START
>>> sub-command of QEMU_VM_COMMAND is received via the main migration 
>>> channel.
>>>
>>> This sub-command is only sent after all save_live_iterate data have 
>>> already
>>> been posted so it is safe to commence loading of the 
>>> multifd-transferred
>>> device state upon receiving it - loading of save_live_iterate data 
>>> happens
>>> synchronously in the main migration thread (much like the processing of
>>> MIG_CMD_SWITCHOVER_START) so by the time MIG_CMD_SWITCHOVER_START is
>>> processed all the proceeding data must have already been loaded.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   hw/vfio/migration.c           | 402 
>>> ++++++++++++++++++++++++++++++++++
>>>   hw/vfio/pci.c                 |   2 +
>>>   hw/vfio/trace-events          |   6 +
>>>   include/hw/vfio/vfio-common.h |  19 ++
>>>   4 files changed, 429 insertions(+)
>>>
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 683f2ae98d5e..b54879fe6209 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -15,6 +15,7 @@
>>>   #include <linux/vfio.h>
>>>   #include <sys/ioctl.h>
>>>
>>> +#include "io/channel-buffer.h"
>>>   #include "sysemu/runstate.h"
>>>   #include "hw/vfio/vfio-common.h"
>>>   #include "migration/misc.h"
>>> @@ -55,6 +56,15 @@
>>>    */
>>>   #define VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE (1 * MiB)
>>>
>>> +#define VFIO_DEVICE_STATE_CONFIG_STATE (1)
>>> +
>>> +typedef struct VFIODeviceStatePacket {
>>> +    uint32_t version;
>>> +    uint32_t idx;
>>> +    uint32_t flags;
>>> +    uint8_t data[0];
>>> +} QEMU_PACKED VFIODeviceStatePacket;
>>> +
>>>   static int64_t bytes_transferred;
>>>
>>>   static const char *mig_state_to_str(enum vfio_device_mig_state state)
>>> @@ -254,6 +264,292 @@ static int vfio_load_buffer(QEMUFile *f, 
>>> VFIODevice *vbasedev,
>>>       return ret;
>>>   }
>>>
>>> +typedef struct VFIOStateBuffer {
>>> +    bool is_present;
>>> +    char *data;
>>> +    size_t len;
>>> +} VFIOStateBuffer;
>>> +
>>> +static void vfio_state_buffer_clear(gpointer data)
>>> +{
>>> +    VFIOStateBuffer *lb = data;
>>> +
>>> +    if (!lb->is_present) {
>>> +        return;
>>> +    }
>>> +
>>> +    g_clear_pointer(&lb->data, g_free);
>>> +    lb->is_present = false;
>>> +}
>>> +
>>> +static void vfio_state_buffers_init(VFIOStateBuffers *bufs)
>>> +{
>>> +    bufs->array = g_array_new(FALSE, TRUE, sizeof(VFIOStateBuffer));
>>> +    g_array_set_clear_func(bufs->array, vfio_state_buffer_clear);
>>> +}
>>> +
>>> +static void vfio_state_buffers_destroy(VFIOStateBuffers *bufs)
>>> +{
>>> +    g_clear_pointer(&bufs->array, g_array_unref);
>>> +}
>>> +
>>> +static void vfio_state_buffers_assert_init(VFIOStateBuffers *bufs)
>>> +{
>>> +    assert(bufs->array);
>>> +}
>>> +
>>> +static guint vfio_state_buffers_size_get(VFIOStateBuffers *bufs)
>>> +{
>>> +    return bufs->array->len;
>>> +}
>>> +
>>> +static void vfio_state_buffers_size_set(VFIOStateBuffers *bufs, 
>>> guint size)
>>> +{
>>> +    g_array_set_size(bufs->array, size);
>>> +}
>>
>> The above three functions seem a bit too specific.
>
> You asked to have "full API for this [VFIOStateBuffers - MSS],
> that wraps the g_array_* calls and holds the extra members"
> during the review of the previous version of this patch set so here it 
> is.
>
>>
>> How about:
>> Instead of size_set and assert_init, introduce a 
>> vfio_state_buffers_insert() function that handles buffer insertion to 
>> the array from the validated packet.
>>
>> Instead of size_get, introduce vfio_state_buffers_get() that handles 
>> the array length and is_present checks.
>> We can also add a vfio_state_buffer_write() function that handles 
>> writing the buffer to the device.
>>
>> IMHO this will also make vfio_load_state_buffer() and 
>> vfio_load_bufs_thread(), which are rather long, clearer.
>
> I think it would be even nicer to keep vfio_state_buffer_*() methods 
> as thin wrappers
> (low level API) and introduce intermediate API doing more or less what 
> you have
> described above to simplify vfio_load_bufs_thread() (and possibly 
> vfio_load_state_buffer() too).

Yes, enriching the APIs sounds good.

Thanks.

>
>>> +
>>> +static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers 
>>> *bufs, guint idx)
>>> +{
>>> +    return &g_array_index(bufs->array, VFIOStateBuffer, idx);
>>> +}
>>> +
>>> +static int vfio_load_state_buffer(void *opaque, char *data, size_t 
>>> data_size,
>>> +                                  Error **errp)
>>> +{
>>> +    VFIODevice *vbasedev = opaque;
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    VFIODeviceStatePacket *packet = (VFIODeviceStatePacket *)data;
>>> +    VFIOStateBuffer *lb;
>>> +
>>> +    /*
>>> +     * Holding BQL here would violate the lock order and can cause
>>> +     * a deadlock once we attempt to lock load_bufs_mutex below.
>>> +     */
>>> +    assert(!bql_locked());
>>> +
>>> +    if (!migration->multifd_transfer) {
>>> +        error_setg(errp,
>>> +                   "got device state packet but not doing multifd 
>>> transfer");
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (data_size < sizeof(*packet)) {
>>> +        error_setg(errp, "packet too short at %zu (min is %zu)",
>>> +                   data_size, sizeof(*packet));
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (packet->version != 0) {
>>> +        error_setg(errp, "packet has unknown version %" PRIu32,
>>> +                   packet->version);
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (packet->idx == UINT32_MAX) {
>>> +        error_setg(errp, "packet has too high idx %" PRIu32,
>>> +                   packet->idx);
>>> +        return -1;
>>> +    }
>>> +
>>> + trace_vfio_load_state_device_buffer_incoming(vbasedev->name, 
>>> packet->idx);
>>> +
>>> +    QEMU_LOCK_GUARD(&migration->load_bufs_mutex);
>>> +
>>> +    /* config state packet should be the last one in the stream */
>>> +    if (packet->flags & VFIO_DEVICE_STATE_CONFIG_STATE) {
>>> +        migration->load_buf_idx_last = packet->idx;
>>> +    }
>>> +
>>> + vfio_state_buffers_assert_init(&migration->load_bufs);
>>> +    if (packet->idx >= 
>>> vfio_state_buffers_size_get(&migration->load_bufs)) {
>>> + vfio_state_buffers_size_set(&migration->load_bufs, packet->idx + 1);
>>> +    }
>>> +
>>> +    lb = vfio_state_buffers_at(&migration->load_bufs, packet->idx);
>>> +    if (lb->is_present) {
>>> +        error_setg(errp, "state buffer %" PRIu32 " already filled",
>>> +                   packet->idx);
>>> +        return -1;
>>> +    }
>>> +
>>> +    assert(packet->idx >= migration->load_buf_idx);
>>> +
>>> +    migration->load_buf_queued_pending_buffers++;
>>> +    if (migration->load_buf_queued_pending_buffers >
>>> +        vbasedev->migration_max_queued_buffers) {
>>> +        error_setg(errp,
>>> +                   "queuing state buffer %" PRIu32 " would exceed 
>>> the max of %" PRIu64,
>>> +                   packet->idx, 
>>> vbasedev->migration_max_queued_buffers);
>>> +        return -1;
>>> +    }
>>
>> Copying my question from v2:
>>
>> Should we count bytes instead of buffers? Current buffer size is 1MB 
>> but this could change, and the normal user should not care or know 
>> what is the buffer size.
>> So maybe rename to migration_max_pending_bytes or such?
>>
>> And Maciej replied:
>>
>> Since it's Peter that asked for this limit to be introduced in the 
>> first place
>> I would like to ask him what his preference here.
>> @Peter: max queued buffers or bytes?
>>
>> So Peter, what's your opinion here?
>>
>>> +
>>> +    lb->data = g_memdup2(&packet->data, data_size - sizeof(*packet));
>>> +    lb->len = data_size - sizeof(*packet);
>>> +    lb->is_present = true;
>>> +
>>> + qemu_cond_signal(&migration->load_bufs_buffer_ready_cond);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int vfio_load_device_config_state(QEMUFile *f, void *opaque);
>>> +
>>> +static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
>>> +{
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    VFIOStateBuffer *lb;
>>> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
>>> +    QEMUFile *f_out = NULL, *f_in = NULL;
>>> +    uint64_t mig_header;
>>> +    int ret;
>>> +
>>> +    assert(migration->load_buf_idx == migration->load_buf_idx_last);
>>> +    lb = vfio_state_buffers_at(&migration->load_bufs, 
>>> migration->load_buf_idx);
>>> +    assert(lb->is_present);
>>> +
>>> +    bioc = qio_channel_buffer_new(lb->len);
>>> +    qio_channel_set_name(QIO_CHANNEL(bioc), 
>>> "vfio-device-config-load");
>>> +
>>> +    f_out = qemu_file_new_output(QIO_CHANNEL(bioc));
>>> +    qemu_put_buffer(f_out, (uint8_t *)lb->data, lb->len);
>>> +
>>> +    ret = qemu_fflush(f_out);
>>> +    if (ret) {
>>> +        g_clear_pointer(&f_out, qemu_fclose);
>>> +        return ret;
>>> +    }
>>> +
>>> +    qio_channel_io_seek(QIO_CHANNEL(bioc), 0, 0, NULL);
>>> +    f_in = qemu_file_new_input(QIO_CHANNEL(bioc));
>>> +
>>> +    mig_header = qemu_get_be64(f_in);
>>> +    if (mig_header != VFIO_MIG_FLAG_DEV_CONFIG_STATE) {
>>> +        g_clear_pointer(&f_out, qemu_fclose);
>>> +        g_clear_pointer(&f_in, qemu_fclose);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    bql_lock();
>>> +    ret = vfio_load_device_config_state(f_in, vbasedev);
>>> +    bql_unlock();
>>> +
>>> +    g_clear_pointer(&f_out, qemu_fclose);
>>> +    g_clear_pointer(&f_in, qemu_fclose);
>>> +    if (ret < 0) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static bool vfio_load_bufs_thread_want_abort(VFIODevice *vbasedev,
>>> +                                             bool *abort_flag)
>>> +{
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +
>>> +    return migration->load_bufs_thread_want_exit || 
>>> qatomic_read(abort_flag);
>>> +}
>>> +
>>> +static int vfio_load_bufs_thread(bool *abort_flag, void *opaque)
>>> +{
>>> +    VFIODevice *vbasedev = opaque;
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    QEMU_LOCK_GUARD(&migration->load_bufs_mutex);
>>
>> Move QEMU_LOCK_GUARD() below the local var declaration?
>> I usually don't expect to see mutex lockings as part of local var 
>> declaration block, which makes it easy to miss when reading the code.
>> (Although QEMU_LOCK_GUARD declares a local variable under the hood, 
>> it's implicit and not visible to the user).
>
> I guess you mean moving it..
>
>>> +    int ret;
>
> ^ ..here.
>
> Will do.
>
>>> + assert(migration->load_bufs_thread_running);
>>> +
>>> +    while (!vfio_load_bufs_thread_want_abort(vbasedev, abort_flag)) {
>>> +        VFIOStateBuffer *lb;
>>> +        guint bufs_len;
>>> +        bool starved;
>>> +
>>> +        assert(migration->load_buf_idx <= 
>>> migration->load_buf_idx_last);
>>> +
>>> +        bufs_len = vfio_state_buffers_size_get(&migration->load_bufs);
>>> +        if (migration->load_buf_idx >= bufs_len) {
>>> +            assert(migration->load_buf_idx == bufs_len);
>>> +            starved = true;
>>> +        } else {
>>> +            lb = vfio_state_buffers_at(&migration->load_bufs,
>>> + migration->load_buf_idx);
>>> +            starved = !lb->is_present;
>>> +        }
>>> +
>>> +        if (starved) {
>>> + trace_vfio_load_state_device_buffer_starved(vbasedev->name,
>>> + migration->load_buf_idx);
>>> + qemu_cond_wait(&migration->load_bufs_buffer_ready_cond,
>>> + &migration->load_bufs_mutex);
>>> +            continue;
>>> +        }
>>> +
>>> +        if (migration->load_buf_idx == migration->load_buf_idx_last) {
>>> +            break;
>>> +        }
>>> +
>>> +        if (migration->load_buf_idx == 0) {
>>> + trace_vfio_load_state_device_buffer_start(vbasedev->name);
>>> +        }
>>> +
>>> +        if (lb->len) {
>>> +            g_autofree char *buf = NULL;
>>> +            size_t buf_len;
>>> +            ssize_t wr_ret;
>>> +            int errno_save;
>>> +
>>> + trace_vfio_load_state_device_buffer_load_start(vbasedev->name,
>>> + migration->load_buf_idx);
>>> +
>>> +            /* lb might become re-allocated when we drop the lock */
>>> +            buf = g_steal_pointer(&lb->data);
>>> +            buf_len = lb->len;
>>> +
>>> +            /*
>>> +             * Loading data to the device takes a while,
>>> +             * drop the lock during this process.
>>> +             */
>>> + qemu_mutex_unlock(&migration->load_bufs_mutex);
>>> +            wr_ret = write(migration->data_fd, buf, buf_len);
>>> +            errno_save = errno;
>>> + qemu_mutex_lock(&migration->load_bufs_mutex);
>>> +
>>> +            if (wr_ret < 0) {
>>> +                ret = -errno_save;
>>> +                goto ret_signal;
>>> +            } else if (wr_ret < buf_len) {
>>> +                ret = -EINVAL;
>>> +                goto ret_signal;
>>> +            }
>>
>> Should we loop the write until reaching buf_len bytes?
>> Partial write is not considered error according to write(2) manpage.
>
> Yes, it's probably better to allow partial writes in case
> some VFIO kernel driver actually makes use of them.
>
>>
>> Thanks.
>
> Thanks,
> Maciej
>

