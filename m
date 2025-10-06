Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94F1CCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 13:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5lEm-0002r2-7o; Mon, 06 Oct 2025 09:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1v5lEk-0002qc-KT
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 09:26:46 -0400
Received: from
 mail-switzerlandnorthazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c213::2] helo=ZRZP278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1v5lEf-0004fB-Q1
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 09:26:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJiQKDNeEIil3l5malTniSb8OiA9KB+S20KbXyJHskgK3Nh08v1wKqgEe7np+1BGAY/5WAxv4CWaoypMMjQPoJjZMeL2kJAW2zxc8vecR/nMP9uNsnUQ7dGzV420NDfgOtwWmlZfPmseJkyfjxvGgAyX7z/qNHVGPIYqEszX1qa320SCCJ5hDjjaEBL1GNY5hBkcrzxQGCAqljfqdeQxzKFNa00QfPdJ13Zrou1o0g/25qwyi01o8PD2Y3x7I551zQntEU6LptOnIrtX0sAAmbrdX4MQA5AYjj94R8MWqQT2yBewPZlVDbryEXdO0+tg0v0W9DKkUl1Wu6zrFq7d4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjqS2XIBgPhKufWoNgOfKU+W1CXEV4ZjZMDlUuyz0iA=;
 b=ZOJVF2MefoTvdGZ0x5ku+/gTB4P6FpYaKLTo5CcMxFL5NmtHJtUqf1pkKPbl4eONWDMFcOgt5QT7DPlLlavVp/Ek2qHJMeW0lEon2MgYkejwVVSR0c6v7n1P2aCL7DSP8QkNLbd+f9gQYLXWP8owatnlrxgACcdchvPsZET3jW6H84qhIqvP3cvviG/eIIxvy0xL7CcPIyXgghtxHdewKRM5EWZzzzIhxZPaLkzM8XKl2jck7VJYPHW0Q+VudZpr06q90e8VJo0cSvwlo8CucyRMDf3HQmhah9o5UKVsqdHIo4MN/AYut7QovBNg4ylKDB++t0fJZVBUgHJPImdB4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjqS2XIBgPhKufWoNgOfKU+W1CXEV4ZjZMDlUuyz0iA=;
 b=gfXxw9+Bwj2TU0VyQK1TZ+5IcgYO3eONpROFV+s9+K0X/mFhFqCvFlxsLCho8jLBDp307O00XZjmgwC1+JuZ8jZSbNjucERSlMHAaXCm4ZuRQiiWFUAKTbnVMTG+uhZrrqxVC13RSxDYwyYc21L244a4bUsCrn4BfhA7ZCij8n8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV0P278MB1185.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:5b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 13:25:48 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::db00:2f5f:f4ca:ef69]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::db00:2f5f:f4ca:ef69%7]) with mapi id 15.20.9137.012; Mon, 6 Oct 2025
 13:25:45 +0000
Message-ID: <0b65f1ca-c960-4d9a-9029-23974218da80@epfl.ch>
Date: Mon, 6 Oct 2025 15:23:18 +0200
User-Agent: Mozilla Thunderbird
Subject: [RFC PATCH v2 2/2] tests/tcg: add test for qemu_plugin_set_pc API
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
References: <e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch>
Content-Language: en-US
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::16) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB1185:EE_
X-MS-Office365-Filtering-Correlation-Id: 84fddb74-3862-431a-a6a4-08de04dbdb55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|19092799006|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mi83TzMxL0VLSXg4cm5lbUVnV2RXMUlQMmpWeTV3d2Jucng3ck9zMm1ra2Rj?=
 =?utf-8?B?Zit4ZEtkU0RyTlUzaUVrSzJRUmlBS1BnVzhRNWZsK3Y2ZktZbU15bUwzZTNX?=
 =?utf-8?B?aWQ4N1QwWmpZWVpLNkpKSnBQRHhodjlIRlJkczhKL0RlUVBadVZKcG1CYThq?=
 =?utf-8?B?bVp4bzd1L2lhVlBIVWdOdWJ4aCtPZ28rZ1lGMmx4ZXlpNWs3S2RzcC8rSk0w?=
 =?utf-8?B?THpVWHRxQTBYZW1KR1FTNFBHb3plUFZFMWVDbmVkby9zS0Fyc2IzczhBVlRx?=
 =?utf-8?B?bnROYzNnMzJCNXFYL2M4NzFqNFZUaVpVblpNY0tWNnVIWGdqbmFCUmdkT0hH?=
 =?utf-8?B?QVcvcEhjWm9SNEExV2tkbUN4b1lPSjlCNEp1ZFdPaEtUTmhyREdWYk1xdHls?=
 =?utf-8?B?Wkkwa2IxVEdTd0QyZVRCVDhadktJdHNMcGpobkpzNytQODVJMEtIK01qWldZ?=
 =?utf-8?B?K3BjbDNpcE52Nnc0L0xucGNuSCtyU2FId25ZUDZ3VEh1YnBrcUMvbjdWSWZn?=
 =?utf-8?B?UU1ZS0VzMHVoUG41dXRlNWx0VkdMd294L3NQM2lkVFd5Q21WVGRJWnp0MjQ5?=
 =?utf-8?B?TEhUZWNtd1lLZjNTeER3L29wckVWZHZBUDFkd3dGRVNJcmZFQzdzRHhVTjNv?=
 =?utf-8?B?MUNhM0czc0U2TWxVQXg2NndDVUordHRNZG5HaVZvdlJaZHZQc2paZUlXU3Bp?=
 =?utf-8?B?Nnp0cktnUzZNdWIvK3Y1TW80Qm14cDZPUGhKNXloNkVXaCtYOTFnZEYvcnN0?=
 =?utf-8?B?R0ZiMWlhVDZFUWtxa1RGbTM4TXpjK283L0crdW9lU3I5TW9ITXZLV0ZobUxk?=
 =?utf-8?B?OVpSRWZyR3lrcUtVbC8yRm9uMHFZbDVLVm1mUExKN21DVXpWcGdmNittV21k?=
 =?utf-8?B?T0dQcjdGcU56Z2JGYnErWEhScnYrNk5Uc3FYbjZ1SElzOTJCbllEaUJCZFJs?=
 =?utf-8?B?aUF1QVhyUTFyOE9UcXBJTGNLT2p0STdISTBNZWZUSWk3Ulh2QkcxNUZGRWhF?=
 =?utf-8?B?T2RuS0lPSmFGdG9udGpVR1hBQnFBL3AwVFZ2QUVFVTAyang4WnlCd1dYcnN6?=
 =?utf-8?B?UTNpNklNeXJnN3RjS0VZN0NMVjJzSlQ4TmU4cE45NlpxRmw1SXhWMDNsOW4y?=
 =?utf-8?B?UHd4N3RWTG14U3NhN2xHa1dhQ3QvYXVJZjhxR2pxOWxNVlFoa09sMnNVc3ZL?=
 =?utf-8?B?S215SlZCTWRUY3FyRVVRV1QzTHgycmc5dzNycHN6a0FwL0R2Sk9yUnArbjcz?=
 =?utf-8?B?RXpQSWtyT3hqUkt6SU94ZFBaSGs2eE5aKzdVc3VkMUdIdzJCd2U4R1ROT0pQ?=
 =?utf-8?B?KzRlWjFFS0sxMUFxUjQ0cldBVUlzT25tejJpdERnSmFXeHkzRFRNTTA4QzJ6?=
 =?utf-8?B?MFE4SG5GbXhRWTNrVTZPdFF4THdnZ2U0cjB3MGdta3ltZ29BNFZ2dzdPTjZ6?=
 =?utf-8?B?NnBzcTZER1FEY1ZkV0JKUmZpZkRwMFFWNmkyeFJRS0V0OG04Tm00M3czUmUz?=
 =?utf-8?B?djBoM1BJVThlcHZTTXN6aDNKckZON1VodTF4MHg3d2JNZ2ZmbThvb2RKcXhP?=
 =?utf-8?B?UHoxL1d4N2tLRG9PUmRtZy9CeXBOVTZHaitEZlVIWXg4QXlWR0M2Q0htY0p2?=
 =?utf-8?B?NG9HcEsyQ1pVNTdLellYNTQvdnFMSmEvQjhkaC9YUXcwcHpHSWViMFh5WFly?=
 =?utf-8?B?dDJ2cmg5QU55Ny9hbk9sakI2Q3hGaVFxN2xZM09oai83Zjc3ckJIWkVKMDNn?=
 =?utf-8?B?OXFhNGx4aWpMRnJmMDM2bVJSNmFYL1hZMElpL3RRS2tUOWhkV3M2bmVkNEUz?=
 =?utf-8?B?ZFVxNUpxTzZHMitFajdWTXREbTc4UGhRNlhaeFM2akp6NUNCS3U4TnVONjY2?=
 =?utf-8?B?Q2F5MVVGTTlJRC9SVG9aRlo5TjZkaVM5dGR5cjBYeHVjYUwwczJhYmtnR3oz?=
 =?utf-8?Q?LEi1Nvx5g8YXizUi9N4VpS5Msb1Fc0lL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHBTdnhzWkcrQnBtOHgySEFTWjZ3Y3ZXNnY0MFRpZVN2MXdqRFV1Zmxza0N5?=
 =?utf-8?B?eXREcFpUU1Y5SmVKd0d1V2xydGVWeXIxeGtVWVpCQldIV1k3ZE1nQU5CL01F?=
 =?utf-8?B?alVUaHFZOGN5MFJlSzA3VlVHSWswcitXTzZ3dml4NjE3Yi9HMnF6WEIyckg0?=
 =?utf-8?B?UnBKaHBmeHVwMEpxMTMxbjYrWlBJa1JpUzhnM21ZcHlqNU13NXZIaG10NjRR?=
 =?utf-8?B?dlR0eFo0R012VGRxMUhwRDNWUCtKU3BkZEt5bFZnR3dQRFk5OXdNYmVIeUZp?=
 =?utf-8?B?S3ZTaEFRWjFxL0dNbXpjNnFIREpZWFRjZVdhZE83amNWM0Q3L0o3UFkxWUQ0?=
 =?utf-8?B?VXRSSmJpM1N4bmFKck1VN0R2aUN0NzZPVUZVWmhoU08rbjBPbHU1WXI5dk56?=
 =?utf-8?B?WW44c2IxY2RmZEdYeGovbi9qWjRyakprVjdQM1ZzeE1nUGUwaGpNUHpmRVV2?=
 =?utf-8?B?K01OeVpqSlovUDFIZzluTEEvWEJYWXNQbEpNN01rU3E4cVRFb2UzcEtJS0oy?=
 =?utf-8?B?QmtZOWVrbW1pZkZiNG5YaEExWE5SZDhhT2JTam1KNHFROTJmdVF2OHVnWEdw?=
 =?utf-8?B?aS95NENHVE5wRzBXdG4wc0VUaHlldXltQXhGNjBpMmJWV0FVSzJ1a1VUZURS?=
 =?utf-8?B?TFRIT1V5VlhPVHR6NFZQMmwyaDVhRzdHTnBjZGlDRVhzbnFLOHA1aU1Yd1VB?=
 =?utf-8?B?YTBSZ3dHbVppZzJmdm43RjZ1c2lZM1FaeWNmZzFoR2NsY1NTSW9laGp5KzE4?=
 =?utf-8?B?NFM5eHh6ekJza0ViZi9hWFFzQUhUT09ZbThUbjVKdHVSa2NiQlVzZ2o5Qm94?=
 =?utf-8?B?b0dkVTM1M0RKZjhLWDFBWm00bTJMeHFlUHB6VGVuSHhxZlVXOFBvYytLUVo1?=
 =?utf-8?B?TXRKUWp5Q2F3SUczK1ZSUVI3VllxZ3VsaTFuWEdacjBoUVJXNmV3cDlwQUdv?=
 =?utf-8?B?TzdEL1hOTXBVM2tsVDJCN2xaMUxtSSs3ZWRwb3RKeVVMbnBhNE50OHlqNC9T?=
 =?utf-8?B?QjNJU3htemxhZUM4T2hMY01ONlh1Y002TGFjckM4bFovNzB0WnRwa0Z6MitH?=
 =?utf-8?B?ZjF2OTM1b3NVdEowejBFallYMTNYNnBON3JzNzVYYVhVSmVmY3JaQkRwbllZ?=
 =?utf-8?B?V2VCeitCWjd1Rk1qTHl6RjBZQUlhSVJyaVpnRnpjVWZvZHlwQ3VHckZXSEJN?=
 =?utf-8?B?eEdiaGRZb3NBd2VMSUEvOWd4VERRWkZyV0tpeFFUTDFmWVZUa05rcEgyM1Nk?=
 =?utf-8?B?bkFDVGw1cGdHS3dNSzVsbVloUit0SEFXeXNrTkoxS21yLzdsMVFKV0hSczRY?=
 =?utf-8?B?dTJZdTVNbTU0T1JJSFN5c1R5Uzg0SkUyaEEzRnhma2grOU1HR0oyenlDcmNN?=
 =?utf-8?B?ZUpZdWx2MUZpcGtGd1pQMWRZNWdZNDgxQlVqVkxWK1I1UkV0N0lZK1VLMHdw?=
 =?utf-8?B?U0oxdUxtOGVqcFRIazhlczJNYkR4NlNzT3JTMnpjWUlFdFF4eUhUc3NiR0Vl?=
 =?utf-8?B?SGMxMDRHQmkrSngvSWVER0VxRGhVMVMwN2R3SGx5VXpVMFp0cko5RXdOQlN3?=
 =?utf-8?B?bHp4WG1SZWVZc3FJendLblY0R3hIeVIzNnhHSmMzbDVOMnovblhEQzl6T1pq?=
 =?utf-8?B?UkVCWFBCQ0Y3Qy8zeTQzMzZQTTl4a1JqL2ovWGIxZFVKenlKd2JyZUNDck5y?=
 =?utf-8?B?ZytLRlZiWi8waCtnVS9Rb0VQUEFFMno5bFkzQXQrelkrbFNZcjdqZFh6eHE5?=
 =?utf-8?B?Zm9NWSs4UWNMeS9ZRDZxajFjS0hDckRKcnYwakpjaUVCU3B0NVkyVEhBNytl?=
 =?utf-8?B?dk05ODFYWVhObFp5eWRQaWtzZGgxMGhTVG83Z2VxZFhEZkJEcm5UNjhINWRi?=
 =?utf-8?B?RWxwZWRwbFpGRmo3K0MvYlU0MzZNT1pEcUJOcFJCOEZRK3NMNlZZdTE4eFh1?=
 =?utf-8?B?SFhhSkdncXlESVlwUVAxbnJHbzBlc1cxUTZaZERJVk5KMmsreXE3ais2RGRZ?=
 =?utf-8?B?b1JQMkcyQU1QRGQ3UVh3aUptRlBwN2Y2RCtlRUVVYSszenFoc2V1M0JTdklO?=
 =?utf-8?B?NE4xQVhXUUpuTUlzeGJzREdORDlmRTBLTUxjTklrbWhBdlJTNU83aTZITUVQ?=
 =?utf-8?B?cmFxM1RiWnYzOHYrbE91Yms3M1A0dEJuYVNHVUNkeGxQR3U5d0xmRG1LZXpL?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fddb74-3862-431a-a6a4-08de04dbdb55
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 13:25:45.8714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOsPbHQpcs3irf0/JFiYHd1fbszsVITAYgXOAsEg3qnC/Z8Y0Ane4bP/Drd+ta+dNMEYV+5rLfUU0wN1NsuZYlQsw24kn2B43CQ4lz5pITE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1185
Received-SPF: pass client-ip=2a01:111:f403:c213::2;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRZP278CU001.outbound.protection.outlook.com
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

The test executes a non-existent syscall, which the syscall plugin
intercepts and redirects to a clean exit.
Due to architecture-specific quirks, the Makefile requires setting
specific compiler and linker flags for some architectures.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 tests/tcg/multiarch/Makefile.target           | 42 +++++++++++++++++++
 .../tcg/multiarch/test-plugin-skip-syscalls.c | 26 ++++++++++++
 tests/tcg/plugins/syscall.c                   |  6 +++
 3 files changed, 74 insertions(+)
 create mode 100644 tests/tcg/multiarch/test-plugin-skip-syscalls.c

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index f5b4d2b813..7df3da2aba 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -204,6 +204,48 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	$(QEMU) $<
 
 EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-mem-access-with-libmem.so
+
+# Test plugin control flow redirection by skipping system calls
+ifeq ($(TARGET),arm-linux-user)
+# Require emitting arm32 instructions, otherwise the vCPU might accidentally
+# try to execute Thumb instructions in arm32 mode after qemu_plugin_set_pc()
+test-plugin-skip-syscalls: CFLAGS+=-marm
+endif
+ifneq ($(filter mips64%-linux-user,$(TARGET)),)
+# Require no ABI calls to avoid $t9-relative .got address calculation
+test-plugin-skip-syscalls: CFLAGS+=-mno-abicalls -fno-pie
+test-plugin-skip-syscalls: LDFLAGS+=-no-pie
+endif
+ifneq ($(filter mips%-linux-user,\
+	   $(filter-out mips64%-linux-user,\
+	   $(TARGET))),)
+# qemu-mips(el) returns ENOSYS without triggering syscall plugin callbacks
+run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
+	$(call skip-test, $<, "qemu-mips(el) does not execute invalid syscalls")
+endif
+ifeq ($(TARGET),sparc64-linux-user)
+# The defined addresses for the binary are not aligned correctly for sparc64
+# but adjusting them breaks other architectures, so just skip it on sparc64.
+run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
+	$(call skip-test, $<, "qemu-sparc64 does not allow mapping at our given fixed address")
+endif
+ifeq ($(TARGET),hexagon-linux-user)
+# hexagon uses clang/lld which does not support -Ttext-segment but GNU ld does
+# not generally support --image-base.
+test-plugin-skip-syscalls: LDFLAGS+=-Wl,--image-base=0x40000
+else
+test-plugin-skip-syscalls: LDFLAGS+=-Wl,-Ttext-segment=0x40000
+endif
+test-plugin-skip-syscalls: LDFLAGS+=-Wl,--section-start,.redirect=0x20000
+run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
+
+EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-skip-syscalls-with-libsyscall.so
+
+else # CONFIG_PLUGIN=n
+# Do not build the syscall skipping test if it's not tested with a plugin
+# because it will simply return an error and fail the test.
+MULTIARCH_TESTS := $(filter-out "test-plugin-skip-syscalls", $(MULTIARCH_TESTS))
+
 endif
 
 # Update TESTS
diff --git a/tests/tcg/multiarch/test-plugin-skip-syscalls.c b/tests/tcg/multiarch/test-plugin-skip-syscalls.c
new file mode 100644
index 0000000000..1f5cbc3851
--- /dev/null
+++ b/tests/tcg/multiarch/test-plugin-skip-syscalls.c
@@ -0,0 +1,26 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This test attempts to execute an invalid syscall. The syscall test plugin
+ * should intercept this.
+ */
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+void exit_success(void) __attribute__((section(".redirect"), noinline,
+                                       noreturn, used));
+
+void exit_success(void) {
+    _exit(EXIT_SUCCESS);
+}
+
+int main(int argc, char *argv[]) {
+    long ret = syscall(0xc0deUL);
+    if (ret != 0L) {
+        perror("");
+    }
+    /* We should never get here */
+    return EXIT_FAILURE;
+}
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 42801f5c86..c5bac2d928 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -148,6 +148,12 @@ static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
             fprintf(stderr, "Error reading memory from vaddr %"PRIu64"\n", a2);
         }
     }
+
+    if (num == 0xc0deUL) {
+        /* Special syscall to test the control flow redirection functionality. */
+        qemu_plugin_outs("Marker syscall detected, jump to clean exit\n");
+        qemu_plugin_set_pc(0x20000);
+    }
 }
 
 static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_idx,
-- 
2.51.0


