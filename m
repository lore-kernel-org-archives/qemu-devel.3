Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EC9CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 11:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wci0H-0003bG-CQ; Thu, 25 Jun 2026 07:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wci0F-0003b3-UT; Thu, 25 Jun 2026 07:12:16 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wci0E-00046q-0x; Thu, 25 Jun 2026 07:12:15 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P3cpID019879; Thu, 25 Jun 2026 04:12:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=cS0c4VzjyzxQH
 o0zbw7qvV/ImolFtCNB5oYxuL7I9wo=; b=s9C8l1C9JOLpwCwV6lzP80D196SqF
 BRJEQcXvqkNr0SyWAA4wVp0XYgYTmFUouOvcSa6Z/g7RGCGB1DwotIVWxPj9xYle
 iz1wfbRV0metcN3eVydK9hrlBTLqDPkRa9rLB/WtGU6NrT9EbFPXOOyGq2mh2Jy4
 1biNqmuV5DSqKiRc4deTGYZxMH2ZuEt95UfUgkIRk94KJZjFhilIiMQFQXrPRYN+
 D80v7d1dvOaAzDs78VclVgV8tnB+r8aZDz/GTjK3PGPLlSsjzD3Q+iGDzQPuZpwz
 H+cqGR0ZSa/ve+kcMKwSEHtpwk1oy5Ygh51Qiht8Qh37GP0IaXR90/dCw==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021104.outbound.protection.outlook.com [40.107.208.104])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4f0ce935r5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 04:12:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkQKea2zNaMWVY5J7NrVPUbUL/H9LugiQHl2wFloV4bHz0rYAeOc5eTsLBshd64AEKFDEWttaXg+4X/F/2ZejVNcOGcexWLIq14CjQw9lraFaRexuw5O5b9UUNbXtvpo3BO05pMxmgyx48GuteIIoUOXzXKAjB22FD1zkUzaZDJGKshdccYRS9pKq3+BxDubeFdQQDBex2T23RJs1QNIeQwRF2WSC04jwD94AE2wcIG9uzOi+BzUQjqstx7fXWs8XAHOVaJ291gneVNXDxZDJkx+R3NAcoa5oMyCZu1qHhcQmZiOtxxtEn4X0SuFDf7m8ScSOSqguzDOI114vUXVjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cS0c4VzjyzxQHo0zbw7qvV/ImolFtCNB5oYxuL7I9wo=;
 b=sR3GkePkoqt5wAE3+eQs+mI/+y/OxgPEno1ecaiwOtg1MGuZNHCEgcfPQpBx9PoPzvj3C6EUa6fBKcbzk3OOtTBNP0UeMZmMulRSFAJG1t0/r3f00Lx9yfgwnXhdJRsANwIGVCrQi+vM30191V7x80bUo+bqz3zve4oNweOrMEFwy7yvp8pGYFTveajh/qF4oldVTxM7Skaj6UpwOtlz8fdjCf0VnDr7x7kXdb5OegDU5lPwsGi3jOxQlD+s6JM4amCvJNeFHITbz26dx/pKaFhgKcWUl1IsOt28x2ZwP5/ePrw8YybOD6iQohOG+JwRC4GOR+JCwz+3DIP1Xh3eeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cS0c4VzjyzxQHo0zbw7qvV/ImolFtCNB5oYxuL7I9wo=;
 b=PsZII5pBA5R75CecDNLBNmfJtoWQWizi9qGI4y9XTFl9fImlKhFwHeX6m72bLCFzVTrKwU3EeAaU6HibblsygwQ6WNc46MPCUaiJ/PpSPNr0kIAAlRuFPhoxhkTKNEOhgANyY2pe9yhKTadHd4g1OBgAhmbPi3zE7WivI0hrHd7Z/SpKt7r1I/aVbvsFGZCv+H/gwwQ6JZpqB1w1gmATHFoP45Bmm6migKP8En+kb9oAZ2HLwjuRI/4Sljam2tKqzlyYY1FudAkYt046YgQNESLaWE21pBCFiQoz1H2i7z3bSuEiOl7GJxdiRfOCtj39KdKdmOxn/dMBtEasji72pw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB7869.namprd02.prod.outlook.com (2603:10b6:408:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 11:12:05 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0159.016; Thu, 25 Jun 2026
 11:12:04 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: kfting@nuvoton.com, wuhaotsh@google.com, alistair@alistair23.me,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/1] hw/adc: convert object props to class props
Date: Thu, 25 Jun 2026 12:11:16 +0100
Message-ID: <20260625111201.1645847-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYXPR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:930:d3::25) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1ce1ef-62a2-47f1-bb6f-08ded2aa96bb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|56012099006; 
X-Microsoft-Antispam-Message-Info: YM5IBJiwLHitOM5Nle7YpsJJomn3Zii0xUtZNMeJOZhOMHl3fzE8H42sXgoNRXyjy4dfaKAG2DfF2AxyPaPqgi9o+dquwQ9nTkJxzNJCyh6PrbQTJU4/3S97B8LpBt31U+GM3cSPnJBfc8neisRj7R9KF/NLVwJLNLLY/tO0JqAHRQPr1gA3yARFnCRPLeDdEdtHGcrMtqWqAXasBuP0gKZs68Ov0boJbnoqu0Hp+1r/kru5H2Ala0TbQc6T73qlIEIt1+ytMytkVhERtTDqeEWOw3zPw17yqzEBQetyrqbt0DKIzFVOx+aI9utRfHA0l+4cL2dZzmzkNuov0UMDwwRyElFDHuYmLxjzWtQMLLEGEnyvCUCSjVwfAB1gOJJu2VPS8aDU8dWM2NTRU6KOyvx7O9Q2pSOO7gSJvu6NX/dhMbUPkzFmnF9Pxwq7gZM1vZRwDWRBlO3IkWHgaQWfDx4EVIjhUbwKE0igg/+WLqcvMnGjsa0h6L7fGydAOth0abYGEgejoWGEZM10dKPZJn38druS1avfE47HC+uk+f83dS2gjExpnwQxronGaVIS/HyFoLJtz2yMIj8gQliCFQNzeuY6Gb1fV+SYD+ci9f1DKk9LtQGTzJltRWkRlOhr1B1MXT3LOJxHEjgRXUWSlhPEWIARrXr/pvGkuFwmkTM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WHwiMLXryojbkoY6FbkWc9TbhypJTwR4WR9pA5dLUXVEzPUMtWOUTQs7bMQN?=
 =?us-ascii?Q?cssUeiPhtvW4xUVMiMuNdNdroUZmB/4X+F8S/5bh+e2eA4RJguVA9YFaXfhp?=
 =?us-ascii?Q?hhhBWr99d0ampFzouAn3DVYiZDXtFNiURJYVmSs8kTj1lCPlx1m6Go3ZmMUI?=
 =?us-ascii?Q?1GhrLG9bzSlwoQrUrw2k+qpFZ0Z6UnaFPboa8dJdkCdKxWIJo8kp3s0wMf41?=
 =?us-ascii?Q?L3k6Tf04RtiLoJdhr3CkGax2VqvngZjxZ1/ctqVnbz2e+Wji9gujPX5q4KUq?=
 =?us-ascii?Q?yvJUD6fDzTs0I+2wGHlTiKOkuh90eAyntsVk0wQ1ak4Ijkm2KJA6ZynBHQaY?=
 =?us-ascii?Q?dtHVQWJup/jwFlkV2H/icb2NgBh00Xn7e8gl7qpq0ajmU1unkYtMHwrOiSVZ?=
 =?us-ascii?Q?KBSspc822yjExqcIo5AEk5Rla8amEufjpO8T+ulVghEeArdNWGCAO0YmHG1x?=
 =?us-ascii?Q?F5CXOj19v5mhMSHMmV4+mfD8TuVLwlLqNr/02P0cKAN7fxUHX9FB6l4Yz0Ex?=
 =?us-ascii?Q?WowlHP6Caz5sW6GnjFMlbZXn+zcGXcsTX8goiBPA+dDN2QFaNAu4CxOnqisy?=
 =?us-ascii?Q?gNpBjtU4IfZ3dJPxcv+5quHtculYdU8Oc4tzl6zr45QktnZBI6NFNx5wDFn+?=
 =?us-ascii?Q?eVco8GYiqNoOMv4jdVVRWYT2HVjJWRxoGboMNHF/oVxBeOAVp0ltOnQNlfsf?=
 =?us-ascii?Q?9XeUTBESE6nHSCghj6Ti50A6Sx+Y5wPksqkvzSSLPRHhyOBZWzTrtMbfA4yI?=
 =?us-ascii?Q?TZR6KvP3ixj8gflpoW12B4VZdoWcrtsKU/3dKohVBKklSFsmNr4qwjP0DeME?=
 =?us-ascii?Q?LkAuAlmqWVThmfIx7e6tu2EhyPzKLqT1nDjlAp477nHj4IX8MO0He+M3ogxj?=
 =?us-ascii?Q?zGxOSfWv6OEam2Lv4ERWOAK/fAQgWC0zWyjayqY0adSKdP/7bV7U+Ennq/zF?=
 =?us-ascii?Q?aKulCOzlyynxtpg+xN4R4uJLG3lo0FH6gykWTAq402ID/PPQiHg2DId2sZaW?=
 =?us-ascii?Q?6xRXBQEGPfh9vIlmMoUktchGBjV+IHuQ5XFeGuWdNc/oNZs6vBNn958CeX5l?=
 =?us-ascii?Q?lEDDs3UHncMPvffepafry7m78R6VEy6/XXVy36Blba5uZYGhQEiRfqSLwUuI?=
 =?us-ascii?Q?/77MEl0avnf8+Ue7N9jBrDouitvb3xYfZ765LSdJT1ILILCGNLqXDVpyZ1i3?=
 =?us-ascii?Q?hGpjeLbxmdR5RL0+ruQPR1JHIJ9GBkZOQOiDcG6oMXpy1zJpmWJ6qHwszsxK?=
 =?us-ascii?Q?wyv/fnJS15IZn0YBO6olnc6TP8Kp6xhznO7eCuDAY+DGbYRWnsx/HgowZGsY?=
 =?us-ascii?Q?PfTUhNpeBfy/z69WTHvAacZ61vQs/WBOvDs+GkiwqF69CkOYBnsP7ndeQODZ?=
 =?us-ascii?Q?jW6KIiPHw3uXEzT4Ami1nM7twKcl4J6Dg8FS4HGTeYoWF8UWVjwSskbcRw+l?=
 =?us-ascii?Q?tZFM8Shxqt7zayUnizuIvvJjI6xGXmjD0UQsvBdIToXjQiLTWVyHgTZ9V+8V?=
 =?us-ascii?Q?k4HnpuckmzhgLyXvQm8scv+Z9c0xAtp/x+hsfG5QqtzqN23jaX5cUVUIjzXc?=
 =?us-ascii?Q?BbMwbNuDTL3ckkuxk10LRY0KzkiLXkMqIMLdk2pzyhzKCYNnhGBP0VO9pS2F?=
 =?us-ascii?Q?vHZ56jWZWAhBsVYMRWNHnj9vJxKqZDG0UHWSFLEo6TiNTXGCsS5g45Djse0G?=
 =?us-ascii?Q?CHl2Pu0Cr+QdfwkTlRwMVQg1IIPyBBQIkSVYAoSG8tlby36Q5Q9Uu59r45o7?=
 =?us-ascii?Q?huDjcT5kRdPapwfUBPyXpGqCUO1E8/s=3D?=
X-Exchange-RoutingPolicyChecked: nyQmiHPYBo6Zyb+bCpuIrWWdYhnYieXOfKoKELQxw7BKaAjGMd9TJXMPrBSu+9slCJujG3Esg1mOvdruV1XLaEDscTaY92tJVztgJVdwN+TYQFr/jQydVWkk28rvhdAG7U2zzINtpZByjde93p0YyJIHJ4ksu2rhcm++uPofvr01cMs4Gx6fYAqJ083wGGxHvOc/1IAEYGknc2ov38s+chFLrbTGX9wA9MI9gPdcuzIQBxfzJ/NZkRXYe3TJL1in6G/1PY9UZgYetTO7jtgIWJGiazyXc+yQ3xFMYIKDO/oxGbgPpkiMN0xJ562T8VtLOU/Hu4BFLIJKSMmI/zUk9A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1ce1ef-62a2-47f1-bb6f-08ded2aa96bb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 11:12:04.9339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4O/XmWdYjkI86w/xvFJBF8FPfebiA6ontK5hlEL5fy+gTUN/If9CtZfIVxP/mW2ttHaPrmrXnQBsYzeQtpcWH18jXK5qXIUAunllq5DTGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7869
X-Authority-Analysis: v=2.4 cv=RO6D2Yi+ c=1 sm=1 tr=0 ts=6a3d0d07 cx=c_pps
 a=jSq2D0RH6kfjLa8OhrZnlw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=Oov7GBWg82k6lRvLM3MA:9
X-Proofpoint-GUID: HKB8yNTNnfifersS9DXaTfZG5JXx-GlB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA5NiBTYWx0ZWRfXwHfU04e92+aR
 TS4uROUylo2QLuBXgcEntHn4KmPdgtKhnsvcZOmUh4boTc4BKS7pNUGw+p+/8UyoFcaubut5pW/
 1Uq7pDK2+tJImiXJHqMu3AsTvb7rXZo=
X-Proofpoint-ORIG-GUID: HKB8yNTNnfifersS9DXaTfZG5JXx-GlB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA5NiBTYWx0ZWRfX0eEjFew7J/OI
 f0lVtkg5WLpQsBpCL4pWOKLlvvLHXFxPvffVIN0xN++5z717rhENoT82XC6Unb6/vsnSA6SJBdP
 n7syKIrhHSJugTg54wQ09BkjIjWK+P55qA99al3EhjlaZiVMBZ2kbgA/HQgHg4ZfUo9tbU2hhps
 /7UGZT0TRzmjKT/SEI1cB1/BZzWmzddtb/eUZrdNCzevRohFloJ4ykKR7z+6USL+jDdSuY4Qr8T
 hkmnexniGFW8e5s6OWRA3OTFIy3bL/54iWA1rhxqGWxL1+9KaSbMetGzX5iaIhDt/GzAeuqKzYI
 miiz1UvqwRp7+yiuSPc8dOyr91XcnNbMN1PxmSRZ9AcrSo3IPYKfyvHg7bP8L7hVkG5l1Vcr6Ln
 edBiGetYBWcCdJjlCJEB3J4hkceZsBZVwqWcQwoIZZxnfx8OX5mo8rc79gbBKXJrsEMWQwVVmKF
 ISCXaxNi6Uqa2/eSIZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Since the use of object props is effectively deprecated, here is an attempt
to convert all use of object props in hw/adc to class props. The eventual
aim is to continue working through the codebase, removing all remaining uses
of object props.

The series is lightly tested: it passes "make check", GitLab CI and some
simple local tests. I'm mostly interested for feedback on the conversion
strategy, and to get a feel for the best way to merge this series since once
the basic conversion patterns are in place, the same patterns can be applied
elsewhere and it would be good to minimise the merge window for such changes.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


v2:
- Drop support for "foo[*]" notation, and generate the array property name
  directly as suggested by Daniel


Mark Cave-Ayland (1):
  hw/adc/npcm7xx_adc.c: convert NPCM7XX_ADC object props to class props

 hw/adc/npcm7xx_adc.c | 77 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 7 deletions(-)

-- 
2.43.0


