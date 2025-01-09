Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D535E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 13:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVsl7-0000DD-Dj; Thu, 09 Jan 2025 08:39:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wielandtdan@gmail.com>)
 id 1tVqGq-0002pN-A9; Thu, 09 Jan 2025 06:00:13 -0500
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wielandtdan@gmail.com>)
 id 1tVqGo-0000Y8-0q; Thu, 09 Jan 2025 06:00:11 -0500
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b700c13edaso38868285a.3; 
 Thu, 09 Jan 2025 03:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736420408; x=1737025208; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5YIm3QxsyqzrfbrWoVNshlPpsvjCfEI+wdwMb+u4a28=;
 b=cBCKfPAGNUJKMk4n5Xi1J64Y7GMD7O/kI57NjUViKZEHD2r6NYafK7xo96B/8Wyt0l
 wWUUToV5uYDqfzx0l1euiQE29jego0Pv4wneibhQMSYtcYu1FqdgvS8DcMfyRJ3/01/A
 MJ1FpoH5Ozg8fQZru5CUh5w3dX/pijK0o3bQ7KbAGWTtUuEXTnGuoayZlBNO68yDDoPw
 4+qNjoRvNJFkLlxZzm3RBjHEK7uWYzHq7kdez/wHNVCoulvVrS6ifM/0mgV8UtSoR6uf
 h5rkEmL/kG5qBy07jAC4vcq77yFL8IG51/3Ser2ZSB3qfsFXW8D3P7+eNFPY+BoFYpu9
 6jeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736420408; x=1737025208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5YIm3QxsyqzrfbrWoVNshlPpsvjCfEI+wdwMb+u4a28=;
 b=uAiKPeESzkS42vcHquuMLTdfHzGDDK4KkJQ5nTdlFYhTU69tKyGw1ukhKMdS2ohzIg
 BRAF0IsNXkx7bJHJpeOUbX0QyjpfSsPJvCb8U04IyrpqO1VZgAC8TMjhnTObK99t81pI
 3Bq3QDUV4juAmW6o29pa3o7H0b5hrSkNRa6y8PJWYN0QaZwL3+YZkT47Ksn1xNZKhEaq
 ewUTSIWNKBvreJjWKY63DbQZUBzLMBpyjcrbA+ozQA+qCUv+PzxOtGy023YecBNVt5lb
 tBOCRlhmqOdfW2gYpA10CQwnKgObTLqZHxUT39jZwY2Y2iY/Gs8LhJvBYgnATe7Kk9ZG
 oxQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcKp++hLPNCqYpDQ6LyioRfy/YTWUh4hpLVoj558MGn+1I/zwiub+MYpr3KxomhYtjXHDPVE7vCEgn@nongnu.org,
 AJvYcCVf9s9L4DvzOUj2gnWhFnf+MN3yHFe3r/MYA+j35ENEHCnWqQqAsi28oJyDO6O72olsHRPARNehrV1sZ1U=@nongnu.org,
 AJvYcCW5HfnU2Ug2/1dJliv1wKkZvx2FkPNMjp5zvcMF+Mg1j1hv7cun7OZl+YI0tEcRtO/qSTRvskoV8BS35g==@nongnu.org
X-Gm-Message-State: AOJu0YwOpaP2oBySzKVeDQDKLIPtmD8PkPXVoGCXUZWKWjlLQ66fC4qk
 dSED/mrQCsN05VtOKudt1GoeHeOSS7lT53ijviQt4KQ0Z7rJHngITIe0wuEbG+VALcB0dk75DSc
 k61Ttc/xuVOa6h6hEpxvmSXSLjm9QDnZC
X-Gm-Gg: ASbGncsPRSb4pRWDFG16xIjmpxOyC5NcnhRsY9C6kxSLbHiyWhDa3uYU2lGM2lgXyzE
 ssgm+PmfjV0olnt6qC6gK+99X9F5lDlemPkYq
X-Google-Smtp-Source: AGHT+IEs6goTPG9VqHoAxyjOBV7cKthxFAbMGRdoEHpvUUJrl+oLcEab94CINPG466P89jQWiT9FR8YzskA9sBGe7ac=
X-Received: by 2002:a05:620a:31a8:b0:7b6:d273:9b44 with SMTP id
 af79cd13be357-7bcd970a98bmr911378485a.18.1736420407808; Thu, 09 Jan 2025
 03:00:07 -0800 (PST)
MIME-Version: 1.0
References: <20250108124649.333668-1-f.ebner@proxmox.com>
 <Z3-pTUj66O2nfqc_@redhat.com>
 <CA+7p6PKEx552-wN_5ueq6E=mNTNYpGpUYgo3wGRM+fxbG=icyQ@mail.gmail.com>
 <CA+7p6P+hc7hYqfK1pLeN5y9ALEVM8HoioMvUK-45AboM5yDWuQ@mail.gmail.com>
In-Reply-To: <CA+7p6P+hc7hYqfK1pLeN5y9ALEVM8HoioMvUK-45AboM5yDWuQ@mail.gmail.com>
From: Daniel Wielandt <wielandtdan@gmail.com>
Date: Thu, 9 Jan 2025 04:59:56 -0600
X-Gm-Features: AbW1kvbCp9mK5AtbYqnpecCwcdsvuCzMFWscG4sRJGxiZxbOJQtj0DD6-NGHWjI
Message-ID: <CA+7p6PJwmpTsB3xS+6_ZSKM3ZqBwVv4cGTaRd_mMDWjKsQSLoA@mail.gmail.com>
Subject: Re: [PATCH] block-backend: protect setting block root to NULL with
 block graph write lock
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, hreitz@redhat.com, qemu-block@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000969855062b43e14e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=wielandtdan@gmail.com; helo=mail-qk1-x732.google.com
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

--000000000000969855062b43e14e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We all know how the thing works and operates it does t take a genius to
know what's working and what's not.. I mean. I.notsaying take out tge
things that made us like to use it.. but I mean command should be
understood logic should be what we use as a am
Standard.. and trust me depending on where your at with structure and
scripts the logic can even be ...codeing..

On Thu, Jan 9, 2025, 4:55=E2=80=AFAM Daniel Wielandt <wielandtdan@gmail.com=
> wrote:

> I feel like your too focused on new problems when you  gave up repairing
> to old os.. be ause at one time it was real slick.. now.theres parts that
> are problems that can be eliminated easy and provide  a less bloated
> function with simple code deletion.. fix the original is down its it's
> primary parts
> .then u can add your fancy automation and setting get real com0lucated
>
> On Thu, Jan 9, 2025, 4:52=E2=80=AFAM Daniel Wielandt <wielandtdan@gmail.c=
om>
> wrote:
>
>> Suggestions hold pattern.. programmers obviously understand control
>> logic. Systems built with operational flaws. Will freeze up when u start
>> repairing it while it's running.
>>
>> On Thu, Jan 9, 2025, 4:48=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wrote=
:
>>
>>> Am 08.01.2025 um 13:46 hat Fiona Ebner geschrieben:
>>> > Setting blk->root is a graph change operation and thus needs to be
>>> > protected by the block graph write lock in blk_remove_bs(). The
>>> > assignment to blk->root in blk_insert_bs() is already protected by
>>> > the block graph write lock.
>>>
>>> Hm, if that's the case, then we should also enforce this in the
>>> declaration of BlockBackend:
>>>
>>>     BdrvChild * GRAPH_RDLOCK_PTR root;
>>>
>>> However, this results in more compiler failures that we need to fix. Yo=
u
>>> caught the only remaining writer, but the lock is only fully effective
>>> if all readers take it, too.
>>>
>>> > In particular, the graph read lock in blk_co_do_flush() could
>>> > previously not ensure that blk_bs(blk) would always return the same
>>> > value during the locked section, which could lead to a segfault [0] i=
n
>>> > combination with migration [1].
>>> >
>>> > From the user-provided backtraces in the forum thread [1], it seems
>>> > like blk_co_do_flush() managed to get past the
>>> > blk_co_is_available(blk) check, meaning that blk_bs(blk) returned a
>>> > non-NULL value during the check, but then, when calling
>>> > bdrv_co_flush(), blk_bs(blk) returned NULL.
>>> >
>>> > [0]:
>>> >
>>> > > 0  bdrv_primary_child (bs=3Dbs@entry=3D0x0) at ../block.c:8287
>>> > > 1  bdrv_co_flush (bs=3D0x0) at ../block/io.c:2948
>>> > > 2  bdrv_co_flush_entry (opaque=3D0x7a610affae90) at
>>> block/block-gen.c:901
>>> >
>>> > [1]: https://forum.proxmox.com/threads/158072
>>> >
>>> > Cc: qemu-stable@nongnu.org
>>> > Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
>>> > ---
>>> >  block/block-backend.c | 2 +-
>>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>>> >
>>> > diff --git a/block/block-backend.c b/block/block-backend.c
>>> > index c93a7525ad..9678615318 100644
>>> > --- a/block/block-backend.c
>>> > +++ b/block/block-backend.c
>>> > @@ -887,9 +887,9 @@ void blk_remove_bs(BlockBackend *blk)
>>> >       */
>>> >      blk_drain(blk);
>>> >      root =3D blk->root;
>>> > -    blk->root =3D NULL;
>>> >
>>> >      bdrv_graph_wrlock();
>>> > +    blk->root =3D NULL;
>>> >      bdrv_root_unref_child(root);
>>> >      bdrv_graph_wrunlock();
>>> >  }
>>>
>>> I think the 'root =3D blk->root' needs to be inside the locked section,
>>> too. Otherwise blk->root could change during bdrv_graph_wrlock() (which
>>> has a nested event loop) and root would be stale. I assume clang would
>>> complain about this with the added GRAPH_RDLOCK_PTR.
>>>
>>> Kevin
>>>
>>>
>>>

--000000000000969855062b43e14e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">We all know how the thing works and operates it does t take =
a genius to know what&#39;s working and what&#39;s not.. I mean. I.notsayin=
g take out tge things that made us like to use it.. but I mean command shou=
ld be understood logic should be what we use as a am<br>
Standard.. and trust me depending on where your at with structure and scrip=
ts the logic can even be ...codeing..</p>
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Jan 9, 2025, 4:55=E2=80=AFAM Daniel Wielandt &lt;<a=
 href=3D"mailto:wielandtdan@gmail.com">wielandtdan@gmail.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><p dir=3D"ltr">I feel like your to=
o focused on new problems when you=C2=A0 gave up repairing to old os.. be a=
use at one time it was real slick.. now.theres parts that are problems that=
 can be eliminated easy and provide=C2=A0 a less bloated function with simp=
le code deletion.. fix the original is down its it&#39;s primary parts<br>
.then u can add your fancy automation and setting get real com0lucated</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu=
, Jan 9, 2025, 4:52=E2=80=AFAM Daniel Wielandt &lt;<a href=3D"mailto:wielan=
dtdan@gmail.com" target=3D"_blank" rel=3D"noreferrer">wielandtdan@gmail.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><p dir=3D"ltr">Sugg=
estions hold pattern.. programmers obviously understand control logic. Syst=
ems built with operational flaws. Will freeze up when u start repairing it =
while it&#39;s running.<br>
</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu=
, Jan 9, 2025, 4:48=E2=80=AFAM Kevin Wolf &lt;<a href=3D"mailto:kwolf@redha=
t.com" rel=3D"noreferrer noreferrer" target=3D"_blank">kwolf@redhat.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Am 08.01.2025 um 13:46 =
hat Fiona Ebner geschrieben:<br>
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
errer noreferrer noreferrer noreferrer" target=3D"_blank">https://forum.pro=
xmox.com/threads/158072</a><br>
&gt; <br>
&gt; Cc: <a href=3D"mailto:qemu-stable@nongnu.org" rel=3D"noreferrer norefe=
rrer noreferrer" target=3D"_blank">qemu-stable@nongnu.org</a><br>
&gt; Signed-off-by: Fiona Ebner &lt;<a href=3D"mailto:f.ebner@proxmox.com" =
rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">f.ebner@proxmox.=
com</a>&gt;<br>
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
</blockquote></div>
</blockquote></div>

--000000000000969855062b43e14e--

