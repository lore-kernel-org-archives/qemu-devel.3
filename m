Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4567D5CC8D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 09:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVRUQ-0007A5-UW; Tue, 16 Dec 2025 04:37:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vVRUI-000755-Q0
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 04:36:59 -0500
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vVRUF-00084u-FW
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 04:36:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KqTXB7HRN9rF6Bz8T+DUHsiRkOaIsYfQJANvZfigKx7geKM/TjEbb4dxMDK+JnhC8L/tL4VivKsdPXc6wR/uUJQFf7Pxhim+zJBUZqEwVbQIHtS6T8qqph+LEDCYZJSYssxUoiJ7rRj2TSEDtWmSIWBbWSn8/Usaf4saVWc9Vpu1FTErtaDAZPs1TXCzqB8vq2IcG8DHaZNNIiOhCmm/vg1v+gdnmPudxtAhtUISLveJQn96sr0hdyqVHvfaeHWgDXp5jtt22HjMvZlJDJ19OgW6hal+mbJnYty0o/7/plNz/zPqiZ95UNCaIgL3j400tdL4WLfD1jYtM+4bFbUyGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+U/K0hwsTz1y+ok+MBVhAhNVGWSzhWEBufjMHpBiX4=;
 b=Wy1bwZsryg2TXaRMbWEjXKZ//RL3yi1WYURNj3ez3XPWSSQ94s+1uY4y78FtLd2EmE7Sz/VCHSg0CcMwOA/bBXk+GjJJ/LsfLwF/hvcOmmgCIfzb0V9IZFgc/bNkmKMoDMle7bXP64nEvQJNAWu4dlhKwHSXA4ZEa0SrKQBlj9pF4v1fs5Cld5L+8qvRLvTOlzUpkNbWK3NV2OqLZEJi6H1HlTTO+HTasloQy3I07NyXHpKeF5v3yFcnFC4gbuMt1+Cw/BNHQm4X+V+bvuHWsO+4Em7PUgvn8szmiJ44glBt/11FWiGg3OZDiWATA9bHbzZmZG2iC1elV9BwGSveWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+U/K0hwsTz1y+ok+MBVhAhNVGWSzhWEBufjMHpBiX4=;
 b=Vtn8oflbrA+eY4OaX913z7xIz/qWxRiuDt6bcw5y7z4tndYmvYmuWNy1Wbmuif6y0+VZfK/IXMvRZTtra2XssAeq33X/gSOXx+ShMh/pUIUVVljgGFOio6QwmqcrEseR4p6RJmxRYWZDB0ih+hp8l/PICLOy7JS+yEVEOfoaLic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1440.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 09:36:20 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1%2]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 09:36:20 +0000
Message-ID: <73e1d846-db58-41cf-a8fd-775bdb8aa9dc@epfl.ch>
Date: Tue, 16 Dec 2025 10:29:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/2] tests/tcg: add test for qemu_plugin_set_pc API
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch>
 <0b65f1ca-c960-4d9a-9029-23974218da80@epfl.ch>
 <877burub42.fsf@draig.linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <877burub42.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0060.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::11) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1440:EE_
X-MS-Office365-Filtering-Correlation-Id: e6fbe40b-7722-454e-15d7-08de3c8691df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|19092799006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3kvM0k0N1BQd2YrZ1A3bk9HVkZvMWZhOThFZUZ6em50bTRodVdzd3Y1QXlo?=
 =?utf-8?B?Y2VVNmlkTUJMNU9jb3pTcUx0ZTlPa3M4eEZISU5xaWhkN2QwakpmQ0hzWlRY?=
 =?utf-8?B?UjFYN1VsNkF1SjBsUkN3a1hIR2VmWVpLTWRma2h2NFdtMysxVCtxOUhQa0dG?=
 =?utf-8?B?MWpzWnVteFNCS0Q0RExEMHZ5M0VEa0JrNzd6OEtuSlBPSjFpb1dTZWZvQ3Zj?=
 =?utf-8?B?L3oxOERzczNLbTFkeE55SW9KdXRaRk9BVHlpY3YxZStVU1ltdkRUZkYyclNr?=
 =?utf-8?B?OHRNSVpqN0pmYjk4YURGR2lSYS9NSmtEd05aelhEZXdCRVFBYmNFSVBER0lv?=
 =?utf-8?B?WkFIVXd0d1Y4eUUrNjJxSUNUSUxyRE8vdmlCbFVBd1FHSW9MN2dEenR5VWRH?=
 =?utf-8?B?Y2V6M2J3WTNwVVJxTW51cDlWRGZxbmE2OVg0Mk1oVGMxUDNYN0d5YnJ0Y2ZX?=
 =?utf-8?B?M05kNStMTG15U2lzSG1xeVBpTG83aVRzVWRhVmt5clN0V1cvTTNIWGU0NWpY?=
 =?utf-8?B?cXREUGUydnZwSkhnNzAyaUhhOGxERjV0YkF2Q3hqRjlaazJJdWdPNlZXdmdz?=
 =?utf-8?B?Vnc2SGlUVUxJTjM0aUFNTldHTmhBcHVFZDJxQXVhdnZsRFNDNUd3QjlzSjQ5?=
 =?utf-8?B?NXVWK3UySHFxdTB0R3dKaTAwSENZRXgyd1JLN3BoWkJvelA4QjlKT2s3aEtP?=
 =?utf-8?B?L0RqSFdBa3RNc2doZHp4QkJDcWVjbHZnWGFIRGk4RVU3cU03TWVtMXIrUTVF?=
 =?utf-8?B?b0pYalZOSUszY2tZdXhYVnM2MDNXUmkzQlJtdWVrOG9PTFEvOExSWG9pU2hW?=
 =?utf-8?B?enM1Q0ozaHNZZHJpVDNKSmc3U1d6bGxrVFIyQ3dlQnJWeUJ0TTZkR3YrUW4y?=
 =?utf-8?B?NlpDdUtmQUx0K1YxVzhvR0k5QkZ5M2tSSHR4L1NpRXMxdXVwWEZCbDFZNm9R?=
 =?utf-8?B?UlF3RlpEanJCRGo2K2pINGtnaVQrY08zandQZksxdFdTVXk2T1VYNFZtdDZC?=
 =?utf-8?B?b1F0RkNRVGV2dkhlbXpVRUVVOUV0VXhGWVI0YVJjcmErb2xyQVVQS0FuSlZz?=
 =?utf-8?B?SXc5bzhhSUZwemJMVWZaMmZVUWZyMkZOdzlFZ21aYTBPNVBxT2RIM2x0UGlr?=
 =?utf-8?B?RUNNY1IrVHlYMEhBUUxTNndOYUM3VENER0tuQU5vQnE5Q1FPRjJsWi8zc2Nu?=
 =?utf-8?B?cjdNRjNFZlJUekFHMkR0OC80L2ZBRlg3MmhzYWZLWmFkNDVoNVpsRVJMbVQ0?=
 =?utf-8?B?MkJ6c3JBakNhcUEzaTRrM2VVY0RBQVp3blp2YjRsdXk4M1dLREcrRHBBcXhK?=
 =?utf-8?B?UHZLcGdlOU5KRStGOUZWRlg0M0p1bkg5cHlCeVFmRVlRVGJzOTlxeTRyajFz?=
 =?utf-8?B?bXRIUkI1ampMQmdUMEltakUyK0pqTTVrNGFvL05TbXl0cVg3SUFNbDlNeXRT?=
 =?utf-8?B?TWh6THRpVGZkcVFoR0ZzSHVPVEJwd1lnRWk2WUFleldaK2JjMWJyTzJ4bkR5?=
 =?utf-8?B?LzI3VFl0ak5HRi9pMGNBUVl6Q0pzdjVPeW9TaDQxZnpJazNmSHlMQkhCQ0NC?=
 =?utf-8?B?Z2Vac0dRUG9RNU5iMktBdW1PVEF1dFBPK3B6WVlkRUlRWi9aWUZKMUUzRmg0?=
 =?utf-8?B?ZWtCQSt6V05KcW45akxpaUZNcDA1bm5lWEw5bDgySWhFd0dDMVpVdmcram1D?=
 =?utf-8?B?TlhFei9qbjdzRVd6ZWhLZXNucG9XUHhIc1dNLzA1QjFnWUhId0JHai9Ud2VT?=
 =?utf-8?B?ZzQvbllhNHBWWE9oai9rb2g5b1hQWkM0eHMraUl5VDh4UHY0YmRmRG5wdFND?=
 =?utf-8?B?T1RLOWZtZDBLU1BjbVl2RUNtd1NoeTVKUXNneWJiVHFxSnV4cDNyRDdPSzdx?=
 =?utf-8?B?eCtFdzl0T0xUYnhtR0tFL1lmV1VCcU95bkFJMkZIZldpNmJpWVRlVjQ5YkVK?=
 =?utf-8?Q?XR9/ohlXlHo+V1a/gh0NIihPk+4E6V/o?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(19092799006); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzU1RkhHMzllNzBld201Wk5ZRHQ2Rm1VaW5UTldaSk9KTC91bVp4dGhoTkFr?=
 =?utf-8?B?TDlNOCtlTjE1TE0rVC91cFJ1UUtyMmRQVHRhQXVVS1BSKytzTkV3S2E5LzMz?=
 =?utf-8?B?cEZlYWNGNzVFK1M2Q1FGWGVtTVczVWw0Und6dUl1NUlycHh4SWlGc09peWVn?=
 =?utf-8?B?ZHlpOWVHdi9lUWJOZzc0OERMeHlCQkYzVDR5T0RRTCtRZ1VXRm9DV09XMEtS?=
 =?utf-8?B?Vi9qM1pBOG8yc2VBWXY5ZkxKcFVOcUY4N3JITEplNjdZeTE1WFhvdUEzenl6?=
 =?utf-8?B?NGZTQ1M1WVBwWk00UFhTbmRseUVYNjFrd2o1djUrZnFJSnRXdGZvMnJCK2I3?=
 =?utf-8?B?ZzRtRkdmdEJQd0Q0aEV2ZTRYOUZveFF4SGxnejN6czBlS21GRUk5bWlNcjda?=
 =?utf-8?B?SjBMRE1jcGtSeHJWL0p4MGN6NzlVZjB2Z0liQzlxSytnV0xQazlmZTlHK2dM?=
 =?utf-8?B?MGErM3k5N202MjdSTXhFMUI1dmhORWRad2hDYUhyM1Z4enZCMlJCU1oyRlo5?=
 =?utf-8?B?UUdTMm94SU54OUVOUk00ZXhPNXRCZml6cTFlV0hORkFJVDBpZWhVL2prSVRj?=
 =?utf-8?B?UXlCK2YvTVM1QkxFbDY3cWw2WGNSbGJqclluTjUzSlY1WWRKcVovQ3h1bU1z?=
 =?utf-8?B?Wko5cG1sL2VFZTFoeEt2dVMvRjRpZWF1NzBZUk9sZ1JmWHA2SDRTZVZXUWJj?=
 =?utf-8?B?R3RnUEJMc3JqNGdVcDROVUJwTVhMMGJiaEE4RGM4UlBzMjJlNU1NZmt2enhs?=
 =?utf-8?B?ZU1jSGlRdnJUV2huQmd0YzlWMUdPYUZiZklGL0RGckhkMXpidSt1VHllOGRL?=
 =?utf-8?B?elc3aTdlSDFRdG5ZQkNNY2VNa1dmd2Z2ZldvbGo1VVRIa1FxNkVrd2hYUEg5?=
 =?utf-8?B?Y2llaVplL2N5dkFhS1hmVjVicjU5MzJyeEdVVjIxWmdZUkFHWEc3NWhWZjli?=
 =?utf-8?B?TUw2VmVlUmJpZDd2S29nZkxvdm9UT0MzUXNxYXdWMVdPdmJpSEJXZUw1OVJm?=
 =?utf-8?B?QzE1QWR0c1hZRmp2WWJyQy95a1dTYkRkUHBFaXFQUU1iaEhrMEgxMzRoZDRI?=
 =?utf-8?B?elpHR0g5SnR2NFFaaTgzQURaVXZRN2twS0xzdUxmUjdKVVY1SFpuY1lZUHhN?=
 =?utf-8?B?dThrK3FreS82cDhCL2RSaVhlb2dXd1JoR2orV2xOTG00dG9QQTc4cXpsUUJ0?=
 =?utf-8?B?Y3BiK1cxOU1PWDFGTmRLWWxzQ2QyOExNNXltMzA5czRMWlErc01OU1h5Wnla?=
 =?utf-8?B?UmFxcU1KZzJOdzZvb1VVRUdNSlZaakFUODNob3dNRkJtYkJ4cTJlb3B1dy8r?=
 =?utf-8?B?ekhKSHduZm9hdzRIYXFlaUxxclRydmdmcDkrRVcyUFRueTA5WHZHdFppdUYv?=
 =?utf-8?B?STdYdHNnY2NFQ05zb3NXMDN6UWVHSkJwVFNmU0FkVHYveWNRb0REUGVtbHdq?=
 =?utf-8?B?NE13VmJjdnlreVo3c0FpZk5jcER1aGJVMnJTQ3RoZTh2bEc2aGFYRmE5QVBY?=
 =?utf-8?B?RndkcXpBenFFOW1TeG94bENmTUdnbGNuQzU2N1N6aFdhbnozRzA2SFZRODFL?=
 =?utf-8?B?NTJUUW1RWS9iNlhDWXN0WGlja1pVdERiVkQ3L0MweW50aEFGSTUySHQyZlJx?=
 =?utf-8?B?dkpQcU5CYnpiV1Y0RUx2M2tSL1FQQWVPOGhWT0dxcjA2emg1RE5aUlZ2aXdZ?=
 =?utf-8?B?TUNkSTFaTVpENWFEQ1Qvb2RLY2hzNmpneE9CdG02UkdtODlxN1Qxb1dXRnVk?=
 =?utf-8?B?RmxMektPL1VtcUdzOEthbGEvZXZkaVBvN052YjEwU1JhRTlMbXlMaG1ROUdK?=
 =?utf-8?B?OGRuRFZUOW16eHdwVDYzcUZGTWZVSzFmeW1tZzRjVFVsUmpyVVFycHRkODZa?=
 =?utf-8?B?KzZmZk1lZzNaMWkxSnZkWUk2bHpmOHhuNnphaUhScm1tQXZZLy9WNXVESjZK?=
 =?utf-8?B?N3R2VFo1ekxxUU95Q0pQT3g0RlhkSlBtUnBTTFdoQzBIVUNYSVJkc1lqb1NH?=
 =?utf-8?B?RGphREhXdnVVaWJGKzk2Lys1SGVMN3kvdldDUkIvbGNGNmw5SGZZVnlZMnBw?=
 =?utf-8?B?QTFsMXlGZFVXeFExQkVRK0s4a1IvZUJveW55SVdTdFR6b0hvbmlhQmpoTWpk?=
 =?utf-8?B?Zk5GTENpOTBsTWovMnhQVHRma1pGbGY3NHY0RkxNQlNPQnR4K1lUNnlWbTVD?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fbe40b-7722-454e-15d7-08de3c8691df
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:36:20.5108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kICabh1j+bM0cCr/DsfMcC7LAs6JMd2JsceoePLV7j9PSdGZL2lMN2J4hhfCQJD0JeEnWfBZZgRw+TyuhFx9qJD2oFKP6xdAlzSV/o7uWkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1440
Received-SPF: pass client-ip=2a01:111:f403:c214::1;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

> All these arch specific hacks should be moved to the arch specific
> makefiles. We do this for example for the sha1 alt builds.

Ack.

>> +EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-skip-syscalls-with-libsyscall.so
>> +
>> +else # CONFIG_PLUGIN=n
>> +# Do not build the syscall skipping test if it's not tested with a plugin
>> +# because it will simply return an error and fail the test.
>> +MULTIARCH_TESTS := $(filter-out "test-plugin-skip-syscalls", $(MULTIARCH_TESTS))
>> +
> 
> rather than filtering it out lets move it into a subdir (plugin-tests?)
> and conditionally include it like we do with linux above?

Good point, will do.

Best,
Florian

