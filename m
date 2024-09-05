Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7542CCD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 11:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smArg-00029S-Nv; Thu, 05 Sep 2024 07:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1smAre-00028p-Q1
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:41:26 -0400
Received: from mail-sn1nam02on20615.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::615]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1smArc-0008MN-A6
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:41:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ju+e0C6ibhSw4S3Kf37+tT813MD5xEpfiyVkhABp0XD9wj8aVTyvn8YQO9PBXuGqhdqakAYUQDM29jtWw65YWkVoo1iyzacSqKxiycfHBswA6mb8O0G2uQdi3WtVlA/Ml8hPnPBnW7f6JV+Z3cZvBJX8TipGSJGXsihPzhOMAT2Sz8EbHDEPsYNkdLHEVaGuBDmV1bmGR7iYfxJo1yBzN8oTU5dhMlOgLkSn4ABKahClXMJ3sbWl112k8HqjSkAszjHmIRuPTdmHRrzg8lQmEdr3h5Soi7HLNQ0nsSbsJTt2GT8xwkmufS2UOlOlj8Clh5pHJu4lSDcN8BKcZCWGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVyvSkuI6m2BapqvWQ9NE4nh/z8zo6UtOCQYKKCoidY=;
 b=MAofJVfKtdxkghJjHhOIefX74oBpuB1+qcF9Fn0fRMLR/Yrnqxu0s63BDvjuzdL4UCarGk5rO+L3SUOv6fbeXRSEDF33ze/qHrQxKFOQZfwBtKOyGLBL35yNeYKUNHUpLJ2O0BPuBktmT4VbDz9lBQ3y1Xat7cxoH0x+6ZWQhQgBY4uyuqf85daNSnqi4+SQp1GifpJ4k+NyfFS6TGmxkUkayRCEPKMHp2g78+oCylitwSjYn7ToUDtyQESEgMhoDNe7fmUH++GVznLR7GbZcNBiKiUR2Xch2KkUtb0hj6dzMHh0M8idKFYjnvOWBSc859sXTB+Y6BvT2ovaAqoNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVyvSkuI6m2BapqvWQ9NE4nh/z8zo6UtOCQYKKCoidY=;
 b=tulokZL6Au6kqoifEz4pB9pHtRZMV6xE1N96Wq5U4c+yOV4PuWFrRfvUv0Q+WuYeLBTQHhDb+Qg2dUWKlDb7uQDbDetvXgeFPo5LySobxjJsPZLzzifwWXmYzUMvVgeaOaCLUB7YtFp370KhF145myJMIblxfj+9hh1vHvZ4mz7kidR/v2AhEURFCh+UXeo/5SMVrSoJCwSbxlNHVyHAPx0XmAox76bcgaFnFduHQPbeCH4+fcoDIf4/QKq6UuW5NC3yeQxQQTvWLTUQYFIi2Tx1pW8rDaBpLfpY6rWxV2MvOvWrqyd78reNuzRLgNSzZ7Ga1dagxOWSFWEgL+yXWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 11:41:18 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 11:41:18 +0000
Message-ID: <b8807171-567b-4e21-af83-bc2f6dbbf606@nvidia.com>
Date: Thu, 5 Sep 2024 14:41:09 +0300
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
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZtiHzQHJ4PgWc21e@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::6) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DS7PR12MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: af3e83f8-264a-4107-e7f4-08dccd9fa7e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnpmSEhURDNBU0RHcGxzT3hpVVk3MFhoRGZKeDNhMCtuRFhKRkJZR2YyQm9k?=
 =?utf-8?B?OXRzOHE5Y1VLWElzdGh5Nys2VmVxZG5GTmkvM1MvYWdiemUyTVFJWEt6MEsx?=
 =?utf-8?B?TkxWeWZoWjRaeXI4L3NLTjdQclVHdWxGY05sZjVjMkk2alF3QVBNQUVOWjdr?=
 =?utf-8?B?UHAvcXYra3UzbXBpRE1ZZWJIZS9PR09kMHE4S0taU2h2VHFQNEwwcHFTbi8r?=
 =?utf-8?B?Ni9UOUozYTRzeng4YThON2t1TUlGNTVnZFdOYXN3N3p6MEdXTmV4UkU2RFIy?=
 =?utf-8?B?RmRJWnlDOEdUc1hNckNQSmw2WUJadGx4cm95ZG9uRTE1WTZPR1hVd1BraHg0?=
 =?utf-8?B?ZmEwM1hwSmxUclRTWjY2ZUdleWZIUDZMWElUOHZxV0ZuSHZOVkk4cFVLQVRL?=
 =?utf-8?B?Z0RpNDFsL1ZKYzd6aWhzalJzbDRQbmpRNzhxbHpJOStzK1RtVzBZU21PK3hU?=
 =?utf-8?B?TmRRdUxDMXVFTGFKWkdDa0VGeDcvZXFvbmdJcXQ2Q2wrYmJiV2pwN3phSVk4?=
 =?utf-8?B?cElzRjhmQk5XQW54NTJBeTNVQ243N0RWZW9YVmRkTG1BREJoY1hOd0ZPcTE3?=
 =?utf-8?B?RmYxQ3BBYzNWL3d5elRFZ0lWcW5XN1ppYXFXWXhiQVl1T3REZTlKLzlhMGFJ?=
 =?utf-8?B?REFRYlNCNWlpSFV2ZEpYbVhtMXhkQytJYlNoazdDZ2JDNEk0Q0ZYNG1SM0dR?=
 =?utf-8?B?dk53VTEzMjVHSXhDdW1BK0xpd1BBUExlRjd5UEt6Q3lnQXBmQ3lwdkVzTWhi?=
 =?utf-8?B?djZOc2VXNjFxcUFvT21yTE5qZ3BtQUxBbHp6QzNhMlZzSkVRLzNvbVlLQjd5?=
 =?utf-8?B?dTRWc2d5YkFTYyt6VWJUWkVIUXNXMFZoUUNsYm9vaFh6RHpZL1Z0U0RmMHlk?=
 =?utf-8?B?UWhaU0V0eXI2SXcramI1YkpIZnZnMmlZWlR2WVhYMmJSYnY5YlBPanNXVFl3?=
 =?utf-8?B?SnZ2ei85bkd6TjNhbjRFM0VFT2tsc2FFME41VlcyanZPRjQwMWRjZnhkU2ly?=
 =?utf-8?B?SUIwNkhIM1dDR2pzSEV2OEphU2RIa1BmWkc2UjN6NFZJWHc2ZDFWbEpWdzFh?=
 =?utf-8?B?ckdMckp3bG52SkJqZGVwTStrSUY1eGk1Rm1PNHcvWjJuUkw5bWsxczRkc3hh?=
 =?utf-8?B?Q2Vha2dFK3RYZGpmeFpJNjhLNzczdm1Kd3I3RUNrSDNuOUtzT2FIMzdUa0hl?=
 =?utf-8?B?dnNmQllVNzRGb1kzb2N5SHVRTGxuUTZxWFZIc09sRVZ0akxPM3pBZVpwT1c2?=
 =?utf-8?B?NEEydEJTZ1pxVit1VkJVbXNkQnlWUEVXZHl6ekNsNUt0c0E3R3dmVk5GWGxD?=
 =?utf-8?B?ZjdNZkNWQ0ZPYTN3RTRsalFYS1puR3F6WVVuOXVlSm9DTzJ4QndKdUdmenZH?=
 =?utf-8?B?ZVhQTk0rOGNydDl4WmkrTGtvbjNWcmgrT1ltaHI3M2ZxcjdabDE0enhUKzNN?=
 =?utf-8?B?d3NYek82cDFReEFvSHVoVkpKR1hELzBtYkR0VHYvMXU4Qlg1aWlPOG85YnZI?=
 =?utf-8?B?YmdxS2hyYXFKTm1SMDIxL1AxRmp3Zy8va0h4UGRSMzJyQXN2ZzFVQkRkNmgr?=
 =?utf-8?B?dHRVd3owSkc0TjdDVU9iYjIwK2JPbzcxd1I2Nmt2d1pLZGljVHlVSXRJdDFB?=
 =?utf-8?B?MEluQWlWbSs2eUV6SlI0YjFraWpDb3JyVG1UZkI2bExoS3VGODE4YnlibExC?=
 =?utf-8?B?YzVZYnNHQ3ZWNkxHYStDWTJySmEwdFozc3Fqd1BBSlMyNktuM3FSQ25zVFN0?=
 =?utf-8?B?SnprWUJPdTk1YlhydklSTXJQQnlpT29JcDlDaklxRWZuRUlBTUl5UHRhR0pV?=
 =?utf-8?B?cEgzOGkva3ozK0pqSU9hQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUJBMkliVWhtMWxiUURDUjZYTS9JbXNBanBRQUIzY0FVUzQ2dHRtSktXRCtZ?=
 =?utf-8?B?YUh5OUVIdEVBaHpsYStmOEpTRDlMOGkrZ1M3ak5KTkZudnFobkt1VFdreEV2?=
 =?utf-8?B?MGpmdDdETmZlY29XQndGV3JqSU9FekdBOUFoSVNjVHNrUlF1cGdJMXhFQkox?=
 =?utf-8?B?K25STU0zeDRtWHdFZlhFOHZTSkFKK01FNHU1a2xQMFYrUGlTejMwTVcyM3Zn?=
 =?utf-8?B?ZW9zVEl2OXJNZ2FNNTA5blBxKzczeHRMTS9WQzBmZURSRDRxdElDZ3pha3E1?=
 =?utf-8?B?dnMzeEdCUkhsUUwxMFBIYWNuZUlmYkdZaXQ3S0RmVFJ4bDAyZW0vdmtPRVpr?=
 =?utf-8?B?aHZ2NGE2SnZSeURQWlQ1TFNpb3JJTUQwTDZ5UjUwaVZFanpwMFR1bSswOVBW?=
 =?utf-8?B?OHRIank5RHFNOGo0TWdXMVdTLy9Wd050NDhZeDZ4em1oSURuVjV6b1grYStK?=
 =?utf-8?B?ZGE5VFNkZy9kZFBoU2EvREpxd3cwVzlQQnEwQ0doWUNCUWd4ZnAwV3Excm5S?=
 =?utf-8?B?djVvTUhWSTV6THdBaDNsTDNRenUzT2xlU3Q1cldNcHBXWXowL2dYdk5zaVIx?=
 =?utf-8?B?MGNMY1hjQUJsWTlVTnNCRWNZbWFzazFTR0NXYkdicFNaUW14QjJLaU1Zb0Nv?=
 =?utf-8?B?MnY2enZyK3NvQTJObEhpTTd2bWlnaUJwMTIwK0R3UTlYZUdCUW9RVVFhM05l?=
 =?utf-8?B?d3FFeFlablVHM2ZkcEN5Z0dRaVd6dGNFeTRqY1I2RnI0K0ZIbjZNTGo1djc3?=
 =?utf-8?B?SGR3cGZXa3RIQUJ5U3U0UWVYNmsyNWRGTUdzOXBjV2UwWWFnb1g2d0hGY0hI?=
 =?utf-8?B?di9BYkpPQnFCMXJra0NhdEpybHdBN0swOTNGaVZWUTQwMVQ4VUNIY0ZiaHJt?=
 =?utf-8?B?by9Rc0YwM0h3VEYxUWZXMzFyanVORGt0RkNtQk9tMVM1VzRwc3FsY280WWVH?=
 =?utf-8?B?cmFBandMNGFJTXN3a0pSdVdCUGtZMmlBeWl3QllQMXlmUTFUZUthVGxjNm5Z?=
 =?utf-8?B?QlJ1dUJZaUp4bjg2K3FKTVRYYTIzQkRWeTAzdjBtTVpQWUFCa2o0NWZHbFNL?=
 =?utf-8?B?Vm9uNHR3Q1ZWMjBkUjdlWW13anRpMzVyTlIrYngwazJ6VUFURDZjWXk2aDBY?=
 =?utf-8?B?MThPZENYN005QkZjVytISzNvUHlSdVdHajM0NUFFV3RwQ1ArNWhIUGV5WHNx?=
 =?utf-8?B?LzdubVhsVnNLUnpyVCtXamNBb21aMkJTZjBWd3NhdkZ1M1d3M2h6Ky9hYmg5?=
 =?utf-8?B?S3Q4cERjMlRSTDBSYTdjL1NnYTBHU1BWbGJwZ2puUXZ2N29MZURHTFJ4YndK?=
 =?utf-8?B?ZjR6ZSt1YTVzczVwR1hVWGZsMkxvVGxYanZ3Q2xZQnczQUY3MzRWSUxkZEtX?=
 =?utf-8?B?d0xmMjBJV1RUSzNBSmpVVGpCMTREU1Y5aU8wak5CRTNHV3F1UllwcWpVcktW?=
 =?utf-8?B?YXVTRHBQQUwzK1E0eGIvRy8xa1JoV3lFRTJlZG9lTnd6c3FYbEVENnU3ZUtC?=
 =?utf-8?B?My9KSmYzakh5TXUrRks5NEJ1RFMyRms3cHk1UWU4NVVYY3pVSGRKV25ReCtr?=
 =?utf-8?B?NEJjRDNnVUtCZVFwcWcvUUUxajlWbmxXR2gweEZTY3hKVStyRldJN1gvVWkw?=
 =?utf-8?B?azRqbFJKbG5mNytHUDdYbTdUbkJJTjFKdmNOYWErMCtVcVo2ckdYNHBWRHFT?=
 =?utf-8?B?Zm1FbjJiNVJYTHg5a294NFNzb2h4UHdCdnhYVEZleGF1OFlxSXZBNHBEZkdK?=
 =?utf-8?B?MDRjQ2QxT2JZa1hOcm5paTJrMmIvNlRPRFB0UW16NEs2SjRuakdsQWVtZEEx?=
 =?utf-8?B?NVpRYUdIN3NDaWNLbWFDRHdMN280STVwQTZEa3NqbzZNQjU5c1dJRUJvZHNB?=
 =?utf-8?B?bXR3d2ZiRE9kZ055N05tSE9sNkk2Zk50OHdYZXQwT2o2ZDc0WW5RYlA3WXhp?=
 =?utf-8?B?cU1vblVBZHV5U2VDUEp0QUtXOXZlN0c3ajdGQjVuSHhmNjVMUjM1VGpyZ2ln?=
 =?utf-8?B?YlNBVmJ5cUQ1eURiYnRyRlZrdlJjVlh4MmlHRGQ5SFJ5WitCSVBKT2xOM2tQ?=
 =?utf-8?B?ejRvNXpoT0RPL0hSVWMvS1pHWkJhdjU0RzRNNWh2dXZuY1haZXBhMW82aVNa?=
 =?utf-8?Q?UzobPKQH55nHzwQrbU5SPoltG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3e83f8-264a-4107-e7f4-08dccd9fa7e7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 11:41:18.2709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBO1Tq/2DKeWEP5XT5BE3aHQ93QpwDZY4ivCyEKDnjWXDqzHg/VwOwxwUM/2FW1ex3bi7nlmB/1A04mROWo/sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::615;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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


On 04/09/2024 19:16, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Sep 04, 2024 at 06:41:03PM +0300, Avihai Horon wrote:
>> On 04/09/2024 16:00, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Hello, Avihai,
>>>
>>> Reviving this thread just to discuss one issue below..
>>>
>>> On Thu, Feb 16, 2023 at 04:36:27PM +0200, Avihai Horon wrote:
>>>> +/*
>>>> + * Migration size of VFIO devices can be as little as a few KBs or as big as
>>>> + * many GBs. This value should be big enough to cover the worst case.
>>>> + */
>>>> +#define VFIO_MIG_STOP_COPY_SIZE (100 * GiB)
>>>> +
>>>> +/*
>>>> + * Only exact function is implemented and not estimate function. The reason is
>>>> + * that during pre-copy phase of migration the estimate function is called
>>>> + * repeatedly while pending RAM size is over the threshold, thus migration
>>>> + * can't converge and querying the VFIO device pending data size is useless.
>>>> + */
>>>> +static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
>>>> +                                     uint64_t *can_postcopy)
>>>> +{
>>>> +    VFIODevice *vbasedev = opaque;
>>>> +    uint64_t stop_copy_size = VFIO_MIG_STOP_COPY_SIZE;
>>>> +
>>>> +    /*
>>>> +     * If getting pending migration size fails, VFIO_MIG_STOP_COPY_SIZE is
>>>> +     * reported so downtime limit won't be violated.
>>>> +     */
>>>> +    vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
>>>> +    *must_precopy += stop_copy_size;
>>> Is this the chunk of data only can be copied during VM stopped?  If so, I
>>> wonder why it's reported as "must precopy" if we know precopy won't ever
>>> move them..
>> A VFIO device that doesn't support precopy will send this data only when VM
>> is stopped.
>> A VFIO device that supports precopy may or may not send this data (or part
>> of it) during precopy, and it depends on the specific VFIO device.
>>
>> According to state_pending_{estimate,exact} documentation, must_precopy is
>> the amount of data that must be migrated before target starts, and indeed
>> this VFIO data must be migrated before target starts.
> Correct.  It's just that estimate/exact API will be more suitable when the
> exact() gets the report closer to estimate(), while the estimate() is only
> a fast-path of exact().  It'll cause some chaos like this if it doesn't do
> as so.
>
> Since we have discussion elsewhere on the fact that we currently ignore
> non-iterative device states during migration decides to switchover, I was
> wondering when reply on whether this stop-size could be the first thing
> that will start to provide such non-iterable pending data.  But that might
> indeed need more thoughts, at least we may want to collect more outliers of
> non-iterative device states outside VFIO that can cause downtime to be too
> large.

Ah, I see.

>
>>> The issue is if with such reporting (and now in latest master branch we do
>>> have the precopy size too, which was reported both in exact() and
>>> estimate()), we can observe weird reports like this:
>>>
>>> 23411@1725380798968696657 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
>>> 23411@1725380799050766000 migrate_pending_exact exact pending size 21038628864 (pre = 21038628864 post=0)
>>> 23411@1725380799050896975 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
>>> 23411@1725380799138657103 migrate_pending_exact exact pending size 21040144384 (pre = 21040144384 post=0)
>>> 23411@1725380799140166709 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
>>> 23411@1725380799217246861 migrate_pending_exact exact pending size 21038628864 (pre = 21038628864 post=0)
>>> 23411@1725380799217384969 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
>>> 23411@1725380799305147722 migrate_pending_exact exact pending size 21039976448 (pre = 21039976448 post=0)
>>> 23411@1725380799306639956 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
>>> 23411@1725380799385118245 migrate_pending_exact exact pending size 21038796800 (pre = 21038796800 post=0)
>>> 23411@1725380799385709382 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
>>>
>>> So estimate() keeps reporting zero but the exact() reports much larger, and
>>> it keeps spinning like this.  I think that's not how it was designed to be
>>> used..
>> It keeps spinning and migration doesn't converge?
>> If so, configuring a higher downtime limit or the avail-switchover-bandwidth
>> parameter may solve it.
> Yes, this is the only way to go, but it's a separate issue on reportings of
> estimate()/exact().  More below.
>
>>> Does this stop copy size change for a VFIO device or not?
>> It depends on the specific VFIO device.
>> If the device supports precopy and all (or part) of its data is
>> precopy-able, then stopcopy size will change.
>> Besides that, the amount of resources currently used by the VFIO device can
>> also affect the stopcopy size, and it may increase or decrease as resources
>> are created or destroyed.
> I see, thanks.
>
>>> IIUC, we may want some other mechanism to report stop copy size for a
>>> device, rather than reporting it with the current exact()/estimate() api.
>>> That's, per my undertanding, only used for iterable data, while
>>> stop-copy-size may not fall into that category if so.
>> The above situation is caused by the fact that VFIO data may not be fully
>> precopy-able (as opposed to RAM data).
>> I don't think reporting the stop-copy-size in a different API will help the
>> above situation -- we would still have to take stop-copy-size into account
>> before converging, to not violate downtime.
> It will help some other situation, though.
>
> One issue with above freqeunt estimate()/exact() call is that QEMU will go
> into madness loop thinking "we're close" and "we're far away from converge"
> even if the reality is "we're far away". The bad side effect is when this
> loop happens it'll not only affect VFIO but also other devices (e.g. KVM,
> vhost, etc.) so we'll do high overhead sync() in an extremely frequent
> manner.  IMHO they're totally a waste of resource, because all the rest of
> the modules are following the default rules of estimate()/exact().
>
> One simple but efficient fix for VFIO, IMHO, is at least VFIO should also
> cache the stop-size internally and report in estimate(), e.g.:
>
> /* Give an estimate of the amount left to be transferred,
>   * the result is split into the amount for units that can and
>   * for units that can't do postcopy.
>   */
> void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
>                                          uint64_t *can_postcopy)
> {
> }
>
> If it's justified that the stop-size to be reported in exact(), it should
> also be reported in estimate() per the comment above.  It should also fall
> into precopy category in this case.
>
> Then with that we should avoid calling exact() frequently for not only VFIO
> but also others (especially, KVM GET_DIRTY_LOG / CLEAR_DIRTY_LOG ioctls),
> then we know it won't converge anyway without the help of tuning downtime
> upper, or adjust avail-switchover-bandwidth.

Yes, it will solve this problem, but IIRC, the reason I didn't cache and 
return stop-copy-size in estimate from the first place was that it 
wasn't fully precopy-able, and that could cause some problems:
Once we cache and report this size in estimate, it may not decrease 
anymore -- we can't send it during precopy and we might not be able to 
call get stop-copy-size again from the exact path (because estimate 
might now reach below the threshold).

For example, assume the threshold for convergence is 1GB.
A VFIO device may report 2GB stop-copy-size (not precopy-able) in the 
beginning of the migration.
If the VFIO device stop-copy-size changes in the middle of migration 
(e.g., some of its resources are destroyed) and drops to 900MB, we will 
still see 2GB report in estimate.
Only when calling the exact handler again we will get the updated 900MB 
value and be able to converge. But that won't happen, because estimate 
size will always be above the 1GB threshold.

We could prevent these situations and call the get stop-copy-size once 
every X seconds, but it feels a bit awkward.

>
> This may improve situation but still leave one other issue, that IIUC even
> with above change and even if we can avoid sync dirty bitmap frequently,
> the migration thread can still spinning 100% calling estimate() and keep
> seeing data (which is not iterable...).  For the longer term we may still
> need to report non-iterable stop-size in another way so QEMU knows that
> iterate() over all the VMState registers won't help in this case, so it
> should go into sleep without eating the cores.  I hope that explains why I
> think a new API should be still needed for the long run.

Yes, I get your point.
But is the spinning case very common? AFAIU, if it happens, it may 
indicate some misconfiguration of the migration parameters.

Anyway, I think your idea may fit VFIO, but still need to think about 
all the small details.

Thanks.


