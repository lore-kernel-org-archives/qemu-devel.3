Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D82C3DA6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFalm-0006KV-VC; Thu, 15 May 2025 11:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalI-00062h-Ti
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:44:46 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFal6-0006BV-5Y
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:44:43 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F9OJCK000592;
 Thu, 15 May 2025 08:44:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=nIU1NX3ZAd8T0lL+E+iFcpjJ/f83h+HxXHrL9+be6
 18=; b=nBt5OQzXjy/VD3LrBJvImMqWYxw2aWuez8F4UFJNjCISxV600Q/NIINIL
 Yamz1Can11KX8rQHX/gWEZxTOLxroIumbCTqlRl6zg5hDVpYMlr4H/0EWECpkMZY
 toSiCYTDeGlhPZc4PEaCnTnPyW4glq5NIip2Dtih54uwrjMjbLUVrG9WG+9CPTUS
 elNBBhxI0Xqn9a1L91SG1se8grSdc/iole87qZM0wnQQQMhwSN8mtNJ86HTx8XU5
 5fIp3/SwTSEMzJFskF2ElKF4SA9rxqA3d17DKpwv7XC9fA0m0rkCeF2mBvRlQsdE
 Qz/GzjGnSuBSE6ew6ExKrJm9XzERA==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17010002.outbound.protection.outlook.com [40.93.11.2])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46mbcsdhs5-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDWzBeGYh6m6AForyz5cSDvk8nXVx1/73rRhSxSeQCmOnj9xqwiLryN7h+sXKQ9kf/Lr2DSgr6zgkRGPHDN+8bjTrE7UGq31ZKgG+Fn+6rdxqojqytayclLXUCJFC7VzMtojxyl999/H9IoV/DLL1MLJDlq5zfMOMmYY/5d+wuJxAdQVqw2nghj/9kDd4hY5vG3Nmth2IhVXzBlpxXyt9pemhJxzXa7GIQKDNKq1y4z9T3YdtIyvlvtWniHwiLolXni3LeTZaOrkXrQwMuOqnVk0DX+lb3Ey7btF/vg+YMKTVVp80O1EQK0B3Pj3S+eejsFQ5HAOqtDAm0TlT/Syqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIU1NX3ZAd8T0lL+E+iFcpjJ/f83h+HxXHrL9+be618=;
 b=ug6QU7siKpPKuo6rBCI2Xw6AxZUdj7kqVzV3JZpTpGJBLu91Mb46Vn2i90oyTqvTgEr+5jzsXl2D293uqcUNoC6xAmk7mwOXnbHJ24lQboLDOopLC85qKtk0Rd5NPdzf6LLFgI6dLkUukVZN7xo4II7giVCgaQBJnXcQRci16xZHfD+NmlXJ8CCFCw4k3WAGj4Llg/Ky6Cs+FhkofRH6Ift1a3e0Vk/odsxUeNHOliBHsiIke66EEfkjjt4zARG45VNtXBKscJqE2dH7JSDH96xdbQem4UV16Nwr9uEe30eFm0hw0vuGdQHKI/+/PFI2QvC/se5ZB7KlHQpVhs1Kag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIU1NX3ZAd8T0lL+E+iFcpjJ/f83h+HxXHrL9+be618=;
 b=NCFUBjUFnxzpicsvHx62oYFBb8Q1KJFk66MAiWx6pLVcZQOJ1gJeHlrs4krL/B05TnNulAGggGJjjUgiBS5VK5cYH3WekVSgi39zZpkdpl6TuK9zx4k5RCN+byFlXXnlCfaNcJvUlq34N4i6YLeks3ESBjbkRIcoi+y0qIW9klcArQQ69hx2ZK8th4t+ynhBZK6rH+JAdqzXASUfXGccBeWqlWnoy33JR+Q403p4bxpIrT3zIReR3WZF8xz32PhUvEQVurfnNANC4mxi3EbnJ6X6OWLoqjhGPvB3oeIh0zpKx87FumM5JTGTzG7EJIMoTrt7SyqWEBvDXquaFUPq0w==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8470.namprd02.prod.outlook.com (2603:10b6:510:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.17; Thu, 15 May
 2025 15:44:25 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:44:25 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH 02/27] vfio/container: pass MemoryRegion to DMA operations
Date: Thu, 15 May 2025 16:43:47 +0100
Message-ID: <20250515154413.210315-3-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e370fd-fcf3-4a16-1ad9-08dd93c75e65
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JEDQVBmk+iLG0dp+1a7oTauJLZtFlDlxvoTJ+pX5bG3y+udpdQdbjNJTAcv0?=
 =?us-ascii?Q?UUFyKTE5dYk8pAL+rXTZ6XPfRNv4VfXjQbrghnU+Q7Os1XwUs5z5uUrRtuvq?=
 =?us-ascii?Q?UslP1rHLdXSKKMmfzGTQWqFAdAXdMfcf4rVZpqLNemgL5uWtuxSgXjTILe/L?=
 =?us-ascii?Q?LnZJSv+iBy2DdQvrm8ofJQ7hNh7/HrBRWJlveXK1I3215bhLlG5KxDIr0UwJ?=
 =?us-ascii?Q?yYfpczzeicFuhQAHDkUhaAsMwQp1uBn2oJEtQ14ZT/zmq3d+YIdj23viwZ6F?=
 =?us-ascii?Q?+cZvphOFLOe3j77hW3GzDPk6hi4cwAP/DxG25tx6PnoFnnlZQ9x809MvXl3N?=
 =?us-ascii?Q?cL9I7QEvz7r85Cz95OdKPbRLDHEsnu6JOFPv+4v5cZbwcHY5L7gLsy3Ym8+M?=
 =?us-ascii?Q?6ZAWDAO/CJvaYzsw9IhLnVtwkpSIWEF7UHe/LKOEZGsCx7AlhgRQXXF2ItE2?=
 =?us-ascii?Q?vY9nZoGX8HIfqhvIc3C6L6STGS0m5AHozxGPcxAVeb2ur4ibU7XpGuc5OecQ?=
 =?us-ascii?Q?47pvnPNoOE2zbxvbVoDywRgnRWlzn2L07yZ/ny/bx/WCEECIE/2rHxK4ke2N?=
 =?us-ascii?Q?/BgFg8TvP0MMWS4chBGYVDboyOZ5pN3zhOB6WexJDiU6Kh8HVCIOk6p0D+93?=
 =?us-ascii?Q?JUsWLwOXn5oCcAObzIP2G1YK7WoY4BBXcxjt+X4TvjzpTnxLDw6duS8JepGb?=
 =?us-ascii?Q?dnlG42QbIQ/HBQ3RAdwuS1wuFYnvl0KkMWA5IfTsRhuO8aJwtj7iVxts5SiJ?=
 =?us-ascii?Q?RzyGI0zxhx2sTIjw09YC6iSRy0DeZa1b96i8EzLQRWygNLurrckjQCDZIgce?=
 =?us-ascii?Q?a5VTbgngLSLoTvmdw3mn5TaCC2h0b9pzPHxizotGkn9yOHhDmtBLSsWJoAeN?=
 =?us-ascii?Q?2QT524xEIDAlaEh4HO8hd/9Z06kbnFZCYDbF+43mw6GMV6GyG2/EzJtIfOO6?=
 =?us-ascii?Q?2kSEC+IMRSwsG2fIFvo8i3Am22qTFcS7L6IIXt07E4nsl61Hgm2okwTe/3lD?=
 =?us-ascii?Q?okgn5SlcY3f7gEf70VEAPwn9GKCqMTlVCdIvpcTmucDqb85dKoYeGEPVRrAS?=
 =?us-ascii?Q?ZkaEbDxup68CJpyzLaC2GgYs+JwTdxXyYcI8hx+R0x+6BEJ1HQUsOun/ufcm?=
 =?us-ascii?Q?SAWeLKjklmncvJHBlmuKZjoGH7rrrvxWS5C9isznFY+ps3GjJvCtML3rARN0?=
 =?us-ascii?Q?SQttaf5xWELM1hBak6ePzdjfY2+gvEdxvmtTL9aWzEp26T67nHr81vXqLHLY?=
 =?us-ascii?Q?zxex4OK5tcKJfAnhk8D18to+PjkD2fKwaL0Hbc6NKMagCzI2CwnL+UlFcR65?=
 =?us-ascii?Q?hm/fmOM5BtVOyI/8tVD4D07o2vdy/pxEk4ZL7WJAKlTyHkjpop6Jx/JDJYbb?=
 =?us-ascii?Q?s0JL7UcaqZuyS0J1tsKA33lAjakC3jKGhtK1DhiSL2iHGE4rxD/pv/EeTayB?=
 =?us-ascii?Q?xKquaiXlJGo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G0RbVDyHPwbItg0mn9IrPqAPAI7azaI/yNx7YkLtaHXZSx5v06QhXbSIWxJF?=
 =?us-ascii?Q?VhwVjSY7kI6JznI9CLm5tIXep2U198jXL+QyRaEyrdkN8GMgh1PetvQf4q35?=
 =?us-ascii?Q?m84q9xQu4xNBNRuRghQzfsIyRwj+mqUw61f7zqgkx16D3kWMDIsDL8RrigoD?=
 =?us-ascii?Q?tzws9h7JdsTzSlUrLTvwfwlauM1R1/K2FPgJoJC7mozAlVELo1/TZP9CMow3?=
 =?us-ascii?Q?Q3qhY/PIuTRnELD+0rOpYNl+npdCJ1dmkbKSnRsNwu/2W/onXJgMT5Z9hTUz?=
 =?us-ascii?Q?v4JIuLx4CzBinbK7R1aGHqQiDZ4b+qkL+py/qy5AEr6g+cduaSWTcDRuwjpj?=
 =?us-ascii?Q?1cOj2BkzqQiDiV+nmRvthK57+k/DbYIGByiEU9s/043u/dGq+O8kznxF881Y?=
 =?us-ascii?Q?H5wGNEPuPP7Z+/t7QIlxVtT5Ptm338Bj/NIkNrzYEmHZP/t72DfagICVIidK?=
 =?us-ascii?Q?NDdtO8RvbJ8r3J27OVmFB0fzJc19vNoXbVSzQ0Ad/2vOUXTPLmvIVHNqzNZU?=
 =?us-ascii?Q?9TDzRzaI9g1MIEQrB7uk/TqHFMYei7DYa7GKBug7komWeMktgG4wPaRB5WrL?=
 =?us-ascii?Q?MaHamI+p1Gst6BtuvG1iCcv1yZ9flnNv8pfyD0k7qfpRA9qaYNVkiCBUhIlJ?=
 =?us-ascii?Q?GNXdO7NpmltkCs2rLZtqHibl9jehFxhCLWL/tFba4slIJSYvKKcYTvsPEVVt?=
 =?us-ascii?Q?8kmNi820kSh1Gs/WW9vClL27woNc/Z6HgOJLcxc6q7+SBduYkpBnws5Mj+PG?=
 =?us-ascii?Q?gZ6MMJC4oO7u3D2LEXqnD/57uRyOI9JsbitWV/DydDpjJ7EIwxNLE6ZCrvSj?=
 =?us-ascii?Q?EzwNbeCqECPHnYeexVDbtb5aEdcEC6y56+tbur9C7IX19jMnQYV2EsFaaOGZ?=
 =?us-ascii?Q?jppS8FYKZuHVLOVoX0S1Z7D0QF+edD+kqQj5jpxfFt1RCM2mGRrLZ8+RvamJ?=
 =?us-ascii?Q?IeTeN76QZcEtuQQCPCLyNUjw081hOPltvO70FUz1NKDqHf6DVZp4bssnYZJb?=
 =?us-ascii?Q?KDfC3Y1dPvMhJT2DrAos9SFXqK4ecBKRoPuDQIwDUPS+JZ3Rmj885Yr7h5I4?=
 =?us-ascii?Q?yJbtbRnUhcKVn3f6w7kHX70iyTl6I15j+flnJqY0i7EAb8KUnYUGeEc1rrFZ?=
 =?us-ascii?Q?GArakmYiHJ+Lcg+1JxHX/2tCPMsbJOwnG1cYnP0GNe4i08PdyjGe+CGWU6h6?=
 =?us-ascii?Q?mjGO+INFcXZcrICepB7LWQeNkKESC/Y8cTBCBzQVbddm6rSK5Cr5hSL+zkDi?=
 =?us-ascii?Q?33/gw/iLoMd83i4R8VfyTFOzrWoOfPpd1CaABD0B92jg+k3IvlQkb0sAao5N?=
 =?us-ascii?Q?bwp1IP8Omr68dY+Q1+GVd/v8PwsdIZqszeCJNGRCSUlH8DpkYjXTd3CvKh+K?=
 =?us-ascii?Q?aetJVa0KR2SwoIJmFcrMx4sklSz2tYEelf6PDsO8dIs+F2S0qG9RmiQMmUT1?=
 =?us-ascii?Q?adQjwFyiFOeHDlFrAF84q2eXj/2IK6rgtEM3/9UFJ7Cskd3hrtPsGKLh39rP?=
 =?us-ascii?Q?QwkYPFRMJwkwXI5bpv5a9C+HtOz5sdvUTipBwMJlQgMMXS6Fq3yo9WGTW+IZ?=
 =?us-ascii?Q?lzeXjFSGz0gY2b7+ky1w1VGGt9ZjWfBySnNjP+u9?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e370fd-fcf3-4a16-1ad9-08dd93c75e65
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:44:25.0002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jYNsOWb5ArX5sraHNgUsAyc/Zya3wQB8O6AUW2ff6JGMfdUoDiz8R2wgyXXgf+PYh9NRtjwdAAjDXAN4y+e5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8470
X-Proofpoint-GUID: 6d0Xrysx_Gx06hqXG35PO_oGjC2bU5Xn
X-Proofpoint-ORIG-GUID: 6d0Xrysx_Gx06hqXG35PO_oGjC2bU5Xn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfX7CInMGttl0A5
 /hcqHZAO3g8v7Blhc+/epNE/DUIQZMupNe+0ZATYfiesPbXxWdOLulZfMdxSBczmJ1GrsD02jWE
 F2H/ek1AizX6UY+G+KHfP7EXauDATdu5qaLbizsYNKjSRxZ9+2o6J34n5oJgwBqXg/eKvk2ilXb
 hghraSdiJbjwwrDokUigzDRlCxiC2z/O2WA1NChwwhhI7nvLR0250muXVmR1jl24D268C/gVQhY
 HcX9TcJQj1EZGfo9+LYi23U16rFP/HIfMIBsqCUX22M4NrSdUXJdZed5LFuLrZ1wQtApQhu6kOc
 aB/lENCYdAL+gI2ZM9R2BDfrGuxkKot9WG8/tEBBTmiVp/6Ty6YPlShExxbenXGfRWut8frCoMB
 ECqkjqsfCoUpzKAvwfIrRn4nYP1+Iyya+4iB63lPtaZwotLZRtzyD2XuXgbJ73+XuzN4YAoQ
X-Authority-Analysis: v=2.4 cv=EKMG00ZC c=1 sm=1 tr=0 ts=68260bdb cx=c_pps
 a=CQ+uznrK75NoT8CVPM1Etw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=P1UepQaUeP-bpQj9cxEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

Pass through the MemoryRegion to DMA operation handlers of vfio
containers. The vfio-user container will need this later, to translate
the vaddr into an offset for the dma map vfio-user message.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-container-base.h | 4 ++--
 hw/vfio/container-base.c              | 4 ++--
 hw/vfio/container.c                   | 3 ++-
 hw/vfio/iommufd.c                     | 3 ++-
 hw/vfio/listener.c                    | 6 +++---
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 3d392b0fd8..359b483963 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -78,7 +78,7 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
 
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
-                           void *vaddr, bool readonly);
+                           void *vaddr, bool readonly, MemoryRegion *mrp);
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb, bool unmap_all);
@@ -121,7 +121,7 @@ struct VFIOIOMMUClass {
     void (*listener_commit)(VFIOContainerBase *bcontainer);
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
-                   void *vaddr, bool readonly);
+                   void *vaddr, bool readonly, MemoryRegion *mrp);
     /**
      * @dma_unmap
      *
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 1c6ca94b60..a677bb6694 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -75,12 +75,12 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
 
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
-                           void *vaddr, bool readonly)
+                           void *vaddr, bool readonly, MemoryRegion *mrp)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     g_assert(vioc->dma_map);
-    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
+    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly, mrp);
 }
 
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index a9f0dbaec4..98d6b9f90c 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -207,7 +207,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
 }
 
 static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-                               ram_addr_t size, void *vaddr, bool readonly)
+                               ram_addr_t size, void *vaddr, bool readonly,
+                               MemoryRegion *mrp)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index af1c7ab10a..a2518c4a5d 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -34,7 +34,8 @@
             TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-                            ram_addr_t size, void *vaddr, bool readonly)
+                            ram_addr_t size, void *vaddr, bool readonly,
+                            MemoryRegion *mrp)
 {
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 0da0b2e32a..562ce9075d 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -169,7 +169,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
          */
         ret = vfio_container_dma_map(bcontainer, iova,
                                      iotlb->addr_mask + 1, vaddr,
-                                     read_only);
+                                     read_only, mr);
         if (ret) {
             error_report("vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx", %p) = %d (%s)",
@@ -239,7 +239,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
         vaddr = memory_region_get_ram_ptr(section->mr) + start;
 
         ret = vfio_container_dma_map(bcontainer, iova, next - start,
-                                     vaddr, section->readonly);
+                                     vaddr, section->readonly, section->mr);
         if (ret) {
             /* Rollback */
             vfio_ram_discard_notify_discard(rdl, section);
@@ -563,7 +563,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
     }
 
     ret = vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
-                                 vaddr, section->readonly);
+                                 vaddr, section->readonly, section->mr);
     if (ret) {
         error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                    "0x%"HWADDR_PRIx", %p) = %d (%s)",
-- 
2.43.0


