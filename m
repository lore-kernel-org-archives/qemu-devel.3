Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4423CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 16:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSH5B-0001ih-KB; Wed, 27 May 2026 12:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSH59-0001iK-Tf
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:26:11 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSH58-0001Sy-8C
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:26:11 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3684a6f3b0bso5925439a91.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 09:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779899168; x=1780503968; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=raPv35VFx65G4bNurRSKoQmaqVPNMgQIU+QDlQiy3OY=;
 b=ZGw05c0mGi7qEd0V0URRIvsGV/HPpfDNtdzPCKfNTEUoOzcrx71l8WjKY6GQdzQegx
 hq6zjJIxRqLEStOn7dluxfnFhHU2JjLwSn3qiclb8WFtnjomi/ujWNCaRioyS0RbPfOP
 dz5ho9M/Tpehp8P+ONZybVhDRCOA8+CMGtjPUpDhTJCIWBUgyDFQ8h5NxXGt1ZWtNaeN
 A6tYVOAzi5HpiXU31KAMBlRLnFCcob0j0w4P+QGBz4BRSGTD7/LTWN73O7iHzbo+fD0P
 6EtB1LgUK8mJX17WfTzW71V1iGM3zcdl0J4sPyXRKh7IZxMjXcXpwFcu49tKHLsZVSeO
 4lwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779899168; x=1780503968;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=raPv35VFx65G4bNurRSKoQmaqVPNMgQIU+QDlQiy3OY=;
 b=D0tfFtH1MA+q1WvexAnnQcuhBN/8Md1bWiiZ8TpHyA2BcF9/PPiG+W3DvxihF6Jlha
 J2LPlPdKuWvXlUGXt91+VEzApJMK9IMb8w0nr18XxmxUqFCYRlmAoRTKV7zeNMqPkETs
 PfyCst1IPlVekQRBaxVESQ0SBTBVLdZJy6U2bxqEF+vzv6JQAaxTMwRivZEBIBA4Fc8f
 Yv43v0fMO/Z4lLFSINLazV8TjK97eD2DUvG8xsu5R4Z9od1IYVHv4ZDaPONYJwFDIx9i
 KsYQtJaAqttbns45Mzr+fjS3YgLd2otherX5vADFgp6fl/hvjCO3Z7ZD7X53PZ4BkqyK
 3Esw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/mfd0bNgaPgWxlp2ihettjSgUw4bAhKVJT2qIVJbJTJcsoOKgofgC3SDLHavUJXfiCqHuMfOpyi+dk@nongnu.org
X-Gm-Message-State: AOJu0YxELxu93y9JBJHf0YpRgc7fD33eKc3abWw6gAxO86K8c9KM95na
 waFAN7HqwX7gAe2aMgQ4asdfnYiEkFq8f61Pz9eirKhZ2HC/x/R2bl0DfetlnKLy5F4=
X-Gm-Gg: Acq92OEvGpWcMDCQzrCkEdQVIxI/9hUJodME3HkGKstG910+0c79MUc+j4NilQqkHbk
 IVRDn+aWdQhz3j+3165hx9sr49R/l59yahp4R2SXESfMHk0y9OPIKGGC1cbITSXxfm8fVRxS0OD
 9/P8xVQ2L6xPyli4KScH59+MEXCvtbNwXiOPHN0LJ9YeR2wvDdkO8batlWnrJaYSowC7kuLdWN6
 KI5GQnEP2VuZOkD1JKOvkcZjJOd7Md8QYcOpgaAe38D5SX2xBot/Z0DxyQCg+BYU3b4gn4vt3FW
 ZxoOPNjzOw48ueuK+3W6nQrWSmumX3mHFSnsHzi6JA1fA3rraohOhRThwf65oj4bzh/Eiv7u+0F
 bQ4DPrPJFv8fA5AK0HUXI6sqd5VzbMGw5Mn3JuXkzh79OYWRQRSVZSF15UJsZ19/Z6NegtE6WMs
 l0N7IQWFzCWynM1jwLzwkMRk95ieXawcJeW07cfpoGJIWlb/I=
X-Received: by 2002:a17:902:f605:b0:2ba:7617:a755 with SMTP id
 d9443c01a7336-2bea23e2544mr248869645ad.25.1779899167543; 
 Wed, 27 May 2026 09:26:07 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb591a277sm161468345ad.80.2026.05.27.09.26.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 09:26:07 -0700 (PDT)
Message-ID: <9131d89f-f390-4031-8e46-0cce55d88bd8@linaro.org>
Date: Wed, 27 May 2026 09:26:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 03/12] linux-user/alpha: add coredump support
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Aleksandar Rikalo <arikalo@gmail.com>, David Hildenbrand <david@kernel.org>,
 Laurent Vivier <laurent@vivier.eu>, Cornelia Huck <cohuck@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260526200207.79738-1-deller@kernel.org>
 <20260526200207.79738-4-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260526200207.79738-4-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 5/26/26 13:01, Helge Deller wrote:
> From: Matt Turner <mattst88@gmail.com>
> 
> Define HAVE_ELF_CORE_DUMP and target_elf_gregset_t in target_elf.h,
> mirroring the kernel's elf_gregset_t (ELF_NGREG = 66): r0-r31
> [0..31], f0-f31 [32..63], pc [64], ps [65].  Implement
> elf_core_copy_regs() in elfload.c to populate the gregset from
> CPUAlphaState.
> 
> Without this, bprm->core_dump is NULL for Alpha targets.  When a
> guest signal goes unhandled, dump_core_and_abort() skips the core
> write and falls through to die_with_signal(), which re-raises the
> signal to the host.  The host kernel then writes an x86-64 core file
> for the qemu-alpha process instead of an Alpha guest core.
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   linux-user/alpha/elfload.c    | 12 ++++++++++++
>   linux-user/alpha/target_elf.h | 13 +++++++++++++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/linux-user/alpha/elfload.c b/linux-user/alpha/elfload.c
> index 1e44475c47..c86f9cf2bb 100644
> --- a/linux-user/alpha/elfload.c
> +++ b/linux-user/alpha/elfload.c
> @@ -3,8 +3,20 @@
>   #include "qemu/osdep.h"
>   #include "qemu.h"
>   #include "loader.h"
> +#include "target_elf.h"
>   
>   
> +void elf_core_copy_regs(target_elf_gregset_t *r, const CPUAlphaState *env)
> +{
> +    int i;
> +
> +    for (i = 0; i < 31; i++) {
> +        r->regs[i] = tswap64(env->ir[i]);
> +    }
> +    r->pc = tswap64(env->pc);
> +    r->ps = 0;
> +}

This has a bug, per review from today.


r~

> +
>   const char *get_elf_cpu_model(uint32_t eflags)
>   {
>       return "ev67";
> diff --git a/linux-user/alpha/target_elf.h b/linux-user/alpha/target_elf.h
> index 864dc6e2e6..bf3bd21b09 100644
> --- a/linux-user/alpha/target_elf.h
> +++ b/linux-user/alpha/target_elf.h
> @@ -11,4 +11,17 @@
>   #define ELF_CLASS               ELFCLASS64
>   #define ELF_MACHINE             EM_ALPHA
>   
> +#define HAVE_ELF_CORE_DUMP      1
> +
> +/*
> + * Matches the kernel's elf_gregset_t (ELF_NGREG = 33):
> + *   r0-r30 at indices 0-30, pc at 31, ps at 32.
> + * r31 (hardwired zero) is not stored; pc occupies index 31.
> + */
> +typedef struct target_elf_gregset_t {
> +    abi_ulong regs[31];  /* integer registers r0-r30  [0..30] */
> +    abi_ulong pc;        /* program counter           [31]    */
> +    abi_ulong ps;        /* processor status          [32]    */
> +} target_elf_gregset_t;
> +
>   #endif


