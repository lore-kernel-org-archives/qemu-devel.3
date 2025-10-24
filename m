Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6259DCCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 13:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCHeN-0003fD-V8; Fri, 24 Oct 2025 09:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1vCHeM-0003f5-9p
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:16:10 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1vCHeH-0004Lo-2N
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:16:10 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59O1dhsK096885
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 06:16:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=EQClWcbx01iho
 V56SM3LFGMvfRYGvlytOm/13JfFVX8=; b=F4ePgoZEAq9qak7OD26bVDRDoTzA+
 cTb+TZtTGhtsVDImzwNSTkwRG7E0rudh92wRK2OWiuGOmu/bPZbOZ/7cUbr5pTnB
 OnTV27nldPf4m5IHGzoM3vudw8hKIq4SlHM9O3mRdPr/t97/Sj35VVzzXT6BNT83
 vnAu/F/D8lMzf0dexMyKuXZzJ5JlPx+S4BkQzUFU025z1uOU3QL28QNB2N9lxiu6
 3CsBd7F1NBd9Zd7X/cIKdFpGopu2DM2XJ4g+R2LSpEiLn39IwfFhgtnbhlp2L8pY
 NuYLG8+1W2xyRPhuFFz4uGGaQEdiEz2LWesYADrC/MHxaNO3q5rQnwGZA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021122.outbound.protection.outlook.com
 [40.93.194.122])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49yncgthg7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 06:16:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8gZh+7INHPDLk5glAwOgcV/HCw4kWVASjkFRXA84kvHoETGPTfCvth9nLZgslY13sIIg3v0ZCCAlDsCyLn6aH1fvbfwrCwKr79O2mRmOyc4BsPeZup4+qLqw2Wb0rwOkWtRRz85O5yNLUF5nR7kzlH8JRbYLfNpYOTg83crqvN2ge6sPItYuggCXJRHkebI/6A8eTrzb/mpjKnnI88UUZt7RKyUWyOu/ycchRPyGJ4H2J0iB/s/c8U9lzIHOamvRUh1NDNpCYFEfHcD1oAsUogx1IqnwmJwvuCvmcZK1nG5qpKXhSCSaz4LCI32CXgD65CIFpHdzlj/kkh8yECy/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQClWcbx01ihoV56SM3LFGMvfRYGvlytOm/13JfFVX8=;
 b=R+jEHr9pfftFHND3IsWkS41KZ2/+rWBL4K1n/aKf8yfiuXZbMNyTudBmnbKEpCErDxcn1EMWet42vjM0hYhm10q/PXXogxA3zBxrQjXNgRl6yd+gY4dV+A6FP6xAmhYIqf+yJlm2ZXc7AnqcHWy/Tv3uiABRWo3t/V5b3KXk9EevvEZkYq0FJNqohU/vpatKBu/XPRmOlFGpCAecRYv8A0eak9Q8dfh8AG4vfkXEpOdz8kPsHSSpwdjOqPqyGwbqR1BU8R8ItWsRCo00/J26uPq4cNcs8FGQxvQccLRYdsa1ltHqd9LbypNd6hPoRB643TmjgPbNQ102ftd2y8kZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQClWcbx01ihoV56SM3LFGMvfRYGvlytOm/13JfFVX8=;
 b=vvApE2ulS7pEiPdROa8mPVElbWfzd8tlUqtTSXMXNb/uan3OuL4YIl+4d+N1df1f3cRZqtCuLCSfmf6DnyER8JecXSSLXsU7Rfq/uj6bpc643icxsyk7edk9+DcnhMyPlAedql/HToKbMaKFKBM39LNYpcy56gZjBLe8krYVowP17IdERLZSIw/p/YyDWOyt5IcVdneBve08W50Qir7AwcZrt3dzElpYP/EpyrZda3z0nP4opSzDEhbHvqN97YJoXGJ0wCUknNM+/734q9O+ogX6Qgry43Fbaf0CNF9b3mDPiLi7VM5LHbChT4GfjtdSHOq3FkEy9OjVo9fF+os3jA==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by LV3PR02MB10643.namprd02.prod.outlook.com (2603:10b6:408:281::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 13:15:58 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::135b:f187:c695:7c90]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::135b:f187:c695:7c90%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 13:15:58 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v7 0/2] Add zerocopy partial flush support for live migrations
Date: Fri, 24 Oct 2025 13:15:41 +0000
Message-ID: <20251024131546.929499-1-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.43.7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0121.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::10) To MW6PR02MB9817.namprd02.prod.outlook.com
 (2603:10b6:303:23b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR02MB9817:EE_|LV3PR02MB10643:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e552808-907c-436a-6ebe-08de12ff785c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDI1czNXNXl1NkdOSWRqdkF3N1ZCUjVWdzZQM2YwRE1YS2xrd3ZzMEtHYmd6?=
 =?utf-8?B?YjgxenlxNE1sbkRCbDcwUE13bWMxbkE2Z0d3MC90dE9TSHMrckVQYkIvRFJV?=
 =?utf-8?B?d2R2WldoRnBiSGdJbk1lRittejhuU2lZVFNGYXhjclBSM2NMajRiMlBJclUx?=
 =?utf-8?B?QzEwbUlRQ1NvZDRBQ0wxT1FTTkMzaHVLSW5BY2lZdzVZdm5GWGRGUWFVVG1y?=
 =?utf-8?B?bTVZV2RZZUx0RVk5b3hWR2ZXc1ZISWloYmtZMHpkeCtsSmFhNzh1L3dwd2xy?=
 =?utf-8?B?V00zVndpaUFwR3RCTHg1VUZWVmx1Um9Da2l6bnNoc1ZDaEtJQTVxQW9WTFV2?=
 =?utf-8?B?VmVmV1R4dkdZVGFOdzNiZEFFSmRkRktjV1Zza3B3TlhhWU4wUWVVdk40QkFi?=
 =?utf-8?B?QmNEWTlySTJtYUFHQWdjbUtYRGRXQUM4R1d3NWZlTERDVndPZkdYV2lqRDNG?=
 =?utf-8?B?MEx6MEROZWxnQ3R1Nnd0T0EvcGxNbFVHMFBFbGxaNGdIVkJubFU3RFZlN3o0?=
 =?utf-8?B?U1NKeDZxcVlwSnU1ZGNQKzVmditUa1ArRFdhY1QyK2FPSFp4ZUVweTh4YTAw?=
 =?utf-8?B?UWF4ZzZ1UG5nSnkxb3FZdHFTcFhnZXlHemorekR4SGIxTURHK1ZDQy9uTUJW?=
 =?utf-8?B?c0hDM2tXenRrWVE1eDdHdWNhaEdqWnBUclVVVmNrTkVVMStSc0E3a0x1eGFO?=
 =?utf-8?B?T20zTGxjRytPWDBHZ09CcWdQRU5ST1p6UVoyQ2QzWk5mcWIxSDZpdFRzWUxk?=
 =?utf-8?B?YWg4L0JyZ0V0ZXVCRTdWdkc2ZmhyZUNNckZVaUlPaG9PODlEUHJwWTdxTXV3?=
 =?utf-8?B?OG9FOWZvSCtEMXhoTndIM29kcUc0Z3JWQTAyUGwrbmQrMlJxS2E0aGIvMkFS?=
 =?utf-8?B?NHZHbnJJaFRFTGVpcEdBdFdXeHVUSWpKWk5MK2NvYWxVcmUvTldJL2N3VE42?=
 =?utf-8?B?cGxWVVM1WnZnRWoyR0dpZ3Y1UUQ5aUpVSXBURDlreWI1NHZzMGFtbE1zOEor?=
 =?utf-8?B?ZWZ4eU5wYmdudnIvNFpsaUxuWFR1VmlMMW8vNzAvdU5RNDV6UFlSQWpzOVNz?=
 =?utf-8?B?YmhVaGFFdDVSY3ovRSs3Z04vaE8rbXIyaHQ2bVY3blVKaEpLWGxlYWpTWHpa?=
 =?utf-8?B?STY1a0RUQ2pubGkzRDV4RTFtVDhmbFAwbWsrRytRSTJ5T2JMVVVLdzBoN1J4?=
 =?utf-8?B?N3RSWVd5SHNoT2wyQ0tMeSs2Vjc5WGtHZGpkWC9PSSsxbGdUc3hPcjNvVXJN?=
 =?utf-8?B?UGluVFNETGZ4K0tyV2N0KzNwTTBtUXpteU9Ib21yR3lNWTNkd2R3ekV3eGk0?=
 =?utf-8?B?WlFGaFNQcXpDaWt2Zlg3VUV0RWdEenY4VkZWK0E1YjZaSjdKU1pvaExDcHZh?=
 =?utf-8?B?ZWFLa0NMd3lGcmZYZndTOFlmckN3clN5aHdJczl4ZVYvbTg1azYzbG5HcFhU?=
 =?utf-8?B?d3N5a25lTGhXek5zOTk2L0lSVTB6dWJHSk9rd0Q4WHNvOExFS0FKKzdKYlBE?=
 =?utf-8?B?NU5ZYjFJN24wK0p6N3lTYVBVeDB4SjZUL1hWVnFoN216dWd6UmJldGpqbEdZ?=
 =?utf-8?B?Z2RmK1JlS05KK2g0RGQzWFpqTXpqUS9mWW9MVnJyWkhFTjROdVdNVE51ejN1?=
 =?utf-8?B?bEJGZWJnM1YvMzZRS0ZWc1B6a3hmRTZaMjhhWTg3ckR1aUVUV1ZMaEhsRm1P?=
 =?utf-8?B?dEV2VUk4eVRNMWVyVE9BNDlmbG9pWHMrTXV3YjhQMFJQUFNTbVZNZmpmamFH?=
 =?utf-8?B?SkZBTDRKWmxOYzlBLzIzNytSV1luQU5KQmZsSW5KTHRNNWUyNWhTR2Z2d2Np?=
 =?utf-8?B?MEJ1dE01dnVaQVIyOGF0VmcwdG9jOVU0QnlKVTZrZmlYNEZLU0dEQ0JGalRN?=
 =?utf-8?B?UFBlQWpza0R2UTBSN3RaMlJmUWJ4NnoyRFF5L3dxVHNjSHIwUUd0b0FJVzVM?=
 =?utf-8?B?dHljeXdxUUZ2S3prVEVoTngrRU91SDQrMHhkTUtNbFdZd1VYNndNRTA0OG1H?=
 =?utf-8?B?UEx0RU5MeUY4Wjc0d0FPeG1DVkNjaG4vYktOS3pPeS9qcHZOWk9QOUdsZ01S?=
 =?utf-8?Q?wNG1TC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFpVL0xSKzRCZGlZYzdyby95cEpqZUhuVjF1Q2pYWCsybXQ3dytJRHZqaWRX?=
 =?utf-8?B?amNqVk9Jc0V1bE9RVmd1VUlxZEtWOGNBSjk2cHNSa2JnRWZMU1hTR25JcGJo?=
 =?utf-8?B?OFVZeEhpcGNwQmgwTlRBa1RDcWJMOUxua0RkaUNPVk5pWnlteG5IQkNtWWtO?=
 =?utf-8?B?VmllNXVVbE1HZUFKY0VBUWh2OXVwRkF5c1kxNnBBVncyQUhHbStGRUFqWFpU?=
 =?utf-8?B?OTAvT2lqRkRXVFdraXp2VHdVUm1YRGZaSXFzNk5NVGdrZk5Gcy9wNHdFMFpp?=
 =?utf-8?B?TUZ3RFRvZ0hhRnU1VEJwdjVIOUkwVlQyMENFN1VGc1M3SEVRUkFtYVlpOVZu?=
 =?utf-8?B?QmFLL2V5Y2o2cytOSHpwcXlQWDVnMjFFU01GYmtqbEVxZ3I2a05mM05pQk1a?=
 =?utf-8?B?dU9RcmdTY2dyNDluUitMNjFsZzhEN2l1YXpzSmpBeEFKWEdnWmprSExyK1M0?=
 =?utf-8?B?WjJ3TXBJM0pLdmNYK0FRQzZ4MTNMbHY3aitVd1NmWTM3b25sMHk1SHpxbnh3?=
 =?utf-8?B?WVh4L2NoSXdvOVdvaEVuUmNPUG5XNlFMY2RITHZMcjg4M3N4QXNpQ0NrMGNO?=
 =?utf-8?B?L0drQTgxM3JrZjJnbmQ3S1pPTko3TDF5L3Q1QzhaTTA2Zk9oQ3IzOVAwblRM?=
 =?utf-8?B?eTEzZ2poUDV5UnV1M0hOdVpRUkdVcSs2YUJTUEhXSDBmc2RVZkpwclBRYnQv?=
 =?utf-8?B?OVZxSUZ5L3VDYyt6UnVsUTkzUVkrZmU2REpVb1cwNEpPdytjOE1za1UxaW5y?=
 =?utf-8?B?aHpXdXRqcnZSRXd5dlJmR2VxU3JoOTRKWlIzZlJRVzR4VHQ2MWdybnN1Y1lu?=
 =?utf-8?B?SkR1MXdaQms3RzhUeWpIZmVZNXJ0VEQrOVJOUis4Uno4OFBNY1grQWJvTDBK?=
 =?utf-8?B?MVN1MDlQSHl4MUF5bG9UVzFvZWJGUk5EQW1yMXpYMVlpMGhPTTFwN2IrTEZW?=
 =?utf-8?B?K0JrN2xiOTdwbi9oaFFLMU5jTTZBYkxnVytOVlVOaEM5MnNJRUNDMXlacmUr?=
 =?utf-8?B?WlVHUS9oUTFwSy9acFA0MGt3OG5saHo4V0ZMYkZuREFDVk95ZzdDUmhKN25Z?=
 =?utf-8?B?NUx2YzVHK213V1kzTFFRNkVaZTJtR2FTSk1sM0JFZjNFcTk3aWczdW1JRlNm?=
 =?utf-8?B?SDRmdTkzcmh6WE1reVNidmhPYVBIRHBQbkVtdDBwOFJBWG5oc0FIRVhYY2ZP?=
 =?utf-8?B?MXlsZk03LzhrWklqMnZWZzVnOXZYRTEzYVB5TEdCQURhTGJ2a3A4YzJ6dzV0?=
 =?utf-8?B?OEFNR05rSXZaMVdBemxIL2tTRkdlaHhPd3VJc3pVamVrVktWR1ZjbG9DYmp5?=
 =?utf-8?B?a0hIWlptdis3cVA0Ti9ldzRRS0cyUk5XQmlPaWdMSzlRVEo5WUhPQlBDZkFR?=
 =?utf-8?B?ZHlTK1hncXZJQUtTaWF1UG01UUFvek9FVE1XemF4NytJdkdYY2txS2NhMWhB?=
 =?utf-8?B?ZFBzcEpFdVlhdmNLUVFPMTN2ekxtOFo4Q2VlUFNsbDJRQ1VxUHgzc3RNRkpD?=
 =?utf-8?B?VXRsL2Z5QjNzWUlSc3FXV1ZEdW5LaXQrb0U0eFRHdWlKL2lPTWR4RGUweHkr?=
 =?utf-8?B?bU1DdjhsM0NMSjhNYnB4SXpsbEszRmZTbVVPS0xrWFJwQTFiZUZOTmloZmNz?=
 =?utf-8?B?NU5MUmVwRi9XeXN3QkloZ3FJWlVvRFN1UElBbkhmVEdNNnJBdVNVM2IzOFFP?=
 =?utf-8?B?b3dCbko0eEJtZjFad054VGVxck9QaUY2dHdNMC9pNTZMemQycTMvYzdoeDY5?=
 =?utf-8?B?MENldGRHejVFTmR0RS9PZGxWSGxVUFJEWkZoTnpPZHl3ajREMTFqRGZHK2lh?=
 =?utf-8?B?VEVqQ2huM2d0SEtHVnhJTytDcGE0WG5rQUZSM3JkY1o4dTFjNzJvVkIyYUlU?=
 =?utf-8?B?WXpLc2dFM3ZtdGYzWVcrc0Q1TWRoanM1U093WFAycE1NVytOczRncU9TdkEv?=
 =?utf-8?B?SjJzcy9Zck9Kdm5iek5GU1ZsbVoxaElNN01UN1N6TllvZzNTQmNIeEprcTNm?=
 =?utf-8?B?aCt4ZjVwYUxRaEloWWxZZmgzUXpvM1pua1h0M1ZSSHZ4SWJ6SzZhVExMNnc0?=
 =?utf-8?B?dDhWZ290cE1HNEU1dzJlZjMzaHlZRlVQMFQ3SCtJWVR2OGhSRVVpWUF0QWF3?=
 =?utf-8?Q?DeCGY4Oku2fGLzAQRU+IpUppr?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e552808-907c-436a-6ebe-08de12ff785c
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 13:15:58.0280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAR7l1U+M/7FUukHrPNgz11HaK6Gwv6wmc/d09R0GZk0urPHMxBzBlUqLf7ZcT5TW/rspPBTv6c1z8EgRU+thA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10643
X-Proofpoint-ORIG-GUID: E0GyZBC_IBQ-3Ailkt0tpVnVpct18Qoa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI0MDExOSBTYWx0ZWRfX9OFwg+nTSDh8
 XjaEnTFZjR9sQRHYP/uNUvm3IsXFgJSW2vzV44bJNw03fiPLLyFVTSnlqy8x2VWXxXowjUktHgs
 OOHTTF/V/hIKWaxkqrLPNbz/2fKrqterjzaE/c6KfWsAk4m0c7Fwyzz6d4XH+d6XDZBW1ozC3ZE
 136gKnRCFg5Jf02HsaZVsib2neNjYv8yG1SFHXN2sE9JnuDRlvJbXb7sjRZ0P2H4bdnshm4mOH2
 2wdRr7lbCklQWi18Z6AGeHzt8jskWNH7RP1Y1rO3hRhhIt8dicjMFfMVK57ZyNOVu7ubdfyZ096
 06nY6BFSB2cYIMFNzTDGxNZWwyKjD7hj59CX+LtDYl6+qyRvfS5OIrhG5oAZXDbOCeHnkyWyWB7
 /c6v6eaqxlWsDcd6rrljLPteD63y4A==
X-Authority-Analysis: v=2.4 cv=MPFtWcZl c=1 sm=1 tr=0 ts=68fb7c11 cx=c_pps
 a=CN5Nmbld9GKaZyt1KupX+Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pB3Rj0LEYSIxIFKjaFAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: E0GyZBC_IBQ-3Ailkt0tpVnVpct18Qoa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=tejus.gk@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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

Hi all,

This series introduces support for partial flushing of the socket error
queue during a zerocopy enabled live migration. This will help reduce
live migration errors due to ENOBUFS in scenarios where a lot of
out-of-order processing may happen.

V7:
   1. Added a comment explaining the usage of G_IO_ERR on the socket error
      queue.

V6:
   1. Dropped QIO_CHANNEL_WRITE_FLAG_ZERO_COPY_FLUSH_ONCE, since it's
      redundant.

V5:
    1. Introduced a new write flag
       QIO_CHANNEL_WRITE_FLAG_ZERO_COPY_FLUSH_ONCE, which will let callers
       decide if they want to do a partial flush on an ENOBUFS.
    2. Added a "blocking" field to QIOChannelSocket, which indicates if
       the socket is in blocking mode or not.

V4:
    1. Minor nit to rename s/zero_copy_flush_pending/zerocopy_flushed_once.

V3:
    1. Add the dirty_sync_missed_zero_copy migration stat again.

V2:
    1. Removed the dirty_sync_missed_zero_copy migration stat.
    2. Made the call to qio_channel_socket_flush_internal() from
       qio_channel_socket_writev() non-blocking

regards,
tejus


Manish Mishra (1):
  QIOChannelSocket: flush zerocopy socket error queue on sendmsg failure
    due to ENOBUF

Tejus GK (1):
  QIOChannelSocket: add a "blocking" field to QIOChannelSocket

 include/io/channel-socket.h |  6 +++
 io/channel-socket.c         | 82 ++++++++++++++++++++++++++++++-------
 2 files changed, 74 insertions(+), 14 deletions(-)

-- 
2.43.7


