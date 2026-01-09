Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40667D1A62D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 14:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veDOu-0000Ti-9Q; Fri, 09 Jan 2026 09:23:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veDOm-0000St-Fl
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 09:23:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veDOi-0003hw-KY
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 09:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767968605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xkhy5h101VvsBL08rOdfFvdvRA/DTV0yf9Wmn3Oeu+o=;
 b=RV/vHJPWZ3b2MfW8UF8gntRXzkcwiAyramkUpjHMHOL4GgSItPh2L+vBKuDbipZzucJ4CX
 jY6dJxTx/I3/N3DXclT7G20OVf3wsPuGjW5FpswmdRnBmuLNHwX3qCFMT0glsny1pSf4q8
 Ejy+g9KJuwRDXpuels4SCYcQCLdg6uE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-zcYKVdTKPB29AkKowM9YiA-1; Fri, 09 Jan 2026 09:23:24 -0500
X-MC-Unique: zcYKVdTKPB29AkKowM9YiA-1
X-Mimecast-MFC-AGG-ID: zcYKVdTKPB29AkKowM9YiA_1767968603
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4779d8fd4ecso18710185e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 06:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767968603; x=1768573403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=xkhy5h101VvsBL08rOdfFvdvRA/DTV0yf9Wmn3Oeu+o=;
 b=NMpNUop9SBCliX1NabK6ICm5STy5Ox/5+X9F2WCxFE+cLm7efSr0COsQRMAt2Ec6af
 hBJ6v84yD7QqK8aUmVRpRH8gbjccZV/9+2jXc9XdF1/TXrcCWIKs9FOM4qLuUoBsrUzv
 xu9F2QM46oRlJT9enkff9ZukWN92Ub8K44GnvJZ/wHuGJYQC3Ug1xu8DL8cPXzl1VHzZ
 4vmxDM+wRpB6aFRqbk9WaOAB17uh+NHKir90qbsV9F6Y2Fx909yh5OiHMpKu5Ybl6dky
 sRxDGFLn02bQ5nzGi+xg8N+Hot3yXGbPj+UcwccLbOCfDEuDh2ehIq2TUr2PSyhcYvGt
 1lIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767968603; x=1768573403;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xkhy5h101VvsBL08rOdfFvdvRA/DTV0yf9Wmn3Oeu+o=;
 b=DSZcLcUS8OQ3GVuPA1zZukbm6ADaR3/tq+hl8+pG7dhgLo5j3IWFsUiz1B3Vy/EF9u
 KchUn4gP0gE8SYVguvPgbvUuuI9Hl4SPKsMj2WTq2mvno7N6xIFHiztbsZC3tQ6sKmel
 Sx8KeJatAI8B++tHv7PH5Z26PpldiG6oVvviOW+CO80kR2tfzY1rHa4va74nnhG1xRQT
 vdanI7oRx8muIzKFylrvNlFezuCr1tSPfTRnTJ9SEkYT173XDQcbVGbMrZGQEedCw059
 sizEmKlKTEy6wskYSDt9CgpkZTUUMZcHjRrAmxFKfkhOLcxeGIbxbDNVKs4lsOyoE6Th
 h9wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeQwjO5xg0b5EcFwUh/rp5vyExl6VF20Mn+nLkr3LjNFwwjszA2s3svOEkeHo8Y1FNLxldtcj8kSlx@nongnu.org
X-Gm-Message-State: AOJu0Yyqwv55Bz3bYe9gJfLh+RWLvt3M54m81aa0VRT2H1HNocuiWUBg
 14ZV/+SXNd3pQRRm0vRADMr5jlFTmGoaZ/E4ufcDC+YcPz/Lye3r2sm7cNEwAiwO3vTjxf3avwr
 oRWOa8cmzKAAlw7sRiNeu7nxyTCBSbtb8qztWWQZ+zoW4Qm38LZs/rGH/
X-Gm-Gg: AY/fxX4yatNNzBhGrHWZkjJlQfp/sX+r7tmNenaDQF+E2ERRdhUVKj2mwmaVSTG3wcD
 GlEPYCSyut+symPQ01OMvPJgrNywbezLlsFbSsInAev1L9c8s0R9pnModEe6Jwa3gzH+yIKdXpg
 MGL4PSAwvESfLahVWCW8wxBfgbgcyMNLD14S8HlwlAYKveznzAkPgZ4zwpFboFeYgcEW0E+1nKl
 3vUlKbVjataW4eBhqHaPLq96gT6cpO4CFK2YYHzxhrGGhG8isI96GOeoC9NHqqxkJc9zH/vsJ60
 kGACO7nqg0lV1ZFhxVRMEPoT2d/Ztwql/s8dIQ+GhFgLuetTl6Ydla8zd0rQ4A1h8aVzFoWlKh0
 y5cw/AI/iWqDwsdmtxba1UEhDLW9++RhCGmM6P2nlTYFsMnuKgVbV5crAJu+qLpZTV1HLUzpicn
 X9yw7VtKVs/lDqEA==
X-Received: by 2002:a05:600c:450a:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-47d8483cc37mr103166055e9.3.1767968603127; 
 Fri, 09 Jan 2026 06:23:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBLxKEX2GlTZIUIRFzl6jKALzbNfSl724vTXDMUinsGUqzPPK1MAtxCz5r6EjqLoGeP66Qng==
X-Received: by 2002:a05:600c:450a:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-47d8483cc37mr103165825e9.3.1767968602673; 
 Fri, 09 Jan 2026 06:23:22 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-47d8678cad8sm68392585e9.3.2026.01.09.06.23.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 06:23:22 -0800 (PST)
Message-ID: <73ac5b61-ebd1-4451-884f-0b78eaf0ff02@redhat.com>
Date: Fri, 9 Jan 2026 15:23:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/29] accel/tcg/translate-all.c: detect addr_type
 dynamically
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-16-pierrick.bouvier@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260109053158.2800705-16-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/9/26 06:31, Pierrick Bouvier wrote:
> With TARGET_ADDRESS_BITS mechanism, it's now possible to specify which
> variant every source file is written for. Compared to before, it means
> that addr_type will now vary per tb translation, where it was constant
> for a given target previously.
> 
> Instead of introducing a new parameter to translator_loop(), we simply
> add this information in TCGTBCPUState, which is returned by
> get_tb_cpu_state() during the translation, and passed down to
> tb_gen_code().
> 
> To avoid modifying all target with this new field, we simply define a
> default value that is equivalent to current state: use
> target_long_bits(). With this, we can progressively convert new
> architectures.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/accel/tcg/tb-cpu-state.h | 12 ++++++++++++
>   accel/tcg/translate-all.c        | 15 ++++++++++++++-
>   2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/include/accel/tcg/tb-cpu-state.h b/include/accel/tcg/tb-cpu-state.h
> index 8f912900ca6..b77c4dd5100 100644
> --- a/include/accel/tcg/tb-cpu-state.h
> +++ b/include/accel/tcg/tb-cpu-state.h
> @@ -8,11 +8,23 @@
>   
>   #include "exec/vaddr.h"
>   
> +/*
> + * Default value 0 means to refer to target_long_bits(). It allows to stay
> + * compatible with architectures that don't yet have varying definition of TCGv
> + * depending on execution mode.
> + */
> +typedef enum TCGvType {
> +    TCGV_TYPE_TARGET_LONG = 0,
> +    TCGV_TYPE_I32,
> +    TCGV_TYPE_I64,
> +} TCGvType;
> +
>   typedef struct TCGTBCPUState {
>       vaddr pc;
>       uint32_t flags;
>       uint32_t cflags;
>       uint64_t cs_base;
> +    TCGvType tcgv_type;
./
I know you're trying to avoid more treewide changes and focus on arm 
instead; but it would not be hard to make this TCGType already, or at 
least use TCGV_TYPE_TARGET_LONG only for the other four mixed-length 
frontends (i386, riscv, sparc, and x86_64).

Also, please call it addr_type since tcgv_type makes less sense in the 
long run.

Paolo

>   } TCGTBCPUState;
>   
>   #endif
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index fba4e9dc21c..bc5d9d74e21 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -257,6 +257,19 @@ static int setjmp_gen_code(CPUArchState *env, TranslationBlock *tb,
>       return tcg_gen_code(tcg_ctx, tb, pc);
>   }
>   
> +static TCGType tcgv_type_to_tcg_type(TCGvType t)
> +{
> +    switch (t) {
> +    case TCGV_TYPE_TARGET_LONG:
> +        return target_long_bits() == 64 ? TCG_TYPE_I64 : TCG_TYPE_I32;
> +    case TCGV_TYPE_I32:
> +        return TCG_TYPE_I32;
> +    case TCGV_TYPE_I64:
> +        return TCG_TYPE_I64;
> +    }
> +    g_assert_not_reached();
> +}
> +
>   /* Called with mmap_lock held for user mode emulation.  */
>   TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
>   {
> @@ -316,7 +329,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
>       }
>   
>       tcg_ctx->gen_tb = tb;
> -    tcg_ctx->addr_type = target_long_bits() == 32 ? TCG_TYPE_I32 : TCG_TYPE_I64;
> +    tcg_ctx->addr_type = tcgv_type_to_tcg_type(s.tcgv_type);
>       tcg_ctx->guest_mo = cpu->cc->tcg_ops->guest_default_memory_order;
>   
>    restart_translate:


