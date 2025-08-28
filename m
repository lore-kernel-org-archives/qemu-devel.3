Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F45C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 10:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urZWZ-00007n-7X; Thu, 28 Aug 2025 06:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1urZWL-0008Oz-GK
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 06:06:20 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1urZWI-0003Vl-JG
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 06:06:17 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S0C71M3582273; Thu, 28 Aug 2025 03:06:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Aho1TY709whTElAnP6d55iXSZ9Ad9I+LBoxp5xMag
 5U=; b=KesCJfarORr9MFbXKaeSfTl2sBVU38XqQbNaKpOebdvZu7Hot9CJ4NYlg
 nJBE8TPUYZOFWDi92YPlROhKlO8q51PhhBRsP74CLBaEOUZrbGuHK72My19u8/Pw
 8LCijVYhPRl29OGAbJsMuMbckDQk13rV7YYoEVefL+K9F4pJWAXVyzaS4XVzA3gr
 nrTf309d5c6cboKsKi81tEdea/s2iFF7s++H8c1b+2WHjaKAef/Ww3m+57RvSA3v
 dDVhU3OWP9QIXnRyaPVkhjnzPmdrniSeO6eKmF6QuaqH1oJtDprUwY8A7czCe0zF
 s0Y5NUVkr6Nv030M4xWhzw9MBBJGQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2092.outbound.protection.outlook.com [40.107.94.92])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48tcc312n6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 03:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXtCFAmv7VRF0nez+Nw0lwho7kiZo8ngTlbONp2dTraM7nxiuuPZ2w2SDE4akpBEsfqX4FHYRvdKylGQPA2305tIb7cYmHmON26DqeM4Ds3rED050BLp5IdY0WkBCwDXPybPgC1Qyd5rXQOl6tjk4D/WkaIY5QP+YGVZJCN1Q2XOAD7cXiKZ0ohiDhCauhrUnsViRoJ+ygqGDnGHOCv/vc37AI2Zu+ev1RFSeGpoJnEz7EffSbNVwWr6C1iTRAyiGUBF7mF6FqHbSOA0epEtsdFDR/RMB+Mp0G3oLjEBaPUPtnm2RLuEglTCUyqHOy5i2jfz2CM7954pTl7FqPSxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aho1TY709whTElAnP6d55iXSZ9Ad9I+LBoxp5xMag5U=;
 b=AL0s3k13X0MbZHi2EbKdUkrpEQxfv7YqlX34eGr9P5xlG2tereGpeQYxkXlWkmdhmDS0C/PCC264mWJwUhtX415yCsJ6TB3pH8GIz7p0xEYJkMI0pSEdHvQsv0Ym93cNW8a5k7Qedcjwwhjyx3aYBrH8Ha1EID4K7Ji4Nn+eLcpaIi5bcfu16U2uIKw3E6xUYfWZf2f13BLM2aFNoDsk9HrPdoaf5LQEOsthkjrI8mcp2wItpHjJMnc6Tn2ysn9IYl3mQB3kD99eSn7hMZgpqv41lqaQh2VHkPxw6wAVcN2s3EB2nFxApjdTJKFsLyB1xqYbKmdrUWPoBS9EzTiAQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aho1TY709whTElAnP6d55iXSZ9Ad9I+LBoxp5xMag5U=;
 b=MP39ruA4KvhikTa+CjIRigJxNEs/SLtNTsOVpQtbAn4BLrZAPntFKupuyPFDFKEk3vX6CYTvgNWHx6EYyEjZZlokumYt39dZ1A4JDSSzt78puKe5XrbPBkFtXqzeZsNJHO24pcPo+7Lvfrs9HtmJuskGHGp1tKy4EF0soIu0zIVsZkwwt9mVLvxOThji2v+43PT79iOwtHm/XrfuaZN4h9p1PPFjHPG3wIv2KR8mAEYjraugs2+M4pwz8fHerBd4n44UHMEaQ7DKf4LHRN8MoFWHhOKlRVcpPQ8Px758l6kYiIXy7qXY/FcQWiUDNgtTe4GfYgxtGqEqHjsmUOHydQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BY5PR02MB6628.namprd02.prod.outlook.com (2603:10b6:a03:205::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 28 Aug
 2025 10:06:06 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9052.021; Thu, 28 Aug 2025
 10:06:05 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v3 3/3] tests/functional: add a vfio-user smoke test
Date: Thu, 28 Aug 2025 11:05:55 +0100
Message-ID: <20250828100555.1893504-4-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828100555.1893504-1-john.levon@nutanix.com>
References: <20250828100555.1893504-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0050.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::12) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BY5PR02MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c360e86-421c-4cc0-ce3d-08dde61a7ffa
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4934Mz+38utjuFZMC/OiY4h8nlfqYTmGVt09NaUN+2feypFqRrjqSNRjHHNy?=
 =?us-ascii?Q?haZnqAZx+YQAuAiI271uhJlw+cA1aFleB/jwMt58Tjn0HKKVfUjxKpvYasJx?=
 =?us-ascii?Q?lQrT8R+ifDX8yEfaxhjanbu1zN3XaSbsRa+rj4Yr4xvjL2qpDqwV3oEc9cwK?=
 =?us-ascii?Q?vZIazwILpuS3/P+mAJPiiclqBaL0mufGvrG/HQpEmCmeSIPI9TY48W/OO/dw?=
 =?us-ascii?Q?eEY9aliwNmemNe+EhoMW68sC30vMEhDnVBe5FUYrF8yy+DS+Xx6QRJPsK1Or?=
 =?us-ascii?Q?wUqWex2x2pOA56zxL+uidsE8e4kd7L0AOpqVvi+mr6ziC57t2NXN9TrxCkvZ?=
 =?us-ascii?Q?E0itxKed3VjQ2Ke8LlMCVcNCgJCG/OxLJVbl8k3zj4nKlX2qzdfC+6rcQgpe?=
 =?us-ascii?Q?NgHS5SvTuM0ZhBNChU9tPe0qWUjYRs/oAqS0RPgq8+F/2MMqi1F6qqOb1427?=
 =?us-ascii?Q?RVSXZoDi8kMKAmGXIhG66dz9zrMXwPg2zMRYyEIb2TmCEs4NjE8ow/vxlUCD?=
 =?us-ascii?Q?vifrlZzsPT0sRNx8vsUG8rZqdHmCL/KluZqG3f60YBa6hU+r4iC1CSsg8I3S?=
 =?us-ascii?Q?k09QC+vPrfySSEcxpUI54b9Ywie5vQZXtdtjawaKIvERMy/CTf8aJXZSAxNl?=
 =?us-ascii?Q?WT4I/0ftrekFko8fUXPPRX58OJehq9GfwNQPKCVu21mqD79wYlrJxWW+W9KX?=
 =?us-ascii?Q?KEsX+zfZO74URpVqUZGBiwjZXKZKnJUfDuSaCE54/W+eZvKgmm+njNUNSncN?=
 =?us-ascii?Q?FkZhfmt7zb5uDpdja5hUA1izvV7JXrTj0BRpSqzW72d9lhB9992nLNcycG3l?=
 =?us-ascii?Q?jPmt6tquJzecd57dkNEK/PE8p0sPXkICaGwfKz3DYpoHO+Fezp/KYxp0GNTZ?=
 =?us-ascii?Q?litqjSySPpVv6skAuY+FAy1jVyFHolpwQXCwaUkSplrdLcjl6CjYtFNvZAwo?=
 =?us-ascii?Q?y00W4H60Y5Lg6bpMandE8mJmsYdx4mhn+IfOrf1Kro6eA3+FpCvMnk4Uax4y?=
 =?us-ascii?Q?YNQ0R7vroG4df9Z/d/UmmtYFrBmtqtIXLO7Xw4uyydkgum0VcwXX0DukWfJD?=
 =?us-ascii?Q?VDEo+iitniP10ISa9ny4rMjtuHV22YmWDhMYCynzW0cP9sF5IivVZ2/Jsbqr?=
 =?us-ascii?Q?NhOHmkwCjnxo99SmxFukkuLTQIiIG1D28/pE4GEBuUJC70eiQy4+gVrMLOVv?=
 =?us-ascii?Q?80gStkZRVHVLPCITmqTf2clg8xSg1U0k53IT/9SSffXcGrn696awQGs58Z/Y?=
 =?us-ascii?Q?S9KuytQbRKpiuK1M5Enf/Vk6SOM+WhhR5x0YF6anzYmHXvUuNzpwYGsAd4F1?=
 =?us-ascii?Q?BmdOacwG7i61+p+eax89smrfz1GR+kiHg1xTimUZr6UP3Lg/ijfqiLzwfyQD?=
 =?us-ascii?Q?wasbSYQc/JflbQY0nIvFneNSy6BVOLMmOIIJi2ru6KY5BuM44E7e7PxlVfSo?=
 =?us-ascii?Q?OXbLVSIAI/Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wgiLvTov7BoGgjLU+1dBbX7bW2KJwp5HC6sgrTPH2EbCvZtgwIDX10hJpl4N?=
 =?us-ascii?Q?hTIEoa2Qgu2RqwTgwEF40uDo5wpNjqdJDG4hRlfE5WjeqmqGBidqnqRLbbw/?=
 =?us-ascii?Q?sh0LCLiw94hlmojZW4CRACwQfhBNVilV+WTtiWO9zODo7dZbBGIe+nmYUxBa?=
 =?us-ascii?Q?NoPkqCJojWRPmZqoh12BnBZJDU/QJgjG0b6bPXj7UdThaFmYR4WiFnqUiqld?=
 =?us-ascii?Q?Ay9AI1taJHpjXfTs3/vyZpqnGRhxHNxUIEyWReg3TCfHtNqOWy3FyxaASUYz?=
 =?us-ascii?Q?zqCw997G59S/VCFzu85R9m0A9tvqFSdTABKMYbeZ0Di1Ed4rvlWiqQp1QuR+?=
 =?us-ascii?Q?VvU7sNME+AFyAb8LjWmSMiV2V1EVDxwejh5efSLCEEGgrYPf5KPbQ7d+Ay5o?=
 =?us-ascii?Q?2FlA+n2fbJOQZrrue32GOTJiDqc1TA1nSNZKJfkILpOcoFhPeW0rLtNnUY/P?=
 =?us-ascii?Q?FnkaD+t7jIiPlV8ESb+uehehmiOR04U72rABRgt1BX1j2XVLZm2NpilkijOK?=
 =?us-ascii?Q?MU754oTz/QJ5G6U/E3XXBLfbEHIthXUDuz1tgB+YlTn5+7HTaeI+RukVcpOw?=
 =?us-ascii?Q?imdpNzsA0Ab0qTAdhS2AiCEvX0A0OdcxqMeAE6pDWdcgA39RBvKBu98XO2GV?=
 =?us-ascii?Q?e5wyofOEytpzSzWqLh0k1CeGUiZn4EQIsDUmp3xXRAz3necN98gU+C5OWyWy?=
 =?us-ascii?Q?qe6mphIj/M4Pz/GfkQq3KCBgpJMwf3jTcS48etH0jPp0tVmXFkXdV/Ks5nmn?=
 =?us-ascii?Q?fH/TjcwZJkFv8vNTCHNGaui1837i1aIANja/kuSrMfSQfrpAdgYrj75uAzFn?=
 =?us-ascii?Q?TSZEflVK0jSkrp9yX3CE3wmpoUU/A2yiJq2gUAEgtaNNxXU+dZe0Fl0W86JR?=
 =?us-ascii?Q?Y5DT6uZDa8GDC/dMo9e9iauuQ/Exf2ZhqKFprZADRV1LDbF6/K4k9V2b9ZIi?=
 =?us-ascii?Q?taudm0D2uDR5Hmqt1Vvc3kk/rdGMOk4JrYwnnWrYnQECbTH+Ya4YVFQo5Lj3?=
 =?us-ascii?Q?MTXjOSefCH2s8vYefWYW2jQTeEB/E4uMScpnxVUxaO9nZL4grVmu4gw2f93S?=
 =?us-ascii?Q?AvDPaAhBtfEOZDwhckouaTqXbH/E2D0HuOApv2/x3EPzd3kn2JmczCqzIKEH?=
 =?us-ascii?Q?7VePOFqo0CODB+mGhyHl3wPccpYXOZJwfdGpbgftpeJ8VD1HoIYHtVa4ziCU?=
 =?us-ascii?Q?Oi/OtfmCZ0pAF7pjvAHo/ysU6j2QhjBj+JvxQCJW6kfseYEjEL7PHUh4FtRC?=
 =?us-ascii?Q?Uo2g59nV69EkcmybPH/7KtSSNMZtX2/oE3U5ConDKJuRusJocwAIwaU3VRaz?=
 =?us-ascii?Q?l178Px2tplGK9KBR/rjl7gkAKXtK12OZBcZTmbHzfqbRBG++bFFHyYznfULJ?=
 =?us-ascii?Q?2bUtDIuNvbPxirEIPpZlDFDwiTW1EhCKeO7UuFIwNe5nVtXQTb9jae3yn2ho?=
 =?us-ascii?Q?KMnfir8/xB6zgQwNBFNd7wW7/DmL1fud8zMtWw8um2ehm83RhS6ap3NHyraH?=
 =?us-ascii?Q?xllwQ2CGOzXvmmE7Ey/RdEmfjf1QxHFC+w8LM96EDg8kwTU6/b5I1nnQ/jSm?=
 =?us-ascii?Q?BW3VERPUHNhgYjOAAvlVVGA/1CMxNc8MyYa4UUAU?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c360e86-421c-4cc0-ce3d-08dde61a7ffa
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 10:06:04.9687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebjsVPjhtKpBwzNzXVUofLG3BZ8LpifIZzXbOd2xRJSdk9a47CHIvhpneXnCFTvz0DMN/Nxv/lZ3yaYG/b8UmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6628
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA4NCBTYWx0ZWRfX06i6YWvKRyfS
 6S8aS+J7C6u/FyjJyXkd2Egm7Mar8UR6VmhaEX9yRV8QstWwVYCy2SOA++P1BKyGczP9drMwdzj
 z1vrzKZFf5U5StMCkjZAj7xi23J/zZoVvehdEArb9DwQt4HzGB2q5xfkQgTguMr9ZPzThklxsnY
 5FoUSQVEcgvT/ObiI625Z/a9DXUqUiwaPf82EJsx33wCSrlz7FmWEsnVwDk7sPyv+K0Tn95Ph4c
 C8aFNXKbh2UUMxgCqevxiUJ3AoROFrFL5QiUR4vlYyvQbWtA0GqCedkrJNAOf95z/7FJufSl06t
 8O/Ss0G2PBaT+X1fZc26UzKlwPkl2IYoUuu9BfpNgi8YKSvFCtCGjjHv1MZDE8=
X-Authority-Analysis: v=2.4 cv=JaS8rVKV c=1 sm=1 tr=0 ts=68b02a14 cx=c_pps
 a=odStxYl4fA30BBTO3gVnUA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10 a=NEAV23lmAAAA:8
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=bGJ7yUH-iEoZGlg0rpsA:9
X-Proofpoint-GUID: Or-dkyCzIFfajeI7FG3SFnbBEU1rC3Bo
X-Proofpoint-ORIG-GUID: Or-dkyCzIFfajeI7FG3SFnbBEU1rC3Bo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-28_01,2025-03-28_01
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Add a basic test of the vfio-user PCI client implementation.

Co-authored-by: John Levon <john.levon@nutanix.com>
Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 MAINTAINERS                                   |   1 +
 tests/functional/x86_64/meson.build           |   1 +
 .../x86_64/test_vfio_user_client.py           | 407 ++++++++++++++++++
 3 files changed, 409 insertions(+)
 create mode 100755 tests/functional/x86_64/test_vfio_user_client.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f074e4371..dbcab38b03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4309,6 +4309,7 @@ F: docs/system/devices/vfio-user.rst
 F: hw/vfio-user/*
 F: include/hw/vfio-user/*
 F: subprojects/libvfio-user
+F: tests/functional/x86_64/test_vfio_user_client.py
 
 EBPF:
 M: Jason Wang <jasowang@redhat.com>
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index d0b4667bb8..eed1936976 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -31,6 +31,7 @@ tests_x86_64_system_thorough = [
   'replay',
   'reverse_debug',
   'tuxrun',
+  'vfio_user_client',
   'virtio_balloon',
   'virtio_gpu',
 ]
diff --git a/tests/functional/x86_64/test_vfio_user_client.py b/tests/functional/x86_64/test_vfio_user_client.py
new file mode 100755
index 0000000000..51676dbf8e
--- /dev/null
+++ b/tests/functional/x86_64/test_vfio_user_client.py
@@ -0,0 +1,407 @@
+#!/usr/bin/env python3
+#
+# Copyright (c) 2025 Nutanix, Inc.
+#
+# Author:
+#  Mark Cave-Ayland <mark.caveayland@nutanix.com>
+#  John Levon <john.levon@nutanix.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Check basic vfio-user-pci client functionality. The test starts two VMs:
+
+    - the server VM runs the libvfio-user "gpio" example server inside it,
+      piping vfio-user traffic between a local UNIX socket and a virtio-serial
+      port. On the host, the virtio-serial port is backed by a local socket.
+
+    - the client VM loads the gpio-pci-idio-16 kernel module, with the
+      vfio-user client connecting to the above local UNIX socket.
+
+This way, we don't depend on trying to run a vfio-user server on the host
+itself.
+
+Once both VMs are running, we run some basic configuration on the gpio device
+and verify that the server is logging the expected out. As this is consistent
+given the same VM images, we just do a simple direct comparison.
+"""
+
+import difflib
+import logging
+import os
+import re
+import select
+import shutil
+import socket
+import subprocess
+import time
+
+from qemu_test import Asset
+from qemu_test import QemuSystemTest
+from qemu_test import exec_command
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+
+EXPECTED_SERVER_OUT=\
+"""gpio: adding DMA region [0, 0xc0000) offset=0 flags=0x3
+gpio: adding DMA region [0xc0000, 0xe0000) offset=0 flags=0x1
+gpio: adding DMA region [0xe0000, 0x100000) offset=0 flags=0x1
+gpio: adding DMA region [0x100000, 0x8000000) offset=0 flags=0x3
+gpio: adding DMA region [0xfffc0000, 0x100000000) offset=0 flags=0x1
+gpio: devinfo flags 0x3, num_regions 9, num_irqs 5
+gpio: region_info[0] offset 0 flags 0 size 0 argsz 32
+gpio: region_info[1] offset 0 flags 0 size 0 argsz 32
+gpio: region_info[2] offset 0 flags 0x3 size 256 argsz 32
+gpio: region_info[3] offset 0 flags 0 size 0 argsz 32
+gpio: region_info[4] offset 0 flags 0 size 0 argsz 32
+gpio: region_info[5] offset 0 flags 0 size 0 argsz 32
+gpio: region_info[7] offset 0 flags 0x3 size 256 argsz 32
+gpio: region7: read 256 bytes at 0
+gpio: region7: read 0 from (0x30:4)
+gpio: write mask to EROM ignored
+gpio: region7: wrote 0xfffff800 to (0x30:4)
+gpio: region7: read 0 from (0x30:4)
+gpio: cleared EROM
+gpio: region7: wrote 0 to (0x30:4)
+gpio: region7: read 0x1 from (0x18:4)
+gpio: region7: read 0x1 from (0x3d:1)
+gpio: region7: read 0x1 from (0x3d:1)
+gpio: disabling IRQ type INTx range [0, 1)
+gpio: disabling IRQ type ERR range [0, 1)
+gpio: disabling IRQ type INTx range [0, 1)
+gpio: region7: read 0 from (0x4:2)
+gpio: region7: wrote 0 to (0x4:2)
+gpio: device reset by client
+gpio: region7: read 0x1 from (0x3d:1)
+gpio: disabling IRQ type INTx range [0, 1)
+gpio: region7: wrote 0 to (0x10:4)
+gpio: region7: wrote 0 to (0x14:4)
+gpio: BAR2 addr 0x0
+gpio: region7: wrote 0 to (0x18:4)
+gpio: region7: wrote 0 to (0x1c:4)
+gpio: region7: wrote 0 to (0x20:4)
+gpio: region7: wrote 0 to (0x24:4)
+gpio: removing DMA region [0, 0xc0000) flags=0
+gpio: removing DMA region [0xc0000, 0xe0000) flags=0
+gpio: removing DMA region [0xe0000, 0x100000) flags=0
+gpio: removing DMA region [0x100000, 0x8000000) flags=0
+gpio: adding DMA region [0, 0xd0000) offset=0 flags=0x3
+gpio: adding DMA region [0xd0000, 0xe0000) offset=0 flags=0x1
+gpio: adding DMA region [0xe0000, 0xf0000) offset=0 flags=0x1
+gpio: adding DMA region [0xf0000, 0x8000000) offset=0 flags=0x3
+gpio: removing DMA region [0, 0xd0000) flags=0
+gpio: removing DMA region [0xd0000, 0xe0000) flags=0
+gpio: removing DMA region [0xe0000, 0xf0000) flags=0
+gpio: removing DMA region [0xf0000, 0x8000000) flags=0
+gpio: adding DMA region [0, 0x8000000) offset=0 flags=0x3
+gpio: region7: read 0x494f from (0:2)
+gpio: region7: read 0 from (0xe:1)
+gpio: region7: read 0x494f from (0:2)
+gpio: region7: read 0 from (0xe:1)
+gpio: region7: read 0x494f from (0:2)
+gpio: region7: read 0xdc8494f from (0:4)
+gpio: region7: read 0 from (0x8:4)
+gpio: region7: read 0 from (0xe:1)
+gpio: region7: read 0 from (0xe:1)
+gpio: region7: wrote 0xffffffff to (0x10:4)
+gpio: region7: wrote 0 to (0x10:4)
+gpio: region7: wrote 0xffffffff to (0x14:4)
+gpio: region7: wrote 0 to (0x14:4)
+gpio: BAR2 addr 0xffffffff
+gpio: region7: wrote 0xffffffff to (0x18:4)
+gpio: BAR2 addr 0x1
+gpio: region7: wrote 0x1 to (0x18:4)
+gpio: region7: wrote 0xffffffff to (0x1c:4)
+gpio: region7: wrote 0 to (0x1c:4)
+gpio: region7: wrote 0xffffffff to (0x20:4)
+gpio: region7: wrote 0 to (0x20:4)
+gpio: region7: wrote 0xffffffff to (0x24:4)
+gpio: region7: wrote 0 to (0x24:4)
+gpio: write mask to EROM ignored
+gpio: region7: wrote 0xfffff800 to (0x30:4)
+gpio: cleared EROM
+gpio: region7: wrote 0 to (0x30:4)
+gpio: BAR2 addr 0xc000
+gpio: region7: wrote 0xc000 to (0x18:4)
+gpio: region7: read 0x1 from (0x3d:1)
+gpio: ILINE=b
+gpio: region7: wrote 0xb to (0x3c:1)
+gpio: region7: read 0 from (0x4:2)
+gpio: I/O space enabled
+gpio: memory space enabled
+gpio: SERR# enabled
+gpio: region7: wrote 0x103 to (0x4:2)
+gpio: region7: read 0x1 from (0x3d:1)
+gpio: region7: read 0xb from (0x3c:1)
+gpio: adding DMA region [0xfeb80000, 0xfebc0000) offset=0 flags=0x1
+gpio: removing DMA region [0xfeb80000, 0xfebc0000) flags=0
+gpio: EROM disable ignored
+gpio: region7: wrote 0xfffffffe to (0x30:4)
+gpio: cleared EROM
+gpio: region7: wrote 0 to (0x30:4)
+gpio: removing DMA region [0, 0x8000000) flags=0
+gpio: adding DMA region [0, 0xc0000) offset=0 flags=0x3
+gpio: adding DMA region [0xc0000, 0xc1000) offset=0 flags=0x1
+gpio: adding DMA region [0xc1000, 0xc4000) offset=0 flags=0x3
+gpio: adding DMA region [0xc4000, 0xd0000) offset=0 flags=0x1
+gpio: adding DMA region [0xd0000, 0xf0000) offset=0 flags=0x3
+gpio: adding DMA region [0xf0000, 0x100000) offset=0 flags=0x1
+gpio: adding DMA region [0x100000, 0x8000000) offset=0 flags=0x3
+gpio: removing DMA region [0xc4000, 0xd0000) flags=0
+gpio: removing DMA region [0xd0000, 0xf0000) flags=0
+gpio: adding DMA region [0xc4000, 0xe8000) offset=0 flags=0x1
+gpio: adding DMA region [0xe8000, 0xf0000) offset=0 flags=0x3
+gpio: region7: read 0x494f from (0:2)
+gpio: region7: read 0xdc8 from (0x2:2)
+gpio: region7: read 0 from (0xe:1)
+gpio: region7: read 0xdc8494f from (0:4)
+gpio: region7: read 0 from (0xe:1)
+gpio: region7: read 0 from (0x6:2)
+gpio: region7: read 0 from (0x8:4)
+gpio: region7: read 0 from (0x6:2)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: INTx emulation disabled
+gpio: region7: wrote 0x503 to (0x4:2)
+gpio: region7: read 0x503 from (0x4:2)
+gpio: INTx emulation enabled
+gpio: region7: wrote 0x103 to (0x4:2)
+gpio: region7: read 0x1 from (0x3d:1)
+gpio: region7: read 0xb from (0x3c:1)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: I/O space disabled
+gpio: memory space disabled
+gpio: region7: wrote 0x100 to (0x4:2)
+gpio: region7: wrote 0xffffffff to (0x10:4)
+gpio: region7: wrote 0 to (0x10:4)
+gpio: I/O space enabled
+gpio: memory space enabled
+gpio: region7: wrote 0x103 to (0x4:2)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: I/O space disabled
+gpio: memory space disabled
+gpio: region7: wrote 0x100 to (0x4:2)
+gpio: region7: wrote 0xffffffff to (0x14:4)
+gpio: region7: wrote 0 to (0x14:4)
+gpio: I/O space enabled
+gpio: memory space enabled
+gpio: region7: wrote 0x103 to (0x4:2)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: I/O space disabled
+gpio: memory space disabled
+gpio: region7: wrote 0x100 to (0x4:2)
+gpio: BAR2 addr 0xffffffff
+gpio: region7: wrote 0xffffffff to (0x18:4)
+gpio: BAR2 addr 0xc001
+gpio: region7: wrote 0xc001 to (0x18:4)
+gpio: I/O space enabled
+gpio: memory space enabled
+gpio: region7: wrote 0x103 to (0x4:2)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: I/O space disabled
+gpio: memory space disabled
+gpio: region7: wrote 0x100 to (0x4:2)
+gpio: region7: wrote 0xffffffff to (0x1c:4)
+gpio: region7: wrote 0 to (0x1c:4)
+gpio: I/O space enabled
+gpio: memory space enabled
+gpio: region7: wrote 0x103 to (0x4:2)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: I/O space disabled
+gpio: memory space disabled
+gpio: region7: wrote 0x100 to (0x4:2)
+gpio: region7: wrote 0xffffffff to (0x20:4)
+gpio: region7: wrote 0 to (0x20:4)
+gpio: I/O space enabled
+gpio: memory space enabled
+gpio: region7: wrote 0x103 to (0x4:2)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: I/O space disabled
+gpio: memory space disabled
+gpio: region7: wrote 0x100 to (0x4:2)
+gpio: region7: wrote 0xffffffff to (0x24:4)
+gpio: region7: wrote 0 to (0x24:4)
+gpio: I/O space enabled
+gpio: memory space enabled
+gpio: region7: wrote 0x103 to (0x4:2)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: I/O space disabled
+gpio: memory space disabled
+gpio: region7: wrote 0x100 to (0x4:2)
+gpio: write mask to EROM ignored
+gpio: region7: wrote 0xfffff800 to (0x30:4)
+gpio: cleared EROM
+gpio: region7: wrote 0 to (0x30:4)
+gpio: I/O space enabled
+gpio: memory space enabled
+gpio: region7: wrote 0x103 to (0x4:2)
+gpio: region7: read 0 from (0x2c:2)
+gpio: region7: read 0 from (0x2e:2)
+gpio: region7: read 0 from (0x6:2)
+gpio: region7: read 0 from (0x6:2)
+gpio: region7: read 0 from (0x6:2)
+gpio: region7: read 0 from (0x6:2)
+gpio: region7: read 0 from (0x6:2)
+gpio: region7: read 0 from (0x6:2)
+gpio: region7: read 0 from (0x6:2)
+gpio: region7: read 0 from (0x6:2)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: region7: read 0 from (0xc:1)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: region7: read 0x1 from (0x3d:1)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: region2: wrote 0 to (0x3:1)
+gpio: region2: wrote 0 to (0x2:1)
+gpio: region2: wrote 0 to (0x1:1)"""
+
+
+class VfioUserClient(QemuSystemTest):
+
+    ASSET_REPO = 'https://github.com/mcayland-ntx/libvfio-user-test'
+
+    ASSET_KERNEL = Asset(
+        f'{ASSET_REPO}/raw/refs/heads/main/images/bzImage',
+        '40292fa6ce95d516e26bccf5974e138d0db65a6de0bc540cabae060fe9dea605'
+    )
+
+    ASSET_ROOTFS = Asset(
+        f'{ASSET_REPO}/raw/refs/heads/main/images/rootfs.ext2',
+        'e1e3abae8aebb8e6e77f08b1c531caeacf46250c94c815655c6bbea59fc3d1c1'
+    )
+
+
+    def prepare_images(self):
+        """Set up the images for the VMs."""
+        self.kernel_path = self.ASSET_KERNEL.fetch()
+        rootfs_path = self.ASSET_ROOTFS.fetch()
+
+        self.server_rootfs_path = self.scratch_file('server.ext2')
+        shutil.copy(rootfs_path, self.server_rootfs_path)
+        os.chmod(self.server_rootfs_path, 0o600)
+        self.client_rootfs_path = self.scratch_file('client.ext2')
+        shutil.copy(rootfs_path, self.client_rootfs_path)
+        os.chmod(self.client_rootfs_path, 0o600)
+
+    def configure_server_vm_args(self, server_vm, sock_path):
+        """
+        Configuration for the server VM. Set up virtio-serial device backed by
+        the given socket path.
+        """
+        server_vm.add_args('-kernel', self.kernel_path)
+        server_vm.add_args('-append', 'console=ttyS0 root=/dev/sda')
+        server_vm.add_args('-drive',
+            f"file={self.server_rootfs_path},if=ide,format=raw,id=drv0")
+        server_vm.add_args('-snapshot')
+        server_vm.add_args('-chardev',
+            f"socket,id=sock0,path={sock_path},telnet=off,server=on,wait=off")
+        server_vm.add_args('-device', 'virtio-serial')
+        server_vm.add_args('-device',
+            'virtserialport,chardev=sock0,name=org.fedoraproject.port.0')
+
+    def configure_client_vm_args(self, client_vm, sock_path):
+        """
+        Configuration for the client VM. Point the vfio-user-pci device to the
+        socket path configured above.
+        """
+
+        client_vm.add_args('-kernel', self.kernel_path)
+        client_vm.add_args('-append', 'console=ttyS0 root=/dev/sda')
+        client_vm.add_args('-drive',
+            f'file={self.client_rootfs_path},if=ide,format=raw,id=drv0')
+        client_vm.add_args('-device',
+            '{"driver":"vfio-user-pci",' +
+            '"socket":{"path": "%s", "type": "unix"}}' % sock_path)
+
+    def setup_vfio_user_pci_server(self, server_vm):
+        """
+        Start the libvfio-user server within the server VM, and arrange
+        for data to shuttle between its socket and the virtio serial port.
+        """
+        wait_for_console_pattern(self, 'login:', None, server_vm)
+        exec_command_and_wait_for_pattern(self, 'root', '#', None, server_vm)
+
+        exec_command_and_wait_for_pattern(self,
+            'gpio-pci-idio-16 -v /tmp/vfio-user.sock >/var/tmp/gpio.out 2>&1 &',
+            '#', None, server_vm)
+        # wait for libvfio-user to initialize properly
+        exec_command_and_wait_for_pattern(self, 'sleep 5', '#', None, server_vm)
+        exec_command_and_wait_for_pattern(self,
+            'socat UNIX-CONNECT:/tmp/vfio-user.sock /dev/vport0p1,ignoreeof ' +
+            ' &', '#', None, server_vm)
+
+    def test_vfio_user_pci(self):
+        self.prepare_images()
+        self.set_machine('pc')
+        self.require_device('virtio-serial')
+        self.require_device('vfio-user-pci')
+
+        sock_dir = self.socket_dir()
+        socket_path = sock_dir.name + '/vfio-user.sock'
+        socket_path = '/tmp/vfio-user.sock'
+
+        server_vm = self.get_vm(name='server')
+        server_vm.set_console()
+        self.configure_server_vm_args(server_vm, socket_path)
+
+        server_vm.launch()
+
+        self.log.debug('starting libvfio-user server')
+
+        self.setup_vfio_user_pci_server(server_vm)
+
+        client_vm = self.get_vm(name="client")
+        client_vm.set_console()
+        self.configure_client_vm_args(client_vm, socket_path)
+
+        try:
+            client_vm.launch()
+        except:
+            self.log.error('client VM failed to start, dumping server logs')
+            exec_command_and_wait_for_pattern(self, 'cat /var/tmp/gpio.out',
+                '#', None, server_vm)
+            raise
+
+        self.log.debug('waiting for client VM boot')
+
+        wait_for_console_pattern(self, 'login:', None, client_vm)
+        exec_command_and_wait_for_pattern(self, 'root', '#', None, client_vm)
+
+        #
+        # Here, we'd like to actually interact with the gpio device a little
+        # more as described at:
+        #
+        # https://github.com/nutanix/libvfio-user/blob/master/docs/qemu.md
+        #
+        # Unfortunately, the buildroot Linux kernel has some undiagnosed issue
+        # so we don't get /sys/class/gpio. Nonetheless just the basic
+        # initialization and setup is enough for basic testing of vfio-user.
+        #
+
+        self.log.debug('collecting libvfio-user server output')
+
+        out = exec_command_and_wait_for_pattern(self,
+            'cat /var/tmp/gpio.out',
+            'gpio: region2: wrote 0 to (0x1:1)',
+            None, server_vm)
+
+        pattern = re.compile(r'^gpio:')
+
+        gpio_server_out = [s for s in out.decode().splitlines()
+                                   if pattern.search(s)]
+
+        expected_server_out = EXPECTED_SERVER_OUT.splitlines()
+
+        if gpio_server_out != expected_server_out:
+            self.log.error('Server logs did not match:')
+            print("orig")
+            print(gpio_server_out)
+            print("second")
+            print(expected_server_out)
+            for line in difflib.unified_diff(expected_server_out,
+                                             gpio_server_out):
+                self.log.error(line)
+
+            self.assertTrue(gpio_server_out == expected_server_out)
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.43.0


