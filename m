Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB30BC4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 21:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkToL-0001mh-Mb; Thu, 16 Jul 2026 17:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1wkToJ-0001ix-9H; Thu, 16 Jul 2026 17:40:03 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1wkToD-0005s1-QW; Thu, 16 Jul 2026 17:40:02 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJrZhk1763910; Thu, 16 Jul 2026 14:39:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=WUaL4fQjodm13B7bXBr9+5hJ+WRfVgk2LSsQ3TYc4
 fk=; b=W31InYLneNvbMnhUr0UfrENtEdUI2VZWB6/QFe3Alv1FJwGpCJp36ENs+
 k8ukfsZRzuQwdnWVxEYCUc6ifpsuzLVBJWWLm3tdQsUAjpehh2weA1zB1nsD1LRP
 0RdzUnOzBmwfyj8DmipZ9b0JMb9GUMtDXVpc98Z7GGynEcZlegTx2NbXpZJnpZ4/
 bnpdyYy6G8s0PzofxTkC2iPRXjqJ5xS7eNrwGwplepkJ494qHPGQ4+qr9Hp8xNKK
 7/3N9NiQr7UR0t/4cm9rtYPqQ283FcBgjtOiesJ6jv8Q8BsHjzr1Rwy/fB9yt7Xt
 l9u61fuIqib9w7OItRvc5GEp5lyIw==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020094.outbound.protection.outlook.com [52.101.46.94])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fdstheva0-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 14:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5glpijjaWrE7dipTaqs3y9/S3+BlTCWyKCkpORPZQQJMHh3SGbH1+FX97aN0NxF09qDzs277w4t9BT+xaPPMim2ddFvdEgP4DJmZIhEMI2PxWUwB9024eVsWjYopQI6t5RwHPYYge3MiqwJgrcvi3xrWX3OCix4m7ZgNOOVTOJ8P0M1zk9ZRiYawyb7/PK3LBHOuNXwHbHCF0PIgXv/PxMkM3IRvIDqjp0iVufq/sNnDOtbDRID0uWQ6CHXHQQNl4QWdr8zOfHEQGSvgRibqthMPaUEvRFyDPznXVIJPFDVve9OayxAGKLk/UB8njH7ffzU+kmvQpnLHw0Ireu09g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUaL4fQjodm13B7bXBr9+5hJ+WRfVgk2LSsQ3TYc4fk=;
 b=tk8tqTUTxxua1ojC8icBOEGcM2zTeUOLowlVavjWbLNycAb6X7sdrO3TM90VDJBtRx7B/NIdsuiSKFGTdS0Jv2WxT5kmyKhbkfykMkci8dun1K28EpnC32b4lkOSv60xuiRWAZqk4evqibeQfb0xiJ8bDPVKvDqeGxQ+cRfb3z4uo4ucE8Iz87DIHIYRk0vMOvjiHDEXIa/drGy65+4T8fgYhzS2ndYi4K+W63jNl5tOzwm8JKlW31P/XoTJE162kMOXVHjg1J0S2g+p5WiBJXCbyOCO4X/ujtHW1rP/eoaHfYny9wk7rsaLQ0LyFN+ayU+LSSCd4cGiM4/1VzvSUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUaL4fQjodm13B7bXBr9+5hJ+WRfVgk2LSsQ3TYc4fk=;
 b=MWwE5vS7vaUeT8k3G+fVK7Q3AasL8mIFVNS+4mq9KCJW0BK7HDvkKrsDHIY6y0MikAZnznbe/8IlCbch/ZFsOMig8LzxXBIedRh6hT2eOEWXdfSFGhjTLOUDI9u2rD0Z5PDEgM7AW3l4hISfASR1PKpHlXfDAoh3PpquMEVKlEZ6KPmDFQyXnEvi1S+mjpoPGbL5cLQKcwx7BFaDNqvL+mGLa2GKSd7IG983oLMzwTAmr7XvVvGmE3mGSjkRC0+RG5edKcaiZuF48+LELNxApZgQ9L2Tnrkq0iGOXwLMmzqU/tMrzUJ3cKSrUyECIcv70DRJvHDMLXuZEKiirBPgJQ==
Received: from SA2PR02MB7564.namprd02.prod.outlook.com (2603:10b6:806:146::23)
 by SA2PR02MB7756.namprd02.prod.outlook.com (2603:10b6:806:14f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 21:39:27 +0000
Received: from SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4]) by SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4%5]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 21:39:27 +0000
From: Khushit Shah <khushit.shah@nutanix.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 eric.auger@redhat.com
Cc: cohuck@redhat.com, peter.maydell@linaro.org, richard.henderson@linaro.org, 
 maz@kernel.org, oliver.upton@linux.dev, berrange@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, gshan@redhat.com,
 skolothumtho@nvidia.com, sebott@redhat.com, armbru@redhat.com,
 philmd@linaro.org, yangjinqian1@huawei.com, shaju.abraham@nutanix.com,
 mark.caveayland@nutanix.com, khushit.shah@nutanix.com,
 prerna.saxena@nutanix.com
Subject: [RFC PATCH v3 01/19] target/arm/sysreg: regenerate cpu-sysregs.h.inc
Date: Thu, 16 Jul 2026 21:38:40 +0000
Message-ID: <20260716213858.609699-2-khushit.shah@nutanix.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260716213858.609699-1-khushit.shah@nutanix.com>
References: <20260716213858.609699-1-khushit.shah@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0071.namprd17.prod.outlook.com
 (2603:10b6:510:325::28) To SA2PR02MB7564.namprd02.prod.outlook.com
 (2603:10b6:806:146::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR02MB7564:EE_|SA2PR02MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: ea55fedc-391b-4a49-6ef4-08dee382b629
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: QlfYDDlxBNn2yot15h+rqdvq1YyZbW376Yn8Cg/mWWcNwCsOlFMDSzTDMI++z2TVKs8gxzyQ2gMoArwFz0izWnSevHmOGHmmyEzB5V8GS7NaXa3EVwlad6rJI7s14ZXIou07fKTEmfHkFWS4DfnNQ1I04PbsVdjA7/acZUzXx7tD3gNTZnQajLwCUdzJqE7ZZRaSCYLlLh8Xkmti4VzAqy5sTdSAwh2S9qV342Nqk1QA/59Xnp1QDc2iwm03xEkm5gz8PpWVcvpGF45v8psCmRlBXnuYMng9IRB9TyQm5s14dgRdrTteqCeV3cGu8Wf7Xm+mG9GrsiY6s9Rz14inwBqZ6U+38kmD9PKIBDdPVo20XrTXPmdXD3UskGbes1rqzwPfngXD82CMnrelHPjRvySaouahUOAnkgERPGy6Vz68FI69Rq7wMnCH+a4/J03UAPtb5UBGK+oX0a2vJMOl9Dlu38dnd0PVsVN+YByfjxjOtWVyFQB9FoPvTN9ALz3znlP31F9USQcbQCIA28nj7D6PhAwhuGl5k8npiz4bA3Anu8wpPTD2M5Gm66Wg7ir3r3GI24siGvbFcS7loocSUL3NnTkVZ8xW0Ky0xdCjGurFfsAKFMCU8DDuALvS1DqAy7lhyShVFY0nd+HcMnI5nGrnBFmO85U3HwLsA2SwAJY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR02MB7564.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0de5V2bwvvP06u3QToGTg3M5zLk1B5EmbhXcr01kFjTV1DCHrtWrCloJvU8/?=
 =?us-ascii?Q?ZfB0aoMLohF4pw3gdgKO4su5bwyzfWDWsVgPUpwhl0VlTaI/KgfWSI4xjP6h?=
 =?us-ascii?Q?II2/6Z0RvS1aULnxXkOb/OqBBLUn+zRZahz/jiq8osnQuhH+tbLeZdeR/z/d?=
 =?us-ascii?Q?ukEdSdcDY0DaXb8drS9zC/PDVh8EJVOSKunWgdxj2YZHKbXdLZvJSEGLk7tO?=
 =?us-ascii?Q?0Cc0Nw0K59qDIGkQz3potyt05bMg3goxtAA275wFVb8FgiY0YOL+9ZjlIy0z?=
 =?us-ascii?Q?/NjLRnoSOhHI7jdsHm4hQoXKuIX2gsvQfxGgXwfY/9XHkgmjY/GeLA+l28qj?=
 =?us-ascii?Q?KHDEtsJ+g72Pmu1XYV4Y+qwYBKp1dmji2l+TwBhqnJQZwi2b0DsZ+Vx1r2xz?=
 =?us-ascii?Q?E7UVfR+RNUz77lP4fYRnn60oaN0SH0wR7oag4cMnFIsXkyohRjwNif9ZCDx8?=
 =?us-ascii?Q?xf42kXfh5JfsGhg19+qoIe/Pg2rxRFXkP6lQPrGBZjcgeP1quKwEiuOMDKzn?=
 =?us-ascii?Q?1WGnMlvMbmhCz690xSWgbPRPzd4dpL1ZZai43wiRyUwsIklDE6vUSkjNtUuu?=
 =?us-ascii?Q?TVj7lU4y2yLo5haPUpY5XD8cbXyUV1k2VA+sui4SqXi49ivbvNCh+wBQVv4W?=
 =?us-ascii?Q?RnObRWSIMvRgZ4cX9Yo5iOtytp/uiV1DDZhd2aGLv66+JMok2ks1QIVsvm3P?=
 =?us-ascii?Q?khj1QC4WOYHlbxue9rw7fpy1by4+jI0pqFmReyMu/qraUGrhlEVAh7EqphNK?=
 =?us-ascii?Q?d0TFD64U0MMx11Z4/IJeh7Puo6kIbT383tzbbTTZ/+OuRF3UWXjc5fcfN/M/?=
 =?us-ascii?Q?q9CnuWDZN+k0y8/yCZicFcIvG9AgI+gbLscMOC70LYnepy8vHie0cKlFKZdG?=
 =?us-ascii?Q?XtjiMNzTdKRh7liRa0Ukk/0LW5JhY+EUyx7DCvfupi20zYvWI+wHDbmth7Pg?=
 =?us-ascii?Q?ygmO0At7klf+bacTH0tbwtbOLFFQZxja0HIxbfw7fa8rm3UYbSDF+rCuRc/i?=
 =?us-ascii?Q?OZIAS+0V1ac0yyrU3OeF7gLRbEFOsXE/2U975aRrsTPuL21mozwrk8EG7Hic?=
 =?us-ascii?Q?iZLW0lu3oq+rX5HoPuRx2/8qigRBvHPrO/kwUPYnqUudfIcQ+QKHymNK6Q1j?=
 =?us-ascii?Q?YBEsj7dbwqhRbJPs/FUeU0rTL9JpwWiJUUjRENfXpglfvZt57ls/aStS097Z?=
 =?us-ascii?Q?ehOtLWaCCSs9daOkvMswUjn4LP25GnozcL5IqbSbD5v6L7QTWvLPLOYgCMXQ?=
 =?us-ascii?Q?GRm+XXH85QLjBKFjawOza5p9Bsmrgz5b4nysw0DPVVHbsRESn1pm2kOzf00T?=
 =?us-ascii?Q?iKH3EEINy6ehwpeVLcNvthE1puPsKrQkicjdJ5S6bj48W0z9/dZK7Y/hQSLa?=
 =?us-ascii?Q?6Qu1jdU3yYdLvClIgh32ZG/pmJQpZVktRSWtIkZaPgr2Y8+5ugyD6s2OPKgW?=
 =?us-ascii?Q?Hh0L/swX6b2hg3q7zHsNL81iggXOjlTm+6Rnyb2OnGYc+Lf7euAIf46Wm0X2?=
 =?us-ascii?Q?0GOggQzgheOFW+uRGN2B9VcrHhSvjJEkLwd1gVlmny3Yx9kNdMSzy6EtyT0+?=
 =?us-ascii?Q?1yA/Znfb1oqjLOT+2tfL/bUNA+sG+yFCq1MWw/AAKLXXx+wgdVLt1Y62c4yj?=
 =?us-ascii?Q?NtTWfqxygioft2OpDGisDHAJ+Q+qPZpStZbXTbeB9DB+vM/mJRKQ2PXNJ9Ac?=
 =?us-ascii?Q?xw3wgR+ll5XZpFpr4t41sEU3u03Gf4NZq8zJtQ32DvnZ6lmQv1fx3TQcBLEv?=
 =?us-ascii?Q?IP/kaF2wrdPe8rQTed/hTWZgeU4bINM=3D?=
X-Exchange-RoutingPolicyChecked: bmwIsd62FMdq2keSgjdA98ldaiAkrAXgqkitGXrxUlXv5Hyr8/+4ghlAoNWHP/BKJ08jKPB6afTnrTvk2OX8Cz7cCl8c/wCrWL485zU1zBrNzi7fqrQqVSLHDsWph4W/BIewZxhkZQQCSb+eBgFENbSH8to9FfohxOGf5cwcg9h34y6iEmQhYjsvgv+EG9oE07wsfMf4+cAaYldKpVWRym8PBhAU+n2bKbLHZoQjZay2Y9B37B76USel8iZvONdtp18ovY5eMCm256QJYgIUBOf0vFUux5h4UpCakPb7NeYIhBh8K/1z2dNa7eUjR/56Dov+drAGRLnDTDIpDfICzw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea55fedc-391b-4a49-6ef4-08dee382b629
X-MS-Exchange-CrossTenant-AuthSource: SA2PR02MB7564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 21:39:27.6315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: haqnln94GPlYdRXS1HHEM+W8PfCKtZxurF6CL3lqc/1vk0KD5qnfingCVEoXz7GCIcWQUPI6/Qf1nodtYNGCKefjy95Eo2Ek8uwn6qV8IU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7756
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIyMCBTYWx0ZWRfX5MTUdkW5ZGqR
 mvM9ns76XXbhkb/nDQtIrRr3S3RgHjznwbyIb3nrLHHLLYe+hUozVVKPj/5YW/nqX1E9NafWDxA
 6BdZx+rbqHSBz0NlROPtJGiPaopvtUnmN5vs8ZQEZoQNMtl2wBRertAJH4h+pD8OENsTlCS3ys8
 1mt8wwFzWxBZjxfHwn4s+U9O0SKawtgitGtdYx/XD85OOAOckyRbaAy4xPIw0eU9XJJPsyBVwqr
 Uuk6X+Sor528ksEF5TE2TG8d7Czq/ZyIKfvFgPeEdamEqyCTQx7CSy6ERpV1Z24TgixEgww0Epz
 +Ld7aOtYdIVg+z4FYqd3IigCKoKgE4HChkVRHDF9IElyoShWCsA+oqaq7lKZOMZ+p43b4sXS65+
 aeZX3HtcKMv33F8e9evPCsSA1er6OL89xxUsfc3p8pVJB928xdmvao/TNtub5fr0m4q+O+hV/kM
 NCNME2vN9jcd1ZT9+KQ==
X-Proofpoint-GUID: Uhe_ukFgIxE2s2_6ZkoZi4oTp1oMfGhI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIyMCBTYWx0ZWRfX+9m1Dxhml+jx
 SyfcHFQQU5D8116uBO+kN777GPDfdKyoztaenHCO+hhoIywD28C+75DfwVxPp72za8CRHL0N05O
 jubd5ez2Lo4G3F/yzvVm4PwY95Cu2yU=
X-Proofpoint-ORIG-GUID: Uhe_ukFgIxE2s2_6ZkoZi4oTp1oMfGhI
X-Authority-Analysis: v=2.4 cv=J8uaKgnS c=1 sm=1 tr=0 ts=6a594f93 cx=c_pps
 a=aWGlcXfvBePkFyJsMZzBEg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=vBEc4jnpDwqIhEWvTNgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=khushit.shah@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
---
 target/arm/cpu-sysregs.h.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 05f558610b..2188cd7be0 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -19,6 +19,7 @@ DEF(ID_AA64FPFR0_EL1, 3, 0, 0, 4, 7)
 DEF(ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
 DEF(ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
 DEF(ID_AA64ISAR2_EL1, 3, 0, 0, 6, 2)
+DEF(ID_AA64ISAR3_EL1, 3, 0, 0, 6, 3)
 DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
 DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
 DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
-- 
2.52.0


