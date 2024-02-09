Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C378C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 12:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYQ0t-0006BI-83; Fri, 09 Feb 2024 07:29:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rYQ0o-0006Az-EB; Fri, 09 Feb 2024 07:29:46 -0500
Received: from mail-db3eur04on071f.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::71f]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rYQ0m-0000yR-8V; Fri, 09 Feb 2024 07:29:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+lVba2DgaR4hJuBJ1PL/mCVT6M/UMCXMZEqlXQAPhDhkbj0AeSxn1Q92NUkf8cJz0aPCKuRVRvc2ZBwvGhAxUW2NN77K0hNcwGXZmekV4rLIBk/uFBrSJv7/7YJsEyr5hqoTahH0hWIoEr6COz/J+0AJV6BzcpwkGOww+DvuMEfLeBJ6GAAaSknqSscwQk+NP5hLnnFsiKqe702vBXwVY3IQuJlUTry7drxICVbBOP7POuEl8ZNpoHJCVjFrLcM8lm6QSFli7e4NOb16NTSXyDHpekx9X8LbwO+1o4eT8c/kIXYG9Bltq1X1Bg/DlHiWXjZcWIYNp3n1XKjVUo6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8pEB0ePq7beg1tasz7Vuf2ExDCzzdeElJK8AQAFhn8=;
 b=GZQpSR1AEA3tSXZPsXuGvVEarw9gdkABhOONuRR/hFKqrkmMp6yUUIv8bYHlfFcMgJVMjVoJBKROQlXmoLMywiJcv2EYics1NsB6FpBoU+eC4Ib5JbDi/Zu+ah55wQd6sR7T36km7u3KlRxi6YKwvRZXmpyEfd3qtKmU3xp+J2xrSkZwV8lWtSgF3/XgHk4WDaplAD762qVDI1ltH85SNmkyzpIgg8uvL+Ox3uqyic6R8o+26DhHvpcrXtEUZ1P3q+bftzylxfwCMZ6V3lZYDVA9p9KAUCQ24UiJQYH4sKYBAF+6EVtts6BNSS303lX4L5AmdfQMBAPfAdRLtz2Gkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8pEB0ePq7beg1tasz7Vuf2ExDCzzdeElJK8AQAFhn8=;
 b=tXYnsL+KfvV9j9N2dW1rp7MDuS1KEDdC44bS7m773hpHLi6n8fUTUCzQG3ol3W5G+jmUePi+HWWYy/P1lx+/dLnvwhkX1ZwWvqs8g2Ra+/mkf9vrkgouJhA+EAZ+db51NRqta5m/u/y8nz1Lcscwl20zGDILkj86+rzbRP5p7cNvLPiauJRWzoSrzJwOazWLhI49hGhMktNrkz0hZRwGRg5gS9GFiSSjU+dvUfG3J+m/wFCo7G/z3xiDfJclr4D5XZ/0DZ6AVfMQ4gc6FtD6Wy7irDE00//hNrD4tM8sBXaRG2TfbzqPAWC5TcDi2YryQM4dKeVWwz72cmQMdi1aNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PAXPR08MB6478.eurprd08.prod.outlook.com
 (2603:10a6:102:159::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.42; Fri, 9 Feb
 2024 12:29:38 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::567e:e2db:3928:5839]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::567e:e2db:3928:5839%7]) with mapi id 15.20.7270.024; Fri, 9 Feb 2024
 12:29:38 +0000
Message-ID: <fd599353-5d83-46c7-938f-c5ff30c4b647@virtuozzo.com>
Date: Fri, 9 Feb 2024 13:29:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] blockcommit: Reopen base image as RO after abort
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, 
 jsnow@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
References: <20240130091440.2346274-1-alexander.ivanov@virtuozzo.com>
In-Reply-To: <20240130091440.2346274-1-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0039.eurprd09.prod.outlook.com
 (2603:10a6:802:1::28) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PAXPR08MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a8f6a3-e720-4a3f-a697-08dc296ac800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvNpQAW9w0ioTzFdjgGhQO30LArYypoyL/iRRWlokWl9sNH/wlTMnMvD23n6+2WwBA+EKQqyrv/C2eFLl04XuczYyN6057LwBODFTjYydIS8UEsos/FhYr40h0RubPlzn0YAfmIvXlmToygSGoSlAqWNeCWHCk0Sh9sgKU7s21KUDxwF2QyQo2ncww/oUfxd8EgG7T5NqccKxQijNMKrAza1NdU/XennFvYn0aont7JXLGn7apVaU/Qe6SUWIHuUu5n5KEIQjlyn/0Cni11K6g6LqM4jNwqBNi4FrQ9vPM5ugE92vv5Ek0CF26ZLpuUM8GFQfqi9gFFFO4GrTDTIt+1twmuWpb93wZT9HyzgBvTTyl2s0D/TDuG+lZOVmBuEFQOobg+m3KqIhuUbRbQ4VZUzDfz5riRpKBYYqcUZxCMfLIG5pa+tG5BAOVmBEqPZyeZyyF5Y2dFTqZZ5sdrXHbuBPOdD91qgk+sVawz8Wjk/RkqXbHTdpERLtSXWrLqi4IfO5FO5aWqoAPVwfEJ6i5uN5oefGBmDzmc1gWUUrgCopiEat6WWGNgotQboddM4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(39850400004)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(66556008)(6512007)(6486002)(478600001)(31686004)(41300700001)(2906002)(4326008)(8676002)(8936002)(5660300002)(44832011)(66476007)(66946007)(53546011)(6506007)(6916009)(6666004)(316002)(2616005)(83380400001)(31696002)(38100700002)(86362001)(36756003)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTEwSUxLUlRDTjYrWGVnaHB5eXdkYVZ1a1U3R1dLMUhvUGNSSlNDYW9ZZVc3?=
 =?utf-8?B?MGVlYWNjVzBIK0hncC95NytkRU5HQ3RVWHRFNHFWcnh2L0orTkFpMkJtL2Fu?=
 =?utf-8?B?UytqYklVdnJUcG5ENGs1cG10b2YvYVM4dUFhK0N2NkRxcDVSRU5QYXdIMHV2?=
 =?utf-8?B?S01xUzRTSHV6WkdIdmNyNlZlVUhXRWgxcUt6QmZkSk1uNHE2K25kWVRGbWhq?=
 =?utf-8?B?WkFkVU9NUVlrMlJGbFlCZkVISGFJaE9ybmVWR3plUXVxeUYrSXFPZ3NpcXpM?=
 =?utf-8?B?MzF6YmRTWExNc1ZIcmZRQWF3SkRrSE45N3lGTERtQU1tYkJvQ2diS0NGUHJG?=
 =?utf-8?B?NUlyaTNLVUJnUzRFZE52TmJTbDRNaGtTSzNHeDUrY2Y2amFZM3NmQnFPR2Y2?=
 =?utf-8?B?ZEV2U1lJSTdlakNIaWEzNDBUNmViT2NVbHlhV1NyNGdKVU5FclVKMFM4L1ZL?=
 =?utf-8?B?RUtYS0JUSlZjZ1k5aXc5bGRtelhnYjFmL3NHRndsdzVaaTA0M0FFM3psOThU?=
 =?utf-8?B?ckFHNVBHcWxobUpGMTJ6V1Y1NGp5TjBtT2hFWE9ZenhkR2JvOWtQS1orTkl3?=
 =?utf-8?B?eGJsbzJIZEYvaXJqeTdHdEdENlZyOXZ6dTJnc0dBOVM4eHRBMGplTHNhOU5S?=
 =?utf-8?B?T1VZQXpoaTN5eEpqUWEvY3gydnQvUzVHOWt3VmIzTURSV25OV3Y3aThHeExY?=
 =?utf-8?B?cE9Ya2xNdmJnUGRvOGtWMzBlbnJxMUZhWGZWR250aVpsUVI1V05JV1FMMEdM?=
 =?utf-8?B?anpKSlEyaHhORUVBQ2lVTVMzUW5sd2cxQnp5eHg5RTNaZlpmcHdjK0RjRCt2?=
 =?utf-8?B?NDdiNHFRR3RwZHZRQTdVVXJvdVpySE8yYWdJcUlTWUZSSm5PUWhteURQVHFH?=
 =?utf-8?B?U1RWVlJJckNZRG9yazNTMmh3RnlLWEVXcVZybUtvZko5ak83ejgweUFwVWVx?=
 =?utf-8?B?Vy9NVC8wYkpsZTBjbUFlekgrWERrZkwyTXhTYXJGTzM1U0MwTVhNS3I0V0k2?=
 =?utf-8?B?MlFJd1hxNmg5N01GWURtOE1ld0ZlZ1ZWeVFMeUthRk1BMzZjUnZqRlN6QXZ4?=
 =?utf-8?B?STdKZ0MwQU15UTl6cUlBNWF2alJlNFRlV29LS05PWngvREQ0QWJiVU45Y1FX?=
 =?utf-8?B?UHdhQ0NwdlhpMXNFbFlLTkFHM3YveVNIcUNVVXgyclU1STkyOXdZY1l6aWRC?=
 =?utf-8?B?WWJoVWJTeUE1S1VmZWkxWk5kOW9YNWdJMG83NWRxWkptdzV3V0VVQXg3bDZy?=
 =?utf-8?B?UGxUa3NEUEZKVGlmaGdia2Njazhkb1lCZE9LcG95N3hqVHVoeHFITW9RL2Ri?=
 =?utf-8?B?a3F6MFlYNGFITHNGblZVczJpOUM2OEhObTh0SVJ6VkFVUDJKQUJ6azlWdWZr?=
 =?utf-8?B?MHd3Z3A4V2c1OVYxaGpjNTQ3bUhRcFlnZFpHQktXK0VxbGthTnIwZTA5UWtn?=
 =?utf-8?B?NlBaQ3pJUGZOUTNsRWpkNkxMNzY2TkVwRENHb1pJSGVxS3J1MlhVbkZIZlps?=
 =?utf-8?B?cStnbVZqRVc1UnJsTzRUQjRmaXhwRlorcHhkVlJiUnpQVUhJOXJkZzhBSmFU?=
 =?utf-8?B?Ujc2UXdUTkllcW5hcEpoV0JOaTkvZi8rM0FQT2tvS0VtbmZ4V2tPN3JmSkVW?=
 =?utf-8?B?cjFUSjk3RHdlcVJLcmFUUEhqY05jUWFCK0NLVXZmRXlWbE5EWmVYdjlyMmhE?=
 =?utf-8?B?aG9LcWRDMUNFVWdtRThRQ1U1VWFVcHJMUFluVzhXcDZ1bUp1NmtwQ3J0Y1ky?=
 =?utf-8?B?YjNQQU5XYkVleUE4ODR1M0hYVlBaQXBMeGhaYkc5Q0VwTlp1UHFrT2dHSkJE?=
 =?utf-8?B?RE1YdmRhVjdNVUVzWlZGZXlTZFFiTFBHK1hpMnJMN0JWaXY4Z3R5WEFhY0xk?=
 =?utf-8?B?TVFiUi90N2kyWnkvd3Z3YWVjRENMQUk4OWgyMmE1THZTZFF3eW81ZTZ6dHNV?=
 =?utf-8?B?aTNzY0tJemxFWFNLNnpXTGhqYWNEWkc4enIzTUtwQ2JmVm5XMnYxWDZneGp0?=
 =?utf-8?B?STMyM2JzK3IzTjVtU3orRXRud0pRbzNERWo3T05VWVRETzNmOHBqZ285NjZJ?=
 =?utf-8?B?Y1pNMHkyMlJHemQxdENoQlUreHlkckNOcE5YcTQ1M2NiSVJ4OFRxMFg1dUxE?=
 =?utf-8?B?dUgwZlVQT2hQK1M0MEF3Z1Q1Q3ZSSHIwc2ozekVPd3JXZ2Zobkw2N0hlRzVi?=
 =?utf-8?Q?CNSv9DkkPXLi+fSjInnHtLs=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a8f6a3-e720-4a3f-a697-08dc296ac800
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 12:29:38.0144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwVAPwDlAcy5zr2zg4f2HSEHMlfTGq3+doQiYC0NaunPPI8Gio+8f5fS1wZDbTBTxpDYOJx7uSvP9jOefnh42UTj75JCim2r4pNTvMN9UCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6478
Received-SPF: pass client-ip=2a01:111:f400:fe0c::71f;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Could you please review the patch?

On 1/30/24 10:14, Alexander Ivanov wrote:
> If a blockcommit is aborted the base image remains in RW mode, that leads
> to a fail of subsequent live migration.
>
> How to reproduce:
>    $ virsh snapshot-create-as vm snp1 --disk-only
>
>    *** write something to the disk inside the guest ***
>
>    $ virsh blockcommit vm vda --active --shallow && virsh blockjob vm vda --abort
>    $ lsof /vzt/vm.qcow2
>    COMMAND      PID USER   FD   TYPE DEVICE   SIZE/OFF NODE NAME
>    qemu-syst 433203 root   45u   REG  253,0 1724776448  133 /vzt/vm.qcow2
>    $ cat /proc/433203/fdinfo/45
>    pos:    0
>    flags:  02140002 <==== The last 2 means RW mode
>
> If the base image is in RW mode at the end of blockcommit and was in RO
> mode before blockcommit, check if src BDS has refcnt > 1. If so, the BDS
> will not be removed after blockcommit, and we should make the base image
> RO. Otherwise check recursively if there is a parent BDS of src BDS and
> reopen the base BDS in RO in this case.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/mirror.c | 38 ++++++++++++++++++++++++++++++++++++--
>   1 file changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/block/mirror.c b/block/mirror.c
> index 5145eb53e1..52a7fee75e 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -93,6 +93,7 @@ typedef struct MirrorBlockJob {
>       int64_t active_write_bytes_in_flight;
>       bool prepared;
>       bool in_drain;
> +    bool base_ro;
>   } MirrorBlockJob;
>   
>   typedef struct MirrorBDSOpaque {
> @@ -652,6 +653,32 @@ static void coroutine_fn mirror_wait_for_all_io(MirrorBlockJob *s)
>       }
>   }
>   
> +/*
> + * Check recursively if there is a parent BDS referenced more than
> + * min_refcnt times. This argument is needed because at the first
> + * call there is a bds referenced in blockcommit.
> + */
> +static bool bdrv_chain_has_significant_parent(BlockDriverState *bs)
> +{
> +    BdrvChild *parent;
> +    BlockDriverState *parent_bs;
> +
> +    QLIST_FOREACH(parent, &bs->parents, next) {
> +        if (!(parent->klass->parent_is_bds)) {
> +            continue;
> +        }
> +        parent_bs = parent->opaque;
> +        if (parent_bs->drv && !parent_bs->drv->is_filter) {
> +            return true;
> +        }
> +        if (bdrv_chain_has_significant_parent(parent_bs)) {
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
>   /**
>    * mirror_exit_common: handle both abort() and prepare() cases.
>    * for .prepare, returns 0 on success and -errno on failure.
> @@ -793,6 +820,11 @@ static int mirror_exit_common(Job *job)
>       bdrv_drained_end(target_bs);
>       bdrv_unref(target_bs);
>   
> +    if (s->base_ro && !bdrv_is_read_only(target_bs) &&
> +        (src->refcnt > 1 || bdrv_chain_has_significant_parent(src))) {
> +        bdrv_reopen_set_read_only(target_bs, true, NULL);
> +    }
> +
>       bs_opaque->job = NULL;
>   
>       bdrv_drained_end(src);
> @@ -1715,6 +1747,7 @@ static BlockJob *mirror_start_job(
>                                bool is_none_mode, BlockDriverState *base,
>                                bool auto_complete, const char *filter_node_name,
>                                bool is_mirror, MirrorCopyMode copy_mode,
> +                             bool base_ro,
>                                Error **errp)
>   {
>       MirrorBlockJob *s;
> @@ -1798,6 +1831,7 @@ static BlockJob *mirror_start_job(
>       bdrv_unref(mirror_top_bs);
>   
>       s->mirror_top_bs = mirror_top_bs;
> +    s->base_ro = base_ro;
>   
>       /* No resize for the target either; while the mirror is still running, a
>        * consistent read isn't necessarily possible. We could possibly allow
> @@ -2027,7 +2061,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
>                        speed, granularity, buf_size, backing_mode, zero_target,
>                        on_source_error, on_target_error, unmap, NULL, NULL,
>                        &mirror_job_driver, is_none_mode, base, false,
> -                     filter_node_name, true, copy_mode, errp);
> +                     filter_node_name, true, copy_mode, false, errp);
>   }
>   
>   BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
> @@ -2056,7 +2090,7 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
>                        on_error, on_error, true, cb, opaque,
>                        &commit_active_job_driver, false, base, auto_complete,
>                        filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
> -                     errp);
> +                     base_read_only, errp);
>       if (!job) {
>           goto error_restore_flags;
>       }

-- 
Best regards,
Alexander Ivanov


