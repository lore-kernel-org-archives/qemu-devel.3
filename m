Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B83C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 10:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urZWU-0008Rk-Ic; Thu, 28 Aug 2025 06:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1urZWH-0008K6-Nl
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 06:06:15 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1urZWF-0003V9-BM
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 06:06:13 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S9LKp33193266; Thu, 28 Aug 2025 03:06:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=uE7Bshe3Mn4Z3emcfE29xaUQyWYuWb5NF10akxGAo
 Gk=; b=gMHPyDQuYm+tHQr6U/cOnMgN60r1wN50qJ6tUl1M2qP5VsuH9OwfIlGOK
 rjA43hj7gGh6CNFyB2L6/UijtRc35y05mLO3UlTcysXrI9cm6Ex8I0xFvyjqXuIG
 UZJ9sQbgJENfB1jCppVnztlDgeh4lyOQuvc9wqURCYqh1t/tMMmD1vTow7jJUXBQ
 /zyQzWLaarEon+uZuzqdor3fXwE3TtaPsPw0MZDngERH4+TtMsJIPkg/Grf8cGFD
 1x0Rbv0OP4VBUlytGlvJnfBeyTa8mBRtVLPn2uXxaEVqjh1p3kNaMzaJPO3/wh0Q
 2RXrVEd+eNyQv2Djqx1kEn0jdZ9bg==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2105.outbound.protection.outlook.com [40.107.94.105])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48t9gyhcjr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 03:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTVOIUYAZ0UIX+uClnE84VqfDuNbkwJW3+5wkruUiuBqGuhgaoJcdrqLKIxQxSi1/T+L99utuIqiyHcCCUv7Z/2Iiul3xNQ0zDs8vGcI2nWgSo/+JVV/hshcrFbJRJUTOmTCHCCkx8ddzr7oi7k8hDfUxzJS0DCy/q/TucSQcc70dASIIwMNtpjeKKBCe5v8AeRWOIvjTQ1D6EzRpKVjbmsAIcbRM4usVFnlBHg5bVPagaTVwa3ysa16B4WdEvGXRTWRTzFrVQS/ZpGqUGM36QiaGGTOkeGXL07+qGSmkPgzu/mBs8Xz+S9wpsN0kuuheOB/j7ypD76SD6iQG1XVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uE7Bshe3Mn4Z3emcfE29xaUQyWYuWb5NF10akxGAoGk=;
 b=OQcb6ENDQ2mdI9rE4ASr9jFgBNsF248d6jbwYdad7xAJyfxZrNzxGA2RRghRkKkC/xZAQyxAn/FHVSNv8fv/Nh1si3y6e8mGtSqPUaqEymApq1/h1DVxtN9FHHOm+NFUNvI31btsv3npYcf73bajoTPKNOpyyaHzgTY6cTFl8FgoV5lUohp4iml4XNaVRibbjqdRP9PkMaP/ojaC8qkVftQLVGGKY87kSihVKXT+kxSN/E/YKZhseK+WXNS9afP5DUifl7RBEYIME0ulonYRgegNMcNVsngkBb7a7wpi5gr3wKaXj0vEUi52P6TZHSWA91rNZ3k84tmq8f2mO1wCrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uE7Bshe3Mn4Z3emcfE29xaUQyWYuWb5NF10akxGAoGk=;
 b=wkoOU4l4yeCk49QOFLPEdtsZfTFcFBLdGRmWVaZ6i0in4Ub191JM+J4QiMZvOha9PQ7U3X2uS2PNw050TyCxsjfrlYQbNPuMgOwjG80LnZMgzhqgfW74LjnwbrYo8hJUGDGFoBb3r2pnE4yaSaYHXVzd3XLG2hyDAbj5rOkaqukh3gADDTT1TU663zTgSLC8raj0Pfm0q7vd1zGWDAPCk0lQxwsIh+Ud18a6y3cogtP0k09Vg8P1jBI0frn57i5ocSarsqxTZthHAWYfaBAtg4NonQ2j0fRywxorcjPIC79wfKwb3+qkzhxSSqr/9bKuepgVlHwR9kGKLViDLz5WPg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BY5PR02MB6628.namprd02.prod.outlook.com (2603:10b6:a03:205::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 28 Aug
 2025 10:06:01 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9052.021; Thu, 28 Aug 2025
 10:06:01 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH v3 1/3] tests/functional: return output from cmd.py helpers
Date: Thu, 28 Aug 2025 11:05:53 +0100
Message-ID: <20250828100555.1893504-2-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828100555.1893504-1-john.levon@nutanix.com>
References: <20250828100555.1893504-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0050.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::12) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BY5PR02MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 0822ecdc-3727-47be-379a-08dde61a7dda
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z4ERxZg6ZeVO2YhS4EFZ8ibTu/2kjaioSKc85xIoYIE2t59Jj1g+q1z6UuIf?=
 =?us-ascii?Q?23+LiTQ2i+Yc6OPHffjPuKor9I7C4Qf7/95MxSIHmkD+xoTZ6RVzdxDsQ5Lj?=
 =?us-ascii?Q?609dzQROuiqa+QP0Q5wgiVrBFe4Tr09RyZKf71tPUofE7OCtHNUv7yz3EZ8M?=
 =?us-ascii?Q?ncTo4TTGJOX3lNtzMX8L9PSFBDvr7Hy4ZjBcz2SLlsetph1Ba+YSslHv6EkW?=
 =?us-ascii?Q?q0MctufZ+kP6pNB+UqQbg/KJNc23YFkjxT2OhElDVRo3E89tQoGoqApCI9/D?=
 =?us-ascii?Q?sjKSoXcAKG2gAU1Lqn0DcwLTgJGNfdQLm7daWlpUxmcpftS3bT2KFwZiP3nz?=
 =?us-ascii?Q?QQNIy0M3xtfxI2T3axgKPehYr2P8lp0RnG1VCqrtNdp+pe3Gyg6sINCxzmZj?=
 =?us-ascii?Q?c3/wC7l4plS3IMCy1x2V6J4f1qSRXraxrvbW6glmHNUwUwoDKyoNBWmxF6bm?=
 =?us-ascii?Q?N5VayxQ32/5xlaP3fV4rNF8kBLaq6URgc4ZvQqL/6fWpQfGQzIlJvXv+2a7V?=
 =?us-ascii?Q?VOHVAYS4iA8vWHwze6e9rCR+lpuRn2L5wWnvngM86QEURVPJGzSU+uMpsw+N?=
 =?us-ascii?Q?YavEv5NKSgqt2rwevO7C+1+vOyqD/U/waoOtily9CxK/AzSfC6ceSoXuOb70?=
 =?us-ascii?Q?++t8wBLOZiZlhChQuFqUTO2LuZ+02OQzpRx0iQAwSNd5vGy8Cis2fTpcH2jz?=
 =?us-ascii?Q?Q3laKPQfp2UhUp7zpzFvS62ZeZq/RxA4u2IZsqfbRz4IrqVaC5CSvp7qgmA1?=
 =?us-ascii?Q?jmHHoqocXdQVbnyexY2X4LfNFXgbFsTsn+GshjD4j7WC2/DvQccanFOvufLL?=
 =?us-ascii?Q?xRDreLRIJxtOKau+J+R9QcBzhLg3XPxQJUG2QY7rSEzWTFHmDwSCFd+6tEhF?=
 =?us-ascii?Q?UywEX1Ai+fsyH87pXQNg3RO28m5yi/+dMmIFmKU/PT9IblYJSEYBM0Phtf3Z?=
 =?us-ascii?Q?9mdEEKm2jgZ3qEPVEB1HPPdkL/rMMYcP6vZIhJZLAaLVnrkDDMg71UEXKLU2?=
 =?us-ascii?Q?hipVHT3KcpuT+r9Wt1BHzM2Tqld2dUaX/JWRYdSsZ/Gol46X1wI5OOiHZ/la?=
 =?us-ascii?Q?rzYHIR8jzyvqdAHAxnaM6hEVC65KF/q6Gfje6DcL8EAZW5f4Va4YMwLw0nF8?=
 =?us-ascii?Q?fKB97aOsxqSyF79x+U/wqwcHI+72bQcf8q+q3W/ED0r/q+r/ys2xEniYTDCu?=
 =?us-ascii?Q?uf1oIaAZQFgtRzY10WSB+wrMQ0QYUaMofmMdkGJkerMcU8Ro6+brrQ7hFgEm?=
 =?us-ascii?Q?7A7U8yYhZTc6fNzrG4qoudzTIEt/ciH8/Z3lP2NOd/WEmffiiFC0TKtCR7GD?=
 =?us-ascii?Q?clqzARPFLLIBBAhltj7c0JL/UW31fRixmVKGyZ7YjhDEaHnTRAmDiBgAwlSv?=
 =?us-ascii?Q?4RZ0brOqnLLbnicBAhEUuHuokoCqEs7T8CubEVd1wMJTVDXKfaCXe+DVPWOK?=
 =?us-ascii?Q?oSmfsg0DaeY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s6rEXWlWIBDIf+ndiTax23fVA1XmFUgiINSTg/xNV5cV4lMOeD8x3pCU3Lnc?=
 =?us-ascii?Q?155vNRgp9tFFigYnrqZukR0LIvysvoSINS3lfgPz6OnRkDy/LlHrD9JJJUwa?=
 =?us-ascii?Q?heKtMomxFBRAM62NX78zYVEPSEd0IhdzGxOCAJvpxVMAFTa2J37yRcE1pono?=
 =?us-ascii?Q?OpYIqDYaHqkws/3Yb6nxURCDiI6my3h7KlZEOI9AnGKaEQEIBjHnvkEDJbMz?=
 =?us-ascii?Q?P5Bmws/fEWOKBPX6Dmh7ZFbex192AiOkQ2nbnPR/OCPP3hUNtH3NOxl2XiWC?=
 =?us-ascii?Q?Nu9dTXlB4RhF1eIU0y19FPliRGbv1GasLq8HLy/QEB6H6Z/SJ/ttjDqT2yV+?=
 =?us-ascii?Q?Nl2SCAxnSE2ZHrVAeDRY3KPbNkIowuo4HVBd9aQ3t+ZnIFwlc+pHlr0952r1?=
 =?us-ascii?Q?YV//rHFESThQxZWX5t++rmBMQZf3AyH1C3ciQ8Q9ys8MmKIHcTu49X80ryKu?=
 =?us-ascii?Q?h8yH9UKv14PV+sY2fA5pWq1FoIfukd4gNdfNyjybhgGoRJkaMLOZD2VGvkz6?=
 =?us-ascii?Q?K9oZqXeno/wBgfNky6+BkiKcWbQ0zxBvLWYnj43+vshoxIPPgjfNyIgRBagr?=
 =?us-ascii?Q?A9E5XJfRyEwTizGFrokZA8vjxnPn1vg+SBHjuNrjIcAd839LF+IX9B/Wtbjl?=
 =?us-ascii?Q?vTPv0PIBNc2nBnf3p7yJ3BS8q6oOA0pxV8zss/SCH1MaYMWJQveF1Ztl5UzZ?=
 =?us-ascii?Q?X7L+w6gMzC9X7OVYEaBJZBofz1ZIw/qREnKKbtfKoL10Vg2OnPM10e5KWX3J?=
 =?us-ascii?Q?yRu+2D4gU/gN65dEjbc+xZelwU2tK0gwTyvjTXO5uqIO/oO3hs/WsVPaLfLX?=
 =?us-ascii?Q?peGdKi4T2U8aUfL3BlPPtXCsMAEtP9pXOH/xI6oqh+OKDK9GKokG83Q3aj0O?=
 =?us-ascii?Q?rUYqBM5bKRJgrwop/uZzXD+nvbhmr/cqj34aYlHcLPXZLRKS4ZRgSsFXhljY?=
 =?us-ascii?Q?U5yfxs79su59S4vRQXFoEQQGlzgKYgpLA9XS09QhpujrYTFthYi8aAeAX4c8?=
 =?us-ascii?Q?D9uVVz8n8jrUEpM0ukBZRq4azcwbslbonUFnhi7lV1mzG6m46n8+GUHZSSKI?=
 =?us-ascii?Q?cy6yMQ0mM2daIrYp5bE8uirflq/Iy4XrO3eacS0RgWNdpPnHCz0F5hi92XXw?=
 =?us-ascii?Q?Bq3pLOkLVUoqajsEYVDQt0a5/HsKQIL279nWJ8ea2fnkQrpIGMF7jC4UMFEz?=
 =?us-ascii?Q?bAAyJ74D46wnYn7hWOnLkB+fkPRe1OxBy3pHvzL5i4csLcvL5wxAPtuTcrUk?=
 =?us-ascii?Q?hsk6gKEIVx3SuF7fJfq7tBEfsBb8hcGGWsOPHG1d4+tBnHcHMW6nkE+a+sh5?=
 =?us-ascii?Q?unaBt0ELw71ouRv4tpe8F36kUnvFqCvHt0u8RG0gAAduFSy2fT37phq3oOTd?=
 =?us-ascii?Q?Bu2CRovsiZaxl1lFT9iEbzJRoHgQdbUKlZl+xLg9eQnOGpDjCTGXUb6FPKLH?=
 =?us-ascii?Q?tVKy67N+4iOwP+U6LdRRfYT+KWEucq2PBxCp9jOx416cPfaCfXJPUvOw5xNw?=
 =?us-ascii?Q?EYJA1YYa3BEY7gwwtqMPxiYa4/Wy9kgzOVRWWln/UivQFP2D2HJtUZTC+isc?=
 =?us-ascii?Q?dry2tlFQYiOVqo6FJEkhTBAAb57SnF6nxL8QFknj?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0822ecdc-3727-47be-379a-08dde61a7dda
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 10:06:01.3321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGwY0BsOL/BCDwFkZdTJ05FHJ0RSBDIYJ4cpQWfdW3cLXxY0mxYxN7Rm1F/4S3RuU1AbTa15gH0xQEHP3eoclg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6628
X-Proofpoint-ORIG-GUID: tkD5EHmDWdoC0Wr8HRHsYn6yYmuXxWES
X-Proofpoint-GUID: tkD5EHmDWdoC0Wr8HRHsYn6yYmuXxWES
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA4NCBTYWx0ZWRfX3Xuin2bwk9BB
 nRpGtAf+RG0GWQ+Jn1l2ZZk/0lCKlAbOAfLpPOYLiDjNRElkKHRat10zxeqEHZWTxf3xo6A3L47
 Em7CtQnRGc0lkyaD5PShM70jSMw9wWK1r/SCHhFvyLPJI4tlsV9VwUj/Qosja2vRQdnpnis1tgg
 EbIpHKOyxGg3HJsvLTlaxpL4sd5hIQPXa3pnXxvrN7u1dV22x7J9VMRI0a+G78JkwCPdcOUkmll
 H36hkX7UPV3nfclGD3RU8HquB8BZK1wWApoLeEEfzejYIqq8LuIDoPhCgbIMR8YkWs5OKv69ZrD
 EJyTYT3fwhD6IqDVFmn7ngKbqIbe4qvhvfxn5ghzz8Ksoz+w/jE2ZWcvxU+NiM=
X-Authority-Analysis: v=2.4 cv=ArTu3P9P c=1 sm=1 tr=0 ts=68b02a0f cx=c_pps
 a=DgGpGtaONXtiYPP+4HxLvA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=AsuM2kbEzKHZIBb9HfkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Tests might want to look at the whole output from a command execution,
as well as just logging it. Add support for this.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 tests/functional/qemu_test/cmd.py | 53 +++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index dc5f422b77..c19dfc577f 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -45,6 +45,9 @@ def is_readable_executable_file(path):
 # If end of line is seen, with neither @success or @failure
 # return False
 #
+# In both cases, also return the contents of the line (in bytes)
+# up to that point.
+#
 # If @failure is seen, then mark @test as failed
 def _console_read_line_until_match(test, vm, success, failure):
     msg = bytes([])
@@ -76,10 +79,23 @@ def _console_read_line_until_match(test, vm, success, failure):
     except:
         console_logger.debug(msg)
 
-    return done
+    return done, msg
 
 def _console_interaction(test, success_message, failure_message,
                          send_string, keep_sending=False, vm=None):
+    """
+    Interact with the console until either message is seen.
+
+    :param success_message: if this message appears, finish interaction
+    :param failure_message: if this message appears, test fails
+    :param send_string: a string to send to the console before trying
+                        to read a new line
+    :param keep_sending: keep sending the send string each time
+    :param vm: the VM to interact with
+
+    :return: The collected output (in bytes form).
+    """
+
     assert not keep_sending or send_string
     assert success_message or send_string
 
@@ -101,6 +117,8 @@ def _console_interaction(test, success_message, failure_message,
     if failure_message is not None:
         failure_message_b = failure_message.encode()
 
+    out = bytes([])
+
     while True:
         if send_string:
             vm.console_socket.sendall(send_string.encode())
@@ -113,11 +131,17 @@ def _console_interaction(test, success_message, failure_message,
                 break
             continue
 
-        if _console_read_line_until_match(test, vm,
-                                          success_message_b,
-                                          failure_message_b):
+        done, line = _console_read_line_until_match(test, vm,
+                                                    success_message_b,
+                                                    failure_message_b)
+
+        out += line
+
+        if done:
             break
 
+    return out
+
 def interrupt_interactive_console_until_pattern(test, success_message,
                                                 failure_message=None,
                                                 interrupt_string='\r'):
@@ -140,10 +164,12 @@ def interrupt_interactive_console_until_pattern(test, success_message,
     :param failure_message: if this message appears, test fails
     :param interrupt_string: a string to send to the console before trying
                              to read a new line
+
+    :return: The collected output (in bytes form).
     """
     assert success_message
-    _console_interaction(test, success_message, failure_message,
-                         interrupt_string, True)
+    return _console_interaction(test, success_message, failure_message,
+                                interrupt_string, True)
 
 def wait_for_console_pattern(test, success_message, failure_message=None,
                              vm=None):
@@ -155,9 +181,12 @@ def wait_for_console_pattern(test, success_message, failure_message=None,
     :type test: :class:`qemu_test.QemuSystemTest`
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
+
+    :return: The collected output (in bytes form).
     """
     assert success_message
-    _console_interaction(test, success_message, failure_message, None, vm=vm)
+    return _console_interaction(test, success_message, failure_message,
+                                None, vm=vm)
 
 def exec_command(test, command):
     """
@@ -168,8 +197,10 @@ def exec_command(test, command):
     :type test: :class:`qemu_test.QemuSystemTest`
     :param command: the command to send
     :type command: str
+
+    :return: The collected output (in bytes form).
     """
-    _console_interaction(test, None, None, command + '\r')
+    return _console_interaction(test, None, None, command + '\r')
 
 def exec_command_and_wait_for_pattern(test, command,
                                       success_message, failure_message=None):
@@ -184,9 +215,13 @@ def exec_command_and_wait_for_pattern(test, command,
     :param command: the command to send
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
+
+    :return: The collected output (in bytes form).
     """
     assert success_message
-    _console_interaction(test, success_message, failure_message, command + '\r')
+
+    return _console_interaction(test, success_message, failure_message,
+                                command + '\r')
 
 def get_qemu_img(test):
     test.log.debug('Looking for and selecting a qemu-img binary')
-- 
2.43.0


