Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB65CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1F6-0005Dr-Pu; Thu, 07 May 2026 12:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wL1Ey-0004oi-GV
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:06:22 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wL1Et-00075B-Or
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:06:19 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2ba6485d219so7397395ad.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:06:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778169974; cv=none;
 d=google.com; s=arc-20240605;
 b=O0p82/1uJPse8BqsUA1PUoF0FdFao2oWcxy3+KUwvAY/kl/qrOTXQmf335hO0bN3nN
 hsq5sPalMlQkYw7I1c8yDRluyxt7QmyGYDRJNcmWsb5+ffyMEzuOxJdRGOimDg//StFz
 o5RKYJtqt8/1KQ4tcSaRSMl0YqRGtmyC7WrYA/UNCDFKMILMXlK+1FySVdD8Sz9b77gS
 mb3+jeyxUnpZvBTuthvCk/C/2WcirBaaUfB8C9jcDppjzcwZCw9Jo3YWeyn+ZDic8dDX
 MH+6YxxooYGOnsa3QWbClSQKg73z/4VJpnMROoSCFCj2PfFpS4wXpvY/bJp+ezKdSoi9
 2ULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kTYrH+zzQgEUNn+1ZBVHdwNoK5XLNKmHWFriJn640/Q=;
 fh=nAvN4y75j2yIYcqte9EQipAO6Eg6yPvb5+V7SAzE8Vc=;
 b=T3E8a/nlED3P7p6GTArJ18H0YiZSeCV/xYCMxZD/UvL62Gx9YorcQhMzzBmuJnkoKh
 PyN0rwTVAGwElhho41COrJpyKQwoYOGnKZGtxXeHCHEWdjV9HFx42Cc9IGIsxADBBUEK
 4cHzdBth6SGXZ/2KXDyIfjqweMttoUe6fs1hT32/wy7PwjxLQ9OqgUBE45mJMur68OXL
 2w66fEu383WDcpL2KYj0JU6HFFfLutm6KF3Jfkg5dRHaEI3kXKwXEoaGQYJIsW1UHzJS
 7dyisB3C1hyUIcgerIifJE2n0Dfu8rs8lBtobkD/b1WeKQWRuMpUYjjwEY4i/1VsMJjR
 XtgQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778169974; x=1778774774;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kTYrH+zzQgEUNn+1ZBVHdwNoK5XLNKmHWFriJn640/Q=;
 b=QFG4T0tIKylWqlsXDRfmBH4NY3csHDyb0Fv7L7g3v7nWjjDJf+FEAKfTGuw5S6rqHj
 PCvWFVG8JdVPtK8RXhxThVRGPZPJXpT5umjh3wZ4bKtDs7b7Bv+jxWtHJljmMMPSxZVz
 IeuJ+9GBt5VUwrYvbCTviHchP42r9cv7wAKsf6D2L8crd6lscGXbPLn8jHFMmTBQ9+6p
 z7T1nPf1vQ/K0aETkev/9ZJ1INDSAQ099wdJN3B6QD8CI56/NizrLxQ0Spu9PsUstbQB
 +n7wSxUXk4TH5TTnquwJeBlE9OgR4UhoIyM0PwPNbGEG74fBPDRurB/3fbFWc4RVmuYc
 MjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169974; x=1778774774;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kTYrH+zzQgEUNn+1ZBVHdwNoK5XLNKmHWFriJn640/Q=;
 b=p/QpJJNHlq7EcdUabUn9u4KXt/jKM+jeWx8TI2CNtPDo5DtgYJ02vQjfb8J6vrADZp
 6LmqTUCLIXL2mXrM6M4rTiXeT9ZJiuTWGzvTA2sjHSmHH6gF+3h3e1Fz9J7e3RJX5Vxx
 D5PwnHRyxMKeVwsW0dQlUB1dW0FAA8atTFjhXjrAKOXAo6cjQG5cxl6P7yHg0J/bSfqL
 swD2pAwWLBGHVDNCIuc0IhrRZxA1VWNxhsTgyln73HmYncL8YKS7lwCP53wJsBDXXwCO
 kPAm6nQvTJTX5lXK51bE4UQGasLmRqJxbRuCHilhYUqzlKqa4zQ+9HDXfTzad1CVU9xL
 N5Lg==
X-Gm-Message-State: AOJu0Yyu9fdkpdF/XaDLmaP8QNtKS9xXek6idp3C76L/BmobBiGK/1Zo
 DUGA5Azj9J1LKmrzQBu1yqfu8HVCkJ4JCBlXBBildxOUKR/84gYg/TK1oQggs9ILyrVou5l1gNy
 Fu91GRYRJedFahbKIs5IrvA5G7CXlpptGVYF35iNFOhTVSeTaXrTIpc8=
X-Gm-Gg: AeBDiesC2SaiAUl9EicNZJPx6De+DW0wF6uYqCn9IIm4TgByOsVy49z2ABpPuG9/1Di
 JAwCBEgEOa0yZkOGzkm3Wm/ehvMQadOUlLgT4l9YC8Ost0Nr+qVfnj3Nu/qhNEuhSjIR3CqcqDq
 kqm98wNu1/50z13S13yXhD9Z01eh3Ros0U6hgT4SWRwguc4PYBgb9HKw/x1FV04RqYTN5hV4QpI
 g1J9dvomBk1sQr4/IPfNQXCt1QsrM/VER7/za8sQ7s7M+cIdIWbHXkg/7HOK9a2Uc8caxKIDNM5
 n+IUQQE/gl+Qmjdp+A==
X-Received: by 2002:a17:902:cf43:b0:2b2:67ca:5ff9 with SMTP id
 d9443c01a7336-2ba78a4564dmr91402425ad.0.1778169974144; Thu, 07 May 2026
 09:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260507-linux-user-bug-v1-1-25831e9bc22e@bsdimp.com>
 <CAFEAcA-ro3NjfPUj2A5odFCJOtdL5MV_V1bq5zuiPwyTFWo7Xg@mail.gmail.com>
In-Reply-To: <CAFEAcA-ro3NjfPUj2A5odFCJOtdL5MV_V1bq5zuiPwyTFWo7Xg@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 7 May 2026 10:06:02 -0600
X-Gm-Features: AVHnY4JNxJiLaypHh-EZYkDWXXNmV9e9bdkFYGMWqbGDSJ4Pzjj49ige4NRWFN0
Message-ID: <CANCZdfro9j8yY0GaLCGhC+Wf8Kwac+6qHmCMeYgJ0AYSZ9CwNA@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Fix a memory leak when pthread_create fails
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="000000000000a8cf4406513c757a"
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000a8cf4406513c757a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 9:48=E2=80=AFAM Peter Maydell <peter.maydell@linaro.=
org>
wrote:

> On Thu, 7 May 2026 at 16:20, Warner Losh <imp@bsdimp.com> wrote:
> >
> > Fix one of the TODO items when creating a new thread: release the copie=
d
> > cpu and free the task state.
> >
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> > Free the new task state and drop references to copied cpu structure whe=
n
> > pthread_create failes.
> > ---
> >  linux-user/syscall.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index d3d9fffb54..7b2e32bcf5 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -7005,7 +7005,6 @@ static int do_fork(CPUArchState *env, unsigned in=
t
> flags, abi_ulong newsp,
> >          cpu->random_seed =3D qemu_guest_random_seed_thread_part1();
> >
> >          ret =3D pthread_create(&info.thread, &attr, clone_func, &info)=
;
> > -        /* TODO: Free new CPU state if thread creation failed.  */
> >
> >          sigprocmask(SIG_SETMASK, &info.sigmask, NULL);
> >          pthread_attr_destroy(&attr);
> > @@ -7014,7 +7013,10 @@ static int do_fork(CPUArchState *env, unsigned
> int flags, abi_ulong newsp,
> >              pthread_cond_wait(&info.cond, &info.mutex);
> >              ret =3D info.tid;
> >          } else {
> > -            ret =3D -1;
> > +            ret =3D -host_to_target_errno(ret);
>
> This is an unrelated bugfix to the one in the commit message.
>
> I found do_fork()'s error handling confusing (the comment at
> the top doesn't exactly clarify either), but I think it is:
>  * might return a negative target errno value
>  * might return -1 with "errno" set to a host errno
>  * might succeed and return 0
>  * might succeed and return some other not-minus-1 value
>

Yea, I was confused by that and opted to 'return negative target errno'
notion here, but adding 'errno =3D ret;' just before the ret =3D -1 in the
existing
code would keep get_errno() happy... But in reality do the same thing
I submitted...

I could also just leave the bug alone as part of my submission.


> The callers all do
>    return get_errno(do_fork(....));
> which handles these cases.
>
> It might be less confusing overall if we simplified this to:
>  * returns negative target errno value on failure
>  * otherwise success, returning value the guest expects
> and dropped the get_errno() at the callsites. The only
> cases that don't already follow one of those two options are
> the "pthread_create() failed" one (which is buggy currently
> since pthread_create() doesn't set errno) and the "fork()
> failed" one (which relies on the "return -1 and caller fishes
> error out of errno" handling).
>

Yea, unwinding that looks beyond what I have time for here.


> > +            object_unparent(OBJECT(new_cpu));
> > +            object_unref(OBJECT(new_cpu));
> > +            g_free(ts);
>
> For TARGET_AARCH64, the gcs_new_stack() call we did before
> attempting the pthread_create() maps memory into the target
> address space, which needs to be undone. Compare the bit in
> TARGET_NR_exit handling which does:
>
> #ifdef TARGET_AARCH64
>             if (ts->gcs_base) {
>                 target_munmap(ts->gcs_base, ts->gcs_size);
>             }
> #endif
>
> We could maybe share code between the NR_exit "free stuff
> for this TaskState" and this error-exit path, though it's
> a bit awkward so I'm 50:50 on that.
>

Yea, it is short enough I think inlining isn't terrible, but if more of
these
cases grow, then refactoring to a routine would make sense. At the moment,
I lean more towards inlining...

Warner


> >          }
> >          pthread_mutex_unlock(&info.mutex);
> >          pthread_cond_destroy(&info.cond);
>
> thanks
> -- PMM
>

--000000000000a8cf4406513c757a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 7, =
2026 at 9:48=E2=80=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@l=
inaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On Thu, 7 May 2026 at 16:20, Warner Losh=
 &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp@bsdimp.com</a>=
&gt; wrote:<br>
&gt;<br>
&gt; Fix one of the TODO items when creating a new thread: release the copi=
ed<br>
&gt; cpu and free the task state.<br>
&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt; Free the new task state and drop references to copied cpu structure wh=
en<br>
&gt; pthread_create failes.<br>
&gt; ---<br>
&gt;=C2=A0 linux-user/syscall.c | 6 ++++--<br>
&gt;=C2=A0 1 file changed, 4 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/linux-user/syscall.c b/linux-user/syscall.c<br>
&gt; index d3d9fffb54..7b2e32bcf5 100644<br>
&gt; --- a/linux-user/syscall.c<br>
&gt; +++ b/linux-user/syscall.c<br>
&gt; @@ -7005,7 +7005,6 @@ static int do_fork(CPUArchState *env, unsigned i=
nt flags, abi_ulong newsp,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;random_seed =3D qemu_guest_r=
andom_seed_thread_part1();<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D pthread_create(&amp;info.thr=
ead, &amp;attr, clone_func, &amp;info);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: Free new CPU state if thread cre=
ation failed.=C2=A0 */<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sigprocmask(SIG_SETMASK, &amp;info.s=
igmask, NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_attr_destroy(&amp;attr);<br>
&gt; @@ -7014,7 +7013,10 @@ static int do_fork(CPUArchState *env, unsigned =
int flags, abi_ulong newsp,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_cond_wait(&amp=
;info.cond, &amp;info.mutex);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D info.tid;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -host_to_target_err=
no(ret);<br>
<br>
This is an unrelated bugfix to the one in the commit message.<br>
<br>
I found do_fork()&#39;s error handling confusing (the comment at<br>
the top doesn&#39;t exactly clarify either), but I think it is:<br>
=C2=A0* might return a negative target errno value<br>
=C2=A0* might return -1 with &quot;errno&quot; set to a host errno<br>
=C2=A0* might succeed and return 0<br>
=C2=A0* might succeed and return some other not-minus-1 value<br></blockquo=
te><div><br></div><div>Yea, I was confused by that and opted to &#39;return=
 negative target errno&#39;</div><div>notion here, but adding &#39;errno =
=3D ret;&#39; just before the ret =3D -1 in the existing</div><div>code wou=
ld keep get_errno() happy... But in reality do the same thing</div><div>I s=
ubmitted...</div><div><br></div><div>I could also just leave the bug alone =
as part of my submission.</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
The callers all do<br>
=C2=A0 =C2=A0return get_errno(do_fork(....));<br>
which handles these cases.<br>
<br>
It might be less confusing overall if we simplified this to:<br>
=C2=A0* returns negative target errno value on failure<br>
=C2=A0* otherwise success, returning value the guest expects<br>
and dropped the get_errno() at the callsites. The only<br>
cases that don&#39;t already follow one of those two options are<br>
the &quot;pthread_create() failed&quot; one (which is buggy currently<br>
since pthread_create() doesn&#39;t set errno) and the &quot;fork()<br>
failed&quot; one (which relies on the &quot;return -1 and caller fishes<br>
error out of errno&quot; handling).<br></blockquote><div><br></div><div>Yea=
, unwinding that looks beyond what I have time for here.</div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_unparent(OBJECT(new_=
cpu));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_unref(OBJECT(new_cpu=
));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(ts);<br>
<br>
For TARGET_AARCH64, the gcs_new_stack() call we did before<br>
attempting the pthread_create() maps memory into the target<br>
address space, which needs to be undone. Compare the bit in<br>
TARGET_NR_exit handling which does:<br>
<br>
#ifdef TARGET_AARCH64<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ts-&gt;gcs_base) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_munmap(ts-&g=
t;gcs_base, ts-&gt;gcs_size);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
#endif<br>
<br>
We could maybe share code between the NR_exit &quot;free stuff<br>
for this TaskState&quot; and this error-exit path, though it&#39;s<br>
a bit awkward so I&#39;m 50:50 on that.<br></blockquote><div><br></div><div=
>Yea, it is short enough I think inlining isn&#39;t terrible, but if more o=
f these</div><div>cases grow, then refactoring to a routine would make sens=
e. At the moment,</div><div>I lean more towards inlining...</div><div><br><=
/div><div>Warner</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_mutex_unlock(&amp;info.mutex=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_cond_destroy(&amp;info.cond)=
;<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--000000000000a8cf4406513c757a--

