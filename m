Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE8CCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 12:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDiVl-0002Vr-Dd; Tue, 28 Oct 2025 08:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiVW-0002RM-EC
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:09:01 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiVR-0001Nu-BC
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:08:56 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b5e19810703so902956666b.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 05:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761653326; x=1762258126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tJrPMCtLgqt23uoDB7YNHYN7lCrT98SpD4zNvenvblQ=;
 b=tj4TuAioOVxZPZJoXdcZUTY2fp/U2Y8PYn+PiHQ7j7lDdwm1tBVSXDju2o3nMWk72z
 c6Uko4uHp2rw11HybnP7fdoYScf+zIWwrOWud/olrhyLFxufG+kRXATp7YsEHU055bUN
 Vm46eytISFywXfQT4C5f8ejpDexxU/kCmaz3wkn33PobhRBZ3KZWWQbEP9Dcz0KSBTee
 WL8sdzluPElihDdn5AnD0YGcCHKu6NafxOEYzHpq0IUAT7eOKSRGY7lX7NqlD7m2WDKX
 kgCrBmRjbYW1NDqYx4Kw5ZgOys6B2xNLWomsIKB6PapGeTky2ncFdoBVcZucMnZyL+qO
 2uJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761653326; x=1762258126;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tJrPMCtLgqt23uoDB7YNHYN7lCrT98SpD4zNvenvblQ=;
 b=w40js+PPlgE/msnPF1zm5DEiLkd7qBqTDjMKcFDbteZlRDoRAycAZDzMRrquvoznO2
 CAbcCJOgLBeeTtASNQm+f5+5OfX0q9SnhKlbGEJR+/7mnL/JxUZe6Y6X0ZOTzPUEvZPb
 ZpyrC+1Ixn1gAqByWc2SOXOuidxU0xbHvgWzPgAShOm9OsgsOiRptRHtBls7EmswGU/f
 u6zpXa4HqDr1UXGa5NrvC+zMGBNX0z355VLbwfxsDyZZ4WNkBF5sWIgYBWT3w4G4pR+P
 gUFqBfPFD/NWHflBZbxDFc2aE9ZB/0J0QZ86hxIpPbkJC+bnvqAfH3xHvCXFeMHnfGtv
 VxMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbbYNAWIMZA33GdjBPhPYKqSa8Vyb6+31POlKBlR9tqn2ha8GKDAR39BNr1XxJd7lw48x6rujrnDfv@nongnu.org
X-Gm-Message-State: AOJu0Ywrr4tnNzxAJ95UuNcgTWnFn+X7Y2CHcok6k0jVLHIOYWNSk7Uu
 JOWs39Eb/YFba/QzDzGp8UjfKONEapZXAuyrutTCziyx1t5/sXwu/E+W3NOA2X62C80=
X-Gm-Gg: ASbGncs/nxBNxDfGPvJndOTKyq6cITcJDLpcb/Y5E87p2rk6ihBOG/tho1Mw81U34vy
 uhspCoS6BNGXlFaNbvjRL+ZQvFVF0u31tThjnmC0iK87fLwB8fkBHpuA/h8UMjwIkJbb9QNEuKO
 fgFOniRk+Cpjv2BqUtxTbcAPscnOnBW7ozcBePW77C2wLN9nHr02jbzcKOgUQNeD2u7eHWKxv51
 OYtm1ZZbrW3zJ02A87YQY/nU8Sz/QALZpO9i8iPGBmwcwY5l4ZdgJWNNhxdkrE9AGOQ1e1cIswl
 bvdja3wOVjvO6G/e0h6FpU4RHSwYREfFy36Sj3HrDCYaTvzIMZRB9/0UIQDuMAar5seL/2xsMrJ
 PjF7f+QDeKWXCZ/Vev/80d9ojBO83JOUUnMSidx++yfDaqatZ68RcUwCX/rJA8xK6SzGjPKB/fU
 lnFLOm129A/XmZJZh2ZzZC5KR5354=
X-Google-Smtp-Source: AGHT+IEEiOLfY4HEB1DtBx4AhKQ+2sUC6aCb90qXuiftDtvMSOBTQ/nCd8LN3fjKoD+zHoU4Ul7Edw==
X-Received: by 2002:a17:907:3c88:b0:b2d:830a:8c01 with SMTP id
 a640c23a62f3a-b6dba5bda25mr333917966b.61.1761653326362; 
 Tue, 28 Oct 2025 05:08:46 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7ef82f2esm8832457a12.14.2025.10.28.05.08.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 05:08:45 -0700 (PDT)
Message-ID: <2ecf7124-978a-4d3f-85d9-3d8ad7584eeb@linaro.org>
Date: Tue, 28 Oct 2025 13:08:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 52/59] accel/hvf: Introduce
 hvf_arch_cpu_synchronize_[pre/post]exec() hooks
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>
References: <20251028054238.14949-1-philmd@linaro.org>
 <20251028054238.14949-53-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028054238.14949-53-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x630.google.com
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

On 10/28/25 06:42, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/hvf_int.h  | 4 ++++
>   accel/hvf/hvf-accel-ops.c | 3 +++
>   target/arm/hvf/hvf.c      | 8 ++++++++
>   target/i386/hvf/hvf.c     | 8 ++++++++
>   4 files changed, 23 insertions(+)
> 
> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
> index 96790b49386..3120a4593a4 100644
> --- a/include/system/hvf_int.h
> +++ b/include/system/hvf_int.h
> @@ -71,6 +71,10 @@ int hvf_arch_put_registers(CPUState *);
>   int hvf_arch_get_registers(CPUState *);
>   /* Must be called by the owning thread */
>   void hvf_arch_update_guest_debug(CPUState *cpu);
> +/* Must be called by the owning thread */
> +void hvf_arch_cpu_synchronize_pre_exec(CPUState *cpu);
> +/* Must be called by the owning thread */
> +void hvf_arch_cpu_synchronize_post_exec(CPUState *cpu);
>   
>   void hvf_protect_clean_range(hwaddr addr, size_t size);
>   void hvf_unprotect_dirty_range(hwaddr addr, size_t size);
> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index 28d50e23017..6fb1fda424c 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -181,10 +181,13 @@ static void *hvf_cpu_thread_fn(void *arg)
>       do {
>           qemu_process_cpu_events(cpu);
>           if (cpu_can_run(cpu)) {
> +
> +            hvf_arch_cpu_synchronize_pre_exec(cpu);

Funny extra line.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

