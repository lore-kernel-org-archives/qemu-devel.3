Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D39CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 05:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssy8m-0001cq-3M; Tue, 24 Sep 2024 01:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1ssy8k-0001bq-Jl
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 01:31:10 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1ssy8i-00016H-Ie
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 01:31:10 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7d50e865b7aso4147451a12.0
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 22:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727155866; x=1727760666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=80suF47J/GFPhDYzGECkE+nj+M5jtOeHgrFyIZ8z8uc=;
 b=g/+MVjJvPjVEQ38TmzOa2iyIftZc155sBrnQLzwKqQBtZOHG7MtQng+q0mNhHcNwns
 tuFFti5rO8OAxyKI91ORPq1IcRcXgonAJp4Ou0+NY4xNTRs402k/ZC6Ai2msctUFvoL9
 +xgA0/B0GrMYnZwHrViEbV/5S6vbYyjFibnLUjWUx/b6d8xwID7zz6Rxlg47jY0okNkf
 5/OPC/S8qL2XD8bFtf4Zn4AX4oUjLJwjqSE6zst/6dUvGEvPK6oxLQ1KB9UQ9J4hrT63
 9/zOcv7bZVCmguMKOCrucUcIO9XVUtzJgz3TZE4ahu9FPBtNPrat9uNBJ3sXC1xGTyvL
 VfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727155866; x=1727760666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=80suF47J/GFPhDYzGECkE+nj+M5jtOeHgrFyIZ8z8uc=;
 b=saRD3zd9xgTUmR0Byr0ProTTcbYb2FyGAPX49ztIMVAytUM4vMfwnsSgG4XCoSiX7D
 GjWRAOnU69PZ2HOdYGll+nQ5DfxOxlpVaRfS8Mwhztl85/GAYDG5B3ckBqSBcM21Su/w
 UM/OFWfLlbPXrrZ9WMedaO0hYQnKZKc0/etknPYpnj24zv6baqiUwi9ivcJHxuqIMKR2
 zHa/Jfcdop4/UUaNRwYyLC3V6Az5xpY1ypURsww4J/HnOKD3LpswLRbO4b+WPIOSgEzX
 L00Vn5yIH8I33ff2zZHwMsW5Jv+Cx/CPWcDJwsQZTzcWnfT64quTSxuOvmfwWC5cBTLT
 fqaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrgHSy+ktWRXXszGb2GpC3HtLbWq7FrQrFVzhY9hsD1Cyc8Cr5R6dLC99g7mccq6tz559MgPN21X1Q@nongnu.org
X-Gm-Message-State: AOJu0Yz93i5haquec9C2+yRJp3omOMl3kx7Qi57RqymZEn0uR3XPWBV3
 SG4AbcNtAY9VWi7N+Ds+YfUtl9AFShU6M4q28xSzibN1C5R2s/Q1
X-Google-Smtp-Source: AGHT+IHttqCWKyk4g7RqacPbgv+B6d8azvhAJlK8IOCYUHGqPmDznOSqTLt2x+JwsSeIiMcAfJKcJA==
X-Received: by 2002:a17:90b:4d0f:b0:2c9:7ebd:b957 with SMTP id
 98e67ed59e1d1-2dd80c17863mr19109667a91.11.1727155866477; 
 Mon, 23 Sep 2024 22:31:06 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.85.39])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dd6ef361b0sm10381115a91.44.2024.09.23.22.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 22:31:05 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
Date: Tue, 24 Sep 2024 11:01:00 +0530
Message-ID: <3311761.aeNJFYEL58@valdaarhun>
In-Reply-To: <2196636.irdbgypaU6@valdaarhun>
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <CAJaqyWeCYrMW8zbLh=kHx_qQWAdXyR8oGpDgfopNeBabXrPovA@mail.gmail.com>
 <2196636.irdbgypaU6@valdaarhun>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=icegambit91@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

I have a small update.

On Monday, September 16, 2024 10:04:28=E2=80=AFAM GMT+5:30 Sahil wrote:
> On Thursday, September 12, 2024 3:24:27=E2=80=AFPM GMT+5:30 Eugenio Perez=
 Martin wrote:
> [...]
> > The function that gets the features from vhost-vdpa in QEMU is
> > hw/virtio/vhost-vdpa.c:vhost_vdpa_get_features. Can you check that it
> > returns bit 34 (offset starts with 0 here)? If it returns it, can you
> > keep debugging until you see what clears it?
> >=20
> > If it comes clear, then we need to check the kernel.
>=20
> Got it. I'll start debugging from here.

I am printing the value of "*features & (1ULL << 34)" in
hw/virtio/vhost-vdpa.c:vhost_vdpa_get_features and I see it is 1.
I guess that means the vhost device has the packed feature bit
turned on in L1.

I am also printing out the values of "host_features", "guest_features"
and "backend_features" set in "VirtIODevice vdev" in
hw/virtio/virtio-pci.c:virtio_pci_common_read under "case
VIRTIO_PCI_COMMON_DF". I observed the following values:

dev name: virtio-net
host features: 0x10150bfffa7
guest features: 0x0
backend features: 0x10150bfffa7

The host features and backend features match but guest features
is 0. Is this because the value of guest features has not been set yet
or is it because the driver hasn't selected any of the features?

I am not entirely sure but I think it's the former considering that the
value of /sys/devices/pci0000:00/0000:00:07.0/virtio1/features is
0x10110afffa7. Please let me know if I am wrong.

I found a few other issues as well. When I shut down the L2 VM,
I get the following errors just after shutdown:

qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Operation not permi=
tted (1)
qemu-system-x86_64: vhost VQ 1 ring restore failed: -1: Operation not permi=
tted (1)
qemu-system-x86_64: vhost VQ 2 ring restore failed: -1: Operation not permi=
tted (1)

This is printed in hw/virtio/vhost.c:vhost_virtqueue_stop. According to the=
 comments,
this is because the connection to the backend is broken.

I booted L1 by running:

$ ./qemu/build/qemu-system-x86_64 -enable-kvm \
=2Ddrive file=3D//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=3Ddis=
k,if=3Dvirtio -net nic,model=3Dvirtio -net user,hostfwd=3Dtcp::2222-:22 \
=2Ddevice intel-iommu,snoop-control=3Don \
=2Ddevice virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-modern=
=3Doff,iommu_platform=3Don,event_idx=3Doff,packed=3Don,bus=3Dpcie.0,addr=3D=
0x4 \
=2Dnetdev tap,id=3Dnet0,script=3Dno,downscript=3Dno \
=2Dnographic \
=2Dm 8G \
=2Dsmp 4 \
=2DM q35 \
=2Dcpu host 2>&1 | tee vm.log

And I booted L2 by running:

# ./qemu/build/qemu-system-x86_64 \
=2Dnographic \
=2Dm 4G \
=2Denable-kvm \
=2DM q35 \
=2Ddrive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
=2Dnetdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0 \
=2Ddevice virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,disable-m=
odern=3Doff,event_idx=3Doff,bus=3Dpcie.0,addr=3D0x7 \
=2Dsmp 4 \
=2Dcpu host \
2>&1 | tee vm.log

Am I missing something here?

When booting L2, I also noticed that the control flow does not enter the
following "if" block in hw/virtio/vhost-vdpa.c:vhost_vdpa_init.

if (dev->migration_blocker =3D=3D NULL && !v->shadow_vqs_enabled) {
        ...
        vhost_svq_valid_features(features, &dev->migration_blocker);
}

So "vhost_svq_valid_features" is never called. According to the comments
this is because the device was not started with x-svq=3Don. Could this be a
result (or reason) of the broken connection to the backend? Is there a way
to manually set this option?

Thanks,
Sahil



