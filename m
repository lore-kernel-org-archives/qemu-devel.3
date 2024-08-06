Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D973C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 03:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbAaB-00015n-MF; Mon, 05 Aug 2024 23:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sbAa8-0000tz-Lo
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 23:09:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sbAa5-000431-Fk
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 23:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722913788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NBZ+ly8s+lA0Ow1gS1XY81pLGWWkrDmYv4GrUu5d71U=;
 b=Z2jrK2Dc+y507V2ewZkmCUiFsFw+xFJ1caSntZBuSDI4aOYwp5bIFUu+0PwtwFXbunujX6
 Vp9L5FZHiMdf5D6rk11dzziXrXiOkcUDo4Zs7NnaA8ddAdB/Tg0Bi8Z91jzdHqfYlIK3Ew
 CT2voCOvEVr8slCVdVSr21oaAPVDaxg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281--qeJ5FMtPPCfisCUwkB2EQ-1; Mon, 05 Aug 2024 23:09:46 -0400
X-MC-Unique: -qeJ5FMtPPCfisCUwkB2EQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2cb5594a9f3so202195a91.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 20:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722913786; x=1723518586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NBZ+ly8s+lA0Ow1gS1XY81pLGWWkrDmYv4GrUu5d71U=;
 b=Z93KtDVk9UfwfxzjwuRXP7THBluqNpD9WcA1fHZYNEHK62qBbWJBWEFcYmgPjWJXQh
 5Imvg4vEGiBVflzPSQ9P5asloja6hSrQT8ody8QSoGvn6Z5QIopC9nBB8RB8EVG2efkQ
 PDNXStZZHlcLc+/NW7faUSMZSDoyc7l3u6NgP3Ku4dkIRqr2b4Hg7K7yyzYINGu3zaVP
 E8p4RoQTJPZvsDh4UHuO9v2H/SgRAzBrURGwG3gJQS8brNUlxKN1S/nftOCkUAkd4CZj
 l8QMwHwzjuPy8r36zMkyuIFfRj7pYtpq8xTpKIzW82Q2wnJZAiSVSk67Uk0z3T9AZQPL
 uAaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+5+6IzM+3JL7r8b6w1wykX2PYbX0EMvwbQlq9gSvBERl8/1SaCYh0Yk/3LMhgPPDFLMDu3NTGslheOQpnAPf7+1IS0Ls=
X-Gm-Message-State: AOJu0YwMjtwVdx0EjrrZNfZNXVoNdRP2CsrocxY8fgOjE5Rxpj/KqQlc
 2gLlFnVVVQbyvkfap7KdtpcG8ERF8zEmBVJasGDYtiNY414S2vn1WK/2AEUz35VH3853XAFVfjN
 e6Cbq3D8/eunuuO1rLYS8H9EWvDT/JJoNPX3Fao9XcwwcSXG9CvkJwnMT8ocI5T3hzHpBca7cU8
 xxCyi/DdBI49ZMMRPCg1lA/pOJ9Zc=
X-Received: by 2002:a17:90b:1e4c:b0:2c9:57a4:a8c4 with SMTP id
 98e67ed59e1d1-2cff955901dmr11729038a91.42.1722913785798; 
 Mon, 05 Aug 2024 20:09:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNOSN9U2ooi4QF8NRD7UUYVlAF5RNKf55fU67OYqgNiOykVq+U3vGXgEiAzj5OlsXS7Nw0O90pVDkXyc26vfc=
X-Received: by 2002:a17:90b:1e4c:b0:2c9:57a4:a8c4 with SMTP id
 98e67ed59e1d1-2cff955901dmr11729015a91.42.1722913785208; Mon, 05 Aug 2024
 20:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240806005814.51651-1-lulu@redhat.com>
 <20240806005814.51651-3-lulu@redhat.com>
In-Reply-To: <20240806005814.51651-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Aug 2024 11:09:31 +0800
Message-ID: <CACGkMEtg+jApyj4Wxi3b_x=hEpHc0Hx3=cziMef6jq0Ft5S3Pw@mail.gmail.com>
Subject: Re: [PATCH 3/3] virtio_net: remove the unnecessary check in get_config
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 6, 2024 at 8:58=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> The vdpa device with MAC address 0 should not boot.
> So remove the check here
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Please describe what issues you've seen, and how it is fixed by this commit=
.

Thanks

> ---
>  hw/net/virtio-net.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index c144ae2e78..8a7c743ad3 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -142,7 +142,6 @@ static void virtio_net_get_config(VirtIODevice *vdev,=
 uint8_t *config)
>      VirtIONet *n =3D VIRTIO_NET(vdev);
>      struct virtio_net_config netcfg;
>      NetClientState *nc =3D qemu_get_queue(n->nic);
> -    static const MACAddr zero =3D { .a =3D { 0, 0, 0, 0, 0, 0 } };
>
>      int ret =3D 0;
>      memset(&netcfg, 0 , sizeof(struct virtio_net_config));
> @@ -170,18 +169,6 @@ static void virtio_net_get_config(VirtIODevice *vdev=
, uint8_t *config)
>          if (ret =3D=3D -1) {
>              return;
>          }
> -
> -        /*
> -         * Some NIC/kernel combinations present 0 as the mac address.  A=
s that
> -         * is not a legal address, try to proceed with the address from =
the
> -         * QEMU command line in the hope that the address has been confi=
gured
> -         * correctly elsewhere - just not reported by the device.
> -         */
> -        if (memcmp(&netcfg.mac, &zero, sizeof(zero)) =3D=3D 0) {
> -            info_report("Zero hardware mac address detected. Ignoring.")=
;
> -            memcpy(netcfg.mac, n->mac, ETH_ALEN);
> -        }
> -
>          netcfg.status |=3D virtio_tswap16(vdev,
>                                          n->status & VIRTIO_NET_S_ANNOUNC=
E);
>          memcpy(config, &netcfg, n->config_size);
> --
> 2.45.0
>


