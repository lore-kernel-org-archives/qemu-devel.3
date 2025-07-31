Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17792C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhaks-0000gT-Mz; Thu, 31 Jul 2025 17:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhaO4-0005re-3a; Thu, 31 Jul 2025 17:00:28 -0400
Received: from mail-mw2nam10on20622.outbound.protection.outlook.com
 ([2a01:111:f403:2412::622]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhaO0-0003HF-Th; Thu, 31 Jul 2025 17:00:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKHPk4S4Hb8Mmb6Qj00vGsM5e2j39cvrFOjg7a8SbxxXMx4Z/u6KZYu82fhk3+RBrGvs0XEAEfR0Ve26WAWIGH4DMLbvDrxECTtTJVl/CHfDYDrpLHjrtjC+WqRTQa7AY5yepvjOXtYpJ70Ts2tp+yxstdm33Ql7+QFIgUiP9XjF/kxAH57L81bjfkMikzYTVV6LfHrkvLW5MCXCyzr/uxuNgbhWnJzAciO6rwNHPOES8vlttG4ZKf/jRYx9EIXj6xFe3R2tl8iGfuBC4XpgnXh6aPKr0akskGHrUNqYnqHa6LrM2LijmXcKhfB9VKkXegbqtTi1wGZ4chgPsq+Tdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1mKaay1cKRHW1/WXOXPhmv9BwCeuNMtc4q2mq9HaKc=;
 b=k7x0KxNP/KHnkKXUG3DrXaZB36SYgj7bdM1enV/9ErH3GgNPzqL2lwxoGxnZqRqm7sV4RubhErmJjBrO9h11bl4vC5R/BneRxWoAOeEifzLrykxVLxpSDDHLmC8//FnTq4pKrFOliSzoV9WwOR3eReShoiVm+QBLCt7xIlUuKFcrKf1aLuO/B8vc16Xb/masFkPrgnA9bxrQw1udEwJwJKDmN1zbHQ6skWtQS8a04GnYEmbDBfubEghblDCNYZ6QpIRJdP2eU/d/LND9GOIMmmueoqemY6QTv4s9JWq5gydfXpI5TNJU8UNgnZR0eQWTZFwbkVzilOuS6ohSWoOrug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1mKaay1cKRHW1/WXOXPhmv9BwCeuNMtc4q2mq9HaKc=;
 b=haApEwIr11dl2p24fSy2eMOAIh4XqJdNHzpAdeMa7g/6UXTFYv2s1pEr7CDZ8sUeq2uACZ7g54tpltTGicBRKQtmA2EnXHezdN4RSvZEhVZoHRiosfNFWLUXnfaXAhstpq69roU8+ksv8mpZGDCUcRpAORM+UdqNPHgQ+DQrSIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by CY1PR12MB9700.namprd12.prod.outlook.com (2603:10b6:930:108::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Thu, 31 Jul
 2025 21:00:18 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 21:00:17 +0000
Date: Thu, 31 Jul 2025 23:00:03 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 43/48] hw/arm/xlnx-versal-virt: split into base/concrete
 classes
Message-ID: <aIvZU7TB8KO0qqwZ@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-44-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-44-luc.michel@amd.com>
X-ClientProxiedBy: LO4P123CA0211.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::18) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|CY1PR12MB9700:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c061f7f-b742-48d7-e017-08ddd07540fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDhBWW9CN1ZJdTNYWU44S1Y3UFJqb1E2SEh5NWw3a3V5WWRPTEdpVFloSklw?=
 =?utf-8?B?V2h0d3ZUaUFmVitiR3hwczVvb1JhSjYza0NmTlJrUEJiR2Z4aGYzdEp0NnlM?=
 =?utf-8?B?ZFI3SmxEc1BwcElZTU1JUnZxaHIvZVozSHNJUGIwYTUxZSs5QlMyQUVQSEZ1?=
 =?utf-8?B?QnNRZlVRREZHMFpCSWhOMG9OSFliTjZIcTcvQjNXR3E5UnVPNCtDWEVaWVRj?=
 =?utf-8?B?T3dGbFdHc1J0dGRqeitVd0VNMU8rdGdCME1wbXppRExsemRMOUJDdGFGTSsy?=
 =?utf-8?B?SWJSakdmN3pyRnJSQStjK1dFbythWlBjNlJsbHptRjJSTkFpaGZCbWQxL3RK?=
 =?utf-8?B?MXVEb0NvODF2elJsMEZ1alp3YTNZWWdPZXoycHNTS1c0azEyTk4zOG1oSUMx?=
 =?utf-8?B?aUVjdFZrT25YRitPaURhV2tLRXNTTS95OGE2d3U4R2ltZE84UzhWcmFtYWhO?=
 =?utf-8?B?MXQ2bzY2Y25HNWdWaXp3QnBtbEw3bVl2eFpualQ1ejVjZlAxNW83TXNhZUl4?=
 =?utf-8?B?NXgyMmQvenJxbTdPTk00T0hidGFweDBwSlhCUFpFd215K1d2TkUzNDFjSW5W?=
 =?utf-8?B?VHdnZ3BubCthYndtRUJWMVNLbFVBNDJMdS9QdDVLM2RQNkpXa1BhdldsZ2NG?=
 =?utf-8?B?azBJNFhVS29LM0lJbkJDOWxoektlQ1hqeDNCWXpFK1BhSjF4Wll5bmhhNHEz?=
 =?utf-8?B?WjlhREdlZkFyTVlVdUo5V1JOUmZWN2IwbGFDbTVxVjRlY1BHSDZZMkFiWHdG?=
 =?utf-8?B?OEdiVzFtR2huM05BVWNOVENic2hoT2g3eDFoVmsyZFRpRjBMR2puTU92VXNJ?=
 =?utf-8?B?UjdxcEd0MzlHL3FxWm1leXNDSVUxa3ZsRVQzRlZ6UXhIcGVjdkdkK1IzRTB5?=
 =?utf-8?B?dUpSS1dadER5eUNPVjkwVWJCMVFWajNWUnVxRnQ5K2V6T0k5VGZYTDBrNVV4?=
 =?utf-8?B?cjRKd3FVdG1FYS84MVZoWlVDcVQyM0ZsTFVIdnF0MlA4V0Y3RTVtZnVDYkJZ?=
 =?utf-8?B?UzkwbWs3ZzFSV1IrUEd3Qlp5eGxRTHBLYjhFTGJlcElaTGNtbnhubzEvWTdY?=
 =?utf-8?B?T0ZEL21rY2MrYjZCNGlHQnkwTUcybWRSY3RwdTBMc2YwOVhvOGV3V3RqVVp4?=
 =?utf-8?B?cEZWN3F0VDVEOHp3a2lyQ1lKdXdvOG9CcEdNbVVzajdjUDFrcWR4TzlaL0V3?=
 =?utf-8?B?YU9CNWFHVXZydURDMU1FRDJETkdjMkxUaEhDYVhyeGtMZy8zWVFJQ3BnN2Rm?=
 =?utf-8?B?TktiTXB3SmJTU0RHNVVrbUtYN0xxRW1JTlFXekhzK2ZrazJPSkp4Slo0Sjdl?=
 =?utf-8?B?SUVDNTFCZVZ3QlA4c1h5cW1hVkhhZ2llb3RRZ0NkNVRSaW5vYnMxM3o4eDVz?=
 =?utf-8?B?b0hyd2JJOE5KeXdkS3Bmd1lvd3ZwUUJkVlFQUVlwRDJIeU1SZ0ZsU2oxV3Qv?=
 =?utf-8?B?djA2YUFiQlVxMnliaDRIRFF0dkNialBXT2VxQ0hCbWREVzhQa20rNjlBSUZK?=
 =?utf-8?B?bjVrcjFXVlJUdW4yV0pJbUJaSTFxSHlUU1BkektZZ1ZWTUEyMGlxRkNQSWg1?=
 =?utf-8?B?dXRaQWpERjNaRXlMcjhwTVJqT0RkTWpLSTFNWWZLallzejA5MVBKQ3pSSnZJ?=
 =?utf-8?B?d29wOEJ0WFdCN0lIb3RnbXg2R1lzSTE0R2F6RE1NMWlKQUpXSjFjTU1mbDRz?=
 =?utf-8?B?OEpLZ3JWdHdKUFFFSVF3N3J1UWJzTHpTK3oxRU1CeVh5Si96QjRIUCtxSVNl?=
 =?utf-8?B?dWFJKy96ZE9peHVjWUhPQ25hNC9Sck1ud0UxWTV1OXJkdUhYQnI5aTcrVW5M?=
 =?utf-8?B?YjZWcExJbFg1MkR2d0lJNlduaE5DSHp1YzVnMWNrRHdCWTFDV1BzNnpKS2x5?=
 =?utf-8?B?cnRDaEhHbGVvOWRYdldYb1hvazRFSWhoWnlIVVJaTmVuMTkwYzUyQXpnSkN4?=
 =?utf-8?Q?P67qlimkaEk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzNOcFg4aVNPT3dYakZHbFZOMFVzOHhwZGU5VU5obUJXcmI1UlNSM2kzZk1W?=
 =?utf-8?B?UEoyeHYxNHNXRXhWd2U5cUFlWlR4Q0xHVnl0WFNJb0tCZnhSMU9BRU0rRG5H?=
 =?utf-8?B?aDRYcU0vOHRja3lqTU8rWTJCWVhJYklkWDZWb0YyakFMdE1BdWcwL29zWkFT?=
 =?utf-8?B?NFZFbGtHNCtQL0ZNdjA0UUVaY284SElXWFQ3MHI3cVVlU3ZueTc5dkV6dFli?=
 =?utf-8?B?TFJvc09FL1VheTRPUy9Ga05pT01RbDAyY0txaTdHZXRUaHJrMXNia0pJVWxU?=
 =?utf-8?B?aytNM3FTU2FDMW04YXczUTBiZ0hDSWR1ZTFVWW51cnkwZ2NkdHp5OTU2eUFh?=
 =?utf-8?B?U0o0RnMvYzR1aXNlcnFicnc0MUVubmJLVVd4cUY2V2lWMm96bG1ldUQ0UnJR?=
 =?utf-8?B?eTFieWdlYkdyVFJlVThQbTEwS1ZaYTBmZnprUmhpdmdtSFZjeFpSZUhWeFdG?=
 =?utf-8?B?WStPbGdUV0hxcHpHdEJ1UTFLWmszMkF0bE1tUlQvMVJwN2k2alEwV2FpUmtW?=
 =?utf-8?B?Zi9ZRUhrQkllN0ZGak1pcHFVZFVPZTdMeWp2SGtYZGJBL0FwQk1DVEFjQnFt?=
 =?utf-8?B?ck1hY2FvTWlYZ2R3Wi94QnNTTk9lbUh2RTh4dzd0MWF1anhHcStBWEkyQW1m?=
 =?utf-8?B?M2pzMHdRQXNPRG82dUlQMVNQbCtuMDg5ODFpWFZzc1VRNzR0UXBVQ0NjdFE3?=
 =?utf-8?B?YVJ5bnU2Unp6LzFacldvT3FrN1ZMOGd1TUFsQXRxVGtuTTVBWXZ5dmRIbVN6?=
 =?utf-8?B?WjZBdXlYQytORlIwRXcwQVlYaWhjZFFtZVM0QW9BV2VjQW44bk5qWlZpbEp4?=
 =?utf-8?B?cG8zUXJjS0pQZTExR0wxVld0RXoybXhzbW84bkFMNmFLN2c4Y3hsTXk0Znor?=
 =?utf-8?B?Y1dmUXdmWkxQT3lQclRwbGptTDVobGk1dHFqWFExem9ocXhRL2Q1N0ZoY1RM?=
 =?utf-8?B?c2pIZHlXU2c1V2g5cEpNQVZpSDBwZ253VUFJL3I1NjBMeGZoVkF0Vkx5OHZF?=
 =?utf-8?B?TDVrTWdnRlkxblU2QlN1WVU0L2ZoZWRxMDZLdWQzMnBGNzJ5QjAvQTc0c2l2?=
 =?utf-8?B?Sy9UOFE3UzlyZE1ZYXdSOHdPazVpM1JtY1VQM2RkZXMvemE3OWtjWTAwbmY5?=
 =?utf-8?B?bENXZEZvN2dpQ0lCWE5zZmRuWUczMVRQWnhqdkEybnpFK0hYNWlUUE1WN0JS?=
 =?utf-8?B?UjZUdjYxeDhOSUdRNWlrYk9iYjVUQ1prQmt3YkswWFpjdGRjcldjQVNiQktx?=
 =?utf-8?B?YXEvUHdVR2hyNy9YSmZkZ2RjZGZ0ejRXYVBtM2tFUUVIeXhvKzNTMkRHV1Rv?=
 =?utf-8?B?L2x5SGdHSzR0dEErY0VhN09XSENjTUxzVENGRlRkTW95cmFwU0ZudFRiOXJB?=
 =?utf-8?B?b2VxbUVQbUtLRTJUSkdKbmxoamlQdUZkNUtadUtQZWNIQnNPT1hDcWFHRHJx?=
 =?utf-8?B?QmV4Tm1Jb3hJc2ZiM0FTY2NkY2pac1M3anFJUW9acEhDMEVuQVFya1J0bk5a?=
 =?utf-8?B?RkEvYUQ0QVJQREpRRmNzRDVrUTRFM1hDajQ4Z2VzUFdvTitzWXJzS0R5S3JG?=
 =?utf-8?B?aHlUTURMbmxCSHBScjlsZGZaYVlpU0lzTWtoV0tXT0FUa01HbmpVQml0TDlX?=
 =?utf-8?B?WlhSeU9GdWNjOU9JbTlxdWRLVkNISndJNDhnbkIyYldlUm9ycm1TQkIwT2tH?=
 =?utf-8?B?dmEvdS8xZEc3bldYcFJVMzVuQ2pMR1dtalYyR2wvVmd0aGlJSmRhVWMrem52?=
 =?utf-8?B?TmRtRVdXU0plK2RZaWJzdzU2ak56Zi92UWxTVVhBc2M1Mk5DMVExSWJZR01p?=
 =?utf-8?B?M1BTZDJRR0E1MHhCK0V0NzdTRElHelpsb3A0b093ZzFhNVpqVFRPdXRDUWNq?=
 =?utf-8?B?NmFPazhGNzh6L2ZCR242VkJvckZoT2czV2VNVlhnT2Qzc1VBUHd0cHphekJa?=
 =?utf-8?B?Q3ZTMit6SzNSbmRmZDg0VWJkSFhCQmlMYXA3SXZ6aXBmQjBPSkc0VVVnREI3?=
 =?utf-8?B?bHZhcy9sSG9rRjBDYmdQeHY0V3d0TkVwSXdwZ3paN00rYXdLNnBxMmdrdW1y?=
 =?utf-8?B?N1NaVVc4ZjFmZXQzQXJIMFNjNTRLR0J0VS91T1hremV5MS83THJ0OTFxeGVK?=
 =?utf-8?Q?85NP9Fzhi/OANBEuri0GV33RK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c061f7f-b742-48d7-e017-08ddd07540fd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 21:00:17.8929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+O3aMddh+vCmv6s0eepdGWYlTe1+YIMRRuYxTzLAqCG27lNddAoQPT77DLvH15gFzu7XRMc35abG1QwWGC99g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9700
Received-SPF: permerror client-ip=2a01:111:f403:2412::622;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

Hi Luc,

On Wed, Jul 16, 2025 at 11:54:25AM +0200, Luc Michel wrote:
> Split the xlnx-versal-virt machine type into a base abstract type and a
> concrete type. There is no functional change. This is in preparation for
> versal2 machine.

s/for versal2/for the versal2/ 

Otherwise:

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>  hw/arm/xlnx-versal-virt.c | 74 +++++++++++++++++++++++++++------------
>  1 file changed, 52 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index daacbfb984e..9b20aef8b07 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -24,12 +24,15 @@
>  #include "hw/arm/boot.h"
>  #include "target/arm/multiprocessing.h"
>  #include "qom/object.h"
>  #include "target/arm/cpu.h"
>  
> +#define TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE \
> +    MACHINE_TYPE_NAME("amd-versal-virt-base")
> +OBJECT_DECLARE_TYPE(VersalVirt, VersalVirtClass, XLNX_VERSAL_VIRT_BASE_MACHINE)
> +
>  #define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("amd-versal-virt")
> -OBJECT_DECLARE_SIMPLE_TYPE(VersalVirt, XLNX_VERSAL_VIRT_MACHINE)
>  
>  #define XLNX_VERSAL_NUM_OSPI_FLASH 4
>  
>  struct VersalVirt {
>      MachineState parent_obj;
> @@ -50,10 +53,16 @@ struct VersalVirt {
>          bool secure;
>          char *ospi_model;
>      } cfg;
>  };
>  
> +struct VersalVirtClass {
> +    MachineClass parent_class;
> +
> +    VersalVersion version;
> +};
> +
>  static void fdt_create(VersalVirt *s)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(s);
>      const char versal_compat[] = "amd-versal-virt\0xlnx-versal-virt";
>  
> @@ -191,27 +200,28 @@ static void sd_plug_card(VersalVirt *s, int idx, DriveInfo *di)
>      versal_sdhci_plug_card(&s->soc, idx, blk);
>  }
>  
>  static char *versal_get_ospi_model(Object *obj, Error **errp)
>  {
> -    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
> +    VersalVirt *s = XLNX_VERSAL_VIRT_BASE_MACHINE(obj);
>  
>      return g_strdup(s->cfg.ospi_model);
>  }
>  
>  static void versal_set_ospi_model(Object *obj, const char *value, Error **errp)
>  {
> -    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
> +    VersalVirt *s = XLNX_VERSAL_VIRT_BASE_MACHINE(obj);
>  
>      g_free(s->cfg.ospi_model);
>      s->cfg.ospi_model = g_strdup(value);
>  }
>  
>  
>  static void versal_virt_init(MachineState *machine)
>  {
> -    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(machine);
> +    VersalVirt *s = XLNX_VERSAL_VIRT_BASE_MACHINE(machine);
> +    VersalVirtClass *vvc = XLNX_VERSAL_VIRT_BASE_MACHINE_GET_CLASS(machine);
>      int psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
>      int i;
>  
>      /*
>       * If the user provides an Operating System to be loaded, we expect them
> @@ -239,15 +249,15 @@ static void versal_virt_init(MachineState *machine)
>      if (machine->kernel_filename) {
>          psci_conduit = QEMU_PSCI_CONDUIT_SMC;
>      }
>  
>      object_initialize_child(OBJECT(machine), "xlnx-versal", &s->soc,
> -                            TYPE_XLNX_VERSAL);
> +                            versal_get_class(vvc->version));
>      object_property_set_link(OBJECT(&s->soc), "ddr", OBJECT(machine->ram),
>                               &error_abort);
>  
> -    for (i = 0; i < versal_get_num_can(VERSAL_VER_VERSAL); i++) {
> +    for (i = 0; i < versal_get_num_can(vvc->version); i++) {
>          g_autofree char *prop_name = g_strdup_printf("canbus%d", i);
>  
>          object_property_set_link(OBJECT(&s->soc), prop_name,
>                                   OBJECT(s->canbus[i]),
>                                   &error_abort);
> @@ -272,11 +282,11 @@ static void versal_virt_init(MachineState *machine)
>  
>      /* Attach efuse backend, if given */
>      efuse_attach_drive(s);
>  
>      /* Plug SD cards */
> -    for (i = 0; i < versal_get_num_sdhci(VERSAL_VER_VERSAL); i++) {
> +    for (i = 0; i < versal_get_num_sdhci(vvc->version); i++) {
>          sd_plug_card(s, i, drive_get(IF_SD, 0, i));
>      }
>  
>      s->binfo.ram_size = machine->ram_size;
>      s->binfo.loader_start = 0x0;
> @@ -316,14 +326,15 @@ static void versal_virt_init(MachineState *machine)
>      }
>  }
>  
>  static void versal_virt_machine_instance_init(Object *obj)
>  {
> -    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
> +    VersalVirt *s = XLNX_VERSAL_VIRT_BASE_MACHINE(obj);
> +    VersalVirtClass *vvc = XLNX_VERSAL_VIRT_BASE_MACHINE_GET_CLASS(s);
>      size_t i, num_can;
>  
> -    num_can = versal_get_num_can(VERSAL_VER_VERSAL);
> +    num_can = versal_get_num_can(vvc->version);
>      s->canbus = g_new0(CanBusState *, num_can);
>  
>      /*
>       * User can set canbusx properties to can-bus object and optionally connect
>       * to socketcan interface via command line.
> @@ -337,47 +348,66 @@ static void versal_virt_machine_instance_init(Object *obj)
>      }
>  }
>  
>  static void versal_virt_machine_finalize(Object *obj)
>  {
> -    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
> +    VersalVirt *s = XLNX_VERSAL_VIRT_BASE_MACHINE(obj);
>  
>      g_free(s->cfg.ospi_model);
>      g_free(s->canbus);
>  }
>  
> -static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
> +static void versal_virt_machine_class_init_common(ObjectClass *oc)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> -    int num_cpu = versal_get_num_cpu(VERSAL_VER_VERSAL);
> +    VersalVirtClass *vvc = XLNX_VERSAL_VIRT_BASE_MACHINE_CLASS(mc);
> +    int num_cpu = versal_get_num_cpu(vvc->version);
>  
> -    mc->desc = "AMD Versal Virtual development board";
> -    mc->alias = "xlnx-versal-virt";
> -    mc->init = versal_virt_init;
> -    mc->min_cpus = num_cpu;
> -    mc->max_cpus = num_cpu;
> -    mc->default_cpus = num_cpu;
>      mc->no_cdrom = true;
>      mc->auto_create_sdcard = true;
>      mc->default_ram_id = "ddr";
> +    mc->min_cpus = num_cpu;
> +    mc->max_cpus = num_cpu;
> +    mc->default_cpus = num_cpu;
> +    mc->init = versal_virt_init;
> +
>      object_class_property_add_str(oc, "ospi-flash", versal_get_ospi_model,
>                                     versal_set_ospi_model);
>      object_class_property_set_description(oc, "ospi-flash",
>                                            "Change the OSPI Flash model");
>  }
>  
> -static const TypeInfo versal_virt_machine_init_typeinfo = {
> -    .name       = TYPE_XLNX_VERSAL_VIRT_MACHINE,
> +static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    VersalVirtClass *vvc = XLNX_VERSAL_VIRT_BASE_MACHINE_CLASS(oc);
> +
> +    mc->desc = "AMD Versal Virtual development board";
> +    mc->alias = "xlnx-versal-virt";
> +    vvc->version = VERSAL_VER_VERSAL;
> +
> +    versal_virt_machine_class_init_common(oc);
> +}
> +
> +static const TypeInfo versal_virt_base_machine_init_typeinfo = {
> +    .name       = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
>      .parent     = TYPE_MACHINE,
> -    .class_init = versal_virt_machine_class_init,
> +    .class_size = sizeof(VersalVirtClass),
>      .instance_init = versal_virt_machine_instance_init,
>      .instance_size = sizeof(VersalVirt),
>      .instance_finalize = versal_virt_machine_finalize,
> +    .abstract = true,
> +};
> +
> +static const TypeInfo versal_virt_machine_init_typeinfo = {
> +    .name       = TYPE_XLNX_VERSAL_VIRT_MACHINE,
> +    .parent     = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
> +    .class_init = versal_virt_machine_class_init,
>  };
>  
>  static void versal_virt_machine_init_register_types(void)
>  {
> +    type_register_static(&versal_virt_base_machine_init_typeinfo);
>      type_register_static(&versal_virt_machine_init_typeinfo);
>  }
>  
>  type_init(versal_virt_machine_init_register_types)
> -
> -- 
> 2.50.0
> 

