Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D63CD5BDF
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 16:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smFcW-0007BN-96; Thu, 05 Sep 2024 12:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1smFcO-0007AY-Oe
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:46:02 -0400
Received: from mail-dm6nam11on20611.outbound.protection.outlook.com
 ([2a01:111:f403:2415::611]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1smFcM-0003r8-C5
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:46:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKx1gakV0x54P3OHB6pKhzRHAp6QGiam+zTg0WRY6Jn1drfM2y65RNsuZlzoT/XiwrQR3OMIW9qbtWGAbAi61SJp7WYTxedNuFKt12Z4pS8sYL+Z9Z4knINxYYaX/U6EDn/uC8WXiH0mboLSbln4IawW27BJCvR+8NaZmpgPtsRMTBTsj4HOO6LEfLBOqo/grPGnc7TOD1rP6AS2KZ6VbJ2lrEoj/4FjmBQdWtnNJZudqonbH4pJxSHdGb6s7pLY6FTvBL8wHs7ZHemj87zjQuia8D7NNLeabHu5v+r7scKr1m6XyuAcLUbCdeyA734vitmToqvcBeCBGHl2HVM5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFpyRhM1ga+InxajELql2sgx5DyFOUeKrGPg9EFJdmo=;
 b=EfHfMR1cLJZwXskzRBJC6PhfZCB3emjYQdD36ySJGNazJe+3+PukUdHpsDO04dz6zmQt6nZlWILOJQMEMM/xWahPYx2pZPagtcf/QE18p1YYYwlH37cMasfKYbWg1KKgY0SPcMaVlpUr8Mi1IpfS9i1ThXMaFCoZq+ZRIzg+DiHMnqvPfJZvw6yOuG1gL2Wd2b0TgFGCtbwfJKU4t70bzAJCaboxBM9m57YBBVcpez/ioPueXUA2RC0AGRhjipX/+nhscPnedi2u47tpZ06OAiLx7dVZZzfHQ8+rXhXyHd/X5eay8fHslWzJ9dcMEIUrCULDY6eUlcF5XSq4u+9BuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFpyRhM1ga+InxajELql2sgx5DyFOUeKrGPg9EFJdmo=;
 b=Ko2oL3DoToU2KCzIGroSALWxyILIGBjKi1/N8FQ6OGGbqlT5cN+2pb4f6lifoWv2gf86agfRnlBqujkFRu+Ewd6384kW8GSDxZ1rOQqqpC8wzHP1Ow0dddjhDQ50nNTfjcwKllH9MRSD70fovzYHGbm68jCZfXc+txxm51JqvYObStzvDKBHQuVw7nkTkS03X3kXzgSnk/foUvC9pGu2svbKQ0ec9rCrw2+nNFMSOsHnTvGQy7oYwdBmB35m6ZDhCjMDnYNCwtCxsk4fj/dC4WCXYT92ntto+aU0Ofi6lJHXf/3wE7AJL0k/JOMumvY0vNchpPC3kRENUxF4TryNpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ2PR12MB8846.namprd12.prod.outlook.com (2603:10b6:a03:549::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26; Thu, 5 Sep
 2024 16:45:52 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 16:45:52 +0000
Message-ID: <22f013dc-6c47-4902-9b28-08e916c3cf54@nvidia.com>
Date: Thu, 5 Sep 2024 19:45:43 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/11] vfio/migration: Implement VFIO migration
 protocol v2
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Zhiyi Guo <zhguo@redhat.com>
References: <20230216143630.25610-1-avihaih@nvidia.com>
 <20230216143630.25610-9-avihaih@nvidia.com> <ZthZ1aW_JmO3V9dr@x1n>
 <95d10ed3-33ef-48a9-9684-3a8c402c5db9@nvidia.com> <ZtiHzQHJ4PgWc21e@x1n>
 <b8807171-567b-4e21-af83-bc2f6dbbf606@nvidia.com> <ZtnLhW-2eo8hA7bQ@x1n>
 <812e89c4-35d8-4fc0-ac10-ec36d57f215c@nvidia.com> <ZtnbD69EeXhR6FFc@x1n>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZtnbD69EeXhR6FFc@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::20) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ2PR12MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: c471375b-3255-4dd1-fc96-08dccdca33f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEZZd3RlV3hCakRRdENTTnE5c2Z5dzdCaE1wWXE2VVFzc3VzYWJUendIS292?=
 =?utf-8?B?ZHhOMTRLa3hXNmdDcWQ4SzUvTkRsdjVYLzdScTNXbWlvdjkwb2hwTnRyTFhV?=
 =?utf-8?B?c25nQ0NFZnRQeXN6Mi9WOXVLQ2drL0YrUVViTVF0aEFmWHNxTTJrTmdubWhr?=
 =?utf-8?B?SVNyWmxBYnpnSFNTRk1oVkNoUFNhTDBBN1NwMnAvNmY5YnUwaEhnQjlSVkM5?=
 =?utf-8?B?RkFVYitNdmZDVnRjQ09hQmlkNHBsY05pVjZoOXR0UG9kd3hMYXR3bVc3Nmd2?=
 =?utf-8?B?Q08vaDA0MGtSS2hpWWgyYjZ1OHZUaFZpWFpmSDB6NmFSdk9mdnpZYVZjOUFV?=
 =?utf-8?B?cUNIcjJOWVlZVTlEKy9JWkZzWHZMM0xJMmtIYWtDSEpzalJWNXA2T3Q0QWQ3?=
 =?utf-8?B?OFVJOUhLbmZidEZLK3k0ZkVsY1lZM1lmeEpTRlcvRkJseVdmY01iNHJpSkJF?=
 =?utf-8?B?aTcvZ1RUSWZHc2M4eWpHOTZkYXR5Z3NSQXFNMFZEOThrU0hoMmo5M2tyRjc5?=
 =?utf-8?B?WSt6eUJkSk5iRlR1UmFjZU51QkhKR2ZWQk9rQTloK0I0TmQ1Y21IV2FBMzVw?=
 =?utf-8?B?TGs5MmJBbXUrUkV6T1VONzlIdkZTaFdYbVI2ek16RHQ3THBaam9BckJwL1h5?=
 =?utf-8?B?UnFDZ2sxcjM1UGNOWTFRMnpNKzdzc2VVYy8zR3B4YkoycldjamZFK0RhYlJ3?=
 =?utf-8?B?dzdFNXh3ZmNwbzVXSXBHZnZIRmxXQWthMm1QanV6cFhaaDlUaEh6QjR5dlhY?=
 =?utf-8?B?SEVicXJVOXE3SytJT3gwajdUWGdhRFZIMEtwVmg3Q3ZTR2kxSXVMOStya0tv?=
 =?utf-8?B?L2FUOG91cWtnSS9ROGFBcDQzMVVTbVpPcmRVQUJYR2VDVVBpZS9XZ0RlYjJj?=
 =?utf-8?B?b01UVVdsb3BTV2ZKZ2Y0WVprdWgvajdPeDFJUmRQNlZuY00zem1LcUsyYVZX?=
 =?utf-8?B?Y2hoMVRyeUw5TXJlTWpTRWVZVFBrek1iWHhRdDFZM1h3YVJsd1hzaUpEUHU1?=
 =?utf-8?B?MisyZUp2empPbzdqMzg4MzRpT0VDZDVhZlZZV2gyVTh0R3pKSmVOOHJDNEtE?=
 =?utf-8?B?azMxRnNod05XVWluemFFRms0a0JLR3daN0xNV2tkc2orODZrZDExQndTbzNi?=
 =?utf-8?B?cHp4OEZ3anU0c1B4ZEJtQXRmUVE4aFl3Q2g4alNLT211ejhzUEZJME1JUCtM?=
 =?utf-8?B?M1lMNkJpOGhCWGQ4NThmY0pTM1FGWldWMTlnYjh5TzhIQ3Qwdk9sd0dkTnQz?=
 =?utf-8?B?VmJKcmRQbkVoWHBVM0lTazhPVitrQWVNN3ZQN0s3U3ZuTkE3VHNmU3d6V2JE?=
 =?utf-8?B?TjRWbEpGWGdtVTlLUys3SWtKY3hnSW5tV3MrdWRwQ2pDUG1nSmp0Y1NkNzJO?=
 =?utf-8?B?aFhVN0xPMThaSFI5Ung5R2VVNldMekllZ2l5SFk1SjYrSFYyUFpJdXpUYWdH?=
 =?utf-8?B?dVRza1J4MWFUZFh1aGFaTWV5NFQvaDRYMFdlUFFHL3NJUmN6ZkcvOHZWMnFH?=
 =?utf-8?B?UGVEMnd3cXBEVWtaTld2bXcrWmxLTldZVnY5emQrZW5uTlJNVWNTT0FxN2w4?=
 =?utf-8?B?cnFnK0RUNWYxQjUyeHh0cFFBRS9FTDVRaUsveTBnVVo5VTlQb0d6cU1tR3NJ?=
 =?utf-8?B?dkErbkYwcmJHZFVqTk1BbVhQMlVMbG5qdEsrV3pQT2pwc0FyWmVmeFhYWGtR?=
 =?utf-8?B?MWNvN291VUlWUEVlMFoyNjJjTy9iR1hndG5LKzBsRkxwTTNaNHd4NTZWOVlU?=
 =?utf-8?B?MExsS0RMbXIzc2V0YjVwcTRjT2tOOTVVa3ZsTTdEc0VKQjQ3Q1pjUGJlUndR?=
 =?utf-8?B?blpNQ0I1dTA1ekRCcDR2dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N08wVnVOdFpUWUZEdFFSVzNXZG1zWUZ5NERPRW5uaU9ZUzNpcU13VC9ySGlr?=
 =?utf-8?B?MU9KeU5DNFg1UmJlbGJIaG1RQ3hmeXBiQTlQdDZHWkUxbTFnTWlzUkZrQ1ZI?=
 =?utf-8?B?QnQ3NjdnVmEwV0txQ1B5c0dzNjNqU1hiV3R5WUpLS0U0R3lLSXk0THZ6YXdT?=
 =?utf-8?B?Zm1TV0xtbWlLRWVMUXVBU2pwc3BvSUdKa0FCN1NZR1FlQ1ExNlNVWmRza2g4?=
 =?utf-8?B?elc4RTJ2YlJrNmhaaUJzUzMxdnBsVXJ4ak5aZm1ZRTFKWXpGaHpucU1zUE8v?=
 =?utf-8?B?V2p1ZHl0Sm51MDA0YWhNY1F1dGRsaDU3c3M1V2ZmNXlqK2FwWTVlYmR6WWha?=
 =?utf-8?B?SUZHMlpmSmE0RWhtdCtjU1BoR0lGQ1JUU25PcnBBUnhmWXJPVFpWYWdsZVBh?=
 =?utf-8?B?ZnpCRDVDYksrelI4ek5ubVNwVGIxYlh0Z0dXUjRyalRzeWI2VTVYcVg1L3Bw?=
 =?utf-8?B?cGFKTUdjbWtVbEJFK0JZbElLdHVNWEMvNDdxdkdTTGVWZHY5MEI0Y2VRVEIv?=
 =?utf-8?B?Y1ZSMWV5V25Qdlc5Q05Cdy9QcVBiazZFVTA2d0V4UDlvekdMQWdmbTYxQXRx?=
 =?utf-8?B?SG82Y2ZtK2VBOEFDWFlBSXJiaXBJYkgzencwZmQ1aFRoVncvblBRblMwWnNB?=
 =?utf-8?B?cm9VbVlwbVloVHY4TVpYdGZVUC9sMUZ0bk9UbUZqZXV2bFAxN3pkTUNPZDVP?=
 =?utf-8?B?TWp2UTVHQUQ2MElkZkJPMm51Wnl6M2VJK0ZmTlVuakV1MmVleWp3NXNvRWZq?=
 =?utf-8?B?L0xhR1IwajJqbEtqWms0NDBjQnd4eDUrNUdCaGJhUzZTS252MVlCS2x0TjVZ?=
 =?utf-8?B?cGVhZXlnSE91dzZoLzNFdGc4Wm1EaVdaMEJXV0gvejg0amNIU1RjL0c2Nmdm?=
 =?utf-8?B?RnJqRzZNV0Q5aDRFbG5EMk1lWmJ6VEtnYmVQSktQNUlEMGF2K05Yc1d5eWNR?=
 =?utf-8?B?WnNtN2ZtK3lRRFFyTnBiVmk0cjVwV2dNWk5BSGtST2ttcTlLSG00Y1A2QWxQ?=
 =?utf-8?B?NmthNFBiNGZGOG5jMWxQOWhCM2wvcVllS3BPdWk4cDdkWis4TTB2UFd0L2tx?=
 =?utf-8?B?RXZCNzFoMS8zQ0h1T3cwNTVKYWNPdEVpdHVORFo5RjdYRVJVK3F6eTJLcW9h?=
 =?utf-8?B?NlgwS2w1T0oxak5HM1JNdlBHS1BtZGdlZ3RBN2ZKWXpPZEdGNHVCR0l5Q3FQ?=
 =?utf-8?B?NHpIYmFWMzJMM0VoeGg0K2hWczlIeXRmN2Q2SGx4ejB4SXc0Y3NrZU5jd29F?=
 =?utf-8?B?Q3ZoWWRpWkFXK216SDVVc1dMQ0ErQ1RoSmtXRGFHTkQwY3RjZjd6SUlUSG1n?=
 =?utf-8?B?aU01WUU3Wml4eXJhbVF2UmFnRlJ2ZFArSWtUSWJ3N2pqMnpSdWIvQU4xQlo4?=
 =?utf-8?B?SDZHTTJjSm5NWStJMjdwYVNKalBsT1dwZEVFSGZBUXhWNXU5alJPV1cyM21l?=
 =?utf-8?B?VS9WOG1ZYXdRbXVUd1NDREJPLzRDVnBpZlFSd2lOTHBKM0p6NHBvUjBndG1U?=
 =?utf-8?B?bkM0RStLNW9XZWo0Y3VjcHZybGIxYkZxUWNDNkNzZ1JMa2VBcHdsckJYV1dm?=
 =?utf-8?B?MWFlYm1TRFQrUHVLR0JHVGJ1b0FleTdML08wSElROUpSVVZUN1BkanplTkF3?=
 =?utf-8?B?Q3NGU2g4UmRjNlEvamNqc2FjZWNnbThVR0dHcmRNWk9vbHpRQXorNkJpeStI?=
 =?utf-8?B?a0hnZ0dSSTEvNEdlb0NxZlo5ZFcvWnZpbDdoZG45U1c4V2g3enhlWUtEUXpw?=
 =?utf-8?B?Wmt4OERYTEFCSHlkN1g0eC9jZC9pM3IrdUxWU1I4bk91TWszVEFTZEhmanBl?=
 =?utf-8?B?RzZ0cjBXTmdIcmxBT2plc3VXOWVDNjhtYVozNzBDRnpxY1h6WTJ6Tllld1Yv?=
 =?utf-8?B?TUVmZVdQKzVzN0kxVEJnbmJqUzFlZ2FqVHI2cUZYZXd4VDdEQWY4ODJqd1dw?=
 =?utf-8?B?ck9Bc0thN2dQdmRCdDdRcUt4cEFxTmpzdFdzUGhzWnMrZ1VyOE9uZ01PYjE3?=
 =?utf-8?B?anBhRTlFS1RMbWJVcmZpSWZXRGJEdVBqNTVnMnVhMHlpNG9SdjdwWlNBMERO?=
 =?utf-8?B?ODN3SStNeERqb1pwNDU3MjViaGdwNzFlODZ1WHZhSjRtUFNOMkZ0WmZFOXBs?=
 =?utf-8?Q?uNkaMYUT7xTgyFSwKCgirYpuE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c471375b-3255-4dd1-fc96-08dccdca33f3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:45:52.4823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6D+MtPdJcJ0xvkQUtwORSVltTI5+UNi8FAHqDIo5aEq3rMhviBBBp4wexEfT8PEiMg/aGejrZ9IaaFwiNhqbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8846
Received-SPF: softfail client-ip=2a01:111:f403:2415::611;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 05/09/2024 19:23, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Sep 05, 2024 at 07:07:28PM +0300, Avihai Horon wrote:
>>> So I wonder why stop-size can change from a driver, and whether that can be
>>> reported in a more predictable fashion.  Otherwise I see little point in
>>> providing both stop-size and precopy-size, otherwise we'll always add them
>>> up into VFIO's total pending-size.  The line on provision which data falls
>>> into which bucket doesn't seem to be clear to me.
>> Stopcopy-size is reported by VFIO_DEVICE_FEATURE_MIG_DATA_SIZE ioctl, which
>> states that this is "[...] the estimated data length that will be required
>> to complete stop copy".
>> So by this definition, stopcopy-size can change during precopy (it can also
>> change if device resources are created or destroyed).
>>
>> Precopy-size is reported by VFIO_MIG_GET_PRECOPY_INFO ioctl, which states
>> that this is "[...] estimates of data available from the device during the
>> PRE_COPY states".
>>
>> Maybe the confusion was caused by this line in vfio_state_pending_exact():
>>      *must_precopy += migration->precopy_init_size +
>> migration->precopy_dirty_size;
>>
>> Which I think should be removed, as stopcopy-size should already cover
>> precopy data.
> Would you please help double check on the kernel drivers' side?  If that's
> true I agree that should be dropped.

Sure.

>
> Does it also mean then that the currently reported stop-size - precopy-size
> will be very close to the constant non-iterable data size?

It's not constant, while the VM is running it can change.

Thanks.

>    If so, is it
> cache-able?  It doesn't need to be 100% accurate as the ioctls are not
> atomic, but still if it's mostly usable (again, will need you all to help
> justify that..) as that then it looks like we have some way to report that
> without the concern you raised before.
>
> Thanks,
>
> --
> Peter Xu
>

