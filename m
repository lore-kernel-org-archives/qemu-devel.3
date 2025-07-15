Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EBFC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc4E-0006NP-P1; Tue, 15 Jul 2025 05:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1Q-0001ML-M7; Tue, 15 Jul 2025 05:32:25 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1K-0005px-Fx; Tue, 15 Jul 2025 05:32:24 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F94iUM013681;
 Tue, 15 Jul 2025 02:32:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=g4f5nRPHiSTJmDTCIp7OwgB+JT0XH/oIB3IEG5pa0
 P0=; b=AY3vu1cldUjwL5sapYMhJhSoZ45Qr+QrcvRzd+RsR/uX1pkzVRuZl5dIz
 LILFaW4mLfcG/fT0KQSV7593dYWg5dR9Z+MToKtCnhm4IBP4eyyXPofup27niz6c
 ILog0A3Ks0eXCJCJDIqMIJH8BBu8OfAKyceGglnnYSxRfs0bVk165sPrcxelyEwO
 yPPA3d2bMS8yNx9FsLCnliIJsex8+1t8qBF92QTDQGM8rVyt/fCHIA72vaYgyGpa
 9NteRIuiHdNc1TdSuuxLxMcPCYGwzZy2k4f7E+alEjyIYSEBbyTuuWSzK2q+tXRp
 mNRBXPCm1kAMy49rn9C+JrN/RgjuA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2123.outbound.protection.outlook.com [40.107.244.123])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47wm1s8243-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:32:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sf8wZZAKK+ZmCc8X8uWAgJLN+1ITA/PeLGkYI6AjXE/rEtJ4dwMwY19AEBI+VCjOSnuq9WCvMCYFOoqs/FxH5rh+v5Ax5rvuhtBiQgFRwC0M6V+531IRPgtEGxHuS9lt8Sd9Im2r7M8js0VqN3bjEefF6OeTE4ixJJbIIcFtnlg1H+1znUsdk2Y2WiL/KSlezr+OaA2qMPCJDjkh+9iipSmHj8HWvGi/dktgaipWAsi7VgwJm/87895ESaE6j3Ua/bAcBkbyZ9O5Hlig+eUL4vODxKg+fI3GpQfv+CVKkdDMGnqTY/ysy2oyOj+wbGlVhy4z+ucpzzeKmGUXoqEJyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4f5nRPHiSTJmDTCIp7OwgB+JT0XH/oIB3IEG5pa0P0=;
 b=JGL5whapTprf1DAyggkRg2E1qbcvgXDfuBRtaWaRmWKo5DDRuRODtKm8sNZ9wYm80DVALhllL7ahkczRIhykU74dYx//HV0lUqlvutQD49SnJDEkBbF5bFnD1nJK5PXlf4R1aCRQw2fty0re/2mIngGZX/AHMoHFc55tnbDOt3lPaGubjxNPQdXE+awaTxNxy2ZRpIFnNPv+Z8RKfIyPs+5fOG1N/NLJfDiEDIgaCDZTxM8TMGkeEbqFGEOmy5f48OiOb/XlTZstUPPSmNWwn7LbszsReY/bLxvGrfUtFXQdVFmBk+/6ek/zGUZIE+QUDexUlmSeBSstoSlzvMVrNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4f5nRPHiSTJmDTCIp7OwgB+JT0XH/oIB3IEG5pa0P0=;
 b=caqMHSJLyzIlBl8fFtEHAaseo4y/YaMRk5d7QC4Shkf7IsaXgHJhM9GEVHB0i+5m5j89DRtLVCfA6wQpCWsuw2nKyX5FuXIQKUKCk3Pg4UzgZN2S2NYnIEfbt6uYfpMJ4Id7A7tjms/tHYF+IkzZGV/8UdAl7aJVk3PYT5kAEHrMyM9cKL/qHDyrdMVqyHePN/FE8vHhEYMV8GY9c2D4RB1XbkaQRqEG2V7mFmr0oXIcZMUPJkZS8WqGelLeVhrYhzIS+if7KQ6wngp4gllffzHxfAc7z7nWI9k01dOr8gQ4/1XTmyffAI6Z5cw5lxyOi+cJ9D5pLTdrcoGkhzvlJQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9770.namprd02.prod.outlook.com (2603:10b6:a03:548::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 09:31:57 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:31:57 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 12/22] vfio-user/pci.c: use QOM casts where appropriate
Date: Tue, 15 Jul 2025 10:25:52 +0100
Message-ID: <20250715093110.107317-13-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0032.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a72d9c-f4b0-4f04-9b6f-08ddc3827162
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nWbg7qJfFnb1NTpNWc/L/MZ/WV9RIeQoFw/A1m97XZdZ+Plhrwm2ehmDk6um?=
 =?us-ascii?Q?eEzC6Vfp4KkfTIUU8x2NdxLN3rhN3yoyCGii/oyZgiu/wv9L2QvGaCyl1nDp?=
 =?us-ascii?Q?YzSwnJB2G4/vwI8HiVn7FLrclsCd+wV+gqJ7KsxuGflQfghDh1MmcCBF8C3H?=
 =?us-ascii?Q?w//BqlhrspuNgll+viWZKyPIJRc+dNk6GF3TKFfdti5NLlO/u7wQM3DrFFtJ?=
 =?us-ascii?Q?CuVBMCf9edFfhcx+JZisgFL1Qj5XvZ9xwUohobBDMyQabhLlFG8ddokmf1ZU?=
 =?us-ascii?Q?snIETEXRWFjpTC/itBMusKTZPw0F4wkj+MWbBsVMtd5w6Yz/WKoQNqaXgbUZ?=
 =?us-ascii?Q?nFkR+0OSXCCWiUDdb869f7O3CcvVKR9FQxqggh+ENl7xEq/EJZxi+RhCCfdH?=
 =?us-ascii?Q?yU4C27VkDwkSu/G++0lpGnEJ66LPmsHI2zVkO5KccxwS3nqvmwbyhl1GPbvs?=
 =?us-ascii?Q?yxl+DxY0DADKHzqM71LxN1PjihPsdiN8FNObwMKTRFG9q2Go+wsLmTNGG1gQ?=
 =?us-ascii?Q?n4GyYpa1wtqY69w92l3270Q46ZfQ1ItYfAi9NqnkNLmLfXwm+NaIBXzutq//?=
 =?us-ascii?Q?0YodsmeSYSR/+soeVYOxboiBpRt9vPerENHux7HIXQHBFo9rdr28B/Ta2x8e?=
 =?us-ascii?Q?q+9jsXipJnj1MTfsu3RKoSlCvGvh8av4GVSVd9sJhDpK6ULht294Mj+hnvI0?=
 =?us-ascii?Q?GJ7GY3Cft8L7kKhyVY2as+hzvCMXfgWzc2/wKjorbO3TRAqnDonyChZqwJLB?=
 =?us-ascii?Q?w1o5ezrx20yM43qE95QiLRnQMVWQdiiI6c1clO9Idfx60tdlYaIl4YRyJ1wv?=
 =?us-ascii?Q?3QksL49Xg0Ege2NqH4M0uZdA2vd9zmfPGMkKxQdB4Q8SeeVfl9E6042nWvnW?=
 =?us-ascii?Q?q5+XOtwOC2siQqqrTFqnvYyzUL6BDjVXz/3efHJXbfLxT/ju0SdAF4bnRUXj?=
 =?us-ascii?Q?OySPdYZ78LaIsMzUsfp39w57aGmyV70OIGvDPJPC72Uhdd7eQVZeSxvvILOi?=
 =?us-ascii?Q?hElDBipxjd6+RiyKUlIu88kFfApSbdJQt9YNMrpFqURGQzdrgXTKuJo+yzQx?=
 =?us-ascii?Q?oP6feAV7B/0zQ7uud7i05oEGxXklvJZSOGmFJHt/emGO6871tYvf+xmhOcU1?=
 =?us-ascii?Q?uZVRS1i+sSKYOxS7Q+GkQjfHUHq1TIkJo/Su4mgq8Mj/w1dCu4OZ5vfkSxKb?=
 =?us-ascii?Q?ygTVZvTaqG4LYFyH+6d+yVtqxpmS8FUj192fWGyR8omowZf9YvIKGuYv2Ctr?=
 =?us-ascii?Q?R4rbG8RBy2v9b8ZWEdbAcmkqnM55ApiChUZwF+87P0M5Vq0BFXoV1hCnW0p6?=
 =?us-ascii?Q?nTet+jxAc0oUYyrozaRGY11+m2ffVW4WiXg4+h2vkyP7YHs/8XLOAuFIETjL?=
 =?us-ascii?Q?wOTS1GI8aCidSXtAfPKZzjInN6xLe2n5Ob8mMW4Gb/Nf8xUqH6IqiZKUA5yZ?=
 =?us-ascii?Q?AsTk8U7MLrn4iRddVmQVEhs/V2OudS2qju2kQwNKwTVXYlcU0Du1TA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i9xL1cwvULqiayf1z5i8MNOjgEb6Rxws4GbsV7ekbkgDWqerk6lSbwbDzNJX?=
 =?us-ascii?Q?9pNsVUAn6JxlKgiDkoon63JGhdQMKVxE8Nl7DjMOIIQVRA4Cs+uCTk7qCIso?=
 =?us-ascii?Q?MXtG1dC0vq5C9Am/IeEKfFYpY5K/SkJQk1cXXE3BJzHwpIGSjJKifX4J7mUA?=
 =?us-ascii?Q?AYKSgQkBkF1RLckDwpaqc5JYLLqyT9gj/HiUuCTN2kQWrttMRbzDtm37HdV9?=
 =?us-ascii?Q?q0FDZgOeZvpAcdyNYZpMHxs7TqJNW/HiPGybAQU1qANxhmvaEGfrEKFqmDuZ?=
 =?us-ascii?Q?VoXEKPv+Vmv0V1Am5FzIZqGN9c0Dv4t4kegFgeBZ5+JImemvNOCFRT+LHsKC?=
 =?us-ascii?Q?aduLmkCPRmK4pB2m0Y2KOaBWjAxLrNEheioIJ/cTDkbFMZ16FtbL7WohGZIr?=
 =?us-ascii?Q?6MERaSSdCHGkKFG8o269QDz2y42x+GvPBEUsXDIDP6HAXXDtMUz9H52vq4MK?=
 =?us-ascii?Q?0+U3BmIZEjashIjwkUjlH9/tZW2aLZGRm11y6AJvb4rX9XVwLW//fV8jdPwY?=
 =?us-ascii?Q?ptP7d3tJ3o1oFhqqYbH75pWINJLQ4gxKEA/VxWNG9vSOV4vfvv1zeDQhFMd/?=
 =?us-ascii?Q?dqU/ON/PiWpnesaRGkw3iuzrF3N8UJkC4mkgEej3uAJU6WM/tPXDhtVwM90n?=
 =?us-ascii?Q?o3KyXglp+1IGjcVrliS7rGotm3n8+SUd7IXkUveYu2vHZt6ateITwZ1y6OH2?=
 =?us-ascii?Q?Jf45YtO8IOC/ZB1q7Ztxz+RCxcangb2zVOY8WB1H/EjIOgYRvwDMvqBqw/J3?=
 =?us-ascii?Q?y3kftvq4Z1rE/cfGqHv8/G8tCF8oUFrmaoZ3If35IcmJuDI/IUG4QRer/3Xl?=
 =?us-ascii?Q?KSyAshfCLyg2WRo1EOhFhdTh4OXzEjetWeCrpmp7AXz0FAxC3CgNfL8v9QCR?=
 =?us-ascii?Q?XdaYOzB2n64YQX6cUJgdJYdLC6jXHjunvd7jzLWA95VEGlMx5CRMciwPHJvl?=
 =?us-ascii?Q?IoqvFIi0Pitg5opG+GzyDzVCcG/G4s7pKt1Pg1oDO2tbr7PFiuRRd/VftQgC?=
 =?us-ascii?Q?rOQoNP/flacVzW29D620ZyaatTc1wzxKkmL6lfHdk/pW0UpTAm1qvJ5utxKN?=
 =?us-ascii?Q?pUpW1coH0S/Y1XJ+80+Go0p7l5EYAcP492EUDBCkgbsvLcza1vC6X1nB8H0R?=
 =?us-ascii?Q?e6xZAehUqCFiPoPM7WL7p3NJXzvZuHZ4LSAZ/YQJ1EC3oNIZq6ONssSWUvrx?=
 =?us-ascii?Q?qjPqT+fEYDk/icw+j7tiSSBj5yapvB7WUNErFpRHZ08F5FxgdUxjIuOA4P6s?=
 =?us-ascii?Q?stK3sAATdfxbqqA+YE3I0jeSIHszC8l5xcBRjwCS6/a2X93G9E+Z+hWUq9rd?=
 =?us-ascii?Q?/XfQD6rqLUbwmGRJwJEqKZKezDPEYIAaxHuv+cfkdaS74m4nRhuaja01nvOI?=
 =?us-ascii?Q?nWqtcRfLIb6YSDwxySIr4gRnypfmqzTOsodlDkw31NFCxt01oZ2Mmqsc8VIm?=
 =?us-ascii?Q?PfvbjTr2hmDOYdiG4DiAf2QnYVUEv8r4Q894dBde5eXhwC3JVPUqCNtJSztw?=
 =?us-ascii?Q?2nFs3DwJVzkB8CeXZIeDY+wXmVUwZ2Q+BUs1i5T6lBaOc3dhZVO+FYouKMAz?=
 =?us-ascii?Q?x2h2pPq1DfYVaQd2h3RV1ICXG/X1no7g2+fA442qUZylrWXXc2dM7CfeEVlO?=
 =?us-ascii?Q?b1KXZrixpN7r1x9p74Cdh+tOnmRVEs6rIFPQHkKJ8Gfbxtw5jpj2Ale5H53y?=
 =?us-ascii?Q?Qaw/+w=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a72d9c-f4b0-4f04-9b6f-08ddc3827162
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:31:57.3731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPaab+1MF3uEK3sf8NRr9+cmYvudUhRiNZgcfXZ5dOzQwMbDlIEAgBPUAPGrXfX/be93CxGLsZ8Szfg/ojdq7QVw0ddYWrCb168okQ6427g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9770
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NiBTYWx0ZWRfX30kKcbciLFpg
 ASepzul7EC6JRRIhMUmsELtkTT425EzmTu/v0cucJgZ/6c2KFE1bx/H0pRGgjaiRnnu56/+h7Xn
 EU5v+yXupMj1Zm3gCcsFSDcK+/PhQAEgW5i5J0H41AW8/lyPR8TnjNvcg9lcUppoF2Q6dgmvc50
 +CA2SvUPRLk7DxDf0Mdlt0qx0NoG2magO0EW+9n4MBhNEd0338EW+aT6h3etDmZgzii98qPKfXB
 vdlpIH+YeuZEG0FmGEpUkVsE9XKSLbyE2IeMwJMZoZKZfIzxph9q1rI1JZKo+udv+JuMZUwxfa7
 VAFmiw6X1E/E2Xo6gFmYdhfUV6vvxHofxbTabS+ibiZMJaJxjyaQ1dd0Ubq6KfTI0ZrTV43c45L
 rcCIygNAGv1EOZXWfjaO2pan/v2+i8iPZGUxJQoU0mp48OCqmE0dmhtd/L3P3wqL4WJr6oIK
X-Proofpoint-ORIG-GUID: AIpgYV5q17E3X_tWRLAHTukX5YgzLCZj
X-Authority-Analysis: v=2.4 cv=fZity1QF c=1 sm=1 tr=0 ts=6876201d cx=c_pps
 a=iT0IPLB/rXRz/LGl7erAeg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=Cd8fGpYwzwJ05QozhWEA:9
X-Proofpoint-GUID: AIpgYV5q17E3X_tWRLAHTukX5YgzLCZj
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

Use QOM casts to convert between VFIOUserPCIDevice and VFIOPCIDevice instead
of accessing device directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio-user/pci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index da6fe51809..e23a941605 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -214,8 +214,9 @@ static void vfio_user_compute_needs_reset(VFIODevice *vbasedev)
 
 static Object *vfio_user_pci_get_object(VFIODevice *vbasedev)
 {
-    VFIOUserPCIDevice *vdev = container_of(vbasedev, VFIOUserPCIDevice,
-                                           device.vbasedev);
+    VFIOUserPCIDevice *vdev = VFIO_USER_PCI(container_of(vbasedev,
+                                                         VFIOPCIDevice,
+                                                         vbasedev));
 
     return OBJECT(vdev);
 }
@@ -418,7 +419,7 @@ static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
     VFIOUserPCIDevice *udev = VFIO_USER_PCI(obj);
     bool success;
 
-    if (udev->device.vbasedev.proxy) {
+    if (VFIO_PCI_BASE(udev)->vbasedev.proxy) {
         error_setg(errp, "Proxy is connected");
         return;
     }
-- 
2.43.0


