Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C97C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 19:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUVpq-00087Y-74; Wed, 25 Jun 2025 15:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpo-00085l-9q
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:31:04 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpk-00046Y-22
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:31:04 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PDoDdu015699;
 Wed, 25 Jun 2025 12:30:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=g9PhacUvZcUxmruVZsbtYmC6rCRxbgNXibolLRoSR
 eM=; b=y2dTbGfEIygrrfCbZHCEwklJSWNViQMvZhjq2HqXy4+h4AQ1HGxgklVAy
 1UolKpOxZx84OOoujBDWUWfGv7/+33Rk45t9XGo7lP11WwHF63Xm/UUyKDPI0zzL
 qzBxxN/0c+CX9ggNCCE07/XuzImhFHJAy9ULr0L+CHmm5TOXn2ePetSL2cfuYFb1
 ZbfzJ9aPozgsiafCCRkL5Ejh4k5MVvF3U09998m3UATTufQfizObirtj+rFdUeZK
 bdjavxjL4Xvh8deXCqE2gp/hTPqcH2ZYQnQ4KFlxjoKD+8HXcXHPyjewPOmx6XiA
 VLkA0+hTDB+V3Z3tac5ZnhwEDA/Nw==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2116.outbound.protection.outlook.com [40.107.100.116])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47gjbh0r93-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 12:30:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQVhUscJ0/GzqhbVCerR5i9xYrUS6Y9T821WeL9qjSYfAlrCf71yc3PvF3jjrPK3aXgyQVWVB1MPY/ToDndl24LP6+Tb79QHE+wSDBBrmhB5WIOHowB/s5+6BQ/ICrw1+35reYVf746za7A1D/kpYSehtRcTxxVg3I2/NfMtSd4pmEIBtLQrH0QONFfC3o7pFCGFF0v+N0Me2mlj54/XlRxqBgoe64GIndm4xmUqF/3tR+zN0Oc0IUd7PQHzP9XHJnwxl9e0eNuPIGpnv9/RzHVYMTaCD8PyVpMt7vllUIekpYfOQaYegwZJzmdyndf0VvkJ9d7gJtWAk7ehipmjmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9PhacUvZcUxmruVZsbtYmC6rCRxbgNXibolLRoSReM=;
 b=ajpCUiyWqeehmpOXZx3PmPnbCQ92JqV01AS4Wx1g03r9C5yy2rYHHIkA7ShgWri6T/Wh31YezkkaJzO8XwaOlxgNJePJEM4dLIX/wGclqDpFfYT6bG6rSdIJ/ieoIdOewHJKeYPPhs4LVSQ1Wk9806ObyH630zeoexsVFdGO7hNErZPStcDMC/uU+J2ecu30ik1XoZiRdF7MfiW1RAzPINvgLpv9bepTPeYruHdX75txEcsXCr0XKtBBWRHfcf/HjEHEvl2ExjrKOxonTHqXqJs1A5kXAjs3mm5nNof7WC3VoO2n7J+Tan62gtDh4Rq3L4SS8lWK0sjGS05TDvdtBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9PhacUvZcUxmruVZsbtYmC6rCRxbgNXibolLRoSReM=;
 b=VoCvih44y6U/5UMEUUoEggjt/DbjZNZV4YCK06/0lNDkeFS9fSDTdoNb2VBODuEeYrfWONVLUz3RRnYcooyCBd+M7ZNA9O7dFYSQ5YO8DaZ5lfhrd6IBqfltmCgtOUPirVME/JeoJI1qpx7w14WL2GiRbPETJwp2wm3JEANEmNqe2b/Iv5eU1amd018hKfh/mDoC9iNgWZupqArKA4DusQLyUd+dZC0kZYkZRcZR0IGzI8c/VpSHnzrjNoYTeJYzPD9Vi6JH8+0NoHtXG5VEMy+ujiUbmOdDVTLtN8cnoF/PZweX+ljsG33LCVFlSu8TYGcpff8P0k+Drts1wHDTIQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8535.namprd02.prod.outlook.com (2603:10b6:510:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 19:30:52 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 19:30:52 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <levon@movementarian.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v5 13/19] vfio-user: implement VFIO_USER_DMA_MAP/UNMAP
Date: Wed, 25 Jun 2025 20:30:05 +0100
Message-ID: <20250625193012.2316242-14-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625193012.2316242-1-john.levon@nutanix.com>
References: <20250625193012.2316242-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f26237e-281d-4d64-2103-08ddb41ecc39
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QQWNpkj2WltWtrVByn4aabaoyJSBrqvgpCmRb9YzWuK55ITvOSYdbuLZgUI3?=
 =?us-ascii?Q?7sQB+LGDK7z7QQBSeTTpPffcF2egMMYxOhLmTOzzfquXCrkvygxIEwXCxtIP?=
 =?us-ascii?Q?dev21RFHC1kxoT0ZfWy9RohoTCFUeE8lAlIDLHORMz985t2qggCtVvrEDwPF?=
 =?us-ascii?Q?Fo9TcgGL53kccxHqKhfCEQOUci2Wj74jexirO9wXxdMjgnKfANOqxYJqtz+z?=
 =?us-ascii?Q?c+9v2UthQ8LHg5eWkrzPh9Rx9M2Khvf+cKNwadJkCZerAaRFGbcL/RQwwt/J?=
 =?us-ascii?Q?rmy2d/qaBGKCaZXY7N9qWAzEZTRXTlXTYQJTcP/O02KosVZVo+MGNAhJBgm/?=
 =?us-ascii?Q?ZoTklZmhV/ACQvo0rLwzxj2unaeRayJxTLfugv/s2ReDtbJlSE/BqSyeGF+R?=
 =?us-ascii?Q?nSPdRANdf/bdCsyGp4BBrEj4eh/J/XSywPgMnfgVtIH4YmX1i6TMnoWM8FpY?=
 =?us-ascii?Q?voUnB5+P26w8NH41TE5fBjHNqt1TxBEaVN1fA5ksit+fqIgutFy1HcVq7zl9?=
 =?us-ascii?Q?BC/oEDB5p6DS4O42R37kQevBRIVMAMq2jmVB1G9Vj+bL6c6ZO/nKeoiMjZMX?=
 =?us-ascii?Q?ERIML0wWCgG46X59VSOPt0cBut+isCj5eJIMmMedQALlCstNir6PKYfott1t?=
 =?us-ascii?Q?97L2T+TD67VyjxIA0I3EH4pUIdBXdf7VT/zr5kSd8I2Paqi7X9LwNmh2yq5+?=
 =?us-ascii?Q?zW0g8swM/MZ5vwj0L8Ka1Mh58Bb+yH2lLxI/lMK/cYK/zV8pleKIXP1aM9OC?=
 =?us-ascii?Q?tp6qqm/BNCd5oqM884xvvMr6iBieCLMqActRGuMvzgnupO9vD6wMlCNR/l0q?=
 =?us-ascii?Q?sSfGLLR3Tu1Csge8GqVX8z7CjbOgwcrasjt3JPgkl0zCnCmXDfols/h4Gj/p?=
 =?us-ascii?Q?sTTSQk+DRzHw9d+F5Cf96EZgkPYzHIpDn2Q+olqrmykXhrisaSHL6QC+vFJq?=
 =?us-ascii?Q?DqX+ymc34Xn0eY833l5tu190C0CfHA2qDjcJPo3JRRUEbcKOOdd/RQk7UCBP?=
 =?us-ascii?Q?YybQZuq82hpCmpPBMr3tV6OYJGcl4Vdkc1k+zcpNPhcqc75U4BEk5LPjRzDQ?=
 =?us-ascii?Q?O50RPD60wh8xnoViL8igZeUu21lSHMxL8d7mwXPMYPVP/4vgcnyX86CIwB9b?=
 =?us-ascii?Q?SzD9ku9YFD4J7lpob1d9l9nbyWilNU9BC5DzcrYWcXKKN493naujfHAPBm8C?=
 =?us-ascii?Q?eotqhe6SnaClXGqz2piA3BBtrH4WMh/xqK8TyMRjBobvhudRt3pyxWyA0MQ0?=
 =?us-ascii?Q?A4kwHGVvca/o8Lh/JHWl4+ynyuqRnW6shH7IbjovHzoNzDYsk6i0fmJQo+Nx?=
 =?us-ascii?Q?nk7lkCQjxZFrgAJGHSoZen9ktqzn3o+KEICwtHZ/7/8oOSaMHhixnE0DWiBu?=
 =?us-ascii?Q?nxx/PgsIPm8yGLZnUmM/F/ZeGibph7/+3suDJsAeWNwy3Y208vtTSelCDdmh?=
 =?us-ascii?Q?qT98h1aeoDo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RtodN0agUxhI71nskm0ojxstrV4+GsYCT64Cc//mcRfL1+tkA3A0DZPE9cSY?=
 =?us-ascii?Q?8vhQKYWKXjd1fVtJipgwkT1G4M6t95/pHIJR2q3qtCnJAtYIYxUKI9W61I3P?=
 =?us-ascii?Q?a6mv59rEnkBaEVXplbt9athNk4S1EAEjNdHSUHKLE2XCKbu3GWg/P4mFyMyA?=
 =?us-ascii?Q?xqvZH2Q8pguRRkfctzOaKu+pQnxykSc6IONNUMM8Yq7KApC5sm9xAIOSjVnY?=
 =?us-ascii?Q?LytfT5bUtyQO6zDyAwrst9lTANok0QeMsjjUKFHNmX8flTMifbEe9EFLASwI?=
 =?us-ascii?Q?LIRjGJ00tygGA4gXo4SPIgpbhS2CSaWH5TGemAOjcVjfn3C+/hLmh/K3ityv?=
 =?us-ascii?Q?b3CbRvTyzsi6UrIwhmXVY2x0peu7ku+fvHiEmkJWfkv7n8dY5JqeKJluITAy?=
 =?us-ascii?Q?2P7ohovBV3Emg9XQG7n8qKekMth3C1zVrOKZtDhDphDntXtM+uN4Hu0tepjd?=
 =?us-ascii?Q?5F8oLU8LIXkIsJ+CLGJ0Zv5rnoS4GF0Iey9CJho5IgYUIcCE+gOzMN8K0+Io?=
 =?us-ascii?Q?mVdrTy71KyLC3/H2w0/yTUIw+niUvQX7wJqilNo9gY+X4HSrJwYAlzQViXb6?=
 =?us-ascii?Q?1Vy0lJLXtR9KJUrHoIOobUpCX2gn5wmmxOvfrwAT0Myc3x7DDb48d7sCSK7Z?=
 =?us-ascii?Q?fk7tQaW4NEXlchKAYL2742ce10SP7Br/ih2AIeNsgfndJzcNVCTrk+G+7IJ6?=
 =?us-ascii?Q?y1kkgPHO2jnLEswr3IImJ710o5clupJ4DCAf6QV3kbORYx+E15DZOCxGs2y1?=
 =?us-ascii?Q?aEn1kI3jvlv1LGoqJxmKYAjiCaUU1qhl/bTFzuGi7l/vTWLC2dVjyGDqetEF?=
 =?us-ascii?Q?9Qd3vTHIGqQP2X32g08nHIMcJX8fXaLvDu6WubIM6LS0N7GlRwaaESFfC+8s?=
 =?us-ascii?Q?AcbGkMNs3HCX3/quDgAjR//QXT70r7z3NlolHtXdhhi5gPqdqxSIXO6oq31L?=
 =?us-ascii?Q?K/Gv9J9qk/9NoCTgCWT5bw6UOCTylVSS7O2n0KvzavcNqPaTZQoDuptDpJei?=
 =?us-ascii?Q?gCkrbkQ7vEre2gU7M41x10DIhLFz2gqYs372f7qGKihVmw3+LYAH3Ii4Ew/r?=
 =?us-ascii?Q?/p6LLlU+Cut+kEu58v4UP1fweB8KTq3+WGjzrIhbnqywnynAGXlAGIk0Ex/0?=
 =?us-ascii?Q?Poa2+iuW13AUAFbL5VAtFayeeQJPRr+Smx1N3e2rX6QkGkgUfQii3xizfgMM?=
 =?us-ascii?Q?f3XnTF0S4QexjMBmNsYOeqQXo/5Veax36J6ADIcFSYcduuhXFbPXn05J9SN7?=
 =?us-ascii?Q?th2thY9M9ZOZUBOcn4h6jkkUxPOIql6q/pf7Y79zQC3TbxytmRdoj/CIdaZp?=
 =?us-ascii?Q?epxZSu6pdNP5ABuZhstx5raJD2JvhqHujKs/HbCfWkbRu/gPvod9oV4DVFYZ?=
 =?us-ascii?Q?fERzZP7hEgdj4qKcJrjJBb002djU4dDrO5SE0ev3dQ8YMC++yY4N+DHFSBb4?=
 =?us-ascii?Q?27LlOltslPERUbHU750fgAdnGIP6Iw+vhgvZCNlxhoxFzziorInwokEqkwMi?=
 =?us-ascii?Q?Yvf8YBe9llwjHkBfJK9+aLFcbfEEeVbF9by8TJoaOKaD7O/J5Jlxf4Z0fSZv?=
 =?us-ascii?Q?87ZtXszHApm+WuZFD/ZS6S8NnKZzLdrlYmOVG4DX?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f26237e-281d-4d64-2103-08ddb41ecc39
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 19:30:52.8284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1U3FlfrGDJJ/sPNlhx5PHzMspYXMXi6Et127aaUnW752CDcxmrMrBMUuVJv2YeWl4nDjkOhhTQyTe1EYntrhNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8535
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0NyBTYWx0ZWRfX0sDXIlzeAmR+
 T16R9An6SKQEccy/F61yhAlhiReUZ5ZCgZZKIUmnKF3R+bdpME2vIHhXyUPMoL+qXLcL2UTh2gJ
 BdYKKqVkefely4lgagASAPmZmIoi1rCYitJlHy9Sf6j3OzTTOcsUld0Ih/+wJxfeJeSR9q1ZwWC
 zNHrhQpE7l80T2xs9WRdLH8pFzcB05UQYTb5iaHn9srZWSRTQC1xT/wPWkVg0kMc4ur9o+BtJTZ
 nTpYDlM8h6wfyR5H43fYI4kRdDQgmOR06NWZxBC4hLuQbglhushbks4HpU5hE3OpZ7AZeLWzUmj
 jsBmNATXN2OmVMuY1o3tpDVRUNX5sFIZ0999+iTZzPvKv5zxrg9cyuG7fm99nM4PfgOY2rnH3Uu
 NYgTT+eP6Gx2cbC0uzScKeK5CwQjXzjiO402WX7Ju+RbDDgZZIBwRVccyHhZV3zaV1bTdhgb
X-Authority-Analysis: v=2.4 cv=WMl/XmsR c=1 sm=1 tr=0 ts=685c4e6f cx=c_pps
 a=ynxkwAiy9VFaaSOUVCgc6g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=RQZ_2NmkAAAA:8
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=VuTGjHEVGySaywlrrqoA:9
 a=46pEW5UW3zrkaSsnLxuo:22
X-Proofpoint-ORIG-GUID: sDgHTeq8oExXROuUzSpZ7pA2mwHI_zAz
X-Proofpoint-GUID: sDgHTeq8oExXROuUzSpZ7pA2mwHI_zAz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: John Levon <levon@movementarian.org>

When the vfio-user container gets mapping updates, share them with the
vfio-user by sending a message; this can include the region fd, allowing
the server to directly mmap() the region as needed.

For performance, we only wait for the message responses when we're doing
with a series of updates via the listener_commit() callback.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   |  32 +++++++++
 hw/vfio-user/proxy.h      |   6 ++
 hw/vfio-user/container.c  | 135 +++++++++++++++++++++++++++++++++++++-
 hw/vfio-user/proxy.c      |  84 +++++++++++++++++++++++-
 hw/vfio-user/trace-events |   4 ++
 5 files changed, 257 insertions(+), 4 deletions(-)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 48144b2c33..524f3d633a 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -112,6 +112,31 @@ typedef struct {
  */
 #define VFIO_USER_DEF_MAX_BITMAP (256 * 1024 * 1024)
 
+/*
+ * VFIO_USER_DMA_MAP
+ * imported from struct vfio_iommu_type1_dma_map
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint64_t offset;    /* FD offset */
+    uint64_t iova;
+    uint64_t size;
+} VFIOUserDMAMap;
+
+/*
+ * VFIO_USER_DMA_UNMAP
+ * imported from struct vfio_iommu_type1_dma_unmap
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint64_t iova;
+    uint64_t size;
+} VFIOUserDMAUnmap;
+
 /*
  * VFIO_USER_DEVICE_GET_INFO
  * imported from struct vfio_device_info
@@ -175,4 +200,11 @@ typedef struct {
     char data[];
 } VFIOUserRegionRW;
 
+/*imported from struct vfio_bitmap */
+typedef struct {
+    uint64_t pgsize;
+    uint64_t size;
+    char data[];
+} VFIOUserBitmap;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index ba1c33aba8..e2fc83ca3b 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -70,6 +70,7 @@ typedef struct VFIOUserProxy {
     QemuCond close_cv;
     AioContext *ctx;
     QEMUBH *req_bh;
+    bool async_ops;
 
     /*
      * above only changed when BQL is held
@@ -99,9 +100,14 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
                            void *reqarg);
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
+VFIOUserFDs *vfio_user_getfds(int numfds);
+
 void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
                            uint32_t size, uint32_t flags);
+void vfio_user_wait_reqs(VFIOUserProxy *proxy);
 bool vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize, Error **errp);
+bool vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                           VFIOUserFDs *fds, int rsize, Error **errp);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index b4a5a840b0..3133fef177 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -12,23 +12,152 @@
 
 #include "hw/vfio-user/container.h"
 #include "hw/vfio-user/device.h"
+#include "hw/vfio-user/trace.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-listener.h"
 #include "qapi/error.h"
 
+/*
+ * When DMA space is the physical address space, the region add/del listeners
+ * will fire during memory update transactions.  These depend on BQL being held,
+ * so do any resulting map/demap ops async while keeping BQL.
+ */
+static void vfio_user_listener_begin(VFIOContainerBase *bcontainer)
+{
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                 bcontainer);
+
+    container->proxy->async_ops = true;
+}
+
+static void vfio_user_listener_commit(VFIOContainerBase *bcontainer)
+{
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                            bcontainer);
+
+    /* wait here for any async requests sent during the transaction */
+    container->proxy->async_ops = false;
+    vfio_user_wait_reqs(container->proxy);
+}
+
 static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
                                hwaddr iova, ram_addr_t size,
                                IOMMUTLBEntry *iotlb, bool unmap_all)
 {
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                            bcontainer);
+    Error *local_err = NULL;
+    int ret = 0;
+
+    VFIOUserDMAUnmap *msgp = g_malloc(sizeof(*msgp));
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DMA_UNMAP, sizeof(*msgp), 0);
+    msgp->argsz = sizeof(struct vfio_iommu_type1_dma_unmap);
+    msgp->flags = unmap_all ? VFIO_DMA_UNMAP_FLAG_ALL : 0;
+    msgp->iova = iova;
+    msgp->size = size;
+    trace_vfio_user_dma_unmap(msgp->iova, msgp->size, msgp->flags,
+                              container->proxy->async_ops);
+
+    if (container->proxy->async_ops) {
+        if (!vfio_user_send_nowait(container->proxy, &msgp->hdr, NULL,
+                              0, &local_err)) {
+            error_report_err(local_err);
+            ret = -EFAULT;
+        } else {
+            ret = 0;
+        }
+    } else {
+        if (!vfio_user_send_wait(container->proxy, &msgp->hdr, NULL,
+                                 0, &local_err)) {
+                error_report_err(local_err);
+                ret = -EFAULT;
+        }
+
+        if (msgp->hdr.flags & VFIO_USER_ERROR) {
+            ret = -msgp->hdr.error_reply;
+        }
+
+        g_free(msgp);
+    }
+
+    return ret;
 }
 
 static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                              ram_addr_t size, void *vaddr, bool readonly,
                              MemoryRegion *mrp)
 {
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                bcontainer);
+    int fd = memory_region_get_fd(mrp);
+    Error *local_err = NULL;
+    int ret;
+
+    VFIOUserFDs *fds = NULL;
+    VFIOUserDMAMap *msgp = g_malloc0(sizeof(*msgp));
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DMA_MAP, sizeof(*msgp), 0);
+    msgp->argsz = sizeof(struct vfio_iommu_type1_dma_map);
+    msgp->flags = VFIO_DMA_MAP_FLAG_READ;
+    msgp->offset = 0;
+    msgp->iova = iova;
+    msgp->size = size;
+
+    /*
+     * vaddr enters as a QEMU process address; make it either a file offset
+     * for mapped areas or leave as 0.
+     */
+    if (fd != -1) {
+        msgp->offset = qemu_ram_block_host_offset(mrp->ram_block, vaddr);
+    }
+
+    if (!readonly) {
+        msgp->flags |= VFIO_DMA_MAP_FLAG_WRITE;
+    }
+
+    trace_vfio_user_dma_map(msgp->iova, msgp->size, msgp->offset, msgp->flags,
+                            container->proxy->async_ops);
+
+    /*
+     * The async_ops case sends without blocking. They're later waited for in
+     * vfio_send_wait_reqs.
+     */
+    if (container->proxy->async_ops) {
+        /* can't use auto variable since we don't block */
+        if (fd != -1) {
+            fds = vfio_user_getfds(1);
+            fds->send_fds = 1;
+            fds->fds[0] = fd;
+        }
+
+        if (!vfio_user_send_nowait(container->proxy, &msgp->hdr, fds,
+                              0, &local_err)) {
+            error_report_err(local_err);
+            ret = -EFAULT;
+        } else {
+            ret = 0;
+        }
+    } else {
+        VFIOUserFDs local_fds = { 1, 0, &fd };
+
+        fds = fd != -1 ? &local_fds : NULL;
+
+        if (!vfio_user_send_wait(container->proxy, &msgp->hdr, fds,
+                                 0, &local_err)) {
+                error_report_err(local_err);
+                ret = -EFAULT;
+        }
+
+        if (msgp->hdr.flags & VFIO_USER_ERROR) {
+            ret = -msgp->hdr.error_reply;
+        }
+
+        g_free(msgp);
+    }
+
+    return ret;
 }
 
 static int
@@ -218,6 +347,8 @@ static void vfio_iommu_user_class_init(ObjectClass *klass, const void *data)
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
     vioc->setup = vfio_user_setup;
+    vioc->listener_begin = vfio_user_listener_begin,
+    vioc->listener_commit = vfio_user_listener_commit,
     vioc->dma_map = vfio_user_dma_map;
     vioc->dma_unmap = vfio_user_dma_unmap;
     vioc->attach_device = vfio_user_device_attach;
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index aed7b22e2a..c8ae8a59b4 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -27,7 +27,6 @@ static IOThread *vfio_user_iothread;
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
 static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                      VFIOUserFDs *fds);
-static VFIOUserFDs *vfio_user_getfds(int numfds);
 static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
 static void vfio_user_recv(void *opaque);
@@ -132,7 +131,7 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
 }
 
-static VFIOUserFDs *vfio_user_getfds(int numfds)
+VFIOUserFDs *vfio_user_getfds(int numfds)
 {
     VFIOUserFDs *fds = g_malloc0(sizeof(*fds) + (numfds * sizeof(int)));
 
@@ -618,6 +617,43 @@ static bool vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg,
     return true;
 }
 
+/*
+ * nowait send - vfio_wait_reqs() can wait for it later
+ *
+ * Returns false if we did not successfully receive a reply message, in which
+ * case @errp will be populated.
+ *
+ * In either case, ownership of @hdr and @fds is taken, and the caller must
+ * *not* free them itself.
+ */
+bool vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                           VFIOUserFDs *fds, int rsize, Error **errp)
+{
+    VFIOUserMsg *msg;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    msg = vfio_user_getmsg(proxy, hdr, fds);
+    msg->id = hdr->id;
+    msg->rsize = rsize ? rsize : hdr->size;
+    msg->type = VFIO_MSG_NOWAIT;
+
+    if (hdr->flags & VFIO_USER_NO_REPLY) {
+        error_setg_errno(errp, EINVAL, "%s on NO_REPLY message", __func__);
+        vfio_user_recycle(proxy, msg);
+        return false;
+    }
+
+    if (!vfio_user_send_queued(proxy, msg, errp)) {
+        vfio_user_recycle(proxy, msg);
+        return false;
+    }
+
+    proxy->last_nowait = msg;
+
+    return true;
+}
+
 /*
  * Returns false if we did not successfully receive a reply message, in which
  * case @errp will be populated.
@@ -666,6 +702,50 @@ bool vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
     return ok;
 }
 
+void vfio_user_wait_reqs(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg;
+
+    /*
+     * Any DMA map/unmap requests sent in the middle
+     * of a memory region transaction were sent nowait.
+     * Wait for them here.
+     */
+    qemu_mutex_lock(&proxy->lock);
+    if (proxy->last_nowait != NULL) {
+        /*
+         * Change type to WAIT to wait for reply
+         */
+        msg = proxy->last_nowait;
+        msg->type = VFIO_MSG_WAIT;
+        proxy->last_nowait = NULL;
+        while (!msg->complete) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+                VFIOUserMsgQ *list;
+
+                list = msg->pending ? &proxy->pending : &proxy->outgoing;
+                QTAILQ_REMOVE(list, msg, next);
+                error_printf("vfio_wait_reqs - timed out\n");
+                break;
+            }
+        }
+
+        if (msg->hdr->flags & VFIO_USER_ERROR) {
+            error_printf("vfio_user_wait_reqs - error reply on async ");
+            error_printf("request: command %x error %s\n", msg->hdr->command,
+                         strerror(msg->hdr->error_reply));
+        }
+
+        /*
+         * Change type back to NOWAIT to free
+         */
+        msg->type = VFIO_MSG_NOWAIT;
+        vfio_user_recycle(proxy, msg);
+    }
+
+    qemu_mutex_unlock(&proxy->lock);
+}
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index aa8f3c3d4d..44dde020b3 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -13,3 +13,7 @@ vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
 vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
 vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
+
+# container.c
+vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
+vfio_user_dma_unmap(uint64_t iova, uint64_t size, uint32_t flags,  bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" flags 0x%x async_ops %d"
-- 
2.43.0


