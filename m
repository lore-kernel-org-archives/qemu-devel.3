Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A249C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 16:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0157-0002OY-Dt; Wed, 02 Apr 2025 12:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u0155-0002Ha-0D
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:36:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u0153-00088D-CI
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743611804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GvkZmsMSDWAE7PNxVmR1iG9iiOLjRLE9Z4mYOZspWg4=;
 b=DF5Z2ve25wXUaoVVErNzwgdgkEfJmZi5Kd1UQ7chMhVVKDirvaWBAalp3A8gywX8R3neKH
 XtvZRWwowIRqCupuvXc9PV+dXx5FJCOltV2L6GB0sH7bQgW29+2fyvAGdy39/p+zP8F2ca
 QikR4Plm8No7ON19+kUw99wmPCT4sNw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-TwdqcvpYPvOzT_C2XoM2mg-1; Wed, 02 Apr 2025 12:36:42 -0400
X-MC-Unique: TwdqcvpYPvOzT_C2XoM2mg-1
X-Mimecast-MFC-AGG-ID: TwdqcvpYPvOzT_C2XoM2mg_1743611801
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43947a0919aso53318955e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 09:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743611801; x=1744216601;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GvkZmsMSDWAE7PNxVmR1iG9iiOLjRLE9Z4mYOZspWg4=;
 b=wU28Abhm4iqL0gEI/AdsD0mds30ENYKrJn81N6T8giJ6PwrsVe0yMOQRLdkI3sArEi
 nLXRJandVlFp9eS4LAknvNN7pXPyV2XI0KR0aBk1FotKKuptctj9f7ybDGzKpWrMPuKr
 ZFiLIdPxKVwT3Mr8KsvjcBt/wVU26Lela/KHjV7XS6w37HUnIR8ZYn6xkYffGPcYYLvm
 pC1ckWcmMWgmqo5uT4q9VcJou+iO/Pzi7aupAaoSX7SSxCgyOzw0fzbJczOJrf6tXzg8
 LkgWROe/L0Unh9maOS90aoouCyQitlG3aXSKhQXlnj8Rv9cpHpLaYxihCuEY5G+F4onB
 72eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNZz7Zoz/tvzUtlqHcGDl8z4Eni73bME9OF0LylJqzUjhUKZEt+YbDj5KdyMFdLiRLNPY86DNLkXuP@nongnu.org
X-Gm-Message-State: AOJu0Yx0twMDuiPYmZ79CmGJj2wgirQAfzB6ciPei1eUwfaI1Pb2WMWQ
 Yz1+C8ya1G3W0DYnYiUPJMUfryttjHWk2VP0zekWNhQP1rz/hYLv/fZULo6VDVBwjOUaSNUko9N
 nqI0PMMddj7AztcuMZm4OmWppp2EatoGYGkvtzYkefBQWZdrSFTMm1u7yiLHZ
X-Gm-Gg: ASbGncu/tsNq0QDVHImWJQu8P6vtxV7ldve4bx26bmbln1gAHMRk31M6x4u/APUlnM9
 D93otM5SR9fzFQP27+qVxBBCEGkIRPzcVpwrZFM7oywqZNvrh1BPxdgVdQ8NEbg/QSiOOmVouqz
 5uEdFn6eR4sjm5IqLOGmwp9bgAoLSDMaQNV6QP8ssUAMA95Q6sJ8H7Yb9QESKGJ6CWpW5D8dAza
 ATPnlMyKQzFdzbraYePFRbB5e1DhSomgGic7JTcXH0lNtWIVda27ptZGC3xU3ebLIFpcFUym9Ls
 tqvL5r7feg==
X-Received: by 2002:a05:600c:3d0a:b0:43d:fa59:be38 with SMTP id
 5b1f17b1804b1-43dfa59c013mr147014715e9.32.1743611800900; 
 Wed, 02 Apr 2025 09:36:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQE2yw9Pp+9hEsVxzINW5ebkVNypELyRTwrtjXxDmqoP5iDnw1N25Vmg2q1y0tn/UxG00iQQ==
X-Received: by 2002:a05:600c:3d0a:b0:43d:fa59:be38 with SMTP id
 5b1f17b1804b1-43dfa59c013mr147014595e9.32.1743611800619; 
 Wed, 02 Apr 2025 09:36:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a41c0sm17114684f8f.88.2025.04.02.09.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 09:36:39 -0700 (PDT)
Date: Wed, 2 Apr 2025 12:36:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 0/4] virtio_net: Add the check for vdpa's mac address
Message-ID: <20250402123627-mutt-send-email-mst@kernel.org>
References: <20250326132021.1215568-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326132021.1215568-1-lulu@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

On Wed, Mar 26, 2025 at 09:19:29PM +0800, Cindy Lu wrote:
> When using a VDPA device, it is important to ensure that the MAC address
> is correctly set. In this patch series, we add a new parameter to
> enable this check.
> Only three MAC setup configurations are acceptable; any other will
> fail to boot.
> 
> The usage is:
> ....
> -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,id=vhost-vdpa0,check-mac=true\
> -device virtio-net-pci,netdev=vhost-vdpa0\
> ....
> 
> tested by ConnectX-6 Dx/vdpa_sim device
> 
> change in v3
> 1. add a new parameter to enable the check and keep the old behavior
> 2. adjust the comment and make it more clear
> 
> change in v4
> 1. change the new parameter's name to check-mac
> 2. change the comment and make it more clear
> 
> change in v5
> 1.These patches haven't been merged for a while, so I rebased
>   them with the latest code and resubmitted
> 
> Cindy Lu (4):
>   vhost_vdpa : Add a new parameter to enable check mac address
>   virtio_net: Add the check for vdpa's mac address
>   virtio_net: Add second acceptable configuration for MAC setup
>   virtio_net: Add third acceptable configuration for MAC setup.
> 
>  hw/net/virtio-net.c | 67 ++++++++++++++++++++++++++++++++++++++++++++-
>  include/net/net.h   |  1 +
>  net/vhost-vdpa.c    |  4 +++
>  qapi/net.json       |  5 ++++
>  4 files changed, 76 insertions(+), 1 deletion(-)


some minor nits.

> -- 
> 2.45.0


