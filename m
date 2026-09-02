Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D6BC624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mAd-0007ob-75; Wed, 02 Sep 2026 10:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1mAb-0007nq-KP
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:42:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1mAZ-0002An-TJ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:42:33 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CXiUo1206475; Wed, 2 Sep 2026 07:42:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ODTKXVfIrQUSG4PIsogjNC0n6hK0dnK5gwZ6Usfxp
 2E=; b=IsSPL8YMuCznPxObKn7Qs7RU0gSYwmX0eG9XOFuzxp45D4wdGWjZ39lZm
 0OcujG0t/0onGgJhDgJK7VbOhw6O8Dynv8QoO7m7Z2piLPqIqsgJd0WnSDWiwsAW
 UJUDz4uRleGs+tP3S3PfgmFW9ar202QgW1tjrYjpYOfEKjYGQRy4+pW+0F9UY3Zc
 epVWr7NUOPw96WriZ9oTbCRzFUxbhUgwqRrzb+rz8cjBI+8g8prnOlKPtYm09i8g
 Q1lkb3tdDXsR1Y2ckF6w//sXpSgK5qslOUEOfM63kLsgFM8BFhO4PTMP9OncNPYl
 bXCPZokNLwAaP7+i8PdTWLc1MTmrw==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021073.outbound.protection.outlook.com [52.101.52.73])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ge100u3xf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 07:42:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tlz1cfrdKnQbbn99275JP6egMARu8Bgp+o9xYK3vdM94Z6UqR+mo1z6j4+tqOyAhFKTRRhE1enezgvD3blSP/jvKqOVgAVtS/8rMYLcITkOmen26ETZw4yVzdHFe/kTn0ztkE+444vsQjkKn/3W8pI9nZDhRePp8fgpeoFp8UfB5k9Wy9ibHTWRCBmmaBL3cwSUvU5/iKNcCHIZVSU6+OttJIsFLQl7ozO22wvnEJ8sQLemcW054fRMaFJjRWjd4ocHLRJbUso3cYj4g7zstQBkPSDh0adI/sCEGxLsL1D5nimT6WpK6pyWuTZlZAxDSrqWKaQZToXhS3glICJM1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODTKXVfIrQUSG4PIsogjNC0n6hK0dnK5gwZ6Usfxp2E=;
 b=HX2pgg/5c3lRYsyv7hwh2znlJbjADcwiP5E22ZbEuM7fIGjc8JucAus4AYZr3fD5SlkkLD5fz+M6sxqtyR1c9fDG+kRWypMqqIw9is0pr7AXi8XobjtNcz06q5YO6JAx6KZJKssuHjUtqTmAvwC/otCYlToq5yeMtS5IwPzXaOsl6sNeVx+H5HJEWQhIxarocR5dj8MtyYFOp7MXCCi9Ab/tvX6yohaLSSxLRc6/0qn+q0/urH4y1ZeaLa447e7vTw0qd04Gc1DQSFDTZniMMeNqbTfd/QWDCsdPjAp6Y4NpkTFNaUSMhaOfJQnCGcn7NGuxsv4ckoqNyEElh/fFAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODTKXVfIrQUSG4PIsogjNC0n6hK0dnK5gwZ6Usfxp2E=;
 b=WSUYzumX9JG4y1i6+11D/xGL5W0khCwaxZ0zPc1ZnQwUB3Qa2s945qKy+xS4KynRoSTz2ac33XH7shC9Yo22kmtq++0vgHnQ36GHTwSzcDk+BpuqkAzP3PZtjpOxdA84fVdY3KrrdaUKLc6Y+ZXuhw4OCbre9ux9Uq3sFMiBQDrtaM2pdHsELVFOWYhnCQmWrhAGVmiXc54nthiMuRCWwpkN65LlHm4gzmtK/pLv/D56K+jgWcZhY/+ySofIvNEe7fT94C1UtWQnazyo9No6iutJPIt7EgMrRjxU1TrTZYVsdgjCexjn43NlhYP169y5VfXu9zKMjHSEn8+1SvSP2Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BY5PR02MB6978.namprd02.prod.outlook.com (2603:10b6:a03:23f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 14:42:26 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 14:42:26 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v3 4/8] hw/i386/pc.c: convert pcspk-audiodev object prop to a
 class prop
Date: Wed,  2 Sep 2026 15:40:51 +0100
Message-ID: <20260902144207.2553037-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
References: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:a03:331::24) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BY5PR02MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 759521a7-623a-4f83-908d-08df0900685b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: tLkGPOiK8Fxo/7Bk8QpC0xKrw2VcZ/xZlr+E/0SEiD9GOgFp4CYvSLYLxRG6dOt4dMfSaJy++esuGrA7DKlCgS3J/2Al+oSoRu9xt8TRjt8lphVwm/sKHVmhtPhgS8C98B2hGp1cKmtY8li5trFLCER01LwkguIb0uNRqEJV8jNxK52dQz8iWTTJlizheTMrVMqRw7bTPtW7PlOjM1yKX7z8ibcf0u5sDGDXHvFdMmSM/T3LM0pmfk3wwD/yESEdTFOlT+HjR02n/vrvtC/1ehVWpGAVukZ0mkCGxKBHNoN+Og7pScfJDLAvl9n61wIf+x9TFh8+rgnAhDRdcQB5HMBx4q7Ry+GeKLRTzZC73sl1xiESD7tYoCae+ao8wtAX31XGXlVQSIaF+1s6E/3XGVS607cx6Kt1f5/ohG+jqIzTI+Owp7nKgiECUHZqSOmtAGZ0HmaLLanUCiTJdaSnPD9y3nrHGMcjbQ5FYzv1V+t3GHA9/qi0UWr5iCLzeua1Sfl+czi55Zdfm8hnIMxOu/Pf86RZ2YrXdyABG60kpsZhF5A/0pKpKerMfOyGcwB6AyM7OgaM9vyOihlKqbVt04uq89t0DeZPddhiVSJ+wmqtlJY/EXl1KYxmRe/lAs0Jr7Bb0tdRimjVpY+VCJMPB8ZpY+j8Ifo0+n8maI9674U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8MhxhBHI0tZzBU6JEK3/+4nadf4bERsTWTjInhBF3qh2MgfstThmMaEd64e0?=
 =?us-ascii?Q?mmWAHkRpPlx3T0Xb/eyeKhUou7JzY5SCygiQaDi1aYw61eJU/p9bxPk+eJK/?=
 =?us-ascii?Q?NEP+YSGGNxtpXhBUuXuYloPmRrU+Ngxm2aitzS1xBDanW2Dk8ed3rNHkrf5b?=
 =?us-ascii?Q?KgciRHJ/MKcKHZRqlCdh8HBITANzphweLvgAGczRUSKsaoPkn1vjHigWXajj?=
 =?us-ascii?Q?rPRHmOiPm1skj64uiK3/pBYPsu+fQC/C3lsPKMKrUixSKuffFPQd4jhrQDW5?=
 =?us-ascii?Q?XW0rP33qpMdB2DW0hMlCPWoV6FB0lToqOr+0augpRiKxrm7ZDXhj6n/pjfBG?=
 =?us-ascii?Q?TorEAEpZYemjXHv4IPJruqVFT6lif6jX/XAhLICjYKdXbhmLmlsXSTYpVIw/?=
 =?us-ascii?Q?/l4A4Tw/7rRQ4x2eXiRyaUUvL970NXdCMav/so1YIXgjmVni2SHIgX6g9G7a?=
 =?us-ascii?Q?i3bthgTtGrCnBNSDHQyUZ/K8tqVfqO5hCn/oohh3Uzsp4UO17n1/peV0QqIT?=
 =?us-ascii?Q?6wdxhLtjlp2Y+kQ8379+e8LFOuiAKRZh2uWgbTdtdQ8WIzWVEDrSQFIyhWXk?=
 =?us-ascii?Q?tAoxGp5Xf0vU0S5JenUOAESQAxLL1IBwI8gB3pwu90a0Vlpkj/VsiTzvz3ss?=
 =?us-ascii?Q?l4xlGCKXKLz+wasUTIK38q3n4qIDTRWQriSz5QnsSuzj9U1jPKMhsu+Qf4ZS?=
 =?us-ascii?Q?x6d/XbVbpL3q8NH9KL7MJa4GRLQQrLFQXaLC6bGLyl9J3FXxkOxmzbts3/kZ?=
 =?us-ascii?Q?B6tDQcCUl40YNPe9yUwCJNpeWsA9sGl57hEQgIaMMAMTh9WhaPaXiXmrTtZ8?=
 =?us-ascii?Q?IguQB95PnkKIbHidF3w/Lq6nUfQWdiEKdKGPMnks+9kmCV4b60byk1MzZ+re?=
 =?us-ascii?Q?4e62HxqGF1yTK7IV0wTwxHKMonc8ON8UEJn5H+0tu1MTIIwQwX9Gy7gHTr8k?=
 =?us-ascii?Q?wPzVBhUJ66GeThDoR9uKwd2sSB7Q1UwFT/ZGKkWuJ4FgB4k1tFJSo+NDgmB1?=
 =?us-ascii?Q?2aRWQOxQchcCKhaG1ZdUti7ySyshZAECYW1SLG1xZdb0VLXQjD82epfqiHta?=
 =?us-ascii?Q?eSH9bGdJO/3dYDyob4FvABJ7YbNcjIO0WgOXIVPwwKjlnAhDT5sF/++qAKV6?=
 =?us-ascii?Q?Bi0wLdDYP0NFxjMR12V0tT9pImHnEbeZGIaS1fGa1hHYDj6PTb/mZ5XMGuf/?=
 =?us-ascii?Q?gQA6Rz9KTPugkx78C52HhwvuH5DHFk5PlObgBq2hD3naSsQAswzaxR73/ZDX?=
 =?us-ascii?Q?zCx4W1oeeh2foHBLzm3QcG8VciFD9P55WdT0F8lWAdtXq/fKhHgvkrNnhrDB?=
 =?us-ascii?Q?hnQer2LcpyS3JuuwV70ziUN79B81LR49K6UNEI/5jTGPE73UiB0Q1dQehG7P?=
 =?us-ascii?Q?QjhIAtz9miMXmxzfsGcMmA6M62f/RbVuNh+xPHJQiUvirvRs/z+WmLYXwbGX?=
 =?us-ascii?Q?stZm0VVM5VbFlWgHj2Nvakug46Zfo9w9rH6mmdFwet9klNachvdzDD4KNOR4?=
 =?us-ascii?Q?3Tku8wdrMnDQU1VR/qajnuLLO+skPtobuIA763y1Suf1UeKGK957PAkeoVpl?=
 =?us-ascii?Q?iDCuZ88FJgsGsEZwRzXcsuwW7l9NPuopGPbueb9oYBBoVUBtOTIonkA+OI6m?=
 =?us-ascii?Q?wXx76ayRmw8FkVnrB4siNNw8KB9jqu0oPGJEI9ygDXgxPbhocTmMgxpKIj5Z?=
 =?us-ascii?Q?eIKApS2V8AY64B4auK7xvIlKlNV2HOTY7fBdvaImCn4BkEX3TMyVLcwVA7to?=
 =?us-ascii?Q?6UYaeHClu+2RIc/vigG/ZM8ZFq3nxkQ=3D?=
X-Exchange-RoutingPolicyChecked: KPfltFkFDsH/5hxKgGgFhspb/o0ypFim5JYu3l7Qad0tKugqrM96HypdP7K5GK39l9eXk8g7varapj0vbCzOUUR07uuatd31CoyRepAbmUHGuWrIcL7uJj5xJykFVBd1BGNFqGCjHm0cgcGgYAWE5bRmMgW11DvII+0gyzuSnK2qoBNgaqzrirk5HAKrryCRdYB1hi8Qvih2TwG0BkZB0vCeC3yM504LUKOSUN/APqSXqrWXRn0nvhdfAogxKCUbO1hKu9pDMfc+Iu/jTQL8Gkl3Gw+JtMLy3Nu5jRnLhcC/1tJYNVo+x2+m9BYqxDlYjkspu/NugmZYn66YYiOitw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759521a7-623a-4f83-908d-08df0900685b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 14:42:26.7515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eW/LXxM1PBpJKeVEipRNG1k2BKSol92GyI5ZrgsX7w+ul0zZzCS4A21mB5eCiW8AoWAjvJGQlW52od4DJIsjyTyaMCk0pIKjsYKsEbGhhek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6978
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzMCBTYWx0ZWRfX7xOaSXo6SBHg
 s+mD/RktWi+33F7BrD4bL2oIAPvnZ0SIqVc4z3HlfZ3CzhDwseOCTQIOtfmpU3v4pHYlm4kSDtj
 QAadj9OmMHFSA3KJQuuqxG6XGKJsFgg=
X-Authority-Analysis: v=2.4 cv=JZuMa0KV c=1 sm=1 tr=0 ts=6a9835d5 cx=c_pps
 a=BX3zSU6Em1tkVDhR+nIdzw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=L8dKEXyYK7uH4lZ-jiMA:9
X-Proofpoint-GUID: 9s9lON7jPBVYR4xrnnCv6W9aWimzj4hZ
X-Proofpoint-ORIG-GUID: 9s9lON7jPBVYR4xrnnCv6W9aWimzj4hZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzMCBTYWx0ZWRfX1Kh7exTmgfH/
 VOISmH7OghScNJ5Q7JwD4ytTOdeedWegyBNo9X2x/boA0bjjnSYBR0ee/SCSN1zZEbIRVu8Ld18
 Sefn4EaaVCwejktpoi2GYppeQct2waFlPLZt5D63TylAcz7VXNTSlY70NIslXlFrAhQd5h43sjV
 Kf6AZdqhct3iyWSP1wndE0/8c1ahyQWxLyA2wsB/w35nnPwLH7mYHAl530VhGInY85D7mUPbgjR
 itgi72SU6AwQ1Of1299mq+Qahu2yKMMSRxTDrfnng32Wu1zg+8MyfTD0tP2KldYQwSEYNpTxYQ9
 r4JvuYZ5GGByrm3OyjdyY1/ioeiL3B4NefBAiGk8EHD0c0cLvL2WCWdbY1uWEQCMaGg4PLxPmy1
 gWo3J+Bmo8QEbntER06EwAfUnK9NraRInDXZfQFqO2TJYJJDmrs8ClZqSSRTXf4E3GffDJJ1x/L
 ERjuwoojs8n/ZcI1tsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/i386/pc.h | 2 ++
 hw/i386/pc.c         | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ac03da97b6..bd800e7ff0 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -38,6 +38,8 @@ typedef struct PCMachineState {
     DeviceState *iommu;
     BusState *idebus[MAX_IDE_BUS];
 
+    Object *alias_pcspk;
+
     /* Configuration options: */
     uint64_t max_ram_below_4g;
     OnOffAuto vmport;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e9e4fc262b..5293c59d66 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1643,8 +1643,8 @@ static void pc_machine_initfn(Object *obj)
 
     pc_system_flash_create(pcms);
     pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
-    object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
-                              OBJECT(pcms->pcspk), "audiodev");
+    object_property_set_alias(OBJECT(pcms), "pcspk-audiodev",
+                              OBJECT(pcms->pcspk));
     if (pcmc->pci_enabled) {
         cxl_machine_init(obj, &pcms->cxl_devices_state);
     }
@@ -1788,7 +1788,10 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set IGVM configuration");
 #endif
 
-
+    object_class_property_add_alias(oc, "pcspk-audiodev",
+                                    offsetof(PCMachineState, alias_pcspk),
+                                    TYPE_PC_SPEAKER,
+                                    "audiodev");
 }
 
 static const TypeInfo pc_machine_info = {
-- 
2.43.0


