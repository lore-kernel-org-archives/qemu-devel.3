Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0DAC982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8cK4-0005dJ-6O; Mon, 21 Sep 2026 07:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8cK1-0005c5-VI
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:36:34 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8cJz-0007uL-1x
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:36:33 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAflPN774316; Mon, 21 Sep 2026 04:36:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=8gjkjfxiZvA4+jL4OtKK6YsT1UR3BNTou2SlCId02
 3g=; b=y0kGODI77eISiubzCifivXkenmM56m/VeE0Q0zR2k1SuI5lNxNGoPLEBU
 0IiVepUwH2ZTcQz+GHBxeeeN4di+3VfXfkIuGfIrSET0yiwA9mHNSJ3QaRNAGWPt
 ZeNhYfjvugSVJb10yCQMaCPEY4ddXhesvA32zw0N6cap6WM8zkufZZAj4Evs7ulv
 cutJtibdUhYX/foRxEiqu0EQO6qopBKtvgvlH1SdDSv/7ole0wKJOmvh6hN2Pmcq
 WQN20Klpz2cFtW6xIOhK9PvQpPcuw/wAIU0PaDvJDq4XXNN01YbQsOFTXV2e0Og4
 lsRqLdR5TCRK65uDOtnHUdECnpBsw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022121.outbound.protection.outlook.com
 [40.93.195.121])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gsqx82xaq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 04:36:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nF47FlpKtkEj4+wDXNvBHc0TBcz0Wyl69tP03a5fzn9fJA/Yn1n7U+vpfZG6JmkwGeJC/e3i2gIWR+vpm/Ym7Gp8gpVTOK0J1eDFmYE11E2kCNaWLN2NeduuQgHk6HgGSEiqJeD4AQiptagaSagxN4BkdRVz9bLg94azFNthsBrUUuv+n8jDBjEqu+wsg3AbW/Lx0vKkf8HT1GRaI2W+xF6+BKrKvIRrvSh19ofTN/tbN6Z5Bq4uA/IdUXlUaSN6Hp3l6TUcUaE2El23pgHCHlJkaK9Cr9xYquT5jWQ723yQwG42yaILPnAA/eKF/VgnOG58HWwQbwIoucV7gps8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gjkjfxiZvA4+jL4OtKK6YsT1UR3BNTou2SlCId023g=;
 b=F9Thpf908xGFUTsh6kFyTGJZmtzSWTjCtQM6SqJEqUmXnuocj7dxn8j5E+M/ZAWuPPTiH8pHibWivkMUpr+2G+em6OLHb3edtUN8sdgtkVPigGNzBV4ZiUyguD4EliLR/qthF1Qv10waxsnJ8/f73C0a5W5W6a7ohGUd2vvj6ILkXSw+tJzhGii89n6x3MI7XLjLiTW5XhfpCdepQIy3+/N9/A9w71/YwuaSb+dlNCbXbvolmr0P2PKJBuz6inQIxb7m2KPqB1JUZZrmq5YdGa6LQYASqQj2valxuB6cqU77WYQ5UpI+Mu8wcEMu+zSIHza8ULxckOgGH9F2ExoXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gjkjfxiZvA4+jL4OtKK6YsT1UR3BNTou2SlCId023g=;
 b=xyc8SesiVbG7JAwV64Qg8qSZZUyuiBTBBcMtUcJ2NLCe5Gi9RcMiib66rNTvPzXJbJ7MFudSbinhm8ri2099LqogLiX05O4MxOD5BCg26doStWVT+MQB3FIq+9vrh0kcFt2rinoO8LTNKaPZVXEEvKAFy5CmUVtnfoY8Je1qbJovnuhn4s2FsWAkEfhCTXtpSnoSlxLDTNI32+XwgK0r5l+RXinFcP2aNKVnASz33ggwnjIQRfcooh+gHHKS+agsUqYNJptB2VMB0eolMY0UzjMgLgb7g3w6adOMk27W+KXF+jpZNLpSs9Lzn6WGKl4fAfNV/Xw7ToVNdJklnQnkow==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9416.namprd02.prod.outlook.com (2603:10b6:a03:4c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:36:17 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:36:17 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v4 4/9] qom/object.c: introduce object_property_set_alias()
 function
Date: Mon, 21 Sep 2026 12:35:10 +0100
Message-ID: <20260921113559.1299740-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921113559.1299740-1-mark.caveayland@nutanix.com>
References: <20260921113559.1299740-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac1e7eb-6642-4588-b6ce-08df17d48ca6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Kd77dx44gBRzKrcIZTJAcLdyxGIoG/eUN7TH+W5dTnpYKun49nDtDijZslp31ZsYA59TTkwNTw56Br9avethH8skFoOrYyn3dpT7iM+AWgPKeZi1TkJ5xEShUi0gxTOsfwxDj8iQSaTGfwzMMPCzNmaurKA78PE+H4CtL+Xz3sMJxGU8c8iBg8HLiKjBVPbDG4m4QAhMDx/R/uGu8vDWqghYyaND1/vpeOpWZo2KPDfmOqZSqtdqj/+LmfsBYQ0ZhZOWk5yqq4kv8tCu4f4oNZqCVruo/zAQ2nMnAxB9KCUf5NQYuFb0eLEBN2VCdKqdnwiLBtriC9Y70GuQ0wMUKMsFo/e7Jr5WBhwK5496hP+iRVomfU+lN9wMtTwRGjH4fplyT/mwm7XB/qHpfQYTo5xcpY64RZt0ZacmQ6I5RGi/aB2yPlCyyyNnbYHt0h0jBqq47rsLAgL4kPes4DCbuxyEnauHWftpDyoBEtI68nCiIY8pVvkcxbiuSlZdWZpcLdhAT5otToaDbPa2lp+nXftLNSlprNJjjngow5jykRDOTzDGoc+77i9FR7+JAT+x1b5ePIkkGukzZsS1JpDbzjaDT18q88F+Ue/HBuroPE5lYXJxO90a9nvs/cbtEoEuStVe1Wiob/niAWn6uOZwYAvsXJ7u8Qq+E5EkN1eqw5c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vj4Mk7oil6FTwo3MF0dJ8f9PwludU5ZjnLpWsteqBNV6/e4P7l6mYkN5h8H1?=
 =?us-ascii?Q?ny0rNLlil6E9yb0HTp3VYxZS9AVU1bVf7qgsSczAjpzijEay8jvWnFankMYV?=
 =?us-ascii?Q?iZADTVTwVaK7ml9bXBOQXHwWNJJcmK0bn/FQe57yuPUPNFGmXV25H25dEoHE?=
 =?us-ascii?Q?L8QC3t/KXzBJ7Wdww6dlAv1S4k0/SMHfx7qxDjtPf7uY6PU4InpKTN79hh9L?=
 =?us-ascii?Q?FrtD4oB1OYnsyQqiwm8te0W/UP+e922fek+VWi8CaMt/HimTvSiDOZZ2lO6+?=
 =?us-ascii?Q?vJmUnDW7XEtLeVanfC9cfDOOue8UJTuquwv7w3rBvhTe2FsX98ypSIGoFKIY?=
 =?us-ascii?Q?m0IAtBoEfJFfZwgzollEU0u/jR1bx0QKc04moDU1cXUcc1TDBUL7bDo40MpN?=
 =?us-ascii?Q?Oz1wuXNsS+5k29UxFbXApHXPkZHkvhHCJ+X0wycgmlb2UpeA1yeUEB+zlqWt?=
 =?us-ascii?Q?N+aLDDo/iyZNWjJanA+5xB9DH9xt4AcjmzqaaDBi188MaJ5a3CTBoXaL/TLH?=
 =?us-ascii?Q?qr2ZHIqqWrPt/S++CIiMOgjVID+cY08vMgSEFOCcmALYQpc5Y3v2zsTPZZ7k?=
 =?us-ascii?Q?um9MBKGE/oFHHzSBBugZPUAXMSEyegnCkdkLMPRAtX8HYg1dmZomH8Nqa9W6?=
 =?us-ascii?Q?Esz0iCoUIL7rts5bVfBZXH585kQaQgh0/3b05sW6DJUnDOfi7BKHi9qjWPLj?=
 =?us-ascii?Q?7XfS8EApgAGWL0QTnd8+dXLmR6CvryP7Zx9OD8yj+HWPXFd9HkywcjhPtXxU?=
 =?us-ascii?Q?lZHOdO7sIXaiY+tU8NqirMLWfQ33A+1ST3jz5958AWn9jrkM6UFHELdIBGdA?=
 =?us-ascii?Q?GgNRVZWlVqnNejln1ux3AZ3FqacIfdhKyM3In76mlPN/7npeuar75G0tMaOf?=
 =?us-ascii?Q?1JI/F/t9ktczFZW/eBe6Y+pm4/NiI7JU1w4XXSkp9kG4Q3giZHTdEqDvDdzP?=
 =?us-ascii?Q?cz2pDoXovtjbAf6m/QEZzJuO35DiSN5d0VewFGpCsrRFm1NfCqRsok3SxrWZ?=
 =?us-ascii?Q?XO+9IOdJ1FE2UE6U1Z83eb16190p17ETIk54+J/UUvT9GZF5br2RYoTehYU2?=
 =?us-ascii?Q?ipa5AD7efDJQ4014pROfdKNvOROJimsgCmLcO6nQrqK7qnAPhlDDCJOIGXoD?=
 =?us-ascii?Q?bg/8L51Okc/0p904X0hzt37NLZ7BOYzWeUnakrlhNk6CGAvxtOVxYIrLmQ3K?=
 =?us-ascii?Q?cd3XmKE62hl9o1recPLfKat0EjcsHAVJ54r/cd4QTVOx2jU2Utehnw9jKYXp?=
 =?us-ascii?Q?srGly08Sxf4RJ9U3v3/sBCOGpRCNMuIFN4M6mMy5IaVhIGV+63bR6ANh25ZK?=
 =?us-ascii?Q?OKVef5GuQO5IoNXWeO6h76t31tdDRVJ1Kv+Pwcb7Tfw5qLnGcuVIqyhtSyrL?=
 =?us-ascii?Q?bLoe27q9arDPNzu+n+Glnp9alTKToRQGC/fvkDdIbu0EgMpN2DpM7Pu4FBTW?=
 =?us-ascii?Q?zvSmF9MWAHW6kWKMpRNdeyS3aTLvfpQHfVJhQ2D7IBTu5mKFAKDLjPmvds8X?=
 =?us-ascii?Q?owhM9WsViL8Fj65rnv9HpsIIj0vC1YRciCEENER99AtKYZCWoCGium5LT7np?=
 =?us-ascii?Q?QYVhrwnxiQ1sh4cSrX1pXK9xxKJdIqEoPq5vay4G37gCKZUDawcFcBtNsjU6?=
 =?us-ascii?Q?ZMhMOFDCAnWhsT7n5+dOj9q0rPdSdeSPhetmTl2nR85YWB8c4YfGJksA553H?=
 =?us-ascii?Q?yiPC7oZIf35pgpchLRMgQQqgR/B+F9GXpWmXDWBU5HNbsXvkean6BJJBvYMV?=
 =?us-ascii?Q?ui3Hj+xIJiDkk85SwC26a7LzbKW9PSw=3D?=
X-Exchange-RoutingPolicyChecked: Z1pL017o7fX86ujwt7Rr+r2KU0O3a7gFCicxHyYICALcodGPg2API+BmuicaRT0Gd/Dl3KEuHwYDXE4rVm0ofW8FOMPpCVSG1oT6yEr5tLZ9SrcGDxwj3Z/Q7gmJdEzYEeUK4H4EDRXw2Lh4ZY26jVRqHufZAkFTw0bXLWF7YDMLfiyGEReXclLB/EJwOz0HP8TCeKTPMPtMLiIMm8ZaD71hpY2SnN9fvfzn9tSj6k1SOVQj2ZxPihbmtQnQbYVQa5jUMQoyLYFh+4LRBT0xy6Uhs839yhTb7zJSkUggon6WXnVNrEzoZojHb6jMQio7s0IWEMASglpXPBR3CUM8zw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac1e7eb-6642-4588-b6ce-08df17d48ca6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:36:17.8188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3np72zbbRoXch+Q/Du2pfnu+ONwdz3u7bAlGN3XLk3HRiCvq6DyV8V9/zerAwdSaDLpdW8ECOgIs0jMJ9WHrlHlBd6gYqzzbvdtdsPHK7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9416
X-Authority-Analysis: v=2.4 cv=KInPn1Fo c=1 sm=1 tr=0 ts=6ab116b3 cx=c_pps
 a=DyfKEl/nMH7vw8kk6njFLg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=cNtrz4puXHHLzHPMHtoA:9
X-Proofpoint-ORIG-GUID: NETn-ypEnkl75DHQxFVPRYMPhDnbL2e4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfXz7OpKb5gildo
 5OgdnzTODwpVCLQjNv+suv2+rrqoMtHf2ha+ClodgeZRSu3v1kB8SuF0bHjAebBBOyKJAire+2q
 zoThOHkTe3UqV3my97dKpeYtKnDmIYs=
X-Proofpoint-GUID: NETn-ypEnkl75DHQxFVPRYMPhDnbL2e4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfX/U/5AGcd+WgT
 4WVkdavlnTarNN5SDt/+05ugStVVTEIOd6NPWpOTrV/q+JTJ4BIzY9BMBQuG+Zw8JC6PlzYcPwu
 h39dVK7l2Z+woc5XNliUKAFyPwnNYewT65b3FjV8tsqx81sXoguPju2JdhMeiCDqGFyGv3mOANf
 Gt3rXJYCr1j+J+Fci2y6YoSVPRnVJIJm/Jhqg+V405KWtqgoeFxdpVu9pz3gbM8D9vXZuMdQJv5
 Dgh+GE7ck6lVuGGIf/3xgzivRh1XW0+K13TkKE/9qvpAYfLaSRISgP5e56G4GTalTUhUXSTWyty
 RfNSl+r1F717cTMHANoJe6Z+cFsoY2Kko0XsArBB69ngV9XUfgJG2uYlWSdKYPFptjLPnXXkQLD
 sid9QBT54K0ujYciKsRqgY5ukYilmUN9Qfu9bvVkcfntQHxZgb089aOtLawwM3vFxpMsHnYtrYX
 //9v6tACiGgCEUuCzPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
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

This will be used to set the class alias property for a specific object. Note
that this function is only required for class properties, and will assert at
runtime if an attempt is made to use it on an object alias property.

Update the existing property_release_alias() function to reflect the documented
refcount behaviour.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h | 17 +++++++++++++++++
 qom/object.c         | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 73d72619b8..4c0645817a 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2324,6 +2324,23 @@ object_class_property_add_alias(ObjectClass *klass, const char *name,
                                 const char *target_type,
                                 const char *target_name);
 
+/**
+ * object_property_set_alias:
+ * @obj: the object upon which to set the alias property
+ * @name: the name of the alias property
+ * @target_obj: the object to forward property access to
+ *
+ * Set an alias property on an object to point to @target_obj.  This is only
+ * required for class properties, and will assert at runtime if used on an
+ * object property.
+ *
+ * This function ensures that @target_obj stays alive as long as @obj exists
+ * by taking a reference if @target_obj is not a child object or an alias on
+ * the same object.
+ */
+void object_property_set_alias(Object *obj, const char *name,
+                               Object *target_obj);
+
 /**
  * object_property_add_const_link:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index e4e8dc6886..96498f3d00 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -3126,6 +3126,18 @@ static void property_release_alias(Object *obj, const char *name, void *opaque)
     if (!(prop->flags & OBJ_PROP_ALIAS_CLASS)) {
         g_free(prop->target_name);
         g_free(prop);
+    } else {
+        Object **target_obj = object_alias_get_targetp(obj, prop);
+
+        if (*target_obj) {
+            ObjectProperty *target_prop = object_property_find_err(*target_obj,
+                                                           prop->target_name,
+                                                           &error_abort);
+            if (*target_obj != obj &&
+                !object_property_is_child(target_prop)) {
+                    object_unref(*target_obj);
+            }
+        }
     }
 }
 
@@ -3212,6 +3224,35 @@ object_class_property_add_alias(ObjectClass *klass, const char *name,
     return op;
 }
 
+void object_property_set_alias(Object *obj, const char *name,
+                               Object *target_obj)
+{
+    AliasProperty *prop;
+    ObjectProperty *op, *target_prop;
+    Object **target_objp;
+
+    op = object_property_find_err(obj, name, &error_abort);
+    prop = op->opaque;
+    assert(prop->flags & OBJ_PROP_ALIAS_CLASS);
+
+    target_objp = object_alias_get_targetp(obj, prop);
+    if (*target_objp) {
+        target_prop = object_property_find_err(*target_objp, prop->target_name,
+                                               &error_abort);
+        if (*target_objp != obj && !object_property_is_child(target_prop)) {
+            object_unref(*target_objp);
+        }
+    }
+    *target_objp = target_obj;
+    if (*target_objp) {
+        target_prop = object_property_find_err(*target_objp, prop->target_name,
+                                               &error_abort);
+        if (*target_objp != obj && !object_property_is_child(target_prop)) {
+            object_ref(*target_objp);
+        }
+    }
+}
+
 void object_property_set_description(Object *obj, const char *name,
                                      const char *description)
 {
-- 
2.43.0


