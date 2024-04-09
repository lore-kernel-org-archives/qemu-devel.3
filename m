Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB76C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 07:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru6A2-0006FX-Lb; Tue, 09 Apr 2024 03:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ru6A1-0006FH-7k
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ru69z-0003jH-MX
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712648690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ohZl7YmHRbVY2eiQR/LjOgqwX/ynb2g2wK4oTqeu2S8=;
 b=VTe92gykySS/DwmPDR3RMHZa1VOmROMBmtri1PHlDuzQvNWpfiQIQ04fKEz8aK7dhhtSE7
 f0eGtDEl4dliiIuJV0LnhPvrW3WFKF8BtUFSLPJal/9zxhZhcBEGcuxneL8Su/PnPACQ7w
 oWGDAYPJt0zfAuoIz4XBHWIqdB+/4JA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-8PJBXwQkPfmvYhs0KfKR6A-1; Tue, 09 Apr 2024 03:44:48 -0400
X-MC-Unique: 8PJBXwQkPfmvYhs0KfKR6A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-416664de900so14144775e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 00:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712648687; x=1713253487;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ohZl7YmHRbVY2eiQR/LjOgqwX/ynb2g2wK4oTqeu2S8=;
 b=Cz5yXFfNVCTlTXm2uL6QRSPGhr3E/VdyCfwDTi+iA7ftORXdz6o0Ft++EuN+xMFPPz
 NzRw4rsKqVJCAUCac1L3wjTzGkP5Rv9UOqic7L0QxgVPHyWSNlDyemasLUKM0M8GPGXs
 fhzizo0fmSTKm19X3Bwhz46/oKZI+jp5B8w7kIh8ZGpqqlfyDQVqlz0H8m4Y5rHoQNF8
 4Jyd7HYqzDMtC6b98kEg5QLw088yWBL3IU2gHMYYkXKv08qPoGK0XrX1ulP0vnioUvE0
 Xg3yXuySxVu+vrbpyjnmtxgYwy0yvswBIyVOKX6KokivyYLHFw48GcBQkU43UNZPyJjA
 skSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpKmB6cDZITa83G3bKrXWvnz9As+In8UbLpxdi9BRBtGCPzYHEaCgFF1TzywfS7r7aegZul/j9OJhLA6guFtq8kL0Nkmc=
X-Gm-Message-State: AOJu0YyZ98hLWiee6rbLZhQExTENqh1d4jRFt0w9H2baWubihuJ4nMYM
 qnEaJXYWIGPlsac1njXB7WmlnyO6vN1OIbRuWrEtoZ2VtalAIaBp2yIpImFJdc/Ko0gPgzCzoir
 ygcaih0Tb/GniKm+x5YkQrs/VCP7nXTJ2dJU1Bj8/OnDtz61BHgFGbtqFYUAv
X-Received: by 2002:a05:600c:3584:b0:416:4641:5947 with SMTP id
 p4-20020a05600c358400b0041646415947mr7043915wmq.34.1712648687010; 
 Tue, 09 Apr 2024 00:44:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFntmoize6NaCIevnJMTqvhsOB4Y0euM/Lm/Q4ANTNa9Y2c4lY+Z43UuvY62m1B9Lajt1lONg==
X-Received: by 2002:a05:600c:3584:b0:416:4641:5947 with SMTP id
 p4-20020a05600c358400b0041646415947mr7043896wmq.34.1712648686629; 
 Tue, 09 Apr 2024 00:44:46 -0700 (PDT)
Received: from [192.168.10.4] ([151.95.152.232])
 by smtp.googlemail.com with ESMTPSA id
 i3-20020adffc03000000b00343ac425497sm10765976wrr.46.2024.04.09.00.44.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 00:44:46 -0700 (PDT)
Message-ID: <ecc1ce60-c31f-423b-8d5e-ba5138323212@redhat.com>
Date: Tue, 9 Apr 2024 09:44:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/28] target/i386: Honor xfeatures in xrstor_sigcontext
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
 <20240409050302.1523277-24-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240409050302.1523277-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/9/24 07:02, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/i386/signal.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
> index d015fe520a..fd09c973d4 100644
> --- a/linux-user/i386/signal.c
> +++ b/linux-user/i386/signal.c
> @@ -612,6 +612,7 @@ static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
>       struct target_fpx_sw_bytes *sw = (void *)&fxstate->sw_reserved;
>       uint32_t magic1, magic2;
>       uint32_t extended_size, xstate_size, min_size, max_size;
> +    uint64_t xfeatures;
>   
>       switch (fpkind) {
>       case FPSTATE_XSAVE:
> @@ -628,10 +629,25 @@ static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
>               xstate_size > extended_size) {
>               break;
>           }
> +
> +        /*
> +         * Restore the features indicated in the frame, masked by
> +         * those currently enabled.  Re-check the frame size.
> +         * ??? It is not clear where the kernel does this, but it
> +         * is not in check_xstate_in_sigframe, and so (probably)
> +         * does not fall back to fxrstor.
> +         */

I think you're referring to this in __fpu_restore_sig?

         if (use_xsave()) {
                 /*
                  * Remove all UABI feature bits not set in user_xfeatures
                  * from the memory xstate header which makes the full
                  * restore below bring them into init state. This works for
                  * fx_only mode as well because that has only FP and SSE
                  * set in user_xfeatures.
                  *
                  * Preserve supervisor states!
                  */
                 u64 mask = user_xfeatures | xfeatures_mask_supervisor();

                 fpregs->xsave.header.xfeatures &= mask;
                 success = !os_xrstor_safe(fpu->fpstate,
                                           fpu_kernel_cfg.max_features);

It is not masking against the user process's xcr0, but qemu-user's xcr0
is effectively user_xfeatures (it's computed in x86_cpu_reset_hold() and
will never change afterwards since XSETBV is privileged).

Paolo

> +        xfeatures = tswap64(sw->xfeatures) & env->xcr0;
> +        min_size = xsave_area_size(xfeatures, false);
> +        if (xstate_size < min_size) {
> +            return false;
> +        }
> +
>           if (!access_ok(env_cpu(env), VERIFY_READ, fxstate_addr,
>                          xstate_size + TARGET_FP_XSTATE_MAGIC2_SIZE)) {
>               return false;
>           }
> +
>           /*
>            * Check for the presence of second magic word at the end of memory
>            * layout. This detects the case where the user just copied the legacy
> @@ -644,7 +660,8 @@ static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
>           if (magic2 != FP_XSTATE_MAGIC2) {
>               break;
>           }
> -        cpu_x86_xrstor(env, fxstate_addr, -1);
> +
> +        cpu_x86_xrstor(env, fxstate_addr, xfeatures);
>           return true;
>   
>       default:


