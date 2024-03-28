Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26D3C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 04:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rphSP-0002wb-1H; Thu, 28 Mar 2024 00:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rphSL-0002wQ-Cx
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 00:33:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rphSJ-0006GO-Ii
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 00:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711600414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9keuV5uRBSbnRJKs8f78SVv6bRoh36CXzZZs0J/TEQ=;
 b=fn9TYABM6sTE77HvCvnZt8AcEM2vS6KOsio/sxV7wFrXIfPAja1+Zi87cVwIyxWZaHCu2g
 kTZa5UgH7eTRzHJ9gjsDrNCfweQqUXdAHMfYnTpZWB2vesracWkbpKxi88njOAHqWetSJ4
 6LWYPmsrg2bhxNWOGoaOSmcbP18NY4A=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-4tILXBhFPaSN7NwPy_Hhpw-1; Thu, 28 Mar 2024 00:33:31 -0400
X-MC-Unique: 4tILXBhFPaSN7NwPy_Hhpw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29dfc072e95so463891a91.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 21:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711600411; x=1712205211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w9keuV5uRBSbnRJKs8f78SVv6bRoh36CXzZZs0J/TEQ=;
 b=onqX4NB7bCgW0cgBZCoU+N6tl2FP7EXbiQvgm7rKWTxJJb/t9PPAyrKwXEWAelI8zC
 YNZsEpod5GMKT4pSm/xHmD8GB12VYB+cGny7XvTiSeNXcF+FnMwSkf2j8ir/Tqd9mxBo
 lGWOSY8l4QP7xl+5oCnsuV7t+cadtWCK2jTz/tnmF6b0meyWKiQFfFxL6qjOwOkWYHlP
 G5uVNUFOe5bfF0gSOF28DGyA2RT4T4cB9JqyiK6fD94EoUpEkMUVVmrcvaoZA3mMOD6x
 JK/LBYoz7POH5S1VfalwqlGlXruPGXrEOqIyaA2IBH/V+BCIDxrA1PYrurLqNrDs1WIO
 9UWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjcubSuZwprTwSXumNwznMSKeqf8wzv5iU36/XVro+1nuW46XQAvFTpUBWQjwCdzCf4FSYEX08Q5XTvH95TEGWo8+oXNg=
X-Gm-Message-State: AOJu0Yx1XxAhXBVcKPAJMWuLZZBubWEl5CL9KwCHSL1ohW0B6KdRD6ed
 q6sjafXbDy0y0btGZOiFH+2BCg1V1d4VZmI41UvXMx12Q4YiANBRV5nHaqPqm8/2FdyEUcYFGeY
 qh64JB+AHwkPmdXbpgN2RdPBETGWMFluDi6o3uucDf2Y3au9tsudwZC0/o8fZpLPQf2WZAzq6Lv
 CgI88Z5XTKwEML/QWqeW0DfETR7PA=
X-Received: by 2002:a17:90b:2d8b:b0:2a0:310b:2cac with SMTP id
 sj11-20020a17090b2d8b00b002a0310b2cacmr1483840pjb.25.1711600410871; 
 Wed, 27 Mar 2024 21:33:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELvYZXi3C/rMoadCzO9k/Zt0vZ1BMv9B7qfL1c7fO3Wys5ikmjz6cdJSUf8AR7tHOzJ2ZaNTaFCR2L0SY2pH0=
X-Received: by 2002:a17:90b:2d8b:b0:2a0:310b:2cac with SMTP id
 sj11-20020a17090b2d8b00b002a0310b2cacmr1483830pjb.25.1711600410545; Wed, 27
 Mar 2024 21:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240327-tx-v2-1-b69ad4e434f1@daynix.com>
In-Reply-To: <20240327-tx-v2-1-b69ad4e434f1@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 12:33:19 +0800
Message-ID: <CACGkMEuTvFKt6goFx+hS1U=3KZZx=ECnJa06VC6ii_AuBg1ZMQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/net/net_tx_pkt: Fix virtio header without checksum
 offloading
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Mar 27, 2024 at 4:43=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> It is incorrect to have the VIRTIO_NET_HDR_F_NEEDS_CSUM set when
> checksum offloading is disabled so clear the bit.
>
> TCP/UDP checksum is usually offloaded when the peer requires virtio
> headers because they can instruct the peer to compute checksum. However,
> igb disables TX checksum offloading when a VF is enabled whether the
> peer requires virtio headers because a transmitted packet can be routed
> to it and it expects the packet has a proper checksum. Therefore, it
> is necessary to have a correct virtio header even when checksum
> offloading is disabled.
>
> A real TCP/UDP checksum will be computed and saved in the buffer when
> checksum offloading is disabled. The virtio specification requires to
> set the packet checksum stored in the buffer to the TCP/UDP pseudo
> header when the VIRTIO_NET_HDR_F_NEEDS_CSUM bit is set so the bit must
> be cleared in that case.
>
> Fixes: ffbd2dbd8e64 ("e1000e: Perform software segmentation for loopback"=
)
> Buglink: https://issues.redhat.com/browse/RHEL-23067
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v2:
> - Dropped VIRTIO_NET_HDR_F_DATA_VALID. (Jason Wang)
> - Link to v1: https://lore.kernel.org/r/20240324-tx-v1-1-a3b4135749ec@day=
nix.com

Queued.

Thanks

> ---
>  hw/net/net_tx_pkt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> index 2e5f58b3c9cc..2134a18c4c90 100644
> --- a/hw/net/net_tx_pkt.c
> +++ b/hw/net/net_tx_pkt.c
> @@ -833,6 +833,7 @@ bool net_tx_pkt_send_custom(struct NetTxPkt *pkt, boo=
l offload,
>
>      if (offload || gso_type =3D=3D VIRTIO_NET_HDR_GSO_NONE) {
>          if (!offload && pkt->virt_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSU=
M) {
> +            pkt->virt_hdr.flags &=3D ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
>              net_tx_pkt_do_sw_csum(pkt, &pkt->vec[NET_TX_PKT_L2HDR_FRAG],
>                                    pkt->payload_frags + NET_TX_PKT_PL_STA=
RT_FRAG - 1,
>                                    pkt->payload_len);
>
> ---
> base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
> change-id: 20240324-tx-c57d3c22ad73
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>


