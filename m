Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF88CC5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAxE-0005dr-TA; Wed, 12 Aug 2026 11:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wuAxD-0005cp-65; Wed, 12 Aug 2026 11:33:19 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wuAwS-00046H-Hm; Wed, 12 Aug 2026 11:33:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6rsxt7W22LDY3VhVkJbcmOXqUK/LlO2DvptkQ3TmX9yFkpbq5dVJkmh1e5I+7waOZ1kXO2+Z1jJwrXAdpOeGBFpAvGCnA0kf2Dzm/F5fE+NwGaLqj6zR0csqBjbqiYBoTODOerHhNm+Ra57MYytIvxO9IYVsqZZLTbLSK0/54pILx6sQYBsztxfkXFmhROmuViOg+6QQS9JSJUoaEfMD1EAezvYrsFiKDPAzRQunhAgYCynZ6Tn2imY5jcaVep4lih70vRkuKowbVZ5zyQQeud7xFBed+4+bQ9n36bC/GHQgJWGRAVQJULAFQpAR7b+IQmZBAoMKjq7fASMqgVz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5etyWA7RDfXihVOtH8jC0gCBq0Ew1Hz1DauVldISkg=;
 b=EGFd/OVqKr5ISj4CpJKXi7dYX6A+1CAI015FgQLQdRalo8VEWm/a/F7ADIejQVmjfXWwrkIstMHJ2b9SATjAAZrp8RjJ2ygAj/zC2F7cVZuBzTS7Pq3yrcv/20nMMZLYLFom8tweFLBvIXOmT2xX8ry/rbBAtQSNs1XO2CdJXJaop0PYC3vnmjZZ1A6kT1WQHw+d3oe/wYRxRQAT4AMVZBlrunXxlkuMre/1lrLS25PSY8K/+f2dhld9VN8WrLuLKBMYLN0boFvhwsGs2csPRdQfFlhO6sJsehZhd0lrpi8zgfrlU4TkxICSZmQUykhuxb+2b1UezbZiztqkt4a0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5etyWA7RDfXihVOtH8jC0gCBq0Ew1Hz1DauVldISkg=;
 b=joT+3XGcU6azJkWUDyTSJBt5DCutdUGHfmXZqj7ODfow4tY4+sQAQTekbRWujcjHUlcxRy9f8exnBRuBqG4N3Rkru7yhBsBoVtYF8EUvcBmOa8nbZl0W1AywaAjSJi9+E8W7LtlYOaSx0cRTlMne9JdmSLQn7YEGjQo6fRp+l91cZ2kcMxKvJtQGGrcU8FJLp+erA4HRrcPKUJIv+4VS9xVfgSHJpVCYTE+Wa95RdmbeFpiDydxY+WUjBYHjB6rvtKLLhWqHi7ng+vQ7GFhGvvn/IjuN++uloPwSFvy+cRLy4EINTR2iN7UdL3bA0P5aePIp0DtQz9fMgmKNeSZfTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7)
 by PAWPR08MB11558.eurprd08.prod.outlook.com (2603:10a6:102:509::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 15:32:25 +0000
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c]) by DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c%5]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 15:32:25 +0000
Message-ID: <269bb712-7acd-4389-ace1-380bfb35be79@virtuozzo.com>
Date: Wed, 12 Aug 2026 18:32:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] qcow2: do not clear the dirty bit when reopening a
 read-only node
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org
References: <20260811154213.184947-1-den@openvz.org>
 <20260811154213.184947-2-den@openvz.org>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260811154213.184947-2-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::15) To DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10650:EE_|PAWPR08MB11558:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8a0111-7e0f-4b22-c555-08def886e8f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|10067099003|22082099003|6133799003|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: mteq+N51A92C7SKTLSrlhEAEHW/VkLig+dE70twNdS0pHl5LdWYH+M6fR2z3DtisC7SNSOiXuKgd7G4VBhu1gDKAwniab/9vgc8iBs7VmFp/nBOCnWpjIkjDdUNdnNwEvUykYRYQFSuC7jvdyBZkkGB4OMgpmWBeHtQuei1l5T/We7QlMLIAL4KdzNQzkvSleWYTrZSA5HvqMkhSV3znBtnOM9+YkQXTdY+ssoIR8FVbTbrWYH9aOCv93468YS82+5vaX2QU5CtdRvi+b+i6qUkcjQbJDOscyZKnZM7PTOH2Ep2is2ilmPJP+xq8Ji+d2zxNqJKHBkMNX3qPeluIdoOcx8UkSOiRo5fq57VxmarIFT71D/0D4gyU3sl8DW4//rAufJ8orcCHqd23WnEpgjymoGy55xGDY6zsQfTFFUWw3+gMywKkNF4KBbfVY5RwYE8Jv2I70Z8c9iAPSNJbVncTJcPoX+M7gZDy/p/tZGbqsznHQ5YPRr5KvQyKj83eeui9ajha4F/Rn/3xprUq+hrIRkJs4voW9ZHSRrIuToAKMsrzwUOOQO5bTPIg0W67EaWTqETRP/u2HIH1YgWNfp6e2wqxNf2yOrgmI4001WRDwC3Q76UfAg2Dhe8fMuR1o54MCxZglfsEw81kubRFiFRczak7elZPROJ/G7LIq1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10650.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(22082099003)(6133799003)(4143699003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWhZRXN0ZnIrUHlqTmNlNmhYZDRQZzlLcnVpcldabTc5TERVR1cxMjBXZHU5?=
 =?utf-8?B?SDZPZXduOCtaSHNvdXVPaDlRSXJSZkVDY1hSVExsRzNGeXk3aU0zLzUza1hV?=
 =?utf-8?B?c2ZlRnU3amsvdVovQXQ4MlJWdzRjSXV6SjFLZWI0Y2I4V1RaWmw2NDE3VzJp?=
 =?utf-8?B?YUlzL0RLb0dqOWM2dW95SUZlOXRDNWRaR0ROaHJnU0ZDN0FrQkZ1ZjNCamNy?=
 =?utf-8?B?RmVSYitwbmtJeWlqRWJyS05UY0I0UlBrZGdOSHBMbHkzUy9paHAydkxhTTZK?=
 =?utf-8?B?bVoweDFjakdaekkwS2JNS256b0Fwc0s4Z0gyZEVIYS8xZVgyckpTUU80Q1FX?=
 =?utf-8?B?Tm9aZ1dUUUsrNEhTSTVpazJGM0YybjNaM3U0OFEvMm9ScGgxWit5bDZraEVE?=
 =?utf-8?B?VzIrajU1Q0ZzQVVDNE1nYjJVV3QyM3YveWQwa2JUWVpYTktKM28wSm9xdGtP?=
 =?utf-8?B?aW9Hakl6Um9DRlVDdmVVcko5cnVncGhybk1KdFJ1NVpqbDhHaHNWYXhRbm0w?=
 =?utf-8?B?NEpEVG1Cb05ndkt6Vmdpc25IeElTOVJLKzduMVpOMHdiUHZOTFppVnFtMEZy?=
 =?utf-8?B?M3Q3aElMQ1lHVXhqeWp4YTNENGpsVmp3dXZFNzhEbFBDc3QwRmdIS0hYdm5F?=
 =?utf-8?B?Wm9mSzgrcHpZZDZ5VEoxUzUvOWJIb1N5OEYwMTZGSEQyUVlGNjE4cFNhaGtJ?=
 =?utf-8?B?N2MxcTVTZTVYMUNTU29mdWR6Tk52MVUrZWZ3bU03QnMva2ZCQThQV1B3RFdR?=
 =?utf-8?B?U2xJS3EyTGpxcFl1Rkk5a25YWXJZMHQyaGl1bU5MMkdWT3dYK3crdzhQMFdt?=
 =?utf-8?B?dkdKaCtPRFUvdjFkYVBuMGlFZm5pUGNZdW1rVVdVQUw3b0pNejJQQ2pFaDRY?=
 =?utf-8?B?TmdDQlR2Zm90NlBXVTczdnB4TXFuYUZZY0lsL2srWXZuRkdtZkpHQmxiWThC?=
 =?utf-8?B?bmwySWFST0h0cnpZbkhhZ2Q0MUR3eGQzVUY2ZVgraVBucW9KajR6LytnRS9r?=
 =?utf-8?B?SmhSNjJTanZHcGZHWG5mb3JLT043Y0YzWlJUOVVZb05yYk9yQldEM3pPSWRS?=
 =?utf-8?B?TmcxT1JNcHFNcjhwRVhDWXRFYlg4OGhKdWFtSkNrUkd1YkM2WkpEaGx3RGth?=
 =?utf-8?B?SmdienI1Qm1VUGpwNGVRbWhzV1JibnVHRUw0QVQzOW9GMW5XandtU2ptbm1r?=
 =?utf-8?B?R2JMY081WUd4SW5xeGgxcEw3MzJpMGwxeGNVRmVEcCsyMkFrQjM1YksrNmN6?=
 =?utf-8?B?QnNOU01od1JIa2p0bDZIbzlNZmhJbTFpeDdPa0JQUlRMMHdLZmtqckJSTlUw?=
 =?utf-8?B?TElRaVE4clZvU2lLYXQ2Q2xGQ25wTEoweVl2ZnB2bjZMVUxtQUFNTzU5Q0dk?=
 =?utf-8?B?MVFhSEtUTTJFc3MyeHV1S0FPWGJLVXBvQ3dPQTkyV3ZkeHNjejdNU2lMZVBn?=
 =?utf-8?B?Qzc4M3VFZjlUeWNSWG5QMWxyT01RSmxDdjVnb0R6ZS9rTXVLUVVBMVYzSnU0?=
 =?utf-8?B?UnhrcDVuQm1NeTJIbzgyWmZTdjBhSkErT1RvM3d0cm5SZGxHdkdqYkY2VFZ6?=
 =?utf-8?B?VlNWb0lRd2d5ZmRkN1l2TnlVdG5tNU11Sy9QMnU3aXJlQnJNNkFYTDgrY2NJ?=
 =?utf-8?B?VFB1eVFBeUUzSmlJWDdDVjZRUTRWVzAvTUhUZjhscSs4MmYvYmNJVFE3TDBo?=
 =?utf-8?B?RGVLUjV3d2M2VTFpYTJmcHVtME53VFJ3d3dCYm80aUNMNmdPNmNmVEovNnNF?=
 =?utf-8?B?WmQrQ2R2RFY2SE1Ybk1PaXBsb1hsc3puemU2SkdNa0ZiaktQbjJOTGtUbG5E?=
 =?utf-8?B?SlJDVlU3djhSclYwTWtDdFlNSUxrazgvQkorWGZySEYvdDRqOHpaRStxdUJH?=
 =?utf-8?B?RTdRN3Q4R1k3U3p2dWJMSjJUTmVqNTFwVUZKUTYzWnZhREwrQ25iaHorU3JY?=
 =?utf-8?B?eitON0VVN0g4YkFNdmU0UmJDU2ErbXRmRm9jd1U4V1BZanpTRmtxbklKcUFm?=
 =?utf-8?B?WS9GWnA2T0JEUStrbmtkWURWVDFHTDVGTHMxSUtxQXliQS9wclRjRlFQbXUr?=
 =?utf-8?B?aDNaNEF5VFIyOHpVUlVTRzlQNUkrblNvWUo1Zi9nNTUwU2J4RGVWMEtvLzAy?=
 =?utf-8?B?R29ZeDZueTBNQ3k4WlRMUHFmdnY2Y0RzMHVoZmpsUnlac1hEYmhXTHpjSXh5?=
 =?utf-8?B?RVZJeXpkSG8yUU8remo1QWI1Tnl5R1J6VDRtRkVDbHN2a2FDUTZGdExKMXhN?=
 =?utf-8?B?MkdSbGV4bGZQZDViM0R2dGlZMWsxbTRtcWpxb0VjNWloYkl6dFFuQWlSZ1lU?=
 =?utf-8?B?WEQxSU9JSzA1aWpVdlRpWHgydjlzbmhrcFh6S2RoRzJ3UmJOWktvUERTUHNP?=
 =?utf-8?Q?tSPB8Nqt0KJiVx5g=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8a0111-7e0f-4b22-c555-08def886e8f4
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 15:32:25.2226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tJkAdsa2C+oygdF6XV32tOOc6ESC6FgVa2S1wHUAw6gLVJnt2H41e4KMfyTGG2+Qnm21kkD53aJa3i8QIFiOJye5b0fS6B6gUF4v+dPfkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11558
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

On 8/11/26 6:42 PM, Denis V. Lunev wrote:
> qcow2_reopen_prepare() clears the dirty bit whenever the node is
> reopened read-only, with an unguarded header write. A read-only node
> can still be dirty, inherited from an earlier writable session, and it
> holds no BLK_PERM_WRITE to resolve that. A read-only to read-only
> reopen of a dirty image therefore fails outright:
> 
>   $ qemu-io -r -f qcow2 dirty.qcow2 <<< $'reopen -r\nquit'
>   qemu-io: failed while preparing to reopen image 'dirty.qcow2'
> 
> Clear it only for a node that is writable now, the predicate
> qcow2_do_open() already uses for the repair. bdrv_is_writable() also
> excludes an inactive node, whose header must not be touched either.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Cc: qemu-stable@nongnu.org
> ---
>  block/qcow2.c              |  8 +++++---
>  tests/qemu-iotests/039     | 10 ++++++++++
>  tests/qemu-iotests/039.out |  5 +++++
>  3 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 7292dd036c..1543255eba 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2102,9 +2102,11 @@ qcow2_reopen_prepare(BDRVReopenState *state,BlockReopenQueue *queue,
>              goto fail;
>          }
>  
> -        ret = qcow2_mark_clean(state->bs);
> -        if (ret < 0) {
> -            goto fail;
> +        if (bdrv_is_writable(state->bs)) {
> +            ret = qcow2_mark_clean(state->bs);
> +            if (ret < 0) {
> +                goto fail;
> +            }
>          }
>      }
>  
> diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
> index 94a8bfe754..db52c580d1 100755
> --- a/tests/qemu-iotests/039
> +++ b/tests/qemu-iotests/039
> @@ -95,6 +95,16 @@ $QEMU_IMG info --image-opts \
>  # The dirty bit must still be set: this open never wrote any guest data
>  _qcow2_dump_header | grep incompatible_features
>  
> +echo
> +echo "== Read-only reopen must not clear the dirty bit =="
> +
> +# A read-only node cannot write the header, and must keep the dirty bit
> +$QEMU_IO -r -c "reopen -r" -c "read -P 0x5a 0 512" "$TEST_IMG" \
> +    | _filter_qemu_io
> +
> +# The dirty bit must still be set
> +_qcow2_dump_header | grep incompatible_features
> +
>  echo
>  echo "== Repairing the image file must succeed =="
>  
> diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
> index c66361128f..3c71e5a3dd 100644
> --- a/tests/qemu-iotests/039.out
> +++ b/tests/qemu-iotests/039.out
> @@ -27,6 +27,11 @@ incompatible_features     [0]
>  == Read-only open must not crash on close ==
>  incompatible_features     [0]
>  
> +== Read-only reopen must not clear the dirty bit ==
> +read 512/512 bytes at offset 0
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +incompatible_features     [0]
> +
>  == Repairing the image file must succeed ==
>  ERROR cluster 5 refcount=0 reference=1
>  Rebuilding refcount structure

bdrv_is_writable() checks pre-reopen state.  So IMHO it'd also be nice
to check RW->RO reopen and that it does clear the dirty bit.  Smth like:

> _make_test_img -o "compat=1.1,lazy_refcounts=on" $size
> $QEMU_IO -c "write -P 0x5a 0 512" -c "reopen -r" "$TEST_IMG" | _filter_qemu_io
> _qcow2_dump_header | grep incompatible_features

A write operation with lazy refcounts must set dirty bit.  And upon
RW->RO reopen the dirty bit must be cleared.

Still, with or without this case covered:

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

