Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A600C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeNR-0002el-Tb; Fri, 03 Jul 2026 09:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeNL-0002ak-FU; Fri, 03 Jul 2026 09:56:17 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeNJ-0006gH-0n; Fri, 03 Jul 2026 09:56:15 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635utX41961896; Fri, 3 Jul 2026 06:55:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=rK4f1RkjvmrhQirHky5BmpR49gENDcoCIecVi0nja
 pk=; b=qRiIxwcCmcaadi1bDrPizJkySiopc9Rn2bYOuiUSPxmm0V7Em23rXqjMG
 gaRu5yQvCtYhmlabo/eomXlqBtOD3LnFRSjqqPMTp1UQF3kPMAHZrx0dNCtE7msP
 0xQCvXFTnzXzzJp/Hm9q3iWvvV5MkZHUQG+KJ79shYwhODbrv7/47Ffh7h7VyBUP
 MkQD2nJrBDsWMBeJr1s78SsTLSsxINk8z9e/18/MaHMrdxx04f7+EwnNO4OqU0xr
 Tpjr33h6xNPh5DNgGcwnkI6M3n/43iZZo+mXdD7FYApLE8Pbe/jPmc9JXTtcun08
 5ydIj5qXvBWmnNJN4LcJCdwCCfBpw==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020133.outbound.protection.outlook.com [52.101.61.133])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f57ebdr0r-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 06:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNmE9CDq9bF1kTNURu3AvG+twkWe/Ok+umEfiC5gtS3q/2iOGk6Bp9UQQnKMHsw8p+ZKMF11uoZnm91D/Oxn6GsQ9uaw2qiw2hsdNJeU+oPRtxdpTsyZfgYkPGJn7BHK0ovT93DGYGkP9XKhxWiIn4Dt4YKMU0UyBv08YLqtd7I8Rge+WWtvIcAF29dP4xOfzySTSp19Q7nnx+y2z81alQfYE66ir37MCfYEkdadBOlGSa9wSM4aJHiFwPmb4n+DYxC0TyBuilL1ylAj28n3OvqKQNicXmwYI8x3y8XyDuYcfEJo31RKwDuDO7qbRhn/U19xkATBz8Tx4K71+MYsYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rK4f1RkjvmrhQirHky5BmpR49gENDcoCIecVi0njapk=;
 b=Fwl9/2adgrx2IYfBZ+iBdpnuJDsi1748c4CB+U46GVkFVct3VwP31KfVJrVdCGThWpFmejA6ExwC3yPnoUPT6ESNNO3H0GbCvbv0cExzqUXk+rgLiwHCOhzD4gOyg5p9JfQTvd95c1XIufO/jp8iGUs+xXzMZBG631xdPUW7S1gx1S3YJD2pIEwWxN3KU0wmtQrvzuq7TcqrzZIwXLXNFGmw/ibRM9UQ+IFi3/LO5fsGzv7OQFVzjV4nu9ZNtjFtmfhIY0Y00fg404xD6ISJLsyktiMEKmBATju0U56H+H5qQzi6u8cMvg44tcOBnjV4knfNeXUfQr+aAUAfhLBCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK4f1RkjvmrhQirHky5BmpR49gENDcoCIecVi0njapk=;
 b=sqJ7LZuTNuwfdgjEgVOBqrsDIjNVfd9HEEQMvdU0fYmFatX5q5j/DS4xdfrRafpx1Zk8o9snGfzVk6NAL5rGuC65WSjs2CJXS7w/RgUfQR/NXNk0rzFW7TyxnQuFj+dMahYLUrsyauagqHG+H/13wD+llQvS/f87i9dQAy/UuRylCbRwLFomWmDqxOTxmmF6UMn7QbCkvyVT4b81SfuMpCeK2/X6aX1gR/RQ747yOEC1gJcBq5WuqAgqtIRapbLNfkLmtOtQZ6yfRLKXOPuhK7+g/KkL51PiUCxsc6+9BxQyG7kZj2MWBoK272eleGiknfCHeq7kFfIZA211rUjmWg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY5PR02MB9016.namprd02.prod.outlook.com (2603:10b6:930:34::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Fri, 3 Jul
 2026 13:55:54 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 13:55:54 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v2 11/12] hw/acpi/pcihp.c: convert ACPI_PCIHP_PROP_BSEL from
 object prop to class prop
Date: Fri,  3 Jul 2026 14:53:13 +0100
Message-ID: <20260703135512.3213964-12-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
References: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0120.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY5PR02MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 24575a20-be4c-4fc4-44b2-08ded90acc30
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|23010399003|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: UAziUngrsJ2giVknq9IYBwJvTXmrKq8vonc3NdRWX7tK48SpuoIIzJfZDAYAtaZTESyNBqZRbr9N8DVGDCzk6hRemknJ1GN4bVF2jhuvRG0xO0unkgNdLUwm/PafANwMkFCvEly8RcrTKHmYfFabNRF/GhvjO0K3mcK0DeBTyiFxKyR1ZMVNbKd7rMTa4c3LXeBWfU+/BY/wjrY/HHSqzE3u5Ch7yncq9oqJcDvzNzhJv7zUIb2BnCqz+4RBQopFsg9WOI8nncsq5gotsWL4GQEIQllGNqtRoMk+w77It78l1zL6xYpXWs8yrYdWyefIySoGpEcbBA0P05JiNARWutpwbJ+grXxOC7JkTkfncqVLPKOtUVxelCmKxJOGCCtqH6bCEYfu+7loUFNxzn9A0LVkwD6LOJphULZKKnsGleIdWCVGwCFh9jzsIoRDrlsYnJ9mDNmdkI4fWOOlBFtWOOvslXVYMJgFwW0VR9FXF/wJOz291FFVMcnROS/iy79zgUkt2tXtb28M8qtnMHpBdRQsua/rX0A/p6s3p2v1MBu5S8sik8Aw8EkB5ymNANu9SIQ2qgek5knEaVJV4z+K389w8U25XmUYWI8v1oOQRxw06YwXhjEW9wTCdPg43r3TzQthfRFDCTXWf9rULec4V8rEkWh9JuwR4WjsptjlMdJSEaydVEiatBqbqxaiGAGyotr4buICweZsSvAXMNC47w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(56012099006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fh6MTL6og39lM/IaQu2VgL1ISKKwoafUsS+QVt7wA2hwlH3uxOT6vqIzDckh?=
 =?us-ascii?Q?u+Ju1b29Bqcb/i67/FzDmH8aVKbJGiYi9Iaz8fdM2tCWw2vY6QN0vb6ISKHu?=
 =?us-ascii?Q?gjgmb/R9eaBu/OqaICZWWMYfP2214lU2W9jZuSmn2RK0N5dWvrgEv2F6pfcS?=
 =?us-ascii?Q?H+a0FiXPKZJhL3zA6E+gCPza2F90+a8U5A9IEeFzpFCJ5KnJDaq37xMpAkbg?=
 =?us-ascii?Q?TdpIw8hz5tu1pZm9WBkhNqK1UCVv7n00AXsuCb6s48NHmv9Ls6Rik50B5U6w?=
 =?us-ascii?Q?CxCwc+xYemfh7GedT+YoixGGUrp8AZG59AoU96EBdDoIAWzzivUMB5rSnwTf?=
 =?us-ascii?Q?42F3wB9K6fQzmUvZFVBDnrtUHoGKEqet3vtjWWCzaR1KmgV/9NZR0kaqwLUg?=
 =?us-ascii?Q?DrAzw6JJYPkL2LygHQXhGJA9m7P1fCedjO8cEA3tNfQDRDdAc4Q85uMdvY0D?=
 =?us-ascii?Q?o+vYaDtdulj/i68rCusendAA6rVGFV0N2ul4+GFJbjH7WjntusBIfU3bd/qe?=
 =?us-ascii?Q?MjK328GoxxGmyl2X4AzKYpduE19ddQdJVfUtEFaTKkTBw+urFuefSEmooLZy?=
 =?us-ascii?Q?0GkFMRJ/dZpNNmPw1NN6yNGBag4XBkdFPC5o05St3wrGYxsbA3Dqp1Imx8NH?=
 =?us-ascii?Q?IqAmi9bHDjeAYfRC71Oh8hLcgWGbvJ05YpxajCCdl0976Qo1j4taAdZ+RlGb?=
 =?us-ascii?Q?zQF0U18Y7r6iuwqgraLA25cLXshtHRa3igK1I8UQQFa1JpEI40Vigj+whnmx?=
 =?us-ascii?Q?i4E0XnoCK4W0GkqVp8qjRHzs1qfs44k6f8sWAmyANw1i/ar6qK0TKIBe/0aq?=
 =?us-ascii?Q?ebeRVxOohkflGXIW9CpQ4NpobYIzQdoTaxD9I+z3ue4x/R67lxs2D1zKPPtA?=
 =?us-ascii?Q?V2wKsoGX5UPWmFxIHyPYZ3BvhOcZy6aSacfc5BL6cdgF/lM0PighX6M0s1Fd?=
 =?us-ascii?Q?b0JU4vEA+qTlbq6CT4r6PwrX1ebjlDSBSJA5F9nOBlsk6HYsnGNK4Ezhrk6m?=
 =?us-ascii?Q?VGITsxPp4AjJr5ghbZ0QBlCv+kPHOSOv6jtYcnVdsN0H3v+1oo9wP9YuAtnv?=
 =?us-ascii?Q?co5AvsG3aUE+syl+eHl43FKrA4Gfa5iK00ZP/Hy5kLeEX2qNsAiXlnH/qEBQ?=
 =?us-ascii?Q?qnMAdIlJ6hI7GqqiBsNQgIiQrlVQOymo9GOLZMNcFy4VGi4U4p1ptfSn7G+6?=
 =?us-ascii?Q?oDS/y0SPTL4cBMakDxAWork3uvKIR5SPJ7kMu/NKggEuHtfncYgh9bv0mRdC?=
 =?us-ascii?Q?+qzhwrA6UqYWOkrrFo/f8IEXTEi3R0YQ92xGTurNiyYuh3PU1IYjQSpNKE82?=
 =?us-ascii?Q?1EcTt2hex7b0vzNUAdvH/pb+Pu08NcWUtjuK5aDKq3d4A4kGP05wbg4Z7zzB?=
 =?us-ascii?Q?lLQ7JyjzSF/pJxyc0uMYVNYDIueIVY0/HpWFaOPoH6aV5NhzbS3t8SvxZBfC?=
 =?us-ascii?Q?J+TlQ9P1x9AIvPmAezLVRTasKrYF3RxRVapxzxRcgzsbQB/b9Z5mzXCkRePz?=
 =?us-ascii?Q?+YUBvVVSllE9Jvt5t9GApJ6TCBa85mkgBJ6psO5AVoid3wgr5p77x7HyAOyQ?=
 =?us-ascii?Q?jSPR8JgqSJLftDJepzcOjFNluYn9/nFX3CexWQuGiIbwfKp3P8oUTQiFg6nG?=
 =?us-ascii?Q?zszNkEYgKhtMCtBZk3IPNKw/bDQoPfSEcUl4MV5elPiytE2ekfEqifHflunp?=
 =?us-ascii?Q?B1eJ18x5CRJ/dStLYsr1jxyRctQowE5gxUy8JMOZ8zqXqp3dxY8FJRB9amRe?=
 =?us-ascii?Q?eiDfc7prxejioClbN61XbEIaKyf082Y=3D?=
X-Exchange-RoutingPolicyChecked: poki/QHeOFrARDw5dZ6LoqsMddJp/qr8Qyx93LrjTL4xUI3Rh6puXTgs45tXt9QYjMWKHs298/RgNFzX/kQdKptXH1Bq2eJXqygtQxmVYVTkVzViUjxXT9MC+X3OC3cTARu9Ng7QlTJQtWfEfn9McOTdLdJWGB/HAAIXaRwctHX62FFz61RJoNDcDn1+qaTOos/T07I4ZIfC11RVay3RRASIvfmhhrMY3EmMWGOzfW9mnUi4JipwYyJZoKjYqnnkBp9YPrPCRQD2tYKUUFSB9blAsL+GvFq13wfSTd0x5fxY4USe+IYHhyiUo2jVqtdbCKLo1SsAhZiUpFFhvVvWsA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24575a20-be4c-4fc4-44b2-08ded90acc30
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:55:53.2871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXi+2f0AHnsuY+1XUlNiLuXc8p7excjPESywbL1S3iCLolz22a39uwfPfCJIQ5kUs0zI5dPEkhqDH5gu0lP0XSlP/Q6ZsJRZc55T9kFZKl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB9016
X-Proofpoint-GUID: aYDnSt-MRXKqppiv6Pq44Lx_ghzmIcUk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfX4eL86/8sYjZJ
 NeKUQ6WQ4j+rbN5AZ+F0euIp7Tm6H5tcaDZPaVr1q6PD8KA0BPkNEw5HAqkp+EkpQtQ5U+PUQun
 jf0n21anUgIBH/d2hBfZM4KIjX/2DbFYrr+SsWcwQ2QJgjCceET1yVi5vRc5ZRxTZgVruxt/H/g
 MpvlvpZBRCExNy6Et21Ei11uh5HOOG3O/KdqjUZhzblynlStqi2rHbV4Wz1yY1mC5Uuod1yjRon
 /kZ4AMfmzCk+sy3UT7SWEVPMfRVy2OLBl7SoUkm3Zfk1ERBPFzGni/eLlXceV/PNYik83Qt8sq5
 wUiHMrPIoZgUghmaPPjjjBTbNYMda8N2DpqBSpQf8KDNWnEQw8z5pMWTAKmNawBzjhVqGLGWfRi
 8igBMHg7wzmsQKCcNCWcSi5GAKbUG1QpsDtFb3KNtIWJSaLg7QFw8PviZxuuW6/8dIxyDU+j4a+
 tLhlIFH8Ohxs7hmZGlg==
X-Authority-Analysis: v=2.4 cv=HeokiCE8 c=1 sm=1 tr=0 ts=6a47bf6d cx=c_pps
 a=3l++41Tsbfu3Vy6U+n14cA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=P6pLB9acsiBn3nJIo08A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfXxqzX+9hwzyCy
 gn2fhFxQkI1zJpTZauzuDk9ItGr++XXbzDJJKGizqDjy/32dCMwhEuhvIsHVEcJYLK8UVtETJTh
 YkVwHyZq/NDJqs3ussZVZa1hgCrMYlU=
X-Proofpoint-ORIG-GUID: aYDnSt-MRXKqppiv6Pq44Lx_ghzmIcUk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Move the ACPI_PCIHP_PROP_BSEL property to the PCIBus object and update all
callers accordingly.

Since the existing logic checks for the existence of the ACPI_PCIHP_PROP_BSEL
property to enable the relevant ACPI changes, set the type of the underlying
variable to int32_t with a default value of -1 indicating that the property
has not been set.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/pci/pci_bus.h |  2 ++
 hw/acpi/pci-bridge.c     |  9 ++++++++-
 hw/acpi/pcihp.c          | 32 +++++++++++++++-----------------
 hw/arm/virt-acpi-build.c |  7 ++++++-
 hw/i386/acpi-build.c     |  7 ++++++-
 hw/pci/pci.c             | 32 ++++++++++++++++++++++++++++++++
 6 files changed, 69 insertions(+), 20 deletions(-)

diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index c738446788..186a157dbc 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -56,6 +56,8 @@ struct PCIBus {
     int *irq_count;
 
     Notifier machine_done;
+
+    int32_t acpi_pcihp_bsel_val;
 };
 
 static inline bool pci_bus_is_cxl(PCIBus *bus)
diff --git a/hw/acpi/pci-bridge.c b/hw/acpi/pci-bridge.c
index 394a919479..9af939363c 100644
--- a/hw/acpi/pci-bridge.c
+++ b/hw/acpi/pci-bridge.c
@@ -23,6 +23,8 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
 
     if (!DEVICE(br)->hotplugged) {
         PCIBus *sec_bus = pci_bridge_get_sec_bus(br);
+        Error *local_err = NULL;
+        int32_t bsel;
 
         build_append_pci_bus_devices(scope, sec_bus);
 
@@ -30,9 +32,14 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
          * generate hotplug slots descriptors if
          * bridge has ACPI PCI hotplug attached,
          */
-        if (object_property_find(OBJECT(sec_bus), ACPI_PCIHP_PROP_BSEL)) {
+        bsel = object_property_get_int(OBJECT(sec_bus), ACPI_PCIHP_PROP_BSEL,
+                                       &local_err);
+
+        if (local_err == NULL && bsel >= 0) {
             build_append_pcihp_slots(scope, sec_bus);
         }
+
+        error_free(local_err);
     }
 }
 
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index a91f523c93..31822f6310 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -58,8 +58,8 @@ typedef struct AcpiPciHpFind {
 static int acpi_pcihp_get_bsel(PCIBus *bus)
 {
     Error *local_err = NULL;
-    uint64_t bsel = object_property_get_uint(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
-                                             &local_err);
+    int32_t bsel = object_property_get_int(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
+                                           &local_err);
 
     if (local_err || bsel >= ACPI_PCIHP_MAX_HOTPLUG_BUS) {
         error_free(local_err);
@@ -78,18 +78,14 @@ typedef struct {
 static void *acpi_set_bsel(PCIBus *bus, void *opaque)
 {
     BSELInfo *info = opaque;
-    unsigned *bus_bsel;
     DeviceState *br = bus->qbus.parent;
     bool is_bridge = IS_PCI_BRIDGE(br);
 
     /* hotplugged bridges can't be described in ACPI ignore them */
     if (qbus_is_hotpluggable(BUS(bus))) {
         if (!is_bridge || (!br->hotplugged && info->has_bridge_hotplug)) {
-            bus_bsel = g_malloc(sizeof *bus_bsel);
-
-            *bus_bsel = info->bsel_alloc++;
-            object_property_add_uint32_ptr(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
-                                           bus_bsel, OBJ_PROP_FLAG_READ);
+            object_property_set_int(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
+                                    info->bsel_alloc++, NULL);
         }
     }
 
@@ -730,14 +726,16 @@ bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus)
     /* If bus supports hotplug select it and notify about local events */
     bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
     if (bsel) {
-        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
-
-        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
-        aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
-                                     aml_int(1))); /* Device Check */
-        aml_append(method, aml_call2("DVNT", aml_name("PCID"),
-                                     aml_int(3))); /* Eject Request */
-        nr_notifiers++;
+        int32_t bsel_val = qnum_get_int(qobject_to(QNum, bsel));
+
+        if (bsel_val >= 0) {
+            aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
+            aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
+                                         aml_int(1))); /* Device Check */
+            aml_append(method, aml_call2("DVNT", aml_name("PCID"),
+                                         aml_int(3))); /* Eject Request */
+            nr_notifiers++;
+        }
     }
 
     /* Notify about child bus events in any case */
@@ -848,7 +846,7 @@ void build_append_pcihp_slots(Aml *parent_scope, PCIBus *bus)
     Aml *dev, *notify_method = NULL, *method;
     QObject *bsel = object_property_get_qobject(OBJECT(bus),
                         ACPI_PCIHP_PROP_BSEL, NULL);
-    uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
+    int32_t bsel_val = qnum_get_int(qobject_to(QNum, bsel));
     qobject_unref(bsel);
 
     aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)));
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 99490aa7b1..f6e1776ad0 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1181,6 +1181,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     AcpiTable table = { .sig = "DSDT", .rev = 2, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
     Aml *pci0_scope;
+    Error *local_err = NULL;
+    int32_t bsel;
 
     acpi_table_begin(&table, table_data);
     dsdt = init_aml_allocator();
@@ -1243,9 +1245,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
     aml_append(pci0_scope, build_pci_bridge_edsm());
     build_append_pci_bus_devices(pci0_scope, vms->bus);
-    if (object_property_find(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL)) {
+    bsel = object_property_get_int(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL,
+                                   &local_err);
+    if (local_err == NULL && bsel >= 0) {
         build_append_pcihp_slots(pci0_scope, vms->bus);
     }
+    error_free(local_err);
 
     if (vms->acpi_dev) {
         bool acpi_pcihp;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2ee061558c..de196f2f4a 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1197,15 +1197,20 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     sb_scope = aml_scope("\\_SB");
     {
         Object *pci_host = acpi_get_i386_pci_host();
+        Error *local_err = NULL;
+        int32_t bsel;
 
         if (pci_host) {
             PCIBus *pbus = PCI_HOST_BRIDGE(pci_host)->bus;
             Aml *ascope = aml_scope("PCI0");
             /* Scan all PCI buses. Generate tables to support hotplug. */
             build_append_pci_bus_devices(ascope, pbus);
-            if (object_property_find(OBJECT(pbus), ACPI_PCIHP_PROP_BSEL)) {
+            bsel = object_property_get_int(OBJECT(pbus), ACPI_PCIHP_PROP_BSEL,
+                                           &local_err);
+            if (local_err == NULL && bsel >= 0) {
                 build_append_pcihp_slots(ascope, pbus);
             }
+            error_free(local_err);
             aml_append(sb_scope, ascope);
         }
     }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d3191609e2..1521f37658 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
+#include "hw/acpi/pcihp.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
@@ -187,6 +188,8 @@ static void pci_bus_realize(BusState *qbus, Error **errp)
     bus->machine_done.notify = pcibus_machine_done;
     qemu_add_machine_init_done_notifier(&bus->machine_done);
 
+    bus->acpi_pcihp_bsel_val = -1;
+
     vmstate_register_any(NULL, &vmstate_pcibus, bus);
 }
 
@@ -283,6 +286,30 @@ static GByteArray *pci_bus_fw_cfg_gen_data(Object *obj, Error **errp)
     return byte_array;
 }
 
+static void pci_bus_get_acpi_pcihp_bsel_val(Object *obj, Visitor *v,
+                                            const char *name, void *opaque,
+                                            Error **errp)
+{
+    PCIBus *bus = PCI_BUS(obj);
+    int32_t bsel_val = bus->acpi_pcihp_bsel_val;
+
+    visit_type_int32(v, name, &bsel_val, errp);
+}
+
+static void pci_bus_set_acpi_pcihp_bsel_val(Object *obj, Visitor *v,
+                                            const char *name, void *opaque,
+                                            Error **errp)
+{
+    PCIBus *bus = PCI_BUS(obj);
+    int32_t bsel_val = bus->acpi_pcihp_bsel_val;
+
+    if (!visit_type_int32(v, name,  &bsel_val, errp)) {
+        return;
+    }
+
+    bus->acpi_pcihp_bsel_val = bsel_val;
+}
+
 static void pci_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
@@ -302,6 +329,11 @@ static void pci_bus_class_init(ObjectClass *klass, const void *data)
     pbc->numa_node = pcibus_numa_node;
 
     fwgc->get_data = pci_bus_fw_cfg_gen_data;
+
+    object_class_property_add(klass, ACPI_PCIHP_PROP_BSEL, "int32",
+                              pci_bus_get_acpi_pcihp_bsel_val,
+                              pci_bus_set_acpi_pcihp_bsel_val,
+                              NULL, NULL);
 }
 
 static const TypeInfo pci_bus_info = {
-- 
2.43.0


