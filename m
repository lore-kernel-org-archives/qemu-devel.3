Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9353D3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFwCY-0005TA-4v; Tue, 26 Nov 2024 09:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFwCW-0005T2-MT
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:06:00 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFwCV-0006XP-8A
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:06:00 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3ea45abb4e1so956006b6e.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629958; x=1733234758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tBfZKVE9puiRsCiFjVgQd/8PsKmrirVGluuPc7qKSJ0=;
 b=dgWniUNUofnvM62Um3cl8KQXZaCiJgUMmdvj35YC0wPJ4s3qWw8pN4tPS4UkNyGiWf
 gh07YPuh3lCyZAOfHYsBPnImk/rB2yL99ijtzK46cOFBaniCuH/SwA0IIEit+7SgvmTx
 e3VfqsQhO9FOr3vEl1HXzRzxEafjaY1i1I9D5Zia2Q+GnTKZrOpw8erijZ0EHlhjQq6I
 /6HcG9eOYHm0ryjIz1ydhzno3GXP13MwhEQ+0CtAcd9WxVuu2PKTsiDfpm6fqKvLPng+
 ln0fztzX4eL6SkLBf4fy2nj4xJoehGvskz760HgljiJ0WAJNeAOGVjRzCvyNhofVf6iS
 6jyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629958; x=1733234758;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tBfZKVE9puiRsCiFjVgQd/8PsKmrirVGluuPc7qKSJ0=;
 b=MhRcd4YP8bkoUp3+DBsXJvukWm7lrIwDs3I4XUvSFKfWdJHlyJDMI4/u60/OQrTCri
 wCbJCQmFB+l1BtbcaMwg22tMeGpr/gNvWRVIIvcPaPf4QpEJusYYp1rDMUAlDfs/pqdc
 A3SvWkaikDG3mb6XkgupPnbNG8Dtf6xV0PHmp0e/mCoKnwlhYfPhLfM19gf3/xMwNRwS
 HXqra90l0KLC3FINUvWiQmrBOxCGLxOG4ycmwAQkB5ncSzxD+QnAR8Qcne4ruJNED1Mt
 gFmOkbWRNNV7jKWhi6CunWeizNf6Q+UcmrQVOYRD0oGrvwzX9mELGPhoPTLldKA227+R
 wmpA==
X-Gm-Message-State: AOJu0YzeBZI5cJnwUytqgzqopLP7RiPF48M4xsSXU3Hy35KJzVswod5+
 WTKHpGm4LanfenJGYdc/UqiH7CBbyqXD3a7oaTkLVmjwjjajVUrYGxhlO8pkSAuOCMy10KZ+ePO
 c
X-Gm-Gg: ASbGncvlX0rl+G0NHGafhLwPxnK/cQyX6i/J1+q88rq+7lAAOf6oh2sPrsLvX+Fo8tZ
 F+jl6/uc4NFciNRf6Bwd87yVT0Tmjd/udEgkpzQwcKGCGmbxwse+WY6Ds8a5Sbtnb6NZ2AmAHC3
 bJsmXNqhMWBhenCPZut91tLGpCt+ZH0JvOFQ2QFE1GEuOgOs+Ctxp5UqD0T9FwSbtvAlvG8NLrv
 0iJ6cHP2SFHYnraNUDRjLRJlpTJLc11DsU4Xa91vht+dg/XJVy3hduo2pmclW0jfw==
X-Google-Smtp-Source: AGHT+IFckKuRWD73d5lsS/PCSkzRmOSeA2YIlPzHO14Kvtvd1xxGFcQ8Yg4DcIqkpCxYfbGPVEFI5g==
X-Received: by 2002:a05:6808:16a1:b0:3e6:3a82:f790 with SMTP id
 5614622812f47-3e9157ab773mr16683792b6e.6.1732629957883; 
 Tue, 26 Nov 2024 06:05:57 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e914e5ab31sm2960288b6e.9.2024.11.26.06.05.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 06:05:57 -0800 (PST)
Message-ID: <c43faf89-bd0d-4b21-8f16-1aecc56df396@linaro.org>
Date: Tue, 26 Nov 2024 08:05:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] target/mips: Introduce gen_move_low32_i32()
To: qemu-devel@nongnu.org
References: <20241126131546.66145-1-philmd@linaro.org>
 <20241126131546.66145-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126131546.66145-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

On 11/26/24 07:15, Philippe Mathieu-Daudé wrote:
> Similarly to the gen_move_low32_tl() helper which sign-extract
> the 32-lower bits of a target-wide TCG register, add a helper
> to sign-extract from 32-bit TCG register.

"to a 32-bit TCG register"

I'm not sure "sign-extract" is really correct in either case, since it's always truncation.

But for the code,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


