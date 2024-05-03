Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A0FC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2s40-0005Ro-6c; Fri, 03 May 2024 08:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2s3y-0005R2-GZ
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:30:54 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2s3w-0001uN-5F
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:30:53 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-34b3374ae22so8361919f8f.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714739450; x=1715344250; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+nMNNnAgBRB+ChHoZlko84e6X/f/t45Atlf2KxHDO8U=;
 b=d/R3CdW5pbw1Ex9qGA3E70qHVxm3MSAMOzbbRCArehzeLnSJXcfmsDcqRaTCzEH6jl
 z1ScxUqYOJ+KAuLlv5MBSJOwX/f2ZDTQiCiO6shiscY1bnqg8sAaC8CEs3gqM2PG8M1e
 XX9zYbviwDvxq20T64L1Eocr9NMi1lWXh27sJj7LZFBBtavuHAvXVht1dW4Rope15xew
 gxF+RcSzbxvXXDosRvkQh7RhAwEJ1JZVVeYY5g1jHkuLPHn2hzLvbykRUL6DU6DTtPeE
 L7v/au+V0f4lya0cY257yysiS39kh/SkDXWdlo3uxTGM1gp/QxdXTVsHg3sm8XZrgGwC
 V5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714739450; x=1715344250;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+nMNNnAgBRB+ChHoZlko84e6X/f/t45Atlf2KxHDO8U=;
 b=dW6VKGu1yi7pRR69lzmX9/gau0Np/GzXpZf0ZpzR87RS2ENqQqp1nCNQ3DPBIgWGSj
 D9bW+cwBs53L4Am1C6snXEItxM8g/uNLK08FguA8nUAXoJAiec0lJ9st0edSQ6Zc5p2b
 DTj6JybA+S+UrCzdH0OzGFzxiI8kSXLvGNX/A+xZSjtf0n7SRtyJ8f9rws3dOZXjtBQA
 dwPTbHoa8FOnyobu7owWUfZV7g/9dhnfJ1Lba6eENczOZWwz2GyRARwTK5xmWpbCbUma
 qa/E8IF3Ysg5D8VpcVCWngf8+1x0AhbzPI0V2XbZARZmHzXADw651VAQdexTX8FYiDAn
 jQcw==
X-Gm-Message-State: AOJu0Yw1/MDUKvl/lz19xU3CDMhxgGNIDpSh0ENTh02MbRmwQFgRSSRx
 21tVWyZ8FYJz/Wv/llTFTgZAPJ9ssDt/+QxxPw5VPDXEX1kNBa8MunZ2sUZqCbMEMGPchEjYXNG
 h
X-Google-Smtp-Source: AGHT+IE9ntCfVQPS9LQ20n+zgYm0Bu4zDdwAO0p314OXgqhUo3EYhjC8x0h4R1826g+rqGCSCfzZKg==
X-Received: by 2002:adf:e4c3:0:b0:34d:8fac:9540 with SMTP id
 v3-20020adfe4c3000000b0034d8fac9540mr2184768wrm.59.1714739450123; 
 Fri, 03 May 2024 05:30:50 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a056000000100b0034e0b56a62bsm3650134wrx.44.2024.05.03.05.30.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 05:30:49 -0700 (PDT)
Message-ID: <f616fcef-efd9-40f2-a2bb-916ef2f17174@linaro.org>
Date: Fri, 3 May 2024 14:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] accel/tcg: Move system emulation files under
 sysemu/ subdirectory
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, Kyle Evans <kevans@freebsd.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Warner Losh <imp@bsdimp.com>,
 Riku Voipio <riku.voipio@iki.fi>
References: <20240503122526.28312-1-philmd@linaro.org>
 <20240503122526.28312-2-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240503122526.28312-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 3/5/24 14:25, Philippe Mathieu-Daudé wrote:
> Some files are specific to system emulation. Move them under
> their own sysemu/ directory. This might help to notice what
> is affected (user, system or both) when doing global refactors.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/{ => sysemu}/tcg-accel-ops-icount.h |  0
>   accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.h  |  0
>   accel/tcg/{ => sysemu}/tcg-accel-ops-rr.h     |  0
>   accel/tcg/{ => sysemu}/tcg-accel-ops.h        |  0
>   accel/tcg/{ => sysemu}/icount-common.c        |  0
>   accel/tcg/{ => sysemu}/monitor.c              |  4 ++--
>   accel/tcg/{ => sysemu}/tcg-accel-ops-icount.c |  0
>   accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.c  |  0
>   accel/tcg/{ => sysemu}/tcg-accel-ops-rr.c     |  0
>   accel/tcg/{ => sysemu}/tcg-accel-ops.c        |  0
>   accel/tcg/meson.build                         | 14 ++------------
>   accel/tcg/sysemu/meson.build                  | 11 +++++++++++
>   12 files changed, 15 insertions(+), 14 deletions(-)
>   rename accel/tcg/{ => sysemu}/tcg-accel-ops-icount.h (100%)
>   rename accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.h (100%)
>   rename accel/tcg/{ => sysemu}/tcg-accel-ops-rr.h (100%)
>   rename accel/tcg/{ => sysemu}/tcg-accel-ops.h (100%)
>   rename accel/tcg/{ => sysemu}/icount-common.c (100%)
>   rename accel/tcg/{ => sysemu}/monitor.c (99%)
>   rename accel/tcg/{ => sysemu}/tcg-accel-ops-icount.c (100%)
>   rename accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.c (100%)
>   rename accel/tcg/{ => sysemu}/tcg-accel-ops-rr.c (100%)
>   rename accel/tcg/{ => sysemu}/tcg-accel-ops.c (100%)
>   create mode 100644 accel/tcg/sysemu/meson.build


> diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
> index aef80de967..1b91f26a7f 100644
> --- a/accel/tcg/meson.build
> +++ b/accel/tcg/meson.build
> @@ -18,19 +18,9 @@ if get_option('plugins')
>   endif
>   specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
>   
> -specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
> +specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files( # SoftMMU
>     'cputlb.c',
>     'watchpoint.c',
>   ))
>   
> -system_ss.add(when: ['CONFIG_TCG'], if_true: files(
> -  'icount-common.c',
> -  'monitor.c',
> -))
> -
> -tcg_module_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
> -  'tcg-accel-ops.c',
> -  'tcg-accel-ops-mttcg.c',
> -  'tcg-accel-ops-icount.c',
> -  'tcg-accel-ops-rr.c',
> -))
> +subdir('sysemu')
> diff --git a/accel/tcg/sysemu/meson.build b/accel/tcg/sysemu/meson.build
> new file mode 100644
> index 0000000000..d0b4939ba9
> --- /dev/null
> +++ b/accel/tcg/sysemu/meson.build
> @@ -0,0 +1,11 @@
> +system_ss.add(files(

Oops, broken rebase, sorry...

> +  'icount-common.c',
> +  'monitor.c',
> +))
> +
> +tcg_module_ss.add(when: ['CONFIG_SYSTEM_ONLY'], if_true: files(
> +  'tcg-accel-ops.c',
> +  'tcg-accel-ops-mttcg.c',
> +  'tcg-accel-ops-icount.c',
> +  'tcg-accel-ops-rr.c',
> +))


