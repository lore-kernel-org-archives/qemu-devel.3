Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34662C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 05:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZlG0-0002Ed-05; Fri, 02 Aug 2024 01:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1sZlFu-0002BY-Mi
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:55:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1sZlFq-0005Gx-If
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:55:09 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4723fXnQ027954;
 Fri, 2 Aug 2024 05:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=lWkStsUSojP2iZjhsV8VuP8KuCXbLefGSdUk1UT7Q7c=; b=
 mdXx/3AE2jJUAD3ZJLAf4G58JegGrN5P3i+l43LRAAUAEH3SlenoGEKSfWeI52FN
 efaowksG5Sbs2ljXJQ3Tkbcg9iYiaF+RnlnlIsIHrsNA0wmgElX34LJ9el0Wp93f
 p3GxBFuzIndlCnEWUD6+QEEJhzVI4BnWGvmJwlv8v7YmwHVWdsUaI4UFwZiaWLHb
 E7QBif9/Z3cmAmRsXh4SyKBWZzY8vmVe3ugfjt1+GpV49rpyQiGgR3V1opyjplLy
 nn6PnnWk7lG1Y2rgTdDnTbQ2nOUM1oRXk4BreOF1Pb2iD8WDcvHZ1HzbHY4qnBtx
 LpMOQC6tHyExYPO0rCKqTQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40rje68eux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 Aug 2024 05:55:02 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 4723IniW000548; Fri, 2 Aug 2024 05:54:51 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40pm86vtcw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 Aug 2024 05:54:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uf8LiDMadaOyaw/A6apyZn1AT8wC8coQFXvznq8zVOubKStlcKRp4p/71rEU/eHkO3mkwKstl9Syg+bQDR1QtMr1MWdjjr/cXQwp6sNdBuopLOr+PIGOvb0ma9viHBZ/NEonwifhxW1tyZjGuva0ALRdz6Qe0lRrKGzD5Oe66sTC2prRBzW6dRywnX4BkpxIfSSIIN0N6uEpEy171jY8BoyDkH7eFFsjKTy1H9pDF6heUBhBVIHNDc+rPtQ6azTl7PobBy9LwvfGBs/g2kZlrXSQAN9Lc7f+flDgu6GknLfnFiDSa/DUxO9VKtCIn2Dd/wIiPhrW+f/GQE2wO9ENKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWkStsUSojP2iZjhsV8VuP8KuCXbLefGSdUk1UT7Q7c=;
 b=tuRn+3A+JugrNc8/yUxDRG0o6EBYefi9sfOoYbzDeIi1662tWxQOF1SCK49WC5tc3/eEm/swZFbRxzo6EMk8OwFzoyYzyQTs/yeLToHTovF+Rqkcu6WP2fCWKiP6CIgOCs6tuIYwL1jgB7A1wt4t9M+s0OkTKbB5pPIZksk8roWQ9uleU/mjDhbx/ZlsRAOlVUWTS2eNi6zZQO4s+xmZFxVrKx8j8HNzVwZv67rNyu5Iu+ZO1NJdlY++m6EPhbIIQ1l7EMKDxxWyNKuxznAjPuNO328Bhe28y2j5AQjCOB+0QM/Jfde/vHnNKqAlMVESOAm8WHOu4Ro+Q7iWt5U2hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWkStsUSojP2iZjhsV8VuP8KuCXbLefGSdUk1UT7Q7c=;
 b=UrQqKEYu8chPtPm6L4+ozuQNslc7LhDsdBk+pEWxuzsV1DeCU1Bwwki2x3ZSu589Ce11tMHnSxxPpfAgjqxH9gynyD3n1LuOxOxPchyHnpL6ZKP90z05P8j9uOTC8BgcwRl9j7y5opTyWkJA0YBJC0cAXG8eov0JmLHIb5b/NLE=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH3PR10MB7806.namprd10.prod.outlook.com (2603:10b6:610:1ae::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 05:54:49 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%3]) with mapi id 15.20.7807.032; Fri, 2 Aug 2024
 05:54:47 +0000
Message-ID: <fbf055d4-e791-464a-a801-699ab439b82c@oracle.com>
Date: Thu, 1 Aug 2024 22:54:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] Identify aliased maps in vdpa SVQ iova_tree
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, Jason Wang <jasowang@redhat.com>, 
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Peter Xu <peterx@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20240410100345.389462-1-eperezma@redhat.com>
 <CACGkMEs=-teddtO4ctLdJiwm2gu3sZrKOww-TC+5o2_19Sph4w@mail.gmail.com>
 <CAJaqyWeKfVXYj61sgvFrUTpOgy0k-zsLoR4JePEo0Q8XuXYbmA@mail.gmail.com>
 <CACGkMEt+TLqpbw2N4m7Ez4edTBztRUxiAt6=NLuFR3c7F7Z_jA@mail.gmail.com>
 <CAJaqyWc18UeBHeQSoAFF1u1nkjaAfj0Y85pgSHbhV8xxExjcgg@mail.gmail.com>
 <CACGkMEtrPAMb-ZN7AAE8cjEzjZY1Hnm29J7PhUYgwv26=YcdQw@mail.gmail.com>
 <84374c5a-d937-4cb5-aafb-45ad75e2d837@oracle.com>
 <CAJaqyWfekhhG+5Zp4eddpp-2N=SjUL+7zs+YqS5xx6eWxa-PqQ@mail.gmail.com>
 <CACGkMEvYSBZpVG2x6q_viekods+QWrjoCETQcsgnHM+Ng4NWGw@mail.gmail.com>
 <CAJaqyWfm1zjU-eQ-j+GaWMHGt7Dk5nGUCUEA75yCga9sBxu39Q@mail.gmail.com>
 <2b2bf1a7-9ba9-4da9-b220-ce516ac029cc@oracle.com>
 <CAJaqyWf-Tcu0RdiWU3m9P07xJ7c33QXwSDH0-D=8u2FHC-=uZA@mail.gmail.com>
 <15d9fb93-58f9-4078-8f07-2ebf0f228d3b@oracle.com>
 <50fd84e1-a8af-4c61-90cc-2ceb653869f6@oracle.com>
 <CAJaqyWcLW3tTdQLM65voYzKQ_S-5ZTQh5NAQAzU88m=BTyWa5g@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWcLW3tTdQLM65voYzKQ_S-5ZTQh5NAQAzU88m=BTyWa5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0028.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::41) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH3PR10MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: 343bf402-7932-4d57-adca-08dcb2b79dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWZnU1psV2VRMy9oVzVwOEZRN2JEMjFnY1NxNkRBQUtnU0RsRFI0OERUcWx3?=
 =?utf-8?B?Q1V5Ykw2Q2FtNkZIbHNDOW1lTkVRY0dTb0sxZzFBbnZ4UHFPeXhINTA5NTgv?=
 =?utf-8?B?cXo3SDhhK1VFdkpjQUxsT0wvaWw5UVdYOEUzUkxDdkE0Q3FwdFpPZE5pM0FJ?=
 =?utf-8?B?aER3UXJXQW4xUHg5bmhqMHFhS24zV0NXWEk1ZzJ3amMyR0I0bmd3L0ExTVlx?=
 =?utf-8?B?RXUzV25PVVFvSmlYWW5SZ3Y0RGdCVHhoSCtWZTBmbXA2Z1JlWGs1VmxGUitk?=
 =?utf-8?B?NzZHanBhQnlpVHZqQmR2ZnltdytLT0Z5SXNWNXBaemFwR0RtdGhVREhLTDhO?=
 =?utf-8?B?RzdHZHA3OU5SZG5ydzBTbE1DdDh1NGlFclBOTUNKV0dvVFhqMTI4Q0RGV1Bp?=
 =?utf-8?B?UFRCZVE1ci9OdGdPZTJsQWZRRUFjUjBhcitkZ3hMOWtJdFNqcVRaSk9vUmtL?=
 =?utf-8?B?UlhYVTFVQXBySEc4bzNKcmxJMXUxZ0ZyVkREWWlNeW5ZTjZMNlVSbkplQkFF?=
 =?utf-8?B?anBUMUkrRFJoNytqM21LOFNzeGNOL0J4bzE4a1lzV25seUNLc21RNlk5RTBk?=
 =?utf-8?B?SVRURFg3d1BjTVlpUVBaNys4RGs4bFIyWG10MFNhWFNKNlZ5Mlh6Yzgvcll5?=
 =?utf-8?B?a0pLYTQwNFZhVm5Gc0pFNVZ3Z3RNaTRacFNXWHlONDR6YWRoWUxPdCtOU203?=
 =?utf-8?B?a0R0TXhORzlaL2sySHVoM0tVRUk2YXYxNHlmSEZJNmc3NGNEQWV5M01RaUFt?=
 =?utf-8?B?ZXRtd2hCSWtVTTZGd3JxWkF6ci9reXpQNFhpOUh5VkY1R2kwbXhrMG9lUldP?=
 =?utf-8?B?Z0JMUlk1MmdQSlROemVzSy9DQnFkZXhWK3VnakRnQXgxVVNHK1htSUQraE5L?=
 =?utf-8?B?eTZCNzcwdUkvTUxsbVRxUFNKRGRBSDhZSGRhclE1UFZmMzRRQXYwUlBQT05t?=
 =?utf-8?B?V0JkUUNObjdnL2xzREtOOTNUdmFzVnBqUUswQWJlREZ4TTIvbWVycm94am11?=
 =?utf-8?B?anJ0V3MwT2s5L2J6bmZJaEV2eE9INWVqbTdiSWdFMkJxODRHQnMwNC8zeEkr?=
 =?utf-8?B?OTEzcXBmNE1WRWNDSWd4QUhCVlZLVTVCV1RMNmNQcTFkdElOTS9ZMmU3WW8v?=
 =?utf-8?B?L21SS1FZa0M2SzJTWjRIR1FHNmlSbklDcmpqdEdiV3duZFUzSU1FbTFGTEpO?=
 =?utf-8?B?YzBqWmR6amdicm1UcGZiTkpkTDZiSytlUDRtZGlaeXF4b2lPRVF6NlMwaVVx?=
 =?utf-8?B?Tit5RXQ2N2hnVGxpUzlxV0I4WlB6MG90WWduNm5mV0IvTXA4a2JJK3dGd2M5?=
 =?utf-8?B?dzVTVXJlTkpBOHFMeGlRZHMyZGJXcjJwUmFlenFKQ3lydGI1YVBMWm1aNmRT?=
 =?utf-8?B?V3pQNEpzeXY0Z3BBd3M1a3JYT0JQMTNsN1F4SUpmZFRNNk1RcXVnRDBiRHQ5?=
 =?utf-8?B?S1plZC9QcStqSkQrMjl1UXpSWEtuZHZYclpqbjQ5a2xnYWVkYlJROEQzQ1ZH?=
 =?utf-8?B?RHdDcjQ0UGhWRGcyTkdtazNOMDJlNm9OSTZnbUhDMGNYS21QYWF4UTZ5Y25B?=
 =?utf-8?B?c2pISHF0ZDVlZGpsWnhYeGM4YWxMamFneGZSWDlYMTgwa2l5NGFjSEtZV2JC?=
 =?utf-8?B?U3dEWVlHeUNobGxldGVPM24zSnJuY3ZyQVdZb3k1QlNDVHRTMkF5WEUwRmQv?=
 =?utf-8?B?djNIdms3RDZ2aGs3YmRkNkJ2YkIvRytZZVlBRkhjTHVnQlRyRWtHZ0xFOUVy?=
 =?utf-8?B?V2d5WFc2VzRCU21sWHFMNmhoTmc4cUFGSm1lL1NScXg5ZGpoZWpmUzQzSzF4?=
 =?utf-8?B?UDdWK0swZ2NqdTlGa3N1Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekdpazlHbVhvbDV4NTAvWXdSUjRWQ0RqL0pYWUdqLzg0T2kwNDRpUW15VDVr?=
 =?utf-8?B?YXBKeVY2ZllkcjVlY3pidHl2V1FkdStpLzJyQllGMXFrQ3VHN0xhRW9BQzkw?=
 =?utf-8?B?a2NZcUh2UWZFVGFoQ2tlTytIS09hY0VvUTRGalRMbktHd3BnZWhmNC9YMWRV?=
 =?utf-8?B?cnJZc1RmSEVIN2RaeFQ2UXFRZG9idVlWK01mN2ExanlpSG5Ic3NFNC9XQmVT?=
 =?utf-8?B?cmhEMkEwVWV0K3FEZk9oUTA1RUVEWTduUDl6NlIxU295dFZlNGtjWTF6VXl2?=
 =?utf-8?B?WXdzem9Cc1Q2NEh0a0RVYXJyVmhZRE1kbkMzVVVvWjJFUTNnajFyT3ZES1Ez?=
 =?utf-8?B?bVpKaGZ2T2hZdFRPYkFKOXMxOHJEZ3cxaXdxVG8vWE05UzVXdnEvdmxCRUxO?=
 =?utf-8?B?L2NSOFNmYTlHMFBEd0I5ak4rckJKbDR0blM4cTB1eFh6bjdQaEltVTNsM1Bz?=
 =?utf-8?B?NlFYYzUwT3FldkRrMlFVMTZCUzVNQXpYV0RadjlFNHY2dDB1RHVHakJBcUJz?=
 =?utf-8?B?UlhmOW9SbXVOY2trU2xESllYS1BoT3RNRDQ0ODMvTk1DTFlaSW5Ec3dYd1lF?=
 =?utf-8?B?em00R3lqT0k2bllKM3BCaHBnVGhqbjVnYTNJN1MvNEs0MWlCckZsVFZBa09r?=
 =?utf-8?B?MFljaTdaMkZPbmJTVzNOb0RZY0NkdzJOQmVIZy9FYkJMSllSTGhwQ0xpWldr?=
 =?utf-8?B?Y1EzdlF1MFN1YzFwdytEeGx0QkdpbFBVQkFGUW1Rc2xaZURMcXErdk5vRXdy?=
 =?utf-8?B?WFU5SFlEYklLellNNHhLdFMzZHBVMlhueGk0OVF3cmo5RG5kMEdKODNQZ3M3?=
 =?utf-8?B?VWtld1JlcHcwUlcwWFZnRGRFTEFhRC9zVExXVG5FZkNyQVpyR3hCNG5kYzdn?=
 =?utf-8?B?ZkNRSHVzWmJpNHFYN1ZmMElUTTF5eGlzeXNkOTQzblFSeVN0NVVycngxbDUv?=
 =?utf-8?B?UEh4YXBqdmdCWXJMVzhaSllGb0p5anYzOG5FeGIxNUExcy95VDBWSDYrdFdQ?=
 =?utf-8?B?Z0F5WCtsQlJPU1dTRk5YTkVpOGkrZGpsNWthMWZtRzUyTThYWTUvcjdjOGtu?=
 =?utf-8?B?YVRGMmFYRkVPVldqU1hXOFh0aXpyRXYvVlZPRmxHWVB3NVZzYm01YUlzUW5O?=
 =?utf-8?B?cFM3NVF6OVBUS29WTjVIcE1RUDVmTlkrdmxMU1ZxSW9BSWorWmVMQnp2WXpW?=
 =?utf-8?B?Smk3RHVvT2h1VkMvanVDZ1J2eVJ2MEx3ZnJlZyszalplM0FnYytBYUlBSFF0?=
 =?utf-8?B?bHdWc1dhSmdDK2RqdzRUTXFjSERoYXl4MUgrMWtLV01sMWJ5SEhGbjJMcEhG?=
 =?utf-8?B?R2pTeEZPN0RZaXJnQ0pkSmZPS0YyemJJM2ZudFdISG96U0pIKzVKZ3FhbUZH?=
 =?utf-8?B?VDJUb0VGSmVuM0FFTkZaYkg4QnhPVk9NcU42TkN5Qk04a3AveUV2TWl4Tk1u?=
 =?utf-8?B?bStYcnBJYm1PTUxCRG1HckFLNmozcWdOdG1ackxPdHRFNGg0c2tlbjlZaEQ3?=
 =?utf-8?B?elFXT2psZE1WYVordGM1WE5abGgxcEZOMkdVcEtQYXdMV3BCUGl6R25hU1Yz?=
 =?utf-8?B?SC82SmJSQ2NmWit2bS95eVVKNzBBRkhSUmhPQzJSY2dHVmhBUDVoNTlrNmlG?=
 =?utf-8?B?R3FYaEh3VVRhWktWYXlIcHVsOVNTVHcyWmdUMys4Nzd3OXRrSGpwSWJiaXM4?=
 =?utf-8?B?R2FWN0g2YWpuekVKQUdLZ3VuR01GM3JrTjh3c0tDaG5oS3JScTZoZDVRZXhn?=
 =?utf-8?B?TlVUelZQMzhOdWpSalhHMkxEM3pXKzFsVC9PcW1ta0hqMjhkKzJoVzQ1OWZ6?=
 =?utf-8?B?eUdwSVo1SmUvYjVCcGhiK2JzamlBTjRpNDBCSzg2TDdMSGdvbFhYd0FpcFFK?=
 =?utf-8?B?Sk50QkJWaldxWWYyYmRVbE9RamR4SVNhcmxMeXE3NSs0VTgxUml0d0VOYktE?=
 =?utf-8?B?cFFFT00yRkxDekxTRjMwRjVYS2t1RDFaV0lrQVJ6dU50NzBiUkdwTXAya081?=
 =?utf-8?B?S1UrakFsVmxuRko5SUVNd2N5UWlMZjdobU1ONVVQdXRhcnk3am5haFdJWXNE?=
 =?utf-8?B?NS9Ucm5FbE04MjlxbnBpaW9TamVIakdPaUhhRTdkV243NGZJL3lYUzYyTmlG?=
 =?utf-8?Q?QogPV/xBofoTSeW9JI8Qb8Nel?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IwlZeh5OwH4jN5w1/74Im4kzsC5u6rvlOhUk+rGAb8pqS4TgMcWHR4KAJylxh+K+Mw05REWx7cfx5mWsy7q4oY7KNCvdyBT0JhsC4AMVKDXpo3k3/uRadBnYv/Qj/HpFpen1FtrPwvcnC1S4oVSCrHcnDAAefuFvBlu/I2MtMiCWoF6OE8i28ekDTWiOlZe+CBAo0bV8wr9nG5+uOvyxi+m+SDWGvG31HorxpgX/cyImxDB3OOMtE8RHqBv5v7bBFQK6kI82dB9NtYdo2yuLbNSkSlX5fZEgbN7UJpPtGD71mdL8mN1+bnsLSkn24qAWwQLZQEY0WrDdJBFetOhSYNnHtjSnFqTBVUdXIkVaTDj+iM2nG/0yiqeM1aodFHyf9BpBQ6sDRiarR6ltFMufAZbzpHpa0qpn3beYMKa7mJrZvgAx3ghAxuT06JwpGsfjEphpM59okbT/OSGQGzxhRxA4ClMcIn1JmxLNwzUEk4RojNIfuIxdYhm6dAHg2yTVOMH1QX/zdzpUN6xvGjOC06RTj6Qaqw/l81WjskiJDSL1ANIZRU2B6mpZF+k5HLFJEoxU7Cq0P9FtHMotR+khWmSXkdmBPG5yZGjZdWLftyc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 343bf402-7932-4d57-adca-08dcb2b79dc1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 05:54:47.6541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPPr2ZW2qX7Iy4FEZzE0+eNQhmZa1MiFa1qVFTMFhQV7SrifX8XRKrl2x6m/XGSEROYebF3EB08qAnlhfQV4WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7806
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_02,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408020039
X-Proofpoint-GUID: Y6oQkufBzLfhjP6ms0lG3jXZaO27ru15
X-Proofpoint-ORIG-GUID: Y6oQkufBzLfhjP6ms0lG3jXZaO27ru15
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 8/1/2024 1:22 AM, Eugenio Perez Martin wrote:
> On Thu, Aug 1, 2024 at 2:41 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> Hi Jonah,
>>
>> On 7/31/2024 7:09 AM, Jonah Palmer wrote:
>>>>>>>>>>>> Let me clarify, correct me if I was wrong:
>>>>>>>>>>>>
>>>>>>>>>>>> 1) IOVA allocator is still implemented via a tree, we just
>>>>>>>>>>>> don't need
>>>>>>>>>>>> to store how the IOVA is used
>>>>>>>>>>>> 2) A dedicated GPA -> IOVA tree, updated via listeners and is
>>>>>>>>>>>> used in
>>>>>>>>>>>> the datapath SVQ translation
>>>>>>>>>>>> 3) A linear mapping or another SVQ -> IOVA tree used for SVQ
>>>>>>>>>>>>
>>>>>>>>>>> His solution is composed of three trees:
>>>>>>>>>>> 1) One for the IOVA allocations, so we know where to allocate
>>>>>>>>>>> new ranges
>>>>>>>>>>> 2) One of the GPA -> SVQ IOVA translations.
>>>>>>>>>>> 3) Another one for SVQ vrings translations.
>>>>>>>>>>>
>>> For my understanding, say we have those 3 memory mappings:
>>>
>>> HVA                    GPA                IOVA
>>> ---------------------------------------------------
>>> Map
>>> (1) [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000,
>>> 0x80000000)
>>> (2) [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000000)
>>> [0x80001000, 0x2000001000)
>>> (3) [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000)
>>> [0x2000001000, 0x2000021000)
>>>
>>> And then say when we go to unmap (e.g. vhost_vdpa_svq_unmap_ring)
>>> we're given an HVA of 0x7f7903eb0000, which fits in both the first and
>>> third mappings.
>>>
>>> The correct one to remove here would be the third mapping, right? Not
>>> only because the HVA range of the third mapping has a more "specific"
>>> or "tighter" range fit given an HVA of 0x7f7903eb0000 (which, as I
>>> understand, may not always be the case in other scenarios), but mainly
>>> because the HVA->GPA translation would give GPA 0xfedb0000, which only
>>> fits in the third mapping's GPA range. Am I understanding this correctly?
>> You're correct, we would still need a GPA -> IOVA tree for mapping and
>> unmapping on guest mem. I've talked to Eugenio this morning and I think
>> he is now aligned. Granted, this GPA tree is partial in IOVA space that
>> doesn't contain ranges from host-only memory (e.g. backed by SVQ
>> descriptors or buffers), we could create an API variant to
>> vhost_iova_tree_map_alloc() and vhost_iova_tree_map_remove(), which not
>> just adds IOVA -> HVA range to the HVA tree, but also manipulates the
>> GPA tree to maintain guest memory mappings, i.e. only invoked from the
>> memory listener ops. Such that this new API is distinguishable from the
>> one in the SVQ mapping and unmapping path that only manipulates the HVA
>> tree.
>>
> Right, I think I understand both Jason's and your approach better, and
> I think it is the best one. To modify the lookup API is hard, as the
> caller does not know if the HVA looked up is contained in the guest
> memory or not. To modify the add or remove regions is easier, as they
> know it.
Exactly.

>
>> I think the only case that you may need to pay attention to in
>> implementation is in the SVQ address translation path, where if you come
>> to an HVA address for translation, you would need to tell apart which
>> tree you'd have to look up - if this HVA is backed by guest mem you
>> could use API qemu_ram_block_from_host() to infer the ram block then the
>> GPA, so you end up doing a lookup on the GPA tree; or else the HVA may
>> be from the SVQ mappings, where you'd have to search the HVA tree again
>> to look for host-mem-only range before you can claim the HVA is a
>> bogus/unmapped address...
> I'd leave this HVA -> IOVA tree for future performance optimization on
> top, and focus on the aliased maps for a first series.
>
> However, calling qemu_ram_block_from_host is actually not needed if
> the HVA tree contains all the translations, both SVQ and guest buffers
> in memory.
If we don't take account of any aliased map or overlapped HVAs, looking 
up through the HVA tree itself should work. I think calling 
qemu_ram_block_from_host() further assures that we always deal with the 
real ram block that backs up the guest memory, while it is hard to 
guarantee the same with IOVA -> HVA tree, in case that there exists 
overlapped HVA ranges. This is simple and reliable since we avoid 
building the HVA lookup tree around any existing assumption or API 
implications in the memory subsystem, I'd lean toward using existing 
memory system API to simplify the implementation of the IOVA -> HVA tree 
(especially the lookup routine).


>
>> For now, this additional second lookup is
>> sub-optimal but inadvitable, but I think both of us agreed that you
>> could start to implement this version first, and look for future
>> opportunity to optimize the lookup performance on top.
>>
> Right, thanks for explaining!

Thanks for the discussion!
-Siwei
>
>>> ---
>>>
>>> In the case where the first mapping here is removed (GPA [0x0,
>>> 0x80000000)), why do we use the word "reintroduce" here? As I
>>> understand it, when we remove a mapping, we're essentially
>>> invalidating the IOVA range associated with that mapping, right? In
>>> other words, the IOVA ranges here don't overlap, so removing a mapping
>>> where its HVA range overlaps another mapping's HVA range shouldn't
>>> affect the other mapping since they have unique IOVA ranges. Is my
>>> understanding correct here or am I probably missing something?
>> With the GPA tree I think this case should work fine. I've double
>> checked the implementation of vhost-vdpa iotlb, and doesn't see a red
>> flag there.
>>
>> Thanks,
>> -Siwei
>>
>


