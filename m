Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FB1E64AB9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 15:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIUcO-0007Y8-R7; Tue, 03 Dec 2024 10:15:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tIUcM-0007Xw-On
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:15:15 -0500
Received: from mail-dm6nam12on2049.outbound.protection.outlook.com
 ([40.107.243.49] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tIUcK-0006Sk-3c
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:15:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LazJpG8TvWS0/I3FjXSTsm3dvQFEcM0K7lh8VcfPlPMQ3EkPWLZxmxrv6Dj+YEVNXsMaBQ3lat67v/fWgIoD9t0GazYQklC6uV96FqBn0dJiEQMhg/+9xWhN2yqWjwWnqBVN9MNqocL2PPlUSGm4MCoFEFYDIyyI/1ITIdKo1E6aLoH/Ua3AwkraVUmkUxvlZi2jYmi5Phvy2OqLdTsFhVDcyzLqNSiWVBf7Wxe/A+E6Jn8sKOVjiuVyUYMPr7H9CbOXmh2cV9BUXHwHosF/0jJu8xpVN1cQIHriVOu7y/ssd2iRflvGX4OibHdJELgwd+NoCo3daTVTIiuKpDRtuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Vgfhucy+ZWKq6k89MjyxJq8znKvm6uXjlCztr8P83w=;
 b=angmtMvk1j5dRXLJONdah8W6HaKVTOaYWMzJeLqNSCUG+BExRUDsVnfamEZKU9pCN6WG0fiNJ0TKOJHYVapRzOXbVif6iktGq5mDlLHgwTiyR3uHMu8H28o0Td33KBjbCJ1R24bbwUReygQnyQloX1Ph+j7BjaQaA10cfjcw8xLci2RAD2EVxw2db/1+TC8YcVU17jxdafleO5jDNxK+DUF5LOyHQc6fLSuWUdAg2aXrb+PPsIC7tF84p0j3YehKNYweKAlPktAa5koNMax7fazqrKccMVZEPxKA0SLsYHC9E65DpG8D9ajIUGlM0gxCDv6d3GpqtP/O1inCaLdAKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Vgfhucy+ZWKq6k89MjyxJq8znKvm6uXjlCztr8P83w=;
 b=JGw4tR91uI+cdLb5K9CIaqzknKCuKfJlaEDXR8LzNS+lEijV0RfzN4rOe4pXdhDbS+d7W1ZSyjHgvm3IHmaMSWzLwdcFh6efwh9J7FPj6g21iskPpVoX6g3ua0vGrHTkEUrfC1PUh5vozdJq5f0zSiagV0mVt0p9i0/oMWtKJwxeuGUgis9ODangGJfrMBILT1PoRKHlUhc3vaFaHtFyoEbSPjewBq9KzOUHMPNtiv5wyjGs6Z83NDl0LR0kQ4sOI8XPtdVTnmGmh6yDvzey64yX7JoxJOPszzOVk1bNsKeuN1COZGcECBaKDR3SY6VoWiivXQ6/198I7a0dzbKeBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 15:10:02 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 15:10:02 +0000
Message-ID: <1fbd277d-c3e0-48f6-81b1-2a5ae97ed9a0@nvidia.com>
Date: Tue, 3 Dec 2024 17:09:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/24] vfio/migration: Don't run load cleanup if load
 setup didn't run
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <72424ece45968b1ae6b39750917a041867c415ab.1731773021.git.maciej.szmigiero@oracle.com>
 <9f27f058-59f0-4056-b19a-f613418e0760@redhat.com>
 <fd69d0ef-67de-4ac8-b00e-a68c4e2ae62f@maciej.szmigiero.name>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <fd69d0ef-67de-4ac8-b00e-a68c4e2ae62f@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::7) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a910741-fec1-4d1e-a23a-08dd13ac8f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1pVc3hYaDA3WXhyL3lCTXRORllhV3F6OHJHNkJvMmRvRzFvdXA0WTVSTHJU?=
 =?utf-8?B?dTg0VW5BKzdCNmJNaDRJNit1Z29Ka3FGb3k0YmJ1Y2kxSEZsK3dhcWJkU0J0?=
 =?utf-8?B?am5tS2w1dFVMQXlCaVhoYWc4a1hpZlpDV0JDUTdmaERhZVYyN0hUUnRjSHlI?=
 =?utf-8?B?QkJTdkpydmpTTWNrR3ZvdEhhcG56YVNndGpOYU52TGFzVFhDVmE1ejdQckdG?=
 =?utf-8?B?WFgzZ1hVRHJxaWt6QitmZkcxMkg5d1BKaWsvTGdJWkNiWkVQT3gzSG51QVM5?=
 =?utf-8?B?R3M1Z0RsemNxRWlzR1NHdWhidkswbmZ5REdKWW1lZllNT3k1WmQ4UDEwK2Ja?=
 =?utf-8?B?M1pqbnpDdWgrQ0FLa2hNR3YyZCt5WHVEQXpSVE9JbmNxSGxVWXQzYzYwSHYz?=
 =?utf-8?B?NFVZNDQ5OEZIMyswSnlTYndma0lxa2ROSzBZbUpUTERkTSsxQ3llRmdYdHpP?=
 =?utf-8?B?aHVibTRocEdVN3VjdmZ0ZXlZRnR6eFRKeXBMTWFJQlVrN044aTRyYlM2WDYy?=
 =?utf-8?B?WFNMZjRWUFh3MUFNYzc4WDZySlkzMUdjSFg4UTlPYTJReXFQdHZ0cTdTRGhX?=
 =?utf-8?B?MWtzMWN5YXlMSkZuTkRPMGhoSGh1ajJ6YjJXT2t4TlpKTzVkNVB4MUY5MmJu?=
 =?utf-8?B?clNRbW5KZk9SSzVzTHAzdlI2MEEvYjl1ak1mbE1YQmtDcGJrd2k1MEZFMHh4?=
 =?utf-8?B?Z0hpUGIycy9DUkRva21nV2pJZU9LSElsZWJHQmhoem0rN2d5NTlBSnNWbzcw?=
 =?utf-8?B?OHJVMVZUeEd4YkJ1NzUyMFVnWGdCSFgvMEZ5aUROSCtCcThEcE1RZUZFZDV4?=
 =?utf-8?B?WTc2b0wrTW1BWWdSZTk4bENnbW0zTmxmVENxdFptK0lBdGRKZUtWVzV3Zmpx?=
 =?utf-8?B?VDNhM2NOVUJKdHhPZkZiL0FYY0NmeVdhcHdRMWlBaGlXRnJ5bDhaZXJEVnNv?=
 =?utf-8?B?cUVOMk9UVXhBRDFGd1BkTjlRRzJjVklOeWVvVzJPd2JFWjlaaE1GWjJqZHN1?=
 =?utf-8?B?enFvUmkyV25FWUVWRkM0c3ZzR2ZEQ0NKYk5aM1NnUDl4YUYvTVkrWm9IWm5r?=
 =?utf-8?B?Q2M5MEJqVE5VaFcxYlFJTU14Z2MzbmozajRDaDI2NTQ1bk40T2FhZm11b2lu?=
 =?utf-8?B?bXVXYnhUSDN6ZkxoanJqTGZXZURqZmxxZSszY2xYRGhrSTNySVJYTXJtanV6?=
 =?utf-8?B?Wms0eXdPcFZiR2Zvc1N2SGc2RnFhcFRNV3M4SzZ4WTI1QlhzQ3BHa2o2SlFl?=
 =?utf-8?B?eVQ0M0FWWG1uaHhFRnRzUmZpMXRWczZTWHI3TkI2eGxhVkhmZ0xhL2JocENT?=
 =?utf-8?B?SFZZT0d4SGpJV045Nno2TUlNTUpSd01QcEdncWdWTmJVN0k5dWdUOURrZVFj?=
 =?utf-8?B?ZlhoNWloc2p4US9aNmJFZ1FPc3FwdE5wM2E3bkRrdEhSZXNZNk9abERYY0Y4?=
 =?utf-8?B?am55SVZlR2YrL3JpUEV5eU1BT0o5V2ZFaWN1NU4wbUxkbFJQTmcveWJ1YUFl?=
 =?utf-8?B?dkpBOWNuZFRwb2x1TldTY1pEV2ZjckMyWTlYbkFtdGlwV21Ga0tRaUNsd2Vi?=
 =?utf-8?B?bmg4MDNCWGRGYTZEN0xQLy9vR1JjV05udDRBOHlxcm1EK2dpTTNhUGxaWFVJ?=
 =?utf-8?B?YU5Qbm5aNE1hTXVhNzc5VWVlRXdFRlBuTDdKQUMyb2kwYzk3RW00ekZTZGRH?=
 =?utf-8?B?NUVDLzZNMGtVZUlDK3UrY3Z4b1RZbk53UHFVRTQ0RHVvYjNnNVJna21WMGVY?=
 =?utf-8?B?ZEZ2cmRqeWxXK3RnNDVHQmpRY09PbTl0ZXRZS2NiekRFWFlMQlYyUXExR1kr?=
 =?utf-8?B?TkJ6WjVSMlYxZXVOaWZuQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1Ryck84b29QWjZQdVRBOW8yU3lLVXVGVEFvZTYxazYrcnJhWnZKVDAxcE9S?=
 =?utf-8?B?MDNBRytSMWhjUGxmdjJtMnhoYXhDdWcyQk14ZnpsUUNsYWhCeHNrN1ViRzE4?=
 =?utf-8?B?dUNkbkkwMEdLaTFqblBVZ2wwMDc5TTdLd0I3M2RJOUY2c2p6Uno0VGNsbzhw?=
 =?utf-8?B?TFlsbFNEdTNzS2hqQUJEOGpWMnJyY21YWXJ0TTV2UHR0ZS9Hdk9lOTA5ODcw?=
 =?utf-8?B?VEMzc1dUVDU3WnptbkplTVVVd3FwQlgxMW5kb0NHaGtrM3RrWkVROTJ6cG1M?=
 =?utf-8?B?Y3pCdFRsOGpLbStSTjJHUFF3bHk5cWU5N3ZXbjJxbWNnaUF2RXlMVDZMTG9t?=
 =?utf-8?B?eWp4V1NNdE9WWWhNQ2ltTUUxN3MzejZheU9sdW5GYmdNRW9BSkE5OGhCSjRv?=
 =?utf-8?B?bjZLZUp0cFNZK3dXVmNBa3BVSTRtZ3AyRkZ0cDllcW50S2VXQlllK2x0ZGEx?=
 =?utf-8?B?dzhyOFFnYjRGQXk3bklwM21WK3QvYnBNbWpYN1dnOUdmYkVvMFJZYzlQMTY0?=
 =?utf-8?B?R0p1WDBuejNQUngxV1BYZEZONXN1Q1UxdUZJaDRDakxIK09VYnEzQUZPenRt?=
 =?utf-8?B?eDMwUkUxOC9ha0xRamhWTEQ3SGQxRmdIZ2RtQkR2aGoraUFZc3ZaM1FlY2dw?=
 =?utf-8?B?aGo0MVowVzRJWEQwTGptU2pnbE0zdzNBUGNERStKVS9wN2RaRVBmb3c5MHov?=
 =?utf-8?B?T2wycXFtamFHQXBUSFBpamk1S2pBT3RiVzR1RjdNRmlvUEd4RGRLTWJTU3JQ?=
 =?utf-8?B?eGVYZ3diSkExdnh0djdyOWRjbTdBYmU4RWNtcGhJZ2l5TGFwQ0FSbDFidnhF?=
 =?utf-8?B?S09KdHFZbmFKdk95TTI3TG01Mkw2aUhTYVhLWG1CWHQvSXIxV1dmZTBDd3pR?=
 =?utf-8?B?RUEyV01uUG1UU1VMMUYyNDVRM1VxQThiYkRsaVk4dDQ2V0FXT0J2dmpWbld5?=
 =?utf-8?B?V2tsZ3Y5TFRvM1F2MkF3ejhMNlZLL1dGWWhKZit3QjdINis1KytRUk5yS293?=
 =?utf-8?B?M2xqcEVZeTBna0x1UWhnQ3A2Mm93U2tOdW9FZlVUelNqVC9qc3ZURWlUQ0pT?=
 =?utf-8?B?U29wZ1Fad3dLK0Z3UkRYRE1KMkhhc29UeVBOTk96bHQ0NGZSbTB5S2VBem91?=
 =?utf-8?B?VEdMUlkyL2wvcE1JRFlQMW1wSzBURjFFZXNFcnMzUU9MS1IyT0VCTWNBSHlC?=
 =?utf-8?B?ZzRUMnIwZkZmR2ExUWRKdDV2ZGRlK2o2cnRyd3lyV3RVM2d6b0FyTGx3QUx2?=
 =?utf-8?B?ajlKRXNTeU9yd2M3blJLZE5zMUtsOE00azBrVHRhNlh4b0h3ODRZbnlibUlm?=
 =?utf-8?B?ekxQR29TTERLTmh0cHk4eGN3aUw3SHdMb1M4UkZjWDZoWDJrYU9LSHB4RzBw?=
 =?utf-8?B?bE9tdmNQZmZwekVna3V4VXIvYTFVUG9Wd0pZM2JkZlhwODk0Tk1INlVVODc2?=
 =?utf-8?B?UGZtODZUaDJ4dUZHTEEyZWZ2VXlhblR2YjdOVWE1eFlwdXlxYXlWdnNkRkxn?=
 =?utf-8?B?c0Y3Y2ZIZVA1Ynh1dnNvVU10alp2RkRpMWlzdyt0YVhuOEVPaENlVnBRcG9C?=
 =?utf-8?B?dzFPYkdkTjNFT1JrQXl5UmtpOTdZUm43VDczQ1RiM2xVdTlXZmM3bWxPOVVz?=
 =?utf-8?B?MmNHQktrb3VGQ0ZKaGdaTXJ0YWlkeU9aQUg4Tk0wUXpITzZqNnl6bDZxWjdV?=
 =?utf-8?B?YlJJS21WS3FCSVZHUlo5cFhIb21HRk80V05iSWtxWTF1b3pVdUcwdS9pMnBN?=
 =?utf-8?B?NTJXU2VQcGxSMWdLTVJGeWpJSytkaHpWK3ZNY3N4Q1JUeWJ2OGdQWUREQk9r?=
 =?utf-8?B?SHBxY0FlenNpcStDZGJleHhXRTAwTkorWDVCV1VZQ2Z6TFZsdjhlajgwaUw0?=
 =?utf-8?B?Y01Vd09UNUNjeXJrYlMvRlM0VlBqMzJDdkZRa1luUUxTeDhLeExBSzkwSmFZ?=
 =?utf-8?B?dUFiM2I1dURyZitJLzVSVHBrNG94M0NGRFVVWC9nZWJMeW5QcHdXQ3FGSU54?=
 =?utf-8?B?RFJFaER0V1BDMjEyZ0sxcDY3Q2I2TXRrMHB1RUJHd1RiK0xIYkFPL2t4YVJD?=
 =?utf-8?B?ZE5PczdiUkMvbEh2WHJaRTlQcmkyQXo2NGNadi9jMzBUSnJJM2E1Z0JYTWx2?=
 =?utf-8?Q?kBcB/kn12JouFTxhf+Vcof8P+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a910741-fec1-4d1e-a23a-08dd13ac8f42
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 15:10:01.8467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtZgRdk2eihzRRpT+Ej9704YwFYyJMQO7iLfxmOfy8NJ0m6YszvuQVUMHnw8nQ0s1Ul5slrMvrAeuR69jWfseA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
Received-SPF: softfail client-ip=40.107.243.49;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 29/11/2024 19:15, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> On 29.11.2024 15:08, Cédric Le Goater wrote:
>> On 11/17/24 20:20, Maciej S. Szmigiero wrote:
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> It's possible for load_cleanup SaveVMHandler to get called without
>>> load_setup handler being called first.
>>>
>>> Since we'll be soon running cleanup operations there that access 
>>> objects
>>> that need earlier initialization in load_setup let's make sure these
>>> cleanups only run when load_setup handler had indeed been called
>>> earlier.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>
>> tbh, that's a bit ugly. I agree it's similar to those 'bool initialized'
>> attributes we have in some structs, so nothing new or really wrong.
>> But it does look like a workaound for a problem or cleanups missing
>> that would need time to untangle.
>>
>> I would prefer to avoid this change and address the issue from the
>> migration subsystem if possible.
>
> While it would be pretty simple to only call {load,save}_cleanup
> SaveVMHandlers when the relevant {load,save}_setup handler was
> successfully called first this would amount to a change of these
> handler semantics.
>
> This would risk introducing regressions - for example vfio_save_setup()
> doesn't clean up (free) newly allocated migration->data_buffer
> if vfio_migration_set_state() were to fail later in this handler
> and relies on an unconstitutional call to vfio_save_cleanup() in
> order to clean it up.
>
> There might be similar issues in other drivers too.

We can put all objects related to multifd load in their own struct (as 
suggested by Cedric in patch #22) and allocate the struct only if 
multifd device state transfer is used.
Then in the cleanup flow we clean the struct only if it was allocated.

This way we don't need to add the load_setup flag and we can keep the 
SaveVMHandlers semantics as is.

Do you think this will be OK?

Thanks.


