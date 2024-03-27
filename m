Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D980FCD11DD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 03:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpJce-0002Ab-NK; Tue, 26 Mar 2024 23:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rpJcY-00024t-0t
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 23:06:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rpJcW-0004Xj-EZ
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 23:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711508791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Trkrku2CS58c1hJqwhRMI168xh0YiaEitpgCt1lKzts=;
 b=b5mXUZG/nXSxaduaVWgLa99WV6rJgU5dA5nFrGSJkwC1tV1odVNGC0aUipbp0Dqtmqn3s6
 9l3iIXr7StIKN6BaSrnCwKU68liyN/9s3v8L7Y9NceFDmLyOGaxReikwqVz8iPHoQrAzG+
 iWBTK8WmhfjtZGyHufNEAz909tNoRgQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-6d4MVI2JMcaC-gzCZ6eX3g-1; Tue, 26 Mar 2024 23:06:29 -0400
X-MC-Unique: 6d4MVI2JMcaC-gzCZ6eX3g-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29905ac5c21so4930879a91.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 20:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711508788; x=1712113588;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Trkrku2CS58c1hJqwhRMI168xh0YiaEitpgCt1lKzts=;
 b=VfaYxQcUXtq+gohlPj+ZmEwGH2qRGCKZ20FPxc5Wp6k/xi4UAJFN6OpjBv1J3sYztk
 SJdRewHePNwIJM4xmX0ENNGlVZQXinN/pxOgslxGr4JSK3hmo3/A7/OCfJ9e2+u835XC
 8fl8/txs/1PEsYxHUKXAu6yzU2tWZQSS2BslvmwVIJfscMbpQd8RWmUYHaJBnr5SyTSV
 8vU/hG85DFDQLfqaaL7DLh3BM5v+V4toA1HKGH71eM63giWivCp2iVOemt8rXeyselKJ
 Td5NBgY5imGGas+BKoYKUF7LiTC7o9KW6C+9T6sXiYZRuGnryVnHpWxdIAvUkoWwUGdu
 tTtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoY72MGlrXsXFgbP28KrAZ8PlYLJ38gjHJSIu9BTO4pJb154U3/4J+9tRyzn2v9VUHevgVmcmigxmQNzph5Qt8+qzCpWo=
X-Gm-Message-State: AOJu0YxwkAKpWnDeqb6H5LxbdvD1a+wu6gHe7jd5pHFigZ27jtBIFZew
 o9V3ZhPPe1lvLct8BfbnxsKB7S0/qkl2h2WkqCBezsEDzhiBTPhVmNJj3p2QwAgt1BFYDOReU2l
 +3ERGQDFOjzqnB202+xcoOAbgIP+C1jgHXw8jlUTx54n3CPZ7qiG6ve2EnQxSVDNDwMU3HVmXQY
 k9+qMVrvWJC0HvYvEaThmMdaYim1RD4Rcevf/6tw==
X-Received: by 2002:a17:90a:b009:b0:29c:74a4:72b3 with SMTP id
 x9-20020a17090ab00900b0029c74a472b3mr1615521pjq.8.1711508788447; 
 Tue, 26 Mar 2024 20:06:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErs7YrjEYVY29nM3cgASgoGXlZcKdaTtp4ek3lkJFkoX1WkxtfGxzeJ9xxOKtijezCYbykQ1g+ldmSn1LTrW8=
X-Received: by 2002:a17:90a:b009:b0:29c:74a4:72b3 with SMTP id
 x9-20020a17090ab00900b0029c74a472b3mr1615512pjq.8.1711508788136; Tue, 26 Mar
 2024 20:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240324-tx-v1-1-a3b4135749ec@daynix.com>
 <CACGkMEvBoe4XQeHOR64rNwAPM-vBMsfLQApWpUoMtvwsSVCpUQ@mail.gmail.com>
 <a31d0734-823b-4b67-8888-46f0c787cf8f@daynix.com>
 <CACGkMEvYQr2=0DF99ge9DotJg-O3H1FmZQAzhb=6RVWSvvGqmA@mail.gmail.com>
 <a4bdd207-e069-47ef-8e80-7b27528a315d@daynix.com>
 <CACGkMEsCTsQ8H6=XYMZ+8Pb9X1o19j9A4N8kiO500Dbgnw-i6g@mail.gmail.com>
 <cc71e6c8-eca5-4ce1-9c16-8f85c6a5073e@daynix.com>
In-Reply-To: <cc71e6c8-eca5-4ce1-9c16-8f85c6a5073e@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Mar 2024 11:06:16 +0800
Message-ID: <CACGkMEvW+_MTvJ5TwJLNxKC=u0bTTLETuHqK5_0P27GQra5Dng@mail.gmail.com>
Subject: Re: [PATCH] hw/net/net_tx_pkt: Fix virtio header without checksum
 offloading
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Mar 27, 2024 at 11:05=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> On 2024/03/27 11:59, Jason Wang wrote:
> > On Wed, Mar 27, 2024 at 10:53=E2=80=AFAM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>
> >> On 2024/03/27 11:50, Jason Wang wrote:
> >>> On Tue, Mar 26, 2024 at 3:04=E2=80=AFPM Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote:
> >>>>
> >>>> On 2024/03/26 15:51, Jason Wang wrote:
> >>>>> On Sun, Mar 24, 2024 at 4:32=E2=80=AFPM Akihiko Odaki <akihiko.odak=
i@daynix.com> wrote:
> >>>>>>
> >>>>>> It is incorrect to have the VIRTIO_NET_HDR_F_NEEDS_CSUM set when
> >>>>>> checksum offloading is disabled so clear the bit. Set the
> >>>>>> VIRTIO_NET_HDR_F_DATA_VALID bit instead to tell the checksum is va=
lid.
> >>>>>>
> >>>>>> TCP/UDP checksum is usually offloaded when the peer requires virti=
o
> >>>>>> headers because they can instruct the peer to compute checksum. Ho=
wever,
> >>>>>> igb disables TX checksum offloading when a VF is enabled whether t=
he
> >>>>>> peer requires virtio headers because a transmitted packet can be r=
outed
> >>>>>> to it and it expects the packet has a proper checksum. Therefore, =
it
> >>>>>> is necessary to have a correct virtio header even when checksum
> >>>>>> offloading is disabled.
> >>>>>>
> >>>>>> A real TCP/UDP checksum will be computed and saved in the buffer w=
hen
> >>>>>> checksum offloading is disabled. The virtio specification requires=
 to
> >>>>>> set the packet checksum stored in the buffer to the TCP/UDP pseudo
> >>>>>> header when the VIRTIO_NET_HDR_F_NEEDS_CSUM bit is set so the bit =
must
> >>>>>> be cleared in that case.
> >>>>>>
> >>>>>> The VIRTIO_NET_HDR_F_NEEDS_CSUM bit also tells to skip checksum
> >>>>>> validation. Even if checksum offloading is disabled, it is desirab=
le to
> >>>>>> skip checksum validation because the checksum is always correct. U=
se the
> >>>>>> VIRTIO_NET_HDR_F_DATA_VALID bit to claim the validity of the check=
sum.
> >>>>>>
> >>>>>> Fixes: ffbd2dbd8e64 ("e1000e: Perform software segmentation for lo=
opback")
> >>>>>> Buglink: https://issues.redhat.com/browse/RHEL-23067
> >>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>> ---
> >>>>>>     hw/net/net_tx_pkt.c | 3 +++
> >>>>>>     1 file changed, 3 insertions(+)
> >>>>>>
> >>>>>> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> >>>>>> index 2e5f58b3c9cc..c225cf706513 100644
> >>>>>> --- a/hw/net/net_tx_pkt.c
> >>>>>> +++ b/hw/net/net_tx_pkt.c
> >>>>>> @@ -833,6 +833,9 @@ bool net_tx_pkt_send_custom(struct NetTxPkt *p=
kt, bool offload,
> >>>>>>
> >>>>>>         if (offload || gso_type =3D=3D VIRTIO_NET_HDR_GSO_NONE) {
> >>>>>>             if (!offload && pkt->virt_hdr.flags & VIRTIO_NET_HDR_F=
_NEEDS_CSUM) {
> >>>>>> +            pkt->virt_hdr.flags =3D
> >>>>>> +                (pkt->virt_hdr.flags & ~VIRTIO_NET_HDR_F_NEEDS_CS=
UM) |
> >>>>>> +                VIRTIO_NET_HDR_F_DATA_VALID;
> >>>>>
> >>>>> Why VIRTIO_NET_HDR_F_DATA_VALID is used in TX path?
> >>>>
> >>>> On igb, a packet sent from a PCI function may be routed to another
> >>>> function. The virtio header updated here will be directly provided t=
o
> >>>> the RX path in such a case.
> >>>
> >>> But I meant for example net_tx_pkt_send_custom() is used in
> >>> e1000e_tx_pkt_send() which is the tx path on the host.
> >>>
> >>> VIRTIO_NET_HDR_F_DATA_VALID is not necessary in the tx path.
> >>
> >> igb passes igb_tx_pkt_vmdq_callback to net_tx_pkt_send_custom().
> >> igb_tx_pkt_vmdq_callback() passes the packet to its rx path for loopba=
ck.
> >>
> >
> > You are right, how about igb_tx_pkt_vmdq_callback()?
> >
> > We probably need to tweak the name if it is only used in rx path.
>
> igb_tx_pkt_vmdq_callback() itself is part of the tx path of a PCI
> function, and invokes the rx path of another PCI function in case of
> loopback, or triggers the transmission to the external peer.

Right, so if it's an external TX, VIRTIO_NET_HDR_F_DATA_VALID may not
work there.

Thanks

>
> Regards,
> Akihiko Odaki
>
> >
> > Thanks
> >
> >> Regards,
> >> Akihiko Odaki
> >>
> >>>
> >>> Thanks
> >>>
> >>>>
> >>>> Regards,
> >>>> Akihiko Odaki
> >>>>
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>>>                 net_tx_pkt_do_sw_csum(pkt, &pkt->vec[NET_TX_PKT_L2=
HDR_FRAG],
> >>>>>>                                       pkt->payload_frags + NET_TX_=
PKT_PL_START_FRAG - 1,
> >>>>>>                                       pkt->payload_len);
> >>>>>>
> >>>>>> ---
> >>>>>> base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
> >>>>>> change-id: 20240324-tx-c57d3c22ad73
> >>>>>>
> >>>>>> Best regards,
> >>>>>> --
> >>>>>> Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>>
> >>>>>
> >>>>
> >>>
> >>
> >
>


