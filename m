Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5828BC3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 15:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFwxK-0001d2-C5; Fri, 16 May 2025 11:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFwxF-0001Wo-Fp
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:26:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFwxC-00072T-Gn
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747409189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kW3dM5gJwsQlhYtS1huj3HNc1vWq0s4r62/aB5W/PCo=;
 b=OQOkzXh/asPG0WVaFZ5TnZ/iApaWytsjUCkIwlJy0Z8T5A4dVD6hbwD+EiyHKUgEuz85fw
 msK3IwleFa+mTFoToKXZB/Xo54xxusgX44xExbphmzfHANlhUu7VzmLmCd9xlwEXQ0/5nd
 DLExU8+FLkAJDR5QjuT1Rf3XiwClp9A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-RaS9M-kfNzufC79zbyuk7g-1; Fri, 16 May 2025 11:26:25 -0400
X-MC-Unique: RaS9M-kfNzufC79zbyuk7g-1
X-Mimecast-MFC-AGG-ID: RaS9M-kfNzufC79zbyuk7g_1747409185
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-44059976a1fso10080865e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 08:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747409184; x=1748013984;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kW3dM5gJwsQlhYtS1huj3HNc1vWq0s4r62/aB5W/PCo=;
 b=M+6tmwuR40bQfxkr6qOvDyVyeK+m4iX3yZbYPQwHnSUKYL20XLbSyJGVUvMayNKh0P
 7x2m/WXORG2vcpohAHawffzIylCtC1Eq0seyvCwEENGyUBh4nzze5vlkipS5Q9ppgzrg
 dpw+YYV2id+VMlIZWjk2pEdIRtV2DEV1ZbrKf5hYRbU0en3ccM5DFmWr6CnmW5oq1YNp
 DR+lcu3As9xg1rBkFQbnCrrPAmXHBEkN2D5gxcwqAea/UHqEnm9/1Fldpr6OHZFEYZv8
 Db2yhSkQXmZZoYO5ZgPZ8o/oj+6D+9jONNjAOy/PY5OhO4Kes2n6M40G+xaVVa54ZzfZ
 4X5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWBKM50cquMg5257D8zyLAchn0dDUTZTEYz1I4rsSCXDzsI3F0jK5giQk2holTsauEOstQPvdPckgg@nongnu.org
X-Gm-Message-State: AOJu0YwbM1IHgzrwEBvgQ/4qu4eRgiuBLaop65jftvP0peglbUIogLmc
 +IzBajs2DgTAx/TFfouKDcEj2Mr5W2aoWsbESgIt3tng/QxLSADZLmFVqvR4kBoYxY3XBgvBGqw
 awev486z7AMLRjxYk0lhyqHD3CC2fBWAC+p4C5wDl/O4dl8eRQzlQDtRe
X-Gm-Gg: ASbGncut2lUP6Wb1WvqvP8fz1A7aw2mUGg+gzYczTfy2XGlUIOv6WGUnI7asqPbPnps
 9goKMA462WhH/Amax8dXtmrzbaMyaHz9o2soJje7FOXy++lI3mEOJCn1Zfrxq/jwVbtv0YsWNdL
 ONCluOoqKXtoWyvn574+5olQglZjrIdC86dlzSsh3wk7S2hqnMAloVoKuAadhfrf1/hv7Q82QCa
 sMUvZ2Dd5PitQakyXHP9kcA9O3SP2fwRKKUVIb4WHRp8gzSKYFEMGS8jn9UCyZSvVmtjM4jqMKS
 /yc93C4y5/xytrUc0byYvf/hYybKLREiWNor6Sw3wS0gYRM=
X-Received: by 2002:a05:6000:2586:b0:3a1:f6a3:4d01 with SMTP id
 ffacd0b85a97d-3a35c845500mr3562188f8f.47.1747409184643; 
 Fri, 16 May 2025 08:26:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMfscJ8G+bWn6x+VDIK7c84WDDbgj3K9IJaXRq6rs765NQ1X0tuabf1KGNfSdGELFIJHFaew==
X-Received: by 2002:a05:6000:2586:b0:3a1:f6a3:4d01 with SMTP id
 ffacd0b85a97d-3a35c845500mr3562156f8f.47.1747409184186; 
 Fri, 16 May 2025 08:26:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca8cf66sm3095500f8f.87.2025.05.16.08.26.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 08:26:23 -0700 (PDT)
Message-ID: <18c45ce4-fbfc-4383-a4f6-22c82ef7cb0e@redhat.com>
Date: Fri, 16 May 2025 17:26:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/27] vfio: move config space read into
 vfio_pci_config_setup()
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250515154413.210315-1-john.levon@nutanix.com>
 <20250515154413.210315-5-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250515154413.210315-5-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On 5/15/25 17:43, John Levon wrote:
> Small cleanup that reduces duplicate code for vfio-user.

It also reduces vfio_realize(). It's time to rename it to
vfio_pci_realize() too.

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/pci.c | 27 ++++++++++++++-------------
>   1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index d96b55f80c..7912c17dd2 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3017,6 +3017,19 @@ static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
>   {
>       PCIDevice *pdev = &vdev->pdev;
>       VFIODevice *vbasedev = &vdev->vbasedev;
> +    uint32_t config_space_size;
> +    int ret;
> +
> +    config_space_size = MIN(pci_config_size(&vdev->pdev), vdev->config_size);
> +
> +    /* Get a copy of config space */
> +    ret = vfio_pci_config_space_read(vdev, 0, config_space_size,
> +                                     vdev->pdev.config);
> +    if (ret < (int)config_space_size) {
> +        ret = ret < 0 ? -ret : EFAULT;
> +        error_setg_errno(errp, ret, "failed to read device config space");
> +        return false;
> +    }
>   
>       /* vfio emulates a lot for us, but some bits need extra love */
>       vdev->emulated_config_bits = g_malloc0(vdev->config_size);
> @@ -3143,10 +3156,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       ERRP_GUARD();
>       VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
> -    int i, ret;
> +    int i;
>       char uuid[UUID_STR_LEN];
>       g_autofree char *name = NULL;
> -    uint32_t config_space_size;
>   
>       if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
>           if (!(~vdev->host.domain || ~vdev->host.bus ||
> @@ -3201,17 +3213,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>           goto error;
>       }
>   
> -    config_space_size = MIN(pci_config_size(&vdev->pdev), vdev->config_size);
> -
> -    /* Get a copy of config space */
> -    ret = vfio_pci_config_space_read(vdev, 0, config_space_size,
> -                                     vdev->pdev.config);
> -    if (ret < (int)config_space_size) {
> -        ret = ret < 0 ? -ret : EFAULT;
> -        error_setg_errno(errp, ret, "failed to read device config space");
> -        goto error;
> -    }
> -
>       if (!vfio_pci_config_setup(vdev, errp)) {
>           goto error;
>       }


