Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC88C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 15:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1radwU-0003B2-4u; Thu, 15 Feb 2024 10:46:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1radwQ-00037e-TP
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:46:27 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1radwN-0005Xd-09
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:46:25 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-51182ece518so1193123e87.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 07:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708011970; x=1708616770; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4rBSgrX5YVivbEpiuFCj+73HjrmHSxalYOXOHIQ6N48=;
 b=hezX7fUA2RcR6buXGPN10/NRSW85aybQZn17l1N3B62+jq9sQ2lS0LqYluR7OiGLil
 ik0pIM7M66RoeK4w+LoJTvf9E9L2epJn7C3GlO+hM6oITom+tUDtxdrfiyL/03/tr1cT
 S8eYhIT5FDzdBNoVnBxPdk/z5KYs+8qt+GgubrRbQcR0S1kfAo/BJZ8l0kMHox82Jl0X
 NqxdJUGw5MHAyMS8b61jGWFXzCOVpf2U+FzdYoesMjpdcaW3L7ldY9+w0/1GY/CKJ1a7
 Q96hHWBqaiFdtwPzMz6oHac2H2Nsyp0hqGiaMgvN1R+yOdC3e+XEcIiHkvlkYtwkHjN6
 ZNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708011970; x=1708616770;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4rBSgrX5YVivbEpiuFCj+73HjrmHSxalYOXOHIQ6N48=;
 b=ZEM3pPbRTDulrS87/WPzrnNChAixmBli+ye5N70aEmfAwq41y8qBbfsIugwsMTcl5l
 KPhXRbpLVXKTA/wl24fCQnJBkN0dsszdrO2G6xcXO0tcIxJq/rStBWskjesEaErvRYz7
 UiqZITIluqbTT2L2rXZAtaRd6xkN2e6oEbHOHSAziUBOjgUpNeWxnmHpOnNC8LE3gXip
 7KqM8pAh1uo+AE13mHcIQs1wHA96m+HwPBjBd5afups8Y88V+S+BtfWtwciv5/HUoQhL
 UTqfcuzZSbswD22NCeC3NC6tk0c4s6j8JBa/ASDDGaq3/XHGawZ0Nvvm1vkzA3a24Lnf
 Fs5w==
X-Gm-Message-State: AOJu0YxEzjRV8wDMJ3VacHrg3ZmlKKB/ZKt4xL0Ka43pI21wRXBCRZMB
 N1fvkjyYBKD5tOy1ojv4yznW6QnPAtTbS0hJMMNjrez0nohjIEAi4wgTFNcF2IIq1JhGEBaEGa9
 IJuB0rkhDCEs75kbb+39FQ2+vq1YMHSSIHh58Og==
X-Google-Smtp-Source: AGHT+IERVKkfp9+r3RR8EamMBaAVeDZmMBnIM3VV1wDnqIAEzDXRbv0S+MnmCkslT/Ub4r1yMGquQcLzMR7LQ3JKSSc=
X-Received: by 2002:ac2:5333:0:b0:511:4e6a:12e7 with SMTP id
 f19-20020ac25333000000b005114e6a12e7mr1675056lfh.58.1708011969851; Thu, 15
 Feb 2024 07:46:09 -0800 (PST)
MIME-Version: 1.0
References: <20240215151804.2426-1-Jonathan.Cameron@huawei.com>
 <20240215151804.2426-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240215151804.2426-2-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2024 15:45:58 +0000
Message-ID: <CAFEAcA8YgJ-m6D6QZFsGCw9H0orF=DHKgs8t8Vaz=502+eXdcw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] arm/ptw: Handle atomic updates of page tables
 entries in MMIO during PTW.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Gregory Price <gregory.price@memverge.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 richard.henderson@linaro.org, linux-cxl@vger.kernel.org, qemu-arm@nongnu.org, 
 linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 15 Feb 2024 at 15:18, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> I'm far from confident this handling here is correct. Hence
> RFC.  In particular not sure on what locks I should hold for this
> to be even moderately safe.

> The function already appears to be inconsistent in what it returns
> as the CONFIG_ATOMIC64 block returns the endian converted 'eventual'
> value of the cmpxchg whereas the TCG_OVERSIZED_GUEST case returns
> the previous value.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  target/arm/ptw.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 5eb3577bcd..37ddb4a4db 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -711,8 +711,38 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
>      void *host = ptw->out_host;
>
>      if (unlikely(!host)) {
> -        fi->type = ARMFault_UnsuppAtomicUpdate;
> -        return 0;
> +        /* Can I do a load and store via the physical address */
> +
> +        bool locked = bql_locked();
> +        if (!locked) {
> +            bql_lock();
> +        }
> +        /* Page table in MMIO Memory Region */
> +        if (ptw->out_be) {
> +            old_val = cpu_to_be64(old_val);
> +            new_val = cpu_to_be64(new_val);
> +            cpu_physical_memory_read(ptw->out_phys, &cur_val, 8);

This is definitely wrong because it takes no account of
address spaces. You need to also account for ptw->out_space.
Compare what arm_ldq_ptw() does.

> +            if (cur_val == old_val) {
> +                cpu_physical_memory_write(ptw->out_phys, &new_val, 8);
> +                cur_val = be64_to_cpu(new_val);
> +            } else {
> +                cur_val = be64_to_cpu(cur_val);
> +            }
> +        } else {
> +            old_val = cpu_to_le64(old_val);
> +            new_val = cpu_to_le64(new_val);
> +            cpu_physical_memory_read(ptw->out_phys, &cur_val, 8);
> +            if (cur_val == old_val) {
> +                cpu_physical_memory_write(ptw->out_phys, &new_val, 8);
> +                cur_val = le64_to_cpu(new_val);
> +            } else {
> +                cur_val = le64_to_cpu(cur_val);
> +            }
> +        }
> +        if (!locked) {
> +            bql_unlock();
> +        }
> +        return cur_val;
>      }


thanks
-- PMM

