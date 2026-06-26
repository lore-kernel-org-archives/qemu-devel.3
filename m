Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A7FC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 18:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdBWR-0004PG-A6; Fri, 26 Jun 2026 14:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wdBW6-0004Kv-U3
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:43:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wdBW3-0002kZ-NP
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782499382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1m08xl5zj2iO0x6HrTgIsPIoRO2MXBBRZkFG3G9+fcQ=;
 b=QK+qOqfwFOOT0Jcv34zCnKZ82/0cL66VFNPSuPEFqh9J6kYwpOc7En8AUiTqrwaIqyuJ36
 cdLXc8++pEaFwb+1KrHIJpsr8vrisSAhDjwYfESs3VENdcUH17A3qkxb8jhkNAU5ShnpcD
 UCjyNguvzclEHnCAzG0AhBcHYodt1/0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-Q89MxEM5PJyuayndj3GqKg-1; Fri, 26 Jun 2026 14:43:01 -0400
X-MC-Unique: Q89MxEM5PJyuayndj3GqKg-1
X-Mimecast-MFC-AGG-ID: Q89MxEM5PJyuayndj3GqKg_1782499380
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490b37e1f48so8087865e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782499380; x=1783104180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1m08xl5zj2iO0x6HrTgIsPIoRO2MXBBRZkFG3G9+fcQ=;
 b=ZnG+ipNtr2JGEx8tGKPkKgNXuXkdhjumOPKrSq8Fl581cFQGTZ19Vbkbv/H61K6c+v
 nXGsOzM/2wPXPNv073HWY+w0wVCie0y8mk2UOtLKwAUoskrvSGoU5qD4pcc3+nen4T4J
 cVtZs3z63j7WNRWul9P7oetHTlCyr713Zs3Gku4WuD6gAF9bVOwBBvIn9vYJ6fGuZXKO
 KbOmSHoLJ1ZX9NDIcYsjuFKgReRmEkoNe79pLIt43aWlAiOPqVtg22c8BsOGaMrElql+
 tbk70TBFN3oIZEf59ItYBG20gajnaBD6kBvKvNYm9Ke10LQFP1zkgCt28wy+Fk5SKPb+
 xD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782499380; x=1783104180;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1m08xl5zj2iO0x6HrTgIsPIoRO2MXBBRZkFG3G9+fcQ=;
 b=oD7OMzJb9bzXw3lhD1x/JSW/npO/fPuAwxzp6USpBmCu8fA773h0VNmJzfnV0ioQf/
 BvsTHSWAGqTdaCzPqUb1USBHL3/SjTBOe4qlDi8ZentV89jMPIYETcztXttNNQGHWyg+
 qe4S6Khb6zWdsfRHpWB0mMl6rJfeHNicIUF3/tEsV32rggK785m2Ke4/GOIjAPmksXEt
 C/X67cxjXR0nweKnYaWUSR9sgInye0XcqUethoThHbS6OwCynfmLHCX74MeK04ohVLsR
 7qSrb+oKzLMBIwKo4l1R8Mb7rDCztxbFEsRG96RcAw7M/CdqFp7N48H+nwv0FqeyGbUk
 5/3Q==
X-Gm-Message-State: AOJu0YzOj8lxPHXzgKrNHvFa93x/NZzcgbLjmihVYobJgu3RxUwcdhOy
 zGjfaIkLKZHfimqCiQYQHgBbOhBhpuB7ZztClwxGDVuhORdojPhCM0qVv7GgICFjd64IIacC2W0
 hvn1dTj9qAZMwTzygtZTjUFI8CYW1QXrRIfhE0GXFas1WHwn8artjCYqi
X-Gm-Gg: AfdE7cm/pu5SF7CHWFU5D52uZHb865JK+FVtmmdyc1RCoh/YtfvItiAVxL7vT6dpR5o
 Y/CFlNtxf8NwaLXbfZzzHCvxvwPVP1VjS58C8LUMFqnN+raXbfKtFPWyk50tkPuPsTCDuRzP8x0
 q43dEviF29Kg9hjWD5rM5VPE1/fqFETIjku0Ry6O0gTbeTt+8hgVl+4Doe7BGnk2ILKprzlI+vr
 xde7UmwI382727bBM94HCm4oqC/EiRPFyvfcw8xFLF6mfN7tRPYKZ+cFF59gVKehA23B49yNhRW
 j1Q5BqGXWbMqOgf+5FK1jZLAZPAZR0eCT3YGbZhhZFnbzCf4Roa4y/iAG1TyD/DsPFXl6Q8c/ct
 WKVupRdOUWre14C+7j+ZkBapni0iZVcytUH4HNuHzlkzu6twW5dZ+
X-Received: by 2002:a05:600c:6211:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-4926683b1f4mr117480445e9.8.1782499380145; 
 Fri, 26 Jun 2026 11:43:00 -0700 (PDT)
X-Received: by 2002:a05:600c:6211:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-4926683b1f4mr117480255e9.8.1782499379765; 
 Fri, 26 Jun 2026 11:42:59 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:a924:b4e0:1ee:f5c5?
 ([2a01:cb19:8426:ae00:a924:b4e0:1ee:f5c5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926c28c51asm41218585e9.2.2026.06.26.11.42.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 11:42:58 -0700 (PDT)
Message-ID: <73387efa-deeb-433d-85bc-08cc292624b8@redhat.com>
Date: Fri, 26 Jun 2026 20:42:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio-user: validate VERSION replies
To: zhaoguohan@kylinos.cn, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Cc: qemu-devel@nongnu.org
References: <20260603062138.4008583-1-zhaoguohan@kylinos.cn>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260603062138.4008583-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/3/26 08:21, zhaoguohan@kylinos.cn wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> The vfio-user protocol makes the VERSION payload optional, so a
> reply may legally stop after the major and minor fields.
> 
> vfio_user_validate_version() currently assumes a capabilities string is
> always present and NUL-terminated. When the server replies without
> version data, QEMU ends up reusing the request-side capabilities buffer
> and the terminating-NUL check underflows. Replies shorter than the fixed
> VERSION header are also accessed before they are validated.
> 
> Reject replies shorter than the fixed VERSION header and only parse
> capabilities when the reply actually carries version data.
> 
> Fixes: 36227628d824 (vfio-user: implement message send infrastructure)
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
>   hw/vfio-user/proxy.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index 0f7d8425d614..197aee07bf7a 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -1292,7 +1292,7 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp)
>   {
>       g_autofree VFIOUserVersion *msgp = NULL;
>       GString *caps;
> -    char *reply;
> +    const char *reply = "";
>       int size, caplen;
>   
>       caps = caps_json();
> @@ -1322,17 +1322,24 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp)
>           return false;
>       }
>   
> -    reply = msgp->capabilities;
> -    if (reply[msgp->hdr.size - sizeof(*msgp) - 1] != '\0') {
> -        error_setg(errp, "corrupt version reply");
> +    if (msgp->hdr.size < sizeof(*msgp)) {
> +        error_setg(errp, "short version reply");
>           return false;
>       }
>   
> -    if (!caps_check(proxy, msgp->minor, reply, errp)) {
> -        return false;
> +    if (msgp->hdr.size > sizeof(*msgp)) {
> +        reply = msgp->capabilities;
> +        if (reply[msgp->hdr.size - sizeof(*msgp) - 1] != '\0') {
> +            error_setg(errp, "corrupt version reply");
> +            return false;
> +        }
> +
> +        if (!caps_check(proxy, msgp->minor, reply, errp)) {
> +            return false;
> +        }
>       }
>   
> -    trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
> +    trace_vfio_user_version(msgp->major, msgp->minor, reply);
>       return true;
>   }
>   


Applied to

     https://github.com/legoater/qemu vfio-next

Thanks,

C.


