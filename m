Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E94D41D64
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTj8o-0008CU-Q2; Thu, 11 Dec 2025 11:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTj8k-0008Bz-L0
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:03:39 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTj8f-0004z6-HM
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:03:36 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3e7f68df436so158363fac.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765469012; x=1766073812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P3UlqjumhrOmQuIWLvhEFRJl1jg5uAdCaaqn+epTnow=;
 b=aT4QBTHrPHjsIVREmZpWFA6Z5PBVZiMu3pXeDoDHVQvVIKfTg3vu5frsRxI1jZEdLU
 iTl6Ny8m6IVGv9XMaKZdPjSeLropRoy0yAFY31mQ3RTUIZrIPEKbPnSd+kexOZ0QNuuU
 xfkpz0zoyzl+P8EDrhQGndAv0TzC57K13+LgKwn58euansw452NjTtfAgfdjpAsXirV5
 I48mFplkbnJY8u8XGfzGYmD7Xkg6WUsgpH8rBgpo9z4tsLhH2waHgnDdw3mPVKv8m0ZT
 nkYPFK+1wqmckg/GVtvkVvA9Xs55pHYIkhWmxlvDg6RlPGZvT3M6lZHBK+l408H2vtRj
 tJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765469012; x=1766073812;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P3UlqjumhrOmQuIWLvhEFRJl1jg5uAdCaaqn+epTnow=;
 b=UqHsWKkhDstitSrLQJgteZYT00PT04TYRrW4ZlDrjskt5UyxgeGXuJHJ+1TU2lVPBz
 5v11v23SeMGz7CIsPJwHJh0Nx6YAybm2ju4wNrEU9AKrvrbOPdTY6WXfHyJvtpc5Ex9t
 TUcMSwDtk60YW4/AGRcszK0odyAZndJIhMQADEyaG1N6I+6+6x94s27OZ0aibo9UqBJ+
 oF6oDFkm/G7IajdM9DheTofu39oyB6HJAIC5e91ZoRwbhwrsgYeq1iSTO4eK6xfN7a6P
 cN+mCra9p09egJMWHBz9lWlb0fJjjUiRTncYehclgFApNfAXBwXFIbvKaN/f0dYUXaeG
 x4KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKQLzeVTntI/yRywrcEU/Qc1cF07XvGIfLGrsfYMlBMWxyC0cJdtkP3WbGHDcgrmoxFUJTAhYh5Ihu@nongnu.org
X-Gm-Message-State: AOJu0Yz0x3TXPSGL9m/Z//1WIZspHK0sK7ya/XV71SksygtVOoGbdZTB
 OQChPen8n+ZbrKGWWhnuSOROkebUNhbwMUbwbiiJv0QnWZPkPHtaLuKhnMhM+dUbo4Y=
X-Gm-Gg: AY/fxX5x4SB/kSjLXSOWrA+hhg07oBtQB0UezQ64E8MMekdgJwGQnUhjrSzdoTGP3dY
 0lnZu1uBULWzmjnV9RalIDfPy9jygrIQ73KaXs6QqWLC6W7dMK1nmg07YsQ+biRkdpa5+lw9C5m
 sMQSaBLtlVTVcW7j71QC/Uwd4DJbWgj6fu/eEmGBo/WTx3H4eLjbd/CsUxKpQpiVTBe+HUEBM+c
 frZ46m2oFvlRwUsXBb9ZQFsyXJkLRGkfpA81JmLxCN+Pz6mnTW35DsLG4n7xOwdzbvtxtLkhrSb
 nRL0oYTsvnZw54yuzlmJYO1atizFrgzUeayPgRl86tRh9qT6dPR6EtnncwZHiICdjVOEmDMTlLu
 YUsqGYFYEBC96Yt32939DnJXx0/5cRICX6dMsADXC3fEzqbnsrWEIhFfeRlq6WLtt/tfkrcOZCB
 oJ6RpKJjO74uwnivdWd122iY44ZJcWU1ZirLsOvKlgsNxt5wtoT3F7o/a6R/LzZZv8
X-Google-Smtp-Source: AGHT+IEvphOqP4YnL0+sP5OzA1o3DgpJ0SAmQfNkF8v1fX6OiHyfwswUoHx83vQhfGBgvHEYYJg1yQ==
X-Received: by 2002:a05:6870:4589:b0:3dc:5c9f:695f with SMTP id
 586e51a60fabf-3f5e005cc1emr1294912fac.4.1765469011022; 
 Thu, 11 Dec 2025 08:03:31 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5de4d36f4sm1375577fac.15.2025.12.11.08.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 08:03:30 -0800 (PST)
Message-ID: <a6629c2f-9faf-4fa9-9191-e52fdadf4452@linaro.org>
Date: Thu, 11 Dec 2025 10:03:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] target/i386/tcg: do not compute all flags for SAHF
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-6-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251210131653.852163-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/10/25 07:16, Paolo Bonzini wrote:
> Only OF is needed, the others are overwritten.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/emit.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index 22e53f5b000..131aefce53c 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -3778,7 +3778,7 @@ static void gen_SAHF(DisasContext *s, X86DecodedInsn *decode)
>           return gen_illegal_opcode(s);
>       }
>       tcg_gen_shri_tl(s->T0, cpu_regs[R_EAX], 8);
> -    gen_compute_eflags(s);
> +    gen_neg_setcc(s, JCC_O << 1, cpu_cc_src);
>       tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, CC_O);
>       tcg_gen_andi_tl(s->T0, s->T0, CC_S | CC_Z | CC_A | CC_P | CC_C);
>       tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, s->T0);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

