Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B24C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 09:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4zDb-0007xa-NP; Wed, 16 Apr 2025 05:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4zDR-0007w7-2F
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:37:58 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4zDM-0004aU-Fq
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:37:55 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso6178482f8f.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 02:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744796269; x=1745401069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sQOBlieVx7DwZK+XD/QwOsduptdXBd3npEDwZEx3ATA=;
 b=dsjGQuNQ1bUNO/diRmTy+uf7jZytFGA7gDwD3y9MYzqmWKlv4XvuNyQ/nn+gaktVPm
 sumetfxvL7WDapWhP+mLYPrVU5R8jH6NTyWwGXbcFoFbKS7WUTuaWIPJTGtbwsy9yEiz
 9QWjVJgWw5Aw6eW5lYfYouPYXsQmGOknIbfXjWY7VuoUpAO4j1si+Bj3E9koJ2WOy9Mp
 s2ViHQGDbRJFbN+58BwbGafVwDx8nFxKnR09bWj/kJXLxV7gGpExiakOyMUImc7/FxiH
 i8g97GZ76VGSG3n7dsDRfg28smkOHNTVCwyLaNXMETGgFa7nuXcBNhMVUEVFhSXeiQ83
 p2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744796269; x=1745401069;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sQOBlieVx7DwZK+XD/QwOsduptdXBd3npEDwZEx3ATA=;
 b=mu7NCbYaJXlKF2KgwGkuSS3eDUekovU1VvVdxfuoMQ6dN6xXVem4W1xRsQMbmdI1dO
 EwkaiE1wCky4V+CcTrie9u59Gc0SG7W3A4XAUMiGUNKdMfem+jr0kDVBoRL89Nh8i5vt
 Qm7ohpMn8zHg5KfEnnjILeMBDtFgmbLh7JrvWqpjvGug7KEEg53+mcnjWa3Bj3NORlob
 JdevbmFXBgP13ZOtGVnswLt5Tbt/8ajaRPRIO3WPdB5MdThjoyw+6eEtrUHalt5tlF0O
 wFAucsLvFl8LjfepMKrjWKHbY/RY3U0z8+dO5Pe4eGShWgPyw2zW9Z3ThmIX5s4mrf3g
 hNuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZqsusEEOmP685B/v5iCSNQarlQwCp0H0Lxe5bzdRCR3S4s9lBrvmyiri4maFgq/novUwGf7c3Cbqn@nongnu.org
X-Gm-Message-State: AOJu0YyPskIpjwB3Wtsfby22Vr9HXAlBxVkj5Es02ZisykRz5fRo77kb
 QXv4t6lORJRh6LzlujwGQuEgI0OShp79g376FKZ7NfKxpHiAPXx17x/tiO3v6Is=
X-Gm-Gg: ASbGncvCUSIfl9g/ueibGcZPgu1QWSr/7Avi1CjcVTyhVuaq8lISOieP1gv5Z1H/d+7
 HulcrYW19LYSGNNkRKP+aXeElXrAqvVj5qCBKq+YuTQyn42JR7mDvh04VuSUwWSoaBbSAKKxgw0
 8aCURNn61JTqd7q0IybdYTqVuON5FUJaYT6XSjndxYn46l3zuMLMpmrTsCWwnMZZtY6kO6hODXs
 dqSh1XbFctJY5PBahgHMPv8a6S3kK4X6RT617Zmul+o/EendPILrSieQUyZ5bwq5cucFFq+Tnmj
 BXoKp4Zs921qznhq0Bh98oCNoMFi1WO005YwcUz2V+ZayZ5jGaI9M9R//C+vMPrbt8DoeNeQnfX
 Q9dRRNVpkFv+09w==
X-Google-Smtp-Source: AGHT+IEbSJP+SdgI0tcHZOmu0kOzUlAeAcfUCVoNz3lD99jqt3F6Q/0K0L5eP2XrHzbEXTRek9UMRg==
X-Received: by 2002:a5d:6485:0:b0:390:eb50:37c3 with SMTP id
 ffacd0b85a97d-39ee5b37b83mr1219460f8f.27.1744796269150; 
 Wed, 16 Apr 2025 02:37:49 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae979615sm17040199f8f.54.2025.04.16.02.37.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 02:37:48 -0700 (PDT)
Message-ID: <29330430-61a8-42c8-a87c-259f0cdbefe0@linaro.org>
Date: Wed, 16 Apr 2025 11:37:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/19] util/cacheflush.c: Update cache flushing mechanism
 for Emscripten
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <97a2164b3f428265136bb1c01615a16b516138c2.1744787186.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <97a2164b3f428265136bb1c01615a16b516138c2.1744787186.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

The "why?" isn't clearly described.

On 16/4/25 10:14, Kohei Tokunaga wrote:
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   include/qemu/cacheflush.h | 3 ++-
>   util/cacheflush.c         | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qemu/cacheflush.h b/include/qemu/cacheflush.h
> index ae20bcda73..84969801e3 100644
> --- a/include/qemu/cacheflush.h
> +++ b/include/qemu/cacheflush.h
> @@ -19,7 +19,8 @@
>    * mappings of the same physical page(s).
>    */
>   
> -#if defined(__i386__) || defined(__x86_64__) || defined(__s390__)
> +#if defined(__i386__) || defined(__x86_64__) || defined(__s390__) \
> +    || defined(EMSCRIPTEN)
>   
>   static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
>   {
> diff --git a/util/cacheflush.c b/util/cacheflush.c
> index 1d12899a39..e5aa256cd8 100644
> --- a/util/cacheflush.c
> +++ b/util/cacheflush.c
> @@ -225,7 +225,8 @@ static void __attribute__((constructor)) init_cache_info(void)
>    * Architecture (+ OS) specific cache flushing mechanisms.
>    */
>   
> -#if defined(__i386__) || defined(__x86_64__) || defined(__s390__)
> +#if defined(__i386__) || defined(__x86_64__) || defined(__s390__) || \
> +    defined(EMSCRIPTEN)
>   
>   /* Caches are coherent and do not require flushing; symbol inline. */
>   


