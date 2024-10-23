Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED8FCFA467
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 20:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3hym-0006UK-0K; Wed, 23 Oct 2024 16:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t3hyj-0006U8-PK
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 16:29:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t3hyg-0000Oh-V4
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 16:29:13 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfet3012081;
 Wed, 23 Oct 2024 20:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=T2UecbWpGOI9mLg+a1qoeHISLwds+shaL9D88w5UMMg=; b=
 kHVjijjh8ywT+q3EORIEcwdqfYzfaYAs5zgaGrMB4iiuYPwLxDMX9rIpI38B8Sof
 1YINhLQmz8dq7q7bD1y9WAzpwWy+f9pzhWOVLfeRCqxvZFlaPdOgUAWrgZdMSY/j
 pQ7C6caQgreFUt0YSaJZNUzUOMoO+Wd3uKCuGMSGG8mQIl4NPXsnCx8bBsNfFSp9
 nv7uRE66iCcEbT0Dhqy+H3r4fCdDNi48RGF/CXR43V1Jpz0WMbPEkZVaOmpYzEqc
 jtSvaAAl1gsD8oWShZSGlcQCh0gdKx1n7tCmqJe1wMBzUa7hzc57AChEJNoR4Nsn
 +nrPjCq7LKo5cECUSfEcXg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53us3tw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 20:29:04 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49NJIEw0027484; Wed, 23 Oct 2024 20:29:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42emh3b8ab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 20:29:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYbok9mn4P+/SDG45vOC155KYtKkn13DuNDlkI2vN6g8IzkkRZgpvArI7kTczt+5KIEavC8AU9OsksXq2oPsKBWMurxSIzwWFWZx0LoLIiCwge+FrlTYRnGnRiSWYA9JFQKTAOK7jlc2nzAKbKIVKW0iMu+1ORGZdnkPGKWGixx8z/GvD/aUZPFDeziK5SKGOBEeMfy7P1UBPLvElLzddGOcVuxBBS13mZjcwvmpbA37Z3UocR4xscRCZGEhIg7H35GrP3YiNYbGEPXc5W2wW1KuUhER9XSFcqjt02TkExlV5YfKUmhJg/aAzO/4G8/wyt62JpwtmxxcUKWwzaqrCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2UecbWpGOI9mLg+a1qoeHISLwds+shaL9D88w5UMMg=;
 b=i4tFUj0r+jnHKcYQ0jtWeqIlhO88OKE4yoO/IzJLfEib1u7EZ5nphBz65KnuvSrwDHwcgt9EgKkRM2OIu4l00FXONCkIxcSXGhRYc9fTx+0DN1ePVlWaEYgTLBRhWwkstwHsLnMnRjDopu4sexubi8eIQQ/cwBgYNSLgLIVJZNVPLJ2HhbWRcCLPWRE4wKxN77I+d7ebXl7dM7yDBaofUIwc68O2z8+WAV1g8keOmGF2OPhiQxcC3WoVINB1ROlb2dSLgInZWoRkfIcgVF87l5swsVd+VugBn/JBOg+jXsvyJ96p3McrBtSGIAm23tA/4AqOGDx0/ZCQo8EHjmWujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2UecbWpGOI9mLg+a1qoeHISLwds+shaL9D88w5UMMg=;
 b=Jk1cqEixnwEJhPHhI4Mhj69klPKRdZI98QjnxHbYFj0ihzgQmGrDlXkyxy42kMrWV/qBMESSB1VzjcTeS0Iz6pyj4iolf/hq/NPnaPJ0DcNzBkDKd1sOVUtprcTNzQRfA9zhepzlHzcQS/s9OI9mp5HK8MojqoJsu1JQ9nhBzjk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB6758.namprd10.prod.outlook.com (2603:10b6:208:42e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 20:29:00 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 20:29:00 +0000
Message-ID: <cbbd6fda-2bef-46d4-8c13-91cdd7cc96f5@oracle.com>
Date: Wed, 23 Oct 2024 16:28:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 04/14] accel: set accelerator and machine props earlier
To: David Hildenbrand <david@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-5-git-send-email-steven.sistare@oracle.com>
 <87ldyl1mah.fsf@suse.de> <628ceba7-9cf4-4ad2-b3e5-6af4037a0bc1@oracle.com>
 <4c0645c9-a38b-4399-ba30-cf2ced63fc5e@oracle.com>
 <3da9ec87-3466-4fad-b4c0-2bcfe3853b5a@oracle.com>
 <ce3c0f72-0442-4519-9c0e-bbd67d25730a@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ce3c0f72-0442-4519-9c0e-bbd67d25730a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0126.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::11) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a637a08-766e-4af6-6657-08dcf3a153e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXliNUMvajVBekVLVTV5ajZWZzBENGJGbWVVRlZoUzJJNjlSSGxoZTF4Z2lj?=
 =?utf-8?B?R2h0TGYvSzJyTjVEOUQ2SHkzZ0o1YncyZXNneGY4em5sd1BHMWZRUzcwMWh5?=
 =?utf-8?B?dGlGQnFTNTVnSHpyejdjb0RRRFZqeGYxWnFoQldrTytGVE16djVydlVNVCtY?=
 =?utf-8?B?VmRjVU1yd2lpZmJPZjJ6KzBlRW5QRkphWTlKVkk4MWhyRlVOMlFBWG9oa0hC?=
 =?utf-8?B?TklkQVI0b1VwNE8xWFdrTkprVmM3Y1JCMXZWM2pyd0ZLUElTYU55NUo2SUQ1?=
 =?utf-8?B?aEVpVFIzaldvYU1nMXpqMk83TW5LQzJZOGc5cXJUWDFVN1hqV0hrczVKbXdR?=
 =?utf-8?B?V1NVMG5qRUNHTWhSSW1CdVNMMmFVc1ZSVHBPWnRJRmpRMklGbWxNeVJrK0RO?=
 =?utf-8?B?ZEFzQXpxWlBYUktLWHFhQUVaeTg3cGdrQlFMb29nMDRsK1VwKzM3Y1QzVEp5?=
 =?utf-8?B?UElmSnp4a3dtMjRVcjlRZStFWVRSR2lQQnY3YVRZdDFXZ3B6Y2Eyc0ExNElq?=
 =?utf-8?B?NzhxMXJrNXNMRUg1MGY1TGF5U1NWWE9MWSttMjZHdDR0TkhBdHhsTmQvQzhG?=
 =?utf-8?B?YWJyUVd3Tk5Fa3d5amtBZUJzSGQzdUFucVJWMFBXRGdDRFZ0SWZHODRlRUlE?=
 =?utf-8?B?UDZtV0NRd1B0RmxabG9QT0RtTUcwcnFEb1JKNEUvQXdvd0tiWmdBODlpZGZT?=
 =?utf-8?B?bmNFUk5hdHViejhrZkFtOU1MbGRGR0tMYVY3NE51SUlkdGFVR2lCZEJMMlhM?=
 =?utf-8?B?Tk1sNnV0MVJObHdlVlc0aTdVT3BBN1pvdlJRanZjOGdJWTJ4dDhTODdqNEJw?=
 =?utf-8?B?R2JTamhHL3BGQzJNL010Umk5bFpZa3RmTjUvWWVwcHNEYWxTa3BKb3FDUERm?=
 =?utf-8?B?NjlZekw1MVB6Tlh6cFZxbm52U1RiYWdralZUKzNVVUxvcVVRYXZjb0RYdHZD?=
 =?utf-8?B?Rms5RzNSSlZHMEI5L0FFd2ZNMy8reER0SEFpWVptNTNySHc3SmNKNlFIeFVW?=
 =?utf-8?B?dWxGOHVlRUk3VXhJOXVReGhFYnY0alFWNzJZbU9rMnhTSmhWWFRFTzRwOVNF?=
 =?utf-8?B?Tmt0MGlaU0JsNHBROThENnZ3YUhuWnY5WkcyN3Q3UXhDcUFjV1kxSytrZEV1?=
 =?utf-8?B?NnRoUWZsVWlmSko5TmZGdm93NTM1YzZ4Y0ZjWUNNY1JRWVd6TXJ5SXdTdVdS?=
 =?utf-8?B?cVlrL2xCbWlycFVmYVdRbHhQT1A4UWI4ekFMWElIYzdiQ2VwelptcFdVNTZt?=
 =?utf-8?B?RkJTcWtTbTA0Ukd5a3ZuYXJqNUk5VzNGUStpUVNjak5MU1NFYmxjeWRrblVa?=
 =?utf-8?B?QU5acmxJK1BxZTZwZ3puUnY3MzlONWFzVS9jamIrOUg1SnVkeGRCNTJQeHhX?=
 =?utf-8?B?dFNBYkdoQ1QyRERWT3RPSER6MXErTDJ3bmRja3ltWmYyMkN0SU41Y043M2Zq?=
 =?utf-8?B?QTMwQkJGWVQ1YXZSMGllU1gyNHE1VGFKNEducElUUHZ4aVprb3JVZ1NWc2U1?=
 =?utf-8?B?OURRb2lJL0NUVU9kanRqTi8vclZ5Zm1JUWYvSU9VcHIxd1MzMXV6bjRCMEJX?=
 =?utf-8?B?MXlIVnBKTEx4L1g3MnRXcDNka2dSSXBZRkpjZW16TzlHczIyOUpaVWJpRGhK?=
 =?utf-8?B?c3gxMTVzUTBaNDlmK25nVE5rVHphdXVrUmdvZ3p0WUNnVmdPR096em5HTFVY?=
 =?utf-8?B?dmQ1RHduQXZ4cGN2aG1BeW1kM2ZwbmprSlozR1Y4WXRSZFA3SkZoQVB5b2Rw?=
 =?utf-8?Q?msKScnnbP9TPzah5mn3VrQ5sUNG8GEOo4wnUpri?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cy9ZaWxEMHZqd0tDSjZUcUdsNDgxTmhvSEh6ZGxxRVVWdUhlR0FoWWs2RWt3?=
 =?utf-8?B?QzVqQUpoZXg4NDkxUlVNUG9uTG9FMEhiVDZVV0MxVEdrb1lqUlluUXUvTDZE?=
 =?utf-8?B?cWIxTzAwTllOakRwRGUvT1dCTDR0aHhZWTMyM3hvVlhlNEFjN1hnK0s5NzdS?=
 =?utf-8?B?VENsSlliUkZjSG9DRlBwWXpwU1BDWmh0K09WNkFZSWZBaGdCUzZyTndOWlMx?=
 =?utf-8?B?RjBQcHNLSHlMU3YzQklBTFJHUzg5RTJvUzJUbzM4MVRuUDhGRk1qMGVHTEhE?=
 =?utf-8?B?ZHhXaHkvWmhBNFJNelRMdmJzWlA0cFdIL05lZ0JVL05TWU1wb3BVOWUzTXM0?=
 =?utf-8?B?YjZ1RVZrcTQ2ek1oNmMvVVBrL1JXeWFOcVJLNFd5TzE5QTc1bCtZN2lQWmxJ?=
 =?utf-8?B?RjZheDV1QlRXTGEzNWdWckVkbkhsR2JHZmtTcW9aaFVCc0hDRVNPWlFKeUta?=
 =?utf-8?B?d293RmNLTjA0WWV5QlBKb1VsWjB1UlFOaEdTcDRWUFRBcXNyNzVMUjJHQldC?=
 =?utf-8?B?cC9xeDJJaGNIbENjd3NuL214WWVkRzREbWJtSU9Na04wejFlc084R3d0ZDJm?=
 =?utf-8?B?L2d4VVU4VExITEMwTnI4Y0VLS2ZqRDRRbThuUGpVS2R1SHVxMElvRFpUZnAz?=
 =?utf-8?B?SnMvMFZ1Uy9QOXZBbDNpb2dEQllYSFVsekkzZkVRT1loK2duRWd4cytIR3hE?=
 =?utf-8?B?UnFpRjBpOG1PQklRRlJJTlEvNE5KOW9FTXRxNmoremdDMmFMSHJzd0ZUTy9z?=
 =?utf-8?B?UStzK2dDTkdGdHNaMUVEcE0zWmh3cjBPRlJXbVhMbzBaQVVpdk52ZmNUTGtY?=
 =?utf-8?B?bW9iLzZXbVJHSkoyQzhneGdpSGpCcjMzbEgyNXBIWW9lV290MFF3WncxbWxE?=
 =?utf-8?B?cWdSR3RXRytrdDAya3RQZTRGSXpoMTNkQnh1SXNmV282R1NENkJCdlkwRE1m?=
 =?utf-8?B?NWZPR1BkY0VYLzVjV25pdE5hZHNnVU9mS05NMVZ4WVAvRjVqaHlJWFhQOS9Q?=
 =?utf-8?B?NTE5eHZ1VEkvaS9SU2ZBZW44ZTJJREFUSWh5WGxuRUd4Zm92UHVmTzdnN3Q5?=
 =?utf-8?B?QXBJOUU0blAzL1p6OFduZXlWaUhnNndqeGRRSzZnK3FEaVZxR0JOQ1pQOW1h?=
 =?utf-8?B?VzU0aVdjcFN5VlBxVkQvN2NiWnZFZVVtUDhxYjNuMVhBVm0vNUVXUXpPVjlJ?=
 =?utf-8?B?Z3BMVm1BNjBLOXJrbXFFTmhDNzJrTmEyaUxUYjBoamRENnpLSFFnVEVvcEly?=
 =?utf-8?B?NlFBeml6aFdlVmo3eEhrVGQrQUljdjNqcVVaZmVxc3l2TFlEaDNlWkp4L09V?=
 =?utf-8?B?MzVyMHR0L0pscDgyL09iVmJ1YkdVNkxTZlczZ3Nmc084RmRkcytROWd5eHBN?=
 =?utf-8?B?MEFNZWxKVVMvVTVNekluWVZ5Qy9iOVh2c21CbUs4K1VBaktOcitDQmlSaHA3?=
 =?utf-8?B?ZHZHU3VUMFg3eDhDblcrNC9RZ2lmUmZrK1J3YmFwUWpMSVgrL2hwaWpBNXlY?=
 =?utf-8?B?YU5uemxrZENOQ1JnQWI4M0lrNnI1RHBIdGlHNEJkTjFCQkN2enZTRTczN3Ft?=
 =?utf-8?B?QzlqbWpmNXFiUmg4by9vTUNEMkkvTXowdU9jRFVpTmtMSjJQUGRhYU5mbjd1?=
 =?utf-8?B?eDBMK2gzczE2RncrVXVaY3BMZnhhVjJiVGVVc0VvWDdITHdVRTNIcDQ5RVNx?=
 =?utf-8?B?M1hScW9DdUNWdStPWWhxRTNTNGZLcVNENVFQdWxndG5NZVdTNEFYdUt3bHF0?=
 =?utf-8?B?OWxaUjRwd1puWTNjWnYzNG5QVE5FcTZZaVp2QXZMdG9vL2hCVXRJMmN2YU1x?=
 =?utf-8?B?LzJBTk54ajBiekJHdldCR1NCQnBiVjN4U1F0MitTdmFGeE81b0tVNkNoTGIy?=
 =?utf-8?B?b1NscFFSZGl6MHgwYmZFK05GTUFZYWtETTkvS3JqNElza05WU0cyREp3UDYr?=
 =?utf-8?B?SHlacm51bW5sc3YzaWI4cmhMUFd2L2xmamplaFhKVU9JdUpHanU3dUdEWncz?=
 =?utf-8?B?VzBiUk50NGQvM3YvWUVGbmc2d2d0aWF4bElDZHpsQWt3UGIwQnlSNlBzQ0d4?=
 =?utf-8?B?ZUI2dHFQTzM0SUxmam1GM1NEV2w5TUJoNnRHVXF2Y0h6ZTE0Y0QxVlNXSVRZ?=
 =?utf-8?B?MTRoYVdBV250SlFLaERHQ1VaYXg0VWI2MVFvWnp5M1dEbGxVZHltUE1JZStZ?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hjNPxKZJ4N6THxpWpoMGTSBBfbNi0QKgauX/JzP0yN5sV0X0zX+BojXtcv1Xzptzt377mS0eQz3PuhCyA4QqT03/IQy+6mMy6AhoG/eL8KBk7IZ/fMFbWIbmgRC94U/GvVuRteBB9LU1sKZhVHw/GUZ8M0IhS9dWMPhhxuc2F/DfA83C6KONhbxgwrevkCNYQe3z9OqN407fyQ6KNkrr3+LRfUghWExSug9B10v+cQz7z7ILHAoRJWq1j+nhICI2jHNLhfQ/hy5yQP7xHd7GWJj9YePRoMfXQarRFK4j8PhPbf32ypT4raSiRWueEtY41/xo2o+t+lnEPKZ4OW5DF7kzXvTYI6gFKBAftQSw08FsKzSjdJeRBdRvCrDu6ggjvymPLf0MeUZoVvq5RT9W26NJLnN5pEwLhjQsV8BvwuqE9PWVF2KH255P522rPjSWd+WxHPYzrxBNeFmzc3zcq0uSZbZKxz1nCStWN4idYwpuViHnRQkBj1cM96NsRQvNqxSfX5i+wmOpu2wnosXKycJUXApSmHrca1T59RQ9tddLAPCf0HpjtvKA31X8zJzrBdebeGOAzFlvZVLCoHmRCjd2Yd+YIjjcbNfRbFtzS8s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a637a08-766e-4af6-6657-08dcf3a153e0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 20:29:00.4808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KM8E1NkdPSLhZrcdMuH41VpF/yIQcj8tfqTOLrR3KKq7H/iYEiv89NfCVCz+pmPvMv81QvbFHFo71Grp4XHaOnejReodYxAnpTYPRbgf3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_16,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230130
X-Proofpoint-GUID: 3apYinsVnZSsUZFBq_VHu60lZoV2QQs6
X-Proofpoint-ORIG-GUID: 3apYinsVnZSsUZFBq_VHu60lZoV2QQs6
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

On 10/22/2024 4:30 AM, David Hildenbrand wrote:
> On 18.10.24 21:15, Steven Sistare wrote:
>> On 10/18/2024 11:40 AM, Steven Sistare wrote:
>>> On 10/18/2024 11:32 AM, Steven Sistare wrote:
>>>> On 10/18/2024 11:08 AM, Fabiano Rosas wrote:
>>>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>>>
>>>>>> Make all global and compat properties available before the first objects
>>>>>> are created.  Set accelerator compatibility properties in
>>>>>> configure_accelerators, when the accelerator is chosen, and call
>>>>>> configure_accelerators earlier.  Set machine options earlier.
>>>>>>
>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>>> ---
>>>>>>    accel/accel-system.c |  2 --
>>>>>>    system/vl.c          | 34 ++++++++++++++++++----------------
>>>>>>    2 files changed, 18 insertions(+), 18 deletions(-)
>>>>>>
>>>>>> diff --git a/accel/accel-system.c b/accel/accel-system.c
>>>>>> index f6c947d..c8aeae4 100644
>>>>>> --- a/accel/accel-system.c
>>>>>> +++ b/accel/accel-system.c
>>>>>> @@ -41,8 +41,6 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
>>>>>>            ms->accelerator = NULL;
>>>>>>            *(acc->allowed) = false;
>>>>>>            object_unref(OBJECT(accel));
>>>>>> -    } else {
>>>>>> -        object_set_accelerator_compat_props(acc->compat_props);
>>>>>>        }
>>>>>>        return ret;
>>>>>>    }
>>>>>> diff --git a/system/vl.c b/system/vl.c
>>>>>> index b94a6b9..bca2292 100644
>>>>>> --- a/system/vl.c
>>>>>> +++ b/system/vl.c
>>>>>> @@ -2346,6 +2346,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
>>>>>>            goto bad;
>>>>>>        }
>>>>>> +    object_set_accelerator_compat_props(ac->compat_props);
>>>>>>        acs->accel = accel;
>>>>>>        return 1;
>>>>>> @@ -3728,29 +3729,14 @@ void qemu_init(int argc, char **argv)
>>>>>>        parse_memory_options();
>>>>>>        qemu_create_machine(machine_opts_dict);
>>>>>> -
>>>>>> -    suspend_mux_open();
>>>>>> -
>>>>>> -    qemu_disable_default_devices();
>>>>>> -    qemu_setup_display();
>>>>>> -    qemu_create_default_devices();
>>>>>> -    qemu_create_early_backends();
>>>>>> -
>>>>>>        qemu_apply_legacy_machine_options(machine_opts_dict);
>>>>>>        qemu_apply_machine_options(machine_opts_dict);
>>>>>>        qobject_unref(machine_opts_dict);
>>>>>> -    phase_advance(PHASE_MACHINE_CREATED);
>>>>>> -    /*
>>>>>> -     * Note: uses machine properties such as kernel-irqchip, must run
>>>>>> -     * after qemu_apply_machine_options.
>>>>>> -     */
>>>>>>        accel = configure_accelerators(argv[0]);
>>>>>> -    create_accelerator(accel);
>>>>>> -    phase_advance(PHASE_ACCEL_CREATED);
>>>>>>        /*
>>>>>> -     * Beware, QOM objects created before this point miss global and
>>>>>> +     * QOM objects created after this point see all global and
>>>>>>         * compat properties.
>>>>>>         *
>>>>>>         * Global properties get set up by qdev_prop_register_global(),
>>>>>> @@ -3765,6 +3751,22 @@ void qemu_init(int argc, char **argv)
>>>>>>         * called from do_configure_accelerator().
>>>>>>         */
>>>>>> +    suspend_mux_open();
>>>>>> +
>>>>>> +    qemu_disable_default_devices();
>>>>>> +    qemu_setup_display();
>>>>>> +    qemu_create_default_devices();
>>>>>> +    qemu_create_early_backends();
>>>>>> +
>>>>>> +    phase_advance(PHASE_MACHINE_CREATED);
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Note: uses machine properties such as kernel-irqchip, must run
>>>>>> +     * after qemu_apply_machine_options.
>>>>>> +     */
>>>>>> +    create_accelerator(accel);
>>>>>> +    phase_advance(PHASE_ACCEL_CREATED);
>>>>>> +
>>>>>>        machine_class = MACHINE_GET_CLASS(current_machine);
>>>>>>        if (!qtest_enabled() && machine_class->deprecation_reason) {
>>>>>>            warn_report("Machine type '%s' is deprecated: %s",
>>>>>
>>>>> Hi Steve,
>>>>>
>>>>> after this commit:
>>>>>
>>>>> $ QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/xlnx-can-test
>>>>> # random seed: R02Saf9b44f2d88dd417052905692ee79981
>>>>> 1..5
>>>>> # Start of aarch64 tests
>>>>> # Start of net tests
>>>>> # Start of can tests
>>>>> # starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-2396.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2396.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -machine xlnx-zcu102 -object can-bus,id=canbus -machine canbus0=canbus -machine canbus1=canbus -accel qtest
>>>>> qemu-system-aarch64: Device 'canbus' not found
>>>>>
>>>>> I tried briefly to figure out what the issue is, but I don't really
>>>>> understand the dependencies involved. Hope you can tell us.
>>>>
>>>> Thanks! I forgot to define the preinit method for the qtest accelerator in patch 1.
>>>> I'll verify that fixes the problem and send you a one-off patch if you want to continue
>>>> testing.
>>>
>>> Actually that is not a problem.  qtest qtest_init_accel does nothing, so preinit will do
>>> nothing, so it is OK to not define preinit.
>>>
>>> Still looking.
>>
>> I understand this now.  The old code worked in this order:
>>
>>     qemu_create_early_backends()
>>       ... creates "-object can-bus,id=canbus"
>>     qemu_create_machine()
>>     qemu_apply_machine_options()
>>       applies link property "canbus0" with value canbus, finds canbus object
> 
> Now I am confused.
> 
> I think the current code does:
> 
> qemu_create_machine(machine_opts_dict);
> qemu_create_early_backends();
> qemu_apply_machine_options(machine_opts_dict);
> 
> Isn't the relevant part that we may only apply the machine options after creating the early backends?

Yes, I showed the wrong order for the old code, but our explanations are equivalent.

Perhaps this could be fixed by moving qemu_apply_machine_options after
qemu_create_early_backends in qemu_exit_precreate.  But that seems risky and
fragile,  as there would be a large window of code between qemu_create_machine
and qemu_apply_machine_options where the machine has been created but the machine
options and not known.

- Steve



