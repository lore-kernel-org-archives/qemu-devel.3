Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171FC1061B18
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Hcu-0004P8-Km; Mon, 30 Mar 2026 14:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1w7Hc2-00047R-FP
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:45:26 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1w7Hbu-0001D2-AZ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:45:20 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UGK1s41679045; Mon, 30 Mar 2026 11:45:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=xD2Fwe7S0B9r9ZBnG6+vTSFQf+wN5rpzTLZwNbn03
 Ew=; b=GVWefUZkgLAy4sB+L1BMbrBtI2C8FgvB9XDYYIZ/ARNfdcjXEc6CjkwPE
 mdELlifVvUz5doGC9VzlqQSCGd64ayD1bQlrxnQuOLuq5s3PTwwWlpotSqb+HyI5
 p0NcGWeZPn3jfu2cFPvExgUycaVVGfYOmY8A685Ev1Z78NvB5yo/jjzPGwzXs91C
 hF1jachvF7OelwRhm1uJx+3dKLWqEAZpmOHgnuhKj1wN8CK+fPaJ2l8WOChryXZ6
 G5+y2bg0s/rqjoHReuLJyq6JjJLrmRgzvsQXBDCnRvdfIrYwm8RHHi5gkTYy2zt5
 v7nRTazwF657CRmXI+WenL7EHYW3Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023127.outbound.protection.outlook.com
 [40.107.201.127])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4d7vku8c73-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 30 Mar 2026 11:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpkkbzTFZIplPYPWueK+KOwjZttHYlv15djrnr2CC2BSVgya8wIVqm6aUSthCuBKsSdurGBi4Nj2ZAFp1XdV2f/bq7AvgFCJdU/9kd+H/JDU5OjN1PnNjcPS7kCXVrLgZNhBpxFq7rrPgfj3pjgnN5NaanZ7heBhuRsPAwl4nezFSJmp93kaDhnyHqWhqxp2MdznyYg3C29CVkq0p7x7B0FbTF95Q/67NVhYu7I96wCBDoMHoFvHLQ3z27Se9GecmWzXTQ37UZwAn+Owet2qaMi2ng6JIL/ya3fdcCSvWqiq/daiqRUcIAIhqZSHY7YJlKIHKkIvpuqTGx6O+nm6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xD2Fwe7S0B9r9ZBnG6+vTSFQf+wN5rpzTLZwNbn03Ew=;
 b=y8GI/OAzMYx66wuyr7SAi10w7OXxGwwJfE1zH1k6S9Ez2AP7q+Gt24fC6+V4Z+Cq7S1NMTnNf48Qssd5DABW4hWlDl/F3xQcf0eEumhixFM5o4a/Fa7HFsl2ibzIVIjY6d08IJxdvJ7tbW7rx8s6LcMvlGDH6nJoI8vVGSmTCrbFZFs4gxwY05MEe099glv5Qv9mwleuA0c98paEUow2XrUI+YX3zLB4CUWG70PVzLutZxLKZTR2JWgwqq63ftTTGPNj4HUjZQYb1e7vDNkAw7p4a80bzSu6UHF54w44nJEVyUqtKK/gpG1j2OjwxC+2x5QUUz4jjjuiI2cBFfjxbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xD2Fwe7S0B9r9ZBnG6+vTSFQf+wN5rpzTLZwNbn03Ew=;
 b=ncBZbaqkrEjYUs/+nxw9hRpehdEIkGkOsW/c61zzKiQ5V0dZZyN8PM81eP9oFUoSVT3P5Hl8nTpNsS5Hyv7t9HyobpR4eji8uogJduvYAhwDmMqXCHAFE7/Ty1hzBLkYukMxInB3Vq+oBEcCWKz1u+VBY+OC9UVKj3glDQ/ezYJIcovOV5VCwk9RUkThNw7vikDUUd8GFd/tLFCda744xm237qCaASGNvHIDnoRLsz4jKimM3UN8uQZkDGm2GJLCQdJJyyGrF8Wnl2QE+3Fw8+9u8ERJQNGdKsiRfSTap10jwhab+MvDPIV/h87yo+EMCaY1PaQkJjQl36pFmH8lng==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by CO6PR02MB7618.namprd02.prod.outlook.com
 (2603:10b6:303:a9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 18:44:59 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 18:44:59 +0000
From: Jon Kohler <jon@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Jon Kohler <jon@nutanix.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH 2/3] target/i386: add new Intel models for MMIO/GDS/RFDS
 mitigation status
Date: Mon, 30 Mar 2026 12:34:27 -0700
Message-ID: <20260330193428.1663253-3-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330193428.1663253-1-jon@nutanix.com>
References: <20260330193428.1663253-1-jon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:610:cc::33) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|CO6PR02MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 0869287a-68b0-4e90-5035-08de8e8c71d1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|1800799024|56012099003|18002099003|38350700014|22082099003;
X-Microsoft-Antispam-Message-Info: XaWatFZmTyJc24ZoYGA7IHrT04R7IB1otd72Ds5pxhj+5Op3ZefVvtBzhsaF/QVzf7fkkVBd/PUiZzULzLhKeg5WVKF4QNQLkKsGGRudb7GcoUOfCb1xIodmX0+foB8UDCPDW1eUEGaEOd8/uxxT+1AeKdP9w6afigw2PCt5wCXRmPnyWqdlKC/ma1AP1LaJzEILbBM/EWM5YYdfTwos8WMsLdo5brV45T5c+byVnPchkL+fndPsKGzSMmNa+6LfBZ8dJ1pmUz4xTm0lTVFGqiuWS+5KjJ6RcCYTzEKS5H3SSkJ6tumZlfp5fg4NmUpuw75w2AkYbozco2WW6sEL9yGrg4cp9hVd1ErC7LQ1Ko/NadDf3cOlf6oZyX0C2tJiV7nwzJetojgidlJ7OluxqqkVpUx98w5re1RzNo380DcmwgMghxmtZDqn6XzHQ1nSzMYabW+vI5vY0lE1cIVjF4RNMRGRnfuX9DMcCq0ZZ17gDaPwuH/86FoECGfZrQBJN1qG1OjOtE0Z3IvmCsjVPQAmdi053vrQEfdYXBpsqp5gCGYzrBIRhUkhYt44W+8KxCHWY+UU9ovmMYZaRvPLLqVM3uHvEjzobF++Q/A2Au6QhOaXoTpJ7eAISr5OI31ilP23K506Ar7kqp/7iTOvlnXQDKJCB505EGyFJ8KrHdheDPwtZSdgQweO8oYqYjdorS+eFuGWo9tmBvG09cF6qU32AwpBl2H7Ht8Tj7iRcEpBXd8QsrIDuyGGQvKUeOuPq8kNR1zaSNAR+nDs2Z3d079TlkYALGuNmn0eXsSvX48=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR02MB11133.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(1800799024)(56012099003)(18002099003)(38350700014)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gyXiiXJV8U2PSK2mNbV2EekjOzov7AYmz1Tc4TbddUwB5YpsiCbfV7h2yYJF?=
 =?us-ascii?Q?ZwABTq3KLx5x1DGhj7riATiq97lGsork23qUrcvLAxpLPw5qfub40c6kevVn?=
 =?us-ascii?Q?OSbZDrwwT24uyuLlxQl3gYVxPlTnLRCshoJx7CT1iQFGjkJLW38P0ZpZ3F0/?=
 =?us-ascii?Q?1aEfGlmOQv482+G2oH85HbsOFNoeHiSeMnD6AoUKqbRip/UD8CZKCN9IIzCo?=
 =?us-ascii?Q?Q7+4NXD1pKVOCjlfxUN92cXr4CqJMSYWtyqsqcylTLO7Uy1GkdH8Nanr5t3t?=
 =?us-ascii?Q?EkZlKmlqtAxpzBmfxkpXE9/PHsbK5FArponokYYlu9bavbX2bExuPjJDWPt8?=
 =?us-ascii?Q?mMmcZjQqNlku3iXV88TKcdN+KyNeXaOuiH1qYeo67oGgWZ+m81Y7ee7HVIuz?=
 =?us-ascii?Q?mLze4PYdCkT64/LK1co2KXksN0MojbdDTw6g6QXdEkaXNTYy7cuKFSHz/834?=
 =?us-ascii?Q?WErTpHFqu48l0h0B1yUhVsCgzNEpTeM9CesvnjoI+dJaQ56UWDyhxMUL70PC?=
 =?us-ascii?Q?bh5d1jiGbwvxfzfr9PmC6hf+Hh4cwShQQkXe0CnLe9wu9VSlni/vcExghMmP?=
 =?us-ascii?Q?92CIKHbCtMT5jH88edyDCa1gnfpD5K5qIc9+VcJKicmfyQ9/kCvpNDTKf25G?=
 =?us-ascii?Q?JmSss0e+nitwjUdLE6elosceP39WV6G0/LzSokJDcjkG9GArTLB274k8ymwI?=
 =?us-ascii?Q?AwmNk1grJmNXj00XK1a/rd2vlpMlIA41bSIzr57Dtx8aVku9kOxPs1DHSpSp?=
 =?us-ascii?Q?YebSxtMeEr1aefJpxtnFFNLblLSfHfQ3vJcVr23AHO5GZAP5/VhAlp5x45W0?=
 =?us-ascii?Q?diog1E1AGjC6OjRwJ+izUX3TDSMzYxLOctXi5Yt5I2dXZJccWOjVoBFxFpYl?=
 =?us-ascii?Q?ZVOrdd6EWDhdw3bxeuuC/andHqKdvrj679eezS3UawHkJV57Fo8ZJlz/T/gf?=
 =?us-ascii?Q?hAPB8oqJj0UL/HL3Hr9wFq8PJmK5PUAWZl6fGHxv0us4Bx88iQlp8IF/PQj8?=
 =?us-ascii?Q?IAAbZG6UuzKpd7Anhp3aEJOkHhEphnqy1+9prGPLagjVR5UzXI8mgOIXrzIA?=
 =?us-ascii?Q?mMZp8BxqlwweaMrlYWnHXbYo4nGLp2ZSW+B6pqPlI1KY518hZrmnmpCCYudo?=
 =?us-ascii?Q?zkvwfqY85H8VapdW3Q+/Bcbysexy6IYg0qBc19i+MlnLUhBHcyIoS02s8cgF?=
 =?us-ascii?Q?oYxUBn3enP4Wicm3zjS8XDiGIAoSRJczHsBWk8DXuiOnapUc4RM+R3vebPEa?=
 =?us-ascii?Q?hgCuCcK4H9QzO4BirAVFtzOc36/NxAYR/Z9ZH/K7fWo/KUIXBYdIc27k3W+R?=
 =?us-ascii?Q?AkZ5GX5TGZNduQsLd/Xu5ksYDHFDkn/+/wSFDwK86U9dQPM2WcqYORY0+08N?=
 =?us-ascii?Q?MGglp3iwseJXO30GCPKMvaFOv0GOsOU3MGFWERt267TJeGWTygmdP2nFvySx?=
 =?us-ascii?Q?KyORdaU86F20v49G613QsGIcGztqLYLeFcZYV5isZjYHfHXNjvVk0KDp1vgy?=
 =?us-ascii?Q?og71p+aeM/DAjkRqDOlJ1o7Lxlu0YQcmShWNCu9zrcpd5gRQ+B47huHchdA2?=
 =?us-ascii?Q?bHcD967wyf6hNDOd25CCmKf2PwpSeo42yvZSfbz6TUok+5BrilFYSwrt7w7F?=
 =?us-ascii?Q?+uqfuADDeQUQ1lMNwdUmnhK4RdfrHc63/zegH5uxMxiRtWs11f7sC8JdaysM?=
 =?us-ascii?Q?aFKmPagFhMTPPUcMNTc27nK1r6L78wx37w6CQBwyZ6KaobWHOOkWU8LoadPH?=
 =?us-ascii?Q?Qbw9I5cy714VQtAoLGN6zlWBlWgUE18=3D?=
X-Exchange-RoutingPolicyChecked: srfk9W+S8ctVzBfHR9Dwh8+IEyjEJTz1IEB808i8KYmqFwV6R/Kn+xYVEp5gc2gEqU98DcgBjvI2bpwkam599fQaXxxcQFZlQJ7in09dRdV2YcSOUBc1niMaf3HhITSXmSHZYUjGAc1t5VDuqkeoOeABY5E/nudiP3PBaev9L5zzC/CszERahMnskolA11m3vA9saKItZY7/6nFY66jA5vqWxGsAxbSgERlTmEs+nCFKPz3mBZ5Jqv4suQkKkakLyEWHiCtHQh6wh8gqi/R+kFdMBMe48oCM3Hql6OgClON499LKLSvvKPpatm9Xrj8syxGgf+X0uWOh9yxXqCYg3A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0869287a-68b0-4e90-5035-08de8e8c71d1
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 18:44:59.3055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOklQxw3REGsFp08AA+kShy3SGZ7ml9+f0FhRnohZv4z8cYSHPJ+6oPKNCRMzWl39SyZAp2XlGBY5CnXhoKU8Q6lxIpTosyZtIzbKM3PlqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7618
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE1NSBTYWx0ZWRfX1AwVOuoA6D9r
 ruWq64vX2+Uo/bxE2giYaGdnQO9XEdBOLRJMmDkJcVppRItyVFnM7Bc5IcI+D4um9uteZWV5KK8
 wcO3mQIFmY2UBjq2TXdonKlCPQFyZjF3IakM9A8fRkEh0RnaeoCMpKwQX9aWCxUgYaMI3arZs+y
 UJCgrtcyEq0BsCtf4Piu+V9CE8PChSvuUONNXsyYHKk3acQBtxHZZDRngdjpF9DiU2OAPMnwirT
 FEBgWOaUr3g9YrU+Yl+hd/ltCmvs/nkc2MWCEHi/wxVunn6bjsAlOSdhU5puNtzM6sFYv1D5GJJ
 Yt572I0o/cmFEi/OKZvGwKAnVTx/dcfVyQS9hMkJxUQRv0oOzqz8Dha8icT4binLYZATfpUWrgH
 tSU934Q1+Naprf/R2dLVzfgvzXvDq6f6FRZ2VIUZe1l5+PJKjFrX98scxAMLoGK+APR8yupLV4M
 B/zlMFHXaFFY05Zhi/g==
X-Proofpoint-ORIG-GUID: aFTpUTbyAhnEtAX6u4nZ2ZQQthS0h0JJ
X-Authority-Analysis: v=2.4 cv=AIht02iE c=1 sm=1 tr=0 ts=69cac4ad cx=c_pps
 a=MP9y2KnavyzKo3MGO/hTew==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=QyXUC8HyAAAA:8 a=64Cc0HZtAAAA:8 a=qvPdHwtVjlk0nBHB3zIA:9
X-Proofpoint-GUID: aFTpUTbyAhnEtAX6u4nZ2ZQQthS0h0JJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=jon@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add new bits to ARCH_CAPABILITIES MSR to enumerate the status of the
MMIO/GDS/RFDS mitigations on Cascade Lake, Ice Lake, Sapphire Rapids,
and Granite Rapids processors.

These have been advertised in Intel microcode updates for a while now,
but require user space to opt in to advertise them to guests.

New models are:
- Cascadelake-Server-v6
- Icelake-Server-v8
- SapphireRapids-v7 (note, already got MMIO fixes on commit [1])
- GraniteRapids-v6

[1] 3baf7ae63505 ("target/i386: Add few security fix bits in
                   ARCH_CAPABILITIES into SapphireRapids CPU model")

Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 target/i386/cpu.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6b1a3a9b98..aa7a91c0e3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4901,6 +4901,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                   { /* end of list */ }
               },
             },
+            { .version = 6,
+              .note = "with MMIO/GDS/RFDS mitigation status",
+              .props = (PropValue[]) {
+                  { "fb-clear", "on" },
+                  { "gds-no", "on" },
+                  { "psdp-no", "on" },
+                  { "rfds-no", "on" },
+                  { "sbdr-ssdp-no", "on" },
+                  { /* end of list */ }
+              },
+            },
             { /* end of list */ }
         }
     },
@@ -5183,6 +5194,18 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 },
             },
+            {
+                .version = 8,
+                .note = "with MMIO/GDS/RFDS mitigation status",
+                .props = (PropValue[]) {
+                    { "fb-clear", "on" },
+                    { "gds-no", "on" },
+                    { "psdp-no", "on" },
+                    { "rfds-no", "on" },
+                    { "sbdr-ssdp-no", "on" },
+                    { /* end of list */ }
+                },
+            },
             { /* end of list */ }
         }
     },
@@ -5360,6 +5383,15 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 7,
+                .note = "with GDS and RFDS mitigation status",
+                .props = (PropValue[]) {
+                    { "gds-no", "on" },
+                    { "rfds-no", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ }
         }
     },
@@ -5541,6 +5573,15 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 6,
+                .note = "with GDS and RFDS mitigation status",
+                .props = (PropValue[]) {
+                    { "gds-no", "on" },
+                    { "rfds-no", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
-- 
2.43.0


