Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43CAC88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nBJ-0003BJ-SX; Wed, 16 Sep 2026 06:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n9A-0001Nj-Gk
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:49 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n98-00034H-Hh
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:48 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G8q4Uj541814; Wed, 16 Sep 2026 03:45:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=AbKFGCy6bi6Di+SjRTibND8oFXMooQqZd57pXAx9H
 zs=; b=uyIAmcAkKaOGiJoy49/ZvMWPUEUi9/DNBahKbyG4sVR4UYJeIyxhP7+Op
 gcSsnyEV21n7pZUdWoannDO4ppcMd28d8hgwf8gMb2kexjTLuBjS/KXwkz9//oBL
 2DOM7uQ+Ih5oKdPAYeGlmVIq/zloXo2n5xoulQ5KsFN1tGdSp9jRpS1SoWP94G3f
 oWav7DRvROr4OJBImJ/+wboQ85h0pH8HwOKiysDN/NE4xuEj+I1M5j6gi0IY3//z
 M/Ykk4lXG6WqA5g6/lyQLTSngp+vmah06/KmHypKJuitdleEdPVTXpZV4enPsS6i
 Q36B1J/9svGkTFnFPk2qtlJzDbyyg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021127.outbound.protection.outlook.com
 [40.93.194.127])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gqa0pta0w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 03:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fC8njwabtF4WW6oAlHmE6sMMIJpA0dBudFJAanFXdYmrc8Kfa3io3ClSdBrWrT3Kecu5V0cPi+/7BJDLm8z9PbOnrRNQf6T7+KlOX+d4voqwxfhgR6akp3wkdih36vyjHPElzqOPlhkW+6pTcbK0AcVPik94Cws8Ud56LqDJbaMhAV9A7vW9mKq0zvIaxiToyiRY0n+0gyHQqkT+1NofrguFnE45XmO1SiPoUg9lMcj8wpHlloS+SQkRhkdGjnn1SYy/i7rDq91Rfm7WtH+FEZ8rExKVzNwe4ru6NeZj6Zms015Qgx3GcAeQhe/D7A4f1uMRnsJhqe2TSsrA836FuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbKFGCy6bi6Di+SjRTibND8oFXMooQqZd57pXAx9Hzs=;
 b=lyNc5psA0/ML8NuC4mOw9UpBHfCTsY8CUTp+fcut1L048BfFqghcb+tGslezWQS3lT749FnLbbiBVFM+1QTht1p4ZGATnXLCXVCF0BCzhYpytJeC4jK3ezzjgWdsGBjXRlBEQfiOiWVw5OAW1sMi6qTDjmSD6bauDj1WXGR9jnAmjoSub95lo46OJYkFRRa56rjNX4QXvsgrDpj09Sqpby7FCKCbm+G8jNRuomzWbEEBHlS8V716laZAwhHD8xJJfX3bxFnSLFYZjA32Sx3TDLkFRQGrvlemfKZY65xnnwusqDu1AdH1q1w52P/JW3zDEIbWKg3FuADjPZH3QEm/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbKFGCy6bi6Di+SjRTibND8oFXMooQqZd57pXAx9Hzs=;
 b=EPDwXfHj1u1wb5qe4hSwzniOHQcC/8H0SCTbpnkp0GEN7MySDXvBddZl2blgaRsUj0Hvk/sAyWLmlkiKs6nmtoPwlnwDO+1D5Dgztw7n4rK9UsqmgV2+9/tFwVz+7Qs+X/e3r0c0yBNJYpCpxujkXs39To+o3fu0gFZcOK3fTaYCtWZafqHQnEpPLhb12QQMBkgpOjM3Fl9PbS9r71+kzoGqRKzrJBUAKkKbUbtfhsDqj96oLw0N5Da3fDLBDfgFGUt/qAdiXjKPm+fMl51ql44ItkqFIaZrVX9rdmCLVb88yEAB+GzpN19S7XR3dDkSvrF5F6QuQjVI4oO5AfZ4Wg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PHXPR02MB11343.namprd02.prod.outlook.com (2603:10b6:510:3cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 10:45:38 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:45:38 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH 17/22] xen/xen-hvm.c: introduce TYPE_XEN_I8259_PIC device
Date: Wed, 16 Sep 2026 11:43:45 +0100
Message-ID: <20260916104435.600211-18-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916104435.600211-1-mark.caveayland@nutanix.com>
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PHXPR02MB11343:EE_
X-MS-Office365-Filtering-Correlation-Id: edbc8c1b-417f-4626-04f5-08df13dfa551
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|3023799007|10067099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: RTVu5x402l1nA3jWtBY7Nmah/Z/dPEI2ST5uemMPworGzeUjMHQpy26ZwVdZIpdwtzk9BWbWF5cWcUzZKR3c6bhIAEX2FonRXfFy6WDdSIzQPYmWBegeFV31H0+U7eaulKH1wyVnULt9yqcnD1OaQ8BXCgDS9CiCf55Vn8TkKp1az80AL1yslfa9QfKo7iR5wo54ilajOp+cnnxJcrmK+liNG8QkaRaDSe7I0XG60EK7HkUSpxfejk4AyevNce8j8YAqM1igiCuYASIm9y1dxf2WkFExmW9Reg1/HfDBRwyNM+21CSV/w2f5i+CuWEBZDNO//sdl+zuNeSrwlLNWY/NS9MP+biaFlkXQ9dXszNNiTldHC3NfcvsUHTjy4L0X3Pz5ArRUS1HIp5vWHEOuC+5DbRY9rHaS6HcPQtUdPq+6DKlHwSfqkv+QBQoY/OLiBHCwJc5xqJ/iNjvHyVElK6aBnFKypCmu5AbxSTqVmdObpgrn0hufzJ7PvgevtUztnF7l3Nq2Jb7c3gUi9lHJR5PUnrq5pXR4nwzOrkOFThoNVxHgJQ8ab8nkq56Pnn6FphYNA6mwODZBKbbijcu2WN7xjIX/HxXqjQnxysRYAwIU3pjaftpnaHivuyV2y4qyvHPyEBDOwQfmXTPcNA7eG1ZGrY6oAf9iD0NiiCtCJPo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(3023799007)(10067099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?spuzrXT7E2cc9NtkVcBKdwUTCWjMDbIYz0Q/srBm/eu+gqYaySzfSsGg3ngG?=
 =?us-ascii?Q?WauYFAWLu9FEZtAHyhDG6NHqyutHPhOTTKUVB75t8vq3ZPu+yzsO8fXAUdMz?=
 =?us-ascii?Q?7mW/IMK0rrDMMUB/Ey+Af5Y2HgtzVtvRsZ2/nvEM3RpMTtkSI5puuYPNGoxa?=
 =?us-ascii?Q?st1F53jt/vhJUTuA69cUQ9O2/bTBFqtRBg4l6WWmU9PemQ3DRO1N7AV9muxE?=
 =?us-ascii?Q?dijx7XhQS3X1tBJbo4m8dsZdjKFbsgVgyfLLsHCJCB68fPezZN8pkrl08exe?=
 =?us-ascii?Q?LbDN7S1jpAIZbVQR26qJw3/y5yIaYTK7dZdpk9hXRUC0geyehjAD1zbvhfHt?=
 =?us-ascii?Q?0Html/MvJCEAABJIe5xYHsRekF2g/bnXByjvxOJKaheQiUmaBLUm3K1JfVOo?=
 =?us-ascii?Q?Ssc6CpeL0YyLYXF1E6nQjxGVTLvN7uMJHtqSqRvK5wdNMTxTogy6ctPPO0jP?=
 =?us-ascii?Q?q8/EcWsyde/RAmtK/DedgHAvajkATIJ3zbXjQcSVPPUFnQXEX6vVA4KqYVKr?=
 =?us-ascii?Q?U0v3lKX+qoIfRacrKaqHMpKKC1ZI0nFw+wn//5RW58wAfGloD2nxRXXrzncE?=
 =?us-ascii?Q?zi02go0Am7nD4QRRy3P8V60y4AskWOK1AYbtS3BlVMmnJ9usnCOTM/xzu/Jk?=
 =?us-ascii?Q?uB2tRakGGHaXoMT0OJm7vXgtpT/JHIGnICicF3SzFz5V79QXqClNwrx5aVpz?=
 =?us-ascii?Q?jISPFuNBcV2SlA7QVlZErdaiviQU3um3DJO+GwK5g7ib5Tk7pzDpYoRBw45Q?=
 =?us-ascii?Q?z0ia8L6K5bZHnFt3t+ogLB43mDtKnRwwj0sNuu2Q5TzHJ5sXJwBeY5cpsr7Y?=
 =?us-ascii?Q?OKUICW4ovksu61SJ9X5wdx4q0tplrJf2CHdRCfSCrD05FISqO1Zsp9Amkv6a?=
 =?us-ascii?Q?VMp6NVbBsH9Dx/A9+8ho5EE98x6iIi3i61qilsKn4Bh6Q12R5gOBdg5QPZ6d?=
 =?us-ascii?Q?ivWy2dHe7WGfKFL3oReiYbPOvYrHTLsGxwbv1h20WVu5Nr6KfqrxyRPcq4rr?=
 =?us-ascii?Q?l12HRlmhGHyFcwubgSED2kCakIK7OgqJIhVYvNUghuPSHKXzR756BOgxIbd7?=
 =?us-ascii?Q?m0u4+SifS23YOeaThqZXvpObE4FitmYbqVIBlmE5Z1gUEiK3oGXevzjFfAO3?=
 =?us-ascii?Q?ZoTJjCN49gk5PXrSzaG1GoNsWY+BlYzeDJQY8XQISrzdBuSulWDkDg09daoP?=
 =?us-ascii?Q?NONDKM+gSNerkcNMg+fEZudPPIMC+M1KgYr7DrPLMQlzK9R4C9Mwq66cgQpI?=
 =?us-ascii?Q?bhn6i1l2Aq66kngzE/ZuNcfdxWrVR4+xVYCh4IlPQqRMnacuVtS54vNqFbWU?=
 =?us-ascii?Q?S1Fw8DVRE44yrtlWUaOgqT9+HLi2dd4Z9V4IpaH8MiPzmqSvOzkkX9U5VvNK?=
 =?us-ascii?Q?wi1IG/Dkb7KSEDHmFAcbb37s/nbmzdWyUwUd2+HDDitb8Avt46VwnpEMFFzG?=
 =?us-ascii?Q?QBSgvRw3QO0nxpVczsrRYJXrq/a4p7DL6WEHDXdge28910+DmzcsfVsh8EsM?=
 =?us-ascii?Q?VNS6xlZpROOnFhDkj1p/ROtatKSEHTGpJYAIttNoqs2D/A0HSaH4mKhaJX2t?=
 =?us-ascii?Q?Q3AAKlN6aF5AgDBUnnFp8ECG1Dom3oVMPTt7SVAjNw0rn134px5GNjwrkaG7?=
 =?us-ascii?Q?Vc2s1hynP0l01+oJlzpwMi1cyrtzS+qpcpdHkhkp10OIRqIxQSpx3Sf2pwuD?=
 =?us-ascii?Q?YZYtl0vpSsq6LM66ytl2WdIO4ewVKtKZR77mBJSAbGDGqjnM0xGHKNEauIh7?=
 =?us-ascii?Q?DZGlpmCOt99NkdPrQRk893MlmdIG8O8=3D?=
X-Exchange-RoutingPolicyChecked: gwBL1mSHqLxeX6dgLLLCY4OEW0iqlotCK4tGRGPdvfXt34IH70MXyO8X3hNLs+Tg8uoyJnHzzz754WqxJciczpNGNfmJPg57zrt2HYS8roSKOFQUH8mP5loCALBd+IKmG78HNBPzPvIZivV9HkTAKRi/SCkF+1oyIaFoJyqf9DWk3sV/jfIqUhM5ZRBO5giMCXfEJ/SQTpmJk7vX0ra3cBlDs5LZAhRa/FmOiWiT9FE6pcpCHlD5nNyqdxIzUGQK3umPdY4RFWRVmCXtt6g10NAEXXfgE7MH3mTQz2rkSalxXXRdiX691a39K2bglIhuTw+/xCttZImkLJhEOciFGw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edbc8c1b-417f-4626-04f5-08df13dfa551
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:45:38.4780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71lYsmtJ4F6NRmrK9fPw78CywHNLZ8kQnamSSJHlc5nXTp/7tEd9A4fUEiszuB/vpCmOGCsD5YYfxa+LvcHBWu4qP3oRtDXRgXByr+Lh4Js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR02MB11343
X-Proofpoint-GUID: 2c5Iupx0Z644kjYl4UWSkPZIK8rJyrIo
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX5OGqPFMkD++J
 Xa5IM6lVjCseNHyDdroiKWarjk0OM2xcl6SIGRHjaxxyMh9EjnqerVKYwQeS5tb4wDjilTcRJI5
 +Lrcu0bLpWhh4JU2WKke3yu2QAsy67k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfXw60ffdmqlbog
 qY4qr+LORPFKLiebn8rz9iZ+T2QPCgKRbLP8b6x+N8RMpZCCu+t5CtD68VqsPs0cJIXGXJBbBCJ
 8/D23at/y/SldsLA1YBXmUEauSdf5B8WvTplyaAu19O3W2jfPmU96dTGsvTrbAGrwbX9vq7ykFo
 jXvRwG/OC+UfT9FhpkHztfZYY61tZ/RG4jLxoLstRkjNNHkNqHBm8lD7cam45kJXXjb6QsIzy/f
 pu+uSYQ5HnZ+e81dKhV/+r8qJrh45YQI++RA7JgizgXv+muH2DxvQJc6rZtcL7cgmZR3Ydv9HG4
 dYp0jVXqhQASCWrdejD1PvJS+297GEFwCrerRRPEfCuP/4uC6EJJERMWRVdjnKCXX13hsiKyPM0
 Eb4hx6ybH1ztZU7iNqrBSGG9SBuhFCfjlntlUiJtvi1QwhtJGOV6vC14uV/Tjs4ZVgiJmlGH4Gx
 HBjbPbHS92P3HIH4omw==
X-Proofpoint-ORIG-GUID: 2c5Iupx0Z644kjYl4UWSkPZIK8rJyrIo
X-Authority-Analysis: v=2.4 cv=Ps4G/AM3 c=1 sm=1 tr=0 ts=6aaa7353 cx=c_pps
 a=wuCIV2M2hcCPwYkL8T+rjw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=tqVLSPGIGyqkaOPIRdYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
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

This device represents the Xen PIC for an x86 machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/xen/xen-hvm.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index af3a90987c..b2378fe3f0 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -13,6 +13,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
+#include "qom/object.h"
 #include "trace.h"
 
 #include "hw/core/hw-error.h"
@@ -69,6 +70,12 @@ static unsigned long *dirty_bitmap;
 static Notifier suspend;
 static Notifier wakeup;
 
+#define TYPE_XEN_I8259_PIC "xen-i8259-pic"
+
+DECLARE_OBJ_CHECKERS(DeviceState, DeviceClass, XEN_I8259_PIC,
+                     TYPE_XEN_I8259_PIC)
+
+
 /* Xen specific function for piix pci */
 
 int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
@@ -114,9 +121,28 @@ static void xen_set_irq(void *opaque, int irq, int level)
 
 qemu_irq *xen_i8259_init(void)
 {
-    return qemu_allocate_irqs(xen_set_irq, NULL, 16);
+    qemu_irq *irq_set;
+    DeviceState *dev;
+    int i;
+
+    irq_set = g_new0(qemu_irq, 16);
+
+    dev = qdev_new(TYPE_XEN_I8259_PIC);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
+
+    for (i = 0 ; i < 16; i++) {
+        irq_set[i] = qdev_get_gpio_in(dev, i);
+    }
+
+    return irq_set;
 }
 
+static void xen_i8259_pic_init(Object *obj)
+{
+    qdev_init_gpio_in(DEVICE(obj), xen_set_irq, 16);
+}
+
+
 /* Memory Ops */
 
 static void xen_ram_init(PCMachineState *pcms,
@@ -760,3 +786,13 @@ void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
         hw_error("Invalid ioreq type 0x%x\n", req->type);
     }
 }
+
+static const TypeInfo xen_i8259_type_infos[] = {
+    {
+        .name = TYPE_XEN_I8259_PIC,
+        .parent = TYPE_DEVICE,
+        .instance_init = xen_i8259_pic_init,
+    },
+};
+
+DEFINE_TYPES(xen_i8259_type_infos)
-- 
2.43.0


