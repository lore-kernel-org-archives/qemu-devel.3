Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588A2EFD205
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 08:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv9t8-0005DA-QF; Wed, 25 Feb 2026 03:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vv9sw-0005By-Pb
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:04:42 -0500
Received: from
 mail-switzerlandnorthazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c213::] helo=ZRAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vv9su-0000eE-Eq
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:04:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9D2Hg7QF2NOH7Vu5+Z67SbiF2FdfrVnbCAaaNeoKt/kau26C8khrLUe9SS0XfbXTI0t3H0b3f7OgzGLOEo0TdwUlCtqNxcOsAs/j+3QP9e1ybjVMr9qqA5xl44mEqGEMeljxJRm8n2ZISzi2K15LKjrSZgxEKz3PJ6VbW45kaLJh1LANmwiEz7ZA+nNfMYFYQqp5djNNQKnnWPupk8mLToEmzqqsDZBlEVqwspqrrwTc18ViK4EgNdlaCvAzPMk8gH4GfSE5B7wzJndNw3o984ab2ZPbI5LMfAXGXvvaZy3q3kXrALJIL48Y89Ud55I5iBy6gfwk0f2fFlcvd99oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rOCNhBQRJDbdB6t77F88jsX/CZWQWQiXr6Ilj6u/oQ=;
 b=NVbFmudKPLeN7MP9LT7S3NF3Z4h3Ibon5SkuOQkmKMxFIT4zsDDIZZWoHHGbwrgiuNK/sH15GFOunjtBq/HJSevePISzVkjm0l81/+9H1bD3HjyCy59Rk4s/PBGnAXjAUqhmVJmWpW2BQSXgX1gzMet73gg+j8Lu/o5I++dCbQw4hMGy0jA97c7YO/Ekx58re4LZyZCUu48WRt95RILUnr1ipGLIoJH37qxm8tP4n5Zc/TdFy0kE5yDPuE2xYXvxEDuvKRl3e3k0ag36g/HYj1w2VyMJuufp/8d2Y4GevZNYdW0oWB9FnacZ1IACVruTgben0kSW/da3iwpvk1YIcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rOCNhBQRJDbdB6t77F88jsX/CZWQWQiXr6Ilj6u/oQ=;
 b=ZXLRFhdovUzVveRxjud+HbhRJAYPRStxVwbim7tmDipDFPF3XLTd97DKdlxqd5b0zk0DnX2Zz/e8nbNLYvTUz2UHMGv7qBf5RV/PFvsKKXyTUoD/ZZJGkvRwY6PFG3/zB0dgsVfzKGto247S5PDKwmE8y69UsIm+xjqohsoP8t0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1238.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:73::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 08:04:29 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 08:04:28 +0000
Message-ID: <317b95ed-f4cc-44b0-afae-64fd45ac8792@epfl.ch>
Date: Wed, 25 Feb 2026 08:59:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] tests/tcg: add test for qemu_plugin_set_pc API
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <2ccc79ee-48ab-4097-a9cc-4d2b79ab9a8a@epfl.ch>
 <193c4274-c79e-4b76-8502-312dd3ebeb64@linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
In-Reply-To: <193c4274-c79e-4b76-8502-312dd3ebeb64@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms050008050307070704030205"
X-ClientProxiedBy: GV0P278CA0072.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1238:EE_
X-MS-Office365-Filtering-Correlation-Id: 40484a57-fbbd-4e4f-3d65-08de74447ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|786006|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzVqK29zYUxWRHRPZFVyUlRtMEZnYzhRbUNwZXNRVnhuN1VzQjcvTi9ma0Rn?=
 =?utf-8?B?M1pJUzRLZW03SytvZG5wVmp0cjh0QUZMYjdlaG53VzZ6RW8yZ1NTNnoyNmpG?=
 =?utf-8?B?MjdGQVhPUnhGWEVsY2JOWEUyV1lIeVY1dVdyUDJyTVFuQnFpdEh1aFg4djNx?=
 =?utf-8?B?cFJNeW8waVQ1UllYKzhJUVBZTENqL052RC9UazBWbSs3NFBUakNPZ1dEN3J3?=
 =?utf-8?B?T01tZnlsNjQrTllWL0F3Vjc4UDNPTERoM016RTNzeml4OWgrempLV3Foc3pS?=
 =?utf-8?B?dUc5cnV5OGZyMXlXck1MajE2TGpEMmxNQVd2NWVWdi9nb2NpMVR1R3VBTG1O?=
 =?utf-8?B?aGZNWUpSUjNzQW1hWGVCZitHeXl2b3JHVHJhRnlNOTk1aC9XUUcrQUIvdEh2?=
 =?utf-8?B?anFZZGNSelgvYW1ZcnRTRHBHOVg4NnkxcFB0QVFUWVZjdmxUcnphSlQrZDBw?=
 =?utf-8?B?YkR6SERDZU5xejNYWURrdS9iZGdETGJ0TEpVWHZWRGoweWFaR3lBemk5SGVY?=
 =?utf-8?B?akNxcmRtRVdjNUFHVTYwYjRHVEFmVTlLVHpoTWVMZzZ0UTdYWTR0Y0lPZXli?=
 =?utf-8?B?ajA5KzdRKzgxL1djZXhrb2JWVVJLT1RXOWJZRG9lK1VDRVlGYjU4ZUcwWDBE?=
 =?utf-8?B?REwrRk1aMGI1eHA3RU81UTJaWTBjZUFPUkhuc0FFam5ia3VDckhUK3lNSys5?=
 =?utf-8?B?MXA0Wms2NWM4NGFOT3JLTi9kMGlIdzdMRzJNRjJQb2xUUjJKdzRHMWkyM3FT?=
 =?utf-8?B?Vmk4MUVna0ZIaXNUVGk2aFVIVklPSXROVjRHUUxOL1V6dWhMTXZXN1c3S3c0?=
 =?utf-8?B?VjlGM1FqRExtNmFkanBnTE1XV2xkS21KYmFsa2JSdjlxc3V5SzRqdlJHdUxa?=
 =?utf-8?B?cFhIVkpKK3VWdDVWcmZ1VG5iOWF0MUNDclNiTmh1UXdKcGJlcW11dVkxV09u?=
 =?utf-8?B?QkxiNTdLWW94WE1oQTRJTm9TbC82Y0paZGV0NlFUcmpUblEydnNhZ1RFTzIv?=
 =?utf-8?B?WEJNcXRaYVFNVHN1aisrZnJGYWdINkdiejFMRnkzMEFJQ2NKQm1hNE8zK2hE?=
 =?utf-8?B?UCtjRzZ1Y0tSZHJNN3F3ZUt4MzlZbTFyNHhRVnRqQ1ovNkRacGg1RkRXZTlI?=
 =?utf-8?B?QVN0OENBdlk2UGEvS2o4V1lTZC9mTUxQK09adWRuNG42UVp2MW9pditUTFRo?=
 =?utf-8?B?TE1ZNDdCeHhFVGRncWp3UHFnQlg1MEdZM2RHdGwwYitqbHFYTlFFMFJ1Tm1P?=
 =?utf-8?B?alBRVTJURDg4NTBnNHQ2OXRNZWIrNXV5a2FDMnNQRkdCRjl4N2VueDFIN2Z5?=
 =?utf-8?B?VjJCR0xEREJ1MVd5ZXdDcjU3V1F2b21tYkYyclQ1SmVZTlNPWlJaRjExNWwy?=
 =?utf-8?B?ZWp2SGM1Ri9KZ2h0SXM5VnlKRDFhWGxldjlpaTkrbEttNllHc2hEcTZsVVFi?=
 =?utf-8?B?SVFPMURDQzhEbWJMM3JMSHAvLytQMU5qTi9TMDROTkZyMHY0YUFTNDhOclRs?=
 =?utf-8?B?N0c0OWhOL0VQbnkycURuTVpONm4ybXJOVGhyanFnckdEd3BUR1dGOXltcFcz?=
 =?utf-8?B?L0c4Znh5Y1BwbGtXQ1kwZUhNaTFOUzUzQ2xsM2xVWDZtNmptOG5pV0JzOGkv?=
 =?utf-8?B?VUUvM3FmUkJucTlPMnpqL1laaTQ3SzgwZGwyVFhDZ3N1NGxibUNZRkRNenM5?=
 =?utf-8?B?M1VoZUYyYWRIQVhSTmppamNFUmhZVFJqRHAzM0JYQzg3YjRJYjRWWFk2V1Yz?=
 =?utf-8?B?WVZLQVg3U2o5NTJEcWhLMWs5RDJRR2ZHaGhUYmNhR3dTUVcvaGNjN1ZQYXFZ?=
 =?utf-8?B?VkhxS2d4VERpVm9seFo2YUdiUnVOOXlGUnFZUWNselZZalpvSDVFWHcwNml3?=
 =?utf-8?B?d2RYYjJxODhmWmNUeGpLNm5pZGhMUHRUcE11OFl0TUpiNFhZd0Y3YnhJNEdX?=
 =?utf-8?B?Sm82MUlVZllJVGsrdlJtRnZwaDdzSDRvaW9hTDBienJ4TWRHTGtBSFpkdkkw?=
 =?utf-8?B?NFhWNjRudDBadWdqeXlEcTFyOURkaHZoVC9aK0Q3QVluVWxJRjd4TUpoNk9o?=
 =?utf-8?B?T0JiNWhNbEJjTmEzdmVRZWJrN25obVI3Slg3N08xMHJHWkZhelVjVE1DQ3Yx?=
 =?utf-8?Q?HBV4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(786006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTlNS2NVQ0I4VmJ0cGswU3BwNzVnYjdvQlk3R25mQzd3QkJoL3EwdGJTUS9m?=
 =?utf-8?B?ZTU1SXFCakwyaWZPNk45dWdmb0tnb1JDb05iQm9mMUpIRGxqVHBDUlRsZXl1?=
 =?utf-8?B?eDljOC9vUFkrOVRRVEdnUEtWUGdvK0xSRlZKNkdFUVkwUzkvMURmWThZejho?=
 =?utf-8?B?WDAyWkpzTEUzcEkxM00rZFE0ZTFPM3U5S1dsdysvNVJXdk5JbTNDUHRqSlpE?=
 =?utf-8?B?eEJ2b1B5QTcxSmYySTMxbkVTUjlyMWoxRktOUU1EUmxwaGVqbWp0dGVuN01m?=
 =?utf-8?B?cFZBUmM1Sld5NGNZTXFTRkZIN05wUnpUUzBRZTNBTVJwVldDQms0U05aODQ2?=
 =?utf-8?B?Z2pOLzhwWTc1RXVpaFBBVTlmNmVyc0dQclVEYU5UZWgrR3ZOM3FhTjUyMlhM?=
 =?utf-8?B?NlJmS0pzSVBSN2VrOUl1UWFjYmlCT2ZTaEFYR3J0RjdmNVpmNkJMdVN4SytL?=
 =?utf-8?B?T3VMMGQ5cFoxelNJejdiWDJGc1JlK2doNTVCUGVOZWNweHBhcmgvUmlEQzMz?=
 =?utf-8?B?ODlKOXNOZkptZENZSXBNMThzSGlyNUkzRTdOWVNCdkppL2ZaTXRBcW85T3Ba?=
 =?utf-8?B?TENDNWQzMkJmSWR0RVRvVVNLdWU0S2hZN3VSWGY0cTh4L1RuUng0ZkVQSjZn?=
 =?utf-8?B?eDcxbll5aWl5dVJvTVY5d1pJcmlBU2RFYXFOb21hbDhwdTU1WlU1U2hLUmoy?=
 =?utf-8?B?OFpDNXZRYVg0QXFyQnY1bUZjMkYyckh5NVN0WHJrT1h0K1I5aStsQ0hxZmND?=
 =?utf-8?B?eW5DazVrZ1ozMVVuemNHbyt4aHhJYld1SUdSYmtQUG80T1pKd3kwNDJsN3V3?=
 =?utf-8?B?Nml2Q3F0SnMwLzk5L3JZNDY0REg4bUFZVDBzV0pwVThtb0JtSTYzdjZJS3M1?=
 =?utf-8?B?MkhBQ0g1R2JEK1I4czYzZGVGNjE2cFkwb1Niem83TEpnSVg3QkRxdW1Nb25W?=
 =?utf-8?B?VDdxbTdWNVlnNjEvS0xQM2NkeFBvV0ZLaERCU01nT2hGYUUwdDFjOEpvcHly?=
 =?utf-8?B?MDhZa0xacDZKOHN1MkhtRU5lTkxOQmRsQldrN0NtNm1UcmRSamV2eWhoOTZJ?=
 =?utf-8?B?clJzOFRZaWFqOEk2eDQzOHFTdFJSbDQxOExweG0rd0ZXbU9jdGlmaFBpUTMy?=
 =?utf-8?B?OHdjdEJEU0FmTVRMdXJLVmo1YkZWOU1uaElsdnFmZ3hiMGVaT2pIRmpSOXp6?=
 =?utf-8?B?dWNKS3NFUEZHT3pVK09jL3VxdUxtYzJYNmQ1cEVMNWkvV2xrY1JRUldjR3Vn?=
 =?utf-8?B?eW9jVXJkVHl2N01iTHIwejZBUnpQRm1QU0E5T0oyME1FdFR2UTNiL3cwWHQx?=
 =?utf-8?B?NEtiL2tETlhuTEJkTEVnY01WQ1NtN1lLdTlaZzE4SjVHeFc4Z2hLdU9jeHFV?=
 =?utf-8?B?ckRSQmxIQjNIYWNUajRQZ2oxUXFUWGIwOGQwTlNKMXNDNGQrU2pBbXdFRUpX?=
 =?utf-8?B?VUlqUk5pc1l3Z1VyMHVoWFcxSGNPY0JLVW5oUUxSc0lFcVIyMnJ5S0VLbGhI?=
 =?utf-8?B?cFJEUmxKNU1oSnM3M0ZzNS9mdWRnMisvNnZXYU41eTZQUWpFYnZ4R3MwQkU2?=
 =?utf-8?B?WDR1MTRJMGR1VmlNOHI4T1JkQWhPZlJGNmQrcUNJem1GdXJyYk1lQ2tWRU5C?=
 =?utf-8?B?aHNFd3I2Yng4OGhiUFZ4OGt4VC8ybTZ3YVhBT2RmTEpjRGd0azJuRUlBNFpl?=
 =?utf-8?B?M0cvdysybkx6cU1RdWtFb0dlT004WVFEVzh1ejNMRGc5ZGs1WTJKODFWM1VE?=
 =?utf-8?B?bFA5YzlycSs1R2dmWGpmcUlLYnVzQ0kvL1R3NHFxcElLSEhKNzdiVmRVWDhE?=
 =?utf-8?B?WFZIWWN4Z2RFTUxtVEwySGxxQUJpVTh3TmY5dWRnbWJzeFZKSmlXSElSTUpi?=
 =?utf-8?B?TXhqNWF0RWxOZGF5NlVreS80M3hnUWYrS1ZGM3JuWFhVbi9rdzEzMmJwN2ZC?=
 =?utf-8?B?R0hXeFJqczFlTjNTY0hqUjkvL0d0LzVmcGRxa1JNdlIzM2toVVB6M1BTWERn?=
 =?utf-8?B?WE00MGFHT2srQld3blJvejcxUzJTRXRPQVhZcklIYUxiVDdacTkzdGJZa2k5?=
 =?utf-8?B?NlB5YnJlakVHb2tSSzE1Y2VxYjdkWDhDOWN2ajlCOHcrQTd3TUtQUDV1RmY3?=
 =?utf-8?B?UHlPN1U1RzNJa3dERjF2dTEvY1phbVdFbWJyRlJvdzh3Qm9OMy9JRnZXMmts?=
 =?utf-8?B?SG5xTjVxQURCRU9uNktQRnZKOGtteTFYdE1NSTB4azJacEt6SGFEdXdnUWp1?=
 =?utf-8?B?OThjaVE2dTlqMFNDMFA2Qm80TUZ2R1Y5TkdEdXJySnVmUWdrV0JOeU5sVEJ2?=
 =?utf-8?B?UlQyVGFLR3NJVTM3SFByLzY4bXQ3b2k5N1BZYjVuQ1R6ZE0yQVFFZz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 40484a57-fbbd-4e4f-3d65-08de74447ff2
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 08:04:28.8441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQwjT7rpOw7V/dV0MyHc58m9MU5M3a5o9Ex4iQMdT4rkfaoW7szz38x0jhgAO37oITJ4PbZHgexKB6XIah1G05euQoq+I7zFwdwbtPh0TUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1238
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

--------------ms050008050307070704030205
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 24/02/2026 21:35, Pierrick Bouvier wrote:
> On 2/24/26 7:52 AM, Florian Hofhammer wrote:
>> The test executes a non-existent syscall, which the syscall plugin
>> intercepts and redirects to a clean exit.
>> Due to architecture-specific quirks, the architecture-specific Makefil=
es
>> require setting specific compiler and linker flags in some cases.
>>
>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>> ---
>>   tests/tcg/arm/Makefile.target                 |  6 +++++
>>   tests/tcg/hexagon/Makefile.target             |  7 +++++
>>   tests/tcg/mips/Makefile.target                |  6 ++++-
>>   tests/tcg/mips64/Makefile.target              | 15 +++++++++++
>>   tests/tcg/mips64el/Makefile.target            | 15 +++++++++++
>>   tests/tcg/mipsel/Makefile.target              | 15 +++++++++++
>>   tests/tcg/multiarch/Makefile.target           | 22 ++++++++++++++--
>>   .../{ =3D> plugin}/check-plugin-output.sh       |  0
>>   .../{ =3D> plugin}/test-plugin-mem-access.c     |  0
>>   .../plugin/test-plugin-skip-syscalls.c        | 26 +++++++++++++++++=
++
>>   tests/tcg/plugins/syscall.c                   |  6 +++++
>>   tests/tcg/sparc64/Makefile.target             | 16 ++++++++++++
>>   12 files changed, 131 insertions(+), 3 deletions(-)
>>   create mode 100644 tests/tcg/mips64/Makefile.target
>>   create mode 100644 tests/tcg/mips64el/Makefile.target
>>   create mode 100644 tests/tcg/mipsel/Makefile.target
>>   rename tests/tcg/multiarch/{ =3D> plugin}/check-plugin-output.sh (10=
0%)
>>   rename tests/tcg/multiarch/{ =3D> plugin}/test-plugin-mem-access.c (=
100%)
>>   create mode 100644 tests/tcg/multiarch/plugin/test-plugin-skip-sysca=
lls.c
>>   create mode 100644 tests/tcg/sparc64/Makefile.target
>> +++ b/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
>> @@ -0,0 +1,26 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * This test attempts to execute an invalid syscall. The syscall test=
 plugin
>> + * should intercept this.
>> + */
>> +#include <stdint.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +
>> +void exit_success(void) __attribute__((section(".redirect"), noinline=
,
>> +                                       noreturn, used));
>> +
>> +void exit_success(void) {
>> +    _exit(EXIT_SUCCESS);
>> +}
>> +
>> +int main(int argc, char *argv[]) {
>> +    long ret =3D syscall(0xc0deUL);
>> +    if (ret !=3D 0L) {
>> +        perror("");
>> +    }
>> +    /* We should never get here */
>> +    return EXIT_FAILURE;
>> +}
>> diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c=

>> index 5658f83087..b68e3cadf4 100644
>> --- a/tests/tcg/plugins/syscall.c
>> +++ b/tests/tcg/plugins/syscall.c
>> @@ -148,6 +148,12 @@ static void vcpu_syscall(qemu_plugin_id_t id, uns=
igned int vcpu_index,
>>               fprintf(stderr, "Error reading memory from vaddr %"PRIu6=
4"\n", a2);
>>           }
>>       }
>> +
>> +    if (num =3D=3D 0xc0deUL) {
>> +        /* Special syscall to test the control flow redirection funct=
ionality. */
>> +        qemu_plugin_outs("Marker syscall detected, jump to clean exit=
\n");
>> +        qemu_plugin_set_pc(0x20000);
>=20
> An even better alternative is to use a value label, which is a gcc exte=
nsion, and you would not even need another function. Just pass it as firs=
t parameter of syscall, and jump to this address directly from syscall fi=
lter.
>=20
> int main(int argc, char *argv[]) {
>     long ret =3D syscall(0xc0deUL, &&set_pc_dest);
>     /* We should never get here */
>     return EXIT_FAILURE;
> set_pc_dest:
>     return EXIT_SUCCESS;
> }
>=20
> More details:
> https://www.amulettechnologies.com/boosting-bytecode-efficiency-the-pow=
er-of-gccs-label-as-value/
> https://gcc.gnu.org/onlinedocs/gcc/Labels-as-Values.html
>=20
> Regards,
> Pierrick

Thanks for the idea, I didn't think about this. I'll check it out!

Best regards,
Florian

--------------ms050008050307070704030205
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DD0wggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJ
BgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2Vy
dC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMw
MDAwMDBaFw0zNDAzMTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2Vy
dCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNI
QTM4NCAyMDI0IENBMTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1x
PQ+dgSxbIIrkaru6skAWJYaGFzmvq4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XR
mS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5ZS64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1C
xy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTbZ/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV
233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK72a2GEpI8Wpl26G6I1/LMzz/98T+FqjT
qxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZACcVdCtl4nAacFacmsiArZBfX7AQG
L7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8WmAESbUriIjyuTUf3fJ9oDNCu
rVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2csh2T79v7pC8aUtHBfwNrT
R19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61aCBevQGHNzrbZ3JAM
neveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxIGJiywe9qPhuJ
SDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/AgEAMB0G
A1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtgv6l+
vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEMGCCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1
cmVkSURSb290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0G
CSqGSIb3DQEBDAUAA4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvC
RS2pili3Hy67i8N4N5NUvw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwE
qOOwLLyH02ZQcsfq5p5LrOH90JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9Y
flujuNNvJztjBaHKYZsnNSg+J38ojYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3
x7Nel3A1bwAkalrDMspvTHvey6LfiBksFIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVr
Yu8RMIIGhjCCBG6gAwIBAgIQAggtinx6OJLKM4FVztNyWTANBgkqhkiG9w0BAQsFADBiMQsw
CQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0
IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQgMjAyNCBDQTEwHhcNMjUwNTI4MDAw
MDAwWhcNMjgwNTMwMjM1OTU5WjCBrDEOMAwGA1UEYRMFR09WQ0gxCzAJBgNVBAYTAkNIMREw
DwYDVQQHEwhMYXVzYW5uZTE0MDIGA1UECgwrw4ljb2xlIHBvbHl0ZWNobmlxdWUgZsOpZMOp
cmFsZSBkZSBMYXVzYW5uZTEaMBgGA1UEAxMRRmxvcmlhbiBIb2ZoYW1tZXIxKDAmBgkqhkiG
9w0BCQEWGWZsb3JpYW4uaG9maGFtbWVyQGVwZmwuY2gwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDZkbG07NgfFKDNM3VI4qQdU1fVIGUQnN6BO2zeqoUdytNIzxOX6n7HxM+o
CLa01AnxaL59DXwFTXIg0OVq5ETAoLshUwnkYeWhKZH4Ysoq74QGVFihjrrs41d+8o+ymG2F
cZBMzQ/RO4KzFhmlaZ/E+1d2F7/O3x8LohaFxxBsN0+qonMreRQGx+ialMmbARFJkVuinuB4
3hZ8eRVmXy8A4R8ywakunaCNm15+eIQtptCs3IH5UqPEEOn16ANekWr7z5mZJh3ApxreflA/
iwJKWd/Ljga90TJXjTFc7sNA0RgA78Edqw7BE+D2VUcPMshdhKYNB1BVHZS81anGL7RFAgMB
AAGjggHrMIIB5zAfBgNVHSMEGDAWgBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAdBgNVHQ4EFgQU
ogXJJmzPazWg0eBlf1DbolocD3gwJAYDVR0RBB0wG4EZZmxvcmlhbi5ob2ZoYW1tZXJAZXBm
bC5jaDAUBgNVHSAEDTALMAkGB2eBDAEFAwEwDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQG
CCsGAQUFBwMCBggrBgEFBQcDBDCBqQYDVR0fBIGhMIGeME2gS6BJhkdodHRwOi8vY3JsMy5k
aWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0Ex
LmNybDBNoEugSYZHaHR0cDovL2NybDQuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcy
U01JTUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwgY0GCCsGAQUFBwEBBIGAMH4wJAYIKwYB
BQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBWBggrBgEFBQcwAoZKaHR0cDovL2Nh
Y2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01JTUVSU0E0MDk2U0hBMzg0
MjAyNENBMS5jcnQwDQYJKoZIhvcNAQELBQADggIBAD3Ne2mHg2ctxRIflrx/T2yBDnQunFhe
SRwBnFIaOvCG05KE9iit2I2sazC5xqdp292spCoP9Qa4MOJg22BFmTnN9XnOjcEv9KFPSMaA
ITLu8CXyewPb0xLET8WqdEe5AravlneZ9/H0ve9Ufhk3wbJPKK5yijcKYmEYH21JBtZ1pnjs
fVEXAETdKkp9LC5sVeYeFk67BbUTPrFl37pha3TynPwJAiXDJFR2uI2JVGESQFyWkeO/bY5T
DCf6VIp3d1p++XoOTVseFE8OqaHZYGN+DgSK4ejT19c/GgjQqoWVK+xSvHEEsoLfOADKcYFN
M0ptGrFYpdRWJO0CKukBUAk8fpriJ/OjhSVQltCpN3pK1DPXnPrXTROXGacb3PNSUyeDlP2/
y0FqpEY7GjwMZMdu+U/rHhMGbDmv/ZBLGwiGzQVmld5je+d8nvZTamE1iBA8Nhmuz6wg6yN1
qx9b7Jn/9yQebxvHddnvz6jw6FDnw2bhq7z88eH3mYZYZ48Fhr8J87horGotEDKTDNHkF1Oe
FSxhIx0a7yoe1I66R5tapkRlNgI5EX53e/npP4ruND5bQFWDI7JGkKrLlAjQR/dNahXXX/Ry
rCfngiHZcAQakPkQrlrZCxMhlIKvDMunATaICyjnHizEC+1qzJsdvJgSC8sOzLxiEjlx3MRe
CswFMYIEezCCBHcCAQEwdjBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIElu
Yy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTECEAIILYp8ejiSyjOBVc7TclkwDQYJYIZIAWUDBAIBBQCgggLWMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDIyNTA3NTkzOVowLwYJKoZI
hvcNAQkEMSIEIEtzLFbz/i08PdkWw3/AQ18UGK6dPdggTeptgIZyYKMfMIGFBgkrBgEEAYI3
EAQxeDB2MGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQ
Aggtinx6OJLKM4FVztNyWTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlVTMRcw
FQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBT
TUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQAggtinx6OJLKM4FVztNyWTCCAVcGCSqG
SIb3DQEJDzGCAUgwggFEMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcw
DQYIKoZIhvcNAwICAQUwDQYIKoZIhvcNAwICAQUwBwYFKw4DAgcwDQYIKoZIhvcNAwICAQUw
BwYFKw4DAhowCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgMwCwYJYIZI
AWUDBAIEMAsGCWCGSAFlAwQCBzALBglghkgBZQMEAggwCwYJYIZIAWUDBAIJMAsGCWCGSAFl
AwQCCjALBgkqhkiG9w0BAQEwCwYJK4EFEIZIPwACMAgGBiuBBAELADAIBgYrgQQBCwEwCAYG
K4EEAQsCMAgGBiuBBAELAzALBgkrgQUQhkg/AAMwCAYGK4EEAQ4AMAgGBiuBBAEOATAIBgYr
gQQBDgIwCAYGK4EEAQ4DMA0GCSqGSIb3DQEBAQUABIIBALN20t90SRP8vwCclhaTSw5Ah4fc
Uooj96WPaK4scBrXu3yqLb98SaHaDrFDhO2TjRog7wWMKs5E0cfneZRpNGk0HV4/mEbRdjyj
Qq+jFLOvjIk/SrreDipZ6yGXeL/TZVS2vvok5hqFZKVXl3G8WptT/ofEu9b7U47fd8JFtYP1
Is9sgg2uSatDYuY9F0zNh6N3tTjeLgDJHuYPsX1PDEOb9v/5q5r/a1byc5ONIh7WMAiM7NsH
gxVNaVQm5E4NteaeOhnzPM0mk4fRJtbeC2k34e5vlKJSdCncp96RVaJhs3V9OTn7baME3tXh
xr66N5A6AhVod+PfDdVJ5uA21VIAAAAAAAA=

--------------ms050008050307070704030205--

