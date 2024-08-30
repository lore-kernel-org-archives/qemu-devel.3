Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEA3CA0EFF
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 10:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjzBs-0000o4-2m; Fri, 30 Aug 2024 06:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sjzBq-0000nR-FO
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 06:49:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sjzBn-0003Xu-Ql
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 06:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725014950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=De5tWIqwHbPdFD/emeSnV1oU5EBb2LXFBRtdF7zf8OE=;
 b=aopbGbvPpSC+bWwR+aUP71xi7fWhsOwSxV9iZzHOp7QLLksnzWqNX3foVp06Ge4KY0QK3b
 CjAJ+/SMXjX758AwI5lU3UtuS1d9M2Et7b4tX2LvBROSJl8n53jZcj+kkF+bdKiCbLNjpS
 Za23M1KmHhHWFVliXQQvzOrZMnKGiCQ=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641--aukWkm1NFe-rPPPLKsnRw-1; Fri, 30 Aug 2024 06:49:08 -0400
X-MC-Unique: -aukWkm1NFe-rPPPLKsnRw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6ad97b9a0fbso33897727b3.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 03:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725014948; x=1725619748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=De5tWIqwHbPdFD/emeSnV1oU5EBb2LXFBRtdF7zf8OE=;
 b=oex/yYWoBWkSgjiCa0KsUY/PBStSdoG2+ZIaZZ+Eo35wG9ZCr0JUpsIsJ7Y6E0cv20
 iIcxSPPJLk6ZniU17bVmKQEIl70YS7nzx4QZSHAjaWBkFtcUcb3w1KBaSP0nBLU1lhCq
 lb/kRcgF4/LaiIGH1bmCvdYuki0/N4QjysV04y8pk5/ZkeOoiEDp2NiI/fqLdv90pckY
 X0f5HqmSb0+vYx4dhxy4bhE0fAZXOcWgBR6/fnn37SfylgGCyIQUnSJ121X5FYRZ8ei/
 4g+pb286vQT3x98zOoN/bpJaAnzQL0CAr8yqaQvc1CjfWv39+RtwZQBjq7u22qsAHCt7
 unfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4jtxaLHjiyoRQwivFHPYFtFeC1NiXE5+qHD87lGqNT9tcBE9hhXZNF1wgeZd0PLDY9VgzHhfCq7yT@nongnu.org
X-Gm-Message-State: AOJu0Yw9DA5TPEv2mdSw4nUqf0rg+9Z1wRIPf6Mw7rozglSuLAYNcHBZ
 ddYA5MpnFqOdjeL+h91FcU4/KaZ0ZSUvC/BlefEWYcIN9f+dkDQpHNM2mQGZ/2YJ4q+MNCG4JDR
 IGnV490BQ1/8RWlz2kNU8vmW5P5TgyWMQa7TByN902lPV8cBURIa8sgYl5oLXYo57ubtJJ16Wj2
 PIhEqMV1z3Wjsi8NdkqVcjItGRXes=
X-Received: by 2002:a05:690c:6711:b0:6c8:7827:f271 with SMTP id
 00721157ae682-6d40e17f792mr18682907b3.19.1725014948238; 
 Fri, 30 Aug 2024 03:49:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXoRZjInhtl2MqHN2MpAfVoir2mS2hcPWnQGVYjTs0ZuD6y99TdovaGVqClTea+CKMGdtaDrCebtcEfoeKb00=
X-Received: by 2002:a05:690c:6711:b0:6c8:7827:f271 with SMTP id
 00721157ae682-6d40e17f792mr18682727b3.19.1725014947906; Fri, 30 Aug 2024
 03:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <1901750.tdWV9SEqCh@valdaarhun>
 <CAJaqyWeDxL039GV=QzreenSNGm7S1XWWp=FH2KeB6PLGf=11-w@mail.gmail.com>
 <2620452.Lt9SDvczpP@valdaarhun>
In-Reply-To: <2620452.Lt9SDvczpP@valdaarhun>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 30 Aug 2024 12:48:31 +0200
Message-ID: <CAJaqyWdno3yzuxpCMQN1CyLTt1SOv+oHHwB0Jze28gGqLicscQ@mail.gmail.com>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
To: Sahil <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Aug 30, 2024 at 12:20=E2=80=AFPM Sahil <icegambit91@gmail.com> wrot=
e:
>
> Hi,
>
> On Tuesday, August 27, 2024 9:00:36=E2=80=AFPM GMT+5:30 Eugenio Perez Mar=
tin wrote:
> > On Wed, Aug 21, 2024 at 2:20=E2=80=AFPM Sahil <icegambit91@gmail.com> w=
rote:
> > > [...]
> > > I have been trying to test my changes so far as well. I am not very c=
lear
> > > on a few things.
> > >
> > > Q1.
> > > I built QEMU from source with my changes and followed the vdpa_sim +
> > > vhost_vdpa tutorial [1]. The VM seems to be running fine. How do I ch=
eck
> > > if the packed format is being used instead of the split vq format for
> > > shadow virtqueues? I know the packed format is used when virtio_vdev =
has
> > > got the VIRTIO_F_RING_PACKED bit enabled. Is there a way of checking =
that
> > > this is the case?
> >
> > You can see the features that the driver acked from the guest by
> > checking sysfs. Once you know the PCI BFN from lspci:
> > # lspci -nn|grep '\[1af4:1041\]'
> > 01:00.0 Ethernet controller [0200]: Red Hat, Inc. Virtio 1.0 network
> > device [1af4:1041] (rev 01)
> > # cut -c 35
> > /sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/virtio0/features 0
> >
> > Also, you can check from QEMU by simply tracing if your functions are
> > being called.
> >
> > > Q2.
> > > What's the recommended way to see what's going on under the hood? I t=
ried
> > > using the -D option so QEMU's logs are written to a file but the file=
 was
> > > empty. Would using qemu with -monitor stdio or attaching gdb to the Q=
EMU
> > > VM be worthwhile?
> >
> > You need to add --trace options with the regex you want to get to
> > enable any output. For example, --trace 'vhost_vdpa_*' print all the
> > trace_vhost_vdpa_* functions.
> >
> > If you want to speed things up, you can just replace the interesting
> > trace_... functions with fprintf(stderr, ...). We can add the trace
> > ones afterwards.
>
> Understood. I am able to trace the functions that are being called with
> fprintf. I'll stick with fprintf for now.
>
> I realized that packed vqs are not being used in the test environment. I
> see that in "hw/virtio/vhost-shadow-virtqueue.c", svq->is_packed is set
> to 0 and that calls vhost_svq_add_split(). I am not sure how one enables
> the packed feature bit. I don't know if this is an environment issue.
>
> I built qemu from the latest source with my changes on top of it. I follo=
wed
> this article [1] to set up the environment.
>
> On the host machine:
>
> $ uname -a
> Linux fedora 6.10.5-100.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Aug 14 15:=
49:25 UTC 2024 x86_64 GNU/Linux
>
> $ ./qemu/build/qemu-system-x86_64 --version
> QEMU emulator version 9.0.91
>
> $ vdpa -V
> vdpa utility, iproute2-6.4.0
>
> All the relevant vdpa modules have been loaded in accordance with [1].
>
> $ lsmod | grep -iE "(vdpa|virtio)"
> vdpa_sim_net    12288  0
> vdpa_sim                24576  1 vdpa_sim_net
> vringh          32768  2 vdpa_sim,vdpa_sim_net
> vhost_vdpa              32768  2
> vhost           65536  1 vhost_vdpa
> vhost_iotlb             16384  4 vdpa_sim,vringh,vhost_vdpa,vhost
> vdpa            36864  3 vdpa_sim,vhost_vdpa,vdpa_sim_net
>
> $ ls -l /sys/bus/vdpa/devices/vdpa0/driver
> lrwxrwxrwx. 1 root root 0 Aug 30 11:25 /sys/bus/vdpa/devices/vdpa0/driver=
 -> ../../bus/vdpa/drivers/vhost_vdpa
>
> In the output of the following command, I see ANY_LAYOUT is supported.
> According to virtio_config.h [2] in the linux kernel, this represents the
> layout of descriptors. This refers to split and packed vqs, right?
>
> $ vdpa mgmtdev show
> vdpasim_net:
>   supported_classes net
>   max_supported_vqs 3
>   dev_features MTU MAC STATUS CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 =
ACCESS_PLATFORM
>
> $ vdpa dev show -jp
> {
>     "dev": {
>         "vdpa0": {
>             "type": "network",
>             "mgmtdev": "vdpasim_net",
>             "vendor_id": 0,
>             "max_vqs": 3,
>             "max_vq_size": 256
>         }
>     }
> }
>
> I started the VM by running:
>
> $ sudo ./qemu/build/qemu-system-x86_64 \
> -enable-kvm \
> -drive file=3D//home/ig91/fedora_qemu_test_vm/L1.qcow2,media=3Ddisk,if=3D=
virtio \
> -net nic,model=3Dvirtio \
> -net user,hostfwd=3Dtcp::2226-:22 \
> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0 \
> -device virtio-net-pci,netdev=3Dvhost-vdpa0,bus=3Dpci.0,addr=3D0x7,disabl=
e-legacy=3Don,disable-modern=3Doff,page-per-vq=3Don,event_idx=3Doff,packed=
=3Don \
> -nographic \
> -m 2G \
> -smp 2 \
> -cpu host \
> 2>&1 | tee vm.log
>
> I added the packed=3Don option to -device virtio-net-pci.
>
> In the VM:
>
> # uname -a
> Linux fedora 6.8.5-201.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Apr 11 18:2=
5:26 UTC 2024 x86_64 GNU/Linux
>
> # lspci -nn | grep -i -A15 "\[1af4:1041\]"
> 00:07.0 Ethernet controller [0200]: Red Hat, Inc. Virtio 1.0 network devi=
ce [1af4:1041] (rev 01)
>
> # cut -c 35 /sys/devices/pci0000:00/0000:00:07.0/virtio1/features
> 0
>
> The packed vq feature bit hasn't been set. Am I missing something here?
>

vdpa_sim does not support packed vq at the moment. You need to build
the use case #3 of the second part of that blog [1]. It's good that
you build the vdpa_sim earlier as it is a simpler setup.

If you have problems with the vp_vdpa environment please let me know
so we can find alternative setups.

Thanks!

[1] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-aint-=
got-hardware-part-2

> Thanks,
> Sahil
>
> [1] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-ain=
t-got-hardware-part-1
> [2] https://github.com/torvalds/linux/blob/master/include/uapi/linux/virt=
io_config.h#L63
>
>
>


