Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73852C982C5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n8f-0000pm-Kj; Wed, 16 Sep 2026 06:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8S-00007L-PG
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:06 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8Q-0002mU-M8
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:04 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G8q4Uc541814; Wed, 16 Sep 2026 03:44:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=/JiDjhK9ihDCRHHsJrq/x8B2es8Is22hCKPznDosI
 PI=; b=2G8M55Xbdeso9Lyaz/tF/PHCTQMqBf2xkG8nok1Ef+2h9zJcittzfqr7t
 mcGMauXPWiFcMgudgYQKNvQe3rrW+1ZSTAiOL6WKTIhfn+jmsRGNNaS9BbJrkk+j
 x0h3VR2NKkL21PZtkgO2kASUf3Tph8S/D+UEQayTUsfH0oo0vWu9GI63UhQjXSTo
 yS1aT2Y8jSYIbu4k32Z2xqPSrNWMT3R1ZRNWnoH6zMTGjHQ/j3OjJeFFieY1yT01
 9CQw91hkbBQWWHm4BEzpN2nOv/YCkA35PZkjLTulSZ+Vt8/WjuTX/EFzCxtGjL0p
 CKZresKeYd8/WeJvSHOtWbs4UuxAQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020103.outbound.protection.outlook.com [52.101.56.103])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gqa0pt9xw-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 03:44:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFeHadgar+P43tvQV9tE/xFb3ai4EpiLCUeJWsibWtsk22gG4x+YYkaZYAx2pnYeqsPH+PMk+6GZ6oeydPQcBLw4rhroL3Sut+liZ5RggEg3VJXB3zi7jpS0A+J9qGQaGbzawdUHoIWOoOSJK5nkIfRWkmvtYFs8TuZtBdVQZMvNHXC/P5AHLWTiqPZSdzmtv5sWZbONkISGLSo2dxgqbwA0yttFbQFybQNqSB86vk+zKdRKxvXB508BCF+Z3OdYRzmIhZ64u5IqaQ5wICI5kaySFogIiDii1BLqG95k0ylu7R4nyupvoz6CWvgbeO5wDV8qoQ2B7SFeNgRw8NCSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JiDjhK9ihDCRHHsJrq/x8B2es8Is22hCKPznDosIPI=;
 b=CTyNfM0rxldafRJAYw3lpAYGajwteKkYjWCP3SEDaRdwjBebriMfXb+nK1fg65nZI3E9ikZzTkxiSZNm3buLZsNt90/xvccvQjAeKw9dPe2mzw50gAm+oUGi6DWLP3uqzsJ2pE4jUVkt+vt7tVftqpA7WU1qCNLcq/zbXGCVYeb3NZeNrWksB3k4/Pyqrj50tneb6wBHoI6SKgDmgxn67vsHo3E7oATXhyx3L9B3sSHY74SrF7i1cAsgkOmQAAevX3/ib7KtTHbAe7Mqay8mbbLR8Pg0eaVM3J8nVtIkXY4yPpeYHIWZJdpNvCztJ3KcSaDq8Rk8Xhtb1OJwQ8Li2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JiDjhK9ihDCRHHsJrq/x8B2es8Is22hCKPznDosIPI=;
 b=dRoIrO7O5EuJa7Hg5Ee7wz+vzL1yU6KhT3VCTShpSfE4uiB7yJ0Ifnmdqr6OGTTsyTVKnYjl46OBcfoRbRFXtdyjUqenZ1qnjaj2HXl6rzOFTnqkwNDIDP8exAnCaAwxDuUTRulDzv4TMEEJ9M+QD8X0Bpe/QU7RNu+dkhpZM/IbppyGAbnXME7Ej1Ebv+Tzom0AIOqC5OYYS19zk69bLvXqTU4x4z75V8lq6+SIFSAlN0OEoArn7CYMWXhGtewj2JX+jP0fAexS2CBYc5xAOWcHoYyCtK0p1dam2FeXU/uQC8+CWG1Nh/YURqZhVwUCAvM0iTt73Rlmb2coGgz1OQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MW4PR02MB7380.namprd02.prod.outlook.com (2603:10b6:303:74::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 10:44:53 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:44:53 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH 04/22] i8259_internal.h: rename PICCommonClass to
 I8259CommonClass
Date: Wed, 16 Sep 2026 11:43:32 +0100
Message-ID: <20260916104435.600211-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916104435.600211-1-mark.caveayland@nutanix.com>
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0172.namprd05.prod.outlook.com
 (2603:10b6:a03:339::27) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MW4PR02MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 253c477a-c126-49ae-400c-08df13df8a36
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 9H+ghNKnwKDFH7EdiIysRAASGEH6ET+us2KM5JNcprZM6LUgkH5cGE/7iXOi+nqSseBgAcEp94BQoOBd3mEYQBAw7lCg77EDkj5/hWg3dMYlBrD3yUyuWNlBG+ZkPU3E7vUM7YPctwha+z9z2WZA09tzo3KrY0hgUCri9J68TLOBIx/Awc8V4EMDZ9B31p6cy1gLSuxT3WAj4q7wEOBVaDCjKa6rof46MYErzNpd4p2K/sWaYIfo2y7uXtC/lSPup2ks4zZD0K1pNI2PoNRHfWiqkCN4IaX5LXuARNLTBROe9w9yW5AUlG3pQudCjE1RHuV36hhj9noza5YI3VYytYH/dFrV9oYiUUrZI66O9JOowDvc0fGOuxqSFcQNntHDJjnZe/qahBaofQUXK81baXStdSqOQe+IWsk0MMNiuH0C2QzWmjqftUBHIfuRLvSa6N5Cr2u9+2i1Ogmjq1jyRy4lE9+9LlR5Snh8fuf8IjtPPAgugIrGSjteKXVUTQLAKBO6UyuvmhUeCxh+f/tgeg6liceDNoX4VB+oSXXM317WnK8IXlDNUy1s4y0sUpxf5PVtpPlNBTiEWHPUTUhdqNP+UdhVlreQNtov4NIiuFjZ+3o4e+qXtKYWWTEQi3Z0885XpE/QDlW3HZgnXKGe5ruCCYzr5lqEds95uxm5d+0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Y6aHUZhj4ZcKESIabf8UQPM3yBnXRPfyNlgjdfxCH8lDRbRV8QuT2XgOWjf?=
 =?us-ascii?Q?H7JL5H7gxOp4WI/265vIpJAiV06O2HZJhkftfbaPu9p94WAU7Het/Tq/NRZn?=
 =?us-ascii?Q?flXlCmgeBH+asbA4Trz7V1eqAIOdpj3T8sda1VZUvSb2Nmp3SZXatQWCKG6v?=
 =?us-ascii?Q?uWNG0Ggsgb0vLHt9c7UQBkGXuYfsRKVm7adWS8Bk8yrd8K0uis803yRml3i+?=
 =?us-ascii?Q?MZk/F0REnx3Epo53JGsoAmjMoXZV+7ZlQoNWJ3Vft8ZeO2HVSLNQGwLUGrMA?=
 =?us-ascii?Q?1pqChdliLO8ovXa2suRrU2iZwt9iy3VPuamlNqbB8CbcF62VsDXT8TtQnvDw?=
 =?us-ascii?Q?beCusrVC8HM9gTKawZ/2p6/aHo/wBHJb4kgkgFheqmWecB+EgRLLthd0H0Ms?=
 =?us-ascii?Q?hVPF3V+bE3dEoBMCAbWOItJa4inEI17aP5x102/5oWcQU6RoBitYdFHgxtHP?=
 =?us-ascii?Q?MJjwQl9FmHsQW7TyseSlWm3sOTX9IflF3+YSrGL64065aIVjkFJwTUFg2QCU?=
 =?us-ascii?Q?nh4w4QnX0/V+XHG/9tmE2TslGek8ftUfCau9sdgw+nJQYfif0CXcae5etmuP?=
 =?us-ascii?Q?pSYhh+06Sxczk4uAKZZnw+P0X1HhPVYenA2czgjIE9cwShXVltYcYQUf1MwY?=
 =?us-ascii?Q?h5YQQCRpI9USK2TO7WsyvuC5kJ8OflRItrw8NKV+TqrZyXDRhBu5bmZpUBry?=
 =?us-ascii?Q?8Adq6MZi84+XKC0uEN/50S80mgbVYzuyHAdykGDWxSJGcm3/aex5CPkM99M0?=
 =?us-ascii?Q?/dHvrn9Q3obzCdvkIs0roF1sGseKjxJAEYBcy7lsQ2Cn0JuJAGxGNEzbl38k?=
 =?us-ascii?Q?gpZKlSAZfz5ifnQLxe8hBF9k0Z9uZHUF0iS+1AneujNnDLN9IYd5HTPztNY8?=
 =?us-ascii?Q?9biQZg4GAg/zwuLi1N9fjLo0bEXUz74kmqJ8MDKWflSgmEranMy4JKAyhlsZ?=
 =?us-ascii?Q?G/rngIPm+q+fok18WHCY6kamOMEUR6wVwGBpgXO/4WCQlIOKk6yeWevk47AE?=
 =?us-ascii?Q?szuTRb1LexEKma15mASW520xF4AJzo2fmsz/pawdr6n8GkIa2E+sOmnMpBfo?=
 =?us-ascii?Q?EXJ3nUQDlFho5ViHQ+eu0NdnL1PE+KHvjJReVD4BTJNwtChzGWdnHnOUS2Ep?=
 =?us-ascii?Q?34sH1WxKD0HVZFReJ+SG9xMLsYNXFUc2clP32ByJuIFawBS1LbIinNZnfFyu?=
 =?us-ascii?Q?XqoHbxgHHAWIywkcRBiBLJhJ/PFs++Wvgg6RqpA+Mdq9s4AGcr1G4d0usYQ7?=
 =?us-ascii?Q?frKgH8CokLXWv71xVsw/Eau3Vonln6jHhJMV6GmdClYprp/lQFPckaQ+iXxe?=
 =?us-ascii?Q?pAL8uFepLOvIQ0B8zRHPEjzvp4kAAA4/N81tTMuDz8O4dKXUhuXgmWGye9RT?=
 =?us-ascii?Q?C7sYAI4S5cDLRbXmdIcd8e5c5vJlhenXj9JApXOT8NBqStALpyVpB1OJnEAm?=
 =?us-ascii?Q?mh+ePKPiseq4UdrfGPKc4jgLFOPMpzb3cA5UaDeQGFQTehljCYFzg9cuNr9l?=
 =?us-ascii?Q?PdertWQl/3krp/EHYsnsFeixSx26IrZElCl4K8zJZaJOqccrCcw0VVrz+UdQ?=
 =?us-ascii?Q?OCjfkrbcXh2soKFylY46FgiZec2BaFmXwUDXzhX3V5AR1PNCVi4IptfaX4vo?=
 =?us-ascii?Q?NqqV4+CS5OWv55E8JSmOAVj+dxETFYeoKAdaj42s+vr9zkDUVOe7kZxN6FMk?=
 =?us-ascii?Q?+bgNwQUsCKTVZwP/zoOzeJiPA9tfDe4MUVKgBX4c5qboJVTRcHJizc02C9Cl?=
 =?us-ascii?Q?DyI9sPRzaJwgwzVBJX02CUCd+FePdak=3D?=
X-Exchange-RoutingPolicyChecked: u2MfnjxmuHq21fyYdaEZAZhzlTRIFc4XsQYS329QN0AmMIOTFNlRVee/I2gtT+Ih/aYZiBgASMQKHKduUtYM70DH/KJKvD6o+Mm4QnkRKjRTJCBt0Te+REJyBisvm078VK4zPORi7JNOyZkRJPMYSOVKToOTIPIH+pEGEYgQCKhVXCG2hWKIEUlt5/lUwSvdN6VMXqjd7XfAdZlwTkBgN84LEYvBvl/gD/N7ygLNOBiOrWHYx3RMDZziNOMLZ8OyBRM/QTZfE7bOcmnLVCrpnlLnfm+sAqQihve0inT/r66yNzsDBHJTT9GuWaqw2AzYgbDLmpaeXuzmbZg38xHElQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253c477a-c126-49ae-400c-08df13df8a36
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:44:52.9570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szo+oyR6Z42Cub15A6V3HoL5abKwWCnUUMV/urC53LXJSk4NZdBteyR346SW+jrCLNTEBqlVQ4rCQUGlc225SquDX43JGbU3IoE8ldMmRSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7380
X-Proofpoint-GUID: 6QG87q_fHnRmciYURCiYzuxU4ytyhHfa
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfXzD0hUIVFxmFS
 e2wMDX8/qZmRMSlktjwNtT2ZKNax+aqlFtpmhYXdj0vb6B1g7bNtVaogTac/Iu0D5Jlxt4N3uqY
 HJE/WK8gndrngs3T/mr+LkttGMeaD/o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX6lmGkHivmc+O
 SIfzKS6onzYc37akVMtRkp+0B7NG7Atj7GBPTSRx2cKzmq1Tz8keGbpOkDjKdkRwAMviKgnDWG0
 jK5Dyxt0vv3Z0OXtplVBXMhSiuf6PigSiv8CJdB68beC2a0PB/z/e7E6l/s8ApG5qjn0C1LWTTw
 uG8uuEWgO6N4Lwz7iIqkVWGuXfUlk05ql/ZvJhlUXcsujd86rJ3S31dyF8+icVQg1BWBVNFaIxa
 VcnHxdN6r3qhZ3VjBm5lbHMD841wFrPxpGbHKQRkzaKLia6SkNtMyciR5aLTf8oPnU2gZpKuJQt
 o9A+xhK51N7UZndnhAYW1I1dywA2y19kZYkdOuOaPbJ7SF9fSc8yTQvYsBmd+3T4CjPZrtsebRS
 EFwKoh/BTLwO+hPoBus/8/dBQSIBMxuogNk07wu3vVz8NOJenrAJDFze/sButiOF2YnUOXr3zfU
 t1WySzR4464WZ0EDy1Q==
X-Proofpoint-ORIG-GUID: 6QG87q_fHnRmciYURCiYzuxU4ytyhHfa
X-Authority-Analysis: v=2.4 cv=Ps4G/AM3 c=1 sm=1 tr=0 ts=6aaa7327 cx=c_pps
 a=WPXs+xwE9Zb4LCNJX07eKw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=qh9Ixq9Ib_qUO60TQ2wA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/isa/i8259_internal.h | 4 ++--
 hw/i386/kvm/i8259.c             | 4 ++--
 hw/intc/i8259.c                 | 2 +-
 hw/intc/i8259_common.c          | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 7a2f9addaf..e039d6f067 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -32,9 +32,9 @@
 
 
 #define TYPE_I8259_COMMON "i8259-common"
-OBJECT_DECLARE_TYPE(I8259CommonState, PICCommonClass, I8259_COMMON)
+OBJECT_DECLARE_TYPE(I8259CommonState, I8259CommonClass, I8259_COMMON)
 
-struct PICCommonClass {
+struct I8259CommonClass {
     DeviceClass parent_class;
 
     void (*pre_save)(I8259CommonState *s);
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index f10643a120..68607d721d 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -29,7 +29,7 @@ DECLARE_CLASS_CHECKERS(KVMPICClass, KVM_PIC,
  * @parent_realize: The parent's realizefn.
  */
 struct KVMPICClass {
-    PICCommonClass parent_class;
+    I8259CommonClass parent_class;
 
     DeviceRealize parent_realize;
 };
@@ -142,7 +142,7 @@ qemu_irq *kvm_i8259_init(ISABus *bus)
 static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 {
     KVMPICClass *kpc = KVM_PIC_CLASS(klass);
-    PICCommonClass *k = I8259_COMMON_CLASS(klass);
+    I8259CommonClass *k = I8259_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, kvm_pic_reset);
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 45db87a2ad..547e86c5f4 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -44,7 +44,7 @@ DECLARE_CLASS_CHECKERS(PICClass, PIC,
  * @parent_realize: The parent's realizefn.
  */
 struct PICClass {
-    PICCommonClass parent_class;
+    I8259CommonClass parent_class;
 
     DeviceRealize parent_realize;
 };
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 17040bdb1e..ac8dc7cf00 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -56,7 +56,7 @@ void pic_reset_common(I8259CommonState *s)
 static int pic_dispatch_pre_save(void *opaque)
 {
     I8259CommonState *s = opaque;
-    PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
+    I8259CommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->pre_save) {
         info->pre_save(s);
@@ -68,7 +68,7 @@ static int pic_dispatch_pre_save(void *opaque)
 static int pic_dispatch_post_load(void *opaque, int version_id)
 {
     I8259CommonState *s = opaque;
-    PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
+    I8259CommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->post_load) {
         info->post_load(s);
@@ -223,7 +223,7 @@ static const TypeInfo pic_common_type = {
     .name = TYPE_I8259_COMMON,
     .parent = TYPE_ISA_DEVICE,
     .instance_size = sizeof(I8259CommonState),
-    .class_size = sizeof(PICCommonClass),
+    .class_size = sizeof(I8259CommonClass),
     .class_init = pic_common_class_init,
     .abstract = true,
     .interfaces = (const InterfaceInfo[]) {
-- 
2.43.0


