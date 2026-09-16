Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C68C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n9H-0001Vk-Ju; Wed, 16 Sep 2026 06:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8Q-0008UQ-GM
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:04 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8N-0002m0-ER
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:01 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G89JCJ579568; Wed, 16 Sep 2026 03:44:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=47KAukU17fw16ZQnEsguQxctcBzaDB9q4df+PeVtS
 uI=; b=xAB73kb2TKiB4lf3zzZPXVzl3G4Xpciqrha9Qs3G5HomT8wjXxh6IXVaB
 XvsZj3qjW+yN6dWgBHMVnkCfOhGmGqNO7ROa3sYP5ADjQDXZqz77ThT77mX0qQp9
 tKMHyNqh0qsqoGezXo5AeNTk23n5h9YDdaBVJMm1mqTkR9oyW+iG0Ht2hW7GqvOd
 NPEmxVckzTP+MP4PCAf7ucrTUGNr/JjoyV6EABjm/xJ6uYM9uAMGuOhSYgMdhuA3
 CNYbQNt8nkJcE+rhqzHV6eshGdpmuurJCA29YV7cdfrGPkd4j1L40d0rFlW2j/LA
 jsSJqEMWrENv8PMBE2+k5eAYz8d5g==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020135.outbound.protection.outlook.com [52.101.46.135])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gqbtb9y9h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 03:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHMstPH0mNxvah2vThSXjVCT3By8Jk8irxXa7RUA6KIyUN9+BvjQRjHOsq6KsK43WVZlOEjSE5hcMDdGebfb7UrxtoNWzjNcJ1DZR0gGXfykXQc8CeXM9Vh53eLjb5zrVRniBY8gLRYIyoOLr21KXF/KwOtrlgbrC8Q/63T59UXWTuCfCiC+XftQFgEmMsEcIMQ2WqPbX0EjoLsi734mPOcxVLQRLnWv+uX1FGbBE8G+nd9Xo5TeZDELhnWExNnO8pEzRg3pcfcqpBB4VWMorIOk8KwHfNAXNiM2XWjCuWO6HpoRzNvmDBhRnCYuqvSaSEWVQwjtzvAJeUj1hXcD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47KAukU17fw16ZQnEsguQxctcBzaDB9q4df+PeVtSuI=;
 b=VrQE7dhvYMh2XtotwSdcrj/tYTgt6NeYXySxPwdl6LDq2q7TJDVkQOfeRhbhcfF4shvh13FLuZ3IgwOdS+FXawKntzTxVpElBz7l2N5Fxama02uWou67rUHprCRM1/z79dRELhXazLRSyAmSL2erkyFm9O0nk7Zcig16si9diQm4dYpo71/UtRtFUr43lGxiz+Kg5nxerlmnZv5jR+DgzBfd6Z28EL8aPXc/JBJ4vyOJGJVTvLgqhIQa5+6Z5NKQ8DXRYexz178mi7bCawhcfO4ln30oMl8YiAks7ZD7Nc/Z9mxfPc0OdhXX7PdpYfYc2ENxbBHDIZ4qCNUsGvDIMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47KAukU17fw16ZQnEsguQxctcBzaDB9q4df+PeVtSuI=;
 b=uTKuzKXlcFMjiKljBBivyj+/aUQcK49sWdOW5baDrlyw9ASGnLmAbut00+80881SdKpc73Q4pFviUCx0cH1IX6Xh191iQ2V5zCHaPktkTWh6SffIbg5BAfeJbx7dEsN6BqflGhtgxLJiWB4hY/RVfAQ0LSPsan/5z5mDtiElFLa3rRAJlXctIU8ReriiDaus2yAVaQyZBDQJRMbQFxPJaZlVPvYd5Bm74EYVDdVJ1yZ4zUruMj1+LevmShV8NsPBeb3m60yPrzzBG9hOcyVWFY2h+V9Zpk0hb2L2oATqePOKYgSmRRb6Lm52RRH/y13P9Y3tYxVve/bxsL+bum7/0w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MW4PR02MB7380.namprd02.prod.outlook.com (2603:10b6:303:74::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 10:44:45 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:44:45 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH 02/22] i8259_internal.h: rename TYPE_I8259_COMMON to
 i8259-common
Date: Wed, 16 Sep 2026 11:43:30 +0100
Message-ID: <20260916104435.600211-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916104435.600211-1-mark.caveayland@nutanix.com>
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MW4PR02MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 39542bc0-e8d3-4c67-7a01-08df13df85a9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 6vhYz4JyaWMhD5U3FnyuVC0rB/40xgbpBlxHyy7gGyMGhtlknLUYuOaWFqraZl+nmCOf4NBGZbUcPi+TOM0WzbG2Uw6YIjDRFQSPu5IAWg/dgpGN+eCOjiUvCIHu4iKe72OLEqrHpsXhkppZG+Y9nvFol19qe1KDJYPfO3wTVf/LCbEa1OCu2DZzs8W0DgakNq8tgOwD26Whco+moiyDSHs/lDsGqmL1UQ9TTQ6OIbAM4d2fJKVSG/E+UFKoQbXIBUf/c0LCsfJuq033qFXVgXMqhhwpAWTLgfWUB/tdz7h9jFbACqTKI2AUJp9qJ0JTJ8U7V2bvAWmHr9TGe53OeDy2zTgJ5Ejrw1Q+b6kmf7E+zD9sCcBQVPzA465bBkABKdDhoOq96pX0iGwew6H6KTJJXimSMk2y1o3mPK+RaMxgA2IV9j7IpOHtYFOYzZBnr95Nwcqn+TabWWtUTt65HL7sDMmhmYVvjMRH42FKxqquBa1smgMcJOGk/a/VgoeV7ZAOD8wKxnWwoBkrH2IgaDqhmSKpl98sL0zKue19FZLrt4I31uC7oHKtyzZ3TOoMtrhcV/Fnz/FGfVZPDys45JkmSWQlDgRDgiTRZ+ol0RD211oLXR+X/7eZJLnIc9kvX3MReMs2dSwyIp6rp5q6aBRLr8xLSMNSNerP+UPlGHE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Qgcxb7gSoWiqUff4CSTkHBUYrJBWlwcSgOJW/O3uhVvoMPYoVfqjVvCN+cd?=
 =?us-ascii?Q?ALLNUtWchhpthrjE5STWNTOnn/8iLGIgJLjVzBECYBnApNAyrV3e4BhiMfQt?=
 =?us-ascii?Q?blQF3B5ZPdZb9D8nsE8mHKYC1pT+aSUjDahPXMbfbcJSsZUJlk+QZ4sieJbS?=
 =?us-ascii?Q?qTosNPoPx0MDxB7JV9ta4m2xWS76ciNkMqUoog9fEWBfmH9lxRd6i5TtE28k?=
 =?us-ascii?Q?bdczvRfCnzm020T4Clwh4jHdS46EWBWr+ZDfbeCFG925wg2vRi3YP80ynXDQ?=
 =?us-ascii?Q?sIWGDarbPJI8ypGNS141W4OSpp87/eeIfCN8cGbxhvUs4dxuQ5eC5DMlKf9y?=
 =?us-ascii?Q?6sV0PzgFvpH4eXMPrXet5WRYaz6SP1z/fKVU6BJIJeXzUvoyzH7Ti289uOph?=
 =?us-ascii?Q?C/zq24G3/GMpCQ29Vb3sQ7/BHLoG4ELGoDgyePX/SDUDHMiT9mQAXn9uF/WG?=
 =?us-ascii?Q?rP0c1yomXX5msjv95Vx8ECKVpC/rForgObLE215StuRYRg5cBGAYa3MRWVHf?=
 =?us-ascii?Q?/vx6a1xnrNnW2/x90WrKx89bYvsgcXI+LWPsCWMSNabEwEplF2Z5G8ArIZpB?=
 =?us-ascii?Q?2Y4Oi5v1d8zReqvVkqwi7UWO5iZ56kATiCoDBHcjfIL+y3bthpLGacQSUKZg?=
 =?us-ascii?Q?EjSQ00mli6DwL5yBm2YezwtSU4EZJs6RnUEIr/pLuzYwCGE8da1rEjp/X9xq?=
 =?us-ascii?Q?vDeyEcA90KT/rdzTC2HHZdxdcm5XIk1LeNkubYL6miHlUvf8ROFB++1cHVJE?=
 =?us-ascii?Q?+4RugPFfZ5rB/E4iHx/y76G8dPw9y3wGbLV+ZyfiyK4SvcQvZkfPsC0UPOrn?=
 =?us-ascii?Q?AgsA6AQoeTbenzETUeH2Vol5YlOmU68tzhUo/Dm5LwWhwUsDtNH4/q5foeYj?=
 =?us-ascii?Q?QonYHkjDBhRLDvz9z0d2Z6UjB7yqm/qzI5P6pS19YpOL95iFuFxmS2YPQT+8?=
 =?us-ascii?Q?x4OHNONRtLcvJ8XUIYN60dEqko3Togvm+cev1xFTbKo2oEdHulizkodDXDKV?=
 =?us-ascii?Q?e784sy8WmtT0Oorra8eAWb1QCmwolzYyiSkBGk3ImAOxgyMImFL4DRFY/Fsn?=
 =?us-ascii?Q?tFBi0DtpvZy7xPrPJfd/pFLjvUeoA0hnVq/fqYm0LCQtZ4bCW2OWGD+V1rrn?=
 =?us-ascii?Q?M+xSOE4j/cVa7cuirVXZlxgiYscvQWSvCingJC5w4OcKtrgVVxpb8PoLwF7y?=
 =?us-ascii?Q?P2JCg2MhXRswTyB1j/xW15DzwpRybvt3eE49ycxR/Poh8DZgHyOjqdz/BhAV?=
 =?us-ascii?Q?jeFX0i2CzCp/4KNADtCQYYUlviito/JzJkjLNx5fDAJ9We0eUZJhwDPjUVsd?=
 =?us-ascii?Q?NnIbhas/aK/nbtoFPACym23rLCHdlBeBfvbD4/5P7Z8EXa/yFeXuGq/q4rtm?=
 =?us-ascii?Q?a9HBddKqUmBJxc+X210EsgrKfHyfhCLkbL9KOTYWYWtvCbU+R73lCn20H5xD?=
 =?us-ascii?Q?HauJxxIVIeiH1iMUaQm92OFXq+Y01rPn7Ehm5lPxI7Zrw3yd0sRi1n+Y2GPq?=
 =?us-ascii?Q?jQUUrCxTCsRVeqyn4jlkLH/DMpTTjt/3WzL1VDrNKLmkRS9QJPmQGmYJ5PL7?=
 =?us-ascii?Q?CKSIb0ocWs9TtvixpJKstEz5I+46vUcv9Tg7Ho7Tfw3DpgOlC4oew3ThNLiP?=
 =?us-ascii?Q?b464PbB/tXrqaIhawF2jYFqbEpE/x2DNt281HVhKIZ/oDPv2WgBqn1SGt9Y4?=
 =?us-ascii?Q?Dm36DUFTv+2u+W8P+lBn36fSIX4OhWU4YyXqro+wvseoxgqkCI6sHsEk8nEm?=
 =?us-ascii?Q?jIZI/GYShndmjiUW9h3z5tQLrR3G4SM=3D?=
X-Exchange-RoutingPolicyChecked: RqYqtDzWPAE9uZKty4+QO9eq/OFm8IQxbvTCY9F735n1ZyQIKRNEHe1bHveU1nin+yzE8PxeGhyoi/E2gFMcf91Nu7ulZRhJEjzgP9Zbxw7RfTEDPyJeHGbJTl59jsHKwNic03MPtdtb99MNQQ9VQsOE7pgzOPQP6E3awLGOiLng/Ry2K2krrR8pjbfBJ8wglHeUsTgaWSUIOta5eaBWxrhyOZtsLgAuxXw1n6pcOF66J2W6pdZHWuyO3QgfGUDaOm42HamH1M0GSt9qaS+ROWhN/kV/aaqJNhPNf6VajMIJooCRJbIT97V43O0AbL0wzRFs04Rbw/Fty2FW/v+9qg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39542bc0-e8d3-4c67-7a01-08df13df85a9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:44:45.1695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqR0BXsLOpDdDYUyi+6RL+QDdQC5Tdg/wUMbMaddnXQzLQRz43HESo8mcixC0oHYNczeDjXU0KXDzNk7vTEszgy7n0VZOTycuPtBYwPWcYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7380
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfXxzfpPlhYTKgz
 9opON5QGoH4vI9pAitfxn7VmMKcRs3GYUvj7IrEQmkcE0zu7qJf7D2dzy1PUU/wD1Vjqzp6MAyi
 xYf2F6iXGGMa2CETHOpKVCjiNcGqmgU=
X-Proofpoint-ORIG-GUID: 6GxFv3o7tf2jdG0-aexsyqUYcgSr1KfO
X-Proofpoint-GUID: 6GxFv3o7tf2jdG0-aexsyqUYcgSr1KfO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX8vn0HnGTVMmL
 qlxF0G1x6vsFtt8dEVVEMfvhfazWFXk9KGSP3GOARQGDALHQJsjuusQGJZ6wMSkZoEPShL9hSXc
 ie4obN0ArWNdEscdiSKzZ4g+MQ3ehTRglAFua/nU1OiGPgjcllaeOB1DYsmsu+37XBmEBSTjbb2
 6CDBfxOUfP9ESMWcCrT2oD5pdqrATF29v5ilMc5XbL9akTVE0+H1sBmODtpPInchReKyIWpHkGL
 RU+Zk4RnDbLgSNgD8+dO0jRCZBDDVu2Tj7Je5I/KIDtGzlmFyStTqhoh0a7txDG/7OcLsoSkmMv
 3XsLTMeY9GPHXCn8SrITMeZWCk2D/jOwOPxdkm97lLjyBX1Q1CmW5feNpxaWc7Jm4vG28P9Xwuk
 vlNpNVfhI3lounrd8WM4UFBjF9EXeNR3mLOckjoRKkiErTlbOSgOIVQviwlLlmFgJXVAkvLDgBh
 BtW4O3QGVkHZQ5kDZrg==
X-Authority-Analysis: v=2.4 cv=QYvzLcbv c=1 sm=1 tr=0 ts=6aaa731e cx=c_pps
 a=5R5l3xa2V1v4tL9kvXelng==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=xWlEjtkXqD840QCPih0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
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

This is to emphasise that child types of PIC_COMMON are all instances of an
an 8259 PIC.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/isa/i8259_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 54dc9036cf..289d08b7d7 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -31,7 +31,7 @@
 #include "qom/object.h"
 
 
-#define TYPE_I8259_COMMON "pic-common"
+#define TYPE_I8259_COMMON "i8259-common"
 OBJECT_DECLARE_TYPE(PICCommonState, PICCommonClass, I8259_COMMON)
 
 struct PICCommonClass {
-- 
2.43.0


