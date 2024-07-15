Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40239C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 21:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTTDE-0003vg-H5; Mon, 15 Jul 2024 17:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTTDD-0003ul-7D
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 17:26:23 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTTDB-00062w-Lg
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 17:26:23 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-367818349a0so2806958f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 14:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721078780; x=1721683580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NC8jnu5P1oImIDkdC3fuFoaRP2LuWED0YnSbV1X0G04=;
 b=YMiEzBJb01NzCmJeowtF54TGewSYQNtvr4SvnrVs81F6RvuwrI7nkDe5D8UZmFXt7w
 HUIB6QZ9wOIVsvF3B+ieKyQcrhvQtvJbd0jHsZObVlDuLrT4lXJPs2RTdZ39A6slxSs7
 X/bmLxYZH0/10eljcM4vE5mmw45FhrfkCpffSkf4VLfXDQnu4RFww+NDcpSCCz/x/8pc
 0QIuyDOiPCXDyMw5AXUp0HOLsPfdY0NPU9YTJt9vZPKICjIYl1uxquDTetFi/wjEJJsr
 6eKoLGL+aBf9xe7tYWKGUFFxNYbNZROZtNIq/giW1D0yZo0fg9JW4JGe+ffPCtsD26iO
 QJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721078780; x=1721683580;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NC8jnu5P1oImIDkdC3fuFoaRP2LuWED0YnSbV1X0G04=;
 b=B5hzU+BmbKWjI/NIpFW2ITHLvw6KqQdeph85FbUz+yFrNF+ezGrlmIE7TuFWVdn/gq
 ToxsB2qGBxdDcXBbpjA4hQF/eA+IIonkGZ7Pwv5Jzmu3aH0KfKLpU4OCvhYj5R7xjMfL
 8aFRveLncgm9QiwoW9m0VHsRg7FjFjlLkhia2CQ40HjoUd/1L2HqVY1PjJOB3SQ6qrnx
 ggAphTFs0kjqDxxvNA6Ef9zGDOLHdhB4+tTERaV3NnqeeYT8UfZcjPDaFV9ITdas0eOr
 kZeCFpgDr5ySlBintNJjEFOYGktHsGXPwg3o+qDu2Dy0zzq41KaMgtXmOsF3Qd3jq/8G
 VzsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh9zBsxmvBbikhTmSDWDjjjgE3/68GuOsN/MoC/9qxNk46qfIKxHlADAVaRKoGe/k4nbN45mF7KeBy/Y1JFxY0h5cKbxk=
X-Gm-Message-State: AOJu0YykQb5yUofHCkLARPGOhI1JPkj5aYFqB/SrZGIROfNF0cClHx4n
 cmrz/F2lHPkaK/MadgsdV3tfvRjG04hw4ds0pUas8r5tEFzWUNCuSFA9cwBBfEE=
X-Google-Smtp-Source: AGHT+IFvk0I6yuMwAQ3SL6ZvE/IQEpzQWnKRUngWwCCtRgbIP1CCMJ+xns3Yu8NodxTWW/oZ9tpDNA==
X-Received: by 2002:a5d:61cb:0:b0:367:9754:810c with SMTP id
 ffacd0b85a97d-3682612bf15mr57928f8f.38.1721078779702; 
 Mon, 15 Jul 2024 14:26:19 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.134.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680daccbddsm7318727f8f.64.2024.07.15.14.26.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 14:26:19 -0700 (PDT)
Message-ID: <28a35035-840a-4c70-aaba-4192f7cd8ef3@linaro.org>
Date: Mon, 15 Jul 2024 23:26:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/26] hw/display/apple-gfx: Asynchronous MMIO writes on
 x86-64
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, agraf@csgraf.de, graf@amazon.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 peter.maydell@linaro.org, akihiko.odaki@daynix.com, lists@philjordan.eu
References: <20240715210705.32365-1-phil@philjordan.eu>
 <20240715210705.32365-17-phil@philjordan.eu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240715210705.32365-17-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Hi Phil,

On 15/7/24 23:06, Phil Dennis-Jordan wrote:
> This change ensures that the MMIO write calls into the PVG
> framework are performed asynchronously on a background dispatch
> queue. Without this, we rapidly run into re-entrant MMIO issues.
> 
> This problem only seems to exist on x86-64 hosts. Conversely,
> doing it async on arm64/vmapple causes other issues,

Such as?

> so we're
> left with 2 different implementations.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   hw/display/apple-gfx.m | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> index 806feb58fa..48463e5a1f 100644
> --- a/hw/display/apple-gfx.m
> +++ b/hw/display/apple-gfx.m
> @@ -67,15 +67,28 @@ static uint64_t apple_gfx_read(void *opaque, hwaddr offset, unsigned size)
>       return res;
>   }
>   
> -static void apple_gfx_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
> +static void apple_gfx_write(void *opaque, hwaddr offset, uint64_t val,
> +                            unsigned size)
>   {
>       AppleGFXState *s = opaque;
>   
>       trace_apple_gfx_write(offset, val);
>   
> +#ifdef __x86_64__
> +    id<PGDevice> dev = s->pgdev;
> +    dispatch_queue_t bg_queue = NULL;
> +
> +    bg_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
> +    [dev retain];
> +    dispatch_async(bg_queue, ^{
> +        [dev mmioWriteAtOffset:offset value:val];
> +        [dev release];
> +    });
> +#else
>       bql_unlock();
>       [s->pgdev mmioWriteAtOffset:offset value:val];
>       bql_lock();
> +#endif
>   }
>   
>   static const MemoryRegionOps apple_gfx_ops = {


