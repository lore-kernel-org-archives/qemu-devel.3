Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D354D2ED1E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 15:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viDiQ-0007dK-Kr; Tue, 20 Jan 2026 10:32:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1viDiM-0007XX-Rc
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 10:32:19 -0500
Received: from
 mail-switzerlandnorthazon11021087.outbound.protection.outlook.com
 ([40.107.167.87] helo=ZRZP278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1viDiJ-00084J-SL
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 10:32:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lk+WfcRCXmhHNKGBWbX2tKT8n0JDOTG68yq7k0N802pc8cP5t6Jpea68zp2+f4ZcyAy17n+h0C7LeaVilLfuD0HOPeEmH4tBHk/ALEjvI3QuaQqbvSSA38hvrbpHdUMk05Vy3v0dH1Dn5PpceCvSpoKagDzsxoZSiefeOeedEA8kYRsQYatBqeRYeCPVes7JzD65h1Vpymjn/HuqHCf6T+BZlgX+sBoG/NEuu1iKOSYffMqMDtlnysk/bRH4UI5H6NJQmcyMWKyycqjN/c7299ZGmsR1jfs1a9Geuhzs4y0ZHhsWW9srayFKJFPocXMPZUv9gh2xaeBuzFlYE50dfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTOQKcwkhmsfiCTtjr3SQmXiE5PJdL5sdw5P4xLuU6g=;
 b=gVj+Ha9QYTDcc9rjih4lgYtE75+2RNIXeYDaWh8OEsrfGqubD1TlM+Gk98LDgzMczQ3NpywyAQMQTUspRSiUyQwABWV/6lcjGho2g6GDV5VGVCZl1DeZASF1/oX6o4tym1JvMm/HVmxsLJruqns9TnMPNa7aCwg0mzpGpteg2ub5lK9o7UHmMwkEOrWPtyJFhpGVhq9rE4mQbV803tFej2ZRnpd0mWYL/HcMlZWtuNFKKnwMn/9pV8rK/5AZnXh6V5DvKfYxsuLX+T2u6l5cGl7bhk4jFqDlghanSMJmRXJwFPK8fLfH03giiBvXD0EgbTUqVkLIrFrRf5vhBCOTLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTOQKcwkhmsfiCTtjr3SQmXiE5PJdL5sdw5P4xLuU6g=;
 b=oGSON+3KfBd/Y86Pjbj0apR0AlXI2F/nqIYGC2JmmLCksyuIzYPJXClIMNMeTc1fvFDm1d3XWRzgjtv9Lo48LNe5xyxhzH+Ky2V9j5GHb6lloOuUp5DUu6Jod3AJ8G2MDalVSrNxBTcc50/rlKcT3nGOVJ+/yxRRu27B6urB4H4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR4P278MB1918.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 15:27:07 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1%2]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 15:27:06 +0000
Message-ID: <ef60bfbb-cc12-4411-acc1-8c131726f22e@epfl.ch>
Date: Tue, 20 Jan 2026 16:19:08 +0100
User-Agent: Mozilla Thunderbird
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Subject: [PATCH v3 0/5] Enable PC diversion via the plugin API
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
Content-Language: en-US
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::27) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR4P278MB1918:EE_
X-MS-Office365-Filtering-Correlation-Id: b4abc3ad-aaf2-4183-e300-08de58385ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|366016|1800799024|786006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ukl3SHlkKytBZzlyUzVPdkI1M01OY1JPWEJvZXZYb1pGTnVlYmExUitvemVq?=
 =?utf-8?B?blVlUGkzNWtpd0RRZlFLaHJiM25WUVNwQjB1eW9pTHFoeEFsU1FCbkdZTHJJ?=
 =?utf-8?B?ZWh1Y0hnZU5yMXJKaWd4ZjgyN0JnSmNoNFYwOVFTWU1OUXdCWFlkb2J3TGpw?=
 =?utf-8?B?bHdQZU5kZFdEM1FVQmtQNTJiSTZCUW5LTlRRVUVHbU1KUmFIcFUrMmd2Unli?=
 =?utf-8?B?VkVQbXpJRTNBZ0hXbC84K2p0emhyKzdtZ21nYVYyeVhpKzMyWU45NkNNTnJr?=
 =?utf-8?B?QWN6SGd5RkErdXZDWlN0UUJucXFKWlVnR1lpRzRJQTVtTzE0VHZjY2l0RFFK?=
 =?utf-8?B?UE0ydE9FNEhaajl4WllwSC9JZStTYU1VbTBIREJoOHVBbDJEUWx3VDN2SVE1?=
 =?utf-8?B?NCtheHpZWWJXRm5tZzVUWHVNRExydkJQZk80R2JoWW96L2h1TFlJMlBMcmhO?=
 =?utf-8?B?cjFueHpRZUdPTmhpejJNelBhTnJVOGNPaDhDVVZtYktLbmlUWDNvUG9wcWwr?=
 =?utf-8?B?MnBKTmMxWVE1UlZhVTZIZEhodVZicEVGRjhZNExZSjBhR0ptRTc5RW11V3F1?=
 =?utf-8?B?WThodm5kUDFCQ2JnS0JmVDI0KzFZTzY0d1hMUlFpbEtvMTczV2ZnSG9ranJw?=
 =?utf-8?B?TjZibkk2cnVCWjRrVVRwallkU0ZkeWptTktHU2pZbjBLUEtoNTVBWHNwNnJY?=
 =?utf-8?B?NmU0QWt3STBxUEdDRkpTcFBZTngrQUJBaWc4ZDkycFhlRC8vdG5hUURVTUxm?=
 =?utf-8?B?OGpnMC9mTHMyU1ZwUEgycjJHaTg0K25oQmtUeFdvSWFxMi96Q1FXTWpPRXpJ?=
 =?utf-8?B?R2ZiRldGcHZ6NnVKNWg1VzVsblpDaTlnM0U1RHV5bnc3d1V1MklLMTFuaDFJ?=
 =?utf-8?B?bk9PV1B2aVRwRlFISk1ZZk0rN0lLSTIzc2I4QXdKbFN6M0lYb3V1bnVQZTQz?=
 =?utf-8?B?L2UzS09naVczbUcyanFvdExqS0JwOVYvdzYxaE9DdmZrM1lteGNEN2xQWmlD?=
 =?utf-8?B?NjViTTFnZG4zSmtSU3FjcjYzSWpqWTRMY1IvaTdJajhiTDZLMUxBdnh5Rm54?=
 =?utf-8?B?b3UxOTkvYWVueXpVODFqTUlIQXhKSk8xcVhaYWVzVFl6MnNhVnhFSVJjd1M1?=
 =?utf-8?B?UjMrYXZPSlRFN3JwT2tqZ2lYUkF0ZTBOemF0UmdsN2ZPY1loWld3c2hYN2pN?=
 =?utf-8?B?bFA3cDdtbjQyTnBON29hTkVyNW5rdzZpZ29GdHIxOURJTG5PL3lGVHRqVkcx?=
 =?utf-8?B?c2JCRTNJUzB6SXRUWkp0ZkpkV0Z6OExURjBkYk5vTFpOc1NuREhxYnVqTXoz?=
 =?utf-8?B?UmE3dUtVdmFwNzJJUFExWWRFQWdFWk5IYzZZeGk4T0FuSXB6M1ArUXFqb2Uw?=
 =?utf-8?B?ZngvZ1NaL1UzSnpRSXJ2dUtJWEZ5L1dNaHpSdUlvbFpBeFpKd2NJK2M1bnhK?=
 =?utf-8?B?Qm9qQXhPOWt0UENxdHdKY2Q5WHpyMVhDS3RqQTE3MklnMXQ1VE92Uk9CZUdh?=
 =?utf-8?B?UTc4dFFNYnZCa294MFFNbnhQYXhQeGpZaU8yUjBhTFhycXJnSlBGUnZBM0M3?=
 =?utf-8?B?NjRNdTJDSm5vOWwzT09WdWFFL2tGbEE5U3F2bUd3UGtlTmUwV1NsYUpvNVRZ?=
 =?utf-8?B?T0pWRTZuUE9iUzNydm40SzFUK3MyRXFjeUpmTE5vRE5rZndwMFFMQThVcENv?=
 =?utf-8?B?dmltSHV4U1I3WWV6U0ZsRmJBMUdQeWsxUWI5Y2N2bDVDT3haV1NmcnB2T2V6?=
 =?utf-8?B?SlA1VS9PZWR4NWx4STl0c2tUTUYwRFlVOXB1VS93cWJ3Y3dYYXFwZk8xNGlF?=
 =?utf-8?B?TWQ0WnhQQWppRnNVakswdUpPejFBc29WQ3hveEs0RjNQTGpFWk9WSCtWL0x5?=
 =?utf-8?B?aXU0d3JETFliRXVnaGRGSE5iVE5XdnF5cCtVQWdNMDNWYTlIL05zejFXdGgv?=
 =?utf-8?B?d1dnajg4enA4REtGM2dtNTdTb0lxRUFtQnhVbGUyRTZYZ2dvdG9tQUVRTk9T?=
 =?utf-8?B?MG0vZDBYSlRNa3J4V2krVENicjZBeHpHbUVIQlREM3drY2kxLzdKMWdueUdv?=
 =?utf-8?B?WURLZDUvVy9tWWZYWSsxM1VjVFZ2Wnd0MHhOV0ROZERsN25PYmFEQTRBeTZq?=
 =?utf-8?Q?tOag=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(786006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTlmRHdZVVVIa24rbUMxb1lQZnhKZEwrTnNMZ09kVzVtcVZBTCs2U1JGNWU4?=
 =?utf-8?B?U2JpQUQ4amNSVnZ1M3Y3UkhtTUlYbGp0NGlxUjNicXNTNWN1ZVFlOHRwMDFO?=
 =?utf-8?B?TG15aEpXY0h3NzgwK2JadmoreFBhNHVScUg0TSttV1kxeVgzYXptMFlRT3VB?=
 =?utf-8?B?dm5RR1hZVjZhUUVsYyt5QWFjSDNsSTRudHgrNjNlNXBRMVZiaEV4NExaS2Nv?=
 =?utf-8?B?cEhWam1UOVJRaVV6RnFhUEx0RUZ6alhPb0xSTDc3cTdSWkdFTEZPTXNNN3hj?=
 =?utf-8?B?L0xnM1QvQUs3dkpQNTRDSDVxcTFyclkzQ2p2bCtWbDJYMEoyNGNMeTRWRmkr?=
 =?utf-8?B?cXVTaitLZnN4RFNLbjQ1VzE3bjJPTGpyNk9rWG1weHlyOXpCWEVUUFVvNm1X?=
 =?utf-8?B?U0hzNUgyY2FFeWxocEszeFpKQXFhN0FxMVRYaGkza2tubFZjcTdiYWljM1hH?=
 =?utf-8?B?UmVmemlGdjJxWmNHRTc0dDJ4YytPeElrWXE3aVZHK2EvWXZXN1QxbWZtemFx?=
 =?utf-8?B?RHI0WElQWFJlbFlKV0dPRFVxOW1kakl1NXVWbGdHdXRxUmtNZHFXeFVHSFVK?=
 =?utf-8?B?ZDF4SUczWHFwTU8rNm9EQXcxR3A1cmEzVXl1YzQrRGlBQ25xcGRLbTIxanUz?=
 =?utf-8?B?OFhVMUQ3M0djeUh4RUZuSVh1RlBLdGp1QlBSVzFDKzBKU0laVUJnUVdXYmY2?=
 =?utf-8?B?U1FTSVJhT3VRQVVZQ0t4a0NFTEpIKzlTbHJOWGJRRVAzSXlJOGhWUlhMbGk4?=
 =?utf-8?B?eWRMVnVaMDU0RzZlWDRVM1F5MmpQUmphYlBnMVFqK2EvVEo5MSt6OW5hR2hp?=
 =?utf-8?B?dGFnR0N2TjZra2dTbWVKNE9SaWZrQ05IVmF2V0FJMCtFL1hQYzBIelVXTHBN?=
 =?utf-8?B?b3U4ajVjNm1UYTNOU0RIcytUYlJlY09RMFZCc3BmcFpkQjI1aGltb0cxNHFG?=
 =?utf-8?B?SFJDVS9MYWhkc0JGY2pCd2hnbDRpajdvbGdyRnlLRXdpazBoQ0wvWnVVSDMw?=
 =?utf-8?B?cXVBOHZPaFNaTHlzdDgwZFhZMTZySm9tdDRMbzhIUGZscmtjdlFVQTRHQ2NT?=
 =?utf-8?B?U3lzMk5ZdjFqM1dDS1BraVJrVTR6cTR6TzNvdTB0eDRtK1FNeGc0a2tFZTFv?=
 =?utf-8?B?bEx4WEdYdnZReWRFd3RCblZ4SC9lL1lYUE9yZU8zSU9jcXRhT1VId1J5bXFS?=
 =?utf-8?B?aml6MjhKNVlGQk1IekRVOHdNeUd6a3dkanNmWUlFaFY2S2NuWGFSS2NDVFVT?=
 =?utf-8?B?YzVNeFlIYXdKMXB1RVdOcXJTbDRIclc0ck5ZZHRIWG5INDFVN3Z2ODVZSVlk?=
 =?utf-8?B?THNMbE1jSjE1bVc3ZDRqR2VPRkV3ckJrWkNHL2psbnVpeEdkQTB2Z2ViVDJS?=
 =?utf-8?B?eitzNDJ3dnJsVnRFL3N4Z1pWcFZWSzcyYVRBdW1Ma2UrZkxhU3R1VjMrZ1Rh?=
 =?utf-8?B?UkdoV0JaUURTemExcGRodE04ZGFkRTdCUXM2TWt6SzRYZmNpSURZTnVOa2FG?=
 =?utf-8?B?NEUxOUhqVjllNUx5R2t2LzQ2UzNKVEh6V3FIWXNieDhhbHh3bHJQUUxEeHZr?=
 =?utf-8?B?Um5nczVna0pmczlHUlVsSFJITGZ2cko5bmNOQkxCczhSME5NTW0rMm5zYTVX?=
 =?utf-8?B?Y3NsbGJUT0x6WmRkd0phQ1hZd3ZjTUJaUmNuTnNkTUcwTGtVUGpCS0loT0NM?=
 =?utf-8?B?eEx2YUdLRmR2dW0zZzd6c3J1dTNmME9oZE95VTJqbjNmZjBRblpkc05IS29Q?=
 =?utf-8?B?RnNMUVJ4OXp1bmp1UEwveWVvY0krM0xubnRzMFBsaHlyZ1RCYVVnMTcyeHVE?=
 =?utf-8?B?YWxZUVl1Y3l3T3kzOVl2ZUxaNUR0dnNIdmdsL1l3MVJnSFVFbDJidktxQUxu?=
 =?utf-8?B?RHRySjBPaDdnN0xJa1EzdFBoMGliRytvN3VhdHZ5NGRPTTk2SXdwcjVNb1Vx?=
 =?utf-8?B?VXhrdXAzMG5BN3g1WTZ5ampxYWpmbFprRmdub3BJL2QxZUJ1cmpxY29YRVZy?=
 =?utf-8?B?ZHBXdGNnTkVISGdhaVBGL3BYN1VXNmVrRlE3OG0zalFKZks2eDZsZHhRZXVU?=
 =?utf-8?B?aVp0Tm5ZdXlWeUJKWk1heDB0Wjl0ZVdhdTgzeHhCMTVYaGdVcFFFWmtCRXBk?=
 =?utf-8?B?TkVJRUpSVk8zNFlXVElEcFI2cUU4dVVsQldIS3BiT1Ird1dURXJrYjM0RHhp?=
 =?utf-8?B?N1EzUXpSNmRMbi95NDFJY1VrdEZLS2dyNm5NQmZJcnBNQTlyVXNOdjBqTmhm?=
 =?utf-8?B?aktaY1FzSGtDTi9mNkRzZER6YzJBQUljMzNyS2lpc3M5YThaZlBFM1JCOGhr?=
 =?utf-8?B?SHVITCtmYlhmWnhZVXkvR3dBTURIcWhzenVDZlJhM3djUTgwNGZQaUY0SmpT?=
 =?utf-8?Q?SHqjOCud9nvMkJDo=3D?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: b4abc3ad-aaf2-4183-e300-08de58385ed4
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:27:06.7813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PBIIPH2d2IGvsoPaESfsu3x12hZHV38sjcPMex7mL2oppvMCABsKtpe90PT4VPOrx78bOEs/tKKRI4EOUoCjt5+HwZBiBWKHSt/uEXUUZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR4P278MB1918
Received-SPF: pass client-ip=40.107.167.87;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRZP278CU001.outbound.protection.outlook.com
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

Hi,

This patch series builds on top of the discussion from the thread at
https://lore.kernel.org/qemu-devel/e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch/
and adds a plugin API function to set the program counter of the guest,
as just writing to it via qemu_plugin_write_register() has no direct
effect.

Based on the discussion in the above thread, the series also introduces
a means to declare registers as read-only from the plugin side, which
prevents plugins from writing to them via qemu_plugin_write_register().
This for now is only applied to the PC, and finding the PC register is
done via some rather hacky strcmp()s. In the above thread, we also
discussed encoding the read-only property in a custom attribute in the
GDB XMLs, but that would (1) make syncing with GDB harder, (2) not
cover all architectures, as there's not an XML description of all
architectures available in the gdb-xml/ directory, and (3) require quite
some changes to the whole GDB infrastructure in gdbstub/ to even encode
the attribute in the correct structs and pass them on over the different
layers up into the plugin API.

This patch series does not (yet) bump the plugin API version, as I've
sent another patch yesterday (see
https://lore.kernel.org/qemu-devel/f877dd79-1285-4752-811e-f0d430ff27fe@fhofhammer.de/)
that makes some changes to qemu_plugin_{read,write}_register() as well
and I'll adjust the plugin API version bump and API usage in a v4 once I
have an idea whether the patches will make it into a release or not to
avoid conflicts later on.

Best regards,
Florian

Changes:
v3:
- make PC registers read-only across architectures
- add tests for read-only registers
- adjust test structure for qemu_plugin_set_pc() by moving
  architecture-specific tests into corresponding directories
v2:
- add setjmp() in syscall handling path to allow PC redirection from
  syscall callbacks (via longjmp(), the cpu_loop()'s setjmp() for
  exiting a TB would not be live anymore in syscall handlers)
- add flags to ensure the qemu_plugin_set_pc() API is only called from
  contexts where the CPU is live
- add test for qemu_plugin_set_pc() API
v1:
- initial version

Florian Hofhammer (5):
  plugins: add PC diversion API function
  plugins: add read-only property for registers
  plugins: prohibit writing to read-only registers
  tests/tcg: add test for qemu_plugin_set_pc API
  tests/tcg/plugins: test register readonly feature

 include/qemu/qemu-plugin.h                    | 17 +++++
 linux-user/aarch64/cpu_loop.c                 |  2 +-
 linux-user/alpha/cpu_loop.c                   |  2 +-
 linux-user/arm/cpu_loop.c                     |  2 +-
 linux-user/hexagon/cpu_loop.c                 |  2 +-
 linux-user/hppa/cpu_loop.c                    |  4 ++
 linux-user/i386/cpu_loop.c                    |  8 ++-
 linux-user/include/special-errno.h            |  8 +++
 linux-user/loongarch64/cpu_loop.c             |  5 +-
 linux-user/m68k/cpu_loop.c                    |  2 +-
 linux-user/microblaze/cpu_loop.c              |  2 +-
 linux-user/mips/cpu_loop.c                    |  5 +-
 linux-user/openrisc/cpu_loop.c                |  2 +-
 linux-user/ppc/cpu_loop.c                     |  6 +-
 linux-user/riscv/cpu_loop.c                   |  2 +-
 linux-user/s390x/cpu_loop.c                   |  2 +-
 linux-user/sh4/cpu_loop.c                     |  2 +-
 linux-user/sparc/cpu_loop.c                   |  4 +-
 linux-user/syscall.c                          |  8 +++
 linux-user/xtensa/cpu_loop.c                  |  3 +
 plugins/api.c                                 | 41 +++++++++--
 plugins/core.c                                | 25 ++++---
 tests/tcg/arm/Makefile.target                 |  6 ++
 tests/tcg/hexagon/Makefile.target             |  7 ++
 tests/tcg/mips/Makefile.target                |  6 +-
 tests/tcg/mips64/Makefile.target              | 15 ++++
 tests/tcg/mips64el/Makefile.target            | 15 ++++
 tests/tcg/mipsel/Makefile.target              | 15 ++++
 tests/tcg/multiarch/Makefile.target           | 20 +++++-
 .../{ => plugin}/check-plugin-output.sh       |  0
 .../{ => plugin}/test-plugin-mem-access.c     |  0
 .../plugin/test-plugin-skip-syscalls.c        | 26 +++++++
 tests/tcg/plugins/meson.build                 |  2 +-
 tests/tcg/plugins/registers.c                 | 71 +++++++++++++++++++
 tests/tcg/plugins/syscall.c                   |  6 ++
 tests/tcg/sparc64/Makefile.target             | 16 +++++
 36 files changed, 321 insertions(+), 38 deletions(-)
 create mode 100644 tests/tcg/mips64/Makefile.target
 create mode 100644 tests/tcg/mips64el/Makefile.target
 create mode 100644 tests/tcg/mipsel/Makefile.target
 rename tests/tcg/multiarch/{ => plugin}/check-plugin-output.sh (100%)
 rename tests/tcg/multiarch/{ => plugin}/test-plugin-mem-access.c (100%)
 create mode 100644 tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
 create mode 100644 tests/tcg/plugins/registers.c
 create mode 100644 tests/tcg/sparc64/Makefile.target


base-commit: 38879a667fbb4ef54c70de71494882615f600a64
-- 
2.52.0


