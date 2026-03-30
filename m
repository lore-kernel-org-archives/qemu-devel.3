Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793E010D14A4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7BBj-0006xU-CA; Mon, 30 Mar 2026 07:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w7BAh-0005Vr-FX
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w7BAf-0006Im-5n
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774871559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oipColfOmHOqAfaAbqK/sdgfQRcbgV6ldhAWeJ6d6pI=;
 b=gdlvBkCo9jhu+A9IB7O5mCKyLFmk0YHSHaEg4hMtF9askw55yGAouKYrX+SRCPeN9/XUUs
 tCMPAQUrkxxdNKKFMnWqK+Tv0NUnCBOAP9qmV/gG9Kf4P6/04p8RQPcyPnBOzTu41hGvgV
 RvsesCt1uaTTJHDC7JGamW6xDdlFOxk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-mDrs_4l7M8mwvwmyEPm7ng-1; Mon, 30 Mar 2026 07:52:38 -0400
X-MC-Unique: mDrs_4l7M8mwvwmyEPm7ng-1
X-Mimecast-MFC-AGG-ID: mDrs_4l7M8mwvwmyEPm7ng_1774871557
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43b96365ea8so4201936f8f.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 04:52:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774871557; cv=none;
 d=google.com; s=arc-20240605;
 b=OziirEcTFbTGWxIn+3qHlF0dKo/RoIETPzOprycjYuMw5MqT8Zf4gFtx91ipnifMFG
 e+fTRkxnh3XP21cUG9lp4MYUR4NOoQn2YbZLTpz+7Ac0oslw27v8cbAWZK68EAgBJ2ky
 7LMWrpOIe9CYKnoLqHGqtez9JeGzoNzPBJQUOXQwKZiQK/Xe/gIHkuDRNVvXOYpfJWpj
 Yzy8gN5QS3wBdQ1zZ23TCsGqiOA0fEwPI5Cy5em1hM7M5EOwkRCSK8cRqsNaEK3+lpx6
 qkfUt1rJJmzQOOpEcoMJeZAmzpnT05zYSC4jN+2dKgJxf++cxubwF66GHYk8sRStN3V2
 cjww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oipColfOmHOqAfaAbqK/sdgfQRcbgV6ldhAWeJ6d6pI=;
 fh=G+YYU0cJ5LFOh23XypSN6d44/A/q4U22J78Ce1TAhLE=;
 b=NObHsPs5FONRrNs0/hCcFPMaZUww3Arst/dM5SPCfnG4Wnd0xiyJ8oYsJLT6rWD6zq
 OogPoljzs2pET3CZ7wX4xHgW8R/5Z+421jeGjYye6LVXIPSpGu+VVj8N+yfh2LOcSicU
 4JTZkfgWf3hxVNy9my5ClxAiFRx4liVEZUBJbSXyJBXTQ24hRN1A/Bw1zj8HzwDH+0zR
 FJKN4KanPVGYn4Y+6aZ4EYuXaF9VW/sU18m59+Ki3EZZoHD+Pr3sQoo8Y30cbKrSI54g
 8W03CwT89VPWS+AYOmJ9DNoTHaCDYrI2odjTlg/6W+a8H8uRiSDmFtsK7WqHqL8W+//c
 BFog==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774871557; x=1775476357; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oipColfOmHOqAfaAbqK/sdgfQRcbgV6ldhAWeJ6d6pI=;
 b=ZlXHRXTDSgXdFuLhwAerWA+u9631F7f4QMH10JbPDE+/KF+z7IDKN+z0TWGTLK+RkJ
 wmer+Y0sPnXfFxTf10je8RjthgPvNy9L60jHCuPVIxvTM0WU3ZFBYyvud+2F3UO+wLYU
 CDogubYApKm+z5IoURWO3BcsVKECzImeeFK2nw9MBobfi6RxtQO6I8NzNyu/e8pt23L9
 Lng9bhW0UVEVJWsKpi0lj5BRDsWTi8e4OdPmYY1x7MvP4JceurGHPrqVjxUtT0kIEfuk
 WiEoUwl20ZZOpOlwDcKDxSC21S0UFdXZHsmilGaAo3x+RZgQlKiNRs4nGMwEM2pBHwLH
 8Tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774871557; x=1775476357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oipColfOmHOqAfaAbqK/sdgfQRcbgV6ldhAWeJ6d6pI=;
 b=WoqhaOnU2y+Sm9XOWAClakWI9uU2uqmfJ5mDCsoGyVglaxFQQg5fWSEHfhYz13n8jv
 7GCGzcceOleKrU4EXUSZMSi/eDe8iYaU/Ac8ZqA+U8FV2zOAhQSWhQDdfcYyLMEiUzvz
 /1U3aYKiL7LHTiiCO10lwSA0jfAPYBOiduKUmtZLRv/4O/149dWBz+MUXAZYWq6vvFPQ
 dFHiNT5NwS7nxhUJOnKlFCfRoEBprgR2Vn6MkZ0wXRZ8sXFvQ3+2DzWhI3L95DM6elRH
 06abcnf+jMigekMzxu5Qws7kYJP5R3FEDIQkI6jcdmG/fiAZHgn4cpgD/y7lxNJXjC/F
 Q2ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR6gLQHRnWZNbIx62DMh/jdLTYXvRqQHytRU46Xnxs/u/68wmnXBZLFJULdBHdJjFodzKxIb/CSt24@nongnu.org
X-Gm-Message-State: AOJu0YyOiKKLhwhgKvgXanaF0HP0Lol08gtYrUw++sznH5OqdZXzkHRM
 wh6IJVlzgUCzYlXFrgkNY8bSrnnBsRF9foVzVPQML4kW9VlQ6Urik2JInL3Keh1Jz28hjCAIJl6
 Ec3QkxEBUV7/LH8eFt2abqcClxl3LucJN9P62eKy9+Oyrxul0Ih25AwOVbPntCVTBipJE6eA7UR
 7ZGNI2xb5zpfDlWFnNRWkUkpyzi43wjVk=
X-Gm-Gg: ATEYQzxQfgaHQvZebEbeY9qIfED/TmtamzBhiwm8rkzXRb4C8UFYrRwYYgfsdKvldAm
 xAWoWgO5b2QZzUJYypF67OMPiJ1Bg64AuMsaD9CARUPJaaIkhVHM5CpBNVCz9zwCaIlsawh4k7X
 zp7jQvNX9ECy6AJZMuM01r4MhnXvWjr9+Thvv74y3uOT+ZAEflnK1fFxjQUZ63oHIt5Ew9bCxzV
 Ds5OdsC1Cs0jQ+jLBfxoDHDS3T3pu7Fjfq0IltAi+UnY0KHZYPwesbI2MJ9l8Qo0Qln
X-Received: by 2002:a05:600c:c4a7:b0:485:3af5:7e53 with SMTP id
 5b1f17b1804b1-48727ec3a93mr194470165e9.19.1774871557114; 
 Mon, 30 Mar 2026 04:52:37 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a7:b0:485:3af5:7e53 with SMTP id
 5b1f17b1804b1-48727ec3a93mr194469555e9.19.1774871556595; Mon, 30 Mar 2026
 04:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-2-peterx@redhat.com>
 <CAE8KmOyTq4wib3niowjXNfqh4TjwhcEDqUt99=mvuLs5vsSx9A@mail.gmail.com>
 <acaNfFWvNAEpFsFD@fedora>
In-Reply-To: <acaNfFWvNAEpFsFD@fedora>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 30 Mar 2026 17:22:19 +0530
X-Gm-Features: AQROBzDc_8Qj_sHwYQrKYyxNgB9wViP3my3A_TstZJZTOn25colsRvgqgiaNgJo
Message-ID: <CAE8KmOwwFmrNgb8MWO7yprPmtautrbrWzF5FYdJ4ODboQxhwUw@mail.gmail.com>
Subject: Re: [PATCH RFC 01/12] migration: Fix low possibility downtime
 violation
To: Juraj Marcin <jmarcin@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson <alex@shazbot.org>, 
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, 
 Zhiyi Guo <zhguo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

Hello Juraj,

On Fri, 27 Mar 2026 at 20:05, Juraj Marcin <jmarcin@redhat.com> wrote:
> > * What is the 'size' difference between < s->threshold_size  Vs  <=
> > s->threshold_size?  Going through the source IIUC
> > 1) 'pending_size' is measured in Bytes.
> >      static void ram_state_pending_exact/_estimate()
> >          remaining_size = rs->migration_dirty_pages *
> > TARGET_PAGE_SIZE(=4096 bytes);
> >          100 dirty pages * 4096bytes  => 409600 dirty bytes => 409600
> > * 8 => 3,276,800 dirty bits
> >
> > 2) 's->threshold_size' is derived from bandwidth (100M bits/s) and
> > downtime(=300 ms)
> >         100,000,000 bits/s => 100,000 bits/ms
> >         100,000 bits/ms * 300ms => 30,000,000 bits in 300 ms
> >         30,000,000 bits / 8  =>  3,750,000 Bytes / 300 ms
> >         s->threshold_size = 30,000,000 bits (= 3.75MBytes) can be
> > transferred in 300ms downtime.
> >
> > * Are we comparing pending_size(=409600 bytes)  <=
> > s->threshold_size(=30,000,000 bits)?
>
> While threshold_size is indeed derived from bandwidth, bandwidth is in
> bytes:
>
>     current_bytes = migration_transferred_bytes();
>     transferred = current_bytes - s->iteration_initial_bytes;
>     time_spent = current_time - s->iteration_start_time;
>     bandwidth = (double)transferred / time_spent;
>
> Conversion to bits only happens for the mbps statistic:
>
>     s->mbps = (((double) transferred * 8.0) /
>                ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;
>
> >
> > *  static void migration_update_counters()
> >         transferred = current_bytes - s->iteration_initial_bytes;
> >         bandwidth = (double)transferred / time_spent
> >         if (switchover_bw) {
> >             expected_bw_per_ms = (double)switchover_bw / 1000;
> >         } else {
> >             expected_bw_per_ms = bandwidth;
> >         }
> > => ^^^^^^^  Should we divide 'bandwidth' by 1000 here (for bw_per_ms) ?
>
> switchover_bw is expected to be in bytes/sec, however, time_spent is
> already in msec, thus bandwidth is also bytes/msec, the existing code is
> correct.

* I see, this is not readily clear though. This needs good
improvement. Maybe we should add an explanation in comments OR include
an example calculation OR define helper function(s) to convert
bandwidth from Mb/s <-> Mb/ms and MBps <-> Mbps etc.

>     s->mbps = (((double) transferred * 8.0) /
>                ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;

* If time_spent is in msec, continuing the above 100 mbps example, we
got to 3,750,000 Bytes / 300 ms above. Now to get mbps

     s->mbps = (3,750,000 * 8.0)  / 300 (time_spent) bits/ms  =>
30,000,000 bits / 300ms
     s->mbps = 30,000,000 bits * 1000ms (=1sec) / 300ms  =>  100,000,000 mbps.

*  (time_spent / 1000.0) / 1000.0 / 1000.0  is not very apparent.

> @Peter, not sure if it is necessary, but it could be usefull to mention
> in MigrationParameters docs, that avail-switchover-bandwidth is in
> bytes, not bits?

* I request that we use 'Mbps' notation for bandwidth at every user
interface, be it --bandwidth <option> OR a definition in a
configuration file OR documentation. Users should always specify and
read bandwidth in 'Mbps'. Because that is the notation used
everywhere. Asking users to specify 100,000,000 bps / 8 => 12,500,000
Bytes/s  instead of 100Mbps does not seem right, is not user friendly.

> >
> >       s->threshold_size = expected_bw_per_ms * migrate_downtime_limit();
> >
> > migration_iteration_run():
> >    /* Should we switch to postcopy now? */
> >    if (must_precopy <= s->threshold_size &&
> >       can_switchover && qatomic_read(&s->start_postcopy)) {
> >       if (postcopy_start(s, &local_err)) {
> >           migrate_error_propagate(s, error_copy(local_err));
> >           error_report_err(local_err);
> >       }
> >       return MIG_ITERATE_SKIP;
> >    }
> > * Here we should check pending_size <= s->threshold_size,  because
> > must_precopy is zero(0) when postcopy is enabled. And we switch to
> > postcopy mode even when pending_size > s->threshold_size.
> >   I wonder if we really need both 'must_precopy' and 'can_postcopy'
> > variables, they seem to complicate things.
>
> With devices that implement pending method, don't support postcopy, and
> are not yet migrated, must_precopy would not be zero.

* If must_precopy is not zero(0), then pending_data would not be <
threshold_size either, right? What is must_precopy data? IIUC, all
device state is 'must_precopy' data, because we don't send Postcopy
requests for device state data. And can_postcopy data is only RAM
pages.

> Both, must_precopy and can_postcopy are required, that is what allows
> postcopy to switchover early. pending_size is the overall total that
> includes also postcopiable data, hence why it is only used to trigger
> precopy completion.
>
> However, the majority of devices don't implement pending methods (yet)
> and thus are not counted towards the estimate even if they don't support
> postcopy and affect the downtime.
>
> Wondering if VMSD devices could implement some pending estimates based
> on their defined fields, this would also improve not violating the
> downtime requirements.

* Using 'pending_size <= threshold_size'  in one place and using
'must_precopy <= threshold_size' in another place is confusing and
inconsistent.

* What is threshold_size really? Number of bits/bytes we _can_
transfer within the given downtime, right? if downtime is 300ms, at
100 mbps, threshold_size is 30Mb (ie. 10Mb/100ms). For 500ms,
threshold_size is 50Mb.

* Then it is easy to understand that when pending_size is <=
threshold_size, then we can easily pause the source VM and switch to
Postcopy, becasue those pending_size bits/bytes can be transferred in
the given downtime. And if pending_size is more, then we _can not_
pause the source VM, because we can not transfer more pending data
within the given downtime value.


Thank you.
---
  - Prasad


