Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85577EE6456
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 07:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soe1V-00010J-GW; Thu, 12 Sep 2024 03:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soe1T-0000yx-TX
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:13:48 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soe1S-0005d4-1x
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:13:47 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-374ba74e9b6so683136f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 00:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726125223; x=1726730023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xR3DzUnPs3ptq+K8Ftk1iMToHIR3TmpEAO1/k2Z+Hx0=;
 b=T5jNqwBXNRQoRJXrjLl2iN7jQoXUbE3zvSKzOdodHIIUhbGyE3KI1apeGYRXfNVYwg
 QAHsmxJqLs867Q4SA/A0Bg5xeIhRmbDAA5f+6vVUC0VxG/XHoh63gYbJvpXWyPvvoAPl
 jw3WE1JDzFcdLQH7yXdxGxz2aW9ejmIRwGHtz+rdOmHCt37ZvYmrYPp6XuepJ7P2uqW4
 UxMcrzz/kFKr8nvKOlnaymicUfXraDN+PvWINvLKfVRM0Jal2TTOhiL34HQZBeNbW20c
 fYklM71C3SCeN1UOSgwDk7kLTqUGO+69F/tgUTRtvxyfPQxT9HBx0yByeCYM0Rf5OCUm
 ssTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726125223; x=1726730023;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xR3DzUnPs3ptq+K8Ftk1iMToHIR3TmpEAO1/k2Z+Hx0=;
 b=EqqapEmWgYNcdJNZeTYkdono/v+L1RjtMRrg1yFBPPVAn15E6K/kIEAXXs/JpEf4rA
 U/JmfGLBcarnpPg4qblFAS3dSBjmikxopA0eWR0ko6Y88wIxXBZSf6/+xwObvhfg0HdN
 lHVoa7UdJNvhp84bV2vSy7F6mvzXOq3pmLzk7SEsMOeSKD9EMBP8qdDjE0Q9aineGAvw
 dnUxxxN3VzSRi0Sn8k9fag6FRANuxpRt8eVvZiCppJsyBvfpnJHhSPkh5K+1HGjKKD3L
 B2YJ57JQ/aDUcgzrPMYZfQ4xQzE7hjymwrryJiC1JEz21SHgjF9E4seGsxFNokhfQ1oP
 M8nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi3mUkW+q4zxKEcnQwo8l/o/B6C8G53BBMHH8a9m0u8BsBag8nH5Z2S9T5qdwIej8jWMb9TnenC1hQ@nongnu.org
X-Gm-Message-State: AOJu0YxHbpkmbqE4Ge5RFxk7AAZQ+ITaR4Ylj0lwpUw55tsvrOQluEeK
 B0ceTII7K/eCn7QSEJ6bNHtcNqZmqps1GGO3oA5Xr0Rwe5ws0Z7tL5Jemy2GGZ8=
X-Google-Smtp-Source: AGHT+IG/NufQLGhXDxBMXAackg/sn95OdRP4T9vJNln9jGTzxNFbAbCM8Czolo2lEiOfBGq7JEc+NA==
X-Received: by 2002:a05:6000:c81:b0:374:bde8:66af with SMTP id
 ffacd0b85a97d-378c2d581camr1398725f8f.57.1726125222836; 
 Thu, 12 Sep 2024 00:13:42 -0700 (PDT)
Received: from [192.168.69.100] (mic92-h03-176-184-33-210.dsl.sta.abo.bbox.fr.
 [176.184.33.210]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb81611sm165598155e9.32.2024.09.12.00.13.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 00:13:42 -0700 (PDT)
Message-ID: <444dbb46-bee5-4983-aa90-4d88f005c5eb@linaro.org>
Date: Thu, 12 Sep 2024 09:13:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] softmmu/physmem.c: Keep transaction attribute in
 address_space_map()
To: "Fea.Wang" <fea.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20240912070404.2993976-1-fea.wang@sifive.com>
 <20240912070404.2993976-2-fea.wang@sifive.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240912070404.2993976-2-fea.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 12/9/24 09:04, Fea.Wang wrote:
> The follow-up transactions may use the data in the attribution, so keep
> the value of attribution from the function parameter just as
> flatview_translate() above.
> 

Doh, long standing bug...

Cc: qemu-stable@nongnu.org
Fixes: f26404fbee ("Make address_space_map() take a MemTxAttrs argument")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> ---
>   system/physmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index d71a2b1bbd..dc1db3a384 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3274,7 +3274,7 @@ void *address_space_map(AddressSpace *as,
>           bounce->len = l;
>   
>           if (!is_write) {
> -            flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
> +            flatview_read(fv, addr, attrs,
>                             bounce->buffer, l);
>           }
>   


