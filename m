Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E239C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgVE-0000oi-Fj; Wed, 19 Aug 2026 09:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVB-0000mY-93; Wed, 19 Aug 2026 09:38:45 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgV8-0000hK-LU; Wed, 19 Aug 2026 09:38:44 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JCmOGP359213; Wed, 19 Aug 2026 06:38:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=7BffAliiZYyeUs3HU3vYalXj6crvUE7uG97Zl/6aR
 Xo=; b=JPcCnllpregQHsUGuAzqd5sTkKcjZemUh9TcrtgH5Q4a/rRrC1Btq2B84
 n1ppW0kf/rsc2xonAouaweTgdF//zzuX4hYvdQuBorSfTlBPMosG4vklc9YXo6QW
 yhWgDSwN9p75oPu9BRsC4zCXdVBgovqZiawJcJv4kuKAlj1eL9TndCP6dWWrv/I+
 +1CPT7wbRLp4GtJGmSWrFr032VM03+1M3xzu3398bq88nCvXEue2dYrcHxeIaFx9
 Zr1VuT0v4OwvSdvniLFCybQt1VKZm6er8P+1pC+yl6r03iwSoSZp3fKqF7x5/XlF
 5ZqP0jx7YUQ4ByEf1LXiHLZkgpz1g==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021131.outbound.protection.outlook.com [52.101.62.131])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g4up4ts5x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 06:38:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7X/d/0RvwiqNaRtSoWouGZvVENo9Yde918vIWNHrLUd0e4sFhxKHm0krqZVg6+wP0WYQIyx0A/1wg8NafE0BYP3apkCxMII1yU5+KGj6mndwEifenYk7iAx5tSSIffghQzjv5zPijixIDqcXW2QYn46bJ1t2wHg7ychvwnmzD1QUSITrQ/H284RQ6LeQ3KHDZg6B56g540eJWzbB+vGcUWRKE6dGCN/TANRnRyeNt0zMCSsN163+iZW5BDrB4lN+QN/u6RN/61uxe1rY3rlTeca32cr9Mw6jIA37QZA6QzS66j66cZRkFZaHHA9bVbSwKtnlbGEVYr+a3i9wSCtMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BffAliiZYyeUs3HU3vYalXj6crvUE7uG97Zl/6aRXo=;
 b=LSpK54bPRoc6kFT47UuwQwn2SenoiN/lTX/FoUZq3yau9SZiC5T+KXp7iZ57RztG9max92Jo7I3qRK/vAMUcLJr7ZHnpE26Oe8pS929YmeYEFtyyIZ5okaYkUnW24EQzjftKTpb/SeipYbk69U6CToMJodRerCpqVsRRoECRUxZPkzfYRaiNiZWp+XYA+D0/WomNd8YjZhY12L/HDGpe5+aG3pwpjOfN+AAArU/uY/87g6TrMeCfKEpFM3ZSD+FIkUtHxWewR01YLlqnerrzBxHHi4/piVmODJiIDroZP+rQxVG36qfut9SC9xArElzszRoGegTpNv2mJ0R/7ZQs8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BffAliiZYyeUs3HU3vYalXj6crvUE7uG97Zl/6aRXo=;
 b=fPIVZlQvlyhKwQCM0Kl2bnuq9VIVQbcmn6+IXSSAt2O32uuevo5A2TsOtyeIExTHXBlAfFPMcYIQ6DJ+FBtwUYBI0EN2cylxozfR2Xy49wSn89tfBrdPm8KebpjIpzlUJmKRxeYhLA3QkPKKCTZ1g+Cb8g41mdTNyMCXehmPi7PQ5Cw8QKR8PnSOaOHMaoqHKal8BV/xOOI3/Zbi3VFQh1+/KLGwvigZ73Ijscg9JyczsgPcKaK2EonFaBC8VvcIZHENyXvf5YK0rLDh+RQmB64oqff5zyWMuYSq7SVKizds8nVJptEkEDQDC8cMPbjv9OyAd9VSHuhnhtxz+pRkvw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 13:38:30 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 13:38:30 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v3 03/15] qom/object.c: introduce
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS() macro
Date: Wed, 19 Aug 2026 14:35:42 +0100
Message-ID: <20260819133816.3497033-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:806:a7::35) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d13ad2-3849-4975-11a9-08defdf727dc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|23010399003|921020|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 369H8v/jf8LwGThlbxlmjSidYaXIm3ugVpOY8bdeUgaBDOZ9xMSJaUEwpTuYOGt++X4Psmwadie4iJrn0Rqtak+z9GBM49+JzwfrQqZNDC3TlXP+YcVFhXYpjCvLB8kx8iZIJIxD7xJLm6V3PVwjl8Yp3m9lIykNVCcFgl1XQzwZecTq1UBzm9HYoHS0pCcnIkfacvlAjSCsqlhpDHM4+FsIU42qY1Onus6wUPYLXTlt0BFrd5u9nRCD122DZsSVtxdAm01ZqsG/jd7/dPo083DkZts74iiPkIBfe0PDDGtbV345aKPI3DOCkNkAb5HJTKkXVB+h3E8ulN3Xk7LlzcjmteZFooYOtSuPL4SYVGr/hTmF+vMfH4rLikE6c/GiC+1OUQyYlnRvZVNOQtyL1lkBmK+fLqqOghQ7e3kKtTnymBdBcbPCW+EZwiaWSDqZdfNhrBqIzSFvwIh2bE2+fUPkEieFVP71XzJ1TXpjJg7SzxYE+RCr/XuO5QXWBfQFlFLVJ4Typec22r0Ch1kWwZRaa6p0pJaBgmuDvB+kX/IKJwmFIgud5FP8Owhb7URNABvY/Qbq8gk/PZJhuyqJSdtNGvq7ucuh78t6BK+RnLbY+cVcs8dzECuX6h5MSAZaSD0X4sEKUjZa2t/rcFbNDesdHDAGQhhWtFX9XAUv0O5VrMzXT7qMu3qLOdRg4N6WktJ6ouwVFimiFrkbr1eOaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(921020)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JI5vBi1CXVrAN1b5L0bmY1SLrC2d/A1BTXkPyZZQx3T5Td8vpGqrtMxxlAO4?=
 =?us-ascii?Q?VOU8ulujdjo6GLzrxHqtBGe/XxdlLVYJJv6TUEuIFhyLQKD+tZtwWqH0OkUI?=
 =?us-ascii?Q?gnc27wGcTeMDhWkAySQbuaHnnrrwFE2W6f6ZzAFIQDGLs0hOzR/78cjaeS+8?=
 =?us-ascii?Q?+vBKrNKQqSDOr98e8aZ2YP43qhNL8k4c6fGmwVYcW9Z8LYTovIOYTpY3LwG3?=
 =?us-ascii?Q?LhFhOA0lL7LQ5AzRuhM2Kv2C8C8uzCPW8pMH++nMFDJ2xe7j2AQi0b0wvMLC?=
 =?us-ascii?Q?XovcUAGVtQMD+8JxwvxNMTiRQmuSBLsdVEDoRFAhXSkIGz1V1mLh4i1TH7eP?=
 =?us-ascii?Q?4kO/KlmSrD8nG2EoI5NiMZDEBbLctvCCqBsHT3TV0iHfxCJZlVtYkETAAkwM?=
 =?us-ascii?Q?NVXjb6cUKubo8Ztp6nYdbfyubBaZqQexXP7x+S0BiIUk3lOY4vPxkfXDMd6S?=
 =?us-ascii?Q?QcFs0VQa5CxeejndhBFDpbCxbCFFPHredz2iy2/4ZKJLwjPOSbYofbSDEyoM?=
 =?us-ascii?Q?K+5h+lN2bXFzh2A1AVU0Cv1NHIBacR4m09laGQy5O+PV77g8vgv3lL0zunRz?=
 =?us-ascii?Q?a16tfGTPvLBnGZ/1UyvImBUx2Wjsj09NBjZARj8uF6kuUFWM6g7cuNwViA1W?=
 =?us-ascii?Q?JbvOn+ONyzNVWYuns50Yy/bqYYwU4ORRWC3vb+iAbmQiqVNnffOqIJvqZold?=
 =?us-ascii?Q?kD7WYjwNXuJadR/6DgTvRFC44kefv+conHvGr5jSYQar9M0dNqlyQhfs4xwk?=
 =?us-ascii?Q?qDoIjzHbMWxSwulfamJH5lr8S+hPqgzcqlb9lCIARODjO1Pkm2ilAd1xziZ0?=
 =?us-ascii?Q?p2XhQWCxal9lYD52WEU6la55nH5iUBct31yFWvH+Xld7oN74bjpodEmAWg5A?=
 =?us-ascii?Q?FQNpQlU6sH+DMRmK+C0zW5xcSq3aSiQYC6O+Ydg6fP+UtK5ioLdc/0IaNYgU?=
 =?us-ascii?Q?N3XLR+RqnTO61ZcPmbihrkgsfbyd+VTNMLZr2nV8OAIyqTnHOBJclIyO7I80?=
 =?us-ascii?Q?W6ws5l71lIdur5MAUv9NAGJdxxln+48uHJeCA59ftpucw7qCVS2M6vHwz6KY?=
 =?us-ascii?Q?l5KKhOTpWK+zCFz100L2xoH0O74bMvUQHkjSpUEdvg7uvpif4BqIE1yl+zAP?=
 =?us-ascii?Q?ZMl0eeGaKT+2Jw4ReDmnyBovfTiyD/mKrJ7BR1zlaYq+2NmNyZ68p2EP14vo?=
 =?us-ascii?Q?4at5plOh7l+zG68sJuqpiiYjccSvX7WOHndQl2gZuworKrsSs3hIFY+kPQgi?=
 =?us-ascii?Q?QvHkCKWcGsG98wjmg4ZwmvQzhQo192fPraLLOXW7P5pEBWho315B/oJmG/q9?=
 =?us-ascii?Q?7YmC4WrBXJWDVTSDJ+/xfMQU1MWHEYBEbjL3cPdNTKZ6aZH6RaYfbrvTTM+H?=
 =?us-ascii?Q?ylpJN6g4uLuGh7QrX81IYKfWFCr6ktu4d7/EPJTe9UiEvbSBMRjzKu8EbBi3?=
 =?us-ascii?Q?+EBhL7dcjBYXkn53XWuRhVvqJYSRM+3KnQ/HRgtLbiX+Xm82W7UT7OFI7GQa?=
 =?us-ascii?Q?6S1kQYPQcFPfqFSQBU90nWD4MdYpxvLeA92CrHnTHY7VcxRkcTHtlspYmEBR?=
 =?us-ascii?Q?557F95yWSeEVUJ4ZLSwEj/jl2ib4R3pS0BDz4z2uGbrbmSB+7nSfToHlgEjI?=
 =?us-ascii?Q?A0z4MPeXawuagVaGIPK85OhiiEH+bOxwOjbGm2kLHrlaxwCWs7NC/TwvVhio?=
 =?us-ascii?Q?oWIz6jaz0UNokbqL+WcjUuzouhPpjOcuUhn1RzmzOz27G4vGWI2vruJ6/kNf?=
 =?us-ascii?Q?oPvtIuC9uHH16rAhQsOJDa25CLk/ZNM=3D?=
X-Exchange-RoutingPolicyChecked: TquXsxtNFp7wZRQyocOdplEZVukcruUdwtN+jsrcY8jRE7rGz3W97n0oIgnE4ByH01Lb5YCM3MRbikpAQ0CUlk/YIEE3GWqwrdW2FiYGEHroXXldDKgMSZxK+/LPsoJPObzJodeVEqW5zkklr9LsABF5HRzuBGvKxUJQl9aVbuwq1IIx49zDy1899MDZcXR1V4sMVPB7L4ngEznXUuGJnKdx1Suj+KlsbdwKlYLiDGNnq4TmcLv/7DQ2yc2We/qlyL0v+Ip4XdHBjclPoRxUXBgANMVF9ObIC3i4gM4d2a5zPyNxbR7UtSUQE4G68tIMytUwnuWRCW2IcMkqY8lWtw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d13ad2-3849-4975-11a9-08defdf727dc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 13:38:30.1514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLGEtybAeo8DwdgPWS3vBpUM4oPC1KcF2Wr+IIYiLzXNvxyZ5W34ceWxAqaNRHk7tGO7XI5VTcSymy2ewu+byv6OGaX+4/j+dwJM0QQI/GE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7336
X-Proofpoint-ORIG-GUID: xC9CclgsKQTYqq6P0-VTIyAkSTImedl7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX2VaoCfYmDVDC
 Wm6n/0zcwFwZIjMw7kN6I6YgLdg2jxv8CQt8EIvz4n1ggWyVVebrBun5aP/kNYrb9aD1a9j7pY0
 943+L8y1fsNgrlpK+9MBGriGOq3APjU=
X-Proofpoint-GUID: xC9CclgsKQTYqq6P0-VTIyAkSTImedl7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX41NmAINoaJMv
 u2z6DSElR0Ck0c4lltCJCkUhKVyPDvTolW6K7sreIhA8W4PuvkO3sh2YZmNBSS+9AfbH0yu3jds
 eVvJRndSnr2jcyWUQndXiyBYk/Jv1xoJePUEDrHDm33C0WzSk5b6l7AOneSd1751yu6ARD9+FhL
 qMxj15XyQZedLGGwH10NzYUwqwzfi7o2+CgBaDbTcfxmczvODp7WdW8igqnKTzfh7hajfE4ytuy
 T9oejewziRjaf/8hYalJZElgR4ZqvMwNNLAu0aowRdBLuxTAcfWWxr348h057dFiGE4spsftlbZ
 6j5b/AWU53kuLtQrIE2d4iqmiHdWSnVLJddaY8Xo8LxTvcl45SMcDbT50ZNG8/c/9O9ReY+JK/B
 zQ2L/QUW4xuujP29ASdW8W6uqjhn5wg/RsoSq5ysSxaf7/y28pgQFN8yJ/i5KKTVRt+Zw/wS//Z
 66BURTOjJYomywhStRg==
X-Authority-Analysis: v=2.4 cv=JpDBas4C c=1 sm=1 tr=0 ts=6a85b1d7 cx=c_pps
 a=06hTPglMN0yABrG4rHRHsA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=UWV-rqafSl4XcmA-RNwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

This macro defines both the QOM get and set functions for the given scaler
type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 qom/object.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index fe4e552928..9cb2cae4a7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2738,8 +2738,13 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
         *field = value; \
     }
 
+#define DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(type) \
+    OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type) \
+    OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
+
 #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
 #undef OBJECT_CLASS_PROPERTY_SCALAR_SETTER
+#undef DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS
 
 
 ObjectProperty *
-- 
2.43.0


