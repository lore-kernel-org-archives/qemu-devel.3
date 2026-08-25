Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B2FC61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrSB-0004Cb-9l; Tue, 25 Aug 2026 09:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRx-0003x6-UK; Tue, 25 Aug 2026 09:44:26 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRw-0002Yt-9p; Tue, 25 Aug 2026 09:44:25 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PAwJZp1711944; Tue, 25 Aug 2026 06:44:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=lNq2MDzVipLy/+0On13GWtp5Zx1rRlXqUL/GPcgwZ
 yQ=; b=iGzZ20ThmfAezlzkYEKubrCRldCEH6lw5c/f52JdfddcoR+BkqAg7Z6CE
 Fws+pTvOPZ+ypITcELvZYa66CGKGSarKem00A0SKT7m5AfXEd006XA8IOVAwBbv9
 JZBb+U9Q7ubT1KYzGCIlsJJS6+zaNmA0lfL1m50GjRe65ImyiFw2ZPoqfYnujAXp
 xDCZXtqsc1UAqtifyEBU5e/JROdfH0QWDXDKom5SnNvR2kRzn23t47m2MNSJie7G
 Tz/MK52J+3oe17Xb7fR1xsw2h9vmtp48mjJtZHi4JC12sya7YGycU/qPUxWAZmCf
 S+iHlpSIAGPkWfmfyjGySAsfLnDhA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022088.outbound.protection.outlook.com
 [40.93.195.88])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g7b9y6c5q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 06:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hm/BkVmk5Vwl3VNBYGGBH0VqjpdvCgR1HJDWd1Re18rdnoPP3eQ6N5/ZVcH6lAA8CA09lZ5mhx7TJh762LHbJAeMmeFAa5cz3wPFMl/gRnOVMIzywouSPdyg6tcri2vnXJ7E+rjPrN0LDaTc4FkDC2FM5cmnCrh5VJtR1m/qE+KaMHTE1s9LURUN2BkXKIQGFfvj943SJNVSJaqLEN0ZFivGisZqehGoyE7lpJGguhgrIeI1PErK0c4nWhlz+59OGZe/MxlrX6o+/ZG3wuy3vVyKpSrttO8K4Jmp5Tet11g5I8+JfwyhLfPU1ioHw9zZODKzyT8hfVxzoeN9kvpq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNq2MDzVipLy/+0On13GWtp5Zx1rRlXqUL/GPcgwZyQ=;
 b=HQHXpjAIWuZM2K2/edrAsgzjFq7OzoBCcftOti1SuGMMv39WSe07i6tK9C2mnl4ATut2G2nNVkA1XncQdaLnd0sA8rBAKX2VYaJkANCRhN7TwPZjRr18FkVxzQu3bmHj5icv45jv6pEweL7RXFLtA/6vQEhVNzCOJTEKe5NgiCfkQ5ISPY8xEAeQBcHCm1/PP4Kvi31yhR70Q5xypyNNcb+52Kqxyqozf8Omp9LbLHQEMfBnMqM6cXluyE3SrTDIhWpcf6rLXIgrJMZDf7pX9BlBYYtRG8mwWMvC6aj0loCSU5ayInyMzdu/Vb8SDkgO+igaO+KSJnhiQ9Y1Vc3xmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNq2MDzVipLy/+0On13GWtp5Zx1rRlXqUL/GPcgwZyQ=;
 b=ZLuqcAEO/KUlNfs26Syh85MUDE3bk4tu87tzFr++nQb+Y916K7gCEjkMd3akqf43H8cHHzjyk3/gr80qDWzH3uKoe08DFUCB1G0f/lmvdtMnwh3vUZNnU7uBONYTH3ZSdRfBJ8SHf1pvnO4t8vO+TvAo75COFOyRWavBgVepOoGSoklsR9rsPCQqQbHEma6ASH21EX3dVKOEVN8q9qNnL2CDYByvreHV1f+iXi45odrJk7NRXx+APsp1d82/OOpyI5l76SPCpRdQlfO2be2voP+/TEVQ4dTC6eHPdSiKVBzZc2a4iSPP3/nwsaAfzEXc0xJ6xL1yuMkdIboe5DmHSg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB6926.namprd02.prod.outlook.com (2603:10b6:208:201::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 13:44:10 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:44:10 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v5 15/16] hw/acpi/piix4.c: convert static variables to static
 class properties
Date: Tue, 25 Aug 2026 14:41:36 +0100
Message-ID: <20260825134320.1039012-16-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
References: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d731fdf-5303-4877-9d90-08df02aef11b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|921020|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LVXtAhY6CtJ0jm0DFl3vpccHWhhTGhwaoa98921qgvnHhpI7b+QTKouf+BBxGxVxOitxp6/l69poq6h2M+oTLw3//YM1Lr1ciUCiJxzzzVk5y2Gp9KiG+iUmIIExkyEocGehaXB8uSv/RZwJ7ZQ4BQnqoUHH6YPwiwFy8QyGftiE8M/g5nPwGfBM5coSHnfIczg3hDN3nKBvxPl3Pfx8846WdwnVWvTnOpiOwQkMfIiMzYWY2RpB+AY9Uq8+asRXC+84fJJ5SrTYkG3S5l/YAXNM08N4ckw25Iil8EsfUi7aFYcBbEpCcR2fIcNtRfS2plnx3xgeYEBHbZOGLXbjTvhCTGMTVNU++83b4C9w5o2Y+2bPW0O0AbcAZTdBstM/3MY+IfT+r/tdnkMmvr38zdFjFMJVC+VTXD4xykXBdr7+sQzjQIyWKLRXHxyvEtRLypIzSKxI+hsultAKsyo1aB/erdrFVFEE+dwULsg6I37+tRpIF1luGtBIQlNdp5b/VMSSyNeo6/ria0Ec6CiDM8Q9s4U5vlVc2QZNJotoFGg6EdSz7NvPkMsclIiuloIiMKhN+kRjUALt34WRmZnLXYCGBSyj3nOZVPLm+NA63ITbqA3tZakrM1UqXAvAksFEAeWPyQoJEikmoVoBoJ+3rIkULYye/Y4FWTJzp+zHpx8FPKbS+SfsiH5fQNEnAnmV9jT4Ju7KFVAVudJojO8EiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(921020)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U29PSEt1bmZsTURkbzdWQUxESm9XYTJlUWxESTc0RmNXRkpTWGFScTNyYlJ1?=
 =?utf-8?B?OWdxYzl2WWt1cFJoVUZkVXdRRGhxNDUyU2c3VE9seCtNUkhWOXpTNTlTTnI3?=
 =?utf-8?B?R21XRDJNY1F2VnhVSTRQRkNtakpDei9tUVNkQVBEQ0s1NXBySk9hUk8wT2JS?=
 =?utf-8?B?dzFua056WlF3UDN2YVFEZ0YyL2ZLalkxUFNpd1gwMmhaY2o4RjArakZoa2xn?=
 =?utf-8?B?Z01RMVRsTXdnNFp2MUdUZzVadzkwNzE5R00vUHpJOEIyWVMxeE1sT1EvUjBv?=
 =?utf-8?B?cG9kdjFFQXlXVzlLQUNKVmlhUDVaMy9kK2E4NmNOcElQUnRhZHVOUkgzODR1?=
 =?utf-8?B?TGZvdjhtd2l2SVNDL2xteUNVSER4TThuemJOZHJ4QW11ZGppVjkxbFdKZldY?=
 =?utf-8?B?S0hQNi9QM0FkbDV0NnZDdDlnczdVSzhpUHl6RlZRQVpZR1NQREhiWXpFTENK?=
 =?utf-8?B?WFlWOHdWOSsvV2l5bDRLYTdxQkxpYjNYT2pTUVd3MHMzckk2dk9pVzVlYkpL?=
 =?utf-8?B?T1AwZWwzZ1ZjT0JNRkVKalpGSmhDR2xDSEpmTjNHR3owVlRNUVNVN2RHRThu?=
 =?utf-8?B?N1NFdmVpa211QUZ1WVdsaFB2VHpnVjRrMWJJUFFqeGdoNU5lWit4UU1oYnlD?=
 =?utf-8?B?SlZCRmJMTGtQeUpNZTEzWUtwcmRRVCsrcFFaOUNKeXRZRU4xdi9tMXYvWEFN?=
 =?utf-8?B?WU5DaTdHeHZGcmVsRW1UYjFIaXpCeEN3eG5ENXdjZXRlRzBRdUxnYnI0M1JI?=
 =?utf-8?B?STF6cUN0LzVXc0tyTC9hdDhzU0N1cUU3d0MwcTQxRElQL1lIdTJPVWl1MzFE?=
 =?utf-8?B?WVE1ZUJOb29EQkpIWklyY2VyQlhHanZxcTRWMC9oblUrUjkxamQyUFJQQ2s0?=
 =?utf-8?B?eWZrZDY1eEowUEJVQU9tdE40N1dvT1liWVM2eEVyb3YxYXZ0bXR0bFJMNmlv?=
 =?utf-8?B?Sk9WRGh4WmRpVnZzc01aTGJqbnVVaDl6ZEgzcXNCekVzZ0ZFRGFPbHNDd01L?=
 =?utf-8?B?SThQaHJaKzZmMnphbzdoeC94TXBBYnVKaDAyNzBKSUZQNllhSEtIcStqLzVS?=
 =?utf-8?B?QlpFSm1VbFdzRkFRTzBBM2JaM0xOYUlHb3A0eEp4UHZsUFlSR2ZPK0FFTWFt?=
 =?utf-8?B?MHBEVTJETjV0TktDNWtwaFBYcThOQWtkMzVBVnNxVDd3QUlUcEdTaThncnFh?=
 =?utf-8?B?dEwxMEV6WEs2YzZKblpDSEQzYnJRRDZjRWs1QndCb1p2a29BY0xKRXhqVU1r?=
 =?utf-8?B?aGNHeUM2MFVKMy9tTEJXOTl3eUpkNXBtaDFhdm0xOFphbmFLMWU3WTNSYXpt?=
 =?utf-8?B?ZGxWSnlLMkxBdTBvNUtzclFXeXk5WVBCNHRuamhLZmU1YXgveTlSRG1Ua003?=
 =?utf-8?B?UjNCY2xORDR4YVNYNnVScVB3bDZQNlFCTmMxd3lUb3ZwM0Uzb3NrUTIyYkNB?=
 =?utf-8?B?cHU0OTJFS1M0KzNFWlpNKzJYNGR1VDJadVRFRUFuVjBLZ1dJdWNmQTJBZ3Np?=
 =?utf-8?B?bnQ4dFRqSFpmOXdkb0QwUlBnR1BJMWVYWFVVdzMvc1luckVlMk01SGtqRTMw?=
 =?utf-8?B?akdBcWN4MjVUZnYzU3RoY3k2VHU5c0J1MFBBVWVuL2c2bXdjZ3lDZlVMVThS?=
 =?utf-8?B?MUJYSXowc09xbG9CVFlKWldodW9XRVVWZ3RWVHBOVXBnTGxob1BidkJTMDE1?=
 =?utf-8?B?SnJmTzZjd3VQWld2cjVxNDdvcnlUNlkxTzlpQUdCNzJXNEoyN3U2VGlDWW14?=
 =?utf-8?B?M0VENzhBUW5sd3NJQVJrdDVrNmtWc1l4elhSM3pTNUd1ZTlPSWxvSnYzY3Ax?=
 =?utf-8?B?NDNvSXMvRE1yME1PTkxNOTBwU3d0ZGpPNFFhOEVxL09KRzY1dmRSS1M5QytB?=
 =?utf-8?B?MTBtZlhCSWNxSWYvWWNzYkFOeHlMdVRueUFSUlpFVEZrUlhRampWY0ljK1RJ?=
 =?utf-8?B?MTJlS2hEekNHbnh6RHdJTzJ2dTMrNzJ2LzZYcFAvWTdNYU1NeTVwU3JWVVY5?=
 =?utf-8?B?dGF0dUFxR2Z4MzVtN01raHRFdUpvc1E2TllxTjJpKzdBV1ZkT1BkWXFNenRS?=
 =?utf-8?B?UjIrbGwwL1ZiYVJwcnVnU1RCd2wydkpuN2RUVTh4dzFpNGpsbGMyenA5dUQ2?=
 =?utf-8?B?V0h4enVDV25IUDRhZmxRQW1mTWkxRVpWejhsNFZLZ0g1YXJlL1pVMmNXUzBC?=
 =?utf-8?B?TGVWbEQxTGRQa3J5TGV4QW5HemZqdWZOMi9ORThCNThpSGhuaTYyMnpZUHox?=
 =?utf-8?B?dHpxYTdjd3hUY2dZU0Z4R2haUUVHNmo3c25LVjJYT1JYaisydEZBYWc4eEtT?=
 =?utf-8?B?U3FBcHdqcnYzM3BFc08vZWJrVUNvUkpFNDgyVllveGpOK0JuNkJUbFZpdTEw?=
 =?utf-8?Q?ferUvlMJUW2Q3x9Q=3D?=
X-Exchange-RoutingPolicyChecked: uvSXoHWjg3eZfDnvhTeI1mlKglsG1TkwY1vmNFLg3e/85mfNUoc6p9W0SZkNon7E8CNAlDCLSlKDEs0rfiopuVJiH6ke/1v/aqzBnGShKrzWfpdrR65FBBg8X519FjeRm0DHaj/TzDS9HEsraGEuhQAjD83o7gu/dFuXGsc8FE10avEQzHon3xCsHsPdS267l9ytww+EuZS9iZqjZ7fiK3APdxrYZmqpHJUlbWw6AR1RUwMX45hTrSkDsFFscUuFWwUrnP6USi09R3sVMR+yObKmB5PBWExUwaZxMjyBEP3x7TUMUhDKgpJAypBA+L57DFilH46doWegIAnAJq54mw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d731fdf-5303-4877-9d90-08df02aef11b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:44:10.3275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2G1fSbn7VFzDhF3PQsVlFGWfSW9qcRqbK9ZEyEB3p2Ocb/iUmwYwVtb/3YIIk9bmtlD3d2k+YpjuVAd750aMlesxxO/4KcQnApj9qBms78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6926
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX4OF1XiEJMzFf
 vKxSS6ExdPugiI1x7HWzF9RjBEZdApBpLDqm/E70Zn4FNLd/5KbInFvX1AQD9VJ3/UuKDScke9D
 0ZkZXixscZfgT/6+vgimXnRLlNhLOtVb73D3aWNz+6vfBJ8vIDMKJ6qTNOUiae2bZe2ujzPuXhL
 h7QRHS3/sacynIfHAGBg6Xs/J2PtF06s2AmeMk1qQQY4OWgf5PzJJ5R5M6OhRlrvbJD+jNEl4+b
 4NbtOoRRudAPQjg+zulhbS8hpFZARiFCIGh0qNwhbU+FdcqsndsM4OGtQivKrF6vkf64Wo1uaGr
 qas7AqCQZtSsEQXndrlh76fLQwJOOdmuRJEKlyYeg63HrJYeLQe04OpVFwzrV9Z+gDCEx7IINGp
 AJ2zotWJ7Yqw3jY9XkL9E1HEC1vLV4uxbIuHshR8ufZTtPs6/kcxgme2ijqntSmLIqzH6//DiQF
 B6Poc0q62wCaFNlxaKg==
X-Proofpoint-ORIG-GUID: 7GENW84wyVaGbCnLceje5v9SS0dCXQMS
X-Authority-Analysis: v=2.4 cv=YrI/gYYX c=1 sm=1 tr=0 ts=6a8d9c2c cx=c_pps
 a=2kU2da9fspT7tSTAg8jXZw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=zWFTgipdAxScIl1IxHgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7GENW84wyVaGbCnLceje5v9SS0dCXQMS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX1fu3TIhwuBgv
 nN3izjQ6S8iIupxQ/fnYdsfU87kz4fk8K1+cnd/lMhPoF3VM27x5LOw35GEi7GPo8Xr5Ry42mKn
 2kBrQb3lF/Gce2pEs4ed4TahEnBzE/c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

The majority of the properties in piix4_pm_add_properties() are assigned to
static variables and so can be converted to static class properties. Introduce
piix4_pm_add_class_properties() to hold the static properties and soon all
other class props after they have been converted from object props.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/acpi/piix4.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 1d209ac96d..6462ba970c 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -406,6 +406,12 @@ static void piix4_pm_machine_ready(Notifier *n, void *opaque)
 }
 
 static void piix4_pm_add_properties(PIIX4PMState *s)
+{
+    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_PM_IO_BASE,
+                                   &s->io_base, OBJ_PROP_FLAG_READ);
+}
+
+static void piix4_pm_add_class_properties(ObjectClass *oc)
 {
     static const uint8_t acpi_enable_cmd = ACPI_ENABLE;
     static const uint8_t acpi_disable_cmd = ACPI_DISABLE;
@@ -413,18 +419,26 @@ static void piix4_pm_add_properties(PIIX4PMState *s)
     static const uint32_t gpe0_blk_len = GPE_LEN;
     static const uint16_t sci_int = 9;
 
-    object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_ENABLE_CMD,
-                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_DISABLE_CMD,
-                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK,
-                                  &gpe0_blk, OBJ_PROP_FLAG_READ);
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK_LEN,
-                                  &gpe0_blk_len, OBJ_PROP_FLAG_READ);
-    object_property_add_uint16_ptr(OBJECT(s), ACPI_PM_PROP_SCI_INT,
-                                  &sci_int, OBJ_PROP_FLAG_READ);
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_PM_IO_BASE,
-                                  &s->io_base, OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint8_ptr(oc,
+                                               ACPI_PM_PROP_ACPI_ENABLE_CMD,
+                                               &acpi_enable_cmd,
+                                               OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint8_ptr(oc,
+                                               ACPI_PM_PROP_ACPI_DISABLE_CMD,
+                                               &acpi_disable_cmd,
+                                               OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint32_ptr(oc,
+                                                ACPI_PM_PROP_GPE0_BLK,
+                                                &gpe0_blk,
+                                                OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint32_ptr(oc,
+                                                ACPI_PM_PROP_GPE0_BLK_LEN,
+                                                &gpe0_blk_len,
+                                                OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint16_ptr(oc,
+                                                ACPI_PM_PROP_SCI_INT,
+                                                &sci_int,
+                                                OBJ_PROP_FLAG_READ);
 }
 
 static void piix4_pm_realize(PCIDevice *dev, Error **errp)
@@ -616,6 +630,8 @@ static void piix4_pm_class_init(ObjectClass *klass, const void *data)
                                          offsetof(PIIX4PMState,
                                                   acpi_pci_hotplug.io_len),
                                          OBJ_PROP_FLAG_READ);
+
+    piix4_pm_add_class_properties(klass);
 }
 
 static const TypeInfo piix4_pm_info = {
-- 
2.43.0


