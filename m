Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B778DC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 21:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tspiC-0006q9-CC; Thu, 13 Mar 2025 17:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsphz-0006jC-Jg
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 17:03:16 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsphx-0006gV-UL
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 17:03:15 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22349bb8605so32887135ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 14:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741899792; x=1742504592; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S2tvZrQSwacLQFNvYdfNdQpwqsAN8yEE8D+ovFgubh0=;
 b=HI+Uzb0huOwA/F/NLwfPHrctuz3WAFIpQCec0eaPrspe8L2RtiPA+Wu6cE4MIC/KGk
 eeOTAtVixxFk8HKufNmFPwD29Ysx1ETJOoamOF9HpWpTxc9y5SewupJwEqC/X0M2DhAL
 tBQEVM8RfBZbAYDuUsCZeYrQ8bylI5+/9FuCEKa2uVwTWcRwEXzlBrHTMdQGEpn51HY5
 24gfS6TngcRaVTShp+aPre+0Y9pEqnwMKJGj4GZAkIlnM/S89v8kZoxdnUYETrUV5mqE
 B4D6H63Gd6QDjQQPSNfSEI4y0MdsLTP1k/y6yDSw9IY9D7vqOcyCVH7qqf0cyFlKtqI+
 vmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741899792; x=1742504592;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S2tvZrQSwacLQFNvYdfNdQpwqsAN8yEE8D+ovFgubh0=;
 b=wTpCrglEkSPMZH1NqhfXyy9nnzyDnocTqvttHxGvJc9rJ2tiOIXznZHgM591HONkUs
 3EsSvZYpJWsPHEt+izV8syL4b2AX6Z+LQ2Kr3WzC1MDG6bfqVy5dcBXHYDxTtclgr6Fb
 TLJ7GCP2mRIfFbab5j2WaSpHIzu2zFr5Lu8KkGv/dLJp0XME/ULdv9pBnGLM1nRB4bBj
 o4osth71383tc0ioFBYn3n5URS9izmMvL21LYYX0br2tGxxqzSRaklb+acwNd4v9w/Pr
 fqpz6EJro/mQ77cAWxwOWfgEhAF5Lv/Wk3FuFrBD6SGrKEipBPNR6igrDh/nSsau8qXc
 QIfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX46s77zKg6Rm0BKHyshNY6lBIi8lNUXHpV7XqrguZIhOwpvwDimJL9fAxhP0+iZxt1XOaJc7jKHpgj@nongnu.org
X-Gm-Message-State: AOJu0YxkQCEVG4mYKuzJmK50cSqIbQWpb8H7uA9+QEwQ4fP/6oGzg7cu
 SBK/6tNOwNdmaJSz5NiReXBLL/rfT20TCBVsyNv9Ircl+lZxutyrAMz2aG7jZwc=
X-Gm-Gg: ASbGnctSTCAhCf7qZ5ruh+J96CYyJ1J7N31YXADE1zSHkevp/uEY1KcGvu0S7OTKfkB
 P7jPGRGJUdF2nyM6gGAIPtzx7uKHaxjWdSxgaqNhlWgTfGsz7cikGWzGznJWZ9Yu8P8NtnN3HZi
 mInnKUUD1CU8dcsRn8sivmQH7RKvq02JjcSboTfhGA7aNKmwgR6bxwEoqqKheuQ/mDBNmZpq/Zd
 DjfxZ7bNkd337NbaJIx9rF0gWx+l5rdHTrf4JMN+97aEWb3mb23SFKyFy8m3ixb5W+iRwgb4A27
 Zh3UISpX4oOufokxSngW6H73vd3mymmNEJy6SPKtM2NDDXMDnEA4VnIXCA==
X-Google-Smtp-Source: AGHT+IEpduT7JrDYbHKZEM9L7kzPG5yE0RVBmCb0DMjfXWLBXcbnKyJris8UJGM+rkVBOWnGgcNQ2w==
X-Received: by 2002:a05:6a20:7f8f:b0:1f5:591b:4f7a with SMTP id
 adf61e73a8af0-1f5c13116e0mr183215637.38.1741899792374; 
 Thu, 13 Mar 2025 14:03:12 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ca49fsm1482595a12.10.2025.03.13.14.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 14:03:11 -0700 (PDT)
Message-ID: <4b308ceb-14c3-4cd8-832b-733a94d4090d@linaro.org>
Date: Thu, 13 Mar 2025 14:03:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/37] include/qemu: Remove ifndef CONFIG_USER_ONLY from
 accel.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-36-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/12/25 20:45, Richard Henderson wrote:
> While setup_post and has_memory will not be used for
> CONFIG_USER_ONLY, let the struct have constant layout.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/accel.h | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/include/qemu/accel.h b/include/qemu/accel.h
> index 972a849a2b..fbd3d897fe 100644
> --- a/include/qemu/accel.h
> +++ b/include/qemu/accel.h
> @@ -38,13 +38,13 @@ typedef struct AccelClass {
>   
>       const char *name;
>       int (*init_machine)(MachineState *ms);
> -#ifndef CONFIG_USER_ONLY
> +    bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
> +    void (*cpu_common_unrealize)(CPUState *cpu);
> +
> +    /* system related hooks */
>       void (*setup_post)(MachineState *ms, AccelState *accel);
>       bool (*has_memory)(MachineState *ms, AddressSpace *as,
>                          hwaddr start_addr, hwaddr size);
> -#endif
> -    bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
> -    void (*cpu_common_unrealize)(CPUState *cpu);
>   
>       /* gdbstub related hooks */
>       int (*gdbstub_supported_sstep_flags)(void);
> @@ -78,12 +78,10 @@ const char *current_accel_name(void);
>   
>   void accel_init_interfaces(AccelClass *ac);
>   
> -#ifndef CONFIG_USER_ONLY
>   int accel_init_machine(AccelState *accel, MachineState *ms);
>   
>   /* Called just before os_setup_post (ie just before drop OS privs) */
>   void accel_setup_post(MachineState *ms);
> -#endif /* !CONFIG_USER_ONLY */
>   
>   /**
>    * accel_cpu_instance_init:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


