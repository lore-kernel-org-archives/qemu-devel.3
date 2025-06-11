Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4CDC61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 11:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPJpO-0005d0-0U; Wed, 11 Jun 2025 07:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPJpL-0005bw-1T
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 07:41:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPJor-0001Qf-GS
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 07:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749641992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2ly9SJCSUsPlEcV+E9/xtPYZm0eFix7wKkZKxAzYj0c=;
 b=PxrYJCbf7YrJEZLR00oQov4ELNMVmMuzZw/l6cGK1OUJS+Xksr9UzmZxsKSNXz/iXVbDtg
 TxGgplZEiClXb0qqB3nzOSWPoG077msqnqaUxYANh/0opU1QRQmhBL2RhrLznh5g3ibVGr
 qSYTBgJYCzD1sFy8fanOghivu/L/aFc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-1lO0bmUpPWCrx7JXiVxPHw-1; Wed, 11 Jun 2025 07:39:48 -0400
X-MC-Unique: 1lO0bmUpPWCrx7JXiVxPHw-1
X-Mimecast-MFC-AGG-ID: 1lO0bmUpPWCrx7JXiVxPHw_1749641987
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450cb8ff0c6so35908215e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 04:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749641987; x=1750246787;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ly9SJCSUsPlEcV+E9/xtPYZm0eFix7wKkZKxAzYj0c=;
 b=gHLV7pMe58GcrmjxVFzRSIBjuWbU6IP4nstDKKazkdJvjAN6TVS1/aYKNEi9Kj366i
 rtIMNhGsXwn/UDga1ou47AA0xn2Mh+hZVTnFtqicE3cpmFC2ce4GdizEbz6BnV/ZmbPy
 r/SvawVdnsNVmXhLxPTu8VuqkGFFOKBm1v4rJESY5PhNp6EsrnvVaAQBGrllJ7kDAmpA
 YCoMKByBPDeHqjw3bq5SWZuEqLsbhUKB4i/0FMRtyZ2ncUmuXvgPrZz+YVCnapsrTIyU
 6EDz91NIUR0I7q309BpbOd4wj9msksicfUZjpZe5UqQfHdpjAp+yfEgJQHK41vS3jDXY
 lHXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzMAs05n7Zx9jMardVl4PnRRRmXtvMHfhMXq6ii27/FdhnaHM2b78LytR6Mo83FS8dCOxooi/GEkHS@nongnu.org
X-Gm-Message-State: AOJu0YyQFP5VLJ+lJFShehEo3q67Qg2yyNJIKgTE+/iz2hcffBr/6Zl8
 tLXlaa3vh8Q3Eo8zyhHdD65QyWyAmwu8/9JWnfFGBW7GO7VxvE/Dp76SlNXLgHHQi9jdspTNHLl
 y1DwXE0ajMEBzwIC1bzRXVIs9Ep9WhYaB9wjMnOCA8onaDPJkBqbO1+6h
X-Gm-Gg: ASbGncsvUrjVaP/lOLNdBDm8gMNuJLduNvRF7PHyN/sUsaoDkEUVhe1kn00d8G6E7hr
 93mKMwmLYSYTmKu73DWACye8jAUBxJ/pMF9Mtz/MK3vRyZ0dG+cN4tuwWOFyojsbaLvyV/zo9h9
 GBSQT84Gob5VCSTsiZSDb/zgDrZTfbZdIBThpJ99lryuBsXFAkTLQ+EjUR4WQt87kS4QLVV8Ere
 6QO+Qpyo609PuFJTGNavC5gZV2iYvKW2cjKE7TR1UnRzKjAM0S7MTHXUqu8pKI3fz96tYOVM3MQ
 gA79NheWU5rw4v8b6EPgE/8M/pd9VEa3/OOE+H3XNEaR1NmxRIG7gck2JIXB
X-Received: by 2002:a05:600c:6209:b0:450:d3c6:84d8 with SMTP id
 5b1f17b1804b1-45324ee6cb0mr25046775e9.14.1749641987275; 
 Wed, 11 Jun 2025 04:39:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi06Qu/t50kx5vtdWKzC6lo7AxhJN+HZN2yyTHH8Jf7gedjUxfRma57K4Uroc4k5IUCe3vxA==
X-Received: by 2002:a05:600c:6209:b0:450:d3c6:84d8 with SMTP id
 5b1f17b1804b1-45324ee6cb0mr25046495e9.14.1749641986865; 
 Wed, 11 Jun 2025 04:39:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532515d084sm18543135e9.12.2025.06.11.04.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 04:39:46 -0700 (PDT)
Message-ID: <8f1fb98d-bf7c-47df-bca1-73e703eb7f18@redhat.com>
Date: Wed, 11 Jun 2025 13:39:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: improve VFIODeviceIOOps docs
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20250611104753.1199796-1-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250611104753.1199796-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/11/25 12:47, John Levon wrote:
> Explicitly describe every parameter rather than summarizing.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Applied to vfio-next.

Thanks,

C.


> ---
>   include/hw/vfio/vfio-device.h | 52 +++++++++++++++++++++++++++++------
>   1 file changed, 43 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index f39259406b..d45e5a68a2 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -168,14 +168,25 @@ struct VFIODeviceIOOps {
>        * @device_feature
>        *
>        * Fill in feature info for the given device.
> +     *
> +     * @vdev: #VFIODevice to use
> +     * @feat: feature information to fill in
> +     *
> +     * Returns 0 on success or -errno.
>        */
> -    int (*device_feature)(VFIODevice *vdev, struct vfio_device_feature *);
> +    int (*device_feature)(VFIODevice *vdev, struct vfio_device_feature *feat);
>   
>       /**
>        * @get_region_info
>        *
> -     * Fill in @info (and optionally @fd) with information on the region given
> -     * by @info->index.
> +     * Get the information for a given region on the device.
> +     *
> +     * @vdev: #VFIODevice to use
> +     * @info: set @info->index to the region index to look up; the rest of the
> +     *        struct will be filled in on success
> +     * @fd: pointer to the fd for the region; will be -1 if not found
> +     *
> +     * Returns 0 on success or -errno.
>        */
>       int (*get_region_info)(VFIODevice *vdev,
>                              struct vfio_region_info *info, int *fd);
> @@ -183,22 +194,38 @@ struct VFIODeviceIOOps {
>       /**
>        * @get_irq_info
>        *
> -     * Fill in @irq with information on the IRQ given by @info->index.
> +     * @vdev: #VFIODevice to use
> +     * @irq: set @irq->index to the IRQ index to look up; the rest of the struct
> +     *       will be filled in on success
> +     *
> +     * Returns 0 on success or -errno.
>        */
>       int (*get_irq_info)(VFIODevice *vdev, struct vfio_irq_info *irq);
>   
>       /**
>        * @set_irqs
>        *
> -     * Configure IRQs as defined by @irqs.
> +     * Configure IRQs.
> +     *
> +     * @vdev: #VFIODevice to use
> +     * @irqs: IRQ configuration as defined by VFIO docs.
> +     *
> +     * Returns 0 on success or -errno.
>        */
>       int (*set_irqs)(VFIODevice *vdev, struct vfio_irq_set *irqs);
>   
>       /**
>        * @region_read
>        *
> -     * Read @size bytes from the region @nr at offset @off into the buffer
> -     * @data.
> +     * Read part of a region.
> +     *
> +     * @vdev: #VFIODevice to use
> +     * @nr: region index
> +     * @off: offset within the region
> +     * @size: size in bytes to read
> +     * @data: buffer to read into
> +     *
> +     * Returns number of bytes read on success or -errno.
>        */
>       int (*region_read)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
>                          void *data);
> @@ -206,8 +233,15 @@ struct VFIODeviceIOOps {
>       /**
>        * @region_write
>        *
> -     * Write @size bytes to the region @nr at offset @off from the buffer
> -     * @data; if @post, the write is posted.
> +     * Write part of a region.
> +     *
> +     * @vdev: #VFIODevice to use
> +     * @nr: region index
> +     * @off: offset within the region
> +     * @size: size in bytes to write
> +     * @data: buffer to write from
> +     *
> +     * Returns number of bytes write on success or -errno.
>        */
>       int (*region_write)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
>                           void *data, bool post);


