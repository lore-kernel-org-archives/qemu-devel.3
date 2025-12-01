Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29AFD111A8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 09:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ0eH-0006E5-Py; Mon, 01 Dec 2025 04:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQ0eF-0006DO-IJ
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:56:47 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQ0eC-0001wi-CR
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:56:46 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B19r1Qg1346015; Mon, 1 Dec 2025 01:56:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=u2Skyfo73xzLqCY7LjDa1fwLEU4aWm/2p6xn/+qIL
 Dg=; b=pP+5Emud6pIBAcG1QRsMaDPCV1C4ssJmfdE3x7Ytq+tm7YsNfsPOEDpMo
 IbO3MuYve9oyXyR/E+3sJHLgyv79aOLT22OINWc4r5lSX4Ysp3CPjkBmd4Wx0w8l
 lNW8DHvc+F48sKSUfiXwBu6zCx4ismrwUkh2UKo/vetGa7OdENzXF2v60ETGWm2A
 CVl/SDVHOpX7cNHeWd4O128VZh29bB99OYcCXiRNvdUxJ4tnb4IeebDG/4qvdC6v
 jvzg4If9alQmO/oMmwNAtq2RFNqbQqZQjyamm3HaW/4umwRhZa39pBLSj4DxdVEl
 Dh3qDWrPb+i08MHyt8ZwbnAOWiEzg==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022114.outbound.protection.outlook.com [52.101.53.114])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ar11e2hs5-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 01 Dec 2025 01:56:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMVZh2VP0rXs+YlQj+VHYmD//O5PyAnCOHzusKcOhowZggeFHg03KtzLODPCkjoONnYMY+1meMF6xc/yUR9+R+Pkt8aBLQkENC0RCpHa4BsdN99/e8WGP/n7VdhBn1zGpP6jOYAIYdQ0yfEeFUJxpP8gT8hdkpmQxWxK0HYPvT3cCaovcliH6YJVqWK89M9xCOtijD54blqA5beujpkTruYUh52novwHGkcWg2Z9neFuuEQxqoIusXXUCHIQfe96vWQbgqzSbyvCE9aQiqkC+FW7vgxEp27a0ksMkucAlUl2AYWOJnuWjvhp5TM4a2p6sGWX0q9KWqUFltOtrgZMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2Skyfo73xzLqCY7LjDa1fwLEU4aWm/2p6xn/+qILDg=;
 b=k1TDiG9aRZnLGvWbWvQud+PTV0VoLNxj166ZtoQv9SjpIuGcoOTIxq2tBzI86pM3ttnptazihmu2lTYgB/cYBMS9Sg5yQ2IIBFgiHlyrM8gfK0DjPHaPpUbvQmeQ18uBtGwm9zLd4BYaV8GHm/aYZ/KuBt+GwkeyOMTIgHwzcrJZeH76P+2/4A+BGznnvB6iyyc1qOoIT8S5SLfzgQvlZJNKeLrsFzjici0ghCKUk+RfDgtVSKebMSM9uBOuaYAJHiWUNxdfANLd0JvM904RCsxIJn0IWbHJ0KyGJY0aMM94aqW8Oc6AMS3gCGUDtWI0vrMYogOIc9I5JVBnrRl1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2Skyfo73xzLqCY7LjDa1fwLEU4aWm/2p6xn/+qILDg=;
 b=tSX3ZhVtnCrxln8rPyK4ANr7Wao6udlx8OoWI/o+YHV94yy1gas46BTxfiGCGud0qhqw3BfHPFEwK0Ch6bqblsvgE0jQXVDJk1Z0TWSYnVM2Sm0MTQDRSDKNsCXo5ZBSEr9p9K6xVrq6GhSxoHVM7xqotJ1gkGZPFcEIL8VYOQq3boS/xB+kw7lcWTywQicKdS+g5drjQQNAUuE/1hdSdKtUjiIVcf9SQPevSKGhKb9Re6xlMEvzm0GJzY1RddMamiiT3yoPzkBU6RIDuuMptVIaIjJszlULc5/QUSTPRALIO6YS/2DaeW+melkcVdzducaoxbMau0LmF1SdbebtWw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB9865.namprd02.prod.outlook.com (2603:10b6:806:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 09:56:31 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 09:56:30 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 5/5] vfio-user: recycle msg on failure
Date: Mon,  1 Dec 2025 15:26:21 +0530
Message-ID: <20251201095621.2786318-6-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201095621.2786318-1-john.levon@nutanix.com>
References: <20251201095621.2786318-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0576.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::23) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB9865:EE_
X-MS-Office365-Filtering-Correlation-Id: 478de1b9-6275-41bd-3bec-08de30bfe714
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/L+io+SeUEGLicrpWJIm6b1zvoqS6CaRDEMLe2IHYCmDrGrrSyQE1WEq95E2?=
 =?us-ascii?Q?PwaGVSTqJt1mzXRU8rkGkAS76M2wvzUoVbB8oeDO4vlBOee63W2DTOd72yvv?=
 =?us-ascii?Q?0gsUtCbyGTgvlrpegEC4A85hZ3bkeKpm0won29ml2p2q+IPuSiBd4cQiUxIh?=
 =?us-ascii?Q?G5+sQ9pe0H8MpH/XwEOd3Jxisfto2PXkUpYyz2bGcz02z2mTCdt+vC9pPRDm?=
 =?us-ascii?Q?Ft2YwEr0vXb4t2L8V6y8GNl4GeQDoDk/RKQ/kKiBuiEUNn8KoTb9N+30ExKr?=
 =?us-ascii?Q?sQg49+rLRAHasGzuRmcp2g9VsJFiemKOPshUfnCAEzYWLf82LhwcOm2N4++1?=
 =?us-ascii?Q?J6xSKru6aS7j7E4Se+WVzcaIeQZWAoC6w/0TOYQonOc+QrV09ssP15JiO0gT?=
 =?us-ascii?Q?viyGCizzlt9H6v+ofmJwuEJlcUZeTkNA957ruIJm24VsgUBNprzhr4Cgwbin?=
 =?us-ascii?Q?4XhV9Lh98d+SPFLaYLxNzqySul6KTmZTejFeXxMgv2MLwizFQuJ3gG7LeLnW?=
 =?us-ascii?Q?MXnyv5MZqD9VYprESyUhr2NbNFkxdHroyFbOQMKnDsK+Vszulqur6q+9ADYb?=
 =?us-ascii?Q?j+ocSHuB5C1jR7gKb6bTUVfdBUxSwwEIF3XEvuZJhrYZ4Z+DTgPru3FOgY+G?=
 =?us-ascii?Q?LwxoxYtlJzxlLDSYZEV7zQUp+U3jBGI6DPRIMxUKAbb/0tfNbqsbhw8NHpBk?=
 =?us-ascii?Q?8NnxPif/qXS1Tk4ykym+hPp+8QmcYr864IegBcxFW45zfLsppF1jb/TdhH0L?=
 =?us-ascii?Q?EEjRGW9Fj1jldkVYgOEaMPW8tjc8E1FPa2+HsUCyHIs7fv3qw51wvNAh+QnX?=
 =?us-ascii?Q?4sktaRlhNlmjrR1BBZLfKqXQ5u7t6H4000cyufor9s8J6xk7r5Ds9Gz78w7t?=
 =?us-ascii?Q?ozvhbAjU5bnD8Szz49Z6efXP5OT43Z3wTiSu3/nrhsAJQoB2Qlj06DIx2vmK?=
 =?us-ascii?Q?YcCIwGte8NYH4a782nBfPThgXTGqZ8WbJ6CqJCpUDahHwZ0E58N6GPNM1dCE?=
 =?us-ascii?Q?HnDcRAyOJlPa53yb/s78smLzfKr3KtZK2F6D4GBOP/1ZAuUUIcVy6Y0TjDEz?=
 =?us-ascii?Q?YzK7sa2/sEyJ+zVhMoryYpD9zJWdPlz9TOdoSguMU9bagOyMimoALgcMHdfj?=
 =?us-ascii?Q?OyZXl7zBaUGKd9ERivR4tQknosne+9PKInX1N9GoflwfY4tzm4/mTPac1be9?=
 =?us-ascii?Q?USnP6IbSGJSbEaPCDV9DHaqjSo3ZSfFzFqfW+tpemZFmnQw5ZqU+LEWfNJKp?=
 =?us-ascii?Q?My9hWnNsNdaECWOj47cS3rTjzUeQNxFmKgagYjUtCwFhc009k9xqQT87dV8+?=
 =?us-ascii?Q?MK1ZRC9hvBc/KhbetTxIuab1oDbRCpw+VlO1G9zaYWIrJpH3H/0oYFcJSWSG?=
 =?us-ascii?Q?dCV2rN9WCIcgwCN+aIif4gq0LzEOk4KYWQeA099sFmx6I4ZK3K19JURo+NLK?=
 =?us-ascii?Q?JvFI9oqdnldyQW1jH7EY3f8C6krmXbUt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DlOg4RsmGrFJBo9Ajo1u8YWyYXCC09l9Hr1ikz+B/M8AxPqyYH3XmAB/9in9?=
 =?us-ascii?Q?r8TZDoHchi3yfjVekrRqyyRLEGXqRj4bTUoeYKFJFz2QyZ6pi5e6j9Ao1QK/?=
 =?us-ascii?Q?Crkox6QB2cI8FJEYUT4FAHkAjv0LWJGr9pc/C/A2ARpPkwZyITrMWroSnZnc?=
 =?us-ascii?Q?apyVWjcHaE5ucaO9USSOXpBn3YtnygzASORsMGYGZl46WMLDkxWfJ3oAU1Mf?=
 =?us-ascii?Q?v8a9UyoOSdGJt9OAZtrpkHFKuJkAhEdb/Gg7yfR9/hSBstUVBBBgMAfWk6Vz?=
 =?us-ascii?Q?ZhGJw0J+a7/Q/abHQephT0KRAz2lR52KB9cKTd/5xKuRFWwajwvd5wVRDn1B?=
 =?us-ascii?Q?hA7g4kPNRdSWKvFTfrTU8vS55D6yIP0mqDg8ty1rSOY0ivvgSuxVz7+b10Wb?=
 =?us-ascii?Q?3Y7O9v3pyYh/OHnp7UgrwzXhXOtdBHwrfaeSbhm2pSxljoNtX7Mkyw6jZ5vO?=
 =?us-ascii?Q?3J2Laxz1EglTe4/aVm0ig8lf5eTjlCfUOZXTsUvg46ezI83py7dv+BaglBMF?=
 =?us-ascii?Q?1TmuaLhuyI69AUkE17eAsitGBsysTSTuzMB5kIkTD/MEWPdlTqPh/kgVSW/N?=
 =?us-ascii?Q?wqj1FLcxCPW0nVsvPqU/eSsnGsWsceoTuaRFyTSrJFtcVCRQE2tTr2Jt1MEj?=
 =?us-ascii?Q?cCiruSXgSbjH0mu4T4eIIsKp5483h9BTQV/YAwrOXtxAixppl9PIaTZE88Rk?=
 =?us-ascii?Q?/J7f0CeV49Jey1VuhAv82pfEJYaen6Pjd+xBXXUN9OSN9e4JQ9gyV7cdKM8Y?=
 =?us-ascii?Q?+63GTcvou2W+D/S3CNszXC0uREuSxFpINYgYRGLnn9M4EbFCS2EyYYtVdXd4?=
 =?us-ascii?Q?WDpLfZK8yRku9gmZuejpGLTcw3pKXccAmq5yMToIodJ+0W1ITmAEWQkb3+8g?=
 =?us-ascii?Q?o+HDKkS4uzaiX0FrPQ4+aETA9XSwknP3PQUegEJvTzrspfn9CQHcCpTnVaLp?=
 =?us-ascii?Q?6xzwezbd/IvRh6T0nidrrM+SZWuO/lBZ1wq7lpegL8fBStzLIpkkldgJA0/9?=
 =?us-ascii?Q?MTKX3WoDtERqRFDMmsPtvqRSq4HlRCxsiWlex3ZDANA4a8B91uZ9aMh0+MY3?=
 =?us-ascii?Q?i78cF9uBWBet4S4IH5+d1bZY5EQEiaiLvRL2ocf199VER6A+xNBxmVcWopuo?=
 =?us-ascii?Q?WO5j1ciZGBWjGCZ3BuXmLWV3RfZ/PiPFqYCYSLHc+g6Ch0yZ2rzkpJO21M0Z?=
 =?us-ascii?Q?K3Edh2SwEJBj3vPcWlBlhSh52hrb+RSQp2YS05Rvr/bHb/SuCheIT4bY/GEt?=
 =?us-ascii?Q?Ou4tMtr5fZ/Wgn+edIsz5g5Oq2jx3xCrUIdnahC7AZYJqUoyVB+1uAbOMgRL?=
 =?us-ascii?Q?euuOqCW5fwY5BsmHrp1H3DRhwH+MK1/pxE0o0JaqzaWIj8f9mWhqpSWvgQoS?=
 =?us-ascii?Q?jV7E8Wpk0fxQSzpnC/+1QkvLIc63e4kV4gDOco4zcpQUT3bQbeXFy6Z/YBS9?=
 =?us-ascii?Q?fFxCPgxs0B6WIVPhTpTUs9CHb7IKo4u/KMcr7VVgk1JU6ANKdgK+/CUUotWr?=
 =?us-ascii?Q?/Z9xWmsUlNn4VcmIUAUXP4bKYV3fdUCeuw5ate2ehhdOuEAP87vgz7OI1yU1?=
 =?us-ascii?Q?Dzpo+r/7eG7t++rrt+MXwEyGRRI5/OUAHhbefZBU?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478de1b9-6275-41bd-3bec-08de30bfe714
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 09:56:30.9375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYX9ZEEbq7TD1IwwyQTz9R1Crt8OsuIMYn/P/D/lOvqu8zoaX0sogQieJd4xNPf+9vhdhvrW6iU7q/OOaOPFrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9865
X-Authority-Analysis: v=2.4 cv=bddmkePB c=1 sm=1 tr=0 ts=692d665a cx=c_pps
 a=PPij9JC9dsFwf49xmEs+Gw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=J75VCkS05BzDYCChcPEA:9
X-Proofpoint-GUID: yemhqjK28lk-i7ywM723oXld1Hx9Y6js
X-Proofpoint-ORIG-GUID: yemhqjK28lk-i7ywM723oXld1Hx9Y6js
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDA4MCBTYWx0ZWRfX/TGzDdd6zhMY
 gYT8CyJzPupc7zXN2XK6woEahUkv2W7kTXvz+AAPikwdtbEWty0hisxj8zBds9BrOf/US1ol9ew
 VgGIUDTQ+jQQlIRzOUR3zpXV0WevJ8x7+b28s+blBdGrsKwSguvX+DnHBpoH3Cxibj6Ske77eLM
 qM+mFWCYT8ku6WHLAahVsBM9C2nfZuz9Bme9zYREujYY10gkYncKN54XBT9YN887FIw2VJgUFI7
 pASTXT6UHp2P+yNxjED2OnjjyAMAJuOjrnYnlelgcL3xjuu+uXSzLT7/kWlxGHuZizRC7sUNpN5
 ZTcXdK1pYbL//z7eiF12xr0ni29RRT5jh8lccd7iWmzxKYWLoqJ5MR9Q6/YKePihda5iGOr+2sU
 6c6etCsIzbQWCZT0/ij3mEjh3spvIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If we fail to read an incoming request, recycle the message.

Resolves: Coverity CID 1611807
Resolves: Coverity CID 1611808
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index d1d63816b3..d06978a74f 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -412,11 +412,22 @@ err:
     for (i = 0; i < numfds; i++) {
         close(fdp[i]);
     }
-    if (isreply && msg != NULL) {
-        /* force an error to keep sending thread from hanging */
-        vfio_user_set_error(msg->hdr, EINVAL);
-        msg->complete = true;
-        qemu_cond_signal(&msg->cv);
+    if (msg != NULL) {
+        if (msg->type == VFIO_MSG_REQ) {
+            /*
+             * Clean up the request message on failure. Change type back to
+             * NOWAIT to free.
+             */
+            msg->type = VFIO_MSG_NOWAIT;
+            vfio_user_recycle(proxy, msg);
+        } else {
+            /*
+             * Report an error back to the sender. Sender will recycle msg.
+             */
+            vfio_user_set_error(msg->hdr, EINVAL);
+            msg->complete = true;
+            qemu_cond_signal(&msg->cv);
+        }
     }
     return -1;
 }
-- 
2.43.0


