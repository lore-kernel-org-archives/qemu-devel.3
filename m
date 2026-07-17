Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35ECC44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfTs-0003f3-NT; Fri, 17 Jul 2026 06:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkfTr-0003eI-Cr
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:07:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkfTo-0006cz-3P
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784282857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MhXq8XzAXs43zmk73r7uhYgGuzDlJaKeIgsxXbc0Ylc=;
 b=HQBqXteyjWH/Jv19sb5iUeqa/lRwArdf6cc+gmEBbgjvu0ykKmVfFH947lovCvoHS6of9W
 8mWoqDlFACnbm9DIGGs0ZweAPXlqW5451Hgwyn/fdnFqSCO+4IauAd0H2kyyoq3oVEactz
 xnHNAyiNhunT+s4QiDEJIdc0d7qal0A=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-wnLrXnmrM-mYynV2PRHttw-1; Fri, 17 Jul 2026 06:07:35 -0400
X-MC-Unique: wnLrXnmrM-mYynV2PRHttw-1
X-Mimecast-MFC-AGG-ID: wnLrXnmrM-mYynV2PRHttw_1784282854
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4a416619e8dso2158261b6e.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 03:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784282854; cv=none;
 d=google.com; s=arc-20260327;
 b=I6Jq7MOIzZ3ezDV2imlhIKk/ePuEyYdpCVHylKKYLlhbth6zDpyV/wos/FmXSgGG+m
 axCaT+I5+fG5MkTA3jW0wlVynvEKUAGkh8JBjffFiQBr4e79yijK/rrslH8AX0KEYJm0
 LdhFZ61wdW/0FHCoEgnS6QEfZUoAKjY4eZoVRpQXXLiHLRj4DoNHjhRREEg7ykQqi+hG
 IALPVfGcn5JvpmJJ57sq5ZOA7htLFJGFVDuOSu+Z9EtX8MsvpVlN4ylWsm1kz6OUH1f6
 cgCqd4Q/MZrkjfSHYSN+GH8IQVIloaFnCeP7eheUqj8ei4yhuhudZyL7Crqq+HarIPRj
 vDqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MhXq8XzAXs43zmk73r7uhYgGuzDlJaKeIgsxXbc0Ylc=;
 fh=OVFBnnrHX6Kfo6v1yc39uPbGOjbRxbkTg355Y9hOqhQ=;
 b=jBtzZ43Aa/EFcEVnyWRMzMr6hDoVpvqiSBCWyNUk3AopZMpUuh8dik1spQOQ2JVDyn
 CEk+YOTT5kr8ErlZDnqHKGuzSbXhFf2llnafxvMRxHD7J/wrNTiBb9dbMC3fCqVbOGNR
 iLbwyNCi18aimmibjEV8QCpFRjuRPA647KXCqoW12B1Zor7rdpyF6yKVlUmznp56GaNj
 ZwcXmdR3vndOWef4tszQEW35v0ha2rIyB551y3sOnU49a88edFAEc++LElemfWtn/AZR
 zfU8mtgyaf7kKxdNADqDWL9g5flp20FL61VxxRVass/dKfZeQEpsFVfXWrpFjEEilu8t
 Xg/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784282854; x=1784887654; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MhXq8XzAXs43zmk73r7uhYgGuzDlJaKeIgsxXbc0Ylc=;
 b=ZN66D8TTEtREZIi6w6puClu3TKpKc1llcTuDzFd7b8mTpdOJBBZ4yFI26Pet+IVyVg
 cep/GumnBZr5dJlk2cqH2iY7ZhE1f0RSvngdswyd34Q49ZSVnGUv3b23gx4wKnIAs0tp
 xO0ei0H79hMVhNJkg5KxEfHM5VSPVFqJwReKcS8FokpEJmmFLFOdkLduonJ8yAVzuSBi
 9769/Chqj7JEYNWh6SmpmkMTBY8dL0OPOcj9VnCGDRaXCxgmvsNTmySikzsYfLMXpXnG
 HQKABT89yzqrkvPhRm2zFmr7sZu/tpwkoe9RoFAG8iaQ9gFSzY3nDK1VDh7v25tXbqTi
 xWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784282854; x=1784887654;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MhXq8XzAXs43zmk73r7uhYgGuzDlJaKeIgsxXbc0Ylc=;
 b=RfdHRN0UIcywx9GjYgT1Chxz+5de2z6qhMxP09ZLLYFDIDa+5Dz+/g8gjkR59cemAp
 mfnfW9KexmO8MT2Xqbjf/figwd3bsoXtUqaSkUU1ELh3aYKJ9rXdr+VsYvfykrek9ZBQ
 CJXclAMd5aVkuPvqLBqmnkPtxJRc+azKVLlK3fP9Pc44YHcE4Ls4bR/EFnkvGyq6vjrs
 DC3nDXSbr8h7PtmT0bZefrz3qrMGlWUxamqp43QPqBB3GY3xrrjKEmtnM1KwKJgcohQh
 UZEKQNaqTzyNSc3sX2KY8mCkuZ882YlOof0qz5ma+fChJiUwpIMxmkwD/xH1NdjLHqvB
 scrg==
X-Gm-Message-State: AOJu0YxyAFLxtJh0nIgiyYwx+OPIsaUN/7YMrgI4CSY1TbMpslKnQanU
 w+x7JfCuXzGnAsZcTMxjajkG+DvSu3+Q3fpDObRqcMRyt0yhlRvXSdCxNpyoR8G9Rq1+2iUm5yQ
 A78L8hH8rChzEDKmHobvsV+DnT1E2p32R6DyMQJpmD72Ic4G8F+OQAomgPH/hqYzocG8SPeJb1U
 HGq3gP98spgyR5uOjY/1y1ubVJgYK4whc=
X-Gm-Gg: AfdE7cnNhKa7PBLh1izSVUVkpsuEhbew2BiXX/xTfPU2dUXhYbK4VLhW4QFrmiUvsI1
 YmzRQDD4Xzr3yz0vua0wdwQ6ntAXCApDmWtb4hfcZ30Wju2yPWeP1alPajUnlbNv8wkb/ZBrGhL
 gph7DtxJlNr9w8+EmfWq5E1la80JdQ5YjBiWo7bz/pV4qOL4w3rLktu8xTQZSF5DgMLKjOLK2r+
 Y7IjV6/tVgTvN5mXBQO9bOc7VYV3n5VSKhcX4PiQLgV
X-Received: by 2002:a05:6808:4fd3:b0:495:f697:92d9 with SMTP id
 5614622812f47-4a4b20685f0mr4772337b6e.7.1784282853979; 
 Fri, 17 Jul 2026 03:07:33 -0700 (PDT)
X-Received: by 2002:a05:6808:4fd3:b0:495:f697:92d9 with SMTP id
 5614622812f47-4a4b20685f0mr4772321b6e.7.1784282853545; Fri, 17 Jul 2026
 03:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260717093925.214023-1-dbassey@redhat.com>
 <20260717093925.214023-4-dbassey@redhat.com>
 <20260717055918-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260717055918-mutt-send-email-mst@kernel.org>
From: Dorinda Bassey <dbassey@redhat.com>
Date: Fri, 17 Jul 2026 12:07:21 +0200
X-Gm-Features: AUfX_mwHDUr2AKcCtEGITag9myJNPNxVRK2RWA8Sj7AEWRNe-M-8yjSI6Hp9IWo
Message-ID: <CACzuRyw=QTSwz1aWVhBG7EO6MeWi85YTMvV-DT_+tsWADMcfqw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] vhost: Fix SHMEM_MAP transaction ordering and
 resulting deadlock
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, mhrica@redhat.com, sgarzare@redhat.com, 
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com, 
 stefanha@redhat.com, pbonzini@redhat.com, aesteve@redhat.com
Content-Type: multipart/alternative; boundary="000000000000aa37b00656cbb949"
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

--000000000000aa37b00656cbb949
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You're right, I will reorder it in v3. The fix came last because I only
discovered the deadlock while testing the shmem/blob support,
but it makes sense to have it first since patch 2 depends on it.

On Fri, Jul 17, 2026 at 12:00=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:

> On Fri, Jul 17, 2026 at 11:39:25AM +0200, Dorinda Bassey wrote:
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
> >
> > Suggested-by: Albert Esteve <aesteve@redhat.com>
> > Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
>
> i do not get this ordering) of patches) why are there features and last
> patch
> is a bugfix? if this is a dependency it should come first.
>
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
>
>

--000000000000aa37b00656cbb949
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>You&#39;re right, I will reorder it in v3. The fix ca=
me last because I only</div><div>discovered the deadlock while testing the =
shmem/blob support,</div>but it makes sense to have it first since patch 2 =
depends on it.</div><br><div class=3D"gmail_quote gmail_quote_container"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 17, 2026 at 12:00=E2=80=AFP=
M Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Fri, Jul 17, 2026 at 11:39:25AM +0200, Dorinda Bassey wrote:<br>
&gt; Commit the memory region transaction before sending the SHMEM_MAP repl=
y<br>
&gt; so the KVM memory slot exists before the guest can access the mapped<b=
r>
&gt; region.<br>
&gt; <br>
&gt; This moves the commit to while the backend is still blocked waiting fo=
r<br>
&gt; the reply, which can trigger ADD_MEM_REG back to the backend and<br>
&gt; deadlock. Filter shmem mapping regions out of vhost_section() by<br>
&gt; checking the MR owner type to prevent this.<br>
&gt; <br>
&gt; The explicit transaction begin/commit wrapping is dropped since<br>
&gt; virtio_add_shmem_map() already commits via memory_region_add_subregion=
().<br>
&gt; <br>
&gt; Suggested-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com" =
target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; Signed-off-by: Dorinda Bassey &lt;<a href=3D"mailto:dbassey@redhat.com=
" target=3D"_blank">dbassey@redhat.com</a>&gt;<br>
<br>
i do not get this ordering) of patches) why are there features and last pat=
ch<br>
is a bugfix? if this is a dependency it should come first.<br>
<br>
&gt; ---<br>
&gt;=C2=A0 hw/virtio/vhost-user.c | 20 ++------------------<br>
&gt;=C2=A0 hw/virtio/vhost.c=C2=A0 =C2=A0 =C2=A0 | 10 ++++++++++<br>
&gt;=C2=A0 2 files changed, 12 insertions(+), 18 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
&gt; index 517cc4ca716..01468f7441a 100644<br>
&gt; --- a/hw/virtio/vhost-user.c<br>
&gt; +++ b/hw/virtio/vhost-user.c<br>
&gt; @@ -1977,8 +1977,6 @@ vhost_user_backend_handle_shmem_map(struct vhost=
_dev *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 memory_region_transaction_begin();<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Create VirtioSharedMemoryMapping object */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtioSharedMemoryMapping *mapping =3D virtio_shar=
ed_memory_mapping_new(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_mmap-&gt;shmid, fd, vu_mmap-&gt;f=
d_offset, vu_mmap-&gt;shm_offset,<br>
&gt; @@ -1986,7 +1984,7 @@ vhost_user_backend_handle_shmem_map(struct vhost=
_dev *dev,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!mapping) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EFAULT;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto send_reply_commit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto send_reply;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
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
&gt;=C2=A0 <br>
&gt;=C2=A0 send_reply:<br>
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
&gt;=C2=A0 <br>
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
&gt; -- <br>
&gt; 2.52.0<br>
<br>
</blockquote></div>

--000000000000aa37b00656cbb949--


