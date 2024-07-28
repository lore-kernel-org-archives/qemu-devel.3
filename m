Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A245C3DA49
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2024 04:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXvoB-0002Ac-FC; Sun, 28 Jul 2024 00:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sXvo7-00029v-Ch
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 00:46:55 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sXvo4-0003Gq-SA
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 00:46:54 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3db14339fb0so1641865b6e.2
 for <qemu-devel@nongnu.org>; Sat, 27 Jul 2024 21:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722142011; x=1722746811; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7PBv64QaV50w/iIkbRFuup+KBGsJycrBE5wO5wuRf3U=;
 b=lm1t3vXAEqqnxrQ1vbhkL3yYTPm2ScJPwL2TTpHOcIpJfRf6HKWKNwyZJQcC6/B5JN
 9rzaLt05Yc+fQEjh9eBLQ6bOP8djoRErbrO4tUldCcN/VFc/RNfmWPkv3q+mo905emHk
 W2V1isLf5yopeMT+THwVNKuwaN3EjSO/4a83PMCMjkGznt8WjL7pG/0xoMIS5PsrUDgH
 biDU1rC9iql43rVuh2ppQSEBY+ieXvkLwCx5MPVAAKB9zq0lp9yeN4BWMTTVrTL7eGoF
 9188W3N4sJnnjjFIp8mp4rtJSo3JhD6sJ/E3fVgGhHFmuJxJHsa33Puxj6SnZ1Cygdwr
 uDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722142011; x=1722746811;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7PBv64QaV50w/iIkbRFuup+KBGsJycrBE5wO5wuRf3U=;
 b=aHpR28UONT++BxnyKwdWbOs/Fc7hb4vkarqbL5PLXX7dRiMkn+nlfRuocNKv3QmvvG
 o6D8a5+YNKHhTFpWdoWOJgEjfFmJYKgv6VcRx5tVTlzS5Fnk3u2lyVG7w7eUk94nd5ng
 7c/AD7pfE7U6lvVcA7NWRdkmOt5uSdSvP7c3Gar5i7mqHBogVnE6iX0XzzRiLAs0hnpU
 YT7Bol6YnkiAgiSI8yIN1Lp2CfIhTv1o2nb0DBRR75AuNIvpOEsQM3LsDrAka7hxCj04
 OFjw7Felj8XmwyN/eh05fMIAhj/eOiT8ocFY3FKxge4OVnD9ni59v+JDpR41jXdEY7NC
 yFKQ==
X-Gm-Message-State: AOJu0YzZZ6ERlttM98A2hsMZS5ygJ3MaCezAsJ4v6efNmxapqjz+3/xO
 YYfLlflJNgDtS82KEOmR1aqveCNzHLn+HIgaTSQMEFL3unHM5uUlpEWykUJX0dU=
X-Google-Smtp-Source: AGHT+IHeAT3N0efzawCL9XFcLS2HEp1xYqmg4dgdkjVNrE8dF/mUUMUzCMQ8wAA6GES+8IJw78Nlig==
X-Received: by 2002:a05:6808:1495:b0:3db:1af0:9ae6 with SMTP id
 5614622812f47-3db23cb46f6mr6739960b6e.47.1722142010719; 
 Sat, 27 Jul 2024 21:46:50 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7f7b092sm58507095ad.246.2024.07.27.21.46.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jul 2024 21:46:50 -0700 (PDT)
Message-ID: <a24ca515-113a-4f1b-b746-67034eee0693@linaro.org>
Date: Sun, 28 Jul 2024 14:46:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/cpuinfo: Make use of elf_aux_info(3) on OpenBSD
To: Brad Smith <brad@comstyle.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <ZqXB_zz0fR1CpA7k@humpty.home.comstyle.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZqXB_zz0fR1CpA7k@humpty.home.comstyle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

On 7/28/24 13:58, Brad Smith wrote:
> util/cpuinfo: Make use of elf_aux_info(3) on OpenBSD
> 
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>   meson.build            | 8 ++++++++
>   util/cpuinfo-aarch64.c | 9 ++++++---
>   util/cpuinfo-ppc.c     | 5 +++--
>   util/getauxval.c       | 2 +-
>   4 files changed, 18 insertions(+), 6 deletions(-)

Is this specifically better than sysctl for cpuinfo-aarch64.c?
Otherwise, I'm happy with the getauxval.c and cpuinfo-ppc.c changes.


r~

> 
> diff --git a/meson.build b/meson.build
> index 5613b62a4f..97f63aa86c 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2835,6 +2835,14 @@ config_host_data.set('CONFIG_GETAUXVAL', cc.links(gnu_source_prefix + '''
>       return getauxval(AT_HWCAP) == 0;
>     }'''))
>   
> +config_host_data.set('CONFIG_ELF_AUX_INFO', cc.links(gnu_source_prefix + '''
> +  #include <sys/auxv.h>
> +  int main(void) {
> +    unsigned long hwcap = 0;
> +    elf_aux_info(AT_HWCAP, &hwcap, sizeof(hwcap));
> +    return hwcap;
> +  }'''))
> +
>   config_host_data.set('CONFIG_USBFS', have_linux_user and cc.compiles('''
>     #include <linux/usbdevice_fs.h>
>   
> diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
> index 8ca775a14b..57468890c3 100644
> --- a/util/cpuinfo-aarch64.c
> +++ b/util/cpuinfo-aarch64.c
> @@ -17,10 +17,13 @@
>   #  define HWCAP2_BTI 0  /* added in glibc 2.32 */
>   # endif
>   #endif
> +#ifdef CONFIG_ELF_AUX_INFO
> +#include <sys/auxv.h>
> +#endif
>   #ifdef CONFIG_DARWIN
>   # include <sys/sysctl.h>
>   #endif
> -#ifdef __OpenBSD__
> +#if defined(__OpenBSD__) && !defined(CONFIG_ELF_AUX_INFO)
>   # include <machine/armreg.h>
>   # include <machine/cpu.h>
>   # include <sys/types.h>
> @@ -61,7 +64,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>   
>       info = CPUINFO_ALWAYS;
>   
> -#ifdef CONFIG_LINUX
> +#if defined(CONFIG_LINUX) || defined(CONFIG_ELF_AUX_INFO)
>       unsigned long hwcap = qemu_getauxval(AT_HWCAP);
>       info |= (hwcap & HWCAP_ATOMICS ? CPUINFO_LSE : 0);
>       info |= (hwcap & HWCAP_USCAT ? CPUINFO_LSE2 : 0);
> @@ -78,7 +81,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>       info |= sysctl_for_bool("hw.optional.arm.FEAT_PMULL") * CPUINFO_PMULL;
>       info |= sysctl_for_bool("hw.optional.arm.FEAT_BTI") * CPUINFO_BTI;
>   #endif
> -#ifdef __OpenBSD__
> +#if defined(__OpenBSD__) && !defined(CONFIG_ELF_AUX_INFO)
>       int mib[2];
>       uint64_t isar0;
>       uint64_t pfr1;
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
>   #include <sys/auxv.h>
>   
>   unsigned long qemu_getauxval(unsigned long type)


