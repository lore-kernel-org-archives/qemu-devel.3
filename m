Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4931EDEBF9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 22:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxXul-000139-QK; Tue, 03 Mar 2026 17:08:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxXui-00011n-U8
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:08:24 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxXuh-0007LA-6P
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:08:24 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-65f73225f45so9774427a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 14:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772575701; x=1773180501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6MMx0UmlhaY7ySCegy0MCQFJM5jOSB2EJMaj6GH8pc=;
 b=Y8dv7/4FBveNQVPeHqNkd8hF9b7/hmuu0zzDFB+Yi2kvyN4f0eg63zZnsSCY26r03K
 7c7MkYKRCsYvrsp/9sc0E2lkdG3ncvtIrFFbqikHezjvqnkBOK7cRC43RZfEhCIK2AsL
 ekVZBzNOGP53rAlNVlhkupDoa7IaCRpnSfvQtEY/CkgsIyG2WPaiLUS7Bi2yk8W8YmEs
 K2C1C4S4QdNPzWCUkTJUPWw5WbqICj6x9vkTOfu8LcOsVMfo0gnpxtfZSFjZKQsNeQgy
 wYuGplL1naqlGEaOFGbV9qTe+Zkhl+ffHN7lAPbzODQRXImhXiK3RnUI4C69uLZQBwrn
 f5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772575701; x=1773180501;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f6MMx0UmlhaY7ySCegy0MCQFJM5jOSB2EJMaj6GH8pc=;
 b=EsVXDC4DLyNUIRoIxiUc7lIGJtmCIAq028+NcGx+DGC8a9KzFy8vJQpaJejfTAof23
 LfWUNpYprn+hbBxIZncQ5jUbaWEN63PZHAc1d98PPx8a3nuakY6Bl0DG4kM6TORjqUWy
 LTYwq+kJa3oS2vqUULdhiFoFZjAG2nNNcNo/cmiLNc07dIhF66u1Fe9kwmJxYSpplSAb
 AoURrP6rIkO8Z2r9sf7fbOH7sM0ouU3bMxsuea8z0ap3NR/Sop7t/teiZBW40hKQQxps
 Sy9uCNJXUxuUa4Y1pWzx2i/iXgP6zKh963XGrNgf7hTRRwjh79dfzb/j+QjFr8Kn7LXv
 vLMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL4Pql+QpJXy6kEC1WD1pj+3N6Tx3E9/fWcvLxxLZpEGvraqUwie623hvJdrJO4JA4cFHwiMpAzbm8@nongnu.org
X-Gm-Message-State: AOJu0YwRU59PnH2ijX387Cm2jk0yw04F3/N9eIJnIwJWva7CKOHrBPCY
 Cvt8O60J+OtcDwrJskZ6bJMWIQIUpdZVgt+ymHaE6cUclv+HpVC//hfdp5PIqiSZLzQ=
X-Gm-Gg: ATEYQzyawGThL/7BAOz8yL7lPggceYt9kxlBOkVimj+1KuR3PNZJL6TDEER2KZFv2di
 fNcRjpkmeCveJId1qBhk2mBOmJEAVkJt4YqeobAqikz0t3kxvpad8NhXAPoapiWsb0llFTefOrP
 MwOFYSpDj8huNJ0DQqHyUQ+tprxDb5hqGThnPw8+jVAzlQNHiUxnQz+xaagRYsTxVUNqdAx9bpb
 /iWmRqGE/FCDddeo84AwCPkOrhi7qNBHb+8PmMyn0pJ+jlM5Fqg3IoJ9f7+7DRpanAt3aYF+q4S
 4L6tcpDpmC6P+Pa27CwSyo5CxuGDgvNaf5mceS8a7VqDgG78vRLgwmlxvLkeHbsTHgc57fATuLr
 3ozsz1JkUmr0pBTUfGHJ6bj0F47rMIBTNbhFEX+xwoN4YrqSn3II5FO68wQhSE+GEPjJKt1FTYk
 K/ifzju2CHOhHvGEqwiyLnQ3U=
X-Received: by 2002:a05:6402:27cc:b0:65c:420:d3b with SMTP id
 4fb4d7f45d1cf-65fddced83dmr9643716a12.22.1772575700983; 
 Tue, 03 Mar 2026 14:08:20 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fabf6d26dsm5068114a12.16.2026.03.03.14.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 14:08:19 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9F7625F7BE;
 Tue, 03 Mar 2026 22:08:17 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] virtio-gpu: Fix scanout dmabuf cleanup during resource
 destruction
In-Reply-To: <PH0PR11MB511250B98C5CE00CE879BB3FFA7FA@PH0PR11MB5112.namprd11.prod.outlook.com>
 (Dongwon Kim's message of "Tue, 3 Mar 2026 18:51:45 +0000")
References: <20260303010047.1925589-1-dongwon.kim@intel.com>
 <CAJ+F1CKCQiBnOncaecpgG2FXj3R2tjxYOe8z7r8rGqCBAo97=g@mail.gmail.com>
 <PH0PR11MB511250B98C5CE00CE879BB3FFA7FA@PH0PR11MB5112.namprd11.prod.outlook.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Tue, 03 Mar 2026 22:08:17 +0000
Message-ID: <87fr6gr2ge.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

"Kim, Dongwon" <dongwon.kim@intel.com> writes:

> Hi Marc-Andr=C3=A9,
>
>> -----Original Message-----
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
>> Sent: Tuesday, March 3, 2026 8:28 AM
>> To: Kim, Dongwon <dongwon.kim@intel.com>
>> Cc: qemu-devel@nongnu.org
>> Subject: Re: [PATCH] virtio-gpu: Fix scanout dmabuf cleanup during resou=
rce
>> destruction
>>=20
>> Hi
>>=20
>> On Tue, Mar 3, 2026 at 2:06=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>> >
>> > From: Dongwon Kim <dongwon.kim@intel.com>
>> >
>> > When a virtio-gpu resource is destroyed, any associated udmabuf must
>> > be properly torn down. Currently, the code may leave dangling
>> > references to dmabuf file descriptors in the scanout primary buffers.
>> >
>> > This patch updates virtio_gpu_fini_udmabuf to:
>> > 1. Iterate through all active scanouts.
>> > 2. Identify dmabufs that match the resource's file descriptor.
>> > 3. Close the dmabuf and invalidate the resource's FD reference to
>> >    prevent use-after-free or double-close scenarios.
>> > 4. Finally, trigger the underlying udmabuf destruction.
>> >
>> > This ensures that the display backend does not attempt to access
>> > memory or FDs that have been released by the guest or the host.
>> >
>> > Cc: Gerd Hoffmann <kraxel@redhat.com>
>> > Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>> > Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
>>=20
>> Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>=20
>> > ---
>> >  include/hw/virtio/virtio-gpu.h  |  3 ++-
>> > hw/display/virtio-gpu-udmabuf.c | 25 ++++++++++++++++++-------
>> >  hw/display/virtio-gpu.c         |  2 +-
>> >  3 files changed, 21 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/include/hw/virtio/virtio-gpu.h
>> > b/include/hw/virtio/virtio-gpu.h index 58e0f91fda..65312f869d 100644
>> > --- a/include/hw/virtio/virtio-gpu.h
>> > +++ b/include/hw/virtio/virtio-gpu.h
>> > @@ -357,7 +357,8 @@ bool virtio_gpu_scanout_blob_to_fb(struct
>> > virtio_gpu_framebuffer *fb,
>> >  /* virtio-gpu-udmabuf.c */
>> >  bool virtio_gpu_have_udmabuf(void);
>> >  void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res);
>> > -void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res);
>> > +void virtio_gpu_fini_udmabuf(VirtIOGPU *g,
>> > +                             struct virtio_gpu_simple_resource *res);
>> >  int virtio_gpu_update_dmabuf(VirtIOGPU *g,
>> >                               uint32_t scanout_id,
>> >                               struct virtio_gpu_simple_resource *res,
>> > diff --git a/hw/display/virtio-gpu-udmabuf.c
>> > b/hw/display/virtio-gpu-udmabuf.c index d804f321aa..bd5b44f5fb 100644
>> > --- a/hw/display/virtio-gpu-udmabuf.c
>> > +++ b/hw/display/virtio-gpu-udmabuf.c
>> > @@ -151,13 +151,6 @@ void virtio_gpu_init_udmabuf(struct
>> virtio_gpu_simple_resource *res)
>> >      res->blob =3D pdata;
>> >  }
>> >
>> > -void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res)
>> > -{
>> > -    if (res->remapped) {
>> > -        virtio_gpu_destroy_udmabuf(res);
>> > -    }
>> > -}
>> > -
>> >  static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)
>> > {
>> >      struct virtio_gpu_scanout *scanout; @@ -169,6 +162,24 @@ static
>> > void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)
>> >      g_free(dmabuf);
>> >  }
>> >
>> > +void virtio_gpu_fini_udmabuf(VirtIOGPU *g, struct
>> > +virtio_gpu_simple_resource *res) {
>> > +    int max_outputs =3D g->parent_obj.conf.max_outputs;
>> > +    int i;
>> > +
>> > +    for (i =3D 0; i < max_outputs; i++) {
>> > +        VGPUDMABuf *dmabuf =3D g->dmabuf.primary[i];
>> > +
>> > +        if (dmabuf && (res->dmabuf_fd !=3D -1) &&
>>=20
>> Maybe add qemu_dmabuf_get_numplanes() > 0 ?
>
> Do you want me to add this condition and resubmit v2 of this patch? I saw
> this patch has already been in the queue.

If you send v2 I can swap it out.
>
>>=20
>> > +            qemu_dmabuf_get_fds(dmabuf->buf, NULL)[0] =3D=3D res->dma=
buf_fd) {
>> > +            qemu_dmabuf_close(dmabuf->buf);
>> > +            res->dmabuf_fd =3D -1;
>>=20
>> I am not really happy about that we close the underlying fd here before =
the
>> next destroy, but I don't have an immediate solution
>
> Yeah, I just thought this would be the best for now.
>
>>=20
>> > +        }
>> > +    }
>> > +
>> > +    virtio_gpu_destroy_udmabuf(res);
>> > +}
>> > +
>> >  static VGPUDMABuf
>> >  *virtio_gpu_create_dmabuf(VirtIOGPU *g,
>> >                            uint32_t scanout_id, diff --git
>> > a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c index
>> > 643e91ca2a..b2af861f0d 100644
>> > --- a/hw/display/virtio-gpu.c
>> > +++ b/hw/display/virtio-gpu.c
>> > @@ -902,7 +902,7 @@ void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
>> >      res->addrs =3D NULL;
>> >
>> >      if (res->blob) {
>> > -        virtio_gpu_fini_udmabuf(res);
>> > +        virtio_gpu_fini_udmabuf(g, res);
>> >      }
>> >  }
>> >
>> > --
>> > 2.43.0
>> >
>> >
>>=20
>>=20
>> --
>> Marc-Andr=C3=A9 Lureau
>
> Thanks,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

