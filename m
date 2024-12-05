Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE12E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJIkj-0007u9-9h; Thu, 05 Dec 2024 15:47:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tJIkf-0007ta-3E
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:47:09 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tJIkd-0008EZ-Kh
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:47:08 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5KMpKB031454;
 Thu, 5 Dec 2024 20:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=Ki79bvwHql8DjINg9VLkRYY78ViBXjBuzT7ZKEGB9cY=; b=
 cjccM5frROkyLxmPmLBb/FYZj+vEtpQtXgRb4urXDKly1/GDt48V0/F34BxDL4JN
 RHiwgtFntykfXcpfw7vVwRVBMEztKxfpeoAPK0z7J+cBRAX2Z+lNrfmiKigmb6XT
 XhS92XR8oAXiOaQ81+fKOhLJ1q0Yl9HJERQvissaf0ctC9VZFGbt9Shfe+WJK77F
 pSlpYcq28pLnhjk1fPdljRFu6rHciEXBnsH8fdtxlZt4njwzf0lJsc/4fjPYdwZs
 3860TCIGj0zSPg65bPRxVqSo9hahIWjzOjJaTi0PLUkDF8ZVcD82rqJO6SokV2tT
 vZ+Jmbzgntg1hRbfGJlM/A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437trbv5qx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Dec 2024 20:47:04 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4B5JdFlB001475; Thu, 5 Dec 2024 20:47:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 437s5bebkr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Dec 2024 20:47:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7iago+hzroGOizc32DMqG0l80Ravo8JqLc7zbXeq4n8W4jspL9uHXKJOGN3Ft2GUoDAjW2WyB/Qr77yKzxjxfQVp3GfwsA2I5UO+yrfQIEpI9HhsXFZxanDkXY6qDHN/xr3AdJLDpheH/mDGtUUiYCRSaq0tYGYxBd6/yC8eEccQr0qMJjtLPHkdUfoyOFOwgwVcsobJvEiVVszANGKhQgz9O9wN/muGfQOQsDwK7aVczhUoBBIverRKJFoivVFDpnr3k7H+lJyxJ1zWlC9tcrwfCfLRwyBWWENQnSQGz8QMolB/JRYGHt5Qb9wq3IS0h/FhNfCryoK8pt8HEy2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ki79bvwHql8DjINg9VLkRYY78ViBXjBuzT7ZKEGB9cY=;
 b=ejikFuoRsmmeSVV0/dJjFg+0qjQky8YtSrrmX1kGOfuJ4myTOSMydAe+mKdkjXGdkmxWfrbhBCztos99V02KubUCn4+58PgNNkKAKH9nJYEvh6z2oZ/9pgTB9dMzocwqWwVSRHcLZSFp6Ub7PrX45jkNqLJAgMpnV/yZWVu1bJKttu24H1JbjBvHvhAvyOnnZXlAhxTuovz2fcAWXWFayExNez5LO9NWFZC3XhhycHe2vEsjos3J+R2BlHlSa/cl5Co1E9y6xq5KutSppSdVxkB4E/VHgd67hLlAY96nB/cvEtWMmIm9x5+Dx0o7MX338xADD+JmbfEfGnvuKOoDDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ki79bvwHql8DjINg9VLkRYY78ViBXjBuzT7ZKEGB9cY=;
 b=pWlLB9BEDRxWOU4jTQ4a1No2va3oX5TCca4oe0DMSNjH+xhLVS/J+RfkOZh3UaqBYcs/oAGDphlSq8JdsI08PRl7P2SiDA5zX111I7gTh/8czxP/caEsPd5KZmqeSCIGoaE3g8YmVU/zqgWQS5PB3KJOWyXaflbflteUGiGiS2o=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH2PR10MB4167.namprd10.prod.outlook.com (2603:10b6:610:ac::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Thu, 5 Dec
 2024 20:47:01 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 20:47:01 +0000
Message-ID: <2ac9265b-0092-4636-8238-91331834ea77@oracle.com>
Date: Thu, 5 Dec 2024 15:46:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 10/19] migration: cpr channel
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-11-git-send-email-steven.sistare@oracle.com>
 <87cyi6cf9k.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87cyi6cf9k.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::45) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH2PR10MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc9b790-d87a-4aac-f110-08dd156df7a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGdLZU5ISUI3UEYzd0xJZW9PMjFpR1o5YUJ2TzVsYllVWFRkMWx0d2padWY4?=
 =?utf-8?B?NVRnOUlWVGdWNjJNU2M4QWdSb0Q1SFFGcGRJS09ZTFlpZlIxOGtxUFREeHUz?=
 =?utf-8?B?ZEk2NUV2bGJyZWlXTDFTUzZ2YU9YMXI1aEZ5WUdrVXF0Zm1zcTZUazRvTDhs?=
 =?utf-8?B?UjgxSWN1cnhnNWlEVWtmOCs5SCtSc1RvVUxLTTZHTnIrbWhTKzR3QzduOW1O?=
 =?utf-8?B?RWRsMVpDblRJTVJVL1dKNmtNQjBiRXZCRTNMRHZjWFNIcTBkWktKRklHTUFX?=
 =?utf-8?B?M254dVdPSmhNaFh6UUVDdk5jVmhUUHJKSGUvaHhUWmdIRlZpVXJpYVhOamNx?=
 =?utf-8?B?M0pCdU1CTWhuUzlHL1lURlF3Y3l2U2F5NTRDMTBOS2dpRFpzQWpodFo5MW9G?=
 =?utf-8?B?UStPeXhuMnNWSk1TQmtWZkdFM1FPSnpBQUxtV0FNVWU5SW5iN0lGZVpsRFJ2?=
 =?utf-8?B?Z2ZHdEMwelVtVmRCTDFMNm0wSTRnOEswMFhZR0NaaGU5M3MwZEtNQldSVXQy?=
 =?utf-8?B?SHJZejBPMHBlRGprTlV4bW5PSjdvRXJvZ3VTSjlFZUJWTzBiUDB2SDRRUDVN?=
 =?utf-8?B?WFBOaGl4K1VHTURDT2ZQR0NmUkFGZER3eG1xT25jZXBhcFVDblR0WWxiQndF?=
 =?utf-8?B?dWh1SHA5SDYzMkdVbmVQM09Bb3AxSkZoSjV6blFyV3ZudWlPMU43cm5WRUNn?=
 =?utf-8?B?RnNLVmVCODUwVzlRcDJZcnFXakFsOHhtUTVOOFZ2SlMxRlZycWozNkRjNC9X?=
 =?utf-8?B?c0pqSGNDbGJrazdLMjlOL01qZkFzdlF6eTlDeXhxUjdKU0JOdmJEY082MU11?=
 =?utf-8?B?WGowTDA2RnRIczY5SG5MNUFGeUNyTDlNd3BpUmxrdWhIcjlQQUlJNjc1M0dV?=
 =?utf-8?B?akcxZTlPZmNJOHlxbXc4U0hocGRNY0tmYVluSm9LY3BEKy9pZmRWeEhKV2Zs?=
 =?utf-8?B?empmams5ams1T2FtcFVGNTVuZkEzNDRqRTJPdjNkUkxjdzJZNTV5TTU1TENa?=
 =?utf-8?B?bmtVdlN1cTRXNU05dUljdnNyUFl4WmFmL2ZEK1hjVG1HMHVEdFVTOVQ3eHZQ?=
 =?utf-8?B?cklnZUtUZHRHa0NLejBvOGZQdzlXUzVNRTZtWVZHemFTMmwrRUtBTjdkdHhS?=
 =?utf-8?B?M3VWZ0xmRWdmWENST3UxSE9NWFllaXNtTGZsTWhCNkI3anoyanE2RG83WnZU?=
 =?utf-8?B?SHVlL05TUmxzY0tkajQ4eUhQREVYM04ybHRhRmYrZFpBYXBKdlR6VHFWZkxR?=
 =?utf-8?B?dnlPUGRpVEZBeldvZGo4UlcwdEoyZTRUQkhyQ3ppaHM4T3FJc3Q2T3BSVGVo?=
 =?utf-8?B?anE2OGRHWjkzZFVsTVB4eXZwb3lKRC9uOHZubElxN2EzNElkaityTjhuZGtz?=
 =?utf-8?B?M1dndUR2a0pkWkZ6RTFhNmF1RHBXUWt0aHJmUzFURHdLWjlSTWZmcjVISlhw?=
 =?utf-8?B?NFRjazBIdGxtY0loSXQ1cDdhemhNS0hTLzZaWmxGRk5CV2xsMDRWWkRybkpG?=
 =?utf-8?B?MVQxZXV6WkUwZmJzbVFCdzIvZkhGVytib00zbTVUbnI5K3p5OStYVC9wb0Jh?=
 =?utf-8?B?SG1GaVEvRXpJaCtJVld0andUblBJL3JNK1hqT1NGaWJtS1d2Ty8yVzZsNVpy?=
 =?utf-8?B?cDBHQzlDcHYrak90RVdNTU4rbEhVRHlicS9oenBLSUI0N05IYU5VTGRGSlVY?=
 =?utf-8?B?M2xNTTNMOEJTVDl2RGlUN1FZZXNTZFZ4aGpRcUdmU010cTdFeW9pUVp6VjlI?=
 =?utf-8?B?ZXJxUmhTUDN0SC81Um95REI2ektyc2FCamlreDM0aWNiOElhNVdEK0l3bTM2?=
 =?utf-8?B?eXgzK0JIc0RrV0RzYUhEQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGJvWDRMUnBTckdQWGRuR3UxYmZaQThacjJUT3hueG5oaGUyakVlN0hZTnFv?=
 =?utf-8?B?QUk3UjF2cXNUM0NIV3ltRmp3Rkl3bHQ1Ynd3U1VyZDFSbWkveXROUXFieHUz?=
 =?utf-8?B?ekVTczB6WWl0ZHYva25mcENzTElTWVlBd3dHUmloeTFTTWxXa3B0dU9sR2pa?=
 =?utf-8?B?NStQam5OQ05WWU9GRnpJNU9yTUFUeVVLNDNtVjJ1c2V4U0tyTkhuWlA3RTVj?=
 =?utf-8?B?S1JDZXpwMHIzdnA1K3pNaE9WNmRSc3JsMEM4RUJzVm1iMklPNW8reTRQeTBJ?=
 =?utf-8?B?bW9DT0txenVuUE1neEdBTXlDcW45WEJJdnZLWTNsV28xajJHdCt4K0FhMXpH?=
 =?utf-8?B?Y1EvVEZqRTVzOTZhV0hDdHFPUkM5a0RGY0RIcXpWL2dBTjQwa3Z1R25XRTVW?=
 =?utf-8?B?RVFIMTdHYTdQZWhSalk3OTljTXEzSHd6aFdVNkwyS2dJTUNOdVExTDlQSTM5?=
 =?utf-8?B?VWgydEJ2MzZMTDVNdmlrOHFOUHBrZFNPb1AzVWd6d2lUWi8rMTdtdm8wODZS?=
 =?utf-8?B?YXdvV29ZMjJmZlBKRzdnVmNTTGFQNXBVZGNubEVvN1Azb0gwamVhdmVrSGd2?=
 =?utf-8?B?ek1oSmxnaWI0ellkY3lkbHorcm0rY211QVhTdVh5M1NsWFEvSG9UeXpGVm1Z?=
 =?utf-8?B?RUNPMHlPWFlUdEUybnZZdGVFUUZ5aTJSUmRnWXEwT3MyVXVCNGpwazIyNnYv?=
 =?utf-8?B?V1lNM2t6ZEVINkxROHQwdjRjMS9NaE5lT3lHYzRsczVIcmY0aHJWbTh3V3hw?=
 =?utf-8?B?UWhrWkFZVlhzWkJMWlVpbmIrRWc4Rld4eEhoN0VtdjdtRlQ2amRnclE5YWZM?=
 =?utf-8?B?bFJaWWxCeGdxN3IxWnM4TkRJRkJHTnVWbVQvYytJVHoxVERjTGo4ZHdMbGhP?=
 =?utf-8?B?L2JmTVBVaGY5a0I0N2lMTHVJVGVjWi9XZUltR1lLNlp3NE1IWERsNWw3UGFN?=
 =?utf-8?B?SE5sZVRmVGlNR2Y0V2MrYVk4ZXhTVzQwK2RUdGhBdGFEc2xmenZrUHZnUVpm?=
 =?utf-8?B?VDdsQ0VpR25GalhiRVFoT2dVcVQrRW1LMWF1SEhJSHYyeXBNSXhsYWZlVU9C?=
 =?utf-8?B?eE80QWQveTV3cGNlUzNzVFBRaVR1dlNtMmw0c2FJYkdhYUdTZE5HV1Z3eStU?=
 =?utf-8?B?T1EzTUlvQUQrTHp4VjFZc1poZlRUSW82cFlBM1Y3K04ySGVwRDF5ZVN5MGpp?=
 =?utf-8?B?NCs4emw1eDdaRFcvU2FrUkFxbDVQdFpRMTl4N0RTMVBpVVRKSHpUZGpyZjB6?=
 =?utf-8?B?K1pPcGhzWVdOS3lhZDB0NWNXNUhFeWlxSkZCNmJ0aHZxSUtESzZRVE81elFp?=
 =?utf-8?B?WnNXTnVMcE1jT3QwRlAreVBCZFlFeDZDUDF3Vzl3bFFBRlY5bnlmd2ZETmUx?=
 =?utf-8?B?d2IzZFV5QlJNbHNPQ05JVDIwcTlIQ1lQMlFwNkxIbmV5SFFRL0FPeDIydm5h?=
 =?utf-8?B?NVFkeXFSR3ZBdHVRbzBHUkpFaDlobUNqWkptNVZSTXA5dThkSVAyaW00UXRw?=
 =?utf-8?B?YUY1cmZxU0gwM1UzNDdMR3B0SUdwYTlhMVB4TnVKa2VndW4vc2ZpVGhYdWxG?=
 =?utf-8?B?eDhYVVROZVdZNkMyTHZGaHJlRU5ZRllDaXVTdnRQUkpEcytwTHhvcUtFb0Zm?=
 =?utf-8?B?V1pJKzBCVEgyUlYvSFBEd2o0ajhMQVF0YitHZHdnZVFYeVIxMFA3SzJwK01V?=
 =?utf-8?B?bzYyVW9leVgvZDNxK3lSY21wZ2VCVCtMc2MyY0ZkWU9NVnNKQWNmcEdyNXlm?=
 =?utf-8?B?RDltUmxyUitHa05FeU9lYzZaRXFQaEJremY3Nmh5ZzJzajBhaW04NGpuTjg0?=
 =?utf-8?B?bjkvYVNjcUV1MHNLemV1MXNQbGVWMjg0MDJkMlpySnFFSG1mNW9zZ1FOQzUy?=
 =?utf-8?B?aTZKVmlqaW9LSXRHc3RtRWEzZWJXTVRoZjNUd2lldXJiY053RGFDcW9GRGhs?=
 =?utf-8?B?U1UwOFBDWE1WWWdVOVh0dlUzRExVMEpDTnRVeEFjcXN5cExXdXJRM1NncWJM?=
 =?utf-8?B?MWEydTJoVEF5bkJSUGhKWUlNV0JpaVRQMkpySUh0SG1yRVExOXRnQzRrRXV3?=
 =?utf-8?B?RE0xZkgwdk9uVStLRWlCaHFGaXV3YVgyVGVJM25kMzJjRTJUUFF6Vm84Mnpt?=
 =?utf-8?B?eGlPS3pDaWY1NGdlSHA5aU90Ny9YOXA0azdGREhpUmRhRDExZWl6Qy9jWW80?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3UxXmbmukdYLRzBe4/VsLIbRVq+v3jpurtZkMQpo1bfj4WcUEun6pAZPBdZ1QLkurR/qnncGe72NSGW18jYj9NJdvVygNisR2cTs9v91tRL8/R8lkB91EWtP2YLZaY1S6Vpz/2yjDv/6N1g0p0kBGyQEZF3nGPdYZLC9IAThDtZ7Vs8gaLMUQwTUpfnztDkptDW/kM2vIO+fFZFnPydM9JKITm7a+NidIDZMrVdmEtCSAhZu6VYWt71tQV0aLCiec62DvxRoOo4AQjmzuViWLw/QMWwHOehoqP9RC3jsOugeoU9xvT31Ivh4QOtvDK25h/OwcmCgk/lKQqXHesbLkQyNIFSdUN1Qw1uqphe4EutH0IK6RLkPB6+LS3cEBbif8GwEa+nBfyUKNjufhj7MtcJE8K0UqW7jXiK95vnBe4vghc7H2l4h20ru9dBtODOMxzIKszxacKgFyNLeC97W7uQS4zRAphiJg+fTGusNizFXfY2KXmHNI+ROgNAVO93FbDTPgKLxlW/1B2GXxZD7YOwk/yKhvuCWrb2uwK/8LAK+vhdRdPHk18lGauWnvCnvD7DbuiLdFDqU+UTKZFGs/QEuypBBrxSnws8b8KYB3Eg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc9b790-d87a-4aac-f110-08dd156df7a7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 20:47:00.9426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BChHz5IvCMWKfeENA/bNSOfePLXXCLaO/m9nzWkybsPKfv6hJuOT0murwNFoXWd3l96sFmSEC2IGSoYwTirRRoX0wpeCoD46ds42z61XyHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_15,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412050155
X-Proofpoint-GUID: uqG76_mm_97I_e4i4kfRcf3EDowGRTDt
X-Proofpoint-ORIG-GUID: uqG76_mm_97I_e4i4kfRcf3EDowGRTDt
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/5/2024 10:37 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Add the 'cpr' channel type, and stash the incoming cpr channel for use
>> in a subsequent patch.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> [...]
> 
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index a605dc2..a26960b 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1578,11 +1578,12 @@
>>   # The migration channel-type request options.
>>   #
>>   # @main: Main outbound migration channel.
>> +# @cpr: cpr state channel.
> 
> What does "cpr" stand for?

docs/devel/migration/CPR.rst:  CheckPoint and Restart (CPR)

- Steve

> 
>>   #
>>   # Since: 8.1
>>   ##
>>   { 'enum': 'MigrationChannelType',
>> -  'data': [ 'main' ] }
>> +  'data': [ 'main', 'cpr' ] }
>>   
>>   ##
>>   # @MigrationChannel:
> 
> [...]
> 


