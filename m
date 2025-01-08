Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40429E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 14:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVWpr-0005uW-EM; Wed, 08 Jan 2025 09:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tVWpa-0005tc-BL
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:14:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tVWpW-0004jl-9L
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736345680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yNcVBbhGtCzb9GuZyfZlONnG3UaP4zdH2tNBP9ClSbY=;
 b=FTy+L3+bvkocVhSP7hiGO7ekP4BW225bL5XfHJqZpFa8EaRfm0oIRmWQjlVFbdRAjiY5Ek
 xFoy5TVkyBHnUS6faSmHxKuUIpI8+I0ZxUJZC3L0S1jfZOXsclqMkPYsmndbtAoVZwq74z
 YfqYI1EGLtMsd4xspvQQsTqSL0pTMAM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-pNX84ABPO0W2uvJOYleRnw-1; Wed, 08 Jan 2025 09:14:38 -0500
X-MC-Unique: pNX84ABPO0W2uvJOYleRnw-1
X-Mimecast-MFC-AGG-ID: pNX84ABPO0W2uvJOYleRnw
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d821f9730aso896960a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 06:14:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736345677; x=1736950477;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yNcVBbhGtCzb9GuZyfZlONnG3UaP4zdH2tNBP9ClSbY=;
 b=Ow7yWuu3xZwJYeQTe5Ls5VZjhlOEIUyIl7rVQeKwjo4WG83mVJf5Jdt0hv9+9hK0le
 38AbSEOudqKofL77sSq/nCFvZSWCf2A2oRbiFF10qM1DAzIGHpjhjMEV5/EOGRUczRmP
 UaqUrx27DUo+Hjnp4n9QDTPCJS9OzBNcU1ZjNbsvncrOI8kszDcS6A3/jxf0lJJvgn3p
 hZzkeGiDOD0cxzVuCd4R2dKXrXkwk2moHns4POOokMzrduRiIcsrnm2Iy4Kgt2n4ycAZ
 2dQ+OtqJC6Mrtsr58zGBWb5YIJvlfv30A1UifrSIPNinbaEgQKDR4LSXkc84HaZOfrji
 w+fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe0PSO1L3Y5za1Dum2sYxt1kodJianPU/1MpXcsQu14Bx4MzQhtVGBoEMRhHLHHJZR7NtwPu3tjzIE@nongnu.org
X-Gm-Message-State: AOJu0YwgHxLre5So696XBY5JJOvdJ4O/3wEUUPNJ0N5reacw5lVKeWNs
 fXEOJKL0C/KCI2GC+jYQB3M5RdYKFOqomxCYhNTxKqDkmsDoplMXRVL5XcrhScLNLaGHAuI9RQK
 xCMtvydhA61b9IHjzJAqJsBZK24mNTIac8xoZckZeK39NlJFNaDXu
X-Gm-Gg: ASbGnculvq9TJjrytEsS2kMrcLoifEuAIK2Dv5VoN0T0SJbAjwAV3FS+XK0dfFQDX34
 TZ938yErduSQg7gFUf6dAkZRhJDPpfRTWQUmFRzfx2zQ1s0sQl5QTsD7y+awjRcUv9WeCVElxiJ
 7lqWZQzU0+TqvkrLiioiRsEP/pdyVBVqcy9kt9WXS9ZaKLWY4/weHyxdfc8r/RhN4r2A9ylDU7y
 d4Bds/nGWJ4ObEfQIJJ2yNmqnyztHsFVIyYzkVSyCK3gju8QD0=
X-Received: by 2002:a05:6402:26cd:b0:5d0:d845:2882 with SMTP id
 4fb4d7f45d1cf-5d971ba439cmr2707860a12.13.1736345677197; 
 Wed, 08 Jan 2025 06:14:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKtk9x9QKCmWxztdABmLZGo0gNmHg9Dd/RFbOSpC8jj0cQZPb5Vvzgn8YqKiPuocWpS+tLNQ==
X-Received: by 2002:a05:6402:26cd:b0:5d0:d845:2882 with SMTP id
 4fb4d7f45d1cf-5d971ba439cmr2707819a12.13.1736345676708; 
 Wed, 08 Jan 2025 06:14:36 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80701ca31sm25153860a12.88.2025.01.08.06.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 06:14:35 -0800 (PST)
Date: Wed, 8 Jan 2025 09:14:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Julia Zhang <julia.zhang@amd.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 xen-devel@lists.xenproject.org, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <burzalodowa@gmail.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>,
 Penny Zheng <penny.zheng@amd.com>, Zhu Lingshan <Lingshan.Zhu@amd.com>,
 Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
 Jan Beulich <jbeulich@suse.com>, Juergen Gross <jgross@suse.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] virtio-gpu: add a new command to get p2pdma_distance
Message-ID: <20250108091357-mutt-send-email-mst@kernel.org>
References: <20241207105537.542441-1-julia.zhang@amd.com>
 <20241207105537.542441-4-julia.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207105537.542441-4-julia.zhang@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Dec 07, 2024 at 06:55:40PM +0800, Julia Zhang wrote:
> diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
> index 6459fdb9fb..2e55dcc2fe 100644
> --- a/include/standard-headers/linux/virtio_gpu.h
> +++ b/include/standard-headers/linux/virtio_gpu.h
> @@ -95,6 +95,7 @@ enum virtio_gpu_ctrl_type {
>  	VIRTIO_GPU_CMD_SUBMIT_3D,
>  	VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB,
>  	VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB,
> +	VIRTIO_GPU_CMD_P2PDMA_DISTANCE,
>  
>  	/* cursor commands */
>  	VIRTIO_GPU_CMD_UPDATE_CURSOR = 0x0300,
> @@ -108,6 +109,7 @@ enum virtio_gpu_ctrl_type {
>  	VIRTIO_GPU_RESP_OK_EDID,
>  	VIRTIO_GPU_RESP_OK_RESOURCE_UUID,
>  	VIRTIO_GPU_RESP_OK_MAP_INFO,
> +	VIRTIO_GPU_RESP_OK_P2PDMA_DISTANCE,
>  
>  	/* error responses */
>  	VIRTIO_GPU_RESP_ERR_UNSPEC = 0x1200,
> @@ -429,6 +431,23 @@ struct virtio_gpu_set_scanout_blob {
>  	uint32_t offsets[4];
>  };
>  
> +/* VIRTIO_GPU_CMD_P2PDMA_DISTANCE */
> +struct virtio_gpu_device_p2pdma_distance {
> +	struct virtio_gpu_ctrl_hdr hdr;
> +	__le32 provider_bus;
> +	__le32 provider_slot;
> +	__le32 provider_func;
> +	__le32 client_bus;
> +	__le32 client_slot;
> +	__le32 client_func;
> +};
> +
> +/* VIRTIO_GPU_RESP_DISTANCE */
> +struct virtio_gpu_resp_distance {
> +	struct virtio_gpu_ctrl_hdr hdr;
> +	__le32 distance;
> +};
> +
>  /* VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB */
>  struct virtio_gpu_resource_map_blob {
>  	struct virtio_gpu_ctrl_hdr hdr;
> -- 
> 2.34.1

This is not how we change this header.
you need a spec patch, an UAPI change to be accepted into linux.

-- 
MST


