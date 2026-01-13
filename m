Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5124DD2F332
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 15:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfgDn-0003yY-1z; Tue, 13 Jan 2026 10:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfgDl-0003yH-Rd
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 10:22:13 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfgDk-0006KV-EF
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 10:22:13 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6455a60c11fso6331155d50.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 07:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768317731; x=1768922531; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RNMoDdiDO4GxdrQZdKvmcC4J/0QHLU5TZ1wElCZDyuQ=;
 b=PX3x4Pbm5PxEmKwUUi1eThl+Qf89dxAzcLgOnw1aHI9nhghx/8RpF5TrFDL8qUeosB
 EjGUdYoei970U1/gUS4sPTf+zAsrEdQ9OWnzPsiFAJiDYx2gWARqPhluC/pUxPXylT89
 mk3NffzGA9nOMMuuGb5lIPyoAfF3lZBKTJPQLSb71Mkbbbh2NrWIM1dVEOCwIkp0aP2p
 Gk+gMpomdeu4op4QmXRSIPWw7W5JAKJ98DM6Ol++pMkIV+zG8+81dHVQMsx++DKuAKUW
 Zg8UPU5Raoa6niTb5PJ+9VuD7QuTX0IZKGyXDoRyldHbCkJhnQK3k6kTPOl3b8z5RQpC
 wznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768317731; x=1768922531;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RNMoDdiDO4GxdrQZdKvmcC4J/0QHLU5TZ1wElCZDyuQ=;
 b=qyGRr2Si0xyZxZPY/rfF4BLCz84fVOLOdK+Lt/NOjhOEKm+q2dshxedOzkLP/v6Qdk
 iGXj4NBQC/6vt5d++va0S68qKGruyD0uNNZjkIILiny4GXGRIwO7/M2bI76oTa04ZZPf
 3O9YYoJVVe8oftFnANb3/IBRlA3WS/t1hcCLzuGmFe46m1ASRFoFuJJNd4kaO1O/4/rG
 ehSJYgOrVELq7pvb8G77cNyhZTZCPV8d0sAx4/333mVHR3EUA9k9B/x3idgjTy6vC4bp
 pZZoZtQMw9TWs2EmB8K+cxeEBKIRTea4HjHNyAVypGAOAXhcEzQPVaLIPSzLTqrc24xT
 nIhA==
X-Gm-Message-State: AOJu0YyNDsxabg+weH7AR8F1LpY5Qaa5lLWRu+tWoiNiEzuJg22RnRcD
 nQHOm8WHnEGE/8oy3FiHN7jxK8KVveQZacVG5JUkaAz8hsRxXKMSzDt5tbSgyE46m9VLiPTgeP7
 0UuOqhQhFz/56UpfhpustZUE0TAMYPVYLCXC1pWTlRw==
X-Gm-Gg: AY/fxX5d1ZLfShSNvpmBYjDSRBuDCn1sxgT7si47y8aAFXBdKq6a16AiiFUMt8uW3X7
 VQsPgLLHuYHGhHYyk1OYG8VwbNoazI+VGKIyExtE4qfHKESRh2c1MDjuA3wqjYF5h67prEtXXO9
 y3bc/gJpiOoWD6MbNDUfw6mlB/69KCnb43IFurpwZInLQcrLiM9ODqB0iZPXO4eiV5un1n7ld3p
 ebbzVSMahytNNqgrryGkw0Xzx978ItfgmQZIOHs3XlIOQ/exvk6A+FYI8qK7tw7fo0/NVSN+3fD
 libzOQVdlwcr7cZwGAvayNg=
X-Google-Smtp-Source: AGHT+IG6dMQVsmcwNZFSNFfnNsrjQvZnjuCna1f5mDGefoA5KRaSFClJaR33Rb7u+J8ZVEe6FMnQ8uNvvff7e2Q0+l0=
X-Received: by 2002:a05:690e:210:b0:644:60d9:7534 with SMTP id
 956f58d0204a3-64716cc07cemr12617975d50.90.1768317730661; Tue, 13 Jan 2026
 07:22:10 -0800 (PST)
MIME-Version: 1.0
References: <CGME20251223120242epcas5p44b454df5afd0d517a4562a545ad11218@epcas5p4.samsung.com>
 <20251223120012.541777-1-ashish.a6@samsung.com>
In-Reply-To: <20251223120012.541777-1-ashish.a6@samsung.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jan 2026 15:21:59 +0000
X-Gm-Features: AZwV_QgAybvmPV55AtxQ9UECtRXzM1imxG4nPzgtPatAR3ZbvnH9TFtvQIqsmWg
Message-ID: <CAFEAcA9Ok=yT_t1kTLSnw8fiG1i5fZXZfKB-Bb=Lw5MeAjA7hQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Implement WFE, SEV and SEVONPEND for Cortex-M
To: Ashish Anand <ashish.a6@samsung.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, y.kaushal@samsung.com, 
 vishwa.mg@samsung.com, ashish.anand202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Tue, 23 Dec 2025 at 12:02, Ashish Anand <ashish.a6@samsung.com> wrote:
>
> From: "ashish.a6" <ashish.a6@samsung.com>
>
>     Currently, QEMU implements the 'Wait For Event' (WFE) instruction as a
>     a simple yield. This causes high host CPU usage because Guest
>     RTOS idle loops effectively become busy-wait loops.
>
>     To improve efficiency, this patch transitions WFE to use the architectural
>     'Halt' state (EXCP_HLT) for M-profile CPUs. This allows the host thread
>     to sleep when the guest is idle.


> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 39f2b2e54d..44433a444c 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -639,6 +639,7 @@ typedef struct CPUArchState {
>          uint32_t nsacr;
>          uint32_t ltpsize;
>          uint32_t vpr;
> +        uint32_t event_register;
>      } v7m;

One more small thing that I thought of -- although we're only
implementing WFE support for M-profile here, the concept of the
event register is the same for A-profile. So we should put the
field in the top level of the CPU state struct, not inside the v7m
sub-struct. That way it's available for us to use and share
if and when we ever do it for A-profile.

> +static bool m_event_needed(void *opaque)
> +{
> +    ARMCPU *cpu = opaque;
> +    /* Only save the state if the event register is set (non-zero) */
> +    return cpu->env.v7m.event_register != 0;
> +}
> +
> +static const VMStateDescription vmstate_m_event = {
> +    .name = "cpu/m/event",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = m_event_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(env.v7m.event_register, ARMCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};

...and so similarly the migration handling should not have
anything M-profile specific to it.

thanks
-- PMM

