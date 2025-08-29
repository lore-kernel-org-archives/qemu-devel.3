Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C78ACA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNg6-0007WN-HU; Sat, 30 Aug 2025 11:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6iN-0003Ec-4B
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:32:55 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6iK-00078r-Rl
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:32:54 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-771ed4a8124so2631785b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 14:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756503171; x=1757107971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/vsclMFJpDnpQXSauU7D0Wh9NmL4TivRm0SvilaDOd4=;
 b=h1MH2KPHE5HcrIpEpDNv/GT8fZ+ZFR7zzosfr++UojnU6aUtoGg97Ve0XFk10f2ZCF
 gdtx+6Wcb/MLzAn3DqzD2USPu8mhV1bFI9ozdviBj6zX63WS7gYGKLfS1oVy6mjFMfbo
 uVFqISxESnA+LlGHlrfrPae8DwIvw7HjlRgipKFQmXgEpnLsTgf6kS1WjMVBOjbqiudy
 wlqcXOg+1CEIMhXIVdFa36qdt2y2mVV5K/KhW5p7HnCC0iYGFwkjyIENJzVXVE7NjTyR
 8bq4X0XKJHb7bZxmYXsAVA0Od2JTwaNG5Np6EFExezOsLS8qE6K/mgdVHbwX5R3jBvJz
 CctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756503171; x=1757107971;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/vsclMFJpDnpQXSauU7D0Wh9NmL4TivRm0SvilaDOd4=;
 b=ecnHnSIjoENtk+kx0UFw0iddvoHyRPMd9BAeDy/bT2M/dpJi37hYPl23Fu/esPiDcW
 nbzXZou7y+ikbBdih9kkXHLnTdig4xJsnsSm2Cgmttbm/aLCSJdgYgULcDxFmLhCN4HL
 GnV0HGYlJZc8qZ4l/gZJsjqNC5+/EPxiYOK3d9Vmq31k6qencK1jCPoaw1za1lPu2TZo
 huipRFZWP0VuX1P4lzxdkT1ygvM0wQV7LgmkvKd6xCZJ9thoU3f9XPh+vAERdmNuqxUs
 keXU8pPqz+8/Im3wvMp+q6gWpxqz1BW6aNOmLl7zG3lZJ37wLhrop1ADP9PwNxZbux1O
 dNbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVCOkUEFLgeC1Yy4BZ7jhRzQhngWpfBSZtWpEr+6puNqcqPCtFx7Pdp6J7U+t1ilEIVNl9lkmsR0Un@nongnu.org
X-Gm-Message-State: AOJu0YxsEmklrC5DIhMTR5qk9pKLSZtuARzYlOlQYznxZk7BTaq9pHgb
 a+fYpf7jtQ4ZmRj0ZnPaXLT+WVRfu9ND8Ev1LFlVETfkz3Vtkb3xhWikFd9MrUSCOeE=
X-Gm-Gg: ASbGnctaHXPSpH8tZlIMeJl4654V8jtJMQQ+Ec8itymHt8ynY23YhAl6wG3hgWm1M63
 oDX71hDBwKIgAGMPAw2DSMe/dG1YmIql3w598c0lt7UEvyCcDwEwBstrPf1Y/MG+uXoRQTJN/Z0
 tlYsl8WVxPhPhc8wc/arsqiAo+6gjWF2EkJkBiyri5Ykl0sVv9bpV0I6g2VOCvGt4hRn0q5M2Ru
 GjjQAftyn2gTOe7Pzlf43OpnVaL40XpKztS9kdWvI1N5luRlq4mag9iHsq1K4owOakoIFVzGsSt
 NG1UcXJF527LOLRtcLpxiKaD9zHc/cql28GClbHhn1gjWSF2Q+OPfX/0msOr4y0hp90gVHsB7hd
 c4cNFqJ1As3mGhccpLSigdijD+6wweomo+OEnfee0iey5rHnXkT2rgC0ZJV4PuW1GDLcf0Fjg6P
 lmT1rrbL4=
X-Google-Smtp-Source: AGHT+IGjQgw6sRO31JNlOkhN9akVvhem7b6jf6o50EVhrwA2n9pjrKYRQLUNFndpyy2vL7GBSROVpg==
X-Received: by 2002:a05:6a20:3d88:b0:243:cff1:3c9a with SMTP id
 adf61e73a8af0-243d6e06218mr160530637.23.1756503171413; 
 Fri, 29 Aug 2025 14:32:51 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-179.dyn.ip.vocus.au.
 [122.150.204.179]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd366f95asm3042215a12.51.2025.08.29.14.32.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 14:32:51 -0700 (PDT)
Message-ID: <be7eb59c-f1d0-4759-b6ff-de8542950a44@linaro.org>
Date: Sat, 30 Aug 2025 07:32:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] target/i386: limit a20 to system emulation
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829152909.1589668-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829152909.1589668-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 8/30/25 01:28, Paolo Bonzini wrote:
> It is not used by user-mode emulation and is the only caller of
> cpu_interrupt() in qemu-i386 and qemu-x86_64.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/helper.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index e0aaed3c4c4..651041ccfa6 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -110,6 +110,7 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env)
>   /* x86 mmu */
>   /* XXX: add PGE support */
>   
> +#ifndef CONFIG_USER_ONLY
>   void x86_cpu_set_a20(X86CPU *cpu, int a20_state)
>   {
>       CPUX86State *env = &cpu->env;
> @@ -129,6 +130,7 @@ void x86_cpu_set_a20(X86CPU *cpu, int a20_state)
>           env->a20_mask = ~(1 << 20) | (a20_state << 20);
>       }
>   }
> +#endif
>   
>   void cpu_x86_update_cr0(CPUX86State *env, uint32_t new_cr0)
>   {

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

