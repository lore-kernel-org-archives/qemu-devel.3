Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E713BC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm4cL-0002Bd-Tq; Tue, 21 Jul 2026 03:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wm4cJ-0002Ak-1V
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 03:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wm4cG-0000ls-PV
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 03:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784617811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZMO4Re7I5CJWeuCotjiNenDVRWR5sPzMiHPMEcsvfCY=;
 b=PoIkqST1KJ2epNuiz2VGqOL0GZxTzqBAMyEvVTBsvZlrgAsXSqJHPLn/onfCp+QlSvWcoL
 t3krClQh0ySQH+DfMY+7jtUY7j/NdPuEK28+0UtASYGVOghgjTSWUxuu0n55uBsKOxwtfh
 uSt9QQBGwCHKGzJ2SxbRQ12ngb2jj5E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-wBy7fPXSMqGgyo5xp38XTA-1; Tue, 21 Jul 2026 03:10:09 -0400
X-MC-Unique: wBy7fPXSMqGgyo5xp38XTA-1
X-Mimecast-MFC-AGG-ID: wBy7fPXSMqGgyo5xp38XTA_1784617808
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-492488f8583so146042595e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 00:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784617808; x=1785222608; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZMO4Re7I5CJWeuCotjiNenDVRWR5sPzMiHPMEcsvfCY=;
 b=Mu+xvPAHw5TxUN1djSoP/v3icHd9AaZ/sFP5rsJ+GlNKDpvrK2l65HngLrvtIH+LSz
 dGbJNJX9dShYr/oWyJltgwHIb+NDcsqJOIp/QUW3H+HRTIjj4keUZ+Ji76vfpHU3zVOH
 uLafJneUnDcr4tMsFfHtuynGMFZ2YAX579dslJ7nHpF2EAsZlktbIcOdwQp8c9+paFIn
 JtUeEgL0FfsIv86JlZpIDUxhY2T3w5ncOYGvZwUSbRRcbp/R/PAtaPVxoVehRrGgoICX
 QFh3j/pQYAlo7sNNwkV8U6I288aEqvOZuRVJpXe+IECMBYjqPDgjnPL7PYPRRIKHDbR5
 eEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784617808; x=1785222608;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZMO4Re7I5CJWeuCotjiNenDVRWR5sPzMiHPMEcsvfCY=;
 b=rt9Ovc9D0jQV1xVP+eAHt8O15pHEcspnuuEIGnohURKv7CqJVCXuBhzwX2nnd08c7e
 sG891gjlSmvBVL4+Lob/5NR5i5zGbHz1V8esUh5k0pRkhjjWvV7XZeRgbaZftJSYDdqU
 VxfW54GjiMUUEAOfM1KzRFi6ai7YmTEyPiqMiqiRUrH+AwBeY6xtKQInyM/7k4tlSpRG
 7Q7YZvBE4XZ6p0HGHGMFL1I9MVzfSH8STIu4u1GzvwHoVl/M0yfLc+MnVmIChphKQU12
 Uq0UhZdgwN+3mchYmU5kJIHyIGrdMpIteK8ibdUT9R7YB0vlY74YeACmOYUetA7I5ghd
 XCKQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RotN7DlccLfkj4S5QXt/p2ol+bMcHl29lMGsNsvyufvH24FXFlBrHe9dLrXjam3kmsUkAK8e6+TUskU@nongnu.org
X-Gm-Message-State: AOJu0YwDmvSvATOkxB159rZ65BPqZ82MLAEtQDBn5wHSjiTU6bitppoL
 NouAV7aSyebfkNiFf53S5cKyXUGFBR8ZKoZX0XGldPnMDYv5Q4DJ7pbGkaGXEd3hxnKo5+CB7je
 e3rxRztfrKmAMM4wK0bV74OhmIvXsrUJmc7v4GsQRZvXzGYrbR3oxNh6S
X-Gm-Gg: AfdE7ckLx9vChjfYu6Tc3WTL5PuH3aUExS5gLmW4kxGKPQ7bcC3jw3UDWQo22UT169u
 OKCon9XsKReWKoPgpQzTLpPU+JDMvat9Jbo1ULFcyAymN+kWAADD/Qn+FHzzFalDEVa+tQuYo15
 C1DRrqAkq2IwOyrjdiCRduRABBQYs1TI3w2D/Nl0kadtpWzvl+Z0mbq1+40mFWlLTTi/y/9dYJj
 mmA0DfJYBxL9YbG6nWr+dwJy/7j/H2XMd8pM4Lwxc2uF8AqyJ8oGt70JjC9V1hTCcT1Z83G2sDE
 LvOOO66+QL5aE3ressMW2UormLk1022jJE6MtfAIgfPMOYbu42tEkmvK4W9K1oyxrsJYwKtuePB
 PerS9mcDIEzr815UKGxyFACOrhPyk5+XNzQCvyVw=
X-Received: by 2002:a05:600c:580d:b0:495:4598:6e14 with SMTP id
 5b1f17b1804b1-4954a4060demr143083135e9.24.1784617808333; 
 Tue, 21 Jul 2026 00:10:08 -0700 (PDT)
X-Received: by 2002:a05:600c:580d:b0:495:4598:6e14 with SMTP id
 5b1f17b1804b1-4954a4060demr143082685e9.24.1784617807799; 
 Tue, 21 Jul 2026 00:10:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653bffefsm43431195e9.9.2026.07.21.00.10.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 00:10:07 -0700 (PDT)
Message-ID: <8ac1d358-6f66-437d-8218-cb4be586ae65@redhat.com>
Date: Tue, 21 Jul 2026 09:10:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] vfio-user: vfio_user_get_region_info: prevent
 buffer overflow
To: Thanos Makatos <thanos.makatos@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Levon <john.levon@nutanix.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
 <20260720135823.21070-1-thanos.makatos@nutanix.com>
 <20260720135823.21070-2-thanos.makatos@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260720135823.21070-2-thanos.makatos@nutanix.com>
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
> If the vfio-user responds with a value large enough such that adding
> the header size to it overflows, a smaller buffer would be
> inadvertently allocated, leading to buffer overflow.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3867
> 
> Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
> ---
>   hw/vfio-user/device.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
> index b8d2b7c1a8..e58167a818 100644
> --- a/hw/vfio-user/device.c
> +++ b/hw/vfio-user/device.c
> @@ -128,12 +128,21 @@ static int vfio_user_get_region_info(VFIOUserProxy *proxy,
>           error_printf("vfio_user_get_region_info argsz too small\n");
>           return -E2BIG;
>       }
> +
> +    /*
> +     * Ensure that size doesn't overflow, otherwise we'll allocate a much
> +     * smaller buffer than we need.
> +     */
> +    if (__builtin_add_overflow(info->argsz, sizeof(VFIOUserHdr), &size)) {
> +        error_printf("vfio_user_get_region_info argsz too large\n");
> +        return -E2BIG;
> +    }
> +
>       if (fds != NULL && fds->send_fds != 0) {
>           error_printf("vfio_user_get_region_info can't send FDs\n");
>           return -EINVAL;
>       }
>   
> -    size = info->argsz + sizeof(VFIOUserHdr);
>       msgp = g_malloc0(size);
>   
>       vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_GET_REGION_INFO,


Fixes: 667866d66620 ("vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO")
Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




