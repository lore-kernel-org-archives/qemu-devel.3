Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90654C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkiZq-0008IB-1n; Fri, 17 Jul 2026 09:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkiZk-0008Hl-3f
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkiZh-0007AP-9Y
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784294756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9sNdq2VoJJQRAirfz5fenf9IpCGK3zYMDGoZDbNdoeI=;
 b=JnbihFfHBxg13YBPTaiaYxQXRJtGMsIAYw7NFCjpH/c4e8CgQHffZKRqHhwvsHUj6H9w+w
 yG5ZG21P86NGcMVKqSk+70ww6q+8zyPo9a+atK6gO9k5WGWiwXdFV6RJxRb9m1uj5R002P
 q7MAGC8t781A1tvxrlV3s7W/07ali/8=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-B-wjKNgZM--EMLM7xVnjtA-1; Fri, 17 Jul 2026 09:25:55 -0400
X-MC-Unique: B-wjKNgZM--EMLM7xVnjtA-1
X-Mimecast-MFC-AGG-ID: B-wjKNgZM--EMLM7xVnjtA_1784294754
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-48f0c5d20c6so6478681b6e.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:25:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784294754; cv=none;
 d=google.com; s=arc-20260327;
 b=r+F+J/TQXNVYETll9crvRjvF8dOHfa+KtuTgCwZWmt462wXhVAEcp322pMOIx3qHlO
 oOfBKN2J6Kz/KUsyUE8sLHMZQUpMlYa2L6GZCM8QB5u/bRAiLIJSf5RAtp0paaofazm5
 AqpL/rVNdPzoLkTdkxcCWfzbusfFew/xApoqD+sQuv6NcCzYkdepIBkeWvMqcTHb1kxG
 LGLntN+FUkSMBygtexo/UcP9UwH8NWr2SiTSJV6d2gffneeMxXTk/o8NE/supbBxS7/7
 Wc/fQQA8KvEc5gnJSpCDpZaIPblI58cWmLCAzUeNPcyXl+kuc+pnm0DY49v//UkQYSOW
 RdVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9sNdq2VoJJQRAirfz5fenf9IpCGK3zYMDGoZDbNdoeI=;
 fh=U9TUit7J9qCkxCjcC9c8Uz7Xap3+9ZNV1UQG0kyLV6Y=;
 b=hFoxpt9y+WPs/tD+RYPmnn5KnZHAsg3JSS8ayxDMDzmZBZBJOOK4aBD6JzZxuyPoI+
 h3ClDcRPcbHkFMWx7FG3BegYNdsTnkXVuYyfArzSs0GWklhZ34vXguikjNn0cb/WvnT8
 xpzbWyC1sJSsEO8EyuH4hdtjKud4+fvvTgmd9vqB5Stc7fzpWqhK4LKPXRHi0nc2+DED
 IggpC4TbnX8my3Ju9DZmyghaUTWWXJ/LfLhrf52lFSBBsG00u5k1MSTU9V0rAP9Lzi/l
 BCcsxdOeyO8B3v23mjYUvdHynEY1vqI5QTxM7T8YHYwmEFQsWEC/84ZsvqbF4vwyWpE6
 iVjw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784294754; x=1784899554; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9sNdq2VoJJQRAirfz5fenf9IpCGK3zYMDGoZDbNdoeI=;
 b=StJTWKdvGWOM5VffQOnpNCQ6UHF2hSOjsaZ+gsyBKxgmu5JM8tEFlQk+R61pLXUycQ
 LeiXIzelLF/LCKrmfhbEoEPzlBeEMYTJSQ4boCv6rco50AQeK4nZq+8xngEJUmsJrVya
 xzESiJ8+qjvcxPzfYD6745vVtYzBbZSwPuMTQoxWIH3IX5j1ut5Tabfabr+ZrTNcsEko
 7PlX8UKrPEb9RK6sBPuX6f14VcOasKQ4xW+2A4Ke8PhSb6v0vduRdrpZ0NfFmtpDZZK7
 dQdyeJ7F4e4Nsf60CdcYXsjcGuBySBOXOzztTneI/MW0djLuxxtBr8jhOJIbODbcOz+T
 y3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784294754; x=1784899554;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9sNdq2VoJJQRAirfz5fenf9IpCGK3zYMDGoZDbNdoeI=;
 b=fX+LxxRCOr80hHwqj1gcjLpLpo8eppXUcYtm3Nww5Pnv+fpNYtnuKcknkXhMjkEZ/G
 DCrjNYZx3vEyBMpfxzWNAxxxpC0gE672y+VOnHpdsk43QNlYovIXLWDPqTHwyQH3xdw3
 ur774OddWZlnnCVleYNToYyIYGyr++q7PNT+GMACMV+ycDFTSDuzeVb7SNYiJ4QVVM0f
 KWRl8mHt2M5Sfpg7orSi8JCI7u6SkuKiRAXHVctpZRNxMO2pE60im4ODfhtDCmqmjTk6
 ihS2LwZIiP8G0dm90WA15Q/sFgMIgDiQ/cckdpflVLAfKsZiqLB2nebgqx9qqPOaWXLt
 Mgyg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSssI2nKvzhOQTYNRnPEAbIC2xJ+vrwjrVVo3W4sKTHHgPI0l5zM9lNC74rnZ5jAuzFyEtlBStzCNt@nongnu.org
X-Gm-Message-State: AOJu0Yx/aqF7n/IXXBi4pExyrvB2A4zAGMooWVXMxADrPunffsaJtDEb
 KnKV7IRiYGg0IOWjx6KRuIdvCORt7+qNe4cAvP8wBV5sR0e5OaKp7Tt+ETphkynkVGIAB8+PYQJ
 mZdSr+jCT815qI9J3Iqr9CUYzTxQrDnbKcqKXuqdqdk6oJO0J5m0fgvV5Kh2zDitHy4KxFj+lNt
 j8luxN6pNJiDxi+gMGW/k6412Smq62K7M=
X-Gm-Gg: AfdE7cm7qTMOzmwAbQ9TSf2B3WYUd6o1pCC41o+PvzCoHrnfL95mXXeeNcecWaJnfsL
 rB0zWcFp6azl6zzx9/UoptMj7ekOdvwBaSr1e1apbclxB+HMzjBS1nojW1ckeDm6sSTBCzrz7Ec
 gPiUbNbIRom0lGvvg3a56cI7g0nYMFLtnb5/KxejoNoa3EMx+cqug9XL/mnX5BtCG6PlgFUo5ct
 ib0XcT2Wm6cghCE5ZSg7Ez2R5f47vS+Zm/qNmLqRHE9Pw==
X-Received: by 2002:a05:6808:1904:b0:495:ecd3:ba29 with SMTP id
 5614622812f47-4a4d03a96b0mr1161821b6e.35.1784294754082; 
 Fri, 17 Jul 2026 06:25:54 -0700 (PDT)
X-Received: by 2002:a05:6808:1904:b0:495:ecd3:ba29 with SMTP id
 5614622812f47-4a4d03a96b0mr1161803b6e.35.1784294753612; Fri, 17 Jul 2026
 06:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260717103301.228974-1-dbassey@redhat.com>
 <20260717103301.228974-2-dbassey@redhat.com>
 <20260717063641-mutt-send-email-mst@kernel.org>
 <CADSE00+Uoy=fu3OnvMCr0Cn=tHSj27LkD9y7_CPqT32oSaDFow@mail.gmail.com>
 <20260717085600-mutt-send-email-mst@kernel.org>
 <CADSE00K8xv0WOZQjL95SuZTEMadKc+HyMTffFkJ0EG27f3bHOQ@mail.gmail.com>
In-Reply-To: <CADSE00K8xv0WOZQjL95SuZTEMadKc+HyMTffFkJ0EG27f3bHOQ@mail.gmail.com>
From: Dorinda Bassey <dbassey@redhat.com>
Date: Fri, 17 Jul 2026 15:25:42 +0200
X-Gm-Features: AUfX_mzA9nO7GTnRQfwimGnKAAPDHGitdfb7KRIOzpljG3VICjToED7L4SsbmYg
Message-ID: <CACzuRyzbemx+jLTRzXxEhxKwuM6Prq5KHzxfNvf=MHUBBToQxA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] vhost: Fix SHMEM_MAP transaction ordering and
 resulting deadlock
To: Albert Esteve <aesteve@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 mhrica@redhat.com, sgarzare@redhat.com, manos.pitsidianakis@linaro.org, 
 marcandre.lureau@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Content-Type: multipart/alternative; boundary="000000000000f71ed00656ce7e30"
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

--000000000000f71ed00656ce7e30
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So I will keep the current mainline ordering for unmap (reply before
delete) as Michael suggested.

On Fri, Jul 17, 2026 at 3:11=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:

> On Fri, Jul 17, 2026 at 2:58=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Fri, Jul 17, 2026 at 01:50:31PM +0200, Albert Esteve wrote:
> > > On Fri, Jul 17, 2026 at 12:37=E2=80=AFPM Michael S. Tsirkin <mst@redh=
at.com>
> wrote:
> > > >
> > > > On Fri, Jul 17, 2026 at 12:32:59PM +0200, Dorinda Bassey wrote:
> > > > > Commit the memory region transaction before sending the SHMEM_MAP
> reply
> > > > > so the KVM memory slot exists before the guest can access the
> mapped
> > > > > region.
> > > > >
> > > > > This moves the commit to while the backend is still blocked
> waiting for
> > > > > the reply, which can trigger ADD_MEM_REG back to the backend and
> > > > > deadlock. Filter shmem mapping regions out of vhost_section() by
> > > > > checking the MR owner type to prevent this.
> > > > >
> > > > > The explicit transaction begin/commit wrapping is dropped since
> > > > > virtio_add_shmem_map() already commits via
> memory_region_add_subregion().
> > > > >
> > > > > Fixes: b52e1896e764 ("vhost-user: Add VirtIO Shared Memory map
> request")
> > > > > Suggested-by: Albert Esteve <aesteve@redhat.com>
> > > > > Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> > > > > ---
> > > > >  hw/virtio/vhost-user.c | 20 ++------------------
> > > > >  hw/virtio/vhost.c      | 10 ++++++++++
> > > > >  2 files changed, 12 insertions(+), 18 deletions(-)
> > > > >
> > > > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > > > index 517cc4ca716..01468f7441a 100644
> > > > > --- a/hw/virtio/vhost-user.c
> > > > > +++ b/hw/virtio/vhost-user.c
> > > > > @@ -1977,8 +1977,6 @@ vhost_user_backend_handle_shmem_map(struct
> vhost_dev *dev,
> > > > >          }
> > > > >      }
> > > > >
> > > > > -    memory_region_transaction_begin();
> > > > > -
> > > > >      /* Create VirtioSharedMemoryMapping object */
> > > > >      VirtioSharedMemoryMapping *mapping =3D
> virtio_shared_memory_mapping_new(
> > > > >          vu_mmap->shmid, fd, vu_mmap->fd_offset,
> vu_mmap->shm_offset,
> > > > > @@ -1986,7 +1984,7 @@ vhost_user_backend_handle_shmem_map(struct
> vhost_dev *dev,
> > > > >
> > > > >      if (!mapping) {
> > > > >          ret =3D -EFAULT;
> > > > > -        goto send_reply_commit;
> > > > > +        goto send_reply;
> > > > >      }
> > > > >
> > > > >      /* Add the mapping to the shared memory region */
> > > > > @@ -1994,22 +1992,8 @@ vhost_user_backend_handle_shmem_map(struct
> vhost_dev *dev,
> > > > >          error_report("Failed to add shared memory mapping");
> > > > >          object_unref(OBJECT(mapping));
> > > > >          ret =3D -EFAULT;
> > > > > -        goto send_reply_commit;
> > > > > -    }
> > > > > -
> > > > > -send_reply_commit:
> > > > > -    /* Send reply and commit after transaction started */
> > > > > -    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > > > > -        payload->u64 =3D !!ret;
> > > > > -        hdr->size =3D sizeof(payload->u64);
> > > > > -        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)=
)
> {
> > > > > -            error_report_err(local_err);
> > > > > -            memory_region_transaction_commit();
> > > > > -            return -EFAULT;
> > > > > -        }
> > > > > +        goto send_reply;
> > > > >      }
> > > > > -    memory_region_transaction_commit();
> > > > > -    return 0;
> > > > >
> > > > >  send_reply:
> > > > >      if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > > > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > > > index af41841b529..e5c219be095 100644
> > > > > --- a/hw/virtio/vhost.c
> > > > > +++ b/hw/virtio/vhost.c
> > > > > @@ -636,6 +636,16 @@ static bool vhost_section(struct vhost_dev
> *dev, MemoryRegionSection *section)
> > > > >  {
> > > > >      MemoryRegion *mr =3D section->mr;
> > > > >
> > > > > +    /*
> > > > > +     * Skip shmem mapping regions, they are managed via
> SHMEM_MAP/UNMAP.
> > > > > +     * Including them triggers ADD_MEM_REG during the SHMEM_MAP
> transaction
> > > > > +     * commit, deadlocking the backend.
> > > > > +     */
> > > > > +    if (object_dynamic_cast(memory_region_owner(mr),
> > > > > +                            TYPE_VIRTIO_SHARED_MEMORY_MAPPING)) =
{
> > > > > +        return false;
> > > > > +    }
> > > > > +
> > > > >      if (memory_region_is_ram(mr) && !memory_region_is_rom(mr)) {
> > > > >          uint8_t dirty_mask =3D memory_region_get_dirty_log_mask(=
mr);
> > > > >          uint8_t handled_dirty;
> > > >
> > > >
> > > > This all seems risky i have to say.  Is this always map never unmap=
?
> > >
> > > The filter covers both, and this is a good point. For symmetry the
> > > handle_shmem_unmap() should call virtio_del_shmem_map() before
> > > replying.
> > >
> > > BR,
> > > Albert.
> >
> > the reverse order I would say?
> >
> > if we add, first we commit then update the backend
> >
> > if we delete first update the backend then commit?
>
> I think it could be argued both ways, so I'd be ok with what you
> described (which is what's done in current mainline for the unmap
> side).
>
> The reason the commit (the whole del_shmem_map() op) was delayed
> before on unmap was to avoid the deadlock (the same as for map).
>
> With the filter, that is no longer a problem. So I would say that if
> the backend sends a SHMEM_UNMAP request, by the time it receives the
> reply the unmap operation is already commited. It's more symmetrical:
> the frontend only replies when the requested memory operation (map or
> unmap) is finished and committed.
>
> >
> >
> >
> > > >
> > > > > --
> > > > > 2.52.0
> > > >
> >
>
>

--000000000000f71ed00656ce7e30
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">So I will keep the current mainline ordering for unmap (re=
ply before delete) as Michael suggested.</div><br><div class=3D"gmail_quote=
 gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 1=
7, 2026 at 3:11=E2=80=AFPM Albert Esteve &lt;<a href=3D"mailto:aesteve@redh=
at.com">aesteve@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On Fri, Jul 17, 2026 at 2:58=E2=80=AFPM Michael S=
. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redha=
t.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Fri, Jul 17, 2026 at 01:50:31PM +0200, Albert Esteve wrote:<br>
&gt; &gt; On Fri, Jul 17, 2026 at 12:37=E2=80=AFPM Michael S. Tsirkin &lt;<=
a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; w=
rote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Fri, Jul 17, 2026 at 12:32:59PM +0200, Dorinda Bassey wro=
te:<br>
&gt; &gt; &gt; &gt; Commit the memory region transaction before sending the=
 SHMEM_MAP reply<br>
&gt; &gt; &gt; &gt; so the KVM memory slot exists before the guest can acce=
ss the mapped<br>
&gt; &gt; &gt; &gt; region.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; This moves the commit to while the backend is still blo=
cked waiting for<br>
&gt; &gt; &gt; &gt; the reply, which can trigger ADD_MEM_REG back to the ba=
ckend and<br>
&gt; &gt; &gt; &gt; deadlock. Filter shmem mapping regions out of vhost_sec=
tion() by<br>
&gt; &gt; &gt; &gt; checking the MR owner type to prevent this.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; The explicit transaction begin/commit wrapping is dropp=
ed since<br>
&gt; &gt; &gt; &gt; virtio_add_shmem_map() already commits via memory_regio=
n_add_subregion().<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Fixes: b52e1896e764 (&quot;vhost-user: Add VirtIO Share=
d Memory map request&quot;)<br>
&gt; &gt; &gt; &gt; Suggested-by: Albert Esteve &lt;<a href=3D"mailto:aeste=
ve@redhat.com" target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; &gt; &gt; &gt; Signed-off-by: Dorinda Bassey &lt;<a href=3D"mailto:dba=
ssey@redhat.com" target=3D"_blank">dbassey@redhat.com</a>&gt;<br>
&gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt;=C2=A0 hw/virtio/vhost-user.c | 20 ++------------------<=
br>
&gt; &gt; &gt; &gt;=C2=A0 hw/virtio/vhost.c=C2=A0 =C2=A0 =C2=A0 | 10 ++++++=
++++<br>
&gt; &gt; &gt; &gt;=C2=A0 2 files changed, 12 insertions(+), 18 deletions(-=
)<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-u=
ser.c<br>
&gt; &gt; &gt; &gt; index 517cc4ca716..01468f7441a 100644<br>
&gt; &gt; &gt; &gt; --- a/hw/virtio/vhost-user.c<br>
&gt; &gt; &gt; &gt; +++ b/hw/virtio/vhost-user.c<br>
&gt; &gt; &gt; &gt; @@ -1977,8 +1977,6 @@ vhost_user_backend_handle_shmem_m=
ap(struct vhost_dev *dev,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 memory_region_transaction_begin();<br>
&gt; &gt; &gt; &gt; -<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* Create VirtioSharedMemoryMapping=
 object */<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 VirtioSharedMemoryMapping *mapping =
=3D virtio_shared_memory_mapping_new(<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_mmap-&gt;shmid, fd=
, vu_mmap-&gt;fd_offset, vu_mmap-&gt;shm_offset,<br>
&gt; &gt; &gt; &gt; @@ -1986,7 +1984,7 @@ vhost_user_backend_handle_shmem_m=
ap(struct vhost_dev *dev,<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (!mapping) {<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EFAULT;<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto send_reply_commit;<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto send_reply;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* Add the mapping to the shared me=
mory region */<br>
&gt; &gt; &gt; &gt; @@ -1994,22 +1992,8 @@ vhost_user_backend_handle_shmem_=
map(struct vhost_dev *dev,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Fa=
iled to add shared memory mapping&quot;);<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_unref(OBJECT(m=
apping));<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EFAULT;<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto send_reply_commit;<br=
>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; -<br>
&gt; &gt; &gt; &gt; -send_reply_commit:<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 /* Send reply and commit after transacti=
on started */<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 if (hdr-&gt;flags &amp; VHOST_USER_NEED_=
REPLY_MASK) {<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 payload-&gt;u64 =3D !!ret;=
<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;size =3D sizeof(pa=
yload-&gt;u64);<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!vhost_user_send_resp(=
ioc, hdr, payload, &amp;local_err)) {<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report=
_err(local_err);<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_regio=
n_transaction_commit();<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAU=
LT;<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto send_reply;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 memory_region_transaction_commit();<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 return 0;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 send_reply:<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (hdr-&gt;flags &amp; VHOST_USER_=
NEED_REPLY_MASK) {<br>
&gt; &gt; &gt; &gt; diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c<br>
&gt; &gt; &gt; &gt; index af41841b529..e5c219be095 100644<br>
&gt; &gt; &gt; &gt; --- a/hw/virtio/vhost.c<br>
&gt; &gt; &gt; &gt; +++ b/hw/virtio/vhost.c<br>
&gt; &gt; &gt; &gt; @@ -636,6 +636,16 @@ static bool vhost_section(struct v=
host_dev *dev, MemoryRegionSection *section)<br>
&gt; &gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 MemoryRegion *mr =3D section-&gt;mr=
;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* Skip shmem mapping regions, they=
 are managed via SHMEM_MAP/UNMAP.<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* Including them triggers ADD_MEM_=
REG during the SHMEM_MAP transaction<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* commit, deadlocking the backend.=
<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (object_dynamic_cast(memory_region_ow=
ner(mr),<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_VIRTIO_SHARED_MEMORY_MAP=
PING)) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (memory_region_is_ram(mr) &amp;&=
amp; !memory_region_is_rom(mr)) {<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t dirty_mask =
=3D memory_region_get_dirty_log_mask(mr);<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t handled_dirty=
;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This all seems risky i have to say.=C2=A0 Is this always map=
 never unmap?<br>
&gt; &gt;<br>
&gt; &gt; The filter covers both, and this is a good point. For symmetry th=
e<br>
&gt; &gt; handle_shmem_unmap() should call virtio_del_shmem_map() before<br=
>
&gt; &gt; replying.<br>
&gt; &gt;<br>
&gt; &gt; BR,<br>
&gt; &gt; Albert.<br>
&gt;<br>
&gt; the reverse order I would say?<br>
&gt;<br>
&gt; if we add, first we commit then update the backend<br>
&gt;<br>
&gt; if we delete first update the backend then commit?<br>
<br>
I think it could be argued both ways, so I&#39;d be ok with what you<br>
described (which is what&#39;s done in current mainline for the unmap<br>
side).<br>
<br>
The reason the commit (the whole del_shmem_map() op) was delayed<br>
before on unmap was to avoid the deadlock (the same as for map).<br>
<br>
With the filter, that is no longer a problem. So I would say that if<br>
the backend sends a SHMEM_UNMAP request, by the time it receives the<br>
reply the unmap operation is already commited. It&#39;s more symmetrical:<b=
r>
the frontend only replies when the requested memory operation (map or<br>
unmap) is finished and committed.<br>
<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; --<br>
&gt; &gt; &gt; &gt; 2.52.0<br>
&gt; &gt; &gt;<br>
&gt;<br>
<br>
</blockquote></div>

--000000000000f71ed00656ce7e30--


