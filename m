Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEDFC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woisE-0004Sx-Vx; Tue, 28 Jul 2026 10:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1woisD-0004Ri-0z
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:33:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1woisB-0008Fo-0h
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785249212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ZKQLAg2nWuoLrzwkndPgylElJPpiKtwbw0TCfvzw2I=;
 b=fEQn/oCOd46NZbhsyIz/USlaonQ2wKBwD0RAU8pC3KLPt0ZQDTu7bKSL9UzdyQEeSvQzEu
 fOY7mexY5guy127yw8Cb+45rKniL4kBMAeUjnNx8zid1BtrDiwMFEIOzXTPVlr2HKYBkwH
 /m9jmHVVX/0Z/F7hGHGXhIkgo0sLlIs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-BYCQB65NMxyv1ZkRf6s02w-1; Tue, 28 Jul 2026 10:33:31 -0400
X-MC-Unique: BYCQB65NMxyv1ZkRf6s02w-1
X-Mimecast-MFC-AGG-ID: BYCQB65NMxyv1ZkRf6s02w_1785249210
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-848d21bbb55so6295039b3a.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:33:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785249210; cv=none;
 d=google.com; s=arc-20260327;
 b=P6kXKFNS+p7qydh2C7ertpQuiXavq2cyD24TrKtilho4qUna6kUGaYvIC3EmL6zLTW
 pR+qQmfp2Xe2OUHds7i5BENA8e+yjSPuClXGr9+1sUkG8Q6jIMQtudbOAAH2x935e96H
 ufeADSxVqQVEo25ydQmBBd2ihCBffispO/s9ZGcdL4JtYH997N105Tu24a2uV1Pqvk8B
 b4R0sUhunaeG0eveRxRRcJeaEYzVsnEl2WRowPbgcN0cPwWQeA0omPXTk6Hxn7gZDrLt
 z094TTnD2gOYc9nFdGTAp4gdP3JdLL54mEunwda3Vx/Br1TSF3YDNE/ewWA41DHcVWqO
 DiIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6ZKQLAg2nWuoLrzwkndPgylElJPpiKtwbw0TCfvzw2I=;
 fh=kveZo5s700XlpLlVpoZ2WItC8in0XnNe+W+T0rjp+Wc=;
 b=rfKo8ktaAYE9/GkrUkwh770i+LmdX0Cr8KIT1I1XDtNcJ1bRWrs4AFqOsyq/CLKChk
 jTeKnljbHVs+qGsJXC0d8QJnebovduV/PlWDHhwqbsJaHD1j3F3NqfCb4nggGId4sfy3
 vNTNV6mGfR+eZ1w3HO35jdcMtmuWBjiQfPMe5+wAR8GzgmYjQtSPA+5bO4JhRWoRPOdp
 AGcn06/Fd0FaUQmPj5y1eZ3YvHJRazX4o6Gi+e1tkMIKQ+e8Ri6O/t6MXPJ/jNDCtXOI
 +lDDG3Vl5Y/WVtXsT5JeeLm+GIOHQDxl6jbl8KxM4Y0hGoU04BePSgrvQAduAw6KEVMb
 J/pw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785249210; x=1785854010; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6ZKQLAg2nWuoLrzwkndPgylElJPpiKtwbw0TCfvzw2I=;
 b=XpDRhv7ep0IqLXcS/MKF4G3T1PdL3ZzViyZVqSzdGiqU8BD5UiWKbKIuZeY/qVrtmm
 V+8Ad6meuAVQ62Djb4kE/YrWaotPShZelpN2lWll5lZBFu6TJK1SH5xUWbGW/E9WxFlE
 Eoa0inVjqR++Z91P5kUwrAgkANU1/r/VVkVHa3BV3wy+5Z4RxFWDWIuo7aJUl57QJjJl
 1CNtke1p5aBczjwNB1HNvx2Kj7+vAv6JdUK/2g6Cj8wXda+mwPVx9dpUySYWKl8wIFBn
 wYIcCf2/U3YWLQ37ezxAPGqUKAAR/v8MGJTvY58l+pkn4rlbY4ZxgvyLA0t5lS3brDpr
 c1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785249210; x=1785854010;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6ZKQLAg2nWuoLrzwkndPgylElJPpiKtwbw0TCfvzw2I=;
 b=hhD3ZbETiQgpqX6RTWVo7WiI46fVaWN5eUUIA1f6OABe3fqSMjvGI71kDXPg24dN0n
 XI9A5kZlybpkcZxpi7wZGrxa3slCxwsRT0nePBdna/COs3VDGY+elEmYy37gLUy5wnIc
 pxNTZHdatreJjL6NnsQivSdWzMitPqZn6NAhfcMfv8EQj+VuawTQEU/2YjBqOhoQ/h/d
 W8193yM1xA47YbZAvspnorVoDiv+zcQ4dnRUtfU1k7FqJUGiIkfZnaoPD7sjGC4nnFse
 CR5fEZHqe5IY/TsbEVHhpLzM1bEpDk6QEdHIRWV52JcBCFV6vyCPd61DWMPOmX9Vu4Vw
 yW7Q==
X-Gm-Message-State: AOJu0Yx1o0xa7OKKRQswuRvUlJqIrjzu4vBbackZ1ldXogP1tQkAszB6
 2eJ/la7nCOHJqvh5I8CTUZI/CbmndLS4V8hAY9ed1qgt/4OfslczSKNmumbT6e5FPS5LZlfDKKM
 pr/WBRIfBN/rxsx0gWKiQByQy/ArzQSshmNuxfKG61pFcVl9G6R+c8nnN3aYjmk/wlpuHfIN5Cj
 LMu+Ndgug7ofd36QjsDQvs/jV9+vwepzA=
X-Gm-Gg: AR+sD11Uaa8+q3fxqtuCNaUPzF7Mol7v9vdNih4susvXPeNJ0295llo1SBjIiB3K2tQ
 1Dfgou0Sow0WzogIAq21ziCR8r9N2KbI3bY9+ByK/NKqbzKycwWKqLwxIhSNLVar55Y004ogiaj
 YQmdhSOFFdeHMk+vO3nRyWs0dB1u3oi+P11/4BtGyJz8/hObt3ONlW/M8xu6HyUruLgIADPlUQj
 6P8272q+6fJjXzdB338qghYcL8dZ2d3KVVbl/NIG+G0xUwXqdKGuiSaVZvGGJwHG+meewnDezoO
 dw==
X-Received: by 2002:a05:6a00:9509:b0:848:4754:28e4 with SMTP id
 d2e1a72fcca58-84e9311a8e4mr3011139b3a.15.1785249210128; 
 Tue, 28 Jul 2026 07:33:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:9509:b0:848:4754:28e4 with SMTP id
 d2e1a72fcca58-84e9311a8e4mr3011084b3a.15.1785249209477; Tue, 28 Jul 2026
 07:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260728101523.3041854-1-marcandre.lureau@redhat.com>
 <a661b28d-8656-4e27-8038-e7b360e550b8@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <a661b28d-8656-4e27-8038-e7b360e550b8@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 28 Jul 2026 18:33:17 +0400
X-Gm-Features: AUfX_mwZZf2H7E8fnlKb8Yh6xr_z5SZl4EYfPgwfSmbywan-mG4Uu8YRzgHeKFo
Message-ID: <CAMxuvazu9g-M7EvHZAS3_Wbd0m0s8p0BuZbwLJZm9XBuEbrhBg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-gpu: use g_try_malloc to avoid guest-triggered
 abort
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, akihiko.odaki@gmail.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Hi

On Tue, Jul 28, 2026 at 6:28=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/07/28 19:15, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Use g_try_malloc/g_try_new0 for guest-controlled allocation, so failure
> > returns an error to the guest rather than crashing the host (glib
> > behaviour).
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3898
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> > Based-on: <20260710134720.2317856-1-marcandre.lureau@redhat.com> ("[PAT=
CH] vhost-user-gpu: fix integer overflow in buffer allocation")
> > v2:
> >   - accept NULL 0-size allocations
> > ---
> >   contrib/vhost-user-gpu/vhost-user-gpu.c | 25 +++++++++++++++++-------=
-
> >   contrib/vhost-user-gpu/virgl.c          |  6 +++++-
> >   contrib/vhost-user-gpu/vugbm.c          |  5 ++++-
> >   hw/display/virtio-gpu-rutabaga.c        | 14 ++++++++++++--
> >   hw/display/virtio-gpu-virgl.c           |  6 +++++-
> >   hw/display/virtio-gpu.c                 |  5 ++++-
> >   6 files changed, 47 insertions(+), 14 deletions(-)
> >
> > diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-us=
er-gpu/vhost-user-gpu.c
> > index ee9858c397ce..0fd115300425 100644
> > --- a/contrib/vhost-user-gpu/vhost-user-gpu.c
> > +++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
> > @@ -487,7 +487,7 @@ vg_create_mapping_iov(VuGpu *g,
> >                         struct virtio_gpu_ctrl_command *cmd,
> >                         struct iovec **iov)
> >   {
> > -    struct virtio_gpu_mem_entry *ents;
> > +    g_autofree struct virtio_gpu_mem_entry *ents =3D NULL;
> >       size_t esize, s;
> >       int i;
> >
> > @@ -498,17 +498,22 @@ vg_create_mapping_iov(VuGpu *g,
> >       }
> >
> >       esize =3D sizeof(*ents) * ab->nr_entries;
> > -    ents =3D g_malloc(esize);
> > +    ents =3D g_try_malloc(esize);
> > +    if (!ents && esize) {
> > +        return -1;
> > +    }
> >       s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
> >                      sizeof(*ab), ents, esize);
> >       if (s !=3D esize) {
> >           g_critical("%s: command data size incorrect %zu vs %zu",
> >                      __func__, s, esize);
> > -        g_free(ents);
> >           return -1;
> >       }
> >
> > -    *iov =3D g_new0(struct iovec, ab->nr_entries);
> > +    *iov =3D g_try_new0(struct iovec, ab->nr_entries);
> > +    if (!*iov && ab->nr_entries) {
> > +        return -1;
> > +    }
> >       for (i =3D 0; i < ab->nr_entries; i++) {
> >           uint64_t len =3D ents[i].length;
> >           (*iov)[i].iov_len =3D ents[i].length;
> > @@ -517,12 +522,10 @@ vg_create_mapping_iov(VuGpu *g,
> >               g_critical("%s: resource %d element %d",
> >                          __func__, ab->resource_id, i);
> >               g_free(*iov);
> > -            g_free(ents);
> >               *iov =3D NULL;
> >               return -1;
> >           }
> >       }
> > -    g_free(ents);
> >       return 0;
> >   }
> >
> > @@ -828,8 +831,14 @@ vg_resource_flush(VuGpu *g,
> >                   PIXMAN_FORMAT_BPP(pixman_image_get_format(res->image)=
) / 8;
> >               size_t size =3D width * height * bpp;
> >
> > -            void *p =3D g_malloc(VHOST_USER_GPU_HDR_SIZE +
> > -                               sizeof(VhostUserGpuUpdate) + size);
> > +            void *p =3D g_try_malloc(VHOST_USER_GPU_HDR_SIZE +
> > +                                   sizeof(VhostUserGpuUpdate) + size);
> > +            if (!p) {
> > +                pixman_region_fini(&region);
> > +                pixman_region_fini(&finalregion);
> > +                cmd->error =3D VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> > +                break;
> > +            }
> >               VhostUserGpuMsg *msg =3D p;
> >               msg->request =3D VHOST_USER_GPU_UPDATE;
> >               msg->size =3D sizeof(VhostUserGpuUpdate) + size;
> > diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/vi=
rgl.c
> > index 550fd03bf5c4..20bae57d0fe4 100644
> > --- a/contrib/vhost-user-gpu/virgl.c
> > +++ b/contrib/vhost-user-gpu/virgl.c
> > @@ -209,7 +209,11 @@ virgl_cmd_submit_3d(VuGpu *g,
> >           return;
> >       }
> >
> > -    buf =3D g_malloc(cs.size);
> > +    buf =3D g_try_malloc(cs.size);
> > +    if (!buf && cs.size) {
> > +        cmd->error =3D VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> > +        return;
> > +    }
> >       s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
> >                      sizeof(cs), buf, cs.size);
> >       if (s !=3D cs.size) {
> > diff --git a/contrib/vhost-user-gpu/vugbm.c b/contrib/vhost-user-gpu/vu=
gbm.c
> > index 710d54529779..e2d8385fd857 100644
> > --- a/contrib/vhost-user-gpu/vugbm.c
> > +++ b/contrib/vhost-user-gpu/vugbm.c
> > @@ -13,7 +13,10 @@
> >   static bool
> >   mem_alloc_bo(struct vugbm_buffer *buf)
> >   {
> > -    buf->mmap =3D g_malloc((uint64_t)buf->width * buf->height * 4);
> > +    buf->mmap =3D g_try_malloc((uint64_t)buf->width * buf->height * 4)=
;
> > +    if (!buf->mmap && buf->width && buf->height) {
> > +        return false;
> > +    }
> >       buf->stride =3D buf->width * 4;
> >       return true;
> >   }
> > diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-r=
utabaga.c
> > index e28aad94eead..60f64d9a8fa7 100644
> > --- a/hw/display/virtio-gpu-rutabaga.c
> > +++ b/hw/display/virtio-gpu-rutabaga.c
> > @@ -360,10 +360,20 @@ rutabaga_cmd_submit_3d(VirtIOGPU *g,
> >           return;
> >       }
> >
> > -    buf =3D g_new0(uint8_t, cs.size);
> > +    buf =3D g_try_new0(uint8_t, cs.size);
> > +    if (!buf && cs.size) {
> > +        cmd->error =3D VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> > +        return;
> > +    }
> >       s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
> >                      sizeof(cs), buf, cs.size);
> > -    CHECK(s =3D=3D cs.size, cmd);
> > +    if (s !=3D cs.size) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: size mismatch (%zu/%u)\n",
> > +                      __func__, s, cs.size);
> > +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> > +        return;
> > +    }
> >
> >       rutabaga_cmd.ctx_id =3D cs.hdr.ctx_id;
> >       rutabaga_cmd.cmd =3D buf;
> > diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virg=
l.c
> > index d9e5b0110497..028ab776df6a 100644
> > --- a/hw/display/virtio-gpu-virgl.c
> > +++ b/hw/display/virtio-gpu-virgl.c
> > @@ -615,7 +615,11 @@ static void virgl_cmd_submit_3d(VirtIOGPU *g,
> >           return;
> >       }
> >
> > -    buf =3D g_malloc(cs.size);
> > +    buf =3D g_try_malloc(cs.size);
> > +    if (!buf && cs.size) {
> > +        cmd->error =3D VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> > +        return;
> > +    }
> >       s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
> >                      sizeof(cs), buf, cs.size);
> >       if (s !=3D cs.size) {
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 8607d0c0b581..9bacd38b4521 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -892,7 +892,10 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
> >       }
> >
> >       esize =3D sizeof(*ents) * nr_entries;
> > -    ents =3D g_malloc(esize);
> > +    ents =3D g_try_malloc(esize);
> > +    if (!ents && esize) {
> > +        return -1;
> > +    }
>
> This converts the entry allocation to g_try_malloc(), but the resulting
> mapping arrays still grow with aborting g_renew() calls.
> dma_memory_map() may return only part of an entry; with fragmented IOMMU
> mappings, guest-controlled entries can expand into more IOVs than
> nr_entries.
>

The goal is not to make QEMU OOM-safe. Even when malloc returns
non-zero we may reach that and get killed. This patch is more a safety
guard for easy guest triggered allocations that can crash QEMU.


