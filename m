Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192C5C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8HdO-0008Lq-Uo; Fri, 25 Apr 2025 07:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8HdM-0008Kl-8T
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:20 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8HdK-0000OI-3E
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:19 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P29BGO018385;
 Fri, 25 Apr 2025 04:54:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=4+Dmd9YpE9AAgIEm090VciJOhR1hVHKCElRC4Cejk
 mE=; b=CIRroitPPRbDXJ01JUcleCrjF/OU0/CUu5e3TYB2nkc6muq3w4cZU0UeB
 jMdoy2LZRjkpwNGwgsHnr8G3FIb61XnePMLXKwv/r9/5NxB88V++dQ2RPXM6Acjm
 tZ6sv0aM4Z24AyHHyMt8ldUspgUTkQrAeVq9V7DsFeOioNh+XfbRyjNcYG9hCDsQ
 gDEVwYODqn297j9zlNlYNLlfNnxoFDFM/zlWWdNiIunJ6GL5TvMfNdd3ne8sFRTJ
 sYZQlPFD7hUkSP3YofXDT4QGGtQb/3ujimUbHX7atNolQBik2OKbO8UbaXyzAvln
 Fhc0Rz2N1Q8BjJBkDRcgemgpxzK3w==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17013074.outbound.protection.outlook.com [40.93.6.74])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 467ww8hask-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 04:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IF7YWRo83zHU0XMUHm28BmbNp/Bexqj0BnfNrlkaIJybUebGn8ZSoZEx6v9VlNsl047Lzt+8sx2QYSGFbD6SpfLXpdbiLc3zCysoN7yumLwC9SF9K++8jEaiqoiUsk1qV5OiF/VmJc1PjoZAZF+5UDf88CktGOrGEIfQ+qdhhEDDeuUpJoBjXbEP1+5tPoRtJkC4S+f3Vms6sYkf539ysnIfqDpZ34n5C3e+spRxJ3Rm3Ki0W1c68e7SHdalqt0mfNHuBxeLyv2bxeFoRn758ga2JfzgKc8GM/2HhUjhPCIUsC/1nTnya4chfS4Bi063IcdIEeaNn0cm2lDcI6SCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+Dmd9YpE9AAgIEm090VciJOhR1hVHKCElRC4CejkmE=;
 b=Gg7Zy8zsm4YlMVTTlQ4zrM4VnThM2ajXOSMP+kutyYheFnahx6Xubelv6UPSfsn0hK6lSzG4PloQzZ5U8Yw+OsmyRskN4ZyT9SR7uKKhL9TAL/zU7sc45aWZ1jdEMlo67Abv6YNfT9FoYASIHMx7dFT/UVMAg0mUFY6MDmhSkPl20OzeQ7CflT8WyIYiJ+QXz1uZNBacfbW0zyIs2TQfo8m9T6RwepbmeBdWwwg21UyQJwxd1URU1i39Nln83zCFaJ8zwuBzWrUWUBw2yxqAGHTu0/UBJ+DOhuqfp4F6HkjY1XtWb5WFJ7WXsf1NoJdEy7Z0GT5gyBl0ezcCb3ChdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+Dmd9YpE9AAgIEm090VciJOhR1hVHKCElRC4CejkmE=;
 b=kEteIq9cnOo88/yl0U9ipTV4g9U96dQXegU4tzfWO526hIBZW0VdDXOg+mujOjWso1YUtd1FQLTiHVeAczlESfZw3KPNEymng+BfVt8Zdkrf4kU9XVaYcJ0XETNGH+6A7WQjMZHZ5bN6Cf3NoyOcURFk2GFwehWTfFSu3FwveSW0H/bpUZ13u1Gejx6t18XF2Ebf2kB6nE28RswxQmFLPIynIT1ivbG5T+kdrZszEZpl7F7XYAhXpdwfOITJ73fgjyQJqwoELqHG1W70zVTsczajFI0G075ZUwda/xHBIJoodvgkf/M3xnaO6n8AJgXUB40tvcV1nL0XwXm9S5N2vA==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 BY1PR02MB10337.namprd02.prod.outlook.com (2603:10b6:a03:5ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.10; Fri, 25 Apr
 2025 11:54:13 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Fri, 25 Apr 2025
 11:54:13 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 03/12] hw/i386/pc_piix.c: remove SMI and piix4_pm
 initialisation from pc_init_isa()
Date: Fri, 25 Apr 2025 12:37:50 +0100
Message-ID: <20250425115401.59417-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425115401.59417-1-mark.caveayland@nutanix.com>
References: <20250425115401.59417-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0045.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::16) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|BY1PR02MB10337:EE_
X-MS-Office365-Filtering-Correlation-Id: 134163e1-abd8-42ab-db51-08dd83efe59b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jWbmN6W9BWClzLr2J1BUtaIFP9Zf/csv1dUZZXF1lLNtaTElt4mhO9AinKKl?=
 =?us-ascii?Q?JvJeVPndYxDFdgMW4nTxcYsSQUFR4XbVB8+F+CTm5pnGhBEdFPbpb5glr1lk?=
 =?us-ascii?Q?3KdU8WWCAahFaTps94ZQj86uG9SPyBVcvzqt1PSC9un0dDm21Bna8rxtaXlc?=
 =?us-ascii?Q?ffEysYoO7yNSNmw+ZsLsnMEYlruZN+9czlqN1zU0VF5QVTMJ/omUG/6QxrcB?=
 =?us-ascii?Q?Nb3aNzY1z1EoUI4x/sDBBa4xRXS6YOF815au1GYwsirjg1MjU02M1zy3mqy+?=
 =?us-ascii?Q?8uIlNFYudu240izeHxSfeRszh5YJLcdQz3paOqXOfWJnZO0bm1ivVy6FC/0K?=
 =?us-ascii?Q?HhUGdIq4/sYbriNc5IbmnxVWyIMjoZXeUsujU5YtsCKQvlv9Dt29MP9bGgMY?=
 =?us-ascii?Q?RtjGsuYX/IFXhY+VEKDj4omZ+QUhMifBp/FhH6jzkg/YTAVnjra6qbzjXfzN?=
 =?us-ascii?Q?4wqi+hln8WgqsxL3dvThICoJANSEm651VVnYDAXooJeP13BVVXfwYaMJj8EU?=
 =?us-ascii?Q?E4MrKDoB44zgQIrKv5bmhji9eCr3QP0+FPnAYLveCUQhH58DGbZvSaGGYUef?=
 =?us-ascii?Q?j0fOGOry4KIvzzIzZ/TVAJL/GIfUxVxpcRwOsaHwU+MhqeRJ2jBanOcm6sNY?=
 =?us-ascii?Q?nVqJfHwB7J6yA9jRJwJuD1QnYSZxqmo0St5/QrobiJaMIfC8VooVPWT8Ux2h?=
 =?us-ascii?Q?ubofG2xzmzV7juP8n7ZCbohoBA+ev0P41yg7GxDxlnU9hBYTOYM+vuRJOLc7?=
 =?us-ascii?Q?pzefMnfYjQy71ODzb8NUNHCA1305194PsKJ86OAs+tPi/kq7XV8hWltSeFjc?=
 =?us-ascii?Q?33O1vvsHmgXcBrR2pu+K04B5bW4Ft1bDL8g5Wff+HBbCrOv3kI2uXicaNebl?=
 =?us-ascii?Q?W6RfzSX2r34prL4g78/Mw7ip9Hd5OuHSt7TrDcFH/y6ipEEHAqHBe6UlWjd8?=
 =?us-ascii?Q?KF53Z4aLtkxdqCKCp/DAh45GSEUmm27FdFb+MJf0/CEJx1U/MSqzgoWG6ilC?=
 =?us-ascii?Q?3q4B0eSwDI0UYW0OxPUckQXV0zdpRSTCUsGBQXpTrcKkxOBShuz6tFZphpaK?=
 =?us-ascii?Q?F/tKjPOI1D2q7lNO508gF3TMFVSNDCc4JekgRq0y7KiSpSK7i2tIGI3SSrXd?=
 =?us-ascii?Q?3kexaGMe/Uc/F9oboqY30SW61L0+t6piouUh6+zfvO3VpXgVcg64SQ/vGbMg?=
 =?us-ascii?Q?zxs0MvU5pezhDLs88nN6hvTbaoJhfs0SEklp5D8GGRrrk6KIVcObwQA0Ox/h?=
 =?us-ascii?Q?fBbAKipVtn0s3bKWZDOwZjq95dwGXohFR1v3Z2u7HnQpu7P5BQ2noA/ubl4A?=
 =?us-ascii?Q?lvvXe0ZqXc9IUuy77z4c7oqltZoisrdY0ZTKuMXKKeyybDbVyKqeq7E0iBgu?=
 =?us-ascii?Q?gSXGPSYogsA6uzZvSc5YhBthLY9TJdgdMECgTF+AKUIiiv/la+kOgmY3iMn1?=
 =?us-ascii?Q?EiEZmTsAn1A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PjDYAP5R5erA1e5cC4c/ZaoFRaBmEXRxkMRHDmBlwjIxsLjZwkb0liiGhava?=
 =?us-ascii?Q?SJzDpTedEd9NGcl2hc3pAa64EqqY5V4aE2eURMeXDvwvpLV3A774V5crQjTL?=
 =?us-ascii?Q?abBVhHMdJzyBS+v1oFTmCOP7rTZt7BL5yybNAASMmZoHEnZTA1v3utrVsh3o?=
 =?us-ascii?Q?aKwDOJqQcp8d2+2+haobIisfIcqGrQFhhZVHpqAJg1oRl5RalIa2QP8mKqDQ?=
 =?us-ascii?Q?AFI4gP496dd/3sybW852ShLm1gKOruPdHfj+lqix1TXG/SvGVDo0803Fw3mV?=
 =?us-ascii?Q?kHSf9MXloSv/NOai6zD6NIU9fIFWkKt0MX5aw25AZAde1Pdzz1A2vTySIRkZ?=
 =?us-ascii?Q?oeMLe398gHPgdoUgoorTALQIyA0OVxvoVyP34VpMkJ2I4NfUKR+jG0byzv7j?=
 =?us-ascii?Q?0oqZA/vfXBXjZWG3UQV/Wk3Fs/mS8eYNZAjuXV2rsUkGm5YujnMtVXdjF51Q?=
 =?us-ascii?Q?Sr+TPwM6UGhuGxMcn2QG+QpDgX6L26ClmUe4alW4FR4NKYO6XyBMo2jzr6S8?=
 =?us-ascii?Q?oJXyYyjyk6lOBV0I1Pcbh//VOAK0zl/I1pRAkv2bNYveOrMC5jk/goZ9mjaU?=
 =?us-ascii?Q?6Xzvy8XTAeMYC0UT7Mu/FRgs9iqSnfURVVRHbPLdsdrVnK4LWoO9A1z//R4a?=
 =?us-ascii?Q?tj3NcdRJsW18ao0bY6VRSSjXZ/r9UkK6EGfA9dMdJ+jBKswhOUTl3wv0rrin?=
 =?us-ascii?Q?kdYZFFU2PZ6RWJ09cetJTHMhOyQlbhBopSAs79L82u7EjN1DMacPLvWb64l5?=
 =?us-ascii?Q?9sMeGDvmRNrhgESYnGP+8wpJJZ79NYlMyYwgoVO91Rxv83QRJY38MRVRCZXf?=
 =?us-ascii?Q?000HfylLQo9k//V/4rJRutEZujuRurBkX05oWD5N0xoizCH3b+TeQmZuD+na?=
 =?us-ascii?Q?STEADl499pBj9L56TP9XoBIjK+43ZylPfXpWXxDZ/BYQU2af0fYYxDzzHf0t?=
 =?us-ascii?Q?2oQuA729UZ7fpntSYUlNBuvyQ9iHUy3ScokJJXr+1+7cIH9428v+eRKQej8j?=
 =?us-ascii?Q?i5eoTpd+3mOUjeUaKVJQvNSiHoyMVbtEO9+CYG4H7z9J6mMj+tvlL/1CFxKM?=
 =?us-ascii?Q?NLseeqUpFTtFwMOCUV0r8dMkhje5KbXaiuQ458kJJBRaQKZMIAk+MHTQ5CYd?=
 =?us-ascii?Q?KehljvrXLOPGW/NLMlf+X0obDfxGnjvjPMrqfU/GMA9XLroBT301cfzkt7lK?=
 =?us-ascii?Q?AunCTxIt0+SgVCIBWggmgrS1FLn7guKalTNDGnWYaAW6FA6c4+VR0qmWAW5n?=
 =?us-ascii?Q?QTXV2MpSsQz+L/PyBLEIhdEcNahA8G8TkFKr8/RokAmHvuzKvzLI8ZES0Lc5?=
 =?us-ascii?Q?wkjMz5V+hC99KzZTLwCf9lqYEz1xFdldGxH3qx3hettmvuIjJyWSRZx8gx7/?=
 =?us-ascii?Q?CM9uVDKqZWH9bF0schS+rovWvKUiW3rL/QOdGYVBveU76gd3TMplqs0jg+Xq?=
 =?us-ascii?Q?FOKD2UoIY2cSu2voPoucSW/ODjfpIGNifT0vENhfU96CsfslBgto+CZLtGzX?=
 =?us-ascii?Q?s5gAygTrAqsehRUYub6WSt5hFIeG/8gEFACYgnDk/6h0Zor4QPwjxG1ZbcxI?=
 =?us-ascii?Q?1+FzqMXSD0ra7o2zVK9Mlu2QBO47A80ffWOWW1Hhe0CiwwPbFfjNJP1Pv8Pz?=
 =?us-ascii?Q?4r0+q5KWXR0Cn3lHovO/Cl2TI+doW2boYiwCaJlb61bjs/N3mNcFz1iuDqp2?=
 =?us-ascii?Q?Po9FBA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134163e1-abd8-42ab-db51-08dd83efe59b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 11:54:13.1364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58pvI+JHRAr79bBL5jTlJU7PfOCFTB/8HOf7DBUHFaDrDiH1swEz5hTt0vCTFjpuI3LiJdqlmpumERWAgzE+ezQ507huO8UbIS9w+eWihc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10337
X-Proofpoint-GUID: PSpXE70AEkONQl017QLrrGdhHhCKUTxj
X-Proofpoint-ORIG-GUID: PSpXE70AEkONQl017QLrrGdhHhCKUTxj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4NiBTYWx0ZWRfXxYZFOtRYBp0T
 BcLN7c0VzyREvDqJeApulh8vm5BFH1S9l6VWEzypN7YvlVuXiRK98XEN6GDK818wR/7+AvOFl3Q
 ZZpZmO6gTa7mrff30e7c+c0zZ66qpIv/uGHW725oHBXD/wh1XA1vqfibNYXUDx6zyOzzsc6AjBm
 AGyVkIYlrOenQRS7V6kETJopeJRbw7MlcAYJ+lKcG3mHHa9Pxq6BQFM4XSS1VZVe3z0Aqw2rEOL
 WndwKLowWdCRJD8tOHBdXM9JBzrpdbaK+M4UOsuV/75EH9YHbPAwd0Mobvmgk42xtCkuyX1vNg2
 nZfQJwgnO5cQAtEdHYQqEDu7IsFGH0MMZYM6EuMwg3dfGUmDGc3DX1J46FULQRqjyYJacGFqC0c
 nb5OqNTMI5Jc0nuSKe/tdYJDphuOgO7SjsiqiaqDnYHGuJ1P4GATLb/JPyvawx0MwJD/O2TM
X-Authority-Analysis: v=2.4 cv=DfsXqutW c=1 sm=1 tr=0 ts=680b77e6 cx=c_pps
 a=4/dVwHrG2xlZHl48ITU9gw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=ufPb-6LLmzJJysA_M_UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
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

These are based upon the PIIX4 PCI chipset and so can never be used on an isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 0c71d16192..34f63a31cf 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -419,8 +419,6 @@ static void pc_init_isa(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
     ISABus *isa_bus;
-    Object *piix4_pm = NULL;
-    qemu_irq smi_irq;
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
@@ -561,23 +559,6 @@ static void pc_init_isa(MachineState *machine)
     }
 #endif
 
-    if (piix4_pm) {
-        smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
-
-        qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, smi_irq);
-        pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), "i2c"));
-        /* TODO: Populate SPD eeprom data.  */
-        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
-
-        object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                                 TYPE_HOTPLUG_HANDLER,
-                                 (Object **)&x86ms->acpi_dev,
-                                 object_property_allow_set_link,
-                                 OBJ_PROP_LINK_STRONG);
-        object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                                 piix4_pm, &error_abort);
-    }
-
     if (machine->nvdimms_state->is_enabled) {
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
                                x86_nvdimm_acpi_dsmio,
-- 
2.43.0


