Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7304EC79F8C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4F2T-00033E-98; Wed, 09 Sep 2026 05:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x4F2Q-00032y-RF
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 05:56:18 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x4F2O-0005BT-PW
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 05:56:18 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688MeVun227163; Wed, 9 Sep 2026 02:56:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=wShaH796amoE54kbl+m7mgLAd4xsKai0Yg/T3YlNI
 IA=; b=X8iQlQqXm7gmxzoQNSpzZ3B0yiiTxWXKTDIU+3f0Lfumn8PyHmDgVjMBJ
 OM6H/I5wTLPQ1RVMY0kimorm2TetEi6zioQFhd0rY/+mfcahb5XApNy6zCd9VqjQ
 /px6jMUU579qTNtwY1gPCDQufMw6rieinjOaCxnCPH4wg79UDQUHYYYuLkWawY1L
 gXGhyzC3xrpOwAKQ8UDCA8gFkt2PlZ4UjlU1uj6SrHPXsCaZcIM3UaJB1tG2c6kR
 jxPKKhfAawOmMz6HmhCesEQW6mskV31kEsHpKTL1MykSe22E5GWAKMuFPeLLP/Al
 LJhgJYg+pwdkMEy/KiOZM+Q+uL1Mg==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020084.outbound.protection.outlook.com [52.101.61.84])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gjp7ma2ev-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 02:56:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtoycAobP5OCgHstkK8T6BiWXLChSXDIr/mW0qAkBojuiHoxKu6Coix1pBx8oNuE9T3M6DvKLlcPt+CkjzhZw0l0qx6C1fpqrgtioX8rZ6TeKXcSf2auNd3CQmpircigx89fuOzjlhTITdi/gDid3PiVvcn74F9lvU+IQ7MzUguLBEd8LkC6BKXI2sBpzF5ZZdTNHvVePet0SDBX5bdTj2Si8iPq9j6bDkCV/YALA0X7sTqqOR1ro61MWnikioNv5W5L9CpbuM6diGesgbN2kelzle4Z7+KIcU0heQ9UysNo1pHyckBlHXdZN7qOlYknFmuhhNFEe9t5EkgS6wZ14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wShaH796amoE54kbl+m7mgLAd4xsKai0Yg/T3YlNIIA=;
 b=bv0zz1vEsRB/jrxbo3XIT/tVNtlxYLpsvUYrOrrJAkucdQ3j4EZ3aDin/3V3z6XONJ4a02DI1kVk3I8Ku5E5svPBnbatk62Gg7yKt2EVHSznOm79TcObsbsLWUosJAuY8zjZYDWi2ADik184RfaQrI3CaTajFbYGgLREyxz4GbHzML5UH8f6bC60vmLRLwQzO6sd2pMHKuG+GWh9KbSnGLnQR77eDMlqVeDFBtkTcZlC+iUipS6lvJMSseD/kUH5y5CoeKumPanInevijJwip7/kwbiA1PF1G7LhEaudt0uiGPWIkDMjvE+e5CxvWahUWuedFo3zdOLLTP2aXnQONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wShaH796amoE54kbl+m7mgLAd4xsKai0Yg/T3YlNIIA=;
 b=lXbRzCksxiqNQeJwYTzbv1L1aV9BtbHqNgTd8jWlesriC5Wz0frev2RIKtnpcpB+Bbw1JW7W4wJrpgq3894hisGaGfNa90g2dKCVVgaGmXP7hUMGx/68zTTx3I85M3DGu8YQxdRGpHdXBbm/0ry3EyNR0c2i4VKHEAz+7x+hHqLeyQC2m2onH0iF0Xj1XrrveED05/ScF2B5OdeCliM3MTWtIWpKhC+CjbbEZN04RVTIFQ9e7rLvdXV581uxj9O9JBdcNXmHcTOtuTpY9zRQe7EtcfCELH+Jf0X0VP8IpzB0a9H/ngcBxUbkauoOcoTvGVoGWdv+h3YBA4nND++pZg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9899.namprd02.prod.outlook.com (2603:10b6:208:480::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 9 Sep
 2026 09:56:05 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 09:56:05 +0000
Message-ID: <762d160e-974a-47d4-8f0a-6cd7f6a4c0b5@nutanix.com>
Date: Wed, 9 Sep 2026 10:56:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: bump sphinx_rtd_theme pin to fix --enable-docs build
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260906222926.3714852-1-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260906222926.3714852-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0114.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9899:EE_
X-MS-Office365-Filtering-Correlation-Id: d9776c66-297f-4b43-ed15-08df0e589051
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LfSqvg+GcoXkIOEiO48uhXtrdqh9xvSqb1nIe7sCDE0v8vvyjqmfmoSyOap71/Jr6IrIfzzaZRdLAKofD1SFNxStLDaffNsAtfVyZLA5v8pTse52tHyKlEUUfiL36O7x9jXAYrKeucKn7OPRPlwui7H5PUz/L5ae6sa2aZPmdj/OV4v78WH26KHTvTZak3Wl2dFmpucppKZerPgAUY1SRqHRvGG1o6sQ6TSkgeTsESY63l4Usw64KXZDZ4EtXQBVbfuQbDnNfUURuLOisHI1SfmRAtWbN/iq+jHp4l6UxzeMOiHDFkLSKItpatRPFRq1PDeTFLfFnhy8m0B8iCecX59Ra1VwwiZy4LFRevZFGonT/Ry0pTzUvENAxrrF2vc0uNsNC761hNxWxDtOctotWTO242k+0UmwITctfmvPHZygrWvgVbllIfUrly0eDWvW7W+scmgd7CEMuvbSthvC21ay5k+TVu9TCsbvFYyEUb54Rl5Q6ir+f+fvZauk/ZXmvlQ7VfJ9mPfy6IOee43SSOp7VCo0qLU87b03oOn/bwJxqN/YGkbUS6AnzCjodkrM6dMkcC8f2AmnsDGPGT+4gn1UWpn74fhPKo61vya5dRAxcklviodzqy56HhbG7HHQQ0ymXzeeQZIxabZMORQBvoEDDXMCSirbhUIzPFyGGyc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em5HTlMybnpnMUtJOXkyNGp1M1BKbXJ4T0xhaW5rSUQ3S01Gc09pTjg0NmZW?=
 =?utf-8?B?aFN1OFBHSkluV29JUWcxS0dOT3hsLzlmdzl2K1ZDaUE5bnRzWmhxOUlaQ2Iz?=
 =?utf-8?B?REUxdHZSZzJTclViM3JCVzFLQTBBQ3o2Y01jWEk2djZtdCtTdjhkVmlVaEFo?=
 =?utf-8?B?ZnZIYzBxSEpUeGxMa2VGZ29lckUrYVM2VUdJZk80aThhNWZPTWpFRmN3QlNx?=
 =?utf-8?B?TzJUWm1aclFWaFluTm9KQnFnNGNzZEZQWlpwRUYyTlJ4b2ZQNmxHcWtEVndH?=
 =?utf-8?B?Tlhrak0xaGNPbkFWR0NwYWVyOExXYUd3MVZudmhManVBcUVuRlNEd0Y0cjNC?=
 =?utf-8?B?UjlmUFg4YTNMaEtQR0txK21EV21nTm4zYitiTnNoS3NlN1hybFNSa3BjY1VI?=
 =?utf-8?B?WXMxQm9QZ2lTY2ZHOW5OcHYxVkZCT0h4Y2ZqL2FYdERiTHFwOTBoSStyM09a?=
 =?utf-8?B?M2dpMU02RHVDMFo0dHVWVGt4VDNlYWJjNVFycC8wWjBXUXhiUVlaV2dHY2Jp?=
 =?utf-8?B?VXAyRXNSa2xzMHN4c3FGV2wvU3VaTDI4c2xBUnYzTDFpeGdJZjFNS254cEpx?=
 =?utf-8?B?ak5oenBNdHJkWktsQUZGdk9hREVSL01va1NYdVBSSkV2UWVUOXZ1MFhBa29n?=
 =?utf-8?B?SzZvWVVRVFNZNkJhdG1YL2x1MDVaZ0M3Mm4xeUR5SUFla29QQlAyeG12b09v?=
 =?utf-8?B?bVJiUXExODlyTHBSOWlvNU5NWVUzWnF5QmlYUFF4VHc2OTc0V0pScm15OHl5?=
 =?utf-8?B?YXZJZjZzTHQvbnkwVHVDWW9HQkgzYWpNMHpCTW5SWnpjNjE1Zm5zdUNXTEh2?=
 =?utf-8?B?TTVNd1Fic1FReS9hSTdhMlFZSXJjclZWVDdMMGtjeXhYR3kyVHpzMDBzeXI4?=
 =?utf-8?B?TEZhRythNUFJUitoT094SUhyQmlja2o3SncrRUVvU1ZYNVNYcEhPMGM2REp2?=
 =?utf-8?B?dE5ydXVvSFU4Q21jM3R0YVowQU1TcVBSWVorQjMwZm8zNys5ZkowdG13clBZ?=
 =?utf-8?B?SFBmU3ZBWWVKN21sMFFSRDJYRFZZcktGUFJUU1pCR2hNdWdLMC9Wc0J4dzY0?=
 =?utf-8?B?NU5tQnRHSGV0QWZ3SkFFUStIeFlYZ1pmRVVSMzdZM2hiVmhiSlR3UVN3MTlZ?=
 =?utf-8?B?ejBiQVlMK2oxTHFrcXZreHM0TC9MdHE5REFiRnlxNW9OdE05cC9TdnRKTGgr?=
 =?utf-8?B?ekk4REVnRlFBdHM0aG9BeTdQT2VXSHdIWFZNdGpMTTBXTkFSYVZGQVQ3T1I4?=
 =?utf-8?B?MEllWjQ4NGMwY0RxenNZMUhrZ29hUVBIWktnZ09xTDBBay80WGVTWXd0TUlI?=
 =?utf-8?B?akYrQkVrRVBVVjk4VG1RRkkzQ251b1J0MVJ0S3dJVlgvMXNBNXFwcUFCRm44?=
 =?utf-8?B?VnNJUWUwaGFDVUhuTkpGWEZvMHFubDZCcmlzL25PTVFQRU1oTUEwYkc1VUxW?=
 =?utf-8?B?NTM4VTdMeDdLc1RqRnJWQWdwdndNWFV5cTY4TlRuSzRtNXJlaDdjMmlXK3pU?=
 =?utf-8?B?ZFlVdyt0YzlXTmIydHNwa3BRNUp1b0NoV0pJQmJDaEdkMVJiYktLcmRuZ1o2?=
 =?utf-8?B?WjhLeDU0R3F5MXpHR2hjQXgyeXdZVk5GUFJLVGV6d3lRcHFvbUNieGxZSkJa?=
 =?utf-8?B?dnVYWUtTcURrVzUybUc0eXhxcGVVR2UvVmEwSXVER2luWHgzUTJHNkRlNnln?=
 =?utf-8?B?QWNBSkxZQWd1Q0xRUWh2RXJLeEMvaUJucmZQTjQxUTAyZWlya0RzL0dZcmRr?=
 =?utf-8?B?SFBxQUUxbWpsYkF5NndhVTdZUC9TVDBIYzdzUmR3MnpzYUxZdnQzQmNUNWZC?=
 =?utf-8?B?ckRmR2ZBeGJpRUQrQ2FER09QUHFBdzdrVDl6Mlo4eWRDbFdGdUs3c1FmZ0wr?=
 =?utf-8?B?bnBEK2plb1FvcXR2aFlabks5QzhaODJoUWlIOUx5Unk5VFY5aHVka290cERN?=
 =?utf-8?B?Vjd5UUtYazhyOEJvWGYzVUpEZEVQTUg0dzB3ZHljczJFY1hVWElRbnVsaWhY?=
 =?utf-8?B?OWU2V1VJeGVKOEpQQlFOdGhzQXhORGNyYmpWckp1bi9zMUZyRDlLM2U2MWRh?=
 =?utf-8?B?d1BxOFphQ2dBVDdJQis2UWRLZUJyRDNZVFBBUXlMc0srZlI0ZjRDQ2d5OE5v?=
 =?utf-8?B?TVMxTnJTVGpEVjhhUS9zS3ZxdXl3VG5UK2ZZNmV5YTFvK1VYai80dlpsRDNB?=
 =?utf-8?B?SVUyc3JmbE5KSGdUOUhjWkRZWitLdUJ0Qko5TjEyYWdzRlFvVFVEeWRQN2hP?=
 =?utf-8?B?MXVacWp1dUlXVmpBcE82OGdBZGVRYVh1YzFINE5hMnBYVTJqMnF0MytWQVUr?=
 =?utf-8?B?RzlBbDV0a1JHeTd1VklXNjhWRjJMK0tHbkNqelVLejc5UDRPWlpBUVNTQStW?=
 =?utf-8?Q?fzE7bfNg5aH5j27Y=3D?=
X-Exchange-RoutingPolicyChecked: kyQvINN9hyPbmwx9hMetEpZewou54R2QAnVbN3aAfU/2coohzKtn7OYUxt8WDk4mTjETUvT5ZfQXtfyWwwNVxoKLpQwn0jEgYwtnUtROLz4kBNWav25xSXJLPYt0K8Y1v2pJ9csETi4a9AyVk50mNkR9Bf0+d1B12TFRZtRm82Wlniwtz2Ajl38fLL16D3O2uqp+PNt3L9PluR3peQ/VBayFjU1ocDU5hmXNMmnRwelsw6dRiap+B9N648Z8JjO42jz5o3cF2Sb7M5pPGPhTWJ1lLVNM0NaK7TJjFrqGTEws3nVHeQMLDIwSnV2YOyYzANd4wCm9v0+rBczsT1bszQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9776c66-297f-4b43-ed15-08df0e589051
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 09:56:05.3461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcFRlZ+StOzJzGC06RU8x3haeDYqB3e/zs5azaaZ/IZ5/KbetB5U0O/yylcRUlCrUR7nLYeyY/vJdJ4E2Dnd4mrFMIDACWQch+hwbn9Vc30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9899
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDExMCBTYWx0ZWRfX3fUT7EjGAOeR
 gj8rzI6oYHzYajL3gR1C6NMYwm+rXwV2vOV59vmPYHcbVJqx1hwG7GcIlVuxf70z8XzSeXDSjD8
 GJPYG2dMv/OyQUmVoONnOHsML84/J1HKHvfj8ei71KoDygwD2U/54AlDcd6x6gKjOwUOUMN7RK6
 VBh/o9HI8z0/crgHW/Wf8Ncc1OcwZ+sgK4sQMSAziaO1h00tf1VT7C12Z2lSsh1tsUGVv3avpMn
 nGNUcl/+jGdNryCsiUZinpb+jfE7Fe7OtXetNoB1VIeUu0k6MQhgTExCdtbBD9qYFAAzB7lXwk1
 dejG2fiqkYyxq5+mIhGcQIB7zSgq2GCl5MqMTTG1rmlIYSH6wIYY0txOx1QnMo9J4DPwUo0YiFS
 AZTQCKnweUh4gWhx7FhSGtDpnrn7zT7SkzavEJLY6NxFmuXWSecCCLO2Bx5mT7s/Sq7I3kXUQyg
 KprzWXxq2ZZVDeZlTig==
X-Authority-Analysis: v=2.4 cv=d7fFDxjE c=1 sm=1 tr=0 ts=6aa12d3a cx=c_pps
 a=n/INy9n90Tzyn9GwErGIDg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=EUspDBNiAAAA:8 a=64Cc0HZtAAAA:8 a=btCSBqAgc3IY1lVz_GsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XiKjPVVhFNsBSfvYihjvtU_S4yJ06ghE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDExMCBTYWx0ZWRfX5TcjXxdcloU/
 e3C5I0jLwDb1I2YIO2tEifTseSNEL6L/M4gQ9AZm7rQnKFsWBGsnhgYhTt0ESIvuXg9VM7PVuXD
 trkvzGn98dB/LcwUQtI1db/R7QRIBr8=
X-Proofpoint-GUID: XiKjPVVhFNsBSfvYihjvtU_S4yJ06ghE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
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

On 06/09/2026 23:29, Brian Cain wrote:

> pythondeps.toml and docs/requirements.txt pin sphinx==7.2.6 alongside
> sphinx_rtd_theme==1.2.2, but 1.2.2 requires sphinx<7 on PyPI.
> 
> A fresh install of the docs group silently downgrades Sphinx to 6.2.1 to
> satisfy that cap, which then fails Sphinx's own >=7.2.6 runtime check
> in docs/meson.build.
> 
> sphinx_rtd_theme==2.0.0 is the first release that drops the sphinx<7 cap
> and resolves cleanly against sphinx==7.2.6.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   docs/requirements.txt | 2 +-
>   pythondeps.toml       | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/requirements.txt b/docs/requirements.txt
> index c10c4cf7c91..509d56bd1e8 100644
> --- a/docs/requirements.txt
> +++ b/docs/requirements.txt
> @@ -2,4 +2,4 @@
>   # Should be in sync with the "installed" key of pythondeps.toml
>   
>   sphinx==7.2.6
> -sphinx_rtd_theme==1.2.2
> +sphinx_rtd_theme==2.0.0
> diff --git a/pythondeps.toml b/pythondeps.toml
> index e4c10d4a9f7..afb1364dd28 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -29,7 +29,7 @@ meson = { accepted = ">=1.12.0", installed = "1.12.0", canary = "meson" }
>   [docs]
>   # Please keep the installed versions in sync with docs/requirements.txt
>   sphinx = { accepted = ">=7.2.6", installed = "7.2.6", canary = "sphinx-build" }
> -sphinx_rtd_theme = { accepted = ">=1.2.2", installed = "1.2.2" }
> +sphinx_rtd_theme = { accepted = ">=1.2.2", installed = "2.0.0" }
>   
>   # This test group is for dependencies required to run various tooling
>   # and tests that should always be installed at configure time. It should

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

It would be good to get this queued to master soon as my local 
development setup is currently broken (particularly as I'm working on 
series that include documentation changes).


ATB,

Mark.


