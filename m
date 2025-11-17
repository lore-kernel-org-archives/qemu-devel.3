Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C662CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1bO-0005QN-2J; Mon, 17 Nov 2025 10:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vL1bM-0005Pp-JB
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:57:12 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vL1bI-0000en-NB
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:57:12 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AHAGSHN741133; Mon, 17 Nov 2025 07:57:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=aQXnHl/gAVIJOur8zgZMAV3vNUGtRYkn/85ZOkQ63
 sM=; b=SkydvBgTdcc3yDX61HEQQ07fHRZTyPRfRFFNvJ3OtY8uw2DGjo4tvzXWy
 6uAVQF3ztOa3wPa6heg8dCTg8DeIo3EEmaVR0+8i0tTgQXdb9ubr4NJRWLXgMRk4
 XzNjDgnT2oHnxyl4ymHRm0fZMOetJAXYXehU59fqWI9Lc1Qa/azqRDVfDOrSsen/
 a6+0qVnKAZl1mIaEgUyCn7NTN2qyWBo/Ue00WvQMSRPp+6HHusU6Wr17ptoMgyxu
 1w3LDPdbEGlfqcV0yT5hzZ8LB2SzH34li3zdTkj/TWLvGaQQB0y7k7p78pPR1R2G
 FBEkP4YX98SRxeFR+geYiMwiw8oLg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022106.outbound.protection.outlook.com
 [40.93.195.106])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4aeqxc3kda-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 17 Nov 2025 07:57:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDVVnsI5KY24e6zKS4sZf6mpltqCL3MR/Tlg2jJzF49uhEXme5VyzNvr6DgTm3eKsl4iugPBL4d6fskOd8MQK5oZmxKQg5HMIbLnOnHN7Zzl6vZszEjSOGo1XYRAn5aCHwLrQwnTPlKLK3fyJJQW2EaVsgPJq9H0kaoPA7O/k4ok9yMMEFWdJ221kx+zFU2DuONycdFgehtTVcrEfwUo8/kxIVkWtanXG/qepgW2K7z8H47Stgqr56wKitXnkofnIPD6co7YsMFyPS3Lckro5AI+XTq2UXl3pkoscvvyfGQpkPvyTXAZ56ByagFNVvBznFz+tefl9cnvVI/EHYiTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQXnHl/gAVIJOur8zgZMAV3vNUGtRYkn/85ZOkQ63sM=;
 b=GbJxpkcF/64wN8Si4dYQ3QrCc18y44MzRC/rJuuTrzv3QQsIqVFp9CpXTZ6bSWvkVJSrKP3G7NEHLIu+3Z7ibA7B05QnhJodFYy2DpzKpwvPAAz6FRDYgYjLljJ0sI2FxdqI4bRG4plCjt2JbYfO7PNSh0Ee1jcISbSvAWPXkXggfh2lErZtzVyJKgTrJFzLUJpTGn+FgFO0rMoR9wHaANILgpmv1/AlOtJ3iEDl3VRnKmPGRPsk/r3aCcPT1Ce1d3C8+QTwRpvtxcse39uJkMHYf3zmsrPS6AACHFhQK3sJECPaxQK7XePxsO/XmCmoWtWaIMqh+k/oHl/w4EGRYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQXnHl/gAVIJOur8zgZMAV3vNUGtRYkn/85ZOkQ63sM=;
 b=jfagH1twTx+Wque/pqT7n21j6nDdxKERJuclkASLYl8QpKzMpoPonjRtaAP+pHMSuR8yxzIlu4UyEfiVjgHgIipfYy67N6H4KFtarNB0e2CXJ2xqNJx4W0O9s29vRnoQuLb7RIHO1c2yHs45BNyepDPFeEiNFIjAMXnOy5uX5icMHlrlFf9Erolntse51afuA4xwUxdjYxSr/fnwzJ8kqoHVVTfiwPSwGJpJTAvFkiJH+LbYFBDi9gszp3tZq3F7cixI2i5nH+ij8iVdqQrV43O2d0wkW9DAf9SViGWHmmv62zRjDSVMJJNNyHwGrmcmMCNEHQXLh+n+mbNa8gLhtQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH7PR02MB10025.namprd02.prod.outlook.com (2603:10b6:510:2ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 15:57:06 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 15:57:06 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 5/5] vfio-user: recycle msg on failure
Date: Mon, 17 Nov 2025 21:26:56 +0530
Message-ID: <20251117155656.2060336-6-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117155656.2060336-1-john.levon@nutanix.com>
References: <20251117155656.2060336-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0226.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH7PR02MB10025:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a24965e-aef9-49e3-0d0d-08de25f1f4bd
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qJ1swAzG5ZV03ZW/OdZiNCaLGISBN6cGciJtE4VV30Pf4kPxrsz4AZ+n633Y?=
 =?us-ascii?Q?kQhZY7fwzG26Op6VdWb1bueAblR0mqmQOj+5P5PNKk2GnAyzKeZPCxlxvASG?=
 =?us-ascii?Q?XRB+pF8xnlchy1Ktpvp2Ood6rmHFe4qBrJNU73RAktW2B8HgEfUzSFQ9mmFH?=
 =?us-ascii?Q?T0pf04PCMQNAlS/i3zJNg19kw+rgZ20rvTW4qySQSjiw+yxyazoXsvdDP7PL?=
 =?us-ascii?Q?/gCdM7Isi2n6RPVA+wdG7IOEak5B3CU+2WyRMRF/bG+McHt8qcBx3NJwgz/5?=
 =?us-ascii?Q?L8tvUabfEclPIspqt0+GN5jTcwmnn7/kJ0CAGzZiyuaVYZm7mcZOJ2iPUZVT?=
 =?us-ascii?Q?mJkE1ND+FNrCQUQLJshDesj5LrdOtmxLfrWuBiYbgkHd7MeZSIVqJC6PNXKX?=
 =?us-ascii?Q?XUtholDNAy0fFMHh58EP0Hhb50XFGC8HG3+vtg1by9aM2GnzTJ3z3MPDzVwl?=
 =?us-ascii?Q?Sri7q7yNmqyfsJdrVEh3yN42WQv1UoehXbw9esK96/t3G7t9BDgVjuqUuzWs?=
 =?us-ascii?Q?Jz+gP4WevaeTafcr8T7zui7nzXOv4FKz4BsYXlJoB2YeX1xeeZY+uqmapjSw?=
 =?us-ascii?Q?MGS2ZFn1lOjC3iJAc0ioN6zJsY3YTExiwfVR1KDRsz1y1ptLrzIqfX/8BXf9?=
 =?us-ascii?Q?H8/Ad95RZeXoMoSxEOOS7gQQsGKLGYX3jwbCWw5DAZmOw1gDlk6ARtvTlphk?=
 =?us-ascii?Q?mER/Wq7ATt+BLdEzCj/ap18oxO1V2xfKanDagHe6YyIPF+J4ESvWMdshRSo1?=
 =?us-ascii?Q?huKMfhPmHLQMVYyw5dLUoZLZ052DPqMasxFUTBiGv0VtcQLkumgEKCv9hsZP?=
 =?us-ascii?Q?i0AeTFcoUtqNE7p1TDuZVDr16v6wdLf1VB3r2sYaW98nlI5NP5DhlkQ9+xv4?=
 =?us-ascii?Q?ZOW5Zu483EOQLUcDgNr9BSrGX8C0s4H1/cFckgC6VOcvEDDfuuWBDndVEzfx?=
 =?us-ascii?Q?qGX/tY0IGxwqxBHrdi04CA56ZayMGxRgacuYaDxeZoK/PUw7KPpHZjyg1lo5?=
 =?us-ascii?Q?Fcq0pd07UZvYP46xU82Xf7kD0mRhBGv/fyFu9WogyDat+krhDopOJ3eLAGqn?=
 =?us-ascii?Q?WRRQIUF31mdqB8OJdJiDNv/fMgwxP9O8F0rUuJzpmqgNX5e8H6Y0zvyYBYZw?=
 =?us-ascii?Q?ScDWhejK76ASLrdmblAksi3FzIma9h0Rgbz2YLE5o0B+AMRISP+B+VFpXH2h?=
 =?us-ascii?Q?cTzRrSHnVserhXl2dRWWxLWPMTAJGm93VhrsD0++wDVqqRv9eT43iqMhpwmf?=
 =?us-ascii?Q?D/T7APa0TOq2rmxFlDMKyBckQ7r5ZWbn4QwW8/4Xon9gBYizJRNKwiLXivlY?=
 =?us-ascii?Q?pK9Yvsf5BGsqShOTz7eRdNUifkmSuuKwpD5ODe6ZWg8eBf4vjRWE5BdLlmmz?=
 =?us-ascii?Q?6MEiiZmPHnRnkPShUhOLLmi5YhopjXl/Vkw681QwIPm8FdFSFLZrTlJ0wix6?=
 =?us-ascii?Q?s5mXL/NakektUZRioxp717NfUUe92PG5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FahFzHp9C1mn4nnIK9s2x7k+6dmlTWkuqslslTi8kdC+glBo6sSGfsuo5Adu?=
 =?us-ascii?Q?F7EI016xbu+Cd6FSWzCd6VOn7fpuWOirq/An68LKwAANWzO41+sN8uKR1BUD?=
 =?us-ascii?Q?Q7/jG2gMNxihBf54/7JGN9KvQ1toxesHhNQXgt4h4+t83NiUL9fVS6lXlQgU?=
 =?us-ascii?Q?HDIzEp83Zzktawk5aNH9jDhNDdF7HhICWMrbij2oRX7uVrgyljKh9RQ4wAXk?=
 =?us-ascii?Q?0Gv64Km4x4pfe4F/YSaUm8vzCccfWW4QjnwE9755a2/gkvy4p+AOFdjo+3S7?=
 =?us-ascii?Q?nikM2pgOOcDC8+koANeyvV5/kQ7R2vcABzNZAQa8Kqdvv0eYO9AnEw0HnsZG?=
 =?us-ascii?Q?S2WGq3gbWvkkKa3V1dG9l5+RWUFkcXJGWNM5Mf29k2fiY6y+NhzgSqKjivSN?=
 =?us-ascii?Q?v/naZqTNPhtL3umZ9ixLewDQdlUgGGvnhcrOCUr4iikVkr3OwChs8AQyQn48?=
 =?us-ascii?Q?+vFd6sRwDN3/V5T5S08ZGnmgCKQW5tj3hjKEMmGiGDWaR795UxqXKY4oPLjT?=
 =?us-ascii?Q?TUlXruZ4nhhwUGkvn9iCFv9F2A7JMm05319Yd6l7kn0QL51Ex/iOc517JuKe?=
 =?us-ascii?Q?SAT4wXmE8cyyuYx+arBxHl2/hjNrZ2PvtKVOzayrFeE68q4dXYYlM6mfPHrF?=
 =?us-ascii?Q?xg1DnfwqPuIFUC9Up8qqnfZq7Ei+b/1xDVs8tNL3iZZJNH4hi8SpR/nkBpic?=
 =?us-ascii?Q?E5VVpXf+1M85uaAlg4VOfchtxefJjMq/a7gw57Q5b5TYwwJMPMHU9mpUskuG?=
 =?us-ascii?Q?YyA2d0GJSTb4MFXSsD9HhkzzGAHZAIv3j98gswCsrZ7E8O5vPt9RIzI0avd6?=
 =?us-ascii?Q?N56dUEvmDwPF8oD2mEESKXySB6QB0Cdw3Y4zMR8M3JPUvBY4GTDx2hwDCSWY?=
 =?us-ascii?Q?RnJ5mhfzbrrbxNVxq24l4TpODApmFR3J51noNJH1WwxTamQz8W2iPHTCkYV/?=
 =?us-ascii?Q?rMsEvk1E+Y6ScmGtzVWQ5VGR/3IwrxY5fUDP+/j1gGsTjzB+w9s2xxjNyluL?=
 =?us-ascii?Q?/VUUx5twQp6NriPIcopS4G+D60JrGqPYAoAYAdCJVSi7B7VsqGaBuCXK7tI3?=
 =?us-ascii?Q?r22SrDTz3OQeRrMFuuxUv+UMNYLdJTj+cVMgFIYAfZv8e4RuOuus99nToxEA?=
 =?us-ascii?Q?PeeE6CpWbKmk2wcFajGMoGZyCO/wfqZ2HxhOFHSBDmi0oUQTVZ/cqJO+DHdW?=
 =?us-ascii?Q?yPyW1IA0FdrlIONEcnsmXLYFrYjSrjVa8dEtyNcq+9N5l85jGDrQelVVjuU1?=
 =?us-ascii?Q?zlVuTJ3TwEJfS6lijx7dNIwSPifFUQX8fos3rTInKEZ0uSh6njgYOKoecVuZ?=
 =?us-ascii?Q?uSQdv21VU0v2SJ6jKncdQy7lLWSHkIuFffEE4nzU8na2JlRN1CTSrJpEcY+D?=
 =?us-ascii?Q?AW5FA2gjAXK0XpPqnLDkkq2sGGihRiJe8yId/rPhhtZnXOdxM0Vqj46hEZAb?=
 =?us-ascii?Q?DEFvt1yX7nvctCxHDXPBDuO8sLJKlMG3ZPjPxRB7D0rXEGgN2b5xWhLoNCgb?=
 =?us-ascii?Q?cEimj+Bx6c8ujl6teqczkge3AyM/muuB4X2caPoE4CPqcajao39YjshjEsz0?=
 =?us-ascii?Q?oWhy95ZOzbSk8RgQTAojbrq/AehBvoGAL4zrxyVl?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a24965e-aef9-49e3-0d0d-08de25f1f4bd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 15:57:05.9245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5K1FRrGOCNW3KOX+e4Iv0RkIt70VrJlalKcYBT+oqWJWc6jwb0NFlffF/T2M8dJt2YLUL7k0ugi3SSDRZW7UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10025
X-Proofpoint-ORIG-GUID: p51WiPVAJ_2BK8OSWhnDxvsE0aKk28W_
X-Authority-Analysis: v=2.4 cv=e8wLiKp/ c=1 sm=1 tr=0 ts=691b45d3 cx=c_pps
 a=njBiJbAQTUgP4Zm4Bb3rbQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=J75VCkS05BzDYCChcPEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDEzNSBTYWx0ZWRfX/Gi4laVnz8wN
 92qXkPwXUF57sXxnmbz6YPiih8ruSkhcxlXtY3a0LoTW+9AhT5UW8KksTBZyCnbph8dHvKKxO+I
 g7PiLYpZF7ono+ihpu/TlQoM6tULlWe1Xra3JDV4YzE4jJtVc9Db7CSRQDJbIP7lt5uWvpz+ZKy
 noWGIEtdv1iujuVN9P1s/Izm7DQ8WDT2YdX8pD61jEYg1hwUTeb2fhwuwkY+BuywniUxJKvllYI
 g+juBqsW3FnA7kFvSAxFTwEvoaKBI4Uzz8GHwok81diMKPZUBwhbt8ltqaL08lTxHECq7FCdWyt
 WfaF8i5XG4z5e1ct8Zoe0I6tKNMtLO8GuoIu7dPUhuuPsAP1d6100duwJ79Xjjaiyq6d5XsE24J
 VxmJFvWTdbcIdmhOmK0lOmde38aqoQ==
X-Proofpoint-GUID: p51WiPVAJ_2BK8OSWhnDxvsE0aKk28W_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

If we fail to read an incoming request, recycle the message.

Resolves: Coverity CID 1611807
Resolves: Coverity CID 1611808
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index aa5b971fb6..28542a5e83 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -412,11 +412,22 @@ err:
     for (i = 0; i < numfds; i++) {
         close(fdp[i]);
     }
-    if (isreply && msg != NULL) {
-        /* force an error to keep sending thread from hanging */
-        vfio_user_set_error(msg->hdr, EINVAL);
-        msg->complete = true;
-        qemu_cond_signal(&msg->cv);
+    if (msg != NULL) {
+        if (msg->type == VFIO_MSG_REQ) {
+            /*
+             * Clean up the request message on failure. Change type back to
+             * NOWAIT to free.
+             */
+            msg->type = VFIO_MSG_NOWAIT;
+            vfio_user_recycle(proxy, msg);
+        } else {
+            /*
+             * Report an error back to the sender. Sender will recycle msg.
+             */
+            vfio_user_set_error(msg->hdr, EINVAL);
+            msg->complete = true;
+            qemu_cond_signal(&msg->cv);
+        }
     }
     return -1;
 }
-- 
2.43.0


