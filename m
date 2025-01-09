Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A574E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 13:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVsl5-00009c-GM; Thu, 09 Jan 2025 08:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wielandtdan@gmail.com>)
 id 1tVqKH-0003pc-0i; Thu, 09 Jan 2025 06:03:45 -0500
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wielandtdan@gmail.com>)
 id 1tVqKE-00015C-WD; Thu, 09 Jan 2025 06:03:44 -0500
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6d896be3992so5074176d6.1; 
 Thu, 09 Jan 2025 03:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736420621; x=1737025421; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+jbfKWQm44ZW9UXv7Bp3KvtiEYH98M3KGqFcwqP+na0=;
 b=au/1ib8Xkl3/OUbtiXO9sRV+cu1UNqgSNJeGwKhY7nbCCVUlwuIvI5NagOG7qbtQRk
 XY4V9xKkMGtdh1l1OUGcdhas2/ryVB3VqyS8EZKEa9F7sz5kyf7wZtDtINRgXZ1lImuZ
 tlDR+I3RU0Whf8Xf2k9mbiqe1JcB7pfSwO6MsjW2CVwnuTB168I99MQqjXMX6QHxciMQ
 aN7cmyifoteIUvvDGCeqxPxGE9LZV423zkp5S23mlKFNm5p6+rdcrSFpdV8WFd8L6Tan
 61i6VSU32UUvir0PGk+GV65f53BCFv9l7AOqmEjYIFMEzuREmixULe2utGKCM/qDiXGZ
 NqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736420621; x=1737025421;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+jbfKWQm44ZW9UXv7Bp3KvtiEYH98M3KGqFcwqP+na0=;
 b=od4/kMhrcRqaXau79T7hZ8RSrVOaxC/kzq2/I7MyNgPWGFcjkCxeapDfsy/8rRSuwi
 gC1qV0U9CLwOefE5844gjJZwLtyqY0OvKxITSIcp8y51JmtMVen/HRE1zZCNY3hXFhyh
 7uoPrKCcJajslqJfPuhaMUiDzuAX2YWnR0l0gSRlBbMa0T9Eql6pvodXJBOeUH22U8Tq
 bUKa3/pcYLZxJ8YzC5+xIS27AjSvM/wZwW7bJPOcWp2imW1TieB6C9KqVur3lvoVM+e7
 f/+NJzWi211MjQxTUiHJ6njDI3WRS/Io59eESAilyg/Q+1HBvV/LO8fxss/jTcraI1ZD
 q9Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCz0nCcIsR/eeWMc+hhurVQSfwwzfa1i5dT9c6VFEOKjM+L1hpL4rRZANdz6QgLH9Op6J+7nfvU3QJlA==@nongnu.org,
 AJvYcCVrLoFjKoBp75rzx5nKRFGKKTjvqEXbwW9aFylxGx0qhLbLE1ozroB4yNuRi0bVejM2unZJcQhgRgGQd5g=@nongnu.org,
 AJvYcCVxyXrhnit7CkEjpXMumXlodT+Ofd0nsnEt2NmN5MvReNbjRS1R9/vmo+JhE3rFI1jffuLg1T0m2LAp@nongnu.org
X-Gm-Message-State: AOJu0Yw5zgl5pjKV0dN231OKH70eRnw3pGvEoal8KLgk7Q+PhL5aTjwy
 YjLB99cXM4UGG0W2yBzedxLtLXAKTDLK15tXt5wOeBzW0eR5+spPy1tolZtHG9pVRMUimjEkZB4
 4CBgOtQ8MjiVFeIrELJMHfR5m/Hc=
X-Gm-Gg: ASbGncv3sLFJgnm1Xybj1cqkX4iRZBUsWUl+EaxyHHEEjBuFfzIyPXFE+Mot0TPkACF
 H2eQ0SjzX/0gf7/SQoDKQRJ/qttBMQhV8ZhQb
X-Google-Smtp-Source: AGHT+IHhdR01Roq58KpuZ4QEuZ593o7FFvVex6fx/dUXkWhxqgsMlnf0VLkfTnAIzDCA9u4XCtmJ3ADBSwxtIUl+pFM=
X-Received: by 2002:a05:6214:27cc:b0:6d8:9f61:de8c with SMTP id
 6a1803df08f44-6df9b24eaefmr2594516d6.27.1736420620792; Thu, 09 Jan 2025
 03:03:40 -0800 (PST)
MIME-Version: 1.0
References: <20250108124649.333668-1-f.ebner@proxmox.com>
 <Z3-pTUj66O2nfqc_@redhat.com>
 <CA+7p6PKEx552-wN_5ueq6E=mNTNYpGpUYgo3wGRM+fxbG=icyQ@mail.gmail.com>
 <CA+7p6P+hc7hYqfK1pLeN5y9ALEVM8HoioMvUK-45AboM5yDWuQ@mail.gmail.com>
 <CA+7p6PJwmpTsB3xS+6_ZSKM3ZqBwVv4cGTaRd_mMDWjKsQSLoA@mail.gmail.com>
In-Reply-To: <CA+7p6PJwmpTsB3xS+6_ZSKM3ZqBwVv4cGTaRd_mMDWjKsQSLoA@mail.gmail.com>
From: Daniel Wielandt <wielandtdan@gmail.com>
Date: Thu, 9 Jan 2025 05:03:29 -0600
X-Gm-Features: AbW1kvbosYd8eMdWBVAK6YLlWNuF4UQ_Mph6U_Rn8t7KADPOmdMkEErGY72vJgs
Message-ID: <CA+7p6PK3khtvuM7bMyRc0RthH0defrX9kKNEQBdf1Gp3AkjHPw@mail.gmail.com>
Subject: Re: [PATCH] block-backend: protect setting block root to NULL with
 block graph write lock
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, hreitz@redhat.com, qemu-block@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000487796062b43eeab"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=wielandtdan@gmail.com; helo=mail-qv1-xf35.google.com
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

--000000000000487796062b43eeab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

U just need someone whose .og personally invested to tell youwhay needs to
go. As a third party it'd obvious..remember the kernel and drivers ate not
the sibstricy..
Also kernel was written  for free but drivers use a very high overhead..so
which system deserves world domination.

None stupid it about the people not the crap we argue over at our nightjobs

On Thu, Jan 9, 2025, 4:59=E2=80=AFAM Daniel Wielandt <wielandtdan@gmail.com=
> wrote:

> We all know how the thing works and operates it does t take a genius to
> know what's working and what's not.. I mean. I.notsaying take out tge
> things that made us like to use it.. but I mean command should be
> understood logic should be what we use as a am
> Standard.. and trust me depending on where your at with structure and
> scripts the logic can even be ...codeing..
>
> On Thu, Jan 9, 2025, 4:55=E2=80=AFAM Daniel Wielandt <wielandtdan@gmail.c=
om>
> wrote:
>
>> I feel like your too focused on new problems when you  gave up repairing
>> to old os.. be ause at one time it was real slick.. now.theres parts tha=
t
>> are problems that can be eliminated easy and provide  a less bloated
>> function with simple code deletion.. fix the original is down its it's
>> primary parts
>> .then u can add your fancy automation and setting get real com0lucated
>>
>> On Thu, Jan 9, 2025, 4:52=E2=80=AFAM Daniel Wielandt <wielandtdan@gmail.=
com>
>> wrote:
>>
>>> Suggestions hold pattern.. programmers obviously understand control
>>> logic. Systems built with operational flaws. Will freeze up when u star=
t
>>> repairing it while it's running.
>>>
>>> On Thu, Jan 9, 2025, 4:48=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wrot=
e:
>>>
>>>> Am 08.01.2025 um 13:46 hat Fiona Ebner geschrieben:
>>>> > Setting blk->root is a graph change operation and thus needs to be
>>>> > protected by the block graph write lock in blk_remove_bs(). The
>>>> > assignment to blk->root in blk_insert_bs() is already protected by
>>>> > the block graph write lock.
>>>>
>>>> Hm, if that's the case, then we should also enforce this in the
>>>> declaration of BlockBackend:
>>>>
>>>>     BdrvChild * GRAPH_RDLOCK_PTR root;
>>>>
>>>> However, this results in more compiler failures that we need to fix. Y=
ou
>>>> caught the only remaining writer, but the lock is only fully effective
>>>> if all readers take it, too.
>>>>
>>>> > In particular, the graph read lock in blk_co_do_flush() could
>>>> > previously not ensure that blk_bs(blk) would always return the same
>>>> > value during the locked section, which could lead to a segfault [0] =
in
>>>> > combination with migration [1].
>>>> >
>>>> > From the user-provided backtraces in the forum thread [1], it seems
>>>> > like blk_co_do_flush() managed to get past the
>>>> > blk_co_is_available(blk) check, meaning that blk_bs(blk) returned a
>>>> > non-NULL value during the check, but then, when calling
>>>> > bdrv_co_flush(), blk_bs(blk) returned NULL.
>>>> >
>>>> > [0]:
>>>> >
>>>> > > 0  bdrv_primary_child (bs=3Dbs@entry=3D0x0) at ../block.c:8287
>>>> > > 1  bdrv_co_flush (bs=3D0x0) at ../block/io.c:2948
>>>> > > 2  bdrv_co_flush_entry (opaque=3D0x7a610affae90) at
>>>> block/block-gen.c:901
>>>> >
>>>> > [1]: https://forum.proxmox.com/threads/158072
>>>> >
>>>> > Cc: qemu-stable@nongnu.org
>>>> > Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
>>>> > ---
>>>> >  block/block-backend.c | 2 +-
>>>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>>>> >
>>>> > diff --git a/block/block-backend.c b/block/block-backend.c
>>>> > index c93a7525ad..9678615318 100644
>>>> > --- a/block/block-backend.c
>>>> > +++ b/block/block-backend.c
>>>> > @@ -887,9 +887,9 @@ void blk_remove_bs(BlockBackend *blk)
>>>> >       */
>>>> >      blk_drain(blk);
>>>> >      root =3D blk->root;
>>>> > -    blk->root =3D NULL;
>>>> >
>>>> >      bdrv_graph_wrlock();
>>>> > +    blk->root =3D NULL;
>>>> >      bdrv_root_unref_child(root);
>>>> >      bdrv_graph_wrunlock();
>>>> >  }
>>>>
>>>> I think the 'root =3D blk->root' needs to be inside the locked section=
,
>>>> too. Otherwise blk->root could change during bdrv_graph_wrlock() (whic=
h
>>>> has a nested event loop) and root would be stale. I assume clang would
>>>> complain about this with the added GRAPH_RDLOCK_PTR.
>>>>
>>>> Kevin
>>>>
>>>>
>>>>

--000000000000487796062b43eeab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">U just need someone whose .og personally invested to tell yo=
uwhay needs to go. As a third party it&#39;d obvious..remember the kernel a=
nd drivers ate not the sibstricy..<br>
 Also kernel was written=C2=A0 for free but drivers use a very high overhea=
d..so which system deserves world domination.</p>
<p dir=3D"ltr">None stupid it about the people not the crap we argue over a=
t our nightjobs</p>
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Jan 9, 2025, 4:59=E2=80=AFAM Daniel Wielandt &lt;<a=
 href=3D"mailto:wielandtdan@gmail.com">wielandtdan@gmail.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><p dir=3D"ltr">We all know how the=
 thing works and operates it does t take a genius to know what&#39;s workin=
g and what&#39;s not.. I mean. I.notsaying take out tge things that made us=
 like to use it.. but I mean command should be understood logic should be w=
hat we use as a am<br>
Standard.. and trust me depending on where your at with structure and scrip=
ts the logic can even be ...codeing..</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu=
, Jan 9, 2025, 4:55=E2=80=AFAM Daniel Wielandt &lt;<a href=3D"mailto:wielan=
dtdan@gmail.com" target=3D"_blank" rel=3D"noreferrer">wielandtdan@gmail.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><p dir=3D"ltr">I fe=
el like your too focused on new problems when you=C2=A0 gave up repairing t=
o old os.. be ause at one time it was real slick.. now.theres parts that ar=
e problems that can be eliminated easy and provide=C2=A0 a less bloated fun=
ction with simple code deletion.. fix the original is down its it&#39;s pri=
mary parts<br>
.then u can add your fancy automation and setting get real com0lucated</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu=
, Jan 9, 2025, 4:52=E2=80=AFAM Daniel Wielandt &lt;<a href=3D"mailto:wielan=
dtdan@gmail.com" rel=3D"noreferrer noreferrer" target=3D"_blank">wielandtda=
n@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><p dir=
=3D"ltr">Suggestions hold pattern.. programmers obviously understand contro=
l logic. Systems built with operational flaws. Will freeze up when u start =
repairing it while it&#39;s running.<br>
</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu=
, Jan 9, 2025, 4:48=E2=80=AFAM Kevin Wolf &lt;<a href=3D"mailto:kwolf@redha=
t.com" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">kwolf@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Am 08.01.202=
5 um 13:46 hat Fiona Ebner geschrieben:<br>
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
errer noreferrer noreferrer noreferrer noreferrer" target=3D"_blank">https:=
//forum.proxmox.com/threads/158072</a><br>
&gt; <br>
&gt; Cc: <a href=3D"mailto:qemu-stable@nongnu.org" rel=3D"noreferrer norefe=
rrer noreferrer noreferrer" target=3D"_blank">qemu-stable@nongnu.org</a><br=
>
&gt; Signed-off-by: Fiona Ebner &lt;<a href=3D"mailto:f.ebner@proxmox.com" =
rel=3D"noreferrer noreferrer noreferrer noreferrer" target=3D"_blank">f.ebn=
er@proxmox.com</a>&gt;<br>
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
</blockquote></div>

--000000000000487796062b43eeab--

