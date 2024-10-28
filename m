Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E94BD5B154
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 21:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Wwh-0001Hn-UW; Mon, 28 Oct 2024 17:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t5Wwc-0001HA-SK
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 17:06:34 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t5Wwa-0003dP-5V
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 17:06:34 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-50c9f4efd09so1454321e0c.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 14:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730149589; x=1730754389;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yj5+M6E4HrsSXZW2J02GB6OTLvWc1Umx2GfEKflB6xI=;
 b=0EsabL8PVJZBR0F7fX8z6Tmh4ynjF9s38jyiCfEuIEkIG5EV3Xyh6CU/4eOhS5YH/Y
 f9ew1OrEOP3nqmYMy10npDgVeMFwbJZFIh/z96YnM8/CEPurgBKaTDnl+2sz/WhrnFRA
 CyfYG/j3n9CBxVa15nspoHWAf2609mv2uq/lGjU3d/Rkdo2m7bIMVCwDsw60pieWS+kf
 DDyqvY6zQSmlIxnAq4/NdO5L6SMOj/388rtnzFFfhzM15Dvxdz2flf1OKF1iZrwcut5t
 /m1uInNONy7HjxN64A9zD9sS3ygXbc/juhNKREeFPwwWNvhfjl+EuxGHYLDFxih82n1N
 Oi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730149589; x=1730754389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yj5+M6E4HrsSXZW2J02GB6OTLvWc1Umx2GfEKflB6xI=;
 b=qIxzc5GxF9TMiPbG4GnO+foCQoUU7kyuV8dIdktpWaXZrAkZIP5Bon7SU65Rhqs86W
 pNYkmmmSEfWKry8HdoRjXut3q3HNwpQAZRJFLq1/9rf4ZdeaN4KYOciwU+JXTQY6WXKO
 W3KgMBpd7m4k7R5dIo5k9m9io1YO8UUkw5zMNTJrgq54DwspzLibkE2BM7YgO62ze9hL
 KKtqx4CnTvkDhmZ4fayGd/GzgFCib3A3BX2eJswymrloDLpb4riW1SCV6XsLpWc6j8F+
 oWSMf3F/O2zQGS98AafYG8ZLrWVK7Xeu9+LU4PctQ6KfZ0SglA8mfJZvD+hUKsU/ARHb
 SSkQ==
X-Gm-Message-State: AOJu0YwbYSK+vBkF8K/kpZI5UDzH9Et3oHbrK4gBpKhgalxYn/2Fz++0
 OsDo6ZyPGxr55ulJyYD5wNUUvcuYx/RnbjFnTQuB5vu+eTuxrWLQwA43LZQFdxEZ6SVDyBitJZT
 D0tohdObiTMycLw+BZdRv6EaqrPac87WobJ1k
X-Google-Smtp-Source: AGHT+IFfGPEKpdS9lEhh0EbVwP9c1lLjtfWfTKYfRN8CnjEZl0IAEqc+yl8+/ZrcTHJmWpcB4BpU9Wvc176WIC4aO+Q=
X-Received: by 2002:a05:6122:21a9:b0:507:9165:209 with SMTP id
 71dfb90a1353d-5101504f211mr6071857e0c.7.1730149589278; Mon, 28 Oct 2024
 14:06:29 -0700 (PDT)
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
 <CAAibmn17=iTaEW0Q_E_n6gsS7vd-d8-w36yee9f2eZ+SR-d-ng@mail.gmail.com>
 <dbb394d4-f8fe-484d-974c-c84275f7a1c7@daynix.com>
In-Reply-To: <dbb394d4-f8fe-484d-974c-c84275f7a1c7@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Mon, 28 Oct 2024 22:06:18 +0100
Message-ID: <CAAibmn1Th6w6JJcxgD7HA62qo-Lk0yV-Cg4XK9OYEtDvvQbhrg@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000ad82a306258fd765"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a36;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa36.google.com
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

--000000000000ad82a306258fd765
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Oct 2024 at 17:06, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> On 2024/10/28 23:13, Phil Dennis-Jordan wrote:
> >
> >
> > On Mon, 28 Oct 2024 at 15:02, Akihiko Odaki <akihiko.odaki@daynix.com
> > <mailto:akihiko.odaki@daynix.com>> wrote:
> >
> >     On 2024/10/28 22:31, Phil Dennis-Jordan wrote:
> >      >
> >      >
> >      > On Mon, 28 Oct 2024 at 10:00, Phil Dennis-Jordan
> >     <phil@philjordan.eu <mailto:phil@philjordan.eu>
> >      > <mailto:phil@philjordan.eu <mailto:phil@philjordan.eu>>> wrote:
> >      >
> >      >
> >      >          >      >
> >      >          >      > Hmm. I think if we were to use that, we would
> >     need to
> >      >         create a new
> >      >          >      > QemuEvent for every job and destroy it
> afterward,
> >      >         which seems
> >      >          >     expensive.
> >      >          >      > We can't rule out multiple concurrent jobs bei=
ng
> >      >         submitted, and the
> >      >          >      > QemuEvent system only supports a single
> producer as
> >      >         far as I can
> >      >          >     tell.
> >      >          >      >
> >      >          >      > You can probably sort of hack around it with
> >     just one
> >      >         QemuEvent by
> >      >          >      > putting the qemu_event_wait into a loop and
> turning
> >      >         the job.done
> >      >          >     flag
> >      >          >      > into an atomic (because it would now need to b=
e
> >      >         checked outside the
> >      >          >      > lock) but this all seems unnecessarily
> complicated
> >      >         considering the
> >      >          >      > QemuEvent uses the same mechanism QemuCond/
> >     QemuMutex
> >      >         internally
> >      >          >     on macOS
> >      >          >      > (the only platform relevant here), except we
> >     can use it as
> >      >          >     intended with
> >      >          >      > QemuCond/QemuMutex rather than having to work
> >     against the
> >      >          >     abstraction.
> >      >          >
> >      >          >     I don't think it's going to be used concurrently.
> It
> >      >         would be difficult
> >      >          >     to reason even for the framework if it performs
> memory
> >      >          >     unmapping/mapping/reading operations concurrently=
.
> >      >          >
> >      >          >
> >      >          > I've just performed a very quick test by wrapping the
> job
> >      >         submission/
> >      >          > wait in the 2 mapMemory callbacks and the 1 readMemor=
y
> >      >         callback with
> >      >          > atomic counters and logging whenever a counter went
> >     above 1.
> >      >          >
> >      >          >   * Overall, concurrent callbacks across all types we=
re
> >      >         common (many per
> >      >          > second when the VM is busy). It's not exactly a
> >     "thundering
> >      >         herd" (I
> >      >          > never saw >2) but it's probably not a bad idea to use
> >     a separate
> >      >          > condition variable for each job type. (task map,
> >     surface map,
> >      >         memory read)
> >      >          >   * While I did not observe any concurrent memory
> mapping
> >      >         operations
> >      >          > *within* a type of memory map (2 task mappings or 2
> >     surface
> >      >         mappings) I
> >      >          > did see very occasional concurrent memory *read*
> >     callbacks.
> >      >         These would,
> >      >          > as far as I can tell, not be safe with QemuEvents,
> >     unless we
> >      >         placed the
> >      >          > event inside the job struct and init/destroyed it on
> every
> >      >         callback
> >      >          > (which seems like excessive overhead).
> >      >
> >      >         I think we can tolerate that overhead. init/destroy
> >     essentially
> >      >         sets the
> >      >         fields in the data structure and I estimate its total
> size is
> >      >         about 100
> >      >         bytes. It is probably better than waking an irrelevant
> thread
> >      >         up. I also
> >      >         hope that keeps the code simple; it's not worthwhile
> >     adding code to
> >      >         optimize this.
> >      >
> >      >
> >      >     At least pthread_cond_{init,destroy} and
> >      >     pthread_mutex_{init,destroy} don't make any syscalls, so yea=
h
> >     it's
> >      >     probably an acceptable overhead.
> >      >
> >      >
> >      > I've just experimented with QemuEvents created on-demand and ran
> >     into
> >      > some weird deadlocks, which then made me sit down and think abou=
t
> it
> >      > some more. I've come to the conclusion that creating (and
> crucially,
> >      > destroying) QemuEvents on demand in this way is not safe.
> >      >
> >      > Specifically, you must not call qemu_event_destroy() - which
> >      > transitively destroys the mutex and condition variable - unless
> >     you can
> >      > guarantee that the qemu_event_set() call on that event object ha=
s
> >     completed.
> >      >
> >      > In qemu_event_set, the event object's value is atomically set to
> >     EV_SET.
> >      > If the previous value was EV_BUSY, qemu_futex_wake() is called.
> >     All of
> >      > this is outside any mutex, however, so apart from memory coheren=
ce
> >      > (there are barriers) this can race with the waiting thread.
> >      > qemu_event_wait() reads the event's value. If EV_FREE, it's
> >     atomically
> >      > set to EV_BUSY. Then the mutex is locked, the value is checked
> >     again,
> >      > and if it's still EV_BUSY, it waits for the condition variable,
> >      > otherwise the mutex is immediately unlocked again. If the trigge=
r
> >      > thread's qemu_event_set() flip to EV_SET occurs between the
> waiting
> >      > thread's two atomic reads of the value, the waiting thread will
> >     never
> >      > wait for the condition variable, but the trigger thread WILL try
> to
> >      > acquire the mutex and signal the condition variable in
> >      > qemu_futex_wake(), by which  time the waiting thread may have
> >     advanced
> >      > outside of qemu_event_wait().
> >
> >     Sorry if I'm making a mistake again, but the waiting thread won't
> >     set to
> >     EV_BUSY unless the value is EV_FREE on the second read so the trigg=
er
> >     thread will not call qemu_futex_wake() if it manages to set to EV_S=
ET
> >     before the second read, will it?
> >
> >
> > This sequence of events will cause the problem:
> >
> > WAITER (in qemu_event_wait):
> > value =3D qatomic_load_acquire(&ev->value);
> > -> EV_FREE
> >
> > TRIGGER (in qemu_event_set):
> > qatomic_read(&ev->value) !=3D EV_SET
> > -> EV_FREE (condition is false)
> >
> > WAITER:
> > qatomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) =3D=3D EV_SET
> > -> cmpxchg returns EV_FREE, condition false.
> > ev->value =3D  EV_BUSY.
> > > TRIGGER:
> >          int old =3D qatomic_xchg(&ev->value, EV_SET);
> >          smp_mb__after_rmw();
> >          if (old =3D=3D EV_BUSY) {
> > -> old =3D EV_BUSY, condition true.
> > ev->value =3D EV_SET
> >
> > WAITER (in qemu_futex_wait(ev, EV_BUSY)):
> >      pthread_mutex_lock(&ev->lock);
> >      if (ev->value =3D=3D val) {
> > -> false, because value is EV_SET
> >
> > WAITER:
> >      pthread_mutex_unlock(&ev->lock);
> >      =E2=80=A6
> >      qemu_event_destroy(&job->done_event);
> >
> > TRIGGER (in qemu_futex_wake(ev, INT_MAX)):
> >      pthread_mutex_lock(&ev->lock);
> > -> hangs, because mutex has been destroyed
>
> Thanks for clarification. This is very insightful.
>
>
> >
> >      >
> >      > This is all fine usually, BUT if you destroy the QemuEvent
> >     immediately
> >      > after the qemu_event_wait() call, qemu_futex_wake() may try to
> >     lock a
> >      > mutex that has been destroyed, or signal a condition variable
> >     which has
> >      > been destroyed. I don't see a reasonable way of making this safe
> >     other
> >      > than using long-lived mutexes and condition variables. And
> >     anyway, we
> >      > have much, MUCH bigger contention/performance issues coming from
> >     almost
> >      > everything being covered by the BQL. (If waking these callbacks
> >     can even
> >      > be considered an issue: I haven't seen it show up in profiling,
> >     whereas
> >      > BQL contention very much does.)
> >      >
> >      > I'll submit v5 of this patch set with separate condition
> >     variables for
> >      > each job type. This should make the occurrence of waking the wro=
ng
> >      > thread quite rare, while reasoning about correctness is pretty
> >      > straightforward. I think that's good enough.
>
> What about using QemuSemaphore then? It does not seem to have the
> problem same with QemuEvent.
>

Nowhere else in the code base uses short-lived semaphores, and while I
can't immediately see a risk (the mutex is held during both post and wait)
there might be some non-obvious problem with the approach. Internally, the
semaphores use condition variables. The solution using condition variables
directly already works, is safe, relatively easy to reason about, and does
not cause any performance issues. There is a tiny inefficiency about waking
up a thread unnecessarily in the rare case when two callbacks of the same
kind occur concurrently. In practice, it's irrelevant. Thanks to the
awkward mismatch of the PVGraphics.framework's libdispatch based approach
and Qemu's BQL/AIO/BH approach, we are already sending messages to other
threads very frequently. This isn't ideal, but not fixable without
drastically reducing the need to acquire the BQL across Qemu.

I do not think it is worth spending even more time trying to fix this part
of the code which isn't broken in the first place.

--000000000000ad82a306258fd765
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, 28 Oct 2024 at 17:06, Akihiko=
 Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On 2024/10/28 23:13, Phil Dennis-Jordan wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Mon, 28 Oct 2024 at 15:02, Akihiko Odaki &lt;<a href=3D"mailto:akih=
iko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blan=
k">akihiko.odaki@daynix.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2024/10/28 22:31, Phil Dennis-Jordan wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Mon, 28 Oct 2024 at 10:00, Phil Dennis-Jor=
dan<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:phil@philjordan.eu" target=3D=
"_blank">phil@philjordan.eu</a> &lt;mailto:<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;mailto:<a href=3D"mailto:phil@philjordan.=
eu" target=3D"_blank">phil@philjordan.eu</a> &lt;mailto:<a href=3D"mailto:p=
hil@philjordan.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;&gt;&gt; wro=
te:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0 &gt; Hmm. I think if we were to use that, we would<br>
&gt;=C2=A0 =C2=A0 =C2=A0need to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0create a new=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0 &gt; QemuEvent for every job and destroy it afterward,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0which seems<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0expensive.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0 &gt; We can&#39;t rule out multiple concurrent jobs being<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0submitted, a=
nd the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0 &gt; QemuEvent system only supports a single producer as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0far as I can=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0tell.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0 &gt; You can probably sort of hack around it with<br>
&gt;=C2=A0 =C2=A0 =C2=A0just one<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QemuEvent by=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0 &gt; putting the qemu_event_wait into a loop and turning<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the job.done=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0flag<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0 &gt; into an atomic (because it would now need to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0checked outs=
ide the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0 &gt; lock) but this all seems unnecessarily complicated<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0considering =
the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0 &gt; QemuEvent uses the same mechanism QemuCond/<br>
&gt;=C2=A0 =C2=A0 =C2=A0QemuMutex<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0internally<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0on macOS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0 &gt; (the only platform relevant here), except we<br>
&gt;=C2=A0 =C2=A0 =C2=A0can use it as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0intended with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0 &gt; QemuCond/QemuMutex rather than having to work<br>
&gt;=C2=A0 =C2=A0 =C2=A0against the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0abstraction.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0I don&#39;t think it&#39;s going to be used concurrently. It<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0would be dif=
ficult<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0to reason even for the framework if it performs memory<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0unmapping/mapping/reading operations concurrently.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; I&#39;=
ve just performed a very quick test by wrapping the job<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0submission/<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; wait i=
n the 2 mapMemory callbacks and the 1 readMemory<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0callback wit=
h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; atomic=
 counters and logging whenever a counter went<br>
&gt;=C2=A0 =C2=A0 =C2=A0above 1.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0* Overall, concurrent callbacks across all types were<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0common (many=
 per<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; second=
 when the VM is busy). It&#39;s not exactly a<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;thundering<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0herd&quot; (=
I<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; never =
saw &gt;2) but it&#39;s probably not a bad idea to use<br>
&gt;=C2=A0 =C2=A0 =C2=A0a separate<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; condit=
ion variable for each job type. (task map,<br>
&gt;=C2=A0 =C2=A0 =C2=A0surface map,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory read)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0* While I did not observe any concurrent memory mapping<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0operations<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; *withi=
n* a type of memory map (2 task mappings or 2<br>
&gt;=C2=A0 =C2=A0 =C2=A0surface<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mappings) I<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; did se=
e very occasional concurrent memory *read*<br>
&gt;=C2=A0 =C2=A0 =C2=A0callbacks.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0These would,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; as far=
 as I can tell, not be safe with QemuEvents,<br>
&gt;=C2=A0 =C2=A0 =C2=A0unless we<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0placed the<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; event =
inside the job struct and init/destroyed it on every<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0callback<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; (which=
 seems like excessive overhead).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I think we c=
an tolerate that overhead. init/destroy<br>
&gt;=C2=A0 =C2=A0 =C2=A0essentially<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sets the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fields in th=
e data structure and I estimate its total size is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0about 100<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bytes. It is=
 probably better than waking an irrelevant thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0up. I also<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hope that ke=
eps the code simple; it&#39;s not worthwhile<br>
&gt;=C2=A0 =C2=A0 =C2=A0adding code to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0optimize thi=
s.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0At least pthread_cond_{ini=
t,destroy} and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0pthread_mutex_{init,destro=
y} don&#39;t make any syscalls, so yeah<br>
&gt;=C2=A0 =C2=A0 =C2=A0it&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0probably an acceptable ove=
rhead.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I&#39;ve just experimented with QemuEvents cr=
eated on-demand and ran<br>
&gt;=C2=A0 =C2=A0 =C2=A0into<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; some weird deadlocks, which then made me sit =
down and think about it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; some more. I&#39;ve come to the conclusion th=
at creating (and crucially,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; destroying) QemuEvents on demand in this way =
is not safe.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Specifically, you must not call qemu_event_de=
stroy() - which<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; transitively destroys the mutex and condition=
 variable - unless<br>
&gt;=C2=A0 =C2=A0 =C2=A0you can<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; guarantee that the qemu_event_set() call on t=
hat event object has<br>
&gt;=C2=A0 =C2=A0 =C2=A0completed.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; In qemu_event_set, the event object&#39;s val=
ue is atomically set to<br>
&gt;=C2=A0 =C2=A0 =C2=A0EV_SET.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; If the previous value was EV_BUSY, qemu_futex=
_wake() is called.<br>
&gt;=C2=A0 =C2=A0 =C2=A0All of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; this is outside any mutex, however, so apart =
from memory coherence<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (there are barriers) this can race with the w=
aiting thread.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; qemu_event_wait() reads the event&#39;s value=
. If EV_FREE, it&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0atomically<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; set to EV_BUSY. Then the mutex is locked, the=
 value is checked<br>
&gt;=C2=A0 =C2=A0 =C2=A0again,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; and if it&#39;s still EV_BUSY, it waits for t=
he condition variable,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; otherwise the mutex is immediately unlocked a=
gain. If the trigger<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread&#39;s qemu_event_set() flip to EV_SET =
occurs between the waiting<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread&#39;s two atomic reads of the value, t=
he waiting thread will<br>
&gt;=C2=A0 =C2=A0 =C2=A0never<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; wait for the condition variable, but the trig=
ger thread WILL try to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; acquire the mutex and signal the condition va=
riable in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; qemu_futex_wake(), by which=C2=A0 time the wa=
iting thread may have<br>
&gt;=C2=A0 =C2=A0 =C2=A0advanced<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; outside of qemu_event_wait().<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Sorry if I&#39;m making a mistake again, but the wa=
iting thread won&#39;t<br>
&gt;=C2=A0 =C2=A0 =C2=A0set to<br>
&gt;=C2=A0 =C2=A0 =C2=A0EV_BUSY unless the value is EV_FREE on the second r=
ead so the trigger<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread will not call qemu_futex_wake() if it manage=
s to set to EV_SET<br>
&gt;=C2=A0 =C2=A0 =C2=A0before the second read, will it?<br>
&gt; <br>
&gt; <br>
&gt; This sequence of events will cause the problem:<br>
&gt; <br>
&gt; WAITER (in qemu_event_wait):<br>
&gt; value =3D qatomic_load_acquire(&amp;ev-&gt;value);<br>
&gt; -&gt; EV_FREE<br>
&gt; <br>
&gt; TRIGGER (in qemu_event_set):<br>
&gt; qatomic_read(&amp;ev-&gt;value) !=3D EV_SET<br>
&gt; -&gt; EV_FREE (condition is false)<br>
&gt; <br>
&gt; WAITER:<br>
&gt; qatomic_cmpxchg(&amp;ev-&gt;value, EV_FREE, EV_BUSY) =3D=3D EV_SET<br>
&gt; -&gt; cmpxchg returns EV_FREE, condition false.<br>
&gt; ev-&gt;value =3D=C2=A0 EV_BUSY.<br>
&gt; &gt; TRIGGER:<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int old =3D qatomic_x=
chg(&amp;ev-&gt;value, EV_SET);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smp_mb__after_rmw();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (old =3D=3D EV_BUSY) {<br>
&gt; -&gt; old =3D EV_BUSY, condition true.<br>
&gt; ev-&gt;value =3D EV_SET<br>
&gt; <br>
&gt; WAITER (in qemu_futex_wait(ev, EV_BUSY)):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 pthread_mutex_lock(&amp;ev-&gt;lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (ev-&gt;value =3D=3D val) {<br>
&gt; -&gt; false, because value is EV_SET<br>
&gt; <br>
&gt; WAITER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 pthread_mutex_unlock(&amp;ev-&gt;lock);<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 =E2=80=A6<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 qemu_event_destroy(&amp;job-&gt;done_event);<=
br>
&gt; <br>
&gt; TRIGGER (in qemu_futex_wake(ev, INT_MAX)):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 pthread_mutex_lock(&amp;ev-&gt;lock);<br>
&gt; -&gt; hangs, because mutex has been destroyed<br>
<br>
Thanks for clarification. This is very insightful.<br>
<br>
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; This is all fine usually, BUT if you destroy =
the QemuEvent<br>
&gt;=C2=A0 =C2=A0 =C2=A0immediately<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; after the qemu_event_wait() call, qemu_futex_=
wake() may try to<br>
&gt;=C2=A0 =C2=A0 =C2=A0lock a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; mutex that has been destroyed, or signal a co=
ndition variable<br>
&gt;=C2=A0 =C2=A0 =C2=A0which has<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; been destroyed. I don&#39;t see a reasonable =
way of making this safe<br>
&gt;=C2=A0 =C2=A0 =C2=A0other<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; than using long-lived mutexes and condition v=
ariables. And<br>
&gt;=C2=A0 =C2=A0 =C2=A0anyway, we<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; have much, MUCH bigger contention/performance=
 issues coming from<br>
&gt;=C2=A0 =C2=A0 =C2=A0almost<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; everything being covered by the BQL. (If waki=
ng these callbacks<br>
&gt;=C2=A0 =C2=A0 =C2=A0can even<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; be considered an issue: I haven&#39;t seen it=
 show up in profiling,<br>
&gt;=C2=A0 =C2=A0 =C2=A0whereas<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; BQL contention very much does.)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I&#39;ll submit v5 of this patch set with sep=
arate condition<br>
&gt;=C2=A0 =C2=A0 =C2=A0variables for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; each job type. This should make the occurrenc=
e of waking the wrong<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread quite rare, while reasoning about corr=
ectness is pretty<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; straightforward. I think that&#39;s good enou=
gh.<br>
<br>
What about using QemuSemaphore then? It does not seem to have the <br>
problem same with QemuEvent.<br></blockquote><div><br></div><div>Nowhere el=
se in the code base uses short-lived semaphores, and while I can&#39;t imme=
diately see a risk (the mutex is held during both post and wait) there migh=
t be some non-obvious problem with the approach. Internally, the semaphores=
 use condition variables. The solution using condition variables directly a=
lready works, is safe, relatively easy to reason about, and does not cause =
any performance issues. There is a tiny inefficiency about waking up a thre=
ad unnecessarily in the rare case when two callbacks of the same kind occur=
 concurrently. In practice, it&#39;s irrelevant. Thanks to the awkward mism=
atch of the PVGraphics.framework&#39;s libdispatch based approach and Qemu&=
#39;s BQL/AIO/BH approach, we are already sending messages to other threads=
 very frequently. This isn&#39;t ideal, but not fixable without drastically=
 reducing the need to acquire the BQL across Qemu.</div><div><br></div><div=
>I do not think it is worth spending even more time trying to fix this part=
 of the code which isn&#39;t broken in the first place.<br></div></div></di=
v>

--000000000000ad82a306258fd765--

