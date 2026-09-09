Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF05BC79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4FwE-0003Ln-Eh; Wed, 09 Sep 2026 06:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x4FwC-0003LZ-RS
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 06:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x4FwA-0003oB-O0
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 06:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788951232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TRhbnx9+CI4pjajpy371a2FMdbyb2j3Qu6kw7m0Efyw=;
 b=Le6yw09fi2YDUjfOdfnj2/ZTlM7BaJo5HAYcjOWqBtfk7GwJ2tVDYbm0glvEB1wKnBeOdN
 BzuaOT9KAcafjudDxrILUIJrLm5wjIs/jBx2S2XDLZ5WuggLJ/Xtvl+U4NNl5y1Vfi3DUB
 xIDYKl26F53Y18+iRJ3B+3eJ4AMuE1U=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-wF969zdFPSi8EL-cMZGszQ-1; Wed, 09 Sep 2026 06:53:51 -0400
X-MC-Unique: wF969zdFPSi8EL-cMZGszQ-1
X-Mimecast-MFC-AGG-ID: wF969zdFPSi8EL-cMZGszQ_1788951230
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d63bad3d09so84774005ad.3
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 03:53:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788951230; cv=none;
 d=google.com; s=arc-20260327;
 b=la5IURtYaahcrdmMSrKJPJuOkfVb3kBTqjZN1JvwZu7/Kx/IKp6xbR4q2F6R4bKEmZ
 7zPk4NvY6fAZM4T5erxhgE3sfT8nWPA6frW7E6bGHUNdlEB+PToo0FTQmhB+PPCyd0Sb
 6jdeYhRI7ISeBW/g8rzee/fb/VGWwCWA4iVLci/tgmHBN7DpiyaEN/dCtKOgs9wvy+aM
 VJDSGgbzFni7pkibRz1d0hoS71WUgdnIo4MNFB24jR5eVL5ueeAP45MhSbLiNMoq48TL
 oCvu2fxZL5PBrAgEnwPRNx0a19BKvDUA+PqVPbpfTMhjKOYvCy2fNb9iVPh1vuSFZox8
 bdSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TRhbnx9+CI4pjajpy371a2FMdbyb2j3Qu6kw7m0Efyw=;
 fh=HLSuPskybtIIysCDrrCUGCclYLaEEdtpVmqnrjAgGtQ=;
 b=GSHdnGOmKSh3IDvrzkueKrw73xLZFKYN/7eBQjhi7Nd4o28T0TJe/yqYPpuAkmr/HJ
 AqOcNWwcUthCZY1FRyQYAuOKbm/iccwWPUC7di4ZlC3iVIMIK3cIpCp9rkCwHbdoq/+H
 fFF+A0qdroVLIj2r0XC3XCSYqgx53/TbGcBRl5VLJoZQ6wC0UeW/P2oMreKqzyef/Eo5
 O5+TfRdAOU1iQJfDWKGV8Qr3ullhXeokZnKBZ/u1STm7Ug1/WklVXVuj64TkGlC18eXR
 6iidTJYw3pnlIYomu5ZS0ZBvVuBLBsaFmRrjHlc+SMspDGgNkWSGPNydwzqtQaszk8nJ
 IyXQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788951230; x=1789556030; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TRhbnx9+CI4pjajpy371a2FMdbyb2j3Qu6kw7m0Efyw=;
 b=ZFe9c03LzI6+Q1xEN1u9f45SDNy+ZqrX3DwwPa2phyG3uShPJ9hI0y069BYnpf1aA2
 mkRqnATBLyVIxya+iFNA9iGwUAt3sRDsJTOsvQWfq5UjBD8BTHUdLBWDfJhSgTywA0eq
 dwQupGsT5JHA5oPOGjTecRadiIl3p1yqxBC21LwxSbEFYoZoO5JKQQnryXRkQpzJ89EV
 dgXEduPkWXJNzEb5rHzoP1kKQtPGvhnnuiEL9gWJ8IRn/j53+uDtL9v3dGXQj1yo1m4N
 nvWlIpzuh2owHE552zpssQYD0hKRwUHSVFqa0cqbfWp9v9h/3HLrTS15l3rOjI/CRXd1
 1IeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788951230; x=1789556030;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TRhbnx9+CI4pjajpy371a2FMdbyb2j3Qu6kw7m0Efyw=;
 b=brm4Agl/YitcZpPJjWSj8WLvPeaj/0OaM0V8WXaPYscGZWW4Q8YRHaIcXos85Ko6n1
 7/IFKRbrToBsoEqrkm+tyitOm+zrcyWECpT6RDwckxWamL6xt48WhnUdGeDi8Zyb/MEl
 madOgTKH9/bUVqogdWbCuFtIWNkRaa2lVixnJQZ24ThlswPGMTv8DDPibaAVdh6IfpsM
 g55XtTvJQx7dPWtS/LHFu34HCje0YD6SKTjUNwBGOlIfdmUaC1jjpIF9K0Jd6B1AkzzW
 n9m4pt8XIrMeYfFcDR4ao/pVaKgzD/LDm1dzAxjJXjR1wSz7k4L/joupJgqxOUv+3/Fq
 UY+Q==
X-Gm-Message-State: AFuF++keInrV8D74MdOgtVxWJOQrUdr8EtCN7pxgl6G0oJ6/mVXy/xDq
 10zIsLEPRsSxdizB69smrTmlorjuuirrQqHDLFYDr5GcZoP/r5j5zgoWIf4f8160mvHpPx+b62d
 ZTvaPN1n3mEp6T0NwDmZgpwCaf3H+zyOXpHSEgi/tY9b/rDIB4jc2KK9jWma1Uim8V7duAbLZmR
 2kZlM5YJA1qtWe0yHrSfG5uj7QJ+ForPA=
X-Gm-Gg: AYBFou1TI5pxlIc29s5NGm62UeDQehsgpu8nLU/NyCf8OtQsaQ15Bj+kJBfkLN4I1L3
 9PCMkIT6o9TYbx4rIZTVmAyr28dBrJ6nX9qboL9CDy2nooFhRLWgrLM530fB1fTf1fiPNsrYXDy
 0gGtm/WHAbiGvAKyuDwZE+LrJpBM1eab6+biWzEk/dvn+2jJyvUc+8U6wHglQh+nXLblyZXpPBZ
 de3aVyZUdrMLB/A6YWa2v1n1oEgJV3uvsX9teE2uu0W0j5ns5dAA8MtpOoZ0aqhGGoscGFkeqJt
 xA==
X-Received: by 2002:a17:90b:2542:b0:398:9beb:5c17 with SMTP id
 98e67ed59e1d1-39b2620a2bfmr48035433a91.18.1788951230063; 
 Wed, 09 Sep 2026 03:53:50 -0700 (PDT)
X-Received: by 2002:a17:90b:2542:b0:398:9beb:5c17 with SMTP id
 98e67ed59e1d1-39b2620a2bfmr48035375a91.18.1788951229575; Wed, 09 Sep 2026
 03:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
 <20260904-virtio-gpu-cleanup-v2-20-15b5ae6b0023@redhat.com>
 <0699b5e3-23de-4199-9689-c5b98a7c4583@rsg.ci.i.u-tokyo.ac.jp>
 <CAJ+F1C+Ymzre7AdX=Gy66YL_OHwAgH9e06qqMNxLCvJNbt0kpA@mail.gmail.com>
 <6bed3d15-8d76-4802-b335-0615131e3572@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <6bed3d15-8d76-4802-b335-0615131e3572@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 9 Sep 2026 14:53:36 +0400
X-Gm-Features: AcwNN1UUuNadMcdJ8C1iwvRwOe_CjvnomW49eKXPNW1OOJOWXSIPT8W0HqUmiGM
Message-ID: <CAMxuvayn0crubd77DbTrbPS7Zf2phMDCEk0X6D09ZYEsKu2VNg@mail.gmail.com>
Subject: Re: [PATCH v2 20/25] virtio-gpu: consolidate disabling scanout
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson <alex@shazbot.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Sep 9, 2026 at 1:33=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/09/08 19:42, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Sep 8, 2026 at 10:46=E2=80=AFAM Akihiko Odaki
> > <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >>
> >> On 2026/09/04 22:10, Marc-Andr=C3=A9 Lureau wrote:
> >>> Use the common virtio_gpu_disable_scanout() to reset the scanout stat=
e,
> >>> including GL state if any.
> >>>
> >>> Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
> >>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>> ---
> >>>    hw/display/virtio-gpu-rutabaga.c | 4 +---
> >>>    hw/display/virtio-gpu-virgl.c    | 6 ++----
> >>>    hw/display/virtio-gpu.c          | 7 +++++--
> >>>    3 files changed, 8 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu=
-rutabaga.c
> >>> index 8a82e96b7461..8697dd6936ba 100644
> >>> --- a/hw/display/virtio-gpu-rutabaga.c
> >>> +++ b/hw/display/virtio-gpu-rutabaga.c
> >>> @@ -312,9 +312,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct vir=
tio_gpu_ctrl_command *cmd)
> >>>        scanout =3D &vb->scanout[ss.scanout_id];
> >>>
> >>>        if (ss.resource_id =3D=3D 0) {
> >>> -        scanout->resource_id =3D 0;
> >>> -        qemu_console_set_surface(scanout->con, NULL);
> >>> -        qemu_console_gl_scanout_disable(scanout->con);
> >>> +        virtio_gpu_disable_scanout(g, ss.scanout_id);
> >>>            return;
> >>>        }
> >>>
> >>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-vi=
rgl.c
> >>> index 79d4c0b569fb..87d1fc3d5f65 100644
> >>> --- a/hw/display/virtio-gpu-virgl.c
> >>> +++ b/hw/display/virtio-gpu-virgl.c
> >>> @@ -618,8 +618,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
> >>>                ss.r.x, ss.r.y, ss.r.width, ss.r.height,
> >>>                d3d_tex2d);
> >>>        } else {
> >>> -        qemu_console_set_surface(g->parent_obj.scanout[ss.scanout_id=
].con, NULL);
> >>> -        qemu_console_gl_scanout_disable(g->parent_obj.scanout[ss.sca=
nout_id].con);
> >>> +        virtio_gpu_disable_scanout(g, ss.scanout_id);
> >>>        }
> >>>        g->parent_obj.scanout[ss.scanout_id].resource_id =3D ss.resour=
ce_id;
> >>>    }
> >>> @@ -1426,8 +1425,7 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *=
g)
> >>>        int i;
> >>>
> >>>        for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
> >>> -        qemu_console_set_surface(g->parent_obj.scanout[i].con, NULL)=
;
> >>> -        qemu_console_gl_scanout_disable(g->parent_obj.scanout[i].con=
);
> >>> +        virtio_gpu_disable_scanout(g, i);
> >>>        }
> >>>    }
> >>>
> >>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> >>> index ae1f87ad68b2..cb096cb349cd 100644
> >>> --- a/hw/display/virtio-gpu.c
> >>> +++ b/hw/display/virtio-gpu.c
> >>> @@ -435,8 +435,11 @@ void virtio_gpu_disable_scanout(VirtIOGPU *g, in=
t scanout_id)
> >>>    {
> >>>        struct virtio_gpu_scanout *scanout =3D &g->parent_obj.scanout[=
scanout_id];
> >>>
> >>> -    virtio_gpu_release_scanout_dmabuf(g, scanout_id);
> >>> -
> >>> +    if (scanout->dmabuf) {
> >>> +        virtio_gpu_release_scanout_dmabuf(g, scanout_id);
> >>> +    } else {
> >>> +        qemu_console_gl_scanout_disable(scanout->con);
> >>> +    }
> >>
> >> GL needs to be always disabled when clearing a scanout.
> >>
> >
> > Ok, I removed the else condition.
> >
> > Are you going to review the remaining 1-23 patches?
> > thanks
>
> I reviewed them all. I have comments for "[PATCH v2 02/25] virtio-gpu:
> fix use-after-free on blob cursor after detach". The other patches look
> good to me.

Thanks; I'll send a v3 removing the vhost-user-gpu patch 24, leaving
only 2 patches missing an r-b.


