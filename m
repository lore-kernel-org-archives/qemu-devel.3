Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B3AC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 17:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCjP9-0001Ej-Nt; Thu, 30 May 2024 13:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sCjP7-0001EV-FR
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:17:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sCjOt-00053q-KF
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:17:29 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44UEf0NT001870; Thu, 30 May 2024 17:17:14 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Doracle.com; _h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D0wkxC6ZEJbI9vbAqVJaP7parm3n9wmeR9BCVqASEtPM=3D;_b?=
 =?UTF-8?Q?=3DoTxWHShVTHh3V4oo4gzyh5aFxBQKS0RJrQ1wHvEu1dOeiC8T9MHBqfH1V1gR?=
 =?UTF-8?Q?uZuSs6pP_G53xm418jESaMsJ7HmOjHgkU38IstwPc2KcP98M7v2yHDtCT/XlN1c?=
 =?UTF-8?Q?t1JDmUPFxLoxlT_abuPsOVknvFGgkQPKvHnakOJL4ulMoSbGpzYjb+aQi4IKLU6?=
 =?UTF-8?Q?Plgmg9zAOPFGTSPNr82w_RliWvBfRYi+uOPUlyFXO4uv51AenRrGGGfSuehZnrh?=
 =?UTF-8?Q?ZnlXAII4AZMHkI1xpXGQV2bMAV_N0FEVXUYvNNaXAUXIngd89cpcMDJG3/nYqWP?=
 =?UTF-8?Q?Dv1+I0ehxtudHOl7rAVtLZkwpaJiwQ80_Yg=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8fchjdt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 May 2024 17:17:13 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44UGOkVf014916; Thu, 30 May 2024 17:17:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3yc538ds7d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 May 2024 17:17:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vg5wB7SkyJT9I3elRs6qXwTn7zjI44mKLTqRFXDLwpLIap+tp6wRO5wuJ1XvX9VVX6s4Fa7+MXPfBnoQC/mCfXz0u3qDGSXsQTV3A+5DUXh11549mE+ION9XB2Pz6d2BESFpZHYUY4hS9nq3vr8erT8G4lVc6jVYvKcaRaRQsuOjjVdJPn5kPeVDm/eK3MNDFpmjgVBdbEtN5yIudzAkLUT/iVX+ll9KpmkQnSX6a/uZFcF4Ueddlf3RRJoEulytrRNuhdqpLIKeXFA+Pj9sBxsIaeq6hdjPucfbVZh6W+wvltcEJVTAY0w9eSmM8h3K0FlNs8bkA7zIjWqPA3+5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wkxC6ZEJbI9vbAqVJaP7parm3n9wmeR9BCVqASEtPM=;
 b=M82NH/8e+fbtnXqOuf4e7U/7+ithAzbtYmbfFqtTSLTbToQPJNVCNAHQbPwoitNbr5gfG2xsYV6bloZsWsb0h9ipBRQweoM5GjGVhNPJTLWwydRHW0wsSU4SoaEBZ/OiLaTKGKE29SyAZ/anmGC71al+8zfNedn5MNyfhnrfB6xaxVmGCqN2b84OHf8Z/Sp7kDFlrh89p74wvgGj1uWKPKcQQgpU5vsdOkuJkcytCqKhrBk6BAZElaXMB/dIyEL7e3pOXISF91wZMnJrSDVSjl2t31ExLnW7JQ6A9fM1hit2h+jQ4WwFCS+W/bQnUXyyA/QhL1ReB6nA0DjQkM0JNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wkxC6ZEJbI9vbAqVJaP7parm3n9wmeR9BCVqASEtPM=;
 b=C/xI/R0+GL1b1QuwXNHnoYvTBjr2Rv5woyfO13gnShtyHaUiQmKMTK1QKvf1dWgsjR19bwuE6+pS/cqHBuKONyAHaKy4h3Xx0R5Fpe7EILeJhy4INo/lxdtjrqnh4gunj7msUczRVijuIkCO8LJZNiY68AMcE0hTeibJWa3lUK4=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CH0PR10MB5195.namprd10.prod.outlook.com (2603:10b6:610:c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 17:17:10 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 17:17:10 +0000
Message-ID: <2fffde4a-de58-4b41-8fcc-c082693d5387@oracle.com>
Date: Thu, 30 May 2024 13:17:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 00/26] Live update: cpr-exec
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, QEMU Developers <qemu-devel@nongnu.org>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <cf8e13ae-cac6-4a8a-82a2-92b63a32b7b8@oracle.com> <87ed9wjey7.fsf@suse.de>
 <CADLect=ODs+-JrT4xOJazVveCtYPyDOCMsfK=2hcR-EJAdWDAw@mail.gmail.com>
 <be4cdd8d-4328-46d4-9b28-3a074d504180@oracle.com> <ZlTG18jRhp7oQTCQ@x1n>
 <102b10d6-034f-453a-8f06-97e8d5869364@oracle.com> <ZlYJgHJwiVkGA7nG@x1n>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <ZlYJgHJwiVkGA7nG@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::26) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CH0PR10MB5195:EE_
X-MS-Office365-Filtering-Correlation-Id: a9329a82-ae70-4e56-88b8-08dc80cc5749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3pLcmtzT3A3bmJmVXpiUS9WN1FqMWxxL3ZGS1NZVUdHTExiR094NDFLREo5?=
 =?utf-8?B?N2VmdkZDZUkveVlkS0gyTHBlckdaRW9tTXk5RlJ1eG9qZkM0WXE3NE05bk5n?=
 =?utf-8?B?Zkpuc2wyQXlyZDZlNHNkVXUyQjdFM1JyL29xTTI4ZkNlT3BZUGpidTFmSW1p?=
 =?utf-8?B?NDExWW9XSkM4MXU0dHBmeEQxYW0veXRqM3ZLMGo4R0xvU0hrWTZONCs1TmtI?=
 =?utf-8?B?N1AraHZLQmkwR3ZIbm9ONW9XTzVmUFFoWVdOYlVLNFZUcCthTHN6RFNSSWpr?=
 =?utf-8?B?bERTbmZQVnUra3pnaHBDT2VrU1BKbmY3c21vU0Z2TnRIMGh3ajh0VWgyMDFu?=
 =?utf-8?B?aFYySWZVNlFuYjZnanE3VGJxNjlaZUNvNFEyVGN4RXN0RmNjS0xhRVoyTW5j?=
 =?utf-8?B?N0crSUtuby9hWFA5ckJPUFkwTWhjRnlwdjQyN1YwRVUwMzBndS95bnpVNGww?=
 =?utf-8?B?eW5kd0NlZnVOSlNyNzZ5TlZSeS81WUhXRmNqenpCazc3TDIzNkhQOHVQWmxm?=
 =?utf-8?B?TlFjTEdRNkhrK3NmSHRuK1JSWFlxdDlPUElFbk9BaENIMC9zb3NFZmVxdUxa?=
 =?utf-8?B?Rkp0Wk56OUV1amxPaTUvY2F4bzJ6eWp1aGdTN0ttc00xVnhPWHlyZERHOTY5?=
 =?utf-8?B?b1g0VDdZSHdQVXp0UmRCSWxITGMyRDdDUTRzZ3JKSVVRdENQZThwd01FbUNP?=
 =?utf-8?B?K0Q1TGVsVkM0VndVNkRLYmRCL2tsdUh1aWNhY2xTUTlCUXQyYlFINXZ6YjZu?=
 =?utf-8?B?NVlTbEhiamorVDYxZjg2SWlDM1lWTkV3Q3FpWUNTb3AwdkVpOUY3bUtQSXZs?=
 =?utf-8?B?UlFGeWVSWUtUL052SFpFbFI4T0ZZdjBBMk51ckE1UFgrTXRjaEU3NFdaNkUy?=
 =?utf-8?B?K2w1YVV1dlExUk94QmhpcGg5aU43QTA3UktjekhxSG9OOThyb2g0NmF1WW9s?=
 =?utf-8?B?UVZobHVYbE9RNFNQWnN2R0Rsa1N4Ti9rdXVGUm91aWxZQTFFbFFFL3d3TU51?=
 =?utf-8?B?SUhCYXYxdmh0V05CaVY1eFB6SWM0eU5BQWxEbjN3bm5MR1dWWHpuTnBHSGxo?=
 =?utf-8?B?OFNSUmQ1OEl2ZkFzWlU3SEwxZU5oOTI2eVRLMmZsT2xjcEpiays1UG5ZWnAv?=
 =?utf-8?B?ZDgrSVExQ1VPUWcxeUtvRUJFV3FPTy9KeU9ONnYrU1MrTjZmeWJTclpiRlJQ?=
 =?utf-8?B?aStLVitKVDE3S2VOZXAyV2lFRFhGOVduMEpTWHN3Tm50OEY3ZkVEMVM1UWIv?=
 =?utf-8?B?VWZqZlg5NGtMZmhEemMzN1d6ZC9GN0w2QzA0dms2Z2tHSHRETnRXYmRHaXZh?=
 =?utf-8?B?UTdvOGFDaHhXTlBsQ1hVb3ZLczgvMzJEdUw5ekc0bU5ZVzBXU2ltNndCY05v?=
 =?utf-8?B?b0toS0RLSDV2OVphWkFFaW5oZDlETmhnNktiZW9ua1VVODhUWnNzSmh5TTJK?=
 =?utf-8?B?MkF1djFHU3ZnaUZkNlVTajNhN0tXR3dEUitlS1gvL2wyVG1hTXNCUGdvK2po?=
 =?utf-8?B?em9SakdiYjdKQTg3T1VjYzJldmFJRjdxQ1hmRDltS2hzOWtoWFRGcUZLTjVB?=
 =?utf-8?B?VDRqWWc1cVhmU24xWmp3V2NnZnRqeHEvNjQxR0YyNHVGb01Gd0o3OWhLeEtR?=
 =?utf-8?Q?c8ui4c2zktJl0h7arrpdYKBNA+/NsL/hAT0uo1UI52WM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zkdnb1BIK2s2VjM2Ync0Ky93c3NLQzljRjg3RXlMSUhCRVNnWHd5OTM4TXVt?=
 =?utf-8?B?bVp5OVNBdXdlM2ZreTJKRTVlWWx5Mk4vZENTN3ZIWjlGZFR0S05wVUU1cWM5?=
 =?utf-8?B?M1hwcHRqckVpQi8xM1lBeXdRWjV3TzdxZGNNWjFNemdHTW9pU0RYc3Vhd01m?=
 =?utf-8?B?WG1SZWI3ZGMrMVJmc003Qk9ibGJOQUtFekhuQUtCbkVKSklreEo3dzg1aHVG?=
 =?utf-8?B?YUZuZXI4WEljcm9tYjg3TklpeXVKaWNtV1daRDQ1NGxqbHh3UFVNQ0l2QnVt?=
 =?utf-8?B?VGZOTTdxbTZVaFVzcGJtTkhEYlNMOUFDYnJlajg4cFZneU1hbklVMW9qYkFO?=
 =?utf-8?B?YXBFYTRZUVN5V1cyRkxuM0o3R1dHWEdNdzJKbE9BbmZOYklSYjAzcWRvdHUz?=
 =?utf-8?B?N1lrWXowZTJaNGF4STFPNFJ4RlJQVmw3OXFVd1Z4ZEw5OUxoOW04eElQZnhn?=
 =?utf-8?B?a1JRdGp5M3hMK201Uy9sVVc1Y1NwdHBILys5VHFNYkRZV1ZYZzJFZUVvQU9N?=
 =?utf-8?B?QWllNk0va3p6TWpnL1ZSZGJLTDAwSEFBdG1uQ2pJNXhFYXRGYTBGK25KcEx6?=
 =?utf-8?B?ZmFlVG9OYjQza0FXcFVOVFE0UnJWSlhSbE16dGh5TTFsbXI3S1E3QmNJeVpU?=
 =?utf-8?B?MW12dVIxNmZ4dklCVHM2R2IzdWZ6M2NabHlqdEM3ck51VDR6R2ZlVGk2SDYz?=
 =?utf-8?B?U1FSWU8rMjNoSjhQWDU2R0lyM2lTUk03SGU3N2dYVDYvMVFvOWp3dVUwZElR?=
 =?utf-8?B?VjRJQ09qN1F3QnhDSGpDK0NJd0xrTGg4WmVOOE1VYmVaNUJ6a2tFTjduVHRQ?=
 =?utf-8?B?WnNlUDZJUkt5VHpzaTUyeVVGSFhMcDhDVHpBN2Yrb1g4NHhncWpyaDFjVlFL?=
 =?utf-8?B?Qk16RXZHQXc4Tkt2M3FpaHdaNWMycWhlVXNneWRiOXYzamFGMnBBMHpaRkZS?=
 =?utf-8?B?aVJvOTFock9wRU1hS2YvY05yS1lKa2RmcWNvanl1djlXaEZaNXR5Vi9lZXJ6?=
 =?utf-8?B?bldjU2hzVzBKUHcvVDF4cGtYZ2pCaWI1STYrWVg5Y1diVUxHVEhvUlhpS1c3?=
 =?utf-8?B?NHFyak8rdklLQUNHTGNhazF4MnBOV3BJMGJ6Y2FIb01yNjFBQjRmazk4Y0Jq?=
 =?utf-8?B?TzdWY05SYm1WejdzekZvTVppU3hVQ0FRKyt2cjF0b1JXS2ZURUNVZDlEdGgy?=
 =?utf-8?B?WC9ONlhDNVBycW9ONkJqcURBQjg1alMyUGJxKzdGWEtiNE1SRXBveXlkVm5C?=
 =?utf-8?B?NWJ5eGJZRkkrNit0dHlxSlJYZHo2aC85aHZxSS9hRnN3TlRsZEttRFlFSGxs?=
 =?utf-8?B?THROTUhUQmhsSi9SV1AzZnFlNTh2Ly83SjBmR1V4U3AvenRuNys3L1Rxc1V0?=
 =?utf-8?B?a1RRQVZNYS9nSlJMakQxODh4dk9qd2d0Z2daakliVEZYY24wYXRsNlBIOVh1?=
 =?utf-8?B?MXF2eExMQWpnL3dxajhadVVWblk5SXFVUlQ3eEFQZzdvc21XVm9ZenRMN3hT?=
 =?utf-8?B?dk1XcTU4VUx4dnQvbm1XVW5mYmE5VkJXdmRZV3ZrSkQ5cGY1QTc3UytWZ3Ex?=
 =?utf-8?B?VG9ZNlhTdDU3T0hmVGwyZUhERkhMaUZyNHRvWVB6V1d2b0hJcE9YRmI0T0t0?=
 =?utf-8?B?OVVZL2hmakw0UnY0TWRrYWttUG9tcXJiT0lmTG42SDRoV1E5NEV3WmExd2ha?=
 =?utf-8?B?ZExHMmdJTzVPM2lsT2VpbUFvdjFoRmQ4cTNzK2lEK1JMbHFvWTNUNGlWL3Js?=
 =?utf-8?B?YkpEc01sSjMyK3BZampiL21FU0ZxaGdTT2xPM09XWWMvMFBoSmVKTnJTL1pB?=
 =?utf-8?B?aTVUUEJrUVpKZElFYXFXajFJUW9FSFhnNktZeDBhaWEva2tmMVpUZGhUOE42?=
 =?utf-8?B?OEg1NzUzTUYwbjhmaG9kaUNQaTFkSE1aczcvSFZuc1JFRmNzaTIzY3RmTGlW?=
 =?utf-8?B?N3A1bnprOERjNzhRcGhCa2s0UTYxM0ZwWEJIN3NsRFBzWkFvazFxTnhvekRn?=
 =?utf-8?B?cG5PNzkrcE5TK1RINzhteTFMMmZhNXBCRXROcG9yS0xObGZyOUlEOEU1SUNX?=
 =?utf-8?B?TUdoK3NNWW9ORHlGU1J5dkNRMURDbXd6cHFHOGRaRHY2UmhybmVOU0RubE1B?=
 =?utf-8?B?dENyL0lGNzIxUnpKRmQwRmJOUlFLMzFQYWhzRmp4QnJEOENtMlZDVDhzVCt6?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6h6tlbkKozIhbt6orJTnI+n1iAqX7Q40lbfr2c4wB479d4DIOC0Lj0+Qgmpb+yrHyY6JjyyNF7mBU5u+nMEFpmyBxb0zPU2KoDEBRWxqQpe597hrG6QI6sYWo+of/Zum3lM8iHm4b+/LLFTj3mohQ03altqCrX4zcNhqdt9JYbTeSChsvBudjZ+3R4/SqX8pX/TO+W/sTOpR/tSLEBaImOiJ6TPley7vLYwkjnAkazf9fR25lI2F0X8ygn5+uotkFsj947Ak8Gkg9nO1Gp4GwGK4eltbgtVdLlAaJ9TUbylCFsVfFpNYE910pyqhVjo0zLY8DL8pkqVeDCal4C/u5CQl6L8OOQXRt72VAQZEMDCvilcZ+O5GviNKSpxc/6y/72+HzXPZVD/E+ywi1IV0v0SDvMmkozFWZLykBb9s/LA4U7MOSk2QgYX0BT+pFX35MXgbHiWuOBHd7FzrvRobRkhmb2wCVe0rmV1gWyuIVHe+04lY8w1gjzpPTCx2P9oKCOA9TSGAiimv3Qyfc/oqGnbc82Q9LB17Jz1y0r7Z5BCV+vQH4L07L+X0J8J/Tc/JWRvDnLWXIpm9wfL+m8jt4kNcVVQsDlTsb+b7IhNSWBE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9329a82-ae70-4e56-88b8-08dc80cc5749
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 17:17:10.6901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6mciJdoT0243ObJJj+9VTLAm63CzvlkIOmnfvCwO146CvxriPiloIF7WcS552iAD5llTtzxiSlXdiqlkfNxLQ8Fd0dObhvbHnZEtvzySi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5195
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_13,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405300127
X-Proofpoint-GUID: ek18ITvEHkgsGvcPbS7trWrzcbwBeiox
X-Proofpoint-ORIG-GUID: ek18ITvEHkgsGvcPbS7trWrzcbwBeiox
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Steven Sistare <steven.sistare@oracle.com>
From:  Steven Sistare via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/28/2024 12:42 PM, Peter Xu wrote:
> On Tue, May 28, 2024 at 11:10:27AM -0400, Steven Sistare wrote:
>> On 5/27/2024 1:45 PM, Peter Xu wrote:
>>> On Tue, May 21, 2024 at 07:46:12AM -0400, Steven Sistare wrote:
>>>> I understand, thanks.  If I can help with any of your todo list,
>>>> just ask - steve
>>>
>>> Thanks for offering the help, Steve.  Started looking at this today, then I
>>> found that I miss something high-level.  Let me ask here, and let me
>>> apologize already for starting to throw multiple questions..
>>>
>>> IIUC the whole idea of this patchset is to allow efficient QEMU upgrade, in
>>> this case not host kernel but QEMU-only, and/or upper.
>>>
>>> Is there any justification on why the complexity is needed here?  It looks
>>> to me this one is more involved than cpr-reboot, so I'm thinking how much
>>> we can get from the complexity, and whether it's worthwhile.  1000+ LOC is
>>> the min support, and if we even expect more to come, that's really
>>> important, IMHO.
>>>
>>> For example, what's the major motivation of this whole work?  Is that more
>>> on performance, or is it more for supporting the special devices like VFIO
>>> which we used to not support, or something else?  I can't find them in
>>> whatever cover letter I can find, including this one.
>>>
>>> Firstly, regarding performance, IMHO it'll be always nice to share even
>>> some very fundamental downtime measurement comparisons using the new exec
>>> mode v.s. the old migration ways to upgrade QEMU binary.  Do you perhaps
>>> have some number on hand when you started working on this feature years
>>> ago?  Or maybe some old links on the list would help too, as I didn't
>>> follow this work since the start.
>>>
>>> On VFIO, IIUC you started out this project without VFIO migration being
>>> there.  Now we have VFIO migration so not sure how much it would work for
>>> the upgrade use case. Even with current VFIO migration, we may not want to
>>> migrate device states for a local upgrade I suppose, as that can be a lot
>>> depending on the type of device assigned.  However it'll be nice to discuss
>>> this too if this is the major purpose of the series.
>>>
>>> I think one other challenge on QEMU upgrade with VFIO devices is that the
>>> dest QEMU won't be able to open the VFIO device when the src QEMU is still
>>> using it as the owner.  IIUC this is a similar condition where QEMU wants
>>> to have proper ownership transfer of a shared block device, and AFAIR right
>>> now we resolved that issue using some form of file lock on the image file.
>>> In this case it won't easily apply to a VFIO dev fd, but maybe we still
>>> have other approaches, not sure whether you investigated any.  E.g. could
>>> the VFIO handle be passed over using unix scm rights?  I think this might
>>> remove one dependency of using exec which can cause quite some difference
>>> v.s. a generic migration (from which regard, cpr-reboot is still a pretty
>>> generic migration).
>>>
>>> You also mentioned vhost/tap, is that also a major goal of this series in
>>> the follow up patchsets?  Is this a problem only because this solution will
>>> do exec?  Can it work if either the exec()ed qemu or dst qemu create the
>>> vhost/tap fds when boot?
>>>
>>> Meanwhile, could you elaborate a bit on the implication on chardevs?  From
>>> what I read in the doc update it looks like a major part of work in the
>>> future, but I don't yet understand the issue..  Is it also relevant to the
>>> exec() approach?
>>>
>>> In all cases, some of such discussion would be really appreciated.  And if
>>> you used to consider other approaches to solve this problem it'll be great
>>> to mention how you chose this way.  Considering this work contains too many
>>> things, it'll be nice if such discussion can start with the fundamentals,
>>> e.g. on why exec() is a must.
>>
>> The main goal of cpr-exec is providing a fast and reliable way to update
>> qemu. cpr-reboot is not fast enough or general enough.  It requires the
>> guest to support suspend and resume for all devices, and that takes seconds.
>> If one actually reboots the host, that adds more seconds, depending on
>> system services.  cpr-exec takes 0.1 secs, and works every time, unlike
>> like migration which can fail to converge on a busy system.  Live migration
>> also consumes more system and network resources.
> 
> Right, but note that when I was thinking of a comparison between cpr-exec
> v.s. normal migration, I didn't mean a "normal live migration".  I think
> it's more of the case whether exec() can be avoided.  I had a feeling that
> this exec() will cause a major part of work elsewhere but maybe I am wrong
> as I didn't see the whole branch.

The only parts of this work that are specific to exec are these patches
and the qemu_clear_cloexec() calls in cpr.c.
   vl: helper to request re-exec
   migration: precreate vmstate for exec

The rest would be the same if some other mechanism were used to start
new qemu.   Additional code would be needed for the new mechanism, such
as SCM_RIGHTS sends.

> AFAIU, "cpr-exec takes 0.1 secs" is a conditional result.  I think it at
> least should be relevant to what devices are attached to the VM, right?
>
> E.g., I observed at least two things that can drastically enlarge the
> blackout window:
> 
>    1) vcpu save/load sometimes can take ridiculously long time, even if 99%
>    of them are fine.  I still didn't spend time looking at this issue, but
>    the outlier (of a single cpu save/load, while I don't remember whether
>    it's save or load, both will contribute to the downtime anyway) can cause
>    100+ms already for that single vcpu.  It'll already get more than 0.1sec.
> 
>    2) virtio device loads can be sometimes very slow due to virtqueue
>    manipulations.  We used to have developers working in this area,
>    e.g. this thread:
> 
>    https://lore.kernel.org/r/20230317081904.24389-1-xuchuangxclwt@bytedance.com
> 
>    I don't yet have time to further look.  Since you mentioned vhost I was
>    wondering whether you hit similar issues, and if not why yet.  IIRC it
>    was only during VM loads so dest QEMU only.  Again that'll contribute to
>    the overall downtime too and that can also be 100ms or more, but that may
>    depend on VM memory topology and device setup.

100 ms is not a promise, it is an order-of-magnitude characterization. A typical
result.

> When we compare the solutions, we definitely don't need to make it "live":

Agreed.  The key metric is guest blackout time.  In fact, the 100 ms I quote
is blackout time, not elapsed time, though the latter is not much longer.

> it could be a migration starting with VM paused already, skipping all dirty
> tracking just like cpr-reboot, but in this case it's can be a relatively
> normal migration, so that we still invoke the new qemu binary and load that
> on the fly, perhaps taking the fds via scm rights.  Then compare these two
> solutions with/without exec().  Note that I'm not requesting for such data;
> it's not fair if that takes a lot of work already first to implement such
> idea, but what I wanted to say is that it might be interesting to first
> analyze what caused the downtime, and whether that can be logically
> resolved too without exec(); hence the below question on "why exec()" in
> the first place, as I still feel like that's somewhere we should avoid
> unless extremely necessary..

Exec is not a key requirement, but it works well.  Please give it fair
consideration.

>> cpr-exec seamlessly preserves client connections by preserving chardevs,
>> and overall provides a much nicer user experience.
> 
> I see.  However this is a common issue to migration, am I right?  I mean,
> if we have some chardevs on src host, then we migrate the VM from src to
> dst, then a reconnect will be needed anyway.  It looks to me that as long
> as the old live migration is supported, there's already a solution and apps
> are ok with reconnecting to the new ports.  

Apps may be OK with it, but I offer a better experience.
To be clear, chardev preservation is a nice feature that is easy to implement
with the cpr-exec framework, but is not the primary motivation for my work.

> From that POV, I am curious
> whether this can be seen as a (kind of separate) work besides the cpr-exec,
> however perhaps only a new feature only be valid for cpr-exec?

You need much of the cpr-exec (or cpr-scm) framework to support it:
a mechanism to preserve the open descriptor, and precreate vmstate to
identify the descriptor for new qemu.

> Meanwhile, is there some elaborations on what would be the major change of
> nicer user experience with the new solution?
> 
>>
>> chardev's are preserved by keeping their fd open across the exec, and
>> remembering the value of the fd in precreate vmstate so that new qemu
>> can associate the fd with the chardev rather than opening a new one.
>>
>> The approach of preserving open file descriptors is very general and applicable
>> to all kinds of devices, regardless of whether they support live migration
>> in hardware.  Device fd's are preserved using the same mechanism as for
>> chardevs.
>>
>> Devices that support live migration in hardware do not like to live migrate
>> in place to the same node.  It is not what they are designed for, and some
>> implementations will flat out fail because the source and target interfaces
>> are the same.
>>
>> For vhost/tap, sometimes the management layer opens the dev and passes an
>> fd to qemu, and sometimes qemu opens the dev.  The upcoming vhost/tap support
>> allows both.  For the case where qemu opens the dev, the fd is preserved
>> using the same mechanism as for chardevs.
>>
>> The fundamental requirements of this work are:
>>    - precreate vmstate
>>    - preserve open file descriptors
>>
>> Direct exec from old to new qemu is not a hard requirement.
> 
> Great to know..
> 
>> However, it is simple, with few complications, and works with Oracle's
>> cloud containers, so it is the method I am most interested in finishing
>> first.
>>
>> I believe everything could also be made to work by using SCM_RIGHTS to
>> send fd's to a new qemu process that is started by some external means.
>> It would be requested with MIG_MODE_CPR_SCM (or some better name), and
>> would co-exist with MIG_MODE_CPR_EXEC.
> 
> That sounds like a better thing to me, so that live migration framework is
> not changed as drastic.  I just still feel like exec() is too powerful, and
> evil can reside, just like black magic in the fairy tales; magicians try to
> avoid using it unless extremely necessary.

Fork is scarier; it preserves almost everything, with a few exceptions.
Exec destroys almost everything, with a few exceptions.
Please give it a chance.  The theorized cpr-scm would no doubt be useful
for some cloud vendors, but so is cpr-exec.  cpr-scm is intellectually
interesting to me, and I might work on it at some point, but cpr-exec is
what I need for our cloud.

> I think the next step for my review is to understand what is implied with
> exec().  I'll wait for you to push your tree somewhere so maybe I can read
> that and understand better.  A base commit would work too if you can share
> so I can apply the series, as it doesn't seem to apply to master now.

Try these tracepoints:
-trace enable=qemu_anon_memfd_alloc
-trace enable=ram_block_create
-trace enable='*factory*'
-trace enable='vmstate_*register'

I sent this to Peter already, but for others benefit, this series applies to
commit 5da72194df36535d77.

- Steve

