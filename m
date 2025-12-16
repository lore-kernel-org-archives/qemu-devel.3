Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C27D5CC97
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 09:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVRYd-0000N1-BN; Tue, 16 Dec 2025 04:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vVRYb-0000M9-ME
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 04:41:25 -0500
Received: from
 mail-switzerlandnorthazon11020118.outbound.protection.outlook.com
 ([52.101.186.118] helo=ZRAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vVRYa-0000uk-4D
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 04:41:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnkdb6Sj2T0UFVIVGibD0NwMfFxRJ3FDpc8wXEKYfdlSFzIwZ9Mws2nEh2eyQ/TvFKyAENR3a5nlE7IxUUcdEmGgx2nVdlM+xPH0UycbmVV1Y2I0vU35meE1naRPkduWiSwhJdTsbt/szsAJZSNShukpAO5suYmFiOCspY15eLRGi5NVbDivQkyFrmMgUexMFIQL9ZhEEQc4LE4f9AFWVHr+TvVkXUKViDMIYGoarjgXfhylXwnyph0cHjkAfJJsWsOuBFZfMDCJsKlQip41f+UORzJ/oeOJsULmo+9Kk4ZldAn8yYSYdWOvFwKIsJlKJ1IHMSm2EFATyLnwhbaDQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3lTlNJ1rvdVLwKD0Wj3ZqC9ZasgP/eF/zmM1KtKJZs=;
 b=sFhmRe/bihqcyMpI2YfWuOc5vsJEbEIgTLlfGkpESPA1GMyO2tkgEcRdftPhh5fcJvhGGPT+mZJNS8n4yUIcbkZ83wr8GEzjHIF7EW7mNGmbIkh+1rI7U1YqG3pQK+aGK/sg+BiypYdy2g6INHh4BfSmy8LfVMMAZ511ghqxZsta3GhAcc6r+rA7JSWFzpLHfLPGRx8P42yS8dxUaG8V/1zmm3oze9l051V7OeJj5hQ5YRpyB40Tj96YywCDHfDBo/zcIHhsy6C16breDvlqWyvDZvgZN68dg4sRGsYSaTrB/tHDkoRcqOi+N3W8KK/TF+/CVbQU+2K1gv6xkzujXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3lTlNJ1rvdVLwKD0Wj3ZqC9ZasgP/eF/zmM1KtKJZs=;
 b=sETn6AfM/Aey0kBF45Fb+paJMnX6wsVLsELmwUsW7pBSQxh6v5hPzGvY1tq7glmcK+J4F7xbSOqVTW23aN4ljHAKXdaGWNR+p9iDHFBKWe0jTXucPh7BcdrXhs55G6UCI+2gDw7RO3d/mdi4+Ev0J4SGZTQcrCQ8cMDXo21czE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1440.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 09:36:18 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1%2]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 09:36:17 +0000
Message-ID: <0586445b-31fc-4c18-9dea-b3cdc973516b@epfl.ch>
Date: Tue, 16 Dec 2025 10:19:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/2] Enable PC diversion via the plugin API
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch>
 <f06e2059-9d86-4a5c-acff-84cbeabcfb06@epfl.ch>
 <87ikebucv4.fsf@draig.linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <87ikebucv4.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV0P278CA0060.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::11) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1440:EE_
X-MS-Office365-Filtering-Correlation-Id: 000df1bd-0d25-4caa-e727-08de3c86903c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|19092799006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEJucVlQRVk1RzgzVzZxMktnYTIwZkQrdEExdWdENGtOR2JNV1JIaDB2dDdw?=
 =?utf-8?B?RHZQN1VzQnlVYUZCc0VRWXBiZUErb0JvYVFUbWNrc25xdlVCNkZ1R3ZSNlpn?=
 =?utf-8?B?OVp3OWxPRXY3Tmh5SXBHbXJzRTFWQ2liWnI3Mlg1UjAzVFJUVTg1anFkaE9k?=
 =?utf-8?B?aUErS0hiNXNHT0VQLzRZKzcraHdmS3VrVytjTklxMmMrOUN2bVJoc2ozdHdi?=
 =?utf-8?B?Yk9UTTV0aStBaUc0VFZZVmcrT2JsRlpiSW5DZUdFT0lrdlNlUlo1NGk0V2ZG?=
 =?utf-8?B?bWxubkdWZHZvZzlFYUlDSDVIQWx6Q3RoLysxTFZVb3hhck9zTExXd3l0RVQr?=
 =?utf-8?B?SVZtN0phVzNiaDVpd2I1MHNoTU0xUkc5OExTVGJjQ21NUW83OUQ5eVduQXE1?=
 =?utf-8?B?QUo5b0E1WFNmbkpBYTJ4NkNlbmdMbmk1RjBsbnFzNlJNNGYybHJRd240VTVi?=
 =?utf-8?B?Mi9oOWdUb1FGMkNNQmdQZjkxV2d6MUxxOS9HR2FMalFBWS9xVFJnc3Z3MGds?=
 =?utf-8?B?eWdmTWF2aCtETnVQNThZZGlxdVc2eERyYnFINGo3OFFqYWU3NllZRG00dk5H?=
 =?utf-8?B?U3FmaEdaVzB3K1R4bmYvdlE2SENSOVdpOVkwdk1LOW5XQnM1bnFwOFBaeWlC?=
 =?utf-8?B?a054WEg2dWZlWVFhYUZuL25RdFlnWHdsTmZqcDJsNVNVTFlpS1JRMGs3Rjlu?=
 =?utf-8?B?QnFRTHBYZzkycndmQmEvNUE0Wmd0cG9qWUlEREpWbUc3UWZxR1JaelhwbUQw?=
 =?utf-8?B?SXM4RXZLT3ZwK3VJSkVteEVncG94Y1hMTE82aGJoUm82UWZCcUtxNHRXWm5C?=
 =?utf-8?B?Um5SenAza2NwT0E0U2V0Q21pa1BjMmM1MFVaOXFRcGs5aUZUczkxWitLSnV2?=
 =?utf-8?B?aUFMenphSFc5VFdVcUJUa0lmTXhTUm5mU3hzaWNxUVVlcWpSZzc4aERBN1kr?=
 =?utf-8?B?bkthU1VEQUVvY1dUNG5kSTNzcVVPK1NUYWtJaFh6U0pTcCtMZUNmYUFhRjFr?=
 =?utf-8?B?RXFEcTVZcTd3SEt6Y3JoVEVVSmRhYkpNRWJFN1N6TjJjTVE4SWdXYW52eTcy?=
 =?utf-8?B?N2dpWXcrMUNQcy9HdXd2Z1NJTkcxbkNyZ2pOUXluc3p1QkNKQ0JUZFVxeXFW?=
 =?utf-8?B?dzlOVVU0MWtlU2RXa2UyU2hkUjJHc0NyU2lXais0YUVnNUgwUHllL3NVMjdP?=
 =?utf-8?B?dFJCWXdSTmhKM2F4eGloeDhSalBvOG1EMkFHRjBGOWhFZE1yNWZEdnNEMFdS?=
 =?utf-8?B?MmFoL0laQTBtMmN4aTJKZlZ5UHNNazVrc05Ja1BmSVAzamNpMjI1d0RzeDUv?=
 =?utf-8?B?NTZGR2NvR044NEI1TGJ1dS93cXNGdFh4ek05M0xUS1lKUzJ2N2VZSGxzODAz?=
 =?utf-8?B?ODFIVzZiaEpOcGN5TVhUTjFSWTJoSzZFYlNrSHVyYmFYcy9ZMEgwcUVKcHR3?=
 =?utf-8?B?aWhaclNUVWdlWEg1ZGFpdFdnNE91R3JuSCt1d1NibGdRU0lacHJTc2IwMWVP?=
 =?utf-8?B?WTFYN1FUakZSNzdJZnJncGl3Y0Z3NytxOXB0TlNSc2FsTUtJUGwyTDd4Qjh3?=
 =?utf-8?B?dnhvZjNwS0o4aFpXcXFsOXEwb2xIMjVNaCswdS9OUFRwU3M2YWJJWVlEZFdU?=
 =?utf-8?B?YVM2STd6RkVqMVBkcllJeEN2VVI0RXpJK3V2L0ZyRzQrM1pFaXRDREZhK29z?=
 =?utf-8?B?Y0E0b3BaOWRZdGVYOUxVNjl6ZFVCR1lqTmJEVVd6NGRpVTl1K1F6bEN0SDFv?=
 =?utf-8?B?K21xaEdQRDhKNVo5bGw1M3JhUUlwbEpFR2lUY29KUUwyTzJuamZ0enFDdHVq?=
 =?utf-8?B?S0NVeVdteEVtVlBWbmFNTVVZZThFbGRnaTRYZUZGQkU2Qnk5UkpQWGtTZm5p?=
 =?utf-8?B?UkJ5dXZRQ1g5NzZ6MXdkeHNTbithRFVSYlpFdFo0ZjFPck1weVdxTmFFcjNH?=
 =?utf-8?Q?isGxjjeh0V6OVCJz8RXmJlxm99GntIgT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(19092799006); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2Qyc1JicFlnMEloV2hkUTdhSXBOMU1rZzdTSlczNmhhOU9SMVlsQ29EZkdo?=
 =?utf-8?B?SFpWMjYveGFNYktnMHBkMkdnbkk3V0ZnamlvZ3FGb3R6bFRpQUxyZnZ5bExO?=
 =?utf-8?B?b2lxVmlNQU1uWUI2MmhRdkJ6Q0c3dTdDV1NCcUM1aWVoYWFRbnVIdGpnbnl1?=
 =?utf-8?B?TlgrUHk4cXpuZ1JFN01WZ0dIQngxUXZJVm1XQkVGL2pEaCs0SkJ4RlU0WXVz?=
 =?utf-8?B?WFNzRFBaNTlOYmZ1R1BwWjQxUGMzdmt6ZlF3NUJ6Mm04cUZvWmYxQjNaUVF6?=
 =?utf-8?B?OFVoTHRLVm5KQnYxb1owWXY1azNUUFdYUUwvdHZhcVhNbnpVSmJLQmtPSmxa?=
 =?utf-8?B?K2NWQlRJdmQ5RW9CNDRwRzF3RzJkT1pJZWtaMGViOFVYTnk2dUtFemU4OTlt?=
 =?utf-8?B?aWw3cm5NNHVlRkFmbkI4RFlzWkp1bXA4V1ArR2hRK0tpRXRQS2ZiMHA0OXpT?=
 =?utf-8?B?V2loK0RQZ3JIWGQrL1M1QnVPYjBOWG9iclpaem5DcklKbTFubUJaVXF2b3l5?=
 =?utf-8?B?ajlGQmtyeUpSK2Z5SHNCSjRqR1N5bG9PSVk0UnlGYVN3aXhvaVFEdUIwd2lz?=
 =?utf-8?B?clhpRHNaZWRBSVZ4WGFXMHJnSm1KaUhKcGxTVWU2YUwxTTVQZUtRRmhnd2Nh?=
 =?utf-8?B?RW4ycmV1bFVmWVVteUNuUXdnaklreWNTeG1MeXlObFdlREdueE9QWnVkMjZD?=
 =?utf-8?B?SVZrckxYV1VSbWQ0UXZMRGtaWXFuYWFqd1lJdnpVbDZ3WnlVQUo4d2JGZFlT?=
 =?utf-8?B?eUd6TlM5Z1R2aXY0SDRXYThqT0ZpTWkzc0NNVUh4dmlkelV0bDQrcXFGMFlB?=
 =?utf-8?B?TkMxeXhwSEdLNGZDZnFsRGdJbFlzbmpnMlZhN1kxbFZBME5lTGJWVWo5MGpv?=
 =?utf-8?B?VVVnUlVuWGpLVHRoYVovcnB3VXI2cENNdHlyZ0JyL3JZZ3htZ1BhT3BjVS9i?=
 =?utf-8?B?QjVjTnZIdlhJRWJDdEpCR2tBbnBDTS9hVWFncTZ3TEF6UGF4L3dTcW5GSkZG?=
 =?utf-8?B?dXhXR1ovb1pNTW5mUHNzR3pWMDVzS1dvVnNqeEl1ek5wZnBpSlJLWWVBKzB3?=
 =?utf-8?B?RWRaOXdhcWlsT211V2xXRi8rcEhCeUJ5R2FGOGE1K0w1R3dPN0ZzVEh6MUpM?=
 =?utf-8?B?N0dIWVFCYlkvcWxEMlNjNS9uNjgyVjV2emEwNW04Y09JbFhrNDN5L2czYWd6?=
 =?utf-8?B?cU1YVjRBbngvQ1dDbkVrVW9qOEpHamh2WGhkSkxQandmRktRaldxeGIxcms0?=
 =?utf-8?B?VVVQaDdPc0dOYm1HcjZTUWc4VUQvbUd4aS9yRURmN0ZYUGkzZkFJZWZsYXNX?=
 =?utf-8?B?VCsycTR5eDdSaHFsdTl1OHgyYUdzU1c2WnZhajUvRnVmbTFJS0FYVUQ0MFJK?=
 =?utf-8?B?Y3IwOXR0amo0YWtYTkNZM3drdlBVNzBFTWdxeDl3ODU4Ym9oaENJdWVXOXIv?=
 =?utf-8?B?REpCTTZsVlAyQSt2eVdkV0FiWEFYRzZvYzNWVnNMZTZRRnd6K3VGa2lzaTk0?=
 =?utf-8?B?UUdlc2dBSkhZanJYME5xSkREcGhWUFZLUWY1Ym5BeE5OT3pQTDdaNGxZVitY?=
 =?utf-8?B?ZDM3NDFtVlprb1czd1FZOStKendMQSt0SW1ULzhZQ3B2T3RXZlFGYWZwQUtI?=
 =?utf-8?B?SFJ6R05BVFpzanQyRTVJYXV0dmRkT1dycUJVd0FOb3BLTHJrMXp2VHBlMUJC?=
 =?utf-8?B?UW9mN1djRzgxQVQvWlI2TE8xUUdocUJyMk5jWXczN1lOVTV5dWJWZW1xUDRx?=
 =?utf-8?B?bTQxUlRNRWNXTDZ6c1lSMjhQL1NpVXpoaFNGcnBvT0NkUkh4M0hGL1VGeng5?=
 =?utf-8?B?bkQ0U2d1UjNPWlJIaUNLMHFJdStPbk5XTVZkNm95Nk9hZ3VXTzUwMVZJaTR3?=
 =?utf-8?B?QU9kQzljN1Q2ZFdObEwyRmFYZUh4MStLbzNNeGlXZmkzSWJ5MmRiWDZyRVNm?=
 =?utf-8?B?NEowalBzMUxUMzNNcmtzUTVCUkhabTVhZWljTUZETzJHWmo0RmR3R2Y4ZkVS?=
 =?utf-8?B?MHFPWVl3WnhpTnNSdUxBdlVPVW9IbHprSFpQVVlHZWZ6ajlCbkp0d0diQTFK?=
 =?utf-8?B?VXgrSDBEc1RQMDF4RUc3Y2lYbEVzcE94MkpRQ09yOUdTUWFXU2NIUytEdHpD?=
 =?utf-8?B?VXJvd3NhMlBEQThNYnVsNXFvSFZBNm41RkpCZ005TXRxajNWbWVzZjdzUk96?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 000df1bd-0d25-4caa-e727-08de3c86903c
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:36:17.8511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsSUb00tlaaFrQFy0VrFoCQHNbHQjQ/+xUHWlvMfRWMeXeH+jZeMNItARhGCTTfniSPXtXjhDxpOLrrfecynOnfgWXhaaP2zcQavh/1xIVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1440
Received-SPF: pass client-ip=52.101.186.118;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 12/12/2025 13:02, Alex Bennée wrote:
> Florian Hofhammer <florian.hofhammer@epfl.ch> writes:
> 
>> Hi,
>>
>> Sorry for necrobumping this thread. I just wanted to follow up on this
>> and ask if there is still interest in this plugin API extension or if it
>> is going to be dropped in favor of the Lorelei patches (which would also
>> fulfill my original use case).
> 
> These are the system call filter patches?
> 
> I guess that depends on if being able to change PC is only for skipping
> syscalls?

Yes, the Lorelei patches are the syscall filter patches.

This was my original use case as well, but I think diverting control
flow outside of that use case can be useful as well (e.g., to divert
control flow to a different library function implementation when things
like LD_PRELOAD are not an option).

Best,
Florian

