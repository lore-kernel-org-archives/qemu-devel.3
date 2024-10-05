Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5497ECF8869
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 01:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swtJI-0001tR-Jq; Fri, 04 Oct 2024 21:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtJE-0001pz-19
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:10:12 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtJB-0004GH-Cu
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:10:11 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20b93887decso22975125ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 18:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728090608; x=1728695408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LFAGykPUspbLZfYGbKb6dpy5Z5eZR/8JSd4o9GjPmkw=;
 b=JtOH3kyDWVTatnFh3D5si0TFdl5994NUUjqCUMGdpGt75EUU9KOIvSa/p/yeAdGaTJ
 zY6sjw+MOqyvCUn5wQ9mdjCIg2abqhGH8gQSPnrkiVbo528+AzcR2BngqbjYfGAl3MKm
 Pe79ukG8LiYcfC2VWze75AcGuJuviqpeeLGv5J4nI7w4kq5aTXysX7i8HzaxkkxQ5e+r
 /zkFl1q9aHAa5hTlrN02m1IG/bnUQWu9NkiCT8cWh6iqFzPCtkqKvBhuURj+Va7U9w0R
 z258It7ZJ6IMbm7TfbqUN7jTUuVtQhIBFLg+VzrmHNVG/2DrK1LG/ZFXxTEwg/Wbom/X
 9Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728090608; x=1728695408;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LFAGykPUspbLZfYGbKb6dpy5Z5eZR/8JSd4o9GjPmkw=;
 b=OyDD77xXMvWgtxRAYs16J0ioj2xq0kQsi4FnwWYgReAJgMwyJR93mCRjQktuOuWTnv
 ABeW10z1vmhgH4/SKUos/+R6bhBw/rNYLp7MGSjYDT/TKSZjwpjlP6+QX+lsZW+q/cXf
 STYwmlnhREYNsfFv7tl4J0EVljIqFQpQDu7ET12PxIwTQbenjEcKzLKgC2UDLU+stoWK
 KjeErBRsrdVyAEM9tFqp514JNG6F90HzIxaH1jbQSym11h5c7ssgGwLaOYL9C9VzRJA7
 fdIIFcbtMiUtrgyZ/hspclTOw2346W1UzAzo2/ZQBtnbZNJ8qc37DpmqmLc9iv7a+Mvk
 3B0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCURVFtC3uqXPuRSRfUjdwpvm5qx1wdEZxECVV3Ne0DwnXvfUSWjutTdoH2JXTNis6KjuIp2IiV+T7t6@nongnu.org
X-Gm-Message-State: AOJu0YyQwM1N6A/D2bdEg3tyn3HOiz8IM4FWfQAeTkCvcLxPorTs/d8r
 McVia+TvrahQMos0HBHM/J/xj9sCfHWdX0Wj9CVI/9Wnf9gpuMgEeT5qXPTZbBfqmCZzeGznua4
 Y
X-Google-Smtp-Source: AGHT+IEkrT6FHpvrNw8xx/VgUcm7P3Jt3kEeMB1St+Zs+x/0TBZpfI3NKBPTKD7TGuZ2uOhCUzxlcA==
X-Received: by 2002:a17:902:d2d0:b0:20b:be06:f3d9 with SMTP id
 d9443c01a7336-20bfe1887c8mr65210395ad.24.1728090607819; 
 Fri, 04 Oct 2024 18:10:07 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13934817sm4356415ad.158.2024.10.04.18.10.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 18:10:07 -0700 (PDT)
Message-ID: <f9131f6e-e843-48be-b85f-c341ec198154@linaro.org>
Date: Fri, 4 Oct 2024 18:10:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/25] gdbstub/helpers: Have ldtul_p() definition use
 ldn_p()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org
References: <20241004163042.85922-1-philmd@linaro.org>
 <20241004163042.85922-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241004163042.85922-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/4/24 09:30, Philippe Mathieu-Daudé wrote:
> Use ldn_p(TARGET_LONG_SIZE) instead of ldl_p() / ldq_p().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/gdbstub/helpers.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
> index 26140ef1ac0..fd83e366a51 100644
> --- a/include/gdbstub/helpers.h
> +++ b/include/gdbstub/helpers.h
> @@ -94,10 +94,10 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray *buf, int len)
>   
>   #if TARGET_LONG_BITS == 64
>   #define gdb_get_regl(buf, val) gdb_get_reg64(buf, val)
> -#define ldtul_p(addr) ldq_p(addr)
>   #else
>   #define gdb_get_regl(buf, val) gdb_get_reg32(buf, val)
> -#define ldtul_p(addr) ldl_p(addr)
>   #endif
>   
> +#define ldtul_p(addr) ldn_p(addr, TARGET_LONG_SIZE)

This does not aid anything in the short term.


r~

