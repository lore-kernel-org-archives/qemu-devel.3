Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5EDC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm4d1-0003J7-Hq; Tue, 21 Jul 2026 03:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wm4cw-00038u-N2
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 03:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wm4cv-0000ol-8X
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 03:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784617852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ha7KLnEi8X0o39L4CD6+XxJeNoFuI1BLMvXP1r/zRmI=;
 b=gEmouOj0ueLr0vSNFHNKqtSuFD4hF7YnmYJ+E64///b9CRozeP+h7UfRZraffbtUxhWNby
 tCcDTo0bar+twRkSNs6vyXMOwh+fq7aI9SWTmdBIPqE5UyELkYspZLyxx1fik8zKyQW7OH
 SK3mY3sFxZ09w9wrPhy5+k1TFhm6XMo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-fBHuNHFxNwqhAMUcC1KQsQ-1; Tue, 21 Jul 2026 03:10:49 -0400
X-MC-Unique: fBHuNHFxNwqhAMUcC1KQsQ-1
X-Mimecast-MFC-AGG-ID: fBHuNHFxNwqhAMUcC1KQsQ_1784617848
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4955b84e25eso19391175e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 00:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784617848; x=1785222648; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ha7KLnEi8X0o39L4CD6+XxJeNoFuI1BLMvXP1r/zRmI=;
 b=HhAbOqc1hvLJRSVUXhrQB19etTrZ+prCCmGQ+dX0NR/iK70Q0omE3LvvEbp7LDw2f2
 75MYNjn8vJJBpQwRGYF6N/oSlDRl96P1rNfUG9V1gBYS65m8cu35HKpacmB6doQWsNH3
 qDIc9UHS4jaiDYyD9c7v801vDUeQBsWmJU9Fge4wH92CbFgxykhpwyrlOc2xJtwJUU6M
 JPCluUjUcDXHO28SXKpOv+MnMVSU7A0hqpUn5bKu7j8CGez0EljHon571h1X7LQX69Q/
 b56OLUKLhA27P2vmxFAZnRBZLxBUNrKFfumFyusZ8HzO1a9zUVVYybc/WJ3GCkgk76vU
 90Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784617848; x=1785222648;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ha7KLnEi8X0o39L4CD6+XxJeNoFuI1BLMvXP1r/zRmI=;
 b=E4OowJ22RSmklz9GWMcW5BCh9sVZ6d91qrf9+mXQnwJK9/qJeSj8MhW7nHHLUfBTFK
 tHCdlqBLnydy8i2dg9z8mqaKnPu9WePi1wUw0/QkPFMTpD0pFVDeILsPiPXOZ2dIi3aG
 BWQeebbB/smxxmtxIL4iFSbGIBnfo9MzeWWNG/oamwym+qF//Bvie94WgPiEmVapFwIQ
 N84KmXB4jGSOF3acZbu/N3SRwDfFwkZV9PXG37klGYh+8INw9QnE2ZYrnHNv2RumOarw
 lvc745a8cVJJcw8NEaX0eooHmrjLheoAOQtivUuHTe8/gYbS5fRcMbRoW3MCiDnsyuSK
 Ouhg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro9ByVOmmCduYMeie9JcmTl8tkjU7Mqulh9vS7HiS1jvq9g6s2quPA8bntJQXhSIf3CXQNouAleBta5@nongnu.org
X-Gm-Message-State: AOJu0YzNxGlIKxKU8M1c3ryc4eX92xB/KczI7TPMHzjW6NMy4aPOzJ8m
 mqHRkC5oSuWvI8ApFWY4WY8S3Ojh12UeQI7Oc716aS43f9vdPDkXnMWxqw1P6iHjOklFHH8fDhm
 tF4I/TzbkIDHpKttEthArg6NMFTrzD2coD/gbr+KBOLrYp3Fdu+3uNAds
X-Gm-Gg: AfdE7cn+RiIyByAKRzkqsJsWLQo7AFBBacuCAFiT57XKDJcBsYrMQWpO5O5KHqiRRNN
 QC6fF3d3alHuDtI89X8K3Alr60BVaZNM/0s20yg8NWuzaAnv3cixQ0ahOIxgF9ukn894MDLo3WP
 M9F590EAevp5zTwcthSJLIjQN7cZFfLAWku9smab9qaFcyZowo4xlpCaw188nXxSxaU4+HUoTX5
 qO0HoHZajviNjXSrtt6QdhKRgiqEp9YSs1GuUQTKLlNNwhJw6oWk9TyPTKhK7Bmv+Gt/w7O++YN
 kHHbZ6HXkBf+g3hRhnSon+NTqyCaHZyFmzvXKG0yHQGn3W4SL/sUG/ly3nvqHsOcmSZHCfaffz3
 9RJraVnx7xTS99x4UWETggoLK2xs8Utc7jCl3jIw=
X-Received: by 2002:a05:600d:6454:10b0:493:bfbf:1da4 with SMTP id
 5b1f17b1804b1-4954a403910mr144584005e9.22.1784617848451; 
 Tue, 21 Jul 2026 00:10:48 -0700 (PDT)
X-Received: by 2002:a05:600d:6454:10b0:493:bfbf:1da4 with SMTP id
 5b1f17b1804b1-4954a403910mr144583695e9.22.1784617847935; 
 Tue, 21 Jul 2026 00:10:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49563971572sm57236465e9.3.2026.07.21.00.10.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 00:10:47 -0700 (PDT)
Message-ID: <d5c56dd5-6a98-471c-bef6-4eb518534d9c@redhat.com>
Date: Tue, 21 Jul 2026 09:10:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] vfio-user: vfio_user_device_io_device_feature:
 prevent buffer overflow
To: Thanos Makatos <thanos.makatos@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Levon <john.levon@nutanix.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
 <20260720135823.21070-1-thanos.makatos@nutanix.com>
 <20260720135823.21070-7-thanos.makatos@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260720135823.21070-7-thanos.makatos@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
> This isn't in practise a problem since feature->argsz is not
> externally provided, it's a good hardening step nonetheless.
> 
> Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
> ---
>   hw/vfio-user/device.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
> index 67736383b8..131be7af61 100644
> --- a/hw/vfio-user/device.c
> +++ b/hw/vfio-user/device.c
> @@ -79,9 +79,15 @@ vfio_user_device_io_device_feature(VFIODevice *vbasedev,
>                                      struct vfio_device_feature *feature)
>   {
>       g_autofree VFIOUserDeviceFeature *msgp = NULL;
> -    int size = sizeof(VFIOUserHdr) + feature->argsz;
>       VFIOUserProxy *proxy = vbasedev->proxy;
>       Error *local_err = NULL;
> +    int size;
> +
> +    if (__builtin_add_overflow(feature->argsz, sizeof(VFIOUserHdr), &size)) {
> +        error_printf("vfio_user_device_io_device_feature argsz too large\n");
> +        return -E2BIG;
> +    }
> +
>   
>       msgp = g_malloc0(size);
>   


Fixes: e2358af5838d ("vfio-user: support VFIO_USER_DEVICE_FEATURE")
Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.





