Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0815BD74940
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 21:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5ta3-0002Tk-Pg; Tue, 29 Oct 2024 17:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t5tZy-0002Qt-VP
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:16:42 -0400
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t5tZv-0007e8-BP
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:16:42 -0400
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4a4789662c1so1666010137.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 14:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730236597; x=1730841397;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=527CFGEDefWRjHtLkUMgAr9bzk44ucfjXJ4rGQP3n2Q=;
 b=RZRz4d1Xkw/L3uGoAJqjH9EwNni67uWhZg4pZ+PCSZ+jX4YzAXVGyJzGzMOibMM+U1
 J64vrlM9mkOqG2osIPTpOxB+rBXYS2wDLJGUwvhXejiIJK8sgBGtWt1ZM7dzPT36hlcv
 WNrXSIevCY24Fn/K3CANsxzzYlKBxnapd4wUbgjlCCoUzYvOFm+p5TT3NleRIRBc/u/5
 sDnmamlnL33T4Qv/D/8lBU833VhOFhJny4xmmPKGM05MANKsF29YiyGHOHdAeYyBy7FV
 nGCCxyQg8xkChcwnM+bDw4MkiZI6ErZek659ngJ1raRPAg/hzRB8dkhgDdvkb2xFjk2a
 0sHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730236597; x=1730841397;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=527CFGEDefWRjHtLkUMgAr9bzk44ucfjXJ4rGQP3n2Q=;
 b=Tr98UUOMizbKtQo3ggUQ/HiCvJolkSTt5Kk8X35MGIIFJ1ru8DKOfKywimOY/a2dN2
 6LQdDDB4mcPGgXc1AvEQz45k0cFctzvzQ5JfNsCPtMenRG8DupHvHjYsltjeDbb4Tbio
 3Di/Zu0XXCWFU2HQXMQVmUJso4AS/oJBKaem1YgzlX3g9kuYkyLZTn02/xPJg1KePKKo
 EnVZDtWb5X08dWSTkkszcmAy2KuUI68w7m1aLOWi97tMWLjAafsHexGVcBqmWCPfJXmv
 rnK9qvCKQNpUX5behvHZnyLRA2LlS9JXf+W2VjJtJtE9pyjZREJb1m5xcT6JTD7VXxmR
 Pkeg==
X-Gm-Message-State: AOJu0YyTgGoH+xTXgyQ0GS+esGxK+soi2kYmhcza6zkHImIHLJp+39Lx
 7pfyHTqKjJTyV1LxvFpjQoaqy1LGlaRKkqTLqzsb6WVu0uzqy1xU0T1wkKEa/RREDC86OZAaLQM
 fCQryFRReuUOIVWuCkV/oZsHnTziucK1+d17R
X-Google-Smtp-Source: AGHT+IFa4QU99tS/ftVZf+ne4SH5n2Z+En2wSaO9gEzfJBhK6k7R28UU2UYd64mudXAXkTnjF2Re5iZyfO4puWD48w8=
X-Received: by 2002:a05:6102:38cb:b0:4a4:7ddc:6972 with SMTP id
 ada2fe7eead31-4a8cfd6d225mr13158903137.26.1730236597313; Tue, 29 Oct 2024
 14:16:37 -0700 (PDT)
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
In-Reply-To: <a8b4472c-8741-4f80-87e5-b406c56d1acd@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Tue, 29 Oct 2024 22:16:26 +0100
Message-ID: <CAAibmn1r=xymvZg9KaOtauo5K=Juxh7GdcrSrVvd=36ymj4qFA@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000c2c8a10625a4197b"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::e34;
 envelope-from=phil@philjordan.eu; helo=mail-vs1-xe34.google.com
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

--000000000000c2c8a10625a4197b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Oct 2024 at 08:42, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> On 2024/10/29 6:06, Phil Dennis-Jordan wrote:
> >
> >
> > On Mon, 28 Oct 2024 at 17:06, Akihiko Odaki <akihiko.odaki@daynix.com
> > <mailto:akihiko.odaki@daynix.com>> wrote:
> >
> >     On 2024/10/28 23:13, Phil Dennis-Jordan wrote:
> >      >
> >      >
> >      > On Mon, 28 Oct 2024 at 15:02, Akihiko Odaki
> >     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
> >      > <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>> wrote:
> >      >
> >      >     On 2024/10/28 22:31, Phil Dennis-Jordan wrote:
> >      >      >
> >      >      >
> >      >      > On Mon, 28 Oct 2024 at 10:00, Phil Dennis-Jordan
> >      >     <phil@philjordan.eu <mailto:phil@philjordan.eu>
> >     <mailto:phil@philjordan.eu <mailto:phil@philjordan.eu>>
> >      >      > <mailto:phil@philjordan.eu <mailto:phil@philjordan.eu>
> >     <mailto:phil@philjordan.eu <mailto:phil@philjordan.eu>>>> wrote:
> >      >      >
> >      >      >
> >      >      >          >      >
> >      >      >          >      > Hmm. I think if we were to use that, we
> >     would
> >      >     need to
> >      >      >         create a new
> >      >      >          >      > QemuEvent for every job and destroy it
> >     afterward,
> >      >      >         which seems
> >      >      >          >     expensive.
> >      >      >          >      > We can't rule out multiple concurrent
> >     jobs being
> >      >      >         submitted, and the
> >      >      >          >      > QemuEvent system only supports a single
> >     producer as
> >      >      >         far as I can
> >      >      >          >     tell.
> >      >      >          >      >
> >      >      >          >      > You can probably sort of hack around it
> with
> >      >     just one
> >      >      >         QemuEvent by
> >      >      >          >      > putting the qemu_event_wait into a loop
> >     and turning
> >      >      >         the job.done
> >      >      >          >     flag
> >      >      >          >      > into an atomic (because it would now
> >     need to be
> >      >      >         checked outside the
> >      >      >          >      > lock) but this all seems unnecessarily
> >     complicated
> >      >      >         considering the
> >      >      >          >      > QemuEvent uses the same mechanism
> QemuCond/
> >      >     QemuMutex
> >      >      >         internally
> >      >      >          >     on macOS
> >      >      >          >      > (the only platform relevant here),
> except we
> >      >     can use it as
> >      >      >          >     intended with
> >      >      >          >      > QemuCond/QemuMutex rather than having t=
o
> >     work
> >      >     against the
> >      >      >          >     abstraction.
> >      >      >          >
> >      >      >          >     I don't think it's going to be used
> >     concurrently. It
> >      >      >         would be difficult
> >      >      >          >     to reason even for the framework if it
> >     performs memory
> >      >      >          >     unmapping/mapping/reading operations
> >     concurrently.
> >      >      >          >
> >      >      >          >
> >      >      >          > I've just performed a very quick test by
> >     wrapping the job
> >      >      >         submission/
> >      >      >          > wait in the 2 mapMemory callbacks and the 1
> >     readMemory
> >      >      >         callback with
> >      >      >          > atomic counters and logging whenever a counter
> went
> >      >     above 1.
> >      >      >          >
> >      >      >          >   * Overall, concurrent callbacks across all
> >     types were
> >      >      >         common (many per
> >      >      >          > second when the VM is busy). It's not exactly =
a
> >      >     "thundering
> >      >      >         herd" (I
> >      >      >          > never saw >2) but it's probably not a bad idea
> >     to use
> >      >     a separate
> >      >      >          > condition variable for each job type. (task ma=
p,
> >      >     surface map,
> >      >      >         memory read)
> >      >      >          >   * While I did not observe any concurrent
> >     memory mapping
> >      >      >         operations
> >      >      >          > *within* a type of memory map (2 task mappings
> or 2
> >      >     surface
> >      >      >         mappings) I
> >      >      >          > did see very occasional concurrent memory *rea=
d*
> >      >     callbacks.
> >      >      >         These would,
> >      >      >          > as far as I can tell, not be safe with
> QemuEvents,
> >      >     unless we
> >      >      >         placed the
> >      >      >          > event inside the job struct and init/destroyed
> >     it on every
> >      >      >         callback
> >      >      >          > (which seems like excessive overhead).
> >      >      >
> >      >      >         I think we can tolerate that overhead. init/destr=
oy
> >      >     essentially
> >      >      >         sets the
> >      >      >         fields in the data structure and I estimate its
> >     total size is
> >      >      >         about 100
> >      >      >         bytes. It is probably better than waking an
> >     irrelevant thread
> >      >      >         up. I also
> >      >      >         hope that keeps the code simple; it's not
> worthwhile
> >      >     adding code to
> >      >      >         optimize this.
> >      >      >
> >      >      >
> >      >      >     At least pthread_cond_{init,destroy} and
> >      >      >     pthread_mutex_{init,destroy} don't make any syscalls,
> >     so yeah
> >      >     it's
> >      >      >     probably an acceptable overhead.
> >      >      >
> >      >      >
> >      >      > I've just experimented with QemuEvents created on-demand
> >     and ran
> >      >     into
> >      >      > some weird deadlocks, which then made me sit down and
> >     think about it
> >      >      > some more. I've come to the conclusion that creating (and
> >     crucially,
> >      >      > destroying) QemuEvents on demand in this way is not safe.
> >      >      >
> >      >      > Specifically, you must not call qemu_event_destroy() -
> which
> >      >      > transitively destroys the mutex and condition variable -
> >     unless
> >      >     you can
> >      >      > guarantee that the qemu_event_set() call on that event
> >     object has
> >      >     completed.
> >      >      >
> >      >      > In qemu_event_set, the event object's value is atomically
> >     set to
> >      >     EV_SET.
> >      >      > If the previous value was EV_BUSY, qemu_futex_wake() is
> >     called.
> >      >     All of
> >      >      > this is outside any mutex, however, so apart from memory
> >     coherence
> >      >      > (there are barriers) this can race with the waiting threa=
d.
> >      >      > qemu_event_wait() reads the event's value. If EV_FREE, it=
's
> >      >     atomically
> >      >      > set to EV_BUSY. Then the mutex is locked, the value is
> checked
> >      >     again,
> >      >      > and if it's still EV_BUSY, it waits for the condition
> >     variable,
> >      >      > otherwise the mutex is immediately unlocked again. If the
> >     trigger
> >      >      > thread's qemu_event_set() flip to EV_SET occurs between
> >     the waiting
> >      >      > thread's two atomic reads of the value, the waiting threa=
d
> >     will
> >      >     never
> >      >      > wait for the condition variable, but the trigger thread
> >     WILL try to
> >      >      > acquire the mutex and signal the condition variable in
> >      >      > qemu_futex_wake(), by which  time the waiting thread may
> have
> >      >     advanced
> >      >      > outside of qemu_event_wait().
> >      >
> >      >     Sorry if I'm making a mistake again, but the waiting thread
> won't
> >      >     set to
> >      >     EV_BUSY unless the value is EV_FREE on the second read so th=
e
> >     trigger
> >      >     thread will not call qemu_futex_wake() if it manages to set
> >     to EV_SET
> >      >     before the second read, will it?
> >      >
> >      >
> >      > This sequence of events will cause the problem:
> >      >
> >      > WAITER (in qemu_event_wait):
> >      > value =3D qatomic_load_acquire(&ev->value);
> >      > -> EV_FREE
> >      >
> >      > TRIGGER (in qemu_event_set):
> >      > qatomic_read(&ev->value) !=3D EV_SET
> >      > -> EV_FREE (condition is false)
> >      >
> >      > WAITER:
> >      > qatomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) =3D=3D EV_SET
> >      > -> cmpxchg returns EV_FREE, condition false.
> >      > ev->value =3D  EV_BUSY.
> >      > > TRIGGER:
> >      >          int old =3D qatomic_xchg(&ev->value, EV_SET);
> >      >          smp_mb__after_rmw();
> >      >          if (old =3D=3D EV_BUSY) {
> >      > -> old =3D EV_BUSY, condition true.
> >      > ev->value =3D EV_SET
> >      >
> >      > WAITER (in qemu_futex_wait(ev, EV_BUSY)):
> >      >      pthread_mutex_lock(&ev->lock);
> >      >      if (ev->value =3D=3D val) {
> >      > -> false, because value is EV_SET
> >      >
> >      > WAITER:
> >      >      pthread_mutex_unlock(&ev->lock);
> >      >      =E2=80=A6
> >      >      qemu_event_destroy(&job->done_event);
> >      >
> >      > TRIGGER (in qemu_futex_wake(ev, INT_MAX)):
> >      >      pthread_mutex_lock(&ev->lock);
> >      > -> hangs, because mutex has been destroyed
> >
> >     Thanks for clarification. This is very insightful.
> >
> >
> >      >
> >      >      >
> >      >      > This is all fine usually, BUT if you destroy the QemuEven=
t
> >      >     immediately
> >      >      > after the qemu_event_wait() call, qemu_futex_wake() may
> try to
> >      >     lock a
> >      >      > mutex that has been destroyed, or signal a condition
> variable
> >      >     which has
> >      >      > been destroyed. I don't see a reasonable way of making
> >     this safe
> >      >     other
> >      >      > than using long-lived mutexes and condition variables. An=
d
> >      >     anyway, we
> >      >      > have much, MUCH bigger contention/performance issues
> >     coming from
> >      >     almost
> >      >      > everything being covered by the BQL. (If waking these
> >     callbacks
> >      >     can even
> >      >      > be considered an issue: I haven't seen it show up in
> >     profiling,
> >      >     whereas
> >      >      > BQL contention very much does.)
> >      >      >
> >      >      > I'll submit v5 of this patch set with separate condition
> >      >     variables for
> >      >      > each job type. This should make the occurrence of waking
> >     the wrong
> >      >      > thread quite rare, while reasoning about correctness is
> pretty
> >      >      > straightforward. I think that's good enough.
> >
> >     What about using QemuSemaphore then? It does not seem to have the
> >     problem same with QemuEvent.
> >
> >
> > Nowhere else in the code base uses short-lived semaphores, and while I
> > can't immediately see a risk (the mutex is held during both post and
> > wait) there might be some non-obvious problem with the approach.
> > Internally, the semaphores use condition variables. The solution using
> > condition variables directly already works, is safe, relatively easy to
> > reason about, and does not cause any performance issues. There is a tin=
y
> > inefficiency about waking up a thread unnecessarily in the rare case
> > when two callbacks of the same kind occur concurrently. In practice,
> > it's irrelevant. Thanks to the awkward mismatch of the
> > PVGraphics.framework's libdispatch based approach and Qemu's BQL/AIO/BH
> > approach, we are already sending messages to other threads very
> > frequently. This isn't ideal, but not fixable without drastically
> > reducing the need to acquire the BQL across Qemu.
>
> I found several usage of ephemeral semaphores:
> h_random() in hw/ppc/spapr_rng.c
> colo_process_checkpoint() in migration/colo.c
> postcopy_thread_create() in migration/postcopy-ram.c
>
> I'm sure short-lived semaphores will keep working (or break migration in
> strange ways).
>
> >
> > I do not think it is worth spending even more time trying to fix this
> > part of the code which isn't broken in the first place.
>
> I'm sorry to bring you to this mess, which I didn't really expect. I
> thought combining a shared pair of conditional variable and mutex and
> job-specific bools is unnecessarily complex, and having one
> synchronization primitive for each job will be simpler and will just work=
.
>

With multithreading, the devil is always in the detail! =F0=9F=98=85 I woul=
dn't mind
if we were seeing genuine issues with the Mutex/Cond code, but it's fine as
far as I can tell. The QemuEvent version wasn't even really any simpler
(replacing bool done; with QemuEvent done_event; and await ->
init/wait/destroy gets longer while lock/broadcast/unlock -> set gets
shorter), and I guess a QemuSemaphore version would be about the same.
Relying on the way an edge case is handled - destroying immediately after
waiting - in the long term potentially makes the code more fragile too in
case implementation details change. I think we've reached a bikeshedding
stage here, and I suggest any further improvements on this part other than
bug fixes should be deferred to future patches.


> However, there was a pitfall with QemuEvent as you demonstrated and now
> I grep QemuEvent and QemuSemaphore to find all such ephemeral usage is
> written with QemuSemaphore instead of QemuEvent. I think the critical
> problem here is that it is not documented that qemu_event_destroy()
> cannot be used immediately after qemu_event_wait(). We would not run
> into this situation if it is written. I will write a patch to add such a
> documentation comment.
>

Sounds good, I'd be happy to review it (cc me).

Thanks for the in-depth reviews on all the patches in this set! You've
prompted me to make some significant improvements, even if the experience
with the job signalling has ended up being a frustrating one. The code is
otherwise definitely better now than before. I've just posted v5 of the
patch set and I hope we're pretty close to "good enough" now.

All the best,
Phil

--000000000000c2c8a10625a4197b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, 29 Oct 2024 at 08:42, Akihiko=
 Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On 2024/10/29 6:06, Phil Dennis-Jordan wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Mon, 28 Oct 2024 at 17:06, Akihiko Odaki &lt;<a href=3D"mailto:akih=
iko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blan=
k">akihiko.odaki@daynix.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2024/10/28 23:13, Phil Dennis-Jordan wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Mon, 28 Oct 2024 at 15:02, Akihiko Odaki<b=
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
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0On 2024/10/28 22:31, Phil =
Dennis-Jordan wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Mon, 28 Oct 2024 =
at 10:00, Phil Dennis-Jordan<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:phil=
@philjordan.eu" target=3D"_blank">phil@philjordan.eu</a> &lt;mailto:<a href=
=3D"mailto:phil@philjordan.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:phil@philjordan.eu" ta=
rget=3D"_blank">phil@philjordan.eu</a> &lt;mailto:<a href=3D"mailto:phil@ph=
iljordan.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;mailto:<a href=
=3D"mailto:phil@philjordan.eu" target=3D"_blank">phil@philjordan.eu</a> &lt=
;mailto:<a href=3D"mailto:phil@philjordan.eu" target=3D"_blank">phil@philjo=
rdan.eu</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:phil@philjordan.eu" ta=
rget=3D"_blank">phil@philjordan.eu</a> &lt;mailto:<a href=3D"mailto:phil@ph=
iljordan.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;&gt;&gt;&gt; wrote=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hmm. I think if we were to use =
that, we<br>
&gt;=C2=A0 =C2=A0 =C2=A0would<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0need to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0create a new<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; QemuEvent for every job and des=
troy it<br>
&gt;=C2=A0 =C2=A0 =C2=A0afterward,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0which seems<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0expensive.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; We can&#39;t rule out multiple =
concurrent<br>
&gt;=C2=A0 =C2=A0 =C2=A0jobs being<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0submitted, and the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; QemuEvent system only supports =
a single<br>
&gt;=C2=A0 =C2=A0 =C2=A0producer as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0far as I can<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tell.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; You can probably sort of hack a=
round it with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0just one<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0QemuEvent by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; putting the qemu_event_wait int=
o a loop<br>
&gt;=C2=A0 =C2=A0 =C2=A0and turning<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0the job.done<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0flag<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; into an atomic (because it woul=
d now<br>
&gt;=C2=A0 =C2=A0 =C2=A0need to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0checked outside the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; lock) but this all seems unnece=
ssarily<br>
&gt;=C2=A0 =C2=A0 =C2=A0complicated<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0considering the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; QemuEvent uses the same mechani=
sm QemuCond/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0QemuMutex<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0internally<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0on macOS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; (the only platform relevant her=
e), except we<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0can use it as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0intended with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; QemuCond/QemuMutex rather than =
having to<br>
&gt;=C2=A0 =C2=A0 =C2=A0work<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0against the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0abstraction.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0I don&#39;t think it&#39;s going to b=
e used<br>
&gt;=C2=A0 =C2=A0 =C2=A0concurrently. It<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0would be difficult<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0to reason even for the framework if i=
t<br>
&gt;=C2=A0 =C2=A0 =C2=A0performs memory<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0unmapping/mapping/reading operations<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0concurrently.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt; I&#39;ve just performed a very quick test by<br>
&gt;=C2=A0 =C2=A0 =C2=A0wrapping the job<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0submission/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt; wait in the 2 mapMemory callbacks and the 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0readMemory<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0callback with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt; atomic counters and logging whenever a counter went<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0above 1.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Overall, concurrent callbacks across all<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0types were<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0common (many per<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt; second when the VM is busy). It&#39;s not exactly a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&quot;thundering<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0herd&quot; (I<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt; never saw &gt;2) but it&#39;s probably not a bad idea<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0to use<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0a separate<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt; condition variable for each job type. (task map,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0surface map,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0memory read)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* While I did not observe any concurrent<br>
&gt;=C2=A0 =C2=A0 =C2=A0memory mapping<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0operations<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt; *within* a type of memory map (2 task mappings or 2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0surface<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0mappings) I<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt; did see very occasional concurrent memory *read*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0callbacks.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0These would,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt; as far as I can tell, not be safe with QemuEvents,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0unless we<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0placed the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt; event inside the job struct and init/destroyed<br>
&gt;=C2=A0 =C2=A0 =C2=A0it on every<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0callback<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &gt; (which seems like excessive overhead).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0I think we can tolerate that overhead. init/destroy<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0essentially<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0sets the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0fields in the data structure and I estimate its<br>
&gt;=C2=A0 =C2=A0 =C2=A0total size is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0about 100<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0bytes. It is probably better than waking an<br>
&gt;=C2=A0 =C2=A0 =C2=A0irrelevant thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0up. I also<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0hope that keeps the code simple; it&#39;s not worthwhile<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0adding code to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0optimize this.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0A=
t least pthread_cond_{init,destroy} and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0p=
thread_mutex_{init,destroy} don&#39;t make any syscalls,<br>
&gt;=C2=A0 =C2=A0 =C2=A0so yeah<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0it&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0p=
robably an acceptable overhead.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; I&#39;ve just experi=
mented with QemuEvents created on-demand<br>
&gt;=C2=A0 =C2=A0 =C2=A0and ran<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0into<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; some weird deadlocks=
, which then made me sit down and<br>
&gt;=C2=A0 =C2=A0 =C2=A0think about it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; some more. I&#39;ve =
come to the conclusion that creating (and<br>
&gt;=C2=A0 =C2=A0 =C2=A0crucially,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; destroying) QemuEven=
ts on demand in this way is not safe.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Specifically, you mu=
st not call qemu_event_destroy() - which<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; transitively destroy=
s the mutex and condition variable -<br>
&gt;=C2=A0 =C2=A0 =C2=A0unless<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0you can<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; guarantee that the q=
emu_event_set() call on that event<br>
&gt;=C2=A0 =C2=A0 =C2=A0object has<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0completed.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; In qemu_event_set, t=
he event object&#39;s value is atomically<br>
&gt;=C2=A0 =C2=A0 =C2=A0set to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0EV_SET.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; If the previous valu=
e was EV_BUSY, qemu_futex_wake() is<br>
&gt;=C2=A0 =C2=A0 =C2=A0called.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0All of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; this is outside any =
mutex, however, so apart from memory<br>
&gt;=C2=A0 =C2=A0 =C2=A0coherence<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; (there are barriers)=
 this can race with the waiting thread.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; qemu_event_wait() re=
ads the event&#39;s value. If EV_FREE, it&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0atomically<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; set to EV_BUSY. Then=
 the mutex is locked, the value is checked<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0again,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; and if it&#39;s stil=
l EV_BUSY, it waits for the condition<br>
&gt;=C2=A0 =C2=A0 =C2=A0variable,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; otherwise the mutex =
is immediately unlocked again. If the<br>
&gt;=C2=A0 =C2=A0 =C2=A0trigger<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread&#39;s qemu_ev=
ent_set() flip to EV_SET occurs between<br>
&gt;=C2=A0 =C2=A0 =C2=A0the waiting<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread&#39;s two ato=
mic reads of the value, the waiting thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0will<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0never<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; wait for the conditi=
on variable, but the trigger thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0WILL try to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; acquire the mutex an=
d signal the condition variable in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; qemu_futex_wake(), b=
y which=C2=A0 time the waiting thread may have<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0advanced<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; outside of qemu_even=
t_wait().<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Sorry if I&#39;m making a =
mistake again, but the waiting thread won&#39;t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0set to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0EV_BUSY unless the value i=
s EV_FREE on the second read so the<br>
&gt;=C2=A0 =C2=A0 =C2=A0trigger<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0thread will not call qemu_=
futex_wake() if it manages to set<br>
&gt;=C2=A0 =C2=A0 =C2=A0to EV_SET<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0before the second read, wi=
ll it?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; This sequence of events will cause the proble=
m:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; WAITER (in qemu_event_wait):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; value =3D qatomic_load_acquire(&amp;ev-&gt;va=
lue);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -&gt; EV_FREE<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; TRIGGER (in qemu_event_set):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; qatomic_read(&amp;ev-&gt;value) !=3D EV_SET<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -&gt; EV_FREE (condition is false)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; WAITER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; qatomic_cmpxchg(&amp;ev-&gt;value, EV_FREE, E=
V_BUSY) =3D=3D EV_SET<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -&gt; cmpxchg returns EV_FREE, condition fals=
e.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ev-&gt;value =3D=C2=A0 EV_BUSY.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &gt; TRIGGER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 int old =3D qatomic_xchg(&amp;ev-&gt;value, EV_SET);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smp_mb__aft=
er_rmw();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (old =3D=
=3D EV_BUSY) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -&gt; old =3D EV_BUSY, condition true.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ev-&gt;value =3D EV_SET<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; WAITER (in qemu_futex_wait(ev, EV_BUSY)):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 pthread_mutex_lock(&amp;e=
v-&gt;lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (ev-&gt;value =3D=3D v=
al) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -&gt; false, because value is EV_SET<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; WAITER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 pthread_mutex_unlock(&amp=
;ev-&gt;lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0=C2=A0=C2=A0 =E2=80=A6<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0=C2=A0=C2=A0 qemu_event_destroy(&=
amp;job-&gt;done_event);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; TRIGGER (in qemu_futex_wake(ev, INT_MAX)):<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 pthread_mutex_lock(&amp;e=
v-&gt;lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -&gt; hangs, because mutex has been destroyed=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks for clarification. This is very insightful.<=
br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; This is all fine usu=
ally, BUT if you destroy the QemuEvent<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0immediately<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; after the qemu_event=
_wait() call, qemu_futex_wake() may try to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0lock a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; mutex that has been =
destroyed, or signal a condition variable<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0which has<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; been destroyed. I do=
n&#39;t see a reasonable way of making<br>
&gt;=C2=A0 =C2=A0 =C2=A0this safe<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0other<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; than using long-live=
d mutexes and condition variables. And<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0anyway, we<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; have much, MUCH bigg=
er contention/performance issues<br>
&gt;=C2=A0 =C2=A0 =C2=A0coming from<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0almost<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; everything being cov=
ered by the BQL. (If waking these<br>
&gt;=C2=A0 =C2=A0 =C2=A0callbacks<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0can even<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; be considered an iss=
ue: I haven&#39;t seen it show up in<br>
&gt;=C2=A0 =C2=A0 =C2=A0profiling,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0whereas<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; BQL contention very =
much does.)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; I&#39;ll submit v5 o=
f this patch set with separate condition<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0variables for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; each job type. This =
should make the occurrence of waking<br>
&gt;=C2=A0 =C2=A0 =C2=A0the wrong<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread quite rare, w=
hile reasoning about correctness is pretty<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; straightforward. I t=
hink that&#39;s good enough.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0What about using QemuSemaphore then? It does not se=
em to have the<br>
&gt;=C2=A0 =C2=A0 =C2=A0problem same with QemuEvent.<br>
&gt; <br>
&gt; <br>
&gt; Nowhere else in the code base uses short-lived semaphores, and while I=
 <br>
&gt; can&#39;t immediately see a risk (the mutex is held during both post a=
nd <br>
&gt; wait) there might be some non-obvious problem with the approach. <br>
&gt; Internally, the semaphores use condition variables. The solution using=
 <br>
&gt; condition variables directly already works, is safe, relatively easy t=
o <br>
&gt; reason about, and does not cause any performance issues. There is a ti=
ny <br>
&gt; inefficiency about waking up a thread unnecessarily in the rare case <=
br>
&gt; when two callbacks of the same kind occur concurrently. In practice, <=
br>
&gt; it&#39;s irrelevant. Thanks to the awkward mismatch of the <br>
&gt; PVGraphics.framework&#39;s libdispatch based approach and Qemu&#39;s B=
QL/AIO/BH <br>
&gt; approach, we are already sending messages to other threads very <br>
&gt; frequently. This isn&#39;t ideal, but not fixable without drastically =
<br>
&gt; reducing the need to acquire the BQL across Qemu.<br>
<br>
I found several usage of ephemeral semaphores:<br>
h_random() in hw/ppc/spapr_rng.c<br>
colo_process_checkpoint() in migration/colo.c<br>
postcopy_thread_create() in migration/postcopy-ram.c<br>
<br>
I&#39;m sure short-lived semaphores will keep working (or break migration i=
n <br>
strange ways).<br>
<br>
&gt; <br>
&gt; I do not think it is worth spending even more time trying to fix this =
<br>
&gt; part of the code which isn&#39;t broken in the first place.<br>
<br>
I&#39;m sorry to bring you to this mess, which I didn&#39;t really expect. =
I <br>
thought combining a shared pair of conditional variable and mutex and <br>
job-specific bools is unnecessarily complex, and having one <br>
synchronization primitive for each job will be simpler and will just work.<=
br></blockquote><div><br></div><div>With multithreading, the devil is alway=
s in the detail! =F0=9F=98=85 I wouldn&#39;t mind if we were seeing genuine=
 issues with the Mutex/Cond code, but it&#39;s fine as far as I can tell. T=
he QemuEvent version wasn&#39;t even really any simpler (replacing bool don=
e; with QemuEvent done_event; and await -&gt; init/wait/destroy gets longer=
 while lock/broadcast/unlock -&gt; set gets shorter), and I guess a QemuSem=
aphore version would be about the same. Relying on the way an edge case is =
handled -  destroying immediately after waiting - in the long term potentia=
lly makes the code more fragile too in case implementation details change. =
I think we&#39;ve reached a bikeshedding stage here, and I suggest any furt=
her improvements on this part other than bug fixes should be deferred to fu=
ture patches.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
However, there was a pitfall with QemuEvent as you demonstrated and now <br=
>
I grep QemuEvent and QemuSemaphore to find all such ephemeral usage is <br>
written with QemuSemaphore instead of QemuEvent. I think the critical <br>
problem here is that it is not documented that qemu_event_destroy() <br>
cannot be used immediately after qemu_event_wait(). We would not run <br>
into this situation if it is written. I will write a patch to add such a <b=
r>
documentation comment.<br></blockquote><div><br></div><div>Sounds good, I&#=
39;d be happy to review it (cc me).</div><div><br></div><div>Thanks for the=
 in-depth reviews on all the patches in this set! You&#39;ve prompted me to=
 make some significant improvements, even if the experience with the job si=
gnalling has ended up being a frustrating one. The code is otherwise defini=
tely better now than before. I&#39;ve just posted v5 of the patch set and I=
 hope we&#39;re pretty close to &quot;good enough&quot; now.</div><div><br>=
</div><div>All the best,</div><div>Phil</div><div><br></div><div><br></div>=
<div><br></div></div></div>

--000000000000c2c8a10625a4197b--

