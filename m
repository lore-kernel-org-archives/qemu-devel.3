Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A489AD116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 09:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ0e5-00069N-J2; Mon, 01 Dec 2025 04:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQ0e1-000659-Gw
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:56:33 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQ0dz-0001vV-NN
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:56:33 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AUNapLb2237071; Mon, 1 Dec 2025 01:56:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=xutl4pGhW+zcQ
 JnGVuc2A743ISAWdOyQiIRKH2B32so=; b=0eMzxO3uP9iLoWF54kuieVEJAc+my
 I8Uoy9wcZw7M0h3P4mfQaHQqwfAvABJesvY4OSzGpl5abi9I91a1BOQFNRz35yz/
 1kS5bZw8SA0lmZs4O4WdjM7iagRp4W9LkQxxcZ3MP+pLzPFV+2H4oRYCgPnefhKz
 2DKKjNVxGijFPq/RRJSxVzMubUSG6OjA+awXNi3fMnV9sEB94oJE9sj7lHy+6iwG
 5WUDERtS/gNjd+tn5YWhnZR3G8faiJ6iFewRbpf/baOwK/seRz0Xz+5Q7qqFK/tm
 4YEDMGTJiUorb0eAKdbMUi7IrhFGSbG+TDgd8lqSTn14ZYlSh1D7PJABg==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022079.outbound.protection.outlook.com [52.101.53.79])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4aqy8camk8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 01 Dec 2025 01:56:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exB++ykivtaMlBVbS9rtiCRSfSvAzN52+kFlFav69uj67E5PyNSxp8kKtab42Ljr0DM6Vtzd7Xp+23EBs5a3KLqOODFf8XpiOY903zxbXHPHoPyi1+OaCQ8NH7jge1m7FmXK2odhh1XG0849gyTLcuq5eAWlmSVxMjnG+WwFv6zw2cYtT9yUTzFdPPuAcLk4JpvzaqrAyG8Fan0LadiYm4fl1mktNKhiSVdzIDJnyOaRTtD0EYtfNPW6YM2g2I3pMo1PrpFZyV8i/082d4/N/42mky3itE5e1wF37mWJisUZi1voScGja26S8/jP7OxxNZ4Ag8Y/d3qkYk7oyL5SEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xutl4pGhW+zcQJnGVuc2A743ISAWdOyQiIRKH2B32so=;
 b=YF17e0Y2ZnCShzLVQA0QS1nooCsKfSDjiWcI1GDSHb9MXTTEGs8J7xNAds4ZI6C029AJ3Kz5mmSnvIiSBUynp1cMGkE6+TolEC7d8wgRLgqjx8gyq3udnenWTWy2fvjZE1WwvBYBu5S6YHQ1GifoqHvYP0lIvRyrRECzmTjS6pZSztpQil24pc6/9YVo5TqPmLPl97LFTW8IxEvEJKkefHMm84QVGCmMKR8Kn1m9s3gf4nviYP2QSW9oYl7US7TUmjYx279mbt+I29UBmEYH/kN1KXJGTecFerIbwHMvQj0jYNrHfwDNqaKfsnurEftwmQFUZqOJhIkZKwSANA+ZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xutl4pGhW+zcQJnGVuc2A743ISAWdOyQiIRKH2B32so=;
 b=CLgb5LqFxkn6pgnS4DVmsr7Pt6XsfYdEvh4jEGOoQLGFEMi54KCgld0go9cWuhQX4w+k586iZpfMNeW3vbcO0gR9FUfAYf7LM8iEWQm2i7BqaHFmsNFzbcqjiv0GX7Qzw3VwQNGFnXug0dc09EoKGUKY7MWbUoNELwRILdq4QPcwbuzMTshOYUaWwWZmHKgZMDiT1XmwQj99fIKgEtGzr39NflOiiNvwGncgTVOIShAb7M8HDK2BO7EHVnvmnfVjE1RJytp99i5rxTyITWh9VnLCqXQlOmiFa2eclyYfTS6M4GJCZFZxGc3FG5GSB+cmm3g5A3xXBnJtJyhVMNHZgA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB9865.namprd02.prod.outlook.com (2603:10b6:806:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 09:56:25 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 09:56:25 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 0/5] vfio-user coverity fixes
Date: Mon,  1 Dec 2025 15:26:16 +0530
Message-ID: <20251201095621.2786318-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0576.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::23) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB9865:EE_
X-MS-Office365-Filtering-Correlation-Id: 932abd2e-e274-45c9-0517-08de30bfe39b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVVya1lpbFhxWlVYVTVwbFJCWms5cjI3YXlXdG1lZWppN1RlNTl2amVoelRy?=
 =?utf-8?B?VUltZW43SW9wOU0zZE9GcVZGdm50V1ZxZktNWjFZZ2xQMTIzWndvRG5rMXJY?=
 =?utf-8?B?c0ZGQ3JmOHdLbk5WaXhhOWRENVNtQVdzWHFJZWRmdFEzVFBXWloza0dydU5w?=
 =?utf-8?B?cTBpZnFwLzZUcC81cEFEbi91emVuM2hiQ3Q2cUN3QkNFbC9neit5cngxamVC?=
 =?utf-8?B?Tm5sMlE1bXNxVDFJSnpYUFVqMGNaU2VZOUpsbHA0aDJmN1k4cTRBeHl4VW5G?=
 =?utf-8?B?OGEwTTl6R2preU42ZUlnZjJtNDczNTB5Y1lrTFRQU21ROTA3dTF5aHVjSnZ4?=
 =?utf-8?B?bUZWMWs1Z1V4ZDNkOXJ4c2dBeDI4R3M1MlJ5Yk5NZnQxVXdNL0pkd1JFMzdE?=
 =?utf-8?B?SjBIYVorMlB3b25wc3JROUFITnUrcVVqK0c2Wmh4L2IzcVhFNGV6Y1owb1pj?=
 =?utf-8?B?YmRNVUU4dnNrT3pEVmxvMG1hWEpVTkVabFhFc2gyZm1pYnQwZnd6SE9vQzdy?=
 =?utf-8?B?eUUwWUFheHh1b0Yzd0w1TDE3dGpZL1IxdGFNSHdlbmFmaGhhSGhSL3RqMXdD?=
 =?utf-8?B?MGxDNDVQblc1R2JLcXRQMjNBYmd0ZThQcGRaUjhXbzVLajFqdG9WeXdQc0pt?=
 =?utf-8?B?aUlkVnFpM2k4VUcvUU02OUgrNE9WRjV3QkFzeGFYM2NCblozRTlobks1b0ZT?=
 =?utf-8?B?cHZXa1YvT3pFZE9wNGVtZ0hMNmkrV3V0UEZoam5ERHNFVlhzenBjZTZFTUlP?=
 =?utf-8?B?cEl1czRZbk5pKzZoUVEvb3d1SitRRnBjbk9held3RVptcWI1Sy9TL1plOGM3?=
 =?utf-8?B?R2pHajMydTBkQ0RmN0FqOGFoNHRLQUppNUV1QW5GM3N2b0lid3orb1ErWG1J?=
 =?utf-8?B?NVJSZWRPL3RMc1pjVnFoNzBaS25kOFM2cndsbHdBMzEySStCdmIwczlQT0lk?=
 =?utf-8?B?a0o2N051ZlRPbXFnaTk2MWRXTDlmY0pVNzNuY0hENlJ6cFc5SDhsK3FvUmdU?=
 =?utf-8?B?Yk9hbTFlVnJDKy9tZTYyV2JnVng0THpCV1NWYUZNUjllM3d0Nnp1b1pGaTR4?=
 =?utf-8?B?L0I5R3l2UVdSaHFMLzJRZWNWSTIvSFJZelBuSlBVTENjaXlBQnNQWmJJcFQx?=
 =?utf-8?B?QURYeW5WSE1KSkFYSHMzb2JIRFdyakFMTlVSS2JmNmxLTkovd1NacWhsUDAx?=
 =?utf-8?B?aVVuV3NFdW9xNTFRSGN4NmplRlRaYUxNYzZweVBwNHg0Mno5Y21Ob2dxaTFi?=
 =?utf-8?B?dUZIdEsyNGpGNjBKYldVU0ozQVRSTTU4cDZMdnpmanQ1VVZma0sxZWticnIv?=
 =?utf-8?B?Q29wNVl2M1puZzdVOStWSml3d093K3BaRTJ5L1RQV241NTRlZ1dyRzQ0V2Mz?=
 =?utf-8?B?ODJqWENIc1FGTE9LckJVTktqc1FGQzZrTlFSdDJnK1llMmZKSnFFUUtKMEJO?=
 =?utf-8?B?VDh1bXJpWk13TnlnNUhidjBFaDE4a1JmUEhmc0MrQUIvNmZyY3FaOUQxZnJX?=
 =?utf-8?B?cm05N09BczJCN09UTkluZm9zT004YmdySnFpUG5TMU9KUHdPZnlzQW00Rkl4?=
 =?utf-8?B?V1czcTZiNldNYStKSnE2VThBTFJLK085eUkrRkc3TnhTL0FFNnlLU1RVc2NJ?=
 =?utf-8?B?RmtIVmZBQWJiMEJVMm9NYytBUFVuL2ZmYllqRlFjTkVYY3FzWXFtUkJPM1dm?=
 =?utf-8?B?cnYzaG9RaEhyWit2ZnVrd3pEdVY0TlE5WmJETWEvK3hZKzAybWlIYmNma1JG?=
 =?utf-8?B?UmVBMHl0Q1BkLy9hM1VTbUwvVGJENmM3RWE2bWJkblYwT1lCUUpWdDlNVkd0?=
 =?utf-8?B?cWlTNTArTGtTTEYvdDErWFdJdUh5Qml3WjlVN0JmTGV6a2F6NEhHTHowL0FP?=
 =?utf-8?B?TVF6V1dZU29FdFQ2a1R1NkEzcTVJRWJ6QktpUjFIckpjVnlSQS9heVVDaXhF?=
 =?utf-8?Q?rEZHRdCfr5kn+R+oh7QFASaW8tdZcuvs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWxHNHdpVStWZlAzSzI1TmUzdEFZNjJjUXdLTkczQ2pvOC9QWXU1NEMvWUxH?=
 =?utf-8?B?M3JYdjU5MGRleUEvRUd4akJwWUE1SXhVa005eEJaL2dHOFVSYjhsR2RwUUZO?=
 =?utf-8?B?aWVMZTBUbUgyeDNQMVRuQk5SbllJdGc2MWR2RGdHRWpQU1M0VjQ0dFNLa21D?=
 =?utf-8?B?bHl6dFAycE1oY2dYVE9VYVo2eE1UdFdpeVpMTTlObDFCSjZiM0dUbmozSXFq?=
 =?utf-8?B?QmJkTlVhRHY5N2k1VDRTVFhnRHR3Q2J3Z0lLWXVrMVNnS2RoTzVhRlM4bjlU?=
 =?utf-8?B?WERvV2hIQW8xK1hlMzB6UUtJQ1pJdWVKdmpHVHVqaGNZTkhvYXVSeFYwNDdV?=
 =?utf-8?B?b3NNbWhiTmZJSk8yYjN2SXNyRGxrMXVCazc4NVJzaVVxb0pXK2tyS0kxQVo4?=
 =?utf-8?B?d2ZJUVhLTTFOcUpSQ3pqUkJVM2Fhek9DZ3JZRWZpT0E1TnFvem1UVk9zNTEy?=
 =?utf-8?B?Yk5PU3NNSy9sN3AxT082V2YzOFJUTlFYZ0dqcWJvSldXeHlhcTVzdlowMks2?=
 =?utf-8?B?MWhXT1ZrWWZiVncraXVDd3VYZmR5K1VnWHFOcnF4MitVUDc5d0ZyL2JmeWVI?=
 =?utf-8?B?Qm9MYjhHNWUwOXE0aWNheHJrYWZqUDgrYkVsQURKd241M0VFTzh3Tm5QUUcw?=
 =?utf-8?B?MUlobzBOZTh0M0NjTzJWZ3NIZkVIUXZaeVFvSkJyR2Y3RW96RkVzZURhM0RQ?=
 =?utf-8?B?RkFNZ1NrNVY4cHRzYzlUMWNyVVVEdTJvUjBaRVRoRUpubFpBVG5yMWVXbGVs?=
 =?utf-8?B?K3BaMWRlNEM5dEIvWDB0SlR0Qm0xZmVyaFN0bFArUWhhcFJuR2FES09PTHpN?=
 =?utf-8?B?UU9MVHJzT1JsZXE2cThPWHllR1FkL0F2Nmw0OTdVem44T2lRNUo5cmY5K29N?=
 =?utf-8?B?dnN5QksvdFZiZXVJNS9FZENPcktKZlZ1QzRvZHJjeDh5UW02ejdDUWF5VE1u?=
 =?utf-8?B?SFZ3WGdiVENMRFkvVythWlNmU1MreU55QzNxRVFySytIUUQyUlhORTBlZHMx?=
 =?utf-8?B?UGtmQ1NXMkVVMFpkNFhVc1FYMDZlcXBSemxSVzVsU3Q4WU5zVkJOeWg5WHlR?=
 =?utf-8?B?bkFNRVY5aitvVm9zNm80cGhaUW5Jb1hVNG5rd3NoWTZaZktGanE1SnVyczZy?=
 =?utf-8?B?ck04UFJ1ak1GbGE4V1BWNXQ5ME1zQ1M0cHNWSnUwN29zL0w0dnR0bFhoVVls?=
 =?utf-8?B?c2JwQ3FSKzhaN3IvYStEUGlUMXZJTmtQRVdpOVpHNTdIdWJxNHhzQkdXRVdW?=
 =?utf-8?B?cjVBRXplTUo0dmMvTnFuaTgybHEwRVNOZXYwNjZxNjJjVGNFc1ByaU9VUjdz?=
 =?utf-8?B?dWRkS3NnVE51MUtkSkhEMGJVTzR2UDVxLzIvWnlrMkQzLzBUeTJSSlBDaGcr?=
 =?utf-8?B?ODdQRVdvd0tVTjBieWVOMjAxeE9WZ0FxQklpS0srK1I0WS9iSDY4NmNVL0pD?=
 =?utf-8?B?WnBNZWNlZTJOUnd3NVNKNnJMZmloeFRveldHaVhOaXd3S1NjVk9sZWVIdjlw?=
 =?utf-8?B?aCsvNVpTSVBhVHh3NGd3cU1EMS9wTERjR3ZBSmd5QjV1dFQySnRWUzMrRG05?=
 =?utf-8?B?aUVURTFpYTgwOWhWWmlUbm1NcktEVjdpMEZoMkV3aWdZTDd0UEh1bmVCcnhE?=
 =?utf-8?B?SXF5YkNqV3dvNnZGOEtjWkNjckY5Q1VMdGszK0ZrYURyWHVTV2pUSlFQUzJ1?=
 =?utf-8?B?R3laNXpWZkhoWTgwZTE3eTIvSFoxSk5oaGlRbGdWRGdqa09aelQxdlBFNGZr?=
 =?utf-8?B?Ynh2SUdvcnVxa0NXLzZzWHY0MjMrdmk2MG9WTmdFVTRYT2l0eWNKZnc4dktr?=
 =?utf-8?B?bnJISHFUN3d1My9wbnlKaVcvQytHRFNONTRzRUZxOHVZSDJkV3J3a2NaQ3FK?=
 =?utf-8?B?NkRwRWcybkNvUlhVb0s0eGpBOXlLWjJ5dFh2eEhLVGJPQ2dkR3hIN2RrME9N?=
 =?utf-8?B?MmFETURrRkpTM1dZT1cxVXhvbkEzbE5VaUwrNUNQTUxad0R5TmlGRmhXdGdt?=
 =?utf-8?B?WjloTXh3S2V3cFJPQkhmbXVoRWcrcjlaQWw0Q01oMG1ZOEtsdmdibXJ1Smxr?=
 =?utf-8?B?bUJCTkc0djdPTUYyM3doaE1iMnlKOFJBSGw4bzRZSEh6a2F1SWJoTTlNYXU4?=
 =?utf-8?Q?MAXfMk/dj7b4iKYeVDRYybSMB?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932abd2e-e274-45c9-0517-08de30bfe39b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 09:56:25.1877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VH9oFjxTNynbIU5a8ZmGZhUSxJbNe5TimRZ75nmILDCIiL3U7GbOfJdI7Me2fsnHhDLYCgLmBxfzREE/uEm34A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9865
X-Proofpoint-GUID: ehPAI6PfbvZ6cXCeiQA8O4r-cuBYWti3
X-Authority-Analysis: v=2.4 cv=Q4ffIo2a c=1 sm=1 tr=0 ts=692d664b cx=c_pps
 a=Y1/fp9MKcFODYkh4PiV91Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=61wL3NVAMDne11lxUa4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ehPAI6PfbvZ6cXCeiQA8O4r-cuBYWti3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDA4MCBTYWx0ZWRfX0SCmqNlqnlyB
 5Yvgm6qA/azenKJyJSRbq92D3rgJeTZ9hGjtqbPWkgnNzYs9siUV6ZRTWYFCsWEuC3fHtB5R1mq
 rLRwo1B/vF6gBsn4C0a7iYc4qn2BCZDT6QEdL5rrW839VGAcj2TgFA7x3rq74Xo0EUmpr4Dw9Nt
 znREcz68hQpHcBDJLbK3hwbqivzds/vKaMaGv4qnPIdg9cSHmXXDCwmhZBSwZ6PfMHzo7JPrnM3
 DG+VzrVG9BaYwx3SqvUoEqUDrJD1u7SuddJ3RrlUU0CtOydiYBD+A4V86/lIorNcFZWsx+QVtnC
 Njlhah+uPeSel24s0AWnFJQsOokd17lS1LzSoG119+5B4m0YbKnawU75NzQEobX3ViuFTWly89H
 W8YB7p+W6mYDz7wv/i9YZ41WBn7FGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Fix some coverity-reported issues with error handling in vfio-user message
processing.

John Levon (5):
  vfio-user: simplify vfio_user_process()
  vfio-user: clarify partial message handling
  vfio-user: refactor out header handling
  vfio-user: simplify vfio_user_recv_one()
  vfio-user: recycle msg on failure

 hw/vfio-user/proxy.c | 204 ++++++++++++++++++++++++-------------------
 1 file changed, 113 insertions(+), 91 deletions(-)

-- 
2.43.0


