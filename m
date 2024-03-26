Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EBAC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 06:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp0em-0007ja-8B; Tue, 26 Mar 2024 02:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rp0ek-0007jR-MM
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 02:51:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rp0ej-00060Q-5V
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 02:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711435892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WOAA07FzmiMSaaIAqGvEUMrm7cgtOrka9v2DPmBLhBs=;
 b=B4xHEvw1P1FbSUOp0CSzi2Ex6LpeV8/PTx0VkK4InwpUPQxERkZgDTvFTUvXR5OUzccVzs
 9u4iXUkWndsrS6hGmXjD8PTw5YDSa/rmKAv64sLPElw8TKC5aJwSYjuwgF0jjChmVQiy5X
 wetmBt0S5ZhYDj7UD1IUa6ZuoE/Awco=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56--2jGYMlsO5GMJDjHuZi-lQ-1; Tue, 26 Mar 2024 02:51:27 -0400
X-MC-Unique: -2jGYMlsO5GMJDjHuZi-lQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5dcab65d604so3644073a12.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 23:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711435886; x=1712040686;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WOAA07FzmiMSaaIAqGvEUMrm7cgtOrka9v2DPmBLhBs=;
 b=iWyBXWMSSKBPATUVY3vLvuJ7Ai8ocAzfmt6EzMpiygmap/l5gMS2fEm8bPx4epRaDV
 Y7BJJOVPa0a4byPCeh610QTTV2xsgEB3ygxSdvD4FkZz5X4L7i6A8IZI1HUekDjWRv4b
 XxOSE7keyGiUJmr6STvFHrIA+lLvj4J7oOmEbLFeqzCNiQu9qqGsyvaV217d2Lize+e0
 j2r05NJKTFqF7hq1IHr2eEZGgkiVFEGFI9ETicW3i3rvoZXvt+IrPVURgY9rGTQTMUgC
 Z9yg66ZHa/8iCox6K9TqihfdvhcEAExUFKFu84CRiaYoVluLoprueOj61G/UI4Fj9+Z5
 0lZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfpfVWn9zca6Llyn7efNzvRzktiqzfWZws0WOzKGu7bxYXpgKdna28osE15DgrZIMIsmMG4qEy10/oBfdCsSk6PfSpyzs=
X-Gm-Message-State: AOJu0Yz2LHP0DoNvyV9hHI8dXS5Dd59yS458zWkp5dvh2lsWc9jVYfd4
 wyVERlFLCJGB80R5dtC5OVzlDe6gKvVYGc0TbyXjmv+F7mtNYDaA2/f/Zh383nA5ulaZBhWcLm6
 hzIqUoGNHL1PIe0j72ku6v6d21qs/rpgJkSUMPdRso9mFnrXsysA5JB7UP2ku+/xHcuBRYDKGZ3
 P0U8Glz2JaYo9e8OHVFMdNfJl2dl6fPE049vyqKA==
X-Received: by 2002:a05:6a20:94cf:b0:1a3:572d:637b with SMTP id
 ht15-20020a056a2094cf00b001a3572d637bmr354023pzb.33.1711435886209; 
 Mon, 25 Mar 2024 23:51:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMKrkmHcFZGDAfpL0i+9LdvzIiCQZtAVmeanankVwB4gtwmFZy0DTxo3Um/2NV42kGxwdryshFUxf3p/KB4AI=
X-Received: by 2002:a05:6a20:94cf:b0:1a3:572d:637b with SMTP id
 ht15-20020a056a2094cf00b001a3572d637bmr354013pzb.33.1711435885861; Mon, 25
 Mar 2024 23:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240324-tx-v1-1-a3b4135749ec@daynix.com>
In-Reply-To: <20240324-tx-v1-1-a3b4135749ec@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Mar 2024 14:51:14 +0800
Message-ID: <CACGkMEvBoe4XQeHOR64rNwAPM-vBMsfLQApWpUoMtvwsSVCpUQ@mail.gmail.com>
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
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
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

On Sun, Mar 24, 2024 at 4:32=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> It is incorrect to have the VIRTIO_NET_HDR_F_NEEDS_CSUM set when
> checksum offloading is disabled so clear the bit. Set the
> VIRTIO_NET_HDR_F_DATA_VALID bit instead to tell the checksum is valid.
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
> The VIRTIO_NET_HDR_F_NEEDS_CSUM bit also tells to skip checksum
> validation. Even if checksum offloading is disabled, it is desirable to
> skip checksum validation because the checksum is always correct. Use the
> VIRTIO_NET_HDR_F_DATA_VALID bit to claim the validity of the checksum.
>
> Fixes: ffbd2dbd8e64 ("e1000e: Perform software segmentation for loopback"=
)
> Buglink: https://issues.redhat.com/browse/RHEL-23067
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/net/net_tx_pkt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> index 2e5f58b3c9cc..c225cf706513 100644
> --- a/hw/net/net_tx_pkt.c
> +++ b/hw/net/net_tx_pkt.c
> @@ -833,6 +833,9 @@ bool net_tx_pkt_send_custom(struct NetTxPkt *pkt, boo=
l offload,
>
>      if (offload || gso_type =3D=3D VIRTIO_NET_HDR_GSO_NONE) {
>          if (!offload && pkt->virt_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSU=
M) {
> +            pkt->virt_hdr.flags =3D
> +                (pkt->virt_hdr.flags & ~VIRTIO_NET_HDR_F_NEEDS_CSUM) |
> +                VIRTIO_NET_HDR_F_DATA_VALID;

Why VIRTIO_NET_HDR_F_DATA_VALID is used in TX path?

Thanks

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


