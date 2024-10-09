Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74212CED628
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 08:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syS5m-00067V-Mm; Wed, 09 Oct 2024 04:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1syS5j-00065r-6C
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:30:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1syS5h-0000Ky-Q6
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728462641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFrZQedWMOz4YKUtGhHTGE3tObN7L/6uJuW9Rb7mVOE=;
 b=Hw/2HhCp7xUVQmLSEJUe3tfsGlCQBbOBGRZqwMJlX0Z4SducVKWeMpbdoRm9QgY/V87y8S
 gFFf7F8mdH92JYYFcQuWEsKucHUut8q0YbrmOgXCPqmT6qGcGCHPXrXrn45AcMjsmmbamg
 pJ/s0NW5bXT4Y9r5lIlPPY0t3SYENIs=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-B9_iuMD0OdusCnKT6TGreg-1; Wed, 09 Oct 2024 04:30:39 -0400
X-MC-Unique: B9_iuMD0OdusCnKT6TGreg-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-71df2e5e4beso4253440b3a.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 01:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728462638; x=1729067438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BFrZQedWMOz4YKUtGhHTGE3tObN7L/6uJuW9Rb7mVOE=;
 b=Hjp8KbWDNfDJh4mVgH7KGfB4ZhzTD5de3lHZMzb2lcIXBMoJAyn0fgfoyJ2vReFG38
 7lxeVcw9H5TsKwRum2JmJjN8mfmN0Z52e3SPvvfzSkLsbTbDsS04t3XqO+gA6zaaq5Xy
 DhbV3VKZlt38pyH3giASD5pcTYaP16YTyKPf6C82O+3zk8ZAHHld6zhBtzvZxgajGPE9
 /JB/mRR56vf93J6zXWH0zJPH2+5bEkhsXWOjG7+xReU8KppyuWXYQsGaEvnT2vn1NMUD
 c+E8Ba1WVQ1cOdBnQd0KyJ7YnDTVO37sd1pZtqjfX1WEJ7CdRPEr4T2JoGcsRM4K4ypW
 dcIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVktfg0nKu4vDSSjy5mSNoVV9QTP35SZz8h5mafuEGnyxavkM+a1CGTDm7n+foO14igUFYyApkHv4+S@nongnu.org
X-Gm-Message-State: AOJu0YxobPhyMkNwAeL3kgUzwSSf456z6iW5OKetXKlG/7gcX/k8f3M4
 OchV/xBfMEpujtuJ4zQdyYd7/Gr/mFhinFy650r13ZyvVwjsg9XVm9vyYEto/kV77Dbbe9C07uA
 DnQPoiBHV4FBAxLEPNw4n3P2FH6JwZG6ekOmPnk+eFkI4xdNQIqhB/Z5cEkPahXC27un2gE8r0R
 ctCit3ePL5NWBZfLnb300hFqKd9XA=
X-Received: by 2002:a05:6a21:6e4a:b0:1cf:9a86:6cb7 with SMTP id
 adf61e73a8af0-1d8a3c10736mr2789071637.20.1728462638403; 
 Wed, 09 Oct 2024 01:30:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhhVZmTamS2Nh1PjKAkBiWJlIr2hySWHn+me8v/iVASidK2l2laCMB6+uoZ2LQ4G2KGhvu3w17VqNxTNiljXQ=
X-Received: by 2002:a05:6a21:6e4a:b0:1cf:9a86:6cb7 with SMTP id
 adf61e73a8af0-1d8a3c10736mr2789047637.20.1728462637951; Wed, 09 Oct 2024
 01:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240929160045.2133423-1-lulu@redhat.com>
 <20240929160045.2133423-4-lulu@redhat.com>
In-Reply-To: <20240929160045.2133423-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Oct 2024 16:30:26 +0800
Message-ID: <CACGkMEsMbzi42mHUopNfA=0Z1Dx1ZZ9Yf9RxJxgESbrCiQAp6w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] virtio_net: Add the 3rd acceptable situation for
 Mac setup.
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 30, 2024 at 12:01=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> While the hardware MAC address is 0 and the MAC address in
> the QEMU command line is also 0, this configuration is
> acceptable.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/net/virtio-net.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 5c610d8078..668fbed9f2 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3620,6 +3620,17 @@ static bool virtio_net_check_vdpa_mac(NetClientSta=
te *nc, VirtIONet *n,
>              return true;
>          }
>      }
> +    /*
> +     * 3.The hardware MAC address is 0,
> +     *  and the MAC address in the QEMU command line is also 0.
> +     *  In this situation, qemu will use random mac address

And explain how the device knows such a random mac address or it's
just for a best effort try.

Thanks

> +     */
> +    if ((memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) =3D=3D 0) &&
> +        (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) =3D=3D 0)) {
> +        memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
> +
> +        return true;
> +    }
>
>      error_setg(errp,
>                 "vDPA device's mac %02x:%02x:%02x:%02x:%02x:%02x"
> --
> 2.45.0
>


