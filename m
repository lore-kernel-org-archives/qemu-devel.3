Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16906D5CCA1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 12:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t67qW-0000cf-5m; Wed, 30 Oct 2024 08:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1t67qQ-0000cJ-Sl
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 08:30:38 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1t67qN-0004X9-3K
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 08:30:37 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71e467c3996so4999494b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 05:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730291432; x=1730896232;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mwxk61qXCxD1igY0nozXU71+2coh7aO9IgwTYvCRrGY=;
 b=1sy4ApV5w9Io/JlC4Jvs2OzSwul3O1oSaPegB23S8SqJZAoYP5tMOByYaxnzPIFu1I
 DZDAC43bvs5x8GyNN9vY1fuUXl//hwqvIJUeQ3utDzgo6mGOqTHEGh4zC3TTEO/Ovax6
 geUWtCE6Usa4km1CVhCVo0D1h4awHLaV2glOUl4FfxWU2btZ00ECBqKNACUKI0F7AqxF
 Vxz256+XSAMAgS5DM547JzrrO8wwkvnGltQij4pmnX19iGAuXZFJz7OptJCH15rWwI3C
 mqtd8o+9flUw1yqlFYYxqWZWU6awBAkWRaKJvXOSP5nAfRJh+szQaEzujW+5bdJZCUn/
 4Wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730291432; x=1730896232;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mwxk61qXCxD1igY0nozXU71+2coh7aO9IgwTYvCRrGY=;
 b=LWZMt/bqjOfP5heESL88cpelharJNjmfg8qYXqxDGaLntxZtGYZzOS9K9792ct4+OD
 rkXddM0dpUDG6dqkg2ExGfuS7YrO7oIHUnMmlpmAmj7b13W3tg1C0FKrt1o1E6mIBN+8
 EZ/a/N/+Y6pdTXjApBQWk2tUeg025qQs7YnvUEM7Hk6NzSQwS+k8YaAJfE0yhgfg/CBN
 cvQh2aGiJ14tkkNo/yvLy89cbST3DrYDbO+2n1/iYqigZlG4sa/KK4YuRBnwGpRWwznD
 d6fZK6i1k/aeM2ZbS2VkFcL87H2pPevoJCB/kv9YVlA8923tbCeImiqzhfPJA+wVhPzW
 PSkw==
X-Gm-Message-State: AOJu0YxHogcpXvcYMUPwQYmSLHxeXYDi7lSl2oznvlj6o57WS0X+0kme
 lTgoUs0M5rAFmkYOwsvpL4jQfqfOmX59ub+9nmZ0lV0LMvYuqLa3XsZbxN3oNPDqLOnTcpFmf7d
 BUpr/qk8lmLWUblmcOWSybVMuBksopVeNaETf
X-Google-Smtp-Source: AGHT+IHLGcj+/g90vitDPhzwmscnE4utjeBoIOQ/oaqLRNGOV/bKgvyIbVJ6scdJe5FbYy8RBmuUkXcGrc30YudF6yI=
X-Received: by 2002:a05:6a20:2d1f:b0:1d9:18af:d150 with SMTP id
 adf61e73a8af0-1d9a840a299mr19377383637.21.1730291431718; Wed, 30 Oct 2024
 05:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20241029130401.525297-1-pbonzini@redhat.com>
In-Reply-To: <20241029130401.525297-1-pbonzini@redhat.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Wed, 30 Oct 2024 13:30:19 +0100
Message-ID: <CAGCz3vtb9Afiq0JbthJQrn=hkXJ=X6cEKywuCs++bAqsf_+HMg@mail.gmail.com>
Subject: Re: [PATCH] target/i386/hvf: hide MPX states from XCR0
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::42a;
 envelope-from=lists@philjordan.eu; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

On Tue, 29 Oct 2024 at 14:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> QEMU does not show availability of MPX in CPUID when running under
> Hypervisor.framework.  Therefore, in the unlikely chance that the host
> has MPX enabled, hide those bits from leaf 0xD as well.

To clarify: is there some kind of issue with MPX in Qemu in general?
Or is this a consistency effort - normal Macs don't expose this
feature, so we have no idea if it were to work if someone did manage
to hack up some frankensteinian host system that somehow does have
those bits set?


> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/hvf/x86_cpuid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
> index e56cd8411ba..4b184767f4a 100644
> --- a/target/i386/hvf/x86_cpuid.c
> +++ b/target/i386/hvf/x86_cpuid.c
> @@ -110,9 +110,9 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
>          if (idx == 0) {
>              uint64_t host_xcr0;
>              if (xgetbv(ecx, 0, &host_xcr0)) {
> +                /* Only show xcr0 bits corresponding to usable features.  */
>                  uint64_t supp_xcr0 = host_xcr0 & (XSTATE_FP_MASK |
>                                    XSTATE_SSE_MASK | XSTATE_YMM_MASK |
> -                                  XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
>                                    XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK |
>                                    XSTATE_Hi16_ZMM_MASK);
>                  eax &= supp_xcr0;
> --
> 2.47.0
>
>

