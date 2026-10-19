Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DC5CCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm89-0000Oz-3h; Mon, 19 Oct 2026 08:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm7p-0000AF-T6
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:01 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm7i-00043p-Fa
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:05:53 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8P2Kn3283490; Mon, 19 Oct 2026 05:05:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=NC5YHIoqeDTuPOLSBXYV5C5Nu9aU8ejNXoZBPcpn3
 9U=; b=FRnIE8ToClMaQSjwqeHzseHxBxwQFgtMOpdVHk30nXLSmUaWZiiDhAwDf
 2fh4vI6F+3AlM0HpqN6Wu5/z4wMPkKugMu4U4HtrswKUFGgIc1tjeZ4qnRUhtL3y
 mcCMpPDDQtYV0P57+pE7rJUo2OC2LDvqBWDXNN790vQWqiOxSNOYzNeLAQO6gsbE
 x4gk1Sze5o1FTtFKS0RCAveTSOBWQAj5014HRq4ZOPE/tnz9UJjgF0gH/6C4PqsM
 68Gmui6L3S5jNsm0fqS05aYrsBxGNf6o+lJGK+e7v2I4mH+aGI+bowJ4/RGHhBLu
 tGivb+UJz1Vme4ce3h0p5Z0e7M2zg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021101.outbound.protection.outlook.com
 [40.93.194.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc74ekjde-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:05:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GC79D5yJPJQBoXdpCwqWh7T8FX4ROVSChgA9Pxx8IAXalK1pO4zkSDYpXAnYGzj1kHx+QBystRfeTkT4tU0W0V3SQmr/W2gPnnT3dgl3GDxo2U1f174HEhjQHaOS49JVOysQ6pOAEEW86DBTExyWhQf4bsookxz6ZG9ybcGkRKjrFNyBlgm5nFpBoHsg26FPHr6ifd9eS+teuHr7aNiu9q0jfxI/5diWo5CSfRngk4bVbKUu1TGdeuZl3Vx3LRTqZ8fYDE7MeqqaK3MqfsBCftTDQEdEiFKX2lCrUv0um0NsTuNsgGg0SYMMZ1O77+SxGbWNy95g+DqQc4jRLbfNjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NC5YHIoqeDTuPOLSBXYV5C5Nu9aU8ejNXoZBPcpn39U=;
 b=AQxxJ/fsKlDXyHeOEgXSw3UW1lqrnqMSSoCtMy8EdVN8vccNmQ4Y3yD7tjjaW+9WZmrYK/R8mFNeU/UMK6SUrG7z20CWX4lB96dtP7oRn4kATWlDE7TanAuQTmNJCXBtPjs49Jp176bj3h3NJGNbp1tMNTD7TJW1orswLzGAgE5HGX8ZIEn126GjyVh9F1NSEdqpIi1g9rxGLcafvav0QcRoGSHO47kbYA28cfwnSq5IxCjHdIxsFvP3ja1AOL1JrMqxdomgAr170ROI0GO6BfwV+YWGAXJVLFvzYxYq1SQ/+Ch6hoxQGr83sekxyeSLixhs84BNAGksPszaFecQFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NC5YHIoqeDTuPOLSBXYV5C5Nu9aU8ejNXoZBPcpn39U=;
 b=pn9n4g/181E1gURFv2pfkYvawkYbATKfhsNiN4nAeM6fzUZ5YpNtUQCmWCjx7djbUMEQ433R4AFC6Ecy2lrEnEPb2PM8srxkUSO6uLlnn+hHafHBYqonScmIUZ+acnYngREerINlo57HsCwpCTvEuVvtPBbk2txLwG9h8+uu44H/UX4P7JskRznSYJncoT0FV3qx9ibLIuDDMefORrMYCyhl+8GYNXRiXS9jJ6ngqYzHNFxOXTYmvjDwBsH7XIXKLyQcbDo3S5beBHYBMk4l3HIThdoSPwRXuJVODCc9/Z7ORKwVBuu36JYQksXxPjk/YBGGyYj6ok0rIQ6ItAEAng==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11441.namprd02.prod.outlook.com (2603:10b6:8:354::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:05:43 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:05:42 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 07/28] i8259.c: always use cs for I8259CommonState variables
Date: Mon, 19 Oct 2026 13:04:39 +0100
Message-ID: <20261019120517.1448687-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:a03:505::26) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11441:EE_
X-MS-Office365-Filtering-Correlation-Id: 07063558-9918-45c9-22bc-08df2dd94ca6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|22082099003|18002099003|3023799007|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 244lBnMqn8Y+lRt36jQCrdSrC+IGROLolon3xNIfSdIItL7DabwGaxxnTG0TMyppg6pnKnniickaeOGHul4sQxN7zyi6FjakFlFzJBek2IQCcK99HWZiGa1GJPGo35HUbTP5x7AJPbDpjoG0iHStHIMo2olVyEOxim0mL6JAxuRJOqxOegJRrPNykRp9ppCaeY3YuFDqv7foJWtnIo72WzWaM4qNpQu8MUw25TIbA6LeVyja7KI5VGqYkQkwScax7jS2Io+g8PMJthzI6PhCegPXZmuiLIyvNgg7xf0t+dzSCDK3Ytcz8bAbQyvA27S2HpA/nRTGLYIouUJWxv33pjWzueUfbznG0sLT4f7pBKmlGmrznrMW2qWzH7A6+F+7b7gGer8961V65OkyehvGNJvcKEvDj6H+sAIsrWamOkiiZ2q+xt1FYkmWZnrMWjEPWAi6HpR+HA+ZCRRmkcXlebQm67hJjV9VDv6Hrjao6eIaP38xWZ7zeTNJ0r9xKsh1Ab0zsnQKD+UJbQ+UH2eb7TCMNOjRttpNiTv8MNAo+SUECTwrqjAmhrYSUIRHjB9byPPg5BcyvjC280W5f8AdK8IZfqbNo99TKxDY/ToSSL37oaB2joHwRgkX9AWddZ5FppcyT/mansICMX/0WbE01g/cZE5/AxNGFRRqROyvUF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8vqc64su6tj89wT0f8jbhXjdsDoDMb8+0n7xppAEYMCFd1C5avkrpZYu3ZrJ?=
 =?us-ascii?Q?IeW/p1v9FcE5Xq5ecFwNOiZ8f9idcsUCA0STYnVHbeAFto9p7MlbNgCNkHqQ?=
 =?us-ascii?Q?ad/Mjs56bqqTJgYbFJv57+12mfevzHSLG7muOrlrjKJ0gkScpb8gVp4FUoou?=
 =?us-ascii?Q?MGK/UAkWWuSSQlZfNnk+t3g7pC7Zd6Q+x/1fhJ2dm0YIXj9UTrdVnFBFr9VL?=
 =?us-ascii?Q?ak3JCHv+30Pcl9WBZC6U/6wF/0F4UMAi6wCJTLB+ajZKOFSDdwDbOLdkAkye?=
 =?us-ascii?Q?A4/vN4hR8mAOw3EYNYkzz4d7GpG+a+pQ2OXlexYHGFDKd7+IaLOB6mTOo2KH?=
 =?us-ascii?Q?wvJqW4VYGutwRy1/RgGNCmTWHV+4jXgunBzs9qJNZTWayKGnTQHgnq5eORIO?=
 =?us-ascii?Q?AOxv1CmzLP7EIxQbueFeMdj9ZJpvykugpFA6a9Oor+9TCzupWixVnYfFwdHz?=
 =?us-ascii?Q?n9R1CaeUDTidEV9NSlX6ES9oBGb0aE9E5M0EY+DSimfJgCR5Gto/7YAfyDUE?=
 =?us-ascii?Q?UTSwb9N9qbpWvUtWPdUpCae1VV019qBtaf5x0732wLkDkbX/DGOOaTijsHEb?=
 =?us-ascii?Q?3N3Jgz7uhUZbiygpBUbHV/ONQmcve42wdGFUh/CqpL/wprjJ2UO+ajqD1gl+?=
 =?us-ascii?Q?s738NhSui0V9Lnqf25hoeRPqRHiFq3HlaWL/68sKkhjHYfmJX68mlU9tArcS?=
 =?us-ascii?Q?rSCX4tmDgQvryotIry6H0K5+f/LnsWPaKOxZ2fFLeguHzKfKNVQ6ahCyCSR2?=
 =?us-ascii?Q?7We2lq/8HaIbmGo0t3ZfgoJUIIMHd5EnFfUlc/inIId8yp8smhlp+cEMyFxO?=
 =?us-ascii?Q?ed/huKhHrhXfHgayMZ1ujbzyOcswHklNib1Rfn5Zl/KdjA4VOD/EMjAKt9QU?=
 =?us-ascii?Q?FqzMgExA21PjQoCBHt5jGltHgLHa/vOTl8b/pLkX6grebF/4uRcHQuolAPWF?=
 =?us-ascii?Q?8ZI4bnyIqJkIZM2dIaIR/WeV7d6v4jzPNgOXStAJ3f/zu5up5ifPEefuG4Y8?=
 =?us-ascii?Q?3OCbpHGrbrfRLTtSP33YwTmAiYdGUe0u5APCH9SrGMc92FBOJZvZGy1vwU/E?=
 =?us-ascii?Q?6cVA0F+3rVgznfdQgSiZYZduRiAqX1PXBvPO/7i7yZwSE6Ltzv8q04geavHw?=
 =?us-ascii?Q?z+Vo3e+SnAiGjvsRZy+/q9gTJnkNo/A0Bwwf8HgoC2Iq1TZIaIkfNfyt6/wx?=
 =?us-ascii?Q?tnIUJuMYL02I+QAepptbcGLSzAyuxkvgxNxteQxk9NKfDyP4p1L5iFU7piTc?=
 =?us-ascii?Q?yYijokEDkyzV175afOmLdmxJhoEOQ79En5VzIa4SyGRy8AZquffD3xPDx8N/?=
 =?us-ascii?Q?/3aXec1CxapIOrc+gKJ6eP0S5jJ0P+/B3kI+4c1RBBJhRjaJGxVxO7IX/lIC?=
 =?us-ascii?Q?J75j/3wW0SIMpXXH++T3h88g0NJ4UKIP/bEo8yEuRLcTh6sF+t9U46RSpMHn?=
 =?us-ascii?Q?vXpq2brpDIex8s+uYuHHigBaIGlb9BY3jYOXr4TjeA433Jn/M0uy4a0ichTk?=
 =?us-ascii?Q?OPHrMjMQh8gF1DxxRR4Wn4whhBqJ3HhK1EqrWcIvXr9zySEtXr+Cay0s7J86?=
 =?us-ascii?Q?upLV/y3Ke8ie+7oeL+17hl+NSiX1olyM7SB+EkN5YouOFhve5fS1i+uK97c6?=
 =?us-ascii?Q?pswKP8qBQeQUExmboXzQDytuLR8yW5bC1TpwYxSvjNNZWTXKJ1eMQn33wlTU?=
 =?us-ascii?Q?uqu1hp+MzBtkfBXbsPrOmhXhW7eWuhzSx3byZIJ53egcDpcYAaoaIvJbAwta?=
 =?us-ascii?Q?EpTaWnzw/+MQ9RFLysNL2/Sbn9hlr5A=3D?=
X-Exchange-RoutingPolicyChecked: x5ACcYjDWpeqlcJbkq9YQ9/y8Nv2sRC7OalSFGPokE59P6pY3PLKXLTDQSB0TFjhsDlPtAZqN+bJvxBIP1UlCEGeR9n1cXC+npxBOKk88uAUAtJ14kFwJ8InYRIDg6SGsECSbfzVHJbJesejUtiJgf/fVxvxH0wQILWUGEx4sRG6xm3wrm621HiS8v3Wk6wS/eFG1EDBz/Cvk1blDDJApR3juHUhUyEQNdVBrmx2g26yRdgsmWdn/XbZao/ewb/jwOoEWJHfD9c/hVlW6IxxC5rE+FZWS0DcntFdi6Ezbha+6wcfRLJ8uivfvqtT4CZmSIuNiztUidllVMtroz4m2Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07063558-9918-45c9-22bc-08df2dd94ca6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:05:42.9315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wry+5EFmt0TqmLZAqbj7qMuTw6fb+uB1dcG5maJrtWhxHk2iYlxTKqAvEkcu9g81TtU8nIRh3Yrfo0wYLwJ8ovM81ZYa4rQqmRDI0zpKrkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11441
X-Proofpoint-ORIG-GUID: uIwzEKv8Xq8kfnRRKodO2WM-WSlOXeK0
X-Authority-Analysis: v=2.4 cv=HYGB3SE8 c=1 sm=1 tr=0 ts=6ad60798 cx=c_pps
 a=+kXwOJT9iXP9BgnuWAWdUA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=zV1iqHTY6MOlpgDiNWkA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: uIwzEKv8Xq8kfnRRKodO2WM-WSlOXeK0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX66pxBqu2UxPH
 mNqmiyt39EFg37e2Rsv0SWq5tJX85EucWGgX1jwxcEyDtU0h+aOsP1L4sHs/QE+Owxkz2Dy4s4c
 vHfUTRqeGMG3iHTrFEFerlINBfTB0Pc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX1WpSfkzR+T3b
 yeMAebXdKFw/lYn2tHoYifqjywXUZVNMkfy+Axc12HBY4oW0AikvpXP/rx96OlXJUbm+59Y0kjL
 y/W7RgL3UES2dPOXqpXOmnzVxdHrovVlcMn48bqFpO3CciXMyiJ5nkJMkRrXA+wDLItDc2ShOn6
 FZZzmAccpbLwZTJLlMj4+jNcfSwR4kgSc0o3MC4rFws5nNcrrfs6cHMkWiypnTYRBIRdc+ilUaa
 4ogPxwZiG6HUGuK9tMo3yZj7os5PL3G2g44JaS/9lsgmYndZVC4QHNq4zJPXcQvyfN19egVaB5S
 0H3fNC8OqercdzBfOS/1XkwX8srJVUkWv1gXzfDJ4dUf4bhl+O7rE6fnY/xNjHgTiub5GKpZxg9
 zLcodQ6IsYPQHZPqPOtu6JNK6fVqgMvbckiV+sIrTWDVRwNP2goTbGEu2+HPxRvtxkxDwVu75ho
 EzoxJU0TQDxmJnTdWDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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

The use of consistent variable names makes it much easier to follow which
fields are being accessed from I8259CommonState.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/i8259.c | 192 ++++++++++++++++++++++++------------------------
 1 file changed, 96 insertions(+), 96 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 81827f2734..700412df74 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -59,7 +59,7 @@ static I8259CommonState *slave_pic;
 
 /* return the highest priority found in mask (highest = smallest
    number). Return 8 if no irq */
-static int get_priority(I8259CommonState *s, int mask)
+static int get_priority(I8259CommonState *cs, int mask)
 {
     int priority;
 
@@ -67,63 +67,63 @@ static int get_priority(I8259CommonState *s, int mask)
         return 8;
     }
     priority = 0;
-    while ((mask & (1 << ((priority + s->priority_add) & 7))) == 0) {
+    while ((mask & (1 << ((priority + cs->priority_add) & 7))) == 0) {
         priority++;
     }
     return priority;
 }
 
 /* return the pic wanted interrupt. return -1 if none */
-static int pic_get_irq(I8259CommonState *s)
+static int pic_get_irq(I8259CommonState *cs)
 {
     int mask, cur_priority, priority;
 
-    mask = s->irr & ~s->imr;
-    priority = get_priority(s, mask);
+    mask = cs->irr & ~cs->imr;
+    priority = get_priority(cs, mask);
     if (priority == 8) {
         return -1;
     }
     /* compute current priority. If special fully nested mode on the
        master, the IRQ coming from the slave is not taken into account
        for the priority computation. */
-    mask = s->isr;
-    if (s->special_mask) {
-        mask &= ~s->imr;
+    mask = cs->isr;
+    if (cs->special_mask) {
+        mask &= ~cs->imr;
     }
-    if (s->special_fully_nested_mode && s->master) {
+    if (cs->special_fully_nested_mode && cs->master) {
         mask &= ~(1 << 2);
     }
-    cur_priority = get_priority(s, mask);
+    cur_priority = get_priority(cs, mask);
     if (priority < cur_priority) {
         /* higher priority found: an irq should be generated */
-        return (priority + s->priority_add) & 7;
+        return (priority + cs->priority_add) & 7;
     } else {
         return -1;
     }
 }
 
 /* Update INT output. Must be called every time the output may have changed. */
-static void pic_update_irq(I8259CommonState *s)
+static void pic_update_irq(I8259CommonState *cs)
 {
     int irq;
 
-    irq = pic_get_irq(s);
+    irq = pic_get_irq(cs);
     if (irq >= 0) {
-        trace_pic_update_irq(s->master, s->imr, s->irr, s->priority_add);
-        qemu_irq_raise(s->int_out[0]);
+        trace_pic_update_irq(cs->master, cs->imr, cs->irr, cs->priority_add);
+        qemu_irq_raise(cs->int_out[0]);
     } else {
-        qemu_irq_lower(s->int_out[0]);
+        qemu_irq_lower(cs->int_out[0]);
     }
 }
 
 /* set irq level. If an edge is detected, then the IRR is set to 1 */
 static void pic_set_irq(void *opaque, int irq, int level)
 {
-    I8259CommonState *s = opaque;
+    I8259CommonState *cs = opaque;
     int mask = 1 << irq;
-    int irq_index = s->master ? irq : irq + 8;
+    int irq_index = cs->master ? irq : irq + 8;
 
-    trace_pic_set_irq(s->master, irq, level);
+    trace_pic_set_irq(cs->master, irq, level);
     pic_stat_update_irq(irq_index, level);
 
 #ifdef DEBUG_IRQ_LATENCY
@@ -132,44 +132,44 @@ static void pic_set_irq(void *opaque, int irq, int level)
     }
 #endif
 
-    if (s->ltim || (s->elcr & mask)) {
+    if (cs->ltim || (cs->elcr & mask)) {
         /* level triggered */
         if (level) {
-            s->irr |= mask;
-            s->last_irr |= mask;
+            cs->irr |= mask;
+            cs->last_irr |= mask;
         } else {
-            s->irr &= ~mask;
-            s->last_irr &= ~mask;
+            cs->irr &= ~mask;
+            cs->last_irr &= ~mask;
         }
     } else {
         /* edge triggered */
         if (level) {
-            if ((s->last_irr & mask) == 0) {
-                s->irr |= mask;
+            if ((cs->last_irr & mask) == 0) {
+                cs->irr |= mask;
             }
-            s->last_irr |= mask;
+            cs->last_irr |= mask;
         } else {
-            s->last_irr &= ~mask;
+            cs->last_irr &= ~mask;
         }
     }
-    pic_update_irq(s);
+    pic_update_irq(cs);
 }
 
 /* acknowledge interrupt 'irq' */
-static void pic_intack(I8259CommonState *s, int irq)
+static void pic_intack(I8259CommonState *cs, int irq)
 {
-    if (s->auto_eoi) {
-        if (s->rotate_on_auto_eoi) {
-            s->priority_add = (irq + 1) & 7;
+    if (cs->auto_eoi) {
+        if (cs->rotate_on_auto_eoi) {
+            cs->priority_add = (irq + 1) & 7;
         }
     } else {
-        s->isr |= (1 << irq);
+        cs->isr |= (1 << irq);
     }
     /* We don't clear a level sensitive interrupt here */
-    if (!s->ltim && !(s->elcr & (1 << irq))) {
-        s->irr &= ~(1 << irq);
+    if (!cs->ltim && !(cs->elcr & (1 << irq))) {
+        cs->irr &= ~(1 << irq);
     }
-    pic_update_irq(s);
+    pic_update_irq(cs);
 }
 
 int pic_read_irq(I8259State *s)
@@ -213,81 +213,81 @@ int pic_read_irq(I8259State *s)
     return intno;
 }
 
-static void pic_init_reset(I8259CommonState *s)
+static void pic_init_reset(I8259CommonState *cs)
 {
-    pic_reset_common(s);
-    pic_update_irq(s);
+    pic_reset_common(cs);
+    pic_update_irq(cs);
 }
 
 static void pic_reset(DeviceState *dev)
 {
-    I8259CommonState *s = I8259_COMMON(dev);
+    I8259CommonState *cs = I8259_COMMON(dev);
 
-    s->elcr = 0;
-    s->ltim = 0;
-    pic_init_reset(s);
+    cs->elcr = 0;
+    cs->ltim = 0;
+    pic_init_reset(cs);
 }
 
 static void pic_ioport_write(void *opaque, hwaddr addr64,
                              uint64_t val64, unsigned size)
 {
-    I8259CommonState *s = opaque;
+    I8259CommonState *cs = opaque;
     uint32_t addr = addr64;
     uint32_t val = val64;
     int priority, cmd, irq;
 
-    trace_pic_ioport_write(s->master, addr, val);
+    trace_pic_ioport_write(cs->master, addr, val);
 
     if (addr == 0) {
         if (val & 0x10) {
-            pic_init_reset(s);
-            s->init_state = 1;
-            s->init4 = val & 1;
-            s->single_mode = val & 2;
-            s->ltim = val & 8;
+            pic_init_reset(cs);
+            cs->init_state = 1;
+            cs->init4 = val & 1;
+            cs->single_mode = val & 2;
+            cs->ltim = val & 8;
         } else if (val & 0x08) {
             if (val & 0x04) {
-                s->poll = 1;
+                cs->poll = 1;
             }
             if (val & 0x02) {
-                s->read_reg_select = val & 1;
+                cs->read_reg_select = val & 1;
             }
             if (val & 0x40) {
-                s->special_mask = (val >> 5) & 1;
+                cs->special_mask = (val >> 5) & 1;
             }
         } else {
             cmd = val >> 5;
             switch (cmd) {
             case 0:
             case 4:
-                s->rotate_on_auto_eoi = cmd >> 2;
+                cs->rotate_on_auto_eoi = cmd >> 2;
                 break;
             case 1: /* end of interrupt */
             case 5:
-                priority = get_priority(s, s->isr);
+                priority = get_priority(cs, cs->isr);
                 if (priority != 8) {
-                    irq = (priority + s->priority_add) & 7;
-                    s->isr &= ~(1 << irq);
+                    irq = (priority + cs->priority_add) & 7;
+                    cs->isr &= ~(1 << irq);
                     if (cmd == 5) {
-                        s->priority_add = (irq + 1) & 7;
+                        cs->priority_add = (irq + 1) & 7;
                     }
-                    pic_update_irq(s);
+                    pic_update_irq(cs);
                 }
                 break;
             case 3:
                 irq = val & 7;
-                s->isr &= ~(1 << irq);
-                pic_update_irq(s);
+                cs->isr &= ~(1 << irq);
+                pic_update_irq(cs);
                 break;
             case 6:
-                s->priority_add = (val + 1) & 7;
-                pic_update_irq(s);
+                cs->priority_add = (val + 1) & 7;
+                pic_update_irq(cs);
                 break;
             case 7:
                 irq = val & 7;
-                s->isr &= ~(1 << irq);
-                s->priority_add = (irq + 1) & 7;
-                pic_update_irq(s);
+                cs->isr &= ~(1 << irq);
+                cs->priority_add = (irq + 1) & 7;
+                pic_update_irq(cs);
                 break;
             default:
                 /* no operation */
@@ -295,27 +295,27 @@ static void pic_ioport_write(void *opaque, hwaddr addr64,
             }
         }
     } else {
-        switch (s->init_state) {
+        switch (cs->init_state) {
         case 0:
             /* normal mode */
-            s->imr = val;
-            pic_update_irq(s);
+            cs->imr = val;
+            pic_update_irq(cs);
             break;
         case 1:
-            s->irq_base = val & 0xf8;
-            s->init_state = s->single_mode ? (s->init4 ? 3 : 0) : 2;
+            cs->irq_base = val & 0xf8;
+            cs->init_state = cs->single_mode ? (cs->init4 ? 3 : 0) : 2;
             break;
         case 2:
-            if (s->init4) {
-                s->init_state = 3;
+            if (cs->init4) {
+                cs->init_state = 3;
             } else {
-                s->init_state = 0;
+                cs->init_state = 0;
             }
             break;
         case 3:
-            s->special_fully_nested_mode = (val >> 4) & 1;
-            s->auto_eoi = (val >> 1) & 1;
-            s->init_state = 0;
+            cs->special_fully_nested_mode = (val >> 4) & 1;
+            cs->auto_eoi = (val >> 1) & 1;
+            cs->init_state = 0;
             break;
         }
     }
@@ -324,30 +324,30 @@ static void pic_ioport_write(void *opaque, hwaddr addr64,
 static uint64_t pic_ioport_read(void *opaque, hwaddr addr,
                                 unsigned size)
 {
-    I8259CommonState *s = opaque;
+    I8259CommonState *cs = opaque;
     int ret;
 
-    if (s->poll) {
-        ret = pic_get_irq(s);
+    if (cs->poll) {
+        ret = pic_get_irq(cs);
         if (ret >= 0) {
-            pic_intack(s, ret);
+            pic_intack(cs, ret);
             ret |= 0x80;
         } else {
             ret = 0;
         }
-        s->poll = 0;
+        cs->poll = 0;
     } else {
         if (addr == 0) {
-            if (s->read_reg_select) {
-                ret = s->isr;
+            if (cs->read_reg_select) {
+                ret = cs->isr;
             } else {
-                ret = s->irr;
+                ret = cs->irr;
             }
         } else {
-            ret = s->imr;
+            ret = cs->imr;
         }
     }
-    trace_pic_ioport_read(s->master, addr, ret);
+    trace_pic_ioport_read(cs->master, addr, ret);
     return ret;
 }
 
@@ -361,15 +361,15 @@ int pic_get_output(I8259State *s)
 static void elcr_ioport_write(void *opaque, hwaddr addr,
                               uint64_t val, unsigned size)
 {
-    I8259CommonState *s = opaque;
-    s->elcr = val & s->elcr_mask;
+    I8259CommonState *cs = opaque;
+    cs->elcr = val & cs->elcr_mask;
 }
 
 static uint64_t elcr_ioport_read(void *opaque, hwaddr addr,
                                  unsigned size)
 {
-    I8259CommonState *s = opaque;
-    return s->elcr;
+    I8259CommonState *cs = opaque;
+    return cs->elcr;
 }
 
 static const MemoryRegionOps pic_base_ioport_ops = {
@@ -392,15 +392,15 @@ static const MemoryRegionOps pic_elcr_ioport_ops = {
 
 static void pic_realize(DeviceState *dev, Error **errp)
 {
-    I8259CommonState *s = I8259_COMMON(dev);
+    I8259CommonState *cs = I8259_COMMON(dev);
     I8259Class *k = I8259_GET_CLASS(dev);
 
-    memory_region_init_io(&s->base_io, OBJECT(s), &pic_base_ioport_ops, s,
+    memory_region_init_io(&cs->base_io, OBJECT(cs), &pic_base_ioport_ops, cs,
                           "pic", 2);
-    memory_region_init_io(&s->elcr_io, OBJECT(s), &pic_elcr_ioport_ops, s,
+    memory_region_init_io(&cs->elcr_io, OBJECT(cs), &pic_elcr_ioport_ops, cs,
                           "elcr", 1);
 
-    qdev_init_gpio_out(dev, s->int_out, ARRAY_SIZE(s->int_out));
+    qdev_init_gpio_out(dev, cs->int_out, ARRAY_SIZE(cs->int_out));
     qdev_init_gpio_in(dev, pic_set_irq, 8);
 
     k->parent_realize(dev, errp);
-- 
2.43.0


