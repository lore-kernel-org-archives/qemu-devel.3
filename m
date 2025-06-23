Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27FBC77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 09:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTdWQ-0000f0-59; Mon, 23 Jun 2025 05:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uTdWB-0000dY-8r
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 05:31:11 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uTdW4-00012H-Vt
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 05:31:10 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N4GMmu003084;
 Mon, 23 Jun 2025 02:31:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=eIUC3eiV+fYFP
 oYUdp4fjeQDpg2Lt6EoFqONne3lR20=; b=j1A1VwQUxYtb8a4TBWTOrT8XCqpfo
 Cdu9mDGiG4YccBEy5ZOC6/yIKjOW9v2aY7Be4LInilc2EWKsvD6XQK+XMzf3vcfA
 2U0zsJZqusfulXh2HxtjKzSAjtW7rlKCPvsEC/7EdgZH0pPdWcJNox6GYnzeS8P1
 Bl+otRyUhCZdVSnBE1BPiDWEPPpDDGwzJ+r6YhX+yGOTt4hehOeTwetjU0eGRWXe
 qAXM4kHLsf5M7MAZ9LzTzYjC1WT263LqM8QJMqwo/mpI92H2Bkoo3R0jg/fF33Ey
 qj5qZLXceKCOMSZwomgEfhhlVr5EzJ0jqXfqqttGkhCKDC8fOd2BvJ6UQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2116.outbound.protection.outlook.com [40.107.94.116])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47dva0akxy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 02:31:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfKLJJ4h0saelsIS2ViploQcMkujsd75GDkR3rZDwqeRGcFQjowg/pCGyzkPvSATKHvnZJFiDo4ti64ZgSxT1/+E+prI20BwYquo2uyCTsI0vyGP0hICB+giSctDz7TsFPNeVMxns25GHSxNrFDdmCEqcMXSe5RYlGPqFZY1LhEPGaJaXfL0jG7CNrnbbFfE1zATPfStU213Pt4IKPhxWGWyz16oEJQ9P2t9I3RjA9brGd99iA6zxH231C2XQFTo699wFhXSgJmCWhJ1dm8WAYpZCZXQdii4wpNAMeJJuGGLx1kJIajFITSFx9ukTqsPeFZixrpwZ+QC9O32GMjjYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIUC3eiV+fYFPoYUdp4fjeQDpg2Lt6EoFqONne3lR20=;
 b=FwPsl705odi6unq1yNyYs5ga0Hfn7MD3gIgQFzGGoLFRtLdsxN+Z6o6/ad8SuJmaMtz22ESgM73cEmgoojtR3yoe3mDf+ZrUhcev1RxEXrVwfE/Kkndi8LQyzmVgvMB0XS0e8FyuKmA50mltJjnpQw2CY23DVYdWTZIUdDO/URTjTvu5JTM85k2dnRCp5TBjsmCB3Q6FgIGeosGpcoGCVZhDEDRU3BeYZciZc7ThnKca2xS2t/0fPR2KKzSZEWuECGRJu6SdWGtc8YMa2wLkgZxNC3oPEZmt2TJMs6lESxU1hp0J6H95aV06cqy0JbUA3aKMtNjOvvRvzX0DnnYuNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIUC3eiV+fYFPoYUdp4fjeQDpg2Lt6EoFqONne3lR20=;
 b=H8P0IDQuHJGtjaU9WdCJlADTEs54kw/JPvEJeY2Bh35Yd9jt94846LhEbmxLXmjLEemL1i7MyNYQ30+SPG/LfQxbbL1b7mdVfD+b0NMdM/7bY8OD0Pkms4+BukLIZqHfsykDrQ12m7x5cK9xY0K+S6GzmsPTS3THR1QmEX+N4QwffQq+Q/8c+n2GK7CgsZQUQ/ADyOkv726Sqf+v+TqA8M1qarDOwmURYbkdzUvf0EdDsQEJTtf8AlyfyOU9jnFVD2tBpXHfbKVazx9Ie4J3didm4IKnj7PUTpjppbhCl3nCzJtFR7TXWdhhD362hkUj4LlmXs8V8AzZ8Wnk/8uamQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH4PR02MB10658.namprd02.prod.outlook.com (2603:10b6:610:23c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 23 Jun
 2025 09:30:58 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 09:30:58 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH] vfio: add license tag to some files
Date: Mon, 23 Jun 2025 10:30:53 +0100
Message-ID: <20250623093053.1495509-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0020.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::25) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH4PR02MB10658:EE_
X-MS-Office365-Filtering-Correlation-Id: 016e3643-1687-4e08-6d12-08ddb238a906
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cUciSa/cf3ftUL9e8OHa+EhzXZDchvqS3qYCCOZSf5DQ0XTFZ4XsrHiE1v+T?=
 =?us-ascii?Q?lk8uj0yJCNLCupO6t3Xa2HltzNZNOnzTCZEIRhUt5JEswYHseiifgiGzwMdh?=
 =?us-ascii?Q?dD25XJjprvmkhdmesVFmw5InNG+skY/xkj3FVR4njzC1SSwg5UVjb9FhtUl5?=
 =?us-ascii?Q?n0CxwqhZibgBqGqcsYtENfkVpXP1PArZXsi1s9+6DaUdh8w5/5DShyUPNgi7?=
 =?us-ascii?Q?2Xs5b7BV/FFq/3bP8JHMbg12r6AwrawKqtLZbRnC6uw3PHcJTE8CMxVUq0ED?=
 =?us-ascii?Q?LjMb2AeFpt0vrp3/STFNOFImNDDhfDg5BEVgTPbttwhr9CxEJHt6PfOpCGR4?=
 =?us-ascii?Q?E/JreCe2WAnLP9rRetgX7rlMHzPPVeYiATmFB5PNny3xEC383qTc1Y6o/GhC?=
 =?us-ascii?Q?hGketouqPtCw4SLtD9dkGwnk7Oq0URp7kN5cYjbweJet/rF30fgxZSUY/8+7?=
 =?us-ascii?Q?ycoE9gwEnXOCyeFX0PFULYtvhj4t3WpYfyMq+VH+uK6H5rbWv40wTBTZhDsU?=
 =?us-ascii?Q?vx7u4ay1EOX6iZsl993E6YfMSt9qFCwNix8BGqRwc529Dqc0/HHWf/l6AfOU?=
 =?us-ascii?Q?CJAQgmk6rKpOaMH8ABWhlMp3K4hZMRmi9dTE0kgdwjAAVejX12Rebw/OjZNs?=
 =?us-ascii?Q?AipxfQJiS/Ehkg9SHdCbTXyB2CiFaanhCwZs00M+swiWQizjTYEo9Jk64B0F?=
 =?us-ascii?Q?KyeiqHf0qXzDrNhWhptbRWkr+jGoPfrhZOz5x0u5ifEILSijP81sj0uwa5Vo?=
 =?us-ascii?Q?H1uqjeuGC9cNqCUGPHSptHRCpeVPfT4YeHZ4rGhzqYIWZzXaVPKrE96OCP0T?=
 =?us-ascii?Q?AvFSBsAK0gVPV0aHtOEBu+OnY8PUfSbI9QDxD9fHJEKEyjp6r3c2SlYXvBjZ?=
 =?us-ascii?Q?TGDQDRaITBN45q0iNE0OKeEG9By8GiXgGnBi6A2BwnP7O6UvmwmaGIyPozdU?=
 =?us-ascii?Q?vZeFKMNsiDoEH5OQq60+MpwcFjFpHBYCxGJUqyFQmXkNQHG2Ez6G/R9n3Zet?=
 =?us-ascii?Q?hu3bAJmePq8XdzlYIK85dx1pbw+P/qIV8RvcXakg5rPX4zs3K+iCXIqlLmX0?=
 =?us-ascii?Q?fRnZ6zL9c0IjLhleZezm9SaYQbifKHWAFl35fZYlcWU3fkD/8T8asgzuZIj8?=
 =?us-ascii?Q?hvK4LZIFGv+6WHhp0JBb8GUX4YG/G+eeVGLVhyqBpUVvBTuWSHv1eQWj8DVp?=
 =?us-ascii?Q?FpoVdBeCIQZSxCJL4kZPNsROae/KxzF8hawP0bGVm9ZIHskcNdusuGKhVWwm?=
 =?us-ascii?Q?jeO00T13syMzYY/I2UvtV3I4iKFCep7gEb8S/Q7M68JrULOLfN6V5JtWnIk+?=
 =?us-ascii?Q?jDyMfUKbZt5s02qRI0hcBxv7RVw32JDU6xUjfSvMJRBnUvyRufwJaOHlXKuL?=
 =?us-ascii?Q?uQO6pRDgJ5vx4ZtSr6ODg6HhZQJ6dohq/RZS9l8fA8BgtY3cyg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RWvpS4H1TEdwTiu5ZrgFaw8O/ve8xKEg0l8ttlHF6BubLlaCW5HwUSrDNQQx?=
 =?us-ascii?Q?z+jUuZOr4xSzhTgygbqlYcxIW2IEytt8lJjVltFZhI5NIhxiluh+j1j5B4Jm?=
 =?us-ascii?Q?8tQG8ZTX2VKRmWwT2Z9YCwJy09+FByjjfg1PWE2JHb/owGSvo0md5cSYlxyj?=
 =?us-ascii?Q?+BcmxMmap6tVS8xu9a+GCUI0UqKkracAbrGyvYkEZNfRbDhW3s4MWFLKqQ5K?=
 =?us-ascii?Q?oAJDZNHy/ldPsjkRNIcmLvkOgCVh9LSATK8aeDlW3ya6xHEQSS4pWnICHi2L?=
 =?us-ascii?Q?bjT9N3Qrs4KZO6h9Hf/ZHL/YEKr9UVuBTfjElhJuOFrqwuSOh7CIn+Z3/QIQ?=
 =?us-ascii?Q?OXqkjiba9OZ194+NRYuxlJ3SYKUtKi0FFKSnVm4+2Zg51JzU/KdEiyxgVPTE?=
 =?us-ascii?Q?bONzd5sgC4b3T8z3FRRwCKj8Sjf+eYsYxa9Ej0uNDoD7Sdmvqv2nvEleomFy?=
 =?us-ascii?Q?0FHSbpKhRJUFFYtq8dXc94dZnoUhFgV50BqVxkx/UBw7auK4TNGO0vqA+OY9?=
 =?us-ascii?Q?nNOU+e5fadbBjs8APu5hWZ3BgmarBCdQGmuKKIEWlhLDjdYiTfayc3DSQzpK?=
 =?us-ascii?Q?YG/J029z7PH1v97QaKD8xvIzYn8KJAso4ywKywCKhgoMg1Qk+c0bjwuUrtaa?=
 =?us-ascii?Q?lCJzxzZ9GJJ5xFd2IhI8FYJfWLYhN5tdd5119oIOoYJHJ6SRsQR8DF59pG2l?=
 =?us-ascii?Q?NBHdKcGhCrnaU6OMsfO9iymUzY8JWhoYY0GHTzHJhD8O0u+dZXUs1+7waKin?=
 =?us-ascii?Q?sqpj2PAvT0vR6SECbf7ALzLLyoc/UsaRWMuav3NUWmpYmMein3pTrDk0IzZ7?=
 =?us-ascii?Q?qkJeHoYyQPdjyUjq+UJL48+GlopDkWg1atYONv1iVNWDIVJaxxIrmrjocnuc?=
 =?us-ascii?Q?FJAyHrdxP2zVLEdQ9i48s7tOe7KDjvOzPUwqJMjy5z8jwYUh9TCR2ZGQ4Mgc?=
 =?us-ascii?Q?UUVUM5rSP8bXxJVK7Z8hNdDhRuA+Gd7RG0cOYubcPBPxJsoQro9Jw6wuemue?=
 =?us-ascii?Q?SwhtvISfO+Qc6SB5fR/ixftxORqOumo+y9QcUPEHN+Lx587NTR2oxvWqASPm?=
 =?us-ascii?Q?IPPkZ9IWZYhAd/O2IYqXoeTumB+BaLHa+5SFlRG3MykKoYTgQV/2PzkZbNkK?=
 =?us-ascii?Q?I2XR4SFZz12FF+jtnO9A0yuCMeQ/sLlVQVVEpt10qOUTc9zhqI6Flc/9hQTS?=
 =?us-ascii?Q?Wf/SIrqD1eb2YX+ix9xJ7UTDB5KmrxaqKCQrIYKVqfIw3sRyOvYE5a/BgoYF?=
 =?us-ascii?Q?H0CnYh3Sp8KEwIHiTGvKN00zae0Nm0+l2Zt9uvFECQbjBC7ZOWhX++wUd6SA?=
 =?us-ascii?Q?PLeOx/ENgrAtC+HDtMchqXh0ipSUqPWOMmObQeDoQnMNSmBs7K7CUPjpf0jp?=
 =?us-ascii?Q?QtaDdytype5Gj+7lcswPHxTHE02/RGbUhU1Zji7NesI5p32hSWOBu6chNWAo?=
 =?us-ascii?Q?FqLv4O/PHU+O/eaGHQ0cnvbRtU8v4rgzhtinRxZQvrkkFSDf0SvsPF0eAd87?=
 =?us-ascii?Q?uPEMHYHNvpj1SgXzomr+6PQjgsyYshOqMfcdrBprP5ZYqYwCQn+/j2Wwy5Bb?=
 =?us-ascii?Q?QeU8tjwUl7LO5DEFLkWZdJ/omCyNDELEFdaHCZAv?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016e3643-1687-4e08-6d12-08ddb238a906
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:30:58.4956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eygzTHSjoLDdUMDoFH/3MMPyJ1nIcjic+HyZu4IsAiUKc/KpkHuezhUjcIdS7JdFxq+D5i+DmxN9Iwj+VTsuIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10658
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA1NiBTYWx0ZWRfX5twRA9NMe2T9
 jxo6u/lClvioq+kQnHqisUp0dqdROx/VgrxRJ4ArqiYzscmPpHvL7x61WtNFMWEOP/G8s5cvV8t
 ItVkzYYEFpXsKlt7AFRoPK8ef1M/P8L0/68WiZd2B7sn2WtaugszJKt92YLoV3e8dVUu21XX40Z
 gYWONSQWMbdCyCEy8bhKeK83SyAvv/JgLnugl26Ru8rP0M3Br6pkjbX8gQ2dT3qsoARbWLNTFTr
 V7st4ty1HOd2fUuGE3cYdM5PhNE8L9VzlWR5sOQwgNqoBHJA8hP/6qHt85uvAPRWkb5TqkuuWh5
 979xvDp+U89bm1n5Lb0NOc7zV77kwZNJHWAwD3DuU8Um8ZxtEMj+m6BvRoN+cBivoh5A9DR8E0/
 3HkP0YCqgQds8pmRl8dLFO4U6Dqi1pubTRcZhj7/wRMhauF6uUCAmDkru750bHl2FLOzervk
X-Proofpoint-GUID: 0WHBs-N0rZ9g_9td2kdSRsKeAFxkVn04
X-Authority-Analysis: v=2.4 cv=Qohe3Uyd c=1 sm=1 tr=0 ts=68591ed4 cx=c_pps
 a=YFZbUVvzz7GUzJ+tBKhNZw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=sizfr2a4TzIih7E-QToA:9
X-Proofpoint-ORIG-GUID: 0WHBs-N0rZ9g_9td2kdSRsKeAFxkVn04
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Add SPDX-License-Identifier to some files missing it in hw/vfio/.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/trace.h      | 3 +++
 hw/vfio/Kconfig      | 2 ++
 hw/vfio/meson.build  | 2 ++
 hw/vfio/trace-events | 2 ++
 4 files changed, 9 insertions(+)

diff --git a/hw/vfio/trace.h b/hw/vfio/trace.h
index 5a343aa59c..b34b61ddb2 100644
--- a/hw/vfio/trace.h
+++ b/hw/vfio/trace.h
@@ -1 +1,4 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
 #include "trace/trace-hw_vfio.h"
diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
index 7cdba0560a..91d9023b79 100644
--- a/hw/vfio/Kconfig
+++ b/hw/vfio/Kconfig
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 config VFIO
     bool
     depends on LINUX
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 73d29f925f..63ea393076 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 vfio_ss = ss.source_set()
 vfio_ss.add(files(
   'listener.c',
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index f06236f37b..e1728c4ef6 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -1,4 +1,6 @@
 # See docs/devel/tracing.rst for syntax documentation.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
 
 # pci.c
 vfio_intx_interrupt(const char *name, char line) " (%s) Pin %c"
-- 
2.43.0


