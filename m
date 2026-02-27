Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656FEFEFB4D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 13:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvyB7-0000sE-MA; Fri, 27 Feb 2026 08:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vvyAz-0000rM-5b
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:46:41 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vvyAw-0004LC-TI
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:46:40 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RAsTrP449134; Fri, 27 Feb 2026 05:46:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=pCDLdkJCaODOFIBYzq/KK/SHviwnV690wVn7J4fqB
 pI=; b=wAPAv/5vXspK/s3TmuzQzXaSfEriwfaHjQyFqDQRDLyzPM5G66NZdDFQW
 PpOSsIpmxE+jccCdC5dUvVeiMEL57JhdLWaZ4AuLeq8P2PGHX3bipjV8VLJ1dGCQ
 C4vxWbSYSsTvFnAtm/kH2yujRiwRDf9UTibRMJkfTRgF5OC1aubMAST0wyE+6i1R
 DXBcBIpHaar6HOZlDA+SH4gShsAfUIxPyoX55MH2RE+rVijM7FHslTrSOpD4qtfu
 rnzrsDAXVEhUDlcqnhJm3oBoZKFs/VGEA5ljZANI1ff/RrLT1aGC1VutfQQCIVdF
 e8G/yszCcjM/nWqRGZkzzbvJRkuRw==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022099.outbound.protection.outlook.com [52.101.43.99])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ck0d4hgc7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 27 Feb 2026 05:46:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtZ98SCyX9M5MAdOZvXzQHHgb3+LapCB9AD5ikRGhUEdmgeMVQS292YLpM9ZVYYtogFMnYEikSFKjREa4a9WMHe89zbdjRscXBofMrZSGMkk9FmMWVVhsE/PE4QKwc8I0cZK5wC43b0Qx+Ht0L5QmTDWBHkK/rNgoaX1hyrwYetwF9MurGDJFGD7+fuozvxz1v+y+4tcHthMYKRV/CpJJSklIYLOsHUg2TyJV/0Wmh0PccZOHbrD0c6xzljAEKp7f8tkBZQbvtRrDLCC2YB917N54lK8pTymIlhvWe7/CpQW/FvWLoHHZxrI6XMYr5Nb4hJfoOi4ohT63caWwluVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCDLdkJCaODOFIBYzq/KK/SHviwnV690wVn7J4fqBpI=;
 b=tVq62bwux6v3sGdS5E9jvvNcG7jyOIZrOiVLAy8DnbBXbW8eqzG1WR82QKNY75fT65V8B6Ha/yMZOJniMndsSlMylpphgmnwYhXRDNAXGN3WBNyBuQgicQrKZwML9TB8uPH2sVKpKey2iMfjJmx6pO/jYzOYnnobZwE7QPVsJfDcidO/Evi9tmVJq7U9oXuj2KAsakqVgIh+QpOKQclUdlL50pGBDyqRnfMy2ItIvyJ/t5tFtEay5Dw/Kr69Zv07WDRYx+TFEOtCKeWTjgenGT9xo+VRbgiL1Eq6CZGgY6KIwx8XceYvsYqaywJHd561OiNNOnP/0ymieQqnXg4wcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCDLdkJCaODOFIBYzq/KK/SHviwnV690wVn7J4fqBpI=;
 b=s6VCFOLgiK2CPIMrXC8/ZHQFd09qrBMVwPxywLTRAaUxJUSHA+CLkneTznMLFSv6m5hHe/U7HfG2WqBBMjaJwFtmmOuf8/mKEtELQAy3dLxCqLtgmMJ0S+WoX6A9WIrxnkrr2fehw7HIyfEOYQW2cIxkCy9wGBnLv10qxfXtClHg8dAHopYp40B1tZqcN8UiOgtK2XufuU0PttsKJ/vNeruc0UJsfJK2AMOGVtWRZ7duYyfY0ci9LgE6SsrH57IC2BBVlKoweyWJt2wCwK7/gGbyONEJT76KifzvJNMK7BFumdKxQ7BlVQ6O+C4nKMm2L2wQAcSU+lMnPx6XxPgdDw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV2PR02MB11277.namprd02.prod.outlook.com (2603:10b6:408:354::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 13:46:34 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.20.9654.015; Fri, 27 Feb 2026
 13:46:34 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Subject: [PATCH 4/5] hw/char/serial-isa.c: declare IRQ as shared in ACPI IRQ
 descriptor
Date: Fri, 27 Feb 2026 13:44:58 +0000
Message-ID: <20260227134611.1229390-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227134611.1229390-1-mark.caveayland@nutanix.com>
References: <20260227134611.1229390-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:610:cc::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV2PR02MB11277:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f9bf3f-2974-4f17-dd6b-08de76069ef9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: /4sKE/jdS8/kTe4oAflvLcEonTgyAQW7wU0Yec1VIZz8Qxqjx29i3l0zIlnACHIGTY/+i90TdNGloCCSJX41K2Zif24hp4XyLcVXJlrxHz8oO2wAGeWUTcD4Mxse6UxbmEBUvfvFrPCNbQ/mp6a8ebHeWMFyNqlmAA0NlOjgFdbKk/eeyNTh3jVIBBn9qP/Zqkf/D3Evrya5vTo5XGBtDzPyU8yx+lxKjgUPTlEyoU3pI41ANXzLS8O0bkflRpwPP/btvj8KfJichu1VabS71Kqnuk2DFZcUSL0oRODFO40N6S9B9yKnc4s6NKk+seiKSGhsZJemGLTiQpgRIcUtGyNX8qypa4vbpnb2wTl3eLcGBK63/RsI3cOgSK/Nu7wOf19gzPWSZ7Mn/LVDz5qhkUku++VgrgRmZthJd4GWFomZ1cZdH+kbp5xpj1J0IFFzj98WNa8bIzItZLc10TeAcZOZx0VzkHUSspVE4C/KQQIFjX5qPaORFaboT4Bccx+i02I8qa9BP0rtgb+PWgtkgFUeNEE3TqZtIsYwUyXRVTGwKYz+enNsYfjo2vOCrHI9A4Gg0fHIfCWxuj8uw1pGwjKTq+OL08QyJyqsKHzCxVzwH30Fak2CekA/BhzF/19eGbcp2eXrIHzgqUc1xicSPfVRrtqRTp8llgLCI0AS/zu1LtQqsKIoKyqVsDKeRpRXLtQbFl/VgPMxLMCOLVSWDngkXqbsgB1pj1z6msZIAmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ij1bMH4KRXVMEh5lAKTzYTXww5Xf2/L9xbVdOc1k5EGZSc119vrrIgUyWIx+?=
 =?us-ascii?Q?9rIGfig9P+2IMMLhk7oZZX1BGuGEFe5wM4tLWASmjAA7YWtmfNH35WtKbfGn?=
 =?us-ascii?Q?shMgEBP/1QFoA4bBrbQjAiisMXy4HHWxPZUAHmD1BghgLlCM8ddNwdGUgZ9x?=
 =?us-ascii?Q?7n3SDu9TsMXPU8f1G7y4PtsB6RtW2t9s2TA7kVnAhpX79O/4P9RfqNieQ4Ed?=
 =?us-ascii?Q?LNnABi04ptuEGy/nGShLwnjMx2/0DY8UoCfDhRWIGPWrZE+AOPM8IEGF96ei?=
 =?us-ascii?Q?RB6+3ZnGOK8kKzarmh+1XHVw+RkDxd3VSpXM/Z4I8s3Zsb7TYccBQ2oubx/6?=
 =?us-ascii?Q?vNcpSvaQDS5MGPLbxMsyJxPZAOPNag5aiibUKiFGbeU0kFxGUWUhQT0fagyt?=
 =?us-ascii?Q?vcvuTKqHyR80uhoC3kTcXfSvLIkJJ2hmudsvP2p1jZsB1paCqg8yG40LtlfX?=
 =?us-ascii?Q?dBTUgErBgYKZ7e8jUKXs3VscaQI0iTkKjoFOnQBV7t42oBBoLuOefQLTG8Ew?=
 =?us-ascii?Q?MmLAIY+zeXzjuUcuqJEieieiD+Q88hTpZoN4tJUxqf2z2dzoz36Re+KU1sRz?=
 =?us-ascii?Q?1rAptpJXZFQ2ZvNSR3Qef88oQyQlEQlz2L488efAzz6h2ag9gHRtfMGvICXt?=
 =?us-ascii?Q?e32k0j+inQMLsvlTaBkMjYAIKAt9r81icB8VAYeAg1xbd2eu/vJEHUGt9ZHY?=
 =?us-ascii?Q?3ErLmQyANNaTYXavaoBRsP2XadqOerujaGj8OvcRMRn3Gf6H+2xfpwXcN51Q?=
 =?us-ascii?Q?Qyevnb0re2cdhMQt7GuK3G5J5Pj7PsE7SjMg0VNLw3OD2ZuETAhCJdty95EE?=
 =?us-ascii?Q?GlHZdBPNqwA0WuQnMlbNmbH4NafneHm8uSavDc9nLZW3n/qQJI4CGVtfqKq9?=
 =?us-ascii?Q?u9yCR7HnyfJrhMY60yE2OgW+rREvVE7rlKB+11OWRBX4djQsmPz2IaDQmfrb?=
 =?us-ascii?Q?jssZA3BWatCGfAwx6Y1CBotN/HTbkdUtA1VESlZ2zC7jjKUiTJqGpCH4M8FD?=
 =?us-ascii?Q?eJv2katj/o6dyCqc8muApUBancG2l02ntM2qiyCoV7j0cf2fuJA+3Th75a9f?=
 =?us-ascii?Q?V7vF02QYssPIUXkid/ugSxRSEazmvZ/G7DimUXtFuPpyKo/24KgUaIxTwGzR?=
 =?us-ascii?Q?o7dFC+bs24/SwWz/KOlqd3z5XgHF043axtskKztnnkh6feURD0BmmR3fO9eV?=
 =?us-ascii?Q?U0mK4J5aHm+aIYe9CdHvqpDprREbIHqXqiz9sfVEAe+RM9OzCKEDrgqNLO7/?=
 =?us-ascii?Q?8CqqC3BKsxji0dinXEkfEzN6X8G432OwQNP7pO5oKWnllEDuq+04MvUMaay+?=
 =?us-ascii?Q?6TvRqPTOg2kzJaCjGEVPgos6Vzw+9GfQsrpntLaip6/XvgyEAA6xZcrVY5W3?=
 =?us-ascii?Q?Hi0woN5FNP/Keq6FLJ5lcPwioF76lQmhbu0d2yMfPHNzUfVX59AwIsRaQIfK?=
 =?us-ascii?Q?hIfU2Euh4avfnRJPanI2+8itqK66a2K1kBVAy69JGnkmDUwALjodkcaiUncQ?=
 =?us-ascii?Q?nltqyvFxYJ8Yr9kcN8Rblqs6RRANG1Om7KZFYSSiFSu733tz7Y9ivX1uCpnc?=
 =?us-ascii?Q?YpqzSMWsBAIYnhHBZlAZwsnRkQfGIflzS1NBHCUWc5y4SCql0VQe5xZnvDPt?=
 =?us-ascii?Q?1i+r+z5JhFO+OxGzsFwU7kMrXH4LWQHOQDD+QTkHl4Q5mYaMsC7ZF+EUQRdj?=
 =?us-ascii?Q?VSVKkgl05DkVcsKsVSNnZ5HCQ1s41FNqdOxwQ4ibbRH0qlt0jcZ3rBr2ojcS?=
 =?us-ascii?Q?/Y+ubXPdzBc3DmpufjcYK6Z5jKkqZ18=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f9bf3f-2974-4f17-dd6b-08de76069ef9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 13:46:34.4694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5byGv4bZWiuThe56x42jmnlbxOyNmlSIcq0gv0z0/vzJVZI+Mhsc0oI+AqFjMZ+95rxlwrwnbmDcak8tcIdpSd8wBGfDNw+kfjyO+Fuj2wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR02MB11277
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyMiBTYWx0ZWRfX18/HG1RmuP/Y
 2X+zF5j0oMGfNiJkNb095ttE3/n94gdwRAlI3KWS+jx7/JUyOhtEpCu6p6rw4PwaGMoFEmuDr4o
 WxqdwYZnIAF2Y5Fzu6O8fxPDn8bDY5tiNei2zq4qLoMT3hGDWuN0uiSXWEVrM8v2ggiQsl686uC
 vTle8mAEhQE4sOfsyKyJ9pDR5fRaBuvKV7HfDeoPvdITkgEwlNvA9g/8294b997/id9yW6+gMcz
 JVoDlAckJ/AKWUmRo5GQFHUWwHs8x4tiigA9riNZmVx3CPbitZtrTkS5LbwnBZXWDqfpejDNlsX
 DbXsuqYJWDEi29O2kHkjPEOKcWF5Au0fDWe2+5p4f3J73Gib+Z3QhYggZpBnRo6xpwCwKDK3l1T
 HCLFe6I0GtBf2wsLSd/ZyLvUl39X1M9ZAl4wBNZHwsnj76mJoTSr7KRUij4Nab3Fkq04dYd/VuO
 /4q1z7zp+TcJ4TAgwqw==
X-Proofpoint-GUID: UbbfsyR1zpar17M8NyXlVElgYsLR7HUj
X-Proofpoint-ORIG-GUID: UbbfsyR1zpar17M8NyXlVElgYsLR7HUj
X-Authority-Analysis: v=2.4 cv=TPBIilla c=1 sm=1 tr=0 ts=69a1a03b cx=c_pps
 a=MyZQQtGQDv4zT9mHdzB88A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=3F4rMqWeykrhfE5CpqgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From Windows 8.1 onwards ISA serial IRQs cannot be shared when ACPI Revision
5.0 is used in the FACP table. The reason for this is that if a 2-byte IRQ
Descriptor is used then the interrupt is considered to be high true, edge
sensitive, non-shareable. Since legacy serial ports COM1/3 and COM2/4 share
an IRQ then if more than 2 serial ports are added, Windows indicates a
conflict in Device Manager and these combinations cannot be used together.

Add a new 3-byte IRQ Descriptor to the _CRS resource indicating that the
ISA serial IRQ is low true, edge sensitive and shareable, along with a
corresponding _PRS resource so that the legacy serial ports also appear
at a fixed address. This enables all 4 legacy serial ports to be used in
Windows without conflict.

Finally add a new x-acpi-shared-irq property to disable the ACPI IRQ descriptor
changes for older PC machine types, and add it to the pc_compat_10_2[] array.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/char/serial-isa.c | 23 ++++++++++++++++++++++-
 hw/i386/pc.c         |  4 +++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index a4be0492c5..1662da86bd 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -28,6 +28,7 @@
 #include "qemu/module.h"
 #include "system/system.h"
 #include "hw/acpi/acpi_aml_interface.h"
+#include "hw/acpi/aml-build.h"
 #include "hw/char/serial.h"
 #include "hw/char/serial-isa.h"
 #include "hw/isa/isa.h"
@@ -43,6 +44,7 @@ struct ISASerialState {
     uint32_t index;
     uint32_t iobase;
     uint32_t isairq;
+    bool acpi_shared_irq;
     SerialState state;
 };
 
@@ -92,7 +94,12 @@ static void serial_isa_build_aml(AcpiDevAmlIf *adev, Aml *scope)
 
     crs = aml_resource_template();
     aml_append(crs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x00, 0x08));
-    aml_append(crs, aml_irq_no_flags(isa->isairq));
+    if (isa->acpi_shared_irq) {
+        aml_append(crs, aml_irq(isa->isairq, AML_EDGE, AML_ACTIVE_LOW,
+                                AML_SHARED));
+    } else {
+        aml_append(crs, aml_irq_no_flags(isa->isairq));
+    }
 
     dev = aml_device("COM%d", isa->index + 1);
     aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
@@ -100,6 +107,18 @@ static void serial_isa_build_aml(AcpiDevAmlIf *adev, Aml *scope)
     aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
     aml_append(dev, aml_name_decl("_CRS", crs));
 
+    if (isa->acpi_shared_irq) {
+        Aml *prs = aml_resource_template();
+
+        aml_append(prs, aml_start_dependent_function(0, 0));
+        aml_append(prs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x00,
+                               0x08));
+        aml_append(prs, aml_irq(isa->isairq, AML_EDGE, AML_ACTIVE_LOW,
+                                AML_SHARED));
+        aml_append(prs, aml_end_dependent_function());
+        aml_append(dev, aml_name_decl("_PRS", prs));
+    }
+
     aml_append(scope, dev);
 }
 
@@ -117,6 +136,8 @@ static const Property serial_isa_properties[] = {
     DEFINE_PROP_UINT32("index",  ISASerialState, index,   -1),
     DEFINE_PROP_UINT32("iobase",  ISASerialState, iobase,  -1),
     DEFINE_PROP_UINT32("irq",    ISASerialState, isairq,  -1),
+    DEFINE_PROP_BOOL("x-acpi-shared-irq", ISASerialState, acpi_shared_irq,
+                     true),
 };
 
 static void serial_isa_class_initfn(ObjectClass *klass, const void *data)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0dd3fd01d9..c0335b05ba 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -82,7 +82,9 @@
     { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
-GlobalProperty pc_compat_10_2[] = {};
+GlobalProperty pc_compat_10_2[] = {
+    { "isa-serial", "x-acpi-shared-irq", "false" },
+};
 const size_t pc_compat_10_2_len = G_N_ELEMENTS(pc_compat_10_2);
 
 GlobalProperty pc_compat_10_1[] = {
-- 
2.43.0


