Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D704ED12D68
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 14:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQnUT-0001zc-PD; Wed, 03 Dec 2025 09:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vQnUR-0001yk-PT
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 09:05:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vQnUP-00045z-NJ
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 09:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764770748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YGPG2BDHUJ2l1WS+IL8JR9jycU1efWCbEY48TqMdn5c=;
 b=NYFUZq9oipJ1JoOGXC+Z9LHxg5hGA7Gn4QBPA1KEkp0u9j4+BPgTLK7Kp3Sehk96zOPZGV
 K/Nt/SH5IbWeQVrez26P7vHDvTGQpmpeLHuZGoD8sxTssxgP/OzY38vsxTMms+iqv1oGwh
 OmrCMJmd43xT8nOJCpfh/LgyukmRekk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-IBeMUlHWP0eWQB4eOn78Xg-1; Wed, 03 Dec 2025 09:05:45 -0500
X-MC-Unique: IBeMUlHWP0eWQB4eOn78Xg-1
X-Mimecast-MFC-AGG-ID: IBeMUlHWP0eWQB4eOn78Xg_1764770744
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4776079ada3so59297415e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 06:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764770744; x=1765375544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=YGPG2BDHUJ2l1WS+IL8JR9jycU1efWCbEY48TqMdn5c=;
 b=hT5D29IAwaYrUHRdUnvrQm2JH6N63gafe0XR/BD7FOdN2ZAL9ljZJ08/AEj/xJcxPI
 KMpw0wXPE7gDfARdOxTJsMyrzkNkX5yUPljIOq1llTRK7ZwpGF+B1xjgYegbet8KQchx
 b6k5mo24qczV6gPjFf/ix2yv2zbJjEv8nIXjNEzKa/3qec5Y1lQuH0d8E7LAK7agaXOK
 je6Vc8J9wRtvosBH2iCbvHDC2p6QkKEJGtILSw1/NuCufDUgPFstSVW+sQBLscp2Ftmm
 sToHOWsb5+ZIvJ1Eejro0GHo2LO4hWL2GU4epVJR27Uep0fFwGqwa6RnJnO+2JwXqiPq
 5/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764770744; x=1765375544;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YGPG2BDHUJ2l1WS+IL8JR9jycU1efWCbEY48TqMdn5c=;
 b=D3UfWTJwQtdRaLPLmeUZXT+Dh7tePmtyBRr9PsTTdwTyjCV6iZxBe8phgi1E6+cKFc
 CnYHw4dWwdOeBXuEhMtxzxTKYqql4R4BjvWUXGL+HOPyKaxTHZhrRzL/o88Btyy/TnGJ
 1E5D8C2NCZi6Tc8yF+A7gLhzycprF/6Vqj578YlMX3fj1eYGZQfw4ze46KncqDsbrgpr
 xAHt/0wz3kDF+AYAT8a4FNF6sxY6GOhzWbqEEMqWwNI9bRPiuKqRApgAi8sCi86hRKWG
 bjD3JbM6lrGAqSvSi4DF8hMtnZGamE9hTIyyOgtRYGFM9IzC+7kezQ4YLKyt1uIEaf1K
 rr/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUjpZu1QiF1r9EW4QjIHDx+J3UO4Qwz8voJ2BDQAmLxhBCpcoEIL5PU0JYxbWh2o2izNUnJ7awNNVo@nongnu.org
X-Gm-Message-State: AOJu0YxsSeLG1mlSoer0bndSPXX0RSBORHb/1Pi2GO5CQ1OE6yyEIaMf
 W7PvCkOsJkqg1zyeKKzhRz3e9Np/2JVJB06R6NkZDKguHq9v/+gMliDmt9bbc2L06+dafsVCekR
 wwld03/ZTuVT8e87OyXxxTtzH12Yul/shSaZKRY9oXdFcoMKLWVpd3GjI
X-Gm-Gg: ASbGncviNrIoju1W+Lmi+4aqdycTFz+rlUmdAeK2Ldw+BnPu5ERVxCe9E2HOaHa/etw
 RC5bxRU1PWdXdmYcmOYUP7nuTkcKHQCaTlgpTeUtHiDDZHkIbCzXgqcSMe4CfJrE0jkh0UFp1gk
 jIEm2khzJi1tC0+Lo1NRqL3pVqON0cloeFRThbheHiizFUMFJDbt8T4xwHo5m4w3/sN55Y3S+pJ
 qlR2jxtyNN0RIdlvvnGI58a8tlXlkD4/hCZCM8w/P3PbEslXrUFuNhYD9SVT/dyRN5JFWD8gkLy
 K1XdfNU3FfAB4DOemHiYA+vilpx+ufVRq6wDNK3svg+bG/WnD8D6rgW4AgOshgwjw038Slz32Em
 BGYoHpaYLJ2n4EQ+/bRGVs8zHuwapq/NE/XX3gIQ1djBsb7SA
X-Received: by 2002:a05:6000:2689:b0:42b:32f5:ad18 with SMTP id
 ffacd0b85a97d-42f73180f9dmr2818577f8f.9.1764770744154; 
 Wed, 03 Dec 2025 06:05:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFKibXKfNVNkA5OBhvRY++EIlWnmCown9+3olkL/NyjhZEMMmupDLtel/vWHMur5nb+6NCCA==
X-Received: by 2002:a05:6000:2689:b0:42b:32f5:ad18 with SMTP id
 ffacd0b85a97d-42f73180f9dmr2818542f8f.9.1764770743660; 
 Wed, 03 Dec 2025 06:05:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5d6277sm39436806f8f.17.2025.12.03.06.05.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 06:05:42 -0800 (PST)
Message-ID: <f2986f27-5279-4236-9013-ba1adb8a1d95@redhat.com>
Date: Wed, 3 Dec 2025 15:05:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] vfio-user: refactor out header handling
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>
References: <20251203100316.3604456-1-john.levon@nutanix.com>
 <20251203100316.3604456-4-john.levon@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251203100316.3604456-4-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/3/25 11:03, John Levon wrote:
> Simplify vfio_user_recv_one() by moving the header handling out to a
> helper function.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio-user/proxy.c | 101 +++++++++++++++++++++++++------------------
>   1 file changed, 60 insertions(+), 41 deletions(-)
> 
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index 82c76c6665..e0f9202535 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -218,6 +218,61 @@ static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
>       return 1;
>   }
>   
> +static int vfio_user_recv_hdr(VFIOUserProxy *proxy, Error **errp,
> +                              VFIOUserHdr *hdr, int **fdp, size_t *numfdp,
> +                              bool *isreply)
> +{
> +    struct iovec iov = {
> +        .iov_base = hdr,
> +        .iov_len = sizeof(*hdr),
> +    };
> +    int ret;
> +
> +    /*
> +     * Read header
> +     */
> +    ret = qio_channel_readv_full(proxy->ioc, &iov, 1, fdp, numfdp, 0,
> +                                 errp);
> +    if (ret == QIO_CHANNEL_ERR_BLOCK) {
> +        return ret;
> +    }
> +
> +    if (ret < 0) {
> +        error_setg_errno(errp, errno, "failed to read header");
> +        return -1;
> +    } else if (ret == 0) {
> +        error_setg(errp, "failed to read header: EOF");
> +        return -1;
> +    } else if (ret < sizeof(*hdr)) {
> +        error_setg(errp, "short read of header");
> +        return -1;
> +    }
> +
> +    /*
> +     * Validate header
> +     */
> +    if (hdr->size < sizeof(*hdr)) {
> +        error_setg(errp, "bad header size");
> +        return -1;
> +    }
> +
> +    switch (hdr->flags & VFIO_USER_TYPE) {
> +    case VFIO_USER_REQUEST:
> +        *isreply = false;
> +        break;
> +    case VFIO_USER_REPLY:
> +        *isreply = true;
> +        break;
> +    default:
> +        error_setg(errp, "unknown message type");
> +        return -1;
> +    }
> +
> +    trace_vfio_user_recv_hdr(proxy->sockname, hdr->id, hdr->command, hdr->size,
> +                             hdr->flags);
> +    return 0;
> +}
> +
>   /*
>    * Receive and process one incoming message.
>    *
> @@ -230,10 +285,6 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
>       g_autofree int *fdp = NULL;
>       VFIOUserFDs *reqfds;
>       VFIOUserHdr hdr;
> -    struct iovec iov = {
> -        .iov_base = &hdr,
> -        .iov_len = sizeof(hdr),
> -    };
>       bool isreply = false;
>       int i, ret;
>       size_t msgleft, numfds = 0;
> @@ -257,45 +308,13 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)

I wouldn't say vfio_user_recv_one() is nice to read ...

>           /* else fall into reading another msg */
>       }
>   
> -    /*
> -     * Read header
> -     */
> -    ret = qio_channel_readv_full(proxy->ioc, &iov, 1, &fdp, &numfds, 0,
> -                                 errp);
> -    if (ret == QIO_CHANNEL_ERR_BLOCK) {
> -        return ret;
> -    }
> -
> -    /* read error or other side closed connection */
> -    if (ret <= 0) {
> -        goto fatal;
> -    }
> -
> -    if (ret < sizeof(hdr)) {
> -        error_setg(errp, "short read of header");
> -        goto fatal;
> -    }
> -
> -    /*
> -     * Validate header
> -     */
> -    if (hdr.size < sizeof(VFIOUserHdr)) {
> -        error_setg(errp, "bad header size");
> -        goto fatal;
> -    }
> -    switch (hdr.flags & VFIO_USER_TYPE) {
> -    case VFIO_USER_REQUEST:
> -        isreply = false;
> -        break;
> -    case VFIO_USER_REPLY:
> -        isreply = true;
> -        break;
> -    default:
> -        error_setg(errp, "unknown message type");
> +    ret = vfio_user_recv_hdr(proxy, errp, &hdr, &fdp, &numfds, &isreply);
> +    if (ret < 0) {
> +        if (ret == QIO_CHANNEL_ERR_BLOCK) {
> +            return ret;

OK. That's how the goto fatal is avoided.

> +        }
>           goto fatal;
>       }
> -    trace_vfio_user_recv_hdr(proxy->sockname, hdr.id, hdr.command, hdr.size,
> -                             hdr.flags);
>   
>       /*
>        * For replies, find the matching pending request.
Looks ok to me.

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




