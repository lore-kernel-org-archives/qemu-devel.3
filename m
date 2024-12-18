Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC462E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuVO-0000yq-2h; Wed, 18 Dec 2024 08:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tNqfn-0003tl-0g
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 04:48:55 -0500
Received: from mail-bn8nam11on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2414::606]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tNqfi-0005CR-4e
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 04:48:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vi1TJ49J7T4Hk96FXuEnpsLd+LzvyhA/VKExQtfNDFTcR42Luj4JC7nQVkq+MMt4UiaBDR/fAbz6XCq1vP9KMJd0z8nN9tsKWav1Q47YuXUuxncHP/KHDiPmAHlNA+oWf2srf1eiPqZ9oJXveSA1YtGdaypaxs4i8cX6UbkP+DPLikXwvJLF8BYxkhZf4KHVzKhSlkzCVJ1ibRw1DUHO+2DL3E1PFsM+9T59zicDP9EwGasSoKSBy3CjRMyUkMiMyNipi/PgkgdoCRrM16sRNFx10WJ5xb+APE5LBzQ1NJmpx5nQmzY1Z6zn4mwiCK5DGE1Gkq6SK4ZBtBok0JplRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHWAT1xz2r975KCRJqna18OBLKb0uPjTML2T6aQyJlY=;
 b=IfySFwjcqRGBI1xD/omi+eze7pEGQ76XrpBlDFvjPo9EipfvooDbVMghLwzabHKTnGR5VaKeo88pH/CAZ7lmvAP0uiPw9WbjD186VWEAdLcDpkjN3vakPMHuW5ZKnlMhCynZB4nInlVG97hp9gBnhylm8b7AvMQ4wkzgh2XMUDIktw0NGlCkSKVO+dcd6DlyBRsG3dyqPFjJQT2O/FyMv+tT6xuDifHZxv5W0B+ueo6BC/nD7geTShwUmzxfdjcV02a3SIqQmMr7/9VVnmjwG1fH3gGAwbMZchFP+7vGK0mfEGRSrtHebPlHc7PeXZIRBdhVPYzBRM2w4DMC2xqlBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHWAT1xz2r975KCRJqna18OBLKb0uPjTML2T6aQyJlY=;
 b=OOizLATGRtFp+CzJApTqDs4tKOjC3vnG3sLXs+7y72+jm2FCP2x5jZ7F1VFopcJdCUz4eQEVuIUuTlTi4DOCiQwJN0+pCfkawP4LRU36PqUw1kLOi/DFzpzli/w9+dV+GduuRCMRBJTXftI+Av2m7JGvlWnnAxlN84qrkqCgyZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ2PR12MB8063.namprd12.prod.outlook.com (2603:10b6:a03:4d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Wed, 18 Dec
 2024 09:48:41 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%3]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 09:48:41 +0000
Message-ID: <61b75143-1dbe-472d-8ab5-bfb6f3a29810@amd.com>
Date: Wed, 18 Dec 2024 15:18:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/amd_iommu: Allow migration
To: Joao Martins <joao.m.martins@oracle.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Wei.Huang2@amd.com, Ruihui.Dian@amd.com, bsd@redhat.com, berrange@redhat.com
References: <20241120073114.20774-1-suravee.suthikulpanit@amd.com>
 <cae2e18a-a090-4bdc-b3b9-cf72393436b0@oracle.com>
 <b2c19675-ba87-499b-aff6-f946d5d25eb8@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <b2c19675-ba87-499b-aff6-f946d5d25eb8@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ2PR12MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe31c7f-7a8f-454b-c0c3-08dd1f49278b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MC93STBUckkvS0tJRk5UOHNkQlRlb1p0OWZHbnptTjEwSVlMMEZuUi85MmVI?=
 =?utf-8?B?L3VvanFPYWxqWGpQT0VJczc0QmRsRUw4NDVEb0g2VU5wR3RVK2I4Vk5Gc2l3?=
 =?utf-8?B?dVVOMCtnb2ZvSVBJU1NlUjd2K3NOSWNCYTlVcHByVzFjYk9zWllDdGY0TjNT?=
 =?utf-8?B?TEtWb2tNYWJtYktmVlVQcE0wd2cwK3lGT0xDazFPOTZuUXl2UndYQUVGTmRu?=
 =?utf-8?B?NHRJd3NFLzdzQzZ3UjMramlnNHZYN0FvL2tGdVFVSFF2c2ZZbDBGaDRvWldz?=
 =?utf-8?B?MUlmQ2FNMExEZXhEYnV4aWFKempiRFg0TmpONzQzUm81ekswMDZGSFE2RE02?=
 =?utf-8?B?VlpHWUNscHNUYlA5d2Uzdk02WnpRSVJnVWxJZmxWcTlVa1J2YnJzNytSa3Nq?=
 =?utf-8?B?UHBwQ1IwbGRoSHFRWDdzM3U2eENKQ0dGNFFybEMyQS9kTlNYVGxUNEZVdG50?=
 =?utf-8?B?c2hwN3FyMUhlU0xjbnUxNEowcktEWkIwY21oZTAxd0h0WUFxR3ozWkhhUDY3?=
 =?utf-8?B?bFViVlFudXBoNlE5Um96M2h1ZkR4S3dTKzFZZTRTOUtOUTd6WHVHWDYxekF3?=
 =?utf-8?B?cGs4REVHMHhJb29DWDBkcyt3V0NxNEJGdnZxYXp2VHZGaERwWWZTa0lGYTRD?=
 =?utf-8?B?K0tRUDcrdXd1S3ZNbUp1SVVyUkRtQTY5aWpvN2kycFZUK2RUMUtNRG1SNWUx?=
 =?utf-8?B?MW80STV6eTc0WGptWWZDSTB5RHczazgvNnEyYTBVL1M5cGFDa0dQTWNsRmpK?=
 =?utf-8?B?RU0yTHBOeWVidFNxUEMxaXdYRG9wTXNCYTBQaExvVDUvWHZJU0NjQVlLZ3hR?=
 =?utf-8?B?OC9sWmRBREgvU205Z1R5QTMxQ0ttSTRyc1N4bnlZbHF1eDNDZ05OTXVkcEUv?=
 =?utf-8?B?VFo4aXAvZ25hMk5DM3E1bjVlbXJEVFNPRmNNdzdJVE4yWktkOEZSS0pwcEg4?=
 =?utf-8?B?Y21uMzQrRnBoc2NuOCtJUnhhQnhKcFBpQ2hDWjFrbnRmajRhb2V2Nk5JRCtQ?=
 =?utf-8?B?RDR2cWhrYis1VkNjVEhSbk5Vbjd3YSs5VlpMVlZrc0s3VTFlZ2V2c2c2NVJv?=
 =?utf-8?B?Y0ljZlN0RXJvaWNpUzlmKzBPNUlhOE1Md040aHQxMUg0bWJBNjRaWDlBMzVI?=
 =?utf-8?B?WlhoUGZjQU40WWhsVnhnVVF4YXNCQkxRUmZkOUNVZDhCY0J1a1QvbWJ1SzhK?=
 =?utf-8?B?MFViYUJQNGljODBxaks1SzlOb0pBdzJkQTZnL2NOeGYrOHU5VVhEYXU2dkhD?=
 =?utf-8?B?YUVRZktSV1BpckZRaWVPMzlIcXhGODFIeUdiOHFTNU9pajBES2ovSjBXMnBr?=
 =?utf-8?B?bU1PeU44bzE2ZUJFTDhMVUxaWEZoVzFsVG8vUE5HSHVxQy9uS3FJOCsrT21x?=
 =?utf-8?B?SXNoKzJzUmd0UGpVYTkxMEZhRWVMZmd4OTErSlJGZ2hPeWEwQmlDeXZOR3dC?=
 =?utf-8?B?L0ZsSnd5bWxLWTB6SGZmWnlFNElHU3l3MzZlQ3FWS05yRzQ4bWNwVFRieWYw?=
 =?utf-8?B?UlF5T3BCRHN2NGl2YjBmZXQ4LzFOUEcwMVFGNEtIQld3dmtIVVI5Q3BpTWFw?=
 =?utf-8?B?MXJMb1RjajZMQlZ6MkFWemtGZFA0MStBV0lJdDFRb2RvWHMrMENpNnVOUG1z?=
 =?utf-8?B?S2FrZ0lyWUpEOVkwTC9qT3lyV3N6cXNLRUFTbWs4bFVEeVRqWW02VnVWdmt3?=
 =?utf-8?B?bmlFM0pUUjdUODFnY1VWSkdmbzZoa3IzMEt3WGNKalFwVDd5RTlSSEhpYVJ2?=
 =?utf-8?B?ZEtZZzRpVXFLMWYwK0QyaGxYTjh0dUlJQjhYRzI0WVVLbWdxUklaYjNWOFJl?=
 =?utf-8?B?MzdIbVlGTHJJQmdzdmY5WWxTTnlhbWgra2VTRWVFc2V5Q1dMYXY1Y2dES1NS?=
 =?utf-8?Q?H0KwI+5afclrl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUlablUxQ054OVZQZFFZbENVZU10OC9hdjYvOUl6bjZaYlpSUFVHL0VTN1pr?=
 =?utf-8?B?NC9aTURYR3NxZnBxMFp1RmEzeE9IS2J4QVZXMXFQL3lISmE4TVNPbktjdkw3?=
 =?utf-8?B?N1lXUDF6K0lObEplTkR5d2pqTGJUbjh4a2hmaUluanc0UDJYTlFkNngvOS8v?=
 =?utf-8?B?ZjZKWCtjZjZ4Z0NnSzZNdzRvM2Z2a3dCNXJGd2tOd1hmQno4TUd4U2dOQk9r?=
 =?utf-8?B?cGQ5TFJ1RFlUbkFyV2lkR3kyUmhWRlp1ZzUxWkpQWmQrR1kvMVhreWVmVXl0?=
 =?utf-8?B?YjFSeGVzUk52S0VFMENqeFFZTTQ3dkUzeUpacVlQQ0djVHJvV0FUM1pvT3Bj?=
 =?utf-8?B?dURxSHVORDgyYkI4RXhOZUIxblJ1MndGV2pQTnBHV1FwQzBWYmR5Rms4TjNm?=
 =?utf-8?B?OGE3NHB1cTJpTVZRR3F0bGhzUUtodDNjQjFzOE1nNFFlSkpYdm1mTVNjYWZw?=
 =?utf-8?B?eTA3M0M0aVlON2Npdjl6VmE1Uk9nOXJCNGZ0UCtXdE5Fck10LzYzZHNVOUND?=
 =?utf-8?B?NEFsV044WlRRb2hoNWtrNHg1WXNzREpRVUdOV3lWSGswZnZMUXo1dlhVUW9o?=
 =?utf-8?B?SXdVY2RsZSs0Q1ptTXhHRzFTWUNMbWdpQVpJZEppTFYzY0Z0a0xuWHROZmZR?=
 =?utf-8?B?UFFMcWNidUgzb1gwajYwYlRzSk5ZK0piZUVVR0gyWUdjSjc4MXVOd2NSQjVp?=
 =?utf-8?B?TGNsbVFkeGRPTk1mUmFGOVlYanlCU1I1bjh0bEc2NXc0RFlYZTVTcENOcU5s?=
 =?utf-8?B?R3FSb1duQjJpL2IvWURwemltKytLSnpjaVYrNzB2ei9pbTNIVE55cXFNOEJU?=
 =?utf-8?B?Tkl6R3czVVJ4bENwMVh5enV1ZmtDSVcxTDArVW13U2h0ZUVPLzBpUlI1SFc3?=
 =?utf-8?B?VG9WYlBRMjJUdjJra0JBNy9UeExsK1BXbS95QzY5bHdUVzc0Nkg3TXhDNnRW?=
 =?utf-8?B?Tjhvb0toYVc1c0c3SDFqRURQNmxZSXpYaEZVUkVJU2JmMjNhc0l4Rm1tY0pn?=
 =?utf-8?B?cjJxT0lleDRwbFB2a1E5TFJreHMyODlBUitUZmZndUZ1dFB6Q0hrVXR2ckxw?=
 =?utf-8?B?NGpaTUk2UCtVek9rUGs1UUhoVFZMNzBZTTU5c3NMTzlxRytnZnFtSk1HZzVP?=
 =?utf-8?B?WlRWRWFiZ0h3aEhoZUxKa3o4Q0t6N0U1ZW04RTNyOThuNjl6emlmNGUrNWlN?=
 =?utf-8?B?d3dzRm92UTJZSTRVOHRyZHppM0pwcGl6aFQ1eVYrbG04Ris4VlQxWGFCVWYz?=
 =?utf-8?B?dllpSDdpMnNHdENxYk1UMHVPYlVxb0tadElya1BiNlREcENhWjR0a3daZ2c5?=
 =?utf-8?B?UnpEM1pFRHJhNGhxc1lOQ0ZUdng3NXF4RnEwSkZBNzd0OG9IM3hxMHQyZUxC?=
 =?utf-8?B?dkt5WXdKSG5oNjMvbWhmTjE2ZTVPNS9NWTZDR2JJM0NlYWhVRExOc2ttVFRC?=
 =?utf-8?B?VFROZ3dTWktCRkxISnZmNzQxaDFTQVJTWVcyYVhnNlNyVTFkbFkxVHJNdEto?=
 =?utf-8?B?T2J2RkdjclUrY3ExZEYvTmh6Ti9IZ3Q5dUdJZDhSYjY4T1JBQ3Q1TnBVbFh5?=
 =?utf-8?B?S0N0MGhyVVpuUXFrWFN0bXNzbmlzN0J1ZEtWaGxFdUgrL0tJK0JYemdSR2lL?=
 =?utf-8?B?TDR6ajEwRW9YK1BqdGtISVVCNzdrdWJSaFl6YzRCRlI5K1o0MWt4dS90bEJs?=
 =?utf-8?B?UkJxSkc0b1J5Mi9QSmRwaTA3a3IzODE1akRySHh0dUJJbDdDekZLNkFaRUJw?=
 =?utf-8?B?ZStFMlNtL1lTYmU5dWM3NElwazlqcitYT2JveDRyd0JCOWZSaU5XdlZqYlB0?=
 =?utf-8?B?WGM2UldLYmtHQmpiRCtndWFYZzdKWVQvYS9XU2lONm9MbzJvMkVaWnExVktF?=
 =?utf-8?B?aEgzNlgzY2xNY3J1NU1DSk1lalBJTmgwQ2NIaldyYzkwZjJzbDRaR2hEeEtz?=
 =?utf-8?B?aEJzWkVOZCtKQWlHSVlqbWc5bDNBZE44TGpaNEt0cWZYbXpHeGJidmp4MGZt?=
 =?utf-8?B?T3NOZkdTYmhlQVNkbXdyK1pIVmY4eUZGbGw4ejlmYW9qK00wdzd4U01VdXQw?=
 =?utf-8?B?TnM4Z01aWlNZYXpxYks3cytoU0dUS29WQ3JrZkRtT2F5QzV1Y051cVE1SFdG?=
 =?utf-8?Q?vWWiShB70fnZtPK0hJ7qPoOU0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe31c7f-7a8f-454b-c0c3-08dd1f49278b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 09:48:41.6725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uss+wlEKPUBFOJ0fEQvnsGG7fUQmtqX2rLP5GiuJwkJjcLYvRPgbq75WflDdJHEsZ8IgeYZOBaqZHKMFxfSRww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8063
Received-SPF: permerror client-ip=2a01:111:f403:2414::606;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Dec 2024 08:54:23 -0500
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

Hi Joao,


On 11/28/2024 10:44 PM, Joao Martins wrote:
> On 21/11/2024 11:42, Joao Martins wrote:> On 20/11/2024 07:31, Suravee
> Suthikulpanit wrote:
>>> Add migration support for AMD IOMMU model by saving necessary AMDVIState
>>> parameters for MMIO registers, device table, command buffer, and event
>>> buffers.
>>>
>>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>> ---
>>>  hw/i386/amd_iommu.c | 36 +++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 35 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>> index 13af7211e1..3d2bb9d81e 100644
>>> --- a/hw/i386/amd_iommu.c
>>> +++ b/hw/i386/amd_iommu.c
>>> @@ -1673,7 +1673,41 @@ static Property amdvi_properties[] = {
>>>
>>>  static const VMStateDescription vmstate_amdvi_sysbus = {
>>>      .name = "amd-iommu",
>>> -    .unmigratable = 1
>>> +    .version_id = 1,
>>> +    .minimum_version_id = 1,
>>> +    .priority = MIG_PRI_IOMMU,
>>> +    .fields = (VMStateField[]) {
>>> +      /* Updated in  amdvi_handle_control_write() */
>>> +      VMSTATE_BOOL(enabled, AMDVIState),
>>
>> no xtsup ?  I guess you are relying on the dest command line having xtsup=on
>> like intel-iommu
>>
> 
> Having said, I think I found a flaw here that sort of "ignores" the default
> command line param of 'device-iotlb' (broad x86-iommu param). By default it
> seems we enable device-iotlb in amd-iommu regardless, even though it's disabled
> by default in qemu command line params.
> 
> Should we enable migration I think stuff like that starts to be important to
> honor given the compability issues we would have to deal apriori. See below on
> how to fix, happy to formally send if what I explained makes sense to all
> 

Below patch looks good. Can you please send formal patch?

-Vasant


