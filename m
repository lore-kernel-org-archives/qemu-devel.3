Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD932CD5BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRnX4-0004aP-MY; Tue, 26 May 2026 04:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wRnX4-0004Zm-1X
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:53:02 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wRnX2-0003n0-6s
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:53:01 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q8XRap3083683; Tue, 26 May 2026 01:52:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=Rjm81ggHcLjB4Ib
 owMWilF5r4xzmVBgyMe7tqfquNKw=; b=QTvagjiZJLPQULGJ28kP2LuWtkiWI7a
 5eq5P3CCaXjHn0cgPdqK441ZSJZJfd35Djpk1XJuVI35H1163wMWM0bI3vh3C9xC
 xpbpu2quz+wEzlelN/38SWR7CTXVhMUq1XgMZNM2JqhUgP6OpvMgJEyztcgUlZUD
 2P2XYUDJZ1uFk4+R8TPLz8CyE2fNx1sZdZzMnWJ09WrLJLAX7MRpYHx0lCwBqic5
 Iapjr2ChZtbQV351H9fanu/6VI31Rf3ik4RZiwEfQ3d8V310TzHOlDo1ZjIEoZet
 R+579hnymKsnCM5iZL9kmk/QqdFKglQmKFaVMPKvDvd0T4c4dAtfjfA==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021096.outbound.protection.outlook.com [52.101.57.96])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ebbs0e595-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 26 May 2026 01:52:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPPXOLxL8CgILlsX7OSkBO8lULLSxxyxoTVa+kKT5IZkBmE0OoSltTgQn6TlkShformQgBRuHT7ZQ3mUCzHk2tNZpreE7B7DdQ1eXBOaPma8Z4F3ZAr9mFr6agbkaWURA0fiVa8hE0B5vNdP7cQoMLPelz9BGbVh4TpCFf2rqdHArw/BMtmVeT49OKB+9Ojg2LukapptLbMoE5QriZunDocxHVzWO9VP4TH9XTbps5X84NW5YUyUHV/KVijs+AUXd7JLKaXK1sl/pH0y/f2reVTb1RurT0IeWguGrks+ziLbsHcHBVDDzmGszE7++R6r9hvIZe1XuaqvvVeTx41+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rjm81ggHcLjB4IbowMWilF5r4xzmVBgyMe7tqfquNKw=;
 b=fzVUvjXKlukNrBaa5V/ESf4JIEAc/BvkxYdYj5qsX9SHfLmt2UhWDjgg+3q0cN5JP5FK0B8Zd0jXSsg1CVNIbi6272MnS1PQ4wgqjmfXz3adNpVLbM4Od/++yURXdPLEDYKo7EtIMMC1r+GGofPqYww4iKrFR06PubFHNlhFNXlAtbOKLfzk03ZPAMQM/a5PYbsP+2QoZXrSEk6uEBbHyhkIzhRxELpwH9f1mK6vZpAA5Bke+fOJ8/lWxSqTtWpMbuFZ6xl1LygjS5JOn6JwQp1RDCEF/TRwVuy+I20zzSYZBzlM+hXCtKSaT3nJ/aSHY1lcrKtwu5z6iM4rQTTznA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rjm81ggHcLjB4IbowMWilF5r4xzmVBgyMe7tqfquNKw=;
 b=c4aJOZiPYryqgvUzknjdk/jZ8vczsmplkCmrD3TUHFo8tQTryLqUF/lWhH+L8eKdPljYreEwdg3syfrSIjKa7C2AYKbcze3aGayWt9FLcF3THVsk3AZL3GaKEW8sJsgu3i10e+VjEjYsM+21N6QdNCusM4jSGPAmNLmDiTtkOm6Q+4w7eSX4kJbKMZ7xQzF/QCn3TuGpHfm8/7U6A/Nda+wmmawUClxXMoc+KsQ4Mwgqq8+KhrDi6jtV+6zROYjsYeMSUMyMiWg5SOkMej96bunEV5W0beQMnh82nwVWR6qS+2oY3mcx5ijVHguL33hP0Ly1k5GaAxJBAEZDbmDMxA==
Received: from BY5PR02MB6753.namprd02.prod.outlook.com (2603:10b6:a03:209::17)
 by IA0PR02MB9146.namprd02.prod.outlook.com (2603:10b6:208:43e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 08:52:52 +0000
Received: from BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57]) by BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57%7]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 08:52:52 +0000
Date: Tue, 26 May 2026 09:52:48 +0100
From: John Levon <john.levon@nutanix.com>
To: zhaoguohan@kylinos.cn
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] vfio-user: reject zero DMA page size capability
Message-ID: <ahVfYLhoKpWS2FDE@lent>
References: <20260522081306.4186242-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522081306.4186242-1-zhaoguohan@kylinos.cn>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P302CA0005.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::13) To BY5PR02MB6753.namprd02.prod.outlook.com
 (2603:10b6:a03:209::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6753:EE_|IA0PR02MB9146:EE_
X-MS-Office365-Filtering-Correlation-Id: da0e2c58-6dba-4708-adfb-08debb042bdc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: o+zY7doeO1iqZBalhkNP8fR1ZkbuZRK3TG5a7vPXQZgKjxOwCvMj3RyFHrS65/OT5PzSFvOGVQuvPW8INzCsS8eA15J0eyssNnh+eBDVjOkobBFxRWkyqDo2p0Glo2fT3jatIFADfA4bkrVM4x0WcChwrY2/G48w7DzCuqXD63kU3gvvVq+rugRagYfK0T2d+biLUKv++D4HhUjFzhLBsGjP2BakWG+wx87KMyou+TvjIoYxI/qDCfIWP9tyOoTmlnUGzZCyPPgwFH08WuibWWYav01YVh/FwNe1u3wWHu3Pvjnxvrn0f+dxelTt3Dan+F8+kQfImYa+kLLtXtvHbx6pkbdOSK1oUOaa9V9ZPEM2lefQc7k5spEpkYFsMKhSR01byktkBPq2Qs6JP/Gkw5BOK94fSzbMT/GGhhZGvV7KPpLSknPjaV+k+BEHByEWWDESkzKqquoePMAjGBSjPHXvyUGvXX579sSrlPh4zL8pNmZ2Tr8B/NlaVUbRk1Y1YE0gfRUgY/m3NW1I3PZ9VW1Az7GfqSSvktofKiEY2cDzhMk1INOtAOyBW+cqs1KtX/Q2TuNuaPMPvVDRXhMnDOKOU5iEIlCn1nZFLtLQf7VhP+0OY/fr43jb6fbxr3qOWQn3yUgCcquG584oHKLLP4PKnOAHKuQ18HTrvEnBQROD2KcwbmOqkvT78wMS1V9i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6753.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P7RRiUSRuy1U5GW6AjHPmKzSlywXHuvTWWPOJQ9DTzk69Tblqkc59DsC75aF?=
 =?us-ascii?Q?WfRFY/iY30GzkpGgAMWAfxVZuWP6wErja8Q7H+9/LEnuAxOqRPqnyvIIVLHV?=
 =?us-ascii?Q?9RMvwVaQH1uYcseVOCzYjzUWyVp9CwgJYf2iVxazp5/XKf18oi9CBVPjEz7I?=
 =?us-ascii?Q?ZTCsykVsgM2GOBLuG2c3DMO+KNfYX4yWeoOvJtkEDkIDfvXfoaFu6Z3jjwyr?=
 =?us-ascii?Q?lHfX07IKWtVJfODOUWg8Hq9IYHYF6M5LKY3TRaKfffmvvsTssLI20pXsE7pm?=
 =?us-ascii?Q?tqsFxm3sb6RhXbpCwkS/JdxVcjE80nLWNfjPycOiMrCa3xN6sbCRzBM8agAN?=
 =?us-ascii?Q?UlYJXfq70ZW0/gwx+PtvDltcddCrjo0Yow280GA/NU+GuedlVATcBn9xRTZ9?=
 =?us-ascii?Q?0mYTYdNHLm5IBFAUlClPiUOuw2TFONjoNheAoX/C98Ivn6O2jyS8XtrZEpF5?=
 =?us-ascii?Q?KUXLNaCdEJTb0oyVzV+zOWTr32XMRGax8SgpG/HmT55hggm08bgpRA6+nYR0?=
 =?us-ascii?Q?UeeryOWzgFIZJFysFOCtq4jdqylEtYLW4E4tHeCndZS5OK+vitGczsRF5o/+?=
 =?us-ascii?Q?s6fqBt6FLa405GRuiD1Gefzbyw5ZO8Bfxlkl0+nJ+pgOdnOlUGYt6nZuaWhj?=
 =?us-ascii?Q?BEsZx9JNC1SYjXukbeDVFjIH27HkwoWLt3zkq1FCU+UZfE/Y7JZCViud72UA?=
 =?us-ascii?Q?G5RjYnEJqwvYP9Wwp4w8VqmTYxI3tJOXQyIMBew8xIqXIRqp9MRDoSRxmIDZ?=
 =?us-ascii?Q?GfaGLRshKV8yaskZvjoBLySxgven0JNtjauBDkhgXPtP3mg9AIYNX9APAbnx?=
 =?us-ascii?Q?n9iXdFOE35TNRmJDVkX2ffGAa0tiz/BteYtxFigwMkGlO/iUYba0ZqhI0uiA?=
 =?us-ascii?Q?iLKjzB5WmsxuweHgedoipIBtULcVSr7vbX0SkAmj9480Hqmi381C7MMPGNd9?=
 =?us-ascii?Q?8VUnSI5S5UY8G/NrnVYtB+S4kXA1mLwgh+AWVLj3hHMIpmQO/E/qY/FtOD+C?=
 =?us-ascii?Q?vO3d0XfNXaBWwvrC44cGrZJ5ITKurZSJLQfCX9Bs+/E4aiJe+fR/3Q0uRvZE?=
 =?us-ascii?Q?2c1eUa7Pq9Yo+rAyYXO3LBRSKMj6k3S6Tx9oYRcysfDT4qXjFdCHIcU+iGrN?=
 =?us-ascii?Q?b20dQp6lYptQ+NEYIBFXBTQe2VOOCYr3DWuN/BrEXr0bBUdmhwqsiQGLghNR?=
 =?us-ascii?Q?bV2aI8SunnozAyGIeFyIShJfO7LR9km3DxRznyUt3AG3gRlSkDRhLI+n20KQ?=
 =?us-ascii?Q?hFHpde2ID3om1o0awHu+EhmTSbC4f/+pq6pq4L3FG5QPavHhxd1n01PdJPhO?=
 =?us-ascii?Q?PEK20Q6Ixoer0GnQlKez8+9RA28wlFpGYNzLrldqjqunOCpd9F3k/XnT4O+P?=
 =?us-ascii?Q?HDO0URgRXr8qpVyOrwfuv0JDxkI/dPtL7eVxARX90GDcZqeCaf8zQ89RzrFy?=
 =?us-ascii?Q?NcEA3ReSMm4ChbFz9O7x4TDcT57x7APdjtEOfnNeOkdvXTL5HSV6TdjZBLo5?=
 =?us-ascii?Q?FFjldu7hEa/iV9p3MEFTBUeBUq9LPnuMeEHU0h0i4ns//MT7NDssQ2FENN1C?=
 =?us-ascii?Q?DyqC5F/lqpqmrZFg/4b+z+ZFBt+yKVc8mbyWJOqIwbhqaQfR7Buc0eFMt20K?=
 =?us-ascii?Q?z5PNttMqWUxVBPSIS/CTr4cG3ytZlmk9qda70MirjZJxGlpySrhAhIdFczty?=
 =?us-ascii?Q?r0sMP0cZtE4LSuFpXhizN/1F+/5FgmVUlBhGaObr7b7/NmvUaofR6J2odNYx?=
 =?us-ascii?Q?khgxXHw5Qw=3D=3D?=
X-Exchange-RoutingPolicyChecked: UU80wLIZNNGBIItXV+EZu4CnZkuhaAUhHnWeNsWV9h2S42lHDABtYLGBMGGwQg/h3UcyZuNsDv7Xlk86+Hu6HIG3Q6TShni6nxguJbXMSd3hWdr/t656gYyDPUi4F0bO/kkNeY9aIC925OjZxzsQLdTqqf0OEkm+BlBgTXzq3VaQvdmiy0yLRVgUjJSGJ0WOnXK4NHWFQJR2oq1f4aOmfVQE9Kl2bh6dI13AThFlHSLVMQwf8xWaenn8wO7b9bNYh5Ej48+J/65+FD2LGXMijEPbQyjuG5uEziPmTSqW5wbsqeLBb31f/pDHhoAWUmdqrBQ40g6iKC0G90YMA1a06w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0e2c58-6dba-4708-adfb-08debb042bdc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6753.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 08:52:52.4504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxYgBMoGURCJUA5riOoFrP3lk4VXIo6ir0z3Je8wF9kn4bgQvpjjvEnKV/DIMEQHa+qshfcvIY5YJBvYSBcFwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9146
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA3NyBTYWx0ZWRfX0UaFN6mD36oO
 ihD5gr/hDViv0xpVikTGG1rFJUUHFEHevzi5rGCf8/S74GHAUKOOnlf++lqJXMi9j1ilWWmJfgX
 798JGYFRX4sxtCla8lsk7EK0M8ZD8tWR09w0TB835xI1H/koLJqWURO1Ul7pvmrHifDwekfqjV/
 yV/eW4pj6oBM8jzRw8squJajeml2ZjMB2AGVdaxPB9SHePPkN4u7qPjFrIPkxrAfv2vUJiiHZLc
 1+88igDO65Q+x6IDpq3E9HZX9PI1eBmdjzvdnXjWh+/ehDRxI0O7zM1nNENhEv4nmWis9gC3SXl
 YLpYAiOsJC+FFnRe4zrSHbtHc2FrI3bJC0IGV8qSeX7jHJMUhDeqV2WuBDrJ7IQoko0ycRILIBb
 fSOquIsSh3cLur9vNavHSABa5g2uhoc43K3mLM26gz5lDD04r0ejtbqEQbnCgOYrjHdpLzgQZiZ
 X6Hp0xZ+Nyw3ldKeifg==
X-Proofpoint-GUID: Ku_aeUh0lGDHe2JJV7CNOxfmsqfVvN8a
X-Proofpoint-ORIG-GUID: Ku_aeUh0lGDHe2JJV7CNOxfmsqfVvN8a
X-Authority-Analysis: v=2.4 cv=dOaWXuZb c=1 sm=1 tr=0 ts=6a155f66 cx=c_pps
 a=YSKqEZ2efjUEYtK1eN1cHw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=wg6bKM8NU6wJnTWyHgoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

On Fri, May 22, 2026 at 04:13:05PM +0800, zhaoguohan@kylinos.cn wrote:

> check_pgsizes() validates that no page-size bits smaller than
> VFIO_USER_DEF_PGSIZE are set, but it still accepts pgsizes=0. This lets a
> malformed server overwrite the default page-size mask with zero.
> 
> Later vfio_user_setup() asserts that proxy->dma_pgsizes is non-zero, so device
> realization aborts instead of reporting a version capability error. Reject a
> zero DMA page-size mask during version capability parsing.
> 
> Fixes: 36227628d824 (vfio-user: implement message send infrastructure)
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
>  hw/vfio-user/proxy.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index 8b7cc36231ab..7c3036ec83c5 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -1155,9 +1155,11 @@ static bool check_pgsizes(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
>          return false;
>      }
>  
> -    /* must be larger than default */
> -    if (pgsizes & (VFIO_USER_DEF_PGSIZE - 1)) {
> -        error_setg(errp, "pgsize 0x%"PRIx64" too small", pgsizes);
> +    /* must not be zero or smaller than default */
> +    if (pgsizes < VFIO_USER_DEF_PGSIZE ||
> +        (pgsizes & (VFIO_USER_DEF_PGSIZE - 1))) {
> +        error_setg(errp, "%s 0x%"PRIx64" too small",
> +                   VFIO_USER_CAP_PGSIZES, pgsizes);
>          return false;
>      }
>  

Reviewed-by: John Levon <john.levon@nutanix.com>

