Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90438C44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZt0-0001Ps-Po; Fri, 03 Jul 2026 05:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfZsw-0001P3-4A
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:08:34 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfZss-0007xq-TK
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:08:33 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6638mB822339081; Fri, 3 Jul 2026 02:08:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=xfJCFuyfUvY8UFSzTSbFIRvMR8NGq0LX+aT1ijghh
 +A=; b=a89YNePjgPJbSwkDwkQvrUoJ7adV9cdz4AA9RyXGOzKpf2gQ+iLUKiXGp
 RPWIRo8CC8VwQA6K/druT5fv/VeiBMp1p1WjChnOLeKSvdXuTwUDf2jK89JXMvuL
 Zc01C3JjVhZM0RzKDrW6U7qkGHiv+wtwlF09xewPMtHeY5gttcSIZ6vVsz/twTuC
 j6aDOS/tP8CLpjpQrWAK96uypwVSLdYvUNHDAuuNqZsc4YMdij0056E2eOeTB8ro
 Bm1xsoGGObKi6v3LQpOSlm0SsUWV+ID/1kSFGBmE2F5B/Qn7gtv0jjDCF3nq6UXZ
 /RH97DVRki1KxbEUAE2ueN6XPj6aw==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023105.outbound.protection.outlook.com
 [40.107.201.105])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4f69w1r1an-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:08:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRQ9OLSUcOM4n8j8FSQe5evFTTeUXJ0TPKAnTH96D/QKZOMWIThN0zZZLMkB5dQTBhf4Ibg5U9JZ72xCw8UvP3hMHx2OBin9jx04zLaLYb0NHjsBI4mMyim+vJJtrnbamqQhgbjFOJsV4y7KZ9yxvkaBU20R2WtiDqsxguNghetLUNUTImyIO+MqQy4wdXLOtjhFMXenVbUUmSdEQWqHvbC/EqQyoumX3CnqzRzIyedKVZQsG/mUx+czy71ADyzLniqA2ksRSgz7YfdNu4LML/FH1MHzFcLj1br8qkC5+v1Vy+hWMiyKUWSdI+eV7VKMywCywAMZQRPeTbEyG71CTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfJCFuyfUvY8UFSzTSbFIRvMR8NGq0LX+aT1ijghh+A=;
 b=uQTvf35P9zF1yHNl+V5pzojpngLiA++QxszUwQbO5IjJ+fx3FXmZSg3nui9FN9iF9htfQtstQQaRmCjfIJFFyHkYgJAmyIbd3FafxYIR1tSCBDa5Lx6RokzNX6KIpdzYck2rTqnkZfj2Hwu2Zm24NPvja887awEb8MtWRgY98zatZfuNEvLgq2L+VS6DTkbB7YfWomOK9wSNm7QkitVfNCPF5bh9Spla8vh9NaZLer5KGiweISX9U0EwqrkOHNlZCdzEWGC+j9aYVGWjzuMK19rCnVuQiG6wYopCjEv2OrjJ7BAb2CZXWGLVhyF2rQxLvOC/2PhT/vVKweZgSasBeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfJCFuyfUvY8UFSzTSbFIRvMR8NGq0LX+aT1ijghh+A=;
 b=w6g+2k9ehR6CyAyeeKAiLbUTsBFJ/bpsdaPTNauhQKkf+/U7d8E1kW5ypGOrL7qTnlZNMoaoKKjj1qb6ese+r2QyuhwZoLkGslq4D6v4FfRSmbUhOUmCf3b60b7iiucVfyQJWK5F/VWChbtY+yGvWCyNCcaGdS4sH12+epXU9bTigZL2yOTBwJDRRILwk99d7tCXoqzfg7rCHEmstxDjSd/jZWBkUvCsuvXnKZqS+Z1I8gvEaWL0LVyRgIu/zzKvK4iR7ErNWkpNscIfn37aZa3zwmrRnEbsCiMJxoXWXHNzgZ5dUPrko1z3cF2jMlQdi/fiOScvmsT6ouXQtjwMyA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SN4PR0201MB8838.namprd02.prod.outlook.com (2603:10b6:806:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 09:08:21 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 09:08:21 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 1/9] qom/object.c: introduce object_alias_get_targetp() lookup
 function
Date: Fri,  3 Jul 2026 10:07:54 +0100
Message-ID: <20260703090814.2993188-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
References: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0136.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SN4PR0201MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: afb72a71-5d9c-44af-f3b2-08ded8e2a11c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: Ajskq0VBCionmvB1IEqOweiln8eM0DPH8DRUD6qFOkIqLhpVnMf1QO/sWJA497AgKE6OoxsMIjSy8flFMXdLO6JsK7oQCj/dZZ13vho+NDalGLqj/ImyX5/gbaJaH42dL6b9DzX+KnFV8gMJC18oI5bHFP5wX966QcogAOJTOnclBL8Xov1YC+iZuX5vEeOM15kfcZSIDHhQGcjf1+50rvh3mMIVEgBjxDZ7aQ1qi9fdWbQDHPyXdmdgP+YkxxaL6CMCRdhdCEulL0WTLbuP69n5jFdFcw7YXep6WpkCrw0jHUbixzN0N/2vcHU2+Rz/gHUUIxdn4rmSLC2CEi7iSzocuzrwhyDUSfaC+ho2rd8FAxnQgGu0eNSmWf4jp0peY1O3V3tK4fDkPLAnDmUShDYnJHyarKs0GIUWa+quQsys7h8teOGlEOSiTClvgNDXqa5MAFEl9RDo6j2P5fBkzs41ialVg+eufEJfUrqXw1xBHOWdAHGxMBr0SRXSOiVPfTtGKuqgsvkXn/sU61hxWXqvE2drVNDkHVCgJVsn0s5X8nNMSktc1X4/DosCCGzzBxrYnz9d/7NFh+2NJ3NZTRhGOKTMzHFEQIxdsyX2dBY8HL4xjFwZ5aQaahhfhdyj0JmHQd9ZRnCxVp0og6OOaxs0e616cNvsOioYYu6Mgfo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hWvg6RpeOjv3Z1kJKJ8WY2BQngm2GqIyvHS2OSwsXYmHlpZe6u2WSUeprWk+?=
 =?us-ascii?Q?GyIh2vZYoAChd+EpwhplSe5KQSu7lhek18W1YHrOuLlbSFaOUbolDu8I12h+?=
 =?us-ascii?Q?e19Ca2JA0jTnX3Nk+PDwCSWo9e/GkW7DIIfyynVv64lhiDDWh/F7indO5CJa?=
 =?us-ascii?Q?sZFvy6mAowltAMTtb58B1ROzZViZLwJ/afADeGAEPzyWa7CmQjt6XDBPJeqO?=
 =?us-ascii?Q?ofPIFpSOdL6jc5WKlK1p5Sdi5wGRGmH0Ypdzxz4TQo0hyIbtpYuEp+EEEfI5?=
 =?us-ascii?Q?rk9ts7dz6h2SBWDaEaWC+g06Q+FJeCWCD1yzdwLmzxw62vguvLxV1l/xgWH7?=
 =?us-ascii?Q?2na/SzL8MW8GJ7KuAQfjV+tKrp91aZAWVaKkm6Qn0jOqwWsuSPrjqC7ttoZx?=
 =?us-ascii?Q?oHpgVAoQDGlKWcM3I2lSMNa0Iz5agyss1yNkyQm0FkyCSCYWc1SylT/BBAlY?=
 =?us-ascii?Q?QrVI0/GqBxytg0GRKjbfmePt5vOBY/n5R6DPIhIRlnK7EwGON9yKcGfGAg9G?=
 =?us-ascii?Q?EKJvGLbl+dFdqOnHHjVJtLDv57ZifLoKvQoRTAxmRi+GqBQMTiq0EedtOnFW?=
 =?us-ascii?Q?AlmDCIONXLlgeNQbAsXbgP1p8Dh9eIfeOUdndXD0X98orx2CDLy+Q3lPGhmI?=
 =?us-ascii?Q?4H2sZ2PBD5PFrumUBKIdjLYbEG4Cm74cMdnDTEorUp/L89pTcKHqyQ2G+hxY?=
 =?us-ascii?Q?DpuruUSsiMHfEJKegVSZ7lfHWj7fZFLtlPJs3E1yjsPtzldYAJz6VIBQzN/Z?=
 =?us-ascii?Q?x8GxvieEURfTjcJEcG0fXe5pIDQA7kTWzYynSwnKXQC2Hwp/TCUwM7lIh79X?=
 =?us-ascii?Q?Z+C9CTgU6LXY9kdD/xt/54jb6PjYZqOkr34To24tWPgFo4I6JTPBUB8GxfQu?=
 =?us-ascii?Q?9ttsTQFx/gzoyVTdY8Bo4LwO6/3oF2jc1tcRsKkcQsmCC8zEC3KbN73Rk/16?=
 =?us-ascii?Q?uqOw9XYz37mFBir9esOc4SZum/ebiEEZM2BK/J+sdURpqMj3z7ZW50CH1pJ2?=
 =?us-ascii?Q?DQxai/sdh99JLZ0f3rz7nYhM5PyzXNlrkX+RTv7ZAVJ52+8hfX1QUqAJ/9Mz?=
 =?us-ascii?Q?u2FJ915WPNzYITUWpob/YT68QpJzciMmfmVNv41KNERNaYZ7bgsqhxtypu0l?=
 =?us-ascii?Q?bogOgqasWefsckY9qPszgJN8Cs55iOvT6VQESG/RqIjv3NRH2t8NgJD5FOHt?=
 =?us-ascii?Q?UH9Irb0PTP+QT94c0uM3IKsngoDMvojDRqflctV7IdRDqX4Wv3I4sAwu1NKO?=
 =?us-ascii?Q?G3RJ8INnirXUHlctPc8Jqscv4DZzUi/nQHm7bgPgqvwFngUFZyOovzl4JZkx?=
 =?us-ascii?Q?bftP4RwqV16/5UADQV4vIiHhWJV/EXM2YzKOncW0yHgvWtdha42zAE8VPaGb?=
 =?us-ascii?Q?r1+be8xfU9+cazx17mlTi4q2mygtUsGp65MgC5ZL69lMkTdRMBirDLc5CoCc?=
 =?us-ascii?Q?xRywM8QFqt8m5Ny8kizxmkDedo4YU1sXc1SYEH7h/5wxhFiaVyCvrlUEi4Pb?=
 =?us-ascii?Q?oh/tmzdrSER/0Fc39Jj3zXcFcnJWpRTbzIja4QfGY21D7i5WYc8TtkwG8iRU?=
 =?us-ascii?Q?4CYOs9+OamQU4lKVd8Ok/qYzF6282c6B821MSXT+tLDaVGXAWYAQMpoic5Jp?=
 =?us-ascii?Q?xQCEnhTRwkC4zY2IAOb9vtuYwUv9ybAhHlpNO4AoCUz5gtXwhsLjzTQ+oDWK?=
 =?us-ascii?Q?RxzvmnuxvZLuKUq/gn8UUoGQ4vr1H5Psuyabef1EgIe6qd8mGWUrP3UsK8Md?=
 =?us-ascii?Q?MQALcVPqmEZnd2xlO7jb146PAHQGhio=3D?=
X-Exchange-RoutingPolicyChecked: LCwr7007wR5+m0NBMze+GNw8kqgAuendlLKKuHCwoQHdQesTFo1o/6vTkJKlkvV60BrrjY2bkMXR+GD5A8v9TpSM0qJDGtWIXksZPkB0UbPt7HFfUEFm6r93wMo1BW8mWssjtR1BmeukbjLFPPkbnBzGrDYyiHin2jt8V/Nr5uDwKPCW7J6frouNgJbRF/5F/vJQERGi5tCSvhssvOMpT4ZiKJkVn/s3fLVKFRyS0Fd46rQ6Oja52eTzbgvRNjlyhhJDqpxOSNOtpwutD+76rwMg5vyIr779qnsqHYqClKmOs6T53VQfzLtO8YR48oGWLG9sKZHANpNpQfrStOYLlQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb72a71-5d9c-44af-f3b2-08ded8e2a11c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 09:08:21.1915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvVN3sSe0IQdsW8guzJ5/05TBGkvyKdjMacxdCS7kuMrF4CLXyd4WduqrdWa12wRB36Od5HbZgdsAN5NvWJ4ormoE3tNrQLSRuDBkCt4PZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8838
X-Proofpoint-GUID: _1aUkhZjf6a9Ac8zBvPzwuGTcKSafmDv
X-Authority-Analysis: v=2.4 cv=dbWwG3Xe c=1 sm=1 tr=0 ts=6a477c06 cx=c_pps
 a=mXWPUgXNGD4LDRIkHGcDmw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=EQ8JHI1Rt87rHWKVKD0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfX/sLqd+LEfZGX
 S4SojsDgfH9AF443AtBlQJ4z4ERAgzB9BopzH5Ad7Eg7Un2jVKlciun0b9kzTf+kNXfl7ULNpoY
 T5XsdPiydqOqNswNXbqIKHEn59VlNg/Ul6eJ4o9e14VutMrCGRoqhZP/b7JIS85+MiGE091JuV8
 cV/lz/+cB87WetjVqWdU3SGGz6AQUKQ7AZWQChQBzudFYfX6pCLxciOqRD5DRzLdwtgbcUY4FSn
 d8JQ+v0705OmgG+oCo00r2Q0t2dyDqzB4f3yhQXbPUBy5fWRxNQP2crai90T4tS/+9eUncBCD2O
 YvLq1OQPpyf5fJFTH6iQeHsbkCz32ZwVIa6MCwTRus4G+M4i9CrGhOxewoj5tx1RezuXQSWC+Ga
 +Okqp9PoEmMVDiJkUeGmfFSsTGp23urP1XNEYG5DZQG0fVXQnKNKWWapzaByCgNgP+WwMH9zUe4
 6aox93is+sJNOAxT8lg==
X-Proofpoint-ORIG-GUID: _1aUkhZjf6a9Ac8zBvPzwuGTcKSafmDv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfX1tPdAH9UuywH
 9U9zlwrbdjDzxCwbsdDJ3mmihgpk65KDpsK9e6BFFxPDTIwvpsK3Prl9PeRALZgVWX1gBQEW0EG
 /FwsE11RidR9aR/O6ajQaDgw95IrY+k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

This will be used later to add support for alias class properties.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 qom/object.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index f79b2cf361..da4db3e0c7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2906,13 +2906,20 @@ typedef struct {
     char *target_name;
 } AliasProperty;
 
+static Object **
+object_alias_get_targetp(Object *obj, AliasProperty *lprop)
+{
+    return &lprop->target_obj;
+}
+
 static void property_get_alias(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     AliasProperty *prop = opaque;
+    Object **target_obj = object_alias_get_targetp(obj, prop);
     Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
 
-    object_property_get(prop->target_obj, prop->target_name, alias_v, errp);
+    object_property_get(*target_obj, prop->target_name, alias_v, errp);
     visit_free(alias_v);
 }
 
@@ -2920,9 +2927,10 @@ static void property_set_alias(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     AliasProperty *prop = opaque;
+    Object **target_obj = object_alias_get_targetp(obj, prop);
     Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
 
-    object_property_set(prop->target_obj, prop->target_name, alias_v, errp);
+    object_property_set(*target_obj, prop->target_name, alias_v, errp);
     visit_free(alias_v);
 }
 
@@ -2930,8 +2938,9 @@ static Object *property_resolve_alias(Object *obj, void *opaque,
                                       const char *part)
 {
     AliasProperty *prop = opaque;
+    Object **target_obj = object_alias_get_targetp(obj, prop);
 
-    return object_resolve_path_component(prop->target_obj, prop->target_name);
+    return object_resolve_path_component(*target_obj, prop->target_name);
 }
 
 static void property_release_alias(Object *obj, const char *name, void *opaque)
-- 
2.43.0


