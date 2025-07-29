Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E87C87FCA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 21:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugsKY-0004co-Jc; Tue, 29 Jul 2025 17:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugqJu-0004tt-WF; Tue, 29 Jul 2025 15:49:08 -0400
Received: from mail-bn7nam10on2061a.outbound.protection.outlook.com
 ([2a01:111:f403:2009::61a]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugqJr-0005dS-Ik; Tue, 29 Jul 2025 15:49:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoYeFRPBZRPBVuDubJXP8jQkw3nQIet+gGFfZBwxI/KhX9iKDIKqnTXu6J4EjbRowq0CVSmdF946KOeZA98vM2sI5WaTuMUgsdDAjoxS3QUQBm6b+xKVMqez2o9jopYSJE49NCyiUzzsfRCmXxz+RC/xRDHVx4KAEGnPCswPEv9h5WzW4C0rODr/rFPjvt9k8k2NArEFE8GmTjDWnFedn2rPDxnwTW9pOQ4BsgWgIS+6yLQLRBGOi81lXCKElm6k5BtULAGDfYxf3+9xir/si5A4u4FWrQukCHCCdXor25e1HCkaojxrozCvz8rJROATmo/CoMTzPYoVqQt1ny7Daw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSqVk9aW9DhVWTIztOO2CQz/YBlQytPUmdEBbaE/f6w=;
 b=XRBczP3E1oaxbCUxlpsf2iPgKfEeDYQ0k3ZTsa6cm6m99ln6KiLGDC/lEcGLTlY/ZebHnM/Sz1S8wpUV5RCCiH8AmMyuWirQ5Sew7USKNYx3IUTCAX78I2F68RYh91GWm0CLiOgphsxBbb6aQC3pODOILVtfUZ7e7jJc3k0SdHOxa1/oXa4U2s/rc3wV/vo1K/HisBRPnDA+zX9xlWsLx88sxM8Hd70egVwLjNehywLetlhWDHNbh+hJbDPlxzGsX/Ziae4ZTucuwEBxYnhHwCIb3en81t8ML7eZ0K6XUJ3sIcGM5zseOO+CZdyOwjNRT+CGZoAjO8LXm3XB4KIXvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSqVk9aW9DhVWTIztOO2CQz/YBlQytPUmdEBbaE/f6w=;
 b=3q63q0zOuT+AAojDg2xXSVhNGPralZg/i7NVmbAwgE6DSUHzluWIQovPNqNKfxsc/BrvRzsccHenuGDIv+B+SIy9DmDmwE/jGWaL+pjgKKigVjUl2YtQi1dZEU3+niCWB0wu0/0oRV9QRSVVibhkXKZQcbGAphcmfqHEmNFvFAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by MN6PR12MB8589.namprd12.prod.outlook.com (2603:10b6:208:47d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 19:48:55 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 19:48:55 +0000
Date: Tue, 29 Jul 2025 21:48:49 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 15/48] hw/arm/xlnx-versal: bbram: refactor creation
Message-ID: <aIkloTBsq48w5BAo@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-16-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-16-luc.michel@amd.com>
X-ClientProxiedBy: LO4P265CA0193.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::7) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|MN6PR12MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d5f02b-0a0d-4d2f-c2b1-08ddced8f3e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnhsOEdyUGhLM3daUmExL2NVVVp5SFlLYlNwZngzN1A3SmYvOUtXZkVkTXp1?=
 =?utf-8?B?VWZKT1pRSnkrdnh6aUtqZThiVmRMVEk5TjhGQko2NkNoUWZOWkdlNTY5ZHIz?=
 =?utf-8?B?QlpSUFVzeVRUSE04SzF5VTFsRkgxRXdRTk1FVUwzQm5ZeDNDT1pFbVFKeFhO?=
 =?utf-8?B?N09WaytoQkNMd2ZlTkk1cjJzc2t1NUVoZnZlOWtPeXZXY3VtM1VGdVVkcVdi?=
 =?utf-8?B?MFlvZ29ZUGNFVVd1Q3hjVkpLM0gzZHRaMWoyMzc2dFBFSVJXWDVGeGFSR2lp?=
 =?utf-8?B?Y0xkQ3BZSEFxcm9rSVRTdXF3aXpCR0VNdnhBRjZsUUNOUWVJcXBvVVlobm9J?=
 =?utf-8?B?Uk1YMmZJTlFQbXBTYVdVaG9CbHlPUjRtbjNBNTJuU3FyUitqWlBFM2IwdWdG?=
 =?utf-8?B?TEtySU9UbU1QWWFkOG9wM1RCYkV6RTIyMEtWUW5XS0kvKys0S1M3WTVsOGU1?=
 =?utf-8?B?dTVWTHFNZGdrRmNNQjhIcVRXQXdheFQ1Z0djaFlIZEE4ajZockZVU1BsNWE0?=
 =?utf-8?B?SWZ0OHpBVHVmdWQ3T1hSbVc3S0NYUWV3T0UxT2w5YUwvSzVHaHZWQkhqdFhC?=
 =?utf-8?B?b2Y1ZlJLOUFKbTZpSS81a1YxOUFUUWQ5MEpzZVIvci90SEltVFN4eE5jMFBN?=
 =?utf-8?B?K1l5cDYrWk9iODY0aFR4cFBvMGZYMExZVUtYcml3NGl0bWxZUDkvRGloSEVB?=
 =?utf-8?B?SUt4QXNmcUpqZWVqZmFHejh4ZS9qOUEwQ2NOeGVoYnJSaGNIMFZVMFNZbFRC?=
 =?utf-8?B?S2szWnlIdnFoRHQ3cGdzay9lc0N0UnU2VURoOU5CM2IyWW5KWFFrQW1DczVy?=
 =?utf-8?B?a3NCVWF6TFNtY2EyaVhNM2hGbGp0Z3BENnUyZlhtUjljMU1vdkRBSVhEUThO?=
 =?utf-8?B?RDVnYTlqTFEyaTRkZTlRa01YTmVpcGNNUVg1ZEJtYktwNUYxTVI2UTcwdits?=
 =?utf-8?B?TTlUVDVQSnd1d1hUSlRnaUw1cjRZajkvSkc3dndPS0pKQis5d1N2cUNVZGJL?=
 =?utf-8?B?VHRvTmN4eG5Tc3NDcTRHUWFicFhpS0tKemViZitzaUcxRzJiNnQraUhRa0o2?=
 =?utf-8?B?ellMRHNudWtJMkFjTXFzdlQxc1QxdEhzTW1QN2FCWHhSdXlaWHAvNWVSZm1B?=
 =?utf-8?B?bm5Tb3dJbko3QWpBSVhIaGtERjlVZzlnSkgyRDZrR0lLTHVReXl3S0pIaThj?=
 =?utf-8?B?YWNQaThLOERWSW8wdVptL21MaDZxa09iYVJENVBhaXJHc2Rvb1NkY2tLb0RQ?=
 =?utf-8?B?MW9PczZtWWVhNkQ1M3oyeEVlQzNZY3Z2K3pjdGIrRm5QOFNLUTNRRXB4MTYx?=
 =?utf-8?B?Z1VyWVBNeWNPTElSMVFlNlBYQVNNVkpITkhOU0tWZm5ZSkVSVDZOcWxvUWFV?=
 =?utf-8?B?SGFYWjlSVzJmQTE3NEM4eG8rUWw3ajBTb29aNFlFOWRyd0JLQlBRN081VVE2?=
 =?utf-8?B?SFhubmNlb29rQThTbUNhNkFGRDlLbkNqaitLaGdDeGtBSm16Sm9Zc1kwbC9a?=
 =?utf-8?B?QWZ3TWtYdUg0cTUxM0EzR0pMcGhtVCs0Y1ZZdEkzYVdTUGN1ZWR1RFNjVC9v?=
 =?utf-8?B?eFFkamtrQ3JjbCs0TCtkTzRVaElPdTBRV3k4STRrSng3UmRBbHgvM2xack9E?=
 =?utf-8?B?eW0vMHQ2V2ovR0tBYWhHWDh6MW1DZmpyTHNGRzdOajVyZytDTDJvK285dmd5?=
 =?utf-8?B?ZjlQZ3JrWGswM2ZQUjlmdnRMb0MyMDA5N2xBMUlETmhvUEY0QVlRQmxkZHBW?=
 =?utf-8?B?aXZrZzhrZnVNWDIzdVJXQVZ3OElOaEFla2ozQlRseWYxazhBMjUzbGx1WWh4?=
 =?utf-8?B?WVlmakJRV1MySWV5bFUvRWhkb2JhR2JtS2h2OVdHS21OU2pkZWsxcVBWZ0lw?=
 =?utf-8?B?RHdPTk1YdFJCcUxNSDZFeTEvTk1odGtEMVZYWDVmbjR2bzZJV2dGQmRoQVVK?=
 =?utf-8?Q?4m5gI3C/nd4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a200WVdWRjVnNVhZNTFERmVsSVNjTUxuY0xhZERGUzliSlhTM1M1cFY2aktU?=
 =?utf-8?B?Y2ZMZEZLcGFZN0F2dHZyaHJ5bWU3MEFYaklCTnZMWU1VTjFBSHpzMDVNZkc1?=
 =?utf-8?B?L2lnaXBwSVJkOTJEMm5SY3ZLSFgwMDNCRjU3azlSYTV1S21zWGlXZ3lNclV0?=
 =?utf-8?B?M0dKekI4YUdoUlZCRjlBVWEvMi96MmlCY0xjcGNrZCthbG1XNDZsNUhhYzF4?=
 =?utf-8?B?NDZIVkZ2cUNMYy9iSjVnWkpYWDIvbFpWY21LNjMxT2dnYmowSG03NjZBRGt0?=
 =?utf-8?B?UDVPWFlrUEs2bS92UC9QTmVsYXZUM1BQTkxvYS8rcDFxVzZtM2FPRnJyWUln?=
 =?utf-8?B?K2Y1eDZLTmNoRWFjVXMxNnl5VDJRTFJIbUN1aU1hT1gwS1dObFFTWW5wYU1E?=
 =?utf-8?B?SkNuRkFLTHY2ZVZTZFJCUTMwQjYrYytDbStUSEJ0eHRHSlU1U3ZDMmk5S0pi?=
 =?utf-8?B?NkpxL0ZtaldYSnR1dVYwVkxlSkp5V0pDMzZUQWVFN0hGMXhYS1BsUTVWUGNn?=
 =?utf-8?B?TllraTFaYXJKNWVVM3kwWHp4V294dEtDRkJ0VThzOENqVFo5aTIvZHd4Q2tI?=
 =?utf-8?B?QmpMVW9xbmFjckl2Q3ZTc1AwUjl0WExBb3VlRG5ZcjdhWHE1YlBGbE0rRC9O?=
 =?utf-8?B?d2ZLdlFEL1RTck44bGtob2dxZjRXZE5BVXFSYllubkp1bUtkWFE1UnJmZzdF?=
 =?utf-8?B?SzlCSFUzdEx5RHRFVWJvM0FET0kxOWQ3ZFg2VnFvcjRpajc2bUZUK0FEa1Nr?=
 =?utf-8?B?MU5UYTU2dUlTem1ocWk2U0hIek1UNVduM0tLQWtJUmhHblBIQWs1czZxdm5w?=
 =?utf-8?B?eVcxR0p2dHIyNWJFN0x4azQ3QU4rZFZEMVh2Y2RHR08vR0YvQU9JN1BHVEth?=
 =?utf-8?B?WVcrb0YwVEsyUEJqRG1pL0NOWmJPVCtLT0tjQ0tVTnRMNHFRRlp6cVg1OWls?=
 =?utf-8?B?RnBjeUpMVzZQYzJXUGJUY1VQVXRyQm5LSUtyblVNWjZlWjNDWm5pZm13Z3VD?=
 =?utf-8?B?TEgyRS9KWEFFdUhmQ3F6WHMrYTFzU1pDb2hPTzcrMGVQSlFXcC9zNVRxUDUw?=
 =?utf-8?B?azhLU1lPcE51bE9rdVNaRjBVS3RaZ0h0N2xuUTJuRTNZQjhKZXMreUxyRXZT?=
 =?utf-8?B?WnNURG1JaXNJd25ibm9UcUFBdjhpTzZ6TjhmV3praXk1TzQ2QTZ5WUtrNzA4?=
 =?utf-8?B?YmMwWWxqWmdld1JRTXdZTzg2RFBMK3FuejNVOU41REdXYURyOXIrOEd4REQz?=
 =?utf-8?B?MjAvVEZPMnN5NEttaW9vUjIrK3VwV1FsQVNWUmp6WVBwb2FTdDBPS2dDTkNI?=
 =?utf-8?B?ckJRMzkzTndySS92RCtwRlBvc0wzVkZKUFVhbi84ZGp2eCt4OVlieW1JMTY0?=
 =?utf-8?B?MFRUbVR5OFVYYmZvT3JXZEx2dTlaZVdTRVVYK09wamFMQ0dGTDMyNTVreHg2?=
 =?utf-8?B?TzRwV25RK0tTZFc5Ny9YT2NMbWNhOFRucWZhZnFKMnNwcmVUVTduNUZmemxB?=
 =?utf-8?B?cEZ3UXIxSWRlSCtJQm5RSXdHOFRUVGtkZW1MbUp5a2lGY1pwaGNzY2lXZXZ3?=
 =?utf-8?B?cDE2MDB6MFVBd0FpeTU4TU1aZ3hSTUl2eDZEVUliRFRYc3JSQUh4TDdXVkFQ?=
 =?utf-8?B?ZkFTN1lOaGhpNHhoT21lZmQ2QW9wOGpqR0ZjYWdoQTdoczAvTDhadEtJVm1R?=
 =?utf-8?B?ZEFGUzZ1OGpxYWJhZUNYZFRsOGFCcUFDcFNZQ3J3Yjd2ZElVNSsyTDllSGlU?=
 =?utf-8?B?M290VHlJU01iaHg4S3ZyNXR5cmlhUTkvZFZ2b1FUY1l4aU5MQU9iQUU5MlBt?=
 =?utf-8?B?cndDUkNQVlVhVHhXVDJPdnd5eENlTHJDRGJMWFlMOHJRcHpmcGIvQ2o5NStV?=
 =?utf-8?B?TjFtYmFJaGhrNXB1Nkl3ZmgzMzRBdmlaS0YyaTJaU1hncGk5SE5qZzRsVW5l?=
 =?utf-8?B?bVpsSU9nQWZFc3VvbDV1WVR2cXozYmh5TC9QUU5JS3ZpVUlYS3hBNVg1MzRW?=
 =?utf-8?B?c0p1ZjhqVEpFY3RVWDJEZkVhRG44Nk4zWkhsN090VHFZTk5MTlpVVUp4ZUJY?=
 =?utf-8?B?M2tjSUdqNTQ3M253R0RjcXZoZFZSWkRHOXhCWFE3SVpDd0g5c255bFZGVTBl?=
 =?utf-8?Q?OvfPqvQ/gugoXhLGYgtGbnFUp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d5f02b-0a0d-4d2f-c2b1-08ddced8f3e5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 19:48:55.8247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4FmUj59hh+9PLmuQdqjzBGFRl9vWJdDY7pqhRACdp5vpwuZo4HctMeuQp0ndtJt5SPH2wpHFl0dDLqV/gKDXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8589
Received-SPF: permerror client-ip=2a01:111:f403:2009::61a;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 11:53:57AM +0200, Luc Michel wrote:
> Refactor the BBRAM device creation using the VersalMap structure.
> 
> Note that the corresponding FDT node is removed. It does not correspond
> to any real node in standard Versal DTBs. No matching drivers exist for
> it.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h |  3 +--
>  hw/arm/xlnx-versal-virt.c    | 27 +++---------------------
>  hw/arm/xlnx-versal.c         | 41 +++++++++++++++++++++++++-----------
>  3 files changed, 33 insertions(+), 38 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 78442e6c2c5..9adce02f8a9 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -17,11 +17,10 @@
>  #include "hw/cpu/cluster.h"
>  #include "hw/or-irq.h"
>  #include "hw/intc/arm_gicv3.h"
>  #include "hw/rtc/xlnx-zynqmp-rtc.h"
>  #include "qom/object.h"
> -#include "hw/nvram/xlnx-bbram.h"
>  #include "hw/misc/xlnx-versal-crl.h"
>  #include "hw/misc/xlnx-versal-trng.h"
>  #include "net/can_emu.h"
>  #include "hw/misc/xlnx-versal-cfu.h"
>  #include "hw/misc/xlnx-versal-cframe-reg.h"
> @@ -83,11 +82,10 @@ struct Versal {
>  
>      /* The Platform Management Controller subsystem.  */
>      struct {
>          XlnxZynqMPRTC rtc;
>          XlnxVersalTRng trng;
> -        XlnxBBRam bbram;
>          XlnxVersalCFUAPB cfu_apb;
>          XlnxVersalCFUFDRO cfu_fdro;
>          XlnxVersalCFUSFR cfu_sfr;
>          XlnxVersalCFrameReg cframe[XLNX_VERSAL_NR_CFRAME];
>          XlnxVersalCFrameBcastReg cframe_bcast;
> @@ -119,10 +117,11 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
>      s->cfg.fdt = fdt;
>  }
>  
>  void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk);
>  void versal_efuse_attach_drive(Versal *s, BlockBackend *blk);
> +void versal_bbram_attach_drive(Versal *s, BlockBackend *blk);
>  void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
>                                BlockBackend *blk);
>  
>  int versal_get_num_can(VersalVersion version);
>  int versal_get_num_sdhci(VersalVersion version);
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 43f3c3d0be9..2d7e8a5955a 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -170,30 +170,10 @@ static void fdt_add_rtc_node(VersalVirt *s)
>                                   2, MM_PMC_RTC, 2, MM_PMC_RTC_SIZE);
>      qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
>      g_free(name);
>  }
>  
> -static void fdt_add_bbram_node(VersalVirt *s)
> -{
> -    const char compat[] = TYPE_XLNX_BBRAM;
> -    const char interrupt_names[] = "bbram-error";
> -    char *name = g_strdup_printf("/bbram@%x", MM_PMC_BBRAM_CTRL);
> -
> -    qemu_fdt_add_subnode(s->fdt, name);
> -
> -    qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> -                           GIC_FDT_IRQ_TYPE_SPI, VERSAL_PMC_APB_IRQ,
> -                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> -    qemu_fdt_setprop(s->fdt, name, "interrupt-names",
> -                     interrupt_names, sizeof(interrupt_names));
> -    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> -                                 2, MM_PMC_BBRAM_CTRL,
> -                                 2, MM_PMC_BBRAM_CTRL_SIZE);
> -    qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
> -    g_free(name);
> -}
> -
>  static void fdt_nop_memory_nodes(void *fdt, Error **errp)
>  {
>      Error *err = NULL;
>      char **node_path;
>      int n = 0;
> @@ -344,19 +324,19 @@ static void create_virtio_regions(VersalVirt *s)
>          qemu_fdt_setprop_string(s->fdt, name, "compatible", "virtio,mmio");
>          g_free(name);
>      }
>  }
>  
> -static void bbram_attach_drive(XlnxBBRam *dev)
> +static void bbram_attach_drive(VersalVirt *s)
>  {
>      DriveInfo *dinfo;
>      BlockBackend *blk;
>  
>      dinfo = drive_get_by_index(IF_PFLASH, 0);
>      blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
>      if (blk) {
> -        qdev_prop_set_drive(DEVICE(dev), "drive", blk);
> +        versal_bbram_attach_drive(&s->soc, blk);
>      }
>  }
>  
>  static void efuse_attach_drive(VersalVirt *s)
>  {
> @@ -442,11 +422,10 @@ static void versal_virt_init(MachineState *machine)
>      fdt_create(s);
>      versal_set_fdt(&s->soc, s->fdt);
>      fdt_add_gic_nodes(s);
>      fdt_add_timer_nodes(s);
>      fdt_add_rtc_node(s);
> -    fdt_add_bbram_node(s);
>      fdt_add_cpu_nodes(s, psci_conduit);
>      fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
>      fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
>  
>      sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
> @@ -456,11 +435,11 @@ static void versal_virt_init(MachineState *machine)
>       * modules unaware of multiple address-spaces.  */
>      memory_region_add_subregion_overlap(get_system_memory(),
>                                          0, &s->soc.fpd.apu.mr, 0);
>  
>      /* Attach bbram backend, if given */
> -    bbram_attach_drive(&s->soc.pmc.bbram);
> +    bbram_attach_drive(s);
>  
>      /* Attach efuse backend, if given */
>      efuse_attach_drive(s);
>  
>      /* Plug SD cards */
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index d34a36e18aa..615eea54372 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -34,10 +34,11 @@
>  #include "hw/misc/xlnx-versal-xramc.h"
>  #include "hw/usb/xlnx-usb-subsystem.h"
>  #include "hw/nvram/xlnx-versal-efuse.h"
>  #include "hw/ssi/xlnx-versal-ospi.h"
>  #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
> +#include "hw/nvram/xlnx-bbram.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -117,10 +118,11 @@ typedef struct VersalMap {
>          uint64_t dma_dst;
>          int irq;
>      } ospi;
>  
>      VersalSimplePeriphMap pmc_iou_slcr;
> +    VersalSimplePeriphMap bbram;
>  } VersalMap;
>  
>  static const VersalMap VERSAL_MAP = {
>      .uart[0] = { 0xff000000, 18 },
>      .uart[1] = { 0xff010000, 19 },
> @@ -159,10 +161,11 @@ static const VersalMap VERSAL_MAP = {
>          .dma_src = 0xf1011000, .dma_dst = 0xf1011800,
>          .irq = 124,
>      },
>  
>      .pmc_iou_slcr = { 0xf1060000, OR_IRQ(121, 0) },
> +    .bbram = { 0xf11f0000, OR_IRQ(121, 1) },
>  };
>  
>  static const VersalMap *VERSION_TO_MAP[] = {
>      [VERSAL_VER_VERSAL] = &VERSAL_MAP,
>  };
> @@ -811,26 +814,25 @@ static void versal_create_xrams(Versal *s, const struct VersalXramMap *map)
>  
>          sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(or, i));
>      }
>  }
>  
> -static void versal_create_bbram(Versal *s, qemu_irq *pic)
> +static void versal_create_bbram(Versal *s,
> +                                const VersalSimplePeriphMap *map)
>  {
> +    DeviceState *dev;
>      SysBusDevice *sbd;
>  
> -    object_initialize_child_with_props(OBJECT(s), "bbram", &s->pmc.bbram,
> -                                       sizeof(s->pmc.bbram), TYPE_XLNX_BBRAM,
> -                                       &error_fatal,
> -                                       "crc-zpads", "0",
> -                                       NULL);
> -    sbd = SYS_BUS_DEVICE(&s->pmc.bbram);
> +    dev = qdev_new(TYPE_XLNX_BBRAM);
> +    sbd = SYS_BUS_DEVICE(dev);
>  
> -    sysbus_realize(sbd, &error_fatal);
> -    memory_region_add_subregion(&s->mr_ps, MM_PMC_BBRAM_CTRL,
> +    object_property_add_child(OBJECT(s), "bbram", OBJECT(dev));
> +    qdev_prop_set_uint32(dev, "crc-zpads", 0);
> +    sysbus_realize_and_unref(sbd, &error_abort);
> +    memory_region_add_subregion(&s->mr_ps, map->addr,
>                                  sysbus_mmio_get_region(sbd, 0));
> -    sysbus_connect_irq(sbd, 0,
> -                       qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate), 1));
> +    versal_sysbus_connect_irq(s, sbd, 0, map->irq);
>  }
>  
>  static void versal_create_efuse(Versal *s,
>                                  const struct VersalEfuseMap *map)
>  {
> @@ -1323,14 +1325,16 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      slcr = versal_create_pmc_iou_slcr(s, &map->pmc_iou_slcr);
>  
>      qdev_connect_gpio_out_named(slcr, "ospi-mux-sel", 0,
>                                  qdev_get_gpio_in_named(ospi,
>                                                         "ospi-mux-sel", 0));
> +
> +    versal_create_bbram(s, &map->bbram);
> +
>      versal_create_pmc_apb_irq_orgate(s, pic);
>      versal_create_rtc(s, pic);
>      versal_create_trng(s, pic);
> -    versal_create_bbram(s, pic);
>      versal_create_crl(s, pic);
>      versal_create_cfu(s, pic);
>      versal_map_ddr(s);
>      versal_unimp(s);
>  
> @@ -1372,10 +1376,23 @@ void versal_efuse_attach_drive(Versal *s, BlockBackend *blk)
>      }
>  
>      qdev_prop_set_drive(efuse, "drive", blk);
>  }
>  
> +void versal_bbram_attach_drive(Versal *s, BlockBackend *blk)
> +{
> +    DeviceState *bbram;
> +
> +    bbram = DEVICE(versal_get_child(s, "bbram"));
> +
> +    if (bbram == NULL) {
> +        return;
> +    }
> +
> +    qdev_prop_set_drive(bbram, "drive", blk);
> +}
> +
>  void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
>                                BlockBackend *blk)
>  {
>      BusState *spi_bus;
>      DeviceState *flash, *ospi;
> -- 
> 2.50.0
> 

