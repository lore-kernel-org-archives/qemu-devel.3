Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B581CCCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm8N-0000nu-OS; Mon, 19 Oct 2026 08:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8F-0000e6-L6
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:24 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8D-00047t-Te
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:23 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JBnE5U3621301; Mon, 19 Oct 2026 05:06:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=4Zzg/I05mP5n7TY2uFK7TpWDkHes0ZRgUzLc2R50k
 64=; b=igoqW8cbhcOcdA7/h3RrrXtLsjxYfoIEStiUn0bRSojVhsqACvmkZn4xs
 a4V98fHsfxvnt9gvtBNMDG9YA8mMC/3AoGbiF43dzExfp0jB5msxQhshl1IwWGvo
 H35IW9qxS+7fPBd+kIDUpBmQ2had5fP4+5CNGAbjfZfvqVc8GIOxY5yzC/eH1sU8
 AhTd+Di6oB+Zdqmu/ZIWZgyRqNDo3nf7mMkJS+t4EKMKWqnsKaPSv3Fm66s41xPE
 9wYCPMiO/2azbFHpGwYfsljRNOulyIV0THMXwZLvVD/IngVGrFsykxod8U15iIrz
 86ZZ+juWijzP1Fa7qfpKpdvi+x2jg==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020133.outbound.protection.outlook.com
 [52.101.193.133])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hdjnwr1g1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btm41jwWjYUZDSNGcz1huZrUT/YQFnvPMxAgGsUy7YMy2265NJ0EqDPmpljGeH2Mw+p+U/X9xvWXdWqOzUTs+UsT4Qx5guQ9nJ46wjYF3/MjHpmCOImIwK/W+D82G8SWaOcZcuoy0tD6JHbX8pv+mQrY08IOTg8VRqGIhKa7iEgOnXNgzQmP1MV/fyhcKmly2V/43S25sqE3+uVgnYqSzqguFS6SMB93gUAdzLuRuQ22Ywu561EQy3zveAAnp4vfp4B0SrbW+fcaBm3AjBPRXoz5rRHvBktXOS57ij2wKWYo7uOZhRUGc6SuSZll5TqKthhUbyNZXDrWmC0+d3q1BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Zzg/I05mP5n7TY2uFK7TpWDkHes0ZRgUzLc2R50k64=;
 b=X9ahRmPQ5rQlbX/b1PuguizskM89hXKb1/jE0eXcchfnRx199dBJto/ybjKpfCCfuY+Y2PhCrCa3W6w947cdi74isg61PaHYc9gGeVgeioQEui0ouVa+EhwVJMMuJvRXti0w+oKYjirneLeuQWwVyJEJ79OlB1bFfLZzWUg783yeBbs7AtecNToSsmX8I7vcUAR10utn4ler3HKeeyKvfqarFGIq8efDwXpkIrP7mPkXqvcNFTm0sszdkdCgfdjeynK1aVbof+LTa80kVaiKQI5WEQ0c/OlFp9UT+oNHA8t+M1OPGwX0qjFConmkDxrppbF7qZ6Fz2PIYZkSL+4ESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Zzg/I05mP5n7TY2uFK7TpWDkHes0ZRgUzLc2R50k64=;
 b=vFa1VIyJ+up/xksJeLKIRS47KJ63tR9l0N6k44hekhovSZy2CxkBKzDGkqi/8NSU/bu17LgXf7e+0fd/aAw8rmnqFA92prBPxZEuQWuO7epCSk9fW/axK7eup85lXX7f+1u4/DpNCnztrHwi3QQG7huRVqrn7SUrD8YKBxFS3AGDHwEzbdbdym541oLXVexUzSc31a8udUYBbX7AaT4FMENVNXNqm7YYtujwBYHVRzKq0IwNdLzA60KAg5UR8NdBEgKa7sfqUNA4nnLH4uDiCQDesZxgbPrU1S5buRc4Qd+yanx/aoHAHKdUOIY/2z20LN6QSBouI/rdPlkfa/+sOA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MWHPR02MB11820.namprd02.prod.outlook.com (2603:10b6:303:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:06:13 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:06:13 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 16/28] i8259.c: convert to use DEFINE_TYPES() macro
Date: Mon, 19 Oct 2026 13:04:48 +0100
Message-ID: <20261019120517.1448687-17-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0026.namprd21.prod.outlook.com
 (2603:10b6:a03:114::36) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MWHPR02MB11820:EE_
X-MS-Office365-Filtering-Correlation-Id: ec832800-bb7e-443f-f7dd-08df2dd95ec1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: srM7CAQsBRQf4jvrcRaKr1qV2/58NfxhtN4cJijSXCf9616Dm+/A127zc6NYODP/r3L6+c+i5OtiVxr0mqyKcc5COIj5UjL6vYmH0ldOdFN5hiAZ+G1N/iuLFEuhY4D155OXeMiLzCYCpbSKd33uLt+o0+pxj9vYHou7//MxJ0qduCu/FxtoFo6tR92srmUPKcJaIvpfeLzuvkc+7UxjkpBojZ/NJ+mMhJr/xJcG/AG+S4dfKAK9HIM1O5QrTQDJPuZSNmJcgqxsr+geV5URpmDItu2jirc2MGL2raHIwr1lQyOAKYDhRE9TShwrWZLDLhX885y0cX/11A4gzUUWizbmE5XByK5oCoG0baagACDmmn/khy1S/Sy0x5E205NP8B5nqgHQVSpvJ7+eIkMEp7SWIDK1QhjEhbAB+ZkKjKUe7tc2xYMY3cGellrJHRmFKNwu4TgV6CV+KoW8Q0B9Qi0yVAEbGfcJudZjZiJPO26zGycgKZkcUuiA/0ND1R/+oHsirJbfM/SQuTNrXRfpSilaG8ZvOuSYZsf6/By/mzN14x15LX0mOoUF4Eu7lR9jElsdBTUNLFHDV1Vj52QHV50PGsoKwTq5d2VFZS2LRlwtIRivB8i3896+yXD5nxkmJEU0tcuGWwBODwOzZgkEonOUoNM+G+tu1CCl5OQQOFg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fo7dj0tupf3hwlJ7www9LzYoNM3rzyV1ZbUop0Da4qkEcMKjyG5FXAsLpejG?=
 =?us-ascii?Q?IDxTNfiDA37lnZkKzth1Bxhsj6Ti9IzMO4HccOo3Ebp0YsvYFEJIgaShT+o1?=
 =?us-ascii?Q?0p2nFAVnlB6AB7+5dOv2aRXddnWtI5CXZpnCtVrVzsa4TI0HRtr7H2L+ak7H?=
 =?us-ascii?Q?yJj8vlnJJ/vQ98Nwe7zKSmrz4HWrXCyR2N/1FSFi61f8bPxwPGIkG1NtWKsr?=
 =?us-ascii?Q?8K5ka9u0dUg+5TN2q0znUul0r7PoQD56croBvoDE8uB4zq1757D8SPF0kGHk?=
 =?us-ascii?Q?m3kQhkcZ8A/ua7gSSPSCUOPXARXRJkQQUqXsR4RF7nmS4O5dfp9RRrBZmH0g?=
 =?us-ascii?Q?7xFqspr8eI2X4G41NWTjZCZDOZl6VccXCdjoVc2SEjyD6HYKqqcuUZ862oa2?=
 =?us-ascii?Q?wP67anHc4ePsIBTlR0nmiVrBWOpTlKh2cRT5tpMqtETtJHArVVBSm8C2DV/+?=
 =?us-ascii?Q?/WQzX9FYCpB/1t3JUBWzuQ4d7XbWrNocbgeeA+C/URMdL3+ofzZU9RDXriQk?=
 =?us-ascii?Q?vPVn7zwCH/Aa83JyE2EMr6H7It0JP3trQWr3u9A7d/WWHNPPatMbQIU4a0lG?=
 =?us-ascii?Q?4SouQ2GDe/Rhz46lZ+t/o3PvgHfXOjYQaPLiPBo+mbHCUnXquhblmGp3+hLM?=
 =?us-ascii?Q?wLqoBw+cS9yBiE/CyMqPX3n4FA0j03p/l6LQwohXh5YaR6rC41oJU5qfYNW9?=
 =?us-ascii?Q?am1M9rRnVF6FMWbAyq+8CiqtzfX/yru33O7C4bo2Bh2f3zMbAp9TTufxPGT8?=
 =?us-ascii?Q?z8OFjpPRNXEmChMkmCuDkZQiyW+JPFFPLItC+C8u+e0PLWV2ZQMjjlli7ZPZ?=
 =?us-ascii?Q?uKBh8WsBChRFAo3J4OEFd6oFYfcw2rXdRWROQ1Fbr/xwO9GEGiw+MiCtVEvG?=
 =?us-ascii?Q?aeKgzEpP2CLJwh9b6QG6I/XuJV+rDVlCE6/p4+8rnysL31khwKJw1S9g7qkF?=
 =?us-ascii?Q?i1legNz7ybbSvI2ZWZyctxjS9SxgIoL20aAfbioH0Cq15hT2Nfhz5oTjwe9y?=
 =?us-ascii?Q?lsg1+yq/rNK1/FtbimkDM+LRXt58zcb1fhQUTBw0AAzwXy+RZca5c2UZY9+f?=
 =?us-ascii?Q?HsO9gXXNH6mbH70UPbKFbnXH9+BNyh4pmIClJSfKxN/MwcERSk2J6C55zXZ2?=
 =?us-ascii?Q?Urq0zDpcO/K+JqekKXcAP8hQopOfho5JoXp03+hlGVV5HXSM7uP5lwChW/NJ?=
 =?us-ascii?Q?Fq1nBzd+36h8ereOt9f9IioiIHqLj45XTEpWex3nYfto+imFFNwscln5weY8?=
 =?us-ascii?Q?tAeVN3PfNDmLiGyk0mn/l43LoDvTf3sA68f46/4DkfQmQny2XHzLN86QhcAA?=
 =?us-ascii?Q?/5msfTP8VI3zcQhFumEjz5YgUSmUNPIb1vUisPAecCDz8UEMC3kxPufArRhm?=
 =?us-ascii?Q?hNVTg+pgMFwaR2ZofKcj6eb7gQKXJd0JNUBhy4NH0bwbE4j1bPCbuET5qHHG?=
 =?us-ascii?Q?+QjioCYfsfn0nyBUwZQXOuXUofHoUm9dSvWGquqIlAD+4yxvAIi+hhrx1opj?=
 =?us-ascii?Q?Z92wxa1dgAa9q6aEGC5Z0XD5wMy7ReZ93eqFfetig3yCJNzvkF40DHagB7HN?=
 =?us-ascii?Q?nFdqp4zRsfa41AnVo/n5FThwzGr035rClbw9NkblHs+RqHIVRiLGkbvCOPHm?=
 =?us-ascii?Q?ccpFotbXvXYI2WqG8bJVBJiplplxiASMjHKpFOAJ4gOV2J4wEfNimHxLL08Y?=
 =?us-ascii?Q?93bDDSCBmaaDF5giGV7SY3wtV4baIjjnqjjY6EXAowK7B4Sr7V8pQta4B3vc?=
 =?us-ascii?Q?0uB5TvNJTd3wq8n3iwrs63AeipRfQY8=3D?=
X-Exchange-RoutingPolicyChecked: YWdDHAnbrLY89y3Z7cMCXIDlJifFNOiS9FFFph2mhgdKQ8d9rxXjFByYFkEYZP6xbgkt4r4R7xikQk4yAQHv4OvVYzSQ7CdR/UnoQ1aX9ty6MRYHIhiVvG7uXnIV44h9a+oEltl67fUuFWheiDZfH6Yby1Kqx2XoH9XMzlvzxN3m1PDDXkD6Rn4dmWof/xv5YDK0liq3DnUOtGxWzQyLulPQE5ZqliUrqtLS26sV1SIhZxvQIqWhGTCO9ryzWi0SOySYeIqq5aXGMHLsYpNiK/+bb7L4Rg6PY4pW4ye/n1uJb2JVD2v+FWsrIjWuBTr6q5XC5eyQindaG6IMNJZThA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec832800-bb7e-443f-f7dd-08df2dd95ec1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:06:13.1905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0JwntP+S9FOzPoxpidpGuIaEzb+bO9DJ77lQAkQCmWXvSKw7Lw34nMFuBUVy9+YYiY5rnmDlqjP9DRb/NMbQx4Dxhxonw17oTfz7wyWh2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB11820
X-Authority-Analysis: v=2.4 cv=fqdJ914f c=1 sm=1 tr=0 ts=6ad607b8 cx=c_pps
 a=OkMMD3sknCYbbSSSOfdz/w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=lKrOaJ4ZLGcPJhkerdAA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: qlM35gZqRfZt8Djvyj-5dkQoP4DXkuz6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfXwPQQZcUfmwN8
 GMsid9qjHnGUcHGd9/tgaCkKP5GQ1FpFWhL0Px3/kJBDMx07EpqdtIM4fPMRa4s3O9DAPa0GiEI
 XiBcvWsP/1SzOwwRd5w2sF9TBL/q6vM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX+Zr+YSbwZgMh
 QR7ywHauQPQgGbHBEx+QwRuzzbJepjEe9r38klRSQWBx3AiyW+/xwXRtBdtZQ8bMCPQ3E/VzKTm
 OgBxpRyW9FI9hcsbTkUDCA3+SR4llh22Ly3GvetE1V5ZpstqKeDnsA2V+M/tnn+xLs+UToADtWr
 YvCVjJEWfkAPc73E5S1vd72lyACG667K2A8zHUAHe+KnURi6GlsLk0cycAkHgDfIPwaUMPLekjd
 U4Attejd+hbewOdanVfNad/9G8c+G5qJslPcjG8v18lppOmvoA4cvQ6mZzs71OgpM2LkLIOd796
 k3hkkhRRbzHcESJqvYhiPZ0kuXq29+NOvM2/TFFzuPS3YEgR1cSBafMT5JvnZFyogJP2on0qCRu
 fJvAF1I7NVLq5sStPUCUxIa2lvoG5s29sXP4SJ2j9v79IAeYKUEmIawlmpDNdKhNwDmTwCwMgbF
 9LXUOp/D4G3Hl6yElXw==
X-Proofpoint-GUID: qlM35gZqRfZt8Djvyj-5dkQoP4DXkuz6
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/i8259.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 4b34e5a649..e5fa0f2e5e 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -447,17 +447,14 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, i8259_reset);
 }
 
-static const TypeInfo i8259_info = {
-    .name       = TYPE_I8259,
-    .instance_size = sizeof(I8259State),
-    .parent     = TYPE_I8259_COMMON,
-    .class_init = i8259_class_init,
-    .class_size = sizeof(I8259Class),
+static const TypeInfo i8259_type_infos[] = {
+    {
+        .name       = TYPE_I8259,
+        .instance_size = sizeof(I8259State),
+        .parent     = TYPE_I8259_COMMON,
+        .class_init = i8259_class_init,
+        .class_size = sizeof(I8259Class),
+    },
 };
 
-static void i8259_register_types(void)
-{
-    type_register_static(&i8259_info);
-}
-
-type_init(i8259_register_types)
+DEFINE_TYPES(i8259_type_infos)
-- 
2.43.0


