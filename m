Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866C8E68956
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 06:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6P2g-00075T-Q4; Thu, 31 Oct 2024 02:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t6P2d-00074N-Rt
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 02:52:23 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t6P2a-0006GZ-Ek
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 02:52:23 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-720be2b27acso236076b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 23:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1730357537; x=1730962337;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=APDOlnwxW0i4iu5cgpXuOXKlIeYapWpNui3pSygCvK8=;
 b=JOZy8V6rjAYkdIJuzOJFB5s+nvk9r+3XmRNBfppWoMtLHdbyQrN8xr49oWnH0GP5hd
 qmZqAOiTOvJ2Hwf/X+olsZDhR4AfdPWQnwQSbd1uCq3iKJ8iKd4U6f0KQeUCC8/eGaLi
 IGhkubjQOEEC+XS/XHMa/79yVhLVtGnTVcRL37yXpABh0mEfvxftRdkgI2Ny6+DcOghl
 MvUfpWh+ns5YgEGq5AXi57OyAcbsJhqbVcQdsRdbPlHgwbH+gCHjG4X0WCvdD7Fh5+uR
 dyr/DOqG2XvWUqwRHtVY/lAYQ/eZQvztBuUDovz6iBpa1rZZlDGQfKXbuFjY74BEbhsQ
 Vypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730357537; x=1730962337;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=APDOlnwxW0i4iu5cgpXuOXKlIeYapWpNui3pSygCvK8=;
 b=XOijrLYo9zo54mqWW+VpboQiL2c/n1hD2zvB0grIvBnQ+SxDspOQ/j8uRt1L5a6j8z
 eijimK+9Y3JjUURnaKtZB+H2N8ELriUlSw/yixKucIPwm3yUShGbsMDuKP7wbeNni7Vi
 xXccI0q8+MKDdt7Sid2ABKjqLdB/Kg8HCnfwwJqobkFgTm8eZKmIZVpXoqjCCRN8ydFw
 S3WtMcRG27lCJTu5cuFwavoz06SO4ELk9IIivEJwgmTE63QZKw3RD2DOY6Wo3FMc+O2D
 LBYjwaJEZzavY92QEa7oj4778HoMdMvsxWooDsFACbQudZ1HNzYQwMjv3gDDx5anTCqv
 y+Fw==
X-Gm-Message-State: AOJu0YzAGd336+yxWmP8U67Bc9e5qMrKsKMSUTGu4Xyn2qNZBgbj3K3h
 DYsXgXDA3KtxzfC0BnbEL0q1scIXM+s5hFtf2t+47pcY9a+SEftBiOirN0ilPTw=
X-Google-Smtp-Source: AGHT+IGC6oiVxZH7rt3vQHXLn2+JvEouTgcwe6ezt8Q9LV/tksCPSCo2xm9nC5gRfVpTWB9RDDUuSA==
X-Received: by 2002:a05:6a00:3d09:b0:71e:44f6:6904 with SMTP id
 d2e1a72fcca58-720b9c291e0mr2965122b3a.13.1730357537295; 
 Wed, 30 Oct 2024 23:52:17 -0700 (PDT)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc1ba19asm614907b3a.21.2024.10.30.23.52.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 23:52:16 -0700 (PDT)
Message-ID: <229fe384-f0e6-4aa9-8f36-e44fc0391b75@daynix.com>
Date: Thu, 31 Oct 2024 15:52:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v4 02/15] hw/display/apple-gfx: Introduce
 ParavirtualizedGraphics.Framework support
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 Alexander Graf <graf@amazon.com>
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
Content-Language: en-US
In-Reply-To: <CAAibmn1r=xymvZg9KaOtauo5K=Juxh7GdcrSrVvd=36ymj4qFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/30 6:16, Phil Dennis-Jordan wrote:
> 
> 
> On Tue, 29 Oct 2024 at 08:42, Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     On 2024/10/29 6:06, Phil Dennis-Jordan wrote:
>      >
>      >
>      > On Mon, 28 Oct 2024 at 17:06, Akihiko Odaki
>     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
>      > <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>> wrote:
>      >
>      >     On 2024/10/28 23:13, Phil Dennis-Jordan wrote:
>      >      >
>      >      >
>      >      > On Mon, 28 Oct 2024 at 15:02, Akihiko Odaki
>      >     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
>     <mailto:akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>>
>      >      > <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>
>      >     <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>>> wrote:
>      >      >
>      >      >     On 2024/10/28 22:31, Phil Dennis-Jordan wrote:
>      >      >      >
>      >      >      >
>      >      >      > On Mon, 28 Oct 2024 at 10:00, Phil Dennis-Jordan
>      >      >     <phil@philjordan.eu <mailto:phil@philjordan.eu>
>     <mailto:phil@philjordan.eu <mailto:phil@philjordan.eu>>
>      >     <mailto:phil@philjordan.eu <mailto:phil@philjordan.eu>
>     <mailto:phil@philjordan.eu <mailto:phil@philjordan.eu>>>
>      >      >      > <mailto:phil@philjordan.eu
>     <mailto:phil@philjordan.eu> <mailto:phil@philjordan.eu
>     <mailto:phil@philjordan.eu>>
>      >     <mailto:phil@philjordan.eu <mailto:phil@philjordan.eu>
>     <mailto:phil@philjordan.eu <mailto:phil@philjordan.eu>>>>> wrote:
>      >      >      >
>      >      >      >
>      >      >      >          >      >
>      >      >      >          >      > Hmm. I think if we were to use
>     that, we
>      >     would
>      >      >     need to
>      >      >      >         create a new
>      >      >      >          >      > QemuEvent for every job and
>     destroy it
>      >     afterward,
>      >      >      >         which seems
>      >      >      >          >     expensive.
>      >      >      >          >      > We can't rule out multiple concurrent
>      >     jobs being
>      >      >      >         submitted, and the
>      >      >      >          >      > QemuEvent system only supports a
>     single
>      >     producer as
>      >      >      >         far as I can
>      >      >      >          >     tell.
>      >      >      >          >      >
>      >      >      >          >      > You can probably sort of hack
>     around it with
>      >      >     just one
>      >      >      >         QemuEvent by
>      >      >      >          >      > putting the qemu_event_wait into
>     a loop
>      >     and turning
>      >      >      >         the job.done
>      >      >      >          >     flag
>      >      >      >          >      > into an atomic (because it would now
>      >     need to be
>      >      >      >         checked outside the
>      >      >      >          >      > lock) but this all seems
>     unnecessarily
>      >     complicated
>      >      >      >         considering the
>      >      >      >          >      > QemuEvent uses the same mechanism
>     QemuCond/
>      >      >     QemuMutex
>      >      >      >         internally
>      >      >      >          >     on macOS
>      >      >      >          >      > (the only platform relevant
>     here), except we
>      >      >     can use it as
>      >      >      >          >     intended with
>      >      >      >          >      > QemuCond/QemuMutex rather than
>     having to
>      >     work
>      >      >     against the
>      >      >      >          >     abstraction.
>      >      >      >          >
>      >      >      >          >     I don't think it's going to be used
>      >     concurrently. It
>      >      >      >         would be difficult
>      >      >      >          >     to reason even for the framework if it
>      >     performs memory
>      >      >      >          >     unmapping/mapping/reading operations
>      >     concurrently.
>      >      >      >          >
>      >      >      >          >
>      >      >      >          > I've just performed a very quick test by
>      >     wrapping the job
>      >      >      >         submission/
>      >      >      >          > wait in the 2 mapMemory callbacks and the 1
>      >     readMemory
>      >      >      >         callback with
>      >      >      >          > atomic counters and logging whenever a
>     counter went
>      >      >     above 1.
>      >      >      >          >
>      >      >      >          >   * Overall, concurrent callbacks across all
>      >     types were
>      >      >      >         common (many per
>      >      >      >          > second when the VM is busy). It's not
>     exactly a
>      >      >     "thundering
>      >      >      >         herd" (I
>      >      >      >          > never saw >2) but it's probably not a
>     bad idea
>      >     to use
>      >      >     a separate
>      >      >      >          > condition variable for each job type.
>     (task map,
>      >      >     surface map,
>      >      >      >         memory read)
>      >      >      >          >   * While I did not observe any concurrent
>      >     memory mapping
>      >      >      >         operations
>      >      >      >          > *within* a type of memory map (2 task
>     mappings or 2
>      >      >     surface
>      >      >      >         mappings) I
>      >      >      >          > did see very occasional concurrent
>     memory *read*
>      >      >     callbacks.
>      >      >      >         These would,
>      >      >      >          > as far as I can tell, not be safe with
>     QemuEvents,
>      >      >     unless we
>      >      >      >         placed the
>      >      >      >          > event inside the job struct and init/
>     destroyed
>      >     it on every
>      >      >      >         callback
>      >      >      >          > (which seems like excessive overhead).
>      >      >      >
>      >      >      >         I think we can tolerate that overhead.
>     init/destroy
>      >      >     essentially
>      >      >      >         sets the
>      >      >      >         fields in the data structure and I estimate its
>      >     total size is
>      >      >      >         about 100
>      >      >      >         bytes. It is probably better than waking an
>      >     irrelevant thread
>      >      >      >         up. I also
>      >      >      >         hope that keeps the code simple; it's not
>     worthwhile
>      >      >     adding code to
>      >      >      >         optimize this.
>      >      >      >
>      >      >      >
>      >      >      >     At least pthread_cond_{init,destroy} and
>      >      >      >     pthread_mutex_{init,destroy} don't make any
>     syscalls,
>      >     so yeah
>      >      >     it's
>      >      >      >     probably an acceptable overhead.
>      >      >      >
>      >      >      >
>      >      >      > I've just experimented with QemuEvents created on-
>     demand
>      >     and ran
>      >      >     into
>      >      >      > some weird deadlocks, which then made me sit down and
>      >     think about it
>      >      >      > some more. I've come to the conclusion that
>     creating (and
>      >     crucially,
>      >      >      > destroying) QemuEvents on demand in this way is not
>     safe.
>      >      >      >
>      >      >      > Specifically, you must not call
>     qemu_event_destroy() - which
>      >      >      > transitively destroys the mutex and condition
>     variable -
>      >     unless
>      >      >     you can
>      >      >      > guarantee that the qemu_event_set() call on that event
>      >     object has
>      >      >     completed.
>      >      >      >
>      >      >      > In qemu_event_set, the event object's value is
>     atomically
>      >     set to
>      >      >     EV_SET.
>      >      >      > If the previous value was EV_BUSY, qemu_futex_wake() is
>      >     called.
>      >      >     All of
>      >      >      > this is outside any mutex, however, so apart from
>     memory
>      >     coherence
>      >      >      > (there are barriers) this can race with the waiting
>     thread.
>      >      >      > qemu_event_wait() reads the event's value. If
>     EV_FREE, it's
>      >      >     atomically
>      >      >      > set to EV_BUSY. Then the mutex is locked, the value
>     is checked
>      >      >     again,
>      >      >      > and if it's still EV_BUSY, it waits for the condition
>      >     variable,
>      >      >      > otherwise the mutex is immediately unlocked again.
>     If the
>      >     trigger
>      >      >      > thread's qemu_event_set() flip to EV_SET occurs between
>      >     the waiting
>      >      >      > thread's two atomic reads of the value, the waiting
>     thread
>      >     will
>      >      >     never
>      >      >      > wait for the condition variable, but the trigger thread
>      >     WILL try to
>      >      >      > acquire the mutex and signal the condition variable in
>      >      >      > qemu_futex_wake(), by which  time the waiting
>     thread may have
>      >      >     advanced
>      >      >      > outside of qemu_event_wait().
>      >      >
>      >      >     Sorry if I'm making a mistake again, but the waiting
>     thread won't
>      >      >     set to
>      >      >     EV_BUSY unless the value is EV_FREE on the second read
>     so the
>      >     trigger
>      >      >     thread will not call qemu_futex_wake() if it manages
>     to set
>      >     to EV_SET
>      >      >     before the second read, will it?
>      >      >
>      >      >
>      >      > This sequence of events will cause the problem:
>      >      >
>      >      > WAITER (in qemu_event_wait):
>      >      > value = qatomic_load_acquire(&ev->value);
>      >      > -> EV_FREE
>      >      >
>      >      > TRIGGER (in qemu_event_set):
>      >      > qatomic_read(&ev->value) != EV_SET
>      >      > -> EV_FREE (condition is false)
>      >      >
>      >      > WAITER:
>      >      > qatomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) == EV_SET
>      >      > -> cmpxchg returns EV_FREE, condition false.
>      >      > ev->value =  EV_BUSY.
>      >      > > TRIGGER:
>      >      >          int old = qatomic_xchg(&ev->value, EV_SET);
>      >      >          smp_mb__after_rmw();
>      >      >          if (old == EV_BUSY) {
>      >      > -> old = EV_BUSY, condition true.
>      >      > ev->value = EV_SET
>      >      >
>      >      > WAITER (in qemu_futex_wait(ev, EV_BUSY)):
>      >      >      pthread_mutex_lock(&ev->lock);
>      >      >      if (ev->value == val) {
>      >      > -> false, because value is EV_SET
>      >      >
>      >      > WAITER:
>      >      >      pthread_mutex_unlock(&ev->lock);
>      >      >      …
>      >      >      qemu_event_destroy(&job->done_event);
>      >      >
>      >      > TRIGGER (in qemu_futex_wake(ev, INT_MAX)):
>      >      >      pthread_mutex_lock(&ev->lock);
>      >      > -> hangs, because mutex has been destroyed
>      >
>      >     Thanks for clarification. This is very insightful.
>      >
>      >
>      >      >
>      >      >      >
>      >      >      > This is all fine usually, BUT if you destroy the
>     QemuEvent
>      >      >     immediately
>      >      >      > after the qemu_event_wait() call, qemu_futex_wake()
>     may try to
>      >      >     lock a
>      >      >      > mutex that has been destroyed, or signal a
>     condition variable
>      >      >     which has
>      >      >      > been destroyed. I don't see a reasonable way of making
>      >     this safe
>      >      >     other
>      >      >      > than using long-lived mutexes and condition
>     variables. And
>      >      >     anyway, we
>      >      >      > have much, MUCH bigger contention/performance issues
>      >     coming from
>      >      >     almost
>      >      >      > everything being covered by the BQL. (If waking these
>      >     callbacks
>      >      >     can even
>      >      >      > be considered an issue: I haven't seen it show up in
>      >     profiling,
>      >      >     whereas
>      >      >      > BQL contention very much does.)
>      >      >      >
>      >      >      > I'll submit v5 of this patch set with separate
>     condition
>      >      >     variables for
>      >      >      > each job type. This should make the occurrence of
>     waking
>      >     the wrong
>      >      >      > thread quite rare, while reasoning about
>     correctness is pretty
>      >      >      > straightforward. I think that's good enough.
>      >
>      >     What about using QemuSemaphore then? It does not seem to have the
>      >     problem same with QemuEvent.
>      >
>      >
>      > Nowhere else in the code base uses short-lived semaphores, and
>     while I
>      > can't immediately see a risk (the mutex is held during both post and
>      > wait) there might be some non-obvious problem with the approach.
>      > Internally, the semaphores use condition variables. The solution
>     using
>      > condition variables directly already works, is safe, relatively
>     easy to
>      > reason about, and does not cause any performance issues. There is
>     a tiny
>      > inefficiency about waking up a thread unnecessarily in the rare case
>      > when two callbacks of the same kind occur concurrently. In practice,
>      > it's irrelevant. Thanks to the awkward mismatch of the
>      > PVGraphics.framework's libdispatch based approach and Qemu's BQL/
>     AIO/BH
>      > approach, we are already sending messages to other threads very
>      > frequently. This isn't ideal, but not fixable without drastically
>      > reducing the need to acquire the BQL across Qemu.
> 
>     I found several usage of ephemeral semaphores:
>     h_random() in hw/ppc/spapr_rng.c
>     colo_process_checkpoint() in migration/colo.c
>     postcopy_thread_create() in migration/postcopy-ram.c
> 
>     I'm sure short-lived semaphores will keep working (or break
>     migration in
>     strange ways).
> 
>      >
>      > I do not think it is worth spending even more time trying to fix
>     this
>      > part of the code which isn't broken in the first place.
> 
>     I'm sorry to bring you to this mess, which I didn't really expect. I
>     thought combining a shared pair of conditional variable and mutex and
>     job-specific bools is unnecessarily complex, and having one
>     synchronization primitive for each job will be simpler and will just
>     work.
> 
> 
> With multithreading, the devil is always in the detail! 😅 I wouldn't 
> mind if we were seeing genuine issues with the Mutex/Cond code, but it's 
> fine as far as I can tell. The QemuEvent version wasn't even really any 
> simpler (replacing bool done; with QemuEvent done_event; and await -> 
> init/wait/destroy gets longer while lock/broadcast/unlock -> set gets 
> shorter), and I guess a QemuSemaphore version would be about the same. 
> Relying on the way an edge case is handled - destroying immediately 
> after waiting - in the long term potentially makes the code more fragile 
> too in case implementation details change. I think we've reached a 
> bikeshedding stage here, and I suggest any further improvements on this 
> part other than bug fixes should be deferred to future patches.

We still have more than bikeshedding. There are two design options 
discussed:

1) Whether synchronization primitives should be localized
2) Whether short-lived QemuSemaphore is appropriate if 1) is true

We discussed 2) in details, but haven't done much for 1) so there is 
some room for discussion.

Even for 2), let me emphasize that avoiding ephemeral QemuSemaphore in 
one device implementation is not appropriate as means to deal with its 
potential problem when there is similar existing usage. QEMU needs to be 
correct as whole, and having a workaround only part of its codebase is 
not OK. We need to either follow existing patterns or prepare for even 
more discussion (and I'm for the former).

Regarding 1), I think it's easier just to show code. Below is my idea of 
code change to localize synchronization primitives. This code is not 
tested or even compiled, but it should be sufficient to demonstrate the 
idea. There are a few notable observations:

a) apple_gfx_await_bh_job() can be extended to absorb all repetitive 
code of BH jobs. Such a change is probably beneficial even when 
synchronization primitives are shared, but it is more beneficial when 
synchronization primitives are localized since it allows to wrap init 
and destroy.

b) No need to declare multiple conditional variables and choosing one of 
them for each job type. Instead we can have one definition and let it 
instantiated whenever creating BH jobs.

c) Localized synchronization primitives make reasoning simpler and makes 
the comment in apple-gfx.h unnecessary. We still need the discussion of 
QemuEvent v.s. QemuSemaphore, but it will be dealt in the common code so 
apple-gfx does not need to have its own comment.

Regards,
Akihiko Odaki

---
  hw/display/apple-gfx.h      | 19 +++---------
  hw/display/apple-gfx-mmio.m | 23 ++------------
  hw/display/apple-gfx.m      | 60 +++++++++++++++++--------------------
  3 files changed, 34 insertions(+), 68 deletions(-)

diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
index e9fef09e37ea..b5aeed4f3dcf 100644
--- a/hw/display/apple-gfx.h
+++ b/hw/display/apple-gfx.h
@@ -40,19 +40,6 @@ typedef struct AppleGFXState {
      dispatch_queue_t render_queue;
      struct AppleGFXDisplayMode *display_modes;
      uint32_t num_display_modes;
-    /*
-     * QemuMutex & QemuConds for awaiting completion of PVG 
memory-mapping and
-     * reading requests after submitting them to run in the AIO context.
-     * QemuCond (rather than QemuEvent) are used so multiple concurrent 
jobs
-     * can be handled safely.
-     * The state associated with each job is tracked in a AppleGFX*Job 
struct
-     * for each kind of job; instances are allocated on the caller's stack.
-     * This struct also contains the completion flag which is used in
-     * conjunction with the condition variable.
-     */
-    QemuMutex job_mutex;
-    QemuCond task_map_job_cond;
-    QemuCond mem_read_job_cond;

      /* tasks is protected by task_mutex */
      QemuMutex task_mutex;
@@ -82,8 +69,10 @@ void apple_gfx_common_realize(AppleGFXState *s, 
PGDeviceDescriptor *desc,
  uintptr_t apple_gfx_host_address_for_gpa_range(uint64_t guest_physical,
                                                 uint64_t length, bool 
read_only,
                                                 MemoryRegion 
**mapping_in_region);
-void apple_gfx_await_bh_job(AppleGFXState *s, QemuCond *job_cond,
-                            bool *job_done_flag);
+void apple_gfx_bh_job_run_full(QEMUBHFunc *cb, void *opaque, const char 
*name);
+
+#define apple_gfx_bh_job_run(cb, opaque) \
+    apple_gfx_bh_job_run_full((cb), (opaque), (stringify(cb)))

  extern const PropertyInfo qdev_prop_display_mode;

diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
index a801c5fa722e..889a23df89e9 100644
--- a/hw/display/apple-gfx-mmio.m
+++ b/hw/display/apple-gfx-mmio.m
@@ -60,8 +60,6 @@ -(void)mmioWriteAtOffset:(size_t)offset 
value:(uint32_t)value;

      AppleGFXState common;

-    QemuCond iosfc_map_job_cond;
-    QemuCond iosfc_unmap_job_cond;
      qemu_irq irq_gfx;
      qemu_irq irq_iosfc;
      MemoryRegion iomem_iosfc;
@@ -154,7 +152,6 @@ static void raise_irq(void *opaque)
      AppleGFXMMIOState *state;
      bool read_only;
      bool success;
-    bool done;
  } AppleGFXMapSurfaceMemoryJob;

  typedef struct AppleGFXMMIOMappedRegion {
@@ -203,18 +200,13 @@ static void apple_gfx_mmio_map_surface_memory(void 
*opaque)
          }
      }

-    qemu_mutex_lock(&s->common.job_mutex);
      job->result_mem = (void *)mem;
      job->success = mem != 0;
-    job->done = true;
-    qemu_cond_broadcast(&s->iosfc_map_job_cond);
-    qemu_mutex_unlock(&s->common.job_mutex);
  }

  typedef struct AppleGFXUnmapSurfaceMemoryJob {
      void *virtual_address;
      AppleGFXMMIOState *state;
-    bool done;
  } AppleGFXUnmapSurfaceMemoryJob;

  static AppleGFXMMIOMappedRegion *find_mapped_region_containing(GArray 
*regions,
@@ -257,11 +249,6 @@ static void 
apple_gfx_mmio_unmap_surface_memory(void *opaque)
                        __func__,
                        job->virtual_address, regions->len);
      }
-
-    qemu_mutex_lock(&s->common.job_mutex);
-    job->done = true;
-    qemu_cond_broadcast(&s->iosfc_unmap_job_cond);
-    qemu_mutex_unlock(&s->common.job_mutex);
  }

  static PGIOSurfaceHostDevice *apple_gfx_prepare_iosurface_host_device(
@@ -278,9 +265,7 @@ static void apple_gfx_mmio_unmap_surface_memory(void 
*opaque)
                  .read_only = ro, .state = s,
              };

-            aio_bh_schedule_oneshot(qemu_get_aio_context(),
-                                    apple_gfx_mmio_map_surface_memory, 
&job);
-            apple_gfx_await_bh_job(&s->common, &s->iosfc_map_job_cond, 
&job.done);
+            apple_gfx_bh_job_run(apple_gfx_mmio_map_surface_memory, &job);

              *va = job.result_mem;

@@ -295,9 +280,7 @@ static void apple_gfx_mmio_unmap_surface_memory(void 
*opaque)
              AppleGFXUnmapSurfaceMemoryJob job = { va, s };
              trace_apple_gfx_iosfc_unmap_memory(va, b, c, d, e, f);

-            aio_bh_schedule_oneshot(qemu_get_aio_context(),
- 
apple_gfx_mmio_unmap_surface_memory, &job);
-            apple_gfx_await_bh_job(&s->common, 
&s->iosfc_unmap_job_cond, &job.done);
+            apple_gfx_bh_job_run(apple_gfx_mmio_unmap_surface_memory, 
&job);

              return true;
          };
@@ -336,8 +319,6 @@ static void apple_gfx_mmio_realize(DeviceState *dev, 
Error **errp)
                                2 /* Usually no more RAM regions*/);

          apple_gfx_common_realize(&s->common, desc, errp);
-        qemu_cond_init(&s->iosfc_map_job_cond);
-        qemu_cond_init(&s->iosfc_unmap_job_cond);

          [desc release];
          desc = nil;
diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 2e264e5561fc..4d174e766310 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -90,6 +90,31 @@ static dispatch_queue_t get_background_queue(void)
      return task;
  }

+typedef struct AppleGFXJob {
+  QEMUBHFunc cb;
+  void *opaque;
+  QemuSemaphore sem;
+} AppleGFXJob;
+
+void apple_gfx_bh_job_cb(void *opaque)
+{
+  AppleGFXJob *job = opaque;
+  job->cb(job->opaque);
+  qemu_sem_post(&job->sem);
+}
+
+void apple_gfx_bh_job_run_full(QEMUBHFunc *cb, void *opaque, const char 
*name)
+{
+    AppleGFXJob job;
+    job->cb = cb;
+    job->opaque = opaque;
+    qemu_sem_init(&job->sem, 0);
+    aio_bh_schedule_oneshot_full(qemu_get_aio_context(), 
apple_gfx_bh_job_cb,
+                                 &job, name);
+    qemu_sem_wait(&job->sem);
+    qemu_sem_destroy(&job->sem);
+}
+
  typedef struct AppleGFXIOJob {
      AppleGFXState *state;
      uint64_t offset;
@@ -355,7 +380,6 @@ void apple_gfx_common_init(Object *obj, 
AppleGFXState *s, const char* obj_name)
      uint32_t range_count;
      bool read_only;
      bool success;
-    bool done;
  } AppleGFXMapMemoryJob;

  uintptr_t apple_gfx_host_address_for_gpa_range(uint64_t guest_physical,
@@ -457,20 +481,7 @@ static void apple_gfx_map_memory(void *opaque)
          g_assert(r == KERN_SUCCESS);
      }

-    qemu_mutex_lock(&s->job_mutex);
      job->success = success;
-    job->done = true;
-    qemu_cond_broadcast(&s->task_map_job_cond);
-    qemu_mutex_unlock(&s->job_mutex);
-}
-
-void apple_gfx_await_bh_job(AppleGFXState *s, QemuCond *job_cond, bool 
*job_done_flag)
-{
-    qemu_mutex_lock(&s->job_mutex);
-    while (!*job_done_flag) {
-        qemu_cond_wait(job_cond, &s->job_mutex);
-    }
-    qemu_mutex_unlock(&s->job_mutex);
  }

  typedef struct AppleGFXReadMemoryJob {
@@ -478,8 +489,6 @@ void apple_gfx_await_bh_job(AppleGFXState *s, 
QemuCond *job_cond, bool *job_done
      hwaddr physical_address;
      uint64_t length;
      void *dst;
-    bool done;
-    bool success;
  } AppleGFXReadMemoryJob;

  static void apple_gfx_do_read_memory(void *opaque)
@@ -491,11 +500,6 @@ static void apple_gfx_do_read_memory(void *opaque)
      r = dma_memory_read(&address_space_memory, job->physical_address,
                          job->dst, job->length, MEMTXATTRS_UNSPECIFIED);
      job->success = r == MEMTX_OK;
-
-    qemu_mutex_lock(&s->job_mutex);
-    job->done = true;
-    qemu_cond_broadcast(&s->mem_read_job_cond);
-    qemu_mutex_unlock(&s->job_mutex);
  }

  static bool apple_gfx_read_memory(AppleGFXState *s, hwaddr 
physical_address,
@@ -508,9 +512,7 @@ static bool apple_gfx_read_memory(AppleGFXState *s, 
hwaddr physical_address,
      trace_apple_gfx_read_memory(physical_address, length, dst);

      /* Traversing the memory map requires RCU/BQL, so do it in a BH. */
-    aio_bh_schedule_oneshot(qemu_get_aio_context(), 
apple_gfx_do_read_memory,
-                            &job);
-    apple_gfx_await_bh_job(s, &s->mem_read_job_cond, &job.done);
+    apple_gfx_bh_job_run(s, apple_gfx_do_read_memory, &job);
      return job.success;
  }

@@ -556,12 +558,10 @@ static void 
apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
              .state = s,
              .task = task, .ranges = ranges, .range_count = range_count,
              .read_only = read_only, .virtual_offset = virtual_offset,
-            .done = false, .success = true,
+            .success = true,
          };
          if (range_count > 0) {
-            aio_bh_schedule_oneshot(qemu_get_aio_context(),
-                                    apple_gfx_map_memory, &job);
-            apple_gfx_await_bh_job(s, &s->task_map_job_cond, &job.done);
+            apple_gfx_bh_job_run(s, apple_gfx_map_memory, &job);
          }
          return job.success;
      };
@@ -780,10 +780,6 @@ void apple_gfx_common_realize(AppleGFXState *s, 
PGDeviceDescriptor *desc,
          apple_gfx_create_display_mode_array(display_modes, 
num_display_modes);

      create_fb(s);
-
-    qemu_mutex_init(&s->job_mutex);
-    qemu_cond_init(&s->task_map_job_cond);
-    qemu_cond_init(&s->mem_read_job_cond);
  }

  static void apple_gfx_get_display_mode(Object *obj, Visitor *v,
-- 
2.47.0

