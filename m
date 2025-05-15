Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF6EC54754
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFanO-0001A3-W1; Thu, 15 May 2025 11:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFald-0006Of-RV
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:14 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalY-0006Ek-Sg
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:05 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FB1Jpn007532;
 Thu, 15 May 2025 08:44:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=sNYeMkVPQ7+KeXT3OFKdXlqJPFksZ7JtNuqb9aT3d
 40=; b=IZr35fhZdFPCoaRiZF6g+E04YOyqDnz+lbTwIXvivJSoNAFhFXOqynGtg
 1wkRmjxc/K+FkigADgdOMWZ2q+JhmVRV8LpMAKPSKnMX9/nOM8omkL1oSvaxk3lY
 lpYeDx3bMAZ3K8chU7Dx9LBll5pgZ3zKfkZAxQE2W0XN0IA/DW4QvOwP5RgxgMXU
 cdPT7D1nbCfSBMkb0BwOKsfmXX9icu+MMEPecQ7BG82gFfnjcgRCaGVXembKLsY/
 CY0aKaJOe9NMOcAdTSxd2bWsZQULIKWYY+O3uapBgm10ibSZNe/Cy8h5kK578k38
 Jo5RGlbj8W2K10n7ekSEo/Mfu3+ug==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazlp17012011.outbound.protection.outlook.com
 [40.93.14.11])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46mbcwwdya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJ3BciNjhTDRhj1eSqQbXToHIZbgXAs8UQwDPt21Lc6GEUx3N+BaHzHzYfoZrCgcarZ+WigqcfchErerO+pEWjyUFgQChvGL+6mJV+lGt/DvN9X25qdU17vSctBjV6fVMVua0zUDQX1LyVUJFR0nq40w0h/F3mk9Vo8Z2UmxyH0nCmXw21XAgw4wG2rJUBBAC1mSoNQzMKIR3tGFACK0xA82Jsog0CxO7P4dJL3Mn44YgdQC46NCiASTcZuijBUq2QbyoEXKJzut+jBsjVyOwCgtj8SaJCCXJfKNMw1PQwWow443l+lNL4h5e9WFCTgbs6h+yVj3eycSSLul6Ej6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNYeMkVPQ7+KeXT3OFKdXlqJPFksZ7JtNuqb9aT3d40=;
 b=Sp3Xd/HLxCfkIx5Y0EBtX17W9ogIfQi4RV+v/Qide8p8/aDFx78VSGdC3c+WcARyinrJO/xjA3JSbEQmG0vNuNjpfzLwYidv7FVyIKp/71XgjFOYp9ZPIqm/pei32woo+6sbQiig8j1jK2HDOeSrk8pL9JoZYjZiSI/r7M+ttMmTOc2roIQhGQwVEpvSMsYROXwFv2ZSEEXvATCs/wVzOuhVh2yZHHGtY48IyVPHXE6OMx2lQe31WzrpT/hJ+q6BBUxjWg9ROGCaUDy9CopDzfKPDHn0p3liyK53NW89oqexAOxQ5ihmYgN2Dpowz9oT7vnLm9gnhmRE3FlQMFWt1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNYeMkVPQ7+KeXT3OFKdXlqJPFksZ7JtNuqb9aT3d40=;
 b=jqRdh4YReEI/BZmq3HnBFeSGGjuQDcMIVS1PCMvaI0i0lqkRpMKqTELl63zfmF1oUDS0HS9QkWzVxGXCjJy/qu0gTAcRgELjwuKiMfNs4GdsOh57aDT9Ml9kjxDL01MRQoJxeMlnV1cUKVRmZzHMehaT+lp0D34/J0zJdnPbpSxPjyWsl5lruJI3tWAofIgjivkUGY0BZDuQx8Uq1FpG0TG9cfr9wIoT6Gwd4PQtPu/0pacX0KLHXod+mK2EzcCVeG3UU4aq8r5uC3O6BX7eYcZooPwMVjC+BPyPBlgK6wpKjcY6q3hpRxigs5gywx4+NWO9bFf1Q8VZ4O++XeeDtg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BY1PR02MB10459.namprd02.prod.outlook.com (2603:10b6:a03:5a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 15 May
 2025 15:44:56 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:44:56 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH 15/27] vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO
Date: Thu, 15 May 2025 16:44:00 +0100
Message-ID: <20250515154413.210315-16-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BY1PR02MB10459:EE_
X-MS-Office365-Filtering-Correlation-Id: 027abe73-dbb7-4e33-3508-08dd93c7712d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3C2KnSaJ5d1okcwRKKLjq2qGaIFXU9Gk4jNgSeNNuRvn9wz9aVdPX0ZVAd+q?=
 =?us-ascii?Q?1xj58sgut+zAiNv4J+DlVLTNfVkgGAaDkd+k/Xw4Q1P3f3VTY94iLUpOM7v8?=
 =?us-ascii?Q?muuyzV95A4Z2K7MAE83Lo+MBs+uAtuPELY9pJJzTEHxFXQICj/GwEmyzYjv1?=
 =?us-ascii?Q?sc+yymqfGEm6wF2q2RtCfveaar/MhikqzvfWqWSXhhWJ75GiUEn24y1uGCHL?=
 =?us-ascii?Q?3rK9pPHbfrGdElYM+DgZ1B6gzO91VCi7r1J44sPO7QMURVBpb34khJV6jOeP?=
 =?us-ascii?Q?WZelyYFsKz1BGCKoW0dIObbJAzyJyzmzQEMtwkK1ex25aAjijn5msDPH7zGl?=
 =?us-ascii?Q?j7mblmI8uP5J+qzX7EDqg+RnGYeXa+V5J/u4MWOFy/4p2z0eDWtFsAMDiTsI?=
 =?us-ascii?Q?/Moxf00r4H/Gk1TDU4grsrDth7kYcMCnhGIlpBYpMuMC80thB3/qjBlkQ5//?=
 =?us-ascii?Q?zl7XMp/QkFZ4idi6iRcd2zLwk2cFR8rxh1avqnt4R/k30Z21y4gydMaG1ri5?=
 =?us-ascii?Q?TZ7DKHqrZqTrhPBaVcvx0HnV9mOlajy0SZyozIwK8pUbqrvRUlgGLmZQle+u?=
 =?us-ascii?Q?tFBcxVX3+gOOusMgpFftA7Ty40CAJo/kraMM22MZCAM9ilIQblRxoA2DiClq?=
 =?us-ascii?Q?f9+kmCeYL3M9k8ZwXIXe1zHY2trXXiYKtlOB4kLE3whfNU5yypCjKIQ0SQta?=
 =?us-ascii?Q?FwqH0EeCQhHp7LRanRo4KTLkomf8pN8vEDVq6XQtGkY7VKZLdpQQCCz+G/fS?=
 =?us-ascii?Q?17H3AG53CZX5eWmCmmYtGvKqsiYfzkdFalPggS212curr7UGzszh+FyY8cBx?=
 =?us-ascii?Q?Fuy+eFR5lzm+eTMT1IhqkyP9lKVqlt5cM4a99XKJYCEZD/XQsbZKM3j6/7+0?=
 =?us-ascii?Q?sTBT91I07wGb5Z0zgtjB4dSJVoNbz6foPWFGPAt5NBn20Jnfdz9mZCN/UNQG?=
 =?us-ascii?Q?S2UtkNnStIK7gtECbDXyHZfIRxAJ13vMWT4bsb6s8ImkDjiRChIRuxmMSsje?=
 =?us-ascii?Q?4AVexyOpouCVVF8IlIE8f6yrUOICFtznrROHQQSlGiKDouQBvg6OP56imW9v?=
 =?us-ascii?Q?7uhKK5Xsvt8oLqULPoXw6KJlG5ol4oWuCyzub2Ufayvd/nNlrllfOnPp4VmS?=
 =?us-ascii?Q?DYtNBLPBYVzNQgbPSYVSyk4F67Z9Za0LXWYKBozy4uBV8NMDFIqUmkH8H+jX?=
 =?us-ascii?Q?AvR6NJIwdui+LU5pSdcNtDeESJwwoVSzrPrLaRM9jBZ2fCuAlhm4/iE59VhJ?=
 =?us-ascii?Q?ZMOkovOy6XQg6XN/k8oSdBFl5H2j9RB2EbOaK0JbJkdPB/07WzHAKiZBFuSz?=
 =?us-ascii?Q?ABfSsa1PnpTJaIxmelSP0hmdELVOWu/0/eSerx3MqyRrrjYx4n6DUKNPed72?=
 =?us-ascii?Q?Irfo6geDcPvIGN95hzxohJHMCOtBJHG6D6KNZhhuIYrfgy1DzQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6LBDy2wBZU1tetCbApLhdZCYyi6wBMcZ2Fu91MagJB6gxjuy1bIRF73Z1o84?=
 =?us-ascii?Q?2RWUF99MpRJi/9XGt0Lvk08EdownsIw+QJYHYCgBB68EHfC62gYVvlIAZHEn?=
 =?us-ascii?Q?xPtQjbKnHShcw3qImRbws7oV8kcD5thdFHrnqRFW6KkhhkFedmxLXHy1eveE?=
 =?us-ascii?Q?iP/n1o4Fg+1ahK7eDff9S0oRTCHZZmTLUv8idP6wPa+hSZi+yWuEwpdWXCHl?=
 =?us-ascii?Q?S+vsalDC3PjIE/PLMtazlYXS3VZHPn2/coep13rVeXud0dM8Zr4tSzYInpeo?=
 =?us-ascii?Q?wIpHHbJI7Nct8aMkl7w0cHcLF01t8FOdJduBZEeZbI7sl68gwLD7Zthd/OVn?=
 =?us-ascii?Q?KtGLij+z977I887me9/mJQwYnncnCW9T1f/VslNmLAMu1vNfAx179hlhMVho?=
 =?us-ascii?Q?ma33kuDSkO4FOhLIqJRStGgSsNvEn7fXyuQo50/fhVkNde9VXjA70k9A6VWG?=
 =?us-ascii?Q?WmoefBZ5WATCqMXIzicQVq7Tdwp7MaNXj5tAkRkIQf9pUZ/VEFqnozDs1a5H?=
 =?us-ascii?Q?0lcLiAREOOCgrKL4SUAyRzVFJ2EAscCQXqHi2/fP/wz5vYniL+n2NrsmIe07?=
 =?us-ascii?Q?0u73+xcKhvOOy6BAOU1uCicjp5qOQRQFJ3XA81l9Yep6Xss4Qvu6i6P+6yPT?=
 =?us-ascii?Q?qLaclPcyEEdI7/u1wbZOSiahmJ10NAsLM6b+ai4dX0HjPckYlWMvl8OwoEFU?=
 =?us-ascii?Q?MQMCj/Hn6Hsn7TiBdqQcQwWhCkzJCf6sHo7Ymwsp0MwMY9+Syvyjc2kLIaon?=
 =?us-ascii?Q?Yy088AUrf87ertVPVxyOwGWO5ZaGMveoqlk6qnlwVIwTrQYKWPn0IR7O6q9d?=
 =?us-ascii?Q?4ubq0xJuypVA2pz1H1/wGtSPnUpjbLfTrezTfbIlHPPIR9yBJ8IdZ0EiHTYR?=
 =?us-ascii?Q?HxhBPxaYD0RbMmstyoyyAfjniu2rBBPXpvTiWmHGv0CrhkohuuoqRTnuBqbE?=
 =?us-ascii?Q?J3xvjzFgoR5VDGZsLjPsnCBez0ZLBWdilcVo69l4AQFg5qzzv4hSfTB2doLk?=
 =?us-ascii?Q?bsWNtfR/f+ZlBciOZazNTuhJWTfSduj6+Vd72wYLZhCO35c5UckhFbOWAcY7?=
 =?us-ascii?Q?STRu0FrNaH4ONbes6a2bD85efYarL7VM1/EYk6XXtRp0O8bVUABluT+mNWZU?=
 =?us-ascii?Q?h2R26cQrswWCAdoCNUqVwY2t0bbNytLsI3E4oMCLQRF5jbmXsoZZ+UJUVMba?=
 =?us-ascii?Q?SHvxlqIjYIV6tKd+mixVurHf0sra3ZjxM27DsFMfPS2oYp0jdBhIOpfR1kac?=
 =?us-ascii?Q?QNcD9Xf9ok1TtRomg6f54JUKShS3eSwXNw1aO/b2W6f37sAhoE1X2jd6KoOs?=
 =?us-ascii?Q?nKvnlyydfUzXj3QPaX8EWhIKYoaYBGf8+dpyHA81rWlJaN3TtbzAk6LrTebV?=
 =?us-ascii?Q?FmiJP2t4jIQZUYCLPKVPcvESVWvPxUipxKLCCrYLMuwZMEdBLVjNWfLetU3F?=
 =?us-ascii?Q?kyl5VQqUZXMLRiBlCvTHTYyIMxd4echUruq2XtHTVvucjpP/8jrKGyhScbr8?=
 =?us-ascii?Q?rwO9cclTHul0sPMZHu+siTtq3Tg5l5/eNdLHOZjH7ibwei2wrPfF+Qe0hze8?=
 =?us-ascii?Q?OleXGEmHkl4Aac7K/FDfoqo0V/G2i7FO00kNZ3OW?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 027abe73-dbb7-4e33-3508-08dd93c7712d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:44:56.4930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gN4wtYEGjG7eS9MYfsP2MBtJQb66dhVIXQSJIr3q/JTAysZbhYBJD5YOmV45DX8W44/+QZThPGEG7hogW/abWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10459
X-Proofpoint-GUID: 89Y35tacCoSoHgj54-IP3yYVKEOASRuj
X-Authority-Analysis: v=2.4 cv=fNg53Yae c=1 sm=1 tr=0 ts=68260bfa cx=c_pps
 a=1Yrorf0s+JG35OSy7nTWtw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=u1fsugoMv0NfKDGiTLIA:9
X-Proofpoint-ORIG-GUID: 89Y35tacCoSoHgj54-IP3yYVKEOASRuj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfX6NXE9BZd8uOH
 zOUrXLfYnxrCG6P/4SkxQOSvH9QIEAAx+TL55GbvHdekxDnPiRZnXllhqEQ4gVfcdd0oX9C/Ceq
 9YtegQrOAr1K9Wb8f3sKcsuEtivGGWBJnIZ3xcmgoZ9cF50vNJkDy2P7IGer7Rvjbp4AzeVG8p9
 LaL+jlrzIudjqSxucm+7FT5TEJ0FnST3X1wXcr0xCieTr0BIrIUh+ji0cn1p/HqsdlgnSF4UUf1
 Qf5Fp88VZIQhNng3h5wzV0mBxsFSYhY3yBfezV43d6Lc7u4qESJlmZzgNSB8Cn4x/g9aKcwOEc4
 8MX4pEHn/zHNiXaEp1825+w4c/LmxTNUJ9+RKrkD8vuofgvXN6bEfCuPcH1mUwRlhHNMk8Bhr0K
 OZ34ZFng8LPZa8e08cs0EdNY1exYKvvNaEa8skC48d6tk3/zXqnhjGz+w/PQib/xIRzcGQ6W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add support for getting region info for vfio-user. As vfio-user has one
fd per region, enable ->use_region_fds.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/device.h     |  2 ++
 hw/vfio-user/protocol.h   | 14 ++++++++
 hw/vfio-user/proxy.h      |  1 +
 hw/vfio-user/device.c     | 68 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/pci.c        | 11 +++++++
 hw/vfio-user/trace-events |  1 +
 6 files changed, 97 insertions(+)

diff --git a/hw/vfio-user/device.h b/hw/vfio-user/device.h
index f27f26b479..a5a2aa9ba6 100644
--- a/hw/vfio-user/device.h
+++ b/hw/vfio-user/device.h
@@ -20,4 +20,6 @@
 int vfio_user_get_device_info(VFIOUserProxy *proxy,
                               struct vfio_device_info *info);
 
+extern VFIODeviceIOOps vfio_user_device_io_ops_sock;
+
 #endif /* VFIO_USER_DEVICE_H */
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 648badff46..1878d44c51 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -127,4 +127,18 @@ typedef struct {
     uint32_t num_irqs;
 } VFIOUserDeviceInfo;
 
+/*
+ * VFIO_USER_DEVICE_GET_REGION_INFO
+ * imported from struct vfio_region_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t cap_offset;
+    uint64_t size;
+    uint64_t offset;
+} VFIOUserRegionInfo;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 9c6b2cdf35..e2cfaeead8 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -18,6 +18,7 @@
 #include "qemu/queue.h"
 #include "qemu/sockets.h"
 #include "qemu/thread.h"
+#include "hw/vfio/vfio-device.h"
 #include "hw/vfio-user/protocol.h"
 
 typedef struct {
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index e081033ff1..57793e6b2b 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -48,3 +48,71 @@ int vfio_user_get_device_info(VFIOUserProxy *proxy,
 
     return 0;
 }
+
+static int vfio_user_get_region_info(VFIOUserProxy *proxy,
+                                     struct vfio_region_info *info,
+                                     VFIOUserFDs *fds)
+{
+    g_autofree VFIOUserRegionInfo *msgp = NULL;
+    uint32_t size;
+
+    /* data returned can be larger than vfio_region_info */
+    if (info->argsz < sizeof(*info)) {
+        error_printf("vfio_user_get_region_info argsz too small\n");
+        return -E2BIG;
+    }
+    if (fds != NULL && fds->send_fds != 0) {
+        error_printf("vfio_user_get_region_info can't send FDs\n");
+        return -EINVAL;
+    }
+
+    size = info->argsz + sizeof(VFIOUserHdr);
+    msgp = g_malloc0(size);
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_GET_REGION_INFO,
+                          sizeof(*msgp), 0);
+    msgp->argsz = info->argsz;
+    msgp->index = info->index;
+
+    vfio_user_send_wait(proxy, &msgp->hdr, fds, size);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    }
+    trace_vfio_user_get_region_info(msgp->index, msgp->flags, msgp->size);
+
+    memcpy(info, &msgp->argsz, info->argsz);
+    return 0;
+}
+
+
+static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
+                                               struct vfio_region_info *info,
+                                               int *fd)
+{
+    VFIOUserFDs fds = { 0, 1, fd};
+    int ret;
+
+    if (info->index > vbasedev->num_regions) {
+        return -EINVAL;
+    }
+
+    ret = vfio_user_get_region_info(vbasedev->proxy, info, &fds);
+    if (ret) {
+        return ret;
+    }
+
+    /* cap_offset in valid area */
+    if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) &&
+        (info->cap_offset < sizeof(*info) || info->cap_offset > info->argsz)) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+/*
+ * Socket-based io_ops
+ */
+VFIODeviceIOOps vfio_user_device_io_ops_sock = {
+    .get_region_info = vfio_user_device_io_get_region_info,
+};
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index ee343023f3..81fc91037d 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -14,6 +14,7 @@
 
 #include "hw/qdev-properties.h"
 #include "hw/vfio/pci.h"
+#include "hw/vfio-user/device.h"
 #include "hw/vfio-user/proxy.h"
 
 #define TYPE_VFIO_USER_PCI "vfio-user-pci"
@@ -92,11 +93,21 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
 
     vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
 
+    /*
+     * Use socket-based device I/O instead of vfio kernel driver.
+     */
+    vbasedev->io_ops = &vfio_user_device_io_ops_sock;
+
     /*
      * vfio-user devices are effectively mdevs (don't use a host iommu).
      */
     vbasedev->mdev = true;
 
+    /*
+     * Enable per-region fds.
+     */
+    vbasedev->use_region_fds = true;
+
     as = pci_device_iommu_address_space(pdev);
     if (!vfio_device_attach_by_iommu_type(TYPE_VFIO_IOMMU_USER,
                                           vbasedev->name, vbasedev,
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 6b06a3ed82..1860430301 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -7,3 +7,4 @@ vfio_user_recv_request(uint16_t cmd) " command 0x%x"
 vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
+vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
-- 
2.43.0


