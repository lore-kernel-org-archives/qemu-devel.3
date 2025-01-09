Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0694E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 13:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVsl5-00009d-JH; Thu, 09 Jan 2025 08:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wielandtdan@gmail.com>)
 id 1tVq9T-00089a-N2; Thu, 09 Jan 2025 05:52:36 -0500
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wielandtdan@gmail.com>)
 id 1tVq9Q-0007kN-Iq; Thu, 09 Jan 2025 05:52:35 -0500
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-467a1ee7ff2so6607701cf.0; 
 Thu, 09 Jan 2025 02:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736419950; x=1737024750; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cc6ZeY5GxwXJI/f/e67cz/DF6o+fx3zn1Fdx79OP900=;
 b=UOJZfAe6zBgq8QTvxzBtDMFY2ZfekrSb54UGuAadZbL40QOrQzeKMtl11K2zqz1Fqk
 VQn9EDqZaY++LOutIpqSia5v0FaV+WPDBawyOKRhaJxEaMxQo++WtlULcLE2po1p9++i
 s2D5NCOzTaIDFwDYR6JAojT+ybDmfAGJKUGogSaMpjrrp+XRzDKki5wxHtimOQ+DAPZg
 mHZgIJLrEF0UPzC165Byg0b1DLzmr3nUwHgEaQqGdXGKGRql6GjuTX3GZVLm9FF4HXFH
 oghMZrW5lRtARKUJODZNSZKHC/mLv+LNLUqHjIW1iUQpdQfRauO1HRUmlu/QiELbLOeI
 S2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736419950; x=1737024750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cc6ZeY5GxwXJI/f/e67cz/DF6o+fx3zn1Fdx79OP900=;
 b=NDOWAd8gbnqefaDDuQVmSqUs8WE9r0cDbKgSivHptcHgzU39wRQVciOGdz6FgNhFiU
 UcgDuN6mn0h6+kxZ0iKxDAWSivnnQkNgbMymlPQ+HpPOR+yiKWMknYBszTeXpc6LDv3Z
 KIogJZqwOTFfN+kzaH5Hm0ws1U599HQKzAztPDfw5ck9GUn9M/szLy+zckyYepOFefo7
 7gRAKcFe4KqjwIxVIIWnxe+GgGsRhMcs/ek4ZSZjZxjHQLsKHCi648gSowWsey9/SdPG
 PMAp5LxjFqxerGNMS3uIS/4XpV77ThOZvQDXRZMrNhNaHQ4SCFo6ONEr2Pw/qfEETO9J
 nqcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUINBTf/Jp4mu3hASY0mUsJJv0ZCWtppW+104x0kDbTbPqMH6jbn+dvLG/53nlPgdUNGsODi/m7oRGWtA==@nongnu.org,
 AJvYcCWfxCuU63eA506c6rKCFv9fW4rHlkp5QtcgGztLoTyqT729N69hRnEyonjxWBoHaEhEPtcWvVfOMRIiI8s=@nongnu.org,
 AJvYcCX/vNa0X/+H6sFJxakwlgz0uEwf0golIq7B9do6SovA7BG0ZvsSPN56cAkK0BSbWqV4kCOyjf7yW/KW@nongnu.org
X-Gm-Message-State: AOJu0YyydB04/uIdlYdgt/yJH4RgDSK5qSfMLqCHOpNS3YdxtyqbZBHm
 g/VT1VqgKLwnYp5Mhmhur4wZqcyzcxI1446bPymtNYwKbsCs3/xsob4PHVJ5BcwZHCYaUv3to39
 zJ9PG2pTchHzTbBvlPIPxaI+Wb0E=
X-Gm-Gg: ASbGncsGn+RDIQv8CBm/2EJVeUVBmKw9+H2mXrMBikIlppigXj6PplHzt7uANQ468o7
 lbVMDHZEzf9kXWt6A7V3jCIjNt4M9bedvlyNA
X-Google-Smtp-Source: AGHT+IHHFVs5Cov9G0l214ejmzW+FG4w6Cvmr9cd9cM+FXDECZSeO6SysVxjIt/NGrjrAV1lvre6flyhscfP2V9gQQE=
X-Received: by 2002:a05:6214:2463:b0:6d8:ab7e:e552 with SMTP id
 6a1803df08f44-6df9b2de7edmr109730026d6.39.1736419950438; Thu, 09 Jan 2025
 02:52:30 -0800 (PST)
MIME-Version: 1.0
References: <20250108124649.333668-1-f.ebner@proxmox.com>
 <Z3-pTUj66O2nfqc_@redhat.com>
In-Reply-To: <Z3-pTUj66O2nfqc_@redhat.com>
From: Daniel Wielandt <wielandtdan@gmail.com>
Date: Thu, 9 Jan 2025 04:52:19 -0600
X-Gm-Features: AbW1kvbmrscI8lHLmZzyF4Ug0iHWGj32_u2AM3eSVGUs5AC3M6RV8_L1x05mz54
Message-ID: <CA+7p6PKEx552-wN_5ueq6E=mNTNYpGpUYgo3wGRM+fxbG=icyQ@mail.gmail.com>
Subject: Re: [PATCH] block-backend: protect setting block root to NULL with
 block graph write lock
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, hreitz@redhat.com, qemu-block@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000053ae0c062b43c696"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=wielandtdan@gmail.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Jan 2025 08:39:34 -0500
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

--00000000000053ae0c062b43c696
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Suggestions hold pattern.. programmers obviously understand control logic.
Systems built with operational flaws. Will freeze up when u start repairing
it while it's running.

On Thu, Jan 9, 2025, 4:48=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wrote:

> Am 08.01.2025 um 13:46 hat Fiona Ebner geschrieben:
> > Setting blk->root is a graph change operation and thus needs to be
> > protected by the block graph write lock in blk_remove_bs(). The
> > assignment to blk->root in blk_insert_bs() is already protected by
> > the block graph write lock.
>
> Hm, if that's the case, then we should also enforce this in the
> declaration of BlockBackend:
>
>     BdrvChild * GRAPH_RDLOCK_PTR root;
>
> However, this results in more compiler failures that we need to fix. You
> caught the only remaining writer, but the lock is only fully effective
> if all readers take it, too.
>
> > In particular, the graph read lock in blk_co_do_flush() could
> > previously not ensure that blk_bs(blk) would always return the same
> > value during the locked section, which could lead to a segfault [0] in
> > combination with migration [1].
> >
> > From the user-provided backtraces in the forum thread [1], it seems
> > like blk_co_do_flush() managed to get past the
> > blk_co_is_available(blk) check, meaning that blk_bs(blk) returned a
> > non-NULL value during the check, but then, when calling
> > bdrv_co_flush(), blk_bs(blk) returned NULL.
> >
> > [0]:
> >
> > > 0  bdrv_primary_child (bs=3Dbs@entry=3D0x0) at ../block.c:8287
> > > 1  bdrv_co_flush (bs=3D0x0) at ../block/io.c:2948
> > > 2  bdrv_co_flush_entry (opaque=3D0x7a610affae90) at block/block-gen.c=
:901
> >
> > [1]: https://forum.proxmox.com/threads/158072
> >
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> > ---
> >  block/block-backend.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/block/block-backend.c b/block/block-backend.c
> > index c93a7525ad..9678615318 100644
> > --- a/block/block-backend.c
> > +++ b/block/block-backend.c
> > @@ -887,9 +887,9 @@ void blk_remove_bs(BlockBackend *blk)
> >       */
> >      blk_drain(blk);
> >      root =3D blk->root;
> > -    blk->root =3D NULL;
> >
> >      bdrv_graph_wrlock();
> > +    blk->root =3D NULL;
> >      bdrv_root_unref_child(root);
> >      bdrv_graph_wrunlock();
> >  }
>
> I think the 'root =3D blk->root' needs to be inside the locked section,
> too. Otherwise blk->root could change during bdrv_graph_wrlock() (which
> has a nested event loop) and root would be stale. I assume clang would
> complain about this with the added GRAPH_RDLOCK_PTR.
>
> Kevin
>
>
>

--00000000000053ae0c062b43c696
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Suggestions hold pattern.. programmers obviously understand =
control logic. Systems built with operational flaws. Will freeze up when u =
start repairing it while it&#39;s running.<br>
</p>
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Jan 9, 2025, 4:48=E2=80=AFAM Kevin Wolf &lt;<a href=
=3D"mailto:kwolf@redhat.com">kwolf@redhat.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">Am 08.01.2025 um 13:46 hat Fiona Ebner geschriebe=
n:<br>
&gt; Setting blk-&gt;root is a graph change operation and thus needs to be<=
br>
&gt; protected by the block graph write lock in blk_remove_bs(). The<br>
&gt; assignment to blk-&gt;root in blk_insert_bs() is already protected by<=
br>
&gt; the block graph write lock.<br>
<br>
Hm, if that&#39;s the case, then we should also enforce this in the<br>
declaration of BlockBackend:<br>
<br>
=C2=A0 =C2=A0 BdrvChild * GRAPH_RDLOCK_PTR root;<br>
<br>
However, this results in more compiler failures that we need to fix. You<br=
>
caught the only remaining writer, but the lock is only fully effective<br>
if all readers take it, too.<br>
<br>
&gt; In particular, the graph read lock in blk_co_do_flush() could<br>
&gt; previously not ensure that blk_bs(blk) would always return the same<br=
>
&gt; value during the locked section, which could lead to a segfault [0] in=
<br>
&gt; combination with migration [1].<br>
&gt; <br>
&gt; From the user-provided backtraces in the forum thread [1], it seems<br=
>
&gt; like blk_co_do_flush() managed to get past the<br>
&gt; blk_co_is_available(blk) check, meaning that blk_bs(blk) returned a<br=
>
&gt; non-NULL value during the check, but then, when calling<br>
&gt; bdrv_co_flush(), blk_bs(blk) returned NULL.<br>
&gt; <br>
&gt; [0]:<br>
&gt; <br>
&gt; &gt; 0=C2=A0 bdrv_primary_child (bs=3Dbs@entry=3D0x0) at ../block.c:82=
87<br>
&gt; &gt; 1=C2=A0 bdrv_co_flush (bs=3D0x0) at ../block/io.c:2948<br>
&gt; &gt; 2=C2=A0 bdrv_co_flush_entry (opaque=3D0x7a610affae90) at block/bl=
ock-gen.c:901<br>
&gt; <br>
&gt; [1]: <a href=3D"https://forum.proxmox.com/threads/158072" rel=3D"noref=
errer noreferrer" target=3D"_blank">https://forum.proxmox.com/threads/15807=
2</a><br>
&gt; <br>
&gt; Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank" rel=3D=
"noreferrer">qemu-stable@nongnu.org</a><br>
&gt; Signed-off-by: Fiona Ebner &lt;<a href=3D"mailto:f.ebner@proxmox.com" =
target=3D"_blank" rel=3D"noreferrer">f.ebner@proxmox.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 block/block-backend.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/block/block-backend.c b/block/block-backend.c<br>
&gt; index c93a7525ad..9678615318 100644<br>
&gt; --- a/block/block-backend.c<br>
&gt; +++ b/block/block-backend.c<br>
&gt; @@ -887,9 +887,9 @@ void blk_remove_bs(BlockBackend *blk)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 blk_drain(blk);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 root =3D blk-&gt;root;<br>
&gt; -=C2=A0 =C2=A0 blk-&gt;root =3D NULL;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 bdrv_graph_wrlock();<br>
&gt; +=C2=A0 =C2=A0 blk-&gt;root =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bdrv_root_unref_child(root);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bdrv_graph_wrunlock();<br>
&gt;=C2=A0 }<br>
<br>
I think the &#39;root =3D blk-&gt;root&#39; needs to be inside the locked s=
ection,<br>
too. Otherwise blk-&gt;root could change during bdrv_graph_wrlock() (which<=
br>
has a nested event loop) and root would be stale. I assume clang would<br>
complain about this with the added GRAPH_RDLOCK_PTR.<br>
<br>
Kevin<br>
<br>
<br>
</blockquote></div>

--00000000000053ae0c062b43c696--

