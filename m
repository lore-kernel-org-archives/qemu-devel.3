Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14888C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6knP-00015X-JF; Wed, 16 Sep 2026 04:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x6knM-00014e-Fe
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x6knK-0008Q2-31
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789546505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8fMe9Jw0nIYSn5JyfmTiJxbYnroBwvI8qcUZyMCznWA=;
 b=I785ECrHThemOBFU6pz4StgRJ66ew/S5PiThA0D5v+oekbR9QQEr4P2d5I00shUMQKzj6U
 8O58Rwg+smKVIrN1tFZpoUmWiFA4fwuMqr7onv25aUEC6gWrwKXauvsJLaVpY5WrvDFCI4
 6gf9FtaN7VJGd9h5gxc2bjKFFemsnpM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-vimHiaARP4GG9MWLbtTQHw-1; Wed, 16 Sep 2026 04:15:03 -0400
X-MC-Unique: vimHiaARP4GG9MWLbtTQHw-1
X-Mimecast-MFC-AGG-ID: vimHiaARP4GG9MWLbtTQHw_1789546503
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-486f1ecf9bbso1160031f8f.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 01:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789546502; x=1790151302; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8fMe9Jw0nIYSn5JyfmTiJxbYnroBwvI8qcUZyMCznWA=;
 b=CZJ7K86bPtmNURMygniDwJIdHQIjZ0LEAdB711feSnIE1J9k0COqAJVRHSqD+62hnP
 OsxRBfTKfp5h3ilrcFeGjxP+53ZKklvePb7Abxl7o8ToYx54q/fY8n/3ThZ/abYoS6VC
 5VUuzH/FkrZ+TpvUQTtb8MPIZO46Tbbjt2muUlyV+WrLhjTBWLBkm5Ao43heEpruoZgq
 INe4F7r+/OHbdcXRERw0Jk20jkzHeBgOUqYBRiQMxhX8da9gkD6FUYH3vjfdYtbUOoni
 cppP2b0bNTBF6qEUxoDUXsrZpWnxjp7EEvdXRrDZ9foSTVlsEI++PCTkvrWBB2+luSYK
 hE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789546502; x=1790151302;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8fMe9Jw0nIYSn5JyfmTiJxbYnroBwvI8qcUZyMCznWA=;
 b=XcHCXGEYr23UY5v0Zyw7wuc7hNwnq9NT8Z/zQTcE4mNX1rf3NJxgexgyyItJ48lch5
 4miuDlE6zFFQ9BQtxuEYzldLpIOVx8iUTanouxbvsgGGkarBBtx0duZ7CtuWaLRC0BpB
 Mi96h70YbjgVd5ri6CMI5CHVEgtZKVOQGPiSyafWLCOLNkZ7llaaT62C3Rt05TQFbPpq
 ARictvcyON6Jb0saL6IDJeFBDicNFdQf28OfLa+jgteZKvbOy7ovVblHVIQT/5lig9p0
 bFHnwrO01zFSk3Q7Gew2jDv9Q4PQUKscv9GoX+S8BDuVMP8hAZFD3l/D1RYEur8dNYYF
 OCUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBygIKO/I15BTaGErVNrnbED663U7UhElBBr7QVbpRKYCyI0RMhSHVaMuOf6PbAui6/Y8SGR3XllzGep@nongnu.org
X-Gm-Message-State: AFuF++nQsa3fYW5SKD399TTa7Nw3+cbXaE9iUF7ohLmLXMmux9O3TaBV
 McQ8+6x7OEtKPYKUfBK0teykoawlT6Qqcmyyjdq5c1kR3NKQBX1+0ykZxLZyPzaMRDMGtoyG6nx
 CypCyZp6/xPZm4yF3Cv4GVYluB12iekSMQf7gR1gmelyyVQ4SDwXvzP05
X-Gm-Gg: AYBFou2jkQyBrTWmAlgXytVFeTMLIlBR7MVqVr9KP+jlegbHCDKmdH3E0TYsZegDYxZ
 CUd9+XZsfu4nHt5Px0efQdCDpK6K55xfUSirlIuxurjl3JDgefVPFH0OBQxzuGVK5yOjv29sd9w
 zyEkvj7RBPx3d0lo2MCHDe4s8PgomORnG/wY2E8dp//AGDfDYgfPAQqQ8bBirIZRO6OenfSh9tH
 ygvwyTevyE4fuMhrCl4MPianyIMZtFGg1BzYtXpyi/EW0pHPxEZo8SwqPhfdGsIVylPPGDM0Cw5
 qUFxfXkj2kN5X5tYfv/Z9Gftx5CAJJAOZETLvt4Imj/DoMgq3q8rzakuJZ/NLduuFVfQzyNy6R3
 aM0FvqSrNN2ZEdSPc1O2xQtGAv6huzdUz0w2b6Cnluf7DdIhXKg/zMxENWpr+VQfdzW3PBZgZ+X
 kVac7SeydpwWR3hH4QkHJY6vI7LO8=
X-Received: by 2002:a05:6000:22c5:b0:487:981:4e05 with SMTP id
 ffacd0b85a97d-4870d269cc8mr2373163f8f.32.1789546502356; 
 Wed, 16 Sep 2026 01:15:02 -0700 (PDT)
X-Received: by 2002:a05:6000:22c5:b0:487:981:4e05 with SMTP id
 ffacd0b85a97d-4870d269cc8mr2373124f8f.32.1789546501889; 
 Wed, 16 Sep 2026 01:15:01 -0700 (PDT)
Received: from ?IPV6:2003:cf:d704:f6c1:9398:5dbc:cc8:753b?
 (p200300cfd704f6c193985dbc0cc8753b.dip0.t-ipconnect.de.
 [2003:cf:d704:f6c1:9398:5dbc:cc8:753b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf27a41sm5109323f8f.18.2026.09.16.01.15.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 01:15:01 -0700 (PDT)
Message-ID: <28da45c4-51ce-452c-b7d7-a18b68d2dd1e@redhat.com>
Date: Wed, 16 Sep 2026 10:14:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] block/accounting: Emit BLOCK_IO_DELAY event
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-7-hreitz@redhat.com> <20260903142359.GD825275@fedora>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260903142359.GD825275@fedora>
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

On 03.09.26 16:23, Stefan Hajnoczi wrote:
> On Mon, Aug 31, 2026 at 03:52:02PM +0200, Hanna Czenczek wrote:
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
> I think this patch series already couples the accounting so closely with
> BlockBackend (i.e. adding the offset field into the cookie struct and
> adding a BB pointer into the stats struct) that we might as well fully
> integrate the two. Then callers don't need to manually manage cookies
> because BlockBackend does that internally and the concerns about
> lifetimes go away.

I don’t follow how integrating them into BlockBackend automatically 
solves the problem.

Are you suggesting that blk_* I/O functions should do the accounting 
instead of the device emulation code?

>> So, for now, just implement the simpler solution of only notifying the
>> management layer when the request does complete, so VMs with high
>> latency spikes can at least be identified when they happen without
>> having to regularly check the latency histogram.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
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
> There are a few names for the same thing:
> - delay_threshold_ns
> - alert_ns
> - BLOCK_IO_DELAY
>
> Pick one and use it consistently?

Sure.

Hanna

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
>> +
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
>> +
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
>> diff --git a/blockdev.c b/blockdev.c
>> index 6e86c6262f9..195bac8af01 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -618,7 +618,7 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
>>           bs->detect_zeroes = detect_zeroes;
>>   
>>           block_acct_setup(blk_get_stats(blk), account_invalid, account_failed,
>> -                         NULL, 0, NULL);
>> +                         NULL, 0, 0, NULL);
>>   
>>           if (!parse_stats_intervals(blk_get_stats(blk), interval_list, errp)) {
>>               blk_unref(blk);
>> diff --git a/hw/block/block.c b/hw/block/block.c
>> index f187fa025d0..19301c6f995 100644
>> --- a/hw/block/block.c
>> +++ b/hw/block/block.c
>> @@ -251,7 +251,7 @@ bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
>>   
>>       if (!block_acct_setup(blk_get_stats(blk), conf->account_invalid,
>>                             conf->account_failed, conf->stats_intervals,
>> -                          conf->num_stats_intervals, errp)) {
>> +                          conf->num_stats_intervals, 0, errp)) {
>>           return false;
>>       }
>>       return true;
>> -- 
>> 2.55.0
>>


