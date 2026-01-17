Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAB2C9832F
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 18:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhAY2-0004Qs-6J; Sat, 17 Jan 2026 12:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vhAXn-0004OK-8o
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 12:57:03 -0500
Received: from
 mail-switzerlandnorthazon11021118.outbound.protection.outlook.com
 ([40.107.167.118] helo=ZRZP278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vhAXh-0008Fc-KU
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 12:56:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xF7zqeJVvrRTyqWg9kVglBoFSw4fi8ziUSABUg0zP+g22y/ulR80D/DKURCu0n/h+AG1sxdWYWtZA3PtiGp3m7QKWWmadszhJxf3paz7QTBZQ8WPQeCBjzoi0ueFqn0GIYjkPDggctLhTkpdFENTpXIiPs+Y4X7AQqYLo7p48WEePlngG7mjIWuIBIMYuv/3ZxLMdNrI1IwJnzmT+JS6Ej6EL2Snfi01k7vg0/cm30nP0XU2JJQDqRpao520Y6nCuGerg1idg4pjXonMh8g6eIw5282LQ/8W+HqIukXiWfcf/VOBxc0uagVa+KXQpftUnJHaGQUFxW4FoL4sUtln0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eN1Cf4T8NjkjhAZ4C0ZV8b+vQetAVJ3B0Xwfi1tyVN4=;
 b=f+uWvy+yZ2Ouu7KzKhfRLPzEpKW7afQm6mHlB/nApUsMt2MX/wmQJdSJ8Adjg8LoJ6OTqkBK4Xq3w7Hu2heHgnpiV7G8+JcqMfk/Qo8vAWyaFEp3mYVKxP3ymQ4nLFo6OI2zf6J3dNEEpTRll27qLsVKIf1god5+oKvWSlUDVeelufTyjhVRKPiLcBDUPAXOx/1FKo/jVbKDeQbA2r9ZP5cs0yxIUOek19FIBoBnO9AXtRNEXDOh4C5XeeRAJ6GuVXrV+un38Kz2CdOBU8vySuq4lQRkU5ReOx+rZVNy6nltR4YZCkSiVGvBytYBNxrmt/jGZ22GDJzscdZghZUHZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eN1Cf4T8NjkjhAZ4C0ZV8b+vQetAVJ3B0Xwfi1tyVN4=;
 b=kEDV5hiGq/ZVZBJnyiLoTA0KcDgYZrdA4gzbap0PONOGZ3j/1E90/rszp4clKsoMvPqC8mQBPizd/LlBhNls3MhRmiMiW2x199KgUEIXAw5iDaT5cU6fDqHyp0+dEJM5O0TUb6FXtxja3rYAIoOjWgxY9T7kW0O7OIftFaZVF/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR5P278MB2102.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sat, 17 Jan
 2026 17:51:49 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1%2]) with mapi id 15.20.9520.009; Sat, 17 Jan 2026
 17:51:49 +0000
Message-ID: <9c71b7dc-ec43-4726-a868-c1c3a3ce3ba1@epfl.ch>
Date: Sat, 17 Jan 2026 18:51:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial] plugins: correct docstring for write_register API
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <60089475-3891-4448-bfe0-8dd698cd2435@epfl.ch>
 <0d32ba74-9171-425d-ac0e-1303d6ca154a@linaro.org>
 <0458a52c-b86b-43e8-84f6-ec75b012a9a2@epfl.ch>
 <3d9c9fbe-711c-4be1-84f6-5fa3cc18d2a8@linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <3d9c9fbe-711c-4be1-84f6-5fa3cc18d2a8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0043.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::12) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR5P278MB2102:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d913f55-1cd6-4d41-11bb-08de55f116db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|786006|19092799006|376014|366016|10070799003|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTgwM1ExbkZ6ZTBqV3VTUlEwT05MUXZJU2IvTVBVeWRLcEVkQUw3QmRzbXNL?=
 =?utf-8?B?NzZpbVBqa1JrZTV3OE1FdkFtQnczdXYwdkZrbEJlWmxNZThFZTNnS010WVVy?=
 =?utf-8?B?SFM5VlNSa2RraXI1ODJWdEhheThjR05pRFhZRWxjYUJrc0lxT1c4Vi9sd0J4?=
 =?utf-8?B?MWo4RmtlWDNTRWUvSkVKQ3dDYjFkSzBZYTFkdnNWc3NRVElWbERGUFN0YWQ5?=
 =?utf-8?B?M3lRc3hTTGNtVGtJSllGNG5tcU5GVUl1aDZxakZLY1NTWGtSbkp6Q2RHd3pk?=
 =?utf-8?B?RlpMZG1LOXJKN2hyM3lzODhVS3VFRFFKeE9GVDlnZlZoL3BSUmN0SW1OUDVh?=
 =?utf-8?B?K1B4RWhidnRBUHlMcG9vMWxQeWhtYmpUL2E2ZzVoNmcwL1l3cnJxNjVRQ1lm?=
 =?utf-8?B?OS9mS3lUbU9lSkJ1VmV5cDVHT24wV0daV3owNFc2QVFtbCtPZ01zcUN2MDRC?=
 =?utf-8?B?dXFSNXV0YlVJblFrZlRlL05IalZGUmlUa3JNTllIcDZBUWw1RHBWR21NTUk5?=
 =?utf-8?B?NENjOWowV0ZYTTZiWDRnYTJIbmtSSzRoK2prWWZQbHFIVGI1TmoxSXAyQk1Q?=
 =?utf-8?B?VVU1RHdlQ0pLdUw2MnpOUzV2SzJGbmVnZ0VYcmZ4a2RZTm05cEdHM3phY3ZI?=
 =?utf-8?B?UWtVdXFmUGVod1VxUU5tQ0k5ZXo0VXg4UkN0SDViSDJNNnRZdGpDaUR2SjQz?=
 =?utf-8?B?Sytsb1REbkxBT0htU2xHNWZ1OTRJRXBRckhDL1dTdWFEKzJUd0ZZN0N5OWJt?=
 =?utf-8?B?K1dnTmd1TnRtcTh0bjB0S1pac1RyUXcrUmpqSHk1ZjRybzNxck9MdlJvMjFv?=
 =?utf-8?B?MnlmZVl4UDhqODM3N29ac295cHhNUGgxUUlHOGpiOEVtV25naUhqZklTeGE4?=
 =?utf-8?B?bXNKV21odmJvTHVLdkRqS21OM3VxSW1XY211Y0VyTkppQlVIbHU2R3Y2eGpQ?=
 =?utf-8?B?YjExcElIWitsS2lDbmY1b0IreGMramlWUVJmMFNHVDBDdVd0OUNYRDY1V1Nv?=
 =?utf-8?B?UGZ5VGFyMVBuNmhybldqbGVUK3ZKRXlVT0xYb0QwL3JYQnpycGVPV0FoalU5?=
 =?utf-8?B?VjVjVGUvbkdYQ1N2UnNzQ0RrbFdiV1RISEI0UlhDNHUyczY4WDNINGlvRXV2?=
 =?utf-8?B?NDZ3aUdwaEJSTWZDQ0g5cnVqUnhUUDhOdUxiL1ZxRDhPK0lCalFYdVhvVTcz?=
 =?utf-8?B?UytGMUlXRE9zSGhrMWpCM2xqLysyblBCaFJTRFVoSmtBVjVKdExLNzFLRU5U?=
 =?utf-8?B?V3pIZy9SdW9oTE9lZjdpcHJ0K1ZFM1hRSWxiS0FmM1JDRTdPYWdIb2Q0YnVQ?=
 =?utf-8?B?emF1MncweUI5UlFoaTloOXZtSGY4TzVjcWVObnpJMHRCMGJnNVZjNzVjTXhp?=
 =?utf-8?B?MzFtV1VPdDlyOXB2OUJHM2ZPeGV6Q3NLTE9VK3pkVjI0dzNidkdpc2o5Szl1?=
 =?utf-8?B?UmVMVFovUktadTZSMThYY2lERDVUOUV4a0xqNXBFTE1lUnNkdzFpeEs5UDFP?=
 =?utf-8?B?dHhFcis4bHYzendNSVJWWVV2elNKejdRL2FRVG96anp6UVJEUW5KZ0FQMXBO?=
 =?utf-8?B?emVUVGlPRmIzZitvcG1yK3I3dEFISCt6TStRL1FqbWJRU3FJMWZzZ1JtVk5J?=
 =?utf-8?B?Uk81dmRqUlNYcmdSZlhOVElaZ0xScGZKbjBoeE1rOWtyUHlBaUhCVFo5VG45?=
 =?utf-8?B?SnJmbmxPZVlPQllGeUorc0hJV0ZmVlB3ZS9MU2ZIYkdzRlAxendsVWdDcnBa?=
 =?utf-8?B?WUcveVM0RXhYRU1wRDNFUS8rRzAzbXVXSHo2VzlySFZyZktnQXRXc1UwQWQ5?=
 =?utf-8?B?MGxIZnJFS1FtZzgzNnlsVGtxaVkvTkFmbCtiSGxtVW1QTmx2aU9td09IeVkr?=
 =?utf-8?B?V053NHNPem5SdVlaRGIxWU8xVEoyRUN2cDkyN0FxWjZMZmpUM2pPa21XTG0v?=
 =?utf-8?B?ZE5oVDlBNEtmNi92V1A4MG5Bc2I1WkF4RzJFUlpFSytFV2tMSWhGRURuWi9t?=
 =?utf-8?B?K0NGVjR1RktiSTFNYi9BeFhnR3UvU1F5V0F6NU1YWHVZNDhIMEpQLzB0SjB0?=
 =?utf-8?B?VzNta1ZxMmd4YnAwc3ZSK295NlNLSTA3ZWlXNEgwZmlXbzdXYm1Tb3ZXajVo?=
 =?utf-8?Q?UnlQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(19092799006)(376014)(366016)(10070799003)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OSttemQ3YXRYVkVRL2k4d2pJRTkyTHIzbmpRSlJ6N0pPbmVBWlluUG52ZkZ0?=
 =?utf-8?B?bXhHMWQ4MUdlZ3dKVHdLUFdMZ1M4dnA3WFVEYmV1Q3FuSlgvU3lmUlM4VzFM?=
 =?utf-8?B?RWNGMFRUTENyZS9iY1hBTU1mWU1pQnBPRVgzYk1WM3ozN1dMRFZBR1JvWjJZ?=
 =?utf-8?B?Z0IxZU03WVdZb1dOamw5d3QzcXJDaTc2ZzdyVEJJTUkzQkJLSWpHNGVLbFRK?=
 =?utf-8?B?VTVESWNXUDVwYjlhSVN3a1VQbkZvbXpCcVdTMHgvelQwOURSSUwzYzd6V090?=
 =?utf-8?B?ZzUxeCtwcGNydHlWODdCOHMwMCtaYVV3aldRQWZSWmpBWEpNcm04dGcwaVZ6?=
 =?utf-8?B?LzRBN1ZXNy9URWlDZ3JGb2NvZ05OZmZLQndXL3ZMY2ExRmZyUGgyQ3l5TUxH?=
 =?utf-8?B?TFNrektKSy9sZnRMVjB6bXZDK1JrR0k3VFpmdFJqa3hsa0lsYSt2NmJKMWFF?=
 =?utf-8?B?dkZza2VuZjhVLzNXUUp4T0t0V3AwMDNUSERoYkdnSFVXKzNqR1lEbkhiMlBQ?=
 =?utf-8?B?U2d4dVh6eEh6MzBBV3Q1dG1Bb3VTMStJQWIzdEJ5cDNqTm51TTdZQURoUXlN?=
 =?utf-8?B?dmRGZDNpZS80KzhhU3Nmc0Y1Sks1SkRJZjZEek0xdFVhdXE1ZGo0ZGt5NkxU?=
 =?utf-8?B?Yy9mVi9OeEFzdzcvVUMwM3MxbUZoNGxIelZLWlFRcGxETDFnanlTa2RubVFv?=
 =?utf-8?B?N29QRHpUVTR1N0lsQ2JnOUowOHpkWDNSbklUVVpTRFJrZnNTNEhlUmlOTlRG?=
 =?utf-8?B?MGVjVGsyblRxZmlhWENPeko2ZkZhOVVGKzgrZm9Vcnlid2haSForQkhDUHc3?=
 =?utf-8?B?Vi9GUEdWNWZ4SXhHSElXQ09FNG0wSTlraUNHeVRqdFpidFdiRnNSTUNtamg4?=
 =?utf-8?B?NmdscjNDMm9HSjVMMGZoMmZIeFZxTURJaVozcDBsS0IyakVRS0EzNUVTeFcw?=
 =?utf-8?B?ZTJlR1dzSzdiQmxvbnZRNWVtRmkxRUtJdmh5cEpLMmh5dzRYc29BNVlEcVdt?=
 =?utf-8?B?bDJGdXNIWldSU2p3SDIvdVRDVmUwd1NueHRtQ1RBUlE4WW1lVkxpV1pFOUpQ?=
 =?utf-8?B?Ty9FaTg2SlA0K1djWVJkVDVvUU4zSTUzS2g5Mld3a05TQVFjSXZ2dklyT3NQ?=
 =?utf-8?B?MlJqVEVZN21UdVcyMkhtcC9WNjJHTlk3Y3BndjJxVzR5NnFxVFp4cWJ5ZjBv?=
 =?utf-8?B?TVNvb0pJM1U2YW5HbmpLTzQ3UUYyczROLzdSSnlQaWV1SzBjNXZaTDg4d3pN?=
 =?utf-8?B?U0plVENlbmlTaDU2TnZrRkZyVW9QQTJIOXdHVVpzOFpiYVlJaUptaUJMM1hS?=
 =?utf-8?B?V0pnWEpqYTVPM01mcytEVjBRYWtpdGR0SlNjMHlFQ2krTlVQZXZGVVBmTmtL?=
 =?utf-8?B?VFpiRmdBcWpRc25oaGYxSENXcC9sYVIwUUg5eExJRmptd3NoaENRaGxYQVlH?=
 =?utf-8?B?MTdYei9kNnpZMDY0V1ltQ2xGVDNTUHhSb0MrYjVBempXeUpDRzcycXdtMVpt?=
 =?utf-8?B?ZDNKblJjUmZGS0FxdEQ3cHROenNFVVVGQ3JaaGJnWDZkV0h3ZDVLbkE0OVpv?=
 =?utf-8?B?RTAraWtMcXpIUThqckRUaEpRRmRqditTZTNnd2kwMXVnbTFZSGJOWGpJMGpp?=
 =?utf-8?B?QzNDRFBMUE5zQTd6R1FLRy9lcmR2UjV6M0IrVFJyNU1wYm5vZmZsQjJIajlF?=
 =?utf-8?B?blR0V0JzUDN5VlZEWkJ5QVQwV2VJZS9XMDZQcmdXMnJLeUpFVzN2L3ltcFZN?=
 =?utf-8?B?Y08wNjZtV3A0cVdiL05PbTYvVFp3Rkc1SkpqRlR5aWw4Y3lnS2l5QlVIM1V4?=
 =?utf-8?B?bXB2VTZJUVdyb1dLNmo3OHJnVTZSUTBZR0lybVJZV2dONldNSmo1TUd0encw?=
 =?utf-8?B?eVJPRDRXL2VCbzNQVzRZQys0R3hHN0E2THRyclpURmQ5ZW00QSs0VkJNTUFF?=
 =?utf-8?B?dWUzWWM3WFZBT2Ntd1JUaWxReEpxeDlmY2pab0RTWEpXcXNzcnIwUnZ0WWxJ?=
 =?utf-8?B?cjRMcjFPQUJMcWJKSlRSVWk0ZzlFa0JwT1J3L2UzWEJaSXluSFZqeHFKaWxz?=
 =?utf-8?B?TFVHUHBsc1NEa0FzcTJObk1JTy84eFdjQXFMaVl6d2pqSWdpd0p1ejJDZnhx?=
 =?utf-8?B?MEIrekNmM0l4ajZXL2IvTEVSSWNaUXVVNG5paGhkT0wzQjZMYWh0U1F2azAw?=
 =?utf-8?B?c3pKZ3MrMjZoUnQwSEt6TGppekJBZE1KNmJERElWM3dteDdiRXFGWDYzNDR3?=
 =?utf-8?B?Wjc4UnlkUVYzZVhVRXlqTU9NZWx1bFFjQTk3OEl0VUxKejBYVFZySVl2elVX?=
 =?utf-8?B?cjFUQWwzb0ZoUGxmdUhqbHF2RjE0UTdUS3NWQXVTcmxiNWd1SGpubHNCbjBM?=
 =?utf-8?Q?DTi6g/uE0OjenZGoggG4bAqx+/85URmMNyuy+FeGW/bgQ?=
X-MS-Exchange-AntiSpam-MessageData-1: i4oQAf6tfWNp4A==
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d913f55-1cd6-4d41-11bb-08de55f116db
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2026 17:51:49.4743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2Znfk1NqkNf1OCjxFF/muqxRKfcuTZexrD/I+vt13dsdeenAfRT3rQ1c8saXNr+UZ1ShKOeHrLYwgkTz0afylapp1DS06tUn6wvUBEl9F8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR5P278MB2102
Received-SPF: pass client-ip=40.107.167.118;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRZP278CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/01/2026 22:39, Pierrick Bouvier wrote:

> For sake of consistency, we should make this use the same interface than
> {read,write}_memory_vaddr, minus the len param.
> bool qemu_plugin_read_memory_vaddr(uint64_t addr,
>                                    GByteArray *data, size_t len);
> bool qemu_plugin_write_memory_vaddr(uint64_t addr,
>                                    GByteArray *data);
> 
> So it would be:
> bool qemu_plugin_read_register(uint64_t addr, GByteArray *data);
> bool qemu_plugin_write_register(uint64_t addr, GByteArray *data);
> 
> This is better and unambiguous, as no one needs a documentation to know what a bool return is, and data already holds the size information.

Sounds like a good idea. This would break existing plugins though, is
this acceptable? (Asking purely out of curiosity, as I'm not familiar
yet with the processes and policies around breaking changes in QEMU
development :))

> As well, writing this, I realized that existing write_register is broken by design: we never check the size of data array (except > 1) and blindly an arbitrary amount of memory from it, which is wrong.
> Even though the doc mentions it, we should just fix it, detect when size < reg_size, and return false.
> 
> This comes from the fact gdb_write_register itself has no notion of size and trust the pointer. so it would need another refactor also. And while at it, change gdb_{read,write}_register definition to return bool also.

gdb_read_register already takes a GByteArray, it would make sense to
also use GByteArray for gdb_write_register instead of a uint8_t* and use
the size of the array for sanity checks.
However, I'm not sure changing the return value to bool for those
internal functions makes sense, as other parts of the codebase rely on
the size information. E.g., handle_write_all_regs() in gdbstub/gdbstub.c
relies on the size returned by gdb_write_register() to know how far to
offset into the packet data it received from GDB, as GDB does not send
register size information when writing multiple registers via a 'G'
packet (just a flat byte stream with the register values concatenated).

> I think it pushes a lot of changes just for a simple comment change, so I would understand if you don't want to do this whole refactoring beyond plugins interface. I can pick it up, or let you work on it if you have time/interest. Feel free to let us know.

I'd be happy to handle this!

Best regards,
Florian

