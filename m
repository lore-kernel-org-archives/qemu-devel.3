Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4019CC87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhaox-0008BQ-5J; Thu, 31 Jul 2025 17:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhaWE-0008FY-Ct; Thu, 31 Jul 2025 17:08:54 -0400
Received: from mail-bn7nam10on20623.outbound.protection.outlook.com
 ([2a01:111:f403:2009::623]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhaWB-0004VO-Tl; Thu, 31 Jul 2025 17:08:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbjt5KNOm5jmmsTysWALU7+AU3LUFG2ihd4NBHfTzVfKmtQlgYVQ0RYTFn7Qb6AfFpLL2ydyHodcKpWCcZ3mBzgdXiOe4Tk8zq1emrgjJP/grAFJh/a6azX5UNkm+PHLHybzw8muEROvpOAOyrRlU6GAoKAD19NBtE/XVF4NhXZQu9dSJPeAuwVxpgLbc5Npqp2z+XOWR5gity25/ru2IVr8fU/QgrLYaLiL97LQSd70VnoQ0dlT+rr3ikGsBf6Cz27IS6/BMveWaGV/8lJaQW+QU8PWgoEBP57P4shSPUMCc2l2aLnAWw5JXmu0IyRjMT4d00Gcc9vJKD2IkVGS5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6esxwyRqbyvgjjKvSpJ5Yp0588Ey+QoXzOxyTP5bmo=;
 b=K023bUn3kl+OzXLZyCvKpZllRew5VJfvM9fCH9X3QRiVoobPOqwDcQK/j1War2W5kSVjy+q097qhvhX2dFIQ05cg/gO32YNAUpgLqEQJB6wIvKoyHgUWO+QwsC9v6FowcyPU3ZdspYOo2niAJFSgHgxFtg7KCXvqxdTdUoPWg5sAOIo25wzDtcyOSMbFY5Cmk+/XFBTvtKFdUlB/YNxHZWaDFSuW+8GiRQC93dOJNLotNYm++UAX7VlGOnj+SLF7tpTgRGkLGopWljX//WhfJXv34Fff4bO0YalpjjaDoKpQmFDn6rknyl8XhirD4sHfzgBH2V9Q+750VCOfXr9rEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6esxwyRqbyvgjjKvSpJ5Yp0588Ey+QoXzOxyTP5bmo=;
 b=YA4LsZzCIIKi5rIIR9Gsw7GN91f84EEd4MWmY7SYTGBg9YB+4Nj8+DlDyr+m5+ITnb5cl5Y0rjnHDuhmpTJ4x5Q3Ba3BS4KIuAh0hNHysOaC/JrfCV4mssVysLBAC7TWueZVXugb2Yio0q2bE6211Jr/gMnlykL0CNgAsg74ILc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by IA0PPFC855560D7.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Thu, 31 Jul
 2025 21:08:46 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 21:08:46 +0000
Date: Thu, 31 Jul 2025 23:08:40 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 47/48] hw/arm/xlnx-versal-virt: add the xlnx-versal2-virt
 machine
Message-ID: <aIvbWJgb5zRQqcD1@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-48-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-48-luc.michel@amd.com>
X-ClientProxiedBy: LO4P265CA0276.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::16) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|IA0PPFC855560D7:EE_
X-MS-Office365-Filtering-Correlation-Id: 16b7a168-4e65-415b-f522-08ddd0766ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHRFcURUNXRvaUl5QmhXRzFFNVRRbGhTTmZuYnNwOHV0RUpPbDRFbmQxUTFy?=
 =?utf-8?B?VU5DbTVHazVUbjlVckpzOXJhU2pxRmZQR1NUUHpBcUtpb1Z4QkZmZ3Y2Yjhn?=
 =?utf-8?B?ZXZTeXFQYWQxWlNWZ28rTy9ZcW9WLzdPU1lDVU1QWDVlMmdVdUovRHRkVDdz?=
 =?utf-8?B?Zk9mNXVmN3NUcXNkQ2FnTG9zVkZSTmpuQk9RSFNITnVwQ1VtakJLdkQ2K0hm?=
 =?utf-8?B?WHpVcEVhT0ZDOG9MclpKWlNMTTByYXVkNjMyWm5JeU5PUjlwM012aUpEVTFK?=
 =?utf-8?B?SWZBWERPdjZsczZrdi94bGdCZGNTOGRrRHkycUFlQ3VVblI5aWRXeklmeWZW?=
 =?utf-8?B?V1o0SmhENmw1VzR2Q3AyWmF4L0NmN2tHMU45WjIyT21IdmJrdTZFaG9GVkRZ?=
 =?utf-8?B?ZG5XS2J5dTNhS1ZOZENpL1NudEhXNW9wQTVTS0Z3UVluVlNnUjZBUk1oVmFr?=
 =?utf-8?B?QW9aUFlHUlRORUNha2VSTEJaUWZKQ1VJQ2toWWxsTEIrNkpKTzlMcjFxbVBm?=
 =?utf-8?B?RzM0U0t5Rlgvcm1rUU1RTWNWbkRmRENUZE9pdUNjNGVxYXN6RUs1cDQzRzhY?=
 =?utf-8?B?MWhwR2JVd3Z2NDcrRkFEenlZUjR1UVR6eFA1S2pCMk5hVGVVRTlZZmNac3h2?=
 =?utf-8?B?dFBzMThiK0g5d2RXR0YvTy95dHgyM1dpeGxwbkJaeGVQaGxmUFovMEZCUkF3?=
 =?utf-8?B?SW5pRC92Y0pJRDNYelRNb2x6Nnp3aVcvU2VSNy91bitYNU9JT1F2VVBEZE0r?=
 =?utf-8?B?MjhheVZ2TjhJTnJmOEJNNllBL29TVEJLdURTdGR1cFVFWkVweVJISm0wc0c4?=
 =?utf-8?B?bUp2MzF0VVVkdUx5b3BidXBsMjQzcXBaVWVHbjFybXJBcFBHMFE4T1hvbTVo?=
 =?utf-8?B?em4wRU1tWGVncVRlK1lTdGhQU1ZJeSszRkpOQnNOQTNicGJqVTNpbVlROTRr?=
 =?utf-8?B?ZGhLblIraGYySEVkQWt3RzJmNEVLNTI5YmczempSWXkvU1NHbGRnUmNFaGJ6?=
 =?utf-8?B?MEpOTERRckFzZzFXc2EzZHdrK1JmY2Z6MTFQa3l2Q0ZHOVoxT21MUVg3YXpy?=
 =?utf-8?B?RFYxeWhzT2ZOVlovQlU1dzBXekZ4Z01pNUVWT0Y0NStmVzVlTkVCUCtpUUNP?=
 =?utf-8?B?NUFYOS9jVVdUdU5za2VDVnJaNDkzR1h1WEZIcXdObTRRWEZ1cGttK0ZNTGFC?=
 =?utf-8?B?OVNSMjdhY2x0Mzl1M2ZmMUUxZCtxZEFvbS9YZVhlS25teFV1TlQ2RGtJblFS?=
 =?utf-8?B?TVRpUzZTSEhlZnBsb1JpKytsK1M1TmJwbzBvOTZTK3lleFhObHYvWndxWDZm?=
 =?utf-8?B?Smx5Z3ZjenB3RUV2UHBkN3ZHVEZ1U1VXRW02THVlaVUxNjMrNUs5TWpXbERP?=
 =?utf-8?B?Ulh4Umhxa1BEUlhHb0pHbkFIVWpWYUFNQ2tpVmJsV05HTVY0Qzgrdjk1NW1o?=
 =?utf-8?B?OGlHRy95LzVwd3RiR0w5Mk10NEx0MTlCVEMzUVB1SFhRYkxaSDI3NU9iRk04?=
 =?utf-8?B?a00wb2lQYVYrbG1oeWFrQ2hvQ0RhY25oZENXM2JxTThUZzh5cXNDWlZLc2dU?=
 =?utf-8?B?RzE1L2kxY3lMcnIxMTVTa3F0MVhGbElyMWNjRmo0b0ZpY01mQk5BZHdwWndm?=
 =?utf-8?B?c0ZPY25kbmNjVXdwSmNJMjdyZk1ONkg5aGg2MHJGZURWb2dzZGVCSWorbkh2?=
 =?utf-8?B?S3crWFU3WlFjcXdLMzN3N0JhbGVJYXBaMEJpU3pMcVgvdy9QN2oraU9VSU5n?=
 =?utf-8?B?bmxBaEJ4NHdpSGFZa2tqVVA0cVJ6RkMraW1jdTdycVRBVGJub0F4QXprZkJG?=
 =?utf-8?B?K21iR3VlUXJnMUdmOUhzQUl5WHM5VHpkSmNFa3dDNnVCYXNMMnJ1RjFqVVM1?=
 =?utf-8?B?U0k4NjdqVWUyM1ZlbE9OZWl5cFg2bytDSmQydmg5TUw1bTV1TDVTamlnaFVX?=
 =?utf-8?Q?hZIB0IoBM0w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTdyN1JKZ2RFQWxxV0FwZEtKZE9yT0lyYW1MV01sekVQLzBRZkdBR3hidW43?=
 =?utf-8?B?aklxRXhWQ0FXNGUrc2pFZVNlcWxHelFjbG52U1BuQ0ZpaUkxdnZhTlFjVzNC?=
 =?utf-8?B?dDBTdWlrK3l0Mkd2aVE5cHJ4U0FLSnJwVmVMbE5WM3JXSzZBcEU4dkx3RVRn?=
 =?utf-8?B?M0UxS2tiYWU1alRLMTY2N1RyWEdwZDlRakRQSmV4aGtvcWY3QnQwbHFnajBO?=
 =?utf-8?B?L04vTmQ4Ykoza3F3S25LTWcwMXhnRFNsVUZJZlFpYWR0ekxNc29VamlDTExD?=
 =?utf-8?B?WDVYdmpFZWZTak9xd1FKODBHYWFnL0FTUzhTSkNBWWRRQ05zOTVXcDgxRmh4?=
 =?utf-8?B?aXBWMmRidmhENnBXK2s2UHdMd1Q5Nmk4V1JwaWhNdnFXSkZsRnZjUWtIajh6?=
 =?utf-8?B?NUE5RnVQTVk1VVNtQkgzWkl1N1ViNFlpZ3JHNFVMZ3NpdktYV3o2WitiYzR6?=
 =?utf-8?B?WlZhSmY5b1VPMXRPV2Q2ejRtZFJhcnZ6VGtHcGZvRXpXRHFLMEY2emx4WGUw?=
 =?utf-8?B?WUhqaytFL1AxcVJ0WWRTbHlhUVp4UTJPZDFGNmR4RW9EK3d4WVk4VGVYeUJq?=
 =?utf-8?B?TS9QRzVtOVRnSW5TRUwyMzcySWhWNlZJSU5yZDNjODMyakdoZjJXS0ZFcFh2?=
 =?utf-8?B?aEJqRHJkVjQ4SWEyZHY4T2RUczFqcWlMZkRTVWIxUzJXWTZ6Nk9rbC9RVnhT?=
 =?utf-8?B?SXZ1c0RrRDNqbkZsY0d0WW85eFNPYVhOdW5nZGZienlhdk04cE1rYXhFUVFH?=
 =?utf-8?B?aDVadnZVVHpLOVJOZzl0S0UzOFA3eVdVZkR1MGdyY2xmTUQ1bmJJenBWUlM3?=
 =?utf-8?B?eS9jUlhzb25ySW9kYzBldDJGSTNpTjlwNFllUTFwSHc1aUhSSHNhdWU0QU1Y?=
 =?utf-8?B?Q1RkcU91ZjNJcjVtL2tnb3BrelM2NmZaL2RBaTdYb2pWaDlPSGl6TGdxWGxJ?=
 =?utf-8?B?UGN4SlRvR21jeVFSTzZ1Q2hFMmV3VDdDdHZpdkR0RVVGYTV5cFVEaDZVZHM1?=
 =?utf-8?B?bEpVdlJuMTJ3RG56c3dTNTRiYWJOVzBGTDUwSnhaZGJpKzhwdDJIbzdTNnpq?=
 =?utf-8?B?NDlNSURBRDRyK3ZVQm9DYytacDVwV2NjUW1LbjhNMDB4K1BpVzNWMlJTcXhW?=
 =?utf-8?B?cDU2NHRWSzNXOHMyUHNSeUNsNkEvdUZYT3lGYWlLVVYwYVg0MUFUT0xLVXJH?=
 =?utf-8?B?bWlEeGRHKzJKNFNTNUVFc0FJdjdFeG0yeHF6SjhtdEhTMHpwby9yMEJ4ZUxx?=
 =?utf-8?B?WjlHNEU4S0dZSWVuaEdGRU40bzdodytJYk12d3VhZ01ESjBnQStBK0VVQnF0?=
 =?utf-8?B?eTBFaE5yMGUzWEJxVDJDcGVwMDVCYkxHRW9KVXJyUGIySWdhbkJiaUM4TVpu?=
 =?utf-8?B?SEhXTzI2U3dMUk5VMjVJQnJpNXg4dS80UGt2Z2cvUEo3Z2VLWGhMd3J6bVoy?=
 =?utf-8?B?YVJyTHpJV2ZJQk85ZXpHM1BQRnhWRVFkRFdZTkVkOXdyU1FSRWJEb0NFZVJT?=
 =?utf-8?B?a2gxWk9aekowK01yYksvTy9GRnZ5b2ZKUVRrVm5oQmo0aUdqNGNoRHM4cTk3?=
 =?utf-8?B?MFR1KzRFVzNmSXFZMUF3SytSODdNR2pZZ2ZnN2lSM1kxQ0JYR1VReEZyWldG?=
 =?utf-8?B?TDR5MkxxUE4wREtKang4bEt0dTdLaTdoeXE2aENlUGFRRDlLOXdzeWsyZkZk?=
 =?utf-8?B?R1EwYW0xc1N6Z0prQlN5ZTBNM3M4aExJbXYxQkxqUHVXams4anFjNzUxV0Mr?=
 =?utf-8?B?TkZ0NFZ5djNDU0VHUEVBTDVEQzYwS3ZsYk9KSXlPU2hKVWVJYTc4c2hManpW?=
 =?utf-8?B?MDF2c2pyZHVZWkxlWUJTVFlWUjZmeEZtMnoyM0Joa2g2ZXpRZUxvN1RiSFc4?=
 =?utf-8?B?cUxTMTNXSzJYb1NGb1BHK2x0RmxFeTZaMitESUdrb1lkTkp0aGR4T3ZnbDVo?=
 =?utf-8?B?ZFFQcjJHNUpKRkZVNXk4Wk1zWkkza0M3NEFJWnd4SklZMHI1V2dVOU8ycVBq?=
 =?utf-8?B?QzBLODkrRno0R3VzcnpBOFR1WU81ODREcW51QnRkb3lIODRXOUkyRU05b3N6?=
 =?utf-8?B?N2dvNlRNdSt2UUJGOXdwcWlDSXZQWUZ1QTcwTUxrb0txaDd1MHpPaXprQjBv?=
 =?utf-8?Q?pN3tc9MoaPgT7FlF9ZgfRJwlu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b7a168-4e65-415b-f522-08ddd0766ff2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 21:08:46.2833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/BJFyMQpjCxVNOlgIZteRt6DeccRZn7jq5TOEoCHFqfa+GIRWREBIbWMSoIHSKbzxcNtxnnCfAKwE0q1jvuuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFC855560D7
Received-SPF: permerror client-ip=2a01:111:f403:2009::623;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 16, 2025 at 11:54:29AM +0200, Luc Michel wrote:
> Add the Versal Gen 2 Virtual development machine embedding a
> versal2 SoC. This machine follows the same principle than the
> xlnx-versal-virt machine. It creates its own DTB and feeds it to the
> software payload. This way only implemented devices are exposed to the
> guest and the user does not need to provide a DTB.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  docs/system/arm/xlnx-versal-virt.rst | 49 ++++++++++++++++++++++++----
>  hw/arm/xlnx-versal-virt.c            | 37 +++++++++++++++++++--
>  2 files changed, 76 insertions(+), 10 deletions(-)
> 
> diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
> index 5d7fa18592b..af56b275413 100644
> --- a/docs/system/arm/xlnx-versal-virt.rst
> +++ b/docs/system/arm/xlnx-versal-virt.rst
> @@ -1,16 +1,18 @@
> -AMD Versal Virt (``amd-versal-virt``)
> -=====================================
> +AMD Versal Virt (``amd-versal-virt``, ``amd-versal2-virt``)
> +===========================================================
>  
>  AMD Versal is a family of heterogeneous multi-core SoCs
>  (System on Chip) that combine traditional hardened CPUs and I/O
>  peripherals in a Processing System (PS) with runtime programmable
>  FPGA logic (PL) and an Artificial Intelligence Engine (AIE).
>  
> -QEMU implements the Versal Series variant of Versal SoCs, with the
> -``amd-versal-virt`` machine. The alias ``xlnx-versal-virt`` is kept for
> -backward compatibility.
> +QEMU implements two variants of Versal SoCs:
> +
> +- Versal (the ``amd-versal-virt`` machine, the alias ``xlnx-versal-virt`` is
> +  kept for backward compatibility)
> +- Versal Gen 2 (the ``amd-versal2-virt`` machine)
>  
>  More details here:
>  https://www.amd.com/en/products/adaptive-socs-and-fpgas/versal.html
>  
>  The family of Versal SoCs share a single architecture but come in
> @@ -19,10 +21,12 @@ other differences.
>  
>  The AMD Versal Virt board in QEMU is a model of a virtual board
>  (does not exist in reality) with a virtual Versal SoC without I/O
>  limitations. Currently, we support the following cores and devices:
>  
> +Versal
> +""""""
>  Implemented CPU cores:
>  
>  - 2 ACPUs (ARM Cortex-A72) with their GICv3 and ITS
>  - 2 RCPUs (ARM Cortex-R5F) with their GICv2
>  
> @@ -41,20 +45,42 @@ Implemented devices:
>  - 2 CANFDs
>  - USB controller
>  - OSPI controller
>  - TRNG controller
>  
> +Versal Gen 2
> +""""""""""""
> +Implemented CPU cores:
> +
> +- 8 ACPUs (ARM Cortex-A78AE) with their GICv3 and ITS
> +- 10 RCPUs (ARM Cortex-R52) with their GICv3 (one per cluster)
> +
> +Implemented devices:
> +
> +- 2 UARTs (ARM PL011)
> +- An RTC (Versal built-in)
> +- 3 GEMs (Cadence MACB Ethernet MACs)
> +- 8 ADMA (Xilinx zDMA) channels
> +- 2 SD Controllers
> +- OCM (256KB of On Chip Memory)
> +- DDR memory
> +- BBRAM (36 bytes of Battery-backed RAM)
> +- 2 CANFDs
> +- 2 USB controllers
> +- OSPI controller
> +- TRNG controller
> +
>  QEMU does not yet model any other devices, including the PL and the AI Engine.
>  
>  Other differences between the hardware and the QEMU model:
>  
>  - QEMU allows the amount of DDR memory provided to be specified with the
>    ``-m`` argument. If a DTB is provided on the command line then QEMU will
>    edit it to include suitable entries describing the Versal DDR memory ranges.
>  
> -- QEMU provides 8 virtio-mmio virtio transports; these start at
> -  address ``0xa0000000`` and have IRQs from 111 and upwards.
> +- QEMU provides 8 virtio-mmio virtio transports. They use reserved memory
> +  regions and IRQ pins to avoid conflicts with real SoC peripherals.
>  
>  Running
>  """""""
>  If the user provides an Operating System to be loaded, we expect users
>  to use the ``-kernel`` command line option.
> @@ -212,10 +238,15 @@ To use a different index value, N, from default of 0, add:
>  
>    -global driver=xlnx.bbram-ctrl,property=drive-index,value=N
>  
>  eFUSE File Backend
>  """"""""""""""""""
> +
> +.. note::
> +   The eFUSE device is not implemented in the Versal Gen 2 QEMU model
> +   yet.
> +
>  eFUSE can have an optional file backend, which must be a seekable
>  binary file with a size of 3072 bytes or larger. A file with all
>  binary 0s is a 'blank'.
>  
>  To add a file-backend for the eFUSE:
> @@ -269,5 +300,9 @@ To connect CANFD0 and CANFD1 to host machine's CAN interface can0:
>  
>  .. code-block:: bash
>  
>      -object can-bus,id=canbus -machine canbus0=canbus -machine canbus1=canbus
>      -object can-host-socketcan,id=canhost0,if=can0,canbus=canbus
> +
> +.. note::
> +   Versal Gen 2 has 4 CAN controllers. ``canbus0`` to ``canbus3`` can
> +   be specified on the command line.
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 154ed7332c3..8cfb7d0c380 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -1,7 +1,7 @@
>  /*
> - * AMD/Xilinx Versal Virtual board.
> + * AMD/Xilinx Versal family Virtual board.
>   *
>   * Copyright (c) 2018 Xilinx Inc.
>   * Copyright (c) 2025, Advanced Micro Devices, Inc.
>   * Written by Edgar E. Iglesias
>   *
> @@ -27,10 +27,11 @@
>  #define TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE \
>      MACHINE_TYPE_NAME("amd-versal-virt-base")
>  OBJECT_DECLARE_TYPE(VersalVirt, VersalVirtClass, XLNX_VERSAL_VIRT_BASE_MACHINE)
>  
>  #define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("amd-versal-virt")
> +#define TYPE_XLNX_VERSAL2_VIRT_MACHINE MACHINE_TYPE_NAME("amd-versal2-virt")
>  
>  #define XLNX_VERSAL_NUM_OSPI_FLASH 4
>  
>  struct VersalVirt {
>      MachineState parent_obj;
> @@ -55,11 +56,13 @@ struct VersalVirtClass {
>  };
>  
>  static void fdt_create(VersalVirt *s)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(s);
> +    VersalVirtClass *vvc = XLNX_VERSAL_VIRT_BASE_MACHINE_GET_CLASS(s);
>      const char versal_compat[] = "amd-versal-virt\0xlnx-versal-virt";
> +    const char versal2_compat[] = "amd-versal2-virt";
>  
>      s->fdt = create_device_tree(&s->fdt_size);
>      if (!s->fdt) {
>          error_report("create_device_tree() failed");
>          exit(1);
> @@ -69,12 +72,22 @@ static void fdt_create(VersalVirt *s)
>      qemu_fdt_add_subnode(s->fdt, "/chosen");
>      qemu_fdt_add_subnode(s->fdt, "/aliases");
>  
>      /* Header */
>      qemu_fdt_setprop_string(s->fdt, "/", "model", mc->desc);
> -    qemu_fdt_setprop(s->fdt, "/", "compatible", versal_compat,
> -                     sizeof(versal_compat));
> +
> +    switch (vvc->version) {
> +    case VERSAL_VER_VERSAL:
> +        qemu_fdt_setprop(s->fdt, "/", "compatible", versal_compat,
> +                         sizeof(versal_compat));
> +        break;
> +
> +    case VERSAL_VER_VERSAL2:
> +        qemu_fdt_setprop(s->fdt, "/", "compatible", versal2_compat,
> +                         sizeof(versal2_compat));
> +        break;
> +    }
>  }
>  
>  static void fdt_nop_memory_nodes(void *fdt, Error **errp)
>  {
>      Error *err = NULL;
> @@ -362,10 +375,21 @@ static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
>      vvc->version = VERSAL_VER_VERSAL;
>  
>      versal_virt_machine_class_init_common(oc);
>  }
>  
> +static void versal2_virt_machine_class_init(ObjectClass *oc, const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    VersalVirtClass *vvc = XLNX_VERSAL_VIRT_BASE_MACHINE_CLASS(oc);
> +
> +    mc->desc = "AMD Versal Gen 2 Virtual development board";
> +    vvc->version = VERSAL_VER_VERSAL2;
> +
> +    versal_virt_machine_class_init_common(oc);
> +}
> +
>  static const TypeInfo versal_virt_base_machine_init_typeinfo = {
>      .name       = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
>      .parent     = TYPE_MACHINE,
>      .class_size = sizeof(VersalVirtClass),
>      .instance_init = versal_virt_machine_instance_init,
> @@ -378,12 +402,19 @@ static const TypeInfo versal_virt_machine_init_typeinfo = {
>      .name       = TYPE_XLNX_VERSAL_VIRT_MACHINE,
>      .parent     = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
>      .class_init = versal_virt_machine_class_init,
>  };
>  
> +static const TypeInfo versal2_virt_machine_init_typeinfo = {
> +    .name       = TYPE_XLNX_VERSAL2_VIRT_MACHINE,
> +    .parent     = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
> +    .class_init = versal2_virt_machine_class_init,
> +};
> +
>  static void versal_virt_machine_init_register_types(void)
>  {
>      type_register_static(&versal_virt_base_machine_init_typeinfo);
>      type_register_static(&versal_virt_machine_init_typeinfo);
> +    type_register_static(&versal2_virt_machine_init_typeinfo);
>  }
>  
>  type_init(versal_virt_machine_init_register_types)
> -- 
> 2.50.0
> 

