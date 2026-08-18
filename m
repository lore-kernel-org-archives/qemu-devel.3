Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC09AC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 12:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwIiD-0000r1-TH; Tue, 18 Aug 2026 08:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwIi8-0000q0-Or
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:14:33 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwIi7-0001LZ-9K
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:14:32 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IA60uj1136424; Tue, 18 Aug 2026 05:14:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=xGnTM0V/+Q1NnttD+0lxnjqm+TYfudZ7MSrTytNC7
 cc=; b=ANz7yghmYn+vJwTpyyQPk8rQP1nhI/vANyLQ1bbm/R0ZYLYpr8apelaVB
 +gjHtOiMnyltzP7wtXFH0mh4VqT8X7HFpDoaCohvOOv/qHhuMomIBzAaqS0vHlMC
 FJWHncZShEBXwMy1TZSMeOkCq31H4pJeEebqFW5gdEX+GkOfcacwjyLm7APo0owL
 chYRSd0ZUTTwlQEW7iLvcoG6pHuo09qXGuIx5duI/Ri6eMLKMltu0wUT2oD06aCo
 9Ay8oLHSmkMom6N7gBlVSpqFplYXyOqFoOBE7bcu+/IS6TU4VnOz7G6LpZEqwVbj
 lilJViCF3a04hwGFFCpGWHyQzthVw==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020131.outbound.protection.outlook.com [52.101.56.131])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g2nn3xg6m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 05:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEAjE84FZO+P/m19UULPns+j4s43/9iJC+Z21XH0XLV1eAM6mZu3b/25KD3CbXHtwf6ask7WpYTv0om+Zdu+WwCEjmBvfa/XyJxpiSgUHn/oIHIQSEUrrb6SYVKeNOaCldeW0CMc8yXh0pum/Q3pzMfNmRBOouxoPlVciqQHozUUvlcoEsz9qGsMUBum6HgqgcEGJY4VvJTjGwE61fJxpy7uU2kkMR40KdOQKhvsM4fNRoy5y/V4TyflQY214GrFrthNpeCy0HNpfw4C6NdCL0cwye7RMf1mlWISEVsc4j4a3ognkGHnI3+QfH8KN6SnF55EnUHYjq2gA/cZEXPx5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGnTM0V/+Q1NnttD+0lxnjqm+TYfudZ7MSrTytNC7cc=;
 b=bY5YBQTDT3xWUuQCDw1sYuufEl1nz68JBKMxfOfqAZSuk9O7JaZEZQ6L2WGlThNhhvB1A5tHMKSqkhCJNx52Ku9jFYvndNgkKjmaXLS+Iz/gYflHDcWj8PiM74WTBfahUdfxser/aeHQPbZSOSktJ0esygAQiFl+SGrKTdq5ibH4OUtL764Mh5DQN0oIjWyovsEAgHYgBwik6LT8FRjgl7/dYOEQZ3HsllYokgz8b7nFnvxzvryvxTKoQqchoo7RYvadhr+EY5iYadIPN0wXw1fgI7oz0kjF7xBc5LMre6N7VHXG+9XJeG60qmjHzC2jaLAnZpezH5Bx848L2BZqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGnTM0V/+Q1NnttD+0lxnjqm+TYfudZ7MSrTytNC7cc=;
 b=kfDX/s5FSgUMfd3nj3U7e8dXpxIuLPfKvSX/jdkWIVkhECzLSXpYSSnYKKyfPDGT6cp/InE3NUYCvc7SDylQFbrT9PznH4Qi+IFAcxwBocPPHwG+AAX8u3N/XVfmFsV2BIbxRUn9GK8nGSggQKRORmkMdgkdl9TATALdtCxW44ySM9QA+3324FgwK7dBHEhn75X/PUqtX+9wOWC654awSz3sUQWald1ZFuSPsiONaehnz1VbzsAgCRR/iyTiEzuMQyu1G2dUkQdlmzg7mArQKVDS1+G+9Krx4kCPNXYjKp9nWeVMqST6uTQcXwy9Rcj54WKvYgemwmKPThXQzBE8Xw==
Received: from BL0PR02MB3827.namprd02.prod.outlook.com (2603:10b6:207:42::26)
 by LV3PR02MB10210.namprd02.prod.outlook.com (2603:10b6:408:21a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 12:14:28 +0000
Received: from BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd]) by BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 12:14:28 +0000
From: Lukasz Kornicki <lucas.kornicki@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 3/4] ui/vnc-clipboard: factor out clipboard peer registration
Date: Tue, 18 Aug 2026 14:14:12 +0200
Message-ID: <20260818121413.2660786-4-lucas.kornicki@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818121413.2660786-1-lucas.kornicki@nutanix.com>
References: <20260818121413.2660786-1-lucas.kornicki@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0035.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::11) To BL0PR02MB3827.namprd02.prod.outlook.com
 (2603:10b6:207:42::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR02MB3827:EE_|LV3PR02MB10210:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d22bd2-d64f-42ae-80e8-08defd224085
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kcp4hBBOL1zEN/Wy0WjTa4b1O5Eglzqz6U1q1coHKQ1RDHRJMEqzhyhqURp/CZX/Fwb8pS8W0ituX6TI2RKixoVfE6PIpni/z5M7OGWtyHAN1Sop3hZ9Ya9UpmuV5gMhqrOI794/0fUP9ox7SCBeTPo0L7/fZwB9ncM4Rdknc7ZMm4/bnhRMyzxRyo7Anjc32yyR1sdfCZtQVsYEkbYfjNO39fw/QRWhGX3xsivf5D7+n4gSRTpInbS9rjWPWwVx6vZHq7+Ksc7onEgHVhffNa53gAVDz81H8adwFGDRvA83/BM4TfwLO6FcH4Nefg1B0PoIEZxMGg1vxbpx7M8giAfogO6g9mzRokLsJ8GuFaTjcYQrsS0nbExJIm42fRWcaBr7LsR3kcRPuMio0m0YXfEK+Z2SW0hzhC1/Di3PrdopWjE4vFcgxuodAiw8ZIfeLe8GMwsoomB/AbwuXqXtwJVUHnUV0Xx/NmUUgnv6HHhLiPopd1zfoastA+TlXV4DyZDqg0J5YcNCw1su2T0r3Xv6mMRNNJ5nh1eR5AV8H3u1atjVGtjg9DY8mVFFwFh4Trn9TsiDukolQeQg2P1OKXupMaiemPzeyCklGT8KVdJZXqlUipVuPZFJEsURcLpS8pHacmk3RsTrnv8w9tM/tVrjl2o/tuOOPIGyojOnxJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR02MB3827.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r5LsUscYtim4CI3Z7VHVHECZZ6ue1mpAnR/ZY9kg5TqEZNhqvcjhWHpGckNh?=
 =?us-ascii?Q?/UY30QuzLjG+1VDBFIAb3eq+kwMQjhbrYwCCp8MIxL9rXVZV6WJX00rkeAae?=
 =?us-ascii?Q?Ew/PXAkDTsDnfJF+5ntPotMsI1ECT0KGsmTRp3SzjwnOs0exEo031Wfuzwb7?=
 =?us-ascii?Q?OzuA3Vcn2ijfaQCcTTlg/FGLgSPki7bvnyMGCDSF6zzG8MiTAjZtttHRPE10?=
 =?us-ascii?Q?xB0WQJ2oGkf39RBCXDQh8+WreUnQG7f13u0bsQKcL0wdsIipjgcEm5b0HT6Y?=
 =?us-ascii?Q?aqda1TFz+6m6gGdh1+P1P4BA39lnJV6v2u1cZv6DPtkIqX7bWH7vWJspxXHs?=
 =?us-ascii?Q?z3Z/xoReQkFJG1wQOxQELHZFdo5c91/bzrg8PItqdSfcvkQFNzF0u7cRYic9?=
 =?us-ascii?Q?atircAYH5JiiHr+VKnm1pVSnm6Jjz3GkA+7EXuLmhcnBlQ3Mss0SZOnyBs2R?=
 =?us-ascii?Q?MPSKJHivXqFvtCF1aM5BMmscB1Eo5rKUTDPoLdJUntSIXcSnYLa7Y2mgflLo?=
 =?us-ascii?Q?aKzepJzHMXE2wdCa9UkG11aJ/W0aN2GW0uvVPLjFNvDKiUTlXlIcZTyYPloO?=
 =?us-ascii?Q?MMX5uPh3Eo0GaBWG9J42+EHlHomNU5sJlQ0P1igmgJW5KgrfYmmbzLKB5mlC?=
 =?us-ascii?Q?PKJ9DEwiJhgyv0RUiFXI5u4Vf62siMps+CvstexImYOuHFeKjcLri5xme5OF?=
 =?us-ascii?Q?HXvg3skZ2A2yzx46lkz1f97zYyBV+Gdd6CgEC0ljwRgjkUCXPK/KnQ2Tgw/2?=
 =?us-ascii?Q?YV7Mcrka1tS+7sC0GnoGwpLEuHIkyQSjYBfbkHi9UIrSYx/S5k3QefZsDR1J?=
 =?us-ascii?Q?DOmf7fAAWiXrCa36gAqFA7k3EeG0Nl5/A7Ltq7y7jswf6l3h+51XCkoa2OVn?=
 =?us-ascii?Q?cUuUjQeub0haKvtWpgE35Toj7b6WW8qsdm8WN0bVe4uNqAcjp/DNVdCoC7uQ?=
 =?us-ascii?Q?gG4yT2+R1krNbszaeflLJkNdu2gWb1rzG8ytT65yrg1jEBdt2MWUTFJ2hjtC?=
 =?us-ascii?Q?ArzVegESBx3I1RSVJw5znei5LPQgClzafrgCEMg+eHlrEq7NfZKRjZrsvOyI?=
 =?us-ascii?Q?fX5fmIF1cdXQskRy54BtsaN6zzcBzO/u9oy1qQ5HmENF+CRJuzcoIQ++vO6r?=
 =?us-ascii?Q?Ss/Zr4Pre5F6b0SaxT8R4IEvWPxMXjYSjRhcQy0KI0abjRkhkCwr74NrtAZt?=
 =?us-ascii?Q?gZQssqghr4X7W+A9n/WvCoepsz4oa/1Vxt8ci2+YbFTKX8rnaF84gOrjj56K?=
 =?us-ascii?Q?46hNTgDJQ/hi9ffFEBVfC0rpcw9yZAJ56lyeFqFEbURC4SGby1zZsAGoqZgv?=
 =?us-ascii?Q?f5i8gGX3yFUySW1KvnLm1OSK40eM6kltGAXsUMSkDNNjYQvazBzKS3a1yNxy?=
 =?us-ascii?Q?UlXCJQaAGzmpZOeowZ0T8h4KjKuXFYV8tvvo3A+jkI2GCZJwecvBcyS1hOGN?=
 =?us-ascii?Q?muwLo/UGsvwaw01ym+eY2XDewJHOBPeN5Vns0Vq8ZLSdKurOOZGK+ws7WmVv?=
 =?us-ascii?Q?7WMu/QVrXl8b02F/zPfxAClpFwUTB+mB4la52mDP7KVfl/Wiixke8z2Nt+0C?=
 =?us-ascii?Q?r79p3/bb7hCI3hkNxObqlHtb2TfHsQl/h157y4rEQHqW2429XAQh05DYIH7t?=
 =?us-ascii?Q?6z89JmGChkuLoU/ZXvXC6MladT35EgNGHK0w3MdGzs9ZrTdVRpOyKXPM3fvn?=
 =?us-ascii?Q?+Tpx4BvUkVzq4RtjWizzEmaLtZD8j4/tu1ztIFVwchG2FZtQEBjtcgIsWedL?=
 =?us-ascii?Q?NEzkvtZHfw=3D=3D?=
X-Exchange-RoutingPolicyChecked: sjXTVmaWBIvPS9VJBliQZSV78gOlaCBKJk24V5GJvh7nWoH5t7BT/IsasngNl0lDBXLkK8HHMTvsaDfOTB67pHg0TC06uj3Vyu4zXH4mxplQhH4MufgOg9xcPSEW8W1pzfMengBpyvRLnVoe8r0LzC4rxNmGM9NeX7QN7lm7XB/YQ/fpZM0u7sMNz0GUjjggskRDfoYDb7PFJuKErkjIFSBjV5O6VnEW6IsuVPdza1cAjbbw3ASRaXGmnOa1D+iwNOLqj+5GhFHqhURm0Q4duv4QaJh6WklPFME81cQEKMxpXfWiSmYJ8x9hBf+GCDISnf2y1J1cOczwVu0aUq2vNQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d22bd2-d64f-42ae-80e8-08defd224085
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB3827.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 12:14:28.7124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEwm6f/NsBIaYIVfoX0tI01+3ic7aQzuDFYfc1PUb7YBObQhVuF78zjnqs3FmfMe93c8vlD8UNx+s5S/BCf7Ebrqbp+J69A8o3xXCre0Eio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10210
X-Authority-Analysis: v=2.4 cv=DZMnbPtW c=1 sm=1 tr=0 ts=6a844ca6 cx=c_pps
 a=xmbubLo1gGd65bmaoQID5g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=z-CVK44dz1E3zK-qHnUA:9
X-Proofpoint-ORIG-GUID: E0_vtxopceSuJMxwargjfbQ0oS5k6844
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA5MCBTYWx0ZWRfX7NHQ/eTTbQo0
 4WlCVxHmoIY/Xv+6FOJD3Zz1A9RLjKaeHOICDZhYwyK5riJyVF5DXxudH8fXTaMcXCCUpbJEh6B
 vibyBP2TFVO1dbskufBEAbMKPsi10nwmJQkzLUwEHfzGoo207vITLHTrNiPQMPm6Y0cM0hm/t6X
 C7+Q31J9WCrXs42Xci8RkNUPMu1aLzEZkRfX+K5jEyIZ3NpHbvv0wGiyoashDpSmOxgSojgtPct
 EIHoFfLE7NN84fV+NJ2wLJ73uq9ZbZpP7mC6gVjuIK3D/VNSlhCbh37TKLnGruQddto/KkhS2a9
 Ek0YfALMvNEcwVdq3TPJcKkC29RFCxwp48c8OKfVAMcBGIMZgJ2P7/cJmx/Qih/nZJifZECl4WH
 1W8c90UzdK3H5jbFd92r4MpM0XciHR7JblfOuVh0gNJJLu0HY1lGgJuKl8FCGIsV8pfOUsF3Whr
 x8Bqw0EwxundPO4LrMQ==
X-Proofpoint-GUID: E0_vtxopceSuJMxwargjfbQ0oS5k6844
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA5MCBTYWx0ZWRfX4PQn5VBNzRn4
 W/UETNnhKkYHJSBsN2RUl6DsTjoKeKIJfB9ucI7SCExn3GbINLH1fRwH9BuIfZ8riigA7MD7IX3
 U+mNQTkPfrWqKFEMydZYZD6iCkrM/hQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=lucas.kornicki@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

VNC clipboard peer is registered inline from vnc_server_cut_text_caps.

Move the registration logic into a function so a subsequent change can
register the peer independently of extended clipboard capability.

No functional change.

Change-Id: I96b20e914b3a0e496791a24b33db8a795c2c1690
Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
---
 ui/vnc-clipboard.c | 17 +++++++++++------
 ui/vnc.h           |  1 +
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
index dfe830f819..67f710f6ed 100644
--- a/ui/vnc-clipboard.c
+++ b/ui/vnc-clipboard.c
@@ -325,6 +325,16 @@ void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text)
     qemu_clipboard_info_unref(info);
 }
 
+void vnc_clipboard_peer_register(VncState *vs)
+{
+    if (!vs->cbpeer.notifier.notify) {
+        vs->cbpeer.name = "vnc";
+        vs->cbpeer.notifier.notify = vnc_clipboard_notify;
+        vs->cbpeer.request = vnc_clipboard_request;
+        qemu_clipboard_peer_register(&vs->cbpeer);
+    }
+}
+
 void vnc_server_cut_text_caps(VncState *vs)
 {
     uint32_t caps[2];
@@ -341,10 +351,5 @@ void vnc_server_cut_text_caps(VncState *vs)
     caps[1] = 0;
     vnc_clipboard_send(vs, 2, caps);
 
-    if (!vs->cbpeer.notifier.notify) {
-        vs->cbpeer.name = "vnc";
-        vs->cbpeer.notifier.notify = vnc_clipboard_notify;
-        vs->cbpeer.request = vnc_clipboard_request;
-        qemu_clipboard_peer_register(&vs->cbpeer);
-    }
+    vnc_clipboard_peer_register(vs);
 }
diff --git a/ui/vnc.h b/ui/vnc.h
index 88293ef497..d8b0070396 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -636,6 +636,7 @@ int vnc_zywrle_send_framebuffer_update(VncState *vs, VncWorker *worker,
 void vnc_zrle_clear(VncWorker *worker);
 
 /* vnc-clipboard.c */
+void vnc_clipboard_peer_register(VncState *vs);
 void vnc_server_cut_text_caps(VncState *vs);
 void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text);
 void vnc_client_cut_text_ext(VncState *vs, int32_t len, uint32_t flags, uint8_t *data);
-- 
2.43.0


