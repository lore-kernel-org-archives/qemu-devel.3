Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E343C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 22:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wopu0-0007Ng-PL; Tue, 28 Jul 2026 18:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wopty-0007NX-4O
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 18:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1woptv-00050i-Nk
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 18:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785276230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rAv/v8x9021XTWgwo8rlzaKUctEb+lbPaRXpKZd1M94=;
 b=TpLjnL2mBOZr0pMMdIxT/1+Xx08fCO5XQg0jJDyPeqEIMrSZjv3IJfvdz+eUaNdAWXpgUL
 SNGW4XKTjeMlFd6Bav1Oc/7T45nfYpHzDIsWA+r653JLe2tWaCYayzCqO+oiMJUobUpQCD
 2WkzFu5T6HZxLXHRwzEYYhXpJ9oDhxQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-WAkbN4y5NuuqpKzHVmCVUw-1; Tue, 28 Jul 2026 18:03:48 -0400
X-MC-Unique: WAkbN4y5NuuqpKzHVmCVUw-1
X-Mimecast-MFC-AGG-ID: WAkbN4y5NuuqpKzHVmCVUw_1785276228
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84e4ef486c7so187118b3a.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 15:03:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785276228; cv=none;
 d=google.com; s=arc-20260327;
 b=eP3zcE/OfGPW3CF0Hgotu3AiBl7YaWV7Qn8pBYzCJFfZr4oNPK/klO1zoeXilx2Tjb
 AaUz7/+ZePK8Y37Y4KRw3t07FloMr5wPnIXN9iBsmcxDVSDtTwFHr7H8dRfP80wUNvTI
 ljPmhuR+L24xZciuvMCl4bca7F+gvmD14ck85FjhP1/18FqZpnpwoI1AMKYCqNAFBmg1
 +qzq0hG79dcaLmi5GYHHfXfPI76npt/Bfn+qCiea4IW0y9ASd1OB/94bOlbXPfD3o6tA
 NKohkI+yJDbi9nrWE5vHodDWA2lYn7NoqNAn0a44csUaMrwreKTyIuxqO+MDNq5gsU3u
 b/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rAv/v8x9021XTWgwo8rlzaKUctEb+lbPaRXpKZd1M94=;
 fh=kveZo5s700XlpLlVpoZ2WItC8in0XnNe+W+T0rjp+Wc=;
 b=DwYSjDfAtpw36hG7L+8J/3vlY80uqjliR4u05T2IiwuzZQpV6spgt4RHsl+ufuU0cg
 LzFPve+Ezex/qCYyh1TfolXwF4yZiXnLhVck9ywafelPSbK7kHGvO2MdMmfFkkRoVGRc
 XFJ41XkDZB8rDFYIXlNrXWZYjNy1GxEbPF+F/IZVHdfuVicoWRfTsMrMS9QP5q3d48MW
 DElQ2wdKvL3q7ETXxzsdxzqT/FmzEYjJXlgmBa8jc327a75w1g9llOvPMIdijxdLd07o
 IDg3DLqY6BoIBacBdXa1lIeOVh7m5xo2JYKiLakkZPF+69PwjpMp+D4WLzsuGENzuzYr
 HpTw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785276228; x=1785881028; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rAv/v8x9021XTWgwo8rlzaKUctEb+lbPaRXpKZd1M94=;
 b=LQvpR7vmH+LToca5VLQ5wqUlaRYmW2CfN+mpQxXbE/+S5i3VTkWTlOyGAKwPft+o2r
 lUhoGgVPrjwoo2ZqKqOn1NTOarJTmS8V3ILOZt8DMX/MegTf38svkE3etG1h6VRSrRpf
 3qMLCfz6b+B4ZUv9MxSBQCL6PG7w1T1SonRlBjPz2GISR42QR4ze9eJ82tOSnCPaYdM7
 ACb6t7YirrF/hY3GUajiiwab6VJ8IgAf6H4qiYMvVxm16H28IFbi8NV9EC3wkqKJmLAw
 X6DSYkSugWBwqgsjJtHUFzv3EDhntWlDeiGHb+Gn8TaASNy9dcdYiviEzTdPdAZM5cT7
 dClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785276228; x=1785881028;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rAv/v8x9021XTWgwo8rlzaKUctEb+lbPaRXpKZd1M94=;
 b=oAvryhN4tU3LIaTzeAUv0v1hMh7p+7JPK5p1J1GsEa5gSFeG/QnNUQQEAlZHxEH8WN
 Q2XC3PaQwNqxG8smhx9w99US5fEmu31nieR+HtP4A1h55OqZ1/E8YoIGaPzRy0Ld5et+
 qAPrI12dhfJP/22wwkJTkJsDj5M+5HErzR8FAc7ICHr5vZGsA59UqF0UP/jRS9kvBRj3
 bWQ1D+135FumEmSv9m+PfP3Q/w3YoYx58zDzMEAXWC55RQEP5cbMZH9M89D8l1wiDiTj
 1Try+pNbcQEj1bgsAWgJdvWu9hsOwzwdZuNhxYvRWZWTbz36HkzhUQ5grp9mo747VvNc
 tZqw==
X-Gm-Message-State: AOJu0YyppXPJqNqXuE9hnwpz7RpHYGxwjBqR69upQr694A8Dc4KQg5JP
 OKEzpiqw+MSremvctCShUqGRZ6s2aCaUrt0eKDPq60vT9vRoWrHiBL5AdhSv6t2TE2H6ibJpdCl
 p68rIyAjDb2utiP/55TJ6oBwgN3RN4KrOJWG1SahcJy8MdBotUcZ8q1hv13NCVGsVUcCGZpPk+M
 Ml8HxdPTsYfTkrXzFp18PirIaQllHDZ3A=
X-Gm-Gg: AR+sD10VRfF2oagdzUtERffUItIZJFkgXN9/Nu9k4bYSx3C74LdsBfJD9iBwb48Ea/W
 9tkk8GT06Oy/xnjYQMlwvyhYiPijDqZ98wQn6+gN7qr2vRZ/SZB8VOS53uauxXODNG7SoLSlYQL
 npO7tdCD9orFAe8I4P11p+cd6M2Td0/Pl3/M7flHP5OcH0B4X0YMC2TSoQtynCR2c1Zghf9pCae
 o/rJ7iXHkN+Qs7cRXZZqscv9lei9fCwlOFFATL4VUI9u8LIXiXN0Rj4X2wmafn9hNA20ldBfpgg
 kQ==
X-Received: by 2002:a05:6a00:a207:b0:848:420a:9ce0 with SMTP id
 d2e1a72fcca58-84e930c8412mr4229063b3a.6.1785276227671; 
 Tue, 28 Jul 2026 15:03:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:a207:b0:848:420a:9ce0 with SMTP id
 d2e1a72fcca58-84e930c8412mr4229016b3a.6.1785276226986; Tue, 28 Jul 2026
 15:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260728101523.3041854-1-marcandre.lureau@redhat.com>
 <a661b28d-8656-4e27-8038-e7b360e550b8@rsg.ci.i.u-tokyo.ac.jp>
 <CAMxuvazu9g-M7EvHZAS3_Wbd0m0s8p0BuZbwLJZm9XBuEbrhBg@mail.gmail.com>
 <6192257c-a6cc-4309-a3e2-be86ef0b3904@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <6192257c-a6cc-4309-a3e2-be86ef0b3904@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 29 Jul 2026 02:03:35 +0400
X-Gm-Features: AUfX_myunQmPC5bnORzfUAser0BBIAQZMctma4EQ6V4W0EW7OIv_aQBixSiPkF0
Message-ID: <CAMxuvawYy4YKwyH6CD0f9PwYQ=Zi01NjxLF0VcPRoiGPrvwjDw@mail.gmail.com>
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

Hi Akihiko

On Tue, Jul 28, 2026 at 11:17=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/07/28 23:33, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Jul 28, 2026 at 6:28=E2=80=AFPM Akihiko Odaki
> > <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >>
> >> On 2026/07/28 19:15, marcandre.lureau@redhat.com wrote:
> >>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>>
> >>> Use g_try_malloc/g_try_new0 for guest-controlled allocation, so failu=
re
> >>> returns an error to the guest rather than crashing the host (glib
> >>> behaviour).
> >>>
> >>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3898
> >>>
> >>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>> ---
> >>> Based-on: <20260710134720.2317856-1-marcandre.lureau@redhat.com> ("[P=
ATCH] vhost-user-gpu: fix integer overflow in buffer allocation")
> >>> v2:
> >>>    - accept NULL 0-size allocations
> >>> ---
> >>>    contrib/vhost-user-gpu/vhost-user-gpu.c | 25 +++++++++++++++++----=
----
> >>>    contrib/vhost-user-gpu/virgl.c          |  6 +++++-
> >>>    contrib/vhost-user-gpu/vugbm.c          |  5 ++++-
> >>>    hw/display/virtio-gpu-rutabaga.c        | 14 ++++++++++++--
> >>>    hw/display/virtio-gpu-virgl.c           |  6 +++++-
> >>>    hw/display/virtio-gpu.c                 |  5 ++++-
> >>>    6 files changed, 47 insertions(+), 14 deletions(-)
> >>>
> >>> diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-=
user-gpu/vhost-user-gpu.c
> >>> index ee9858c397ce..0fd115300425 100644
> >>> --- a/contrib/vhost-user-gpu/vhost-user-gpu.c
> >>> +++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
> >>> @@ -487,7 +487,7 @@ vg_create_mapping_iov(VuGpu *g,
> >>>                          struct virtio_gpu_ctrl_command *cmd,
> >>>                          struct iovec **iov)
> >>>    {
> >>> -    struct virtio_gpu_mem_entry *ents;
> >>> +    g_autofree struct virtio_gpu_mem_entry *ents =3D NULL;
> >>>        size_t esize, s;
> >>>        int i;
> >>>
> >>> @@ -498,17 +498,22 @@ vg_create_mapping_iov(VuGpu *g,
> >>>        }
> >>>
> >>>        esize =3D sizeof(*ents) * ab->nr_entries;
> >>> -    ents =3D g_malloc(esize);
> >>> +    ents =3D g_try_malloc(esize);
> >>> +    if (!ents && esize) {
> >>> +        return -1;
> >>> +    }
> >>>        s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
> >>>                       sizeof(*ab), ents, esize);
> >>>        if (s !=3D esize) {
> >>>            g_critical("%s: command data size incorrect %zu vs %zu",
> >>>                       __func__, s, esize);
> >>> -        g_free(ents);
> >>>            return -1;
> >>>        }
> >>>
> >>> -    *iov =3D g_new0(struct iovec, ab->nr_entries);
> >>> +    *iov =3D g_try_new0(struct iovec, ab->nr_entries);
> >>> +    if (!*iov && ab->nr_entries) {
> >>> +        return -1;
> >>> +    }
> >>>        for (i =3D 0; i < ab->nr_entries; i++) {
> >>>            uint64_t len =3D ents[i].length;
> >>>            (*iov)[i].iov_len =3D ents[i].length;
> >>> @@ -517,12 +522,10 @@ vg_create_mapping_iov(VuGpu *g,
> >>>                g_critical("%s: resource %d element %d",
> >>>                           __func__, ab->resource_id, i);
> >>>                g_free(*iov);
> >>> -            g_free(ents);
> >>>                *iov =3D NULL;
> >>>                return -1;
> >>>            }
> >>>        }
> >>> -    g_free(ents);
> >>>        return 0;
> >>>    }
> >>>
> >>> @@ -828,8 +831,14 @@ vg_resource_flush(VuGpu *g,
> >>>                    PIXMAN_FORMAT_BPP(pixman_image_get_format(res->ima=
ge)) / 8;
> >>>                size_t size =3D width * height * bpp;
> >>>
> >>> -            void *p =3D g_malloc(VHOST_USER_GPU_HDR_SIZE +
> >>> -                               sizeof(VhostUserGpuUpdate) + size);
> >>> +            void *p =3D g_try_malloc(VHOST_USER_GPU_HDR_SIZE +
> >>> +                                   sizeof(VhostUserGpuUpdate) + size=
);
> >>> +            if (!p) {
> >>> +                pixman_region_fini(&region);
> >>> +                pixman_region_fini(&finalregion);
> >>> +                cmd->error =3D VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> >>> +                break;
> >>> +            }
> >>>                VhostUserGpuMsg *msg =3D p;
> >>>                msg->request =3D VHOST_USER_GPU_UPDATE;
> >>>                msg->size =3D sizeof(VhostUserGpuUpdate) + size;
> >>> diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/=
virgl.c
> >>> index 550fd03bf5c4..20bae57d0fe4 100644
> >>> --- a/contrib/vhost-user-gpu/virgl.c
> >>> +++ b/contrib/vhost-user-gpu/virgl.c
> >>> @@ -209,7 +209,11 @@ virgl_cmd_submit_3d(VuGpu *g,
> >>>            return;
> >>>        }
> >>>
> >>> -    buf =3D g_malloc(cs.size);
> >>> +    buf =3D g_try_malloc(cs.size);
> >>> +    if (!buf && cs.size) {
> >>> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> >>> +        return;
> >>> +    }
> >>>        s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
> >>>                       sizeof(cs), buf, cs.size);
> >>>        if (s !=3D cs.size) {
> >>> diff --git a/contrib/vhost-user-gpu/vugbm.c b/contrib/vhost-user-gpu/=
vugbm.c
> >>> index 710d54529779..e2d8385fd857 100644
> >>> --- a/contrib/vhost-user-gpu/vugbm.c
> >>> +++ b/contrib/vhost-user-gpu/vugbm.c
> >>> @@ -13,7 +13,10 @@
> >>>    static bool
> >>>    mem_alloc_bo(struct vugbm_buffer *buf)
> >>>    {
> >>> -    buf->mmap =3D g_malloc((uint64_t)buf->width * buf->height * 4);
> >>> +    buf->mmap =3D g_try_malloc((uint64_t)buf->width * buf->height * =
4);
> >>> +    if (!buf->mmap && buf->width && buf->height) {
> >>> +        return false;
> >>> +    }
> >>>        buf->stride =3D buf->width * 4;
> >>>        return true;
> >>>    }
> >>> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu=
-rutabaga.c
> >>> index e28aad94eead..60f64d9a8fa7 100644
> >>> --- a/hw/display/virtio-gpu-rutabaga.c
> >>> +++ b/hw/display/virtio-gpu-rutabaga.c
> >>> @@ -360,10 +360,20 @@ rutabaga_cmd_submit_3d(VirtIOGPU *g,
> >>>            return;
> >>>        }
> >>>
> >>> -    buf =3D g_new0(uint8_t, cs.size);
> >>> +    buf =3D g_try_new0(uint8_t, cs.size);
> >>> +    if (!buf && cs.size) {
> >>> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> >>> +        return;
> >>> +    }
> >>>        s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
> >>>                       sizeof(cs), buf, cs.size);
> >>> -    CHECK(s =3D=3D cs.size, cmd);
> >>> +    if (s !=3D cs.size) {
> >>> +        qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                      "%s: size mismatch (%zu/%u)\n",
> >>> +                      __func__, s, cs.size);
> >>> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> >>> +        return;
> >>> +    }
> >>>
> >>>        rutabaga_cmd.ctx_id =3D cs.hdr.ctx_id;
> >>>        rutabaga_cmd.cmd =3D buf;
> >>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-vi=
rgl.c
> >>> index d9e5b0110497..028ab776df6a 100644
> >>> --- a/hw/display/virtio-gpu-virgl.c
> >>> +++ b/hw/display/virtio-gpu-virgl.c
> >>> @@ -615,7 +615,11 @@ static void virgl_cmd_submit_3d(VirtIOGPU *g,
> >>>            return;
> >>>        }
> >>>
> >>> -    buf =3D g_malloc(cs.size);
> >>> +    buf =3D g_try_malloc(cs.size);
> >>> +    if (!buf && cs.size) {
> >>> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> >>> +        return;
> >>> +    }
> >>>        s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
> >>>                       sizeof(cs), buf, cs.size);
> >>>        if (s !=3D cs.size) {
> >>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> >>> index 8607d0c0b581..9bacd38b4521 100644
> >>> --- a/hw/display/virtio-gpu.c
> >>> +++ b/hw/display/virtio-gpu.c
> >>> @@ -892,7 +892,10 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
> >>>        }
> >>>
> >>>        esize =3D sizeof(*ents) * nr_entries;
> >>> -    ents =3D g_malloc(esize);
> >>> +    ents =3D g_try_malloc(esize);
> >>> +    if (!ents && esize) {
> >>> +        return -1;
> >>> +    }
> >>
> >> This converts the entry allocation to g_try_malloc(), but the resultin=
g
> >> mapping arrays still grow with aborting g_renew() calls.
> >> dma_memory_map() may return only part of an entry; with fragmented IOM=
MU
> >> mappings, guest-controlled entries can expand into more IOVs than
> >> nr_entries.
> >>
> >
> > The goal is not to make QEMU OOM-safe. Even when malloc returns
> > non-zero we may reach that and get killed. This patch is more a safety
> > guard for easy guest triggered allocations that can crash QEMU.
> I agree we are not going to make QEMU OOM-safe, but I'm not sure where
> we draw the line between "easy" and "hard" guest-triggered allocations.
> Even if the IOMMU mapping isn't fragmented, the data from ents is
> essentially duplicated into iov right after, doubling the allocation
> size anyway. I feel it's easier to avoid reasoning by just consistently
> using g_try_* in this function.


Ok, maybe it doesn't make sense for bounded-allocation to use g_try
then. It's true that if the IOMMU mapping is fragmented, we could end
up with an allocation that could fail. I am not sure we can do much in
this case but rather have a reasonable limit like
VIRTIO_GPU_MAX_IOV_ENTRIES (16384 * 16). Otherwise, happy to convert
to g_try_renew() for now..


