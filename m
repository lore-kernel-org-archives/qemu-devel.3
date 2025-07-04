Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42493C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXh9J-0002VP-V0; Fri, 04 Jul 2025 10:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh8M-0000wh-5o
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:11:26 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh8H-0004qU-OL
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:11:20 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564CA2ge006302;
 Fri, 4 Jul 2025 07:11:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=SOZPaQfj495WEziRfAVvWeBm3xYiiQ/+WzdVz72+y
 DI=; b=w734zG+53/oDGzerrj3CQ5aIkCLlo9EYPbEsH2yX6VqcDWpArepE9i7n6
 MN8kqR25QrLdxuNiQ5DZKOouym2TmIypp81xonTrLTiOeFxi3aLx+/hAp5jJ+CuG
 PyDddxT62XgVxiVPKeB2iTjHpXGqqd7fA56qCFpbNRi32SoPiH5wXKmBrHxndBzC
 /WEQ7HTJru3XmbLA8mgHxq1+bhHTghad4jZSchNXGkX1L0AOY8NAJvYhP/u39kgC
 S3iZz2S2kBIwmeky6NRfaNxsbv47fOIkadgHRh2IQXHoVpnKcKIGHNgTJm4RjP8Z
 xbIxKPyCwxVH7/Uq+DJPlaG8gsjaw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020133.outbound.protection.outlook.com [52.101.85.133])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47jdxb8t3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Jul 2025 07:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhdrQRdQfyJO4y+r8MpwB6X+rYxCMBGWAe08gC7Rk0qpenKYm+2VDLq6mEzekDzw6fMwBxNW2mp6/gYUDXJ/RRyp2jsLkxSEvndrqSL+pYrDxIRz1GjagCmemCst6kQzciHVTIImAVCU0YM487v4Ja9MJARtwPMaQx01AfXwanq+QularyHr+7ZlXPU9Gxm5qhIHvyQIRIMG3+6IKutR9BroDpvRZnTs3OazoBFKcVWXRjxk2I8xop6AxcMA+ZEkL2tkMSqPeL5YpNxKQSHCwLxJZfNOoOlDl3wefqaGFWYkSPy3oVbjrcdaEjzN51C95ce1E7nwlVbuGNm2VuzgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOZPaQfj495WEziRfAVvWeBm3xYiiQ/+WzdVz72+yDI=;
 b=xoMdINDP4zugOGTatj4hoQDBLdRp+eDkNlcISrS9mWZS8gdDr5wR27DiZWKkshFdIsXrbkv/QnysAIsQhaJf+OBueZ3B0meApAzEhxWmP+BA7io/v5lrZv99Aa8R58EF25hjPJOFs3bP/QR0eyLd3t2VeE4p0bUFSiGRQw4SeJNPuIiB9lsrfr7cuszfZox+aZxRnCj+5fu5WEhnEh8q8YSu75kw1TJ3+IpidrsvkNvItCFj60bkeu72/koAuVg1AGQS3ayXXJ7yqpdDVhqm9ZzMGPbnzZLGN7B2s4AWaLEo34wHidzvRD1ElvzLZVFraDNXaqnZkjoEq20540DpDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOZPaQfj495WEziRfAVvWeBm3xYiiQ/+WzdVz72+yDI=;
 b=PcOrpRFPCr1403vCKEOGrIwdX5f4TOQEb/5ABbdz2HS7zuV/h67DV3km5OaCdUixZTkM5ZYBsTK+MkEEEs5p/lhm8LlYeScsHtWJDOmSqdGCC/v9cFTwNKMWb/zDT+Uccd+Jpilh8ZXIWzzBuZ3o4Im42yxVi5GmjJIg9JJSoX86a6HqVnDrqVHPZ9PvjVUfPy/DzKe9kDt8APf/1PPYXxIORNakCNbPY454dltwmciQRU7udtCzt1Ae2Pf/6xSHkCQ+y44zeb1Bpp2IuaHnGl1yo0aidex7yeCx/c9rXyHuNLtq287ArpA45EHz8koSSdOZZeWbe7/NuGTfD81rGQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB9087.namprd02.prod.outlook.com (2603:10b6:208:419::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 14:11:12 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 14:11:12 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 14/14] hw/i386: move isapc machine to separate isapc.c file
Date: Fri,  4 Jul 2025 15:09:41 +0100
Message-ID: <20250704141018.674268-15-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704141018.674268-1-mark.caveayland@nutanix.com>
References: <20250704141018.674268-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0045.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 249d315b-4477-4d1b-2d6e-08ddbb04a1ec
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?12Jo5w943+57t6H4L6I3Wawv21VTLY3Rlc8hba++/A0PzNC1Zw6a7JQqBjVx?=
 =?us-ascii?Q?I79GIGnHtqblpHp8U2kyME2wkXQRus2jsC+anbcZmNjb22pTW70omSmkiQRM?=
 =?us-ascii?Q?aVXh9Cjc4YqF7lHCmfSg3rg2KwcBnMp5NklLGBYgSkXfQowmCRaENWGe64yE?=
 =?us-ascii?Q?2hiQP6WVx/M3Gj07A39CX49OPDaem4NY6KTGAnv4zYYJSuVe3IlW58MnZmiC?=
 =?us-ascii?Q?JIB8UU8Iv0qMBXGt5LzqfS/MfI0PRQnLtnhiIRMQI02LnF7gvT7dY+OffeS/?=
 =?us-ascii?Q?tScqOJQaB6pbTb+ydPNUBRYmCJqC9+FmZSLXLFjblcm5Jzd0KlvDa6S7F/zZ?=
 =?us-ascii?Q?/MgTKmbVmNs3ttvQEovuOC92l13QSzv07Rogp0NfNAU0wNr+fd98FZ+niSyc?=
 =?us-ascii?Q?AIB9IqWxyyNuaA32AkC94ox7QrSv7Sdn+86yYcPB1AVTPAI70U2kKa+tYoAl?=
 =?us-ascii?Q?/81KvCclE8sOdjU+Sojl9YXODghUZmRqnw6silJjuR7GhP6jzxDvzInQ+7at?=
 =?us-ascii?Q?mMvNy0RL408OAJ6c/0OvZuar4+/sMs1/qtS0oVPW4SJAl3gzYuYFSFzhx0u4?=
 =?us-ascii?Q?Mbwz2G294CVHuES9r1MnW1XDWL0DBSVsKB2Pvwllpq8a6KUdBw3KvMnj6Q1I?=
 =?us-ascii?Q?b8IkBFtjtQ0lhfTQYf0vWSrJ/0NPbve/UQDxjOHdoi3vpeWFp2Pf2NonysAA?=
 =?us-ascii?Q?wlEaNljYTNh7dwgiulPlCNoshNiql4rOTmOlPxgYsYd3FIv772yELLTK2WJE?=
 =?us-ascii?Q?3Jjj42ljk9R9V+LpTFRlr6TijIAFvAw08/Ka8/9Y4DO9uHdACSD6X4bQsu1D?=
 =?us-ascii?Q?/fGi+u2tia35fSspdvfAfGat4V2tKUYb/gEkj0xxqCxdoKW0BUpiJFxUcDf+?=
 =?us-ascii?Q?4W/pWeOVo8vfUxw1xeNJrQknghfZ7VE/sCyjMhAVmDON2L9t6GZGwdVpm8T7?=
 =?us-ascii?Q?7WKo/bUxg5VX0NC9LPZcne/PuTS+2elaEfR56s13zdP0wCxBc8YdGGmvo7Ck?=
 =?us-ascii?Q?3yFg8WclBD3O4XrtnW9rUFo5Y6jmOq74YJI3L7IQTv5kZp1ItsC9zCnx9sF5?=
 =?us-ascii?Q?xxITOwCa90TTQ7AL2ns8qZRNbtzyHbNq+MsCOq8NOJNIfoYnRulSzWqgdKGk?=
 =?us-ascii?Q?IxTIXICCm9CzN0kxP4XwSxSVFSRv8nCXEhSOdd1I4I5RR77Hq0XVneywgWaN?=
 =?us-ascii?Q?g9NtTo33cZWxOp3p6fI4IBaRSrpvT/VDoX+enI4TVTmI+lAORtCSKJJV6Fjg?=
 =?us-ascii?Q?c1hxDya9V46giOXtn9eqc0nLOGtkQvyg43pg32W0NSSMs0EQLj74PbrVb9FP?=
 =?us-ascii?Q?g3NpSpP6pEyypbf1oMJBn+A7vu4CrrSZMZk058bkYEwXEm9yQTkYxrA/z7vU?=
 =?us-ascii?Q?rEJYFXrTgXhUtbX7PJg1KA5KZPDt5hUTSBla8/LUxraw+wuLXeSLi17/Hsmq?=
 =?us-ascii?Q?qOrJkNaEGbU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hmRAS0f7VIgTrZ+XFBH3ywZUPQl7UMnTPe6D92PmXhhjuqNwpaKiYNY8rv7p?=
 =?us-ascii?Q?vWF2sDMiecJHUjXv/aVJZVUzIVbG2KejJTXusm2nphFm4r6XhW/MJqefnxwx?=
 =?us-ascii?Q?luBgYwpOlQfG1oI4Y/yZ8X22szzoOZtqz1jS8BlhffPnKTyozx/dGDdcisKp?=
 =?us-ascii?Q?qNp/tdcLXPDrzjWqOI5H7FsGhxmk1mLZsHbRFORJBz/GxHBrV0MCPZ4pHcqd?=
 =?us-ascii?Q?L2Vnfi5K/LHVH2tXYjhSMPWw4uqXiSPO0FEeZT9PnZ8iA5PVcmWc7dIC4Bf0?=
 =?us-ascii?Q?HMgcBpxrUq5n680EJHv+yG8/GTILa2Hg5ltjtR/OgsLZLdeWP8xykYslQqt4?=
 =?us-ascii?Q?q3SN0xIFWmMrIE5QEFkhUlQ16l918wBL5MzQxxQkONnCUfbAy7im4jq+0gn3?=
 =?us-ascii?Q?r8C/dMdWvF1fGdCjGnZ7tiTno0PUpPDh0RxmkdeJN1pFIhJvoocfPgQkiyNx?=
 =?us-ascii?Q?sPIxMt2Kg7ePbn1pLK3HdW5Yd3GJV0eZ0cNdmfa1PQTASU16PDIm6O4SFGro?=
 =?us-ascii?Q?ZB19NjoWVXInlp5OoF09JrAvqp+eihbVHhZJ+IfsbgPKx0C3P4TmzF/gfJ3Q?=
 =?us-ascii?Q?QmL/YEwXdxRxJpDyMtybGNM6A9WfZadEKbsBY304N9LXs9uKZyGs/FPOnDw+?=
 =?us-ascii?Q?KpR/cy2gHY5Dxq0HRXguijYDUaM934kF1vQLa4ytOCNpkaP8lalt7uLAvBD6?=
 =?us-ascii?Q?F9CCVNe/D7gwy4uxj8yBE+fTTb/rv4sJuo31sMoWOh927N8IvVGSd/47cPXm?=
 =?us-ascii?Q?IOa7bqRvcmT1LcUuY7o4sRXDQ1psb5EaEkk4ZHJl6fVAOYi9qElcdRVOrUub?=
 =?us-ascii?Q?C1MEo2Aawjqz7gP8bLZ3MAuUVKsQq+y805J106Wj20RnDVWkRXC/u8s11BnC?=
 =?us-ascii?Q?2NGHrO/CjaritCVQ79YoaIbP8uEvz4B6nUXvqXjdmwQrBQqjNMIMrYH+JHhH?=
 =?us-ascii?Q?I79baIjuGDGNALl2Mghj0wLg9esrinjgOtsx/Ln60+533i9s9kULa0/+uzgj?=
 =?us-ascii?Q?pCzUTjYYBZUyXYuusoTpzp/Q7CnIBvNXzQt8r8u7s1W1u34BVPtyZtUXmlp2?=
 =?us-ascii?Q?9Qsp/9WXYHYGBPLJnH0HA3gywqOz4zyVPy4+SdH15afk+RumFycQ0fYJIyeS?=
 =?us-ascii?Q?/A6B5CJMXzgqFcfIS42+G3CGQJhLt1G86nURe7jG99nPJrPaYpoNt6VEMVBs?=
 =?us-ascii?Q?jeaYdJzA5IQ9+mIuaVro2+WMiOl4EZPdeSbb3WHOismRpZKDw72OMkynvryI?=
 =?us-ascii?Q?AVA+/MnykYxsyNcFlx1GkySY1YZnfhv7KtM2j06l15SqgSk79RAmkU8gkI4J?=
 =?us-ascii?Q?kBrBlFjGldbVtI3gFHOdOgOzmt5ffnCILnI9W17Gz22D6qBnhtlnGN4Up2Kf?=
 =?us-ascii?Q?A82j2z/PXWeJVKpb6J2Eh9sMAc8NwRe3+Zi6FHQAClvq1pbj8+QbBVFcRQeJ?=
 =?us-ascii?Q?FGKC9jRpmdFT5QmgwBBWBqaGVpWROEJtW+fR23MQ+2GwcmdeaI5kWCFwGrcX?=
 =?us-ascii?Q?TovonQAr18JCsTvM4k6/AKswUU4sUfZZLnbapoMDrgz0dX08nZpT/mv7CYEd?=
 =?us-ascii?Q?QIsFtWn0hVHbH/ZBkXRTRgsLu6eFwYPzPhRoWVGHjHi17SpDE7AV2qn+LEAD?=
 =?us-ascii?Q?v0Ft0mnOxOxyQmQLgZsDVWTQRYEQc9PcFRCURwSXmnxH2wYcywFB6hM+XjrL?=
 =?us-ascii?Q?71DsnA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249d315b-4477-4d1b-2d6e-08ddbb04a1ec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 14:11:12.8357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPF4UGlOXwAQAxvbI8CyXKJpXPykzhdWomj6CB18h9rB17KYxT9CCEq6gn57W+9pKqV8QIfu8g0KAoBer8E2Tb6PvYef8VHBAUt9USDuHB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9087
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwNyBTYWx0ZWRfX2f+jKB+FLlZ9
 yLJ1443DSbb71hu60hrkKcVxR8ByBRCHLN6kqQaqQZnbv/oi9Sj5E8B901PhpG4pxpsEDciSCk3
 5a9uPzOT5BUFCjGfuFG3rGPqHlkORDIVhMFpjPywQVzbeEXhLH6zTXNbBNHA4hgDLkLtGmyK7EJ
 ZfaTjmziiDAALLuyrM1qLqRKVnJaMhCoUHrwWjB7dq3maDinJHf7DHqGUXGiru2ZVBDZ/FslWwv
 DAdpeJaB6I0IxkIYCYfrWJV1r3vog4dyjwksOmyLhdbFq5ZfPqVg3SmY+ysT7H3SHOGJ+7aI+ES
 9PhgqZ9+pyE0SIacKA2EBeQ6j4otszeoaRlWVRCNMM6jNsDhBTTZR94S0y1no0c6uO7uZlBqePe
 O51bKnXVlPXWuZm3aqXQXY51G7FhMf/b4uetN1gdbH23kZROELMFEe0ehNsHDEEImqPPjdoa
X-Proofpoint-GUID: D3Vn1O1D1aQJdKHHmW6MAPcyY_YJn-qp
X-Proofpoint-ORIG-GUID: D3Vn1O1D1aQJdKHHmW6MAPcyY_YJn-qp
X-Authority-Analysis: v=2.4 cv=c+2rQQ9l c=1 sm=1 tr=0 ts=6867e103 cx=c_pps
 a=HNo1bxtHJBcBpsuwJpMK3g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=Pbl5c31VFoorxvNN0s8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218,
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

Now that pc_init_isa() is independent of any PCI initialisation, move it into a
separate isapc.c file. This enables us to finally fix the dependency of ISAPC on
I440FX in hw/i386/Kconfig.

Note that as part of the move to a separate file we can see that the licence text
is a verbatim copy of the MIT licence. The text originates from commit 1df912cf9e
("VL license of the day is MIT/BSD") so we can be sure that this was the original
intent. As a consequence we can update the file header to use a SPDX tag as per
the current project contribution guidelines.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/Kconfig     |   3 -
 hw/i386/isapc.c     | 169 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/meson.build |   1 +
 hw/i386/pc_piix.c   | 148 --------------------------------------
 4 files changed, 170 insertions(+), 151 deletions(-)
 create mode 100644 hw/i386/isapc.c

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index eb65bda6e0..a7c746fe9e 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -96,9 +96,6 @@ config ISAPC
     select ISA_BUS
     select PC
     select IDE_ISA
-    # FIXME: it is in the same file as i440fx, and does not compile
-    # if separated
-    depends on I440FX
 
 config Q35
     bool
diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
new file mode 100644
index 0000000000..5ac077a860
--- /dev/null
+++ b/hw/i386/isapc.c
@@ -0,0 +1,169 @@
+/*
+ * QEMU PC System Emulator
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/char/parallel-isa.h"
+#include "hw/dma/i8257.h"
+#include "hw/loader.h"
+#include "hw/i386/pc.h"
+#include "hw/ide/isa.h"
+#include "hw/ide/ide-bus.h"
+#include "system/kvm.h"
+#include "hw/i386/kvm/clock.h"
+#include "hw/xen/xen-x86.h"
+#include "system/xen.h"
+#include "hw/rtc/mc146818rtc.h"
+#include "target/i386/cpu.h"
+
+static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
+static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
+static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
+
+
+static void pc_init_isa(MachineState *machine)
+{
+    PCMachineState *pcms = PC_MACHINE(machine);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *system_io = get_system_io();
+    ISABus *isa_bus;
+    GSIState *gsi_state;
+    MemoryRegion *ram_memory;
+    MemoryRegion *rom_memory = system_memory;
+    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+    uint32_t irq;
+    int i;
+
+    /*
+     * There is no RAM split for the isapc machine
+     */
+    if (xen_enabled()) {
+        xen_hvm_init_pc(pcms, &ram_memory);
+    } else {
+        ram_memory = machine->ram;
+
+        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
+        x86ms->above_4g_mem_size = 0;
+        x86ms->below_4g_mem_size = machine->ram_size;
+    }
+
+    /*
+     * There is a small chance that someone unintentionally passes "-cpu max"
+     * for the isapc machine, which will provide a much more modern 32-bit
+     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
+     * been specified, choose the "best" 32-bit cpu possible which we consider
+     * be the pentium3 (deliberately choosing an Intel CPU given that the
+     * default 486 CPU for the isapc machine is also an Intel CPU).
+     */
+    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
+        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
+    }
+
+    x86_cpus_init(x86ms, pcmc->default_cpu_version);
+
+    if (kvm_enabled()) {
+        kvmclock_create(pcmc->kvmclock_create_always);
+    }
+
+    /* allocate ram and load rom/bios */
+    if (!xen_enabled()) {
+        pc_memory_init(pcms, system_memory, rom_memory, 0);
+    } else {
+        assert(machine->ram_size == x86ms->below_4g_mem_size +
+                                    x86ms->above_4g_mem_size);
+
+        if (machine->kernel_filename != NULL) {
+            /* For xen HVM direct kernel boot, load linux here */
+            xen_load_linux(pcms);
+        }
+    }
+
+    gsi_state = pc_gsi_create(&x86ms->gsi, false);
+
+    isa_bus = isa_bus_new(NULL, system_memory, system_io,
+                            &error_abort);
+    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+
+    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+    irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
+                                   &error_fatal);
+    isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
+
+    i8257_dma_init(OBJECT(machine), isa_bus, 0);
+    pcms->hpet_enabled = false;
+
+    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
+        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
+    }
+
+    if (tcg_enabled()) {
+        x86_register_ferr_irq(x86ms->gsi[13]);
+    }
+
+    pc_vga_init(isa_bus, NULL);
+
+    /* init basic PC hardware */
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
+                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
+
+    pc_nic_init(pcmc, isa_bus, NULL);
+
+    ide_drive_get(hd, ARRAY_SIZE(hd));
+    for (i = 0; i < MAX_IDE_BUS; i++) {
+        ISADevice *dev;
+        char busname[] = "ide.0";
+        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                           ide_irq[i],
+                           hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+        /*
+         * The ide bus name is ide.0 for the first bus and ide.1 for the
+         * second one.
+         */
+        busname[4] = '0' + i;
+        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
+    }
+}
+
+static void isapc_machine_options(MachineClass *m)
+{
+    static const char * const valid_cpu_types[] = {
+        X86_CPU_TYPE_NAME("486"),
+        X86_CPU_TYPE_NAME("athlon"),
+        X86_CPU_TYPE_NAME("kvm32"),
+        X86_CPU_TYPE_NAME("pentium"),
+        X86_CPU_TYPE_NAME("pentium2"),
+        X86_CPU_TYPE_NAME("pentium3"),
+        X86_CPU_TYPE_NAME("qemu32"),
+        X86_CPU_TYPE_NAME("max"),
+        NULL
+    };
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
+    m->desc = "ISA-only PC";
+    m->max_cpus = 1;
+    m->option_rom_has_mr = true;
+    m->rom_file_has_mr = false;
+    pcmc->pci_enabled = false;
+    pcmc->has_acpi_build = false;
+    pcmc->smbios_defaults = false;
+    pcmc->gigabyte_align = false;
+    pcmc->smbios_legacy_mode = true;
+    pcmc->has_reserved_memory = false;
+    m->default_nic = "ne2k_isa";
+    m->default_cpu_type = X86_CPU_TYPE_NAME("486");
+    m->valid_cpu_types = valid_cpu_types;
+    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
+    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
+}
+
+DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
+                  isapc_machine_options);
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 7896f348cf..436b3ce52d 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -14,6 +14,7 @@ i386_ss.add(when: 'CONFIG_X86_IOMMU', if_true: files('x86-iommu.c'),
 i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'),
                                       if_false: files('amd_iommu-stub.c'))
 i386_ss.add(when: 'CONFIG_I440FX', if_true: files('pc_piix.c'))
+i386_ss.add(when: 'CONFIG_ISAPC', if_true: files('isapc.c'))
 i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('x86-common.c', 'microvm.c', 'acpi-microvm.c', 'microvm-dt.c'))
 i386_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: files('nitro_enclave.c'))
 i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c9d8a1cdf7..8d0dfd881d 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -71,12 +71,6 @@
 
 #define XEN_IOAPIC_NUM_PIRQS 128ULL
 
-#ifdef CONFIG_ISAPC
-static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
-static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
-static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
-#endif
-
 /*
  * Return the global irq number corresponding to a given device irq
  * pin. We could also use the bus number to have a more precise mapping.
@@ -373,111 +367,6 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
     pcms->south_bridge = PCSouthBridgeOption_lookup.array[value];
 }
 
-#ifdef CONFIG_ISAPC
-static void pc_init_isa(MachineState *machine)
-{
-    PCMachineState *pcms = PC_MACHINE(machine);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
-    X86MachineState *x86ms = X86_MACHINE(machine);
-    MemoryRegion *system_memory = get_system_memory();
-    MemoryRegion *system_io = get_system_io();
-    ISABus *isa_bus;
-    GSIState *gsi_state;
-    MemoryRegion *ram_memory;
-    MemoryRegion *rom_memory = system_memory;
-    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-    int i;
-
-    /*
-     * There is no RAM split for the isapc machine
-     */
-    if (xen_enabled()) {
-        xen_hvm_init_pc(pcms, &ram_memory);
-    } else {
-        ram_memory = machine->ram;
-
-        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
-        x86ms->above_4g_mem_size = 0;
-        x86ms->below_4g_mem_size = machine->ram_size;
-    }
-
-    /*
-     * There is a small chance that someone unintentionally passes "-cpu max"
-     * for the isapc machine, which will provide a much more modern 32-bit
-     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
-     * been specified, choose the "best" 32-bit cpu possible which we consider
-     * be the pentium3 (deliberately choosing an Intel CPU given that the
-     * default 486 CPU for the isapc machine is also an Intel CPU).
-     */
-    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
-        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
-    }
-
-    x86_cpus_init(x86ms, pcmc->default_cpu_version);
-
-    if (kvm_enabled()) {
-        kvmclock_create(pcmc->kvmclock_create_always);
-    }
-
-    /* allocate ram and load rom/bios */
-    if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, 0);
-    } else {
-        assert(machine->ram_size == x86ms->below_4g_mem_size +
-                                    x86ms->above_4g_mem_size);
-
-        if (machine->kernel_filename != NULL) {
-            /* For xen HVM direct kernel boot, load linux here */
-            xen_load_linux(pcms);
-        }
-    }
-
-    gsi_state = pc_gsi_create(&x86ms->gsi, false);
-
-    isa_bus = isa_bus_new(NULL, system_memory, system_io,
-                            &error_abort);
-    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
-
-    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
-    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
-
-    i8257_dma_init(OBJECT(machine), isa_bus, 0);
-    pcms->hpet_enabled = false;
-
-    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
-        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
-    }
-
-    if (tcg_enabled()) {
-        x86_register_ferr_irq(x86ms->gsi[13]);
-    }
-
-    pc_vga_init(isa_bus, NULL);
-
-    /* init basic PC hardware */
-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
-                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
-
-    pc_nic_init(pcmc, isa_bus, NULL);
-
-    ide_drive_get(hd, ARRAY_SIZE(hd));
-    for (i = 0; i < MAX_IDE_BUS; i++) {
-        ISADevice *dev;
-        char busname[] = "ide.0";
-        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
-                            ide_irq[i],
-                            hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
-        /*
-         * The ide bus name is ide.0 for the first bus and ide.1 for the
-         * second one.
-         */
-        busname[4] = '0' + i;
-        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
-    }
-}
-#endif
-
 #ifdef CONFIG_XEN
 static void pc_xen_hvm_init_pci(MachineState *machine)
 {
@@ -839,43 +728,6 @@ static void pc_i440fx_machine_2_6_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 6);
 
-#ifdef CONFIG_ISAPC
-static void isapc_machine_options(MachineClass *m)
-{
-    static const char * const valid_cpu_types[] = {
-        X86_CPU_TYPE_NAME("486"),
-        X86_CPU_TYPE_NAME("athlon"),
-        X86_CPU_TYPE_NAME("kvm32"),
-        X86_CPU_TYPE_NAME("pentium"),
-        X86_CPU_TYPE_NAME("pentium2"),
-        X86_CPU_TYPE_NAME("pentium3"),
-        X86_CPU_TYPE_NAME("qemu32"),
-        X86_CPU_TYPE_NAME("max"),
-        NULL
-    };
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    m->desc = "ISA-only PC";
-    m->max_cpus = 1;
-    m->option_rom_has_mr = true;
-    m->rom_file_has_mr = false;
-    pcmc->pci_enabled = false;
-    pcmc->has_acpi_build = false;
-    pcmc->smbios_defaults = false;
-    pcmc->gigabyte_align = false;
-    pcmc->smbios_legacy_mode = true;
-    pcmc->has_reserved_memory = false;
-    m->default_nic = "ne2k_isa";
-    m->default_cpu_type = X86_CPU_TYPE_NAME("486");
-    m->valid_cpu_types = valid_cpu_types;
-    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
-    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
-}
-
-DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
-                  isapc_machine_options);
-#endif
-
 #ifdef CONFIG_XEN
 static void xenfv_machine_4_2_options(MachineClass *m)
 {
-- 
2.43.0


