Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83B0C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgVZ-0000uO-2v; Wed, 19 Aug 2026 09:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVI-0000pU-Hf; Wed, 19 Aug 2026 09:38:52 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVF-0000im-P1; Wed, 19 Aug 2026 09:38:52 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JCmE5W2886938; Wed, 19 Aug 2026 06:38:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=pnIGSKWpxj34A0dd96xi9opwsGQg2z34ELh3nlYvl
 HU=; b=wV3Q+qkmN2ZkniueovKvr97UA8jLaJod2PvdZYFszmwQ1nQXDDB+4FBU6
 DirPmDtjt2xQKOMeTgwN942YEBtXlR3IxroCym3sf47b6qn0OfC0/fC/ks0zWxx2
 DjRQOEU7uLsrlepejw0A5iBtMGMV8/us/rpG9eytiXtTRkdF9ZdFLY6PZrboU6FX
 MU5MbCGxLGmcLrylPsGnRQqNYYxGviG4+iVioj7MRf7ArTg/GqXqMgwlKzsyW2Da
 bL4Rf8B7ui+guel9af31h+8c+q6MUbziGmrA2fbvxmE8Wc+w/uFnNAhuWoOInBnU
 Ysqw2Wyla32OnMz75OgdAG8Vh4K/Q==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021080.outbound.protection.outlook.com
 [40.93.194.80])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g4wg3td1v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 06:38:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVKESWq2qA6RRDtzSr73NDwY1fOzvA14Rr6Ae5v+1V0Icgtrli83fT/gI8Yz9DbQNb4rFOzpQn4CGso3F+7QSZP8PUb2suK3h/ZtvejeWbB4H5aHebRMKpCaDFP7nmbqdMFk1b+uxLGq2REmRRZZ01ya1BpNvQMhvwMm4yGpzXQdIQ+LGfVrgl0dJOH5vvl41E+LdUV1qqeoVci62g6NMzUM5X+nLPs30x+YoXbBm6JAzYYP1/kkep7ljeYc+aTJ6g0C2msLmTQhmxthqkxPRrbwCG6NY3r5+8RxVv+4tON1WS9xzyUHT/+eHMrkPIDbYaeyvYf08UWJItYJ+TLiuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnIGSKWpxj34A0dd96xi9opwsGQg2z34ELh3nlYvlHU=;
 b=TLph4Vz7pOfmnGA4a2Q5dDx3LY+WDwOxl33wB+WzvLySwbLcTYBWpJ9RbPPELL15e4Tlib+cn6hA/sLmd5HudY9p2sTsH70AUPR2RsMmeAJWu+41fs/XzTQwifS6fD+LwdcWWXlcLGLO+WDsPzsNY0K1xG9f3Qk93i//XbrLFdr/xOPfWkAirxHnQSXwBzo8ZHYDUKsJhrVFpy+2bv+eKHguNBra5MPCyT6eVxpdMea9XXBgDYXNmiyqxALg1ZdZ8XhK0kR/mgavsEu9HETaylA9QARaZ7BrFzwoV56cJ/EKxBulwV7jcJHkHPRlLCqaU9tupATKYlW6Sjq412u/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnIGSKWpxj34A0dd96xi9opwsGQg2z34ELh3nlYvlHU=;
 b=T/RE00F5MFfBPdnD9HsfzvBUrnHBNIMrbF8aNTqf+peZKwqy/rhtNEMEPm9VBNIYlUbT3JUl2k6zHycKWzk9me6ZAZ3qVe/eM4CTvV/QynjzWdEjsDhhOa5Pt+G/ucSC0aRU/T1SfvlcWhfdFG+Lx8qQWKboKm6IjPgmfvOt3+RlCmkD42MbIvVZB+qMrZNFZhbxq4WuE7fzSULJNjOR4ZHUKQyIq6mraZZI5XmUJCXu3y2JKN3YWhp449aGfWCbNzUt0P5AyQXcBV0uUrFJBJK/nZVpJMMJSTmIBfzpVGKjgrtQcHA9FvxZ60uRSN/2jQwLC2d/+HrcwkafQwigww==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 13:38:38 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 13:38:38 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v3 05/15] hw/isa/lpc_ich9.c: convert ich9_lpc_initfn() object
 props to class props
Date: Wed, 19 Aug 2026 14:35:44 +0100
Message-ID: <20260819133816.3497033-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0094.namprd11.prod.outlook.com
 (2603:10b6:806:d1::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: aca4d1e5-7aac-433c-bbe5-08defdf72cea
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|23010399003|921020|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3I12Bxwzh6BBBeqqQ43P+VcTF/5OuPXBsZmYKEIgPpJYVTf9+TwCWZjDDzHiMgT6nZer7LtnA+sA9InOKDfonTN/mzkWxpJWVSxXzfaeTzfJz2UxVA36EgjAYGbf/VadL3hOtM7bJPTtTIjh9nPO8EZO62xptNCAVsJAuZPW/MprtUFYcW6kwNl74nr1zubt7ECiliiIZCtDN/MLmDg2Cq0eijx19LoQsDWLk9WcLwdf5t7O3y7Ibmubuh6/s1X5yf0Tp4SxMcPOfz21N/t5jm9Ld4kwdKr2cXvK2QlzPus63z/+rFeAC/1LrTtX4PF2xVZcx9FSfp8JtPwPHPDDX7oXECdijQwbX2E4d2JHwsgkxooPphieKcZxrfrl2h1SlOkiZsC/r0YOvU8vmK40Wou1HvQoqOO++xh7ksSGXgmEJQy2/OaQ89KR4DI1DoSmGl3j/IsdvMaZOOh49S7Bq3/gtyM6WfRjChvWtd/LXl4+2HNUoch3nk88zPLVCggeQHkp5i2vYZIvX2siPdCJAfcIW3QYOmiWOseLgAd2HI2FIEZ5y9uZpH6o1iwPeF1heJidPSuc4xoyged+vJwwDqtKGr6VQeQN2hbvEPTGrX+AJr5s1bd4to91LDp4rPFnIXyDvpHeIy55A35YPOFpqHotC4PqfrY8i0NdrtghfOTXCyDytuIrJxC9VsurgbVlsdhnSqRFOL8ujzF5If+2Ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(921020)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MKr/HuIWoSFYij+yzyw3GW2b03iYKuG3vvh2XjyPUGI5Vhcr7NpdMgutRT5h?=
 =?us-ascii?Q?zHhXRut/XqlnAfUcRzusog0jY1PRlGoKZ8SNWj4bLvGj0Xx4suKIr50qvimY?=
 =?us-ascii?Q?3lXcwi5FcYIePuIIW1r7QzmJXaCxo/6v9EKt8e7eUb+EU9weyH6kw183zGn4?=
 =?us-ascii?Q?uDnioiB5v++4fAGEebInoDwKGB8pgjDcM1PBplKIVz16dbiwCsZgW/IcKhiw?=
 =?us-ascii?Q?uo2aL5QoGILzPM91H0/0UBHCUjbzEKYGOELAfAmy7YOuU+JrgY2i6CCmrPFT?=
 =?us-ascii?Q?/fCg+eOJBuFvA16KGNmFStmphNX4pkrUBOiRiUwt5tWU4BvrZjnf8EEZ8Siz?=
 =?us-ascii?Q?/tzJv87n1Aj9QC+DKQxOKAeeU7G3yOVZR8lYwDyVhSyS9HdKXhUdb8ahf8Ns?=
 =?us-ascii?Q?gYGuvtWU8jdY1fl30HVv0w9M/RJO66O69ZFwlNdEaLGPSWKN4P73McS1Sla5?=
 =?us-ascii?Q?VX4SDovCMZaTr+0lw1rYXZZMzb+UJknQCKQLJUEr/sFHEfRUBCATf72GS2Dh?=
 =?us-ascii?Q?RhYUqT6mRkJzbXE9QmxcUgWodAVd5ZMs/G3V1IZ0GgeCkvTwrHaOtGxuGNcy?=
 =?us-ascii?Q?71ilpXXvxYx9DzSlPGEUAwbSZoxbzlXBFYECoTl1Kn3cNTePQH9Mds6NXdDz?=
 =?us-ascii?Q?HnSNjHVX7SwJSnBP02YeQL85Mo/FQR0dXpBVu+TodEag5hdavVPNzVw11mJa?=
 =?us-ascii?Q?Ivt5n0xLRdCU68s0amEPvmqMGenXxs8BtAhxH912NAUmx3RUT3RW4M4kVLUy?=
 =?us-ascii?Q?aCmPthQUNC340JN6Qnhz5upQsWGpNCrbrznT0O0ZjoqPPTA86yFl47DjH/t+?=
 =?us-ascii?Q?9JbQ+dgIOh9PWH2ue0SZttK6RUA/KK2r9FUx2U1XzS+O07vbDpA9nMZ+vf+2?=
 =?us-ascii?Q?Un84rCJHqirM5daLNbTDw30xhkoim6354V2iM+Fhn2bf5c+P6PaVyELhdxwY?=
 =?us-ascii?Q?08n/QYEBzIXwNNRVEjYhGmGOyocPaiQXGgpP01q4x4rTA51VHW4aTQBBfmOr?=
 =?us-ascii?Q?dfQ508clhIYPcTmGazbyOhvRHSxd3np714iv4W2cxzcs8wXgG8xOnvrZgM/4?=
 =?us-ascii?Q?QuRt1s9vFWMWFx+nIEQ5onAt9isIIQS8OGKTwWb9BjJ2eyOdX3VmAnJxAhm9?=
 =?us-ascii?Q?Rpc35ynKyRw8dlLCWlia3lWULw6+BWqfjun5z0v5reEqdhJvcF37lx+pISJK?=
 =?us-ascii?Q?Nezyfw2rql+twTAuLNHomD5V2s4B25zwddz8k+uVRTwuGZC8V9zGkF459Y5C?=
 =?us-ascii?Q?fm1BZ7RIMI8N38dQtZQI4uBTgzrzl0aC5Ekbg+hiuX2PcH607Rv/jZGK03FG?=
 =?us-ascii?Q?clBkzgl/LXi5UNmntAWy1Xl2qbUT7vNo5H+/K08J8NJq/6lrgtgptd9edfVg?=
 =?us-ascii?Q?9opL2FW8T9cpotOLoteePKvQvor2eMs8nZ7AuY5NnzblEWgLbNttBNEFJ7cj?=
 =?us-ascii?Q?p0sioeFjy29/SXvx05fME7btoJtGIN3Cq9B2CMLxtLW2J8mvM01u81iPqCjc?=
 =?us-ascii?Q?WGmaLmpQ1rqAEx7sa3XKo34Zz52Gc/erdyy7fxEwrrkxLXoZucBtNexVhqjP?=
 =?us-ascii?Q?uERfaeYyVPZM8fHPCzfv3poh46sw6Gz9KqqPR4mI49H1hel2R5pmrFXiwa4K?=
 =?us-ascii?Q?4xZJHA5xIajADmeCVPSJMAbxROY/jqgpPvXJaYk074DJkK/esadV8KbhJ350?=
 =?us-ascii?Q?WI8ZEXYTmwqA5yAXALo3q4LANA8/ZDynFjL2zkWhS8u4FQl9Hcb4X2SN8Yg0?=
 =?us-ascii?Q?pZqMkgh33aANLVHCqAd4+CHsEuqVTcY=3D?=
X-Exchange-RoutingPolicyChecked: OeqjjfncSKuBthCB9Q77xlJIJZY8vCa2xvO94WwG5qNW7i5lO+JnIlqV7BwYLocB+7vNKUyNjwqCWQM0sE56u7d4uZYXDr9NDpOqhYbJ//emurEbV1Izyt4zxtC8c0kex6NWNUZfGF/NUuEr+ZD5TTtT8GjcUZdLTFZ8q/jKgnXWgJuKu+4Us0oOh0VFAo6eO5UR2sl3VeH/7L2PKu9Xplbe+dwQhA2RCW6CkQ+gLqowGhsKtYX+lC8G9pge7uVSnARozgpl4JqnfGLDf3t0xJg32focSTukShbM0PjRFFo3Cawj8JEfGSi+99ieT7XkUdqRo/fiO/5YiB0LvobViQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aca4d1e5-7aac-433c-bbe5-08defdf72cea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 13:38:38.7519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5bmc5TOdOVYk6vrnGLu28yqIrkAhM9Avyf7YHSE9ygVGCyY0K1K3ZAkMTUMNHLigh9gUtpmaabndE5YQkL1dJC3fy1CTjM30FNSG9IKZuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7336
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX9UimzHnenvmh
 r5Cf30NxudlOLcRseaWDMFlRmiH3BRqqITXqHYqwkyO08XMiMfU2XSriokEJQJ2K2syEWS4qBum
 8FA649W/iA8eOOGTWvmFzvyMF6WXUSM=
X-Authority-Analysis: v=2.4 cv=c+qbhx9l c=1 sm=1 tr=0 ts=6a85b1e0 cx=c_pps
 a=zCB0p5dOVkmUH+c4GheF5Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=oOh_xqB7XwJDYdBhmPMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX4KXgmxJv9tIx
 q7TDqj0282KmuNCfLGByqe2VTR4sWYIPbEdyw3VYn5ych4Ji1nqmk7JC0UNtKCmn+ov5SDE71dA
 LlVIGMEPariStkBUoxEmEMnAzDTVKZsp0XGBrnXqDvhVDZxMFh83cmNYRDCCot8/46K0pemq0nO
 S1FNfWgr1EGm2RBiEwNN4aEbJZKDVhiKCz5nltRowNn5tHEyKNXfNcpCMbfL/lFjmdjCvjG8vPd
 cMErez+IoL9H3pFmWbd3dA5QKmEiAQnRgXbXMURx/RBpUWKY8kfyicCKBvz7hwAfc/Cw9tjtuVh
 honho4iOmYKiRTJYQDBGzTjDN2yrTnyCqEGgrb+JI56Z+DbXAPcNlmet/9m7J8dx0mf2DgpPY+Y
 +hD+tBxTgqaIkC60a3zG+P7AWQMUJ4R8kuTAQMojqKG2RBwwhOnDBPyBl7tdwmfxE372fsujb63
 CzbHIoVhUhz/X2BIrCA==
X-Proofpoint-GUID: huhI4OYMkMruFnImKth7ZBtWwuQi-n8_
X-Proofpoint-ORIG-GUID: huhI4OYMkMruFnImKth7ZBtWwuQi-n8_
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

ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP can be promoted to a Property since it uses
standard uint64 getter and setter functions.

ACPI_PM_PROP_SCI_INT can be updated to use object_class_property_add_uint8_ptr()
with OBJ_PROP_FLAG_READ.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/isa/lpc_ich9.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index edf9783ec8..8925cd4387 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -683,24 +683,11 @@ static void ich9_lpc_initfn(Object *obj)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
 
-    static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
-    static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
-
     object_initialize_child(obj, "rtc", &lpc->rtc, TYPE_MC146818_RTC);
 
     qdev_init_gpio_out_named(DEVICE(lpc), lpc->gsi, ICH9_GPIO_GSI,
                              IOAPIC_NUM_PINS);
 
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_SCI_INT,
-                                  &lpc->sci_gsi, OBJ_PROP_FLAG_READ);
-    object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_CMD,
-                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE_CMD,
-                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint64_ptr(obj, ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP,
-                                   &lpc->smi_negotiated_features,
-                                   OBJ_PROP_FLAG_READ);
-
     ich9_pm_reset_properties(&lpc->pm);
     ich9_pm_add_properties(obj, &lpc->pm);
 }
@@ -845,6 +832,8 @@ static const Property ich9_lpc_properties[] = {
                      pm.swsmi_timer_enabled, true),
     DEFINE_PROP_BOOL("x-smi-periodic-timer", ICH9LPCState,
                      pm.periodic_timer_enabled, true),
+    DEFINE_PROP_UINT64(ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP, ICH9LPCState,
+                       smi_negotiated_features, 0)
 };
 
 static void ich9_send_gpe(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
@@ -888,6 +877,9 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
     AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(klass);
     AcpiDevAmlIfClass *amldevc = ACPI_DEV_AML_IF_CLASS(klass);
 
+    static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
+    static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
+
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     device_class_set_legacy_reset(dc, ich9_lpc_reset);
     k->realize = ich9_lpc_realize;
@@ -912,6 +904,18 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
     adevc->ospm_status = ich9_pm_ospm_status;
     adevc->send_event = ich9_send_gpe;
     amldevc->build_dev_aml = build_ich9_isa_aml;
+
+    object_class_property_add_uint8_ptr(klass, ACPI_PM_PROP_SCI_INT,
+                                        offsetof(ICH9LPCState, sci_gsi),
+                                        OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint8_ptr(klass,
+                                               ACPI_PM_PROP_ACPI_ENABLE_CMD,
+                                               &acpi_enable_cmd,
+                                               OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint8_ptr(klass,
+                                               ACPI_PM_PROP_ACPI_DISABLE_CMD,
+                                               &acpi_disable_cmd,
+                                               OBJ_PROP_FLAG_READ);
 }
 
 static const TypeInfo ich9_lpc_info = {
-- 
2.43.0


