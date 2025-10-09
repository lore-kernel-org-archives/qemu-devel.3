Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF46CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6txA-0008Vu-2p; Thu, 09 Oct 2025 12:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tx6-0008Vk-L2
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:57:16 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tx3-0006iI-La
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:57:16 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-32ee4817c43so1085272a91.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760029030; x=1760633830; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x2wvjjpZdXT6RlT2//Rb8pcJp10CPSnhh0YcY50WSyU=;
 b=Yg1YeKRklLJ5tsJziQszNVCWncfTFpfZGtgSkhCTsX/vCv+ji1oHkZqrkzN2oK6jyf
 cyy9BN6Okj931x9U5CeAVS+6yGenHpN8Cp2fLPmswJZ7kuXwk0HLHCZaxwXncfC65Hd0
 SlS9GWbU7p5U3icRzjk0WFupPpxM83R6ORYZwV4v2pH9knF80vwEzc99Xo0YHcPrEh3n
 +Ni5fCMj61VwnrHEb1szvrQSCxMTeawkCyvKvJGoB3EGt/mYIQBRMFx8MbIRjM2etIPJ
 ALBq8oNxGfQjlN+rPd6MMLtsgw0ATW/xJ8svburGIoQwF2RPCki5U7Y3Sn9dseSNFUkM
 iopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760029030; x=1760633830;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x2wvjjpZdXT6RlT2//Rb8pcJp10CPSnhh0YcY50WSyU=;
 b=GZiDLGmD4sswuEBaN1Yqbog76P+fpFb/eqbeE/Fe6BVGTfww+BnofObvM4AXI7C3jT
 fEuKavUPq9D3r0JizpB/MbD2cJR00CiegWeFgXL5CNZZ9dWOqAbV9OZUxTcvQBZD0wMz
 c8EPxgFn1t4hG9/5lyitoFH1SnuW96mKysZ1rdH1LYbC00EOMfIa/e7U0oGeJwirTXLi
 Pj+FXoHjfbtitwCwTadLFH+VwHnvbmaGwZzdMNfmMzu0ZYdQEdj8q/CV1+rN95ZSjdPA
 fksHVJo3zFsi35WsJqASkwIhG7jG8DZGNXU3LK7rMCRcOqiezMp4oW88yoNAOZYMyAbr
 Ct5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKA/h7eogHGgydAlhXqRf/gC9DDcF1yACNaeMoEmfFoUY+hvG3rWUpzNGI+juWlPQVTxR/WaTuquJz@nongnu.org
X-Gm-Message-State: AOJu0YwOiyywQwH7PiYNtLmRS+MnXuJmmSN9sZZynsio+Qr0+P09wHPo
 av5JMuU/6jDGCai01Pf4KIsadYqWdmutpioI4ZHEvX1pb60Lkfcyyf3LDqR3IwEwe+k=
X-Gm-Gg: ASbGncvYzHbrcwOOewWQbpftSgGKqeovsSA++cKrSNgNxujhYQtZTjWPcZXYiTcF7np
 RZDx0PN8vlaUlMB00intOgHSpGLRBns3WsN2jc5u04ZH50q0dggI9HvtkBo4rVfGnjE84imat+A
 bthQWVEJA6FBqCxNEiAvAtMzT9zSsHJbCadLycACmhKioL9XHD4xLJPoXdUkcdagZkI/F0ab9sR
 MFCzQHOYiOMMaNX3zBvaDsDjSJhS2kE6xKdYPMwyzmr/7e/ZhM72AILgW+4VPd0gPe464cKgy2p
 wN23Mw7n/CmTy/Frc435UFTUM4qsEew2P6XphM6ba2zkbAfCFYaO8Njewuimb45Gx7iNUbZEo7e
 VMVI7SlMZwnLXNbSdMGE+KNzLj6EgpVrTFDvlYGAE79YcfdfwqLSJ9yra7LUzrGpA
X-Google-Smtp-Source: AGHT+IEDVkMdmZpYtbb/7C5ugzZUgt7A9S6StUIkvkOekUVA8TpBKh1MWnVKRpVBSS9eNEKD1XNixA==
X-Received: by 2002:a17:90b:58ec:b0:330:a1ee:e119 with SMTP id
 98e67ed59e1d1-339edaae564mr17264616a91.9.1760029029580; 
 Thu, 09 Oct 2025 09:57:09 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b5296d52esm3860015a91.2.2025.10.09.09.57.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 09:57:09 -0700 (PDT)
Message-ID: <f29f0755-eded-4d56-879a-42c174d532f0@linaro.org>
Date: Thu, 9 Oct 2025 09:57:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] target/hppa: Have hppa_form_gva*() return vaddr type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>
References: <20251009101040.18378-1-philmd@linaro.org>
 <20251009101040.18378-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009101040.18378-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 10/9/25 03:10, Philippe Mathieu-Daudé wrote:
> Return a 'vaddr' type for "guest virtual address".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hppa/cpu.h        | 4 ++--
>   target/hppa/helper.c     | 4 ++--
>   target/hppa/mem_helper.c | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> 
> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index 869a75876e2..e14f238827b 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -320,7 +320,7 @@ void hppa_translate_code(CPUState *cs, TranslationBlock *tb,
>   
>   #define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
>   
> -static inline target_ulong hppa_form_gva_mask(uint64_t gva_offset_mask,
> +static inline vaddr hppa_form_gva_mask(uint64_t gva_offset_mask,
>                                           uint64_t spc, target_ulong off)

But indentation needs fixing on the second line.

>   {
>   #ifdef CONFIG_USER_ONLY
> @@ -330,7 +330,7 @@ static inline target_ulong hppa_form_gva_mask(uint64_t gva_offset_mask,
>   #endif
>   }
>   
> -static inline target_ulong hppa_form_gva(CPUHPPAState *env, uint64_t spc,
> +static inline vaddr hppa_form_gva(CPUHPPAState *env, uint64_t spc,
>                                            target_ulong off)

Likewise.


r~

