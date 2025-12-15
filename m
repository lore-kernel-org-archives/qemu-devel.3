Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6066AD5B85E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 17:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVCjj-0001LW-Ra; Mon, 15 Dec 2025 12:51:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcmorcos@google.com>)
 id 1vVCjW-0001Je-9e
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:51:47 -0500
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcmorcos@google.com>)
 id 1vVCjU-0006Ok-KI
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:51:42 -0500
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-55b09f54e98so1138252e0c.1
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 09:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765821100; x=1766425900; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AEofe3U+vR5Wl6ecYWnKxvsGdbshodOGyoNvx5+ZkBE=;
 b=F97SrIxfH7Gs74zl9ojJc/hbXh0C92ulP7Jls1yRteiKZflaCxdoD8jUdmP2AGTvkJ
 Ck5TEL1f7GqCxHuT2PmR83rFRzzF7FxxwbnVTfUB631zJQKjH5bUqKVsqMtWIbAMzdFz
 JsSqc/OrFgiHkI5zdCV/6ROAap5z0jNiWAkyfIN0HTMSfIhoWYvVxRqQsgPvlPXiS96T
 mBzjxMvhks3/nKaEa73LcfrRxC6SDMbv3b6RVU/g/XZd1Ex9SnaTrMHzuD3d1trUlnxe
 gBULHGd0US5CcUh3QtmlWuPBT71W1u6EhEyGw+0f8IX1F41yYCgsj1OKX+R/V0uFfnxp
 ovQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765821100; x=1766425900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AEofe3U+vR5Wl6ecYWnKxvsGdbshodOGyoNvx5+ZkBE=;
 b=vQAsmF9v/E+GfHLJgxIj22zACIOYTR2UvHw8jYV9PhC/m/CQWVYnmHLoTTCzn6T24K
 b4sRMjptU4R3PIXpMPU+L8y5MjhyGjJP6f6ZmcBkxWh46FBwkHDjng38PuhZhswTaJgC
 pVkbNja33xjqH0mQpkYPdHFp9Il71Ysn2mEJ3B11CtoQXzEfIyLfYQrBctDGdO6RpD6G
 H4kLTDkuiCCwFV2Up9B8L1tGlHdMhO8lxUPR4Y47Oke3PaSR6YgeVhJZnkTapjqzBv+n
 zTEG2mKPIeprt0wlO+kkyrs8EUSiEiiJibsy0PT0ySeBkk6euapKkEKEORxk/7OrG3x5
 uJHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWirk5exboEqWUv5eBVLyXSCmvwug27RWqf3KZ1+kGzzT8OO2bE0rq4cwKqpLk9THU9QrsFqdHlCO/C@nongnu.org
X-Gm-Message-State: AOJu0YxI2DtE36WmseecMBR0MnDrlZyMBF/kNQ0zGfKxOA/iH+B6z+q2
 LOibkh0bPQjvA9E+HR2Vz6PCsIgeOGwmAwmzSJaTmp8CHFNgmjdrhpHpas22e7L++8FhDtcOdld
 CgoXw8WKIk0h7fsMu6m4kSP86yc6cfTT3MCJ/eBX6
X-Gm-Gg: AY/fxX4rvYin2pnUV0InG2soZAEt7+dwf/B9YcNwVdUWCN4QS7SMtqiK2F9g0ozIowD
 r2jzYapMva3oM9M8jJEnhvF5OtoharwYrIAIqZHBq30dkmMII//NBAgFcF9YmBlk8Ez73OfnwN+
 USiEPfJ4TPVkSfoWcjuUg5p7+uIE/g0AMuu6HMYBp0ZOxXMEBnsHjP3pwv2xwQSnImgUzHY3CiC
 MUjFLXksUQJP2TPnaIFTd5+YyceOT5FuHDQl6/60HmFR9ZfxGTo2/Mt+rt4ffWrznVcf1xVdATs
 vjNm50/fIgUBPUC6NZztn5ZgczyDFA1pGA==
X-Google-Smtp-Source: AGHT+IGhvvgJYBzbewqwYS0dt0pvl6YvEeEbI1fyi7wyfpcFFQVSUSf+FqGYpHFDOAWjTlZJnZR0xKUHdgMTNDhUW4g=
X-Received: by 2002:a05:6122:310a:b0:559:ef6b:1efb with SMTP id
 71dfb90a1353d-55fed62bfabmr3984534e0c.11.1765821099379; Mon, 15 Dec 2025
 09:51:39 -0800 (PST)
MIME-Version: 1.0
References: <20251213001443.2041258-1-marcmorcos@google.com>
 <20251213001443.2041258-3-marcmorcos@google.com>
 <159ced33-46e4-4b86-85e7-eda01406f768@redhat.com>
In-Reply-To: <159ced33-46e4-4b86-85e7-eda01406f768@redhat.com>
From: Marc Morcos <marcmorcos@google.com>
Date: Mon, 15 Dec 2025 09:51:30 -0800
X-Gm-Features: AQt7F2qzOJJ91zfx4CTNMV6CXrlJTNseiRzfLuw9_1STeyubPu99KVrx2t2nszI
Message-ID: <CACKn2CyOtxr_KiH8T+7D6CMtDqKcTqL2kBVMBbEQzdZJuQYvnw@mail.gmail.com>
Subject: Re: [PATCH 2/4] thread-pool: Fix thread race
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000005e59830646014370"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=marcmorcos@google.com; helo=mail-vk1-xa34.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--0000000000005e59830646014370
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sounds good, thanks!

On Mon, Dec 15, 2025, 6:43=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> w=
rote:

> On 12/13/25 01:14, Marc Morcos wrote:
> >
> >           req->ret =3D ret;
>
> Better use qatomic_set here---will fix it myself, thanks!
>
> Paolo
>
> > -        /* Write ret before state.  */
> > -        smp_wmb();
> > -        req->state =3D THREAD_DONE;
> > +        /* _release to write ret before state.  */
> > +        qatomic_store_release(&req->state, THREAD_DONE);
> >
> >           qemu_bh_schedule(pool->completion_bh);
> >           qemu_mutex_lock(&pool->lock);
> > @@ -180,7 +184,8 @@ static void thread_pool_completion_bh(void *opaque)
> >
> >   restart:
> >       QLIST_FOREACH_SAFE(elem, &pool->head, all, next) {
> > -        if (elem->state !=3D THREAD_DONE) {
> > +        /* _acquire to read state before ret.  */
> > +        if (qatomic_load_acquire(&elem->state) !=3D THREAD_DONE) {
> >               continue;
> >           }
> >
> > @@ -189,9 +194,6 @@ restart:
> >           QLIST_REMOVE(elem, all);
> >
> >           if (elem->common.cb) {
> > -            /* Read state before ret.  */
> > -            smp_rmb();
> > -
> >               /* Schedule ourselves in case elem->common.cb() calls
> aio_poll() to
> >                * wait for another request that completed at the same
> time.
> >                */
> > @@ -223,12 +225,12 @@ static void thread_pool_cancel(BlockAIOCB *acb)
> >       trace_thread_pool_cancel_aio(elem, elem->common.opaque);
> >
> >       QEMU_LOCK_GUARD(&pool->lock);
> > -    if (elem->state =3D=3D THREAD_QUEUED) {
> > +    if (qatomic_read(&elem->state) =3D=3D THREAD_QUEUED) {
> >           QTAILQ_REMOVE(&pool->request_list, elem, reqs);
> >           qemu_bh_schedule(pool->completion_bh);
> >
> > -        elem->state =3D THREAD_DONE;
> > -        elem->ret =3D -ECANCELED;
> > +        qatomic_set(&elem->ret, -ECANCELED);
> > +        qatomic_store_release(&elem->state, THREAD_DONE);
> >       }
> >
> >   }
>
>

--0000000000005e59830646014370
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Sounds good, thanks!</div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 15,=
 2025, 6:43=E2=80=AFAM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.=
com">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">On 12/13/25 01:14, Marc Morcos wrote:<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0req-&gt;ret =3D ret;<br>
<br>
Better use qatomic_set here---will fix it myself, thanks!<br>
<br>
Paolo<br>
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Write ret before state.=C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 smp_wmb();<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 req-&gt;state =3D THREAD_DONE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* _release to write ret before state.=C2=
=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qatomic_store_release(&amp;req-&gt;state,=
 THREAD_DONE);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_bh_schedule(pool-&gt;comp=
letion_bh);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_lock(&amp;pool-&gt;=
lock);<br>
&gt; @@ -180,7 +184,8 @@ static void thread_pool_completion_bh(void *opaque=
)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0restart:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0QLIST_FOREACH_SAFE(elem, &amp;pool-&gt;head,=
 all, next) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (elem-&gt;state !=3D THREAD_DONE) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* _acquire to read state before ret.=C2=
=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qatomic_load_acquire(&amp;elem-&gt;st=
ate) !=3D THREAD_DONE) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -189,9 +194,6 @@ restart:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QLIST_REMOVE(elem, all);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (elem-&gt;common.cb) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Read state before ret.=
=C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smp_rmb();<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Schedule ours=
elves in case elem-&gt;common.cb() calls aio_poll() to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * wait for anot=
her request that completed at the same time.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; @@ -223,12 +225,12 @@ static void thread_pool_cancel(BlockAIOCB *acb)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_thread_pool_cancel_aio(elem, elem-&gt;=
common.opaque);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0QEMU_LOCK_GUARD(&amp;pool-&gt;lock);<br>
&gt; -=C2=A0 =C2=A0 if (elem-&gt;state =3D=3D THREAD_QUEUED) {<br>
&gt; +=C2=A0 =C2=A0 if (qatomic_read(&amp;elem-&gt;state) =3D=3D THREAD_QUE=
UED) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QTAILQ_REMOVE(&amp;pool-&gt;re=
quest_list, elem, reqs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_bh_schedule(pool-&gt;comp=
letion_bh);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 elem-&gt;state =3D THREAD_DONE;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 elem-&gt;ret =3D -ECANCELED;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qatomic_set(&amp;elem-&gt;ret, -ECANCELED=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qatomic_store_release(&amp;elem-&gt;state=
, THREAD_DONE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0}<br>
<br>
</blockquote></div>

--0000000000005e59830646014370--

