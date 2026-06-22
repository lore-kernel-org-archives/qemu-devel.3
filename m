Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9497BCD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbclv-0004QC-KT; Mon, 22 Jun 2026 07:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wbclm-0004JS-Uj; Mon, 22 Jun 2026 07:24:51 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wbclj-0001Ri-Rq; Mon, 22 Jun 2026 07:24:50 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MAq4r14141595; Mon, 22 Jun 2026 04:24:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=0zhSjSSxs+i/zAV56gvprgI1Lwa0jdNlpo3l3gmA1
 cg=; b=fULywHYw7yr5GG0j08v12eqnPwIa3+tvIiGAmGdFXFlu9OAfN4seoHL1l
 F3ytZWurPY1yzCbtW/er0ZiolKFTlC1exVFKm7HzvX1Iwtdrosz2lD3UmagTyNzG
 70UTYyOSZggLMC8VxcBuJdx76goJWhbjfOBw78LQ8wf4w5uuOayrOhiFuGuSkGEZ
 yaVq6eqYLMpJtyWOh1MJgBzBAmYfDQ2LMqsA2axgtqjwwpZ9yzLp2eYfBvpckRJj
 /xQhRMAeDQcBwbMZnxsl8gfbFLqG7Mrm0sHh+N0NrlVasrff8qcK6kdZMufVgFGR
 81p+lh3GOvhFaCHITnrZmXl5VyPxQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021109.outbound.protection.outlook.com
 [40.93.194.109])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ewsxd3fa3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 04:24:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4jyfYw2n2oAy/ujHKE1rRJjEuMfpeIikVlfF/CbMD/4IGNq9r/qefhfAy0vo1Chl3rY7BCoCTqOVevaSi4FLWqNlZgHz7E2evPKS5jISvamI4RejItdPMR6q6WciYYL2qD0TYrzQatwPVdPQ/bvxVKStaaU3ZWtowCM9uv3iVvKOmmKIBPd8So2qUCvKgaJ/u0aS9dbe1MOH1I5EH1NV/no8tNMNve+1OADbOPCkD+ujQqMU6Ga/PJHy+3Q1cibnO6d/FepyuRvMQF1FElGliLahJu9Q/gbVchUnPPoemF7I1o3t4B/MXcejAXBAn4JPynPBY6z1DwxcESMQbpmvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zhSjSSxs+i/zAV56gvprgI1Lwa0jdNlpo3l3gmA1cg=;
 b=GAh7xb2ZC/lcFzotIzigU1FBKSvrzlb3c/6yiRMEbC0X8RVQAGDZWucnTih2emLMaN+XK1BMhhFv8Sq6mZbU6cVfZb2vBQfiEXTPIe3IaPtMk0/exqAI8dcEhALh3hP6bgaGXI64K+/7YCJY7INB2CjdMfpJkvb1WFI+G/oWhZZ1DfaV7dghSQcQWN/0rVwt8vUVP/3KmnTyQVABZerNwgu/0U3DMScP8XmTXeReSaB7spm8WtQw46eYXHYA58IHyRp+WGfy00mHUz8/s5bYKN6AMRIgdWeivvelsJUiMpFYMC3XG7H7eU4vJM5UpWuZXb7i3H8SJXXtfzPMzODvOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zhSjSSxs+i/zAV56gvprgI1Lwa0jdNlpo3l3gmA1cg=;
 b=aP9LRkKygYb9XWuTauuuqTvgT1GR6JrOzgGs7u6/HZ/u9ugpvapOo7TJR/wF2yqRYBI44hSV03bDOL+tZ/EdefbiEeQU+lwdvG6ILSAscuQHcy82kGHUKL3QpseIRx/AvJ1jnRkYkwClTPDMxuCRW4/TBSsAH9hUDb7BFkAV+Tt48szliUzGsHXhrrB8yjmXcEH28p1/VpNBOwtP9+K+rWfSc4KIC/Jn+KA5/AvELTOm06SUl8Q6vmKCIaQBGqiXeKb/V5CjL+5F2tsug48dFQrJJ4Svxk1QGnyDq0ru+mlZyVN4vFwuNJM9uJk8LYY3tXeR66NfavhQuFtbdvikGA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB10661.namprd02.prod.outlook.com (2603:10b6:8:1f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 11:24:30 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 11:24:30 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 6/7] hw/acpi/pcihp.c: convert ACPI_PCIHP_PROP_BSEL from object
 prop to class prop
Date: Mon, 22 Jun 2026 12:22:38 +0100
Message-ID: <20260622112403.928954-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622112403.928954-1-mark.caveayland@nutanix.com>
References: <20260622112403.928954-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR19CA0090.namprd19.prod.outlook.com
 (2603:10b6:930:83::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB10661:EE_
X-MS-Office365-Filtering-Correlation-Id: e2aa828d-7cb1-43a7-bb52-08ded050d3dd
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: C0i7tRj0QNfZetrmvm2JOuoFBjuwTjW1eau/S2JJPPR1n9Yj98rJI/YOOsgVdoIUpdA/DNe5FXfUflXZl9ZGcCj3LhnXNmiGs0CR8oZQIC22OdoLbP6wGzv0B4+6UwJQo2R2geb6lFOyEtlQy6enEFkD8nhwcWsNXJ6nKNs8ixd8P+B590v6p1pK2VFmcct2IIFuEpSdmUPI4kHEP0FjM/ZhuZ3A1qObQcIvYs+BbxVmBqLE/kRhE4IG2EUEwDP+3GYo04jSTnniJepXUeKuzOsR3pb6DAxGuLb0mjyHXApx43JFcamPtzQMEgZSelAJaLN57ogiXM0WHMgxBT9VzgRglKKKQjGFS1TM8SG9A+hMSv7IY5DZKNEQffPLCyFzyMnyQmmf9VAZWC2N6v+EQ+9igmHa+x3yMN9/S6ind6b4ThiNjcI1gG7zyY8C/cqofgDxC2DMcRVJjaIKFQI6TxZsWvnN1TDjNXrn5GbMuu7XgULEJFVaDumAC8hK2vclCXgmJAdR/hO58R8svO2v783rxGdL17Dc38bDW78NtnNUb08QMlKrRE5yPoflWupgEbobYX+ZOj01XSSZ90cGbWkXUayDtLMmmIt2UKL4DWfVplSPQqELRbomcoUH7j0ZLRWFXE0DcEbsLrR0CJ4CSvUkHR4tP6h/UHjRratQTF3zDBOiS2ABBGeLGnvSav7O9SgECniGIrfRT0wDSMOROQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yBIXp2gEuV01K1YRtjqOJOF9T6jCKsgSS7fZGdb/zrNILFxpKEsJSwPTYFOL?=
 =?us-ascii?Q?0mrZcIFiAhbU51MN3qgyIk4pLaZWYWeYuj7mJ31GbCvFZdJ6Sr1qg/a53sAQ?=
 =?us-ascii?Q?8suWm5v3z3KZFtVoVCQ+ul0n37Uf/SV6PcE82W9T04y4FKuWpkE2iTHapOV8?=
 =?us-ascii?Q?k9XcRKE4CjSIKe1jfg8zVNDVZQ1NwdBZzpeR4UEAOjNp3Km1vmmegKxjESlc?=
 =?us-ascii?Q?TOf+Gy1A/xarhXP8ZZkb3fegAn551Gw2IHm5dk3KoglRsrmv/BQaufqzH8ai?=
 =?us-ascii?Q?sNzWsRHf2axUoMRbb4WJ5vFWug32ohFqNhVXqobASlJ67QO+wH1q3TZiiagz?=
 =?us-ascii?Q?MH36S23bs1jo9vYs7ncH6ryitQds9hUuLrLrNwYZ3D3BFKlo/qRLrt+wQkya?=
 =?us-ascii?Q?qkkpTKJxPvlhnDZ4HXpMg+e86KeRXM2zYpIMAEmIUAs/PnygedRuUTBtamyb?=
 =?us-ascii?Q?W4K6lmRVzGwwBoxHvaE6hissfOGanpWMB4wgsTiC386SwZAdgy3oUgPny4Vg?=
 =?us-ascii?Q?y7n0mfp10ZJdxz1FF49BoKXGbHglzsK5mlqxQlMRG2q7lkcY3TeYo3gd6gYa?=
 =?us-ascii?Q?tKKk+56HKShy05sdqdOkK8MVUbwt3V/G3/1fWIZnvhug8ptkMQTKAYFUC+b7?=
 =?us-ascii?Q?IXY8mKk6LX7gUvwuox/OXgyI+GpRZuXUHGOKE+o5afRegA7n/cPBrSUWzJkz?=
 =?us-ascii?Q?Oxw5F46qGfvCOMio7qkbVXsf756b9tNuwMMo7BacGOvE1oheNmtFATXO8WA1?=
 =?us-ascii?Q?jYAcet1f83se2UKczQj1cro+nfGShqHNvpjsehnIZ08y8ZqZSyS/7qMjRhxp?=
 =?us-ascii?Q?UAW6aKKUwOJwYnDMq/1YfohemtrAUIFJ38CezyACqLzekMii6KHidxO6ZXmw?=
 =?us-ascii?Q?inOyp3sDsWkJb+nocsVNPRbA8mVC2w2Y39HSejxIgQN+88w8zhdJxEyRQ4wU?=
 =?us-ascii?Q?+JxXeizsbfKspZJjkQujUtdq/NsKDicKvuqOFC9YvQY6XEH34QjmTzBSE6QI?=
 =?us-ascii?Q?sfG6yAo1osbCRxjeRMAyKgUNMZjlK3ieBWco3oP+vAZOO1TjgUu4aNX1U5Pw?=
 =?us-ascii?Q?aDQoGbNlh1zCFx8aPpGbjWihZZTL+XQAL59+TTo2bu0/fqpaRj5+rYKf/xNW?=
 =?us-ascii?Q?jpyOLUsy1doFPD0ryyG72D2eq5lSwfUmUcLWCN6Uuu8W+B7biu2Mc2dlRbHK?=
 =?us-ascii?Q?usjji+YaJJLkMPH5ocXK1DFxAjOSB21hww1bYYCQnc4+X0eelT5MuH92crcj?=
 =?us-ascii?Q?NmQfZ4iMc95K4xKDHOHESyejLXlO/c8bzLHlQr3L+8cI+RK0hCd0A19VFh7x?=
 =?us-ascii?Q?RhqygsxCvOxwsRJJ2veYmllQwrDUcHWH6VdiTlpqC0Dr759Ob3GH2KzMgnGS?=
 =?us-ascii?Q?8A8a0t7iarV120SPGQILQCrwzin2EDdqKJfGhpxIa3Gf7Rfmw/M8ZV4Eu4M5?=
 =?us-ascii?Q?jkuR8yH8t3FrFRwDR0hOKMW6kREoXN3wK/KAJQKnMo/2PoBbUo0UF18NXKs6?=
 =?us-ascii?Q?g1S+YdU7H8zi2y+hSIubNDr5dJLnA5M5FC8xpHegyAJXSkF2wSf3AZ9uHTPU?=
 =?us-ascii?Q?RA12O3Nd8608i6vAjCOIVeeoGa8y0Ev4xyY9hFDk+spS+jtXIXvMeX96ngol?=
 =?us-ascii?Q?gptSJlcPC8BsGPjbjgsjo+Bh7DxR3wcXAEvG+LRdR/AJvy3zfAWMSb/+IVq4?=
 =?us-ascii?Q?h/4tHKIXIoDHhOaCpcqYhTw9jZnfUhYksWDmqIEmmOvbIQJKUTtmsk/9QZv1?=
 =?us-ascii?Q?Hf3LQhn4njldiQbUBNdfz/G6GJDRO7o=3D?=
X-Exchange-RoutingPolicyChecked: NPDw8PAE3SIMU3mbwqiBq2/7R7vm+7C/XyRgO1QvT33AV8901wAEk5Covv18CAZ/iBYaBsiJN9BvnH7zitAmz09fze7wsb3xc8qB63kQFVVUOaQ19ujvvuPJhkNOlX0OzDHnoq6JEL9ZJygmUcb5e1FEFukX3nPSoioOnMHeiRrB2lgGysLiW/4LUngREh+l/b2TFhxkrrAeug9VH0jRAbZoDP5JSskQrwONj7A2zpVQDV8AyeNX/XVAj1tOrrKYYwWTGvIeDhbJegYuRs61n3oBbWTKVUuFuGxutYnwDX5MwcQgDF71Ndo8un9IWJA/yhZh9RTCe72q0YWg2D0sFA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2aa828d-7cb1-43a7-bb52-08ded050d3dd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 11:24:30.6322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVqHMTndgEexb9kLNVhtQleDlPKfHS960udvZXgAR5z/O6/DQBvZct1ERX7NThMX5lR1fiWxaB88QRZmGA3Boz9qQx936hCSn40UfLKbNZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10661
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDExMiBTYWx0ZWRfX2sud1TfVZzMM
 38l0G+Y1dp5P5tfO2SpJiu2R4RxKu7w3ADBl0d4ChjReZVHeZYjADiTIcufRGTveSAklCXS61tE
 G7sJxsgR6grqZeOB1nzojPkKjpp+f/sdQKOvXoOXIqgcej6U74p5hFZXobrwYVVjHDcnPZ6vA29
 PXsr/ZzQ7sjwszttkFkj4mLgttkvcuiblPnEmXpKzUaxc+edysGLumlwHrula4EI8rDSH1b5bz2
 v62n+KnuPhbQN7MpDNPKCwCPha0D1ZmvhvB4CFDOLHp/YJij4PGz0H2CMS7RfWNo+PiGR6v3HzS
 TRb4ILRzq1j+Z5UAE0U7eLs6CWh+PLrBIc0y/uBXqoBNP0rosGrPbpRQ31g9aNqwFwuoHa63SgP
 slunZDjpHEEDPgKBqutzSuw2SKqmQA8o6V3VC1Q4VRnJm1dW1v15jfRaYF2n8ZBBIsWTMrIgpS3
 YQQHeQa9UuESqOMnadw==
X-Authority-Analysis: v=2.4 cv=WYg8rUhX c=1 sm=1 tr=0 ts=6a391b70 cx=c_pps
 a=mU+v3NmKB8T18PSzrq+lTA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=P6pLB9acsiBn3nJIo08A:9
X-Proofpoint-ORIG-GUID: wHwZ2JW4sJxaP1oNa-v5oeMPjSjHmvI9
X-Proofpoint-GUID: wHwZ2JW4sJxaP1oNa-v5oeMPjSjHmvI9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDExMiBTYWx0ZWRfX7f4WeWb6v5az
 WiSzSgKK8Ioz1htIeyObFwOh1RlnypjuTNZPr0AZMGIvYACAdSf/tbbkg93iW55Bd3pWWTrPa0C
 FpZPPgrbuA10Hq5Wem0TvIBktL6E328=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-18_03,2025-10-01_01
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

Move the ACPI_PCIHP_PROP_BSEL property to the PCIBus object and update all
callers accordingly.

Since the existing logic checks for the existence of the ACPI_PCIHP_PROP_BSEL
property to enable the relevant ACPI changes, set the type of the underlying
variable to int32_t with a default value of -1 indicating that the property
has not been set.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/pci/pci_bus.h |  2 ++
 hw/acpi/pci-bridge.c     |  9 ++++++++-
 hw/acpi/pcihp.c          | 32 +++++++++++++++-----------------
 hw/arm/virt-acpi-build.c |  7 ++++++-
 hw/i386/acpi-build.c     |  7 ++++++-
 hw/pci/pci.c             | 32 ++++++++++++++++++++++++++++++++
 6 files changed, 69 insertions(+), 20 deletions(-)

diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index c738446788..186a157dbc 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -56,6 +56,8 @@ struct PCIBus {
     int *irq_count;
 
     Notifier machine_done;
+
+    int32_t acpi_pcihp_bsel_val;
 };
 
 static inline bool pci_bus_is_cxl(PCIBus *bus)
diff --git a/hw/acpi/pci-bridge.c b/hw/acpi/pci-bridge.c
index 394a919479..9af939363c 100644
--- a/hw/acpi/pci-bridge.c
+++ b/hw/acpi/pci-bridge.c
@@ -23,6 +23,8 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
 
     if (!DEVICE(br)->hotplugged) {
         PCIBus *sec_bus = pci_bridge_get_sec_bus(br);
+        Error *local_err = NULL;
+        int32_t bsel;
 
         build_append_pci_bus_devices(scope, sec_bus);
 
@@ -30,9 +32,14 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
          * generate hotplug slots descriptors if
          * bridge has ACPI PCI hotplug attached,
          */
-        if (object_property_find(OBJECT(sec_bus), ACPI_PCIHP_PROP_BSEL)) {
+        bsel = object_property_get_int(OBJECT(sec_bus), ACPI_PCIHP_PROP_BSEL,
+                                       &local_err);
+
+        if (local_err == NULL && bsel >= 0) {
             build_append_pcihp_slots(scope, sec_bus);
         }
+
+        error_free(local_err);
     }
 }
 
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index a91f523c93..31822f6310 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -58,8 +58,8 @@ typedef struct AcpiPciHpFind {
 static int acpi_pcihp_get_bsel(PCIBus *bus)
 {
     Error *local_err = NULL;
-    uint64_t bsel = object_property_get_uint(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
-                                             &local_err);
+    int32_t bsel = object_property_get_int(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
+                                           &local_err);
 
     if (local_err || bsel >= ACPI_PCIHP_MAX_HOTPLUG_BUS) {
         error_free(local_err);
@@ -78,18 +78,14 @@ typedef struct {
 static void *acpi_set_bsel(PCIBus *bus, void *opaque)
 {
     BSELInfo *info = opaque;
-    unsigned *bus_bsel;
     DeviceState *br = bus->qbus.parent;
     bool is_bridge = IS_PCI_BRIDGE(br);
 
     /* hotplugged bridges can't be described in ACPI ignore them */
     if (qbus_is_hotpluggable(BUS(bus))) {
         if (!is_bridge || (!br->hotplugged && info->has_bridge_hotplug)) {
-            bus_bsel = g_malloc(sizeof *bus_bsel);
-
-            *bus_bsel = info->bsel_alloc++;
-            object_property_add_uint32_ptr(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
-                                           bus_bsel, OBJ_PROP_FLAG_READ);
+            object_property_set_int(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
+                                    info->bsel_alloc++, NULL);
         }
     }
 
@@ -730,14 +726,16 @@ bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus)
     /* If bus supports hotplug select it and notify about local events */
     bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
     if (bsel) {
-        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
-
-        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
-        aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
-                                     aml_int(1))); /* Device Check */
-        aml_append(method, aml_call2("DVNT", aml_name("PCID"),
-                                     aml_int(3))); /* Eject Request */
-        nr_notifiers++;
+        int32_t bsel_val = qnum_get_int(qobject_to(QNum, bsel));
+
+        if (bsel_val >= 0) {
+            aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
+            aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
+                                         aml_int(1))); /* Device Check */
+            aml_append(method, aml_call2("DVNT", aml_name("PCID"),
+                                         aml_int(3))); /* Eject Request */
+            nr_notifiers++;
+        }
     }
 
     /* Notify about child bus events in any case */
@@ -848,7 +846,7 @@ void build_append_pcihp_slots(Aml *parent_scope, PCIBus *bus)
     Aml *dev, *notify_method = NULL, *method;
     QObject *bsel = object_property_get_qobject(OBJECT(bus),
                         ACPI_PCIHP_PROP_BSEL, NULL);
-    uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
+    int32_t bsel_val = qnum_get_int(qobject_to(QNum, bsel));
     qobject_unref(bsel);
 
     aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)));
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3f285ff6c7..926c21324a 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1138,6 +1138,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     AcpiTable table = { .sig = "DSDT", .rev = 2, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
     Aml *pci0_scope;
+    Error *local_err = NULL;
+    int32_t bsel;
 
     acpi_table_begin(&table, table_data);
     dsdt = init_aml_allocator();
@@ -1196,9 +1198,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
     aml_append(pci0_scope, build_pci_bridge_edsm());
     build_append_pci_bus_devices(pci0_scope, vms->bus);
-    if (object_property_find(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL)) {
+    bsel = object_property_get_int(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL,
+                                   &local_err);
+    if (local_err == NULL && bsel >= 0) {
         build_append_pcihp_slots(pci0_scope, vms->bus);
     }
+    error_free(local_err);
 
     if (vms->acpi_dev) {
         bool acpi_pcihp;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2ee061558c..de196f2f4a 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1197,15 +1197,20 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     sb_scope = aml_scope("\\_SB");
     {
         Object *pci_host = acpi_get_i386_pci_host();
+        Error *local_err = NULL;
+        int32_t bsel;
 
         if (pci_host) {
             PCIBus *pbus = PCI_HOST_BRIDGE(pci_host)->bus;
             Aml *ascope = aml_scope("PCI0");
             /* Scan all PCI buses. Generate tables to support hotplug. */
             build_append_pci_bus_devices(ascope, pbus);
-            if (object_property_find(OBJECT(pbus), ACPI_PCIHP_PROP_BSEL)) {
+            bsel = object_property_get_int(OBJECT(pbus), ACPI_PCIHP_PROP_BSEL,
+                                           &local_err);
+            if (local_err == NULL && bsel >= 0) {
                 build_append_pcihp_slots(ascope, pbus);
             }
+            error_free(local_err);
             aml_append(sb_scope, ascope);
         }
     }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index cec065d108..db42b5296a 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
+#include "hw/acpi/pcihp.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
@@ -187,6 +188,8 @@ static void pci_bus_realize(BusState *qbus, Error **errp)
     bus->machine_done.notify = pcibus_machine_done;
     qemu_add_machine_init_done_notifier(&bus->machine_done);
 
+    bus->acpi_pcihp_bsel_val = -1;
+
     vmstate_register_any(NULL, &vmstate_pcibus, bus);
 }
 
@@ -283,6 +286,30 @@ static GByteArray *pci_bus_fw_cfg_gen_data(Object *obj, Error **errp)
     return byte_array;
 }
 
+static void pci_bus_get_acpi_pcihp_bsel_val(Object *obj, Visitor *v,
+                                            const char *name, void *opaque,
+                                            Error **errp)
+{
+    PCIBus *bus = PCI_BUS(obj);
+    int32_t bsel_val = bus->acpi_pcihp_bsel_val;
+
+    visit_type_int32(v, name, &bsel_val, errp);
+}
+
+static void pci_bus_set_acpi_pcihp_bsel_val(Object *obj, Visitor *v,
+                                            const char *name, void *opaque,
+                                            Error **errp)
+{
+    PCIBus *bus = PCI_BUS(obj);
+    int32_t bsel_val = bus->acpi_pcihp_bsel_val;
+
+    if (!visit_type_int32(v, name,  &bsel_val, errp)) {
+        return;
+    }
+
+    bus->acpi_pcihp_bsel_val = bsel_val;
+}
+
 static void pci_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
@@ -302,6 +329,11 @@ static void pci_bus_class_init(ObjectClass *klass, const void *data)
     pbc->numa_node = pcibus_numa_node;
 
     fwgc->get_data = pci_bus_fw_cfg_gen_data;
+
+    object_class_property_add(klass, ACPI_PCIHP_PROP_BSEL, "int32",
+                              pci_bus_get_acpi_pcihp_bsel_val,
+                              pci_bus_set_acpi_pcihp_bsel_val,
+                              NULL, NULL);
 }
 
 static const TypeInfo pci_bus_info = {
-- 
2.43.0


