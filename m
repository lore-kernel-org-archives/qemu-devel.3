Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1C8CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHcdz-0007Bm-B5; Fri, 16 Oct 2026 03:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xHcdp-00079j-2T
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 03:46:13 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xHcdn-00047J-3K
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 03:46:12 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa377c61so7489787a12.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 00:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792136767; cv=none;
 d=google.com; s=arc-20260327;
 b=Bl1RITTs21OAPIf1yO0edGhqMgL0GjDbyJPMn9MDYnRlHl6dSjh4O45AigyLS74isl
 7xCui1VLdblhaGE9VTmAPulNV3nIFBtFn5wNVfBosIg4dE6RE/NHiPKgfD6UANWDshZR
 NBdm+/BR3AUVnXhqVx3PcqkVrjeiVMpXqBYIRDU9DYaI/S6/eN+temq0ikuVwba4m9h8
 3j6fxgygq9xjNnYEwxIFlRImQlWt22Jb22qIgCOUgNH1dyBHFg+bvfGVLzXHsxdsBw51
 UO9bCcVh6B5+0CLFZVAnVZzjr4gpUutR+YUCsm3u/EqdcfX4vLnDvXSy2ZYPewuhKG+U
 7pqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=dWshOP8vnrAxbyRS/QN38SaLQ7rjqxT4inF1al0mW7E=;
 fh=CVGpmR9kGStmGjkZNzUi0dwX6VeM01tVLIBWEMjFAsA=;
 b=Y5yn3Bu+FG4FpnuiXJIKfDk6NLMEjtmc1xxwBUDwTHVh3mn/fk1A+nQweSpPRUvGak
 NcRXrCPJeqIBnsBLg64x+to80iFD8AkrS9PuUK6Z1bJ+u7hkM/oxrA/QnTEMJqUynyG4
 ru3iZa1HzzXOOVo2Ws4X57CTMttwvWLwi+j4PAexID7BFIaCukp3e36Hd0hBse54gZ0x
 1nZNdBFCz7siGjWBBn1PdxnOwy1De3Ww04Sh1PhlE3MRyJM/Bax5YnEBeO5uj1hAqcts
 /RDa64mPdIPvOABeM83Q0p/svhJg6GTM3M26jZoBorWcB0Z7rIx60AiTY1DXwYR3s0iE
 CLnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792136767; x=1792741567; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dWshOP8vnrAxbyRS/QN38SaLQ7rjqxT4inF1al0mW7E=;
 b=AAnWMq/gK/z3bqcgNglCeSyjwGMKK+pSZYsyCIj74yKi3xsLOiVc35EEx2em6Q7uoo
 57zzaecn5aGflyISOjZdwMCzfMxdHv4yD40M1ezseaqevoxqGvXKG7bCUwOv/n4jZMsK
 pcH3Y81Swy0c3Ujqm2v0rb6Aaiqd21V0Eo/1deMIWER5XKOwNNiq0ILtKJH4piXk+flI
 wdyuPKPT7iiPczNSyRKFuEBdbhpGF4IausyXtQpEEYCIoB2w4BsKVGU1FupmFeKMoaE8
 APIwgRHk8FkkCFXenceRWFjo1cFkT8xlVanXO8cbxK0xCBjDu781AO0uHq4nlm+LwfiY
 6tRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792136767; x=1792741567;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dWshOP8vnrAxbyRS/QN38SaLQ7rjqxT4inF1al0mW7E=;
 b=A42cNgMj5QXNzJxCWfl+upI+P5vR0GKKvXl3XKd3GzwwCbSBvGtepgUDPaAtrtnSCX
 CRZrEe311i0CZCq+Ule0brjZJtJyP0vIQ/mkHXyTHP7nUMypRxfCiJLhGiBNslpLiXsz
 5epe91HjJIlGT4LFALV/30+PoVOr1JSh+Nn8dVMeFsAJl3noxJnMeRB2lrL5y54rCEz4
 F2F/nDLrZxOYe7WJjyYIi71BzZnEAYvZQdntIr7f6fz2JLbOQdxl2xZJIC2z4HqdjnKj
 fCBNYdieoNNNZ4Kw3AnFMymUnxHyyyuhtWEvlQwRbAKxzmiIWLkOh+A+PR4fxiJF8eV/
 WZRQ==
X-Gm-Message-State: AFq9FYI6aUW5wJ+JbhsfyuxzgSA2zqJB1w2zOEJUtMjcMVCFxD90pLhI
 KALjJePVlMT74CyKeYDvUEh9gfEVi8YRorlC0BsQwlhs+eQfXoXxrhlkcRQR4IPU2OpbCU8znD9
 aVWVNkBG1lVw2TBtIJmBs1bi/H2eVhbI=
X-Gm-Gg: AYBFou2hR0behBLFxeRhUHlzaj3VWYYWhMF/5eQxCHEsQ26jL5sZdBN45kAyRoO25cF
 q5vqXnq7EfuxXFVK6LCAhtceVterd0+0XLwaJ9cshspEr1u5cc2+yiXOKHUAV3J0HRbgl1joIWo
 RudJH3jhNRrQB96DTIU0Jz6EBBg5bWsANGpIwRXkUalKIiYgQKqGEiIvzVmAKwH7j11cAMnrnuq
 negWcKIZnsPwKQXZpX3h3Z52cerUkOr7FrTuzEHKRtcdJN0ps8LqPS/RTVPf4SGRUvBMnRoPjiN
 8pi+Ny/m9KVxpMj6s9R7ULAUiyPO4Ps+w5babB/wqSptdJDalp5T/BE=
X-Received: by 2002:a05:6402:21d2:b0:6af:e26c:f6ad with SMTP id
 4fb4d7f45d1cf-6b17c27d33amr13141437a12.39.1792136766714; Fri, 16 Oct 2026
 00:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20261014094224.1976-1-luoyonggang@gmail.com>
 <6da8ceed-7ff4-497b-9499-a0d5d3925e15@kernel.org>
In-Reply-To: <6da8ceed-7ff4-497b-9499-a0d5d3925e15@kernel.org>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 16 Oct 2026 15:45:53 +0800
X-Gm-Features: AclHuK_kKqMANioqEfV05t7_Ls7bgGJG-gMqc2WRcSVav3Ha0Uuqpc9uQpe_ty8
Message-ID: <CAE2XoE8qJ7baHd_2xsUc4jQF8OUu0_epDc2GMLUH1YtVAA0=XQ@mail.gmail.com>
Subject: Re: [PATCH 16/34] hw/virtio/virtio-mem: Avoid call to target_info()
 in class_init
To: David Hildenbrand <david@kernel.org>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Cornelia Huck <cohuck@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>, Eric Blake <eblake@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Ani Sinha <anisinha@redhat.com>, qemu-s390x@nongnu.org, 
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-riscv@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, 
 Fabiano Rosas <farosas@suse.de>, Song Gao <17746591750@163.com>,
 Fam Zheng <fam@euphon.net>, 
 Markus Armbruster <armbru@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Chao Liu <chao.liu@processmission.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Darren Kenny <darren.kenny@oracle.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 16, 2026 at 3:37=E2=80=AFPM David Hildenbrand <david@kernel.org=
> wrote:
>
> On 10/14/26 11:41, Yonggang Luo wrote:
> > Done by merge virtio_mem_legacy_guests_properties into virtio_mem_prope=
rties.
> > As we already have vmem->unplugged_inaccessible handle in virtio_mem_de=
vice_realize
> > So we can reject the wrong option in virtio_mem_device_realize, then th=
e call
> > target_info() in class_init no need anymore.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  hw/virtio/virtio-mem.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> > index a4110d61312..81e2192c2fb 100644
> > --- a/hw/virtio/virtio-mem.c
> > +++ b/hw/virtio/virtio-mem.c
> > @@ -879,7 +879,11 @@ static void virtio_mem_device_realize(DeviceState =
*dev, Error **errp)
> >              break;
> >          }
> >      } else {
> > -        vmem->unplugged_inaccessible =3D ON_OFF_AUTO_ON;
> > +        if (vmem->unplugged_inaccessible !=3D ON_OFF_AUTO_ON) {
> > +            error_setg(errp, "'%s' must be 'on' on non-x86 targets",
> > +                       VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP);
> > +            return;
> > +        }
> >      }
> >
> >      if (vmem->dynamic_memslots &&
> > @@ -1568,9 +1572,6 @@ static const Property virtio_mem_properties[] =3D=
 {
> >                       early_migration, true),
> >      DEFINE_PROP_BOOL(VIRTIO_MEM_DYNAMIC_MEMSLOTS_PROP, VirtIOMEM,
> >                       dynamic_memslots, false),
> > -};
> > -
> > -static const Property virtio_mem_legacy_guests_properties[] =3D {
> >      DEFINE_PROP_ON_OFF_AUTO(VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP, Vi=
rtIOMEM,
> >                              unplugged_inaccessible, ON_OFF_AUTO_ON),
> >  };
> > @@ -1635,9 +1636,6 @@ static void virtio_mem_class_init(ObjectClass *kl=
ass, const void *data)
> >      RamDiscardSourceClass *rdsc =3D RAM_DISCARD_SOURCE_CLASS(klass);
> >
> >      device_class_set_props(dc, virtio_mem_properties);
> > -    if (virtio_mem_has_legacy_guests()) {
> > -        device_class_set_props(dc, virtio_mem_legacy_guests_properties=
);
> > -    }
> >      dc->vmsd =3D &vmstate_virtio_mem;
> >
> >      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>
> Now a property introspection shows properties that don't make any sense f=
or
> other targets.
>
> I don't see the value, really.

This is the only way I can get a usable qemu-system(single-binary),
looks ugly but I have already tried other means.

Using "is_avaiable" basically has the same effect like the one before
this change.
And renaming the QOM name would cause much more issues. I'll wait for
others to do these.
I've tried my best, sorry.

>
> --
> Cheers,
>
> David
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

