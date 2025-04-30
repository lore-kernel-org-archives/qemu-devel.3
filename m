Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1AEC3ABAC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uADIa-0007wN-Gd; Wed, 30 Apr 2025 15:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIS-0007sW-DC; Wed, 30 Apr 2025 15:40:44 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIN-0006CX-Lh; Wed, 30 Apr 2025 15:40:42 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UJ5CYv010420;
 Wed, 30 Apr 2025 12:40:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=c8G705wh7baCQWEEkVRqNGfftJXik+4JIAlCjHjbp
 Bs=; b=GQjJj2HiChwC4uIw9VSjI7gWQ9tDKfVsodLcDUFv4Fq4puhmTv+FMkZcU
 6ZaQaqycVqc9kIt4U29sEJ+lMoMcr5q51aiCyPTTeGKImGtual0F+pf6RJJgkOYo
 sFiCh2ZThEyWQim2EdxieCFkH4Dj/GIV1YEthsaEkgD4FghYBrmzGFAoff3s6zh9
 QvGTK2NOBSj3OXdpFSWu2sMZAjVZZLiSSMHJGknx+rN9ilYoMIF94Eo2WzEa5eSd
 Dqrz1SNmt+aSsKPVL1R9AmG3a8kxN50tb8RJmPBhh0DGeK8dhvgHge5+97femAmA
 tu7+YJxGszst5mQSx6qbtySFGcBIA==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010022.outbound.protection.outlook.com [40.93.12.22])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 468y109yc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 12:40:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jb0HyEWcA8o3Kxs5DH+LoB7RGe/4zc0ggtNlsfpGJ7hhQ1DkZ+ntte3OkXr+yxnsgUWgkO2k/Wi+54Cc+lTiRhJ+6WWEJmeL8QSWaGT03Sd5ZS7rlv78Mz/cEbYrx3jPn+nXhgZOSQfJeS4YCKEVnj2ZrKXd3Cc1lzpHFACvJTJGQRpySwI0fyO4zvIvAiocGc4Stw+FM3OScev9Lh3XxQvsxnLqD57wJpSE31oWjYeDIejqG4domGLM3ZzUigs5Uk9MG6/G/7LPPR+zJNrI1/VoZGVUv7Di0boTigw4NESZhq59yPLfx3EWeATHSuqPNaayMbFnWpoz/cp8K0Ypew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8G705wh7baCQWEEkVRqNGfftJXik+4JIAlCjHjbpBs=;
 b=sJkLWMJmr7wXFMXleCipY9GAbUY7A1HsYIxLQ2qCYACnkeI0aBsXGc8eR+28pJGvr/EkmDmPQBl7S3eMXWT9bFIEK5PuTigySEnZ5ZimGQVJpmRooY51mIcWBNquIojMLRMRND70sbBevz3Pha+RiiBbRj5QaZ3DFOZppUjMkmK7BfBk7MSBlvlZbeDIWpDakGXgobCrrGRKc7ZgG1Gt0XM9+KaaOFHYs5pXg2aV8pJkrinhVqwSd7L1tDBsxopZwojDUT/tdBSlY2Uxb+V2P6mxxcbutxCxPzocKmpHqFgUhEUyf9cS6U9cW5S3OFOUZF7wMJ+C8VSN3DWHWZHigw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8G705wh7baCQWEEkVRqNGfftJXik+4JIAlCjHjbpBs=;
 b=vJI5Ka0x3Scl7m4N4PZz9y5t7vqPubsUmme8B5JblWddEHHnMmlsQkTypQbD9Mza0lNkY7tm9sdGAx3sFkujQWYw+oUwjxl4X6slrq+gbho6diQ4xRsodt3jG+28ezz9gTPN3R+lJO7y//WU7hWnMkICiOmYzm/sQ8N9CzQ90MBk1G7iC6VwvCjgJtJD3TO3bpTTTt8shWD7JZ/k+dfk8BWSUgghhZCUHmEmpeE8NPkH0+RRK/ZJ+m0zKQBRbqSLCWUv7CNbE1IACv2CgeEf5bpzGgh2sm1g6etMMPPP8XRSLzJog71pvadY0iu/PmLjuHmrt5SX3ANWZo5UzmDc9Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB9931.namprd02.prod.outlook.com (2603:10b6:610:177::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.9; Wed, 30 Apr
 2025 19:40:35 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 19:40:35 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 08/15] vfio: add unmap_all flag to DMA unmap callback
Date: Wed, 30 Apr 2025 20:39:56 +0100
Message-ID: <20250430194003.2793823-9-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430194003.2793823-1-john.levon@nutanix.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::34) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: aa464d31-4ee0-4eb0-960c-08dd881ee073
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bGHyfnWDSBGG3l9y8fnJuXfmsg7ZfR9bkwv1u6+bLXyq4JuFTuw28JAjm7ZM?=
 =?us-ascii?Q?0NuekV2/hDGW7ZT1b/TJ6pblScopi1iGuOHCsPffKmK6PvTiRhrVxjtNYY7Y?=
 =?us-ascii?Q?ML3kPxLJSb1mtOhkCNpWnyaPoCluTYwCX1sxXUBcM7zhnx1h5TTiDI1WnV1Z?=
 =?us-ascii?Q?L8FhmDeEbyk9k3vZl89p/G8XlKSPblkdJxm9Mwy9kFoJt7+n2cjS3WYq3aWX?=
 =?us-ascii?Q?7q8wdUkhW7cyP17sB42WMkQM1Mw0xbQKceYs0tASm2iuJwt1Xu/9Y8kOBaHS?=
 =?us-ascii?Q?waL4x0ILORyW3L/TD5DPoR2kR7rkI3RgavhGteq4h1hounb3hhQvyP6SxBHe?=
 =?us-ascii?Q?JLXBkWb5085uAHmeKIejbaTl8jSQOfIMIebQ1wEIRmhugdCUi/XNTVikW+HG?=
 =?us-ascii?Q?DjdwihcL6qMrSePy/hQZFJOU2tUlsNo8O2uEWcKtE4Xstnr0Y3cWx/GcM2rY?=
 =?us-ascii?Q?nDcje1NI6g84h30vQJDzF29tsTQ1tahvlJV4hy8w0ZPJ3mU6umZZuZP45oZy?=
 =?us-ascii?Q?X25IvsNgLNSjiaIzNBFGXqMLQ2m6q9y4qfB2frq+wagwPErV/oPxML7BB1Cl?=
 =?us-ascii?Q?LmoQrXzZcsLGGnzSzljkC7/mcliKwWBKl9Hr27pUAlnWG/i3sEjLS0Chh8HR?=
 =?us-ascii?Q?rb0zS6zbE65m1oIC6WoX+lbr1G+36t6IcnQp63BibaDL9OF3YsRprOlIBJIt?=
 =?us-ascii?Q?uJFhlg2dnDiRGiXyfVBEs+pDwiW5UkHpqHwH4VVCmiy9AHJ370/UIucD6V1i?=
 =?us-ascii?Q?9SNE+nZSd0KryRep1qmrvt8OT6IyMIsuY9xbYq0n0U0f8moTYXyLCGJAoVQ9?=
 =?us-ascii?Q?qH4qhuxaAtmPY+zczl0xacae/Kbu8hC8Yxa0oP+YV5BtAIDpEUq6Jr2u3sui?=
 =?us-ascii?Q?bbZjjVOE3VDiY2r+ZbYYEmTZdFSitYJbeuYm1cWYYzRB+1Ywa4DQUDtuBSJa?=
 =?us-ascii?Q?QJDY+cOLUD9QcicHOe4rlz7BkzrIMzl911D6u0TTTTY2NhN7fUKgPMxNlv9L?=
 =?us-ascii?Q?vtZvSNSEkmAKhhIiKbsDRbjNaMpF5CG5RgBoK7kibprQujvNwSasyE2nPFmm?=
 =?us-ascii?Q?edhC2OYwkr+GR8MtZooE17Gxs7UoQ9qkEhliC7thw7yZtu24Cq85HvWDOjMx?=
 =?us-ascii?Q?qyT8ZXluzjv+2sW0MnZw0umUJrObV6KEeIDpvWG8Yk7ZOqRXhYzyLhKA9Wh3?=
 =?us-ascii?Q?mg7/pFh4HX5VcRLIoxoU4x0Lolc00qURnrcKin60HpxVftDx9vbeAwliD0L/?=
 =?us-ascii?Q?P5Y9FZDXrn8b5VkdDq/EX+hEGWcMBCOQczs20jYMw1AsOfzbxG/GskDJd00x?=
 =?us-ascii?Q?wP3tuTqx/TSJVNNB4p/EAZPJnVthAH1r4IXIjRQZC3OLK5LHQ0pbydKn9unM?=
 =?us-ascii?Q?LWfXJam7JLZwXUuxp8Tcwzil4m+11kCFcHwMg/qG0XH1S6JkzY7xZMvxhYrY?=
 =?us-ascii?Q?BzOso2Lr370=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SSrsecwJP6gG/6ryP1+WRsTkVv0dWsrOjhj0S4o+gDV+Jk86MWWXJDm+heex?=
 =?us-ascii?Q?txUNfA561uzDqLymPtiHi6+0QaJ9H+15bD5H9v21FM31SvbSL6jpwkdV20Fx?=
 =?us-ascii?Q?q/t/ulfFCZVH2cEvQTLGAleXLXILKIXDnCwUBcoFKMQbxO8jh9A8AqkktRXR?=
 =?us-ascii?Q?tcoz6J5O8zQZd9Q31N9l2lysrd4GZNoZ0U9pT7thjr9X0/K5IsdhjNZ/y7U+?=
 =?us-ascii?Q?MqwtDKYO2k1DVx+BBJCk7NcUHGJRWn+zAofvnKn8zEpmqDw5IZV96RN5CcNe?=
 =?us-ascii?Q?yy2pky814FM3NqfH/GgpNusc6NX7sMvvcSlPV6Gd6HgWiS6mpHS6LT+VyyxR?=
 =?us-ascii?Q?Bhptn9Tz/FKmiXfdAbaMEhNkdtpociH1X5BKw3j/j+PaWkRlEj4F4tE24nAx?=
 =?us-ascii?Q?M53pkbRPSICqUoYc65VrczpwE60RnqE4YkriYQWy87s1Z8cR5LX61QEYrG14?=
 =?us-ascii?Q?JqPRxcPxG2DlXJFdvUiIh+W2MFeqzZ1I5R0rYRPd1M3ixX4RrIdtyHaMtTIL?=
 =?us-ascii?Q?Zhow+nSXPfKwU8snhVF7p52+nqN5e2lAIvLr7Z3boXsRbqscKUWeay8tW2x5?=
 =?us-ascii?Q?vcrM2LrE23YQvR4uw75asd1bqtqOvkbgVyQIEnCRvwV1rzQb98e9g+sI/n5/?=
 =?us-ascii?Q?uniUCfVPrrYCLJPw9FAushCd7GQEGybcuu6WukqPI5Kpev3YMSIpGwsoyXw7?=
 =?us-ascii?Q?jGZ6VbWL7J63reT7p9Iz0499EBF5vfzgY4szNip6l/dAe5RdwuPKYPcHQCOF?=
 =?us-ascii?Q?V7HzloABKcMjrkGJ4usoxE/M/OqxOdy4vMXZqJXT8x+tmf6IjvH3pEtnGjF9?=
 =?us-ascii?Q?2Mr4ERDzjCgnp43LSsqtWLlIynUntQWj9BAOHTFjYR1ZaCn+3T9ZGBWWOPNB?=
 =?us-ascii?Q?2Hl94L46PEFi1YjWnO/HxZWRBGX97sJudhgb2lkJt7iEYMg+v8MsFfA/P89a?=
 =?us-ascii?Q?TgMEq5MejdMPklrnXLJDorOOu1DApgHoVWlJFfCwu314NXiQoqR9mUKyxVrX?=
 =?us-ascii?Q?pM9+AFpWiqLb6g58G99jJmP8YJnyRVS2U7d+duXVe7NZp9PctGi/N4LlZqgv?=
 =?us-ascii?Q?kBljUdl1/sIn33AmnJ7DAbjyxM57pqMSCUKhMd9lK9sD1VoyZnO+OP0PiGwe?=
 =?us-ascii?Q?SzNxuIbvWnaQ6+PTcjCW4CBXDqefuLeZ00SjB9u8BXrc5jc/wwiqZPFK6pUI?=
 =?us-ascii?Q?ikd3On5dlz/PXq6TMYg5Yi88EUe/7NkvOHSXOuTBleNfdIG2nhMmU2GSiebR?=
 =?us-ascii?Q?REQBawRPn5j+gXM1q91ctsMMROBL5KgqyUbnM60SysgHNEJtZNVFJ2uwDdno?=
 =?us-ascii?Q?/Tv3y6ZGsQTnvSsZdotgjN6uQJVRxcmh2maKUMKN1RxHXmDpEVPA7fZj77l/?=
 =?us-ascii?Q?+GkDXecXKHyha5XVY5W4PL2LPq6GRLoxohy4CjIuuRXcsLhroGMizAfYJcut?=
 =?us-ascii?Q?hSnCPhlccgqtmyki32vHdmbLHiips9VQkPAtxqMSMduUBVxWkwPwGLasSATY?=
 =?us-ascii?Q?JAvPyBCWraYONql611P7ck+JHFjH57eeKOQGTlW3atBsS9TKQTvhZCmyWx0+?=
 =?us-ascii?Q?FMS5xejidxZsc1YA7e/i551vBDTVQSU6Lvkddbur?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa464d31-4ee0-4eb0-960c-08dd881ee073
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:40:35.3901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apVTRwKJkG5Z4SDalsLpTg/nnDhYpsQGFjVRVPX237Dleufq4yBmYUK6Fm4+10Z0PQ3nHT2lrryI4tBrJO1XNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9931
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NCBTYWx0ZWRfX9gBEVpK6yEQh
 1whWz/Hqeb9Efh77m4yZpjlSiyuy2+i5Agj7qFJWrtqUyoL8fcQzQuC3+1DSZ6BWjhpXB5dKKBG
 MwEsxJmKDp09ZvEWwS6Yy9oSmUSjf2qRIpxgLT8kfZUqMbdjDsf3n+QVNRT4WaS638OygsAL79Q
 UgIp13htqLsdN9kK1BAbxknW3HHFyKi7WeDL8SjYFetikr/DU2kc3zYv4iA0CjHhtTF+84GdgHS
 SwtxXt51I9rsVukE6+gfI9iHSi3LnajcUCTazcXXT+T0PvkBP5ETBmcSKKSe8kxWIV7GFFlwAXQ
 rXTIbf1iOG94/PcwAoTIK0tfEtrDPQNjwbijpIyEpGbTl/f8XaVwwxixCTjft0uWE8sS46f5sCH
 l/UcsXTmmcYnhCLNHHPA2jmUuC7ZBm6+T/v/p78+C2PXOt7uPVIUaXx4BLgztzNIWCXi7xMz
X-Authority-Analysis: v=2.4 cv=MNVgmNZl c=1 sm=1 tr=0 ts=68127cb4 cx=c_pps
 a=tQsPtMi3p37jOgXbkrwZvw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=wam52ssa2_Y8bD6HYSEA:9
X-Proofpoint-GUID: RJFqMh7BVmpDHVJoGZyYakN9klYcBbD1
X-Proofpoint-ORIG-GUID: RJFqMh7BVmpDHVJoGZyYakN9klYcBbD1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

We'll use this parameter shortly; this just adds the plumbing.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/container-base.c              | 4 ++--
 hw/vfio/container.c                   | 8 ++++++--
 hw/vfio/iommufd.c                     | 6 +++++-
 hw/vfio/listener.c                    | 8 ++++----
 include/hw/vfio/vfio-container-base.h | 4 ++--
 5 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 09340fd97a..3ff473a45c 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -85,12 +85,12 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
 
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
-                             IOMMUTLBEntry *iotlb)
+                             IOMMUTLBEntry *iotlb, bool unmap_all)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     g_assert(vioc->dma_unmap);
-    return vioc->dma_unmap(bcontainer, iova, size, iotlb);
+    return vioc->dma_unmap(bcontainer, iova, size, iotlb, unmap_all);
 }
 
 bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 1dfdc312bd..766ba5a275 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -124,7 +124,7 @@ unmap_exit:
  */
 static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
                                  hwaddr iova, ram_addr_t size,
-                                 IOMMUTLBEntry *iotlb)
+                                 IOMMUTLBEntry *iotlb, bool unmap_all)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
@@ -138,6 +138,10 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
+    if (unmap_all) {
+        return -ENOTSUP;
+    }
+
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
@@ -205,7 +209,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
      */
     if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
         (errno == EBUSY &&
-         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL) == 0 &&
+         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL, false) == 0 &&
          ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
         return 0;
     }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 62ecb758f1..6b2764c044 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -46,11 +46,15 @@ static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
 
 static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
                               hwaddr iova, ram_addr_t size,
-                              IOMMUTLBEntry *iotlb)
+                              IOMMUTLBEntry *iotlb, bool unmap_all)
 {
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
 
+    if (unmap_all) {
+        return -ENOTSUP;
+    }
+
     /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
     return iommufd_backend_unmap_dma(container->be,
                                      container->ioas_id, iova, size);
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 6f77e18a7a..c5183700db 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -172,7 +172,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
         }
     } else {
         ret = vfio_container_dma_unmap(bcontainer, iova,
-                                       iotlb->addr_mask + 1, iotlb);
+                                       iotlb->addr_mask + 1, iotlb, false);
         if (ret) {
             error_setg(&local_err,
                        "vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
@@ -201,7 +201,7 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
     int ret;
 
     /* Unmap with a single call. */
-    ret = vfio_container_dma_unmap(bcontainer, iova, size , NULL);
+    ret = vfio_container_dma_unmap(bcontainer, iova, size , NULL, false);
     if (ret) {
         error_report("%s: vfio_container_dma_unmap() failed: %s", __func__,
                      strerror(-ret));
@@ -638,7 +638,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
             /* The unmap ioctl doesn't accept a full 64-bit span. */
             llsize = int128_rshift(llsize, 1);
             ret = vfio_container_dma_unmap(bcontainer, iova,
-                                           int128_get64(llsize), NULL);
+                                           int128_get64(llsize), NULL, false);
             if (ret) {
                 error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                              "0x%"HWADDR_PRIx") = %d (%s)",
@@ -648,7 +648,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
             iova += int128_get64(llsize);
         }
         ret = vfio_container_dma_unmap(bcontainer, iova,
-                                       int128_get64(llsize), NULL);
+                                       int128_get64(llsize), NULL, false);
         if (ret) {
             error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 5527e02722..92cee54d11 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -81,7 +81,7 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            void *vaddr, bool readonly);
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
-                             IOMMUTLBEntry *iotlb);
+                             IOMMUTLBEntry *iotlb, bool unmap_all);
 bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
                                        MemoryRegionSection *section,
                                        Error **errp);
@@ -122,7 +122,7 @@ struct VFIOIOMMUClass {
                    void *vaddr, bool readonly);
     int (*dma_unmap)(const VFIOContainerBase *bcontainer,
                      hwaddr iova, ram_addr_t size,
-                     IOMMUTLBEntry *iotlb);
+                     IOMMUTLBEntry *iotlb, bool unmap_all);
     bool (*attach_device)(const char *name, VFIODevice *vbasedev,
                           AddressSpace *as, Error **errp);
     void (*detach_device)(VFIODevice *vbasedev);
-- 
2.43.0


