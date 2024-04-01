Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7362ACD1288
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 18:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrMde-00083W-9R; Mon, 01 Apr 2024 14:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rrMda-000833-UJ
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 14:44:06 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rrMdZ-0005oX-7y
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 14:44:06 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e0189323b4so30176865ad.1
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711997043; x=1712601843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=upQ5d65hlPWCFrJ5o1EehS6jvy2DLMc/W+RAjVhjQ/g=;
 b=Z05UUrK6rZNawsuvCDVm8aJj2E8yXXTc2vv37ja3Z6jbO5YPL+cGiE9CoOUevbKfOs
 ApvOhdRuSLqyCq0ApRNLKyn8fhPOfMj5mv4PcBpGibfRzu7prLov6x/iG+SCinkDimck
 aOw7fHFrjGZ5Uuj4dr3c8CHKsQyKPFnNTKvyIT8gCqQjXaKTghNp+8wFFf+qHKm5YkyI
 Fxvi0kSRIuL3jz6fSNzBx0o48F0W0ab8KuPhAE7xRTTs9ltRx4UtOnyPaw6ZqqMziY/j
 bqaV4vo6RzxUSDDPk7+2pfVEYElbseLjipUp0aa3pLC2Uys+FaLisHtHlw9mHHnv9WL9
 O5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711997043; x=1712601843;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=upQ5d65hlPWCFrJ5o1EehS6jvy2DLMc/W+RAjVhjQ/g=;
 b=dYld2iw3LU9bFOvRjiZhe00FXD5ZzCf6+HGuB4GLDZP90A+lxYrXJum4W+M1on6l31
 l7JkIb8GqM7BGmVFJtoB7DvWMbLyKnwzIxLMxoATuy3dPfLlrbLX4X5ECuGUJJSEQTIj
 bJm18Q9LvyCpfL2+R6jZt9ik2rQ3GScWZb5/PEfOVwL5Czce/kNmNfvpYiiZ3xiKx2d9
 8VUgFqW1a/TWVrREyrKp2l7m41p4PQaDVa/3NUhdzQaUcuLSRw3CsbDK7IR/X9ct0cGH
 Fzi4Wg/xyRaQJhKQChj+eIN9+fLbjqvxXLsfyT29EM07IrcM4elWgGxGuuXxMi15gB88
 38Yg==
X-Gm-Message-State: AOJu0YyNbHft/keDWWMhiA7zph8uLWdqHqEXmchb0IvfjqULbMo2IRh1
 j3RoOEeoEPaX8YoznL7fWXOG3l70pbVzsuljhnSfGeamoZgF+ow+q+9WrJSTqMM=
X-Google-Smtp-Source: AGHT+IGqZxlM4pji1fgJsVba3qR17T27o/hfadQy0t4HV5JQD1ggp4NJXdiCHvpUUhK/4B9M97Xmyw==
X-Received: by 2002:a17:902:c94f:b0:1e0:a784:f965 with SMTP id
 i15-20020a170902c94f00b001e0a784f965mr12844850pla.65.1711997043122; 
 Mon, 01 Apr 2024 11:44:03 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 w4-20020a1709029a8400b001d8f111804asm9274434plp.113.2024.04.01.11.44.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Apr 2024 11:44:02 -0700 (PDT)
Message-ID: <0f5697e6-da79-424b-866d-40d11b4db0bb@linaro.org>
Date: Mon, 1 Apr 2024 08:43:58 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: mask upper iaoq bits when returning to
 narrow mode
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240401145201.2175873-1-svens@stackframe.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240401145201.2175873-1-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 4/1/24 04:52, Sven Schnelle wrote:
> For unknown reasons, Java 1.5 on 64-bit HP-UX 11.11 does signed
> computation of the new IAOQ value in the signal handler. In the
> current code these bits are not masked when returning to narrow
> mode, causing java to crash.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   target/hppa/sys_helper.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
> index 208e51c086..3bbc2da71b 100644
> --- a/target/hppa/sys_helper.c
> +++ b/target/hppa/sys_helper.c
> @@ -83,6 +83,10 @@ void HELPER(rfi)(CPUHPPAState *env)
>       env->iaoq_f = env->cr[CR_IIAOQ];
>       env->iaoq_b = env->cr_back[1];
>   
> +    if (!(env->cr[CR_IPSW] & PSW_W)) {
> +        env->iaoq_f &= 0xffffffff;
> +        env->iaoq_b &= 0xffffffff;
> +    }

This shouldn't be needed, because we are already masking these bits later, in 
cpu_get_tb_cpu_state.  But I do have some cleanups in this area, and perhaps one of them 
matters.


Please try

https://gitlab.com/rth7680/qemu/-/commit/d06e0303595a63565593ab2a5d42f312135b9ded


r~

