Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A6FC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 21:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugV2v-0002gR-8q; Mon, 28 Jul 2025 17:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugV23-0002VB-Es; Mon, 28 Jul 2025 17:05:21 -0400
Received: from mail-bn8nam12on20604.outbound.protection.outlook.com
 ([2a01:111:f403:2418::604]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugV20-0001WR-SV; Mon, 28 Jul 2025 17:05:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYsZ6Gw2PHJz/nOV0HZvrJuYm6ZXTeSXvVq2X+sRUwPhQFpo0G7Umtn20b/FsXwsGDJh4I+5zXleNiore5UTm/zixlRJVWukO1qMUWmE/p5uhgRBMex8xjiVBDfYYr3RSxnBtenb+TqSPJG0QkFVzvAo+uAYn2FPWSaUduwcjZWu7h7RDMLxTo0znn6XHq+/jlQ/QoGh2LvbmQKuzT7QjVXtV0KDScsZgZ8l9DJ1GZei98Izya5X2gi55k9TM6tdq91Jl27B+mwHiHWCY7MXz4w1VufCeJh4LsSgeBGYkKQS0Tlo8/X9DJTCw6dnBJeJnrhwkORN73cc9lWzMBgJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pGAWxXC3H3X6uXtG5SburuCRzdhxmkMW2l/Azrp1UA=;
 b=LfnoyO07crmmumcLicO67qaKJ39D3xGNuW1UD4zh80NTg0tcWjUx3cnvgZGAAf3nH2563fidjcOen0DEInKvS+pn8YKJlmzujcPXY4mGyAhQOjqXnZMHheLbfXc86F0+U+t802Hcyg0OIP5Y/ZRQv+jaN8F6b1dxcSy/FQnDfa0IWj6Ay2wn3k3zCIsPfk74L8s/AbrZ+w0uo3dUCaH6S5tXq+vyYHWTNzOPPnnEsBTWYH6tJhXFw06fu3l6W4lz430d5r0IeVNaQwi4UxNB67xF56jsnDfMYW85XzijdOkAZciwCdnP9zapePnBSbOdVIdMhd9o0hTkb8tdRG6EQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pGAWxXC3H3X6uXtG5SburuCRzdhxmkMW2l/Azrp1UA=;
 b=kA8XSsw4KQh5m6gLYZpBIXmPqeu2j622sz2bbb1lT9GYTxqdMVxhNg6J208vZnlwssoyQODFw+NkFPHyTWyUo5qePN0NNsvCrRnsGnCV6Ntv/dBzd1ZGSs7KG1uUPonbG/u59vFx0K3OTlIm1zizRlKePSHTXcoqi+7N+Lgh6Wg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by IA1PR12MB8262.namprd12.prod.outlook.com (2603:10b6:208:3f6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 21:05:07 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8964.019; Mon, 28 Jul 2025
 21:05:07 +0000
Date: Mon, 28 Jul 2025 23:05:01 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 09/48] hw/arm/xlnx-versal: xram: refactor creation
Message-ID: <aIfl/QgF0xYunBp2@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-10-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-10-luc.michel@amd.com>
X-ClientProxiedBy: LO4P123CA0224.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::13) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|IA1PR12MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: 859810ed-beac-44a9-e58c-08ddce1a6e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHlGa1NvMWtSTDQ2Y3BDcDhTOTJZVUYwM0o1SWs5OUtUMmZhQ2UydDBPbHUv?=
 =?utf-8?B?ZVc5aElVZ25FRmp6UWY3cndVNHRHNmx5THBTZ0p0OW1kYnJMQmNkK2xLU3l3?=
 =?utf-8?B?SDh1SjVnYmxqSWIyeTRLNnBwZE9uZGt6U3NMUHRibEFDdWRlWXdhOGViR1M2?=
 =?utf-8?B?dlRtNWpyS3VKSTQ2a1JqRHdMaER2a3NnU2U1U2dxNVdTMCtreTZnNmFUY0Ra?=
 =?utf-8?B?amgrNUlzVjgwcmZLWUdwRGJpdEZSZmV1Y3FlNDFOZmhnOHBNV3FxZTdxSkdE?=
 =?utf-8?B?NGhuaStGZG5uN0J1SFpqbHZPYWhMUEM0YzdsVGJERnZWUXBjczdCM0QwdnlI?=
 =?utf-8?B?Q1lzSzBuakRPZkVKS1lWTEdTb2RuZ1VjdGx6RytBNzJYZWx4S2FvRFdHWWxL?=
 =?utf-8?B?MTFhVVM3eXJmQkxXK3hraHBxZWtEZGh5L1ZtWG1jd3NKRjhMOWF6c0VZYkJj?=
 =?utf-8?B?dnZobmk2dXB1ZGdwcGU3c0ZQYlM1L0JjOFN2SkNDMXJjOEJzYkx6V1F0b3VW?=
 =?utf-8?B?MGhBQ0diWWc2UWFtdUQ5SUh0WUk5aGRNajFFRGJrL0ljR2JESFBaWVQ5U3c0?=
 =?utf-8?B?YnlVL1dvUVljVGNQTmlhc1c3SjNraDVkOHRMOUczNUp3bEFEV0VjZGNpTDBw?=
 =?utf-8?B?Qlh0U3ZTaGk2WTAwMCt2ay9xN29BSDJQbmVaL25BZzdrdkJJbkRTZXQ0NUtK?=
 =?utf-8?B?N21FTWI3Sm9TNHF3NCttUTRLaG10V1lVL21rM0RqaHRoVnhxVmlRL2ZQWTVW?=
 =?utf-8?B?SDZyNXZTb0IyQkR0a3ZyNXRPMmRuZjdsTjJrMTdRbzh1NHN6dU40bkxDSUZI?=
 =?utf-8?B?NElTajUzK3ExeGkweTU5MWVodGJJNU0rVzdEeHd4WVBkRmVyTmlzNWZNV0J4?=
 =?utf-8?B?QWxKTTRFYzFGcW1GVFdUT0kxdmFWaDlCcG40blpJV0VzRTZLYkt1STNUU1RZ?=
 =?utf-8?B?ODJKcThYQ3JvdW5PanFXYU1MRGxJU2VuVGZzL0VVOGV2MUx6TmNaa3VEV3hl?=
 =?utf-8?B?ME56UDJ1R0JQMHUzSW10WENCMXo4b3l0dEpEK3lWQ3lRV3hHaDU5YnI5Q2E3?=
 =?utf-8?B?MGVIUzl5SlB4bmZoVmwxZ0Z0eGcza0R1SGY5ekxCY0crTWF2SHg1Y1dndE1M?=
 =?utf-8?B?cnlxVjdmNXRIZm02dDN5SUtzZlJYL2MxWDljbjVHZXA3b1ZDc1BBbHVVdDlr?=
 =?utf-8?B?NWNzTmdlL1o0Nmt2SURIb3RIdmFEOStrbC8yYjRzdHllZFg0UG83OWwwa2hI?=
 =?utf-8?B?VzJheFVoV1NEZWpmVitaSTlxZWpmMHVuZEJ6OGFmV3JiZDVZaEMwR0JOUjVS?=
 =?utf-8?B?bnBMOGdERzhmUXRqb1NFbS9BRDBuNHFScjJIczVZN1YrUmlvMUFLanpTdm54?=
 =?utf-8?B?YS9lZ0MrZ1dPZnVXUFpjNXc4MDZ0cTErOTVaVWQrbWhXK3MrNWNBcklGczh2?=
 =?utf-8?B?eWsyMVJ2Z0FvWWN2eTBTa1JjMkFHMENKNGZtOTlSY3U4TzJ1N0hHZ253WWRK?=
 =?utf-8?B?TDZLL0lDdUJOemd1Q0xiWTZLSWpDWm0zQjc2cHB4Y21rclhzaThVVDgvSzFX?=
 =?utf-8?B?Y1BNQ3dXYktUdTB2TE5kUXdnc0ZzbXNqaDE4OFIvNVJzZVdhUnZtUnZQdXFD?=
 =?utf-8?B?bVBSK3BFb282aEZsUTZHVWNVN2U1SHdIblBGcVc5QmtYOENWemppUytMWkZt?=
 =?utf-8?B?b0VGRnVWdWc2c2hlNGxuWXFaZGtyQzFFbG1LbUlDMDV6dTdVakU0UUM0UDBR?=
 =?utf-8?B?TDFCSk9xY2NCOXQ1VmFBaE4xUEExMjM4aHdmaHk2R3hqUCtTT0RDSm9wcHdN?=
 =?utf-8?B?cC8wbzZJd0cvcExzb2tBRWtGVG9QTGg1b0NyM2NwL3QvaXZoaCtwRnMra3dN?=
 =?utf-8?B?dlZuVldBQ0p6ZUJwdUpkY281ckdsRDhXTnB4TUE2eVlTZk1WenJmL3h0OHRH?=
 =?utf-8?Q?eY0m7flmCjs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eklFRmRpV0hmRjhXZHFnQTdmRWE4K1IrSzhFVUZUNmxoZ0VGUTZDcFJSVGV1?=
 =?utf-8?B?dVlVTTVKeDRZVUVTME1rMTR0VWU3aDBIajFvaml6U1pWMktoWVY0VWd5ZFpL?=
 =?utf-8?B?SHFLWExhRG00TWtnS0hiTHU0NFNORjNLODdVbWxUU3pueVBUYjNSZi9MeDNj?=
 =?utf-8?B?ejhtMEd6RmpJTG5kRCswUmJHMWVrUkRPcTk1RHpWQVNXYTVGQWxYNERwVlcz?=
 =?utf-8?B?RG1yL0ZTVFQrWWozS1NFT1NROTdlbk5wNnpQV0ZIU0pudmxlR05aRXVrdHc4?=
 =?utf-8?B?TUhORFNKaGhSWUEzTVVWcE1uU1FlT1pFNjhtQzNRQThqelNENUxiWHNVd0Ux?=
 =?utf-8?B?WHF0bFlBZkpqL2lKcU9uM1dkYlNSSlJ3bkxVamJhUzZ4ZFJxem9WVHp4dW40?=
 =?utf-8?B?Q3VQRUpYcVE5WnQxdG1tbnBKcHFBa21qcHptcVFaSXNCbEUzc3VwTFFsUjVX?=
 =?utf-8?B?NEtKU01JcUhwOVBuczZGR2VnZ0k2UHNiSFVvdGZBSFFUSXhzZkRVelNtcHlR?=
 =?utf-8?B?SFUrYm1JdGt2dEo1UUo2S2ZXd1VWbGpQazI1Q2VBVjhuYUh4QTdJQ0pFRjRT?=
 =?utf-8?B?T2dQc0Y1MFl4QzJyVHVjZCtvYWUydmxoYmtiRDhkWUY5LzdDcU1FR1VRbkJN?=
 =?utf-8?B?RVNiWm9GVXMzTkREUFZVMHNxcVhvQTRFVmwyVUFBcmdPb3BNZGRaVllVVms1?=
 =?utf-8?B?Z0tKT2lnN3NkUVhEY0NHbDREeThLdEQ0bHl6ZGZvVUpYTmtLMnhSdE1KZjhJ?=
 =?utf-8?B?ZE90STlGYWhnRVNaMlRReWorL2lHL0lvbmVvSmNTYXJTMXBWNXBwbDg3eW1I?=
 =?utf-8?B?OU8rNlBRS3dtRlJiOUlrcE1UV1NWRTN2MElmc2FKbUxzQ0hWOXplZk92anJM?=
 =?utf-8?B?WndNNmRDeWtXMXVqY05rd0hnNWR0Z2V2NEdwQnVzS3dOT2RrejhBTGNwcFRN?=
 =?utf-8?B?bWY4YlRmekdaNWlRalpwVXdpVUtQeHJOTmkyQmp4eG5qQWptU2lZcUl3RnRO?=
 =?utf-8?B?cHFqdE5kWGNHODlDNEVvQ24wcjRKTFpSWlo5L1JXUXdjcnlBMTdXNHNEZHk1?=
 =?utf-8?B?d0pjamtRdGJUY0RoNXVJaysrUWM4OG1vdHliSDNqc1E1Q3FxTW9oRldaZzVH?=
 =?utf-8?B?dFhVb1h1YjRPYmZtWjYzZE1FU3dkNTM2ZGkwZDR1dWZPR1hGWUJIVHQzSVVR?=
 =?utf-8?B?NkZsV0U5ektvWnJZZ2FMTCtxbk8xSnJZU3owa0szNnlNRHVQd2lnSGRicTB5?=
 =?utf-8?B?aUk0SXRqSEt1RXh2V0l0TnMrZndLaXZPZmhVa28rN2M2VXZpZmVXSk5CZ0FL?=
 =?utf-8?B?R0xoMjc1OURjTGdNSG0zak9LaERST0dNRERiK2lzY2tKNjRzV1pFQjZHbGo4?=
 =?utf-8?B?L05xVGFhNjVPcmtyQ2JLNUUvN2hhWU9BNzBQZ2VLRlRINmh4UDFlbDFnUnBu?=
 =?utf-8?B?aU4wZXFMaksraFJIand2QjZ3QjE5RUNPNjRHdDFMcDl5QUZPbHZDbWdmUmlq?=
 =?utf-8?B?QTFZZHBMdHpwNDQyRGlDbGFGOFhWK1JCM3ZIRmcrWEtWRklaWXl0OWlDdFdG?=
 =?utf-8?B?UUZac1pOaEZyazNtRnk0MlIrc0cvYjBJWW05d2x4MmdKa0c3VXR5c2cxb2pJ?=
 =?utf-8?B?dmNHTm1pRTQxb1B1QVZCTFdjM2gwdUNscVZISHEwZWEvR2ZoMDVuZlBhcTF2?=
 =?utf-8?B?OEFKWmhkeU1tWjBLOXlqdE9abWR2eDNNb3UzSkkyNFNBWGc0TjRzWmNwYThi?=
 =?utf-8?B?TGhyS1cvTjJWZW9NQktMaEYwQkEwczJkT1FMdmxlRlUwRGV0Skc5Y1RwS3l4?=
 =?utf-8?B?ZTZ2U01ONDBnMVJSUldUY0Q2UEc4ZHo5Qmx0UXdFbzJjOHI4OTg1V0VMRjdQ?=
 =?utf-8?B?Vm5CMVJmc0tzVHJmeWpYajNFb0Mxd1pkcU1JOEVsR011eitlb2J5SVRpR1Q1?=
 =?utf-8?B?cnhwbk1Va0VaT01DOWRzcm0zTWNlYnpGUGk4TFlQeFM2OG9ibXQweGd0SmVu?=
 =?utf-8?B?SWc3aFo5NnhqWUt5SktONVJzS2JCSUd6SGNMcW1wbmZncFRxZFhiTkZSbktY?=
 =?utf-8?B?NU9rR1ZWTUY0Vi91VTIrSThiaFJhNmdBLzNueXQxczBLNzIxQTlRMWJMNDRR?=
 =?utf-8?Q?Hzb2zu6JwB1u2ri1E0fvvzwTM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859810ed-beac-44a9-e58c-08ddce1a6e7a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 21:05:07.7495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bW+W8g07JQ2snCC9a5BRIyczm/hxVpuPfYNLh6eoC4nR02Z5RIu831bplo+yizDELpqvkiAxuAm3LXvLcnL4gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8262
Received-SPF: permerror client-ip=2a01:111:f403:2418::604;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 11:53:51AM +0200, Luc Michel wrote:
> Refactor the XRAM devices creation using the VersalMap structure.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h |  6 ----
>  hw/arm/xlnx-versal.c         | 59 +++++++++++++++++++++---------------
>  2 files changed, 35 insertions(+), 30 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 4eeea98ff34..71c3314b8b4 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -18,11 +18,10 @@
>  #include "hw/or-irq.h"
>  #include "hw/intc/arm_gicv3.h"
>  #include "hw/rtc/xlnx-zynqmp-rtc.h"
>  #include "qom/object.h"
>  #include "hw/usb/xlnx-usb-subsystem.h"
> -#include "hw/misc/xlnx-versal-xramc.h"
>  #include "hw/nvram/xlnx-bbram.h"
>  #include "hw/nvram/xlnx-versal-efuse.h"
>  #include "hw/ssi/xlnx-versal-ospi.h"
>  #include "hw/dma/xlnx_csu_dma.h"
>  #include "hw/misc/xlnx-versal-crl.h"
> @@ -86,15 +85,10 @@ struct Versal {
>  
>              CPUClusterState cluster;
>              ARMCPU cpu[XLNX_VERSAL_NR_RCPUS];
>          } rpu;
>  
> -        struct {
> -            OrIRQState irq_orgate;
> -            XlnxXramCtrl ctrl[XLNX_VERSAL_NR_XRAM];
> -        } xram;
> -
>          XlnxVersalCRL crl;
>      } lpd;
>  
>      /* The Platform Management Controller subsystem.  */
>      struct {
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 97cd991be10..6c5eb6d3fd5 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -29,10 +29,11 @@
>  #include "hw/char/pl011.h"
>  #include "hw/net/xlnx-versal-canfd.h"
>  #include "hw/sd/sdhci.h"
>  #include "hw/net/cadence_gem.h"
>  #include "hw/dma/xlnx-zdma.h"
> +#include "hw/misc/xlnx-versal-xramc.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -69,10 +70,18 @@ typedef struct VersalMap {
>          uint64_t chan_stride;
>          int irq_stride;
>      } zdma[2];
>      size_t num_zdma;
>  
> +    struct VersalXramMap {
> +        uint64_t mem;
> +        uint64_t mem_stride;
> +        uint64_t ctrl;
> +        uint64_t ctrl_stride;
> +        int irq;
> +        size_t num;
> +    } xram;
>  } VersalMap;
>  
>  static const VersalMap VERSAL_MAP = {
>      .uart[0] = { 0xff000000, 18 },
>      .uart[1] = { 0xff010000, 19 },
> @@ -90,10 +99,17 @@ static const VersalMap VERSAL_MAP = {
>      .gem[1] = { { 0xff0d0000, 58 }, 2, "rgmii-id", 1000 },
>      .num_gem = 2,
>  
>      .zdma[0] = { "adma", { 0xffa80000, 60 }, 8, 0x10000, 1 },
>      .num_zdma = 1,
> +
> +    .xram = {
> +        .num = 4,
> +        .mem = 0xfe800000, .mem_stride = 1 * MiB,
> +        .ctrl = 0xff8e0000, .ctrl_stride = 0x10000,
> +        .irq = 79,
> +    },
>  };
>  
>  static const VersalMap *VERSION_TO_MAP[] = {
>      [VERSAL_VER_VERSAL] = &VERSAL_MAP,
>  };
> @@ -633,41 +649,35 @@ static void versal_create_trng(Versal *s, qemu_irq *pic)
>      mr = sysbus_mmio_get_region(sbd, 0);
>      memory_region_add_subregion(&s->mr_ps, MM_PMC_TRNG, mr);
>      sysbus_connect_irq(sbd, 0, pic[VERSAL_TRNG_IRQ]);
>  }
>  
> -static void versal_create_xrams(Versal *s, qemu_irq *pic)
> +static void versal_create_xrams(Versal *s, const struct VersalXramMap *map)
>  {
> -    int nr_xrams = ARRAY_SIZE(s->lpd.xram.ctrl);
> -    DeviceState *orgate;
> -    int i;
> +    SysBusDevice *sbd;
> +    MemoryRegion *mr;
> +    DeviceState *or;
> +    size_t i;
>  
> -    /* XRAM IRQs get ORed into a single line.  */
> -    object_initialize_child(OBJECT(s), "xram-irq-orgate",
> -                            &s->lpd.xram.irq_orgate, TYPE_OR_IRQ);
> -    orgate = DEVICE(&s->lpd.xram.irq_orgate);
> -    object_property_set_int(OBJECT(orgate),
> -                            "num-lines", nr_xrams, &error_fatal);
> -    qdev_realize(orgate, NULL, &error_fatal);
> -    qdev_connect_gpio_out(orgate, 0, pic[VERSAL_XRAM_IRQ_0]);
> +    or = create_or_gate(s, OBJECT(s), "xram-orgate", map->num, map->irq);
>  
> -    for (i = 0; i < ARRAY_SIZE(s->lpd.xram.ctrl); i++) {
> -        SysBusDevice *sbd;
> -        MemoryRegion *mr;
> +    for (i = 0; i < map->num; i++) {
> +        hwaddr ctrl, mem;
>  
> -        object_initialize_child(OBJECT(s), "xram[*]", &s->lpd.xram.ctrl[i],
> -                                TYPE_XLNX_XRAM_CTRL);
> -        sbd = SYS_BUS_DEVICE(&s->lpd.xram.ctrl[i]);
> -        sysbus_realize(sbd, &error_fatal);
> +        sbd = SYS_BUS_DEVICE(qdev_new(TYPE_XLNX_XRAM_CTRL));
> +        object_property_add_child(OBJECT(s), "xram[*]", OBJECT(sbd));
> +        sysbus_realize_and_unref(sbd, &error_fatal);
> +
> +        ctrl = map->ctrl + map->ctrl_stride * i;
> +        mem = map->mem + map->mem_stride * i;
>  
>          mr = sysbus_mmio_get_region(sbd, 0);
> -        memory_region_add_subregion(&s->mr_ps,
> -                                    MM_XRAMC + i * MM_XRAMC_SIZE, mr);
> +        memory_region_add_subregion(&s->mr_ps, ctrl, mr);
>          mr = sysbus_mmio_get_region(sbd, 1);
> -        memory_region_add_subregion(&s->mr_ps, MM_XRAM + i * MiB, mr);
> +        memory_region_add_subregion(&s->mr_ps, mem, mr);
>  
> -        sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(orgate, i));
> +        sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(or, i));
>      }
>  }
>  
>  static void versal_create_bbram(Versal *s, qemu_irq *pic)
>  {
> @@ -1186,15 +1196,16 @@ static void versal_realize(DeviceState *dev, Error **errp)
>  
>      for (i = 0; i < map->num_zdma; i++) {
>          versal_create_zdma(s, &map->zdma[i]);
>      }
>  
> +    versal_create_xrams(s, &map->xram);
> +
>      versal_create_usbs(s, pic);
>      versal_create_pmc_apb_irq_orgate(s, pic);
>      versal_create_rtc(s, pic);
>      versal_create_trng(s, pic);
> -    versal_create_xrams(s, pic);
>      versal_create_bbram(s, pic);
>      versal_create_efuse(s, pic);
>      versal_create_pmc_iou_slcr(s, pic);
>      versal_create_ospi(s, pic);
>      versal_create_crl(s, pic);
> -- 
> 2.50.0
> 

