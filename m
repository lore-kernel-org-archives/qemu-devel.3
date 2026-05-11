Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B1BCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 21:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMYZ6-00069j-LP; Mon, 11 May 2026 17:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wMYZ2-00066q-Vr; Mon, 11 May 2026 17:53:26 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wMYYz-0004PH-9R; Mon, 11 May 2026 17:53:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgHsLJH+aDpH2igCG90jgEg81ut53BoZJ1rtE42NTPmy7TVMoy53Oz/TvS1fHASYLTTkY4GgCZ105cBlg+NAZKKmvhkFDlABY5dTmJWfSfPimxR5+mVsyZUs1zkQa3XKi1AZR4dldu321WOXcdO5PWg/zRR2/ZiqwT7cPFusgHftT/qK6ESn2vSPAIsMqKB1UTecSv+PLew5gDenlp00xIhZ+PqOcSwOUEfNAseDoeV0fdHXEWHE9HoI0JJbVLQtom7RiBZOc3MwKkSKierAJo1wf9VbPwEajzEv7S/wQJmCaHiKiY9/YZGW3j0qO1VCKq0e6JT4cjGGFGzMWZD5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDR2bXIP9D80TwKvGExqgJcR4VMsfOZgzivKcTIhk+k=;
 b=JyfdOFhF0ru7BxUxDVx+6JBqownSr7MDqpcJlAict7GOhcZjwSEdHrgWodDR3gCxh3xQYjiA94d+Zr/ajLuY2bKX+9r/K828wbxlTWu0TKgoDsVQp8PeJqVQoQI/D3U7lYZfD2R523XZzh+o/elY0PWqllUrkcbN4DcLVp5KlGfFap3WlnlAOfcEMg+Sj636tF5Fx57r4eykC5QPaUSFGpz87AqIVuCBTOHcEj7oKlcRPFQiw1+vb5/Xv82nt69bPsvtjrcjMSEIRMiBQiagZ91UTc/Rv7+f4UhdcvndMOqVbrGzhI5WrzVfhnnjZA8IjC7Bud9bw0HT2tyiwfavNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDR2bXIP9D80TwKvGExqgJcR4VMsfOZgzivKcTIhk+k=;
 b=N0jUmhQ7KkR896+pC81NIy7MuWTfkBqRLS62TTT+tWZT8cdNXHnGsoc8nWO2zsmRl4TGNERtZAsRqEwEi0H3t6oH05IzKjJovj5jg5xnj5wYTmAs39WHQA5Wshb9xHoAfgq/EuEOuNaKF9q2V6Z3SdUclsAUNmdcZw7chDGuJvDQ/6z6PXJFyx673razcGw+AzrMjr5QfkjziSPJ0wif8rBQGka++fzJXTpXn6IoZtoV3zsNrb92sLxVwy0g6n023R7uFyG7L+WMzOlhpY9SbaUefYtCMgIoovyH9afxAJZeKh4abc0qeVy0R8BxhV5vC92a8T7o77wKjejlFkLtZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PA4PR08MB6160.eurprd08.prod.outlook.com (2603:10a6:102:e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 11 May
 2026 21:53:14 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%4]) with mapi id 15.20.9913.009; Mon, 11 May 2026
 21:53:14 +0000
Message-ID: <11911eb1-9917-4ff9-adcc-f339246e2ff8@virtuozzo.com>
Date: Mon, 11 May 2026 23:53:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] qemu-img: add sub-command --remove-all to
 'qemu-img bitmap'
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
References: <20260424105949.254757-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260424105949.254757-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0089.eurprd04.prod.outlook.com
 (2603:10a6:803:64::24) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PA4PR08MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d84970-1786-481e-57f4-08deafa7b36c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|22082099003|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: kGXjWCZBqIXUKz0UzT+q6WkCcNzULde5ttW1LmonBVR1MUIspbVZq4N/YGzxNTBR1cGs9EDEvwMsD++ZcUzMi4U2YYEtsoWRTE2mI/lWaBBztlVimQufIa8h4KSpa0FJ/Lb9IrvqbpjcpYsqL3CMR8A8PrAs/jCA+sPQhGs0Rxpbyzt+eC4olqgI3+t9pkPIUTcFHnBB9Ys4WxZH9mXwXaaMbL0BxJnzFF6K/8/nz4paih4OG1tUkNk8MBQ6EPOewu8Ehcr9zd60tSlGrGYp9AQx41Y8i1rdjkIvtS6Ve99QJvFpRLy7WVIN54Xtie4QdZUni1hdoog5gRsXWbKrxZLxUJPvHRzluRXFA7q7hxn9tsHzUf+QfsgcCt3cuEJKQovQ5L4DutFrtvclw/toUGeUlB0gz169TFm509Zi0Q4ARVouNNnRwcdoL2OMGFhbTz91PttJ8biKkFRW9ce1oglWxYsjTCCNElVbmOaAd33MY+1JFcYi5z5MtonX/5ujQyBbSxqCGR+Dw6bX2zesxdnA2mppIztcRdSL4HI7BJUeCrzslnES1zTJU8lDhzfB+rrYvhU/pkKzTMuQMAAkAwEb6adEkGrrz8AOS7YMQ3HfplMIb31shW/ihssLfoE1uwcOHn2H9gODC1KN4VXAAiH/Yd9fR6Y624OTkW05hRCfTuvM690yVtGsbEwZwrqY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(22082099003)(56012099003)(18002099003)(3023799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk9mdDNTaVBrckNFR0d0eFM3WkRIZVlZQmtBUGFBQXU5dXpJWmFOOVlrc0Vq?=
 =?utf-8?B?aTNiLyswMnVEUCtFNG5Jc0Z6djJzSW1FNFErODh2QnBZdytQd2lzOWJobDUz?=
 =?utf-8?B?bDFTbkhDejc3N2dGbVJIN0JHdWc1dm1zK1Eyd0h5TVNXRHp1RDJUUnJ4UzdE?=
 =?utf-8?B?ZFRwVU1rNkg4WFBKV3hiU0kzSDRzOWhXZTZSOEhHa2I5aU5hMUhoWHlVeUV5?=
 =?utf-8?B?S3MzR2xHdVNXR3l5d3lBOEpvWnhibkdwR3p4TUpJZ3pBRjNOTFFRaW1tSDd0?=
 =?utf-8?B?V0RNNTZjaDg2NXZ6YUFZZE9hUmJGenN4dU9sQWtMS3I4dVU1Sndqa3ZoVXpU?=
 =?utf-8?B?aUU3YzVQMk55cExvQndjdDJQSzZNMUJiMVc0L0hJL3cxNzF6ZFU4R1FzMjh5?=
 =?utf-8?B?ZHhGdEFLaElhdkNKU0JwUVZvQm9xdlducENFNURWeFJpN3pxb1lnd2JheURr?=
 =?utf-8?B?VENiMFMyeWRIUXFmYTdMNkgzMHdrSnhxZjlhNlhyWVVnNWNYdkV5aXM5RFdz?=
 =?utf-8?B?ZmNpSUdrM0M5TGFMekxGMzdPTU5LKy92T003NkxQNGFsVnJDemE4dU1yeG8w?=
 =?utf-8?B?Z3MrbWp3TWNZakErczFwOVNUV205OVh5eTlIMHpvaTZLbU9EaklwZFRDS1dJ?=
 =?utf-8?B?UURFQUhWc2h1NDhtQVhidUQyOE43bzZFTENucklBM2lYWlROMHJPditHYlpp?=
 =?utf-8?B?dUhRUjdiVHFWcHNQQXpmWjh3L1VxdlV3WmtuL0VQYjlKYnhIVm52YkJ2UTMz?=
 =?utf-8?B?YUFoZEI5WUxvZ3Q5YkZ6UE9lV3d4LzBvT3ZWUkt1Y2pmbmpaY1UzS1MydU55?=
 =?utf-8?B?NkhkVXNYNkZGanZ3RVdvWmNjK1NIVnNtbmN1VkJ5ODEwSkpLaGsvVFJNQkdY?=
 =?utf-8?B?dDhqR2J1THVKSm9UUlY5S2lBOC8xcGY0T2JqSXQxbDJ3UVNIemY5V3RrdE1Y?=
 =?utf-8?B?dm9DSUlSM2V1bVpZMnRHTW9uVGJ1N3BjNXZCVW13SFBSSmVId1FtNnVzcVEy?=
 =?utf-8?B?NExNQ0pxN3pHSGwvaUxaNnZlakYvZURJT2o0c1pJK0Q3YzllSjZoU3VzNEJy?=
 =?utf-8?B?OFVDN3BQUGRnWG1QaUxhUWpMYjc2bHY5eWozNW5zckdXMzUyODhPWURVL3F0?=
 =?utf-8?B?VmVmVGQ0RzNISHlkb2NOT0sreHYrRm45RzNIS2VobGdyN2sySUY5dXA5aTBu?=
 =?utf-8?B?aDEvNmtOcGo5bzdOVmRxM1d4MU8rWExQcjArRitzaXJzZWtpQStYbit1RERR?=
 =?utf-8?B?aEJOYkRIZmhyVVg4aHhodmpNNG01MDgwZXp4akZGVU1UYWMvRkNUN2J2Q0ow?=
 =?utf-8?B?Nm9SZnpjbnhxc2haZTRhUThVWW05bzZzNkNybTVPWnVPcndrUlpxbCtIcGdP?=
 =?utf-8?B?UCtJOGxLOWxBNXpsbzVIblR2QTZWRTVmZTVzUHdNdC9mTjl1V3RxSTJxdDla?=
 =?utf-8?B?UndoVEErak9FWWhUS2ljZVNmQkhxYVB2ckI0VDdXS29VMGYxRnRNTDZJNElO?=
 =?utf-8?B?bm9sbGJIS2JjcU41bllBcSt4Q1VWYzYxSHg3anZFbzNEK3dyOXYrK1RiMjl3?=
 =?utf-8?B?aStGNkZ4djh2WHRiWVVQUXpxdzhQVDlKZzJwR09TRzEvTWMramZoN3hjK24y?=
 =?utf-8?B?WkprU3V3M3IyTnN5cWVGdU5rSzBzblUrTEp0eDNhOEdVSmk0dVRpU0pKOWg1?=
 =?utf-8?B?elI3d25lc25RL3FqeGZQRjNHZW96Y3htUWdzWWxQRVBnWVdTWWcxNmhPQUll?=
 =?utf-8?B?cGUxcDlnUEhFbFg5eEYxcFJ6U0Z1MzF2QVBNc01aemR6dHVHb29Na0ZpWnVh?=
 =?utf-8?B?bnhiQ0d1WUJTOHYvcVJmcU82Y0MzV2xEa1Y1NlZ2ai9XM3dxeHBHQ05KcVlF?=
 =?utf-8?B?bERVVllxSTl1eHpmSVhpVEJyTk1YQjZVWmZSUUxmdDRrNlM0N2FkbklGK1Bm?=
 =?utf-8?B?SXZ4OEx4UnJldEk0d0pDL2V6SE54NWdUZ2FmcloxRVJaSzlQZUVlUDg1U3RF?=
 =?utf-8?B?MDByS2YzQ3ZFeExuNnYvTHNWWG1MdjZQdW9UMFB6cm1idlJuclQ0TVVWbkFy?=
 =?utf-8?B?SmFRcitHaEFQUW12TXYxbGlBbVRlTjZnRmcwNDhqZm1abCtJRXRLQVR5aDR4?=
 =?utf-8?B?V0RUZExnSlhVRkVZVll5bktZd3NHVTVWNkdmKzkrVlkrVFpzUWgvR2lCS010?=
 =?utf-8?B?V2NOYUhqZTFVWnFFRk53Y084Qjh0U0N1b2liZXVMQ1VLNnVBYnRJRGgwMHp2?=
 =?utf-8?B?U2Z2SnUxc21BRHNpODF0dTdMYjM1Y3ZIYkZnTTFwSkdTUjJPZG1HTWNaVGdp?=
 =?utf-8?B?YnNHc3VSalpNRnRDTjFWbDBXSW40ODhmYk92UFFTdmRucCtLOEVuMWcwNGQy?=
 =?utf-8?Q?tJUkIyn2R+xhlB3szyztzt4UPjbZIDpBNAqczsiHh20M4?=
X-MS-Exchange-AntiSpam-MessageData-1: n8GsQeXOI1uyOg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d84970-1786-481e-57f4-08deafa7b36c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 21:53:14.1315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OqK5E0z7xS2AA2aeS2FaeCn94mKiBNBkz8L1Q7yVys1xVThOurRZZcft4lK3ZpcOutcm9B62gXp048JMxn1yWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6160
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=den@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 4/24/26 12:59, Denis V. Lunev wrote:
> From time to time it is needed to remove all bitmaps from the image.
> Before this patch the process is not very convenient. One should
> perform
>     qemu-img info
> and parse the output to obtain all names. After that one should
> sequentially call
>     qemu-img bitmap --remove
> for each present bitmap.
>
> The patch adds --remove-all sub-command to 'qemu-img bitmap'.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> ---
> Changes from v2:
> * rebased to the lastest head
>
> Changes from v1:
> * rebased to latest head
> * adopted bitmap help to the new layout
>
>  docs/tools/qemu-img.rst | 10 +++++---
>  qemu-img.c              | 53 ++++++++++++++++++++++++++++++++++-------
>  2 files changed, 52 insertions(+), 11 deletions(-)
>
> diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
> index 558b0eb84d..b0c798b77a 100644
> --- a/docs/tools/qemu-img.rst
> +++ b/docs/tools/qemu-img.rst
> @@ -301,15 +301,19 @@ Command description:
>    For write tests, by default a buffer filled with zeros is written. This can be
>    overridden with a pattern byte specified by *PATTERN*.
>  
> -.. option:: bitmap (--merge SOURCE | --add | --remove | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME BITMAP
> +.. option:: bitmap (--merge SOURCE | --add | --remove | --remove-all | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME [BITMAP]
>  
> -  Perform one or more modifications of the persistent bitmap *BITMAP*
> -  in the disk image *FILENAME*.  The various modifications are:
> +  Perform one or more modifications of persistent bitmaps in the disk
> +  image *FILENAME*.  Most operations require *BITMAP* to be specified;
> +  ``--remove-all`` operates on all bitmaps and does not take *BITMAP*.
> +  The various modifications are:
>  
>    ``--add`` to create *BITMAP*, enabled to record future edits.
>  
>    ``--remove`` to remove *BITMAP*.
>  
> +  ``--remove-all`` to remove all bitmaps.
> +
>    ``--clear`` to clear *BITMAP*.
>  
>    ``--enable`` to change *BITMAP* to start recording future edits.
> diff --git a/qemu-img.c b/qemu-img.c
> index c42dd4e995..22ddc7a627 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -87,6 +87,7 @@ enum {
>      OPTION_FORCE = 276,
>      OPTION_SKIP_BROKEN = 277,
>      OPTION_LIMITS = 278,
> +    OPTION_REMOVE_ALL = 279,
>  };
>  
>  typedef enum OutputFormat {
> @@ -5018,6 +5019,7 @@ enum ImgBitmapAct {
>      BITMAP_ENABLE,
>      BITMAP_DISABLE,
>      BITMAP_MERGE,
> +    BITMAP_REMOVE_ALL,
>  };
>  typedef struct ImgBitmapAction {
>      enum ImgBitmapAct act;
> @@ -5036,7 +5038,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>      BlockDriverState *bs = NULL, *src_bs = NULL;
>      bool image_opts = false;
>      int64_t granularity = 0;
> -    bool add = false, merge = false;
> +    bool add = false, merge = false, remove_all = false, any = false;
>      QSIMPLEQ_HEAD(, ImgBitmapAction) actions;
>      ImgBitmapAction *act, *act_next;
>      const char *op;
> @@ -5052,6 +5054,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>              {"add", no_argument, 0, OPTION_ADD},
>              {"granularity", required_argument, 0, 'g'},
>              {"remove", no_argument, 0, OPTION_REMOVE},
> +            {"remove-all", no_argument, 0, OPTION_REMOVE_ALL},
>              {"clear", no_argument, 0, OPTION_CLEAR},
>              {"enable", no_argument, 0, OPTION_ENABLE},
>              {"disable", no_argument, 0, OPTION_DISABLE},
> @@ -5070,8 +5073,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>          switch (c) {
>          case 'h':
>              cmd_help(ccmd, "[-f FMT | --image-opts]\n"
> -"        ( --add [-g SIZE] | --remove | --clear | --enable | --disable |\n"
> -"          --merge SOURCE [-b SRC_FILE [-F SRC_FMT]] )..\n"
> +"        ( --add [-g SIZE] | --remove | --remove-all | --clear | --enable |\n"
> +"          --disable | --merge SOURCE [-b SRC_FILE [-F SRC_FMT]] )..\n"
>  "        [--object OBJDEF] FILE BITMAP\n"
>  ,
>  "  -f, --format FMT\n"
> @@ -5086,6 +5089,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>  "     with optional multiplier suffix (in powers of 1024)\n"
>  "  --remove\n"
>  "     removes BITMAP from FILE\n"
> +"  --remove-all\n"
> +"     removes all bitmaps from FILE\n"
>  "  --clear\n"
>  "     clears BITMAP in FILE\n"
>  "  --enable, --disable\n"
> @@ -5115,7 +5120,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>              act = g_new0(ImgBitmapAction, 1);
>              act->act = BITMAP_ADD;
>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> -            add = true;
> +            add = any = true;
>              break;
>          case 'g':
>              granularity = cvtnum("granularity", optarg, true);
> @@ -5127,28 +5132,38 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>              act = g_new0(ImgBitmapAction, 1);
>              act->act = BITMAP_REMOVE;
>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            any = true;
> +            break;
> +        case OPTION_REMOVE_ALL:
> +            act = g_new0(ImgBitmapAction, 1);
> +            act->act = BITMAP_REMOVE_ALL;
> +            QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            remove_all = true;
>              break;
>          case OPTION_CLEAR:
>              act = g_new0(ImgBitmapAction, 1);
>              act->act = BITMAP_CLEAR;
>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            any = true;
>              break;
>          case OPTION_ENABLE:
>              act = g_new0(ImgBitmapAction, 1);
>              act->act = BITMAP_ENABLE;
>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            any = true;
>              break;
>          case OPTION_DISABLE:
>              act = g_new0(ImgBitmapAction, 1);
>              act->act = BITMAP_DISABLE;
>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            any = true;
>              break;
>          case OPTION_MERGE:
>              act = g_new0(ImgBitmapAction, 1);
>              act->act = BITMAP_MERGE;
>              act->src = optarg;
>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> -            merge = true;
> +            any = merge = true;
>              break;
>          case 'b':
>              src_filename = optarg;
> @@ -5165,8 +5180,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>      }
>  
>      if (QSIMPLEQ_EMPTY(&actions)) {
> -        error_report("Need at least one of --add, --remove, --clear, "
> -                     "--enable, --disable, or --merge");
> +        error_report("Need at least one of --add, --remove, --remove-all, "
> +                     "--clear, --enable, --disable, or --merge");
>          goto out;
>      }
>  
> @@ -5184,10 +5199,14 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>          goto out;
>      }
>  
> -    if (optind != argc - 2) {
> +    if (any && optind != argc - 2) {
>          error_report("Expecting filename and bitmap name");
>          goto out;
>      }
> +    if (!any && remove_all && optind != argc - 1) {
> +        error_report("Expecting filename");
> +        goto out;
> +    }
>  
>      filename = argv[optind];
>      bitmap = argv[optind + 1];
> @@ -5225,6 +5244,24 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>              qmp_block_dirty_bitmap_remove(bs->node_name, bitmap, &err);
>              op = "remove";
>              break;
> +        case BITMAP_REMOVE_ALL: {
> +            while (1) {
> +                const char *name;
> +                BdrvDirtyBitmap *bm = bdrv_dirty_bitmap_first(bs);
> +                if (bm == NULL) {
> +                    break;
> +                }
> +                name = bdrv_dirty_bitmap_name(bm);
> +                qmp_block_dirty_bitmap_remove(bs->node_name, name, &err);
> +                if (err) {
> +                    /* Save name for proper error reporting */
> +                    bitmap = name;
> +                    break;
> +                }
> +            }
> +            op = "remove-all";
> +            break;
> +        }
>          case BITMAP_CLEAR:
>              qmp_block_dirty_bitmap_clear(bs->node_name, bitmap, &err);
>              op = "clear";
ping

