Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF48CC25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 17:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCN9m-0006hW-BS; Wed, 29 May 2024 13:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sCN9W-0006Qv-6k
 for qemu-devel@nongnu.org; Wed, 29 May 2024 13:31:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sCN9S-0000Na-3l
 for qemu-devel@nongnu.org; Wed, 29 May 2024 13:31:53 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44TGYdm9028305; Wed, 29 May 2024 17:31:46 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Doracle.com; _h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DBUbOjWHZ0+au5qhGXn7p/39UwAcUyCBL0nTNXq6VeJ4=3D;_b?=
 =?UTF-8?Q?=3Db9KXvAjFj8ZkCiBZxeTiWrErM5gj6w71f5EkVxlJbpIJmTC6Jf8sSK+Ks352?=
 =?UTF-8?Q?HUmxlwKI_0OkvNpSv8T2lj3DhLahlLEsv9v5COMEjqUA+TvNU+P0Zy8hP/682h7?=
 =?UTF-8?Q?nTUPO55zT8/sFH_6D+4mhKu1Hn+MmJ6H0jVBlwLDvQwjzKarfzUjqaPbRaGB7H2?=
 =?UTF-8?Q?4SHszuoKs5GeXPx+6l2d_DGatik+6TnO8feSlmCc1RAeNWcUWclf9d13/X5el7N?=
 =?UTF-8?Q?hG2yJ7adJP/g22XeLey79sLj3N_KHh8TcEQYgbgbI/5jZ5/S6en86Fq3AWUPIGa?=
 =?UTF-8?Q?6duamqWf5jwyyLW338b9e5OyHyPyYd1E_9Q=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g479fn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 May 2024 17:31:45 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44TGlATk026646; Wed, 29 May 2024 17:31:45 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3yc507h1ms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 May 2024 17:31:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgVa17y6cYPwA4RMu++9UCVxDNFfl/ZSm9MgI2lB/40ckjqy5Ui9F7RMKArB+fBMxbPBFDvQeTZ/qQ5FfNDMCRnc77XzCMq8A4eme37zMDRmlh+j9y93IyoQe79CoN9LcjJnPvALJqsFSvXd5Y9cg4HFl58apFzSzsUmrcKxmcTdi5Tr785tAblxt+GfbzNrsSycbT2hv5neFIS/TrvIeSWUPb0RlHjkneNSptDK9+WI0SngNizRPlwJHDtDk7FkAz54s0mfQVxHdmlFrGyBcK1rk6suj639CkAtRzuCtC78EtbMjLJD5nVAuj30JpXf1CO6WL5oSA6xpn4aHtNF6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUbOjWHZ0+au5qhGXn7p/39UwAcUyCBL0nTNXq6VeJ4=;
 b=Hmuwz0mJJyrp6iW58zZKPahD6zvxcmh6ZApCK8FZWiFadtQkJ7aHvumMnWBhh0aLkf6lzNxH3rDDlbRdP7QcSaUuljiMAXzr0McFmNR7S/7mHAIADd5R0CXNnt0kF+abQ182x2kcLzNz3qRgj4k9S6SP0ta0ftf8meC87SOVWe3Rl9sfnjdAfQ98rRLOEl6JtHDXZK5qxrmbJzZd5kKsvQcNJS3RQM7Z/G/f1ovWQh1l3UJU9VzcWkiq7S93x6+5yzI1HIph5nax0bQrlRoGBkPHp37wXpX6cOfPgPDHQ+TexDmiAw/IQh/ILF75ytNpJ9JziVS4gbUb4nU6qyDirA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUbOjWHZ0+au5qhGXn7p/39UwAcUyCBL0nTNXq6VeJ4=;
 b=rbn1OEbahylbK2BqijzJ4N1FbFEdfsgyxw1dpBSQivPIHJd7gtXoM/jappP7dm9j9890KB0SDx+gPQLAl3ApUM51xindnrtJf4dS36/v3FnBYFAGPaozoKKiAze75ko/+PC52/O6o3A4yk/HZDBuaHHRD52UnZsy7REfX6aDnf4=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA2PR10MB4442.namprd10.prod.outlook.com (2603:10b6:806:11a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 17:31:42 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%5]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 17:31:42 +0000
Message-ID: <79a8023d-2e19-4d80-821d-a03818a5372e@oracle.com>
Date: Wed, 29 May 2024 13:31:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 17/26] machine: memfd-alloc option
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-18-git-send-email-steven.sistare@oracle.com>
 <ZlZIoiH5Dj4XBbLO@x1n>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <ZlZIoiH5Dj4XBbLO@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0016.prod.exchangelabs.com
 (2603:10b6:207:18::29) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA2PR10MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: b96530ca-9c56-49b5-1e56-08dc8005347b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nk94SXVZN1dFcnJScFc0ZUpwUVhrSzhYRlBCSnEyOFo4WjBvWWc4VzBDdXk2?=
 =?utf-8?B?bGdvNXBkRVZPSEhqZDRVNS9SWEo3NXlzcnBUa0ZCbldLVE4xTi80RS9IblBJ?=
 =?utf-8?B?Z1RSZC9oL3QzS011bzdKczNEOTNlQzZ5aG02YkMxdUZVZkp1OFVPdzVac0Ur?=
 =?utf-8?B?ZE1YbkI3ZDNILzlJRENBZit4QUp0U0tLSitCaEhPTXFCOTVob3hiNjYxU0h5?=
 =?utf-8?B?OHptM0QxTjAyT1BwQWVsQ3N1V21IRGZSWndEWVE5RVNxOUc4SHlJN1JGbHN1?=
 =?utf-8?B?dFFCc1h2YnpoZG9KbDM4eHhNUGpwZ3BLV3ByY3pCNUwrN1NQcUcxNnZjK3l3?=
 =?utf-8?B?cXBRbjJKS3VJVUtxN08rM0hDMkJ1c2JHODhBUjd2U2xSc3F1WUEzd2JuSitU?=
 =?utf-8?B?aVlOZ2hXVVBnaVpwNmdCVlBOV2tMdnNMSUJEbWhTTkp2Z25nTExlYkFrZDdZ?=
 =?utf-8?B?a2hvUE53ZTZhZmUzSlRyUkZTQUJRKzNiekpsdjY4UGNGSWJIUG5uU0VUQ01p?=
 =?utf-8?B?Z0ZPcWdSYnEwWmRzZnRUc3pvdjBUdlIvTWlacWFEVDJDT1Bia3E3LzdPYUlk?=
 =?utf-8?B?Yk9jQ0lzSFNZQ1Z1UnovYk5pcHpqUlhNNGNCQkwzY1J2WG52eVA5NkFGeWJp?=
 =?utf-8?B?VU5tZlo0a2J5UzdiV0Zzei9tUGk3RnRnVkcxVXc4MXZWWmQvc2YzTStOd0hB?=
 =?utf-8?B?M3UzaHZlWEt4NDRnUGpnYnlMOEw3ditTOUtvSmIvZ3Z0VnNCV0xwMHdyRFF3?=
 =?utf-8?B?VDUxS1lWR1owRzhxekFxdXZyUmNaS2VMQnA1SFZvSlpoMW5VdjhwaEtIc01h?=
 =?utf-8?B?b3UxRlNYWFlaVk45VS9pOG9HejF6c1dOemlpUkp0QmFsd21MSUJPQXVMdGNV?=
 =?utf-8?B?Nlc0MjQycE5TZjJMMVpWU0RVbVhQQWlXZ2duWTlsZVVaMW0vTFVBSXR3UTVz?=
 =?utf-8?B?SHVySEhQM21vci9rUjNjeGJPVEZsU3UwQkNKYSs4c0VkZStnNXQ3c2RVVlQ0?=
 =?utf-8?B?T1RIVFI5bk11VmN5eDVCdytrZnZDMTg1NEZwaGEvekt4MFhqbDBHdGxJZ3Ay?=
 =?utf-8?B?ZjNnWU83bmFpbG44UFRYQ0JJbFZTN05NRmJuWjVWM0JUWjdiVUhnUEg4aWlC?=
 =?utf-8?B?N29zSEJ1bTVJTHVkZVU3bDNncUc1UkpFM2V6V2lnMEN2Nk15SndGaG5SYnVS?=
 =?utf-8?B?TWdjQW90Q3RidGdhbDRFK2JJUzY3dHFRWXEvc21hcjBLUjdPUFFOSEcrWTZM?=
 =?utf-8?B?WnB0b2I4U2ZDdU9OS1N5YnVYdkhOUGxEYTRObU5kSnFoVmd1SUdyYjMrcHcx?=
 =?utf-8?B?eVpmdWU0aFlBRWF4QVo2ZnRKT2ZhMHRNQW1uV1Vib05FWWxzR0cxRXhjRTYr?=
 =?utf-8?B?aURsdDN3U0p3SHdsWGtVWGs3VmZZdGpQQ25kYS9xbzZiY2t4ZThtR3FtZnNo?=
 =?utf-8?B?bnRyYW40RnVBMzNoN0ZuZXA3bWpZd09Xdm44SkVuSTZQdnR4dXJZWEVSMUpr?=
 =?utf-8?B?NXBieUh4aTR1ZlF5eVh2SzZtSkNmTy9EdXc3S0x4Z21udWtnYUMyeFJoVzFY?=
 =?utf-8?B?Mi95L2k4SkNZTnk4bjF1Z2VTUEw5Rkx3NUg3UFE4WE1JaFVvRWd5UlROZTRU?=
 =?utf-8?B?T0VwSk1nMmdNbXM5NEhvMUlFa3Jla295YktIV0xIYmdpcm4yeFdwSURGQjl2?=
 =?utf-8?B?N3pHbUhyMUhmYzd0cVlobHdibFVIWEJlRTlyR0VMTDAzRHZjdU51U2RBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1F6WFR3THhXNTlTNFpicVN5Rkhrd1Bja0dieTFNMUR5Z2ZnUC96OW1FZW0z?=
 =?utf-8?B?dnErYzNIMUJMaC9xUEN3UWljbWxsOFFDU3dzaEM4UWJIbkx2RS9ycGR1MFpS?=
 =?utf-8?B?Qm44OW5yazRyRVcwc09rN2FJMTNTUld4NjF6U0lBZ0ZHaEEybmdodVdwL1Ru?=
 =?utf-8?B?UmxuYVd5aVNTS1VxOVl2cjNwNVZiVHQ0bzJzQ2EydXNqVS9zMmNGV3NPd2dr?=
 =?utf-8?B?S3pkNmt4M3hhQXhHT0FTbWR4aEpXbDE4K1FHcjN0MWdqczlHcTJLSGRXaUVl?=
 =?utf-8?B?K2Q5Ri9NZnlkN1E3bEt1OWFNQktTaGYySnlDRlhRUHV1c1RwWllEZ0V1Q0FV?=
 =?utf-8?B?YU5ZZHV2akptVG52eUp2QkdRYWZML09yaTJURVRHenJXRFNqY20rZmVNTWxP?=
 =?utf-8?B?M0phM082cExJVWRsenpCSkxIZGtKYXhCRW1PbVI0TEp4TzVVcWhtUytiNmdx?=
 =?utf-8?B?NnlEOURWVWh2WkVncStrdzErZ1QxZlZtVHBTdUdnVHJrZmhqUnh6UklzWWJh?=
 =?utf-8?B?TlpmbXZSUkZpcTkwR2Z6dW10eHdmSWRhekZKN1RJQWowcTB3SzUwbGVxUEtH?=
 =?utf-8?B?ZjVuOUxXVXpMVWt1Q0poQjRlclY4bWs1VlJtMU9BQnNZLzlNbUtFZ0NrQTNM?=
 =?utf-8?B?RVRpd0ZYK2grSXFEalNZdjkvOHluRTJvWVZQM1FyM3Y0SzFOc1lXemxDbnlU?=
 =?utf-8?B?MFlEcDNRR2VzYzNyYmRGc2MwYzNTalduUFpucHJ5SDJDZ1N5c3MxSEpHRWxR?=
 =?utf-8?B?RTlDemFJbmJiWUdtOXcxT1lFSnRIRjE4NTF3VXVoUTI5VnVOVnVzTFRCNHZT?=
 =?utf-8?B?ejNVNlEza3RseVdFT0NXSXREaXhjUWJSWVpndG92Nk9LYjlyNWNBNjNUcUZW?=
 =?utf-8?B?cUNvRnQ1VExDUkk3MHA0cWpBSXZnZmU2Qkx6QVBKbGlhR2h0aTdRZzdhSWtZ?=
 =?utf-8?B?WGZ4NVR1YVIxanQvTWhXTnBRNkZHd1JGR0ZGWkhZbDZEZG1ER2hodGVUVVNa?=
 =?utf-8?B?N1pDOEpOYkNFcTJVUXpVUTZva3VzcERtNnJaUkRORVlLQjZqcTJ0U3lKNVIz?=
 =?utf-8?B?VFVOMVo1S2V6dlhKR3p1WjRMcVcwNXc0czdUYTFRWGtSUmdRdUt5ekVkNk5D?=
 =?utf-8?B?L3BDa0JYTUo2cUFnaXZxUzJTQXl5UjBPYkh5L3F4cXBFZ1BWZmVzRE44V0Yw?=
 =?utf-8?B?aVJJSkpyS01rN0l6aThnOEEwbDU2eFUrcCtUaGUrMXFBRG1WeXNxQ2RzODZa?=
 =?utf-8?B?d2FTZjZyMkUrU1R1Zzh2SDQxcVJKQStmZGdsNFloZ0lqbzV5ZmN0elVVWDBp?=
 =?utf-8?B?ZVNqT2pIcEVOaStjOE11Vi9EUDdXR2R0YVBsRFA3L0h5ZDQ5WWZ1WG0za1k2?=
 =?utf-8?B?ZTRjVlBIc3cvOHRlYy9BV2RDQkIzN1F3V3JVNmZRb0ZDYkFYd2ZWSDR5SHdq?=
 =?utf-8?B?Q2wxTDB3VGg0VHYxZWZBS1pVSEdGbXhkQTBGOWtPbmpnZkZNcEpHUnd6MDFz?=
 =?utf-8?B?c0ZHQ3ZTQkhCL2ZqaDYyb1hsNThTOFpXV0NhbHFVZWhONXZqZXFHZzhMVGgz?=
 =?utf-8?B?dE16WjhEN0V3VHltenlKb2RIZ2ZzUVNzOW5RcGo2MjFhbDQwWUsyN3N4YnZn?=
 =?utf-8?B?SmFyN2V2YldRbDBYQnNwUUdMUWlZY25jb3BSZk8wKzNBVWJ3eUNhTmdKMndM?=
 =?utf-8?B?bTh5Y0ZGSnptTWMrOUNWWkRsSlZIL2g3UDlZUmpOZGxaNnJGNG1hTmZzN1VH?=
 =?utf-8?B?Ni9hanNFRm5qbGhkUFI1U0Y3RTRUbVFzNlRVVDQxSDE2UEZvOS9qTzdjNlF4?=
 =?utf-8?B?Y05HbER0YVAwd010OVJMQ2hQUWlqNE0rc0J5TlZzOC9TaGdzeXpqL01pSzgw?=
 =?utf-8?B?cExaSUZpNTl2NkJNcUQ2c0NRT1dkU2x1Tkl4NVp1bVEwZE5zbS93UTRtOTc2?=
 =?utf-8?B?YmdOSmU0SUU2VklQMTFQV1gvbzdCS3pWQ1YyS0swUmJEeEtpVFdpdHdyN3A2?=
 =?utf-8?B?ZTNHUDVJSzluei9jYzF4dFNkZGNoZU1VU2tPd0ZsQ1g5dGFKbDd0Vk5lZW5O?=
 =?utf-8?B?Uy9WN3kvRHVWaDJXT3dOOXNYSTl2cFJ2SHFLN2lUQStDMVlGZU40cmE5Zy83?=
 =?utf-8?B?T2dSRFBEbTBrMnNveTJQTUlvWS95WDgrOEhGcjRDbWVCVlV4aWM5MSt4b0l3?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6Hesjwv6DNbnCnvx5mWQu+EG/y4bxQfbbIOUEzYdIVhENJLOzwSXde9U4QAYVJ+uXlZjxZmcHIcDXKC9XIFVBxPCTm6lTtXLcgyQbr0sDC6SClBPxWrL3OjeBoDBMfNCa8rN22nOsztQxiPgyPT4XHH+vQ5c+D0KEbpcBtB4zCbzoQ1l57WnoKQoHswkEGPZE45BjByJI63pEO3oQYC1xFe9OPyC1jmk0PNXumEFNfqUNq72O5OkzH97ZzAuF8Eyf4xWJ9sEnWrgMjIoRWXubNe+Lf491n2hOmNOgnfM0XoWSeT4WVh3LBMoHOniwJlcaKzxR/6ol85pSkvpwqZsFV6wmpMtI1hJoG9nsQ9RPhXC42G/jCg3Ev21V2KYfp4HmkkDvpAY0+qvnPLuJXsNTAZOvDI0GAASJn9Odh/A4b+dIldqo+xNB3iF1ZxbO1p7eSgy17/n3wFSnOXy4XQ4HVC0ugwzQIaLTF79uP+wM7NMy7pbCvzqABXfL0qkvg2u1kBm+xn3P0gR+WnfsZlmxIzC/fuoIjc7mIJVDeCattX+gqKBsjoGUrrKo3pzBg5eOgqyu/wUemQs4tL8K92HbQOAg8xMRIvPUlvygBqDPuo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96530ca-9c56-49b5-1e56-08dc8005347b
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 17:31:42.4506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9FC5yrXB2S1Z1TwVWPYG7KDFyABPG3wZ5He5VR29LCFLlUlmGQw835WsvIqmLZ9Cxlu9Gaih+Z3RX30sjT/qlmyrVfO/us00jwEZ9Z2Fgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4442
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_13,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405290122
X-Proofpoint-GUID: 3xl6qgN-XPXvycor_o39KWNcndh1yeND
X-Proofpoint-ORIG-GUID: 3xl6qgN-XPXvycor_o39KWNcndh1yeND
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

On 5/28/2024 5:12 PM, Peter Xu wrote:
> On Mon, Apr 29, 2024 at 08:55:26AM -0700, Steve Sistare wrote:
>> Allocate anonymous memory using memfd_create if the memfd-alloc machine
>> option is set.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/core/machine.c   | 22 ++++++++++++++++++++++
>>   include/hw/boards.h |  1 +
>>   qemu-options.hx     |  6 ++++++
>>   system/memory.c     |  9 ++++++---
>>   system/physmem.c    | 18 +++++++++++++++++-
>>   system/trace-events |  1 +
>>   6 files changed, 53 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 582c2df..9567b97 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -443,6 +443,20 @@ static void machine_set_mem_merge(Object *obj, bool value, Error **errp)
>>       ms->mem_merge = value;
>>   }
>>   
>> +static bool machine_get_memfd_alloc(Object *obj, Error **errp)
>> +{
>> +    MachineState *ms = MACHINE(obj);
>> +
>> +    return ms->memfd_alloc;
>> +}
>> +
>> +static void machine_set_memfd_alloc(Object *obj, bool value, Error **errp)
>> +{
>> +    MachineState *ms = MACHINE(obj);
>> +
>> +    ms->memfd_alloc = value;
>> +}
>> +
>>   static bool machine_get_usb(Object *obj, Error **errp)
>>   {
>>       MachineState *ms = MACHINE(obj);
>> @@ -1044,6 +1058,11 @@ static void machine_class_init(ObjectClass *oc, void *data)
>>       object_class_property_set_description(oc, "mem-merge",
>>           "Enable/disable memory merge support");
>>   
>> +    object_class_property_add_bool(oc, "memfd-alloc",
>> +        machine_get_memfd_alloc, machine_set_memfd_alloc);
>> +    object_class_property_set_description(oc, "memfd-alloc",
>> +        "Enable/disable allocating anonymous memory using memfd_create");
>> +
>>       object_class_property_add_bool(oc, "usb",
>>           machine_get_usb, machine_set_usb);
>>       object_class_property_set_description(oc, "usb",
>> @@ -1387,6 +1406,9 @@ static bool create_default_memdev(MachineState *ms, const char *path, Error **er
>>       if (!object_property_set_int(obj, "size", ms->ram_size, errp)) {
>>           goto out;
>>       }
>> +    if (!object_property_set_bool(obj, "share", ms->memfd_alloc, errp)) {
>> +        goto out;
>> +    }
>>       object_property_add_child(object_get_objects_root(), mc->default_ram_id,
>>                                 obj);
>>       /* Ensure backend's memory region name is equal to mc->default_ram_id */
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index 69c1ba4..96259c3 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -372,6 +372,7 @@ struct MachineState {
>>       bool dump_guest_core;
>>       bool mem_merge;
>>       bool require_guest_memfd;
>> +    bool memfd_alloc;
>>       bool usb;
>>       bool usb_disabled;
>>       char *firmware;
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index cf61f6b..f0dfda5 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -32,6 +32,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>>       "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
>>       "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
>>       "                mem-merge=on|off controls memory merge support (default: on)\n"
>> +    "                memfd-alloc=on|off controls allocating anonymous guest RAM using memfd_create (default: off)\n"
>>       "                aes-key-wrap=on|off controls support for AES key wrapping (default=on)\n"
>>       "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
>>       "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
>> @@ -79,6 +80,11 @@ SRST
>>           supported by the host, de-duplicates identical memory pages
>>           among VMs instances (enabled by default).
>>   
>> +    ``memfd-alloc=on|off``
>> +        Enables or disables allocation of anonymous guest RAM using
>> +        memfd_create.  Any associated memory-backend objects are created with
>> +        share=on.  The memfd-alloc default is off.
>> +
>>       ``aes-key-wrap=on|off``
>>           Enables or disables AES key wrapping support on s390-ccw hosts.
>>           This feature controls whether AES wrapping keys will be created
>> diff --git a/system/memory.c b/system/memory.c
>> index 49f1cb2..ca04a0e 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -1552,8 +1552,9 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
>>                                         uint64_t size,
>>                                         Error **errp)
>>   {
>> +    uint32_t flags = current_machine->memfd_alloc ? RAM_SHARED : 0;
> 
> If there's a machine option to "use memfd for allocations", then it's
> shared mem... Hmm..
>
> It is a bit confusing to me in quite a few levels:
> 
>    - Why memory allocation method will be defined by a machine property,
>      even if we have memory-backend-* which should cover everything?

Some memory regions are implicitly created, and have no explicit representation
on the qemu command line.  memfd-alloc affects those.

More generally, memfd-alloc affects all ramblock allocations that are
not explicitly represented by memory-backend object.  Thus the simple
command line "qemu -m 1G" does not explicitly describe an object, so it
goes through the anonymous allocation path, and is affected by memfd-alloc.

Internally, create_default_memdev does create a memory-backend object.
That is what my doc comment above refers to:
   Any associated memory-backend objects are created with share=on

An explicit "qemu -object memory-backend-*" is not affected by memfd-alloc.

The qapi comments in patch "migration: cpr-exec mode" attempt to say all that:

+#     Memory backend objects must have the share=on attribute, and
+#     must be mmap'able in the new QEMU process.  For example,
+#     memory-backend-file is acceptable, but memory-backend-ram is
+#     not.
+#
+#     The VM must be started with the '-machine memfd-alloc=on'
+#     option.  This causes implicit ram blocks -- those not explicitly
+#     described by a memory-backend object -- to be allocated by
+#     mmap'ing a memfd.  Examples include VGA, ROM, and even guest
+#     RAM when it is specified without a memory-backend object.

>    - Even if we have such a machine property, why setting "memfd" will
>      always imply shared?  why not private?  After all it's not called
>      "memfd-shared-alloc", and we can create private mappings using
>      e.g. memory-backend-memfd,share=off.

There is no use case for memfd-alloc with share=off, so no point IMO in
making the option more verbose.  For cpr, the mapping with all its modifications
must be visible to new qemu when qemu mmaps it.

>>       return memory_region_init_ram_flags_nomigrate(mr, owner, name,
>> -                                                  size, 0, errp);
>> +                                                  size, flags, errp);
>>   }
>>   
>>   bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
>> @@ -1713,8 +1714,9 @@ bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
>>                                         uint64_t size,
>>                                         Error **errp)
>>   {
>> +    uint32_t flags = current_machine->memfd_alloc ? RAM_SHARED : 0;
>>       if (!memory_region_init_ram_flags_nomigrate(mr, owner, name,
>> -                                                size, 0, errp)) {
>> +                                                size, flags, errp)) {
>>            return false;
>>       }
>>       mr->readonly = true;
>> @@ -1731,6 +1733,7 @@ bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
>>                                                Error **errp)
>>   {
>>       Error *err = NULL;
>> +    uint32_t flags = current_machine->memfd_alloc ? RAM_SHARED : 0;
>>       assert(ops);
>>       memory_region_init(mr, owner, name, size);
>>       mr->ops = ops;
>> @@ -1738,7 +1741,7 @@ bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
>>       mr->terminates = true;
>>       mr->rom_device = true;
>>       mr->destructor = memory_region_destructor_ram;
>> -    mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
>> +    mr->ram_block = qemu_ram_alloc(size, flags, mr, &err);
>>       if (err) {
>>           mr->size = int128_zero();
>>           object_unparent(OBJECT(mr));
>> diff --git a/system/physmem.c b/system/physmem.c
>> index c736af5..36d97ec 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -45,6 +45,7 @@
>>   #include "qemu/qemu-print.h"
>>   #include "qemu/log.h"
>>   #include "qemu/memalign.h"
>> +#include "qemu/memfd.h"
>>   #include "exec/memory.h"
>>   #include "exec/ioport.h"
>>   #include "sysemu/dma.h"
>> @@ -1825,6 +1826,19 @@ static void *ram_block_alloc_host(RAMBlock *rb, Error **errp)
>>       if (xen_enabled()) {
>>           xen_ram_alloc(rb->offset, rb->max_length, mr, errp);
>>   
>> +    } else if (rb->flags & RAM_SHARED) {
>> +        if (rb->fd == -1) {
>> +            mr->align = QEMU_VMALLOC_ALIGN;
>> +            rb->fd = qemu_memfd_create(rb->idstr, rb->max_length + mr->align,
>> +                                       0, 0, 0, errp);
>> +        }
> 
> We used to have case where RAM_SHARED && rb->fd==-1, I think.

file_ram_alloc is the only other function that assigns to rb->fd, and
hence the only function that cares about fd > 0.  It does not
interfere with memfd_alloc.  All calls to create ram blocks funnel
through these two functions:

qemu_ram_alloc_from_fd()
   ram_block_create()
   file_ram_alloc()

qemu_ram_alloc_internal()
   ram_block_create()
   ram_block_alloc_host()
     if (rb->flags & RAM_SHARED) {
         if (rb->fd == -1) {
             rb->fd = qemu_memfd_create()
         }
         if (rb->fd >= 0) {
             file_ram_alloc(rb->fd)

> We have some code that checks explicitly on rb->fd against -1 to know
> whether it's a fd based.  I'm not sure whether there'll be implications to
> affect those codes.

That's OK, the memfd allocation completely acts like an fd based ramblock.
   rb->fd = qemu_memfd_create()

> Maybe it's mostly fine, OTOH I worry more on the whole idea.  I'm not sure
> whether this is relevant to "we want to be able to share the mem with the
> new process", in this case can we simply require the user to use file based
> memory backends, rather than such change?

That does not work for implicitly created memory regions.

- Steve

>> +        if (rb->fd >= 0) {
>> +            int mfd = rb->fd;
>> +            qemu_set_cloexec(mfd);
>> +            host = file_ram_alloc(rb, rb->max_length, mfd, false, 0, errp);
>> +            trace_qemu_anon_memfd_alloc(rb->idstr, rb->max_length, mfd, host);
>> +        }
>> +
>>       } else {
>>           host = qemu_anon_ram_alloc(rb->max_length, &mr->align,
>>                                      qemu_ram_is_shared(rb),
>> @@ -2106,8 +2120,10 @@ RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t maxsz,
>>                                                        void *host),
>>                                        MemoryRegion *mr, Error **errp)
>>   {
>> +    uint32_t flags = current_machine->memfd_alloc ? RAM_SHARED : 0;
>> +    flags |= RAM_RESIZEABLE;
>>       return qemu_ram_alloc_internal(size, maxsz, resized, NULL,
>> -                                   RAM_RESIZEABLE, mr, errp);
>> +                                   flags, mr, errp);
>>   }
>>   
>>   static void reclaim_ramblock(RAMBlock *block)
>> diff --git a/system/trace-events b/system/trace-events
>> index f0a80ba..0092734 100644
>> --- a/system/trace-events
>> +++ b/system/trace-events
>> @@ -41,3 +41,4 @@ dirtylimit_vcpu_execute(int cpu_index, int64_t sleep_time_us) "CPU[%d] sleep %"P
>>   
>>   # physmem.c
>>   ram_block_create(const char *name, uint32_t flags, int fd, size_t used_length, size_t max_length, size_t align) "%s, flags %u, fd %d, len %lu, maxlen %lu, align %lu"
>> +qemu_anon_memfd_alloc(const char *name, size_t size, int fd, void *ptr) "%s size %zu fd %d -> %p"
>> -- 
>> 1.8.3.1
>>
> 

