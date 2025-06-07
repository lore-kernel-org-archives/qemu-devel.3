Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D65C61CE7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNhA3-00035m-3s; Fri, 06 Jun 2025 20:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNhA1-00034S-CB
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:45 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9y-0006R5-7W
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:45 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556N0Rt9023133;
 Fri, 6 Jun 2025 17:11:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=cTA0UaGQyjYS0LKGNn3//eAGxWer1OE7mkfqMKrWP
 iU=; b=mglQP8W8QCuIhl47qgsUPOwD5POTfs4jGG0U9+o64d8GOuaRhtK9drB0x
 ZSlw1SwEQXHzBWuLdpXe4HpMeAMHDVNB/aWuUBgBumFgSgxpE/rPwA3hHRQZGOrY
 eTE+hKXxfmTYMWR3aOuo03+35hPufB2TJjFcUMzl2HPvo0pxY/bBraL0F6SmuzLD
 +FTk9CoyVHBwUOUTKC0m8yVUXDuigiFVoWMZ3vZ7UCq9ZhPWEAXd1LNlCi7sUqkv
 nPs5mmvYXLUhIpnDKMEr2dBPsTPPLS2FcaD6W+pgsODiC7UvdM8mXVA3cincKUDG
 HFhe2KUdwILZAuvhaw4pcbVhX7fqw==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2126.outbound.protection.outlook.com [40.107.212.126])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 472njsxqb2-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNOdqsjVhmwhAXJDiazITp9bicLKEjeFjr72Q1m9VLZvDBd6G6Vbs+O5/A7zW++f7fepbREcf23IefckXuA/s9rX5y98P4rnL8duR0kU3WXB6/w7Arn+0O7896CPQ0BFr5EdJ4gWS+sMNebskNuf/1auJ/+11evxEoksqrvfeObYMTOvrNLF79e34XTDmE7b0R9iFQ3kP4V59uVcLCKxNYG+miXkBb6W6xLw3hlnIsbqaNPSkB/f6SORIQ9dFqHivzoCSlRqih5pqRKghQkcaWoPC1ksYgDDtkmO+r7efNSKgQWXfPOT9lnQ2Oq6OZyfXzguUufpYONJ6bRp6mcoog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTA0UaGQyjYS0LKGNn3//eAGxWer1OE7mkfqMKrWPiU=;
 b=PydSReU8nuD6FtTFu1c6euRW6pYWj/6kKsBtA2T2/xdDndaqx0WltYJ2iMHX89JmJ6P9MiovjmVZX5/2yroahJz3+2ngDnr+IdLVjxNuekExeAmAf8CKkMjLvfWaU7tqM2L6b9nveBOOlP97NFbLLhGDrnqdcVVSlbcVKwo0NfrfhMlI5B2FEQvztLOI9kskG883hnSgu1OnDWiv4UkEr6f0/rlzt0s7waxq4g7lWCBy1oLEKxt7Ikj/bD+ou9EGN5PhcosakUKSLPpm+ZrtENvdg/OUnGNDeWRm2RdvIsFQMTyFvTlk18ea7urvMhGB7gk7y4grsP8Ul2kZVpNy2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTA0UaGQyjYS0LKGNn3//eAGxWer1OE7mkfqMKrWPiU=;
 b=lQn/JS012gWABRgm7yBT0D8Be6cOMNSGXo5FDJjwPYnN1nnbKdSIyVD4zdV251YjjeIbuHfl190j4HSvVFUw2QgdtED/jq78wBoYgi9is0xt52sCqz9aIWTkWLSuGfBnFQKkaMEMn+EqONWUyO7uBKPvBy9isjoXBetV1LEtKDtvUrOb4868fG6pa7L74IOSLRjYfvhJ6cyyu0FPU+9hA1H7r+rq8u3ZHNcpvFJ75ZizT8pJmbb4HFtfrs72WOg95JpZ9VNSw2qN7FyYo2+gwRGFXINjijWaM2p9F8ZEm2XlkNbU9dOn4ahxBpRLtiaY3TWDeiGxAvcyZnIRE3rtYg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CO1PR02MB8441.namprd02.prod.outlook.com (2603:10b6:303:154::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.17; Sat, 7 Jun
 2025 00:11:27 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:27 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v3 20/23] vfio-user: add 'x-msg-timeout' option
Date: Fri,  6 Jun 2025 17:10:52 -0700
Message-ID: <20250607001056.335310-21-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607001056.335310-1-john.levon@nutanix.com>
References: <20250607001056.335310-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::19) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CO1PR02MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: b213150d-49e1-4e57-c888-08dda557d8e7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5Z58ff8vLwl7yIg/+kjnDnBxvDRqA76tucVbdxG2ZyU9982/VetE3Si8d1vt?=
 =?us-ascii?Q?iXF/FmbQnLsOHvRDE0T6VcWSw8GKMiy1Uof53nkyAJR2/vJZzM+YRXA2G1ip?=
 =?us-ascii?Q?Zs67+gQHCl5xH8nWk9Q6Yj04bZur1W4LwtXggFr7EVZbanmfLMDHVjMCrFrw?=
 =?us-ascii?Q?SQn+H/78KyuDZbdKpUDv8krVZ6I9kuOz9ZiJAn08MZ/PfuIo3D4/K2SYrDJ1?=
 =?us-ascii?Q?tv5FkEt/bl0eJo3o3l0nZMWim+ri9tgRB+VuoAfNnjfq+INzDLvlRWQhLuYs?=
 =?us-ascii?Q?rjHASUNX8bvIqHFXEMDaQtMxmlRVMOaohVotyhAUgySU/odKJ4ReOhS9jD6e?=
 =?us-ascii?Q?kfH8m23UYaCA3pu55zzNTfAF5NANe0Wxjy97Zm7wxaLVNmyCfOortwA763vF?=
 =?us-ascii?Q?niQybJ+IJV/Qi5R5pcA4h+1padYVOLUqxBhjt0H+yegAy3+lz1dhttooUa+J?=
 =?us-ascii?Q?rmWIr37E3bysecRJndQrWRQrZP7FvPhcIlJlj7bylZBmv9zHHcjNkaG7RnUi?=
 =?us-ascii?Q?BgSwukdHisFg4Fk0hdatypJsLuK56oHUFGFuY26Sm4AfnKQabcF5uIt0CiuZ?=
 =?us-ascii?Q?4gfSGfdf68RE0Z6Wjgjizsz+v5TWc5elVsDq6kDqJCxYc22/rMc+98jJTi6N?=
 =?us-ascii?Q?gU+o1qzsTSWrNqgccq7lM9OzqNjGsXPRLM5nqHxVw/8In5Z+dOBL5vaDKfIg?=
 =?us-ascii?Q?6rVx4d3B1kYeGtW/8uDa9jnid+RQ5enySL/QdAaEpsOzx0T/+fEhWHVtVGNt?=
 =?us-ascii?Q?qR0EUI5GrzfOnaRxcjLkS+i5lOvN+BKD5HaGOYH5vmqN0E4e1frLA7lEigU/?=
 =?us-ascii?Q?Vodt2aiA9DhTdwbUieVNyZwDsloc1DF/Oxoiqe7oz4e52/tSYK4dzLRTCWpB?=
 =?us-ascii?Q?4pHqlolHYeSwOMbfWPpWfEJX7Ikr5HAJDB6o9CY5QgrpxdL9xhFfET7qVooA?=
 =?us-ascii?Q?XKID5HtE9qplXe/bNSHrDtgGpsPBE/jFqBaT4ZyT9JVQgbSmDdcgZ5PlvibZ?=
 =?us-ascii?Q?SMzJRMVVcD5B1tFmytHSz+FOouKIE/0cTUIA0ncA7LRNnJqY3Q68m/6YY6Uj?=
 =?us-ascii?Q?pXY+IDnu5+pldhBFFXL5+9er5XzcNeKEEWnpfOZfT8hd+tJqoYeMgswDBt4N?=
 =?us-ascii?Q?FuEz7A/Yv+anDuDMEQ3ODjrEBHpHXpIzq8Lf280dBHmL6yak6tZZEEwu0snF?=
 =?us-ascii?Q?aUQnxrTBFwQZ+7UfDKn7UaFDPILYNFOy3bi3YCI2p2HwJKSYgcGDsAPcQpbC?=
 =?us-ascii?Q?Fknn1NxuNfYRPct+BmdJfaLbabbfgf2Tdxe5ME98DSg5ij9y7jg/82hgnZzX?=
 =?us-ascii?Q?Zck7v6U3ja6CE6ALDdOM+33Xo8sbX1xGw+5kvpJxTgk7iC3yJJz3WqXiBxkl?=
 =?us-ascii?Q?qZHFsvAlY0hkSZOIqGOAc2w67l4dNp81pOZFFndH4LcGpFfaJLSpH1DLLxug?=
 =?us-ascii?Q?V38/bCMSM1c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Op7o//2klBnxBGxn6wn6V5H+RIXW0Ak6Hmf1fgHYJDdIL7KL9Q0flvLkNjlw?=
 =?us-ascii?Q?2/QfF+gDSSGc+3owqJwp3L36Q7UBUkI7kwEcJRyWZXHosZknaVF+C8hQ4vsc?=
 =?us-ascii?Q?thmnD61iPQmMcO+BPM8Pc6Lm0D24SuxwJ/ItyV3qrgLYyyn8lHTM0xLXjBjH?=
 =?us-ascii?Q?rNcOynuI8ZEXLyAK1H8rfzwJVPeAk+u8P1Kdh7A5EqqK5xpK3Kk3+ioLWZ1Q?=
 =?us-ascii?Q?1wzpaZYmxBJystn9RXM/PyxAEU3PDJw0Y7hfSt/pyXxmHP9RXd+O6d50Z4el?=
 =?us-ascii?Q?A48PpHQ4x3Gre4D9KOOo8LZgvAG2TDYtll9u9pMoS4dwyoHF6BNlWOHobvXq?=
 =?us-ascii?Q?fXOhLQgtc33zSi2SCUkWi3doIYIEY5jopD9Ly1w4LWw3U0tiAyULjsZkeBDw?=
 =?us-ascii?Q?8wI7kLF96bnVNcftr4qikAhBg5kgK9MfyIfBNBbWvKMBzzSLgV74BQ+FNpvN?=
 =?us-ascii?Q?lwXUEZnKg4GrKg5Yem2pRpwvyJsr1FT3sWM5YVEm7vt+Xm46mhb9Iy4chOqX?=
 =?us-ascii?Q?6BYw6VHsJ7c4gwzswQvItRp6jvoe/h3jo6n90HahlGjWAVRCIN4hPoWWwFvN?=
 =?us-ascii?Q?7aHB4sMvLzH85Rp0GBRvAe2G3EHKc+JflhUU6qof3dlA4xizQgOFSopw0VvK?=
 =?us-ascii?Q?5RzrBwExYkMjspHULSXJr465W33lO0BgL+Wq+wMukq3VmmDnekLYeV2WqPOp?=
 =?us-ascii?Q?YELSPjvpl68BHTGfTtdQuaXPwEt1oFRZWRqMi3H4tu8J/RcjgGgzZGDxkQUS?=
 =?us-ascii?Q?roKdWo4Wt2iElzCXqlhasbrj2lXFwEH7YAuuR1EG9+4dBnvFyEeS8qlqXG5i?=
 =?us-ascii?Q?3VVZNKnGKBiajgIEewU+FIt6R+vNLLsNR/cDLzfjlBscLVi2/EUxxMI4CCUv?=
 =?us-ascii?Q?dCLooRzpT9RiN/UjxI6z08hKqR2aX9LYjnqbbA3EdRxFD/SXpNbVeYeCPQQh?=
 =?us-ascii?Q?AbRpfXkOhiuPP07MQCKXOdBJDUAhl+zsCAvwSvUNLKE8NFwPBtKq/8jw49ac?=
 =?us-ascii?Q?Pn2XqIBxDQS7ksOf+61yng0FJs1AkPRvSnzTD2AnTtJdiDcjzjzVjNnNQXPC?=
 =?us-ascii?Q?GjLZmyPb/erksD8q7w35+G8xMLWqz5Y7xtcE5A+KxEGZGx2nEXDku+uxqWIZ?=
 =?us-ascii?Q?dmAT0KKdKXZAbvkJL5qKasRx62iLOfZuopxGLO1cOM6HWKpeEHxEU/OP173s?=
 =?us-ascii?Q?V2M/fuAQCc0l+Xk7LFSkGui7fVPUcH1/2Plrszf0eb8AAGDoOz+ae4HV+ApP?=
 =?us-ascii?Q?xDysjtQLrdM9amDUlGpLhs7QBmeEu1CefsUz8RjGDF+wOe9HYKFCzpF8v55N?=
 =?us-ascii?Q?8I/yYibA3onUqBrPpYhBNZOOkC5P6rwICUGITEdGAH3Qvou9IqCyvdCq5sJ/?=
 =?us-ascii?Q?UyFIbYTIVHYwk6LBdD8OyfWugDg+g6mfjrtkKBbWPqmF3HzWTLHqRrY5AMpv?=
 =?us-ascii?Q?BKSQ1xolIhz90EAh5X4HwX6TukcAH/WVVxdnhrkd7cBxHtcXHJmL2u/dN8JU?=
 =?us-ascii?Q?El1U7VHyPi7DeAMXc+EEy4HPpd1ZJtA+Byq13reVHNO+Rt2eZWFtNoBMH6wb?=
 =?us-ascii?Q?VbDRfNIbfIjr64OVfirsSS7RLeHTiTY6MNRPDllv?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b213150d-49e1-4e57-c888-08dda557d8e7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:27.7606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FieD2QTozSysIkJ2FhA0k99h3JiW2m1JSMPJUtxaDOtnV0tqiOTA18FAc0uDDAYWOg8RTe3H41uSSd9qyBh+Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8441
X-Authority-Analysis: v=2.4 cv=f9JIBPyM c=1 sm=1 tr=0 ts=684383b2 cx=c_pps
 a=JomqzcHDjT5Ni/tnCvtrfQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=Ql6ANm6PklPDYutWWPYA:9
X-Proofpoint-GUID: sM1w5dSBsSozwz6TbkIp_8AjEn9V0O8m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfX16aR1Lt/uhvp
 Lkr1qB/4vthXiWiGB5UdNxHgcFHz4zRdWF2ezzeYOB8lwFjygJcJsNGIGHdOwvJIoZPnUbhyMWq
 I/DN7Fe2Pr+/CkSmvD4yQ1f2eiIHTHomBx9khOhNIcaNV2bCHxMXe+1YPOd4BU0efHKRu5mRegB
 Zhq8mxzHHuK+9C/r7vEuVQW10QcY9FTsc9/Tnr/9JvJXE73gxTBIOdP99pK+nVsjIcwZ0YizCNK
 YYWM4wduirBUnwcrWF/dbQWk3csdk+RZsgLnxl/zBfO/EyPqREYgrmq7hConGdgRkR+uJyFIl8H
 ESL8N3SYbZQAD47rC4/rnTGZBEqIeAvQDlCtu65VGaOhnwyj8sJhm+YfniaVS2ZPty9rKWtlf7U
 iAqt7/gbwrzfE+PnHhqo52jXYb+p2p193Hq1YiP+RSRnIgu0ut5K2irwtA/lOVjVFhYuqDt8
X-Proofpoint-ORIG-GUID: sM1w5dSBsSozwz6TbkIp_8AjEn9V0O8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_09,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

By default, the vfio-user subsystem will wait 5 seconds for a message
reply from the server. Add an option to allow this to be configurable.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.h | 1 +
 hw/vfio-user/pci.c   | 5 +++++
 hw/vfio-user/proxy.c | 7 ++++---
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 8f2d529846..da29674fdc 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -70,6 +70,7 @@ typedef struct VFIOUserProxy {
     uint64_t max_bitmap;
     uint64_t migr_pgsize;
     int flags;
+    uint32_t wait_time;
     QemuCond close_cv;
     AioContext *ctx;
     QEMUBH *req_bh;
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 095f32604d..769dd9b810 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -25,6 +25,7 @@ struct VFIOUserPCIDevice {
     VFIOPCIDevice device;
     char *sock_name;
     bool send_queued;   /* all sends are queued */
+    uint32_t wait_time; /* timeout for message replies */
 };
 
 /*
@@ -263,6 +264,9 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
     }
 
+    /* user specified or 5 sec default */
+    proxy->wait_time = udev->wait_time;
+
     if (!vfio_user_validate_version(proxy, errp)) {
         goto error;
     }
@@ -397,6 +401,7 @@ static const Property vfio_user_pci_dev_properties[] = {
                        sub_device_id, PCI_ANY_ID),
     DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
     DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
+    DEFINE_PROP_UINT32("x-msg-timeout", VFIOUserPCIDevice, wait_time, 5000),
 };
 
 static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 0935b72e9f..74cfaff6fa 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -24,7 +24,6 @@
 #include "qemu/main-loop.h"
 #include "system/iothread.h"
 
-static int wait_time = 5000;   /* wait up to 5 sec for busy servers */
 static IOThread *vfio_user_iothread;
 
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
@@ -665,7 +664,8 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
 
     if (ret == 0) {
         while (!msg->complete) {
-            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock,
+                                     proxy->wait_time)) {
                 VFIOUserMsgQ *list;
 
                 list = msg->pending ? &proxy->pending : &proxy->outgoing;
@@ -725,7 +725,8 @@ void vfio_user_wait_reqs(VFIOUserProxy *proxy)
         msg->type = VFIO_MSG_WAIT;
         proxy->last_nowait = NULL;
         while (!msg->complete) {
-            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock,
+                                     proxy->wait_time)) {
                 VFIOUserMsgQ *list;
 
                 list = msg->pending ? &proxy->pending : &proxy->outgoing;
-- 
2.43.0


