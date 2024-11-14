Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C19D6A226
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeob-0002yx-4D; Thu, 14 Nov 2024 13:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBeoY-0002vV-RI
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:43:34 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBeoX-0004em-7Z
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:43:34 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e2ed59a35eso877989a91.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731609812; x=1732214612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XjfAF/SJK3eDJAFNumNgZbXhsBbAjVolOCWprgqHspU=;
 b=x1zgSTqrDGl0tE9MElyWUOo/fZ102986nlfUlh8VNMTscWAf8u0zyUw1pOOCiTwIcD
 8ssBTXkw2KyoQq5bpohzKOrrqUFbHSW02PAdweyJcKYu7v8V75JNh3nGLJGqqLjAzuYw
 qx0H0h4cSFshks0BZXLgKjA6zv7GcA7lFQyauRL+PGJe1nVcOoLsKok1ESUw/fXxdXsn
 AEjmZczsLzLq061/o6VGBPWcJ2OaLCn1rqOiZPsUm2Sh9LhRUwEovpBi1ybgaAcPAn1p
 EYnHzx+BQth2n1SKUVveUeLebBwH/42Bc6dAiU66F9e5y66p37sQfH0vikb9awptB+K7
 o1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731609812; x=1732214612;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XjfAF/SJK3eDJAFNumNgZbXhsBbAjVolOCWprgqHspU=;
 b=uU9SHA/2Bor7Nj7XGRgkkAL7EAMcX/fPEPejLmAXr3zYDZK3v3OOW3j4z8lmfDpv+b
 /EDeXU0O+aOH0c35kgUNb2SRSW9slb/GeFBWvCROM2ifCr7bxoQZrFpWXtFbuFFDwTjN
 D8Lh5O3qrGIhmek3kePJoyTUf8ns6YrSxKZjeLJCC2El0B5K4Sb27/bcke3OAJ0GZWzE
 opeNhwpKXbF4t2VInTNsmvheYkC/pW8YTXed+LF+houdzHvIcqS4f453WXauL/nKyEeR
 AXAxOfZ/JZzjsm7X3Alk7aLyQdoKLVsRBPrQhquZ8VzfAPECd+FO2LNKRejAOFDMO46u
 jCGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwtrHcfHqYVVQ8GqACxDYdhIjZRe9BN4UND4LknyORyt5sXL4tek2ZCMgaJubewkzC2aQu2ZRP0VwY@nongnu.org
X-Gm-Message-State: AOJu0Yx6EjBl7SBnp0zI6Iv/iSwHsJtARxeG8V14dLNqS21GLTJcL388
 qa84yn50FzTHVFh8xarhADtYmIxsDgAmvEaiXwnZ3n2MSTJ61acGUIaNWp33sxs=
X-Google-Smtp-Source: AGHT+IFZiFRuTPhuuPl9RedinzOTAidWxryZvOz2MP4W9IYmAynVnyLjPAGi0/vjNnIsl6cVobjXLw==
X-Received: by 2002:a17:90b:3c84:b0:2e2:c69b:669 with SMTP id
 98e67ed59e1d1-2e9b177d6cbmr32076950a91.27.1731609811796; 
 Thu, 14 Nov 2024 10:43:31 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea06fbb549sm1505103a91.52.2024.11.14.10.43.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:43:31 -0800 (PST)
Message-ID: <b7d12d85-fa22-4b53-ad09-b55ae62e4d9e@linaro.org>
Date: Thu, 14 Nov 2024 10:43:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/24] target/rx/cpu: Include missing
 'exec/translation-block.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241114011310.3615-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 11/13/24 17:12, Philippe Mathieu-Daudé wrote:
> The TranslationBlock structure is declared in
> "exec/translation-block.h", along with the TB
> compile flag definitions. Include the header
> in order to avoid when refactoring:
> 
>    target/rx/cpu.c:50:42: error: use of undeclared identifier 'CF_PCREL'
>       50 |     tcg_debug_assert(!tcg_cflags_has(cs, CF_PCREL));
>          |                                          ^
>    target/rx/cpu.c:51:21: error: incomplete definition of type 'struct TranslationBlock'
>       51 |     cpu->env.pc = tb->pc;
>          |                   ~~^
>    include/qemu/typedefs.h:116:16: note: forward declaration of 'struct TranslationBlock'
>      116 | typedef struct TranslationBlock TranslationBlock;
>          |                ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/rx/cpu.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index 65a74ce720..945ae6e9e5 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -23,6 +23,7 @@
>   #include "migration/vmstate.h"
>   #include "exec/exec-all.h"
>   #include "exec/page-protection.h"
> +#include "exec/translation-block.h"
>   #include "hw/loader.h"
>   #include "fpu/softfloat.h"
>   #include "tcg/debug-assert.h"


