Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA8ECCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm7b-00006a-5y; Mon, 19 Oct 2026 08:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm7V-000063-3C
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:05:37 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm7S-00041x-8i
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:05:36 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8QPXa3199047; Mon, 19 Oct 2026 05:05:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=aNlUrMr9q1rOFXLFDeaeQlVWwE1CMuX+2uDxxeomG
 uY=; b=wKw3hf+rYbICXEZzHEeZHyxTquKXi5/VyN4jKwYsRHnYgmWF9/UvNkU79
 kB2m7vihfpbr+cpfFxbdyzRyQPAo+bDjDKRXXgS6ntorIEF09iovsNoVsapbCL1M
 EUOVqitFSm0TuaqmUJf4SGKjHAQuHLiAENnZtQsFQyBOaOHlEnyBgUpg7nIW3Xdb
 GeTQSVWuW6CVF+O2REthOToFv1xVyX/JH7QtftDXsSV/5bFY8e3X3A/eLsOFAsWK
 EPx+8Ew8x9PLSuayhKzwLWS+IWSf5U3OgqWGG8OUZ6tuToBp1IpduAuvKSHBy4qc
 VVfYhV9wAnBHbqkmU4ftkBrAELbhA==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020135.outbound.protection.outlook.com [52.101.46.135])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc83eugvn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:05:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WImn5HN8JGbHiwxeVwy0lVubRk5Qc6DSm/cAU0vv0AQdxL0m5x6Je/KoiClqe3JcmE67UhLealTGCgDrL6hsjzxRDOpqoKm7h87aOv46g0y++aivOwjU3jafyKgLRXqRoc9PrvfkaDExLITij64IKAPzqWM2Jji7HNwiHh5sYNCTxk0jYEFkMA0Ky8nDatcocbRhVrHdVfp8SKQv7s6/SdevAq8XZ/u8JgRr4+THQ0I35k83JwAX6SbGc5ffHrccwQqt9vEOVtvP2v67lT37RSVeI37ca9fvv5NlKQg0vQBun8XoZDxARjbGdFiBna/Mjvslxv/mM1t5Q6ZznQOGLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNlUrMr9q1rOFXLFDeaeQlVWwE1CMuX+2uDxxeomGuY=;
 b=ro1ySFY33PruofrEMm4RzPC5AynJKaJQgY+38S4HTDnDKAGUYtQdIJ/PGBw/jKP4YpfYgKtMnviY9yTLxEcMqitFe2L1NSYlipr32twMW1cGw4Je/Tf2XK2X3afevB7CLC9HlbYXYHbEZrbLqwleieO3EItw0jw35xQ4GMgVXFMoboV//oOmdaOuUMEGcf78vuEj5TSL6mfqIAKW0LXXIsBLwQDhUzSbHF8hPtAHSC1o758ujSW/KfRLeIFY+Y8XW39bgYXAShueItIIFCTo93/MiGU7sr+AtKonQD75iC0aCX1UgF6axe2sc+MjFJkW4O6TrpVP5IcffdpHcnQ/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNlUrMr9q1rOFXLFDeaeQlVWwE1CMuX+2uDxxeomGuY=;
 b=T74/KeLC0KEsVnhatwPYqnAm6Bk3ha8HINKCrv5eIIVl4sJoVRKMu1Ow5dX9ZRNUwaW06nodw0QCf32zkRaOFdixZcnzgZCK4ZSRs6qk231Jbooi0fwCwyZl5kO9Szs0RyFnLK3CItvxYIwk/27tXNhfWDsDNE9yer/GJHD7Pt5vzgFnbBxhhAbOzzq/fsf4FSNfz8zb4cjOi4sSKABN3bj5ffXks1V4SU6VinEml+XDZL/+IFImc5hRZJ2ADrTWGTpZf4NTE4OA3pl23JhAL27+T+ctipAhWY8pHTl0a8ax8Kxh1Qw8+VFJdW+E50zfB7rGmkqvQ919bWExjN2aBg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11441.namprd02.prod.outlook.com (2603:10b6:8:354::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:05:24 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:05:24 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 01/28] i8259_internal.h: rename PIC_COMMON to I8259_COMMON
Date: Mon, 19 Oct 2026 13:04:33 +0100
Message-ID: <20261019120517.1448687-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11441:EE_
X-MS-Office365-Filtering-Correlation-Id: a7bbed3c-1cfa-40da-479c-08df2dd941bf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: M1MRSKACszyo/qcN+0DV8vin10J7N9CU7Kx0XhVh+rvxkLjoRoo+B0gqW5KngEwzeow3+e5zgO/PE3mvfag6bQ04e+aCU5AboLgMF0cyU9eaH8FBCASorb5yHhQj8MPzTue/dMfAj9vnhNirZVpCYSvAmaUckFMcYcUB4GND2eJCo0FBlTfJ+iF19WIO9rc8RmJpP3Oc+hTgHKkHuvOApBTpXpccIUbCv4ok3Frq2lysA67Tqdn1+cWaT/TkyUIbXcOmge7uLQ3Wx5y/lCE3gvzj35yu/EJ7En94o4tfqbMbCTd+JG/psuIOOskOHyvagLSBkOKxr+ltRzHFxvnhYF3/V0YhP8m0+NVLdRKOw6tJrHdFUImDawHOZ8Kz7BUla2V4Dk6qZWNJ5xYVEbhc3trKvsywyD+fVA/qW4fuiOJd4XyfghxDfZz8vFOITof74dp/vC3yD+RkPZ5NxzwJmmyunxBaV7y9IhV0GIy2xBxdJ04TsxpElWrjgGvHq3H2c7zDikzC7FKIYC/ALTbemKKrJ0R6dcpdMsM8pTdwuUaIFw1kp7SQ4mfT3e1siHnlkXAn+IFx2N4p22xXMq3AlCSgX9JZksuhxqKuB9OE22QfHvc3q7GUUf+jK/+Rg1Ne2uvBcI90UX47qz8L3fxCUAVZjRHEynnv4Gd/P7pOMEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KTVDOToqZ2Lv31fp7GNdZgsRV6D0/kx45gOkMVla5H5mmcu360yiessgNVVo?=
 =?us-ascii?Q?TBv0KDKL7IIt32l6J4HdsZSrtoUYJkhSYAJPHCF6Ho0bVUg9bs/tYRiiPZpp?=
 =?us-ascii?Q?D6f02uJLxVa2mlPSeN0NeE9/3F3HwSE6XF9ZPpOtnn6vs+scw6diMGzhBxgO?=
 =?us-ascii?Q?to9EMFLXh8byT018sXZp4mlX7QJta7eyrGtJ8Ng/jy2NFMCucx0k8d8oHRW4?=
 =?us-ascii?Q?hlUUpRj3yu0e714Qv+DhJkDaxxkWDYWy+8yECbGGOetVPRD8eQZho6JXYAyk?=
 =?us-ascii?Q?ef4xJoA0mT+YAnBdOyse2wnKaNU9K5vHDuKbID27WryBL4YN2LF5MapAmFgo?=
 =?us-ascii?Q?KXVZD1afILheL2j197dRhHzbMgiw/00/OsR0CyCValBRgzx7EwXCPyYfPRM8?=
 =?us-ascii?Q?GbuZfop/HKwvFsNpuJ+JCo3So4PUVnZU35ulaJUUnj0hqWCout15m4f3o8a7?=
 =?us-ascii?Q?AK4p+XVgHOmatMyifOi3OBh9lovP7+6d4T/SePP9JkkrtnvZKnz+morfXkfP?=
 =?us-ascii?Q?qHrgFK1oAHwa025Fp5eOvjJ3+kM61cVEXThquSV52tZTuU+gBDGlC1SofvwU?=
 =?us-ascii?Q?GurYpZcnYIqI9wceWQ7idv6hlVoydHlRPse9bKRJt7H8kGpvte0THjIOF5r1?=
 =?us-ascii?Q?n4IpE7vvjsvWCBIcXnoim3NEJsjccKDUOS3/wlSQGWKCxtrWBrRMUtj8MBeR?=
 =?us-ascii?Q?Mg97YrfQ3A9cevmU0fqgvd4ETp0c884B5mpbAjjVY2Nx/Ul8SKNsTZE7FEcO?=
 =?us-ascii?Q?L2lZLw7mkUlVAXR2P8/Ju3MtsRRPu5WRhvf4DbVbVi4HX2dyShX0tT1bvRx1?=
 =?us-ascii?Q?Gb0EqesD5oFGjSmQB5ZzO4bTBBfisDD/KH6nE0EYAvjGXJhISnjJdzr/mv0n?=
 =?us-ascii?Q?BY95D5eBoxhs5E54lkOYbYXLPIvuVLQ4x4Ae/Doib4IbYNnq0KWP4E33GLBH?=
 =?us-ascii?Q?p6GG/6NJXPQxBaab4Ufa4A9pNG4pBASBAXHq6qXqjjGik9w3hwt5al0zTKiD?=
 =?us-ascii?Q?LKtZuGMEZaU1Y8DrVv583mfGEL4Vxfyc/3X49xyvcf2ycHQVhPXA1w29zBCh?=
 =?us-ascii?Q?WkQx/VSe++Sdek+TjS9WEY8VTwn2a2sbv6A4mPhvmJKPmVnIQepsid+gbfhO?=
 =?us-ascii?Q?kljRKciDrKCB7isZHDomMYN2bAfSal3sRogUV30wD2w4JhULl0dcvHdcT+KI?=
 =?us-ascii?Q?+UOMHPcT6cHPODjO6rer+6rmPtNigySMdEL2ndi+5arRwkm3iTS7fHis4NV1?=
 =?us-ascii?Q?MvzpBIT65t8Om6GqYl92nte895kF+8r0m3O0Jf8m+omXo8UZ7i6jyw48N4KQ?=
 =?us-ascii?Q?pry96T7n1AjjpG8dvAR+5yTzG+cW0Vmej4EFi7Ij5Z6qXoygYqH4z7rjzPb1?=
 =?us-ascii?Q?yqMYnvsAxlTZ98QLAafN0V/vPJxIL8vZJXiwSrcwubMA92IelSoe3E/z3WFg?=
 =?us-ascii?Q?mJq+oO0tRQBJRETfsChXw142wTOQdPYtLmqwqRUkJaDXqnt7lGfBfhmz/PHp?=
 =?us-ascii?Q?7rAIVrIOUz7sU6BxGKr+VevNbFrEZd1MTJzm+vzOJ6l2yqA1+JMTXXGYzfzF?=
 =?us-ascii?Q?+pLutzShDy/V1bRUi/MxEmvScuYnp7+XDuGrfHr71yB53GL4tRVeskOyHdnA?=
 =?us-ascii?Q?/5++1kKDURNfuNFsPfTjnDl8fC2eCx5RNvotcZgqSBpSXARwVinkfa06I/XQ?=
 =?us-ascii?Q?aNTo3THvlM4ayMwMo/tJXvHK2zTyNlpfvFGap5X2X7hJsnlqpXEs+XbR3dVZ?=
 =?us-ascii?Q?VQone859Vew+9K5ztcFAViUl8R9bFTc=3D?=
X-Exchange-RoutingPolicyChecked: fCKzcwsqXFkAyECvXZZgoHV5YBdAiF3E5iO/3xWxoGFzzotNUTgMUPP0fs5ONfuhSJ5aNljp3RdMbtHAu4hSPBZedFOCsK9ezBajFXD0/PD/PeE93Ta4tFBEuwQwdGWoEoasMePVoOgXx8EQnHy8QcvTO2JNa9+Slb3ZyGtEpZkOQ9TwKRaJ4BiujaJn8a3gMakUkS+HnJlErl/c+j/Q8JodpaSF/dcQ8zSm1ShVFjmTLO5a4xaC40uxJMvgAnvxNGGnCPLaBU6+4fqNWduzXC16tdylyxSJAfnvQEMIpvV03JHG68RmsJxEZesCinKaNk75E4FTJZce1Z4+FHHd8A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bbed3c-1cfa-40da-479c-08df2dd941bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:05:24.6334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swummGCsK+yY6y2LpDP7NfnzqkOZ0sqanVFnl/n+lttp9xa+ksoJSu9B37+W8Lgag4BH6Ynjjy/JXQZ096JUts85UP6LMOmRVH7iT6aoF4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11441
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX84O4zDndk7JN
 NszTuMalAtFMgOVisZXSTMRxXRElP3zquXHRKX9QCzcwe6FmWI3H70o1iLxEs3G5yLxU11cxGTt
 9PwMbzczTfzLTuxYucj721k5YZ2Uj+XVcE2UxNe4Caxm3CZ3a0a4cL+pyFcf7Qt+D8QU1vtm1eM
 Kw/cVQev3+bv71aIIab8zN45sxHqnmhCRGUodHjpjP0kmlmlOFTclzzkFy7BQH19lYdgrlnYAQF
 Id2u3rSHHFPYXAIim5QffeFf8426GIHbNPmUFlV8SVIfDg0AjIVvnBCwFLxDQ5MyUSllYw6v7d8
 iFmC+BBePK9K6tgSUMdoCi/BERRVgbFg1GRaLkdgbzrEIJxPOiPhQ7a4vQwdzZQRADjQGNUGKcg
 ZrqpiMIJIt7kLttHVOSp8o5L58BJ+GRgejPFTeFMCs2IEtNiilK8LUilED7Yw9leVDFWbHgwnVD
 BQGN4PkpLXR4bUGAx4Q==
X-Proofpoint-ORIG-GUID: jhGA_ywVe8KoFFV2ICwQJnXyoggRRiIe
X-Authority-Analysis: v=2.4 cv=RI8mjIi+ c=1 sm=1 tr=0 ts=6ad60785 cx=c_pps
 a=5R5l3xa2V1v4tL9kvXelng==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=XF9Y1ugsmyLceZbb4BIA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX0eHTCrPYVX2e
 T+jBZRzPBMDvjmOIGdRL/13sTFjZPyLEk9XU/kYrJb/wuAJ4MpIQXcsu84+eG9jwM5i5ce8QkO6
 XS308QuK2CwK2OaZVCmXzaqY4Dx1lp8=
X-Proofpoint-GUID: jhGA_ywVe8KoFFV2ICwQJnXyoggRRiIe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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

This is to emphasise that child types of PIC_COMMON are all instances of an
an 8259 PIC.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/isa/i8259_internal.h |  4 ++--
 hw/i386/kvm/i8259.c             |  8 ++++----
 hw/intc/i8259.c                 | 10 +++++-----
 hw/intc/i8259_common.c          | 14 +++++++-------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index f9dcc4163e..54dc9036cf 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -31,8 +31,8 @@
 #include "qom/object.h"
 
 
-#define TYPE_PIC_COMMON "pic-common"
-OBJECT_DECLARE_TYPE(PICCommonState, PICCommonClass, PIC_COMMON)
+#define TYPE_I8259_COMMON "pic-common"
+OBJECT_DECLARE_TYPE(PICCommonState, PICCommonClass, I8259_COMMON)
 
 struct PICCommonClass {
     DeviceClass parent_class;
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 66f37e1303..14029783e5 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -103,7 +103,7 @@ static void kvm_pic_put(PICCommonState *s)
 
 static void kvm_pic_reset(DeviceState *dev)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
 
     s->elcr = 0;
     pic_reset_common(s);
@@ -122,7 +122,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
 
 static void kvm_pic_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
     KVMPICClass *kpc = KVM_PIC_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(dev), NULL, NULL, "kvm-pic", 2);
@@ -142,7 +142,7 @@ qemu_irq *kvm_i8259_init(ISABus *bus)
 static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 {
     KVMPICClass *kpc = KVM_PIC_CLASS(klass);
-    PICCommonClass *k = PIC_COMMON_CLASS(klass);
+    PICCommonClass *k = I8259_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, kvm_pic_reset);
@@ -153,7 +153,7 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo kvm_i8259_info = {
     .name = TYPE_KVM_I8259,
-    .parent = TYPE_PIC_COMMON,
+    .parent = TYPE_I8259_COMMON,
     .instance_size = sizeof(PICCommonState),
     .class_init = kvm_i8259_class_init,
     .class_size = sizeof(KVMPICClass),
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 8f2aa1f0fb..52e24d333e 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -218,7 +218,7 @@ static void pic_init_reset(PICCommonState *s)
 
 static void pic_reset(DeviceState *dev)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
 
     s->elcr = 0;
     s->ltim = 0;
@@ -387,7 +387,7 @@ static const MemoryRegionOps pic_elcr_ioport_ops = {
 
 static void pic_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
     PICClass *pc = PIC_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(s), &pic_base_ioport_ops, s,
@@ -418,7 +418,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
         irq_set[i] = qdev_get_gpio_in(dev, i);
     }
 
-    isa_pic = PIC_COMMON(dev);
+    isa_pic = I8259_COMMON(dev);
 
     isadev = i8259_init_chip(TYPE_I8259, bus, false);
     dev = DEVICE(isadev);
@@ -428,7 +428,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
         irq_set[i + 8] = qdev_get_gpio_in(dev, i);
     }
 
-    slave_pic = PIC_COMMON(dev);
+    slave_pic = I8259_COMMON(dev);
 
     return irq_set;
 }
@@ -445,7 +445,7 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo i8259_info = {
     .name       = TYPE_I8259,
     .instance_size = sizeof(PICCommonState),
-    .parent     = TYPE_PIC_COMMON,
+    .parent     = TYPE_I8259_COMMON,
     .class_init = i8259_class_init,
     .class_size = sizeof(PICClass),
 };
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 8ceb5841b9..e2f997e161 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -56,7 +56,7 @@ void pic_reset_common(PICCommonState *s)
 static int pic_dispatch_pre_save(void *opaque)
 {
     PICCommonState *s = opaque;
-    PICCommonClass *info = PIC_COMMON_GET_CLASS(s);
+    PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->pre_save) {
         info->pre_save(s);
@@ -68,7 +68,7 @@ static int pic_dispatch_pre_save(void *opaque)
 static int pic_dispatch_post_load(void *opaque, int version_id)
 {
     PICCommonState *s = opaque;
-    PICCommonClass *info = PIC_COMMON_GET_CLASS(s);
+    PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->post_load) {
         info->post_load(s);
@@ -78,7 +78,7 @@ static int pic_dispatch_post_load(void *opaque, int version_id)
 
 static void pic_common_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
     ISADevice *isa = ISA_DEVICE(dev);
 
     isa_register_ioport(isa, &s->base_io, s->iobase);
@@ -118,7 +118,7 @@ void pic_stat_update_irq(int irq, int level)
 static bool pic_get_statistics(InterruptStatsProvider *obj,
                                uint64_t **irq_counts, unsigned int *nb_irqs)
 {
-    PICCommonState *s = PIC_COMMON(obj);
+    PICCommonState *s = I8259_COMMON(obj);
 
     if (s->master) {
         *irq_counts = irq_count;
@@ -133,7 +133,7 @@ static bool pic_get_statistics(InterruptStatsProvider *obj,
 
 static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
-    PICCommonState *s = PIC_COMMON(obj);
+    PICCommonState *s = I8259_COMMON(obj);
 
     pic_dispatch_pre_save(s);
     g_string_append_printf(buf, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
@@ -146,7 +146,7 @@ static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 
 static bool ltim_state_needed(void *opaque)
 {
-    PICCommonState *s = PIC_COMMON(opaque);
+    PICCommonState *s = I8259_COMMON(opaque);
 
     return !!s->ltim;
 }
@@ -220,7 +220,7 @@ static void pic_common_class_init(ObjectClass *klass, const void *data)
 }
 
 static const TypeInfo pic_common_type = {
-    .name = TYPE_PIC_COMMON,
+    .name = TYPE_I8259_COMMON,
     .parent = TYPE_ISA_DEVICE,
     .instance_size = sizeof(PICCommonState),
     .class_size = sizeof(PICCommonClass),
-- 
2.43.0


