Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AEAC982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9KtX-0006OV-0l; Wed, 23 Sep 2026 07:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x9Ksy-0006JH-Eb
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 07:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x9Kst-0006kV-8u
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 07:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790161890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aAOjAbLMGaPpT/mKSm9iJH+rjaejUaHaT45fFTr3rYY=;
 b=HS7Fj10Fi/S4kGoEpnql1yyqGUGu/899FkLldg2lbzkVUR3F8uD3G97Jdt7fB2WdfB/ip8
 ImdeeMiI+ONo3Vm+ZcqHBO179DklHKyA1t1knrH3cvYcq4o8yv9uMr0oeCTPFqgN61kz9s
 iD4np4MyvSd4g4Oxujo+G8BHj6t36g0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-e4hPMrgHN9CFhfHIziYSbg-1; Wed, 23 Sep 2026 07:11:28 -0400
X-MC-Unique: e4hPMrgHN9CFhfHIziYSbg-1
X-Mimecast-MFC-AGG-ID: e4hPMrgHN9CFhfHIziYSbg_1790161887
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4957287363bso5092705e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 04:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790161887; x=1790766687; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aAOjAbLMGaPpT/mKSm9iJH+rjaejUaHaT45fFTr3rYY=;
 b=BxPfzTpJgno+ShNFGXqXjwg6kSCqtv5pWuTxWXD8dvNw2LC1XnKM6f9C72JSjMepvo
 6UBR9zyS1cSkYluTd+GEvCXaHPR77u64Ds9/9zttwTFi+k+z3IYbvvNTmXtDYKDR/ZD/
 57t0sCukzNBwwODbJOFv6iwhB9zqn4ca/KmSY1GckxM7n6Jzf9FU9x11t84h8mmzH03t
 zIFeX92i9tuxwphihpflPelDD7I0fUlFqKqwkVLtUKGb/nJYOKz5md+muADPCTM2zkD4
 tRBTv/YRFaliJCHTfWi5Oj/tHHSSIT2qGyW3kWtJC8JVKkWaq2hoNaG1dIaYvBmhy0nV
 Mgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790161887; x=1790766687;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aAOjAbLMGaPpT/mKSm9iJH+rjaejUaHaT45fFTr3rYY=;
 b=bxrDwLgBrFIjjK0AlfXt+0fIenzkqHb+YKWg9/EU/BZBkybZgFGgrzir1dLEOsKVwJ
 xTqLvEcJklJ+WLwER6+ConK9H997w5LiXrCddfDFkoypvEW6K7yL083pukRR43pMcMVF
 r18ySlKM0W8zXSRdcNmXWWZHP53ZOjXr3OYOCwGX91LweeyYVDBSOrTSnk3P5eY5se/6
 2CuvZ3NIakGBobRzypsf3a/Vw00ZYfqxQqAK4qGmq53UwXZwaA5N7vPSEJ3UuWDoFLmH
 7/qXsh1KmyISycKenGuf7NHXBG8XdjCvd97N66x1gOLSKl2nW8AVSPISLWjKatbBnxCy
 yO+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfEpd3tHAGV2GcMfNqmnNpJ0MBOQcCsI/bzdQfzIFCXyQm6BOX92uva/NeJgPBPXfbnOQ37w/KBMy0@nongnu.org
X-Gm-Message-State: AFuF++kbCp6pC8twxnOaFz1VyYDp1wT1lz6Ypyhgc77rE8ERrgP5TULu
 OiKcdUgPhycrnnsi5I2qkXDK6mVavQGBUulw3wHQqXPaQWl1B1kFUKlt+dRrP6N85NZsA9wgmEh
 /J53aWcNNOzu7Q0qxQu/pQFjI/N2WPE8NrfY6F4e0cR2DIs9VyYyf+eko
X-Gm-Gg: AYBFou2tPTLw9gZoorrs7/X3PXwfycHlxNt6BBS+VXct58QJ4uZR7vmM8zQuqSJurmf
 YoyUU5VcSyGi6CJKwEChUwqsvzr7s6jkhVTt61knXiX1QG+P3mISBZ+2evfbIYncPmBAI76W1kV
 JvdABRfVX9XoEjPWt/7hyrznVP9KfN9iZbauhyERTukV6SwmfKMGsoflFllc6COjWdzMwWutC2s
 O35Y43dCLiSnerHRDrAYVqkWjra0khPueamUtQFtDHElyfqYnE/+rjH+aEy+Y4xspzkJqyH/gZT
 OKpIpgiUI3L0NbDnstB35BK2bmKHvEPDg5U4v+SfGx2qjPQBSHiFRbyu9FvBmByOOf2rRvcqw32
 WAhbKl3+RARDJEeE+ppAb+9FG/r6zOHrDmPQNV01ANoT1836Gkrm9b3j1Y3mlwpDXzc/oC+EIKs
 MRhPbH1Oxm+jVL2OD40pyk91Byc87l9f8w2Qz0Pdkl
X-Received: by 2002:a05:600c:c16d:b0:49c:ff9f:f6b6 with SMTP id
 5b1f17b1804b1-49fdee0b7f2mr28002805e9.6.1790161887137; 
 Wed, 23 Sep 2026 04:11:27 -0700 (PDT)
X-Received: by 2002:a05:600c:c16d:b0:49c:ff9f:f6b6 with SMTP id
 5b1f17b1804b1-49fdee0b7f2mr28002315e9.6.1790161886739; 
 Wed, 23 Sep 2026 04:11:26 -0700 (PDT)
Received: from ?IPV6:2003:cf:d749:526e:3864:2ce3:24f2:e6d4?
 (p200300cfd749526e38642ce324f2e6d4.dip0.t-ipconnect.de.
 [2003:cf:d749:526e:3864:2ce3:24f2:e6d4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde1ccccfsm66358435e9.7.2026.09.23.04.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 04:11:25 -0700 (PDT)
Message-ID: <47928b1a-7bc4-4194-a623-b8113e419dda@redhat.com>
Date: Wed, 23 Sep 2026 13:11:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] block/accounting: Emit BLOCK_IO_DELAY event
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, John Snow
 <jsnow@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-7-hreitz@redhat.com> <arJ4JzSmzTO1GMin@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <arJ4JzSmzTO1GMin@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22.09.26 14:44, Kevin Wolf wrote:
> Am 31.08.2026 um 15:52 hat Hanna Czenczek geschrieben:
>> When a request finishes with a higher latency than a predefined
>> threshold, emit the BLOCK_IO_DELAY event.
>>
>> Note there would be an alternative, more precise solution: We could keep
>> all active cookies per BlockBackend in a list and repeatedly iterate
>> over it in a background coroutine (woken on a timer so it would wake
>> always exactly when the next request would time out, so it generally
>> stays asleep until there is actually a timeout). This way, we could emit
>> the event exactly when a request crosses the delay threshold, while it
>> is still running; and we could hypothetically even take actions like
>> pausing the VM until the request is done so the guest operating system
>> is shielded from extreme latency spikes.
>>
>> In practice, this is very complicated because latency cookies are
>> created and finalized all over the place, so it is very hard to
>> guarantee that every `block_acct_start()` is matched by the right
>> finalization to ensure that cookies are properly removed from the list
>> when they are done. Even if we fix all non-matching places now, there is
>> hardly a guarantee this will be kept in order in the future.
>>
>> So, for now, just implement the simpler solution of only notifying the
>> management layer when the request does complete, so VMs with high
>> latency spikes can at least be identified when they happen without
>> having to regularly check the latency histogram.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> Checking only at request completion for now is fine with me; however,
> the documentation the previous patches added (And possibly their commit
> messages? Not sure any more.) suggests that the event is emitted while
> the request is still in flight. So these description need to change to
> be consistent with the actual behaviour.

I tried being a little bit ambiguous so that behavior could change in 
the future.

But now that you make me think about it, that was a terrible idea. I 
should fix it to reflect the current behavior and explicitly state that 
it might do something else, too, in the future. (*If* we think changing 
behavior is OK, then it should at least be explicit now.)

>>   include/block/accounting.h | 10 ++++++++-
>>   block/accounting.c         | 42 +++++++++++++++++++++++++++++++++++++-
>>   blockdev.c                 |  2 +-
>>   hw/block/block.c           |  2 +-
>>   4 files changed, 52 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/block/accounting.h b/include/block/accounting.h
>> index 025536239e6..ba3a6859cf4 100644
>> --- a/include/block/accounting.h
>> +++ b/include/block/accounting.h
>> @@ -92,6 +92,7 @@ struct BlockAcctStats {
>>       QSLIST_HEAD(, BlockAcctTimedStats) intervals;
>>       bool account_invalid;
>>       bool account_failed;
>> +    int64_t delay_threshold_ns;
> Why signed?

Because block/accounting.c uses int64_t for all latency values (except 
for block_acct_queue_depth()).

>>       BlockLatencyHistogram latency_histogram[BLOCK_MAX_IOTYPE];
>>   };
>>   
>> @@ -103,9 +104,16 @@ typedef struct BlockAcctCookie {
>>   } BlockAcctCookie;
>>   
>>   void block_acct_init(BlockBackend *blk, BlockAcctStats *stats);
>> +/**
>> + * Set up accounting for a block device in @stats.
>> + * @alert_ns specifies a latency so that if any request takes longer than that
>> + * threshold, a BLOCK_IO_DELAY event will be generated (when that request
>> + * completes). Pass 0 to disable.
>> + */
>>   bool block_acct_setup(BlockAcctStats *stats, enum OnOffAuto account_invalid,
>>                         enum OnOffAuto account_failed, uint32_t *stats_intervals,
>> -                      uint32_t num_stats_intervals, Error **errp);
>> +                      uint32_t num_stats_intervals, int64_t alert_ns,
>> +                      Error **errp);
>>   void block_acct_cleanup(BlockAcctStats *stats);
>>   void block_acct_add_interval(BlockAcctStats *stats, unsigned interval_length);
>>   BlockAcctTimedStats *block_acct_interval_next(BlockAcctStats *stats,
>> diff --git a/block/accounting.c b/block/accounting.c
>> index a74551d41f2..debf1924455 100644
>> --- a/block/accounting.c
>> +++ b/block/accounting.c
>> @@ -27,8 +27,10 @@
>>   #include "block/accounting.h"
>>   #include "block/block_int.h"
>>   #include "qemu/timer.h"
>> +#include "system/block-backend.h"
>>   #include "system/qtest.h"
>>   #include "qapi/error.h"
>> +#include "qapi/qapi-events-block.h"
>>   
>>   static QEMUClockType clock_type = QEMU_CLOCK_REALTIME;
>>   static const int qtest_latency_ns = NANOSECONDS_PER_SECOND / 1000;
>> @@ -62,9 +64,35 @@ static bool bool_from_onoffauto(OnOffAuto val, bool def)
>>       }
>>   }
>>   
>> +/**
>> + * Convert a BlockAcctType into its QAPI equivalent IoAccountingOperation.
>> + *
>> + * Must only be called for valid BlockAcctType values, i.e. specifically not for
>> + * `BLOCK_ACCT_NONE`.
>> + */
>> +static IoAccountingOperation block_acct_qapi_type(enum BlockAcctType type)
>> +{
>> +    switch (type) {
>> +    case BLOCK_ACCT_READ:
>> +        return IO_ACCOUNTING_OPERATION_READ;
>> +    case BLOCK_ACCT_WRITE:
>> +        return IO_ACCOUNTING_OPERATION_WRITE;
>> +    case BLOCK_ACCT_FLUSH:
>> +        return IO_ACCOUNTING_OPERATION_FLUSH;
>> +    case BLOCK_ACCT_ZONE_APPEND:
>> +        return IO_ACCOUNTING_OPERATION_ZONE_APPEND;
>> +    case BLOCK_ACCT_UNMAP:
>> +        return IO_ACCOUNTING_OPERATION_UNMAP;
>> +    case BLOCK_ACCT_NONE:
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
> Wouldn't it be nice if QAPI could generate the shorter BlockAcctType
> with BLOCK_ACCT_* on the C side while still keeping the nicer
> IoAccountingOperation name externally? :-)
>
> (Not a request to change it now, but a wishlist item for Markus.)
>
> Though actually BLOCK_ACCT_* seems to already be possible with 'prefix'.
> Maybe we could live with the longer IoAccountingOperation type name
> everywhere and avoid having two separate enums?

Probably.

(If not, then IoAccountingOperation were not doing what it’s supposed to 
be doing.)

I’ll take a look.

>>   bool block_acct_setup(BlockAcctStats *stats, enum OnOffAuto account_invalid,
>>                         enum OnOffAuto account_failed, uint32_t *stats_intervals,
>> -                      uint32_t num_stats_intervals, Error **errp)
>> +                      uint32_t num_stats_intervals, int64_t alert_ns,
>> +                      Error **errp)
>>   {
>>       stats->account_invalid = bool_from_onoffauto(account_invalid,
>>                                                    stats->account_invalid);
>> @@ -79,6 +107,7 @@ bool block_acct_setup(BlockAcctStats *stats, enum OnOffAuto account_invalid,
>>               block_acct_add_interval(stats, stats_intervals[i]);
>>           }
>>       }
>> +    stats->delay_threshold_ns = alert_ns;
>>       return true;
>>   }
>>   
>> @@ -252,6 +281,17 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
>>           return;
>>       }
>>   
>> +    if (stats->delay_threshold_ns && latency_ns > stats->delay_threshold_ns) {
>> +        g_autofree char *dev_path = blk_get_attached_dev_path(stats->blk);
>> +        double latency = latency_ns / (double)NANOSECONDS_PER_SECOND;
> Wouldn't it be both easier and more reliable to just expose an integer
> latency-ns in QAPI? I think all other time related values in the block
> layer interfaces work this way, too.

Yup, noted to use nanoseconds exclusively.

>> +        qapi_event_send_block_io_delay(dev_path,
>> +                                       block_acct_qapi_type(cookie->type),
>> +                                       latency,
>> +                                       cookie->offset >= 0, cookie->offset,
>> +                                       cookie->bytes);
>> +    }
>> +
>>       WITH_QEMU_LOCK_GUARD(&stats->lock) {
>>           if (failed) {
>>               stats->failed_ops[cookie->type]++;
> Kevin
>

Thanks for reviewing!

Hanna


