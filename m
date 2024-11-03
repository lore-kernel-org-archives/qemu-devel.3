Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8811CD11101
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 15:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7cDl-0001n0-Ls; Sun, 03 Nov 2024 10:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t7cDP-0001Sm-7W
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 10:08:34 -0500
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t7cDF-0008AG-AW
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 10:08:29 -0500
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-851d6c397bbso886148241.2
 for <qemu-devel@nongnu.org>; Sun, 03 Nov 2024 07:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730646500; x=1731251300;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q3oaMLzSGPVPaz5pCxMA1G7tGThEIRqS7dSxYYCXgcA=;
 b=14AjnsVTjl+4EjLYdcUxLXsRib/TwOY+bqIjAIp9HpYZ984vzYXMTPVHFVOrNCc8Fn
 xxVE8NqpQ8zN8+ugKRnbnCVJrUCJ3M4USp3JznQ6rQROzE5v7zZqDT1gY47LFubVRlKo
 EKZCru/zwz95PUwXsW1e2F2cUvAaXOu5CuQyQEMJ/AtUvetlR8LYNxfgS5o8aaAbjG4d
 rw04pqB0fp/yusfWC+E0HnS3RI7d7bR5xvgR5M5cXeweT2eMhMZq/nc06FmW3Pr+ARDl
 YWxEabNXbcRJhmkZm6N/WdMOB9kNSy2+rigS1pae9UbUheXfrusWgusL6PUXRpS50MAX
 sLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730646500; x=1731251300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q3oaMLzSGPVPaz5pCxMA1G7tGThEIRqS7dSxYYCXgcA=;
 b=PV82c6y0KtogAZw3OVFEIhhKULquZzZkxAq8TMeLSzOx89wy1EI21YF4/p6u/CJE3e
 Fbs2hYFgI736X6XUQ/tgnZJp9BWStQO5tXPrT9YpKDASAKwJp9OxOGwMPhrwSeEBvdQ5
 GzfMgY5NZ+NTzINA+kExVh/y5+rehYGUaKZP/fve4IZA4Im+zh9nOkc+kSVdY5F00mMB
 nLcZkV29KnchjhrgTD/i8uSVQpCJ0ykVqFMVR1+A3wV6y7wf5j5vqGGNhCnHoIaScx1D
 3boqZpi8IDyu437Wvhi51Yt0bLysBo5CcN/p1Hyjqvs8+qDzrLVK4NpjjNjx+q2jKUp4
 EvCg==
X-Gm-Message-State: AOJu0YwE+qrk/YUhpiepM7r5fhSrJKPdx3sVZChykiwUNYySgw2AOpex
 GrM9ZXKmlMu2t4EvXtp3/0xecCwQTcF0kE+hTykUNxJZwipvr26uQ5Jy0Dgw4r3RydLfpNECgvc
 rfCWXliVYkgokmKKa6flwTp2TjM7nHyzWB7V7
X-Google-Smtp-Source: AGHT+IGLYqaXG07HgSPBpvcQvP/rbEFL/IPRLnBvhlIsdi1a9a2K9mZFVWAOb8TsiZkN5ppWbAptgo2Lyu/wfvitEoQ=
X-Received: by 2002:a05:6102:3750:b0:4a4:87f8:f41e with SMTP id
 ada2fe7eead31-4a8cfb4cee3mr26937015137.9.1730646499659; Sun, 03 Nov 2024
 07:08:19 -0800 (PST)
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
 <CAAibmn1Th6w6JJcxgD7HA62qo-Lk0yV-Cg4XK9OYEtDvvQbhrg@mail.gmail.com>
 <a8b4472c-8741-4f80-87e5-b406c56d1acd@daynix.com>
 <CAAibmn1r=xymvZg9KaOtauo5K=Juxh7GdcrSrVvd=36ymj4qFA@mail.gmail.com>
 <229fe384-f0e6-4aa9-8f36-e44fc0391b75@daynix.com>
In-Reply-To: <229fe384-f0e6-4aa9-8f36-e44fc0391b75@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Sun, 3 Nov 2024 16:08:08 +0100
Message-ID: <CAAibmn2boGAF4s-2wuQnkeynB9kHBChjg5ZQgodr_LZUH=-+YQ@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000d82a000626038911"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::931;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x931.google.com
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

--000000000000d82a000626038911
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 31 Oct 2024 at 07:52, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> On 2024/10/30 6:16, Phil Dennis-Jordan wrote:
> >
> >
> > On Tue, 29 Oct 2024 at 08:42, Akihiko Odaki <akihiko.odaki@daynix.com
> > <mailto:akihiko.odaki@daynix.com>> wrote:
> >
> >     On 2024/10/29 6:06, Phil Dennis-Jordan wrote:
> >      >
> >      >
> >      > On Mon, 28 Oct 2024 at 17:06, Akihiko Odaki
> >     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
> >      > <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>> wrote:
> >      >
> >      >     On 2024/10/28 23:13, Phil Dennis-Jordan wrote:
> >      >      >
> >      >      >
> >      >      > On Mon, 28 Oct 2024 at 15:02, Akihiko Odaki
> >      >     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
> >     <mailto:akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>>
> >      >      > <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>
> >      >     <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>>> wrote:
> >      >      >
> >      >      >     On 2024/10/28 22:31, Phil Dennis-Jordan wrote:
> >      >      >      >
> >      >      >      >
> >      >      >      > On Mon, 28 Oct 2024 at 10:00, Phil Dennis-Jordan
> >      >      >     <phil@philjordan.eu <mailto:phil@philjordan.eu>
> >     <mailto:phil@philjordan.eu <mailto:phil@philjordan.eu>>
> >      >     <mailto:phil@philjordan.eu <mailto:phil@philjordan.eu>
> >     <mailto:phil@philjordan.eu <mailto:phil@philjordan.eu>>>
> >      >      >      > <mailto:phil@philjordan.eu
> >     <mailto:phil@philjordan.eu> <mailto:phil@philjordan.eu
> >     <mailto:phil@philjordan.eu>>
> >      >     <mailto:phil@philjordan.eu <mailto:phil@philjordan.eu>
> >     <mailto:phil@philjordan.eu <mailto:phil@philjordan.eu>>>>> wrote:
> >      >      >      >
> >      >      >      >
> >      >      >      >          >      >
> >      >      >      >          >      > Hmm. I think if we were to use
> >     that, we
> >      >     would
> >      >      >     need to
> >      >      >      >         create a new
> >      >      >      >          >      > QemuEvent for every job and
> >     destroy it
> >      >     afterward,
> >      >      >      >         which seems
> >      >      >      >          >     expensive.
> >      >      >      >          >      > We can't rule out multiple
> concurrent
> >      >     jobs being
> >      >      >      >         submitted, and the
> >      >      >      >          >      > QemuEvent system only supports a
> >     single
> >      >     producer as
> >      >      >      >         far as I can
> >      >      >      >          >     tell.
> >      >      >      >          >      >
> >      >      >      >          >      > You can probably sort of hack
> >     around it with
> >      >      >     just one
> >      >      >      >         QemuEvent by
> >      >      >      >          >      > putting the qemu_event_wait into
> >     a loop
> >      >     and turning
> >      >      >      >         the job.done
> >      >      >      >          >     flag
> >      >      >      >          >      > into an atomic (because it would
> now
> >      >     need to be
> >      >      >      >         checked outside the
> >      >      >      >          >      > lock) but this all seems
> >     unnecessarily
> >      >     complicated
> >      >      >      >         considering the
> >      >      >      >          >      > QemuEvent uses the same mechanis=
m
> >     QemuCond/
> >      >      >     QemuMutex
> >      >      >      >         internally
> >      >      >      >          >     on macOS
> >      >      >      >          >      > (the only platform relevant
> >     here), except we
> >      >      >     can use it as
> >      >      >      >          >     intended with
> >      >      >      >          >      > QemuCond/QemuMutex rather than
> >     having to
> >      >     work
> >      >      >     against the
> >      >      >      >          >     abstraction.
> >      >      >      >          >
> >      >      >      >          >     I don't think it's going to be used
> >      >     concurrently. It
> >      >      >      >         would be difficult
> >      >      >      >          >     to reason even for the framework if
> it
> >      >     performs memory
> >      >      >      >          >     unmapping/mapping/reading operation=
s
> >      >     concurrently.
> >      >      >      >          >
> >      >      >      >          >
> >      >      >      >          > I've just performed a very quick test b=
y
> >      >     wrapping the job
> >      >      >      >         submission/
> >      >      >      >          > wait in the 2 mapMemory callbacks and
> the 1
> >      >     readMemory
> >      >      >      >         callback with
> >      >      >      >          > atomic counters and logging whenever a
> >     counter went
> >      >      >     above 1.
> >      >      >      >          >
> >      >      >      >          >   * Overall, concurrent callbacks acros=
s
> all
> >      >     types were
> >      >      >      >         common (many per
> >      >      >      >          > second when the VM is busy). It's not
> >     exactly a
> >      >      >     "thundering
> >      >      >      >         herd" (I
> >      >      >      >          > never saw >2) but it's probably not a
> >     bad idea
> >      >     to use
> >      >      >     a separate
> >      >      >      >          > condition variable for each job type.
> >     (task map,
> >      >      >     surface map,
> >      >      >      >         memory read)
> >      >      >      >          >   * While I did not observe any
> concurrent
> >      >     memory mapping
> >      >      >      >         operations
> >      >      >      >          > *within* a type of memory map (2 task
> >     mappings or 2
> >      >      >     surface
> >      >      >      >         mappings) I
> >      >      >      >          > did see very occasional concurrent
> >     memory *read*
> >      >      >     callbacks.
> >      >      >      >         These would,
> >      >      >      >          > as far as I can tell, not be safe with
> >     QemuEvents,
> >      >      >     unless we
> >      >      >      >         placed the
> >      >      >      >          > event inside the job struct and init/
> >     destroyed
> >      >     it on every
> >      >      >      >         callback
> >      >      >      >          > (which seems like excessive overhead).
> >      >      >      >
> >      >      >      >         I think we can tolerate that overhead.
> >     init/destroy
> >      >      >     essentially
> >      >      >      >         sets the
> >      >      >      >         fields in the data structure and I estimat=
e
> its
> >      >     total size is
> >      >      >      >         about 100
> >      >      >      >         bytes. It is probably better than waking a=
n
> >      >     irrelevant thread
> >      >      >      >         up. I also
> >      >      >      >         hope that keeps the code simple; it's not
> >     worthwhile
> >      >      >     adding code to
> >      >      >      >         optimize this.
> >      >      >      >
> >      >      >      >
> >      >      >      >     At least pthread_cond_{init,destroy} and
> >      >      >      >     pthread_mutex_{init,destroy} don't make any
> >     syscalls,
> >      >     so yeah
> >      >      >     it's
> >      >      >      >     probably an acceptable overhead.
> >      >      >      >
> >      >      >      >
> >      >      >      > I've just experimented with QemuEvents created on-
> >     demand
> >      >     and ran
> >      >      >     into
> >      >      >      > some weird deadlocks, which then made me sit down
> and
> >      >     think about it
> >      >      >      > some more. I've come to the conclusion that
> >     creating (and
> >      >     crucially,
> >      >      >      > destroying) QemuEvents on demand in this way is no=
t
> >     safe.
> >      >      >      >
> >      >      >      > Specifically, you must not call
> >     qemu_event_destroy() - which
> >      >      >      > transitively destroys the mutex and condition
> >     variable -
> >      >     unless
> >      >      >     you can
> >      >      >      > guarantee that the qemu_event_set() call on that
> event
> >      >     object has
> >      >      >     completed.
> >      >      >      >
> >      >      >      > In qemu_event_set, the event object's value is
> >     atomically
> >      >     set to
> >      >      >     EV_SET.
> >      >      >      > If the previous value was EV_BUSY,
> qemu_futex_wake() is
> >      >     called.
> >      >      >     All of
> >      >      >      > this is outside any mutex, however, so apart from
> >     memory
> >      >     coherence
> >      >      >      > (there are barriers) this can race with the waitin=
g
> >     thread.
> >      >      >      > qemu_event_wait() reads the event's value. If
> >     EV_FREE, it's
> >      >      >     atomically
> >      >      >      > set to EV_BUSY. Then the mutex is locked, the valu=
e
> >     is checked
> >      >      >     again,
> >      >      >      > and if it's still EV_BUSY, it waits for the
> condition
> >      >     variable,
> >      >      >      > otherwise the mutex is immediately unlocked again.
> >     If the
> >      >     trigger
> >      >      >      > thread's qemu_event_set() flip to EV_SET occurs
> between
> >      >     the waiting
> >      >      >      > thread's two atomic reads of the value, the waitin=
g
> >     thread
> >      >     will
> >      >      >     never
> >      >      >      > wait for the condition variable, but the trigger
> thread
> >      >     WILL try to
> >      >      >      > acquire the mutex and signal the condition variabl=
e
> in
> >      >      >      > qemu_futex_wake(), by which  time the waiting
> >     thread may have
> >      >      >     advanced
> >      >      >      > outside of qemu_event_wait().
> >      >      >
> >      >      >     Sorry if I'm making a mistake again, but the waiting
> >     thread won't
> >      >      >     set to
> >      >      >     EV_BUSY unless the value is EV_FREE on the second rea=
d
> >     so the
> >      >     trigger
> >      >      >     thread will not call qemu_futex_wake() if it manages
> >     to set
> >      >     to EV_SET
> >      >      >     before the second read, will it?
> >      >      >
> >      >      >
> >      >      > This sequence of events will cause the problem:
> >      >      >
> >      >      > WAITER (in qemu_event_wait):
> >      >      > value =3D qatomic_load_acquire(&ev->value);
> >      >      > -> EV_FREE
> >      >      >
> >      >      > TRIGGER (in qemu_event_set):
> >      >      > qatomic_read(&ev->value) !=3D EV_SET
> >      >      > -> EV_FREE (condition is false)
> >      >      >
> >      >      > WAITER:
> >      >      > qatomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) =3D=3D EV_S=
ET
> >      >      > -> cmpxchg returns EV_FREE, condition false.
> >      >      > ev->value =3D  EV_BUSY.
> >      >      > > TRIGGER:
> >      >      >          int old =3D qatomic_xchg(&ev->value, EV_SET);
> >      >      >          smp_mb__after_rmw();
> >      >      >          if (old =3D=3D EV_BUSY) {
> >      >      > -> old =3D EV_BUSY, condition true.
> >      >      > ev->value =3D EV_SET
> >      >      >
> >      >      > WAITER (in qemu_futex_wait(ev, EV_BUSY)):
> >      >      >      pthread_mutex_lock(&ev->lock);
> >      >      >      if (ev->value =3D=3D val) {
> >      >      > -> false, because value is EV_SET
> >      >      >
> >      >      > WAITER:
> >      >      >      pthread_mutex_unlock(&ev->lock);
> >      >      >      =E2=80=A6
> >      >      >      qemu_event_destroy(&job->done_event);
> >      >      >
> >      >      > TRIGGER (in qemu_futex_wake(ev, INT_MAX)):
> >      >      >      pthread_mutex_lock(&ev->lock);
> >      >      > -> hangs, because mutex has been destroyed
> >      >
> >      >     Thanks for clarification. This is very insightful.
> >      >
> >      >
> >      >      >
> >      >      >      >
> >      >      >      > This is all fine usually, BUT if you destroy the
> >     QemuEvent
> >      >      >     immediately
> >      >      >      > after the qemu_event_wait() call, qemu_futex_wake(=
)
> >     may try to
> >      >      >     lock a
> >      >      >      > mutex that has been destroyed, or signal a
> >     condition variable
> >      >      >     which has
> >      >      >      > been destroyed. I don't see a reasonable way of
> making
> >      >     this safe
> >      >      >     other
> >      >      >      > than using long-lived mutexes and condition
> >     variables. And
> >      >      >     anyway, we
> >      >      >      > have much, MUCH bigger contention/performance issu=
es
> >      >     coming from
> >      >      >     almost
> >      >      >      > everything being covered by the BQL. (If waking
> these
> >      >     callbacks
> >      >      >     can even
> >      >      >      > be considered an issue: I haven't seen it show up =
in
> >      >     profiling,
> >      >      >     whereas
> >      >      >      > BQL contention very much does.)
> >      >      >      >
> >      >      >      > I'll submit v5 of this patch set with separate
> >     condition
> >      >      >     variables for
> >      >      >      > each job type. This should make the occurrence of
> >     waking
> >      >     the wrong
> >      >      >      > thread quite rare, while reasoning about
> >     correctness is pretty
> >      >      >      > straightforward. I think that's good enough.
> >      >
> >      >     What about using QemuSemaphore then? It does not seem to hav=
e
> the
> >      >     problem same with QemuEvent.
> >      >
> >      >
> >      > Nowhere else in the code base uses short-lived semaphores, and
> >     while I
> >      > can't immediately see a risk (the mutex is held during both post
> and
> >      > wait) there might be some non-obvious problem with the approach.
> >      > Internally, the semaphores use condition variables. The solution
> >     using
> >      > condition variables directly already works, is safe, relatively
> >     easy to
> >      > reason about, and does not cause any performance issues. There i=
s
> >     a tiny
> >      > inefficiency about waking up a thread unnecessarily in the rare
> case
> >      > when two callbacks of the same kind occur concurrently. In
> practice,
> >      > it's irrelevant. Thanks to the awkward mismatch of the
> >      > PVGraphics.framework's libdispatch based approach and Qemu's BQL=
/
> >     AIO/BH
> >      > approach, we are already sending messages to other threads very
> >      > frequently. This isn't ideal, but not fixable without drasticall=
y
> >      > reducing the need to acquire the BQL across Qemu.
> >
> >     I found several usage of ephemeral semaphores:
> >     h_random() in hw/ppc/spapr_rng.c
> >     colo_process_checkpoint() in migration/colo.c
> >     postcopy_thread_create() in migration/postcopy-ram.c
> >
> >     I'm sure short-lived semaphores will keep working (or break
> >     migration in
> >     strange ways).
> >
> >      >
> >      > I do not think it is worth spending even more time trying to fix
> >     this
> >      > part of the code which isn't broken in the first place.
> >
> >     I'm sorry to bring you to this mess, which I didn't really expect. =
I
> >     thought combining a shared pair of conditional variable and mutex a=
nd
> >     job-specific bools is unnecessarily complex, and having one
> >     synchronization primitive for each job will be simpler and will jus=
t
> >     work.
> >
> >
> > With multithreading, the devil is always in the detail! =F0=9F=98=85 I =
wouldn't
> > mind if we were seeing genuine issues with the Mutex/Cond code, but it'=
s
> > fine as far as I can tell. The QemuEvent version wasn't even really any
> > simpler (replacing bool done; with QemuEvent done_event; and await ->
> > init/wait/destroy gets longer while lock/broadcast/unlock -> set gets
> > shorter), and I guess a QemuSemaphore version would be about the same.
> > Relying on the way an edge case is handled - destroying immediately
> > after waiting - in the long term potentially makes the code more fragil=
e
> > too in case implementation details change. I think we've reached a
> > bikeshedding stage here, and I suggest any further improvements on this
> > part other than bug fixes should be deferred to future patches.
>
> We still have more than bikeshedding. There are two design options
> discussed:
>
> 1) Whether synchronization primitives should be localized
> 2) Whether short-lived QemuSemaphore is appropriate if 1) is true
>
> We discussed 2) in details, but haven't done much for 1) so there is
> some room for discussion.
>
> Even for 2), let me emphasize that avoiding ephemeral QemuSemaphore in
> one device implementation is not appropriate as means to deal with its
> potential problem when there is similar existing usage. QEMU needs to be
> correct as whole, and having a workaround only part of its codebase is
> not OK. We need to either follow existing patterns or prepare for even
> more discussion (and I'm for the former).
>
> Regarding 1), I think it's easier just to show code. Below is my idea of
> code change to localize synchronization primitives. This code is not
> tested or even compiled, but it should be sufficient to demonstrate the
> idea. There are a few notable observations:
>
> a) apple_gfx_await_bh_job() can be extended to absorb all repetitive
> code of BH jobs. Such a change is probably beneficial even when
> synchronization primitives are shared, but it is more beneficial when
> synchronization primitives are localized since it allows to wrap init
> and destroy.
>
> b) No need to declare multiple conditional variables and choosing one of
> them for each job type. Instead we can have one definition and let it
> instantiated whenever creating BH jobs.
>
> c) Localized synchronization primitives make reasoning simpler and makes
> the comment in apple-gfx.h unnecessary. We still need the discussion of
> QemuEvent v.s. QemuSemaphore, but it will be dealt in the common code so
> apple-gfx does not need to have its own comment.
>

After moving the memory mapping/unmapping code into RCU critical sections,
there's now actually only a single BH job on which we need to block in the
callback. This is the readMemory/DMA job. I've implemented that using an
ephemeral QemuSemaphore now, although I've skipped the extra level of
indirection, helper function and macro, as they'd only be used once.

I've done some testing on both x86-64 and arm64 with the QemuSemaphore and
unlike the QemuEvent, I haven't run into any deadlocks/hangs with it.

I've just posted v6 of the patch set with this change (and some other
changes vs v5).

Thanks,
Phil




> Regards,
> Akihiko Odaki
>
> ---
>   hw/display/apple-gfx.h      | 19 +++---------
>   hw/display/apple-gfx-mmio.m | 23 ++------------
>   hw/display/apple-gfx.m      | 60 +++++++++++++++++--------------------
>   3 files changed, 34 insertions(+), 68 deletions(-)
>
> diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
> index e9fef09e37ea..b5aeed4f3dcf 100644
> --- a/hw/display/apple-gfx.h
> +++ b/hw/display/apple-gfx.h
> @@ -40,19 +40,6 @@ typedef struct AppleGFXState {
>       dispatch_queue_t render_queue;
>       struct AppleGFXDisplayMode *display_modes;
>       uint32_t num_display_modes;
> -    /*
> -     * QemuMutex & QemuConds for awaiting completion of PVG
> memory-mapping and
> -     * reading requests after submitting them to run in the AIO context.
> -     * QemuCond (rather than QemuEvent) are used so multiple concurrent
> jobs
> -     * can be handled safely.
> -     * The state associated with each job is tracked in a AppleGFX*Job
> struct
> -     * for each kind of job; instances are allocated on the caller's
> stack.
> -     * This struct also contains the completion flag which is used in
> -     * conjunction with the condition variable.
> -     */
> -    QemuMutex job_mutex;
> -    QemuCond task_map_job_cond;
> -    QemuCond mem_read_job_cond;
>
>       /* tasks is protected by task_mutex */
>       QemuMutex task_mutex;
> @@ -82,8 +69,10 @@ void apple_gfx_common_realize(AppleGFXState *s,
> PGDeviceDescriptor *desc,
>   uintptr_t apple_gfx_host_address_for_gpa_range(uint64_t guest_physical,
>                                                  uint64_t length, bool
> read_only,
>                                                  MemoryRegion
> **mapping_in_region);
> -void apple_gfx_await_bh_job(AppleGFXState *s, QemuCond *job_cond,
> -                            bool *job_done_flag);
> +void apple_gfx_bh_job_run_full(QEMUBHFunc *cb, void *opaque, const char
> *name);
> +
> +#define apple_gfx_bh_job_run(cb, opaque) \
> +    apple_gfx_bh_job_run_full((cb), (opaque), (stringify(cb)))
>
>   extern const PropertyInfo qdev_prop_display_mode;
>
> diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
> index a801c5fa722e..889a23df89e9 100644
> --- a/hw/display/apple-gfx-mmio.m
> +++ b/hw/display/apple-gfx-mmio.m
> @@ -60,8 +60,6 @@ -(void)mmioWriteAtOffset:(size_t)offset
> value:(uint32_t)value;
>
>       AppleGFXState common;
>
> -    QemuCond iosfc_map_job_cond;
> -    QemuCond iosfc_unmap_job_cond;
>       qemu_irq irq_gfx;
>       qemu_irq irq_iosfc;
>       MemoryRegion iomem_iosfc;
> @@ -154,7 +152,6 @@ static void raise_irq(void *opaque)
>       AppleGFXMMIOState *state;
>       bool read_only;
>       bool success;
> -    bool done;
>   } AppleGFXMapSurfaceMemoryJob;
>
>   typedef struct AppleGFXMMIOMappedRegion {
> @@ -203,18 +200,13 @@ static void apple_gfx_mmio_map_surface_memory(void
> *opaque)
>           }
>       }
>
> -    qemu_mutex_lock(&s->common.job_mutex);
>       job->result_mem =3D (void *)mem;
>       job->success =3D mem !=3D 0;
> -    job->done =3D true;
> -    qemu_cond_broadcast(&s->iosfc_map_job_cond);
> -    qemu_mutex_unlock(&s->common.job_mutex);
>   }
>
>   typedef struct AppleGFXUnmapSurfaceMemoryJob {
>       void *virtual_address;
>       AppleGFXMMIOState *state;
> -    bool done;
>   } AppleGFXUnmapSurfaceMemoryJob;
>
>   static AppleGFXMMIOMappedRegion *find_mapped_region_containing(GArray
> *regions,
> @@ -257,11 +249,6 @@ static void
> apple_gfx_mmio_unmap_surface_memory(void *opaque)
>                         __func__,
>                         job->virtual_address, regions->len);
>       }
> -
> -    qemu_mutex_lock(&s->common.job_mutex);
> -    job->done =3D true;
> -    qemu_cond_broadcast(&s->iosfc_unmap_job_cond);
> -    qemu_mutex_unlock(&s->common.job_mutex);
>   }
>
>   static PGIOSurfaceHostDevice *apple_gfx_prepare_iosurface_host_device(
> @@ -278,9 +265,7 @@ static void apple_gfx_mmio_unmap_surface_memory(void
> *opaque)
>                   .read_only =3D ro, .state =3D s,
>               };
>
> -            aio_bh_schedule_oneshot(qemu_get_aio_context(),
> -                                    apple_gfx_mmio_map_surface_memory,
> &job);
> -            apple_gfx_await_bh_job(&s->common, &s->iosfc_map_job_cond,
> &job.done);
> +            apple_gfx_bh_job_run(apple_gfx_mmio_map_surface_memory, &job=
);
>
>               *va =3D job.result_mem;
>
> @@ -295,9 +280,7 @@ static void apple_gfx_mmio_unmap_surface_memory(void
> *opaque)
>               AppleGFXUnmapSurfaceMemoryJob job =3D { va, s };
>               trace_apple_gfx_iosfc_unmap_memory(va, b, c, d, e, f);
>
> -            aio_bh_schedule_oneshot(qemu_get_aio_context(),
> -
> apple_gfx_mmio_unmap_surface_memory, &job);
> -            apple_gfx_await_bh_job(&s->common,
> &s->iosfc_unmap_job_cond, &job.done);
> +            apple_gfx_bh_job_run(apple_gfx_mmio_unmap_surface_memory,
> &job);
>
>               return true;
>           };
> @@ -336,8 +319,6 @@ static void apple_gfx_mmio_realize(DeviceState *dev,
> Error **errp)
>                                 2 /* Usually no more RAM regions*/);
>
>           apple_gfx_common_realize(&s->common, desc, errp);
> -        qemu_cond_init(&s->iosfc_map_job_cond);
> -        qemu_cond_init(&s->iosfc_unmap_job_cond);
>
>           [desc release];
>           desc =3D nil;
> diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> index 2e264e5561fc..4d174e766310 100644
> --- a/hw/display/apple-gfx.m
> +++ b/hw/display/apple-gfx.m
> @@ -90,6 +90,31 @@ static dispatch_queue_t get_background_queue(void)
>       return task;
>   }
>
> +typedef struct AppleGFXJob {
> +  QEMUBHFunc cb;
> +  void *opaque;
> +  QemuSemaphore sem;
> +} AppleGFXJob;
> +
> +void apple_gfx_bh_job_cb(void *opaque)
> +{
> +  AppleGFXJob *job =3D opaque;
> +  job->cb(job->opaque);
> +  qemu_sem_post(&job->sem);
> +}
> +
> +void apple_gfx_bh_job_run_full(QEMUBHFunc *cb, void *opaque, const char
> *name)
> +{
> +    AppleGFXJob job;
> +    job->cb =3D cb;
> +    job->opaque =3D opaque;
> +    qemu_sem_init(&job->sem, 0);
> +    aio_bh_schedule_oneshot_full(qemu_get_aio_context(),
> apple_gfx_bh_job_cb,
> +                                 &job, name);
> +    qemu_sem_wait(&job->sem);
> +    qemu_sem_destroy(&job->sem);
> +}
> +
>   typedef struct AppleGFXIOJob {
>       AppleGFXState *state;
>       uint64_t offset;
> @@ -355,7 +380,6 @@ void apple_gfx_common_init(Object *obj,
> AppleGFXState *s, const char* obj_name)
>       uint32_t range_count;
>       bool read_only;
>       bool success;
> -    bool done;
>   } AppleGFXMapMemoryJob;
>
>   uintptr_t apple_gfx_host_address_for_gpa_range(uint64_t guest_physical,
> @@ -457,20 +481,7 @@ static void apple_gfx_map_memory(void *opaque)
>           g_assert(r =3D=3D KERN_SUCCESS);
>       }
>
> -    qemu_mutex_lock(&s->job_mutex);
>       job->success =3D success;
> -    job->done =3D true;
> -    qemu_cond_broadcast(&s->task_map_job_cond);
> -    qemu_mutex_unlock(&s->job_mutex);
> -}
> -
> -void apple_gfx_await_bh_job(AppleGFXState *s, QemuCond *job_cond, bool
> *job_done_flag)
> -{
> -    qemu_mutex_lock(&s->job_mutex);
> -    while (!*job_done_flag) {
> -        qemu_cond_wait(job_cond, &s->job_mutex);
> -    }
> -    qemu_mutex_unlock(&s->job_mutex);
>   }
>
>   typedef struct AppleGFXReadMemoryJob {
> @@ -478,8 +489,6 @@ void apple_gfx_await_bh_job(AppleGFXState *s,
> QemuCond *job_cond, bool *job_done
>       hwaddr physical_address;
>       uint64_t length;
>       void *dst;
> -    bool done;
> -    bool success;
>   } AppleGFXReadMemoryJob;
>
>   static void apple_gfx_do_read_memory(void *opaque)
> @@ -491,11 +500,6 @@ static void apple_gfx_do_read_memory(void *opaque)
>       r =3D dma_memory_read(&address_space_memory, job->physical_address,
>                           job->dst, job->length, MEMTXATTRS_UNSPECIFIED);
>       job->success =3D r =3D=3D MEMTX_OK;
> -
> -    qemu_mutex_lock(&s->job_mutex);
> -    job->done =3D true;
> -    qemu_cond_broadcast(&s->mem_read_job_cond);
> -    qemu_mutex_unlock(&s->job_mutex);
>   }
>
>   static bool apple_gfx_read_memory(AppleGFXState *s, hwaddr
> physical_address,
> @@ -508,9 +512,7 @@ static bool apple_gfx_read_memory(AppleGFXState *s,
> hwaddr physical_address,
>       trace_apple_gfx_read_memory(physical_address, length, dst);
>
>       /* Traversing the memory map requires RCU/BQL, so do it in a BH. */
> -    aio_bh_schedule_oneshot(qemu_get_aio_context(),
> apple_gfx_do_read_memory,
> -                            &job);
> -    apple_gfx_await_bh_job(s, &s->mem_read_job_cond, &job.done);
> +    apple_gfx_bh_job_run(s, apple_gfx_do_read_memory, &job);
>       return job.success;
>   }
>
> @@ -556,12 +558,10 @@ static void
> apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
>               .state =3D s,
>               .task =3D task, .ranges =3D ranges, .range_count =3D range_=
count,
>               .read_only =3D read_only, .virtual_offset =3D virtual_offse=
t,
> -            .done =3D false, .success =3D true,
> +            .success =3D true,
>           };
>           if (range_count > 0) {
> -            aio_bh_schedule_oneshot(qemu_get_aio_context(),
> -                                    apple_gfx_map_memory, &job);
> -            apple_gfx_await_bh_job(s, &s->task_map_job_cond, &job.done);
> +            apple_gfx_bh_job_run(s, apple_gfx_map_memory, &job);
>           }
>           return job.success;
>       };
> @@ -780,10 +780,6 @@ void apple_gfx_common_realize(AppleGFXState *s,
> PGDeviceDescriptor *desc,
>           apple_gfx_create_display_mode_array(display_modes,
> num_display_modes);
>
>       create_fb(s);
> -
> -    qemu_mutex_init(&s->job_mutex);
> -    qemu_cond_init(&s->task_map_job_cond);
> -    qemu_cond_init(&s->mem_read_job_cond);
>   }
>
>   static void apple_gfx_get_display_mode(Object *obj, Visitor *v,
> --
> 2.47.0
>

--000000000000d82a000626038911
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, 31 Oct 2024 at 07:52, Akihiko=
 Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On 2024/10/30 6:16, Phil Dennis-Jordan wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Tue, 29 Oct 2024 at 08:42, Akihiko Odaki &lt;<a href=3D"mailto:akih=
iko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blan=
k">akihiko.odaki@daynix.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2024/10/29 6:06, Phil Dennis-Jordan wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Mon, 28 Oct 2024 at 17:06, Akihiko Odaki<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:akihiko.odaki@daynix.com" tar=
get=3D"_blank">akihiko.odaki@daynix.com</a> &lt;mailto:<a href=3D"mailto:ak=
ihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@da=
ynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.c=
om" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0On 2024/10/28 23:13, Phil =
Dennis-Jordan wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Mon, 28 Oct 2024 =
at 15:02, Akihiko Odaki<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:akih=
iko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a> &lt;ma=
ilto:<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.=
odaki@daynix.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.c=
om" target=3D"_blank">akihiko.odaki@daynix.com</a> &lt;mailto:<a href=3D"ma=
ilto:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</=
a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;mailto:<a href=
=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix=
.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.c=
om" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.c=
om" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;&gt;&gt;&gt; wrote:<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0O=
n 2024/10/28 22:31, Phil Dennis-Jordan wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; On Mon, 28 Oct 2024 at 10:00, Phil Dennis-Jordan<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&=
lt;<a href=3D"mailto:phil@philjordan.eu" target=3D"_blank">phil@philjordan.=
eu</a> &lt;mailto:<a href=3D"mailto:phil@philjordan.eu" target=3D"_blank">p=
hil@philjordan.eu</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:phil@philjordan.eu" ta=
rget=3D"_blank">phil@philjordan.eu</a> &lt;mailto:<a href=3D"mailto:phil@ph=
iljordan.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:phil@philjordan.eu" target=3D"_blank">phil@philjordan.eu</a> &lt;mailto:=
<a href=3D"mailto:phil@philjordan.eu" target=3D"_blank">phil@philjordan.eu<=
/a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:phil@philjordan.eu" ta=
rget=3D"_blank">phil@philjordan.eu</a> &lt;mailto:<a href=3D"mailto:phil@ph=
iljordan.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; &lt;mailto:<a href=3D"mailto:phil@philjordan.eu" target=3D"_blank">phi=
l@philjordan.eu</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:phil@philjordan.eu" ta=
rget=3D"_blank">phil@philjordan.eu</a>&gt; &lt;mailto:<a href=3D"mailto:phi=
l@philjordan.eu" target=3D"_blank">phil@philjordan.eu</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:phil@philjordan.eu" ta=
rget=3D"_blank">phil@philjordan.eu</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:phil@philjordan.eu" target=3D"_blank">phil@philjordan.eu</a> &lt;mailto:=
<a href=3D"mailto:phil@philjordan.eu" target=3D"_blank">phil@philjordan.eu<=
/a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:phil@philjordan.eu" ta=
rget=3D"_blank">phil@philjordan.eu</a> &lt;mailto:<a href=3D"mailto:phil@ph=
iljordan.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;&gt;&gt;&gt;&gt; w=
rote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hmm. I=
 think if we were to use<br>
&gt;=C2=A0 =C2=A0 =C2=A0that, we<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0would<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0n=
eed to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0create a new<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; QemuEv=
ent for every job and<br>
&gt;=C2=A0 =C2=A0 =C2=A0destroy it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0afterward,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0which seems<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0expensive.<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; We can=
&#39;t rule out multiple concurrent<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0jobs being<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0submitted, and the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; QemuEv=
ent system only supports a<br>
&gt;=C2=A0 =C2=A0 =C2=A0single<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0producer as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0far as I can<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tell.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; You ca=
n probably sort of hack<br>
&gt;=C2=A0 =C2=A0 =C2=A0around it with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0j=
ust one<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QemuEvent by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; puttin=
g the qemu_event_wait into<br>
&gt;=C2=A0 =C2=A0 =C2=A0a loop<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0and turning<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the job.done<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0flag<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; into a=
n atomic (because it would now<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0need to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0checked outside the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; lock) =
but this all seems<br>
&gt;=C2=A0 =C2=A0 =C2=A0unnecessarily<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0complicated<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0considering the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; QemuEv=
ent uses the same mechanism<br>
&gt;=C2=A0 =C2=A0 =C2=A0QemuCond/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Q=
emuMutex<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0internally<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0on macOS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; (the o=
nly platform relevant<br>
&gt;=C2=A0 =C2=A0 =C2=A0here), except we<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0c=
an use it as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0intended wit=
h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; QemuCo=
nd/QemuMutex rather than<br>
&gt;=C2=A0 =C2=A0 =C2=A0having to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0work<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0a=
gainst the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0abstraction.=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0I don&#39;t =
think it&#39;s going to be used<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0concurrently. It<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0would be difficult<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0to reason ev=
en for the framework if it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0performs memory<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0unmapping/ma=
pping/reading operations<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0concurrently.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; I&#39;ve just performed a very =
quick test by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0wrapping the job<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0submission/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; wait in the 2 mapMemory callbac=
ks and the 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0readMemory<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0callback with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; atomic counters and logging whe=
never a<br>
&gt;=C2=A0 =C2=A0 =C2=A0counter went<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0a=
bove 1.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Overall, concurre=
nt callbacks across all<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0types were<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0common (many per<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; second when the VM is busy). It=
&#39;s not<br>
&gt;=C2=A0 =C2=A0 =C2=A0exactly a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&=
quot;thundering<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0herd&quot; (I<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; never saw &gt;2) but it&#39;s p=
robably not a<br>
&gt;=C2=A0 =C2=A0 =C2=A0bad idea<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0to use<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0a=
 separate<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; condition variable for each job=
 type.<br>
&gt;=C2=A0 =C2=A0 =C2=A0(task map,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0s=
urface map,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory read)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* While I did not o=
bserve any concurrent<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0memory mapping<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0operations<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; *within* a type of memory map (=
2 task<br>
&gt;=C2=A0 =C2=A0 =C2=A0mappings or 2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0s=
urface<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mappings) I<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; did see very occasional concurr=
ent<br>
&gt;=C2=A0 =C2=A0 =C2=A0memory *read*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0c=
allbacks.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0These would,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; as far as I can tell, not be sa=
fe with<br>
&gt;=C2=A0 =C2=A0 =C2=A0QemuEvents,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0u=
nless we<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0placed the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; event inside the job struct and=
 init/<br>
&gt;=C2=A0 =C2=A0 =C2=A0destroyed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0it on every<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0callback<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; (which seems like excessive ove=
rhead).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I think we can tolerate that overhead=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0init/destroy<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0e=
ssentially<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sets the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fields in the data structure and I es=
timate its<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0total size is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0about 100<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bytes. It is probably better than wak=
ing an<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0irrelevant thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0up. I also<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hope that keeps the code simple; it&#=
39;s not<br>
&gt;=C2=A0 =C2=A0 =C2=A0worthwhile<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0a=
dding code to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0optimize this.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0At least pthread_cond_{init,destroy} and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0pthread_mutex_{init,destroy} don&#39;t make any<br>
&gt;=C2=A0 =C2=A0 =C2=A0syscalls,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0so yeah<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0i=
t&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;=C2=A0 =C2=A0 =C2=A0probably an acceptable overhead.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; I&#39;ve just experimented with QemuEvents created on-<br>
&gt;=C2=A0 =C2=A0 =C2=A0demand<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0and ran<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0i=
nto<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; some weird deadlocks, which then made me sit down and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0think about it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; some more. I&#39;ve come to the conclusion that<br>
&gt;=C2=A0 =C2=A0 =C2=A0creating (and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0crucially,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; destroying) QemuEvents on demand in this way is not<br>
&gt;=C2=A0 =C2=A0 =C2=A0safe.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; Specifically, you must not call<br>
&gt;=C2=A0 =C2=A0 =C2=A0qemu_event_destroy() - which<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; transitively destroys the mutex and condition<br>
&gt;=C2=A0 =C2=A0 =C2=A0variable -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0unless<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0y=
ou can<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; guarantee that the qemu_event_set() call on that event<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0object has<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0c=
ompleted.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; In qemu_event_set, the event object&#39;s value is<br>
&gt;=C2=A0 =C2=A0 =C2=A0atomically<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0set to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0E=
V_SET.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; If the previous value was EV_BUSY, qemu_futex_wake() is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0called.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0A=
ll of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; this is outside any mutex, however, so apart from<br>
&gt;=C2=A0 =C2=A0 =C2=A0memory<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0coherence<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; (there are barriers) this can race with the waiting<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; qemu_event_wait() reads the event&#39;s value. If<br>
&gt;=C2=A0 =C2=A0 =C2=A0EV_FREE, it&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0a=
tomically<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; set to EV_BUSY. Then the mutex is locked, the value<br>
&gt;=C2=A0 =C2=A0 =C2=A0is checked<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0a=
gain,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; and if it&#39;s still EV_BUSY, it waits for the condition<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0variable,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; otherwise the mutex is immediately unlocked again.<br>
&gt;=C2=A0 =C2=A0 =C2=A0If the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0trigger<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; thread&#39;s qemu_event_set() flip to EV_SET occurs between<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0the waiting<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; thread&#39;s two atomic reads of the value, the waiting<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0will<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0n=
ever<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; wait for the condition variable, but the trigger thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0WILL try to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; acquire the mutex and signal the condition variable in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; qemu_futex_wake(), by which=C2=A0 time the waiting<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread may have<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0a=
dvanced<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; outside of qemu_event_wait().<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0S=
orry if I&#39;m making a mistake again, but the waiting<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread won&#39;t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0s=
et to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0E=
V_BUSY unless the value is EV_FREE on the second read<br>
&gt;=C2=A0 =C2=A0 =C2=A0so the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0trigger<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0t=
hread will not call qemu_futex_wake() if it manages<br>
&gt;=C2=A0 =C2=A0 =C2=A0to set<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0to EV_SET<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0b=
efore the second read, will it?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; This sequence of eve=
nts will cause the problem:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; WAITER (in qemu_even=
t_wait):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; value =3D qatomic_lo=
ad_acquire(&amp;ev-&gt;value);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; -&gt; EV_FREE<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; TRIGGER (in qemu_eve=
nt_set):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; qatomic_read(&amp;ev=
-&gt;value) !=3D EV_SET<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; -&gt; EV_FREE (condi=
tion is false)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; WAITER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; qatomic_cmpxchg(&amp=
;ev-&gt;value, EV_FREE, EV_BUSY) =3D=3D EV_SET<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; -&gt; cmpxchg return=
s EV_FREE, condition false.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; ev-&gt;value =3D=C2=
=A0 EV_BUSY.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; TRIGGER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int old =3D qatomic_xchg(&amp;ev-&gt;value, =
EV_SET);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 smp_mb__after_rmw();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (old =3D=3D EV_BUSY) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; -&gt; old =3D EV_BUS=
Y, condition true.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; ev-&gt;value =3D EV_=
SET<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; WAITER (in qemu_fute=
x_wait(ev, EV_BUSY)):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
pthread_mutex_lock(&amp;ev-&gt;lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
if (ev-&gt;value =3D=3D val) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; -&gt; false, because=
 value is EV_SET<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; WAITER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
pthread_mutex_unlock(&amp;ev-&gt;lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0=C2=A0=
=C2=A0 =E2=80=A6<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0=C2=A0=
=C2=A0 qemu_event_destroy(&amp;job-&gt;done_event);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; TRIGGER (in qemu_fut=
ex_wake(ev, INT_MAX)):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
pthread_mutex_lock(&amp;ev-&gt;lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; -&gt; hangs, because=
 mutex has been destroyed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Thanks for clarification. =
This is very insightful.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; This is all fine usually, BUT if you destroy the<br>
&gt;=C2=A0 =C2=A0 =C2=A0QemuEvent<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0i=
mmediately<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; after the qemu_event_wait() call, qemu_futex_wake()<br>
&gt;=C2=A0 =C2=A0 =C2=A0may try to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0l=
ock a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; mutex that has been destroyed, or signal a<br>
&gt;=C2=A0 =C2=A0 =C2=A0condition variable<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0w=
hich has<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; been destroyed. I don&#39;t see a reasonable way of making<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0this safe<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0o=
ther<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; than using long-lived mutexes and condition<br>
&gt;=C2=A0 =C2=A0 =C2=A0variables. And<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0a=
nyway, we<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; have much, MUCH bigger contention/performance issues<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0coming from<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0a=
lmost<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; everything being covered by the BQL. (If waking these<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0callbacks<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0c=
an even<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; be considered an issue: I haven&#39;t seen it show up in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0profiling,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0w=
hereas<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; BQL contention very much does.)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; I&#39;ll submit v5 of this patch set with separate<br>
&gt;=C2=A0 =C2=A0 =C2=A0condition<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0v=
ariables for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; each job type. This should make the occurrence of<br>
&gt;=C2=A0 =C2=A0 =C2=A0waking<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0the wrong<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; thread quite rare, while reasoning about<br>
&gt;=C2=A0 =C2=A0 =C2=A0correctness is pretty<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
&gt; straightforward. I think that&#39;s good enough.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0What about using QemuSemap=
hore then? It does not seem to have the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0problem same with QemuEven=
t.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Nowhere else in the code base uses short-live=
d semaphores, and<br>
&gt;=C2=A0 =C2=A0 =C2=A0while I<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; can&#39;t immediately see a risk (the mutex i=
s held during both post and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; wait) there might be some non-obvious problem=
 with the approach.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Internally, the semaphores use condition vari=
ables. The solution<br>
&gt;=C2=A0 =C2=A0 =C2=A0using<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; condition variables directly already works, i=
s safe, relatively<br>
&gt;=C2=A0 =C2=A0 =C2=A0easy to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; reason about, and does not cause any performa=
nce issues. There is<br>
&gt;=C2=A0 =C2=A0 =C2=A0a tiny<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; inefficiency about waking up a thread unneces=
sarily in the rare case<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; when two callbacks of the same kind occur con=
currently. In practice,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; it&#39;s irrelevant. Thanks to the awkward mi=
smatch of the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; PVGraphics.framework&#39;s libdispatch based =
approach and Qemu&#39;s BQL/<br>
&gt;=C2=A0 =C2=A0 =C2=A0AIO/BH<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; approach, we are already sending messages to =
other threads very<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; frequently. This isn&#39;t ideal, but not fix=
able without drastically<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; reducing the need to acquire the BQL across Q=
emu.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I found several usage of ephemeral semaphores:<br>
&gt;=C2=A0 =C2=A0 =C2=A0h_random() in hw/ppc/spapr_rng.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0colo_process_checkpoint() in migration/colo.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0postcopy_thread_create() in migration/postcopy-ram.=
c<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I&#39;m sure short-lived semaphores will keep worki=
ng (or break<br>
&gt;=C2=A0 =C2=A0 =C2=A0migration in<br>
&gt;=C2=A0 =C2=A0 =C2=A0strange ways).<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I do not think it is worth spending even more=
 time trying to fix<br>
&gt;=C2=A0 =C2=A0 =C2=A0this<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; part of the code which isn&#39;t broken in th=
e first place.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I&#39;m sorry to bring you to this mess, which I di=
dn&#39;t really expect. I<br>
&gt;=C2=A0 =C2=A0 =C2=A0thought combining a shared pair of conditional vari=
able and mutex and<br>
&gt;=C2=A0 =C2=A0 =C2=A0job-specific bools is unnecessarily complex, and ha=
ving one<br>
&gt;=C2=A0 =C2=A0 =C2=A0synchronization primitive for each job will be simp=
ler and will just<br>
&gt;=C2=A0 =C2=A0 =C2=A0work.<br>
&gt; <br>
&gt; <br>
&gt; With multithreading, the devil is always in the detail! =F0=9F=98=85 I=
 wouldn&#39;t <br>
&gt; mind if we were seeing genuine issues with the Mutex/Cond code, but it=
&#39;s <br>
&gt; fine as far as I can tell. The QemuEvent version wasn&#39;t even reall=
y any <br>
&gt; simpler (replacing bool done; with QemuEvent done_event; and await -&g=
t; <br>
&gt; init/wait/destroy gets longer while lock/broadcast/unlock -&gt; set ge=
ts <br>
&gt; shorter), and I guess a QemuSemaphore version would be about the same.=
 <br>
&gt; Relying on the way an edge case is handled - destroying immediately <b=
r>
&gt; after waiting - in the long term potentially makes the code more fragi=
le <br>
&gt; too in case implementation details change. I think we&#39;ve reached a=
 <br>
&gt; bikeshedding stage here, and I suggest any further improvements on thi=
s <br>
&gt; part other than bug fixes should be deferred to future patches.<br>
<br>
We still have more than bikeshedding. There are two design options <br>
discussed:<br>
<br>
1) Whether synchronization primitives should be localized<br>
2) Whether short-lived QemuSemaphore is appropriate if 1) is true<br>
<br>
We discussed 2) in details, but haven&#39;t done much for 1) so there is <b=
r>
some room for discussion.<br>
<br>
Even for 2), let me emphasize that avoiding ephemeral QemuSemaphore in <br>
one device implementation is not appropriate as means to deal with its <br>
potential problem when there is similar existing usage. QEMU needs to be <b=
r>
correct as whole, and having a workaround only part of its codebase is <br>
not OK. We need to either follow existing patterns or prepare for even <br>
more discussion (and I&#39;m for the former).<br>
<br>
Regarding 1), I think it&#39;s easier just to show code. Below is my idea o=
f <br>
code change to localize synchronization primitives. This code is not <br>
tested or even compiled, but it should be sufficient to demonstrate the <br=
>
idea. There are a few notable observations:<br>
<br>
a) apple_gfx_await_bh_job() can be extended to absorb all repetitive <br>
code of BH jobs. Such a change is probably beneficial even when <br>
synchronization primitives are shared, but it is more beneficial when <br>
synchronization primitives are localized since it allows to wrap init <br>
and destroy.<br>
<br>
b) No need to declare multiple conditional variables and choosing one of <b=
r>
them for each job type. Instead we can have one definition and let it <br>
instantiated whenever creating BH jobs.<br>
<br>
c) Localized synchronization primitives make reasoning simpler and makes <b=
r>
the comment in apple-gfx.h unnecessary. We still need the discussion of <br=
>
QemuEvent v.s. QemuSemaphore, but it will be dealt in the common code so <b=
r>
apple-gfx does not need to have its own comment.<br></blockquote><div><br><=
/div><div>After moving the memory mapping/unmapping code into RCU critical =
sections, there&#39;s now actually only a single BH job on which we need to=
 block in the callback. This is the readMemory/DMA job. I&#39;ve implemente=
d that using an ephemeral QemuSemaphore now, although I&#39;ve skipped the =
extra level of indirection, helper function and macro, as they&#39;d only b=
e used once.</div><div><br></div><div>I&#39;ve done some testing on both x8=
6-64 and arm64 with the QemuSemaphore and unlike the QemuEvent, I haven&#39=
;t run into any deadlocks/hangs with it.<br></div><div><br></div><div>I&#39=
;ve just posted v6 of the patch set with this change (and some other change=
s vs v5).<br></div><div><br></div><div>Thanks,</div><div>Phil</div><div><br=
></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
Regards,<br>
Akihiko Odaki<br>
<br>
---<br>
=C2=A0 hw/display/apple-gfx.h=C2=A0 =C2=A0 =C2=A0 | 19 +++---------<br>
=C2=A0 hw/display/apple-gfx-mmio.m | 23 ++------------<br>
=C2=A0 hw/display/apple-gfx.m=C2=A0 =C2=A0 =C2=A0 | 60 +++++++++++++++++---=
-----------------<br>
=C2=A0 3 files changed, 34 insertions(+), 68 deletions(-)<br>
<br>
diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h<br>
index e9fef09e37ea..b5aeed4f3dcf 100644<br>
--- a/hw/display/apple-gfx.h<br>
+++ b/hw/display/apple-gfx.h<br>
@@ -40,19 +40,6 @@ typedef struct AppleGFXState {<br>
=C2=A0 =C2=A0 =C2=A0 dispatch_queue_t render_queue;<br>
=C2=A0 =C2=A0 =C2=A0 struct AppleGFXDisplayMode *display_modes;<br>
=C2=A0 =C2=A0 =C2=A0 uint32_t num_display_modes;<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* QemuMutex &amp; QemuConds for awaiting completion of=
 PVG <br>
memory-mapping and<br>
-=C2=A0 =C2=A0 =C2=A0* reading requests after submitting them to run in the=
 AIO context.<br>
-=C2=A0 =C2=A0 =C2=A0* QemuCond (rather than QemuEvent) are used so multipl=
e concurrent <br>
jobs<br>
-=C2=A0 =C2=A0 =C2=A0* can be handled safely.<br>
-=C2=A0 =C2=A0 =C2=A0* The state associated with each job is tracked in a A=
ppleGFX*Job <br>
struct<br>
-=C2=A0 =C2=A0 =C2=A0* for each kind of job; instances are allocated on the=
 caller&#39;s stack.<br>
-=C2=A0 =C2=A0 =C2=A0* This struct also contains the completion flag which =
is used in<br>
-=C2=A0 =C2=A0 =C2=A0* conjunction with the condition variable.<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 QemuMutex job_mutex;<br>
-=C2=A0 =C2=A0 QemuCond task_map_job_cond;<br>
-=C2=A0 =C2=A0 QemuCond mem_read_job_cond;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 /* tasks is protected by task_mutex */<br>
=C2=A0 =C2=A0 =C2=A0 QemuMutex task_mutex;<br>
@@ -82,8 +69,10 @@ void apple_gfx_common_realize(AppleGFXState *s, <br>
PGDeviceDescriptor *desc,<br>
=C2=A0 uintptr_t apple_gfx_host_address_for_gpa_range(uint64_t guest_physic=
al,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t length, bool <br>
read_only,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion <br>
**mapping_in_region);<br>
-void apple_gfx_await_bh_job(AppleGFXState *s, QemuCond *job_cond,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 bool *job_done_flag);<br>
+void apple_gfx_bh_job_run_full(QEMUBHFunc *cb, void *opaque, const char <b=
r>
*name);<br>
+<br>
+#define apple_gfx_bh_job_run(cb, opaque) \<br>
+=C2=A0 =C2=A0 apple_gfx_bh_job_run_full((cb), (opaque), (stringify(cb)))<b=
r>
<br>
=C2=A0 extern const PropertyInfo qdev_prop_display_mode;<br>
<br>
diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m<br>
index a801c5fa722e..889a23df89e9 100644<br>
--- a/hw/display/apple-gfx-mmio.m<br>
+++ b/hw/display/apple-gfx-mmio.m<br>
@@ -60,8 +60,6 @@ -(void)mmioWriteAtOffset:(size_t)offset <br>
value:(uint32_t)value;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 AppleGFXState common;<br>
<br>
-=C2=A0 =C2=A0 QemuCond iosfc_map_job_cond;<br>
-=C2=A0 =C2=A0 QemuCond iosfc_unmap_job_cond;<br>
=C2=A0 =C2=A0 =C2=A0 qemu_irq irq_gfx;<br>
=C2=A0 =C2=A0 =C2=A0 qemu_irq irq_iosfc;<br>
=C2=A0 =C2=A0 =C2=A0 MemoryRegion iomem_iosfc;<br>
@@ -154,7 +152,6 @@ static void raise_irq(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 AppleGFXMMIOState *state;<br>
=C2=A0 =C2=A0 =C2=A0 bool read_only;<br>
=C2=A0 =C2=A0 =C2=A0 bool success;<br>
-=C2=A0 =C2=A0 bool done;<br>
=C2=A0 } AppleGFXMapSurfaceMemoryJob;<br>
<br>
=C2=A0 typedef struct AppleGFXMMIOMappedRegion {<br>
@@ -203,18 +200,13 @@ static void apple_gfx_mmio_map_surface_memory(void <b=
r>
*opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 qemu_mutex_lock(&amp;s-&gt;common.job_mutex);<br>
=C2=A0 =C2=A0 =C2=A0 job-&gt;result_mem =3D (void *)mem;<br>
=C2=A0 =C2=A0 =C2=A0 job-&gt;success =3D mem !=3D 0;<br>
-=C2=A0 =C2=A0 job-&gt;done =3D true;<br>
-=C2=A0 =C2=A0 qemu_cond_broadcast(&amp;s-&gt;iosfc_map_job_cond);<br>
-=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;s-&gt;common.job_mutex);<br>
=C2=A0 }<br>
<br>
=C2=A0 typedef struct AppleGFXUnmapSurfaceMemoryJob {<br>
=C2=A0 =C2=A0 =C2=A0 void *virtual_address;<br>
=C2=A0 =C2=A0 =C2=A0 AppleGFXMMIOState *state;<br>
-=C2=A0 =C2=A0 bool done;<br>
=C2=A0 } AppleGFXUnmapSurfaceMemoryJob;<br>
<br>
=C2=A0 static AppleGFXMMIOMappedRegion *find_mapped_region_containing(GArra=
y <br>
*regions,<br>
@@ -257,11 +249,6 @@ static void <br>
apple_gfx_mmio_unmap_surface_memory(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 __func__,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 job-&gt;virtual_address, regions-&gt;len);<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 qemu_mutex_lock(&amp;s-&gt;common.job_mutex);<br>
-=C2=A0 =C2=A0 job-&gt;done =3D true;<br>
-=C2=A0 =C2=A0 qemu_cond_broadcast(&amp;s-&gt;iosfc_unmap_job_cond);<br>
-=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;s-&gt;common.job_mutex);<br>
=C2=A0 }<br>
<br>
=C2=A0 static PGIOSurfaceHostDevice *apple_gfx_prepare_iosurface_host_devic=
e(<br>
@@ -278,9 +265,7 @@ static void apple_gfx_mmio_unmap_surface_memory(void <b=
r>
*opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .read_only =
=3D ro, .state =3D s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_bh_schedule_oneshot(qemu_get=
_aio_context(),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_mmio_map_sur=
face_memory, <br>
&amp;job);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_await_bh_job(&amp;s-&g=
t;common, &amp;s-&gt;iosfc_map_job_cond, <br>
&amp;job.done);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_bh_job_run(apple_gfx_m=
mio_map_surface_memory, &amp;job);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *va =3D job.result_mem;<br=
>
<br>
@@ -295,9 +280,7 @@ static void apple_gfx_mmio_unmap_surface_memory(void <b=
r>
*opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AppleGFXUnmapSurfaceMemory=
Job job =3D { va, s };<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_iosfc_unma=
p_memory(va, b, c, d, e, f);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_bh_schedule_oneshot(qemu_get=
_aio_context(),<br>
- <br>
apple_gfx_mmio_unmap_surface_memory, &amp;job);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_await_bh_job(&amp;s-&g=
t;common, <br>
&amp;s-&gt;iosfc_unmap_job_cond, &amp;job.done);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_bh_job_run(apple_gfx_m=
mio_unmap_surface_memory, <br>
&amp;job);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
@@ -336,8 +319,6 @@ static void apple_gfx_mmio_realize(DeviceState *dev, <b=
r>
Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 /* Usually no more RAM regions*/);=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_common_realize(&amp;s-&gt;comm=
on, desc, errp);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_cond_init(&amp;s-&gt;iosfc_map_job_cond);=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_cond_init(&amp;s-&gt;iosfc_unmap_job_cond=
);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [desc release];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc =3D nil;<br>
diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m<br>
index 2e264e5561fc..4d174e766310 100644<br>
--- a/hw/display/apple-gfx.m<br>
+++ b/hw/display/apple-gfx.m<br>
@@ -90,6 +90,31 @@ static dispatch_queue_t get_background_queue(void)<br>
=C2=A0 =C2=A0 =C2=A0 return task;<br>
=C2=A0 }<br>
<br>
+typedef struct AppleGFXJob {<br>
+=C2=A0 QEMUBHFunc cb;<br>
+=C2=A0 void *opaque;<br>
+=C2=A0 QemuSemaphore sem;<br>
+} AppleGFXJob;<br>
+<br>
+void apple_gfx_bh_job_cb(void *opaque)<br>
+{<br>
+=C2=A0 AppleGFXJob *job =3D opaque;<br>
+=C2=A0 job-&gt;cb(job-&gt;opaque);<br>
+=C2=A0 qemu_sem_post(&amp;job-&gt;sem);<br>
+}<br>
+<br>
+void apple_gfx_bh_job_run_full(QEMUBHFunc *cb, void *opaque, const char <b=
r>
*name)<br>
+{<br>
+=C2=A0 =C2=A0 AppleGFXJob job;<br>
+=C2=A0 =C2=A0 job-&gt;cb =3D cb;<br>
+=C2=A0 =C2=A0 job-&gt;opaque =3D opaque;<br>
+=C2=A0 =C2=A0 qemu_sem_init(&amp;job-&gt;sem, 0);<br>
+=C2=A0 =C2=A0 aio_bh_schedule_oneshot_full(qemu_get_aio_context(), <br>
apple_gfx_bh_job_cb,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;job, name);<br>
+=C2=A0 =C2=A0 qemu_sem_wait(&amp;job-&gt;sem);<br>
+=C2=A0 =C2=A0 qemu_sem_destroy(&amp;job-&gt;sem);<br>
+}<br>
+<br>
=C2=A0 typedef struct AppleGFXIOJob {<br>
=C2=A0 =C2=A0 =C2=A0 AppleGFXState *state;<br>
=C2=A0 =C2=A0 =C2=A0 uint64_t offset;<br>
@@ -355,7 +380,6 @@ void apple_gfx_common_init(Object *obj, <br>
AppleGFXState *s, const char* obj_name)<br>
=C2=A0 =C2=A0 =C2=A0 uint32_t range_count;<br>
=C2=A0 =C2=A0 =C2=A0 bool read_only;<br>
=C2=A0 =C2=A0 =C2=A0 bool success;<br>
-=C2=A0 =C2=A0 bool done;<br>
=C2=A0 } AppleGFXMapMemoryJob;<br>
<br>
=C2=A0 uintptr_t apple_gfx_host_address_for_gpa_range(uint64_t guest_physic=
al,<br>
@@ -457,20 +481,7 @@ static void apple_gfx_map_memory(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(r =3D=3D KERN_SUCCESS);<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 qemu_mutex_lock(&amp;s-&gt;job_mutex);<br>
=C2=A0 =C2=A0 =C2=A0 job-&gt;success =3D success;<br>
-=C2=A0 =C2=A0 job-&gt;done =3D true;<br>
-=C2=A0 =C2=A0 qemu_cond_broadcast(&amp;s-&gt;task_map_job_cond);<br>
-=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;s-&gt;job_mutex);<br>
-}<br>
-<br>
-void apple_gfx_await_bh_job(AppleGFXState *s, QemuCond *job_cond, bool <br=
>
*job_done_flag)<br>
-{<br>
-=C2=A0 =C2=A0 qemu_mutex_lock(&amp;s-&gt;job_mutex);<br>
-=C2=A0 =C2=A0 while (!*job_done_flag) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_cond_wait(job_cond, &amp;s-&gt;job_mutex)=
;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;s-&gt;job_mutex);<br>
=C2=A0 }<br>
<br>
=C2=A0 typedef struct AppleGFXReadMemoryJob {<br>
@@ -478,8 +489,6 @@ void apple_gfx_await_bh_job(AppleGFXState *s, <br>
QemuCond *job_cond, bool *job_done<br>
=C2=A0 =C2=A0 =C2=A0 hwaddr physical_address;<br>
=C2=A0 =C2=A0 =C2=A0 uint64_t length;<br>
=C2=A0 =C2=A0 =C2=A0 void *dst;<br>
-=C2=A0 =C2=A0 bool done;<br>
-=C2=A0 =C2=A0 bool success;<br>
=C2=A0 } AppleGFXReadMemoryJob;<br>
<br>
=C2=A0 static void apple_gfx_do_read_memory(void *opaque)<br>
@@ -491,11 +500,6 @@ static void apple_gfx_do_read_memory(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 r =3D dma_memory_read(&amp;address_space_memory, job-&=
gt;physical_address,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 job-&gt;dst, job-&gt;length, MEMTXATTRS_UNSPECIFIED);<br>
=C2=A0 =C2=A0 =C2=A0 job-&gt;success =3D r =3D=3D MEMTX_OK;<br>
-<br>
-=C2=A0 =C2=A0 qemu_mutex_lock(&amp;s-&gt;job_mutex);<br>
-=C2=A0 =C2=A0 job-&gt;done =3D true;<br>
-=C2=A0 =C2=A0 qemu_cond_broadcast(&amp;s-&gt;mem_read_job_cond);<br>
-=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;s-&gt;job_mutex);<br>
=C2=A0 }<br>
<br>
=C2=A0 static bool apple_gfx_read_memory(AppleGFXState *s, hwaddr <br>
physical_address,<br>
@@ -508,9 +512,7 @@ static bool apple_gfx_read_memory(AppleGFXState *s, <br=
>
hwaddr physical_address,<br>
=C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_read_memory(physical_address, length, =
dst);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 /* Traversing the memory map requires RCU/BQL, so do i=
t in a BH. */<br>
-=C2=A0 =C2=A0 aio_bh_schedule_oneshot(qemu_get_aio_context(), <br>
apple_gfx_do_read_memory,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;job);<br>
-=C2=A0 =C2=A0 apple_gfx_await_bh_job(s, &amp;s-&gt;mem_read_job_cond, &amp=
;job.done);<br>
+=C2=A0 =C2=A0 apple_gfx_bh_job_run(s, apple_gfx_do_read_memory, &amp;job);=
<br>
=C2=A0 =C2=A0 =C2=A0 return job.success;<br>
=C2=A0 }<br>
<br>
@@ -556,12 +558,10 @@ static void <br>
apple_gfx_register_task_mapping_handlers(AppleGFXState *s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .state =3D s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .task =3D task, .ranges =
=3D ranges, .range_count =3D range_count,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .read_only =3D read_only, =
.virtual_offset =3D virtual_offset,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .done =3D false, .success =3D tr=
ue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .success =3D true,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (range_count &gt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_bh_schedule_oneshot(qemu_get=
_aio_context(),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_map_memory, =
&amp;job);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_await_bh_job(s, &amp;s=
-&gt;task_map_job_cond, &amp;job.done);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_bh_job_run(s, apple_gf=
x_map_memory, &amp;job);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return job.success;<br>
=C2=A0 =C2=A0 =C2=A0 };<br>
@@ -780,10 +780,6 @@ void apple_gfx_common_realize(AppleGFXState *s, <br>
PGDeviceDescriptor *desc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_create_display_mode_array(disp=
lay_modes, <br>
num_display_modes);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 create_fb(s);<br>
-<br>
-=C2=A0 =C2=A0 qemu_mutex_init(&amp;s-&gt;job_mutex);<br>
-=C2=A0 =C2=A0 qemu_cond_init(&amp;s-&gt;task_map_job_cond);<br>
-=C2=A0 =C2=A0 qemu_cond_init(&amp;s-&gt;mem_read_job_cond);<br>
=C2=A0 }<br>
<br>
=C2=A0 static void apple_gfx_get_display_mode(Object *obj, Visitor *v,<br>
-- <br>
2.47.0<br>
</blockquote></div></div>

--000000000000d82a000626038911--

