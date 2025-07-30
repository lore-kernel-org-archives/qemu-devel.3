Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EFBC83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 20:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDX0-0004LT-1g; Wed, 30 Jul 2025 16:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhCPS-0005jX-MM; Wed, 30 Jul 2025 15:24:18 -0400
Received: from mail-mw2nam10on20622.outbound.protection.outlook.com
 ([2a01:111:f403:2412::622]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhCPP-000159-0k; Wed, 30 Jul 2025 15:24:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSE3Dizof9Dk9+Ppv97cWHnwwmybRD/F9zT6FvxOeQXFg0Wwt0xSr9c2taKyBE9ey+4L63MS/QACUqcidZnQ55+9e3xICEmfCmG1c/AWnXcJmTJDvChtnJYj9+/5MXuHQKNa1ifWpZSh0hCGiB884WN+OL7451XoGkU/hFJLyuTuoPDcoFGY8M8/bpWU7TMR8Pz73XNtlPtZb3CI2FdyRpzGmaRGr2MznBdBh4j66zyl5bjfXazr08OhmdVx1dW/ertaPaA1rSq3nVt3IbQRyzAFEAOwohixK4dodcfXBZyGf7ZEptuapSyEQ8/IZnT/PNah00wq8oPLX6s5yRqepA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcpPkPnehFB5XC2K3Olu+sGquXxJIctfAco7K7rF2+s=;
 b=Em/oPoCE0E2s+EzjR45t9zChGFds80UUoQaW7VvO6DS62PPcMVCqzY8mEK9VPGqi2evm+6OVcWFlfjiQSEwcNubc8PppgjEpBfpBS0shO68crXl8hcpNDN9edK1H11qLqvZyOe6UhLz9Nu/Wo8eVAnHZIPpjTSfFkwd/tjn3ZSsidSbRVD9e2alFNZg2ZtoVzTx/xJvV9aEP7guTiVa06YQf61m5Ul9NkyTe4XPxDQYo6hUzINj7vmA3cW57JF33ldDlRff+9/WxmfavgcmPFpKqyTwCoBCTB+mPmwnNFL6tWc8twYA4wkPo6rDH3UIBy4EKLxb7+jza93qzJ/3m6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcpPkPnehFB5XC2K3Olu+sGquXxJIctfAco7K7rF2+s=;
 b=A0bODlKSNQ0LmhHSZMIMISX37yTdHQbu3ho11zDIo8i0R3bA8GJa35VEfSrEpKCSUAEN1LY/jptW8i5RHSawT0Y08TJ8WwLIPAn5+BLt2cWq8ep7Fm7++R5dUAO8UXxG9IxP5WFXIlj/8sbIRY4KI3lf3EhOaGbxbv+Ge8YC+rM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by SJ1PR12MB6193.namprd12.prod.outlook.com (2603:10b6:a03:459::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 19:24:05 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 19:24:05 +0000
Date: Wed, 30 Jul 2025 21:23:58 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 32/48] hw/misc/xlnx-versal-crl: split into base/concrete
 classes
Message-ID: <aIpxTokh3MAq6X00@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-33-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-33-luc.michel@amd.com>
X-ClientProxiedBy: DB8PR06CA0035.eurprd06.prod.outlook.com
 (2603:10a6:10:100::48) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|SJ1PR12MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: 94f8e0cd-346f-410d-baae-08ddcf9ea5ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3hOQzFNK0VqbXFCTitleTdNbGplbWZMckpSVFJYMDVNZFpsZi8yNnNDcUZJ?=
 =?utf-8?B?WFJSYXNGNGdMMTRuLys2RTcvSTROd1doYjFIUC81bDI1UDBVMEZZTTl6TTZv?=
 =?utf-8?B?TzNXVGR5RDloRXErNklOOWMrRVNVMGhBcU4wWktuMjhvSld5cTNhQXl6MTFz?=
 =?utf-8?B?ZnJBclY3dXgrc1c1STVzYWF1REc5UDJRZ2tuaUlzeGt1UUdDZXVzY0JOVDU4?=
 =?utf-8?B?cy9yN1ZOVjFRNnlpdmpidVJKWWhtWkxENDYrdG5uZm9mRlBNUENXVWpWcVEz?=
 =?utf-8?B?Y1o5VUlqVVhVblhwdzhVSEhvWExreUJobGZuS0o4ZjVCOE1vYWZEUWEyMXdQ?=
 =?utf-8?B?RC9KOEtYOWpmYUoyTnNpb1pEQStSSTFnSW5mczIzR1F4UGxhUTBXOGtYZEZ3?=
 =?utf-8?B?UnV6MFUzTjQwa2JhWE1xS3pGNk5TSXdZNi9GUmMvczN1U1FIOTNWSGNEbUZt?=
 =?utf-8?B?L3QzaDRYOHJiR2NMRFp6TTAwVHcxTGlQTmZ4ZW1rcXJ6NTRZRndiZitXeHhx?=
 =?utf-8?B?QUNqMjJ3K1hsMkIveGl1dWdxUW42ZVpkVWdPQlE5WnFWUGdnOU1DSElhcCtD?=
 =?utf-8?B?aHJkeEQ4TUFMNW5GSGtpTHdzNUtXc1ZlMG5DN0FZOVI2V25QbEdxZ3lHUjJV?=
 =?utf-8?B?TTFjUDdKMDU4SWlrdGJHbDRRcVcxYlVIRGtWOGFDQW04eENSejB1dURVZDJt?=
 =?utf-8?B?b3lRaE83NUNVMEpoMTlDcXFFcWVpVWQ4Rm5tU1NiZVJ0a3ZVa3VSRkFVME0w?=
 =?utf-8?B?aWxTOXJ5MXRjRUJyNE1XMktwbmNTei9oeS94K3lwNHlsMGg5Vkp1SllIU3JT?=
 =?utf-8?B?YTlWeFFvN0t0UkdJZzlyaVRUa3hRaU4zUGRHbi90VlQvamFNdkFOby9jOXh1?=
 =?utf-8?B?R0JGMGdlajdJVGsrOEdVVXhUaEZKUFJFRkZNbE9SL0pLYVlaMmJ3WEtiLzBJ?=
 =?utf-8?B?Qm9SVld5N2NZc0FURjFJT3ZiYnBDQys1L1YzNVVjbXk4QnJGRThjTWRsbVZo?=
 =?utf-8?B?ZkRQZFBDczRvY1NVT2kvVC81aS92VnVSNW9qVXc1dVdNU1NpTk95VWtFcmVV?=
 =?utf-8?B?algwaWcxNGRXeVA5SE9sM3c5NFJVelFkTDJEYUdGRFNOYTVyMEI2ZGtyc0p0?=
 =?utf-8?B?anNxT1N2VXNtWXVJZFBoclV0SUZtZmtIS0dnM0VYbE5kUEtFaFUrMDVhR2Nw?=
 =?utf-8?B?bm5oR3VpVEx3a0NxYVZwMHFKWDRDVURwZ2lWcWRISkZNVllSejlDMzB0MzUy?=
 =?utf-8?B?MmFveG81MUVTZmpLTDdRejg0SWdsTG4rOTBJaENhUG91c3NuRXFhTk5ZNjBi?=
 =?utf-8?B?QnFiVlVwTU9xWjNOVDVzSnpWbmdoN2hrcGJFOWZPY2Z1S2IwSWtCNVdyNHNv?=
 =?utf-8?B?MFRQajBGNjlCM1hPaWxrazF3cjdDRmg1UXdqMVR0V0dEcWFXMEZubkduekFh?=
 =?utf-8?B?TGk5bFYwQVp6QnIyRFExVzc2TElwTDJOQVZpSU03Ymw0aGN1OVQ2dm54RFFu?=
 =?utf-8?B?SzNLcmY2cXoySnRaOWJoMno4MUNjYzhGdTNWVzVUQlphWG1CVUFyU2pIWUJJ?=
 =?utf-8?B?YzFMVWxZMUw5WXAvZ05LbzhObFlmZzN5ekdleXZHYktnQ29iME8xamw2VkUw?=
 =?utf-8?B?R2crQTBpWWhHZTNUdUQrcVFsOGxjbGtucTczeENYbW5CRkhUaUhyMkllSFI1?=
 =?utf-8?B?N3NxS0pmeWxIbVZDd1ljMWNDbk1ZOWtmL2syR2p6WTJKM2JQWFBtd0lqTDcx?=
 =?utf-8?B?MEVaMy9zRWhtaFpuRmJMRlNLdnRDOU90RDZNNkt3T0lJeGR2QUJyZzNOcFhR?=
 =?utf-8?B?MWw0M3ozR3R0VTlBQzJRYTJoMk5nWVBuZGI1bzZvem5ycEw4TndNRXBlVmJF?=
 =?utf-8?B?NkxuRXlTVHI2cHNQOEdIcHNMb1pPVWJvMzJpMU50YnRBN1RPVmxMR21VNSt4?=
 =?utf-8?Q?9SxMl9prUkg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnpiUEh6Q1VRR1pYV1ovOFU0S3FVcFp4Qyt6ODhDNnJHam44QUtvZEp0cFl3?=
 =?utf-8?B?QkR2TGwvWlZ3TDNIcWo2bkpseDZ2aG0wR2QxOHRCblM3SUpRTVBwaEJLaGRV?=
 =?utf-8?B?Z0RVT1Rna1VkQ3MxMlZnbnZnWUFnaHRCWXhFMjRBSEJzSkNicnFuTlFPVlFh?=
 =?utf-8?B?L0lnVXh2Wm1DZ1dWZlRjUlFLcXM1Q0dOa2c4ZUN6SVRNcEh0NVB2b1hTd1ln?=
 =?utf-8?B?MFE0dDA5NkhZU1g4dnNrMkRxT2lOZ0ozVGk2Q2dKdHdvTFFhWUdtNXNBaHFQ?=
 =?utf-8?B?WkFVYi8xckFtekpXVE9nTXRxV0kvcFhkdjRkYkN4VHBtc3lRV3FCdFhPSUc3?=
 =?utf-8?B?VThiKzRnRXJPYmtzaGp6MkRhRE5hMzc3ajJQT2lNMmZkQVYvU3ZaVGtJaklR?=
 =?utf-8?B?YWgvL2pFU0lKZkZXTmc5RGZGUWt5Rm5QN1h0anBQZVpadW02c0NhYXRZczE3?=
 =?utf-8?B?QlBsZGxUUE15RFUrdGN2V3ZqOFZ1cGRPRGx4NGl5dkRyaUpxTlhndUtyNGw1?=
 =?utf-8?B?VkpOcm0xUG5kZ1NwMU81dmh3Zmx4eEJEdElZY3ZFVGVUU3R2WUYrN1c0RHFs?=
 =?utf-8?B?ejJETnZycmlrZEpxZ040bmlqWVRCUXl2SWE5MmdwSHVjUHVyeDZtQ09XRUxv?=
 =?utf-8?B?NGE1Znk1WVFZTUZIbEFTRFFtbHhRTGhRYXkrSDFTRFB3cWpMMjY3YVVNc2dk?=
 =?utf-8?B?MFdqYnFkSVpMZERsaTYwVmd1TG9aZ3MxZk96K3RXSFJTYmZ4dm02MXR0UFVT?=
 =?utf-8?B?MGJYNGxOcjFxajNOMWwvdURaSzFTMng3clozam45UThxVEZJdTkxcUtVVkh5?=
 =?utf-8?B?WVVJbVk1OE4yTFg0UHBHZkJ2eDk5dVJYSTVycHdIUWJFbUhtWTMveXgzaENK?=
 =?utf-8?B?UDZMcXl1NUZqcUxFNzBvU0dLRXlFdUtqUDJ5Qm9YS1A4UVRqVDc4TW9kcDdF?=
 =?utf-8?B?K0FzcnI4TnZUb3hVK3Z5TlRJWHc5SVRmK002N05NSnFVeHM2SmliTHd2Witw?=
 =?utf-8?B?Sk11YitXbkk3WFc2ZEpUMVBRSGh2d1BmbmlMejhWM0tQNXp2U0FVTCtxZGtt?=
 =?utf-8?B?Z1pDcUFJcGc5TGpzaTY2YUFyNXVKdm5ZcVAzODEzc0VOWkhKZlYwNGRreUFY?=
 =?utf-8?B?Tjl6K3FUdDA3QjdoRjdwOWZmbWFpdzA1Z1YwM3ExRUo2bXpidFBnZ3htWG9y?=
 =?utf-8?B?NGY2N2pFN3hLNTZnelR5dkNKZ3lmRzRUelNPa1h2aXJPTE1sWTNXbWlHU2JE?=
 =?utf-8?B?WWhXMTlnaTN2TkFFVTRjUmhOMklVUFQ5OVhWSHQvY05RYUlMejhzbEdlOFhV?=
 =?utf-8?B?MVJqQ2dieWJjejdKNDFmakE5RDNHNytGeHFYRElwdDVvdE1ySEFld2NPNG1l?=
 =?utf-8?B?MUFHek45ZHJsbkd2SktCejkxOW54MzJ1QzBJVGQ0QVBTUjh1OW9GaTBGRU5x?=
 =?utf-8?B?OWtpS2tsQy82NW5jYkNUU1Y2eGtpbmRnYXFqdmpFTnVMRDlvVkxUcUxtS0x6?=
 =?utf-8?B?aUtFUFVJWFk4UzlTMGdBWTBFR0RRRy80OCt2QkVwa0tmM0tEUFJlc0xPeDl4?=
 =?utf-8?B?TGJ4MVFCUmlCcnJ6L3JIK1VqQVpubjEzakNZd2tUYkZOVWZWd21RKzJmSUhv?=
 =?utf-8?B?SmtnUlFrUi9nWFZYbTYyMHRjUGZmcDFhSXhFMWk1VFJQT2o0NTVyazVUQk01?=
 =?utf-8?B?Qkh6Q0p6WWtEa2FWeHVES2JRdnRFTHVGQkZxS0FMZElacGFNZHZIWEdvSlpB?=
 =?utf-8?B?T3JWSnJ2NXpHTGFwOTh6cnpFL0xkaS85c1dyRGpSSDZiZ3ByU3Erd3RKa1JQ?=
 =?utf-8?B?aTV1eUxyWFNqVklIMzhBSU02WVZnS05OMElOZkFtODJvaE15VU1wSUdkVUxC?=
 =?utf-8?B?T256N2NJV210a1QwZEVpMnBKZitpRjYzZ2ozUVpWcEg1ZHFWM1I0Lzl1Vk0r?=
 =?utf-8?B?eVl6d1dRQXQ0WEZNYU5ZOE5lUVZ3TUJDeGt3cFg4QUtZYTV1ZlRWbTRlMGJz?=
 =?utf-8?B?YlZBWUFKL0o2dUhmankxcnQxSTJTbDdOVXhseGlOWEZwc1plVldkZnRidm13?=
 =?utf-8?B?bDVHcURnMEZCb2hnTmEvUm42U1lMcE5ERlh1ME9pRTFiL1dQUURuSUcrVEZq?=
 =?utf-8?Q?w8HF0CS3w56hVj73RrO64hOpU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f8e0cd-346f-410d-baae-08ddcf9ea5ec
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:24:05.4623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTJ3HECbi/DDAMyGcXOEeh/9/aEybPcR9J2oTNJRVJ+TDF7OPokuEZke4b3wySMyEnkUFgpYRKMnkFoxd3f6QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6193
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

On Wed, Jul 16, 2025 at 11:54:14AM +0200, Luc Michel wrote:
> Split the TYPE_XLNX_VERSAL_CRL type into base and concrete classes. This
> is in preparation for the versal2 version of the CRL.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/misc/xlnx-versal-crl.h | 31 ++++++++++++++++++--
>  hw/misc/xlnx-versal-crl.c         | 48 +++++++++++++++++++------------
>  2 files changed, 58 insertions(+), 21 deletions(-)
> 
> diff --git a/include/hw/misc/xlnx-versal-crl.h b/include/hw/misc/xlnx-versal-crl.h
> index dba6d3585d1..2b39d203a67 100644
> --- a/include/hw/misc/xlnx-versal-crl.h
> +++ b/include/hw/misc/xlnx-versal-crl.h
> @@ -1,21 +1,27 @@
>  /*
>   * QEMU model of the Clock-Reset-LPD (CRL).
>   *
>   * Copyright (c) 2022 Xilinx Inc.
> + * Copyright (c) 2025 Advanced Micro Devices, Inc.
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   *
>   * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>   */
>  #ifndef HW_MISC_XLNX_VERSAL_CRL_H
>  #define HW_MISC_XLNX_VERSAL_CRL_H
>  
>  #include "hw/sysbus.h"
>  #include "hw/register.h"
>  #include "target/arm/cpu-qom.h"
> +#include "hw/arm/xlnx-versal-version.h"
>  
> +#define TYPE_XLNX_VERSAL_CRL_BASE "xlnx-versal-crl-base"
>  #define TYPE_XLNX_VERSAL_CRL "xlnx-versal-crl"
> +
> +OBJECT_DECLARE_TYPE(XlnxVersalCRLBase, XlnxVersalCRLBaseClass,
> +                    XLNX_VERSAL_CRL_BASE)
>  OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCRL, XLNX_VERSAL_CRL)
>  
>  REG32(ERR_CTRL, 0x0)
>      FIELD(ERR_CTRL, SLVERR_ENABLE, 0, 1)
>  REG32(IR_STATUS, 0x4)
> @@ -214,22 +220,43 @@ REG32(PSM_RST_MODE, 0x370)
>  
>  #define CRL_R_MAX (R_PSM_RST_MODE + 1)
>  
>  #define RPU_MAX_CPU 2
>  
> -struct XlnxVersalCRL {
> +struct XlnxVersalCRLBase {
>      SysBusDevice parent_obj;
> +
> +    RegisterInfoArray *reg_array;
> +    uint32_t *regs;
> +};
> +
> +struct XlnxVersalCRLBaseClass {
> +    SysBusDeviceClass parent_class;
> +};
> +
> +struct XlnxVersalCRL {
> +    XlnxVersalCRLBase parent_obj;
>      qemu_irq irq;
>  
>      struct {
>          ARMCPU *cpu_r5[RPU_MAX_CPU];
>          DeviceState *adma[8];
>          DeviceState *uart[2];
>          DeviceState *gem[2];
>          DeviceState *usb;
>      } cfg;
>  
> -    RegisterInfoArray *reg_array;
>      uint32_t regs[CRL_R_MAX];
>      RegisterInfo regs_info[CRL_R_MAX];
>  };
> +
> +static inline const char *xlnx_versal_crl_class_name(VersalVersion ver)
> +{
> +    switch (ver) {
> +    case VERSAL_VER_VERSAL:
> +        return TYPE_XLNX_VERSAL_CRL;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>  #endif
> diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
> index f288545967a..be89e0da40d 100644
> --- a/hw/misc/xlnx-versal-crl.c
> +++ b/hw/misc/xlnx-versal-crl.c
> @@ -296,21 +296,21 @@ static const RegisterAccessInfo crl_regs_info[] = {
>          .reset = 0x1,
>          .rsvd = 0xf8,
>      }
>  };
>  
> -static void crl_reset_enter(Object *obj, ResetType type)
> +static void versal_crl_reset_enter(Object *obj, ResetType type)
>  {
>      XlnxVersalCRL *s = XLNX_VERSAL_CRL(obj);
>      unsigned int i;
>  
>      for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
>          register_reset(&s->regs_info[i]);
>      }
>  }
>  
> -static void crl_reset_hold(Object *obj, ResetType type)
> +static void versal_crl_reset_hold(Object *obj, ResetType type)
>  {
>      XlnxVersalCRL *s = XLNX_VERSAL_CRL(obj);
>  
>      crl_update_irq(s);
>  }
> @@ -323,24 +323,26 @@ static const MemoryRegionOps crl_ops = {
>          .min_access_size = 4,
>          .max_access_size = 4,
>      },
>  };
>  
> -static void crl_init(Object *obj)
> +static void versal_crl_init(Object *obj)
>  {
>      XlnxVersalCRL *s = XLNX_VERSAL_CRL(obj);
> +    XlnxVersalCRLBase *xvcb = XLNX_VERSAL_CRL_BASE(obj);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>      int i;
>  
> -    s->reg_array =
> +    xvcb->reg_array =
>          register_init_block32(DEVICE(obj), crl_regs_info,
>                                ARRAY_SIZE(crl_regs_info),
>                                s->regs_info, s->regs,
>                                &crl_ops,
>                                XLNX_VERSAL_CRL_ERR_DEBUG,
>                                CRL_R_MAX * 4);
> -    sysbus_init_mmio(sbd, &s->reg_array->mem);
> +    xvcb->regs = s->regs;
> +    sysbus_init_mmio(sbd, &xvcb->reg_array->mem);
>      sysbus_init_irq(sbd, &s->irq);
>  
>      for (i = 0; i < ARRAY_SIZE(s->cfg.cpu_r5); ++i) {
>          object_property_add_link(obj, "cpu_r5[*]", TYPE_ARM_CPU,
>                                   (Object **)&s->cfg.cpu_r5[i],
> @@ -375,45 +377,53 @@ static void crl_init(Object *obj)
>                               OBJ_PROP_LINK_STRONG);
>  }
>  
>  static void crl_finalize(Object *obj)
>  {
> -    XlnxVersalCRL *s = XLNX_VERSAL_CRL(obj);
> +    XlnxVersalCRLBase *s = XLNX_VERSAL_CRL_BASE(obj);
>      register_finalize_block(s->reg_array);
>  }
>  
> -static const VMStateDescription vmstate_crl = {
> +static const VMStateDescription vmstate_versal_crl = {
>      .name = TYPE_XLNX_VERSAL_CRL,
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT32_ARRAY(regs, XlnxVersalCRL, CRL_R_MAX),
>          VMSTATE_END_OF_LIST(),
>      }
>  };
>  
> -static void crl_class_init(ObjectClass *klass, const void *data)
> +static void versal_crl_class_init(ObjectClass *klass, const void *data)
>  {
> -    ResettableClass *rc = RESETTABLE_CLASS(klass);
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>  
> -    dc->vmsd = &vmstate_crl;
> -
> -    rc->phases.enter = crl_reset_enter;
> -    rc->phases.hold = crl_reset_hold;
> +    dc->vmsd = &vmstate_versal_crl;
> +    rc->phases.enter = versal_crl_reset_enter;
> +    rc->phases.hold = versal_crl_reset_hold;
>  }
>  
> -static const TypeInfo crl_info = {
> -    .name          = TYPE_XLNX_VERSAL_CRL,
> +static const TypeInfo crl_base_info = {
> +    .name          = TYPE_XLNX_VERSAL_CRL_BASE,
>      .parent        = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(XlnxVersalCRL),
> -    .class_init    = crl_class_init,
> -    .instance_init = crl_init,
> +    .instance_size = sizeof(XlnxVersalCRLBase),
> +    .class_size    = sizeof(XlnxVersalCRLBaseClass),
>      .instance_finalize = crl_finalize,
> +    .abstract      = true,
> +};
> +
> +static const TypeInfo versal_crl_info = {
> +    .name          = TYPE_XLNX_VERSAL_CRL,
> +    .parent        = TYPE_XLNX_VERSAL_CRL_BASE,
> +    .instance_size = sizeof(XlnxVersalCRL),
> +    .instance_init = versal_crl_init,
> +    .class_init    = versal_crl_class_init,
>  };
>  
>  static void crl_register_types(void)
>  {
> -    type_register_static(&crl_info);
> +    type_register_static(&crl_base_info);
> +    type_register_static(&versal_crl_info);
>  }
>  
>  type_init(crl_register_types)
> -- 
> 2.50.0
> 

