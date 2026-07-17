Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CE2C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkgcc-0002ef-4C; Fri, 17 Jul 2026 07:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkgcV-0002dX-UY; Fri, 17 Jul 2026 07:20:45 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkgcT-0008A2-Df; Fri, 17 Jul 2026 07:20:43 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HAVOsf3610520; Fri, 17 Jul 2026 04:20:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=M4yLRe8DqpPSujEyEJB/nv58GEvRIeEzJcKdjHgtZ
 Lg=; b=GfPHdvML6bWRTqwl2i0KloEP7557kAYPoJE+D9hz7eHPXBu8FgH5lMr7r
 Bpk7zcYARK+skwZkh8ob3oukmR5oZMJko17Lpazap6YeN/69peUnVabUgYlYrC1t
 fdv/q5+AZJHA3fyzi755LrpbwNrKN3yZKEgXFy6pKAIk82VkRuoZNmWBDGK55jfg
 wEHAwnyUryEqu7FElI2HNmWfP8eNJZK2wDhtFN8LVue4Vfju52CjTFb+EAxn0bde
 4syt2LO0hgHxULfzqZtrrzNHZRV2kgQ8+l5/QQbeZWgxR2N2NSOeIHM4fF+ubCqT
 mUiLqOLUa/LZmrWAzYutSdtQ8vvQQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023128.outbound.protection.outlook.com
 [40.93.201.128])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ff2f9jaas-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 04:20:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULswYSvhx8qAxJBkqygmMS/WHnamsfpbO3Q4IllLV8aLca4f0zrDJu0wIVAlSOrkFvPQPaXOcqVg7eGVXsSETGnh0BjOdk7E2Lbm3c4W8gPjD2633Vnwk3xYIJOeW1YI9qz1GUuIFRrXC+7iXvTmxBxYBQp50SBQEcc0r9JgGXL1viCjesoxMNF6FSq7nblw8VI29iHO+uU7qV77qqTVxH7dulJP8Hh+QuqD1EcDEMy9UURVhkfNI2MT6/gJsLga3NQo1fzYPsFqUtIh7FuJcU2GIbJE7rOrGx3IRTxXIyYpR9Qc+a4umGmbqasubdVsYP6ZIsRR2FB1m/XDOqIX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4yLRe8DqpPSujEyEJB/nv58GEvRIeEzJcKdjHgtZLg=;
 b=qIxoLNg58ZXZb8O02v9muzRWpTTvF74Q6nzsFhyVFeHzq0JDyCeslYoGsfsVK0IWufgUD4afIswXwv7iTdhY11FozmC/WYjlJKfti2OUIfvoe6XU8lIrK2aK6F7av5NK7RasU2DnoSPl2a76i1I0c0N4gxkK/KIiwvCFfjtjnW8de87GMiHyZ8ElilnD+exr/ArmHTeeA0xBkcfCdV/a51t8yPMd5KOM9fbJ8btPjUU3PREPxqLPccfVJMK7ya6Ka57CA2iOtB7G4my0zwsVO9xzPUdUI6RHKbSNWVkiFZyEzsAh+sFlsAjoHtd1dKJXrt9QF4xZnjJVcb90FS9SaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4yLRe8DqpPSujEyEJB/nv58GEvRIeEzJcKdjHgtZLg=;
 b=y1oGj2bIBJvCe9XoqEbETDmWR4T8olvACT30z122+V9KgvlYwi/2Oat04b3qEpDAzqDebKn7PPueg8Bp6AwCt1L+Khhk18RCVQ7xWf5Ysj1nLpMC416j7k7CqxTQqAe7VjCcurSLhVFdCsfxU7DknZRIR5N01sF/x0PrDFr1qkFCk1AdD/bg3x368Mfm/wGJHWda1PA5QLnvYlKvEvagUI6oVS4NDliWl+/S4pXfu2tZOH+Dh3+Ag8U/kOphBUMVhTTkQJ/n0SX3kSFWxJlQcA2bbBRULPQt1fbqK+nINeRIcI+dtRELiLPGrbP0ICVSrNCNX6S3JkRTFoEJvcW4Kg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7503.namprd02.prod.outlook.com (2603:10b6:a03:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 11:20:32 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 11:20:32 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, pbonzini@redhat.com, berrange@redhat.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 2/5] qom/object.c: introduce
 OBJECT_PROPERTY_SCALAR_SETTER(type) macro
Date: Fri, 17 Jul 2026 12:19:09 +0100
Message-ID: <20260717112022.444367-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717112022.444367-1-mark.caveayland@nutanix.com>
References: <20260717112022.444367-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:930:17::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc549af-5caa-42ba-31e4-08dee3f56a53
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|921020|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kBrAdm6pT9eaZoaJTSx7ZjIi6o7LrVcapFU9Jx4RSE7SEfdDhd0OvACGKtZ6N+811q8RVgFo43up8FrRddy5IcXMU8sR0ToIJFEmghyX4YX2Ene0o1bvizktPbVo5W2viiTd5CB+3bILE/0LS8tWt4G8C2i5Pe0GRahWlNpU2aQiFonFrBHOiDZW/Lx+XO66df2puq8obq/5NIVcdu6+4cTDzeqt/RHm+Zeshl72a0pHo9Fe8t2FbuG3+rzfHmpRTHENYmqebBZTmfNLMuvzYINH/8L4m/3E9gp7q13nfBOmB9g1JJ/H0UaojJVNILYjO5PKI/O6fwXQtHQOzGx8TeTf8w0hSvjdGQI3P6LBsV/IXrGJxbpulKW+TqjH/+FUtTfNH0qOXNXwvqMCg0QUlWy/H5c6UnFa1wtDl3bQu6fgikeCY13KH5D31IgDnua4aTSzzu/PK1Wl+DwuovLxz9FQmPU/Vgvu+OB4ELKZ7bgDtVthovM1UXnQSZBAH8Cb3ofSHVkaMxvcL75xFJ7hq75G7uWcaQTBd5lG0xGD8FGLDHLwdJL6bWort8La5iotmAmRmOIttHqdMrLoA6hf5k/CpUD5wnLbk/BQJ3F1q+6NpgyxO5A0yH2gskZpClyyTpBjByk2U0zmdiefn29hZkqlVbZR5nSo0eU3zX5XzhLE3DbgC5WTFUB9onqHJxveBN1jnfoQZAG2k1gDXzsIpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(921020)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vq7Sc4O7i8T4RnrmkkHDmFFs3Wdda58D3PHbBQC+9BtpE31gVjkuX6YU/KVh?=
 =?us-ascii?Q?SV5HNHZfTg1CReYNl5R2AgsBh7DTu42fo96Mik4YBHNQFVd+KJ+6cTGEiLdv?=
 =?us-ascii?Q?CeR/f0cCwm05lF3ATYbSYcEZ1DhI1cAkF6/J7rXUHiRAjj8S5LgpMteUZM2h?=
 =?us-ascii?Q?J0LlllDcnLdxK0PAZAL4QKG4HFCOxjFQKSgkGq3oqzH3GyW3zAClttt6pg6I?=
 =?us-ascii?Q?gCUXRxu4G7MnmseA3hXoq4C9g4X/tDN4E3BfrpYd8lL7ucrpArLThx9ho4LI?=
 =?us-ascii?Q?2nIpQaVmagM1aB4MVrDrKqnhCSkyGklT5gR+eYCZqOgcRs/3AsabnNL3y5vf?=
 =?us-ascii?Q?WX09ris4zaNnlHbn/LEeotCKmwXudud8QwLXQlECLrUgpTnfrh41Qvh8X5GJ?=
 =?us-ascii?Q?PPO1PnE6Nu4wu4aEfPYe6tIWFnyBzw3F6XyqFILtxLF8jd3EHJwsCv97uqD+?=
 =?us-ascii?Q?/tb9w22PLuO8XVwXSBeU+je2rnrNKoQwnZFhOboxKeBj/5FG92fmKr5iAkNc?=
 =?us-ascii?Q?aaM9aCSixgJOo3zXDtVZ9AfY/QFp4+PVAtHO4fujkCndi+bDNCrtwvq81JYq?=
 =?us-ascii?Q?fbrFFTU4Yzuk09uU7e9Lxl7LgovyCpDWgpHh2npWeuNgPizUwzdawNoVJxbz?=
 =?us-ascii?Q?YFB5fejGKUU0sryJuoo4ikdKJ9xhffwa2LyM3yN08TtUiqLrF2+phS19bcHR?=
 =?us-ascii?Q?x3R14euXkKBKl5njxF5ITBRNMPT+a7JjmDdKbeVEdUnfdHxey+RFItL7ombR?=
 =?us-ascii?Q?yXMexK1kznbxdmGb9lcGwjykW8TqKJpCn3E9bQnlMd4v1X6OIBxoDdEhwSZm?=
 =?us-ascii?Q?M7orblucZXo4MItTYVi4CA0tPFF7x9vGGc7PPw4NsvatOOZLdmCh+egJ75oL?=
 =?us-ascii?Q?6God2pd0Xc32NYfZgeBq7iRpO8qaaKS8X3vaUhpakGwqNL+wfQHNvfDxlyip?=
 =?us-ascii?Q?LFnhAcz+RtjSQClLkP5MnLhzYRR7i6NAo2GYIyZTD3oafs3HLSzXqJxQCCqX?=
 =?us-ascii?Q?JGpxQriyBnE+Koef3JMeEbdrK6aW1s/gpR9jvY+vZRAayZjQGx+MTTBwTV9k?=
 =?us-ascii?Q?xL2vrx+MT+PyNSJ3V3KnpSfeaMzsLkUthJXLFTgEwjzalTJe3urBxstiuHmr?=
 =?us-ascii?Q?IivkugDEIflVIqA5W7eESY4pySZddqHOuKB6tX0QmqYPD4oLRuUOlMoSEFU7?=
 =?us-ascii?Q?Kr1pzlNt0+VAPmak1wNfw232ONWWCRFkgXnMGN40w1ZALmF+sefHi2qLqHw/?=
 =?us-ascii?Q?p+4buXfZhz0KKs+F9UsyZcKeUyz6HxMqBfrE70Nhvd2mC9836LWOMoagkz95?=
 =?us-ascii?Q?hFKNvnL7ErRjXsjsU38n0aSS5mDoAloRuUvtD4yAKTsnHW9ySVXBokXD6s2a?=
 =?us-ascii?Q?VaIowcP80TUSGbWqD7r8giC0eEmyI4szh7jTtyU32RvkNDcRSbVGbf7HeXCb?=
 =?us-ascii?Q?ugOjtx4WPrIi27R/FGlUrpKqIyk9MsQNwmPg0jLLtAJX2klzMYxCI5bJAmBr?=
 =?us-ascii?Q?3MSn9/lbsFT65U2zDSg+pYkYmppOuMSt7AKRer0JzksmzO1ZB9Wop5PzD1aB?=
 =?us-ascii?Q?o9zmt7+TsDHscpZfJriiWsR1To23R1X6U7xGseauaGrr4gFhDj2y6eRYszvt?=
 =?us-ascii?Q?54D3zJvbqvdom7J8azdYwiapJIA0kPWr6XPLI7RvwV3d6+HzHOwFRTsWry3l?=
 =?us-ascii?Q?O1+mXxE4r5YrAAWSDE8BIbS3T3qSzK+r0KS05e8j9KvrgpoTATGBiAUIgavH?=
 =?us-ascii?Q?Nj9/ud06+WzDbgA2gOhPH2bKIoRwA/4=3D?=
X-Exchange-RoutingPolicyChecked: CcL8VQO2+ZhHHlG8VD1xjtXJjQg64gLiXwoUIy0VD5Y04n1Ej4qMYLPhkQC66loUEvj6P1w5WgeNEDgEvaIC/V8uPczfgWUaJ09uolK5nTRDmgkvDmcs8rZ5ylFYDv0h3fG6egJy/znFc4wgPg0TtrBaxaL47c1DwAKFKoql2VErgD6lqtvVHrfuANMA48DWb9+/WmFMEqu808iDf0lrWNfyO71lP9pxwzTszHayEWwGYKzDM8CnO7xSb+zf+4Z/pCDiUbMvUmdkxF7U0GH0Mc7M1pNXcTiHfKOvad5Q3nhIvPxF8o19RD40nGbaVb/4eIGimOIxJQU4thpH3LR5hg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc549af-5caa-42ba-31e4-08dee3f56a53
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 11:20:32.6861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5Ryf5w6NOQpNAJmNrxeU2b64VYG4KI7drbOrq2Y4VOx/crW7skjWZanTwcms3vqRSNlkkyVmf6bBZ0m1e1gMiv5fv67gHA4aTvhn/hSPRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7503
X-Proofpoint-ORIG-GUID: cUmCRMd28ZJjIeB6CvqhDjQeyCAi-uhC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDExNCBTYWx0ZWRfX8BSEIKkfd2KQ
 a6hMFjC0c3km4HjdpO1RH6xHl6qq2Q8nBT7ggAtbEqmTerzwh7T0aTlgdQInSwWBSimNTerK9l2
 CtSGqGEQryw97ZVEVR41QZ6fi+k135RIPWsaA3CCKEXKRuj3HrjHThDPAjzK7amEsqKDiYaS0bQ
 f3yMDsS7/6c/2AmxFxVveEZ4d7/W+Uz8X8npYuTlFx5sWTOruFZHi0lvmCu6fJjh4+F4aPgV92r
 0xMd1FuyQGBfQ7xLlCGfD+cB6TsJgIiow3NfO3RQz3CJ0EvyZTYLpc8Pe8ECSv01s+xB2YSMupz
 q0lspO62W3/FI+xsXWrgRs37LJp7TmnwxA9HPesobNYv0JpVJC67nc8RPh1bIEgQvCkTDzk7Jrd
 rlMhJToiH0CqYVcVnwh/oiUxS0JbovwdIa/gzMhKJEFCr307iRN0IdVXFSwQUT2MgFrH7pVkfL0
 3RO9KhZtoan7bdL8AWw==
X-Authority-Analysis: v=2.4 cv=WvAb99fv c=1 sm=1 tr=0 ts=6a5a1002 cx=c_pps
 a=DyFIwYW+7dlM5tCrNmKnqg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=fKZFoM0pQB3ZjpgBshEA:9
X-Proofpoint-GUID: cUmCRMd28ZJjIeB6CvqhDjQeyCAi-uhC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDExNCBTYWx0ZWRfX6FI/+tZ7znQ+
 0C2SP9yXdtc4aNSc9E6Kla9hhMMhFacQATt9O+ixUNafaSD3toKtasCItmt+sDqkO8hPMkSLqAy
 /tlBhSGBNPBlBYs13hJBdToXNVlYtz0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This macro can be used to generate the boilerplate property_set_type_ptr()
QOM set function for the specified scalar type. Replace the existing scaler set
functions with the new macro.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 qom/object.c | 72 ++++++++++++++++------------------------------------
 1 file changed, 22 insertions(+), 50 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 34aef7ca9f..8a1f80f613 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2671,62 +2671,34 @@ static char *object_get_type(Object *obj, Error **errp)
         visit_type_##type(v, name, &value, errp); \
     }
 
+
+#define OBJECT_PROPERTY_SCALAR_SETTER(type) \
+    static void property_set_##type##_ptr(Object *obj, Visitor *v, \
+                                          const char *name, \
+                                          void *opaque, Error **errp) \
+    { \
+        type##_t *field = opaque; \
+        type##_t value; \
+        \
+        if (!visit_type_##type(v, name, &value, errp)) { \
+            return; \
+        } \
+        \
+        *field = value; \
+    }
+
 OBJECT_PROPERTY_SCALAR_GETTER(uint8)
+OBJECT_PROPERTY_SCALAR_SETTER(uint8)
 OBJECT_PROPERTY_SCALAR_GETTER(uint16)
+OBJECT_PROPERTY_SCALAR_SETTER(uint16)
 OBJECT_PROPERTY_SCALAR_GETTER(uint32)
+OBJECT_PROPERTY_SCALAR_SETTER(uint32)
 OBJECT_PROPERTY_SCALAR_GETTER(uint64)
+OBJECT_PROPERTY_SCALAR_SETTER(uint64)
 
-static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    uint8_t *field = opaque;
-    uint8_t value;
-
-    if (!visit_type_uint8(v, name, &value, errp)) {
-        return;
-    }
-
-    *field = value;
-}
-
-static void property_set_uint16_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint16_t *field = opaque;
-    uint16_t value;
-
-    if (!visit_type_uint16(v, name, &value, errp)) {
-        return;
-    }
-
-    *field = value;
-}
-
-static void property_set_uint32_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint32_t *field = opaque;
-    uint32_t value;
-
-    if (!visit_type_uint32(v, name, &value, errp)) {
-        return;
-    }
-
-    *field = value;
-}
-
-static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint64_t *field = opaque;
-    uint64_t value;
-
-    if (!visit_type_uint64(v, name, &value, errp)) {
-        return;
-    }
+#undef OBJECT_PROPERTY_SCALAR_GETTER
+#undef OBJECT_PROPERTY_SCALAR_SETTER
 
-    *field = value;
-}
 
 ObjectProperty *
 object_property_add_uint8_ptr(Object *obj, const char *name,
-- 
2.43.0


