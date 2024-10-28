Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07B4D10C11
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 13:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5PqW-0004bV-SR; Mon, 28 Oct 2024 09:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t5PqU-0004ad-AE
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 09:31:46 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t5PqR-0003rY-Sw
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 09:31:45 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3e5f968230bso1491386b6e.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730122302; x=1730727102;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ViZt5i1LowrCEgLq3TXpyh0l0Q0O4zNRRkzSe4OxN+U=;
 b=k3kez4sxyYVLDlklpjYTSOntKY/mMDHqrnIggMdiPQ+RLEQsIqkUnsiHT38hdz1mHR
 c0TpG39VEehqP5c4lH85j7vFYyLy4iES8ZT79N74W5I4imOkSmEFUbapmbiGubTDahtf
 j8EF6jOGk00Yku4Y79dY8mRf047lP/aKD4YcVDJajzvxJQbw4p0A5vlTiAtE3q8Fk8wT
 fvJAhi26xD96u/EQ0FUxdW92E1HIaLvL29FBfwgLZ2YTZEefluyGa3R3kInH8Ic7V5i5
 0LVqFCVS6oWWjII8/xYZEVEB57B3UUmwbzkw/IqndPrN/XF1PgTABP1vXPvj8MEXqxew
 c2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730122302; x=1730727102;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ViZt5i1LowrCEgLq3TXpyh0l0Q0O4zNRRkzSe4OxN+U=;
 b=XWds85Ti2sVO+vVirujXCM57NlJ4FfomBtbZzrNVB1ilbpcspMQl6gr4drLbVpYbTt
 06lmyTAx6nCVPUY5JLZTZNIQxVp9JcHmBohFtY8V1nfFORIO4b2fThgXjpAwIPz1tMjx
 0dPt/lYYMj1yI2uPiyHo6jy6KpgNo4nJ4kvHlORgPswekG5FSh20IqW4j4/KxB87kUAa
 qr0p5eezjpKL3E7Qoiu9BDd7fdNQxAwm3w9W8CV1slnzbm4BGe6mpbnctMMqqyCuVs2L
 lHRwtmArwX5RwdzjCbirV75TUKTj2lN6dnaR0A06d0x1X4RNW6V9kHLwa9FqIF0y/+VL
 Xhrg==
X-Gm-Message-State: AOJu0Ywnq1LLTSrngeDlcKLY/fndNmTYSAoKUk/ngqWl7sKCUlXmlhef
 Msf5nXPNmqmuHsyqtw2mmQQzSkN+pWCtWtE+0gAFKyEnqILWm4mywT6SPyMVecaZMBtkLCYKrqC
 6aLwHqxzmRG9E1XVOsOEvHtisLNA9W0t3uBXm
X-Google-Smtp-Source: AGHT+IHzyE8ukoSLITTIZpy/cO2QxDvoIPSFQ3QVCvsQs7c0sAuHTu3IB5TarXEB9r1tSZiVXns5mUQFkv+LRCR0Tt8=
X-Received: by 2002:a05:6808:1309:b0:3e5:de6d:71e0 with SMTP id
 5614622812f47-3e6384cea09mr6503763b6e.45.1730122302086; Mon, 28 Oct 2024
 06:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20241024102813.9855-1-phil@philjordan.eu>
 <20241024102813.9855-3-phil@philjordan.eu>
 <9e310d5e-ab73-47b9-b9ed-5a16d4db3fb9@daynix.com>
 <CAAibmn0NA+K63OvrsBpN1HivndyZo-fgeLwzY8AVE4hPrQR26w@mail.gmail.com>
 <dd2aae75-348d-44ad-bbd9-5d45aad15bc6@daynix.com>
 <CAAibmn1z+7yizwH8DogfcCWOWzA8Ox6e=p+Hc1pu-CS4SjAirg@mail.gmail.com>
 <6a989d04-6416-4bd9-98ac-e1230a1095a9@daynix.com>
 <CAAibmn3YEOT0O55-bwJkpi_oEGkA1WwvhC0w3jGbgXOZLTVa0w@mail.gmail.com>
In-Reply-To: <CAAibmn3YEOT0O55-bwJkpi_oEGkA1WwvhC0w3jGbgXOZLTVa0w@mail.gmail.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Mon, 28 Oct 2024 14:31:30 +0100
Message-ID: <CAAibmn3HZeDeK8FrYhHa1GGwc+N8rBuB2VvMRm7LCt0mUGmsYQ@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="0000000000003c00bb0625897d15"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::22d;
 envelope-from=phil@philjordan.eu; helo=mail-oi1-x22d.google.com
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

--0000000000003c00bb0625897d15
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Oct 2024 at 10:00, Phil Dennis-Jordan <phil@philjordan.eu> wrote:

>
> >      >
>> >      > Hmm. I think if we were to use that, we would need to create a
>> new
>> >      > QemuEvent for every job and destroy it afterward, which seems
>> >     expensive.
>> >      > We can't rule out multiple concurrent jobs being submitted, and
>> the
>> >      > QemuEvent system only supports a single producer as far as I can
>> >     tell.
>> >      >
>> >      > You can probably sort of hack around it with just one QemuEvent
>> by
>> >      > putting the qemu_event_wait into a loop and turning the job.done
>> >     flag
>> >      > into an atomic (because it would now need to be checked outside
>> the
>> >      > lock) but this all seems unnecessarily complicated considering
>> the
>> >      > QemuEvent uses the same mechanism QemuCond/QemuMutex internally
>> >     on macOS
>> >      > (the only platform relevant here), except we can use it as
>> >     intended with
>> >      > QemuCond/QemuMutex rather than having to work against the
>> >     abstraction.
>> >
>> >     I don't think it's going to be used concurrently. It would be
>> difficult
>> >     to reason even for the framework if it performs memory
>> >     unmapping/mapping/reading operations concurrently.
>> >
>> >
>> > I've just performed a very quick test by wrapping the job submission/
>> > wait in the 2 mapMemory callbacks and the 1 readMemory callback with
>> > atomic counters and logging whenever a counter went above 1.
>> >
>> >   * Overall, concurrent callbacks across all types were common (many
>> per
>> > second when the VM is busy). It's not exactly a "thundering herd" (I
>> > never saw >2) but it's probably not a bad idea to use a separate
>> > condition variable for each job type. (task map, surface map, memory
>> read)
>> >   * While I did not observe any concurrent memory mapping operations
>> > *within* a type of memory map (2 task mappings or 2 surface mappings) I
>> > did see very occasional concurrent memory *read* callbacks. These
>> would,
>> > as far as I can tell, not be safe with QemuEvents, unless we placed the
>> > event inside the job struct and init/destroyed it on every callback
>> > (which seems like excessive overhead).
>>
>> I think we can tolerate that overhead. init/destroy essentially sets the
>> fields in the data structure and I estimate its total size is about 100
>> bytes. It is probably better than waking an irrelevant thread up. I also
>> hope that keeps the code simple; it's not worthwhile adding code to
>> optimize this.
>>
>
> At least pthread_cond_{init,destroy} and pthread_mutex_{init,destroy}
> don't make any syscalls, so yeah it's probably an acceptable overhead.
>

I've just experimented with QemuEvents created on-demand and ran into some
weird deadlocks, which then made me sit down and think about it some more.
I've come to the conclusion that creating (and crucially, destroying)
QemuEvents on demand in this way is not safe.

Specifically, you must not call qemu_event_destroy() - which transitively
destroys the mutex and condition variable - unless you can guarantee that
the qemu_event_set() call on that event object has completed.

In qemu_event_set, the event object's value is atomically set to EV_SET. If
the previous value was EV_BUSY, qemu_futex_wake() is called. All of this is
outside any mutex, however, so apart from memory coherence (there are
barriers) this can race with the waiting thread. qemu_event_wait() reads
the event's value. If EV_FREE, it's atomically set to EV_BUSY. Then the
mutex is locked, the value is checked again, and if it's still EV_BUSY, it
waits for the condition variable, otherwise the mutex is immediately
unlocked again. If the trigger thread's qemu_event_set() flip to EV_SET
occurs between the waiting thread's two atomic reads of the value, the
waiting thread will never wait for the condition variable, but the trigger
thread WILL try to acquire the mutex and signal the condition variable in
qemu_futex_wake(), by which  time the waiting thread may have advanced
outside of qemu_event_wait().

This is all fine usually, BUT if you destroy the QemuEvent immediately
after the qemu_event_wait() call, qemu_futex_wake() may try to lock a mutex
that has been destroyed, or signal a condition variable which has been
destroyed. I don't see a reasonable way of making this safe other than
using long-lived mutexes and condition variables. And anyway, we have much,
MUCH bigger contention/performance issues coming from almost everything
being covered by the BQL. (If waking these callbacks can even be considered
an issue: I haven't seen it show up in profiling, whereas BQL contention
very much does.)

I'll submit v5 of this patch set with separate condition variables for each
job type. This should make the occurrence of waking the wrong thread quite
rare, while reasoning about correctness is pretty straightforward. I think
that's good enough.

--0000000000003c00bb0625897d15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, 28 Oct 2024 at 10:00, Phil De=
nnis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu">phil@philjordan.eu</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hmm. I think if we were to use that, we would=
 need to create a new<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; QemuEvent for every job and destroy it afterw=
ard, which seems<br>
&gt;=C2=A0 =C2=A0 =C2=A0expensive.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; We can&#39;t rule out multiple concurrent job=
s being submitted, and the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; QemuEvent system only supports a single produ=
cer as far as I can<br>
&gt;=C2=A0 =C2=A0 =C2=A0tell.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; You can probably sort of hack around it with =
just one QemuEvent by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; putting the qemu_event_wait into a loop and t=
urning the job.done<br>
&gt;=C2=A0 =C2=A0 =C2=A0flag<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; into an atomic (because it would now need to =
be checked outside the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; lock) but this all seems unnecessarily compli=
cated considering the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; QemuEvent uses the same mechanism QemuCond/Qe=
muMutex internally<br>
&gt;=C2=A0 =C2=A0 =C2=A0on macOS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (the only platform relevant here), except we =
can use it as<br>
&gt;=C2=A0 =C2=A0 =C2=A0intended with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; QemuCond/QemuMutex rather than having to work=
 against the<br>
&gt;=C2=A0 =C2=A0 =C2=A0abstraction.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I don&#39;t think it&#39;s going to be used concurr=
ently. It would be difficult<br>
&gt;=C2=A0 =C2=A0 =C2=A0to reason even for the framework if it performs mem=
ory<br>
&gt;=C2=A0 =C2=A0 =C2=A0unmapping/mapping/reading operations concurrently.<=
br>
&gt; <br>
&gt; <br>
&gt; I&#39;ve just performed a very quick test by wrapping the job submissi=
on/ <br>
&gt; wait in the 2 mapMemory callbacks and the 1 readMemory callback with <=
br>
&gt; atomic counters and logging whenever a counter went above 1.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Overall, concurrent callbacks across all types were comm=
on (many per <br>
&gt; second when the VM is busy). It&#39;s not exactly a &quot;thundering h=
erd&quot; (I <br>
&gt; never saw &gt;2) but it&#39;s probably not a bad idea to use a separat=
e <br>
&gt; condition variable for each job type. (task map, surface map, memory r=
ead)<br>
&gt;=C2=A0 =C2=A0* While I did not observe any concurrent memory mapping op=
erations <br>
&gt; *within* a type of memory map (2 task mappings or 2 surface mappings) =
I <br>
&gt; did see very occasional concurrent memory *read* callbacks. These woul=
d, <br>
&gt; as far as I can tell, not be safe with QemuEvents, unless we placed th=
e <br>
&gt; event inside the job struct and init/destroyed it on every callback <b=
r>
&gt; (which seems like excessive overhead).<br>
<br>
I think we can tolerate that overhead. init/destroy essentially sets the <b=
r>
fields in the data structure and I estimate its total size is about 100 <br=
>
bytes. It is probably better than waking an irrelevant thread up. I also <b=
r>
hope that keeps the code simple; it&#39;s not worthwhile adding code to <br=
>
optimize this.<br></blockquote><div><br></div><div>At least pthread_cond_{i=
nit,destroy} and pthread_mutex_{init,destroy} don&#39;t make any syscalls, =
so yeah it&#39;s probably an acceptable overhead.<br></div></div></div></bl=
ockquote><div><br></div><div>I&#39;ve just experimented with QemuEvents cre=
ated on-demand and ran into some weird deadlocks, which then made me sit do=
wn and think about it some more. I&#39;ve come to the conclusion that creat=
ing (and crucially, destroying) QemuEvents on demand in this way is not saf=
e.</div><div><br></div><div>Specifically, you must not call qemu_event_dest=
roy() - which transitively destroys the mutex and condition variable - unle=
ss you can guarantee that the qemu_event_set() call on that event object ha=
s completed.</div><div><br></div><div>In qemu_event_set, the event object&#=
39;s value is atomically set to EV_SET. If the previous value was EV_BUSY, =
qemu_futex_wake() is called. All of this is outside any mutex, however, so =
apart from memory coherence (there are barriers) this can race with the wai=
ting thread. qemu_event_wait() reads the event&#39;s value. If EV_FREE, it&=
#39;s atomically set to EV_BUSY. Then the mutex is locked, the value is che=
cked again, and if it&#39;s still EV_BUSY, it waits for the condition varia=
ble, otherwise the mutex is immediately unlocked again. If the trigger thre=
ad&#39;s qemu_event_set() flip to EV_SET occurs between the waiting thread&=
#39;s two atomic reads of the value, the waiting thread will never wait for=
 the condition variable, but the trigger thread WILL try to acquire the mut=
ex and signal the condition variable in qemu_futex_wake(), by which=C2=A0 t=
ime the waiting thread may have advanced outside of qemu_event_wait().</div=
><div><br></div><div>This is all fine usually, BUT if you destroy the QemuE=
vent immediately after the qemu_event_wait() call, qemu_futex_wake() may tr=
y to lock a mutex that has been destroyed, or signal a condition variable w=
hich has been destroyed. I don&#39;t see a reasonable way of making this sa=
fe other than using long-lived mutexes and condition variables. And anyway,=
 we have much, MUCH bigger contention/performance issues coming from almost=
 everything being covered by the BQL. (If waking these callbacks can even b=
e considered an issue: I haven&#39;t seen it show up in profiling, whereas =
BQL contention very much does.)</div><div><br></div><div>I&#39;ll submit v5=
 of this patch set with separate condition variables for each job type. Thi=
s should make the occurrence of waking the wrong thread quite rare, while r=
easoning about correctness is pretty straightforward. I think that&#39;s go=
od enough.</div><div><br></div><div><br></div><div><br></div></div></div>

--0000000000003c00bb0625897d15--

