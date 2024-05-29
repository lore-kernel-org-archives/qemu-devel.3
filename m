Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48375C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 17:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCN9r-0006vx-Vw; Wed, 29 May 2024 13:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sCN9m-0006jy-Jl
 for qemu-devel@nongnu.org; Wed, 29 May 2024 13:32:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sCN9j-0000Od-Ay
 for qemu-devel@nongnu.org; Wed, 29 May 2024 13:32:08 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44TGYWIf010960; Wed, 29 May 2024 17:32:02 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Doracle.com; _h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DF16vwgdGFvS2OIO4LD0tnwA+uLxQLXJHr/M0W9aDEtg=3D;_b?=
 =?UTF-8?Q?=3DKuIsFwpUc39Kw41MF77ctrxVFzfNG9LpxJ1wd3hi06mI5f5vgVYcTsjDbRxZ?=
 =?UTF-8?Q?JspjzVB3_Y4unfb+gdTjBUWucJ3TzH7P4+Pb+Byew7ZS2lP3xZV4aFVzg46Ve8E?=
 =?UTF-8?Q?gUEKldWHEL6uPx_/wVKfNr4bIvDUrggfTW2jIvDRz9npRsw4e+InbMZE7+s+3I/?=
 =?UTF-8?Q?WlEQwX/1Myt4rV7ncKRQ_8tkM+muJkbafAp5e694tcrVbLhqs4SHMm5J1RO6Eg5?=
 =?UTF-8?Q?hTbmYNkvHE2lsd+8WlA2RZrM2v_wRKhdf2zg/dio6Hpzxk8a+sftY8B7g8n1N9S?=
 =?UTF-8?Q?2Fpy9t3XAPZJyuNHJCsGifwlNW0loyiZ_IA=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hu7a2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 May 2024 17:32:01 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44TH3xqj010746; Wed, 29 May 2024 17:32:00 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3yc50yj7jq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 May 2024 17:32:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faJeWthLGa9sKUoUHPUd1RznV407bAAAEcmR9awP9aEjc61/IWn8sSDdphwGtNys5n7bWGYl2qzWevc6Xhh0BeZeBGSGJy01aK/3zpb+3MwBFt9/Of5Pb1iOgUwXR5SfyQstDgGPojhqhkWRAAJqMXjza6c/2Qo7XBDegzTuwZo7Dg3K38ZUYkx6+SrgkJVZj/CGWB/hWcm/zRjs7R2jNelj7+nPAuS73ZKsbBlOSceFToLnZbdS09dafIB5LVSmUs5yuKAOs7bxJDn5tMQTqHKrIZ12R2b8u7FNE2rgXyUV52WyqTa5Vss5TS/IaTM0wAsoZ38IjfucWc+s8GCDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F16vwgdGFvS2OIO4LD0tnwA+uLxQLXJHr/M0W9aDEtg=;
 b=Ag2vsobRBMX1by5rBbCag4zRkvGIp39qKGaq+SHHsA8/yHqMO6WKw+iy6EkSfCd2ibp0Xfej4tXKDTHftDpefrAn0Z6FwSBDQuEgc1sBxMaBP6kD0LzraLRmTwcyeyfX1bSrNaPsnaktIUw+JdF1yODTwlGMlBF+Pzmo6jxxd+2LiHRi71pFTfUsSf/tNsFTT+nHHclsTNUMljAgGdGhK0Rv1RvwLlL3mF1xgz5HfPaju2SQzWs/Zyq7i/7Mf02tl3G90atummo889wMdSNEVzM8iZjtVLZQnnyNMLbzYBZysTkzaiuGfi3fJQnnUMwGJkA9zSdcLaDkG2I0eZ3CFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F16vwgdGFvS2OIO4LD0tnwA+uLxQLXJHr/M0W9aDEtg=;
 b=aX6j213vb1+jJkCuGUJhsG68reYsYO2ZQMGqIDLNkihD1H41OcxZKF6A5JipyK4KaOwP7wYC4nGB3rVleseJ135O5IBw1FuDmkxEuq3wk1OWCyngWASpsL4tVF7YGD/Gojbj24Gu0zokDg8IdnAWw0QSMmpCvSBy4BD0x4+EuYs=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA2PR10MB4442.namprd10.prod.outlook.com (2603:10b6:806:11a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 17:31:58 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%5]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 17:31:58 +0000
Message-ID: <c3f23e83-81d7-469a-aa04-29785fa6f8d7@oracle.com>
Date: Wed, 29 May 2024 13:31:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 19/26] physmem: preserve ram blocks for cpr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-20-git-send-email-steven.sistare@oracle.com>
 <ZlZQVijf2weEmzYK@x1n>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <ZlZQVijf2weEmzYK@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:208:239::28) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA2PR10MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dfceb5c-cfbb-411d-4692-08dc80053df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkxsK2ljQjZ6MjZEaktqdEt2MmhCTU9WK1MzY1FFMzZKN1dJNWxIVGhkS0lW?=
 =?utf-8?B?L2t5RWFlYmhzK3djdVlmUjQ5WXQzbExhUmgvN09pRlFFV00vT1ZwY3ZzUWli?=
 =?utf-8?B?enpaaHMrd3dVUTVMbFpKYUV3c1k5dFNoNlloVHhVN2NtajlKNFNzQkF5Ni9N?=
 =?utf-8?B?OUxQK1o0STUxaWtLc2FyRk9kUUtQVmk5czJsamxISjBhN3V2VjZXTVdDQW9p?=
 =?utf-8?B?MFlOeGlzZEhEY3ZzWGlta0RlL0gzSzA5UWxENHI4VFRDUlE4OVVGUUg3Y1ZZ?=
 =?utf-8?B?Zjl5MHFTai96WE82QzdUbUtFMmJFSHhxRTEvOGZqTUw4NHdwdUZFd2hZWm12?=
 =?utf-8?B?TkFLUWhaUGwzSnJFRFZhQ0YvSWFQTmlEYkNZUFZFZ3grRlU5cWF1UEZ2QUtN?=
 =?utf-8?B?bnFWbGdWRHJqR0dnMU9OUSs5V3FDSWU4UlBDMTJRb0I1TVRuT2czMjZvVlFB?=
 =?utf-8?B?S3VYem8wd21Yc3dEU2hRRWFKSm5Na3MzZHUvNlBiRm9zSUdoUjFSV2pOZG5C?=
 =?utf-8?B?eUhlZS9wTE5URGVsQW9pd2lsekxydkUxbXYxY01EVVJ1MXZBUTFXMWpOV1hk?=
 =?utf-8?B?UGs4bGt5cy9xWDNKRkxDSkIzT2tRVTgwRk5ldmZ3MFZIZWo1VitWWGFLUEZ5?=
 =?utf-8?B?WUxrdzBjVXJmMUtBdzc1RUYwZTEyVGREcnlicVRPRWlmV203L2pVL3didU5H?=
 =?utf-8?B?VjhtcHM5dzdEdjI4MHpYOWEyVnFGN0s5NTZwa3ZQTzVVZStGckRFdm9YVkgr?=
 =?utf-8?B?YlJ0TDFEc0gySDFRNWdBV2ZyNS9Ib3E1d0JaNGp1b2gzUC83TmkwOHp4UUxp?=
 =?utf-8?B?dFc5YmpmS1Z2RDRGa0lyLzBSVU03VkM5Um4zZVgzUTZXcG9uaktFZzVYbXRL?=
 =?utf-8?B?ZE96T2RWdXRxeUdPTy9tdU5sbkVyZUJzZWQrdUl0dE80ZDhoZkFaQ2hpbkJ1?=
 =?utf-8?B?OEgxZWgweHBHc3dkSlZqU2JBdXBzWEtITUlxVjV5N0FoZUREWE5uTnl0Z0FS?=
 =?utf-8?B?SktjOGEzWXVPUStmRzZMV0x5R21MeHN4cGhoZnZtRUkrV0x5RllqVzU3Sm1L?=
 =?utf-8?B?b1dVbTRlaW00VUw5UmVzS20vbEdQUWlHYWdKTEFOaU0xYUNHMHlCbm5tWUpR?=
 =?utf-8?B?aXRhQmhyUzFEcTQzcndDUmxWYUJLREV0UmhJdVc3dUtYNW9kL2E5QTJKQ0VC?=
 =?utf-8?B?YUVFc1Y0bnV4S2ZLL2VUWFIvdm1yVGZtQXpjTXY0UlY3dzk3MkN3RjJDaUlk?=
 =?utf-8?B?QVdiZmVZU0RFUEI3d2F5aUV0VlJmeHc4VEZhMVM1QmZCM0FLSWVOeHJDRytK?=
 =?utf-8?B?ZXV3RG1jalJja05UclFZcm5zVGszYjhBRURnQ0dwd1Uwem1nTTB3T2lVQkR0?=
 =?utf-8?B?R0E4QmhiSnY3VW1FaUZrNk9wSUFZSE5Vd2VIK0o4aFpHYnFSc3BOOUNFTmxD?=
 =?utf-8?B?Y0Z0ZnFwOTF4TE8yTzJZclpSdkwzREdFVm5yMXRoZ3YxSEROOG92L3ZidDdY?=
 =?utf-8?B?bVRTQklrVFRLVTlXVG5pODZWQytQS1pDbHF2RkdNQ0JrSlczbXVrRmtoVlEz?=
 =?utf-8?B?eUw0Z3FkMG9kVlFXU29zdHlFSjRMRVVBb3dkNVJrYnFDTXBvRGFmejdVekNo?=
 =?utf-8?B?MmhUWitranpWMjJ1WFViTTFxeFAwejUvdTdxOE1abUdBNE10MVlLdzlieTVS?=
 =?utf-8?B?TFAzNFJIMWlocVoxWUlIbzJOdTdOQjk3UExyMlFlcEc2azZIVjg2cllBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlJhZmNQOUR1dVVZMXZzU1ZxRU1abm1vUmpqSG1xNjhDKytPbVYvamYrRGNY?=
 =?utf-8?B?U1Rjc3ByMVlmL3NkM1RQcFRKdW5HT3dtZTZpRmxaWXk5cjVnbisxcnp6WHJm?=
 =?utf-8?B?TWc0TlRMb0tlYjNzQ29FL1ZEdGR3aUc1SFlCRjRsTmVzRUhPMWRjd01UMFVt?=
 =?utf-8?B?UFgvM0ZZdFJ1UlpDNDdQTU5LQ2g2U1RIZTJkQVE3TW0rdElWeHZWeXpXWG9L?=
 =?utf-8?B?TjVQd2REN1RYRXVkTm5UYVVvTStBUFo3UTlBK0pFcVNwRnJyTFNEZ1pUeVBP?=
 =?utf-8?B?R1hyYzE1L29heTQ5S3NZQS9TaVhzUkxkUGcrczJDM0Ewd3BPd3BhUTZva2JF?=
 =?utf-8?B?ZHpsdXU3dlQxR29RQW5lWVB4L1VRZjNWWWFPd0tDMmxJeVZsTzUxRjJUWGNS?=
 =?utf-8?B?T2NhOS9PMmhEUHRrODlHK3pXdnNzNm9ndG5QMHIyWVlGTGU2Nk1jZ3Y4aTZv?=
 =?utf-8?B?TnlaSklhcjF2S2g5RDl2UWY1YWFIMTRvb1pMOENpNVZZRnI0aWxzT1RkaHJj?=
 =?utf-8?B?VmNHNXcvOVBOUGtiTGxhV1hrWjNwWnJwV0dGSGFraStCa2J1NTd2MXc2TDBY?=
 =?utf-8?B?NytRRjUrWW5NcVF1M1p3WnlWVElnMGsxdjc1Vy9VM1ZsdkJsUEtpSmgyTFRu?=
 =?utf-8?B?MzhiazE2OXY1VmszcDgvaEJiLzdTWWdYVVBrN3dHSklERmV0aEJFZkdQdk1C?=
 =?utf-8?B?eGx2YWpQc0VIRTZldWlzMGl3dTVWek5vY29HUzlCQVRVcm9zUHNvOEx6VWJB?=
 =?utf-8?B?UWZ1Sk9oUzJYNGhZb0syck9uN3VUemxyN2hTNEVTaHFwR2crQVZZL21lREpS?=
 =?utf-8?B?b3dld1lWcXlOZ3VBZlpRUGlKM1lEYkw3YnRqdWtLeFovT1o4OTFyNHg3VDRD?=
 =?utf-8?B?YnBFVGxKMEZwUXJuaWRWNWxkaERUNXQrRDVhVmw2aUROazZUWmNWZHZWQTZZ?=
 =?utf-8?B?Q2Fhc2NCNkxtaUFRcFdYOHhaMndJeWVBcVVkelJvQ21mc0lLYjFCU0JZdFc3?=
 =?utf-8?B?LzZlYUZNNDU4U25BViswM2pJZHpvR1l0ZWhWL0xTelh0dlNoZ05MZTlNVloy?=
 =?utf-8?B?dWF3UmxJM3hJZGhZaStOQWZmc3RMdU80VVRYZFRJWEhkam9maENidkZZNWNI?=
 =?utf-8?B?Uit3ZWxoRjU1dUkvaFh6VzlOM05rQTJKUWhnd0Q1WGhnT0pxalFTdkpBTzBZ?=
 =?utf-8?B?YjJaNXZraHFrY2dqVHY0Z3ZkUlZ5M2srRi9YQnVYR05zaW9xQ3pZYVdmdmxW?=
 =?utf-8?B?bnN0b3JTeTk1Z1VVYjI1Qk5pdENoQzA2ZFJoL29odmVjeURGblV4dG1GemNw?=
 =?utf-8?B?RExQZjNENUVDMmVhUnh0cnEzQjVpSmh0VGxsTDJKcVYwL1d2MFUrNUZjdEw4?=
 =?utf-8?B?RFlLNVo5N1NHNFpPNDVjMzBWSjVXTG0vRytZazdjb0lOY1pQakhGbSsxVm0r?=
 =?utf-8?B?djlIanlPOFpNc016b2hNdDNXZHVxU0UxUzc1WSsyUlREeCtnYlV6THhCWHdF?=
 =?utf-8?B?M0tPYlFlQTE5S2k3b01kTFNXeGhSMitoVU5DK0lxZ29EaFNlUXVlcXRZMW1y?=
 =?utf-8?B?T2dsN0JBRnI4MllTSU9mMFBETldla3g4ZE1rZHZ5RzMraGcxWXhpMzlyOEFo?=
 =?utf-8?B?My9hcUg0N3JlMjhlRzMrUFpSbDNGQ0x1WEhvTFU5QUFVSm9VSHNhYWpQNmIx?=
 =?utf-8?B?QXBTTHNNVk84cDkzZFhaZUJnUWkwQ1M4NVZlVUJYRm5LZlp4QnlPYkRLYWVr?=
 =?utf-8?B?R2VFMUN5R0t0VGJNeFlxVlNwZVFPNlhmZzgrOERYaW1kS09FTkxRaDFQdXZC?=
 =?utf-8?B?R3hKTkp2ZzQzSEtaTWN6NTE2a010dGxvTkpKUFlKRVM4WUp1ZmovY0FEcWt3?=
 =?utf-8?B?ZGNJQm92R3NaeTNDRlRRR0l5THRQWU91cVJaRnp2WEhTc2JvakxHc0Y5Z2tl?=
 =?utf-8?B?cFNsV1NiQzNEZTBPdENwRzJZN25oQUdpOGpKbFQyYjV4UDR1R2U1aXBaaktt?=
 =?utf-8?B?NFNRNWVYeW9tc2VWemVRMHErTGlXV2lCY2c4eXByYm5aTUZuaEp2NWdvVTgw?=
 =?utf-8?B?Qmh0RWtlTmJSejNsMjl4d0xGY0ZWREREWjVvdVBBYnRDUTA4RzYwNXdNeW1q?=
 =?utf-8?B?Sjh4Sis5SmhEQnRNMU9CUG8yNXQvOThOZUhnZXZjUDF0bW1yNnNPcUR6Y3hJ?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v9kxmsPSuJV7zfyYIJ5bhxMqV/FdoDouC7hvkyQwXS/CDDWQGmHT78DcKuRnuU42AggeE7KQD0T+88PgAtB3KimMelyHzU+kg4tfV9OGxMo3rVpz6CuXGrUQeJtgjvJydWCoYFvY0VwM7HJyQG0l6ibFBb5dhjeIqRljxtX9b8dnR2EgwXcpix46tsdlQcqxXNYWXEtPCNv4zuSg4jYdWSRCy8U1mg4V7liSumF6sW2doj2pc+j8axi+nSUtHvdBr9TomBY8e9fie903yqEefjJzOw3TMvlZQuySUQSH0vgOX+jm8tAZaWGCxMekRtpBKIk5IaIQvDFtcVII1IJasgrCXNkS7kphExOP9SpkpzUQ/KTx5vtSI4biP4dXyLPgHACge7iMRXFR2GlxXE/K60M2jcO8t0mdSPYadPVGqUFoEOjPbltHg+WLCKhDYo7TQxvi3EWZvNu23/PcUpsRA1M0UBSCn/JJc+M8iqc/XjOILAeRVz1LJkLK8blGmiGj9hwG3z/kWYr7kE7sI0nmhyBjaWPj2o49GN4SlUiZJI7nHIGwmcjUm1goEJ/FZFP0OqBxq8CGW7BW+JVnIuJ1ccD8k6LDq5eBieCNY9KuaEI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfceb5c-cfbb-411d-4692-08dc80053df8
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 17:31:58.3732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1F/zk6ecsuOrBYwzOVpxdbaHTVZjKiXEi82ZRxQfgLj4dm5sIzRMXkLibXqXh9bq7vV0IwONbs93IF1oX/tgDYl8N3KvbxYd0j5fBDDeOr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4442
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_13,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405290122
X-Proofpoint-ORIG-GUID: hT1lwZ2RF8ykCLYcAtdvWhYQSwSPYrTF
X-Proofpoint-GUID: hT1lwZ2RF8ykCLYcAtdvWhYQSwSPYrTF
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/28/2024 5:44 PM, Peter Xu wrote:
> On Mon, Apr 29, 2024 at 08:55:28AM -0700, Steve Sistare wrote:
>> Preserve fields of RAMBlocks that allocate their host memory during CPR so
>> the RAM allocation can be recovered.
> 
> This sentence itself did not explain much, IMHO.  QEMU can share memory
> using fd based memory already of all kinds, as long as the memory backend
> is path-based it can be shared by sharing the same paths to dst.
> 
> This reads very confusing as a generic concept.  I mean, QEMU migration
> relies on so many things to work right.  We mostly asks the users to "use
> exactly the same cmdline for src/dst QEMU unless you know what you're
> doing", otherwise many things can break.  That should also include ramblock
> being matched between src/dst due to the same cmdlines provided on both
> sides.  It'll be confusing to mention this when we thought the ramblocks
> also rely on that fact.
> 
> So IIUC this sentence should be dropped in the real patch, and I'll try to
> guess the real reason with below..

The properties of the implicitly created ramblocks must be preserved.
The defaults can and do change between qemu releases, even when the command-line
parameters do not change for the explicit objects that cause these implicit
ramblocks to be created.

>> Mirror the mr->align field in the RAMBlock to simplify the vmstate.
>> Preserve the old host address, even though it is immediately discarded,
>> as it will be needed in the future for CPR with iommufd.  Preserve
>> guest_memfd, even though CPR does not yet support it, to maintain vmstate
>> compatibility when it becomes supported.
> 
> .. It could be about the vfio vaddr update feature that you mentioned and
> only for iommufd (as IIUC vfio still relies on iova ranges, then it won't
> help here)?
> 
> If so, IMHO we should have this patch (or any variance form) to be there
> for your upcoming vfio support.  Keeping this around like this will make
> the series harder to review.  Or is it needed even before VFIO?

This patch is needed independently of vfio or iommufd.

guest_memfd is independent of vfio or iommufd.  It is a recent addition
which I have not tried to support, but I added this placeholder field
to it can be supported in the future without adding a new field later
and maintaining backwards compatibility.

> Another thing to ask: does this idea also need to rely on some future
> iommufd kernel support?  If there's anything that's not merged in current
> Linux upstream, this series needs to be marked as RFC, so it's not target
> for merging.  This will also be true if this patch is "preparing" for that
> work.  It means if this patch only services iommufd purpose, even if it
> doesn't require any kernel header to be referenced, we should only merge it
> together with the full iommufd support comes later (and that'll be after
> iommufd kernel supports land).

It does not rely on future kernel support.

- Steve

