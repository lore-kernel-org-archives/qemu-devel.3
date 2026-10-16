Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F45DCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHipe-0003Sm-Rs; Fri, 16 Oct 2026 10:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHioq-0002pM-Rq
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:22:07 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHion-0006jJ-TU
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:59 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5GhJ3502681; Fri, 16 Oct 2026 07:21:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=q+TiuT29Lft1Lhctk/2jJK60T8JNvSJE91lHid7oU
 0g=; b=TAWdMoPoVJXiHI3OOR42lL2AyCbNBwCmxvkEmW3i7Y7aSKxheHc8bGMp1
 1nIcEyTaOguDuvy8KSByACYbngWsMo4rhh9ckK8qvcM39G64ld9YvlmNRQ+4rdh4
 FjhakINn2/o9m7EWhQNShbnznQtRahw2Qrz58xp7upFUnwvAaLY26l3Ij/RL16b6
 SxZpgqpA5Cs4oCp4kUasDlmaitu7CbYfYyXs0dANmdphgdFgBVqKWRIZAJBKdOjN
 7qoVK4LhkApVaYK+tfvSKk1rxBwNrGPtLeivZnEWZ8Odnzj9FSyZzlEWY36NXxcb
 Ne8oZq65uZboOtBAy2nbYWvBJFUlQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021103.outbound.protection.outlook.com [52.101.52.103])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hbg268s3f-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:21:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3OAY0B0cbBNUotLesPueiuIWnV2vbikSvA1Le8TasPCuScK5ZcPkcfOwkNTAq/T6DEUVDeWN/ADC58GRxcIgbE3pisqldz491XhXrKsEeFjPnfJssUmwsoRjM/ao0zE7CRhj7Evjkk7+q0YkW5R/9Ua1GzJkmtR3VOGbFA94dGbaUh0KBBUs1ttHnpg641qcupzzNL/pXjTXYonmXpT68Bvt60hkPwjj3G2vOwRIoKXZPv+uEByIblZKYFkINNDgo67SWffEUkxOFNYhtyJrqpvibpaTHVqxc+dCd3wxXEas67w7jCLeDo+CsA9NY+e5KwxdXZk28J2wbhqT1cJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+TiuT29Lft1Lhctk/2jJK60T8JNvSJE91lHid7oU0g=;
 b=MkWFskghrWnjMkGxpj5UJi34zgAs4oGyviWLBFKg+j8Dq5FGVbnluEaThYlvYihaxMF7VbPHOyGkN98f6KHH5rXdmFV4ClQHiXRVfzSuBWe8jYO2LX6pHweEl8cVFjeKpJqthxvPk0vFSTlgeo7r5WyfNW1hB33aDwQFoGUdi80nLJAA7CLfHU0sIrEbSIbmHz8p9hL58chMJkMjGUdKEzCHR4SfDjk/YWFVZnRc1b1UsGUNIRut2RsupyHRsK7Bq/xO1+JxQLtPWa/wfQyh0s31sqOFXTHuyOPBdSYAriWchrvs/ZWUYUSTUL0NjNfuo4ZFVtl8cmOOKM6SAqaROw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+TiuT29Lft1Lhctk/2jJK60T8JNvSJE91lHid7oU0g=;
 b=uOUgB2J7RPLQzsBBW1eB3iLNn3g918TC0FvKL/CPxRMe+G9udlSnogPCrgUOjwe8TsOEfXbEzbqEYHOI0bFWa5Br+wGOC/HEGL5oJVK7zMZE+4DwIW8dD3ovpN2SOGWzkf/dSWXqC+khDfCJTbcMfHxLvNJ/12jznVq6kgdv0pLxP/fKpmjfh89+aqNyx7VZJViEHInvALEJs3vCi5Us6SE1dpJ6JMElC/7HlffzEtLLgNn6EGDa+HmpedniHK+dpHwytggwIj8xqs0Qnsaeq13iILGk95AXc/YviOAqpSChDJk3mxWAuMQNVcFyzu61rpysdau4MjEyx6LQ7/DR7w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11424.namprd02.prod.outlook.com (2603:10b6:8:352::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 14:21:34 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:21:34 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 14/27] kvm/i8259.c: use kvm_i8259 prefix for functions
Date: Fri, 16 Oct 2026 15:19:20 +0100
Message-ID: <20261016142031.1204281-15-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::28) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11424:EE_
X-MS-Office365-Filtering-Correlation-Id: 69076bad-cc53-49cf-5817-08df2b90c81c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|10067099003|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 0+v8Tnc+e/mr/zY1IgJID4aAB+V/eZ2UChJZVsr5kncGUoXC/ikK/wSA/4gbUW9xU+I9nyvhI1toMM+dmWZjddv3OyrKOQreWHt5Mxn3bboxSr66ax1AIROII6chjj1eUzSuL6jWm7wuf6ZT0OZEbCBuqt/kjHO+aLvrHdL2AndqAz1x/EEoUYqxfRTv6kPtujI9NCI4dzdyw1FSuAvw8RCgOoPl4OqFWD9yvj4QhZDMSa0MTLhZ8kRqYMsArymeaBKApAGOsn8q1zG1Kk8IatMJAAP3AhDitw2MCzgkAvB6/eCn217lgn6tJkT0dTFun6eajK1YtNQ1oAmkjFRZ3lHl9F8xNV6lggidz90V8XChmL7yCP5fPIN/efR+YXpcWa8gO4M7j9AWVyojAnzl+VN9u4wAK5XTCOsEkwr/nJ8X1CCz6r6m8FCe/0aeMIIEsRqqak48F24t8GMzZ8N4W2d+A4fqSrgxgEfXQ2fmcCg6vsxvof425aWPsiAr1jiMhg63AnLQfA922hIs4PGOsS5iipKhc14MKwggE10sLsnYHuuOhUJ48Uror1okYQ094MZW+9lsVPyCQQ4t2fEIZ4wCTrrLRwZEZD6ffQO5vvlE9RT+IIqEWZVY2DNe13tTphz9Xg4v9ow7X9rdhAIRKZ8XlOvv1Mc5G/lWuqt+RHI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(10067099003)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZtELg850ZJXBovopVYv9JjnMZ8QpowGqilFDmrlaHdKsB7OZHsvpEYM0cykv?=
 =?us-ascii?Q?b1wTUXyIdhkzrfVnfT5vzWhLXvPqRzQ/8+BZzRfN4V45XbK3hWLrCjB/WOMX?=
 =?us-ascii?Q?OOKXc/ADmMovrZKIl+ltjLtboC9641zt2qQ31PQskfV3b0gQvFkSKAoPPnuS?=
 =?us-ascii?Q?5VvgwJt97w5/OE6DY6FPkXKG0F29m3TNO4A4FJObnjDGohXlm+wWEbXEkJZ0?=
 =?us-ascii?Q?0cSjgTJlGMeVSNnxVKZHHrIG+hr8REVNWxMzkwNodAuNz/AqfUscn52NJUsK?=
 =?us-ascii?Q?ALFk5UWE0/DuqyXlYMtkdC9wouxreK5RNFtYlcsID48MD2rqFLWxfiiE6V+y?=
 =?us-ascii?Q?4YeP7GsIIzEYCLnCVV4Dj7imDFkLZZoxl7UDKPteT5lY/m7ag4vkXzpdp0wR?=
 =?us-ascii?Q?L1amlwBlouIsRIkQPInqqOaxABzkVz7zGPsSOP9Tq7NpRz5yOXeOfPZ7hZ3S?=
 =?us-ascii?Q?62BxNZ2jOtfgKM1XZ1eactKCfE4UZJHDCf3uWbE8DMUeLJ06o+y2OdSW+kG2?=
 =?us-ascii?Q?pmCHYcjEL3Eilzg5sEQrzdzhRu9zeAodFrGb30fpgLK84PYCF5Jh4PUi+BAD?=
 =?us-ascii?Q?5jNvIB8KN5u6XVwxolCPvAZOuPrePI1iWWJQHDZ5FpMlx/e+nLotcfs7tPCw?=
 =?us-ascii?Q?DMcrk7wJreFWLtihXV4MpbLNl+2SZ+OxPsAzXESp/k5BRma9qTmC4dhH0wva?=
 =?us-ascii?Q?ONxJLJgB5689MeAJg++0mr2jkle0CPu77twPRWmQ+TDXLAwUViLDZVFzPmx9?=
 =?us-ascii?Q?l/Mxz026gTAFTo3+DPVMY3uGNxhBdBjz8BWNEtJ88z/X9NrZMpkHo+cqf5kV?=
 =?us-ascii?Q?xzXcEQNdHWNsyzO1z9MlvSLdo1v0Hh6/ewyXUrfaANrJxppn3miC4qLb9KQH?=
 =?us-ascii?Q?zNldGAaauvcBU/Mjwc8tgCq0JIczKKqO4eTS3wfaTdJDI6TWUi7+Vkt9EDdo?=
 =?us-ascii?Q?3AfKbDuB1XhU/v1OcJ1AP4iMjdEXvwwAEyC4NuEJgm61wYUS30J0FR/pLgMe?=
 =?us-ascii?Q?kEXZg7MtM+Ufb+G3DQ0wIptCwGlu9IoW9yKKft/J8teGQE2J8rEPhDpZZmck?=
 =?us-ascii?Q?N2a9aZt2BAgu52N/v3lUbBgGX6TRF5YROBM7TdySKaZvpZLtqkn2UwLwNO6f?=
 =?us-ascii?Q?PqFBY4Zh3b3zXHKti8P06OWBS/40tTzf3XwLVvlL9XDfvOyXftkgEUwp4zlz?=
 =?us-ascii?Q?ijXdeF4tKVrGdjOqyclLZxU76fUqLc4XUZAxzldpSavhDqIrZoajB9eRosx5?=
 =?us-ascii?Q?Ywi7jfIkztiGPLOaP5jIVIC2+kypgwfb1himVnZrBfX72buPmQX4JgH89jjY?=
 =?us-ascii?Q?Z6XFcBoS+3kaTz4YiA9OQ9hwb/8lKjexXUZQQjxJZfWefiuql02TG05uFj0f?=
 =?us-ascii?Q?Oq710bEAPQIaqzxG96NQrpYBf0hgcjrfzDykcsFwB+lGfzLUeZD+yxtsjWHJ?=
 =?us-ascii?Q?yVvSlZ/mWPLR2hbScolnMaa3Zu1v4KIIOZ91BwyjoIddyZpXoeE/SUwCyZRE?=
 =?us-ascii?Q?Gmkt+URfUKGL7bzl0eaMZo0aPFTdIF0yRPSzyZBvAji22D2CAzlBCCvBBTrt?=
 =?us-ascii?Q?+bdEUrHJkIY18nqIHNY07NmDrfXNwIUJ6v3dDVnbMhibBMz+hYA5WHI8L32N?=
 =?us-ascii?Q?6D7x8TlNd6E3jl0/Q7YEIjmgJ+h5XqOylY7QD2Y3eB4TVnFRF0nxy+qTLcYq?=
 =?us-ascii?Q?OSDgu1hOQDyEnmJyy+Fzx56IaZlOtEKS7+hhfzyPP5nR2DMQYaQRBjzWGkYV?=
 =?us-ascii?Q?HPxK4YZUW3ddEZN/G9YLtbWZ+C0LfWg=3D?=
X-Exchange-RoutingPolicyChecked: leXj+3WZvgvc9AgPwGdGo4jofV/rgPPQbfwVGc+R+tM/hIslsWCtrD7fO5LA6p0JRMFbPnis8nO60jmDpQqtuN/b9jZPN17IGO6rLEX+S3hxsuHMsz2nP+5ibcmU1FwBXX2pYvUvbdiUDZkpFU2xPJniAgzhEqLDKbfjNFg/bTudWvAv+DFtElYQwxc8IJ1sHrioct8jduNDKTHWIIQebZQqkOjs7tvuCEWE4/98kP2wHQrOBxU0Nq1Qx8K6RJf11bU7GKMNA2RU3o1sLDCoO0DcGgiy57BncCIT0HYofZVkpLLptFujO2JlJo2OMAMRXQmWWEATJa7GhcRfvTIuXw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69076bad-cc53-49cf-5817-08df2b90c81c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:21:34.6125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yzadlPVZTl/OsBDB1RyWeC7uVT9kdziyScrnfWyFTizZErd85d8fuUrAhX15dMgHvmuGMPNkDxyZrO5h4qEMt4mMBMRAG/SGnl5Nparcfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11424
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfXxXsJu7r5mPbm
 HCKQBaOb7uJ9X9g4eBoQZ6JOuSgLtK1cPP1x59mOCjiub01jvVf5NZW2u9OkBKg0LvCBCpn3w9l
 zVH2M0LssVj7XvTKtpnkuSsoARl2I1M=
X-Proofpoint-GUID: Aj3vd-vBQd-d2Fv7mFOaaFdhCoTt96YP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX6KWC7WkBEWI8
 v85l88tdXe4HuWDXV0irGxZ8eomsPpPIrggqG6Q0dfzHwhJ1VvLN7MZSPP9UD86f4Q3WNgeUUmU
 dIUfs6ft9t0BVaKsMZzQ2HB0NOgFUTiqcIN7u/Y4W8aIq/DuqF0LrdZAh4oRIEjb7q93C6kmf7F
 RqwxFnCT9FMcx7dO6KSPJayze7GMvG7iyRE2RL9Eus6gxaz0o0UUIilCkIXvipQolYAAlPdTIA1
 7mH3KezkFhgYD2Q63ia7nC7m5a6DRa6qHcFOAi6sLVQKvAOXguwtcaYmPXKOspJz9WonXDzCopa
 nhBJXWrgEZvpP/SlMfy9UaeVbwanz/Dc7IJtEKjVtxUwDCMAh0ZXZpygJlCIg36HSdZWLIzHC3D
 jsJEXMzQP9VrRXk0wvyz1PczGJgwPJ5CmmJVrKSA134cV7LPbPNITe+CeSP/2wGbtRX83OLqhLL
 7fw4M/PMy7LgtDAVaSA==
X-Authority-Analysis: v=2.4 cv=G5OJgNk5 c=1 sm=1 tr=0 ts=6ad232f0 cx=c_pps
 a=yD2eIpN93qk0sgAC8tXY5g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=b1AWVSNg6wsnrng390EA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Aj3vd-vBQd-d2Fv7mFOaaFdhCoTt96YP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

This ensures consistency with our normal QOM-based naming convention.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i386/kvm/i8259.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 3a960e48e6..952f58be11 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -36,7 +36,7 @@ struct KVMI8259Class {
     DeviceRealize parent_realize;
 };
 
-static void kvm_pic_get(I8259CommonState *cs)
+static void kvm_i8259_get(I8259CommonState *cs)
 {
     struct kvm_irqchip chip;
     struct kvm_pic_state *kpic;
@@ -69,7 +69,7 @@ static void kvm_pic_get(I8259CommonState *cs)
     cs->elcr_mask = kpic->elcr_mask;
 }
 
-static void kvm_pic_put(I8259CommonState *cs)
+static void kvm_i8259_put(I8259CommonState *cs)
 {
     struct kvm_irqchip chip;
     struct kvm_pic_state *kpic;
@@ -103,14 +103,14 @@ static void kvm_pic_put(I8259CommonState *cs)
     }
 }
 
-static void kvm_pic_reset(DeviceState *dev)
+static void kvm_i8259_reset(DeviceState *dev)
 {
     I8259CommonState *cs = I8259_COMMON(dev);
 
     cs->elcr = 0;
     i8259_common_reset(cs);
 
-    kvm_pic_put(cs);
+    kvm_i8259_put(cs);
 }
 
 static void kvm_pic_set_irq(void *opaque, int irq, int level)
@@ -122,7 +122,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
     kvm_report_irq_delivered(delivered);
 }
 
-static void kvm_pic_realize(DeviceState *dev, Error **errp)
+static void kvm_i8259_realize(DeviceState *dev, Error **errp)
 {
     I8259CommonState *cs = I8259_COMMON(dev);
     KVMI8259Class *kpc = KVM_I8259_GET_CLASS(dev);
@@ -147,10 +147,11 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
     I8259CommonClass *k = I8259_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_legacy_reset(dc, kvm_pic_reset);
-    device_class_set_parent_realize(dc, kvm_pic_realize, &kpc->parent_realize);
-    k->pre_save   = kvm_pic_get;
-    k->post_load  = kvm_pic_put;
+    device_class_set_legacy_reset(dc, kvm_i8259_reset);
+    device_class_set_parent_realize(dc, kvm_i8259_realize,
+                                    &kpc->parent_realize);
+    k->pre_save   = kvm_i8259_get;
+    k->post_load  = kvm_i8259_put;
 }
 
 static const TypeInfo kvm_i8259_info = {
@@ -161,9 +162,9 @@ static const TypeInfo kvm_i8259_info = {
     .class_size = sizeof(KVMI8259Class),
 };
 
-static void kvm_pic_register_types(void)
+static void kvm_i8259_register_types(void)
 {
     type_register_static(&kvm_i8259_info);
 }
 
-type_init(kvm_pic_register_types)
+type_init(kvm_i8259_register_types)
-- 
2.43.0


