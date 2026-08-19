Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61893C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgVW-0000pu-HR; Wed, 19 Aug 2026 09:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVH-0000pG-8V; Wed, 19 Aug 2026 09:38:51 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVF-0000ic-0t; Wed, 19 Aug 2026 09:38:50 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JCmMSA394589; Wed, 19 Aug 2026 06:38:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Mz43lXKLm7l583VbWUW8TguG+bNvz52xdvSuGZVne
 iY=; b=13QDt2I0qRxt3sOxRHP9DEa/2O6D/G2tWZH4ofHMTqMUmczN1yJmIpa36
 kaUIJkM0qpt9w1S2NBNpOr/E05jq8jcLTBXGPZqQXh9vrLtPMAJ+BYxrEgiehSih
 V+tV3KDhUM8hKdDliQMIhRvPhQwKuN/GnBw9o75rNeXQ9U8QCP8bzDJVFVFJ4BcX
 Udfj1fSNPuJUJOa0K5tY7teCsoXWMEmV9oruD2GuikRki6M4Rz6Zxy5F6sB1FKb5
 F1KBucRtFtKsm1pXq7r2YIJ4T/aJSeZ+RhIviRsDP23jjM+pqLtZ1s/cPRO7uy9N
 jrjqFTd6/JK+emE6OdmKWsM7BLzeA==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020103.outbound.protection.outlook.com [52.101.201.103])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g4xnxa6hx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 06:38:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2FGnYJB6rDbluZYm/0LXat78i+wiRU/+etVyrRv8AyvcJ2siWqV5ov+G9ZfDyrjv1g6znzFa9oVUR++Q8qx0Xs09xX5QAeODfGPKkAWmKFmDmLQJjkokC5eb+MDX2WwrRGyIa6lQQdaIy4FpSYqRVQBCwlpU9KHeZQihZxh1DFNVR23ITDbnzY6ZxS5yrt/QFNmdhr10ZChzEnhdEOrg5iBsXB/d04EkOlPW5Me/oZ3ErnA+SwXlnfj/p4keOJAx8TJV+z/qa/Gl8qHtAMNBgtM5BE3AdD3P82ce3RI/nFXNYJvNXY1HfrV4FAOe+gNwEbiObgqgxrElLIpadI6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mz43lXKLm7l583VbWUW8TguG+bNvz52xdvSuGZVneiY=;
 b=aRRNJFLeHd7q+Ub2TdOlj1he4WCRfjC98wy7vVvVn5ahlpJFiAGMJTgVP3BxAQ5zjOpmTT2N7Fzr7I9a8HdmQ9fx30aIzgomaiaPjVLSs158ZKsAefYaSgBa0qrqQRhs2uc8YOTmrRwiYA4PDjlpiTQ50O71QgRxh04d/P5BPqMEkBA2RkcTxM1AbfUuLpiwSnCLCYkHmQ94w36n14KDkQc/pdI232JjV9uRrs+W3aBakvBfWLxwAxISrD6PPL1GW+Ygs7KSVgXo9A2a5yE6hyCIDLrhdFG69wO5ewFy8IM7Lg7TwafyhiDo3K+xoTh7+Ci2Cn0fllXS5eXZY146zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mz43lXKLm7l583VbWUW8TguG+bNvz52xdvSuGZVneiY=;
 b=WDGU52RCFUEgS9Ha/Lru9oIpFobedVmHsWOrgG586EJ0S19+umz0RLqrFUNmNr+cg3pR4l/AifL2JIMOAS8LlyezmDZTwRs+J/g68WiBwLHCM2rS+5wk7ojShm0x0C3XitvDIrJKuVpMnv3avbM+ifkQsjMmDN2EAG/OvhNnK1gZCCLhB+/76jocJE/5FWe/6LfvSh4Jhsp+LYeYHGHfd33khFeVUUf2pAhbtyyJjWKlzxzZUprzkJKPbhd8ngwc8PXt9FoL1x/pVJwqrwsW9VHe81wx/Z8fnQG/R8J3gtQsS8oWyw2q3KKXKUTfeBkN6Yf3lIgW2cxxTtVdnrZzng==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 13:38:35 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 13:38:35 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v3 04/15] qom/object.c: add
 object_class_property_add_uint8_ptr()
Date: Wed, 19 Aug 2026 14:35:43 +0100
Message-ID: <20260819133816.3497033-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::27) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a627bf-ac5e-4333-3e3e-08defdf72ab7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|23010399003|921020|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: e+iGLoqig1Dei++w4cPQ3bTJtpAwEjgvLHcXTHiu7sfFZxPZqu+efhBJPidliGB3TVFvuVwg8doF2fLpFGj1sq3VSq9NrQmXX7L75thJLQTxMUmnsArV+G/EB+kPPz+tD8S+gHUXbNttLSKOxbKrMN3zjGTcyuanAFW4oI1I3kI0kYCq1NI5D0dDWY3u+bsXEh8nZujUzwaOfTZKrsAzpXJS7QIqOJwd1Ld7rEc+2HjLWd6BQFiv5OM2ax+1op7Uldeg2MOTtoLHOI5YAVqK/exFsxbgrpe6Yi5Y3aPIEPtfOkSRAGAvIP+1VttX9iP74aZIlu1hPvQNgt9H6GSfmqLLAVAMMiLh2Gjl8097bjo/dtIYF/ilP3ADjJTzUNxk0roo1M1oc2syB8Rf7VefB+dn8BzeWXZrhCzTPNDeZQz3z8Gi+kbp9MB7NH7JNUwkyPpSCKjtqVJCnseQIfJTkkyDH5kS4qosDUZkWz8DQDyEOSnqcfr5kzzfobfMJc4glI0E8BLgyJn2+dOAurE4XIay/BvLy3eK5DibC0E6uaIqlJt7KKDFbXL5lMzmEIpS6bHerKiQNAZhFQd6HrlR5nmzEtF2s+cKl86Ceb0aYxm5iW5qM66o5vG4T8/HgmYSqjzTk+r90QO+b/Qb2aZ2N+eyDrboYJ3jJfUYjPsCxcE7pFQvvt/UaZL0XzcX13Cbsc5p2JBMZPt3TURHvQHJuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(921020)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e3BbB4+2DphLztnwzFAtKmf1Y4aIrgN3IKwNEqLGyv3iDw9pgOMyIXvkf+He?=
 =?us-ascii?Q?TTKoPZ3Da0CjxGLN/PLFxn9CkaTkWk8Ceel2lctNrYRxYkOqtGjFR/W19NSj?=
 =?us-ascii?Q?mU2ua1Km7UDMZSFkepgzhqpcr3n0A6ETQPQsmsdZkyAqxg4kpMAEA0N7QShi?=
 =?us-ascii?Q?tRwdOCXyNkbO+6ikhn+PdIYwuk+EpZuFy2GjJt66M7tVXSdXX6toVcfmYKdG?=
 =?us-ascii?Q?cMCvAQlUxNiiuOrKc8PzADvwYmLrYOdP9gV0SSn1TR8UdzCKAfmWKMAZB49N?=
 =?us-ascii?Q?iSQGNjXcMKDAv4sft9M4atPoCIpCTlxtdLVTTvNUuC7LoDyZ+eojY7ErOUT6?=
 =?us-ascii?Q?YToP0c1UGuzfJjLjImYmjHO1YNq5rgvKRsi5AcDj1BCz4NfCOi+w8VvW2QOb?=
 =?us-ascii?Q?6Hl4b/U2CpZZiGUwaMKZucPrAOjU6A/xurzCGlXsFlTnJ57/czSUW/wJh7Uw?=
 =?us-ascii?Q?yY8kEUI7htPUEdu6569wTJb7fHbuNFkicva/WpG48ZqiiaXJQ1Rw6mSWeUeC?=
 =?us-ascii?Q?/mlzZR+qPEF0haaZ4BcVM4MdkTflcsKKYKZyy1Ukq2qXnGkGMEohhJzxR2tI?=
 =?us-ascii?Q?mKfnGIPQGzdDZW+y1I/aw9ns6H05PycBOR5vP/04GdL7rh1WKlAG4WZd7b8x?=
 =?us-ascii?Q?0IT6jCUzqQz/bZ+kOKzqbFRo2ztjvpmj7/C+8q6pydczP8iuakRket4KxhiG?=
 =?us-ascii?Q?3PfpGd0gWpS8Eb/G79O2aWCgmVEPemze0vLYBFww5INwZqBGO+Sut6qVedXo?=
 =?us-ascii?Q?OuQV0IX7UzFs+u3iiaR26oceubzSolUk9O1yYqONZxOqqt6x1QvIQiQE53Nx?=
 =?us-ascii?Q?VSD8cAfDQ/UIMLyJAvOXtrZcgh4NiGyH8uENmEotKpTzlYE4LKbanclWLe7e?=
 =?us-ascii?Q?BODnS8Fe1ZH9qo7Lo9ewNIudV13h9ojN/chwY+QgTxnPniMObkc8baiJl/bg?=
 =?us-ascii?Q?CzssIrTKC0BWZRnahTROYhL2mnxUpcnkQJRt2XZnlh8pLVghHNh0Za9S0g4/?=
 =?us-ascii?Q?M4Tdc3OGkRC8GZzZfRGFP5FoN4CuhSWWx/AMZHCD198784lE8E/boP/8pyH7?=
 =?us-ascii?Q?+nh2PopHH8fpBfMvSqoKgS0RbIBeM0X+BBLhVzAhmzzQ9GTK+DnYb25oOLl6?=
 =?us-ascii?Q?jXM1II10fXCchYjB9Stm7ldaqJyfTkfypDCIzb78x3aS9RsHSz/fYNITCz4z?=
 =?us-ascii?Q?ubSl367PQN5cyhFoiTdiAxeZOnz8TvFxjBXFy/Li+smLOm7k54yVenl4fuqY?=
 =?us-ascii?Q?jFR+7Wacc7FotUy95zETozsAsEPVDE+R+1o/hze9MGH88N++wGtK8EW2vtJb?=
 =?us-ascii?Q?n53nAJUE82sveaTp0iWntom5HlLQa8P5k9Yw/UM9PjkcOUAvHFSZDWkaLGuu?=
 =?us-ascii?Q?KeShE8eXyIpHBAgBcpWGnrW0363mU65Dod3qUtLyuaXYgweixDVQZAwWL/Kc?=
 =?us-ascii?Q?8qQzGUuWf5lrOIKMwX41lA8AHkHEHAJ2nOIT7wdUlLe31DujwiQ1CDQuJu/T?=
 =?us-ascii?Q?v9fkELIOsrQwdNuGsmu1zPzRqhJsp3UR9ZHbnXTn0uge98iOn+OdFBqBuk9/?=
 =?us-ascii?Q?8dEHhNUvkk6jhRBrNaSsbAESISyGhAwILa5MZ826kVstGYR3/2G0Tmb5C5F1?=
 =?us-ascii?Q?XBIROgdiqPU3zjKiLTtBX6CqB3/e2Jqag+idFjW3sDDOe5QaWlLsA+cw7oDJ?=
 =?us-ascii?Q?ouTSjaHaIOYj3T776QFFYCFmQeFmxixyG7SdzQp6Eq2qUGlgZ9Ip8X1r/BY3?=
 =?us-ascii?Q?QxjrNeodHJDOUlHKtr9+YfPU8LUmErY=3D?=
X-Exchange-RoutingPolicyChecked: OI7qrsVqWzkQIZ3Ih9e9sC2X/Xby8o1vSCDBC1NcW6PIRPm1W6mm2UuQbRUSRiGmorSy4WKI3uch1s9NEXRHL2n1+/0aMUsaSpr5h1Kwi9LRVoWZtF0m2ZKJwlAltzP/tzqWEw9UYQKPfJu8VuvHXkCjM7A2RcOCaX9Xwnlx5/stAbWNw+LsHiP7VA/yOP5QtsYWOXXb/0ucH4dYTT49CLgh+H1IbuHbAmkAycBnExVSqZhNCtnQCKfhEkIB3JW4tzNukexEEiYBY8LX3VdUSWqywUnmxV5QK2KVKCt1NcX0qDk3iGgUIZIws6XQ93Vz97c+P5p6yXmwoNDaaxYsNA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a627bf-ac5e-4333-3e3e-08defdf72ab7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 13:38:35.0084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mO6RTsEfBKarYt2SyPHoSdqW7WOFyKtkYKvB6iqC/IB1S4jhev97RRCsHjn1pYkThkUaeKO/bFRXSV6vKJ5HtQPwQJDL9fNe4jC+bTtXNbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7336
X-Proofpoint-ORIG-GUID: jAPCLo25tk8JD6F-mB0j89HAIViiX_95
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX5KzizpGLtLRq
 BLCEy0DSScNj1eLgwRTjguXvNI9d3g0yjhizzAUYL6JIjTILcxZ/ItcfQvqxlX7IiuTXCPkZkd0
 f44coi7U2acbfFyMkAfPEoTCUxkV41duGNc6U+TcWIwgIU2C8MdsYQtkZWaYf9IBT5/jBLlbAeF
 5fRUj/MVbbBtozmyrz4inoS3XUA4+cU6O09H4jh+Y0woKmgsg201EG3dDm9Ea7/DLStH2hdCWR1
 ppBGg8O5ctG81vsc9yloc+71ZWQ2Mj6T/fhV7npg2cgjAa+NJIUwKtKwwWZOMpRa+XMd1eNLHif
 FrOf+FLLxnTpVSwlw9hm0bmth1DiplB6iDWxD2Ic5Ys4FL/AsYMSK4rN2uAyZztfcVsAxlVQYcd
 iZv+0WJgpI93hsZZh9/xxDXd+BNNPDg7QYq/zQv3dO5kxgGA74/V9CcPAMHaIeKsb6HBMBi2pJS
 lZiCLIJ52HXWEvxxUaw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX0RG5FMpfoR6A
 vq6n7ZqH7EYwGysb34sNQ50XZbPeTwymQ93SJUrnVP+6b4GRayP0vtRld8R+zXvgQA1LhuC2zRl
 QKI921oDDrUy7mbMoR86/ZDONg4xRYI=
X-Authority-Analysis: v=2.4 cv=TfqmcxQh c=1 sm=1 tr=0 ts=6a85b1dd cx=c_pps
 a=CFps2rDb9cXvy/q1LzOFGQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=4QfE8SPBBHYfMhEiUa4A:9
X-Proofpoint-GUID: jAPCLo25tk8JD6F-mB0j89HAIViiX_95
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

This adds a class property that references a uint8_t within the object instance
and is intended to be a replacement for object_property_add_uint8_ptr().

This commit also removes the __attribute__((unused)) annotation from
object_class_prop_ptr() which is no longer required now that the previous defined
DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS() is now being used.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h | 18 ++++++++++++++++++
 qom/object.c         | 23 ++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 11b1c9d2dc..eba675d218 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2033,6 +2033,24 @@ ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
                                               const uint8_t *v,
                                               ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint8_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @offset: the offset from the object instance where the uint8 value is
+ *   stored
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint8'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
+                                         const char *name,
+                                         ptrdiff_t offset,
+                                         ObjectPropertyFlags flags);
+
 /**
  * object_class_static_property_add_uint8_ptr:
  * @klass: the object class to add a static property to
diff --git a/qom/object.c b/qom/object.c
index 9cb2cae4a7..a480fdd400 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2703,7 +2703,6 @@ DEFINE_OBJECT_PROPERTY_SCALAR_METHODS(uint64)
 #undef DEFINE_OBJECT_PROPERTY_SCALAR_METHODS
 
 
-__attribute__((unused))
 static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
 {
     void *ptr = obj;
@@ -2742,6 +2741,8 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
     OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type) \
     OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
 
+DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint8)
+
 #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
 #undef OBJECT_CLASS_PROPERTY_SCALAR_SETTER
 #undef DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS
@@ -2767,6 +2768,26 @@ object_property_add_uint8_ptr(Object *obj, const char *name,
                                getter, setter, NULL, (void *)v);
 }
 
+ObjectProperty *
+object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
+                                    ptrdiff_t offset,
+                                    ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_uint8_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_uint8_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint8",
+                                     getter, setter, NULL, (void *)offset);
+}
+
 ObjectProperty *
 object_class_static_property_add_uint8_ptr(ObjectClass *klass,
                                            const char *name,
-- 
2.43.0


