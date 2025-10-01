Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E177CCA472
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 14:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yAA-0003sd-0i; Wed, 01 Oct 2025 10:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3yA7-0003rs-6I
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 10:50:36 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3y9r-0005sA-Kc
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 10:50:32 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-78af3fe5b17so1078436b3a.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 07:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759330210; x=1759935010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Wik4f061JdQK++F4f8nYGgXnGMZ15vWa3p55l9qZWA=;
 b=iI6T5s1S3dxNd6ycihbCIfcsb7QnPKg6G/uBuoPo72yXTT1lcmPRQYuIygi7zzEBdJ
 q0Byj5yRUlIyW6G0rkqQOl9fZNqoun7DADVsDA821tGAjB3H9cyOWzLPtL1aZeImeyVV
 ZNJyOxAg4xjdsZgPXZfvepKdBpWaditJIdPk8S8z3IpXDOy9TzJbBPTVi6goxOztRk42
 AwcqrO2o54YdDF5kJcd5C9eIxMAunJB5JMfMRCppuiJiV1MNghQxYgwWi1zVxZSk+9TI
 YXQVV7/o7F2fUiHRai2+58sFa5exXyyQVFaJbd5VWrWkZF8oPO0Wn+kgHt6PKm5ORoO5
 oe5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759330210; x=1759935010;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Wik4f061JdQK++F4f8nYGgXnGMZ15vWa3p55l9qZWA=;
 b=QzkzynNmnaSJBSD9yWWxgFVKqRK9i0gu/Y1kr53I4SIIdiBGq2osq9OzrjomjNgbi/
 bGPEFhkhXNLDEINqsIRjniImIV5A5s8C26YehPT0UQfSp9L3P9iKHv+PpCRqF27Y7s2I
 pM4MfFRtaw5/hpAK/ppCKSxotw0x38A+QgIjsDdQu0f65ccuthr3lJdxfdBSL/XRtneJ
 0ekSRLoP4ubCpl6PMcwusgCs7XSvdzAS05HMe1hkoPn+PkQsdOlrmoNNNmVtATMjc8mz
 5pUFRglAg/RgUKYWUvuvTwnfFNKh390iAJi7aBxUV3jmbaLrETbNccRYH5qW2GBCVcau
 PGcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcaRQOuYlkopLuGrDBhQucCeEjanQonArCVdv7KfI24QsLnYPjw/2d4J1uu6+HDrXoiiB40LWiD7bb@nongnu.org
X-Gm-Message-State: AOJu0YzIYuJyWog1vyZQKUzt8xAVqr9g84HQbwsWvVssjKV0X7AVG+0m
 MPBigJwGsY019vrMhiM9JDuPy2zCuo4CYUeDTPE+QtLj8K1svUvo7DTwt4JY3ormQxtfM4vTuAR
 gvfYc
X-Gm-Gg: ASbGncsIUChNWO9OxSvmzKON29SsYjYkDsUii8bGu9udQQaKitWnLJc97TH3mWEN6+w
 K4MFhewP6me8D8PrIn3w0jd3lZ1Nxpzk+wYmpfYpTZmAOqL+l9Wd2O5CnFAQBRNT9zl6TJ7454G
 5sGuAk5f6TeI73aBMFh+SPBD/MXkkfu0YJGcECWPNzpc3VwNrgKKztH2PD3zUtbjk0pw9+KdOpo
 EmFn8CLS46bOPNjOhuTqpr9qnRvdgPc9OLkaYfNohf0quqIetc37pPw1t4kbVJhhe7DTD+geTHa
 XaM6s+6aqvPKnpb4hk51tUG8OP+z3eWBfhDomJEon+htyobsBS3VX18gMjEhluaXb+1ONOL+cj2
 Q2ULKG6biYBjRhZj+S6eivyW+vHmAvV73KxiznQRe7q0oAAjePjRatZapJOsXOYcq3ihqu2oaNU
 dWTGq+xfWo7FhRDdEVWi20/Rj7KfOQ1sQ=
X-Google-Smtp-Source: AGHT+IHQyv3cw7dyYlNcLu8oAJaoQhJKbxQWFbtQ+ORLcdO+qGiw27F4lU48bvcfeQM2dMIu61WIYw==
X-Received: by 2002:a05:6a21:62c1:b0:2c5:f4a:8839 with SMTP id
 adf61e73a8af0-321ec9365afmr5477762637.60.1759330209787; 
 Wed, 01 Oct 2025 07:50:09 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c55741e6sm16131304a12.29.2025.10.01.07.50.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 07:50:09 -0700 (PDT)
Message-ID: <e6eaaddf-8bdb-41e6-bb8b-7272809f3abc@linaro.org>
Date: Wed, 1 Oct 2025 07:50:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/25] hw/vfio/listener: Include missing
 'exec/target_page.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251001082127.65741-1-philmd@linaro.org>
 <20251001082127.65741-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001082127.65741-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 01:21, Philippe Mathieu-Daudé wrote:
> The "exec/target_page.h" header is indirectly pulled from
> "system/ram_addr.h". Include it explicitly, in order to
> avoid unrelated issues when refactoring "system/ram_addr.h":
> 
>    hw/vfio/listener.c: In function ‘vfio_ram_discard_register_listener’:
>    hw/vfio/listener.c:258:28: error: implicit declaration of function ‘qemu_target_page_size’; did you mean ‘qemu_ram_pagesize’?
>      258 |     int target_page_size = qemu_target_page_size();
>          |                            ^~~~~~~~~~~~~~~~~~~~~
>          |                            qemu_ram_pagesize
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/vfio/listener.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

