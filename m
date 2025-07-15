Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4032C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc2T-0002zn-4l; Tue, 15 Jul 2025 05:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1X-0001fZ-3f; Tue, 15 Jul 2025 05:32:32 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1O-0005qQ-QD; Tue, 15 Jul 2025 05:32:30 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F94iUR013681;
 Tue, 15 Jul 2025 02:32:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=iLXjMfZHLX1p13IiEWjkvZZtUgwJ/raqa5D9a0FS+
 mg=; b=O8JpMvC+hSK0FtOWdj65xEL35KIVwejwVxjKLjJFETMxZUklPnOGe/QGU
 Hd05k4CJ3zXEWEK1aqeoavsi6Vq2fgvqOdv0sjZVktbUCrHRx+TJvW+s7uECSQa1
 xdErTz/GNje32L6gAxJhol0kEGE2bNbdABGwsxTQti0AwpxvCUF9vCsvoAB9aUCE
 2qIuO10H+VxwHXcTaxZ3BBQszaNyimK/aT2q2Kg5hxDsYJjrli4uvtveZEbPdhWA
 3yH1jgtsLGR1dT9GSsCi04LqMd9b+kLnA9gNYncsK+EJ9qxhQeNOCtylGCBEYE57
 yjAVklYKmynqAZcdeny7OqEQAMcpA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2123.outbound.protection.outlook.com [40.107.244.123])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47wm1s8243-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:32:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E60jFTxxehzUD4EfkZoTXNs8ydK0fDhM6wA0/uFMpTblMRHm5Gp7e8lIEJPDcGg4bwDla5X7IcLzCtCxQDiAHHRT8IMwJvzdcd0yzJHTzRZJxdA8yOc3cw4KAc1M+NXzoAlfxcqMNceA7lOwmBGcyCnwTH7ZBEVrUI1GNDi+D+mVbgb0u800zVqQqVhGT1v7HjQ4YHlIum7IDNNmrp4dEkD6SZj2y0obddKxcEnLpl6qJun4OLmUAvxcuWrr1yaCgZ9B4s+LQXHzxvEDreOR9ikycsMUC2KppxdoDsWE//hgIb6326Xi0GwZSPpdDFZrLbwHuvQMX2J/H0e+67JPGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLXjMfZHLX1p13IiEWjkvZZtUgwJ/raqa5D9a0FS+mg=;
 b=y7l7HuzRqfYktfUcAvE9cF0rYVUIt658lrlgnD6gqZ+tJV4O3FtaszmhoF1UygcdaNNgRQSJXyQ68SrN5KJvjZAzly+UxVdIA0qNxslH2UElvl6H+hOH22f1p9+LWndb45Dtmuxit7CtI32NoXuh5NmF4bE8EFR7oaBi26/6/TA4GrxGUmRYvHhpGaGkjPhMgBP9PICh30nb+SG2VvuEi0lDhB2R4loCmEX1s8h0hXlih8ysV395UG7ZLpalyrM/iDUwXoBu2Emqh7jw9TK9DGolwuz2hAxgBIU6zSgmDWTzlSo2JiZsc4xXgBt/H9+ax6N/820nj+OeKTdJouUwwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLXjMfZHLX1p13IiEWjkvZZtUgwJ/raqa5D9a0FS+mg=;
 b=gJe3hKigxrYQtKoYndvV7BYjheJ5RirHdWYniWaZtO65BODfDocW5//0u8FnTLXFl7NB43833Gu1+E2/4qoZrsIyL0HjD6lN/DsxmPvlQVfYid0m5nX84IXpPrAaQ2bU5XXBp6Yu8BEHZ5ORO0wLVkB7/AYQm+xKWXbydw4lv8mNu0doQLNwi154/PPwfyht0HZ3nZNFc8avwexq553GXQcBWjLe0jGyTBdZmTRvSK4NQNVSjLHmQwJtuUxzRICg//f23cVDNJMNsF3JphhlUBDPD//7GugOt31wEYslPvAIgCzcLm1CPCz5wV1kYFoPKqRiy1cmka+LHP3mgd14Kg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9770.namprd02.prod.outlook.com (2603:10b6:a03:548::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 09:32:12 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:32:12 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 16/22] vfio/pci.c: use QOM casts where appropriate
Date: Tue, 15 Jul 2025 10:25:56 +0100
Message-ID: <20250715093110.107317-17-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0076.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc24f01-ef11-4f73-1db5-08ddc3827a8a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lhLPAC1iDIBZ1lSlmjW+N5gsTw73n1iOLSXlWpPG0whXnHGjuvfeG24F7TNn?=
 =?us-ascii?Q?lxtGm9bfzh7E20H06Fjt2LDrBFVwPk53C8bWu/UE6JRTgupEsNn2idElG8hT?=
 =?us-ascii?Q?FJ9zff9SOUWr29c+DwESUzWtnWmnRWaYcuwwXpXePsbIEjV1oKTkAeOAjepD?=
 =?us-ascii?Q?7ctCFnXpJ+rRqKI6RmmwnN6Owbl39aoIJTs0W2wl+4yMV0puNXuhyeB8bIvK?=
 =?us-ascii?Q?GA+YZM1AEFRrIkFgBuSaDuICGKcKJp5RKn3bEmEByx0EeeTIWquass7t2cxw?=
 =?us-ascii?Q?4LgMacenVSgP/bb+fRWKAAoCggcNhxgPTFB3LD4WpD72Nwu5JTn7UnCGkJsy?=
 =?us-ascii?Q?6D++9a/NJEH46CDjnIhtliFt+cSBvWAkJl1CIzF34FhvLDBiojGKm3VjyuWj?=
 =?us-ascii?Q?OFEQH6HiwVVlJ7cDQod9LvoahtRnLsL4yyDgXxwCTIw2sbDVWc4Ya0OFaflq?=
 =?us-ascii?Q?ijb1cG7SREfIh0vs6Hk3cjPTmr0awnaH0lATfdCGVWlahFHGs4md1srY30uz?=
 =?us-ascii?Q?jgSPh50ccnPrAYr8FNHEiO+69q4mBQN4ibfOnyAZ2ugl68RCNTaQxhODgZ1f?=
 =?us-ascii?Q?4T7WB2tpp0oEoPl22uBPXvWJu/m82dj6VIm4MrG3YqvSlWehhgGKomVQr5XP?=
 =?us-ascii?Q?c6DHMlGxlC+sR8nSle+f4Cve9lOjsudj2U9raUpMEebl/BfmZ2XqsdZaJmlD?=
 =?us-ascii?Q?JyxkChv0RuqHT5l+tLfWyvKUvvDV09LOW0cW7Mw7lIo39ANwOs+hUcrkabxv?=
 =?us-ascii?Q?DfInvTbBj8yMUsNAvcWQRefKd896d5MQQkz4/OzQRxnJJAys1Q4nUZ8i3AuJ?=
 =?us-ascii?Q?8uWvW2PKlLPv5mTB2TA4g/TbcB11fcFbFA4nAo9yofv+B0PjJ8NeEjWR7f4k?=
 =?us-ascii?Q?NsBmd9LEfS15KFERARU5T8nTkzJ2J+UgHqSdPj+xVHP0j6ppinbmhhwLSbBn?=
 =?us-ascii?Q?el2hho46Cvq4E1ZFdx8m1ggcoYuu3DMsYmQSQKUlTpX4dbq0Ra+WMTWe37oD?=
 =?us-ascii?Q?QZAET9iCjVekjecImqaOWlI2WXaHOcufwYcnUodgW8y+Wk4x9EYBXpm/3aXV?=
 =?us-ascii?Q?dbPsFE34aTQqEpfxzVCWs5VB657tbObnTLrNHsOs8LjlaHGSsk8gAz+DQ/WU?=
 =?us-ascii?Q?hlS3qS46pgDVuHNkj9Q24FNz5Of8ISJUj4+kMKixIxiwIXiwUwCQUFOjb77A?=
 =?us-ascii?Q?ttAzzesEIug02TkFEbjDpidw1iZ/jsQ9l+QQwpP+h+WaHwehfqZzNOuybHoV?=
 =?us-ascii?Q?+seqRsiQ9QVMN3SRiUkAJtDJZ59E4wPMZiaaWtWhB1G0If/FB3ksS17UjXSN?=
 =?us-ascii?Q?notAT55yOp1EeiOk/0+shLY/BfIrP7G2NgvBIxbM/1GwCsBJCiEmTRzkEwuU?=
 =?us-ascii?Q?R+hXn5zOPtyq4upqMrEUYbY566fvD81JI5aYi1nZCedSHznz3gtfpB9mYWyl?=
 =?us-ascii?Q?6X/zOFwfFvI+0zkQdnqjH5sSeqNUV1gwyxCfVs9OgXfSKfiLH8Za+g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wgq300Xy06S8YTt3Lzv3ojF5ziwh18l7zdCj6yDi4lLMZgmh7Y5mD3b9E825?=
 =?us-ascii?Q?CBtpBJF95s9y32u94C5ILHTHiBXJzZOoclhxwuv7HR6S3TlBctRWA2sjeJ4A?=
 =?us-ascii?Q?hD8RlKQTxoceANHLaZgPRn/iZRlhTZkfv8pUfVAweOZBSPAzsiSL2IJ2SX9C?=
 =?us-ascii?Q?xqXj2aOKepYlP5th5MMSvnClgNXlPLwFG6zAxC0YhAbG5QDWwKK5AwK1JuA2?=
 =?us-ascii?Q?f/PY2bscuEn6BJy2/6rd5zZ2sMW/6ZSqTaNWrtmb77DKqKZhqfV2fTyZ199L?=
 =?us-ascii?Q?RWxhjxe/L8qJ3oF5WeKwnhAYREhDNeiasV+aNf8Bg3TYUzlZWDoljFeGthjc?=
 =?us-ascii?Q?c57mVqVzU5VHgGfiXK2M9ncZvO8/v8sON5if/P9nsQxyLcs5gv2OXBUbK/7O?=
 =?us-ascii?Q?ULc1fYFFPLJSX63YCDQyvQbMJ4CSexZRn96QDgtWXqHHURm895Qwxg1EXgF/?=
 =?us-ascii?Q?gNRsoZ4qVQmYrLJ4woVfI9U7GGNSwM1TzZi/yOoNaFMAyDHpXwvDKR3cz/fh?=
 =?us-ascii?Q?r3T1SQRUvPFQK9c2rniQkE/D4/ouiu1yHn+WgAHRNHeZFOA0cJlubijMbquv?=
 =?us-ascii?Q?GGkJprcHPFRqTYgOs3tX+AZgeDGprOCT4lrx38hyMlEShAM8lQ8I8Tt47Lbm?=
 =?us-ascii?Q?FCNDUkOuhNf2hOWBkM9tX3LE6FQm78FjF5XsdUWPZcYyOE/y6GT5wVFq+DhU?=
 =?us-ascii?Q?6SSLOuoxPbNpGcer993j2iGJp7IQHGQUM/gOQV8wdhrENHXa8ZkSka+qtby5?=
 =?us-ascii?Q?+bRtR0zEIbjNnU7MBrWVsjp13mnhxCeaMxhww//49EU12GloTVLhhKakwFMN?=
 =?us-ascii?Q?TW1aG0EpxtU4DnLWY931WhWxkFpjtG+eOWsXpMvEA+cWLq7N6QRfq7V12IvX?=
 =?us-ascii?Q?aPcp+lMGPUTVhUH0E86MAk3wjV30HUNvZmoNmu8Cw6MCXCgAKNs/ZYYJzopv?=
 =?us-ascii?Q?0FbwkK5fv4T+vWnlAHAuBNdHHNhztogNRsxGHlz0EujPP7mISYtq7tPesalZ?=
 =?us-ascii?Q?vl28n3EuZza3hmMMJ010WWzVjS8zMe0tJHVIcQ5QL/q3tWXclEBx4tGRUFhL?=
 =?us-ascii?Q?32k2XenTO8Ol0vfNXcQxdymGkQ7vXOvJT2PEoJKmevRT1Jeb3erbG2x9KIAW?=
 =?us-ascii?Q?ozCo1dpmctUVOLKDOBvODmbDSX02AoW5N++BdTDdIy69muR/1SbhCAEM8ent?=
 =?us-ascii?Q?WmnDchwwXdCIHpT44eHgoNRbJfb5bKxMQCh9i/mV7mZJKisLxqNlfJdSe+1t?=
 =?us-ascii?Q?hp1JNdFfLd9msM50SIYEvIv/ORU/rLenUWAOJicabpQHTQYj6Gs6K1Tmguj5?=
 =?us-ascii?Q?nWKiv4j7Iv5uOOlvFvRrju3E+mk/o6xv1WmogR+UbX+fQrK6NlzhyhrH5NZH?=
 =?us-ascii?Q?eDub5LxYecJ5phd6QS53dDLzg/jHcpKROxfkDyrZVCedDu32nb/Mh2ZhOfy0?=
 =?us-ascii?Q?nAEF0JhOn5bG5aQ6N3CY0D4t2klEqHF3R8S3QkvVl02nT0vns9muXn5Lm5A6?=
 =?us-ascii?Q?R9kFCSNeECi28Z01OKSyNrVPfdvXd6/UWKS8Pd5eypukw8/28lN0TtMjSGKf?=
 =?us-ascii?Q?IYAcaV8BZ7AmQyXSFy703W0Cd97EIoyNKz/PaOVVYZAEzrkLWz2hR9oScYLP?=
 =?us-ascii?Q?r7FYi+tLRAlCpnebyGCwUSQuki6bKlHrpf4EBqgJb6cwdXtilpPXOsFMRSqp?=
 =?us-ascii?Q?uzwtQw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc24f01-ef11-4f73-1db5-08ddc3827a8a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:32:12.7896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dww8JyKwhnuDDULxeZe2Y2xswn61Au5KCQ3lXWuPuFl1XhCEFkXBkKeZcVfKBc7dxAd3LNYmEZlk3dSCSeEFhSOwivn0qITqLHKZoI7NmEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9770
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NiBTYWx0ZWRfX6wID3ojuEv6o
 JQ8oBDcv9cQTlcMkYKn8lo1tI1Vgz87BJtKMpcI1mzkmk00X/gCaOsI4aSrLusqsEzq1RATARvC
 Mk/KQZtmsiFZhPO6Mscda6RJ3InmIJj7RnAbJoYNipwe2321SOBRzMJsTqvRUOyhm1LAerVtb6X
 vnMfxiBYg3whoX5tLvY8BK8TJLu/ZJGIv2a1llN9uJDlocqB+whXRbA5W0SGI9R94jgkOk5M+eB
 Ng3vHWX/LAiQIzfwbhc2x7jFqAdCkrOHXuqf6k65DzoJBqPDR+QmobzPEcHaC9VsColM4DCdaLd
 qxjd4ABt6QAORX0M9ViqNfSto/MFd3obaAZMavivcuAgk6kKZz9+/3E82tHlZe0RGE8wF9QYidw
 mus14JAqUCWejJLrFHGIes90F/TYNR76QDKlLuBqv4fo7JpmVFunpjToLhIPGZltYB5HVgUi
X-Proofpoint-ORIG-GUID: XQZnCszmMDNDvcCfUTnRdnPTi4DHuiFy
X-Authority-Analysis: v=2.4 cv=fZity1QF c=1 sm=1 tr=0 ts=68762020 cx=c_pps
 a=iT0IPLB/rXRz/LGl7erAeg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=d_WJrpXm2LDB4llzgu8A:9
X-Proofpoint-GUID: XQZnCszmMDNDvcCfUTnRdnPTi4DHuiFy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Use QOM casts to convert between VFIOPCIDevice and PCIDevice instead of
accessing pdev directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/pci.c | 202 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 120 insertions(+), 82 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1093b28df7..fb9eb58da5 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -119,6 +119,7 @@ static void vfio_intx_mmap_enable(void *opaque)
 static void vfio_intx_interrupt(void *opaque)
 {
     VFIOPCIDevice *vdev = opaque;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
 
     if (!event_notifier_test_and_clear(&vdev->intx.interrupt)) {
         return;
@@ -127,7 +128,7 @@ static void vfio_intx_interrupt(void *opaque)
     trace_vfio_intx_interrupt(vdev->vbasedev.name, 'A' + vdev->intx.pin);
 
     vdev->intx.pending = true;
-    pci_irq_assert(&vdev->pdev);
+    pci_irq_assert(pdev);
     vfio_mmap_set_enabled(vdev, false);
     if (vdev->intx.mmap_timeout) {
         timer_mod(vdev->intx.mmap_timer,
@@ -138,6 +139,7 @@ static void vfio_intx_interrupt(void *opaque)
 void vfio_pci_intx_eoi(VFIODevice *vbasedev)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+    PCIDevice *pdev = PCI_DEVICE(vdev);
 
     if (!vdev->intx.pending) {
         return;
@@ -146,13 +148,14 @@ void vfio_pci_intx_eoi(VFIODevice *vbasedev)
     trace_vfio_pci_intx_eoi(vbasedev->name);
 
     vdev->intx.pending = false;
-    pci_irq_deassert(&vdev->pdev);
+    pci_irq_deassert(pdev);
     vfio_device_irq_unmask(vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
 }
 
 static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 {
 #ifdef CONFIG_KVM
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int irq_fd = event_notifier_get_fd(&vdev->intx.interrupt);
 
     if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
@@ -165,7 +168,7 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
     qemu_set_fd_handler(irq_fd, NULL, NULL, vdev);
     vfio_device_irq_mask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     vdev->intx.pending = false;
-    pci_irq_deassert(&vdev->pdev);
+    pci_irq_deassert(pdev);
 
     /* Get an eventfd for resample/unmask */
     if (!vfio_notifier_init(vdev, &vdev->intx.unmask, "intx-unmask", 0, errp)) {
@@ -243,6 +246,8 @@ static bool vfio_cpr_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
 {
 #ifdef CONFIG_KVM
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+
     if (!vdev->intx.kvm_accel) {
         return;
     }
@@ -253,7 +258,7 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
      */
     vfio_device_irq_mask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     vdev->intx.pending = false;
-    pci_irq_deassert(&vdev->pdev);
+    pci_irq_deassert(pdev);
 
     /* Tell KVM to stop listening for an INTx irqfd */
     if (kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
@@ -309,7 +314,7 @@ static void vfio_intx_routing_notifier(PCIDevice *pdev)
         return;
     }
 
-    route = pci_device_route_intx_to_irq(&vdev->pdev, vdev->intx.pin);
+    route = pci_device_route_intx_to_irq(pdev, vdev->intx.pin);
 
     if (pci_intx_route_changed(&vdev->intx.route, &route)) {
         vfio_intx_update(vdev, &route);
@@ -326,7 +331,8 @@ static void vfio_irqchip_change(Notifier *notify, void *data)
 
 static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 {
-    uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+    uint8_t pin = vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1);
     Error *err = NULL;
     int32_t fd;
 
@@ -344,7 +350,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     }
 
     vdev->intx.pin = pin - 1; /* Pin A (1) -> irq[0] */
-    pci_config_set_interrupt_pin(vdev->pdev.config, pin);
+    pci_config_set_interrupt_pin(pdev->config, pin);
 
 #ifdef CONFIG_KVM
     /*
@@ -352,7 +358,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
      * where we won't actually use the result anyway.
      */
     if (kvm_irqfds_enabled() && kvm_resamplefds_enabled()) {
-        vdev->intx.route = pci_device_route_intx_to_irq(&vdev->pdev,
+        vdev->intx.route = pci_device_route_intx_to_irq(pdev,
                                                         vdev->intx.pin);
     }
 #endif
@@ -392,13 +398,14 @@ skip_signaling:
 
 static void vfio_intx_disable(VFIOPCIDevice *vdev)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int fd;
 
     timer_del(vdev->intx.mmap_timer);
     vfio_intx_disable_kvm(vdev);
     vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     vdev->intx.pending = false;
-    pci_irq_deassert(&vdev->pdev);
+    pci_irq_deassert(pdev);
     vfio_mmap_set_enabled(vdev, true);
 
     fd = event_notifier_get_fd(&vdev->intx.interrupt);
@@ -422,6 +429,7 @@ static void vfio_msi_interrupt(void *opaque)
 {
     VFIOMSIVector *vector = opaque;
     VFIOPCIDevice *vdev = vector->vdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     MSIMessage (*get_msg)(PCIDevice *dev, unsigned vector);
     void (*notify)(PCIDevice *dev, unsigned vector);
     MSIMessage msg;
@@ -436,9 +444,9 @@ static void vfio_msi_interrupt(void *opaque)
         notify = msix_notify;
 
         /* A masked vector firing needs to use the PBA, enable it */
-        if (msix_is_masked(&vdev->pdev, nr)) {
+        if (msix_is_masked(pdev, nr)) {
             set_bit(nr, vdev->msix->pending);
-            memory_region_set_enabled(&vdev->pdev.msix_pba_mmio, true);
+            memory_region_set_enabled(&pdev->msix_pba_mmio, true);
             trace_vfio_msix_pba_enable(vdev->vbasedev.name);
         }
     } else if (vdev->interrupt == VFIO_INT_MSI) {
@@ -448,9 +456,9 @@ static void vfio_msi_interrupt(void *opaque)
         abort();
     }
 
-    msg = get_msg(&vdev->pdev, nr);
+    msg = get_msg(pdev, nr);
     trace_vfio_msi_interrupt(vdev->vbasedev.name, nr, msg.address, msg.data);
-    notify(&vdev->pdev, nr);
+    notify(pdev, nr);
 }
 
 void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr)
@@ -488,6 +496,7 @@ static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
 
 static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     struct vfio_irq_set *irq_set;
     int ret = 0, i, argsz;
     int32_t *fds;
@@ -530,7 +539,7 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
          */
         if (vdev->msi_vectors[i].use) {
             if (vdev->msi_vectors[i].virq < 0 ||
-                (msix && msix_is_masked(&vdev->pdev, i))) {
+                (msix && msix_is_masked(pdev, i))) {
                 fd = event_notifier_get_fd(&vdev->msi_vectors[i].interrupt);
             } else {
                 fd = event_notifier_get_fd(&vdev->msi_vectors[i].kvm_interrupt);
@@ -550,12 +559,14 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
 void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
                                int vector_n, bool msix)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+
     if ((msix && vdev->no_kvm_msix) || (!msix && vdev->no_kvm_msi)) {
         return;
     }
 
     vector->virq = kvm_irqchip_add_msi_route(&vfio_route_change,
-                                             vector_n, &vdev->pdev);
+                                             vector_n, pdev);
 }
 
 static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector, int nr)
@@ -624,7 +635,7 @@ static void set_irq_signalling(VFIODevice *vbasedev, VFIOMSIVector *vector,
 void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
 {
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     Error *local_err = NULL;
 
     vector->vdev = vdev;
@@ -713,7 +724,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
     clear_bit(nr, vdev->msix->pending);
     if (find_first_bit(vdev->msix->pending,
                        vdev->nr_vectors) == vdev->nr_vectors) {
-        memory_region_set_enabled(&vdev->pdev.msix_pba_mmio, false);
+        memory_region_set_enabled(&pdev->msix_pba_mmio, false);
         trace_vfio_msix_pba_disable(vdev->vbasedev.name);
     }
 
@@ -764,7 +775,9 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
 
 void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev)
 {
-    msix_set_vector_notifiers(&vdev->pdev, vfio_msix_vector_use,
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+
+    msix_set_vector_notifiers(pdev, vfio_msix_vector_use,
                               vfio_msix_vector_release, NULL);
 }
 
@@ -791,6 +804,7 @@ void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
 
 static void vfio_msix_enable(VFIOPCIDevice *vdev)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int ret;
 
     vfio_disable_interrupts(vdev);
@@ -807,7 +821,7 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
      */
     vfio_pci_prepare_kvm_msi_virq_batch(vdev);
 
-    if (msix_set_vector_notifiers(&vdev->pdev, vfio_msix_vector_use,
+    if (msix_set_vector_notifiers(pdev, vfio_msix_vector_use,
                                   vfio_msix_vector_release, NULL)) {
         error_report("vfio: msix_set_vector_notifiers failed");
     }
@@ -845,11 +859,12 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
 
 static void vfio_msi_enable(VFIOPCIDevice *vdev)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int ret, i;
 
     vfio_disable_interrupts(vdev);
 
-    vdev->nr_vectors = msi_nr_vectors_allocated(&vdev->pdev);
+    vdev->nr_vectors = msi_nr_vectors_allocated(pdev);
 retry:
     /*
      * Setting vector notifiers needs to enable route for each vector.
@@ -942,10 +957,11 @@ static void vfio_msi_disable_common(VFIOPCIDevice *vdev)
 
 static void vfio_msix_disable(VFIOPCIDevice *vdev)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     Error *err = NULL;
     int i;
 
-    msix_unset_vector_notifiers(&vdev->pdev);
+    msix_unset_vector_notifiers(pdev);
 
     /*
      * MSI-X will only release vectors if MSI-X is still enabled on the
@@ -953,8 +969,8 @@ static void vfio_msix_disable(VFIOPCIDevice *vdev)
      */
     for (i = 0; i < vdev->nr_vectors; i++) {
         if (vdev->msi_vectors[i].use) {
-            vfio_msix_vector_release(&vdev->pdev, i);
-            msix_vector_unuse(&vdev->pdev, i);
+            vfio_msix_vector_release(pdev, i);
+            msix_vector_unuse(pdev, i);
         }
     }
 
@@ -991,6 +1007,7 @@ static void vfio_msi_disable(VFIOPCIDevice *vdev)
 
 static void vfio_update_msi(VFIOPCIDevice *vdev)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int i;
 
     for (i = 0; i < vdev->nr_vectors; i++) {
@@ -1001,8 +1018,8 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
             continue;
         }
 
-        msg = msi_get_message(&vdev->pdev, i);
-        vfio_update_kvm_msi_virq(vector, msg, &vdev->pdev);
+        msg = msi_get_message(pdev, i);
+        vfio_update_kvm_msi_virq(vector, msg, pdev);
     }
 }
 
@@ -1164,13 +1181,14 @@ static const MemoryRegionOps vfio_rom_ops = {
 
 static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
     char *name;
 
-    if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
+    if (pdev->romfile || !pdev->rom_bar) {
         /* Since pci handles romfile, just print a message and return */
-        if (vfio_opt_rom_in_denylist(vdev) && vdev->pdev.romfile) {
+        if (vfio_opt_rom_in_denylist(vdev) && pdev->romfile) {
             warn_report("Device at %s is known to cause system instability"
                         " issues during option rom execution",
                         vdev->vbasedev.name);
@@ -1199,7 +1217,7 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
     }
 
     if (vfio_opt_rom_in_denylist(vdev)) {
-        if (vdev->pdev.rom_bar > 0) {
+        if (pdev->rom_bar > 0) {
             warn_report("Device at %s is known to cause system instability"
                         " issues during option rom execution",
                         vdev->vbasedev.name);
@@ -1218,12 +1236,12 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 
     name = g_strdup_printf("vfio[%s].rom", vdev->vbasedev.name);
 
-    memory_region_init_io(&vdev->pdev.rom, OBJECT(vdev),
+    memory_region_init_io(&pdev->rom, OBJECT(vdev),
                           &vfio_rom_ops, vdev, name, size);
     g_free(name);
 
-    pci_register_bar(&vdev->pdev, PCI_ROM_SLOT,
-                     PCI_BASE_ADDRESS_SPACE_MEMORY, &vdev->pdev.rom);
+    pci_register_bar(pdev, PCI_ROM_SLOT,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY, &pdev->rom);
 
     vdev->rom_read_failed = false;
 }
@@ -1496,6 +1514,7 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev)
 
 static bool vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint16_t ctrl;
     bool msi_64bit, msi_maskbit;
     int ret, entries;
@@ -1516,7 +1535,7 @@ static bool vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
 
     trace_vfio_msi_setup(vdev->vbasedev.name, pos);
 
-    ret = msi_init(&vdev->pdev, pos, entries, msi_64bit, msi_maskbit, &err);
+    ret = msi_init(pdev, pos, entries, msi_64bit, msi_maskbit, &err);
     if (ret < 0) {
         if (ret == -ENOTSUP) {
             return true;
@@ -1709,6 +1728,7 @@ static bool vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
  */
 static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint8_t pos;
     uint16_t ctrl;
     uint32_t table, pba;
@@ -1716,7 +1736,7 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     VFIOMSIXInfo *msix;
     int ret;
 
-    pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
+    pos = pci_find_capability(pdev, PCI_CAP_ID_MSIX);
     if (!pos) {
         return true;
     }
@@ -1808,12 +1828,13 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
 
 static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int ret;
     Error *err = NULL;
 
     vdev->msix->pending = g_new0(unsigned long,
                                  BITS_TO_LONGS(vdev->msix->entries));
-    ret = msix_init(&vdev->pdev, vdev->msix->entries,
+    ret = msix_init(pdev, vdev->msix->entries,
                     vdev->bars[vdev->msix->table_bar].mr,
                     vdev->msix->table_bar, vdev->msix->table_offset,
                     vdev->bars[vdev->msix->pba_bar].mr,
@@ -1845,7 +1866,7 @@ static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
      * vector-use notifier is called, which occurs on unmask, we test whether
      * PBA emulation is needed and again disable if not.
      */
-    memory_region_set_enabled(&vdev->pdev.msix_pba_mmio, false);
+    memory_region_set_enabled(&pdev->msix_pba_mmio, false);
 
     /*
      * The emulated machine may provide a paravirt interface for MSIX setup
@@ -1857,7 +1878,7 @@ static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
      */
     if (object_property_get_bool(OBJECT(qdev_get_machine()),
                                  "vfio-no-msix-emulation", NULL)) {
-        memory_region_set_enabled(&vdev->pdev.msix_table_mmio, false);
+        memory_region_set_enabled(&pdev->msix_table_mmio, false);
     }
 
     return true;
@@ -1865,10 +1886,12 @@ static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
 
 void vfio_pci_teardown_msi(VFIOPCIDevice *vdev)
 {
-    msi_uninit(&vdev->pdev);
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+
+    msi_uninit(pdev);
 
     if (vdev->msix) {
-        msix_uninit(&vdev->pdev,
+        msix_uninit(pdev,
                     vdev->bars[vdev->msix->table_bar].mr,
                     vdev->bars[vdev->msix->pba_bar].mr);
         g_free(vdev->msix->pending);
@@ -1929,6 +1952,7 @@ static void vfio_bars_prepare(VFIOPCIDevice *vdev)
 
 static void vfio_bar_register(VFIOPCIDevice *vdev, int nr)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIOBAR *bar = &vdev->bars[nr];
     char *name;
 
@@ -1950,7 +1974,7 @@ static void vfio_bar_register(VFIOPCIDevice *vdev, int nr)
         }
     }
 
-    pci_register_bar(&vdev->pdev, nr, bar->type, bar->mr);
+    pci_register_bar(pdev, nr, bar->type, bar->mr);
 }
 
 static void vfio_bars_register(VFIOPCIDevice *vdev)
@@ -1964,6 +1988,7 @@ static void vfio_bars_register(VFIOPCIDevice *vdev)
 
 void vfio_pci_bars_exit(VFIOPCIDevice *vdev)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int i;
 
     for (i = 0; i < PCI_ROM_SLOT; i++) {
@@ -1977,7 +2002,7 @@ void vfio_pci_bars_exit(VFIOPCIDevice *vdev)
     }
 
     if (vdev->vga) {
-        pci_unregister_vga(&vdev->pdev);
+        pci_unregister_vga(pdev);
         vfio_vga_quirk_exit(vdev);
     }
 }
@@ -2049,8 +2074,10 @@ static void vfio_set_word_bits(uint8_t *buf, uint16_t val, uint16_t mask)
 static void vfio_add_emulated_word(VFIOPCIDevice *vdev, int pos,
                                    uint16_t val, uint16_t mask)
 {
-    vfio_set_word_bits(vdev->pdev.config + pos, val, mask);
-    vfio_set_word_bits(vdev->pdev.wmask + pos, ~mask, mask);
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+
+    vfio_set_word_bits(pdev->config + pos, val, mask);
+    vfio_set_word_bits(pdev->wmask + pos, ~mask, mask);
     vfio_set_word_bits(vdev->emulated_config_bits + pos, mask, mask);
 }
 
@@ -2062,8 +2089,10 @@ static void vfio_set_long_bits(uint8_t *buf, uint32_t val, uint32_t mask)
 static void vfio_add_emulated_long(VFIOPCIDevice *vdev, int pos,
                                    uint32_t val, uint32_t mask)
 {
-    vfio_set_long_bits(vdev->pdev.config + pos, val, mask);
-    vfio_set_long_bits(vdev->pdev.wmask + pos, ~mask, mask);
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+
+    vfio_set_long_bits(pdev->config + pos, val, mask);
+    vfio_set_long_bits(pdev->wmask + pos, ~mask, mask);
     vfio_set_long_bits(vdev->emulated_config_bits + pos, mask, mask);
 }
 
@@ -2071,7 +2100,8 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
 {
     struct vfio_device_info_cap_pci_atomic_comp *cap;
     g_autofree struct vfio_device_info *info = NULL;
-    PCIBus *bus = pci_get_bus(&vdev->pdev);
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+    PCIBus *bus = pci_get_bus(pdev);
     PCIDevice *parent = bus->parent_dev;
     struct vfio_info_cap_header *hdr;
     uint32_t mask = 0;
@@ -2087,8 +2117,8 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
     if (pci_bus_is_root(bus) || !parent || !parent->exp.exp_cap ||
         pcie_cap_get_type(parent) != PCI_EXP_TYPE_ROOT_PORT ||
         pcie_cap_get_version(parent) != PCI_EXP_FLAGS_VER2 ||
-        vdev->pdev.devfn ||
-        vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        pdev->devfn ||
+        pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
         return;
     }
 
@@ -2132,8 +2162,10 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
 
 static void vfio_pci_disable_rp_atomics(VFIOPCIDevice *vdev)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+
     if (vdev->clear_parent_atomics_on_exit) {
-        PCIDevice *parent = pci_get_bus(&vdev->pdev)->parent_dev;
+        PCIDevice *parent = pci_get_bus(pdev)->parent_dev;
         uint8_t *pos = parent->config + parent->exp.exp_cap + PCI_EXP_DEVCAP2;
 
         pci_long_test_and_clear_mask(pos, PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
@@ -2145,10 +2177,11 @@ static void vfio_pci_disable_rp_atomics(VFIOPCIDevice *vdev)
 static bool vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
                                 Error **errp)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint16_t flags;
     uint8_t type;
 
-    flags = pci_get_word(vdev->pdev.config + pos + PCI_CAP_FLAGS);
+    flags = pci_get_word(pdev->config + pos + PCI_CAP_FLAGS);
     type = (flags & PCI_EXP_FLAGS_TYPE) >> 4;
 
     if (type != PCI_EXP_TYPE_ENDPOINT &&
@@ -2160,8 +2193,8 @@ static bool vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
         return false;
     }
 
-    if (!pci_bus_is_express(pci_get_bus(&vdev->pdev))) {
-        PCIBus *bus = pci_get_bus(&vdev->pdev);
+    if (!pci_bus_is_express(pci_get_bus(pdev))) {
+        PCIBus *bus = pci_get_bus(pdev);
         PCIDevice *bridge;
 
         /*
@@ -2193,7 +2226,7 @@ static bool vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
             return true;
         }
 
-    } else if (pci_bus_is_root(pci_get_bus(&vdev->pdev))) {
+    } else if (pci_bus_is_root(pci_get_bus(pdev))) {
         /*
          * On a Root Complex bus Endpoints become Root Complex Integrated
          * Endpoints, which changes the type and clears the LNK & LNK2 fields.
@@ -2261,20 +2294,20 @@ static bool vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
                                1, PCI_EXP_FLAGS_VERS);
     }
 
-    pos = pci_add_capability(&vdev->pdev, PCI_CAP_ID_EXP, pos, size,
-                             errp);
+    pos = pci_add_capability(pdev, PCI_CAP_ID_EXP, pos, size, errp);
     if (pos < 0) {
         return false;
     }
 
-    vdev->pdev.exp.exp_cap = pos;
+    pdev->exp.exp_cap = pos;
 
     return true;
 }
 
 static void vfio_check_pcie_flr(VFIOPCIDevice *vdev, uint8_t pos)
 {
-    uint32_t cap = pci_get_long(vdev->pdev.config + pos + PCI_EXP_DEVCAP);
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+    uint32_t cap = pci_get_long(pdev->config + pos + PCI_EXP_DEVCAP);
 
     if (cap & PCI_EXP_DEVCAP_FLR) {
         trace_vfio_check_pcie_flr(vdev->vbasedev.name);
@@ -2284,7 +2317,8 @@ static void vfio_check_pcie_flr(VFIOPCIDevice *vdev, uint8_t pos)
 
 static void vfio_check_pm_reset(VFIOPCIDevice *vdev, uint8_t pos)
 {
-    uint16_t csr = pci_get_word(vdev->pdev.config + pos + PCI_PM_CTRL);
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+    uint16_t csr = pci_get_word(pdev->config + pos + PCI_PM_CTRL);
 
     if (!(csr & PCI_PM_CTRL_NO_SOFT_RESET)) {
         trace_vfio_check_pm_reset(vdev->vbasedev.name);
@@ -2294,7 +2328,8 @@ static void vfio_check_pm_reset(VFIOPCIDevice *vdev, uint8_t pos)
 
 static void vfio_check_af_flr(VFIOPCIDevice *vdev, uint8_t pos)
 {
-    uint8_t cap = pci_get_byte(vdev->pdev.config + pos + PCI_AF_CAP);
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+    uint8_t cap = pci_get_byte(pdev->config + pos + PCI_AF_CAP);
 
     if ((cap & PCI_AF_CAP_TP) && (cap & PCI_AF_CAP_FLR)) {
         trace_vfio_check_af_flr(vdev->vbasedev.name);
@@ -2305,7 +2340,7 @@ static void vfio_check_af_flr(VFIOPCIDevice *vdev, uint8_t pos)
 static bool vfio_add_vendor_specific_cap(VFIOPCIDevice *vdev, int pos,
                                          uint8_t size, Error **errp)
 {
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
 
     pos = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, size, errp);
     if (pos < 0) {
@@ -2327,7 +2362,7 @@ static bool vfio_add_vendor_specific_cap(VFIOPCIDevice *vdev, int pos,
 static bool vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
 {
     ERRP_GUARD();
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint8_t cap_id, next, size;
     bool ret;
 
@@ -2413,17 +2448,18 @@ static bool vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
 
 static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, uint16_t pos)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint32_t ctrl;
     int i, nbar;
 
-    ctrl = pci_get_long(vdev->pdev.config + pos + PCI_REBAR_CTRL);
+    ctrl = pci_get_long(pdev->config + pos + PCI_REBAR_CTRL);
     nbar = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >> PCI_REBAR_CTRL_NBAR_SHIFT;
 
     for (i = 0; i < nbar; i++) {
         uint32_t cap;
         int size;
 
-        ctrl = pci_get_long(vdev->pdev.config + pos + PCI_REBAR_CTRL + (i * 8));
+        ctrl = pci_get_long(pdev->config + pos + PCI_REBAR_CTRL + (i * 8));
         size = (ctrl & PCI_REBAR_CTRL_BAR_SIZE) >> PCI_REBAR_CTRL_BAR_SHIFT;
 
         /* The cap register reports sizes 1MB to 128TB, with 4 reserved bits */
@@ -2461,7 +2497,7 @@ static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, uint16_t pos)
 
 static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
 {
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint32_t header;
     uint16_t cap_id, next, size;
     uint8_t cap_ver;
@@ -2555,7 +2591,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
 
 bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
 {
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
 
     if (!(pdev->config[PCI_STATUS] & PCI_STATUS_CAP_LIST) ||
         !pdev->config[PCI_CAPABILITY_LIST]) {
@@ -2572,7 +2608,7 @@ bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
 
 void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
 {
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint16_t cmd;
 
     vfio_disable_interrupts(vdev);
@@ -2789,7 +2825,7 @@ static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
 static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     pcibus_t old_addr[PCI_NUM_REGIONS - 1];
     int bar, ret;
 
@@ -2837,6 +2873,7 @@ static VFIODeviceOps vfio_pci_ops = {
 
 bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
     int ret;
@@ -2893,7 +2930,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
                           "vfio-vga-io@0x3c0",
                           QEMU_PCI_VGA_IO_HI_SIZE);
 
-    pci_register_vga(&vdev->pdev, &vdev->vga->region[QEMU_PCI_VGA_MEM].mem,
+    pci_register_vga(pdev, &vdev->vga->region[QEMU_PCI_VGA_MEM].mem,
                      &vdev->vga->region[QEMU_PCI_VGA_IO_LO].mem,
                      &vdev->vga->region[QEMU_PCI_VGA_IO_HI].mem);
 
@@ -2902,6 +2939,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 
 bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
     struct vfio_irq_info irq_info;
@@ -2953,7 +2991,7 @@ bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
 
     vdev->config_size = reg_info->size;
     if (vdev->config_size == PCI_CONFIG_SPACE_SIZE) {
-        vdev->pdev.cap_present &= ~QEMU_PCI_CAP_EXPRESS;
+        pdev->cap_present &= ~QEMU_PCI_CAP_EXPRESS;
     }
     vdev->config_offset = reg_info->offset;
 
@@ -3156,16 +3194,16 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
 
 bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
 {
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t config_space_size;
     int ret;
 
-    config_space_size = MIN(pci_config_size(&vdev->pdev), vdev->config_size);
+    config_space_size = MIN(pci_config_size(pdev), vdev->config_size);
 
     /* Get a copy of config space */
     ret = vfio_pci_config_space_read(vdev, 0, config_space_size,
-                                     vdev->pdev.config);
+                                     pdev->config);
     if (ret < (int)config_space_size) {
         ret = ret < 0 ? -ret : EFAULT;
         error_setg_errno(errp, ret, "failed to read device config space");
@@ -3233,10 +3271,10 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
                                               PCI_HEADER_TYPE_MULTI_FUNCTION;
 
     /* Restore or clear multifunction, this is always controlled by QEMU */
-    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
-        vdev->pdev.config[PCI_HEADER_TYPE] |= PCI_HEADER_TYPE_MULTI_FUNCTION;
+    if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        pdev->config[PCI_HEADER_TYPE] |= PCI_HEADER_TYPE_MULTI_FUNCTION;
     } else {
-        vdev->pdev.config[PCI_HEADER_TYPE] &= ~PCI_HEADER_TYPE_MULTI_FUNCTION;
+        pdev->config[PCI_HEADER_TYPE] &= ~PCI_HEADER_TYPE_MULTI_FUNCTION;
     }
 
     /*
@@ -3244,8 +3282,8 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
      * BAR, such as might be the case with the option ROM, we can get
      * confusing, unwritable, residual addresses from the host here.
      */
-    memset(&vdev->pdev.config[PCI_BASE_ADDRESS_0], 0, 24);
-    memset(&vdev->pdev.config[PCI_ROM_ADDRESS], 0, 4);
+    memset(&pdev->config[PCI_BASE_ADDRESS_0], 0, 24);
+    memset(&pdev->config[PCI_ROM_ADDRESS], 0, 4);
 
     vfio_pci_size_rom(vdev);
 
@@ -3262,7 +3300,7 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
 
 bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
 {
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
 
     /* QEMU emulates all of MSI & MSIX */
     if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
@@ -3275,10 +3313,10 @@ bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
                vdev->msi_cap_size);
     }
 
-    if (vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1)) {
+    if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
         vdev->intx.mmap_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                              vfio_intx_mmap_enable, vdev);
-        pci_device_set_intx_routing_notifier(&vdev->pdev,
+        pci_device_set_intx_routing_notifier(pdev,
                                              vfio_intx_routing_notifier);
         vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
         kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
@@ -3290,7 +3328,7 @@ bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
          */
         if (!cpr_is_incoming() && !vfio_intx_enable(vdev, errp)) {
             timer_free(vdev->intx.mmap_timer);
-            pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
+            pci_device_set_intx_routing_notifier(pdev, NULL);
             kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
             return false;
         }
@@ -3440,7 +3478,7 @@ out_deregister:
     if (vdev->interrupt == VFIO_INT_INTx) {
         vfio_intx_disable(vdev);
     }
-    pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
+    pci_device_set_intx_routing_notifier(pdev, NULL);
     if (vdev->irqchip_change_notifier.notify) {
         kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
     }
@@ -3472,7 +3510,7 @@ static void vfio_exitfn(PCIDevice *pdev)
 
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
-    pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
+    pci_device_set_intx_routing_notifier(pdev, NULL);
     if (vdev->irqchip_change_notifier.notify) {
         kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
     }
-- 
2.43.0


