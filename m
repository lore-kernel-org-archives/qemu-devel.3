Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9D6CA5FED
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 08:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF5jw-0007gi-JV; Fri, 09 Oct 2026 04:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xF5jf-0007gL-Eg
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 04:13:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xF5jc-00047U-EC
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 04:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791533623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=F3Rhgeu2wi/Sslnk/cTpGvj3Bn3XfxtnW8klcJsn7DA=;
 b=YwHTuiQS/domiUex4AHjWBI1O9MDXEwm1Sh3miS/HkfrgCzcUGiywxNpY+qheJAimNXMoH
 lyEWK/nHyCy3Ko7cOzhfwgW2P9mMa8pCk1DxDaXNjPZC93pI6JeIKrfd9LIv0r21rvmC69
 qsUtsG8NJM6IdGJuLn7zcHfpBLARqtU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-4a9b-R-vMNeL37xMZEkJOg-1; Fri, 9 Oct 2026 08:13:41 +0000
X-MC-Unique: 4a9b-R-vMNeL37xMZEkJOg-1
X-Mimecast-MFC-AGG-ID: 4a9b-R-vMNeL37xMZEkJOg_1791533620
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a17741243eso26737115e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 01:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791533620; x=1792138420; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=F3Rhgeu2wi/Sslnk/cTpGvj3Bn3XfxtnW8klcJsn7DA=;
 b=saWdndqEDffpPIhYP9kxJOyEYJ5VqcNsiHOidYKBvCAqAmZFAeQUErUC6uBdW+yZuz
 QMD7n/9T54c0JOCzB5tB3nGMSBKn5BbCh+5/CKsKPrpQ6nHs6cYJ7SwGaGocNrkL5gia
 tINUfs6T63SvVfURqBPdgjRcTQkFwl8n2batB6/v0xw68I1La1f+ym4J5zQE+eR8Z7La
 lRVA07G9hslBe6gUJ9OCoEZwxSLnJOwBhvDu93hQY0F+2BqjS39EwNDdPqf79pu6JLOw
 k95FdJsITb00xM7E51HAQTE6Y99WcZ2P8mRFIJqm5nKQtIulS6JKucRK2j1RxGnIvHNY
 mEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791533620; x=1792138420;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=F3Rhgeu2wi/Sslnk/cTpGvj3Bn3XfxtnW8klcJsn7DA=;
 b=oG54ycR9dn4QK8hQR47byja6BS+1q2TIzUmzxHjw64ErmBk2v3MpS6se8qEkyo5+Km
 68SJP9bJGcW7FIio7JE7VPNCm4M5NjMwpYBIS1njB4Yr2Ticj94utmn+/40lxObAjGpX
 qbshE1f7KyH5gM2PxOwNqH+6GcEPZYoRgDK5tlJZ42cFrcor7EMRvv40YIXv/cCTeYYc
 mFMdE1lEEgLWTSUB6UV8tx4DnHsp2adSaSOR7+xfTjdo5McqEWUGYwlj6jQNIolSqnZ0
 DpW15GG92nMs9Sje9nKI34XLMAlZkQz6ApgXSA0hwejmzLvszj0vzFjAmbkfizwKpBSe
 buSA==
X-Forwarded-Encrypted: i=1;
 AKwUvByQ8tZ+LLNCVBqiaOkdCPoLNB2Uqi/qT5+sMv4Flzffk4qDWVilR/j4eDrXs3vH3Yukens7q2dpwIvX@nongnu.org
X-Gm-Message-State: AFuF++noPV3hwMTQn83Zy1rQhunxmUeQJKly4H6DU2SHf5MSqMh57ZxO
 A5BlVMoscXz8JNEQHlu2EjJJ5rcbzMotLJNuE6ZhusOEVpgljNK1iZXmSARlmXVeA1NV8e+Mw55
 /AvBG7/N606T04VY5KZpyPmd0uH3l9/9r+hV9BzTbJhJIiZfzppJ4JARJ
X-Gm-Gg: AYBFou1tSqjS9WUd9yhnLorfZ4/4aeBURbp68ohUU35k2RthvMyD6UufwaJvDS/TYhj
 x9m9Wtq/3IXi1OM7vRkP/thA/Gex++A2OdhyZrb73ujU7lsqFmoI7NSUPEdfXmXntWF4wR1fsKF
 fBIkJR6To8lgAChciIfRLMdrxyWcybxkxXhVEkPQjk0Yzy469Hy1k/WgNDrB2FBwzHUPncP81ys
 Qyf1UUTm+o76oZ+DTNmF7DV/wpCHfAmFhWDsk2WHhHB2cC6bndxeN/m5ag7nyjkg1ZaJuJjPIRI
 UXkdXANT1REtCRzUAtYZeZ4bqeN0sp/gjWdhHgval3wqApFgIekNNFZEnQaaUkSyMR4AyHMWwzL
 eU39svDlMMCmaxxX/w0E4EWhkdrOpHqRK43l8wx6J
X-Received: by 2002:a05:600c:4e89:b0:4a0:12d7:4c88 with SMTP id
 5b1f17b1804b1-4a18e4ac77amr20780215e9.30.1791533620297; 
 Fri, 09 Oct 2026 01:13:40 -0700 (PDT)
X-Received: by 2002:a05:600c:4e89:b0:4a0:12d7:4c88 with SMTP id
 5b1f17b1804b1-4a18e4ac77amr20779785e9.30.1791533619885; 
 Fri, 09 Oct 2026 01:13:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18c85009csm29991865e9.2.2026.10.09.01.13.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 01:13:39 -0700 (PDT)
Message-ID: <ba708fcf-7d14-4735-8f09-a013bf0f5dcb@redhat.com>
Date: Fri, 9 Oct 2026 10:13:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 7/9] vfio/device: Add a helper to mmap a dmabuf
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-8-vivek.kasireddy@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20261007201222.648687-8-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/7/26 22:09, Vivek Kasireddy wrote:
> In order to mmap a dmabuf, we first need to create a placeholder
> mapping that would fit the entire size of the dmabuf. This mapping
> would then be replaced with smaller mappings of individual dmabuf
> segments.
> 
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   include/hw/vfio/vfio-device.h | 15 ++++++++++
>   hw/vfio/device.c              | 55 +++++++++++++++++++++++++++++++++++
>   hw/vfio/dmabuf-stubs.c        |  7 +++++
>   3 files changed, 77 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index c05430be8a..4b8fb62056 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -345,6 +345,21 @@ int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
>    */
>   int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
>                                    Error **errp);
> +
> +/**
> + * Mmap a dmabuf by first translating the addresses in the iovec
> + * array into VFIO region offsets and then creating a placeholder
> + * mapping that would be replaced later with mappings that
> + * correspond to the dmabuf segments.
> + *
> + * @iov: array of iovec entries associated with the dmabuf
> + * @iov_cnt: number of entries in the iovec array
> + * @errp: pointer to Error*, to store an error if it happens.
> + *
> + * Returns the mapped pointer on success and NULL on error.
> + */
> +void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
> +                              Error **errp);
>   #endif
>   
>   /* Returns 0 on success, or a negative errno. */
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index d95503a5f1..5bc0443764 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -776,3 +776,58 @@ int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
>       }
>       return ret;
>   }
> +
> +void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
> +                              Error **errp)
> +{
> +    size_t total_size = iov_size(iov, iov_cnt);
> +    struct vfio_region_info *info = NULL;
> +    ram_addr_t offset, len = 0;
> +    VFIODevice *vbasedev;
> +    VFIORegion *region;
> +    RAMBlock *first_rb;
> +    void *map, *submap;
> +    int i;
> +
> +    if (!vfio_device_lookup(iov, &vbasedev, &first_rb, errp)) {
> +        return NULL;
> +    }
> +
> +    /*
> +     * We first reserve a contiguous chunk of address space for the entire
> +     * dmabuf, then replace it with smaller mappings that correspond to the
> +     * individual segments of the dmabuf.
> +     */
> +    map = mmap(NULL, total_size, PROT_NONE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +    if (map == MAP_FAILED) {
> +        error_setg_errno(errp, errno, "Could not reserve placeholder mapping");
> +        return NULL;
> +    }
> +
> +    for (i = 0; i < iov_cnt; i++) {
> +        if (!vfio_region_lookup(iov[i].iov_base, &region,
> +                                first_rb, &offset, errp)) {
> +            goto err;
> +        }
> +
> +        if (vfio_device_get_region_info(vbasedev, region->nr, &info)) {
> +            error_setg(errp, "Cannot find region info for dmabuf segment\n");

no \n

> +            goto err;
> +        }
> +
> +        submap = mmap(map + len, iov[i].iov_len, PROT_READ,
> +                      MAP_SHARED | MAP_FIXED, vbasedev->fd,
> +                      info->offset + offset);
> +        if (submap == MAP_FAILED) {
> +            error_setg_errno(errp, errno, "Could not mmap dmabuf segment\n");

again.

> +            goto err;
> +        }
> +        len += iov[i].iov_len;
> +    }
> +    return map;
> +err:
> +    munmap(map, total_size);
> +    error_prepend(errp, "VFIO dmabuf mmap failed: ");
> +    return NULL;
> +}
> +
> diff --git a/hw/vfio/dmabuf-stubs.c b/hw/vfio/dmabuf-stubs.c
> index fb5318e929..b9e03a162a 100644
> --- a/hw/vfio/dmabuf-stubs.c
> +++ b/hw/vfio/dmabuf-stubs.c
> @@ -15,3 +15,10 @@ int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
>       error_setg(errp, "VFIO dmabuf support is not enabled");
>       return VFIO_DMABUF_CREATE_ERR_UNSPEC;
>   }
> +
> +void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
> +                              Error **errp)
> +{
> +    error_setg(errp, "VFIO mmap dmabuf support is not enabled");
> +    return NULL;
> +}


