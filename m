Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A442CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 15:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNu8b-0003QZ-KG; Fri, 15 May 2026 11:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wNu7j-00035I-M9
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:06:48 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wNu7h-0006XZ-E0
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:06:47 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64F9VosW060336; Fri, 15 May 2026 08:06:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=AjoeTPLsKvG6E0Il8LRw+iVIVMOrTW4L31GgU38FU
 OQ=; b=HXQAgFNiYwsHy5P5o8W3k3Va7yv1aIDtO/FM1v0i4/WmD7oN2c/Fg4Czt
 x2N87Y9lztDey2EoTKkBR6YxR7QwLen8e0t4F37ORcVcN8G3FHKSpOzDLHlPEktv
 LAcPNq1NQqH+7DXNa/KZNTdbo+GHLdxGV2ADjXRd/t/5HBy0Zawlg0JiQC6lg7Xu
 YwyhYwsJD+bDjXqlrMZoJ5YkloQxY3WLUMcd+wXU4GF+r7CxtD6eZ+DTesZi96eZ
 aOlnFgeTCiHyPezcE81Suz2g8nmkdJvKaqI5wS6nD2ZwyGegu+QeXeOBfHxT56KY
 9iEFHjPsvhm3qcFSzhINlbWOLuGcA==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023092.outbound.protection.outlook.com
 [40.93.196.92])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4e5m22aa1q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 15 May 2026 08:06:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8EBu1buY2a+Cr1jhkz5pkD2nQfjrWJHmlTuYXEAf7k8c4YdrCYwzDf5XROsl7GCjHZO9RGH1APrU8RggqrKLz25MfSz34vaGfSfIyy21Cbo4F7T1UQaFtc0OPkoQA23o2FAh4C2/KVK5vMFGpuMeD3nWnAISZhAHDknOpgpDCPLZM0MNomB3Z8NmovPzJEOSmjjWn41cqozDxX5vbzHDJimNUjv6R0yzI2Q21cYCqMgJ1QBpxZNSyAdZPlQDKsDwTcVLCqx4WxolAMROaD2x/1R20gQwj8SUXYcfbs4/FtbO/j5E1rzsOVsqjpIVl5KC4/QG4ml2Ke6o9CP5HZs1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjoeTPLsKvG6E0Il8LRw+iVIVMOrTW4L31GgU38FUOQ=;
 b=PdJVXcqc3hf21cMymEpBZXspKERFMD6+DNeSHss4s3oiBwFBX+op2nxVyfiMP7KsYiZriaMuZ+O8YABiHDVnFrslgjdCM7fDcba6EtX31OOdq5QC8w3wiugPQw92unLkgxUCVijs4wZcpVwAcimPVORxC8GnvDimItfVzl84ZrgaGOT9cB/c/mawfv2ZuCLhkONKafkOsAwPRdbomat4YRe/oJTVL08NdHC56fOCrQIAKJEkVCwkaklAYNqDjvI2MFayscTQJynLWwIvZKLHC5rBXSpeXLtT5v10udVYicf84HWEycwGwZqGRlIlf64Xw69VFQfNE6j2UhHkduDM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjoeTPLsKvG6E0Il8LRw+iVIVMOrTW4L31GgU38FUOQ=;
 b=sQ1ZbBpzowzUWz130n2lidw9ey849hWE1jr7RFlxVA6c3FQmUI8DWTDybkE73/xEXNZ9IU2VtZNjC9PqEEArUrjmB+8zEGkKaUIH3pUvo8gIIgDDE3q8UpKiyKf730Zry8J5TGXZKrQSU8y1eeSWmlZvtCVVSI/8qh5jQv1ooW5z3jQ06zSOqxtXbM6LdTZKI8puB9fWer3y0BoSmT8YHy16Gl0UCefwXuTaN7yYq69Y6Ye6V0HSHpXEg8EkHauMvuxJ55CRcBhIBDKvg959p1UJs+nNICTH6Pc3tn69l1w0I4nOuLuqSeb4x258dWTTurOjuAplLyZk4gPniN2fDA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BY5PR02MB6517.namprd02.prod.outlook.com (2603:10b6:a03:1dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Fri, 15 May
 2026 15:06:42 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 15:06:42 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 1/4] hw/acpi/aml-build.c: add aml_irq() representing the
 3-byte IRQ descriptor
Date: Fri, 15 May 2026 16:05:44 +0100
Message-ID: <20260515150634.2637533-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515150634.2637533-1-mark.caveayland@nutanix.com>
References: <20260515150634.2637533-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR13CA0015.namprd13.prod.outlook.com (2603:10b6:930::24)
 To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BY5PR02MB6517:EE_
X-MS-Office365-Filtering-Correlation-Id: 799c3390-d89f-4d09-6278-08deb2939263
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: mqQ4VdP+kluyFjZmtdb+xQLGBu5adXwsyc7xKvmXTYL27b3vERoYrPJ4vHDPBZyJdERN9fDXz68J0rOO0uMeyzIRb5RfqR1impviyI+/6Fo/pLanbbDua4NUZOz7k10umIamfIwRRz12uieSpmzLdleUSVw55wdtsS+PXtE9VKpgLtXs6YXkYFtqAlvYPtCu2+hye66P1RffgKQKwUwCSHliwqU1B4tQ5orHtZhg1RD9PZkC4RdoiYZ013nWguHDE/C9CHqw/gxq8QHUl1KFQzE4JhrnLZVTpg0WJmvDvJRntC+m7nzzSgp5WQdRJCqAUb7+h3SOTmtQwMIiTCzaMXpcpp6258j6BJE+Ov51/FKbIworklj9z+Ew/D22yMcbdwkHYC6oTZ0X+6LdedBXdw7k84qfBG269JLzY48wB1avJ/vnMtarSUTujdhk+1YwNtRYZeLK3HfMQagmmYqvIG0wlXT5C7IjWV+1AFrw4/MfdDbb2SW4JscEFM+onHm1gAZ3Nobeo4ZZtlt+bJbDZv86BXAEqM1uL1ag2em3n1NDtmYv9pn8IgPYgrLHV/Ayoon/gUsyHsedmD/U5b4IYKKunOvFzTekSKIV/aiUTNaAx6UEHxy1JNPprp3iGRnh1oeh1CymfwjKhqVnCQiilMkWEt7bmQ5W6pyQLoBYDhAmuA4kfcuUUZO6bqcGR3tQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kwFmxAZY3EHzuadChOQ8a5n+o1NeXYN378i5RtWaJ/2hxWBtq3kgCQLjq3s6?=
 =?us-ascii?Q?IVV/xvjiuxEtH7KcPr9SDXm6OWbkd8IiyLttZKzD4KZjiTSxs0J3vhU+tRWe?=
 =?us-ascii?Q?8qXxWTzpnVBIcDle+Lv+Ln19mZhA5p2ia7xN25SBPFbrOsdJOf0nqufoGvnh?=
 =?us-ascii?Q?E/METQ7eC0o9nDs61RwcDHcZDjzPe1byspgNu+3g5izU5qgbR5RU+SOM4rfK?=
 =?us-ascii?Q?KbUtcu8A2fDtMwDFTxzbhAhKqYCrSyAD6q3dLo+pNFjxADM/n87sUgZywDqw?=
 =?us-ascii?Q?z/0NpsXnvwbYX4Rb2Bc5gsLTYMIs9Je9vErxz5nYwWakRtX3DeT/nDbx9fBL?=
 =?us-ascii?Q?d3gHe/eEGOREjrZhvCO7lxKwsS4ApfeitMNgqF5CQJpVPk/p5BWRZT4qDF1q?=
 =?us-ascii?Q?ea/AEUbIVxJr38+FTWB1UvpAaU9S+RKmm6H8uW0+mtFYMyvqRndasgoOrHUG?=
 =?us-ascii?Q?oo3yduRT5z276964gll7WE+14jMdIkhmHWd0L5VBfpQkzKeUHXJRH1euR6a1?=
 =?us-ascii?Q?PYoN9jGsT6aoAzlUevL5ZzRuVmKJ+Tldva+Z1oP8DaziwdJhsh9fwEvtVFEa?=
 =?us-ascii?Q?PDBCpdHrK2ejVunEG2Q2gFqb8rYFz60AlAkMmRHO9q6afEGXIHMtkedSGJmS?=
 =?us-ascii?Q?De2UeG36P/sowGW95LTt3LYqXbvxkbzoD/Sf6IIGkRVqnCPDa3elXbEqVYyF?=
 =?us-ascii?Q?5c6GZiKS5UAe07A4+gahQdB4yUsECqvHi++8EPrzyEbjaBaDOO902a9cdf+E?=
 =?us-ascii?Q?kvMYxeS+v/l7vIGc4anyhbdYDJqiPuP5DewqgHYngQiIDCjRNFdY4gaaiJRu?=
 =?us-ascii?Q?6pdxpL0ckmXAftz3EhMqPTk8NJGHSkDZyNjAR7mSJDWXUqt3s/YgUI8L9m6n?=
 =?us-ascii?Q?yxdNqv7a98Jj1t7XYw0PEe/+Ttx1OMGz1VTH/isMXnsKSR0AtS28xr5Twi6X?=
 =?us-ascii?Q?bUb1VrHS9cAXaXdRKaX5QzgOYKdRknBLm+wVRr8QYe+PL452XpKllbH9vWKM?=
 =?us-ascii?Q?6mNCUxpZMbn4pBSFijc81xHpXaVt7f/PROc95iYxkLaV8078mJb6PEaK+g7m?=
 =?us-ascii?Q?M4my7TXH3RMgchw56iwkx+oDjY+l0C3TP08BMU+dM4//9BYQsMrw/xFVgOXT?=
 =?us-ascii?Q?zHPl+eHNL+FsOvZJHJvTUF08ettlT27mxcvjZGXexfhPH839R4nmurbJKkbe?=
 =?us-ascii?Q?+sPti2oQonETab46Mpt5heSx7dbeqYfD27qI2slLbSepEGFkeFiNL6kb99UI?=
 =?us-ascii?Q?bKBBRW/CxRiLnl48zy8mWSz5sZKW+ZdyaXl9nlIrNXNEHUcXUBAXU3ZQEtfk?=
 =?us-ascii?Q?o/4cmuoVvC2jfgdsRL7NDIdSxMu1tY/HcyE4vmB9jrh7D+ejzC+6f9McVW82?=
 =?us-ascii?Q?W9mnhYyQ2R8n6Pa/C5d8GGnMQE2fy7c9bS9pnv3Ac8ikyCwSC62tcTx02mXP?=
 =?us-ascii?Q?c5V3uYja5ZjwPhB2EwqQDFggJfyrPqpumG8WUXz5Q0a53JVTysA9a3lhnjrK?=
 =?us-ascii?Q?trmiNcuIbHOeYmosSJbtWMGT7OocdxnmOUsNcHEYphfsVgcRulyvtbsPvZKn?=
 =?us-ascii?Q?/KJxc3Iu5JKWqiG0pAJPDihASxIo4oko12ioj7iSHGEoErns74M/NdYQHsEC?=
 =?us-ascii?Q?tygv0Y967YeDrfxrAMgnKs3WWzauj0BR/wi9HNJk7hoQQ3RplRrM6smTubmy?=
 =?us-ascii?Q?7htyuljKeOd2SpbCXtYSO+z51yF+5Y2ddboaW7tWGGjhePv5L/OD2KeDa63v?=
 =?us-ascii?Q?UPr0g5JEZ+CwK3zNY4s8IuhpjdIGnqU=3D?=
X-Exchange-RoutingPolicyChecked: ezDNiz12o+d94LyJbHmwroHlRihOBH473SIteLHf7xi8wyzvwJ8WlBT6vKjxZ5lVUvjhqrKsln936heagShDR9IztA29IzcV/ZEFo5gBAIDqkTUApFNTJnsfbc0LpLLndAtu2SRPp+smCh0k6UpDZLpgo1PA8ewM4ssbJz2f7zq2fuIOVHFf94N+eZBf+0T2WlmPsruTBIZRHNS7OiaIRWJmoraCXui9Q+wnBb+N0tMWrycvvcmeWSUZk/OGZhzpnCtamKqyoYgi/F71AQnPoGSshVnXMkvTu3f3TcInWsyWF7/fuJYYLkZbaxe4YiUDr8ceyPiLr2lOxqMjHurk1Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799c3390-d89f-4d09-6278-08deb2939263
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 15:06:42.1573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8BmZibJ0DBelS0lyC/0Fy1h+5bQLmilc1WkajG0FA7z97U1zYshVzl/ITyYifRpkwrK1GxEEMMavpC05zFHNzhQ19LAjlIO3o3gE6Ita7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6517
X-Authority-Analysis: v=2.4 cv=Eff4hvmC c=1 sm=1 tr=0 ts=6a073684 cx=c_pps
 a=GAsWKLoVs33bSFNQwaa9VQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=xNT4PeXsLruldGOZOHkA:9
X-Proofpoint-ORIG-GUID: Of2cU6gdzMBM_sExn4o_F2b_EB7x9Nhn
X-Proofpoint-GUID: Of2cU6gdzMBM_sExn4o_F2b_EB7x9Nhn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE1NCBTYWx0ZWRfX4xEvm9Er4wR2
 Z7ZAh+IdAV2PI06/6hVoTPIwTYOWmbaPWUjhPt4ZfxReqYXYjF8QALoTW6qQ5UbMc1P/YirEkzs
 0HNBWwD3WjJk7kreIK1T330z895RPBDzXvl24+vuGm/GVPd7mehxNOLltBbviba+NZSvxzWVdNO
 6S7+uZ6N1H7O23J6b8IpMp18IpubrkeYnSibvF2sv0J6q0Y3pBIwreIRcOmqky4t2hvaWPKYcFo
 HCIbhxwvv3d/rdqRMi1Yd0xwTnBBmqknrn6yC+iQtA25MQ7GwxOJMguTGuIaaw+EsAlLy2geGdX
 Er907pOzwzDULveaT66FWGAirv5kJ/hk5PQDRqITcY+eNF0YfzjcsE9TnnyQFyt6pACEKFxfD03
 OgqVJb4uH5+K8qjFedhUSGjUo8gGEA5+IYEQumiKjA9WyiASF9DA7GxJbchlpV6eHmLFGf39SHc
 NLOWbhdOhzJwH3mr5Sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

The existing aml_interrupt() uses the Extended Interrupt Descriptor to store
the interrupt information, however newer Windows will only parse the
standard IRQ Descriptor when enumerating ISA serial ports.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/acpi/aml-build.h |  2 ++
 hw/acpi/aml-build-stub.c    |  6 ++++++
 hw/acpi/aml-build.c         | 27 +++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index e70e0643b1..eaff025d26 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -343,6 +343,8 @@ Aml *aml_io(AmlIODecode dec, uint16_t min_base, uint16_t max_base,
 Aml *aml_operation_region(const char *name, AmlRegionSpace rs,
                           Aml *offset, uint32_t len);
 Aml *aml_irq_no_flags(uint8_t irq);
+Aml *aml_irq(uint8_t irq, AmlLevelAndEdge level_and_edge,
+             AmlActiveHighAndLow high_and_low, AmlShared shared);
 Aml *aml_named_field(const char *name, unsigned length);
 Aml *aml_reserved_field(unsigned length);
 Aml *aml_local(int num);
diff --git a/hw/acpi/aml-build-stub.c b/hw/acpi/aml-build-stub.c
index 89a8fec4af..3180c7c962 100644
--- a/hw/acpi/aml-build-stub.c
+++ b/hw/acpi/aml-build-stub.c
@@ -67,6 +67,12 @@ Aml *aml_irq_no_flags(uint8_t irq)
     return NULL;
 }
 
+Aml *aml_irq(uint8_t irq, AmlLevelAndEdge level_and_edge,
+             AmlActiveHighAndLow high_and_low, AmlShared shared)
+{
+    return NULL;
+}
+
 Aml *aml_interrupt(AmlConsumerAndProducer con_and_pro,
                    AmlLevelAndEdge level_and_edge,
                    AmlActiveHighAndLow high_and_low, AmlShared shared,
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 7edc8aed42..413d9b6240 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1061,6 +1061,33 @@ Aml *aml_irq_no_flags(uint8_t irq)
     return var;
 }
 
+/*
+ * ACPI 1.0b: 6.4.2.1.1 ASL Macro for IRQ Descriptor
+ *
+ * More verbose description at:
+ * ACPI 5.0: 19.5.63 IRQ (Interrupt Resource Descriptor Macro)
+ *           6.4.2.1 IRQ Descriptor
+ */
+Aml *aml_irq(uint8_t irq, AmlLevelAndEdge level_and_edge,
+             AmlActiveHighAndLow high_and_low, AmlShared shared)
+{
+    uint16_t irq_mask;
+    Aml *var = aml_alloc();
+    uint8_t irq_flags = level_and_edge | (high_and_low << 3) |
+                        (shared << 4);
+
+    assert((level_and_edge == AML_EDGE && high_and_low == AML_ACTIVE_HIGH) ||
+           (level_and_edge == AML_LEVEL && high_and_low == AML_ACTIVE_LOW));
+    assert(irq < 16);
+    build_append_byte(var->buf, 0x23); /* IRQ descriptor 3 byte form */
+
+    irq_mask = 1U << irq;
+    build_append_byte(var->buf, irq_mask & 0xFF); /* IRQ mask bits[7:0] */
+    build_append_byte(var->buf, irq_mask >> 8); /* IRQ mask bits[15:8] */
+    build_append_byte(var->buf, irq_flags); /* IRQ flags */
+    return var;
+}
+
 /* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefLNot */
 Aml *aml_lnot(Aml *arg)
 {
-- 
2.43.0


