Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83477C982FE
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8tVJ-0003fH-K9; Tue, 22 Sep 2026 01:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irtaza.hyder@10xengineers.ai>)
 id 1x8tVH-0003f7-Kc
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 01:57:19 -0400
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <irtaza.hyder@10xengineers.ai>)
 id 1x8tVE-0002Xi-Gb
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 01:57:19 -0400
Received: by mail-pz2-x0d.google.com with SMTP id
 d2e1a72fcca58-85469a34907so4013047b3a.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 22:57:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790056632; cv=none;
 d=google.com; s=arc-20260327;
 b=lY2YZHVvlmAjF6pu5Ci0QbEa19EJoFmOcwo0a+ADqqztD5M0n2rnZsKxYqO2/VmxgY
 jGwgfVFNXVSveqPDg6vxpk89V6ZiCWvfpBHcpsAd6eoStEwJKDPtzsAAk9xYAMWLrke2
 FkYBqeucAFLlL5VyRNxKA9dZWj/oO39x2vgpESwmM456vk6D/xtfYEoF8X/Q362sVp/q
 LYhgWt483m6LTQxcPfTgh6xy3krzOMsoDO2LAfnE9HsWEPz1T1JXvjZjOW1ZLzZu8cVO
 CwBPTFiDhpL8u+moiofJgs/teBc+VzA1kB8hE1TnEFQvOasuqCWR99/KvRsDTWPU2sWB
 dbqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=th4G8h7k2XpsLen4ypbj8Us/TornVqNscNnths28B+A=;
 fh=G/GAXTf0joU8NY5/s7xS19D9uSeUemg6blsNMojTbYk=;
 b=ceBYnY1jWKMbqh/mbmkye7Si/YCu7fghws0xcQVIk4ftL5OU/9r1Hn+HIek6vFm/Bd
 u86Z4UW13ovRAmi6u/oR3Ts52kVdETMvh8LndxBlGF3ZiuhKLY79qcyJrKbwK3aERgFm
 kbjttQfcwXorw8hnr3oNYsFJu8u/Mjc8uVHtjA6UGsPip0CrmTo4yefaOS+R/OQ5kQPe
 ykVkpRIU5/+nWHoHw4JjNqaQPlv/fP/npXshkBEJ7CVOAxtbA9MTK5zWirkRkyk9VQia
 NovdtFcvj+tA0vZZK96KxdI7OZ5o7Dm/CSVLelfjgpep/4ddpQ53QQ9gHDvVbBzRT2sN
 /7+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=10xengineers.ai; s=google; t=1790056632; x=1790661432; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=th4G8h7k2XpsLen4ypbj8Us/TornVqNscNnths28B+A=;
 b=LojN8yxV5w+7NcXJLvrSVei+Z4M563YFvlf7pfeyhz8JLJEjAclaWfvIGF7b3Qfj9T
 TrU3jDUmQMb99eFkCAroLxJ/JB4rtnHwsAfO1ChjQ241HYj3HVAad4OF9WZRYDMsKchv
 tj/G8HXkwo436mGhdBFefp4y3udobVdclKlTfVCJeuYtq1FhHi2gutDVde9NytqDmvP2
 FAKeXkw3ctnI4N071ZhldQrVJ4AdmhN6f3xDzkOUxWRewV1RFIRF5a9Rjss9bOnvmWwV
 mHowGvLA7VVqhENLFr5eyBRmBQ777lO4eVcIAm6YDb8iOkxKeXhbGpi5+tNYs5itAOjM
 GHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790056632; x=1790661432;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=th4G8h7k2XpsLen4ypbj8Us/TornVqNscNnths28B+A=;
 b=f1/URaQM1NxyWQfqZYfwYEK4XcZ87/i3vPvyiWpHDnHfNFS0WpbmUYKuKBQwZ7UCjg
 X5JH8gSjwsR7iVlQrFSdGopcj5C2u/f5G51eZqnnD2uaSXjSoqdUYDNt1s4XbzZQWC0u
 Iz1mwR0xZHQQouPEwQrtYPyntV24NV2p3LZoZIeTUm7oMrrtDTRZ7E/ttVhE2aoY+rCQ
 lImsqWZCTOzYQusOZk5kjnlf7d8DuC00G5hvw3yUOaYBbLU1YWSLv2+s1fPwrbjmyncu
 vlNnqKsCc0kdshdLdQC/0L7biYkeHQzF2JAAsnNRiIItSHPMAHkXZXRtZiQ/dXT9n2gX
 1K2g==
X-Gm-Message-State: AFuF++l9gLpMz3l3HwOYdduX865WbFJpTPY/xtvB5J7n2bvE2s5ZBb5s
 EvBjuIdIxEC2OgvYmPpYb/o0rOWbEJ/yLmpXrmg3zfWFcHgF9Rx/YPTgzbeC5X+R8Pg7Bf7PDDd
 buhrrDeej4SLJDHbHQG9xPdoDkE9QmwjBmF7fJwcFBQ==
X-Gm-Gg: AYBFou2bb6f/ZpAFqhm4VDLlaGCy97cbj1ZKeN/PceGDdJof8SStMKfKdY2XPa5sJ9h
 Gxf4HOMVNOAiGBmhCzPy8pRYBGJvuKp0i4kS9UnNZg5UMiG4kg/rzjPR45nKsbsKCBYjHRnP3nT
 /nqMY0IZ8nctlUegpazh363YTMf2h6mju2kVtsE1bUJcs/CEa47DnO9pC8wJqbnBssrQKJMJG1Y
 BWUaZ8oT3TUCw1E3pnkwlkNTgB16/+gDxejN2xy1TxHxIhAMvnLm9B07Dc4SdWEs+Xdza88giXg
 etQJZ7UVSYNfWzw2zAXtGy2jzkXQzuAas3hVw6sd59KcZFjiDrFbf4PUQeC1yaItZcKIOrECy0O
 UNrywQBXs/NxJbF+RrkCOX8ugp/U7QKg/0GuOQYV/lRooEFpXvqrFuAk=
X-Received: by 2002:a05:6a00:9513:b0:878:34d7:6976 with SMTP id
 d2e1a72fcca58-87c83c4a091mr109823b3a.36.1790056632370; Mon, 21 Sep 2026
 22:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAPF+SGdq9yngvDxCM+YeeaF0HKSkN4TgE0KK09DpCdEqPczYOw@mail.gmail.com>
 <CAJSP0QUMjJ7J+_=jDO7Ek353-DnShz0deRDHi-WQ4SVMwp_rpw@mail.gmail.com>
In-Reply-To: <CAJSP0QUMjJ7J+_=jDO7Ek353-DnShz0deRDHi-WQ4SVMwp_rpw@mail.gmail.com>
From: Irtaza Hyder <irtaza.hyder@10xengineers.ai>
Date: Tue, 22 Sep 2026 10:57:00 +0500
X-Gm-Features: AcwNN1Vr_6MjfdeywkGqLP0eDxy32gnmm4gI-_s0xqkeWtxPtEX89uvQ9_Zg96M
Message-ID: <CAPF+SGf+PUNOS=gGZZO_FtanDfhGrq_7o7X86tq8K=j8_PE07g@mail.gmail.com>
Subject: Re: Deferring FD read/write to worker thread while vCPU remains halted
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000b355cc065c0c09b0"
Received-SPF: pass client-ip=2607:f8b0:4864:3b::d;
 envelope-from=irtaza.hyder@10xengineers.ai; helo=mail-pz2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000b355cc065c0c09b0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan. Thanks for your reply. As you have pointed out correctly, I am
trying to implement out-of-process device emulation and hence require the
blocking call.

I was unable to get the memory_region_enable_lockless_io() to work
properly. I have assigned the memory region triggering the blocking call to
become lockless, verified QEMU treated it as lockless as well, yet the
main-loop still got stuck waiting on BQL. It seems the BQL was taken by
`do_ld_mmio_beN` in the call stack involved in accessing my device's
memory region. Additionally the call stack showed memory_read_dispatch
being called twice on different memory region addresses (physmem and then
my device memory). Is it because I am using a **SysBus** device?

The spapr_rng.c approach is working as desired. I just want to confirm if
that is the correct approach in this case, or does a better approach exist.

Many thanks!
Regards,
Irtaza

On Tue, Sep 15, 2026 at 1:35=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:

> On Sun, Sep 13, 2026 at 2:37=E2=80=AFPM Irtaza Hyder
> <irtaza.hyder@10xengineers.ai> wrote:
> >
> > In the [QEMU Internals Overall Architecture Blogpost](
> https://blog.vmsplice.net/2011/03/qemu-internals-overall-architecture-and=
.html),
> the following is stated:
> > > Although many I/O operations can be performed in a non-blocking
> fashion, there are system calls which have no non-blocking equivalent.
> Furthermore, sometimes long-running computations simply hog the CPU and a=
re
> difficult to break up into callbacks. In these cases dedicated worker
> threads can be used to carefully move these tasks out of core QEMU.
> >
> > The blog stated example implementations are no longer available in QEMU
> 11 to gain insight on how worker threads are used.
> >
> > For my use case, I am trying to trigger external file descriptor writes
> and wait for the corresponding read based on vCPU instructions (i.e.
> register/MMIO rmw operations). In my current implementation register
> read/write operations are redirected to the following function:
> > ``` C
> > MemTxResult fd_mmio_rmw(hwaddr addr, bool is_write, int bytes,
> >                         uint64_t wdata, uint64_t *rdata,
> >                         CharFrontend *fe)
> > {
> >     int chardev_status;
> >
> >     if (!qemu_chr_fe_backend_open(fe)) {
> >         /* Charbackend is not open */
> >         return MEMTX_ERROR;
> >     }
> >
> >     chardev_status =3D qemu_chr_fe_write_all(fe, (uint8_t *)wdata, byte=
s);
> >     if (chardev_status =3D=3D -1) {
> >         /* Unable to write to socket */
> >         return MEMTX_ERROR;
> >     }
> >
> >     chardev_status =3D qemu_chr_fe_read_all(fe, (uint8_t*)rdata, bytes)=
;
> >     if (chardev_status < 0) {
> >         return MEMTX_ERROR;
> >     }
> >     return MEMTX_OK;
> > }
> > ```
> > But this function blocks the main event loop due to the blocking charde=
v
> frontend APIs. How can:
>
> Hi Irtaza,
> Doing blocking I/O in a MemoryRegionOps .read() or .write() function
> is fundamentally a problem. I say blocking because your code example
> suggests that the rmw function not only needs to initiate I/O but also
> needs to wait for it to complete. That can take an unbounded amount of
> time. The vCPU is blocked during this time, which is a performance
> problem and can cause problems inside the guest if this takes a long
> time (e.g. Linux can complain about hung tasks and Windows can
> bluescreen).
>
> The first thing to do is check whether it's possible to avoid this
> altogether. Can you write the device emulation code in a way that does
> not block the vCPU? The answer depends on the MMIO interface your are
> implementing.
>
> In some cases it's unavoidable (e.g. out-of-process device emulation).
>
> > 1. The function be deferred to a worker thread as mentioned in the blog=
,
> while keeping the vCPU triggering this request halted but the main event
> loop running?
>
> The issue here is the Big QEMU Lock (BQL) that protects most state in
> QEMU. The vCPU thread running the rmw function holds the BQL and other
> threads (including the main loop thread) cannot run during this time.
>
> There is an API to avoid taking the BQL during a MemoryRegionOps
> callback: memory_region_enable_lockless_io(). If you are careful when
> writing your rmw function, you could write blocking code and use this
> to prevent the other vCPU threads and the main loop thread from
> blocking.
>
> hw/ppc/spapr_rng.c:h_random() uses a similar approach but without
> memory_region_enable_lockless_io():
> 1. Initiate I/O
> 2. bql_unlock()
> 3. Wait for I/O completion
> 4. bql_lock()
>
> > 2. The worker threads be synchronized with the main loop (i.e. how woul=
d
> it inform the main loop to give control to vCPU executing instructions ON=
LY
> after the FD read is completed)?
>
> This is probably not necessary if you use the BQL techniques mentioned
> above.
>
> Stefan
>

--000000000000b355cc065c0c09b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Stefan. Thanks for=C2=A0your reply. As you have pointed=
 out correctly, I am trying to implement out-of-process device emulation an=
d hence require the blocking call.<div><br></div><div>I was unable to get t=
he memory_region_enable_lockless_io() to work properly. I have assigned the=
 memory region triggering the blocking call to become lockless, verified QE=
MU treated it as lockless as well, yet the main-loop still got stuck waitin=
g on BQL. It seems the BQL was taken by `do_ld_mmio_beN` in the call stack =
involved in accessing my device&#39;s memory=C2=A0region. Additionally the =
call stack showed memory_read_dispatch being called twice on different memo=
ry region addresses (physmem and then my device memory). Is it because=C2=
=A0I am using a **SysBus** device?</div><div><br></div><div>The spapr_rng.c=
 approach is working as desired. I just want to confirm if that is the corr=
ect approach in this case, or does a better approach exist.</div><div><br><=
/div><div>Many thanks!<br>Regards,</div><div>Irtaza</div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 15, 20=
26 at 1:35=E2=80=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.=
com" target=3D"_blank">stefanha@gmail.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On Sun, Sep 13, 2026 at 2:37=E2=80=
=AFPM Irtaza Hyder<br>
&lt;<a href=3D"mailto:irtaza.hyder@10xengineers.ai" target=3D"_blank">irtaz=
a.hyder@10xengineers.ai</a>&gt; wrote:<br>
&gt;<br>
&gt; In the [QEMU Internals Overall Architecture Blogpost](<a href=3D"https=
://blog.vmsplice.net/2011/03/qemu-internals-overall-architecture-and.html" =
rel=3D"noreferrer" target=3D"_blank">https://blog.vmsplice.net/2011/03/qemu=
-internals-overall-architecture-and.html</a>), the following is stated:<br>
&gt; &gt; Although many I/O operations can be performed in a non-blocking f=
ashion, there are system calls which have no non-blocking equivalent. Furth=
ermore, sometimes long-running computations simply hog the CPU and are diff=
icult to break up into callbacks. In these cases dedicated worker threads c=
an be used to carefully move these tasks out of core QEMU.<br>
&gt;<br>
&gt; The blog stated example implementations are no longer available in QEM=
U 11 to gain insight on how worker threads are used.<br>
&gt;<br>
&gt; For my use case, I am trying to trigger external file descriptor write=
s and wait for the corresponding read based on vCPU instructions (i.e. regi=
ster/MMIO rmw operations). In my current implementation register read/write=
 operations are redirected to the following function:<br>
&gt; ``` C<br>
&gt; MemTxResult fd_mmio_rmw(hwaddr addr, bool is_write, int bytes,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0uint64_t wdata, uint64_t *rdata,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0CharFrontend *fe)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0int chardev_status;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (!qemu_chr_fe_backend_open(fe)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Charbackend is not open */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return MEMTX_ERROR;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0chardev_status =3D qemu_chr_fe_write_all(fe, (uint8=
_t *)wdata, bytes);<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (chardev_status =3D=3D -1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Unable to write to socket */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return MEMTX_ERROR;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0chardev_status =3D qemu_chr_fe_read_all(fe, (uint8_=
t*)rdata, bytes);<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (chardev_status &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return MEMTX_ERROR;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0return MEMTX_OK;<br>
&gt; }<br>
&gt; ```<br>
&gt; But this function blocks the main event loop due to the blocking chard=
ev frontend APIs. How can:<br>
<br>
Hi Irtaza,<br>
Doing blocking I/O in a MemoryRegionOps .read() or .write() function<br>
is fundamentally a problem. I say blocking because your code example<br>
suggests that the rmw function not only needs to initiate I/O but also<br>
needs to wait for it to complete. That can take an unbounded amount of<br>
time. The vCPU is blocked during this time, which is a performance<br>
problem and can cause problems inside the guest if this takes a long<br>
time (e.g. Linux can complain about hung tasks and Windows can<br>
bluescreen).<br>
<br>
The first thing to do is check whether it&#39;s possible to avoid this<br>
altogether. Can you write the device emulation code in a way that does<br>
not block the vCPU? The answer depends on the MMIO interface your are<br>
implementing.<br>
<br>
In some cases it&#39;s unavoidable (e.g. out-of-process device emulation).<=
br>
<br>
&gt; 1. The function be deferred to a worker thread as mentioned in the blo=
g, while keeping the vCPU triggering this request halted but the main event=
 loop running?<br>
<br>
The issue here is the Big QEMU Lock (BQL) that protects most state in<br>
QEMU. The vCPU thread running the rmw function holds the BQL and other<br>
threads (including the main loop thread) cannot run during this time.<br>
<br>
There is an API to avoid taking the BQL during a MemoryRegionOps<br>
callback: memory_region_enable_lockless_io(). If you are careful when<br>
writing your rmw function, you could write blocking code and use this<br>
to prevent the other vCPU threads and the main loop thread from<br>
blocking.<br>
<br>
hw/ppc/spapr_rng.c:h_random() uses a similar approach but without<br>
memory_region_enable_lockless_io():<br>
1. Initiate I/O<br>
2. bql_unlock()<br>
3. Wait for I/O completion<br>
4. bql_lock()<br>
<br>
&gt; 2. The worker threads be synchronized with the main loop (i.e. how wou=
ld it inform the main loop to give control to vCPU executing instructions O=
NLY after the FD read is completed)?<br>
<br>
This is probably not necessary if you use the BQL techniques mentioned abov=
e.<br>
<br>
Stefan<br>
</blockquote></div>

--000000000000b355cc065c0c09b0--

