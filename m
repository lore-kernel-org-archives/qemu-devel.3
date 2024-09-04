Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400BACD4857
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 15:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slsDI-0001KN-Hx; Wed, 04 Sep 2024 11:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1slsDD-0000zI-8G
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 11:46:27 -0400
Received: from mail-co1nam11on2076.outbound.protection.outlook.com
 ([40.107.220.76] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1slsDB-0001ze-1r
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 11:46:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xj8rG10Ci26rdP39olvjYe9rFqB8+4eORRt9Lrl7c+SyupB2lBnUSdVtvV+bEhM5K9FyXDBiEn5Susog7PGZvv+9/KBXBuCTSU9c9gmCMxYNWTzSxfCI691SKSN965i5vsepvbEdSmn76s/l5dQ87Uzt878MSXRw4cmskHLUzwPQ+qXu86vy4Bo+TSJjk2rKxHrhtBOj7wY5NbmEgsV235K2yTDb+2GsQDY2Lxuel1DdQY+dRrJDN0o9BC1gnqSKjk8m718LW+FpmYKiHWOC5eCXRyD27pw73yPJ+j9H1YknnduAWZteMq65kLFMOuSVKUzu4hD6qfwv9evE0Db5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soeQe5c2guEdMo3IUUrfSbpl+usLyo1cQ+nKJ9/X8Bk=;
 b=dHXQ5HPMRRuokFSEDfe3TtEZQG0v2yvCiV7X+zoa0A63fCLSf8AXkDIl+pjqAcHPnpgYv6Rr6WP7iP5Csg5jhfBtoFiAKQsR0ON6EuIbfJAS2SvDfLOVVggt+R9aKRSxFPSfPjNCMLGJMFk3LnbW/aUAA+DSiEDq1SjpMGaNB+BUgE65/7Q7ARgDAkN0nlOJMEVda4zMBUHsIW9TbNtg84VfRmyqLUFMa2tcULG2JTbJMauodPUD2kaSU6rtxkwfyq928ZB2bnHf3UMS9vN6nbrmJAWFpjXLjyoDIxhLRaWxOMC0RzJQRmeJ3clljB9n0vj9vNNifzWpCzbCsp9fyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soeQe5c2guEdMo3IUUrfSbpl+usLyo1cQ+nKJ9/X8Bk=;
 b=M0221bw6qxa7rQjdDcFhHwYW2N9HbgRZxnaE9GT9fZF4sWw82fBOyG41Y0aoBOanaDUHq1bdL8aJKOfotcM/AriDH5VqhCJOJ+TGB+u2rGQA14cCPjZaVXAI/sCnCAiOOg2yzkPeVUNHYP++tk9FI4yIb7D2XUJd6AhSQEtFHI7xsIqUS5ecIgjDrQHK0XjqJ4xTu8aGClQpe6w6u6Nzm37FMEjbUKeKRNWrYRwonGtD2rv2v5g23WNSvisQxOu7wa7brmUs+DfehiUH8acmBZ44irPsl8D6439TEvjMXcdnFmNUr6sSyUTw+snv8J1uY0vJOq6V5Nl/KBI9AlIvpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 15:41:12 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 15:41:12 +0000
Message-ID: <95d10ed3-33ef-48a9-9684-3a8c402c5db9@nvidia.com>
Date: Wed, 4 Sep 2024 18:41:03 +0300
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
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZthZ1aW_JmO3V9dr@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::13) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e2e0e5-2610-443a-2108-08dcccf800d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjRqblRTVjZiK25WYUt1czlEdTdYVVdSN1puMHJlVW1USnk5S1hNOFdYc05W?=
 =?utf-8?B?eTVVVHhvcXFFcHRrSEUyOXZMRHlPOVFmZDZ2aHJ5YWRGbDBSV3g0aXZPT0li?=
 =?utf-8?B?UUNTQXlQOWJDdkQ1YUltVmZMa0o1dGFyWlI1ZDRURnVLbnN0emFyVWg4US9o?=
 =?utf-8?B?ZnpPRkJJV2owMWRyaDBKTTFLK2tqWTlzVUJZMzhaY3FSNmRDRDBEZmlEZmpo?=
 =?utf-8?B?K2thVXdIeWN1d1dSbS9OcXFGTmVaYk1BaFk5N2doVTVPS1dVYTU3VlZFVFRw?=
 =?utf-8?B?LzR5eFJHUUM3aGhmY0lhSUpPbkNheWhpV3lVY1hQNEYyZDNWN20zTHkwbFN5?=
 =?utf-8?B?ZVRXek4vR1FlY1BYd2d0blowUmduYUNFVjZqemErWmkxWC82SHFuZzBmWXVU?=
 =?utf-8?B?M3Mxc1pENHNmdGFQekR6OHhnUlUweHZMTWtPdEsxV1AxREFXaE5wdlFYc3k0?=
 =?utf-8?B?bnJnWmJ6b2QxdlV1N0lKcnNJdVJaKzE2Vmw1YTQvVW9QRlIrZXpKZy82N3Z1?=
 =?utf-8?B?SU1DK0VMWi9qcFI4eWJCeDVnRjlwbmcrV1phVk90UzZOTnprSzREWitkaE9I?=
 =?utf-8?B?ZmwwRmt3cFVRdWxRL2VYdjhRZm1LTG5iTDZuODdGSVI0VVhFN21DZzN1VVZ4?=
 =?utf-8?B?M0U1YTlTOUx6eklYTU1XT0VieTBUTEhVNVBtaWx2M3VvVzRoT3BmekFtekIz?=
 =?utf-8?B?YVpDWXhnTEdncXk2cTJGVVZ4Zjh5WDdNWjZQU2JHRzJiLzNxYlVKM1RUanN2?=
 =?utf-8?B?R3JxYUNvTk9BMXRFalJoSTI2OVUwQm5PNFVNSXd0Vm5WcHV0Zm5PUlQzTkx6?=
 =?utf-8?B?ZzJzSkdldUdEVEJEN1oxL1poUHpBdW9CTC9VdmZHRWk3SXVPUURFNjQ5ZVJ1?=
 =?utf-8?B?Z2hyVVlYUzBLbVNRa1hBZTRMTXRWa3JTREtWVlRYNlQ4N2pJcVhGbWVQY3My?=
 =?utf-8?B?a3BERGpYL1kyT3pROGpuRlV5YXBXQkJ5RFB6MjNoQmREWXpRYUJkRVYreTgw?=
 =?utf-8?B?Z0hkZ054bWI5TXZtWFV1WnpjUWQzdXN4S0pBSmRXVkNYZDZMaDdZOEhxTnFS?=
 =?utf-8?B?SW9zMUx3UG44Vmt5ZjFQVXpwQktKTVYwcU5rWmdFS0UwQmcrbXdka1BpbGYx?=
 =?utf-8?B?RXlVSFUraHkwZHM4QnduaHUrRVQ0OUJWakI0cmMydURlK3RJdUJleTJVcTB5?=
 =?utf-8?B?ckoxYlB6eU5LbGo2N1Q2QUh4L3M1OEIydWFmckpHdkt0NUF3ZC9NZU43c3VF?=
 =?utf-8?B?aUFTdDU3RVJ1VVljMjdGN3lOQmh1dlJ6ZkluQVFBSkwyUWZpRmFaNVI3ckp2?=
 =?utf-8?B?ZEtJSGxXQ29tdUk5NGlaem0ranRNWldxeXc1Zk5UV25mdElES3JlMnlFbXNS?=
 =?utf-8?B?bDcxemdqNFVUWDhmd3V4YXFaY0hwQVZwcXpPRlVvVFdmY2Qzb2xsZnhyNUty?=
 =?utf-8?B?R09RNW95VXhxeVE3RWtzVCtyYWR4cldxVG5OT2s4bjVlS0NvcjZiRCsxMVVB?=
 =?utf-8?B?U3JGNmExMEx3emlBUGhSZTV6RUw0NXEwTWxBT1JHYitoa2JNUlBSY2lzOUlF?=
 =?utf-8?B?RE9SRnAyVGJubVdGRXdJeUVCbWlwUjNpNUlqeVI4elNITW1uQm9BaFA4NVNs?=
 =?utf-8?B?WlkrREVBSmtNNnFxbG9JOE9WNUlCeVRpS21FRmYrMDA4MXpWVWg5aWFIYTV5?=
 =?utf-8?B?MmwxeDB5Sk5PZ1hieVJsU1pjYi9CWmsyVkIyVUlGdll2SFF0OGxTek15UGpJ?=
 =?utf-8?B?L0NLOGV5OVVadDU1NU9uRk5WdW1PRnJabWFiM3FDc3VHbXkxNnk4M1ZEYmo0?=
 =?utf-8?B?UFc3RW1pNktRekhwVkFkZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1hNU1dwZ2hlNkZ5Yjc0dHlhNC81QjY1WXVCZ0M1T2VwNTNyR1h2WUNNS3Zy?=
 =?utf-8?B?UGZwbUJlWlR5dDl3dWNPcHdGbGJlZUVwYkRIZkswYlRoVmMwNGdNcW1Wa2ZC?=
 =?utf-8?B?WG9DaHZoZ3lGclJITFh4L1p6OWVheUNjOWtuS1lmczRlTkFGN2FWQ0FlWHNk?=
 =?utf-8?B?WjlXU1JWU2xvQjlCMTY3c1M3dW5OcG9ZeWYwUTYxRGtrcFZ4STdxNWgrT2p4?=
 =?utf-8?B?dzNyeFdaZzlaZFdoN0pncXdORWd3M0V5SzFyZTNVd1E4MFRMMnZwbHV6dGQr?=
 =?utf-8?B?UUR6MmVRUWVpK1NoSUYvRWNmZmMwcUlLVnNRcmViT0cvZy9BYWlRTzJ0ZHRB?=
 =?utf-8?B?eFhrT3h0UWVRMmsydCsrTE5mcTN5MllnbzV3WlVNSmNVREsvRzBhRU9uV1hM?=
 =?utf-8?B?VE56cDRZbnp5R3JDUmZVNlVqZ2ppTE5tVUhZeUxJbUtGNVl0dkVFb0IyU29x?=
 =?utf-8?B?a0xlbFJoZG9GVFB4K1VUc0I3dlQxdjhNNWRHOG9MbWhmZXNieUh2TnpnT01R?=
 =?utf-8?B?ZEhaRkhua2hKRHFPL094M0FIU2NiRjQ2RENyRTFKcTNPN1RUTUpwM1dMWDRZ?=
 =?utf-8?B?R3kyeDFoQ3p1MXYxZUdxWXFuTWk1NS9IeTk2Q2w1ckJjMklDektPUmpSWFQy?=
 =?utf-8?B?Y2NKcmRMV0FqWTFBRnVzZXVtRlNLdTFRUHU2NDFNV0dFbDRyYUg2YWEyY3Jj?=
 =?utf-8?B?VXZDL0hUNVhUTTlKYjdSOUMwQXk0Z3pYWmlVYVBFa3Y5blJGUUF1YW5vdmhH?=
 =?utf-8?B?VEpSL21oNmMzRU1DRlpacHJPd3FIK2lOZnIzTEU0NDcvdGhkR01Da0pxRW5N?=
 =?utf-8?B?RHgwRW5kSHJOUlhTb1VNOVBYZ3gvNVlBV1htQUtZT05raXl2cG5iNnhNRVFM?=
 =?utf-8?B?bDhmV3Vwc0luWU1ZdGZSL3IrcXR3THc5a1ZJTmZhYXJYZ3EvaVdEVm9yQWor?=
 =?utf-8?B?ejNRZlZCVXBqaGtSK20wdk1SNGJ4L3lRRmcwM20xazlIaTQwT0xZWmlGOEdj?=
 =?utf-8?B?eit6UGRNNm4wWFFseEdmNVlRUUJzRlN6ZlYyN1UvcDBtMWcwY0JCb3NoM0VH?=
 =?utf-8?B?MHVmSGRxT3JnenlxcXFmNWUzeTgyeEZ3bXVMcmo0R1daWUpvUk5mN1ZhK2JZ?=
 =?utf-8?B?cTBGNEcyUUpsTGNrYlFrcDI2Vm9UeGhQWGhrSW1uNlo1a1JTaGtCMHM0L2F3?=
 =?utf-8?B?R3ZoWEZ3ODVqQS9uRWtLajZxckpTZkRFWTBBcjFoUVdnWjNVb0h5KzZEZGtw?=
 =?utf-8?B?T29wWmVPclNWQjlZeFM2K3VNYUFhVVoxN3FqNU4rNm53dE4wM1grYnJIZVJq?=
 =?utf-8?B?S3dzWTkza1dqZ2M1VDE4RUxXdllZQzhaVm5Hb3lSNXZ5L0F1b1BwbloxVHB1?=
 =?utf-8?B?TEY2a2gwOUVYUHRwTUVUQURGdktJa2dqc0tLU2RvWXlwNUxHNUxMZlRoOUpN?=
 =?utf-8?B?dVowQ1oxZlNXMEFOMHFwOWdjQThaRHN6UXBqMlNNVk1idS9iNmg1K2JtbGtZ?=
 =?utf-8?B?NE42aHY2UzlLSHJiWi82UzlYaTdvbmlNWkd2dklWWW5FNVRWUmhJTmppQTZ4?=
 =?utf-8?B?b1FPUGpYc3N4ZHhEUjVuUm9DUWY1S21La1NCVnY3Z2M3NFQ0TUFhcjU2azIv?=
 =?utf-8?B?Y2d3WnduZ0Z6a2FuaThRZFJlYlgzWlhFTEFYeTN3TWxHMnlBNEtydjVmTDg5?=
 =?utf-8?B?TXQrbEdsWUlJdS9qS3poYUY0VGRsVVFrZXhaeFlYMDg3dElFVEM1NUJrU0tJ?=
 =?utf-8?B?eWViU2dONFBRUFk3RktmM25XSUhDU2t6ck5SVDZrT1I4Z05CR08xbjF2Z3lX?=
 =?utf-8?B?bkMzblBldDlCc0hrUkNvTkkzMjdJUjZYNFJwOUJjUnc0U25EV0RyZEZxOWtm?=
 =?utf-8?B?Q3Zxamlka0d5Unk1ZHh3V25OSnYvMnV5SDRFS09Yd2M2YVIzZ0srM3lxNXZC?=
 =?utf-8?B?dFlRUUoxcThHOTM4cFYvNExjcXI5Ni9TdENvdkk2TTJFOVdyV21sbWxUdGNX?=
 =?utf-8?B?MHR5YmpzeDBkdW0wQ0M1Y2xncktIenJyUVdUb0xFWkthb0xsaTlxQUZaelBk?=
 =?utf-8?B?TjlXWlA3ajM4aHFqaldidWIvbXlnUXVMWW02ZWRUT2VLcFB5N1FFMWdaL1RS?=
 =?utf-8?Q?AnJodLMfCmutHy9WILGOL6Ja5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e2e0e5-2610-443a-2108-08dcccf800d3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:41:12.0070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V33tv1Hbwe6jxplRMFbB/pNOYR+8QkhKzMj85KjpOxfUPzmbGQsj9OcFD8FrHonqaL7LxVZcpmF4zRlHhPEaeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806
Received-SPF: softfail client-ip=40.107.220.76;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 04/09/2024 16:00, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> Hello, Avihai,
>
> Reviving this thread just to discuss one issue below..
>
> On Thu, Feb 16, 2023 at 04:36:27PM +0200, Avihai Horon wrote:
>> +/*
>> + * Migration size of VFIO devices can be as little as a few KBs or as big as
>> + * many GBs. This value should be big enough to cover the worst case.
>> + */
>> +#define VFIO_MIG_STOP_COPY_SIZE (100 * GiB)
>> +
>> +/*
>> + * Only exact function is implemented and not estimate function. The reason is
>> + * that during pre-copy phase of migration the estimate function is called
>> + * repeatedly while pending RAM size is over the threshold, thus migration
>> + * can't converge and querying the VFIO device pending data size is useless.
>> + */
>> +static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
>> +                                     uint64_t *can_postcopy)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    uint64_t stop_copy_size = VFIO_MIG_STOP_COPY_SIZE;
>> +
>> +    /*
>> +     * If getting pending migration size fails, VFIO_MIG_STOP_COPY_SIZE is
>> +     * reported so downtime limit won't be violated.
>> +     */
>> +    vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
>> +    *must_precopy += stop_copy_size;
> Is this the chunk of data only can be copied during VM stopped?  If so, I
> wonder why it's reported as "must precopy" if we know precopy won't ever
> move them..

A VFIO device that doesn't support precopy will send this data only when 
VM is stopped.
A VFIO device that supports precopy may or may not send this data (or 
part of it) during precopy, and it depends on the specific VFIO device.

According to state_pending_{estimate,exact} documentation, must_precopy 
is the amount of data that must be migrated before target starts, and 
indeed this VFIO data must be migrated before target starts.

>
> The issue is if with such reporting (and now in latest master branch we do
> have the precopy size too, which was reported both in exact() and
> estimate()), we can observe weird reports like this:
>
> 23411@1725380798968696657 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
> 23411@1725380799050766000 migrate_pending_exact exact pending size 21038628864 (pre = 21038628864 post=0)
> 23411@1725380799050896975 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
> 23411@1725380799138657103 migrate_pending_exact exact pending size 21040144384 (pre = 21040144384 post=0)
> 23411@1725380799140166709 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
> 23411@1725380799217246861 migrate_pending_exact exact pending size 21038628864 (pre = 21038628864 post=0)
> 23411@1725380799217384969 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
> 23411@1725380799305147722 migrate_pending_exact exact pending size 21039976448 (pre = 21039976448 post=0)
> 23411@1725380799306639956 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
> 23411@1725380799385118245 migrate_pending_exact exact pending size 21038796800 (pre = 21038796800 post=0)
> 23411@1725380799385709382 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
>
> So estimate() keeps reporting zero but the exact() reports much larger, and
> it keeps spinning like this.  I think that's not how it was designed to be
> used..

It keeps spinning and migration doesn't converge?
If so, configuring a higher downtime limit or the 
avail-switchover-bandwidth parameter may solve it.

>
> Does this stop copy size change for a VFIO device or not?

It depends on the specific VFIO device.
If the device supports precopy and all (or part) of its data is 
precopy-able, then stopcopy size will change.
Besides that, the amount of resources currently used by the VFIO device 
can also affect the stopcopy size, and it may increase or decrease as 
resources are created or destroyed.

> IIUC, we may want some other mechanism to report stop copy size for a
> device, rather than reporting it with the current exact()/estimate() api.
> That's, per my undertanding, only used for iterable data, while
> stop-copy-size may not fall into that category if so.

The above situation is caused by the fact that VFIO data may not be 
fully precopy-able (as opposed to RAM data).
I don't think reporting the stop-copy-size in a different API will help 
the above situation -- we would still have to take stop-copy-size into 
account before converging, to not violate downtime.

Thanks.

>
>> +
>> +    trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, *can_postcopy,
>> +                                   stop_copy_size);
>> +}
> --
> Peter Xu
>

