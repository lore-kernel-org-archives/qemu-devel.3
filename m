Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD492CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 17:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH3QU-00034B-F0; Thu, 06 Nov 2025 12:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vH3QS-00031M-Cg
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 12:05:32 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vH3QQ-0000tW-1G
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 12:05:32 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A6FiLHV1143749; Thu, 6 Nov 2025 09:05:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=6uHD1E2FsazS6DdukAQPYElBoaZFuyKi8PIDCVUgP
 0M=; b=Ts0kSvFATEV3ov+9hSyqA0qdrXdWIDebt+AYxXcORjctnDP9GoYETse1p
 J6T3Mnnj9zbw6x4zaeOzBbU06Kj7fNiG/4B8WLtn3Jy7eRifsmU9tMdByPrfahkT
 C10Wgc3MAPohmkAauaX6EywnBLrIXCVvHvng4xo0MYecRMZG6HxI61S48Sbandze
 36mEyUqtABI0MWnSBqCsXcZf8Mt3BV88FPTkypJJN+mD1l7IM+Fie7F5Gs5rIRej
 RdmMSNab6sTwnBecCx3Ur5+D0pClMfk0/GvE1rEYBPmpx1+DWnqwZJMKSVY1H3rV
 YYk8n6lDD9Hb5MmvWcHtMgo8WJ13Q==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020091.outbound.protection.outlook.com [52.101.56.91])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4a8bch2y2s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 06 Nov 2025 09:05:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGvbTiinVBYOm81qjX4AXj+3E2iUYoGPzv40EQs8YqPrFo23B4/T+I6jKnZ1rnRcA3EYZySR6BDzBPVxqT+QSbzxgZLL6FIZJQ+elhwC+lPWj0iVCdz1vejaQzPdI9/gG+xp8duK6RMp2WrJHXmYS7vhfvUrc2qVuLGc3Tu6Hn1Z4iT4C08PMQnloWW+A1CUWipADd910E2cGSL6wDOCnozCSflEgixzloq2xBUcMf2MBoTnZItww6U4cXSdtT0H6iRmChGc53T9d+WiHqurhk94LzmAXI5d11ddSN4tmTaSO8GqwDr18goFrT5EAIbF3qGkxUv4b5izi/CrqkPKXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uHD1E2FsazS6DdukAQPYElBoaZFuyKi8PIDCVUgP0M=;
 b=AANF6tcCCwQ6/tW1utx1NeyNYDr3CUCD2r2HUI3DRA0E9d3M4Q9FPm6zJuGyqggwHxYD6OVe+hPEiUMPSLLKra1YjdST7dNK/GtstIEdoVMe6PsmBIVBAVEbloOhFeDan2/Kr3U8Htizyj6CGeG3f8UFcd3E+1PQQkNK507ThvlPXIq6blSsPwBbR+7h67zpS+YewR1OHoWeyr72eb0pPz2ojXNLBvrky7aWH9/IhX068DpYXoqumc9aCGtkkEghQCa+xivAypu7f0oIi696y8Pdr4hJMKxRFeIiudlH66n1Mc21DzLyk3MSAU/D4TVGd5ZhArcDC7JpapAKSO806Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uHD1E2FsazS6DdukAQPYElBoaZFuyKi8PIDCVUgP0M=;
 b=a03/rp4Du38QSisGHAxE+l+s7LHDNMm6OZHkPB4WbQ3PHuJ88bGiLdWVyPAP5KUJNfzN2FZxnzlAt4HbVwlP6qP7xe4o1RBGUMn/ka8sMjvQvWDgtA/K4e4w+glOoh5NVMXfCQka8OKgA6vCEqX6NSLwfpVw2GKYWzd1AkSgOvZehoiX8lpfS9nV7xE8OjwJCOs29j1Eh0ifzyEpS+tjoS0Kjf43wHqH25w9GD0TQDY2EINVsVnhCeAcwIbBNhRHrizlEdF+CUuFE2+OSgg03bu+ocYhTrwY64FLzYAD6pGV/WGmxyLgG6S6qfvxQT3swKAX/R2pVLo1KKnLxPDe5w==
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
Subject: [PATCH 1/5] target/i386: Add MSR_IA32_ARCH_CAPABILITIES ITS_NO
Date: Thu,  6 Nov 2025 10:46:21 -0700
Message-ID: <20251106174626.49930-2-jon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: d9f7d7ce-aae0-4d16-27fa-08de1d56ad08
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/3+6L7Bf3UNg+L5+9GMDhG393LUVnDfHH5RuIH9GnZM9Vg5vtQzlpQcAWWyL?=
 =?us-ascii?Q?svekzH4jWA4dgOUbzUV2pHPDKn1KvuYM4EM1hgFThgiUDEFAYEOCSbaO1T0b?=
 =?us-ascii?Q?5Bo46/j7AIXP4GC66J1fUMD8T/C7TbqVIgTSqHymPcbJmMzRdnspK/43vO4G?=
 =?us-ascii?Q?9YC2SdYsmi8CgrWK2vRKPhXX8EAZd2WAPobhGHmYeRpemURS2vIxj8HnBTrT?=
 =?us-ascii?Q?ZwpGcUACR+yFBKfWOw6uqehg/6vxx3mNXxzxPdrPbSQYWzib1aYvvhepyFAd?=
 =?us-ascii?Q?3t7t+kDU25AWU8OPjIJZGUl5L7rfhefnCZHTPOENVYT47QbESv8CDkAowzWH?=
 =?us-ascii?Q?WMi6X00yH2T5X3Whd7G9cW0fQEEBaBDLgSSK1dRcA0yvIIXo/SvD330BjnkB?=
 =?us-ascii?Q?42vOOAlLKM6f3equihrGCLVe+6JaGWpZGN3EfYI0TFv/6RWaq5OhmMI/KGTu?=
 =?us-ascii?Q?CXJmrH1Q5PMLTw2Y5NgwKq9ssX9DUgmg0CCtrmgqeGbTkSZzVVxq0oatC73j?=
 =?us-ascii?Q?xR7PS2TaXqgOlNQTC9hBhzPlKS7xZs5mhHAcTgScJgoeu9CocUQM8szcu1oc?=
 =?us-ascii?Q?kDQahxCEbGLdnsJ8R/RZ5Nv6m/5wu/ckI8/Re5WK1ktpjUtHzRfvpbbiRiSl?=
 =?us-ascii?Q?LYTV5o1bR8P9b3XGVR65uhvgMVZ3FtY3/HOP+GeXXw9lDEkrRseo1657euS3?=
 =?us-ascii?Q?bwxr8qVbAoBX7pusVkcJ++wwMgOfF25yR5xJuqGNAno5zIGqX2yvt2rkr2nf?=
 =?us-ascii?Q?iRgot1BTOnIMgcUqkbWnozPTcqhCwcbwTSaSA5I7v1rj+Wto9RJs6mncqANw?=
 =?us-ascii?Q?kO1Ul/vOhqY6qAFoWKwJtiUU9ElItAChGLbmxI6BUIZAHkQNRURvYvOrP8mm?=
 =?us-ascii?Q?gu1wsMl+EA5lee7YEtTsDQR15jXxlnE/Fm8E0xY9/YMa8wuLlFiIPRCI4nNf?=
 =?us-ascii?Q?e28rDxS3mtWRWzjzkAkP3cjWL98OC5VFRsS0x0kVrg2CV69e9SlJb7Xja2Bj?=
 =?us-ascii?Q?++a2xJZOShNKqhqn4dJAnC232WVIrrX/JIV0tP5IUxPE0rWutLvIN1ZeYn3G?=
 =?us-ascii?Q?J9KkDOnxyWF8HQ4u/ncdBDXxnthvN6sPl2rEhxk4gs1WxG3FgHBvJgKxWH4Y?=
 =?us-ascii?Q?tqL20jq71jm+pOHCceT4l23Ri25DUwnmMJI6Zc3p9UrGGLotFVz+UGsCn41L?=
 =?us-ascii?Q?5A4hL1IAN6zGvxRlcAU+vknnLSysbnjNnmuhE2rc5AgrX+47Z1cxnWVmf2tD?=
 =?us-ascii?Q?Uz1nRyWUc85pmvi04st3MBgEIAh7HnObvapdBloyTD3i9Dvy25YgwMUyaRCd?=
 =?us-ascii?Q?owKhNPIGxt6gmTnnVRVoWFTsjF39X0304ZwsQOP//b4Wbk3G+eS/YCo5UKEk?=
 =?us-ascii?Q?DDkZ6heK+D/c4X4zgHv6ZKl0j5Mq9HgSAO+zNbZWICqbIjvkjFzc/UadA8c/?=
 =?us-ascii?Q?auJhbujz05FNf5+Zup3ymW4C1ZA1DB+yHA/wS/1nkcw6ROH9Xs5kJNglxEr5?=
 =?us-ascii?Q?5SWT2PzaSZi8ZyIEIiuUlybFjdHmyui1m0Qf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR02MB11133.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4E3u5QNBL+c6W4avdezqB1bHHCGFgMVNTYLurms2kYB1SDYzm7eTiAZbshy+?=
 =?us-ascii?Q?5cxS7uyjd4xqETkCLB2FG4SCr9XFe70BEmPmK5wAfZbHpRr+4ggWVRxOtx6q?=
 =?us-ascii?Q?uHK+uPWza+e8fTo9/5E9qJWLxjGpu2KUPtnq6x58N6+4ByxmkWRO7mvAtBAP?=
 =?us-ascii?Q?KsasrPRk9WgGEbkTSufSLheVamCloL5eFkV9hHFwjCINSUmo7Bvn+06O0OmW?=
 =?us-ascii?Q?cU6P1LeSlm8TR6G9bMQZAu71KIawLE7CeuJGw2akfpWbeSsoK4yWm2vcYzlp?=
 =?us-ascii?Q?xmJSpmVKS96SUw8LsuZQsImIJSi+JZbGgx+pye7JIbIRiihQx+J/oCv1VWOu?=
 =?us-ascii?Q?kZDjRg0oltk7nW8SgCe+9DnVEDmThLXFoIspE8XcCbRs+DxdyllqiukBctVT?=
 =?us-ascii?Q?KRupKmspw0mvqQ+X4Ysb/N98CHGHiYO7O1q2zTTf/A0Sm9r6zY5NNrzfQ4h3?=
 =?us-ascii?Q?ldcEZpxC+o7nR1G79jUaQ1fjZ0DhU1vND2N0GC056Aku92MwjWlfr4QmGYAO?=
 =?us-ascii?Q?82solx5CqrxCCNEpD8YHeh4hWcenX7NxF7I0XUj0aUgMKnmtZTOEqIqF8+OV?=
 =?us-ascii?Q?M06CxNL7YnSmBgWJjuCokZvtcYdTD8d9/ZLhhMHmxm0GZ4nrNDYEwe79IWV1?=
 =?us-ascii?Q?OGEQM2zZ49hE0xTbBYdP7VozYc1ivWzaWETfJYhRWrFOgffzfaxdmU8CwSfH?=
 =?us-ascii?Q?kQtOXVymB5zunb8/JAcZrikwOCRVAk4VnOE7VN+8Smo9J+6aHKMUiZocllgK?=
 =?us-ascii?Q?DGTQcIyw2kPVT3T9HrpGLdJYnUmjpfq5uthFqd3c+W7bkpVJghi/yaXJGNmG?=
 =?us-ascii?Q?lytNhee95C8Zek/oKr1GAIV9uNnkcZ/CqcYhWtBiQOKDUKh0IxY8s0Gpo96p?=
 =?us-ascii?Q?nMRXVQlPaRxpnd6SrZsnaOkIRkEER1QDF8s+xadLsaJEwnUxeZZA1WRbaHCg?=
 =?us-ascii?Q?pK9HKhiYnjteG87MBJt2Um6OcoAEmz72JNMaBeIgJzg9Mggs2kLUQsAPfHGb?=
 =?us-ascii?Q?fu4JZBw0hgYWDg7lzwf6XPiUfkx4PC3xskZlNT/aCo58pu7cvmNh7tmAn5BE?=
 =?us-ascii?Q?MgFKYDiiJr5tpxpBIiMrXbhCW9A8a7G9ma1M5lSd8Lfk9G6Q4iKwvGvCQP1u?=
 =?us-ascii?Q?SnAIjlqPXYlhCMiqJk5ptBIPs6vc0obrf6s8t0dj/StYTwUfzuocbFRq8on3?=
 =?us-ascii?Q?J+vnwyb31NG2PNpmLSX+t8lr5yDZIDfeGEsUg3ypWOzGf5NWC5FtzD5aiXtT?=
 =?us-ascii?Q?NqOd5DOvuRDqqnVFCjgFTAq87+f+RxUawsEnMvhcTBVqPemHrH/OgWjAnho+?=
 =?us-ascii?Q?d9HNh3cMjlwKPR4EFu/uz8jbieTMRmcpGdqEE/DFEdIxFVrvi7Z4L5IMJPBI?=
 =?us-ascii?Q?YUXscOWNBNLA8flUnw19ns+KDCzZJPmHtAuXPU45pB0C+Xz5S4WvKFZZyT0u?=
 =?us-ascii?Q?GJq90YKld1CayC5OskSJAqn5XJ17qFCK6MFg39L8i92W21/XPcAlWZAvQ1AV?=
 =?us-ascii?Q?qnOtZLkkhHU9EkCbz8Lf6pmPWk97UqVThyIcYOXCm2TcEZuz/tEEsvFHKsC2?=
 =?us-ascii?Q?8WXP+0djPpkXAwvcIoXh1tmMUycO41Q/vDN/zvKfKIrJ1hx1/TQTref84AMk?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f7d7ce-aae0-4d16-27fa-08de1d56ad08
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:05:24.1964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+cebWUX46DNc8EV8FSNsTJ89zlYE2mB81MxZIOtAAMzOo5mATXDRER6yjoEEX/tkMgPG9x6pHjtlQw8ZAvlzvJnWObJZs9OFXnMm3ZSuOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8000
X-Authority-Analysis: v=2.4 cv=OvVCCi/t c=1 sm=1 tr=0 ts=690cd556 cx=c_pps
 a=DCeSEX+nBJmE/I7rcEuDsA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=64Cc0HZtAAAA:8
 a=hixg0Wx_gI3H7SzMrFQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzNiBTYWx0ZWRfX1gqxg/RAnWWR
 Fpap1r9+GG7QApjzrnXSF5D2HgK+Ns9euYY4VcYddcFpX2pWYBQOtDvHrNPsiXuVXRKbAdyBp1y
 ZkRfb+4BG0A/hRrqyqGUgcBKvJ4N3JQsT/Eyr/P/2kBJ0m5kELWWR6s93QiLuDqijC8mnlGaKOz
 J75NyAP2ese94uvuOhk4UUpbhE1iY/Ga6lW9FtJPrkh+b9MlsI0wy3197wOlZuVcpq1rmZem+o5
 ihc13bXVay/vGrFG9RI/OJc/RL6yRWKWmau22unSNIhe0w6kpBgYmOav2opGxH5lO8x6jy8KCPo
 T7b3WimE/yrAV3hjaE15TzRrEzNH8b4hHgaM8cuf7WgtdZ6pJ0CuGYkk1DXMmB+KC5o1SKLX8w/
 vTM7PFAIsL+/mVcTRSJAgkYR00zcJA==
X-Proofpoint-GUID: 2hcPavIMSAXAC9Gt9YAMyrp5Bf82bgoY
X-Proofpoint-ORIG-GUID: 2hcPavIMSAXAC9Gt9YAMyrp5Bf82bgoY
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

Add bit definition for Indirect Target Selection (ITS_NO) bit 62, to
allow ITS_NO to be added directly to a CPU model in the future.

Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 target/i386/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cee1f692a1..93f466fb2b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1245,6 +1245,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define MSR_ARCH_CAP_PBRSB_NO           (1U << 24)
 #define MSR_ARCH_CAP_GDS_NO             (1U << 26)
 #define MSR_ARCH_CAP_RFDS_NO            (1U << 27)
+#define MSR_ARCH_CAP_ITS_NO             (1U << 62)
 
 #define MSR_CORE_CAP_SPLIT_LOCK_DETECT  (1U << 5)
 
-- 
2.43.0


