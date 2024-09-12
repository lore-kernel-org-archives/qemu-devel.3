Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D74EE645B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 08:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soetP-0000Nn-36; Thu, 12 Sep 2024 04:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1soetN-0000H0-FJ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:09:29 -0400
Received: from mail-dm6nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2415::600]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1soetL-0004WQ-8t
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:09:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPezeKKNyYjhLrBnEBn7GZnacg1FDr9zNYJhdZhSyEPbzA8jH8C3oCwQomZadRMTr74PC9FAzasNhnUdS5dHBCtXdiYX0iWOjcvFpBXOpy/+SRI3gp4QdNxTK/rZWyqkoN0Uxfo8ZhHTtWXlhqCpEkJEa0SSMdPj2jpidlTvFjzYZwL+Xt5675ahWADQaytgxLUuOxdOYcHc1vSV/YSK5UNIi8eL0TsbgFG1wxf5zQnG1pf3jaVZ49wh84jbdNkwDIwwVbS/3F6gtDne01+N63Sq/vYFe9RItkp+S7lFFjXJXoIBgBz9an+JPWovQOmgKewbneZS2C5nffRArEETwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQNVxN27Q20REEUgsp3+kiN1rx7z5eJwn22NQ/u1bLA=;
 b=przl7yf9K+i/N0SnSkhY6UzAtxK5jJ+5msS2PYkqb2EezgAmyesjejLpzDi+7CHNH2DdgN5r78AHPwWGQWAQ11eOQIMnlKM6Ez6laFR0MDfKzkFw4S1gkFx3meolQKfpASuj8R6CYfXhkWcWEOXkkEsk0F/1YpHlgT0I2sbOMeeQtx95OLp/MetJz/bhgkF6OulaO8+wVVRxl63fKES4k6KXF5F2RmHr90IYpdzdi/CkikWT1f0M2PQxNzsFn4JxMf7/VkwgtbtAG+jxOmgFn3xcJEO8sVGSim4qz0llN9Vj4PqLJtJ+KTLOHM/1Xm7lZGiFDcrITz1QCQjta0Lyaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQNVxN27Q20REEUgsp3+kiN1rx7z5eJwn22NQ/u1bLA=;
 b=FScL8JnRyqsdPvWkt5h+bmCpdmKD4Ctea1NhyeQtARV5jLPFfZsKdW23eZx3ZHUVdFqoVNcLpY9JUc1MVk+q5yWTMaUEJC2zuVQXpDZhUMWUuVWhM835e2p+R4iqzZJ7y3NlFF5CEs/9/yXGNCnQ9mpoVK/HdtHTzZ9vYAXePYDb0jCTtXO9JRrNmXj98YVLWTFT22jo14a7EHVFWS/RJ/qJMZSg5+WBPm+X+rnzCQ45QTIeEYqhCGg8pFeo9vfujYiPqXUISPseNJFvKa2hsKE/4iKrA3BpMMo0UcT1PqPoHWF2f9xTwyMa+tdl3ugq61FKiAVoM1OtCHR8OP1aYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DS0PR12MB9422.namprd12.prod.outlook.com (2603:10b6:8:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 12 Sep
 2024 08:09:21 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 08:09:20 +0000
Message-ID: <bc31b6c4-89c8-4e04-b74d-e84422eb9901@nvidia.com>
Date: Thu, 12 Sep 2024 11:09:12 +0300
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
References: <ZthZ1aW_JmO3V9dr@x1n>
 <95d10ed3-33ef-48a9-9684-3a8c402c5db9@nvidia.com> <ZtiHzQHJ4PgWc21e@x1n>
 <b8807171-567b-4e21-af83-bc2f6dbbf606@nvidia.com> <ZtnLhW-2eo8hA7bQ@x1n>
 <812e89c4-35d8-4fc0-ac10-ec36d57f215c@nvidia.com> <ZtnbD69EeXhR6FFc@x1n>
 <22f013dc-6c47-4902-9b28-08e916c3cf54@nvidia.com> <Ztn5CcxhzYR-SFfE@x1n>
 <c4eebbbd-00aa-4893-90f8-e6faeb08db90@nvidia.com> <Zt8QKPZiw6BXgh-5@x1n>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <Zt8QKPZiw6BXgh-5@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0380.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::32) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DS0PR12MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8ff7aa-af14-4123-48c6-08dcd3023475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVU0QU1wMUJhUkpHWUFFendpS0hzMkl2bjZHK3NXZmN3bVJnUUI2YjV2SXlq?=
 =?utf-8?B?SGlGYXdKb1kwV0EvQVQvcU5IU2drOGxneXVOUHlCWE1QUFpSWjlyd2swaVdu?=
 =?utf-8?B?aThXYzZjRUFmSXFVVVczdVlFSGhrZ2UwRm81MGNYNnB3NHJCdHMrV0lncnJJ?=
 =?utf-8?B?OEtkWHdlbkg4Ny9Td0plM3FaSEd1Q3lxRDY5bFVXbWR5QTAzSlBjWitjU3hu?=
 =?utf-8?B?VUZ2Y3pqTjF3VEY2MFg2Q240bndTSTBQMHFXQUt4NC9yWmdxTCtGcmJsTy8w?=
 =?utf-8?B?ckpXdjRaaEJrUzRMQmNsUFJjNTNwQXBZUTY3MldNWjd4elBEcEl5NnN3bU9S?=
 =?utf-8?B?UEEwaFdjcjVzcFBXRCtxZU94WjJlS3lHSVV4Q045SGprdXk0L2tQNFJZYlg3?=
 =?utf-8?B?T3RSajY2bkt0dlNhUGZMWkRwVlYzNXp0V0RoZlhGcUljT0hVekF1VHlmNGY5?=
 =?utf-8?B?VzcrK2luMGdjSU8rZGg2YWdtWnUvT2xLZ0I3SFhEZW8zcnZySWY2aC9Vb3BF?=
 =?utf-8?B?RTBDRStHamxiWU8xTG9BcmlwdklIc2cxVllxeTdjdDFrVDZRSEhuRmM2bFY4?=
 =?utf-8?B?NDZRcUw2R3R0c3M3NWN1dVdvTytOaHNTQkZuQlZFWkJUYXlEdmUzYXF0VDVQ?=
 =?utf-8?B?ZjBxZFBMM1N2eUhoZzdLUkExd1lMZUE5OEZuc0ZreS9PR3Y0R1pqcVloQTI3?=
 =?utf-8?B?WW00bkZVa2pCS09lbzZsRkRvWDdHWklCSWQxRFZ5NlNTYUtrNHp4eTFZVUpU?=
 =?utf-8?B?d2MycktsUS9iR0Q0R1g3MHdIbHBoL1VPMWhuVmhJWllxNElXc1AxR3lXSFdG?=
 =?utf-8?B?SW1ENDJyOE02VVRuelRpQ2xrNUovUkdFbHlrRHVnS2M5WDBjSXBwdzFqbHMv?=
 =?utf-8?B?cjFtQnMrNENrLzZOak5xWVczc0JnZGhJaWpnVXdUK28wZUhiOG41bDVnWFFB?=
 =?utf-8?B?QkdabCtXZFU2TWFyU2JUUE5Db1FFNk5ETUU5RHlSaTR5QjdpYlBFYWIwUVBU?=
 =?utf-8?B?cDZuRGlyQk9uRW5IZXpkT2pnczlnd01aUkNQa0IxNXFUM0luS1dKNnBuUW1w?=
 =?utf-8?B?YnhYN1M3VzFlV2lKdzdTeEllK2dzWUoxUUZQN1VTODNWeEFlTUdTUlJqWUNq?=
 =?utf-8?B?elFvVnBxUElmSnlGQm9vVWFCdTE2bjVLdUVaUlRMcHEyaTBqQnQ1SW9ONXo5?=
 =?utf-8?B?VkFFUFhQMGVkeThSQS9pbGRibWl4a2crRHZNakdSZzZsL2hGa1dlVjh0b0NJ?=
 =?utf-8?B?OUczOUFHZjRja0J1VHdXTUNaVWZiTGFnOXA1dVlMeWQrQXkvS0ZSNlhubEQ2?=
 =?utf-8?B?WHUvMzZ6QzNQRjFybDBQRVFyeU9ZQnVSWndLRS9TZ3ZUcG5xdHZOUnArMlNH?=
 =?utf-8?B?eHlxU2E1ampBZ2c0eklSc2RSSlhvQTBsWVVSeHV1bEp6Wjc4QzBTR2cwVkll?=
 =?utf-8?B?eU84b1dCY1ZrblZ6SUpZMHZJWEJuTXB5ZXZXZXNrKzB5amU3TUIvc1VMUkRB?=
 =?utf-8?B?SmdUS2dNUEs4cnRFNjYyN1JiMmZISXN0QS93WUtuYjExZmRuSkZUK0RkblVw?=
 =?utf-8?B?R0QwNlRuMmp5UGJXZU5JOU5CTnQ4aFFlN1I0RmE1RlNnOVlacDZJMiszWEtS?=
 =?utf-8?B?TXR3NWYrUEgxc2JVNnQ4SE9LbXN2bmM4Y0Roc1dzRmhLYXgzR1U1ZDNRbVM5?=
 =?utf-8?B?aWxXYnJjdXdSK1lCQlM1dVd4alh6WVJIMlhtVDhIaGZCTlBLckkxTTExWE13?=
 =?utf-8?B?NEZSTmRYR09HYlp2KzlTNWRKVjBwSlB0QTVsNXFrc3VOdGpjNThFcTloMXov?=
 =?utf-8?B?Znh1NDJLWld1VkxLd2ttUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlM4NzBaNVdmNUVmYUg3T1V3TktiNDFTRnd3TGNsa25sYlVFSDVUY2JxT0pa?=
 =?utf-8?B?TldZM09IRFgwRTFrc0ZFaVZUUXNld1B4WXlEOVRnOUJtaU9iWmhJeEd6T3ZI?=
 =?utf-8?B?d0ZVc016ZVlaZGJhY2NrR3d2S3l0by9UOVMvQUMvZ2RYUjBxYWpXQzRsR1pt?=
 =?utf-8?B?ZDkxMXYwZGtTWVdzRUJwUDdEMTkzWDQwSDBDRGdDZ05ORjhtcnNUZnNDWDdU?=
 =?utf-8?B?M1BhcnpzS0lWSEo5ZGhnb0hYWHAwMzczVU5rNitXMlZ0VENFUkxWbjhLeWNL?=
 =?utf-8?B?UFNyVUVoTS95czY5OU1hZ0hvRXE0YXhiZW1oZ1FDUVJyd0dFczMrckh0Ri94?=
 =?utf-8?B?cUtvTXJiQWVqWGY0a245NGFRcWdSZC9iR0FnTDFqaVpER0JqSlEwSzg2dmdq?=
 =?utf-8?B?VW10MXJ6OTY2RkVvRWZXdFYrNTJTNE5BYVVmWUZCVWZNejBWVHRxdkYxVjJl?=
 =?utf-8?B?c2ZBbHAwK0hIVGRNcS9GbEp3NlhiMVpXVjZPOWVZN1FPWTZlV1FEc0FGMXJq?=
 =?utf-8?B?WHo5ZERvZmdudEY2N1RjQkRhOVp6NktGWWgrQjNTUFlkeHBQb2hicjNRS01E?=
 =?utf-8?B?NVRKU0QvOVBGblorSzhqUWVlaDQvRENnQ1ZONitpNGx3V0VqS2VEYXJEZy9G?=
 =?utf-8?B?MHMvTEt1WmdSWXB5NzZsNnk0M0llOEJlUkdpZEZMcjZrSGQyQlJhQVNuaEds?=
 =?utf-8?B?cG5TQnUrSHdJTjlRVDM5UlpTbEpDUTVTVEJ6TG9aZHlGSHhXY2Q3aDBBT29n?=
 =?utf-8?B?ZGJBRW9RV1pPSW9Ja1JGVWtHNWNXWGJFdWYvNXYzbUp1UEliR0gxVG16TzFC?=
 =?utf-8?B?MVFLbTZWM2FabzlXYjgzVUp0WFZDOUltb1VIdGhlOHRyVDFWSk1vSHRUSFVK?=
 =?utf-8?B?UGlWMUJOWm1wSlFEbk52Y1pIdTJJUStuOWljalJHbFQ1UFFUa3NvWmtPaW83?=
 =?utf-8?B?azN3ZWx3WEJVdVhPRTFaay9jVWQrdUhTZDhTUzcrVmhwUk5sMVRsNmZPSnBW?=
 =?utf-8?B?NGV2MDc4QWJzRm9JOFdpb1lKQjMzaUhxUkVvb1ZXNGtBenVONkszRWlNUktJ?=
 =?utf-8?B?NDhDKzZNcmp2L2hIZmZwR0YwZlNkRkFBZG5GdXdYWGQzWVJnWlFsNWloVzVp?=
 =?utf-8?B?NUFtKzR5a1NVRXp2WktKWnRaNEwxbmppYitjMzNwRkgxRThML3p1NnpMMzhj?=
 =?utf-8?B?cEdtKzdWSWVlc3dhTFdMSE4xOENkZmc4NUVRNHdQbi9YelR5b2l4UXBDUk5B?=
 =?utf-8?B?RGY0NU5nZ25QRldSWXBaZjFUekZWcWdlYTNwK1VhQzM3YWVuVHNIUmg5Kzkr?=
 =?utf-8?B?WUVjeGlYSFgxSi8xcEgwTFlYU3NQKzZ5dnJreDY5MXc5WDQ0dzlQcUg5VnFp?=
 =?utf-8?B?VlBVVFBaTGxmdWU4dnpGQzZrOWZGSWcyb1NhVmVnRXcxZW1mb0hmeDlHRmRD?=
 =?utf-8?B?S0w0TjJGMzBIZEtzQVNCbjlhNURzUjNQUVUrVlRnWFIyNUJKV3B4blYxTDlU?=
 =?utf-8?B?alZ2aFY4ekZPYVdUcHJLOW55cktRTXVhcGNRZEs2MXA1YUlTK3VrSFhFM09G?=
 =?utf-8?B?UkhNNGFqYnVCNHVla2FucjkyYStCMUl5Slk2Skh2VGpXeEZYTkg0K3QyeEJp?=
 =?utf-8?B?eVp3elNZM1NBQy9xOHgxZ2NaVlFLRUpoVmYvTys2QWxkV2E4cnJwY3U3ekht?=
 =?utf-8?B?UkF3c0pUL1ZDSzYzM2NwWk1GM2VwL29wK3ZqdWMxdEIrc3c3d29sbmFVSnRI?=
 =?utf-8?B?b2IzdFRnOVB1aUVzb0FLY011YjNPV05KWVR2aVZoVHBSdzM0WElmRExISXQw?=
 =?utf-8?B?eVMwVEtVS1lmTTlwVFA2cXVYN3Jad25DakhsTkp2TG1PaU02NGc5S2kydEJE?=
 =?utf-8?B?Zmx0b29KVXZreXZiZEtPY3JRVnhHU1N6RGdQNm40d3VNeWVsVVRiNDFHb3BX?=
 =?utf-8?B?R29zaWh1RzkvRGJjNHUwaWZnQ2FTQnMyRVFNRVFWZVlHR01GdjRzT2YrQksz?=
 =?utf-8?B?bklWWllsS2NtNVlyTFl4OTJHdWkraXRtKzRaSk5yUXRnMldDOUl6aVFLYnZi?=
 =?utf-8?B?N1lsdGptT1dkRGdIejd3eXEwd21tVnBncW9nMHBCblNYTXJXeXgzVm5YK2FS?=
 =?utf-8?Q?4ExcANqjUQnxOeY+JXELeGY+A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8ff7aa-af14-4123-48c6-08dcd3023475
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 08:09:20.7076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0RWMAfU4W9ygQvURsgk+45VVYMDGuA1EB91oll/6DA+ca53sjLoLzRYeBTVidDytEUcFwCV9xhfTCmPbVQ2YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9422
Received-SPF: softfail client-ip=2a01:111:f403:2415::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 09/09/2024 18:11, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, Sep 09, 2024 at 03:52:39PM +0300, Avihai Horon wrote:
>> On 05/09/2024 21:31, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Thu, Sep 05, 2024 at 07:45:43PM +0300, Avihai Horon wrote:
>>>>> Does it also mean then that the currently reported stop-size - precopy-size
>>>>> will be very close to the constant non-iterable data size?
>>>> It's not constant, while the VM is running it can change.
>>> I wonder how heavy is VFIO_DEVICE_FEATURE_MIG_DATA_SIZE ioctl.
>>>
>>> I just gave it a quick shot with a busy VM migrating and estimate() is
>>> invoked only every ~100ms.
>>>
>>> VFIO might be different, but I wonder whether we can fetch stop-size in
>>> estimate() somehow, so it's still a pretty fast estimate() meanwhile we
>>> avoid the rest of exact() calls (which are destined to be useless without
>>> VFIO).
>>>
>>> IIUC so far the estimate()/exact() was because ram sync is heavy when
>>> exact().  When idle it's 80+ms now for 32G VM with current master (which
>>> has a bug and I'm fixing it up [1]..), even if after the fix it's 3ms (I
>>> think both numbers contain dirty bitmap sync for both vfio and kvm).  So in
>>> that case maybe we can still try fetching stop-size only for both
>>> estimate() and exact(), but only sync bitmap in exact().
>> IIUC, the end goal is to prevent migration thread spinning uselessly in
>> pre-copy in such scenarios, right?
>> If eventually we do call get stop-copy-size in estimate(), we will move the
>> spinning from "exact() -> estimate() -> exact() -> estimate() ..." to
>> "estimate() -> estimate() -> ...".
>> If so, what benefit would we get from this? We only move the useless work to
>> other place.
> We can avoid exact() calls invoked for other vmstate handlers, e.g. RAM,
> which can be much heavier and can require BQL during the slow process,
> which can further block more vcpu operations during migration.
>
> And as mentioned previously, VFIO is, AFAIK, the only handler that provide
> different definitions of estimate() and exact(), which can be confusing,
> and it's against the "estimate() is the fast-path" logic.
>
> But I agree it's not fundamentally changing much..
>
>> Shouldn't we directly go for the non precopy-able vs precopy-able report
>> that you suggested?
> Yep, I just thought the previous one would be much easier to achieve.

Yes, though I prefer not to add the get stop-copy-size ioctl in the 
estimate() flow because: a) it's guaranteed to be called (possibly many 
times) in every migration (either well configured which is the probable 
case or misconfigured which spins), and b) because how "heavy" get 
stop-copy-size is may differ from VFIO device to the other.

Maybe I am being a bit overcautious here, but let's explore other 
options first :)

> And
> as you said, VFIO is still pretty special that the user will need manual
> involvements anyway to specify e.g. very large downtimes, so this condition
> shouldn't be a major case to happen.  Said that, if you have a solid idea
> on this please feel free to go ahead directly with a complete solution.

I think it's possible to do it with what we currently have (VFIO 
uAPI-wise), I will try to think of one.

BTW, I checked again and I think we should drop this line from 
vfio_state_pending_exact():
     *must_precopy += migration->precopy_init_size + 
migration->precopy_dirty_size;

I can send a patch for that.

Thanks.


