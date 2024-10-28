Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1946D3398B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5QVO-00042k-M1; Mon, 28 Oct 2024 10:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t5QVM-000426-F1
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:14:00 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t5QVH-00021L-OD
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:14:00 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3e5f533e1c2so2392022b6e.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730124834; x=1730729634;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y93YzI1ugSdY/e5WwShuOOXxhsZP9ZsiKEyuBBYrS3U=;
 b=E6CoEjLXcmSpvUGXlfRlj2u4UCVJ7QwHdsMlWStv2gtNNN5ucanyRC6IFHKH8gPurl
 NYRdpRBS0ibuqEIB7lkAV9ESFyxkZoY7M7p1Nyc5RPp6XDVAAgLIY7gugWZ1HKWWtoZO
 /shME6RlrbjSWFOJdvTWsntPmUY0ND8RlZHIWg3cRI/4HI+mfDoVc3mEhPXRd5WkJXeh
 1vEoJh8EX0FqpHIM6GkbMI5eJFoOk4TtoOeGWWV/inHin8mWsHymSsNCnQNo09x5b9wb
 I5FKQFUKyej0xmJUnCqWkO4VvbI6O5y2HFRhMtPgAgw0oOs1uDjQYdlSRLg6c/vlIzMi
 A9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730124834; x=1730729634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y93YzI1ugSdY/e5WwShuOOXxhsZP9ZsiKEyuBBYrS3U=;
 b=LWz7+XG9OMWoTJzkVWGysRPr1J7MlixgKvrVt0cqcq3ro9xuKuZTnT5aZaG4jV7ZKM
 9QFAInTJNzy9kxXtrWj1IYiWpKRIcG/9P9KiAoM7jI4B1tYFTbMmvNCSYQcgGgKz3myH
 LddiUUkLAteh1tlw14qOzHsp/v19XA+SaINsoYVjiJAeuvsRa9HOUax6NcJuOiy9iGjX
 RjMlSYUEoC04l68GWTkVTHGndb5SFwbVtlWNzx0tiZ61UG0JLioiZunXJA/HEUgFzJmB
 Ib7zAYVOU8EYgCreERf6yoEK5qdmdg7OAxmqOUOa/Hky+2g5I3sIUtBtYqUP1WvTLJkv
 W3Sw==
X-Gm-Message-State: AOJu0YzOcERfQCoVWCDPsOtr2HcILV69vqDQC2WCeUSbiddjhWBV/yAD
 pcVN01gO/oUtvyZiGOPvxU7gK3AHci30AlwQXlvPwjbozxjT6TiaB0oHHrzRDShOv1FAahdxmLm
 78s7lFeufwc8NjqQ84rqbkkVNRQN106xEs4Z7
X-Google-Smtp-Source: AGHT+IFcAIUIvR6yF9KmqwOuO5mPQtkNQywZDryziUw5lgb8GfIIuCJ3vlEVOLU1PB3pKYAnkEJr1UllDkY8o+SD5iI=
X-Received: by 2002:a05:6808:23c6:b0:3e5:ef2d:f53b with SMTP id
 5614622812f47-3e638248906mr6869107b6e.11.1730124833851; Mon, 28 Oct 2024
 07:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241024102813.9855-1-phil@philjordan.eu>
 <20241024102813.9855-3-phil@philjordan.eu>
 <9e310d5e-ab73-47b9-b9ed-5a16d4db3fb9@daynix.com>
 <CAAibmn0NA+K63OvrsBpN1HivndyZo-fgeLwzY8AVE4hPrQR26w@mail.gmail.com>
 <dd2aae75-348d-44ad-bbd9-5d45aad15bc6@daynix.com>
 <CAAibmn1z+7yizwH8DogfcCWOWzA8Ox6e=p+Hc1pu-CS4SjAirg@mail.gmail.com>
 <6a989d04-6416-4bd9-98ac-e1230a1095a9@daynix.com>
 <CAAibmn3YEOT0O55-bwJkpi_oEGkA1WwvhC0w3jGbgXOZLTVa0w@mail.gmail.com>
 <CAAibmn3HZeDeK8FrYhHa1GGwc+N8rBuB2VvMRm7LCt0mUGmsYQ@mail.gmail.com>
 <27ced2db-472d-47ae-9047-9efc0b589a1e@daynix.com>
In-Reply-To: <27ced2db-472d-47ae-9047-9efc0b589a1e@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Mon, 28 Oct 2024 15:13:41 +0100
Message-ID: <CAAibmn17=iTaEW0Q_E_n6gsS7vd-d8-w36yee9f2eZ+SR-d-ng@mail.gmail.com>
Subject: Re: [PATCH v4 02/15] hw/display/apple-gfx: Introduce
 ParavirtualizedGraphics.Framework support
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com, 
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, 
 shorne@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org, Alexander Graf <graf@amazon.com>
Content-Type: multipart/alternative; boundary="00000000000023a42106258a148f"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::22a;
 envelope-from=phil@philjordan.eu; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--00000000000023a42106258a148f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Oct 2024 at 15:02, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> On 2024/10/28 22:31, Phil Dennis-Jordan wrote:
> >
> >
> > On Mon, 28 Oct 2024 at 10:00, Phil Dennis-Jordan <phil@philjordan.eu
> > <mailto:phil@philjordan.eu>> wrote:
> >
> >
> >          >      >
> >          >      > Hmm. I think if we were to use that, we would need to
> >         create a new
> >          >      > QemuEvent for every job and destroy it afterward,
> >         which seems
> >          >     expensive.
> >          >      > We can't rule out multiple concurrent jobs being
> >         submitted, and the
> >          >      > QemuEvent system only supports a single producer as
> >         far as I can
> >          >     tell.
> >          >      >
> >          >      > You can probably sort of hack around it with just one
> >         QemuEvent by
> >          >      > putting the qemu_event_wait into a loop and turning
> >         the job.done
> >          >     flag
> >          >      > into an atomic (because it would now need to be
> >         checked outside the
> >          >      > lock) but this all seems unnecessarily complicated
> >         considering the
> >          >      > QemuEvent uses the same mechanism QemuCond/QemuMutex
> >         internally
> >          >     on macOS
> >          >      > (the only platform relevant here), except we can use
> it as
> >          >     intended with
> >          >      > QemuCond/QemuMutex rather than having to work against
> the
> >          >     abstraction.
> >          >
> >          >     I don't think it's going to be used concurrently. It
> >         would be difficult
> >          >     to reason even for the framework if it performs memory
> >          >     unmapping/mapping/reading operations concurrently.
> >          >
> >          >
> >          > I've just performed a very quick test by wrapping the job
> >         submission/
> >          > wait in the 2 mapMemory callbacks and the 1 readMemory
> >         callback with
> >          > atomic counters and logging whenever a counter went above 1.
> >          >
> >          >   * Overall, concurrent callbacks across all types were
> >         common (many per
> >          > second when the VM is busy). It's not exactly a "thundering
> >         herd" (I
> >          > never saw >2) but it's probably not a bad idea to use a
> separate
> >          > condition variable for each job type. (task map, surface map=
,
> >         memory read)
> >          >   * While I did not observe any concurrent memory mapping
> >         operations
> >          > *within* a type of memory map (2 task mappings or 2 surface
> >         mappings) I
> >          > did see very occasional concurrent memory *read* callbacks.
> >         These would,
> >          > as far as I can tell, not be safe with QemuEvents, unless we
> >         placed the
> >          > event inside the job struct and init/destroyed it on every
> >         callback
> >          > (which seems like excessive overhead).
> >
> >         I think we can tolerate that overhead. init/destroy essentially
> >         sets the
> >         fields in the data structure and I estimate its total size is
> >         about 100
> >         bytes. It is probably better than waking an irrelevant thread
> >         up. I also
> >         hope that keeps the code simple; it's not worthwhile adding cod=
e
> to
> >         optimize this.
> >
> >
> >     At least pthread_cond_{init,destroy} and
> >     pthread_mutex_{init,destroy} don't make any syscalls, so yeah it's
> >     probably an acceptable overhead.
> >
> >
> > I've just experimented with QemuEvents created on-demand and ran into
> > some weird deadlocks, which then made me sit down and think about it
> > some more. I've come to the conclusion that creating (and crucially,
> > destroying) QemuEvents on demand in this way is not safe.
> >
> > Specifically, you must not call qemu_event_destroy() - which
> > transitively destroys the mutex and condition variable - unless you can
> > guarantee that the qemu_event_set() call on that event object has
> completed.
> >
> > In qemu_event_set, the event object's value is atomically set to EV_SET=
.
> > If the previous value was EV_BUSY, qemu_futex_wake() is called. All of
> > this is outside any mutex, however, so apart from memory coherence
> > (there are barriers) this can race with the waiting thread.
> > qemu_event_wait() reads the event's value. If EV_FREE, it's atomically
> > set to EV_BUSY. Then the mutex is locked, the value is checked again,
> > and if it's still EV_BUSY, it waits for the condition variable,
> > otherwise the mutex is immediately unlocked again. If the trigger
> > thread's qemu_event_set() flip to EV_SET occurs between the waiting
> > thread's two atomic reads of the value, the waiting thread will never
> > wait for the condition variable, but the trigger thread WILL try to
> > acquire the mutex and signal the condition variable in
> > qemu_futex_wake(), by which  time the waiting thread may have advanced
> > outside of qemu_event_wait().
>
> Sorry if I'm making a mistake again, but the waiting thread won't set to
> EV_BUSY unless the value is EV_FREE on the second read so the trigger
> thread will not call qemu_futex_wake() if it manages to set to EV_SET
> before the second read, will it?
>

This sequence of events will cause the problem:

WAITER (in qemu_event_wait):
value =3D qatomic_load_acquire(&ev->value);
-> EV_FREE

TRIGGER (in qemu_event_set):
qatomic_read(&ev->value) !=3D EV_SET
-> EV_FREE (condition is false)

WAITER:
qatomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) =3D=3D EV_SET
-> cmpxchg returns EV_FREE, condition false.
ev->value =3D  EV_BUSY.

TRIGGER:
        int old =3D qatomic_xchg(&ev->value, EV_SET);
        smp_mb__after_rmw();
        if (old =3D=3D EV_BUSY) {
-> old =3D EV_BUSY, condition true.
ev->value =3D EV_SET

WAITER (in qemu_futex_wait(ev, EV_BUSY)):
    pthread_mutex_lock(&ev->lock);
    if (ev->value =3D=3D val) {
-> false, because value is EV_SET

WAITER:
    pthread_mutex_unlock(&ev->lock);
    =E2=80=A6
    qemu_event_destroy(&job->done_event);

TRIGGER (in qemu_futex_wake(ev, INT_MAX)):
    pthread_mutex_lock(&ev->lock);
-> hangs, because mutex has been destroyed

>
> > This is all fine usually, BUT if you destroy the QemuEvent immediately
> > after the qemu_event_wait() call, qemu_futex_wake() may try to lock a
> > mutex that has been destroyed, or signal a condition variable which has
> > been destroyed. I don't see a reasonable way of making this safe other
> > than using long-lived mutexes and condition variables. And anyway, we
> > have much, MUCH bigger contention/performance issues coming from almost
> > everything being covered by the BQL. (If waking these callbacks can eve=
n
> > be considered an issue: I haven't seen it show up in profiling, whereas
> > BQL contention very much does.)
> >
> > I'll submit v5 of this patch set with separate condition variables for
> > each job type. This should make the occurrence of waking the wrong
> > thread quite rare, while reasoning about correctness is pretty
> > straightforward. I think that's good enough.
> >
> >
> >
>
>

--00000000000023a42106258a148f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Mon, 28 Oct 2024 at 15:02, Akihiko Odaki &lt;<a href=3D"=
mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On 2024/10/28 22:3=
1, Phil Dennis-Jordan wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Mon, 28 Oct 2024 at 10:00, Phil Dennis-Jordan &lt;<a href=3D"mailto=
:phil@philjordan.eu" target=3D"_blank">phil@philjordan.eu</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:phil@philjordan.eu" target=3D"_blank">phi=
l@philjordan.eu</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hmm. I=
 think if we were to use that, we would need to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0create a new<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; QemuEv=
ent for every job and destroy it afterward,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0which seems<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0expensive.<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; We can=
&#39;t rule out multiple concurrent jobs being<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0submitted, and the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; QemuEv=
ent system only supports a single producer as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0far as I can<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tell.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; You ca=
n probably sort of hack around it with just one<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QemuEvent by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; puttin=
g the qemu_event_wait into a loop and turning<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the job.done<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0flag<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; into a=
n atomic (because it would now need to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0checked outside the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; lock) =
but this all seems unnecessarily complicated<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0considering the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; QemuEv=
ent uses the same mechanism QemuCond/QemuMutex<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0internally<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0on macOS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; (the o=
nly platform relevant here), except we can use it as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0intended wit=
h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; QemuCo=
nd/QemuMutex rather than having to work against the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0abstraction.=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0I don&#39;t =
think it&#39;s going to be used concurrently. It<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0would be difficult<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0to reason ev=
en for the framework if it performs memory<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0unmapping/ma=
pping/reading operations concurrently.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; I&#39;ve just performed a very =
quick test by wrapping the job<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0submission/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; wait in the 2 mapMemory callbac=
ks and the 1 readMemory<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0callback with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; atomic counters and logging whe=
never a counter went above 1.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Overall, concurre=
nt callbacks across all types were<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0common (many per<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; second when the VM is busy). It=
&#39;s not exactly a &quot;thundering<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0herd&quot; (I<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; never saw &gt;2) but it&#39;s p=
robably not a bad idea to use a separate<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; condition variable for each job=
 type. (task map, surface map,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory read)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* While I did not o=
bserve any concurrent memory mapping<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0operations<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; *within* a type of memory map (=
2 task mappings or 2 surface<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mappings) I<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; did see very occasional concurr=
ent memory *read* callbacks.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0These would,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; as far as I can tell, not be sa=
fe with QemuEvents, unless we<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0placed the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; event inside the job struct and=
 init/destroyed it on every<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0callback<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; (which seems like excessive ove=
rhead).<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I think we can tolerate that overhead=
. init/destroy essentially<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sets the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fields in the data structure and I es=
timate its total size is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0about 100<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bytes. It is probably better than wak=
ing an irrelevant thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0up. I also<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hope that keeps the code simple; it&#=
39;s not worthwhile adding code to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0optimize this.<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0At least pthread_cond_{init,destroy} and<br>
&gt;=C2=A0 =C2=A0 =C2=A0pthread_mutex_{init,destroy} don&#39;t make any sys=
calls, so yeah it&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0probably an acceptable overhead.<br>
&gt; <br>
&gt; <br>
&gt; I&#39;ve just experimented with QemuEvents created on-demand and ran i=
nto <br>
&gt; some weird deadlocks, which then made me sit down and think about it <=
br>
&gt; some more. I&#39;ve come to the conclusion that creating (and cruciall=
y, <br>
&gt; destroying) QemuEvents on demand in this way is not safe.<br>
&gt; <br>
&gt; Specifically, you must not call qemu_event_destroy() - which <br>
&gt; transitively destroys the mutex and condition variable - unless you ca=
n <br>
&gt; guarantee that the qemu_event_set() call on that event object has comp=
leted.<br>
&gt; <br>
&gt; In qemu_event_set, the event object&#39;s value is atomically set to E=
V_SET. <br>
&gt; If the previous value was EV_BUSY, qemu_futex_wake() is called. All of=
 <br>
&gt; this is outside any mutex, however, so apart from memory coherence <br=
>
&gt; (there are barriers) this can race with the waiting thread. <br>
&gt; qemu_event_wait() reads the event&#39;s value. If EV_FREE, it&#39;s at=
omically <br>
&gt; set to EV_BUSY. Then the mutex is locked, the value is checked again, =
<br>
&gt; and if it&#39;s still EV_BUSY, it waits for the condition variable, <b=
r>
&gt; otherwise the mutex is immediately unlocked again. If the trigger <br>
&gt; thread&#39;s qemu_event_set() flip to EV_SET occurs between the waitin=
g <br>
&gt; thread&#39;s two atomic reads of the value, the waiting thread will ne=
ver <br>
&gt; wait for the condition variable, but the trigger thread WILL try to <b=
r>
&gt; acquire the mutex and signal the condition variable in <br>
&gt; qemu_futex_wake(), by which=C2=A0 time the waiting thread may have adv=
anced <br>
&gt; outside of qemu_event_wait().<br>
<br>
Sorry if I&#39;m making a mistake again, but the waiting thread won&#39;t s=
et to <br>
EV_BUSY unless the value is EV_FREE on the second read so the trigger <br>
thread will not call qemu_futex_wake() if it manages to set to EV_SET <br>
before the second read, will it?<br></blockquote><div><br></div><div>This s=
equence of events will cause the problem:<br></div><div><br></div><div>WAIT=
ER (in qemu_event_wait):</div><div>value =3D qatomic_load_acquire(&amp;ev-&=
gt;value);</div><div>-&gt; EV_FREE</div><div><br></div><div>TRIGGER (in qem=
u_event_set): <br></div><div>qatomic_read(&amp;ev-&gt;value) !=3D EV_SET</d=
iv><div>-&gt; EV_FREE (condition is false)</div><div><br></div><div>WAITER:=
</div><div>qatomic_cmpxchg(&amp;ev-&gt;value, EV_FREE, EV_BUSY) =3D=3D EV_S=
ET<br></div><div>-&gt; cmpxchg returns EV_FREE, condition false.</div><div>=
ev-&gt;value =3D=C2=A0 EV_BUSY.</div><div><br></div><div>TRIGGER:</div><div=
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int old =3D qatomic_xchg(&amp;e=
v-&gt;value, EV_SET);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 smp_mb__after_r=
mw();<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (old =3D=3D EV_BUSY) {<br>-&gt; old=
 =3D EV_BUSY, condition true.</div><div>ev-&gt;value =3D EV_SET</div><div><=
br></div><div>WAITER (in qemu_futex_wait(ev, EV_BUSY)):<br></div><div>=C2=
=A0 =C2=A0 pthread_mutex_lock(&amp;ev-&gt;lock);<br>=C2=A0 =C2=A0 if (ev-&g=
t;value =3D=3D val) {</div><div>-&gt; false, because value is EV_SET</div><=
div><br></div><div>WAITER:</div><div>=C2=A0 =C2=A0 pthread_mutex_unlock(&am=
p;ev-&gt;lock);</div><div>=C2=A0=C2=A0=C2=A0 =E2=80=A6</div><div>=C2=A0=C2=
=A0=C2=A0 qemu_event_destroy(&amp;job-&gt;done_event);</div><div><br></div>=
<div>TRIGGER (in qemu_futex_wake(ev, INT_MAX)): <br></div><div>=C2=A0 =C2=
=A0 pthread_mutex_lock(&amp;ev-&gt;lock);</div><div>-&gt; hangs, because mu=
tex has been destroyed<br> </div><div><br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
&gt; <br>
&gt; This is all fine usually, BUT if you destroy the QemuEvent immediately=
 <br>
&gt; after the qemu_event_wait() call, qemu_futex_wake() may try to lock a =
<br>
&gt; mutex that has been destroyed, or signal a condition variable which ha=
s <br>
&gt; been destroyed. I don&#39;t see a reasonable way of making this safe o=
ther <br>
&gt; than using long-lived mutexes and condition variables. And anyway, we =
<br>
&gt; have much, MUCH bigger contention/performance issues coming from almos=
t <br>
&gt; everything being covered by the BQL. (If waking these callbacks can ev=
en <br>
&gt; be considered an issue: I haven&#39;t seen it show up in profiling, wh=
ereas <br>
&gt; BQL contention very much does.)<br>
&gt; <br>
&gt; I&#39;ll submit v5 of this patch set with separate condition variables=
 for <br>
&gt; each job type. This should make the occurrence of waking the wrong <br=
>
&gt; thread quite rare, while reasoning about correctness is pretty <br>
&gt; straightforward. I think that&#39;s good enough.<br>
&gt; <br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div>

--00000000000023a42106258a148f--

