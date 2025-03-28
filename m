Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC879C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyGGI-0006uw-8C; Fri, 28 Mar 2025 16:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyGG2-0006sf-Rn
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:24:52 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyGG0-0002S9-ML
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:24:50 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac25520a289so425105866b.3
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743193486; x=1743798286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X7Cjfym3N9vQnj3/Y3zynJAH23nXoGKBjXJlj8Bhj1E=;
 b=Bb7k9zVcRxnLJ2ixF+x2WM34blNgYMC4TROoGevCwamAr1pQuHD3HLqcSfFF3hShOn
 2TeamcFrA3urK0bUKSOtJJB5HyuYzI0tcrBcW/WLrK6VGiMb0O0b8kNh5p8q+x4Otabx
 XXCDmYaHDVjOChwBmi9P3/Ao6QegeGD5/y3Fn/8JvQEpVHGLZtNxJ7WOxs6W+KPP5XJh
 hmJCd/SJVjquav3RKy/N4EEpOwKrAOJu7iSEZyToklPaHy7Jn671qj+RGHTLdUjAU8lc
 fQ7GeL+d3BdCz4k0jOaQTKga3VLxb+3pdXxBCDoSvKhWI4l9J7xsfmxPBZg+61jwf+RN
 iDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743193486; x=1743798286;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X7Cjfym3N9vQnj3/Y3zynJAH23nXoGKBjXJlj8Bhj1E=;
 b=uZdgiDvKBReGVMUPCNkBYRyFca90JUNhB4mYhbkzsa2KL1gUEjna1xpLAzD0op+Z7D
 LdtXVB0SUb/JajTnP3/bOvcY0l8ozCMW2DiATfO4DYqlt4nigl3P7hMqLtEg29Vdxu+h
 3cCuYB95jDJVe0okM7Ux8rvz5nM9Aat/klktYyPKL47QB3qa32UN/QGSYbJPv/COOAQM
 enZCh9knWGNOCWgLxl1ov36c+72N7sTRF1WBpGpIZaEDyXuTaiTaneq53Jwh+y4x+kP4
 pn6AlBh3SwORl5asgOMYv64FjmiCT+pUdMEwYnoYd/9Vc/7MQGgDIELzZqypvOf+wEfw
 nqtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWQmLkM9TakXnpsEbSzYWVi50X3tOnymEl+yQ9aMvIGvMH3Eh6Cfmm4n0PUx59UDpHQDYucCZ9OB2l@nongnu.org
X-Gm-Message-State: AOJu0YwJ9Nat9jynJTflBIAtedQQbC8z4Vb47XKIvHLnfN1lyE5Mpl7T
 JDAz8NRz3kQVBAH1Djn5VRlHgexPVSXo99Ajr6PhZlENtfh4K4E6HLTNeVXTFvM=
X-Gm-Gg: ASbGncuRYxmmk2ZrW1r5BOZ5W0zS4Gfv4gwf0eXKEHZclSUmo6Z8aqRzedGC6YQNlw/
 xgl3b8X0ZPxqci6YrRNHAEybIh+LZqxV8BebprGUA3VoSigHUNjdb0XlbCPWaA0T8YVJ/Ecq8Mk
 AFx4jqshYwwEdySZzddFU17E0On1g/jt4+HkAKiwv5DxpDx+JyVaXGYcYzEWXsMKurKvbd4arC8
 IwEez6gz6vrvRirKh/Iz3Og0/5aIzRejSNladLCl1SSGg8VXNctZYjYiDDAyrlCtvmXRXnSUB4w
 yXFKkjOEPrFIzP/jX3RGStWEfTUV+Bz3BrCKm7nwVjo/0CtpkQLMJ0OjZQo=
X-Google-Smtp-Source: AGHT+IEc8A5E37Y1rNmbmmOOO4J6AhG7FNIq6s1f4Xs0+tZQp5o4701ssY+fPyG23jDJOSucFDktZg==
X-Received: by 2002:a17:907:3e1d:b0:ac3:8537:903c with SMTP id
 a640c23a62f3a-ac738bc07d7mr42370566b.37.1743193486463; 
 Fri, 28 Mar 2025 13:24:46 -0700 (PDT)
Received: from [10.154.28.14] ([193.32.126.156])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac719223e42sm209700166b.22.2025.03.28.13.24.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 13:24:45 -0700 (PDT)
Message-ID: <5609e7a2-5b7e-4d92-900a-78419176f710@linaro.org>
Date: Fri, 28 Mar 2025 13:24:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] accel/tcg: Build translator.c twice
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250328200459.483089-1-richard.henderson@linaro.org>
 <20250328200459.483089-6-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250328200459.483089-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ej1-x633.google.com
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

On 3/28/25 13:04, Richard Henderson wrote:
> Drop some unnecessary includes.  Change the offsetof expressions
> to be based on CPUState instead of ArchCPU.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/translator.c | 14 ++++++--------
>   accel/tcg/meson.build  |  2 +-
>   2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 307a513487..36a6a9e040 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -11,14 +11,13 @@
>   #include "qemu/bswap.h"
>   #include "qemu/log.h"
>   #include "qemu/error-report.h"
> -#include "exec/exec-all.h"
>   #include "exec/cpu-ldst-common.h"
>   #include "exec/cpu-mmu-index.h"
> +#include "exec/target_page.h"
>   #include "exec/translator.h"
>   #include "exec/plugin-gen.h"
>   #include "tcg/tcg-op-common.h"
>   #include "internal-common.h"
> -#include "internal-target.h"
>   #include "disas/disas.h"
>   #include "tb-internal.h"
>   
> @@ -26,8 +25,7 @@ static void set_can_do_io(DisasContextBase *db, bool val)
>   {
>       QEMU_BUILD_BUG_ON(sizeof_field(CPUState, neg.can_do_io) != 1);
>       tcg_gen_st8_i32(tcg_constant_i32(val), tcg_env,
> -                    offsetof(ArchCPU, parent_obj.neg.can_do_io) -
> -                    offsetof(ArchCPU, env));
> +                    offsetof(CPUState, neg.can_do_io) - sizeof(CPUState));
>   }
>   
>   bool translator_io_start(DisasContextBase *db)
> @@ -50,8 +48,8 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
>       if ((cflags & CF_USE_ICOUNT) || !(cflags & CF_NOIRQ)) {
>           count = tcg_temp_new_i32();
>           tcg_gen_ld_i32(count, tcg_env,
> -                       offsetof(ArchCPU, parent_obj.neg.icount_decr.u32)
> -                       - offsetof(ArchCPU, env));
> +                       offsetof(CPUState, neg.icount_decr.u32) -
> +                       sizeof(CPUState));
>       }
>   
>       if (cflags & CF_USE_ICOUNT) {
> @@ -80,8 +78,8 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
>   
>       if (cflags & CF_USE_ICOUNT) {
>           tcg_gen_st16_i32(count, tcg_env,
> -                         offsetof(ArchCPU, parent_obj.neg.icount_decr.u16.low)
> -                         - offsetof(ArchCPU, env));
> +                         offsetof(CPUState, neg.icount_decr.u16.low) -
> +                         sizeof(CPUState));
>       }
>   
>       return icount_start_insn;
> diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
> index 72d4acfe5e..047afa49a2 100644
> --- a/accel/tcg/meson.build
> +++ b/accel/tcg/meson.build
> @@ -8,6 +8,7 @@ tcg_ss.add(files(
>     'cpu-exec-common.c',
>     'tcg-runtime.c',
>     'tcg-runtime-gvec.c',
> +  'translator.c',
>   ))
>   if get_option('plugins')
>     tcg_ss.add(files('plugin-gen.c'))
> @@ -22,7 +23,6 @@ tcg_specific_ss.add(files(
>     'cpu-exec.c',
>     'tb-maint.c',
>     'translate-all.c',
> -  'translator.c',
>   ))
>   tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
>   specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


