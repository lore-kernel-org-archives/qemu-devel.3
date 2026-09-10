Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097E8C79FB6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 02:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4UTN-0007Ki-Dq; Wed, 09 Sep 2026 22:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4UTL-0007K6-V9
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 22:25:07 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4UTK-0000k0-6f
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 22:25:07 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6a68279dd86so8246753a12.3
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 19:25:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789007104; cv=none;
 d=google.com; s=arc-20260327;
 b=ctWfXDiRvT2IM90r4vmOzoBdZ76U21eOgRrjM0MYeP9SvlK7j2gt9rlaxKZLYc9lrb
 5yfWqlsDx2Xq2SmgRL3Ru2mNL8n+VpKK8eaSlKgg0KN76SOBtXNBprtNQiqhwCjP2B9i
 mGXf8Euhq0lQRBpsUMLRV7Kp6EJ2qauXYfzP27tDr+Q9yE1J5o7wAIxDltyGYtiBKFSB
 dQavHxmgYGaHAtaqQxG0akOWUX/6tiXmfitQUm1ymYoEki2oWha7i/n+0FLbC76j42PI
 wpAlEw2jQsFiyf6JTnngS8fRBT50YO+2uuG5IhDgwbSjh3opbnGaEHRy5nNKHg2rpYNQ
 E9gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=th/OVyjsr7yqaKZFoKz9c7hwzbrGgWEuRq7tX7IsOss=;
 fh=wGZeUYt39FdrjiyDvngBMA/6KW8toEkLMWKs7FzaIuY=;
 b=TPpsQlwSwS7miMno9HwrpO5ic62GKNOVIBzfYg63qqycd3XTrjdWgOKBuy0e8gap/u
 i3hqbaL0ErIoMmH/GyTS/bGyQaWEj08oveTqyH+KbI0RVaUEsiRdm49Lig+JU1nKgcy+
 opLyypCk45wI89v9e7gZHQ9Qk8xkX+0Q1H930G+9VExkoGdKQa08ZVW9gnbIqGmTFVLt
 hN6dQEVa4zKb+INNsErGDbgO1jP4gzewp4ylxbt7cDlZ7onoivol+JuPxUB1vk76rZEy
 breFOiTVtXg0Q+3ICpx1DpjhzveHaraKBk/+dALQPEAdd9WHmRB5GQDxqITIuBnGjJ/q
 KK5Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789007104; x=1789611904; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=th/OVyjsr7yqaKZFoKz9c7hwzbrGgWEuRq7tX7IsOss=;
 b=nnU2eUcBCuRhQ9bIFn9EYVtVG+g1TmafiL/S7xwfTajueNu+fogoOjwsRc4Ck/Ws+x
 OaGJwqKJoHS3a9IRsfg8GimtjsojShmslme2Q9TLmUSfoAPvzpelPIEJZpOEzOxkWrdQ
 ILjUCVUNjFqs2zdl3cG9XaUIGKupLKBceyy3L1iEvj9P4Oc2sxgViJcCcYcTZ7UJVZWC
 o8m1Bvk8lR/htt87+USUL0+tz3qKYGhrzwv+ybiPUeo/zJXawmMJFZRdphUrS7zwXasM
 RjqHhROR4UanQm5drXSFgV1Y3A4OVLgKx9meSlCcMB/lL4zsvs6b1sNjdoTQB+t/+Sgq
 uhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789007104; x=1789611904;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=th/OVyjsr7yqaKZFoKz9c7hwzbrGgWEuRq7tX7IsOss=;
 b=qKER9iJKYMnik6j74/G/ap9ahHghCPVZVdORuXqEL1eBRPlxRfEwxBfBrzbksI3/Qa
 SrJ/n1jDgNmVormnpCPWqMZdLo2l/NDCW/jgAC+8G6wEPDydl5zA116OKPR0KpySnvuc
 yTz7JPxJmZl9dc6FPcFHqxNAQyn3lx9FxwF7OfVIGwnQ/K2dlEF10dynHDFl/lN30jVK
 qfnR6B3wPxk0tkA0lxhvE5j8A/u1U1FtIwLCVM36SPE2CPdn7VWjY2PDfV4v6xcZMJLK
 C9DI4pYpd1c45spUQdKhvejCpcVyhHS02Dil4189pupPSi9fKtYE6vdqwSaC6dYjz7WP
 gCJg==
X-Gm-Message-State: AFuF++l20aZ7eJDl1YwY3mIzEY11W1S6LP7vBoVblYvb6b2boqclRH1B
 xaeWatRPxEpo8r/dJU2cyiDm5pb8FF3R4dWoOJYNcOyD/ycvgMwu0qoXognMjpLSzW98ArJJAfg
 bgZvqTqqbLNbXpOPv1IXzfSeLiSB+Bmk=
X-Gm-Gg: AYBFou2SpZq1hgeZdkod0MNwmVqZM3kZQbI7SV6F2yfuRubwvn1bNW9sRbjk9hgXlT2
 CcoSwMnb4dJ6j3dqA6Z3gbGmak/SXQHEiWJid+2vC24H9hxKGyNVTbyodePmaGfYKt9IeKB5adD
 ZvIVSLcnyfAc/W3TN5ihKUDqpjJd4j7J/xJKUMx+/RH15qACYTmLjzPWNAjAZLKqfRN5sF2G8u+
 AKqyDSitA8L3KeqMz97NoRfKpWeiOFPsG8KRVYqTpVtLYFkRUNve7Bps4WKzRGGDi1vzviCA2km
 ytwDG/1VH3gWEmVdzvgyuDOAnZBgmx1OWxpzhIHfZfHj4Ji/hiKYWFJ1
X-Received: by 2002:a05:6402:3982:b0:6a9:9c47:771f with SMTP id
 4fb4d7f45d1cf-6a99c477882mr1976519a12.37.1789007103487; Wed, 09 Sep 2026
 19:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260907063725.626685-1-zhangckid@gmail.com>
 <20260907063725.626685-6-zhangckid@gmail.com>
 <874ig1xmbi.fsf@pond.sub.org>
 <CAK3tnvKfeJK-p8POfzDoG2NLt=NWgKnF_WcmAWAHWXnuQdCWTw@mail.gmail.com>
 <87fqzin1wc.fsf@pond.sub.org>
In-Reply-To: <87fqzin1wc.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 10 Sep 2026 10:24:24 +0800
X-Gm-Features: AcwNN1V-_F6NPqBeubSx7HR8-dBvEKIrEUtj-7FHlfVaPWVBfxIHm5EI6zeLd2M
Message-ID: <CAK3tnvKo5LAR+YBsChTeS=BBpG32QsFQD=1SjL+dpuLRefLewg@mail.gmail.com>
Subject: Re: [PATCH V15 05/14] monitor: track IOThread users with QOM paths
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Sep 9, 2026 at 6:40=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > On Mon, Sep 7, 2026 at 8:44=E2=80=AFPM Markus Armbruster <armbru@redhat=
.com> wrote:
> >>
> >> Zhang Chen <zhangckid@gmail.com> writes:
> >>
> >> > Monitors that require an IOThread share the internal mon_iothread.
> >> > Account for each monitor explicitly in IOThread holder tracking, usi=
ng
> >> > the monitor's canonical QOM path to distinguish holders.
> >> >
> >> > Acquire the shared monitor IOThread AioContext once and store the
> >> > IOThread and canonical QOM path so the holder can be released after =
the
> >> > monitor has been removed from the QOM tree. Reuse the stored context=
 for
> >> > later operations.
> >> >
> >> > Release the holder from monitor_finalize(), after resources associat=
ed
> >> > with the AioContext have been destroyed. This pairs the reference ta=
ken
> >> > in complete() with instance finalization and keeps the IOThread aliv=
e
> >> > throughout monitor teardown.
> >> >
> >> > The internal mon_iothread remains hidden from query-iothreads, as be=
fore.
> >> > Management applications therefore cannot use it to determine which
> >> > monitors are using the IOThread. Nevertheless, track the monitor
> >> > holders so that they follow the same explicit holder and
> >> > IOThread reference lifecycle as other AioContext users.
> >> >
> >> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> >> > ---
> >> >  monitor/monitor-internal.h |  5 +++++
> >> >  monitor/monitor.c          | 26 +++++++++++++++++++++-----
> >> >  monitor/qmp.c              |  5 +++--
> >> >  3 files changed, 29 insertions(+), 7 deletions(-)
> >> >
> >> > diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> >> > index 822a66d06d..1d5aeae5e6 100644
> >> > --- a/monitor/monitor-internal.h
> >> > +++ b/monitor/monitor-internal.h
> >> > @@ -77,6 +77,11 @@ struct Monitor {
> >> >      GString *outbuf;
> >> >      guint out_watch;
> >> >      int mux_out;
> >> > +
> >> > +    /* iothread context and holder identity */
> >> > +    IOThread *iothread;
> >> > +    char *iothread_qom_path;
> >> > +    AioContext *ctx;
> >> >  };
> >> >
> >> >  struct MonitorQMPClass {
> >> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> >> > index 2654b81890..cc7f6785b5 100644
> >> > --- a/monitor/monitor.c
> >> > +++ b/monitor/monitor.c
> >> > @@ -93,6 +93,16 @@ static void monitor_finalize(Object *obj)
> >> >      qemu_chr_fe_deinit(&mon->chr, false);
> >> >      g_string_free(mon->outbuf, true);
> >> >      qemu_mutex_destroy(&mon->mon_lock);
> >> > +
> >> > +    if (mon->iothread) {
> >>
> >> As we'll see in monitor_complete() below, mon->iothread is mon_iothrea=
d
> >> if monitor_requires_iothread(mon), else null.  Which means
> >> mon->mon_iothread is non-null if and only if
> >> monitor_requires_iothread(mon).
> >>
> >> Here, you check whether mon->mon_iothread is non-null to find out
> >> whether @mon uses the monitor I/O thread, and you read the monitor I/O
> >> thread from mon->mon_iothread.
> >>
> >> Elsewhere in this file, we check monitor_requires_iothread(mon) and yo=
u
> >> read mon_iothread, e.g. in monitor_cancel_out_watch()
> >>
> >>            if (monitor_requires_iothread(mon)) {
> >>                ctx =3D iothread_get_g_main_context(mon_iothread);
> >>            }
> >>
> >> I don't like this inconsistency.  Two ways to avoid it:
> >>
> >> 1. Always use monitor_requires_iothread(mon) to check and mon_iothread
> >> to read.  Drop struct Monitor member iothread.
> >>
> >> 2. Always use mon_iothread, except where we initialize it in
> >> monitor_complete().
> >
> > Just to clarify: by option 2, do you mean using mon->iothread
> > consistently for per-monitor checks and accesses, except in
> > monitor_complete(), where monitor_requires_iothread() determines
> > whether to initialize it?
>
> Yes.  I meant to write 2. Always use mon->iothread, but mistyped.
>


Thanks for clarifying. I'll use mon->iothread consistently for
per-monitor checks and accesses after initialization, keeping
monitor_requires_iothread() for the decision in monitor_complete()
and the global mon_iothread for shared thread creation and cleanup.

By the way, any comments for other patches in this series?

Thanks
Chen

