Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E68EC5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSMZ-0001pS-Cq; Thu, 13 Aug 2026 06:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wuSMV-0001p3-RZ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:08:36 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wuSMT-0001Y7-9Q
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:08:35 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D92l072435960; Thu, 13 Aug 2026 03:08:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=A/zoU3z+TOOgsoW
 g2Us1xA8x2Sn93bGqGqUbyMMnp8c=; b=O+pldWARizFzlUWMerRCirlXXDZAiP+
 gpe0fztd5G4Omo+KzNmNLfm5z9FmYK1SfOm+a42+9Cjf79LHG7NDw0EtoKl6yWNZ
 ngn0cPiK3mVDuxk8n2bEA7X/H3ldBjzqjcO1gnd4O1DeAxApBOCXejAGk/2QmXUU
 l8CuCqtqQN7ILGFdE3pTsdZ9F9tAiKuggLlHnghiQx0Zs8exd81Pfa1C16tq68L+
 y0aq10+KvZwSLGpuw6qEuo70p4OkzRfwLlokM/JDgOBWO2AJtoM17Yc/cIEOuzm3
 Qi+nktEG39xmZEs9emyOnwvdqPJVAe0q9FY4eamZfdBygbur4Js0Mfw==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021118.outbound.protection.outlook.com [52.101.57.118])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g0a1fvn4y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 03:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAdL5dxATk5ajgVWdOJi1u6uAFYooxhGfOk5YdPLpRe2EFikE9kML486nJdWDP1AMrrtut2J+iibkmjaS/zlzqHOvhBeIknimXAI2JtYNDYDh4GoldPzFl6NOGxyZx21X+prfn+xxsLMsj6YfTc8meA9YstUDwEcSO5/xeZKDctin608XlsCIeRGMbnZfX2WtNWSQjjOK8SyVc99kPGjlykk9/ZiqNmQQ0GlAsHF8q7Ktlt06Ho2tFt+uiwme683LUw3+BmNdO+w+6A89sMDWM1HprIaft/jtG3aeJzgMO+tq2G/QSKeOdxDCmbWW86KKhMFeUuAPG+VUX9yCvsDfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/zoU3z+TOOgsoWg2Us1xA8x2Sn93bGqGqUbyMMnp8c=;
 b=kKqjpUZUkA1jA1Wq/RTyKGHlIgb7yDIggeKcxxbS9vuZ1/m2+TfKrp0gnWxw4MlrjRfMBNWMx4cY2rL4iLhKbc6njh8R98Sjodkk49/aW8R9wc4raalSV4OeQSnjPpuAVGOc2lAMdVtTcNw0RSBCXTS7UxTFVgX18zaa/Y2QvZ3i+f27x8Mw10fppg0Pla9fY26QoJLz44n3U+XhI3G6ZpOPJiX8eNxM5dRczihKHck9Zx5GpjncSA57MjWUsB2LUiBcdqOACeG9c60W2qRk2J4MlOwQlX9xB+KVAXWAqqGWRA2zWopGcIZNl+l4fgn5k169Yt9Qzz80pfAt32BKMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/zoU3z+TOOgsoWg2Us1xA8x2Sn93bGqGqUbyMMnp8c=;
 b=O1MubbO76PMk54CRMVGEYJdGgaR06rcpmTEkfx5ACFx2UL9VtOm55fVvv4fRwubeOf4leKLRP8ENJeGeeolEuJXj4GKeZoTGN2KWFclld4lt/WsG+3/ec//r96st7Z7hUz+5P/c6ZN4855QNqNzGxzQMZlqjv/xZQf9KigvWZIUDwNTDZ+OvVQ5IYywezjmZ+KxmfE/wdzn77mb89sxv0O12CLTOb/yF/bWdWplvVDksaFvWEfOlG2n15L2PUfUpHtE81YicmIJv7awhq5wTSSVLKIfflFGXskFySLmpCb0SmshgLo9H9wstueeYJ4EZ1w1b0j0uQeBxhfhCBHYJ9w==
Received: from BY5PR02MB6180.namprd02.prod.outlook.com (2603:10b6:a03:1fd::16)
 by BN0PR02MB8239.namprd02.prod.outlook.com (2603:10b6:408:156::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 10:08:26 +0000
Received: from BY5PR02MB6180.namprd02.prod.outlook.com
 ([fe80::5bab:a96b:f604:d7e1]) by BY5PR02MB6180.namprd02.prod.outlook.com
 ([fe80::5bab:a96b:f604:d7e1%6]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 10:08:26 +0000
Date: Thu, 13 Aug 2026 11:08:21 +0100
From: John Levon <john.levon@nutanix.com>
To: Hugo Komatsu <hugo.komatsu@nutanix.com>
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] vfio-user: reject failover during init
Message-ID: <an2XlewmwjalSWtZ@lent>
References: <20260813092959.76-1-hugo.komatsu@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813092959.76-1-hugo.komatsu@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P123CA0195.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::20) To BY5PR02MB6180.namprd02.prod.outlook.com
 (2603:10b6:a03:1fd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6180:EE_|BN0PR02MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: de1ac3d6-8284-4971-1f7a-08def922d0bf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 1q9PiwHAwjmCdbvON2cpDxvqEAeKCBsVd3By655vLMEifHJZOaGkpdbvaxZs6DipE6YeUTO+QmAtPvpgDCud95p7bzHuTt5qpshQr+cUjwb3POQwB4quUWq1vciVLcCoSNoCBoy2zHVX2LN3SdScNBEZePs3V58o1kfsEWl1PuRZcTtq7csBjwsr8BU1DDKkoMdfW0OZ4sei37ZIdX2xfOgsIRGLehUyfJNjNyFiS07I3bYkEDK6pg2IXfwwpll0WylwNKeP+x3EKKp58oB4lB4+ddPKIq8kmTo0WoXvR1g0AOWslOwEa2gh0AN8L1c6BkHUzdzOtAZ6BLbVdYGa3deudAX5u4BKyslfGCjnIbhkDg3lnBz1Pfi6dYj4TZagMn1DU3W7R3zYRe0q7hXo9IQ0cpvdmpOiHooNuWNn2LCJuVB72oAl/2+MVrTas+Hf8N2u/Z+ob/ImB21T8CV1OUf2g3MX2Eza8/qFYY3Xrw+NP/uYJKJvT/g0ID0utVSpFhab6vobB0cMau9/nmfHDt1o8Ld8DadGbZAEGp72DTuf+wz8RV4V+fxeLjdnxXR9ivFObRR/Ke/yQBEH6o7SUfxFlveqw1Yn5enLG/gMyxlYLKpyuhZPdEgUBSebePMD4j4ZWop+dVCqIGD+Fpaf8sbyzemuBUoDvjaoiYadB1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6180.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4jmwFff7Aw//IqjppdyuyaZAW6OOzS0Aq7ArTG0vK0J5pcRtHgsQqMrYim5O?=
 =?us-ascii?Q?0YpOOKtIPwm9AXaQ6Jh7RYeV6f+yjUnFhHEYXbkxyiCu5qukd0QoxKVSOH9t?=
 =?us-ascii?Q?asd/Y+uPLKlmGU67FsSSBnbgxEZTtW7iEaR9nhPNjfLL3Z402YT/3jSu6VQd?=
 =?us-ascii?Q?GVh0YKwupnQ6z4lrY5EUdlP2ejnjb0UhiaiQJYQnBPveuXkRzBLUVSnmZkxm?=
 =?us-ascii?Q?C8BsfmxamLmCLefCyFlYwTbQWHstSAu6P6O+WobhklmXMf9g6pCTLgHkiR9u?=
 =?us-ascii?Q?EsIivikLDomjSzo2Y7p84TC+zUZreewnVgGOqmFIRdEh1a2tT6pVifhkbmj8?=
 =?us-ascii?Q?GFy1E9cjIelPR8o/CDkSfDWg052yB29cMafUiGyUP1xpw9gK4ONkk1bEbSVC?=
 =?us-ascii?Q?GyOivH9kFD0+B2Pif4vU84NwfWGK8k+TmP+t99JApQs4VazAJ/IonWErCCbv?=
 =?us-ascii?Q?QUDvchGnsBs2vTl81AiGrRPpA6kg6qL5dPoxm4ZivKUb139VPv2wO3ERpn/K?=
 =?us-ascii?Q?Es+dV6sxzW7kawRYaRCwYimNNdMCwqh8dZDBHifM9lO9SjKfejBdd33c6Iuj?=
 =?us-ascii?Q?nM0IcNV+crabfkRAp4evDejZ0xx6TRQiLtdfRIo6sZe+MDJZFWculOz/2tKp?=
 =?us-ascii?Q?wHxT/uWOmwASJIybIVJ7R0o/cX5RcZOYYztIjis4ATOqP4ywFxnmPobZbPXi?=
 =?us-ascii?Q?/IciIro4/618y9HEB1X8kKp3L0pdCgsLd5ECEZ5nFAdb8bvWA/i2Z1dgJl07?=
 =?us-ascii?Q?qdc3+Ww/gQvgwrOBbsZRyBLw7r8kpzzAX0dbE/cqOEpzMkVlLSiTeq2Hr5C3?=
 =?us-ascii?Q?pCzn75MTeBu1D7uqdbhpaVOmLICDSB+lhIklwHK5dLEwH20p8qjdfZZS3D7g?=
 =?us-ascii?Q?uk/DJu0D+qwJRKwOjUTx8nnr4LOWg2JFoqs/5KJGkP331/cmEpuldTWTFzxZ?=
 =?us-ascii?Q?KifnbC/4btR2AtMX6PsIqcTLAXlaVHOzGkqJ4aj/BEgnFWrRK+t/U0uGZSNP?=
 =?us-ascii?Q?i8WcGxEwtXhq67Zs1rb+hJpRmikjCXnuC+VDXWElXhonVi2ksl5CZEZxt8AL?=
 =?us-ascii?Q?xFBafIoulGFugXtTeCODRxPYoKfLj1bimHl76wpQrUGKLGxw9cK2aRXLHrN3?=
 =?us-ascii?Q?Sq/QUkaiMnACDxev2//9hAD6tfbIPo67437cfom5GcHuhwkQLRyK0S45t2bx?=
 =?us-ascii?Q?qklzp4uR/5P+WQ0FGDgvkK0Vv/muYd+if+vHEH1ZKjjgS7pr7ubdqIk4lF6t?=
 =?us-ascii?Q?Q/qww3LyC733DbaQCdQYJIXaHVgVlNpueD8sDoo20hBJartTpdT1dOaWJfVB?=
 =?us-ascii?Q?mvwKlag18mQcbPvEgwf4+OTvmscoYXlq9NAwHVp5QsQt8iPo/X3UVMKmjlD4?=
 =?us-ascii?Q?WB9viaq7xMVHZtsdlYYQsY0KgKWtYAG6ZJoc70Z7de1h6iHn5AJ+qwRMuw6q?=
 =?us-ascii?Q?f6r20xqB0tg9wBVm4giZ/uxPb1mVMYsF4k0GbkSe8n8bYO+UWQwhKps6jrKS?=
 =?us-ascii?Q?1K9om4Y2/PyE4PWQyymzs8Eq0xKGunHsz43maagZAkTxI1elgqDYQEgwgfMi?=
 =?us-ascii?Q?98ySV1wNt1XGd24fPmd5dkl8bNxR/qcDeVcwLFGXdwzxd3KzRTKxKu4nUHYX?=
 =?us-ascii?Q?niurslzOw7fxwbzxd/XiG0LmjxAiAIWsbAXR489VcMB7ppfj/LZokHkrhaEF?=
 =?us-ascii?Q?nLH/9yB843L9GSs7TGBweCOhPqDw6oNikJI91DGNrm3emB0NufALsJaOQl77?=
 =?us-ascii?Q?bABUF93uBg=3D=3D?=
X-Exchange-RoutingPolicyChecked: O4c/HsLQ0pZwGdNeg+WPFd31tpG+T9pVs39HgUe4xTHM/r2RqU6fwij0UVTeSHIGa4ihetXcM7ZWVGAnCJ+I4ULNW4aebZ/w8FmigCtzoaKkiCVtK55wQOFbMVfXA2Rbh5RFgle/I6gwckjWleE+2DwWozBjLcAj41elZd83uLkRBqwFDt9pJZjLj2JWPD3tStkXAwoEqiN71HT8NGBw547PbuV47b5nM3ETUveHy8fEN63AYxndBzRxAuUovwPDSJ2TSj3P721N7k0ZI+v0ne+GA6nGSe8GRg9QOGdq93fTPWf+dlVG0FuNEi86CHkMGm4snui2bV6lTfx0RZgyog==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1ac3d6-8284-4971-1f7a-08def922d0bf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6180.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:08:26.0959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYHTd9ICFBME+BrU7HEBUHAjCE9sQJM0XdYNTEwK6SWrwNm29Nmz3OwZ1ItIdIuoBQjQ3dzI+pWJNXW6S+Zj+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8239
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA3MCBTYWx0ZWRfX5I/XuO/1Mjh3
 b4KSMRVaPuxD+fpsi3k+RxjngfDz18URwsMjkUYbq9LA+uh8xCaCrL1Il/dEC84HrWyqo+T02H/
 bNMlyKcP8n+oeWArbw/yl3xUlq2N9Hwbw4Hlw98JnoEOrBLpoA2JoR4HQtnNqRlkzKEHJToBo9l
 h7OlxWZmzMrFcJfy5oEkRm1LbsYWloAlWoHnNCwO0jNSX0UzzDbcuAVpB+8FcB3vub/aFsmTNPT
 2X4xir90xb27yJTsf1zk6Whnq1BIS5jtsI68nOx0V+H9Bfs/0cLG9VZRampya2NpzUlvUDvsGMD
 VAIdPpoT1FyJfsYrgoRXDNYwi8RgbMErx4DmaVleOQccczDkxHnBM3TDuUpYd1kob/GlR/pNZF3
 kDKtdZ0eGrQQ/ro1mgHtbuBK4pB6+6et6dfoY+Zc8FLTYf9LIO3JG3PsBxHU1RZu7rL/9necmqJ
 KWoyPtZ194nMciwjpIg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA3MCBTYWx0ZWRfX3kOlYauSQ73k
 D7oR/AiF15CPI6B2FXiHP6ePhCT6UmDoTtzF0X7LpQ7b7P6hHJ2AgCkAA+TfeMaSHFRRxE5rdWP
 6xG1iYfjsFvJXOWZrZKVvX6QGfZ/26E=
X-Proofpoint-GUID: fV54kLlW9pxt_uXuSU6f5qiUFyaN1FZS
X-Proofpoint-ORIG-GUID: fV54kLlW9pxt_uXuSU6f5qiUFyaN1FZS
X-Authority-Analysis: v=2.4 cv=HfwkiCE8 c=1 sm=1 tr=0 ts=6a7d979c cx=c_pps
 a=Fp6ZGEvu10dMZ3IStNZSqA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=2WcVyZ2Tw0x2aDQjdfcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

On Thu, Aug 13, 2026 at 10:30:44AM +0100, Hugo Komatsu wrote:

> Virtio-net failover is a networking feature that relies on a primary
> and standby device pair. This is not currently supported for vfio-user.
> Refuse initialization if this property is set.
> 
> Change-Id: I80989ddb08a1cd3eba84bcf9b0edc26cb4a65669

Please drop the Change-Id, that's a gerrit thing.

Otherwise, 

Reviewed-by: John Levon <john.levon@nutanix.com>

regards
john

