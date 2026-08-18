Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF114C5DF84
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 12:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwIi4-0000og-3t; Tue, 18 Aug 2026 08:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwIi2-0000oE-1Q
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:14:26 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwIi0-0001KC-9l
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:14:25 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IA5V233615940; Tue, 18 Aug 2026 05:14:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=j/p/+BpTj5SFt
 YFOL6eu5jZCIb1jOhtuTddtGl1kt+w=; b=bcy4WiyaoYllRNIAU8wTXy+Rq6uxN
 bt2V+ATeGLNOjse6pbpR2vcIFJQMoRquRgyW7pXhDlZK7bcbYeHU94z34R22snW+
 YNhNa+VGkhpOC5ql6LZMElYfdalEEvyHAgTN5I8V1ViPJU+byciaA5GfOd5y8Rte
 F1YNNoIWrKKIln1PMcIb/rr/Sm1vBim4ylQFUfkgCp75BGxLd7UNzavtqXjyt+xW
 cdsHi0lBOW4gzdKutkdskvJQiI+43mL1eXEZZoI+7jKcfhgqbjqtBDmY1XlO5LJf
 EN5rr2t6sOqNmKBMsefOwTemhBlbRpsvxAn25ToFmJXNay1GBJp+E2EqQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021133.outbound.protection.outlook.com
 [40.93.194.133])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g2qe9efeu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 05:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDLHGluzOEKLxy6tMRYGobfPiSjsJzOVR+cEau/oZuuGapWvvNWxJcJ58cazeuynX63N7KeboZ4oQkvOx2iTNWPC6k0d+peDShI7njdMlrBDoXTsd5IViij1IProlM4s0ndst4sNwTEe7y6BCjW0oW3+y0DmFWKyCSAF2odErkOxQ5ueQ+6xVhannn+N7h0ooFjzn4ebe5a9PUpo8TMguNq+v/BsIMfnu88xWeMNNQvUCWKB5K/Ic+/56saCfwKHuN7yBogztvJbU2KfiFv/RrQahg+eM4ZzY8IwcJPEBr9+Uiqu7Fy4zO6/EIe0UyWuXW0g9rqNZXtOOc4HbsTAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/p/+BpTj5SFtYFOL6eu5jZCIb1jOhtuTddtGl1kt+w=;
 b=ycP3hyLO7yhgddlTiwB7bXToKMqiggHWrXCSP23bRAI5G+ECj6JDO46pPCco8PRWFpcKaDAOiLsHWV6Sn1jKoTsRVQM4jGhNk2cevIOFbe6ag0fygu7ka0/SOdnNcmmL2QZduw+9dTK5vQs1aIkxKaFszzlmr6Xm+5z5TjP3Moc7n/W2sRN+hCLcO2mCxQV6DIvpe2azjd94fnXkq8yLi6rmf/Tc9yPQPg+cm5amLBRO644QXrEMhrIBhIpvMA6cK8z0TMON+A9/ZxcRY0h1vXiKMOXy1VKw3X7iK5XRGt0O5rWQ9g+Q4rWgzof0JTLDPHWukSGgqKFhL1hgghgIBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/p/+BpTj5SFtYFOL6eu5jZCIb1jOhtuTddtGl1kt+w=;
 b=eA7f851u2/cClWD3lMMdi9yvG53TBP9MQez/7DIzkRzeX4EaHyY/TB8c/RieCoeaUPOrqaSkwyJ5mp+0Uz/N8SKg1fpvs2EZ6W9ptJdUj1Z8pu8zupM6W4XoDHs/1pUlwKdnLE5dRd4yVngyTK7Xad0dXRxejA6OCRVLOI6L2qW95LrAEAd97Gq0b6dMcFllY6cXneYnkiJjS3ZrmVOuRL3LhxA5qiec2IW2DYZwuxqMsvBm33gq14jt1mnNH6v/f3ngqepgvU8SiOh3OPZTD0Z9SDXDbuKZlgvgvuGSsujRLUu0QoaFOJDX92F0SPAEV3E/m06lyx+tSTUnf4BBcg==
Received: from BL0PR02MB3827.namprd02.prod.outlook.com (2603:10b6:207:42::26)
 by DS2PR02MB11260.namprd02.prod.outlook.com (2603:10b6:8:332::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 12:14:17 +0000
Received: from BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd]) by BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 12:14:17 +0000
From: Lukasz Kornicki <lucas.kornicki@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/4] Add clipboard status notification to VNC
Date: Tue, 18 Aug 2026 14:14:09 +0200
Message-ID: <20260818121413.2660786-1-lucas.kornicki@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::17) To BL0PR02MB3827.namprd02.prod.outlook.com
 (2603:10b6:207:42::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR02MB3827:EE_|DS2PR02MB11260:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c8b49d6-eb5f-4d0e-d34b-08defd2239e9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: QcmqcSCcqlQUrOoZAn0Ml4Y/86USxbmJ5rT6TCjI7ve03+qP5IUk2gfswrAOGd3Ox6roQbHc1PdaMw8+BdZdEIfEdrd8q/9VZKJDeVqYyXS31+DnF1a5qyJOwGfjo0TRUrvNdxLZsQmaYaaMru/CBeESQ0CI5Rju5gmxOJmw2iL9wMwMqMFzaot+X0fa+9PrIIZI4B0SYET/VQqHM7FoDb+oV1hiJpkRJbvkpe18BSrWacghG/KXLFsQcQDEWFZLpU8hqu/PbMMQA5lgHPvXmz18qiOltkMIn1+jqDGMYUX109qJ7B111hZPk23t70h8w1Bb7UdwMdM4n1YDxFODxEMzOIciowBDTD5s/FqDwqu55sTwD7WRDRd8CqyYBmRpC6RoE24hGspdQ17ovy0h+G/5BzKwuGYbVsssxSTipY605wcXGbknGQuNlcIjIuqb+ERvncbJPtooEJg+FplPGZFjsrjLyibt1mt90kjx/p9s1iH5bXUzXOi3AxG2kJS9ZNWB2rn7f5RMbxl7ZMbsQLHNbZzzoe6vXkqmYXdz27e2ULK+V1X295Ba2S0cc/4BqD9LEniUsuNuKg+vpUpJlQWOIeR+lRD7m3B8FdIg0G5emt29JorGkyLN4bqLrSjI8rbKQBg8ryI4tLkg0gTNXxHduLdoOAuZQCbNd7YCsAM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR02MB3827.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTBVTmk4RXpDVDEwM3NHUVJIWnpFdkh4RkN0dC80bmNRa0NLblAxZzB2c041?=
 =?utf-8?B?VGtvZ0tiVWR1ajB4Z3hxVzJZanBlbm90blFZZzBvbldhdWRPeGtMdENjaWJp?=
 =?utf-8?B?eTdVaXhaaDJpMldsYzlnYXkyejFXYUpVUTdyUkxCVlMzVjMzWk9mVHpBaUQ3?=
 =?utf-8?B?eEVjTDZCdHhyNnVscXZHOGgvb3NDY3FBSy8vR0lURGJRTDN5UUc2VDJ5SVBq?=
 =?utf-8?B?L3NqT2paRVFBK0s2RVZISVZPSUdHUEoxaGtpU1B6QTZoWEpBOHQ1Wmd6YzY4?=
 =?utf-8?B?SUZ4NWMyam9iNXN5Vm5Ec0RHSytYSXdnaUNzS2JpV0EvQUZucVJrbFdMZDJ3?=
 =?utf-8?B?SjZJeVduUVF1THAvRWRrMytwYUEydlNLeVhQb0U0eEl6ZEhVTnQrUEkvUnp2?=
 =?utf-8?B?ZENhQ1J1UW1UTlNVeXcxbVowSEFOS09nMzZJT0lHbVZTd1RDdkFDdG9JSUhj?=
 =?utf-8?B?TlNiRHZxYnRHWGdKaWE3eWdib2ljVzVkWkxnVGFZdFU4NG5mdGFHNFd4TlQ0?=
 =?utf-8?B?T2M3cFRtVWRZVFZJTDErM2RPNWJpamdVMjdWUW5Wb3E5UTh6N0xEbmFZM1pY?=
 =?utf-8?B?RCswMWRSWC9hdU1XTGN3SEZ1N3RPNzBKTDlhS2FyMlF0dDVuSFlkeUI2Qld1?=
 =?utf-8?B?QkhpVmQvK2ZnMnRRM285MEkvOWZNc1hIRW1LMXFnZTZIY2JyZnl0QnRXN2Zm?=
 =?utf-8?B?WEc3aWRENVVqOU9pM3Y3MW5RTk13T0FqZFk3M09KbDM3N0xURFFFTmhsb3Rz?=
 =?utf-8?B?c01PSGpFbWFDbkhXY1dBZ3lPZHFEMm9HMGpZekFpYWpVa2NKVHdSSHRQelBQ?=
 =?utf-8?B?cHZaS1BpTExPQmpPWS8ydnFmaGpyNVp2Vzc0K1FRYW1sRVdxcXJWVDRSSHEy?=
 =?utf-8?B?QnVLUHVtWjh3Q2lIUEN4dzhZam9SUmN6RUd2TTRpak5qT1RVUW5mT1RIdjVh?=
 =?utf-8?B?U24yQ3JEZm5LL1pZdXhILzBoekF2OW5GVGNUaUpud3RpU1RrVmdQUWtXanRi?=
 =?utf-8?B?d1hiUlNsWWFlNmdYb2FiVWVuUldXenVUbFlPMWQvR3dGeE1sTm5VTy9wQ2lE?=
 =?utf-8?B?dUd4dm5jMVpNYzlTclRBWEVocDlTbHpVSzUzVkM5TW1hWElJTkU5alR2MUJJ?=
 =?utf-8?B?bHNHUFlYU2liUnl5Q29JR3VJNS9ESXIzMEgrZTRTbDNaR0gyQktOU04ybVJS?=
 =?utf-8?B?S01QOUhPajlJTk94Zy9TVGFoRXBYdlpyemJzNHE1ajdWWjJZb2pmV0pEUEpm?=
 =?utf-8?B?NWpYb09HR1F4Um4yWFJVME1CcGtXOVV5RWpGSzQ3dm9VV2Q5TlBIWjd0MDVC?=
 =?utf-8?B?RUxOdXNzY3JCYUpwbTBLUWZzdnBPNitlYnNpeTJ5N1hMdFNmK3hUUEFxaGdW?=
 =?utf-8?B?S2F1MnhrUlRpOFBLdlFyZHFCMW83VGRYcmx0THBMT3ZhdUpVdjgwcyt6VTR2?=
 =?utf-8?B?SDhpWXk1M2JiTEh2QVlyMUZOMm51YWhMSDNrakxrekR3NGZPN1JjdUttV3FU?=
 =?utf-8?B?ZE1rcldiZ2JUR2d2NEVTR2l5UGk1NzQramk2dTlZVEs1ZU4xejRJcFlKcE5q?=
 =?utf-8?B?U0R2cmhmUFg3d3JUWlRxcllnajJKY2NjWHV2a21rYkRPYjRhSjBUNFd0SHFW?=
 =?utf-8?B?T3crbnRrNktkZitQd0NtSVNNSWpTbDRvV2JMM1dVeVdBZGFSQ0U4emdncEdW?=
 =?utf-8?B?dU81YkJYTCs0STBGRVF0ZUVEMHlFbEszc1l1dmt3OUp2bWJnUUcwcWlZSzNU?=
 =?utf-8?B?SVlDK0dEZnVTeXBLNW9ycEdDbWRwNkl5SUJrK0dycVAvbUlzNjlpL2pFZldR?=
 =?utf-8?B?NmovU1BMSGVmaHc3VWNFR080c0xoOGFwa2N6clpNYkxaekNrSkwzNkZTeWov?=
 =?utf-8?B?cXZyTFdzMkZxdjNuZmRoT2ZwN1BRNWYxTTIrU2lSSFV6Qi9zZzRnUDJqL3JM?=
 =?utf-8?B?ek9oMWxsbmUxTkQ0bHppMFVuK2NUajRsZFpVMXlOcExWcXNwV3VJTHQ5dEEw?=
 =?utf-8?B?VHVldDFESC9zajBSTnNYK2JtZkIvMlNzRmJkcWdNclVIQ29Gbk54dENubE9V?=
 =?utf-8?B?K3pLQjl1d1EyMXdKMjNZZXk1aWxJNmpSNVgvNjZPZ3diOXNjdUd1R0pNY2ZF?=
 =?utf-8?B?bkpnc2ZDYlVSeUNnSzFnSEI0aG9WYkY2VWJQeGI1dzFEcEVUV0tlK2xvd3Vk?=
 =?utf-8?B?ZnlpeStPWVIzWjFrSy9YQmhmVlNvMzFvWnJKcUtpZzVIWEZFZHh3R3hyM0ps?=
 =?utf-8?B?WXR3UlY1dkltejhaSEo3Q09JQkdiZDBxRFVPWnJMTy9zS3ZlVG10QnZ2eWJx?=
 =?utf-8?B?ZFEvc291b3l1TUswUmRhKzRPNjlCNThwOEhpeDhQeEhiWnBPdW1XelFycXd2?=
 =?utf-8?Q?PS0PVbukVIVaGDTs=3D?=
X-Exchange-RoutingPolicyChecked: Trw/nskGvE5mQiTsEr4POQkoLmYDRJimuyMpgaxaKOGRzODzWKogX+oH+NPJrKFoirVJMNydNeXbRxxLcg8eiE6YCOt3ekeyEoh/sZ/gTwVGtR/HcR3iF/zzDG7opsz0tKEB8Rhlg4eYgnGA8IeuOK2XiffQKfqQxyuXBQ8ouJnVx8uTmmdX4Tvm28cWYEa7NCxPDhenZ6gukWP8mg81l4LdL7KREnWVXRDeb88IW1oENjyK5aShRZjj26XnUHVe+ENj/XysWr5WB8v8g4H0mJsVZPXI9grjPqN7AZ1xs+fKipzgMBfpgjQAHcTaqghAlm2PvyXohRBLQOkoxv50Qg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8b49d6-eb5f-4d0e-d34b-08defd2239e9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB3827.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 12:14:17.7558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WSk0DhuViBqH8mqbpKBFCn+mNu5TxoJyZvHRXILRzqo5dk/gQZ1Xe+hBnxCOsmbxyjKtJn5rm9vTFc0gebG+yG2g4ib0r51GQ5E+OXtHZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR02MB11260
X-Proofpoint-ORIG-GUID: VOb-pnSH0OabaR2eW3ei5isXBYIPpEWi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA5MCBTYWx0ZWRfX1JPkecm0xGcw
 nAdteC5cmMbkSyJgFqmn1fX7/m0zF3ZMyL9T4LTpOJjVlGygx6XtWghtaSexxeNhaTbd4PFAVq2
 Huou7L9whsTVdisCb1ikB/Q2jI8dR8Y=
X-Authority-Analysis: v=2.4 cv=MP9QXsZl c=1 sm=1 tr=0 ts=6a844c9b cx=c_pps
 a=ypmqvA/i/yzbxHxvB85sdw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=slvQY8qIVbuip1VUKbwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VOb-pnSH0OabaR2eW3ei5isXBYIPpEWi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA5MCBTYWx0ZWRfXxdGj5Y3QWk3c
 +qL6NA1c6yFRXEOYE5S3ZdGK2XbRE1MZaK1kCj1xsfo3yml/LDE1od87YaF9RIVNJvMpSyy2rag
 R0rJIofvYMYO8WGTdg+PRJkuAKA1dY8ppa6ol3yqWPzcW3xbTY+vkNZZ92MCvEgR6Ldzj5aJPHY
 WAZsERtj6gvX69gyh0WZkReu8PzCzeVGF2A4nTillpw91rqqiy49Fmmkm3mfqpxOez6n7Ye7l5c
 D3h58flyTcZeqMLVSG48iGlcFCEy51WgICVrXtSqpJxLuu3+IU3ZuXVagjDYC4Vps28mW5Rb1dq
 iVIVtgdPvJPyeqewCXQ3I8KRaag8xNueqXqrv3sSdJwBO2FyaNE8CtqX2DLAVFKOmumuE1e/X5L
 OaPO2rrzpBzkoE5uN24YuMQL29ZOSjpsBF29UpFWRV7F6d9K11LLVj296gS2oXb6lduozGeE40Q
 NOayDg0vIRBvcnwgpBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=lucas.kornicki@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

Currently, a vnc client has no reliable way of determining if a
guest side clipboard peer is present. Using VNC_ENCODING_CLIPBOARD_EXT
allows the client to try and infer peer presence based on NOTIFY event,
but that is limited to cases where the unregistering peer had ownership
over the clipboard.

This series' goal is to enable vnc clients to determine if a guest side
peer is present, and to be notified of changes to its presence.

This is achieved in 4 commits:

1. Add PEER_UPDATE notification to ui/clipboard and call it on each
    register/unregister.

2. Add *guest* field to ClipboardPeer, which indicates that a peer is
    guest side. Currently it's only set on vdagent's cbpeer.

3. Factor out vnc peer registration into a separate function.

4. Add the new vnc feature, register the clipboard peer for update
    notifications, emit the message on set_encodings and peer updates.

Lukasz Kornicki (4):
  ui/clipboard: add clipboard peer update notification
  ui/clipboard: keep track of clipboard peer side
  ui/vnc-clipboard: factor out clipboard peer registration
  ui/vnc: notify client of clipboard peer status

 include/ui/clipboard.h     | 27 +++++++++++++++++++++
 tools/qemu-vnc/clipboard.c |  3 +++
 ui/clipboard.c             | 33 +++++++++++++++++++++++++
 ui/cocoa.m                 |  3 +++
 ui/dbus-clipboard.c        |  3 +++
 ui/gtk-clipboard.c         |  3 +++
 ui/trace-events            |  2 ++
 ui/vdagent.c               |  4 ++++
 ui/vnc-clipboard.c         | 49 +++++++++++++++++++++++++++++++++-----
 ui/vnc.c                   |  6 +++++
 ui/vnc.h                   |  9 +++++++
 11 files changed, 136 insertions(+), 6 deletions(-)

-- 
2.43.0


