Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E486EF4EDE
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 12:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9jAB-0000qs-CM; Mon, 06 Apr 2026 08:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1w9jA3-0000q0-SY
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 08:34:37 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1w9jA0-0008IX-7h
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 08:34:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdYj+9YCGNEe6Gsm12USjIKKr7XhJFycta6Z5rSr0YvtJjOn5Uu1rzXd8yVN5RI+XZJrpZ82EDy8SVBe9lq9zBMWPavO7UmBHLK2W/D54WRKKq+WBSjWWTb4pxKsLwWl1LbUhY4wotNK1JgZoffukPN9S8XUzbHa7H/KuqQE8g6OuzhvaYkpiYC1mc7BAoUQXwduiEjmZ1QaBFpukR/N3dIhFW5rBmQQA8H4iML83MpdLMwDl7aDhYLxlWKb6U0kSIEt+P0+ynuJ92NnJeZkkkxIEia1KKEZls0Z5UIgDXrcNtgb3+s/A9XfEKaJEiV6o3gpgc6MisRdqg1WJgWNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aw9jCWJSL4iETscKI782vpoI4/h1kZnxuqIDj50/IRE=;
 b=RLxsJgpFwStGeFwFzHkzKHrXSKQO5OdYatsw3ZN5yJOduvmDA29DOEJHJNhLRKWWEQYD6N/s6rTNApp3vplfJr0wrLF9fdPF7MBd8LFW++l0LSB/lNRQoLnkgwCOCFth//xbKYdJ4hFavj+PjMBeThIL+gRL8JCtBzP4zgExKPYazjQZrZ6TzA7muaWv1oQBj14UMhFz12qiEF2Kab1AtAHHxgvJf6L8wAuZrekGJ/NGMGbUUBEgjS0xuOfr9R3/rZNnO2sopRw+y3bGFhie6wwLsh2C4wWsBL9qOGmRFht6fabbFoJD6x6A+ZmTYEv5DXQ3vshd33l9T9Ciq5ctXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aw9jCWJSL4iETscKI782vpoI4/h1kZnxuqIDj50/IRE=;
 b=tbCxeZT9ODMiiiAzdJjndfTO74gswi4C5uqcvHFZ0XGCpKj5HmhwuiANOdFwobolq9Fe+imyi/LiV5sBGZyogyZIdyBXCRnEWnjvUfpbbWGnBSR+6w0SItVUL+BF8/xtIcgETqCowLK40UzAYSylaw0Ztp6v42xGGhwmf3Coy8gagIz+tSuw+JxG1edlMcrr89r5nbjaqEkhMFXlc0fIxYNVkTFAzAaf3Kyy9uNiOZQBW0swqqjD7kl0icpMPp74LKxXR+VyX21n4W/qWA6kje8c0yKLMHLJWIexYDlhL60D97pUCpeJoJ8AhxJUPanJYeJ0PExg6BRbMM1eBRdJ8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 6 Apr
 2026 12:34:26 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 12:34:25 +0000
Message-ID: <b1a8f7d9-306b-4a13-8916-828e61ed0f41@nvidia.com>
Date: Mon, 6 Apr 2026 15:34:20 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 08/12] vfio/migration: Fix incorrect reporting for
 VFIO pending data
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson
 <alex@shazbot.org>, Yishai Hadas <yishaih@nvidia.com>,
 Fabiano Rosas <farosas@suse.de>, Pranav Tyagi <prtyagi@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-9-peterx@redhat.com>
 <e6a9aaf2-e2ab-4b25-a01d-b6093922668e@nvidia.com> <ac6LCWmVHl8fq81J@x1.local>
 <ac6RbaA3V_jpfwJX@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ac6RbaA3V_jpfwJX@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
 To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|MW6PR12MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d27876-8b1d-4c4d-e252-08de93d8d68d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: IVmDgqIPXqC1NC8q4A4VTHcRh7enRa1ih9c8GfxRVjjtvKfpIIZNt9wLcopJhRfiZ62O/4UIzapUOmgcnnYu4Azj+NPoSHoDCNM/MQOacE1kNDqcn0/GLa0+x47oxdBDMvZZ/zAWRKCIU+rzHaqryHCs9Cdaf/CL+URBqhQI3AMUpELbe9tWrktUnWc2lHJ6mMlnBi4pQvDecERNh15lkk7OY+pNd4uOSd74ywr7nVTrR2F0nYDt4ekRz5xCSJaJo1EmMIVg1UJmUJtLd47da8+PQ0k0jvBJh2k0j551AsTPfSsr0pk9TVOgqwDxXjdOcBrIQ0N3Q+2x7sn57AolH+SRz/rKCBXNU2jH0U62nuVSORNNX4stLhy93I1zizftnnZgPz5SjqCpZsjHlmzZ9DZBoAYwy2GQ0WTE/dRaGF4gpHJUdg45LW78JlajUPx4Vci9+oDMzMWcG3WJFrvl8Nv5a1ooN7g761UZ1ama1KFCWF8JwFqu7ldT7UTWMclrRXQ5HGADF5u5HCe8e31aGB4/43mliCQfC3IijLm5bbU7qqhO9ReqCtlYVQolp1UkyIAqDhvJWJ2ecG+/Pt3tAyEYYBNMdEtLQ0NIFtDxds7dTOc2a0PeymMqYqWHmHZTAEcSdJyJSWF3KDyy3+sV7YZu9z3C4B1yfIGX+IBdi2FeVPw4e4jQt4XMRt/2tPhURkGg5nkpbNKdusLeIe+D9dre61bz63q51J8F7LLEym0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REJjN0ptTFRaTWw3UzZOd1Q5NGkvcEphQTg2S01IdEFkdjF4UDBKU21QZFNv?=
 =?utf-8?B?YzlJdCtheWFvSG5ONnhZNUtWbWxDTStuRUh4eE9sRkUyWHlETC9wb2wyMVBF?=
 =?utf-8?B?MVZDMklkMk9ZMDB1aXhJMlRKRDc4bm5NWjFSSkoxOVlIOG0ra0lUN2cxTjJv?=
 =?utf-8?B?MndPeWN3cXNIQWpBRzY4b0h3YTFmU00rS0EyL29aaXBURU1nZHZCZVNuTzJY?=
 =?utf-8?B?bFhVcjlaQ2FpY05qY2ZYeEhPbFZHTmR1dXhNVGJMOU1icUpVQmFMcXBRU29J?=
 =?utf-8?B?SXZyVnpJbThsOG13aXhZSGpsaEY5S3Q0L0JpaVR3UnJWNk95aW9rTDFKWU1p?=
 =?utf-8?B?NDhkY2lFRFJYVmlzclNhNW1vMUwwNURmbnhUenFuMnllK00rSllqb2oxelhS?=
 =?utf-8?B?blJOM09tU1ByZVNweUNUdXNMVlgvdjVHQWhtK1FLa1EwaFJub05FU1BBNi9O?=
 =?utf-8?B?M1gwbnNzRHpFOXpRQ2pGVEdUMTF5VjJqL0hNbk50OW9hbFc2NndRb2phazk4?=
 =?utf-8?B?RmhCaC9LOHI0L2U3bUVPYm1UUit6Q2c1U1d5MnNrS0hLRm9uUVhMejBabWZx?=
 =?utf-8?B?TExSbEVNd0tCRUJKNklyZ0dvb0p4SUs0M0JYaTJ1bmZqbGdCZFppSjJNQ1gz?=
 =?utf-8?B?WmpOamxhVjFHa1I4RXpSbkg2V2kySE00bjBuV2Vvb1JjeE50Ukx1VXJtSDlk?=
 =?utf-8?B?L2JRSHBnN0x0UW9kdnc2QlZ2Rk5YQVhLdURmN01SdkdXb2RFbnZodUtMYXds?=
 =?utf-8?B?TVVwbno5THUyNVFqUDRWTUZYYXdJcWtKd0VXRGVDbzZrcndVN3d5MXI0NXpQ?=
 =?utf-8?B?RDJ0a3F1M3FCeWtwL1oyL1k1eHAzNkZrRElDcllRZWM1dXdmRTZaZlJEaFhI?=
 =?utf-8?B?SkxGZ1pHVExWWFdYYzQzVnNBVHVic3hnNlpvS2pJV2hMWGJmOXk3eGxxdHZP?=
 =?utf-8?B?Nm95K1M3TU9ZV01uWkR5WThYVWpnUFNudGd4SXJGRXl1dDRLSnh1WkMrcFhO?=
 =?utf-8?B?aUVGNXZTQzlSUGdwQ1g0a1ZiUlpSVHdEeW51UGhtOGU4VURxa0wwc0dZTXJB?=
 =?utf-8?B?TVFKbnBmN3NOY0plM21CNGtsTGljUE5nWWp1clorRklVZU0zL2VPaHZCc2Jx?=
 =?utf-8?B?MUlhNm44UzFZZGh2UzZocCt1N29RU29zQlR6NHhLY000OWdOd2FDV3VHdmVV?=
 =?utf-8?B?YThtL3pxN3BHQ0RhamQrdnJHdFVDeS9xTUhhYnZGL2ZHci85cldIVCt1eHVL?=
 =?utf-8?B?QS9uU3d0Mm8vcGxHTDk5VlNDR056c1doWTlnLzhYKzFydGtOQmNaN29SeXlj?=
 =?utf-8?B?cXFNVVpYd1J4MTE2K2VEYVNOMENDS3k1VFUxMjE4aWJ4azdQdnRiMm5qeFll?=
 =?utf-8?B?YkhFTG5pc0cwMXpzSnRoRUFwSHppdUYyL0NYdFZ1UHZjUHV3THRhbk1DUmZa?=
 =?utf-8?B?RzJmTm1oVTh3M3NBcW1uTStLNmxhMktXbm1DREtsR0szeWJjdW9CVEVCUWl0?=
 =?utf-8?B?T0djRlF4T2RnQ1FsWFNoenp3cytGbjR4TUNCci94eVlMaG9jZ0hBZVJxczYw?=
 =?utf-8?B?dzhncnJYS0NZTXNWMGdVaTFJMUNkckVqaVJpcmprUS9GcDR1N1BIUzJoci9E?=
 =?utf-8?B?OUFnNmtaU3NvNzQycUp3VDZUQWhKc3lacUhFczJzY0dSSi9WWTZSdGxCdDYx?=
 =?utf-8?B?VFBlaVhWVHhpcU8yZStCN1RCa2paQUlUdUFQbFNoUkJneWwzbEpsVEdFbE1w?=
 =?utf-8?B?ZlFwQVBQVmR0ellBTWJEQmNuZWswWlRDbnMzZlZnVkFYWEh1cmowa2RpOGRr?=
 =?utf-8?B?aXBvWGhrNmg5RklWZHhzemUxaG9IK1Rrb296dHFhQ1lRcm1WWVRaRHdyNXhw?=
 =?utf-8?B?cjh6b0R1WlU0SzQvZHk4ZFNwL2MrSDdOSVRLMDNqVTBBWEtzY1hxUDltaVgw?=
 =?utf-8?B?bVFlYmw1ZDRvK00xNHVLRDNwU2dBS0ZNU21pY0dKc2RkaVB5L1JpeGVUSjE0?=
 =?utf-8?B?U3dPU20wMzlYVU1lS1Y0YkM2OGRPazZMdmticzZHbnR2Z2J5MmVIeXlUS1Z1?=
 =?utf-8?B?VXdTcEFPSkZOU2ZmdmQ2a3UzUGw4TUZDd0dtQ1dTdW1kVEU3ZUVVQitKZllu?=
 =?utf-8?B?cVZrZEVVUjF2d09aVDA0OXlHZlpNcWhINTROM2t3MUlSTXd5YjlRQ0JDOEJK?=
 =?utf-8?B?WFF3ZndvVE5KNlBXZURieVpBOEQwRWJZSnlLYjU4UE1zQThSQTNwN2t4ZDdi?=
 =?utf-8?B?TFdWbHVhMDgxRWJmOFpEdzd4LzJxeS80WVdwK2djbTh3cGI5S1pucDEvM05U?=
 =?utf-8?B?S1ZCZzBoS0VUWXVmL0lyeUlDdDJXVHZWanFldEc5T0NHWTNBMi9hdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d27876-8b1d-4c4d-e252-08de93d8d68d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 12:34:25.8796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIriS0UA1XgQPlyA08dMwdr8Lgl2C0/Z8PYf0GH9n6TLc1s5yjN30kYlIZ73A0DYFSHFmhAiBPVd2+0dXeOUtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=avihaih@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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


On 4/2/2026 6:55 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Apr 02, 2026 at 11:28:09AM -0400, Peter Xu wrote:
>>> Now that migration->stopcopy_size holds only the stopcopy size (and not
>>> stopcopy+precopy), we should remove these lines from
>>> vfio_update_estimated_pending_data():
>>>
>>>      /* The total size remaining requires separate accounting */
>>>      migration->stopcopy_size -= data_size;
>> Good point, I missed this part when changing the definition, I'll fix.
> Instead of changing the definition, I found that it might be cleaner to
> keep the definition of stopcopy cache variable for VFIO (considering the
> other invokation during save setup), then just do one more step for math.
>
> The new version should look like this:

Yes, that's better. Just small comment below.

>
> ===8<===
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 655ff7712a..5aff8de844 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -585,19 +585,27 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending)
>   {
>       VFIODevice *vbasedev = opaque;
>       VFIOMigration *migration = vbasedev->migration;
> -    uint64_t remain;
> +    uint64_t precopy_size, stopcopy_size;
>
>       if (pending->exact) {
>           vfio_state_pending_sync(vbasedev);
> -        remain = migration->stopcopy_size;
>       } else {
>           if (!vfio_device_state_is_precopy(vbasedev)) {
>               return;

Now in the estimate path we shouldn't bail early if not in precopy 
state, so estimate/exact reports are consistent also for VFIO devices 
that don't support precopy.

Thanks.

>           }
> -        remain = migration->precopy_init_size + migration->precopy_dirty_size;
>       }
>
> -    pending->precopy_bytes += remain;
> +    precopy_size =
> +        migration->precopy_init_size + migration->precopy_dirty_size;
> +
> +    if (migration->stopcopy_size > precopy_size) {
> +        stopcopy_size = migration->stopcopy_size - precopy_size;
> +    } else {
> +        stopcopy_size = 0;
> +    }
> +
> +    pending->precopy_bytes += precopy_size;
> +    pending->stopcopy_bytes += stopcopy_size;
>
>       trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
>                                migration->precopy_init_size,
>
> --
> Peter Xu
>

