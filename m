Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEEEE8307A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 20:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnMma-0007n7-7t; Tue, 03 Feb 2026 15:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1vnMmT-0007me-E9; Tue, 03 Feb 2026 15:13:50 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1vnMmN-00034J-0K; Tue, 03 Feb 2026 15:13:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yzay0trfuI6H2/JnuyhZQKrbrc66t0wQ4PU6OggkLjhPHSn5cmLEgPECTf4Jz8b5JVp0RTTsA2VYZ+J5IZaFVzfqY2u5Fe/alYJ+oTaxPslJSkLnz/55wdwENXR7OHx5ozZjpYM66ZnfLV0uFz/rnaRLf9ftiiJ5ZfhJiimRlGRoprcAFo9B2vpxRfGLEzkYAfYB3apQnJmeJ+nXm7hLZqvCR/0pvrZiH913sHu025iUs34LpDQXVLV+YUXWyB48LbAXhJu+b/AJFM/kSrf0ROOjkQuFCHqNHQIu+JeCsWLPrp7jYbQ9nghPHUw4ST0gT7ZDDGkNgAePAHCNoc5j6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLmUVTT1hgGtnluUN0E98RTMmkNYKtYDApqfhOWowPg=;
 b=mfbFTBY9sMeSOLRPczw873qrNiAYNQh62MhlU+SON4t7xV/VAliFijLlFhWf56WFoVT5WfUivql0N5yv3r7KKV9lHuqVmJDrRBpK52DJCTeImgCL2S3bZRZWH5zsLDnjzU2vfPU9lY1CxYbatDUN6q4pqb/I5bzDQPx0NlwLDeN7jt/eF+sdg40l5nEWDYImMSH5sIEbPZICZA3rFzcmtKFtOOy4N4Ux4/ik2BJe4wKn1YniI1+pyytlfHDMnOuCU8Djk56lx4FXDpWx5nYuOrRT9MQ7F+Ar2AwrxZWyKGn/EJqL+S60qyzdo7hs61LYZp1RWUyB3E3hXQ+/26ov2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLmUVTT1hgGtnluUN0E98RTMmkNYKtYDApqfhOWowPg=;
 b=SRDqh0Ezms/71Co+Dm81fKPhH+fjPv71qDJw6Cuo1F2KUFUT6Kalk1qIRahNfvR3s1/iaIRBQm438PzxXbaTmeFsJeXptx7D6Q49/96ZY+0lwRPxucGCuoQsd/kcPYYaqIwle6q/N8fBWsQKt81Qjx/UAWachpb3dgZ67s6BbOJ2Nh3DLMUtunUHCphN7Tw2PCkHFQjcQwGGGH2JlNuecyUEmsNzQopqYqOvR9oAiPjHkbsBwwVPRzf+6C4tIzBui+IULnfDxt6eRGUJLZLfo/QeVYzMq2b7ROudXgFBc72qNRy60ZgPOFJxkYevjGRmcbc/ati+lLLVS9haBpDCwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21)
 by CH8PR12MB9768.namprd12.prod.outlook.com (2603:10b6:610:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 20:13:33 +0000
Received: from DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087]) by DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 20:13:33 +0000
Message-ID: <9c138864-313f-48a5-a91e-d3408b97dece@nvidia.com>
Date: Tue, 3 Feb 2026 12:12:49 -0800
User-Agent: Mozilla Thunderbird
From: Ed Tanous <etanous@nvidia.com>
Subject: Re: [Stable-10.2.1 04/56] tests/functional: Fix URL of gb200nvl-bmc
 image
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Patrick Williams <patrick@stwcx.xyz>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <qemu-stable-10.2.1-20260202173336@cover.tls.msk.ru>
 <20260202220805.945271-4-mjt@tls.msk.ru>
Content-Language: en-US
In-Reply-To: <20260202220805.945271-4-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:40::43) To DM6PR12MB4283.namprd12.prod.outlook.com
 (2603:10b6:5:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_|CH8PR12MB9768:EE_
X-MS-Office365-Filtering-Correlation-Id: 192d8559-489a-47f0-8a42-08de6360b482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTB4K2N1cGZKWXpxeTdKbFhwVGxiMkhaM1FrSlNZWjdyVThjc0p1czl3SEs1?=
 =?utf-8?B?WVhSY1lERHR2OE4wdWlVbHQza3ZKY2NVU3UwQStPOTZ3OVFvclNZN01wR0JO?=
 =?utf-8?B?ZHJLMEExaTUvYVJHMnVjRWVsNGRuYUg0WThOZ2VQUEZqUmZJcitEUnV6Y0dv?=
 =?utf-8?B?VVZzR1o4QVhDMnYyZ3YzeFh3aUxGU3hKRUJKRkg4d1FWdXQxQzhROUhLaWVF?=
 =?utf-8?B?d0QzT1p1cnR2aTdRZ0xVNGVad2VSN0xwZWRSR3hTZjZGQnkyNEkwdTlBeW9P?=
 =?utf-8?B?UWlTeG14OG0yQWl3N2FSeTBnSEFpaFBaTW9VTlZsdWZ4cTBZY0x6ckc5ZW9z?=
 =?utf-8?B?OVM1d3gzbjBWdEpzTWIvTC96L2t2anV4dHp6bzlqYVhOTDgyaFFKZHVIUjQy?=
 =?utf-8?B?OXZPSjBsbXltQlFNVEhiOHBHV0xaTS9xMk9jTzh4RHVtQ095Q01VWFpCSm44?=
 =?utf-8?B?bDE5eGFuaTZyTVgyVlR5LzNLdHFwL3lzOFJUeHduV05pMVBSRzNxTm5jWjUv?=
 =?utf-8?B?aDBEbHJ6dkF5cHk5YWZ2bEF2NnVDNUE3Z1oyaDRwaEsrUlRLZWdjazFhNlc4?=
 =?utf-8?B?V09KazN0NW9DMTF2TWFQNWxWQ0RpdmppV00wdmsxTnMvbzcxdXRqRjhrSHFG?=
 =?utf-8?B?K2VDYmdmN2I5bTgzVmdnem9wbXQ1NHZWd3YvdjJiQzVKendVMTFBdVE2TkdP?=
 =?utf-8?B?SmlQK2dSZzVaV2EyN053bGZDRDZUWXVYTVBuSEllSm50THdTTGhRMXNwMHNz?=
 =?utf-8?B?K1A2Nkxwazg5bG1YSUdDWmE5QisvKy9FT25uOU1EV2FBNVMreS9JUkcvejF2?=
 =?utf-8?B?ZVU2VFNTb2pnakRsODVwTDRNNzFrVGdYejFDRzJxZjBLcjBrdkNKVVFsSkhS?=
 =?utf-8?B?aFd4eEhqbVUvRzZHT1pzY2lkQXl0N0FZUk5rNFB3d2pCa3lzN29KckZQbmVZ?=
 =?utf-8?B?d0hrVVhJeFZaTXJqUGpFMS95b21sNVhJd2tNOE4xdTVzbjFoODB5cGxXZWdS?=
 =?utf-8?B?QjJReEVIelMxYk9KYkRoZk90RkVCSWhoc3Q5aGZ4aVpyRThWM0twY1l2dTZ6?=
 =?utf-8?B?ckY0aEZxNkRmL0VYbktYWE5DKzBkQ2l3TjQ5MGxkNTFtWG5oemFIN0UvalFY?=
 =?utf-8?B?VW5aM2VacGVXQ1Z1ekhmcjlQNUVLVzJYdU5NZlU1czVHUFE2TVBiV3BoWlU4?=
 =?utf-8?B?dFhVdEdVNUovWDBSNEhjZUYyZXErRFJlSzNISXpYOGhrRkVwQkl1RVZ6Q2ho?=
 =?utf-8?B?d3VLUFV0Z096YkZtUFdYazQ3TURmY0tIMU1VVWVGbHJ6cnJHZXdsMlgvcDJa?=
 =?utf-8?B?UWpFV1JKMXN1dzhYNmk1MVRZZjJUUG9lalZqWHRYbXlZMEdJVXc0REVmWUs3?=
 =?utf-8?B?Z3MvR1pmQXlmUFg0VWlpU1IzVVBrSzQyRVJPRUNRb1hWTy9iRkszek9YelhJ?=
 =?utf-8?B?Q2RHV1FEWUx4elRpTmlHZTR2NEQwYkRSM1NwckJPR3ZJZlRMM2NaaWl0QUZC?=
 =?utf-8?B?Z1ZDYlBCQkIrTVlNaG00eDJsclhOMEJvWENvSVdxdElwWStWaXlkWTZJdkhP?=
 =?utf-8?B?QldvY1ZRYXFKTnZka2wvRG94WjRSZkdHcTNURjdhekRhN1dTRXdKRmsvS1BG?=
 =?utf-8?B?eVNVUmtwZTVCUExNL1RPbUhEV1M4S00yM2lLeEpNMzBLWXh4VUh2aExIamdk?=
 =?utf-8?B?TXFkZW90SkI0KzViWk96MEE5Z0wyVm13ZG1NUWh1M3FqN0pyTG9kbXErRW9m?=
 =?utf-8?B?ZVlhejFPVFNlVnFKTmQ0ZVJsMnF4OFRjS1NMME1mbDdkM25odEpNRnFMQVBT?=
 =?utf-8?B?S0U2MHAvM2tsK3NpQ0VsUHpkbGpKQkY3aEl4dDFQaUhPa2doUVRHTHdDYzl6?=
 =?utf-8?B?L2ZvRGJqU1VycnFMeHdBb1BId1BrcXFRWEZvUTlKa0Zua29pa1lOa0pmaGUy?=
 =?utf-8?B?SDYxVUN5MmJqM3o2V1F6ZVBiQUNQaHRuSjFJNndMYm1ZWmdzUkJvTVM3cFRH?=
 =?utf-8?B?UDI4blNKVlpPSTZraUQyZ25wdUNKV2lOREJ1OUJyOElsTGRYNTVXOW0zQ1BE?=
 =?utf-8?B?eVBoWmVKK2JHa1RlQlVkRlg4VThlREowTGRFdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2xJN3g1REltZzN5VkxOVmFsTk1OQ2VPZ2ZML3ZObFlYTDJKaWpiWFp1NFpP?=
 =?utf-8?B?Sk1ZWjRQZ3VEYlJsd3FWRG94TDZaRnlGMmtwbzJJVktKSlRoak1vNEVpTFIy?=
 =?utf-8?B?Mm1NSThwa0ladkV5ZFdCYUl2YXhPeTU1UVMzZUZkeE9LT1lvQVh6bURROHMv?=
 =?utf-8?B?Y0E4U0NMb1ZncnpsNFRxUytzSzdtNFhtRWJ3dVgwcU1iNHV0bUo1aytWelBo?=
 =?utf-8?B?b1BraFpVbzI0Z2hublVwc3E5ektMKzFWeW9TMmtvd01lV0JiL25qYWsvN0o0?=
 =?utf-8?B?YjdiSUdaN3hETHlqSmovQjNMLytzK1dtRENhVFpIdzZQZldTNHFMSTlNZ3Zu?=
 =?utf-8?B?QlZWK015TUlJYzhMNVhCa1lzcExzTFNhb2J0MWZZSWhHMDhmTFVVL1pEOVR0?=
 =?utf-8?B?UzBGaStiWVhnVmV6bnFXTDEwbUVDM28za3A0TGV4QnJvUmhSbG00QlRIL0I4?=
 =?utf-8?B?Sm9HY3VZUUY3VHhDc2V3eU9nR1BHZytSNXNLd2N6eHJWMFYySUdNbWFzRGRK?=
 =?utf-8?B?dE1lSjRHcklNOUZ0c0t3Y0ZtNExONklWMmhWQWx1ajdEcTZkS0NpQythczht?=
 =?utf-8?B?cWlUdzJWTTYxTmgwbTFxNmNOWktxNVgrOWNDVVF2NDVxeENzUzVpR2xVa0pV?=
 =?utf-8?B?UmpIUU9qOUFJQ2Z6dkpQSHlmdFpsaWxuc1N4SGVuYkJKVFhjL1RvZTZBU2tq?=
 =?utf-8?B?YTR0RWJEdDhhalZ1aUQvb0RSNWtDSkJLd0MyMDhHSjRMcUZ5cFhMaXYrb1J3?=
 =?utf-8?B?Zk95b2VhNDNaNnNCVWJ5S3p0U21zM0lSaWFBampWNHh1RmYzeG1zc1NrdlZz?=
 =?utf-8?B?dmx1eWR6NzBrby94NkFrYThMMVlSOSsyRGlmUW94ZUxVRnNZaUxXc2ZDeUVt?=
 =?utf-8?B?YmpZMmc4SUNxMXZyMlQxVUhFZ3JreHlremdWSzJUMmJIQ3k0TVRROVl0N01w?=
 =?utf-8?B?bVVuUitvSURYbWZ0SWk2UTlaK0d3Uy9WaXBsRWFvQmpYSS9FZUVVT1B1L3pD?=
 =?utf-8?B?aVI3Nk9nbnNWbUQwd2VNNVVuOFphQVNmNUF6b1k3QWhSdlQ3VUFwUUxmQ2xT?=
 =?utf-8?B?Q25KUUx3bEtDR05EWThSUTJhUitWREkxbEFnOWJFbWJwUUY5QWtLNURaRGNw?=
 =?utf-8?B?eG10MHNUOWFmU2gwRnVsQVJiWmJQSG11SklWQUEvYzNEeVdHY2tXS21IMmdz?=
 =?utf-8?B?VkdKNFBLQWQvRGdYdVJxZUF5NlJydTFQZnZWYmdEemdlcWRnRFlYUEhVME5x?=
 =?utf-8?B?ZmhtRnFWbHJIQnBoeUxZMElndUEvRVhGbC8vbVE5bmNZODdQM29wRlNIWkFx?=
 =?utf-8?B?eC8yTytLaXE2RmxHbG14eUpYMEhDakMzb3pBOTduVnZpcFlmajFkNWxwOVkz?=
 =?utf-8?B?S3k3dllWbGRZQmxlUlluUlpHV2FjNDZ1cVZVUGdOOXlsMjhpOXlFQS9PdENC?=
 =?utf-8?B?L1BSUmlOcUpWVkdFR2w2dnFsNUsvb2dHNVN0dTlHTG4vVG5ETTlQVkhodVNN?=
 =?utf-8?B?LzVVbGRIUTl5aCtXcDlOK2JVSFRLcDd6NmdBWmh6MkNPZ2JiYTBzeUhjU1BL?=
 =?utf-8?B?ME9BUHdEbERaN1dwcGVxb2JENW1HUDFaNjh6TUdzN0pjOU82KzJuYVRqLy9y?=
 =?utf-8?B?Y3gzd1paSEdVOGUxTDFSM1h5WldyWVQrSUFEVHN5VkpkN1ZpbGhLeUZ3MEdN?=
 =?utf-8?B?WktFQWc2MXhQMVdKWGFxQ29WUTU2WGZ4MEQ4YXdlS1R2WUlwWWNmV3dzL1NO?=
 =?utf-8?B?dVFpUG5tcm9INlBxQ0NCcWlLMWVHK2hxSS9rRlRaZENLelN0dzBvaWRZM0I3?=
 =?utf-8?B?N29PU2dxM1ZrN0RIdm5tZHpTNlErd3hnUHA0Um1YRm5EV3Erc0N6WHNnYUNq?=
 =?utf-8?B?V1ZrbzVYOXhJbVU1OHJZRzdNQk1QaC9Gb2R1cGNKSEtvZm03dmdnaXVFMmRR?=
 =?utf-8?B?S09MK1V1elNBYmxPdDRkQmRsSWk2NG1KOHI1dE11T1UvNGgxNHpxVWhSQ0Vq?=
 =?utf-8?B?RUpPNkwya09uTzZaekVGNHlWTURzSnArbXFVLzdPV2E1QkpDb3BPS2Ywb2NK?=
 =?utf-8?B?bUNZRHhSMUl1djZPd243a05leFZiUnNpVVVXOUNEZkFZbHpoRDJuSFhYNmxY?=
 =?utf-8?B?NHlDVC9BOUJuMWo3bmRhQy9wZjgrdFJKWXg2S2hpMXljemF3dU5yNDNUSnE3?=
 =?utf-8?B?a0NYelhUajVvRHl5ek1TU0Rnc3gvTEI4TXhYbjV4cTZKYklvK1VhTkpPbytk?=
 =?utf-8?B?QlhJb2pVOTVyeUlaNkRpL1Voa2lyOEMvd2R0ZWZ4ZTJIV2hKZURBYXhraGFa?=
 =?utf-8?B?SFNCWTBBQkxVblJTaDlIb0hmeFdwSXlUYW1FSUYyZGJWQ3BPeU00QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192d8559-489a-47f0-8a42-08de6360b482
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 20:13:33.1932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWlOECUZ6CTixo5hxsBWdKRQH+MJCRcVx6FGT6CaU1y2hGwHOoeQuxuV1A7yxnC1UBcgaHfE9/0VHipn54UQxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9768
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=etanous@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 2/2/26 2:07 PM, Michael Tokarev wrote:
>
> From: Cédric Le Goater <clg@redhat.com>
>
> Commit [1] moved the FW image of the gb200nvl-bmc machine and broke
> the associated functional test. Fix that.

Apologies.  I should've been the one to fix this.  Thank you.

>
> [1] https://github.com/legoater/qemu-aspeed-boot/commit/52451b2472eeb40aa97e131aeea327e9d4a8a78a
>
> Cc: Ed Tanous <etanous@nvidia.com>
> Cc: Patrick Williams <patrick@stwcx.xyz>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Link: https://lore.kernel.org/qemu-devel/20251222073351.166720-1-clg@redhat.com
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> (cherry picked from commit 75bcfb98a13d14beb2ea95fb3c51da01c7102325)
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>
> diff --git a/tests/functional/arm/test_aspeed_gb200nvl_bmc.py b/tests/functional/arm/test_aspeed_gb200nvl_bmc.py
> index 8e8e3f05c1..e5f2dce0f5 100755
> --- a/tests/functional/arm/test_aspeed_gb200nvl_bmc.py
> +++ b/tests/functional/arm/test_aspeed_gb200nvl_bmc.py
> @@ -11,7 +11,7 @@
>   class GB200Machine(AspeedTest):
>
>       ASSET_GB200_FLASH = Asset(
> -        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz',
> +        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-bmc/openbmc-20250702182348/obmc-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz',
>           'b84819317cb3dc762895ad507705978ef000bfc77c50c33a63bdd37921db0dbc')
>
>       def test_arm_aspeed_gb200_openbmc(self):
> --
> 2.47.3
>

Reviewed-by: Ed Tanous <etanous@nvidia.com>

