Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBFCCF9C71
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 10:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st34j-0004GO-6v; Tue, 24 Sep 2024 06:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1st34c-0004FP-JW
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 06:47:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1st34Z-00089H-SH
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 06:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727174829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IlBcfjapmhB9hIPg3pLrmW9zWpCkPYrE5PMsm392IdQ=;
 b=gpYlQyK8qsKvdK4NpVJC4Np92NCh2F+M8JIilO6peYfTmJcOjyQ7O6TQ3pJlwbz281h+FG
 /UYNJXoLRtXyc2R178kPxhr2m1iTdE5S0QK593FED7aEEQ/qt6gC+6LhetNjkZj7hmoh8d
 d4h81J59pl2YTbKknVe7626IFkWViMU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-iZf_zCSeODe3L9GFWmK7yw-1; Tue, 24 Sep 2024 06:47:03 -0400
X-MC-Unique: iZf_zCSeODe3L9GFWmK7yw-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-6db7a8c6910so79727357b3.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 03:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727174823; x=1727779623;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IlBcfjapmhB9hIPg3pLrmW9zWpCkPYrE5PMsm392IdQ=;
 b=nXiuCwAZMKXunBWlkn+8mSK0CiP8SMiBERB+k/8WpeFRkJOzV8JCF5KeOCkvyOgFCg
 CnsTzY2L2zIR3de5fAcRbDAPzCSC4/4yrfrxmUUnvKmnoAzOm+7+TgkH//Pa3pkSJ1MI
 TZdxRixrsGfv4+UQe5czZFVLCMSfPRqwT8q6NPZ5AqRV1zpZEastoExfeSQv8rTMF7/I
 J7avyhB4LobuBd+2TN16EaxZFanQxdri/7qudxsmeulc1VQpjXbhYH00cR5OHEeAOgjz
 jy9HTr9t+yiS5eFwwQkMVg30Ae5fpP9Cfy9tiqGjBMAbvCWaqd89CbkRllYDuHNioVck
 e1jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuJ697ApktKNPB9Yms6tRcJAxupmE/5bTLnXI9G7ZmKMsm+C8NXVgSAswg9f6AeN8wlptx9TttM4B2@nongnu.org
X-Gm-Message-State: AOJu0Yx8nE7u+m/Huezy75RgeRt03kNA2xJF6GCLdET/L5TT8UitGfOb
 gEXn8MIdLVXvqxB1ALCVpUbbZNdFcQ+PGteoqKR5maOZ7xs0OxZE/df9+2qwSyFFKhAAx4B/Gyc
 PkIlNnBzZaQDudU45jqQ0OWKnhqN7Iyk0hgwkssaY169CebFsxvlCleHF9DetwrF3c1QlY3FRIf
 gJ6dUhPgjaNQopqcgztqAYp196K2A=
X-Received: by 2002:a05:690c:f06:b0:6dd:d2c5:b2c with SMTP id
 00721157ae682-6dfeec13e32mr117327547b3.4.1727174823092; 
 Tue, 24 Sep 2024 03:47:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf/Tt5PIjIpS9/dntR65mpWtlUIe1+VHCudPit0m5avUsSZ4C77pLkZ4r1FS/ScEyZUETZ7n3efrjt9Fabs6w=
X-Received: by 2002:a05:690c:f06:b0:6dd:d2c5:b2c with SMTP id
 00721157ae682-6dfeec13e32mr117327487b3.4.1727174822744; Tue, 24 Sep 2024
 03:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <CAJaqyWeCYrMW8zbLh=kHx_qQWAdXyR8oGpDgfopNeBabXrPovA@mail.gmail.com>
 <2196636.irdbgypaU6@valdaarhun> <3311761.aeNJFYEL58@valdaarhun>
In-Reply-To: <3311761.aeNJFYEL58@valdaarhun>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 24 Sep 2024 12:46:26 +0200
Message-ID: <CAJaqyWeus1zqEqE4ZzoGOzrY=w=_vEMdPGoHrv+Gxvc6zhiNmw@mail.gmail.com>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
To: Sahil <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Sep 24, 2024 at 7:31=E2=80=AFAM Sahil <icegambit91@gmail.com> wrote=
:
>
> Hi,
>
> I have a small update.
>
> On Monday, September 16, 2024 10:04:28=E2=80=AFAM GMT+5:30 Sahil wrote:
> > On Thursday, September 12, 2024 3:24:27=E2=80=AFPM GMT+5:30 Eugenio Per=
ez Martin wrote:
> > [...]
> > > The function that gets the features from vhost-vdpa in QEMU is
> > > hw/virtio/vhost-vdpa.c:vhost_vdpa_get_features. Can you check that it
> > > returns bit 34 (offset starts with 0 here)? If it returns it, can you
> > > keep debugging until you see what clears it?
> > >
> > > If it comes clear, then we need to check the kernel.
> >
> > Got it. I'll start debugging from here.
>
> I am printing the value of "*features & (1ULL << 34)" in
> hw/virtio/vhost-vdpa.c:vhost_vdpa_get_features and I see it is 1.
> I guess that means the vhost device has the packed feature bit
> turned on in L1.
>

Not quite. That means the device exports the _F_PACKED feature bit.
Now we need to check if the guest acks it. You can look to
vhost_vdpa_set_features for that.

> I am also printing out the values of "host_features", "guest_features"
> and "backend_features" set in "VirtIODevice vdev" in
> hw/virtio/virtio-pci.c:virtio_pci_common_read under "case
> VIRTIO_PCI_COMMON_DF". I observed the following values:
>
> dev name: virtio-net
> host features: 0x10150bfffa7
> guest features: 0x0
> backend features: 0x10150bfffa7
>
> The host features and backend features match but guest features
> is 0. Is this because the value of guest features has not been set yet
> or is it because the driver hasn't selected any of the features?
>
> I am not entirely sure but I think it's the former considering that the
> value of /sys/devices/pci0000:00/0000:00:07.0/virtio1/features is
> 0x10110afffa7. Please let me know if I am wrong.
>

Right, it's the former. _DF is the guest selecting on what 32-bit half
of the 64-bit features willread.

You can check the virtio_pci_common_write function,
VIRTIO_PCI_COMMON_GF case when proxy->gfselect =3D=3D 1. But it should end
in vhost_vdpa_set_features when the driver writes DRIVER_OK, so maybe
that one is easier.

> I found a few other issues as well. When I shut down the L2 VM,
> I get the following errors just after shutdown:
>
> qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Operation not per=
mitted (1)
> qemu-system-x86_64: vhost VQ 1 ring restore failed: -1: Operation not per=
mitted (1)
> qemu-system-x86_64: vhost VQ 2 ring restore failed: -1: Operation not per=
mitted (1)
>
> This is printed in hw/virtio/vhost.c:vhost_virtqueue_stop. According to t=
he comments,
> this is because the connection to the backend is broken.
>

Can you trace vhost_vdpa_get_vring_base to be sure? In particular, if
dev->fd is valid.

> I booted L1 by running:
>
> $ ./qemu/build/qemu-system-x86_64 -enable-kvm \
> -drive file=3D//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=3Ddis=
k,if=3Dvirtio -net nic,model=3Dvirtio -net user,hostfwd=3Dtcp::2222-:22 \
> -device intel-iommu,snoop-control=3Don \
> -device virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-modern=
=3Doff,iommu_platform=3Don,event_idx=3Doff,packed=3Don,bus=3Dpcie.0,addr=3D=
0x4 \
> -netdev tap,id=3Dnet0,script=3Dno,downscript=3Dno \
> -nographic \
> -m 8G \
> -smp 4 \
> -M q35 \
> -cpu host 2>&1 | tee vm.log
>
> And I booted L2 by running:
>
> # ./qemu/build/qemu-system-x86_64 \
> -nographic \
> -m 4G \
> -enable-kvm \
> -M q35 \
> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0 \
> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,disable-m=
odern=3Doff,event_idx=3Doff,bus=3Dpcie.0,addr=3D0x7 \
> -smp 4 \
> -cpu host \
> 2>&1 | tee vm.log
>
> Am I missing something here?
>
> When booting L2, I also noticed that the control flow does not enter the
> following "if" block in hw/virtio/vhost-vdpa.c:vhost_vdpa_init.
>
> if (dev->migration_blocker =3D=3D NULL && !v->shadow_vqs_enabled) {
>         ...
>         vhost_svq_valid_features(features, &dev->migration_blocker);
> }
>
> So "vhost_svq_valid_features" is never called. According to the comments
> this is because the device was not started with x-svq=3Don. Could this be=
 a
> result (or reason) of the broken connection to the backend? Is there a wa=
y
> to manually set this option?
>

Yes, you can set it in -netdev vhost-vdpa,x-svq=3Don.


