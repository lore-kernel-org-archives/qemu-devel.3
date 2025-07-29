Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA0FC87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 21:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugsKd-0004jD-Oz; Tue, 29 Jul 2025 17:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugqLT-0006lH-KI; Tue, 29 Jul 2025 15:50:46 -0400
Received: from mail-bn7nam10on2060c.outbound.protection.outlook.com
 ([2a01:111:f403:2009::60c]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugqLR-0006BP-Gy; Tue, 29 Jul 2025 15:50:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5+ZkaJO3ycm2AFrYsPsQW9I5AXzbBfPwPw6PJ7lqv5ib2LFFzP2STxW2P5Rsy5HlRx2K7J2523n/b+Wr4fSrTp920NO2FqC9jbgj/ErWeqtVq8W/t8V+eRryap0Fm5e7inzxMmsaMaHRxLQmP7lHNaQ8xzUBlokkyKA+UCy6XoNTpSbt75QAdH8yj+3gMar1jqm2GzivaB8Y5qRQ61g21y7i0lpFJXaof9NmLTVOapiFQeu0uXPZrNuGnkvyKBIHlugHzo2i4YJYqsgiFgB9HzRQfvJXGtX7bDVyjhdhgrdpd4r8y6tZtMZALHnwtXG29l7iPv/+MKOUVuspyx6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKyHKLKvCDb2GWLYy15yR6i8Z1QEepek/E1mHaof0q4=;
 b=ZQjL0xJrf+pTkN8azofKfZ13YNY/SMq50Ou44bIIPlY4Yapu3xTzKLcmnXbD4/twVFqbJA5inizxbCsF+RPIPbJep248lfnHdlzrTFI3RJXovPFpOR5Nkj2f4p39+defcMeMaNcesJBck9clDzryVvYKGaWMJdB8Ss5N/S/TIt8+BhITTMU79s37M2K1SD6WPSr1rT5DnlYuE1wdHdCz99z9KIGpVmAj0Vgiu/6QPbYaxa9E4swjQTLH9EjD67CkyB56OZWwW2DVurrvqJnF0qyubkyrLBmn+bEbJSgZyS+qlUGKq8FkY80kBxxJi6A1KQb3QxDXm1slLvoyQHjtIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKyHKLKvCDb2GWLYy15yR6i8Z1QEepek/E1mHaof0q4=;
 b=F5boJ3AaiZqtBCVeVpyMe4doF4r5gvMoPAh3Ahb2VMEpU6zdaOjFSNdfgGMkp9VWkU5RGiwQpggq3yvtwRpIRZdwwCs0NUrzcoWFxs2R2qasLrJ/DlEo3kHviSXTUZZWJeTwlNvrWlKfWODgEzDjRpjJeIcQGTh97D2mOzIeLyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by MN6PR12MB8589.namprd12.prod.outlook.com (2603:10b6:208:47d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 19:50:37 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 19:50:36 +0000
Date: Tue, 29 Jul 2025 21:50:30 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 16/48] hw/arm/xlnx-versal: trng: refactor creation
Message-ID: <aIkmBrQqXqRbaUJe@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-17-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-17-luc.michel@amd.com>
X-ClientProxiedBy: LO2P265CA0391.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::19) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|MN6PR12MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: 026b8590-7b3b-467a-da5b-08ddced93016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUZtWm5yTGhxMUUyWTJqWjBFMkR1NE9lVXF1aHh4VVdwNWV4ZGs5K0p1WGJX?=
 =?utf-8?B?YTRHTkc1Ny9LaFFGaXRHSTM4SzRxNzEwNjhqNTlGaUFuRE9Nb3JtdDA3cktp?=
 =?utf-8?B?VFV5R3ZKR2RkZ3ZoMWNUemU1WkRETW01NksydU9HN3Z3MW91Uk5BZ2k5cUth?=
 =?utf-8?B?VTR4ZEVXNXNSWW0yWFJuUStFb0pLNDI2L2Q2bmhYb0dKcmdzbm81b1krNE1I?=
 =?utf-8?B?Zk1qbGtEVW4wNzc2U0R2L3BNZ0JSbmJmZ01QMUM0alRuY0NHNStwNkJWZlVi?=
 =?utf-8?B?d1B0UG5JbzRnaFEwWlNpWjZFdkhwVzBOR2NWZmU0MzR6N3J3S1RNNDRFQysw?=
 =?utf-8?B?K21idzEyZzU1UUtWQTNndDE3cUo1Si9zallINDR0YmlFQnVreUFoaTJOZURo?=
 =?utf-8?B?LzhKS1NWWXVrNEFLYXF0TDZ5NG9uREtZNkZUTlFNeGs4NWxlNWtteTFMdHdO?=
 =?utf-8?B?aEdhUWJrM1hYVUtvdEllRXFlWmZvQ1RqVW4xQ3pZK2ptZDMzZHNWcnpYLzgr?=
 =?utf-8?B?d1Raa0lXcmJVc2E4MDNLZjQzSGkxM1FmN2JyQUV5WE5CWk53UTNUa25icHpx?=
 =?utf-8?B?MjhMYkg5ZEZ3UUY0bWFZdHQzRmc1K0xhTEVQK1FEWExteXFGWk96ak1keHpq?=
 =?utf-8?B?bHNRODVUUzNOTXBzcld2Y2syWHp4NHB4Q2EzRXQrbncwaDllcVlEUjVpbzVB?=
 =?utf-8?B?RkVETzJkK0k5cHFqNk5NUzRWZDloUFB4ckNKb2thVWVObEphQUpOZTZ1ZUd3?=
 =?utf-8?B?LzU3SmQyTHpBcnNtN1lRODZOejAyZGNXNXRLWnVnTmhRTXNEa0RTMklsekRS?=
 =?utf-8?B?cmlPWmhOb2c0Tm1vR2hVNGRXdnkraGJ0ang1dTBNTXlQZy92RkFTRFVLN3VZ?=
 =?utf-8?B?WmVkUXpUWE5QK2Q5MFZoVEY4NkJQNGJXZ2NmdkNiMHpHV3Q5SFk5b2h1MHRM?=
 =?utf-8?B?OXdzcmRuNXZ4V0htQlZyalpRSjBGa2QwRy9xRFBuNTMwTEdqaUxKSkF0bVMw?=
 =?utf-8?B?S3Z0ckZYOSsxdkRScjBtQWVybjFuT0VEczFmNElWbXpwckR0NVBUM0hIWjVv?=
 =?utf-8?B?K2o5QWhYM2s2YmdNRTVyd0dGZjd0UE43OHB3bWIxbWRHbmR4dWVBaVJOTDhI?=
 =?utf-8?B?V2dtM3RZVURTOTFpWGhzTEZtTHoxNDY1a1EreEdzUVlmdGsvdE9kRlp1emdQ?=
 =?utf-8?B?aXpPWDNUR3p5RVlnSEJ1NWx2YWhyL0FhOTA4TkNBZVlrRjdESks1Wk1uSjMy?=
 =?utf-8?B?NmxIeThlZFE0LzdzRE9tamtSS0VVTFk1cUQvNFRPWjQ4ZktuM1hMdWhLZS91?=
 =?utf-8?B?ZDhrZnJqNUJSSjVVOGFLYkVyQVpKSVVDNko2TFhHTloxTS9sSDRKSHZWREw2?=
 =?utf-8?B?dnEwU0VYMUQrMzNpQ0ovdHJEQVp6WlNIS09NQ3U2bXVzcWNhMEowMUJNTHJP?=
 =?utf-8?B?NkppL25xRXZYR2pialZ5aGhyVnk2emdEWTBiaElWWVpUMW40eGgydlVhOHZT?=
 =?utf-8?B?Q1B6WU91a09iLzEyQm1aREQ3NXlqWHpKVXIyMWNOQ21hTTB5MFJVendJdmNh?=
 =?utf-8?B?bUVSUHFsZkhBaGpGK1JNWEdBc3Y3Rjl0QUZCRW85cXhWRjd3L3ZiYVIvYzdK?=
 =?utf-8?B?Q0xBMmMvQVYvWDR4dXhRUDlUbTJjRjI2ekNuSzI0Nk9OZDVReElkalNRUWxl?=
 =?utf-8?B?bDlZb2RteVYzN216OFBWZ2w0b3l6UlJTSzhKTkpURExnQW5GZGg4S2NYOUts?=
 =?utf-8?B?M0tDWmtoTjIvVW9VWXYzWE5sbUpwNFpsYmlWQUEzcFZlbE1OUFZzQUdDeXhQ?=
 =?utf-8?B?ZHFmc0xiSk1JTnYzOVZQS0d3aE00OHg3MHllczNnUTRPZ0w5SG50QzV6cHRZ?=
 =?utf-8?B?WUFxZ1o2SDFRYi9SR3I4SldocjRBajhFM2N3T0VKckZBS2RlbXJzazFveGhn?=
 =?utf-8?Q?CX4tUI8dmsk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWlhak91REFVMjdDU055dkNyVmg3eGxTYi9vM3RoTktwT3p0UzB1MEQ2TkFu?=
 =?utf-8?B?VjBybEdaTk81NXlHMCtDWi9tM2F3U3NVcVdhTXl0dlV0dUdRZ3NON1BDVGRQ?=
 =?utf-8?B?Y3p2S1pNU0R5NmNQWXZWQUFmck40UDV3YmRMeEZkSTJENXo2SURBc3dPMnlE?=
 =?utf-8?B?MU5WNDVGK2FkNDRwcWVBUzVDRVdpUXRMVlFueE8zYk9rb0xiQ2Ntd2Z2cUdu?=
 =?utf-8?B?NTMyOC8wQzEySGVSQTcwTW1TNGxRM3VxVHFLVDh3dlV6UFBOTEdzR0V1OEd0?=
 =?utf-8?B?M1RoSlhsV3ZDcDUrcEFtUEhVbVFmek4xb0FIZ3pua3RiWFFVYkJMVlVlTkFy?=
 =?utf-8?B?SDBGNUlvbU96TUNoWmpuTHdTZU5KakMzUkdPWHU2V015aDg5SVZpcVdqRVBx?=
 =?utf-8?B?OThYMjN6K0xtbWhHUGhoQ3A1dzk0NUZuRkhhSjVpSGg0Tk1lRVIwQVNiZHh0?=
 =?utf-8?B?NzU0RnhDR3ArbEdpL0VjZ0JzUGk1QzNMRDV2alNIR3dxd0l1aTNJNnlqNThM?=
 =?utf-8?B?TFJPZ1FnZ2lNdGVNWEI5ajBWYmh2N3VXR0xCNFJwTDBFS2JlcmJONndlMTd5?=
 =?utf-8?B?bEtnR1pPM3VlM215bmlGbTNnQXZEbHR1dldGYzVKSGFVZ2Q0YW9DU2djeG9P?=
 =?utf-8?B?elBYcExrdnZjU2FsTnZueGhIcnlGb1FrV0doMnhCV084VUd2d1dGUEpNdGNE?=
 =?utf-8?B?bFdrOVppQkhXay9HTEZ0c1RQR1lmbmlOcE9Sa2c4dFY3UGRFbnRnU25EY09K?=
 =?utf-8?B?ZVBlTlJVbTVMaGxHSjRzQ250T2l6QzBtenlVZWZHbmtqUmRFcUxaSUxreVVX?=
 =?utf-8?B?bzVMVEVlVHIzcy95alBpNlZlSHZQSS92MTl5dUZuTmp2SEQ5R1QwZUZadG5K?=
 =?utf-8?B?ZmNUTW85a0FYQ3dVdElPNHA2ajA4eWQ3VFczQ0pLcWQwbmd1WVZNTWlNS1M5?=
 =?utf-8?B?ZW9jdmV5RzI1c0VFcFRaL0dVbW1JL2JUanhDS2RKT0wvSjRtQ08vdFpML2hm?=
 =?utf-8?B?YUdFWjdyNWlobW81M0JiMHZjaVZUZUUyZ0RYTHQveXZOU1lnUVd2dkFJcjd4?=
 =?utf-8?B?STl2Y3RESUxPQzluVzJidFhvZHlRbStubGsvVFdvM3g0RWI3RDlRZ243WFVt?=
 =?utf-8?B?NXRzTEMwZjYwb0VMbGpiVUp5NjFNSVZmYTVVMGRVYlpENzlHYWZHRURvNENI?=
 =?utf-8?B?SnZhOGwxZ0dYRjljVGpBbmFyNiswQzRjM09CZU8waUdzR1g2aWhxQnhESW1l?=
 =?utf-8?B?ZUlsYkpvUlFjRThQRVZ2cml1TVl3MFpiMjZ5VXQyWkpHbXpFK2h0VlJobFFj?=
 =?utf-8?B?ajlheXU5cUg5SERTTEdWbnJLR3l4R0xMbit5L2lPUDdkZ1hZVFNNbFd0b1BJ?=
 =?utf-8?B?TzZtSE1wdlI2dkZrMlk4Z3VTVHJXVE13VnVqU2N6OEV2QlJ6UWMvNkpsbm1Z?=
 =?utf-8?B?Q1RoZkpJSkRVOFptL29GY0psUXgzOU03SGI3ODMwTmh5ZUVXQWhnL1VsSTJn?=
 =?utf-8?B?bEpBYkFCbFUvUGJoUlU5ZDh5a0R5cDlxaGJSZWNPMDVEV3crdWx3TEVjUDZz?=
 =?utf-8?B?ZkhKMXpLbysxMmZNVENZWEFORnJPOVNBYUk3VXlSWWNtKzRBTDY2czhXQUp2?=
 =?utf-8?B?cE9FeEhxekhVTmNXRzB6ZnJ6MGxYb3hURG51NFFONHdyMkNzRHFuaTZlQUFv?=
 =?utf-8?B?NXp0RUdpWng4WDg1aDJXazFISjYrNXRrZk9uVEEzRmE5OXlaOHpldTkveDhH?=
 =?utf-8?B?ZzlPcW8zVnAxcld2UWZwTDNBeEFrUkxSS1AvMG14M1ZzQlI1M3N3b2t0T1Q5?=
 =?utf-8?B?eGxYSkdDMXhDbXZGcHVGWjU5UW9CVEE2aGRzNEJIM1lBc1pNZm9iMW9xbncy?=
 =?utf-8?B?WklBblBva1daZ1M2eDcxK2F2ZFdGdHpSVHE4a1kwR01rcVVLeXN1TGFGNXlC?=
 =?utf-8?B?ZGd3anowdmlJcURwQ0prRlU1RDZWWEpwclQ0aGtUbU1hWDNtaGVaVnFwUE1Z?=
 =?utf-8?B?TXRBSnQwUWdOZU9reXRFR0R3dUhOVmxycnRsT2grRDFzcm1zMVFyQkFYbGdH?=
 =?utf-8?B?ODlidFBIQTg4WXNOMHZtNksxSlYvZWRXZGhLbnc3a1BGZXVKaVlHc0s0cjJh?=
 =?utf-8?Q?Pwi/Bkc5yrm8h+NDwDZEO8A7r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026b8590-7b3b-467a-da5b-08ddced93016
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 19:50:36.8339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNRw6xmqCj8ciqheKJ4xu367y4tTtWxbcp57G9oVqet8LsuAfd6KzZWRV6CxrndU2a//eV4NfrHzzjqf6btYTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8589
Received-SPF: permerror client-ip=2a01:111:f403:2009::60c;
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

On Wed, Jul 16, 2025 at 11:53:58AM +0200, Luc Michel wrote:
> Refactor the TRNG device creation using the VersalMap structure.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h |  2 --
>  hw/arm/xlnx-versal.c         | 18 ++++++++++--------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 9adce02f8a9..bba96201d37 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -18,11 +18,10 @@
>  #include "hw/or-irq.h"
>  #include "hw/intc/arm_gicv3.h"
>  #include "hw/rtc/xlnx-zynqmp-rtc.h"
>  #include "qom/object.h"
>  #include "hw/misc/xlnx-versal-crl.h"
> -#include "hw/misc/xlnx-versal-trng.h"
>  #include "net/can_emu.h"
>  #include "hw/misc/xlnx-versal-cfu.h"
>  #include "hw/misc/xlnx-versal-cframe-reg.h"
>  #include "target/arm/cpu.h"
>  #include "hw/arm/xlnx-versal-version.h"
> @@ -81,11 +80,10 @@ struct Versal {
>      } lpd;
>  
>      /* The Platform Management Controller subsystem.  */
>      struct {
>          XlnxZynqMPRTC rtc;
> -        XlnxVersalTRng trng;
>          XlnxVersalCFUAPB cfu_apb;
>          XlnxVersalCFUFDRO cfu_fdro;
>          XlnxVersalCFUSFR cfu_sfr;
>          XlnxVersalCFrameReg cframe[XLNX_VERSAL_NR_CFRAME];
>          XlnxVersalCFrameBcastReg cframe_bcast;
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 615eea54372..45d9fc1e282 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -35,10 +35,11 @@
>  #include "hw/usb/xlnx-usb-subsystem.h"
>  #include "hw/nvram/xlnx-versal-efuse.h"
>  #include "hw/ssi/xlnx-versal-ospi.h"
>  #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
>  #include "hw/nvram/xlnx-bbram.h"
> +#include "hw/misc/xlnx-versal-trng.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -119,10 +120,11 @@ typedef struct VersalMap {
>          int irq;
>      } ospi;
>  
>      VersalSimplePeriphMap pmc_iou_slcr;
>      VersalSimplePeriphMap bbram;
> +    VersalSimplePeriphMap trng;
>  } VersalMap;
>  
>  static const VersalMap VERSAL_MAP = {
>      .uart[0] = { 0xff000000, 18 },
>      .uart[1] = { 0xff010000, 19 },
> @@ -162,10 +164,11 @@ static const VersalMap VERSAL_MAP = {
>          .irq = 124,
>      },
>  
>      .pmc_iou_slcr = { 0xf1060000, OR_IRQ(121, 0) },
>      .bbram = { 0xf11f0000, OR_IRQ(121, 1) },
> +    .trng = { 0xf1230000, 141 },
>  };
>  
>  static const VersalMap *VERSION_TO_MAP[] = {
>      [VERSAL_VER_VERSAL] = &VERSAL_MAP,
>  };
> @@ -771,23 +774,22 @@ static void versal_create_rtc(Versal *s, qemu_irq *pic)
>       */
>      sysbus_connect_irq(sbd, 1,
>                         qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate), 0));
>  }
>  
> -static void versal_create_trng(Versal *s, qemu_irq *pic)
> +static void versal_create_trng(Versal *s, const VersalSimplePeriphMap *map)
>  {
>      SysBusDevice *sbd;
>      MemoryRegion *mr;
>  
> -    object_initialize_child(OBJECT(s), "trng", &s->pmc.trng,
> -                            TYPE_XLNX_VERSAL_TRNG);
> -    sbd = SYS_BUS_DEVICE(&s->pmc.trng);
> -    sysbus_realize(sbd, &error_fatal);
> +    sbd = SYS_BUS_DEVICE(qdev_new(TYPE_XLNX_VERSAL_TRNG));
> +    object_property_add_child(OBJECT(s), "trng", OBJECT(sbd));
> +    sysbus_realize_and_unref(sbd, &error_abort);
>  
>      mr = sysbus_mmio_get_region(sbd, 0);
> -    memory_region_add_subregion(&s->mr_ps, MM_PMC_TRNG, mr);
> -    sysbus_connect_irq(sbd, 0, pic[VERSAL_TRNG_IRQ]);
> +    memory_region_add_subregion(&s->mr_ps, map->addr, mr);
> +    versal_sysbus_connect_irq(s, sbd, 0, map->irq);
>  }
>  
>  static void versal_create_xrams(Versal *s, const struct VersalXramMap *map)
>  {
>      SysBusDevice *sbd;
> @@ -1327,14 +1329,14 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      qdev_connect_gpio_out_named(slcr, "ospi-mux-sel", 0,
>                                  qdev_get_gpio_in_named(ospi,
>                                                         "ospi-mux-sel", 0));
>  
>      versal_create_bbram(s, &map->bbram);
> +    versal_create_trng(s, &map->trng);
>  
>      versal_create_pmc_apb_irq_orgate(s, pic);
>      versal_create_rtc(s, pic);
> -    versal_create_trng(s, pic);
>      versal_create_crl(s, pic);
>      versal_create_cfu(s, pic);
>      versal_map_ddr(s);
>      versal_unimp(s);
>  
> -- 
> 2.50.0
> 

