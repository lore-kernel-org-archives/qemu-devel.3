Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F6FCAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 01:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyKeu-0000gi-5o; Mon, 15 Sep 2025 21:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyKer-0000gX-VD
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 21:39:01 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyKeq-00022o-1t
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 21:39:01 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7761b83fd01so3153333b3a.3
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 18:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757986737; x=1758591537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vx9YVsRa3nuiK0LU8n5w+77mR6dWf1K55SyYBI+jcFo=;
 b=jzpJw8BlDCsCRvhZGPVOZ/hRLvRPS28ky1SRX8la7gacy7hGQxBv/9RzDT1pl5MJGC
 olVfT5OOTvO1mz9NS+/LNEuB5sAnQ64H1uvKCFHCe+Yo+IWgP2z/oDy3ib1O8IwWKuko
 eOuPoNA1Zdfl6nbbhomAx81oDDVbQk5ER8j+f0mGKIK8z9pOvfGlsFLU4j0+OOPoMQ0m
 /FCFW5imfYXmpSpOERWif6g24auhY6+WaHAsY36fbpOr/MDpPiey2Zmecvn7NCCh8wrw
 K1Zbt/pFoWVXTmY6Yb08bi36fIpPXziGHZCmELrZrP+JnrP+ZzydpUrkZrre27mYY8M8
 KvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757986737; x=1758591537;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vx9YVsRa3nuiK0LU8n5w+77mR6dWf1K55SyYBI+jcFo=;
 b=nfrrwZxMqhleVEG0Tf/Tq12BJ2a1ENQ8II9Az3VAXRMmq4YORtoD3DpsyMP4hGWpJw
 aU/I17iqjI2hf1NBNUDS24mU+KOOatggqjgXgZ3j08mX2QZ9VUSRq1Y17B8xuw1Nd+Sk
 tUFWWO7cPW+lGURETu8nQfSkAfqTcFiR+lTxEja31ju6X98z08u8XTcsrfqbZujEwz3Q
 bp/EmgiJFmTQPjOgHMnPa6vJT9nu/GXpirTz3p3SZdZzzncoS1z25MyooSgb+7ojPgJM
 rlZW3qkTzNMp4oJD3In5DMFN4/HSyz72byq0yxo4c/YQtj5+wgrcNzVwNhm6mDwYtZS8
 eTUQ==
X-Gm-Message-State: AOJu0YxifdGEq1WWvHrY76JbRcb4TKL5/t5QDkhvNCAbSjBo1L5JvO0o
 rkt1jnWQxIolxUwph7vX958k06ohY5WeyhV4jbP0jAE+9DX+SQ9SHGablm6Q2qeQdUSG2VeMDC0
 Nq2Su
X-Gm-Gg: ASbGnctF1IrTPRvhpStJ/iqsBq6mYSyGqz7kjCQIAqK8dxL/JEWs6PRRJ8/3KKrN62m
 rczYPo5nAyyMf/H5izFix0ksjAIjh3n2IDMKCUpczCpLtTdZP4x9Ab4A7Txqg2rChyfalXZGo/q
 ltwZQnNheaBY5pR5yx4y3BkuB54U03hc3i3cESE+NOCXVtX44DG1kooKkm3LcP2X0DaTlju9QeH
 SfRX0Nk6PObt3aFhCCBvQLitfd9rYBzcVGhufVujuyN//WY0CUAhaaDiXCEVoxRSUuuiGgnCXII
 EsJqw4SIo3gyZJ7WnacO4vOgu241KHwTHpEqhFcFuRubqnhVTaIHHwZYVIpIJ8kcV6+FZU/HNXR
 C+FqvUhtMKtMTG/cSZn21dLn5aJGKmawNsXkQ
X-Google-Smtp-Source: AGHT+IG/C+wbz+AqpoydshFhcXwVSy0zJ4iayp01ckjCc/J2PTX9mpO4k3LnKgwBpSVDpBHDXXRNBg==
X-Received: by 2002:a05:6a20:1593:b0:24f:f79d:66bc with SMTP id
 adf61e73a8af0-2602ac84210mr19494887637.24.1757986737488; 
 Mon, 15 Sep 2025 18:38:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b54a387d0aesm13054781a12.31.2025.09.15.18.38.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 18:38:57 -0700 (PDT)
Message-ID: <a6108491-9e0e-45df-9448-45de99e373a0@linaro.org>
Date: Mon, 15 Sep 2025 18:38:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/x86_64: Accept a few locked pages in
 test_memlock.py
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
References: <20250915185509.340022-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250915185509.340022-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 9/15/25 11:55, Richard Henderson wrote:
> Startup of libgcrypt locks a small pool of pages -- by default 16k.
> Testing for zero locked pages is isn't correct, while testing for
> 32k is a decent compromise.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/functional/x86_64/test_memlock.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/x86_64/test_memlock.py b/tests/functional/x86_64/test_memlock.py
> index 2b515ff979..81bce80b0c 100755
> --- a/tests/functional/x86_64/test_memlock.py
> +++ b/tests/functional/x86_64/test_memlock.py
> @@ -37,7 +37,8 @@ def test_memlock_off(self):
>   
>           status = self.get_process_status_values(self.vm.get_pid())
>   
> -        self.assertTrue(status['VmLck'] == 0)
> +        # libgcrypt may mlock a few pages
> +        self.assertTrue(status['VmLck'] < 32)
>   
>       def test_memlock_on(self):
>           self.common_vm_setup_with_memlock('on')

I wonder if I should have chosen 64k, which might be one 64k page...


r~

