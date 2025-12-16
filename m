Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA51D5CC95
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 09:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVRUH-000742-VT; Tue, 16 Dec 2025 04:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vVRUF-00073h-0h
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 04:36:55 -0500
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vVRUC-00084u-S5
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 04:36:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqcweXe6P3JL7vrOC8SDBZeVOHW7CluO8igoktgcZNlMYZaJcmKqHwEn6lzBLKBQPs3UJL1Nu0NYY9FdOaS2LFACWaUlu5hyGJmqVmT2rFum5awMMbvYvxlrlaiD10QY5XtBWtbBgQ/7l1EUHe2tJ9marA1saSXDa8IHUTEEna1VbdWxgsV7E3SA0g/gI8w7JH8l1IiMtU0/vjL2YIqAzJu9S8I7UnLuws/APrWbg5lZFtj20rpaQSbV5g3lUQIpt5LhDKnCobY2Dtu60cJ1G/i6qunAKBZMjkVWnTx+NfTbXmqdzvoPBUORpyoNRBYFeHXiobdleLZ4NXy3jsqpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aqro+m5tDnUQLBWj1p5TUAnEYqYDpb5P3SA1LbXZyk=;
 b=sFB1qCOKe7zdV57tdmT7EjQq5DVi3lOILJgLMoyohvb+P643FOHsppgaHKc42FCFnogAoPcGDFWMloPTlfK+8kyGUf6xhHzEF1NcGZZlLxbQR+h+N6XegcKHJMyiDBS36R+qty8q/cAMZyq1RXE4s08vAk/3gbe/iO3KEKaZ8bQkRdPRzEDvl2jHf1OryJXDdDJOhneEae/s/nxI7qD/Ezx3S6DLC9NoyvDlbm9anbe97nmZe/0iUS8KTLBwuOKqn2GGJZ0QQoKQZO3g3vFvSPFo45lAWPkRsJHSSl+Zc12rd16+ue7wpSgI99O9uTUyNuHcl96EtP37xjfRgqcXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aqro+m5tDnUQLBWj1p5TUAnEYqYDpb5P3SA1LbXZyk=;
 b=DijldAvE71+sdttc/dV59h/vp9wI98E/7bfhyW/YDZuehRycwykWbNyrenAzcGQa7GadWlPw+dRx9ee56ofyB/KivqTXMruaPnGY1yPW5cSoFv1v0yllsqWnWn7h7c733ZGai3TInxbRSjc80G3oNxfpfQnxShKBB79J54NJgto=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1440.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 09:36:19 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1%2]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 09:36:19 +0000
Message-ID: <341e0334-7bc3-4186-94c7-fba1c92cfc9d@epfl.ch>
Date: Tue, 16 Dec 2025 10:27:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] plugins: Add PC diversion API function
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch>
 <b461feb8-4ad5-481d-a497-dcb10b12ee79@epfl.ch>
 <87cy4jubc9.fsf@draig.linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <87cy4jubc9.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0060.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::11) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1440:EE_
X-MS-Office365-Filtering-Correlation-Id: 844dff6a-2fc4-483e-c60d-08de3c86911d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|19092799006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmdTc1JSdzZ2SklNR2gzaldNUzVUbnYzVnJxenEzcjFGa3FQVW9WR3hVdHJL?=
 =?utf-8?B?Qi9kajNVS3NKb1pqbnd0d1pZcEhPS1VLbGtrOXc3QlZqQ3Jqd1k5ZjlTVEJi?=
 =?utf-8?B?dUhnWWFWUDZxa1o5cFR1bWFmbk5FNWhaWFZjd1QrZ2RkUWxDZmhaMmlNakFY?=
 =?utf-8?B?cENQczRTa3NtOUV2RTFPZjk2L2lBRWRnUWNaakxDZnRtenNLd05qRmQ0b0Zn?=
 =?utf-8?B?YktrZW1peFJjaHp4RDRjMjV4SVRSTFBJeGpIbVlwMXN5dTg4QmhtTWprQnJL?=
 =?utf-8?B?NTlCMzFwY3FEUHBuUU9KTHdQWko1WEdnSXdXT0hnRmtmOHRHQVk2Z3ZjZVhJ?=
 =?utf-8?B?Smp3T1VKK3hBZ1ZBWEFobGE5d1V4WEdwYVUrUFFRdzR0ejBvblA5cjFicGpZ?=
 =?utf-8?B?TXcrSVEyWC9NVnNCWlZ4THBZMUlBRDVmcEZvd2RzS1FRNzBiUmFhWnBpUmdl?=
 =?utf-8?B?RVFUeHM3bUVnTjNtUitCelcxQjhoSThHcHpEWkRlRWk2VHlubkdscHNSSHIv?=
 =?utf-8?B?VXBiQ1FRVm9NRUVFVFZNSW5DT0ptZDFCN1RpNWdQMDBFVTJHS2haTTF4Vy9s?=
 =?utf-8?B?eDJYUGh0MWlRdnBrRkN4UmZZUUdreG1iQUVtV3hObW1TQlpxR2hGQWNTK2xm?=
 =?utf-8?B?TkQrbW8wdkV0NXc1NWlUNmlxejVEbmwrblg0bWhSVVIvY3R5S2Z2RUZ2K1Zl?=
 =?utf-8?B?Tm50c2dtQ0I5NXRraUg2TFF5Ymd5bk4rOE9LRWJLcGhHVnF4ZTNyUUN3a2M0?=
 =?utf-8?B?cmNvZEdZcWRrQTZSTmVTdXJmVHQ5cTcrWndQcWpJN1VhcWNWUTlra3ZGai9u?=
 =?utf-8?B?SEo5OE01RVAvRkVOMmw0ZCtEOXpibHVDc2Nya0RERFo2R1g5blhjREFyOVQz?=
 =?utf-8?B?cTl4NE5wN1hKa2NkbUoyQVF6dVRrTWV3a0srWUpMRXp4OFlRSDZTQjJaQlhL?=
 =?utf-8?B?K1lmcnRFWVBzd29sRngwWE9tY2tSNjVFMWxCRmVVQXZscFBrZmFpZVI0ejVs?=
 =?utf-8?B?VjZPbFM5dmxpZCsyVDRmZU1HYjRWcmJpdVZvY3VGTkVaL2xULzBLQUUxTXNh?=
 =?utf-8?B?QlQvYkJHUWNSM3lOQzFpMDI2T2NIRTJKamJhbjRJbzJ0bE9saHljN0t3NUlQ?=
 =?utf-8?B?aHd0NFFFdGc0VVlSYU9rRDI2aHEwazJTY1ppVXA1ZXc5ZnJXNzhsdFk1RlJv?=
 =?utf-8?B?WXBabWZKVGsvbTZOcTRmSHpaK29PaFZJS2p5N29pTXYxN1ZjUmxQZTk0Y3Uw?=
 =?utf-8?B?VlFacWd0S1ZsZUo4MWQwRDduSkxZUDlIeHMvclgzaWpLSy9BbXNmVXhUaytB?=
 =?utf-8?B?Y1luZzNFZ3IraUpIeUdvbSszSVRMSjRJSjBVV2toMTBNanJoNVJDQTZrU0Er?=
 =?utf-8?B?TjBQYUNIczVzd1gzZUpqU2luY2JrSVBpQ29QS25qV0NFQWFDNVJNY3RTdC9I?=
 =?utf-8?B?TmpFek1uWTg0M1FQYjFhRzlud2FjalBDd29sdkhyMGFsN0QvM2tXVkpiZGMv?=
 =?utf-8?B?eUhtSzJZWFdXMjZZaVdWQVlSSllZcGExV2VtRHRpa1ZKQ0NIZHZVbDhaZFB6?=
 =?utf-8?B?eVByVGUrNnlwcW5YTEp5QzVSbGtOUGZjQmRyeTJoUzdyMCtDcDFYbXRYRG5v?=
 =?utf-8?B?SitrOFBBRjl0Q2dIZUQ4clVaZ25SYTBVd294Z1RtQU05b0d1cTllMEV5c0Zq?=
 =?utf-8?B?U2VzU2sySVhpc2JUc1NDblVDMUg4dlI0NU5HOFZQQVRnVzlsRmxpNXZCTU9w?=
 =?utf-8?B?QXdOOWtjRmZiZGhLcFlMMGR2NVVlRU1xazNWcmZVN1RaS2JmREFsc3ZMV3Rm?=
 =?utf-8?B?RkJuWjJyNExwVWpvaFhuVi9RV1AydmNmQlZ3K20rOWp3VlRSZmlsNy9NZ3Qr?=
 =?utf-8?B?NE9OR1lVZGd4RThUblg1aE11cDhiUklGTHI5TWpWUE5TWHpiYjZZaVA5dDlE?=
 =?utf-8?Q?yyP6LuZxuPqeZvKfyYcFpCRc0gWW/2TJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(19092799006); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MENCRWk3cytpY1hEeUgwQVgyR3BtTlBwK25menA1OXltUklHSjhJMmhWL3dY?=
 =?utf-8?B?Q3BEYW9YdmxUTGhRa3BRYXpnczhhekJFQ3ZrV0ZhVHcxWG1rc1JRU0xHQ1d4?=
 =?utf-8?B?MWhSRXArSkJVMVpib3prY2F2OGszZjRYaU5Hekx5aXV4eFlPRzVxcFJ5R2Fr?=
 =?utf-8?B?TWRiZVhXSnQwTUswSjFDeldyZ2tOM2ZDTWxlOUloSGZaNURTYmpoL01Ub0t3?=
 =?utf-8?B?WVpQcHZTSTN5OHMxMVUxMDFGUDFwYVZueVNUM2xYN3hQUkw2MExNWVdybUE5?=
 =?utf-8?B?RHIwVDhMSGVOcEVPZEZqOThFc09FNE9rN1VhM3lEbUdvSzBCelJuck45UDNu?=
 =?utf-8?B?RGlVbFVmNlBIOE05MHFRNXVEOGp5V1JHSlNmdW02a3RTRVJTeU93bWZab2lk?=
 =?utf-8?B?K3RQdGc2bDNURlBOZTVwTzllbVBpamZ1a2ZYVENoRHFVVWVldkVKbjJqdWZC?=
 =?utf-8?B?ajdVTnpUSUtRVE5mc1pZVDFrcy94RzVoSEZybkREZm5RdXNqQWM2YUtsQ1Ft?=
 =?utf-8?B?TUEzZVRwcEF4bWNTUnFIR3djMG9CUEFQbUdGdlBnMit0ZWdkQytUKzIyU3JO?=
 =?utf-8?B?diszQk1KTU9vbGI3eVNyM01xVDl2aEsvblUxUFZjWjVocDB1VHBwOUNlOUFU?=
 =?utf-8?B?WGR1TU5KVVF3NUZJVjRNaW1kYitWTHFxZ1NPdVFnVE1pUFJmNE1mZWZuMThs?=
 =?utf-8?B?akNqekJMbXBza2gzL0JIbGV4dllPTEI5aXk4dFpvOTNKbkpPQmFHbXdveTZ5?=
 =?utf-8?B?eDJKZFNmL1BSR29GS0dCTmNNaEtzNDVEWnlCdDBoZldubHlrS3I3RnlnYm5N?=
 =?utf-8?B?ODlaRkFiVjgvRjJqbGJyNjl6MytiQXJiV2MrY0VyampYS2RsSDF2Y3FoQlJ5?=
 =?utf-8?B?WnFCLzh1aXVYUHM1RUFHaWU5MDBkOXNjV25DNFo4aHdid1hHZTA0RlBjOGEz?=
 =?utf-8?B?cDZWcnQvMFZMbDNDcXBQT2FIL0NHOVljYUc2Q0RJQk9LWmRTRTFhR0lnZklq?=
 =?utf-8?B?bHNUaHkrTWRuekpSang0cXQzSnZPZE9GczUrWUNlMStyWUhJak5PdmxjM2NP?=
 =?utf-8?B?U1l0Wkdoc21PYW9Bd3FDYzBxWVhwbmREOEtYYUJ2ckQraXpLb2FtbDA4YmNz?=
 =?utf-8?B?a3RJL1N5cUZSQTMrQkxHZTV5ZnA4L3dzdHRLdWE2V1ZKdFJKaGVqUG9QUjBN?=
 =?utf-8?B?bHZFbWcrWmZLZFFISGRqTjZkdkJaZ3RjS1NIeE1nRnFWK3c3S2xrcWpZaGJL?=
 =?utf-8?B?OHdHR05XOEQ5akNIeTVqd3FGS21weG5Cbnc3aUtyeGYzMlN2aFRMS01BZ21T?=
 =?utf-8?B?Z3dJdWlwRVpuVXlZc0UzU0s3TDMyeXZkdit3UkJ2c3ZESlpYTE5YcEVNMUpW?=
 =?utf-8?B?YnZmeTVxNzU0TjBlN0ZhMWwzYnY2TG9IL0Y0dlFrTGlpeGxKOERQU2lPb0s1?=
 =?utf-8?B?T1ovN0NGallSZVZsN3lkVjFqR1JLQVdodnFqU1ZOYStGSktzOU1nMllvS1ZM?=
 =?utf-8?B?QUpDbDZCRWYvbjloVjcrekJEUXJhRlRQOGZ1blZFdS96cU5vaFBWcXNvNCtI?=
 =?utf-8?B?bDR4QVE3a2dpaXp4dFkwWDhCWlAxSm1aZmZ2QWpzT3pCMDBXNElWbFR0Zmdt?=
 =?utf-8?B?Z3dFM29pVDJXd2lJVlVnbzBPWG1VQkVTQ3hVT05RYnBrYWFrSUxOZ1p5T2Zv?=
 =?utf-8?B?Z2hldjRyMnIrTndKNG93SFU4dFhHRkxjTFlZajgvQjIwUTdyY0o2RDArcEtL?=
 =?utf-8?B?MEZudlFIUmF2N2JZV2lWUmNCdWtqTktMcTRNQmQ4R2RLSmRmZlUwYmNSUVVG?=
 =?utf-8?B?Z1dlMEhuWndKUlRkVlYvY0dCV0RYaHhLNnc2MGZ2elUxampKWExSZXhac1lj?=
 =?utf-8?B?Q0lvRFJaRGdVSW02aFdEUkV6YmJ4UndNOTJBT1NCc0wyTEJrdHVFWndSREhX?=
 =?utf-8?B?eFVVWXNsWjM1SWR4eUtJQjgra243cHAvWTBVY1poaFRtUVBleDBuSGFBRWtm?=
 =?utf-8?B?c0VlTzY2TlA1TkIvRHpwYUNXaHgwSEhGd09ESHhxOWpJZWk4WW13dW9HNVRR?=
 =?utf-8?B?eWx5dGFVVDNwQXN1VkxGWGo1RXoyekIxMGVuenMvT2xlZVprTTRqZWtKRjd1?=
 =?utf-8?B?MEVvTENVRi81cTEvWjZrSVl3TUFqS2NqZmQyM0wvTjNOZ1lXZXY4bXYyUWJO?=
 =?utf-8?B?ekE9PQ==?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 844dff6a-2fc4-483e-c60d-08de3c86911d
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:36:19.2515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fw62oTHrVZhprtidqJKfwVtaDH/sQQS9biV5cGGdqMZMsehWoZQlyvx3OOs2O6/mWvtCahngOl/jMCr616L4w90WOEmSCASakYI09f7/dlg=
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

>> diff --git a/plugins/api.c b/plugins/api.c
>> index eac04cc1f6..fc19bdb40b 100644
>> --- a/plugins/api.c
>> +++ b/plugins/api.c
>> @@ -41,6 +41,7 @@
>>  #include "qemu/log.h"
>>  #include "system/memory.h"
>>  #include "tcg/tcg.h"
>> +#include "exec/cpu-common.h"
>>  #include "exec/gdbstub.h"
>>  #include "exec/target_page.h"
>>  #include "exec/translation-block.h"
>> @@ -450,13 +451,27 @@ int qemu_plugin_write_register(struct qemu_plugin_register *reg,
>>  {
>>      g_assert(current_cpu);
>>  
>> -    if (buf->len == 0 || qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS) {
>> +    if (buf->len == 0 || (
>> +                qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS
>> +                && qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC)) {
>>          return -1;
>>      }
> 
> If we are exposing a specific qemu_plugin_set_pc we should probably
> forbid setting it via write_register. Can we filter out the PC from the
> register list?

The qemu_plugin_write_register API silently swallows writes to the PC
even though such a write doesn't actually have an effect, so excluding
the PC here might make sense and I'm happy to update the patch
accordingly.
Are there other registers that should be excluded as well?
General-purpose register writes are visible to the guest immediately,
but what about special registers? Do writes to those actually always
have the intended effect or should they also be excluded here?

>>      return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1);
>>  }
>>  
>> +void qemu_plugin_set_pc(uint64_t vaddr)
>> +{
>> +    g_assert(current_cpu);
>> +
>> +    if (qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC) {
>> +        return;
>> +    }
> 
> Given we aggressively assert that some functions are called in the
> current_cpu context maybe we should do the same here? If the plugin
> tries to set the PC and it doesn't work what is going to happen?

Could you elaborate on that? I've added the g_assert(current_cpu) as in
other API functions, but I'm not sure what you mean beyond that.
As highlighted in the doc string (see below), the function already only
returns in case of errors, so the caller could just handle the error
case in code after the call to the API function.
I originally thought about adding a boolean return value to indicate
success or failure but given that the function only returns in case of
error, I considered that to be enough of a signal to the caller here.

>> +/**
>> + * qemu_plugin_set_pc() - set the program counter for the current vCPU
>> + *
>> + * @vaddr: the new virtual (guest) address for the program counter
>> + *
>> + * This function sets the program counter for the current vCPU to @vaddr and
>> + * resumes execution at that address. This function only returns in case of
>> + * errors.
>> + */
>> +QEMU_PLUGIN_API
>> +void qemu_plugin_set_pc(uint64_t vaddr);

Thanks,
Florian

