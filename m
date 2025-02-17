Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D2EC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 17:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk5Oh-00005C-7n; Mon, 17 Feb 2025 12:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tk5Oe-0008WQ-1X
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 12:59:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tk5Ob-0004MK-R6
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 12:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739815143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=P4O62DVI796aVTfKybb/eJv2Wf6zshVokxup36foZWw=;
 b=O7oWP0L4HiI4bwlkLQYBvBsiYdVkkseAtTPQoQchG4A0xPbyJO524hEhXe/mGZvh0ofuXW
 8wuHfA3nk/QnXiDKNk2JTsfOXEa85hbHIhlbRJrKR+6CFWzLtWN16Exd6A+i9wgn7pEW46
 /VC3H/G8JYtKMXlUCcsslb13fA9eTso=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-sLdgAd0XMLeN42hSLl1YvA-1; Mon, 17 Feb 2025 12:59:02 -0500
X-MC-Unique: sLdgAd0XMLeN42hSLl1YvA-1
X-Mimecast-MFC-AGG-ID: sLdgAd0XMLeN42hSLl1YvA_1739815141
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43947979ce8so24980435e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 09:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739815141; x=1740419941;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P4O62DVI796aVTfKybb/eJv2Wf6zshVokxup36foZWw=;
 b=gD5vIM7c2vy+znN/LfPcfLY/hI17PsI/ewQ/HHhDZ4GB+anx8L/1tiec7CwSzHZlOb
 HBv94GyBM9Wb/2msriHK7xAeIxYptXNxSHScm0JqnyxXzHe1tGIVLKUK9WHalT0hjrNY
 wjWCmWdTJ6fYvz7jsLs6w+xHwgKmfdNW1KdrrtJyMQxMfSLY5rSCf44FqWQj06NrwUT/
 RchGxcJgYN8t0ISXo5954YBBFt2PzcCouHmNVk5V2k80xnah/0adF0d4m2FGqsbOS62i
 ju7u/nHO2mE09wXDG/kBxl9FlJnngmLjm+McKNp1ZPlXEpzw1IvXqOxAqxaeCbWC59Td
 j3IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP2+3T7ZxLXdY3gfpEhN0NQ/zWdhoedA/Yyo4n6A0AsuuKDTxbjKCk5JLK6JxhXMHPtd+S3NsJAWN5@nongnu.org
X-Gm-Message-State: AOJu0Yzk2Au4rsQenWVeDGn0ive/J+MWCpFvyOtdz6vM6znKK+jRUeX7
 gzTZ2Rx29jwRg2jkFg2ENTPiK4xRX8mIVUnkc6vMlDzIa6oY0MW2nwVm7rXxOcyFWax5WDk1U8e
 YF2rm3LWyIEB1wTSmdauiUuYTKLRKhaEVNfsAGTZ6MHuVsQfexiy0
X-Gm-Gg: ASbGncuL9G/5et6VlpUGMssDwUkeivildhX9PgyeBizLc8gKjeG8I/WjfV/ClZ/y5O5
 X24k/UNheQls8rmaAdeKyyGixYRg0a8mLIoI0ZUT170FMU7udEuLCBP+gYM+WUuJqs5UxJcv+0T
 sswvcnd3j31NFTJcTIwsR9kTaocjtGqup9Lg0zdFlpjbJs44fNiafpV7apwENP2tXukVTAgnJ5F
 A0RXyfXFtgHI1KrffsxN4siyTapdUolxzZgyR39l3CtYtmdVJmlpdo5fWc2y9dbWN/Zfh4j8rIA
 /145jKaetdtiETzLDCmT5Pv/Ebc/2PDcaQE72WgP
X-Received: by 2002:a05:600c:3110:b0:439:4b9a:a9fb with SMTP id
 5b1f17b1804b1-4396e77948bmr108500645e9.30.1739815140857; 
 Mon, 17 Feb 2025 09:59:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzwJH+L1q2xRFmzow8bd6DL0Sd9E/u9jQYBjAJtNSMBO6EWCa8UED8pKWuleJDaOfCx1lFUg==
X-Received: by 2002:a05:600c:3110:b0:439:4b9a:a9fb with SMTP id
 5b1f17b1804b1-4396e77948bmr108500475e9.30.1739815140492; 
 Mon, 17 Feb 2025 09:59:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398a8007easm21000805e9.21.2025.02.17.09.58.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 09:58:59 -0800 (PST)
Message-ID: <25b0c264-ddef-4507-9cd0-8246ab4fa5bd@redhat.com>
Date: Mon, 17 Feb 2025 18:58:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 05/45] vfio/container: ram discard disable helper
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-6-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1739542467-226739-6-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/14/25 15:13, Steve Sistare wrote:
> Define a helper to set ram discard disable, generate error messages,
> and cleanup on failure.  The second vfio_ram_block_discard_disable
> call site now performs VFIO_GROUP_UNSET_CONTAINER immediately on failure,
> instead of relying on the close of the container fd to do so in the kernel,
> but this is equivalent.

should be ok.



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/container.c | 48 +++++++++++++++++++++++++++---------------------
>   1 file changed, 27 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 7c57bdd2..0f17d53 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -535,16 +535,10 @@ static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
>       return true;
>   }
>   
> -static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
> -                                   Error **errp)
> +static bool vfio_attach_discard_disable(VFIOContainer *container,
> +                                        VFIOGroup *group, Error **errp)
>   {
> -    VFIOContainer *container;
> -    VFIOContainerBase *bcontainer;
> -    int ret, fd;
> -    VFIOAddressSpace *space;
> -    VFIOIOMMUClass *vioc;
> -
> -    space = vfio_get_address_space(as);
> +    int ret;
>   
>       /*
>        * VFIO is currently incompatible with discarding of RAM insofar as the
> @@ -577,18 +571,32 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>        * details once we know which type of IOMMU we are using.
>        */
>   
> +    ret = vfio_ram_block_discard_disable(container, true);
> +    if (ret) {
> +        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
> +        if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER, &container->fd)) {
> +            error_report("vfio: error disconnecting group %d from"
> +                         " container", group->groupid);
> +        }
> +    }
> +    return !ret;
> +}
> +
> +static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
> +                                   Error **errp)
> +{
> +    VFIOContainer *container;
> +    VFIOContainerBase *bcontainer;
> +    int ret, fd;
> +    VFIOAddressSpace *space;
> +    VFIOIOMMUClass *vioc;
> +
> +    space = vfio_get_address_space(as);
> +
>       QLIST_FOREACH(bcontainer, &space->containers, next) {
>           container = container_of(bcontainer, VFIOContainer, bcontainer);
>           if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
> -            ret = vfio_ram_block_discard_disable(container, true);
> -            if (ret) {
> -                error_setg_errno(errp, -ret,
> -                                 "Cannot set discarding of RAM broken");
> -                if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER,
> -                          &container->fd)) {
> -                    error_report("vfio: error disconnecting group %d from"
> -                                 " container", group->groupid);
> -                }
> +            if (!vfio_attach_discard_disable(container, group, errp)) {
>                   return false;
>               }
>               group->container = container;
> @@ -620,9 +628,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>           goto free_container_exit;
>       }
>   
> -    ret = vfio_ram_block_discard_disable(container, true);
> -    if (ret) {
> -        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
> +    if (!vfio_attach_discard_disable(container, group, errp)) {
>           goto unregister_container_exit;
>       }
>   


