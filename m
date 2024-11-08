Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DAFD5C0CF
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 14:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Pku-0001KC-K9; Fri, 08 Nov 2024 09:14:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t9Pks-0001Jl-ME
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:14:30 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t9Pkp-0000Yc-RM
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:14:30 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8EBfak012873;
 Fri, 8 Nov 2024 14:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=vxMetvJlQgYC3bUPTxhHvElXHXZld2/nFGLKeK+lyl4=; b=
 TrOq1xhmE4LStSWl+iNpxiXv374NV+xqHWP/esXXz+pMQKZo/l24X3uuBhkIgcAa
 xTmVFx0Id+wGI1qd6+0gNPu6ZBuqJNzVBN29QylXX+s+auS1uYhdsjwlZg0K4hCu
 l4bkrYZbI+ldm4d1Rnfq9MehpsH6cWTdSSqw0stxbU733tuzzTVDPej+hNKk1bbd
 W3VwWi8EvlREs4zpfzefYMg/BhSdvf4RV8V8w2kgMYGUuhroAOXrdtgBPYi2I5Hu
 wu/B2zQ37Q9wsjvSeKFJDXqyv6S33LeMxvT16xE08Pq3kvn/WI8Ts6orZ/5ILSan
 1wv1PCEzR4p8fMxPSpes0w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42s6jthhak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Nov 2024 14:14:22 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A8DQ31G005129; Fri, 8 Nov 2024 14:14:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42p87ev3pv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Nov 2024 14:14:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfrQg48iin8IF5Ktt3IVbqxpNclilsBqLIXKmGIZRGX8l8NOuWObxGAoZPg9e6j13CcgPM2Gov8i+YTP2PkXigmgZa2dTS/2nDFQIMTs/gQolIZgQq+NMTubW6Dqccu+AnSI+IOc2REe0Zffn3ZAgZlzA7LeKtncC1AjvRQ5E3WavGh4FPne+IqdWQp3Rot4KkwvhFYIsWapk2dbuICEWUp238gnZtWxM16VNvZorqX6zsytF7LlKPW4jmXePK6nBXUPArHtRcuPVOom7swDIzSgrlKQLJPM/s21RRjmPrzP6H2+dKTag9MmeA6Fj6gXfhQb4CN8qNBsYv7PC4AXtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxMetvJlQgYC3bUPTxhHvElXHXZld2/nFGLKeK+lyl4=;
 b=Y+8BYWAzPRzd0l/PUXq55OmjeVLInjoMKIv2j10oLBqG/mLtBGaxumQubRUbs29AMroRbxzWXIB/eeGT22s81LglZ6nKiS3YH98txajID1rfBA2OqpJcJHZfah/l5LdUqOV7tD4fGr7sa79Lfpl89ULCx1FLkBY5Y6VJQcct6/gV5MEryVmCLYFDYOCEfrjM5nMna47/OxdQU4Dibaysw4iLqdFRn9/vKjpXKhThm5NwRlT97mXLH8lnivvkhYeJNe5x8J0Pag+4VK+CaHEk5nR5C4jixpuZQxCz4bGokp1PJPhNisJGMyVmg0RgEj9Ew89O3RZv95jbMC1CLxNHPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxMetvJlQgYC3bUPTxhHvElXHXZld2/nFGLKeK+lyl4=;
 b=ykMHd3Ougd6OKArhM/iC9vRrqDwOvuQgjRytlz8NFQwXUquBkLiS7CEw2fmjzbnHhdEp5408TUoIX5DN6Y47pBvAHQPjDWFzVrySnxDX9vl0j1RMKQvRD6g1L1yfCAkiWMhOnOqKEYLTHYLxv7glFJ3B5a0gLTQdmQws6SYusEc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB6392.namprd10.prod.outlook.com (2603:10b6:806:258::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 14:14:19 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 14:14:15 +0000
Message-ID: <514e4919-45c1-48da-83fb-518fdc12161f@oracle.com>
Date: Fri, 8 Nov 2024 09:14:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
To: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
 <c2ca740b-0178-463b-8262-b149841b8def@redhat.com>
 <bcc4cd7e-3532-475a-8989-211e80bf3eab@oracle.com>
 <09701693-436c-4e1a-8206-03eb26cacab5@redhat.com>
 <66c05a06-dbb7-49ec-b58e-ccd917d098ea@oracle.com>
 <053dd9b6-e4f7-41c8-abe9-ed02214f0639@redhat.com>
 <cce158c4-3bb1-4771-b2c5-f3ae8a2285d5@oracle.com>
 <5b192b5e-943c-4b2f-ab40-ef54ea578363@redhat.com>
 <00261b15-3eef-439a-8501-574e3bb50d95@oracle.com>
 <d00ab1a4-2b72-4202-b810-adeb53a16f01@redhat.com> <Zy4VkScMEpYayGtM@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Zy4VkScMEpYayGtM@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::21) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d8bc92-d8b9-4d1a-3628-08dcffff9ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUZCM1A4WE9VQ3RGVU5ydUVjUUZXb2ZtYnczTEllSnB3aVJkaVZ2WmlVRFZS?=
 =?utf-8?B?WEJaTk9rZzdsSUlmOTA0czhFK1Ria3oyTklKdHBuaGs5SWlsb0tPSXN5eVh0?=
 =?utf-8?B?Q0lGRTcwNld5eXBRSE9yZzVUKzE5OW5ka2tyOFhPU2ZUaFhjY1RQbVNOTjhQ?=
 =?utf-8?B?Rnk3d1drcVAwdUFmbnlPUnlLZkJjR2JpRjVYOXM5TzVqOHlhT0k3NmwxT1lO?=
 =?utf-8?B?V3ZNL2luYVViK3NPbVloa1ZvbjhmNG5YbC83OEJLaG53Q1JkQml6SHU4b2M2?=
 =?utf-8?B?QVZ4UDM1NHVHNEhvOEFaUit6d2VWbEVwVzNHWE82bEtVUUUwWmJmY3M2WG9V?=
 =?utf-8?B?R1hYOUNyb1RvTWM4K3c4OHlFd2l6ZXhhcVNOYW1IUGdRVUR1NjBqOVd1V3U1?=
 =?utf-8?B?UnlKMytkNGdnRmVGamdBWlk4V2R0OW1TN1NNemhnaDBoZEhsbDJEUjMrNXJZ?=
 =?utf-8?B?QWNDek5nWlZ4L3BzMGZ4Qjh1bGJEUFB1eFBLTWJwUUhOeGVKR3M3cmwrZFU2?=
 =?utf-8?B?YXJPb0FKSTY5czlJdFdJajRzSG8yMjZTazcyb1FQTUEzOWJsQWEzUFpPeVFs?=
 =?utf-8?B?QTVBZG5GNVAxWGNlWVptL1VBK2p2RURrcitMVkVDcW1xNHNTeXlXRGRIbDdt?=
 =?utf-8?B?NHBhMkRGM2w4UzJ6OTEydFFYKys5R3dUWmhYbXZGMU5DSGtLZHdjSGtpTHZW?=
 =?utf-8?B?UWJMRU1JTUt0YjN3RkhjSFY0cHR5aDU3dlFYTnpTZ29nek9lZXdYNWY4dnp2?=
 =?utf-8?B?OHljbEsxcDJhakJ1QS9xazlCOENhSDhMS0diV3llam1IajcyOEJoYjNqREN6?=
 =?utf-8?B?QzIvL1JYQVhsclVncTVtWDZWUnl3b1VPZ3ZNc3BDRlNydVk2RndGZjR0akVL?=
 =?utf-8?B?dmhJSGsySlQrMk4zc0JPeWx2bHBmblpuS3ZwNlM2ellDT2pQTEJQT3BDUXRG?=
 =?utf-8?B?UVBhbTFqaVpkV2dWNDVvdjM3ZndWYU8yRnpIYTQyeVJOd3MvMlh0dmc4RlpX?=
 =?utf-8?B?WEtFS2F0SlFBMFFGKzNNMlgvcTQyM3ZCdEFYUmtQZFduTXJGMjdaT1VBYTdJ?=
 =?utf-8?B?eXIreVZIcDNaTHRVUGQzbnBhK2VPU1BzSmd3RzMvVXlMbmxRMUFCYkRxT1BW?=
 =?utf-8?B?R3NIT2gxNEFITi9CSGQ5andMaUJnOXhiQUtHbkpwTnJVeklXZUR1T3JkRXpP?=
 =?utf-8?B?cis4YjJsSXVTV3JXRkVnU2Y5a2k5L1R6Y3M2bm5WWGFGOXYzclRQUmhmTk5n?=
 =?utf-8?B?TjRvYlBneTNPMGhMcEpLQXZqSTBzRUNwQksxTi9rNDVBaTRkWkFEMi9tR0Na?=
 =?utf-8?B?N3YzU20rZGVCVzR1SFMrSGZNMml6Nmw0dXRaZWhJbmtaVW9rSVFSOUxERFlD?=
 =?utf-8?B?N1dBa2NPL2tlQWluL3YvQnB4QmxWeDNWWENmbUt0TUhwTDEzSEFUbGdmbEh5?=
 =?utf-8?B?NEJFbkJVZ245d3YrOHFYZG9hdTY5WE1TN1VObWZLU1ErSk1EZXJCL0ZJTEh1?=
 =?utf-8?B?THliT0JPc2VZbHdRVHVtVnZOWlR4dTFBeGdTVDg3NkFyWHl0OWZlM290UE5m?=
 =?utf-8?B?a3JKQXRMa2lmdnpYR1dzQkplSTdUMzZtdlM3YmdUZFZYRGFrYkhiRGVIL2VV?=
 =?utf-8?B?ejNyc2tSNUE0MFVSeVQ0Z1FFUnhjTHB5WE5IUGZjZmhyclV6ZTZkM2lmM2E1?=
 =?utf-8?B?aE11aGFYWWdXMFhWTVRsd3JOVkpGZ3dpc2pVZllVeGVRZXdSNjRxR1lEZ2Vs?=
 =?utf-8?Q?Jdxk7NKQ9k1PCaEM5mnV0cW3Jj6FPy+woWpRoe/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzhHa0oxem5vVXd0SnJnb2FDYy94ZVoxQUJzTWpSVlllTmJZSGZiZlh0OGI2?=
 =?utf-8?B?Mk9NTCt6bUYwS3MycnpQM3oyMXlrbzg4Z2c3UHNRN05yZnRDdzQrYURhdEJL?=
 =?utf-8?B?OGE2NmRQMjE3TzJvMkl4Z0QwWThJV0xXZk9ZTk9CRW5zTFNvYXJ6aGljMzkz?=
 =?utf-8?B?MXlQVXVkaWV6aUMrWEFzWUVUVGg4eklFRUxjTytTUW4rSDFKZWZXVGQyRnhJ?=
 =?utf-8?B?aFVhOTdJUGJUM1Y1VGZHSDgySGNPbDVQTEVnYllGSnlheFdma2EwYWVmbWs0?=
 =?utf-8?B?dXdlVzZySXN5TXlBdnZqRmlTK3JWV1ZYUHZEN1dMWkN2azlZUnhOVTVjZjJr?=
 =?utf-8?B?c1FJMEhLZ05iUXczN0UxdWRRTEJlRmJ2MytZL0lTaE5QbVRNNDF2VUpHbVhy?=
 =?utf-8?B?RHV0TTlWLzA2b2dseTU5bFp4RHIva1RpQ29IcGkydThnUlBMTDZld2hSSExQ?=
 =?utf-8?B?UUZyZ3ltZHhkRHp0MDh2bUpUZE9BTlh2WnFCVlFxLzVmS1FHb0lSWitpeGtU?=
 =?utf-8?B?eXJmRzBjVGgyQU9FUGxIUzJtaHRldC81TmZmK0xUSmxpL1dqNWFwNkRZVWx2?=
 =?utf-8?B?bC81S0pvQ0I2ejBlWWVZbXo5QnJDUk1nOGZRblEvZlBDckVBWEM0b3VZRTlt?=
 =?utf-8?B?Vk05djFCbkEveElyNmtmRkZkYTNKaGx5U3FncXdvRHN6eG1WOWs2R1U1NDRS?=
 =?utf-8?B?cURhOEFoYUwxbG8zTHo2c2tCNDlBNUdjUnRVYzlpbzVoSW4ySkpVTXJ1eThU?=
 =?utf-8?B?aFI2dG1zSGZicmUreFY2dDBHTkU4SlNiQmVYNWRBNHh0V3JvSkNhdnZQdlM5?=
 =?utf-8?B?S3dmZ2hpeTVTV2Z6eDVxS1hicFllaHlyckN5dnBvdVpTT04rejBXZmppaFMw?=
 =?utf-8?B?WUQrVFdNdnFnclFsN0p4bUdEaXU4anlkdDhwcGt5VmhrWEZpakRnVWI2bk5W?=
 =?utf-8?B?dEFUV3pLY2dlTDd1NDNnaExwS2hXVG5HbmVJZjUxWnQyU0hBOUgyZzVhZVdE?=
 =?utf-8?B?OEZIMzZ2QUEwWFZKS2tScU0xUDRWS0dINFdMS3h5U25BWnlha3I1cDZsZ0dH?=
 =?utf-8?B?UGk3cEswQWkrZjRjZUlEOHdTZStDd1NFS0lCQnl0YW1ZTFRDMVhaSFkvV1Rq?=
 =?utf-8?B?MU9YN1o1Z1BtcTNMWlUvc09MVVNTZGtvS08wNGJqTSsvNDZHd1pGZDQ3M0RI?=
 =?utf-8?B?YmlsSW1jczF1Q0dsdHZKQkZ0VEg1TENSRThURWtWeThCNWxEbWg4S2ZqYmZQ?=
 =?utf-8?B?OUluVmo5VGF1bmNlR2NlakUyUW9BOWhQTXhrMVptWnFvTXYvU0JRWGxGT25p?=
 =?utf-8?B?ZlpWSmhrSmVTR0JVQ1ZJSWdjaytFUnllTDV5NnBuWjhDdlZsQzRkR05GbE80?=
 =?utf-8?B?TE9mUktyL0I3ajZ1TGk4cG8wcndKcW8zOHZaUXRnWlRVQUNCOEpndlRhRUY4?=
 =?utf-8?B?NVU4aXlEdzMzYjVrazFkSWhVcjFFcWRSM1o3aGF3a0VxOElicE1leml6b2xS?=
 =?utf-8?B?WkE2czFiallzQWtqeS8rbUxHclpheUw5U3VFMFJYNWN5VFQ2aVFHQjFqSjFJ?=
 =?utf-8?B?MXNabFI2VTltNW0wRjJmem9zNDdLc3VSemVwQjFOekJQbXQ3aytXQnorYnB2?=
 =?utf-8?B?TzVqV1V3eVFWT252YU9DSzBESjU3bEQ1bTNDM0tmNDVUOVRKbDdsNFordXp3?=
 =?utf-8?B?NU1XRmVFb1BGSDE5bWJBL3BtaU5NbzhsMk0zNERrOTllYlRtN3RtK0k1N3NQ?=
 =?utf-8?B?V21jTm8xNm1NRVp4OG8rZ2JxTG1VdmllWC9TTVgwTEZxTXpVL0ZDcWRzaEVu?=
 =?utf-8?B?ZTZ4bXN3dkhoUHlGZHBFTXVyckdJSk9tYTFSbEVJaU42b1lQWlR4MG9EMHpm?=
 =?utf-8?B?MmZJV25US1poMnhjTGRBbmQ5VkVCZnNzcHdWRElYUFFpdjNsbmNZNnZEeDJG?=
 =?utf-8?B?ZngyQnc0RHdNc2NCYi9kMXRFVkNxOHI1NDZwNGtSSTA0aStQZ01rVkdyWnpS?=
 =?utf-8?B?OXRzTi9lVnp1ZnE3ajllcVoxT0Z0Y3hoZ3VlTFlMUHVaRDNua3BVSUJpTlEr?=
 =?utf-8?B?THRhbkFWc0FucDd2THhwR0ZvVzZVUFJpcnVRbFFOb2xwbGU0Q3JnODdBRlBZ?=
 =?utf-8?B?aXpnS0ZldEduZm5maldKbkIvYVVrL0V6MFUzQUEyWWh3Q0VTZnpkeWYwaWxO?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2ypPnCW+1LC/vKKoTqcoCZzCzBt63ev9usQ9PhS1ktHSdf7fPTdjkDdq+OX5MozRWlYsuxixSOnFNR+Y9mAnlfQT21fwZ7uCh2mty2E5pIrSFapBSXJs8DvoSU9xeCP6vA4qBOR9L2H5KP9ASg35as1JJNBmlcLYI4o35MKc74ae777C3Sw5zAiThPwvs7bdji7LL2cGKUb7QoJRiO847h+20fperhyZ+pymn7/XIjdyr63a4C9mXnLiQXuIHRYYpxX0aUKohlYtxFPPdOtZuwq4OtutP75z/d4cAGmlWJdGyWcYlG/hutUlQxcqQ1xrTYr2UMonHxooFwNhTOwX7PjBwH2ucDslEvZeZqye831TTAw0nBiSwekDTM+P+UY9CptrOQ/dzo/tW60QCpbgdy4bZOUf4PZZXXBXruwLH/YUAvgnatNYqyMhtWNaItgOXlKdooby45ARTmB6zSKh7Q+nMca3ygA3wF5E1y0P0g3A7nCOiR1uhMoKL051Yo/i88rKnm2hVXH7rsz3F3iwV45ebs8jrbfthtdWLbRaju/Td/PnyOHmnZaNoicJDS0RYnJy5z9F+8in2AvnLpWcytBGV5dAXlb9bKL9x3G3xog=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d8bc92-d8b9-4d1a-3628-08dcffff9ce8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 14:14:13.8649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsU5TBWFMGsr1BR9IJ3Gaypb7j5JBxnX28OWfOSTzMN8i+nCN1VMLBCvbNRFOVEGKzfxz9t3TetEZupBxXzuJ3VDYxvxPo5U8pZqxTxy8oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_11,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411080119
X-Proofpoint-ORIG-GUID: xg37CKagPWn1HFq0ba_GEhqgqAUwRuoI
X-Proofpoint-GUID: xg37CKagPWn1HFq0ba_GEhqgqAUwRuoI
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/8/2024 8:43 AM, Peter Xu wrote:
> On Fri, Nov 08, 2024 at 12:31:45PM +0100, David Hildenbrand wrote:
>> On 07.11.24 17:40, Steven Sistare wrote:
>>> On 11/7/2024 11:26 AM, David Hildenbrand wrote:
>>>> On 07.11.24 17:02, Steven Sistare wrote:
>>>>> On 11/7/2024 8:23 AM, David Hildenbrand wrote:
>>>>>> On 06.11.24 21:12, Steven Sistare wrote:
>>>>>>> On 11/4/2024 4:36 PM, David Hildenbrand wrote:
>>>>>>>> On 04.11.24 21:56, Steven Sistare wrote:
>>>>>>>>> On 11/4/2024 3:15 PM, David Hildenbrand wrote:
>>>>>>>>>> On 04.11.24 20:51, David Hildenbrand wrote:
>>>>>>>>>>> On 04.11.24 18:38, Steven Sistare wrote:
>>>>>>>>>>>> On 11/4/2024 5:39 AM, David Hildenbrand wrote:
>>>>>>>>>>>>> On 01.11.24 14:47, Steve Sistare wrote:
>>>>>>>>>>>>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>>>>>>>>>>>>> on the value of the anon-alloc machine property.  This option applies to
>>>>>>>>>>>>>> memory allocated as a side effect of creating various devices. It does
>>>>>>>>>>>>>> not apply to memory-backend-objects, whether explicitly specified on
>>>>>>>>>>>>>> the command line, or implicitly created by the -m command line option.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The memfd option is intended to support new migration modes, in which the
>>>>>>>>>>>>>> memory region can be transferred in place to a new QEMU process, by sending
>>>>>>>>>>>>>> the memfd file descriptor to the process.  Memory contents are preserved,
>>>>>>>>>>>>>> and if the mode also transfers device descriptors, then pages that are
>>>>>>>>>>>>>> locked in memory for DMA remain locked.  This behavior is a pre-requisite
>>>>>>>>>>>>>> for supporting vfio, vdpa, and iommufd devices with the new modes.
>>>>>>>>>>>>>
>>>>>>>>>>>>> A more portable, non-Linux specific variant of this will be using shm,
>>>>>>>>>>>>> similar to backends/hostmem-shm.c.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Likely we should be using that instead of memfd, or try hiding the
>>>>>>>>>>>>> details. See below.
>>>>>>>>>>>>
>>>>>>>>>>>> For this series I would prefer to use memfd and hide the details.  It's a
>>>>>>>>>>>> concise (and well tested) solution albeit linux only.  The code you supply
>>>>>>>>>>>> for posix shm would be a good follow on patch to support other unices.
>>>>>>>>>>>
>>>>>>>>>>> Unless there is reason to use memfd we should start with the more
>>>>>>>>>>> generic POSIX variant that is available even on systems without memfd.
>>>>>>>>>>> Factoring stuff out as I drafted does look quite compelling.
>>>>>>>>>>>
>>>>>>>>>>> I can help with the rework, and send it out separately, so you can focus
>>>>>>>>>>> on the "machine toggle" as part of this series.
>>>>>>>>>>>
>>>>>>>>>>> Of course, if we find out we need the memfd internally instead under
>>>>>>>>>>> Linux for whatever reason later, we can use that instead.
>>>>>>>>>>>
>>>>>>>>>>> But IIUC, the main selling point for memfd are additional features
>>>>>>>>>>> (hugetlb, memory sealing) that you aren't even using.
>>>>>>>>>>
>>>>>>>>>> FWIW, I'm looking into some details, and one difference is that shmem_open() under Linux (glibc) seems to go to /dev/shmem and memfd/SYSV go to the internal tmpfs mount. There is not a big difference, but there can be some difference (e.g., sizing of the /dev/shm mount).
>>>>>>>>>
>>>>>>>>> Sizing is a non-trivial difference.  One can by default allocate all memory using memfd_create.
>>>>>>>>> To do so using shm_open requires configuration on the mount.  One step harder to use.
>>>>>>>>
>>>>>>>> Yes.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> This is a real issue for memory-backend-ram, and becomes an issue for the internal RAM
>>>>>>>>> if memory-backend-ram has hogged all the memory.
>>>>>>>>>
>>>>>>>>>> Regarding memory-backend-ram,share=on, I assume we can use memfd if available, but then fallback to shm_open().
>>>>>>>>>
>>>>>>>>> Yes, and if that is a good idea, then the same should be done for internal RAM
>>>>>>>>> -- memfd if available and fallback to shm_open.
>>>>>>>>
>>>>>>>> Yes.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> I'm hoping we can find a way where it just all is rather intuitive, like
>>>>>>>>>>
>>>>>>>>>> "default-ram-share=on": behave for internal RAM just like "memory-backend-ram,share=on"
>>>>>>>>>>
>>>>>>>>>> "memory-backend-ram,share=on": use whatever mechanism we have to give us "anonymous" memory that can be shared using an fd with another process.
>>>>>>>>>>
>>>>>>>>>> Thoughts?
>>>>>>>>>
>>>>>>>>> Agreed, though I thought I had already landed at the intuitive specification in my patch.
>>>>>>>>> The user must explicitly configure memory-backend-* to be usable with CPR, and anon-alloc
>>>>>>>>> controls everything else.  Now we're just riffing on the details: memfd vs shm_open, spelling
>>>>>>>>> of options and words to describe them.
>>>>>>>>
>>>>>>>> Well, yes, and making it all a bit more consistent and the "machine option" behave just like "memory-backend-ram,share=on".
>>>>>>>
>>>>>>> Hi David and Peter,
>>>>>>>
>>>>>>> I have implemented and tested the following, for both qemu_memfd_create
>>>>>>> and qemu_shm_alloc.  This is pseudo-code, with error conditions omitted
>>>>>>> for simplicity.
>>>>>>>
>>>>>>> Any comments before I submit a complete patch?
>>>>>>>
>>>>>>> ----
>>>>>>> qemu-options.hx:
>>>>>>>          ``aux-ram-share=on|off``
>>>>>>>              Allocate auxiliary guest RAM as an anonymous file that is
>>>>>>>              shareable with an external process.  This option applies to
>>>>>>>              memory allocated as a side effect of creating various devices.
>>>>>>>              It does not apply to memory-backend-objects, whether explicitly
>>>>>>>              specified on the command line, or implicitly created by the -m
>>>>>>>              command line option.
>>>>>>>
>>>>>>>              Some migration modes require aux-ram-share=on.
>>>>>>>
>>>>>>> qapi/migration.json:
>>>>>>>          @cpr-transfer:
>>>>>>>               ...
>>>>>>>               Memory-backend objects must have the share=on attribute, but
>>>>>>>               memory-backend-epc is not supported.  The VM must be started
>>>>>>>               with the '-machine aux-ram-share=on' option.
>>>>>>>
>>>>>>> Define RAM_PRIVATE
>>>>>>>
>>>>>>> Define qemu_shm_alloc(), from David's tmp patch
>>>>>>>
>>>>>>> ram_backend_memory_alloc()
>>>>>>>          ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
>>>>>>>          memory_region_init_ram_flags_nomigrate(ram_flags)
>>>>>>>
>>>>>>> qemu_ram_alloc_internal()
>>>>>>>          ...
>>>>>>>          if (!host && !(ram_flags & RAM_PRIVATE) && current_machine->aux_ram_share)
>>>>>>>              new_block->flags |= RAM_SHARED;
>>>>>>>
>>>>>>>          if (!host && (new_block->flags & RAM_SHARED)) {
>>>>>>>              qemu_ram_alloc_shared(new_block);
>>>>>>>          } else
>>>>>>>              new_block->fd = -1;
>>>>>>>              new_block->host = host;
>>>>>>>          }
>>>>>>>          ram_block_add(new_block);
>>>>>>>
>>>>>>> qemu_ram_alloc_shared()
>>>>>>>          if qemu_memfd_check()
>>>>>>>              new_block->fd = qemu_memfd_create()
>>>>>>>          else
>>>>>>>              new_block->fd = qemu_shm_alloc()
>>>>>>
>>>>>> Yes, that way "memory-backend-ram,share=on" will just mean "give me the best shared memory for RAM to be shared with other processes, I don't care about the details", and it will work on Linux kernels even before we had memfds.
>>>>>>
>>>>>> memory-backend-ram should be available on all architectures, and under Windows. qemu_anon_ram_alloc() under Linux just does nothing special, not even bail out.
>>>>>>
>>>>>> MAP_SHARED|MAP_ANON was always weird, because it meant "give me memory I can share only with subprocesses", but then, *there are not subprocesses for QEMU*. I recall there was a trick to obtain the fd under Linux for these regions using /proc/self/fd/, but it's very Linux specific ...
>>>>>>
>>>>>> So nobody would *actually* use that shared memory and it was only a hack for RDMA. Now we can do better.
>>>>>>
>>>>>>
>>>>>> We'll have to decide if we simply fallback to qemu_anon_ram_alloc() if no shared memory can be created (unavailable), like we do on Windows.
>>>>>>
>>>>>> So maybe something like
>>>>>>
>>>>>> qemu_ram_alloc_shared()
>>>>>>         fd = -1;
>>>>>>
>>>>>>         if (qemu_memfd_avilable()) {
>>>>>>             fd = qemu_memfd_create();
>>>>>>             if (fd < 0)
>>>>>>                 ... error
>>>>>>         } else if (qemu_shm_available())
>>>>>>             fd = qemu_shm_alloc();
>>>>>>             if (fd < 0)
>>>>>>                 ... error
>>>>>>         } else {
>>>>>>             /*
>>>>>>              * Old behavior: try fd-less shared memory. We might
>>>>>>              * just end up with non-shared memory on Windows, but
>>>>>>              * nobody can make sure of this shared memory either way
>>>>>>              * ... should we just use non-shared memory? Or should
>>>>>>              * we simply bail out? But then, if there is no shared
>>>>>>              * memory nobody could possible use it.
>>>>>>              */
>>>>>>             qemu_anon_ram_alloc(share=true)
>>>>>>         }
>>>>>
>>>>> Good catch.  We need that fallback for backwards compatibility.  Even with
>>>>> no use case for memory-backend-ram,share=on since the demise of rdma, users
>>>>> may specify it on windows, for no particular reason, but it works, and should
>>>>> continue to work after this series.  CPR would be blocked.
>>>>
>>>> Yes, we should keep Windows working in the weird way it is working right now.
>>>>
>>>>    > > More generally for backwards compatibility for share=on for no particular reason,
>>>>> should we fallback if qemu_shm_alloc fails?  If /dev/shm is mounted with default
>>>>> options and more than half of ram is requested, it will fail, whereas current qemu
>>>>> succeeds using MAP_SHARED|MAP_ANON.
>>>>
>>>> Only on Linux without memfd, of course. Maybe we should just warn when qemu_shm_alloc() fails (and comment that we continue for compat reasons only) and fallback to the stupid qemu_anon_ram_alloc(share=true). We could implement a fallback to shmget() but ... let's not go down that path.
>>>>
>>>> But we should not fallback to qemu_shm_alloc()/MAP_SHARED|MAP_ANON if memfd is available and that allocating the memfd failed. Failing to allocate a memfd might highlight a bigger problem.
>>>
>>> Agreed on all.
>>>
>>> One more opinion from you please, if you will.
>>>
>>> RAM_PRIVATE is only checked in qemu_ram_alloc_internal, and only needs to be
>>> set in
>>>      ram_backend_memory_alloc -> ... -> qemu_ram_alloc_internal
>>>
>>> None of the other backends reach qemu_ram_alloc_internal.
>>>
>>> To be future proof, do you prefer I also set MAP_PRIVATE in the other backends,
>>> everywhere MAP_SHARED may be set, eg:
>>
>> Hm, I think then we should set RAM_PRIVATE really everywhere where we'd want
>> it and relied on !RAM_SHARED doing the right thing.
>>
>> Alternatively, we make our life easier and do something like
>>
>> /*
>>   * This flag is only used while creating+allocating RAM, and
>>   * prevents RAM_SHARED getting set for anonymous RAM automatically in
>>   * some configurations.
>>   *
>>   * By default, not setting RAM_SHARED on anonymous RAM implies
>>   * "private anonymous RAM"; however, in some configuration we want to
>>   * have most of this RAM automatically be "sharable anonymous RAM",
>>   * except for some cases that really want "private anonymous RAM".
>>   *
>>   * This anonymous RAM *must* be private. This flag only applies to
>>   * "anonymous" RAM, not fd/file-backed/preallocated one.
>>   */
>> RAM_FORCE_ANON_PRIVATE	(1 << 13)
>>
>>
>> BUT maybe an even better alternative now that we have the "aux-ram-share"
>> parameter, could we use
>>
>> /*
>>   * Auxiliary RAM that was created automatically internally, instead of
>>   * explicitly like using memory-backend-ram or some other device on the
>>   * QEMU cmdline.
>>   */
>> RAM_AUX	(1 << 13)
>>
>>
>> So it will be quite clear that "aux-ram-share" only applies to RAM_AUX
>> RAMBlocks.
>>
>> That actually looks quite compelling to me :)
> 
> Could anyone remind me why we can't simply set PRIVATE|SHARED all over the
> place?
> 
> IMHO RAM_AUX is too hard for any new callers to know how to set.  It's much
> easier when we already have SHARED, adding PRIVATE could be mostly natural,
> then we can already avoid AUX due to checking !SHARED & !PRIVATE.
> 
> Basically, SHARED|PRIVATE then must come from an user request (QMP or
> cmdline), otherwise the caller should always set none of them, implying
> aux.
> 
> It still looks the best to me.

Our emails crossed. We could set PRIVATE|SHARED all over the place.  Nothing
wrong with that solution. I have no preference, other than finishing.

- Steve



