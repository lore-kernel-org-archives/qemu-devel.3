Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8DBC44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkgcb-0002dr-6c; Fri, 17 Jul 2026 07:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkgcU-0002d8-Gu; Fri, 17 Jul 2026 07:20:42 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkgcQ-00089s-0e; Fri, 17 Jul 2026 07:20:41 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HASJeX3667907; Fri, 17 Jul 2026 04:20:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=HNlW3PwW3FpPwK8U4pnE0lijpimDD3YqFmsPvtVaA
 pY=; b=xX1RHkAHF4upTRcPglkqBQKAP7thU+07R4q9qVAH8+AB9pTNUGLefYydr
 zPscHFpNTbxdRp6whPkXxx6MLFWOs6t9RHLr8AUhIFlsGqZa8mCrZlvtRdxI01yT
 8rrpkfRqrwcuC95EEUSldBbONEeTkBnpFsIcGEdQvxPCPY0MjkoD8BZJaKSlpTb7
 AuxeZECoJrAySzlVg0jVSZ89S5MfXdTDHbB6vpJRkNrBndsId7ys25T71HiuE0UK
 icbrcCaI9eGhCluSMX/SwpyC6xQ2FNxGlVPJNAen3Yk+BrJ+SolEjXBFcmLWDbBc
 +agSDmYUtfPWy1UdLdEtBqtna4j4A==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023140.outbound.protection.outlook.com
 [40.93.201.140])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ff8dh1afm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 04:20:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oa7CsN6A2lW0DvHrnCh1W3JN9W/W3pEXBoCHj3TCJBd75rqnlJ8vzgHrYeDXswWL9TE44t0sxAYgTE6QVf9iZthmjkGxUdoMSwOPRYgqGzyRM+P32ef2zcAyoVdSATxWLaA2LPL79bPjEWqkcj/G6osNYjr7qpUy1I0qWHciHssg+9TD+PDP2zOlXarYjKTV0AFrMEB/iamqDI/s7GzCDXx7zKz36qFaKZrdfPpD1yluhUmq6XTjKBvUMZtrkUknngcI3CbPHUPIBbgjuDe3DSro+SE8124/FAoFsgKvLMwmbeiaoGNpqtxdLQHF62qxTkVeLM5Id4/KeBK/fo6rpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNlW3PwW3FpPwK8U4pnE0lijpimDD3YqFmsPvtVaApY=;
 b=q1h7qnyM7ntdKoMpyFqgDk91QWu/ruPw1tVnn1bxoTW4tCWG9rdpvV1I0AmE0aVDrOx53JA4AR0fTdZ+Q459kIifnV+YTF3D/FgIBeTcGrqwKSBu+kejqIxsGDr24iZoULJo9mRt0/ElO40qw9gv2SPbdLom6To+c9Ny1Y6WkBsBuM5CI9mMdgJ4cwsf7tTX8V9OLNZi8nRlMNCRdQeJNCyDQ/kGMalFsUKV8ac97hpglhnXD2FK1iU5cLvcuHCLUT2m1pdRJGvrvJMNtjChEZzwt9Eqlbnf51I5vJJY+o0P0+9yCf4CLln6oQraCozu2EPVW5L9GVelkkjhzpDrxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNlW3PwW3FpPwK8U4pnE0lijpimDD3YqFmsPvtVaApY=;
 b=URHPG74jZRUo+k/ET1bw7bKKtUrhCjU1F2q3QsT3nDHnNNEtsfIo+W8gFy0Jrwzagiq7YC/bi+tp2U3y8Zu4M+oCwd7VQvC6bb3whPbM3mVOjYq2MLpVMck/KpjtEkkCBscgP9x9k4P3gyPkFRyISfyFxvjBv4C9NcJfpeUxUigoDBKQQM3UWstyLoJgHgOqvFw7xp0yBShrs6zzjlCMowwl/NlFc2/H+dvfTxBdHMhazqlA5gi4yWfEvEkmP0QD5AYY9I1D6kiduuKpddSt0eLRGxBRzTn8NnpNCgNMeH+erZqafCYSd8wD7YTG/pu7VjK5ReZuR0O26ngzWHRmAw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7503.namprd02.prod.outlook.com (2603:10b6:a03:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 11:20:29 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 11:20:29 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, pbonzini@redhat.com, berrange@redhat.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 1/5] qom/object.c: introduce
 OBJECT_PROPERTY_SCALAR_GETTER(type) macro
Date: Fri, 17 Jul 2026 12:19:08 +0100
Message-ID: <20260717112022.444367-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717112022.444367-1-mark.caveayland@nutanix.com>
References: <20260717112022.444367-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYXPR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:930:d0::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: d507635b-3a6e-4dbb-4b64-08dee3f56832
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|921020|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YYGnTzqti6MBl3zAnWIUIvXKWjeyxVYKG0sYJlgwC6I+AjYvNWjIpdiSmFrtnKhKeALU0BY5994JswKIiNAYkCZh1J/VVoLckEailyg/3F+NkSjJltUE1qIxdjUyknDeOB9o3QLZPfwqb7g48VB5xUFGkBcBiMkaW08J8W1UOVD2JkMe0a0Bek864mIbn4jg4pTGwX2t9pBZ6ASaLv+57cyhgNKYTl2VU/lgC+Rgo538Xtf40nsQGl9olkMX+lUU+FxRIEQNkNyOfRtmfUPQCQ3O0DIcC1K6E7fPJUJP7/3uQhFKTjxremQgvDBHk5PXK5nqnZ55myEznHw3ipTm3GTdwBv4Ps9RrfqYKjy39SS18GOzz4Gv9B//GRoXYOPWC51s9nMpaMiikgSzAqhfhBY91+zE2dvY1jDGdZOnHKi7DWcp6Xr8IqF47m+bG80kFXz1CEGT8FZbE4PnJzy3jJDZHAAEIIN9M9ScTKadvvKrIK+yw2/cEdtGBHdXY2sns8hO9ZPjTnLhYxn62scTXePRjqakVlzmgi6nGqBX9vp04AOzyvSKuo9TtP9B46j96oK+OJ0TWJqWWplTVskguixEJbnASlgzpTSldJonJbxiel/l+HR9Zp6OAVQzx32Jh37emCEg7/8BC8eelO3T2nrdQWSWwmQv1m2kZPhDX+FuDR3vxz8fIk0wLtnfSw8ogv4NRKV1Va+1mFyz51iYJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(921020)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZlsMD9OBgHFjU3wWxf5t6QvpRUu5+A3pz3UAJu1yGO4JFrlvaQwYK8bfF8X1?=
 =?us-ascii?Q?oWpMH1Xtx4S95NblcPKsSEiGM6AwuOKhdOHGWQIliwuEk1HRsqIBBpZLnhEK?=
 =?us-ascii?Q?AP8Bmypu8V63edylrJMnyuZkbTIRmoa2llse6zcLfH3nncWA1QmOgAyymW2v?=
 =?us-ascii?Q?y6pQCe/N/rx3UMJ1JEalJBW2az/sYvundnOZBZ5m6Sjm+ly/BoDe2CsM7IJk?=
 =?us-ascii?Q?bdzdKvss3AbesL1xBGj5hoCPnA013ayatVzU9Oezx6vHRB1zoFsk193GFTwo?=
 =?us-ascii?Q?0mI2qx3Z0jkqX4bhLLO9vIceOt6aH5BDU0175K6Z2Xga+CfCKPgl0DuasW1l?=
 =?us-ascii?Q?kmjceDBrGSKpuAz5nvJyJXSXhfHFb9IES2EIf+Yitr++rgMajdkwtMtFRKNm?=
 =?us-ascii?Q?BL9ygXOn2G3WvcPzy5cZRYXKG3wnG6REaLaFkZH73FUFwgbs1FAVFgHaMEU9?=
 =?us-ascii?Q?+kXHfPqayLPRDZ5tZ8JjrvNvs3SZ3Z9/iD8GWzVeYzRyspNa8YeBfO7rnbyI?=
 =?us-ascii?Q?MD5tWD8W1dOsvrZhKYlJyF9EQeCzIq75vLW2zMZ+TkuwC/UsMeKfeh340eS2?=
 =?us-ascii?Q?eATLw9Bv55vVTT8CxMOy5vWACjWS108WNr3QzVnjNaTYpNZ5yAasrWdBHKTT?=
 =?us-ascii?Q?/X7Q1b04iaxmd4LGsZWPdVtDcO8aq14NPGe6JCkVNO8K4+dkzP4JTz3oTDHX?=
 =?us-ascii?Q?kbWVK3r7kBs6IPpbd6njoU/Z8wBGxf0fdEpxzZHuvEV/5fQKCbKFXyU/YlpZ?=
 =?us-ascii?Q?cZpa+rAq1Qozt9QUPX8jJIyMv1XM64qX6QRvkjf1GkvgaprbmMGrEQxH6yv1?=
 =?us-ascii?Q?sPLUjcBuNTIZ64DgJHRTFSr7RBY6D4fgfdaP/AO8OrYnQD8hxiIAnc/dVWCh?=
 =?us-ascii?Q?72GPb4qt4rBq4AHoaLnXXKfLkId6K1sKGz15eYBlVlD1E/m1nTYDJiJGknal?=
 =?us-ascii?Q?658v4J9Htm6nKBsFjSL2XgzCVHx6gQZvukB2dkiocAT1n2RFIAxuoC7HET79?=
 =?us-ascii?Q?dtWC55LiZDBqDzwjqcY9VkNc8k5SNTLU3nGQME3s2Y+rrPuGhPiicC2lMnFz?=
 =?us-ascii?Q?4aU3Kh89TXYerRxCVzt5IJIGxngwIwLoNASeH6OKz/f7502/yf/qgLrfow3x?=
 =?us-ascii?Q?zrJq52z6ZJ2OJUq8IkFe7vH/h7Y5LSFlUweO/dkm7Q856VeNeftCKeUgEWg+?=
 =?us-ascii?Q?RRs9R1ItH3c/JDsoWvbt6D6+NmR3qYBoNselSmKNgZV9ZvW31Y7Lt0Jo8ccH?=
 =?us-ascii?Q?4cda7U6I3kKsWrckOfYqSaOD7uBTygqpq5XMwNfRtLt4PeLAv9Q/bQ/WvBhP?=
 =?us-ascii?Q?B0DvhyZIcMX9gZSpfVVEMcbe9HifBeimY7pmYPi1s7vqQQRFBM/6NEj/FPs2?=
 =?us-ascii?Q?o3c+V40sMNF35Vuk6eZ/3NFmzySA10vZTwlNyGykUzIp/pRBy3wqAj40aShq?=
 =?us-ascii?Q?02n7iCm9ugf3az5Xj/VHtKPS7F6r95mXcMCZZsLJBOe0frual5W8pHBzvZ7j?=
 =?us-ascii?Q?Ifk3X6PovcH1FXmZBtXU3oN+XmY7AT8FVSKi3QxFrjpEW4htXBnvjG/lazMX?=
 =?us-ascii?Q?xhD3U+y/tOLAdNFGuYDjEqah3wH0Kh0sxF7w5ocMsXNeq73jOeWWpF5oXuaU?=
 =?us-ascii?Q?4hPc38ZYgLsQ8GbmMumc7m7e511UxMvsNUsRjKxNiaQscCaFXgiHjb7o9Lyo?=
 =?us-ascii?Q?dEkPV2La/1FmkoDV2WnrXL1BGokszNYr43x9QHD+c0htJ4HaIgEzXmtBMc2V?=
 =?us-ascii?Q?hBNfNx6Qao++7A290bOVDBcGUEyM0a8=3D?=
X-Exchange-RoutingPolicyChecked: qBS9J0+kB5Cs43kjj0RP9FMatIcAxJ3BWSs24iRErk4oxOaezgqeqF0277uJr9DnNtK+VudH4JSGxk4v6m+O2alDGW/EpSBwWCJxaG9F6sJ9jqPxCRGij+iZnFqRfprLpYZeCQi6xA/WKmIv2CVZ5v/Hh0mwtD1BobimxVvJx5mF4sWBoRbyCiysSg8qTwKpoI2Na5EP9KEFa+dHHT3lCm4P9Bs+dKzTKsPgKWalZcH4stImSLGihkJSSk29BVy5dM2B/elZv1q2X8EYmIssBTK2KlGPd+zVMxAyuM2RBCg3WW8xfxfZsak9kwn2Odzhd6wclx3RoKwQJbrIeJPCqw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d507635b-3a6e-4dbb-4b64-08dee3f56832
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 11:20:29.1189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAPEhuf0x0i8hfevedU1Hq5SIW82Hs2ZGDX2QsqIUw3UbYYPDCm761D7Etr00UIOorSCMJN7/epLOsvDL2zlG0eonELcEDrEYF49YEvf50g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7503
X-Proofpoint-ORIG-GUID: U1aGThQhLteRzNJ6DlZtMvoDg4L7DQ28
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDExNCBTYWx0ZWRfX9PXOcdcQ7PXe
 SDuZCfdLuQeXxo5EIGcuIY+4xs2W/+qL+A3+S5n1L3Q/hlo3tDzD426UNr0ie6BjzgoR8GczSVZ
 LhkvKeGz17Cwtl5eQCI3uNvVhzo5hu0k2g4Bz5xkugKXAC7MHrR74P/qj3hEHTm1NGIF6MfKJP/
 OPAipP8itWVYiZgnTbAf7MOJhHa0OF/GOuk29ZecL/VtTYFTzbNJxY812ICquQ8FTsJ5uFhGYPf
 AOrk9ETNBvTKUw3e/ePo4WdADHzyg/6MDGidfqYl57zJ5jdSIrAafuWw9dkHXvAge8wEcjRdGXL
 MFrOncIrWDw4Jir3E9LiVdyXzLvp89cQAQ6IeKNWSgi9E3uWqq5oKnBBxenahrfFtxNLYYzc+dW
 rLLdnyEN1av6j6Oeb7v0zfDdh6KdHDc4Gbv+ZKyDIW1isxnaQ4a+gGRlgDki79qWLRQpohrFjY9
 apoJOHP1RBfKxUEzFuw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDExNCBTYWx0ZWRfX5o0Ne2Tb755k
 0q0sQi/T4qG7E9B+OYzJDDaKDkv08VzGXHvx9pnzJNcN2tnBCs8rDdQuv1KE4fdFmD94jRr+u0j
 YbA7UZqZ8nmA7KgtyrfatIA1ulWQgKU=
X-Proofpoint-GUID: U1aGThQhLteRzNJ6DlZtMvoDg4L7DQ28
X-Authority-Analysis: v=2.4 cv=J8aaKgnS c=1 sm=1 tr=0 ts=6a5a0ffe cx=c_pps
 a=Yd/70bDpgrqg65f6KmCseQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=DsYRqU8QP4ptd1Us8l4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

This macro can be used to generate the boilerplate property_get_type_ptr()
QOM get function for the specified scalar type. Replace the existing scaler get
functions with the new macro.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 qom/object.c | 41 ++++++++++++++---------------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index f79b2cf361..34aef7ca9f 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2661,12 +2661,20 @@ static char *object_get_type(Object *obj, Error **errp)
     return g_strdup(object_get_typename(obj));
 }
 
-static void property_get_uint8_ptr(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    uint8_t value = *(uint8_t *)opaque;
-    visit_type_uint8(v, name, &value, errp);
-}
+
+#define OBJECT_PROPERTY_SCALAR_GETTER(type) \
+    static void property_get_##type##_ptr(Object *obj, Visitor *v, \
+                                          const char *name, \
+                                          void *opaque, Error **errp) \
+    { \
+        type##_t value = *(type##_t *)opaque; \
+        visit_type_##type(v, name, &value, errp); \
+    }
+
+OBJECT_PROPERTY_SCALAR_GETTER(uint8)
+OBJECT_PROPERTY_SCALAR_GETTER(uint16)
+OBJECT_PROPERTY_SCALAR_GETTER(uint32)
+OBJECT_PROPERTY_SCALAR_GETTER(uint64)
 
 static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
@@ -2681,13 +2689,6 @@ static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
     *field = value;
 }
 
-static void property_get_uint16_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint16_t value = *(uint16_t *)opaque;
-    visit_type_uint16(v, name, &value, errp);
-}
-
 static void property_set_uint16_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
@@ -2701,13 +2702,6 @@ static void property_set_uint16_ptr(Object *obj, Visitor *v, const char *name,
     *field = value;
 }
 
-static void property_get_uint32_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint32_t value = *(uint32_t *)opaque;
-    visit_type_uint32(v, name, &value, errp);
-}
-
 static void property_set_uint32_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
@@ -2721,13 +2715,6 @@ static void property_set_uint32_ptr(Object *obj, Visitor *v, const char *name,
     *field = value;
 }
 
-static void property_get_uint64_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint64_t value = *(uint64_t *)opaque;
-    visit_type_uint64(v, name, &value, errp);
-}
-
 static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
-- 
2.43.0


