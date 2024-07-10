Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6009DC3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 20:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRdzZ-0006XR-Ov; Wed, 10 Jul 2024 16:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sRdzX-0006WV-Hf
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 16:32:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sRdzU-00056X-6E
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 16:32:42 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AG3Icf012180;
 Wed, 10 Jul 2024 20:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=hQuQYh68QO+19sVnfjv/Xz1U7PkIjyRkHRCfb4wOmiE=; b=
 WOFYlnTkWcYL0ZRho8GkTqUQu//R5gPIu3EK3aOUMDfdkfbHxP5q2cWJKcFwwOvJ
 vcDiPmrELsLpuLgyc6NpLxtvM2Q6iOAQNyQVCtoJvIaqH4o90vUUmzJRLHAHsjrD
 XnB5MqUgXCsWrIocennPHytt8+WyBb2lt9HU5kdjWAF/igjTpZmraMEGnMsBPA8l
 Jklp7w1ixIASu8eSGf5cTndvg1R7ay4r1XnyoWJBSja0w0Qo8fkfwZ6v5BPBpe9i
 MRAtzJjh55jM4tD88N/cccUkOq5qCT3HEV+YyFnqnmhVFQfDwGKCfaoGUBHmyU5B
 Xxs8lze5U/RlVrZ87Jqgpw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emsyhqs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jul 2024 20:32:37 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46AKPdkp010347; Wed, 10 Jul 2024 20:32:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 409vv4v03u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jul 2024 20:32:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQ96ds45YzwgjPxL6zwsVb7tbiXxB+4stmi/+Zk3IBMR0as6RMGItILasyqu2aCK3nma/gu+ZHzWAmSHA4wX1/CMjGm4m1ILFKIOarJBSVRanFVQ0iDqwo6iKlfX3i+lcPAm8D9kWNIiCDqa1Vl74Isi0DZI7w3ZlbHw58PQAfmtYUasZcgEzJrvTi9k6rEpH8glByqkK9NeoNv/go9UC3lGffCHqrvCsrakxlDn1zL85QGYZr1OkAZ8cHenJ8Nf36aDATZP0W7lKt6lzpFLefkpa/3WqQ4cf5ePJwTrKr4wI5pHrroDMFcSjyZPApW0ldpTtxfuTG3gvAVVgkWgaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQuQYh68QO+19sVnfjv/Xz1U7PkIjyRkHRCfb4wOmiE=;
 b=UiY/KeKyMYtqAIOPMNm9+J6/5pByJNmWwCFhEnU5WcmZTZ7C9aj6bnlwMLaDHfuB9rf35w9t1w+QDanlpYkHEeT0/GOGwzBezLROPD0rkhJ59i4iykpPgkqkr9q/ZhbYADis5twd9w59UvJaqPBWeHaYWfISJNQPn+qw8loibEISzGh8Z/UizGMULuN8ewYOuUT63D8JbsGzDBGev7yBAIGK0ecjF1mKQHoAcBxkVZgO78L5JU0d4FrSb+Pz5yHCibuBp8YNgv7RJAnIKqhOhku09IlQ2jjPjwXqlwreJ62NWuLJt4fP0qBp9FFue9WnoELAaulWzfDwHIY+ZdlYzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQuQYh68QO+19sVnfjv/Xz1U7PkIjyRkHRCfb4wOmiE=;
 b=oQwdxqcC778DST4fxt/roSK5Vh9Gd30xh49wKrpvuvtuGoZ1M8enOvGBU/W+6vEaOMHpsro6Ckx7JjXyamvGddvtgY41YaY5xnWNDKgCBkghuDu0r0lHcMQjVjy85eaT+OR1V5Cn2bSHQJghj02T30J7m9YmW4EWUpjAR4cGlnc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB7852.namprd10.prod.outlook.com (2603:10b6:510:2fe::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 20:32:34 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7719.028; Wed, 10 Jul 2024
 20:32:33 +0000
Message-ID: <059a1fff-901f-458e-af53-cc9910bcd80e@oracle.com>
Date: Wed, 10 Jul 2024 16:32:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 4/8] vfio-pci: cpr part 1 (fd and dma)
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Cedric Le Goater <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1720558737-451106-1-git-send-email-steven.sistare@oracle.com>
 <1720558737-451106-5-git-send-email-steven.sistare@oracle.com>
 <20240710140301.4491b9b1.alex.williamson@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240710140301.4491b9b1.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::6) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 11182b58-4ee3-4d12-42e2-08dca11f6dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFNaTWJrVEsxMGNVZjJaVHFJa2s0bXVkeGpxZlpKNmVDR1FTQmJIK2J0Tm5P?=
 =?utf-8?B?cHJLbkRaYUhVOGNkWU4xMmU3azhWZk4zVWJYellqNlFhZGp4VWFEVkpqTHp6?=
 =?utf-8?B?eVV3OUFKSmZ0UDVoa3ErbDl0K0x3M3VhRDQ2a05QN1lyZStqMUxXOVhKdlNN?=
 =?utf-8?B?dTBpVGVmU3BiMFZOaC8xdEw5Y0QrRXduQjU5ZzBxUlhLeVVWUitUeWhzWFo2?=
 =?utf-8?B?ajk5MmpZYTdXV09yR1VrK3RDZEt5ZjU4NzZZcXF2U3ZyZ1MxTU83VlRoN0tl?=
 =?utf-8?B?d3kwNjBGNnNtcTVjT0tLU0lDeHN5OGRsR1FVdWdkVzBPbXptM2plWWY1V1Vy?=
 =?utf-8?B?T1Zxdml1MjF0RExvcTZVc3ZlOVFSbXFLNWVtcE1QOElQNVV2aFVhVk8yYWpI?=
 =?utf-8?B?VzR3RFl6VEErZk1pcTNseTY0RDZ1TnBhblVpK0VSbGszbWk3VXNjY0JnNEJu?=
 =?utf-8?B?VVVtMmMrcE05TXZyc0d5bGZic0REQzNMYVpjODRNRTBvQlpHTnBka3F3S0JW?=
 =?utf-8?B?T2haWkk5d0U1aHVUblRTMkk5ZWRHTnd6VDBwaDdqZlkrcTVCZFhxMjBsSEwr?=
 =?utf-8?B?djZVdldrR0wwdXVEMld4OVdLMHErSWw1ZFNuNUxYZjBUbTdzZ1lFaEgwaWRp?=
 =?utf-8?B?Sk9MeEI1UmJtcFpFd2JldDhHbTZhSjdIbFNnd2ZiTktoSkNBb0FFUXhrSzVi?=
 =?utf-8?B?eHM4bmVmL1FmNzlkZ3d1a2luMWI5YU93Z2RLdExlVDZmbGUxYnZGOHNXdy9N?=
 =?utf-8?B?RndLZDNXMUtDRnk3bytXWHBiVzV6dDdSRjE4OFJmZ2p3VmtDWG5mYVV3amxp?=
 =?utf-8?B?SW9PRlJpTi94VUF6aTFwVE90M1FJSGI1T0VFbEVGQXhQdDhCYnNFL0M2aWNV?=
 =?utf-8?B?NjVCRHlTUDcxM2ZLTnlqVGMvWlcyU0ZwTld6NVV2aGJCTFMwNGNQQzRSek5q?=
 =?utf-8?B?MWdHeVE3SVVTWThid2Qva0cwZk9wUzFjSnFHZ0NyTGZKNUFQZGsxSTBOREpr?=
 =?utf-8?B?bFA2UUgvMHIvY1pnT2krVm1ybG5CcVFLZUdZMXdNRi94TldEQWNCOE81T2hx?=
 =?utf-8?B?VmhPaTdjMWQ0ZTFhMWd2d2FaRXlOT2xkcHE0TVNETXdLazFGM3dzRzc4Q2Iw?=
 =?utf-8?B?TkdISmdKNEJMQjR6U09ncWRPV3BKQXNaWkVhMk9lV0ZVOWp3TUlMUzVxaStk?=
 =?utf-8?B?TmxLSGVRMXg1T0ZVSlM1QlhWZVVhVDFHMTNHd0ZRNVhVaXBOc0t5dFZERGFE?=
 =?utf-8?B?b1F4QXRWRUJWVVZXL0F5bWtsSnQ4UzZGVWw3dm44M3FsY09Hd09XcWQ0bkJq?=
 =?utf-8?B?cDYxdXZZWk0yTWFEcXZUZjhjUHNGeTl3Yi80Q0lNNFBCOE1vRHFiei8zSnha?=
 =?utf-8?B?Rk5yZ0VJbEtKRG4wMERRYi80dHNlcjhYOGViZ2VKb2RudHdRMkR3d3pNQlFk?=
 =?utf-8?B?VWFOSm41QjBwUzJObmIzV1BoQVB1bHhmNVNVYnp1K2Z1WThqR2t4LzM3c2F5?=
 =?utf-8?B?ME1LSmp3ckVNUTFrdFYrYkFENytzNmU5MlpTNG5rQW9Dc29YYVJ3Rjg3Zzkx?=
 =?utf-8?B?bHBXZVlPYzhFOFhLV3lDaU9aTjFpczdMa0t3RmUwbmVqbUxLODJ1ZlArdG0z?=
 =?utf-8?B?ZURiQ3NyRXJXbmVGY2poMWswMVc3Si9udERldm96Tm9aeWZOdjUvRUQrdlFx?=
 =?utf-8?B?b1VYaDRJQlUwVWp6TXBtUlFZWU5BZVNCenNKcnNPZ2lBc0h1UkZzM1RVc3Ey?=
 =?utf-8?B?UVlvb0xZYWphS3J2bEEwQm94NzQyemdTOGg3RHFwZzFiRFRxSmhWeFdiM2oz?=
 =?utf-8?B?MnE5ejdJMUY1dnRtaG1IZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UURNRDJFVGxFWXp4Rm9KZ3ZGaWpCa3ZESnRMNVhCSDlmU1hib3ZQbjBreWg3?=
 =?utf-8?B?Q2hTOE9MbkZRYmNpS1pSUTJSakhPOTNOSWgzRWd1NVphZ0NzWlJPQmhzS2NS?=
 =?utf-8?B?K2VoYnhVSjUwMWRaaWJpWTNzV3RJNEcxVXd2NDBBa05EZ0hwekxIcGI0aXpx?=
 =?utf-8?B?cit0L0xLV1NtQnpidmxPYnZRS2ZLby8zWlE2YTdvZnJtVXVHeFU5OTlWam9I?=
 =?utf-8?B?b2ZKZm5EQWZ1V3hwamp6SlBXdWluMEFyOHFiaUI5WEVHeW5HTXVpRnNtTk10?=
 =?utf-8?B?NW5VcEVpV0RZZlpsL1hsSkxnMDhMT1pKTjlhT0RDTHI2ZXdEelFMR1pESDJh?=
 =?utf-8?B?Y3dYTk9hSzhnTW50SE5iVWVBTk9GTGlMdmxxQ3U3T0psNTdjZ0M0SFRrSHl6?=
 =?utf-8?B?MTNGZDE4NU1BNi93a2dmTHJCTkQvWFhmajE1b0RpbzFLSUZFOHBCeXFrOWJK?=
 =?utf-8?B?bXFZT0ZvTWcvWnFKeXRHRnM1VGo4ZWdORjE0VGZzM0xZZWN4RjY3aHpDR2hG?=
 =?utf-8?B?UGJpcGg3NHVqcUhrMWhvVW9EbityRWRCU1lpSWdUdmVSMDJWQUdyZ0hpZWhK?=
 =?utf-8?B?MWJsdkR4anpwU3hzbUhLc2VKeVZlOTduVVBJalZnTUMxTGJ4MjlBMTV2bzhB?=
 =?utf-8?B?NDNOQVVObjlxRmJtbjBWZ2RrSWoyOS9MS2hLelJuZngrUDEwZkJzamJ2QkFQ?=
 =?utf-8?B?ejlBQ2YrUmhpUGFvNDFsZUNTQjE2aWluRFVidXdzYVVSOWp5U1dCcldoRWpx?=
 =?utf-8?B?OFBUUDJSMjBDZjFOU2dtWm9jNm1rVHVWVktMR21nUXN4cGtYUnYwdFkrODZh?=
 =?utf-8?B?bkZqait6bEd2VThFaFZ0MU1JR3NldFFYYmw5RTRxbnpsMnozZ0NGTUpGcDJW?=
 =?utf-8?B?d3M5dlhIWHVCR2J0MXZsRUN5UUxNTUhiU0hTdFpHMWxKVktDU3p5cnJ4UkRE?=
 =?utf-8?B?WXpxV1ljK0pJYVlDOFM3bEsxWEJhVC9mWlZHMWlBSmEwbWhGbk8rRWhFd2Y0?=
 =?utf-8?B?WWI3RFY4UERiaVVKR2wxZFY1Nmo5VFlTVnhpM3F4ajkvdFdpY3J4a3psM0Yw?=
 =?utf-8?B?MnJVcTZTRWdCeWRDN3M2SENzZjRwNDRCL3diNlNwVEhXYWd6NTl2bmpCTE1y?=
 =?utf-8?B?YjdRRE10UCtqMWdLRWpVTngzcHV5cFFiVmpWWldWQ3VMZ29EM0JvYXNBWmE5?=
 =?utf-8?B?Mi90V08wMC96MWRWZGZHekhyNjJqYVN5UWY5VDRLc2xiOU5ZSXZVdmgrQ255?=
 =?utf-8?B?U2pxSDlROXBnaGVWOUdGeGxLWUEyaDlRV0xPZHYrNXBkRmF3MVhzRDBmcXk1?=
 =?utf-8?B?OXdVVnBPajNQS0trUlVwQzRuQytZSllUTVIxVDRxckYwNU13RE9UTnFBT0xp?=
 =?utf-8?B?MlFSb0dZWk9yZGNDcnZHZm1rTzM2MC9sNEswV1E5ZVBrbTNOWjZMalRsdFJ0?=
 =?utf-8?B?VmZqZHBNYnZRZnprbkF3ejJwbWVSRCtDdEpoakUyU0FoWE05NGdtUWZRb3M4?=
 =?utf-8?B?d2NCeG9hbzFnUUpoaVQ5by9hbDJ1ZFlLZzNTY2RpdG8zUE9CRWEvMXRUWnFN?=
 =?utf-8?B?VjR3a0hoaHU1cTlGMk9OS09RMkVBSHpURktacG9FUUJHOUxaREVxcEJsQ2Vp?=
 =?utf-8?B?aGFTZW1kWHplRER6Qm1yQVdocjNSemc3eG1KczBHZUZmd1hIVmdBbTAxSitw?=
 =?utf-8?B?Z21OcENyUnRZUXNmOUg5dU9mZ2RNN1lOS0hNQWZYRTkrYXhaTXdJQ29LRVdJ?=
 =?utf-8?B?alZLb3UwREllVzU0cS9lL1Y4S0t2amVoNHhVTmtlYjNFa1diOXhieG5JbWdK?=
 =?utf-8?B?ZStBSkgyS2c5OGZkdzYwaEFqYXBEZDVLeVBoUmNIWGloYU14S0k3c0hyR0hS?=
 =?utf-8?B?NHh6My9MdWlRczh1V0dJKzhFNk1mTGpUK01LQk4vZTR6U21ZZWoyMWNhU2l6?=
 =?utf-8?B?NVVTOWNLY1lRL2prOXQ0UnY3Qm9JTllaQjJCQko2RS8ya01JcEVmQWNvRzdR?=
 =?utf-8?B?WmpSYTk1SDE3WHRhZ1paUHpRSHhuRkRIN3JYcXZRMWVCWStyZTJTZTJoaDFH?=
 =?utf-8?B?WWV0eUpiRGtCQ0ovZmJOVGtFdElLZzg1eXArWmhzREFCZnlja0x6V0NmSnA3?=
 =?utf-8?B?OUVqRnNYSHZ1dEU1SmprTFRVR3VXTE93NXRiWE5BSFNrUVJZQW56SHBwc0hu?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2P05e3vXZ68Lzug4FxYIiCvk9NaFkomgzhsNmFsSIzaznPHNrBa4eRTVmHg+EE6bq94+5wO/vmvS0OKH6O28lCcEbPLlPBlWbh7uh0E+YvpyJO44t+3alXGPtGzjoMQhmJNvKeumNhM548GCruj2LGZapY2bfFjJNefMDZ5eowRzCDGsc4bRBjAHBHDe9amlmAmzH/AQ+pmNqDSksQgDPyiWzFpT83n7NyinZHNacczphaTxdkxzUuzSAre0co6yvhrhqCcHF9VKJMPD1qGf2ZbAcvoqQd4q8/n6dK32+G5UGEga5lRwP040SkagWpeTIlDrq1nA4yZdPjNA6+cYa/nEZhUm0pg2AOC9SgrX3/GURDhqm5EoetSkWYZYYUGTQ5pGtwB9ksQcwsnR20Q8tP1kWYnoR8YU1ta9H3l5yYtqrPVNmL7apccWeE+PSRJgYOz45SBHVei1XKzt5E9AYenqXYh96/uLw3izJP4cuYeinnIDMot6rxxkamMKY+PWg5zVeXyU5MZOnm+RSnmVs+WuAGXdZO0pD0GB7cUf4uz/J/Z3xCbzJG/haV87s/OinIlqUDN8ySZK76LpmvIVX1ZOZViJLOi3Z5InmDMOAFY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11182b58-4ee3-4d12-42e2-08dca11f6dbd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 20:32:33.8772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnCgtPIfIwvZWw0zWcBWhMnCDlSSWOqTniJITlOLHDsLnrJ+lrPMwrRHnC4xuGSa2UG/8OgvPNm+2KNdRhjQjju519lViKV8sA8gUXBeOcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_15,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100145
X-Proofpoint-GUID: uDrVQ44ejxgj3aelqZdzahN3hxa41PlD
X-Proofpoint-ORIG-GUID: uDrVQ44ejxgj3aelqZdzahN3hxa41PlD
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/10/2024 4:03 PM, Alex Williamson wrote:
> On Tue,  9 Jul 2024 13:58:53 -0700
> Steve Sistare <steven.sistare@oracle.com> wrote:
> 
>> Enable vfio-pci devices to be saved and restored across a cpr-exec of qemu.
>>
>> At vfio creation time, save the value of vfio container, group, and device
>> descriptors in CPR state.
>>
>> In the container pre_save handler, suspend the use of virtual addresses
>> in DMA mappings with VFIO_DMA_UNMAP_FLAG_VADDR, because guest ram will
>> be remapped at a different VA after exec.  DMA to already-mapped pages
>> continues.  Save the msi message area as part of vfio-pci vmstate, and
>> save the interrupt and notifier eventfd's in vmstate.
>>
>> On qemu restart, vfio_realize() finds the saved descriptors, uses the
>> descriptors, and notes that the device is being reused.  Device and iommu
>> state is already configured, so operations in vfio_realize that would
>> modify the configuration are skipped for a reused device, including vfio
>> ioctl's and writes to PCI configuration space.  Vfio PCI device reset
>> is also suppressed. The result is that vfio_realize constructs qemu
>> data structures that reflect the current state of the device.  However,
>> the reconstruction is not complete until migrate_incoming is called.
>> migrate_incoming loads the msi data, the vfio post_load handler finds
>> eventfds in CPR state, rebuilds vector data structures, and attaches the
>> interrupts to the new KVM instance.  The container post_load handler then
>> invokes the main vfio listener callback, which walks the flattened ranges
>> of the vfio address space and calls VFIO_DMA_MAP_FLAG_VADDR to inform the
>> kernel of the new VA's.  Lastly, migration resumes the VM.
> 
> Hi Steve,
> 
> What's the iommufd plan for cpr?  Thanks,

I am working on vdpa and iommufd as we speak, with working prototypes for both.
I plan to submit the kernel and qemu RFC for vdpa next week, followed by vacation,
and iommfd in the weeks after that.

- Steve

