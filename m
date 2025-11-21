Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C37CFA47A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 06:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMKz1-0002yD-A7; Fri, 21 Nov 2025 01:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMKyp-0002xW-SL
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 01:50:55 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMKyn-0003a4-Nf
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 01:50:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7xuxMnoPXQ7vZYNf66MPTSpeviFc8E0AHPID9iDBGAs8qcPCF6+wbYQm/k+MU/YTcMN4tBYEVbOyhziDIQRZY49aGCfKVv3WElW26Di+XGC09aN00hy4ImtKb95XNkv1y3tTzragfeOlTRghMiMfDKDF1utaeZ2UqMbxubbpXLK7J8L9Yif4LnFA7L3zpr/zt1J0bWf8EUYsyHUid8SkLiX6kn3rtbhGC1Wi8vasAXEwGwqudbqCQU3NnoVIjovmonBPaC8RIYwPl/6rN5E/tQeGRwMxPpHUn/bDQXbyV8OUquzpYQt2ke7xrdMUuN70ntGJJH7r7N880bhmqB28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwDnGPg93PoAt8oU5GkqSLvd6kogSBRww/6P/eVLY2M=;
 b=BXEMGgqwq2FO4o0mcPHngej5Cl4k+FIN1LxpNbe5afMFV7/64RVyadSKdGrWo06Jz0roxSVTdTUUsvNzhNyCELsQnn4Ky23RC8Er+UL9ity/Wnx2j8w2UE1juNVCRQMGuWcshhL+FLzuw4xmhO6dMkQClOKnDeuTN3ljNMGXbnNUaUoq7XhpMpzmJYKkPf6q0utBp6itS2NRU84xTY+nKRQeyzYgE78LuMZMVnsZGcW1SxcJPO/1FiM7QUCC71HZMR4F35H/Kgqp0MAE5mfvbbjC8d0YIiHbnhgQyYofp4v6r3yImErFOFlCpPHcMDSSpFZYlApNBhcpC9ahtUd/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwDnGPg93PoAt8oU5GkqSLvd6kogSBRww/6P/eVLY2M=;
 b=jxh10Ii1ZI6PlzG0WkO4N76eslzHYk93z84iWIb67b+rtqh/MhECFc+t3aYQF/rQnhfQ2MhO0GfmjSktpWTD39hDSr0nCbI0q8dwHxfiXlNz1LhF/pBi/1Ik6uuW7Z6XYoJGKlmmvk5lqFbH1GrhqrgODvynunIYXP8fGges0cc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.12; Fri, 21 Nov
 2025 06:50:43 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941%3]) with mapi id 15.20.9275.015; Fri, 21 Nov 2025
 06:50:43 +0000
Message-ID: <f95196fe-27c8-4eef-8b64-b1ede138425d@amd.com>
Date: Fri, 21 Nov 2025 14:50:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 1/3] virtio-gpu: Add support for
 VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com, dmitry.osipenko@collabora.com,
 alex.bennee@linaro.org
References: <20251121024705.1403042-1-honghuan@amd.com>
 <20251121024705.1403042-2-honghuan@amd.com>
 <b6f4cc26-7ebe-4b07-8e50-257b6f53d309@rsg.ci.i.u-tokyo.ac.jp>
 <db263884-6159-4d25-8c40-44dd78291714@amd.com>
 <ca2e398e-8158-4845-9798-6f444a73b103@rsg.ci.i.u-tokyo.ac.jp>
 <c33300b0-b4db-44b0-be07-4e4382a0c0fb@amd.com>
 <21b94d50-79c4-4942-84f7-f4c96f432dd8@rsg.ci.i.u-tokyo.ac.jp>
 <dd14c464-bd74-4d0d-9578-e28367319475@amd.com>
 <9b48903e-09eb-453a-aa8f-903fca99cb7d@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Honglei Huang <honghuan@amd.com>
In-Reply-To: <9b48903e-09eb-453a-aa8f-903fca99cb7d@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0174.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::13) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|MN2PR12MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e5eb3c-e9e7-4283-ce63-08de28ca4a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1RBU1BaMGd5aGFMVk4rNjI1eS9SbE1qeklpL3ZKYU15dHZEYUhFQklLelJw?=
 =?utf-8?B?Rm5leVcreU93K2d1VVVTemFmZFdRWXh4MU5PK3VoRUJWa2FWRUtJVEpoeXJK?=
 =?utf-8?B?Z0dsV05PTDlPNkpQV0U2djZIMlRGaURNVXpmUWhGc0RGMkpJOTg3bGNQUjFk?=
 =?utf-8?B?cG9FRUpZNDh2Y0JOR0UzeUNUS3Z2RTRUMWRZa3VudEw1NGJuYVFQK2NacmMr?=
 =?utf-8?B?Y2l6NVBYVmE5eDFaL3lvcXZaN3l5dyszVDdJWTB1VGhTc0pDVGxxUnBxekJ4?=
 =?utf-8?B?TS9qYmUwV2I4RUVLOWpCZHROQVVqRVNvZFBZZmJTQXpvZkVCU3lDRzI2RHdR?=
 =?utf-8?B?OC9QSW5NZHczNktIMWJ5UXQ3a3BNZzV4cEJTNE5BRWx0b2xXRWtGeVJwY3k5?=
 =?utf-8?B?QW9reHltZWFZa3UyMHYxVGNTSG5mN1FNT1NnVU03USs4Sy9DcTNNbmd5QXVP?=
 =?utf-8?B?Wk93WWE4QjBIVWRrbEp5RVlheUswaVpmK2NJZ0tnaTYyYmRtVUtRTE9tYXhT?=
 =?utf-8?B?cllzOWxkd2x1cFhPWHB2aTlLaGx2UENrb0haVzlhRkFjZzBRSnVzYzhKY25v?=
 =?utf-8?B?WFR6VkN4OHI3cjBFNUNBcGptL0ZmdFQ4L3FNU3dRcVQ4cTRIcTIzQ2ZaSHhC?=
 =?utf-8?B?NFE0WTRYTE1UVkdzaVB5Z3BFMDloMUgzdm9ZTktKVkxWSnluODlTWEJXcTFm?=
 =?utf-8?B?Tkh3bXF5V2loVkZUdnkxSk10c3BUcCt2a25ER1U2WjZHS2dmOE9UdG4zb05E?=
 =?utf-8?B?Z3c5ZHhUcFdVYW8yMWp6UEkvRmE0WWJtazNGZmZPKzdEYXptRnl0V1paeEhT?=
 =?utf-8?B?dHVlY00rZHlXMnNLWHJyci8zczY0MnFiMUZLMVBrVWFQcStYODNiWEUwTU8w?=
 =?utf-8?B?bDU1RllZRmJSZFIvbEtoK2w2dnh2QWZnMWUvMnlMR2k5b2JSSGoyc0c2cysy?=
 =?utf-8?B?UDMwbEVkT2hxelg1aitHcUp1cGJVYURrRkR3MSt5QzI2UXRuU25pVTFYTnFY?=
 =?utf-8?B?NVpmY2puRnk0TEIzbGJKYSthazJXNUFCWmx4S2FIcnV2dEd6Sk5tSnJVMkkz?=
 =?utf-8?B?N1JvTWFua090ckdIcUZIOEtwZ1RncWloK0p4bC9ZS3I3S1dzTDRnT1kwaVNL?=
 =?utf-8?B?UTZFSmNmTG12VFM1RnN1RVdUblRtN1NQUWU3cWhJL2gwU1Z0TXN2WFMzTHll?=
 =?utf-8?B?c3NKNlJvVS9vNTBXWEx1NW5ZQ2EvTnVVbjhtemQzWHE2d0NWODJ4MjdVM2xH?=
 =?utf-8?B?dmtIbU5GTUlwMEtmZEVCdkhyU08raVJJR1BrUkdZTkdLS3A0TXlyWk1lYitz?=
 =?utf-8?B?MVgvSHgrcklGVHdKeWZ0dkR2WmhyMG1QTytqendxbDRtbVJGdk04cE5VRU9m?=
 =?utf-8?B?ZDQrc3lCdS8wdWJGdzZkajNVb2lXQUtpRXlNWHUyS3ByTDQzYk9PeTRWRFhQ?=
 =?utf-8?B?bGY5cE80RkpoZUNFMStjWkxlWnRjNHVEUlpOaXN3ZVFPNXRYeEE0K1p0TXZY?=
 =?utf-8?B?N0JuQ3lMSVNJZUdYZlZ6VG1EVzZtVlMxYlYrbkxJT2xzTWErRy93SGVWUUZv?=
 =?utf-8?B?NDhYdFpnQVk0ZVQ3M3VNdjVNRVVRaTY4b1c4cFZMQjlnVnFEdzQvQ2FMSTh1?=
 =?utf-8?B?dVFZQTExeUZFaHA1Y0NOTkFOQ0VDS0ZBRHhucDFwTzd1MHZERVhjNHMwWTA2?=
 =?utf-8?B?aEdrN0JUVFgzcldjY29Rc0dteHdqQWF3S3M1ZHFhaEFVdmcvT29NZnNXa1V4?=
 =?utf-8?B?YUF2ZEg0UVhTRFVlNGZubGt0M2RVYmViMjYwUFBOcytPZ0pTbzczRGpLbHpj?=
 =?utf-8?B?eCtqazJWdnRLYy9jdkNrQXdDa0pONHVKcUVzOHRHYU5xV3JpekpzSFBkMHFG?=
 =?utf-8?B?ZlMwaUxSVzJpdC94YjdKNlo2QjlTeXdRMFZmc3ZINjhQbWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXdBTCtkRGpXN3pRYVJNeG93OXZJVkZxVWFrNXF2RytqRTFnaWlLREpDMllG?=
 =?utf-8?B?OHg5ODFpMGV5Z1JXalNBbFFQRWdvbGx0WlFvYWFOUHBZVCt1YkdaMnJHM2tY?=
 =?utf-8?B?YkFISVgrMEM0NEtYZHlGUjZmQkRJU2Q2UXBmeUdpZkJCSWY4VTJqTkw3ajBN?=
 =?utf-8?B?MXg2djJkdDNCeG1iQ2FIRmhCSzF0SHJoZERkTElOQ3VpM0NGRzZsLzhKSG1B?=
 =?utf-8?B?TWE2TlhVTTBnUGFtT0JVbmVUQk5kbE8yQlVDN2xYYkVnZXhsSnhaUFpYeVAz?=
 =?utf-8?B?bGtOSlkvUVpVclhUcEV1c3N6M2dBMm5rcDdOTHhlS0hsbmJyYmdUR1pacWN6?=
 =?utf-8?B?aTc3cnVjaGRIbHdTT1VnNlpvalVWeXZuMmUvNWVJYy9WZFRzU1VwWmRMWk1T?=
 =?utf-8?B?VzdoVjJRZGxKZmlGRVdoTHJsM0FjTTVwdm5DMGJZQVRGbWN3TGZ0aHIvc0Va?=
 =?utf-8?B?YktmYWxlNUwwdFhJaURURmloOVNEa2VOc09jUXdGT1NTZExGSlVrZmpqYTlr?=
 =?utf-8?B?SGdyRW9vQXFnc2pDb2Fud3ZmWVJnTlJsQ3ZvSE5INDlUSTh0TmNZaXNpUnRq?=
 =?utf-8?B?NXNJME8zL2dUeXF0cHRReFRTc0hmSGlUZmovajZ1emEydGY2YUVTelZHOFhV?=
 =?utf-8?B?TVlPOS96ZHVpL2NHWXkyOUlZSXAyQXR0d0plaFRBNWxCa3MxVitBR0V1MFZz?=
 =?utf-8?B?dVhkN3BwZ2hnbXZLMlJaSFpnaVRDSHJSMi9MS0ZtYm4vb1gyYk5PRlgzWXVr?=
 =?utf-8?B?Um9YdCtlT1dNeElmL0ZvelhBU3g4WjZ0VFprVmR5YkdDeWdxSHVMbmRHSUdv?=
 =?utf-8?B?YnJkYTRleXpTV1prMnlJekZNb3djbmoza0VYSU8yVGR4MGhKd3VETG5iUlJp?=
 =?utf-8?B?NjV1ZzBXU1F4RFgwUlVYMmFLT1NLK0dyMlhuSlFhWVFQT2NvalpCczlpOW85?=
 =?utf-8?B?SmQyRkpFSlI4b3Q5bmVtc3g5QWFZSjJVenIyeG85eU9udDRxZHVPUDYzdXda?=
 =?utf-8?B?d0k2VGFxd01VZ0VlcmN5T1MrNmd3aUdFN0ljd0R1c05sV3hPa3ZSQkc3am1X?=
 =?utf-8?B?bXhqRUZBTFYrdTg2WXVDU2pxL1JzQWQvT0FpZGNWNnRRV2lsZWgvc0dyd3JC?=
 =?utf-8?B?T0lUVSt1ZTFwVEZ1ZGtCQnpMS0pXcjRWSWw2VnJ0UWtkVHg3aFpRUmovblBW?=
 =?utf-8?B?OS9TWGd4V0xkR3hFQzlZaHB1MVRHbnplemU1dkNjc3g3a1I3Qk5FbTdtZ2lS?=
 =?utf-8?B?TzhvRjlKUkkxckZCaFl5NnZEa2p2eStyRFczY3RvaUlXZkFhQm1kNkVHS0dn?=
 =?utf-8?B?U0dNdWFLS3B6b1QvSVZwQjN0QS9jSE12OTNQS1Fzb24vdXFMQzZ1NXp5cFVz?=
 =?utf-8?B?SGJHK0dBTjJSYkF3eVBnaUZHRm5DT0FGTDZGOWNTOEhvRXVxZzRuSkpBSVUv?=
 =?utf-8?B?d2s5MHZ1V3VPb202YWJEVVFxaVZkeUlOblJ4amY0Q2xYZzZNUkR3VVQ4K2kv?=
 =?utf-8?B?bnY3WUVwaThnTnRzSG5zVFdUcTRMaFgxYnBwbVJBNXNjcWhQRXNLalA3WW9B?=
 =?utf-8?B?NG9wT1VacVpxMCtzSlpwUUUxZlNIVVdCSmVyVSt1YituVXByc2NGdmFoQUhJ?=
 =?utf-8?B?aUtaRFp5Qnl1K1VkM0toRVlTNlJ0bjl1L1QxTlpuV0FOcGlHdXBTZ2twMXNC?=
 =?utf-8?B?eW1oQUVES3VPMnVvMGVvNUQ4aWloZTFQVVY1L0VlaWd6SmRNSFlrS1p3NStM?=
 =?utf-8?B?cWd6OFowc3hmZTZhQ0hVaWlCRnVqVGFWZHhsNDUrc0Y2WkIxcXc1Ry9jdXlh?=
 =?utf-8?B?TmJhOHFrUk42UGlMVFpyOWovSDMvaFFMU2NQMlhwNjNoK2lna1pwd1pxdDIv?=
 =?utf-8?B?bmliLzRkWVJCMlFXQ2sxM1BjMTJiNk9zSTJtMTZUUHU5YkN6ek51UHY0d0Ux?=
 =?utf-8?B?NjU0MUxRSjFETEMrV0U1WTBaTGlBc0ZFVmRiT2lWcWtJNUJDTGJ1ZGNBdnhS?=
 =?utf-8?B?WDhxbTF5ZmRlUkd6ZDh3MXBDcmlEd1ZZd0I4ckVpY0xDOEVVSUVDQjdhbndm?=
 =?utf-8?B?S1ZzM29samFwQjVYT0NYUFFpSTA1Y2YzREFTenlpaDZrZ0ZodGR0Nlh4bUxX?=
 =?utf-8?Q?hrQ+/3LW94nqtK3BvkX7EygGl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e5eb3c-e9e7-4283-ce63-08de28ca4a84
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 06:50:43.4715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffnohJ8g9vj9lKxB6aSgWwWtg37yioi8Wg09gITAthul6zvl6Zvs21qGQigHMd52MoXDIQnAe8NbecjMVuollw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=Honglei1.Huang@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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



On 2025/11/21 14:12, Akihiko Odaki wrote:
> 
> 
> On 2025/11/21 14:43, Honglei Huang wrote:
>>
>>
>> On 2025/11/21 13:28, Akihiko Odaki wrote:
>>> On 2025/11/21 14:21, Honglei Huang wrote:
>>>>
>>>>
>>>> On 2025/11/21 11:39, Akihiko Odaki wrote:
>>>>> On 2025/11/21 12:14, Honglei Huang wrote:
>>>>>>
>>>>>>
>>>>>> On 2025/11/21 10:56, Akihiko Odaki wrote:
>>>>>>> On 2025/11/21 11:47, Honglei Huang wrote:
>>>>>>>> Add support for the USE_USERPTR blob flag in virtio-gpu to enable
>>>>>>>> user pointer mapping for blob resources. This allows guest 
>>>>>>>> applications
>>>>>>>> to use user-allocated memory for GPU resources more efficiently.
>>>>>>>>
>>>>>>>> Changes include:
>>>>>>>> - Add VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag definition
>>>>>>>> - Enhance blob resource creation to handle userptr flag properly
>>>>>>>> - Remove arbitrary nr_entries limit (16384) in mapping creation
>>>>>>>> - Add conditional handling for userptr vs regular blob mapping
>>>>>>>
>>>>>>> I don't see the added conditional handling.
>>>>>>
>>>>>> Sorry, the additional handing is replaced by the fixing of value 
>>>>>> check.
>>>>>> I will correct this commit message in the next version.
>>>>>
>>>>> Not just the commit message, but it also questions the utility of 
>>>>> VIRTIO_GPU_BLOB_FLAG_USE_USERPTR and VIRTIO_GPU_F_RESOURCE_USERPTR. 
>>>>> Neither of them adds a new functionality. They should be dropped if 
>>>>> they are also replaced with the fix.
>>>>>
>>>>
>>>> Yes totally agreed, it is my mistaken, I shouldn't mix the code for 
>>>> fixing and the code for adding new features in one submission.
>>>>
>>>> Actually this patch set are for another components upstream test, 
>>>> for the sake of convenience, I have added both the fix and feature 
>>>> here,
>>>> that is a bad idea.
>>>>
>>>> Will split the fix part into previous thread.
>>>>
>>>> And for the check value fix thread, will send v4 as the final version.
>>>
>>> Splitting fixes and features is a good idea, but that's not what I 
>>> meant.
>>>
>>> What I pointed out is that, it seems that one of the "features" you 
>>> are adding, namely VIRTIO_GPU_F_RESOURCE_USERPTR does nothing at at 
>>> all. So I'm wondering if you forgot to add a real implementation or 
>>> the feature is just no longer necessary.
>>
>> Understood, actually the resource of flag 
>> VIRTIO_GPU_F_RESOURCE_USERPTR just reuses the feature of 
>> VIRTIO_GPU_BLOB_MEM_GUEST: using the virtio_gpu_create_mapping_iov 
>> function to map the iov from guest.
>>
>> In qemu, the handing of VIRTIO_GPU_F_RESOURCE_USERPTR and 
>> VIRTIO_GPU_BLOB_MEM_GUEST basically same.
>>
>> The VIRTIO_GPU_F_RESOURCE_USERPTR is from guest userspace, but the
>> VIRTIO_GPU_BLOB_MEM_GUEST comes from guest kernel.
>> So in VIRTIO kernel and virglrenderer they are different, see VIRTIO 
>> kerenl: [1], and virglrenderer: [2].
>>
>> May I need to change the organizational form of this patch set?
>>
>> [1]: https://lore.kernel.org/lkml/20251112074548.3718563-1- 
>> honglei1.huang@amd.com/
>> [2]: https://gitlab.freedesktop.org/virgl/virglrenderer/-/ 
>> merge_requests/1568/ 
>> diffs#14086999aaf57fc68a3d7d639ab280c3a2672430:~:text=if%20(args%2D%3Eblob_flags%20%26%20VIRGL_RENDERER_BLOB_FLAG_USE_USERPTR)%20%7B
> Why does virglrenderer need to distinguish userspace and kernel?

It seems like the blob resource in virglrenderer doesn't support the 
guest resource/iov resource, virglrenderer doesn't let guest kernel 
resource go into get_blob callback.

But some feature I am working on really want to let guest userptr 
resource get in get_blob callback.

So I use this flag to extend the feature of virglrenderer blob callback.

The different is:
guest kernel resource -> won't go to blob callback.
guest userptr resource -> go to blob callback.






