Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84851C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 20:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whYTT-0004hf-86; Wed, 08 Jul 2026 16:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whYTR-0004hO-NI
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 16:02:25 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whYTP-0003sc-KF
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 16:02:25 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2cca24023edso2597845ad.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 13:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783540942; x=1784145742; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ohC2u3CisgWq9rZm8HXftZcimG5iuq20FNdR+PcFK08=;
 b=YnjpRsR8tclxIShImnVANGES1gofwMbP26+LqBjoCVOEkFt4T/UpuxiN1EaJT7rSfe
 NUVyEzTn5stExg/a2vE6yYOi00LhPR82OoY6Aswjxz16mdW+FJGkuY4wQaWS2un7UedL
 VTuuaHpUwGpOa4ch+BdiqQa7dirGgg6NJ8gjNvNHiY5WCCk9SDmJR1WimMtxRFJQB/ih
 +c6KPcZkp/XOO5cKThKghqSuJloE8Zh0UAqty8zqxx8/k/rGfa7NFjtnrnuSYM3mmM5/
 PQa9r6A1NNmE2UoVfj5KWCBL9Z8YqFZfm9pevRPIT6u3n19AV/DFQhsnCXrQYl3rSia5
 zppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783540942; x=1784145742;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ohC2u3CisgWq9rZm8HXftZcimG5iuq20FNdR+PcFK08=;
 b=UdLu8aN3shno9pn52wfDiJty39KDYwzEbkvXltmLMR+aFQga6GXwZRHQ3Gw9ZnnbXe
 W9sAP3AYtU9FQewWqOeOQ9gx2GAestFixHKejTc6h0EzOUfOQhYAxOiLMSL+Rmktfhyp
 H6ltunQjCqQM0r429lDNQLVrROMG4YhiW9Xf50hp4LEKhH4AeYoRymvmyKZsgrFdq+Mp
 CqVHDR0O7xew5YQQax8MUmHGEeWn1sBmGUJ+QVrTZmts4FdJrZmfmeCR8b8sOTCv6c9F
 DABIJphDgPlQlYf53CihxgTqBlA2VkNsvov+EOJe8In/MSgmcdEc9g1TZefzm46VTanx
 F8ZQ==
X-Gm-Message-State: AOJu0Ywqcuw/5mE6FzMsiUU0aSyaTpidkUAcrxluW6OHpZbr9vkO3A5W
 9jKKT+EDZ89nhuD3jtiWYDjZNPFhaLW9Uf5uD0u91H2WU5z6gzgF7TG7ULBH75g40fngsNCPvDw
 Qrltt
X-Gm-Gg: AfdE7cnAKXaZmWQymiV7vOcVB7hy/GfOrc7rDWn53cORZAhNANyojPgtAcJqvfiExt4
 nUPKuI22xOSZEQZSzyLLNgYN9atXQztq4au2IbrpQZvcclF5y/gEAjgSgURu+lPKKzIqVwLzqS2
 EKDqGwVkvB7Gyfb+zbrm1JVc9k31KaWZ91hBC7rIaNW0RIMbsLbYb0+v5Fzo8P+/EQ1ZY1hateY
 QHM7AqSpNVbPpFSBPCweJiC5h+1ofXdu7ACmbviyJ5/tOjcGHldH6L6/n84g7G2WSdzxnf066wX
 BR6SnsmOSsNOg2CGwEehGT+Jxn1lRv07suQ1eczzT+K+kb368NfY6XDpDa3o7J4afe4TOD0KAL+
 y90X26N1VuPgyUw41lIptYmoqfCWvz3JEVukk7gzoTp3M/z9l068OzqjX4J3DeJ5DEpqy4kOAbD
 UzNp1hfrcENNgkOUFGGmdZue65MpJ0KyN+Apjgz9n2ahnr7Tit1/0T5ZF0W0h3c7HzBQ==
X-Received: by 2002:a17:903:46c6:b0:2ca:1eef:5096 with SMTP id
 d9443c01a7336-2ccea46cf9bmr40489675ad.36.1783540941526; 
 Wed, 08 Jul 2026 13:02:21 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb73asm32628395ad.17.2026.07.08.13.02.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 13:02:21 -0700 (PDT)
Message-ID: <8373d65c-64d3-48d3-b2db-ddc2271132c8@linaro.org>
Date: Wed, 8 Jul 2026 13:02:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg: fix buffer overflow in
 multiarch/linux/linux-sigrtminmax
To: qemu-devel@nongnu.org
References: <20260708150541.2137546-1-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260708150541.2137546-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 7/8/26 08:05, Max Filippov wrote:
> Fix new_argv allocation size to be `(argc + 2) * sizeof(char *)` bytes,
> which matches the way it's used to store `argc + 2` pointers.
> 
> This fixes the test for me, which otherwise fails on xtensa with the
> following message
> 
>    linux-sigrtminmax.c: 59: main: Assertion `execve(new_argv[0], new_argv, environ) == 0' failed.'.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>   tests/tcg/multiarch/linux/linux-sigrtminmax.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/tests/tcg/multiarch/linux/linux-sigrtminmax.c b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
> index a7059aacd9cb..b5ea65f3d393 100644
> --- a/tests/tcg/multiarch/linux/linux-sigrtminmax.c
> +++ b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
> @@ -39,7 +39,7 @@ int main(int argc, char **argv)
>       assert(qemu);
>   
>       if (!getenv("QEMU_RTSIG_MAP")) {
> -        char **new_argv = malloc((argc + 2) + sizeof(char *));
> +        char **new_argv = malloc((argc + 2) * sizeof(char *));
>           int tsig1, hsig1, count1, tsig2, hsig2, count2;
>           char rt_sigmap[64];
>   


