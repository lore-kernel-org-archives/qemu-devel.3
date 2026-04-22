Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86ED4F9B5E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFTHQ-00053o-2z; Wed, 22 Apr 2026 04:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prtyagi@redhat.com>)
 id 1wFTHL-00053M-Pn
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prtyagi@redhat.com>)
 id 1wFTHJ-0005OV-T9
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776847788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tNkAcbWXWEw9ZDgYlv0BbsLbeoubW3bqnY7/+McjXGU=;
 b=D8lSFq8M0WFn91KQEVn9K+LFFQunOoLFmwvslnuR/O3V4gQtucnhwHTiYVsv8CKVrdkai3
 7arNSKqYp4coKP2NYt9CDi5D46tJTHWUy6e3K49KzCVWvLtbMO4YdfTNsUbfVQCjAnFDLd
 yn0gtqTbjKHFaBrLGa/Mjh+h9G+Wc0Y=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-wL1T8wpUMVGMwqyKZPHSUw-1; Wed, 22 Apr 2026 04:49:47 -0400
X-MC-Unique: wL1T8wpUMVGMwqyKZPHSUw-1
X-Mimecast-MFC-AGG-ID: wL1T8wpUMVGMwqyKZPHSUw_1776847786
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-671bcc1e533so4959460a12.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776847786; cv=none;
 d=google.com; s=arc-20240605;
 b=PgAlOZfJHKJElUkBCHz6Orm7DajevAOIvokqloy0UHm2X3NprltZFOAx7B2Ky42s2H
 75XidaCZSi4ZAklBa2hbUrFleekzQL1t990mJD+n4cU9D2lHQA5sT3LDC0pVg30R9p1l
 1ammwLOeXs6+OL+2rqG4SsAzhzi0+jK61LY59Z4hR6K/uLttY5Wo2AAOBKl8T9UIaFm7
 1pKXwaNT74AJvtpSwNkwFJnyeq+cFqxJSLp/IgpTUNODqBaJcp0sHE01qJ5sZfcNbzRN
 oV0XtAa5MGOkkEY/mwQEGbpt5wFiK/EuN+/jyMGhSu8Eb3Ex2WU2NBYI4cK7ajbkwqCe
 Gixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tNkAcbWXWEw9ZDgYlv0BbsLbeoubW3bqnY7/+McjXGU=;
 fh=tqeddvYnnfVFRES8/MufanmBVJwlsV6HFTbK+mWQ8lQ=;
 b=AD6D9Mi5cqTylcyEr0UWk+wYQMQhl2dKVd//Tvh8t+tctQVavxUGNaI99x0/3aaWBV
 yBeb2g00inQZkvJ5VVaSXIH4k2EsjkiNFvvJhrcTFY1lX+YDJ6MdfrQTLyKTeDLBE3og
 8cVWdx2QSzyh5Plo3zUwMk9sUWGxBFZoKyW8C3Qjtl4J5q4Xkl6QIhx4qmYaGzik7fKF
 7yWRxTEj+KtZ7qjzNde/RlAKrslCzocczncUBU+X8/mYA71LDlUcQMvkj17uJ10fwQZ7
 +ftIdQgyuH34Nm1j6t4r11SfjsnkbWlHSI21cTe7tnzwPfnV/Ol/y4KV0QJRNq2/j3S8
 9+Jg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776847786; x=1777452586; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tNkAcbWXWEw9ZDgYlv0BbsLbeoubW3bqnY7/+McjXGU=;
 b=j1wLTSotaoejHus4GNqPYXhAo/jJMhgDFJshRT4sseaorlD9sj/Uzoqvy6QxB6IvAx
 0+aW5DRe5p9Gmk9LX4aTiRnM3fbsXZkj8ZBMB2ag0+vd84HomnJuF3dsAGfO/nwsg6or
 imB60zO48OroZ0JgKDJ3XCJvcISOVRcEhtjBNWiO5ZNaMAOPfF5LbZjHgOetcnC3F79r
 DsH9J4OSgJ5+UR/ms9/mV4LmWrrn5BTy8CRcTmwziEgfoCzl/0mw0s4LDdjvRE4aPqx4
 yFsfpld8SUWFGhzqZ2/iPndrxt7iLro31Y7KqSe8UPzR7w2/+jJ/34QZGQeu+g8Miwzg
 4ePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776847786; x=1777452586;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tNkAcbWXWEw9ZDgYlv0BbsLbeoubW3bqnY7/+McjXGU=;
 b=hZ7Y2tStRmXHthuwypAuqYfNFr67tBhtet0j82Sb6iUvU8nuyXz2SlvEm5MC8ioOJZ
 Hbfz3McNxalMWr9nLnEcsnnH/cCsujRib+tW/J5l/dS/ugLIjuDtunIDZAghVAJ/a/+9
 aCO/wwdYl6xqkY9wQyL6Altz4CVg/B8NCYu4MyRNUHWL8haAwY7ue1F9oSUMX3lKmDZf
 EQfkn4pdTjLrLEFeUYCI6UZ9b+0hk7zFKVl21qeTmQV5vRqtUm5ANDtmJGntOtX8xvIc
 7vDx5fhvmLHdvEcPmR+bGAwNDmmW2X+pk2Ybzrq74pBjyB6gisLwb2J3G9VEgpt51Bnf
 Zuww==
X-Gm-Message-State: AOJu0YxU8opgQKt2yaUMu6+uVnklbzW+8uIz3QHs9kgqKOgKba0mVRkz
 jv7MnCq/JWarn1OVQbjS0VdDwBefUV9CG4hvvXxwdDAp61+v0G0sDC0oe1HydtcLPP/W4WDlsrE
 fVAG54ungVlTbGiAjbEcy80qoPGg0aewnShjv2TrWNnse5osrxS6MnkkfWMjrDzDWols0mhCVuW
 3yUyiRpSy2GpgbHiLZL2YtxefBdiKMpv4=
X-Gm-Gg: AeBDiesG/YFU7sAsfOB3YvapmPCzHafTzO4dt0MFl+kL7hsjhJUbYz5Sh8Cb8RgnjsP
 dNAlTtbchSzfC/NuiUGOZmw+urc8MkedIawemW8FTXnrClF4Ol7a8oU74vs8MAMDl9gvTYJ516I
 ZeHS0j7ExbGPqj+XbofbZfTET8jSsakQHbnkIyWMR449d2OGGa/hfZW2DMPw3gwzStErcKeaMKM
 fGZ+UwosSUS/vjL5l4=
X-Received: by 2002:a05:6402:13cf:b0:66b:e8e5:4628 with SMTP id
 4fb4d7f45d1cf-672bfdd8b9emr10166081a12.20.1776847785795; 
 Wed, 22 Apr 2026 01:49:45 -0700 (PDT)
X-Received: by 2002:a05:6402:13cf:b0:66b:e8e5:4628 with SMTP id
 4fb4d7f45d1cf-672bfdd8b9emr10166066a12.20.1776847785293; Wed, 22 Apr 2026
 01:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260421052227.8278-1-prtyagi@redhat.com>
 <aefrPBN7k94Jj2dh@x1.local>
In-Reply-To: <aefrPBN7k94Jj2dh@x1.local>
From: Pranav Tyagi <prtyagi@redhat.com>
Date: Wed, 22 Apr 2026 14:19:33 +0530
X-Gm-Features: AQROBzDRDrTLFK11eXc1T2T-D5zqW0fUBP5819oE1Eeh6vsBBahCRJEnTQABbjc
Message-ID: <CALY4kkSJRqTpcBwe2UAJHJQBQGU7Tt1oWnX3nUECUKZPA=g3eA@mail.gmail.com>
Subject: Re: [PATCH] migration: Fix blocking in POSTCOPY_DEVICE during package
 load
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001018910650089d32"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=prtyagi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

--0000000000001018910650089d32
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 2:55=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:

> On Tue, Apr 21, 2026 at 10:52:27AM +0530, Pranav Tyagi wrote:
> > The package_loaded event is not set in case MIG_RP_MSG_PONG does not
> > arrive on the source from the destination in the return path thread. Th=
e
> > migration thread would then be blocked waiting for package_loaded event
> > indefinitely in POSTCOPY_DEVICE state. Where as, in such a condition th=
e
> > source VM can safely resume as the destination has not yet started. The
> > pong message can get lost in case of a network failure or destination
> > crash before sending the pong.
> >
> > This patch uses the error detected in case of network failure or
> > destination crash to set the package_loaded event in the out path of th=
e
> > return path thread. This will kick the migration thread out from
> > a condition of indefinitely waiting for the package_loaded event. The
> > migration thread then fails early and breaks from the migration loop to
> > resume the VM on the source side.
> >
> > Fixes: 7b842fe354c6 ("migration: Introduce POSTCOPY_DEVICE state")
> > Signed-off-by: Pranav Tyagi <prtyagi@redhat.com>
>
> Ah I see.. thanks for figuring this out.
>
> > ---
> >  migration/migration.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 5c9aaa6e58..1656c1203c 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -2386,6 +2386,15 @@ out:
> >      if (err) {
> >          migrate_error_propagate(ms, err);
> >          trace_source_return_path_thread_bad_end();
> > +        if (ms->state =3D=3D MIGRATION_STATUS_POSTCOPY_DEVICE) {
> > +            /*
> > +             * Kick the migration thread if it gets stuck in
> > +             * POSTCOPY_DEVICE state waiting for
> > +             * postcopy_package_loaded_event. The event will never be
> > +             * set as MIG_RP_MSG_PONG from the destination is lost.
> > +             */
> > +            qemu_event_set(&ms->postcopy_package_loaded_event);
> > +        }
>
> This makes sense.  Said that, we have another similar case right below fo=
r
> the postcopy recover path:
>
>     if (ms->state =3D=3D MIGRATION_STATUS_POSTCOPY_RECOVER) {
>         /*
>          * this will be extremely unlikely: that we got yet another netwo=
rk
>          * issue during recovering of the 1st network failure.. during th=
is
>          * period the main migration thread can be waiting on rp_sem for
>          * this thread to sync with the other side.
>          *
>          * When this happens, explicitly kick the migration thread out of
>          * RECOVER stage and back to PAUSED, so the admin can try
>          * everything again.
>          */
>         migration_rp_kick(ms);
>     }
>
> It achieves some similar goal, where the migration thread is waiting for
> some event from return path thread, and when the channel is broken we wan=
t
> to kick it out.
>
> I'm thinking if we can reuse that, instead of kicking multiple events.
>
> Say, we can do migration_rp_kick() for both POSTCOPY_RECOVER and
> POSTCOPY_DEVICE states in the rp thread.  Meanwhile at below..
>
> >      }
> >
> >      if (ms->state =3D=3D MIGRATION_STATUS_POSTCOPY_RECOVER) {
> > @@ -3232,6 +3241,17 @@ static MigIterateState
> migration_iteration_run(MigrationState *s)
> >               * package before actually completing.
> >               */
> >              qemu_event_wait(&s->postcopy_package_loaded_event);
> > +            /*
> > +             * Check for errors in case the migration thread was stuck
> in
> > +             * POSTCOPY_DEVICE state waiting for the
> > +             * postcopy_package_loaded_event which was never set.
> > +             * If so, fail now and break out of the iteration.
> > +             */
> > +            if (migrate_has_error(s)) {
> > +                migrate_set_state(&s->state,
> MIGRATION_STATUS_POSTCOPY_DEVICE,
> > +                                  MIGRATION_STATUS_FAILING);
> > +                return MIG_ITERATE_BREAK;
> > +            }
>
> ... instead of waiting on postcopy_package_loaded_event, we can do:
>
>     while (!s->postcopy_package_loaded) {
>         if (migration_rp_wait(s)) {
>             /* Error happened */
>             migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_DEVICE=
,
>                               MIGRATION_STATUS_FAILING);
>             return MIG_ITERATE_BREAK;
>         }
>     }
>     /* Acknowledgement received from dest */
>     migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
>                       MIGRATION_STATUS_POSTCOPY_ACTIVE);
>
> PS: I think event also works in this case, so likely either one shared se=
m
> or event should work; it's just that it was a sem before, and rp_sem has =
a
> name that is generic enough to apply directly to the
> postcopy_package_loaded_event use case.
>
> Thanks,
>
> >              migrate_set_state(&s->state,
> MIGRATION_STATUS_POSTCOPY_DEVICE,
> >                                MIGRATION_STATUS_POSTCOPY_ACTIVE);
> >          }
> > --
> > 2.53.0
> >
>
> --
> Peter Xu
>
>
Thanks for the feedback Peter. I will update the patch accordingly and
send it again.

Regards
Pranav Tyagi

--0000000000001018910650089d32
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 22,=
 2026 at 2:55=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">=
peterx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Tue, Apr 21, 2026 at 10:52:27AM +0530, Pranav Tyagi wro=
te:<br>
&gt; The package_loaded event is not set in case MIG_RP_MSG_PONG does not<b=
r>
&gt; arrive on the source from the destination in the return path thread. T=
he<br>
&gt; migration thread would then be blocked waiting for package_loaded even=
t<br>
&gt; indefinitely in POSTCOPY_DEVICE state. Where as, in such a condition t=
he<br>
&gt; source VM can safely resume as the destination has not yet started. Th=
e<br>
&gt; pong message can get lost in case of a network failure or destination<=
br>
&gt; crash before sending the pong.<br>
&gt; <br>
&gt; This patch uses the error detected in case of network failure or<br>
&gt; destination crash to set the package_loaded event in the out path of t=
he<br>
&gt; return path thread. This will kick the migration thread out from<br>
&gt; a condition of indefinitely waiting for the package_loaded event. The<=
br>
&gt; migration thread then fails early and breaks from the migration loop t=
o<br>
&gt; resume the VM on the source side.<br>
&gt; <br>
&gt; Fixes: 7b842fe354c6 (&quot;migration: Introduce POSTCOPY_DEVICE state&=
quot;)<br>
&gt; Signed-off-by: Pranav Tyagi &lt;<a href=3D"mailto:prtyagi@redhat.com" =
target=3D"_blank">prtyagi@redhat.com</a>&gt;<br>
<br>
Ah I see.. thanks for figuring this out.<br>
<br>
&gt; ---<br>
&gt;=C2=A0 migration/migration.c | 20 ++++++++++++++++++++<br>
&gt;=C2=A0 1 file changed, 20 insertions(+)<br>
&gt; <br>
&gt; diff --git a/migration/migration.c b/migration/migration.c<br>
&gt; index 5c9aaa6e58..1656c1203c 100644<br>
&gt; --- a/migration/migration.c<br>
&gt; +++ b/migration/migration.c<br>
&gt; @@ -2386,6 +2386,15 @@ out:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (err) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migrate_error_propagate(ms, err);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_source_return_path_thread_bad_=
end();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ms-&gt;state =3D=3D MIGRATION_STATUS_=
POSTCOPY_DEVICE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Kick the migration =
thread if it gets stuck in<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* POSTCOPY_DEVICE sta=
te waiting for<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* postcopy_package_lo=
aded_event. The event will never be<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* set as MIG_RP_MSG_P=
ONG from the destination is lost.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_event_set(&amp;ms-&gt;=
postcopy_package_loaded_event);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
This makes sense.=C2=A0 Said that, we have another similar case right below=
 for<br>
the postcopy recover path:<br>
<br>
=C2=A0 =C2=A0 if (ms-&gt;state =3D=3D MIGRATION_STATUS_POSTCOPY_RECOVER) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* this will be extremely unlikely: that w=
e got yet another network<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* issue during recovering of the 1st netw=
ork failure.. during this<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* period the main migration thread can be=
 waiting on rp_sem for<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* this thread to sync with the other side=
.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* When this happens, explicitly kick the =
migration thread out of<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* RECOVER stage and back to PAUSED, so th=
e admin can try<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* everything again.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_rp_kick(ms);<br>
=C2=A0 =C2=A0 }<br>
<br>
It achieves some similar goal, where the migration thread is waiting for<br=
>
some event from return path thread, and when the channel is broken we want<=
br>
to kick it out.<br>
<br>
I&#39;m thinking if we can reuse that, instead of kicking multiple events.<=
br>
<br>
Say, we can do migration_rp_kick() for both POSTCOPY_RECOVER and<br>
POSTCOPY_DEVICE states in the rp thread.=C2=A0 Meanwhile at below..<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (ms-&gt;state =3D=3D MIGRATION_STATUS_POSTCOPY_=
RECOVER) {<br>
&gt; @@ -3232,6 +3241,17 @@ static MigIterateState migration_iteration_run(=
MigrationState *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* package before=
 actually completing.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_event_wait(&amp;s=
-&gt;postcopy_package_loaded_event);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Check for errors in=
 case the migration thread was stuck in<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* POSTCOPY_DEVICE sta=
te waiting for the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* postcopy_package_lo=
aded_event which was never set.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If so, fail now and=
 break out of the iteration.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (migrate_has_error(s)) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migrate_set_s=
tate(&amp;s-&gt;state, MIGRATION_STATUS_POSTCOPY_DEVICE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MIGRATION_STATUS_FAILING)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return MIG_IT=
ERATE_BREAK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
... instead of waiting on postcopy_package_loaded_event, we can do:<br>
<br>
=C2=A0 =C2=A0 while (!s-&gt;postcopy_package_loaded) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (migration_rp_wait(s)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Error happened */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migrate_set_state(&amp;s-&gt;stat=
e, MIGRATION_STATUS_POSTCOPY_DEVICE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MIGRATION_STATUS_FAILING);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return MIG_ITERATE_BREAK;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 /* Acknowledgement received from dest */<br>
=C2=A0 =C2=A0 migrate_set_state(&amp;s-&gt;state, MIGRATION_STATUS_POSTCOPY=
_DEVICE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 MIGRATION_STATUS_POSTCOPY_ACTIVE);<br>
<br>
PS: I think event also works in this case, so likely either one shared sem<=
br>
or event should work; it&#39;s just that it was a sem before, and rp_sem ha=
s a<br>
name that is generic enough to apply directly to the<br>
postcopy_package_loaded_event use case.<br>
<br>
Thanks,<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migrate_set_state(&amp=
;s-&gt;state, MIGRATION_STATUS_POSTCOPY_DEVICE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MIGRATION_STATUS_POSTCOPY_ACTIVE)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -- <br>
&gt; 2.53.0<br>
&gt; <br>
<br>
-- <br>
Peter Xu<br><br></blockquote><div><br></div><div>Thanks for the feedback Pe=
ter. I will update the patch accordingly and<br></div><div>send it again.<b=
r><br></div><div>Regards<br></div><div>Pranav Tyagi</div></div></div>

--0000000000001018910650089d32--


