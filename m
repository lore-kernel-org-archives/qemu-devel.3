Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D06C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1OQX-0002Fh-Dz; Tue, 01 Sep 2026 09:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1OQV-0002Et-Ls
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:21:23 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1OQS-0007yJ-Py
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:21:23 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681AILpU2242870; Tue, 1 Sep 2026 06:15:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=rZZEv29BB6d2bJEOVXIRmgcs/EeaGUVIWdg+7lyX3
 +Q=; b=L8v6DZZ1et5lMIPdk0JFBe/PypcT7VGBV/KyUiLEHFbmbUJESr6NCGR4f
 DHy1Nc+bL/7XPycsQ0mO8MvEOxzWP28Gw3Q7P8LTJIVTzM+ggCdGUYL78I6YxTq7
 yNYpQZ5umyH+N0LiGr5MylDq9YgoYgzxpgEiyVdayNzgvMMFJAF+jwrNIpZNCmZb
 HSx20r9h7oyLfvtv2biYXqmxuq/dv2XyrYPHx6T2DyVQ4oOyjEZNxZRCRumeOtnA
 PnC1PjoebTakL/Qh7zaGXSiQh6EOEHGKu5CjB56r0W+fjLhvi138mkTDjk1Azb3n
 sSe4sChAC9kW3rlgsW5Rv8KpflN8A==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021084.outbound.protection.outlook.com [52.101.52.84])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gdhhxhy77-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 06:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvdZzv9kalIeQompV3j4ig/5++9x9erQFG00fgWtdx4AhFu4a2VjQDOR6qLF6n15v389Nft23ik1VYyAuyKVKESu4KqxzKKbeFL6YyBWtt3fNxaZMQ/sc2XAzOloVpCYjC+yTTfiZB53aF/T4ONPZQtZx0aRYF1lVoGUPcbfMd3iVc7MDIFjM65SxZnIdC98omEcyT3Xu6ICGgEGSYFaB/B+8bHq/nrqK4Wn9fMLz6b/FFClq0h1VEQvnuEAKBXfIRvlUekKx1/cpBG4c72bShyIMxB41UBwTgAF9scrd0KBeR5gclZBzOmh+uYzFVDtH8ZIfB1N09pUiB8Ha4pTtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZZEv29BB6d2bJEOVXIRmgcs/EeaGUVIWdg+7lyX3+Q=;
 b=sGwOy4cmS0VQHoO/niTcynnJioWmJqKHtMRKI2nZJIjxv2LRRf+W+QRxlDtcxbTEsqm1Jn/7irrsEIDPczUHmfzQA6+7l+ptfnZNYWM+jyyQ0Lec/bmvkUWLkiJJIuUSLNbrMSU7/iR+8VaIJKcwDflKMqaXQnO5/1o7cDXVCUOkzA3omwQ9D2pjJrWS+MaVI4NcmLSXyCiKB8dbn1HeSNkHPrO7rEVNHmdUFdvDmRRECDHpTZ1AXPQP68qfdPPKE6D4Z+4c7yydu5Z0xkePLWdgU58H909DHg7aZmtYfDbZhaUJbAC9nP7UiB5cDawx2kYD6s7ksxFTAbGyx8MdFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZZEv29BB6d2bJEOVXIRmgcs/EeaGUVIWdg+7lyX3+Q=;
 b=HWKaYgKkjyTWGOt0gYaUX0cS/uorl7J7ohriMJb7oFnnp8tkfjnSLo82rJQKenfIiDblKhhnBYj3JPCH/6UjGt1a/mqlWjUs68wwAgfVcxIkJTtHUid9k2gC+/ei+4rscLMtaij0Ez+C9Au2W18eWRE8bWOEFTOZvwHmnG19NFKSEnGDHYB0favKBb8YRCZQRYuCXnY2c8h3gadXXhv3iV945/YiSStVPX4yn062CFc+xTJji58vgsCpMcczb/s5V+8U1KfP3Bxo7zyKrdCbNPhJzIz9EYdcrde79wZrTkAN5DPaNWc+QrjuMZpxDfY8D7krfoi5+gy2EfDBwr+b0Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MW6PR02MB9861.namprd02.prod.outlook.com (2603:10b6:303:23b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Tue, 1 Sep
 2026 13:15:32 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 13:15:32 +0000
Message-ID: <062cc68b-8f32-4a42-b885-4ccd206524e2@nutanix.com>
Date: Tue, 1 Sep 2026 14:15:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU community call tomorrow - agenda items?
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, cw@f00f.org,
 dbarboza@qti.qualcomm.com, Demi Marie Obenour <demiobenour@gmail.com>,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>,
 eblot@rivosinc.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com,
 helge.deller@googlemail.com, Alyssa Ross <hi@alyssa.is>,
 iggy@theiggy.com, Warner Losh <imp@bsdimp.com>,
 jacob.oursland@gmail.com, Jan Kiszka <jan.kiszka@web.de>,
 Jason Gunthorpe <jgg@nvidia.com>, jidong.xiao@gmail.com,
 Jim Shu <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 matthieu@minio.io, Max Chou <max.chou@sifive.com>,
 Mark Burton <mburton@qti.qualcomm.com>, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 utsingh@redhat.com, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <877bl6eoqv.fsf@draig.linaro.org>
 <2e826f6e-28be-4a2e-ba20-725b293d24d7@oss.qualcomm.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <2e826f6e-28be-4a2e-ba20-725b293d24d7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::31) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MW6PR02MB9861:EE_
X-MS-Office365-Filtering-Correlation-Id: db7e7cc6-762d-4d0c-5ba9-08df082b19ba
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|921020|10067099003|4143699003|4133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Mri5NkHtz/xKFImDRZts3CrU9jUXDKZMI+jm9wDgPiSwXpGSUtduatHoaoehuubL579pGCQyalWnGNGzjgdj80RmcDF+9ZAvthakNITcIhDAKWjW8SOSqo2EV7gsAT2ylcTp1Zx7u9tr4X84RLDmbl/JPXjWHvMaYrKv4zp5rlvGQy9pwJwBQnxFwI3QzrI+HUn1vTCah/iHbdEUV06mk28WX09b+qXSqfTBf9VEEgnFR7I1fugQ1v0XjFHV3s+QLtQcERUyq5PjhDe7PUwovMrgKqxnBEwTaJP09kmKYg8ozosduE3Yy7uOCYKVrJxbHArNMAQy/1XT+ML4f4y86bkLdNk906FFT+DW9Emavnz7sdtnZeF6L/90h4IRrMgwKS1tTPJcPEOKR9Fc+roPk3H6mJomuIkTb6LrNa89jym/D8ds0qtTBpFUpXxllwgPHxyunSjN4+3jptep3OPdrIRHPqBv8bhgSFzo7UDur02V6BV50NMGizEqDMftYUjPCobRq/KbDJFLhKOLHxpV9qzwyYn89Tx/exzw+o8YTGPAqp5Q74zdiDjdlG/yw9hYiLr4dgMq+PDiQNk+tmlxgs7jMqEiYpU7tPPaJKwtUU4kM/R/jYOWBXeAPD9yKabM7gD+phX1uFpRKMz7/xMqVbVP1aCBvRsqb5qcDUdAYd8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(921020)(10067099003)(4143699003)(4133799003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1ZMNkVMd0ttY1dQSHE3Q0hsV0Nab1pndzQvVy85TjN4RHBubWtYNGdDRnRq?=
 =?utf-8?B?bk1rOUIrMGROK3ljQWZEUlFvSndZM213MExOUkhMMWJrNEl5K2d2MmlIUFF2?=
 =?utf-8?B?VlFySTJ5S2plWXU0MXJFSzdBKzhyUENUMVU2TDVnWXcrZ25ZS09wSmlYQlpQ?=
 =?utf-8?B?NDNFTktXOC90OU1Mc3l1cVRVQ1hhbS9YM0dWclE4MFdISm9oMTEreGEwREN4?=
 =?utf-8?B?VE9BOTZEdnRCVXhvLy91S3pyakh5OVVvWTB0dFRtSVQ2Q2dPeU1vaVppTDZ5?=
 =?utf-8?B?V3NZdnQ1REU5VzFYbldvQk9IMXdlQlNlNk9ZSkF3UDhnZDIrWHZWNTVPSGww?=
 =?utf-8?B?UklzYmdpUkpCMllYbzJ4NjVkSmRrejZOM29NdDNmS1JYZUNJYzZibzVRVFA1?=
 =?utf-8?B?SkFpVWM1WFg3RTFQM2N2bUJpY242eGI5SjZWbGJnazFIU1YwRjFMS3gwTnZ2?=
 =?utf-8?B?NFFrOGszbU1MVEpFNXVMSW1LVFo4TGpPZnpGUkJ6NXlFQTRocWVuZDVLa2pT?=
 =?utf-8?B?YkxqT0JKMTlVRnBEeDZWTndTTXJDK2JlMmt2aHVHOFNvT1JTTWRwZ0lEdkx2?=
 =?utf-8?B?OVBlYytvaWxoVCtBQlVFQm1rcVJTOVR0ZWlmRVhVOTk1V0dqa0ErTnhPZVVl?=
 =?utf-8?B?YjU4bVNKZXlxbVFXU3dPWFVWM1VUWG5tclZmQUtKby9rRGF3ekFISVVzUE5r?=
 =?utf-8?B?K1RRbm1hdzFKTngxZGZ2ZytubEQ1RE13Ukw3Qm9iazJjejZPd0VEUHY0M2tK?=
 =?utf-8?B?RTlQWWFYL2hYSUZsYm13THJHbzNZS3NnSmpEOGVMWHVBamhLQkNGRnl0OE5X?=
 =?utf-8?B?OG9JZUVoMmhLa3luYXM1TUpEK2tLSklkbG16dXJXSGN2WTdyWURSZVl6a1dx?=
 =?utf-8?B?MDVRS0psRW9Zc0kyUHFtdmxyWkhYdWhuRXNUdWVhOUF2TXZ3NmpyRHp1WmdO?=
 =?utf-8?B?dTJFR0tCRis0RHBPT080N1hIWHJVaHBpdU11V0VpTzl6QStuNlhOeE5uWWQ0?=
 =?utf-8?B?L2x6YkZRLy8ydEdEN21rTlJuOFBVVzVqTmlaR3ZJOHdJRGg2RWhtL1MwZ3Rv?=
 =?utf-8?B?NFVaMFlWK2l0VVZsUDhSNFhYd3FXMzUyT1Z4bWx2UUZ6eE84S3d4VGpBbSsy?=
 =?utf-8?B?QU9uczBMSFQ2WG9SZHBmZUxrZ3ovU1ZPaUV4dHRrdGhHTzZta2xkK0YzOU8x?=
 =?utf-8?B?ak0xQ1Ixb0k4MFdqZnRBQ213b1EzUnlKUTV3WnRZZWJtTEJWT1VkTWJnUEN0?=
 =?utf-8?B?aHNYb0xBRDMvckRGaC9way85OTdBQUVpWkxLd0JVKzNxcTlWbHNXLy9odjBu?=
 =?utf-8?B?RzViK1J0R3NqY0pIaEtJVldRSFpCSDhZYmlIckd4WklqemZ1cEw0cWN5TjlW?=
 =?utf-8?B?blNaanM0QWtwdkl4RnkxKzBJNndheTFXREt2VUd3MXFOa216NnRtWkV0cURr?=
 =?utf-8?B?ZEp2NWRxRkNwQm0yeU5zNGF0ZHU5M3FJeG9UWWh2d3VLcUFZdDZwM2c1aXZW?=
 =?utf-8?B?NUx4SHZKTUs3YzM3MkEyRWw1V1hRL0drSXU4SmlJdUppUjBEQXdMeXhoZnpQ?=
 =?utf-8?B?L0wrSWdoK0VrRVpBYkgzNVJyVnVpczBSQVlzZ2Y2VjlneExzZzkvMzhnWW54?=
 =?utf-8?B?WkFiSlpQVlpzVFcveGdIVXlQdy9ZOEpOcEpSRnM1NUhOLy9DQmdCZGU4TVdW?=
 =?utf-8?B?a2QyNDBiZDNpdGpDTlNoSDNmS1pYVHQyS3VXKzRCQzBPVTlYNWIwaTFkdUsy?=
 =?utf-8?B?ZHE2TkFQa3MzTnlDQjNEdjJoR051TDRNYnJrV0lzYmFKMXlmZUJQTHdYVUl6?=
 =?utf-8?B?c2czSEJ3UGRzR05wY3BXN0cwTHlyVitnblF2bXJ2aUV6ZVVVeXB0RjFQV2w5?=
 =?utf-8?B?dXh3WDB0WkVDbnVseC85aTF6cE1ZdnlFZUVyZVZXUW54MUExM01lU283cTZK?=
 =?utf-8?B?UlRoanJvaUhWc2NWRGcyM1VtbERwWkoxZm5RQ1BSS09oTE5VTGNzdnZDT203?=
 =?utf-8?B?eTU4bmpNUUJHY0pjN0x4dmVoSE5hUExRd0hSMDlOYk5HWjRpcWVQMzJEcWhp?=
 =?utf-8?B?aUhqYjdUazZjd1hDQTlqbE90NVFKb1N4SnV5UG1tSDBaSThZTGcyczlVdlVG?=
 =?utf-8?B?VkV2QnRrejJtazF4S3d6a2xxK2ZiMjVpbnQwTUViVi9CTFRWMWxJQUpuRzVT?=
 =?utf-8?B?eCtJTDdBWGU4ZkcxQVhySXdmS2syTmVYVnpNc1dVQW1BUm01UmNUTlg2YzVi?=
 =?utf-8?B?UUhRZjdJM2dOeWhhK1V2SmtYSmpoaXRMbGdpRU9VV1QwcGFua1NEeThUcVQr?=
 =?utf-8?B?WmI3bGpDWkxnWUhsaXJ2WDd0cDdsMjdlamxIYncyWS9mamI2SXVybko1ZzR5?=
 =?utf-8?Q?exJKkvyQfeAnstCI=3D?=
X-Exchange-RoutingPolicyChecked: s78YAXIiIoiJgwoHESHuYLL46XVo8NrVC/seL/LLOkX+agxA2jiNJNSQSV9THQwXtTBf4rudc4DdAfV9a2gbAQniGFeppxNODnZ8g8ft5VkjKEa64qrwq4pmEi7yW6cg+GV8+xk9nzCx5jRaslnThffJi0y6ozNaW1cXjoHOkgn6035Pzc7ztfJ5STku5ti1ykjrIRQ7IAntOEj7snjqOAWqQ2sxfALzrW12bUL1q9ggPkUaGrw607douGXAG/e69Xr5m0Hz/sS4krdt7uFhQqVeLMdFsoCVRmUrG4xLBZ/uJtBTDfVEox9DtUuRaMAk0GsB4kjH+cx8AbA9tfA7YQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7e7cc6-762d-4d0c-5ba9-08df082b19ba
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 13:15:32.0042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6H0fyYuMzxkokVMoQAqm/GMjSfyHjF94y6nbKbPNdBbVwBLeaF+4RrZZUZg74fwPLNVronth6P4GnSbz4XmirjSNf0fm/lvxoPcKm7iH/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9861
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDExNiBTYWx0ZWRfX9OpUbJSpYBX/
 U8ODzivgbgU/geBztfAIgEpMBXKi1hOY0MMb6KgqcEBaJO54nKa3mb7Uy57elqcu50sZM2oJhBF
 hYKL7JRY0wGRAwBtrnI12/+60Sozl/6qCm3p/tNLcjqU5NXlFUCl5QOhu1FkygFCDlzXNBnUtL3
 qOHMKjbB4c0dmOCwL+T6pumoi77noQLHHK6y/gompMOZ8uY9fG9JUWe6GCFK7KkUr8QdAYkxsqA
 3oMTA24k+SXohqsHzLm0jPxbQOygMDSnt9t4VxJ+H0XjnSvDc3EktLEPO5TGRvHb4P+U8QnpLSd
 DiuTrmTk67MD+W7zTXIcaQKq6FkDJroi24nrXIjJZa3DuqO9RjsPE3Fm1mMi+Fqi8rQ0JTtxCbG
 VWjET0W+zestckbffy4fb0+LQb8xYfkJ4DzIS9bNrnsEPkTZmlJn7V5PfvaQovtIEnIrmloDnZ3
 xLzIOuZR+i77RUtuFmw==
X-Proofpoint-ORIG-GUID: A-q8iSRByR-PVPNICcWaO7LqwyXKMk-q
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDExNiBTYWx0ZWRfXxmARqOkauILz
 0pHoetHVH1MzoPZWnMMTfUgeOIvvWnaKdFdB2UyF+fTgBkWAQr8cHHtCS492TmBPRBcxYZfSHQ2
 uo8hhfWDBm498R+/RUWYmUt1XJrA+6w=
X-Proofpoint-GUID: A-q8iSRByR-PVPNICcWaO7LqwyXKMk-q
X-Authority-Analysis: v=2.4 cv=S6HpBosP c=1 sm=1 tr=0 ts=6a96cff8 cx=c_pps
 a=0I/lWAHw6mYlwhxI0+EZog==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=RpNjiQI2AAAA:8 a=mXUZAmrYYQz6BFmuk2cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
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

On 31/08/2026 11:12, Philippe Mathieu-Daudé wrote:

> On 31/8/26 09:24, Alex BennÃ©e wrote:
>>
>> Hi,
>>
>> The KVM/QEMU community call is at:
>>
>> https://urldefense.proofpoint.com/v2/url? 
>> u=https-3A__meet.jit.si_kvmcallmeeting&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=tJnw3gip-5JC7hYEXkI3jFOeCB5tdEvEhf7cFH-iTEakJq0k9z98tMYtI1pEpyUD&s=V9nPukf4EkuZhKo4vCepVa5Swiw6ejdGfdC3itPL_XU&e= @
>> 01/09/2026 14:00 UTC
>>
>> Are there any agenda items for the sync-up?
> 
> Mark suggested 2 topics but I can only remember one of them:
> 
> - How to merge a series what touch many subsystems and which is
>    mostly reviewed but few maintainers are not responding

Yes, I'm happy to talk about this on the call :)

> Maybe the other one is about merging experiments?

I'm not sure, but I really wish I could remember!


ATB,

Mark.


