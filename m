Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C231C48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 08:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZS2g-00045w-G3; Mon, 12 Feb 2024 03:51:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rZS2f-00045b-5N
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:51:57 -0500
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2009::600]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rZS2d-0007IQ-BD
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:51:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZj30Uf1mhNIm+cXpgkXCUxSplR9wnpJY5Q+dGx3YPYeBt+Pn856vY9dJH0fBsPlGvBHDQI9aVDkFoQsbfdXGCuJSyTNGbtwEA7iz/xDtPKNjizG8VssMRPwBeO5ku77vlnq2b8JwQP/Zue4teC/heF1ha/vJiAQZxg7iuBFEvLXPFYD99i7ulAxpDXZPhyuq7Y1ItH/3MaRxug+m0t1UU2F5Fg3WO4DbawQOdSyycwkqnugQcRLL1FIdE2WYW3AfmtlRrCCb2mQKA6I2UQFs8tPjPInUrdiNDUtvlCSIKKKfZL7GpVBe9oZFAtewttlvrjxFSQdH4NEksnL9Gy8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DO3EW49qmO4JrT59DCCytwxhArji3ruUuugYWt+FL3w=;
 b=BZFoBexy06xEUjLB2EXXWG+pfD/xe0ZD7scDtgl6rju6sNeUyg/XofP1Uy1YxKhRaFlhaKOW5zIAqi3iBrjWav2BRYOO623GssVSBtcH3ew0qyhYR2ZTm1OOLfXin7Kk+KnvkkDguElsy99ahapR9KDanTJD45VE4+iz2/JR8R4Gwl4v4rztXez+ZcBNraF6oTwJaJyw3rOk1SgiAHULlz3spUCCXc/X7Qf5oFWME4miFSHPX4MI0WQvn9bu8qk9jgd4PR29olswgdIx/cxdYPX7sN+0BjjcCMyvDs98uCGwIOnQ78q4H5DZixASnrNyPrtwKvHVXoX16sVjNYBvLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DO3EW49qmO4JrT59DCCytwxhArji3ruUuugYWt+FL3w=;
 b=Bba7szfT7Cv5S5/rEz+kAa10BjfvEEmT42MDLon+dTd4upFOg2WQZ8HHJYNn1T3l1IJgR2U63dkGmdmgmv7dj8/jrESlcieyrZw8FPyvOq3zOZ6iIiWRvU9E3S1YmPV5Zez6+2/LXuFFZ7ns/wA261kdlgK7fj2yZDGVHcBXUP46eOKmtENzDrDgnb4R5YcSEOHY76vcfcOSpKpnEjdPfmE9ntmRR/sFRcZ0lUd0I6ur7FqZ3vbK6WVByfTw6EYKec/lvyI7MDNfO3odSYCOZPmoQB9SJ7Dj5c2ekITevPUmnocLT+5XI6r/MlXvbsN2FotPJSALC8cEHwOIFfCFYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CH3PR12MB8306.namprd12.prod.outlook.com (2603:10b6:610:12c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.18; Mon, 12 Feb
 2024 08:51:51 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7292.022; Mon, 12 Feb 2024
 08:51:51 +0000
Message-ID: <9e8d8479-7202-417f-a3e2-3ed3cebda423@nvidia.com>
Date: Mon, 12 Feb 2024 10:51:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] migration: Modify ram_init_bitmaps() to report
 dirty tracking errors
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-5-clg@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240207133347.1115903-5-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CH3PR12MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ac5ab8-bd7a-4c07-584e-08dc2ba7daa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFxSKFIkPSsBAvnyR+m0kb6YFJJWjcnBHFKkgbt8HcYPahWnjiPCwFiyA9Az4dS//ESjh+ez2w/ZZi7mX0zcVqBpWMH6TtjY2GZrp4wj5Icdyfbbwj76UANLADyEJlc9taI/jeC/+UbkJ3jfpGeaRDLg4wmVWGYv8rYHTN9gpA5pILgs24P2779s78bsGQk3sXLwxyfcNI3zo+eqp+IIWq9w8d9tMuGDM1V7m4UAblPpcWT68hm1eaX72dHRiqwuXEGdJh8jKt1f2C1HPPVgTbWi7zKqMDlA+dmAv7gGr6EX9LcQao8Tk7mAKGXLZbJJZ0UMJu/mwvf87FH4e4nqeqXPqzA1CDSsHXiN/OrEUZpTYp+rrqsG1Ebel6eqKB7JICe1XbeToc0j9qsMViP52OaG6TmuwhenTiAvVvRMaJJwL2L8NDL/mvw3t2SOp0F7IHgB4KUUTunwIZVUT1CnIl1dwJJBkZcQaepPTvQDuE2zF3b2XqjfS2c7rIS5ddLqrd5P6RCyL6FFpq2U6pOgOw3PvejsOoHCqB8lUfX+irRkIsZCCo6mezM8VPax58p+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230273577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(36756003)(31686004)(41300700001)(316002)(2906002)(478600001)(6486002)(66556008)(54906003)(66476007)(66946007)(4326008)(8936002)(8676002)(31696002)(86362001)(38100700002)(26005)(83380400001)(66574015)(5660300002)(6666004)(2616005)(6512007)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVR0cFcrMkpBc3V4WUpPRW9kcXhkN2FCTjVCRk1GL05MdEdqT2h6YTNuVk9y?=
 =?utf-8?B?UjJsWEpvWmk4akxJUHRFaU83aWJBME4ydEdvZG5SdEo4QUhac1lDdHRBbkg2?=
 =?utf-8?B?Q0R3NlREUHk5bXZzWlhENkhQemQ0OFhTa01KSzRvQzF1cnZVVFVOR1RSZWhJ?=
 =?utf-8?B?SCtna0ljNVNBdGd6WDJzdlNwSm03K1Rwd2dwOTZhL0VsMFdEVjlxSWRlRTdC?=
 =?utf-8?B?ZXRMK3dORjhka2V5NndIOVA3bHlZckN2UE1ocmdxU3BmTlFRTm1icW5Zc2Za?=
 =?utf-8?B?Q0dWWXllcFgzVmxvK0pWWEhZODdVNDI1Q0E3MWVUNzhadmxrRlVQWjQ5c2dz?=
 =?utf-8?B?VTh6VEx3V3dwRDRNVmlSM3ZBblZBTDhpdnpBc29ydWpOTmRuU0hFaXdoUjJi?=
 =?utf-8?B?TDQ3b1QxemFtNno5Z0xIdzRHaEl1NnlxazhibE4yblhsclVscFdIbElMT0NF?=
 =?utf-8?B?Nk81NS9oSlljOTgzbStiMFE2eUZGekczcW9JWS9waXExTVg5RWxHR0RSQlR5?=
 =?utf-8?B?aWVmNHhyRGtiWFJHNUk4cC80MSs4bGtxNG9TVklQaklJM3dJQkpnYkFtaVJ0?=
 =?utf-8?B?bDFSZnl5aW40L0lWOVpQTTJ3dWZVczZsdnA5cVBvZlpYVFdreVlBV1pQYTRw?=
 =?utf-8?B?VmxzRjhOc2J4VmZMY3VyUjlsV1c3KzRBbWNNL09QdkhXemxqNnN4SkV6bGVq?=
 =?utf-8?B?ZUZXZjFGeTNTMDVGQk9ZN1pNTEVOQmFsQU5jdzFjckdtSFdGUm5IYWpKQ0lJ?=
 =?utf-8?B?RVZ0eDVRbUhNMEFEQVRkeENYVnRFbUFiSmZsdlUzbVI3dEU3RHRPbWFIYnkv?=
 =?utf-8?B?ZXc3QUZNSlNHdWFRUU5Dd056TzhPcEgwSHdzL2JZVVJxMHRKL2cvbUZaWjAw?=
 =?utf-8?B?Q21icGs2d1BJZ3hJcER6cDg5bzJQNVhBblR1cTFqTmI5eXorbktMNW1BWm5Y?=
 =?utf-8?B?YTUwN3VmOEZrcmJudzh0LzFKNWF0VitZQ2RGK2Z5VmFzRlRRUkl6K2NnZVJi?=
 =?utf-8?B?M2VBZ25tcHlwbXRZTERVbm90ZlBHc2Iway9OdjhYN0piTnZuWFlNeTVTNy9N?=
 =?utf-8?B?VUFkbW80bXkzMjIyak8wNzRtTmJTVXFabVQ5NURiYjdid0FwTEFHRk1LYUFx?=
 =?utf-8?B?cHJTVFBnWnNkekQ4d2RCQUtGRzRzM0xxZnUrcnVSUDFxQXo4Rmx0YlprNXp6?=
 =?utf-8?B?UUhNVkRBbXk1TDJKZDJaUkV4dkZNT014eDZHeU1hZ2U4MTlqMVA2Rms4Tzkx?=
 =?utf-8?B?bkJqYjgrTzBqVURDOEVRM2hUYWhFbVhtZnI2dTNCREw0SW55enBaT2s3WHMr?=
 =?utf-8?B?bTlzaDdqbGNqTHJORm44cllEc2wyT2pIV3hzZ2ZvU2hsUmZlTDllbnV6NjA2?=
 =?utf-8?B?RU1VakdSMW5UbFBHQ0M4bloxZVdZMEg1ZzU3Q1VZZ1FRL2UwZ3RuSGpQQ0Vx?=
 =?utf-8?B?eFJTdmR3dmx2eVpZRDNCR3BPUGtxb2FURmdYNk9qRWJTWG4yOHhEMFk0YXBC?=
 =?utf-8?B?YXdxYkpuZm5Vc0xuWjhxeVkyMkNWaURDMFVqTlJBaEZKUytGaFhWQzBGRS81?=
 =?utf-8?B?ZlhjRjhpNjEwZEFpZDRjS29QWGg5YzVCYVRUaDk3OHdnVXk1ckt6Uk5xZGRl?=
 =?utf-8?B?OGtia1crbGxmck9Hem4zZE90R3hKVlRlMi8xRGRuTUtKZXJhT0dwUW02Ull4?=
 =?utf-8?B?bHNjTGJlYlZEWFhwT3l5VEZHYUlDVG5lZWY3SHpWZVBuTWFtUGJSMlREWGFk?=
 =?utf-8?B?K0dCc2dlSUptTjd1TVNvZ2RaM2V1T2h0MTg5cW4vNm1ST3BLVE1OeGVPbDgv?=
 =?utf-8?B?WFdVVjJ2a3dJSi8xOUFmOTZCbEZaRUd4K01aa0VrYWsreFhpejFENXhUKytq?=
 =?utf-8?B?NkpjWEVqWmxOUmFuOU9JQXEydEdvM2tsZlVlRTFpTzQ2NTczTXdaU3BsRldJ?=
 =?utf-8?B?Ykk3SmtvL2RmVVIyWTYveDl3U0J4TW1IU1Qwd1pBTHpFekl6ODdGQXRBS0o3?=
 =?utf-8?B?SnRxRVpDTStMcU9zdkJ4L2FNM3pwZTQ1eVZyUFlVNUYwR3JqalhyV1A1MWth?=
 =?utf-8?B?U1dMcFM1MFlRdFVaZUZvOHhyUXRJaldoblZvV3Fadi9jZzVPNmFtdkJNQmtP?=
 =?utf-8?Q?ONmkOdFB9tlg+FhvQmKyG2bpS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ac5ab8-bd7a-4c07-584e-08dc2ba7daa8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 08:51:51.0647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/Ut2sJOLMaVdS6akA8HkOkkNIkUtg92cjeRvdQzI56nd0tlNSOJEwDh1/E1jh0LUoHHJsBY1H+kxoO5NkIC2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306
Received-SPF: softfail client-ip=2a01:111:f403:2009::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hi Cedric,

On 07/02/2024 15:33, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> The .save_setup() handler has now an Error** argument that we can use
> to propagate errors reported by the .log_global_start() handler. Do
> that for the RAM. qemu_savevm_state_setup() will store the error under
> the migration stream for later detection in the migration sequence.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   migration/ram.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index d86626bb1c704b2d3497b323a702ca6ca8939a79..b87245466bb46937fd0358d0c66432bcc6280018 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2802,19 +2802,17 @@ static void migration_bitmap_clear_discarded_pages(RAMState *rs)
>       }
>   }
>
> -static void ram_init_bitmaps(RAMState *rs)
> +static void ram_init_bitmaps(RAMState *rs, Error **errp)
>   {
> -    Error *local_err = NULL;
> -
>       qemu_mutex_lock_ramlist();
>
>       WITH_RCU_READ_LOCK_GUARD() {
>           ram_list_init_bitmaps();
>           /* We don't use dirty log with background snapshots */
>           if (!migrate_background_snapshot()) {
> -            memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, &local_err);
> -            if (local_err) {
> -                error_report_err(local_err);
> +            memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, errp);
> +            if (*errp) {

I think we should use ERRP_GUARD() or a local error here and also below 
at ram_init_bitmaps() (or return bool like Philippe suggested).

Thanks.

> +                break;
>               }
>               migration_bitmap_sync_precopy(rs, false);
>           }
> @@ -2828,7 +2826,7 @@ static void ram_init_bitmaps(RAMState *rs)
>       migration_bitmap_clear_discarded_pages(rs);
>   }
>
> -static int ram_init_all(RAMState **rsp)
> +static int ram_init_all(RAMState **rsp, Error **errp)
>   {
>       if (ram_state_init(rsp)) {
>           return -1;
> @@ -2839,7 +2837,10 @@ static int ram_init_all(RAMState **rsp)
>           return -1;
>       }
>
> -    ram_init_bitmaps(*rsp);
> +    ram_init_bitmaps(*rsp, errp);
> +    if (*errp) {
> +        return -1;
> +    }
>
>       return 0;
>   }
> @@ -2952,7 +2953,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
>
>       /* migration has already setup the bitmap, reuse it. */
>       if (!migration_in_colo_state()) {
> -        if (ram_init_all(rsp) != 0) {
> +        if (ram_init_all(rsp, errp) != 0) {
>               compress_threads_save_cleanup();
>               return -1;
>           }
> --
> 2.43.0
>
>

