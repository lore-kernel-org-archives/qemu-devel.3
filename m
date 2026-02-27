Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1214EFEFB4F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 13:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvyAy-0000qs-0c; Fri, 27 Feb 2026 08:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vvyAs-0000qZ-SZ
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:46:34 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vvyAq-0004H5-85
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:46:33 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RAxYxi449553; Fri, 27 Feb 2026 05:46:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=U8pJd57z2rWDNxChesAubL5FqlwE5kkKvMux2gSNf
 7g=; b=UsJSwAowZ/d+C5fm7l3WRmhQOXpsX6tinlnuOtBfyzOjoYIo//HwvtIuV
 4Uuu8me7YsAI2ojLn9CB9c28k9ibza34WgTsKAxZ7HPP5ywN3FpmzK+bMag8nSNJ
 43jJ1qz3bf85QbX9RW05snOiRZEGp0u4VpJgQFuQ9rrOjIx3ORFhJQ/KVXqn76PP
 K5V3OlUy9aAkTV75uOKbNhYTWjrSTNGzyrswbK8T0MLJ1VTCncJL1xAis5P2soIX
 Nq2JP0f06CWF+FMy60RHCu6cHId8xTAoeGK6TWncgPGh8JNlKl0c0Jlr+NEjWbFI
 FdhC1LEqxKCBVEVbQqJQscJVfDWfQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023078.outbound.protection.outlook.com
 [40.93.196.78])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ck0d4hgbr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 27 Feb 2026 05:46:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8tGF3IstIVsgGywqojz9zBkabhkStbGEpVx+Jv8iioXZ34yWgpfVrQZbqHL+YV3HGLnflZLuM5VQR4hR7sK6argT2EfgC14BFCX9W3XDtlhS54VXKSa/ocONccnSSoxVlbQ8Rgxh6YgAgUhD/0rVC4Oqk7grYXElIeDvGeC5R68h4YffOKc5fI90bJwI1r40+ISK5K5Jv+9PRin0Xd2p8zT0kG+LvYzNEvWzgC2ED+cgUf4W38Ur2N0K3b556Nd9GarECwKh0xl7hpylBicdincvLHQJy0kkZtQ6datDfAfpyhDBXJIVUj4rZRhSdjEx0GSJ+nKkDGWGw4UkMI96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8pJd57z2rWDNxChesAubL5FqlwE5kkKvMux2gSNf7g=;
 b=i+NE6+I9N7ETYXRilS7ve08oubb0NpGYnTXMRVphvJ9wXgtZL1SzxX/8VQB+QiCv0Y8s8e2cS8hQNTdyRmLmV3A1It/xpMsDmBrqnl/oTVkLmgXurI9UuUWPic1Ja2+P7bou/Sc6cL0j7z/QqRQvvuUbj3tiyDbOYI6T45cLWhOa+Hq4PrgW8XL+aLlpq/kgU1vgBRV5L1DZ8PCwUXsqx8avSLUbHLBJm+KEISolMH/qU1mbvsnwVnar1CMnwAXPQI+nSFLhu3TB3mDTLWzw4RLOePC0Vktpg0i7WlhK+wsLpUJcYdiSLz9XjeIC3NJoGLIBBmCDJ5U6f7mCy5DKjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8pJd57z2rWDNxChesAubL5FqlwE5kkKvMux2gSNf7g=;
 b=DRLwCBlyxbF6PJd2iZoXtm7FEab1aic4l24V2obF4lXEMnnT5b++THBmCfv+8Bv/HIl9SzlSrxH7hioAnKqRRBohiXSCtoCuvdSc9P38b/2bes1ci5XyNDnYpgCjXtb4MSzdE7PCNwOXXLzuxwrc1sxn/gWW8y3ZkI7kwP0EH2/Tj+ZyEpq9NQoIpsFlaw2A57ThKhXEF4R/pWHM9qpkalAAEEo4qL5cOnzEVqKPQS7UxpyArhpfskVOe+2vUZ56AfEAAVheutrCtSdYknJu9fuWxpxZJ+CfdwRHlqHlA1wdxXdnqfWze+yjhmmNDFg7hBuBkWHDK9XCaxGdKAGJCw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV2PR02MB11277.namprd02.prod.outlook.com (2603:10b6:408:354::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 13:46:27 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.20.9654.015; Fri, 27 Feb 2026
 13:46:27 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Subject: [PATCH 2/5] hw/acpi/aml-build.c: add AML functions for
 StartDependentFn/EndDependentFn
Date: Fri, 27 Feb 2026 13:44:56 +0000
Message-ID: <20260227134611.1229390-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227134611.1229390-1-mark.caveayland@nutanix.com>
References: <20260227134611.1229390-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV2PR02MB11277:EE_
X-MS-Office365-Filtering-Correlation-Id: dda055c9-5987-49e9-71c5-08de76069ac4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: SAUdaBJeiEO6WrFuSM/T/RO6AFxuwQN8EadIwZDEsCOhiBZGko6y61NxMWQ2YlGspTZ3AZd6zJxTDjl94k6DHWKST4lZ4+GzFL7diBYO/lINM834H9wT3Kon0FE7AQACF99pZ2EAI6Bd4sGHm8bTPzol4NrzKKhDDBy0eIiXlbE401EaXG11BiQHGgU4Df8lV/s055IuU7BlobgtgNMQplpIo9XUQOL2BN9L9UqZ2QCmm6nsy5bHso7XYwJjgiw02beM1MXJCQxMzD/F5+kISsRupxgdnQ2IZ+sYBvOiqH9V+U7oCLDO3UdURM/zJHZwYAHksO17vPy9MUEdsbkFGm51BSh7grpfDj+SjvPYyQBAuaNVl+Pso0Cygeeb9YW2NXPBn3zGQJuS+A5CzXO4mn7Rd5qBmgOfsbFseNZhxcFgAXpebKQyDia121d/uBsvFphsoCEJw+L5zclVYhikMvW8cJmPXDVcqD39jnpcXKZMPo8SuQ4/CmZpxzCB7sWcgEA+qO9nJtlYXSS44xTsoxTIhd9bcHO407gq3rNVNWg7U0eqBRneK9zUTqvsKmcmhMlG642WRYfPdz9D/lf8AgSozJ0ESe/ecEAFtr/Qf2Fuf7pxdtVPa2Ft5bKssJy95Nz4vH3zOK/nhuPkNzrVAWV8ZrhIJmSpW8aARhhwiAJqsekRQFxE90mOgjsfqlN9Skl9VZ9Zrb7za3cJEILyJN0rkGSZFm8/qI1kFJOdZwI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IQJgboOUuy0JMpywZcgtkV2/Fvm5CFpO6iTpuhEv7Ex1EkXZ/hfMkt8KltXi?=
 =?us-ascii?Q?DYqe0c0ipTI6VKBnECATKWAepjdZvXQAHwgAPkqg3FGemsOQM82AMD1xhKGs?=
 =?us-ascii?Q?yExrDTsolnGNhlKNH+JWO5CQzH4IPE9KaHPh2KNVDr8TIrhZ5lc9a9WmqOnj?=
 =?us-ascii?Q?VuvXaf15FX3sWlNpDNXwWDdIUMhnlwegvysgHnffZWy0bHGCRykox1VR9/Ib?=
 =?us-ascii?Q?EfkatiqVX0uWI5fzVUfslD1VPApDtvUnPe9yLxj6ggGds+g8n0uPaQzFCDM2?=
 =?us-ascii?Q?tT9IUr5l29f6P7QWrWeMtLCtOrj/IMb4UejCRVRZw1jHGi9znU4EuD7h1AgF?=
 =?us-ascii?Q?iBQS4UawLRjWmcukx5MQBSUgj/z9ohXLBwIx6dmAB9rLumUlktoyjUdTf3gx?=
 =?us-ascii?Q?LxgBBVBzRVhLMllcMNIMulaT2RYtegVI55r+2h0ztMw3bDH+QYedyAYUwT41?=
 =?us-ascii?Q?tCd4UwjCQt+m64neDDnm5pjS9tM5YUdFrTGScX2sk2jLPgWF4NwMKdyiUOIm?=
 =?us-ascii?Q?eG2cqyF8JFckkomsh1MQSvptFEnlfYjf3idNMbfefICiartLIXIJK9idzWDk?=
 =?us-ascii?Q?m1q6Mq9GZ0Z8cqnPihDncONrJrXM2cIWQ5rGWk2IQcgIBdPFpVrnx4/OQqbc?=
 =?us-ascii?Q?nFC1FoQhVZgRNa9pzev9kg3+sAX8K8eRBmBrbFol64GGOcaUPMZHpCpDBs2W?=
 =?us-ascii?Q?FAHbYEmr3lF9+OkdZBVeR7F/M49Noorw2ktvWDU+RAW84wGwO2H0ep/rrpgt?=
 =?us-ascii?Q?+JzdK33zx0IanvaQidBFrPGJaAkAWzGHTbC7rohbT6zmdY84fHckqFVwSYR2?=
 =?us-ascii?Q?K9G+Nt3pKixVVGShluTMIz4Hs7QXZIqxbLn7FcFpg5WgR6oVbgJ3U8+E5DQc?=
 =?us-ascii?Q?ihG2HicEx0+wAY8BkjKnou01q8pUuOyG31nQRcHGYxpwhshdExEQV1eHYzTY?=
 =?us-ascii?Q?toNLNg4jikeKAJcUwNSpRFccV+zdYLZolid3N6a26CZ6jpOwGlCwjBhtjkgm?=
 =?us-ascii?Q?NfkQ7ztLGCjqDXN9v2/MeAp5VFqtxVo+1WMSs7s5dP1yM67BZbXOhECWi8R+?=
 =?us-ascii?Q?1NNL2JTqrgzRVhGZgALzq3ei2W6va2LVzOsQ42yIU5m4DB5GUbqM6rd4QWcH?=
 =?us-ascii?Q?xHI1IPVAZQeu8ig5JIhBrirjQUhKCDq+xNAWsoMSK8//aFSlG4m663kahODk?=
 =?us-ascii?Q?ZTq7mTWGDpSuqbYxYodelzzaC2g4FmXmlQFG22y03OoD8bhduSN0HEa6WU1Q?=
 =?us-ascii?Q?dXiHxXiySHPCGstRpObyyr2ve7LR9rjW+gwMYdu5o+kaFzWLDbXiJ+mEU2P1?=
 =?us-ascii?Q?0NlTl9JBqutT7hUDA4U8tnmXd6599anPx2ZEXCuHcJxt7FpNu2bi0WP/7039?=
 =?us-ascii?Q?Qn00CVkW343be53rjMcv2qgdasiKjiy6ghmy6gEQmF0MWGpObjFu4oAFNo7f?=
 =?us-ascii?Q?ofeq68uqL8b0Kn4TJcSAydcD98nRKTh/WyCO53+21nppkm4lNz1Rdth1a7XH?=
 =?us-ascii?Q?sVwLApv/tyYEmgHEraWQ9iTBGuyNcZ8XqCflWK56NB6HDeLaS3ZZfrrmJEXC?=
 =?us-ascii?Q?lkwpaBUJtkByKu0S48T5RDTtib7NIxdzwH9r91KwarMFdoDgZZ7z5cl2sSbx?=
 =?us-ascii?Q?S0NgRo99bcbmTcQ/Ti89iXUbTlrAXn69bgasslryGw39B3I7v8S8EEHX8rtz?=
 =?us-ascii?Q?EiflTuUtmjIuFJidEc7hvImgIh3djCf0E2DaJFXa/x35GY7lWEMcsDIXU3Cy?=
 =?us-ascii?Q?RV51WAeoqpSvdruVjvgWyXvMUYs0Dbs=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda055c9-5987-49e9-71c5-08de76069ac4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 13:46:27.8646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDxrBy2BNzrwDpaJ9qig0hcG6HA7h7StoEdVG053plawhF2/F5h4dUtfGpJFlZbSgipoSJt3R20qszAq0Yx9UWE7ktPsHBWnz5VkIE8Ogu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR02MB11277
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyMiBTYWx0ZWRfX0PdwdGPfTWcL
 6JbnuDWqwKRS0/1K8016VpRUT52ZY8qtcq/la8glSD47BPMk/hvRxsd/Fru9iRhryFveC0D/C1o
 LplKhgKQ/ntQQJHVlwbon0bqtzw+LadB+J1rw3TLxi4HIgCb9SHSOb5WNKd5ZavIysRmlUuYrj6
 1XWghamo7J4XAwtOa1t1oGaE1a1UMssoDGevECQsWNCzLs+bZDJgGKZkpEqQXYHbJGutMGHvaBV
 j0hb6BnkEM6YN16HpPqJCGd32Vee6l2CwJW0aw4yF7mHHUaipTpivO5tgErevtv3u6bypIfaOKi
 LQigRtXNAxKjUyB0U+X82ImfhfgqQB25+xgJ9S0wml9qaeLz5lJUw7y+aqGYLZAc4BH5jE4sI2A
 bB2MIguKB47ZLz0oXm1oMgMH68k2s1+9+Iwx2Dp0rDjuhS516RJSdxb2kJhu/KNJEzuexD1rW6x
 Ror1KTEJ5HaRCLDRxhQ==
X-Proofpoint-GUID: 3UCt48HOTDcZpg1xmH_4ka-dieC_Xblu
X-Proofpoint-ORIG-GUID: 3UCt48HOTDcZpg1xmH_4ka-dieC_Xblu
X-Authority-Analysis: v=2.4 cv=TPBIilla c=1 sm=1 tr=0 ts=69a1a036 cx=c_pps
 a=qh32Q7XyPXPg99od4CZmAQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=pVxnATgtKDxbnibDHZgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

These functions are required to generate a suitable _PRS entry for the
ISA serial ports.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/acpi/aml-build.h |  2 ++
 hw/acpi/aml-build-stub.c    | 10 ++++++++++
 hw/acpi/aml-build.c         | 15 +++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 3394253b9e..6043eeee41 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -415,6 +415,8 @@ Aml *aml_derefof(Aml *arg);
 Aml *aml_sizeof(Aml *arg);
 Aml *aml_concatenate(Aml *source1, Aml *source2, Aml *target);
 Aml *aml_object_type(Aml *object);
+Aml *aml_start_dependent_function(uint8_t compat, uint8_t config);
+Aml *aml_end_dependent_function(void);
 
 void build_append_int_noprefix(GArray *table, uint64_t value, int size);
 
diff --git a/hw/acpi/aml-build-stub.c b/hw/acpi/aml-build-stub.c
index 3180c7c962..cf2f34ddb1 100644
--- a/hw/acpi/aml-build-stub.c
+++ b/hw/acpi/aml-build-stub.c
@@ -107,3 +107,13 @@ Aml *aml_buffer(int buffer_size, uint8_t *byte_list)
 {
     return NULL;
 }
+
+Aml *aml_start_dependent_function(uint8_t compat, uint8_t config)
+{
+    return NULL;
+}
+
+Aml *aml_end_dependent_function(void)
+{
+    return NULL;
+}
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index b07b0133c2..0b9498a4e9 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1729,6 +1729,21 @@ Aml *aml_object_type(Aml *object)
     return var;
 }
 
+/* ACPI 1.0b: 6.4.2.3.1 ASL Macro for StartDependentFn */
+Aml *aml_start_dependent_function(uint8_t compat, uint8_t config)
+{
+    Aml *var = aml_opcode(0x031 /* StartDependentFn */);
+    build_append_byte(var->buf, 0); /* Good compat, Good config */
+    return var;
+}
+
+/* ACPI 1.0b: 6.4.2.4.1 ASL Macro for EndDependentFn */
+Aml *aml_end_dependent_function(void)
+{
+    Aml *var = aml_opcode(0x038 /* StartDependentFn */);
+    return var;
+}
+
 void acpi_table_begin(AcpiTable *desc, GArray *array)
 {
 
-- 
2.43.0


