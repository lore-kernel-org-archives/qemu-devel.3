Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5595C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 16:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u014r-0001tK-8O; Wed, 02 Apr 2025 12:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u014l-0001r6-HV
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:36:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u014h-00086K-FI
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743611782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FcDSAxRphFGpDcpQy4vZY/XBWtSsUNfjL7iKsb539eQ=;
 b=MlN/4MEVYOg6OH4Jt+BgVy2oNX22tq806K4O4vHRbraZPlBEma9LenYrvV/20bjX3LbAZK
 Vf4Mm38S97lMhh2MG8LWsJNid9vXCjiOZB786IAFQvQOkAn6geMlrW66IOS4xpZT0t4mcV
 gMMhKoc2eM3C4NULLY3FmdrNcacZUzg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-o83hfeRIN_OIDGz1GkwI6A-1; Wed, 02 Apr 2025 12:36:20 -0400
X-MC-Unique: o83hfeRIN_OIDGz1GkwI6A-1
X-Mimecast-MFC-AGG-ID: o83hfeRIN_OIDGz1GkwI6A_1743611780
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d00017e9dso47456665e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 09:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743611780; x=1744216580;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcDSAxRphFGpDcpQy4vZY/XBWtSsUNfjL7iKsb539eQ=;
 b=V6qYmz6Ee7+yQR+P4m6+NtJmSVicx8qN9FUEANjX4lYw1tNb0ePrjgoUtBbyfvYgSz
 Vx0M3KmvQW5RNL/US9c7JYAAKMm6fypsBwi8NX5J1yO7BNx9YW76RJ2N5hNFEbxgXMZ+
 zs5an3bSPTTbCyp+yGkddCSTw8Wu5DvRNkLoOAp+nwOq8kSPHtfEboRrz+3oZX3TURAV
 EtAtF7lCNxPIf5PBeHrl2VvZ24DZlF1FByj7cznt64FoHGRg1oOsY1frgreUKRd4gaPD
 quR17Nzan3OwXo+E7W0EvXM+vWp94+bq+S9oNvr4xx/08zizZlfM11ef2os1HgiWIVJU
 eJtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqa3+EN5Lv1fpfl62JVf+ccZTeRVwUUVgLv93dOVKtC5tWMK5rFJ5yeqbPT05uDJlp0tNucsT5i6zu@nongnu.org
X-Gm-Message-State: AOJu0Yx2H1KCeduIoZG0G3i0fZXlCl65lVJgYaimSUa35cS9aA7TwEVc
 28UGjrs7/a2S9lD6LJerGGnnP8bCRd4rCci3PepC6v6W7wGQ0ZSE2+UDyQFX5wIHOCUDEfJgq/C
 45wiyYDPV1hEbq6XQJpKDVwFJojj3I6h9VFul7zTn0AI4bPapH63+
X-Gm-Gg: ASbGnct1GAoEwGsHA8ATisjQKLX+ERVjvOH2W8rBBx7PiRHUr+LsrPCPwYoaFD2Q0kI
 bHLw9VvYnacLDcemySRcB6RJyVwvVIozlLxbThgmuLrd3b/KBiVEW2p6dgwHewtmKEcKUolqu+0
 r2AM6gk0brpdcmdbasmeD4ilDlBoaE6Yq4HeUW+yu516avjljpEITwzCw/6CYAXFiiAJ7yfUJwW
 lSCPZkGgvBCnjfE8o73urqZDoSZpKCwDh83o4kAh5RT9QkIq3+Uc/FjpvGAYYMNud3fRQASrcSt
 rgfNkxnKEg==
X-Received: by 2002:a05:600c:1e27:b0:43c:f16a:641e with SMTP id
 5b1f17b1804b1-43eb5bfc519mr33089955e9.6.1743611779650; 
 Wed, 02 Apr 2025 09:36:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE95c/rDwuZYvpUdFnJ0Gkp8WI2TR0quKd9H+hqT+c3eQQaFWPN6D/GK4WhvxmtUQgSGSsPCw==
X-Received: by 2002:a05:600c:1e27:b0:43c:f16a:641e with SMTP id
 5b1f17b1804b1-43eb5bfc519mr33089725e9.6.1743611779187; 
 Wed, 02 Apr 2025 09:36:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb5fcfc35sm26340395e9.16.2025.04.02.09.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 09:36:18 -0700 (PDT)
Date: Wed, 2 Apr 2025 12:36:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 4/4] virtio_net: Add third acceptable configuration
 for MAC setup.
Message-ID: <20250402123554-mutt-send-email-mst@kernel.org>
References: <20250326132021.1215568-1-lulu@redhat.com>
 <20250326132021.1215568-5-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326132021.1215568-5-lulu@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Wed, Mar 26, 2025 at 09:19:33PM +0800, Cindy Lu wrote:
> For VDPA devices, Allow configurations where both the hardware MAC address
> and QEMU command line MAC address are zero.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/net/virtio-net.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 1fd0403d5d..d1f44850d5 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3782,6 +3782,19 @@ static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n,
>              return true;
>          }
>      }
> +    /*
> +     * 3.The hardware MAC address is 0,
> +     *  and the MAC address in the QEMU command line is also 0.
> +     *  In this situation, qemu will generate a random mac address
> +     *  QEMU will try to use CVQ/set_config to set this address to
> +     *  device

same comments. end sentences with a period.

> +     */
> +    if ((memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) == 0) &&
> +        (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) == 0)) {
> +        memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
> +
> +        return true;
> +    }
>  
>      error_setg(errp,
>                 "vDPA device's mac %02x:%02x:%02x:%02x:%02x:%02x"
> -- 
> 2.45.0


