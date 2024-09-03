Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E84CD37AC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 20:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slaC0-00032T-3A; Tue, 03 Sep 2024 16:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slaBb-0001U8-Mq
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:31:54 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slaBW-0006FE-NH
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:31:33 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-715e64ea7d1so4966424b3a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725395489; x=1726000289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kXJfT3y0f5XCSjrkvcEuP8Uv79zBVDHxfI0HTHS1+hY=;
 b=IySAK610QK6p6ltvli76Z4wBOe9eBynlkDlDYsHI/dF8vvIMAnASnScr+F/4C7HctR
 Y/0brllQgSX2h3BpGjEePldMxIUGCsCgkXT7359QXvTbNSXyq83z0Dn/6eME8Eg614du
 avl33jnJbYL+Uann+ZFcqW13Y+PLAu6tIJvPELlxNi+SSqPwhzr2GbYPzdPOqjrniqe/
 SyzOIXehizHQ9uyBRkRq5PToGd6D3MIkYGa8H9gdjMBo9Ex0lRm1YXEdPj1A58WkQqLd
 y+Nlyq3WyOG/3x709GV/tj3ehwfqapCOnu0i+dsOsCGWFK/fI/Ft7gFs6HS/v5GomkT/
 S9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725395489; x=1726000289;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kXJfT3y0f5XCSjrkvcEuP8Uv79zBVDHxfI0HTHS1+hY=;
 b=w6X6fMmm2wcNM6rF7kb0NWuZH3AwaR3wzwf+ZLWk9TTQqfM/b+dUIsYoZADfxiCdCL
 3iQrzBJfcLAuOrhxvjQokpoj1kDZW6xXc07nvciY6FKK/2iIdPKfwqYEcr23lGNZsP5C
 XKXVQi/0K2DPc83md8qi9JGf5CqmYrl3+zZeaTKkD3HLOMGICg8toJ/z5Mtwnp1m7lFz
 X6h+fTuzNB1MuBqyfnAzyaKWOOPS6PLcGq6cNiUiPvfMwBOIVtDOPl8XA9spH/SOZKBB
 0u/PP/KaOFSpzXb2UFdNFu2/s9MIuyhjZzvvV6Fykv1HF2vH99Cwq0CtXhuo57iC6aKC
 MbCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRD5aszZAxWjZ1EGINe+WxP1sV7bAqY3jFRfVOkKaI6DawGtyx1xE5HMJ0gFsa+7xByFNOhhX4aMej@nongnu.org
X-Gm-Message-State: AOJu0YwhUwvxtCKCQqCUJelFn/zt5mMxRg1hJpp2qCLciAFPfsBGCdjc
 THPSyVVFlxyhgFdS0+u63dtC4Puxej0WVxaguqkrX8+JKfvSzbHe1stTElVadBE=
X-Google-Smtp-Source: AGHT+IGUDpiWu7rZoJJEoedY8hKP7vZqsTm2b52fjBaYXjySOOwcd71ekND8nBqX9+VBiojLl4RQtg==
X-Received: by 2002:a05:6a20:4389:b0:1c0:e997:7081 with SMTP id
 adf61e73a8af0-1cecdf2e14amr15017521637.29.1725395488633; 
 Tue, 03 Sep 2024 13:31:28 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7177858c42csm272166b3a.136.2024.09.03.13.31.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 13:31:28 -0700 (PDT)
Message-ID: <f091410b-5ffb-482f-bafd-4f608755baa6@linaro.org>
Date: Tue, 3 Sep 2024 13:31:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/12] exec/memtxattr: add process identifier to the
 transaction attributes
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com,
 Frank Chang <frank.chang@sifive.com>, Jason Chien <jason.chien@sifive.com>
References: <20240903201633.93182-1-dbarboza@ventanamicro.com>
 <20240903201633.93182-2-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240903201633.93182-2-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 9/3/24 13:16, Daniel Henrique Barboza wrote:
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
> 
> Extend memory transaction attributes with process identifier to allow
> per-request address translation logic to use requester_id / process_id
> to identify memory mapping (e.g. enabling IOMMU w/ PASID translations).
> 
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jason Chien <jason.chien@sifive.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   include/exec/memattrs.h | 5 +++++
>   1 file changed, 5 insertions(+)

What is this for?  What is different about it than requester_id?


r~

> 
> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> index 14cdd8d582..e27c18f3dc 100644
> --- a/include/exec/memattrs.h
> +++ b/include/exec/memattrs.h
> @@ -52,6 +52,11 @@ typedef struct MemTxAttrs {
>       unsigned int memory:1;
>       /* Requester ID (for MSI for example) */
>       unsigned int requester_id:16;
> +
> +    /*
> +     * PID (PCI PASID) support: Limited to 8 bits process identifier.
> +     */
> +    unsigned int pid:8;
>   } MemTxAttrs;
>   
>   /* Bus masters which don't specify any attributes will get this,


