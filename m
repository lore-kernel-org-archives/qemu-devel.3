Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E3DC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 15:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzy7J-0002Rw-Ag; Fri, 28 Aug 2026 11:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzy7G-0002Rg-SX
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:03:38 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzy7E-0008Jr-7w
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:03:38 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDUDLf3069407; Fri, 28 Aug 2026 08:03:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ODTKXVfIrQUSG4PIsogjNC0n6hK0dnK5gwZ6Usfxp
 2E=; b=QRz+719HXxYuyBV3eEoSlgJiJGvfpHFWsTq6ha5O3SzqC9UzPaXGNmbrX
 TBEgx4kXq/5w0U54iXHH8ZYTCNUtzAjVHgUYigFQdjMoFM88hdOTQxuAPOTrlcuL
 dDBQHAchm0Yg5FPS5gtpQ98GmGMBvrWt/ouoztpO4pjr9MODokJMqUDSweJRKL8g
 kKBXlPrMYWljQKuzpSyNpanRzpVWSEyZtsOw1KNS+WZjyhJg5qBvUW6CLIcaJC6x
 BzOjgjM499djiTgWpcpIlFkBWG12yNf76E0SmrRv4trFljqwNnRboIhIOaEeeNl2
 gnf/lwNyQhXokZF0XRvPX9xrIL1fA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020088.outbound.protection.outlook.com
 [40.93.198.88])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gad5ccmwf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 08:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7pvN4w6cy6mt9L2xSBGcCVTZ5z0KXIbdOedLEI9r7Sw+k+c57WZk8MVGhISh4URtIcYLNQ79lsOx4qNcv82T17hqeO2wIcrubHB+8ZFAFcuuSk6hLK1Fs2eYSVFjWBJiZvpXXhbaDw7IQSKf/TaT+Nle6xd8G710Fdb6jbbBQqMC1YFNzJE4DN1OqirIysJyjlbfH8kT/eChRYdfMguntchCkbQ3X6grd7hdWpYd8p2m+CfpZlyIcmQ+w0aNFwc/PPOApvkaPz01G4W7IfC2vO5IN10sw0gBkB66smqjmiIxCMUWv6c49ayAtpptg/6Jli2TgliQCK4D2Ja7BZn1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODTKXVfIrQUSG4PIsogjNC0n6hK0dnK5gwZ6Usfxp2E=;
 b=WP2HscZbNqaexX3qhN+E/sY1/RZQ4HgrT5YmHs3cKTuYu5m0RIF1ehmgJCY+90Fwtn+rbUushpDaDDQWXsPsY0l4lSMudFgBQucG/2zbxyG5Xxn3GvAXzfbydNtw5V9pDVnjesz7AaMi/Chz/XOY9M80kGQJ7kTXJWjD4SSeWbVJqq1w6G7f/DdOZtjTHLFtxkvHq8ZU229XuItZ16K1Z6utW7GjmTAq8zzsJHwiXEJrTwadQvsjwHPE7F2APKQnESOVlx1MRS42aKE2IXFgg5kds1WzUw8otMtZLpGEzexaMY6IsS4tENBq352JsChGxbDWWrryCa0IrAUfx8g/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODTKXVfIrQUSG4PIsogjNC0n6hK0dnK5gwZ6Usfxp2E=;
 b=mAmSseQRnEIiFTDfA8H34bBDVll94bgcZIVRR8xy0ORj7YPiuw1wSoTc3mW8WqJ7WgQOZfCsk4HdsGthB4EcwgSkCW8DaAGi/oi1MWeiLjVzQhwvdI0UOla/vSBrV1js4NHSWSfiLsOs3RCQjjRx6tAqYYdJn/+xub6vHChbTtBrvkWetwiiqCFDxeUFCRn+kkz37JtXovUgFISMe1AFEQoA4Hmzib3SQ0kFM/MRKY/OR+0u1nPKwXso5LpAEWYaPvlik8/TrINO5pDOnNrLwIinWHcacvl/pbNd1IgLDH3tLtSQhyBj7+jYgBJ6QjmLEgNjDoVXhshNZQbv2wNarQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM4PR02MB8909.namprd02.prod.outlook.com (2603:10b6:8:b5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Fri, 28 Aug
 2026 15:03:30 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 15:03:30 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 4/8] hw/i386/pc.c: convert pcspk-audiodev object prop to a
 class prop
Date: Fri, 28 Aug 2026 16:02:00 +0100
Message-ID: <20260828150313.1883999-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828150313.1883999-1-mark.caveayland@nutanix.com>
References: <20260828150313.1883999-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:806:a7::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM4PR02MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 5148ff2a-86d5-45c8-6892-08df05158578
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5ufrpV6Bki4zaXIDrfCjDafL46zVntdExRDVKuWde7fuI4yJrbSgywNunWvXPKYq1khPDEEzJ4OC4zejeYJlHFGbglaxMgE3knuU2DbTrKt01F9frrG1m2ajvrhH1aU2syTUezxkwV3DQZzON+xP+knIE5PUSbK3GLhBuWRkFyu5j7aeLpuFUe44q6nxv1XdR8DXwzP8nJ3RKkYmCvAE2U5Ziq0qxS3kPaO9KZib6jGx69A54pMHPL8EjzWqiB8S4d5AYsC6mxp7u5foqvvv+JnJnt0VnzHivz0kr2FKVE7Hh9OPOqOncwwzo6s3k2BNWMf6rQlqqnnG+y8d5GwQkM1jBZ7engWY5eGbAn3Y6JHrHPc2v1ll+gFol8CaN4mA/cLG4opvPP1gjAKtZhsDf9uDgN9fM5b2QUFcSl8D6zHYb2w2Js8AH/OBwJIeDojxdKeYv+vnJoH31CqWjU6CNxaJ0MXc6OTYiekWZRilQMfcKSJSP+7upqXnjY44a0NW8WozurT3vWmFmeUYOxAodu4J3jZAz0x4V7+WT1sZbWJl7y6EQFYhJ/2WYeRVt27Ru39x5GfOQ7tTxFz80NZHL0c8qXFPPtS6ELOMbBe4JKNcea19LS9m1j2fQZOCyBCVcug+FBdf26rMROw0dyeTqgSphOSRZuUPCystqrQFiK4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TuH0WY+wAFiyb/pBvuMleoBcNOAQah/qpMdPDFWBX+abxE58CQHZoUMovgFz?=
 =?us-ascii?Q?85/dl0dbwz0jv6yFnuxhk4EF5pj1yg8B3Zuqy38zZevRZ+cCXwcIYnHFYv1r?=
 =?us-ascii?Q?Tc2KrVKg5lIgJEwBJjFJYXy5UfEQAJJARbFlRxMTqO6HVmXd7wdVhukBcOec?=
 =?us-ascii?Q?Vr+Pyih97bcQDmq/CCpvsU5i4b8abj5oEka8d5nIqi8mlgMgBYTQFB/akjn4?=
 =?us-ascii?Q?TUguTJGdHHxiWx6zK5KDpY24uJUmkiWwur6dz5PdiP6mwtViJh6J0OvW2pze?=
 =?us-ascii?Q?OsLkOab3mKGrS7jaAt9jaiegbg3RkWBtt6/thHTBaAXZTiDcZL6PbgRtlxiH?=
 =?us-ascii?Q?BLu1upax4RXgk1gO3Zr57NqLcU7m+WcTRVbbfLV4QurLE5yD3crsLXyw8OIr?=
 =?us-ascii?Q?mEfDEtY3CzkjYm0YSaPQY5CA0O1XPd+ATbHG40SxdAcL+17hmZRo5K1HkYDf?=
 =?us-ascii?Q?FsTVV4Cg4dYp7ZrjIIrC5w6tYB0tdI/K4eVlnrCIiOP4Ui9GY5bdBSTeI86n?=
 =?us-ascii?Q?SIV9/vXbvDAVyifwWCK6DGAE6WLoPFmkODucXBDoG0LwANzAuue3fukuDN15?=
 =?us-ascii?Q?UsEBzyyWit7az+7THz4UFITu957dbMtebGyZyPTHaA3irQDy8R1aVRcxdb3y?=
 =?us-ascii?Q?wcaq7BgKkYgXsak1iyjaPwC94ol3Wxf3NPpXdFWpK+aaToeBgrxKz9sPS8oT?=
 =?us-ascii?Q?bDpYa3b0cRRm1R2g0Nel9JGhmtEGg1oA9ehJAHYgeu/uhkLj7poIg7YXgvTe?=
 =?us-ascii?Q?3Z557B+nlk8tja6ko0coVgqPRM6tyfuaiP1NBd9gmd6GpFAWzR8g5G4Wrfoj?=
 =?us-ascii?Q?QlPt1adyB91C/e5ZSW0vkEu1gQFs/GaIqJUR+mAn8aTNnQYo44dVwbCet5da?=
 =?us-ascii?Q?d50M9LKmiGJrpcd2LCGsO0/vVfLKUOJcHR4gZGjOymthdzKf6pQ4bNizSexe?=
 =?us-ascii?Q?b471yXoL8qLFnxMdAfUm+oFiCTAqC2SufILfWIu6pD8O/5wpx7UzDJWPGpXT?=
 =?us-ascii?Q?sVW5kbwW3Szrw1oQvmFcquh3h6YcQfwe/CBxqYhKJG4ZoxPhXvxiqJPZ0UOX?=
 =?us-ascii?Q?/YB6000g5A0qK+UUT+OHuFtQwx9HvjTELJxMA6z8C+zkI0CRc+V5zILmTbGk?=
 =?us-ascii?Q?tdKHbQPMnxncYm/VS5uJ6hU45ZeTj36jEFUk3bXnrLMqr9H87APwP0mEQlqO?=
 =?us-ascii?Q?Up4K8nVPmIHucw8ndy6YzeU+J66881zWkISIapjDUftVirOyKz/9Byy3La8A?=
 =?us-ascii?Q?omVHuw4KwEhsgHCigLe3ym+cpncMWf7jNPZf9jzAr53TXfU/Lf2mQ6A7NYyH?=
 =?us-ascii?Q?+P1B0qXS4qICOU6vSwuA9Qak5Cs9eJPRQaJXdh06auis08JG72PaBkUO/ZBC?=
 =?us-ascii?Q?TmHBt7wBT8ZtlPJjps1KFPtl6rmKql0TvGzVZCo+JNS8TGVdmvJHloHWeCCE?=
 =?us-ascii?Q?sKuphKRq8wOgYr8gxtDoiKyxfSxm6a6DCYHkkx2RK5QcBWJP0oeiHedgcMSj?=
 =?us-ascii?Q?++W4D05+13pnAUMaTd/La6BNMy2bP+iGHuWptoixoxpS9dnvT9luGMWlW4di?=
 =?us-ascii?Q?AtB7oTEA740/1BpyZKXwWl61mZtBV96zMCb4ZxhXTCsdsE5X5FSIuSPSkMM4?=
 =?us-ascii?Q?yJnJueRhyX9znEdhTB1VNlCwvimXfz/zxE8SQygfd+p092CWlxCNzO5mxwPL?=
 =?us-ascii?Q?ZDvrPgV3IHE19eWCTF2WQIfykSli0px4X/mzL9ekwoP18iDHBl8HEGN5UBkx?=
 =?us-ascii?Q?onYoP8YXYIIeYAqFzRRHAzrpcgfQm54=3D?=
X-Exchange-RoutingPolicyChecked: GAuPnxhv5RyuSuQJv1x8+uoZmX8nE5pvkVutqDS5EjuC0x4c10p11DNklj6ocEnNICVI/W2WZmdL+N38hqwHChZ9vgtZvkWAo8cN229xoFrywfWA5hLZ0nV3V4pU2PJulNgzyJ93ErI+wAUduhDYyt/2WM4li5SdDhO43Z+N2ldt4/zD+fMSP8JphkiS/IIwGkuUVEYvPA6QwHEoOUGACUjUw7i+Jr2arz2jn4zN9Ma0hZ840KQo/IFvtmAV4djE0ADdwKNBxUk6De15hiQC2dyYJSuSLHIXvSQHG3f3yHxdMv7cFHrjeKlEQ1Ew2MJo/nUCF+Yq3bRY2pCOOFOQeQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5148ff2a-86d5-45c8-6892-08df05158578
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:03:30.2832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUFkF/PFq3XzwC+sZK8GbDK4xlntv9W1bKgnTjee3IeB867wiArFXc0wXvltc1JmoM7KbZ6Ur+RrzTzyYCi2wdSzgI6s8d3BVHCaJ4/JfgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB8909
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzMSBTYWx0ZWRfX1j2LDeWGQBkk
 hpC1dJ3nZbXg1or0aTWc/mgtJ6NhSvw8JU93RDS4CTUUznkqCR5YiEjEr/DAnVpjRd3C43DpIOU
 6FgwhPoKBzmaqEjEjLmDZRyj2jhwjW8=
X-Proofpoint-ORIG-GUID: -jgudaHf3Lm1fvUhoeugbPnhdmd6bDxr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzMSBTYWx0ZWRfX0EEmrltDxXlf
 7kllJnLaM2yaBWeeQENhzMtkqOL5RX2XtWNJNQ/gRerOiJV27rVbxb5jAEdkzt+UBcV15Khu1gf
 lwuYFGU3WPX2yfzJVqk3AzwyTkNRP6kJzvoL2LKUDt5eDWpDs9avla0INV/9STKp58SHEa4oK//
 DYxYT9UR6x7CT3qwWvK8zG++LGR8hWbnnRsvv+kv4yvuVbdwlmfGM3sv5DwTRQYHUtaV8VWFUVf
 xtxaIRpgCcu8z2JmOrXqWnTw5XZy6/j0QFKve9gwf3r0/h3K3hkc/IRCSJXE18nSBoVs50qapBi
 +W8s0AZhtdM8eUoniTCH1A1vOjmyBpr4az5N18e8mRzwuyGmsIAMSYNwT8B28ycsfJGNbla3ZYM
 d02gan49Qhf+lIx/OfMUE+PdrdC0qBNWYA4hUlUIYzC6WBVZradFPgd+0Ro+k+Hb08pMye6YO65
 ZY88qo1pFVFbqdd9RxQ==
X-Proofpoint-GUID: -jgudaHf3Lm1fvUhoeugbPnhdmd6bDxr
X-Authority-Analysis: v=2.4 cv=Me1cfZ/f c=1 sm=1 tr=0 ts=6a91a345 cx=c_pps
 a=B4HvfKsIdAoZ9ZdT5gFWvw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=L8dKEXyYK7uH4lZ-jiMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/i386/pc.h | 2 ++
 hw/i386/pc.c         | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ac03da97b6..bd800e7ff0 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -38,6 +38,8 @@ typedef struct PCMachineState {
     DeviceState *iommu;
     BusState *idebus[MAX_IDE_BUS];
 
+    Object *alias_pcspk;
+
     /* Configuration options: */
     uint64_t max_ram_below_4g;
     OnOffAuto vmport;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e9e4fc262b..5293c59d66 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1643,8 +1643,8 @@ static void pc_machine_initfn(Object *obj)
 
     pc_system_flash_create(pcms);
     pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
-    object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
-                              OBJECT(pcms->pcspk), "audiodev");
+    object_property_set_alias(OBJECT(pcms), "pcspk-audiodev",
+                              OBJECT(pcms->pcspk));
     if (pcmc->pci_enabled) {
         cxl_machine_init(obj, &pcms->cxl_devices_state);
     }
@@ -1788,7 +1788,10 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set IGVM configuration");
 #endif
 
-
+    object_class_property_add_alias(oc, "pcspk-audiodev",
+                                    offsetof(PCMachineState, alias_pcspk),
+                                    TYPE_PC_SPEAKER,
+                                    "audiodev");
 }
 
 static const TypeInfo pc_machine_info = {
-- 
2.43.0


