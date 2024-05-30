Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F93C27C44
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 02:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCVdL-0006A9-Tk; Wed, 29 May 2024 22:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sCVdK-00069z-0k
 for qemu-devel@nongnu.org; Wed, 29 May 2024 22:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sCVdI-00077a-7j
 for qemu-devel@nongnu.org; Wed, 29 May 2024 22:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717036510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rg2xmNdV9VryyD/e57RSlB0G1p5CoIc1hYKQjH6TQZk=;
 b=KD/u0YirIx8nblxLWTj1EaR6d5DpAghf1T1KWmefz7f2FuzbE+KrwDg5ttZc8xV8O8pnDo
 ZHf64tHjzhtkw5s3ojze/GDf3yG8gCRmxBq+o1p8G+fF/KXB6zMXxg+p7+/C61ZfQL/7FC
 yWSPpyk0Ip1bQSchQ8SLTCz/BLh6vEw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-sBsiXDASO2q-C_3KJuoR1w-1; Wed, 29 May 2024 22:35:08 -0400
X-MC-Unique: sBsiXDASO2q-C_3KJuoR1w-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-6bed8ceb007so436733a12.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 19:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717036507; x=1717641307;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rg2xmNdV9VryyD/e57RSlB0G1p5CoIc1hYKQjH6TQZk=;
 b=nO3K/o/1fjJN2pMOFXvrlAXuZBWaGOzfg8AlPv254IfLKpXNFO46TwgnrAUQb+vSuK
 UT9GHFa4V3JX+eDD8Ql0rb2s3UQXtex2yRq8O0pAPpuqxSyHQ1coHvGnL98lEDxjB/xw
 tHSepHqbmEnWDfpKomc5ygRnvloJ+ncqZH5hkMlRD+GDB5YklXamicJ7fPtW6eqy4EEQ
 U7SSQSC3RBA1xR3judp8A+QlJcW6mGI0Vu5DEqK3MBkLfyRuAvAg/CUf/cA8BZAmenCe
 ibbYpcsY+JwbB/uMLWxtEW3+9WOoFqXu3DOsD2VS7jpyZQIPy4v2j7V/UL+l0zMWcc2s
 dW+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH8aqdji55OagM2/HynvaTOJa/g7SeMbO4eZFPzZ3/P6+Tny21R6RJIOt8SFMwgZvbPlhzbXA0sBSPrG8VebQobZjwKwE=
X-Gm-Message-State: AOJu0YzDJH2E5162PQi655dyGYi/kt1xM/hAsMYhLnPjbdFbE44IBC29
 6nJn8X7A6VYkK5tUGr8yObRG7KimVTrLWYOx66tUNraeMp+UjMNFeoR6X91MlHyQ7pk/cjV6xba
 w7AaKoG3CLYYxcplqVlZIKhu7J6MhQVfn32+ONdC6ek9YMh2Wu8cx17S+6xAY9IlpzaR0BLGKe1
 p9ykjabMBI4SROQCTzx9cTnsogrF4=
X-Received: by 2002:a05:6a20:a129:b0:1af:fbab:cf92 with SMTP id
 adf61e73a8af0-1b264633325mr934610637.54.1717036507514; 
 Wed, 29 May 2024 19:35:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPHvpypLiS1f9nHuTmAChnD4EHwAxPYoYQB3REFayM6IwdGm1utKDJOVKVa4jC+xxyAyU2nJR8TBAkjlFqwy4=
X-Received: by 2002:a05:6a20:a129:b0:1af:fbab:cf92 with SMTP id
 adf61e73a8af0-1b264633325mr934600637.54.1717036507106; Wed, 29 May 2024
 19:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240429113334.2454197-1-pasic@linux.ibm.com>
 <ps5dukcjk6yh3an3hlkynr227r7kcln7b5dxgwope62avz5ceo@decy6vkuu56j>
 <20240527132710.4a7c372f.pasic@linux.ibm.com>
 <CACGkMEtqpdAE1bs-egAH6YLCFY+DtctN2HgXUxqygwE3M6fGpw@mail.gmail.com>
 <20240529141746.2a74ce14.pasic@linux.ibm.com>
In-Reply-To: <20240529141746.2a74ce14.pasic@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 May 2024 10:34:55 +0800
Message-ID: <CACGkMEtoxSne90b75GEWWKaYOXzvvo5=rUS96ufjYsWYfN0ykA@mail.gmail.com>
Subject: Re: [PATCH 1/1] vhost-vsock: add VIRTIO_F_RING_PACKED to feaure_bits
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Boris Fiuczynski <fiuczy@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, May 29, 2024 at 8:18=E2=80=AFPM Halil Pasic <pasic@linux.ibm.com> w=
rote:
>
> On Tue, 28 May 2024 11:25:51 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
> > > 5) Based on the following, I would very much prefer a per device list=
 of
> > > features with the semantic "hey QEMU can do that feature without any
> > > specialized vhost-device support (e.g. like VIRTIO_SCSI_F_CHANGE)"
> >
> > Indeed the current code is kind of tricky and may need better
> > documentation. But the problem is some features were datapath related
> > and they are supported since the birth of a specific vhost device. For
> > example, some GSO related features (actually, it's not a feature of
> > vhost-net but TUN/TAP).
> >
> > And I've found another interesting thing, for RING_REST, actually we
> > don't need to do anything but we have the following commits:
> >
> > 313389be06ff6 ("vhost-net: support VIRTIO_F_RING_RESET")
> > 2a3552baafb ("vhost: vhost-kernel: enable vq reset feature")
> >
> > Technically, they are not necessary as RING_RESET for vhost-kernel
> > doesn't require any additional new ioctls. But it's too late to change
> > as the kernel commit has been merged.
> >
> > > over
> > > the current list with the semantics "these are the features that
> > > need vhost backend support, and anything else will just work out". Th=
at
> > > way if an omission is made, we would end up with the usually safer
> > > under-indication  instead of the current over-indication.
> > >
> > >
> > > @Michael, Jason: Could you guys chime in?
> >
> > Another issue is that it seems to require a change of the semantic of
> > VHOST_GET_FEATURES. If my understanding is true, it seems a
> > non-trivial change which I'm not sure it's worth to bother.
>
> I don't quite understand. Would you mind to elaborate on this?
>
> For starters, what is the current semantic of VHOST_GET_FEATURES, and
> where is it documented?

Unfortunately, no documentation. The semantic is kind of complicated
which requires the userspace to know how a specific vhost device
works.

For example, userspace knows vhost-net works with tuntap. So it checks
part of the features with vhost-net and the rest with tuntap.

> You mean the ioctl, right?

Yes.

>
> Then why do you think the semantic of VHOST_GET_FEATURES should change?

For example vhost-net can return GSO related features.

If we don't do that, I don't know how we could achieve
under-indication as you mentioned.

>
> IMHO changing the semantic of the VHOST_GET_FEATURES ioctl is not viable,
> but also not necessary. What I am proposing is changing the (in QEMU)
> logic of processing the features returned by VHOST_GET_FEATURES, while
> preserving the outcomes (essentially realize the same function in a
> mathematical sense, but with code that is less fragile), modulo bugs like
> the one addressed with this patch of course.

Ok, I think I misunderstood you here. Maybe an RFC to see?

Thanks

>
> Regards,
> Halil
>


