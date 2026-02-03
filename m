Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B93AE87843
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIjZ-0001Ni-OP; Tue, 03 Feb 2026 10:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIjX-0001N6-Vn
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:54:32 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIjW-0004Ni-CG
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:54:31 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 613DnoDp1438669; Tue, 3 Feb 2026 07:54:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=eTLPw3l7FQPr5wLxUS6qr2LDrnReR3eWS+QxHW6aD
 Hg=; b=YOPew/5XQVDHIahmpggeXi7W1j8B2kTYkgtILHc7IhG58kyKqVCpdfNTR
 wd1QkegfrIBkhAOBaXvMoJim8utbF6m5z8e8nOgEUn6RzIHnVGXgHNSDkbhO36XU
 w/Sh+RfsmzFk6tDDG7KcE82h+9ozBctwlzgZRTfALST4SXdf1nA1KwFGG5ULOlyN
 kauMfOBiDxCp1tB8+tfYx1av+18O4QEDEzLETSyuuPKkfAlK5NWpMRhQ8Ys6kjqR
 YMV76FJBEVjPBYVW4XS7NGWrowNyYR3mAevO/q6Bovw+csODx6dH/u2QJrtf6kV+
 HnbGW6IWVMgKIwVVskHVNokSUyu7A==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020075.outbound.protection.outlook.com [52.101.56.75])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3aydhdqv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 07:54:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FU8P7iQ+YNqdN4ncrwq9NITV467dBJ/wJbffTtbnmf3s4ucTYK8R/t5O2CWRELvvG3mEHncIH7BLNMOOwI9+iJTUb7e4humhqBdCrpdVDNmx2ZpfdNCibKIVJ96Gt0wEnlwTOO2uKVkqkHq7O83U4ck3Monr/gNLMjSFz5ZkTTXaJ7YtU+ecobxXrS0bqgZRF0735hc/nX3quLgQrSixz7Xac27GgcmyVRIaxelDFlwGIWG1X114WNhE9T8KkzMO23uz3EEXLCDoUrNpkQBXScALiYsuwbM0SuXYRzhsPiA4QYD8UxNRt8REsAX2aI8Y1QA/IDyNN969Pq8mECrrDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTLPw3l7FQPr5wLxUS6qr2LDrnReR3eWS+QxHW6aDHg=;
 b=s7K+sm9Y3UWusFVMlFgIRT7nR4LgenC9gMJ65cSA0cZPoypBiJZCU3kTRRAce1ozqSmJ4fOs2A5xFocvfijW8Gcjq7QptkFQE4RL8JXG56lF0p70nNn6TKiKSTentrhHPSSBGZn5FYM0P9+GnC2Qut1OQUQeCkok/NiTKz5Ad5sfoEurizOBG7w0llqntr0g/b+n6iXAlvxEHvXNm22YVxpu7evFi3SmzD+D5SNL5mY0tCbWPCkbCcb+HjWR5XjluBlPiUdUc2pEkGEyu1Qsfy8hmQEbf5fK8WkGtehp4O0xDq+n23YBfFQPVD98t8rIk41gZdWma/ODaWE1lATAog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTLPw3l7FQPr5wLxUS6qr2LDrnReR3eWS+QxHW6aDHg=;
 b=N5/3ETXS5UOapf14qifBA2T8RpHG33YYJKS+OlGK7vCkgqDOoMxgF8IT3S71z4PXtCSts52Ko3vtKru2ETN8xOS/A3hN+qWnmiMWSbjETgHvqYoGQEoaxFgYoIR9SceofbeoNieOhTAUAxF5aZ6PgdwajFTk2Ix9hU79SJMJq9qisxAiPGcVP7cf4+KMEz2/iKRoAta+yeCTIJRwVr/J2sNFgOiW9I19RZUREyMCEIIouXYpmy6qXUFtbODZGMwoPsYBuS+lnrjxD3Vc9g1C1h+NyrFxa7plmT91Eh9VHkccRIPTwRQF7t0jRJopDn62+Hrimbf1JP6xyXXbdnquFA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS7PR02MB11082.namprd02.prod.outlook.com (2603:10b6:8:265::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:54:25 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 15:54:25 +0000
Message-ID: <c47744c7-e816-4745-8a1c-a22d5101c02b@nutanix.com>
Date: Tue, 3 Feb 2026 15:54:22 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/37] audio: list backends as modules
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-8-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:806:120::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS7PR02MB11082:EE_
X-MS-Office365-Filtering-Correlation-Id: 688c1df8-f223-4674-9772-08de633c8137
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q05naGloSjFIRHcybkRidUFnbkZvQ0Q2NzdNcUtuZHU3VG0vd0UvOE00a2hP?=
 =?utf-8?B?K01QQWNrZ2tpNXhHa1NzczFJbjBHMFBTc2hGUmZqTFFzUTdTZVRPMEJnN2Rv?=
 =?utf-8?B?eEVIcXBSUXlHQzN0MUFtU2JvM1JYRnZwM1NjSCs2djFJVk9CM2hoK2RTaTNO?=
 =?utf-8?B?akxVbGZLWWtDTHJyZ01RQjBQdUNsMDhLekdXQ05XVzY5Y2lqT3dsdWxuZzBi?=
 =?utf-8?B?Q1pZakExN2pmWnhwTDcwbVkvcmpXampoL2dENGRhQlhvajYybzFIaUhneVh1?=
 =?utf-8?B?QjBncGdKQWw3c2hPY29UcWZNeXlPeFJZR2xwMWZRMVRWWXhDQWRqRFlLd0tV?=
 =?utf-8?B?NjBlUkNCa0dUWHNaQ2lIUTA4eEZqQ0xXcEpsbXBoeUhqaEk1bTZJclFTVURa?=
 =?utf-8?B?NmpJTXN5NnRrQzBvVlkxL0pCWWlmREZjT2xNT2pJSUU3bHUrQjFGM2Fuemh3?=
 =?utf-8?B?NUlYa29WbkRUTFRHeFJIQUgrOUl2eC96MHB3ZXRJTkJSYXdVaWFWS2N6bjIv?=
 =?utf-8?B?c2hmV2pPcktYdWlieWpaY2RWUHVzZkllcWhZSm1FU3JmV3RWcjVSL0JQdFhJ?=
 =?utf-8?B?Y3hDR0daVHYzakNIeFJYQS9kM1MyQXk5bTJ1WkpqanJJbGZnVG5KdHN6ZDZP?=
 =?utf-8?B?blpSOC9ra3p2aUFaU2NjM2x4ZW8yeXYvcHYydE1zQUErYS9UcEQ5R1JvWk16?=
 =?utf-8?B?VjJ3anBHQmlQeHUyUTQ1cFNtYmZ2S2taajBJak51TXdYeVcvTzAxNEVnOUo0?=
 =?utf-8?B?M1RiRUw1NWMxcktxUTdIdnBid0x6cWtGZnZGdUQwczgvdUVSRXlEQndaUmJZ?=
 =?utf-8?B?VUZHUzBEaHVXTmEyWTltNjNIUHRZczBVd3R1cjVYTVRjMFNTYU5LWUVUanlI?=
 =?utf-8?B?Tmp4MjBYWHQ3YlhNcExPNERXVXNNOW9ndVpCYTViN0VmeU00Qk9mWTBaeUtk?=
 =?utf-8?B?N3o2NUtNZHduRnBrY1g1ZDkzUlZVaXdJQWFjOXlCTjhQaFpPdWZkVGFEZmN6?=
 =?utf-8?B?eEhoeWdMWXVpMXptMi9BVmZnVUJnVFp4UFR0RDJEc2NRWG82VXI3bFVxNWY4?=
 =?utf-8?B?SzFtTVlZMXlaOTNTYkJML2tBY2lwLzg4M1NpZHBzekNvNWF1VEg5cWdRNkRv?=
 =?utf-8?B?OGF3WDZPU1M3bUhraGw1RDVZelFsWlVMVSswUTRjcnJVRG96WlhIQTZNLy84?=
 =?utf-8?B?TkQ2bHltNHljSDZ3YzJwSDVRUjg4a01ycFBnU0FsU25pRGRqaEJPUnNZRThk?=
 =?utf-8?B?RmVJR1pJMEFxMytGeU5pRVRWVmI1bkRZQVFtaDduYTZaOWF5MDdIdVdOWlUy?=
 =?utf-8?B?Q2xJelpUNGJSZ2ZZcWUvTTI3eHJCTW9UMFJGWFpoZG4zMTdaK2ZmNjNhdjZW?=
 =?utf-8?B?KzY4QnJVVjc0QWtiNFVoSnAzOWtPMDVpbzVBT2VlNC9IQ3F4RlNsLzhsYXV0?=
 =?utf-8?B?VU8reFA4c0dmU2VqQzJ3bkpLcjNiYTJwUHdRYVp4K3I2a21IdnlYd0pUWktQ?=
 =?utf-8?B?K0FRNldKVE1CWUZSVHpVOWl4T01ZMHcwTUgya0Y3bDFkQ3pMMXQrV0NtTC9z?=
 =?utf-8?B?ZGhSeGp1RDR5N0ErbjN1MS9xdVhnWXlaQ3M1OHFSY2wyRDNnZlpVVVJaR3VB?=
 =?utf-8?B?UFJkbTNsbGRrZjhqTnF3Z2M0ZEtmWDR3MFVxRnVuM0RFd2NYWExobnQ1Nk5I?=
 =?utf-8?B?amprSFN6SUFqTExrdGk0U3htakpnMWE4ZzN2Y3lqcG1qalJ4M3RuMXNkdlBP?=
 =?utf-8?B?VTEySjYxSmVrNnFCa3UvVys2aTcxUTdFS0ZwWUZYVVZaUFFwWEJCSWNBc1JN?=
 =?utf-8?B?YTVRcEdObTkvYzNBV0gzMnQrWEVhaUIrUHliUFRMRE9kb0FkL1dvTzJ3cXhV?=
 =?utf-8?B?Q2UwZzhLWUJSZnQ3QXhXeXQwdEVYdjIvS2E4cGQ0Znd4M1FkQWZSakpwOXVQ?=
 =?utf-8?B?SVFhNFFhMGRldmZnU0FNYmJvTzYxN2NNdFhIdm04Z1FxT1phMldLamZiZzh3?=
 =?utf-8?B?T1RJU0tvZlMrRjZsZGNXNDhobG5PcVd4SVJwSlJpbFpaZ1FtQ0JDSHY3Qk42?=
 =?utf-8?B?VjIvZWRxM0JvY2J6VTRhNDZvbkdhZ2dkVU5WbTBRSXpOeGFBYkkzYXNMYXlS?=
 =?utf-8?Q?WklQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUhpWG1INStuSzh6SW9FQ1RJTkxJSTN5QzJtemduU09TRjZNY0lXTGdLK0xK?=
 =?utf-8?B?SCtEcHN4WDZHZmt3ZG9qTW5lZ1grV0pEUkRZRWVhYmRiVzV0U1FIRml4L09Z?=
 =?utf-8?B?SUJBU0t3c05UY3dmOHlKaUJjcnVKM2RpQ0xyM2FOVFR5amo1L2FmUkh0cUQ3?=
 =?utf-8?B?Q2NTN2V5TlR1eW0vNFRxT0VlTlBBYmtXSWFVSmx1Snp1QlBCeGVzVmlqNHRH?=
 =?utf-8?B?NkNBbDB5UDQwVjB3MS9EU0UwNUxzcnFWZlJ6TXpwYVIzYUhmWkViRWVldVpq?=
 =?utf-8?B?WE16bmhaeXVUSVRhS2k2NngzUTRUSkU5NDkxRjd6WHRudFo1dUN3eUlzOXZY?=
 =?utf-8?B?bnhHcmNqRitOanBGQmxOWlgzQjdJeit6dFUwalp0K1J3WHVTMkM3MGhXYzRF?=
 =?utf-8?B?VGh5NG1sWkhxL2NVYVJCczNnem1iekJDNm9yZ1lhVDNzNnZ6RnpHRFpqYm1w?=
 =?utf-8?B?OGh6aDBnMEkrNngyQ3hnSWdNRmM5OE5PeVYvdk1jTzJlMEd1am80QTVSSDQz?=
 =?utf-8?B?ek03WTFZSnNJd0U3OG9sN256ZzdBQi9vK1ZCekphcUxjQnpDVHN6dit4TzRo?=
 =?utf-8?B?eEFYOGxKQmZhd0ltaXptL2hTa3dSME5NTkJ2WEZEVXg1VmtMb1ZxcHA5ZWlv?=
 =?utf-8?B?eFJ1WE5oMWwwdHVwcjRjckhLZEc0cTdCWlBRNWpoRnpneUd4NDJZTjI1aFV4?=
 =?utf-8?B?MUhCYzBnWEQrWlAzbXBLYnZtVHpWQkw2R0ZyVzVGNkxZWXhrS1c5eUpENWpL?=
 =?utf-8?B?dFhDNWMwVXpMVW5TdDlVRzJLeUg2TjhJaDAzbG52UTlVZkx1cDdTT3IzRjVE?=
 =?utf-8?B?K05IL2RNdi85MUdkK2RJcEt1Q1RQTU5IYzNOOGluVzVJV0FCMEhEWUYvaXRs?=
 =?utf-8?B?dFdsM09LS3M0RDdTRkVDbEJhU1dVMXFqMHgyUlhMdjVHRWhkY00rdWtXRndl?=
 =?utf-8?B?dUtpRkpYczV6eGMvRzZhK2lVY1V3d3hhdmZYRjV2b2tLWmgzRERFNEV0N2tU?=
 =?utf-8?B?Q3BMTEtvamNsTm1DQytuU1dQMk1TTTlsNTRKTFREUFVPY1dCbCtOMTVOdDd0?=
 =?utf-8?B?UGtjYkRpTUE0U1lKdEM2R21hbVNnWllrMCs2STFQOHF0bDl1MjNFdU1TWDdj?=
 =?utf-8?B?akhDNWtTMVkvd2oxQ0NlZFhaeVg4bE91N0o5NkhFUFZ1QXkzRWVzU2JyOXRX?=
 =?utf-8?B?NUx6N0lxK0w0STRvRHlXc3hEbEsvZWlGVFVxU0RBbk05bmdpeUtPejU5ZG42?=
 =?utf-8?B?S1lZb3U1VHJDblliNm9TTWNQcmVyeWJ5MHp5L0Mrc0V3S2k1UGZVSHZQMkdh?=
 =?utf-8?B?a3pEQVpJZWtEL3hYdDh4bGpQSE0zNjA3d0dPMlpqNy96ZlBsUFcrS1YyaHk4?=
 =?utf-8?B?b1VuRFJvTm1pbUNWd1U0elNqZ0FPaEg2WFpIMHBwR0JZclpSMjh2ZUJ0cVRC?=
 =?utf-8?B?NnpLeW1Dby9PWDJjYmVWSnMyT1VhbEpNUE5FODVDZlBBdFEwZTFVWGhITVN4?=
 =?utf-8?B?bnozcGFsVGNRTEpaekNSNnFPV3lodWV6bk9UbDhqTEwzM1U5dXBmci9YUWVY?=
 =?utf-8?B?b2ZMZStoZGwvNUZ2T083YVBKK1FzQmlId1hETm1NQ3JzZVR5amxOamx6NGMx?=
 =?utf-8?B?R05QODFlTzM5L096YW9YN2lTMTM0b0RxdHptSjJxVHhIeHpuc25wNjN0a2JE?=
 =?utf-8?B?enUxc2VwYnQ4aUhlOHlHVTZSWGI0UkpsWHhWNFMxMHA2eDJ5L1duR2FCbXor?=
 =?utf-8?B?M21qVHNtTGxFMXQ3VEQwbW9yck5LZmhqaFEwK3hzNFNleUNZeGI2Skx6OGJw?=
 =?utf-8?B?MmxRWVd5aDc1cXRqWkFoeEt2VUlWc2RjV21mTnc0UnRpVU8rQk40K0V3ZUtY?=
 =?utf-8?B?aEcyNUkweEkzTjFMSjFYQWNNWTV1WlpNRVpiVjduRS80em43cXE5ZkkzT0tn?=
 =?utf-8?B?TGFvTGg4WlBhZzFWV3hTRlFVRnFyVGNINGRwRE4vRElLQ08vNUhBOFFXTHNH?=
 =?utf-8?B?ZXhCaFBRbWJuN3FIc3kyQTZ2ZDZGcEg2algrdXFZRXA2WnZNNExCTzlka0pT?=
 =?utf-8?B?S3FrN2xwMDhnTHdEVVJOVXdlQXUwY3laWm80QnBhL0diRHhqUWtVZkxzSWJz?=
 =?utf-8?B?MzF5WmN1blQrTXc3REhSQXhVM1ZpME5xY0lMamJyYmFDMDdWREo3MFhRQnEz?=
 =?utf-8?B?eVo4MVgvTjl6ejM4WStnclZuZ0dPZ2dadUthUGRtaGlWUFFHMklEV05meklM?=
 =?utf-8?B?MlVsZTBMenh6OFNGRHlmU3FtZlRhcGRJaCtlc3duNVlOdmVNREhLTjNpVWhF?=
 =?utf-8?B?YWVrdXhVTCtuR3ZvYUp2cVhtcHp2YS9zNVVuODlrR1M4Z3pzYlNsTEJTalZX?=
 =?utf-8?Q?JZlD9vD6hjjxi+nk=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688c1df8-f223-4674-9772-08de633c8137
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:54:25.1112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmueQpuNxkB/SIH23aqkkUbN+7T+juvhg8RAlAKCF7NtagbqGv7tq4X27eshaxe38Hras/Vjmq8VfSveATQoCMwAq/VcYMTfAwVtfdXYBhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB11082
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyNyBTYWx0ZWRfXw77r/fWgy+VL
 mbxkpL1nfBaEjxrMagCyKA93pVX9dN0ISYGeb4QkTF7wWsotebkCwDcO9Nb9rcgbCs3oea4Y51j
 FLBXXMmtMOVs6kJ24SowGmHkn/XwQYwPiRRuivFJgVvo8o7nvEfwR7N+lIBiZLYvz7KsMdEpBA1
 YE88CtJHvK/n7MZMRRMn3SJKQw9vbLz4Oh8oz0R4Aoi6AB5oSSq5Ae5nnpanH5bT9Z4GVFkcore
 NDsuehaiw+SU7Eu+SVZ/GFdYJVFx+PNGCmga5cJUPMiDKemjA58XCbJoKtPdiXj4BThCrjz6NN/
 Dd/eZHnxTABwKN7C1JzrHoB5ooSk4IxgvcqMnFKXX2Xb9kMpvoxhJIg/s1etcsJYz9ezRmalubu
 lg2k4xWuwACV1lGiMETalN6tNDnopODrsgX3nV3Kjw1XUaF6Aa4FGlRkUZZrFHwm7V6i2YyUuLm
 h47wlc0o+wDfKQ0PnQA==
X-Proofpoint-GUID: eVSPSDwhTrzQulCtopuRMJQpSKU7pR11
X-Proofpoint-ORIG-GUID: eVSPSDwhTrzQulCtopuRMJQpSKU7pR11
X-Authority-Analysis: v=2.4 cv=AeC83nXG c=1 sm=1 tr=0 ts=69821a34 cx=c_pps
 a=JPYgw6djPvulOwJF0XPiqQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=2e3-hzWyhrHcKWtxPDgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Windows doesn't support modules, atm, but we can treat it as a regular
> audio unit regardless.
> 
> MacOs does support module, so this is fine.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/meson.build | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/audio/meson.build b/audio/meson.build
> index b2dca2c6409..23fb66d571f 100644
> --- a/audio/meson.build
> +++ b/audio/meson.build
> @@ -8,12 +8,11 @@ system_ss.add(files(
>   # deprecated since v10.2, to be removed
>   system_ss.add(files('audio-hmp-cmds.c', 'wavcapture.c'))
>   
> -system_ss.add(when: coreaudio, if_true: files('coreaudio.m'))
> -system_ss.add(when: dsound, if_true: files('dsoundaudio.c', 'audio_win_int.c'))
> -
>   audio_modules = {}
>   foreach m : [
>     ['alsa', alsa, files('alsaaudio.c')],
> +  ['coreaudio', coreaudio, files('coreaudio.m')],
> +  ['dsound', dsound, files('dsoundaudio.c', 'audio_win_int.c')],
>     ['oss', oss, files('ossaudio.c')],
>     ['pa', pulse, files('paaudio.c')],
>     ['sdl', sdl, files('sdlaudio.c')],

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


