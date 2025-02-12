Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5D3C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGez-0002Gs-KO; Wed, 12 Feb 2025 12:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tiGex-0002GF-3Y
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:36:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tiGeu-0005Ee-OV
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739381783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mUU9J6rENFH2vyOmvH8jos803BUxbs6sxAZ8hNx+HP8=;
 b=K/cy4kMYG2Wq9AYhvBX7pGVQqoiMg9zzLf6vGFaHjKHW7UN8HqD331gnYPP48gfs+lfddp
 0t3oAHDmmxpaDqS2RWdfymImP86SLEjOVEMkCueA+DrVc5vEBGdr+MAqRX5YjM84iTKWvU
 BrSvWcL3jlOdKaUh0FIdSxQ2UUJelsw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262--jtKNo5GMuaV9OCnnSft5Q-1; Wed, 12 Feb 2025 12:36:20 -0500
X-MC-Unique: -jtKNo5GMuaV9OCnnSft5Q-1
X-Mimecast-MFC-AGG-ID: -jtKNo5GMuaV9OCnnSft5Q_1739381779
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43945f32e2dso27770075e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 09:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739381778; x=1739986578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mUU9J6rENFH2vyOmvH8jos803BUxbs6sxAZ8hNx+HP8=;
 b=qc7CDZSGpz8DM73aa9LR3B/Gb3PKWE3vh/oMY4+KGdD1m3nqXRLqBkxN176HYAzfmb
 qZostVUMI9qcbN2HHtjNjlYWaIpQ08P4fnhkFMCiwhEzxf4UK4oRiKuh3xx20olWCEMK
 IIzNFW3RZItXIaBl+ns/MyfUAW6meBx4Zr0we3tM3qBH3S2fPE1YwaacdG8r4EPBX3vO
 Ia1I61mt5QF3ocMtdP/IgYi6QUgeT0rSdBlvIbJV6YY+Kyvcnta5jLShHm4UW0JujLjb
 ivGZTBuumG6zqzTbashpyHsOSKatiX22mPWN6I4hgnI7iy4ml/QHmvM7Nq08bgSR77EV
 QB4g==
X-Gm-Message-State: AOJu0Yw/5T4CCvArtiPkZRnMPopGyxyEg6DC6PVgYfQFzxY7MF5KGpFT
 CViMNrY4KQH6/5IQNlJLxSiGuUR0oIhM/TI9G5tD70vVdfzHiVkD1ZhCw0M8WlOW8+4qK80IuN3
 mEKZld1ojJ2LWc3s+z3owpB5UyGDz8GKbLmchoIAi5AlyT3/vrVZwvbx0zdnHe5uvmrtcxMnNg8
 YXL3phPNj/AJ+kI/SfYilk8WKLFC83RqWzn42PkVno
X-Gm-Gg: ASbGncsob3i+PQtqhw9RG2CqPlGAFKo7IZsv1JIImZppkrvtru/sr2lJa19Z37LCoEQ
 lh4auZG9bhx9bL4NKmKOIw4NzWxtuzitjqGxrflNMZODD42J0W+3S9KCz3W+n0V/N
X-Received: by 2002:a05:600c:3b9e:b0:439:40c1:1343 with SMTP id
 5b1f17b1804b1-43960191549mr4514165e9.15.1739381778092; 
 Wed, 12 Feb 2025 09:36:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH98BLyCvaD4ClxXiQTnCgZDl3JcHyVy9SM4RS/SD0YQsf/LrqQZE0Uwh+oSJlHNNH9lompTGLXrBYWw7RR8iw=
X-Received: by 2002:a05:600c:3b9e:b0:439:40c1:1343 with SMTP id
 5b1f17b1804b1-43960191549mr4513865e9.15.1739381777673; Wed, 12 Feb 2025
 09:36:17 -0800 (PST)
MIME-Version: 1.0
References: <20250205122712.229151-1-ppandit@redhat.com>
 <20250205122712.229151-4-ppandit@redhat.com>
 <Z6VCxEKxn6-_okRx@x1.local>
 <CAE8KmOwJSYq2Ok38_sq29cr7JhbLLh1ZEncP13QpDdnYKOAheQ@mail.gmail.com>
 <Z6YqstgG2bSY45dM@x1.local>
 <CAE8KmOwMTw-m0w+JbFBZ7mn-ZuSNfpk9xbq-_KbLXu7_kDhDVg@mail.gmail.com>
 <Z6owYoktb5nk2yRw@x1.local>
 <CAE8KmOy+C7QzDHJ5hfWg93zSV0ctGYYz30qsQTe-=+iq1vA+fQ@mail.gmail.com>
 <Z6tqq5jpbDHsVtVw@x1.local>
 <CAE8KmOwxobOtw0B4UVECFtgTdbMtOU2Sw09WqYryYYzG+d_UJQ@mail.gmail.com>
 <Z6yyRdDabvoHrYsm@x1.local>
In-Reply-To: <Z6yyRdDabvoHrYsm@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 12 Feb 2025 23:06:00 +0530
X-Gm-Features: AWEUYZkTkby6JwDtiyFpO8XOi5PFzxkbYX4NCENUGIFIk1yo7Hpv-5soBz67GLQ
Message-ID: <CAE8KmOx7K1h+_99ivNFQENJNCRJ_rnJVJrdP8BP7zqbRMZNTpw@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] migration: enable multifd and postcopy together
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

On Wed, 12 Feb 2025 at 20:08, Peter Xu <peterx@redhat.com> wrote:
> I think it's not because TLS channels don't send magic, but TLS channels
> are not prone to ordering issues.
> In general, I'm not convinced we need to check names of iochannels.

* If the channel does not set '_READ_MSG_SEEK' flag, which magic value
are we going to read? As for checking names of the channels, it tells
the reader how an incoming channel is processed.

>> It did not work, as qemu would crash during multifd_shutdown().
>
> Have we debugged the crash? I'm not saying we should go with this, but
> crash isn't a reason to not choose a design.

* Yes, I did try to debug it but couldn't get to a conclusion in time.

> No this is not.  As I mentioned tons of times.. copying page in socket
> buffers directly into guest page during vcpus running / postcopy is a very
> hard to debug issue. If it's possible to happen, the design is flawed.

* Sure, agreed. So far in my testing it does not seem to happen. The
theory of multifd_recv_threads getting scheduled out and causing guest
page over-write seems remote to me, but I get the
possibility/probability. One possible solution is to have the
destination side send an 'acknowledgement' to the source side.

> I don't think passing the unit tests prove the series is correct and should
> be merged. We need to understand how it work, or we can't merge it.

* Well, passing unit tests should confirm that it does not break
existing functionality. Is there any metric/limit to such
understanding? Everybody understands/sees things differently.
Understanding is an ever evolving thing. Saying that merge should
happen based on understanding sounds weird to me.

> I feel very frustrated multiple times that you seem to want to ignore what
> I comment.  I don't know why you rush to repost things.

* I guess we are seeing/understanding things differently here.

> After a 2nd thought, I think maybe multifd flush and sync could work on src
> side indeed, because when flush and sync there'll be a message
> (MULTIFD_FLUSH) on main channel and that should order against the rest
> postcopy messages that will also be sent on the main channel (if we do
> multifd flush before all the postcopy processes).  Then it should guarantee
> when postcopy starts on dest, dest multifd recv threads flushed all
> messages, and no multifd message will arrive anymore.

* After a 2nd thought - that's evolving understanding right there. :)

* To mention here, to flush multifd channels with
'multifd_ram_flush_and_sync()' I tried calling

       migration_iteration_run -> multifd_ram_flush_and_sync(s->to_dst_file)

It does not work, it crashes. Is 's->to_dst_file' a right parameter there?

But calling a function below works
===
/* Send enqueued data pages onto next available multifd channel */
int multifd_send_flush(void)
{
    if (!multifd_payload_empty(multifd_ram_send)) {
        if (!multifd_send(&multifd_ram_send)) {
            error_report("%s: multifd_send fail", __func__);
            return -1;
        }
    }

    return 0;
}
===
    migration_iteration_run -> multifd_send_flush()

Works, but it is not sending the 'RAM_SAVE_FLAG_MULTIFD_FLUSH' message
as done by 'multifd_ram_flush_and_sync()' function.

> But again we should guard it with an assert() in recv threads if you want
> to postpone recycling of multifd threads, just to double check no outliers
> we overlooked.

* Yes, the revised patch is working with the
assert(!migrate_in_postcopy) in multifd_recv_thread.

* I was going to send a revised series with these changes, but will
wait on that for now.

Thank you.
---
  - Prasad


