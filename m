Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181F4C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByTN-0007b8-7B; Tue, 28 May 2024 11:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sByTJ-0007aM-V5
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:10:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sByTF-0000Iv-Pi
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:10:41 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44SBmwbA032399; Tue, 28 May 2024 15:10:35 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Doracle.com; _h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DXLfQpQhn0mf4AUbkcAnuHiZqTVuw1Gr917NF6KbX0vE=3D;_b?=
 =?UTF-8?Q?=3DLcRB8ZdTvSCh834MBln/+SVD3JMaU/fdiTK2LYC5viUCGk7LeJ6tbptkCdjf?=
 =?UTF-8?Q?XDr/nMj4_3FKNWhoHD6BwHFoCNid9FBo/3mLBSXt04sV+xDJ1EfFaffNBZ6Ywae?=
 =?UTF-8?Q?fSaUO4XWrBTNc+_WGKgPWDGMJZM1TURrSHKqWef4K3MW8tvB9B9xM6G79mcaVBa?=
 =?UTF-8?Q?ffnG54xdsoqvGvT4x2Hd_0MbTGSnW6s0CXUh0mAlY7HCFpbzOtaHjnGu/+AwXtf?=
 =?UTF-8?Q?4XCP3veDpHZ6gc8e4E1N6QoamY_l0Su7HiRxV+SJMTE8vF+1xuRzy+Kf9Xi+087?=
 =?UTF-8?Q?b8I0WRElnmFdPwGilwGuafwIl+ZA21xS_Nw=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8fccm37-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2024 15:10:34 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44SF0bUe037637; Tue, 28 May 2024 15:10:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3yc5060d03-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2024 15:10:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bu9IRLj3HXiPQBMH+JTMEzcE+w1y6g+QJbRDyyZUJedrsBs1lFO+zNxvn/wr4wlfL0sbm99Txh49J7z6OGTcqBXFT1cdFZ0n+Or5zeE1Jl5TV0of87YMwwJKFaFAGkRvgLhLHpyGSUbe4IVmGZPU4a/kVxnDCNZJXEzICvGleuQKDUbE2XEYhQ5vKOZrmhKt33pmHfeNt5uYXGv3tNy4TLAz9OpmzBciCas5H/OAxDboCq6LpczSjxUm+tWsuUEgShHKHdR1fX8iJFkIz1VGeTFSd8fhOFRq0l2JnRJBFpvC3mUrpks9CtLuXF5dPaDSiBo0k56lN30cvC52S8z2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLfQpQhn0mf4AUbkcAnuHiZqTVuw1Gr917NF6KbX0vE=;
 b=aUnE2KxSvzK9hc8+AvhB0G+nTfgfKO34XGOn5uFRYlg+tUgIbWYPSKKoISSlFc8bOQhXyweq/TiE+O1gkmn2UwHkki8EtcWQUiWvDe+QSUBYgh9vG+GXEgr0LE+fzZtD7/AjpzBeSEbLcmRm2loEODHsW71Vqqua4b3AzMZo3ONf5eEHG0/VBU5We+DKYTRFtZJUdA94KjmJlzIyB6ca05p/s50wlsWwXYAhT1iMPA3+4TnARxvy97MwijkQTqDFwhfojYfqrXHY5LNE05T9jy9MGvmjtTQ0JGS7ZimlX5A5MQvcOPQzTseyKwtYkfQ6Us6wII1aGWuBE+daKdqEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLfQpQhn0mf4AUbkcAnuHiZqTVuw1Gr917NF6KbX0vE=;
 b=zOQDG/FO/8g75LRJfSrxqL/UjfP2DJ44AVhAAXBbdx1S4GLB/McjgFx8remDlc6kMSlK3ojOUtQXrCy1K7Nm/8d/K4Nsgduxt9+BvRQfdeZStHj/GEG+KUxt9L7P6jZ/XZndZ6CLAMLCw39PiukY+2snpqiupSWh2M01b54a6ck=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DM4PR10MB6717.namprd10.prod.outlook.com (2603:10b6:8:113::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 15:10:31 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%5]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 15:10:31 +0000
Message-ID: <102b10d6-034f-453a-8f06-97e8d5869364@oracle.com>
Date: Tue, 28 May 2024 11:10:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 00/26] Live update: cpr-exec
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, QEMU Developers <qemu-devel@nongnu.org>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <cf8e13ae-cac6-4a8a-82a2-92b63a32b7b8@oracle.com> <87ed9wjey7.fsf@suse.de>
 <CADLect=ODs+-JrT4xOJazVveCtYPyDOCMsfK=2hcR-EJAdWDAw@mail.gmail.com>
 <be4cdd8d-4328-46d4-9b28-3a074d504180@oracle.com> <ZlTG18jRhp7oQTCQ@x1n>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <ZlTG18jRhp7oQTCQ@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:a03:338::17) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DM4PR10MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 380b4369-c9b3-41c7-3376-08dc7f2850ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1c4TlFwY3RCcTZpL29sdTNGbHVMa0R2UXpaNUU1aitHajJVRHNML3ZqUTdt?=
 =?utf-8?B?VHR0MXc5cG9KZFpvblE4a1Q5aXVGK2tvanpZWnFRV0dGSWdmZUFVb01sU3dt?=
 =?utf-8?B?NTgzNmNJMzZVcmpsaGpSRjNUVFh0STUrSjV6TU1hSHF3dldKcldnVVVRM0hp?=
 =?utf-8?B?NjdXVUFGQmZWd3ZwSEI2UU5mV3dHNGJVWnJKY1BodXhUVGFsaHl3b0djTWda?=
 =?utf-8?B?QjJIWnV5SXpndHFRVXRmcThNeDRRUUIvdGplOHkrMjcvTWhjMFk5Q2ZwYVVn?=
 =?utf-8?B?bktNbTRoSEFaVUpscTVoRVdKcWt6a3RQYWxWNTlybEEzb1JBMml1Ym52blZO?=
 =?utf-8?B?RnR1S1lndWowNkFuOC9BNWZ4L2tnTEprakFLemROa2lyTHJGcDh2U0IxU002?=
 =?utf-8?B?ZjJqOExZZzcrdmw5NS9IbElKeEtKVk0zNVJZZlpKbDV5RjdGVkdmOVJBbWxt?=
 =?utf-8?B?QXYzNTM3SXlHNTluTzg3cWMrS1d4SVRBR3AzM2JlSTgrSG1JRXFMengwVU9w?=
 =?utf-8?B?M3NhK0V3Njk2dmM3cDB6djVTTGVzMGR0OFJhOVhMWlNEUWRraTl4a29nSHRp?=
 =?utf-8?B?RVFWK05uMlgzWTMzcGNWYjdOZG1KeDUvQkQ2T2EvMWlGeUVmL1BITDc0SWNY?=
 =?utf-8?B?akZsd0lySkVvcmV4VnRmUWlOUmZOT3RaTkNQZDExUnlmOVRaVGcyZlJvMjNo?=
 =?utf-8?B?TWU1c3Z2OEwwM1FoUUpqbmJGUWwzdWhvanFZM1ROTEt0OFNCNHU4cXB6cS9O?=
 =?utf-8?B?Z2I4dmt4c25XdFNOUjBrcTNzRVk1Sk5VUzNUK1VoWGdnSU5QUzhFRVhGZXJU?=
 =?utf-8?B?N3BMbDhvRkZvSDVVeHhrTmtEYUVFUHhJK0M0QVBiTEM0dFFrWmJlNFpDT05t?=
 =?utf-8?B?SW1WVWkyRVM1UXU5S3g3QnJJM1V2cUpXakUrOXU2ZW1FN25Ea0hReFBvM2F4?=
 =?utf-8?B?OVZpWG5udXR1MXAzd2cySmYvMHRMYUhjQktjd2xxQ1NCYXIwZndPL2ZRTzVY?=
 =?utf-8?B?MDJRaXlKYXVuQyt5YTF6UUhQWnZEKzhZQjZLRG4zckV1TzhWSE1Uc1VIM3dL?=
 =?utf-8?B?dXF0cVFWRUx0ZXFEQ0pheE1yNHFtbGdUNFY2MkUrb0xoUGlkVWUyQ3dhbFBj?=
 =?utf-8?B?UFpmNThIZHlUVHViUUpQWTBqOUVpaW9UVFByMVA4WCs0ekpiNVBjWWMvbTZr?=
 =?utf-8?B?MWJSdmhuV1dmQmtoQXhaSStrK0pBVllsanI4dEQ3Mm5xT3luOTNJRnhuOEhk?=
 =?utf-8?B?cHRjdDVVSW1pcThsQlNza0pzYktpdjZ3RjNIS25WUGExKzk1czQvcHAxYXlC?=
 =?utf-8?B?OHh0RUJuYVRidHJKbnBMMmZLY3VlcCtFeG1haDJTQTlaM2ZxV05MWjRTdjlm?=
 =?utf-8?B?MWpmbHhoWU9sYkZhVGNjbG9aL2pMNWsxZkhvcjR5bGx1dzV3aCtyZU5SbmJi?=
 =?utf-8?B?NmdWQ3JLTkNWd0MvaVVhWGNTZzBCUzM3aWs3TFZLOFZmaEtQT1FuWFBzWCtH?=
 =?utf-8?B?N1lucDZDOGRBUXBUeHRWNmFWSTlIYkhUOXFPN0lqRGZXb2pSZ2E1R3JHWW91?=
 =?utf-8?B?NUNTRk9rUjNnYStPN2djdFVETzZjMmpSckhkVWtWTzdrL0xaL3NxeER4RGVB?=
 =?utf-8?B?UU9FcU9FeVVlTG1tcDRuV25iSnYzMUxjSTE4N1BZY2ZpWVBoQmpndE9SNUFv?=
 =?utf-8?B?alFCQmR6WTRLN3VVcWpmN0hydzJrZEZaNWFpNWNuQVlTZFhYMXc5VXd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2IxVjhhMndSOUEyOGRHTXBQNVhDTU10d3VSWDNHcTl2aUo2UWJXUEVJandq?=
 =?utf-8?B?ZEQwdlNOeEl0ZzNabHIxUXFKb0E2RDNYdTNlKzdDd290SDBDNC9oTEZ5dkFH?=
 =?utf-8?B?YnpIckdMaE9Sd1hBNVRHSjZ5bHk0MVJiaUJTOTV0ZVlvNXFYMGpGSm5XTnpp?=
 =?utf-8?B?eEcrOSs0cFNRajE5ZG1WdFk5NldwclFoNGpmRHpXY2tBZmxwN3l2anV2cDMr?=
 =?utf-8?B?QXBselp0S2NhUlFuSDg0eWRiMjU0K1F2bzYzK3pmZkN4UDlkV1c2UTlEVkpt?=
 =?utf-8?B?VHhBTWxzamlKQkoyUlQ2bHRSNmZXcXA5bVU3MzJ3eCtzWHc5TWwzeU41L2Vi?=
 =?utf-8?B?NEpuMzU2dlVEd2doaTIzU1dIOExHaUdYb01VZk55UXprTGlUSENkZStucG4r?=
 =?utf-8?B?eDJsL09seERWVGJwYUY3N01mYjlKQmwyYkwwWllvSmFWL0htUG1kVy91YXhK?=
 =?utf-8?B?akpQOGFiN0M4RnlBT3RpYzduUHc3UGFhUGJqd2d4TnU0MldlV1JraGsvNTRx?=
 =?utf-8?B?TFJrTGxoZjRId1N3bkhWT2t4M1lOYWpzTmRPY21TMU9kMzlIejAxUkZVeUd4?=
 =?utf-8?B?by9RSkg5SHNMbk5FS0JoV1NYamMzRjlPcFEwamlLYTVuaExpRU9Sc0RQMzY3?=
 =?utf-8?B?SmttNG9NUm5WbldreUxsRWN5YWxzUXQzK2txMS9pUm5KWVEydHUwVEVVS2dO?=
 =?utf-8?B?NVB4S3ZJL1pSVmY1RUxFSFhjcDZadnVGeEFPbGRJNFpBTlVuZXI2TUh5Wktk?=
 =?utf-8?B?THpQVFlTbEhkTnRITjcvMCtCQTNrMXhZdU9penhCV3VNVjVpSytENkFDM3Vr?=
 =?utf-8?B?djV2TEFodWlCcStaZXUrN3daRUxTUVEzV2JYU3cyTWJKZ294SHJYTGJ1QmFs?=
 =?utf-8?B?UURqUU10dld1OEhhL1VDSlEyTmhNMzJ2L3dOWExqSUlTZHhUakVQUjZzWVlm?=
 =?utf-8?B?TkE0cERjbzZBdnplZDFRd0pVWU9BVHZaZ3dQaFdLSUk0VXRuTno0K3dvY3Nt?=
 =?utf-8?B?U0NpNkxHR1ZDdEdUQ2thaFZmQ3lHN3VRM2M4RllIMGtlbXdhYmZBd29lTjdx?=
 =?utf-8?B?OVJ6cTMvcC90VUhlTzdLZmR1M2IyeVBBc0JndDVEbjJqZkJ4QWNhbTVtdXVL?=
 =?utf-8?B?M3psY3RHU3BsTFpQa2NBSGw4ZVYyYXhJS294MEM3bGRFUE55ek1sdTBENUhV?=
 =?utf-8?B?Qi9vZ3IvRXdyYlB6dzUxZlMwT1F2OGthRVNjYVI4QmlTSHh5bXhQeEVMR3dq?=
 =?utf-8?B?ZmpsbEpiOXR1NC90ck5yUTd3UjVXWHVnckg5QWlmaEJnem9ia1IzalB5eFVt?=
 =?utf-8?B?ZFJDTEhXZUYxOG05U2tTaWV3WWp0NDBKcm4yRmVWN29DekZtRVgva3BuZnM1?=
 =?utf-8?B?T285aDIwNkVwZEtrOEFZZWFJSnJqZVhUMWgyL0JuWkw3M1ZmcDZ1ZGpFWFpu?=
 =?utf-8?B?Q3lOUXQ3YmNLZEJPR0k4ajBnQiszc2JPYUQzS2JveFFqdWVJVUZ0OURHVHZp?=
 =?utf-8?B?WGsyYUtjbnRSRDZYSUxmaUs2empseGxza1hLbUNTSmdBeW11akhMZlZybG9Y?=
 =?utf-8?B?MDJYMlppTVZCOGZwOTk0VmtONjdyTWpQZks0bjhTbG9LVzdnaEdGZXF0L1dk?=
 =?utf-8?B?MXlhRXYxL0dIMW0vbmxXYXhEV1lzaW5xaWd4aTVwbU94RjJpMXRHbUR4VVZi?=
 =?utf-8?B?V1R2S3pQdld0WWFTeGRGUkU4Y3NYN2xZNnFSZ2FrajZhUElsZkpSUkJuWjNk?=
 =?utf-8?B?NjFXZ2c3d0ovNjN4V2hzNFdIaS9zbnFyN0xiNkZNSUF2Vk01ajh0ZnJOL3ZB?=
 =?utf-8?B?WXZGSHkxTE5qbGc1dzNsbzNkaVBBc2pyeTNyWFZoV2s3UGxNZzFiaGhVTjA0?=
 =?utf-8?B?aVRySkJDTzhxT0hHc2pOT1llcHZBTVRvTW0wNmZvOXBROENwTm5vNDdZL3h6?=
 =?utf-8?B?M2JSWU93RzdiRVBvTURJamxEV043NVJQbTl1Uy9FRm9UcjlmMTNKcnZPRG5Q?=
 =?utf-8?B?SmZwMTlFeUIwbk0yY2JkcTMvNWxId2lGWnB5eHFiWElBVkRDQnQwV3E3V3RU?=
 =?utf-8?B?L0orcVh0K2F6d3ZNT2kwekFMa1U1eDB1SEdUV3RjcmgwV0xkYmRyLy8rUURs?=
 =?utf-8?B?ZS9OUktRc0dUTGFhdE9vT1VJeE4xQjFyZUE2UkVsMnJRUUErTzE3NWo1d3ZY?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RDEuJl4PJbUG091dxjA1Z1GY2noaFd2c0HZ+bC0eEUtF320WA903+MonC0RNHBgq2NVc6aIvyVsMX6qjbfCJLLBMrol10bQc8HtEJ9JRX+HSi/9iTd7EpSoFdsJmccRyh1O93v/U7Yth/8d1iRfoa2dUiRzIJKxJtRJiKXpGtAz/tGgWMWTZrm6/tCbzxyFvCYrNyCU7OKeSD5rPj5GeTSsRO85SSkU37FMTlmRW0jvhSqzAX/UDA+XYHhlMON9bNJ9i/LXTc1KlT2EDu4CO56A90rfn1s5c3zm3LF1upXrBzLZ2774kXZpRYGRB//eSi1xtRd6e0SuL23H6ph2VTmvE8lqzV/qW4iGoVCElEENnBE4M/EgHLxvKIiLnPk+34cvbIDQgRNT3VpZeTtibgE6dgmnYTUQDwqQAmMd54Y3P9xtRHLfP7YYJVvutlK6XJTXLQ1e9Xrc8PSPnbFoRFALfv3p2CCOug84ZB2C15kONbtIPKy/V8EmUq5Vy86MIoONG4zKAJ6lU+5SUXbs+0r97WK2p8vxnX5AbB+R404kLjpy64y9+KS/fMns9xOevUYxUCf7KqQOSEQVkixIEvwndSMZLgxTO3wmExcAPWFM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380b4369-c9b3-41c7-3376-08dc7f2850ee
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 15:10:31.4027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjikaUE2cKazx9LhxU+iyOyXTUvxiczXa7Rd+X2rVdy9Gwv9n8+XQVjCZYdzCo/gHF2dlmn2ydUqNQe9wDjAzRECyd+BD9zJLUUeiR1gNdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_11,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280113
X-Proofpoint-GUID: QCU6D2S81hJLR69G6uxKt46HDiztFGRY
X-Proofpoint-ORIG-GUID: QCU6D2S81hJLR69G6uxKt46HDiztFGRY
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/27/2024 1:45 PM, Peter Xu wrote:
> On Tue, May 21, 2024 at 07:46:12AM -0400, Steven Sistare wrote:
>> I understand, thanks.  If I can help with any of your todo list,
>> just ask - steve
> 
> Thanks for offering the help, Steve.  Started looking at this today, then I
> found that I miss something high-level.  Let me ask here, and let me
> apologize already for starting to throw multiple questions..
> 
> IIUC the whole idea of this patchset is to allow efficient QEMU upgrade, in
> this case not host kernel but QEMU-only, and/or upper.
> 
> Is there any justification on why the complexity is needed here?  It looks
> to me this one is more involved than cpr-reboot, so I'm thinking how much
> we can get from the complexity, and whether it's worthwhile.  1000+ LOC is
> the min support, and if we even expect more to come, that's really
> important, IMHO.
> 
> For example, what's the major motivation of this whole work?  Is that more
> on performance, or is it more for supporting the special devices like VFIO
> which we used to not support, or something else?  I can't find them in
> whatever cover letter I can find, including this one.
> 
> Firstly, regarding performance, IMHO it'll be always nice to share even
> some very fundamental downtime measurement comparisons using the new exec
> mode v.s. the old migration ways to upgrade QEMU binary.  Do you perhaps
> have some number on hand when you started working on this feature years
> ago?  Or maybe some old links on the list would help too, as I didn't
> follow this work since the start.
> 
> On VFIO, IIUC you started out this project without VFIO migration being
> there.  Now we have VFIO migration so not sure how much it would work for
> the upgrade use case. Even with current VFIO migration, we may not want to
> migrate device states for a local upgrade I suppose, as that can be a lot
> depending on the type of device assigned.  However it'll be nice to discuss
> this too if this is the major purpose of the series.
> 
> I think one other challenge on QEMU upgrade with VFIO devices is that the
> dest QEMU won't be able to open the VFIO device when the src QEMU is still
> using it as the owner.  IIUC this is a similar condition where QEMU wants
> to have proper ownership transfer of a shared block device, and AFAIR right
> now we resolved that issue using some form of file lock on the image file.
> In this case it won't easily apply to a VFIO dev fd, but maybe we still
> have other approaches, not sure whether you investigated any.  E.g. could
> the VFIO handle be passed over using unix scm rights?  I think this might
> remove one dependency of using exec which can cause quite some difference
> v.s. a generic migration (from which regard, cpr-reboot is still a pretty
> generic migration).
> 
> You also mentioned vhost/tap, is that also a major goal of this series in
> the follow up patchsets?  Is this a problem only because this solution will
> do exec?  Can it work if either the exec()ed qemu or dst qemu create the
> vhost/tap fds when boot?
> 
> Meanwhile, could you elaborate a bit on the implication on chardevs?  From
> what I read in the doc update it looks like a major part of work in the
> future, but I don't yet understand the issue..  Is it also relevant to the
> exec() approach?
> 
> In all cases, some of such discussion would be really appreciated.  And if
> you used to consider other approaches to solve this problem it'll be great
> to mention how you chose this way.  Considering this work contains too many
> things, it'll be nice if such discussion can start with the fundamentals,
> e.g. on why exec() is a must.

The main goal of cpr-exec is providing a fast and reliable way to update
qemu. cpr-reboot is not fast enough or general enough.  It requires the
guest to support suspend and resume for all devices, and that takes seconds.
If one actually reboots the host, that adds more seconds, depending on
system services.  cpr-exec takes 0.1 secs, and works every time, unlike
like migration which can fail to converge on a busy system.  Live migration
also consumes more system and network resources.  cpr-exec seamlessly
preserves client connections by preserving chardevs, and overall provides
a much nicer user experience.

chardev's are preserved by keeping their fd open across the exec, and
remembering the value of the fd in precreate vmstate so that new qemu
can associate the fd with the chardev rather than opening a new one.

The approach of preserving open file descriptors is very general and applicable
to all kinds of devices, regardless of whether they support live migration
in hardware.  Device fd's are preserved using the same mechanism as for
chardevs.

Devices that support live migration in hardware do not like to live migrate
in place to the same node.  It is not what they are designed for, and some
implementations will flat out fail because the source and target interfaces
are the same.

For vhost/tap, sometimes the management layer opens the dev and passes an
fd to qemu, and sometimes qemu opens the dev.  The upcoming vhost/tap support
allows both.  For the case where qemu opens the dev, the fd is preserved
using the same mechanism as for chardevs.

The fundamental requirements of this work are:
   - precreate vmstate
   - preserve open file descriptors

Direct exec from old to new qemu is not a hard requirement.   However,
it is simple, with few complications, and works with Oracle's cloud
containers, so it is the method I am most interested in finishing first.

I believe everything could also be made to work by using SCM_RIGHTS to
send fd's to a new qemu process that is started by some external means.
It would be requested with MIG_MODE_CPR_SCM (or some better name), and
would co-exist with MIG_MODE_CPR_EXEC.

- Steve

