Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EE2C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 03:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBnTZ-00083O-TS; Mon, 27 May 2024 23:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sBnTY-000839-KE
 for qemu-devel@nongnu.org; Mon, 27 May 2024 23:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sBnTU-0002bB-S7
 for qemu-devel@nongnu.org; Mon, 27 May 2024 23:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716866766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/EkxWXfzX6zXGOtB4KBx1KFCylPfk8b2PjkJFLdpgw=;
 b=eqXy7BNuvGN3vOgPHVFDJ4PBrJQYCt43fgA82LBguFf2p0+JBFtu4JchBjtRFKrkdY/Bo+
 43wMeF78faXIvcoyfn6gCgC6qA7UyMr4OXy4K80MdBa7zWZW41h0vhC75TxjPV5rHnFAQw
 yBrWUXY7h0ntnSgdIFLmKe4pXA3umVg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-MqkadbZnNZus_o7ZfBiZUQ-1; Mon, 27 May 2024 23:26:04 -0400
X-MC-Unique: MqkadbZnNZus_o7ZfBiZUQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2bde806870aso348460a91.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 20:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716866763; x=1717471563;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a/EkxWXfzX6zXGOtB4KBx1KFCylPfk8b2PjkJFLdpgw=;
 b=AefNVNo7TnchQNRZBYxgNQGz/UYTbK9ZLxz9w+sQq46Bp/7160kVXZQ5JPeD9wd/tQ
 +7thWMF7p4KAhbL4nzTXuLyzLfIGAe4GJHOXHwZtOUm9BQ9fwtvNwfoX9a/tZ9zUiLnf
 nPjbuM2C96DF4Eve66PBZx9fxO7ZrjTD3c84igFHy8YbFPNhxKUI2sG/ZfHf8ZitiLmN
 stpvfPab9YZCgA6qq/ISzR0AR7OX7cwPJZpn4MDZDVvzEZKuHdNizu0NAVqj8Ud+/3as
 +roGsC2XGZyex+jd9dab/I3dBTiTqP7WQZGnz4jXmxzS8Yl+zvDa55KHjTTigsg6ZZjS
 XC4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSGMAclqT7tcjz4xP/VAfqUPnLwe7QC21qCx7iSRFYPKzGDN2JkTgQg4J+0yqNhJsLKqwCHx8lpFrQQCuDf5GpnQFxRU8=
X-Gm-Message-State: AOJu0Yxf5NDTBcykNIxeM0dev1/rl/rDurIi7tlknw5UQn70nKYBnmeG
 BOa6CfHsSYKHRokaejyRwuwPaj5pyNL/7/8DpW8ls6ufrOZ84tJKwdib8ImcxUJdcrXJm9nSFJk
 8wCEKec+G0yjSpC9iD3CmARuXSO3M0FMmKqPz8033/CbleFZiDFhwuIYrUZORll9Y52F/QpGRmA
 jP7MzsLTzd+PiLxhmOOOxkVRHOxRg=
X-Received: by 2002:a17:90a:6786:b0:2bf:ee29:1a64 with SMTP id
 98e67ed59e1d1-2bfee292f7bmr2658555a91.23.1716866763265; 
 Mon, 27 May 2024 20:26:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt/YGKVSypjboUqS/HE2fdO4hf1tSSAYaMGbsTP/P8IHD/Mk1ac1v2pIUR1F/j3dCCVDuPXT6uykbcgGpTlQI=
X-Received: by 2002:a17:90a:6786:b0:2bf:ee29:1a64 with SMTP id
 98e67ed59e1d1-2bfee292f7bmr2658546a91.23.1716866762772; Mon, 27 May 2024
 20:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240429113334.2454197-1-pasic@linux.ibm.com>
 <ps5dukcjk6yh3an3hlkynr227r7kcln7b5dxgwope62avz5ceo@decy6vkuu56j>
 <20240527132710.4a7c372f.pasic@linux.ibm.com>
In-Reply-To: <20240527132710.4a7c372f.pasic@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 May 2024 11:25:51 +0800
Message-ID: <CACGkMEtqpdAE1bs-egAH6YLCFY+DtctN2HgXUxqygwE3M6fGpw@mail.gmail.com>
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
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

On Mon, May 27, 2024 at 7:27=E2=80=AFPM Halil Pasic <pasic@linux.ibm.com> w=
rote:
>
> On Thu, 16 May 2024 10:39:42 +0200
> Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> [..]
> > >---
> > >
> > >This is a minimal fix, that follows the current patterns in the
> > >codebase, and not necessarily the best one.
> >
> > Yeah, I did something similar with commit 562a7d23bf ("vhost: mask
> > VIRTIO_F_RING_RESET for vhost and vhost-user devices") so I think for
> > now is the right approach.
> >
> > I suggest to check also other devices like we did in that commit (e.g.
> > hw/scsi/vhost-scsi.c, hw/scsi/vhost-user-scsi.c, etc. )
>
> Hi Stefano!
>
> Thank you for chiming in, and sorry for the late response. I was hoping
> that Michael is going to chime in and that I can base my reply on his
> take. Anyway here I  go.
>
> A very valid observation! I do agree that we need this for
> basically every vhost device, and since:
> * net/vhost-vdpa.c
> * hw/net/vhost_net.c
> * hw/virtio/vhost-user-fs.c
> already have it, that translates to shotgun it to the rest. Which
> isn't nice in my opinion, which is why I am hoping for a discussion
> on this topic, and a better solution (even if it turns out to be
> something like a common macro).
> [..]
> > >
> > >The documentation however does kind of state, that feature_bits is
> > >supposed to contain the supported features. And under the assumption
> > >that feature bit not in feature_bits implies that the corresponding bi=
t
> > >must not be set in the 3rd argument (features), then even with the
> > >current implementation we do end up with the intersection of the three
> > >as stated. And then vsock would be at fault for violating that
> > >assumption, and my fix would be the best thing to do -- I guess.
> > >
> > >Is the implementation the way it is for a good reason, I can't judge
> > >that with certainty for myself.
> >
> > Yes, I think we should fix the documentation, and after a few years of
> > not looking at it I'm confused again about what it does.
> >
>
> I would prefer to fix the algorithm and make whole thing less fragile.
>
> > But re-reading my commit for VIRTIO_F_RING_RESET, it seems that I had
> > interpreted `feature_bits` (2nd argument) as a list of features that
> > QEMU doesn't know how to emulate and therefore are required by the
> > backend (vhost/vhost-user/vdpa). Because the problem is that `features`
> > (3rd argument) is a set of features required by the driver that can be
> > provided by both QEMU and the backend.
>
> Hm. I would say, this does sound like the sanest explanation, that might
> justify the current code, but I will argue that for me, it isn't sane
> enough.
>
> Here comes my argument.
>
> 1) The uses is explicitly asking for a vhost device and giving the user
> a non vhost device is not an option.
>
> 2) The whole purpose of vhost is that at least the data plane is
> implemented outside of QEMU (I am maybe a little sloppy here with
> dataplane). That means a rather substantial portion of the device
> implementation is not in QEMU, while QEMU remains in charge of the
> setup.
>
> 3) Thus I would argue, that all the "transport feature bits" from 24 to
> 40 should have a corresponding vhost feature because the vhost part needs
> some sort of a support.
>
> What do we have there in bits from 24 to 40 according to the spec?
> * VIRTIO_F_INDIRECT_DESC
> * VIRTIO_F_EVENT_IDX
> * VIRTIO_F_VERSION_1
> * VIRTIO_F_ACCESS_PLATFORM
> * VIRTIO_F_RING_PACKED
> * VIRTIO_F_IN_ORDER
> * VIRTIO_F_ORDER_PLATFORM
> * VIRTIO_F_SR_IOV
> * VIRTIO_F_NOTIFICATION_DATA
> * VIRTIO_F_NOTIF_CONFIG_DATA
> * VIRTIO_F_RING_RESET
> and for transitional:
> * VIRTIO_F_NOTIFY_ON_EMPTY
> * VIRTIO_F_ANY_LAYOUT
> * UNUSED
>
> I would say, form these only VIRTIO_F_SR_IOV and
> VIRTIO_F_NOTIF_CONFIG_DATA look iffy in a sense things may work out
> for vhost devices without the vhost part doing something for it. And
> even there, I don't think it would hurt to make vhost part of the
> negotiation (I don't think those are supported by QEMU at this point).
>
> I would very much prefer having a consolidated and safe handling for
> these.
>
> 4) I would also argue that a bunch of the device specific feature bits
> should have vhost feature bits as well for the same reason:
> features are also such that for a vhost device, the vhost part needs
> some sort of a support.
>
> Looking through all of these would require a lot of time, so instead
> of that, let me use SCSI as an example. The features are:
> * VIRTIO_SCSI_F_INOUT
> * VIRTIO_SCSI_F_HOTPLUG
> * VIRTIO_SCSI_F_CHANGE
> * VIRTIO_SCSI_F_T10_PI
>
> The in the Linux kernel we have
>         VHOST_SCSI_FEATURES =3D VHOST_FEATURES | (1ULL << VIRTIO_SCSI_F_H=
OTPLUG) |
>                                                (1ULL << VIRTIO_SCSI_F_T10=
_PI)
> but in QEMU kernel_feature_bits does not have
> VIRTIO_SCSI_F_T10_PI which together does not make much sense to me. And I=
 would
> also expect VIRTIO_SCSI_F_INOUT to be a part of the negotiation, because
> to me that the side that is processing the queue is the one that should
> care about it, but I don't think it is supported by QEMU at all, and
> then not negotiating it is fine. VIRTIO_SCSI_F_HOTPLUG is in QEMU's
> kernel_feature_bits and thus negotiated. in  So the only one that can be
> done purely in QEMU seems to be VIRTIO_SCSI_F_CHANGE.
>
> And for vsock we have
> VIRTIO_VSOCK_F_SEQPACKET and VIRTIO_VSOCK_F_STREAM, with VIRTIO_VSOCK_F_S=
TREAM
> being strange in a sense that the spec says "If no feature bit is set,
> only stream socket type is supported. If VIRTIO_VSOCK_F_SEQPACKET has
> been negotiated, the device MAY act as if VIRTIO_VSOCK_F_STREAM has also
> been negotiated."
>
> VIRTIO_VSOCK_F_SEQPACKET is negotiated with vhost.
>
> It seems for whatever reason we just assume that the vhost device
> supports VIRTIO_VSOCK_F_STREAM and that is why we don't negotiate it. I
> would assume based on what I see that the feature VIRTIO_VSOCK_F_STREAM
> was retrofitted, and that is what we ended up with. Thus I guess now
> we have an implicit rule that any QEMU compatible vhost-vsock
> implementation would have to support that. But in practice we care only
> about Linux, and thus it does not matter.
>
> 5) Based on the following, I would very much prefer a per device list of
> features with the semantic "hey QEMU can do that feature without any
> specialized vhost-device support (e.g. like VIRTIO_SCSI_F_CHANGE)"

Indeed the current code is kind of tricky and may need better
documentation. But the problem is some features were datapath related
and they are supported since the birth of a specific vhost device. For
example, some GSO related features (actually, it's not a feature of
vhost-net but TUN/TAP).

And I've found another interesting thing, for RING_REST, actually we
don't need to do anything but we have the following commits:

313389be06ff6 ("vhost-net: support VIRTIO_F_RING_RESET")
2a3552baafb ("vhost: vhost-kernel: enable vq reset feature")

Technically, they are not necessary as RING_RESET for vhost-kernel
doesn't require any additional new ioctls. But it's too late to change
as the kernel commit has been merged.

> over
> the current list with the semantics "these are the features that
> need vhost backend support, and anything else will just work out". That
> way if an omission is made, we would end up with the usually safer
> under-indication  instead of the current over-indication.
>
>
> @Michael, Jason: Could you guys chime in?

Another issue is that it seems to require a change of the semantic of
VHOST_GET_FEATURES. If my understanding is true, it seems a
non-trivial change which I'm not sure it's worth to bother.

Thanks


