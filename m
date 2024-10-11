Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A44CCFD2FD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 09:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szBe0-0002Gr-Rj; Fri, 11 Oct 2024 05:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szBdv-0002Fo-4t
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 05:09:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szBdt-0001TL-2U
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 05:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728637740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mAZXKd3ptVRM3rVAai4OTgdpOM9cZHdmARW8utAHs1g=;
 b=ZHUNFko4opmPrSntMzZzxINslZC/dDI+EF5IZe56xu7tztLC5KiVs0iXtjo8TrxiJg4dwR
 5ONl6T0Bg328HvpuVam+UgeMYP8TTAe03fiXnHRGV9DaPgMr3fODMyzeBR37EzgmGrOiUi
 Oj+YO6RMz9kjfQW6eoReQI9fL2ehxuU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-4HwcvkrNNjuSA0FDLSQkYg-1; Fri, 11 Oct 2024 05:08:52 -0400
X-MC-Unique: 4HwcvkrNNjuSA0FDLSQkYg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a9942ef051eso71590766b.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 02:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728637731; x=1729242531;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mAZXKd3ptVRM3rVAai4OTgdpOM9cZHdmARW8utAHs1g=;
 b=qUjPaYcNooe2YklkGcQmUAz9Br3mKp/kswKtbFOh9GXkNJFHIp+gdQgi2MEWOwbu3B
 NucVeOkPo5eUhGkAwdkgt8+qp08r6NLBr0j85z0ttEIwytsLJRG+YhLcdiTVIj/qUL03
 dtHuZzortvt3mZTxXJSUtfnL93dtF6hs1wVMQ543UiMtRa2BQd1m4E9FKXdf4l5itQmj
 HW51r00FZ1KGI3dC8gsRTCnw8WTazqfxAnrLkh3uhr6XTv/MrjGf7ZBE4mXP/q/vQ5au
 9MX+UUOmB2S59hAzgc1rvgK4GXW3WC7djUHSpGKuFLovbw0wxKNxCzMPrhrtFZfbfRJQ
 T4Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQUplLqX7jRqwXDBCBtkdWkxWaQFetVrazLsznekjKCuEUADQFlaO9p1+p8u8iafgR++A0Kfp2sNJc@nongnu.org
X-Gm-Message-State: AOJu0YxmsRBOZgBlOBa/It0zQRS3rGk1OECHS+sMcXbCxrOKhVJepccV
 a6aVYWZJlSguXREEsxvV1toTVj060VqGXvILZWNrbotXdcPxADWdmXOMoGjGvWVILI1k3UkF9ge
 D0ibdwCVAQmxQfs5AWqi72rzqO1sYd+oloUHYF61Nr0lBYA4xpYrr
X-Received: by 2002:a05:6402:234c:b0:5c8:967d:cf47 with SMTP id
 4fb4d7f45d1cf-5c948ccf321mr1690276a12.19.1728637731601; 
 Fri, 11 Oct 2024 02:08:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHegWwMgDt5sgEoVygc4k3pN5rizfNsf46uL4QVEGEd4XkiLipUOG1L1lQqIYTB12BhP9cqUg==
X-Received: by 2002:a05:6402:234c:b0:5c8:967d:cf47 with SMTP id
 4fb4d7f45d1cf-5c948ccf321mr1690254a12.19.1728637731189; 
 Fri, 11 Oct 2024 02:08:51 -0700 (PDT)
Received: from [192.168.10.81] ([151.81.124.37])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5c9372940e3sm1724178a12.81.2024.10.11.02.08.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 02:08:50 -0700 (PDT)
Message-ID: <2a543dd0-11e7-4357-97d9-31979a1a87ff@redhat.com>
Date: Fri, 11 Oct 2024 11:08:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_attr: Do not define for glibc >= 2.41
To: Khem Raj <raj.khem@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20241011054806.1014276-1-raj.khem@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241011054806.1014276-1-raj.khem@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/11/24 07:48, Khem Raj wrote:
> glibc 2.41+ has added [1] definitions for sched_setattr and sched_getattr functions
> and struct sched_attr. Therefore, it needs to be checked for here as well before
> defining sched_attr
> 
> Fixes builds with glibc/trunk
> 
> [1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=21571ca0d70302909cf72707b2a7736cf12190a0;hp=298bc488fdc047da37482f4003023cb9adef78f8
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> Cc: Laurent Vivier <laurent@vivier.eu> (m

Hi, I think it would be better to test in meson.build (with 
cc.has_type), as is already done in several other places in 
linux-user/syscall.c.

Thanks,

Paolo

> ---
>   linux-user/syscall.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1354e75694..9e6eebbf1a 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -359,7 +359,13 @@ _syscall3(int, sys_sched_getaffinity, pid_t, pid, unsigned int, len,
>   #define __NR_sys_sched_setaffinity __NR_sched_setaffinity
>   _syscall3(int, sys_sched_setaffinity, pid_t, pid, unsigned int, len,
>             unsigned long *, user_mask_ptr);
> -/* sched_attr is not defined in glibc */
> +/* sched_attr is not defined in glibc < 2.41 */
> +#include <stdio.h>
> +
> +#if defined(__GLIBC__) && defined(__GLIBC_MINOR__)
> +# if (__GLIBC__ > 2) || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 41)
> +    /* do nothing */
> +# else
>   struct sched_attr {
>       uint32_t size;
>       uint32_t sched_policy;
> @@ -372,6 +378,8 @@ struct sched_attr {
>       uint32_t sched_util_min;
>       uint32_t sched_util_max;
>   };
> +# endif
> +#endif
>   #define __NR_sys_sched_getattr __NR_sched_getattr
>   _syscall4(int, sys_sched_getattr, pid_t, pid, struct sched_attr *, attr,
>             unsigned int, size, unsigned int, flags);
> 
> 


