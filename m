Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B5FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 22:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH8pR-0006xx-9e; Mon, 19 May 2025 18:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>)
 id 1uH8pM-0006xL-Fi; Mon, 19 May 2025 18:19:20 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>)
 id 1uH8pG-0003P8-DR; Mon, 19 May 2025 18:19:20 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5fff52493e0so5777741a12.3; 
 Mon, 19 May 2025 15:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747693151; x=1748297951; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=trAVbXqldHEwKdmbSU91X8t495ZSX1SEg4fDq1voX6k=;
 b=JenKuAfFfYOnsE7XqkC/oUpV38pv8AQCKtYHDlbALur9Ft2Be6mA36JXSbAz8ADiA7
 tpIE7IP0DqNa1ImQEnHixUHPsPeqLBX5b4+ZCEakBJR+Ep+GvjIiehRm4ZkVS6eXOf3d
 1xKuC8MHixbi0UtSToj0BaDfyf+ucoilnC7U4DV4pk2lsTXDVAne1Z3P9i4NWOd5Iv0r
 VIe1GiZy3NxMcUnYYfltitCJ0CGFypDCMJHly9cDmssP3q1nE2/8kYQOVebEEJ5oUV3T
 xpMlQuHHsrb34Ea9VN6HNz914ehr5FQqFWR7TCt73mTTKZVPOkZ8OpojrLVksSVEVak4
 4dWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747693151; x=1748297951;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=trAVbXqldHEwKdmbSU91X8t495ZSX1SEg4fDq1voX6k=;
 b=mc+WoPKP4V/b3KQFtjn0sogky++J0qgEBTTRfQcXSX1VnAdSmK4gRXVbRzyqo75OcR
 8xrPSwhOStsfK7eJzmOv5FE09inj3OgcIapA2hkb0siYbMQSMm7JRwEcCRJN6cdi6Erx
 +8JVualrw7+eJEovOQHRKiq3lNUqlkLs6c/hOW4BpWqDE2gx0TRceDTf3/dphrOvtvuf
 U8OuwqY2h/dJR5g47L/uW4fXQSKLCpDBQBAt/pknSnQQTepM5EwnhTqIwk8Xm8CY9T8p
 wjdGoqiD02OYDO3wHJrGIEdW+VSnf13cIJKoHpyaeoAS6Cug4QE+Zwasv6h7wwYA79Ur
 99Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWle03ORYZnJkyxsXTBSR0Oip498OExZuXWwaw5RDknn0ZFjZBbYNRZuPfDOIYW/hWYXd3SxKOaMlQvGA==@nongnu.org
X-Gm-Message-State: AOJu0Yy/s6clPeTa9/ekGT65vIRQACRGdkgNg6ASwnO1BCG1gxmbao/n
 MjeWYqLtibO0YSsBEHkidsKMUzx/9HJ5hECIaMaYE+0z7glxAorLWrWC4z7KunWaLkSqqB/zmFp
 /HGDJiLyeqtAkML+wov5jwsTGx+XFDSM=
X-Gm-Gg: ASbGncs10Nv2r0UJgXJ/AOBjFQ2QAY/OSwD2sOrkQCc3eBbxBwInUSJG0X8HkxkS5dh
 QIt0MZSjuDrHDtOOODbdfa7FVgyWMWsOVw18soDt58auTRrhmW31dBgyFOSdGjad3vx7GGsNheO
 2n7mwJwXAZNXYwZhjbkz8wKWNhKe/C5jenGIEtEwGC5RNN2kI8rhFgEwa4mYShp2e4Qg==
X-Google-Smtp-Source: AGHT+IGKgiNExdHhOpXYhjLMFgym4FoxA/D1u75HhRPO0/XkJwYqZ1Oq24cr50IsgTTxJAuT/xHv83ack69ZW9W/Y2M=
X-Received: by 2002:a05:6402:5250:b0:601:e653:b6e0 with SMTP id
 4fb4d7f45d1cf-601e653b9a5mr5099866a12.33.1747693150754; Mon, 19 May 2025
 15:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250518152651.334115-1-zzyiwei@gmail.com>
 <6420d58e-ab55-448b-a860-889d3fed04a2@collabora.com>
In-Reply-To: <6420d58e-ab55-448b-a860-889d3fed04a2@collabora.com>
From: Yiwei Zhang <zzyiwei@gmail.com>
Date: Mon, 19 May 2025 15:20:36 -0700
X-Gm-Features: AX0GCFsnO2zJa4z5Ohe7MF8GxI2sVB9jargTfE3ylcrA-SLyMYIXEbo8B05bqQ4
Message-ID: <CAJ+hS_j14ZY97rLgWQ5-F+Yiw8cY-pXABNSBNYCto7dNA9qHdA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-gpu: support context init multiple timeline
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: qemu-devel@nongnu.org, balaton@eik.bme.hu, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=zzyiwei@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, May 19, 2025 at 6:12=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 5/18/25 18:26, Yiwei Zhang wrote:
> > Venus and later native contexts have their own fence context along with
> > multiple timelines within. Fences wtih VIRTIO_GPU_FLAG_INFO_RING_IDX in
> > the flags must be dispatched to be created on the target context. Fence
> > signaling also has to be handled on the specific timeline within that
> > target context.
> >
> > Before this change, venus fencing is completely broken if the host
> > driver doesn't support implicit fencing with external memory objects.
> > Frames can go backwards along with random artifacts on screen if the
> > host driver doesn't attach an implicit fence to the render target. The
> > symptom could be hidden by certain guest wsi backend that waits on a
> > venus native VkFence object for the actual payload with limited present
> > modes or under special configs. e.g. x11 mailbox or xwayland.
> >
> > After this change, everything related to venus fencing starts making
> > sense. Confirmed this via guest and host side perfetto tracing.
> >
> > Changes since v1:
> > - Minor commit msg updates based on feedbacks from BALATON
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 94d0ea1c1928 ("virtio-gpu: Support Venus context")
> > Signed-off-by: Yiwei Zhang <zzyiwei@gmail.com>
> > ---
> >  hw/display/virtio-gpu-virgl.c | 44 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >
> > diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virg=
l.c
> > index 145a0b3879..94ddc01f91 100644
> > --- a/hw/display/virtio-gpu-virgl.c
> > +++ b/hw/display/virtio-gpu-virgl.c
> > @@ -970,6 +970,15 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
> >      }
> >
> >      trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.ty=
pe);
> > +#if VIRGL_VERSION_MAJOR >=3D 1
> > +    if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
> > +        virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id,
> > +                                            VIRGL_RENDERER_FENCE_FLAG_=
MERGEABLE,
> > +                                            cmd->cmd_hdr.ring_idx,
> > +                                            cmd->cmd_hdr.fence_id);
> > +        return;
> > +    }
> > +#endif
> >      virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.ty=
pe);
> >  }
> >
> > @@ -983,6 +992,11 @@ static void virgl_write_fence(void *opaque, uint32=
_t fence)
> >           * the guest can end up emitting fences out of order
> >           * so we should check all fenced cmds not just the first one.
> >           */
> > +#if VIRGL_VERSION_MAJOR >=3D 1
> > +        if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
> > +            continue;
> > +        }
> > +#endif
>
> Is it possible that virglrenderer will ever write a context fence in
> virgl_renderer_create_fence()? Do we really need this check?

I assume you were referring to whether a context fence can be written
in virgl_write_fence(). Yes, the fenceq contains both the global
fences and context specific fences. Without the check,
virgl_write_fence() will signal any context fence with a fence id
smaller than the latest signaled virgl global fence.

>
> --
> Best regards,
> Dmitry

