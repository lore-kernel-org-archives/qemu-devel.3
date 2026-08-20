Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF41C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 15:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx4FX-0007tf-2S; Thu, 20 Aug 2026 11:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wx4FV-0007tP-9E
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 11:00:09 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wx4FT-0007O4-In
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 11:00:09 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so397499666b.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 08:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787238005; x=1787842805; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wwLWBgIUVebcQwCJcR6vF2hZR0T+onXWhzs8n/3SRk4=;
 b=v1OHRLa41bBDNuVCVltuLd3qINDF5Rf/UrphAMBABCbfqu5ssOlfz65o6XVN6pWWx8
 Ynpktr0CjpqWcROcNgFDhI/owErZLP3HsQzxSx9nE+pfgPOUiGs6+9zC4Ogi796cCmqc
 UgdaR+TfnKoSvdVT2vfaE0qtSPfxJTvOOVaN6gMfomiRHo6jE0fnhb0iANI/oYgCwuGN
 ShilvpCC2WFInEpEXECAQotbSgcUlb6zTGYpBxvgCycg48SbR3u/XrRZYP+nn7uK1Yyg
 eRtNJcB3Sw5XnXxXdtyB0qimtsC0CpNySFJfCnrxBbpKnfo7pxQ6pcq0lNK6CDBPiEA2
 eypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787238005; x=1787842805;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wwLWBgIUVebcQwCJcR6vF2hZR0T+onXWhzs8n/3SRk4=;
 b=gvfqfmQ/pGzFCr//qS/cFQIKFd51bxxie+dHQk6opFZs2ZGlCGsbjcSY/ThNihlE+b
 9PPJqbSpptl4NlYd8T5KuYHrhMZu5+jyag3KmeE1l8gjMFex/IbV+Mz0hLU3TUOsrKB8
 cepJOYcVH0vQwv2klSQLRfstv84+sqoMFQaRW/gi5PdB4Ju3SVhaIlaXqGPdfPiKkh2t
 wKonSzQXieub+OL7wZ4nexMxqqGAfWOfuW6T4tJwLITyQ2XGlri2yZpFhbnEx8QOyicA
 BEANxoWftdDUeRP9u8I/GqPOncqtVPNGWiRUjCGrPcRIz+OOm8HN3m9VAmBEb61Ing8l
 clxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrIRPN8miIPEhSAgWuN9REy5NelFf0iEeZI5pI5u4lR9l1G1V5dD4rHT0GMoa+vhj7AuIFD11Octif8@nongnu.org
X-Gm-Message-State: AOJu0YwfMhDKjOFm8+zjMI1AfNpPqfcIUpkXMmF3iDt7ruThmgYxGQFX
 OISmE4YHUxcx0j0epW8NQzKph/agNfB0tOi52RHetJykJjruNQCM2s/x77VofQNHCr4=
X-Gm-Gg: AR+sD13Ui1ods3PuTzfYcDQgCY/UfH8wn9WNakFbraFt4sljM0g/Erf5EZpuzT/Wspj
 4V/7ZsMg8oIduckKOR1zt/bLuT3pq0s+WND9xPN1SWY0Mn47IAZ5btD9cM4Wvydb5wcifqzRpwQ
 B6RTIkeDSi5Qplde+ge5TxZZyIqZnUkxPStzJO+0oWKP9kwEg95Per5gULYtqscasdv+FEnUiCi
 BMWgBcA0yEn9jJAJ8oQOL2DUDd3FPQo9dk5fwZaCYi3MiOQ4AISO3xAqez7F+I4A92GYMiyGsVj
 LwvyqIGEPLBx0GpfNsCyrIDPX66iyCHvt79zWmcvkD8zros3BJLjHh4PnrxzRAU8wULGzjYSuQo
 yMzIq6JEOKjvbT5816TEA5Cc9o3/6LwyRSkuOsV6nrmk50WMzWPzjih+Lniybu8K0jhxrAwbsCB
 jZGwN1mEAmDC5LwB6zC5JnC7snatyxi6nIP1LL4eZTO+fo7CHp++oTHVwwLqMN3h8NtBuksl/Sp
 4oTdxggoefQvV17yEaWN2oEOjAJbVDsyy0JOjQ1CAWFZ9WCdazxVueN+pdY
X-Received: by 2002:a17:907:9488:b0:c21:8c6a:c680 with SMTP id
 a640c23a62f3a-c242e3626c2mr944176466b.22.1787238005021; 
 Thu, 20 Aug 2026 08:00:05 -0700 (PDT)
Received: from ?IPV6:2607:fb90:331d:db6f:e6eb:39ca:2251:a26f?
 ([2607:fb90:331d:db6f:e6eb:39ca:2251:a26f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff0c30casm2275941a12.7.2026.08.20.07.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 08:00:01 -0700 (PDT)
Message-ID: <0ab52741-c059-4b3b-b1cd-fcf289bf820f@linaro.org>
Date: Thu, 20 Aug 2026 07:59:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: Add aligned ld/st accessors for vring
To: BillXiang <xiangwencheng@lanxincomputing.com>, mst@redhat.com
Cc: pbonzini@redhat.com, peterx@redhat.com, philmd@mailo.com,
 qemu-devel@nongnu.org
References: <20260820094611.1767100-1-xiangwencheng@lanxincomputing.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260820094611.1767100-1-xiangwencheng@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x635.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/20/26 02:46, BillXiang wrote:
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 387d65c..c23f5a2 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -255,6 +255,20 @@ static inline int lduw_he_p(const void *ptr)
>       return r;
>   }
>   
> +static inline int lduw_he_p_aligned(const void *ptr)
> +{
> +    uint16_t r;
> +    __builtin_memcpy(&r, __builtin_assume_aligned(ptr, sizeof(r)), sizeof(r));
> +    return r;
> +}

If you know it's aligned, then you don't need anything special: just a normal C memory 
access.  E.g.

     *(uint16_t *)ptr

and then of course no need for a wrapper function.

> +static inline int lduw_le_p_aligned(const void *ptr)
> +{
> +    return (uint16_t)le_bswap(lduw_he_p_aligned(ptr), 16);
> +}

And this:  le16_to_cpu(*(uint16_t *)ptr)


r~

