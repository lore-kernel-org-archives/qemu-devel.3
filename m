Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACC3C28B24
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqd96-0001th-Rk; Fri, 07 Mar 2025 14:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd8o-0001Yt-58
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:13:50 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd8m-0006u3-GE
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:13:49 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22409077c06so15292825ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374825; x=1741979625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NY91rOZV95QGQ9Eg3v6BGeiEZpsnL1+JIetFGjDLGFc=;
 b=K+ffHeaBGMKcz+8QZ5QMhyWNA3KVxUiZ8DKYKwP+XjM/O2ZM99ycB0Y/lIT0Sde6CJ
 7nYve6sWlyWAFDXS4Y134UJGSCVUI1NKXUeUMVFpLPOPHtEanNxcgYZBDQZWOU6AP7us
 RjIelP6rByn8y+2C4ZoJyS3XeMTe6t3l00vRAeEfsWSsPp9Gw6gWcjwei470Yq/iEuFD
 rMby6+Nff2MK1RBv5dZ5Yc4LmB6vtOTwJ+1GR6bS6ommtwXRHbcBp6opJxOrDp42no+h
 Atnvci2/1xmbLQFou3K2bnHTkDEaVGK6MYtPhwsxKTmzK8JmRX+DKnONG1j2Gb4A/951
 1hIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374825; x=1741979625;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NY91rOZV95QGQ9Eg3v6BGeiEZpsnL1+JIetFGjDLGFc=;
 b=WjcVGYqqjI1k4roUSHRCKpzWK8Bfz9CYOuEhLgYoVSVeALSSTYG0a8Bxa1QLPwMUyv
 LVVL2Vr8fyp9ITJFx/0y73UOSUKCqYVOEnENv0fYO5u3w8NDGw6L7SPhMEcwa2WfM0DB
 25Jjc/xXxhc0e+P73sSf8E7TsXMS/eNdSFpk4LLa/XiVcTpcuu2XwvttGWKTyqyXg0go
 eVcPW8Q/5M2jWt8teRoB8YxRf+E4cajRps1TTupNQ9HakhsyAX9AaIzJb1l42dHjl6IV
 +0P34eoj6wNpDmC1XM+TpCxwoO+D8rBxFpJEf6WOEiHqSvwjn1ysCu/rHpSSLglCupyB
 VsSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ44kTRWik+X2fe9o9wkVbNIuLW48IG6kqpTTr/LqI6PDtws3sxyMujgiRzsH/Zwb41f7DKXoCaNM6@nongnu.org
X-Gm-Message-State: AOJu0YyB14auAY+Wbu6Q7Yoyvqu7SinyIvxSxA1K+DCJLgdXaCl1Z03e
 cjOwILl+Ib/MoLc5+8urBnJXX8Sk9q1I+94I8SArwpzRzCnaLsPYwVGVtYui9g92Eg6QOAa0+E0
 j
X-Gm-Gg: ASbGncvLL1yBCKhGIBlxSxqWhHsYvulcgUyXHXnDiNvBSzooVSH/tzeUkJgyHVSi8Qk
 g/rNKOoNOYATnPK4SoT0Kq/7W/ovAhhmeHxRdMTlcQC9tw+vqpTZ2fArwBlrqRs7aaQA2keAK/h
 WT6aQaFQrvA2FqdcsrVRmXtjcAVm3+vOZwuzxCUCvdqB6ECtCd4OjRT0oFk2v/WOq0tcdqD1mt5
 NHGj1cKdS0qZD/xW3eTpoSZoIDQgmgZAVnDDczHDlZN9XiElnnmrkvVlBnzzGSbLFKcWhKFES1x
 2sXaX1VRDuhrFwZ2kibgLI8B64PDQA5fUMDFCsnUucPBJOFXC5OOYuxyFw==
X-Google-Smtp-Source: AGHT+IGO29daCPtwG4WFRvp6mtN4nG3CslnshkuwT8f3YmWwl/bHF2SvImH7tFeXUIdwuWmm5quZvw==
X-Received: by 2002:a17:902:ce0a:b0:223:6436:72bf with SMTP id
 d9443c01a7336-22428bf7a47mr90946765ad.44.1741374824704; 
 Fri, 07 Mar 2025 11:13:44 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a9193fsm33700535ad.164.2025.03.07.11.13.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:13:44 -0800 (PST)
Message-ID: <354f1a03-538b-4dae-81e3-ab603422e5e9@linaro.org>
Date: Fri, 7 Mar 2025 11:13:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] include/exec: Split out helper-getpc.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250307185645.970034-1-richard.henderson@linaro.org>
 <20250307185645.970034-16-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307185645.970034-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 3/7/25 10:56, Richard Henderson wrote:
> Split out GETPC and GETPC_ADJ to a target-independent header.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/exec-all.h     | 19 +------------------
>   include/exec/helper-getpc.h | 31 +++++++++++++++++++++++++++++++
>   2 files changed, 32 insertions(+), 18 deletions(-)
>   create mode 100644 include/exec/helper-getpc.h
> 
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index a758b7a843..22a99ca502 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -26,6 +26,7 @@
>   #endif
>   #include "exec/mmu-access-type.h"
>   #include "exec/translation-block.h"
> +#include "exec/helper-getpc.h"
>   
>   #if defined(CONFIG_TCG)
>   
> @@ -177,24 +178,6 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
>   void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last);
>   void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
>   
> -/* GETPC is the true target of the return instruction that we'll execute.  */
> -#if defined(CONFIG_TCG_INTERPRETER)
> -extern __thread uintptr_t tci_tb_ptr;
> -# define GETPC() tci_tb_ptr
> -#else
> -# define GETPC() \
> -    ((uintptr_t)__builtin_extract_return_addr(__builtin_return_address(0)))
> -#endif
> -
> -/* The true return address will often point to a host insn that is part of
> -   the next translated guest insn.  Adjust the address backward to point to
> -   the middle of the call insn.  Subtracting one would do the job except for
> -   several compressed mode architectures (arm, mips) which set the low bit
> -   to indicate the compressed mode; subtracting two works around that.  It
> -   is also the case that there are no host isas that contain a call insn
> -   smaller than 4 bytes, so we don't worry about special-casing this.  */
> -#define GETPC_ADJ   2
> -
>   #if !defined(CONFIG_USER_ONLY)
>   
>   /**
> diff --git a/include/exec/helper-getpc.h b/include/exec/helper-getpc.h
> new file mode 100644
> index 0000000000..1c8bd72c11
> --- /dev/null
> +++ b/include/exec/helper-getpc.h
> @@ -0,0 +1,31 @@
> +/*
> + * Get host pc for helper unwinding.
> + *
> + * Copyright (c) 2003 Fabrice Bellard
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#ifndef HELPER_GETPC_H
> +#define HELPER_GETPC_H
> +
> +/* GETPC is the true target of the return instruction that we'll execute.  */
> +#if defined(CONFIG_TCG_INTERPRETER)
> +extern __thread uintptr_t tci_tb_ptr;
> +# define GETPC() tci_tb_ptr
> +#else
> +# define GETPC() \
> +    ((uintptr_t)__builtin_extract_return_addr(__builtin_return_address(0)))
> +#endif
> +
> +/*
> + * The true return address will often point to a host insn that is part of
> + * the next translated guest insn.  Adjust the address backward to point to
> + * the middle of the call insn.  Subtracting one would do the job except for
> + * several compressed mode architectures (arm, mips) which set the low bit
> + * to indicate the compressed mode; subtracting two works around that.  It
> + * is also the case that there are no host isas that contain a call insn
> + * smaller than 4 bytes, so we don't worry about special-casing this.
> + */
> +#define GETPC_ADJ   2
> +
> +#endif /* HELPER_GETPC_H */

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


