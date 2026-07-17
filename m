Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C56FC4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkhlg-00015r-RF; Fri, 17 Jul 2026 08:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkhlf-00015T-1a
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:34:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkhlc-0000XI-Tc
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784291652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2qUN9KCPNvPeb/q+dpEjEzbh002POb/NdOo381n94iE=;
 b=PxE2hU7qlqVfM4IaSRKorMOkTwU7ZGgGx7tv8T0dpF9O94yc4/wQSHjqejSKY6OslAd6Vv
 XfnkEHDGqi1jKsIc4scbFJpYoFY7xKvP478lXZrZWWrt7cKIVMZIS/d3mRnlV3CpUOw3We
 W7W6xIdXe//+ERVvoLSktdRxsMC2IYI=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-goSA5mIIOwiln9l3tfbadw-1; Fri, 17 Jul 2026 08:34:09 -0400
X-MC-Unique: goSA5mIIOwiln9l3tfbadw-1
X-Mimecast-MFC-AGG-ID: goSA5mIIOwiln9l3tfbadw_1784291649
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-486055c1c6fso4590667b6e.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 05:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784291649; cv=none;
 d=google.com; s=arc-20260327;
 b=YSNvBFd0XWVodaqGzkIGeUOf58rp3rDMxCbNRlV/iFlvUp1xjtZqmTnvF04IESmVZl
 8jpXrrvPYE4QtRsPn0qoKC6aLSeyPeK57LOdsv7pNA5CnZePUO7oQUqHONPb1TbPQbLD
 ixUjksGMtOm/8fW1LNjZmDmSCE4qm9iP3U5PiTGQW5E1MIdbvco6k7yiHIPAJgIzNHcV
 i9karoeE3K+jdKToupfltSBzKJQfiaMWwihu27rQK3T4iqLCoAazmJ2UoW9w8enkuA8A
 ol42gBomM/YCVPGHArOEL8qzQGH0sxSltZ35M6R7YeFB8AR+Iy+GOiLaR2xCej0wxY+o
 J11w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2qUN9KCPNvPeb/q+dpEjEzbh002POb/NdOo381n94iE=;
 fh=yMT8b8T8ht6iWX7piMkmNLNvzSymuJt3sDznvSbJHMQ=;
 b=VEYkEshs5WYLcJfnMZuQfYaueRFml3nrM1lCB/3XUBGFpieTGUgHhcvZpTwIvnnLfr
 IrzUSfoZfG5qTPhUtz4HVA699DC3GK2genFpzBthn5vJ5AihoxzTBveukI9d4WU6z2k5
 RGe9Y/bLrhr835r5HLFJqnAMu8iAZUk5Fth2WooJQQ1JpUSkX9OrUstHE9Tj9k/qej4S
 FgjffcyueIjqqAVaJXIpcZjirsIquNeQTzRgTg13wfW5uwH0QxmBcefn84TK+RfHxUMh
 6UdwRWWtKUrSBGENhbKzr3HFI15OM72gWrGWcbt8QgAnVMn6GYzXAnE0+cTDylfkLQ+c
 IO7w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784291649; x=1784896449; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2qUN9KCPNvPeb/q+dpEjEzbh002POb/NdOo381n94iE=;
 b=fT7fmiHJkg88zZWtKHqIaiKeTV6zqYuNlYHLJOJYxIueCqaSinz9tajsYf5HnOKwCA
 R1F/NqxP5GwXBEJBDsRCfVEoNKkeFvtBduciwLnrOwTSDqY/B1s1xkQ+CxjIPD91oqSZ
 fFxq8ZpceOKrNdiWf9l7kdN6IxCwZ59urOUkkVoDv7DxgDFOW6MoB2FLWLLQnUTSHvC4
 0GR3MANvA1s8QmfXPSmUjw7ERCoj9F3TEFnlITB1+CwClqCNp2BJwVc9/A4utBiaZXtB
 T9nvH+kHPV97NEtXn3c9l5S+bYySshZFqRcQqKbA7FM9Ma8VXxPBN6Alts6WWoKKPWSY
 ZwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784291649; x=1784896449;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2qUN9KCPNvPeb/q+dpEjEzbh002POb/NdOo381n94iE=;
 b=jS0jTx1Z6v30l5CVhzuBe6HqPnK+7GuYi3ljW1iV+MYUmUxXiyftbPZx0Wa0vL/xwL
 0qIaDQL34GTNFsmmuz0wUtaozNsd3c9ve8n3LwG6okH98WHMxRltFTVE091PL28wAzmu
 Njv5JJKLPn9+QnH94xlM+CVLl/Ek8JCbVs2Zw37vxiNGWkgchbGG5ZX6wyUjQj54X0IA
 GVjQCf9B11dm0008Q+SL3UdDrlRzkusr2U2bcl/cBw7upjlwQ+F3SIJXRuEA2/tVffbe
 9cYiLU/vIwl8/0L5Hi4F/Hf2w95eBe+1UszU6Lk9qezsXkNnSgyVCABP1nXdjK6pULM1
 oCaQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUNnQ2JLJZ8zaIvPXsPJbqbG7YOxOc81UAT6CX+NSQRHf2DoSiz/DbsAnz0YtHah+zZd1T9qzODces@nongnu.org
X-Gm-Message-State: AOJu0YwEnBIIHMk0+Gyi0yrsXFiNwYuAWfrnOXoLP7cjieSIDSeHbD4y
 AT6Bb9sv5TqCBnYvNGzgzFsN36fjdBpow9oyMNT+vMl+EHHY/ZzGnvOo2Qy8Pnbt8mMMcgztrKa
 9po2IDPo/4L5KfeAkp4UlYt9QswJQyLsY1nrlcwwh3gvilKZRo4nXgxrfmPEZtV64QXTiYDo6hn
 q5EhMJp/LdtgD8VgNOoLjCvKKSW0203ls=
X-Gm-Gg: AfdE7ckw9FlKiwApAXC6GJ5myjkMeEK9JP71K9Mm//qQXIk45CTLwSHAfT108guiJ/t
 vaEyCk8XvssAegVSMr3QNAkQ0H1BAGwid0kjt9hvitj9EWYukjgwJp9o4diEeQ6/vUEO9edoofR
 kyychzhjfvqYJvJABdloimL3Kf7ap+PGzX+4atxlVqclQpLmlFXtc1rwuymDM2Yq/04MJSCcpIE
 4rXmxi57VugazVRe9GUszvimBEcuFqQibl6kB79GYqWXw==
X-Received: by 2002:a05:6808:13ca:b0:497:e0bc:afe2 with SMTP id
 5614622812f47-4a4d03063f2mr966520b6e.4.1784291649035; 
 Fri, 17 Jul 2026 05:34:09 -0700 (PDT)
X-Received: by 2002:a05:6808:13ca:b0:497:e0bc:afe2 with SMTP id
 5614622812f47-4a4d03063f2mr966501b6e.4.1784291648536; Fri, 17 Jul 2026
 05:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260717103301.228974-1-dbassey@redhat.com>
 <20260717103301.228974-2-dbassey@redhat.com>
 <20260717063641-mutt-send-email-mst@kernel.org>
 <CADSE00+Uoy=fu3OnvMCr0Cn=tHSj27LkD9y7_CPqT32oSaDFow@mail.gmail.com>
In-Reply-To: <CADSE00+Uoy=fu3OnvMCr0Cn=tHSj27LkD9y7_CPqT32oSaDFow@mail.gmail.com>
From: Dorinda Bassey <dbassey@redhat.com>
Date: Fri, 17 Jul 2026 14:33:56 +0200
X-Gm-Features: AUfX_mztrW3g0GrNg_P1X1ZjfLgnm1MtnIHlB-0Hcgs4I9Ik9e1op4jgx_LAWZs
Message-ID: <CACzuRyzBab+XdnQVkv1CSLx_36huJn+_u=pyp1POpgYm-KgFUQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] vhost: Fix SHMEM_MAP transaction ordering and
 resulting deadlock
To: Albert Esteve <aesteve@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 mhrica@redhat.com, sgarzare@redhat.com, manos.pitsidianakis@linaro.org, 
 marcandre.lureau@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Content-Type: multipart/alternative; boundary="000000000000e32a2a0656cdc5bd"
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=dbassey@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000e32a2a0656cdc5bd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good point, will move virtio_del_shmem_map() before the reply in the next
version.

On Fri, Jul 17, 2026 at 1:50=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:

> On Fri, Jul 17, 2026 at 12:37=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om>
> wrote:
> >
> > On Fri, Jul 17, 2026 at 12:32:59PM +0200, Dorinda Bassey wrote:
> > > Commit the memory region transaction before sending the SHMEM_MAP rep=
ly
> > > so the KVM memory slot exists before the guest can access the mapped
> > > region.
> > >
> > > This moves the commit to while the backend is still blocked waiting f=
or
> > > the reply, which can trigger ADD_MEM_REG back to the backend and
> > > deadlock. Filter shmem mapping regions out of vhost_section() by
> > > checking the MR owner type to prevent this.
> > >
> > > The explicit transaction begin/commit wrapping is dropped since
> > > virtio_add_shmem_map() already commits via
> memory_region_add_subregion().
> > >
> > > Fixes: b52e1896e764 ("vhost-user: Add VirtIO Shared Memory map
> request")
> > > Suggested-by: Albert Esteve <aesteve@redhat.com>
> > > Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> > > ---
> > >  hw/virtio/vhost-user.c | 20 ++------------------
> > >  hw/virtio/vhost.c      | 10 ++++++++++
> > >  2 files changed, 12 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > index 517cc4ca716..01468f7441a 100644
> > > --- a/hw/virtio/vhost-user.c
> > > +++ b/hw/virtio/vhost-user.c
> > > @@ -1977,8 +1977,6 @@ vhost_user_backend_handle_shmem_map(struct
> vhost_dev *dev,
> > >          }
> > >      }
> > >
> > > -    memory_region_transaction_begin();
> > > -
> > >      /* Create VirtioSharedMemoryMapping object */
> > >      VirtioSharedMemoryMapping *mapping =3D
> virtio_shared_memory_mapping_new(
> > >          vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
> > > @@ -1986,7 +1984,7 @@ vhost_user_backend_handle_shmem_map(struct
> vhost_dev *dev,
> > >
> > >      if (!mapping) {
> > >          ret =3D -EFAULT;
> > > -        goto send_reply_commit;
> > > +        goto send_reply;
> > >      }
> > >
> > >      /* Add the mapping to the shared memory region */
> > > @@ -1994,22 +1992,8 @@ vhost_user_backend_handle_shmem_map(struct
> vhost_dev *dev,
> > >          error_report("Failed to add shared memory mapping");
> > >          object_unref(OBJECT(mapping));
> > >          ret =3D -EFAULT;
> > > -        goto send_reply_commit;
> > > -    }
> > > -
> > > -send_reply_commit:
> > > -    /* Send reply and commit after transaction started */
> > > -    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > > -        payload->u64 =3D !!ret;
> > > -        hdr->size =3D sizeof(payload->u64);
> > > -        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
> > > -            error_report_err(local_err);
> > > -            memory_region_transaction_commit();
> > > -            return -EFAULT;
> > > -        }
> > > +        goto send_reply;
> > >      }
> > > -    memory_region_transaction_commit();
> > > -    return 0;
> > >
> > >  send_reply:
> > >      if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > index af41841b529..e5c219be095 100644
> > > --- a/hw/virtio/vhost.c
> > > +++ b/hw/virtio/vhost.c
> > > @@ -636,6 +636,16 @@ static bool vhost_section(struct vhost_dev *dev,
> MemoryRegionSection *section)
> > >  {
> > >      MemoryRegion *mr =3D section->mr;
> > >
> > > +    /*
> > > +     * Skip shmem mapping regions, they are managed via
> SHMEM_MAP/UNMAP.
> > > +     * Including them triggers ADD_MEM_REG during the SHMEM_MAP
> transaction
> > > +     * commit, deadlocking the backend.
> > > +     */
> > > +    if (object_dynamic_cast(memory_region_owner(mr),
> > > +                            TYPE_VIRTIO_SHARED_MEMORY_MAPPING)) {
> > > +        return false;
> > > +    }
> > > +
> > >      if (memory_region_is_ram(mr) && !memory_region_is_rom(mr)) {
> > >          uint8_t dirty_mask =3D memory_region_get_dirty_log_mask(mr);
> > >          uint8_t handled_dirty;
> >
> >
> > This all seems risky i have to say.  Is this always map never unmap?
>
> The filter covers both, and this is a good point. For symmetry the
> handle_shmem_unmap() should call virtio_del_shmem_map() before
> replying.
>
> BR,
> Albert.
>
> >
> > > --
> > > 2.52.0
> >
>
>

--000000000000e32a2a0656cdc5bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Good point, will move virtio_del_shmem_map() before t=
he reply in the next version.</div></div><br><div class=3D"gmail_quote gmai=
l_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 17, 20=
26 at 1:50=E2=80=AFPM Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.co=
m">aesteve@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">On Fri, Jul 17, 2026 at 12:37=E2=80=AFPM Michael S. Ts=
irkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.co=
m</a>&gt; wrote:<br>
&gt;<br>
&gt; On Fri, Jul 17, 2026 at 12:32:59PM +0200, Dorinda Bassey wrote:<br>
&gt; &gt; Commit the memory region transaction before sending the SHMEM_MAP=
 reply<br>
&gt; &gt; so the KVM memory slot exists before the guest can access the map=
ped<br>
&gt; &gt; region.<br>
&gt; &gt;<br>
&gt; &gt; This moves the commit to while the backend is still blocked waiti=
ng for<br>
&gt; &gt; the reply, which can trigger ADD_MEM_REG back to the backend and<=
br>
&gt; &gt; deadlock. Filter shmem mapping regions out of vhost_section() by<=
br>
&gt; &gt; checking the MR owner type to prevent this.<br>
&gt; &gt;<br>
&gt; &gt; The explicit transaction begin/commit wrapping is dropped since<b=
r>
&gt; &gt; virtio_add_shmem_map() already commits via memory_region_add_subr=
egion().<br>
&gt; &gt;<br>
&gt; &gt; Fixes: b52e1896e764 (&quot;vhost-user: Add VirtIO Shared Memory m=
ap request&quot;)<br>
&gt; &gt; Suggested-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.=
com" target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; &gt; Signed-off-by: Dorinda Bassey &lt;<a href=3D"mailto:dbassey@redha=
t.com" target=3D"_blank">dbassey@redhat.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 hw/virtio/vhost-user.c | 20 ++------------------<br>
&gt; &gt;=C2=A0 hw/virtio/vhost.c=C2=A0 =C2=A0 =C2=A0 | 10 ++++++++++<br>
&gt; &gt;=C2=A0 2 files changed, 12 insertions(+), 18 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
&gt; &gt; index 517cc4ca716..01468f7441a 100644<br>
&gt; &gt; --- a/hw/virtio/vhost-user.c<br>
&gt; &gt; +++ b/hw/virtio/vhost-user.c<br>
&gt; &gt; @@ -1977,8 +1977,6 @@ vhost_user_backend_handle_shmem_map(struct =
vhost_dev *dev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 memory_region_transaction_begin();<br>
&gt; &gt; -<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* Create VirtioSharedMemoryMapping object */=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 VirtioSharedMemoryMapping *mapping =3D virtio=
_shared_memory_mapping_new(<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_mmap-&gt;shmid, fd, vu_mmap-=
&gt;fd_offset, vu_mmap-&gt;shm_offset,<br>
&gt; &gt; @@ -1986,7 +1984,7 @@ vhost_user_backend_handle_shmem_map(struct =
vhost_dev *dev,<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (!mapping) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EFAULT;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto send_reply_commit;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto send_reply;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* Add the mapping to the shared memory regio=
n */<br>
&gt; &gt; @@ -1994,22 +1992,8 @@ vhost_user_backend_handle_shmem_map(struct=
 vhost_dev *dev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to ad=
d shared memory mapping&quot;);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_unref(OBJECT(mapping));<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EFAULT;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto send_reply_commit;<br>
&gt; &gt; -=C2=A0 =C2=A0 }<br>
&gt; &gt; -<br>
&gt; &gt; -send_reply_commit:<br>
&gt; &gt; -=C2=A0 =C2=A0 /* Send reply and commit after transaction started=
 */<br>
&gt; &gt; -=C2=A0 =C2=A0 if (hdr-&gt;flags &amp; VHOST_USER_NEED_REPLY_MASK=
) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 payload-&gt;u64 =3D !!ret;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;size =3D sizeof(payload-&gt;=
u64);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!vhost_user_send_resp(ioc, hdr, =
payload, &amp;local_err)) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local=
_err);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_transact=
ion_commit();<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto send_reply;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; -=C2=A0 =C2=A0 memory_region_transaction_commit();<br>
&gt; &gt; -=C2=A0 =C2=A0 return 0;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 send_reply:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (hdr-&gt;flags &amp; VHOST_USER_NEED_REPLY=
_MASK) {<br>
&gt; &gt; diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c<br>
&gt; &gt; index af41841b529..e5c219be095 100644<br>
&gt; &gt; --- a/hw/virtio/vhost.c<br>
&gt; &gt; +++ b/hw/virtio/vhost.c<br>
&gt; &gt; @@ -636,6 +636,16 @@ static bool vhost_section(struct vhost_dev *=
dev, MemoryRegionSection *section)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 MemoryRegion *mr =3D section-&gt;mr;<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* Skip shmem mapping regions, they are manag=
ed via SHMEM_MAP/UNMAP.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* Including them triggers ADD_MEM_REG during=
 the SHMEM_MAP transaction<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* commit, deadlocking the backend.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; +=C2=A0 =C2=A0 if (object_dynamic_cast(memory_region_owner(mr),<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_VIRTIO_SHARED_MEMORY_MAPPING)) {<br=
>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (memory_region_is_ram(mr) &amp;&amp; !memo=
ry_region_is_rom(mr)) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t dirty_mask =3D memory_r=
egion_get_dirty_log_mask(mr);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t handled_dirty;<br>
&gt;<br>
&gt;<br>
&gt; This all seems risky i have to say.=C2=A0 Is this always map never unm=
ap?<br>
<br>
The filter covers both, and this is a good point. For symmetry the<br>
handle_shmem_unmap() should call virtio_del_shmem_map() before<br>
replying.<br>
<br>
BR,<br>
Albert.<br>
<br>
&gt;<br>
&gt; &gt; --<br>
&gt; &gt; 2.52.0<br>
&gt;<br>
<br>
</blockquote></div>

--000000000000e32a2a0656cdc5bd--


