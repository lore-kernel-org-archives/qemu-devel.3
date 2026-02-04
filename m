Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5EFE95372
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnZyk-0003zn-Vf; Wed, 04 Feb 2026 05:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vnZyj-0003zR-Lp
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:19:21 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vnZyh-0007wl-Om
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:19:21 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b8871718b00so1133960666b.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 02:19:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770200356; cv=none;
 d=google.com; s=arc-20240605;
 b=guiql1XhWDiNK5Ql3P2ZMGXKykW88L75QUoRLGFDmHhgsy2J0kKLUEac5oJrEO88qh
 /CJFfLYV/L6hVprSzev2nriMzRq53j/fPSDjoqET14wbPBQn+Ofh1mAqXMyIwM+67ADu
 oGaS1mT+L9Hfdb04P25D5LUC4DRCd9rYMDuNVoHTXaoddy1O2Il0bvvXPpTY+hQ8jul2
 LBedLmAms0GXJytojC33D+YCFACwSzKXUWC87mcHEYySfSzpfHgML/a08nN6Lsc3BcJJ
 zkWYbd0TTB1DUCTy/OrYQbp5HmjHKqZzblnQc3OjPoHNpXVrhFTbCm156VxfnML3fAu5
 3r1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PRcxitAqMeNvgd553md1jtRfJ7xOtaXQbc1TsNfuSx0=;
 fh=KjKb4mtKIg6b9miUH2Ls/CMINXGMjUPQ7XuWSoe4pto=;
 b=WExVe6juulhm1IffmZ65sov3TOQpocaeT02pp2aEZQH2JqWS1qkNAIN5vpwu+1aR2Q
 7yCn8BY8hjhIJs6jNyk5jV790iKSHpLlaKkN8hgCGJ+ZG3WRJ+PRxiDDZh8nkanL1kCe
 M/w2av+/IpJBi7seBhZK38ABA/jIkGCfoKngGMYXElzw0O3iInLlY0RVUzNXStKfKeXC
 hs4aW3mf5l7JYqIm+0Cb9vNgdNd2BebkSZQkhb4645LkjWyeIjo5BUK6oh1/ORHQ29Bw
 6x0fbi9HQmGRlehOQDdCf/MfSUu4/49oYwMDwBKlBiAonc8jYOcaMoNNVlmW0hbI56J4
 PSxA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770200356; x=1770805156; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRcxitAqMeNvgd553md1jtRfJ7xOtaXQbc1TsNfuSx0=;
 b=ZNxhcZw78EF3oE5/2duBpMS9EEzsVSnlVFw40uKGjIcVrzTkeek9CkzwF+yp6ft84O
 RO0pIB3X2GvZylC+dScSgnFCJis2EJ5Rhha3MSS/og8aFhHozvncKJz512GOQ8ZVCT3V
 lVGZGQ2n/wO9y3reDCWayKVjFpBMlaNeSGwGsg+gPv45Yjug/HuSvZkUDoBgi9fj85Vr
 40xeIIHqrCxO/DnJTSfEMp1ghYio3dDCbB2IQrRcqHD2wVarnyydV61UNUb0oTTtZOlg
 XpApt7qXY0baG0E79pB2Q5NyVZngSPAYl9dSeL9g+b0H406iEUIB5ehdRoJOLdEso2eo
 XMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770200356; x=1770805156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PRcxitAqMeNvgd553md1jtRfJ7xOtaXQbc1TsNfuSx0=;
 b=dIoLPjMZVWz2s7OLbpQAYQ40OUUBLi8u73nG50eKQmLlpT3MEjgAtHNvFxl/oTpGw0
 787+laut6H81rx/lxR/gy4+VmL2fXGUxdvfoFrEHmuGVQT4zQikVQvrsYHB5UG82E6Tg
 8i/kvugH3njTWIHlDGh+JWxMxNfAGWlgudDRCCm6DT1kZEZUBKZlMlYbdKRhG+ENQSqP
 w1AZ7nlIkiYYjmk+pbFMw2GeXYG60ZwECOMSDbauco9Oh7M2lviFAbMwSVuDW1JiqYS0
 W5up5mbkNkRagfq0FrLEM4eGw2zL55ucGZWW+Ffhj8maQ+r0fi+g/sjNFtpSYd7UXZAv
 IfMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeiHWeoJWhezxGx4T1qcejk8UBB+OSDl7mQSKb/wiPPl4XPiaCIeAjZH2t47NzEJCW6fa9MIsnmjyM@nongnu.org
X-Gm-Message-State: AOJu0YxuJ6HbQBEPxTrooT3rW6NOqPRueocjh6kkGA/W70egFST8zQEz
 x1pnkjJo1NvKXXYueq/6TVgfv3pzClmSbSAPsxfkIe0tkARSFkHguWxCBm+T1uBqIdPeRqmIecN
 3651b06+2Ka8LWPH2qB/5t4kehxc36dc18rUCzp6SCw==
X-Gm-Gg: AZuq6aLHHHuWVKRlxS63rsVHJUr4fxfCCm5mowiEQ4y12fCDt4QP70Pqv/m4xeZDx8G
 mcjADCUVZ2Z0L0mbzUYNxlCujwUYrUB7iXgKJ2EPwJGbQmpEQ0+qkmlDWP9121IXVapnUcXGluX
 81bkx9thmPQPOprMDPq1axvRwSV9yb0Sc8hIFKxCHgrYGwnDejvvp812qoEYLrrqyF1xim6i4NP
 VfN1fGK477kRtOcwLptu8ElaPT7fVkv+R0lfXFH4tkF0Ru7+EDVS2qFC3IBISdtgjrRnIchN/eO
 BjzpRpoM8iMGPZVCqHG/JZM+sGZrkb9RvKp7
X-Received: by 2002:a17:907:fd18:b0:b88:6542:86a0 with SMTP id
 a640c23a62f3a-b8e9f2b3ec6mr183946366b.54.1770200356198; Wed, 04 Feb 2026
 02:19:16 -0800 (PST)
MIME-Version: 1.0
References: <tencent_66E8C146EA79CD00E966DEDAEF8CACD97D05@qq.com>
 <CAAjaMXYV5M-Zkg=1ycopGJBRpcuR5HHx6Cp0FVkws4+QR0VEug@mail.gmail.com>
 <20260203105150-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260203105150-mutt-send-email-mst@kernel.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 4 Feb 2026 12:18:49 +0200
X-Gm-Features: AZwV_QgP0rMbeHrHHxaEtvX4mwb9IqP6m4lhe-xCttoa2sHgdyx8fxgVShOnNMw
Message-ID: <CAAjaMXYyMCFtLuC6XzajjKt=E8e2Ub11inLhn4CoNOijym2wNw@mail.gmail.com>
Subject: Re: [PATCH v1] audio/virtio-snd: fix latency calc
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yanfeng Liu <yfliu2008@qq.com>, kraxel@redhat.com, qemu-devel@nongnu.org, 
 Yanfeng Liu <p-liuyanfeng9@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
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

On Tue, Feb 3, 2026 at 5:52=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Sat, Nov 15, 2025 at 12:08:07PM +0200, Manos Pitsidianakis wrote:
> > On Fri, Nov 14, 2025 at 11:35=E2=80=AFAM Yanfeng Liu <yfliu2008@qq.com>=
 wrote:
> > >
> > > Media players needs meaningful latency_bytes update but it is
> > > zero now most of the time. This adds stream-wise latency_bytes
> > > calculation so that to improve the situation.
> > >
> > > Signed-off-by: Yanfeng Liu <p-liuyanfeng9@xiaomi.com>
> > > ---
>
> Manos what do you want to do with this patch?
>

If it indeed fixes performance then the changes LGTM.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Michael, could you pick up this patch in your maintainer pull request?

> >
> > Thanks for this patch. The virtio spec doesn't adequately explain what
> > latency_bytes means, could you explain what it does and why it's
> > needed? And also what behavior in media players this patch fixes?
> >
> > Thanks again!
> >
> > >  hw/audio/virtio-snd.c         | 12 +++++++++++-
> > >  include/hw/audio/virtio-snd.h |  1 +
> > >  2 files changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> > > index 9101560f38..ed0422b45a 100644
> > > --- a/hw/audio/virtio-snd.c
> > > +++ b/hw/audio/virtio-snd.c
> > > @@ -431,6 +431,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSoun=
d *s, uint32_t stream_id)
> > >          stream->id =3D stream_id;
> > >          stream->pcm =3D s->pcm;
> > >          stream->s =3D s;
> > > +        stream->latency_bytes =3D 0;
> > >          qemu_mutex_init(&stream->queue_mutex);
> > >          QSIMPLEQ_INIT(&stream->queue);
> > >
> > > @@ -899,6 +900,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevic=
e *vdev, VirtQueue *vq)
> > >              buffer->vq =3D vq;
> > >              buffer->size =3D size;
> > >              buffer->offset =3D 0;
> > > +            stream->latency_bytes +=3D size;
> > >
> > >              QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
> > >          }
> > > @@ -1112,12 +1114,19 @@ error_cleanup:
> > >      virtio_snd_unrealize(dev);
> > >  }
> > >
> > > +static inline void update_latency(VirtIOSoundPCMStream *s, size_t us=
ed)
> > > +{
> > > +    s->latency_bytes =3D s->latency_bytes > used ?
> > > +                       s->latency_bytes - used : 0;
> > > +}
> > > +
> > >  static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
> > >                                      VirtIOSoundPCMBuffer *buffer)
> > >  {
> > >      virtio_snd_pcm_status resp =3D { 0 };
> > >      resp.status =3D cpu_to_le32(VIRTIO_SND_S_OK);
> > > -    resp.latency_bytes =3D cpu_to_le32((uint32_t)buffer->size);
> > > +    update_latency(stream, buffer->size);
> > > +    resp.latency_bytes =3D cpu_to_le32(stream->latency_bytes);
> > >      iov_from_buf(buffer->elem->in_sg,
> > >                   buffer->elem->in_num,
> > >                   0,
> > > @@ -1178,6 +1187,7 @@ static void virtio_snd_pcm_out_cb(void *data, i=
nt available)
> > >                  buffer->size -=3D size;
> > >                  buffer->offset +=3D size;
> > >                  available -=3D size;
> > > +                update_latency(stream, size);
> > >                  if (buffer->size < 1) {
> > >                      return_tx_buffer(stream, buffer);
> > >                      break;
> > > diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-=
snd.h
> > > index c176066584..9560bac8b1 100644
> > > --- a/include/hw/audio/virtio-snd.h
> > > +++ b/include/hw/audio/virtio-snd.h
> > > @@ -150,6 +150,7 @@ struct VirtIOSoundPCMStream {
> > >      } voice;
> > >      QemuMutex queue_mutex;
> > >      bool active;
> > > +    uint32_t latency_bytes;
> > >      QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
> > >  };
> > >
> > > --
> > > 2.34.1
> > >
>

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

