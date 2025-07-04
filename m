Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C78DC83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 12:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXf6i-0004G5-8j; Fri, 04 Jul 2025 08:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXf6b-0004F9-63
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:01:28 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXf6V-0002PE-Ch
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:01:24 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-710f39f5cb9so7231127b3.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 05:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751630476; x=1752235276; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g7em2cNXKnXUibtFakubNMgOKSsBTiBM0K9HagMSvwI=;
 b=TQsgriX6dHEohyXn+4V8fecGJYoyr0mntB70xWtQz5ef9nm2CPcLifmyRhY0tJ55fs
 G9oi7+qk8da9qr6Y1euFqERxdx3qMxKB0eWjqY5Y6HgKOq2UGJ/ZTxDYn4tHREpaexWe
 dmbhXixDUnph7YXPy+XvNXNf9L4QNLvLbTaGijU03alCW1AokY6PZDnBqK0OmMVD5e3g
 ZQr62+xR2ioRRCYU8fmSvEdMjCLn/2UEc5tPxlBYr+TtAkyXb8Qa0FUM+7MSMArK+Gmg
 LlKAtuxYHsuV6jBDItgYzraCNPUgOtMG2qkroN2T1J9bqXUNlSEIZZ6CYqs+7QA8g6Y2
 BFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751630476; x=1752235276;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g7em2cNXKnXUibtFakubNMgOKSsBTiBM0K9HagMSvwI=;
 b=E7ErzZ4VwENX7Rt1A8ZFB4rKV5OEQJ9xxhNFKPat3mkFbrD5ScsO8w59XGP5DLjaBh
 m6I/7znHulag4y+Cb9GNA9YFPUOeiG0HKF1G1uDN9XeOpa+05W4+qPIriKaf543uf5uB
 CDi5OvfZf2KlYi0Qp8z9beDJS+YMGxDLyKzXVSt5Ni5hxbHFYSzLMkeYPoAWlpuYf0Sw
 X1VOPMkqKXx2GlXzEL6qGp1vfyNPv1huztyL6H64IL29jm7SspU52D+09QwZ3GKuDKQB
 5zEYcYlDoSun8K/UQ2z93x4gqPTc8HJld/sWkAtkhhQ2XQk/lQfBzjoTFEac8B/z4Rs2
 Mdcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9IpKcoHJ8qjpWgYR8INWJU9YprhdI3LSYat6end1dnl/5z+zc3Nx7AnujZnxwjDwfAA9PQVYTWcNY@nongnu.org
X-Gm-Message-State: AOJu0YxCfe/JziQYBM5ihyA3acFinYoD9yD3n40zh4tOm2YoBeMZk5GL
 P9+RZ6JkMAvgNTrWVezugkGTfZhFAyzmpdMYdqnrvjDuX/JaAbCOXRxQKr42PPVy3A7akxDWkah
 wrO1dsp/hiHv0Km5ymXfq6CnVuJKQW4C/Tad1O++12Q==
X-Gm-Gg: ASbGnctaOjlyxX5/TV3yCS9roSFcNWzsczOr4MBlPxSN2BaMdK0dzsEZ5tq4Y2mxFYf
 MBDXcv5redr5nJCI5VfkGhsEuukNW20EhK8D2yuimPAPvk3YshoufKGzwvSXhK7biKmnHRc4Nsm
 QbrxPThbcyp7Udzeevy9JjAM3beZwSDrfe9kcqvUz22O1+
X-Google-Smtp-Source: AGHT+IHehhFBpfRXGOhunTibaZ8UdR8UbP58vN9Y+ETVwJhel9Fp6cCbV4oHAxkRTJQgvlpq4eP2uGQSJRMtBU6hfV8=
X-Received: by 2002:a05:690c:316:b0:710:ebdb:83d3 with SMTP id
 00721157ae682-71668bd1741mr29194787b3.8.1751630476316; Fri, 04 Jul 2025
 05:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250702163115.251445-1-eric.auger@redhat.com>
 <20250702163115.251445-2-eric.auger@redhat.com>
In-Reply-To: <20250702163115.251445-2-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 13:01:05 +0100
X-Gm-Features: Ac12FXxU2qWCFEJnCsnQzqxfbOYtcDGtugAMlaUkVitxW20uhx4ehzd4LdKhauE
Message-ID: <CAFEAcA88pUf6tpn7_o-khYjRP6T1NwCuaZKREkC3wmd_YUKEiQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] hw/arm: Allow setting KVM vGIC maintenance IRQ
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 miguel.luis@oracle.com, richard.henderson@linaro.org, maz@kernel.org, 
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com, 
 hi@alyssa.is
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, 2 Jul 2025 at 17:31, Eric Auger <eric.auger@redhat.com> wrote:
>
> From: Haibo Xu <haibo.xu@linaro.org>
>
> Allow virt arm machine to set the interrupt ID for the KVM
> GIC maintenance interrupt.
>
> This setting must be done before the KVM_DEV_ARM_VGIC_CTRL_INIT
> hence the choice to perform the setting in the GICv3 realize
> instead of proceeding the same way as kvm_arm_pmu_set_irq().
>
> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

> @@ -231,6 +231,7 @@ struct GICv3State {
>      uint32_t num_cpu;
>      uint32_t num_irq;
>      uint32_t revision;
> +    uint32_t maint_irq;
>      bool lpi_enable;
>      bool nmi_support;
>      bool security_extn;

> +    if (s->maint_irq) {
> +        int ret;
> +
> +        ret = kvm_device_check_attr(s->dev_fd,
> +                                    KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ, 0);
> +        if (!ret) {
> +            error_setg_errno(errp, errno,
> +                             "VGICv3 setting maintenance IRQ is not "
> +                             "supported by this host kernel");
> +            return;
> +        }
> +
> +        ret = kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ, 0,
> +                                &s->maint_irq, true, errp);

This doesn't seem to line up with what the kernel documents
for KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ:

https://www.kernel.org/doc/Documentation/virt/kvm/devices/arm-vgic-v3.rst
says

# KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ
# Attributes:
#
#    The attr field of kvm_device_attr encodes the following values:
#
#      bits:     | 31   ....    5 | 4  ....  0 |
#      values:   |      RES0      |   vINTID   |
#
#    The vINTID specifies which interrupt is generated when the vGIC
#    must generate a maintenance interrupt. This must be a PPI.

but this code sets kvmattr.addr to 0 and kvmaddr.addr to
the address of a uint32_t with the vINTID in it.

Looking at the kernel code in vgic_v3_attr_regs_access() it
looks like maybe the kernel docs are wrong, but I'm not sure.

thanks
-- PMM

