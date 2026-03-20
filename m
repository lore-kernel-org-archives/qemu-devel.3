Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4817D108B8E5
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3WUD-0001qA-VB; Fri, 20 Mar 2026 05:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w3WUB-0001pM-Jo
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:49:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w3WU8-0004OR-Qi
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774000178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jTmjwWfULrwN4cfCkbMhVV0ICf/zFXEB5JzkqqhXXuw=;
 b=bYI60DlIUr/0nEtYJlwUfGfoM/0edyS4i2k8ZgvpqPrvE4U1we/qitmwE8Oo9sTYhOqeA4
 UgzKlGIp8VXmM88V35BZerAAaYh+m3BtrGdtgllKWuVkIHI/6wKWOqyRX3n0tTzkurgrIi
 LXbJfu+y1oOZ7OaL5Qtx4O080NwVhvk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-JK69ZqJoNX2WOUMDzYUFiQ-1; Fri, 20 Mar 2026 05:49:36 -0400
X-MC-Unique: JK69ZqJoNX2WOUMDzYUFiQ-1
X-Mimecast-MFC-AGG-ID: JK69ZqJoNX2WOUMDzYUFiQ_1774000175
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-483786a09b1so18558375e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 02:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774000175; cv=none;
 d=google.com; s=arc-20240605;
 b=eKkE65W9MM11eKtsAE4MAJbMJhBSRiEZtQEKeNyeHYtNAOp/bXO308wnDTYzLLnm+g
 iBSEGW4Bac4KyHnTe/2Gm0M4TN/+QZ7lI0zdDG37lNu10oA1f3Yt0urLpCbS9sWN4tZR
 zVd/jD3jmA/cEK6L7Q0LONq622UGD55Yy7IlfajJH3oRftnm0iSuj+WRzcsyy5Ngmc4G
 1AAHAsi/sCyy89jMPA+XZGscvV7P2gw0bXvu2r8I2Cbl/hL2JF1FMrgwPVLOmdg3CU8v
 8KKTceao3lz+SdDYw79Nl6T7PYEo7n8t21uqJH3u8hSvBg4XNUN/Hfxshr+3BTG6otNQ
 FsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jTmjwWfULrwN4cfCkbMhVV0ICf/zFXEB5JzkqqhXXuw=;
 fh=PRy/UMsTflbww0VnKZ/lYWzqEyak9st/+YTZWl1C9xA=;
 b=bXCfO+yLabXMYb6GPiOYMGcrQsZGBU42Imq9SNZGfWwRWXwZ+UFbjcgSfa/yji7Sq7
 G9XARQQk4vrtMBdZLiWMVdFEOhAiYd7So6VfRTTzQZ74Ifz8cF9fOwqiBe+RjRAQ0jxo
 ls16MF28NVhDP77PV5U9OeSOBCYokLdspw4IiZ70bwgadzQthB6SX9T4mwq+oax6RVbo
 w40dLKv0057Cntgd2Z3sbO/hED8XUZv6Bj0xkx6Vpomvqcs2GIi4YsCmebhqwGFCny0R
 LwpPKselGXxnlG4yPLF1EwmhFlijCer5AOmkB7olPJ5RVIeRV/mrKxN7j70f5QajjLyN
 UHBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774000175; x=1774604975; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jTmjwWfULrwN4cfCkbMhVV0ICf/zFXEB5JzkqqhXXuw=;
 b=t1dgnG/6cF2jaRbA/8cjCTpJ/4O/MXEzu7mOvYio8wdUKoKrbEH2ghgV+zhXZ8F0ur
 IpHOQ3yuROAGvmudvqSb0xsvixYHcQs0IRbf5nlgvoOdy1ml9VxYKVbr/joQamnLGnLe
 XEkZ0A4IA28cud3LnW4XwiN0VbnbZP5VKn5KbLr97dTWn/xQ226sc+btari7c+a/mELa
 UNhzbafdEo6p1gH9dvCRkbjIxkG2ctWtY9pLSPPqmEfAwRcsCDPoVkZR9uct+m/b05hq
 8hfBWwnIkfp5U5yjr1zq2p/t8sP7Al8KQb2lPbKh19lIHRXS75Sd2962bAtUiIrKGq5S
 gy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774000175; x=1774604975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jTmjwWfULrwN4cfCkbMhVV0ICf/zFXEB5JzkqqhXXuw=;
 b=NSgCXVeHTTQDmYTZU4mM2QCEJ3EsXTVeb9lm4DYEQPsJA49goFat6dp4SAcyzhoHTl
 kxzbluQ8Cgfx5AzBAKZ3WnUTz8jaSk2IcG4ekJaKc95PnQyFJBJRWXkseKMg51fUuuie
 0d76gJut8r8kJ/pze3VXQ5CVM4b/Ae/xiou6ZsEyoCOK8ilzGbwp2I14AYjF60Hej3i5
 wtaZEw4U/90K7MxB46wBda6229ZB/6h8D78o6o6clZq6kOYvR1wboxrj521zYgoAMbeZ
 7Jus/aBNLILehXhqf5Jtw4x/bYBIn8Yp1uxcMByzVmwscRTnIcKT3bqMOMQ5y8b/9Wt+
 dyAg==
X-Gm-Message-State: AOJu0YxFfmCuybBPzYuxvEP16bj4pHi74Kh5in10OD5P1SKJNBaiQ+a+
 K26btY1JYNsMDJm7cn5qBy1y8vZyYkEOL0C5Pr5lptVkk3tePPn/2Q41aOOgLJrkaGS+BrtVC//
 Z88ccuHxZ6hztNwpJxyFUsdeMWS01ActIzFaUyId+jkojdD0Wrk0ozrfEJf4HcgJje/MHXb54kZ
 eRoe/p6Hq8djSt1mFSZesBGAbY8xFp/kE=
X-Gm-Gg: ATEYQzxaHGtaF1GLpphupAU2KVDQEQd1PG/0Euz22UcL5R46tTlS0pkjxaRqDw5R4pg
 +Rhmq3emjpfxh+C5aYIGzrBXRopt11ucWn+lhonWMWglm12WLaszP8X4s/h+apgbN3XkJyS8T9o
 ak+41Co6yb04m1Aurd13Tpmyq/qtzIK/94brbZO9e94QiZtre1uAgnb/L8r073MaaR/LsSQ7Pxc
 sNAu2IaaiyxLIFOmL6P1slR2RMbVd9Cm+joQMfvc2uu41SpT0trOFSZX8DNU+IDAG4H
X-Received: by 2002:a05:600c:8711:b0:485:3f58:d9f with SMTP id
 5b1f17b1804b1-486ff029008mr36125705e9.30.1774000175090; 
 Fri, 20 Mar 2026 02:49:35 -0700 (PDT)
X-Received: by 2002:a05:600c:8711:b0:485:3f58:d9f with SMTP id
 5b1f17b1804b1-486ff029008mr36125085e9.30.1774000174492; Fri, 20 Mar 2026
 02:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-10-peterx@redhat.com>
In-Reply-To: <20260319231302.123135-10-peterx@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 20 Mar 2026 15:19:17 +0530
X-Gm-Features: AaiRm50jgW1qylEIvMoFvAkd7i-z73OB4YDxYNvYlLlqeGetAgwpVT4Q2Hx6GNg
Message-ID: <CAE8KmOzqJzdez1xuXOsPyq2ewrCohg+a0VfgmbkPkzTS6nr9Wg@mail.gmail.com>
Subject: Re: [PATCH RFC 09/12] migration: Make iteration counter out of RAM
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, 
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson <alex@shazbot.org>, 
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, 
 Zhiyi Guo <zhguo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Yong Huang <yong.huang@smartx.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 20 Mar 2026 at 04:44, Peter Xu <peterx@redhat.com> wrote:
> It used to hide in RAM dirty sync path.  Now with more modules being able
> to slow sync on dirty information, keeping it there may not be good anymore
> because it's not RAM's own concept for iterations: all modules should
> follow.
>
> More importantly, mgmt may try to query dirty info (to make policy
> decisions like adjusting downtime) by listening to iteration count changes
> via QMP events.  So we must make sure the boost of iterations only happens
> _after_ the dirty sync operations with whatever form (RAM's dirty bitmap
> sync, or VFIO's different ioctls to fetch latest dirty info from kernel).
>
> Move this to core migration path to manage, together with the event
> generation, so that it can be well ordered with the sync operations for all
> modules.
>
> This brings a good side effect that we should have an old issue regarding
> to cpu_throttle_dirty_sync_timer_tick() which can randomly boost iteration
> counts (because it invokes sync ops).  Now it won't, which is actually the
> right behavior.
>
> Said that, we have code (not only QEMU, but likely mgmt too) assuming the
> 1st iteration will always shows dirty count to 1.

* Where do we make this assumption? I mostly see 'dirty_sync_count'
read/used as is, only cpu_throttle_dirty_sync_timer_tick() seems to
skip one *_bitmap_sync_precopy() call when sync_cnt <= 1. This'd works
for zero(0) as well.

> Cc: Yong Huang <yong.huang@smartx.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration-stats.h |  3 ++-
>  migration/migration.c       | 29 ++++++++++++++++++++++++++---
>  migration/ram.c             |  6 ------
>  3 files changed, 28 insertions(+), 10 deletions(-)
>
> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> index 1153520f7a..326ddb0088 100644
> --- a/migration/migration-stats.h
> +++ b/migration/migration-stats.h
> @@ -43,7 +43,8 @@ typedef struct {
>       */
>      uint64_t dirty_pages_rate;
>      /*
> -     * Number of times we have synchronized guest bitmaps.
> +     * Number of times we have synchronized guest bitmaps.  This always
> +     * starts from 1 for the 1st iteration.
>       */
>      uint64_t dirty_sync_count;
>      /*
> diff --git a/migration/migration.c b/migration/migration.c
> index 42facb16d1..ad8a824585 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1654,10 +1654,15 @@ int migrate_init(MigrationState *s, Error **errp)
>      s->threshold_size = 0;
>      s->switchover_acked = false;
>      s->rdma_migration = false;
> +
>      /*
> -     * set mig_stats memory to zero for a new migration
> +     * set mig_stats memory to zero for a new migration.. except the
> +     * iteration counter, which we want to make sure it returns 1 for the
> +     * first iteration.
>       */
>      memset(&mig_stats, 0, sizeof(mig_stats));
> +    mig_stats.dirty_sync_count = 1;
> +
>      migration_reset_vfio_bytes_transferred();
>
>      s->postcopy_package_loaded = false;
> @@ -3230,10 +3235,28 @@ static bool migration_iteration_next_ready(MigrationState *s,
>  static void migration_iteration_go_next(MigPendingData *pending)
>  {
>      /*
> -     * Do a slow sync will achieve this.  TODO: move RAM iteration code
> -     * into the core layer.
> +     * Do a slow sync first before boosting the iteration count.
>       */
>      qemu_savevm_query_pending(pending, false);
> +
> +    /*
> +     * Boost dirty sync count to reflect we finished one iteration.
> +     *
> +     * NOTE: we need to make sure when this happens (together with the
> +     * event sent below) all modules have slow-synced the pending data
> +     * above.  That means a write mem barrier, but qatomic_add() should be
> +     * enough.
> +     *
> +     * It's because a mgmt could wait on the iteration event to query again
> +     * on pending data for policy changes (e.g. downtime adjustments).  The
> +     * ordering will make sure the query will fetch the latest results from
> +     * all the modules.
> +     */
> +    qatomic_add(&mig_stats.dirty_sync_count, 1);
> +
> +    if (migrate_events()) {
> +        qapi_event_send_migration_pass(mig_stats.dirty_sync_count);
> +    }
>  }
>
>  /*
> diff --git a/migration/ram.c b/migration/ram.c
> index 89f761a471..29e9608715 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1136,8 +1136,6 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
>      RAMBlock *block;
>      int64_t end_time;
>
> -    qatomic_add(&mig_stats.dirty_sync_count, 1);
> -
>      if (!rs->time_last_bitmap_sync) {
>          rs->time_last_bitmap_sync = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>      }
> @@ -1172,10 +1170,6 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
>          rs->num_dirty_pages_period = 0;
>          rs->bytes_xfer_prev = migration_transferred_bytes();
>      }
> -    if (migrate_events()) {
> -        uint64_t generation = qatomic_read(&mig_stats.dirty_sync_count);
> -        qapi_event_send_migration_pass(generation);
> -    }
>  }
>
>  void migration_bitmap_sync_precopy(bool last_stage)
> --

* Change looks okay. Setting dirty_sync_count = 1 seems like special
casing, we need not do it if it's not required.

Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


