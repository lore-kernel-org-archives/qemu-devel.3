Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E948CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUneb-00039o-2W; Wed, 03 Jun 2026 11:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wUneG-00033p-7k
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:36:52 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wUneC-0001Mm-Sf
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:36:51 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653EDBhR3777781; Wed, 3 Jun 2026 08:36:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=yh+LmgGKlNU+aFjl73jMFt+IN7d6aKc7YWf+zpVEP
 lA=; b=URgBhhyVlCo985jm5Ril3uqPeG0AMlyAHKZFSxEvBn/BJOuTqXVR7Kmo8
 w48sTJIiZHEesognCq7mcS9J5QFFg6kkh7ae0Fctbg3E39D8+qyLZJup5TOo0Nae
 yyQHv1FDWanCf7Xj2b3n5E2qZ3UySBVwiDRA1C2dICHH8ziH6UxEQ13SzCmzNw5r
 0vlRESzxmrS6jblsVMUdITSggfYkAFyNswcJKyEZD6N3lPPVh50ZrOZnA7I3W9/6
 KrXf3Ko1lv5KuKnxJUdmhbFBcWLIsozwTx1Y6uSKYaxF708owiuG62VgwPtXIs+0
 BokGxFLmpH61d3jNGzkGsJtVW3e2g==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022115.outbound.protection.outlook.com [52.101.43.115])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ejg2492pe-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 03 Jun 2026 08:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUKkCCoZTxUmDMBkx+tLfUgGJVqRwsE7yod1FTgbl6K6hvc1QQamDswYsOyOLdEwsG/x2y71A0WCnrHFatoTbCpgs5GPoY+vpBscJOfs+bpc6IpuSED9+hKjS6vDq4bKcJzSxnj97OGoiweDQ58Ebq9u4RNvMic2CEAwqjvd/419XdRFagBa8z0tJhjwhc3eLbBOUcv+vsiJ9jYSJ5s/cJJmoc75ml8hUHa3KWOY6u54hOoosagtoNechamzE3SHFQaFxKTxyEvXzTQqBtA2XyuzchflLMjvwwJDovU8TrUIrLjlzJ8Jx+vWG7g+rkH1SuRYb9G4L9k3Km1ryluLTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yh+LmgGKlNU+aFjl73jMFt+IN7d6aKc7YWf+zpVEPlA=;
 b=IpUMboZwOXE5lmtKydbzU9VAxfWMgaH/5/mi3Co5829hlHen9LWoQvDIb6o29FJUt4G84Rwnc211Bp+JIkjRwqCORq4PV0QTdqQgQk/bI7IgzwfXKM4OYVlLhimONvJnScp2cGjuEnPuxBMUn/iW3tnzIDbEnTxijk5MzI/kFyjyDzRfwDpDjswOPIyYfH2RbotET3N5AENsJmNC47SStD7QjQm2sp15EqIX/s7JFCztrXlhaLWby/rnbKSeVtXCYQaT2ciwGFWghcQDDnYRkDPMqAQZwiInrlEMUz0xrffP/Clvs+gxgD8BvLHV4hXN9qfsSjFlfIeMzcxUiDrFDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yh+LmgGKlNU+aFjl73jMFt+IN7d6aKc7YWf+zpVEPlA=;
 b=Tanx+nvG4npMfSZ2V3k9aTnuaTdg0ZSYRm6MW1dQKtrrnhypgidrlWzm7I3NvGoPNJmkPY8vHq2QPQ0e8D9C88l/scKIZbDAzIZSvjEc3nlPNsqyIAO8pw9v7TTA1n6XK44y3xxA4kgVpuXMmObD+F4vIgecxyHCmyKnKH6AQA34MGFwDKIu41vhKVU3Dq9gsMwSjjCSmbKTkXBmshsirGF2OalMNprsW03XVj7sTN541uY7aoNMc5kAscx/ZtqPZP7MYYUQw8QWwGWDz79mFWQW6ht0Yy3UZfCyU4UohJoe/S9uS/smhbIeb6Kv9/M7DUJgBtL4ekqf4QInEQt94g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7343.namprd02.prod.outlook.com (2603:10b6:a03:29c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Wed, 3 Jun 2026
 15:36:42 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 15:36:42 +0000
Message-ID: <12cf9760-831a-410c-b8dd-a9bc6befbae3@nutanix.com>
Date: Wed, 3 Jun 2026 16:36:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] migration/vl: Allow set parameters with -incoming
 config:*
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20260528212947.368132-1-peterx@redhat.com>
 <20260528212947.368132-2-peterx@redhat.com> <87pl2ftc12.fsf@suse.de>
 <ahmrcVkOWW5iwozk@x1.local> <87cxyetbc4.fsf@suse.de>
 <ah36ZhBP2TweYhg0@x1.local> <87zf1d6p24.fsf@suse.de>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <87zf1d6p24.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYZPR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:930:8a::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 0365a5a6-eba0-4a4b-3764-08dec185e998
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|18002099003|22082099003|4143699003|5023799004|6133799003|56012099006|3023799007|4133799003;
X-Microsoft-Antispam-Message-Info: 7i+thvW0YXh74aHWjfNWXKTwJV5YQtc6ylTEPhC9cbYvz2O7L+DeV94ebf3aB/AaW+0J4/EER+ogQ4b5Vxc+YmhGct2cE1Vr9ym+U8rr/8ZEmtRyYEBSjeRYPtEvHfBA6jmfx2PmEAD3lu/21FRW/AWKseld/aweMFoBUfP7XdAf9C3/BeiQWxxzUwIiZ8TPiVJGJyzbRt+2d9pHTogcRnhDKR7rn+hd3yhhkAdGjlrfbDrkpf+R7mHpDHCFWrzqmL0cHoBw5HNsSW6p1KiUlenyyb/PGoOyYzR5IUXbYvxXuv12gtK+ODSNbhgzy6YlnOSPalXAAd+panFZ/DirN1ajVcEp9YldLgYLORkQagH8MvTkwATBNvyuym5DxiSO6P6TMmQw1k4/skovClOxI7wOLQ4A9KkI9keoEaKEbFHeZ4iQjiumclH+9ZuepnRENEsY45oqXtJS5aMBlELY6eJ3DhUAG0WNGnVzvUffYespHGovW6F/uJQwQrfm7Eq+EfGtlOGAJ2sNmwVVdx7weF8M3+3YrB//NXP7ECn9e4t66LgnvresDkNHMnwnpypjSx7rSZd9mefhyzg6ghzvxTYrFGEKZ2ZEs6Z+tArRskP+5n0vaEmBPD4Q25u8TyVPu+Cx/Oeb1nBlBy0/wL+K5xKA1ij1UVDOS8FVdK7vv9M08DqJSHJMMU+O6LJj+m8gT3bcj3yqWhypyP+8Iscd1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(5023799004)(6133799003)(56012099006)(3023799007)(4133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTV4TE9HT0VHWWRHRUVjNnB6REJTYVE3R3U0OWNXMzB5bktISDdSM2ltd25C?=
 =?utf-8?B?T1lpYmN0azNXUmp0TlAzYUlEdGVuQk9lWEROUVFmVkgxRGRidHAyS3N0T1cz?=
 =?utf-8?B?OGJIRHdZbXhpZFRYZVJYNHhWMjNFaTNyOWkrTDNFRFFrU01KMHh1RWVKOHVX?=
 =?utf-8?B?aG9UM3puT3BjKzh0KzBYMGRHQ0tGR2swNkZVdTVIaVEyeFM2TmM0UlRDSjdH?=
 =?utf-8?B?SEUzNWIxQnpPdC9McTVKRUNSdlFIQ0tucEpKWDVmbUxzTUliWUlXcEdSdlJ1?=
 =?utf-8?B?b2V0bEVib2FWak1qS2crNHRMZEhsT3l4S3hmWFptR2g2MHNHRVRtTEh2eHR6?=
 =?utf-8?B?MENaUFRKNVRuOUxoSUo2K3pnekJzbTg5ci9KWjVoUFBkc1F4Q2d6WWFlZVAw?=
 =?utf-8?B?WTZSb1p3bFdmNGRveEJlQktHWHpzd1BhYUhhVnVCVFRPVkRxRWhobjZhQWZl?=
 =?utf-8?B?aXkyTXp5QUpFY005ZUpuNWR1eUlmTWxRZ2ErZGhwdEhuMUZKa3FJVzFXZVkx?=
 =?utf-8?B?R1Y1WlhOQ2JYc3p4THllMEhwM0VSRnNWZXNHMDlOSnQ1Rmc5bHJyYUN6K2N6?=
 =?utf-8?B?RytGeUZaNU44dkVFZmRqVm5YaWJ4VWZ3ay85RVBoQUJtQTdOUU5DWU94dGZR?=
 =?utf-8?B?bk5VTVdDajcrSW52V1FVcUZoZlpLYUFCVkovZFhybkZWamZLeHFVS1VQaE1x?=
 =?utf-8?B?RmlFVnM0d1VNSzBTc0Nxd0hXeTBHM2RZZzVkQ1lpTzBmaDJSM2lKT214aE5z?=
 =?utf-8?B?dXExSXcvcEFaZXZ4MWtRY1h2SnB1T3RmV25jbzNmWHJnaHVlNDI2bmxqNHhU?=
 =?utf-8?B?QmpVOUE3SkJiYUVXRWpzVDJLZUVuZC8rdzRYMEVQVU5mU1VKT1c1OEhSUGRi?=
 =?utf-8?B?Q0s2TWZrVWhTUjBicVFTd0IybjZiVGxoREdNSGE2ZmNnT3I4RVpEZ1FzVDBn?=
 =?utf-8?B?KzFsYlR5MGhydGJITm5MTXJaT1ZTbmNJdmtJcmlOdUpQTEg0a0x1SXcwT2xK?=
 =?utf-8?B?OEd3NWU2N3B5cU9hemN6OHFmUm8vY1R4WDlXWnd1OFNVU3Y2bEF5dXNObHRT?=
 =?utf-8?B?bUNHY2RCZnNUakVtYTBXc2xWdFlFdHJaWlBwUUdHTkx5OVlMMlh4aEpVTUly?=
 =?utf-8?B?bUkwaVp6bTV2M2o1SEl0bStPQ1BMQ0FoTXY5dU9qVUd1Zlc5UU1wYURXOWZh?=
 =?utf-8?B?d3Y2d3dvbUtPclNYZFRXSUhFTTUwakNra1JtVjMzSDhUajFucGcwU2cvelMx?=
 =?utf-8?B?b2ZZVjh0UE5nb3dIU0I3VEJhZ3VhQmwrV1VFQmhqc2kxQXFuUUZNQ2pWaWZl?=
 =?utf-8?B?OVh2NUFQTVdxT3B4WHM5TWhLdjJDb0ZJakhUWm5FK1E4RVo4dVMzVTFjUXAx?=
 =?utf-8?B?VXlVRm1ZcUJXbi9mWW90Z2tyRVlLdFJQV1BwYjMwakRTa3VtYW4wSU1mWHJl?=
 =?utf-8?B?RVZsMmdyMjh4TUlDMS9LaGtMUkJmTXYwRXZMazFTZFBYamNyRzFFempIYWIr?=
 =?utf-8?B?K3RCNG15VytabG0xNUp1ajNrdnZ1Vm05MkZvR1oyWVhnNUlUZ3BUT3BqdzM3?=
 =?utf-8?B?L3FxSHVKM0tIcDZ1Qms1QmFKbHJQMW41RzlPQWhaYlpBSUdEWDlnR01kOHVt?=
 =?utf-8?B?Q2JjODJXa1o1aEEwZXFMY3diY2VLYjYycFl0WXFQelh1UlN2R0hSU1p6czVC?=
 =?utf-8?B?Q3Z3d3o0NUJvd3Zzb3pkVWsvNkRHOTVIZ0YyK3dvbDNzTyttcTI1TjY2d29N?=
 =?utf-8?B?Q0lFQkJTY0dmUDdxTDl4clZNUkZOdS9YZmJTNnNSNVc5WjJBdjZXdmNaVjBj?=
 =?utf-8?B?cjkvbGNrYktjMEU0aUlVUHhFbTJGSmlCR2UzTkpGeUdFWXRtYnRqK3hHNlNa?=
 =?utf-8?B?Y3hQZ3ViT0QyaDZHZC9GckZidXhKMEpzeGdaUHllNDlQbEtqTUhuVGhqU1hR?=
 =?utf-8?B?aTRVR2N0UFcwRmtvZFF6eUt4NDExTDhsVVU3VU5kdURYc1R1NUkzUWZ1dmFw?=
 =?utf-8?B?TE5HbUlKMkxRN21SZGZydW94cXA3d1NjTDJ6OFhyL1k5d1M4bmMzQVlLNjd3?=
 =?utf-8?B?cVhoOGg4Q3NLTGp6aFgwdEpNaVZsa0M5NEVESXBzVzgrKzRVdDdCUWovbGlG?=
 =?utf-8?B?Wm5NeDJBdm91WUlzUnNsUW5iUGhpcXFRSTFqemVCMDh1YUVURHZWQkVDRmUy?=
 =?utf-8?B?K3dTMmUzOEtkeGVod0orOWZwVG5Ec3lCZFUzMXlCWHdtTlh0enlZQThZUWdw?=
 =?utf-8?B?RTZmOG1Jbjl2d1lJbmFzV2FBQk5IWEpMQmFPQWxBQXkwY2NIcytIVlA4ajFF?=
 =?utf-8?B?bXB2UXR4M1AyaUJNMFVDeWZsRUxkVzl1UktRY1BnbWd6WWF5Nm5LZVpuZm5K?=
 =?utf-8?Q?4JK29aUKVRUkvb1o=3D?=
X-Exchange-RoutingPolicyChecked: cMZ15H0FjF/GZkwLdgQIZ3cOjSbu82+BMe8kSyHBUUwYIOD6SXZS0Wf53IXUkBajZEV2fIhuWYI4R12R2EC0TOdz8vWDTjUgxi4ioevwToXMqCP+A0woxYtJw5Cpvz72cGWEdxFDI5IXRF5Yau/z/M/YiHuoWrzBqudpOWYkIjt8yGyBw+nw5ak3pVH2tV5hi6dAPuFz2ozAWb1s5BQBNtkR1xhmod916SEO04QOgHP/RCi+3aKfeCj/0Ljf07EMka7xTcwQ4uNkPErmEi69g+A9TNh3jtyeuxk4aV27n3RbMwJxDJSieySD/sfyFYg+C1WgzCk95s/0kTYWlKmF3A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0365a5a6-eba0-4a4b-3764-08dec185e998
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 15:36:42.8153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5HfFxUIlRH5eS/1dCvWj0YyE3mICik394LUDSMvz73mozjPpavmxrBkbc6h4j9TD02T/pitGYflkTtppH/RbIHWTDrZqmqgwxmSmpeIkxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7343
X-Authority-Analysis: v=2.4 cv=T968ifKQ c=1 sm=1 tr=0 ts=6a204a0c cx=c_pps
 a=Ta6zJQCUzi71fP58ADEmYA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EBArqqBVCR-gLu5wRrEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE1MSBTYWx0ZWRfXzhz3nBN/WDPr
 81HCT3oIiaMGd1agrYCBhiZcthZjP77AURscEXgLt+8eYpxdMnv8bfFSkOdhalES/7kLKOWHO99
 7Ucdr7270Ol39Ysc9NbMbim52uPk72EALDKpGRQlf9EHJIDipKrZFMZ3tCMGIWNwxlOjaZ3bteg
 cXJ2OfSd9sCdAow0PXeyTOc+qqo2H8T1jqhIc28m1jYMmREzPQFC02peXFP0MW4Sw6M5QC4Oz7R
 9YtCGMvtl/slgGk6a2OQGPKu5c4Shb7BcJrkYf32qLQPFuGPJQf1ODmZZmbhSY8aBUEg3T7ADmF
 fdFaOHD3y02fxkXKeBYICpgXMVEs/iFD2vCETAwYCG2bfoK48kU0pJBBjpQoIy+F2p3BrSgA+OB
 DrbWXlp54VB7d8/PO2F61Uvxd2iY3hVJFreQPmCL3mF6KWI+5rL8YUrXNfSaZkqHNJCiK/9msU/
 9iYuYVH49aW0HEmuMKA==
X-Proofpoint-GUID: OBxZ8Y4GfhXUuTpAKDtXdEP3Dm7PAeST
X-Proofpoint-ORIG-GUID: OBxZ8Y4GfhXUuTpAKDtXdEP3Dm7PAeST
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 02/06/2026 14:37, Fabiano Rosas wrote:

> Peter Xu <peterx@redhat.com> writes:
> 
>> On Fri, May 29, 2026 at 01:44:11PM -0300, Fabiano Rosas wrote:
>>> Peter Xu <peterx@redhat.com> writes:
>>>
>>>> On Thu, May 28, 2026 at 07:16:57PM -0300, Fabiano Rosas wrote:
>>>>> Peter Xu <peterx@redhat.com> writes:
>>>>>
>>>>>> QEMU doesn't yet have a good way to specify migration parameters so that
>>>>>> they can be available even during early stage of QEMU boots.  It is because
>>>>>> the migration object (who owns the migration parameters) will only be
>>>>>> created after PHASE_LATE_BACKENDS_CREATED.  It means anything before it
>>>>>> reading migration parameters is illegal.
>>>>>>
>>>>>> However, QEMU does have special use cases for such, namely only-migratable
>>>>>> flag, and cpr-transfer. Recently, we have one more possible user to read a
>>>>>> to-be-introduced new migration parameters during backend initialization
>>>>>> phase.  We can introduce yet another global variable (or per-device
>>>>>> parameter) to bypass this limitation, but we can also seek for a generic
>>>>>> solution that we can setup migration parameters very early, even during
>>>>>> backend initializations.
>>>>>>
>>>>>> See this discussion for more details on the context of the problem:
>>>>>>
>>>>>>    https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_r_ahdI7Vl5KraK566D-40x1.local&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=RMJscC71rPIaZcWE2xNWeuHeK0qmTkT4jnKXp0AVp4SEa7jlKxLNal50vCx6VIAo&s=MNLWQVZxg7cOInvRx6FinI_ACIiZdt8KJfho82JzKEg&e=
>>>>>>
>>>>>> This patch wants to take the latter approach.
>>>>>>
>>>>>> As a start, introduce a new way to specify migration parameters in QEMU
>>>>>> boot commandline, as proposed in the above discussion:
>>>>>>
>>>>>>    -incoming config:key1=value1,key2=value2,...
>>>>>>
>>>>>> When specified, QEMU will parse a string formatted MigrationParameters and
>>>>>> keep it.  When migration object is created, it will apply all the settings
>>>>>> as initial value.
>>>>>>
>>>>>> Since the application of boot parameters will be after object_new()
>>>>>> completes, it means it happens after all machine compat properties or
>>>>>> -global settings (which should be done during instance_post_init()).
>>>>>>
>>>>>> So far, it's still only a way to specify parameters.  All parameters are
>>>>>> not visible before migration object created, like before.  Any parameter
>>>>>> that needs to be visible during boot will need to opt-in this feature.
>>>>>> Follow up patches will switch the current users to use this model.
>>>>>>
>>>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>>>>> ---
>>>>>>   include/migration/misc.h |  5 ++++
>>>>>>   migration/migration.c    | 54 ++++++++++++++++++++++++++++++++++++++++
>>>>>>   system/vl.c              |  7 ++++++
>>>>>>   qemu-options.hx          | 18 ++++++++++++--
>>>>>>   4 files changed, 82 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>>>>>> index 3159a5e53c..aff79b1380 100644
>>>>>> --- a/include/migration/misc.h
>>>>>> +++ b/include/migration/misc.h
>>>>>> @@ -133,6 +133,11 @@ bool migrate_is_uri(const char *uri);
>>>>>>   /* Parse @uri and return @channel, returning true on success */
>>>>>>   bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
>>>>>>                          Error **errp);
>>>>>> +/*
>>>>>> + * Parse @config_str in form of "config:key1=value1,..." to initialize
>>>>>> + * migration parameters.
>>>>>> + */
>>>>>> +bool migration_parameters_boot_parse(const char *config_str, Error **errp);
>>>>>>   
>>>>>
>>>>> 'boot' is not the right word. Maybe 'early'?
>>>>
>>>> I am ok to switch to "early".  Another option is.. "cmdline"?
>>>>
>>>
>>> Either is fine.
>>>
>>>>>
>>>>>>   /* migration/multifd-device-state.c */
>>>>>>   typedef struct SaveCompletePrecopyThreadData {
>>>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>>>> index 074d3f2c69..d918be7a44 100644
>>>>>> --- a/migration/migration.c
>>>>>> +++ b/migration/migration.c
>>>>>> @@ -41,6 +41,7 @@
>>>>>>   #include "qapi/qapi-commands-migration.h"
>>>>>>   #include "qapi/qapi-events-migration.h"
>>>>>>   #include "qapi/qmp/qerror.h"
>>>>>> +#include "qapi/qobject-input-visitor.h"
>>>>>>   #include "qobject/qnull.h"
>>>>>>   #include "qemu/rcu.h"
>>>>>>   #include "postcopy-ram.h"
>>>>>> @@ -94,6 +95,9 @@ enum mig_rp_message_type {
>>>>>>   static MigrationState *current_migration;
>>>>>>   static MigrationIncomingState *current_incoming;
>>>>>>   
>>>>>> +/* Only used during boot, destroyed after migration object initialized */
>>>>>> +static MigrationParameters *mig_boot_params;
>>>>>> +
>>>>>>   static GSList *migration_blockers[MIG_MODE__MAX];
>>>>>>   
>>>>>>   static bool migration_object_check(MigrationState *ms, Error **errp);
>>>>>> @@ -102,6 +106,45 @@ static bool stop_return_path_thread_on_source(MigrationState *s);
>>>>>>   static void migration_release_dst_files(MigrationState *ms);
>>>>>>   static void migration_completion_end(MigrationState *s);
>>>>>>   
>>>>>> +bool migration_parameters_boot_parse(const char *config_str, Error **errp)
>>>>>> +{
>>>>>> +    Visitor *v;
>>>>>> +
>>>>>> +    if (mig_boot_params) {
>>>>>> +        error_setg(errp, "Only one -incoming config:* is allowed.");
>>>>>> +        return false;
>>>>>> +    }
>>>>>> +
>>>>>> +    v = qobject_input_visitor_new_str(config_str, NULL, errp);
>>>>>> +    if (!v) {
>>>>>> +        goto fail;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (!visit_type_MigrationParameters(v, NULL, &mig_boot_params, errp)) {
>>>>>> +        goto fail;
>>>>>> +    }
>>>>>> +
>>>>>> +    visit_free(v);
>>>>>> +    return true;
>>>>>> +
>>>>>> +fail:
>>>>>> +    visit_free(v);
>>>>>> +    return false;
>>>>>> +}
>>>>>> +
>>>>>> +static void migration_parameters_boot_apply(void)
>>>>>> +{
>>>>>> +    if (mig_boot_params) {
>>>>>> +        /*
>>>>>> +         * This can fail, because qobject visitor doesn't do sanity check
>>>>>> +         * on values while parsing.  It's not too late; we're still in boot
>>>>>> +         * phase.
>>>>>> +         */
>>>>>> +        qmp_migrate_set_parameters(mig_boot_params, &error_abort);
>>>>>> +        g_clear_pointer(&mig_boot_params, qapi_free_MigrationParameters);
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>>   static void migration_downtime_start(MigrationState *s)
>>>>>>   {
>>>>>>       trace_vmstate_downtime_checkpoint("src-downtime-start");
>>>>>> @@ -322,6 +365,17 @@ void migration_object_init(void)
>>>>>>   
>>>>>>       current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
>>>>>>   
>>>>>> +    /*
>>>>>> +     * Apply boot migration parameters in case the user specified some via
>>>>>> +     * command line "-incoming config:*". NOTE: this will overwrite machine
>>>>>> +     * type compat properties and -global settings!
>>>>>> +     */
>>>>>
>>>>> Hmm, but then it's exactly the same as -global migration.* ? Why do we
>>>>> need to extend -incoming?
>>>>>
>>>>> Also, I don't see how qmp_migrate_set_parameters can overwrite compat
>>>>> properties. They're not part of MigrationParameters.
>>>>
>>>> Some of this should have been mentioned in my other replies, let me know if
>>>> there's still concern over there after reading those.
>>>>
>>>
>>> The question about -global is non-sensical, forget about it.
>>>
>>>> In this case, after we set current_migration pointer compat properties are
>>>> applied, due to instance_post_init() happening within object_new().
>>>>
>>>
>>> Yes, but migration_properties has two distinct sets of Properties, one
>>> contains only compat properties that match machine.c properties and the
>>> other has properties that go into MigrationParameters. I was under the
>>> impression that we never tied compat to parameters.
>>>
>>> The only machine compat property that is also a migration parameter I
>>> see is zero-page-detection. Maybe we shouldn't have done that. Now we
>>> can't decouple MigrationParameters from -global. Unless, of course we
>>> declare that from now on compat needs to be done with a new property
>>> that's not part of MigrationParameters; and duplicate
>>> zero-page-detection.
>>
>> I always treated migration parameters to be a subset of what we can apply
>> to compat properties in the past.
>>
> 
> Good to know.
> 
>> For example, -global almost works the same as compat properties and also at
>> the same time, currently both done in device_post_init().
>>
>> In the future, if your series to convert caps to parameters work, then I
>> also want to add even more "parameters" (which used to be caps, like
>> postcopy preempt mode) into lists of machine compat properties, so e.g. we
>> can enable preempt mode by default.
>>
>> I hope that makes it useful, but if you still see some benefits of
>> splitting the two things (compat properties / parameters), let me know.  I
>> may not have fully caught what you're visioning.
>>
> 
> The problem I see is a long-standing one: MigrationParameters needs to
> be embedded into MigrationState because of -global (as both compat and
> debug feature). As long as that holds, we'll need workarounds such as
> having this extra early state.
> 
> But let's not make this a problem to be solved in this series, please
> disconsider this discussion.
> 
> Just to wrap my thoughts, for reference:
> 
> What I want is a migration-owned MigrationParameters that we can do
> anything with, decoupled from whatever is needed to expose compat
> properties. There's two ways to achieve this: One is to declare
> parameters are separate from compat and drop the debug usage (what I
> suggested in my previous email). The other is to make MigrationState
> stop being a QOM object and instead make MigrationParameters itself be a
> QOM object. Then we could reference its members directly from qdev.

Is the longer-term goal here to allow machine-versioned usage of all 
migration parameters supplied via -incoming via -global?

> 
>>>
>>>>>
>>>>>> +    migration_parameters_boot_apply();
>>>>>> +
>>>>>> +    /*
>>>>>> +     * The boot parameters should have been verified already, but leave it
>>>>>> +     * after applying boot parameters to do one check for everything.
>>>>>> +     */
>>>>>
>>>>> Will it get expensive? We do that for every QEMU start.
>>>>
>>>> Checking caps and parameters?  Why expensive?
>>>>
>>>
>>> Just because we're putting more migration code in QEMU's startup
>>> path. Most QEMU invocations don't care about migration. Eventually,
>>> checking every parameter twice might have an impact.
>>
>> I would expect most QEMU invocations should care about migration, but
>> irrelevant of that.. I never expected these checks to be expensive.
>>
> 
> Well, only a small subset of invocations will actually result in a
> migration. There's many uses of QEMU that don't require, or even cannot
> migrate.
> 
>> postcopy_ram_supported_by_host() might be the heaviest, but it's
>> conditional and I still don't see it an issue. We also don't run any loop.
>>
>> What made you worry on this?
>>
> 
> I don't know. The voices in my head.
> 
>>>
>>>> Here I should have mentioned we must do one shot check here, because
>>>> sometimes there're illegal mixtures of "-incoming config*" and default
>>>> values only after they merged together.  I'll update the comment for it,
>>>> IOW we must check here anyway.
>>>>
>>>
>>> Right.
>>>
>>>>>
>>>>>>       migration_object_check(current_migration, &error_fatal);
>>>>>>   
>>>>>>       ram_mig_init();
>>>>>> diff --git a/system/vl.c b/system/vl.c
>>>>>> index da36b2c6e1..49f5fa0c7b 100644
>>>>>> --- a/system/vl.c
>>>>>> +++ b/system/vl.c
>>>>>> @@ -1838,6 +1838,13 @@ static void incoming_option_parse(const char *str)
>>>>>>   
>>>>>>       if (!strcmp(str, "defer")) {
>>>>>>           channel = NULL;
>>>>>> +    } else if (!strncmp(str, "config:", 7)) {
>>>>>> +        /*
>>>>>> +         * This is not a channel setup, but configuration to incoming
>>>>>> +         * migration parameters to make them available during early boot.
>>>>>> +         */
>>>>>> +        migration_parameters_boot_parse(str + 7, &error_fatal);
>>>>>> +        return;
>>>>>>       } else if (migrate_is_uri(str)) {
>>>>>>           migrate_uri_parse(str, &channel, &error_fatal);
>>>>>>       } else {
>>>>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>>>>> index 96ae41f787..1fc92a409a 100644
>>>>>> --- a/qemu-options.hx
>>>>>> +++ b/qemu-options.hx
>>>>>> @@ -5366,11 +5366,15 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
>>>>>>       "-incoming <channel>\n" \
>>>>>>       "                accept incoming migration on the migration channel\n" \
>>>>>>       "-incoming defer\n" \
>>>>>> -    "                wait for the URI to be specified via migrate_incoming\n",
>>>>>> +    "                wait for the URI to be specified via migrate_incoming\n"
>>>>>> +    "-incoming config:key1=value1,key2=value2,...\n" \
>>>>>> +    "                specify migration parameters valid even during boot\n",
>>>>>>       QEMU_ARCH_ALL)
>>>>>>   SRST
>>>>>> +
>>>>>>   The -incoming option specifies the migration channel for an incoming
>>>>>> -migration.  It may be used multiple times to specify multiple
>>>>>> +migration, or can also be used to setup migration parameters for the
>>>>>> +incoming migration.  It may be used multiple times to specify multiple
>>>>>>   migration channel types.  The channel type is specified in <channel>,
>>>>>>   or is 'main' for all other forms of -incoming.  If multiple -incoming
>>>>>>   options are specified for a channel type, the last one takes precedence.
>>>>>> @@ -5411,6 +5415,16 @@ options are specified for a channel type, the last one takes precedence.
>>>>>>       Wait for the URI to be specified via migrate\_incoming. The monitor
>>>>>>       can be used to change settings (such as migration parameters) prior
>>>>>>       to issuing the migrate\_incoming to allow the migration to begin.
>>>>>> +
>>>>>> +``-incoming config:key1=value1[,key2=value2,...]``
>>>>>> +
>>>>>> +    Specify migration parameters in QEMU commandlines, so that these
>>>>>
>>>>> command line
>>>>
>>>> Fixed.
>>>>
>>>>>
>>>>>> +    parameters will be available even during very early boot of QEMU.
>>>>>> +    They will be applied properly after QEMU boots and when the migration
>>>>>
>>>>> The "applied properly" part is implementation detail.
>>>>
>>>> True, I simplified it:
>>>>
>>>> ``-incoming config:key1=value1[,key2=value2,...]``
>>>>
>>>>      Specify migration parameters in QEMU command line, so that these
>>>>      parameters will be available even during very early boot of QEMU.  It
>>>>      has similar effect as setting these parameters using QMP command
>>>>      ``migrate-set-parameters`` or HMP command ``migrate_set_parameter``.
>>>>
>>>
>>> ack.
>>>
>>>>>
>>>>>> +    core is initialized.  From that POV, it has similar effect as setting
>>>>>> +    these parameters using QMP command ``migrate-set-parameters`` or HMP
>>>>>> +    command ``migrate_set_parameter``.
>>>>>> +
>>>>>>   ERST
>>>>>>   
>>>>>>   DEF("only-migratable", 0, QEMU_OPTION_only_migratable, \


ATB,

Mark.


