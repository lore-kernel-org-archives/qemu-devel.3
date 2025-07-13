Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DBDC83F17
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Jul 2025 13:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uawQZ-0000am-Am; Sun, 13 Jul 2025 09:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uawPW-0000Ir-9h
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 09:06:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uawPU-0005rB-6W
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 09:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752411985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OZ7DFGM4h3wwXXGccC52KVAC5yN9Y5zw8awmuxOwTcc=;
 b=U/P9NVMPLre+sgEjnm6OTkjXHZ5YcHefNZrF9tNy86tSjPcr7oFQ81DCPUh0r31O0r+Cvx
 xK16K8hjdVR6qVPqsNVITgCsfnsF/f7J7b25bTsQrKpvyI/cOGd9IoIRtX66iOKOwlLFY4
 nAS8OFCsEdpMQ/kuQDHLKoM8yo4jexE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-mm_l9UQXODyqRPhYYC6tww-1; Sun, 13 Jul 2025 09:06:24 -0400
X-MC-Unique: mm_l9UQXODyqRPhYYC6tww-1
X-Mimecast-MFC-AGG-ID: mm_l9UQXODyqRPhYYC6tww_1752411983
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a5058f9ef4so1419583f8f.2
 for <qemu-devel@nongnu.org>; Sun, 13 Jul 2025 06:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752411983; x=1753016783;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZ7DFGM4h3wwXXGccC52KVAC5yN9Y5zw8awmuxOwTcc=;
 b=DpkI+DIhwxKgk1EiOJqb372ukrRqrY5xBB3mzS1MEYjvd84t9hacoQ8VEFeKeXVZ/r
 xOMXJ68DkfJ3PP4zjpJLH5ILiRXR6UXD0tpUIu1IUjbWn3CJeioidU+I7Cfd0XTaFJAo
 04joRzDWKU3JVqRrAtq0EMty300E2h6aT5IIKBQOFArsV/p6yrRlYM0ZD2VgUmArNfcW
 JeZAQ1ydKtUknoZe0tjk/muCVfmlTmx6KkS+P45mcRscNFsNRL5ZKPLbEapP8HeXKwNg
 ur4+LN4gOVWHwtO7zWypND/BraBRdbqXM6aMadvfUzNVckRfFsRR+uCH9cnbbAJMWcLC
 5/wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX00tQCLrO8DdTqvMMnud9yJNXikky4W3iw6qTOkUd/b1ihf48w+f+i9gRu459mleRf5LfAiyoNhCsf@nongnu.org
X-Gm-Message-State: AOJu0YwZvrCX8xxMkzXokya5ILLGLCQ7UYu6JOStlFbUuaU1SzhQ2Kxo
 324b6cfxEpKXgpy0GME7ReCu0NUgGPwW9aRmR8fu2RyhIpDbu7Xzj45tcwIs1ZwigdfPfGGuZEP
 gHSljFfmE37zFD7SqIU0NtufCX5aXay1RcmYuKZk+wRM8xQMe4l27A6Ki
X-Gm-Gg: ASbGnctjdy8yzS6k5xnkfkwAmoHkgQMl1B7VwmSVKkZJT7IFBZSmgzbuv64PhA6RSxF
 F71zm6x9a5vgo51+aIH3zsVH8J8Ok8DR2bH7oQzBbTk1J7a5k5zKoStt0qC5KvqHdQSKDU23diP
 Ux9o+1cKWYqixAHg6FY2GBUR9pB6ug6zzn9acYUpXgTbYiaUnI1UK1CUi2AMf6tGRSxkXI0TA/x
 8/0pk4VMZYSBr/fHfNH8nBKCdw5PlOzmq5IJ9Nghba2BUpJdq2mQfdsBMbFKDjXq5mYKdBF4zke
 9+G5xEAfLxH3WB9AGx4muhFJfoYNu4Ne
X-Received: by 2002:a05:6000:4310:b0:3b3:a6c2:1a10 with SMTP id
 ffacd0b85a97d-3b5f351eb04mr7209977f8f.12.1752411982749; 
 Sun, 13 Jul 2025 06:06:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE2ys4qL9+YtIzIALr0+tTYJaMx4eY/a4wPb9tFRfyrsCkVtVpx+ZFnEMifQUzh4YJURVoTg==
X-Received: by 2002:a05:6000:4310:b0:3b3:a6c2:1a10 with SMTP id
 ffacd0b85a97d-3b5f351eb04mr7209936f8f.12.1752411982244; 
 Sun, 13 Jul 2025 06:06:22 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-455f7ddd667sm58219305e9.34.2025.07.13.06.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Jul 2025 06:06:21 -0700 (PDT)
Date: Sun, 13 Jul 2025 09:06:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Konstantin Shkolnyy <kshk@linux.ibm.com>, qemu-devel@nongnu.org,
 yin31149@gmail.com, eperezma@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux.dev
Subject: Re: [PATCH RFC] virtio-net: Fix VLAN filter table initialization
 timing
Message-ID: <20250713090209-mutt-send-email-mst@kernel.org>
References: <20250713-vlan-v1-1-a3cf0bcfa644@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-vlan-v1-1-a3cf0bcfa644@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Jul 13, 2025 at 08:52:43PM +0900, Akihiko Odaki wrote:
> The VLAN filter table was not being properly initialized when the driver
> sets the DRIVER_OK status bit, causing incorrect VLAN filtering behavior
> that could allow unintended VLAN packets to pass through. Correct the
> table initialization timing to fix the issue.
> 
> Problem
> -------
> 
> The expected initial state of the table depends on feature negotiation:
> 
> With VIRTIO_NET_F_CTRL_VLAN:
>   The table must be empty in accordance with the specification.
> Without VIRTIO_NET_F_CTRL_VLAN:
>   The table should be filled to permit all VLAN traffic.
> 
> Prior to commit  ("virtio-net: do not reset vlan filtering at
> set_features"), virtio_net_set_features() always initialized the VLAN
> table. That commit changed the behavior to skip initialization when
> VIRTIO_NET_F_CTRL_VLAN was negotiated, assuming the table would be
> properly cleared during reset and remain stable.
> 
> However, this assumption breaks when a driver renegotiates features:
> 1. Initial negotiation without VIRTIO_NET_F_CTRL_VLAN (table filled)
> 2. Renegotiation with VIRTIO_NET_F_CTRL_VLAN (table will not be cleared)
> 
> The problem was exacerbated by commit 0caed25cd171 ("virtio: Call
> set_features during reset"), which triggered virtio_net_set_features()
> during reset, exposing the bug whenever VIRTIO_NET_F_CTRL_VLAN was
> negotiated after a reset.
> 
> Solution
> --------
> 
> Fix by moving VLAN table initialization to virtio_net_set_status(),
> which sets the DRIVER_OK status bit. This ensures proper table
> initialization regardless of feature negotiation sequence.
> 
> Fixes: 06b636a1e2ad ("virtio-net: do not reset vlan filtering at set_features")
> Reported-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

A bit worried about legacy drivers that might use device before
DRIVER_OK, is that a problem?


> ---
> Not tested.
> 
> Konstantin, please see if this patch fixes your workload.
> ---
>  hw/net/virtio-net.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 221252e00a50a46033d7ec8d18936e7c8196a6ca..6d2a67471e570e1e9b4b4fb5338d87c30e23ae36 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -389,6 +389,12 @@ static int virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
>      int i;
>      uint8_t queue_status;
>  
> +    if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +        !(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +        bool vlan = virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VLAN);
> +        memset(n->vlans, vlan ? 0 : 0xff, MAX_VLAN >> 3);
> +    }
> +
>      virtio_net_vnet_endian_status(n, status);
>      virtio_net_vhost_status(n, status);
>  
> @@ -998,10 +1004,6 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
>          vhost_net_save_acked_features(nc->peer);
>      }
>  
> -    if (!virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
> -        memset(n->vlans, 0xff, MAX_VLAN >> 3);
> -    }
> -
>      if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
>          qapi_event_send_failover_negotiated(n->netclient_name);
>          qatomic_set(&n->failover_primary_hidden, false);
> @@ -3990,7 +3992,6 @@ static void virtio_net_reset(VirtIODevice *vdev)
>      memset(n->mac_table.macs, 0, MAC_TABLE_ENTRIES * ETH_ALEN);
>      memcpy(&n->mac[0], &n->nic->conf->macaddr, sizeof(n->mac));
>      qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
> -    memset(n->vlans, 0, MAX_VLAN >> 3);
>  
>      /* Flush any async TX */
>      for (i = 0;  i < n->max_queue_pairs; i++) {
> 
> ---
> base-commit: f0737158b483e7ec2b2512145aeab888b85cc1f7
> change-id: 20250713-vlan-8c107a65ad91
> 
> Best regards,
> -- 
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


