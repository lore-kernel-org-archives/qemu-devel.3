Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA1ECA0FFF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 07:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uszDl-0006yC-0s; Mon, 01 Sep 2025 03:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uszDh-0006wW-Fh
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 03:44:53 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uszDe-0002Nq-SR
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 03:44:53 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45b8b7ac427so3952675e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 00:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756712688; x=1757317488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9kTA0v4cUFxtXNSIP0qH9oOlb1PwVlLBNcW6yOlhGV4=;
 b=Ydmbw61M9b6wpYoXJ60giENtKfakMdn634t6tl0kdWkidSxLN/2ur23OhNfMUS0Cya
 3HeISWEAg84nDXbigaYZAAnNU2RLqgsciCh7pkEQCn3t5d/eKoTiWKSRxI8Sk+zsPAQk
 wNyTFlDJPUIJxYYJE19LjTcBZ18JD4nPsju5OhUlqmpVoz9xHBHPwYiqn27FFm2xMYHj
 0njQbNpXrBlwqGG43mkvzy2x1pDPpHj0Gb6/Q3Kj3ifBMVtLubC0Gmp8+wSkJvgBY3wj
 Y+Q3e+LSpU2JEBtnypE064/c2mJCeehB9jbzNmyWXzf2A6LkQtRWb/XXg0fsAZHuvOTb
 fZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756712688; x=1757317488;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9kTA0v4cUFxtXNSIP0qH9oOlb1PwVlLBNcW6yOlhGV4=;
 b=cue+tVZ/BT6mkqNI2MGwU7HZLSRwwfSgdjchPJpFNoNQpC96rB/Y9U2qZgJWz5f2x9
 PggoOIdPdO5TqOf5TE2nNR9Skv22HuS0tN+wgiJyhlQGSy7jAzvqHUOJu8ULexqGYHuu
 tmFUezTk2kQD2YEq544rUbObfrb50BGvkmtN1da4KfuZ1a0CI2dMxB+h4Ex2hOTZap3C
 9pTQ12hQd1LN/0Xhx0384HBKIR2CYGTtc6VplxtZ4TxjPxa2khSPay/gWcvhEiz+XD+n
 GFNSetoCCbsYNzF6QL6pXNuhh32ayaDFNZTh8F44+x5Tpymdn+BHUk5+fHfgodNS/JGe
 qWfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5YuxBLFTdIE+DksME2TRY82IzasSsST63O20gPeImHC2C8/HZRyZETFldFbG91vxlk03Y80g3hAbI@nongnu.org
X-Gm-Message-State: AOJu0YwX4QxddzetVuwpOjAshH4BUNCiW3k+3hB/QvAVF14igJcVvbfB
 f2ViNqnLefj5o3pamDn8QYRARXkx1YGV13l1c03GA2fNR824ZJJibLVHd1Vmxnfpzy4=
X-Gm-Gg: ASbGncv0Cp32r2hvEG10QybXdeQJ4aH92jv45swGh+lf+4g1O9x3B4VxGLK06LnhnE9
 AZnJFceXB5BbMSz6N4W88wdhSGaq2pSmCpe7wz9QSc3QY491GAtYV1/mBXCU2Y46greNenChNnR
 mMh592gqpm0yXHinp6oeK+0BqlluVoaqeribG8mYFGdFzXl7hwFIl/sHa6EHElcxtLbbDIwws2f
 y4VczzXXi4/+4VOfwRlOL9JUhC0dXXqtYPv/6quDT0letmHTIeAom1qqEd6xnU4c2wHM++dyE4i
 EENWkqeMC43piBkhpSLRy9ZnRZ0W31+dbtO4Ycaq3DlqjfvkEsLPEY1b/fGJaADyxIitfh/Zw8Z
 X6pXesoAUcpKO5AkTWytMXEbfLOrlJsRTe3w/yUd/V3ZS1wNxWSTrerKp87F+0jvZPrHCIZl9Ku
 pb
X-Google-Smtp-Source: AGHT+IGNkUCnZwDolfjLJVZTxyqSJAmUxK92V+3XbWM7mdfdkmYxObZqfHiktnbLYV+yUhpjLnyzaA==
X-Received: by 2002:a05:600c:19cc:b0:455:ed48:144f with SMTP id
 5b1f17b1804b1-45b8c85802fmr20793785e9.14.1756712688006; 
 Mon, 01 Sep 2025 00:44:48 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b69b7529asm137739605e9.0.2025.09.01.00.44.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 00:44:47 -0700 (PDT)
Message-ID: <9e2c744a-1730-4c7c-9b5b-9d8644c6f2bc@linaro.org>
Date: Mon, 1 Sep 2025 09:44:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] target/i386: limit a20 to system emulation
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, richard.henderson@linaro.org, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829152909.1589668-4-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250829152909.1589668-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 29/8/25 17:28, Paolo Bonzini wrote:
> It is not used by user-mode emulation and is the only caller of
> cpu_interrupt() in qemu-i386 and qemu-x86_64.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/helper.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index e0aaed3c4c4..651041ccfa6 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -110,6 +110,7 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env)
>   /* x86 mmu */
>   /* XXX: add PGE support */
>   
> +#ifndef CONFIG_USER_ONLY
>   void x86_cpu_set_a20(X86CPU *cpu, int a20_state)
>   {
>       CPUX86State *env = &cpu->env;
> @@ -129,6 +130,7 @@ void x86_cpu_set_a20(X86CPU *cpu, int a20_state)
>           env->a20_mask = ~(1 << 20) | (a20_state << 20);
>       }
>   }
> +#endif

Directly move to target/i386/cpu-system.c?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


