Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7039CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 20:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEw8b-0003w9-6u; Fri, 31 Oct 2025 16:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEw8Z-0003ve-Ip
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 16:54:19 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEw8P-0006Zp-MX
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 16:54:17 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-475d9de970eso18452125e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 13:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761944047; x=1762548847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aWig3n2agd4WazZPYglttl86zROiptjK3T/62YRviE8=;
 b=jJ0Er47n0hCytt6xPWSLxJf3UteybTzdBW2HoADkNNsmCnH24rpfcJLHFm1FYr3HKZ
 MtV5VVHl9WPwz/tdOlcxfW67QscQ1UzgXG+oXY6oQcswisV9Eh6wMuB5XcegRQN/AD4T
 GgH2wcyKinS+4TuMORKMOzY4enU8t0TsCqLqG2cc9/gIKV6JQ51/hyQzQg0HLz4FOiMX
 k8VbhVkP5SQow1xSEfTBjpWFL9iww6rTNIylSoDmM+xe7gmiDuqeItyJWPPNgL94Muk+
 PACSk4zPDinvBKrnhpicIdx0jJULv0ouRXUYJCRr5dVdVOdLD8z60zL+iGZIbW18BXwb
 2QkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761944047; x=1762548847;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aWig3n2agd4WazZPYglttl86zROiptjK3T/62YRviE8=;
 b=lI3EQN3RZrBr2hrggMZ8oDgTrf31iC5zMlEF8/fGxex/Y3bUsodKy6IuldSKr9XhOi
 ISo+mcrBZCNEFllqbJXWDM/cO/HYckNy/Xzkui/tEiOk6PE6rwKXmQZXjxiyt8XCP0qV
 jJCdWnGL3nVMysxy4SzmK+jNhzI4yRWyuuliJNqxOt4KEa+YjXKVVLgHCPDRaGOarfWv
 7geeA5AcRqcHyTCNXkezqGbbdOM48rIqh/nEhBA/yzUqdgz3JKuad8St62HxB91M/3uR
 ppXNgzE4Y2Amk0YNuAZb/JPo8e0uDl2rLZk1R1ASvCHaU21PRvKD3u6gq7/GrcaLBJk5
 AvBA==
X-Gm-Message-State: AOJu0YywbBBKTZB6F24kn20p2/7Ra53x7SXYdfcuUlEIHBvCOh0LFSsS
 SzXzAyi0W3z6NqCn+sbAcMebLzU0buWW63u8e6aCj2Vv3cseZWyogpYcc0Vft3OwGfI=
X-Gm-Gg: ASbGncv9yOh6NiItCHOxcBHh2PjAqLhrLSs4NhVbFMXKVYo4mqEYabgYwiUQuQwOWMb
 JGEx219UKvxDHac6a0xPXiXtMmckULTj3nELI/i5v5opkgFCsCpWUQm7AQr/EZptAAkxu7BpO7c
 yoINKnpeYmo4QiAqUK00TOi1/B//a9rQ6K0KhBrJI+HMWEVu+m4LEMCGI6renfbBwBoE584lNxr
 r7ArXj5CvWI4+gJ5Sga5qqJW09qvdykDGbe9sHcGMnfvY9785enzs6YBbOKgK9r1OxAdHmza9NL
 J+aXY2R29o3GivjLRpYNNWEjLS1hgACG2LtLaYt8jq+wNKU90On5y7sT5Ynuy/IjePYDGlm7Bgg
 q38jB0iUvPrW/tGcJ7t5JhW9RgVKfYapHRIeoUoGR06wn34nO6IZSwwCWzbHXTW8+xm3o0Et/1A
 z7i/zwViCAY74CmmAhO0AeBKXFM89oBaxXvcWSVSEH+blolKjrc55F1pyIpa+0QL/AP+B5n43zz
 NUN
X-Google-Smtp-Source: AGHT+IGQTn+fq+0v1xipSyleHL0S7CRlf605MewZVs7NliFpecaUAOOQ8lIQoE1GZu+mM4s+4lPsGw==
X-Received: by 2002:a05:600c:3149:b0:477:fcb:2256 with SMTP id
 5b1f17b1804b1-477307e486fmr43819815e9.17.1761944047010; 
 Fri, 31 Oct 2025 13:54:07 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13f3278sm5249453f8f.42.2025.10.31.13.54.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 13:54:06 -0700 (PDT)
Message-ID: <d0f6aa76-08c6-4630-927e-358c8f81f383@linaro.org>
Date: Fri, 31 Oct 2025 21:54:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 berrange@redhat.com
Cc: qemu-devel@nongnu.org
References: <20251031190246.257153-1-vsementsov@yandex-team.ru>
 <20251031190246.257153-2-vsementsov@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251031190246.257153-2-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 31/10/25 20:02, Vladimir Sementsov-Ogievskiy wrote:
> QEMU_HEXDUMP_LINE_WIDTH calculation doesn't correspond to
> qemu_hexdump_line(). This leads to last line of the dump (when
> length is not multiply of 16) has badly aligned ASCII part.
> 
> Let's calculate length the same way.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   util/hexdump.c | 38 ++++++++++++++++++++++++--------------
>   1 file changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/util/hexdump.c b/util/hexdump.c
> index f29ffceb74..7cfc547261 100644
> --- a/util/hexdump.c
> +++ b/util/hexdump.c
> @@ -22,6 +22,19 @@ static inline char hexdump_nibble(unsigned x)
>       return (x < 10 ? '0' : 'a' - 10) + x;
>   }
>   
> +static size_t hexdump_line_length(size_t buf_len, size_t unit_len,
> +                                  size_t block_len)
> +{
> +    size_t est = buf_len * 2;
> +    if (unit_len) {
> +        est += buf_len / unit_len;
> +    }
> +    if (block_len) {
> +        est += buf_len / block_len;
> +    }
> +    return est;
> +}


>   void qemu_hexdump(FILE *fp, const char *prefix,
>                     const void *bufptr, size_t size)
>   {
> -    g_autoptr(GString) str = g_string_sized_new(QEMU_HEXDUMP_LINE_WIDTH + 1);
> +    int width = hexdump_line_length(QEMU_HEXDUMP_LINE_BYTES,

size_t

> +                                    QEMU_HEXDUMP_UNIT,
> +                                    QEMU_HEXDUMP_BLOCK);
> +    g_autoptr(GString) str = g_string_sized_new(width + 1);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


