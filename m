Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B9FCCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 22:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBKWS-0006M9-Hw; Tue, 21 Oct 2025 18:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBKWR-0006Lv-0F
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 18:08:03 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBKWO-0001l6-Ef
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 18:08:02 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-43f715b18caso2985595b6e.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 15:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761084479; x=1761689279; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BoGFaoGfC2oJYuZRlRefeJySzQHd31XezZ+4eSJwdGw=;
 b=x8ZYeo2lqUValQj5xgdlthmzd/1UwNss9zkXJ8ua0i2NpiR3pPJN09/F6OCjzuKqSk
 2oRaqoeE+bBHCwNPY3s5AIO3A7B4sU+x/PmBP7qQtHMBOStR6qLJnQFR2+y2d24N7TJn
 n9zDHtP+h9iYPxmad9qnz672Xs0AVaq8lxcDhQK5PB/QEnMDv8sb4kRDTfgEY3RsXnrI
 onUBKAwE0AxgEJBFjaXmqb1FDQhFkBFTxmqiNEKpHs6jSlywdBkh7g29JxcCFiKk+TgM
 G04dE3BOFLR/uXwZfMtNAcGGWeT63Akf+uInEH7+pVbJwW7rtve3EzqS3Lm/RaKHJaYh
 sQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761084479; x=1761689279;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BoGFaoGfC2oJYuZRlRefeJySzQHd31XezZ+4eSJwdGw=;
 b=dA0Smtf8cWx5CbUO2Uehc4xG2P0y/xVvmB7JGqS4l87KW+vWp5DZpytXjhpHeQjIff
 1BARuCB0r/vbuP3F1qyGKzSOfjQ2c/f5SOV5AOyY7CVxvKZ0FZeUVnNv+5tmlKB84R7V
 Ctt0tBxlVb+bX0Q3QrdSnQw/AAc6u73LjGN0qrQRarJ+KyIQgFcSWlTn3NWV3EEpBsQE
 G3L1PKI5Ky1eIMC1+OXBt/X2dSqWmXRnRqnE2B8XdhygfjzSpnVslWuUl7z0hniEiKg5
 obZYA1YSOwEKlAj/moc6ULlGr6dw40xJ7X4ra9e9+7ztg8orVyB/jiQg8rMtWpWB83Nr
 oJ2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVurGiFeo1GCdCHcOaaoSGh5rNnga+yHU0pruPER9WJBPVMtdLA559CE4acCZFZd88g6LgfcM2rFUtE@nongnu.org
X-Gm-Message-State: AOJu0YwSdai/tXQkjMsvSRuhk+/v5FhLQ0nlckuBmnNvxE/xvVBhq99F
 gy8Lrp8UDt03qVrdTaFQp7Lw5TMprgPl9GyNe6tyUB05xBCQZX3n8oM3buVhgyzFKYo=
X-Gm-Gg: ASbGncvsXljQ/F67eW49xdyQhlUPXqGJfwWIdUt+ESC04H0MndWqgeXN4AmCqW+k8D9
 pXXLVi6/d9pqaxSZJqX5Rk+0XVG7GW2dU3fslmvZZoM1h6xFSuNNWxGEKYYDJik+BjpdjIBtoR4
 3zcvZcT3j/QV93dLMtE8oO0zTD+AchOT2zlW1sRQo+fhGnMX2xvoMh8LiPHbUHP73AZazkrA38l
 gPOhq8JoMhjqridZtZlt0kDNPot+QwyiqnmB0qgotSNP/EMkP586bFxo66Qr0v69TAgy9clIdL/
 NVwJ9X9cLKtORpXicWljHkNYR/XdiN+Y5fGkH1NciB2JK1PmuOuqbSqAAYDqvS+t0puFxXNbw6m
 LikycOXql5z3cb2jbA7kC7LyK7kkAHgNgijf5ZF5JputjtRXu423UWP6l/TC4fBKX+jp7ASayyZ
 xfilVmEI2oI+dBJEP0vS7TayTyqixriF0cs9LvdcTIKd7yW/dMhW9zQndc188QVlr8Fdcq2Pw=
X-Google-Smtp-Source: AGHT+IFeTMI69lh6eoYSHeROWdxP8qqCosuX9gL41lJBvrQVP6neB6Xfd8wGLVp33Davzb7fRj6bnQ==
X-Received: by 2002:a05:6808:7005:b0:43b:96a5:f629 with SMTP id
 5614622812f47-443a2f20dc3mr8667527b6e.18.1761084478742; 
 Tue, 21 Oct 2025 15:07:58 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1aeb:47a2:7373:ab02:a897:da96?
 ([2607:fb91:1aeb:47a2:7373:ab02:a897:da96])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-443df31dd12sm3049423b6e.21.2025.10.21.15.07.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 15:07:57 -0700 (PDT)
Message-ID: <de8c1f99-89e7-4495-aa23-1e71ac6a46dc@linaro.org>
Date: Tue, 21 Oct 2025 17:07:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/x86: Correctly handle invalid 0x0f 0xc7 0xxx insns
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20251021173152.1695997-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251021173152.1695997-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

On 10/21/25 12:31, Peter Maydell wrote:
> In the decode_group9() function, if we don't recognise the insn as
> one that we should handle, we leave the 'entry' pointer unaltered.
> Because the X86OpEntry struct has a union for the gen and decode
> pointers, this means that the top level code will call decode.e.gen()
> which tries to use the decode function pointer (still set to
> decode_group9) as a gen function pointer.
> 
> This is undefined behaviour, but seems to be mostly harmless in
> practice (we call decode_group9() again with bogus arguments and it
> does nothing).  If you have CFI enabled then it will trip the CFI
> check:
> 
> ../target/i386/tcg/decode-new.c.inc:2862:9: runtime error: control flow integrity check for type 'void (struct DisasContext *, struct X86DecodedInsn *)' failed during indirect function call
> 
> Set *entry to UNKNOWN_OPCODE to provoke the #UD exception, as we do
> in decode_group1A() and decode_group11() for similar situations.
> 
> Thanks to the bug reporter for the clear description and analysis of
> the bug and the simple reproducer.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3172
> Fixes: fcd16539ebfe2 ("target/i386: convert CMPXCHG8B/CMPXCHG16B to new decoder")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/i386/tcg/decode-new.c.inc | 2 ++

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

