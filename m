Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EA0C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrRX-0003gL-GU; Tue, 25 Aug 2026 09:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRP-0003f3-S8; Tue, 25 Aug 2026 09:43:52 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRL-0002SL-Nb; Tue, 25 Aug 2026 09:43:51 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PB0eCw1670254; Tue, 25 Aug 2026 06:43:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=GiCQUXi6hkQOX
 VGj6/7n/SBkeKoLjIA4A1qcWngyDHk=; b=b2vdYf9vAPrEoE8unYb73wbUXD7Qw
 xjcjEaquAUjbgQQOMOi4E6hBWXM5biqjnyLFA8hVmliQQnmRnIuEdSgj2/EzBA3T
 G0awaTddcPf80mNMCT2YmQAaJGEuTrHbKyx706u3yKcliONxL0cb++S1bx4yf2XY
 nZSUb2CHNvi14tpHp+jMJxWSX19ibfrEoABFqoo8qIfOGOuq7OGiVFfDk3Bo8i1D
 aXTXW+oisqBAGN5327Mj9UH3EC3ZrXf2rk/AfwoOpZSGpB5pHsoCw+MLImv7hdHw
 s1L0msFy/l4YLWpybm1pv1dgsPSlws/gyQp37NtXtoL5ttMEXYlrvIpcw==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020086.outbound.protection.outlook.com
 [52.101.193.86])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g8sya2fva-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 06:43:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQOpukSiuXI3/X9+1Qf2uiEE31Vr2H0s1r7eiL9qq+z8fn94miiRoZFPVc6WyxhMBUW8jw8yKFNHwZhyonaJJuy+TuKk92h4uOSEEHpgo4Qy6+XWVHRoL/uS6QElObig2fDtnkfBj3hbbGKrPxFOiu3wEjovcuN90MMNqq/32SUopjnL/w9900f2TcG4/nuj6Oq/cwTwmeZyOZNWW+A4VkyzBmsLBEp5G9HzeCxlImGyokSXwNa6wexJ6H037fLP/JwRlHv1I76wQ4reF8Qy61Ry/ba5f8g/EyhyaeGgkozCTXvI9xzqmTaR0XChTsL8dE0A8xZgLRQuqZQF3yaYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiCQUXi6hkQOXVGj6/7n/SBkeKoLjIA4A1qcWngyDHk=;
 b=c+6TcgrDh+iJwHJmTW+7elT4DgExWp1kc5aGYq4Znkb8t8mjk9H/UTHzQiwKNqYH30XhVgu2IxhGrE2DcqBCG/8MW1kaGC+GeH5vyNteMKJ349y8YQG73TtmRmWUXOiNpsc9a45wQmuFbUUnkitB+fFlJEu9Jit9iEs9JozzPt0HwsRs5ciT0J3uD7qW8I7modxf9ogO/zDutknhefKTDgnebD3xyVyj6X5hzgnERrG/XCQ7kwsVN6Bs9sCWFfcNLE3+Jd4KDX9UBCZowgO0EYLzRQKNb6nxqdqxiSuKs3UJlkzpEWK0TImL6P+QVIcpZ7unt9eAr0aWNdt1FB3dhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiCQUXi6hkQOXVGj6/7n/SBkeKoLjIA4A1qcWngyDHk=;
 b=gQAIGRdDECuTBJSUiWJzKpQ+sz+NGV33Fvw8zbz5DaYQgV+oCYaI4Kv9apL8QTcFTBsCB8wOJmGOXNBYBmlT+NdxivVrhSF1iKsR9Z43/l18uBN4Y8wyrEOy5BfZYYrbNlmAQiDYNObtiWYGc07WeZvUxcU3wCkJKubxpEECdm9Pa4SkVIoTrSuwV50W6ORUpvjme8iXRBEaH3y1dlfOnLmb7z6LEjHli2yi8oKdvcrlArt4RliXKovx8GJv9bvPW0kNezpqd+gl1dvxhDL/NGGSdLDCr7T2kWg+Pv9u0J6DIZVJmMWS2ey17Q0is6sL6QFIdlGge2JRh1ZH9/9XUQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9805.namprd02.prod.outlook.com (2603:10b6:208:491::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 13:43:23 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:43:23 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v5 00/16] hw/acpi: convert object props to class props
Date: Tue, 25 Aug 2026 14:41:21 +0100
Message-ID: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0108.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::29) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9805:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a76a45b-15d6-49c9-1b9f-08df02aed4f3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|23010399003|366016|3023799007|56012099006|10067099003|6133799003|921020|18002099003;
X-Microsoft-Antispam-Message-Info: a+ARJac4KbiQeXJY5+Q7t5nTcwPXCErH1Ktu0oGEmz+Ir/gGqesWVJHFwPDmxBHOAwkAmM99rGj6tfYl2c4okbECDppjOiMEVMpJMs2Yse2JH6STS7z14RWqLsE+PoD7i6ZgPeI0K2KJy91r08iwEokWhDoVqm6Cvcr6efwXSa/s9lluwwrOpPC5708v0AoQcYvTHgIPBUWIPdiz+wscjsy8uFTh3cycAwqQ8LXoFZbTYCin4U41zQJZFlFK7132jl2N7MZYQTrmIzoWLViIZLDIXprQBWHOe+OgcgLldHTDiRXOdtIufkQk3r8FMTb6oAFZeKtsTIe6MSztDTAoefrqlUJ7BJ6LNzsBZe2R5jT4XT8wdADxzSiARjqlOtbidoH7SRuCoYM5TcBSHg26jQmQKzEt9PmQz+9HHYfVp8odgVzejMNmiVPmvfxFngT7pgpa6OxIwhLbFzzc7SWbU7ekVseM8PBAAJS5xym6UCnjTiNmGrpqRZISzB+1tLjj84kcZWs+afotALytagfieuucgySxZpGoJzm88DyzZ0VG+3phydVew4xfWre7a6cBvxLmUv6Rt2LfHVv0PmOvwZHRmJ7BAcJ+IDlgaMlogYzPA10yO+QNe8MiCUaut6LekVS+XD5Sfw4Rvcz1sIJFFhnOmtmZRQfMBsF5BtAqoTU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(3023799007)(56012099006)(10067099003)(6133799003)(921020)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjVZVURaeGFBeVJDSFFQS2szU3IrbDFIRmthTSs3Y3pZQ29GUUxmSWtxekJ2?=
 =?utf-8?B?NWZoNDR4TGpJQlk4OE4weHdmSXRERmFOZVU1b2VEZEdvSzZZVHc0UWRnTVVF?=
 =?utf-8?B?TzJEOWk5YldpRGQyazZFdGtlNTZrVVRJa0h2TEloWW9PeDJmU2k4SjBxZkQ0?=
 =?utf-8?B?TWU3aTA5VHVKS0ZyOERnTXorclR1WnVFekltamZCT3VhODVBWEUzM2pQc0Na?=
 =?utf-8?B?ZFFBa2hXQWZtYWFnRkVHellJaTRQZ3dybm5hQ1I2ejhwR2FSR1lZNm4vUEJM?=
 =?utf-8?B?TUpvNkpwMGk1dTBOTFFtV3hWdG5RUno1OFJrc09aMW9aUU91Mk9XcXlaaENv?=
 =?utf-8?B?QndCK1ZjY2tlcXQ5RE1GaU5WNlM4MlFBd1lOUENORGNTdVY3K0JFdGN0ckpN?=
 =?utf-8?B?U0NiUWs3bms4WHJOSEZVVVpWSUhVdWlCb0VvQ1prc0hwdnZzbG9MbG1iWUVG?=
 =?utf-8?B?K0podzkzczZhYTZPK2p0MmYySFdpbnpYTzlucXF5T3ZvT0lqcEYwKys0UVFY?=
 =?utf-8?B?aTNpT3FNamJGQlpKL0pLRWErV3N2bzVScWtYelQ4cmVrUVJiRkxjVnlJc2ts?=
 =?utf-8?B?c0dLdDlyQjRENHp5WU5aNXNyUVp1VGNia1B5cFpFSWtLNm9MaGw1dWcvSDE4?=
 =?utf-8?B?NDRQU2V0M3FFN2U2ZURaMndGRE9sT2FCRUdTanIyOS9zN1N4S1hhbUpLYjY1?=
 =?utf-8?B?RzZEcWx5MWM0VE9PUzF4QXZEMldsRHU4MzBqdTI3MnZKZk16UGRLdFR2YjV5?=
 =?utf-8?B?RGF0ZFlRamlkOEdOdWhVc1gyaDR3Q1RGRGxZTGFWS0N0MHZ4UjlDcFRNMVBh?=
 =?utf-8?B?NkpMMGlaeVBXVnRkRm4zOS91cEx6TGpTNmd2SUpEV2F4OXNhWUJsOUNDZlN3?=
 =?utf-8?B?eWJJMEwrdVl0aXlORDM5TmI1cUVINUlOTzFRb3MvR3YvQ0szN1d0Sk81OTMr?=
 =?utf-8?B?ZFluclVDckc4STVVUlN5QVpnZndWRElvZHFPdFpOaHlTLy81MDdXZDU1MUV3?=
 =?utf-8?B?TEhkREJVYVl5emlJKytuRHdWTlY3MnFWbzl1bkhHK04xeWsrVUdBUUVTQlNL?=
 =?utf-8?B?N0tqdFYzTHhncUs2M0t1UXdCc1lyeUNLRVdSVGFtNktRQTc0a2VVR1A2OTZa?=
 =?utf-8?B?aGhJNWdHQmZUUUtBbkVPN0hXdzhJTndsMnNFZHIySG5IVEVjVVV5bTVLQWQv?=
 =?utf-8?B?NFJiQ2tOekdwMXp6cGhBamQ1RjRKd043Z000RVJidmg1cmhFYng2bHN2UEJ3?=
 =?utf-8?B?NFFyYXg4TWxpM2Y4d05uUlM2RTZRL1N0MWZ4RWZDV1VVSkxiUVFheUMzWVRI?=
 =?utf-8?B?MHIwVTNxVEUzT2xCMG9lZ3B6dlBtWDdWRTZlRzlTelg3WjhoYnp4ZmdwODZz?=
 =?utf-8?B?NGo2M1N3aTYvcHBsUHV5bjFoYkMvL1NQTmhaaXphT3Z4SEh1SnBWRjhMSFBr?=
 =?utf-8?B?Slo5UmFLTTN5T08zNDY5UFpaWnZFbEJpSE1PQ0VrMFhBVEp6eTFwYjJyOWsw?=
 =?utf-8?B?Nld4TDFwdEpMb1lEVmdZZ2wwOFlXRFM4SUJpeUJmMjFMb0VURzl1aUVmc1lu?=
 =?utf-8?B?d0pzUENTQ2gxRGFXUGsyUW1hT285V254cFlLeTJNTnYraDJZem5WOHpjdUFh?=
 =?utf-8?B?R25FN3lvZXJWV0hHa0RVYXpJcENEdTE0eHF5dzlaZU1rZERNUExHV1RLazZH?=
 =?utf-8?B?YitVUXJFam9Dd2s2M0lLMWdaMjA3Q043enhHaTJzbDNFVHkwQlBJbXlOYnhK?=
 =?utf-8?B?SzFDcVpkVXpWaTBhRHMxYXQ1ejVsZTJBWTVQT1hqeU9pSUNhTGRFVWhaTGFU?=
 =?utf-8?B?WnNUcmEycWthSEIwY0xENDl0djhrV2FoTEdIMVlWeVJZLzNYZTAvbTZpRmZE?=
 =?utf-8?B?cjlzVndaUHQrWFIrYmMwZFM4Q1R1MHdRU242OS9NTG8zWHpFa1FiNVlHYUJB?=
 =?utf-8?B?Q3FEdjRUTHMvYXp4VEVjZThwNlFRWFljd2lzOTdJN2NKbGc2YWE1NnNISmpV?=
 =?utf-8?B?Yi8zY1pla3pYTlNRRHpDTllqUUhHTW9rQXpadGZRVUpDSmNObnlnTHV3blBH?=
 =?utf-8?B?YkNrQWhGK1VkMm5EbTExaHFJeE8rSDgvOTVDWFhOTWVrMTZKQVFPK1dTb1Q0?=
 =?utf-8?B?K04rM1hDUTFwK2wvZEZNYnBWMVhsdFJoemdHd1YxUStiay96bzBEcGh2bmU2?=
 =?utf-8?B?dkhMcWN0OGxQYnhvdzR5bmt4YVpHOFo1aEdPT2V3c3pCRkxHTVh2MG9GVmll?=
 =?utf-8?B?WGlqLzdEY3lFR3p1WVZvOWFxcW12QlExWEVJbkIxelRYUkkvRzVIS2NYNVZp?=
 =?utf-8?B?RExZVHFnVnVWdk1PWEdNNnRIT3ZTUE1jTzVNb0gyWmxBc2NoTDh5M3FqUzJy?=
 =?utf-8?Q?U8UM5MBZjaJY0nR4=3D?=
X-Exchange-RoutingPolicyChecked: yM3pg5HqeoYHqEYEXoRtZQsRA8IOhXav/5HeTYEpYx7syiGrkddgQDviXd5hz5CQC9ji6k0o8nuo05ljio0WWvhwlpmbAYQ639AqO5HTvaPacL3LdNMG/7p8W/AcUeC90lHiZzDW5+73FKOlgFUxO+j1TIZWesbmaJD2XVpT4yM3BGELdDMfcUxQYB4IOUdvulp0SNr7ilYZju9NNOPhPknO5PfCp7jrG8ScXLMpUtLgZQcd4mkS3UuQl5RirJFc8VbINLgLCgfe0zVKNg2dNfHEGTRugp01r2V2dlevdCbI0cNpJ3WywHeNn8sfvPSyYs8+Bqa05Djk2otLnfGngw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a76a45b-15d6-49c9-1b9f-08df02aed4f3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:43:23.2164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yUGH02JHcgNENDX4Rlgk+VpUubb2Vaeinx9wld0imGPVvvTG4C9oUGxEIh764xvJIL3jzTh+eqvP5TkQY0GMZg/OfL/eagJNErCmHtQva8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9805
X-Proofpoint-ORIG-GUID: FFKGOS1cvAlvXDzNmEyti3JmZ1aWsYVy
X-Proofpoint-GUID: FFKGOS1cvAlvXDzNmEyti3JmZ1aWsYVy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfXy/R+1mU+S8Ec
 xhKrZV0til+VOytbrzm6enxQ5Xn3bfZD+xHFHuUAjaLHr8CMIGKO+4zi79AEgGYtTBmFQsRLii3
 pcxSn1+hAhqnaMchbTOuw2yLgQcfyb7qyGJM6TkhEMYFgHHdM4ciLawJ0UAetUYZv4FinD8dTQB
 I6VmtN/jXHGD8gd3FqdeIPsTC33dFhphn3NjvoTaPiTOoLiXe5AhHl3SlO5UYMTvhTNxToutUcE
 2W7Abu4n6JQQ2KG01MKBZgC/HtpE7SfWPj616uutBIghYO5amloTthK6GDnbec0cBhhZ5CON6hx
 CYtlGjuVlXa+O7JcbWNaxoxPZnzlctJES/TOarnaYCEa0Fg+Y2MSFfa7aT6TYc/7OfIbZj/fVXB
 7nP8pumdx13DchWTXHIvn8dxdVs7lPvCmGEm/HTC02V6wULBcVoLd4DRtJ4qsOM44t6qDphqxb6
 p4dfygg8wFtFWGztjAw==
X-Authority-Analysis: v=2.4 cv=YOqvDxGx c=1 sm=1 tr=0 ts=6a8d9bfe cx=c_pps
 a=Ju9Zey7g8YyQpP5MZaDBLg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=mDV3o1hIAAAA:8 a=GaQpPoNlAAAA:8 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=yiOi61s0K-w_ntCZxyYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfXzdWl5CQicxOg
 D2CChzRdG5oLUOKbHBMWyqFO4+uJ6dKEyy/ymoAiuTdB13WP7EndhzTlFETkKO1iWkrYaddrNh2
 JOP0+rqHDbDzwgINgYjWENNa9t39wqs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

[Background: based upon Peter's feedback at
 https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg07717.html I realised
 that what we really need are object_class_property_add_*_ptr() equivalents to
 the existing object_property_add_*_ptr() functions to make it easier to
 convert existing properties.

 There are actually existing functions with these names that are already in use
 but after observation these are really static properties, so these are renamed
 to aid porting object props to class props, as well as making the difference
 clearer.]

[Note: this will have substantial conflicts with Marc-André's series "qom/qdev:
 associate properties with QAPI schema types" at
 https://patchew.org/QEMU/20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com/.]

Since the use of object props is effectively deprecated, here is an attempt
to convert all use of object props in hw/acpi to class props. The eventual
aim is to continue working through the codebase, removing all remaining uses
of object props.

The series is lightly tested: it passes "make check", GitLab CI and some
simple local tests. I'm mostly interested for feedback on the conversion
strategy, and to get a feel for the best way to merge this series since once
the basic conversion patterns are in place, the same patterns can be applied
elsewhere and it would be good to minimise the merge window for such changes.

The following warnings below are generated by checkpatch but are incorrect
since they form part of macro definitions:

1/16 Checking commit 58e8d5fb5971 (qom/object.c: introduce OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type) macro)
ERROR: spaces required around that '*' (ctx:WxB)
#41: FILE: qom/object.c:2720:
+        type##_t value = *(type##_t *)object_class_prop_ptr(obj, \
                                     ^

total: 1 errors, 0 warnings, 28 lines checked

Patch 1/16 has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

2/15 Checking commit 2068ae0d4ded (qom/object.c: introduce OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type) macro)
ERROR: spaces required around that '*' (ctx:WxV)
#28: FILE: qom/object.c:2730:
+        type##_t *field = (type##_t *)object_class_prop_ptr(obj, \
                  ^

ERROR: spaces required around that '*' (ctx:WxB)
#28: FILE: qom/object.c:2730:
+        type##_t *field = (type##_t *)object_class_prop_ptr(obj, \


Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

v5:
- Add R-B tags from Daniel

- Update comment on patch 10 to explain why OBJECT_CLASS_PROPERTY_SCALAR_GETTER() and
  OBJECT_CLASS_PROPERTY_SCALAR_SETTER() cannot be use to implement the
  property_class_get_bool_ptr() and property_class_set_bool_ptr() functions

- Use PM_REG_FIELD() macro in patch 11 as suggested by Daniel

- Use error_abort instead of local_err in patch 14

- Rebase onto master


v4:
- Add R-B tags from Marc-André

- Fix comments mismatch within object_class_property_add_*_ptr() descriptions in
  object.h

- Add patch 5 implementing object_class_property_add_uint64_ptr() now required by
  patch 6

- Don't promote ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP to a Property in patch 6 since it
  must be marked as read-only: use object_class_property_add_uint64_ptr() instead


v3:
- Re-implement the object_class_property_add_*_ptr() get/set functions using
  new OBJECT_CLASS_PROPERTY_SCALAR_GETTER() and
  OBJECT_CLASS_PROPERTY_SCALAR_SETTER() macros, similar as has already been
  done for object properties

- Drop most R-B tags since nearly all patches have changed since v2

- Split conversion of static variables to static class properties into separate
  commits to act as a reference for future conversions

- Drop patch 6 from v2 since that has already been merged separately by Phil

- Use UINT32_MAX to indicate ACPI_PCIHP_PROP_BSEL has not been set in patch 13
  instead of -1. This is because the existing object_property_add_*_ptr()
  functions always use unsigned scalars: let's try and keep this the same for the
  object_class_property_add_*_ptr() functions if possible

- Add a new object_class_property_add_bool_ptr() function rather than using
  object_class_property_add_bool() in patch 10 since it avoids writing explicit
  helpers for each property, and there will likely be other cases in future

- Rebase onto master


v2:
- Add object_class_property_add_*_ptr() functions matching the existing
  object_property_add_*_ptr() functions for class functions

- Rework patch to use new functions instead of manually adding get/set
  functions as part of the conversion

- Ignore existing R-Bs since this approach is quite different to v1

- Rebase onto master


Mark Cave-Ayland (16):
  qom/object.c: introduce OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type)
    macro
  qom/object.c: introduce OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
    macro
  qom/object.c: introduce DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS()
    macro
  qom/object.c: add object_class_property_add_uint8_ptr()
  qom/object.c: add object_class_property_add_uint64_ptr()
  hw/isa/lpc_ich9.c: convert ich9_lpc_initfn() object props to class
    props
  hw/acpi/ich9.c: don't pass ICH9LPCPMRegs via opaque for
    ACPI_PM_PROP_GPE0_BLK prop
  qom/object.c: add object_class_property_add_uint32_ptr()
  hw/acpi/ich9.c: convert ACPI_PM_PROP_GPE0_BLK_LEN to a static class
    property
  qom/object.c: add object_class_property_add_bool_ptr()
  hw/acpi/ich9.c: convert object props in ICH9_LPC_DEVICE to class props
  qom/object.c: add object_class_property_add_uint16_ptr()
  hw/acpi/pcihp.c: convert ACPI_PCIHP_IO_BASE_PROP and
    ACPI_PCIHP_IO_BASE_PROP to class props
  hw/acpi/pcihp.c: convert ACPI_PCIHP_PROP_BSEL from object prop to
    class prop
  hw/acpi/piix4.c: convert static variables to static class properties
  hw/acpi/piix4.c: convert ACPI_PM_PROP_PM_IO_BASE to a class prop

 include/hw/acpi/ich9.h         |   2 +-
 include/hw/pci/pci_bus.h       |   2 +
 include/qom/object.h           |  90 +++++++++++++++++
 hw/acpi/generic_event_device.c |  10 ++
 hw/acpi/ich9.c                 | 115 +++++++++-------------
 hw/acpi/pci-bridge.c           |   9 +-
 hw/acpi/pcihp.c                |  35 +++----
 hw/acpi/piix4.c                |  51 +++++++---
 hw/arm/virt-acpi-build.c       |   5 +-
 hw/i386/acpi-build.c           |   5 +-
 hw/isa/lpc_ich9.c              |  36 ++++---
 hw/pci/pci.c                   |   7 ++
 qom/object.c                   | 171 +++++++++++++++++++++++++++++++++
 13 files changed, 416 insertions(+), 122 deletions(-)

-- 
2.43.0


