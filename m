Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6C6CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13TP-0006Ke-J7; Tue, 23 Sep 2025 09:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13TM-0006HZ-EV; Tue, 23 Sep 2025 09:54:24 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13TE-0003w1-Ad; Tue, 23 Sep 2025 09:54:24 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N9Yjpj2985871; Tue, 23 Sep 2025 06:54:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=BS1V7yzBhh9C82NFqBlkOAlYi/LfGjSjchxGB/tgx
 rQ=; b=thI7WcjUAOew7/evrPOsa7bqdOl2cmv3NOytp3Bmo/H98uGTX7/2mQNor
 vVZff3SSQ2gt9dhvH2XnZb8WEEp/dbiJGEm1kAxLjhkJUAy4BJJeTAfOjHDq3K/8
 HPhGx0iK5PRhnCB39GW/OjLY6Ar57T4Q2S/GeaE7Kap6xOxMe60PlzZcWXkl74Rv
 TW0+6g24J7SDzhf79HK/t5hzFtk84AhPY8VaT8G/wMEKKbLXM7pXuN0YImTOHF+o
 RJF77bFggYg80Iosw4I8FtGYVsT3qPYJqICIwvYmuyi02X8Px1gXWGS+alNFr+l+
 eqTxAUdQAih0WjpA/jm2/2CJXedWw==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021100.outbound.protection.outlook.com [40.107.208.100])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49b6tju00v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8lVyWq4AY8Nbt+Sfi+gGCzzAnmeWrvjIHZDU4T79SAZrs2ZwBpBneyl37WnXSV9P8/FAkhzLySmrqeCK1vBJjKH0bfwZAxi/zz5ksLrkvAySaLpLf02dS2Lk2RPeKG6iGo82wV+kIl+fyMVdOzQFvSnsqqmQreUAnuKYESyZ6873ViRJpvcIDw3dh8LiD9UrrPMpXgc1jo8VX0HMiNS+XcdEXm21Zb6Lnm/CBIWP8qU0yqQmKMmAALXq8gnMvmSup1wWbhqYjYNoWRCBPHmlo8W1Tvr1QGOQhDzEp49F23jVT8Usbt2KF0X/7pOgir6Zw8/LgsKUHjdVbBmIBBIpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BS1V7yzBhh9C82NFqBlkOAlYi/LfGjSjchxGB/tgxrQ=;
 b=A/9ik5O1GiTErQ1Cy4X+XglDVWu58WdmzEaetPwxxXJTNFtEbFwuHdqUeRngdxVnGUzAQxRP7praDMc54E/qNRB5heHTEKkgi/wT5bePdxKnbY7Zr3YDD9w0J8cwwwgM0tyMT3rBaJUVXkAdbtZs2KMbXflKxzkLsudoO6gw9DeykaTdiRYEK/+cVTBuyyJr/pm3h/1VqUzU9lCbcwEoJprqOVLtq41SRo02Ls3fCBK0quhIqNI8kD2oqhqDkCPsW3Ey3qufqFNFHTDod6ay59M/+REW9SK4721OVOMcvHGD8saDa5lk3l3d5Z+IOVaVpR5aVBd6pErgM6NcxOoc9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BS1V7yzBhh9C82NFqBlkOAlYi/LfGjSjchxGB/tgxrQ=;
 b=h9DG3asoGBIrpzpEpBvUcJTJsf3Jj3cg7c43laoovKddvZ161cxG5/Iuwc2OgPB0KdYrpIevOYdpgj0CK+sKuvdYjvMq4pWgD8+Zh5Ux5x9R1fpYN2no7O2lONK1rH/bz5/14MKHkGkukCrCvMvxC6Oj659tt2XmZe441KJw/3oypIXq10pBT/oVLDPD3jCW6/38gclHtvJvlQ67vzPOc/tBr1mE+spJjlaf35THq6O4yZVktJccMLwZ4V3oRkwb32jfFZzJ57sPPJqgn08KvKIMfgQoipI49aEhUZl41A/zilQvL9xKN/HCRlGTMOR2yYDXFWoR1EqgV5yMNkP38g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB7037.namprd02.prod.outlook.com (2603:10b6:208:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 13:54:04 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:54:04 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 02/27] include/hw/vfio/vfio-container-base.h: rename
 VFIOContainerBase to VFIOContainer
Date: Tue, 23 Sep 2025 14:53:08 +0100
Message-ID: <20250923135352.1157250-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0181.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 84174a5b-7f3f-4484-6152-08ddfaa8a836
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|10070799003|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eLqEhnogQOldAmnBf7v9pqmmdlZwNnL5Opv97FZrAFDhoAQdVYvBi0RPa7cE?=
 =?us-ascii?Q?9ayjF/9ho81B9UQxM2Ka9csqnAbUdxFwxh3vRRrq78/UrZSbXvsrFurJ6Tnp?=
 =?us-ascii?Q?OrX/V9EE3+G4Cpr8K7lFHPiBxC2yUnMr4t2hesHQWq30hNFe9yICUaqzfrvl?=
 =?us-ascii?Q?A5xbOrLo+ubn8bA8+/fSsVrjCEfRQI95bREta2+biUAklg6pTlVVlwGmH3SC?=
 =?us-ascii?Q?fW3sXlaWwGtq+r0bOzBxoyyOMLto3uAWImdaVIhOQWQtGOyS0jYDH+k4F0ye?=
 =?us-ascii?Q?k6Ux78s+vWdmgtgBcdTe9aIenxa8AtU/GYAXewIP61d5Q30h7AWLRyTkkDlZ?=
 =?us-ascii?Q?aOt1/LmY89zXJEPa1vG+7eaSLHU9LWLGkBD5ICyQz/WuwEIuJ3poYFAF41E0?=
 =?us-ascii?Q?LAs8VjGUiobsoppbsMrDu3+RkUi6NrU6ZLJjLMtw8S+beD1rXdzW9rOV51kz?=
 =?us-ascii?Q?f3CBwmEarTacsgSTjAphrdbSd2cFnBzo1dJ69X5mfVF0wIH0Fig0z6wcAsHq?=
 =?us-ascii?Q?eFGlWzqUgpjbdT6EHBqf3O9kUg+Um1bF5r10SHb9i9kXkQk+YSb9C9ZUdWk7?=
 =?us-ascii?Q?AFpvJbeZfOvK1uDbAX0M99/bNCNsMFdXrlUpduqQx6AoP04mZR5yEF3fAuXK?=
 =?us-ascii?Q?ziCqHTC3auZLHQn2VPMusly4FCcqXRX8WF0cAdCVZzxfRqceDLernrCPSJQF?=
 =?us-ascii?Q?j37lVZpwMshU+byW4mNS34u5L1euuD59tn5HCjp9yOwjZkxLYDMZHlNeJeyG?=
 =?us-ascii?Q?O4YYUg4phGS+2V4Hi12oEikQYQYnOAM3/7Zzhdro6dy/RwtLzMMQFgqdZpso?=
 =?us-ascii?Q?HikaK2mG41dBSkmzWNCSUeXCDeLCxlDN7sYyBmQYiIcmXMMMbe6by84gBFn2?=
 =?us-ascii?Q?L0OAQ8T3pTwAgZWYrDQlIqZuQUVh0/wnCA9uM/Z2qqJYQTvapj/cWaS18KxD?=
 =?us-ascii?Q?0pczY4QwqvBh2UrfkKt+rAZQMVozmRLI9En4oBSPJ31KPNvcE9JVlR/Q+TO2?=
 =?us-ascii?Q?XPhGpbEuObWKFCc+HkcTBAyC+rPGC0eC4Z1vtc1Ir5pRW+sjRwRDsPjsP0ka?=
 =?us-ascii?Q?/nBOP/+SizZCDH9mqxYAPrdWnU5FiakqDUCPQUJ8zHgj1Ov1W3KZnRo9WDF9?=
 =?us-ascii?Q?ZHiPsagCA/x+Ri3JlxTD2v+RD01V5dJ7rdu84szZ12OA0aWH1MwMZeGxoTdj?=
 =?us-ascii?Q?sj9bde+z9H5Z9Ahjmc48Kq9dB0V8KT2Y8VB2pJh7yOT0XfnfRgTp3vN6VAGI?=
 =?us-ascii?Q?msn/o6gYfnyHmH2F2EuaPiui3jikoUoxWqXEo4XxtabZmI9xRZeUcYlaXQlk?=
 =?us-ascii?Q?rYFLesOA9pYNrB0hHNxGTDipS3Ww5fsIjbAr//wL7cM03RX/e6g8a6ovbyE0?=
 =?us-ascii?Q?qODyRqMp1g29mdkbm6CcnHLxzk2BSNWoRzl4p6haRzg9NFegcA49GL+LoFBh?=
 =?us-ascii?Q?fC7/CRXQE0Qu+Z6d5RKg5VOmu3wAcMAF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mAVYlMAisNKuKLQX6VFfxp3kOsdrQPu/6NoP5ZAX78A2gd/iieWhQ7onbz5f?=
 =?us-ascii?Q?nW9DY7wpbcQXOymPLKwUHFezudKyUdYgXGVptyqDQMnDSQBPizDKhnagwGjK?=
 =?us-ascii?Q?3tF3mtqh7+pkili+aoQfRSEiAl4lovVqf5ebXOBV6hbZilZUR/4CyzPwxy3x?=
 =?us-ascii?Q?iieLWtRnw/WCeJ0uEf1t3qCJxU+l0kKxEKUeDxOlrJdcRkPXeJsO5XaTg2kH?=
 =?us-ascii?Q?9YNpXXI8y6JdQWkR718yTG1qV3SldSY/wNoueFQujzqeZs/dXuEMiZdRylBW?=
 =?us-ascii?Q?sMhhR2rnCaYr2u4jeB0VW4JAH3KJsBLlo1CwhZ/Nns5CF8PQAQaTM5bXBXn/?=
 =?us-ascii?Q?q4XNGrX73r0/Ss2k1an5mvSwMLb6/c5VghZ4eui4N/z717vyyHx9wbDAu7QW?=
 =?us-ascii?Q?LK0G+q6rENKwuUi/CkVKxr3ETte/0oX7+l8qdz9edNVALya3A06ugBAIQtlu?=
 =?us-ascii?Q?RukUBVbqtx2Kf4lUarhU1qcGym0g0OVQfbz5Ysff20vn+2ApQ6tfAM92GnIU?=
 =?us-ascii?Q?fWZt6pfmVZHPgtan9QjE0sEgkPM0okQuXkXp8Wiy+YKgVq54UV4XA7tNKoNK?=
 =?us-ascii?Q?W5jO8YchXbI1W00RtMNcDrWRA6U+LfCI71CSGbEcwznjB//eyzBl6Ptrbx9V?=
 =?us-ascii?Q?rtxL2h5XFbb79oF9zu+XRH7EMxV9iM3HYyD3/dh0TRHcYAVsf5nwCfLALCsX?=
 =?us-ascii?Q?6kCDiFxQx2ztk2dh3cKmwQizH5t4PiST4FYlmO7B26PK7pbQ7vb5w7/mg3Mx?=
 =?us-ascii?Q?8hP6Y35Qg8GGipWzKX8wsaz1j28NMGqCy+4hFRBvnWh6Yo9KQv/iGOFwdK1a?=
 =?us-ascii?Q?FDEZoHx9Mfxq/xtc2JbfW6qKKyvtSKaP4dZWFUrk3qUsHd136aGfOyDPApdW?=
 =?us-ascii?Q?Th0M8nEXU0SpWR9vu+wi+qknVUNVO9GfE0q90VmOyKgNNnbmyJkJ0Isoudl4?=
 =?us-ascii?Q?1l/19879xD7NcX+I5yinD33eorTpfEpvJmTMgeekRVIVzaKZAy3Xq8Lr+37L?=
 =?us-ascii?Q?XoLjlYroCuqMJMZlz8wJhWBAeLYKbHB2Odpfe40kRkWWnlpbczNTbnPFChn1?=
 =?us-ascii?Q?K0DGr7Xdth82ou/tqt68uE7+cckSVsv1PiWuVjQunPfAsGd51e+6LTmG5ws6?=
 =?us-ascii?Q?MXw2SaFWEpSCN39b0s5URCkgNfdhoYCJK5WYRAm48fyozO+eh9JXJXvRE5K7?=
 =?us-ascii?Q?lpXH0tgFE/zDLmvvJDyxMg9TL4FMop/MrGUkUO87CXJHhOim12Q76DbEOr2f?=
 =?us-ascii?Q?6rnxMfHEajWgiiEFpvHIq8gkh5qG8PFO0ozYefDAK62zwGgObOdlFj5/JiqA?=
 =?us-ascii?Q?DEyz6cHL/rsZY4gDaCO1VteULM2YgWCqE1oaiRS6HhkMj/eR7KJAC/D9kjCp?=
 =?us-ascii?Q?mNp26crxVoNA+7LAtQ/vriEPKe/KDdQ1OVKquwchqrb5hkLzURQdJ3BmQ7E+?=
 =?us-ascii?Q?4BduYQEfuIrFrp/Zc4kjovk8zXTuN9H//jaUswuNFqr7prsG8tXj7BN/xzQz?=
 =?us-ascii?Q?0TN8ruRpmxVyrFzyPxPlCAHkQVybeXjuWaAHJPXBcGlv9rv+/ImnwoKiB6X2?=
 =?us-ascii?Q?y3C5mYRyVYEuOlGpq6TaOLrnTM9kDALnjuP3ji/W8+eGufyms1sbDTynolkZ?=
 =?us-ascii?Q?8WllvZ56KxJ2yRRuYeekmLYYn7mQ2fNrCn/Q0r+de96tCcDSf6VmOehmR+AE?=
 =?us-ascii?Q?k0ZbrQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84174a5b-7f3f-4484-6152-08ddfaa8a836
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:54:04.2830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U40Xej0jvcEGE2R2ORhcaWW1XaDCq0loFvNIOGF6jYVjxIJT3PyclBoLgXTIK1GA9vGQbtcdEEF1F+zlFwNaV3yA50EyYVjgkwGqLq+qplc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7037
X-Proofpoint-ORIG-GUID: kmevm1qb6tV1monn6MorDshN0jb05I5G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfX6FFBRqdjMQG8
 O9xf84yce0Gj2MfGlExnAKH7dnWjRB418sz88phST9wIAyabpmeDx5FJR8FraazI9IvfOU/uaBN
 1CSDPtUCQPhJ42OtSnjc/ckW6qvjVm6VWRKwacvJWpZhpVK8e8rlvxM/oJgplYJrDHJywxa6Lah
 6HQEZm/ag7gUqn9MjB+5wphCFr1ymNwydX9wEPi+T7Mn5EHn80osWyL90XrVZlJzXV7yGeK+/Sf
 Z9tKOT30PY6eQzbVFqmYs4X0/RGxU+FOryE4uG79K07p7lp449TETKlVK2zZp2dHIhYEoLgh7HX
 MlAV75LMdcU9bcE3KMeo9HY2sRb6wMrBQoZOQHiE3+pH4gLtmVH34eKRUnf50E=
X-Proofpoint-GUID: kmevm1qb6tV1monn6MorDshN0jb05I5G
X-Authority-Analysis: v=2.4 cv=BJSzrEQG c=1 sm=1 tr=0 ts=68d2a67e cx=c_pps
 a=EgTKCgcPzLllfVGnvYq9fA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=IcXyTmTK4DxogE5MuWoA:9 a=2zJFH5hcnsJJ4i6w:21
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

Now that the VFIOContainer struct name is available, rename VFIOContainerBase
to VFIOContainer to better indicate that it is the superclass of other
VFIOFooContainer structs.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/ppc/spapr_pci_vfio.c               |  2 +-
 hw/vfio-user/container.c              | 18 +++----
 hw/vfio-user/container.h              |  2 +-
 hw/vfio/container-base.c              | 41 ++++++++-------
 hw/vfio/container.c                   | 22 ++++----
 hw/vfio/cpr-iommufd.c                 |  4 +-
 hw/vfio/cpr-legacy.c                  | 14 ++---
 hw/vfio/device.c                      |  2 +-
 hw/vfio/iommufd.c                     | 18 +++----
 hw/vfio/listener.c                    | 74 +++++++++++++-------------
 hw/vfio/spapr.c                       | 12 ++---
 hw/vfio/vfio-iommufd.h                |  2 +-
 hw/vfio/vfio-listener.h               |  4 +-
 include/hw/vfio/vfio-container-base.h | 76 +++++++++++++--------------
 include/hw/vfio/vfio-container.h      |  2 +-
 include/hw/vfio/vfio-cpr.h            |  8 +--
 include/hw/vfio/vfio-device.h         |  4 +-
 17 files changed, 154 insertions(+), 151 deletions(-)

diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index faa3ab3fe1..c8175dd8a8 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -86,7 +86,7 @@ static int vfio_eeh_container_op(VFIOLegacyContainer *container, uint32_t op)
 static VFIOLegacyContainer *vfio_eeh_as_container(AddressSpace *as)
 {
     VFIOAddressSpace *space = vfio_address_space_get(as);
-    VFIOContainerBase *bcontainer = NULL;
+    VFIOContainer *bcontainer = NULL;
 
     if (QLIST_EMPTY(&space->containers)) {
         /* No containers to act on */
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 3cdbd44c1a..411eb7b28b 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -22,14 +22,14 @@
  * will fire during memory update transactions.  These depend on BQL being held,
  * so do any resulting map/demap ops async while keeping BQL.
  */
-static void vfio_user_listener_begin(VFIOContainerBase *bcontainer)
+static void vfio_user_listener_begin(VFIOContainer *bcontainer)
 {
     VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
 
     container->proxy->async_ops = true;
 }
 
-static void vfio_user_listener_commit(VFIOContainerBase *bcontainer)
+static void vfio_user_listener_commit(VFIOContainer *bcontainer)
 {
     VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
 
@@ -38,7 +38,7 @@ static void vfio_user_listener_commit(VFIOContainerBase *bcontainer)
     vfio_user_wait_reqs(container->proxy);
 }
 
-static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
+static int vfio_user_dma_unmap(const VFIOContainer *bcontainer,
                                hwaddr iova, ram_addr_t size,
                                IOMMUTLBEntry *iotlb, bool unmap_all)
 {
@@ -80,7 +80,7 @@ static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
     return ret;
 }
 
-static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
+static int vfio_user_dma_map(const VFIOContainer *bcontainer, hwaddr iova,
                              ram_addr_t size, void *vaddr, bool readonly,
                              MemoryRegion *mrp)
 {
@@ -154,14 +154,14 @@ static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
 }
 
 static int
-vfio_user_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
+vfio_user_set_dirty_page_tracking(const VFIOContainer *bcontainer,
                                     bool start, Error **errp)
 {
     error_setg_errno(errp, ENOTSUP, "Not supported");
     return -ENOTSUP;
 }
 
-static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+static int vfio_user_query_dirty_bitmap(const VFIOContainer *bcontainer,
                                          VFIOBitmap *vbmap, hwaddr iova,
                                          hwaddr size, Error **errp)
 {
@@ -169,7 +169,7 @@ static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
     return -ENOTSUP;
 }
 
-static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
+static bool vfio_user_setup(VFIOContainer *bcontainer, Error **errp)
 {
     VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
 
@@ -202,7 +202,7 @@ static VFIOUserContainer *
 vfio_user_container_connect(AddressSpace *as, VFIODevice *vbasedev,
                             Error **errp)
 {
-    VFIOContainerBase *bcontainer;
+    VFIOContainer *bcontainer;
     VFIOUserContainer *container;
     VFIOAddressSpace *space;
     VFIOIOMMUClass *vioc;
@@ -260,7 +260,7 @@ put_space_exit:
 
 static void vfio_user_container_disconnect(VFIOUserContainer *container)
 {
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     VFIOAddressSpace *space = bcontainer->space;
 
diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
index 96aa6785d9..241863ef97 100644
--- a/hw/vfio-user/container.h
+++ b/hw/vfio-user/container.h
@@ -14,7 +14,7 @@
 
 /* MMU container sub-class for vfio-user. */
 struct VFIOUserContainer {
-    VFIOContainerBase parent_obj;
+    VFIOContainer parent_obj;
 
     VFIOUserProxy *proxy;
 };
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 56304978e1..98c5198e50 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -67,13 +67,13 @@ void vfio_address_space_put(VFIOAddressSpace *space)
 }
 
 void vfio_address_space_insert(VFIOAddressSpace *space,
-                               VFIOContainerBase *bcontainer)
+                               VFIOContainer *bcontainer)
 {
     QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
     bcontainer->space = space;
 }
 
-int vfio_container_dma_map(VFIOContainerBase *bcontainer,
+int vfio_container_dma_map(VFIOContainer *bcontainer,
                            hwaddr iova, ram_addr_t size,
                            void *vaddr, bool readonly, MemoryRegion *mr)
 {
@@ -92,7 +92,7 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
     return vioc->dma_map(bcontainer, iova, size, vaddr, readonly, mr);
 }
 
-int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
+int vfio_container_dma_unmap(VFIOContainer *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb, bool unmap_all)
 {
@@ -102,7 +102,7 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
     return vioc->dma_unmap(bcontainer, iova, size, iotlb, unmap_all);
 }
 
-bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
+bool vfio_container_add_section_window(VFIOContainer *bcontainer,
                                        MemoryRegionSection *section,
                                        Error **errp)
 {
@@ -115,7 +115,7 @@ bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
     return vioc->add_window(bcontainer, section, errp);
 }
 
-void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
+void vfio_container_del_section_window(VFIOContainer *bcontainer,
                                        MemoryRegionSection *section)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
@@ -127,7 +127,7 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
     return vioc->del_window(bcontainer, section);
 }
 
-int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
+int vfio_container_set_dirty_page_tracking(VFIOContainer *bcontainer,
                                            bool start, Error **errp)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
@@ -151,7 +151,7 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
 }
 
 static bool vfio_container_devices_dirty_tracking_is_started(
-    const VFIOContainerBase *bcontainer)
+    const VFIOContainer *bcontainer)
 {
     VFIODevice *vbasedev;
 
@@ -165,14 +165,14 @@ static bool vfio_container_devices_dirty_tracking_is_started(
 }
 
 bool vfio_container_dirty_tracking_is_started(
-    const VFIOContainerBase *bcontainer)
+    const VFIOContainer *bcontainer)
 {
     return vfio_container_devices_dirty_tracking_is_started(bcontainer) ||
            bcontainer->dirty_pages_started;
 }
 
 bool vfio_container_devices_dirty_tracking_is_supported(
-    const VFIOContainerBase *bcontainer)
+    const VFIOContainer *bcontainer)
 {
     VFIODevice *vbasedev;
 
@@ -210,8 +210,9 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
     return vbasedev->io_ops->device_feature(vbasedev, feature);
 }
 
-static int vfio_container_iommu_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
-                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
+static int vfio_container_iommu_query_dirty_bitmap(
+    const VFIOContainer *bcontainer, VFIOBitmap *vbmap, hwaddr iova,
+    hwaddr size, Error **errp)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
@@ -220,8 +221,9 @@ static int vfio_container_iommu_query_dirty_bitmap(const VFIOContainerBase *bcon
                                                errp);
 }
 
-static int vfio_container_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
-                 VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
+static int vfio_container_devices_query_dirty_bitmap(
+    const VFIOContainer *bcontainer, VFIOBitmap *vbmap, hwaddr iova,
+    hwaddr size, Error **errp)
 {
     VFIODevice *vbasedev;
     int ret;
@@ -242,8 +244,9 @@ static int vfio_container_devices_query_dirty_bitmap(const VFIOContainerBase *bc
     return 0;
 }
 
-int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
-                          uint64_t size, ram_addr_t ram_addr, Error **errp)
+int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
+                                      uint64_t iova, uint64_t size,
+                                      ram_addr_t ram_addr, Error **errp)
 {
     bool all_device_dirty_tracking =
         vfio_container_devices_dirty_tracking_is_supported(bcontainer);
@@ -297,7 +300,7 @@ static gpointer copy_iova_range(gconstpointer src, gpointer data)
      return dest;
 }
 
-GList *vfio_container_get_iova_ranges(const VFIOContainerBase *bcontainer)
+GList *vfio_container_get_iova_ranges(const VFIOContainer *bcontainer)
 {
     assert(bcontainer);
     return g_list_copy_deep(bcontainer->iova_ranges, copy_iova_range, NULL);
@@ -305,7 +308,7 @@ GList *vfio_container_get_iova_ranges(const VFIOContainerBase *bcontainer)
 
 static void vfio_container_instance_finalize(Object *obj)
 {
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(obj);
+    VFIOContainer *bcontainer = VFIO_IOMMU(obj);
     VFIOGuestIOMMU *giommu, *tmp;
 
     QLIST_SAFE_REMOVE(bcontainer, next);
@@ -322,7 +325,7 @@ static void vfio_container_instance_finalize(Object *obj)
 
 static void vfio_container_instance_init(Object *obj)
 {
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(obj);
+    VFIOContainer *bcontainer = VFIO_IOMMU(obj);
 
     bcontainer->error = NULL;
     bcontainer->dirty_pages_supported = false;
@@ -338,7 +341,7 @@ static const TypeInfo types[] = {
         .parent = TYPE_OBJECT,
         .instance_init = vfio_container_instance_init,
         .instance_finalize = vfio_container_instance_finalize,
-        .instance_size = sizeof(VFIOContainerBase),
+        .instance_size = sizeof(VFIOContainer),
         .class_size = sizeof(VFIOIOMMUClass),
         .abstract = true,
     },
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index bdf415b3d6..dc8425efb1 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -72,7 +72,7 @@ static int vfio_dma_unmap_bitmap(const VFIOLegacyContainer *container,
                                  hwaddr iova, ram_addr_t size,
                                  IOMMUTLBEntry *iotlb)
 {
-    const VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
+    const VFIOContainer *bcontainer = VFIO_IOMMU(container);
     struct vfio_iommu_type1_dma_unmap *unmap;
     struct vfio_bitmap *bitmap;
     VFIOBitmap vbmap;
@@ -121,7 +121,7 @@ unmap_exit:
     return ret;
 }
 
-static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
+static int vfio_legacy_dma_unmap_one(const VFIOContainer *bcontainer,
                                      hwaddr iova, ram_addr_t size,
                                      IOMMUTLBEntry *iotlb)
 {
@@ -184,7 +184,7 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
 /*
  * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
  */
-static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
+static int vfio_legacy_dma_unmap(const VFIOContainer *bcontainer,
                                  hwaddr iova, ram_addr_t size,
                                  IOMMUTLBEntry *iotlb, bool unmap_all)
 {
@@ -209,7 +209,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     return ret;
 }
 
-static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
+static int vfio_legacy_dma_map(const VFIOContainer *bcontainer, hwaddr iova,
                                ram_addr_t size, void *vaddr, bool readonly,
                                MemoryRegion *mr)
 {
@@ -242,7 +242,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
 }
 
 static int
-vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
+vfio_legacy_set_dirty_page_tracking(const VFIOContainer *bcontainer,
                                     bool start, Error **errp)
 {
     const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
@@ -267,7 +267,7 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
     return ret;
 }
 
-static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+static int vfio_legacy_query_dirty_bitmap(const VFIOContainer *bcontainer,
                       VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
 {
     const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
@@ -307,7 +307,7 @@ static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
 }
 
 static bool vfio_get_info_iova_range(struct vfio_iommu_type1_info *info,
-                                     VFIOContainerBase *bcontainer)
+                                     VFIOContainer *bcontainer)
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_iommu_type1_info_cap_iova_range *cap;
@@ -492,7 +492,7 @@ static void vfio_get_iommu_info_migration(VFIOLegacyContainer *container,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_iommu_type1_info_cap_migration *cap_mig;
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
 
     hdr = vfio_get_iommu_info_cap(info, VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION);
     if (!hdr) {
@@ -513,7 +513,7 @@ static void vfio_get_iommu_info_migration(VFIOLegacyContainer *container,
     }
 }
 
-static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
+static bool vfio_legacy_setup(VFIOContainer *bcontainer, Error **errp)
 {
     VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     g_autofree struct vfio_iommu_type1_info *info = NULL;
@@ -619,7 +619,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
                                    Error **errp)
 {
     VFIOLegacyContainer *container;
-    VFIOContainerBase *bcontainer;
+    VFIOContainer *bcontainer;
     int ret, fd = -1;
     VFIOAddressSpace *space;
     VFIOIOMMUClass *vioc = NULL;
@@ -732,7 +732,7 @@ fail:
 static void vfio_container_disconnect(VFIOGroup *group)
 {
     VFIOLegacyContainer *container = group->container;
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     QLIST_REMOVE(group, container_next);
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 148a06d552..6aaf6f77a2 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -176,7 +176,7 @@ void vfio_iommufd_cpr_unregister_iommufd(IOMMUFDBackend *be)
 bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
                                          Error **errp)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainer *bcontainer = &container->bcontainer;
 
     migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
                                 vfio_cpr_reboot_notifier,
@@ -189,7 +189,7 @@ bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
 
 void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainer *bcontainer = &container->bcontainer;
 
     migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
 }
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 12bf920a7d..bd3f6fc3d3 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -38,7 +38,7 @@ static bool vfio_dma_unmap_vaddr_all(VFIOLegacyContainer *container,
  * Set the new @vaddr for any mappings registered during cpr load.
  * The incoming state is cleared thereafter.
  */
-static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
+static int vfio_legacy_cpr_dma_map(const VFIOContainer *bcontainer,
                                    hwaddr iova, ram_addr_t size, void *vaddr,
                                    bool readonly, MemoryRegion *mr)
 {
@@ -100,7 +100,7 @@ static int vfio_container_pre_save(void *opaque)
 static int vfio_container_post_load(void *opaque, int version_id)
 {
     VFIOLegacyContainer *container = opaque;
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     dma_map_fn saved_dma_map = vioc->dma_map;
     Error *local_err = NULL;
@@ -137,7 +137,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
 {
     VFIOLegacyContainer *container =
         container_of(notifier, VFIOLegacyContainer, cpr.transfer_notifier);
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
 
     if (e->type != MIG_EVENT_PRECOPY_FAILED) {
         return 0;
@@ -170,7 +170,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
 bool vfio_legacy_cpr_register_container(VFIOLegacyContainer *container,
                                         Error **errp)
 {
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
     Error **cpr_blocker = &container->cpr.blocker;
 
     migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
@@ -194,7 +194,7 @@ bool vfio_legacy_cpr_register_container(VFIOLegacyContainer *container,
 
 void vfio_legacy_cpr_unregister_container(VFIOLegacyContainer *container)
 {
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
 
     migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
     migrate_del_blocker(&container->cpr.blocker);
@@ -210,7 +210,7 @@ void vfio_legacy_cpr_unregister_container(VFIOLegacyContainer *container)
  * The giommu already exists.  Find it and replay it, which calls
  * vfio_legacy_cpr_dma_map further down the stack.
  */
-void vfio_cpr_giommu_remap(VFIOContainerBase *bcontainer,
+void vfio_cpr_giommu_remap(VFIOContainer *bcontainer,
                            MemoryRegionSection *section)
 {
     VFIOGuestIOMMU *giommu = NULL;
@@ -235,7 +235,7 @@ void vfio_cpr_giommu_remap(VFIOContainerBase *bcontainer,
  * The ram discard listener already exists.  Call its populate function
  * directly, which calls vfio_legacy_cpr_dma_map.
  */
-bool vfio_cpr_ram_discard_register_listener(VFIOContainerBase *bcontainer,
+bool vfio_cpr_ram_discard_register_listener(VFIOContainer *bcontainer,
                                             MemoryRegionSection *section)
 {
     VFIORamDiscardListener *vrdl =
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 08f12ac31f..963cefc053 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -460,7 +460,7 @@ void vfio_device_detach(VFIODevice *vbasedev)
     VFIO_IOMMU_GET_CLASS(vbasedev->bcontainer)->detach_device(vbasedev);
 }
 
-void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
+void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
                          struct vfio_device_info *info)
 {
     int i;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 8c27222f75..7f2243d9d1 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -34,7 +34,7 @@
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO             \
             TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
 
-static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
+static int iommufd_cdev_map(const VFIOContainer *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly,
                             MemoryRegion *mr)
 {
@@ -46,7 +46,7 @@ static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                                    iova, size, vaddr, readonly);
 }
 
-static int iommufd_cdev_map_file(const VFIOContainerBase *bcontainer,
+static int iommufd_cdev_map_file(const VFIOContainer *bcontainer,
                                  hwaddr iova, ram_addr_t size,
                                  int fd, unsigned long start, bool readonly)
 {
@@ -58,7 +58,7 @@ static int iommufd_cdev_map_file(const VFIOContainerBase *bcontainer,
                                         iova, size, fd, start, readonly);
 }
 
-static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
+static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
                               hwaddr iova, ram_addr_t size,
                               IOMMUTLBEntry *iotlb, bool unmap_all)
 {
@@ -159,7 +159,7 @@ static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
     return hwpt && hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 }
 
-static int iommufd_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
+static int iommufd_set_dirty_page_tracking(const VFIOContainer *bcontainer,
                                            bool start, Error **errp)
 {
     const VFIOIOMMUFDContainer *container =
@@ -190,7 +190,7 @@ err:
     return -EINVAL;
 }
 
-static int iommufd_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+static int iommufd_query_dirty_bitmap(const VFIOContainer *bcontainer,
                                       VFIOBitmap *vbmap, hwaddr iova,
                                       hwaddr size, Error **errp)
 {
@@ -464,7 +464,7 @@ static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
 
 static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainer *bcontainer = &container->bcontainer;
 
     if (!QLIST_EMPTY(&bcontainer->device_list)) {
         return;
@@ -486,7 +486,7 @@ static int iommufd_cdev_ram_block_discard_disable(bool state)
 static bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
                                              uint32_t ioas_id, Error **errp)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainer *bcontainer = &container->bcontainer;
     g_autofree struct iommu_ioas_iova_ranges *info = NULL;
     struct iommu_iova_range *iova_ranges;
     int sz, fd = container->be->fd;
@@ -528,7 +528,7 @@ error:
 static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
                                 AddressSpace *as, Error **errp)
 {
-    VFIOContainerBase *bcontainer;
+    VFIOContainer *bcontainer;
     VFIOIOMMUFDContainer *container;
     VFIOAddressSpace *space;
     struct vfio_device_info dev_info = { .argsz = sizeof(dev_info) };
@@ -687,7 +687,7 @@ err_connect_bind:
 
 static void iommufd_cdev_detach(VFIODevice *vbasedev)
 {
-    VFIOContainerBase *bcontainer = vbasedev->bcontainer;
+    VFIOContainer *bcontainer = vbasedev->bcontainer;
     VFIOAddressSpace *space = bcontainer->space;
     VFIOIOMMUFDContainer *container = container_of(bcontainer,
                                                    VFIOIOMMUFDContainer,
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index e093833165..3b6f17f0c3 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -52,7 +52,7 @@
  */
 
 
-static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
+static bool vfio_log_sync_needed(const VFIOContainer *bcontainer)
 {
     VFIODevice *vbasedev;
 
@@ -125,7 +125,7 @@ static MemoryRegion *vfio_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
 static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
 {
     VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
-    VFIOContainerBase *bcontainer = giommu->bcontainer;
+    VFIOContainer *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
     MemoryRegion *mr;
     hwaddr xlat;
@@ -202,7 +202,7 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
 {
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
-    VFIOContainerBase *bcontainer = vrdl->bcontainer;
+    VFIOContainer *bcontainer = vrdl->bcontainer;
     const hwaddr size = int128_get64(section->size);
     const hwaddr iova = section->offset_within_address_space;
     int ret;
@@ -220,7 +220,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
 {
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
-    VFIOContainerBase *bcontainer = vrdl->bcontainer;
+    VFIOContainer *bcontainer = vrdl->bcontainer;
     const hwaddr end = section->offset_within_region +
                        int128_get64(section->size);
     hwaddr start, next, iova;
@@ -250,7 +250,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
     return 0;
 }
 
-static bool vfio_ram_discard_register_listener(VFIOContainerBase *bcontainer,
+static bool vfio_ram_discard_register_listener(VFIOContainer *bcontainer,
                                                MemoryRegionSection *section,
                                                Error **errp)
 {
@@ -328,7 +328,7 @@ static bool vfio_ram_discard_register_listener(VFIOContainerBase *bcontainer,
     return true;
 }
 
-static void vfio_ram_discard_unregister_listener(VFIOContainerBase *bcontainer,
+static void vfio_ram_discard_unregister_listener(VFIOContainer *bcontainer,
                                                  MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
@@ -396,7 +396,7 @@ static bool vfio_listener_valid_section(MemoryRegionSection *section,
     return true;
 }
 
-static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
+static bool vfio_get_section_iova_range(VFIOContainer *bcontainer,
                                         MemoryRegionSection *section,
                                         hwaddr *out_iova, hwaddr *out_end,
                                         Int128 *out_llend)
@@ -423,9 +423,9 @@ static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
 
 static void vfio_listener_begin(MemoryListener *listener)
 {
-    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
-                                                 listener);
-    void (*listener_begin)(VFIOContainerBase *bcontainer);
+    VFIOContainer *bcontainer = container_of(listener, VFIOContainer,
+                                             listener);
+    void (*listener_begin)(VFIOContainer *bcontainer);
 
     listener_begin = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_begin;
 
@@ -436,9 +436,9 @@ static void vfio_listener_begin(MemoryListener *listener)
 
 static void vfio_listener_commit(MemoryListener *listener)
 {
-    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
-                                                 listener);
-    void (*listener_commit)(VFIOContainerBase *bcontainer);
+    VFIOContainer *bcontainer = container_of(listener, VFIOContainer,
+                                             listener);
+    void (*listener_commit)(VFIOContainer *bcontainer);
 
     listener_commit = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_commit;
 
@@ -460,7 +460,7 @@ static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
 }
 
 VFIORamDiscardListener *vfio_find_ram_discard_listener(
-    VFIOContainerBase *bcontainer, MemoryRegionSection *section)
+    VFIOContainer *bcontainer, MemoryRegionSection *section)
 {
     VFIORamDiscardListener *vrdl = NULL;
 
@@ -482,12 +482,12 @@ VFIORamDiscardListener *vfio_find_ram_discard_listener(
 static void vfio_listener_region_add(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
-    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
-                                                 listener);
+    VFIOContainer *bcontainer = container_of(listener, VFIOContainer,
+                                             listener);
     vfio_container_region_add(bcontainer, section, false);
 }
 
-void vfio_container_region_add(VFIOContainerBase *bcontainer,
+void vfio_container_region_add(VFIOContainer *bcontainer,
                                MemoryRegionSection *section,
                                bool cpr_remap)
 {
@@ -656,8 +656,8 @@ fail:
 static void vfio_listener_region_del(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
-    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
-                                                 listener);
+    VFIOContainer *bcontainer = container_of(listener, VFIOContainer,
+                                             listener);
     hwaddr iova, end;
     Int128 llend, llsize;
     int ret;
@@ -744,13 +744,13 @@ typedef struct VFIODirtyRanges {
 } VFIODirtyRanges;
 
 typedef struct VFIODirtyRangesListener {
-    VFIOContainerBase *bcontainer;
+    VFIOContainer *bcontainer;
     VFIODirtyRanges ranges;
     MemoryListener listener;
 } VFIODirtyRangesListener;
 
 static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
-                                     VFIOContainerBase *bcontainer)
+                                     VFIOContainer *bcontainer)
 {
     VFIOPCIDevice *pcidev;
     VFIODevice *vbasedev;
@@ -835,7 +835,7 @@ static const MemoryListener vfio_dirty_tracking_listener = {
     .region_add = vfio_dirty_tracking_update,
 };
 
-static void vfio_dirty_tracking_init(VFIOContainerBase *bcontainer,
+static void vfio_dirty_tracking_init(VFIOContainer *bcontainer,
                                      VFIODirtyRanges *ranges)
 {
     VFIODirtyRangesListener dirty;
@@ -860,7 +860,7 @@ static void vfio_dirty_tracking_init(VFIOContainerBase *bcontainer,
     memory_listener_unregister(&dirty.listener);
 }
 
-static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
+static void vfio_devices_dma_logging_stop(VFIOContainer *bcontainer)
 {
     uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
                               sizeof(uint64_t))] = {};
@@ -889,7 +889,7 @@ static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
 }
 
 static struct vfio_device_feature *
-vfio_device_feature_dma_logging_start_create(VFIOContainerBase *bcontainer,
+vfio_device_feature_dma_logging_start_create(VFIOContainer *bcontainer,
                                              VFIODirtyRanges *tracking)
 {
     struct vfio_device_feature *feature;
@@ -962,7 +962,7 @@ static void vfio_device_feature_dma_logging_start_destroy(
     g_free(feature);
 }
 
-static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
+static bool vfio_devices_dma_logging_start(VFIOContainer *bcontainer,
                                           Error **errp)
 {
     struct vfio_device_feature *feature;
@@ -1006,8 +1006,8 @@ static bool vfio_listener_log_global_start(MemoryListener *listener,
                                            Error **errp)
 {
     ERRP_GUARD();
-    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
-                                                 listener);
+    VFIOContainer *bcontainer = container_of(listener, VFIOContainer,
+                                             listener);
     bool ret;
 
     if (vfio_container_devices_dirty_tracking_is_supported(bcontainer)) {
@@ -1024,8 +1024,8 @@ static bool vfio_listener_log_global_start(MemoryListener *listener,
 
 static void vfio_listener_log_global_stop(MemoryListener *listener)
 {
-    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
-                                                 listener);
+    VFIOContainer *bcontainer = container_of(listener, VFIOContainer,
+                                             listener);
     Error *local_err = NULL;
     int ret = 0;
 
@@ -1057,7 +1057,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     vfio_giommu_dirty_notifier *gdn = container_of(n,
                                                 vfio_giommu_dirty_notifier, n);
     VFIOGuestIOMMU *giommu = gdn->giommu;
-    VFIOContainerBase *bcontainer = giommu->bcontainer;
+    VFIOContainer *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
     ram_addr_t translated_addr;
     Error *local_err = NULL;
@@ -1127,7 +1127,7 @@ static int vfio_ram_discard_query_dirty_bitmap(MemoryRegionSection *section,
 }
 
 static int
-vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
+vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainer *bcontainer,
                                             MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
@@ -1143,7 +1143,7 @@ vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
                                                 &vrdl);
 }
 
-static int vfio_sync_iommu_dirty_bitmap(VFIOContainerBase *bcontainer,
+static int vfio_sync_iommu_dirty_bitmap(VFIOContainer *bcontainer,
                                         MemoryRegionSection *section)
 {
     VFIOGuestIOMMU *giommu;
@@ -1180,7 +1180,7 @@ static int vfio_sync_iommu_dirty_bitmap(VFIOContainerBase *bcontainer,
     return 0;
 }
 
-static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
+static int vfio_sync_dirty_bitmap(VFIOContainer *bcontainer,
                                   MemoryRegionSection *section, Error **errp)
 {
     ram_addr_t ram_addr;
@@ -1209,8 +1209,8 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
 static void vfio_listener_log_sync(MemoryListener *listener,
         MemoryRegionSection *section)
 {
-    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
-                                                 listener);
+    VFIOContainer *bcontainer = container_of(listener, VFIOContainer,
+                                             listener);
     int ret;
     Error *local_err = NULL;
 
@@ -1241,7 +1241,7 @@ static const MemoryListener vfio_memory_listener = {
     .log_sync = vfio_listener_log_sync,
 };
 
-bool vfio_listener_register(VFIOContainerBase *bcontainer, Error **errp)
+bool vfio_listener_register(VFIOContainer *bcontainer, Error **errp)
 {
     bcontainer->listener = vfio_memory_listener;
     memory_listener_register(&bcontainer->listener, bcontainer->space->as);
@@ -1255,7 +1255,7 @@ bool vfio_listener_register(VFIOContainerBase *bcontainer, Error **errp)
     return true;
 }
 
-void vfio_listener_unregister(VFIOContainerBase *bcontainer)
+void vfio_listener_unregister(VFIOContainer *bcontainer)
 {
     memory_listener_unregister(&bcontainer->listener);
 }
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index b8bade90d7..6d462aa13c 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -62,7 +62,7 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
     VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
                                                   prereg_listener);
     VFIOLegacyContainer *container = &scontainer->container;
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
     int ret;
@@ -244,7 +244,7 @@ static bool vfio_spapr_create_window(VFIOLegacyContainer *container,
                                     hwaddr *pgsize, Error **errp)
 {
     int ret = 0;
-    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
     IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
@@ -348,7 +348,7 @@ static bool vfio_spapr_create_window(VFIOLegacyContainer *container,
 }
 
 static bool
-vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
+vfio_spapr_container_add_section_window(VFIOContainer *bcontainer,
                                         MemoryRegionSection *section,
                                         Error **errp)
 {
@@ -439,7 +439,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
 }
 
 static void
-vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
+vfio_spapr_container_del_section_window(VFIOContainer *bcontainer,
                                         MemoryRegionSection *section)
 {
     VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
@@ -461,7 +461,7 @@ vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
     }
 }
 
-static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
+static void vfio_spapr_container_release(VFIOContainer *bcontainer)
 {
     VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
@@ -478,7 +478,7 @@ static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
     }
 }
 
-static bool vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
+static bool vfio_spapr_container_setup(VFIOContainer *bcontainer,
                                        Error **errp)
 {
     VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
index 07ea0f4304..6c049d9257 100644
--- a/hw/vfio/vfio-iommufd.h
+++ b/hw/vfio/vfio-iommufd.h
@@ -23,7 +23,7 @@ typedef struct VFIOIOASHwpt {
 typedef struct IOMMUFDBackend IOMMUFDBackend;
 
 typedef struct VFIOIOMMUFDContainer {
-    VFIOContainerBase bcontainer;
+    VFIOContainer bcontainer;
     IOMMUFDBackend *be;
     uint32_t ioas_id;
     QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
diff --git a/hw/vfio/vfio-listener.h b/hw/vfio/vfio-listener.h
index eb69ddd374..a90674ca96 100644
--- a/hw/vfio/vfio-listener.h
+++ b/hw/vfio/vfio-listener.h
@@ -9,7 +9,7 @@
 #ifndef HW_VFIO_VFIO_LISTENER_H
 #define HW_VFIO_VFIO_LISTENER_H
 
-bool vfio_listener_register(VFIOContainerBase *bcontainer, Error **errp);
-void vfio_listener_unregister(VFIOContainerBase *bcontainer);
+bool vfio_listener_register(VFIOContainer *bcontainer, Error **errp);
+void vfio_listener_unregister(VFIOContainer *bcontainer);
 
 #endif /* HW_VFIO_VFIO_LISTENER_H */
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index acbd48a18a..b580f4a02d 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -26,14 +26,14 @@ typedef struct {
 
 typedef struct VFIOAddressSpace {
     AddressSpace *as;
-    QLIST_HEAD(, VFIOContainerBase) containers;
+    QLIST_HEAD(, VFIOContainer) containers;
     QLIST_ENTRY(VFIOAddressSpace) list;
 } VFIOAddressSpace;
 
 /*
  * This is the base object for vfio container backends
  */
-struct VFIOContainerBase {
+struct VFIOContainer {
     Object parent_obj;
 
     VFIOAddressSpace *space;
@@ -48,17 +48,17 @@ struct VFIOContainerBase {
     bool dirty_pages_started; /* Protected by BQL */
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
-    QLIST_ENTRY(VFIOContainerBase) next;
+    QLIST_ENTRY(VFIOContainer) next;
     QLIST_HEAD(, VFIODevice) device_list;
     GList *iova_ranges;
     NotifierWithReturn cpr_reboot_notifier;
 };
 
 #define TYPE_VFIO_IOMMU "vfio-iommu"
-OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
+OBJECT_DECLARE_TYPE(VFIOContainer, VFIOIOMMUClass, VFIO_IOMMU)
 
 typedef struct VFIOGuestIOMMU {
-    VFIOContainerBase *bcontainer;
+    VFIOContainer *bcontainer;
     IOMMUMemoryRegion *iommu_mr;
     hwaddr iommu_offset;
     IOMMUNotifier n;
@@ -66,7 +66,7 @@ typedef struct VFIOGuestIOMMU {
 } VFIOGuestIOMMU;
 
 typedef struct VFIORamDiscardListener {
-    VFIOContainerBase *bcontainer;
+    VFIOContainer *bcontainer;
     MemoryRegion *mr;
     hwaddr offset_within_address_space;
     hwaddr size;
@@ -78,32 +78,32 @@ typedef struct VFIORamDiscardListener {
 VFIOAddressSpace *vfio_address_space_get(AddressSpace *as);
 void vfio_address_space_put(VFIOAddressSpace *space);
 void vfio_address_space_insert(VFIOAddressSpace *space,
-                               VFIOContainerBase *bcontainer);
+                               VFIOContainer *bcontainer);
 
-int vfio_container_dma_map(VFIOContainerBase *bcontainer,
+int vfio_container_dma_map(VFIOContainer *bcontainer,
                            hwaddr iova, ram_addr_t size,
                            void *vaddr, bool readonly, MemoryRegion *mr);
-int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
+int vfio_container_dma_unmap(VFIOContainer *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb, bool unmap_all);
-bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
+bool vfio_container_add_section_window(VFIOContainer *bcontainer,
                                        MemoryRegionSection *section,
                                        Error **errp);
-void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
+void vfio_container_del_section_window(VFIOContainer *bcontainer,
                                        MemoryRegionSection *section);
-int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
+int vfio_container_set_dirty_page_tracking(VFIOContainer *bcontainer,
                                            bool start, Error **errp);
 bool vfio_container_dirty_tracking_is_started(
-    const VFIOContainerBase *bcontainer);
+    const VFIOContainer *bcontainer);
 bool vfio_container_devices_dirty_tracking_is_supported(
-    const VFIOContainerBase *bcontainer);
-int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+    const VFIOContainer *bcontainer);
+int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
     uint64_t iova, uint64_t size, ram_addr_t ram_addr, Error **errp);
 
-GList *vfio_container_get_iova_ranges(const VFIOContainerBase *bcontainer);
+GList *vfio_container_get_iova_ranges(const VFIOContainer *bcontainer);
 
 static inline uint64_t
-vfio_container_get_page_size_mask(const VFIOContainerBase *bcontainer)
+vfio_container_get_page_size_mask(const VFIOContainer *bcontainer)
 {
     assert(bcontainer);
     return bcontainer->pgsizes;
@@ -123,12 +123,12 @@ struct VFIOIOMMUClass {
      * Perform basic setup of the container, including configuring IOMMU
      * capabilities, IOVA ranges, supported page sizes, etc.
      *
-     * @bcontainer: #VFIOContainerBase
+     * @bcontainer: #VFIOContainer
      * @errp: pointer to Error*, to store an error if it happens.
      *
      * Returns true to indicate success and false for error.
      */
-    bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
+    bool (*setup)(VFIOContainer *bcontainer, Error **errp);
 
     /**
      * @listener_begin
@@ -136,9 +136,9 @@ struct VFIOIOMMUClass {
      * Called at the beginning of an address space update transaction.
      * See #MemoryListener.
      *
-     * @bcontainer: #VFIOContainerBase
+     * @bcontainer: #VFIOContainer
      */
-    void (*listener_begin)(VFIOContainerBase *bcontainer);
+    void (*listener_begin)(VFIOContainer *bcontainer);
 
     /**
      * @listener_commit
@@ -146,9 +146,9 @@ struct VFIOIOMMUClass {
      * Called at the end of an address space update transaction,
      * See #MemoryListener.
      *
-     * @bcontainer: #VFIOContainerBase
+     * @bcontainer: #VFIOContainer
      */
-    void (*listener_commit)(VFIOContainerBase *bcontainer);
+    void (*listener_commit)(VFIOContainer *bcontainer);
 
     /**
      * @dma_map
@@ -156,7 +156,7 @@ struct VFIOIOMMUClass {
      * Map an address range into the container. Note that the memory region is
      * referenced within an RCU read lock region across this call.
      *
-     * @bcontainer: #VFIOContainerBase to use
+     * @bcontainer: #VFIOContainer to use
      * @iova: start address to map
      * @size: size of the range to map
      * @vaddr: process virtual address of mapping
@@ -165,7 +165,7 @@ struct VFIOIOMMUClass {
      *
      * Returns 0 to indicate success and -errno otherwise.
      */
-    int (*dma_map)(const VFIOContainerBase *bcontainer,
+    int (*dma_map)(const VFIOContainer *bcontainer,
                    hwaddr iova, ram_addr_t size,
                    void *vaddr, bool readonly, MemoryRegion *mr);
     /**
@@ -173,14 +173,14 @@ struct VFIOIOMMUClass {
      *
      * Map a file range for the container.
      *
-     * @bcontainer: #VFIOContainerBase to use for map
+     * @bcontainer: #VFIOContainer to use for map
      * @iova: start address to map
      * @size: size of the range to map
      * @fd: descriptor of the file to map
      * @start: starting file offset of the range to map
      * @readonly: map read only if true
      */
-    int (*dma_map_file)(const VFIOContainerBase *bcontainer,
+    int (*dma_map_file)(const VFIOContainer *bcontainer,
                         hwaddr iova, ram_addr_t size,
                         int fd, unsigned long start, bool readonly);
     /**
@@ -188,7 +188,7 @@ struct VFIOIOMMUClass {
      *
      * Unmap an address range from the container.
      *
-     * @bcontainer: #VFIOContainerBase to use for unmap
+     * @bcontainer: #VFIOContainer to use for unmap
      * @iova: start address to unmap
      * @size: size of the range to unmap
      * @iotlb: The IOMMU TLB mapping entry (or NULL)
@@ -196,7 +196,7 @@ struct VFIOIOMMUClass {
      *
      * Returns 0 to indicate success and -errno otherwise.
      */
-    int (*dma_unmap)(const VFIOContainerBase *bcontainer,
+    int (*dma_unmap)(const VFIOContainer *bcontainer,
                      hwaddr iova, ram_addr_t size,
                      IOMMUTLBEntry *iotlb, bool unmap_all);
 
@@ -234,21 +234,21 @@ struct VFIOIOMMUClass {
      *
      * Start or stop dirty pages tracking on VFIO container
      *
-     * @bcontainer: #VFIOContainerBase on which to de/activate dirty
+     * @bcontainer: #VFIOContainer on which to de/activate dirty
      *              page tracking
      * @start: indicates whether to start or stop dirty pages tracking
      * @errp: pointer to Error*, to store an error if it happens.
      *
      * Returns zero to indicate success and negative for error.
      */
-    int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
+    int (*set_dirty_page_tracking)(const VFIOContainer *bcontainer,
                                    bool start, Error **errp);
     /**
      * @query_dirty_bitmap
      *
      * Get bitmap of dirty pages from container
      *
-     * @bcontainer: #VFIOContainerBase from which to get dirty pages
+     * @bcontainer: #VFIOContainer from which to get dirty pages
      * @vbmap: #VFIOBitmap internal bitmap structure
      * @iova: iova base address
      * @size: size of iova range
@@ -256,24 +256,24 @@ struct VFIOIOMMUClass {
      *
      * Returns zero to indicate success and negative for error.
      */
-    int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
+    int (*query_dirty_bitmap)(const VFIOContainer *bcontainer,
                 VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
     /* PCI specific */
     int (*pci_hot_reset)(VFIODevice *vbasedev, bool single);
 
     /* SPAPR specific */
-    bool (*add_window)(VFIOContainerBase *bcontainer,
+    bool (*add_window)(VFIOContainer *bcontainer,
                        MemoryRegionSection *section,
                        Error **errp);
-    void (*del_window)(VFIOContainerBase *bcontainer,
+    void (*del_window)(VFIOContainer *bcontainer,
                        MemoryRegionSection *section);
-    void (*release)(VFIOContainerBase *bcontainer);
+    void (*release)(VFIOContainer *bcontainer);
 };
 
 VFIORamDiscardListener *vfio_find_ram_discard_listener(
-    VFIOContainerBase *bcontainer, MemoryRegionSection *section);
+    VFIOContainer *bcontainer, MemoryRegionSection *section);
 
-void vfio_container_region_add(VFIOContainerBase *bcontainer,
+void vfio_container_region_add(VFIOContainer *bcontainer,
                                MemoryRegionSection *section, bool cpr_remap);
 
 #endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index 712a691400..a84dfb0dee 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -26,7 +26,7 @@ typedef struct VFIOGroup {
 } VFIOGroup;
 
 struct VFIOLegacyContainer {
-    VFIOContainerBase parent_obj;
+    VFIOContainer parent_obj;
 
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     unsigned iommu_type;
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 04e9872587..26ee0c4fe1 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -13,14 +13,14 @@
 #include "system/memory.h"
 
 struct VFIOLegacyContainer;
-struct VFIOContainerBase;
+struct VFIOContainer;
 struct VFIOGroup;
 struct VFIODevice;
 struct VFIOPCIDevice;
 struct VFIOIOMMUFDContainer;
 struct IOMMUFDBackend;
 
-typedef int (*dma_map_fn)(const struct VFIOContainerBase *bcontainer,
+typedef int (*dma_map_fn)(const struct VFIOContainer *bcontainer,
                           hwaddr iova, ram_addr_t size, void *vaddr,
                           bool readonly, MemoryRegion *mr);
 
@@ -65,11 +65,11 @@ int vfio_cpr_group_get_device_fd(int d, const char *name);
 bool vfio_cpr_container_match(struct VFIOLegacyContainer *container,
                               struct VFIOGroup *group, int fd);
 
-void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
+void vfio_cpr_giommu_remap(struct VFIOContainer *bcontainer,
                            MemoryRegionSection *section);
 
 bool vfio_cpr_ram_discard_register_listener(
-    struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
+    struct VFIOContainer *bcontainer, MemoryRegionSection *section);
 
 void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
                              int nr, int fd);
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index e7e6243e2d..67b9fcdd2c 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -54,7 +54,7 @@ typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) container_next;
     QLIST_ENTRY(VFIODevice) global_next;
     struct VFIOGroup *group;
-    VFIOContainerBase *bcontainer;
+    VFIOContainer *bcontainer;
     char *sysfsdev;
     char *name;
     DeviceState *dev;
@@ -252,7 +252,7 @@ struct VFIODeviceIOOps {
                         void *data, bool post);
 };
 
-void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
+void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
                          struct vfio_device_info *info);
 
 void vfio_device_unprepare(VFIODevice *vbasedev);
-- 
2.43.0


