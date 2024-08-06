Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4836C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbKNL-0006lM-W3; Tue, 06 Aug 2024 09:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sbKNH-0006V8-M0
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 09:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sbKNC-0006pv-BG
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 09:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722951428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s0Azy5IqZ41TCP/WCbxsy2VM9SX9V8d+xsx3W+hTjbY=;
 b=Yf9HDhrETMGAVyBjPGnQGOCPWp953D21dfbAvsxu7PkP5gVGA7kgWHoFe8kDeGASw1JOs8
 X8PirO9tw5cLewukYTQY7o4JkLFnpoYRN/gOrI6+VsWEaXn7QEMTBGbzrOD2qBZqNxD4V3
 LotFO7g50dAXEoU1j7+MQOA3vxSWqYU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-vgThdpK0OsCMUbymB6Vj1Q-1; Tue, 06 Aug 2024 09:37:05 -0400
X-MC-Unique: vgThdpK0OsCMUbymB6Vj1Q-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2f18429ce00so5935371fa.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 06:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722951424; x=1723556224;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s0Azy5IqZ41TCP/WCbxsy2VM9SX9V8d+xsx3W+hTjbY=;
 b=mzuKJLDD3sx6pPU/Cr6JE2ssUItsGd+PGgHkFK/5+Gw6pJ9nzM3ChzEt2hBZ5R1MJ0
 CFBnkzsiRcUeeQRhYhBAAS/RshKR/lxW8K5qRZKjlDxPLjv0g3gfytmCfauNkR7pxSZp
 ETeDe//OJxyOPrHbH03ew4uAHvEnRlQ9qZ7/5A3Lly5QEqLw87qplmecqzon5Z+XSf2s
 a8vtC12v+gAIG283nQK2kNnGxJgQxIqqNJhRhj3StlPhW9yTDn0ug2lcxZxPH0UlQSSO
 UOte8LIZja4b/Q5s0rkQK5nGvIbYG6uYdK0tlKVSpGnxeXh7YEmxdKcq1O3hxgFzJXAx
 O5GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV04JuC9tgJkGWAASxdIOVd5UMLO2t1kI808IPuJDH50tMlsQcyIXJVPc4ge6Z3jUcbbORxs/bOrqn9@nongnu.org
X-Gm-Message-State: AOJu0YwrQGiKIl1N5L09XptC2t+tcsYZNl+1XIwo+90AT2A/NdaHObmH
 ICXqb0gd8FPPAC5l6yF7AOo9h7W3EFMQG6F3EMZt2PWb0IY573Jir6teFLcVDKnPhQctgNQa2FI
 UQcWZBx3mNOTnEg5uh6/G6w8k91tQEc6grr3NykkrQu3jG5LLHDMs
X-Received: by 2002:a05:6000:156e:b0:360:8c88:ab82 with SMTP id
 ffacd0b85a97d-36bbbeefe27mr16409177f8f.30.1722951035939; 
 Tue, 06 Aug 2024 06:30:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqvw0eH3+3qQ9AF5AQ6WDIO6ESB2IvDxX/qux9Igzn9we9Z73ZJVj/YF24ncuuYR73NS485A==
X-Received: by 2002:a05:6000:156e:b0:360:8c88:ab82 with SMTP id
 ffacd0b85a97d-36bbbeefe27mr16408981f8f.30.1722951033086; 
 Tue, 06 Aug 2024 06:30:33 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:c9eb:d9d4:606a:87dc:59c7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0ccc5sm13123697f8f.23.2024.08.06.06.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 06:30:32 -0700 (PDT)
Date: Tue, 6 Aug 2024 09:30:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] virtio_net: Add the check for vdpa's mac address
Message-ID: <20240806093013-mutt-send-email-mst@kernel.org>
References: <20240806005814.51651-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806005814.51651-1-lulu@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 06, 2024 at 08:58:01AM +0800, Cindy Lu wrote:
> When using a VDPA device, it is important to ensure that
> the MAC address in the hardware matches the MAC address
> from the QEMU command line.
> This will allow the device to boot.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Always post threads with a cover letter please.

> ---
>  hw/net/virtio-net.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 9c7e85caea..7f51bd0dd3 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3579,12 +3579,36 @@ static bool failover_hide_primary_device(DeviceListener *listener,
>      /* failover_primary_hidden is set during feature negotiation */
>      return qatomic_read(&n->failover_primary_hidden);
>  }
> +static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n, MACAddr *cmdline_mac,
> +				      Error **errp)
> +{
> +	struct virtio_net_config hwcfg = {};
> +	static const MACAddr zero = { .a = { 0, 0, 0, 0, 0, 0 } };
> +
> +	vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&hwcfg, ETH_ALEN);
> +
> +    /*
> +     * For VDPA device: Only two situations are acceptable:
> +     * 1.The hardware MAC address is the same as the QEMU command line MAC
> +     *   address, and both of them are not 0.
> +     */
> +
> +	if (memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) != 0) {
> +		if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) == 0)) {
> +			return true;
> +		}
> +	}
> +	error_setg(errp, "vDPA device's mac != the mac address from qemu cmdline"
> +			 "Please check the the vdpa device's setting.");
>  
> +	return false;
> +}
>  static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>      VirtIONet *n = VIRTIO_NET(dev);
>      NetClientState *nc;
> +    MACAddr macaddr_cmdline;
>      int i;
>  
>      if (n->net_conf.mtu) {
> @@ -3692,6 +3716,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>      virtio_net_add_queue(n, 0);
>  
>      n->ctrl_vq = virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
> +    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac));
>      qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
>      memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
>      n->status = VIRTIO_NET_S_LINK_UP;
> @@ -3739,10 +3764,10 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>      nc->rxfilter_notify_enabled = 1;
>  
>     if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> -        struct virtio_net_config netcfg = {};
> -        memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> -        vhost_net_set_config(get_vhost_net(nc->peer),
> -            (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONTEND);
> +	   if (!virtio_net_check_vdpa_mac(nc, n, &macaddr_cmdline, errp)) {
> +		   virtio_cleanup(vdev);
> +		   return;
> +	   }
>      }
>      QTAILQ_INIT(&n->rsc_chains);
>      n->qdev = dev;
> -- 
> 2.45.0


