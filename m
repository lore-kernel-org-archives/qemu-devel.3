Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5ADC87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 11:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugLwN-00076x-6Q; Mon, 28 Jul 2025 07:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugLgJ-0005tO-Og
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 07:06:16 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugLgE-0001re-ND
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 07:06:11 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso31465575e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 04:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753700763; x=1754305563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5EzSKU+h4Ak/EbXS7kgUaozDaGnCRQc4spyQDkugc2c=;
 b=rbIumGc2V5E4qs4TiegFgUPMOwFKO1zkY5VlrLIcKzV2yXgUvPwhWPWhFJXp0ARjdZ
 QHDdEz0JQ6H7pJjVvK3yE+/8AjIDnFciY7QkzXRxuBjF/YMdYjm/hre2c9Eq/Z9l9kiD
 PDOPWSwCfIT7GwZ50jV10YdOkB3IGF7VJS0jS4r3Kf5TKnRZPai/n87Ps5547tAQiaSS
 xKbXHyMVozUUdbI5Tk6zCPNc7MMMf7KAHeafTOMptX1jk8x3+q5lzIRLwoAQj6Pq+iK7
 HIYpj8f5qVQke8E7NZmZ5unxL4QiufnMEXyep7ZGR51Q6fP4oXjRfUkj5nM/foYKx+IE
 fjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753700763; x=1754305563;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5EzSKU+h4Ak/EbXS7kgUaozDaGnCRQc4spyQDkugc2c=;
 b=CIkGtKZQlobUonYBmVEDBIS/3yvPWqCwO2CjlCxchKxYNB/Jhlb0q10bmd4NpLGCMJ
 VIIQYXgfNdD1xAo61V2pOIaoz9x5mMuQ470bhWyMSJEajbQ5baqWwew1JjjBX+Thk6Bn
 f0/KvwQ36cQW5pkqkkjDUBJ+lZXOSrYHzeyxaEfCc9EPvw2XHYlYVepVYxtXWZowWWfE
 FOJWPmDS4kScdbaMiiMrxr9MuwxN5e/Y1zdLw1H+nRLJ1fkhJzMIJWuVNfXynlT44N86
 z4RCn5JeQB1GxjLtUhJNbShIyYirDAckEGlhzwLwaipC2Ln2sPhcS7I5IFrQUQ9Np0K2
 ZR+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKSzEMMzxbh+DZ8NJs1DPyLf6JXq/D/ZMVXOkMyWhxiupnywcKo+AQgvVdGAMoSspzFw28QPOhZJRt@nongnu.org
X-Gm-Message-State: AOJu0YxR8gbJojL1+cZJcrz6J5XnilTFyXqt2yl9i0ICeqmLjNZqWW5+
 vesPs+sccnREvIzk15ARcr7xgya2gLgnEtMJp8EqpxevMZR2/xYUeblg8HZrlpKFU1s=
X-Gm-Gg: ASbGncscrBPgpEcjzJLMlxq7+JXY0KOigBK+hNa97hA/aq1WNUg88PRRmfL6QvnUryS
 0DjfXXd2IkdVM8zIsEQuCUeWtZK7x6MthV2t6SGy7+A640OYLJz9d4HilILyty/6PCfLQbbSSs6
 CEAKuYYbPfLr1cvzZlFBCqmUxqY9soVanZUaGQMloR6gLvX+VES1lt+Nh5yGkxdktDUsYVUC29l
 2hmxsHPrDoKCtQ6EcbaEC6ckYYLlLRgqrro26TNOhVjbRXnZ3V7CSITAFvvAI6kaebYtaFYHhs6
 dULcZ5mJNSRYdL1YJL65c9qqEuiaBe42vkPLT2EQ0iocvmXWHZ57QD9iEk1YRVGU+Spap7l/Qy4
 WZ0XuFZpkbbS9mkoKcHPcahrzfBUpQCRLyMS6kTOsKEggRFO3xSzsvAlgW5xTidXKlsyWHmV8/o
 Pi
X-Google-Smtp-Source: AGHT+IG/RghZo0+Wz585BSX5eWBXordnv7rcmdgWBmsSH7SmOBPkosEXQxzdGeWx8vjNxXSspw7B5g==
X-Received: by 2002:a05:600c:861a:b0:456:1bae:5470 with SMTP id
 5b1f17b1804b1-45876b12ab6mr61946645e9.8.1753700763120; 
 Mon, 28 Jul 2025 04:06:03 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4586f88ce71sm121702835e9.0.2025.07.28.04.06.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 04:06:02 -0700 (PDT)
Message-ID: <ea0e0abb-b9b4-4a81-bdba-ce9c6873bf13@linaro.org>
Date: Mon, 28 Jul 2025 13:06:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/qxl-render.c: fix qxl_unpack_chunks() chunk
 size calculation
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paul Durrant <paul@xen.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <20250221134856.478806-1-mjt@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250221134856.478806-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 21/2/25 14:48, Michael Tokarev wrote:
> In case of multiple chunks, code in qxl_unpack_chunks() takes size of the
> wrong (next in the chain) chunk, instead of using current chunk size.
> This leads to wrong number of bytes being copied, and to crashes if next
> chunk size is larger than the current one.
> 
> Based on the code by Gao Yong.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1628
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   hw/display/qxl-render.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
> index eda6d3de37..c6a9ac1da1 100644
> --- a/hw/display/qxl-render.c
> +++ b/hw/display/qxl-render.c
> @@ -222,6 +222,7 @@ static void qxl_unpack_chunks(void *dest, size_t size, PCIQXLDevice *qxl,
>       uint32_t max_chunks = 32;
>       size_t offset = 0;
>       size_t bytes;
> +    QXLPHYSICAL next_chunk_phys = 0;

Thanks, queued (without zero-initialization).

>   
>       for (;;) {
>           bytes = MIN(size - offset, chunk->data_size);
> @@ -230,7 +231,15 @@ static void qxl_unpack_chunks(void *dest, size_t size, PCIQXLDevice *qxl,
>           if (offset == size) {
>               return;
>           }
> -        chunk = qxl_phys2virt(qxl, chunk->next_chunk, group_id,
> +        next_chunk_phys = chunk->next_chunk;
> +        /* fist time, only get the next chunk's data size */
> +        chunk = qxl_phys2virt(qxl, next_chunk_phys, group_id,
> +                              sizeof(QXLDataChunk));
> +        if (!chunk) {
> +            return;
> +        }
> +        /* second time, check data size and get data */
> +        chunk = qxl_phys2virt(qxl, next_chunk_phys, group_id,
>                                 sizeof(QXLDataChunk) + chunk->data_size);
>           if (!chunk) {
>               return;


