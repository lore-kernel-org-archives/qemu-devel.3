Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC72CC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 19:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBfcB-0007us-KP; Mon, 27 May 2024 15:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sBfc5-0007uQ-72
 for qemu-devel@nongnu.org; Mon, 27 May 2024 15:02:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sBfc2-0006Bl-JE
 for qemu-devel@nongnu.org; Mon, 27 May 2024 15:02:28 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44RH4g68001251; Mon, 27 May 2024 19:02:23 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Doracle.com; _h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D6/fzJoMR1KB2nbE8A8yuy97l9oUaqvsYE+mzqIDRt4o=3D;_b?=
 =?UTF-8?Q?=3DBFU1Y6hX+C1uqQU5JUP2zO8JFB1/Im/YvCsgGBuGh3Q6qJCb25XUSmhgYL3+?=
 =?UTF-8?Q?pf9ynOIz_c5uXsEykZoAJ4KQSQHiAJbcpb/oV43PQYTzA6fsvJGLqRtwF5LO6bx?=
 =?UTF-8?Q?RjjSr7BYASCXs8_dld6poOOVEoyaMpMzw1WCgfHb8xS0ao8QFc1j6nwCsMYTdJ4?=
 =?UTF-8?Q?VyhOErCdl1i1qavTYdhK_hbrM1jQ1rWfmy44OO72EgO7oLT4CUZWEfX/vIXNLr1?=
 =?UTF-8?Q?1TDYKhGIDQB0UbGhTcVdDPXqN5_Lq7t+D44+2KhGCo6xZS3J8AitNeT6zpxHUCa?=
 =?UTF-8?Q?vMU7gSfdGwkJ4DnSYsyPqdYQs4xQGvmU_rw=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g9k0s3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 May 2024 19:02:23 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44RHpnPa037601; Mon, 27 May 2024 19:02:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3yc50529ah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 May 2024 19:02:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sfh/ySK1CaefFqNVvt6/8uthorzD5BnS+9eEKImmz8i12CpM/aOVYpbdYFlKcSsWsrJ36Ymxs7cAu6xQZdhovhIw9OixHuB8Ntk77tCfeXdbWSKEgxWHZfi58w+CIJOrQ0VQKv5A73sdLLVCCR1FvI3s+xLojXgCYt02CFcFt8v0Q93hOKFCZgTnotDG6n70I3zfOw55SX98pGVRQMHMmrs0a971xXXGRSbQFJTjDKf42KPC2BU6zASnYuoM1xkNPwoX+SbUfGAEY7P0jzy+wVNmkubVCoNSeyAeQ8ggQ7esnQhmwwYiiHQfoyyfJUU5yIweYP64DkX97LC3CijCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/fzJoMR1KB2nbE8A8yuy97l9oUaqvsYE+mzqIDRt4o=;
 b=KEe39V3I2oXm2Sq1eSkcuaRaXrJ2W82S6E2g0d0uveV5kwvGBLgdZLa675JdPqoAjIwYmr3t+viVSeo5N04FfunARty1BorAj8gGs+GrHfCXwC+Mjbmi+De7Ts0nRPE+n6lqlnQWI1ESX5P4yYwm1JgashJhQenFAubCw/2VA9a4pO1SK5CKaCamGns86ECbXtLrOlhfDn4h4t61zKgxSOw/qpNX2KPYK0KRFfkY2EzzTdtrHEzeby4WhVwaxsppQYeKqKfq1oKzhq3ZeCkH1HszaYAqU9dXlGH1J6UrI9oirUJ3HsXezoRwUNVeY1nZvQWPu95uNrLDA6QfewGtXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/fzJoMR1KB2nbE8A8yuy97l9oUaqvsYE+mzqIDRt4o=;
 b=vICG5x6ixGnOf3uysEPPcCe/485C5utaSqFOKHMqxHV1o8eCY/F7iE5NoLiUay+jKJsricJWcc+mQ7iHo28CcdQP9xPqcU0UlAPaiVTaB6ASWZstq6wlyZURtube943/p77hOLjzTwB5sp5BfdnhyKEN6a92QY5ZL4UYHh4yAsQ=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by BN0PR10MB5192.namprd10.prod.outlook.com (2603:10b6:408:115::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 27 May
 2024 19:02:20 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%5]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 19:02:19 +0000
Message-ID: <941f84c0-ef2e-4800-adb2-7f32d2638d87@oracle.com>
Date: Mon, 27 May 2024 15:02:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 23/26] migration: misc cpr-exec blockers
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-24-git-send-email-steven.sistare@oracle.com>
 <87o78vgz79.fsf@suse.de>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <87o78vgz79.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::31) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|BN0PR10MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: c67e1dd4-ccc2-49f2-03ed-08dc7e7f8870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHMyb21adnlOcVRVd3J0Tkl4OE5haGQ0WFY3OGcyczRGMmJaWFFRMzBKcTlq?=
 =?utf-8?B?OFpFa1hmbWl3aFAvNndYeXg1M3VBMytwazNNaDI2TVRWNitacFRkRGg5a2dw?=
 =?utf-8?B?NVkvYlE0Z0pndENOeUxXaTFrTWUzU25vU1cwR1lUd0dhRnh0dDZnU2Jralpn?=
 =?utf-8?B?aDUrUTQyNHEvWHlvVncxcUxRSWt4d2hNM3EvdlVnSVFoWGw5U0x6R3pIRzNM?=
 =?utf-8?B?NGhya0VUUFJBOXMvQ09VOUtleDVyc0d0VVdTQXQ4WFZkWm1qL3BHY1h2cHNw?=
 =?utf-8?B?Nm9JUW1FVGJIdWgvT21RZU9lYXRJVnJQYXk1TElaME5xZGUySEJkbXpvZm41?=
 =?utf-8?B?QnJUbmlJdWNsOXljZENBaGdTa3pUS3Z0Ujh1bWcwWm4reG9kZ2JqdVZWNHhK?=
 =?utf-8?B?NU9zbklta3c0b1NnVmxGTi9rMW5TeFJoMm10ZzhEaDFnTmpNQnA0S0NHYW1p?=
 =?utf-8?B?QVJrODhhb3pRenAxWHZnZU9QM0o4bnMyWHh4WTVrQkNXdXRwSkFtSTdONVcw?=
 =?utf-8?B?NUQ0UnRQVVAwaHNVNmtLYS96QWVLTDJoL2toWWFIK1JwazhlY2x4Z0JHWThD?=
 =?utf-8?B?NHFEeFRUbnMxeGNKNVBPK3NUeEZQMFRJdlg3elZxc29nWDIrVzFqY202d2NG?=
 =?utf-8?B?bXBUdUJPaFc1bzc3S2hiY1VFZlpSRXF3NEZYT1Y2am8xWXJqYkhzbTduNlhX?=
 =?utf-8?B?UnBpN1o0eXpzb1NpWnZ2RHU3ODI3ZDZ0a0NQYjRBNkN2Z0lvL2VZYnZBeXlO?=
 =?utf-8?B?azRZc3hkaHNYaDFYeThOck5sSTRHS0prWDh6VzZ5SDhJeGhEZnV3VXVIRWdO?=
 =?utf-8?B?Y3dhazRFSGY5aElpTFZLUUw2VGNSMGNTM0lZT21mTkVJb3JSSysvLzBtdmRw?=
 =?utf-8?B?U0o2NHlaTzhvR2lGSmFFSTVMSCtPQlNEbVRISnhCbTloV3RnU1U1TlBodkha?=
 =?utf-8?B?MTF3cUZ1d2tFT3d2VzJqRWtZWmhPeGNkTnh2Q0NtdGVCdmNRRXZnZnJPTHc3?=
 =?utf-8?B?MGVMU3ZKYVB0YUF4LzhKeTlUWS9ISEREUUIyZG9hWHZTU2RKV3JZcmI3S3Jp?=
 =?utf-8?B?eHkyTnRGWXBkcWszaE8wamlkS09qNGRXQkxNTElhRDl6eHcwK2VVN0xvQmJ4?=
 =?utf-8?B?SnQxalN5NE1QYWhYVlVBa1J4cWpRM0FCdXRDdWdyWU5ENnRMVVFRaHRyRkhL?=
 =?utf-8?B?cTE1SFZmMTVCTkxUSUFCcTdKc2h4MlhtbkhGSjN4U1dQaXBsc0wwMFJTV2NZ?=
 =?utf-8?B?MWVYbmpjS3d3Qm1LSU1YT2hSREN4emtnMXBCd1FZTElCVStUL1Q5cGNUTmxn?=
 =?utf-8?B?bmkrV0lMZjdXSEk3N3R6KytVY1hUb3BzTVdQUEpJek40bTFvRmREbHJKTzlx?=
 =?utf-8?B?Z3JOVTRpS09sNE5FQ0pmUlhFYmIwRS9IdVFvRGUrV2dJSUlLR2F1Z1pCeTNo?=
 =?utf-8?B?bSt5OUpSVWlJRWpwQy8vQTRCWGxDbGloUDFwbWxOZEVFcmg4aGlWc29JWFRB?=
 =?utf-8?B?NXV3VlJpWkNKVzlDMHNXY1p5MEtOVjhRSW91cWt4WjFkSjROa0JwdGdSM2RX?=
 =?utf-8?B?My9ST2ZlbzdvRVY0dnkvRmpIWEJHdEZRYzZEUmtiNWMvamFGbGlKN21GUlA3?=
 =?utf-8?B?UTlESDlKV0pkRTVlQ1hyOGJYOElyNitIOWYvL2FNQzIxWlBnQWNKZzBqb1NF?=
 =?utf-8?B?ajNHcWorSzhXeEJ6bERLQnh3NE9RRVJ1SmxCMW1yNlZxeXpOS1pqZlF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(7416005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjJjODhrT3ZRWDlEd2NSVElwdHZlWFdpLzdwa0FOL1JGclFOT0V2czBwclNy?=
 =?utf-8?B?QTk3dFNzazlpd0J5dTJma1NDb3piOVBBSVliSXByakRiaGZLM2hPYjA2M2Rz?=
 =?utf-8?B?T0RKcnlqZzZjV3VnMlVXNGs2S0h2U1FnZEJaUVdlZkJnVnRKdTUzZ003R3lX?=
 =?utf-8?B?Nm9GVmQ0K0JoNllZSC9wSUZac2h5eE4wTEVkQ1hZV0pzMnBpbGM3SjFMTXRl?=
 =?utf-8?B?MXVvK0VQV3l5ZzhLVW93UEtkOFp3c1NXZG82NUtObno3U1ZTa2VybHdwSFdh?=
 =?utf-8?B?QzN2dVZ6T1VGUTlwRDZvR2tZT0Z6bHYxQ3E5VUd3d2crNElOMU1sUzhKeWhm?=
 =?utf-8?B?TjNLcXpjdVFQdWN4OWY5Q0hlalArVnhkQk1xL3ROelVhbmFnVS9LVTltbHlm?=
 =?utf-8?B?MktVWjgrRDVMbmJjV3RRYTgveDBSekJvbHg1b2h2dmJyUjBsSGZHVGREcSsv?=
 =?utf-8?B?LzBwbXpBbHdUdFUzajU5WStFM1dWWGJrSkg5Njh1Q0U5cnBmYlFRb3BCV1lN?=
 =?utf-8?B?MUtUMkRCQ1JwN2cyNnJrayt5cDM5VVVFTVEwcjl4NTRDeW8vUHBsN0xINklh?=
 =?utf-8?B?SzNUei9JWWF0ZXpGYjQrbU1ObktnTlNhRXd0dUdWM203UG9YWjNhWXUwMzI5?=
 =?utf-8?B?NzJrM0dPSjNqTHd2cW5DNjc3SEtIaUdmTkZ3M2FUMW1xck1Zam50ZWhOTk9a?=
 =?utf-8?B?NFdOZzZDM2RjZzBzZzRXSk5YSXBteUdzdkFCQzBLbHkyZzVlQytSUnFGdGNk?=
 =?utf-8?B?cjlVcjhYSGFuS2IvcThWMlFOUmwyR0piaVZETlcwb1NIQThvUmpwQ0hrYXpu?=
 =?utf-8?B?b0JQTEVTQk9GMVY5RDM2VFNPeXdwRStvTUR3aGR4dUpLcVNFV25DQTVEWjFr?=
 =?utf-8?B?cm9NNURqY3NJN1NNVUp1bUJGODJpZmhhenRKc0lRTis4OEovbStUMGtCVWpV?=
 =?utf-8?B?alFudWgxUy9jb05WYldvTmZxUzdvUXBmdEJiM2ZpUnloMmxKUmVkK0NCUXpX?=
 =?utf-8?B?U2dDZG42ZGRjY0h3U045T0NNQXd4aDV1U3JET3VoeHpYMTVPTklMOHIxR1ZM?=
 =?utf-8?B?d09nekNVNk1tS29KVndOUy9mN1diVlFBOW1hWDlxcitjRWFURzJvRzNRbXoy?=
 =?utf-8?B?WUFxMFZQNnZEdWNJMnRIeU5jdkhJMDZ1cUFOVjFWUVcxdjdiTU9jUjNYV0JL?=
 =?utf-8?B?dTIwbDZoUE5sbWp4b0R1Qi9zQnplaUZUbEJQdVlDb2dPVkRIS3RLUThTSUZ0?=
 =?utf-8?B?elljSjVsSk40M0JiZUVvRjM4L0tyRE94UE8wSU45b2pDQllJMFFTWHJ5Ynpw?=
 =?utf-8?B?VGExaisyS0R6SkhOOHc5UklzNXM1cXg3d3FPQjBiWmkzM0pWYUd5dFZ6c0Jx?=
 =?utf-8?B?UXpsTDFmcEprelVnN1NySERtV0lvUFd0SDNINmhPWFhQTlNGV1dNYllYNDF5?=
 =?utf-8?B?bHdCOHI0VXlrYTBYRkZnT3N4VlhHUXlvTVBBMG1Cb3dvdXRka3N0QTFxZWo5?=
 =?utf-8?B?d2hxQkVBTHp5L0Y5VWYxNWowRjI2ejhEUVc2NXRDNVdGd0c1bVVUT1lYa21Z?=
 =?utf-8?B?WllGUVY5RzUxT2pVRW1pMkk4KzBlV1RTQXVYL0lVajQ1ZFlMZ295RTdGUXBX?=
 =?utf-8?B?bytPVmJtS2dyM3JRN1o4QlpWYlNLWTNmUGRObmw2UTFiMGs2dW5Cdy9qckd2?=
 =?utf-8?B?NWNqUEZ2UzlVODBjVkpKc0xVSjMyMHZsQ2pYUlpwbXY3U0E3UEtoQ3JhVWRq?=
 =?utf-8?B?ZTBHQXJQeEhXd1ZXMWkwd3ZOTFNuQjQ1SXBQRFVNRlBneE1YQXFMNWo2ODZN?=
 =?utf-8?B?QmljdlNsSXg4Mm1qaG8vVHZJVUN4UVRSUEhsT0x3N29EMU42MnRvazBhV2dE?=
 =?utf-8?B?Y2FHTEZhSTB0Ky9lMGo1NXNmRWNrdU9lcEw1UmZYd3Z5SjJPZUo3T2xmbkpH?=
 =?utf-8?B?ck9DRUtxU2VsZWYxMU8yMTBNUFdCNmt4R0lZcFlUNS8wZWh5bEFyRVNENjFL?=
 =?utf-8?B?Skt0ZmpOOXZ6azh4T09FSjZvVDVUMzNjbkprdWJ5MzA3SFQ5SU1ZN004a0xJ?=
 =?utf-8?B?SlNrWkZVUklvdno1NytWeXBYOUkvbU9Zd0dCcWFheVJZZVc1clk4SGhMNEVh?=
 =?utf-8?B?SzRpai9QV2xUZi9BOXRvRDhReGF6RS9sYU52djRQaTZlK0NXZkszVzJ6YWNm?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XZecPMRk7Sf7DHlKFPcwSczjbyfmIRIiz9RKYI8aGnX376PzilHZOTgpFzdqUDEhKEHc3xjJa2ohvLY7hONOnyNKl2TkFEeGQ3SfRRrCVIrcfII8cLpn01BeASxytk/6w3cNPZ5jAWhdM6KMYmlLbzDPYOdRUc+cuk9IizjcA3xTzzLSJfEzLBdFonL0GjFy/d7cjkVW6PX6rXvGRdflGQkNCJUjj+6NE57S/BgOSZ8BwHrpWnsUL5UL/HsOTNpuDXD4ceIVUzgYdhxsQ54PpFNf+5H9hIQQqRFw9dLOXkhGMx4vgnmPjGG/uds8+nB9NY4Ld8zdB+w3BBL48FwKcP///2yM+XnMd/2ODRwZY/BxIHpIbnazvKz5JwJ2tO3+jhaqfmtKg7PqJknYCF+grc2Ph3ILJEkiaZPezAfD27UlvEYsrjeAL5kailwjrFw9NBX5Y9QU7uhSVv+HUhu3TpVltg9iWO4+AnkNC2aZAWForL0OqxFLQ17sbRpF/Pq45grej5ygAvoS/1Dw9nQ/UjiMK4Vk3Y+mQZagKkIWOl4l3gypx7Zla008nWubXnLbQKGIHh1BpKB8ZS6KoqRCJFORS2Jd6ec8dsY+Etif+pg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67e1dd4-ccc2-49f2-03ed-08dc7e7f8870
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 19:02:19.9327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJx1bAMZnyPkSQelmSqAZioSkRGUltglDtI5MY+WifCZjzbwfod9FpRMFug/awUfWI1ZYEa2OWWvP+mWVDAZ76zZI1ewtFfo3ynHUdk/ex0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405270155
X-Proofpoint-GUID: 7eGIL3Hq8G23-kHg8xtORgwvP1Yg-Ru1
X-Proofpoint-ORIG-GUID: 7eGIL3Hq8G23-kHg8xtORgwvP1Yg-Ru1
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

On 5/24/2024 8:40 AM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Add blockers for cpr-exec migration mode for devices and options that do
>> not support it.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   accel/xen/xen-all.c    |  5 +++++
>>   backends/hostmem-epc.c | 12 ++++++++++--
>>   hw/vfio/migration.c    |  3 ++-
>>   replay/replay.c        |  6 ++++++
>>   4 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
>> index 0bdefce..9a7ed0f 100644
>> --- a/accel/xen/xen-all.c
>> +++ b/accel/xen/xen-all.c
> 
> This file is missing the migration/blocker.h include.

Good eyes, will fix - steve

