Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22059C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 18:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfNTX-0006ox-AA; Tue, 04 Feb 2025 13:16:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tfNTW-0006om-EV
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:16:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tfNTT-0008NE-6k
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738692998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KwfctDRItyW2yQvnhfoSFhnH3hJlTX5MgjecvN5apfQ=;
 b=Qt0NXx3qb9gpM2ndPh88EIXQ/9kaNt3l13KXkPYNqr1fahIi7XJSROv3KQi1IfKsrWFP5V
 NQLhoW59HTtxN+a8eTJyiGvqjG3oq7gJ/gz+O1qJxxss+UsP2AP/qmMvP0TDohyx8R//Cu
 Kcf4DJVWnazzMCm/SBE31ilMdq+I19o=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-4qP_Z9TRPWKO6y3F41zfQg-1; Tue, 04 Feb 2025 13:16:36 -0500
X-MC-Unique: 4qP_Z9TRPWKO6y3F41zfQg-1
X-Mimecast-MFC-AGG-ID: 4qP_Z9TRPWKO6y3F41zfQg
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-6f2ad1a3eb8so86840697b3.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 10:16:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738692996; x=1739297796;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KwfctDRItyW2yQvnhfoSFhnH3hJlTX5MgjecvN5apfQ=;
 b=NS3sCYpDHfY7geqTHKel0ItOkz10PgRN9OsQvKYDBy6nFZEo0ugIGfD7teXQYq2WVz
 926W4YuX6vpNfqWbuKJ7oVZ9yFuepuJfjfOWzDU63Nhee54ieu4M5DvVi2+76jnGSirz
 cjXxgbImMuVp/6j6naaWu6dS7qGde/8Ah1wJsoKDxLgSQYGyPVEbg/gNTZgTETaP5GNm
 /fJYa0Lov1A73cZYNbTG5wH6/8h2luM9ZTdDud2Uk4ZrI2+ILoeoOyWwZ/a261NjGxPh
 57tCfqOTAhbkd0fjZ/qwaB721Qqy5JKa19h8bNZjMRuHBFWThbN73GbiTOFFlpwlWPze
 OwFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQIH12ONl4/y4XoXLVVqTTT3nvfTcUmmiAwP7bOyh7FYL4XZz/oKsYxVhP3Tfdtsy9tZHDzKP0/eTm@nongnu.org
X-Gm-Message-State: AOJu0YxFyyKpUqQq2OWPA6gosaxglOZY9P2lDx6oNiYx+1il+KOYa/NR
 IDBXTQ8h7cfRNZxobDqoFIQ2xHlkmrmr+4GtadLIy3oznojSFFcl5ZziPCF9/mTvwLHczKbCTk+
 bReOHdiv/wkYHx/dRciWJtYPUmXjuUUEB+cbeJvY3lqTIo4ljuzg5Jad5d3NwTUgqMP8Sz8S88i
 qGNORWWeBH/lOKRci/nmrgJi2c7sK+2WbIuwCTWQ==
X-Gm-Gg: ASbGncuqwact+7Lr+A9sNM6U4+CvELzNIv1fcJMK/0HK4MM54eOWfb3SIUVOGfBuBue
 dZ9ECijqWqFAb/E5Pxicc/Ab3P1MecKcY7Hh2sUMvciJNuv2wZ4XWZd+D4GSy
X-Received: by 2002:a05:6902:2683:b0:e57:3a77:99b6 with SMTP id
 3f1490d57ef6-e58a4b07c62mr19932225276.19.1738692994435; 
 Tue, 04 Feb 2025 10:16:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEACPvIuqy3kzC84XXh46cQojnTwnfLe47N456h827IE5qMq4IhPFu88twvLkkPtX0bfpYFL5rWEOkO0hR9h60=
X-Received: by 2002:a05:6902:2683:b0:e57:3a77:99b6 with SMTP id
 3f1490d57ef6-e58a4b07c62mr19932062276.19.1738692992556; Tue, 04 Feb 2025
 10:16:32 -0800 (PST)
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
 <CAJaqyWcgEefe8EKeuY_hxPuPfdOk6yPiFw1gaY5fvKYc7vPo5g@mail.gmail.com>
 <91d6b4b3-be87-462c-9a0a-4f3fc8ebe4c1@gmail.com>
 <CAJaqyWfL9sWRgk-zMyW_+K0dAp18iDNw1AxJLoLHoSN=GA5_sg@mail.gmail.com>
 <dd634f4f-1539-44dd-8f97-6d1173dcd626@gmail.com>
 <CAJaqyWe3qTJhQrkP2gkmCeand_63O_R6ZNvWSgGJQpE-3Qz3aw@mail.gmail.com>
In-Reply-To: <CAJaqyWe3qTJhQrkP2gkmCeand_63O_R6ZNvWSgGJQpE-3Qz3aw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 4 Feb 2025 19:15:54 +0100
X-Gm-Features: AWEUYZmi4v8UPcl2FxMEwvw2w1S2OfjKQQA5UsyrTkP4T9hqDOHxz_NDLsZqpu0
Message-ID: <CAJaqyWe1a9bWKqEqkswDJrwE_8GbetqPFmMau01+nWHGxEL18Q@mail.gmail.com>
Subject: Re: [RFC v4 0/5] Add packed virtqueue to shadow virtqueue
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Feb 4, 2025 at 7:10=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Tue, Feb 4, 2025 at 1:49=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.co=
m> wrote:
> >
> > Hi,
> >
> > On 1/31/25 12:27 PM, Eugenio Perez Martin wrote:
> > > On Fri, Jan 31, 2025 at 6:04=E2=80=AFAM Sahil Siddiq <icegambit91@gma=
il.com> wrote:
> > >> On 1/24/25 1:04 PM, Eugenio Perez Martin wrote:
> > >>> On Fri, Jan 24, 2025 at 6:47=E2=80=AFAM Sahil Siddiq <icegambit91@g=
mail.com> wrote:
> > >>>> On 1/21/25 10:07 PM, Eugenio Perez Martin wrote:
> > >>>>> On Sun, Jan 19, 2025 at 7:37=E2=80=AFAM Sahil Siddiq <icegambit91=
@gmail.com> wrote:
> > >>>>>> On 1/7/25 1:35 PM, Eugenio Perez Martin wrote:
> > >>>>>> [...]
> > >>>>>> Apologies for the delay in replying. It took me a while to figur=
e
> > >>>>>> this out, but I have now understood why this doesn't work. L1 is
> > >>>>>> unable to receive messages from L0 because they get filtered out
> > >>>>>> by hw/net/virtio-net.c:receive_filter [1]. There's an issue with
> > >>>>>> the MAC addresses.
> > >>>>>>
> > >>>>>> In L0, I have:
> > >>>>>>
> > >>>>>> $ ip a show tap0
> > >>>>>> 6: tap0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_cod=
el state UNKNOWN group default qlen 1000
> > >>>>>>         link/ether d2:6d:b9:61:e1:9a brd ff:ff:ff:ff:ff:ff
> > >>>>>>         inet 111.1.1.1/24 scope global tap0
> > >>>>>>            valid_lft forever preferred_lft forever
> > >>>>>>         inet6 fe80::d06d:b9ff:fe61:e19a/64 scope link proto kern=
el_ll
> > >>>>>>            valid_lft forever preferred_lft forever
> > >>>>>>
> > >>>>>> In L1:
> > >>>>>>
> > >>>>>> # ip a show eth0
> > >>>>>> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_cod=
el state UP group default qlen 1000
> > >>>>>>         link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
> > >>>>>>         altname enp0s2
> > >>>>>>         inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic no=
prefixroute eth0
> > >>>>>>            valid_lft 83455sec preferred_lft 83455sec
> > >>>>>>         inet6 fec0::7bd2:265e:3b8e:5acc/64 scope site dynamic no=
prefixroute
> > >>>>>>            valid_lft 86064sec preferred_lft 14064sec
> > >>>>>>         inet6 fe80::50e7:5bf6:fff8:a7b0/64 scope link noprefixro=
ute
> > >>>>>>            valid_lft forever preferred_lft forever
> > >>>>>>
> > >>>>>> I'll call this L1-eth0.
> > >>>>>>
> > >>>>>> In L2:
> > >>>>>> # ip a show eth0
> > >>>>>> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_cod=
el state UP gro0
> > >>>>>>         link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
> > >>>>>>         altname enp0s7
> > >>>>>>         inet 111.1.1.2/24 scope global eth0
> > >>>>>>            valid_lft forever preferred_lft forever
> > >>>>>>
> > >>>>>> I'll call this L2-eth0.
> > >>>>>>
> > >>>>>> Apart from eth0, lo is the only other device in both L1 and L2.
> > >>>>>>
> > >>>>>> A frame that L1 receives from L0 has L2-eth0's MAC address (LSB =
=3D 57)
> > >>>>>> as its destination address. When booting L2 with x-svq=3Dfalse, =
the
> > >>>>>> value of n->mac in VirtIONet is also L2-eth0. So, L1 accepts
> > >>>>>> the frames and passes them on to L2 and pinging works [2].
> > >>>>>>
> > >>>>>
> > >>>>> So this behavior is interesting by itself. But L1's kernel net sy=
stem
> > >>>>> should not receive anything. As I read it, even if it receives it=
, it
> > >>>>> should not forward the frame to L2 as it is in a different subnet=
. Are
> > >>>>> you able to read it using tcpdump on L1?
> > >>>>
> > >>>> I ran "tcpdump -i eth0" in L1. It didn't capture any of the packet=
s
> > >>>> that were directed at L2 even though L2 was able to receive them.
> > >>>> Similarly, it didn't capture any packets that were sent from L2 to
> > >>>> L0. This is when L2 is launched with x-svq=3Dfalse.
> > >>>>
> > >>>
> > >>> That's right. The virtio dataplane goes directly from L0 to L2, you
> > >>> should not be able to see any packets in the net of L1.
> > >>
> > >> I am a little confused here. Since vhost=3Doff is set in L0's QEMU
> > >> (which is used to boot L1), I am able to inspect the packets when
> > >> tracing/debugging receive_filter in hw/net/virtio-net.c. [1] Does
> > >> this mean the dataplane from L0 to L2 passes through L0's QEMU
> > >> (so L0 QEMU is aware of what's going on), but bypasses L1 completely
> > >> so L1's kernel does not know what packets are being sent/received.
> > >>
> > >
> > > That's right. We're saving processing power and context switches that=
 way :).
> >
> > Got it. I have understood this part. In a previous mail (also present a=
bove):
> >
> > >>>>> On Sun, Jan 19, 2025 at 7:37=E2=80=AFAM Sahil Siddiq wrote:
> > >>>>>> A frame that L1 receives from L0 has L2-eth0's MAC address (LSB =
=3D 57)
> > >>>>>> as its destination address. When booting L2 with x-svq=3Dfalse, =
the
> > >>>>>> value of n->mac in VirtIONet is also L2-eth0. So, L1 accepts
> > >>>>>> the frames and passes them on to L2 and pinging works [2].
> > >>>>>>
> >
> > I was a little unclear in my explanation. I meant to say the frame rece=
ived by
> > L0-QEMU (which is running L1).
> >
> > >>>> With x-svq=3Dtrue, forcibly setting the LSB of n->mac to 0x57 in
> > >>>> receive_filter allows L2 to receive packets from L0. I added
> > >>>> the following line just before line 1771 [1] to check this out.
> > >>>>
> > >>>> n->mac[5] =3D 0x57;
> > >>>>
> > >>>
> > >>> That's very interesting. Let me answer all the gdb questions below =
and
> > >>> we can debug it deeper :).
> > >>>
> > >>
> > >> Thank you for the primer on using gdb with QEMU. I am able to debug
> > >> QEMU now.
> > >>
> > >>>>> Maybe we can make the scenario clearer by telling which virtio-ne=
t
> > >>>>> device is which with virtio_net_pci,mac=3DXX:... ?
> > >>>>>
> > >>>>>> However, when booting L2 with x-svq=3Dtrue, n->mac is set to L1-=
eth0
> > >>>>>> (LSB =3D 56) in virtio_net_handle_mac() [3].
> > >>>>>
> > >>>>> Can you tell with gdb bt if this function is called from net or t=
he
> > >>>>> SVQ subsystem?
> > >>>>
> > >>
> > >> It looks like the function is being called from net.
> > >>
> > >> (gdb) bt
> > >> #0  virtio_net_handle_mac (n=3D0x15622425e, cmd=3D85 'U', iov=3D0x55=
5558865980, iov_cnt=3D1476792840) at ../hw/net/virtio-net.c:1098
> > >> #1  0x0000555555e5920b in virtio_net_handle_ctrl_iov (vdev=3D0x55555=
8fdacd0, in_sg=3D0x5555580611f8, in_num=3D1, out_sg=3D0x555558061208,
> > >>        out_num=3D1) at ../hw/net/virtio-net.c:1581
> > >> #2  0x0000555555e593a0 in virtio_net_handle_ctrl (vdev=3D0x555558fda=
cd0, vq=3D0x555558fe7730) at ../hw/net/virtio-net.c:1610
> > >> #3  0x0000555555e9a7d8 in virtio_queue_notify_vq (vq=3D0x555558fe773=
0) at ../hw/virtio/virtio.c:2484
> > >> #4  0x0000555555e9dffb in virtio_queue_host_notifier_read (n=3D0x555=
558fe77a4) at ../hw/virtio/virtio.c:3869
> > >> #5  0x000055555620329f in aio_dispatch_handler (ctx=3D0x555557d9f840=
, node=3D0x7fffdca7ba80) at ../util/aio-posix.c:373
> > >> #6  0x000055555620346f in aio_dispatch_handlers (ctx=3D0x555557d9f84=
0) at ../util/aio-posix.c:415
> > >> #7  0x00005555562034cb in aio_dispatch (ctx=3D0x555557d9f840) at ../=
util/aio-posix.c:425
> > >> #8  0x00005555562242b5 in aio_ctx_dispatch (source=3D0x555557d9f840,=
 callback=3D0x0, user_data=3D0x0) at ../util/async.c:361
> > >> #9  0x00007ffff6d86559 in ?? () from /usr/lib/libglib-2.0.so.0
> > >> #10 0x00007ffff6d86858 in g_main_context_dispatch () from /usr/lib/l=
ibglib-2.0.so.0
> > >> #11 0x0000555556225bf9 in glib_pollfds_poll () at ../util/main-loop.=
c:287
> > >> #12 0x0000555556225c87 in os_host_main_loop_wait (timeout=3D294672) =
at ../util/main-loop.c:310
> > >> #13 0x0000555556225db6 in main_loop_wait (nonblocking=3D0) at ../uti=
l/main-loop.c:589
> > >> #14 0x0000555555c0c1a3 in qemu_main_loop () at ../system/runstate.c:=
835
> > >> #15 0x000055555612bd8d in qemu_default_main (opaque=3D0x0) at ../sys=
tem/main.c:48
> > >> #16 0x000055555612be3d in main (argc=3D23, argv=3D0x7fffffffe508) at=
 ../system/main.c:76
> > >>
> > >> virtio_queue_notify_vq at hw/virtio/virtio.c:2484 [2] calls
> > >> vq->handle_output(vdev, vq). I see "handle_output" is a function
> > >> pointer and in this case it seems to be pointing to
> > >> virtio_net_handle_ctrl.
> > >>
> > >>>>>> [...]
> > >>>>>> With x-svq=3Dtrue, I see that n->mac is set by virtio_net_handle=
_mac()
> > >>>>>> [3] when L1 receives VIRTIO_NET_CTRL_MAC_ADDR_SET. With x-svq=3D=
false,
> > >>>>>> virtio_net_handle_mac() doesn't seem to be getting called. I hav=
en't
> > >>>>>> understood how the MAC address is set in VirtIONet when x-svq=3D=
false.
> > >>>>>> Understanding this might help see why n->mac has different value=
s
> > >>>>>> when x-svq is false vs when it is true.
> > >>>>>
> > >>>>> Ok this makes sense, as x-svq=3Dtrue is the one that receives the=
 set
> > >>>>> mac message. You should see it in L0's QEMU though, both in x-svq=
=3Don
> > >>>>> and x-svq=3Doff scenarios. Can you check it?
> > >>>>
> > >>>> L0's QEMU seems to be receiving the "set mac" message only when L1
> > >>>> is launched with x-svq=3Dtrue. With x-svq=3Doff, I don't see any c=
all
> > >>>> to virtio_net_handle_mac with cmd =3D=3D VIRTIO_NET_CTRL_MAC_ADDR_=
SET
> > >>>> in L0.
> > >>>>
> > >>>
> > >>> Ok this is interesting. Let's disable control virtqueue to start wi=
th
> > >>> something simpler:
> > >>> device virtio-net-pci,netdev=3Dnet0,ctrl_vq=3Doff,...
> > >>>
> > >>> QEMU will start complaining about features that depend on ctrl_vq,
> > >>> like ctrl_rx. Let's disable all of them and check this new scenario=
.
> > >>>
> > >>
> > >> I am still investigating this part. I set ctrl_vq=3Doff and ctrl_rx=
=3Doff.
> > >> I didn't get any errors as such about features that depend on ctrl_v=
q.
> > >> However, I did notice that after booting L2 (x-svq=3Dtrue as well as
> > >> x-svq=3Dfalse), no eth0 device was created. There was only a "lo" in=
terface
> > >> in L2. An eth0 interface is present only when L1 (L0 QEMU) is booted
> > >> with ctrl_vq=3Don and ctrl_rx=3Don.
> > >>
> > >
> > > Any error messages on the nested guest's dmesg?
> >
> > Oh, yes, there were error messages in the output of dmesg related to
> > ctrl_vq. After adding the following args, there were no error messages
> > in dmesg.
> >
> > -device virtio-net-pci,ctrl_vq=3Doff,ctrl_rx=3Doff,ctrl_vlan=3Doff,ctrl=
_mac_addr=3Doff
> >
> > I see that the eth0 interface is also created. I am able to ping L0
> > from L2 and vice versa as well (even with x-svq=3Dtrue). This is becaus=
e
> > n->promisc is set when these features are disabled and receive_filter()=
 [1]
> > always returns 1.
> >
> > > Is it fixed when you set the same mac address on L0
> > > virtio-net-pci and L1's?
> > >
> >
> > I didn't have to set the same mac address in this case since promiscuou=
s
> > mode seems to be getting enabled which allows pinging to work.
> >
> > There is another concept that I am a little confused about. In the case
> > where L2 is booted with x-svq=3Dfalse (and all ctrl features such as ct=
rl_vq,
> > ctrl_rx, etc. are on), I am able to ping L0 from L2. When tracing
> > receive_filter() in L0-QEMU, I see the values of n->mac and the destina=
tion
> > mac address in the ICMP packet match [2].
> >
>
> SVQ makes an effort to set the mac address at the beginning of
> operation. The L0 interpret it as "filter out all MACs except this
> one". But SVQ cannot set the mac if ctrl_mac_addr=3Doff, so the nic
> receives all packets and the guest kernel needs to filter out by
> itself.
>
> > I haven't understood what n->mac refers to over here. MAC addresses are
> > globally unique and so the mac address of the device in L1 should be
> > different from that in L2.
>
> With vDPA, they should be the same device even if they are declared in
> different cmdlines or layers of virtualizations. If it were a physical
> NIC, QEMU should declare the MAC of the physical NIC too.
>
> There is a thread in QEMU maul list where how QEMU should influence
> the control plane is discussed, and maybe it would be easier if QEMU
> just checks the device's MAC and ignores cmdline. But then, that
> behavior would be surprising for the rest of vhosts like vhost-kernel.
> Or just emit a warning if the MAC is different than the one that the
> device reports.
>
>
> > But I see L0-QEMU's n->mac is set to the mac
> > address of the device in L2 (allowing receive_filter to accept the pack=
et).
> >
>
> That's interesting, can you check further what does receive_filter and
> virtio_net_receive_rcu do with gdb? As long as virtio_net_receive_rcu
> flushes the packet on the receive queue, SVQ should receive it.

PS: Please note that you can check packed_vq SVQ implementation
already without CVQ, as these features are totally orthogonal :).


