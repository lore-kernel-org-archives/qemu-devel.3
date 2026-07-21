Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD6CC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm4cj-0002Z4-T2; Tue, 21 Jul 2026 03:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wm4ci-0002Xn-PG
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 03:10:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wm4ch-0000nc-5b
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 03:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784617838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8KSnnQHRu5sSmYvpJpfj88WTOM4p3yoxYz6Nv502/Wo=;
 b=FXjCcolRcGiY7xGs1gvX+EpvD0naOcQA3iQ5ZTE3h9ejWg7MlzfMmgPxPYt96urXntUWqY
 bnmuMipb5P7x+zpO59pl6hbtMhnwthWR7coUIxoG1l9NoNycX/Fnhn6Wn7wMMm7VoWx86e
 5mOA4c4G2h6lytp7rqQHRCAPDdC7F2w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-9Z1MHTo3PamRqRXKNFKYjg-1; Tue, 21 Jul 2026 03:10:36 -0400
X-MC-Unique: 9Z1MHTo3PamRqRXKNFKYjg-1
X-Mimecast-MFC-AGG-ID: 9Z1MHTo3PamRqRXKNFKYjg_1784617836
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-476608a9fefso4333005f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 00:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784617835; x=1785222635; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8KSnnQHRu5sSmYvpJpfj88WTOM4p3yoxYz6Nv502/Wo=;
 b=rmhTOr5OTERbyNrqt+pf4VjrOoGIIJM7sukk71iPyfj9POG9p37ZsIeRKtvu9GrBsA
 O74sSfUJB7qAUYzY46JPxS3g+Lm+xWspxoelk7rRFafdzU6VCLHDcK/LBAnumFPj+hI0
 jwED8hgUhEZMSx7Nl8hDp4Kd13QXbsbpHn8VUYOXM/pC5iUi04boEcNUdi1l3p7gQKsZ
 y4NVls7J6YtHrccVMbAaT5W+XdQbid4OTf+LNv3YoW3EVfVTR4GbvRJ3OYiMo0dySZZ/
 2gWGGmixDYsjPkLfdyLxLggnU3N6Ckw6Ga+9Aj9AES0uKo2+LrDRdvmVNFr0UQThssO/
 LKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784617835; x=1785222635;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8KSnnQHRu5sSmYvpJpfj88WTOM4p3yoxYz6Nv502/Wo=;
 b=h5HGlWFv2bh7goPP69eBTQ6V589J2XRkbQesU6abRWuMgeHFUs325duVGaiToP1NTh
 WVPbIX5UksuTqnZlwqyh5HtcIu+yTKrjlmE8ZnvI8FQ3lpYZGCUKjJsZsO51MkuQSgQv
 PLblcs3PenaHMfeQHZUCUTJMuVnhMHj9zEbVqzetuLOtWEKVmfgmSQHXcAD2G/wqCTVR
 cBzxIRyF0IvG/nNaPj2mapDstxQibmOiwIUv3U45gCyRvf+UkbSAiVljJwxCY570zj++
 EkwuhIZxSYmZQA7xsM9plxI8rLEa4MSi3xMUbZYutpQYm4mSCKJMPeGDkCpkZXMOkynL
 7SbA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKf5YkyEUkA/c/6FH2UsvwwUqK+7sGEUINfb/RzhssAQPAvXXgXjJd6AggVJFJ+v1fAgyMwIl6LYMI@nongnu.org
X-Gm-Message-State: AOJu0YyGr+2+FhnbaSGiQIE/JqoZoobH2okocMuwoFKLMQPMwgpdE1fH
 n0cxyZhIbX+G9HFxRF+kYuaMGigE+w6Mz87HjyLpIwCeL5CKV+gOr+FaOBXTVMSjw/hKqapEh+9
 BW4XH6sHFdTEGYcMeZDyuhjxb5piACJhlcOR7HejiM8lkuCulj2MTQHD4D+qi3U0n
X-Gm-Gg: AR+sD13t2WFEMAQOCepoTeS1xzttGizbxMxJSZ2+PLAmx8WjnSbWQn3nCZWTjLxrqqh
 jvyipAllaJQhFHaFldhtzHPwFnNODlQqof+GiqDHpXlD0fzVHlLcSaqZ+vmdUr6WYzUqDz3NJDV
 Zj5BgvhrB6Ho5RJuve/esZcLNAWlNvDA1dyyQRUj0etderEofFU7ToPmU7vCDlrYDoVMhDDhpV+
 e5NNDhJrtgyKS7nJ8XPrH4sBnRSTly1QAOThsK2bxbsKAj+ChU5u44YJBF5Wfw0exgNIX7RRrxe
 2YXMHd943TOegEaUTyzqCrHCkkg+JpYF8JhNgjfuA6dxawPVNjnbsiMkdTh9JFP6xC6Qsz8mXBc
 4wgwEYBJmjEHXGM+bIqya6prQ6yo6NbAlWroaF/Y=
X-Received: by 2002:a05:6000:3105:b0:47f:7d49:1745 with SMTP id
 ffacd0b85a97d-47f7d491837mr5094401f8f.23.1784617835556; 
 Tue, 21 Jul 2026 00:10:35 -0700 (PDT)
X-Received: by 2002:a05:6000:3105:b0:47f:7d49:1745 with SMTP id
 ffacd0b85a97d-47f7d491837mr5094378f8f.23.1784617835164; 
 Tue, 21 Jul 2026 00:10:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63edda9bsm36961437f8f.31.2026.07.21.00.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 00:10:34 -0700 (PDT)
Message-ID: <82496e8c-70a0-4476-a393-5cf11a34ab8c@redhat.com>
Date: Tue, 21 Jul 2026 09:10:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] vfio-user: vfio_user_device_io_get_region_info:
 fix capability check
To: Thanos Makatos <thanos.makatos@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Levon <john.levon@nutanix.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
 <20260720135823.21070-1-thanos.makatos@nutanix.com>
 <20260720135823.21070-6-thanos.makatos@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260720135823.21070-6-thanos.makatos@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/20/26 15:58, Thanos Makatos wrote:
> The existing check for PCI capabilities misses the case where
> info->cap_offset == info->argsz, which results in accessing unallocated
> memory. Fix the comparison.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3865
> 
> Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
> ---
>   hw/vfio-user/device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
> index 008e5cf687..67736383b8 100644
> --- a/hw/vfio-user/device.c
> +++ b/hw/vfio-user/device.c
> @@ -214,7 +214,7 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
>   
>       /* cap_offset in valid area */
>       if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) &&
> -        (info->cap_offset < sizeof(*info) || info->cap_offset > info->argsz)) {
> +        (info->cap_offset < sizeof(*info) || info->cap_offset >= info->argsz)) {
>           return -EINVAL;
>       }
>   

Fixes: 667866d66620 ("vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO")
Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




