Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DDACCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHipw-0003pG-WD; Fri, 16 Oct 2026 10:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHios-0002qY-MP
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:22:09 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHioq-0006je-Jg
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:22:02 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5JgV3050717; Fri, 16 Oct 2026 07:21:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Gc5sSKfDVB8R4X6fBb7T55UzLTmJFAUuEnah/iYPL
 cw=; b=MB37VXHSoRoJROd2319RBofU8v8zOrE5cMwgjJZY4Sy0HrtClaheOvOW6
 fHR4TdgWeAWUKAowxSfzDYDI8coEyvwrUgUhIia87VLObKI/3ijLfqPGPMRyW8Ag
 tMDSiOqRisj9snTvBWoWzEFP0D0MdsuZk8MzsBLv1qTQ7ZBiSu8ZKbTRMbCGJcdy
 sZFF66n0Jhgv8Nf/zng1XVsFW4ptRCFnU+9vO8RxyLhiuHITxgSWvMt3ddM35ola
 iGM5kwnk6VfuZu/Ws6Trpc7HlUQxoNM1uu5/gjoL7z0foYF4zsI3/3DvMFj7oX+Y
 7ElCv9YnZ9pTJ1vetewP0q9LpSApw==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021114.outbound.protection.outlook.com [40.107.208.114])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hb7t19qsm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjLCjhB8bNps6sVgZELr1AUFpd+BaJ0RTVsvemYt3Irw/W2FyAzpHi/Fm5u2bJotK7LejMLXjHZtuodoUFBU1CnjpT5jsnqpQkrgO6MIsRbhnK/Z6dsbR46mdTtRCU1SFEn/townh1omYfLkUFi5WcEEAui8Fxjyh29vsveGan3d2TXHy5EZSlblmidmSZDoVpizckjZvDqkJR+J24EGPS+q8kIj9FzAJpKIudX5q096xUCGS3xHkaEmjpzATBgqewxFcp78GeGdNR9WFOUZLl8ORdrV/hCxX6M3dEwq17VlPLZWbK9UBKhQGwHz7x+R4FA5Gu7SnbpvduOcf2aW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gc5sSKfDVB8R4X6fBb7T55UzLTmJFAUuEnah/iYPLcw=;
 b=MGryjAJHXdp4lyl+bKkbJEgQfvsS6+mjwvlNCKLNg7Nm54Qb5m+4p05AQElcaoK1zd8Xt2qcxnbajHu9YsrVbCGu73nfuUtP74JHrAKECnPt1cx618BE26nAXsQWVhcIB+O5g0efrsaJVCSyAnce3liTtS1NZbTf0RHKXIvf4vkAYesaDeGUE7XEECR4JdAQlWGObjTW+KOfgkLox3KwLyc2m1czSjunn0R1D1/aSyfdPJ6n9MpBnOrabdl9gj3Wu36o8RjIJ5Z3wwB7z7J2vh+gIDvvO/VODQWhDiO/Yg3oj3gQ/1j9JMQrHXd2nXHCu+euRhE+fVEt/HKR3jfgcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc5sSKfDVB8R4X6fBb7T55UzLTmJFAUuEnah/iYPLcw=;
 b=t0TsMdOi3CFTPgargNj+Tt5Y8p52wGLrlWB91qpoF7AL3wVSm2dOswd4hr4k7fjMnNaMmTTpOLkppoOqdNzczHTsIrf1KQqqEm6h1vM2C5oYvDqOENs8Awt3IyEu0gVr6+yB58sdaihh1JFs6+VCXmXx3+JJLIH6yWWMKLCOTq2gHWiy42DbXaMvfd3C1933NJ3rPDiwlnlcMmQ4khTWZdrAHTTxTNzxJyYFmZMgx7xovZ1rToyd0aYHO/junK9jDyfa8eVBsUmeIlAcMCZxl94uWL4wrWjyU2xj+R29pIZpW6MzNE5zyOosFk0KXKsQdcMfT5htgsuwENzgZQRbFQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11424.namprd02.prod.outlook.com (2603:10b6:8:352::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 14:21:51 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:21:51 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 18/27] i8259.c: introduce TYPE_I8259_PIC device
Date: Fri, 16 Oct 2026 15:19:24 +0100
Message-ID: <20261016142031.1204281-19-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0193.namprd05.prod.outlook.com
 (2603:10b6:a03:330::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11424:EE_
X-MS-Office365-Filtering-Correlation-Id: 40dd7927-25c3-46ec-06f1-08df2b90d20c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|10067099003|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 2im+Io+AjEikp8s9b09Eo20ptNbv2qAgRH8JvxbDddfqg+8T1gwyGmbkpd/afin+6hb9EhhAPqVixdWS9cP9Ih2tWY2o9DXXfqAGiw1qiQoxeygfUmusNTxLFYZU8SjdYEwZp2y5cXY1nMcRgvPuG1Ax4HXZlbLAX1e0LDlwnGwwWGeNfg9mmxMIN886khgsiWk9HtAj624hRodijrcqgCgtYN+yNH70Ac7+ADlKmFr7thR9zmVPLZhhX1iqKeW2qVtBalK/9BTJ49fYTnYZzfhzMUCspyrmNgbQSJPoFkcKD8Fxl1hyuQYnvlWNUzUUpZ8wqlKVCIA0IAZBzCzGWHgZ/dmuRiboJVRKf1eL+1NR/WhT8AXCw5V7FWzRHno5kEGtn1ZEpfgfepj62WA2ScMj5P8SxMTKApYPmBRKA6XL4fR2nX9j6adWiWQYpq36P4Z3h0tHhfbpKobnHzGYpg37azL6PfSyLAuEJbKbhpLIBhpv9RiXhAuDmqMtguKq89aB2TCCnAfJm1n+mV1MImniknKP6cwaUq959AxTDeu4n4oFyblzUoOH1SNnLdf06aJAITeErSF8DBTD96e+beGr9jWQpsoxdbaPPkDnwTtQsxg5obODAtJpSHeZDCMJym4vmRDu4XMccKqxXfopNrdgZ4lntEFDZuc8LdKGvj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(10067099003)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?axns75zRaWZ7FU1rqabJ6Hd1iaxIv1f6aE3R5godDc0cObanGxaHbmSmrqnT?=
 =?us-ascii?Q?nyKeb6RMcV1XWcG0p1WdJ6cMrE5FFmZ6jzFEYQK1zdUI3ryurkgbMioFCgYw?=
 =?us-ascii?Q?hVTJm3jPJAZTXQiigSv1aHloS0lJg67F2WbKqX4BS8kzKvhbGOnqjwtwY1VW?=
 =?us-ascii?Q?EWD3MG+K1UeDIO2u+jg0kk//OarQomeeb+0loHCQ61Dyx1s9zp8qB03z+TjX?=
 =?us-ascii?Q?W/kYLy2dexNOCFh2gL4brgGW9XTNkj3/tv00tVig2n8C3dmyKNjFATYI2Q9m?=
 =?us-ascii?Q?1WEFtHxSsoik+jdT8my6mYbQ0l5XXfnQkJEDbdyoweqnWT4f95BcODstAU4J?=
 =?us-ascii?Q?5sQYONQDYSzwkxTX6v19xl5WEWApd2/FjDqBdL8/MVv/nSdJQiDgeHZ0z3xx?=
 =?us-ascii?Q?OMCMKPm8teX5BYNhlWZ5SPHQ4h+hj9IBdRxc8ZdRUkWoss/OnS2uv+u9H5ax?=
 =?us-ascii?Q?nLstFK7fXLbEBTVlNoddcQMDIZujBkBZO7/aEN+cNGiqz0zVWGw4/BhlgQbW?=
 =?us-ascii?Q?3wBbBwPADGUPuCz+FPUqfltabur4EELsCUagG/Z0+IsSRimKKKurJNtvzhmZ?=
 =?us-ascii?Q?UwLPEhEX674y6DsJAiaS6hZL5GjtSSSis9x2KodBKY546AIzQuLwzOW8cFWi?=
 =?us-ascii?Q?bXZZRI52OpaEnX4JlFzrQjjSmgoL591erE0ZzAArV/kCZKBHuOJJnBQkdysD?=
 =?us-ascii?Q?I5fg4vPDcAt/dIK+O6Y61SyjjEog778ZYHz4qK0YvM/6yyAQVUOaohMxxRMI?=
 =?us-ascii?Q?7RF/kJN+1UY/ayFyfaBR12lGxdJWbUnEQ+cSMj6JBM0lxL/u9BZhpdFMnaNM?=
 =?us-ascii?Q?hOPNm8CdrU2CIXMN1SegvEcokneV1n0wtLSxRRY8Gfi1RDRAFLXdAz/m6rBy?=
 =?us-ascii?Q?CNluauQ8l4ejuWFzhJtnrUGNRJKKaAl+MVLmd8rx3cpCT+NOw76g94zm43tx?=
 =?us-ascii?Q?zkCW4n4ITF7mvi8NdmUqcFnD1PJEA+yk+0vUiuSGoSpqx5EDsjGJKS4/n4M0?=
 =?us-ascii?Q?8ByCQYLtw+/Mn1mdBI1ROFiDvm3U1axXilQC1sdV78W/SnjSNA20zaFWgvQa?=
 =?us-ascii?Q?lvBMgb1t93iZB3sZGIV5tpVp+lDvs61z/AkIEUOEAWKKOxvlxbn3XfkFvAZ3?=
 =?us-ascii?Q?zD25Eowml4Bfa5qir9yRsZ/+bYtyy1JC0RofULtikNhdpBgMmPTU+5gEABW7?=
 =?us-ascii?Q?VhmE5IGORSDO2z5JTfn2olW25tXzSd5uSGxBE+FVP2YqbQ5QuB0zNTxR5RP0?=
 =?us-ascii?Q?bAZvEw8fDm2phlf+EYTFkrP1HvJUnyvL12i4Ql98G1o9LPJYLha8jAeBHMYP?=
 =?us-ascii?Q?l16S6HEhZzQv9RoSjkSprWTN0WXBA8lvUOEqg8RL7G2noXHuTSqXQqyVGJ8t?=
 =?us-ascii?Q?Y8QSt4+Xs6pmjp73BTvcNb/kRWQbv77NLFWaISC6ewyF7TRn49CaJSIkWaDd?=
 =?us-ascii?Q?tBFc//lu7mmcgbIDLw9QK/VuUaBs2TXEJAUNChWYMxvYC1k8kVTIQMA5B1+a?=
 =?us-ascii?Q?1dM5Wp7HDTj8yAw5+jFV7x306LMeSK48l1EgC8jec4uAAlWSmIaP3en6L2lB?=
 =?us-ascii?Q?ytvjtpIbaP48zf0nuYwqL1fKWMnRCJCbi/LAZp4xoT19gs19U2T5KgTrvE7s?=
 =?us-ascii?Q?DtWFYH6PoHSRpqFa41PtZBI69sMTLfVY8tADnqG1q9JtpWkocO9+LMiyp56z?=
 =?us-ascii?Q?mMZ0fLGaAboZTs86yHGocyzHggoSXUUtgBxuc0zC0DpEQ3IhywM9qGefqCTQ?=
 =?us-ascii?Q?ZhR/mYaeVwTP39UB8VrXIbzohh+1JFQ=3D?=
X-Exchange-RoutingPolicyChecked: ha6Jy6ySwPaCxYTcItYdET/PKPPJN36B5JRytduoMyP80Rp5+zFLscs3TV7gPrOA71OL1c8WkwD3c2/MsV8X7T4+fHnRkw+rl2HG43cOEOgInhLuyFpHNS4G5i6P02PX/zv2TVWhgMFH4SXA3Eb9pRSfuVIkWwIap5HPB8kWw4eMfHJg20Pwp/WdxA+IKFX4g6Zh4stCwOii19d84NP/x+tJG5GQ8rWvzEuITVxHteNLLC3XJOiGzFsdVIME/zyI7UKxirhVjc5gvVWCB0Omshdz0VidCuUHLcz5mh7c2mZwybELDYy1s+HfTUlytIH/+382jvxVBNixauwHUQTaLg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40dd7927-25c3-46ec-06f1-08df2b90d20c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:21:51.4039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Y4pF2uzMMK8b4BBDOwiQ2skdB3JUmYjSbzKnmXobHoV9jSd6JfGbz++NdB4nvDalDBgvMuAK15XcLOiWohS2w3JOu8U50DKsrDkDqRS+PI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11424
X-Authority-Analysis: v=2.4 cv=LsYHWXdc c=1 sm=1 tr=0 ts=6ad23300 cx=c_pps
 a=rSpWrHmMTF20an4ACDPPuA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=0XGB6JmbSUb4YdcodAIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX3saVKKzDr71g
 tTSSiRWbg83XTUgAdAAnDMMqi5UwRSmBX5orLsRmTr4CyimvFM2+nQYNFqJ1qYvOp6ASoQXhcmg
 BOqnrh+gRgj+UGNJC+1yOLpIiQt+LUQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX/sLF6PR5ve2p
 tF4OJ830tBWd4jKr4C0tH6TE008zsyAiXw+EnebTneSD79wk1vQstD7dQn5oWPxyzNbOWWJFSQo
 sdAyAyuL4XVbCtth+sXwhQsTD4Phhn/oTKq0lociE8NgUurvWWMVoD0EUl+/AljL8TbLsznyKe4
 1DQyI1T6ibPDF8xjDIkHr+Ru8V6gyebrZmUXQujiuPI+B9XVlLHnU/hVeDl+36dF1IL2K15Sc9+
 RI7OaD63Zc16JFEw2HIkPS0Faf8R9BOilXzy7LA9msZDyhvW/2SFQXHm1AwE71LukzAx87r5REr
 Yjlv8pksRu6U/I1tycSa9RJXZ9K4gsKahSDPmDkMtQm1pMt+wqo5Cg3IljlbI0XebWjjymqKmOx
 rT0s7sEcyevEU2asQUVxa7jPTVejZu8IFcHWWRDVmzg6BdodEuIruKD/Gy0wDGTJcJbK0OCuZNV
 m7L43nRA9TsEoPuhr0A==
X-Proofpoint-ORIG-GUID: Ne3dkg9vzRNzUPw3NtFIhLSjvSZ1uqSW
X-Proofpoint-GUID: Ne3dkg9vzRNzUPw3NtFIhLSjvSZ1uqSW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

This device represents a PIC for an x86 machine consisting of 2 cascaded i8259
devices wired accordingly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/intc/i8259.c | 133 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 118 insertions(+), 15 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index e5fa0f2e5e..bfe01067b7 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -25,7 +25,9 @@
 #include "qemu/osdep.h"
 #include "hw/intc/i8259.h"
 #include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/isa/isa.h"
+#include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "hw/isa/i8259_internal.h"
@@ -51,6 +53,22 @@ struct I8259Class {
     DeviceRealize parent_realize;
 };
 
+#define TYPE_I8259_PIC "isa-i8259-pic"
+
+struct I8259PICState {
+    DeviceState parent_obj;
+
+    qemu_irq pic_out_irq;
+    qemu_irq pass_irqs[ISA_NUM_IRQS];
+
+    ISABus *isabus;
+    IRQState i8259_primary_out_irq;
+    I8259State i8259[2];
+};
+
+OBJECT_DECLARE_SIMPLE_TYPE(I8259PICState, I8259_PIC)
+
+
 #ifdef DEBUG_IRQ_LATENCY
 static int64_t irq_time[16];
 #endif
@@ -410,30 +428,24 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
 {
     qemu_irq *irq_set;
     DeviceState *dev;
-    ISADevice *isadev;
+    Object *pic_obj;
     int i;
 
     irq_set = g_new0(qemu_irq, ISA_NUM_IRQS);
 
-    isadev = i8259_init_chip(TYPE_I8259, bus, true);
-    dev = DEVICE(isadev);
+    dev = qdev_new(TYPE_I8259_PIC);
+    object_property_set_link(OBJECT(dev), "bus", OBJECT(bus), &error_fatal);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
     qdev_connect_gpio_out(dev, 0, parent_irq_in);
-    for (i = 0 ; i < 8; i++) {
+    for (i = 0 ; i < ISA_NUM_IRQS; i++) {
         irq_set[i] = qdev_get_gpio_in(dev, i);
     }
 
-    isa_pic = I8259(dev);
-
-    isadev = i8259_init_chip(TYPE_I8259, bus, false);
-    dev = DEVICE(isadev);
-
-    qdev_connect_gpio_out(dev, 0, irq_set[2]);
-    for (i = 0 ; i < 8; i++) {
-        irq_set[i + 8] = qdev_get_gpio_in(dev, i);
-    }
-
-    slave_pic = I8259_COMMON(dev);
+    pic_obj = object_resolve_path_component(OBJECT(dev), "primary");
+    isa_pic = I8259(pic_obj);
+    pic_obj = object_resolve_path_component(OBJECT(dev), "secondary");
+    slave_pic = I8259_COMMON(pic_obj);
 
     return irq_set;
 }
@@ -447,6 +459,90 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, i8259_reset);
 }
 
+
+static void i8259_pic_set_irq(void *opaque, int n, int level)
+{
+    I8259PICState *s = opaque;
+
+    qemu_set_irq(s->pass_irqs[n], level);
+}
+
+static void i8259_primary_out_irq(void *opaque, int n, int level)
+{
+    I8259PICState *s = opaque;
+
+    qemu_set_irq(s->pic_out_irq, level);
+}
+
+static void i8259_pic_init(Object *obj)
+{
+    I8259PICState *s = I8259_PIC(obj);
+
+    object_initialize_child(obj, "primary", &s->i8259[0], TYPE_I8259);
+    object_initialize_child(obj, "secondary", &s->i8259[1], TYPE_I8259);
+
+    qemu_init_irq(&s->i8259_primary_out_irq, i8259_primary_out_irq, s, 1);
+
+    qdev_init_gpio_in(DEVICE(obj), i8259_pic_set_irq, ISA_NUM_IRQS);
+    qdev_init_gpio_out(DEVICE(obj), &s->pic_out_irq, 1);
+}
+
+static void i8259_pic_realize(DeviceState *dev, Error **errp)
+{
+    I8259PICState *s = I8259_PIC(dev);
+    DeviceState *pri_dev, *sec_dev;
+    int i;
+
+    /* Primary */
+    pri_dev = DEVICE(&s->i8259[0]);
+    qdev_prop_set_uint32(pri_dev, "iobase", 0x20);
+    qdev_prop_set_uint32(pri_dev, "elcr_addr", 0x4d0);
+    qdev_prop_set_uint8(pri_dev, "elcr_mask", 0xf8);
+    qdev_prop_set_bit(pri_dev, "master", 1);
+    if (!isa_realize_and_unref(ISA_DEVICE(pri_dev), s->isabus, errp)) {
+        return;
+    }
+
+    for (i = 0; i < 8; i++) {
+        s->pass_irqs[i] = qdev_get_gpio_in(pri_dev, i);
+    }
+
+    qdev_connect_gpio_out(pri_dev, 0, &s->i8259_primary_out_irq);
+
+    /* Secondary */
+    sec_dev = DEVICE(&s->i8259[1]);
+    qdev_prop_set_uint32(sec_dev, "iobase", 0xa0);
+    qdev_prop_set_uint32(sec_dev, "elcr_addr", 0x4d1);
+    qdev_prop_set_uint8(sec_dev, "elcr_mask", 0xde);
+    if (!isa_realize_and_unref(ISA_DEVICE(sec_dev), s->isabus, errp)) {
+        return;
+    }
+
+    /* Wire up secondary cascade */
+    qdev_connect_gpio_out(sec_dev, 0, s->pass_irqs[2]);
+
+    for (i = 8; i < ISA_NUM_IRQS; i++) {
+        s->pass_irqs[i] = qdev_get_gpio_in(sec_dev, i - 8);
+    }
+}
+
+static const Property i8259_pic_properties[] = {
+    DEFINE_PROP_LINK("bus", I8259PICState, isabus, TYPE_ISA_BUS,
+                     ISABus *),
+};
+
+static void i8259_pic_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = i8259_pic_realize;
+    device_class_set_props(dc, i8259_pic_properties);
+    /*
+     * Reason: must be wired to the ISA bus via the "bus" property
+     */
+    dc->user_creatable = false;
+}
+
 static const TypeInfo i8259_type_infos[] = {
     {
         .name       = TYPE_I8259,
@@ -455,6 +551,13 @@ static const TypeInfo i8259_type_infos[] = {
         .class_init = i8259_class_init,
         .class_size = sizeof(I8259Class),
     },
+    {
+        .name          = TYPE_I8259_PIC,
+        .parent        = TYPE_DEVICE,
+        .class_init    = i8259_pic_class_init,
+        .instance_init = i8259_pic_init,
+        .instance_size = sizeof(I8259PICState),
+    },
 };
 
 DEFINE_TYPES(i8259_type_infos)
-- 
2.43.0


