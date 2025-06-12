Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517DAC71141
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 10:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPfK9-000057-Co; Thu, 12 Jun 2025 06:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uPfK4-0008WH-Gb
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 06:38:16 -0400
Received: from mail-mw2nam04on20623.outbound.protection.outlook.com
 ([2a01:111:f403:240a::623]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uPfJf-00080B-UW
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 06:38:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbIaQZgznKlLlH/mvSmpBG/Q2V68rIw8Aa+Tvz9gwxuxxxeUok6hbvP9Hup/TYqZKEGkI0rhRD1nOrsMwqhJdOIezObRUtqBYIRKDQGLUMBxOPWnZUx+yvGAkCJybLjn7STYeUKSfEIJz9gyuom7ZgNVRZVgmEaPqGMauJOsEKeKLi7l0sdv1ZQ1O0e41qF2wGBOeiA5o+D2Sc3zQNpntM7Mv36irh/ac0DWwmZCTNGwpxSBx+58BzQfXGbln25pB8X8s/0kNj+ELSGVORSJc7fl9o0aMQcnYGYQ1bii93A2W7MI4kqtvC2j6NC+LWFqZYrz8OwC7qZi1atf5PA5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cg1yrxtBNtLLauTL2SuyUA04gvNCLG6liuTQfOYXwqs=;
 b=y1BRAGYfUayzBHXx/7JSaTZbEVn7OpIZzx4qv0AoNaNqiJc6L3kedoFXdb7gv3+AskA1DwArPV/O7eq2YqaR0wQYiXhLu/ok6i28A4Es0EeGP1+JHc6PfriO3XWd2lHzWGRWmqmzvPljWPYXfq5voIn9xd1BvrRQWPqh1BFal/7cpNcrj9GAjQZb+JteXqZ1Tz9L2rfGNf6q3fv7SN7E0tm2P8z7BmkgxRese9/24p2SDmjYvMmT90Z+Bt1npbvOlhoFsnfEGLPPMG2dMrR8o5r0+voB6ay8xWb4nKlnilMHOwmL5aZqJU7D9BKlc/mrOR7QI35v9H04bu3HcInXVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cg1yrxtBNtLLauTL2SuyUA04gvNCLG6liuTQfOYXwqs=;
 b=dhdqztdAqXjy3wO7gcU99ocYC2OKlQb3oe2soZrvVtm7li9Q+5Yvc0nDBTekJ+KV8wW/u7qmSic9yn6GKwjY6N9I9H/+VcdZ0iK+Bzox7IadSvFsxS4Cjcr3KPQPeDctL/+2WBP5VxURFB4hMR3wG7rc8r9KPhCDv/yLIZLDY1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.39; Thu, 12 Jun 2025 10:37:28 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 10:37:28 +0000
Message-ID: <34197439-8045-4fee-8fcf-4fad005379a6@amd.com>
Date: Thu, 12 Jun 2025 16:07:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/20] amd_iommu: Return an error when unable to read
 PTE from guest memory
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com, sarunkod@amd.com,
 Wei.Huang2@amd.com, clement.mathieu--drif@eviden.com,
 ethan.milon@eviden.com, joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-7-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250502021605.1795985-7-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aff5dd5-df72-4baa-bcb5-08dda99d20c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlJPdy9vR1JqS29EbzhWM3pFczYrQlVncVB3ZE56NDR2dEpxOEc0ZnpsSjRl?=
 =?utf-8?B?enJ5Y21jK04rTS9Cdk43VGJDaEkyS2tzWElRWXF1U0o0dUR5WkxDaWl2WXpS?=
 =?utf-8?B?RE0xTXJyYzZoZkJXelNsWlpsNXovcHlaVm5rVkdsTC9wVWtCbllOVEhJOTkx?=
 =?utf-8?B?bllkYldKRWxGZldJbndGNTBPc3dBMzI0enFNVjAvS3RpR3pTb2trYTkvcWVx?=
 =?utf-8?B?ZVhicENmOVBoNFEyOVU4UkFCRFMvU3RZT2xkN1VOUG9jdHl5TUZabWhOTmUv?=
 =?utf-8?B?TW42NTUyVUlpMHFUTUVLVXF2aUNUOURXWk1mL3ZLeTNzQW1XbU45SlFCMTdU?=
 =?utf-8?B?TmdXdGx2VlNmWGI4TWVPUXpHUkRpTkU3TDVJOGQ4UnE0cnE5L013aWJaRENn?=
 =?utf-8?B?UjFlOUNMWVJFSFkwQjdKTzBKOUpXdXpBRDBUTE15TFNNWXR3cWI0SkVsbFlw?=
 =?utf-8?B?SU1HRjc3TjFDYzVqMTJTMTQvV0RMVzJ1UXM1UDVNUG05UUZMNHpEa0N6OGI5?=
 =?utf-8?B?empuUXZ1bmkybWZGTGJqV0UyV245Y2FRZzdnejBTSkdYMlExeEFMY2tCcStx?=
 =?utf-8?B?ZEVQV3JLcjNJSjY0dVJCcFZudVdzNVVNbWtXTzc5bG94aWh2UkJVZ3NqN2ow?=
 =?utf-8?B?a1JNQVBpNllvM3JyOEd0Q0QrbUdxWHFGOW0yNTE5NjY1cEZOMUErWHRja3hh?=
 =?utf-8?B?ZmNBMGZUeXF2MjZkWEtFQllZRmhwQkJFSmRDWDUrQWlUVGZ0SEJZZGM1NWdE?=
 =?utf-8?B?OUJmYk1nSHhWWjRUeU9nY2ppSWVGa3FpZXJzdlUwWVgyNEVGOUp1OS91MXhP?=
 =?utf-8?B?d0t1K25Eajg3ZnNxV2txZWxDb1lRT2thUDZNUG1ReU51R2ZEclVBME1jVnRz?=
 =?utf-8?B?Q0QxZFN4bmFLbTRHbGxrbGxWMHJBd0tRZU04S2pOMmpoZHc5OERMTTcrOEhn?=
 =?utf-8?B?VVZxeUJUNkx2YWpHbW16MGl2L3NlWjNEdmtkamt4R0xwTVZXeWZJSVVFOVJF?=
 =?utf-8?B?UWxFZC9nNjQwTVlvenhhR3ZOSjl2ajFWQkpSUXMzV3VLRzRkV0VpdFBIOCth?=
 =?utf-8?B?UnlQdkFyWFVWREVydzNhN0MrVTBHM1MyTzR4RVhPemN5TElFMUFVTGdQSkFM?=
 =?utf-8?B?VmpTMDlNTlZDM0RBd1BCSExxenQwKzhSQTZ3K00zV0lIenNvWnVtWjV0VGpD?=
 =?utf-8?B?cDZ6Y3h0cDRsU0ZrYURmYXFzU2lGNWZEdFliUGZRUjFrSm9Wc1hibTIwS1VG?=
 =?utf-8?B?aEs2VWlFNXBRbTI4MlM3VEh5RytFcW93N3h3WE5UMTRLTFVKd1dWZTgzblpW?=
 =?utf-8?B?elNLYjlNc0hwMjdmaDhSNytpNFBiNk9hQWdOSC8yaWxvOUJWRTA0SmFpNmxt?=
 =?utf-8?B?OXBodWxmdCtHNW55S2tCdjlGdGluNDlyZHN2bWlOc1QyY3FHWUJPVGg4a2lG?=
 =?utf-8?B?ZkxpRFdmWEMwc2RHUVRweFFWV0czb2l3RDJISUR3UXFwbHNhQVM1d1JsdXFC?=
 =?utf-8?B?YVdFdkhjVHRTVk5uMzhMcTVYbjRBQWRjWCs1NldHY0l0cUcxNm9zcG1wK2hv?=
 =?utf-8?B?Mzc3RVl4SUtYR3lUMUQ2eHozbTgzb2pTVThmcVJaa3cyamR1MExKaUdsbVJS?=
 =?utf-8?B?V3pja3hKb3EzZGhXK3lBODM2SDZhM1JJTUQyV0xJSFdneHA1UWI3WlB1UzRZ?=
 =?utf-8?B?RHJSdmpwYTdSZW82c29sMlBiYm9vR0YxZGlTYlFHS2lXVCt5Zkw0Rm9jTXpR?=
 =?utf-8?B?YWVRM3k2S3RVaTNEYmZNTGV2L2pwYUhPVEVlSDNBRzBhMm5CZk5wSTRjNlJ6?=
 =?utf-8?B?dHJtVEVJZWFOTGNSdTJ3dWN6ZzZMdHoya1JyaWorbGxrUWpqOVFaRzZpYTla?=
 =?utf-8?B?K28vWUtIM1FyVEFVWG0rdzBET21aME9icmpMenZXUCtGNVNPZHBwaXVrVEV2?=
 =?utf-8?Q?wUgzoMogqR4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG1Cd1Z1Wm9yZ1UrellTQmJkTWJHYm1weis2anBudVdGcjBkMGhDUmcveDc1?=
 =?utf-8?B?YWl3cFJtemRFVHhKMGdRWnRVdUV6Q0RSbTZTLzd4RlZXb1ZwVlVTaW4vR1Z3?=
 =?utf-8?B?cGsyeE1wVVFpT201SFo5U3NGN1FuRmljSERmYmhyM0FwU1RxbUNHTi96S1Jp?=
 =?utf-8?B?M3A4T1RUM3ZIZHVuWjJqM0hiTDhuZUdmcWp3dXNjbDVQVFFXcGErbzdsbzNp?=
 =?utf-8?B?NmZhZGF6ZEhWMnRRV0tMV2NaV2tMNXVBQ1FRSUlHeTlCbjFLUGVHQStuWmp6?=
 =?utf-8?B?QmtkQ0d2cXdpSlFrU0s4TE0zc3ptWVQzZFEwVGhGU2N4QVhlOXBrVGVsVjhj?=
 =?utf-8?B?ODJnU2NqYXM4ejhBc2dHbkFsMnFqeE4vbmdSNDFNR1FFNzVvTjdIcEJlSG9N?=
 =?utf-8?B?MzU3K2RDTFZGc3lIV3dtbEZsWmtSNktFdFo2U1N6R3NHQml3NlhRa2hDbGZW?=
 =?utf-8?B?YklCQTkyQXJ3aDZzN1Q2QmVvdS9rd2hzNUtpbUIrSVlCMDJtcnZ6WG0zZVJx?=
 =?utf-8?B?R2EyV2NlQUdsaFA4WFRLVzNpRk8ydHBnem11S0xZS05BSU1CUHREMm9hNmg4?=
 =?utf-8?B?Q2tyOWFIM2ZnV0NZRklpNzBOYUx4bExaMnZockRnZiswZlp4MXR6MzQ1aEVJ?=
 =?utf-8?B?TzBEQjk4NUJ5eDdQM1E1VHJBRm02YlhoRFZkRlVBWEdBbmxYWmszS3RuZGF6?=
 =?utf-8?B?dUlvZ3ZJZlVCNGQ5QmtHOEl4VUdGODRVWnhmUFk4cTZ5a3VRR3k1ZmNoQ08y?=
 =?utf-8?B?ajRNUkVFQ1htVGYzVWM3RlVabVA3OXZhYkpSeHI3dm1jNUdxVlgzSkxYalMr?=
 =?utf-8?B?ejVma29WUFh3ZjVHL0ROL2lEZXVIcUY1eWh5bklHTnU3UnN6aVBTU05zTUNX?=
 =?utf-8?B?VkQxUmFwTjk4WWhCUnA4WW5qaWNwTm9kUmhxcGV1R3NFQXhvODdNZ1JoQkh0?=
 =?utf-8?B?RXoyMGpwa1lrOE1DdEErMmgxUEdoZ2lCczJLUlkrZTduZk1ES1RIdFVsZmNL?=
 =?utf-8?B?cXNPbzc4dnMxaWFwVmlNK3ZIT2ZySUJLRzJHd2VqakZWVERJZ283SGhMOUdq?=
 =?utf-8?B?OVVJZmFkNmt1U204UFFic3ZkQTBjV1JEdGF1QTJBTWY0TDE5MFpWM2JLTWRO?=
 =?utf-8?B?MUZtbGovNHlKbFkxbys1Uk9BaFhLdGZ3SDFtYWtWRFQwNS9RbTFtTXozd2V4?=
 =?utf-8?B?eUlmZGVGQnk0NG01U1hTWlBsY2NQbUloRElYNVdVV1NpYldmOHRvL1FqOTJB?=
 =?utf-8?B?R0ovazBLR3B3YzNjQXRPZHpLd0N6ZFNLWThVTmpaamR6NE1tQjlhVThyOVU4?=
 =?utf-8?B?VWJoaVA5eThCWVRPU0pTOW5QWDN6Z3BjK3I3Y29iYU1Fd1VtS05JUXhhU2x3?=
 =?utf-8?B?M2Q0eFE4R1NRTXlRd1NoWkYzMUhMbEtEd1d3SUl6dkZSUkpEd1IzeGJ4T3Bk?=
 =?utf-8?B?N2xQREhtYU9CamxTVHZFL1FCRW9WSU9UVnNpUUZ6MmhtaXk1WXFWNi83UjhL?=
 =?utf-8?B?TmtKZ1hPWkxHbTNkYnVGZFd1RU8yNU5KQnZQT2g3WmFnb1JEdkllamw5N0xl?=
 =?utf-8?B?c0tJVTlxS2hHb08xVGlLN3VQcVlRejJMVTBrMTZ1Ti9JZlUyQ2VjK1pQbFRP?=
 =?utf-8?B?L0doN2lObGk1NmZGdUJRN0w1ZlAyUkRzQTJmV1VHdTRIWTc2WUJPVWowdEJ3?=
 =?utf-8?B?dmYrVzFiSlpsNVAxa2hNYVZ0ejBzb3hsOWlGRnh4ekl5R1lxNklMQU9aS2Nm?=
 =?utf-8?B?QU9aVFhvNy9JZzEyb0g1YVl3MFhyVzMxUnpGa3kvSEgvTlUrOFIwMmhDS1dL?=
 =?utf-8?B?WVJwa040TmFSSjZ3V0ZYSkppL3lWRFd0ZnN1VWwxNks0SG92c3VOWWRob3Rr?=
 =?utf-8?B?S0Y4NDd6YVp1M2MyR3FaL09aU1g5SithYnB5RG9NbzF2WjQySTJQV0FEc3Ju?=
 =?utf-8?B?SlNJWVh6aGpCMGtUQVdCTGJNQzJRZEQ3bzJNcHFUbCtsMDlhK1BndmsveGVa?=
 =?utf-8?B?RHJPdGgzdDE2eitjTGY0VzcwN3krSmFieEo3eXk1aWJMb2EySnBINU5LZWRP?=
 =?utf-8?B?YzROQ0hRU01JeWV0TWVPYlB4elJmc3A3bXY5d3BlZXh5MWlCL3JUeXh6OEdj?=
 =?utf-8?Q?72S7aSwcmQahxLJVre10ha+Ll?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aff5dd5-df72-4baa-bcb5-08dda99d20c1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 10:37:28.5044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HdOAEqplU+HTNOgGfSDfd4+9p/4DWkjS+XAxj/DiCU4ayFfiQ5KypKDbMyAurgNqveq4PCmaIl+sSt0II2NDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614
Received-SPF: permerror client-ip=2a01:111:f403:240a::623;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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

Alejandro,


On 5/2/2025 7:45 AM, Alejandro Jimenez wrote:
> Make amdvi_get_pte_entry() return an error value (-1) in cases where the
> memory read fails, versus the current return of 0 to indicate failure.
> The reason is that 0 is also a valid PTE value, and it is useful to know


If PTE is valid then at least PR bit will be set. So it will not be zero right?

-Vasant


> when a PTE points to memory that is zero i.e. the guest unmapped the
> page.
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>  hw/i386/amd_iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 5322a614f5d6..698967cc1a88 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -496,7 +496,7 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
>                          &pte, sizeof(pte), MEMTXATTRS_UNSPECIFIED)) {
>          trace_amdvi_get_pte_hwerror(pte_addr);
>          amdvi_log_pagetab_error(s, devid, pte_addr, 0);
> -        pte = 0;
> +        pte = (uint64_t)-1;
>          return pte;
>      }
>  
> @@ -1024,7 +1024,7 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
>              /* add offset and load pte */
>              pte_addr += ((addr >> (3 + 9 * level)) & 0x1FF) << 3;
>              pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
> -            if (!pte) {
> +            if (!pte || (pte == (uint64_t)-1)) {
>                  return;
>              }
>              oldlevel = level;


