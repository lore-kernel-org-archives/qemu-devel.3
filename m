Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A709C7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 11:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRqyR-0001EC-Hs; Wed, 18 Jun 2025 07:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqyP-0001Dy-Ph
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:28:57 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqyO-0002Va-45
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:28:57 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I8AU4P013249;
 Wed, 18 Jun 2025 04:28:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=pLbtbWDdlXSLqKwPsy6zF9dGqeF6Jq3BtA2lKcWyo
 9Q=; b=DGkcwqnoyi87YbxkxBYDagY4MmbM3GWlktiHrx9XvdVV3VyJVUqs7eiSp
 Cexshr5JWdmxZ5n04sBKyxujlzMHTRSE6g42wVbZAW+oJBogn9A3gT6dpQLTARdl
 C8idkUXb4Qiw6TDAC+QF7nEMdX22m0o5ewAi9VGlw2Hm1Sh/7mo5WiHA+bHMTyHU
 vZAYXL8omp8ywqAhQEPs0BDm6uIw7qH1TAJe/IWYdBnhodWKBsfawBfjE1g33Viz
 S6zIluGivDALrCa7l30nU24kiDpFKc8XwwKTE3IzZDmC+OQwQWhIJW35jeBIhVdM
 sj4o0HDdN7d94WxP30aFF0NL35SHQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2131.outbound.protection.outlook.com [40.107.92.131])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4798mygstq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 04:28:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPo4OAt+0H5L7q6lCbOuKgNJekR18k4dJfwff/odTHAvnnaD3e1hPppjFkPTNEaK9ndHh0P4xinTMPKjB7pmeKrbU/GoAaGN9RAlmi1bvUybfZG+GsG8pTocgxgKRIbzilJrvyLLCiW7n4QYl3CfIR288H1P0f5LaXeZ3W2Wl/GgazP+V86hmXFNJsNsG2PlCcjuL8n+aVvZ/0HU/R98sRos0MClJWGfllw8ZwcDuq9n4u1qy87kZwOWkS59XnprnlLgUnECUnR950IbscKaM5QXDoDW0gFebEXIGpiFhLB65ErZIqpg65R41TjfhmbOf2fC9v19iLYuy4ltRG65rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLbtbWDdlXSLqKwPsy6zF9dGqeF6Jq3BtA2lKcWyo9Q=;
 b=AFBbU6LLXvCUY/GzaAGR30T+oncPJ/TscOOhk9Sn+Nh7LVHWrpph1hUanuqwQy4DIH/gYVGqs/6g+fGgFuzyeMxMbo32+JgLcywnXAKYgWXN6zmLWZTvCQavkOSiTS3en8s9WvEErVMTV+oWfctN2NSU2Sw6IXBkp6WrVK8nBG5gUpuM79BnPAFtjahM9XJoQ07V/+r55FZYcW678BKFKsEMHpVsZlVwLA2lMvj1ZHNWwrPtX1vxWQw1esFLSuBTVNOJlnGLwAFxLhHt7wf5rg70NwQ6CsgORCpzkFA+54x8hjV9CRUMHKvcA62A8hgNn5/ukLPXjxtOLwdluAK2qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLbtbWDdlXSLqKwPsy6zF9dGqeF6Jq3BtA2lKcWyo9Q=;
 b=MCDO378AELo9FbC+ZVLcdkBVlwbBVsCbbIpohSkds1b/9wDkiSFP7lVCAsR5bS7UEa/shgDduu5pjU0L7HpGZWWaLd+GfABqLBzd+KJLmjyylVW/G6SDfd9dxkAday6+W9vnIG+GIw/PUHJvIGnzloI2gKt0bvoZXxJ6cYyXhJDJFX9Tp3kQ+Y3CzFunRo1HVMXluRfJDCoCQUeI/oztjjkwkoWaeEp1dd3BHE795nViIHlAFWIlIskJPPzLIsfM3iw7VD/8GdbydZUALra9khbV0J8vRTJr7ft9gq3LPe8NQMc7FnNiteXVn3sMphgu9IkkRG8PpyXGGh9aey5AEQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9632.namprd02.prod.outlook.com (2603:10b6:208:3de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 11:28:50 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 11:28:50 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 05/12] hw/i386/pc_piix.c: remove nvdimm initialisation from
 pc_init_isa()
Date: Wed, 18 Jun 2025 12:27:10 +0100
Message-ID: <20250618112828.235087-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618112828.235087-1-mark.caveayland@nutanix.com>
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0027.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::32) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea772d4-f01c-465b-8e25-08ddae5b4c49
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5UyW9T1VgJShsM5L8pl3hgBkpBCGFlkLtPhbC3Qr3C5Nsbf0xGT7y2ClLFz5?=
 =?us-ascii?Q?lh11Yh/9JPp4Ro+GkqB5Wzdxo4ZyA8blIDTiKhaSwekMt9e+F5/BnXsLvA5v?=
 =?us-ascii?Q?pINppJnoLgEdsMCXaU7wHAjycccMss0m1u0Uu95DbaipyEJZBZBJcN7tMTXT?=
 =?us-ascii?Q?VqXT5Aeo7d7gVJojb0B2yPfFlTkV8ogUmnp38zOU602vrItJ0XdR5iA8CTp1?=
 =?us-ascii?Q?+lIlArwA98/jWl1/65S2D4geago01UnSulACnaMSarowhi/wUS7PA3fKDP3x?=
 =?us-ascii?Q?hB/nhnILK9Q6OyAeSRDy18f7FdYtTu9pG3McSXnZr5jWuRTDquzT6nHVdczg?=
 =?us-ascii?Q?z3JLwG1K93Xqos4rK9NvnHTtFZySYMeacRIGajxst2n6xGpkMdKLIGtLxh4p?=
 =?us-ascii?Q?sQmJcVztgAdFbqDdGrPuyqI6PeaLUvYzzNaMO36JqKgzf1HTp8fnafC3OtmR?=
 =?us-ascii?Q?vO0KmO1X0vXuVC7iXAX4O3e3g1q/TKc+K+IEV/87P3ESxYBchpPyda4F+5Cw?=
 =?us-ascii?Q?31q4j9nVfIIUsvUvihsKZgfMrzIhQNrlyB/tdZ0UWdsixV91faCe+ojBF7vh?=
 =?us-ascii?Q?IR9B/E9BJ2K86vvQC9ulgOyUAR55nuCRJ076ZU4LkVKN7LEgDIQDwhB52+Bc?=
 =?us-ascii?Q?v1So/7+Rv9ClRXgZcjtguUFuoM0U+1p2vsobDoDN0zDeG0uaHmvyUS1pIwsA?=
 =?us-ascii?Q?gMRpKfk3seYbnRUpTVAlAbwK1JNO0dKcrI3rBTCWqyI4GaqX/R3EWtmOeNeF?=
 =?us-ascii?Q?VDbD1s7mkInntg0ZBsPXttWsCAyIjonnjNP+q1YKgX3sGnqUwiFh4w5M8Vew?=
 =?us-ascii?Q?Fd/ORQXr65av+d96+9s/VZecKLtJxBff+m2g4fSuQsxF9KP98E5QGI4iQk9T?=
 =?us-ascii?Q?CaYtSebT14mhWxK8A7Xz/svLb2XnMAujwZzknZc1vqIFYLetsr6VdieCI5CZ?=
 =?us-ascii?Q?T5cCzP2K2N/l8t/b0ZHJS9Cz8v4XoXWxTgmlKTpCgmGld8aDdDNMRZuiOxqs?=
 =?us-ascii?Q?vWBWVQqA+lRc9KcMxa/mmZ5MXF5howwzFt3ruznRXS8uA2gGosAcrcuGgOBH?=
 =?us-ascii?Q?+DlMEF21OYwkC6EtTiwHeaMiHQ8mztc+W5RWJi5iCLeka6q+6UQZENzU8m5H?=
 =?us-ascii?Q?spD3PlkiOssc8aIgHH5UN9v/VcgJ0FDwp1qmCL5nKdNBeku9earoA5zAEP/J?=
 =?us-ascii?Q?KeItY2tcSlGVmgGvdsfrMve1/DkYth7NFLCuK6omRQWs3/cXj7ee9S/WzTKW?=
 =?us-ascii?Q?+dnslYJir8buKZe2jc6s7//Fe6yIqc96B6W+3SKzw3yvSyLH8CJRb6FOy9KR?=
 =?us-ascii?Q?TAYoNlkjCytALiUQymsNsvvEJlbrG822+gvYQrFX3DVdGK9yZDoFaltcW4hI?=
 =?us-ascii?Q?dMQRbvgOjcGe3zNqK5QriX3/0R1iMuIip/MEt3xW1If3W0HolW2VhRmmk/dx?=
 =?us-ascii?Q?pFDTlQCzijg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iNjOUi/0nvTrCNYVM1tJgvCc2t1MNgE/6/5bYO9ldGSabCycVpUPgxBZHn2M?=
 =?us-ascii?Q?IX3uJKA82DbdtiNoFI72YertJrnBTDNb0Jlmyol4Nn2f8qIcAqTSQfyclYld?=
 =?us-ascii?Q?A2MiwJGj+wQg9FidPWVvgnqa3VUhADkouDCuAplWXCr6GrfMzuT+zq+lj8EL?=
 =?us-ascii?Q?CgOGZYLy+/AC1aLMxWqgPK7+/5FTno0XFXOBwAhODbDr3O5HbcHpqd2+mnDM?=
 =?us-ascii?Q?vNbJZEBgHOQ0iwrnhVZuMYYAChJTi47U6mdLeIMA/VgDyzHDuq7pvHDbx1H8?=
 =?us-ascii?Q?4c+cZWwgdlTKNrm3dI0ziQnd/34fpLuuyMXEe9poXDOt7qo8nWyzxI6JFh45?=
 =?us-ascii?Q?jUtj0bvQBxRoAc2AyCXgFMmFf7Sxk8jDk2+5HONygA0KfH8bY4jO+12RCjWY?=
 =?us-ascii?Q?9OY7xg1MDRa/CUcDNmO4V7EITeNjoMOw26eChD9F+ANWUPYExU9hLOlpbsYX?=
 =?us-ascii?Q?GFzZPNQW+TaCigSMCB4qr0vjh03nrnIyitGhfMi0ErAvpnjaGZ/hsc3hhb1P?=
 =?us-ascii?Q?lICBsqTvePxsMEJVUssCt6gp4jIPP5CaLw83TguYxE8F+rNGM0wchSSMScao?=
 =?us-ascii?Q?XutkKKHmjkzGJHwM545YdsCOhaq/yv18tj/lfsd0Dw577ZGVQjny7aZiNCbj?=
 =?us-ascii?Q?zSiulIgzuVqfiyJoPWZTBm2cYPS8sGwsazOFXy3PgsXtNr6wXYewUB0P9zXW?=
 =?us-ascii?Q?/UoObcplwex+KmTXo/twJRtnfQqV45otivIbpJaB7l6f268CLClhbPtk90Jd?=
 =?us-ascii?Q?8mGf9uljLjT5wQgMVxzgDcwkDNz4Kbo7kFfszXcUIrGDhqzKoawVrrQPNUn1?=
 =?us-ascii?Q?/yA6xW46cG4yO4WCSKy5U+dPTJrmo06NY1pAHRWI2RyIm+hVaM+xbTa9AG9c?=
 =?us-ascii?Q?h1lOExCWtEzD22KrGcD3V9AdDy+sjSZ8oUfGC/qz93xhzEPUzdn2Qi8sZR+T?=
 =?us-ascii?Q?xb+1bq5actUqz7s8cQjFH9GT4TVI0A9n0imSlyAC4+QJrtxfVv6D03TvffaI?=
 =?us-ascii?Q?elZpKvXo8MtTyJLcTe03EbAA6WdUUybACMbuz2PkeVRljzj03SAP0yP5G2BD?=
 =?us-ascii?Q?/KgSMXKdwDAGNA5BQPCQiM7rW1a8JG5QsTozvhTh3+Gz7lNwfZ19Z5sChje8?=
 =?us-ascii?Q?7THNzVJOfn9VIDDJK3OIGndS9+61BjM46fUF+3GwmCsuIozUksd9fuQHXUOp?=
 =?us-ascii?Q?2jAxCxLqtAwBHvD9PeABmBcnAnc6GdNiTiUQ4ibbNtLV6k6b622JIfA2KgAc?=
 =?us-ascii?Q?6shUc0zjW4XjVe21qqoxmSkzVj+czHGm0tbW0Q/F0PGNh9YvPfnyiYSADfNt?=
 =?us-ascii?Q?Yhb4TkOTtYZpkinfQPIy7t+R8ICkPBWgRHHo6Gck6ha5oLCUcQgZWcXdXRN3?=
 =?us-ascii?Q?CoEKLnkupfPbhTm8qdnvfnFGuA9amBpp5JenJmCP1LuoKVYbj3FQbQ1AGUBs?=
 =?us-ascii?Q?zMXoJ5Nqj3C3CJdOQbQvNbLXaVDDB2Dck4oxwAgttHPTMS8ukTl3m2rzMHDH?=
 =?us-ascii?Q?WnAfnoK2QCp58KpX6eN8jOGDGGxFz7oZ5DCAp5B/3RI7Q7vYhJa6pq2/IRgP?=
 =?us-ascii?Q?A8apvWsvIs0x/wf6okgT0sPg7piyYQMEcz2S/MrkDyNdW5vDz6ILjbSCv+I7?=
 =?us-ascii?Q?rxJ0xpOUNyOm6b09Wc6j6Fq6RCVluY9CSPOp+7+l8HXEOn4+TxeELRiDmlY2?=
 =?us-ascii?Q?8QcH0A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea772d4-f01c-465b-8e25-08ddae5b4c49
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:28:50.2301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTR7ApVuT1ryNr9pG7OH5oJHZ/PSjOvFTjMqba95V470TZi0qyFLb1U63wtVwjRAblYNTmsZ9HYosEsHmZQrD8vqrArmY7oAIWzK+VuF1E4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9632
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA5NyBTYWx0ZWRfX9DmaGlHBtCPH
 wVIrZbNxFvjn4SZOIMY8X5qv1YvTjXaOJdKT3Hz5f2j3/zJjHdbfQNzdXbgRC/veuGKP11kfLTc
 dRgdk5iK7uO8GX/WlpL0Y5VZ810Sh6mJ5+gO9Pa51YVeHyYzrtCn6kC2/TfeBNCAOMPUbgg6cv8
 LGA4Pq+7jrJnMUWq2E9dVr6vZmr7VVKyiPgeVBpec0AicS1LWDCXRL0UckYQxrJEyUOy+LlHl5U
 Y8vRAhl5kIXJSVeTsvBq9Mijvsc5Sen9bm6SY1lzV7U+vTWlfzSmZ/0yf9zXcbt+848hx8HbfBQ
 7TOJcRe4JQfgOiMfX+LDcW5rJkwuK12h3uKI0V0fD6JQyG5kSO6Jqd7dPnR2Kn52+edHDAf6Wsf
 YFPLOa71eQmMzvoSo5tlS1pGLxf5v5pE5hH3Xm0sWYBAObReFTEVptL9HiYVd36LuOl3uOQQ
X-Proofpoint-ORIG-GUID: jDNs25VrK95MfKozURfowsamOHNaxTnD
X-Proofpoint-GUID: jDNs25VrK95MfKozURfowsamOHNaxTnD
X-Authority-Analysis: v=2.4 cv=LIxmQIW9 c=1 sm=1 tr=0 ts=6852a2f5 cx=c_pps
 a=3xgE4jxeEmi8nvdmdzTCVg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=XL6wrB0Zc_gxRR1ig4QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
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

NVDIMMs cannot be used by PCs from a pre-PCI era.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index d4fb9787cb..640583e163 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -562,12 +562,6 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 #endif
-
-    if (machine->nvdimms_state->is_enabled) {
-        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
-                               x86_nvdimm_acpi_dsmio,
-                               x86ms->fw_cfg, OBJECT(pcms));
-    }
 }
 #endif
 
-- 
2.43.0


