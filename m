Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A112C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 07:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbEEM-0003UJ-EC; Fri, 24 Jan 2025 02:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tbEEB-0003SR-PP
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 02:35:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tbEE7-0004W3-Kx
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 02:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737704135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f7/CjFrBiLhoILgSQmEVAthqofxJRmK7MXH0ktzzpo8=;
 b=INkSiZHgpCMcGyxKLrSmo+fuwqb6UaaIfJ1Dc0fursSgPc6inDbG2BEYaCJhc/soc6GbpT
 ECzQSNqEngqtvL7pU+OmZfjDmSqFSrrp5hzVj/676rpGnKOL2ESUZ5wLcU+ewuRkym1E4+
 LIJs7dthwqYGMcn0sEbtts/36uMuk4Y=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-iPKW8OrWOPuUGQtDozi2eA-1; Fri, 24 Jan 2025 02:35:32 -0500
X-MC-Unique: iPKW8OrWOPuUGQtDozi2eA-1
X-Mimecast-MFC-AGG-ID: iPKW8OrWOPuUGQtDozi2eA
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e3c61a11a40so5057139276.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 23:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737704132; x=1738308932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f7/CjFrBiLhoILgSQmEVAthqofxJRmK7MXH0ktzzpo8=;
 b=wi/4DxK4UkEcGKKJWuUzejC/69EKLyJTd6PjM3Dlq6zyc+/x3rm+U8O49mTz0L9Q8S
 OTmtvWYFKIzi2TsGMF/vhE5ZX0Gh99sQRQeBimJgFRWLFJWsNebdKh9gZopmw839MS2+
 BPaQVnVeeXwGk/vE7+xUnvFLI/jw3+E3g/9Q3DwUXdKb3mytiaUV6LaXOEn1FQDiom9d
 LYzPv723woZqd+XN4RVBVIANGdv99NwNh+wc2xpVJQAmkx8qVxbnyogfrWIkACTqQiKk
 w2F5MTPdIJK5Dv6B061Mu/oRqEDccNDkO8TYl19ODjfGm7W6vIHbnmqOX2N16TmfDgZZ
 tyPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgnlNXRgEms+mnjCxS7BaMrRZNO07ixJ8jItvbCmDGBw3zJir5tuAwKxZtHqGJyAKn2CLaxhT947ZS@nongnu.org
X-Gm-Message-State: AOJu0Yyz+Ps7ow/d9XsJfGYPQlYy6gPjfyfEg1jK6bd+q0ZPMO8cbl/F
 cWOwU1q2Zfn1Ujgiv+WPMwcYjiOr7ztfcz65VO7AU3yIyhkKS+cj3Jf2UrUy1n2m5K9ydG7ysJ2
 IGsfUGw6KRZRME8h50mKkzDNUHC3M+AvRF4liiggkK8Jk1WZoCE9LXuK2V6VgVemOxYkOglJoGQ
 5VxMeu2QDV6ZpxxRpZkOv9ziHV3Sk=
X-Gm-Gg: ASbGnctIFSdZV/V/uoziESIKWp00zqs7qJmuycK3mNQgDWH3hnlBGLGUXrxH7naB2yr
 rtsBfTC4+L6el4ev5sEimnpiPItGYCaXZ9W17nL1oKv+BFw3GgQ==
X-Received: by 2002:a05:6902:cca:b0:e58:32b4:4864 with SMTP id
 3f1490d57ef6-e5832b44979mr3111948276.42.1737704131851; 
 Thu, 23 Jan 2025 23:35:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiwD6iNkUYWSTBrjP8Klf6vLAQO8Ech/VF52SPn/cYD6hvwyooueW+54xpjA9On6k/SGF6URI2mu3txXqH8mc=
X-Received: by 2002:a05:6902:cca:b0:e58:32b4:4864 with SMTP id
 3f1490d57ef6-e5832b44979mr3111932276.42.1737704130820; Thu, 23 Jan 2025
 23:35:30 -0800 (PST)
MIME-Version: 1.0
References: <20241205203430.76251-1-sahilcdq@proton.me>
 <CAJaqyWerdWk5S0Sxt4oMUCc8FQJTxopyvhtyOV6ocbXmJ_p7Dw@mail.gmail.com>
 <f95a9e51-6aa1-4aeb-959e-99e9b31109be@gmail.com>
 <CAJaqyWdx6GGrQ8-Pm9k9jE11djdk3B1OHda+uGTQqYbq5tyX7w@mail.gmail.com>
 <d747027b-4c59-4f01-bb36-b9a00aa7d3a9@gmail.com>
 <CAJaqyWeKW3VVATqdWMrRUxCZxsrCUur7uwiyDqk2Y2W1wqZusQ@mail.gmail.com>
 <9b20ffc4-b55b-42c8-9847-a677c30c0051@gmail.com>
 <CAJaqyWf_9btBAtZ1TrUDpCh-eTD47ELHO5jxWJW3gOAZO0tMCw@mail.gmail.com>
 <f670a48e-73ab-4027-9d2b-d4fafa54cd16@gmail.com>
 <CAJaqyWftS8angT2=XUUFiR_5yjxNOmV4WXHe3cxkb4t6KbQdDw@mail.gmail.com>
 <4ee57bd3-5ea0-49a7-969e-c3fe902d8246@gmail.com>
 <CAJaqyWf9g_yAb6oYf_bJ5st9owKOzJDKbcWh6k+ZYZ3-mRSaVg@mail.gmail.com>
 <b5e90abd-9fa0-4ab8-9ad2-2b673f1c0784@gmail.com>
In-Reply-To: <b5e90abd-9fa0-4ab8-9ad2-2b673f1c0784@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 24 Jan 2025 08:34:54 +0100
X-Gm-Features: AbW1kvYYrRg7Dlf0MpFkzcKp0ZCAHtRoZILLa8QRoKDi9Xz2Y-SeWfKLNSAvMCc
Message-ID: <CAJaqyWcgEefe8EKeuY_hxPuPfdOk6yPiFw1gaY5fvKYc7vPo5g@mail.gmail.com>
Subject: Re: [RFC v4 0/5] Add packed virtqueue to shadow virtqueue
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

On Fri, Jan 24, 2025 at 6:47=E2=80=AFAM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> Hi,
>
> On 1/21/25 10:07 PM, Eugenio Perez Martin wrote:
> > On Sun, Jan 19, 2025 at 7:37=E2=80=AFAM Sahil Siddiq <icegambit91@gmail=
.com> wrote:
> >>
> >> Hi,
> >>
> >> On 1/7/25 1:35 PM, Eugenio Perez Martin wrote:
> >>> On Fri, Jan 3, 2025 at 2:06=E2=80=AFPM Sahil Siddiq <icegambit91@gmai=
l.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 12/20/24 12:28 PM, Eugenio Perez Martin wrote:
> >>>>> On Thu, Dec 19, 2024 at 8:37=E2=80=AFPM Sahil Siddiq <icegambit91@g=
mail.com> wrote:
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> On 12/17/24 1:20 PM, Eugenio Perez Martin wrote:
> >>>>>>> On Tue, Dec 17, 2024 at 6:45=E2=80=AFAM Sahil Siddiq <icegambit91=
@gmail.com> wrote:
> >>>>>>>> On 12/16/24 2:09 PM, Eugenio Perez Martin wrote:
> >>>>>>>>> On Sun, Dec 15, 2024 at 6:27=E2=80=AFPM Sahil Siddiq <icegambit=
91@gmail.com> wrote:
> >>>>>>>>>> On 12/10/24 2:57 PM, Eugenio Perez Martin wrote:
> >>>>>>>>>>> On Thu, Dec 5, 2024 at 9:34=E2=80=AFPM Sahil Siddiq <icegambi=
t91@gmail.com> wrote:
> >>>>>>>>>>>> [...]
> >>>>>>>>>>>> I have been following the "Hands on vDPA: what do you do
> >>>>>>>>>>>> when you ain't got the hardware v2 (Part 2)" [1] blog to
> >>>>>>>>>>>> test my changes. To boot the L1 VM, I ran:
> >>>>>>>>>>>>
> >>>>>>>>>>>> sudo ./qemu/build/qemu-system-x86_64 \
> >>>>>>>>>>>> -enable-kvm \
> >>>>>>>>>>>> -drive file=3D//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow=
2,media=3Ddisk,if=3Dvirtio \
> >>>>>>>>>>>> -net nic,model=3Dvirtio \
> >>>>>>>>>>>> -net user,hostfwd=3Dtcp::2222-:22 \
> >>>>>>>>>>>> -device intel-iommu,snoop-control=3Don \
> >>>>>>>>>>>> -device virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,dis=
able-modern=3Doff,iommu_platform=3Don,guest_uso4=3Doff,guest_uso6=3Doff,hos=
t_uso=3Doff,guest_announce=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,packed=3Don,even=
t_idx=3Doff,bus=3Dpcie.0,addr=3D0x4 \
> >>>>>>>>>>>> -netdev tap,id=3Dnet0,script=3Dno,downscript=3Dno \
> >>>>>>>>>>>> -nographic \
> >>>>>>>>>>>> -m 8G \
> >>>>>>>>>>>> -smp 4 \
> >>>>>>>>>>>> -M q35 \
> >>>>>>>>>>>> -cpu host 2>&1 | tee vm.log
> >>>>>>>>>>>>
> >>>>>>>>>>>> Without "guest_uso4=3Doff,guest_uso6=3Doff,host_uso=3Doff,
> >>>>>>>>>>>> guest_announce=3Doff" in "-device virtio-net-pci", QEMU
> >>>>>>>>>>>> throws "vdpa svq does not work with features" [2] when
> >>>>>>>>>>>> trying to boot L2.
> >>>>>>>>>>>>
> >>>>>>>>>>>> The enums added in commit #2 in this series is new and
> >>>>>>>>>>>> wasn't in the earlier versions of the series. Without
> >>>>>>>>>>>> this change, x-svq=3Dtrue throws "SVQ invalid device feature
> >>>>>>>>>>>> flags" [3] and x-svq is consequently disabled.
> >>>>>>>>>>>>
> >>>>>>>>>>>> The first issue is related to running traffic in L2
> >>>>>>>>>>>> with vhost-vdpa.
> >>>>>>>>>>>>
> >>>>>>>>>>>> In L0:
> >>>>>>>>>>>>
> >>>>>>>>>>>> $ ip addr add 111.1.1.1/24 dev tap0
> >>>>>>>>>>>> $ ip link set tap0 up
> >>>>>>>>>>>> $ ip addr show tap0
> >>>>>>>>>>>> 4: tap0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq=
_codel state UNKNOWN group default qlen 1000
> >>>>>>>>>>>>           link/ether d2:6d:b9:61:e1:9a brd ff:ff:ff:ff:ff:ff
> >>>>>>>>>>>>           inet 111.1.1.1/24 scope global tap0
> >>>>>>>>>>>>              valid_lft forever preferred_lft forever
> >>>>>>>>>>>>           inet6 fe80::d06d:b9ff:fe61:e19a/64 scope link prot=
o kernel_ll
> >>>>>>>>>>>>              valid_lft forever preferred_lft forever
> >>>>>>>>>>>>
> >>>>>>>>>>>> I am able to run traffic in L2 when booting without
> >>>>>>>>>>>> x-svq.
> >>>>>>>>>>>>
> >>>>>>>>>>>> In L1:
> >>>>>>>>>>>>
> >>>>>>>>>>>> $ ./qemu/build/qemu-system-x86_64 \
> >>>>>>>>>>>> -nographic \
> >>>>>>>>>>>> -m 4G \
> >>>>>>>>>>>> -enable-kvm \
> >>>>>>>>>>>> -M q35 \
> >>>>>>>>>>>> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> >>>>>>>>>>>> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3D=
vhost-vdpa0 \
> >>>>>>>>>>>> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=
=3Don,disable-modern=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,event_idx=3Doff,bus=3D=
pcie.0,addr=3D0x7 \
> >>>>>>>>>>>> -smp 4 \
> >>>>>>>>>>>> -cpu host \
> >>>>>>>>>>>> 2>&1 | tee vm.log
> >>>>>>>>>>>>
> >>>>>>>>>>>> In L2:
> >>>>>>>>>>>>
> >>>>>>>>>>>> # ip addr add 111.1.1.2/24 dev eth0
> >>>>>>>>>>>> # ip addr show eth0
> >>>>>>>>>>>> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq=
_codel state UP group default qlen 1000
> >>>>>>>>>>>>           link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
> >>>>>>>>>>>>           altname enp0s7
> >>>>>>>>>>>>           inet 111.1.1.2/24 scope global eth0
> >>>>>>>>>>>>              valid_lft forever preferred_lft forever
> >>>>>>>>>>>>           inet6 fe80::9877:de30:5f17:35f9/64 scope link nopr=
efixroute
> >>>>>>>>>>>>              valid_lft forever preferred_lft forever
> >>>>>>>>>>>>
> >>>>>>>>>>>> # ip route
> >>>>>>>>>>>> 111.1.1.0/24 dev eth0 proto kernel scope link src 111.1.1.2
> >>>>>>>>>>>>
> >>>>>>>>>>>> # ping 111.1.1.1 -w3
> >>>>>>>>>>>> PING 111.1.1.1 (111.1.1.1) 56(84) bytes of data.
> >>>>>>>>>>>> 64 bytes from 111.1.1.1: icmp_seq=3D1 ttl=3D64 time=3D0.407 =
ms
> >>>>>>>>>>>> 64 bytes from 111.1.1.1: icmp_seq=3D2 ttl=3D64 time=3D0.671 =
ms
> >>>>>>>>>>>> 64 bytes from 111.1.1.1: icmp_seq=3D3 ttl=3D64 time=3D0.291 =
ms
> >>>>>>>>>>>>
> >>>>>>>>>>>> --- 111.1.1.1 ping statistics ---
> >>>>>>>>>>>> 3 packets transmitted, 3 received, 0% packet loss, time 2034=
ms
> >>>>>>>>>>>> rtt min/avg/max/mdev =3D 0.291/0.456/0.671/0.159 ms
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> But if I boot L2 with x-svq=3Dtrue as shown below, I am unab=
le
> >>>>>>>>>>>> to ping the host machine.
> >>>>>>>>>>>>
> >>>>>>>>>>>> $ ./qemu/build/qemu-system-x86_64 \
> >>>>>>>>>>>> -nographic \
> >>>>>>>>>>>> -m 4G \
> >>>>>>>>>>>> -enable-kvm \
> >>>>>>>>>>>> -M q35 \
> >>>>>>>>>>>> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> >>>>>>>>>>>> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,x-svq=
=3Dtrue,id=3Dvhost-vdpa0 \
> >>>>>>>>>>>> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=
=3Don,disable-modern=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,event_idx=3Doff,bus=3D=
pcie.0,addr=3D0x7 \
> >>>>>>>>>>>> -smp 4 \
> >>>>>>>>>>>> -cpu host \
> >>>>>>>>>>>> 2>&1 | tee vm.log
> >>>>>>>>>>>>
> >>>>>>>>>>>> In L2:
> >>>>>>>>>>>>
> >>>>>>>>>>>> # ip addr add 111.1.1.2/24 dev eth0
> >>>>>>>>>>>> # ip addr show eth0
> >>>>>>>>>>>> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq=
_codel state UP group default qlen 1000
> >>>>>>>>>>>>           link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
> >>>>>>>>>>>>           altname enp0s7
> >>>>>>>>>>>>           inet 111.1.1.2/24 scope global eth0
> >>>>>>>>>>>>              valid_lft forever preferred_lft forever
> >>>>>>>>>>>>           inet6 fe80::9877:de30:5f17:35f9/64 scope link nopr=
efixroute
> >>>>>>>>>>>>              valid_lft forever preferred_lft forever
> >>>>>>>>>>>>
> >>>>>>>>>>>> # ip route
> >>>>>>>>>>>> 111.1.1.0/24 dev eth0 proto kernel scope link src 111.1.1.2
> >>>>>>>>>>>>
> >>>>>>>>>>>> # ping 111.1.1.1 -w10
> >>>>>>>>>>>> PING 111.1.1.1 (111.1.1.1) 56(84) bytes of data.
> >>>>>>>>>>>>       From 111.1.1.2 icmp_seq=3D1 Destination Host Unreachab=
le
> >>>>>>>>>>>> ping: sendmsg: No route to host
> >>>>>>>>>>>>       From 111.1.1.2 icmp_seq=3D2 Destination Host Unreachab=
le
> >>>>>>>>>>>>       From 111.1.1.2 icmp_seq=3D3 Destination Host Unreachab=
le
> >>>>>>>>>>>>
> >>>>>>>>>>>> --- 111.1.1.1 ping statistics ---
> >>>>>>>>>>>> 3 packets transmitted, 0 received, +3 errors, 100% packet lo=
ss, time 2076ms
> >>>>>>>>>>>> pipe 3
> >>>>>>>>>>>>
> >>>>>>>>>>>> The other issue is related to booting L2 with "x-svq=3Dtrue"
> >>>>>>>>>>>> and "packed=3Don".
> >>>>>>>>>>>>
> >>>>>>>>>>>> In L1:
> >>>>>>>>>>>>
> >>>>>>>>>>>> $ ./qemu/build/qemu-system-x86_64 \
> >>>>>>>>>>>> -nographic \
> >>>>>>>>>>>> -m 4G \
> >>>>>>>>>>>> -enable-kvm \
> >>>>>>>>>>>> -M q35 \
> >>>>>>>>>>>> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> >>>>>>>>>>>> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3D=
vhost-vdpa0,x-svq=3Dtrue \
> >>>>>>>>>>>> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=
=3Don,disable-modern=3Doff,guest_uso4=3Doff,guest_uso6=3Doff,host_uso=3Doff=
,guest_announce=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,event_idx=3Doff,packed=3Don=
,bus=3Dpcie.0,addr=3D0x7 \
> >>>>>>>>>>>> -smp 4 \
> >>>>>>>>>>>> -cpu host \
> >>>>>>>>>>>> 2>&1 | tee vm.log
> >>>>>>>>>>>>
> >>>>>>>>>>>> The kernel throws "virtio_net virtio1: output.0:id 0 is not
> >>>>>>>>>>>> a head!" [4].
> >>>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> So this series implements the descriptor forwarding from the =
guest to
> >>>>>>>>>>> the device in packed vq. We also need to forward the descript=
ors from
> >>>>>>>>>>> the device to the guest. The device writes them in the SVQ ri=
ng.
> >>>>>>>>>>>
> >>>>>>>>>>> The functions responsible for that in QEMU are
> >>>>>>>>>>> hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_flush, which is =
called by
> >>>>>>>>>>> the device when used descriptors are written to the SVQ, whic=
h calls
> >>>>>>>>>>> hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_get_buf. We need=
 to do
> >>>>>>>>>>> modifications similar to vhost_svq_add: Make them conditional=
 if we're
> >>>>>>>>>>> in split or packed vq, and "copy" the code from Linux's
> >>>>>>>>>>> drivers/virtio/virtio_ring.c:virtqueue_get_buf.
> >>>>>>>>>>>
> >>>>>>>>>>> After these modifications you should be able to ping and forw=
ard
> >>>>>>>>>>> traffic. As always, It is totally ok if it needs more than on=
e
> >>>>>>>>>>> iteration, and feel free to ask any question you have :).
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> I misunderstood this part. While working on extending
> >>>>>>>>>> hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_get_buf() [1]
> >>>>>>>>>> for packed vqs, I realized that this function and
> >>>>>>>>>> vhost_svq_flush() already support split vqs. However, I am
> >>>>>>>>>> unable to ping L0 when booting L2 with "x-svq=3Dtrue" and
> >>>>>>>>>> "packed=3Doff" or when the "packed" option is not specified
> >>>>>>>>>> in QEMU's command line.
> >>>>>>>>>>
> >>>>>>>>>> I tried debugging these functions for split vqs after running
> >>>>>>>>>> the following QEMU commands while following the blog [2].
> >>>>>>>>>>
> >>>>>>>>>> Booting L1:
> >>>>>>>>>>
> >>>>>>>>>> $ sudo ./qemu/build/qemu-system-x86_64 \
> >>>>>>>>>> -enable-kvm \
> >>>>>>>>>> -drive file=3D//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,=
media=3Ddisk,if=3Dvirtio \
> >>>>>>>>>> -net nic,model=3Dvirtio \
> >>>>>>>>>> -net user,hostfwd=3Dtcp::2222-:22 \
> >>>>>>>>>> -device intel-iommu,snoop-control=3Don \
> >>>>>>>>>> -device virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disab=
le-modern=3Doff,iommu_platform=3Don,guest_uso4=3Doff,guest_uso6=3Doff,host_=
uso=3Doff,guest_announce=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,packed=3Doff,event=
_idx=3Doff,bus=3Dpcie.0,addr=3D0x4 \
> >>>>>>>>>> -netdev tap,id=3Dnet0,script=3Dno,downscript=3Dno \
> >>>>>>>>>> -nographic \
> >>>>>>>>>> -m 8G \
> >>>>>>>>>> -smp 4 \
> >>>>>>>>>> -M q35 \
> >>>>>>>>>> -cpu host 2>&1 | tee vm.log
> >>>>>>>>>>
> >>>>>>>>>> Booting L2:
> >>>>>>>>>>
> >>>>>>>>>> # ./qemu/build/qemu-system-x86_64 \
> >>>>>>>>>> -nographic \
> >>>>>>>>>> -m 4G \
> >>>>>>>>>> -enable-kvm \
> >>>>>>>>>> -M q35 \
> >>>>>>>>>> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> >>>>>>>>>> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,x-svq=
=3Dtrue,id=3Dvhost-vdpa0 \
> >>>>>>>>>> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Do=
n,disable-modern=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,event_idx=3Doff,bus=3Dpcie=
.0,addr=3D0x7 \
> >>>>>>>>>> -smp 4 \
> >>>>>>>>>> -cpu host \
> >>>>>>>>>> 2>&1 | tee vm.log
> >>>>>>>>>>
> >>>>>>>>>> I printed out the contents of VirtQueueElement returned
> >>>>>>>>>> by vhost_svq_get_buf() in vhost_svq_flush() [3].
> >>>>>>>>>> I noticed that "len" which is set by "vhost_svq_get_buf"
> >>>>>>>>>> is always set to 0 while VirtQueueElement.len is non-zero.
> >>>>>>>>>> I haven't understood the difference between these two "len"s.
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> VirtQueueElement.len is the length of the buffer, while the len=
 of
> >>>>>>>>> vhost_svq_get_buf is the bytes written by the device. In the ca=
se of
> >>>>>>>>> the tx queue, VirtQueuelen is the length of the tx packet, and =
the
> >>>>>>>>> vhost_svq_get_buf is always 0 as the device does not write. In =
the
> >>>>>>>>> case of rx, VirtQueueElem.len is the available length for a rx =
frame,
> >>>>>>>>> and the vhost_svq_get_buf len is the actual length written by t=
he
> >>>>>>>>> device.
> >>>>>>>>>
> >>>>>>>>> To be 100% accurate a rx packet can span over multiple buffers,=
 but
> >>>>>>>>> SVQ does not need special code to handle this.
> >>>>>>>>>
> >>>>>>>>> So vhost_svq_get_buf should return > 0 for rx queue (svq->vq->i=
ndex =3D=3D
> >>>>>>>>> 0), and 0 for tx queue (svq->vq->index % 2 =3D=3D 1).
> >>>>>>>>>
> >>>>>>>>> Take into account that vhost_svq_get_buf only handles split vq =
at the
> >>>>>>>>> moment! It should be renamed or splitted into vhost_svq_get_buf=
_split.
> >>>>>>>>
> >>>>>>>> In L1, there are 2 virtio network devices.
> >>>>>>>>
> >>>>>>>> # lspci -nn | grep -i net
> >>>>>>>> 00:02.0 Ethernet controller [0200]: Red Hat, Inc. Virtio network=
 device [1af4:1000]
> >>>>>>>> 00:04.0 Ethernet controller [0200]: Red Hat, Inc. Virtio 1.0 net=
work device [1af4:1041] (rev 01)
> >>>>>>>>
> >>>>>>>> I am using the second one (1af4:1041) for testing my changes and=
 have
> >>>>>>>> bound this device to the vp_vdpa driver.
> >>>>>>>>
> >>>>>>>> # vdpa dev show -jp
> >>>>>>>> {
> >>>>>>>>          "dev": {
> >>>>>>>>              "vdpa0": {
> >>>>>>>>                  "type": "network",
> >>>>>>>>                  "mgmtdev": "pci/0000:00:04.0",
> >>>>>>>>                  "vendor_id": 6900,
> >>>>>>>>                  "max_vqs": 3,
> >>>>>>>
> >>>>>>> How is max_vqs=3D3? For this to happen L0 QEMU should have
> >>>>>>> virtio-net-pci,...,queues=3D3 cmdline argument.
> >>>>>
> >>>>> Ouch! I totally misread it :(. Everything is correct, max_vqs shoul=
d
> >>>>> be 3. I read it as the virtio_net queues, which means queue *pairs*=
,
> >>>>> as it includes rx and tx queue.
> >>>>
> >>>> Understood :)
> >>>>
> >>>>>>
> >>>>>> I am not sure why max_vqs is 3. I haven't set the value of queues =
to 3
> >>>>>> in the cmdline argument. Is max_vqs expected to have a default val=
ue
> >>>>>> other than 3?
> >>>>>>
> >>>>>> In the blog [1] as well, max_vqs is 3 even though there's no queue=
s=3D3
> >>>>>> argument.
> >>>>>>
> >>>>>>> It's clear the guest is not using them, we can add mq=3Doff
> >>>>>>> to simplify the scenario.
> >>>>>>
> >>>>>> The value of max_vqs is still 3 after adding mq=3Doff. The whole
> >>>>>> command that I run to boot L0 is:
> >>>>>>
> >>>>>> $ sudo ./qemu/build/qemu-system-x86_64 \
> >>>>>> -enable-kvm \
> >>>>>> -drive file=3D//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,medi=
a=3Ddisk,if=3Dvirtio \
> >>>>>> -net nic,model=3Dvirtio \
> >>>>>> -net user,hostfwd=3Dtcp::2222-:22 \
> >>>>>> -device intel-iommu,snoop-control=3Don \
> >>>>>> -device virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-m=
odern=3Doff,iommu_platform=3Don,guest_uso4=3Doff,guest_uso6=3Doff,host_uso=
=3Doff,guest_announce=3Doff,mq=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,packed=3Doff=
,event_idx=3Doff,bus=3Dpcie.0,addr=3D0x4 \
> >>>>>> -netdev tap,id=3Dnet0,script=3Dno,downscript=3Dno \
> >>>>>> -nographic \
> >>>>>> -m 8G \
> >>>>>> -smp 4 \
> >>>>>> -M q35 \
> >>>>>> -cpu host 2>&1 | tee vm.log
> >>>>>>
> >>>>>> Could it be that 2 of the 3 vqs are used for the dataplane and
> >>>>>> the third vq is the control vq?
> >>>>>>
> >>>>>>>>                  "max_vq_size": 256
> >>>>>>>>              }
> >>>>>>>>          }
> >>>>>>>> }
> >>>>>>>>
> >>>>>>>> The max number of vqs is 3 with the max size being 256.
> >>>>>>>>
> >>>>>>>> Since, there are 2 virtio net devices, vhost_vdpa_svqs_start [1]
> >>>>>>>> is called twice. For each of them. it calls vhost_svq_start [2]
> >>>>>>>> v->shadow_vqs->len number of times.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Ok I understand this confusion, as the code is not intuitive :). =
Take
> >>>>>>> into account you can only have svq in vdpa devices, so both
> >>>>>>> vhost_vdpa_svqs_start are acting on the vdpa device.
> >>>>>>>
> >>>>>>> You are seeing two calls to vhost_vdpa_svqs_start because virtio =
(and
> >>>>>>> vdpa) devices are modelled internally as two devices in QEMU: One=
 for
> >>>>>>> the dataplane vq, and other for the control vq. There are histori=
cal
> >>>>>>> reasons for this, but we use it in vdpa to always shadow the CVQ =
while
> >>>>>>> leaving dataplane passthrough if x-svq=3Doff and the virtio & vir=
tio-net
> >>>>>>> feature set is understood by SVQ.
> >>>>>>>
> >>>>>>> If you break at vhost_vdpa_svqs_start with gdb and go higher in t=
he
> >>>>>>> stack you should reach vhost_net_start, that starts each vhost_ne=
t
> >>>>>>> device individually.
> >>>>>>>
> >>>>>>> To be 100% honest, each dataplain *queue pair* (rx+tx) is modelle=
d
> >>>>>>> with a different vhost_net device in QEMU, but you don't need to =
take
> >>>>>>> that into account implementing the packed vq :).
> >>>>>>
> >>>>>> Got it, this makes sense now.
> >>>>>>
> >>>>>>>> Printing the values of dev->vdev->name, v->shadow_vqs->len and
> >>>>>>>> svq->vring.num in vhost_vdpa_svqs_start gives:
> >>>>>>>>
> >>>>>>>> name: virtio-net
> >>>>>>>> len: 2
> >>>>>>>> num: 256
> >>>>>>>> num: 256
> >>>>>>>
> >>>>>>> First QEMU's vhost_net device, the dataplane.
> >>>>>>>
> >>>>>>>> name: virtio-net
> >>>>>>>> len: 1
> >>>>>>>> num: 64
> >>>>>>>>
> >>>>>>>
> >>>>>>> Second QEMU's vhost_net device, the control virtqueue.
> >>>>>>
> >>>>>> Ok, if I understand this correctly, the control vq doesn't
> >>>>>> need separate queues for rx and tx.
> >>>>>>
> >>>>>
> >>>>> That's right. Since CVQ has one reply per command, the driver can j=
ust
> >>>>> send ro+rw descriptors to the device. In the case of RX, the device
> >>>>> needs a queue with only-writable descriptors, as neither the device=
 or
> >>>>> the driver knows how many packets will arrive.
> >>>>
> >>>> Got it, this makes sense now.
> >>>>
> >>>>>>>> I am not sure how to match the above log lines to the
> >>>>>>>> right virtio-net device since the actual value of num
> >>>>>>>> can be less than "max_vq_size" in the output of "vdpa
> >>>>>>>> dev show".
> >>>>>>>>
> >>>>>>>
> >>>>>>> Yes, the device can set a different vq max per vq, and the driver=
 can
> >>>>>>> negotiate a lower vq size per vq too.
> >>>>>>>
> >>>>>>>> I think the first 3 log lines correspond to the virtio
> >>>>>>>> net device that I am using for testing since it has
> >>>>>>>> 2 vqs (rx and tx) while the other virtio-net device
> >>>>>>>> only has one vq.
> >>>>>>>>
> >>>>>>>> When printing out the values of svq->vring.num,
> >>>>>>>> used_elem.len and used_elem.id in vhost_svq_get_buf,
> >>>>>>>> there are two sets of output. One set corresponds to
> >>>>>>>> svq->vring.num =3D 64 and the other corresponds to
> >>>>>>>> svq->vring.num =3D 256.
> >>>>>>>>
> >>>>>>>> For svq->vring.num =3D 64, only the following line
> >>>>>>>> is printed repeatedly:
> >>>>>>>>
> >>>>>>>> size: 64, len: 1, i: 0
> >>>>>>>>
> >>>>>>>
> >>>>>>> This is with packed=3Doff, right? If this is testing with packed,=
 you
> >>>>>>> need to change the code to accommodate it. Let me know if you nee=
d
> >>>>>>> more help with this.
> >>>>>>
> >>>>>> Yes, this is for packed=3Doff. For the time being, I am trying to
> >>>>>> get L2 to communicate with L0 using split virtqueues and x-svq=3Dt=
rue.
> >>>>>>
> >>>>>
> >>>>> Got it.
> >>>>>
> >>>>>>> In the CVQ the only reply is a byte, indicating if the command wa=
s
> >>>>>>> applied or not. This seems ok to me.
> >>>>>>
> >>>>>> Understood.
> >>>>>>
> >>>>>>> The queue can also recycle ids as long as they are not available,=
 so
> >>>>>>> that part seems correct to me too.
> >>>>>>
> >>>>>> I am a little confused here. The ids are recycled when they are
> >>>>>> available (i.e., the id is not already in use), right?
> >>>>>>
> >>>>>
> >>>>> In virtio, available is that the device can use them. And used is t=
hat
> >>>>> the device returned to the driver. I think you're aligned it's just=
 it
> >>>>> is better to follow the virtio nomenclature :).
> >>>>
> >>>> Got it.
> >>>>
> >>>>>>>> For svq->vring.num =3D 256, the following line is
> >>>>>>>> printed 20 times,
> >>>>>>>>
> >>>>>>>> size: 256, len: 0, i: 0
> >>>>>>>>
> >>>>>>>> followed by:
> >>>>>>>>
> >>>>>>>> size: 256, len: 0, i: 1
> >>>>>>>> size: 256, len: 0, i: 1
> >>>>>>>>
> >>>>>>>
> >>>>>>> This makes sense for the tx queue too. Can you print the VirtQueu=
e index?
> >>>>>>
> >>>>>> For svq->vring.num =3D 64, the vq index is 2. So the following lin=
e
> >>>>>> (svq->vring.num, used_elem.len, used_elem.id, svq->vq->queue_index=
)
> >>>>>> is printed repeatedly:
> >>>>>>
> >>>>>> size: 64, len: 1, i: 0, vq idx: 2
> >>>>>>
> >>>>>> For svq->vring.num =3D 256, the following line is repeated several
> >>>>>> times:
> >>>>>>
> >>>>>> size: 256, len: 0, i: 0, vq idx: 1
> >>>>>>
> >>>>>> This is followed by:
> >>>>>>
> >>>>>> size: 256, len: 0, i: 1, vq idx: 1
> >>>>>>
> >>>>>> In both cases, queue_index is 1. To get the value of queue_index,
> >>>>>> I used "virtio_get_queue_index(svq->vq)" [2].
> >>>>>>
> >>>>>> Since the queue_index is 1, I guess this means this is the tx queu=
e
> >>>>>> and the value of len (0) is correct. However, nothing with
> >>>>>> queue_index % 2 =3D=3D 0 is printed by vhost_svq_get_buf() which m=
eans
> >>>>>> the device is not sending anything to the guest. Is this correct?
> >>>>>>
> >>>>>
> >>>>> Yes, that's totally correct.
> >>>>>
> >>>>> You can set -netdev tap,...,vhost=3Doff in L0 qemu and trace (or de=
bug
> >>>>> with gdb) it to check what is receiving. You should see calls to
> >>>>> hw/net/virtio-net.c:virtio_net_flush_tx. The corresponding function=
 to
> >>>>> receive is virtio_net_receive_rcu, I recommend you trace too just i=
t
> >>>>> in case you see any strange call to it.
> >>>>>
> >>>>
> >>>> I added "vhost=3Doff" to -netdev tap in L0's qemu command. I followe=
d all
> >>>> the steps in the blog [1] up till the point where L2 is booted. Befo=
re
> >>>> booting L2, I had no issues pinging L0 from L1.
> >>>>
> >>>> For each ping, the following trace lines were printed by QEMU:
> >>>>
> >>>> virtqueue_alloc_element elem 0x5d041024f560 size 56 in_num 0 out_num=
 1
> >>>> virtqueue_pop vq 0x5d04109b0ce8 elem 0x5d041024f560 in_num 0 out_num=
 1
> >>>> virtqueue_fill vq 0x5d04109b0ce8 elem 0x5d041024f560 len 0 idx 0
> >>>> virtqueue_flush vq 0x5d04109b0ce8 count 1
> >>>> virtio_notify vdev 0x5d04109a8d50 vq 0x5d04109b0ce8
> >>>> virtqueue_alloc_element elem 0x5d041024f560 size 56 in_num 1 out_num=
 0
> >>>> virtqueue_pop vq 0x5d04109b0c50 elem 0x5d041024f560 in_num 1 out_num=
 0
> >>>> virtqueue_fill vq 0x5d04109b0c50 elem 0x5d041024f560 len 110 idx 0
> >>>> virtqueue_flush vq 0x5d04109b0c50 count 1
> >>>> virtio_notify vdev 0x5d04109a8d50 vq 0x5d04109b0c50
> >>>>
> >>>> The first 5 lines look like they were printed when an echo request w=
as
> >>>> sent to L0 and the next 5 lines were printed when an echo reply was
> >>>> received.
> >>>>
> >>>> After booting L2, I set up the tap device's IP address in L0 and the
> >>>> vDPA port's IP address in L2.
> >>>>
> >>>> When trying to ping L0 from L2, I only see the following lines being
> >>>> printed:
> >>>>
> >>>> virtqueue_alloc_element elem 0x5d041099ffd0 size 56 in_num 0 out_num=
 1
> >>>> virtqueue_pop vq 0x5d0410d87168 elem 0x5d041099ffd0 in_num 0 out_num=
 1
> >>>> virtqueue_fill vq 0x5d0410d87168 elem 0x5d041099ffd0 len 0 idx 0
> >>>> virtqueue_flush vq 0x5d0410d87168 count 1
> >>>> virtio_notify vdev 0x5d0410d79a10 vq 0x5d0410d87168
> >>>>
> >>>> There's no reception. I used wireshark to inspect the packets that a=
re
> >>>> being sent and received through the tap device in L0.
> >>>>
> >>>> When pinging L0 from L2, I see one of the following two outcomes:
> >>>>
> >>>> Outcome 1:
> >>>> ----------
> >>>> L2 broadcasts ARP packets and L0 replies to L2.
> >>>>
> >>>> Source             Destination        Protocol    Length    Info
> >>>> 52:54:00:12:34:57  Broadcast          ARP         42        Who has =
111.1.1.1? Tell 111.1.1.2
> >>>> d2:6d:b9:61:e1:9a  52:54:00:12:34:57  ARP         42        111.1.1.=
1 is at d2:6d:b9:61:e1:9a
> >>>>
> >>>> Outcome 2 (less frequent):
> >>>> --------------------------
> >>>> L2 sends an ICMP echo request packet to L0 and L0 sends a reply,
> >>>> but the reply is not received by L2.
> >>>>
> >>>> Source             Destination        Protocol    Length    Info
> >>>> 111.1.1.2          111.1.1.1          ICMP        98        Echo (pi=
ng) request  id=3D0x0006, seq=3D1/256, ttl=3D64
> >>>> 111.1.1.1          111.1.1.2          ICMP        98        Echo (pi=
ng) reply    id=3D0x0006, seq=3D1/256, ttl=3D64
> >>>>
> >>>> When pinging L2 from L0 I get the following output in
> >>>> wireshark:
> >>>>
> >>>> Source             Destination        Protocol    Length    Info
> >>>> 111.1.1.1          111.1.1.2          ICMP        100       Echo (pi=
ng) request  id=3D0x002c, seq=3D2/512, ttl=3D64 (no response found!)
> >>>>
> >>>> I do see a lot of traced lines being printed (by the QEMU instance t=
hat
> >>>> was started in L0) with in_num > 1, for example:
> >>>>
> >>>> virtqueue_alloc_element elem 0x5d040fdbad30 size 56 in_num 1 out_num=
 0
> >>>> virtqueue_pop vq 0x5d04109b0c50 elem 0x5d040fdbad30 in_num 1 out_num=
 0
> >>>> virtqueue_fill vq 0x5d04109b0c50 elem 0x5d040fdbad30 len 76 idx 0
> >>>> virtqueue_flush vq 0x5d04109b0c50 count 1
> >>>> virtio_notify vdev 0x5d04109a8d50 vq 0x5d04109b0c50
> >>>>
> >>>
> >>> So L0 is able to receive data from L2. We're halfway there, Good! :).
> >>>
> >>>> It looks like L1 is receiving data from L0 but this is not related t=
o
> >>>> the pings that are sent from L2. I haven't figured out what data is
> >>>> actually being transferred in this case. It's not necessary for all =
of
> >>>> the data that L1 receives from L0 to be passed to L2, is it?
> >>>>
> >>>
> >>> It should be noise, yes.
> >>>
> >>
> >> Understood.
> >>
> >>>>>>>> For svq->vring.num =3D 256, the following line is
> >>>>>>>> printed 20 times,
> >>>>>>>>
> >>>>>>>> size: 256, len: 0, i: 0
> >>>>>>>>
> >>>>>>>> followed by:
> >>>>>>>>
> >>>>>>>> size: 256, len: 0, i: 1
> >>>>>>>> size: 256, len: 0, i: 1
> >>>>>>>>
> >>>>>>>
> >>>>>>> This makes sense for the tx queue too. Can you print the VirtQueu=
e index?
> >>>>>>
> >>>>>> For svq->vring.num =3D 64, the vq index is 2. So the following lin=
e
> >>>>>> (svq->vring.num, used_elem.len, used_elem.id, svq->vq->queue_index=
)
> >>>>>> is printed repeatedly:
> >>>>>>
> >>>>>> size: 64, len: 1, i: 0, vq idx: 2
> >>>>>>
> >>>>>> For svq->vring.num =3D 256, the following line is repeated several
> >>>>>> times:
> >>>>>>
> >>>>>> size: 256, len: 0, i: 0, vq idx: 1
> >>>>>>
> >>>>>> This is followed by:
> >>>>>>
> >>>>>> size: 256, len: 0, i: 1, vq idx: 1
> >>>>>>
> >>>>>> In both cases, queue_index is 1.
> >>>>
> >>>> I also noticed that there are now some lines with svq->vring.num =3D=
 256
> >>>> where len > 0. These lines were printed by the QEMU instance running
> >>>> in L1, so this corresponds to data that was received by L2.
> >>>>
> >>>> svq->vring.num  used_elem.len  used_elem.id  svq->vq->queue_index
> >>>> size: 256       len: 82        i: 0          vq idx: 0
> >>>> size: 256       len: 82        i: 1          vq idx: 0
> >>>> size: 256       len: 82        i: 2          vq idx: 0
> >>>> size: 256       len: 54        i: 3          vq idx: 0
> >>>>
> >>>> I still haven't figured out what data was received by L2 but I am
> >>>> slightly confused as to why this data was received by L2 but not
> >>>> the ICMP echo replies sent by L0.
> >>>>
> >>>
> >>> We're on a good track, let's trace it deeper. I guess these are
> >>> printed from vhost_svq_flush, right? Do virtqueue_fill,
> >>> virtqueue_flush, and event_notifier_set(&svq->svq_call) run properly,
> >>> or do you see anything strange with gdb / tracing?
> >>>
> >>
> >> Apologies for the delay in replying. It took me a while to figure
> >> this out, but I have now understood why this doesn't work. L1 is
> >> unable to receive messages from L0 because they get filtered out
> >> by hw/net/virtio-net.c:receive_filter [1]. There's an issue with
> >> the MAC addresses.
> >>
> >> In L0, I have:
> >>
> >> $ ip a show tap0
> >> 6: tap0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel sta=
te UNKNOWN group default qlen 1000
> >>       link/ether d2:6d:b9:61:e1:9a brd ff:ff:ff:ff:ff:ff
> >>       inet 111.1.1.1/24 scope global tap0
> >>          valid_lft forever preferred_lft forever
> >>       inet6 fe80::d06d:b9ff:fe61:e19a/64 scope link proto kernel_ll
> >>          valid_lft forever preferred_lft forever
> >>
> >> In L1:
> >>
> >> # ip a show eth0
> >> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel sta=
te UP group default qlen 1000
> >>       link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
> >>       altname enp0s2
> >>       inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic noprefixro=
ute eth0
> >>          valid_lft 83455sec preferred_lft 83455sec
> >>       inet6 fec0::7bd2:265e:3b8e:5acc/64 scope site dynamic noprefixro=
ute
> >>          valid_lft 86064sec preferred_lft 14064sec
> >>       inet6 fe80::50e7:5bf6:fff8:a7b0/64 scope link noprefixroute
> >>          valid_lft forever preferred_lft forever
> >>
> >> I'll call this L1-eth0.
> >>
> >> In L2:
> >> # ip a show eth0
> >> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel sta=
te UP gro0
> >>       link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
> >>       altname enp0s7
> >>       inet 111.1.1.2/24 scope global eth0
> >>          valid_lft forever preferred_lft forever
> >>
> >> I'll call this L2-eth0.
> >>
> >> Apart from eth0, lo is the only other device in both L1 and L2.
> >>
> >> A frame that L1 receives from L0 has L2-eth0's MAC address (LSB =3D 57=
)
> >> as its destination address. When booting L2 with x-svq=3Dfalse, the
> >> value of n->mac in VirtIONet is also L2-eth0. So, L1 accepts
> >> the frames and passes them on to L2 and pinging works [2].
> >>
> >
> > So this behavior is interesting by itself. But L1's kernel net system
> > should not receive anything. As I read it, even if it receives it, it
> > should not forward the frame to L2 as it is in a different subnet. Are
> > you able to read it using tcpdump on L1?
>
> I ran "tcpdump -i eth0" in L1. It didn't capture any of the packets
> that were directed at L2 even though L2 was able to receive them.
> Similarly, it didn't capture any packets that were sent from L2 to
> L0. This is when L2 is launched with x-svq=3Dfalse.
>

That's right. The virtio dataplane goes directly from L0 to L2, you
should not be able to see any packets in the net of L1.

> With x-svq=3Dtrue, forcibly setting the LSB of n->mac to 0x57 in
> receive_filter allows L2 to receive packets from L0. I added
> the following line just before line 1771 [1] to check this out.
>
> n->mac[5] =3D 0x57;
>

That's very interesting. Let me answer all the gdb questions below and
we can debug it deeper :).

> > Maybe we can make the scenario clearer by telling which virtio-net
> > device is which with virtio_net_pci,mac=3DXX:... ?
> >
> >> However, when booting L2 with x-svq=3Dtrue, n->mac is set to L1-eth0
> >> (LSB =3D 56) in virtio_net_handle_mac() [3].
> >
> > Can you tell with gdb bt if this function is called from net or the
> > SVQ subsystem?
>
> I am struggling to learn how one uses gdb to debug QEMU. I tried running
> QEMU in L0 with -s and -S in one terminal. In another terminal, I ran
> the following:
>

The option -s of QEMU make it act as a debugger for the *guest
kernel*. It's interesting for debugging the virtio_net driver in the
nested guest, for example, but SVQ lives in the nested QEMU, in
userspace. So you don't need to use it here.

> $ gdb ./build/qemu-system-x86_64
>
> I then ran the following in gdb's console, but stepping through or
> continuing the execution gives me errors:
>
> (gdb) target remote localhost:1234
> (gdb) break -source ../hw/net/virtio-net.c -function receive_filter
> (gdb) c
> Continuing.
> Warning:
> Cannot insert breakpoint 2.
> Cannot access memory at address 0x9058c6
>
> Command aborted.
> (gdb) ni
> Continuing.
> Warning:
> Cannot insert breakpoint 2.
> Cannot access memory at address 0x9058c6
>
> Command aborted.
>

Yes, you're trying to debug the kernel running in the guest with the
QEMU's sources so it is not possible to correlate functions, symbols,
etc :).

To run QEMU with gdb, just add gdb --args in front of the qemu invocation.

> I built QEMU using ./configure --enable-debug.
>
> I also tried using the --disable-pie option but this results
> in a build error.
>
> [8063/8844] Linking target qemu-keymap
> FAILED: qemu-keymap
> cc -m64  -o qemu-keymap <...>
> /usr/bin/ld: libevent-loop-base.a.p/event-loop-base.c.o: relocation R_X86=
_64_32 against `.rodata' can not be used when making a PIE object; recompil=
e with -fPIE
> /usr/bin/ld: failed to set dynamic section sizes: bad value
> collect2: error: ld returned 1 exit status
>
> >> n->mac_table.macs also
> >> does not seem to have L2-eth0's MAC address. Due to this,
> >> receive_filter() filters out all the frames [4] that were meant for
> >> L2-eth0.
> >>
> >
> > In the vp_vdpa scenario of the blog receive_filter should not be
> > called in the qemu running in the L1 guest, the nested one. Can you
> > check it with gdb or by printing a trace if it is called?
>
> This is right. receive_filter is not called in L1's QEMU with
> x-svq=3Dtrue.
>
> >> With x-svq=3Dtrue, I see that n->mac is set by virtio_net_handle_mac()
> >> [3] when L1 receives VIRTIO_NET_CTRL_MAC_ADDR_SET. With x-svq=3Dfalse,
> >> virtio_net_handle_mac() doesn't seem to be getting called. I haven't
> >> understood how the MAC address is set in VirtIONet when x-svq=3Dfalse.
> >> Understanding this might help see why n->mac has different values
> >> when x-svq is false vs when it is true.
> >>
> >
> > Ok this makes sense, as x-svq=3Dtrue is the one that receives the set
> > mac message. You should see it in L0's QEMU though, both in x-svq=3Don
> > and x-svq=3Doff scenarios. Can you check it?
>
> L0's QEMU seems to be receiving the "set mac" message only when L1
> is launched with x-svq=3Dtrue. With x-svq=3Doff, I don't see any call
> to virtio_net_handle_mac with cmd =3D=3D VIRTIO_NET_CTRL_MAC_ADDR_SET
> in L0.
>

Ok this is interesting. Let's disable control virtqueue to start with
something simpler:
device virtio-net-pci,netdev=3Dnet0,ctrl_vq=3Doff,...

QEMU will start complaining about features that depend on ctrl_vq,
like ctrl_rx. Let's disable all of them and check this new scenario.

Thanks!


