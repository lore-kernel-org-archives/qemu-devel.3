Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFC8C7115D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 11:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRqyg-0001Hl-Fp; Wed, 18 Jun 2025 07:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqye-0001HK-BG
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:29:12 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqyc-0002Xj-JK
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:29:12 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I82QxJ014676;
 Wed, 18 Jun 2025 04:29:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=NPlXhadgFJ/MptG6YMm1EHMUC5cr8jn3WwLjH3xcG
 94=; b=bEbdX5+MLgcrVjFAWlDXWatG0+j1cBf1bb6DMjFXBaNOl9mKKbSWUYGEv
 rvCyjFNkyde/E46xlP5cCc3qDN4nrdxHMn3FPmwnHIa9tnaq3ubOeYCmml0jHH+P
 xLvhwTOHxTZjXKkmjyz2WdSTHEgW9C9H28l17dHV3ZTnMEqGH3qpaCPW7myjVdW4
 yHxg8hcjP6ElGA8mnPIydisulC3ORYS9oKe2d5179Sdc7EUyqVHxIFGyWF9mQhvT
 204HLAwaxyfQ8oHj6GFH/BdCQVd6BS8OWz1CAf3cfwuqLzVdtk2tGIyuf8wTSiUx
 opqSLXMFXKED5PSm+V9LtCY9jQ0HQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2133.outbound.protection.outlook.com [40.107.92.133])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4798mygsue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 04:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvSFMC73Y5Jg6+BGBpLsg2Dzt+j/fxs2V6ZlOfKNvQJyg8JZWEkH7LtQzfQnr2kupKYxOTLINA58rGMRFUDZ+qXnLakqBVJPyP5116DEwdBEV+84WRQOdgRbsBiS5L8pr3DY3js7JHlkGjoRCxpWYhzCJG1PsRWRwemi4I15x2lgHyfHv01P3A9ZT9DTKsZERFndAvwerlJBZ0KOo8GxHVwHgP9FbksYyJez9L/tSpCUlW1SACHaTb9NXngEpuPOoP0SoXD2Ll3wVzRrvJho/4ostJtTerj6T0LJmBidlau1UGn26p3s+lN9gEdvYcr7usZXgjtYYP0J8NSRpmVWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPlXhadgFJ/MptG6YMm1EHMUC5cr8jn3WwLjH3xcG94=;
 b=Y+ZzNG5DO2GR+KhqoW1fwIOEWddpyaa7qZCxPlVQ0IhFaqwpLIomI3pQuD79A67iHK0kt4jwOFYQDI2Xfebcz5OPrY6mdKisE/siQweyvkAm6nTWJnVgRxx+nE1Y+S8xEj+JSdSmWqfPuZh/lug3KBHixHev0r0htEGoKhrq6buhVz3BRMRTr7wSskO4p+vDmEo+GFo2+TPvlclkbUanO5tRVNG2QrvchvuI+54LrCDYdkgMx1nLvAWHjRVfT5wTwI1gy0P7zXOgHC+hvYZ62EwQ9dFCF7RmYqnt11gI4Q6rxtgiPp6LOl9xR8zILwfyFz2RX2sOntwS9leM9LVa7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPlXhadgFJ/MptG6YMm1EHMUC5cr8jn3WwLjH3xcG94=;
 b=PpFOPTTxH9NLabf/qcldQETNtSggzuOmvXtDb58miySuPqLzaLhx2niMtdwvhyplkSBFvk3EOX2KGqS5Pb68/Y73ouiFQbbLLdDWXQ0sbmy7LMVZXPgIUzCpSmqdAI5sQBgRJA8tUIO/JPgPeldDyp/0LQDRzwC7mDABHQ31vK7/t8aTEgv1DwT6mWHcxSa8OB7EhuuxCOjRI+HFlPMKOBYHioHPsIePlSQ0vivZJbwgoziFhM+mUJMQn2lMQGiN4qQ3OEk6VRvbyDmYwqSyPnBdP6P9eW764ZuTzaPbnDVrk302VXSq52R2fHsLBVkoN+08FysJOnqJ9d7Z1zPXQQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9632.namprd02.prod.outlook.com (2603:10b6:208:3de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 11:29:05 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 11:29:05 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 09/12] hw/i386/pc_piix.c: always initialise ISA IDE drives
 in pc_init_isa()
Date: Wed, 18 Jun 2025 12:27:14 +0100
Message-ID: <20250618112828.235087-10-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618112828.235087-1-mark.caveayland@nutanix.com>
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0168.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::35) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc2baa0-5a60-40e6-5532-08ddae5b5536
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xd9x+7YOOD7FFJFbmj9tnhL4/PiZ3Cw0AgC5d+YFrzfM8hCeKpeQ6iiFrHYQ?=
 =?us-ascii?Q?lnjI4YqhvChbq83Lg83nSmNvHR3C/JpKtnZF05jSvU6yKb0LkLyffNru9jpH?=
 =?us-ascii?Q?lI6nJ+tLGsvUlZtuwkXi1zUTarNc5hpQqqJ6dsLZ5jyQroUCDOr5tIFbND3X?=
 =?us-ascii?Q?kb06jUd3MUQoS8hESgryffrFvP7nP028P7DX8xfF4gNISihoFw2d4yEUG6mC?=
 =?us-ascii?Q?CaCxoqjuylGdsILKZDBd09M9nRxUbCFMD5eE8b4VKRbbay76l4BSHAupbKDD?=
 =?us-ascii?Q?4vdkzJ1NSJ5vVF+SMARkNxCaRPhpqDXObUBk4s/38QmFyLakoNXyzFLI/QC+?=
 =?us-ascii?Q?jvXSctaNcixWLIklR9zctA1Cox6iokFPZFBVJIV3setmjmoJy//hfA73Fjth?=
 =?us-ascii?Q?YmRD6j583rmXHclQ3qfA+iupnsVFvXhcfkBDHH+H+gHb6NEcDTLLS7xFeqBj?=
 =?us-ascii?Q?Yb0SgQdfVF4XJaF3GJYsia9DlkaZPXpjt98v6yeyOK8It7mSlB+RYIMKd9jh?=
 =?us-ascii?Q?zNLBkgUcsPXPrx+Ef+2mwEpve/BcB7gy1Bq49UnFOUxdJtgnfZ7AOTWyEkFK?=
 =?us-ascii?Q?buNhztoVOKSgX9bu9AYfYrryyXa7WCBSdEGwOXcvd5FNBe68ohmBQ3ncJTUM?=
 =?us-ascii?Q?DH5bXKk7inJn7ZTBtNdlzyqrAwZH2Be74JmLuu+gilgp75yHL0bs+2NPKvPm?=
 =?us-ascii?Q?ePTMTQB5jrcugChCxs5yHuDsr61sUOdtiDcJXF741dGyEmu3YlF+riCFLkbe?=
 =?us-ascii?Q?DIqP0aIbz9zLBb+2DkH8OV2R7UqtlIIAWNNBDORRDo4kabN/aUQIB6l8mRN9?=
 =?us-ascii?Q?13R2VgIP3K/mxM58VFkrs3AVAFZXId8Qf4lyO6FZ4cxSBoa8jBoLKhDQ2SJd?=
 =?us-ascii?Q?2geS2intuyKTCgIMCTo0kFhgfXT1ZcQkcAc9UBkEQum3ASTkEVLq+HvXTjhL?=
 =?us-ascii?Q?5C1LtZMCe8odtYumqv036i0Ls67npmOu65KblmcGV/43KGm2OF/ClQYWUqzU?=
 =?us-ascii?Q?OqmlSOKz7kYYXCvFlxsyPKzpq41/pROt11v0O255pkTRpQeEvLl22oq8WRIo?=
 =?us-ascii?Q?uznL7xPxA6UQbU3blaBxB7yGjgEx+7G3lYyQfAwobShqKyxMBIzZXlxuskDt?=
 =?us-ascii?Q?zNJqAdUAIWLWi/Ru+gSB1eN+4Tdf38W5NQEeFILVLSMNymkg4eAYUu2Glz0S?=
 =?us-ascii?Q?PN+7M6fEYDx5U+7mxHx5uMJ1/2hfzwmGB5Gw69crrXMzenGj616ZNbhqxelv?=
 =?us-ascii?Q?yb+/otDDqZ5Bwuk3IAsTQNHj6ksHYHc/jrKtmyImE3L+dG4gVPZqlx/vKO5X?=
 =?us-ascii?Q?2rmHxOBvhnx+JwAErGFou6FY8x7nHiRUITM4tgcS7yqYqGfHwTjf7IhMYFlE?=
 =?us-ascii?Q?mzMz2HLNdGUr5dL0AuK91OS4jEZI7nThpGR/yhR7sTRlkQ4pyg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GKYJHgBFnSQubpuyDfh1v6452XaYP4WaJPYh0o4fQVWi+mzPvBrY85+VlqUQ?=
 =?us-ascii?Q?TzhGtfk+EKG6HIAiFysMIE8Cd8tprzAMhmIce+EmEx3YJQTPP9zCIpruPRNF?=
 =?us-ascii?Q?S7HODi7A7ZEqYnyHRAIEtkFrTABe+2PpYIulzfdnAxXhR0/x+VkEKbJUd+Hb?=
 =?us-ascii?Q?hi/1GtIyfqAWYoXGY8pnDOGycmqaLOeUs8VAqChcShehvoG2mOofHFdiGbFm?=
 =?us-ascii?Q?MaKLVWHz6aJ7n5Be/ZKrvQl6yB204vMRNK5nnXSoXYdhQt6p63O4JFdhRMqU?=
 =?us-ascii?Q?v60qrYPijX/aKM3m/SXu0s3JtmeNDk9jbzv/OqofKqejC7dRUL8YEIo9AKhy?=
 =?us-ascii?Q?mv+G6UBLHQMgmVm3QZMqe20J7+bzyIyZMHDtdXeLby503agTA6D40Ioq4lny?=
 =?us-ascii?Q?Qcn9L4srL4LYL3Lf3CyjPebSOtcDExiY1o+vgcryu1kmG1nan9NqeElc83kB?=
 =?us-ascii?Q?aRdvYkHFCAvLbV+LlYmJd4F0JE0tCi6cD/T2dFWoeKrlmrYQEDR06kb2TWJn?=
 =?us-ascii?Q?gmE+lWDNnXBfyYA4naQN+iVe2dJLs1w7WdBvBun1RMLi+OTgBouNQBwOcQN3?=
 =?us-ascii?Q?1uUm/9dCNcZSJKTe+uyHrHJPpsD/nMY8xF5xMaHz3GjYb2wu9TOyQq20sRbO?=
 =?us-ascii?Q?q2yz1TvF1CPWBA3gA1k9mYSwtAiKcOufqwVaKGv2m9kztLsGHK7jBuVGJcYO?=
 =?us-ascii?Q?lT4f3UbBq7RNPbVs7zWXlRGllOTN7Nb24JcdjPYTUrmaCWHTzcO1iYWy0gQR?=
 =?us-ascii?Q?D6nA3+G49iFfEGX+l3e+/QqJyJ8o0bkxR4mQV95Ptt5lHUReGG5kyawjPhUn?=
 =?us-ascii?Q?J/wMShKYN8OzN5gx4GItfrRPE0/zrbWhhbc5E93kF7ZcezFeQfqjZvJ+kNNb?=
 =?us-ascii?Q?o9CC9r68gwv84Lkib6yUc/Il07svs9P5gDvXe/DBJ9n0t/OlkP2RGflh59NH?=
 =?us-ascii?Q?FyrXNdujnYNMJWOuanDrJeOEs3sEQwUmKIPzXMMxQUwLiv0gaJCPKK60egw/?=
 =?us-ascii?Q?2LV4qqHr+RTQsC1hByl8YgmJElOynjE/Vhc/qnlPPo6mDHCR56fuuBM/7+Mw?=
 =?us-ascii?Q?G1jul56ei7LaN08/wFNqdnGZoRdDhIENmkNUMRR4pnPNTFXaSuZnN5F8D5pT?=
 =?us-ascii?Q?9zoFWUfAWvH7psI0H/SvJTOaywWdIMr/5ntqsNhVZy7IirQFMQIJRfk20w0x?=
 =?us-ascii?Q?NSe7AHTznsusn2YjmtiK2vUYDTh+4faKINgUQrbw4Sqj1S16eGWEpKSZXPqj?=
 =?us-ascii?Q?r3xUjxkRDm5WeAW1ebAooWvOQKFbfizRzTojQwXyBo65e3tglZI+eoY+dxcq?=
 =?us-ascii?Q?djqycJcESOvPKnrwlQbCU5KVPBwtnQ8ki9unFxK3H0amOzAkMjKSFCraZF2R?=
 =?us-ascii?Q?S720Yjv+9S7dLZ8Pal7l0NG/vHnKqNphyONkxoCp5l6rBxj1LqatKd84s18r?=
 =?us-ascii?Q?GW9/WgHbh54ky8ScYffRgYtShu0FhIZfJBVNcG+3bATMaERxdg3Ys4Rkp1l+?=
 =?us-ascii?Q?y8+i10nOG8dlj1BFBo+4/jQLMa8iL60pMLSSUugDKFSv1/w8SvA1qhpOU41+?=
 =?us-ascii?Q?xbLdQ46psgTtToShKbQVjzKd96+vggTOty+UNLgTKSpIJ+oUltCS//QRCR6O?=
 =?us-ascii?Q?xfN2rOiiHGo6efWZ21/gvp3SGP9vxgvCBGZmII9PKsrt2o9PUwZipejwaks3?=
 =?us-ascii?Q?w1cOuw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc2baa0-5a60-40e6-5532-08ddae5b5536
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:29:05.1975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1IGesW5yMYCrU3/NobQvIOak2NzmbhqQoWeRS3aLGsR9pc0eIHYWxMSlTDO6MmX91O6BSEaDPaGhbahX3jdh4DVflmN/EU8YlMX3q0rH6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9632
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA5NyBTYWx0ZWRfX8lCwM6eH78uk
 8NQHMTIow3ActQ35BLLrsC2afCeDg8K8r3tHzRrZhAOIagv7nXdbKQg4XCoXLz/ctA/N8WUDtu3
 W435Trzap52jQJ5yKUjQmDLObyr+X+NL9kDv80mQX3bfGO6AVclirEkNuHOUFWJSe5QUxLtk8kn
 zHyu5Tjy/0uLwwf46npCxwczprWVP5biWzV+gH8ZSLBe+CQmGnBYctQ464OLcOHIgyLzvBq9aAZ
 RmiPNhTluqEzUfRq5VSUxFQVe6dJ011BCVOZ+n3Lz9UoEwX5SHwL8oN9u5h8GINSXYX6iXHxtNF
 vdlqnFufFIdN/5d0ZXBDxnNOvckzT0KwWdS2rNYeh8CuQUG+x4BCJi08DEu8eCmB53HHRHcu9+k
 bXSDveuWzH5PmIt7Bz1EIyykLMfG1EZe2WMeQHXy+eAMVYoswESurop3eqR3U/oPoiSvXKlD
X-Proofpoint-ORIG-GUID: LS-9dBjM7oCqftSx8AFuHaKbYbWpaBFK
X-Proofpoint-GUID: LS-9dBjM7oCqftSx8AFuHaKbYbWpaBFK
X-Authority-Analysis: v=2.4 cv=LIxmQIW9 c=1 sm=1 tr=0 ts=6852a303 cx=c_pps
 a=IA3z5DP03+00aNcgMV2pVQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=VUPP-S39-c8G-0SaL20A:9
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

By definition an isapc machine must always use ISA IDE drives so ensure that they
are always enabled. At the same time also remove the surrounding CONFIG_IDE_ISA
define since it will be enabled via the ISAPC Kconfig.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 69c4c001cf..03bd09f680 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -427,6 +427,8 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
+    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+    int i;
 
     /*
      * There is no RAM split for the isapc machine
@@ -489,27 +491,20 @@ static void pc_init_isa(MachineState *machine)
 
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
 
-#ifdef CONFIG_IDE_ISA
-    if (!pcmc->pci_enabled) {
-        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-        int i;
-
-        ide_drive_get(hd, ARRAY_SIZE(hd));
-        for (i = 0; i < MAX_IDE_BUS; i++) {
-            ISADevice *dev;
-            char busname[] = "ide.0";
-            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
-                               ide_irq[i],
-                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
-            /*
-             * The ide bus name is ide.0 for the first bus and ide.1 for the
-             * second one.
-             */
-            busname[4] = '0' + i;
-            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
-        }
+    ide_drive_get(hd, ARRAY_SIZE(hd));
+    for (i = 0; i < MAX_IDE_BUS; i++) {
+        ISADevice *dev;
+        char busname[] = "ide.0";
+        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                            ide_irq[i],
+                            hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+        /*
+         * The ide bus name is ide.0 for the first bus and ide.1 for the
+         * second one.
+         */
+        busname[4] = '0' + i;
+        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
     }
-#endif
 }
 #endif
 
-- 
2.43.0


