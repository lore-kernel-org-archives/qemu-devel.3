Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5167AC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc3i-0005FI-Hw; Tue, 15 Jul 2025 05:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1u-00020z-HQ; Tue, 15 Jul 2025 05:32:54 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1n-0005tt-Eq; Tue, 15 Jul 2025 05:32:52 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F2TxAC020665;
 Tue, 15 Jul 2025 02:32:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=NMnI5yaegP6zMU/5kNv/8Clm4zVCqpHU7UWPxmnlP
 Y0=; b=Ac1hyrXSK5/NDZMIoDAj6405EiywOFuFyZivuHtAayLRTI7rNAhmNK7eh
 ZP5eU7YvBlB8sQHKYQWW5l/uKp8qqSxCuQm6Gq3tPDNFc6gCoIRL7iPZiNeYf0Vq
 z5a7UU12H+QPVNuHSc+b4KV94JBUNbMCQyESrJh+WFz4JSU+gY0eXO4VzotI7Ho/
 ho6WpTfZ5Jowwadrgch91ywc7Nv3vZAX2cx9n5E6SLd3HzA1R0DFDPoPfGV68Gub
 EDK/Wvc2luSgzFyHhxLjLR+MoM5wYuRMgvt4BoErBvzbl+UY1k5KzasFLeLUJzpg
 jOkDiKvPb98GZ5qqSYizN7cjPSd/g==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2107.outbound.protection.outlook.com [40.107.244.107])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47um1v5u5v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=let+2Z2d2LTUzBmFHFH+BVhEcnUXLPbq6AN4nGMtlAXi9wN5Aqz3b6H+H6uGACTOFPZdPTVeXA783VG7XcOujg/gfKsxhGcGLpSvSHUW2Hp31TaAhwA245Rjh2sluE01tbsO0QutkVl5u6socNrIApQ5dO444EKyG/lLiFmX+Fc+R4JM7rUsuApj7twRsIw4DgxzAJIL6tmYYOGwEl0Syu53r6TzK8UtOUV3G/66vxoDC3m7EIpgZNG2PlNbI8jqoWTuqaKlGM2tI8B+wxeL56OfVdtNkTbaATNBrdhcTP4w3/NWiihsJhlufWxx/hmv7B6OUzwSggwETiDIV9PAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMnI5yaegP6zMU/5kNv/8Clm4zVCqpHU7UWPxmnlPY0=;
 b=IaDUVtAHVY6yVQD7HREpX4e6emCQGp1OglyHIgU9tweWnBzfS+PUZzF2XRuT7PgqkXBzmBizwqmt7QFDzY7HKeujNDDYSUuq/GwUByLfE5/5E6lg90yocpXgNS4TWyQNKmM9mgHPY6FlFUW3gO5HmOiOO5SVKZjUV+pxdY1w4PggtvmJu/CO1nS0gSJOj31xz6WrhE5GTQRZI7bi9/C1NSlz5kjYW7BzoKgrHFQp8IZ2gbK10BlEvtmnbvFQZ5lMcJXktWftxdCm7GXzwNxjZ0UE+dT7H19ebVDIO+8nbUPU7FbLTPCfzTfnjFEFhkUkR/3ZEMGcUOIqZmyCTtdpSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMnI5yaegP6zMU/5kNv/8Clm4zVCqpHU7UWPxmnlPY0=;
 b=yctV7UlvEJfJx3BD0IElBKsIyA3fNPIT+fVTCOGwgXNQUviuC2Fe+ZOEe5+nkTfBh/h0csbNvNKsSQgBhLlO9HPLKYGq98qXn5xPO0kL1UhBVBHPWkHJv6nkEPOEN8KJweScRvbgbKV64TNmKn/TWwOylWldoKVWD7Ee1gEwuHeT5YZ+XZAKy1hrmR5MF+hXrQVTZOVEfYUm+erVCYTmu8G/Iync2vNz72vHrr4vGRN08h5Cz1yVPPtC4+FlbpbKSNLnwebUwFHzU4pCG3OeV3wm+9nrovB+fzXIorqGLZOcD8WE39XKW5GQPwwrx5Kmu550amalff5tVOdUM02F/g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9770.namprd02.prod.outlook.com (2603:10b6:a03:548::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 09:32:32 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:32:32 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 21/22] s390x/s390-pci-vfio.c: use QOM casts where appropriate
Date: Tue, 15 Jul 2025 10:26:01 +0100
Message-ID: <20250715093110.107317-22-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0047.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1d0ebf-a7d9-4a07-a00c-08ddc3828651
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bSaGQKz6r18svVSwZxL2ed+gE/YXedOiTnt3XxT6DOTFCPjrbevlGB1WGFK6?=
 =?us-ascii?Q?RSs4yoGGA99w8KlaiBL8WyLwwKMGGT6Ae4JVY4qGoMEhoewA831IPml1n2cP?=
 =?us-ascii?Q?HieNPnxo8AoTaB6Nn7g26cg4oRvBpJDEEW1yaZRGtX4eVO7WFGw/W/6Z5wZE?=
 =?us-ascii?Q?5nV1A0QELd+SJ/juV6GZBegFA8JnVIoj4AhV9DDXwz/Y3iI6tNoGS97/lk0L?=
 =?us-ascii?Q?U170NZS/acsVhNXreXJxNZNbMegNytEMwu7T666/GUMZJtm9SPMNaSGFiWGg?=
 =?us-ascii?Q?f6RN/Cjf8dQcYCZ6yM/d/UIV/gHDKytk+R10t/nmEzPOQpscXDhSdpCcblIJ?=
 =?us-ascii?Q?r6lTNeQapDE2upUakuox9ff+FWPQS6e0zm+EhNSlktcKpYiL/bYjfxEsArbc?=
 =?us-ascii?Q?j6BF1qzGL9ecPPbTu69ajKfSdYFwoSpjkZTPdhQxTRv2isX7vI3p27SI8Bw9?=
 =?us-ascii?Q?MwUgHf7W9RZqJ0S9+3iOGQdumeW62CeesfSwgePW+ZgOXdxLzQHYOxpLKabe?=
 =?us-ascii?Q?PbJ6OHinmOx6i9HVbroYMgtokPQBiVSzK2Y7cyrlJ7xCEGtmDIOGkfkrPdh0?=
 =?us-ascii?Q?fFJY97M+VAP1yCTu8h9+/JZmvmMWYFcY+P6WnHajtrEPdAme0sVH9TQsCSlO?=
 =?us-ascii?Q?cIr7RqjQrkJvJsZF4lWYjpCX/tHQlqDoMZAaN1RlK2KtsINoL7IzPzJRCU7f?=
 =?us-ascii?Q?hxq+576cnjInk18081F25GXScy1Jq16C8lq15ZM39UGZ24W/Uf4gMOV6W/2c?=
 =?us-ascii?Q?4v9GZdVmNLYmCy0yE6W/fuXup15/dV11/UHpotZIT8M3RjH8vclfQh13Jng6?=
 =?us-ascii?Q?kczuuQDmzzy/+k+cxM9nEnvOkCq+pfaoPr+1aj0G8Ea8j47RzTMb0Thxt1pN?=
 =?us-ascii?Q?bYZ1YMmL7sBqWcycnAqlXjzVa86YNq1IZ1Coz/3Yn82KNuIbD2IbJE7ZC4gm?=
 =?us-ascii?Q?tYftCw1tD8QXWtydh8FxQadeUI3n8xrfTlhVlNFpi9srplhGXNLiA/fmzEAc?=
 =?us-ascii?Q?GmfMAkHnlcryg+dI6wtCuDoerEUUqz5CYseJX29xA4SCOwLxfMFRhvdUynXq?=
 =?us-ascii?Q?ERB0ZyiyifXrTTSsooCPIythxKsdQMm8SkqqBeY4bN4rOBkRx+P2qA/gdriT?=
 =?us-ascii?Q?KjEzj2OfVM09flCnCIpjOfXPR8zU2aaU46aaQgr644iIvu6//tkbG9lNwVZP?=
 =?us-ascii?Q?STd4js855s5JO/w2FKkJMa09EtRKcDkHQFgmjhHvaLZWpwznwaPuQ11x5cIp?=
 =?us-ascii?Q?pYB3iRxKCg738I6t1nkOuS/Ziutsb6vTKw/tAmwUtotusRqNC6/N4rr02xZ6?=
 =?us-ascii?Q?REXI16dI5rEzKldhGeqynRTF5jM9wqIneTezfjIVBPSryDT5fU35TOdn0nku?=
 =?us-ascii?Q?geDfZFccYJsDs9obxPLPIwZBwZSWtWv0r1cWWoniY/J8AZdC9tBLeUlEFj5x?=
 =?us-ascii?Q?te/mfB/GvbyGcjSPq6+bfGflJRjV4WjDIHYKKHsXP+KUP/weU8POdQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DgnxiTYMyopQIgXWruojqEq2CPSVPcMNJi5nIZEk2XvCGvmGqywLc5mVVmwH?=
 =?us-ascii?Q?bp4z1aYQLGIRdaw2vOno9gQMMDpGzuaaSnMdwU7+gy+VIZjPbmUUcQLIh7jR?=
 =?us-ascii?Q?YYYYcnpSnzu8KBydRm3r2Jc/hbysyO/JurxKjqfouHLK+8goeqrpwlGsIBVa?=
 =?us-ascii?Q?qtp1ZsV7Fhzhhs/DssDdlBzOZ2FaSha6HWYzth5l/r4XYQpyWHmz1uJsn7N2?=
 =?us-ascii?Q?fcVt6SEZ84M0IDMRFt4ej7Vlqp6vpl5o8da5/i8sC5QGtJO1LGvRogVMY11l?=
 =?us-ascii?Q?QZqOuKs9yHoqTC18PdSzQ6zIdpFnFvyKMh16c2q6t5pvP9KUs9zKqx+7hE+c?=
 =?us-ascii?Q?YVB3dMPU45iOSxkbV/2VZAfaR0rmrCct07nSLl2hG3jQ2KYyU0pNAD70anN4?=
 =?us-ascii?Q?pbdfVN9/IUo1bwQehwnUtfLxu4mCokq4Gm3q+3sziLuSYJR3W3cRcc87nu3y?=
 =?us-ascii?Q?uDbHHEFwGL0jb8AWvLGVZPp5afwfOhDZgRFn9OHXqzNu7YejbJbtbR24R8lV?=
 =?us-ascii?Q?Hp+Ma+E2sZvlxce7HCwA6omngyr+eJ8XuNjodlgtvgrzjfx/Jf7g/0IPVGU0?=
 =?us-ascii?Q?BJxtt/rZS6ZgmqtyZfZS9Oc7BA+wVKUqnA+DtQIw4oAO8nO0krN49kwKP6Ij?=
 =?us-ascii?Q?QQNW+m+3e8EgsaZJeG3T7l1wPwEWln/WoPnV6sERz5SEJwlFtGVnluzYoyl/?=
 =?us-ascii?Q?F3LkQi4FuqtiY5DlYFcTSyLVWibkJPDQBy5fc0NGuzkCJj7RbLUcNz76aORz?=
 =?us-ascii?Q?48aNGZvARpqFmReqedFWDUPjxwAt5mJy1kU2Bov3lwj9Z0tLsTwavual+gYy?=
 =?us-ascii?Q?e5+DjBhAKUO4rnlGABbN9uhSW4xuxJ5vqV84Uqz8w4Naiy7CmClQYYtSp/Gn?=
 =?us-ascii?Q?/MWN1o7DWWc9sqixpYHJUm93al98rENcR2T4vWz323d2BotGIzDTkNWnBcc5?=
 =?us-ascii?Q?hn0jE82Jo9W5xav/t+PHxRwbEWfP6Z4bnlQmIFCJ6RzahIZTrOfJKSXn7/8s?=
 =?us-ascii?Q?rr7jKgEWkyvSoTU4vf89H9k2hPuZDZGMqRre6PDo/getyWcQwD7iQxUfSbOX?=
 =?us-ascii?Q?kPqMgvlX4EvhbOFXt8ag3iVd/lsTnGprUgGaDLCB5golERWEItwLgHDLNIoJ?=
 =?us-ascii?Q?c+qxxRIXnUftlBJLBcwXIZ0NMyfUltwLqqZZ5eFa745iyeSSplUWgqIJ9hq8?=
 =?us-ascii?Q?ZCiyWnKhFc90G8J9+emp3eL2q+l5PlMYlir1lf8szGKKCQoBf3taSdRiLhxg?=
 =?us-ascii?Q?r6rIU5v0JyYsB9qMAhIetsCCXRv+/hq4ElcQDC6jDqtHFqm1LLs7gb3UQWMc?=
 =?us-ascii?Q?9kpj2hDesEke86e808TvXHDCahk2A7YXLMBWp6/DsoW17GVc1n/l629v7G1k?=
 =?us-ascii?Q?AuJHNBuZyWyH/pYNteKcH2MJQV0ICJoxYtarmPoixdO5j/aJ2Rg+4gwbSIvx?=
 =?us-ascii?Q?WUX7lW+5hMwIAK3TpKhGGvbTrdSbCQMBlmQoakzv+krGmwt8aRg56P291jha?=
 =?us-ascii?Q?CdNwaQdySUJ3Tz4S530dO5BoIZvhDCpU1iYs18LU5xPpFaBBwjV435jc3dS2?=
 =?us-ascii?Q?HegKGAWwe8lYJP8r/Rs2jrh00XLqgpaeKmbqgOy3pybGQaIfLL6DX+j/6gr1?=
 =?us-ascii?Q?nW8JINwrm5uuYt6Nb3cZz6DNS6QLqMqDaJUrSzFvGwiKhZYOWO3B+BXkLWWA?=
 =?us-ascii?Q?YXVXbA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1d0ebf-a7d9-4a07-a00c-08ddc3828651
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:32:32.5571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUK1QLC1wHbYclLPkqp48Gt64VxCaprpggww/lzpQhe7X6b6hUzOo4XDH24ksTL//qU3/DQfNr587va1YOj7h+TINcShYJi02snDwCS/WZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9770
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NiBTYWx0ZWRfX7wLbqrQPEfra
 xGUMaa+bz7bDJiXpVAkDVWbK8AjaGmxwgshoHWxF/UE9+sMoYD4JBt9ATu/0kMP4EFwWDC1Acal
 DoraHBdapDDfwBK8R1Wpd5PFZ+dFfQUhA1ClhxbQ+DVMgBvF44DLnWJCqpGaUfEf2by5bgvZ+uL
 bADRR1udAkjNCcNQbnKOB7AmnUWRu+7Bjpeen+W3frenw/ArGU+6HerMBb7Kg2VpknOYk/C0/YF
 +BDY6vedOVkTkWvzN4KufADQ+WVN8DgWV2fg+8kehV7DZbZ7XqqQ3yHizrLG9MNt0S5neVXbFzz
 JZnaDFO5BeLyb7F2Bz/7kJV15Pmu5HOp8nSVraFr0heD/CkRWWtkpSoK2WWwLTM0fRGdDmaqTCz
 uvtB5bKAoX7szEFpmRS5WIOQw0wif36ILiNiPBEMJb3vo+C/WbMIFqOUkzUDVZ8noIveLpXR
X-Authority-Analysis: v=2.4 cv=Y5L4sgeN c=1 sm=1 tr=0 ts=68762033 cx=c_pps
 a=jnPEPjqVaUv745K9fB5zJg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=iFcvb2vRK-VYUA3afGgA:9
X-Proofpoint-GUID: Qv6eFIY58vWicI6oJv3ZSBKQGvl3VSpT
X-Proofpoint-ORIG-GUID: Qv6eFIY58vWicI6oJv3ZSBKQGvl3VSpT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Use QOM casts to cast to VFIOPCIDevice instead of using container_of().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/s390x/s390-pci-vfio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index aaf91319b4..938a551171 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -62,7 +62,7 @@ S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
 {
     S390PCIDMACount *cnt;
     uint32_t avail;
-    VFIOPCIDevice *vpdev = container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+    VFIOPCIDevice *vpdev = VFIO_PCI_BASE(pbdev->pdev);
     int id;
 
     assert(vpdev);
@@ -108,7 +108,7 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_device_info_cap_zpci_base *cap;
-    VFIOPCIDevice *vpci =  container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
     uint64_t vfio_size;
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_BASE);
@@ -162,7 +162,7 @@ static bool get_host_fh(S390PCIBusDevice *pbdev, struct vfio_device_info *info,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_device_info_cap_zpci_base *cap;
-    VFIOPCIDevice *vpci = container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_BASE);
 
@@ -185,7 +185,7 @@ static void s390_pci_read_group(S390PCIBusDevice *pbdev,
     struct vfio_device_info_cap_zpci_group *cap;
     S390pciState *s = s390_get_phb();
     ClpRspQueryPciGrp *resgrp;
-    VFIOPCIDevice *vpci =  container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
     uint8_t start_gid = pbdev->zpci_fn.pfgid;
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_GROUP);
@@ -264,7 +264,7 @@ static void s390_pci_read_util(S390PCIBusDevice *pbdev,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_device_info_cap_zpci_util *cap;
-    VFIOPCIDevice *vpci =  container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_UTIL);
 
@@ -291,7 +291,7 @@ static void s390_pci_read_pfip(S390PCIBusDevice *pbdev,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_device_info_cap_zpci_pfip *cap;
-    VFIOPCIDevice *vpci =  container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_PFIP);
 
@@ -314,7 +314,7 @@ static void s390_pci_read_pfip(S390PCIBusDevice *pbdev,
 
 static struct vfio_device_info *get_device_info(S390PCIBusDevice *pbdev)
 {
-    VFIOPCIDevice *vfio_pci = container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+    VFIOPCIDevice *vfio_pci = VFIO_PCI_BASE(pbdev->pdev);
 
     return vfio_get_device_info(vfio_pci->vbasedev.fd);
 }
-- 
2.43.0


