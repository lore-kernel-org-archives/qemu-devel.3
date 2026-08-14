Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744B2C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuq8K-0002Dk-8u; Fri, 14 Aug 2026 07:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuq8J-0002Cr-7V
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 07:31:31 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuq8G-0006hm-8b
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 07:31:30 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EAbqrM1618427; Fri, 14 Aug 2026 04:31:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=VJjg3d6jHX/KB+/1pmJ2wB+t5e0/MstLofkrILZ7w
 mw=; b=LrSAxHv6VI7BlcZVIBaJPzOm9sk+B3ItnNVmJOvaT7F9ouJ1oIf6KGJlJ
 Md4g2vzz8E8YV7dzKihsqrGInwqIi6ZxHo9k3qeBSSFlAWZXs3urjVoA5MpbApfN
 b7IgmMG7bEHvhH8oCYxHC+2pR+fvjMgNl60JlAOZYDGkAp2UQ4LCZRl2Ec5je49k
 NlwFmdar0A74BYJV5jMDkJUriR9cWqemzt+aQScGERoHspDmIp56v1g5yFHNazaT
 Vf9JPFE/yYmFV7KeG6RhtLLkmkMG0uOT0hpwXHr31BCE9RffsTuGErO0mOkoUUtP
 QSFmnYH4EN7JpcpbPOoVd+YNxXlVQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021080.outbound.protection.outlook.com [52.101.57.80])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g1nym1dvh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 04:31:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yr8ZQfy1rQXhE4kmrsS7u786sdJpAvk9Q/Pe+ceG7vSUK5qKdQgjCM57PMzoduxJRdwuSLuxHzChz4OHyMB1w60XjwgO1Kw1tG0dwCOo0wEEFdgSH6BF5nHP31Z1dEIXNLC7ELADwDoO+1y0FtKtPcSB/CN8GjbYKxFvrEQUyGFEPV7NhRG4vVUv2GTLSSYVQSLgJN8AH0R37ic10q++xbL23X7X8Ol7kS9/ncgRmkBl9nBjhLt6VZLaxpVhOmNvJaLyn0DVyxGsfJsCrRprszbmeiAm1AVR0WBgldnd/DJYZpzksgOSn0u/6CvAOFLVGCgtIRr/NSc+Gta//IYTUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJjg3d6jHX/KB+/1pmJ2wB+t5e0/MstLofkrILZ7wmw=;
 b=UxpPv5GdWbatFCT5fZmsZrb8ZQLeSikox8PVM7Ie2sTdfoS9merVQN8pNkH9ds2FG6cF0flpADJBVYHfAALIYdCssR8DQggKhqi4egq/heGHJ31pSB3XVArYveO0LKcwAJdCRzsglX3d3Qoe9fG/s5v6A0QInL2J95nsvXckVgICGLqrC1yGARXjZifFk882x3zT/gRxKo/Ep6zWeCtLvoLI/iyJY9UbRTS2qmwqUay8SrQ+Nn+nSLhEhzkY6a23ry81MVycQGi/byzKNFLFmemOGJVbSbcI6DncFHbxaR4C+Fqn8US0gR7SvS176qBUVoyUw5w0tW7zEouZHMm5aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJjg3d6jHX/KB+/1pmJ2wB+t5e0/MstLofkrILZ7wmw=;
 b=i3A09lzz8rGlsmoa3ttMboZ2EeZmR6/CqK5oGmgZe8IFdHJ1LVdZLqIYkva5FtJhAMfwGtHF91x+FXCGXh4GpGh6nW24EUBE5T1zABvEhlDteSvPPFIpv5R1CDjCekJx1nhEr/g/jpsTwoCwegPWaVmKelL5WkrjtHK5ihPX3IqQ/AA+45LzNNafuYnSxH2CMPqH3AWUXkVDdi8k2znXWQWRu1vGbt0xF1m+mhQTtRmJ4sSi8t9GX9d9ThOlAIEwJSHsJzdBsi7jbwTzuaTYwvHmr+1TtM7QOIje4y+5tvw77hD2grncjJLSgPJSASIzG4wRAEfU1+djhhESTWzmOg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA3PR02MB11199.namprd02.prod.outlook.com (2603:10b6:208:542::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 11:31:23 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 11:31:23 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 3/6] qom/object.c: introduce
 DEFINE_OBJECT_PROPERTY_SCALAR_METHODS() macro
Date: Fri, 14 Aug 2026 12:30:21 +0100
Message-ID: <20260814113044.2416794-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814113044.2416794-1-mark.caveayland@nutanix.com>
References: <20260814113044.2416794-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0088.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:345::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA3PR02MB11199:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9991ac-b308-4744-86e5-08def9f79212
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3jwBeXUmf/SFdckIcjTzG6XubLFICwaXCJ+PaXWovFHXfNiw4KfRlD6VUkuFoKeufJ1s/Xw0kajobw9EbQYsuCCAXWj6fVJnmEqyaEMOUz9SExGf+fqRIAkQj0jsWeq4kLMaNME7afjXr/YWudEWYyUHjqqd9iEC9SA2CMlWVMBX7SnhRoJnuV8Z22mFiplTV3+BBnUIG7kFzxrO6K05N42OZ1ImcfeM2cqh6gKFe7fmJJJoH95+7x/1iaruhJE7cCLKuXN2MIXKiSpk+kjMqPcRDaVyuBXbpPJQgpnsTf6TsOfVyDz6+iG/1AREdGdAO9P0GGip3kPDCniY607Tm2HsmEFMU1u9dT06U2ULN9U07/7DclRQ7ZPjVz9IVsWQM7f0SM+qHDH72YMiRaN7dfbE6A7r8ki6Ywf3eOFzHITM4gJfM0jvKmjXtcYoQVUPag72dtD6vKQwsy6TH7C0dD+HDBwf9KO9IkhfvqeEnfv8e1ts6uAb1MmeZCbssqX7gaDmxARXJi6t0jOHDopto/ADVmNfo4cjpPj64IGQ65yiDgvQOVTGc+vktgs9E7cxlJiIChuGlLFD/kIMx8xHEbnTqhzCF4goEcAz/nyVPAcQMit4nbne8RmUU1cS2V25L0N6VNf/ks5WkSaRI3HXuDjxQ+NfoK5SWBFVe4AyhJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzBQQUpiUHdxYU0zUmJGM0sxRGU5QVNjQk4rR2U2dUE4V2tGSlRmU0NVZmJX?=
 =?utf-8?B?azB6dGNrSEVhaCs1TGp3TVpWRmpYU25wS0tVeDJDS0ZBaUREUElVUVFXZWNL?=
 =?utf-8?B?ZDVJU25VK1ZjOStBWFo4NVlhUUN3VmRuTUVGdTNsdElsM3dSdFlmWC9sUFpO?=
 =?utf-8?B?MzRmdDB0dUpuRnJlSXBvSXNBVDRoUUNlWHJCYWRUZERrblh4RFUzTTdHMXdm?=
 =?utf-8?B?RG1xK3E1MkgwY2hTcmpDeERLVWJxYXpDK3ppRTJDRkZHMEphK2d1ZlBNQjJF?=
 =?utf-8?B?elVadllVUkFsb1VGR1VOQXV1ZVJDK1lEMjljOHFpcW5iOXdNTGFIUzR0UzA1?=
 =?utf-8?B?QnFVUHZudnljWE5FblpPN1lVTUFJNmIvdDd6RTZFNnc4VWJEUWN4Y0cvbE42?=
 =?utf-8?B?MmZTZHVmbGdVa0NKMVI0TUNoZjdwVmlpNUVPQ1dtSnkzNll4S3IrQmYvbVZR?=
 =?utf-8?B?VmZTRUFZU3RBdEVJUUtib2VXWHpzK3JNWXZNOXc2b2F6ckRwTGgxNHhXTGhI?=
 =?utf-8?B?Q05ZRjcrclJ6ais4dUdXcXl5L3BQM2RvMis2OVRxNlM4NGpTTUJrK09YOVBz?=
 =?utf-8?B?V2l0bUZQUys1cVoxUDhHb094UmJXMi94a2lqb1hHQVZSNHdJYzFoSWNUUFV2?=
 =?utf-8?B?TjZsVm9aVFg1SEVYbDgrQ2pzbEF5U0JPVWhxYjBlZ3A3RndXQkNia2pwWDh2?=
 =?utf-8?B?QW9DVUtRWUhQcVFhMmZaODJ1ZkM1TmF2OW1VUTIrZEFGMjNWaldoZXM1U1NJ?=
 =?utf-8?B?N09rK2NyUU85MnpyTXpiaC9iaE1jWm9lalBRVWlSMzkrYld2VDJJcjNVemJi?=
 =?utf-8?B?K3llMmx2RUhiejN3c1N0cGZwSytIVUtmc1RIR2NDWnBqY1A5S0NVRVYyVnBI?=
 =?utf-8?B?Q2tKVHBoYjI1V3hsTUZsN1ZWR2pQZUVBMjIrZE1MYWQxTm9VVnBKMUNiOEla?=
 =?utf-8?B?ZUwxZXA1TVNyVEM2ZzAyL2tFU2NLV1ZpZnprV013UkZxblpBZ1dzUjNhbCs5?=
 =?utf-8?B?d1ZCbmJyTjhCMmZMRytkOXNsQmlZVVlPV2k5NWdGRzBTNS8wRFhEazZENVoy?=
 =?utf-8?B?T3hnekNveEVjL0wvN3pId2RKNW1NcnMvd0JvOWJkdElIY3R5WXQ4ZjBjaDNm?=
 =?utf-8?B?UFRvN0NmVXhESGlyYW1KdGNzLzF4M3ZaU3hlK0JGZ1pzNHZyTVl5VE1OTThz?=
 =?utf-8?B?b1ZNKzMzWXFDamhxd0xzMlozZmFvS3ZOWjVQYmVUWnlKem9maUg1b2lZemxK?=
 =?utf-8?B?VkxsK0dwMnpZR0srZ1l1QnlXSmZTU2VVL29lYlNSSzBla3N6Y0wwVDBMOXU3?=
 =?utf-8?B?K3VqR0NqVkhhdzRVMm16TkNBK0EwUjkyMTg0SXl5cUZmTHpxSnZqQkhzamp6?=
 =?utf-8?B?WklMV1JQWFhMczlHalU5K24wQlZJdUlBcEsvczJ0cS9tSzcrU1labGxDTzJO?=
 =?utf-8?B?cFNWNzQ1d3dkRXd0bUcxcVZMTXJwU1hPMlJIaXQybFBLWHFwQ3NQQ0VGYm5G?=
 =?utf-8?B?QTR4eHJNQWo1OVJldGU2d2orWFRjTTZ3Qkg2L0dJWWNyTlBJSktjL1FXeHpm?=
 =?utf-8?B?THdzTkd3OEFmQ2FPaUZDaWwvcUxuYmd2dmdLQzFJTXZ5aXBqZEhqYndNMlJF?=
 =?utf-8?B?N2Z5RkF0eEJsN0NhMWwwQVVleWpNd3NZQktWSnVBNy8rM29IOTQ2ei9Xcjgy?=
 =?utf-8?B?OCsvV3p6cURYdkdCREtMYkNmNGVjb2pIOTArSEplQktFcEh2TGhVWnNCUGd3?=
 =?utf-8?B?TER2d3BSVGVHMWMrVTN5cDJhb014VUFzckNDSHByUVorVUtUVFRreVMvWXN6?=
 =?utf-8?B?TWVsYzZncytBV3UxYkg2U1ZTcXQ0VlE3MHBKUjFDZW1uYzN0V1hhWWM4aitY?=
 =?utf-8?B?bDk1dUJtUy9sYytQdlFqR1FiNDJCeTJiUCtMZTdaMTBUY2ExY2U2SURRK21G?=
 =?utf-8?B?R2w1TFp2RkVUMmJQTUVmbnFvaEpwNG9lSzYyYVBrc2orZlJSR3d3NTZPRVpQ?=
 =?utf-8?B?cnA0WjdXUHhnUGJ2SWZCTG02K2V0MTlEdmVZQmZtQktGem5YQ2FpSk9wZnRY?=
 =?utf-8?B?ZkVUbW9abmM3WE9uVlVjdFpXRGs0NHBxRXFiUG1oVGZXaGhhZENIM0RsZHA3?=
 =?utf-8?B?R0NWZXV3ank4Yk5mNTZWNFFmL1o1MHpsK3Nlc0dQMVdXamE2ZFNUb3NXcFZL?=
 =?utf-8?B?Uit5VWVkTmtiZDhpV3RhRUtWNzVNNWdmNE94bnRpRFhJWUFXRkZRV3NIcWtK?=
 =?utf-8?B?QjRRTXdHVWtPeDhoNElqMjExc2xpd090TGs1NkdjaDVFdVovZksxeVo4Z05H?=
 =?utf-8?B?RmtYWFJYNlpXSlI0c1NKVEMrYitRZmk4cjFRSnA1b0ZRRXdEa0ZPdUNoaDFw?=
 =?utf-8?Q?L+pGtEYHSauO65mM=3D?=
X-Exchange-RoutingPolicyChecked: BlrCIRKZOBWNT6mAwdlBc2gsy5kFsUbfZh5Npg7eB7gb27f8S/N5hG4I4y9y4sQzALKkH781GrdbvQd4swiNTeuzH92jD74xx2ilRljpT36uiPsXz7HvMEl1TNYTNU1GMQ2D7CydWMCfpi2GQLjoweziDErW1P2xhdrbF2ykETh/qOBDkcbXL/8XCVD09TJuMGUvsOyWtiMs90VPKHa3vSllzB+2TPeccU8xd8oFq+C3vLUcu+OVyqsYC32hW5v0BtHx5POjKPv17Rzhf0svDA8lSoI4hFyPpFkesayBskz2ooIAqE2b+57nTbF3P1cOxpB5qCyxZCHkt2eQsD6C3A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9991ac-b308-4744-86e5-08def9f79212
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 11:31:23.8038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKsvj2ZjCaEVDnBmsKAvyEp9Ekhxzd/l95uteCNocCpc07d70Rkvy24n6051dd0mtwVEcFfOs6n+eZgYvhXTVRayHI4fAbDnUGvFe62uXfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB11199
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA4NyBTYWx0ZWRfX1L7Qnfh1skO7
 EdEpSIZcdPFXspArFilTvSu9T+3hoDYHVUo7CcwTxtTh/nDvhU4a+gzLQxIeTi6f6v96Gp2cdxs
 KVY1NCE2oiazCLoWs8Pj2NwjjoozT8I=
X-Authority-Analysis: v=2.4 cv=YP2vDxGx c=1 sm=1 tr=0 ts=6a7efc8d cx=c_pps
 a=ODHLhvGZZr/oS+ofcGj7zA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=kLGNbyHpIViufWfsSGAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA4NyBTYWx0ZWRfX8eigdcFFkAz9
 rMh6WH1MszkQHSFojJbBykwcp72F/yQBZ/JjdxhPCnpDBVFdc61qv/ikV0CeU+ZQQSVQMWISdd9
 ZNxPP3hFj1oUejxvgcM2hrFLQVl7XOQs7lp7K+AVcgJv5pqeF+00At+vMsrkzWy4RUL+DxITJFc
 BMLPPgKn7E3OiTqwcVp5nVX6vGeZkXkKEP4GwQo2BybLODhH6Dd2mX0i0zBCxDAWyXz/8x3bfAl
 Yl9CuqIsNJJfKr8LFJ6Fugk6Z43U4PANqbbQ+gPRDOXdUVAPpANbKOX2tSdWL/p/Y4K2Rsr4TCY
 CwEdqdm/mEyywTSN1u0h/asIg4EU0/wmdR74f7skaZsdLcT8AAt/Qrelp5wn7IlvKwL41kTvvuu
 ui44FHcQBRbCBDt7QanmsItHKly/T9o7R7aK71e8QZZ/GdGi/pJgcerX+qDpgp7BCwVzcc46ifa
 /0Htwc5sEJ34jMro6Aw==
X-Proofpoint-GUID: 9NRdR7nk2X8-9ZVMMVhf7MBrbUpvwapq
X-Proofpoint-ORIG-GUID: 9NRdR7nk2X8-9ZVMMVhf7MBrbUpvwapq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.751,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

This macro defines both the QOM get and set functions for the given scaler
type. Replace the combined use of OBJECT_PROPERTY_SCALAR_GETTER() and
OBJECT_PROPERTY_SCALAR_SETTER() with the new macro.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-Id: <20260717135254.508701-4-mark.caveayland@nutanix.com>
---
 qom/object.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 8a1f80f613..622840f9f8 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2687,17 +2687,20 @@ static char *object_get_type(Object *obj, Error **errp)
         *field = value; \
     }
 
-OBJECT_PROPERTY_SCALAR_GETTER(uint8)
-OBJECT_PROPERTY_SCALAR_SETTER(uint8)
-OBJECT_PROPERTY_SCALAR_GETTER(uint16)
-OBJECT_PROPERTY_SCALAR_SETTER(uint16)
-OBJECT_PROPERTY_SCALAR_GETTER(uint32)
-OBJECT_PROPERTY_SCALAR_SETTER(uint32)
-OBJECT_PROPERTY_SCALAR_GETTER(uint64)
-OBJECT_PROPERTY_SCALAR_SETTER(uint64)
+
+#define DEFINE_OBJECT_PROPERTY_SCALAR_METHODS(type) \
+    OBJECT_PROPERTY_SCALAR_GETTER(type) \
+    OBJECT_PROPERTY_SCALAR_SETTER(type)
+
+
+DEFINE_OBJECT_PROPERTY_SCALAR_METHODS(uint8)
+DEFINE_OBJECT_PROPERTY_SCALAR_METHODS(uint16)
+DEFINE_OBJECT_PROPERTY_SCALAR_METHODS(uint32)
+DEFINE_OBJECT_PROPERTY_SCALAR_METHODS(uint64)
 
 #undef OBJECT_PROPERTY_SCALAR_GETTER
 #undef OBJECT_PROPERTY_SCALAR_SETTER
+#undef DEFINE_OBJECT_PROPERTY_SCALAR_METHODS
 
 
 ObjectProperty *
-- 
2.43.0


