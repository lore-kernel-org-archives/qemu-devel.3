Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729FDC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 09:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYMp4-00082G-0G; Mon, 29 Jul 2024 05:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYMp2-0007vh-73
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:37:40 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYMp0-0002wE-0e
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:37:39 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-368440b073bso973349f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 02:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722245856; x=1722850656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sCWkVcHeruDkGrPDh/mRpleBIy3RLpqFEp1Iz7K2KW0=;
 b=E8lGZwaY/2k+Yrn0gIcQKlrwRoeedWgq6tGynfink0C4ZKjKeHQxop9zNrAqoZGHIC
 wWgbtazuHlgDq+TThqKLgoaeK37XIVM0WkrJTYM+Dmdqb/5HSM6Yh2+/RUPCyshnj/ww
 xb+C037qZ0BjfatI6YUbYk/STkpBkmDKeBVwoUatRHyo7m/kwsPD8ORryz7VLIVJwkUU
 XSJKKnNZhTVuZdHgTzDTk9uhPu4Ot8dGVuqSVD3JtneLgTvVLDYpA+MC4DByp/QHUkPd
 ruhXsOfLWGtM+Y3oQI78EEB5dQCsQXTQl4ljVIlkNIObLSMxipmV9e7FhB8nZ+asqcmS
 ebNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722245856; x=1722850656;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sCWkVcHeruDkGrPDh/mRpleBIy3RLpqFEp1Iz7K2KW0=;
 b=O5jcIqL+iTj5sOSKsmmNkNMl1Q5pOA7YtB9tgJzxplDs0U4A2n99aLXoxHwIv5708L
 KcAlkaKapHCCjvDg/RfcXWZ3q+4yKF9JBq22MJw2HgTOzW8zhXbWusgAO2NQ9OiKugqp
 ISqND8Rf98Yl3WTu9+0necBnHFHtA3pM16VnT1EFBhl06n23tXMmPqtma3jnaHx8BAWZ
 Ru2tuvKOeF3J8YN4+tEA8EO7L5JOXBEGhfPrux4Wc5fYL+hrNtLsf74v0klmapPP6hEa
 /5xof8ZfRpEAZW5eX/KQm40zcfCJH/iOjsfgCFx/W0oRNOyGcX67uM5mFUup5rSrRG14
 VB3w==
X-Gm-Message-State: AOJu0YwYWll6COB8lKaF6QT62U7iwiwpiOrpO1mJiXHYFTvnOHv9+85M
 6yHsfGE6/GGAZQQYUUU5/5+6/mF/Lc8U429LEJhOppTvZy0kT8hkhZMLBimd4pU=
X-Google-Smtp-Source: AGHT+IHacmmssRod2OeVfXmkzB+5gt7LfTOlKhrYcr2pQdtHdb4PHC3OHqdz6TdMRSbuCKkZRmncCQ==
X-Received: by 2002:adf:c08b:0:b0:368:4ab0:b260 with SMTP id
 ffacd0b85a97d-36b5d7cfbcamr3776803f8f.18.1722245855653; 
 Mon, 29 Jul 2024 02:37:35 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367fcb78sm11764565f8f.53.2024.07.29.02.37.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 02:37:35 -0700 (PDT)
Message-ID: <61229356-940e-41f2-9b7c-0d1642c6415c@linaro.org>
Date: Mon, 29 Jul 2024 11:37:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/cpuinfo: Make use of elf_aux_info(3) on OpenBSD
To: Brad Smith <brad@comstyle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <ZqXB_zz0fR1CpA7k@humpty.home.comstyle.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZqXB_zz0fR1CpA7k@humpty.home.comstyle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Hi Brad,

On 28/7/24 05:58, Brad Smith wrote:
> util/cpuinfo: Make use of elf_aux_info(3) on OpenBSD
> 
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>   meson.build            | 8 ++++++++
>   util/cpuinfo-aarch64.c | 9 ++++++---
>   util/cpuinfo-ppc.c     | 5 +++--
>   util/getauxval.c       | 2 +-
>   4 files changed, 18 insertions(+), 6 deletions(-)


> diff --git a/util/cpuinfo-ppc.c b/util/cpuinfo-ppc.c
> index 1304f9aa80..ccfcaa0754 100644
> --- a/util/cpuinfo-ppc.c
> +++ b/util/cpuinfo-ppc.c
> @@ -14,7 +14,8 @@
>   #  include "elf.h"
>   # endif
>   #endif
> -#ifdef __FreeBSD__
> +#if defined(CONFIG_ELF_AUX_INFO)
> +# include <sys/auxv.h>
>   # include <machine/cpu.h>
>   # ifndef PPC_FEATURE2_ARCH_3_1
>   #  define PPC_FEATURE2_ARCH_3_1   0
> @@ -35,7 +36,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>   
>       info = CPUINFO_ALWAYS;
>   
> -#if defined(CONFIG_LINUX) || defined(__FreeBSD__)
> +#if defined(CONFIG_LINUX) || deinfed(CONFIG_ELF_AUX_INFO)

Typo!

>       unsigned long hwcap = qemu_getauxval(AT_HWCAP);
>       unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
>   
> diff --git a/util/getauxval.c b/util/getauxval.c
> index b124107d61..5bdbb04f8f 100644
> --- a/util/getauxval.c
> +++ b/util/getauxval.c
> @@ -98,7 +98,7 @@ unsigned long qemu_getauxval(unsigned long type)
>       return 0;
>   }
>   
> -#elif defined(__FreeBSD__)
> +#elif deinfed(CONFIG_ELF_AUX_INFO)

Same typo, has this patch been tested?

>   #include <sys/auxv.h>
>   
>   unsigned long qemu_getauxval(unsigned long type)

Except typos, code LGTM, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


