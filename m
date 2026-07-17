Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78827C4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkjvK-0008GW-O9; Fri, 17 Jul 2026 10:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkjvI-0008GL-Sq
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:52:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkjvG-0002I5-BV
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784299937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tVkJEHLLkjeQjeGs5Y0oW4EBCciNzF3Y214Q4TgtBts=;
 b=GayIK7U2bmHOF33UsydFG0lK55ThKB8gIs6s3irBcwi2HTrWayL7d9vltsFQJmmPRonjER
 fdyNVo8KFofE6G1Qbu0vvxYm+yVFmmmn0xkWx23gkfjjdb7iulc3HVvKT8bJJlQQwn0O5l
 +AtJZ9oITS00T/roY7aTfxNWmIe3UZc=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-vgswWmzENiqbfKwePgtYfQ-1; Fri, 17 Jul 2026 10:52:15 -0400
X-MC-Unique: vgswWmzENiqbfKwePgtYfQ-1
X-Mimecast-MFC-AGG-ID: vgswWmzENiqbfKwePgtYfQ_1784299935
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4a41f46d629so6784196b6e.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 07:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784299935; cv=none;
 d=google.com; s=arc-20260327;
 b=cafF8AFxKztXT1KnaEh7SOnC2cRjYfn39U3zerF+8ZAcpDnPEIbn5t92FDoYzYsbU2
 d3xNNd2fmaJTWWTC1QcGJ9Bs+2Zd06MO2QxzVqvY8D9Jc8e2HWNls00hCCqHoq4povd5
 4KSjed7zxin4CMN65yUQxaJ2DAQ4QRq59ITFZwDrXv1KrvDTCAVXUboaR+P0PqkEFH12
 KlrCpvIDvUMCx4hqWCj09Wcw+XtH6IE9aBXg8Y9XLk75gu8Z/0cx/GmGdCW1dFwGkevn
 o7rekzPiNCyNXfqnukaaCzB+UuXyz2DehkvMiGveVsF2RsutE0WpvdGA8Jfq64eL3zGz
 FxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tVkJEHLLkjeQjeGs5Y0oW4EBCciNzF3Y214Q4TgtBts=;
 fh=R1VrqclvkLCnd3GYDD8ADqjObXIeANPJzeCYtIZN6kk=;
 b=drHxWuiOSs2tzyoMKLhVClg2GP/Kg6EJ7GfhnW1wU+YRkM/wfzHv2T0XKTFunYqt9b
 hT/vkfOomDGL+dgRoKlKA7r8vmppnnvuK9yLumVr668clz5j7q5d4OdIEbmaTnGQNzJI
 hM2fpoFjp8y+xzChUU4onFdRwOzIto1g5OKY1xR8FgH7XI1GfHkvt+/aQ9VgKBb0R3Lb
 aTnw9fFKCem3KZxvoE6MXIv5ibfyB6ysQgwW0FOSc4XVuxThhufUesPAbA0r1oGZ8fYJ
 KQR7r8c8X63TZSrspq+LDjjqroIufKtkvlC4SitiXO1wGPgmQfgT+Ig2W40QyqvBT1P6
 rQEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784299935; x=1784904735; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tVkJEHLLkjeQjeGs5Y0oW4EBCciNzF3Y214Q4TgtBts=;
 b=FhmXWBW5348j1s4LNF/XHCgp486w502sVbcwTeRe6PJk3qNyFm7jRIQyM1u8mXx8Xy
 FmFi5W4Tfygkx+0QRs4/avY7j3enTs4IxN/PA+GNf0irJVvTKD10VkRR2sVDwZC21AB0
 eiEg8A+wfbvBK0uoj+/wwF3jIMbnL04CVwSrK7Y2bwgiIfRe7QFJVBCK71EueCKQQ3kn
 azdlIdtnmprOo9Bx1qFNmDNlg9SGdBcIF4aIsoa4D1iFTT45BmDrW14Y431iAevtLsJu
 714dgT8OshyLd+YypCvgDh/qpS3quB1Zft1KuJo1Y4gl94LYXl8nA0aEkABXQHSkE1+0
 pBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784299935; x=1784904735;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tVkJEHLLkjeQjeGs5Y0oW4EBCciNzF3Y214Q4TgtBts=;
 b=OFp7sleazCVk3sQ/ZfLniymozGQTEiXeTfsEpopn9gTz5gK5t55sAxZu/ddbmXMQCP
 N+eUeE7QJStejcS3kNaNbb0WiRd/XdPDzgIBqzbErcVfrxJlM9Tc4qUqrc/rrXk59Xs7
 0rSIeAhfyRom7E8Ak/wrgHYeO10LGulTwvBf3+Y2z3nDLl8B4XzRz+RBzdXCRkHxMx8Y
 Vi8vq3TC2bnP5wF4GDC9WTRK2nxIq/JtY4Xhjc9mQwEaAvRwpxg9RXR7ScSJyXLqiSXT
 UXL2JQuguH7uyrh1wra0ZcRSvSlFR/yykhuEj0noTA0wKZkrqa343YzeZOq5eHGXvVvE
 aHgA==
X-Gm-Message-State: AOJu0Yz0SjwepIhDExrQl1/S83FG4zC5PwQHpaLUB0wrQAbDr9uYAsXM
 ECtNzz5qpG4jJ5/9NIBafnHLDS56rtn7AO8S61Zit0wUmDiowhSYDOj/vK7PbMolPdMqwIQMNuM
 6O5Z/ILQkOFBFzAdxbHEboDk5NBHhYUy8k7FztoScfs1CVPAYVLCzq9LTsqrqxbZ2Y2+ACxglpS
 6gm7xE82CSedeRYHi/j0IpX0DHiu8gm2E=
X-Gm-Gg: AfdE7cmO3T6FAXo4eqPR0nqBntyb/KNALkgtx28kSvvVa2J44o4ry5k7Xb8Fgz7uGVn
 msPCg43hyrrhjKpdIoHzypU38+x4+tf9o6cbOfLiBI85aLvjbdSEIjWJPistwdc7Rz8+EBraMJc
 m1ETIVneoRHOCzJTKo3Z/M11pBBaIwHk0dJFMkE4qySPLdceEPAE3ymuH2p27FwH9sVrg0KNT/q
 vlkXw8oneq+3ExBiozRB7oIic+3j7yE7gNJQ/lj/8w7yA==
X-Received: by 2002:a05:6808:309f:b0:4a4:12c4:9c16 with SMTP id
 5614622812f47-4a4d03219e4mr1824050b6e.7.1784299934771; 
 Fri, 17 Jul 2026 07:52:14 -0700 (PDT)
X-Received: by 2002:a05:6808:309f:b0:4a4:12c4:9c16 with SMTP id
 5614622812f47-4a4d03219e4mr1824018b6e.7.1784299934320; Fri, 17 Jul 2026
 07:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260717134920.265128-1-dbassey@redhat.com>
 <20260717134920.265128-2-dbassey@redhat.com>
 <CADSE00+LZO1+CcFcWeLX8qLWjoy43zqcPBiaN8u8bn_YP-Zuug@mail.gmail.com>
In-Reply-To: <CADSE00+LZO1+CcFcWeLX8qLWjoy43zqcPBiaN8u8bn_YP-Zuug@mail.gmail.com>
From: Dorinda Bassey <dbassey@redhat.com>
Date: Fri, 17 Jul 2026 16:52:03 +0200
X-Gm-Features: AUfX_mx8SZ0UUAfuBB6VqdptMGYwTpTMdUFRE9YUaYrk2aVoZHzQSOlTvEdmON4
Message-ID: <CACzuRywfAXb4osx3Q_v=ssy0BhGd8FNcm6sV2C-VuZMyHZpccQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] vhost: Fix SHMEM_MAP transaction ordering and
 resulting deadlock
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, mhrica@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, manos.pitsidianakis@linaro.org, 
 marcandre.lureau@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Content-Type: multipart/alternative; boundary="000000000000c226e00656cfb334"
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

--000000000000c226e00656cfb334
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sounds good, I'll look into that as a follow up.

Br,
Dorinda.

On Fri, Jul 17, 2026 at 4:25=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:

> On Fri, Jul 17, 2026 at 3:49=E2=80=AFPM Dorinda Bassey <dbassey@redhat.co=
m> wrote:
> >
> > Commit the memory region transaction before sending the SHMEM_MAP reply
> > so the KVM memory slot exists before the guest can access the mapped
> > region.
> >
> > This moves the commit to while the backend is still blocked waiting for
> > the reply, which can trigger ADD_MEM_REG back to the backend and
> > deadlock. Filter shmem mapping regions out of vhost_section() by
> > checking the MR owner type to prevent this.
> >
> > The explicit transaction begin/commit wrapping is dropped since
> > virtio_add_shmem_map() already commits via memory_region_add_subregion(=
).
> > The unmap handler keeps the original ordering: reply before delete, so
> > the backend is unblocked before the transaction commit.
> >
> > Fixes: b52e1896e764 ("vhost-user: Add VirtIO Shared Memory map request"=
)
> > Suggested-by: Albert Esteve <aesteve@redhat.com>
> > Reviewed-by: Albert Esteve <aesteve@redhat.com>
> > Tested-by: Albert Esteve <aesteve@redhat.com>
> > Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> > ---
> >  hw/virtio/vhost-user.c | 20 ++------------------
> >  hw/virtio/vhost.c      | 10 ++++++++++
> >  2 files changed, 12 insertions(+), 18 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 517cc4ca716..01468f7441a 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -1977,8 +1977,6 @@ vhost_user_backend_handle_shmem_map(struct
> vhost_dev *dev,
> >          }
> >      }
> >
> > -    memory_region_transaction_begin();
> > -
> >      /* Create VirtioSharedMemoryMapping object */
> >      VirtioSharedMemoryMapping *mapping =3D
> virtio_shared_memory_mapping_new(
> >          vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
> > @@ -1986,7 +1984,7 @@ vhost_user_backend_handle_shmem_map(struct
> vhost_dev *dev,
> >
> >      if (!mapping) {
> >          ret =3D -EFAULT;
> > -        goto send_reply_commit;
> > +        goto send_reply;
> >      }
> >
> >      /* Add the mapping to the shared memory region */
> > @@ -1994,22 +1992,8 @@ vhost_user_backend_handle_shmem_map(struct
> vhost_dev *dev,
> >          error_report("Failed to add shared memory mapping");
> >          object_unref(OBJECT(mapping));
> >          ret =3D -EFAULT;
> > -        goto send_reply_commit;
> > -    }
> > -
> > -send_reply_commit:
> > -    /* Send reply and commit after transaction started */
> > -    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > -        payload->u64 =3D !!ret;
> > -        hdr->size =3D sizeof(payload->u64);
> > -        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
> > -            error_report_err(local_err);
> > -            memory_region_transaction_commit();
> > -            return -EFAULT;
> > -        }
> > +        goto send_reply;
> >      }
> > -    memory_region_transaction_commit();
> > -    return 0;
> >
> >  send_reply:
>
> Minor idea for follow-up, not a blocker: with nothing left to do after
> the reply, we could drop reply_ack =3D false and the handler=E2=80=99s
> send_reply block, and rely on backend_read()=E2=80=99s default reply hand=
ling.
>
> >      if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index af41841b529..e5c219be095 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -636,6 +636,16 @@ static bool vhost_section(struct vhost_dev *dev,
> MemoryRegionSection *section)
> >  {
> >      MemoryRegion *mr =3D section->mr;
> >
> > +    /*
> > +     * Skip shmem mapping regions, they are managed via SHMEM_MAP/UNMA=
P.
> > +     * Including them triggers ADD_MEM_REG during the SHMEM_MAP
> transaction
> > +     * commit, deadlocking the backend.
> > +     */
> > +    if (object_dynamic_cast(memory_region_owner(mr),
> > +                            TYPE_VIRTIO_SHARED_MEMORY_MAPPING)) {
> > +        return false;
> > +    }
> > +
> >      if (memory_region_is_ram(mr) && !memory_region_is_rom(mr)) {
> >          uint8_t dirty_mask =3D memory_region_get_dirty_log_mask(mr);
> >          uint8_t handled_dirty;
> > --
> > 2.52.0
> >
>
>

--000000000000c226e00656cfb334
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sounds good, I&#39;ll look into that as a follow up.<br><b=
r>Br,<br>Dorinda.</div><br><div class=3D"gmail_quote gmail_quote_container"=
><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 17, 2026 at 4:25=E2=80=
=AFPM Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com">aesteve@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Fri, Jul 17, 2026 at 3:49=E2=80=AFPM Dorinda Bassey &lt;<a href=3D"=
mailto:dbassey@redhat.com" target=3D"_blank">dbassey@redhat.com</a>&gt; wro=
te:<br>
&gt;<br>
&gt; Commit the memory region transaction before sending the SHMEM_MAP repl=
y<br>
&gt; so the KVM memory slot exists before the guest can access the mapped<b=
r>
&gt; region.<br>
&gt;<br>
&gt; This moves the commit to while the backend is still blocked waiting fo=
r<br>
&gt; the reply, which can trigger ADD_MEM_REG back to the backend and<br>
&gt; deadlock. Filter shmem mapping regions out of vhost_section() by<br>
&gt; checking the MR owner type to prevent this.<br>
&gt;<br>
&gt; The explicit transaction begin/commit wrapping is dropped since<br>
&gt; virtio_add_shmem_map() already commits via memory_region_add_subregion=
().<br>
&gt; The unmap handler keeps the original ordering: reply before delete, so=
<br>
&gt; the backend is unblocked before the transaction commit.<br>
&gt;<br>
&gt; Fixes: b52e1896e764 (&quot;vhost-user: Add VirtIO Shared Memory map re=
quest&quot;)<br>
&gt; Suggested-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com" =
target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; Reviewed-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com" t=
arget=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; Tested-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com" tar=
get=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; Signed-off-by: Dorinda Bassey &lt;<a href=3D"mailto:dbassey@redhat.com=
" target=3D"_blank">dbassey@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/virtio/vhost-user.c | 20 ++------------------<br>
&gt;=C2=A0 hw/virtio/vhost.c=C2=A0 =C2=A0 =C2=A0 | 10 ++++++++++<br>
&gt;=C2=A0 2 files changed, 12 insertions(+), 18 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
&gt; index 517cc4ca716..01468f7441a 100644<br>
&gt; --- a/hw/virtio/vhost-user.c<br>
&gt; +++ b/hw/virtio/vhost-user.c<br>
&gt; @@ -1977,8 +1977,6 @@ vhost_user_backend_handle_shmem_map(struct vhost=
_dev *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 memory_region_transaction_begin();<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Create VirtioSharedMemoryMapping object */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtioSharedMemoryMapping *mapping =3D virtio_shar=
ed_memory_mapping_new(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_mmap-&gt;shmid, fd, vu_mmap-&gt;f=
d_offset, vu_mmap-&gt;shm_offset,<br>
&gt; @@ -1986,7 +1984,7 @@ vhost_user_backend_handle_shmem_map(struct vhost=
_dev *dev,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!mapping) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EFAULT;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto send_reply_commit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto send_reply;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Add the mapping to the shared memory region */<=
br>
&gt; @@ -1994,22 +1992,8 @@ vhost_user_backend_handle_shmem_map(struct vhos=
t_dev *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to add sha=
red memory mapping&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_unref(OBJECT(mapping));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EFAULT;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto send_reply_commit;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -send_reply_commit:<br>
&gt; -=C2=A0 =C2=A0 /* Send reply and commit after transaction started */<b=
r>
&gt; -=C2=A0 =C2=A0 if (hdr-&gt;flags &amp; VHOST_USER_NEED_REPLY_MASK) {<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 payload-&gt;u64 =3D !!ret;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;size =3D sizeof(payload-&gt;u64);=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!vhost_user_send_resp(ioc, hdr, paylo=
ad, &amp;local_err)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err)=
;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_transaction_c=
ommit();<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto send_reply;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 memory_region_transaction_commit();<br>
&gt; -=C2=A0 =C2=A0 return 0;<br>
&gt;<br>
&gt;=C2=A0 send_reply:<br>
<br>
Minor idea for follow-up, not a blocker: with nothing left to do after<br>
the reply, we could drop reply_ack =3D false and the handler=E2=80=99s<br>
send_reply block, and rely on backend_read()=E2=80=99s default reply handli=
ng.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (hdr-&gt;flags &amp; VHOST_USER_NEED_REPLY_MASK=
) {<br>
&gt; diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c<br>
&gt; index af41841b529..e5c219be095 100644<br>
&gt; --- a/hw/virtio/vhost.c<br>
&gt; +++ b/hw/virtio/vhost.c<br>
&gt; @@ -636,6 +636,16 @@ static bool vhost_section(struct vhost_dev *dev, =
MemoryRegionSection *section)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MemoryRegion *mr =3D section-&gt;mr;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Skip shmem mapping regions, they are managed vi=
a SHMEM_MAP/UNMAP.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Including them triggers ADD_MEM_REG during the =
SHMEM_MAP transaction<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* commit, deadlocking the backend.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 if (object_dynamic_cast(memory_region_owner(mr),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_VIRTIO_SHARED_MEMORY_MAPPING)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (memory_region_is_ram(mr) &amp;&amp; !memory_re=
gion_is_rom(mr)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t dirty_mask =3D memory_region=
_get_dirty_log_mask(mr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t handled_dirty;<br>
&gt; --<br>
&gt; 2.52.0<br>
&gt;<br>
<br>
</blockquote></div>

--000000000000c226e00656cfb334--


