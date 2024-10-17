Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B09D2F7EF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 07:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1KUB-0000Y9-BT; Thu, 17 Oct 2024 02:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t1KU8-0000Xe-TL
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t1KU7-000279-B8
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729148386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q/i443zsBKNEHSCUusupLqTYR0Vj5FPMqVuN02srCug=;
 b=g2AkjO+dnpi2fU5tYy/mW6MDRy8pFXDHPqkaWcq4PxhdVZ5+R0362w6Zc6Lm72aRWBO7QD
 ftfqy1tOVmptUDC5B4yTWmrl8pw2aAlbaNBVwyuLhLaOlVZkgnUVqttjFL4VF4437QZzH5
 vv/LMjLHWdvsg/4RxrMvNjNpQ7oGzvA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-PUVYtZvSNlaF8UeXoOxp5g-1; Thu, 17 Oct 2024 02:59:44 -0400
X-MC-Unique: PUVYtZvSNlaF8UeXoOxp5g-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7174c6cbdbaso693121b3a.2
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 23:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729148383; x=1729753183;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q/i443zsBKNEHSCUusupLqTYR0Vj5FPMqVuN02srCug=;
 b=YbLJc3go2Xq9PUPV3/lJBuEvcIaztmmKuDALzsUSnx+VBHKYhPH7e4leZ1hQ12v7Vz
 d1VnJSgaQ8gX2yjbTchCQcE+Jh/gPQBWZE+XZdrgWbJ5TsoWCskWy5SppgL3HhY3bxxB
 ahH+PBLORk1K0bUJxaQlgi5aglCBLxH/7/ulO/DQ+3nLZZHZ3WK6sIDm9UtvPT4LEdT+
 xKWQN1DBfCoKRZwQ3EEX5be1QLSgsk5DySApri5mGC7NLmf551HbZ8NiddCzY2MxTGdT
 UFFeHqwemKgvpCh/oZm2gqh//2C5QfPw/CQgaL0IYjRzS9pryQ9w2v75xAZiw3aCI3Mh
 m6qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjBa/N0BXsW2l/q/gbzKY2No4cvkJ3i3zsaRXvfphsM5DTErTlTaOexsKSIku6k3fhTLBU+6vVld7u@nongnu.org
X-Gm-Message-State: AOJu0YyIuw4tdRdSIV1meORVEoH+yxfp+SLKiiO5ApUvpLR0xIaOIPxF
 hqpNqdrHxlzruByxtGQJcM/BqfrxtSXbyepHnMwwoFcWlenJB9EwnMhGzgeAl/PNYHsYK9mwCHc
 /JZudtOpL692+VaOgnwh/mfzE8Dc+Fw4vZgWTwjzw7TMukgAgtjyYJ1o5BYCOMPXOtZenacHxFN
 oZuVMsVx4nNzvGPSAkbU23EFPPEtYM8gIYOxcsY/Uj
X-Received: by 2002:a05:6a00:10cf:b0:71e:7294:bbc4 with SMTP id
 d2e1a72fcca58-71e7294be2amr13035429b3a.13.1729148382976; 
 Wed, 16 Oct 2024 23:59:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbCBXQ/YOubV6/a2hxvZ5Fau+X5ogdDodT3ogVAiHXl0s46nE4AXF0L1knH0+XHEINuTRcVqRT7Ecli6lwg/Q=
X-Received: by 2002:a05:6a00:10cf:b0:71e:7294:bbc4 with SMTP id
 d2e1a72fcca58-71e7294be2amr13035417b3a.13.1729148382561; Wed, 16 Oct 2024
 23:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240604073755.1859-1-jasowang@redhat.com>
 <20240604073755.1859-9-jasowang@redhat.com>
 <a46a895a-4961-43fa-99d8-3bda7612bb9a@redhat.com>
 <14bcc2cf-f934-4aa3-8cab-21803a930adc@redhat.com>
In-Reply-To: <14bcc2cf-f934-4aa3-8cab-21803a930adc@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Oct 2024 14:59:31 +0800
Message-ID: <CACGkMEs5P=Gmo4xTbwH1SPTjwjMoeAcK+fiVXQE0BRrRh-hAwg@mail.gmail.com>
Subject: Re: [PULL 08/20] virtio-net: Add only one queue pair when realizing
To: Laurent Vivier <lvivier@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 14, 2024 at 11:16=E2=80=AFPM Laurent Vivier <lvivier@redhat.com=
> wrote:
>
> On 14/10/2024 10:30, Laurent Vivier wrote:
> > Hi Akihiko,
> >
> > On 04/06/2024 09:37, Jason Wang wrote:
> >> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>
> >> Multiqueue usage is not negotiated yet when realizing. If more than
> >> one queue is added and the guest never requests to enable multiqueue,
> >> the extra queues will not be deleted when unrealizing and leak.
> >>
> >> Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the guest do=
esn't support
> >> multiqueue")
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >> ---
> >>   hw/net/virtio-net.c | 4 +---
> >>   1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >> index 3cee2ef3ac..a8db8bfd9c 100644
> >> --- a/hw/net/virtio-net.c
> >> +++ b/hw/net/virtio-net.c
> >> @@ -3743,9 +3743,7 @@ static void virtio_net_device_realize(DeviceStat=
e *dev, Error **errp)
> >>       n->net_conf.tx_queue_size =3D MIN(virtio_net_max_tx_queue_size(n=
),
> >>                                       n->net_conf.tx_queue_size);
> >> -    for (i =3D 0; i < n->max_queue_pairs; i++) {
> >> -        virtio_net_add_queue(n, i);
> >> -    }
> >> +    virtio_net_add_queue(n, 0);
> >>       n->ctrl_vq =3D virtio_add_queue(vdev, 64, virtio_net_handle_ctrl=
);
> >>       qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
> >
> > This change breaks virtio net migration when multiqueue is enabled.
> >
> > I think this is because virtqueues are half initialized after migration=
 : they are
> > initialized on guest side (kernel is using them) but not on QEMU side (=
realized has only
> > initialized one). After migration, they are not initialized by the call=
 to
> > virtio_net_set_multiqueue() from virtio_net_set_features() because virt=
io_get_num_queues()
> > reports already n->max_queue_pairs as this value is coming from the sou=
rce guest memory.
> >
> > I don't think we have a way to half-initialize a virtqueue (to initiali=
ze them only on
> > QEMU side as they are already initialized on kernel side).
> >
> > I think this change should be reverted to fix the migration issue.
> >
>
> Moreover, if I look in the code of virtio_load() and virtio_add_queue() w=
e can guess it's
> not correct to migrate a virtqueue that is not initialized on the destina=
tion side because
> fields like 'vdev->vq[i].handle_output' or 'vdev->vq[i].used_elems' canno=
t be initialized
> by virtio_load() and neither by virtio_add_queue() after virtio_load() as=
 fields like
> 'vring.num' are already initialized by virtio_load().
>
> For instance, in virtio_load() we set:
>
>      for (i =3D 0; i < num; i++) {
>          vdev->vq[i].vring.num =3D qemu_get_be32(f);
>
> and in virtio_add_queue() we search for the firt available queue to add w=
ith:
>
>      for (i =3D 0; i < VIRTIO_QUEUE_MAX; i++) {
>          if (vdev->vq[i].vring.num =3D=3D 0)
>              break;
>      }
>
> So virtio_add_queue() cannot be used to set:
>
>      vdev->vq[i].handle_output =3D handle_output;
>      vdev->vq[i].used_elems =3D g_new0(VirtQueueElement, queue_size);
>
> Moreover it would overwrite fields already set by virtio_load():
>
>      vdev->vq[i].vring.num =3D queue_size;
>      vdev->vq[i].vring.align =3D VIRTIO_PCI_VRING_ALIGN;
>
> It also explains why virtio_net_change_num_queue_pairs() (indirectly call=
ed by
> virtio_net_set_features()) doesn't update the queue pair numbers: vring.n=
um is already set
> so it thinks there is no more queues to add.
>
> Thanks,
> LAurent
>

I agree.

Laurent, would you like to send a patch to revert this?

Thanks

>


