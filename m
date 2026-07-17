Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60AEC44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkgcd-0002gi-WB; Fri, 17 Jul 2026 07:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkgcc-0002ej-Gr; Fri, 17 Jul 2026 07:20:50 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkgca-0008At-F0; Fri, 17 Jul 2026 07:20:50 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HARgAM3666016; Fri, 17 Jul 2026 04:20:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=2LmiZa5qN36GmM2FXz3tJ3sIFAkbUfV3UH2n87qDf
 50=; b=HajvO7Ju0v0p914fz9ggoNX37BSf55LCj6gJHgAGIz84d0K7ZAci+fNHT
 QBIwDnmD2wRMPH3dZaz98leE7Y5dKgQM8bLLrQc4MtqCmbo71sU11gyE5uovBXuH
 YmmiBkxG6u1QfC0TGCIfT/aflaL/FZAPHEHN2eBB4y3T7VW9hKKBWEnwfTIPZ21C
 E7g31Xz/35YU2QsF1T8BnwgBQYDiBlosg+/v0VP3WhmItp5yN9fc+J6+O7uVwpWA
 AimweQvHhDvk/5mYJ5Ki0Z0fH+JdipBvy2lQCzl/NfDOG36BniTZngSVk/7mttpm
 NYjqM6Bayg+s1fpKj3tjfpa0wmw3A==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021115.outbound.protection.outlook.com [52.101.52.115])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ff8dh1ag1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 04:20:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNIE1XajIlJXI5YC1BTCuQ7Mk+WmrTsjW3QHkk9o4E2I0Rq3VKaJVAlIXDbb09xK9g8z84godVAhZjaBRKvvA6CgRc00/CcpxRAWI/7rlo8Pk7DOZseb1+sScIbTDlOOnwVH+xhNMAbv6E5k/ADcJ+AZcHBgDMwj5c6sck6B+J+sRHnKjCvQqdjG9/fLSueB/ClQMNMGYEiqMCu0czhXQCmDoi9O1FWhqQ8GzfWtglb6j9s0Ujwp+46fbK8YenldOvNkNDkqnb6vCyrJzUXcNiycfNMUBgsXhE2nd+KRXP/k4bJ0TfHzWB3MxbrmnwtvH4OP1LxwY9En2g3C4gZo8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LmiZa5qN36GmM2FXz3tJ3sIFAkbUfV3UH2n87qDf50=;
 b=kvEG36v0gSK/1qj4FQwfu5t6TN6OI6aSYWOVDYb62W0HIjhziBX5fltveV2l/EXX6PRyrMKdp/X7aCkAGs6UhSU/LLTZRgc/HSZqTSeOqR4Jmdm+DeLvQUm1MuXKBQReTVsgPIgKkQiEeq3dt3Dk35ZEo7AAZrjL/HaaYBW7/mfGku6xxidS3BjFmKoDW1wBf3lO8gsVNC/TzkV17uAGYXjI4RekaJqwfUxSaRs5GLZdWUnK15LqfS2ggRxrgmKkSLirgTwY//syYlOQJC2XDXuXc0IFgntT2/WMPbRhKN7hXQZI+mC7DPXPetPt6XjdOPK5Loxh98EJ1k/ahB4DBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LmiZa5qN36GmM2FXz3tJ3sIFAkbUfV3UH2n87qDf50=;
 b=FO6LemuoeBbghLMc110W6NsYUyV3FUi9GktvYUNFNqKUfbVmepLOWVnoJF/zyvu0AgMxTyanCpNXhrEsmAdbOqaL/OfmW1ocej4zkZTal2YgMO8NukdzA/Pv9GRe1kPuba3bz9j56P6/gwNgFYjH112InsAO/Z4/EjU6W1VGmS/ln8kjx2cHVcdxSylodciDBfTpgopgsC8zz0a5gKgUUOTitQav5WfD529/lEhtJk8fKGY7XHbCoF1y0QyeKKde2nQo7MRrvn6y/F26oNsopQPqSVTmX1T6yZM8DJIpNrik87hfTW21bvSEVGf88Lu9EixuTL7ydZ2DLQaAfHn2JQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7503.namprd02.prod.outlook.com (2603:10b6:a03:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 11:20:40 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 11:20:39 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, pbonzini@redhat.com, berrange@redhat.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 4/5] qom/object.h: add missing documentation for
 object_class_* property functions
Date: Fri, 17 Jul 2026 12:19:11 +0100
Message-ID: <20260717112022.444367-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717112022.444367-1-mark.caveayland@nutanix.com>
References: <20260717112022.444367-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0214.namprd15.prod.outlook.com
 (2603:10b6:930:88::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 370d9b2d-6358-4840-ff1a-08dee3f56ea6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|921020|6133799003|56012099006|10067099003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: L8ybJGW2jVWjpxWT/uNumWnmmCN21L6huvtIzB0TzInl9/QTcrEefWKC4dennqE/HBa6o3YNfDwN2Ij9PRVdrf5+2Fj3Cj/qaQWc3THdAp5MWJIf/29v2NKYj1ZQ+HQ9g9nwpj485YDOs3vDGp297y49Y9mIiDBYZLrFyaKXn8D6f0AM/KVElA3dt5E/WWIMgv+GOxuX72hJ/x12aWMF+lpmLjE3G4IZogmoOpw8ic+lzpj/pi55jgFE3T06Nzkxzwrx+qHmSJb1G3XfClUGvHqbpDTBmlDhm0cKNtzvXs3PprXPArloCufcc/ztec6m+nShW7ijz7J40gRejVgTDpUeqMjsLh6gnEKGNBTNSuQjqa47flb7xHmB/zlmNi/Igwd0E6PAB9fi6NJXk0sCMu/fCLikB5ggMhmU7coeE3RWjknVZkugssHQ1Fkb7nRkFJ4wP91NOOF0w9Bo57MaPUsLfbP6KheVffsXCVUNSOu1TsVbmfmmIS8d2oRpPCGY38rKMQbqFeh/BinVdulOABD4/Mkn0auMzUQwIAL3BSK0qtf9ACBM6oCQzUIL3nv02J5GGjFqZOSNaqY1jZvX+GrpJfcaJyGqBrTcn5P5VHhnBpB1PYE8JHo97+g2rPscauD+8Nge1QxXbT+4m3xiLY9WdYeAWU8K6x/vCAgyyJjl2+OZv0HaXmo0+0LUobhHVjSpVb230TjG8WkoirII8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(921020)(6133799003)(56012099006)(10067099003)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VScRc2uE0deWipxGXALFHCKgWaf1UkZ/pb2abKdkYyGnZPu1Xgfd9YYV9UDm?=
 =?us-ascii?Q?ENa62P1LM+N9+WU3vZDCBCU9c9tvaJhj9hFHARAvlSGmh3DmiRzUXE7FTSuU?=
 =?us-ascii?Q?b5mes2fl4WW6t4LSbOGA8MkYxSMZXt5TSac56lAdvO4VQEFvU0WeEgOvVYa3?=
 =?us-ascii?Q?7PyCsTIXOzm0ipfM73zx/3i2MC673fZeslStCFIelyQmQOKEtXsuqyNy4nyP?=
 =?us-ascii?Q?YxncPzSVnaM63zOexvoLqhaSnEgB+E0tfgG0ZYPPgssTqzKW5Cut7UfzA5A8?=
 =?us-ascii?Q?RJ/t2otZkaSONgVjMSYWByVBUrOxtP8/4743vBDLUKoG/S0SW2MG260LFJnl?=
 =?us-ascii?Q?OzRKrj5JYhnWz4EX1qM2zEsVk74qkaoXnR0aBhbN+gj/KmxZ7wmnPe1y8yCc?=
 =?us-ascii?Q?hUA3aulRq5EwQ7bYPuQw7LMkNc5bepN+R4oiRFayn7QcgTJf9jvwf1iY821o?=
 =?us-ascii?Q?EYCtBIrPmXh5STMXXGz3f7rB0Vn25UeT3mSA4XeGg1kbKXncKwZ9/IgWLIma?=
 =?us-ascii?Q?+zAIIOjQlA2ZQuElJFLzUVDW7AD8usllnKcy3XcXrCxt0iJfTuYiUtfEEhwv?=
 =?us-ascii?Q?Mr9NEUZ7W9cozzdYB/jz2kYksnZ11a7hiZNYx5+Qep03ZRm/aFX/X06L87ZX?=
 =?us-ascii?Q?D9gDmwkOkayN/dvnT5pL8YJEqBHY1G/QPHmLNrkkRuHr0hUUSjuNJebqs5hi?=
 =?us-ascii?Q?r3dmEOtajWwif7eUJ4icJqTs+xJpc2TI27ybvssGo9MK2Jn+b3eCpF/E6LMc?=
 =?us-ascii?Q?nS5kaWYfFRkjQD9ldcxzZtWDLQN1SoAEv+tqJQsngv0U0PAfv1dSkq4ux3gO?=
 =?us-ascii?Q?/BUkf7lrZB6vs7pYeXKMD893AWgFFHbU+UZcBYcB57+9OcmjRrAOImSZuFku?=
 =?us-ascii?Q?F6H3//PKbXzlKAl2uDzvjNMrNiWPFmImVfIMKKc6xeEHsNORtnMBtBWwmp/U?=
 =?us-ascii?Q?wQeIrd0EWsSzI98t0CzX3f9GYhhZR5j/linAI3lvgXKQdvHj8a5sS8TeOjK8?=
 =?us-ascii?Q?exddXX2LlHxlOsUoxzOTBWvpZsfBZNAc+dYlM5maK9IFfNxyFlpl0U1L/0Pe?=
 =?us-ascii?Q?c6T+S8qF9HhaGywo+cb8t63GalFlJCa2D77LE070atZ4ED81DGDu4cxAWM/i?=
 =?us-ascii?Q?U8FRURzfCO1XE8pTqXxpZMf0wW6+zPR+4aAalRIW7qh2bMjNPrVa3LaI2OG+?=
 =?us-ascii?Q?4EMGF8ZPI+T83s84XRvRzcGPVIZqJWDjCk7UdIenrMNVoFWYuVxnHdA9GJlK?=
 =?us-ascii?Q?6texl0vsKRDz0OD8TOq9+3F3OmvWiifZ8Jy/FmoXpIyA32lKhEOxFoqAylCB?=
 =?us-ascii?Q?kBevjlTiceHtKqRozayc3hu9omVDpJB/GpOpxZt9epXjqNYmGNcyrpj6Ng1l?=
 =?us-ascii?Q?rTpZmgpX7WV09zgiaYXwiND24ihLHGrzJXSqnfVYpbh0UjyMvu2vHwpafJPZ?=
 =?us-ascii?Q?vC5RvV+00t86XMVx0xzQEkqu6/iCfcvaQIenQnGFx1sU8i4bblKnUCohwWzO?=
 =?us-ascii?Q?BGq3SIZZRnnPFGOCPoKfooZQvNpYU349b9tFbtEWkoQ2G7TPCUt8+V2k3Ptw?=
 =?us-ascii?Q?FcOgTSXolGMMNhmCqlhHAdZsWRt7CLu5rJBc9+VNG8eOaoP1KCW1K1Le3aNT?=
 =?us-ascii?Q?oxYGcF3zUg/sd0xHwiPjy4hHziTCcOMPwbVDJBnUXq39FbuNzU77p4aCS31z?=
 =?us-ascii?Q?DMIfQnweUgNoLjbK9ldjAQ7jKkedehfZOAL4Ea+Pb6ZYH238GhQlW87k30j5?=
 =?us-ascii?Q?MpbK4jRYzDpqVbkJgfB+BtrsdgKAufk=3D?=
X-Exchange-RoutingPolicyChecked: QV3kEi9kirrdQfVulkAphzE10rXS3hCc/ue1yYnZNiYAvzRQ/x1mW9TGqeeu+XjPd0fGLLwnOIAyOOb6mt0EH7c6vTOjHFDmr2yNOnXZz8UurNryGhInBA6wSe5o3N6H+T3RpEneX7RloSTkNIyuBt/SDGnquK2uHoZo1RoJ4bvrAQTjyU3xwKDCpISzcnA6YbMBLv5BiLzGLciM2ZdFkHEx7VzXlg/hgoj35p+wlp2t/qYrzXpwSAnLflN8dY75f+9OgBu2pr0GLkBLoM+tzK6GqKPCwaQOPotxW6ktUVwM16NOXLo0goZDaMbhvPw9unVsx763crlC3rR36IcSRw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370d9b2d-6358-4840-ff1a-08dee3f56ea6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 11:20:39.8682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WO7rjsdAnRt5l+xfAt5MPcJ3xBNrbn/OtfOCsZo6vHper8B6va6D7mgvqoNDVSaNGW3ckoGw+sA/oq4zQpCeujflKAwPc34PQSeHy90Y56s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7503
X-Proofpoint-ORIG-GUID: SQpNkn4FtJjo0MOcP-O823955krklnXf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDExNCBTYWx0ZWRfX470clsIir3tC
 ez8oWPqP6m7DESGII4geuS3PxElIXVnyAgx23HHF5e/tfMQ81rItUT0qt9J2/LzoNql4/2Asz+2
 n/zaJrsSZo0g/VY4k3RCD7wRTf6P/gSzHSpH6yAw1FZxIANH+CyddKbxQsl9b8wl26JSuNiV4Oq
 Nn3shq2rQG89zCCFhtIG4OGwnSnX2LNLGnHaR8vzsI2prIcL9CoXi165g0lWYIzxEmXtIfBvBCc
 9twi96PPC5HeBqeOvfH9CXIcVt/VedWEMZ311sMt2O0duZuf5H75RAdQz/qOP1bTbuKn7PefLog
 e4Jg56Uf9qQ3A5iblSUvaA2/KX+gTuZ8VNYGnjnveRUQ18mKrMgZOpaEPER5ZWOlcX4w26wo/DC
 PFBPVXFSOvo5pfMoVxT+zNKFm8gSnaSgj8zPysUD38oyH6DXJTwieai1XaFEKkA7IjH1mbfZ8NB
 kaZC74R0l7nlyzvQKnA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDExNCBTYWx0ZWRfX1biE8jJbX26d
 cGoaS8c0YuZn+ZUZpmbpWehOOLjKFIgRvpppH1EgQtz6bTV+SsjckodOB2ujhRjsdwkv4n5FE6k
 7QNoDGTH78m8InjhH1WlRhvfewuTigQ=
X-Proofpoint-GUID: SQpNkn4FtJjo0MOcP-O823955krklnXf
X-Authority-Analysis: v=2.4 cv=J8aaKgnS c=1 sm=1 tr=0 ts=6a5a1009 cx=c_pps
 a=G7MN2QGakcCL30ZscpFwFQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=lESd7L1ileNoS6jXIgYA:9 a=PazGKgE90xQOQ00f:21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

This is so that the object_class_* property functions appear in the generated
QOM documentation at devel/qom-api.html.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h | 140 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 11f55613fc..95fdf01e30 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1818,6 +1818,37 @@ ObjectProperty *object_property_add_link(Object *obj, const char *name,
                                             Object *val, Error **errp),
                               ObjectPropertyLinkFlags flags);
 
+/**
+ * object_class_property_add_link:
+ * @oc: the object class to add a property to
+ * @name: the name of the property
+ * @type: the qobj type of the link
+ * @offset: the offset from the object instance where the link object reference
+ *   is stored
+ * @check: callback to veto setting or NULL if the property is read-only
+ * @flags: additional options for the link
+ *
+ * Links establish relationships between objects.  Links are unidirectional
+ * although two links can be combined to form a bidirectional relationship
+ * between objects.
+ *
+ * Links form the graph in the object model.
+ *
+ * The @check() callback is invoked when object_property_set_link() is called
+ * and can raise an error to prevent the link being set. If @check is NULL, the
+ * property is read-only and cannot be set. Care must be taken to handle NULL
+ * values for @val.
+ *
+ * Ownership of the pointer that @child points to is transferred to the
+ * link property.  The reference count for *@child is
+ * managed by the property from after the function returns till the
+ * property is deleted with object_property_del().  If the
+ * @flags %OBJ_PROP_LINK_STRONG bit is set,
+ * the reference count is decremented when the property is deleted or
+ * modified.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_link(ObjectClass *oc,
                               const char *name,
                               const char *type, ptrdiff_t offset,
@@ -1859,6 +1890,19 @@ ObjectProperty *object_property_add_str(Object *obj, const char *name,
                              char *(*get)(Object *, Error **),
                              void (*set)(Object *, const char *, Error **));
 
+/**
+ * object_class_property_add_str:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @get: the getter or NULL if the property is write-only.  This function must
+ *   return a string to be freed by g_free().
+ * @set: the setter or NULL if the property is read-only
+ *
+ * Add a string property using getters/setters.  This function will add a
+ * property of type 'string'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_str(ObjectClass *klass,
                                    const char *name,
                                    char *(*get)(Object *, Error **),
@@ -1881,6 +1925,18 @@ ObjectProperty *object_property_add_bool(Object *obj, const char *name,
                               bool (*get)(Object *, Error **),
                               void (*set)(Object *, bool, Error **));
 
+/**
+ * object_class_property_add_bool:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @get: the getter or NULL if the property is write-only.
+ * @set: the setter or NULL if the property is read-only
+ *
+ * Add a bool property using getters/setters.  This function will add a
+ * property of type 'bool'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_bool(ObjectClass *klass,
                                     const char *name,
                                     bool (*get)(Object *, Error **),
@@ -1906,6 +1962,20 @@ ObjectProperty *object_property_add_enum(Object *obj, const char *name,
                               int (*get)(Object *, Error **),
                               void (*set)(Object *, int, Error **));
 
+/**
+ * object_class_property_add_enum:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @typename: the name of the enum data type
+ * @lookup: enum value namelookup table
+ * @get: the getter or %NULL if the property is write-only.
+ * @set: the setter or %NULL if the property is read-only
+ *
+ * Add an enum property using getters/setters.  This function will add a
+ * property of type '@typename'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
                                     const char *name,
                                     const char *typename,
@@ -1927,6 +1997,17 @@ ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
 ObjectProperty *object_property_add_tm(Object *obj, const char *name,
                             void (*get)(Object *, struct tm *, Error **));
 
+/**
+ * object_class_property_add_tm:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @get: the getter or NULL if the property is write-only.
+ *
+ * Add a read-only struct tm valued property using a getter function.
+ * This function will add a property of type 'struct tm'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_tm(ObjectClass *klass,
                             const char *name,
                             void (*get)(Object *, struct tm *, Error **));
@@ -1956,6 +2037,18 @@ ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
                                               const uint8_t *v,
                                               ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint8_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint8'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
                                          const char *name,
                                          const uint8_t *v,
@@ -1977,6 +2070,18 @@ ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
                                     const uint16_t *v,
                                     ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint16_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint16'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint16_t *v,
@@ -1998,6 +2103,18 @@ ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
                                     const uint32_t *v,
                                     ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint32_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint32'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint32_t *v,
@@ -2019,6 +2136,18 @@ ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
                                     const uint64_t *v,
                                     ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint64_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint64'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
 ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint64_t *v,
@@ -2075,6 +2204,17 @@ ObjectProperty *object_property_add_const_link(Object *obj, const char *name,
  */
 void object_property_set_description(Object *obj, const char *name,
                                      const char *description);
+
+/**
+ * object_class_property_set_description:
+ * @klass: the object class owning the property
+ * @name: the name of the property
+ * @description: the description of the property on the object
+ *
+ * Set an object property's description.
+ *
+ * Returns: %true on success, %false on failure.
+ */
 void object_class_property_set_description(ObjectClass *klass, const char *name,
                                            const char *description);
 
-- 
2.43.0


