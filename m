Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B283C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 02:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpJVb-0007VW-NN; Tue, 26 Mar 2024 22:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rpJVa-0007VI-8z
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 22:59:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rpJVY-0003C3-Ig
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 22:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711508359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ShEezi4qrhqfXZWyj4AFjREldJMS9eLqKT4vLnWXNEU=;
 b=VNlcoN819ONNGaN8awEtfX4Voow7/nWQ1dQN0VeXSzFDHvytmI7pSSIYWTKJbk7zyL1JMz
 RhJHURH624WOJ8HEVBiV0pEnASX7rWGiW07cTkKff8ynzH2SjUAMaiVjche4yqo/Z4MN9w
 W8YcJWOFEIJ3XJQNnhZJ08DC2RIBOMg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-JTYkRTQYNNiC0KcLQ2WDxg-1; Tue, 26 Mar 2024 22:59:16 -0400
X-MC-Unique: JTYkRTQYNNiC0KcLQ2WDxg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29f6765954aso4989881a91.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 19:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711508356; x=1712113156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ShEezi4qrhqfXZWyj4AFjREldJMS9eLqKT4vLnWXNEU=;
 b=TkcIOhjfH9HUCFh0ycbJieYOVPqQSqmYYSWvCQH1OttldUINTOFcKmXpPQP8TlNkEq
 91oM1nTUuea21Zv61s8xrk09ibnuhf24HByXMHiE9fdUbUJATZ7ARi73q5swJ2GjG8nu
 bmA9rBaBzJpDiV9mr7B1HfnEyYSCNMk+RdySPLVQzzUhjTUEEm1W1ssaO0FXkvKQasc/
 AHWBAofk/BTR5nxJcO9Ko85kCHTyRMNpY2S5ldtCXXn6QkF0zf2pGISCEXiVH+bqBcOe
 xdAAZGG3lfamF8eYc/cnJY+HiAgN7PRodfcYiJ9W+kLOn0B92QKbrn1qF9owDkfqCko0
 pWxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3eDHuE5qFwTV/Yoqvl4KReugFeS1UI9rrg05wxH3fWYbsrP74zPBarDBylMAQCLJwlZgFrMT6mIRI3/B0KiOtn8bX9EA=
X-Gm-Message-State: AOJu0YwLQHch/+DKKtO9n6g7oM6uqCEWSsOJnyA93SJ2qoKz0mm7oJ2l
 fhk4dPZUx7Tj0fPbD9G+bLM7ZXLdgxO3y9QRArMjFDLQjeAvPKREiTWOxRP+4BLPN88a7aFCh8U
 Rjya0HXBpBDiEBtM5HWMWg4Ozrkqc7V94aMHZD1tEgzEoTHzdgqKAw6v7UZlSPjgxVI7F/t3uyQ
 ecQT5S+d6TQ5b6jnrI0fKOnNQVKM8=
X-Received: by 2002:a17:90b:fcd:b0:29b:10bc:acaf with SMTP id
 gd13-20020a17090b0fcd00b0029b10bcacafmr1505026pjb.30.1711508355916; 
 Tue, 26 Mar 2024 19:59:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLNadWuEle/XOu1wmLgLHOJ0e5SxIei8/VnZbXhOzsovNe+NRVZHbangf6caMZjoo7owd6mN5RSPouzqvZwYQ=
X-Received: by 2002:a17:90b:fcd:b0:29b:10bc:acaf with SMTP id
 gd13-20020a17090b0fcd00b0029b10bcacafmr1505017pjb.30.1711508355473; Tue, 26
 Mar 2024 19:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240324-tx-v1-1-a3b4135749ec@daynix.com>
 <CACGkMEvBoe4XQeHOR64rNwAPM-vBMsfLQApWpUoMtvwsSVCpUQ@mail.gmail.com>
 <a31d0734-823b-4b67-8888-46f0c787cf8f@daynix.com>
 <CACGkMEvYQr2=0DF99ge9DotJg-O3H1FmZQAzhb=6RVWSvvGqmA@mail.gmail.com>
 <a4bdd207-e069-47ef-8e80-7b27528a315d@daynix.com>
In-Reply-To: <a4bdd207-e069-47ef-8e80-7b27528a315d@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Mar 2024 10:59:04 +0800
Message-ID: <CACGkMEsCTsQ8H6=XYMZ+8Pb9X1o19j9A4N8kiO500Dbgnw-i6g@mail.gmail.com>
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

On Wed, Mar 27, 2024 at 10:53=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> On 2024/03/27 11:50, Jason Wang wrote:
> > On Tue, Mar 26, 2024 at 3:04=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2024/03/26 15:51, Jason Wang wrote:
> >>> On Sun, Mar 24, 2024 at 4:32=E2=80=AFPM Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote:
> >>>>
> >>>> It is incorrect to have the VIRTIO_NET_HDR_F_NEEDS_CSUM set when
> >>>> checksum offloading is disabled so clear the bit. Set the
> >>>> VIRTIO_NET_HDR_F_DATA_VALID bit instead to tell the checksum is vali=
d.
> >>>>
> >>>> TCP/UDP checksum is usually offloaded when the peer requires virtio
> >>>> headers because they can instruct the peer to compute checksum. Howe=
ver,
> >>>> igb disables TX checksum offloading when a VF is enabled whether the
> >>>> peer requires virtio headers because a transmitted packet can be rou=
ted
> >>>> to it and it expects the packet has a proper checksum. Therefore, it
> >>>> is necessary to have a correct virtio header even when checksum
> >>>> offloading is disabled.
> >>>>
> >>>> A real TCP/UDP checksum will be computed and saved in the buffer whe=
n
> >>>> checksum offloading is disabled. The virtio specification requires t=
o
> >>>> set the packet checksum stored in the buffer to the TCP/UDP pseudo
> >>>> header when the VIRTIO_NET_HDR_F_NEEDS_CSUM bit is set so the bit mu=
st
> >>>> be cleared in that case.
> >>>>
> >>>> The VIRTIO_NET_HDR_F_NEEDS_CSUM bit also tells to skip checksum
> >>>> validation. Even if checksum offloading is disabled, it is desirable=
 to
> >>>> skip checksum validation because the checksum is always correct. Use=
 the
> >>>> VIRTIO_NET_HDR_F_DATA_VALID bit to claim the validity of the checksu=
m.
> >>>>
> >>>> Fixes: ffbd2dbd8e64 ("e1000e: Perform software segmentation for loop=
back")
> >>>> Buglink: https://issues.redhat.com/browse/RHEL-23067
> >>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>> ---
> >>>>    hw/net/net_tx_pkt.c | 3 +++
> >>>>    1 file changed, 3 insertions(+)
> >>>>
> >>>> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> >>>> index 2e5f58b3c9cc..c225cf706513 100644
> >>>> --- a/hw/net/net_tx_pkt.c
> >>>> +++ b/hw/net/net_tx_pkt.c
> >>>> @@ -833,6 +833,9 @@ bool net_tx_pkt_send_custom(struct NetTxPkt *pkt=
, bool offload,
> >>>>
> >>>>        if (offload || gso_type =3D=3D VIRTIO_NET_HDR_GSO_NONE) {
> >>>>            if (!offload && pkt->virt_hdr.flags & VIRTIO_NET_HDR_F_NE=
EDS_CSUM) {
> >>>> +            pkt->virt_hdr.flags =3D
> >>>> +                (pkt->virt_hdr.flags & ~VIRTIO_NET_HDR_F_NEEDS_CSUM=
) |
> >>>> +                VIRTIO_NET_HDR_F_DATA_VALID;
> >>>
> >>> Why VIRTIO_NET_HDR_F_DATA_VALID is used in TX path?
> >>
> >> On igb, a packet sent from a PCI function may be routed to another
> >> function. The virtio header updated here will be directly provided to
> >> the RX path in such a case.
> >
> > But I meant for example net_tx_pkt_send_custom() is used in
> > e1000e_tx_pkt_send() which is the tx path on the host.
> >
> > VIRTIO_NET_HDR_F_DATA_VALID is not necessary in the tx path.
>
> igb passes igb_tx_pkt_vmdq_callback to net_tx_pkt_send_custom().
> igb_tx_pkt_vmdq_callback() passes the packet to its rx path for loopback.
>

You are right, how about igb_tx_pkt_vmdq_callback()?

We probably need to tweak the name if it is only used in rx path.

Thanks

> Regards,
> Akihiko Odaki
>
> >
> > Thanks
> >
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >>>
> >>> Thanks
> >>>
> >>>>                net_tx_pkt_do_sw_csum(pkt, &pkt->vec[NET_TX_PKT_L2HDR=
_FRAG],
> >>>>                                      pkt->payload_frags + NET_TX_PKT=
_PL_START_FRAG - 1,
> >>>>                                      pkt->payload_len);
> >>>>
> >>>> ---
> >>>> base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
> >>>> change-id: 20240324-tx-c57d3c22ad73
> >>>>
> >>>> Best regards,
> >>>> --
> >>>> Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>
> >>>
> >>
> >
>


