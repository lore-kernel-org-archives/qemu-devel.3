Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550D2C4452F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9jT-0006AU-WD; Tue, 21 Jul 2026 08:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wm9jJ-00068S-PM
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:37:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wm9jH-00072Z-C0
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784637462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XSZwtCSsIJNR1RlvXBr8hBnuCFZ456NZpkaK/avBFJo=;
 b=BABkqPkY8HFkRYG1XRlIHvKOb1Z+s+WtFPbpN1CLFpD9HDMVXEgsT/Gp9jQspkCZAP87Xt
 iqBUlvUNbOepYT/c0eicMMPIKES0wmg0LqsEZzAamz2RqmRJHU3WyGcpDDhwxoJxHpXZRG
 8ybtbqqYvIgWiL+wNaJCuMhsCri1rlg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-0jbuSZKQNtWaL6bA8p7ksw-1; Tue, 21 Jul 2026 08:37:41 -0400
X-MC-Unique: 0jbuSZKQNtWaL6bA8p7ksw-1
X-Mimecast-MFC-AGG-ID: 0jbuSZKQNtWaL6bA8p7ksw_1784637460
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-69e984607e7so3528991a12.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 05:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784637460; x=1785242260; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XSZwtCSsIJNR1RlvXBr8hBnuCFZ456NZpkaK/avBFJo=;
 b=rbh2PVPhzumipaq5wy7E+PfDz7bDVDZQcn/xjFT5uz7R4oUuHx2INiL9lwY7R3EnIa
 sYJYtIi/bQOC3bkjM2xzMI7YEAEftEzILA4Yn1CQXBWQvMZaoBo+5SPFwOhPvPZ6ubN5
 XH27zLXW1FrQAOKNkLIDgHxxGe1f48nIeYBQY7GwWBXos7UsATMj41Rl9KXjywUTtx+6
 1dU2Pycha83Hx9GhqtguJeg32cFEHuDStXak2ZaJMcH4R922q2HTgqZ2RhPyeUFJJQax
 eiUUd+//VeJURtUq7RG463qcofP2u3e8Szjf06E0Dc/vgrUiKqUQYwAB/RtepFFfaLqO
 iRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784637460; x=1785242260;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XSZwtCSsIJNR1RlvXBr8hBnuCFZ456NZpkaK/avBFJo=;
 b=Ey5hEF4s99xpJGUx0TXhEvJDqbkbKuWmapaWAxoXGfuZnH0nBxpQMjDxBvQfbNFuXq
 V4Pj4dxrYJLZwnzankezYBuXkjmBNamkVEj1ZMSaC0OQh+J1HI5AGd18sS8tt4aUrtrg
 wbJ1jJk233vqm23Lg24YXk+Zx4lF8NwJS7FSCLVULvh1GmfMo6QcIhc4chDDZee4oncR
 Z2rkcohZBJZ8XhC3dNhkWu6YqJ9Juedyd/uVLEwRhJy20gaFg1HLajnuUCmiOzUw7vil
 8VkeZamND0KoDbzdoMC/+Uq3ZWnpQXYIWDEnwv8kM+/5lFnnqcWT/dlguop1wLJB/gWa
 2sqA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpeVmX6ScaMtrw+xf30VMmAAdJZP1pvHJrEn1kb+J6206sxG1JfO85yUD+TRPE/UHWJ8u3DjXQl1ti+@nongnu.org
X-Gm-Message-State: AOJu0YwQRRK1NRqqrDIQhEEOOXxvl22TxXO1GGuL1nDmuRFpOjVWixgd
 pMQmseU7tDZVD7+w4bqY6DJJlBpX6O2WOt8gLynPG4GbMP7C1MK/poGbMihArne5p0Jxhkpz68x
 nxWMT6tyG0DVpN2kwcIZdc2o1GfMPY34B0mQUThZPWkqErUeXI7srr8pR
X-Gm-Gg: AR+sD12m9v3ZwDIgZmb2Auv66IKHESKoO/Ygwp2eb+IX1yG3zw0HqbGja/DiA4IFYBu
 dhMkzC+cycfVKOGNxkTjBxuVasjnydMgT3KW8TSQm8/D3M6eq44QsjR1yhXe1Kj1bZoOtTD7bel
 NpwTV96KlD6NXV9D4PT9Dn0HT436LVePyFmN7jvtobrPePO4NioDN6hJrS5qdrduL9Kto/gqkm8
 GTiWKa8MlBjSgK8Pvsjivrj2iHQyowZoIOUrHnZuT86wAEu+wBmQgLAqUXF5HNmKwau3/o0VdEV
 PPweM4i24NuxXwmaRE9pigo7pPUc55vGtTNR0zhHhovc+TEbfRz5Nz7fKtt5RQA4sT2INnaQ7pE
 UF3wiwB8ttYdNBTQGKSCNiZAQLvGu61yZ/YM9pqI=
X-Received: by 2002:a05:6402:190a:b0:698:9be1:4a5a with SMTP id
 4fb4d7f45d1cf-69e6525b702mr6741087a12.7.1784637459956; 
 Tue, 21 Jul 2026 05:37:39 -0700 (PDT)
X-Received: by 2002:a05:6402:190a:b0:698:9be1:4a5a with SMTP id
 4fb4d7f45d1cf-69e6525b702mr6741079a12.7.1784637459474; 
 Tue, 21 Jul 2026 05:37:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69e6fef2477sm6101864a12.7.2026.07.21.05.37.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 05:37:39 -0700 (PDT)
Message-ID: <4584d6c3-e6cf-4d36-a1ad-51d180925396@redhat.com>
Date: Tue, 21 Jul 2026 14:37:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] vfio-user: validate server responses
To: Thanos Makatos <thanos.makatos@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Levon <john.levon@nutanix.com>
References: <20260720135823.21070-1-thanos.makatos@nutanix.com>
 <20260721122643.30985-1-thanos.makatos@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260721122643.30985-1-thanos.makatos@nutanix.com>
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

On 7/21/26 14:26, Thanos Makatos wrote:
> This patch series fixes some bugs where the vfio-user client doesn't
> properly validate information returned by the vfio-user server.
> 
> 
> Thanos Makatos (9):
>    vfio-user: vfio_user_get_region_info: prevent buffer overflow
>    vfio-user: vfio_user_get_region_info: respect max_xfer_size
>    vfio-user: vfio_user_get_region_info: reject unreasonably short struct
>    vfio-user: vfio_user_get_region_info: prevent excessive malloc
>    vfio-user: vfio_user_device_io_get_region_info: fix capability check
>    vfio-user: vfio_user_device_io_device_feature: prevent buffer overflow
>    vfio-user: vfio_user_device_io_device_feature: prevent excessive
>      malloc
>    vfio-user: vfio_user_device_io_set_irqs: prevent buffer overflow
>    vfio-user: vfio_user_device_io_set_irqs: prevent excessive malloc
> 
>   hw/vfio-user/device.c | 54 +++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 50 insertions(+), 4 deletions(-)
> 
> Changes since v1:
> - added 'Resolves:' in patches 1 and 5
> - added missing SOB from patch 1
> - removed reassignment in patch 1
> - added a new patch to address the same issue as in patch 1
> 
> Changes since v2:
> - expanded cover letter
> - added 'Fixes' tags
> - improved check in patch 5
> - removed extraneous new line in patch 6
> - added patch 7 and 9 with same check as in patch 4
> - added patch 8 with same check as in patch 6
> 
> Patches 1-5 address issues introduced by:
>     667866d66620 ("vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO")
> 
> Patches 6-7 address issues introduced by:
>     e2358af5838d ("vfio-user: support VFIO_USER_DEVICE_FEATURE")
> 
> Patch 8-9 addresses issues introduced by:
>     ca1add1696 ("vfio-user: implement VFIO_USER_DEVICE_GET/SET_IRQ*")
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


