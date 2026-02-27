Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F272EFEFB4D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 13:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvyAz-0000rL-5d; Fri, 27 Feb 2026 08:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vvyAu-0000qj-9I
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:46:36 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vvyAs-0004Hl-LE
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:46:36 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61R3bcbA3536051; Fri, 27 Feb 2026 05:46:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=B1qTga7IC1eRYfRQrV0AcwdzkiIyAzny+rF9YWNYv
 aY=; b=0Sjx90u3gRvEamVUWysou7dMXqjyI6oWnAax8KbzuvxOvi7kQIafQhYFy
 Y4jU8shgGxDuXaVviCkFiCh+S3dQd84W2PTqIcoHYFFZ4EFFd4KZcoQmKFEtSfC7
 Ih5lNStSap9b+v0F6lKj4Mj7jPBe+SekElb5R2iCWy6ZesXB50rQ/SrIa0rV+lQc
 xBuA0SjI9Uo0nxxb+iVU0mswOGigUl2xnH0ecd5AfoznTh3/3r+aO8flXiR/rQ3M
 0LtBwyPo1i0S4vdzMdvZtT0LsdW2Q/NT1Eld8BZDf5G0mMRt3RjsMXHhg+tuAyys
 JXNzbjBd3lRrrVpAnpvb7xWXhXnjQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023100.outbound.protection.outlook.com
 [40.93.196.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ck3h295f1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 27 Feb 2026 05:46:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lB3HIGqS1IpBqMGm5Z9uAfjUBJgxQC9QXdd4ODk9RwM6qMw53kBQ/NyswQVYva2HGCQFeVUiDmTU12scW70bpz1VXpiCCfDu+uFXDoGUKA2zJ37GeYGNNAxteMEpzZP/JdXV7b0uu29FkiiPz7KB2wlf1evgYjYs5Nw0gNqlly0ASfKP/st7cWZ0Wt8L5aFDurR5VFpO0W8YqXVcxAAlSTNIMH8PIf2Cyvd375YYpl30OIb0zImcyGrJT0zsMRK+AOuWIvvdNYY1zmbTNbsurC/wDQwLND38Y2uNHSvCsfcVoYVs3mG46EYXw0nT5Rve3dMbxfR1zWVMlnRj0/XR6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1qTga7IC1eRYfRQrV0AcwdzkiIyAzny+rF9YWNYvaY=;
 b=Q44Lxd0Ad1r8Gdndhr1HrOht7Gs1LACbduoQj+M6appaGvaH/zd8MZbP7eF5qY5DzpcRxWUwrGCC8pnxnDGMSqtbvx+1bAmqHqS76ni85w7uM6eV/8+7iF0y4+k2OGZxmWGHc8ZicUlj5YOBSc3tt8ti3bOaeq6aO8evyaYOIOCgdtbiKQsRxm5YMH1fCsiJAFEwZ5gpDWmQVvUzY0h9NLkrdriTpsxQwehv1xFP2rc2HGRfuxhtb25++zCJk7qqu7K6LshQ0h0pL9mJa22oPYmCDKRLotbh5op/n7hVXdQAVYxhbrBQj6k0DxyAIpriu0v9L62VOjAgXw6gb4QEVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1qTga7IC1eRYfRQrV0AcwdzkiIyAzny+rF9YWNYvaY=;
 b=cBFvC2ABjGS0FZJPuPyy3vjMV2zHplSFRbRasNlkF5CIJaVHO/U7Nkmt8OVWqUVKzWPv5RCQmOfPve11x+IOStGJD0HZRLULXTRvqQRK8W22D7E5JXy+jwprxlOyhW/Ot0cQ2tsaKDw9977Xuf4ZoRstX+CdkqSXxojpyxc+eusY6Mr1s0B+iRi0sll77vUOhGnsd0Al5kvg106rRgkfuAg8OeLcm3gVyzf8pFq61svPytEr/HeyNnBFP65cvtVtIX+5SatB/oaTx32OPljMo+MieQKEWlzsJX/zHc2etbyhIgOZEMd60sO2LCSemT5c2hKPpXmyLQK4VBkZYHzlNA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV2PR02MB11277.namprd02.prod.outlook.com (2603:10b6:408:354::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 13:46:31 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.20.9654.015; Fri, 27 Feb 2026
 13:46:31 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Subject: [PATCH 3/5] tests/acpi: allow DSDT acpi table changes
Date: Fri, 27 Feb 2026 13:44:57 +0000
Message-ID: <20260227134611.1229390-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227134611.1229390-1-mark.caveayland@nutanix.com>
References: <20260227134611.1229390-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:610:76::32) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV2PR02MB11277:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec7a00c-a8e8-434d-3ddb-08de76069d3e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: mGqZdp/vordxI2zNkVjhuW2Cy1ZGmmXRL056cmDTAowYpvTyZGbu8HrDcP/svivT5mi4Mk3amjMu9mljB6PO7i+LwlNS9Hev17wl3mtb0Ro1QiPMNFxDtwhvM0sQn897TONOeebxC7Pdx5z1+BNTPzkVBtUGJysuxc4D/85RsGFF6moLLugyxxU3ZRAXJGgrZn5CB32MnqCzjXClN/K5ZUyJmOHBMVPJL0nK6AdmiG6K21cBML16X+TlTrwGu7Xym5dY7ZdV4O2dWbGOAiRIZTLCCf6GCvxwYiUvvuUfckQgkXKbsRCg5RCA+0V/3/+ZpM2hdhzbTeyMHm4ib+chF1ai5Os+O3p8y7Uh8aWUPCNlnwxKlzugBJd0H9OXqEmoRp7gWJmfecUnTyHSuJ5ig7KOjv2MbNIRvae3GB1l3heHr0z+F0bdgFJEcebTgRCODoexNC9zXmhjKWD05bZt8zFS4138WELAXJ28Mnkp1Bu2qvSeuRgKKzDg5iazQhi1zfr3a+0B9Zo0RwivaViWkC5qh+3Y2or+SNPHtzIfOotS5UUfADjhsqjf1wPywcl0NgH+nUDjtt/R3M8Sa0w/3lXdVuhZpNYV8qeGrg4Z3SoR/6z9lC+08NFbE7UT2c5Yn4qQykCx6WMYY83VKa5nhrVt7L2a7XEgjhgzeVtJj/A4yGrOGw/1OMZUmJwFqdT1CO3EAJGHObYWEWR7+2i8R4CoEyp/t6RiqpwqTOZRPCs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AKHFqOrGsVY/cxKhZMTVIALGkSodaytAYQJclchCX+dskttHcrfq0DdeUj2U?=
 =?us-ascii?Q?fveAsEoB1EFNJU+lE89vwxA5g4+Y908gltg/OsGpalo3QGO/mAkWXaqb3Kax?=
 =?us-ascii?Q?KEilzC3ySJSecLbXYzzfhsjLMWmdwJwWW+x7tfC23BG55irr2wvuHzu9Ts9i?=
 =?us-ascii?Q?1ofNTFG+phMbiUAUQLcRyrsbyvABXoU9hACzQDR3bUdNSH01RSQNXRvq5QwR?=
 =?us-ascii?Q?WTK1ddLhXJybMNXp8hVdKixpfkanFlEbTEEs8JbkxFOSWKkvY2GwZWDXnNWN?=
 =?us-ascii?Q?gZfXmSyMvaN++YC09IF6lIhr/ntOM3vARHALATok03LEZM/5YoJbqSgx6pYM?=
 =?us-ascii?Q?l/2ovSXxpBSUVWLOVJVPfDH17TOrcXI31O/C/ZsoGX5040/PhXjzoQPHOkMe?=
 =?us-ascii?Q?Cl4+FA0pHeS9xt2u8VuKz4/calrSa/npLH0JcJ72ZFfa1p78D8bzs/ZYiA0J?=
 =?us-ascii?Q?xKQ1h2oyL3J8djK35U6ipZlMZAJqSsyrAhR92ShCTTWxjzr2oFZZGwLIYR5s?=
 =?us-ascii?Q?F9UO5ojfn5b7Ys2c1CZd1OdWOwd5MSdrhWqXSuKVsBpB145n+Vb2gZDJacaW?=
 =?us-ascii?Q?VxoZrnAHy/LokPym0gd3oCZVmaWaOSkhx8odvdVRntSQYKR5dsa5DS0MJI/U?=
 =?us-ascii?Q?tbf+9pdD4HTZ+UrnJbzJBPawPUKneruVZQTIFvTnUyYo+WxAG09ymITeIlEy?=
 =?us-ascii?Q?ePjVoJI318jIaq0bbubtRzrNDjUzVzv8p+wT29xpeyGMoYJvdG6F7utJPH6y?=
 =?us-ascii?Q?0u+tBxxbbCDw30dwYGW8gEpAGLt/sFjQBbkRFwLc4G/qoT3MaNz7y337aXzs?=
 =?us-ascii?Q?Ak9cG0Q7r2YPIXv+wFLGZ5yqoYYwcxhFQTrYiDqMjYTv62DeZGghZMw/FMlN?=
 =?us-ascii?Q?3WYQBps45sYA4OVjnZAqaRYFwhXt5cfhXl0E3YfOBJM6p4Uu9yfIzzd52KQX?=
 =?us-ascii?Q?Z3Wd57MqUtQE8gR7yMUUFrKF4Wxs8TtZsD+2Xdqqr5bs3sTk/JrZjO1as+5R?=
 =?us-ascii?Q?LOUeRa3tZlUMAjeGGIZBP2AyYygxbpm9Jdhu3xIG9mZHkYv/v53AtnM99h3Q?=
 =?us-ascii?Q?t97tOO9cQBMkVsVjRmrtEbNbILh8/5bO7kQwy0/9wY5LTvvkxWS2x8dvwNek?=
 =?us-ascii?Q?EXPRbrzqRxziadBNIy9UpFjvMIfItYQRlQmO5gSjeLL/bxZ82Ie+CHGHb+kn?=
 =?us-ascii?Q?8K7uD0nAifbki+mRdCtlByaZ+dCC/V53ynpR1HXvs70nlmw20LmPaQtJYoWa?=
 =?us-ascii?Q?n+IojyTmSC2sYS2Shbooxnskcs6aMotzpS6VBacy9gQjwWQfG4qBalanpVtI?=
 =?us-ascii?Q?qRLcac6lrdwGl8bHWVLMh8R0kyAPtZ0U9vFF1b26TZgYKQftq70kGhDDiY0Z?=
 =?us-ascii?Q?Wb/z8/h59hTzoqsUyJgWt7pcD6J8i5uYsdOYhH+T2igSr6QWMVt0aSS1eTwj?=
 =?us-ascii?Q?WsbASjv1e0PHxGqh9HMaWNhGE969TWw/UpsNlvds6V8lt8KR4YM5VStm+hZi?=
 =?us-ascii?Q?8jtMneipCN+yESQdKQm5gMIuz0lJrv7kgPDAEzjFcruExkujyNlvvqamR2DD?=
 =?us-ascii?Q?+x6Hz8R3uIEIavSTM2Ow9uQlMbUEUD3IhyjlFhx62tQU+eRY5nLmMPd/4IC2?=
 =?us-ascii?Q?EAfRzGFiASWTE4oRTzqxgpWdknGPQP0+bygsA5KRYzr4+gXPiv7G1Oz+4mHl?=
 =?us-ascii?Q?rsLLwVp/N2/ShZ3LWIY1CJD5Mbj0QJSBAMUn3+fW0egD0u3/F9VgW2v3W8c2?=
 =?us-ascii?Q?g7p6m22ikZzY60qL0Ru3Q9V9DVGYegc=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec7a00c-a8e8-434d-3ddb-08de76069d3e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 13:46:31.4568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXN7XPAflzD0RPlNWnYCw6oNWnSB8mFmDVTIQ8ErW+1Ln/0ld9oXo1HOslk6ZvQC+/dL18m1qdi08nLRRsx07CdmwxQvL6Fav5W5+0srz8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR02MB11277
X-Authority-Analysis: v=2.4 cv=LOprgZW9 c=1 sm=1 tr=0 ts=69a1a038 cx=c_pps
 a=6ImCnFsxPDZKs//ZBa9aqA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=w1bZv0MCpcxBmq4Jr4kA:9
X-Proofpoint-ORIG-GUID: 8iNhFOfkQZP6dXFA_aSfGEUQ_bYJGY3I
X-Proofpoint-GUID: 8iNhFOfkQZP6dXFA_aSfGEUQ_bYJGY3I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyMiBTYWx0ZWRfX5tx9iMlziCbx
 YnGsdXI9cAWPma2qpJWKZnYqjLiLmtUvREF8ExzSYKI9tgyYRL576QtDji4SZIZqUgfnWrE9VLK
 YklkwpYfyhBQzA3dUXCw+PmSfNjbYZjucPjcd+6aFQF8TkSKPK3ItefM2Fdi+YDIzkpuElr7Dkb
 9j4ashgVPobH+SSbNQfWhEMUnEZF9/LUQhO1/4bTPS726Dhue2PKgnzyhs8DqubAYBKe4S3zvzP
 HKsBRMrE/kg3Q7fS7rwLvetd3ge40gvcFaCOQbNCF4yn1B0Mt45tQCr2A0/aqtZKRzJDV7broU8
 wzLO+oeQpoUp/hXMaeI/OHggFTCTiRzZZnHdpvddhC7Uv9XbOMOM/heHe/hfxFugKQ2N59urMCW
 HRSHlWkxbq9ZB2+EpKG2jB1qC7PoXI6TpawQlsG98A2Baex50F/TRxKgcXVHTZyRjHxjxaOfKhH
 DoKkrA7Rvl9NXsfsjhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 tests/qtest/bios-tables-test-allowed-diff.h | 47 +++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..cef44135bc 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,48 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/pc/DSDT",
+"tests/data/acpi/x86/pc/DSDT.bridge",
+"tests/data/acpi/x86/pc/DSDT.ipmikcs",
+"tests/data/acpi/x86/pc/DSDT.cphp",
+"tests/data/acpi/x86/pc/DSDT.numamem",
+"tests/data/acpi/x86/pc/DSDT.nohpet",
+"tests/data/acpi/x86/pc/DSDT.memhp",
+"tests/data/acpi/x86/pc/DSDT.dimmpxm",
+"tests/data/acpi/x86/pc/DSDT.acpihmat",
+"tests/data/acpi/x86/pc/DSDT.acpierst",
+"tests/data/acpi/x86/pc/DSDT.roothp",
+"tests/data/acpi/x86/pc/DSDT.hpbridge",
+"tests/data/acpi/x86/pc/DSDT.hpbrroot",
+"tests/data/acpi/x86/q35/DSDT",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
+"tests/data/acpi/x86/q35/DSDT.bridge",
+"tests/data/acpi/x86/q35/DSDT.noacpihp",
+"tests/data/acpi/x86/q35/DSDT.multi-bridge",
+"tests/data/acpi/x86/q35/DSDT.ipmibt",
+"tests/data/acpi/x86/q35/DSDT.cphp",
+"tests/data/acpi/x86/q35/DSDT.numamem",
+"tests/data/acpi/x86/q35/DSDT.nohpet",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
+"tests/data/acpi/x86/q35/DSDT.memhp",
+"tests/data/acpi/x86/q35/DSDT.dimmpxm",
+"tests/data/acpi/x86/q35/DSDT.acpihmat",
+"tests/data/acpi/x86/q35/DSDT.mmio64",
+"tests/data/acpi/x86/q35/DSDT.acpierst",
+"tests/data/acpi/x86/q35/DSDT.applesmc",
+"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
+"tests/data/acpi/x86/q35/DSDT.ivrs",
+"tests/data/acpi/x86/q35/DSDT.type4-count",
+"tests/data/acpi/x86/q35/DSDT.core-count",
+"tests/data/acpi/x86/q35/DSDT.core-count2",
+"tests/data/acpi/x86/q35/DSDT.thread-count",
+"tests/data/acpi/x86/q35/DSDT.thread-count2",
+"tests/data/acpi/x86/q35/DSDT.viot",
+"tests/data/acpi/x86/q35/DSDT.cxl",
+"tests/data/acpi/x86/q35/DSDT.ipmismbus",
+"tests/data/acpi/x86/q35/DSDT.xapic",
+"tests/data/acpi/x86/microvm/DSDT",
+"tests/data/acpi/x86/microvm/DSDT.usb",
+"tests/data/acpi/x86/microvm/DSDT.rtc",
+"tests/data/acpi/x86/microvm/DSDT.ioapic2",
+"tests/data/acpi/x86/microvm/DSDT.pcie",
-- 
2.43.0


