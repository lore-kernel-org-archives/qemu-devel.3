Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91603CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHinv-0001yR-QO; Fri, 16 Oct 2026 10:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHino-0001xO-WD
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:20:57 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHinm-0006Zp-Pb
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:20:56 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5bUg3246539; Fri, 16 Oct 2026 07:20:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=aNlUrMr9q1rOFXLFDeaeQlVWwE1CMuX+2uDxxeomG
 uY=; b=cspCwhjaLFqhz6/xxAimuMhU2DquKw5pvWid1+BKnVWsw58+DSBeHl4bW
 f5wIxDifGU/kYcwXZ/aPHLdK86eeEh13ZU8XqmAusGUgj9V6mReattEZDDHOVrTL
 ryqzsVQAOOsiuB+yy0DwttdhgjBWevLFVQckbAstW5WN17sKXjzUzSqBf/Ky6xCE
 FUtu9fPqPvzJCF5viImex+dGyXTjxox1SJKWxm47tROSbdMZsZ15ROMq0UjPjpyP
 zChPV/ZTR3RklhcJcbDoYwpaAjD3DyJQW5ETYzvE9SWm6095w8ntrjApfVcKhb6t
 Cqz7d0+mfgRBP/uXNILIc6sz682wQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020087.outbound.protection.outlook.com [52.101.85.87])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4haxj93881-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:20:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKg9riRze/e1HBrgSUtIFXd9PGPb0fVZoy9ddQAVa1mgWnAlRmwLL169NjwpVHAzm6TiI038ew+vPlFYIbzpkX3nEZq05ebMCU9phQfM59lUD2PGPB+mR+ugsPPxw6v7TlXqLMt0+bbeEq5JhAI+xU4Oh6RGsNVNkiXGUxqP/9c7w5Aq06G6gIk37farIy3PU9hGWriUMbJFsn8RitycdSIzlsuPuP/ijRyA1DP1xqPthLSh1+n8720fxvuNfdoKzp8nMJbZOzo5hnehK/mrBXEDn0mtxF/ZVu3M0HEXOCv2N2NdPJC0f+rZ2V3m1Ersdu7FLdbIjdRzvK5HRbXr9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNlUrMr9q1rOFXLFDeaeQlVWwE1CMuX+2uDxxeomGuY=;
 b=pl3RX1U4NzXPjPMqGZ6CPUBMMU4mRfiZuSYrdBxZ7FCMe1CNi2XGTk8NcL7iNh7XRgeBIkyQ3+2gton24Xn/c4L5GQc/cmaxnCHSD/pgKiAR9l+MoMmbV0YcYl97D0j5Q4bHxqiXtReBNSRbXW+SqJCovBDTGoJD4aG2ERcFwpXuTqw/o7A1S15d4kvGck9vub2moqqILYALFE+8dPXV4G/vE/vlc1u6WJR9W7IolnQyBXtYSlAYbA3j1lb5/047Mt0layQGxxqO0A07FAncPOQi3LKiz8AMxB/LxDibT02b2VTGOq0gV+Pp45hFuf2YGglClDd3SZmkyD/d4+g7Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNlUrMr9q1rOFXLFDeaeQlVWwE1CMuX+2uDxxeomGuY=;
 b=tZqiALdlKl1PYPpl8L0SncVWel9SZdUjyf23hU02lwuAokvoENsas1UkdfZAXtFDl+BsFWwfsH5amWw/g1VrBiT+ZTh0nlzO9EYL8gu5OhcAQ7TVu7nwhcCagLPskTs8UcYKNSHmGGCidHaiuYxAlzx86JdhlVum4aQnhUl3egX3Lw5Tf32OyoWtWzGHI9so1CvK4mdsmQ5yGC0sNZ/ckIiPro24vE8xSg/+dv5ECZP1fXQlFocvb6qZYep/gqi/pwknNPmdAkbPBxBqKpvZTgYQjxvPOtRY3pjNH7UGheG6CfMhtiK1kk9HRBdnB3QaEtPM2XDP7hkSR7bRW59pOA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL0PR02MB6547.namprd02.prod.outlook.com (2603:10b6:208:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 14:20:40 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:20:40 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 01/27] i8259_internal.h: rename PIC_COMMON to I8259_COMMON
Date: Fri, 16 Oct 2026 15:19:07 +0100
Message-ID: <20261016142031.1204281-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL0PR02MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2b74c7-6b7b-4797-8765-08df2b90a7a5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|10067099003|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: vfuCGe7BHX2GPWG/Ox6careXF/FNvKLZreqbXiJeILS74sDTj77U3wTgJ4P6pi1uq/R94d2xJl2PM/BhtPxRR4DT4T9vBqWV4BrUNaPH+4nVkyDX/Rxnh4FPBrfcPWT3J1HSo2IlygixRC2Am2rbEEPvL44mhKOjoM8gOLPpbDVM9MN9kUzCos3afyybF2oPfJMvJF2h7eRFdUyz/jPIGkqbMs84Dyh8GOiIBCMqAy5/ZFDTPnKbT+jX4x020FNyIrPmfuaCGr4QJTDJpaOPcWpA+rtlD5AHcbWB7VNXPsApBGDxXpjqZF9lYidSBuKXlPGK+eHf+KIsz+hJLTsLgz0pqxF4XhWwCznYsVOYk2VFhEgKFqwRq5QZh1tc8gebShU5E4+o4qb+X5JaB34uWtf3MOLj5fFtJISh4ojKbnl4papmJXNmVVosJnZueUJuZv6fBf0rk4V+f0KRppZfyKw5G2vtQMIpDhAW0boWZqrj9mtTp2mVSwIx1UkINPAvcsAsdsLrmPx5KV385Ud8YhYIFQ54S1HKrxsVyyiusRKI/rraATky3RUufWS61HHUkjtih3/kjPea7E7rf1LETxj42d6EYvKQMqIbYPq7jrT0lAB1pjOQDbv5PQi6tZuPe0v2WojFQ3MEMWuZTaanrxFdZgFJh7i2TCTDkT87BsA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(10067099003)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ZBg7NQxZFKeX/f+MimcRRmKqVXAxHCrK8eslK7WdXYSIMKTNXfIxBr+B2XG?=
 =?us-ascii?Q?4G+hA/0SlKxBqfBo4c6ufLPwzWjHU50CUSPbFh3bAT0pAB/DbrKgQqL9Y3mZ?=
 =?us-ascii?Q?GPkbhgPcCig0ClFLPR7qwmnQpptkIdRcwP7C78+Lwa994wuUjiXoK/KwVqGX?=
 =?us-ascii?Q?5DCrfLAzNXhUa9OfmFInOSrbxzVQEqBF87kZYdzkUpBAj4GaxoHMg59b4Dzu?=
 =?us-ascii?Q?0jxzW/pv/nVmzkHax/MVoHYcTEQ21G+uWSxNZRkxwqqLwTGfObX9/nFSWywb?=
 =?us-ascii?Q?pf6Hv7zII4KX2KaFXN9M5PBKdFoNANun9ZJHDNtEi++eahEeGStBdKEL0HvP?=
 =?us-ascii?Q?5ZL+Oo1HZEgf5ENc60Xt1FB7gu6zu9jv20bezwv+V4Y8M6gq/mJE9zMtzlXj?=
 =?us-ascii?Q?UjFeL7iIG1c0JQSqwG0OIpTi1yQfC7barIQP6FkP5r5gvh9N/VKOUVEzvnVa?=
 =?us-ascii?Q?lxuOve8y2S75EocVdd2wpLYNwRfrMv1nTbuLJ1fubFiUTagJR/9c/S7e0qUS?=
 =?us-ascii?Q?gs6Ddpk8WF0Pi9eB+o2DyfojipN7TfINFfqZjYNKkLgiEebs6MdYxdhYl8oh?=
 =?us-ascii?Q?ExFfFEMKFmrvSd5xf2sUp4kKYSqHhsk4cfNsNerd66o2167WzNzwqnGAGBtu?=
 =?us-ascii?Q?HuL7mr9FEbOBDDOYRq7VbtSuwb4V/jZHw1qVGxndsyc/mssG6P5iL0lamse4?=
 =?us-ascii?Q?KRYiXC1TxmsNX1zu4F03I8Rjh390ALfvAXLG+g9Ss4LvyhGr53eMu3GP1act?=
 =?us-ascii?Q?2ukmHOAW1heQRtbj/2/STNKLDsbIc/kYkGETwVlGNmUuFxDiZimn6wJjs999?=
 =?us-ascii?Q?br08/9bOA1H0pTrTAjHP5pzT0FPh28BVWlx4tYJKzceaEenG1eA0RAXmhEB6?=
 =?us-ascii?Q?aQFrkMxTu1ayfH2L0MxFXBAJcAEXV3owcGQNpOkBvxH0KmHu8dGWKP8fT6uP?=
 =?us-ascii?Q?XuI90HRX32VBq9HZrOEBA+TP+cIuijHak72kt9jUpBtNX5azeOMRdTEajgid?=
 =?us-ascii?Q?YNA+9LNL4tg3qNk0oM/3ney0ctGm+tcLUalXB8XRXeAFxyCNmApZOk6y4+xE?=
 =?us-ascii?Q?omBTmBwjgiia+vWLd0FN9+mcAvcHEnfpxiHL+MqNwUjmTXivZGOcy0LrS0VT?=
 =?us-ascii?Q?N8F3hEo/yyNscnL5DKU/wWfekFFXpEulQCGXfSWuFfViSNPIWgwAF2oW8WLM?=
 =?us-ascii?Q?T1u6pWvhXWEnwSNX2E0caNUCI0izPpfIjJhaUgQmqVfgVVLL0mAGsUAzxRtV?=
 =?us-ascii?Q?YvyGLnXTxMFGSjmH07O/0ajcoO51hNjWtVG+SUnxOcFdN3eCPqVekscj260E?=
 =?us-ascii?Q?UxuMr41FkV5FDrBHhWo+alMGG/C95FAlJpuEDsxkvQLrMu/YJmvArsD4geUG?=
 =?us-ascii?Q?y2pE85Y0x2OPs6Ir8hIxkAPhPRzci5euzbVtMX1BkrLp+i8xLTrxGXyeiJN4?=
 =?us-ascii?Q?gK9iXHZNPDamwEsd+pxu0tO9O75Mz+kJ59z5hpEiZr4XgGg4w/v5ZiHZs7fO?=
 =?us-ascii?Q?yROGjh7rKfJunNCYGrYllLgEb4iqg9VJODOfXdsSWKW0Ys1Cn9pPC9uo65zr?=
 =?us-ascii?Q?TkLMtlLC8Yx4/1i7mJCEMvWXpTTpKvP+6cxP/IV8m0zDq2RVNVCjr39eZLHo?=
 =?us-ascii?Q?aFCv2cJXpO/pc9ffBO8aRwqWNYJ9iBCwdwbJ4FEyXdghaukH7gcNMVz066ax?=
 =?us-ascii?Q?RqzxPEhuB7novliBiDKQhD/U57Bt1orOj2TnnM+QBj6kCSuZk5uHwW3xlmsn?=
 =?us-ascii?Q?M9c08PHhwZ47/O9nRRtJU2aZxUb1WuY=3D?=
X-Exchange-RoutingPolicyChecked: WSG3TYjVdEmmWTJ4d+MgH4+Z41dH2oYJW2YCZgJCmMpoDJke9mv7orU4XaEWvkDnlK0jx1biO50Az1FC2qgjy8eDJWu/Xbp6H6dKdB1eNT5NZ+NLpCTK4MIqkq+fGkT/NGU18xkMcgfM6gob+8aocNiyaiU5ENnLOgN3bWihs3VyR1qTOQurqI6T5UF5YIptw7KwIfEjGI10I6qjACQoj6E+TbVj/9zyLKtV86AwSewBQLQz5qQM2NQpvzvnZTnzywlplYHIyZ2NgeK8QOf5z1r+c1S8ke2vTnfOmlp9/GWBjxzTBY6hotTZs0uTzxhwdGsU+WNba0/Mc5bIBbDWLg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2b74c7-6b7b-4797-8765-08df2b90a7a5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:20:40.1628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87vnX4P5E9ZHpkBOg/bt9LTvqWW1r6NJY7y4RDFz0MuogB4ecP5XBwmLcVM7GlyY243LZhGyRo3o1996wezQoE2fsdA00qAufLLpXez3VJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6547
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfXz14ILCBC0BDl
 QtqMrpaRK8JlXty0pi9Of2Eud92rUobb2RruQEe+3L3h7vmiWojRv89zxaJsXEpeVahhUQfk289
 zSI28DK0k15rdk3q/HbfyqjN1djBgO4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX8SxS9mCvK/FW
 hwBm1yZV38vTJR1xfG8g5hC2T9j+FIwvfkvUfFDH9KpZ6pdEEMpgcQamlp2x7e6IL2nTZnYshLk
 AdDjT+V77BvgTKC5Gk5yXEsgu4s/iDBLjh3+CZJbDDujeTduhxb2JC9aXnMutcMOhhgdkTnbFWr
 OgBsdjRaIP95TFJ/cnzf5HE8Eti3sl1ISCbWL0MvRftomBfaf0+eVZmLETSC5CDzLeJ/tHf5hEB
 IaBzPyvVvOJ4sgqoBdctqGUoJ0ZoKsDqqY14R/yT/UZCuwyOHwy2kVLIJZhtCgGG3DHUp2lli3g
 ht2a6/aMdrvdcMw4UsaHPltdRgAdgcQfsLuHfvt+Olrcq+aa9HHTq5tOeLzksH1EBaciJFpvTXI
 iYQhgbVjyfDoH5uY8drlAFtQp58Hnay6f8hNORWWywJvHviRBw+nKUgB4ydHYe8GeWFQZKrnjiG
 TVe09CMEoxhTzefhdUA==
X-Proofpoint-ORIG-GUID: -MtB3VpxVJhtokg3paSY1HZSGp3V410e
X-Authority-Analysis: v=2.4 cv=ItOL47/g c=1 sm=1 tr=0 ts=6ad232b9 cx=c_pps
 a=R61xy7Sxgg6fOHg0EL+J9A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=XF9Y1ugsmyLceZbb4BIA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -MtB3VpxVJhtokg3paSY1HZSGp3V410e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

This is to emphasise that child types of PIC_COMMON are all instances of an
an 8259 PIC.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/isa/i8259_internal.h |  4 ++--
 hw/i386/kvm/i8259.c             |  8 ++++----
 hw/intc/i8259.c                 | 10 +++++-----
 hw/intc/i8259_common.c          | 14 +++++++-------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index f9dcc4163e..54dc9036cf 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -31,8 +31,8 @@
 #include "qom/object.h"
 
 
-#define TYPE_PIC_COMMON "pic-common"
-OBJECT_DECLARE_TYPE(PICCommonState, PICCommonClass, PIC_COMMON)
+#define TYPE_I8259_COMMON "pic-common"
+OBJECT_DECLARE_TYPE(PICCommonState, PICCommonClass, I8259_COMMON)
 
 struct PICCommonClass {
     DeviceClass parent_class;
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 66f37e1303..14029783e5 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -103,7 +103,7 @@ static void kvm_pic_put(PICCommonState *s)
 
 static void kvm_pic_reset(DeviceState *dev)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
 
     s->elcr = 0;
     pic_reset_common(s);
@@ -122,7 +122,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
 
 static void kvm_pic_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
     KVMPICClass *kpc = KVM_PIC_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(dev), NULL, NULL, "kvm-pic", 2);
@@ -142,7 +142,7 @@ qemu_irq *kvm_i8259_init(ISABus *bus)
 static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 {
     KVMPICClass *kpc = KVM_PIC_CLASS(klass);
-    PICCommonClass *k = PIC_COMMON_CLASS(klass);
+    PICCommonClass *k = I8259_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, kvm_pic_reset);
@@ -153,7 +153,7 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo kvm_i8259_info = {
     .name = TYPE_KVM_I8259,
-    .parent = TYPE_PIC_COMMON,
+    .parent = TYPE_I8259_COMMON,
     .instance_size = sizeof(PICCommonState),
     .class_init = kvm_i8259_class_init,
     .class_size = sizeof(KVMPICClass),
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 8f2aa1f0fb..52e24d333e 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -218,7 +218,7 @@ static void pic_init_reset(PICCommonState *s)
 
 static void pic_reset(DeviceState *dev)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
 
     s->elcr = 0;
     s->ltim = 0;
@@ -387,7 +387,7 @@ static const MemoryRegionOps pic_elcr_ioport_ops = {
 
 static void pic_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
     PICClass *pc = PIC_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(s), &pic_base_ioport_ops, s,
@@ -418,7 +418,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
         irq_set[i] = qdev_get_gpio_in(dev, i);
     }
 
-    isa_pic = PIC_COMMON(dev);
+    isa_pic = I8259_COMMON(dev);
 
     isadev = i8259_init_chip(TYPE_I8259, bus, false);
     dev = DEVICE(isadev);
@@ -428,7 +428,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
         irq_set[i + 8] = qdev_get_gpio_in(dev, i);
     }
 
-    slave_pic = PIC_COMMON(dev);
+    slave_pic = I8259_COMMON(dev);
 
     return irq_set;
 }
@@ -445,7 +445,7 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo i8259_info = {
     .name       = TYPE_I8259,
     .instance_size = sizeof(PICCommonState),
-    .parent     = TYPE_PIC_COMMON,
+    .parent     = TYPE_I8259_COMMON,
     .class_init = i8259_class_init,
     .class_size = sizeof(PICClass),
 };
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 8ceb5841b9..e2f997e161 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -56,7 +56,7 @@ void pic_reset_common(PICCommonState *s)
 static int pic_dispatch_pre_save(void *opaque)
 {
     PICCommonState *s = opaque;
-    PICCommonClass *info = PIC_COMMON_GET_CLASS(s);
+    PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->pre_save) {
         info->pre_save(s);
@@ -68,7 +68,7 @@ static int pic_dispatch_pre_save(void *opaque)
 static int pic_dispatch_post_load(void *opaque, int version_id)
 {
     PICCommonState *s = opaque;
-    PICCommonClass *info = PIC_COMMON_GET_CLASS(s);
+    PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->post_load) {
         info->post_load(s);
@@ -78,7 +78,7 @@ static int pic_dispatch_post_load(void *opaque, int version_id)
 
 static void pic_common_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
     ISADevice *isa = ISA_DEVICE(dev);
 
     isa_register_ioport(isa, &s->base_io, s->iobase);
@@ -118,7 +118,7 @@ void pic_stat_update_irq(int irq, int level)
 static bool pic_get_statistics(InterruptStatsProvider *obj,
                                uint64_t **irq_counts, unsigned int *nb_irqs)
 {
-    PICCommonState *s = PIC_COMMON(obj);
+    PICCommonState *s = I8259_COMMON(obj);
 
     if (s->master) {
         *irq_counts = irq_count;
@@ -133,7 +133,7 @@ static bool pic_get_statistics(InterruptStatsProvider *obj,
 
 static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
-    PICCommonState *s = PIC_COMMON(obj);
+    PICCommonState *s = I8259_COMMON(obj);
 
     pic_dispatch_pre_save(s);
     g_string_append_printf(buf, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
@@ -146,7 +146,7 @@ static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 
 static bool ltim_state_needed(void *opaque)
 {
-    PICCommonState *s = PIC_COMMON(opaque);
+    PICCommonState *s = I8259_COMMON(opaque);
 
     return !!s->ltim;
 }
@@ -220,7 +220,7 @@ static void pic_common_class_init(ObjectClass *klass, const void *data)
 }
 
 static const TypeInfo pic_common_type = {
-    .name = TYPE_PIC_COMMON,
+    .name = TYPE_I8259_COMMON,
     .parent = TYPE_ISA_DEVICE,
     .instance_size = sizeof(PICCommonState),
     .class_size = sizeof(PICCommonClass),
-- 
2.43.0


