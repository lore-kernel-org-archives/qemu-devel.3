Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510E9C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc4E-0006EX-Ji; Tue, 15 Jul 2025 05:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1S-0001QD-EP; Tue, 15 Jul 2025 05:32:28 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1K-0005pz-I7; Tue, 15 Jul 2025 05:32:26 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F94iUN013681;
 Tue, 15 Jul 2025 02:32:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=VetjzGUbDRaSNJEmwZNU0fOjK4pkFZyIQrw1ziqlZ
 MY=; b=XIgCS2QjFiCjdToIz3JHGPP7R+rPtvLdrKkx3Vc6X+QKGKSb8mq9dGz+i
 gZgo3XsTOgl/ODwq8F7VzUi6Bc6VROE208r4gjXWryghrQWXSKYpD4y72bRVV3gG
 PgeQBDo1WyQOBy4XmNuONzzo5EFLPUZs/g583lfhwR7mfimzGsAsInBZEIwWSkJ7
 hKLnu+yf/d1QaOJRJwp1FP3a68D30uuHmb3OdSDyH2f4dyNMPUUc7rBRD9lJtIBo
 Cf949FduKHKr1kxm7BmFVT/OkfuxGosZy/QUrzStCSA7RnccnZSusT9nYjBlw64r
 P+opmCGY9fUQo+Rh0khj+YmIjan6g==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2123.outbound.protection.outlook.com [40.107.244.123])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47wm1s8243-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0QLty2nl0+5sWKK7QszudM/sFO2A8rXm1s4nODxVUD3mIRaQoY8TqtkPs8cEzoXQR6QcCwhVBDVTUecnbFlT7X+XjYNxgaB0SJm6sdtA7x0zqwsS5ZcAzlQfiFJQvVB3SLzI3mVl8twQARLs7DffZV0AjdEX9fUv4D2NhnNTuaKsHuh6rNddQnUHMJyD1ZHnAtrtVROANVAfWi3zrWyDvMdhNcMT6Oh4kQ+7myemzOvb2TQmByqcaubK8PM33nsjiNGzD5m42nxHazDBS5wt08SZgB3jA7jBAwOUG6GAEBNktMmpL5NNAZwSR/Ua/tVFYaeKgQlELaVVeDAwDRPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VetjzGUbDRaSNJEmwZNU0fOjK4pkFZyIQrw1ziqlZMY=;
 b=Mt8RmUfkVK7dtSMiLZwmp7ik64CB0zqsu12mIZesjq4Op8sXGNwhuQLpwGrX5h1rf0tHA6qaVQ2sf42ByLis63bR9NOyhiIbSAlib0tavP8U+uMIekWkfy2rVAoGU635RBX1Mbc6135ypQGtDIuc/ARV8yVleI99uo97iKeNED9YmQcRsfMQKxGvKE/AAoagYnejGh1PRt2LNTE6k52h7CYByozHjI8AKPMGxAuWEoJcUyXMlkCQ03TXphA5u41qXW8hgxgAYgpvMxLlUpATi2S1fxyWk0RBqC0Tqt/u/UIUz6nwjTNBDcgDayHcaeRd3i7GRaZh7HgaJBUPtvDHow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VetjzGUbDRaSNJEmwZNU0fOjK4pkFZyIQrw1ziqlZMY=;
 b=g3qGVVzKswVPD6CS5m5v50NLAgEdmSbQlIFxvZmUKs7ULfkemi69maFPb9K4R5Mk+BSIjMTEU5v5g2e1r/ag8TXIsl3SZwxOF+EdFgkZzkS4GcwTT7Aon8DlLKnHHbsRWCzB1h76tDJ0qY04Ry7Dlrt7H2BSupvAxI6GflwqL2MVfvUikGm8I/8Avrm2fnfdTtCfooKFUYGUKzwbGZRiawLO1xEJpC0r159C+QjDdw4YJgCfV896FoF+W+dqz+uTpK3F4Xbjzwc1JegExe+11mfAET3vMZ5VXTUJk5gG76jAnOWpiuZ7b+tPeIyf/ZlIBygEINDh3WGaFdEw8YtdJA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9770.namprd02.prod.outlook.com (2603:10b6:a03:548::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 09:32:01 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:32:01 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 13/22] vfio-user/pci.c: rename VFIOUserPCIDevice device field
 to parent_obj
Date: Tue, 15 Jul 2025 10:25:53 +0100
Message-ID: <20250715093110.107317-14-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0031.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: bbed52b7-87a0-4cca-37c9-08ddc38273c5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I81JgrMe4gScrnupjet5C1z9Q5htv1G4smkZmLwjRSjktQv0+ruxJJO5XUUc?=
 =?us-ascii?Q?5j3Y7mmLBm0sRkZ5y1uG3vMcbDt64SCpo4ivyeHmkY7qqJihUix01MqRYj45?=
 =?us-ascii?Q?uqn3N+Ws5Dcqr5C5gNbcYjedR0G0Uo/8qkRn1T1MemxmKz9RCyWo1GLCagR6?=
 =?us-ascii?Q?ssFGkv/zfnxD2c06Z4wxtiXMaQzCeSWsh6MdzcMLd8rm6+55+1llouUvS/yu?=
 =?us-ascii?Q?MNpHCJa5b2ctmxlRLcIlyGJE6LdcnmeeFKBxG2xf7FCZaCL0TUBLPk5T03Gt?=
 =?us-ascii?Q?mZsHhe6Bhk8aAmYIBw6gLl+M8WDZqP1a7p5nopQn326kpbs2PYqllXjNYcgs?=
 =?us-ascii?Q?NY1igarQf2Ly/7C0ZVYWLMbMV7QHZaaISktUmQ7PMPI3dkS5atSTn96K9NU7?=
 =?us-ascii?Q?oTr0oI7NLD9lXr6o9RIIW7SUOrRoAzAVtbV42GMDNOa5z56Fz/I+2yMxmJdJ?=
 =?us-ascii?Q?t5hdoHKqRwgYgRUf6a0ITILm85ue3q0EHoMyp9vubbj8BNurlpv1kZLAW7E9?=
 =?us-ascii?Q?a2pJc+DxkZ5hF4pU9TmaivbN1UbO41tdoJA5LL+IlVWOVO9XpvcIsfoKKHl4?=
 =?us-ascii?Q?0Vy+GEbwL3nvSNp+k+pzrE4SsFYCRzziDi1TQncnMSuSy/oR9Bd3Uk12tX6F?=
 =?us-ascii?Q?dSjybXmZXujw/hkLTlgmF6CEk75LVcvOV9kU5k8AR98O/jY2QEFRbIgeN/kf?=
 =?us-ascii?Q?J2iol2DLBM2VTUBCia85zo2n/QrUf1dwFUm0M9nMtd7DrXFB3NhsHWRiijGJ?=
 =?us-ascii?Q?x3o1nUa/TE+/c2/Bro27p8A7H9sYDKfuXKIFVA86TdJ5Fhf/nh4EOqZFHUuj?=
 =?us-ascii?Q?P/9aJfp2vXJDdrz84/gIz5wnE2vZ+GSon5SLq79Qc6jxyQdCCx6t+cA4txTo?=
 =?us-ascii?Q?nNVAuBZQzR4wFL9NwbjKIsfIXIc9BE8MHcYmhgaLMgXbR5C+bxqVlzYHHcSH?=
 =?us-ascii?Q?SQItuoo314sMmd+wa6BxH68hVsLJ+CaYsKO/hb+ABFJ7LjLk3wmv5Vxs0z1T?=
 =?us-ascii?Q?E+LejTz2/gh1xC08wXOumWKxHorXcdlpPIhja6jndxZETPuZK83/iag1z+Mg?=
 =?us-ascii?Q?G4wFB3h7VdMn3ZNkvoTJwBXkK1KSgvjgtn0eq1jx6Zz43goPtviCLaRLcjeP?=
 =?us-ascii?Q?onLZwE+iIjcDh2UMWHNFWmWnCxF0QzIwojSWive3Wn6UGIhEK+iDBQNuduJN?=
 =?us-ascii?Q?LcTcAEqJsTT49Il8baWdUFbsmWViFTvV6K3pOdaWrB4KFGiJVGH98BEhtXKJ?=
 =?us-ascii?Q?pfJcb89wkbTXMJRvDDv54vxh4Lg+6Tmp4C/GB0lmseh3PufyPCKOGWtEOqq3?=
 =?us-ascii?Q?7ZWt+QCwemQm79AXNdUFZ+h1vhUNda0/+iNTVn0ElVJbi7jjj8Hq2SsRy2jy?=
 =?us-ascii?Q?MU0UA2plrdIQqRchePbbg3gmvbP7YQQH26gRsGN9eayi4PYp//2EoULIs+v0?=
 =?us-ascii?Q?uo7MC4CBZG+VNrp5BLEpbH2d/PRN43FHcnzOS94JYJbOL6El+BylWg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EGFQlQTt4aiCdY0JYFMWVGFES/nOZZ349L753EANU2VtrEEBiLPT0DPdQ/0x?=
 =?us-ascii?Q?c5aP4B57CpLjUaFYt42OcOAphbihjbfOhCjm6K6SfUey85Jha8wruagvXIDK?=
 =?us-ascii?Q?l1iLwJmGX+0xQ9sIVE9iK0gxZsnyZdNrs3HrpRS6hXF/qDo/3YSA+hDmJLPS?=
 =?us-ascii?Q?kiiM187ABg4Gl5mUUz+k0W9EevrKMuMZ1V8ZHZQ6I6qbMogreYlPJCs3F/8K?=
 =?us-ascii?Q?4J9jOh2NunGmtGKowclDg3+t1sOTtmpeW8rMnWs+QyRiv2elyI3Pf4loa/LH?=
 =?us-ascii?Q?R2AWP8eQZN1D+8mT/1NKIWYx1FTRLU10k0xMvnuC25JR1+2tW/C0u6XuccP6?=
 =?us-ascii?Q?CMJbF5oQiseZnF1SSqq/2LviKt0nL0sxiy2U6mCIR3s0G9/UxAJfBQ32sp8R?=
 =?us-ascii?Q?jJc4rDs9B9zYL+RCo4A+PYoB7uVVwkALsnABcgd3xMIz199ODdtfaqemPyzY?=
 =?us-ascii?Q?Co5gT5mrETh3bk5PuKfsZ2hNDZTcOxV5GFP6XDCLd3zzYiy5HFrJCtXBPBGo?=
 =?us-ascii?Q?3Ul+EjSU+WhgQLgECNFedTbjxpe2SG/jNB0Rw6VYyu+60MkkwiiMsTPzuuYy?=
 =?us-ascii?Q?WvUSd30rG6+tyyryk5dZP1A7JA3QsfC2vJSTad9jap1t6Umf4ztsY6GBD+ed?=
 =?us-ascii?Q?Z2pQ7eV3Qw52AW6RfbWJryzvaAjpdCEH00DJhbOro9agLXA/YHQNBaeZweu/?=
 =?us-ascii?Q?ddOPhPhlM+qYEY/4yn1GRMsgE3rPD+VHFytNZyOepwD38ShCakJ3++xTOaQq?=
 =?us-ascii?Q?q7P1FMPany5OPIoHPPCKfE0I0lQX3olVZU5OtMGFKUfI+recc3RKENzTDYej?=
 =?us-ascii?Q?MhUepNqwr0kQ23dQiwCqvWurvi6Wdgt83+e7TnCQDd9sHGIk4oGafLqaRfs+?=
 =?us-ascii?Q?pR1lwt2ie4Q2y8Xl2z1XS2uJRCaJQWT37yz78LRsgIZH3N+pW0K7aoliIs1C?=
 =?us-ascii?Q?U3/j8o7CHnAGVXxNrsQ0C4eejRHOCXBoO5o2wCLp8njdc9aI+h6uhoOPaZG+?=
 =?us-ascii?Q?PNMVt/EaHblwKrxgmy6YS2XgKsqHeme7VCjt4o9x5hblEpiKT1cnvWgDreVc?=
 =?us-ascii?Q?OLcfW2+eFsxR0ZljGBmLWGaa1/epeX1x51QBRV9NYsg+1SHDtOhVzdJwqgqa?=
 =?us-ascii?Q?tjWAntBcWbzpWyYH2FH/07kYs5SdvboJeW/7NOnIfpJSXbFrk7xHlz7uq+bO?=
 =?us-ascii?Q?+xUu9ZH4uk5Rj1TcGAuYtHiXEC4Y/Ls0SIHT1uFiRidcFvBiyivSWZJlHN7k?=
 =?us-ascii?Q?/pkaxbT3EMfNSbF9A8+KLLFYnImGRppP/cm0OO03UDvy/C5P5fBHLBgf7er2?=
 =?us-ascii?Q?5hDjTCmPQBsSJy25dkUAVViGRJ25Ij0YsZlCi4n1HqeTlf4cLjcK1hsogbR+?=
 =?us-ascii?Q?A1Hl65Es/F5yyH//Lwove/B6Sgbc7d8ux1dvXgigFKfcMZcRgkLIttKpZTuW?=
 =?us-ascii?Q?DPw115nGJcguDsoeasDUY/ro6/XXWhWBrcJw04tnrnINdg/47LPUrLO+oZzH?=
 =?us-ascii?Q?WSqlLDVngN+xOBT+HkJsaApoBHTutSs7UkAG901PpXrlVGKJttPP8B2AFx59?=
 =?us-ascii?Q?l24gPnqjLqgHQheuT+Q/j9cdZRJr7CUxS7dhxjdNUF8IAOVkPjwUxkeIBq4l?=
 =?us-ascii?Q?MqoxL1wN2QUsOJMVF5DBXJjSJa9bqj4FaXyku0n0zpowwY9VXdMf/qIeEmuI?=
 =?us-ascii?Q?EIfbug=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbed52b7-87a0-4cca-37c9-08ddc38273c5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:32:01.2823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQYjS11VHi9ikQkRT9y3m8hvWy9T5mgb/uP4A6IMZ1okWam7r5jOhUdSWGAYjbxUgc01cRzLPLVVqzM1I+6m/HCeWLf5EaHjsEPzaFmXZ+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9770
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NiBTYWx0ZWRfX5xuWSuPeucM6
 nBh6Xb2x+ijFCjjB0QxDHsqJ6ivp3fo1DLglaUHF0nRnsPxZZgprrHQ7DnjSv/hT5vVOiaRrgjX
 SBhTMZGD52c3xeCRpOGtyUgMUEcSHjrO8vhZam/HbdTAPiPpUWQrWf5siLHJH8169ryTpotsGZe
 EeeX24mMIosvp/RDrwPvtEIaJCm9r4gF/sTkjx2irUQ9wIaHA3Izsw5SwrFczaEXoWlZEZN/Ppy
 yThGcMlige8kA9d5x+FAi6nNv8aVjaZ6QOMCjiu8d9BD5hiextEkYQUMtgnPWbXDFjdVY/ZgCp9
 JvpAqUO6+KUc2cbvERr6ZFJBWFxkiS76GuOPKoHI/caEb5a4iG5U1WVa6JSEvWTousjDb+31nAX
 jNCZFzqtrUMULIxB0dyNRACu/9elA7NS2BKVmnPbgVw2TDOZAtTeClm4zWStFcvarXFApbZ6
X-Proofpoint-ORIG-GUID: 5zlWmtfdFbz4_cWlAdVQu0cOSNPM8dUL
X-Authority-Analysis: v=2.4 cv=fZity1QF c=1 sm=1 tr=0 ts=6876201e cx=c_pps
 a=iT0IPLB/rXRz/LGl7erAeg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=Im7LzKyiugD5FO9Ph94A:9
X-Proofpoint-GUID: 5zlWmtfdFbz4_cWlAdVQu0cOSNPM8dUL
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

Now that nothing accesses the device field directly, rename device to
parent_obj as per our current coding guidelines.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio-user/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index e23a941605..9380766548 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -20,7 +20,7 @@
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
 
 struct VFIOUserPCIDevice {
-    VFIOPCIDevice device;
+    VFIOPCIDevice parent_obj;
 
     SocketAddress *socket;
     bool send_queued;   /* all sends are queued */
-- 
2.43.0


