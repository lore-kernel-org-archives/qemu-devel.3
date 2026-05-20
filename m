Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0726CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmPw-000524-7w; Wed, 20 May 2026 15:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sinxx198@gmail.com>)
 id 1wPlci-0004vK-0t
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:33 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sinxx198@gmail.com>)
 id 1wPlcf-0002VD-Dr
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:27 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5a742b8b72eso6423007e87.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:26:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779301581; cv=none;
 d=google.com; s=arc-20240605;
 b=hZ76UcaGXWkMfjCTlcraUj4Ql0NhNXaZ+3MNzB9hlYSEyo5iyKaEi60dTCamvbjH4v
 9nNmuK1qhVTxXyhDCOnioRYUwnWPBDiKSNh+MaxFaJzA6MrMPUhNbuntynxtRc+u5Cuh
 9fqKc5JEwQ3IJYMaeSCqnHWrlWr8Q+4PnQz26Q49bHzsNGaPdnjfWdRoAlAxnWV4BzlU
 zovILlOyW8Q/QVuh8YaI/tfs6cXHMfWkQphUIcmjQIiHdZdwprGv1pHtnlztE0tozZ2L
 7gYFjTnoW4HrET8R755FrFpBdgeHFZ/UGHP97QCNlq2eifv3XTHAN1mwujWhZ6s4fB+9
 9fCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jeAoR4cxDmbfP95f/OMQmHTiGY3Q6VFFU4e+mYjR+U0=;
 fh=7R/RZGD+m7OAV6ynsYAfWZ1IG1hYR0cKwZ0GYuuX0rE=;
 b=bp8Opqb4Kgz5VOBfTjyZ5gRkadwJNnefoX/9JAzZxPWedR8Sl2gYf2lxmK1E37K+LG
 cwrdOnixALQOrQON41JaoGwvQkakJb7FQAfXYFE5/0q6IOvRkEnfPYnEqMpOZpaw0q4k
 MGUwWXD40jd7+PybsZXSKXFVkHmzGWzenpBhwRkn3WMgk2FqtUes0s+8TK0LYU/6HaGL
 CvHK4Nt+9zOBeP5NwbFVIATLk/Yf09/oA7z68EPpWbkZIYci+owAk1sx9457U4l5Vrc4
 XoeLwcBjfR53h4u05D67Ce1z9rRk8QHPq7XW61ojumf5FI2tyHlt6NWYHbQjoL4GUUaa
 y+3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779301581; x=1779906381; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jeAoR4cxDmbfP95f/OMQmHTiGY3Q6VFFU4e+mYjR+U0=;
 b=oHesJupkR9wgf3OxLPjnl+am+76e+48ZW4VzyWX78DvDihicXSsupMTrl9DR9EgF5Z
 wDA5dFcPMEy1ZE6FG+rNX24W2PwXogMQeg09a6Sari4Kj6SBKkTTNR1YG3pOaUQsHzS1
 rFJNEXEud82GIr1cJ+CxYp/XhRdNlXWmTQl/udHerSEaX9AuBhAQj8hlp5959s0BOHeG
 qRZVkyvGXoBuDFGlGcoLIie5Umjcp3IOGb8KMXLbBt6CLHKvs852v6A87Ud2S9ufXfRt
 cnoqg5JZls8MMPyKFOFJMeuLG/438w/IelOwL+b4lyrVXBN6SGgFr706+Ter2Jm1yEh/
 OuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301581; x=1779906381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jeAoR4cxDmbfP95f/OMQmHTiGY3Q6VFFU4e+mYjR+U0=;
 b=Qii0YVKRxz34/lXIP210hxv3XQ6gGKvGHVyOvXX2na3kZogfKgddqxwWm2SC841WIe
 H/wlRIegRAuPbuWpOLJ9yJ3wirm6VVjfcbqjY5W34JdM1IUunX6gw5uRZqfq8OynEvdf
 b2MUB8qFL5pyZ71HQX+O6OibOaJNJ0WmfaaCKqtMgfE3+erEryuBDSP9/Y2Hvg0+eUWf
 HquZORe8U+kl7QsUpSOCqcw2wCYTX0PR730zphOHoOAmQaja45fLWvNKAS3XDCPbLZh+
 3pg/RLuzJdxRRQ32UiF+Z+wAVEV3jPtF4JWs7SJhbyPB0KtrFzgPi0hzYzqkSLAKQyDy
 +/3A==
X-Gm-Message-State: AOJu0YwVFuMoBq775aPw8v+C6LJIjaIAxMjBrbIqkp6qnGNohKkslJfZ
 g0hc7msGI2FM4XlSsYhzWg8jXpL8xFZQaXrAXoGptRbjIqdoRN9cy9vtJykgAEYRjyufmEiAcYg
 fLiOg7CY+aWtFMeuLoLrfvYhpqyv284k=
X-Gm-Gg: Acq92OGTVeOWmZmQrME+GbT+wDeIPosfzyEJmI7j6gCORgofwwZCipjEiI0HJ3o7uNE
 1dvOpOE0Rz29anI4OtG55SmK8Q64sWehagRAtnI/eVxLR7Hb7HA3cO65sAaeFgsB9krj6VDtJJ8
 xrqiguW4GJhgFb70CEfH85S6U1iW1FCYdOZGnKJkB/3zB21L58H9VqSmFPnxybPdojxMM1TlI6Q
 u1GP93dSLY4DtzZ9BZOTpkHNwjuXL0T5TjdDRSUH2mZrXv48rInbFLQIKBEDwmapEp5Jzy9J4vT
 o3oSfq0WwZONyyANiv8DoVEOdzEgq5y2KOwtLpdGQMpqzv0T2w==
X-Received: by 2002:a05:6512:3e14:b0:5a2:b3dd:7a74 with SMTP id
 2adb3069b0e04-5aa0e73edcbmr8816294e87.33.1779301581204; Wed, 20 May 2026
 11:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <E1wPkYi-000adH-4E@kylie.crudebyte.com> <4735365.LvFx2qVVIh@weasel>
In-Reply-To: <4735365.LvFx2qVVIh@weasel>
From: sin99xx <sinxx198@gmail.com>
Date: Wed, 20 May 2026 14:26:09 -0400
X-Gm-Features: AVHnY4IRimrgGpHp1pI0qWQQEsT73eoUdEimPRpdb7H4VX_B-D2_oNpOkwuO-NY
Message-ID: <CAMX0No0JkKWL2ZPUqD8558FshhSNFJGjy6hsxqVwntRp9F3rUQ@mail.gmail.com>
Subject: Re: [PATCH] 9pfs: fix missing rename lock in v9fs_co_readdir_many
 (CVE-2026-48004)
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Content-Type: multipart/alternative; boundary="000000000000b22fc2065243ee09"
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=sinxx198@gmail.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 20 May 2026 15:17:16 -0400
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

--000000000000b22fc2065243ee09
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, please go ahead and add my Signed-off-by tag. Also, if possible, could
you use this email instead?
Signed-off-by: sin99xx sin99xx@proton.me

Thanks.

On Wed, May 20, 2026 at 2:22=E2=80=AFPM Christian Schoenebeck <
qemu_oss@crudebyte.com> wrote:

> On Wednesday, 20 May 2026 19:11:25 CEST Christian Schoenebeck wrote:
> > From: sin99xx <sinxx198@gmail.com>
> >
> > v9fs_co_readdir_many() dispatches do_readdir_many() to a worker thread
> > that reads V9fsFidState's path.data without holding a rename lock.
> >
> > A concurrent rename request, e.g. of its parent dir, causes the FID's
> > absolute path to be altered by freeing the old path string and
> > assigning a new one. This causes a heap-use-after-free race condition
> > while do_readdir_many() is still accessing the old object.
> >
> > This allows a DoS by an unprivileged guest user.
> >
> > Fix this by wrapping the worker thread dispatch block within a pair of
> > v9fs_path_read_lock() and v9fs_path_unlock() calls, like it's done at
> > other places.
> >
> > Fixes: 2149675b195f ("9pfs: add new function v9fs_co_readdir_many()")
> > Fixes: CVE-2026-48004
> > Reported-by: sin99xx <sinxx198@gmail.com>
> > [Christian Schoenebeck: add commit log message]
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
>
> sin99xx, I forgot, may I add your Signed-off-by tag?
>
>   Signed-off-by: sin99xx <sinxx198@gmail.com>
>
> This is required [1] for making you the patch author:
>
> "Your patches must include a Signed-off-by: line. This is a hard
> requirement
> because it=E2=80=99s how you say =E2=80=9CI=E2=80=99m legally okay to con=
tribute this and happy
> for it
> to go into QEMU=E2=80=9D. For full guidance, read the Code provenance
> documentation."
>
> [1] https://www.qemu.org/docs/master/devel/submitting-a-patch.html
>
> > ---
> >  hw/9pfs/codir.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
> > index bce7dd96e9..5568399343 100644
> > --- a/hw/9pfs/codir.c
> > +++ b/hw/9pfs/codir.c
> > @@ -220,13 +220,16 @@ int coroutine_fn v9fs_co_readdir_many(V9fsPDU *pd=
u,
> > V9fsFidState *fidp, bool dostat)
> >  {
> >      int err =3D 0;
> > +    V9fsState *s =3D pdu->s;
> >
> >      if (v9fs_request_cancelled(pdu)) {
> >          return -EINTR;
> >      }
> > +    v9fs_path_read_lock(s);
> >      v9fs_co_run_in_worker({
> >          err =3D do_readdir_many(pdu, fidp, entries, offset, maxsize,
> dostat);
> > });
> > +    v9fs_path_unlock(s);
> >      return err;
> >  }
>
>
>

--000000000000b22fc2065243ee09
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div style=3D"font-size:inherit" dir=3D"auto"><span style=3D"font-size:inhe=
rit;font-family:-apple-system,sans-serif">Yes, please go ahead and add my S=
igned-off-by tag. Also, if possible, could you use this email instead?</spa=
n><br></div><div style=3D"font-size:inherit" dir=3D"auto">Signed-off-by: si=
n99xx <a href=3D"mailto:sin99xx@proton.me">sin99xx@proton.me</a></div><div =
style=3D"font-size:inherit" dir=3D"auto"><br></div><div style=3D"font-size:=
inherit" dir=3D"auto">Thanks.=C2=A0</div><div style=3D"font-size:inherit" d=
ir=3D"auto"><br></div><div class=3D"gmail_quote gmail_quote_container" dir=
=3D"auto"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 20, 2026 at 2:2=
2=E2=80=AFPM Christian Schoenebeck &lt;<a href=3D"mailto:qemu_oss@crudebyte=
.com">qemu_oss@crudebyte.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">On Wednesday, 20 May 2026 19:11:25 CEST Christian Schoenebeck wrot=
e:<br>
&gt; From: sin99xx &lt;<a href=3D"mailto:sinxx198@gmail.com" target=3D"_bla=
nk">sinxx198@gmail.com</a>&gt;<br>
&gt; <br>
&gt; v9fs_co_readdir_many() dispatches do_readdir_many() to a worker thread=
<br>
&gt; that reads V9fsFidState&#39;s path.data without holding a rename lock.=
<br>
&gt; <br>
&gt; A concurrent rename request, e.g. of its parent dir, causes the FID&#3=
9;s<br>
&gt; absolute path to be altered by freeing the old path string and<br>
&gt; assigning a new one. This causes a heap-use-after-free race condition<=
br>
&gt; while do_readdir_many() is still accessing the old object.<br>
&gt; <br>
&gt; This allows a DoS by an unprivileged guest user.<br>
&gt; <br>
&gt; Fix this by wrapping the worker thread dispatch block within a pair of=
<br>
&gt; v9fs_path_read_lock() and v9fs_path_unlock() calls, like it&#39;s done=
 at<br>
&gt; other places.<br>
&gt; <br>
&gt; Fixes: 2149675b195f (&quot;9pfs: add new function v9fs_co_readdir_many=
()&quot;)<br>
&gt; Fixes: CVE-2026-48004<br>
&gt; Reported-by: sin99xx &lt;<a href=3D"mailto:sinxx198@gmail.com" target=
=3D"_blank">sinxx198@gmail.com</a>&gt;<br>
&gt; [Christian Schoenebeck: add commit log message]<br>
&gt; Signed-off-by: Christian Schoenebeck &lt;<a href=3D"mailto:qemu_oss@cr=
udebyte.com" target=3D"_blank">qemu_oss@crudebyte.com</a>&gt;<br>
<br>
sin99xx, I forgot, may I add your Signed-off-by tag?<br>
<br>
=C2=A0 Signed-off-by: sin99xx &lt;<a href=3D"mailto:sinxx198@gmail.com" tar=
get=3D"_blank">sinxx198@gmail.com</a>&gt;<br>
<br>
This is required [1] for making you the patch author:<br>
<br>
&quot;Your patches must include a Signed-off-by: line. This is a hard requi=
rement <br>
because it=E2=80=99s how you say =E2=80=9CI=E2=80=99m legally okay to contr=
ibute this and happy for it <br>
to go into QEMU=E2=80=9D. For full guidance, read the Code provenance docum=
entation.&quot;<br>
<br>
[1] <a href=3D"https://www.qemu.org/docs/master/devel/submitting-a-patch.ht=
ml" rel=3D"noreferrer" target=3D"_blank">https://www.qemu.org/docs/master/d=
evel/submitting-a-patch.html</a><br>
<br>
&gt; ---<br>
&gt;=C2=A0 hw/9pfs/codir.c | 3 +++<br>
&gt;=C2=A0 1 file changed, 3 insertions(+)<br>
&gt; <br>
&gt; diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c<br>
&gt; index bce7dd96e9..5568399343 100644<br>
&gt; --- a/hw/9pfs/codir.c<br>
&gt; +++ b/hw/9pfs/codir.c<br>
&gt; @@ -220,13 +220,16 @@ int coroutine_fn v9fs_co_readdir_many(V9fsPDU *p=
du,<br>
&gt; V9fsFidState *fidp, bool dostat)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int err =3D 0;<br>
&gt; +=C2=A0 =C2=A0 V9fsState *s =3D pdu-&gt;s;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (v9fs_request_cancelled(pdu)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINTR;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 v9fs_path_read_lock(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 v9fs_co_run_in_worker({<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D do_readdir_many(pdu, fidp, e=
ntries, offset, maxsize, dostat);<br>
&gt; });<br>
&gt; +=C2=A0 =C2=A0 v9fs_path_unlock(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return err;<br>
&gt;=C2=A0 }<br>
<br>
<br>
</blockquote></div>

--000000000000b22fc2065243ee09--

