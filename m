Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCDB1125851
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0MOP-00028D-9c; Wed, 11 Mar 2026 12:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1w0MOH-00027m-3S
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:26:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1w0MOD-0004Fq-OI
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:26:32 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62BD5fTa011044; Wed, 11 Mar 2026 09:26:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=wcUNdxZwrdu688cEGc9hpcYiJhbKalLp1+9Imcste
 r4=; b=TGW9S/RuOxE/qVlyqe2Wxx7QXGITYJfyjiPgoDco8FL4c9Ir69xLeyU1D
 iycQvAoXT/OaRpzXivDJkKGhL8s84aS6sIq1cKMLKO8RCMFe9c/WbWfTzrr4ZlVm
 FsDA9hUwHOKZ+L+lwj4whLm6aEoZ8qcapuFbM0UaPGG2O/9ocSk+UBdRyFcbytUz
 raL3wmOFa99R5E/s7YPcBain3d54fIZwRIrCH231x4QsKS2qHvcZbH7mshCEPXNv
 6cKQxFLBVeYvXiZI/jjW3JhvsgkhDvOtNkc+yLXnPUGwMBBiK7q3E9+55HYC6Xwp
 T+idnNDytLXyYe5DHwXfOFhMqht5w==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022127.outbound.protection.outlook.com [52.101.53.127])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4cthj545h0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2026 09:26:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bs4+lNfRkNAULLwoTqdAdM3gIcg3rfe9DArNrqnk2DQ2H0UHGnYQKCqkj/bsrdPwC9lHnvCbeRG3oUjbl6uq+35gDR8QkeIuxSSFV04q0hq2BFqllzH8+eymdfmjSLfwJ/O+A/vULWvP5p97bWxVzOWyNGNS4hXHXqOM6AmnXu161DPHYV0hi7nXPBGEVwT5N+xHNZoAjXm+UC9rXzIYAkQB84VCQIpuIJODOqQxdN52c7UvlpifYjqq9tMfZTXXzrghdXCQurXuo9Gkgpdh/JGmCEZ79WOOMT6SwWwjNqXRC2eDkqcK10OPkHC2wDNurK0NcePaGmcRQW/6aI51Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcUNdxZwrdu688cEGc9hpcYiJhbKalLp1+9Imcster4=;
 b=Ser/YK/OjxlW8+mmFMXE4s/plpP+12tOAFtaemn41A6Jl5DLv6KWZJ1FARk1RmHeElG+59js08XEE8Wc4S7pfMrOftCqgYaxpGCXoBoreiBo8n3PoQZ47F4KPkhA2iumpW7a0tSyGqHGsxp4yEwWVERUQSjpqER+Czal1tA96mN8puGtq9lZ/jEjFSjsv37oav/uRlX7yXJzKsY3XyGdj+iUnH+Np9YWq5BO+KV4G6/Y0q7kU6W5cjxkecNYWmhwEow8Kb4P2RX2n6Qg1IKPOkGMsry4qE74NskrUK2VKRX1pr9H//TCLeBzultkpqguyUQAMSEoLcATYwkinH9Feg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcUNdxZwrdu688cEGc9hpcYiJhbKalLp1+9Imcster4=;
 b=V6YAMtkF5EfXFqwPVGy2uF9OnYh6l472PJ+J7MFRLTJ7kuIFshkvVWTp2zQ3dDmacbTNVBBGJoP7yG/1WtRo+yb7G2PxeW1nF9ccBXOX0veGnIUSU2P5HfhRLiDhnMN2mV+VJQh1gYnMvpu/Z5Q+eUDufCAnLqTyNQSCJOuNPGOx8ky3+Z5pePqN9DF5bQUvdIolm1cfPcy7+daU6IJGHuM5WHwPeZkMvl8J5g2JzwuSEc01o3W3ichnpdxUOC+IjQP2mOdnO5IaGChsMpeAwEpcPXVA68tyuOv5tw6FB8AeX5FewyTKP4zSGixEn60dQMX6g5F9t+sOb3lLm4AoGQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV0PR02MB11111.namprd02.prod.outlook.com (2603:10b6:408:334::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 16:26:21 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 16:26:21 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] tests: data: update x86 ACPI tables
Date: Wed, 11 Mar 2026 16:24:29 +0000
Message-ID: <20260311162605.2976339-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311162605.2976339-1-mark.caveayland@nutanix.com>
References: <20260311162605.2976339-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:610:4e::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV0PR02MB11111:EE_
X-MS-Office365-Filtering-Correlation-Id: f2073399-f455-48e6-8bc1-08de7f8aee48
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 6VXCyCudj8nyRlSY29YjxGHsrx97bvREmiu2b4GDuYNgfWDj4c53TO0Gc4X1IbOdQmf1m1xzIE8Rh2sjir/pBeuVI3JdDjZEJt5mcThegSo5fqc5IJXuda83OWPIX/UXcBMIVLRz13bhtEkrX2AHHBWsKWwVLZOwV9rsosxPsPH3xywpa+KzbbBIXZ3x0xpi/NJxQYWB5Brd+TF6CMDQNmmoyUOJKA0rln3J8uW+JBwfzCQErS3n4hcp+zV5YXdJYnnF6CXndg7RIQTzOD3tvsRSBvQyqEjsLUC2oEkcZ55E1lItPRnI1e9v+MlRAtVhkMHSdR1TPbXd5TnNVDhQ7gFZyRFNL7se4gNZ5CRMwrOzpkMP/sS8yXaR0a9d5aL4K1tgRY1D6Bnykm3Y478M+AsFSXSyooKQlx6iQeGmnS9Nw1GT7fp7C1SCfi0KVoifrRm0+ZUUVX2LIsHHmL1BhSzj2QyzrpFvB5T2cZerq2JcVFR/hJKKKS7LumeJsB+kRhZurV+ZR/6sSZFmQcUAawJCCaHtSCVaBsWltVoHDUepq3ZJQisyPknMyt9npy8YiVkfqoj1IuWvhF8/5yCy9Cz433/slD/h0j/L6YNRSjDBo8geD4pqZjcZ9Tw4VBT7tXEeE2v6Ia03G2bFcjAx9TAEhMvql70AI+gApWbPzkR4aPySdkPYlwTLr8McjZ0orr8M4z3pHGKrz1KaW8nQApB6qU3OzWv4I9cT73LwlaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jLkuqheHRTzN2HmxTdas8LVYmG5dUMKs6yN19Ld9m7gGn3xY16eSO847a07A?=
 =?us-ascii?Q?hFDyiF+Yo50IU3Q6UPaDB4uAMMCrSzUi+z12XPTsUYH59ogqAE1RpvHFjtgZ?=
 =?us-ascii?Q?fu1UaVrB7n5QOK6N+xYSNx2ekBxXIiNAUiVPBFWel2W7cQDpARX7/WUcZ5fQ?=
 =?us-ascii?Q?oRXD0dESZ+X4D5WZkOfLOqRKPALogoNg5+LyKKpO2ragOBd5l/yEiT8hZ58r?=
 =?us-ascii?Q?ZiP7z1XIm+1sJtqztUygFLSi+rcNsaHMtdJ8JhtoYTMdYb/pbcnt/bGr5lv/?=
 =?us-ascii?Q?c3RY2Tewe6Uy3HusGV+B10JcpPUlB+oFN3BWX1lsfKBqDf2hlFUhvG7kXmVJ?=
 =?us-ascii?Q?c7kRwuZXehOyjeSudO0uTEsSKt1zSXHs5Cy34g1WToUBxCn//Tgng9k/vt85?=
 =?us-ascii?Q?hpmnUbU56YVHJR4nZPnPEOu/03UAmHqx6bJsO5vtJFetUafnE3e7B5GLLz16?=
 =?us-ascii?Q?Rktb3oCIsyvUD9I1LJLqwaawYY+ZHU2Z3VJQC1Q9gqGXY2hv5hZSwh6XKcIm?=
 =?us-ascii?Q?JP8JVy3GSoYKPU0BXhnYEb8GGO/l0ZHz3H3VoQNnudiAIKR47jJwtlaQJh9e?=
 =?us-ascii?Q?oKScxW4LecCGhUWJ7/TFyLdyYpwJv9M0+i4oJlIlBlvbXKdO+YtvZlSTtxIs?=
 =?us-ascii?Q?nooR7D769YAZeRbuGodj0HnASTTee6aAs9x9ZV+x8v76Q/4KkBZuuIiMjPRT?=
 =?us-ascii?Q?nb5oGCYwKa1faukEme9ce8m0xhsoNzWCY1BsKip/sJfrEF9i3KUdFGNJUAK/?=
 =?us-ascii?Q?biHDdIHjWxibTN872P2vW3QSYMD98XNJDDWmRBHGHq2hr+eQVEgKzCUrCoJJ?=
 =?us-ascii?Q?mEr/RR6QoIO0W79QYxZj6rcazgNFL0aTi6PM8X63kbiG/1rF+WZKN4TFMQ8F?=
 =?us-ascii?Q?KWUMZ+6aWunUstCWB3X8NGjzWyIjII3qXLkMjZiNQWXZKhP+gQNfQIFueOq/?=
 =?us-ascii?Q?yarfMaAJJATmU2R3hqpiPwjm5eKI8uaCVIyIwB2O3jO4wf3vCWL65ECy4yqg?=
 =?us-ascii?Q?SajEfj9bmj5T75pr6DhgA9hrXsBfByD1uyK3rKFGYLVoqzBn3hG92nYFJp+2?=
 =?us-ascii?Q?qNo3cYZ+q+E9Edms9YCa5lKTljXkdJEvYSdyzu8PR/ABFkv4qMXlVW5OLaiD?=
 =?us-ascii?Q?e7fJWTt/G24WKj6FMdFLKTa5xbJzOdV2R1EomE72+d3hH5zltEPT9YWB+3z3?=
 =?us-ascii?Q?/qx1pDtobSBIyi0Zc7CzPWtrOIKuwAiJK7beRWwtPyMUX2cKz3rC0mtol3Ts?=
 =?us-ascii?Q?WIYZDydFCBoBQG5g2HbISpaiJoue+D3xc1TjaBFhK3wV62zzlO2IrgjXtiFq?=
 =?us-ascii?Q?cuzp7DqTqB/fU3ggyKWZLUiruDuEeJDszjJhx/1c6R5ttx8f/rIpzDL3IbQh?=
 =?us-ascii?Q?4ESh9x0VKvzMISuu64OCW+ufYL/i6LNqCCEMkZojFhL72cOM0ZsmjLuElsMz?=
 =?us-ascii?Q?fzsYH4J3z0NhhVd+P9TY3Q4LeUx/3eF5q18c1toEcw/PSWf4S465aMdoJPKe?=
 =?us-ascii?Q?mq1sEQr5dOyqCqDERA18Tp9TWO9XPSPkzgG9FxYEKpWfoIhYs9HDMfqV6rAq?=
 =?us-ascii?Q?dx3X1kI2jhg2sMhTZWx08J7QubYyhZBXgAb1Ae3U0q7cyJQQ35afu8MBoS9X?=
 =?us-ascii?Q?Gc63JLuJHSfZkSrEWbFcL5ifVLw83ctNaJYlr8C2rVrTfRnig+FjoZVU3Z7x?=
 =?us-ascii?Q?kLfZuZAKNgO0J3ozee3WPS0tBT6KK/8HK77zFNKX42aorSIVlXxyNgJtAMKs?=
 =?us-ascii?Q?FNyrPYtnDCdSxK4x84iuApce6ptr4bo=3D?=
X-Exchange-RoutingPolicyChecked: LztfmZ8NzxsoSu8wXH5VIX0b3QXzMOCOkSDr+8aH7DUcjDduzjqYbJdQDlcdFOJ8oLEmUV7A6DHRmvu3eqCznSJhb5UGqIlftm0q8SE6yOrHXjXevny2hCd4HN0NkO91tAlMD5sfqjzeqQ3yJX+W8GDg43oyC8ptQkIBBDil09T7Dp9M7b7LfUhERvIm/Wjw2KiOf444/sq983kF/QzOi3X2Ga01e/t/NWv/+DLpRL1iB7humVq3W4QNh8RkNu4wZZdU/nDPYM2u38UhLh+3lVftUo01NnAIYsSECF51U9t03+XkaZWSKGfx2dNJA5L9h0D4lLt9V/tDJfrBTGjuWg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2073399-f455-48e6-8bc1-08de7f8aee48
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 16:26:21.5964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2ZlooMJtTguI0z6dOB/6EpzXPMWGpjVrgnzoxYAZZEZrh4QhewrumrUGG1DzDIqxkWeWYFoFVtSXH8BvaG4seis3/1LfDjPEN4Ko4Qz0vs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR02MB11111
X-Proofpoint-ORIG-GUID: IojoWAz7jYC8wQLE3K1_uc2W_9fc1mwM
X-Authority-Analysis: v=2.4 cv=dMOrWeZb c=1 sm=1 tr=0 ts=69b197b0 cx=c_pps
 a=joEKXnXoGvZ7C1i2YY6L6A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=zRaU-G0EUO7tfXcqvJAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEzOSBTYWx0ZWRfX8DBUZd6Gijh7
 f7tUN2TnKesQna+Q+5NvAmHAqgzg0ipQUHMPuR10eHZ06S0zZFHZNyxAYwP79OCgDt42Oo64hrK
 iSWO5FCMir2SIKZ6mu4hAsfrIDzNhqan/qXHgb/06PnXEGNBQY0D3wQaLXiDcFbx7z7lQDsWuBK
 UWCGUKxr2Kwj6aousMRrsFQWwZ/MWZOoreurDTDwOmRWju/PQc3c0rKU50ODNB/9GckF1kWY2Kg
 tTKYtbZpap4KHB5m8CWzakECvwLdYrwjB8Doeu5zY5s5oi27npX0T1QSt8DKOKJvpoorpLTx6z/
 BkcYhTJbAeCnYRxpw6nQE0EySAstlixgExlZHV42Fnm/M4mJZLJzfM0OMAuWIaV2lTxGhmap2BT
 Zp0vwsOXo6oREgSdr1o/ah7BTDsUqtFxf0RteEw8i4kBdK6UYm3y2M22UEhq0gKcnCBwk7yoqNU
 Ydx3vk/QWen4aLgs0bQ==
X-Proofpoint-GUID: IojoWAz7jYC8wQLE3K1_uc2W_9fc1mwM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Update the x86 ACPI tables to reflect the IRQ descriptor changes for ISA serial
ports:

     Device (COM1)
     {
         Name (_HID, EisaId ("PNP0501") /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
         Name (_UID, One)  // _UID: Unique ID
         Name (_STA, 0x0F)  // _STA: Status
         Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
         {
             IO (Decode16,
                 0x03F8,             // Range Minimum
                 0x03F8,             // Range Maximum
                 0x00,               // Alignment
                 0x08,               // Length
                 )
-            IRQNoFlags ()
+            IRQ (Edge, ActiveLow, Shared, )
                 {4}
         })
     }

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h   |  47 ------------------
 tests/data/acpi/x86/microvm/DSDT              | Bin 365 -> 366 bytes
 tests/data/acpi/x86/microvm/DSDT.ioapic2      | Bin 365 -> 366 bytes
 tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 2985 -> 2986 bytes
 tests/data/acpi/x86/microvm/DSDT.rtc          | Bin 404 -> 405 bytes
 tests/data/acpi/x86/microvm/DSDT.usb          | Bin 414 -> 415 bytes
 tests/data/acpi/x86/pc/DSDT                   | Bin 8598 -> 8599 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8509 -> 8510 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9923 -> 9924 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15469 -> 15470 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9062 -> 9063 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10252 -> 10253 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8549 -> 8550 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5087 -> 5088 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8670 -> 8671 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9957 -> 9958 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8456 -> 8457 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8604 -> 8605 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12391 -> 12392 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8427 -> 8428 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8444 -> 8445 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9752 -> 9753 bytes
 .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12637 -> 12638 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8706 -> 8707 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8473 -> 8474 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12040 -> 12041 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12985 -> 12986 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33842 -> 33843 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8891 -> 8892 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13218 -> 13219 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10081 -> 10082 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8502 -> 8503 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8515 -> 8516 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8444 -> 8445 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9786 -> 9787 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9557 -> 9558 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13280 -> 13281 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8289 -> 8290 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8285 -> 8286 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8433 -> 8434 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8528 -> 8529 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12985 -> 12986 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33842 -> 33843 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 9033 -> 9034 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9059 -> 9060 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18661 -> 18662 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14684 -> 14685 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35790 -> 35791 bytes
 48 files changed, 47 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index cef44135bc..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,48 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/pc/DSDT",
-"tests/data/acpi/x86/pc/DSDT.bridge",
-"tests/data/acpi/x86/pc/DSDT.ipmikcs",
-"tests/data/acpi/x86/pc/DSDT.cphp",
-"tests/data/acpi/x86/pc/DSDT.numamem",
-"tests/data/acpi/x86/pc/DSDT.nohpet",
-"tests/data/acpi/x86/pc/DSDT.memhp",
-"tests/data/acpi/x86/pc/DSDT.dimmpxm",
-"tests/data/acpi/x86/pc/DSDT.acpihmat",
-"tests/data/acpi/x86/pc/DSDT.acpierst",
-"tests/data/acpi/x86/pc/DSDT.roothp",
-"tests/data/acpi/x86/pc/DSDT.hpbridge",
-"tests/data/acpi/x86/pc/DSDT.hpbrroot",
-"tests/data/acpi/x86/q35/DSDT",
-"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
-"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
-"tests/data/acpi/x86/q35/DSDT.bridge",
-"tests/data/acpi/x86/q35/DSDT.noacpihp",
-"tests/data/acpi/x86/q35/DSDT.multi-bridge",
-"tests/data/acpi/x86/q35/DSDT.ipmibt",
-"tests/data/acpi/x86/q35/DSDT.cphp",
-"tests/data/acpi/x86/q35/DSDT.numamem",
-"tests/data/acpi/x86/q35/DSDT.nohpet",
-"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
-"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
-"tests/data/acpi/x86/q35/DSDT.memhp",
-"tests/data/acpi/x86/q35/DSDT.dimmpxm",
-"tests/data/acpi/x86/q35/DSDT.acpihmat",
-"tests/data/acpi/x86/q35/DSDT.mmio64",
-"tests/data/acpi/x86/q35/DSDT.acpierst",
-"tests/data/acpi/x86/q35/DSDT.applesmc",
-"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
-"tests/data/acpi/x86/q35/DSDT.ivrs",
-"tests/data/acpi/x86/q35/DSDT.type4-count",
-"tests/data/acpi/x86/q35/DSDT.core-count",
-"tests/data/acpi/x86/q35/DSDT.core-count2",
-"tests/data/acpi/x86/q35/DSDT.thread-count",
-"tests/data/acpi/x86/q35/DSDT.thread-count2",
-"tests/data/acpi/x86/q35/DSDT.viot",
-"tests/data/acpi/x86/q35/DSDT.cxl",
-"tests/data/acpi/x86/q35/DSDT.ipmismbus",
-"tests/data/acpi/x86/q35/DSDT.xapic",
-"tests/data/acpi/x86/microvm/DSDT",
-"tests/data/acpi/x86/microvm/DSDT.usb",
-"tests/data/acpi/x86/microvm/DSDT.rtc",
-"tests/data/acpi/x86/microvm/DSDT.ioapic2",
-"tests/data/acpi/x86/microvm/DSDT.pcie",
diff --git a/tests/data/acpi/x86/microvm/DSDT b/tests/data/acpi/x86/microvm/DSDT
index f477668f2ee80241e47b340ad4a30f5480df2049..faa858f99d30bfeac80951e5b37ca8834f609e4e 100644
GIT binary patch
delta 47
zcmaFM^p1(kCD<h-kCB0a>C;3mX-1EUYUYf_6XO*51-ba#8GkVUU}oS@7GRK^*!utg
DFK-NW

delta 46
zcmaFI^p=UsCD<h-myv;iNpK>UG^6`OHFHLziE)a20$jZAj6axvFf(u{2{26TdjJ3k
C0}FKk

diff --git a/tests/data/acpi/x86/microvm/DSDT.ioapic2 b/tests/data/acpi/x86/microvm/DSDT.ioapic2
index e5924a49962e0cff4228bcfc77ebcf48cb4a2219..87f6473d986818df26eca9c9546ac8cdf300a270 100644
GIT binary patch
delta 47
zcmaFM^p1(kCD<h-kCB0aY0X3~X-1EUYUYf_6XO*51-ba#8GkVUU}oS@7GRK^*!utg
DCTR>W

delta 46
zcmaFI^p=UsCD<h-myv;i>GVV{X-4;nYUYea6XO*51h{zJ8GkVUU}oS@5@49v_W%GN
CLkuqf

diff --git a/tests/data/acpi/x86/microvm/DSDT.pcie b/tests/data/acpi/x86/microvm/DSDT.pcie
index b646a05551c1ed902413a462442346ce246f8675..733f00d29153637d1305d1752b2b7142bb931510 100644
GIT binary patch
delta 48
zcmZ1}zDk_SCD<io6*mI|)6I!o(u^(>)yx@<C&nrA3v%(fGyY)y!OXy+EWjYSu~&v0
E05DYxrvLx|

delta 47
zcmZ1_zEYgaCD<ioB{u^D(~pT<(u~d%)yx@<CdMi932^bcGyY)y!OXy+B*3t-Plg)+
DDIN=_

diff --git a/tests/data/acpi/x86/microvm/DSDT.rtc b/tests/data/acpi/x86/microvm/DSDT.rtc
index e375473b5f033d374dd2a64a9f814fd16c3e262f..651f5cce04ec0d1de8edb8e76823f194e533410f 100644
GIT binary patch
delta 48
zcmbQjJe8TtCD<ioDkB2}(}9Ux(v1ES)yx@<C&nrA3v%(fGyY)y!OXy+EWjYSv6r0@
E02+A<2><{9

delta 47
zcmbQrJcXIdCD<io3L^sp)BTBD(u{r+)yx@<CdMi932^bcGyY)y!OXy+B*3t-kDU<!
D6Tu4!

diff --git a/tests/data/acpi/x86/microvm/DSDT.usb b/tests/data/acpi/x86/microvm/DSDT.usb
index d63fd84620a2689120b32262f964e6a098d71632..ae9aa979a752a346a1232de80545cac424ba5641 100644
GIT binary patch
delta 48
zcmbQoJfE4%CD<ioJ|hDI6VpU4X-3b9YUYf_6XO*51-ba#8GkVUU}oS@7GRLv*el2g
E00q?wZ2$lO

delta 47
zcmbQwJdc^nCD<io9wP$-lj1}!X-1EUYUYea6XO*51h{zJ8GkVUU}oS@5@6WaC&&l@
D|FjBi

diff --git a/tests/data/acpi/x86/pc/DSDT b/tests/data/acpi/x86/pc/DSDT
index 6ea2d36d138daffb59a8636759078500adc58f24..b52cd65af59b9da995dc0bd03a8f88a1559b6535 100644
GIT binary patch
delta 82
zcmbQ{Jl&bgCD<iox*`Ju<F$=k+lA!3p2frmJH-n)JqvL5G>C5E4mL1|=ZJT731WzD
ma^HMkD29>Ic(RR%BEKLPpF86Z<{!)q9LfR=lAE(dw0Qv-Ko<%C

delta 81
zcmbR4Jk6QQCD<ionj!-O<M)kR+lAyjpT)!nJH-n)J_~U6G>C5E4mL1|=ZJT731WzD
la@%}gD29>IXtIrnBA);kuRG%p<{!)q97+NVn{!08c>xKT7YYCX

diff --git a/tests/data/acpi/x86/pc/DSDT.acpierst b/tests/data/acpi/x86/pc/DSDT.acpierst
index d8c173aa613f51b1c76ea7b9dee19e899cba240d..967f6dde1ae580b9a17ee66e7d720f1234c77a43 100644
GIT binary patch
delta 82
zcmdn%w9kplCD<jzPLY9uQEnsGb|E>(hcWTNPVoYs4+5M$4WgU4gAEMgIpQ5%f*7Kk
m+&AABieY3lo@^tc$S=sn=g#<p`3Exthq3^J<mPOVOFRJNC>GuT

delta 81
zcmdnzwAYEtCD<jzR*`{$(S9S>b|E>3hcWTNPVoXB4+5M$4WgU4gAEMgIpQ5%f*7Kk
l+&14AieY3lnrtJY$S1(X>(2Ot`3Exthmrup<{XhrJOI{H7Ty2=

diff --git a/tests/data/acpi/x86/pc/DSDT.acpihmat b/tests/data/acpi/x86/pc/DSDT.acpihmat
index ba363d6af76af728b7c88bbaf47f7e0ea3dcb41f..15c10cc3ef08c257405c745d8e96866fb89ec0f6 100644
GIT binary patch
delta 82
zcmX@?d&HN^CD<k8h#CU}<K&H8PsHWCp2frmJH-n)JqvL5G>C5E4mL1|=ZJT731WzD
ma^K7&5yQx6JULTRkzbID&z<oH^ABbQ4rKub$;~q)wRr(Btrsu=

delta 81
zcmX@&d)SxDCD<k8uo?pc<CcwFPsHUspT)!nJH-n)J_~U6G>C5E4mL1|=ZJT731WzD
la@))!5yQx6G&xgJkxzh&*PZbP^ABbQ4kZDG%`+vnc>y947cc+-

diff --git a/tests/data/acpi/x86/pc/DSDT.bridge b/tests/data/acpi/x86/pc/DSDT.bridge
index b68302363cb24181988d6e3dceb04a0946838d5e..69bfdf97db0c273b534fcd87e02de096f0cbff23 100644
GIT binary patch
delta 83
zcmaD`@vef)CD<h-&xV14@ySN6?LrEDy-YFj!A|i4t-VYE&YlL*P29l-2Jsy6jxIqA
n(M|4~9}2}VG8#{|6H(+B<l=K@{K5Q#nSn!DfI)I`u80NzWDpnQ

delta 82
zcmaD?@wS4?CD<h-*M@<Ck#!^2b|Hn{UZ$A%V5fM2mR_a+XHSFZChlMZgLsa3N0%Um
m=q9(#4~1eF8I2~}i74_3aPhh`{$T#W%)p@}z_2(^L<0a2uNLC~

diff --git a/tests/data/acpi/x86/pc/DSDT.cphp b/tests/data/acpi/x86/pc/DSDT.cphp
index 20688edf2da41146ece4faa4141517408a42870c..ae5ec9c764c718764c21c67998ac38503a8149c5 100644
GIT binary patch
delta 82
zcmaFn_S}ujCD<h-U73M_(Q_kLyNI0EvzYi`r+5LUX93Qh2GLF2!3GBL9Py4WK@8DN
m?wi+(#4s`%Pv#L*<QL@Pb7%a){DYZ+Ls@`9a<jFVHZK4J+!j3m

delta 81
zcmaFv_RNjTCD<h-O__m#F>51NyNI0UvzYi`r+5L!X93Qh2GLF2!3GBL9Py4WK@8DN
lZkyMO#4s`%P393(<P+fHb!Ys+{DYZ+LrH*PvyGTGF97w$7Cis}

diff --git a/tests/data/acpi/x86/pc/DSDT.dimmpxm b/tests/data/acpi/x86/pc/DSDT.dimmpxm
index 8d4be05d2c71ca8de6d732d3e48e0e323143160c..dd7d04aacc840d7b66019a5679eedc01959292d3 100644
GIT binary patch
delta 95
zcmeAP=ndd<33dtL)nH&?{I-!xSCZ4~SxkJeQ@nuFWCuwRM)%F3k}-^i#?Jn}h8*!8
yo-RC&7g!lN;zK=MfMjrpBNsnMymL^npdc5YJL3=LAIuCK$^s0Mn;%MP^8x^^!xyFi

delta 75
zcmeAT=n3F*33dtL(O_U;6yM0DE6M5kEG9nKDPF*FvV)`uqub_C$rwg{BWHhKLymY4
fPZu7?3#^Qjd!!^de=z@GX5df~VA%XfN}Cq|+i4SC

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbridge b/tests/data/acpi/x86/pc/DSDT.hpbridge
index 2b5b885b862a2fe8bc4a24446400dccf685dab85..0c7a6a0ceb0bef6d3719c8ed442f421e4774154f 100644
GIT binary patch
delta 82
zcmaFr^vsFNCD<h-O_70tk!vH@b|E>>$1(B2PVoYcj{}@N4WgU4gAEMgIpQ5%f*7Kk
m+&AABieY3lo@^tc$S=sn=g#<p`3Exthq3^J<mPOVUpxQ>NEdGa

delta 81
zcmaFn^wf#VCD<h-Rgr;#QF|lTb|E>B$1(B2PVoW`j{}@N4WgU4gAEMgIpQ5%f*7Kk
l+&14AieY3lnrtJY$S1(X>(2Ot`3Exthmrup<{Xh<JOK9l7jFOn

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbrroot b/tests/data/acpi/x86/pc/DSDT.hpbrroot
index cc6f26a3f8fe85f34a8acb5432bab3cf4d3ab1f6..36ee469ed53000db6174c478cf9df85976287f93 100644
GIT binary patch
delta 82
zcmcbw{y?3}CD<k8fiMFDqvu909zi)TotXGwr+5J;od9P~gXkviU;~4Aj(A6xAcp8B
m_su4PF^r7HlP3x(@(XhDxikJ?{=v+^p)9~4x%q&QJR<;=@)Xnn

delta 81
zcmaE$eqWu-CD<k8zAys=W7bA49zi)zotXGwr+5KJod9P~gXkviU;~4Aj(A6xAcp8B
lx6LMkF^r5xlP3x(@(FP9x-<S@{=v+^p(Mbt`Jj+IBLIoK6x09!

diff --git a/tests/data/acpi/x86/pc/DSDT.ipmikcs b/tests/data/acpi/x86/pc/DSDT.ipmikcs
index 052a84e294eee4ecef9a36341493f841caf887a5..82c309f19d238a89851ad54603e13b324d6c2460 100644
GIT binary patch
delta 82
zcmV-Y0ImPtL*GLRL{mgm-yr}10aCFFw-O#g>s((`LSGO{>QF;TFk6BPQ!p@J2wy=&
oQUF_mPqW_=qyYgllY|r@4-pCuM*;W)_yYh4BM<-?v$GT{4N4stM*si-

delta 81
zcmV-X0IvVvL*7FQL{mgm-XQ=00duhmw-O#f>s((`LSGO`>QF;TFk6BPQ!p@J2wy=&
nQUF_mPP5+<qyYgklY|r@4iE|rM*;W)_yYh4A`k$xv=l21I)NBR

diff --git a/tests/data/acpi/x86/pc/DSDT.memhp b/tests/data/acpi/x86/pc/DSDT.memhp
index 7efc12a46cb87c0684b7d880b2cc94d302744e03..300793ceb8b41d78d52eb3dfd6b09d5b75c29d77 100644
GIT binary patch
delta 82
zcmaFr`^=ZiCD<k8nHmEF<Eo8ZY!Y%_&tl?(o#F+Yo&`928bmj72OAi~bHqEk1TjQ6
mxo_5!h+$+jp4=^|$S=sn=g#<p`3Exthq3^J<mO$H+PnZIw-+`5

delta 81
zcmaFn`_z}qCD<k8sTu<V<LQlDY!Y&w&tl?(o#F)?p9MI38bmj72OAi~bHqEk1TjQ6
lxoy^yh+$+jn%pg^$S1(X>(2Ot`3Exthmrup=G~IoyZ{$C7d8L@

diff --git a/tests/data/acpi/x86/pc/DSDT.nohpet b/tests/data/acpi/x86/pc/DSDT.nohpet
index 7eedfcd64ebd0193744864b4f6cbead35c7c3ab2..e6d58b295aa30fde9a0d72c0c56b968e6279ecef 100644
GIT binary patch
delta 82
zcmeBh>U83A33dtLRAgXaoWGGvQ%KJ1SxkJeQ@nuFvjAsLgXkviU;~4Aj(A6xAcp8B
m_sxMqF^r7Hlh+9=@(XhDxikJ?{=v+^p)9~4x%sZJHZK6KxfSgI

delta 81
zcmeBl>Tu$633dtLP-I|WJg|{VQ%KJ9SxkJeQ@nuVvjAsLgXkviU;~4Aj(A6xAcp8B
lx6Oe<F^r5xlh+9=@(FP9x-<S@{=v+^p(Mbt`JS*gF94yS73}~3

diff --git a/tests/data/acpi/x86/pc/DSDT.numamem b/tests/data/acpi/x86/pc/DSDT.numamem
index 910b4952a0757025cfed1c60416d16054e70846f..a92bb83361a80f39fca6061305e5e72af89bbe1d 100644
GIT binary patch
delta 95
zcmbQ^JlC1aCD<iot|9{iW70;hy+WK`&tl?(o#F+YCSMQ|VRYa8R49hg(Ae4E*N`LL
y!_$Sw@d7I&M|`NK3y=&BapdCXh<6SO78K;-b7%a){DYZ+Ls@`9a&w`GHZK4fwiw0$

delta 75
zcmV-R0JQ&|L!3hjL{mgmoFM=J0fVs$y%GsY=3HM>LSGO;lh6_r0Y<as5?lcfGDA;I
hF$iBsNkj}m&;<dL926J{_yhO@00<%w0JCxwD-B#;6$k(T

diff --git a/tests/data/acpi/x86/pc/DSDT.roothp b/tests/data/acpi/x86/pc/DSDT.roothp
index 45d3dbe1b69143a956b4f829913ca47f07134741..0fc28164ed66819f164142f49572863983e3c44f 100644
GIT binary patch
delta 84
zcmaE!@FIcBCD<h-!+?Q-F=->$b|HnP^Nca^!A|i4o#z+>oIMSqo4A7w4B|QB9bJML
oqMO_|KNN~#WHg>^C!)wN$i?T*_=EWeGXsaR0E6V_T#;YW09{oWi2wiq

delta 83
zcmaEn@H~ObCD<h--GG6Cv3Vocb|Hnv^Nca^!A|i49p@MWoIMSqo4A7w4B|QB9bJML
nqMO_{KNN~#WHg#=C!)wFz{Ts%_=EWeGXsZ`0K?`ykzdjPPD>bx

diff --git a/tests/data/acpi/x86/q35/DSDT b/tests/data/acpi/x86/q35/DSDT
index 377e880175f6f11101548c0c64da61b5aee00bd9..0f840ddf54107d59425799eed4741a0b3901a0e7 100644
GIT binary patch
delta 65
zcmaFu_{NdTCD<k8jRFG$<C2YB^75Q+(lPPDPVoYMla1sZ7`-PK%YR@ro}8kf$S=sn
V=g#<p`3Exthq3^J<mAZ;5degy5)A+V

delta 64
zcmaFk_}Y=nCD<k8wE_bJ<I#;=^75Rn(lPPDPVoZ1la1sZ7`-MJ%YR@rnw+Ab$S1(X
U>(2Ot`3Exthmrup<S7af0C`ao4FCWD

diff --git a/tests/data/acpi/x86/q35/DSDT.acpierst b/tests/data/acpi/x86/q35/DSDT.acpierst
index 026bfdfebf66c1803f158ac8c115eb5f49b5cb19..6528b5fe49e000be84e794941f56310bb851936c 100644
GIT binary patch
delta 65
zcmez4_}7ukCD<k8uL1)DqsvAvd3jEEnV9%sr+5MX$wu;ljNX%5<UcSPPcBtZ<QL@P
Vb7%a){DYZ+Ls@`9a`F;|2mpi>5+?uv

delta 64
zcmezC_{WjUCD<k8j{*Y&W9mjOd3jDZnV9%sr+5Ls$wu;lj9!yl<UcSPO)gbX<P+fH
Ub!Ys+{DYZ+LrH*P@=}Ee0C=_%CjbBd

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat b/tests/data/acpi/x86/q35/DSDT.acpihmat
index f1b8483d8da21dd57f3e5e7a1e4eb787df2c38ac..11104b11ad400ed0424579df33c9c1ca357d9e28 100644
GIT binary patch
delta 65
zcmbQ?Gt-C5CD<iIQjLLuF<~Q@j|!)obWD7(Q@nuR<aiYaM(@cBR6Z~oPoAi%$S=sn
V=g#<p`3Exthq3^J<m3aY5dc8}5oQ1Y

delta 64
zcmbQ~GsB0=CD<iILXClev2i1pj|!)&bWD7(Q@nuh<aiYaMz6^WR6Z~oO`fQ#$S1(X
U>(2Ot`3Exthmrup<b$da05*jYW&i*H

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x
index a7731403f460a235bf705770a1547dafeee069ab..64ff0eea014ea7be1095609e4734f29bfce78dcc 100644
GIT binary patch
delta 66
zcmcbcbT5g^CD<h-&X9qDQDh_6I$cgDqnP+$r+5Lc%?EYYFfw{i&eQ+EXgoRIK#^aN
Wi_e|$2lEeR1`cHb2Fb~N2Im2*ITMrs

delta 65
zcmcbYbT^61CD<h-){udL(R3r%I$cgjqnP+$r+5L+%?EYYFfw{g&eQ+EXf!$AK#@;?
Vi`Sj;2lEeR1`Z_whROW~=K-Gm6O;e|

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator
index cb4995de7e33cd9f2d134ec96651d217873d6944..8ed2aa533343d1e4080e4cf64d2e7e9bf0f00ab3 100644
GIT binary patch
delta 65
zcmZp2X?Edq33dr#R$^dal-kH;roibY9TOky6ffX6*;B!R(R*^2!Usm<$<>OA{DNG3
V?u<W}e=sv}C<`!1PF|%L0RRw#5J&(3

delta 64
zcmZp6X>#Fm33dr#Qet3WwBE>Nroibc9TOky6ffXA*;B!R(Q9&-!Usm9$<>OAd;(m&
U?u<W}e=sv}C<!o3Uac4b00#>YNB{r;

diff --git a/tests/data/acpi/x86/q35/DSDT.applesmc b/tests/data/acpi/x86/q35/DSDT.applesmc
index 92c8fdb6cbb8ae8bdf5ede9679eea92486eaf372..d99ed5d31ef2173dd6e9b83fbbfc8822c3037615 100644
GIT binary patch
delta 94
zcmbQ~G|P$0CD<iIN|Awqaq>nkd3jD3xtRE1r+5LM$wu-HjGmi|<>eR+jh+2{4LRaH
xJY9GkFR(Il#D{vi0LkDGM=pMjc;}#CK|wA)cg7#gKbRRflm!?hCm&RZ002Py7Ht3k

delta 74
zcmbQ`G}DR8CD<iIQjvjyamz+7d3jD}xtRE1r+5MH$wu-Hj2@ed<>eUpjhy{`4LRaH
eJY9GkFR(IB&QXxy{K5Q#nSnz|fMN0>g$Mw{l@kj9

diff --git a/tests/data/acpi/x86/q35/DSDT.bridge b/tests/data/acpi/x86/q35/DSDT.bridge
index 957b3ad90c787616eac212865bce0a19a5ac1e6e..89b3c833bb004e96baae91897dd96524492b8017 100644
GIT binary patch
delta 66
zcmeB(>x|=a33dtL)MsE|+`o}aUY^tEYfOBwQ@nu7W+VA$yo}zHC3QbA8c*iZQ{)%q
W;&W&G!Tf`nfkRn<L2|OC-gy9XEfNF(

delta 65
zcmeB->xkoW33dtL&}U#^e6W#AUY^tYYfOBwQ@nulW+VA$yo_FxC3QbA8cpWXQ{)ri
V;&o^I!Tf`nfkR1vVX~Fpc>riC5(EGM

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count b/tests/data/acpi/x86/q35/DSDT.core-count
index 50ca91b065d9a2ba95f97d01856865f0e7c615f6..eb8c24e5621ecd83db35c5de153d4e0b8631b2c8 100644
GIT binary patch
delta 92
zcmdm)x+|5-CD<iomk|R4qs&IGw+5VU(lPPDPVoYMlMEdgy(c>welRq4_V+d9i1+Yx
v;c>jc%E%EP>gfU`gF_s-_&MU8gMtMGx%k`}e=z@GX5dg3V33@gXcPee%HkL?

delta 72
zcmdm$x-*r_CD<iorx61KqwPknw+5W9(lPPDPVoZ1lMEdgy(T*ve&9E9_V+d9i1+Yx
c;c>jc$~c+FNP_bR^ABbQ4kZDG$w@{L03N6mfdBvi

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count2 b/tests/data/acpi/x86/q35/DSDT.core-count2
index f460be2bf74ae512db8f24418b42e8cf2a56202d..50ed660a6cf50274ab48b28dd70b8220c8deb187 100644
GIT binary patch
delta 67
zcmdng!L+%9iOVI}CB(Refq^l1BUf4zr<-(4e6UlzfZycGCI?3E$-A09Fd9!@-K@wj
X$i?T*_=EWeGXsaR0E6V@Tg?#w%Zn8A

delta 66
zcmdno!L+G^iOVI}CB&$Ofq}7aBUf4zr>k^Ke6UlzfbZnWCI?2Z$-A09Fd9u>-K@wb
Wz{Ts%_=EWeGXsZ`0K??l%@F{-`xNs4

diff --git a/tests/data/acpi/x86/q35/DSDT.cphp b/tests/data/acpi/x86/q35/DSDT.cphp
index 7c87d41d03fcfd2b5b82f2581f16de6bc0bb10bf..70b80ddd7395a167effdc34550cbfc6f1f910718 100644
GIT binary patch
delta 65
zcmdn(y2q8vCD<ioj}ij|qxeRy_X?bD(lPPDPVoYMlbIA97`-PuD}G=!o@}C|$S=sn
V=g#<p`3Exthq3^J<m6<f2moJj5fcCa

delta 64
zcmdnvy4#h@CD<iow-N&bqs2z9_X?b@(lPPDPVoZ1lbIA97`-MtD}G=!nrxz^$S1(X
U>(2Ot`3Exthmrup<P@a{095A@6951J

diff --git a/tests/data/acpi/x86/q35/DSDT.cxl b/tests/data/acpi/x86/q35/DSDT.cxl
index da86b25f51b550ab20771111cb0a2bc49e713186..956d914b5bee53689b1f6ed7aa6c99ee23a35a8f 100644
GIT binary patch
delta 66
zcmZ3KzBrxBCD<iou`vS!<MWMNTMW58WMkrko#F)?WGA06Ol0()tY!3p(Ri}7u_C`9
W7oR)h59S}t3>?Y=43d+*j3WTA1`@Ua

delta 65
zcmZ3Sz9^l`CD<iokud`U<Ijy;TMW6}Wn<!lo#F-jWhS36Ol0($tY!3p(P*-?u_B)U
V7q2_x59S}t3>-=V43oW$BLJcw61D&U

diff --git a/tests/data/acpi/x86/q35/DSDT.dimmpxm b/tests/data/acpi/x86/q35/DSDT.dimmpxm
index a2d812e5a23a3ce7739789246b342e703f8c96c0..ad0c9d77ddc03a2d6042e3075707de1b8efeae08 100644
GIT binary patch
delta 65
zcmV-H0KWg>PU21qL{mgmVkZCq0mQKil_d#A8(d#gLSGP0lc*&?0ZWtVCGY_=liDUB
X4-pCuM*;W)_yYh4BM<-?lL;qSuXz(4

delta 64
zcmV-G0Kfm@PT@`pL{mgmVJ83p0p+m@l_d#98(d#gLSGO~lc*&?0ZNnUCGY_<liDUB
W4iE|rM*;W)_yYh4A`k$R3MW{ikrN#N

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmibt b/tests/data/acpi/x86/q35/DSDT.ipmibt
index 43ac1bd693d1b3f67d2a9e89ccaf8a56656df22d..4e5e6bccc152bde9e6a624323d84702aca861476 100644
GIT binary patch
delta 66
zcmdnywB3ozCD<jzT#<o+@%lzCd3jDpg_!tYr+5L+$wu-HjBcBY<*gYRjVG^HP~;cn
W;&W&G!Tf`nfkRn<L2~jvg$MvoCJ`I}

delta 65
zcmdn)w9SdjCD<jzOp$?s@yA9kd3jC;g_!tYr+5L6$wu-HjINuD<*gYRjV7;GP~;Qf
V;&o^I!Tf`nfkR1vVe);22mnPY5gY&j

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmismbus b/tests/data/acpi/x86/q35/DSDT.ipmismbus
index 1b998820d46e522b3129e42a867ed691c1f83e8f..d32cefdc6d4b5f9ffadd9993703c9285456a7dd1 100644
GIT binary patch
delta 65
zcmX@?bi|3vCD<jzMUjDl(PJZ*yga9$LQH(HQ@nuNWFvV8M(@eR@*fzDC#NVV@(XhD
VxikJ?{=v+^p)9~4IeD_e1^_#|5g7mg

delta 64
zcmX@&bl8c@CD<jzS&@N(F>@oAyga9`LQH(HQ@nudWFvV8Mz6`m@*fzDCZ{MU@(FP9
Ux-<S@{=v+^p(MaCd5XdY05P%=82|tP

diff --git a/tests/data/acpi/x86/q35/DSDT.ivrs b/tests/data/acpi/x86/q35/DSDT.ivrs
index 026bfdfebf66c1803f158ac8c115eb5f49b5cb19..6528b5fe49e000be84e794941f56310bb851936c 100644
GIT binary patch
delta 65
zcmez4_}7ukCD<k8uL1)DqsvAvd3jEEnV9%sr+5MX$wu;ljNX%5<UcSPPcBtZ<QL@P
Vb7%a){DYZ+Ls@`9a`F;|2mpi>5+?uv

delta 64
zcmezC_{WjUCD<k8j{*Y&W9mjOd3jDZnV9%sr+5Ls$wu;lj9!yl<UcSPO)gbX<P+fH
Ub!Ys+{DYZ+LrH*P@=}Ee0C=_%CjbBd

diff --git a/tests/data/acpi/x86/q35/DSDT.memhp b/tests/data/acpi/x86/q35/DSDT.memhp
index 7346125d23fb3174c0ce678a2cdf2fdc77c4a9fa..461439f3c3df0abfde5e8b11a8b94692184b7b28 100644
GIT binary patch
delta 65
zcmdnxv)hNuCD<jzT8)8$v3w&}o(iX%bWD7(Q@nuR<VF<-M(@doR6Z~oPu{Gm$S=sn
V=g#<p`3Exthq3^J<m5-H5dd&n5{&==

delta 63
zcmV-F0KosdOu9@8L{mgmIwk-B0hqB0ZX^js8(d#gLSGO~lYt~a0ZNm?B=7+;ld~lu
Vlb|I93HSr}0{{pj5CD_oC0J)56LtUq

diff --git a/tests/data/acpi/x86/q35/DSDT.mmio64 b/tests/data/acpi/x86/q35/DSDT.mmio64
index 15a291dbfb62e6ceb0249e02eb25b319744e351f..83611d7d12aee11cab97bcef43faf202509f6bcf 100644
GIT binary patch
delta 65
zcmccWb<K;*CD<h-OqGFw(PAT4g)*nROiX;RQ@nux<Zk6aM(@dYl|L{VPd=xj$S=sn
V=g#<p`3Exthq3^J<mA695deWV6Al0X

delta 64
zcmccSb=8Z@CD<h-RF#2&F>)hUg)*m`OiX;RQ@nuR<Zk6aMz6_tl|L{VO+Kfh$S1(X
U>(2Ot`3Exthmrup<bNs=0Ci6j4gdfE

diff --git a/tests/data/acpi/x86/q35/DSDT.multi-bridge b/tests/data/acpi/x86/q35/DSDT.multi-bridge
index 889a9040d950dd08980408d57f1037a5fc20c961..47fac5ce1e855de77b9c9b52426edfc7e3886aa9 100644
GIT binary patch
delta 96
zcmaEm{xF@(CD<k8p)msk<Ias-^733QI*c*#!A|i4-J6Z&eFYi4CpQ{=Ff?}d_ci2*
z_waP#alF9F$Ppjv=>jB!LmavIIpUpzf&~S+_}m$PF#lj?;7}G|kleh`(4GkZW{nx%

delta 76
zcmaEu{ve&pCD<k8fiVLE<E@Qc^735GI*c*#!A|i4U7L;NeFYi4CN~;<;5Tyi_ci2*
g_waP#alF9FIN8Tgg7XLS4`v1qB>{%biwy0V0H1mmZ2$lO

diff --git a/tests/data/acpi/x86/q35/DSDT.noacpihp b/tests/data/acpi/x86/q35/DSDT.noacpihp
index 780616774f97a2d7305faf9e9a9d12afeb0e2fa2..e39a74e088817c763c84f4b88f7d7b706de25020 100644
GIT binary patch
delta 66
zcmaFp@W_G7CD<h-Nr8cZv27z)i7cm!UQB$jQ@nuB=62aUMn><+-{d|p8c%*MugEXR
W#pllWgZT$D1BbEzgXCl}1#bYR9TLp|

delta 65
zcmaFl@X&$FCD<h-QGtPhars8B5?M}Xy_oo5r+5MH&F!*zjEr8BzsY@IG@ATeUXf3L
Vi`Sj;2lEeR1`Z_whRNaz-T;}L63qYr

diff --git a/tests/data/acpi/x86/q35/DSDT.nohpet b/tests/data/acpi/x86/q35/DSDT.nohpet
index 0f862ab2938e0e11aa8335630fad389095b37edd..7e78ae2a157fe66a85a35aeff7aa6a21d877f07c 100644
GIT binary patch
delta 65
zcmccXaL<9uCD<h-PJw}eF?S=^L^)13>6rLnr+5Ls$xGxM7`-PymHWVGJo%cuBEKLP
VpF86Z<{!)q9LfR=l9O2#A^?pP5?}xT

delta 64
zcmccTaMyv$CD<h-R)K+mv2P>SL^)1Z>6rLnr+5M1$xGxM7`-MxmHWVGH2IpmBA);k
UuRG%p<{!)q97+NVli3s^0D#^SU;qFB

diff --git a/tests/data/acpi/x86/q35/DSDT.numamem b/tests/data/acpi/x86/q35/DSDT.numamem
index df8edc05b69ecd1331973b16e534b44616b50f58..8bedc38465d8223df0a7f2360323364a2b76182c 100644
GIT binary patch
delta 65
zcmez9_{ovWCD<k8lL7++qrpZlRe4S~>6rLnr+5Ls$rkbsjNX$g<v%bQPtH<M<QL@P
Vb7%a){DYZ+Ls@`9a`H@t2mo~!5y=1m

delta 64
zcmez5_|cKeCD<k8qXGj1W8g+ERe4TV>6rLnr+5M1$rkbsj9!x~<v%bQP0mtK<P+fH
Ub!Ys+{DYZ+LrH*P@+^f20BQ>n$p8QV

diff --git a/tests/data/acpi/x86/q35/DSDT.pvpanic-isa b/tests/data/acpi/x86/q35/DSDT.pvpanic-isa
index da3ce12787c28e555b6ba5eacb26275bdd4587f1..fca1446b0cf42f156a85b8d88b02beeb07cb8c10 100644
GIT binary patch
delta 67
zcmccMbkT{+CD<h-P?3RwF?A!CygaA3VoZFnQ@nulWFvV8CI{)wCGsJRjK-5sDk$;`
Xa`Cw{{$T#W%)p^6z#uvKhe8AZU0o4j

delta 66
zcmccUbis+sCD<h-K#_rgv3w(!yga9uVoZFnQ@nuFWFvV8CV#2TCGsJRj7F1BDk$;^
WaPhh`{$T#W%)p@}z%cozLIeO(C=p=*

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count b/tests/data/acpi/x86/q35/DSDT.thread-count
index 50ca91b065d9a2ba95f97d01856865f0e7c615f6..eb8c24e5621ecd83db35c5de153d4e0b8631b2c8 100644
GIT binary patch
delta 92
zcmdm)x+|5-CD<iomk|R4qs&IGw+5VU(lPPDPVoYMlMEdgy(c>welRq4_V+d9i1+Yx
v;c>jc%E%EP>gfU`gF_s-_&MU8gMtMGx%k`}e=z@GX5dg3V33@gXcPee%HkL?

delta 72
zcmdm$x-*r_CD<iorx61KqwPknw+5W9(lPPDPVoZ1lMEdgy(T*ve&9E9_V+d9i1+Yx
c;c>jc$~c+FNP_bR^ABbQ4kZDG$w@{L03N6mfdBvi

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count2 b/tests/data/acpi/x86/q35/DSDT.thread-count2
index f460be2bf74ae512db8f24418b42e8cf2a56202d..50ed660a6cf50274ab48b28dd70b8220c8deb187 100644
GIT binary patch
delta 67
zcmdng!L+%9iOVI}CB(Refq^l1BUf4zr<-(4e6UlzfZycGCI?3E$-A09Fd9!@-K@wj
X$i?T*_=EWeGXsaR0E6V@Tg?#w%Zn8A

delta 66
zcmdno!L+G^iOVI}CB&$Ofq}7aBUf4zr>k^Ke6UlzfbZnWCI?2Z$-A09Fd9u>-K@wb
Wz{Ts%_=EWeGXsZ`0K??l%@F{-`xNs4

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm12 b/tests/data/acpi/x86/q35/DSDT.tis.tpm12
index 67ebd7c158759221b801ecb67d8562d92fa219d5..9bf0e80a9d0dd4eb8b8d3935afd9f8f88609bdc9 100644
GIT binary patch
delta 78
zcmX@<cFK**CD<jzOPPUz@$p73ZFw#ahnV<ar+5JehspNx_Kd!p>*bx8`Hh|ZeGNI{
iJv?1_951jkPJS;h#^cWTgZT$D1BbEzgXH9oN)Z5KofVh>

delta 75
zcmX@*cG8W@CD<jzQ<;H*@#{t|ZFw$thnV<ar+5K>`^on5_KZH8>*bx8`Hh_YeGNI{
fJv?1_951jkPM)JA!TE#v2QveQk^sZxPf8I0DiRd}

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm2 b/tests/data/acpi/x86/q35/DSDT.tis.tpm2
index c6b58472157d575e2625557d1346586be06b927c..382fa8f1fc5cf861392651107b4ae8ffbe7baab4 100644
GIT binary patch
delta 66
zcmaFt_QZ|LCD<h-MVWztv2P=nwmhekQ%roYQ@nuJWIK5WM)%G2@-fVe#*^<TDe?<)
W@wqepVE)0(z@aR_AUT;^IRXH62@x*<

delta 65
zcmaFj_SlWfCD<h-S($->as5UvZFx>dr<nL)r+5L+$#(J%jBcCj<ztu`jV9kwQsfih
V;&o^I!Tf`nfkR1vVKR?$1ORF(5ibA$

diff --git a/tests/data/acpi/x86/q35/DSDT.type4-count b/tests/data/acpi/x86/q35/DSDT.type4-count
index 17a64adb2055ad3168754ca121bf29851d2ee496..6cd3e70df7162a975ecc0b5c4e267baea60e9e08 100644
GIT binary patch
delta 67
zcmaDlk@49?MlP3Nmyl;33=E8x8@VLiIo+gV;)9*y1^g!KxH~X<PtJA!z-T-<&O?!3
Xkc-cq@dxt{W(E#r0S3v*y&e$&v27Cs

delta 66
zcmaDhk@4w7MlP3Nmyo9(3=E7>8@VLiIbEe=;)9*y1$-y#xH~X<P0n@yz-Tl%&O?z;
WfQ#3i@dxt{W(E!=0fxza9uWYgL=yx6

diff --git a/tests/data/acpi/x86/q35/DSDT.viot b/tests/data/acpi/x86/q35/DSDT.viot
index 6eb30e8f4b2c54e4789c649475adff356c8c58a4..bcb0e6d20287b2e71c234645c6d41a0b5564f1eb 100644
GIT binary patch
delta 65
zcmcapbhn7hCD<h-){=pNv1}ukk2$B8d`x_>Q@nuF<aqNIM(@c_%s((1PrhoQ$S=sn
V=g#<p`3Exthq3^J<YX4h2mq?}6B7Uc

delta 64
zcmcaxbf<{RCD<h-#*%@7ar#CsA9GGm`Iz`%r+5L!$?@hbj9!zUn15h2ntatlkxzh&
U*PZbP^ABbQ4kZDG$*h(U0G=ch6951J

diff --git a/tests/data/acpi/x86/q35/DSDT.xapic b/tests/data/acpi/x86/q35/DSDT.xapic
index 111bb041dc0d114351add07c040dde61643d157a..f75121de546bfa6cbf57bdd53587666b780a5b3a 100644
GIT binary patch
delta 67
zcmX>%o$35^CN7s?myq+_3=E8!8@ZUeINhXU;)9*y1^gz9b~!M5PY&z)z-T<#y<3rA
Xkc-cq@dxt{W(E#r0S3v*W!(_~(t{Kn

delta 66
zcmX><o$1_kCN7s?mymPa3=E828@ZUeI9;V<;)9*y1$-xqb~!M5O%Ch&z-Tnty<3q_
WfQ#3i@dxt{W(E!=0fx!t-4OuAZWJ5<

-- 
2.43.0


