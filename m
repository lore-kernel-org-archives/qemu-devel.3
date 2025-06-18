Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA09C7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 11:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRqyV-0001F0-Q4; Wed, 18 Jun 2025 07:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqyU-0001Ef-Di
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:29:02 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqyS-0002WO-Fq
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:29:02 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I7t11K028395;
 Wed, 18 Jun 2025 04:28:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Fc8ol85F+iH/sZfCKX59n/ihC3eAawnTDNbFRvrZV
 nU=; b=VX8NlCrcRJgCtZq5cVPk8LFcqR/IIpAjegCUp+5a7zryqI8pNHaGnxmid
 DxGXvMRb+J+jIxVwF+8nHCFG0/uHcSkQq2VJPnnLsjHY0JTkhwmmn6QUMNxeSrjK
 FtrtCr6vcjDG9yx2N1sIR9uh9eawSlT+WAleUycPgn4OdsGsKbGmkVl912Eyktcj
 pcjlO8OOqaFSBvDBMmfUHz6/vbf2oHcj8KZpcR0nvl9vCSN0iF+Y+72qGFeK+nVv
 4bdjVjXRYLZX5vLbZ2Z44ZwTHDxgrYrx0x/J+danzZUzBq2Ib/72qmc4ZXW80fCb
 g211LOh3RLSYMbUEBivyNsKaPM16Q==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2132.outbound.protection.outlook.com [40.107.92.132])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 479508h346-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 04:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzDMY07SlD63hR/qs9Z0Kb0sse3RHnxw5/JH+r9BE3UWtf15/qNLEy23xECbqwSHmeXJ49XYW9E5hEG7WC4u2aKYPd0K1yd5dqVMVRGq0Iru2NX9oecXl+xF5WTvjvyE8ZvH34PEKVpAhMJtu/FAG8E4/ScG597+Qu+KgkcLyC6E4EPcVfidezXSguSZ9WaISH2j9k1SWp9YkMXQejyiKzkMndp5JnYDG1ndReN7KMM/TqoxA1oMP00nDi3wUJyipHiFXrpskStNJ3K+nr5wbuTVk8zBmMNvT98cnCn5cAtYhH9HZ75kHm4LpjnjXw53GDa5gWGQ9MgJaleQ64/jhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fc8ol85F+iH/sZfCKX59n/ihC3eAawnTDNbFRvrZVnU=;
 b=r8aM1V3UnZScfvTX89ChAqZXsPq8nbFNIQvTtJmvLJqGE9eO1s+UJJ0rSlESJg2vI12/DLbGIRMceNEd8BeGNnpAiAPk+W7bU5k0Y+9Fi/1XwP1pKb1X1OIExHoShaAPeOEV6v41QM2MEWByPZIzsRpYZwM5JA4l439Fpj3YwDBFG8HcfQySjLH/mJUOJ3qh2WwUuPko6VeaxIcm4ngMkgmrLHX58w6lUQm9+MuoQQSXn4xD8fCpBHAg5nXcE5wBiPw/dn4zvjYNRTxCj8RFYNWDBD3P8aPG3Yg0GkEcotZAyhlQNC+9yEDpZ+tk8lygwInwIaEaQOsW5EqVsf0rHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fc8ol85F+iH/sZfCKX59n/ihC3eAawnTDNbFRvrZVnU=;
 b=DmHO5jvjqhweqgjr+v3CJvds4OwOtZ8ET4M4+mBUsDgA98nXfzd6QY2UUkOUy+VGsLUjCagCb4awKB7HczWtqQJXeDd/I9zXeg56CPpy4ZiSpMOszKgTBPGCa+epHy0009ZlJ0ZRSut6g+5Rup1eQAA8XJ4Zk1kZ9s9BMPa55HcWFWaPFfoQadN9QK4fw4Gbpc+z361CwazUare87/LMs29G72j0RvpZM/PYfqF+AGjOk1g1+BYgl2JJBCuM+X51qjUoHtpWVKCAPATK4BpwpqnxZhg/++DKCRDIwh5HUDp47OwDA1LOUgkZeBN9mlmsUc1uaddmHtQ+A8XCfq7qvg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9632.namprd02.prod.outlook.com (2603:10b6:208:3de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 11:28:54 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 11:28:54 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 06/12] hw/i386/pc_piix.c: simplify RAM size logic in
 pc_init_isa()
Date: Wed, 18 Jun 2025 12:27:11 +0100
Message-ID: <20250618112828.235087-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618112828.235087-1-mark.caveayland@nutanix.com>
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0046.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::26) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: d72ca80c-7944-4dae-b435-08ddae5b4e8d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AZjbinRzX926Jzd4IiOEFY/RnuoHiM5JwTSmljE0vKV6ACoWLZE//CubONKi?=
 =?us-ascii?Q?2DTTvoIghNCv8y5/uSwFwndulSHNn21D2zvEfD77iJRiQlmY5l8yeFWybumV?=
 =?us-ascii?Q?p36wYeN9gw0X3j8JFmmphcC9oa5CuT7J2M4NpDBUA2HxrneAIuY+pc9Mf6B7?=
 =?us-ascii?Q?86YxOi3QH1UwXB9U7JMnB+IdIvTroB2kDKIQXboiWiT2PqxUhoj6sqU5mgnQ?=
 =?us-ascii?Q?aQRWxzBTi/S+PnQrRB2IOlt8VTR8Pht3HHXoZmK1YnHvglzhuGreajePU0Hm?=
 =?us-ascii?Q?7snOdSdOZkd+QUTdBC50f3oiRHsW/60fsh/JBqbBhXfHUAE3V6sTD41UThrU?=
 =?us-ascii?Q?EA6wuY1fjh6YUVbdcSDkMLv+WdmmfbgfrxZ263nyPxhnlkyXWLjEJb04wgJt?=
 =?us-ascii?Q?fcKJF+hCKgu8HjnUyufZlB8eq1fq0c7v5nwM2AlDp37WFEcEh9KRRcfykRyR?=
 =?us-ascii?Q?jUYogyPJWvOtZCG5QPoLYny0qzE9Y68wpciLXPU0SzoDzjkbXlJa+vKDXQIP?=
 =?us-ascii?Q?ts+M/I9HVDTeztPMv2bik02pment6KV6k/XMtp/BeUwCPjsOkd24unp43FFN?=
 =?us-ascii?Q?gKDmhJ0R0fFek7ILPPnIlO18neioATuEkb+ikZhyHRSjtga0zOC2d7U0pNrt?=
 =?us-ascii?Q?Ex6uYNw8mo7vxLcG/oqI9iBwrcdlnd38lVw/7sVAluyYNAN47iJ31CIhAF/d?=
 =?us-ascii?Q?yf18CWKnHFmJ5fQ5byHhgyBbmvnz9pGapMWBTcgetuokTi4bM+eiqeEN94Rf?=
 =?us-ascii?Q?rYcqC1d602TreNS+u+gLkH0JX7fo5yXd57lyLfPWo/UwcRxcApR+ee/uBV0c?=
 =?us-ascii?Q?/Mi3t58Do+Ea3PJBoa9LukOPwnB5SPQE2h4sanYw7x4rSTvGE7pnQ5BB94Kj?=
 =?us-ascii?Q?qAtV+8TCTX+X9w1RNr7n0uyXVBMCuh++hVOUavY3z376hD4L5J4gHrOiDZsZ?=
 =?us-ascii?Q?ro2cXFBVyhPSAiVjLtRD6S56S/HSpbEdPSsr68SSRD4Nq+lokSa7tEVhXhzu?=
 =?us-ascii?Q?huUUwnwmOqs6rZmFvueqI+3L+BczJKlSTmr836g1hxM0Y4QjeY+60nTBx8zo?=
 =?us-ascii?Q?wvgohjAzSM/EjZFs+Ib6T0jTe8EtywTcQy0YW9If6wyWfMgsjevGyr8P4o/T?=
 =?us-ascii?Q?wxdEALAkMDB8t4hKF7ssR3wzboAZxiiwJw8IMrNNV0bbp7nqFfJKjVkroFfP?=
 =?us-ascii?Q?/OLbzaaTZuooYDIfK4MgldHfgStssGva132lf/dkcf8W7Ogc/xW3UZdneYOV?=
 =?us-ascii?Q?SnnjgyImJI9ld1BVZFTMcQURa+4UB8Iqgt7agc9X1IujHnvK1W07QWhW4T8c?=
 =?us-ascii?Q?Z0IyvWV3cpKxX4OyQLnhjGZfhiLQSQ5FKLq7uBbXBNMF6PS5sMJHTGgzNT+d?=
 =?us-ascii?Q?DYzt7qumwWd7bWY00Yo+Aa8qDJDgJydRdJrvteiKAlDIRzqFgegtrQUcCmbf?=
 =?us-ascii?Q?87V81O7UmjY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VUKnhOWJxazLvNTOTTkksFeEuRioxujbBTvoa1xePkuxiInHTqhpoFtB1gh0?=
 =?us-ascii?Q?6nsIbQ+osumPsBLlDlP4JUZt6C7PwebutvD1G4ESRdzOIinquLkZmKdZLE0I?=
 =?us-ascii?Q?K4UNZrXR2nYm92I9+i/qTQ3oppjoEAaYgVCRlRv6iLaK71Bg9FH6m3P+lsCa?=
 =?us-ascii?Q?yjzeeGrnaPTdg16dSQPilKfjgHTzHVDZ3XqzWW58MB5IKfqi5DUBrosq1qy+?=
 =?us-ascii?Q?4xJA+0QCHWj0i/PFoHr0TXZcmkvieXbzAcmcYHUFhZxgPJEKLJwu4ywwOtP/?=
 =?us-ascii?Q?5iwM7MzVEWAZqXv7wwchkOcu+kHRhIsufbrafGR61thYaQYlIA91otj8Y55m?=
 =?us-ascii?Q?ttSjDkpreiDXasPsWJRFvmhUnPfO2vxzVM+zImYuOrhhfZXypDuAKtqBGBcF?=
 =?us-ascii?Q?8wV3VbJgACqkVovJ2SKzcfDkIKa09Ixr4H7OvL5y6TMWLDm8f6+gBjVmfRxZ?=
 =?us-ascii?Q?3jbM1iDIIKj8u+b93wA3km0w/feqtLcd4eGjuozm0ueQLsVSETJIH+1lc4zt?=
 =?us-ascii?Q?4TcphJPgPgCzMllx0fMOa/VzfIc+EIrLjuR4kE0nLLdfGbnjkw/8CFh+tMR8?=
 =?us-ascii?Q?gLBRWU/dSPBJFI8ogVq+8ey3Si/spl74DNe28WOkfuAl60rGEM3474Re/o+6?=
 =?us-ascii?Q?u5KfoIDFultBRGoru6rLnpoviwQDuorKHv4PH4DRHt8WSLVtOJKXF7nGEkPO?=
 =?us-ascii?Q?HcbbexYURR6Imvwz+eRRiOOriKLeBX51ow4WE9Bte91/AzOuP/TwtZCtK9UU?=
 =?us-ascii?Q?5msM2ZENRl6/x2Phv2oX4v6ZECC1sb8yu6JCLZR9yDG23FgvMtNnELZKXeHh?=
 =?us-ascii?Q?/z6bOuiPKmZT6wRRNyb1CIaogXwvFW3MQN1Bo4zkkaC0RlYepOMVIzFYKRPE?=
 =?us-ascii?Q?RDNxKtG+7YI4ukn0FePG+SOTCmS39tBLvIJom64XBKBoYpTWrztknAbvF53y?=
 =?us-ascii?Q?d/3M8cb6K7XEGNg+aV2Q1oQIbK1W/1OVCFPWxn/zEVny2Fb9pM1jCSEVbVug?=
 =?us-ascii?Q?bEcCbDqGCUjJZd05pWDrvQaTU+HUxWKQowv7cxa7xp+ai2/m/lwjr6ll5Iyx?=
 =?us-ascii?Q?hGotqkuiP7qguNPhR/DljK4RK5OmzthiUKEF6bwhlC8qpr2QBDtkd8T6Eqc7?=
 =?us-ascii?Q?ATnxSp6gliSPKZs9fjQ2RVqaw7VO8gGWbA5MIF+PmUjEEnfVWRBGM36dUsZy?=
 =?us-ascii?Q?77N741smihqtEkJeAHekyDwPJKufHfnBStZ8+p+pD1+ahwIVqoENEHtxXsMP?=
 =?us-ascii?Q?lV/WfkWLDm5ZegHCuP3E7CUDc0OmtQr9u/Vl32+DIYpNX1Yd9BbSPFh895Mi?=
 =?us-ascii?Q?LBFVKjrl3AV1lfPRs9TrOm8nvxGhTU1eayADnN9LPZ/w/z/zEZNFA1k/UrtL?=
 =?us-ascii?Q?RvjEFYiUtZoWcoFEGxTuzQ5Ghipzi3vxymKtC1ZSBGI8tIn7l/77zXULjroJ?=
 =?us-ascii?Q?Vjm0SLz5SOr+s9Q/ulC9o++N6aO4miHHIyHmf1K+BiOOvZ6+SWT9MTHEiO0d?=
 =?us-ascii?Q?zYoqLEO/MpyL8iq1bwYC2r3Q/XAo2SMcBCwsGv0+tRxKmhSOVpwBGPSEHteK?=
 =?us-ascii?Q?CRYLd6KSmv8G6Zuu9ETJ7FCkZgYlyLF73Dco7CezNT28nz9VVvWWvtIb/sZT?=
 =?us-ascii?Q?VVOsp0QRsKGd+niexncU3K6u/Dd51OhAVwL7Yp6eedc+F8MT+FAvRstC0ZAO?=
 =?us-ascii?Q?F9bT4Q=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72ca80c-7944-4dae-b435-08ddae5b4e8d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:28:54.2194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U58/Yyd2w+c5u+qfyM7KPcpCrC+ICAeH03cIIu/QjR2PEI2t85ztvvtpsbqU6kfKT1rXvhRan7XJ5C+w3XA0WXZzkUBv3ZdU3ahdDMjW77E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9632
X-Authority-Analysis: v=2.4 cv=HaIUTjE8 c=1 sm=1 tr=0 ts=6852a2f9 cx=c_pps
 a=ne5f6Wayux1SoovUbtzCnw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=puX-rZ3iWx3qy-NnaecA:9
X-Proofpoint-GUID: VWgTGaUA8GkFFE-HJPuBqzI5KZwjeJo6
X-Proofpoint-ORIG-GUID: VWgTGaUA8GkFFE-HJPuBqzI5KZwjeJo6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA5NyBTYWx0ZWRfXxtA7nETgaMSS
 XH5tEEonL+zPPxmjoV/ydiFmhq8e1cOYQqv8b6B53BMz7paRB4FTPNGIgXc6mO4z1gbDEgpmLn2
 Eui6aRPD0bDEKTghFCmeUCMJzq69XX8qAO+/sLCsMmbKmAh2929wiqjrj5nacKwmo51NvK9KJKg
 j7j4lqgM63zSicyRkP659CxnSyz2DClpZZSzPMPwGEQu8U/Y5DFXHagySEhoqztFKruD0Cdsu4W
 HKw3Lc8+k6a0gvcW/6vtFKQ4QHhUBkd2IjSaUpgaR03Bc2XcocM1YNL/KWvSnBtoPKWoJm3E8Om
 rHoNldpaRrV3olwMJpYdlzMsZnCTgMq5ekXOeQuCtthwlo6t+Q4odzu+SVtRvE1LoqaY4smlX8V
 uVWIqTEu5wzAC3BmnpVpqTWzSLORNVWBk/PgQO6zvV28C9/rmbepIGp3+GbGPUiOyxVO4vAB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
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

All isapc machines must have 32-bit CPUs and so the RAM split logic can be hardcoded
accordingly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 58 ++++-------------------------------------------
 1 file changed, 4 insertions(+), 54 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 640583e163..168469457e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -427,69 +427,19 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
-    ram_addr_t lowmem;
     uint64_t hole64_size = 0;
 
     /*
-     * Calculate ram split, for memory below and above 4G.  It's a bit
-     * complicated for backward compatibility reasons ...
-     *
-     *  - Traditional split is 3.5G (lowmem = 0xe0000000).  This is the
-     *    default value for max_ram_below_4g now.
-     *
-     *  - Then, to gigabyte align the memory, we move the split to 3G
-     *    (lowmem = 0xc0000000).  But only in case we have to split in
-     *    the first place, i.e. ram_size is larger than (traditional)
-     *    lowmem.  And for new machine types (gigabyte_align = true)
-     *    only, for live migration compatibility reasons.
-     *
-     *  - Next the max-ram-below-4g option was added, which allowed to
-     *    reduce lowmem to a smaller value, to allow a larger PCI I/O
-     *    window below 4G.  qemu doesn't enforce gigabyte alignment here,
-     *    but prints a warning.
-     *
-     *  - Finally max-ram-below-4g got updated to also allow raising lowmem,
-     *    so legacy non-PAE guests can get as much memory as possible in
-     *    the 32bit address space below 4G.
-     *
-     *  - Note that Xen has its own ram setup code in xen_ram_init(),
-     *    called via xen_hvm_init_pc().
-     *
-     * Examples:
-     *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low,  512M high
-     *    qemu -M pc -m 4G        (new default)    -> 3072M low, 1024M high
-     *    qemu -M pc,max-ram-below-4g=2G -m 4G     -> 2048M low, 2048M high
-     *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low (=4G-128M)
+     * There is no RAM split for the isapc machine
      */
     if (xen_enabled()) {
         xen_hvm_init_pc(pcms, &ram_memory);
     } else {
         ram_memory = machine->ram;
-        if (!pcms->max_ram_below_4g) {
-            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
-        }
-        lowmem = pcms->max_ram_below_4g;
-        if (machine->ram_size >= pcms->max_ram_below_4g) {
-            if (pcmc->gigabyte_align) {
-                if (lowmem > 0xc0000000) {
-                    lowmem = 0xc0000000;
-                }
-                if (lowmem & (1 * GiB - 1)) {
-                    warn_report("Large machine and max_ram_below_4g "
-                                "(%" PRIu64 ") not a multiple of 1G; "
-                                "possible bad performance.",
-                                pcms->max_ram_below_4g);
-                }
-            }
-        }
 
-        if (machine->ram_size >= lowmem) {
-            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
-            x86ms->below_4g_mem_size = lowmem;
-        } else {
-            x86ms->above_4g_mem_size = 0;
-            x86ms->below_4g_mem_size = machine->ram_size;
-        }
+        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
+        x86ms->above_4g_mem_size = 0;
+        x86ms->below_4g_mem_size = machine->ram_size;
     }
 
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
-- 
2.43.0


