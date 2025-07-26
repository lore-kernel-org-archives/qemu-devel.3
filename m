Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C10EC87FCF
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Jul 2025 01:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufTlT-00080u-SR; Fri, 25 Jul 2025 21:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufTlR-0007zd-2r
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 21:31:53 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufTlP-0001lW-Ec
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 21:31:52 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-234c5b57557so23796035ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 18:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753493510; x=1754098310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BTLbOGCZzomcfnV76IIWtTtThiruuLFwyNSYOOpyyds=;
 b=hWbY4ZcPKJgOtVZTOUpA7Hdz1inV3kNmngrkfwi+c3I+tXad4q0Bx9QvOwfEpx5qXK
 T7r/EUk+K+yWj8ecNJdrd2I6o5bm57VNbhJab1bosMPOrMuji+bcQdVhGQ1RK4jwe8gI
 pbmDR47tMYIJcyNuhn0PkX/N3EvLk2DzrTB2tr83Q/z/uJeoiR45xbdSyB2muS0gm8Q+
 t8jzenBY2yQY7JQ01F7DrMf0vwqg21YMXTeHBfkr+Am/5LO9S1qab/9zaC3fjE00ednS
 jIlRRQ3K7FQkc+boMhyvmjPnTf3p0N1CVbYY1kKoczWDQH+oxnDzgoZGtnQTT71i/ju1
 UUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753493510; x=1754098310;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BTLbOGCZzomcfnV76IIWtTtThiruuLFwyNSYOOpyyds=;
 b=JHom5hub9w9MoXLVG0HC0GrQ0+sYx+qLP3VmW8jIQK8VaRCr2sNZpR8KABQLND4fnG
 L0seGas+xBSm7iOawUJosufwmpn99TS0tFy4oQ5PE9/8S6WuxWK1TfjgN6GsL8a/XhBz
 IICb+ZbQVEXPhJ/KYR1zUe2sYuQZ2zBRHqie4I+RAvyRUQM9iCRoNNEXCj09g4ZW5K1X
 9pE2faZA1zTk//50gckk9qRE4e8iiZ+QZSgps8R4Mb8cYi3GVLNmvSNEI68z7J2JmMhT
 fsk8i1jKU4UTm0ESJUHnTje2ql5Fe9y2MFsW5e3IClDywiZmYupVR0yeq3Jk7AGNJ5xC
 p+bg==
X-Gm-Message-State: AOJu0YxYbfsaGLbpOpd9oVAVJ+CHbcmGFNJSKUUDx+XSj9puR/fReP0h
 wo8Rp9PcXTRNJ6BNEakcTRNMmLKFo5zfE7QBcT/UE3EGg2km6d+OjilqgdXYiOFh/516Q8P9lar
 I66CU
X-Gm-Gg: ASbGncvw7cdGHUzEdSmNmxSN4MlCGbJu3ZEodkEtdqgALZuHD7tBvNTo6oaE9iRxonJ
 tb3LRaZ2fiFxeVyMsNLIhWLwVtp9GyVSeZz2zYRViqNq9CMK+WZyknFnuFEA3yvN5nGMa4vHkfF
 4HOVoZdEDIYaM2YMPwA13F0eI8WQH6uieis+o48DKe7oPc+auL+sPQ2THFnaj+clWJTZYlTHXNV
 IDVOgsKsgDcCp01XtYg6MhgmxNRsWdSMWO1wwghugLe6bsQnpRfoI0mccl9BgF8mEoFcZoNMXOj
 e8Kc7PQrYk9qVcK32iuLESPN8lBDsQRE10tfQ3J/uYLIq06Ct7/5m/Rvc0IxBDftKZ3fntfUyR2
 hFmOrnz+6HGIruwmxr9sRY8tOCDCIDi2zGwAT94h5I+tldt+o8Cqe0hN/5K5z088cgfcxoIwEhv
 6eYQ==
X-Google-Smtp-Source: AGHT+IGXp0alZ6OffCg2rLCkZtC/6vL8W6Tvp3jTWg0zgNTjmjgjBws5m0JrNuDZ7RwF5u2PDedNUw==
X-Received: by 2002:a17:902:d2c7:b0:23f:8df8:e7b1 with SMTP id
 d9443c01a7336-23fb30b3224mr63720755ad.32.1753493509721; 
 Fri, 25 Jul 2025 18:31:49 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fc5a9d1b9sm2886995ad.94.2025.07.25.18.31.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 18:31:48 -0700 (PDT)
Message-ID: <80d713a5-a696-47e5-ade3-fce9472daf1f@linaro.org>
Date: Fri, 25 Jul 2025 15:31:46 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/17] target/loongarch: Add parameter mmu_context with
 loongarch_page_table_walker
To: qemu-devel@nongnu.org
References: <20250725013739.994437-1-maobibo@loongson.cn>
 <20250725013739.994437-8-maobibo@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725013739.994437-8-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 7/24/25 15:37, Bibo Mao wrote:
> @@ -191,8 +187,7 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>            * legal mapping, even if the mapping is not yet in TLB. return 0 if
>            * there is a valid map, else none zero.
>            */
> -        return loongarch_page_table_walker(env, physical, prot, address,
> -                                           access_type, mmu_idx);
> +        return loongarch_page_table_walker(env, &context, access_type, mmu_idx);
>       }

You haven't stored to the physical/prot arguments to loongarch_map_address.  I'm sure this 
gets fixed somewhere in patches 7 through 11, but it means that this patch set isn't 
bisectable.

It *might* be easier to start from the other end of the call stack.
Then you can do things like

   return loongarch_page_table_walker(env, &context->physical, &context->prot, etc)

in the intermediate steps.


r~

