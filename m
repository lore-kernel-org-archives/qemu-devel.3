Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B33FC36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 11:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u11iv-0004cz-LV; Sat, 05 Apr 2025 07:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u11it-0004bM-MO
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 07:30:03 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u11io-0008JS-FJ
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 07:30:02 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-301918a4e1bso2033926a91.1
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 04:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743852596; x=1744457396; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uf/OongiiAPHkiNoLjrwsQXxGFPchg8S2XavhsGNyGA=;
 b=TBlvhJOxscHxRGi7tBSXnxmZKia/pH2DMzQycBqIRK+iqDWT6SQ5TTFgqtxw78jGV4
 M0fZ9K1BdST4WrdMnnV8ekr3VV95wpl12ROBj/AY2kJUITwi+fuBSYqAUBTvTFvhVJqQ
 WO6JGWG/VN5wOkCobxggb5QB66wlmjqZF5mDwjGR5YTjCJ0LkTyD7/3e3lmhkBs1keWa
 oobtvSmGBzBQX9irXNE5ciq5wsYyvR6GBr/r6yw9fG4z34ORQ8CLd9A7EypvMiQseBAU
 YABGlqLUfmLwEJOY7OVYH11KcgB5qwHU4ywcMb8beZisBw8Yp+bQxJHQIK3OM0OGVEus
 vrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743852596; x=1744457396;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uf/OongiiAPHkiNoLjrwsQXxGFPchg8S2XavhsGNyGA=;
 b=W3GQi2h3BxSZm8mOek+jIkEw1u46rOclJchWnmSAuTDU6B/Q9aNkfggp5swXvhAM38
 LGmbQOfRl88zLqL8aA4QpeUE1JNAruhJ7VIhnSNJLYR8KVrl9G/+1ql9BDL/acmKCO9I
 OUnqFIF3Djkna12MRHOv2xpML6QFdPgr8iagYKYUWDp5jlUUnY5X1PPtOjySfX7hlwI0
 hel89srnlIeb7liE/kxN4ApUv+r5A5eu9joKnsyU8sVPI4ywaMbS+Iebuq3C+kxraVl6
 A4C9OA3xrHxtlM46QuZtyHIzPeDP+vAgcgT8KRqK33sE/O7t3LuL1gdw6+ieytWJg7o5
 4lcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4YDMNcWIC8whNJfoYdOp42ZX6nqCP4GFeu+0nsBiOedabY3sbn8XUA/1r6uzvYbgYDf7QCLYfQ2UZ@nongnu.org
X-Gm-Message-State: AOJu0Yw16GY8HiRtTBdfbcrxFL8mjB3x21PDQHB0g+zLOOqz1IW2+fw3
 aVXjqMTAcRKlPiM9JfofJjFwEjVzwYj3/KQiKPRbaWnevPj/xJwi4mukI4nIXHY=
X-Gm-Gg: ASbGncs7zWnz9NZ1/zo3rNH0EtDBsf3A7GqsBwli+e97wR5OlTJRYx6JtfZNDbH3oXq
 H+DVXOv6A3sdrS+YtBCcUG/J3r+KnoNyCKuJffziFIE3xBTvtE1P7b6RT3sYm6/ilpNqSvKfEYi
 PSLKzUjduRq+YzY61P+22s0x7RDFAA/RBgOtB0gkgCAEh4LWAibpLByKuP4Dh6enRqfH92myZDQ
 3bLZNOpCzRXamB7sx5Az1I84WLeJzqdBo0WOtgVS5+ntg7h1T8uF1Myeg9FlZstOWt2JJ91bCyf
 o6NFxoQSevDnaibWatW6hN//yKfcwSyVMo/j+VBZLIFJxLcAhw66P+EtjVZpwtpZ
X-Google-Smtp-Source: AGHT+IF7kQI134pr5JCCF7S+fcVh/OBWQApK3/7naJjxZZQukPEPaXEu6erehJ7pCUnpPxyTJr1+cQ==
X-Received: by 2002:a17:90a:d2cf:b0:2ee:db8a:2a01 with SMTP id
 98e67ed59e1d1-306a62103e3mr8214778a91.30.1743852595959; 
 Sat, 05 Apr 2025 04:29:55 -0700 (PDT)
Received: from [192.168.122.15] ([173.164.107.234])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057ca1f07fsm5384717a91.6.2025.04.05.04.29.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 04:29:55 -0700 (PDT)
Message-ID: <42750cc0-177c-4939-8832-154c2d2178d8@linaro.org>
Date: Sat, 5 Apr 2025 04:29:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v3 19/19] tcg: Convert TARGET_SUPPORTS_MTTCG to
 TCGCPUOps::mttcg_supported field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250403220420.78937-1-philmd@linaro.org>
 <20250403220420.78937-20-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250403220420.78937-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 4/3/25 15:04, Philippe Mathieu-Daudé wrote:
> Instead of having a compile-time TARGET_SUPPORTS_MTTCG definition,
> have each target set the 'mttcg_supported' field in the TCGCPUOps
> structure.
> 
> Since so far we only emulate one target architecture at a time,
> tcg_init_machine() gets whether MTTCG is supported via the
> current CPU class (CPU_RESOLVING_TYPE).
> 
> Since TARGET_SUPPORTS_MTTCG isn't available anymore,
> instead of emiting a warning when the 'thread' property
> is set in tcg_set_thread(), emit it in tcg_init_machine()
> where it is consumed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

This doesn't work for i386 and riscv, which have both been "updated" to initialize 
cc->tcg_ops via ${arch}_tcg_cpu_accel_type_info ...

>   static void mttcg_init(TCGState *s)
>   {
> -#ifdef TARGET_SUPPORTS_MTTCG
> -    bool mttcg_supported = true;
> -#else
> -    bool mttcg_supported = false;
> -#endif
> +    CPUClass *cc = CPU_CLASS(object_class_by_name(CPU_RESOLVING_TYPE));
> +    bool mttcg_supported = cc->tcg_ops->mttcg_supported;

... which has not yet been called, so NULL pointer dereference.

I'm not sure why the init of tcg_ops was moved from ${arch}_cpu_class_init.
Probably it looked nice to remove the #ifdef CONFIG_TCG.

There's a definite ordering problem here, and I'm not sure how to fix it.


r~

