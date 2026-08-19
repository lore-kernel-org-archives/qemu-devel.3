Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEE1C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgVd-0000y1-5o; Wed, 19 Aug 2026 09:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVM-0000q4-Do; Wed, 19 Aug 2026 09:38:59 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVK-0000jd-5R; Wed, 19 Aug 2026 09:38:56 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JCmFZm394419; Wed, 19 Aug 2026 06:38:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=8IeTnYu8rXZJ7ishxjf2udAN+ikb7eE9xhtyF8G7w
 bM=; b=v7ZhKmNu5dHr/+zV1KU57raxo0GQ7M3goHjPgbztWH6TRii44jCVFWrzO
 ZLwmc/g/XEt1+5VlRJU4H3/gMPu4109vDgkm5jU8KgqaQJvWAdRNVzGGsdpmv6Q4
 A5WJm28vFjAUKEI8JdkmUOeQ0B7huKCJHdvowWaPzgb4kPF0GjzndikUw+GC7NNp
 xUWJx3n87JQDQUfvAw0FVgX0G5UhbbfzR74vrPbNIaUD0c517YttRj5vhpl6VpjK
 zw0ck7dwxO9UZKFV0577I9WU+acz+qzl2a4A2DRUOcXegYExwdYCNVFFf2MW4s0m
 Wutnsq5K/yrjtcH8e88eSUlmyD8pw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021093.outbound.protection.outlook.com
 [40.93.194.93])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g4xnxa6j7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 06:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDu+ZKdmzRZs3xa7hqNFdgQqMX++BG8m+hFeY70C7EONYi0SJ6PGHRcIJyJSJMwbojvLUzUmlTzQdNGcH3a6uDzJFJ7DBJSSMchT0LvOmJY7x0NJGpZanHv3pnmEUoVn0uPL4pWVPwVJF0al1j1LcON49TqyxC8lenZR7hdwj5We5NZODBJ0bmRdahFemhhN64rw3nn2etOtooo/SoAX5a1u4uyuYgIksS6k15nAAOOyTNNXdv26uewepr53fiGWTIqrvvZ4ogI7TaQ32Q25iNldlfoYRjkTpa8Q4uXwmL70ketU9k4Yo682V/8ASzvrkz8FUc7FlVTyIPFDEREP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IeTnYu8rXZJ7ishxjf2udAN+ikb7eE9xhtyF8G7wbM=;
 b=D2QtX72dIbggukukAYaABzBYVEmwQaPVNi6l8EgXWRhCW9LTM5PjokUyytCulOrotnjZ2DjXDxj5bBvN1gN1gZ7U1gzt+YvuuwubNcRc0HPUEQSMz3GrxI2kubWjt015ofVyK7R8NKWjXTDWXEoCuqKLWKr7Jq61V0yXls1w02D7l6SRjHV96HGE8T7cQZ/cVQRMR8DaGhtM5H8d8+CWOnnXZS1lOyOMd/NKTasUJjtcqxanoqmFzIKYhmQe/xlgkrJdw0NZI20yK04beWH1BJjCU8KvZtXTNA59YrpqEUoGHXqE1nZnMigJA2Kq4XI6h/gXW91URhjgYMxZUT0gaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IeTnYu8rXZJ7ishxjf2udAN+ikb7eE9xhtyF8G7wbM=;
 b=SDpywfgxzj+c2kWRJNtRoTgMLUxHA34JYznXdwSlIwo/BnIqpHjc7EN0q8ZBkXdwTslsEjTafQ1ROAzA5zkLuVv9H+tLJ/8MEO7UF3xKvVJfmNpoZ/0I+deUacB2hoCMZTq4GjO14kSrqpGRXEfpM0t8xkPkKwOrVJYVjMm8qtfWId/rgt+cHDKNq+1/EPqIAiOWEy70CBgu+8GfOGWH7F5vlVxI+W9qmc80iIh1wd6WK/MtWCmuUtG2CpKfkNa3f5MMNiN90I4UfieFxVJVl41SHJN4Eb/i7Dmpxx9ZX4aBNpid8NzOu1a2sgmiCYxjW44TjWaSvJnqWkTdwjLI1A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 13:38:43 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 13:38:43 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v3 06/15] hw/acpi/ich9.c: don't pass ICH9LPCPMRegs via opaque
 for ACPI_PM_PROP_GPE0_BLK prop
Date: Wed, 19 Aug 2026 14:35:45 +0100
Message-ID: <20260819133816.3497033-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0188.namprd04.prod.outlook.com
 (2603:10b6:806:126::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac618f5-4b56-4d82-83e2-08defdf72f91
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|23010399003|921020|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HCirfZS1LNrXwUTzNgQ6T2TK1bNOzaqf+ktR0qMDT9dcEU/CbyadcoN018JirRx2GmsWg/DoctsqkLhn0QtEcJGIiP3/sEeQa72elAbNuXZiB/z+KuFcKKUy7IOihXRHuCFa3SRFVt0uA3F1W83swOzIVmIji79viebiak8gW5z3A/pznkluS4kdd74CSXvQ9v/AAuQMJuVJwGdvbxQrKwHoVkyphIvAbZk24qBtdWGZwUb5GUzGlERUmx1TzUGmXhjWHF0x5tcW9VnlFicTZ5dS6ACcWx+y1pc+0Vney0xOrTcr/AGIClxzlwkxjYk12VuixqK6kHPCwgcZXsZQSDon8BiTidIZbOgzFHm8RSH2YGx+zWfX4i6CIxXDEGhZ92x8bdd2lgRYonkKpm+NI5bqf0E7/RA5T+j95HcVH1dWTlP4oVrAViTnS4lGrhzFdWiCIqhjzivFyxlbmKOYEy1H7dJBB+2iOqrXeQImbUYg5qm+S5/NWjXhjg1v/8BvlF6/g0VGrR36DD7cV44q3zsEKekoug+CO9bzZJ/69wKDMicDwnDP6LjVxavetAeI3AtbXkuBfw7OyHVCw2BLU2+7/yhQ4zjKNyuPgN0tH9R4/Oaoq1rHrclPECMxB5TuOznuFD1sKCktUY7kv8daeaQlKPkLmvnlpnhP+FecX4a3z7a4GLgP293B/ZTBcFMFBWeKlxT/xwDA1icje/KiVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(921020)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hf2KKhhu7JxOomsaOqiK43Ll4RhT4KFHv5pZ09N3de09qf39H5gwgR7xqNEN?=
 =?us-ascii?Q?4SJEVc2DwudW1gEa2x89Md7mvG3cfI3GUFeAED4yZtvqLMMGiYhqaFgWl2JA?=
 =?us-ascii?Q?WWgguTxYAAeNDtExlQOdtQfsjpMXH4yfeI0jffKMQxipiFFJFkPjmcBObU7y?=
 =?us-ascii?Q?22jimiT4GZA+Fj4vyUPVnUmXtUwNRHlx+798sglDcBGGmSp6bi9uW2lF1DD/?=
 =?us-ascii?Q?MLC4hIhCZjcFg/QFa3UlFp0qVNO+jKK6PvQ2SnjuN/xwG0WHhs0Xg6uwXoIU?=
 =?us-ascii?Q?kUxh3ma9Rzr0BGDF8H+czilD/eSbEN0k4upwMDfwgkWLmBGeKfNI3kdyfOsu?=
 =?us-ascii?Q?6oWSnWF+rB0Vz/ROxdiJFHPVFqlC1GVh5rJ0bOldcNuweu66F+TXKP0VcdMc?=
 =?us-ascii?Q?kfLt8hSNxDrjpYQvTp0bhX+3/VUtQAhkvWuX/Zft8igpln3Vr6jkAoeWkmL4?=
 =?us-ascii?Q?xu5pRAttaPao2dxvlB921LSG3JXEZwVx5XHo2rjKxoXdezX+L5JXbZ8l+Kks?=
 =?us-ascii?Q?O1kEe1caDvGBzl43KMOEgHklM5g58ZkbDAXx5wnALEtzElwGQinJg+cn3DWX?=
 =?us-ascii?Q?KxLr+qAllKVsYAZdj6FA/vcgIoZpPxpTopDnMXNADG/H98Sr9NOBRXu/M04z?=
 =?us-ascii?Q?mSNVqCW+BWSZgsWJWfv9OiRxTefMSZXx/A3NEtIu4ePD85PqZdcu8TaO/7Gn?=
 =?us-ascii?Q?VNHwPWx/nV+w5FaRPVt9/TnQfp8NU1HqUv8xsQYma0A5vwR1W5Pt8sMySTEW?=
 =?us-ascii?Q?lkfaKX6YWBPE8Fi+JbJl9rJ1da4RJF5UaUZwz8FgeIz3rxU23PO2vnZHwJxN?=
 =?us-ascii?Q?wIWGfw1Zg26Zydx5dpiksodDuk9wBwB2T0dlcNAq1HZdhJi9MpnYcUBiVGHR?=
 =?us-ascii?Q?okkVcxnMvTdF42velyz0mHQHxF9jnBB+84VJZDRnYkCW2J3aOMDY2l6d3sAL?=
 =?us-ascii?Q?CflpJ0JEDGL5NPFE7wODsLM4RU1IvF0jsLzaRtvW8h7zfyyIZETSrT/ngm7H?=
 =?us-ascii?Q?hWvArUzn5nnzVksr/F3Hn24CG/IIJtUAibkFYxPdhlJd+5xvBo8v87GfciDH?=
 =?us-ascii?Q?lBoI/oAAm9VoCpRDmbmNBFNup7LyT9FMOTbv2W4kRfjwqzNKUloGBRZGNx0m?=
 =?us-ascii?Q?Zbezn61a42Aq36CyCacaAuLwfz4YvVkMiAuTLynpCER17RXDj4K8CxBl/Iwr?=
 =?us-ascii?Q?/oMQHd0e0hWBjo7U7g/AWK4JacLnbxo6G2ZLOzSLPx3TIu71zo80H055RhSw?=
 =?us-ascii?Q?mjtOGZJek54v7ZKAvdolYAgDn8rez7CAQf47NTeNTC/ViBQ5RC3/CHPoXKwH?=
 =?us-ascii?Q?i1WZ28dTDh0XrBDRAtGinoB//6q/8jOWyJr7CMBy1AUJu8sMejcguURiCeEF?=
 =?us-ascii?Q?QNrg12mGFAx1+DiURj+3kVovHCu/vQYtCKluNe8065puVfNjRzok6IuOt41B?=
 =?us-ascii?Q?BhCn5a7bh1UX4Zvlobvuv9hY0DXEEHiFPKCsNC1FtEdoIZSUc/ZMzPbv+LfU?=
 =?us-ascii?Q?esvF5htDq5c58/cIF7OxvHhCCQSf/Ij6krQy6pcIgUBokFjcbpEkvDI5S2zC?=
 =?us-ascii?Q?a94ggGDSUYyVF0dI9PIt6CF9IVbgcbOvmRPBqzWro7eNMN+pIJG2Djq3lKlx?=
 =?us-ascii?Q?/Ssm6pLGkS31eJ4njoM6fuJP+K3aVwPmzrAX8h5//NTyHORKmfUykQVCc9th?=
 =?us-ascii?Q?XilpNmxr1evhOyO2lKIsN6ilvie8Z7h6CP/JyshnLriYx7gHZwc3ERuq0eXY?=
 =?us-ascii?Q?Ejww+P86ZrQLEhfJQyIU0PXzfUIlQsk=3D?=
X-Exchange-RoutingPolicyChecked: gsDCdX0sNDFRDOTl6leLzykvMisNpXqd7Y6qffF/gN+TzEj/1wxgRubb9HUPL8pZb4TLf60cybcyYyt5M43F+A0ehd8VpaOnxmuK9ZtTjwzDgUMly1E0yU6CnzqcAjfO1vb++2rFF3JXt5QjUNLyW4c9mshDgCOK+V8IhYOtZ66d1hOlCLluMSTkHfUWMSWxxQQOJdu7iWy7fY+gj0ewb8CTR8u8YRCv2OWkCiZcF9CsWolm/VVla3jhke0gdPiN/30H19XnATAZIOdTe/4jphcDwhmSDVun0giuoNYJJg4A40QIPsD4t/ax7hH/fQ2QYh2kk4dqb3XGV3qRvAmntA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac618f5-4b56-4d82-83e2-08defdf72f91
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 13:38:43.0769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwKiFYAwjr3NRf8a70QplcmbRHRQv85jv2/Uc2o+3nu6Z4wYFYhndRURlMxX143+jndNgUz5HMjvZCzZpr0p9biG1TPqWeNZJTMrRqL99wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7336
X-Proofpoint-ORIG-GUID: odEsQokeYN2dECzhGUrf4U6i7XFX9kmp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX/wmnLTE3zjq7
 horeF0BHTLD+2UZX3nXltSCxMjRu6udVM6Ld7oi8XhyTqcDB3L/KLCv/4+8FoUYop9J74dzEYTo
 R732GH1u8hxzWVjm3ZaPuOek3CN/oYyXq6hmDSHTmF6fOtjtXud/StNPt1U6E6Ok5Z2g2suIANO
 rAcCOet0bjI0PM6kqvcnBlPlH02RdukZb5BLPlk0eQsDRNf6BQZzX4XvoWHa+bY0N8v/sHe5BTd
 AxhIHfwjfNg9++D36QYDVFU3AC/BWKSMh7L56LhG8xbzGxDgMxCecZzB/bnjOmfV5b5o5FvSuTe
 x7wvULaCKrpEdH2grBpIARUWjLrfIPnaqdgJddtcjD11rxYrolT3S4+64107Zrk1IbUQ9IORiUV
 wYUqErhAvbdukQJWKaURNkO/g58hfMFofaV8rbvF/3ogcPxdaRtz3smTzWvDq82QN2lZjPTb6ff
 560Qx8DeTu2ekrEaIlg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX8UgIUlKrgpqH
 T6ywIrIl1EkjHmmV26qfWPrTNuPDnuhhnCEtxGMH1ekD6nKDHfbjO6hiDZgVTJrwxhBA8zsTYDD
 /C6M60BufoylSfDZlWgVD5v2neQNY10=
X-Authority-Analysis: v=2.4 cv=TfqmcxQh c=1 sm=1 tr=0 ts=6a85b1e4 cx=c_pps
 a=G8VycjxW3wO8/D/xgNJDKg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=Y-s1kumoAnAeZpE8ypgA:9
X-Proofpoint-GUID: odEsQokeYN2dECzhGUrf4U6i7XFX9kmp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

In order to convert to a class property, the ICH9LPCPMRegs instance must be
resolved by the getter/setter instead of being passed directly as an opaque.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/acpi/ich9.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 5e8f8a7eaf..ac3f452dc3 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -342,7 +342,8 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
 static void ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
-    ICH9LPCPMRegs *pm = opaque;
+    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
+    ICH9LPCPMRegs *pm = &s->pm;
     uint32_t value = pm->pm_io_base + ICH9_PMIO_GPE0_STS;
 
     visit_type_uint32(v, name, &value, errp);
@@ -411,7 +412,7 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
                              OBJ_PROP_LINK_STRONG);
     object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
                         ich9_pm_get_gpe0_blk,
-                        NULL, NULL, pm);
+                        NULL, NULL, NULL);
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
                                    &gpe0_len, OBJ_PROP_FLAG_READ);
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
-- 
2.43.0


