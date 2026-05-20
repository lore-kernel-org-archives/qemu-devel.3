Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F105FCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPabH-0000hn-55; Wed, 20 May 2026 02:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wPabE-0000hE-O5
 for qemu-devel@nongnu.org; Wed, 20 May 2026 02:40:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wPabC-0007Vi-3f
 for qemu-devel@nongnu.org; Wed, 20 May 2026 02:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779259208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GBAD0RuLrrerokz179hG/ZU7wTiXcyph9yVZ+GLi6Xo=;
 b=iio7Xbuj9JBpZT+bHj2MYfqRK0R9Ckjq9NvN6PhphOXvzSnYerfJtZ1M7jSOYdCVIs+kgu
 eSyXZwi9LQf+KOx/Kve01nu0WMrdsuFHyVkiXEzIx/IGbinlqpS3DJv26aSZaXCoqZ9a+t
 kiWt+U4eF+1s2JXy+Llg9NeSf7iHYZo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-gHa_lilIPQO-lQLwbgjEwg-1; Wed, 20 May 2026 02:40:06 -0400
X-MC-Unique: gHa_lilIPQO-lQLwbgjEwg-1
X-Mimecast-MFC-AGG-ID: gHa_lilIPQO-lQLwbgjEwg_1779259205
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48fde68e420so40233155e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 23:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779259205; x=1779864005; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=GBAD0RuLrrerokz179hG/ZU7wTiXcyph9yVZ+GLi6Xo=;
 b=KtUvbMJKaJm8f4XbQm1nVArc+aHQbBy8eW2fOmYubxBg2JfmLlmRh8U819QCw3R+zo
 4kv0HsnUW2yQ+dd2LpTVjt9myqF3rXk7JwBO4cwfK/ocJlaSZMC+w9YFCwbtBuqdr4jO
 vl1RCqUou7EDYXydZDotF9k9J6qf73zWWll1gtn4Ona+1Ow6NOULplECdThGuVhgea4i
 2pcL4taGBYUCiowSJzocwSNA/453YqH6GXdxNs0igNc3+0rHFBRpWdmVpoCEfBWC+jrN
 3+4oZgrbKbhy8ogHgq0+FBJvT2icsBzjghhHwTuov8zxUAkzgIR78SCOJgcU+MQoa+Bl
 pn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779259205; x=1779864005;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBAD0RuLrrerokz179hG/ZU7wTiXcyph9yVZ+GLi6Xo=;
 b=nrH5NEjge6VbJg5Kh6PCBbZdjFcJYzDC2+Hw9iVCVsbfvxxO48Be7jHnRT/Lf6QTJH
 UQkglyGzOlRTGtBpbTrvCcCgrhaCAOsx8BJ+4ACXNldK5RYCIkg3KKGxRHDmcxca7qud
 8WOISUMp8K2KD0ckoM/SioNnzpjnebGw0ubFFU3Iz9Me6O+dLoth0AIi6ZoutltTYr4H
 ty2agLuvLMocSEtbPohH7Z6M/7HspY8bEm/oUgrmSfkN0DmiiP7c/Nv+J8W8M4CU9XDG
 m0YqxYV2Fcb+yKB/+e5toosKer4clFN4Mw73UWJyPTkTh5ouix2mWlxXBwR/Rvpq8HFW
 pCOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9nbwwc9KS1QqLP7FW++tIstNVQjKKvVCjmmYAMsxC5DF+P+62fftwmtIPXW26DLCqzlGh5b0Gdqcc3@nongnu.org
X-Gm-Message-State: AOJu0Yy0ar8PeaSTNH4jNMITDwBBGPkaoMSBZ9kFX0eQgA62HwL/68Ws
 qe3fYmnjm7TCPXjGd/yJ4rfRIbhlbSNn+HwgxWteHh6kPtC+MSTnvYxtedeuGrr9pzu2CW3ZwN5
 LwxCTgGS6AUvqy33LE5hMvNlD7x8E19F5T1o5T5vDqT8juuFND3CNRVht
X-Gm-Gg: Acq92OEh0KH/n7KRnzssg1NZGOtvyLi6xuxE4tG2HCzOBOv22H04C8DYcemPmnr7x3v
 leR8yGprdB85oEhErp8IQH/vxpK9IrOETGNNiwb2oYbRa7+ma6pzJ+hMSmXeBqmlQXQ4uhAAOfT
 YXgVKKo8Y6SSeJNSz682okQ/AebGHHkJJUeRah45+u8Zo+bcSFP6e1Ca4tteZ0mffWGGe4SI8iy
 fzRL1Q8UdlKtjw8KNUaR2JiqbKIYSEG3CAcFHNoX1Xo/TiIj1lUVZatnJLey42j+kvGwTCqS9z0
 evZCDm2TLeHSyuoiFIG0m7KbIigdjzmHptEmBjpk2tGuWkM40WcwLM3t4wRVUvdWo2uEAjbQLPW
 Tk/1LkOFSkavZ5DRbiWo+0Nye++DGkA==
X-Received: by 2002:a05:600c:c494:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-48fe60ed839mr332950175e9.11.1779259204939; 
 Tue, 19 May 2026 23:40:04 -0700 (PDT)
X-Received: by 2002:a05:600c:c494:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-48fe60ed839mr332949675e9.11.1779259204468; 
 Tue, 19 May 2026 23:40:04 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19b1dsm50706363f8f.17.2026.05.19.23.40.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 23:40:03 -0700 (PDT)
Message-ID: <aef85a21-180e-4bf5-9528-c9394cb261d4@redhat.com>
Date: Wed, 20 May 2026 08:40:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] buildsys: Stop checking for ESA/390 host
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org
References: <20260519171240.97420-1-philmd@linaro.org>
 <20260519171240.97420-4-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260519171240.97420-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 19/05/2026 19.12, Philippe Mathieu-Daudé wrote:
> We still build QEMU tools on 32-bit hosts (see commit
> cf634dfcd8f), however no OS supported by QEMU still runs
> on ESA/390 (Linux dropped support in release 4.1 in 2015).

Technically, the 64-bit Linux kernels on IBM Z still supported 32-bit 
userspace until recently:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e0b986c59c67e08ada646249f834655a9e6da16

... which got released with Linux v6.19. So there theoretically could still 
be Linux distros around that use a 64-bit kernel with a 32-bit userspace. 
Practically, I haven't seens such a setup in ages, so I think it is safe to 
go ahead with this patch.

Thus:
Reviewed-by: Thomas Huth <thuth@redhat.com>


> Remove the configure check, directly checking for the 64-bit
> z/Architecture.
> 
> Also per commit 3704993f545 from 2020:
> 
>    "we don't support s390, only 64-bit s390x hosts".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   configure                 | 12 ++----------
>   include/qemu/cacheflush.h |  2 +-
>   include/qemu/timer.h      |  2 +-
>   block/file-posix.c        |  2 +-
>   disas/disas-host.c        |  2 +-
>   util/cacheflush.c         |  2 +-
>   6 files changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/configure b/configure
> index eea90306728..513ef7a153d 100755
> --- a/configure
> +++ b/configure
> @@ -401,12 +401,8 @@ elif check_define _ARCH_PPC64 ; then
>     fi
>   elif check_define __mips64 ; then
>     cpu="mips64"
> -elif check_define __s390__ ; then
> -  if check_define __s390x__ ; then
> -    cpu="s390x"
> -  else
> -    cpu="s390"
> -  fi
> +elif check_define __s390x__ ; then
> +  cpu="s390x"
>   elif check_define __riscv && check_define _LP64 ; then
>     cpu="riscv64"
>   elif check_define __aarch64__ ; then
> @@ -469,10 +465,6 @@ case "$cpu" in
>       linux_arch=riscv
>       ;;
>   
> -  s390)
> -    linux_arch=s390
> -    CPU_CFLAGS="-m31"
> -    ;;
>     s390x)
>       host_arch=s390x
>       linux_arch=s390
> diff --git a/include/qemu/cacheflush.h b/include/qemu/cacheflush.h
> index 8c64b878145..0618966ddde 100644
> --- a/include/qemu/cacheflush.h
> +++ b/include/qemu/cacheflush.h
> @@ -19,7 +19,7 @@
>    * mappings of the same physical page(s).
>    */
>   
> -#if defined(__x86_64__) || defined(__s390__)
> +#if defined(__x86_64__) || defined(__s390x__)
>   
>   static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
>   {
> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> index b931181f53d..fc021f8f966 100644
> --- a/include/qemu/timer.h
> +++ b/include/qemu/timer.h
> @@ -889,7 +889,7 @@ static inline int64_t cpu_get_host_ticks(void)
>       return val;
>   }
>   
> -#elif defined(__s390__)
> +#elif defined(__s390x__)
>   
>   static inline int64_t cpu_get_host_ticks(void)
>   {
> diff --git a/block/file-posix.c b/block/file-posix.c
> index e49b13d6abb..5019ddade9b 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -79,7 +79,7 @@
>   #include <linux/hdreg.h>
>   #include <linux/magic.h>
>   #include <scsi/sg.h>
> -#ifdef __s390__
> +#ifdef __s390x__
>   #include <asm/dasd.h>
>   #endif
>   #ifndef FS_NOCOW_FL
> diff --git a/disas/disas-host.c b/disas/disas-host.c
> index 7cf432938e0..d41235250a0 100644
> --- a/disas/disas-host.c
> +++ b/disas/disas-host.c
> @@ -74,7 +74,7 @@ static void initialize_debug_host(CPUDebug *s)
>       s->info.print_insn = print_insn_little_mips;
>   #elif defined(__m68k__)
>       s->info.print_insn = print_insn_m68k;
> -#elif defined(__s390__)
> +#elif defined(__s390x__)
>       s->info.cap_arch = CS_ARCH_SYSZ;
>       s->info.cap_insn_unit = 2;
>       s->info.cap_insn_split = 6;
> diff --git a/util/cacheflush.c b/util/cacheflush.c
> index c043c5f881a..77440ddb478 100644
> --- a/util/cacheflush.c
> +++ b/util/cacheflush.c
> @@ -223,7 +223,7 @@ static void __attribute__((constructor)) init_cache_info(void)
>    * Architecture (+ OS) specific cache flushing mechanisms.
>    */
>   
> -#if defined(__x86_64__) || defined(__s390__)
> +#if defined(__x86_64__) || defined(__s390x__)
>   
>   /* Caches are coherent and do not require flushing; symbol inline. */
>   


