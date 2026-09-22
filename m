Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392F2C982FF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8zrz-0006mh-7J; Tue, 22 Sep 2026 08:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x8zrx-0006hD-4W
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x8zrv-0002S7-8B
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790081106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J5WwMiSXbyDxffaH8ii7fjxnNPyvu4OwUqcJEgtvzUA=;
 b=Z7W5B6W4K1QIC39BvK1EgHKhWhj4PNYqCZdoUz5qBLSJwxsRFVCWKOVryWILWzI1LK6oQd
 qTW5tCFRrjP11Qi0LAm7gm89voDF9zJ3mv0JaJFOb5pZdopC70t198aT7B6dZecIL58m8O
 lgLU1C9ABRqRNomvAqb0j3Bi0FduvC8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-vElfhrLwPh-LpjYJnhWZuA-1; Tue,
 22 Sep 2026 08:44:59 -0400
X-MC-Unique: vElfhrLwPh-LpjYJnhWZuA-1
X-Mimecast-MFC-AGG-ID: vElfhrLwPh-LpjYJnhWZuA_1790081098
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A7EE18795B9; Tue, 22 Sep 2026 12:44:28 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.148])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64F1A3000225; Tue, 22 Sep 2026 12:44:25 +0000 (UTC)
Date: Tue, 22 Sep 2026 14:44:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 6/9] block/accounting: Emit BLOCK_IO_DELAY event
Message-ID: <arJ4JzSmzTO1GMin@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-7-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831135206.126184-7-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 31.08.2026 um 15:52 hat Hanna Czenczek geschrieben:
> When a request finishes with a higher latency than a predefined
> threshold, emit the BLOCK_IO_DELAY event.
> 
> Note there would be an alternative, more precise solution: We could keep
> all active cookies per BlockBackend in a list and repeatedly iterate
> over it in a background coroutine (woken on a timer so it would wake
> always exactly when the next request would time out, so it generally
> stays asleep until there is actually a timeout). This way, we could emit
> the event exactly when a request crosses the delay threshold, while it
> is still running; and we could hypothetically even take actions like
> pausing the VM until the request is done so the guest operating system
> is shielded from extreme latency spikes.
> 
> In practice, this is very complicated because latency cookies are
> created and finalized all over the place, so it is very hard to
> guarantee that every `block_acct_start()` is matched by the right
> finalization to ensure that cookies are properly removed from the list
> when they are done. Even if we fix all non-matching places now, there is
> hardly a guarantee this will be kept in order in the future.
> 
> So, for now, just implement the simpler solution of only notifying the
> management layer when the request does complete, so VMs with high
> latency spikes can at least be identified when they happen without
> having to regularly check the latency histogram.
> 
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>

Checking only at request completion for now is fine with me; however,
the documentation the previous patches added (And possibly their commit
messages? Not sure any more.) suggests that the event is emitted while
the request is still in flight. So these description need to change to
be consistent with the actual behaviour.

>  include/block/accounting.h | 10 ++++++++-
>  block/accounting.c         | 42 +++++++++++++++++++++++++++++++++++++-
>  blockdev.c                 |  2 +-
>  hw/block/block.c           |  2 +-
>  4 files changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/include/block/accounting.h b/include/block/accounting.h
> index 025536239e6..ba3a6859cf4 100644
> --- a/include/block/accounting.h
> +++ b/include/block/accounting.h
> @@ -92,6 +92,7 @@ struct BlockAcctStats {
>      QSLIST_HEAD(, BlockAcctTimedStats) intervals;
>      bool account_invalid;
>      bool account_failed;
> +    int64_t delay_threshold_ns;

Why signed?

>      BlockLatencyHistogram latency_histogram[BLOCK_MAX_IOTYPE];
>  };
>  
> @@ -103,9 +104,16 @@ typedef struct BlockAcctCookie {
>  } BlockAcctCookie;
>  
>  void block_acct_init(BlockBackend *blk, BlockAcctStats *stats);
> +/**
> + * Set up accounting for a block device in @stats.
> + * @alert_ns specifies a latency so that if any request takes longer than that
> + * threshold, a BLOCK_IO_DELAY event will be generated (when that request
> + * completes). Pass 0 to disable.
> + */
>  bool block_acct_setup(BlockAcctStats *stats, enum OnOffAuto account_invalid,
>                        enum OnOffAuto account_failed, uint32_t *stats_intervals,
> -                      uint32_t num_stats_intervals, Error **errp);
> +                      uint32_t num_stats_intervals, int64_t alert_ns,
> +                      Error **errp);
>  void block_acct_cleanup(BlockAcctStats *stats);
>  void block_acct_add_interval(BlockAcctStats *stats, unsigned interval_length);
>  BlockAcctTimedStats *block_acct_interval_next(BlockAcctStats *stats,
> diff --git a/block/accounting.c b/block/accounting.c
> index a74551d41f2..debf1924455 100644
> --- a/block/accounting.c
> +++ b/block/accounting.c
> @@ -27,8 +27,10 @@
>  #include "block/accounting.h"
>  #include "block/block_int.h"
>  #include "qemu/timer.h"
> +#include "system/block-backend.h"
>  #include "system/qtest.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-events-block.h"
>  
>  static QEMUClockType clock_type = QEMU_CLOCK_REALTIME;
>  static const int qtest_latency_ns = NANOSECONDS_PER_SECOND / 1000;
> @@ -62,9 +64,35 @@ static bool bool_from_onoffauto(OnOffAuto val, bool def)
>      }
>  }
>  
> +/**
> + * Convert a BlockAcctType into its QAPI equivalent IoAccountingOperation.
> + *
> + * Must only be called for valid BlockAcctType values, i.e. specifically not for
> + * `BLOCK_ACCT_NONE`.
> + */
> +static IoAccountingOperation block_acct_qapi_type(enum BlockAcctType type)
> +{
> +    switch (type) {
> +    case BLOCK_ACCT_READ:
> +        return IO_ACCOUNTING_OPERATION_READ;
> +    case BLOCK_ACCT_WRITE:
> +        return IO_ACCOUNTING_OPERATION_WRITE;
> +    case BLOCK_ACCT_FLUSH:
> +        return IO_ACCOUNTING_OPERATION_FLUSH;
> +    case BLOCK_ACCT_ZONE_APPEND:
> +        return IO_ACCOUNTING_OPERATION_ZONE_APPEND;
> +    case BLOCK_ACCT_UNMAP:
> +        return IO_ACCOUNTING_OPERATION_UNMAP;
> +    case BLOCK_ACCT_NONE:
> +    default:
> +        g_assert_not_reached();
> +    }
> +}

Wouldn't it be nice if QAPI could generate the shorter BlockAcctType
with BLOCK_ACCT_* on the C side while still keeping the nicer
IoAccountingOperation name externally? :-)

(Not a request to change it now, but a wishlist item for Markus.)

Though actually BLOCK_ACCT_* seems to already be possible with 'prefix'.
Maybe we could live with the longer IoAccountingOperation type name
everywhere and avoid having two separate enums?

>  bool block_acct_setup(BlockAcctStats *stats, enum OnOffAuto account_invalid,
>                        enum OnOffAuto account_failed, uint32_t *stats_intervals,
> -                      uint32_t num_stats_intervals, Error **errp)
> +                      uint32_t num_stats_intervals, int64_t alert_ns,
> +                      Error **errp)
>  {
>      stats->account_invalid = bool_from_onoffauto(account_invalid,
>                                                   stats->account_invalid);
> @@ -79,6 +107,7 @@ bool block_acct_setup(BlockAcctStats *stats, enum OnOffAuto account_invalid,
>              block_acct_add_interval(stats, stats_intervals[i]);
>          }
>      }
> +    stats->delay_threshold_ns = alert_ns;
>      return true;
>  }
>  
> @@ -252,6 +281,17 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
>          return;
>      }
>  
> +    if (stats->delay_threshold_ns && latency_ns > stats->delay_threshold_ns) {
> +        g_autofree char *dev_path = blk_get_attached_dev_path(stats->blk);
> +        double latency = latency_ns / (double)NANOSECONDS_PER_SECOND;

Wouldn't it be both easier and more reliable to just expose an integer
latency-ns in QAPI? I think all other time related values in the block
layer interfaces work this way, too.

> +        qapi_event_send_block_io_delay(dev_path,
> +                                       block_acct_qapi_type(cookie->type),
> +                                       latency,
> +                                       cookie->offset >= 0, cookie->offset,
> +                                       cookie->bytes);
> +    }
> +
>      WITH_QEMU_LOCK_GUARD(&stats->lock) {
>          if (failed) {
>              stats->failed_ops[cookie->type]++;

Kevin


