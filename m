Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA581CA0FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 13:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk28s-0003B0-G5; Fri, 30 Aug 2024 09:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sk28q-00035c-Oi
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:58:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sk28n-0007BV-CN
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:58:20 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UDvsU5012407;
 Fri, 30 Aug 2024 13:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=xtZ1O7au278ZGkZfz0xmV6p5RVpxntILjDvm2mRmXt0=; b=
 NnA65kCRmgZj2vEJn1gspI6TNVUuYiqEJ5iP4wPjReabWRvNfHsuNthrGqC+0E/S
 5B9H3BdpWfqCxX3GsaiO1G2jPf7zg7V3S6X+cOA1CvCiFQQ5zzxw10qr1nYvIUnF
 27V1DicDPZOedq/YEM1OfzLFIfHe0St/fMCQ9tyZanZrWX94gOTc/hZ9ZHr1TUNK
 cYydPgyrsnFTV8B96DFqxBOJ1PPM3lhi1136BElV41/2sj08ASg+olN8bmyPZSNh
 oyUHp/JPlF0iCpWIbqNKnqMeihfE11Zd40pG57wktNIfZDn0PTBEgF+jckpxTLhi
 PyJMPzHrDMc0Ul9R8xRxQg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugxs27-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2024 13:58:15 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 47UDWgYJ020447; Fri, 30 Aug 2024 13:58:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 418j8rus3t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2024 13:58:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jT9kFxEJ/hI0NhuIhZb/byhhLl1PbIkoTn3Xl8uwrHBAkQt/dOx/cZGH7DzpjHwJ/kS2cuXUeRj7GXuqDBfyO2MliQxju+X4PIAmf/kD5GC/LtDmCzGEWBZchSc8uH+K9tdmK9OnGqYtmL0eYNZ6vsziOlao8fYTMEM1+9NdA/5n/ztXlkeZrNFiHg04YfD1k91Xq+mqBVb9C3D8gArkITuHIC2qr708d/og3o6ghtBjcZ53SA4SLrEc7J6KyBwQlVzLUe4HQ93VAG1EG27cyEBMIDlS69TPrBWmR/xGpW/thk9kOpmGymzwWHgnPhwdju79uSFjjbjV3k0fy/1o1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtZ1O7au278ZGkZfz0xmV6p5RVpxntILjDvm2mRmXt0=;
 b=ua8i2x4WUAQYxqVkC5q4acl9fELhMPEu+fi+sM89A4hqOE95gRfctI/5PYTQosEpz/Y0BPsFyL3ZUCw4RedNASYNOotKT9SiiXLr2eDDx2SlcvYBIvDbZxIb5xqVr6Ij4IHHHYuAONeTcM1F4FxRF838pWT4K98rAYp2+6xdGlINVEnvk4kpU0FokPtFoWKgeoGO/xQpiY8mT6arOdM4xHMt/Q0W3B3dg2K8bNnjWfjtfitYTPJ95pe6NCXChwVkmvboJqgNSVM79oTWB8xnYfo6ZCqLFlQL+AaUX0ix3Q8kMOieVLg5veVxH/SZnnQW0+u0/js4PvZy8M/3NHlc/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtZ1O7au278ZGkZfz0xmV6p5RVpxntILjDvm2mRmXt0=;
 b=Eqekac8O2DnidZxTM0LzStpmSLpqnq+iWcsa8aDi+bA3oj9hNsImca6Zlkxcil5jlCUisInc287K/q8TgyxD3DMdf8vdYwyWJtytp4+aO9rnqD5s2fY7FR/sdFAxSnKNRixnF0Ybcv0RCppSSLCbPmqHDhOTya3q0/RXyh00leM=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by IA3PR10MB8018.namprd10.prod.outlook.com (2603:10b6:208:50b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 13:58:11 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 13:58:11 +0000
Message-ID: <e796af9b-b810-4dab-96b4-01f8c13b1699@oracle.com>
Date: Fri, 30 Aug 2024 09:58:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] vhost-vdpa: Implement GPA->IOVA & IOVA->SVQ HVA trees
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com,
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
References: <20240821125548.749143-1-jonah.palmer@oracle.com>
 <20240821125548.749143-3-jonah.palmer@oracle.com>
 <CAJaqyWcZbr=xVN4jdxiy09AgX6Me6vSsxSneqQJJ6LSk+4A4rA@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWcZbr=xVN4jdxiy09AgX6Me6vSsxSneqQJJ6LSk+4A4rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::23) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|IA3PR10MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: d8da46f6-1ab3-4bd4-538d-08dcc8fbc92c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzdqeTFwUWhBckkyK2VaV3ZnUjJHdW5ybzBtOU1Id3ZFekR0SytZdDJnY3d2?=
 =?utf-8?B?ZGpsUUR5Q0YveElBMGRUQVBCN1QwcmRuTFByUnRPRWRLbmE2aExyRC9MNVJ1?=
 =?utf-8?B?c1A3TWhYZU5sbnYyVEcrNUpIdURONFNRaDJNdHNtYkcyN3VKcEFpYWZpMkxh?=
 =?utf-8?B?azZhQnpFaEFLcGlPMUpqS2xicUdZcTg2Tm5CbWgxYkN4dWZnZUpkbThieXE0?=
 =?utf-8?B?TVJJYTlsVTZSaG5iRGdMbk5sNnpnMkhpZFRGbmlXOFJnZTVtdE1rL2xKNDZx?=
 =?utf-8?B?Y0xuSERURGJLendGdHZucnN3eTROL2FIK29zZG9tb3RybHo3WldsRFlCZysw?=
 =?utf-8?B?K3B6K0FEY3d4Mkp3Y3UvdzBUdUNXNCtkMXdMQUVNRXVINjlySUxnVW11KytG?=
 =?utf-8?B?cTdWSS8zRmYwTnN5L3F3aUlybkVtYml1YS9xeDh4Z3FmNUt1M1FCMUJ0ZURW?=
 =?utf-8?B?Ylk2eXBlU25Rc0JjY0FEdm1aNjM0c09zUituUERMTkVHQklnN0NOdWNUNDUz?=
 =?utf-8?B?WlhIZDJkeE1hWVdRdDNNWVhtT3VSNndOTTZlZjgrbWxIM0RYY3lEQnpzbVNP?=
 =?utf-8?B?T2F0NHpRNDVvSmJINWMzY2tMM3h4ckxvQTZMMXNsQ1pEREZ0dlM5aGpjMU01?=
 =?utf-8?B?SEpYYkJZRHB5SXZzNGd1OEExd0lVR2I3K0hnN1c0bExtZ0hDUjcyTmZDa0Vx?=
 =?utf-8?B?cUw5VGlKaDZ4TUEvU3hCeHZScVRqZkVrbUUyT3dxV3gyVFVhakJEb3UraU5j?=
 =?utf-8?B?aXJIQ1dndDVTUS9MaUlxK09tWURwNkFoZXE4UnNzSzFURFVHOE1xUlpZdS9Y?=
 =?utf-8?B?TCtDUzlrTlNLWmt1ajA4QXZqQTIybjRCTGcyM0gyeHUrdlhZRVNmT3RSUitE?=
 =?utf-8?B?ZDlCVHBxaCt0dDNWWlZSUjRCZ0g2L1NVdDdoNWVod1NuU2RsaXRtSDNvMUdl?=
 =?utf-8?B?a3pQMzc4ZlhTR011bm95UWN1Y2ZuT0c1SjdFMFh6Y2ZWVzF4QkpQTjlZaVQ2?=
 =?utf-8?B?Q3ljcmd2aWFiaGpKSmcyUm5ERXFqb1l2d292VXpoMlpBU2pROUNkTE1McitE?=
 =?utf-8?B?ZmNCU09kbi9LRlJzTjVFRHN6T2pWWjhqK05QV0k1d2c5UzY0YmN2a3QvVjVN?=
 =?utf-8?B?amNHWFNLRmtZcHJBaUFRbXVzT04zUkU3OFc5YjlzV3dDakRzTDExR0wrWllR?=
 =?utf-8?B?cmxLZGNOUjdpTFZJNFBaSCs4QlVoeDYyUkhjM2RQUWFTV25HRHdoWitqSU5Z?=
 =?utf-8?B?aEoyQmhOU2ZLd29ibEczTktFekJCaXpEMy9qakwyZGtsREYyenBmZWQwU01R?=
 =?utf-8?B?bzUrNmR1L0YxR1doSlpVc081ZjhzM0p5SUE2UitJdGNRSWJ6eGpnYUQ3Qndr?=
 =?utf-8?B?Mk41ampoSzN2U25mTmVpRXN1TFlLYkVCOWc0TDRVeHZNM2Nlayt2MDVpSkla?=
 =?utf-8?B?RzJlckdBSk1GNFNEY0RTMWVXcEJEMi9ZUEM5eStwS0xwekNtdG1WWXpkSkJS?=
 =?utf-8?B?WHlTWXNZSzRCN3ExNUhFdHBBL2dKQ2w3RjBYbkMzV3Z2aFZkSlpGQ0lESVlS?=
 =?utf-8?B?eVNYeXlDcFc5bTFVblVGbkR1M2xkbWV0b3dpdU5EZXZiOVJ4YTdvM09HUzd6?=
 =?utf-8?B?NC80WDV3Tk9aaGNtL0dud2VjSUhuVkE4MUl1OEo2WUMzZzkva2JuVFI5c2I3?=
 =?utf-8?B?N2ZWbmNxWnU1SHRBRlRwL1EySUNpL1MrTXNwTlVtU3ltRnJ3Z3A5Y2R2Z1RZ?=
 =?utf-8?B?a2ZZYnh3dG01SkMzbUkxMlRnQk9TUVl4T3dLZHB6S1RUZUxKdi8yUE1HTHhF?=
 =?utf-8?B?TVdUc09Wam9YUTJBYlVhZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3dMS0lIM3RubzRtZm1NSHZFZmVJckFlK2pCY3ZhNUZyYm9wK2crVVpGbEdL?=
 =?utf-8?B?Q0oyM0lnbWNicStrdGlBQWVQa0x4dk1JYXZRQVppVGQrMXZ1ZmxDSXYyOGhE?=
 =?utf-8?B?YzJvSFoxdVlTUERFcm9FbTV4aENuMW1PRU1xRHRGbEprMFJoVkVMdFhPL2dI?=
 =?utf-8?B?MWhMMDlUYkVvODg5SjlSeDVESkNnQlFjZVc3Q3pYRnZ4aEJWNEdkM2tmRUtQ?=
 =?utf-8?B?RlRkU2c5NE13K3RLdjJub2V1UjloRjlNOTcrREVycUkyTmwvMFlGWjdYSmtz?=
 =?utf-8?B?RFMzT3JQOVdYNXdKVjY1QUFrS3crRDRCcXhsQ3EwaEFnaFFtUE9DSVUxRWt0?=
 =?utf-8?B?TG1XdU80TFl2U3hHVjVkRUwyeXFzbDlEMGhNNGgvYm8wZ1RqQjh0R3BPRDZG?=
 =?utf-8?B?cUFpeEF3akV5TXZ3V1pMK0FhczF1RENnV1hUMzJ4bUFJUzhVVExHL29kSjhY?=
 =?utf-8?B?NUYvM29VbkkwTGJvZ1pxS3ErcXJRRFJHeFdIVjJjY2tRdUtCVnJseUN1Mnlw?=
 =?utf-8?B?cFd5d21PMkZQclFSNU9TRWk4dWljYVcyNWNQNG16Q084VmpPeFp0OHRreTFC?=
 =?utf-8?B?WG1KbERLWjNsSU9nbmplcDBvYWRWaUpsTG5STTY0QnQ3elNFZm1vZ1hVMnh5?=
 =?utf-8?B?YWR3TFE0Q1UyL0NPeDVkbGoxVUowdXROZndqYjQ0V2U5YjYrbHNNN2ozbnFu?=
 =?utf-8?B?NFZscVBYVmVJcThFNzFaampaSEpYOUloR0w5U0cwYUVTaDk3dXFpSkdNU3lP?=
 =?utf-8?B?dFRuL2hZaEVBWFlCTUMvTTBtcENxQWhGWW4vSW91SEJQcVBQdVpPTlBXN0JB?=
 =?utf-8?B?R0V0c3A3bUVCZVYzUXJoMERWZzljYlZIWFVtVWY0ZGxzbzNURndyU3Nadjg0?=
 =?utf-8?B?WSt6ZWY1Vk0rNm9JQkR3ZGVPOVBHODBYNi9ta0hiRVVHSlpQQ3lXWmlOc0Z5?=
 =?utf-8?B?V2NFQ1MzOWVZQnEvR3kybnlTOGNOWG83b2REM2xCNW53TWNBRGs1Ui9oNXFi?=
 =?utf-8?B?MFpKSDNTWTFJYmxPSWJoYnA4SHRiZDlIVW9RTm40ZWcvOTZIUFRWK1krV1Jt?=
 =?utf-8?B?dkxvWUU2N3prVzNrb3BWYVR0bG9qSlV4ZzlxRmR0cU5LUTd2eHNxNDBkZWhh?=
 =?utf-8?B?TjFHTWlaSHk2VWlQQWdlK24ybTBIbFVpTk56Y0hwZHhIc09iL0t6OUhRRXBV?=
 =?utf-8?B?SjVQL1A4aEF4dk5WUldzZ0J5WUhzTXdXT1R0by9iTklhbEZuVk1aQVhuWTlC?=
 =?utf-8?B?eU1jNURJeDVxODRqSnNBbU5oclkyQndrTVV2Z2xEcmJZd1VYTUNjZWlCTUc3?=
 =?utf-8?B?czJSS3F2a1F5Q0twMTNLT1pVZUdNdnFpa2VNTnFKRG04UzdTZmQ5c3o2UHlk?=
 =?utf-8?B?SllHR3pSYTA3UVhpei9uanFtaTdkTEhWMXRzZ3BqSjVaQ1JNeEJmOStSUmtW?=
 =?utf-8?B?SGwrektKOHZLdHR0T1dlSWJFQy8rT0Y1SiszcDBuWDN0eDc3RGEvVEFvMjla?=
 =?utf-8?B?ZFlRdW5vVlNFUWhPcGV2a2FHM2EvcXhQREcxRStla0d1SGtXZlB2QzN2LzF5?=
 =?utf-8?B?TG9mSTNlbGZFUzhOcC9JMU1Ud1NLNkNBc1hlN2kwdG56MjNjZW9ZT0VQc3N5?=
 =?utf-8?B?ZkFSb1ZJelZVQ0tnM3JoYVBhUS9MWHVMU2wxakc0emtKbzhJa0lpTjRjaWtQ?=
 =?utf-8?B?bTdUeVRSNG4xZFNrbmQ2VjZHYktqT1VPOFFqZGFqWGFTZHZzTUc0WFVBa2k4?=
 =?utf-8?B?NW8rZFVwVFhGMlBkSWdYYnFyNzNtcTRnZWMyS1VrQnhzZ3Vmd0RSOEpLOGN2?=
 =?utf-8?B?dXpsb2crTjZXOHpLZGlLZ1lhN3hxWEU1cU1MZjg1eFY1QTgrOFcyQVNXVDB0?=
 =?utf-8?B?WmttejBDbXpDS3pWb3gxZ0tSUjN3aTNNbHdDMXNibE9xdDZaaHFad01xU1U1?=
 =?utf-8?B?dWJibVgvaW42cm4rdGdFRXB2ZkNTOGIvU0dPTlBpcDBPSENJeTRiUUkxMVJm?=
 =?utf-8?B?RkJWbVZFOG40MFpQbDZ6SUwvelJiaGJwcnJOVFJkeC85VVlrTE1TZlBqNDZt?=
 =?utf-8?B?a1Y2MVo3NmcrQnVHNWg0bG4vZ05tODRCUmF0WHR2d0xORlhuR3NOeEU5Z2NC?=
 =?utf-8?B?bktzVlZtY2VlNkNkTFhLSUNXVkpFcVFFRFpFS0JkU0xBaUtKbTI1TFJhUGlC?=
 =?utf-8?Q?sclPOY+hSV0xRg9zbeVRN6I=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RdDlvkQ34+i/5KUcW9oQfwbrVRUF+JoA4dXOscyD/dxpyN8RS86nKg9aVNtMYidbK0ceGF7hJ/KPntLW1i+ASu1hEaXy4KpNa0mMWKKlCmOuPLtSgrDZhnCR8KdxyrVl1DrMsDbkCApeQ0hL3NE2bPnsmm3rT7E9V05V9gb+HesKCwAY3lC5IQsB24eC/p9Vcv1ZWUO4ILqFKtWszp1GUPdcbIpuTXiDIYjvTzv7jUWHSYhxmF0SEqLF0RXudY+bEiJFwofqmDLyUWAKWRW0idyNC8bqt79dQmBVTs/c8WMZp1u+0gO8jTmgSlH/GTxkTMb8HFyBX4PEZtCwCLiuH5VSqI+LMrzdKAkGYrpFiBp+9toZqHsPeO3BalkYSHk5yDxA97+AGUMzsBtADLL70DiGOuKJkVG4oKxxvJbzZxTi6nKACAkKrQhF9ZTEZdIt3rojq9VQqqwwW4UuYMQNsvEFZGB7fDveCmjaZKkn1gJjgWXJXaw147Oq69kb7XuIvBdU/YABt882Wcb7tB6D8ldxS+5voTn1yoSdDwFsZReSvAE3zxDKZ7X+Rd65Ks0gv6m5PMmQXSaDyWeHjLQ05MAARm3mOQInMg82e3MsD5U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8da46f6-1ab3-4bd4-538d-08dcc8fbc92c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 13:58:11.8592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6l1badKe7b8xfYglJ80lMOLAA50GloXzD5+ElpNGjCRz7ejkFC9PbCDisCz/g4UWdGTndp3sBHw+i0EmZMmfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8018
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_08,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408300106
X-Proofpoint-GUID: W_iV8ROMxRPGjrB4e7iXRwxDFkVqzSnK
X-Proofpoint-ORIG-GUID: W_iV8ROMxRPGjrB4e7iXRwxDFkVqzSnK
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 8/29/24 12:55 PM, Eugenio Perez Martin wrote:
> On Wed, Aug 21, 2024 at 2:56 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>> Implements a GPA->IOVA and IOVA->SVQ HVA tree for handling mapping,
>> unmapping, and translations for guest and host-only memory,
>> respectively.
>>
>> By splitting up a full IOVA->HVA tree (containing both guest and
>> host-only memory mappings) into a GPA->IOVA tree (containing only guest
>> memory mappings) and a IOVA->SVQ HVA tree (containing host-only memory
>> mappings), we can avoid translating to the wrong IOVA when the guest has
>> overlapping memory regions where different GPAs lead to the same HVA.
>>
>> In other words, if the guest has overlapping memory regions, translating
>> an HVA to an IOVA may result in receiving an incorrect IOVA when
>> searching the full IOVA->HVA tree. This would be due to one HVA range
>> being contained (overlapping) in another HVA range in the IOVA->HVA
>> tree.
>>
>> To avoid this issue, creating a GPA->IOVA tree and using it to translate
>> a GPA to an IOVA ensures that the IOVA we receive is the correct one
>> (instead of relying on a HVA->IOVA translation).
>>
>> As a byproduct of creating a GPA->IOVA tree, the full IOVA->HVA tree now
>> becomes a partial IOVA->SVQ HVA tree. That is, since we're moving all
>> guest memory mappings to the GPA->IOVA tree, the host-only memory
>> mappings are now the only mappings being put into the IOVA->HVA tree.
>>
>> Furthermore, as an additional byproduct of splitting up guest and
>> host-only memory mappings into separate trees, special attention needs
>> to be paid to vhost_svq_translate_addr() when translating memory buffers
>> from iovec. The memory buffers from iovec can be backed by guest memory
>> or host-only memory, which means that we need to figure out who is
>> backing these buffers and then decide which tree to use for translating
>> it.
>>
>> In this patch we determine the backer of this buffer by first checking
>> if a RAM block can be inferred from the buffer's HVA. That is, we use
>> qemu_ram_block_from_host() and if a valid RAM block is returned, we know
>> the buffer's HVA is backed by guest memory. Then we derive the GPA from
>> it and translate the GPA to an IOVA using the GPA->IOVA tree.
>>
>> If an invalid RAM block is returned, the buffer's HVA is likely backed
>> by host-only memory. In this case, we can then simply translate the HVA
>> to an IOVA using the partial IOVA->SVQ HVA tree.
>>
>> However, this method is sub-optimal, especially for memory buffers
>> backed by host-only memory, due to needing to iterate over some (if not
>> all) RAMBlock structures and then searching either the GPA->IOVA tree or
>> the IOVA->SVQ HVA tree. Optimizations to improve performance in this
>> area should be revisited at some point.
>>
>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> ---
>>   hw/virtio/vhost-iova-tree.c        | 53 +++++++++++++++++++++++++++++-
>>   hw/virtio/vhost-iova-tree.h        |  5 ++-
>>   hw/virtio/vhost-shadow-virtqueue.c | 48 +++++++++++++++++++++++----
>>   hw/virtio/vhost-vdpa.c             | 18 +++++-----
>>   include/qemu/iova-tree.h           | 22 +++++++++++++
>>   util/iova-tree.c                   | 46 ++++++++++++++++++++++++++
>>   6 files changed, 173 insertions(+), 19 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
>> index 32c03db2f5..5a3f6b5cd9 100644
>> --- a/hw/virtio/vhost-iova-tree.c
>> +++ b/hw/virtio/vhost-iova-tree.c
>> @@ -26,15 +26,19 @@ struct VhostIOVATree {
>>       /* Last addressable iova address in the device */
>>       uint64_t iova_last;
>>
>> -    /* IOVA address to qemu memory maps. */
>> +    /* IOVA address to qemu SVQ memory maps. */
>>       IOVATree *iova_taddr_map;
>>
>>       /* IOVA tree (IOVA allocator) */
>>       IOVATree *iova_map;
>> +
>> +    /* GPA->IOVA tree */
>> +    IOVATree *gpa_map;
>>   };
>>
>>   /**
>>    * Create a new VhostIOVATree with a new set of IOVATree's:
>> + * - GPA->IOVA tree (gpa_map)
>>    * - IOVA allocator (iova_map)
>>    * - IOVA->HVA tree (iova_taddr_map)
>>    *
>> @@ -50,6 +54,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>
>>       tree->iova_taddr_map = iova_tree_new();
>>       tree->iova_map = iova_tree_new();
>> +    tree->gpa_map = gpa_tree_new();
>>       return tree;
>>   }
>>
>> @@ -136,3 +141,49 @@ int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)
>>
>>       return iova_tree_insert(iova_tree->iova_taddr_map, map);
>>   }
>> +
>> +/**
>> + * Insert a new GPA->IOVA mapping to the GPA->IOVA tree
>> + *
>> + * @iova_tree: The VhostIOVATree
>> + * @map: The GPA->IOVA mapping
>> + *
>> + * Returns:
>> + * - IOVA_OK if the map fits in the container
>> + * - IOVA_ERR_INVALID if the map does not make sense (like size overflow)
>> + * - IOVA_ERR_OVERLAP if the GPA range overlaps with an existing range
>> + */
>> +int vhost_gpa_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)
>> +{
>> +    if (map->iova + map->size < map->iova || map->perm == IOMMU_NONE) {
>> +        return IOVA_ERR_INVALID;
>> +    }
>> +
>> +    return gpa_tree_insert(iova_tree->gpa_map, map);
>> +}
>> +
>> +/**
>> + * Find the IOVA address stored from a guest memory address (GPA)
>> + *
>> + * @tree: The VhostIOVATree
>> + * @map: The map with the guest memory address
>> + *
>> + * Return the stored mapping, or NULL if not found.
>> + */
>> +const DMAMap *vhost_gpa_tree_find_iova(const VhostIOVATree *tree,
>> +                                       const DMAMap *map)
>> +{
>> +    return iova_tree_find_iova(tree->gpa_map, map);
>> +}
>> +
>> +/**
>> + * Remove existing mappings from the GPA->IOVA tree and IOVA tree
>> + *
>> + * @iova_tree: The VhostIOVATree
>> + * @map: The map to remove
>> + */
>> +void vhost_gpa_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
>> +{
>> +    iova_tree_remove(iova_tree->gpa_map, map);
>> +    iova_tree_remove(iova_tree->iova_map, map);
>> +}
>> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
>> index 8bf7b64786..c22941db4f 100644
>> --- a/hw/virtio/vhost-iova-tree.h
>> +++ b/hw/virtio/vhost-iova-tree.h
>> @@ -24,5 +24,8 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *iova_tree,
>>   int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
>>   void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
>>   int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
>> -
>> +int vhost_gpa_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
>> +const DMAMap *vhost_gpa_tree_find_iova(const VhostIOVATree *iova_tree,
>> +                                       const DMAMap *map);
>> +void vhost_gpa_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
>>   #endif
>> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
>> index fc5f408f77..12eabddaa6 100644
>> --- a/hw/virtio/vhost-shadow-virtqueue.c
>> +++ b/hw/virtio/vhost-shadow-virtqueue.c
>> @@ -16,6 +16,7 @@
>>   #include "qemu/log.h"
>>   #include "qemu/memalign.h"
>>   #include "linux-headers/linux/vhost.h"
>> +#include "exec/ramblock.h"
>>
>>   /**
>>    * Validate the transport device features that both guests can use with the SVQ
>> @@ -88,14 +89,45 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
>>       }
>>
>>       for (size_t i = 0; i < num; ++i) {
>> -        DMAMap needle = {
>> -            .translated_addr = (hwaddr)(uintptr_t)iovec[i].iov_base,
>> -            .size = iovec[i].iov_len,
>> -        };
>> -        Int128 needle_last, map_last;
>> -        size_t off;
>> +        RAMBlock *rb;
>> +        hwaddr gpa;
>> +        ram_addr_t offset;
>> +        const DMAMap *map;
>> +        DMAMap needle;
>> +
>> +        /*
>> +         * Determine if this HVA is backed by guest memory by attempting to
>> +         * infer a RAM block from it. If a valid RAM block is returned, the
>> +         * VA is backed by guest memory and we can derive the GPA from it.
>> +         * Then search the GPA->IOVA tree for the corresponding IOVA.
>> +         *
>> +         * If the RAM block is invalid, the HVA is likely backed by host-only
>> +         * memory. Use the HVA to search the IOVA->HVA tree for the
>> +         * corresponding IOVA.
>> +         *
>> +         * TODO: This additional second lookup is sub-optimal when the HVA
>> +         *       is backed by host-only memory. Find optimizations for this
>> +         *       (e.g. using an HVA->IOVA tree).
>> +         */
>> +        rb = qemu_ram_block_from_host(iovec[i].iov_base, false, &offset);
>> +        if (rb) {
>> +            gpa = rb->offset + offset;
>> +
>> +            /* Search the GPA->IOVA tree */
>> +            needle = (DMAMap) {
>> +                .translated_addr = gpa,
>> +                .size = iovec[i].iov_len,
>> +            };
>> +            map = vhost_gpa_tree_find_iova(svq->iova_tree, &needle);
>> +        } else {
>> +            /* Search the IOVA->HVA tree */
>> +            needle = (DMAMap) {
>> +                .translated_addr = (hwaddr)(uintptr_t)iovec[i].iov_base,
>> +                .size = iovec[i].iov_len,
>> +            };
>> +            map = vhost_iova_tree_find_iova(svq->iova_tree, &needle);
>> +        }
> 
> I think that having this complex conditional here is a problem for
> future users of SVQ.
> 
>>
>> -        const DMAMap *map = vhost_iova_tree_find_iova(svq->iova_tree, &needle);
>>           /*
>>            * Map cannot be NULL since iova map contains all guest space and
>>            * qemu already has a physical address mapped
>> @@ -106,6 +138,8 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
>>                             needle.translated_addr);
>>               return false;
>>           }
>> +        Int128 needle_last, map_last;
>> +        size_t off;
>>
>>           off = needle.translated_addr - map->translated_addr;
>>           addrs[i] = map->iova + off;
>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index 6702459065..0da0a117dc 100644
>> --- a/hw/virtio/vhost-vdpa.c
>> +++ b/hw/virtio/vhost-vdpa.c
>> @@ -373,9 +373,9 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>
>>           iova = mem_region.iova;
>>
>> -        /* Add mapping to the IOVA->HVA tree */
>> -        mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr;
>> -        r = vhost_iova_tree_insert(s->iova_tree, &mem_region);
>> +        /* Add mapping to the GPA->IOVA tree */
>> +        mem_region.translated_addr = section->offset_within_address_space;
>> +        r = vhost_gpa_tree_insert(s->iova_tree, &mem_region);
>>           if (unlikely(r != IOVA_OK)) {
>>               error_report("Can't add listener region mapping (%d)", r);
>>               goto fail_map;
>> @@ -394,7 +394,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>
>>   fail_map:
>>       if (s->shadow_data) {
>> -        vhost_iova_tree_remove(s->iova_tree, mem_region);
>> +        vhost_gpa_tree_remove(s->iova_tree, mem_region);
>>       }
>>
>>   fail:
>> @@ -448,21 +448,19 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
>>
>>       if (s->shadow_data) {
>>           const DMAMap *result;
>> -        const void *vaddr = memory_region_get_ram_ptr(section->mr) +
>> -            section->offset_within_region +
>> -            (iova - section->offset_within_address_space);
>>           DMAMap mem_region = {
>> -            .translated_addr = (hwaddr)(uintptr_t)vaddr,
>> +            .translated_addr = section->offset_within_address_space,
>>               .size = int128_get64(llsize) - 1,
>>           };
>>
>> -        result = vhost_iova_tree_find_iova(s->iova_tree, &mem_region);
>> +        /* Search the GPA->IOVA tree */
>> +        result = vhost_gpa_tree_find_iova(s->iova_tree, &mem_region);
>>           if (!result) {
>>               /* The memory listener map wasn't mapped */
>>               return;
>>           }
>>           iova = result->iova;
>> -        vhost_iova_tree_remove(s->iova_tree, *result);
>> +        vhost_gpa_tree_remove(s->iova_tree, *result);
>>       }
>>       vhost_vdpa_iotlb_batch_begin_once(s);
>>       /*
>> diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
>> index 2a10a7052e..57cfc63d33 100644
>> --- a/include/qemu/iova-tree.h
>> +++ b/include/qemu/iova-tree.h
>> @@ -40,6 +40,15 @@ typedef struct DMAMap {
>>   } QEMU_PACKED DMAMap;
>>   typedef gboolean (*iova_tree_iterator)(DMAMap *map);
>>
>> +/**
>> + * gpa_tree_new:
>> + *
>> + * Create a new GPA->IOVA tree.
>> + *
>> + * Returns: the tree pointer on success, or NULL otherwise.
>> + */
>> +IOVATree *gpa_tree_new(void);
>> +
>>   /**
>>    * iova_tree_new:
>>    *
>> @@ -49,6 +58,19 @@ typedef gboolean (*iova_tree_iterator)(DMAMap *map);
>>    */
>>   IOVATree *iova_tree_new(void);
>>
>> +/**
>> + * gpa_tree_insert:
>> + *
>> + * @tree: The GPA->IOVA tree we're inserting the mapping to
>> + * @map: The GPA->IOVA mapping to insert
>> + *
>> + * Insert a GPA range to the GPA->IOVA tree. If there are overlapped
>> + * ranges, IOVA_ERR_OVERLAP will be returned.
>> + *
>> + * Return: 0 if success, or < 0 if error.
>> + */
>> +int gpa_tree_insert(IOVATree *tree, const DMAMap *map);
>> +
> 
> I'd keep this GPA tree in VhostIOVATree as other IOVATree users like
> intel iommu do not use it.
> 

So you'd like me to move these GPA-related functions in iova-tree.c to 
vhost-iova-tree.c?

>>   /**
>>    * iova_tree_insert:
>>    *
>> diff --git a/util/iova-tree.c b/util/iova-tree.c
>> index 536789797e..e3f50fbf5c 100644
>> --- a/util/iova-tree.c
>> +++ b/util/iova-tree.c
>> @@ -71,6 +71,22 @@ static int iova_tree_compare(gconstpointer a, gconstpointer b, gpointer data)
>>       return 0;
>>   }
>>
>> +static int gpa_tree_compare(gconstpointer a, gconstpointer b, gpointer data)
>> +{
>> +    const DMAMap *m1 = a, *m2 = b;
>> +
>> +    if (m1->translated_addr > m2->translated_addr + m2->size) {
>> +        return 1;
>> +    }
>> +
>> +    if (m1->translated_addr + m1->size < m2->translated_addr) {
>> +        return -1;
>> +    }
>> +
>> +    /* Overlapped */
>> +    return 0;
>> +}
>> +
>>   IOVATree *iova_tree_new(void)
>>   {
>>       IOVATree *iova_tree = g_new0(IOVATree, 1);
>> @@ -81,6 +97,15 @@ IOVATree *iova_tree_new(void)
>>       return iova_tree;
>>   }
>>
>> +IOVATree *gpa_tree_new(void)
>> +{
>> +    IOVATree *gpa_tree = g_new0(IOVATree, 1);
>> +
>> +    gpa_tree->tree = g_tree_new_full(gpa_tree_compare, NULL, g_free, NULL);
>> +
>> +    return gpa_tree;
>> +}
>> +
>>   const DMAMap *iova_tree_find(const IOVATree *tree, const DMAMap *map)
>>   {
>>       return g_tree_lookup(tree->tree, map);
>> @@ -128,6 +153,27 @@ static inline void iova_tree_insert_internal(GTree *gtree, DMAMap *range)
>>       g_tree_insert(gtree, range, range);
>>   }
>>
>> +int gpa_tree_insert(IOVATree *tree, const DMAMap *map)
>> +{
>> +    DMAMap *new;
>> +
>> +    if (map->translated_addr + map->size < map->translated_addr ||
>> +        map->perm == IOMMU_NONE) {
>> +        return IOVA_ERR_INVALID;
>> +    }
>> +
>> +    /* We don't allow inserting ranges that overlap with existing ones */
>> +    if (iova_tree_find(tree, map)) {
>> +        return IOVA_ERR_OVERLAP;
>> +    }
>> +
>> +    new = g_new0(DMAMap, 1);
>> +    memcpy(new, map, sizeof(*new));
>> +    iova_tree_insert_internal(tree->tree, new);
>> +
>> +    return IOVA_OK;
>> +}
>> +
>>   int iova_tree_insert(IOVATree *tree, const DMAMap *map)
>>   {
>>       DMAMap *new;
>> --
>> 2.43.5
>>
> 

