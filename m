Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4865C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklOd-0003Mm-TS; Wed, 19 Feb 2025 09:49:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOb-0003Lg-H5; Wed, 19 Feb 2025 09:49:53 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOY-0007EP-Go; Wed, 19 Feb 2025 09:49:53 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J9K12X024315;
 Wed, 19 Feb 2025 06:49:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Fo5T4wdttlCPCsIP7ttovjalrRTDCrL841CgZU45m
 bk=; b=k0XckMD//LVPgmr9cEAFCyTd/Z1/s7BK0TvIDEBVTtAod8NhjsTVEJPea
 XrY3DOdEY2yRb3SbFI27uTnsk8QqYMdvNufuEVKItpx2nvHAjAYqMp6ay3i4UyaT
 SffXifXakMWJjYZhxonvyUoZHO/nyxWMkXXp8ZKlOb8gJZb5CMoIjyGXEoGg/t54
 INUE37xOXLAK4G03FR8B7C8zUsEn+INtSCf7JIRAcTUiCPuYPyAP1+QPZ10JqS+Y
 Q+lC8eWdVuoYd82Tb/R1u2HVKxSwAEZ/4+AfNdX1NMm1KApD+VRGpxOpU4M0v1Lr
 ujey/n5g4ylR6V+ogXUQlCTMuifjg==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazlp17011027.outbound.protection.outlook.com [40.93.13.27])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4basxrv-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:49:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lv0XmS/A3oG+WnQ+y+l1n007htJx+6MatK5Kv4yjB+UnxVlGwdzmA5dtbCsQuBt3ZtKU6U4zR99kpeBhMpFpQg9vRT5OXgh7G2HjMNo1RUzfFziQtmzaJ1OLXLTqBdzAEu06727b6aDnDfLMcEuZdd2VocuUMYEnoK8Yw45uUxAmm4k4PfywlD/j7J6N5bcv28LMTDVeQI70F1FVk+fYTG+rh+uaUXrpY0NlQOnLAPj1LPEky/HGe3lPe9TwOtJ4RRujIxqG3qLfqFIEbRzl1XWz2eLYVzGjSoe5Q6WT7FtRJZoErEiTAO68CGgKje11OCDemFiKasY+VaEiDGgHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fo5T4wdttlCPCsIP7ttovjalrRTDCrL841CgZU45mbk=;
 b=VYzC0U3ulEZ2h1doTDYXbB6h4RKpDxXf0025BSF7J5vvLP5QL9KzA3mA9QIH4GkKjKxsjASJfvfNnlkINFKnV96FYW1rELM+6euxxA9cuiNNqz1NSFaCVnxABGTWD+F2fcp6Cns99N1y1e3HrFO2a5UhS6zhqigMkmrjBiKGbGPmNiBz9pPUa522NAne4K7K+RzqSfR5bFtJ/v9H8lso2AJ6OFDRqVJ+ZScySjLx1DoIdEOfXUsEVDt9JUUxaeFqf9Fy+ObXS/OF2XD9ngHcZbCp6KMQ/BvTH2ACRAog5fCY0a+4NXAtNo6utQExXHPxKA5TeE2Zej9SDFhj/MQScw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fo5T4wdttlCPCsIP7ttovjalrRTDCrL841CgZU45mbk=;
 b=VeAfjniAMIxcejWqYzAm/nO0q7ZeIymvVHsvWey1nalDdxZ2c+UrM1XL58xtPcSca5QQ5f4iYYngLqNtuARzy53ym2cK610Ag4wbF5IGI86n1JwKMWQkIEglsH6SRa6Sqv3YVQ0Z9C9lN7RljHwmpnUv2Lqr5sdDMKtopFYo5iASxHc85dpOz7jFp8OcAUROMMCplK6zsrohXZ5kGyGskqzJCij1p7+XOepjL5STvfGkrGZYBfzBNMnZ2CrwZFopV6y5EKEufeYVdtxhbu4fuOKje1xicaAIIO50X+VTtzzc6X66L4Ywdgq48b5sywb+ANFrHhcOUw047FCn1L0gpQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB10559.namprd02.prod.outlook.com (2603:10b6:610:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 14:49:44 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:49:44 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v8 10/28] vfio: add device IO ops vector
Date: Wed, 19 Feb 2025 15:48:40 +0100
Message-Id: <20250219144858.266455-11-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219144858.266455-1-john.levon@nutanix.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0154.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB10559:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f98aba-88a5-4c47-b64b-08dd50f4a5c3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P8+XPweW+iYp3IczoG0IQI3O3rpn0b4DgqBBNxQ0e7yWxgG55jHR0yrTLPi/?=
 =?us-ascii?Q?wx0Vaa6art2Q06BR8x5H1a188S0L5Ejcz1eaWxcQWHROwMb9quUx/3nTidan?=
 =?us-ascii?Q?6DO7NVxZKhr+5KM5VZDUZaaGF3FrHoeoVOgZbGRbF24DALw0t2cInuIw3jkV?=
 =?us-ascii?Q?srADoNgWMUAvRcWbMBdFBwZnNtXr7CN6tWAPuIsQ3mOXosLg1UbGVIZxzuWK?=
 =?us-ascii?Q?hA7UYqi+SHKcNdb7AHTui0yWuKRd3LHA+yqqSx4+CFKeptkCGStvTZFkytbc?=
 =?us-ascii?Q?CwyVLCbwyGXhO3ySw7/IOCZ9OECSMCioBQ9vdOLkI18eiNLxS1Fpfsr9F9cb?=
 =?us-ascii?Q?5lOqq+WUdW1CMgaCpMSbIGFmNh6m7EGE7OZpK123HntL5NvQrrNKqHws7sut?=
 =?us-ascii?Q?YekrNhv1Hw4bwEnWNN1NP9fy81AJ+6aMqQ2PN2tpR1huaAJVTU3BkheT2/Wo?=
 =?us-ascii?Q?fjMEJ6husXpY4a1zu+Jtq+TNxqP1IwGDVhDdeARnK3wGUHIHgoJZBkS4BW41?=
 =?us-ascii?Q?C2ndvBguVQCKFJmR/yqxszPq6HY7RWzvpTHivHFTrf/+XCN0Av7HgVfggTiU?=
 =?us-ascii?Q?+GrlffwTSUyz7+ywlWDW68X5pQqKv9TCUTfQpdYD3564FXsQ22WdSNWYwLHK?=
 =?us-ascii?Q?kojpGvc8nY8qS4nicWkgXF7gQdrRPVjoV72MU+UcNy+0nGC3tMrqpJZkv+vW?=
 =?us-ascii?Q?QZvITG+5QisCkXeoSwwq/eC0/1le9iy2+eRmOvYX3pguftOukDkY5HFDQrsF?=
 =?us-ascii?Q?SSIOX+ZMAul4qUrNcnuEDo97D+1bBn8LGE3gdYUbwCNaKYDBOGgCfv/bHS/J?=
 =?us-ascii?Q?Xo6cpJJlKALiqlkZA9n606N1mSfR6eOAfzHr2ltlkOux5wii54Ka6EV5wXYd?=
 =?us-ascii?Q?kGh1GEAAZiXhFZvvD07y2F7yWQg58NlnP684gU+dUnYQ6LY02ggHiS7C2r+8?=
 =?us-ascii?Q?DAzVEKHpIKjUmR+0i57HB5a9Vtdy3JiSL4Xw0tvFwEP+5k8Xp54wwx6Slx8V?=
 =?us-ascii?Q?/VR3bHFTeoUHHC78gD/la8GwlsIEYQLN6yeBAdQy0UWovhRZgtZ+Q4G3IN4k?=
 =?us-ascii?Q?Z/r27+Y/zp2zx76IeVpmbcWX5ohhVy+6bfjjKp/zbE138uFJISf3bN2SnCYv?=
 =?us-ascii?Q?DLetp2ZWXZMFhuxBEZnhr4LMd9UUGvHPU90x3dCj7wrcgRNu98lM5UypEQho?=
 =?us-ascii?Q?7ZJNVXR0/jDQTZjOtNyLkSczO/Bmr4RdvywIpdwDKAWQhS/sv2LGe84H3f/z?=
 =?us-ascii?Q?umWwyyZVT7J1xmJSAI9LdATESW+7zIlL0puVsWj99NyeeKm03/RHev8VV1ZC?=
 =?us-ascii?Q?W9WXtxxVLbQaUlzETLOBxXJQ4fMx4B4+rwzILnWBfieDImlQO2L7LRjWg1NT?=
 =?us-ascii?Q?ROUAnrD1pyvHNUUVe/dmdD5zNEJy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AcOzwbuXye3Z9H+43pepm5dnR06qqgWHF0BnR35XFV4VZVPYIeaq9U3P5sKI?=
 =?us-ascii?Q?9o4P8wTSVYs63maZ61RIEpOP+pVuvKLYe8kgZ6wNdpK3ecJLUZlX02KsvzhA?=
 =?us-ascii?Q?4b23TTjGmEqjOcxJDKSPoZ3rujSpzBQ/G+l0SSJPEwGkYI/XETLRjjI3fwTu?=
 =?us-ascii?Q?yFw4VHHPYrvwVdcrk+twDdh7fTZIAmiyRXpWSOYPoRcvdty9Gqfufnwv9XVR?=
 =?us-ascii?Q?m6NoypWl7mZ56xaJ8XR2XUUYcspbTSclZtSCMB7LE0qHv/Iv6xvLq9OyLV2c?=
 =?us-ascii?Q?RQPlgKAAHkFcyu2N0AvrauGxTGsZbux4BUE+PtERgiED0TlGTBNDtlvsJBrb?=
 =?us-ascii?Q?ZOuKk62CM2ws+kdc16bAW4fSr17lntxzOCdOhDTbgZPgK8vI9axo3c2rGPxb?=
 =?us-ascii?Q?2jLhCRk7OTlvYhA5h8NH2cL1vd8VCZRV/tMSPt4b2Ypz4Fe8NLEUH9Y3L3Yg?=
 =?us-ascii?Q?YfpAyU7F0akXxRhz2KOjF2IflPfViP0yOKc9BBAMZUKcb9o5gJsGhC9dpXgo?=
 =?us-ascii?Q?UC4Kb9UBZrquZM2hpkaGgegZDPGVQtanlp17otedhYvNXBZrUyctdIjtCuwm?=
 =?us-ascii?Q?07JOZgZdhAzI17yxA6d5d72bxAZSrDcjYwBPTKFGRfsFXOrvvCDK2VcNG81i?=
 =?us-ascii?Q?U2y5Bm8KBna3N9dHVnzz8UEVWS7djWGg96BdtjOszd7iTL7cu1x3R/oUSfAl?=
 =?us-ascii?Q?AlLlBeZCKfeAxPnMuA2RtXeNwEZOgqK5eKwfu8r28hAO4Nenl6/yQspVj7/p?=
 =?us-ascii?Q?TLyzbHeBc09Gx67VnQCM/pv28WuaicmsELk1VMl/D747x3rDdukzBDtuvWE3?=
 =?us-ascii?Q?hpK0FkdQe/ZR9kJ/Q8mx6MLEgVQ5H+aNjvNilHXeyXeC78Mb1133aLZDQ1mF?=
 =?us-ascii?Q?+3/mkhs+v01FESPh957Mg4z+bdhhuIEgqkvzeMwebjYItFXpoQgA+9r4LPeZ?=
 =?us-ascii?Q?87+jC6xRcoehhgCzceqTfAUpAzbyxvMfb5Pt/B/TBSxsMAv850PVpLV3igKA?=
 =?us-ascii?Q?o7EN4lfoV9I4T1MUH7R/kDx1A9RkdwZ+RhoHBPozy6CaohEu//VV95z9MT86?=
 =?us-ascii?Q?30RB8+pXDK5/BL8fjajGljdt1RlrqCkIkwS9d6b55GVBALMmHuH9tFZSeJG5?=
 =?us-ascii?Q?aR6zqD1rUIxvPcfOs8eBklWelKrgpeShsbByezos9HsfeLrseOvYaqr4SFvs?=
 =?us-ascii?Q?zPAdQk6HsC+9mluAcI7NxJq79DyQoBJKgx4pofn6eQnqznuynkV94nB4qITE?=
 =?us-ascii?Q?7d266L5SHd/22kmAWJ3FMrElrKFGr7vcCHO1QqC7Qc2BckBPy6mcg93jaP2K?=
 =?us-ascii?Q?karAJ1iX7zaYu4BI5G7ZtpEgBYQhwZXE6nuoT9BswEG9uVOwww3rn6z5Jpk3?=
 =?us-ascii?Q?G4w56+7P7lNU+Ta2WtS3Ptj0cdb0KorEYvZmEfZdeQkgC/UJOpK6E0TvIfky?=
 =?us-ascii?Q?39C7T3rP7A0Ir5q6N3QqRggIV8wRjLH2POrtD18TNyDv2w1MyPv3/TutnLN4?=
 =?us-ascii?Q?zC3Sj4YzJKvRtULjNocIVQlxKlPYht6TMX8TjYRjE4oluy8rLNyGtOHq+tbi?=
 =?us-ascii?Q?Lbe4If83gWuGibhEw3B+QJ6tQjdxT/1tKcubuzNE?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f98aba-88a5-4c47-b64b-08dd50f4a5c3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:49:44.1742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEo4P1l5SVj/fjkEfSt1XSWZxDs+ZyLwH83Wc28fQfgH3RbkQxzQXLKCTFx5Xcu143bpKYaB3HvQ2tuMT2dhvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10559
X-Proofpoint-GUID: C6Z3qZTNtpjrMK1HfLwvGtwYJc1FBcZB
X-Authority-Analysis: v=2.4 cv=bfyRUPPB c=1 sm=1 tr=0 ts=67b5ef8b cx=c_pps
 a=U0KzkmEawxegXmCr7eTojA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=cut_OxLeOoAalzpo9TUA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-ORIG-GUID: C6Z3qZTNtpjrMK1HfLwvGtwYJc1FBcZB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

From: Jagannathan Raman <jag.raman@oracle.com>

For vfio-user, device operations such as IRQ handling and region
read/writes are implemented in userspace over the control socket, not
ioctl() or read()/write() to the vfio kernel driver; add an ops vector
to generalize this, and implement vfio_dev_io_ioctl for interacting
with the kernel vfio driver.

The ops consistently use the "-errno" return style, as the vfio-user
implementations get their errors from response messages not from the
kernel; adjust the callers to handle this as necessary.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/ap.c                  |   2 +-
 hw/vfio/ccw.c                 |   2 +-
 hw/vfio/common.c              |  13 +--
 hw/vfio/helpers.c             | 110 ++++++++++++++++++++++---
 hw/vfio/pci.c                 | 147 ++++++++++++++++++++++------------
 hw/vfio/platform.c            |   2 +-
 include/hw/vfio/vfio-common.h |  27 ++++++-
 7 files changed, 227 insertions(+), 76 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 30b08ad375..1adce1ab40 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -228,7 +228,7 @@ static void vfio_ap_instance_init(Object *obj)
      * handle ram_block_discard_disable().
      */
     vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_AP, &vfio_ap_ops,
-                     DEVICE(vapdev), true);
+                     &vfio_dev_io_ioctl, DEVICE(vapdev), true);
 
     /* AP device is mdev type device */
     vbasedev->mdev = true;
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 22378d50bc..8c16648819 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -682,7 +682,7 @@ static void vfio_ccw_instance_init(Object *obj)
      * ram_block_discard_disable().
      */
     vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_CCW, &vfio_ccw_ops,
-                     DEVICE(vcdev), true);
+                     &vfio_dev_io_ioctl, DEVICE(vcdev), true);
 }
 
 #ifdef CONFIG_IOMMUFD
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 1866b3d3c5..cc0c0f7fc7 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -971,7 +971,7 @@ static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
             continue;
         }
 
-        if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
+        if (vbasedev->io->device_feature(vbasedev, feature)) {
             warn_report("%s: Failed to stop DMA logging, err %d (%s)",
                         vbasedev->name, -errno, strerror(errno));
         }
@@ -1074,10 +1074,9 @@ static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
             continue;
         }
 
-        ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
+        ret = vbasedev->io->device_feature(vbasedev, feature);
         if (ret) {
-            ret = -errno;
-            error_setg_errno(errp, errno, "%s: Failed to start DMA logging",
+            error_setg_errno(errp, -ret, "%s: Failed to start DMA logging",
                              vbasedev->name);
             goto out;
         }
@@ -1145,6 +1144,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
     struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
     struct vfio_device_feature_dma_logging_report *report =
         (struct vfio_device_feature_dma_logging_report *)feature->data;
+    int ret;
 
     report->iova = iova;
     report->length = size;
@@ -1155,8 +1155,9 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
     feature->flags = VFIO_DEVICE_FEATURE_GET |
                      VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT;
 
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
-        return -errno;
+    ret = vbasedev->io->device_feature(vbasedev, feature);
+    if (ret) {
+        return -ret;
     }
 
     return 0;
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 94bbc5747c..bef1540295 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -44,7 +44,7 @@ void vfio_disable_irqindex(VFIODevice *vbasedev, int index)
         .count = 0,
     };
 
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+    vbasedev->io->set_irqs(vbasedev, &irq_set);
 }
 
 void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index)
@@ -57,7 +57,7 @@ void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index)
         .count = 1,
     };
 
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+    vbasedev->io->set_irqs(vbasedev, &irq_set);
 }
 
 void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index)
@@ -70,7 +70,7 @@ void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index)
         .count = 1,
     };
 
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+    vbasedev->io->set_irqs(vbasedev, &irq_set);
 }
 
 static inline const char *action_to_str(int action)
@@ -117,6 +117,7 @@ bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
     int argsz;
     const char *name;
     int32_t *pfd;
+    int ret;
 
     argsz = sizeof(*irq_set) + sizeof(*pfd);
 
@@ -129,7 +130,9 @@ bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
     pfd = (int32_t *)&irq_set->data;
     *pfd = fd;
 
-    if (!ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
+    ret = vbasedev->io->set_irqs(vbasedev, irq_set);
+
+    if (!ret) {
         return true;
     }
 
@@ -161,6 +164,7 @@ void vfio_region_write(void *opaque, hwaddr addr,
         uint32_t dword;
         uint64_t qword;
     } buf;
+    int ret;
 
     switch (size) {
     case 1:
@@ -180,11 +184,12 @@ void vfio_region_write(void *opaque, hwaddr addr,
         break;
     }
 
-    if (pwrite(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
+    ret = vbasedev->io->region_write(vbasedev, region->nr, addr, size, &buf);
+    if (ret != size) {
         error_report("%s(%s:region%d+0x%"HWADDR_PRIx", 0x%"PRIx64
-                     ",%d) failed: %m",
+                     ",%d) failed: %s",
                      __func__, vbasedev->name, region->nr,
-                     addr, data, size);
+                     addr, data, size, ret < 0 ? strerror(ret) : "short write");
     }
 
     trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
@@ -212,11 +217,13 @@ uint64_t vfio_region_read(void *opaque,
         uint64_t qword;
     } buf;
     uint64_t data = 0;
+    int ret;
 
-    if (pread(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
-        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %m",
+    ret = vbasedev->io->region_read(vbasedev, region->nr, addr, size, &buf);
+    if (ret != size) {
+        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %s",
                      __func__, vbasedev->name, region->nr,
-                     addr, size);
+                     addr, size, ret < 0 ? strerror(ret) : "short read");
         return (uint64_t)-1;
     }
     switch (size) {
@@ -561,6 +568,7 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
                          struct vfio_region_info **info)
 {
     size_t argsz = sizeof(struct vfio_region_info);
+    int ret;
 
     /* create region cache */
     if (vbasedev->regions == NULL) {
@@ -579,10 +587,11 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
 retry:
     (*info)->argsz = argsz;
 
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, *info)) {
+    ret = vbasedev->io->get_region_info(vbasedev, *info);
+    if (ret != 0) {
         g_free(*info);
         *info = NULL;
-        return -errno;
+        return ret;
     }
 
     if ((*info)->argsz > argsz) {
@@ -689,11 +698,12 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
 }
 
 void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
-                      DeviceState *dev, bool ram_discard)
+                      VFIODeviceIO *io, DeviceState *dev, bool ram_discard)
 {
     vbasedev->type = type;
     vbasedev->ops = ops;
     vbasedev->dev = dev;
+    vbasedev->io = io;
     vbasedev->fd = -1;
 
     vbasedev->ram_block_discard_allowed = ram_discard;
@@ -749,3 +759,77 @@ VFIODevice *vfio_get_vfio_device(Object *obj)
         return NULL;
     }
 }
+
+/*
+ * Traditional ioctl() based io
+ */
+
+static int vfio_io_device_feature(VFIODevice *vbasedev,
+                                  struct vfio_device_feature *feature)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_io_get_region_info(VFIODevice *vbasedev,
+                                   struct vfio_region_info *info)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, info);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_io_get_irq_info(VFIODevice *vbasedev,
+                                struct vfio_irq_info *info)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_io_set_irqs(VFIODevice *vbasedev, struct vfio_irq_set *irqs)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irqs);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_io_region_read(VFIODevice *vbasedev, uint8_t index, off_t off,
+                               uint32_t size, void *data)
+{
+    struct vfio_region_info *info = vbasedev->regions[index];
+    int ret;
+
+    ret = pread(vbasedev->fd, data, size, info->offset + off);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_io_region_write(VFIODevice *vbasedev, uint8_t index, off_t off,
+                                uint32_t size, void *data)
+{
+    struct vfio_region_info *info = vbasedev->regions[index];
+    int ret;
+
+    ret = pwrite(vbasedev->fd, data, size, info->offset + off);
+
+    return ret < 0 ? -errno : ret;
+}
+
+VFIODeviceIO vfio_dev_io_ioctl = {
+    .device_feature = vfio_io_device_feature,
+    .get_region_info = vfio_io_get_region_info,
+    .get_irq_info = vfio_io_get_irq_info,
+    .set_irqs = vfio_io_set_irqs,
+    .region_read = vfio_io_region_read,
+    .region_write = vfio_io_region_write,
+};
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 812743e9dd..a9cc9366fb 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -45,6 +45,14 @@
 #include "migration/qemu-file.h"
 #include "system/iommufd.h"
 
+/* convenience macros for PCI config space */
+#define VDEV_CONFIG_READ(vbasedev, off, size, data) \
+    ((vbasedev)->io->region_read((vbasedev), VFIO_PCI_CONFIG_REGION_INDEX, \
+                                 (off), (size), (data)))
+#define VDEV_CONFIG_WRITE(vbasedev, off, size, data) \
+    ((vbasedev)->io->region_write((vbasedev), VFIO_PCI_CONFIG_REGION_INDEX, \
+                                  (off), (size), (data)))
+
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
 /* Protected by BQL */
@@ -379,6 +387,7 @@ static void vfio_msi_interrupt(void *opaque)
 static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
 {
     g_autofree struct vfio_irq_set *irq_set = NULL;
+    VFIODevice *vbasedev = &vdev->vbasedev;
     int ret = 0, argsz;
     int32_t *fd;
 
@@ -394,7 +403,7 @@ static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
     fd = (int32_t *)&irq_set->data;
     *fd = -1;
 
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
+    ret = vbasedev->io->set_irqs(vbasedev, irq_set);
 
     return ret;
 }
@@ -453,7 +462,7 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
         fds[i] = fd;
     }
 
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
+    ret = vdev->vbasedev.io->set_irqs(&vdev->vbasedev, irq_set);
 
     g_free(irq_set);
 
@@ -763,7 +772,8 @@ retry:
     ret = vfio_enable_vectors(vdev, false);
     if (ret) {
         if (ret < 0) {
-            error_report("vfio: Error: Failed to setup MSI fds: %m");
+            error_report("vfio: Error: Failed to setup MSI fds: %s",
+                         strerror(-ret));
         } else {
             error_report("vfio: Error: Failed to enable %d "
                          "MSI vectors, retry with %d", vdev->nr_vectors, ret);
@@ -879,14 +889,17 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
 
 static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 {
+    VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
     uint64_t size;
     off_t off = 0;
     ssize_t bytes;
+    int ret;
 
-    if (vfio_get_region_info(&vdev->vbasedev,
-                             VFIO_PCI_ROM_REGION_INDEX, &reg_info)) {
-        error_report("vfio: Error getting ROM info: %m");
+    ret = vfio_get_region_info(vbasedev, VFIO_PCI_ROM_REGION_INDEX, &reg_info);
+
+    if (ret != 0) {
+        error_report("vfio: Error getting ROM info: %s", strerror(-ret));
         return;
     }
 
@@ -911,18 +924,19 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
     memset(vdev->rom, 0xff, size);
 
     while (size) {
-        bytes = pread(vdev->vbasedev.fd, vdev->rom + off,
-                      size, vdev->rom_offset + off);
+        bytes = vbasedev->io->region_read(vbasedev, VFIO_PCI_ROM_REGION_INDEX,
+                                          off, size, vdev->rom + off);
         if (bytes == 0) {
             break;
         } else if (bytes > 0) {
             off += bytes;
             size -= bytes;
         } else {
-            if (errno == EINTR || errno == EAGAIN) {
+            if (bytes == -EINTR || bytes == -EAGAIN) {
                 continue;
             }
-            error_report("vfio: Error reading device ROM: %m");
+            error_report("vfio: Error reading device ROM: %s",
+                         strerror(-bytes));
             break;
         }
     }
@@ -1010,10 +1024,9 @@ static const MemoryRegionOps vfio_rom_ops = {
 
 static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 {
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
-    off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
     char *name;
-    int fd = vdev->vbasedev.fd;
 
     if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
         /* Since pci handles romfile, just print a message and return */
@@ -1030,11 +1043,12 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
      * Use the same size ROM BAR as the physical device.  The contents
      * will get filled in later when the guest tries to read it.
      */
-    if (pread(fd, &orig, 4, offset) != 4 ||
-        pwrite(fd, &size, 4, offset) != 4 ||
-        pread(fd, &size, 4, offset) != 4 ||
-        pwrite(fd, &orig, 4, offset) != 4) {
-        error_report("%s(%s) failed: %m", __func__, vdev->vbasedev.name);
+    if (VDEV_CONFIG_READ(vbasedev, PCI_ROM_ADDRESS, 4, &orig) != 4 ||
+        VDEV_CONFIG_WRITE(vbasedev, PCI_ROM_ADDRESS, 4, &size) != 4 ||
+        VDEV_CONFIG_READ(vbasedev, PCI_ROM_ADDRESS, 4, &size) != 4 ||
+        VDEV_CONFIG_WRITE(vbasedev, PCI_ROM_ADDRESS, 4, &orig) != 4) {
+
+        error_report("%s(%s) ROM access failed", __func__, vbasedev->name);
         return;
     }
 
@@ -1214,6 +1228,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
 
     memcpy(&emu_bits, vdev->emulated_config_bits + addr, len);
@@ -1226,12 +1241,13 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
     if (~emu_bits & (0xffffffffU >> (32 - len * 8))) {
         ssize_t ret;
 
-        ret = pread(vdev->vbasedev.fd, &phys_val, len,
-                    vdev->config_offset + addr);
+        ret = VDEV_CONFIG_READ(vbasedev, addr, len, &phys_val);
         if (ret != len) {
-            error_report("%s(%s, 0x%x, 0x%x) failed: %m",
-                         __func__, vdev->vbasedev.name, addr, len);
-            return -errno;
+            const char *err = ret < 0 ? strerror(-ret) : "short read";
+
+            error_report("%s(%s, 0x%x, 0x%x) failed: %s",
+                         __func__, vbasedev->name, addr, len, err);
+            return -1;
         }
         phys_val = le32_to_cpu(phys_val);
     }
@@ -1247,15 +1263,19 @@ void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t val_le = cpu_to_le32(val);
+    int ret;
 
     trace_vfio_pci_write_config(vdev->vbasedev.name, addr, val, len);
 
     /* Write everything to VFIO, let it filter out what we can't write */
-    if (pwrite(vdev->vbasedev.fd, &val_le, len, vdev->config_offset + addr)
-                != len) {
-        error_report("%s(%s, 0x%x, 0x%x, 0x%x) failed: %m",
-                     __func__, vdev->vbasedev.name, addr, val, len);
+    ret = VDEV_CONFIG_WRITE(vbasedev, addr, len, &val_le);
+    if (ret != len) {
+        const char *err = ret < 0 ? strerror(-ret) : "short write";
+
+        error_report("%s(%s, 0x%x, 0x%x, 0x%x) failed: %s",
+                     __func__, vbasedev->name, addr, val, len, err);
     }
 
     /* MSI/MSI-X Enabling/Disabling */
@@ -1343,9 +1363,12 @@ static bool vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
     int ret, entries;
     Error *err = NULL;
 
-    if (pread(vdev->vbasedev.fd, &ctrl, sizeof(ctrl),
-              vdev->config_offset + pos + PCI_CAP_FLAGS) != sizeof(ctrl)) {
-        error_setg_errno(errp, errno, "failed reading MSI PCI_CAP_FLAGS");
+    ret = VDEV_CONFIG_READ(&vdev->vbasedev, pos + PCI_CAP_FLAGS,
+                           sizeof(ctrl), &ctrl);
+    if (ret != sizeof(ctrl)) {
+        const char *errmsg = ret < 0 ? strerror(-ret) : "short read";
+
+        error_setg(errp, "failed reading MSI PCI_CAP_FLAGS %s", errmsg);
         return false;
     }
     ctrl = le16_to_cpu(ctrl);
@@ -1549,34 +1572,43 @@ static bool vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
  */
 static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
 {
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint8_t pos;
     uint16_t ctrl;
     uint32_t table, pba;
-    int ret, fd = vdev->vbasedev.fd;
     struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
                                       .index = VFIO_PCI_MSIX_IRQ_INDEX };
     VFIOMSIXInfo *msix;
+    int ret;
 
     pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
     if (!pos) {
         return true;
     }
 
-    if (pread(fd, &ctrl, sizeof(ctrl),
-              vdev->config_offset + pos + PCI_MSIX_FLAGS) != sizeof(ctrl)) {
-        error_setg_errno(errp, errno, "failed to read PCI MSIX FLAGS");
+    ret = VDEV_CONFIG_READ(vbasedev, pos + PCI_MSIX_FLAGS,
+                           sizeof(ctrl), &ctrl);
+    if (ret != sizeof(ctrl)) {
+        const char *err = ret < 0 ? strerror(-ret) : "short read";
+
+        error_setg(errp, "failed to read PCI MSIX FLAGS: %s", err);
         return false;
     }
 
-    if (pread(fd, &table, sizeof(table),
-              vdev->config_offset + pos + PCI_MSIX_TABLE) != sizeof(table)) {
-        error_setg_errno(errp, errno, "failed to read PCI MSIX TABLE");
+    ret = VDEV_CONFIG_READ(vbasedev, pos + PCI_MSIX_TABLE,
+                           sizeof(table), &table);
+    if (ret != sizeof(table)) {
+        const char *err = ret < 0 ? strerror(-ret) : "short read";
+
+        error_setg(errp, "failed to read PCI MSIX TABLE: %s", err);
         return false;
     }
 
-    if (pread(fd, &pba, sizeof(pba),
-              vdev->config_offset + pos + PCI_MSIX_PBA) != sizeof(pba)) {
-        error_setg_errno(errp, errno, "failed to read PCI MSIX PBA");
+    ret = VDEV_CONFIG_READ(vbasedev, pos + PCI_MSIX_PBA, sizeof(pba), &pba);
+    if (ret != sizeof(pba)) {
+        const char *err = ret < 0 ? strerror(-ret) : "short read";
+
+        error_setg(errp, "failed to read PCI MSIX PBA: %s", err);
         return false;
     }
 
@@ -1591,7 +1623,7 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     msix->pba_offset = pba & ~PCI_MSIX_FLAGS_BIRMASK;
     msix->entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
 
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
+    ret = vdev->vbasedev.io->get_irq_info(&vdev->vbasedev, &irq_info);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "failed to get MSI-X irq info");
         g_free(msix);
@@ -1735,10 +1767,12 @@ static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
     }
 
     /* Determine what type of BAR this is for registration */
-    ret = pread(vdev->vbasedev.fd, &pci_bar, sizeof(pci_bar),
-                vdev->config_offset + PCI_BASE_ADDRESS_0 + (4 * nr));
+    ret = VDEV_CONFIG_READ(&vdev->vbasedev, PCI_BASE_ADDRESS_0 + (4 * nr),
+                           sizeof(pci_bar), &pci_bar);
     if (ret != sizeof(pci_bar)) {
-        error_report("vfio: Failed to read BAR %d (%m)", nr);
+        const char *err =  ret < 0 ? strerror(-ret) : "short read";
+
+        error_report("vfio: Failed to read BAR %d: %s", nr, err);
         return;
     }
 
@@ -2438,21 +2472,25 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
 
 void vfio_pci_post_reset(VFIOPCIDevice *vdev)
 {
+    VFIODevice *vbasedev = &vdev->vbasedev;
     Error *err = NULL;
-    int nr;
+    int ret, nr;
 
     if (!vfio_intx_enable(vdev, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
     for (nr = 0; nr < PCI_NUM_REGIONS - 1; ++nr) {
-        off_t addr = vdev->config_offset + PCI_BASE_ADDRESS_0 + (4 * nr);
+        off_t addr = PCI_BASE_ADDRESS_0 + (4 * nr);
         uint32_t val = 0;
         uint32_t len = sizeof(val);
 
-        if (pwrite(vdev->vbasedev.fd, &val, len, addr) != len) {
-            error_report("%s(%s) reset bar %d failed: %m", __func__,
-                         vdev->vbasedev.name, nr);
+        ret = VDEV_CONFIG_WRITE(vbasedev, addr, len, &val);
+        if (ret != len) {
+            const char *errmsg = ret < 0 ? strerror(-ret) : "short write";
+
+            error_report("%s(%s) reset bar %d failed: %s", __func__,
+                         vbasedev->name, nr, errmsg);
         }
     }
 
@@ -2794,10 +2832,10 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 
     irq_info.index = VFIO_PCI_ERR_IRQ_INDEX;
 
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
+    ret = vbasedev->io->get_irq_info(vbasedev, &irq_info);
     if (ret) {
         /* This can fail for an old kernel or legacy PCI dev */
-        trace_vfio_populate_device_get_irq_info_failure(strerror(errno));
+        trace_vfio_populate_device_get_irq_info_failure(strerror(-ret));
     } else if (irq_info.count == 1) {
         vdev->pci_aer = true;
     } else {
@@ -2915,8 +2953,11 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (ioctl(vdev->vbasedev.fd,
-              VFIO_DEVICE_GET_IRQ_INFO, &irq_info) < 0 || irq_info.count < 1) {
+    if (vdev->vbasedev.io->get_irq_info(&vdev->vbasedev, &irq_info) < 0) {
+        return;
+    }
+
+    if (irq_info.count < 1) {
         return;
     }
 
@@ -3368,7 +3409,7 @@ static void vfio_instance_init(Object *obj)
     vdev->host.function = ~0U;
 
     vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PCI, &vfio_pci_ops,
-                     DEVICE(vdev), false);
+                     &vfio_dev_io_ioctl, DEVICE(vdev), false);
 
     vdev->nv_gpudirect_clique = 0xFF;
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index f491f4dc95..51534fd941 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -648,7 +648,7 @@ static void vfio_platform_instance_init(Object *obj)
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PLATFORM, &vfio_platform_ops,
-                     DEVICE(vdev), false);
+                     &vfio_dev_io_ioctl, DEVICE(vdev), false);
 }
 
 #ifdef CONFIG_IOMMUFD
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 304030e71d..3512556590 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -116,6 +116,7 @@ typedef struct VFIOIOMMUFDContainer {
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
 
 typedef struct VFIODeviceOps VFIODeviceOps;
+typedef struct VFIODeviceIO VFIODeviceIO;
 
 typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) next;
@@ -136,6 +137,7 @@ typedef struct VFIODevice {
     OnOffAuto enable_migration;
     bool migration_events;
     VFIODeviceOps *ops;
+    VFIODeviceIO *io;
     unsigned int num_irqs;
     unsigned int num_regions;
     unsigned int flags;
@@ -186,6 +188,29 @@ struct VFIODeviceOps {
     int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
 };
 
+#ifdef CONFIG_LINUX
+
+/*
+ * How devices communicate with the server.  The default option is through
+ * ioctl() to the kernel VFIO driver, but vfio-user can use a socket to a remote
+ * process.
+ */
+struct VFIODeviceIO {
+    int (*device_feature)(VFIODevice *vdev, struct vfio_device_feature *);
+    int (*get_region_info)(VFIODevice *vdev,
+                           struct vfio_region_info *info);
+    int (*get_irq_info)(VFIODevice *vdev, struct vfio_irq_info *irq);
+    int (*set_irqs)(VFIODevice *vdev, struct vfio_irq_set *irqs);
+    int (*region_read)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
+                       void *data);
+    int (*region_write)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
+                        void *data);
+};
+
+extern VFIODeviceIO vfio_dev_io_ioctl;
+
+#endif /* CONFIG_LINUX */
+
 typedef struct VFIOGroup {
     int fd;
     int groupid;
@@ -317,6 +342,6 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
 bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
 void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
-                      DeviceState *dev, bool ram_discard);
+                      VFIODeviceIO *io, DeviceState *dev, bool ram_discard);
 int vfio_device_get_aw_bits(VFIODevice *vdev);
 #endif /* HW_VFIO_VFIO_COMMON_H */
-- 
2.34.1


