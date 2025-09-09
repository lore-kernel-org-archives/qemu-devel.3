Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791E9CAC582
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 20:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw5D5-0000VY-Hl; Tue, 09 Sep 2025 16:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uw5D1-0000UJ-LI; Tue, 09 Sep 2025 16:44:59 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uw5Cw-0008W8-1U; Tue, 09 Sep 2025 16:44:59 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 589Ess82817607; Tue, 9 Sep 2025 13:44:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=kCj9OWKk/oR8b8qAw3rQr8RH3vlUw4E7gSDqm9VaC
 hA=; b=eIXcdXKBG71bENS3Br9lGtT3DhWX4fXIOU667104GVJHJ4joPif65Kj9q
 VjOkWBSdXZZDFqh3b5L+xYGDmXdurRZ1r5RGdXLztwecQLTB7uYgJAbYf4MGDi8D
 K3uF18BNfL/8ZGxV5OVZiFQT2OMiNyP1adthKHUB4sAIntN1MRlZi3AKOr3eib+l
 x8hWJbM8sbxkUFnB9yCGvIMoAz4YMbSggpZCeYP/EFJVJvbQ8G9FNcA2NvYLHDDB
 qGweHmpqHn5akzn91gje4cQxoG3IWBuOcNXCEg4uZV9cEEDydSZWmdMij2srrcRo
 BJ1L9DWuqBdt1eoA15LBvP76aTpRw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2113.outbound.protection.outlook.com [40.107.92.113])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 492pdxrtx4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 09 Sep 2025 13:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrR4pso1tikMuGyTKGd9IBzM8gsisnnCItMtL6n0QpCSd67wbK7qhJV8zYSdChXdLIQZ9ZfOAYyDxHinoTY+ClPxTSkM4ZdMKgkGN3ot+sbEAU2QWZ1dkmzhgV/yHw8JZZwzVbuqqEuIqrZO8//Vba5ph5kRhtIiN+HcWv+KrLOb5tOltZucE+CbqXJmuAa11KjC250d1i73VhAO4mLxLEcar4RREnGYTCtVzIlSswBVNd8ye3ZwRa5HXcf2c9Nyw7VL6jLJRdcgtAtPQiwY9An4+XO3ODssDNI8EdqEELvGlMI+5qY2tdeh1PFBrjC6OFDMK8FVYO1hTgIdWDIi4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCj9OWKk/oR8b8qAw3rQr8RH3vlUw4E7gSDqm9VaChA=;
 b=AokNLwSB4dxHemYE1pJKB/aCvamACwrac/eG+KvRnLUEWVLTl4fJGj0rexPhHTlzekXa2POwMCR3eb7C6eUrMHzl/qYExL5bcb44Kv+PM3iqGHjaFivNrFwt13k6UPWW15xdvCcYIgRVoKB1cA+DDPJszxMrfdkH0iu8PA5ECpIeBgio6Qfu3WW4XKoyD8xA6QSvRrRweJ7zXlrNpE7eivCwRD9Qu3ffrUazIPHY0w8Lc0hLbAXlPCmERb2yndxcwtLxsiSDxsL6kOC7WDT2asi3HKdFVZzu2MeJOlRiEqCoy6qICvxCNimR+5D8GWOc/CHBJ99GHqPh4OGKZSPr5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCj9OWKk/oR8b8qAw3rQr8RH3vlUw4E7gSDqm9VaChA=;
 b=kGFzS7HnozFqyB8YYNI+CzF++6bM8hw4zQi2AxMb/QRZWpPOU7R/JeCs2ZNc8b778a5jCu6C9eaXRTXK7Qku0PwWY0MOAPsMbfFWH5OVwIU4pW+WV5Zw93PP9szNDKLGCoAv+EK8aUNm43QPG+16tCTDYJ72+DcUmP4EszDQHYygqNq3yeyZ5RKhl5yGrqzCWi1KN4WR3i6xs4neGVFkhb+qcq523ufp5P5jF442WqQxqz7xB+Sulmh81Ytq/1tfyDvQVCuAvNKR231Pq3wdoRTe/FH7lBWx5AhKxrmaBmUAcatpMas45NUQZKBp66PDzjHAbOXstdA2AXvWQpTAOg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB8401.namprd02.prod.outlook.com (2603:10b6:a03:3f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Tue, 9 Sep
 2025 20:44:40 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 20:44:40 +0000
Message-ID: <402bb470-a51f-47a2-b5a7-07914023d5b3@nutanix.com>
Date: Tue, 9 Sep 2025 21:44:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/22] vfio/pci.h: use QOM casts where appropriate
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-16-mark.caveayland@nutanix.com>
 <47404bbe-dd6a-436a-83f5-5eb235d0c40a@redhat.com>
 <e5c210e9-50cb-4434-b3c1-79409c5ad6c3@nutanix.com>
Content-Language: en-US
In-Reply-To: <e5c210e9-50cb-4434-b3c1-79409c5ad6c3@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0212.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c9eb3e1-c79e-4997-ce50-08ddefe1b28a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SG16Uk9PQS94RjBpa3Nxc3lQdm1YZGV2bVZDWXFIVTA4b1pGT2tzbzc2VENE?=
 =?utf-8?B?T3cvem9tcHloMXUzVzlsVlc1RUNZQ1RzVmd3bHlBYS9UQkp2QnpGSzltZzdh?=
 =?utf-8?B?MGFTK2YxNVJIQTlVQW8xc1hQRlYzazJxU2tWd25SMXZ2WWw3Z2RLVFRsWW1a?=
 =?utf-8?B?SVJsc2lyTGJGcFc4eW5ONy9jYlVUamo0d1Q4WGNrVjdGR0dkdHZzSVErTDVE?=
 =?utf-8?B?Z202Y0ZiRFpvdWZFTzRNV3pYYjEwK01IUWxzTlV4MVFGZ2pWbzZJZVlLSzdi?=
 =?utf-8?B?ZVo0YUxLLzNRRHVhQXpkT0JQSE1nZmk5dk1YOWJBUWRFNWlheFR4dHp4M21N?=
 =?utf-8?B?WE9jcWNlRzZBRGdDb29qOC9NbUQvdXI1Yjhla3BVZ1lQYTR3SzNrVEl2OHhF?=
 =?utf-8?B?dnRXUUREbVcvNkRFTEhiUjNkbjNzMEZQbzVHdGE5cmFxM29JK09xUjA0M2t5?=
 =?utf-8?B?dW82L01udDR1dThuUUFmRjh6Yi85QmZzRnZCTXB5OS8xVVUyMCtvU2dYQUhy?=
 =?utf-8?B?Q01DM3VpNXVhVEdLUGpmTHFOWWoyY2tVTEw5Ym1oVGxTSWxYZE9aMTFBdDg2?=
 =?utf-8?B?UXl2SFhvVkpJMmkwUVZwWTBPcmhvQUI3Wk9GVHRBSmhxOEd1aHk5QnpRakdV?=
 =?utf-8?B?T0w5QWZLdXpkL09keWR4K2pwNVpKQnh3OHczUGN6ckU3QmFyYlRlRFIzRGti?=
 =?utf-8?B?N1hPcEt0WTlXekNMaFZmN21pNHhid3hZeFcxNkR2WVVBWlRKWll2WWdqRjFB?=
 =?utf-8?B?ZnBQMWVYWkRDd3ZXYWwrYzFPdlZDb2o0alNUc2hHaHhya1dMZFFzaDZ4R2Er?=
 =?utf-8?B?a1d3UW01OTl5WU55TU9vRExFaGdpZ1ZoajhwSjk5R3B2bmFuSGdQRVF1ZjFz?=
 =?utf-8?B?WlFjeS9NRHZHaXdJMy8vQll4cjNiUXNXUmhoTEJLaVZPVlp0ZCtQZDZ6ZEQr?=
 =?utf-8?B?SkxhN05TeExSU1M3eWpZWE9NSTJpYVRQZU1vU2I2eGNORTZyaGdtNnBSZ2sw?=
 =?utf-8?B?M2hFMHVocVpWUElWY1lGUEhDZ05kNlVUYlArQk5rVHhGZGpOWjBmVW1mczZo?=
 =?utf-8?B?amlEUE9VWVZQa2NvVDd3RnZkcW1NeTRKVTErSk9STWR3eVA4TkdKVURDeXNU?=
 =?utf-8?B?NlRNb2t1bjExc05xZ0R5NnRCYVk4U0YwV0hrdGQ0QXFJcm5JOVRvQ3ZYcnRq?=
 =?utf-8?B?c1NubU45aTQ1YlR4NzMvNXRwQXJCdkp6VmFZWnY1cEFCNXZ5VFlqVWJBV0pT?=
 =?utf-8?B?dlc5MnRkbWpmZm5iRndFeFZHWW1YZjhPQWRaTUV3NmltRmRNeE81QS9aQVFZ?=
 =?utf-8?B?cXRSZTJ6YXVDS0Z6a1RWdWd6eXVlT3R1OVJEU0RjVC9ZZjE2ZVdqOTFwMkdB?=
 =?utf-8?B?NEV4K3JCK2lDcU41SC9wQ2I5MXFsa29SZGFKL3JxeFA4Mms1ZWg5alBZUnAx?=
 =?utf-8?B?Ti9tcFpwd0F1eHNRdGJqZllEK3EyWGNzdW1NRERpcDE5UGFsU2dTUHcvMXRa?=
 =?utf-8?B?VlJyRlFUMHdNbHd3VlhNTk9KaXdzU1FMbkhJR3BjNmhWYjgvVTV0QmdsUTZz?=
 =?utf-8?B?R0xqdnBWTTB4N2lEVUxLMmI5NDZmbVVYdUJoTlEyRnRDSlY1ZnJ6QWlFbzNV?=
 =?utf-8?B?VUg1UGtycUVFcWUrNlJTcjlIT1FxaGhvZlYvbTlJOVplMTAzaC9uMHd5ek9l?=
 =?utf-8?B?QWZqM3pWaXdRbkR2MlJXRjNtK1lWZ29pS1RxMDBUOTlyR1lBSVJBRjh6cGxT?=
 =?utf-8?B?QzBWT25wZDlSZjB0ZXIrZmdUcjVhTS9NaVNYay9FdmRIQU56SlhyaWlkT1R5?=
 =?utf-8?B?d01IVm5EWEI1SGFCNXkwUUg5VmZ6QzcwMmFxUllYdEV4QW5hb3ljdDJVNG5u?=
 =?utf-8?B?dXgvWmdaUXIxekVRSVBScG9GeGNLUTdsOWQ2amR1VWp6MGlQWVNaZ0l3Wldh?=
 =?utf-8?B?NDB3MXRqdzlLTnk4bEFvRGovSnpGcmE1dEdFTzV4SFkvSlVPMi9VMWVpUlZ0?=
 =?utf-8?B?OHVtZmNwY3ZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEVralhkUVByUnNQSFB1enJPR1E4SDRVMG9yOVZUUXgrOVVZTmVFeWthZWw5?=
 =?utf-8?B?eXczblRZU3VNbnRtb09NbE14MEQ0SU9ULzc3VlJHTkI3dTV1dEFYN2I1cHRt?=
 =?utf-8?B?SzFQRkFqanQ1TGx2R0hiSTFTZlI0MzNDODlpK2NFbXljcCtBcFRURmtYV3Y0?=
 =?utf-8?B?d0FYNkIyczEwSWlBY2hEdG1Nb0RUOXU3S1hXVnZKVnFRQnVwS0xPT2pQTEkr?=
 =?utf-8?B?Z0NNb0Y1VEZHZjBjcTMwSVVFVHFXakJsdTZvZ2ZPNWk5UnNIdHBrZnVKOXJ5?=
 =?utf-8?B?MzFCc3d3NTRodVdiR0ZIV0paV25leU82dzR5L0FQRmxjd2lMd3F4SFNVR3Vk?=
 =?utf-8?B?UVhOcG5Ld1VqVkF1UTUrNHBoT1RYRnBML2x6aStKaDZLKzVkNnVCNWNMV2hy?=
 =?utf-8?B?eElJQnR5YVpoNDVYZStaTkovUCtNWG5NMDNocVh3amZWUCtSZjY2aXY5WVhu?=
 =?utf-8?B?bU1qSjFjR3FuSjg5REpEcW0vUklFY3dQT2xmMkpmRnFYWHorQnRvQSs2bE41?=
 =?utf-8?B?ME5iMldicG9neENYTjhYSnJ0SlBxSUREZlVvc2drMHJkbDhrNzlSK3Z2NEt5?=
 =?utf-8?B?d0NlMkUrS0tpNGFzWGFLc3N2cE0vTDlwY3A2RytRQ0Rlb21ldG5BcForRFRp?=
 =?utf-8?B?UHdqZHVsVXVRU3hkQzVJWlVYVGRHdEVCbHVaSlJXQ1N6M0FISE9uc05Pb3Nx?=
 =?utf-8?B?SXQvQ2RwM1lnSm9IbVdUSmlyaWFLb2pYMElxMXN0REoyL2xTdWJjNmRlZUlF?=
 =?utf-8?B?cjBZSjFSckltYmtQWEFFZ0pNaFJ5SVhQWTNYWjQ4THpmdEhUa2dwUjY3L0kz?=
 =?utf-8?B?Mkt5azdCT1Z0MnRTVG95NnBOYjBleFVrUU9lMGlrRGtmUTBMMnN0Sys3R1E5?=
 =?utf-8?B?VFhVQVN4eUl1aU9RNHNGRm9QV3U0U2dwWXFyZGtXNzF4WXB3VFFjcSs2ODVn?=
 =?utf-8?B?dCt3ZUVsamdjc1VVOXQzaFo4NXE1YUZ2ZDE3MDBqUWdYYS9OVU1UMGRMM2FN?=
 =?utf-8?B?S2dLWVEvdzRIcmFpZ0NBeEIyVFdhbjZmbWtFd3pVTWRrMFhRN0U4VXRPKzN5?=
 =?utf-8?B?UmV1YTNHMk5zMFBiaGlscGN6enFyMzNLdUhuTW1ZWmdoRTJuWVJzQ3kzVmZ1?=
 =?utf-8?B?MEtKa3pEVWsyWmpGVjZjbUZKL3NPN0p6WFRMcGljWEdCa3d4SjJyZ2lRM0Fh?=
 =?utf-8?B?ZkFqQ0orem1vSnh1bGlSZXVzSXpDOFAxaFBFUUJiWXdVZzlrbHJaaHlUSUpw?=
 =?utf-8?B?cjc3bVBHaW9tWGNnVTJpekVVV2IvdmhqdVREbDIyNEsvbE5va0xhdTdTT0lO?=
 =?utf-8?B?c05GR3F5NXZRd3dKMnJkbWJKdkNIRE51QVNGT0xtMjErTnhBcjhFMmgwcHpF?=
 =?utf-8?B?T2lhQzJMU0JXbnJ6Y2oydHFtOTlHVGJ6YWVVWU1vZWtYeDhtUmhZNHM3VU00?=
 =?utf-8?B?MzZNRWRURml1RTNBbERCSGF1NXVReEpMeDZxeVJVdkdQSWttc3d2NXFnZjM2?=
 =?utf-8?B?b1Yrb2toYS9LUVVHVXFCZDNITE9ROW5FbkFRRzk4VlhRR2VQU1ZFYmFRTDVC?=
 =?utf-8?B?QjFBTHA5YWo0YUF1TTljbUJBWS93Yk1XUDdzdHZOOGNPZEZucXVXSHkrYk9Y?=
 =?utf-8?B?VTBPclFDY1RxTXRIWi9JWXZZTnZIUUEyVHYzM2FxL2ZWTlpMdWxvcUp1NWhO?=
 =?utf-8?B?K1hUKzIzVFR1WHZEcXhNZjM2akNrQmpHdCszdXhHQ2MvQi8rcndxTFdoMHNX?=
 =?utf-8?B?NHg2WjFlY1ZPT1AzUWYxV0Jpbjg4bWxLR3VnbTVmZHcxaW5rbDRPa1F1NldT?=
 =?utf-8?B?R1U0REYrbXEyT1dqcUpYRFNIOGI4ZHRUUnVMaFlCSjd1SUUxb0U2ajJTR09n?=
 =?utf-8?B?cFdLcEtlUTVaTVp4bTBXWTRYa0t2MTBiQ2FBVnBZaUx2NXNQc3lhVXpMdGNR?=
 =?utf-8?B?YWFWTTl6clBuZE5ydWl0OFpvUUtTN1gvb0NZeTJtU1VSR1NCY3h5SXBoRXZZ?=
 =?utf-8?B?RFozRWVELytjVFNrNDNZYzc1OVNrbGlpRStMQTY3Y2hvck12ZDRneFNkdnVP?=
 =?utf-8?B?NE91QUR4bld4SDJaL2FFN3ZodUhtbGdvemhEMXEzdTlkNjBneTVZUzNhOXJD?=
 =?utf-8?B?UlhyRVNQVUdsNDRCOER1VTZESDdUdlhhS0VVYWdZTFA5eGF6VlJ5RWpxS0ZX?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9eb3e1-c79e-4997-ce50-08ddefe1b28a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 20:44:40.1626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SvLFcuPhI/nBWjBdEF/86rdaQ9jebK2zKUcHjENJA5H9M3yBvo/EhZ+Uj7d85aUuT67iv9S3NQcImkWRNsXv5X8SBts/3wR4VuLcJnaPJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8401
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA5MDIwNCBTYWx0ZWRfXyD2ijAB1Pi3o
 Q/z3TOXMU9j+bIZidMfK/k8XOC2RL8f5VHpdSeOfLt37euqZRtkogKXtuMLZSHFyF5+eEflQBBh
 64zapobKTBhAvCZVpnyjY4R3CqeoSlx3AauNRPn1aDiXHcr8NsN18Qk3jkm/quGgE8potYAHAH+
 zXcE78tAFXr5HzEMqvqYmwMJy+fZwZYKRePLmcEYtVWQTS0Bi/2fI83uRZ9bdFg57md2UV+wdIl
 Zq9d7gKIo5v5S+G7BjVf+g/gKhTnUvu81yGjsuoGkcXgbUZvexPNoN3x/Ae2RKnO2xBvqzKPHOR
 m+lfERmfcke0Bi0Ugx/li1VU7x04ywjyTm7KHfmCNph/gmrkbaaf+n7jbRUULU=
X-Proofpoint-ORIG-GUID: wVPemyHGbMEQQc2ZSAZLLG0NTrVvenzJ
X-Proofpoint-GUID: wVPemyHGbMEQQc2ZSAZLLG0NTrVvenzJ
X-Authority-Analysis: v=2.4 cv=WccMa1hX c=1 sm=1 tr=0 ts=68c091ba cx=c_pps
 a=6JPPvL0+Kp/bephKfSor1Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=BjDLEnmaNGqT-2_20UMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

On 09/09/2025 16:10, Mark Cave-Ayland wrote:

> On 08/09/2025 13:41, Cédric Le Goater wrote:
> 
>> On 7/15/25 11:25, Mark Cave-Ayland wrote:
>>> Use QOM casts to convert between VFIOPCIDevice and PCIDevice instead of
>>> accessing pdev directly.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>> ---
>>>   hw/vfio/pci.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>>> index 16f092a0c6..c0c3d68742 100644
>>> --- a/hw/vfio/pci.h
>>> +++ b/hw/vfio/pci.h
>>> @@ -206,7 +206,7 @@ static inline bool vfio_pci_is(VFIOPCIDevice 
>>> *vdev, uint32_t vendor, uint32_t de
>>>   static inline bool vfio_is_vga(VFIOPCIDevice *vdev)
>>>   {
>>> -    PCIDevice *pdev = &vdev->pdev;
>>> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>>>       uint16_t class = pci_get_word(pdev->config + PCI_CLASS_DEVICE);
>>>       return class == PCI_CLASS_DISPLAY_VGA;
>>
>>
>> This patch does not apply anymore. I will drop it.
>>
>> Thanks,
>>
>> C.
> 
> Thanks for the heads-up - I'll take a look and come up with an updated 
> version.

In fact, this patch isn't even needed anymore so no fixup required :)


ATB,

Mark.


