Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332BFCCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9NO1-0004ca-Sn; Thu, 16 Oct 2025 08:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9NNz-0004c0-47
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:47:15 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9NNn-0003nS-2e
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:47:13 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-781421f5bf5so7349587b3.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760618817; x=1761223617; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9nNVPL0lVBZmtnDCe5Q9S9dE3MhWWeHX0MneISc7Eg4=;
 b=lSBnjJqk9S+zQ8uD05uZBYEyARLWL6pum0PxKtQodlD/GtigN/6BHf4sUeibI4WskD
 6dTUbNxPB6fnZB7JKhMvnMjMNfYoFKWUm5dzacO7iajEHGGE7Q1ssbdF6DEb6k4Y2PVl
 XZDXhxJa4SkjKXZCSf55NIeCFsFDEqiWl2dYrSDzVsrJPr2UIaX+fd/beReZCfySPk+9
 BOOUPAtRsVbFZIz+ljMjZwVTZ7MZIeec86WUXEMU7cQII2zu1vq2ZXjokUirr4hUds23
 bbm24zL3wf4ckZCHQqVOv+GyjRx5beIi3mNe7FTY2lVcXXrR0zeGZOmnJ22/bCgt0wjB
 Rj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760618817; x=1761223617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9nNVPL0lVBZmtnDCe5Q9S9dE3MhWWeHX0MneISc7Eg4=;
 b=DoTzdRByw1QYyiIAhRjsmzom0UwtO4gAr4xZXxKF+/LsGcC6HOpADm7op8c6GT8teO
 l3r6ErTfv8wqOskslo3X4GLFDzvIIU9sVsxOsT1RUj9WHOupWsmAQvPgAX0MeBBqIazB
 7yTJjkJLy4yFKj6EdBPJXGYbpCF3SNtvHM6x0s9Bf7ymvFLzb64OEXkLFsqjrZFqvlVY
 zLtvh9OepxZ6TvKAHZlDTvnK/OuHhIeH2z9ghFNLIXn7KjKPSfC2BA078LN5rtX2biUP
 o/u8QOvjOdSdRN9CKEMNNuVAsBKXcPdI4hpK+2ovYZbVtErBf2YUIvLfYyi8RZyUsmqM
 cpkA==
X-Gm-Message-State: AOJu0Yze77S1IlegGN0OQBfLGkTVG0Qqnsod6DAxQK/pnJvMX3l5zmdl
 gKmZhLj6WRGGYWnfdhOhshCPHlG0+VD6kGz/uV1bDTmhkhL4uN/vLqDsRSKP4/ujQQs0VcABZ0Q
 1UPPhSiYl/beMD5i+UbASffrODtPtPJZKoo3hhn43xA==
X-Gm-Gg: ASbGncufohWuMx/Ej338IMhJPyWCXf8gtpOfqApqNQiwg3+qNnvluaFedd5yQaVH9uA
 PDgpJUJois2xxDBlzwtGMA+J+PAGd4s5fBBH7r06BbAzQCsgwRBW0ERGwF09q8XdGS7IXYotK9u
 r32R46Qn8qmVM4ruqEmOvfP8N9g3bO/L8vONFjIhhaECCzPBRk10jCcbCrbims4B5veWQI2nVKw
 nab0dpM5/ExSv4V3viwa0TdVY784zvF3YB9XpbS8YSR2hYP0LoVwUtkeo3wMpaUxavxJtYIyEZ0
X-Google-Smtp-Source: AGHT+IF8sCj+/Ohe0xSKZMze7ZtuVnPr/6sw18BOt+RcEklNIRDAuUk9JKK4kkhz0rhCBTewE8j0ZtiXq0fgK13ImVQ=
X-Received: by 2002:a05:690c:6002:b0:781:64f:2b15 with SMTP id
 00721157ae682-781064f38e1mr390759237b3.55.1760618816819; Thu, 16 Oct 2025
 05:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20251014102439.319915-1-peter.maydell@linaro.org>
 <d6f9dfa368b2419998379ac9dd986a7b@huawei.com>
 <CAFEAcA8U_3zJsnHt2wxME3j8J83whzTNgP9vEvUGuWHe7KGaYA@mail.gmail.com>
 <e2b03da8f7514b57aef7d236be1dcb90@huawei.com>
In-Reply-To: <e2b03da8f7514b57aef7d236be1dcb90@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Oct 2025 13:46:44 +0100
X-Gm-Features: AS18NWCnw2YCIbsS_V6KlvxwUZP6v57kZxjgc4eWXfNIXB_ONo28YgfhCMSBPEY
Message-ID: <CAFEAcA_KcvBOOc4nY6VMziSuh=YrcgbaNZhi3+M_kM01v97WtQ@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Salil Mehta <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, 16 Oct 2025 at 12:13, Salil Mehta <salil.mehta@huawei.com> wrote:
>
> Hi Peter,
> > > Above changes assume that the driver's configured value of the
> > > ICC_CTLR_EL1 system register is the same as the default value. I've
> > > verified that this currently the case. However, it safe to assume that
> > > this will remain true in the future as well?
> >
> > I don't understand what you mean here. We read the kernel's ICC_CTLR_EL1
> > at VM startup, when we know it will be the reset value, because we haven't
> > run any VCPUs yet.
>
>
> System register fetches its value from ICH_VMCR_EL2 and ICH_VTR_EL2.
> In specific, EOIMode, PMHE and CBPR fields of ICC_CTLR_EL1 are from
> the VMCR register. Later gets configured when driver gets loaded and again
> re-configured in context to each CPU ON request(via in-kernel  CPU Hotplug
> state machine; CPUHP_AP_IRQ_GIC_STARTING). This configures the VMCR
> again and again. Although, the value as of now is same.
>
> You might want to check gic_cpu_sys_reg_init() in irq-gic-v3.c

I'm afraid I still don't understand what you mean here. This is
all the guest writing to the GIC registers as it starts up, right?
That has no influence at all on what the reset value of the emulated
hardware should be. (This is the same as on real hardware:
it doesn't matter what the OS writes to registers when it is
running; when the hardware resets it resets to the reset value.)

We want to know what value the kernel gives to this register when
the GIC is in a freshly reset state when no guest code has run.
That should be the value that it has here, when we read it on realize.

thanks
-- PMM

