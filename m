Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB16EDE997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soDom-0007OE-Tr; Tue, 10 Sep 2024 23:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDom-0007Nl-0g
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:14:56 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDoj-0008Jl-Vj
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:14:55 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71798a15ce5so335051b3a.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726024492; x=1726629292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NpgzkpSkUfyYRP8tWlwGl2VTZlAQ5KxroABNo0hAoOw=;
 b=ctLhgN0YvtTKmjmT7xA9ogX7YI0Yd5/fjLDvTpr4eUuArD2J0EBgCV9mHqIKjLy6ww
 c+x2WqiqF2db4ch7KaHwjVzVClqTvzuHILpYNy1zOs9OrXelNLUto5PN2XUhLSQR69ES
 pCq/VHYNvJioA8ofIa7uG9Hw4ue0s65DcbNjxUH70OXN/4WMt7MQSFIOmquyDRjRlek3
 TkE43SYalPbab02IMkHEGhnKKsbRVKEcssgOjOl7VpiXFAJzBBsGAPWKDZz7dDX4kB7Z
 1NFlJLQ9T+VoSz6QHpKJ9ryP3TdWdJzOKmSro3+EkonP38drBpLPyoNEUG1Pd3MrZy/i
 cSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726024492; x=1726629292;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NpgzkpSkUfyYRP8tWlwGl2VTZlAQ5KxroABNo0hAoOw=;
 b=OW8hbGQ8Rv+ic88l58IVy2w5JqJPbekSijhcDLymhkE/bwTha0vPVtxRAddo/u8YlQ
 6ITDoHDAo7IyDaIJHbHM1uBmqDoWkbxxlzUWKw3z8ya7B13w7sWAg58DhLrzqgd2X6Ik
 l+tfi/s2H9yAI6MP9/C0ZBeTmNh8oVXlWSIGDQU/xhn/oHZjBXvuaBRTYzCI3eIredMr
 6GXqRta5rmWDoHlKLlBGc2Y9BJ/ay0PUX7n7zKmakewZK/OyFlKEUdXs0FIliG59d3ns
 nEUGLHYN4YU1rTNFubJ59a8crMNKowa4y/ESbC95ol/gBD9kKmHR0dFWE4WQrWmYmOoG
 +qcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXczlLlgVBcocEwf8zRYxAqANL2itIRCXkccvgaGqXnSO+e9B2uphlyfA8fzkKPF0AGBsFq5w3d8THA@nongnu.org
X-Gm-Message-State: AOJu0Yxm0a15MBBvnU7vk8Kqk0QObfCW0v9GKp4paNqYdqord35/N1gj
 5vTy+se/D6VEjTpfgimsHXS/iMKXdcobERhHxS1eIeJc47vrxkDOoyyw7DKWrmA=
X-Google-Smtp-Source: AGHT+IENYZakYWWagkw0SXqrWoSfmt4J5W+dzVhCft5DdCZrRVRJmhhgKt5E/gm2HHrncGrxzsxJaA==
X-Received: by 2002:a05:6a21:328e:b0:1c6:9a3b:ba44 with SMTP id
 adf61e73a8af0-1cf5e21aeddmr3293394637.25.1726024492184; 
 Tue, 10 Sep 2024 20:14:52 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe27bfsm2043216b3a.56.2024.09.10.20.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:14:51 -0700 (PDT)
Message-ID: <b26aeb05-4d26-4949-b43e-7f6320f4bfac@linaro.org>
Date: Tue, 10 Sep 2024 20:14:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/39] target/ppc: replace assert(0) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-12-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-12-pierrick.bouvier@linaro.org>
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/ppc/dfp_helper.c | 8 ++++----
>   target/ppc/mmu_helper.c | 2 +-
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
> index 5967ea07a92..6ef31a480b7 100644
> --- a/target/ppc/dfp_helper.c
> +++ b/target/ppc/dfp_helper.c
> @@ -249,7 +249,7 @@ static void dfp_set_FPRF_from_FRT_with_context(struct PPC_DFP *dfp,
>           fprf = 0x05;
>           break;
>       default:
> -        assert(0); /* should never get here */
> +        g_assert_not_reached(); /* should never get here */
>       }
>       dfp->env->fpscr &= ~FP_FPRF;
>       dfp->env->fpscr |= (fprf << FPSCR_FPRF);
> @@ -1243,7 +1243,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b) \
>           } else if (decNumberIsQNaN(&dfp.b)) {                  \
>               vt.VsrD(1) = -2;                                   \
>           } else {                                               \
> -            assert(0);                                         \
> +            g_assert_not_reached();                                         \
>           }                                                      \

Backslashes should ideally be kept aligned.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

