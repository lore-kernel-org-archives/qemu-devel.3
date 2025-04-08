Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D505C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 06:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u22bg-00087y-DN; Tue, 08 Apr 2025 02:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u22be-00087X-1e
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 02:38:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u22bc-00050f-7G
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 02:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744094320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJTL9w6fbdd97u5XdFWZjMvzzdsOQEF1xKhIUfuc5BM=;
 b=Cil/jJqjp89Hmzi9V7ENe/HB+oJeFqjr9JqZyLlHXf593d/SyP3EmEQOdXuauFQx0nyks7
 ajJ5h8h5pAqhMjbz4ZANlNZvhayWUsxTrdwAJ1jyWEzvjoqAg1WA+fnZmtcSTvEOQXEdLz
 A+JdWKxQDfVDnQv6UidQCDTMPmSLAOc=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-fWYBRozSOf69fYoi3n1H6Q-1; Tue, 08 Apr 2025 02:38:39 -0400
X-MC-Unique: fWYBRozSOf69fYoi3n1H6Q-1
X-Mimecast-MFC-AGG-ID: fWYBRozSOf69fYoi3n1H6Q_1744094319
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-86c8754d0d0so689804241.3
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 23:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744094319; x=1744699119;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJTL9w6fbdd97u5XdFWZjMvzzdsOQEF1xKhIUfuc5BM=;
 b=YxpZWhmDfbHKsEKbz6OqgEnxpjEzV99U2ZnOiYa0o8l8lxOZRP5l/BQAi09YJZa/Qy
 FVh8V6MCzEmRtsQujJ25xixuTrYn6WNILGVEoyYD3GsemHLJToiVnFeRA5fHTxiUK6tP
 NVYLmj8w6KfJTfpfDfPvnRR/zCf72a+yPng/kA6Q/Fbswh1O3150fMJJMR3xWZna+LhT
 YYZ25CMHziBjiQSrlc0l/p+5+WHMEcM75zQc7alcMk4IVAaVN3GguZ1lEl5CtYjtGcVb
 z+5urSqJ6h6hcZBSeK6Id54jvMLhvAKqVT3yBFWIuIfaohe6mO+Ms8KYxEAnR+VX87Jw
 +3XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvgpPIX5JnvHEmZtEw3TENwm9rcA5BqB77pB7ltd5hkI8l3oKyR6FVsNexN7NNyCJmwk7Ua/bJ0j9S@nongnu.org
X-Gm-Message-State: AOJu0YwRtUMa3UXZozYpYMQd91zVI2D8vFtMD7oTQvCGt+PQF39yKA3R
 im6hqCmRBEk3+0YRH5i5Od2lZFFCUfQKEqmzUkkNYkREVO5xfoeXWBp1gt8uGhhnO/Pp2m0GUtU
 DP5Zf2vdvaJZ+zxVZ+DCHOUoM7cUpInU1sUKn8Wsq7U6jpVan+rwxWgYpbSZg2nTjKjFuhx/r48
 5+MSja6sfedl9IXlbw6DJxj17mOyA=
X-Gm-Gg: ASbGnctrPihwxhczw/fEWoT+08v2w2nXUJr8K29nmKPKDK8HZ9UvAIpY8o3p7C6O9Vh
 DVuVnouGz25QuApwUyUfd3zcZ8VEeVBM7H4EqC7GCgR+yyzB+BV8QT7NI9tmuRshOM4uMh/8y
X-Received: by 2002:a05:6102:3e07:b0:4c1:86a7:74e9 with SMTP id
 ada2fe7eead31-4c8636646f4mr8946904137.10.1744094318759; 
 Mon, 07 Apr 2025 23:38:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXOe6IuNY2vaB3tJ95CEFatKiv0cA7XK09kfGi+sv8dJe+VOPQbZm1cHbHWy6W0PcE2kH0LQNYha8wD91sAV0=
X-Received: by 2002:a05:6102:3e07:b0:4c1:86a7:74e9 with SMTP id
 ada2fe7eead31-4c8636646f4mr8946895137.10.1744094318388; Mon, 07 Apr 2025
 23:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250408061327.2590372-1-lulu@redhat.com>
 <20250408061327.2590372-2-lulu@redhat.com>
In-Reply-To: <20250408061327.2590372-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Apr 2025 14:38:26 +0800
X-Gm-Features: ATxdqUGSP1XsCC-Bb-bNKHLvQLte3fe7H2N2bRvvDYQu5tLgRiTU5B52T6bYzFE
Message-ID: <CACGkMEt5CzZFfainmRA2jPSDx2EgY6QvfyRHpUMZ=GamcxFWzQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] vhost_vdpa : Add a new parameter to enable check
 mac address
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 8, 2025 at 2:13=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> When using a VDPA device, it's important to ensure that the MAC
> address is correctly set.
> Add a new parameter in qemu cmdline to enable this check, default value
> is false
>
> The usage is:
> ....
> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0,c=
heck-mac=3Dtrue\
> -device virtio-net-pci,netdev=3Dvhost-vdpa0\
> ....
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  include/net/net.h | 1 +
>  net/vhost-vdpa.c  | 4 ++++
>  qapi/net.json     | 5 +++++
>  3 files changed, 10 insertions(+)
>
> diff --git a/include/net/net.h b/include/net/net.h
> index cdd5b109b0..fac1951b6e 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -112,6 +112,7 @@ struct NetClientState {
>      bool is_netdev;
>      bool do_not_pad; /* do not pad to the minimum ethernet frame length =
*/
>      bool is_datapath;
> +    bool check_mac;
>      QTAILQ_HEAD(, NetFilterState) filters;
>  };
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 7ca8b46eee..ba1da31741 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1870,6 +1870,8 @@ int net_init_vhost_vdpa(const Netdev *netdev, const=
 char *name,
>                                       iova_range, features, shared, errp)=
;
>          if (!ncs[i])
>              goto err;
> +
> +        ncs[i]->check_mac =3D opts->check_mac;
>      }
>
>      if (has_cvq) {
> @@ -1882,6 +1884,8 @@ int net_init_vhost_vdpa(const Netdev *netdev, const=
 char *name,
>                                   errp);
>          if (!nc)
>              goto err;
> +
> +        nc->check_mac =3D opts->check_mac;

Unless we need to iterate all the ncs during the startup, I think it
would be sufficient to store it in nc[0]?

>      }
>
>      return 0;
> diff --git a/qapi/net.json b/qapi/net.json
> index 310cc4fd19..a5c70d1df8 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -510,6 +510,10 @@
>  # @queues: number of queues to be created for multiqueue vhost-vdpa
>  #     (default: 1)
>  #
> +# @check-mac: Enable the check for whether the device's MAC address
> +#     and the MAC in QEMU command line are acceptable for booting.
> +#     (default: false)
> +#
>  # @x-svq: Start device with (experimental) shadow virtqueue.  (Since
>  #     7.1) (default: false)
>  #
> @@ -524,6 +528,7 @@
>      '*vhostdev':     'str',
>      '*vhostfd':      'str',
>      '*queues':       'int',
> +    '*check-mac':    'bool',

To make this more useful, we probably need to make it true by default
and do the compatibility work. Btw, while at it, do we need to check
MTU as well?

Thanks

>      '*x-svq':        {'type': 'bool', 'features' : [ 'unstable'] } } }
>
>  ##
> --
> 2.45.0
>


