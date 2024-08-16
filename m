Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB79C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 18:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf1Sm-0006Tv-9s; Fri, 16 Aug 2024 14:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sf1SZ-0006De-0R
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 14:13:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sf1SW-00083B-V5
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 14:13:58 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GHtTjH029169;
 Fri, 16 Aug 2024 18:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=ijHe8418vhhyWs6pZkxiCHPWGeNrcJtkqiCn11RT3pM=; b=
 ITdwUqx7XOE7tQzNC7GlJ72bX8nlAc0FJNkNe+xOAtLxQAm0vRSky9Y16E4JOgOT
 iXQuS/GQd0R7gpGA0xk6UC7BSP+Tzpw78Yq+jJr+org6fc5s8zDLpZidq4ULFUGL
 yvk46iVjcfgI22Vo8r7o5cnvf++6cPSkujLDC32p/xwnFe+Kd9rDHO3vmmdii9cR
 6FArwdicuKqctuGOgnRdlf6hosG9x8sf6I00e1HftB0gFCiaPFbTIg7Uy0LmWuyB
 huIDD9K41/Y8Px5UIvqT/t2tRx4pFAiyiLNxAMfI3kTH8qfth/AWifdlISQNxl4n
 CbDSXLrVG5AOQEMwW1W53Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4104gaqw03-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2024 18:13:53 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 47GGC2iX021274; Fri, 16 Aug 2024 18:13:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40wxnk73nc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2024 18:13:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seClN4novoi5vgBWtCRQCGbCp++HBHj8nrfPpiYEorkDu9DmfGIqLg+OFtQnKohJotI8TBCU28kA831eWJ0Avt5S/hyj9ak0dGYJ/uRTHSsmi3EH6uZIOByjo8r3gBerFDT+NSAf67kcMcYhx8Mn3NfpGJ4ylupZsxoHyxUlufLviDs6So5IBcr6ILwcZmcKUXUTynyLrfaFlN72Xd1353v6MmuXFnfmiPoPoPjiqKCpWbECWIU0N62viy76Ok4y7jmhtRKWmEwM3uleeOUrxlyt9qJ15OnwBpb2RaufkE675buA33HvYzzx8hCFeWu/5Y3F/3HdT4hm6jfM5iNMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijHe8418vhhyWs6pZkxiCHPWGeNrcJtkqiCn11RT3pM=;
 b=DEgnJaFECn4ARVdd0i3FUgaaggK3WTXNOZCyzPqGGhratGZOiG+93q1Zf7qhHK4GSwsZEDX0xUresXPHstv5XxsAc9/vDNP8V5XAE/oDtk2msNNIchhB0RUuSB8zW1jFE7PHXDC4VNsklnhbBDUpnkyal+t/45T2b8Z7GEj4v2ZjRsamBYV4nBAIeHNTvLFFnHP5SzAt5OJ3OMgZNTmgCWLvRVUcbPbJB7LHiUihConomHX6R30miEp9jP7BRPUp/fOPxENrbfnX7d9owXryDNA+Z7TWQsOK2H0ExPBMAAyDVoEwRvdYsK/A+j1wb4Iuk3Lhl3n9azsBaUdClXGGbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijHe8418vhhyWs6pZkxiCHPWGeNrcJtkqiCn11RT3pM=;
 b=pmVUnMJgdCliN9PW6o5Ca4gSfR1//E30kfncxHSvkLXRr08nL1e2JPAM6aN4BnaoKUu1iqPzfnjpjzjHIULFa4nJWArf/EEJsGDOQwFLWzKxXV7Yw7c5wZazd4ykhaf6fqAsvbEc3rS8hOb+NpSqMx7y2JfKBQhwfAKXxqKXTeU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY5PR10MB6022.namprd10.prod.outlook.com (2603:10b6:930:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Fri, 16 Aug
 2024 18:13:49 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 18:13:48 +0000
Message-ID: <c27c167e-1ec2-4273-93fd-17198bf67fec@oracle.com>
Date: Fri, 16 Aug 2024 14:13:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 10/12] migration/ram: old host address
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>
References: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
 <1721502937-87102-11-git-send-email-steven.sistare@oracle.com>
 <87ikw05p1v.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87ikw05p1v.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0014.namprd11.prod.outlook.com
 (2603:10b6:208:23b::19) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY5PR10MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d16965-84b9-45ac-c5a0-08dcbe1f2c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlRkVDhwT003Y050Zk90RWw4QTZrOGVIdC9SYlJHTkorbk9KckxwdkdSVndw?=
 =?utf-8?B?clhBSHNwUlFJdVlsSXRaQ1E3aXY5eE01MHMwL00ydzV3RVZ4MWVrVExFLzYy?=
 =?utf-8?B?V0hrQjJCOE1zcHlwRXBxb1dta1czbjNxcGVyNmlkblcvREpjOWw1QWtoZTRP?=
 =?utf-8?B?TUVRVUF2ZXZRUmpONHdXTklORSs0Y1kzZTd5dyttZTNBSUFndWZBeHZpN2NI?=
 =?utf-8?B?enVqV1BrbnYzUWVVQlRZN0RGUjN2WnpNb0V0R1o4RDVoSSswN0pLNE1oZFRO?=
 =?utf-8?B?R3JkZFVCUzRwWnh4M0M1VFJtNWVkODRLLyt1ckFoNVYwblFsRTdrL3o1eWZH?=
 =?utf-8?B?VjBmT285Y3RCMHhWVHMxSGtCcjNPQnBpWm9pdktzN0V4WG56MXJsdEtDMFZL?=
 =?utf-8?B?b0V0ckVCUVlGT3BhZEhpWWFSeEsrS2xTWnNRenRaQThvbHV6a1p6dUdnak9k?=
 =?utf-8?B?NmNCNEVZaC82Wm1CZVE0MXNlcEJlS1J1RWlWUW1vT29uWG4xRWdHM09aSlBs?=
 =?utf-8?B?QUJIUjB5QXBnNTdhUjVkMFBHU0w0c0tma0pTVWJkRC9TVzZHTnVQZUp3anRv?=
 =?utf-8?B?YllmUDl1Y2FqRit5M0xRb1pCVVhqQ2o1NlA0ckFwNUV3VSt2SGROR3hJbTVu?=
 =?utf-8?B?VUxjOG1FU2E2MnhEekJKSFN2aHFSU3llTlY5cnRyMlg0Sk9jdHBPQTNoazNS?=
 =?utf-8?B?aVR0RWtXTjIwS044bmtUVkM1U3RzTElseWY3aWhMdG9ZWVlwWXpwZE84L0Uy?=
 =?utf-8?B?eUdyNHZUdUFNTjloeWprbjFiK09vczY4a2lJcy92QlJnczJoVU5ad0Q3bGZm?=
 =?utf-8?B?L1JYa00zUHAyekpKZHVmb2ZQNE9HVTZqVXJtVk5ZMUNDYnQvVVNRd3h5M0My?=
 =?utf-8?B?dHhHU0VhR0RUQi9kc2VSbjJIbjVuVDNkdC9pZFlva2JRSlFSWGhyMzZVbk00?=
 =?utf-8?B?Q1JIa0xjQWFFQjNaUmdBbEMrWExPKytXRnc5VUtCR1VrODMxMjl5b3FqVElG?=
 =?utf-8?B?c21iQWluV1pMMGpkUlU5b1AvVEdHa0dvU0x5SE9MSDcxZ2FyTnJNY2dFK3h1?=
 =?utf-8?B?d09vUW1CaU5pUlFLSGhOMUpnNmJ4bGl5ZHlCODY4elA4RUxiQWdndjA2cElC?=
 =?utf-8?B?Vkl6M05PQWdpdEVIS3RGOVBET0hieEtxRW80ZGYwM2Q0dVNlL2k1WTh1eGcy?=
 =?utf-8?B?d0huZDJIN3ZoVjIvN3RpMzhmUWhvSzY2eHpsNGV4SmtBZFBzSlBVWmlaSGth?=
 =?utf-8?B?R2V5K0FnUXMvTzU0Mm92RzdvQUIycXZqT3Rldi8xYWkzUmgvTXZWT1N4MkpN?=
 =?utf-8?B?N1NMTDVoREJWWG4rZU16Ti9WK0dSN1lRbHIvUzg3U0Y3Mk9HTG41MDNVaW01?=
 =?utf-8?B?WkY3SjlpRkNlTjZRdDZGMUVNMWIxTUFxNE53NDlsbG1HNUxXSFpXRGUwSFg5?=
 =?utf-8?B?eEhYQXRHQ0ZFWUFoUHpZeVQxeGtIZTJQdy81UFhhU0N2TDhSUllyWmNrR0cx?=
 =?utf-8?B?cFhSa0VmaXdtQVBkeVRVVmlMWmFJdllzQjdXY2MzU0VsbytrZ0R2cjFCM1V2?=
 =?utf-8?B?Y2I3VExnTjcrRzNUU0xvRnhRTGU1d2tLZTNVZmtGU1dwUUhQMkFWNEMwdmNI?=
 =?utf-8?B?d0xLeDc4SzY4ZXJjdGFXSmRYU1JkcWl2S0ppZ3pGTmVZZjFIMEx5anN5VGp5?=
 =?utf-8?B?c1lVR3BPNXdjNWRUYzNNSWVYTDRLckMrMENIM1JseW9QbjFVRi9uM3FPaW1s?=
 =?utf-8?B?b0RWV1VBSnRlZUp2MGYwemJrWjJBbGlqQkU4V2xlVE01T0pwTTFsdTU4S0Vv?=
 =?utf-8?B?QTZHQkZYV0FGaWIxYzVMUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amp3alVoVGI0bXlYb3F6cGhVYzdHZWRUeG1MUHlVNTJJcHlDRG5LWmgzN0Z1?=
 =?utf-8?B?bzFtRHo4azZTeUpFYU1FMkI4NlprRHc0bXE0emIvNUlTSHduVnNHWnJxMVRl?=
 =?utf-8?B?bDNiL1RMMHBiei91RFczdG52ZklUS0laN3hHaG1zYWpXZnlHdEdzUllIeEZj?=
 =?utf-8?B?b0NOUDhKQm9SWGdpQkUrSnQ2VzlIaHlJTHEwN0ZoVy85R0t4U0RjTjBKeVlm?=
 =?utf-8?B?THNJcTc4bXRHZ2gzSGRVN3Ura3JZc3I4TURuWTVSQk8xYnFZTkxiRXNDcWs2?=
 =?utf-8?B?N1J3VWdIeEV2bmxJSWxmaFFvdzBDSVgwaUFqeHhkU205aG1TREFkMkZPWG16?=
 =?utf-8?B?TllJSVRlUUZtTTYxTitaTGVSZTFwbkZkc3FwTmtkaE0vL0t6NVVZaU0xR0xq?=
 =?utf-8?B?ZWlrWnhGYlhjMDFrNkNmNngyWk9XdTJtU0xTdVlCVHR3dGFnWUtYcHhrMnhp?=
 =?utf-8?B?cVpFRHFlRVFRY2V0UEFBMzltMmZHYkxLVnRLcEV6alczSThNSitNUnk0S1pC?=
 =?utf-8?B?KzFMdGJUZjJSVkoyMkhJTjBVL3lVT01KRlNEMmFUdFBiVDFNQ1hlZWtieCsz?=
 =?utf-8?B?REtBOFkxMVJIYlZRUWtzcHNnRkpzNmI0V0k0dmtoK0Fyc0MwWkQ1Um0rakhG?=
 =?utf-8?B?N2RMcXlIK3YxbUJRWjNHYlA1YnJuS1NYbXRDWFZ1THVyYXhsaVgxS2RMQXRZ?=
 =?utf-8?B?MjV2RzhyYVBJZjNhVWk2eEQwYzRzeW5Da1ppYms0WkRxL0YrMXRKdHhHRFNo?=
 =?utf-8?B?aUJ5V28zZ3R1MEJuelhadlM1VlgvUlVyT3VweURtUStiekhMRmhpdHNyR2Vj?=
 =?utf-8?B?M0h0TXFyY3hqcktiaU1wcjhaVWp0MnI1SXpwS1YxZis4aFg4MjVWT0FSVktF?=
 =?utf-8?B?eTNrdFVMVzV0Z1R0eVFqWDVRZ3Q2dE9OZ0hrL1dWTWtMZmRLb1RjdEtPUVZW?=
 =?utf-8?B?M1FrZU1mU0sva2J6Yy9aRmF4T1RQaEJhWFlrSjVOVjZyZlArYldZTUZWcUxi?=
 =?utf-8?B?QjdmQ0JrVkthclNYUHR3bDJMUnp1aXNUMmRielQ1eTRoYlRReHdMTW1zU1d4?=
 =?utf-8?B?T2k5SmExWVJ3amtXVURRMGtHcXhQaUdhcWd4UGtYdVVDTEREYW1YeTUwZHJ4?=
 =?utf-8?B?L09ya1Y2NUtUa1ViU3JPcGhxY3V4OHNzWThxNEVnajBySjI5aHgrejdzbFJC?=
 =?utf-8?B?UGlLTmZWZjZqbzlCRlo4Zm05c0RVUjVtYy83azVldHNFemhlVkljSmNkb1hQ?=
 =?utf-8?B?cTR0T2FSMjYwUTZZQmpkZUZJWEtUQlBnOEQxak5Ob2VWdXBhNDJqTitCV0RH?=
 =?utf-8?B?a240eFc4R25CRkhZWUt5YnFSQWMrTXo5UTgyWVQyV0pKdXpkZW56VmRwamtn?=
 =?utf-8?B?UGJlaGs0ZXVzbjFTQzhJTzcxbjJKbzlxbWVFYVhSYmZzaTI4ZEJRNTg5Tm5s?=
 =?utf-8?B?QUd1VEEzTVNzWTRZdFFybXU4YkZJQUQxVTVDTkNJQzhHdkRacGVPL1ZxRzJC?=
 =?utf-8?B?TzI0Z1JiTmY4QkZzczd4Ykd2T1ZENEJZUThzNFdKUmZHb3ZJU2lOemJucW0v?=
 =?utf-8?B?QnBnVFFEWnNTL3dsUFZCS0k2dWNzZWxQZXE0dmZubnRuaGJsYnYyM2VJWlZm?=
 =?utf-8?B?VTJyYWtNTnQ5NDJZcG8rSjZxdEQ5K0pLbURKenRERDJ0R3Z4SldWQ1NkbUo2?=
 =?utf-8?B?NEg2K0FQakhRaTN4Zk1VSmxxRjVYQXduRzNtNTlycCtlNTNzVWduTE1BMTBy?=
 =?utf-8?B?Y3FsSDVZVnZXRkpGY0YyRzZ2LzI2OWs2ekt0VnZkcUU5U21WT1N2WjhtR1hs?=
 =?utf-8?B?Ykp6aWdWekF2YUYwcVliNUdPbzdVZVZEUVpUeWd0dUJjL0hkRTE0ZWkxUEtU?=
 =?utf-8?B?SllSdDRzbkpyeC9nTTh4QlVyU016azd0RFFjQk5INnYzQitQSlRIV3RCWVZz?=
 =?utf-8?B?czRlZ1A5S095cVhaVklUL3JldTZVeGNTVzFDT3NZZk43WGxGS3drbU1oTHd4?=
 =?utf-8?B?UWRjNFl1WUNTdjg0Sk1mSElBTWo2aXB0cTBBK09mbXo2Tm9BRWFvQ0RaaUov?=
 =?utf-8?B?aWNYcFNHRUdPbmxvUDBCYWJVY1hCZ2s3aEZFVTg4aXhnV2pabDdhSG9yaTBF?=
 =?utf-8?B?UENWY1NBcUMzNWQ0SU1hL0FXYlRRKzJJK09jWGFYaXc4ZHB6em9lUi9iekNQ?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UplSe6lA0XG+ChepBZJvtgaE3esdGNuJgGDpFhdc9tXFKBgS8o7eD+ZR2M3gX2g5KL8BLfl6IoC+CZy9A2CPxpy2bm5CHbV/LjbIaJWKAs/oSWz/2bb2SfjyCUxdcuMCWUIwkdiKSlNwrkClZ8MIFqM9vnX5ctDg7lSRhhTgS20dtv46CvUPhFdeq+IN3ejhmHT1uvRIL3VTSahdFq1qNxxwgq6Nd6xH+ZUObGN/YaS+pJ7zMZIqJ0YuIQN97Uaad+YUmB3eghknliaRkKf949aGt6Lg0QL5Vfrz+v7BoVJhQgoojh4dciR+4cGCVgLqCyyPvAQqyCgtjy3xNxXZmAmIrPAGb7zsPZI1SAN+a6wUTJiHTUj3eBtZ04APv28LXapQM4PoyReGG5btatdg5S9Bfm5iamU759it+7BD0oNQjmWNtg7dGPoinQNJmL6vomYD1mLBrnkXs10T1lVFt8fbzczuUbjaouG77rysRwIwoLG5xcSSmd5zab69RQjAuV8tu5T3XNov9+vLcwW4No6cUDsrXxm1uurV7+2WS6q6dPIQyhzvkBi068SrGnd3FZQ95RD/yiNujmwXR6tlCE5qdxGUn64YaCPm7rd7mtk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d16965-84b9-45ac-c5a0-08dcbe1f2c98
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 18:13:48.2944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPsDTnR1t7Iw5Tk2QguFIPp0PjxOqhnsidp1Bg7jkofe+0Sl204or4jVTYSedSoArFiKu5sx9XP1hCCjpShBV4t4iEFhcXkmrP1Exv7xcpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6022
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_13,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408160128
X-Proofpoint-GUID: mYcGXwTVd78O1cnZo3yGQsPfa8n1ZilL
X-Proofpoint-ORIG-GUID: mYcGXwTVd78O1cnZo3yGQsPfa8n1ZilL
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/16/2024 1:57 PM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Remember the RAMBlock host address as host_old during migration, for use
>> by CPR.  The iommufd interface to update the virtual address of DMA
>> mappings requires it.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/core/machine.c       | 6 ++++++
>>   include/exec/ramblock.h | 1 +
>>   migration/migration.h   | 2 ++
>>   migration/options.c     | 2 ++
>>   migration/ram.c         | 7 +++++++
>>   5 files changed, 18 insertions(+)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 9676953..0ac16b8 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -35,6 +35,12 @@
>>   #include "hw/virtio/virtio-iommu.h"
>>   #include "audio/audio.h"
>>   
>> +/* TBD: register hw_compat_9_1 with machines */
>> +GlobalProperty hw_compat_9_1[] = {
>> +    { "migration", "send-host-old", "off"},
>> +};
>> +const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
>> +
>>   GlobalProperty hw_compat_9_0[] = {
>>       {"arm-cpu", "backcompat-cntfrq", "true" },
>>       {"scsi-disk-base", "migrate-emulated-scsi-request", "false" },
>> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
>> index 64484cd..8f1c535 100644
>> --- a/include/exec/ramblock.h
>> +++ b/include/exec/ramblock.h
>> @@ -28,6 +28,7 @@ struct RAMBlock {
>>       struct rcu_head rcu;
>>       struct MemoryRegion *mr;
>>       uint8_t *host;
>> +    uint64_t host_old;
>>       uint8_t *colo_cache; /* For colo, VM's ram cache */
>>       ram_addr_t offset;
>>       ram_addr_t used_length;
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 38aa140..b5e3151 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -442,6 +442,8 @@ struct MigrationState {
>>        */
>>       uint8_t clear_bitmap_shift;
>>   
>> +    bool send_host_old;
>> +
>>       /*
>>        * This save hostname when out-going migration starts
>>        */
>> diff --git a/migration/options.c b/migration/options.c
>> index 7526f9f..197cb86 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -92,6 +92,8 @@ Property migration_properties[] = {
>>                         clear_bitmap_shift, CLEAR_BITMAP_SHIFT_DEFAULT),
>>       DEFINE_PROP_BOOL("x-preempt-pre-7-2", MigrationState,
>>                        preempt_pre_7_2, false),
>> +    DEFINE_PROP_BOOL("send-host-old", MigrationState,
>> +                     send_host_old, true),
>>   
>>       /* Migration parameters */
>>       DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 1e1e05e..8644917 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -3030,6 +3030,9 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>               qemu_put_byte(f, strlen(block->idstr));
>>               qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idstr));
>>               qemu_put_be64(f, block->used_length);
>> +            if (migrate_get_current()->send_host_old) {
>> +                qemu_put_be64(f, (uint64_t)block->host);
>> +            }
> 
> This requires an update of scripts/analyze-migration.py. Could be done
> on the side.

Indeed.  Thanks.

- Steve

>>               if (migrate_postcopy_ram() &&
>>                   block->page_size != max_hg_page_size) {
>>                   qemu_put_be64(f, block->page_size);
>> @@ -4021,6 +4024,10 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
>>   
>>       assert(block);
>>   
>> +    if (migrate_get_current()->send_host_old) {
>> +        block->host_old = qemu_get_be64(f);
>> +    }
>> +
>>       if (migrate_mapped_ram()) {
>>           parse_ramblock_mapped_ram(f, block, length, &local_err);
>>           if (local_err) {

