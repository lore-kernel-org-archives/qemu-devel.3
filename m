Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32CACAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kF6-0007uk-Kn; Thu, 25 Sep 2025 07:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDy-0006bq-Q1; Thu, 25 Sep 2025 07:33:24 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDq-0008PF-42; Thu, 25 Sep 2025 07:33:21 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P7dBZZ3781997; Thu, 25 Sep 2025 04:33:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=nvpfwfogKcWNpwvLov1Cc1W158GjBW5Sk2qqr4H6f
 FQ=; b=nbB90Al0V9wTXno8xH9TzQ5ksvnBnKJtrHweeh6GrstEHbTCwCseiITaQ
 61HmHEFg3Go/DdYRFr69hjH9lyZv7ob6OYhHuAe/ZmiAn0TRwVqQth58o3yH7d4L
 o2CBGybuOwwyICQRCCHGyxAQ5RS3FgkYvEDIiFaSddm3AdtytkEEcq4rMHzO/yFv
 hWCOcqN5Hh2aJskDOge8fJUHwf8/rQmnsTy2r1qWn3LfwxRcxGRj15bPukEEAD41
 s8Ps1sROBpwt1GvY8GA1T/+lkhdKa/om1lmWNH+E+K8yzDMHs513aK8BzYyPCZfR
 U/8VUT7xhVdA7ELs9CyLdfnm/ra7w==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023111.outbound.protection.outlook.com
 [40.107.201.111])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49d1hn0fms-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:33:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7+TX3W+5p+9ZeWrjlVNnl+xKMBKKnBiJMRqxHVcaV2rdHAeuSEOzasQOMZRTy9TeSwCynTQyJ/iR4hr+ESPh0TcWCo4UfwhY3PzNY4AZHM4LEiaH5oTCk/HMhOkn2OUfxijQHxWo3GTzARNMkGJA4uf25tTSuAox+3A9+/uHnw3HjYLVmAnbAUYp/2GbTZ60eWQpz9woXyS7egPJi8PXzTiMM+YbpisPf4vgK+v6BS4AUkerelwM0pl7eCgjQ9HP5nu9yGnJPzHboS2/QrgwYZfc0015Iu3QQiuJpdVpCazqRkre+w3/Kiy6jqlR+9VXn+x80ayDpDE1E6yEYD9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvpfwfogKcWNpwvLov1Cc1W158GjBW5Sk2qqr4H6fFQ=;
 b=i6GnoYAfQmR3SXZjnEIO5HFpb9XbzUDe5lw/rXApRcTVi20sKLQC/kQ8rTkEUrWSbleYMVYj93pNHxPD1p/2JWb0wMK6N4l/n34ZkTFeRNpzXPJMDLo4lOapGPW2/cZEr3Phf5474FurgpCg8SXY7Fmu3peCwiABRBqhO/xGRwTNPlghrcV0DW2rzGP6fny1FC8HqFQuMFdASBNgOSTaGyYgCcxyLqyjXOO3BDgecDyhPaSCJ0mbBkOnsSHA0L9kQHPZgGEZQBi5DZu7RqNVkoVZGIh6yh7pUAFGTLl+yU386B7ILQk4UDGOmJDuv2Web/05lNfQvOBBG76l0eBlYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvpfwfogKcWNpwvLov1Cc1W158GjBW5Sk2qqr4H6fFQ=;
 b=RqmPBqnxgLsTQk6vVfqnfB1kjRsbZFP4f6uAiiZvxOsfX/dcI0x0imo6zsCm5smpL1m9gCnLqR8NCyGdSOXjzje605DhKpQVZODrL0KQl7bXyBCqz3moRyzTOMQ4HOKzD0Oe7dEnzfIx1AfzkhKH1actlsZ8y/X1L5h9OTZv2p93U6iCOLbcVsaLt7IPfWsMwawCRgu3MF+yvSW4TqDywXq5wzsHH1lu/g7/MQjYA0W8YYUfYpVdmHRHNwzELLjiqyZ2jLGJ1L13JyyAsxdVapqkhmvr/iiu3Gwgz5eeORFQeSbzLYM86qfCZ+EsG2zMYtJI+P2dRVFNfPfQ/Ihh6g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9854.namprd02.prod.outlook.com (2603:10b6:208:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 11:33:01 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:33:01 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 17/28] vfio/pci.c: rename vfio_pci_base_dev_class_init() to
 vfio_pci_device_class_init()
Date: Thu, 25 Sep 2025 12:31:25 +0100
Message-ID: <20250925113159.1760317-18-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0041.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e2c7bb-fbed-4f74-77f0-08ddfc274902
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1JONVUyaWhJcXRqRHRhT3AvU09IRWhrakUrUGhPRGVaWG15UXYzNmFlNHRs?=
 =?utf-8?B?SHdnWFUwRkh2SjdpbVEzb3FaNUN2dE1pM1hTOWt1dkRSNHB4UG1QUVR1UFl3?=
 =?utf-8?B?clcvSW1OczBmSXpWN1hYV25tdStvT0FFbERkUTViMTgwbDdUMnJ5dklBcW9D?=
 =?utf-8?B?emx3ZS9yc0UvZjF1YlRSampabDFwdEJnWGhrUkRaZHJ0eEV4YUJtRENnb0dJ?=
 =?utf-8?B?VHFIb3VQT2Uway9UczBjYlowUWh6c0p5cVN0RnNSSWM2S05Wc0UyNmV1NmIw?=
 =?utf-8?B?bE1veUN3OFBISlMxb2ltS2E3cWJrVUVvY2xOanl6eDZlSTBGNEVnaVhRL2hD?=
 =?utf-8?B?UFhhemdRaWNkblh5ZFVxUDdnYXpKTVpHMWRUYXF1QmRsOTQ4YXBHQWVjSkV2?=
 =?utf-8?B?WWZYM3NYNDV5RW1ac3g2UEl5b2NSdjFPNThPY1VZbWNhTGM5cCtyRVhVR2lN?=
 =?utf-8?B?OVRxYkJsdFpibCtiNTMzVEZkVjV2OTV1ZzFUa3ZxL1h6T0w1S0tKTzlvOUZ0?=
 =?utf-8?B?NVhMTllMdDRYMHFTT2l0b2xFWlpRemhKVUdQZDZtMG50NjA2UmpsUWpvcmQr?=
 =?utf-8?B?bFU0elJFellkUjIyc1pLZHZiSFNBWnZZOWYzcCt5K1M3dzNSQkFPZ2JWdkpl?=
 =?utf-8?B?WU5DZWE1WmczVlV5TVlqQnFWY3A2eUNHWlUvNzNsdlJXZ0o0MVJzbjEzVHZT?=
 =?utf-8?B?TjVmNkFGUExrQ2JxblBWYXdKWWZhVmR2WVdLOE9mSnRVKzdDdDVyMWJGR1c5?=
 =?utf-8?B?SWJIUVZnSUxjWm5MUERrVmZsMGI1Nys0QjlmMjVjSnlkSUtzcGhRUm1EeUxo?=
 =?utf-8?B?QkJIN2VhaU5sYjZMd2RWWU93cGRGaThhUWhuSnFJcURkS3hoVWpIWDlXWUM5?=
 =?utf-8?B?TXJlUlhWZkN2T2pMaEZEeHhBUnhBNG5qbGtENVJxc2oxTHZ4RVFPNXR2bkNp?=
 =?utf-8?B?RVRSZUdtRENyR1lNeUFPZHI2NE5zU1pTQVZLTm1iTFAwSVFKRjhsNzA1OU0r?=
 =?utf-8?B?RitYMEpmK3QxQ0hHMnJTRmVjMXhaMGNReTlFSHRmelNjMFd4S0FFQU9YbTJK?=
 =?utf-8?B?aWM5Z2JpaDlTcEgweVY4K1VkTVB5YmhabVF0Yk1sSCtQRGQrQzhOMnY3NWgw?=
 =?utf-8?B?UTBQQ2ZmRGFnZnpPM3NNeDkrdEI4Zy9INVhob3RpcVZzeUZnTDJKWDYzMklU?=
 =?utf-8?B?cThmNDFkWVpwaUlvUUticnNKZjRDU0piNXBtU1k0dUxUeHBrR3JqL0o5ZzlE?=
 =?utf-8?B?RG5VNUpPNzA3Y2lFNktMME50MHNKdFVMd0QyZnF6d2tJczB1WEtkdGZVVVR5?=
 =?utf-8?B?dzE3cXZYN2dKellIbEl3Q3V2MkkwVlF2eEJEUzdkZk9WMFpZanJNc3ZlbFMw?=
 =?utf-8?B?RnFXV3VRT2ZUczZOUzVhMUszVXZwL3JQUE5ITVRPK2ova2hzM1Y5U01BR1F6?=
 =?utf-8?B?TElHNHFMeGNTWUhuckR0bTVialVXLzlwbWQwbWx4TENoZWszV20yeGJIQ2pO?=
 =?utf-8?B?R1B5ZFpmVmVNdlNpVjIrRW80dGUydDJFVEYzaGtrQzFuWVB4YVpSY003K2VP?=
 =?utf-8?B?WnQyREk2ekpoU2FZbjArWDQ5b3RGZXBOTTVlejdXVE02aGtVZERQMndkQVZx?=
 =?utf-8?B?bW93RE8yemdHa25SRjc5bThVUU11UTlwYUVGaDZ2TjFGZnpINWViUldSc1RR?=
 =?utf-8?B?cVlNRVl4RU44VGRxK25DdjkvdGdrcWlCWXhQUXBOWGZzSk91bmpETURIN0I2?=
 =?utf-8?B?RHkxOWVoNTZnMVliWVJXOWh3b1lvN0VPaGJma0ZsZ0RPMnR6K0dLZ2g2VFNt?=
 =?utf-8?B?K3pUUFpIUWVHNmNtcmZMMlUxT1kxMUtxd3RwRlNyMUVFNWs3NUFwMVFMWE9I?=
 =?utf-8?B?RU9kbkJWelE0VWhONmtyU3VDc0oyZmRFeXg0bktFUzg4WThaalk5b3puSXl2?=
 =?utf-8?B?aXVDNDRwMG9CR25ZMWRqVmVMZHVlc2RiTEF6Mk5qWUdEclR6cWYwZkVMOGJ4?=
 =?utf-8?Q?7BjGQiihQiZ9dzBPQqJ2FLoSw1zCn8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk0zVlVVYjBRdC9iMklHbi9kWEJwT3Q3cWo0alRta085alhUcU9iQjdBVkht?=
 =?utf-8?B?KzBkUDlHSktqVWV6RmlMMytsTUd4ZkhRazlOUFBQSU14cWp6MEpUUDIxaW5r?=
 =?utf-8?B?bVU3R3RZamxReWFCRWRYVFprbUV4RkMwZnNFb3lOaDZuVTVUVEZRTGdmT1RS?=
 =?utf-8?B?SkZNTHNSOHpXZzlEZDRNQTRVNzBVaXBzZHp5K1h2SENBVVJNbFQzcVl0cmc1?=
 =?utf-8?B?U3RVMVFZb2RnTzlqMXhLM1Uxd2REdWZDekRZaDJCVThoa1dqQkxkWGRScTYx?=
 =?utf-8?B?d2FNc0kxNnhHYzczMHAwUU9RUDdWSmwvL00rRDVTZm55STZ5M0d6c0liVlMw?=
 =?utf-8?B?YWR0d2J4WXN4am5UUTA2TnVTVEFvenlSQ21uMUdpVlhxdklDNXBXQzFaR0Jv?=
 =?utf-8?B?RmFCcEUvTERZVy9GZmxyRVdJZE5hK0N6d1EzbDJZOVE5MERDSktIRm0reUxL?=
 =?utf-8?B?ZVlzd3V0UklYQUcxZitUWDM5YWUzdmhMcjdvRG9uaE9QOHVFSmtrbmVXbjh0?=
 =?utf-8?B?YkpEd2V4ellsQU84VEtuNVBtcVB1RWx2SGh3eXBYaVZBdlBiS3Izay84Y1cy?=
 =?utf-8?B?d1VtQ1gxdllWTDdkUjFFVC9Ic2JxTjdQYTV1Ynl2NHhsSmN3SHAwTFBKZi9L?=
 =?utf-8?B?c1BQNTJRNVJoWlpJL0tTY2RNQkMzVjQ4SFdhdnZacGxISlM2NXR5ZjB2aGV0?=
 =?utf-8?B?RXVONXl1ZFh4T1lXT1l2WUVoaUdBcGtYZVM1d2N2bFJRU0k3S3Zab3ErOVgv?=
 =?utf-8?B?ZXlNd25ETWRRUXY2Rk9sa0I2blVhYWFSc2hMTVJ1VVZNeEdUMDliQWJaN3Zo?=
 =?utf-8?B?dXV0L2IzV1piZmpFWE9wVGp2c1FLWDZLTUZFNUp6ODh4b0wzRk5nSzBGb0M0?=
 =?utf-8?B?R01WaWk5Qld5SG1EMlA0aE1WL2FTMDQwaEJRYmdTRkY2Ty9TMUk4dVB4T1Bt?=
 =?utf-8?B?TGJDQWRNUDVxMWZoMUJoTDVFUFFhakpwMWdRMEdLdm5kNC9sRGo5SnB3cHJE?=
 =?utf-8?B?OHY1cmp3VDhTeGt3ck9SOWZ1UVJzU1NMTFNjamFMZC9vL0JVQ3crcXhGSWgz?=
 =?utf-8?B?SXJFZ3F5ZXVTelFDWEtJSzNYOTRxRERqWTRySHd5QlpiZWNCaDFBdENBS0V6?=
 =?utf-8?B?WGFpL0QrcnVTN1JoSTgza0hwbHl0d1RFZWxJWko4VXBpZ1JCVzZyVStuMFdJ?=
 =?utf-8?B?eXF4Z3VzeU9pb1QwNU9kSFI3Z3JtYXlSVUZickUxZ3VCMCtHVER1UnFYd1RH?=
 =?utf-8?B?TVA5Rkc3MUhmZmxTb2VDUFN0dXo5YitMU1JFWWI4dGh1SU9rRjlmNmlub2ha?=
 =?utf-8?B?NWgxc1NyTWlCaVdHWGZFTUg5Q283bWtGUmdjQWRHSXJVLzNtNzBodGV2Q3h2?=
 =?utf-8?B?eTFQQlFYK0V3Z1YwWmtDSTk5VGY0b21RNGNmU2RDdmxsQlFsR0tQTlVhTGFu?=
 =?utf-8?B?TTVPRllma2pKTVVNZk04a2xoY0tSbWdaZ2grY2k4djlkbmFZZkJKRzI3STBm?=
 =?utf-8?B?ZFEvR0hyL2FHSThZdFlPNEpLd3hEczVNSStSb0gvVUhUUU1FNWVGQ29naWNF?=
 =?utf-8?B?dENkWkhmdGx0Uzl5UjB0MTR3RGhYeTBackJKS252aVRMMDkzZEtqbVMzT2lX?=
 =?utf-8?B?MGFiSXowMjFLcEhuZXNzSThzNzBBVHVQYjdOemNKenZvdlh6a1Z5Rlc3Uzdw?=
 =?utf-8?B?ZTV5QlR3cXNsS25jU3B0Ums5dW83QlYvT2tSdjBUVGpmOXBWdFZ4b3RiSDcw?=
 =?utf-8?B?WXFVMXFRQjkyNElSVU1lR1c5alRNL2t1ODVHQnR1OWdXeU44a0QxeG9mdnlE?=
 =?utf-8?B?ZFFJY3FtLzlFbmY4Y2w1Vjl5WDYxRVFCL2wrdkI3emVOZHFjUHMvNTYxTUhk?=
 =?utf-8?B?SENibm4zamd2elg4MFdwWWwrSVZEbU95TjJQKzh4bTZQSjFKS1l0bVkwRTRm?=
 =?utf-8?B?THRBOWlWbytDc2JNYlJYbUJIVTBPMWNwQjRwRUhPMTRMV1dqYXB6NmlmbStY?=
 =?utf-8?B?WEZ2R2pCMnR2QTNYK1F0a3I1QmJZOTIraXk5UUdkdWJsZGVWaDM2OGExTnB2?=
 =?utf-8?B?ZHRJL25jV3ZESmtVN1dYRWZUeTR6MVdyd1NGZnlHalpRd2J1ZkYyYzZjUkd4?=
 =?utf-8?B?UWNrb3ZwVjk3WG5hR0l5TVZZTUFhVnF6VnhZZXdSbm9QK3hIRDRibysyREpU?=
 =?utf-8?B?WHRQTytwdlBFYXF3RFN5c1JyeHY4cUNwOTVEbGJUNkgrYWpyZFAwajgyYzRD?=
 =?utf-8?B?WW5qVnZLK05RWjBIUyt2MzNsUE9BPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e2c7bb-fbed-4f74-77f0-08ddfc274902
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:33:01.6193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoK04KD1vK9spH/2lPr4qhp1B9yZMz9gU0Wtu/zY0AEdcyzWh1BLEG8M5xuUyy+C/mYa9JCR/IgzFHKzkzZgROiABLTyVBuq7GTcObNYVwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9854
X-Proofpoint-GUID: oVdRucIRMKSlhHub1NJ_Hku6bjo_cVIJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfX2uMKWoqQqONv
 WYCG6n9lUS9VZRJhmIFzjoC+FhNu23CKRPsojuHjSiUHWQf+cco8YCV0iSp+LpoqkRyJfOek/kI
 VzKG8G521QbUu/ZNdOexlMDSnGWtu9Mk5UxT/4a85Rity8+IG5l49RZ/eDuL4WmPlyFOZrOlGUq
 cOHgdneY57pvzrbzBzqIK8KhT5kS9z7NIoqwabXb/NEOFDWSeGX924T6fxEvIVrwCZ7I153/AN5
 b/izJsAx6/wuC745o6nI8SXuyOU1E7V9zZxRo51a5eD943/4nego26tmZAkQxSO2vjGFwYixSSw
 MiCEzq9ndRO3oWo84U8x+ELJjB8GYYhxs9QdFC832Ra/3+Qmv4q0vjJ0qPe+R4=
X-Proofpoint-ORIG-GUID: oVdRucIRMKSlhHub1NJ_Hku6bjo_cVIJ
X-Authority-Analysis: v=2.4 cv=D6FHKuRj c=1 sm=1 tr=0 ts=68d5286f cx=c_pps
 a=wxCSDdEBtq/JR1ZGw+k+FQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=udP_5BOVWkZL6ct6w7QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

This changes the function prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index aa9d3e0354..9278b46711 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3656,7 +3656,7 @@ static void vfio_pci_init(Object *obj)
     pci_dev->cap_present |= QEMU_PCI_SKIP_RESET_ON_CPR;
 }
 
-static void vfio_pci_base_dev_class_init(ObjectClass *klass, const void *data)
+static void vfio_pci_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
@@ -3673,7 +3673,7 @@ static const TypeInfo vfio_pci_base_dev_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(VFIOPCIDevice),
     .abstract = true,
-    .class_init = vfio_pci_base_dev_class_init,
+    .class_init = vfio_pci_device_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-- 
2.43.0


