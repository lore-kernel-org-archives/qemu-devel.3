Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867D5C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbBO-0007q8-BT; Thu, 27 Aug 2026 10:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBM-0007nV-SH
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:20 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBK-0001yC-G5
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:20 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RE9ajD038953
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=AULE8Y/bQNSIvnrqVqDoAzupiEsCNKH5m5FXBJwZE
 ZA=; b=g2FELdj5PSLmGtLiTqm7qAklhpYQ1Eiu/YTRRWr3+ByCiLWRAkyE1p5Tm
 xTFd5hb121CYCWVYpE78y3yvTg1sfBCzt1ySU1JWcXMf0Odj/QUDzGIh85E4HyNM
 0Q0Ib8XfGORmxMlRqJlFifkwTDwvQzl1wlpA9WANAUEE/EB5i8xsskutkzX9yqgl
 d12x4+Je8l1ejP3cfsXzET3N2cASirFntxrrdFgN1fmdv7ZtPog5tnFYSbJ80Krv
 YAllRAphDpzXAUkICrei/Aaf6SXPUI0D1MWaBb3DfXTUXIOSFvHPXu5cn1a8eMfY
 5I2dEcPbSbYnDBRtiBVoV/4Hv27HQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021095.outbound.protection.outlook.com
 [40.93.194.95])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gad5c9e2r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+M1w2FpI7I+3PUVO8+VG1H8seWvxcMzpzvdTVS31Uv2zQHYI9wcQjYID9on3ZqbVmNAkha2O6KKO8aY8oKuXk5yCEGCn3OlkDL9MHdXihroMYcSUZ/7vJM4rbJ3ohX2TUf3VclkPlMa88aZcnwXfo08ICYMvpf2cqlyWg8jqMmJTRcuZ3wtmJ8G4fmRuXehAMICEvAfbn0kp2ofyG5QCOqTPmQcDlEEJ8uLZd2VeXmL7mJ5KPfLrjUW17J3VDCtSm/QmwNUCYsiaz4XL0kIm36vdh53DlK1P4+yhW4yz5h7QbCGRMVg2dCvuWmq7CRKstQnTO0o2/NdIGEfPi2yng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AULE8Y/bQNSIvnrqVqDoAzupiEsCNKH5m5FXBJwZEZA=;
 b=HEVrLoAXNs63lm2YjUN5BaJeuPCYS2I+X9MjGkJLpc7/GQhYxRJPqSi6zAwoYVj3P2CCreBA5Vn1x7uIz5iuPaAybzQrgcgU1swtqtYUPqnkR8ibFlTPae9zNK+Yt9eZcKcbNfnIYq1yXgQIMljZNpzkaw59itgku9sVu6KELaYJpkGeX+JIbGxFEfEAt6eEqFW7oC5jxtEnMhuf2nTPjMqyVrFS69IbhEW6ErAcWNZQrTpkMU4HerVABNEp/nypx/L0rlu7KfORGCHBoGQEeMj05vLrNiWdch1ZFHUNx9CwGPtHKrFwCdpn18BquU6iNg0tv6DIM+oP7XnAqecpSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AULE8Y/bQNSIvnrqVqDoAzupiEsCNKH5m5FXBJwZEZA=;
 b=XDWrHDyQHgQPAnjyo/OBmUYeGBEO7mIM02fdpxGgLmJVXMrebJVF/H+Cyliy/4exyW5eQXJ3ujwXalAOGGvOivBHfDujIgggFKEOb+k1tpRL2N91T6a4g7XmaQLg5/hLuzXKWVi5jihbOxVPFIeR9vvsJB1YGEkBd3b5bsmpWg8jgdu1YaXkzB0z9iwjZmbtX61qj+/zDyGqaQma/jPZl/p5MoAcvvC1JfOeXmu3lUCHxOuHsCGI0rhmvWUIqZVNgPl2aTghom2uJEp/qoz0W43TXnoE9R6+8JsEDCnxciVdnf0LOt1qLIF5pA+2Fj/TZeTTYX85CpSNNKrTFg1dbQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB8114.namprd02.prod.outlook.com (2603:10b6:208:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:34:13 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:34:13 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/16] qom/object.c: introduce
 OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type) macro
Date: Thu, 27 Aug 2026 15:33:23 +0100
Message-ID: <20260827143404.1393166-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
References: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0124.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f642927-a51a-42d7-2543-08df044843ba
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PZpMlU/1HLNroV7o1QwpKXcItp8Q2NAuqMRQtyshnfpzCxvCaQJDJLnWVO68vVyLvF9PcbNQlLrTlUQG+Bg/8ryeJVjHUSkR1cGoOQe9sURyS1OTkWD4EBj450ciA0N5pdllXXtI28YDOhsZqKXV3rj6ZkmB72fawk/MAReGRZi3FJ1RMFDvNcaFGKRLEKagN9K45pFBoVT5UH+kc6+ic7rIkKXNe7Ecv3GwdmHA85mdnukxKP2IVqgJIZQNk5gA9+IabxywC2OHRXnw51HTuh4MbuHutNKfhZ0R+icDeg8Ppb6w3/jVsVQZlYjWs2zEZEMDtDcrIcZ4hvi8QKV8bLOz6JGljozcB0vc61QsmsnTkqJXKl+id2Ox8AVS4QUgrRDYJnz7v15GIb9/A6+C+mbcfZlVyVVydlL6HHiQ51DraOxOWqGSXWmpWSYVC8RLArtbI4S2Le/QsZwlQlzNjRu6gqRd9rqDwXV8nFwjqMDs9x0rOQlVWA6xXkO1JuquFypIvac/QPwuaS5qNBFcBo8SjVzUkDf3I9dDvQtrsKLMyCoccP0kDDn8DWDN1hYuk3WehLTqTQ2gpbuKjqhVI4dT+RS3coecHTDdlbfLsAtg83KHvaw1oeWOpO9GnbaaJza3D7NyTGexXvhfOnvcY4lDQx4tV+EXLb4UHLuuAcU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlFiZkJlS0xRS1lOdFNSTTUwSVlacVpqNmNHQldhWk4zVmhZSTFPQ2ZEVXBr?=
 =?utf-8?B?S0NiM2xrY2ZtU0YrNWlGdnJVRXlCZ2xxbjEwTVRnNFBueE43Ti9DSExKeHhV?=
 =?utf-8?B?WnAzeXUyOGo0aTN2L3dySUI3bjRUOGIzR2hTbUtiMEk1MUw4T0pob1NId0o4?=
 =?utf-8?B?b2U2bHoyb2p1NDMrUlhWcFUvelZhMTNuazhmemhSRzltNEtKQ2RDcU15MTJC?=
 =?utf-8?B?ejJTQXg4VmJHU0NDMjlMMnh1NE0zaTJaZG5OVkRidDAzZVE2UFVoMzBOWmJu?=
 =?utf-8?B?RFRjUlJ0MEdhc0Jzc2V4ZzdXdlY0VXFKdE5PMWhlOStJOHN2WE1INUxibG1X?=
 =?utf-8?B?YXNLWHpVeHBTYjlaa0VFZWdWVDE3ZS8yQmtXdThidmREYW50anFtdlViaUxm?=
 =?utf-8?B?UTFYSWJkQjBlYVpmT2kzeEdKZ1NkcWZXWXlDbGxhN0d1YjArK3B0UVZQYmpr?=
 =?utf-8?B?anh0N2ZPd2VpRFNmaVZDUUFETmtFaXZsUHVRUzRCbUFPbmp1S3BsVDhINXNH?=
 =?utf-8?B?ZVFhUm52d3lLSnJleTJqQmNnMGtFTXJqUzJOS3VnZzNDeXA2TmFjZE9PSFUx?=
 =?utf-8?B?NFpraWhKK1RWVkNuazg5M0xKenpUMjd6dzBvOCtJdnJnVGVDNC9tQXhxSFkw?=
 =?utf-8?B?WWRBR0dzaFduTGtndjUxUkViNEhKNGFoUDh1cmZ1UTVNcXNLZ05QUDc0NEFz?=
 =?utf-8?B?T3JEcElWaVluOHNEUFBsRWJvRUtJdm1mTzBRUmRKWE1EaEJsdHhaYmVldGhk?=
 =?utf-8?B?QzFXMnJ6ZWp6bkxGNGN2ZWkyUS9yeHNNK21WSTY0ZjVIb1h6RlpjMzUxVmN4?=
 =?utf-8?B?aE5yeG8rRVFuaDVPWlplSGJXS05CUjFwYWQ5MkFtT3U1bXdFWlZpREEyMVF2?=
 =?utf-8?B?b2tXUFdUcVUwTzFpVlZCQUpKYWE3cTlpSmY1NnQ4QU9HYXVxSG1lcnQ2ZFVz?=
 =?utf-8?B?bWVXYUdQQ2c4aXRXbGpMUDcvZGZBZkE1cE1SVmdUMlNEMzNzaHVXNnVsZFhy?=
 =?utf-8?B?dVlkRmo4UHRETUVkQWVDcGk3NnMxd0tJVlRVTU5nTFVLci9uTGNJYnhYemVM?=
 =?utf-8?B?dmxyRjJDd2NGVzhLQUxVSWtmdVhHbGxPcnNDa0xWVjY3NkRkc2pPQUpQb1ZF?=
 =?utf-8?B?ZVNsdThNMFR3TTR4TGtiYzFLQ2thZ0E2VXNkNXlTdG4yME1IWlorMWRVMU5X?=
 =?utf-8?B?d1F2ZExicTU2cDlRdmQ2MXdIdE5JYWFUZVV4Tm1ucUFHanZEeXJjbi96Tlda?=
 =?utf-8?B?QlZjcVMySkJMY3hrZ0ZZWkJvK3FIZGJLZ2hmTzlNL2tEenl6TlJBeS9BUncy?=
 =?utf-8?B?SGJMU3ZUM2lDTEtyMVptQVBRbGxYSW1OdHo4V0dudVhxWE1IanFscmV4NkQz?=
 =?utf-8?B?N2o1empMMzU5MGlIeTVScG0yM0ZIOU5SV2tBbG56OTRTWGptUVc0amF5Y01m?=
 =?utf-8?B?Z3o5VFk4SFpLL0tydEw2WVZNbzdtWU1xZnRDTUpqVEpkU1pRZWxIOXNmUlZt?=
 =?utf-8?B?ZzhBTVYvb2tzQ1FDa2VITjZ5RjRYQTN5dkI1ZEhzV2FxUm1VZVhRcEZ5NXpO?=
 =?utf-8?B?TVRxU0tvRmQzendtOGNzYmdyWHBSbTFneU9NVUNhNkRDWlU4WkR0emE0VGNG?=
 =?utf-8?B?UW1XOStuakgxenowSXhoSVR6M1F4bG15R0FqaDdlaEEwajZ3Q2graVhvQVNs?=
 =?utf-8?B?VUZEdVZYTE0zWmN0d2dsYlZ4ZlVLVGFzQkk2UTdYK3BjOENucDF0WVJmb1Y0?=
 =?utf-8?B?RFNnM2hXWUd3VDROUmduMXBHVUtHUUtzRkZuYUZWOXArYWE1MUZnSmRRclZE?=
 =?utf-8?B?SnNnYnpmR09FdkZjR0RRRGMyR2h3RGJaa0xybm1RNm9BSVhkcENSQzRTcTVk?=
 =?utf-8?B?V1QxNElzUW5saVY4Z3crOHgxaytMZE4reGg3MkhOU2hPUnI4emhReGdlTzZs?=
 =?utf-8?B?Q1BXeFk1NWtKMEhtU3p5NUgwcG03N3VLVFh2U1M4UGJXNGJJcWxvd29TcE9G?=
 =?utf-8?B?dkpXS1hnUG5YemlhMHJ6MGp2bFIzUVdNRzdpYUgwYnJsNzFRUkJjTUV4bExp?=
 =?utf-8?B?NVlsTXlMTWV1VklYQllFZjFyc1p5S0tQbk9kWStmZjR5akxvYWd4ZVp1Y0Zu?=
 =?utf-8?B?WEUvdlRjaHgzUWNDck5HRUNmbldCNHIzbllkRThmL2huclNkNlc2b3JhSmRw?=
 =?utf-8?B?Q2ExRHBpR1NXc3huU2NPYWYyMzZ1UEVxekFOWVNQNjlTUXlWZmNmbWUwNmVt?=
 =?utf-8?B?cXI4dzNmNGJzekVyNjRPUUFuYTVoWDRYY0w4cnBOeFVxaStaMmJoRmw3NXdW?=
 =?utf-8?B?VVNkS0Mrb3EzZTE1dGljcDltaFYrZFVmOUt3NkhRbWNkVUxjY2h4MXJSTFRW?=
 =?utf-8?Q?yoq1Gy80FOBWNjdo=3D?=
X-Exchange-RoutingPolicyChecked: nVKKiY1IJdcw5t+ET9DfYjE8s4sjUcBfdc/Td8kpi2UHZRhyGsQ2jYvvpzbytjLqPZxrVYkDznTzrkLtLYvqtlHUGWvsshcSH4UdGUnY8a05YtNZ/a1yuq4vTG2+zEFQ/W8fNq3CcJjE/EL/IHd7S8wo52F64zMs9PkgmXnfKjY/0uOQDr27ZDSgjfwZbXWZPBKXSDnxengTZ3p+KF9zV2uCWh6VuvkR8lF/cUjT9wbeS7MGaQRxy2ZhVW1+klMCbOo0ObG66Frr3pWQysnJvLp1I9uKH78lTRt+Q4slaqH97o0Zcd4jdP5RH1CXa2irzlmT+lHQaVD3IilVHsA7lw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f642927-a51a-42d7-2543-08df044843ba
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:34:13.0852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65eWsFhsyT3VYImDz7xKUdPZlc+kOcfyYpWuBaFFXEb9GWeCP0HeG1zTM5u6pJNg7eN736R26M3os3m//rKdmTHesaYL6VxABjhzokUWpWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8114
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX9joSyuKA4v6u
 akFBqUKMiuGr2Qc6+yMJY3fcNnntlrwkRLEmYByORqDN+Ku3m+fmBUOsW8XoPrHbPqNCwNNnY4U
 6vn/C8pnmuOUNvsN/cZ0zw/x0mSWbH0=
X-Proofpoint-ORIG-GUID: OEmorzYmwY4HfZZfUgrhRC9Fl2-Wn1rC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX4epW+Ia8zgxx
 bQ2ZpVJudkIhncHfnH24G2G9C5RPE8dECGFid0FK5sFabZRPjN4FCaWHr30oavb8pAqM4UZOEV4
 5EccQvXSkz8S4UM0pWceoVRqU6amEIktUDyRV9FI8VK4vpom8XgNfhSdvVuNl0mW3jjMaRcdBCN
 YyyTQEaiVWEcsekISA6FmFlEtaUWvXVL1wbltPEd5bz91I4bZtg00sGoeUK3NRB/I6h36UBaNIp
 UGsgAMchAwcWB4pPOLoP2ZYRMDTu+Ew7DxMyUwqYcTs7qAZ5adjCVhqmYXCpUFb9kuhIW78ICpr
 KwJLTTIPyCIdqu9zc5GBOsVLXNCaMB1mwtSrCEhUpQoMJ4Ju7COa0gMI22rTy/Vpa6kA5SyHEHO
 qrkUDW38LkdBSn+g4b+p36Od+WisKIVqwsoVv2dbsLjT7FVMOpLoFjI03t2oaIRRHX2N3nMwXHC
 YPKGwvLIlEps92LEx1Q==
X-Proofpoint-GUID: OEmorzYmwY4HfZZfUgrhRC9Fl2-Wn1rC
X-Authority-Analysis: v=2.4 cv=Me1cfZ/f c=1 sm=1 tr=0 ts=6a904ae7 cx=c_pps
 a=KKEi/m33+wCRTXJOHCufbA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=R2kG3xqjge_4VQhtPmQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-27_01,2025-10-01_01
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

This macro will be used to generate the boilerplate property_class_set_type_ptr()
QOM set function for the specified scalar type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20260825134320.1039012-3-mark.caveayland@nutanix.com>
---
 qom/object.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index e32ae30bd5..fe4e552928 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2722,7 +2722,24 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
         visit_type_##type(v, name, &value, errp); \
     }
 
+#define OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type) \
+    static void property_class_set_##type##_ptr(Object *obj, Visitor *v, \
+                                                const char *name, \
+                                                void *opaque, Error **errp) \
+    { \
+        type##_t *field = (type##_t *)object_class_prop_ptr(obj, \
+                                                        (ptrdiff_t)opaque); \
+        type##_t value; \
+        \
+        if (!visit_type_##type(v, name, &value, errp)) { \
+            return; \
+        } \
+        \
+        *field = value; \
+    }
+
 #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
+#undef OBJECT_CLASS_PROPERTY_SCALAR_SETTER
 
 
 ObjectProperty *
-- 
2.43.0


