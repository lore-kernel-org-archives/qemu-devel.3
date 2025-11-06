Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DB4CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 17:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH3QT-00033E-Nt; Thu, 06 Nov 2025 12:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vH3QS-00031H-BE
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 12:05:32 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vH3QP-0000tX-Np
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 12:05:31 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A6FiLHW1143749; Thu, 6 Nov 2025 09:05:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gzJsWJaPvhgAGEt80dF0oM5GXV6Lku5xxNDv+4ChS
 bA=; b=1YsY1bYQxVLvgxzKUToHVHx9Ksv6F9zfqCECQdP9LyzdNV0doMbF56WPa
 9tSaVia6WloNEhnAHaE9FdNMWSOPEwzI9wHhL4XLfUKkYXw4Kcd4HdT5mrP2ZZcZ
 zpvdhVKHr6El3Xr4u5Im706JTSkJ+8UrFES2tgUDQoO8R7KGl6PLmS4HgJHBgTDt
 vBOcjJfx3IVnCWvKTGeztll7Eo/ENCTR0tVTO0Lo51OXptzfF0v/7v2chkZj21Jv
 xh3zRl4U2l1Qe1+E4z67Qb5nIgpP6L9v66paE8ICAQIGlXlL3CRoVSE//wWBmLBf
 HOLO8hOOJ8H3rRLVsM+7hXjaCHRXQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020091.outbound.protection.outlook.com [52.101.56.91])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4a8bch2y2s-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 06 Nov 2025 09:05:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xqr7smnAJR1T2RR1I7nEZLbBd/bxhstCyf2aGyzil1AL6eG7EKUpQwZMtIQS2dpA9F1xGT1AvGs7fKq62SNT27nH+QYOrGHDOROPI1CIcC7hIkbM0huljLYsqYvkQ5o01Iqywk3zyc58B09l+ksu4QeWOFG1BynWTklKCQnZZNky+vQViX9YZgjwaTm9ydCAAucRzYvWoNfH9/EkLASwJYCYCMZ6kapT8PBy0uDCF7XEDuC2Dk0vv8MGArMaE3XO8Wytjd35miE0sL2Jm6luYOFAHoPkpI75lrIbVhNsAgS72ENs22B3wrwsiVOiPD+V4dzQkAt/XqfpgUcSLLu2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzJsWJaPvhgAGEt80dF0oM5GXV6Lku5xxNDv+4ChSbA=;
 b=uH9HlrqMGiIe6860S5rFY9b+1EAM3VIpnbm+6BbI+n0LN+u38D/jBKDGha8CJhayr5up1B/izg7U9grg7sHG274OA61Qgyoy6LwLHfTQSGhs7E4kypeQ5fJt4zsT7KeEiLX4NVpO8VFPKFuI2gE6cbQx53u8oAGsRoQo/p2S1waIBq6corC+GWiU3yKKZ+HsH6vtplYxqWUGQ4HAoDHWakeCc3boZGvWlCXxZbEXe8XsTfawXD6BJ7Ym3mo0esAczE1DBfSPsv+FEHmZ73a7LuOIfrB+qFJ0I6NkYYicBGgGtnOZYhPavQtMbe9KT8ujh29wgqo7iKPwYdfzB6vl1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzJsWJaPvhgAGEt80dF0oM5GXV6Lku5xxNDv+4ChSbA=;
 b=hqui37mcpgQpsDDIH9sG0CgT6/R6DEr+SOtFLt7df+6ne5OzG39rN0tUh5GLGJGlybzj1VsGCUS1uuuOVrOb9aa1G7GgYwGl6WXC83cBGrPdYINZr0QJ3hpoNICRL+pNzScra3h1qvi2zgjzQMKUf3EsKgbhnPkuVjd5mmli+fEFN553px0ZcRtJzmn0d3vuSCv/vfDm4BVrWj3ybbxAAlaWgN75IeH85G/Flhph3XKpcPn35zJRNo97l/33j+G+waoIkDcixgJd7a0NLmu7/+iFmy4w1mhMJtNiU2Q0Ss8NBXP2Pj12TXU1YmYpsjh4sWOJeWmRelKH+SX/dlKwaQ==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by BN0PR02MB8000.namprd02.prod.outlook.com
 (2603:10b6:408:16d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 17:05:24 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 17:05:24 +0000
From: Jon Kohler <jon@nutanix.com>
To: pbonzini@redhat.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 pawan.kumar.gupta@linux.intel.com
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH 2/5] target/i386: introduce SapphireRapids-v5 to expose ITS_NO
Date: Thu,  6 Nov 2025 10:46:22 -0700
Message-ID: <20251106174626.49930-3-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106174626.49930-1-jon@nutanix.com>
References: <20251106174626.49930-1-jon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:510:174::9) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|BN0PR02MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 219e1674-5e5e-49c2-bf36-08de1d56ad6f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9DEZVIjmNXMKqM/5tCM1veuMoN1SO/z5L1rOWModklPVUvsBPnsauoT1RrrH?=
 =?us-ascii?Q?LcBqPu9Q0Cw1WnhO2HQrMsYq11GIyct6KTe+NMbYZ3dZZp4AQnzohMzWu0/s?=
 =?us-ascii?Q?yJzQgqsNriYPSQyAIcPTxsJwdGzvEk2jN9WcTZZd0vp0OPVDXMQ1Y0NhFp+Y?=
 =?us-ascii?Q?9XK/mH7YahlldfpqVmVqn4INX0mWrr4Pknnnh5iiyuhqjnmTGvJ+z3iWI8Fu?=
 =?us-ascii?Q?+Hcl0f+IxNLwh/Q8UjhVHkyRSNKNiEATODJc5qU/35ZPDRxqm62EQP5/+G+M?=
 =?us-ascii?Q?2lpSqY2kBzSRiwVnEuVIAt7FFo4HJ96XSUwFbwrdr6RqGvZi5FyCpj+QcBt2?=
 =?us-ascii?Q?DIdHfzBTX3udRgda0+BRPCtsYhMQnVsFawaJfsyRYfExjE0M9EIFsgrU4lhU?=
 =?us-ascii?Q?cK58M7c/C/50N885W7pUga/M+ubWYJsk1zYhdif+dZXaITImls/LHXuNZwlZ?=
 =?us-ascii?Q?QZEHGOR+wmY8N84KFu4GjZ62tZmsYODduW6a/p/cpgKNKUUVZU2AHUGO4Vk8?=
 =?us-ascii?Q?XDQ2N2PnsC0RRr6ueD3xvpOY1YFnR4XD5ua4jN1a1v+VKeUdVQoV3Fz5JoI8?=
 =?us-ascii?Q?3QPG/HDsFePsgiU27zkV1u/7rnq/LBA22vFXBEQbkK+r/2SYEZnew6I0WVou?=
 =?us-ascii?Q?lmmPqrkyVAu+DTgM8TmNPwc8QYRNQVLaj1T44YjasCT5UMas5/g5/vidX2Vc?=
 =?us-ascii?Q?iHsyDVcPQc5U+Zg/u5MCQMjKgZQDP5xDsa4TLb6BYK8TAYSJbl9OFap6K/2e?=
 =?us-ascii?Q?OZXevs+1AEuHvTflgKMXzJmmc3j7JuZC/82i/EaqoOoXBgGA+66840q/mSXP?=
 =?us-ascii?Q?u0nEupoHSlgjfAM3aLL56e8iuUzIoORJk9U9Hb/xBnqaB6egjbRyi7Tk/WJX?=
 =?us-ascii?Q?NUYwcAK363azKRMIXKEwco3Eeyxd7Ni+bV85NqUKJyylbBj1JbrYbj7jRvci?=
 =?us-ascii?Q?0iJhh8y8YJxZ1joqLc3TSnG466Adf00cpR/YwMsvVlIUmT66S4Ze9U8+zN+D?=
 =?us-ascii?Q?NdujSISdD8O6NXSXoAzxm3UGTBwNn5t19//l84+fddRLRX0XkPpgcYyJXqGj?=
 =?us-ascii?Q?m3Und0VVLfiAW73X614L7sO2I0K3cMrZ/T2TY0KpeP/8w/RWibJze75m8cDf?=
 =?us-ascii?Q?N/CxKy2Spj7DpjLyfjakx1niUeansId1e8gd3QTFHdHA280PnqcCgOpZmimT?=
 =?us-ascii?Q?UHekVxyjORdaPQXFF7NEjHm8XzRkdV7311IwaM+tCx8OQSxdkImm68j9HUv2?=
 =?us-ascii?Q?vmOX6LC71/cbHce78gJ8A7evrr22GQ1gns+wjlOE2t3AR4yEA/x4+CJlJKiy?=
 =?us-ascii?Q?DPq4hGsrKzXCykk+Yc31XctKAea1mG0U7g8dCcPWW7dUC8XF6kCZ9mFWzxbh?=
 =?us-ascii?Q?4aJgTNWZ/HXhDeXD0ms1UYUKDbhc7QcU75GvF4kHmSpptUfCOyE7ZtSW5GzJ?=
 =?us-ascii?Q?DGAP56Sl4Cw/Br2p0PKBZQvz7Zxh6jrNZmq3pj8q2fnXIuzw6bmdmBhyB/sR?=
 =?us-ascii?Q?mMl1uj5drYQAcPrubDCoUOLDflJOtGb3XoWI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR02MB11133.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dEs17HeyXV3b8xJrRcFyWCu5f/TJTfEZwVrb71pJeC0HnxyRWXo37cnq6+8w?=
 =?us-ascii?Q?RCWoI0+vKEWHmYTRDoowCW7+VxQ5f2xupI4SDeb2yLSE3vyTjQWBL4VDSlIh?=
 =?us-ascii?Q?77Wi79RfvvjAgvuashm/YH7UGHvGAUCCcyi1kIiIGSl9C7yED+WFzTLpOONY?=
 =?us-ascii?Q?lFJYzDI6BsZmeRQqKYjIS7gS6y97vC5n7TCWnZfqstlV1uDqITk1NOwenNrZ?=
 =?us-ascii?Q?ywERvjLuu0VrcdO5Yom0v6cA+Gxi4AEiFEhdneqE72w7pdPHXNAp/O4C7Iuw?=
 =?us-ascii?Q?hsve+l3Af1y6SVbnM5TPYY1+VvsxjxaQqSmJ0oRaUee8o2RjLiBKbkGFdakB?=
 =?us-ascii?Q?VYu4op0JAOBQIzoIjyl25qgNQKZ2iUnDzdhAfsAzUO1baKq4Dmybv8GE3VQ1?=
 =?us-ascii?Q?ehW6DRw1PRKaJ5YfNnQoPmeXuE1DY2Ovf6RbpMe1rWMPy2qavMhjCENnw/7f?=
 =?us-ascii?Q?5pdZ+1oPW3a51xko5rb+Qkrha+wyhq7zzeuMWokF0V80RCRl5RznYn4qiBrV?=
 =?us-ascii?Q?TvlWpxTE6qX8eT2Wd7s7xym7QjBmdqLuuxWHwLEMJ7r6o5Ddv3thElzDCJIp?=
 =?us-ascii?Q?NkS5gHpZ1KMiCyvKjpzm4cdYuAfvnJPDLsj+lpFSjL5yVzKDdcvhyeD1eYRX?=
 =?us-ascii?Q?4PtgoTBp6r5J9qDCd06b4ShVqQsnmjKf4l/1/DDVfkiVweSVV7ueMf0//rKC?=
 =?us-ascii?Q?nnjEN8vKXmwEVZV9CnRsIJn0IpRauJWAmjpltit2sQoKOTb9erR9Hznx2ckw?=
 =?us-ascii?Q?9IfTByfRbO/7xP9Qw01qQ/XGsGoW/kKrvhsldh+E0ntayDR9QBBq60+ptOLK?=
 =?us-ascii?Q?H9MXszixdNbM+V9bam381a/KOGBN3ee5A5mo6rTlW4+JVoewZqMs/A+x2hLR?=
 =?us-ascii?Q?vQz4L98r6ySmyaVKiMd4cu8KWWasD7qWvOvrxd18LQxiNurryjHF9S53Ehag?=
 =?us-ascii?Q?5tQ1Rffyq7AkMwPgtOAsrgz+1FGrY9RGF5mwQtW1kJIDfs5704ymoCOfCSgF?=
 =?us-ascii?Q?RbcNHGbaGgX6dgUjr+0Ztt8HuUHdjNhsYmPHJQpD0xX5bRbJ1zj13kCQ7zn7?=
 =?us-ascii?Q?LvMcgNWdC7iXJPzwDKyl466xYwg6qZL+PwEuww1PfcYJovHntw846xDqBYss?=
 =?us-ascii?Q?5r8nltsdmkQBsur+3cGpIhwr4XMrwhahigdpbild/uZUSENpJ0Ej53T9zMj4?=
 =?us-ascii?Q?lpOtGnhlyGbgsx8QMouzYxEMPwjbptaXFWG0lMYRm6de4yL0cN+zzRz1uxP3?=
 =?us-ascii?Q?5A8vzXjLJsyFidPmY0Bnesj48On8WQGQVkXRyANJ/Y9mc6QrVQTV26tpbNWQ?=
 =?us-ascii?Q?+Lcd+hagHTwSgP59yreNCC7VtjrJY3AGFVpbZij1P08O5JhtKcnTSs8hOoRy?=
 =?us-ascii?Q?kKGZYq0+FGLg0ssRKoG3KmnzOOxJUgOU//cpkQCmzh3gUynfwuq5/LH2iNGX?=
 =?us-ascii?Q?CUZBGwky4WJARjVg4rmGj8sXyhqTziEG8FJ06T5DjNy9lU9MrgBOS5uIoZvJ?=
 =?us-ascii?Q?2pahmtiRGWRo9Q9L68eIGL/teFawgwiEYJUULC8Q3Es8fnBNjY8Fl78c/zCz?=
 =?us-ascii?Q?QFb+S3/4KWIrxwENSyVoVThBgq5E6sw68q/OxUfuwLdYc5UhH47bIvF4YxYF?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219e1674-5e5e-49c2-bf36-08de1d56ad6f
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:05:24.8757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXOTZdy7//KsvoPmQxV2M/HZtN0U3OST248D6jc0G4qTA6YTUKsBewUCVS2a7rmmoYYZQANwc1hQWoRC77MqlL1RdOC0rQOraWAiCgdLh2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8000
X-Authority-Analysis: v=2.4 cv=OvVCCi/t c=1 sm=1 tr=0 ts=690cd557 cx=c_pps
 a=DCeSEX+nBJmE/I7rcEuDsA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=64Cc0HZtAAAA:8
 a=J7X7g0SFKKtu9_AsvGIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzNiBTYWx0ZWRfXx4W7c+WfqrSO
 gdLEZjQJlMSeA9MSJcp83UVBfftueFgjXdTVsDNIP40TwevUmLByhC3/FKLoi7FzBDmgk6WG1UJ
 7wbg+a6xFqMo0QxTdwkJs549ozpYkVGqOCsQU6PnPWt5k/6kc/vlwp2PWfi/Q8xFGo8RCrC+FOm
 0c/AdRE5rsQxQc2Gh1Ko8oSSbnp1hiPQUmEXY0fcPZQ2AheepDdFxdulWLCp97sEMqw1At3qaUL
 Dd3HmUjjGdHeG2Uhwe/8MewVWhd8akXbMZpBZ9cpafT+R+xRqJKTwnY1QCNQsbYGAg4ZDM1wSpT
 I4yEdxQy5e6w+8cxAo8D0ix89ngzZTVWxbjOf2slIJ67faN0NcXLZ5m+Ps/Nj+LuSosqRQWRqTJ
 kjXdn9PJOA2knosOsyAYoWN4n+kuvw==
X-Proofpoint-GUID: eSapWsPNbxr1GHThNu-ke4he9EyG3YcH
X-Proofpoint-ORIG-GUID: eSapWsPNbxr1GHThNu-ke4he9EyG3YcH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=jon@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
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

Expose ITS_NO by default, as users using Sapphire Rapids and higher
CPU models would not be able to live migrate to lower CPU hosts due to
missing features. In that case, they would not be vulnerable to ITS.

its-no was originally added on [1], but needs to be exposed on the
individual CPU models for the guests to see by default.

[1] 74978391b2da ("target/i386: Make ITS_NO available to guests")

Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 target/i386/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6417775786..e579b790e0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5111,6 +5111,15 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 5,
+                .note = "with ITS_NO",
+                .cache_info = &xeon_spr_cache_info,
+                .props = (PropValue[]) {
+                    { "its-no", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ }
         }
     },
-- 
2.43.0


