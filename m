Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EBFCA1017
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 20:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uttxn-0003bS-Ou; Wed, 03 Sep 2025 16:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uttxT-0003V8-Ow
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 16:19:55 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uttxK-0005G7-MA
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 16:19:51 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 583HHYQC3671744; Wed, 3 Sep 2025 13:19:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=CuQgdSrRjgGPUlUSJOGq1cNPCX9+NLqRMhVg2G/ku
 Js=; b=ASjCi/JzpimBl+jHKE48J5/hhzQEKx/IL5nVQDLH1Wc7lBM4old/MWX24
 QkObLJclLOKT80T8HF+7gpuroj9dtnUEK2Mkn2UMogwseVcSpgIzagvgABpHOdnR
 ik9yUCIhDfxsC+49htCw9YiFVGZlnh8W5BNKQvkGOLWXN9II4v5IHA7oLQrguUqf
 br3P8NimmpKaZeEUS1mh+VlyQFi5UMWbOUYXh/L8N3yTGK2stbD2L8kQ1e3B9qTN
 hVWsvXUzYApWePhxU7YpxzDfQllWJ28aZ9oyYTSsxw+fmAwSglYEJTt+Mw282/rw
 WFt0L+g1qxTuNEQhmcm4BqQUklApw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2112.outbound.protection.outlook.com [40.107.236.112])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48wxm0cdte-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 03 Sep 2025 13:19:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqBiXdoOuTZuakdRagdU4W98Sn5EpNSRju49Dj/oh4KPFSQi5c0J3YMlikdR/6shdfyP0ITOL4hqFzvDys26sdN/+mS1nWufNPqDGKZnau7olwMbHMnAVzg48G0aI4dIef5LFx4G5tGVilerRpj2ZoqW7q7tnWeQMGzIl4q7fZgZrs3aDtmVXYIfp1RHerYsHEERuHjJQg3BUO2O88D6QFvdMAFfkGY+0x3GhWpPtnS9NQdT+QJkLNmFLz2i8IVGiAcN5q6CEeY/D180S+xpqds82CCmC47xD1eZuAxqWHoGKNJneJNgfzhHAfDY+tsT6dteNUukLqbBm/n4q5Lhrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuQgdSrRjgGPUlUSJOGq1cNPCX9+NLqRMhVg2G/kuJs=;
 b=h5T45YUvzhZGkGJ2XplMLjQfBq85k5edj+5dvEi9wtutt1OcCSgBFOvesFTVisu/w8BhE8ulM160vayN3bwCzFpIHtWfzABKBCaIC8tl5sffJCr+j4AuMXAPLklGga7rC0x4a5x6p4MJHDc6ZBbHnmaIkUafOP+Lx4uE87M83J2HXuUVKiTpH+VqA9HHelEOll+C01DEWaEMP4XF2UPnq+jXRNZYbhnCAqanlHfEhYgnBlIK9wcdgFuRE4N1lk3mig7Qw9KJ/G3tHK1SE6BosOoV06sqlXfpp88FkDN7T22AjvmhzPxDu25cLU+0Q287VZHF3/07cJsauyKJUZrsdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuQgdSrRjgGPUlUSJOGq1cNPCX9+NLqRMhVg2G/kuJs=;
 b=uyxoOQb57xrCyrhkHGW0RBM/rxvsPQLGG6TOowSR6LtC2ZJoqUOmeys4u0gA+R3DYXqM/dK0wHH4TIviqnaWUzv4QjDLBmmPC9kC5AanT8gTOm6S16pQTOIU/Q56v3hVHHYpPAP7hyo7aVMu0KWUJ7h9Ys4kPlrxnK0a2fpTpcDsv3ayYZwVEXjLv5If5yykT7ss3IFLv6+bS7hfcV5/LY2n17HsL4eXRqmsTbPIhaJEPRWfK5sXJrXPu0lJujoC41VMXRxQzO0J8mKr7GHl4lMrYZz5lqPfIrnp2FVVY2AAkyR+feRG9Kp3ykc9XUt7/0xzzQg2clFnfRzp/0Jz0A==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH0PR02MB8133.namprd02.prod.outlook.com (2603:10b6:610:10a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 20:19:40 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 20:19:40 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 2/3] tests/functional: add vm param to cmd.py helpers
Date: Wed,  3 Sep 2025 22:19:30 +0200
Message-ID: <20250903201931.168317-3-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903201931.168317-1-john.levon@nutanix.com>
References: <20250903201931.168317-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0025.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::20) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH0PR02MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b58113-b1ba-43f5-21e2-08ddeb273631
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?irzzgIi5NeEbVVUohMfXbpO1uKdEA3UXgzqu0aGyFGKXtDveHxMAVNJXFhPZ?=
 =?us-ascii?Q?pzMtveaudeKU81qDe2Z3ZZ4/9ZQvjWpoSuN4UUZKaV/pZ7azlxvuAY5n548h?=
 =?us-ascii?Q?GVw0QrJLDwnjsVrFjGaorSeYvyvgNkmNEzgYG0vvyH1hBxphzblmwQ4e4H6Z?=
 =?us-ascii?Q?Fy1kBl6TU0iEzBhjHeEXI2Mh/DEI5hg3dIHAJTGknrQRg1M3Oa6YAQk9/F3A?=
 =?us-ascii?Q?OLg68eGSH62GpQkCeXWo5LLQ4mIrRInhlzsNCyFCAqYHW6ZpCH8P466et7cb?=
 =?us-ascii?Q?kJBDy0FIcKZb3B+Q57bN/Uz+ysj0vizYFp9kKKep4Y6CuGYH2EdVQDL1jzYS?=
 =?us-ascii?Q?K+W4vbNBA/wASsvoGU/25HShcrv/HpaMdnnll96KCoYBq6e9opSNswJ+d7Ta?=
 =?us-ascii?Q?g4aw5mbKRDoqBC8Swym5YiSKo2HUqlbQaAgcM9lVCcOj+bvF85IH7EQHFuSE?=
 =?us-ascii?Q?H5fg7YIPjNir/wdl3pk9O22K2WFbkREBUoaUrDZDONyAOQqqCJh5JHGp4QHG?=
 =?us-ascii?Q?lb0r1Chv0lyQdsO1G/vYsu+HFKIJUeMMRrxnXAQeJWDEi9OV1StzcmZ0PAdq?=
 =?us-ascii?Q?bMiGnIGf5ucQsMsovJqpm4lH7qA52kDnjTxk/HRRP+UH9Emwd67kifQR5hj5?=
 =?us-ascii?Q?kpJ8U7GnBzT3X/V6y1wCu9H3tujCWKG2EVtnUi7IuO/mxrtRLJe48EOLq8EY?=
 =?us-ascii?Q?mmr9IP2RJ2qhLF4BHJm4V/bbNdV5OE4jvoRFUWGlyKOVzO/e5ejCD4QgrG1j?=
 =?us-ascii?Q?Q+sXuJSq4ZbXOaSzwTnFYGhn+ojN5W02iM9JbHQrdMx104yIog/N5n3Itn45?=
 =?us-ascii?Q?w832JssMXyuW+LhZs37GIrXXPOuubBgnRpiE0vedIQCSkp8JNMhIu7rRJf+8?=
 =?us-ascii?Q?ieqXgBgoixzwGxM/hOxZ+pG0ZvbCZfrFSz72QdJN5u7yhf/owuaO2qkcrRdA?=
 =?us-ascii?Q?rmqh6+VXwfOu5ojXpYFIiOW6Xs3FKpEETkGCKhKbl6NE2VvuLqy9SLcAHFlt?=
 =?us-ascii?Q?SkX18THN6fP9v3QgJI7qpq3CewunehT8qPZSQi6HWwl6ZiuAiwujUUXaegEy?=
 =?us-ascii?Q?rO7sfh4j1BNk3OX75ZKMLtKb0WXoNk5I0oYMG2BMRhiFtG8eesko+m4zSaz7?=
 =?us-ascii?Q?sr/ViYrGta/8zSvGQ0Wt2VWJiepDZP1wNVeCUw3s9Cm5pn7IMakkeLafgYhz?=
 =?us-ascii?Q?W9/GJKgTw96MS0QSVO7tIDLEOAST/9RIRQLNRP9sD5Fv8vbKDmlziF2ri8A9?=
 =?us-ascii?Q?7m7GPm0HDbDp3UpO+1bgqWwl7b4uCLcd9ng0/UB5ROAwLFdB6u7vSv0jAM3J?=
 =?us-ascii?Q?h9ntMHcrQzG7NYlIyqrmU1QyL5ARaxA7J67BLeJ3GBNEZnpB6KNrjY8D1kmN?=
 =?us-ascii?Q?AEoXQnM4Dm7ix0QLNyQSeUkI6ttFUOD1C06T081RYjySsGp41s7YQ5RMwnik?=
 =?us-ascii?Q?AXucWTiLUqA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cqS/IqEE5afWsEho2Z4gDthm3Wz3RfFo77ZDhgXHqQdmev90tTMK3E6KEqv/?=
 =?us-ascii?Q?kreGjpQqmUdORNsldskl4I/WXcYO2xr0KSGE0TVb5E+UU9JPkHNJObZ13R1V?=
 =?us-ascii?Q?+oBlk1RYwnLHmJy2XAVt59S2TpfNT2lkP7hDMxZJA/+zvieaYDiPtxUkNzpe?=
 =?us-ascii?Q?+Z6KxgaRKAbelcUzz5aBrsYWDnaUtTBmyDdz5Fr+eYtM1sxsfo01FTTn3yTy?=
 =?us-ascii?Q?Q53J2AmjUo2R52PIEHOA1PvTZrMIDiyrZZxHsfrGByggIb5llbQawT/g2Xnp?=
 =?us-ascii?Q?idmBu3K2Sg6FrN8kv9lpsXFP8MMqrUXNfVTJeeXL2g6E+j/qNpdeWBcCgz+Y?=
 =?us-ascii?Q?iGvU5e8rGz22nZpg+GlN1vZIfBMh+40egvz/Zp71fYoh192BySiwBTnVOaaa?=
 =?us-ascii?Q?hU7LY4+CLoY8j3vX4dSKcbW852hUyUOoDZ3qvEVcU+WaIDUxVxY0mhHo0Pqn?=
 =?us-ascii?Q?5yBDq1FoiPjssVkDCZOYB9fV12LwNDyTkXW9r5bEkg2Qu86Pbsjn7D/HC38r?=
 =?us-ascii?Q?WTC1bZbmLnccSbi6vx5qWmYuOW6KGb5F2IUm6ZkrOLSCB+CV/ud7gcSRBYyK?=
 =?us-ascii?Q?NEtuunF4aogO5MSQtpXDOUqH4VAlI5zzJdXuTk6u6SpZ4/jGz5uxEu28uGRH?=
 =?us-ascii?Q?cU/j5aErxpFHhJXwCUhtCTAtG71Z63UEQtSY1e8Wm2UYCxY3Ot513+ObG6Gi?=
 =?us-ascii?Q?CD3qa9Ghxys2h695Aj6Qqv5PsA1fX72HLVZwNOyeoDry2FerBcKWJ2smDPAI?=
 =?us-ascii?Q?wJBLmooZq2jI8vVdAwFbPFHzXJ8FJmnymTE5bqHH0M6bb0i9zy1BJ5MON3Af?=
 =?us-ascii?Q?BZIpeq+OE/NqEoDdZynwB8pVKGnIFIRWlxGj+ibCnh3OWbgIVceaSycgFULh?=
 =?us-ascii?Q?3S4y7x1Qufes5XS/KdD7WiEcJujJpohy204MZfFEBIWCWsdiZxiMveNmFEq+?=
 =?us-ascii?Q?xqCPbcIAp/xQ2x2RPrRbvBbosRMMLwD1Uu12VIfAHMtZ9ijmqMtpk8OoSFZA?=
 =?us-ascii?Q?Fnd7R4kCfbxcwe2Sf94tqewryslZwY3dVyaK3B0DSnDa6TApyj0IGXUcbTTd?=
 =?us-ascii?Q?EBsrpb/63QFCpcamTaB4Amr9g20v04N2bhXDoA2IAG9+FBBIGVDi9H7GM1Fl?=
 =?us-ascii?Q?tGSNPtcZQTkGhfVIQwfGYsOx4ajKKrB1RbZ94EHyNjwV4obiA/reqn6OJ7H/?=
 =?us-ascii?Q?ZBDpVw0z0/3SXVKLEZPxnhXHUMOYmlKUlPQIBDNNyisRut3BSWBScaaUkTUU?=
 =?us-ascii?Q?V3CdqcjQkSJg58JNpH79rjd5Uck7n4H3+qcjfo7F/9CA3EvII4GjR608KI3F?=
 =?us-ascii?Q?HGAgp6ml2ovUepvKM+B2ZaADCiGbckfH0zk25meDul32ck9LlpjwL05U1pG4?=
 =?us-ascii?Q?Wn/ZDxiLWm1SwfOrr6Z2X+kTOrLnXxt2r6TgnjLMmrjpmJrCZrA6xs7gnbWV?=
 =?us-ascii?Q?jk3r3BqogVyCuklzj0JUsDITC3X3i6xqkdJlYOaAvs3iWVOORwNYmikbDcIB?=
 =?us-ascii?Q?LY0SGjow1kS40+FiHeNiP6n4LePlsZCUtXXlAAZuMaAF71TcqwdnwalYXq+O?=
 =?us-ascii?Q?2wO0eQ3qC2E410D4liI/VljzX7WP7eucc63KvZTf?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b58113-b1ba-43f5-21e2-08ddeb273631
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:19:40.6606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHV1Sj0SLMHQDreOwYXSV9IGw2fEn/y4YEjGtaQzTwRgBwfW8Yq00tUdSmLqwcv1JCB0vhFcXZcrpkVNKp4DGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8133
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDIwNCBTYWx0ZWRfX94Zj50min0tx
 Yf8lxHynbFzIeg8O5G/SnFP916xrNkr9wo0nWstMcMFghyM6dH7jXsqgHDzFwtV8PzsnNx66Iez
 OFi57b43Q8fGbQ59FlgivWpoabWZwapOXP7Frp8BQC3kILH/dcB0eE1bJky07JgV4ZPBPwS9uuh
 TIJRqkrMUG8k0en/YmxQpZXD8Ka5exSHRM6K2fwJE59CejwDCbhYpAQpAalZkLYLJhFCDqZLQAs
 CMvqOPzNbOgYSFF4Ni2lG8PzuJTgf+FYyHrB7p0WRu2RWbwMdiWZAi1TZNRCpV+E6tRUsiHjDel
 joc4gaXHRt53z4O9gECmNaC6di2p0ZiEOJNmjdCrJWgW9l6VVb90LnHo7qIFjQ=
X-Authority-Analysis: v=2.4 cv=Uv5jN/wB c=1 sm=1 tr=0 ts=68b8a2de cx=c_pps
 a=YKFX93EuWXayyUKPW+D/Tg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=XuhTMkjeje0lLBXxpz8A:9
X-Proofpoint-GUID: KGfxZ1Dz-fRWkvtu6NCT6kpt-kQPALdq
X-Proofpoint-ORIG-GUID: KGfxZ1Dz-fRWkvtu6NCT6kpt-kQPALdq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_10,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Extend the "vm" parameter of wait_for_console_pattern() to all the other
utility functions; this allows them to be used on a VM other than
test.vm.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 tests/functional/qemu_test/cmd.py | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index c19dfc577f..8069c89730 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -144,7 +144,8 @@ def _console_interaction(test, success_message, failure_message,
 
 def interrupt_interactive_console_until_pattern(test, success_message,
                                                 failure_message=None,
-                                                interrupt_string='\r'):
+                                                interrupt_string='\r',
+                                                vm=None):
     """
     Keep sending a string to interrupt a console prompt, while logging the
     console output. Typical use case is to break a boot loader prompt, such:
@@ -164,12 +165,13 @@ def interrupt_interactive_console_until_pattern(test, success_message,
     :param failure_message: if this message appears, test fails
     :param interrupt_string: a string to send to the console before trying
                              to read a new line
+    :param vm: VM to use
 
     :return: The collected output (in bytes form).
     """
     assert success_message
     return _console_interaction(test, success_message, failure_message,
-                                interrupt_string, True)
+                                interrupt_string, True, vm=vm)
 
 def wait_for_console_pattern(test, success_message, failure_message=None,
                              vm=None):
@@ -181,6 +183,7 @@ def wait_for_console_pattern(test, success_message, failure_message=None,
     :type test: :class:`qemu_test.QemuSystemTest`
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
+    :param vm: VM to use
 
     :return: The collected output (in bytes form).
     """
@@ -188,7 +191,7 @@ def wait_for_console_pattern(test, success_message, failure_message=None,
     return _console_interaction(test, success_message, failure_message,
                                 None, vm=vm)
 
-def exec_command(test, command):
+def exec_command(test, command, vm=None):
     """
     Send a command to a console (appending CRLF characters), while logging
     the content.
@@ -196,14 +199,16 @@ def exec_command(test, command):
     :param test: a test containing a VM.
     :type test: :class:`qemu_test.QemuSystemTest`
     :param command: the command to send
+    :param vm: VM to use
     :type command: str
 
     :return: The collected output (in bytes form).
     """
-    return _console_interaction(test, None, None, command + '\r')
+    return _console_interaction(test, None, None, command + '\r', vm=vm)
 
 def exec_command_and_wait_for_pattern(test, command,
-                                      success_message, failure_message=None):
+                                      success_message, failure_message=None,
+                                      vm=None):
     """
     Send a command to a console (appending CRLF characters), then wait
     for success_message to appear on the console, while logging the.
@@ -215,13 +220,14 @@ def exec_command_and_wait_for_pattern(test, command,
     :param command: the command to send
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
+    :param vm: VM to use
 
     :return: The collected output (in bytes form).
     """
     assert success_message
 
     return _console_interaction(test, success_message, failure_message,
-                                command + '\r')
+                                command + '\r', vm=vm)
 
 def get_qemu_img(test):
     test.log.debug('Looking for and selecting a qemu-img binary')
-- 
2.43.0


