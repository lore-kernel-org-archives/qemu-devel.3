Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F4ED5E144
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 12:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVUBM-0001mS-BN; Tue, 16 Dec 2025 07:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vVUBK-0001m7-UX
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 07:29:34 -0500
Received: from
 mail-switzerlandnorthazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c213::] helo=ZRAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vVUBI-0002Sg-V5
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 07:29:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQBmgov5g5GTGTpRXuMG/kGoDu72phf4IBToLfoD8txv4oZ5uj9wIcaEaKrXYD4C/q0aRASpYIPYPob+FGkC+IXMvWWBz1oVBN7Zify0ZAYpiOnpJKS4cCAVlo4vO10gP5YyMJ9jttZMO7osbuRi0epJuQEvTRJPd+LxbVKXTwAtTcPlVjYhI267rK2GiPrWHas1WD8SR4p7TXe9KvEerIiOuCOV5Tv2N1Kv3aqZd0DdP3Jdugemj4Yd9VMo3TcUgpwT6iFiQ7q6hms5W/kSpczVZe2AcVDOied4BXQ/ElSGpwOT1P//yug3kYiUYLzOOBrbEyxgDSJwlXz9JtXX+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yvvcPIm5hhJTV0dl/N4BXU2x3mfMI6jXqELZ4Q/u9M=;
 b=JBQYCOSeN24ZjmHJRLnKS4Sg6vmP9A484I489DDW7GYhM2WLZgAFBrT7kTVtLgb6Pq295S7Ps4kH+UAnRSlpVqaYzpL5jT7CBiEb/GUicqbgYaK/k9itPznieZtxge0SEIEvtdFxz6zt1IjW/WSAlr2nzxZGpTkTjWC/U+0CJl0c/JCqKznDIG5yvI4OaaEX5uqb9XukAQGA6BZ3MHXOSkTh7VFFLmrd1MSabJA8LBbKu/jEoZWmUwIvGvkyJCtnoB7gEwcdvTIMJqjlGK8e4hT7YweG3/+SZpyABH/pI224WoGqZkDcBU35yzfLYNFuMfGjOJKH2Nmon8cXjCbqYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yvvcPIm5hhJTV0dl/N4BXU2x3mfMI6jXqELZ4Q/u9M=;
 b=iCg3bWCjCtCZrKF3mcBb0V9x7jJNYnyJa8JAiP3RvTN/T3AAi4JorW5g+eZ8mdBdSqHXgczB13Gb70ifGcyryGQVRdshukYO/ShNrwHrXVYE1DiipUfgmHkU9/7QejOuxCcHUAVGqd+DidF21WsGbIoV2jl7Gi8SrageBx+s9SE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1305.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 12:29:28 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1%2]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 12:29:28 +0000
Message-ID: <01a56a53-ef95-4c63-8f4d-21458bbc3668@epfl.ch>
Date: Tue, 16 Dec 2025 13:28:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] plugins: Add PC diversion API function
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch>
 <b461feb8-4ad5-481d-a497-dcb10b12ee79@epfl.ch>
 <87cy4jubc9.fsf@draig.linaro.org>
 <341e0334-7bc3-4186-94c7-fba1c92cfc9d@epfl.ch>
Content-Language: en-US
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <341e0334-7bc3-4186-94c7-fba1c92cfc9d@epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0022.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::9) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1305:EE_
X-MS-Office365-Filtering-Correlation-Id: 8188057b-3492-4c8c-9bc4-08de3c9ec193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d01JVytpNEhFL09BczkvN0RzUHVkK29xOVc1bTZRaEFmSS9XYUpvZi9vK2lN?=
 =?utf-8?B?VnlFYzFOK3BrRCsvYXRza2QySmJaUXpaa1pCNXhyaWROdFN1Y1FvTXZNb3Qz?=
 =?utf-8?B?cDg5c2JIMXROdFR4VUg4STQxTnVYZUFIOW80VVZ6SFdFWUJNalZoS29pcTMy?=
 =?utf-8?B?WVdERitvZVBlbWtkQTNldFc1ZlZFVEpkQzVrQ0hLVVptMnNLRnJuaXVVdXA1?=
 =?utf-8?B?bmhvZGMzT01LRHBJSjhtMkxPVUozZk1iYzdpQTVoK3RxU25nVllVOVJta2F1?=
 =?utf-8?B?clJYbVUxT0NvWnVSWVhqNmJTbXZaSlRCTHRvN3BJaGhRaTJqNVVPRlhNZ2Vw?=
 =?utf-8?B?eWNWZlhnUVZQS2lkcTFQZHRhaDB3L0FoNG92VHlHQ1ZmWm9NdkNVSVdSNVRC?=
 =?utf-8?B?TnZ1VlRDTjdDR2pkRUtxRG9rVmRsbW04ZzlMaWFweVBibm9iU1RsSk5QVGlr?=
 =?utf-8?B?cWgrQ3RyOFpRekY3cTFBc0w2YlU0L09Ec0Z6djlqV3hpeHZicVlRZmxFUFlJ?=
 =?utf-8?B?RFVPVDIydDF5aytVd3B5N1Btdks1OGdLSzArSzRHRFNET2YxM1dZbHNkV01D?=
 =?utf-8?B?ek1FbW4rN0t6MHlibWNUL0t6OTV0VTZ0Y1pGVkFQYi9KMGE5ZE1pT2h2RDVz?=
 =?utf-8?B?Rk5VU2FXVmMyczJtSzVPc3FXdlFUV2U1WmFxd3VtTmhoZDB5L3JncURDL2do?=
 =?utf-8?B?c2FZbWxCNmFYRDJWY3RwMVFzUlFYNUJ6bUlHL0orN0src3drNTluUXBUeDFt?=
 =?utf-8?B?ZFo5YnFLQ0FVY1A4VG5UdXlBTS9JYWR5UGhuZm5VclhPU0RCQTJXUmxPU0dw?=
 =?utf-8?B?aER6QnBSa0YvaHRTOXViUWZUSlJhblg5RVhHZHdVWExjKzArMjdWZnVydi9j?=
 =?utf-8?B?bVlYa0tUeEgydSs4MC9UemR6Ny9ER2xRNW4vR0x0ZkltZGFwbFIzb0o3c3o0?=
 =?utf-8?B?VkFxQU1mSE9MVTYrc0xGYXNXeFh1MUg0TU40WVNELytDRFd6TndOMmFDa3Bp?=
 =?utf-8?B?VVNqWUtVMTdjT0k3eUlKZlQ2T3JCcForbEVXblhXZ29kNXdwY2p6ZjlPeDVz?=
 =?utf-8?B?bHBrUlR2Zk1IK0gwK2llL3d1bFZ5Rm5WMXVHVHh3eEdPSzkyeTZ1Q1orUjVt?=
 =?utf-8?B?T0dKN3B4UXBTSFdyVDRMZnVmYytwazBySG42aXZLQlpOUk50VGc4UHY5dGly?=
 =?utf-8?B?cUZyU2NhOHpHVkoxQy9Ha1BicHBTTmlKYzN2VEJpNWNSZ1MzMW16ZktvRUV1?=
 =?utf-8?B?SSsrVEtzYzBqVnJjRWN3cjhXbFpuakJ6U1lXYWpUc2NBNWY4bFB2Ujk2aGY2?=
 =?utf-8?B?a3ZmVDZjNU5lMVRwT1Z0WTVmVm4zTldqbnBNOWtnY1lMSi9FQkRmNmdoZjR4?=
 =?utf-8?B?K0hLZUJyT1E1U1V0eUZ3UGwrSG0yb2k1aC9MTHVJL3I3M3U0Nk9GL2RBWnRV?=
 =?utf-8?B?alJzQm9PYis1ejIyQytEckNYc3BGdkp0MjhiN2Q3SFFIQ2RodTBPUE1iZ1J1?=
 =?utf-8?B?cW52QWh3TzltSWZHOCswRjFaa2N5cllwbmNETW1yRjIzNGJWZDRhUTNJV2tt?=
 =?utf-8?B?VHJoVnVsVGhVL1N2cjJXYjdNTzNwRmxaRWZVNjc3WDRyNFNxWTFuMTNwbWxL?=
 =?utf-8?B?VlJId3RrMTJ1NVlTZXgyZTRTR2kxdC9JM1VFQmMxTi9LY2dUTGlFYTlUeWIr?=
 =?utf-8?B?NVRUNWJNVnFDNU1FbmpkaTRXSi9ycU5kQ1Jxb2VDaTltUHo2NklZWnJqT1hJ?=
 =?utf-8?B?OTlGcXhLK2JpTGltb3VXNERrRWlCL2YzS092RUc2dmRVOVdkcUs0ajRtaGR6?=
 =?utf-8?B?aUd6bVQwMlNGRG9IQy8rLzZQam12K0tSL1F3dFZ0a3RmNllYMFA4UTBlNENL?=
 =?utf-8?B?N2o0b0F4WktEc0NxNGNxUnIxam1JU084ZDkvMjRQOEhueTVwV1Qya3E0dGtR?=
 =?utf-8?Q?X0AOaOH9xDf3h9M8HktvD3L3LRsN8lN6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(19092799006)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlBDMDFyQ0xpdTgyT3VHVGR3VGJ0dVk3TnFkd3p2cTdCVFhWWHBVdnhUdkg4?=
 =?utf-8?B?a3hyc2h4cmdBQ2orSkRIU050eVVhNlNheHJRaGtQalpEbkE3Zm5YQVZWaFdr?=
 =?utf-8?B?Mk15cXpWdFRZVzR3OVNpeFRuTmsvWmJrT3VKdkJkUFlXTjJFY0lncXNHZWt6?=
 =?utf-8?B?T2tsRjlIZTdDOFNwc2ltdGI2dVpRd3l2TmlYQktBVndRUERzTWpTVEJBcFpI?=
 =?utf-8?B?TEU4UDB2dGlOdzJKMkhaR3luQTRDUEIwOHlHOTBka2UvdjE4c2RMR3pnMUhJ?=
 =?utf-8?B?Y0dhSEhkdkNibGZkZlBZcUg4U0g5cmlyS05OTHlVYTNtTUVubWp1VWhlOUhY?=
 =?utf-8?B?bkF1a3o4VkRUaUw5UHF6R3JnMm9hVVBDUUY2elhwYmJLUi9aVHovSG14RXMy?=
 =?utf-8?B?WHZ0V1RBcE82R2toMkdJOHUzYWpDNlhncFI1MzNtKzdnNlFQbnY3cGZMTUln?=
 =?utf-8?B?MUFPS0ZaYmtsblIrbkM1ekdzUVFmUWs0bjVJSXdFeXI4Qjhpell4SmxpN0FO?=
 =?utf-8?B?N0lySXNZYUtMR0Rwa1ZLVWRmb1poMXlNVFFNcS9SQXM5QzFDNEhCSFBZekZJ?=
 =?utf-8?B?VzdsdFE3WjZuRVVnTlhJS1UwSk0vNVdCRFh1dG42REp2UlE5SE9ZVitGV2VU?=
 =?utf-8?B?MCthblE4NTV5SW5laXhlNTZGVGJ6QUZFekxUanFKZ1RqZi93Ni9LaHJQa2Rk?=
 =?utf-8?B?OEI5L2svcG5qb0JkL0w2eFAzeVdRT2ZxcWVPZzlUcjJOeWtJL1lZOGtKL1Mx?=
 =?utf-8?B?WVphR09FT2NJYlRNbGVMclAyb2NYajhvODc3L2FTb3FncS9wWldvdXlUeGRY?=
 =?utf-8?B?VUo0Unk2L092bk55dlI1eDRiTTdOdC9xU3dnQkpPVmJFU2lvUmhwa1ZUWnAv?=
 =?utf-8?B?ZkdEczJTaE5ZSitVemlNdHlLbzY5L3RpTWowTGlZQW9welVxZ3V5VXlqSXIv?=
 =?utf-8?B?OTkzb2NDbUVxMzBMM0dYcjJ5eFBFRkZQYk5KTkh3OGlZWWVZcmlYV2pHK0RL?=
 =?utf-8?B?Y2pWWVJXWU03M2ZiRkNBeW0xN3NOV3dOb0VTU0p3WXF4NUNCNFVreDc2U0Iy?=
 =?utf-8?B?dGEyVjJ6eTZaT0VqVU1CNVRCSkkxL1lzZWszUCtPVmZwQzZkcXNPdXhDNi9U?=
 =?utf-8?B?V0xmY0Q5MURTOTlIMGNIelhVVE53VlR1WUdiY29EZWRBUVMxc1FpTGI3b1Va?=
 =?utf-8?B?MWlMaEVIelEvbnkrOXU5ellGYmdvYzZteXJCSzJ6RDl2M1FBb3NMN2lBZlcv?=
 =?utf-8?B?eWlrN2xVUTZ6Y2NzbjVYUXB1cUdXVUd1SmZCK1JMMWx5RGFLL1ZtUzN6Z0lo?=
 =?utf-8?B?SWZwbHpqN0dsV0hWRU1wanRHS3d6R0RsNGZseTN3QW9Rand4YmtyZndtblkw?=
 =?utf-8?B?N0lsQWVoR0hkVG9PYkJ1QU4vSWxjTG4xM29VbFNCb2tHZG1BeFJGejFwZUxu?=
 =?utf-8?B?NlpoV2NRMnFQTXN1ZzZOQmZBUzFaeCtYMDQ2VitmU3pZV28zam9GNkRvell2?=
 =?utf-8?B?RkpYc0dSSWtLWi92U0lWc0FmOUdJZEwvSTUxZDZid1p5dGlzVFhGaVlXem1i?=
 =?utf-8?B?aXlRSjRoWWNjalFkZGxjSDVqQ1NMUmZHdnJLU2dBdFFFazFUQlN3TU5FQXlq?=
 =?utf-8?B?WkwwMGlFTk5UTkJXRmdnV3BWZ0wzM1NCYXpmdjJ3VW5IWE1NbGJKVS9UQVFz?=
 =?utf-8?B?aldHQk9DU01MVlRweUxxN2R0VDVhcE1TL3pEd09xTUhnaFZnWE41QlBSSUpj?=
 =?utf-8?B?MzViREgweXR5Snppc3F6TjJPTUdtRDI4cHdVdUM4NEZmRWVLSUNyTW16YVVE?=
 =?utf-8?B?OE9ZRE5GZVNWRjhxRmxPNkN5NVlKU29LNitXUmt4ZVc0bng4TTNaSVlDUm1O?=
 =?utf-8?B?THZocjRVc3QydlUxdGNnenh1K2dHK2lqK2RwdHlRQmZ4ZmJycFNHMTdnMnky?=
 =?utf-8?B?REZqcC9GQUMrM0tRVm1ESG1XYU5DRmsxUEcveFRFNjhtbUt2VkZqQTltUFd5?=
 =?utf-8?B?L2w3MnZjZzJ1TXVUS0wrRUd4a20rMzg4YmJHR0dlZkYyQ0VkZnNUU0VUMFVL?=
 =?utf-8?B?SjdpMlpyemQ4NUoyUmc5ZTRpL1NTOFd6V0JMWFBKWXFrYjhaOFdXekcxRWdT?=
 =?utf-8?B?dm54cXAvdFpJYitXSGVJWnVIN2JvOTJYYVhhcTd2MTNnVFJXb0hid0hRUWdG?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 8188057b-3492-4c8c-9bc4-08de3c9ec193
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 12:29:28.5417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4la/dC1pZ2N5Y4UHIvkad6QnqnpTrJ3QWaQokPM+jr0GSlJ2a9F57RglaExtP5a+btMKOLIqGx1JcF7LLknT762KTNOBx9oH9SHfS89gss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1305
Received-SPF: pass client-ip=2a01:111:f403:c213::;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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


On 16/12/2025 10:27, Florian Hofhammer wrote:
>>> diff --git a/plugins/api.c b/plugins/api.c
>>> index eac04cc1f6..fc19bdb40b 100644
>>> --- a/plugins/api.c
>>> +++ b/plugins/api.c
>>> @@ -41,6 +41,7 @@
>>>  #include "qemu/log.h"
>>>  #include "system/memory.h"
>>>  #include "tcg/tcg.h"
>>> +#include "exec/cpu-common.h"
>>>  #include "exec/gdbstub.h"
>>>  #include "exec/target_page.h"
>>>  #include "exec/translation-block.h"
>>> @@ -450,13 +451,27 @@ int qemu_plugin_write_register(struct qemu_plugin_register *reg,
>>>  {
>>>      g_assert(current_cpu);
>>>  
>>> -    if (buf->len == 0 || qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS) {
>>> +    if (buf->len == 0 || (
>>> +                qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS
>>> +                && qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC)) {
>>>          return -1;
>>>      }
>>
>> If we are exposing a specific qemu_plugin_set_pc we should probably
>> forbid setting it via write_register. Can we filter out the PC from the
>> register list?
> 
> The qemu_plugin_write_register API silently swallows writes to the PC
> even though such a write doesn't actually have an effect, so excluding
> the PC here might make sense and I'm happy to update the patch
> accordingly.
> Are there other registers that should be excluded as well?
> General-purpose register writes are visible to the guest immediately,
> but what about special registers? Do writes to those actually always
> have the intended effect or should they also be excluded here?

Actually, after looking into this for a bit, I don't think it's easily
feasible without a big revamp (but please correct me if I'm wrong or
simply missing something).

The problem is that the opaque handle passed to the plugin API only
encodes a register offset, not its name or type. So to exclude the PC,
we'd need to expose the register name to the API (which would
likely require either duplication of the name in both `struct
qemu_plugin_reg_descriptor` and `struct qemu_plugin_register` or
changing the API) and then filter in the API based on the register name
("pc", "rip", "eip", ...). This seems rather hacky and fragile to me.

Alternatively, we could encode whether a register is to be filtered out
or not in the opaque handle itself (e.g., by setting the topmost bit).
This still requires getting this information from somewhere, though.
Currently, registers are created by parsing the target XML in `gdb-xml/`
at compile time. The PC is generally marked as `type="code_ptr"` in the
XML, so we could expose this type information to the code and adjust the
register handle if it's a code pointer. The problem here is that it's
not just the PC that is marked as `code_ptr` in the XML; there may be
other registers as well (e.g., `lr` or `ra` for Arm and RISC-V).

I'm not sure whether the above explanation is clear enough, so please
let me know if you'd like me to clarify anything or point you to the
exact spots in the code.

Thanks,
Florian

