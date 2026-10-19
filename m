Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51767CCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm8x-0001zy-FX; Mon, 19 Oct 2026 08:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8h-0001ch-PU
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:54 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8f-0004FO-PU
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:51 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Osgu3282313; Mon, 19 Oct 2026 05:06:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=rzdHUCfCbytGRtS+cKyd2Lkn3aUnlJZ11xO0v/Rty
 v4=; b=DZ9F/NNkYaGBd7Ztg7txXoHDFp00rqBN/bNDCt1I+RWAZCmzD5LnZzcWs
 zASfOWOk4UmCUyVtcoFX3iQxP8+WbeoZwI8buGDzp4zkIAscXlX9Zu2izTdgxjyp
 3lEeqqXFUWNNYwqGetBeKzoVHOgWY2fWT7/AbjqPAwAg8QGPg4+kQ1KMAgSVoi1E
 FkR97q1Opohw0bjDJSVEYX+/R5DGd4DJQQfGVvHu0ZN0hLRHqs34Dh7LuMum2Hhk
 Y5HTR0ttAYmVomGkOV5YsTFA/jJ3s2ksr+0QSx1M98a5HS5hF8FTGOi3tCLbVphv
 znlHug4GoPqtS9WgknmG9KpMTv81w==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021081.outbound.protection.outlook.com [40.107.208.81])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc74ekjh4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:06:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQYMKM6lgTJWzqtOx93qWpPlfMkXYqRIwv/4eBrK+LjaKNHswFYDxU92qbiem70tev3ohmARI+fc68vkCRarzOBkjjYxDoCuXOdnXPQDvrYRNFONqt8LoxzsB0Y1jOWdzrzhKU34Rl4LaRGCdeyuUzmd2yiaT38WDRYE2lHjaw9A7DVLVGcKqD8CuzsuOj/llvM1essMU6r4xk4ukBg1ti4nD8RILAQ9FIu0tsedXddK1McZTbW/16S8Bq1lRXO3brZlGTZmBFmcpDriEDKYF/ypXYyYPQNNGZLtGf7TfYecCMoZ2VvU94zBhn9BMN7J56x9p6f6duwDvWcGjnk4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzdHUCfCbytGRtS+cKyd2Lkn3aUnlJZ11xO0v/Rtyv4=;
 b=uKO27ix8RZ+pwLthVIsPNOfaW0VYRse5HxrzcMmMNZNj4/d4Vcdrb4U+UDWKCeeIYk4AY/I8n07F+gON7MGuPCwqQmAm64xipeyFq8ziB/0u4jbhfWaKWGcvnGQS+QpxsXAMkPt3wHhihSozK7v8CtIc2p7/7/pWswHHC1r7NQ57GP66mR6+f9C3ISPV58ZzbPLsswClOUzwtr3OvR89Cd85jBt2/PZNoqaREuE+J5ZbytkmK6o1ZRqkyAFHDyuzBktHx7X8JP31sMnQpObDlE4Vkr2FuRNc5tq6H2o36YAZmmgQGJPioKzQgKblvVjMiC8ZMMdXKQiJFF21+pn25w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzdHUCfCbytGRtS+cKyd2Lkn3aUnlJZ11xO0v/Rtyv4=;
 b=gNLwVesZuRcaqwZ5P/wkNR4ihSTn/YUAWk7wa5p0pjoSYaaF9KgzJDg68aQ2gY5RrG9OBxIGX/Wh/NVxaf/4Klv7bFvq2RaGNNOlk0n2RS8pVQxtpi48Hn3ptoTbkZm/gX3qFBLtHFAVcreYPgvP15lmB3KpkJ3W2UyCbmKpZA3zGaWIFIIxGJ6Xd+pcIbVEyp9HXzOq/LCqZHOSanY5StTcj+ThD9A3al/q1oT+DTMNDfCYG8QvFnJlEEDo5fgaSs8dfZ9zRCykffNFM/GQRavgjL+UvyT4xj5wSys2siQ1lsMB3zR+9bVyr9pe1laBvERRPih2LqIZb6gBHyektw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MWHPR02MB11820.namprd02.prod.outlook.com (2603:10b6:303:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:06:41 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:06:41 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 25/28] i8259: move InterruptStatsProviderClass
 get_statistics() from i8259 to PIC
Date: Mon, 19 Oct 2026 13:04:57 +0100
Message-ID: <20261019120517.1448687-26-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MWHPR02MB11820:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a3d0ca-597e-4e97-230c-08df2dd96fc0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: PCI5xssRG+KrTMRYJUtAR0AtnchMqk9pKLvg0Y3s/o0giDhDuhldbjdnu0MosjkopNySP74M5KVeJWmzL4VMJQaP+xb+zcQVsrFQCovBgB2ma3GJXaD06466+ZMOZNLP4UVi1300Cr7+Y1JiDKDZmaP2J/B5QQ6oQfHNQ5WnJVXYpdvNA6nmwqXStB2gYo+FX323t5MJq/Y9gbpZTjHv3UwMH8RjMA3J7S51iBBwKc+ABWDB5KYCycD225BSK1OQ1atc64k3OezqJ7XhA2t1fN94z13P93qpKzTySXh+tYWzBh+NvqntRoqzPDio76aWYrfLaYBQ6u+GLtRzMidHKwZ3TDRsgxLAqhgAitA27JbFMMI008FwzQa0lSgITxyQ3zFGh/1KObJSwm5Zf+a4C0Ysdca03XkiIPLH7amtFD1IaG28QyM/XRzeZrwDt3MJumSuJeoActZJIZ/RYF1FQsckAVhXggxQ+EzlvBQ93gU4ZAmYMGs5LnpsnwCOlsyDxlLmI0s4up54HdBr7NhatAqDjz9ltymnX1Q19AQ1VcGQLk3oeJCGFzg9g3cG1o06fA8ihTDgH72WMws+vsT9vhIjpqP9nCmQaofDGYEJXD6OREiauu2YaPE0IGENWsg4IQpBFWxCziVKKtItebYSLAsLpa9Mp5DJtHmK3kSYoA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6BsdDoP54UWjFv2Eqi+RVppp9JzHMMkNQsT8lUYLy98fTxqaEEJ7FfeaYA7q?=
 =?us-ascii?Q?mXICmsRQ6f+08bISV9KCA7wbBCgkcRoUQYhXCzG42WlkPHND1JipFaYrsnf+?=
 =?us-ascii?Q?3X/uQu7IFRCfscECFrPsz2yc0xqgo6bdrzJklBh8i1N9GIzEwlpmHKzyLlgv?=
 =?us-ascii?Q?CBlIzW+OdipRpQRfkKOIO5cffbe+t6FgFUWGUmO7qt5TSExMzZ5ChreullJM?=
 =?us-ascii?Q?QZ1WB1wOPoegfmg+pXuO7YTpQTdhhq2U2ySCUERFRkRb94PAWUf6YWQDSTdQ?=
 =?us-ascii?Q?UrDVHQsdGUcEOOpFu92WVNsFWk6g4iH1BKOQaWWyEAV5+Gz0MSxtkrBMPkFT?=
 =?us-ascii?Q?sj1EQuBnAtLomIiTU08A2Nu0UG/FYzX+f/8iEif9x4uCRvBLpRmVP9swd/ZO?=
 =?us-ascii?Q?u3lr8QdEz6jUAhelLPvOKVDrb41J7UrqnLqIB256wJb/Ca8SjbRmRiJjuWXA?=
 =?us-ascii?Q?KkuRYXHYGBzPoCcfKj8HR7VJjdMkcPh9jHU2z6MCAYGEaoY6Q7yxaitE46DG?=
 =?us-ascii?Q?8Tl5Zeh/S7Yu4Ccepv4sSTEssaeg9Elnxq4WhyvTHNW9BJadNjOUYOg7mIHr?=
 =?us-ascii?Q?32TXUkm6DTPHi42bgKWk2FNh2rEolhVoJZAqRLsARhMDq3o56U1/yOs8BTo0?=
 =?us-ascii?Q?12REndYUVnKD5o6KUdH5iW0/Iiy3REPtwZRsPniLv4F2A5DO4cbmH5H8hAum?=
 =?us-ascii?Q?veJ0XcgMfPwCkEnbghnIzcM30fYHiORxYYDg1TAqg1FhVzqHf+ID6nogg1HG?=
 =?us-ascii?Q?84pAs0VBcAmIUCgG6SDkAQAzVnsFedBTQjondMWSVWZ/rdQi7Qb7UICycLO2?=
 =?us-ascii?Q?FD4aCJEG3VH01azsVEOvgbfObLQAW7HQPfNsHaNlC7fWDaNa7BD9mKT5rOEs?=
 =?us-ascii?Q?4q6cP80NtG0TKOifHsnzu7DzEt50mMwYKhBI6y/Ru/GKsucsjTelGds+alSN?=
 =?us-ascii?Q?K4l/T3pGAo3ZkD+lAO1bwfNc1qRNXkFBIFCvFf5n6orrBPPil54QJzIITQch?=
 =?us-ascii?Q?TodNL9SafJrKku8H6Me8RWd9ApMi1EYAguBWEM/koXYEan0BCywLu+BETCEu?=
 =?us-ascii?Q?yxy8VyPBxao04pcDR4LtDgIab2auUghqo/pmW40xUnfpPH2QxfU+GOWXpNiQ?=
 =?us-ascii?Q?2SS8vAYXrE1a/Xpi80fVwOwlfGEel5g75UtI8bTEZyjNZ5qVbove6Fh/27Di?=
 =?us-ascii?Q?shOSc2Lkpp3PqpF6CUeeKDrlqMSByhPYT3zm7wYgxQvo07Z5bVoLVJKHyg3J?=
 =?us-ascii?Q?xmkgc8eVOzXY79iDVfYwgcEeUkQT+bfxpgsOsqcHsBDHk2npCEeQD52bYp8z?=
 =?us-ascii?Q?qc/d8DYZIM17bqLO6XZnX4fXuPp9Ar4kcao/xFpG9mAj37tPWAlI6hHZyKT6?=
 =?us-ascii?Q?Y2FDQZDv9JzkaCS1/oPG/ACC0dPVqRhs9g8I97NOmz3OmJ9tTr3JoGBn7LXz?=
 =?us-ascii?Q?6rQoJ3uICPijjQpdWT09Y1GZH3qaqL8oOzRKEcF3JyL3pwYjzSYLJ47gjNPe?=
 =?us-ascii?Q?Rj3qpVqeqBhtm6tjQGpqVDjyrFSLl/WSCbCk7UQ7CYFAJBFv7oCkalZKHCTC?=
 =?us-ascii?Q?mSa3SnbEtxjMddAU8JaTr56ZtFDNBDx6Eyseho83wy/LRfeFAKbN2hr07REZ?=
 =?us-ascii?Q?C1WLs3I8VhgQ+GlQvfldK/uFunPbmXQffeRDDnqW2ppQl9w3dn/Hyg4Uko5i?=
 =?us-ascii?Q?k8lzFNswh2UCvp9bftkIKyYKNq+3REkcMiVky7Wb2ueHEbYhihtTz+Zk/qHQ?=
 =?us-ascii?Q?oWbRpDd182xH4THIo67vRyEQtZMwUh8=3D?=
X-Exchange-RoutingPolicyChecked: 3VgqgBrFo2TK/kZGtQNt1wm1XBe03fXmy7rmq8EN6NuOOguFD0lovMMyjx7JFAC7S8kVojrnSSKfNjmGF7o6zGq0ivnQA123VaAPgPBnH2yT7ANO6B19dQNjadMXmyBwdQpmMdPyjcnCG8HPPvrh3tzsBr7S5ZlIFLpJidIaHZQCR0NnRKFchtFS8cwn5D1/pE0Ynx5/Jfr4sKPF0RGK/5qGhTjQUlYBlXMbFPYVyNs2elcOE1Boszk9LgdvnFBrLG21PCWuZErVcs++2wQV9zn6AuLBMH9SWNrThAJyOZ6F7+dhDxdWLHO/QGHtyDuCYmmWbh8RkgIQTjBiWCx5jg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a3d0ca-597e-4e97-230c-08df2dd96fc0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:06:41.7970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gTrJVNSdNSrV1oFp6bshDdHDJgIaK0cSnQF7rzoIyBoxjeLloApFH/8mCHFKbIWaR8cc0LbrsNyUQEvv08obiR6ij0WM1pfPwSreJAr0LA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB11820
X-Proofpoint-ORIG-GUID: oxMzofU_jbYfVCur4kRFq25ggyCPCFsg
X-Authority-Analysis: v=2.4 cv=HYGB3SE8 c=1 sm=1 tr=0 ts=6ad607d3 cx=c_pps
 a=HzPr6oCfsVO1Dm+K1Iow0Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=A7cMN0_0mIGH7w_oRUwA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: oxMzofU_jbYfVCur4kRFq25ggyCPCFsg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX5EGJous4Wetm
 X4ZUdoqS1fOtRbiM/Z5N5lxcZl8ijC1H7DFuraSLmkg2yYly9gRrmKHj5B9sfXnlR0tNBn9KH2u
 uU57zDVXOIl9HizGfPZ+h+7vm7VWjYk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX4Ba4PBjsU9/y
 sWJctk3i1gK84ofezgL/MSlBDXgKlfsTbqUVrk7vC4t1FktYhYuHCXjX+/ryEZPvsLF464kdfbA
 HNcfF4VxW0uaUmllfTvejhJLI8X+oKv4hBEWtAlMOST7ez46pxPeb9n6pGXXHhXrK7nw9J/rA1Q
 TOp7Wmig4m0pZeqWVI1qju+b6nlzfXym4YPoha5BPC9UHk577wPwFC1p+gf1XKUzG6JTtt6B0Cj
 515Q4+hEQuTsnpJWH56ZSOquipYSG2QF4Z1buWySNlTfqGHrRaTtUAa3btCysTDeW3StI3KS94j
 o1fglNii3ST8aDOJz6041w2lITZ9bvZPYsw16Pm4Kz3KvF3ROcGARCq4ll26qUc/WscZwYSlqJm
 Iap5MYcPW+HsrUfvWfK6LvDueX57PErBgKlV9qgpeUP+ItK1PeP5NOmWrABQvKroNrSvCcxR8UN
 IT99GMg++DKeBfxYNpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

The internal i8259 implementation has workaround logic for storing interrupt
statistics since these are currently recorded at the PIC level (i.e. for all
16 interrupt lines) whilst being stored in the master i8259 device which only
has 8 physical interrupt lines.

Move the get_statistics() implementation from the individual i8259 device to
the containing PIC device in preparation for removing this hack. Note that
this has a visible change to the "info pic" HMP monitor output since the named
device displayed by "info irq" is now the PIC and not the individual i8259:

Before (TCG):

(qemu) info irq
IRQ statistics for ioapic:
 0: 68
 4: 1
IRQ statistics for isa-i8259:
 0: 68
 4: 1

After (TCG):

(qemu) info irq
IRQ statistics for ioapic:
 0: 47
 4: 1
IRQ statistics for isa-i8259-pic:
 0: 47
 4: 1

Before (KVM):

(qemu) info irq
IRQ statistics for kvm-ioapic:
 4: 1
IRQ statistics for kvm-i8259:
 4: 1

After (KVM):

(qemu) info irq
IRQ statistics for kvm-ioapic:
 1: 3
 4: 1
IRQ statistics for kvm-i8259-pic:
 1: 3
 4: 1

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/i8259.h         |  6 ++++++
 include/hw/isa/i8259_internal.h |  1 -
 hw/i386/kvm/i8259.c             |  7 +++++++
 hw/intc/i8259.c                 |  7 +++++++
 hw/intc/i8259_common.c          | 27 ++++++++++++++++++---------
 5 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
index 87ccd55a4d..d51a7fde32 100644
--- a/include/hw/intc/i8259.h
+++ b/include/hw/intc/i8259.h
@@ -1,6 +1,8 @@
 #ifndef HW_I8259_H
 #define HW_I8259_H
 
+#include "hw/intc/intc.h"
+
 /* i8259.c */
 
 typedef struct I8259State I8259State;
@@ -18,5 +20,9 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in);
 qemu_irq *kvm_i8259_init(ISABus *bus);
 int pic_get_output(I8259State *s);
 int pic_read_irq(I8259State *s);
+bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
+                              uint64_t **irq_counts,
+                              unsigned int *nb_irqs);
+void i8259_pic_print_info(InterruptStatsProvider *obj, GString *buf);
 
 #endif
diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index dd255fac24..2807409eff 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -26,7 +26,6 @@
 #define QEMU_I8259_INTERNAL_H
 
 #include "hw/isa/isa.h"
-#include "hw/intc/intc.h"
 #include "hw/intc/i8259.h"
 #include "qom/object.h"
 
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 48282db58e..8cea5fb12b 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -223,9 +223,12 @@ static const Property kvm_i8259_pic_properties[] = {
 static void kvm_i8259_pic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
 
     dc->realize = kvm_i8259_pic_realize;
     device_class_set_props(dc, kvm_i8259_pic_properties);
+    ic->get_statistics = i8259_pic_get_statistics;
+    ic->print_info = i8259_pic_print_info;
     /*
      * Reason: must be wired to the ISA bus via the "bus" property
      */
@@ -246,6 +249,10 @@ static const TypeInfo kvm_i8259_type_infos[] = {
         .class_init = kvm_i8259_pic_class_init,
         .instance_init = kvm_i8259_pic_init,
         .instance_size = sizeof(KVMI8259PICState),
+        .interfaces = (const InterfaceInfo[]) {
+            { TYPE_INTERRUPT_STATS_PROVIDER },
+            { }
+        },
     },
 };
 
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index d713795ae0..c3a3199b8e 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -540,9 +540,12 @@ static const Property i8259_pic_properties[] = {
 static void i8259_pic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
 
     dc->realize = i8259_pic_realize;
     device_class_set_props(dc, i8259_pic_properties);
+    ic->get_statistics = i8259_pic_get_statistics;
+    ic->print_info = i8259_pic_print_info;
     /*
      * Reason: must be wired to the ISA bus via the "bus" property
      */
@@ -563,6 +566,10 @@ static const TypeInfo i8259_type_infos[] = {
         .class_init    = i8259_pic_class_init,
         .instance_init = i8259_pic_init,
         .instance_size = sizeof(I8259PICState),
+        .interfaces = (const InterfaceInfo[]) {
+            { TYPE_INTERRUPT_STATS_PROVIDER },
+            { }
+        },
     },
 };
 
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 5fa38fbc5f..684290fb2d 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -99,19 +99,28 @@ void i8259_stat_update_irq(int irq, int level)
     }
 }
 
+bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
+                              uint64_t **irq_counts,
+                              unsigned int *nb_irqs)
+{
+    *irq_counts = irq_count;
+    *nb_irqs = ARRAY_SIZE(irq_count);
+
+    return true;
+}
+
+void i8259_pic_print_info(InterruptStatsProvider *obj, GString *buf)
+{
+    /* No information for i8259-based PICs */
+    return;
+}
+
 static bool i8259_common_get_statistics(InterruptStatsProvider *obj,
                                         uint64_t **irq_counts,
                                         unsigned int *nb_irqs)
 {
-    I8259CommonState *cs = I8259_COMMON(obj);
-
-    if (cs->master) {
-        *irq_counts = irq_count;
-        *nb_irqs = ARRAY_SIZE(irq_count);
-    } else {
-        *irq_counts = NULL;
-        *nb_irqs = 0;
-    }
+    /* No statistics for individual i8259s */
+    *nb_irqs = 0;
 
     return true;
 }
-- 
2.43.0


