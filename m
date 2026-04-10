Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C18E99056
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB7gB-0004cp-0T; Fri, 10 Apr 2026 04:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wB7g9-0004c9-Lt
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 04:57:29 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wB7g8-0003Hq-1B
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 04:57:29 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A6IR3Q2662057; Fri, 10 Apr 2026 01:57:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gQOXKIzzMxP1bXybqF8ZZWY5+IuNxA80ImuiDGXUU
 /Q=; b=wzz67U2FnQPo9uxP6IVYxyzZxcS6ah3vz2ZoRuSxqvU1bWDFeu6FxPH7C
 6fh+yzFgPdMdWxZrd7weeXnCH6DvFlAgF5mAgvhKLoLn8AdK7o1V8uNBYQc1htJS
 eiSLb12Szoj+MNzIIP4GMgrtLxYCvPlUb5V9vl/ji2ggGr2kMoaBoekx54uBdIXP
 EvJLf+jMuZ498yJ/Gg2twW2Mr3z8VX/0TMENCfLw92TvdYYy2vYTYk+qc3TN/lx+
 zGaJ+40p0AH71191VR0zKlYHO+1VkPkBg/S+hmbOKUfRw+ML0WHcSrnSXu16sJH0
 4p4aIufmyYlyt/FmUwC390kHXWkYg==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021106.outbound.protection.outlook.com [52.101.62.106])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4def2k1re2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 01:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8CHcxbJiwqBh4juidt5bv6hb5ocw/LGi/aIViCd/9uuZ5RPy+SpSxwgC+ooRsaBX8hI/U6KgpOQZ3qDcbglF/PpTjEMzvkYhhrctfeFsVAfupkGliHXNttBpJhgk4uwLUSmX6IEkf62qOyEwDxxwpzQ86aH0a/j2Mnan+mEQmCY+LvJP2f0AnXS06BV1hRhFhny96qFcT6/dsNbvBHqsUaquiPFw56RWpQU5F40W/JcIPi4VTXKeqpSk+0Yv37PQsLuTfJuMALXCQbZH/GHLWtarJtESOw8OiOEOLktVjjKvHpbVJQFWxCi8fXbUTiReliJi1UXKmY3s875FyjmcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQOXKIzzMxP1bXybqF8ZZWY5+IuNxA80ImuiDGXUU/Q=;
 b=cgzSbFX314+VngTHirEkqn6wLSHB/WpGcKKhqC9rG0SoC2WxMPybzvYyOxjdYpFT0+RFDMg83Pe7NyUIGw3T1qI1ybit3mOCBEW60QO5ygPNVYOo7NFt2cLnhwbInKT3MszP4LAM2zcx6Naoq30wxvdEgqnchVvounRWSx/gS8w9Bh8P1TTe+lkiFnSSvvIZF9LW+VqGHfKl2hZw/+oprvC4aOxSbd3c7j3Q/GCNRLjkOCwKXGvb7n4zdM7Ywb4FCZoYetGmEbilXaz7qx5E5YYrmpk1wvY/gP5FyfbUzXQZScA6kSlJPLbwsx68XJmesoSEfDYCdtDprQtYIU/P6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQOXKIzzMxP1bXybqF8ZZWY5+IuNxA80ImuiDGXUU/Q=;
 b=ThsbgtvA6y9TXI8MXDNxhfduAGGLKmIWg5Lj9E1r0aOdbyT1ojp5PNOAkTuqbHak6DM4GYinKlRgsAwcJeimy0g9z1uExCfytWimndROF6eX4/JKpX0Z3+T0BXQskHRdSU1AFw4B/eV2ONisMDuejsj8sd+X2cUo4HrEL5WodULng41mgr7ZcOxgSy7zCWrlUQpnuXjDawgjzKNqj3POnoiJg3oOAtytBcgxoQc5QryPSVCF1QQVgE0oF9cnopwZpQzVg3IsJAahVYLIfKQkMFoNXd5EUceEudoV7MQMv0cfLSbU7xJ81INevkQBUFW/8jC5vDQkzlcLxYg+ubcK2w==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by IA1PR02MB9256.namprd02.prod.outlook.com (2603:10b6:208:424::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 10 Apr
 2026 08:57:23 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9769.035; Fri, 10 Apr 2026
 08:57:23 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>, Patrick Mooney <patrick@matx.com>
Subject: [PATCH v2 2/3] vfio-user: correct protocol for DMA reads/writes
Date: Fri, 10 Apr 2026 09:57:15 +0100
Message-ID: <20260410085716.877185-3-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410085716.877185-1-john.levon@nutanix.com>
References: <20260410085716.877185-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0404.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::32) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|IA1PR02MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: 31233401-b5d0-4969-77a7-08de96df2dfa
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Zxna37pV6rD0f2LZOIKvDXA7m6GehGM+TzwN17dEAuTlo1zK6mKprNzVaFVL4LcSVFuH2PR6F7PGSeqUF4bt/YKvKimZb53yv7vWZsB326Ls1qGYOvIcckAyyFM4kgb3M1XF+L4q5mD77PtxhtmQNCLNCGU02qrbjXBDfKx57P+7Afg9XuSi2dwA3VGWdW4C3fYH8yNqMAnijtu+DL19YE7xL0z8YnpnQOtJFxUyNGIM4gQcPsT/fQKii38zhpGsNj5ayIc+aNm4iIKkKYD1/oihlW8/PreqhTgsq/G5UFRDdfu8Wv4L/LTxBXEyqTnQYoLdMbwSKvo8874YJdpIa0Ee0ndWb8Nv+YH90rJ8lAaH5xBytLtQmfR7JLUpHnwbc52/KJHLALVIY/+wyYcLdjldVW8+I+Oi1Cmi2Hj5doqd187Z4h1rzl+FYdxhSrVF3f3juVGpY1A1SjRn5fWPKhtMF/4609T26m/2GI1bBNRHi9Xqix7JYdXBiDQvnt+IvAt1pBpdJlTgPslWlTe7tJfvxBX0Qc5HS98I4yLyze2TWeZSI4Cl0AZ29617WqhYpZoVxOm2r938pAGHs3l4XETuQMA/0WITsTtb2J+KuA+656N6gt+YZjK7u54tDktYofISNToVbjQjf9Ia985tSpyqR4Bp1Z3a/qPfGyBhJ3v8PAFHBpOpIDeAQpnpKUG1bKkLJT/3DsG6iiyS58vjUvuP8Yki3jmECd7L5oOWB0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Gr5pT1/qwQvazxUr0xGVYq5lQME6DXTApnxRK1zzOoF62WyPQcOSV4jQPWz?=
 =?us-ascii?Q?0JeskU8LmXohHMd2jPjArzYAbKIiYr/iVTbZY0tRs/3oSfCN6euKmKeSRkSx?=
 =?us-ascii?Q?lA961qPEb64/bkyCTiSozHZFlAPzOOu2cYxsKazOU5ahfIJANxWRQaXtjS9W?=
 =?us-ascii?Q?0bYXeU7TYW4vukp6JcxE1HNZtu5LZOxXK0n0isTyZlkVbjM3R6ECJjpQOe3B?=
 =?us-ascii?Q?S4da28cBstGt5pMhznuejrtw+jAmcjZN3XVT0Huhi8V7/AT3Sfu4dRibhBdK?=
 =?us-ascii?Q?GJGk52A4AmoP9iq59S1Oet9mUzsKM17SZrK3t4XcRGPZVYuGUMAzxPLmq7Mk?=
 =?us-ascii?Q?F9+eQw46EEiaI4HY/fJfPaAtRoKn+riHcm8eetmRMUB7w1PCQIQCMgFQsjux?=
 =?us-ascii?Q?Fb1F+i8qevEXVY4kGpp5sfGStQEd6J0MRkVk3ihHH50ddzmREClgPh9VxXnW?=
 =?us-ascii?Q?mBZdMevwEVDIyThHp4q5t2gX9pKnFhdWfi4BkaWKOoOsbkprYzUGOsFDduI1?=
 =?us-ascii?Q?zlk/LazcZ/oJ5vS4GO7odsjbpKRVTtiQ3Cx9h9h+0miuX7TJxVX/kfqO+Yf5?=
 =?us-ascii?Q?RagF2wh315cxf8A8WX4iHbh/XnoOdNvwEoJUuLbb0W0h7GHfcbYNmBODjlOB?=
 =?us-ascii?Q?t9GNe3cnGHMc4nGg5HaPCxBzJfHFqw8npd7CLDJx7NRZO8qJIbpzj5Q27rHj?=
 =?us-ascii?Q?I+Q7R56UW5crPqfpgWgN9CYkz6NdGWzzEg1Ysart5YdjTM41B1wMNDtwUrLZ?=
 =?us-ascii?Q?Uwf5cT+m9VopTsSOlou1D0VShU1MRSzmDcbwj5wZdApzN0zzhSjbfAcYUHDr?=
 =?us-ascii?Q?xvoOhKLQqoAKoqj+80U1mp04fH4RalRbMqkYqD9sLVfjBAqU86zYLwsdpHPJ?=
 =?us-ascii?Q?+h5R8DRhN56jUQj1yoDz0bScF2qNJ4LMXvRwaAgCvhS7mjOvSWnXUpvZEL6A?=
 =?us-ascii?Q?+dnTVcFd/JEjfa7DuEK46rMPeS3sRCyYPpiNGjz7EC32dUFWsjs1rkPe0PjR?=
 =?us-ascii?Q?xqgboQqmim/F3Gss1mztoExw6nNDZJ7AeJzhmLGDpTryCpchFs12I7XNIz43?=
 =?us-ascii?Q?Xudbq/7cWLSEXdAclVkQpuu1n9tO6gU3s3920V+sOZsbfhL1jCjBXsNALl8j?=
 =?us-ascii?Q?qBDTj26b3Tm93O6PCIjKB29bR4MpxVz0q6OrVh2rBlbnG02pfafH6CPBPhmB?=
 =?us-ascii?Q?tkvdq6qT9WEA2Ul/hIm8dGIW38ab7TQVq9VrFKK7TA9TQAgKknF4nd8liKpe?=
 =?us-ascii?Q?Nf2lAbwBXhnbu9gN0J9eyP/gNY6zhdUuvFHQNvntvsbez8gmY6a7lkRw6lr2?=
 =?us-ascii?Q?kPesLcx0KXIGDhLwnGyetmIR0Tuuy++c9ZwUanjafB1UMXzcWI+g7pp8Gcu/?=
 =?us-ascii?Q?Z10hyKeW4kOrWLpPKFtUtEvPse2kHFF0F16ALfhb/8yheL55Y9Kfju81GyD2?=
 =?us-ascii?Q?yswkkv7hk7SHpwHPnDdZbEZAn3hBrBTAcgPGfGpZAMi/m4MXkvXq4zsjQBnU?=
 =?us-ascii?Q?zfPKA0LSRBWGMeoyOgHruCasyLocaTdaqag/uoMWCOav+1iHyzdV5qpvJZWd?=
 =?us-ascii?Q?a0zJi5Y5qQLzVHzdzbJYhFrmBcJfSHyAOZ6xvvQmWB9/Zkdb/qofcPlC+fLp?=
 =?us-ascii?Q?oDklRa73hJJWYjMk3M9noLelLaHMrtePRLBJUCdaxjdjGjLA19bFPMidYkJA?=
 =?us-ascii?Q?f11mhmYGkxbbDNvZgtAPiZyDzTfLwJtWnuBRRXhTQZLIzn74a+zzWekcacEk?=
 =?us-ascii?Q?MsuDr5Q9hg=3D=3D?=
X-Exchange-RoutingPolicyChecked: XvoghYn08zq8c9BrLKUR1hD9r+akI624/8k7rH114Z7RVca36yXZpeLZnUHBFHcTGUztT7bu1S35WdY1cV3zYzo6QOvwjiY8zWtH+3P8IiSDSCovdhY2aX0i/4ZDvY+yEmqY2ISi2exfD9aobIDWyxRrzc/aK/1iOwf1HTjs3Y1Fu8jVNJJdlAbgnDklGkWrK91pXmyfzvsmTluq7bOHlbx8Pih2qnFbXMlj6qpUfgRu1BDlajx9X8N9z+ZuTwkuruGBatf5ByEFs3hI3BwQkHaE6rI0LDtAX2q0gCGEGj6L1QBKK900ad65doe78zIVhMhO3CqCksB7eL2tGpmhzg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31233401-b5d0-4969-77a7-08de96df2dfa
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 08:57:22.9191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcLVxVh5e/nbQrOHQK584TK7akg2CnbeSWqRF9B5kDlwh/9hZToIotaTOT+T9l03uq/fZgsmusFmAao/sbMN2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9256
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4MiBTYWx0ZWRfX9X3AGclXX2P8
 cHuI5UM1V1ctMlPi9gY8tZYjvQ+DEKnhrCa3VbKo+3du0/ud/CWeEey5e9F54OU6OBgf/gvImMY
 rv6r6OhRRcE/VAXoKfTdGajK/FEQBvXUcEsu/RnmX0eHmo802w3jKTP0Al4m/g5DItYaKK84WlT
 V+iPQGZBq2VoQDZh5lQbSPTUttOLSxTdPxY9lTM0GWY25HFLfm5GdFYD10Wh2kAUHNUjEATWsQn
 O1RuogztFqSExKx1KFfzDmKolCcj2rxrc/J/r516/3uGoKZWrPe3VDuHnWq4iE/2EQVwOkJQmL+
 SLOnASUwT/neyqLBYcq1Vy+WDHcE6vYrRwfl3CR6RJV93EXRa/lnqCOnzOrx7vJqcFih39qb2md
 5SS3h//CCxZT929nO+n/T3PaED8ifYQEnPg8ZjG3WW0999sCc/LULISUZVFQSwG0ZqEhsJP+xMw
 axMIyJMIPu+y/7W/Nxw==
X-Proofpoint-ORIG-GUID: Ae0l7Nd5dmtxGhTwDPjR0dNKxmZujE17
X-Authority-Analysis: v=2.4 cv=fKgJG5ae c=1 sm=1 tr=0 ts=69d8bb74 cx=c_pps
 a=YkHaaIsEX1QH8E31U4hA2w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=puMWUmrUAAAA:8 a=64Cc0HZtAAAA:8 a=grO-18Nwhb_pULRB4IoA:9
 a=oJ1xzHRvupUJs7EIRaQM:22
X-Proofpoint-GUID: Ae0l7Nd5dmtxGhTwDPjR0dNKxmZujE17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The "count" parameter in the DMA write reply should be 8 bytes in size.

Reported-by: Patrick Mooney <patrick@matx.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 docs/interop/vfio-user.rst | 2 +-
 hw/vfio-user/protocol.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst
index 303fc13d6e..d4766487ea 100644
--- a/docs/interop/vfio-user.rst
+++ b/docs/interop/vfio-user.rst
@@ -1463,7 +1463,7 @@ Reply
 +=========+========+==========+
 | address | 0      | 8        |
 +---------+--------+----------+
-| count   | 8      | 4        |
+| count   | 8      | 8        |
 +---------+--------+----------+
 
 * *address* is the client DMA memory address being accessed.
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 2a0c31e7c5..c478d1353f 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -210,7 +210,7 @@ typedef struct {
 typedef struct {
     VFIOUserHdr hdr;
     uint64_t offset;
-    uint32_t count;
+    uint64_t count;
     char data[];
 } VFIOUserDMARW;
 
-- 
2.43.0


