Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7469C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8HdR-0008Mo-5h; Fri, 25 Apr 2025 07:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8HdP-0008M2-Hx
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:23 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8HdN-0000Og-F3
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:23 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OMCg3m009062;
 Fri, 25 Apr 2025 04:54:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=rAiJsSFPPagroq8l2wlQxkZJKNVi/ezYamaZX3FnD
 l0=; b=emMHXsSGm/3BSB+s6vHTb+AxgrMM1Ujde/tlPd5mDPZBdI/eeVZlcv31k
 Fr3wAm6PMKUEnkydnaxaRpzBIPCH7r5oxjvo5V1TaJCQY0DKdEBF4RR1egpK5CHx
 wRc5/JgpPwkFv/YkJk55g5//UTxq062bqe4dJ7CAlB8rwItpKZH83ypdeRw85HBL
 vHN1li70/oUPzieLgv3WsRWJHl1VOKnG+2RizsQaVb2q7nfI60zZjAFS37bBZevk
 kHKynD/BlvZlIeux3V3sQ4NkwAACrciMiQ6In3P6D61+80rDEwKPgCaLmKz65Wvb
 jD/TCUNrd+ZciOS1cOdEtYdZNF4MQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17013074.outbound.protection.outlook.com [40.93.6.74])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 467ww499st-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 04:54:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIZQuREPEbpZq91QJZCL+gxFZkSsv0n8Om8wJwSjW/3T0tqDtt6eWE9sHprwTOypY2dP7X5Uc68m9AKMTYaBzb0yOuyyIGOvdxBiaUJba8sOeIWUxmf2QE43LqLGEa8BInBGtnTClCsO6/COWfWyxi1FaTJROOy2f9od4QFbwyWT9mlPQaJp1Y4UMAdB/WFUfvS/T4WHJUDxcGziT/CNiv05ME32c3Lau6oNPbUk85/2qnomdKhwA/M3dM9xSiPZgm/9zJWX/mbfjT2rriLI+KeUnJYtaKmyAIKy2iDA8NJH6GuLFkx1Mko0oMXifs4Va8bmnEYLWe10Y30tF1eZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAiJsSFPPagroq8l2wlQxkZJKNVi/ezYamaZX3FnDl0=;
 b=VWFThA8AtOJEdCPh8G7QXYlvKodYUMs9oXwRShPpv9ZpKv8VhdIHNH3iiLBQq1P37lknpFXcJ+XH5h3Smv3iO4f2RSWb/tiA4AI93W7yyUXZmQcWdB03yVBz9rye5LITXLG6kYXWIy99L3+zIk4Ffosm8puYBC/2hjfCp2GLRNrhi7ZUxHIrrwcH7d61ZmS30S/LA1qk8xufY6bE48D4pptXQAhNrMQupItW7Ked0K4PtAtMycCwNZaDV/gPCKQzXWA4H6VJ6/izo0KqslhQS5sU1IES/icmy9rcqPV4GHIKsDQ0AbeXnoJdQrVcarV0p2IgSc32fTky0krzyAGiWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAiJsSFPPagroq8l2wlQxkZJKNVi/ezYamaZX3FnDl0=;
 b=y5WvDfybPH1lVdXZNu0ishQxoG/1TtnO43zyugi7R0XvDTfNarz+ekwslnjchnEawFwMw7jwYlBDV/Kf49OE/k6kBMpkY0HihKdc9x+quaaBxwtp1v6AOAn571Timile1RVAqq7X6PpN4a9Ac6qwMHxdqjMVWHIl9BMSumixgUG5ciiZeZdY2l1y9E01M7GiKETVxUsNF1+ui4HotIBzxps3JsNWosrVtNYM5+2N8ZCCyJDyRBOIH0aJ6Yvq0rPY2z01B5XvFhW+12VUEM/iDlqUSOCUZey9BUJsa9TlYWv+Dow2AgpTFYHDur1Jb4yflKCabvxzXpR9uM3CX+V6qw==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 BY1PR02MB10337.namprd02.prod.outlook.com (2603:10b6:a03:5ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.10; Fri, 25 Apr
 2025 11:54:16 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Fri, 25 Apr 2025
 11:54:16 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 04/12] hw/i386/pc_piix.c: remove SGX initialisation from
 pc_init_isa()
Date: Fri, 25 Apr 2025 12:37:51 +0100
Message-ID: <20250425115401.59417-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425115401.59417-1-mark.caveayland@nutanix.com>
References: <20250425115401.59417-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0140.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::45) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|BY1PR02MB10337:EE_
X-MS-Office365-Filtering-Correlation-Id: 910beb1b-b94c-42c1-bffa-08dd83efe7a8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ygOrdwB6diKkyKo7La9PyI7OgYhJUanBaDJyBj+1DvN4JIMIU1U7kKGSCECG?=
 =?us-ascii?Q?ExtXArfeBpisIwRx2LEBZsVpr1I0V5rwI0HDue7LGDGicogEqojlhiU5m3Ks?=
 =?us-ascii?Q?AJVPlga2Awey52O+sOaCpg309FCQbhGGJ6A1Nr1/W7glmbd18FkmNGSdemil?=
 =?us-ascii?Q?E3mmyMRGatUc0aHbHa4Qo+X5r+7Mx6Gj1xsKwin6WvODRiUvrgJMl52ORBAv?=
 =?us-ascii?Q?BqS0DBnliPd2QlnHGWkBgiCE89YFXSH0nDlX0PqXfkBlvtCjTvXBlsTjnsXC?=
 =?us-ascii?Q?SrLgPV6zb+v/uyVReqqVZJKClo1Q+LSxdA2G9XI/35m5QDCnpR0tyTfMCMrr?=
 =?us-ascii?Q?0td8f1M4Rd9VnObA7SZ35zxtPEn5crDzcCkzqDWTSLZ0FUuGqGusDv3AxxDR?=
 =?us-ascii?Q?IAA9G3LvZLNw2kkIdQwCH75mIeNlFhUYba2Wi22gbFVlG73FV4B7RR1mc63B?=
 =?us-ascii?Q?ST1I3pSwGXqrRNqNzLz7ZH4tJUKSJcu9J2CVe52kjauuIxhU0AfpYQJbx9ti?=
 =?us-ascii?Q?JyO1OyrqxEKOz3xKGX/LZjHT7HNyq6y+hXmQKLf5mgeCoorqDXCX/6O08YKW?=
 =?us-ascii?Q?wpP8pGo1x62/pHIiQybK9W2pE+DgRcSYSjkj4aMFDi2sTttg/I/uznAITMOp?=
 =?us-ascii?Q?zFMw2nkg0r/ntZZec+UpaLK4VNSXhuQgdQX2a8BWwxpmN5dKXIPXhBvE0lmn?=
 =?us-ascii?Q?H3Bli+VB4X0YqyVdgpdNWvM2hX/KP5/nXJTqKsKk4ghsTjUrGhq9xZqyejtF?=
 =?us-ascii?Q?igF9ZYvM8ZOQDKfOduksnK36WOckWS3c4DnQLVA7igbOfA/Eu2cd4JYKKb7E?=
 =?us-ascii?Q?RzQv2LEwvTI3VCVyZYzEUa1HDAnTOy50oixA2RzKHvi7E2G0sGawwXaF0oOp?=
 =?us-ascii?Q?xjPcnwW1XIYNF+h9mf2v3rnIhkR/XixAiRrl3sJyBEM0J2yJX8t+pPukZ8PJ?=
 =?us-ascii?Q?u25sC9xVObucyUR1vQr8HtW1bNXiCUQ4Dwp6bvv2EOeu5OHv27LpBl8FMG/G?=
 =?us-ascii?Q?b2cZvCQMtlFoFs9WQkUsuzL9qAz2LF9v4TxKW25UVTYarIlDfJCLzvvnekv3?=
 =?us-ascii?Q?myv67wMOBvqABBs4zPvNdQXlBlDPkFxKL8hNv84Fu+tj1nyGLJsXGyjiqCt9?=
 =?us-ascii?Q?pSXAxKi2I9EdXUk4EyqPNhRCBptKU0r+LFr8frM9IyWlYl0/fBra1OT/srKF?=
 =?us-ascii?Q?oe7SmiQfSOokXvhFyVEEN+CE5hyK9Y4gWPuXwgrWGE6aKXH1NFl7UXw91DJi?=
 =?us-ascii?Q?kdWg8J5UUtxqQGDqPpY099zZRhF52vzLZgdvfur/VDr8sEHM4Oeeeqa82MDI?=
 =?us-ascii?Q?6mm/Kha+FHdIO6+06e9zu8KncWVLri9j/JdWSL1pf+ceTJov/CfZvGmsya30?=
 =?us-ascii?Q?tJWGZUIFin9Dr9O8BNnpeookci6/M38as/PloLJa+fLG+Ex1qjkZgescfsz7?=
 =?us-ascii?Q?iNMr+Bja6RI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TNRKHKj70krTQThK1oNZLfsROQYT0K6gyytNzmJ5n9rG4hBlJiZ19Bwv4x/2?=
 =?us-ascii?Q?un/PvLo5wLqQH7E4u0mykQZO0MrRH3OuzAzJC3WBK6qTguoO/ACi7gVIWmhe?=
 =?us-ascii?Q?8IwEmWZTG7+NoffxkqrUFlqIDls6A3Bs9BTGPMtUFxJv/e2XArhznX8gElIs?=
 =?us-ascii?Q?oLpPVf/lq1vywI/fbi9MiXmlZM/kWgef6gKMmhWwbSL8kNEJPB/30lN9BTjG?=
 =?us-ascii?Q?jOS2t0f4XlffGVrF7617AdP+/k7EzDCok3EMexB0zYuA4H2ylzA86PP/pF9u?=
 =?us-ascii?Q?NldydkrIQgyOhxVtddTYu1oW4KyhsYiAL+W0P4ya5Q+k7VZ5Ez5KqvfiSrnE?=
 =?us-ascii?Q?Up6tEZerfmeqxbJEmGcplcgdXhpxdZoU0de2V9sfprsQA87t6ptjnPocnfzV?=
 =?us-ascii?Q?cAIeg4uPkq3o8ze5iHxIVYitk+Glwc2LOLNnA+P9sX9BBIvpqsoFvBClZxDJ?=
 =?us-ascii?Q?Zu7mxZng1jeqijf8vWv2IYqfkHj9du1FnvfEd89Krse/vmBZXUQo9b16YNaD?=
 =?us-ascii?Q?LVZNXCx/T6s/taKKXDOHPAgRUpyiurRLRltZv1kJQt55CtTaSDiszVrBikMe?=
 =?us-ascii?Q?mKzuWrOZAxVS1lyI/fYNIYw3pi6CQSAbE2oFxZ9+xLhRq+ID2y6vXHVxKGaa?=
 =?us-ascii?Q?lCLq02RRvfk6q2ZcY0aogN7LSctzZYgwlgYWMXWJRs4HnsOqLsNiTp5cFNGn?=
 =?us-ascii?Q?xhfURUL3zGJIPP2gi54hv149zLl4JtB3bvj9I93B/Vq+CIPc/OEHqH7KGIWF?=
 =?us-ascii?Q?58marTClECox2xp7aORFs99TFw4LCYHt/fR0D1MRzJhQzJux/kN1b6edJCnX?=
 =?us-ascii?Q?WNYCghwlWrDBOL/ILJf4iJi0i4wgX8Uhv08yX7EocInv2YPTHeXVn+SRaLOY?=
 =?us-ascii?Q?jM08u0CrMeq6jqnzKpLxThMWHdlParDPObJGANB8gIYB4ZVmnO2oA8u+C31z?=
 =?us-ascii?Q?6fPUwPn7YGnHh/4ypUxPv75DXuubMJKZp5nP7yzEXwc+kwM5ndMy4gsgHdwj?=
 =?us-ascii?Q?ihRXGTU/2D4oNjNPXDOjwpMqacy7fpCbIVbv7a+3ZbudiD2I7XClukfAoi+p?=
 =?us-ascii?Q?uLkoi1DOooHE1G8QmoDf7wJkP4I799V0/tECptjiP7cNgXuPCJa4UAKAD6QR?=
 =?us-ascii?Q?H8ttc4S9QQThLeA6EScozJgqS515nUNrc44sGKWIwcJRBRhoOBy8tMcJytUF?=
 =?us-ascii?Q?GaQd13LB8Q0CMZJ6bZChux0RoGs9JPjSsoDpTU4Jw3FxWVim89nMFckCtZ20?=
 =?us-ascii?Q?01CVwtiSF1dpcpFihXjcKDTUXEqEVBWGRYaN7447zzV6+qtlCz2Xjmhs2pgD?=
 =?us-ascii?Q?hYQk9GJFjEJKqK3/AyD86qbOg9DPKQupNTwHNKnilXcLuWniqB6BCyg4k0Q5?=
 =?us-ascii?Q?CJWpirS6LY/tTKS7YdOg/wNC8FYEvWoyyDzT+ZqgAq21Awi8iiVGgk8OqnlI?=
 =?us-ascii?Q?/21nGAN/j8YeHD7MEUyup0tOAryQrM0UohvzaplUgbHSuJLgmOs82vB5xao5?=
 =?us-ascii?Q?5DalSGjlLj5Gl9URzxNZRHkdQa56AA0k/0MOpcS4v0N5tWA09ZZrpBV/kSh7?=
 =?us-ascii?Q?Zr0YCRSPyfAlHFehAQ/GXcqo+csvL6qCSPaifFJk1zHQJy/5J7rh5hUyUAhj?=
 =?us-ascii?Q?+JOizPBEYRvZl/niZEQozhLKBuwN+YTwDxNA5/Tfpidmv9LinZ8Xh/v9r5Gz?=
 =?us-ascii?Q?J1t9ww=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910beb1b-b94c-42c1-bffa-08dd83efe7a8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 11:54:16.4719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8GiM+jqay3En2vsY5z5Ki25DVvn3/by/8Ned+9RyXpugTB9smdsFHvi3mtwjCGVbtAarqXYi2dELZ+AIv826Z4+zSKvoMLgUxnHoctaGKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10337
X-Authority-Analysis: v=2.4 cv=boxMBFai c=1 sm=1 tr=0 ts=680b77ea cx=c_pps
 a=4/dVwHrG2xlZHl48ITU9gw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=rnFr0Qxienu5vtaJ29UA:9
X-Proofpoint-GUID: lCY7mABh8rrkPnrr-s5EmESGt2gZ7gbE
X-Proofpoint-ORIG-GUID: lCY7mABh8rrkPnrr-s5EmESGt2gZ7gbE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4NiBTYWx0ZWRfX5X+P0vPTTyoo
 3oBVHAR2cGS+r0tIek6To9r7VYq47ph2Kp3WD+deekSOpGyRcrMPBBt7iWF98wIocY4oem8IMos
 Y25q4BAO9cnUpuyhawB5lP3F/fN2OdC8Q19Kos5GFZiNNHOCNFseiUYbdEnLhFY1+I9MuDGhlFR
 XGte82ukosQbPby4A/nbsx0uQ3M+xS5f2z+52dGnse+y6aQMH+iHCEgeXrAJ2Zrjqc7f1FOKGCw
 wqXgb462ajFvewQPOK8mFIut6/fts3iMxsUxI3mrvmb9JKV8ReTeO04EMLAOrF33pircGvXJMzf
 joU67eXz2wWHd21SloAPYxGFcL1NeMKMRW9w5igMvcoU87r1fmdC4ogBts6TtmNu3a1iehsqsqB
 UPE60GVQk8VhLSvhyDe1zT7McEIN34MPKgHltcFo0KJaWO3NMCxDkObJcdfY2TiM+fnOTGEw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The Intel SGX instructions only exist on recent CPUs and so would never be available
on a CPU from the pre-PCI era.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 34f63a31cf..a12f63dad6 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -487,7 +487,6 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 
-    pc_machine_init_sgx_epc(pcms);
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
 
     if (kvm_enabled()) {
-- 
2.43.0


