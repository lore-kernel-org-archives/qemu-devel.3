Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC63BCAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13UI-0007Qy-55; Tue, 23 Sep 2025 09:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Tc-0006RE-BA; Tue, 23 Sep 2025 09:54:42 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Ta-0003zw-4u; Tue, 23 Sep 2025 09:54:39 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N9ZUhc2985958; Tue, 23 Sep 2025 06:54:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=5pQ7H67+fisx/+wCXqMZlrzA18JdUUFx/bdkqeZws
 sY=; b=dr1s5Sea3IO3ASl0ZSvPI+TIkXAxLO/GHisofGXCKAdxVlUSqBvN1u4VN
 10mXwkwep17oOt6RNnITZE/egvyVe2M9hP4qqNY9w5KUMy4YY76PP3lTlvQIeMyu
 4N7D0iGJxi3v2oKu9fO0zcOFX5HT+8buPskU7G332zI3Y5OfOwymuemQU6muSvqa
 ulVzEBu3n4LNeE5bukFl6XyoqhXl+y6HgRrxe2bdrXjnca1rsoXqcv4ETYHjoVkW
 Vo8o62UQtSTiQTlBz8dC7Vb6KwJKW3HnPP6lGzcYQ6bEtLY6PhEc+abzTWShTcwy
 Dc+LVtLwH8k9iA5JpUuy5H6BS1Vkg==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021135.outbound.protection.outlook.com [40.107.208.135])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49b6tju026-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TK9mrM5ttZ4tOHeGRPTtyK8ANUz2J2GOqsSwNgfd5tBADzEYAjSfN5hL0S1RrQrF3uKfqsv1iqkAWExgdzo2BW3CjylopKsVx024r1ebzozVmzqmSHTF0Ut5CNgy/3N/o4m4/B1g/EBMThbCSvhNEySPHRLZ2HUTJsvBcIzsEk0MVQAWk610+O+qlmuOgZdNSdWZKt7ivngzTisEhLF7bVdKgNLZFlL5s+yo94n0ccyhyr2hT5bxoFhlZx4yX5qkTfoSLZ2M1wxJ3Knhg3OiUwOjkD0KO7FwcCsmIxKiLQ8XitmI0SHFghe755Sbj2VFeuET6BKcmIEepo8fOZMz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pQ7H67+fisx/+wCXqMZlrzA18JdUUFx/bdkqeZwssY=;
 b=c8wCUCsAKs7p9Bp3O7yEh918DCwWK/eLHvT9AkzkqHkEPb27NeH9L0duwlshvZdZbCltW4lTQLbcVGKBSBHU737neLqrTdDHFIMvpRsL+A3fxPM3vyg/eDNnEQd/rsshEhL9AMiVCkIgZZS9ySV3kMDDpUAaocls5zgw2VWfW8oFYgeeIkrPk6MVUUWylenAWH00X9dT/U81ZZIUkor7lBDdlkRPA37aWdQIGmixpotrpVc0SDrGooY3DRYgD+WJALg8xUKKJAJEyLIOfSo5tbRUmh68FIQ3A7OPmdgGLHMkPUZ6LSl6fJQQhbwIb38MudrYzrzylGtEv4vPNIFkPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pQ7H67+fisx/+wCXqMZlrzA18JdUUFx/bdkqeZwssY=;
 b=wt5uIDBUkw63u2rdqCX46KMj7IhtmaErPkVS+5uGOj9xfaSsBE3p7mk+X1OOsh91qhOPLWr5Dc54xBxL7klaQeKGIFP0f8OjEw+MCre2S2UHZ5Wyx1vwITm3nfJVSV9iW1BDjkPVWj1ptascuMlGhenjAB4On2ZFWExiAx3Wb8DyLMtImySfUQmIMiTjtCUUPvvsAFGZIVrtI2l9AzMuHCsLcBgorwrvO98+Wr/RkVvFXTGzS5k5l5filv1EZ2DxLVqLq9ShaDIgU31t7CGYoZcb1LEnGU7spEDFQav6SX/ByEauXo5rM7EuqHWRGVKz4c/g+rZrAMm0M51mkRY8DQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB7037.namprd02.prod.outlook.com (2603:10b6:208:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 13:54:30 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:54:30 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 09/27] vfio/vfio-iommufd.h: rename VFIOContainer bcontainer
 field to parent_obj
Date: Tue, 23 Sep 2025 14:53:15 +0100
Message-ID: <20250923135352.1157250-10-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 315fcb6b-336b-425a-4e6c-08ddfaa8b7c1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|10070799003|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2Lzz4vldkVU5IH+y7pjusQlllVHtnF20qHgaycun1j2g5RjgkGcRwydSJWFe?=
 =?us-ascii?Q?Tlhr4hT88eio6BIHE9kroxf8pAi511LlMLrZ2QkjPelpHudh4WygCCe6NIww?=
 =?us-ascii?Q?IyxhajX0sFIpExIayBWRAr0FKBmoCmZeTFf+99bmCEWp6N3liU73a4G1vrH+?=
 =?us-ascii?Q?6rD55VH2xqUqVmh130XGGqOuYuYQPQexSUAenulj5d2cSKpiYxD8KI8siIE9?=
 =?us-ascii?Q?SIlhiNwVcVtFBvrZZtFzu65kP/SGGX3oZgd/fE0lB+v/PMwfEsMlGbgwEm8J?=
 =?us-ascii?Q?7aMCI45Ph6XihpXqmYGddrRKCB1Jyvf6UELXcl9jREXvPXRBhvIZK43BF6PP?=
 =?us-ascii?Q?NkpIED08XrsEQw7ncK80+fmN8K22qNfo1WCAqil94pCWBsy2wp2fyhTtLSUq?=
 =?us-ascii?Q?vLJioKyTepLrjhhaqKFDZ6JlGHS9lxGP/6/GrTcr9WaUQT2qoSB/Q/pIudVo?=
 =?us-ascii?Q?5gxuJh0UFYYLkvOBidm7dO0iYldzAyfgouD3fxC+Lr8BDB/JjdS/9yZrNCVf?=
 =?us-ascii?Q?oEA/9OT0fzjZIr8EqJ91glc4mNz+AAC2rOda1hQA6db3mufoz1IOH6WaBMtF?=
 =?us-ascii?Q?QJuD/lVPtm6dLUCR5qy8ogEXxZ2Nsas0C5YWR5hhxOzQkTsjJSzEbm7RQhjm?=
 =?us-ascii?Q?ujDz9xPSUnekThcXqaQdbSD4ZXSV1xJVMDVkBVxjSXa0x15VpKrkR1oocSeT?=
 =?us-ascii?Q?86QRWfJySoMNsf1HXmi/el2cgL+vDb9RQfKop7Qna+rGRbIn1bn3qcYUFO5H?=
 =?us-ascii?Q?MrLvRDzfM+P8xpgEB/7BKwFtJlbL6qlnJ06zj2BzK0rRXQESkPEA+2IupiWe?=
 =?us-ascii?Q?IkRjn+xWlLroWwFVn5ZXT9+OxgaEKm1kWUep1gjEBpOtwDXDHe+kV9dABOhR?=
 =?us-ascii?Q?rwplfUH0MLD0UaeBybOMgBpozC6lcETof3yZ90/jgRsaRyvgQEI3MsGRC18r?=
 =?us-ascii?Q?rC0aGZZtsVSxsrJOmjOTw8uIERTphGDhpFhsr5UGexEND7OlCMC+pldd+BRT?=
 =?us-ascii?Q?zL3lM2ssYnf3KbiKxWpxxz8fyOtZxTwsY87ZYVk0UzpT61FNrYWkvbIDmi8A?=
 =?us-ascii?Q?md0ci7lQnx8wNQh4BDWPIIu6kwpElOnZP5dkBLWwKPmbuC5YicbzJJ9vm3jx?=
 =?us-ascii?Q?PVjvjnSyMKmdTrAgyellBAUi+3Jt/l4kSnVsQgqG/nct6myyTlWc+NvV25U1?=
 =?us-ascii?Q?nbYOYrTT/Jjku9d07SOpR6qwGEBAnmGRyXYn7HdkpxAVUmBnafNQ88WBF/Cq?=
 =?us-ascii?Q?5UNVy+RQfuGVEVrqsc8rad04vrZ+U6M9jPUlqTePF0NseT2Eo30SVzr36ptd?=
 =?us-ascii?Q?6Nil21nQKE6RsDUHazI/pEDZtE6AuJS6NeRAY9LbnmAm6SZqZyTt/NkDMa/1?=
 =?us-ascii?Q?+TPf5s7XEjtzULhAAZzLEzQzJUZuSb+i8TzEI17mXiSmFCLNCAu5Qea56t2i?=
 =?us-ascii?Q?sSkC3rrQCcpNa4m/5vXe/5EgbgXfXhdOV8P6Y4QAUqooH7qZok6JhA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?30cGZjuG1DajoxG8RTX89Omq/6oQxlBmrtqOWG4+QJTg2IzIEbgYMOz9ufTz?=
 =?us-ascii?Q?TXkIybP+JieUaU7Hnbbat0krXLK6i1oH6FxmjXFiV51grrokHcjiUwkxitRy?=
 =?us-ascii?Q?HnyAgCK4WuTy1GmMKYFcQh4Oek10sqsYFF26Lj6m+WWnYfMhc6fdK7+KtBdP?=
 =?us-ascii?Q?oqSDT894paO+DnMh2Iw40HbyYAyFMi76KlJ5RnYgbQw8hW9Fac5ws6OaGd+l?=
 =?us-ascii?Q?mPaoHXl3yBUGJDWc3UWBedspWb/uMVjm1yb9QT7IR4Wb19WTUxSzhkAhB9rE?=
 =?us-ascii?Q?gw9uuEiGHTOklIGDfD7jZwVYlrbji5Bie5hAJHSnwA3WGTTtenOqTKhsM/5X?=
 =?us-ascii?Q?jJLqAnZJQ6YFj2zXqi+8A4YBFBVPeqEcDeC9APEyPDza+eDfH++mO3ionZL2?=
 =?us-ascii?Q?cfMOGTWVi4L1uwsZ1KZYMwb0kWjLNLbCcpFVYM4w/iVwTvubn3xVQN98QQq4?=
 =?us-ascii?Q?6M0+MPF7AkVj6ddziTw1Y6nDoQ9cZxgg9jReBpJPw5CorHpuqMpy8KkkAlwP?=
 =?us-ascii?Q?88riREDMooSv/mcpbdisqEgXXlhDgD2KUipNqtJFwlWgc4oRPMeLtm9HHcij?=
 =?us-ascii?Q?skm/5QC0qZPnP8uORpHFMWy0bjMsF7GbfsXqTwxETsutH07MBUkfK1m4Btk4?=
 =?us-ascii?Q?Dkxb+7pMKWjk2b323fMo4K7Af6VKKO8D30whKEZ8B6cjB+yj2lucFI2uHYGx?=
 =?us-ascii?Q?rwMN4R1OJJKb6inhsckId4Uewkr+Z8AXFWiyi0DKJkapB3aSk7zxk/TbFeiC?=
 =?us-ascii?Q?XvdOmHVRVhKl99o3Ki1M/KZRPRdc8YR6roe6/B5tN0A42i9ic0K85GR4IB6Z?=
 =?us-ascii?Q?jQZJon9M4xBPFA8dVrQZ7CJKZV3yfxt3Xk3+jXzHoa3Udg81w4u+fyhQgWO3?=
 =?us-ascii?Q?e5WPPp5ppBczVVrUjJT0TEiP7fxVB/gmn9sLxUSBEji1uNqYY7ZgJkeRBhbO?=
 =?us-ascii?Q?o9e4L9fcyNpkQGc0VEsC7kT0ntBbEmA1UDetCjMLri0d/h84bJjdNxZ4ioTu?=
 =?us-ascii?Q?SBwCkrk07+7sZJbnTNvYqdvBM/74Jvl4YFbQVQMOLGeqKGveIEp1VTnWo/0q?=
 =?us-ascii?Q?ssdV7LSWQqjcjkkYjuBtsLashb+TRRnIQv3+7D+dWOfbYR0Qt6zRY+S39zW8?=
 =?us-ascii?Q?WFgYGl6QwN81ZZEL7O7BIaOwFm8WxVvI58l0gKAcDI+DnTslP5w3YteEGmZ1?=
 =?us-ascii?Q?t9jJaxQO5lwv1GzMSYadoKX2e5TkHCn/ZK9uQiHFc8ee1lSxwyBPnKpMLvzF?=
 =?us-ascii?Q?DKtL86wQCEEHalIn5IA1I+Z+I0d+o2m/fz6WJ75JZk7+xrlBU+4UnDWSNKSS?=
 =?us-ascii?Q?0jq4JISTr3iITn+1e9JV9pCfhyGO8Qg130d0v+3bs0+zuOzfHXPFPE2h4f6O?=
 =?us-ascii?Q?gN1fd1MLAiUkAeUrl3J6zKns6gjOr9DqPqNpPz5tbaFRAjq8IhjLQee6s+Pw?=
 =?us-ascii?Q?kDdK/PQm4LveQuTG5gMr7MUAND63jHtUlIanVU+5jldy6FZnbv2JPFwHOlWk?=
 =?us-ascii?Q?3eTmDkNux5OD1+s4kxtIn8RdXdldkca8mdq51UYwH0Y0iUuj5J2+TMuqLldG?=
 =?us-ascii?Q?sa5KBvM45bWC1NyqwGVFUAJjCznW2e7BtCAWrceNNLTx5kzzdPQWgWi5ptJ1?=
 =?us-ascii?Q?cYQzdSY3m1X5h9C8r383AU8zFpV9UyX8vlsSWrMGhfV7QDD1QxgiCm4ERUQl?=
 =?us-ascii?Q?P7GzRg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315fcb6b-336b-425a-4e6c-08ddfaa8b7c1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:54:30.1747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JK5fBTcEplKd4SG2H01NWAMunqGiXRorkmJAu1YrzBqvS92uEgdt/BFNGNGFmg4XqjTaVkJM+zXAp4kWhQyPigFk9NfjbpjK6NFtgrKX+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7037
X-Proofpoint-ORIG-GUID: kKMArUA0cXDD8YNS6CnMifm_kTwrdKlg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfXyD3enU2lJBE8
 AhlbCly+WoCa59x8ZOYvTdByXZVutxib4RPs73dsoLwAaLAAyTL0+ickvIa6c4t09GED2fuPm80
 212hd9tU5BfYRbyGcyFRAslYB3sLrJ6vBJkILKwDn3qY0DNSCWJ03DJmThBHwcbo+iGXzfyviEK
 oE9RGu5JVgbCB1mfJ3JEn/XlBzlXyPaOYxBIPHOtGJvKoqyHS3ZboU6DT0JTRefhpwxNkxG7l1n
 t6ygqxRQRwpRtU7P0NjOsDxTRE/JO4sk4Ku1XaCj1w9Egr4KyphLXkXE3lSiPm4+Tf1+adttwwS
 zs47wuv+wYDWpT7GZDSSGx5BYmswUeu1vhgylhi0VgW2a2uA8jCpuR0v5hDJ78=
X-Proofpoint-GUID: kKMArUA0cXDD8YNS6CnMifm_kTwrdKlg
X-Authority-Analysis: v=2.4 cv=BJSzrEQG c=1 sm=1 tr=0 ts=68d2a697 cx=c_pps
 a=49tiPNKudA41XY8u0CHlaQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=8L7MK6Kl4ER3plC8pQ0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

Now that nothing accesses the bcontainer field directly, rename bcontainer to
parent_obj as per our current coding guidelines.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/vfio-iommufd.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
index 13f412aad7..6b28e1ff7b 100644
--- a/hw/vfio/vfio-iommufd.h
+++ b/hw/vfio/vfio-iommufd.h
@@ -22,12 +22,13 @@ typedef struct VFIOIOASHwpt {
 
 typedef struct IOMMUFDBackend IOMMUFDBackend;
 
-typedef struct VFIOIOMMUFDContainer {
-    VFIOContainer bcontainer;
+struct VFIOIOMMUFDContainer {
+    VFIOContainer parent_obj;
+
     IOMMUFDBackend *be;
     uint32_t ioas_id;
     QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
-} VFIOIOMMUFDContainer;
+};
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
 
-- 
2.43.0


