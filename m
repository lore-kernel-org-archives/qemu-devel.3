Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E0ACF6ABC
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 09:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdmhX-0006ox-44; Thu, 08 Jan 2026 04:53:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdmhU-0006og-Lx
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:53:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdmhS-0003OX-GY
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767865981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6iAEi6+b7bJDK+thsNNc3DxtT0WAWpgLi7SoNplnUB0=;
 b=ZFjyGzoED6O0K67U0oKhRLmS2M4c1X8SQwR5o1NbFiO2U1prdW67lP+2OADAWneYtwlC0s
 SDm9TqPjQNANoHS92AzXwlV4hNzyKiMamDw6os2xT2O+jfRE5iiX1xdjLXqHuwKjG4ZUWG
 PU8Smwcq1nowQh6FC1foewfyhb/gbUI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-673UMr3SMTyivWte2l9lLA-1; Thu, 08 Jan 2026 04:52:59 -0500
X-MC-Unique: 673UMr3SMTyivWte2l9lLA-1
X-Mimecast-MFC-AGG-ID: 673UMr3SMTyivWte2l9lLA_1767865978
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4325b81081aso2151666f8f.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 01:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767865978; x=1768470778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6iAEi6+b7bJDK+thsNNc3DxtT0WAWpgLi7SoNplnUB0=;
 b=YMxurSkfzg8tfv8kytHDj33i0IxoMp1SX0yWc9OjZJyJiQ4xYAtlBhHXK/71uy7Lc+
 MVNxt3AxP0pcBsmyksxJ/5a0El/TbRUREulRF5ssJ8m79A8OraUB+/303k6G2ipwVmC2
 EOiBDLv3TXVCXViI/lEWg3jph5RbPmtIQ5ZBFECQTPxm2wcD7R2b8g0oMzict9Wxah3t
 lyrPyVWB2WmUxWQQlSvc9+msBPtcJaC+soQijJp922ZGjCLVEnQifRhvkBaDi1onkHRz
 U3lYTj1SqOWULQxqTVXvyskKQIPLRYconCqGRIUlNxmSdtGAmSxClJmj4VRqXplbIC8H
 3ULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767865978; x=1768470778;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6iAEi6+b7bJDK+thsNNc3DxtT0WAWpgLi7SoNplnUB0=;
 b=TTZV/Nvjkgq2I8e54JA03lCTXvYAsyCo3S312nccGXm+b0JecFGKUoGWO0kaut/MRe
 d28EWBBto5v+PRAq0ep0lq2OIKZzm1A+VPpGIreyr1PboYiy6iSDv1UV12SfavJWyTQh
 29z/hFWdnpbrmd/JI8K+W/V/7Inybbevv9fd/LEe+4RJVHnOevYnbdThrXgpwpkS7L0f
 MyGmu4I6PoF0MkZQ+S0YEuj90bHXoN5q6zpPR4ASLKTg7l4ErhMMwChiamjfbICkDT55
 dyeRM8i5uh86R99m2axdnoE+KIHVGCMZEdDyRqefCeCTxyp7GNtGgALcDm1nSRz8cbnX
 R5qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGF8AYNWNoKKZBSGe/CTycYGH4u6NshOTqn2i98o6sny1SVPs/jp3jgOkp4wdtPpdyZjh48XFeUO9m@nongnu.org
X-Gm-Message-State: AOJu0Yy2qzDIR5nizYPCM2NaQaX1Qpj+I8UWEcmei/ZT+ax6gW/O7IDX
 zM1KNpZwYtM66teKwgK0LK7KnziVHz/yLbIGFsrjeglucNcoF3avxTiPACbWm6K//V6fi4JgId8
 lH9yWW0FF4Tgm+cSDXyqSrxiUm4QGerPMwzja6nEu+JXlYfHLiy59Zko+g4d0Bze3
X-Gm-Gg: AY/fxX7jRT87N3UQT88I4NiGU4AmxbE7t7+8bQJD4aHnaz2o+/mLvuF+oc3kIeCZ+iP
 6fFVcYCWoxQeQgLM1OxRMYVIZp/4gD7Ker+vKQuQ1KHkJKGge1rOUKLYQZAEG+/q9g1+1VWq1FV
 E5hNrJJRZDEcWow6GyLqx5AiTW1fao0Z/QK/+KiXgoxxQbnjgL0YEQXna+Y7iZ3UazTC3akrgsQ
 HwM4AzN3tWcXvnKWyM5+0mk/nZVwnQ9QFwdu2l5hgOZZCanVJ19fp54ogJpU74foG1EN60ThPbN
 2PLn/IjXSQJ8KypjbJIsGwOpr7ljZzYrTnoVfZe5HxrqpYFcORWMWH05DTEID+7FWEQ4xWarlXX
 /RPBktAA=
X-Received: by 2002:adf:fe8f:0:b0:430:f97a:6f43 with SMTP id
 ffacd0b85a97d-432c379f3c9mr6318953f8f.53.1767865978494; 
 Thu, 08 Jan 2026 01:52:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvIZIWwLCFjsuRJ05k1OpRBC/ThbAqNRVPm+11RchNqI9DYXOijh75+X0eGsVsU4nrOsMXlA==
X-Received: by 2002:adf:fe8f:0:b0:430:f97a:6f43 with SMTP id
 ffacd0b85a97d-432c379f3c9mr6318928f8f.53.1767865978110; 
 Thu, 08 Jan 2026 01:52:58 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0860f5sm15158847f8f.0.2026.01.08.01.52.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 01:52:57 -0800 (PST)
Message-ID: <27dc6f18-c4db-4f34-97eb-78987bc70edc@redhat.com>
Date: Thu, 8 Jan 2026 10:52:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/50] host/include/x86_64/bufferiszero: Remove no SSE2
 fallback
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-8-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260108053018.626690-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 08/01/2026 06.29, Richard Henderson wrote:
> Since x86_64 always has SSE2, we can remove the fallback
> that was present for i686.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/x86_64/host/bufferiszero.c.inc | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/host/include/x86_64/host/bufferiszero.c.inc b/host/include/x86_64/host/bufferiszero.c.inc
> index 74ae98580f..7e9d896a8d 100644
> --- a/host/include/x86_64/host/bufferiszero.c.inc
> +++ b/host/include/x86_64/host/bufferiszero.c.inc
> @@ -3,7 +3,6 @@
>    * buffer_is_zero acceleration, x86 version.
>    */
>   
> -#if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
>   #include <immintrin.h>
>   
>   /* Helper for preventing the compiler from reassociating
> @@ -119,7 +118,3 @@ static unsigned best_accel(void)
>   #endif
>       return info & CPUINFO_SSE2 ? 1 : 0;
>   }
> -
> -#else
> -# include "host/include/generic/host/bufferiszero.c.inc"
> -#endif

Reviewed-by: Thomas Huth <thuth@redhat.com>


