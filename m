Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD52BD5B176
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 14:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5mq6-0001HA-AX; Tue, 29 Oct 2024 10:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t5mq2-0001Gc-FG
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 10:04:51 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t5mpx-00057p-Fl
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 10:04:49 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5daa93677e1so2796476eaf.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 07:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730210682; x=1730815482;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9LCtpfDarLZxUu9LyaLi86Qqpc2dqBh1AAo2k0jTwDM=;
 b=TaBEJ7niIs83Zxcj0XHZwxUMWYHuQFORlEdHbwt1qnOXX587kLm0wuG+knqdr6azvN
 cKinuFTew0uaUqzyp/e1ikNjIbSAjXIC6sDbvxxYcgkZYz1uCf28W9LY/c5B4Q2G6haa
 /KMWCrGwTlbFJctju+xLsAplYf04UUiPjUhu0h86Mktr9P2Lj65HY9aR/cRAbdZKbMVy
 DBaKohxNWNltDx/cRIARCTR+LNkXKWdpk0eckOPBH5o/duajcLCPWbAIh0uMCFNzxKLU
 l9dTIJsQIZt+ZknAvpBPprkolEIVUKLGKodp+Wv8TEu2yx8F7mGKYTDDRPlhlITbseEE
 pQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730210682; x=1730815482;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9LCtpfDarLZxUu9LyaLi86Qqpc2dqBh1AAo2k0jTwDM=;
 b=pmFlEHoqmFejn6Hwb7Z18rjI0cv6gyD2je2Uo0TNwyZ3Ci6xCYIINP8tHnhxpSxnFJ
 6XHdxc3tRbKrlHXnBJXljtgXzHmxYqeERUPB0up9PhaNDTU18jXO7JIfRrnLk5bU4wHG
 KCLuseennHGELbnoyXmcp2VbVeZMTI5eCAp1/PGN/b66k2YEFZw18I9jYSw5axWd08PM
 QriudjWJ76gVKaebN/7UfvB3BEWTy/Y9eX15lpJEDn6YtQMX9+2T/Te7NIc2hioxyIKx
 +/CXreCWGpjIuYOowcnG6weh3CjjY0xm3Heny4K1tMUZz1nLS2QFYwp3MVfBN++YYmWl
 lsiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPbsW/Mj1sLtxOShPXQsKMq2r/qqtQda/cbiaSkKCUibiFCKDomym8oXYGujOx6Hdu3X55DWO7/6bk@nongnu.org
X-Gm-Message-State: AOJu0YyFcI0qgGqNOYz44ZC8GmAxqGZuEpN6nALCWGccZBtdCfV2pGRN
 wjfslzhKejLlGmArAtMbPme3lAViEl5Ox3K7Ph++UBFn17jFNuQvn8P/fKomVNEXnglhyiBReV2
 GJrtTPwxg+I9GpS4nhcAlKA5cAKJyRebA85Am
X-Google-Smtp-Source: AGHT+IFbgcCfZaBNEzZEaynusIOG6fVee1J+od8ieorBQd3npNWCCO5x0nyzX8N8Oq+/u82RL3NPcxxsbvClUn9gL6E=
X-Received: by 2002:a05:6358:719:b0:1c3:9572:5c9c with SMTP id
 e5c5f4694b2df-1c3f9f67287mr456306955d.23.1730210680888; Tue, 29 Oct 2024
 07:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240716180941.40211-1-philmd@linaro.org>
 <20240716180941.40211-12-philmd@linaro.org>
 <f0b1df5e-4eee-4a56-a8a0-5426cdf2b3d5@tls.msk.ru>
In-Reply-To: <f0b1df5e-4eee-4a56-a8a0-5426cdf2b3d5@tls.msk.ru>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Tue, 29 Oct 2024 15:04:29 +0100
Message-ID: <CAAibmn1FQgHwt4LapR1gJzyue4bf7Uhbua0sxGg+PxaEjR0Row@mail.gmail.com>
Subject: Re: [PULL 11/13] ui/console: Remove dpy_cursor_define_supported()
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000596a106259e1114"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::c34;
 envelope-from=phil@philjordan.eu; helo=mail-oo1-xc34.google.com
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

--0000000000000596a106259e1114
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Oct 2024 at 13:30, Michael Tokarev <mjt@tls.msk.ru> wrote:

> 16.07.2024 21:09, Philippe Mathieu-Daud=C3=A9 wrote:
> > From: Akihiko Odaki <akihiko.odaki@daynix.com>
> >
> > Remove dpy_cursor_define_supported() as it brings no benefit today and
> > it has a few inherent problems.
> >
> > All graphical displays except egl-headless support cursor composition
> > without DMA-BUF, and egl-headless is meant to be used in conjunction
> > with another graphical display, so dpy_cursor_define_supported()
> > always returns true and meaningless.
> >
> > Even if we add a new display without cursor composition in the future,
> > dpy_cursor_define_supported() will be problematic as a cursor display
> > fix for it because some display devices like virtio-gpu cannot tell the
> > lack of cursor composition capability to the guest and are unable to
> > utilize the value the function returns. Therefore, all non-headless
> > graphical displays must actually implement cursor composition for
> > correct cursor display.
> >
> > Another problem with dpy_cursor_define_supported() is that it returns
> > true even if only some of the display listeners support cursor
> > composition, which is wrong unless all display listeners that lack
> > cursor composition is headless.
>
> Apparently this commit made windows10 guest to freeze.  There's a rather
> hairy bugreport at https://bugs.debian.org/1084199 .  Also there's an
> interesting bug filed against qemu,
> https://gitlab.com/qemu-project/qemu/-/issues/1628 ,
> which seems to be relevant.
>
> Can you take a look please?
>
> This user did a great job bisecting qemu with no experience whatsoever..
>
>
It seems an odd commit to be causing this, but you never know=E2=80=A6 Some=
 random
thoughts on this and a few questions:



As far as I can tell, in both cases the guest display adapter is QXL. In
the case of the Debian user, I think the UI backend is SPICE? Presumably
the it's the same for the user reporting the bug directly against Qemu, as
they also seem to be using libvirt. (No full command line available as far
as I can see?) In any case, the SPICE display specifies:

    .dpy_cursor_define       =3D display_mouse_define,

Which means the old dpy_cursor_define_supported() would have been returning
true prior to this commit, with the modified QXL and VMSvga code paths
theoretically unaffected. A bit odd, to say the least.

But I suppose it's possible that my understanding is incorrect, and
dpy_cursor_define_supported() might have returned false. The code in
qxl_render_cursor that follows this check and which will now always run, vs
would not have done previously includes:

    if (qxl->debug > 1 && cmd->type !=3D QXL_CURSOR_MOVE) {
        fprintf(stderr, "%s", __func__);
        qxl_log_cmd_cursor(qxl, cmd, ext->group_id);
        fprintf(stderr, "\n");
    }

Can we get the user to set qxl->debug to a value > 1 and see if the freeze
coincides with logging from here? (Possibly tricky to intercept the fprintf
output from Qemu run via libvirt though.)

I also notice that the subsequent code in the QXL_CURSOR_SET case looks a
lot like the code being replaced by Michael's patch from the Qemu bug
tracker. (qxl_phys2virt calls) It looks OK to me, but I'm not familiar with
QXL at all, so perhaps a chunk of code that could use another review?


Or could it be a timing-dependent bug? Although the removed check should
have been rather cheap and shouldn't affect timing much:
- if (!dpy_cursor_define_supported(qxl->vga.con)) {
-        return 0;
-    }



Given that "The time before the freeze seems to be random, from a few
seconds to a couple of minutes." there is a possibility of a false
negative during the bisect. (i.e. commit marked GOOD that should be BAD
because it happened to not hit the freeze in the usual time) If that was
the case, we would expect the regression to be caused by a nearby *earlier*
commit. The only candidate I can spot that touches SPICE or QXL or the
display subsystem in general is a418e7a (ui/console: Convert mouse
visibility parameter into bool) from the same patchset which looks even
more benign, however.



We could ask the user to check whether there's any connection with mouse
cursor changes, e.g. whether he can more easily provoke the issue by
perform actions that rapidly change the mouse cursor. (For example by
visiting https://developer.mozilla.org/en-US/docs/Web/CSS/cursor in the
guest and moving back and forth over the test area.)


Is there an easy way to take a sampling profile on Linux that will show us
stack traces of all the threads in the frozen Qemu process? On macOS this
is easy with the Activity Monitor GUI or iprofiler on the command line.
That ought to confirm whether it's a deadlock or indefinite wait in some
Qemu subsystem.


Michael, what's the situation with the patch you suggested in your comment
on the Qemu bug:
https://gitlab.com/qemu-project/qemu/-/issues/1628#note_2144606625 ? Is
there any chance we can get the Debian user to try that?



Hope that helps!
Phil

--0000000000000596a106259e1114
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, 29 Oct 2024 at 13:30, Michael=
 Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru">mjt@tls.msk.ru</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">16.07.2024 21:=
09, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; From: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" ta=
rget=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
&gt; <br>
&gt; Remove dpy_cursor_define_supported() as it brings no benefit today and=
<br>
&gt; it has a few inherent problems.<br>
&gt; <br>
&gt; All graphical displays except egl-headless support cursor composition<=
br>
&gt; without DMA-BUF, and egl-headless is meant to be used in conjunction<b=
r>
&gt; with another graphical display, so dpy_cursor_define_supported()<br>
&gt; always returns true and meaningless.<br>
&gt; <br>
&gt; Even if we add a new display without cursor composition in the future,=
<br>
&gt; dpy_cursor_define_supported() will be problematic as a cursor display<=
br>
&gt; fix for it because some display devices like virtio-gpu cannot tell th=
e<br>
&gt; lack of cursor composition capability to the guest and are unable to<b=
r>
&gt; utilize the value the function returns. Therefore, all non-headless<br=
>
&gt; graphical displays must actually implement cursor composition for<br>
&gt; correct cursor display.<br>
&gt; <br>
&gt; Another problem with dpy_cursor_define_supported() is that it returns<=
br>
&gt; true even if only some of the display listeners support cursor<br>
&gt; composition, which is wrong unless all display listeners that lack<br>
&gt; cursor composition is headless.<br>
<br>
Apparently this commit made windows10 guest to freeze.=C2=A0 There&#39;s a =
rather<br>
hairy bugreport at <a href=3D"https://bugs.debian.org/1084199" rel=3D"noref=
errer" target=3D"_blank">https://bugs.debian.org/1084199</a> .=C2=A0 Also t=
here&#39;s an<br>
interesting bug filed against qemu, <a href=3D"https://gitlab.com/qemu-proj=
ect/qemu/-/issues/1628" rel=3D"noreferrer" target=3D"_blank">https://gitlab=
.com/qemu-project/qemu/-/issues/1628</a> ,<br>
which seems to be relevant.<br>
<br>
Can you take a look please?<br>
<br>
This user did a great job bisecting qemu with no experience whatsoever..<br=
>
<br></blockquote><div><br></div><div>It seems an odd commit to be causing t=
his, but you never know=E2=80=A6 Some random thoughts on this and a few que=
stions:<br></div><div><br></div><div><br></div><div><br></div><div>As far a=
s I can tell, in both cases the guest display adapter is QXL. In the case o=
f the Debian user, I think the UI backend is SPICE? Presumably the it&#39;s=
 the same for the user reporting the bug directly against Qemu, as they als=
o seem to be using libvirt. (No full command line available as far as I can=
 see?) In any case, the SPICE display specifies:</div><div><br></div><div>=
=C2=A0=C2=A0=C2=A0 .dpy_cursor_define =C2=A0 =C2=A0 =C2=A0 =3D display_mous=
e_define,</div><div><br></div><div>Which means the old dpy_cursor_define_su=
pported() would have been returning true prior to this commit, with the mod=
ified QXL and VMSvga code paths theoretically unaffected. A bit odd, to say=
 the least.</div><div><br></div><div>But I suppose it&#39;s possible that m=
y understanding is incorrect, and dpy_cursor_define_supported() might have =
returned false. The code in qxl_render_cursor that follows this check and w=
hich will now always run, vs would not have done previously includes:</div>=
<div><br></div><div>=C2=A0 =C2=A0 if (qxl-&gt;debug &gt; 1 &amp;&amp; cmd-&=
gt;type !=3D QXL_CURSOR_MOVE) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stde=
rr, &quot;%s&quot;, __func__);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 qxl_log_cmd_c=
ursor(qxl, cmd, ext-&gt;group_id);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(s=
tderr, &quot;\n&quot;);<br>=C2=A0 =C2=A0 }</div><div><br></div><div>Can we =
get the user to set qxl-&gt;debug to a value &gt; 1 and see if the freeze c=
oincides with logging from here? (Possibly tricky to intercept the fprintf =
output from Qemu run via libvirt though.)<br></div><div><br></div><div>I al=
so notice that the subsequent code in the QXL_CURSOR_SET case looks a lot l=
ike the code being replaced by Michael&#39;s patch from the Qemu bug tracke=
r. (qxl_phys2virt calls) It looks OK to me, but I&#39;m not familiar with Q=
XL at all, so perhaps a chunk of code that could use another review?<br></d=
iv><div><br></div><div><br></div><div>Or could it be a timing-dependent bug=
? Although the removed check should have been rather cheap and shouldn&#39;=
t affect timing much:<br></div><div>- if (!dpy_cursor_define_supported(qxl-=
&gt;vga.con)) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>- =C2=A0 =C2=
=A0}</div><div><br></div><div><br></div><div><br></div><div>Given that &quo=
t;The time before the freeze seems to be random, from a few seconds to a co=
uple of minutes.&quot; there is a possibility of a false negative=C2=A0duri=
ng the bisect. (i.e. commit marked GOOD that should be BAD because it happe=
ned to not hit the freeze in the usual time) If that was the case, we would=
 expect the regression to be caused by a nearby <b>earlier</b> commit. The =
only candidate I can spot that touches SPICE or QXL or the display subsyste=
m in general is a418e7a (ui/console: Convert mouse visibility parameter int=
o bool) from the same patchset which looks even more  benign, however.<br><=
/div><div><br></div><div><br></div><div><br></div><div>We could ask the use=
r to check whether there&#39;s any connection with mouse cursor changes, e.=
g. whether he can more easily provoke the issue by perform actions that rap=
idly change the mouse cursor. (For example by visiting <a href=3D"https://d=
eveloper.mozilla.org/en-US/docs/Web/CSS/cursor">https://developer.mozilla.o=
rg/en-US/docs/Web/CSS/cursor</a> in the guest and moving back and forth ove=
r the test area.)<br></div><div><br></div><div><br></div><div>Is there an e=
asy way to take a sampling profile on Linux that will show us stack traces =
of all the threads in the frozen Qemu process? On macOS this is easy with t=
he Activity Monitor GUI or iprofiler on the command line. That ought to con=
firm whether it&#39;s a deadlock or indefinite wait in some Qemu subsystem.=
<br></div><div><br></div><div><br></div><div>Michael, what&#39;s the situat=
ion with the patch you suggested in your comment on the Qemu bug: <a href=
=3D"https://gitlab.com/qemu-project/qemu/-/issues/1628#note_2144606625">htt=
ps://gitlab.com/qemu-project/qemu/-/issues/1628#note_2144606625</a> ? Is th=
ere any chance we can get the Debian user to try that?</div><div><br></div>=
<div><br></div><div><br></div><div>Hope that helps!</div><div>Phil<br></div=
><div><br></div></div></div>

--0000000000000596a106259e1114--

