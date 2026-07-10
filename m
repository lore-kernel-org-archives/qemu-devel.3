Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3B5C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 01:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi09c-0004OG-QI; Thu, 09 Jul 2026 21:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wi09P-0004Nt-Mx
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 21:35:37 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wi09N-0006Aw-HK
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 21:35:35 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-51a868b6962so3329271cf.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 18:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783647332; cv=none;
 d=google.com; s=arc-20260327;
 b=k1F7p0HDEiPsQ8yaqr+4plJCzcxTBepU2qUn9ZNEqESy0lxWR7mVCdRdXtefZyLbxe
 wjhQOAItIz54BQYO4v7H/cIN1J187DKu3jfVjd6khX9ZYabp2bl3cBZ6Sawt54d7cM4e
 9IltR/7e3VdBSiYL68cTpzHBEHkt25S2dOBVI6nXKl92AQdKEndq5s/+ydNj5+t2gqTX
 9USCTcmhbBCSZbBlm0MP1TSFL+WytDPyvhcfoTyPH65i3KAasmrEbjiM1Y7xmU8Ic/AH
 X9WEQqvBmdtMtxGJshwnnVoP6df1yd0dTLLcQcKqWTHUxzjIir8QlrJ70raUXZpqsIsI
 H5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EdIctWCqJ1+QiJTyvdkc+1IsGOZH7utBpkweEL/hnV8=;
 fh=gMjfbdOkdsdyugoyuRb6DYWE7E1DjTHLX9jbWQ8ybu8=;
 b=n41lL5Q5S4BxPX8Ys2zHb8jrormhth67XI+ZvFUhEMtZ7HI+MiqMf2/5l1ykkmtEpC
 EBdhBIp+A113JH2lXwhskh82Zydni1nh6hpLqBUg87zWrenzkOIbdNht7mXzhpZvmhLj
 wlcxnCOgK2jAYX/t8wGM23eKeSh8BREXF55HY/n1Y6unddmqPYPXaSaIQqBohuywU7Lh
 WDWGxELlaCaOTSpN4Tymd57YfZaqXKn8jiyLKnLE1NGwvyefvK2eHzd68IiSZe9nFOPf
 s7VesrXXSSIGRwMqCnlz9MDhi7f52oEfaTPwW5q6BSwVsVk32qgBwd4XZ1taxossyWgf
 SkYA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783647332; x=1784252132; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EdIctWCqJ1+QiJTyvdkc+1IsGOZH7utBpkweEL/hnV8=;
 b=Pi9pL9mrqeoCv1GjUoskmM2uROfLqeYcfWAy00gmhvDrmhc69/ACg1Wd2oRLHy6dJT
 55NdUQ8L2e9liDkLzO+qtaIs4Ru44DKLnMu3yM2BgFXwXZ0tq9jr5VJy9/7QK2vi9BeM
 JUYbNiV0Vxfjv421XMCJbF2ocJm9Kqi+6DrMBuKnYr6HmWTns10Iczgeg9iFKnOoUJ+v
 HBQNQ/hUd/QVAqmfmLjNa1WKGdc1d0PoHgHnuAevqibXEWBTvcde+IMXFZ4bHZ11f6DZ
 XZqQXEahdkkrhq5alNuPQwwxyNrQrV44HpPEnLOdBmI0g0MtwfLMjL0lb47/IP1JdWNR
 l7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783647332; x=1784252132;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EdIctWCqJ1+QiJTyvdkc+1IsGOZH7utBpkweEL/hnV8=;
 b=KvkKcrB3/jpmdI6ueyXEtWuGS92QRwqmRznU8Fd4EIOFdIkUuM5hLlrwkBNs9OBCwd
 nY+e9hVMeQuely+eg1kkvuTM2PsKQDNBO0m4nXrSfxc6xEpqR+lywAzo2YKnhbLgh75E
 ejiOC7eJS4v4uDQ4Og2hF2O16bBmtYJ9kSgtR4dK9NzOmffZt3THgYUAQqllbRF+xr+H
 6ARICS/S+p+zNvID+1o4YTU2rxgw8M95UW+4rZ3258qzVq3bkmxkeAzSKffsGd1TJ9QN
 fPAidge5QHpEpQkJZ+mc5gErPgqcF1/wMcXLn+2HZjqnXMwhwHyDjS17pqsJckOcNUkl
 x9Dw==
X-Gm-Message-State: AOJu0YxdrbGlllpV4MtvIyRkRVVmg9Bea4hEZBVf/ejLhJ5zH5eA2xH6
 xbWOGyPCWi65XKund0mFK5lTsfcol0yA/NfpnFKS8GiIm3qXewlWcqRjWaRWwAT3q49UGH7/lZu
 RFJldjALMFUvNkEnHi956k2iRjF/RFLQ=
X-Gm-Gg: AfdE7cmUH0xpzGm4bCAyW1CHplgwv9xFAQmKFRLA53KLAxm7tS+mTdV+1mHlqrKBfca
 mFhSqqZQkVDxcbl2lxkP9HV3mRef2v6XesTvDhMxQyutZBXRcUVlBsZeM2n3UsLwtZ+jgqkIwlx
 i/QfMcfVYXkiQc/MOK7LNWJdPXBS+fYYw18XOp5TRPUHS6VTf5HxGXkOBXO6MoQ89OPIHYQ3Quv
 S2rWoDEswXPh0l+6IFPoH5yWMwgMQuJE9roAHwn7pDJN47e7Nj/EXrvE4ozjzNW0Tv9EZYTEAOy
 HhY+Ii4=
X-Received: by 2002:a05:622a:5809:b0:51c:7b11:419d with SMTP id
 d75a77b69052e-51c8b4c03eemr127258581cf.74.1783647331654; Thu, 09 Jul 2026
 18:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260709100529.41267-1-physicalmtea@gmail.com>
 <20260709084105-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260709084105-mutt-send-email-mst@kernel.org>
From: "m'te'a physical" <physicalmtea@gmail.com>
Date: Fri, 10 Jul 2026 09:34:54 +0800
X-Gm-Features: AVVi8CcM7GUxkHn_0qKkobyNiwfGgyLDC0zAeXYOh4sGis7bI4sb_zTljHuQpkA
Message-ID: <CAJwVaM+LE9BdOU=cMx0P7GmSuBpVEBQYANHxr0DsuB_UhhUCuw@mail.gmail.com>
Subject: Re: [PATCH] virtio: validate split queue head count before popping
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000009b9ffe065637c1aa"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=physicalmtea@gmail.com; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000009b9ffe065637c1aa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think virtio_queue_empty_rcu() is no longer needed after this change.

For this caller, the pieces it covered are either already handled elsewhere
or
kept explicitly in the split pop path.

The disabled-device check is already done by virtqueue_pop() before it call=
s
virtqueue_split_pop().

The empty-queue check is covered by virtqueue_num_heads(): rc =3D=3D 0 is t=
he
normal empty case, and rc < 0 is the invalid avail index distance case that
this
patch wants to reject.

The read barrier is also covered by virtqueue_num_heads(), since it does
smp_rmb() when it returns a positive head count, before the caller reads th=
e
avail ring entry with virtqueue_get_head().

The only old check that I think should stay explicit in
virtqueue_split_pop() is
!vq->vring.avail. virtqueue_num_heads() does not check that, and the old
behavior for an unconfigured split queue was to treat it as empty. So v2
keeps
that guard and replaces the rest of virtio_queue_empty_rcu() with
virtqueue_num_heads():

    RCU_READ_LOCK_GUARD();
    if (unlikely(!vq->vring.avail)) {
        goto done;
    }

    rc =3D virtqueue_num_heads(vq, vq->last_avail_idx);
    if (rc <=3D 0) {
        goto done;
    }

With that, virtio_queue_empty_rcu() has no remaining users and can be
removed.

If this looks right, I can send a v2 patch with this change.

Michael S. Tsirkin <mst@redhat.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=889=E6=97=
=A5=E5=91=A8=E5=9B=9B 20:43=E5=86=99=E9=81=93=EF=BC=9A

> On Thu, Jul 09, 2026 at 06:05:29PM +0800, Jia Jia wrote:
> > virtqueue_split_pop() reads the next split avail ring entry after
> > virtio_queue_empty_rcu() reports work. Call virtqueue_num_heads() befor=
e
> > consuming that entry, so an avail index distance larger than the queue
> > size is rejected.
> >
> > virtqueue_num_heads() also keeps the read barrier needed before the ava=
il
> > ring entry is read.
> >
> > This prevents an invalid split queue state from being expanded into
> > repeated device command processing.
> >
> > Link: https://gitlab.com/qemu-project/qemu/-/issues/3930
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> > Tested with qemu-system-x86_64 11.0.50, built from origin/master
> > f893c46c3931 plus this patch, configured with:
> >   --target-list=3Dx86_64-softmmu --enable-kvm --disable-tcg
> >
> > The original virtio-iommu live-vring qtest reproducer used for the
> > report completed successfully on the patched build without host OOM,
> > confirming that this reproducer is fixed by the patch.
> >
> >  hw/virtio/virtio.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index f4d86a3655..252bff8641 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -1751,9 +1751,11 @@ static void *virtqueue_split_pop(VirtQueue *vq,
> size_t sz)
> >      if (virtio_queue_empty_rcu(vq)) {
> >          goto done;
> >      }
> > -    /* Needed after virtio_queue_empty(), see comment in
> > -     * virtqueue_num_heads(). */
> > -    smp_rmb();
> > +
> > +    rc =3D virtqueue_num_heads(vq, vq->last_avail_idx);
> > +    if (rc <=3D 0) {
> > +        goto done;
> > +    }
>
>
> Do we still need virtio_queue_empty_rcu then? Why?
>
> >      /* When we start there are none of either input nor output. */
> >      out_num =3D in_num =3D elem_entries =3D 0;
> > --
> > 2.34.1
>
>

--0000000000009b9ffe065637c1aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I think virtio_queue_empty_rcu() is no longer needed after=
 this change.<br><br>For this caller, the pieces it covered are either alre=
ady handled elsewhere or<br>kept explicitly in the split pop path.<br><br>T=
he disabled-device check is already done by virtqueue_pop() before it calls=
<br>virtqueue_split_pop().<br><br>The empty-queue check is covered by virtq=
ueue_num_heads(): rc =3D=3D 0 is the<br>normal empty case, and rc &lt; 0 is=
 the invalid avail index distance case that this<br>patch wants to reject.<=
br><br>The read barrier is also covered by virtqueue_num_heads(), since it =
does<br>smp_rmb() when it returns a positive head count, before the caller =
reads the<br>avail ring entry with virtqueue_get_head().<br><br>The only ol=
d check that I think should stay explicit in virtqueue_split_pop() is<br>!v=
q-&gt;vring.avail. virtqueue_num_heads() does not check that, and the old<b=
r>behavior for an unconfigured split queue was to treat it as empty. So v2 =
keeps<br>that guard and replaces the rest of virtio_queue_empty_rcu() with<=
br>virtqueue_num_heads():<br><br>=C2=A0 =C2=A0 RCU_READ_LOCK_GUARD();<br>=
=C2=A0 =C2=A0 if (unlikely(!vq-&gt;vring.avail)) {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto done;<br>=C2=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 rc =3D virtqueue_=
num_heads(vq, vq-&gt;last_avail_idx);<br>=C2=A0 =C2=A0 if (rc &lt;=3D 0) {<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto done;<br>=C2=A0 =C2=A0 }<br><br>With th=
at, virtio_queue_empty_rcu() has no remaining users and can be removed.<br>=
<br>If this looks right, I can send a v2 patch with this change.</div><br><=
div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"g=
mail_attr">Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@red=
hat.com</a>&gt; =E4=BA=8E2026=E5=B9=B47=E6=9C=889=E6=97=A5=E5=91=A8=E5=9B=
=9B 20:43=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">On Thu, Jul 09, 2026 at 06:05:29PM +0800, Jia Jia wrot=
e:<br>
&gt; virtqueue_split_pop() reads the next split avail ring entry after<br>
&gt; virtio_queue_empty_rcu() reports work. Call virtqueue_num_heads() befo=
re<br>
&gt; consuming that entry, so an avail index distance larger than the queue=
<br>
&gt; size is rejected.<br>
&gt; <br>
&gt; virtqueue_num_heads() also keeps the read barrier needed before the av=
ail<br>
&gt; ring entry is read.<br>
&gt; <br>
&gt; This prevents an invalid split queue state from being expanded into<br=
>
&gt; repeated device command processing.<br>
&gt; <br>
&gt; Link: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/3930" r=
el=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/=
issues/3930</a><br>
&gt; Signed-off-by: Jia Jia &lt;<a href=3D"mailto:physicalmtea@gmail.com" t=
arget=3D"_blank">physicalmtea@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; Tested with qemu-system-x86_64 11.0.50, built from origin/master<br>
&gt; f893c46c3931 plus this patch, configured with:<br>
&gt;=C2=A0 =C2=A0--target-list=3Dx86_64-softmmu --enable-kvm --disable-tcg<=
br>
&gt; <br>
&gt; The original virtio-iommu live-vring qtest reproducer used for the<br>
&gt; report completed successfully on the patched build without host OOM,<b=
r>
&gt; confirming that this reproducer is fixed by the patch.<br>
&gt; <br>
&gt;=C2=A0 hw/virtio/virtio.c | 8 +++++---<br>
&gt;=C2=A0 1 file changed, 5 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c<br>
&gt; index f4d86a3655..252bff8641 100644<br>
&gt; --- a/hw/virtio/virtio.c<br>
&gt; +++ b/hw/virtio/virtio.c<br>
&gt; @@ -1751,9 +1751,11 @@ static void *virtqueue_split_pop(VirtQueue *vq,=
 size_t sz)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (virtio_queue_empty_rcu(vq)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto done;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 /* Needed after virtio_queue_empty(), see comment in<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0* virtqueue_num_heads(). */<br>
&gt; -=C2=A0 =C2=A0 smp_rmb();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 rc =3D virtqueue_num_heads(vq, vq-&gt;last_avail_idx);<=
br>
&gt; +=C2=A0 =C2=A0 if (rc &lt;=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto done;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
<br>
Do we still need virtio_queue_empty_rcu then? Why?<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* When we start there are none of either input no=
r output. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 out_num =3D in_num =3D elem_entries =3D 0;<br>
&gt; -- <br>
&gt; 2.34.1<br>
<br>
</blockquote></div>

--0000000000009b9ffe065637c1aa--

