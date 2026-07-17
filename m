Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BF7C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkgcc-0002f4-SE; Fri, 17 Jul 2026 07:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkgcX-0002dZ-AD; Fri, 17 Jul 2026 07:20:45 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkgcV-0008AE-Na; Fri, 17 Jul 2026 07:20:45 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HBHGZS3782347; Fri, 17 Jul 2026 04:20:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=uXwnpKDsnUEM4AHjTaJYhmCPnBTTfgRwXqDL4GQ3A
 jA=; b=FXFyM/zOO86vGW/pLKAAn7VnpIJGHoWYq5r+s9yuY3aHB+BQp845282g1
 klWSYPr74sI8K/V/NGsQpMVfb/6UT3Fm3rCAi6v71/xrL7+uXt3K1H5CdFWxYWq3
 EEAaRQgmX5YRU9P6G0tUKfr46FFpC3hz9q1MMFExJzH7ZgOs43z2g5ArbWrRIzPZ
 c7cIUcwv0cU1UKXUPAZPgYdzXlsedb4pkRMwSq98uop7omm0uV/GO6drJf5Oqubc
 rtppIlnu25UI2WULtuw+UsH7HHedBqCVIYry8yN5oiYxgBkgFIAmM1uagH+DCbEw
 r/QRHfY4P0tlVR3gSTZuIpykx3AaQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023096.outbound.protection.outlook.com
 [40.93.201.96])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ffkcx806r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 04:20:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L51Ih06lTyUxQX1PV5dr/jj8Z1WWa7T95llOumH8PtY1dNcDttyr+EJY+giRB4D3qhDWfcyrd8qBEevDKFkOc4Yq7YXgQxbA0aJxKG+6dUUdXpA51lgzID4//0R8pBmT/h95XjMvkj3DfmHY5d28Om63ZWA9IuvXHo0BQZgK/qeBhsD9+/EnTPjK1Ho/BqMJW/sBJdaeZ3qQxY5MN2N9oHmA9420ihMGrsCcffsCXmhVpUQlTqgOVHz6POn+uojvhVXJ/6FwVr7JkXnxSt2RK4u2FRKwgL5lvcslrJJJk8ba1iMp4aBO5Tr9BYPXupFGI4ODUEFRZvf3EPAsbNrRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXwnpKDsnUEM4AHjTaJYhmCPnBTTfgRwXqDL4GQ3AjA=;
 b=Lk3EAZAoATyRO5wi/k1RBlLGowRR4SZ26o18K6JqbrM5lzOd2G12wRPi/0H0fT1ZdLEeqzPWZalEb5qHQ38JgCRFJ7VYZi1VHhmfpI1rNsJ2jOYRFazAFqRGxO3WwvCA6ZdQhArbxNrdo5rLJqCamz5AmOtMM7zyWgnt3eXOjCZnABSR/Wtn00Q5RWGGDFqE7VUMo/U1oN3yD9QWefXoVXD5C7odw/1hhXuDVsAGPhd7+DW+y0xJXG2+bpXHcuLQ79YDWhpZKnuSbYP6J4gz8MfYTw6MnHd5kIrT3RN9biLWoVqInHnVp8fSiC9mojI9mmtag3wGeBBoJBEGH/FjrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXwnpKDsnUEM4AHjTaJYhmCPnBTTfgRwXqDL4GQ3AjA=;
 b=AYbakB85pFuisAbhB0usksw7e3i2uOkrPa1ZKDX2IV+sPM6xah4eIDrCNobNPyaysgG3wLu1YoGyyiCC2M3r3o7GgHhm1+ZsolS0svAdxgHbNkKT8oIhomX6oRwXBarfhXsXv4D6bXZPX+HYV4z75EBKdPMpD02/qUK+R5694sOWG3ag+R3Mh2BlzgrtuWvQZ2UGXL20aACBff/c0pTKf1EUv1Y77cbgACl08K6g4P+eYVXsZndjdSKHmj9MimJjuY8VWErsBYiJLrno3bXNtbRogwMLFV62RBC9lmxr7aLmTctUS//gpw+IVF22aRdTqsYch5PiWC2ugj3o5pjc4w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7503.namprd02.prod.outlook.com (2603:10b6:a03:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 11:20:36 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 11:20:36 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, pbonzini@redhat.com, berrange@redhat.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 3/5] qom/object.c: introduce
 DEFINE_OBJECT_PROPERTY_SCALAR_METHODS() macro
Date: Fri, 17 Jul 2026 12:19:10 +0100
Message-ID: <20260717112022.444367-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717112022.444367-1-mark.caveayland@nutanix.com>
References: <20260717112022.444367-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR22CA0044.namprd22.prod.outlook.com
 (2603:10b6:930:1d::24) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa48121-34eb-4742-68ad-08dee3f56c83
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|921020|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lEZOlN/Btztzf7KatBkMt8s//X6WJscqcUjjxx8/M24g3JONygF0NbCjpCNqI3zZ/ugL4ETudiHNk/Yu6wnjrVrDeXUrGMRlnox2V1bwqwXZXDWAEyxszLNyY5dcDMctGTT0ivNgBk4fVF0HaMPruurUtXAEw/4cWFFbvoEvfS3ZSccjRyOG2Ax0AALMCYHDpQRhigQXfgR+yyw2aBZAtkjcL6VSK6JE+qp4Yeyt3we47WlrrBEJBFHV3mep36tH0ko6RDu3U5tQsiqsda4PAmRKK9Ny0z2G/H5qv8d5ndN/aCAp1ZYk/tX1se07DeY5WwVjFQBTKNkoyuLQHgD9ttcDpzzfKDUMAk4mAwtSLwP63ZJ8SbzOWh444LLZoCdiWe9SxHoqNu21+IC3VEzL13WKCr0nLbXPqvMNEBszeLMwgbcnihk9o7xon2z8FbmWjnN7a0WUhxaIkRt/cabojAEm89Jw2ydzZhqlTOF7rA0uMC9h41zMEesDGu+DhHpARTOdrfuJ/6UNlkCPE5TzT4dAJ1weuULK+CWqa718X5WkOTP3z3Mdj5cM/g1FM8r20e4J0iRoVXWkQwr+f+Vu+C/AhnD7rlwNkTNcXiCLbz4ppVOfUbsoeeLMLMJ2+Trf9PabkXbWmUkWEP7OqE5aQ1KT3wb0ugEcwmy0XlRPQfYj62V9wGds1otGgud419Fy6YIaZiYBxySEqn9VwGQMAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(921020)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D7349RMvn/INmUwgnySNGd3PFwER+nPsg2xZaKhjclBiNHayAfe0LWc4knXS?=
 =?us-ascii?Q?PABGTpyfdVyKvMfVE1QRqLGTw5Q8H1zRQbWAlcjcnjWeDx1ZmV2U0aVr2J72?=
 =?us-ascii?Q?ZtqKfGp/Q9iehM8uYmpOw5Ha5YxJECZMhbssOPAHfanSO7iHM61xupY2ijLp?=
 =?us-ascii?Q?79gaHMCb653Mu4IabUsBVi0VlvuC9ZG1XWcDbnZa+m1XnZtuQWaRJBP4vTtQ?=
 =?us-ascii?Q?pPPZ3pXLi/Y6WYO+07bPqOgN72ZHrr+oM533xFvlqb65UaycLHtbohfbVFsY?=
 =?us-ascii?Q?BByIaLMrvfbq75AfC0cHsn3xddkLkca5JJJj0Yb61ojNf7vj/v2aW0zSV2k5?=
 =?us-ascii?Q?yDQw5O1zx5cIKojBFm0NylptEidTM9E7YEGsaSyWMx/jkqta24EHXIKVNumh?=
 =?us-ascii?Q?TVHhPDwPup52eGcZI6wpXFrE6ERJM69evQE0IphkIdbjl2DCoBsg0DoWL0Y2?=
 =?us-ascii?Q?wIOmhJsFeREHyJStr/zRbsuNKVHVvPSoBt/UbkoM0P09s4GThvlbUiCIv+ul?=
 =?us-ascii?Q?47CroIX0WpfFvKD0EtBPXEvU8QFGBvOC7655ZpWcAepDXH4gK8k7XJS7Bzre?=
 =?us-ascii?Q?/exe6Vf5SimbisL+HFZFIOu646eRNHyAljvvAaYYRjUrLaVnzzoEsy+gUGMs?=
 =?us-ascii?Q?LvIUpWo5oudg8EJzyDPYkVz4DOawwceGoMR2zpZTync7EtwzLsL2KKcFpPew?=
 =?us-ascii?Q?8MOVpQ8nkpUh90TmsIUeGkVvlxeIx0HkfV7rLysxeTWkvez6x8t2MWy/X0fG?=
 =?us-ascii?Q?x7Ca/pD7pb98U/WIwIbRcsQfzjJHfkV/yjqHHxy+2nb5UBvuFY0oXhMTkfiL?=
 =?us-ascii?Q?+X+BWaW57N1fkwp7MZt3GsUaznBsTtwb2IBvrrwZ6gxNpQdTGZjwxj0yNB6R?=
 =?us-ascii?Q?bWTsuYRE6Lq+iAA6dmuHINZyQG1mCV/5+0A+6BNd6C0ClgSbSwBqWi49E1se?=
 =?us-ascii?Q?qMBKRoqoGre7t5zNpjOqypDJD8dbCVToOrI1695vV5aUgkXFbkWKHY6DlaV1?=
 =?us-ascii?Q?W2HlOqTbGPIzR1VA++yfu9ZUKh9B9CaaFmX+y3osTM5UbjQDRJKlKQawgl7y?=
 =?us-ascii?Q?epnby/Vf8zYDwIr9aT0Fcji3U75OMgXWeHWX/HPNVCK8cGHtByE6+YWETlaz?=
 =?us-ascii?Q?u7W1ISQQJVSwayBzW4SJJYIvgmM9lmQij00Sys4i+P1LlNKZ0wpVP/VORTGR?=
 =?us-ascii?Q?/ndByai40KGFVwwlp8+B+IYfe4HRAk7X7Qc3mNpLIYpzrTxk9Dh4D57xuR7Y?=
 =?us-ascii?Q?YApXrBqKaAEjvLvSz6SXRgu8pcBF2ICCr7cFDp2XNOSL42sc74HL3TD3RtKT?=
 =?us-ascii?Q?cYKP8u/kN7ZVHnESMkhdcywgTDQdLb5osmgW3gjMrnFEn8P2kRCscU9hUZGk?=
 =?us-ascii?Q?9BV7Sd7jSqZOqNKWvanBJilpgODL/alj3UaQxtfAou+3XZHWJDQ82mkLLPbz?=
 =?us-ascii?Q?bL96H4kqTOzyqtddUoV3rWRJEnS5ZdczbY5hMpQNY5dg7ax+mUElKUiDEWvW?=
 =?us-ascii?Q?GnvuhjKGnxMen/sofo81g1HrIk9kGWZXKyg2lkMYqhklMw0/DattvzvsYR5P?=
 =?us-ascii?Q?W95013jsTlzdS9vwPQ+8QgzGbuCjvWZBpqUq2OVCJzJYr16tNu5QqdeLwzAo?=
 =?us-ascii?Q?uT5RGv3JZCr9uvTYKQlGe76ct4KTQNbxJG4JCsQoFvcER3YNydiRyUqIE8nD?=
 =?us-ascii?Q?1x3WhBCJ2i8eOB4wImmG1KbkIRkHvlrsaDvh52Z091dcMOSexWOHP04M3qo1?=
 =?us-ascii?Q?H1kuttRMZ3/7CFAuJi203R7zXNhM5wg=3D?=
X-Exchange-RoutingPolicyChecked: K3UHSq2WXVE9aDTl8lvz1WwkbGIWzIFST7ak/Pud4S+PsqXK8qFHD7P3Xm/JFiNrYLIZjipr59bcvETePQymYGVEj8azzI+Yw68IyMwcGT255fjDCxyrp8U5mIF5nOzHilhr8T3cvIYLSaPhxDZTbpyhRyNVsus+yr6HSeYPh25zToHm2YSpt+G9vaqMo8XkDG6xcPncBbTOahpDKDJ+J81LLcUGyG64Jy5RAMsev6YHj/20+50PUUdwKYniAI4ItiqOI7OE5khke0qyTVnXCwwrH87IF55NpnYmNkMu0IKnOOED+RuFbRVpUba6p9mGBn5srpfXGu4ODcVmwHyEDw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa48121-34eb-4742-68ad-08dee3f56c83
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 11:20:36.1876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GP0Vn6Z6feckDMkiEFI2y11O1K5nUeChF4UJxGU/LSdlQqEhc5bjIlsfMgcxvYtM9iXljwQmhl890jMozYSVJOnlWTRbRESWGTtqRgp3+Ok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7503
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDExNCBTYWx0ZWRfX8oOzLlSvJhAM
 ofrAqX0FtlJdJDttpU2kjIabvmNBqiCnlg2OY8yIGqQ3GTdX34Hdblqmf3Re6edAhsLdbc3OpZ+
 NBbUIGkKlbZF5AVrQ/LY2TbaojKo+dQqHZNsaIS2GNUaA28qXsD78kdgIgbMrgmY7KZTdHUDLrY
 Y0g99W8qQbliYmm0yH00COnk/0N3lTjBu8ZCIceXX9m1GTbhyd1P/er3iSYqcQPgx3WiH/yMzvF
 VMswQTi0P/XPNiB8niF3+u5gr1oGSkbkZEbl6q2sTFndHdWpEo57okhwxHjzRoCY2XAiLQWbSQr
 hdgUgZd+mi4uEQylwQoTjIhMrc1biH0EF+EA9bIs2+Fh9Ot6lFbvXqRN4owrLSx/QeB8fOaBhal
 LX6aeLENcRyimPqwLbuHoRUgoByxOE1wMH5K17fi1MLjN3mxdQkTKGhdwq269AHbRDeYmq7yodl
 DN/l0CM18XOz9hqYJAw==
X-Authority-Analysis: v=2.4 cv=GecnWwXL c=1 sm=1 tr=0 ts=6a5a1005 cx=c_pps
 a=8ytssxGH5sXDYVMDm1fH2Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=MN20X9a0icJrC1ak0dwA:9
X-Proofpoint-GUID: O-owOWMVIM5jIUawo4YOr1RODzdR_Mhv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDExNCBTYWx0ZWRfX2OVVVmtrSCLi
 5/YzJ7lOQPpxu6nOCnj6dFR7q8QI+ac3PDPEH63QeWE30x9HaNcKPING+F7TJ4RVsyneds1UzmU
 st01px/x7evQM08pBeCfs9uMVggkM1s=
X-Proofpoint-ORIG-GUID: O-owOWMVIM5jIUawo4YOr1RODzdR_Mhv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


