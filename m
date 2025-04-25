Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191A6C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Hdn-00007d-0E; Fri, 25 Apr 2025 07:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8Hdj-0008VV-Vf
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:44 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8Hdh-0000R4-AS
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:43 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PB3tXZ013239;
 Fri, 25 Apr 2025 04:54:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=qmYFPPIn4zIPPz1OziAuDyUCxSGo6GXH3u8hjZ9Wc
 lU=; b=c6sItbQBUxFeMQoDp0jKAbvBkSzNXn5816F90L5eqUjaLMMxQrcGeFJAI
 g5nS7gTi1ZAzbuAWg9r88J5Zk8xpkhsfCtqpYwt3n96eXnpxO16D/qHCggZWPmXM
 GLevFnH5I388/0TGQMn8oO1rEiYPy0TQhAsOc3T/ajbzkNwYAyDsCPKIHGlNalen
 mk7ZbmnOAugilvoTWxJIe9xRi0xVV3B/oezJiy8s2yvbhEEqUqDlXHsHWMVoFDsk
 w1j3Vw+0hVrYGetT7Cr7U70mR/KhKO2vgX2QvyWqIuFAnnr6AuOAqXcfWwNKK0ez
 O97QehG4UwcVL6WGKNfc2UXWuPVVg==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17012037.outbound.protection.outlook.com [40.93.6.37])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 467ww21b9h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 04:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEozzAPRENvQ2qNeMpd3ucL1qiEtRZA8YBtgDek/xwfAesiEsc612xSzHvK/LF9K9qxqCIj/DE3Aq3BuyucfqWITMwDHLtzloXochr3UeK8FwLpoXFN/JWWGiy0vJv0I4dCLmItyLUETwTvgphWBFBoGAAxQpPjCCLdMcA2/HW7Qd60Ie2al1gBTwQrQaNxxVQDVZMPEFzNHe3GoAEepoXaaOlv3AI1/jYBpupdo9FRzWI6WJnNRlVzZ07ipZ3GdRKihSgWexmG92bXV/46Q7Hts2fwh/MfrL5ZDg6QshMHbp6DvkYHwsx/j8dWkAu3tFc58TpeZL7DsLWAXHaQkSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmYFPPIn4zIPPz1OziAuDyUCxSGo6GXH3u8hjZ9WclU=;
 b=plk+/ffzQFvf8ZdPmF5LO7/kxXrzplhv8o1V1AIdHeGFZTuOv0r5Qllxq2f9Q0YMjUUS8RI1NI2Mmnw2qrQI+KTFtANUPRvORaUe8n+FXXnqOypScAcLV3X9ZIRyJmkqXmH4LQVA+OpOyNi9avbG7Ln65K4sUB60JaiAPioHywIhMxhvs56DCG++2FUt2yR3II4/5xQmK273CGoi2r4K1fFjz9TKOZOkQe4TC9lxvhGbpDKZNxIfj3/AMz/Sjyn3RuGgqI1K/A7m+/Eu0aKaHVIuoOrE274kNjcm2hGQSG2mhfz/S28c/5hBBvRiA2WeJKjzf+FdW6sBQWznCtwlCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmYFPPIn4zIPPz1OziAuDyUCxSGo6GXH3u8hjZ9WclU=;
 b=hqMJfuML0M7X6g/fwWlONVqg20MHS1VCT3Z3c5vZlDX9VNrTyXpDPYeDbRYZtvQQjrNfBhUTiybCpTdrMqfpccC+yOkex8f0QIyq+Y65Ds5aZMfhAUtVKy8IMUulqaFO17uy6RvsUcVJqgIkEa0sol5OHyHvfr69N9pqZRkdqCK/93F9i2ZaFH0Jck/PjRJmGql+b/mvWI2kU3pnWFtebYJjEAonhHDx5LKTeJC4yEHi4Rxm1lbRzJfMiO5R6JNF4EZQgnAFtINKd+/YMgOr5BBqDlqWXMph2153M97i1gGUwLpjgnSeCmy9T98Z3mehDLuLizG20Pmo+4b8VefEIw==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 BY1PR02MB10337.namprd02.prod.outlook.com (2603:10b6:a03:5ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.10; Fri, 25 Apr
 2025 11:54:38 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Fri, 25 Apr 2025
 11:54:38 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 11/12] hw/i386/pc_piix.c: hardcode pcms->pci_bus to NULL in
 pc_init_isa()
Date: Fri, 25 Apr 2025 12:37:58 +0100
Message-ID: <20250425115401.59417-12-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425115401.59417-1-mark.caveayland@nutanix.com>
References: <20250425115401.59417-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0023.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::28) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|BY1PR02MB10337:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f97338-02fd-4ba5-8f7a-08dd83eff47c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PkF83yoPkpzcGVw44whj4Im5Il37eYeltUOZKlae6caTsWE/p8hL3yFzch1P?=
 =?us-ascii?Q?Y1sednri2jdgKgLEpZNKBYOGJ9fmB9ZjEwH91kiSMNm6TcT/Fg7xuG0eU4Hu?=
 =?us-ascii?Q?CdF8xyGQcE6Kzd15TS3cma8mBcHLt8WjTJNOKo9iX7vYQMR3mXZtywHt9MXt?=
 =?us-ascii?Q?nM6pXKPSBagcWplap/A1DWwH9eG1diJelq3CQybbtIDFQSdlRtUieTaZ+4tu?=
 =?us-ascii?Q?WA0BxBKYPmn55DhbuNEmyPdFOnF0LqLs+TiypQz8k2jEq+t/h4S0JeFn6YDt?=
 =?us-ascii?Q?wZUuo4Xg/q3rBWWWuKFeN2yIueGKACfcub7ClGfEFfRAp5ChV+i0aSmsHEIq?=
 =?us-ascii?Q?Juxpo3bBVOL4VfDANoFAljagxI/hJ1mHuhHgbzx0tPlZOY5w3QDJ6/iYlc4x?=
 =?us-ascii?Q?ckJnTNsIgHU2nZ/EKlBT8sgeQM/1lXtSUnZwRpkfrU10RWg9WnBnc5QaKMlj?=
 =?us-ascii?Q?wvFF8+Qr2yGfsDhflY2fHjNQKgabhB/W9WbngVs3v1gJIxTfo9fiquThONRn?=
 =?us-ascii?Q?ccYf519arytv3iNBhdRlCgBoBuMugck0R9lYcQYe4CcXqAPmfqDWxxTT44Pp?=
 =?us-ascii?Q?2deq9MC/F/qXp5rlkbp51biiDSaUudDZ5trtGEFxz0D5yJEp720aj0Qafhm7?=
 =?us-ascii?Q?dtLoNgI8COt3zS+qGk402JQLq34KCZPfHcQVGR8HcUSz6Yf20UeCfr+K4yxj?=
 =?us-ascii?Q?puAFAWX3dykkRlil2aNNLoMPiR/zcUBKEiEav2cEHk+Kp0FvP3P3zQpM+bb9?=
 =?us-ascii?Q?vmn9anQfTwZpsc24FO9XlQ2b/9QREfCzFYvy2uoRL2QL3T1YU6TK23LqWgEl?=
 =?us-ascii?Q?SJnUV9aTJPwi6r5wZDnlNvEPzmmJY40+yeghZ965p2KK3CvbpB35CtIh5SvH?=
 =?us-ascii?Q?9U/H6jR3fzHkvYWMSlIqcFEcE4l0HhtlhKtD0pGVXqIe97qHoqVUjYkveO99?=
 =?us-ascii?Q?+dro7kWgPFXv6/X9vEXITkYp7rcaNLm/3PkyXH1+fQGCg44hNn4r2mRZjxFG?=
 =?us-ascii?Q?IOi4QObiq/2yFSMKhtjIZJrChh8j5+/xHp7JmbFNbhXPesZfHHevhkNR4/9f?=
 =?us-ascii?Q?HhMc4EAP3R9KOKk3Cie9MEbkeYDadIvXe0BH+3ld66/suq5AuXe69SvWTa11?=
 =?us-ascii?Q?OhXX5u40HtGD/FyvuPMX+d9MRoitJji7LiTan+4vfDX3AajmtAnKJsMTopf8?=
 =?us-ascii?Q?en4vUzY8OTdy1x2cxOtNj5acnFnNQTDXHQCF7rJDX7qxAgLCsK9ppdtC99RH?=
 =?us-ascii?Q?5Hqvb1Yzp3dDQOW2yFuRl5mdBEoGhcr6Tq/e3HQ22FTB51vhUZZlwiAhFEdA?=
 =?us-ascii?Q?L0G+afRS7pY5eqQI+ErqexoskCNDV9NhCmjWUwcIdaPrW2vkiXYif1ppGA3Y?=
 =?us-ascii?Q?sn5Kg5LorHJQXgrFnNqYxPE8kHBCcNKlfsFqGYnZsJwFNlqOx7env4PI/tOB?=
 =?us-ascii?Q?jkb7lbTQqF0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ZcW6Pq+87qRZi2XiWrwybhS1GwwyPZlSjafySnKvabvM+/W1noQd1NHed4+?=
 =?us-ascii?Q?DF0odmkIMfeF7/MkoB23AmfyPI9QxH5I0w5ZLwPbXP/ytyWSg3nOpuXzNztM?=
 =?us-ascii?Q?z/KjrToxYD+/ex8pj3ayz7ZXKYmjDKW7z+Tzxoc4xnnmANqs8tkqMUIkDP5O?=
 =?us-ascii?Q?qg+5U34HGeGuiCBIRVOufLrAH7g+ucuKfIf4Y81lfnnRla5X69BlUB8d6rir?=
 =?us-ascii?Q?TxSZqdJRL3nQ5XJ4cE6U5E2OlqQmnBEzkj4gXpDw7U06F3XeiOCyTGzKbs8X?=
 =?us-ascii?Q?oW4mmTCotVBAc2bkti+PTzIWSWfm92DLLAcgfuxl5McGlxXzFiRB8h6hMHM3?=
 =?us-ascii?Q?qY/lQju1MZb5fmG9VXvKevMvv1Yl5aFma7YKNwFcgy5NI2EidJuxe9OpeHpj?=
 =?us-ascii?Q?pIQU4mldIw4LrDd6R9oiNVY+zQBkI8TUZyg6OmdlYxcRv8iYveQP43lItteR?=
 =?us-ascii?Q?fZPwtmjwgj4jx1V3PJvMOcwwX8Q/1d96roGLzcfZeJqMcSyK7A/JELnOYbDW?=
 =?us-ascii?Q?Iq595NdekxuoPLokkQ2YPnhk+DP9upnvfEL4HA+iUerBCO7o9YfgdXOS8kq5?=
 =?us-ascii?Q?L4urtBAebX0w503+Cf1rG56qR9YCEfo49OOCx9EqIHrTW79HqQ4mS6IKSWOb?=
 =?us-ascii?Q?Q7CYwfnaZ/accGZmQibc6s340CdXueHQCkge4Vdtx/6hLk/nxZ5FJIP/o+qM?=
 =?us-ascii?Q?jER/8Qf+kF4QrLrRnpbAYAuqJZC3cCW7Z01r5n46nHsTHL/6IDEm7OAktJ4E?=
 =?us-ascii?Q?+nn9nMIeqZTK/4w+35dxrljxzr5Pksap+wN0TGgDwkzF1YyX0/fx3jgb7B7F?=
 =?us-ascii?Q?dY2niSC0A6b2AAO1C4REx2O+regcYszDZN1/fu6a4cvKKb5samvf5EmKOnY0?=
 =?us-ascii?Q?hXHMZpHd3VFMLufF8Mxg9Xl0W+AbhcxAA031t6eYvbEWgLlS4s5GMICUon5E?=
 =?us-ascii?Q?ydEXKJSSpcuf5J/f4zydLeefLq10BplUKKWCe9HUqoqbmd9xNF1EtFnGpESC?=
 =?us-ascii?Q?yCOw8nai2UdixIS2A02ZPQcVELLx+irIrRBQx5F/m6iCY4qBY2+aTGufS53H?=
 =?us-ascii?Q?r44pIxWuqdgEesghRY4EN43Kg+7jK3G1IKJpwYWEIt9dpNODSBubtfBRMSAM?=
 =?us-ascii?Q?PpCIfQSARQ2RAerigjAPsvdkUNTAXGl+/G1lizgNCu2YOAw6WHhWDyWvxnLf?=
 =?us-ascii?Q?T/d2GAQNgr9i+jQEvIdebEoLx8c0Qyt5cF85io0wU6Wnt5y9t0tYFwQmedPZ?=
 =?us-ascii?Q?UaxNKExx4wFmoQIuSGBuDX0Ok5QptB1DbF29nckkTIYu/CJXrEuFvYfttrXF?=
 =?us-ascii?Q?2E2CfLYn1p89qqs/fejLetJq1lJEft8DIBeuI+oN77u7tVpEHa7Ukn/plqrX?=
 =?us-ascii?Q?XP4P0/dVliyaWJAMJXe3J81is/uz5MsXhdA8W+b8hthFNQbGdgs29UB3ULiO?=
 =?us-ascii?Q?H77ZjzAM3SAlyk7nfhPKxt7PUGzW+NAm8XRwbO1y3IoXJVdglekE+SSwO4PU?=
 =?us-ascii?Q?A0xBqWi5P5QaAnZ4X7cw8ZCEuARZ3XOxQWCQn0x9QJ30GsxAcoSU2itYsyB+?=
 =?us-ascii?Q?j0LpgWuiIi9//5BUpNbQ8jXExZoWF5+Un+R+Nz7bucMSp8OwZ0L6EOygWPFd?=
 =?us-ascii?Q?f8/OFPIMxVq8R8wA22NB3+JQMoZvJJONBJtA/6+NPHDFIBXOW98Z/Rx4z/Fj?=
 =?us-ascii?Q?ykcWEw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f97338-02fd-4ba5-8f7a-08dd83eff47c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 11:54:37.9785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/FUPMlS+7NM47ZBt9D4wCoyPFY10r3JRbl+3JsCosdaaIUmzQAk24aPiHY+O5n958zwXU4v2jVn/JqrTUMyc4YtMfRSeYVk6Dq3WrLxrSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10337
X-Authority-Analysis: v=2.4 cv=BevY0qt2 c=1 sm=1 tr=0 ts=680b77ff cx=c_pps
 a=dnQYvCYIB+Ymp8NUOuD+qQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=t_IIakVZT3XxnDp3cAMA:9
X-Proofpoint-GUID: CeDmZAVuolx0gKNFsNw52tJL-Fc-pzKD
X-Proofpoint-ORIG-GUID: CeDmZAVuolx0gKNFsNw52tJL-Fc-pzKD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4NiBTYWx0ZWRfX7D597ezv2DVr
 qc+se3BYZsKZJcVKz2QNmw8AzNpK6r2o5jvW5jiP4sobrOaXnJgcQExd1NDKuX99+RTbTtAM5og
 LnfwL0fi7MhL9RNactwLaOKIZbivg3zM8PguwuJzxJDIRRkIycXQZVUm7TU5+11nRqXhN2Wy+6W
 vA2tt5WLN3GkxlwiYrKrZW5non8jbXtdp3ajyO08rtNSM6rcxg4pWl0yskrGf2SrWCdCuhygZC1
 xJO57yOBPN3Ktjhnf6XFRfpPpej07+bT3uEIi6Pg/IeHd2W5QdjJvX7EiTI4SZ2G1kDeBh9Ew9R
 ynMl3GywNWxfiNFK12cVVB+nU75i+1gVcDFVvO76v/A9553yVbpwCQE5kU3FylR5kYaCrGKxBGJ
 QvkW4aL5naRLMiS/ksPy4clrt7qzaqfkSENBHnHLjdnDQRCNcCdbmjm+hX0XC7MMMLa/9DgY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

By definition PCI can never be enabled on an isapc machine so hardcode the PCIBus argument
of pc_nic_init() to NULL.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c12e5423d1..d165cc9427 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -484,7 +484,7 @@ static void pc_init_isa(MachineState *machine)
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
                          !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
 
-    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
+    pc_nic_init(pcmc, isa_bus, NULL);
 
     ide_drive_get(hd, ARRAY_SIZE(hd));
     for (i = 0; i < MAX_IDE_BUS; i++) {
-- 
2.43.0


