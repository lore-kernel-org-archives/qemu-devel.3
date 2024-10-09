Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D84CED618
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 07:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syRKF-00021i-Sg; Wed, 09 Oct 2024 03:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1syRKE-00021X-Hi
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 03:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1syRKC-0001uP-KO
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 03:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728459695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=re6iQRwVUCqy/n4EUS+nquRq8taDdoQGAj162cVw64w=;
 b=bKVaJfvvim5fURqFpEO7kJIP4eaU2V7g+Gl1zNqSeo4uFvSaCrDJodPwwuHXDZNZ4iLHg2
 DAsD7flIjDl/IJRqEsqU6slf7+umI/7LneHL0//fAEkKo9636ka+I3s5dYw0uryzLjrcIG
 pemuc2Auh2jjzOpql/5pVk3moHluiPM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-IJ4Y4DrUMxaBPdVy6Zjnow-1; Wed, 09 Oct 2024 03:41:18 -0400
X-MC-Unique: IJ4Y4DrUMxaBPdVy6Zjnow-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-20c5bcbc603so15983595ad.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 00:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728459677; x=1729064477;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=re6iQRwVUCqy/n4EUS+nquRq8taDdoQGAj162cVw64w=;
 b=OdS2h9/IJzHFeAamBSq+CVXBdG6znus9WesulUJ5EbuQ1w0jakBNECydRzQxlGUeHf
 JxklgCGSg3gWs2TMJ99rhB7FBGPlVm3HCYJCUAtTYE6jQT0S3XUcwA+CQhw6bTNsl3w3
 l0ove9osFkMZnFGEFsG7Qf+tO1SGZUAc/ipm91gRovRl2MHDYeIKRh91yk7+rJvCeDp+
 eQ6Nw207YyaoGN7QnTgCQKrunWgnlOEZZAL5zJzZmPjvNBw0clsDdhIz5JsXwbZbnBbs
 sNdZ4SuCopsx5JDKiOZIFtLAmUR4ypvrttzSqHDNSxjmZjhkFPJiYYpuWzmqB7EbYlIG
 /95Q==
X-Gm-Message-State: AOJu0YyFH76dJQRSb/c+tElDolN3PS9D97om8rIGNI4+byegvuSTQlbV
 Dbvnb19PkBhZuXkNaW2i1YqE24sC7PuL/AFf6+w5hj0urXFtoW3j7bmCaBRmXSKNBOkD/HcQzuY
 LAQ1RboLlhDIMXEegNyA31DuBw6kpbXgWhMzH8igDaVLlFmgnNbZ9lKlw5Ex1/RPLvuNiJHH9MP
 Pn1lQ+78CV/hSL0mAJXIReqPrZTL0=
X-Received: by 2002:a17:902:fc44:b0:20c:5e86:9b68 with SMTP id
 d9443c01a7336-20c636dd37emr29854215ad.4.1728459677556; 
 Wed, 09 Oct 2024 00:41:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRfT8NvbtIECls9ofrd2l2nBLBC/r+J7S5+Vs7ork6Z0GAtlZUy0+xTHwkSidRIBFDCjpAeQY3BJSFrUnc7D8=
X-Received: by 2002:a17:902:fc44:b0:20c:5e86:9b68 with SMTP id
 d9443c01a7336-20c636dd37emr29853875ad.4.1728459677092; Wed, 09 Oct 2024
 00:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20241008-macvtap-v1-1-2032caa25b6d@daynix.com>
In-Reply-To: <20241008-macvtap-v1-1-2032caa25b6d@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Oct 2024 15:41:06 +0800
Message-ID: <CACGkMEvmEsFdLRgF9CLQCEo0jt3dX8wAPLjRC2pNb4ofD8dLNQ@mail.gmail.com>
Subject: Re: [PATCH] tap-linux: Open ipvtap and macvtap
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Tue, Oct 8, 2024 at 2:52=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> ipvtap and macvtap create a file for each interface unlike tuntap, which
> creates one file shared by all interfaces. Try to open a file dedicated
> to the interface first for ipvtap and macvtap.
>

Management layers usually pass these fds via SCM_RIGHTS. Is this for
testing purposes? (Note that we can use something like -netdev
tap,fd=3D10 10<>/dev/tap0).

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  net/tap-linux.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/net/tap-linux.c b/net/tap-linux.c
> index 1226d5fda2d9..22ec2f45d2b7 100644
> --- a/net/tap-linux.c
> +++ b/net/tap-linux.c
> @@ -45,10 +45,21 @@ int tap_open(char *ifname, int ifname_size, int *vnet=
_hdr,
>      int len =3D sizeof(struct virtio_net_hdr);
>      unsigned int features;
>
> -    fd =3D RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
> +
> +    ret =3D if_nametoindex(ifname);
> +    if (ret) {
> +        g_autofree char *file =3D g_strdup_printf("/dev/tap%d", ret);
> +        fd =3D open(file, O_RDWR);
> +    } else {
> +        fd =3D -1;
> +    }
> +
>      if (fd < 0) {
> -        error_setg_errno(errp, errno, "could not open %s", PATH_NET_TUN)=
;
> -        return -1;
> +        fd =3D RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));

Any reason tuntap were tried after the macvtap/ipvtap?

> +        if (fd < 0) {
> +            error_setg_errno(errp, errno, "could not open %s", PATH_NET_=
TUN);
> +            return -1;
> +        }
>      }
>      memset(&ifr, 0, sizeof(ifr));
>      ifr.ifr_flags =3D IFF_TAP | IFF_NO_PI;
>
> ---
> base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
> change-id: 20241008-macvtap-b152e5abb457
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>

Thanks

>


