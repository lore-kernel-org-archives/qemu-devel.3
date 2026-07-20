Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B54C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlmBj-0008W0-7X; Mon, 20 Jul 2026 07:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wlmBi-0008VK-5q
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wlmBg-0007tZ-5a
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784546970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fR5AiT/cAxn+QI1I8yG9P+nDCse4n7b3HfZ12cjFwKk=;
 b=OQT7PFVt4UzyX5Za7CYkQW2VFQ3Qsqi/0TOVoL8/nwTu92jKmYokNBS0bxQ/nRXUgSkCix
 VGP1sgZDH/RoyeS361cguGwp33NQueXo6L8REHC6Eh+Rwd3hZPjpzz4NeN7nFCksf3Kt0a
 yzNGt19oGdaxdoZ07Ene8U0We3WkgZE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-Iu49Hn0fMqeGhAXS3zfxFA-1; Mon, 20 Jul 2026 07:29:28 -0400
X-MC-Unique: Iu49Hn0fMqeGhAXS3zfxFA-1
X-Mimecast-MFC-AGG-ID: Iu49Hn0fMqeGhAXS3zfxFA_1784546967
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4955fd77c18so4181965e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 04:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784546967; x=1785151767; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fR5AiT/cAxn+QI1I8yG9P+nDCse4n7b3HfZ12cjFwKk=;
 b=jfz7siy4A2jw7ncMKehFD4PHoYkLwuPEJMgIDHHUqAzYMkDxcjAzYxABJBnP5fj7+z
 Cp7R4qB4XZ0kkNYPow/T22uK/a+YRjFHyn6/T2GvIpseECdGlog+mi/utU0cm/keZG7z
 UXGbQTNtQV2Gqia6VB1c8xvLAPn6yeIFEYrWVbDRgP04j+qYFgT6deaXBpoYLbQAFBxU
 bv88zKBGDFZQG94lx+CzuAmFW8KjYTBvTWlhlTTHQnbOUbmufqOZgri3fdbAVgid2yoY
 5n8j/iOC4o2yowPcieo1OT7Qf+4qxoA1ZmVxpPHhHUovpyBEUzjICvj+2oq24TvO+qLH
 oYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784546967; x=1785151767;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fR5AiT/cAxn+QI1I8yG9P+nDCse4n7b3HfZ12cjFwKk=;
 b=m8yuyc0FJOga87e7P5xKAMoNcfB1E/GWn1Eff7Yu3oJx23hSuakgclr21k6U1WI4ND
 iptRHcBj9xVgT1TEwvAU3pwlDAQt+24MNj4RYgnfcdxzBdIngk1aSg1s79XzUSEt0g1w
 RmcpCPR95eocnFKj7EsNuHUXG86/1c324d8zgOjj1jf0C5fT1fCS7aAc8XDjnxJi2Nr+
 wHJ1cQpk62kiI5vktSSZzK6p0RmEJ0A1dMU2g6bLFqmXm61fs37HdbP/qExl4U5PYz9e
 UWevYziHPE3cgj/gwxQgjO02CVey2sr67QONzgQHcEOwxhNGzJgYWYjiSZTHGodi6nvb
 K4Xw==
X-Forwarded-Encrypted: i=1;
 AHgh+RolXihivMQPJqiR69vZV6S6oTbOCxZpOoFaXYzXCxFkjbwpuJhkVTwiRsAKMv2BHQm1r16tNXHYp+K5@nongnu.org
X-Gm-Message-State: AOJu0YznhmyWjHFjK4b/jTHm0q8y3QPSax9M65EPku/Q57dFBf7x68bd
 F6vQkCPYcGKuJzmaQaRzLOfKpnrUu1FJQj1gdsHUSF5jtYiGN3V7zqKhQOlSqFhRowp5+Q3rXI7
 hCSeDsvW1xsqaXs++m3mq+i28P2Q3ymiSl7CgNb16ro6QH5/5WnwkiOMA
X-Gm-Gg: AfdE7clT4M80EGrnhVimU6UK6LjKnm1QRHCfhyli3Tqa/OpPHFhTrID8romDq9DJUV3
 lYxPfGgo/jabokH9igiwDk264/XAg9vdgLb6ycO69N+WATD/IbzYoPK3nPglCzUiX3PREv2lFUa
 lXwgUQGYKsf1iqHrFe17Navm2FdQACpmOgxNOqDUWuTeRxyRw65XgPFgSla2HOEh3gyQzp7S9zw
 +/z3dYQKmDqm2UCRHoCeBXFMu9i9bTuuQh7iufiRk0xHL+b6iIWgiBtJyD+Ynk6UdaZ1T6lo70X
 KPnVkBNWLF+c7ss1YWB8YeMsOM7b4eHqr5C7dCVIBzYch0zgOVjfYz6aitxoYFXUg/Ewoh96DRo
 0tKpg3ZRVgoAJFdKYZ7t1aLEpadNocRBsyWlZVpo=
X-Received: by 2002:a05:600c:705:b0:495:3b8a:bf11 with SMTP id
 5b1f17b1804b1-4954a515217mr99817265e9.26.1784546967310; 
 Mon, 20 Jul 2026 04:29:27 -0700 (PDT)
X-Received: by 2002:a05:600c:705:b0:495:3b8a:bf11 with SMTP id
 5b1f17b1804b1-4954a515217mr99816905e9.26.1784546966750; 
 Mon, 20 Jul 2026 04:29:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49563e60fd9sm7606265e9.0.2026.07.20.04.29.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 04:29:26 -0700 (PDT)
Message-ID: <664901a4-d8ce-4f12-8511-86acd3f53c37@redhat.com>
Date: Mon, 20 Jul 2026 13:29:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] vfio-user: vfio_user_get_region_info: prevent buffer
 overflow
To: Thanos Makatos <thanos.makatos@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Levon <john.levon@nutanix.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
 <20260720091718.2642-2-thanos.makatos@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260720091718.2642-2-thanos.makatos@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/20/26 11:17, Thanos Makatos wrote:
> If the vfio-user responds with a value large enough such that adding
> the header size to it overflows, a smaller buffer would be
> inadvertently allocated, leading to buffer overflow.


missing Signed-off-by:

Could you please add a reference to the 'culprit' commit and

   Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/xyz


> ---
>   hw/vfio-user/device.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
> index b8d2b7c1a8..19a42c2a25 100644
> --- a/hw/vfio-user/device.c
> +++ b/hw/vfio-user/device.c
> @@ -128,6 +128,16 @@ static int vfio_user_get_region_info(VFIOUserProxy *proxy,
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
A bit below, we have :

     size = info->argsz + sizeof(VFIOUserHdr);
     msgp = g_malloc0(size);

which becomes redundant now.


What vfio_user_device_io_device_feature() :

     int size = sizeof(VFIOUserHdr) + feature->argsz;
     VFIOUserProxy *proxy = vbasedev->proxy;
     Error *local_err = NULL;

     msgp = g_malloc0(size);

it seems to be a problem also, isn't it ?

Thanks,

C./




