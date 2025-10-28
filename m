Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F8ECCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDh5H-00050f-6f; Tue, 28 Oct 2025 06:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDh58-00050T-PS
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:37:38 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDh54-0004Sb-OK
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:37:38 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-7849c889ac8so98836637b3.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 03:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761647849; x=1762252649; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+VogG5bJlckXRcgChjIj0RuzZ9xCrcFLVwzWctAbkNQ=;
 b=d+DiUCqYtmmBS8+975zWxJ+tsqDkRijRURwtqVwR9YGQsVcF5l87AHjhnY/3+BEZqf
 Gn+V5UG2/DQHvsxbuLomQ3M1eKXtMvkKTKrOCuLO0DJlM2DjKZ46INxA+d/UaHKlGMbL
 cHMVTqMwNZQAE3BwjIAnGF8vf7fAJGWxJvBpHOnpR8uUpZC9Ko52y2WDPXA0+3YdVIsK
 yk/h5uh2lHawn6jDv6COobIaU1J6D1cdS/f/xYt2iuR5f1zrXUZXPtmjg6EcJS0sLMdo
 JkzTxVimdhJR4KZb+DCPkl40+psiXOzonnhDyNJYOQV0F/84W2gJQfaLkaoZf3GLV7KH
 krOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761647849; x=1762252649;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+VogG5bJlckXRcgChjIj0RuzZ9xCrcFLVwzWctAbkNQ=;
 b=ovkLTqaBArT6JvCGZyTiOWhiQSqfxMztw2HQwDPHJrGiSPya74GZhjkIpBWZswuCID
 DjRLlAzjzsPTKN4MtQy3OXljHogs6SxDVQFBZDSRm4IxUJxJdg0DSLTSim4/TRmOrVOF
 q+qPVf2KaovW5nXpQfdxiEy+CNTBNX85jDxYe6d8X6Ffkq8iMzDPWOY1cyAs8YmKcL/l
 CTV0NEUK/Tt2cNfDSuPUllyC9nH2fLYCH7egIotcy7zvVGdwDAGEqEfi4nfw1KqiHhSK
 qjbHRN2xHqeQ5YCKSB07ux7JeR4v+K0V05TY2a8gsPCvG+VosezyGcKXbLdo5EGy+PIX
 c5rA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfztGOE72UoQ6HrTe7uhEd6vW3BdBxXy+uDHhBOhzcj383G1CtkrdCGFQoyL3+hb84eWJmw5ptkwe+@nongnu.org
X-Gm-Message-State: AOJu0YxeT0HyRMFH7aAgsEyymIcgPqYhk4aarwXAYfvxoCPlwAimRW+/
 RkYkhOORA/QUzzcMVJz53YVLuPIWXRJ+FRpRQZvz4ybYttBbAcV621IaJbvbkJLR5u892V2WKxj
 cbQTHI6RC6pETGZ6E8IH/Lwkf+8zFRZe8sTBQ1RWmnw==
X-Gm-Gg: ASbGnctu0nT7U1PzZFC4NM6HvEU2/vD2wcKN3yakdJ5nDKCY70TFmBN7nKCoJoaCTr3
 aUr4ZMi+I1jikO6QjXlgrvbeOjRGCPvhn1CpeOWslwUWGQkkCU+rg+DKJOQU4hjeFO3D3U01wya
 KxyjL/qpZdRgNsTNHfomWEcCZ5PLEoTNfX8iv+l52F/pS16hkcHlUiX/rKhbGYIpaPytf08WDh+
 /f5e31I5KReYT8N3BKa0W0awItbiP6QHe1bBenJe0fbSl6WGhWBOsOuOmtvnmPFd/IhpStv
X-Google-Smtp-Source: AGHT+IEZAM4auEqB+WSe5eHf5tb55iV8XjvGstcJeiHBlHKfHtoDsSVBcEG6hbld83dOg2ELkk9OTMWNP1XOnCzzI68=
X-Received: by 2002:a05:690e:4009:b0:63c:e8f2:2280 with SMTP id
 956f58d0204a3-63f6c5efbe2mr1952247d50.2.1761647849413; Tue, 28 Oct 2025
 03:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20251016140039.250111-1-eric.auger@redhat.com>
 <20251016140039.250111-8-eric.auger@redhat.com>
In-Reply-To: <20251016140039.250111-8-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 10:37:17 +0000
X-Gm-Features: AWmQ_bkTPwDs2fMRUDbNnqYdUbteCNQqyI7sAymkPHEOjuNAZpoZQ1cllrhnKtE
Message-ID: <CAFEAcA_DSo7COpwXF_W4sMiwwmGvZy21GON7UbKWm4H5uDxb4A@mail.gmail.com>
Subject: Re: [RESEND PATCH 7/7] hw/arm/virt: [DO NOT UPSTREAM] Enforce
 compatibility with older kernels
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com, 
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Thu, 16 Oct 2025 at 15:01, Eric Auger <eric.auger@redhat.com> wrote:
>
> This is an example on how to use the new CPU options. This catters to
> distributions who want machines to be migratable (forward and backward)
> accross different host kernel versions in case KVM registers exposed
> to qemu vary accross kernels. This patch is not meant to be upstreamed
> as it is really kernel dependent. The goal is to illustrate how this
> would be used.
>
> In this example, For 10_1 machines types and older we apply the following
> host kernel related compats:
>
> 1) Make sure the KVM_REG_ARM_VENDOR_HYP_BMAP_2 exposed from v6.15 onwards
>    is ignored/hidden.
> 2) Make sure TCR_EL1, PIRE0_EL1, PIR_EL1 are always seen by qemu
>    although not exposed by KVM. They were unconditionnally exposed before
>    v6.13 while from v6.13 they are only exposed if supported by the guest.
>
> This will allow 10_1 machines types and older machines to migrate
> forward and backward from old downstream kernels that do not feature
> those changes to newer kernels (>= v6.15).
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/virt.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 175023897a..c4f9b82c38 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -97,6 +97,23 @@ static GlobalProperty arm_virt_compat[] = {
>  };
>  static const size_t arm_virt_compat_len = G_N_ELEMENTS(arm_virt_compat);
>
> +/*
> + * if a 10_1 machine type or older is used:
> + * 1) make sure TCR_EL1, PIRE0_EL1, PIR_EL1 are enforced, even if they are not
> + *    exposed by the kernel
> + * 2) hide KVM_REG_ARM_VENDOR_HYP_BMAP_2
> + */
> +static GlobalProperty arm_virt_kernel_compat_10_1[] = {
> +    /* KVM_REG_ARM_VENDOR_HYP_BMAP_2 */
> +    { TYPE_ARM_CPU, "kvm-hidden-regs", "0x6030000000160003" },
> +    /* TCR_EL1, PIRE0_EL1, PIR_EL1 */
> +    { TYPE_ARM_CPU, "kvm-enforced-regs",
> +      "0x603000000013c103, 0x603000000013c512, 0x603000000013c513" },

Strings which are lists of long hex numbers? Is there a
more readable way to do this?

-- PMM

