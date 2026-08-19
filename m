Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D431AC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 20:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmlO-0001WJ-Fg; Wed, 19 Aug 2026 16:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmlN-0001WB-7d
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:19:53 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmlL-0006dD-Pa
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:19:52 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-84e84a6c4bfso252051b3a.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 13:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787170790; x=1787775590; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sfdb1dzdnoBwIpbZ45e8jxs15t/r3s/rCiyhXY3QLm0=;
 b=gad1BcefUSQXOPHFwqbM2pdCacaObv7ujPBYmauuy3qjtJBlMg40dmF6VApSn6f4/T
 k5woPKYJxwc03EYjv69iyFwqiUswy59J1TPD2hW+T2Z8To3Gy+CMeLrmqpHRQccqXiIg
 u8taPJaDA9YE68qVAb0wmGtiC6SznxEI8YN9ntT1ZJu+TGz4uM3403FrLnOe/B+5EnqR
 kS5hdQ/BZDBaMa7U8/Fd+3v1RD8C7Eqaf+hUfkdPM6gi5/z3qdKAklykoi10lt7ejOtd
 VuwfbbkM93qVZwaBEtsXrZ4K1cBxoJANxIrMoq6wKd3pw/nXUhj5/k11ojqu1lSfABfF
 +fHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787170790; x=1787775590;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sfdb1dzdnoBwIpbZ45e8jxs15t/r3s/rCiyhXY3QLm0=;
 b=KQgAbmh14YIQZlL8/tu/dTmI06SSvCaXs4GmfScmplQR2SHorixPgUx672RHkMXtyv
 FEfWqX5OxxwTKcXTH0ZM6yWh8XnYitOJPFv0oLDtllyGPwxnmerZxppNcXvg3+V3jmuc
 TUg84FJSsXfI4nYqiCsHyaZtSeec0nAdTJN5n3Ws+ag+Ir6mq4JDO1L5lHqnZpsQaR7K
 7isTp75s0/iNtgNHJP4nuoIpU90INgZ5QuVxBvdn79W0VvApEhivMIIV8Xr4pavHskB0
 Z9K9EFtsDtvLTzwgd+tOn5EiY4Ay1kPVd4NoesvRXBqDOzn3TGIdOFvSHpgfn8U+U2Px
 G2Gg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpFRYLNGf3yO2n6zSA0zbXnAbjRdV805iqnzP9vONlWNPxhTVGA1uT4Jbq7l25bcV3gc9HE5bGLdorF@nongnu.org
X-Gm-Message-State: AOJu0YyCpX1e6CauUS+46gCKpKeQpQxK0bDbfE7KhBvBRqivH88a05n/
 /cCHLzOK6b+ds6ouyXVbhWwnCwI9O3GNr5oZHJsoFMuuNQcnpDSGwSs2UowyDyC59e8=
X-Gm-Gg: AR+sD13GnC2E61p3MB5djhRd1G8mz9FeiclqTHKQqwZleU7K0N3gK7y1kLrDUQ8cAPO
 nrAarqTg3GqVy3C2Ho7Fa7/YmgkXPsu1gx3dmWbUIobEg73idUmJUXNSA/3k8UNC8HJ2vbnbLdd
 9kOCohBtwvVCq+Li7oopRiwlfibtmlMbxkRpvTjxE0P/rAHaIDle/JwhnC/8Q9y8T6oPZh+b7/7
 nCIRHFjhUTSobcpBfHFR/RhsrkGmwbS9iC+2y4wk6GxiLjZuU/9cg6FNJZJXVpGe8Lj0oPaJ9SV
 sZ5xn37rjq1D6bh12vG6z+Rs7x7cEGCVLIlAW+RNfR4IaQpuYuAAVHWe4CCfXh6F1upxhIE05Jx
 /6j9VOQDoYZ+A0dS6rXqC7Msl3lONQ+hXCPxqQt/0nzZSafrW1cC+8wsh6EamwyOyNdHpLGzwHU
 FF6mr1KIoXXGuYI3piT721mHI/5xdWX0N0+cPHYePC7LgAAnnpUciey2t9HU4Tq7LSLjX3MBctm
 kWS3NzE
X-Received: by 2002:a05:6a00:7603:b0:842:446a:4cb5 with SMTP id
 d2e1a72fcca58-851df6bca8fmr1607797b3a.0.1787170790257; 
 Wed, 19 Aug 2026 13:19:50 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d3389fcfsm997527b3a.18.2026.08.19.13.19.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 13:19:49 -0700 (PDT)
Message-ID: <49aa8e41-c097-4bd3-a432-0fbb80f7f33b@linaro.org>
Date: Wed, 19 Aug 2026 13:18:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] target/i386: Convert cpu_exec_halt() to
 transition_halt_to_exec()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-11-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260819145649.23439-11-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 8/19/26 07:56, Philippe Mathieu-Daudé wrote:
> x86_cpu_exec_halt() now merely checks cpu_has_work() and
> conditionally call x86_cpu_transition_halt_to_exec(), which is now
> the generic flow in cpu_has_work_after_processing_async_events().
> 
> Register both process_async_events and transition_halt_to_exec
> handlers to use the generic target-agnostic flow, and remove the
> x86_cpu_exec_halt() wrapper.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/i386/tcg/helper-tcg.h        |  1 -
>   target/i386/tcg/system/seg_helper.c | 11 -----------
>   target/i386/tcg/tcg-cpu.c           |  3 ++-
>   3 files changed, 2 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

