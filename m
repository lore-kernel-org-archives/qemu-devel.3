Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BD1D3E798
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 09:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8cI5-0002ma-QY; Wed, 06 Nov 2024 04:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t8cI3-0002eR-3n
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:25:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t8cI1-0005mk-7X
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730885124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mllvCjcjfwWnIM8yDqoSazmb0uURCBr6afosmhj8vvI=;
 b=Qe5NFDPE9GDkcvJ5zqsVWBY6wcRKH+xjZdW77s+2C+3nskr1Yr/walOin/AowWKZUQYGO5
 5Y3FBxOEN/tRSBwHpL5Yw1YybUsfW9uvuurDhgudJM8KTLDZPf5EmVg/8mV0OhEadt8BkA
 ejNIZ+Sq3d/QlfqcrACRsUaKccDEWZA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348--w_ZK998MUSV9cPkyvgsWg-1; Wed, 06 Nov 2024 04:25:20 -0500
X-MC-Unique: -w_ZK998MUSV9cPkyvgsWg-1
X-Mimecast-MFC-AGG-ID: -w_ZK998MUSV9cPkyvgsWg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d662dd3c8so3330592f8f.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 01:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730885119; x=1731489919;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mllvCjcjfwWnIM8yDqoSazmb0uURCBr6afosmhj8vvI=;
 b=j+rKelp0A+1Zps4HBWsbh4aX0irVRLO4OdjMT0M2JDJSJECqNVLTAJddWoRSpnLAOx
 0F4ZkZy3MKVT0JpUx8IMX39A/kN90b1nUJpF0TPPTrN9G/QOUl8K4vMcGqNf8vmtQE9s
 wTKG+xl2ypt5AMaqiZ5GshZg7Lo8lODsSGQ9kSvZgM+OgM1mSILWYJAnpMs6eetnKIZ8
 FJkk9JTwK5JNekYsrCc9OsrkZyPF7SZz8cqC9VOevBcLDegqpf+8d0ccUDm8gXhtYTAJ
 FPujKXo+SoGlc33f1sHqMeVT5iYP9Rev7c2uThM8UghTw9NSQHZFcc2cUUwPPd1tJxic
 K63w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxiE47UQM7Ec/McxANoz/s3ssLvlnfOX8eGPChzCd9Em2syXGL7E5Bp+LVoidqXqRuL7uSVq+aAtdF@nongnu.org
X-Gm-Message-State: AOJu0YyXc99DZahLzOTVz10o7fG2fiZcF4z3rvEhfNQmnektPFDj5Onz
 culwomDjurr7foPV7YfxPUD3sAd/69ZOJstW0VynFH4zBScvh1rkkxl7Ek4jJfOOdexV+ua8c1i
 lhgzv8MEOAuojB+faf5v1UP6formN19N6NJ9XMfR87+rank0jEaXw
X-Received: by 2002:adf:f802:0:b0:37c:d2f3:b3af with SMTP id
 ffacd0b85a97d-381b705688bmr17327957f8f.5.1730885119213; 
 Wed, 06 Nov 2024 01:25:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTxe0HXPe75pwj4/Mx2rCUu30TSayB1plmErQRpwwg/VCJzPZOakG4CZd+fGRcNh56SXEoeQ==
X-Received: by 2002:adf:f802:0:b0:37c:d2f3:b3af with SMTP id
 ffacd0b85a97d-381b705688bmr17327944f8f.5.1730885118822; 
 Wed, 06 Nov 2024 01:25:18 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e6b5sm18793647f8f.88.2024.11.06.01.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 01:25:17 -0800 (PST)
Date: Wed, 6 Nov 2024 04:25:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/4] vhost_vdpa : Add a new parameter to enable check
 mac address
Message-ID: <20241106042219-mutt-send-email-mst@kernel.org>
References: <20241026080121.461781-1-lulu@redhat.com>
 <20241026080121.461781-2-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026080121.461781-2-lulu@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Oct 26, 2024 at 03:59:59PM +0800, Cindy Lu wrote:
> When using a VDPA device, it's important to ensure that the MAC
> address is correctly set.
> Add a new parameter in qemu cmdline to enable this check, default value
> is false
> 
> The usage is:
> ....
> -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,id=vhost-vdpa0,macstrickcheck=true\

typos in command line are not welcome.
you should also separate words e.g. by dashes.
Are there more options than strict?
Also if not strict, should we still warn?


> -device virtio-net-pci,netdev=vhost-vdpa0\
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
> index c8f679761b..e00651a97b 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -112,6 +112,7 @@ struct NetClientState {
>      bool is_netdev;
>      bool do_not_pad; /* do not pad to the minimum ethernet frame length */
>      bool is_datapath;
> +    bool check_mac;
>      QTAILQ_HEAD(, NetFilterState) filters;
>  };
>  
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 46b02c50be..071c3ff065 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1860,6 +1860,8 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
>                                       iova_range, features, shared, errp);
>          if (!ncs[i])
>              goto err;
> +
> +        ncs[i]->check_mac = opts->macstrickcheck;
>      }
>  
>      if (has_cvq) {
> @@ -1872,6 +1874,8 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
>                                   errp);
>          if (!nc)
>              goto err;
> +
> +        nc->check_mac = opts->macstrickcheck;
>      }
>  
>      return 0;
> diff --git a/qapi/net.json b/qapi/net.json
> index 87fc0d0b28..7d75119858 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -510,6 +510,10 @@
>  # @queues: number of queues to be created for multiqueue vhost-vdpa
>  #     (default: 1)
>  #
> +# @macstrickcheck: Enable the check for whether the device's MAC address
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
> +    '*macstrickcheck':    'bool',
>      '*x-svq':        {'type': 'bool', 'features' : [ 'unstable'] } } }
>  
>  ##
> -- 
> 2.45.0


