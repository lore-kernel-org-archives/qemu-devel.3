Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4DAC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXh1R-0004Yu-G6; Fri, 04 Jul 2025 10:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXh0e-0004Kx-O7
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:03:36 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXh0d-0000cD-1M
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:03:24 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e8276224c65so844733276.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751637799; x=1752242599; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fEOguAl/E9+enpXT7inQRZjrSGrT4GgdC/exifKAu0U=;
 b=D5fXRZzocUswboZFHsgTHWBtYvMHFRdQhW9O1UZ7xY90yiXVtehLoYtakHRgG8kym+
 8GyqordsCSjnmiFGrWa+aO1oihB2AiVSjP4xggIPRpmflW5QEywLKTzCO0SXc5AKVk3F
 OQY5uueggfpAjZJJxdJqmZ1Ctoq6tlDDuY36l9Z2dlVQb/d19x1RPsfr2M24ary1m0UK
 pIxPiNOGPKPCK0iNl6JdewWjm3mWnPq7Tg7P+WL2WmyjfXw5J8fkmuT5MCuxO7IneRFs
 waBXfSXAx7tXeLYaJlW0WgzR5NCxGsx7S6D+gRY23/uPS8jQ8/Nuje0P5HAbNsaw1ATU
 KCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751637799; x=1752242599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fEOguAl/E9+enpXT7inQRZjrSGrT4GgdC/exifKAu0U=;
 b=jirQfgggD/jy9SC84u0L7iw048ogA53+xG2L9a4mrnCNJ58SgANx4b6zdHqaKQYJ95
 fYZaFmYmeCNIth4UUaJtG8DqtqfHOowsaGzmn6fTovIQCLE2nUe5aIaBDW4ZrnI1p6Wz
 GzP5Zs+1ZfwuwCZCfkoDoKdULgyGnBOTSR39H9GxHpeXR4k/8omE+W/Z9UeRaUKNtdsE
 0HCLUPIUSwUczJm3IcLEeQnGjS4gH0//fdBTWcLk59tvNB2a8/qOpUKNLkEZZOTWfZp/
 grYRJb+k1d2g4o2fPmOZgM8yo9pugRCJyTGmW0uNYF4QTXxMoRJ1RGTJoeuRLEtdgE1r
 2DvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSUgAvtqhviyF393coQqJCPQTNnswhX/owDlHjoKMm6Wp4tC6/q7+teyg6xXUKpKU38vCf0n++IeDL@nongnu.org
X-Gm-Message-State: AOJu0YyjyMwtTaL0UqZfgKr0VCS04yZfHabUTqYKN3nG475NHXWsjivA
 cgy9nHX/+VTPQpP27R4qra9DJvooU2ZIFuBTgMLxG2oyyDZVTVuLgfdr9efXcOEwTFlooNevQ+D
 VZnu+0DUSijQBBayXFVQaKL9gxX/IVY8RneubWljvHQ==
X-Gm-Gg: ASbGncsaLnhsosATpKhkHV7exmCcqz3FXqQ+CsltA3WnySvyZQ0+qKoiEOmGR2paDJW
 Y1acdHljzgNvZT3+O/nLYMqAJD8I2fh/BC8r+GRIWVfwSGXt8k5Gk+x5RZG7r5NFDpIUeSeh+eE
 ifxW9D9u1PqJG6KTc3qq14r13FL6s5iFEa7DQWAX5xi0A7
X-Google-Smtp-Source: AGHT+IHV/2GF6o2yg3b4NbA2xzV490F+Y7/J6aFHUiuCtoX3O1kSZHnXbIYvd3DpSbS7gWjigk/1Y4u9ANHr6VbTflc=
X-Received: by 2002:a05:690c:692:b0:70e:2c7f:2ee7 with SMTP id
 00721157ae682-71668bf27b3mr33452547b3.12.1751637798735; Fri, 04 Jul 2025
 07:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250702163115.251445-1-eric.auger@redhat.com>
 <20250702163115.251445-2-eric.auger@redhat.com>
 <CAFEAcA88pUf6tpn7_o-khYjRP6T1NwCuaZKREkC3wmd_YUKEiQ@mail.gmail.com>
 <86zfdk9i98.wl-maz@kernel.org>
In-Reply-To: <86zfdk9i98.wl-maz@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 15:03:06 +0100
X-Gm-Features: Ac12FXwkS6O-indDBiOlHX3su1HKo9gysc05zwEokHnxb9jIGMJYHKt2dZWRcv0
Message-ID: <CAFEAcA9Z5bSgsYvHMwDEbw7e-1V_Yi62X8r2pH_LRHQfVonJVg@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] hw/arm: Allow setting KVM vGIC maintenance IRQ
To: Marc Zyngier <maz@kernel.org>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, miguel.luis@oracle.com, richard.henderson@linaro.org, 
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com, 
 hi@alyssa.is
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 4 Jul 2025 at 14:51, Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 04 Jul 2025 13:01:05 +0100,
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > https://www.kernel.org/doc/Documentation/virt/kvm/devices/arm-vgic-v3.rst
> > says
> >
> > # KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ
> > # Attributes:
> > #
> > #    The attr field of kvm_device_attr encodes the following values:
> > #
> > #      bits:     | 31   ....    5 | 4  ....  0 |
> > #      values:   |      RES0      |   vINTID   |
> > #
> > #    The vINTID specifies which interrupt is generated when the vGIC
> > #    must generate a maintenance interrupt. This must be a PPI.
> >
> > but this code sets kvmattr.addr to 0 and kvmaddr.addr to
> > the address of a uint32_t with the vINTID in it.
> >
> > Looking at the kernel code in vgic_v3_attr_regs_access() it
> > looks like maybe the kernel docs are wrong, but I'm not sure.
>
> I think this is a pretty bad case of one person implementing
> something, and another (me) hoping (but not checking) it would be
> implemented in a particular way. Oh well.
>
> Would the following match your expectations (and the code)?
>
> diff --git a/Documentation/virt/kvm/devices/arm-vgic-v3.rst b/Documentation/virt/kvm/devices/arm-vgic-v3.rst
> index e860498b1e359..4843c91052786 100644
> --- a/Documentation/virt/kvm/devices/arm-vgic-v3.rst
> +++ b/Documentation/virt/kvm/devices/arm-vgic-v3.rst
> @@ -299,7 +299,7 @@ Groups:
>    KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ
>     Attributes:
>
> -    The attr field of kvm_device_attr encodes the following values:
> +    The attribute data pointed to by kvm_device_attr.addr is a __u32 value::

I think it's maybe better to explicitly say "Attributes: ignored"
or "Attributes: none" or similar. Otherwise it looks like the text
is describing attr, because it follows the "Attributes:" subheader.
(Though we don't do this for KVM_DEV_ARM_VGIC_GRP_NR_IRQS either,
which also ignores attrs and reads/writes a value pointed to by
addr.)

>
>        bits:     | 31   ....    5 | 4  ....  0 |
>        values:   |      RES0      |   vINTID   |

Is the kvmattr.attr field mandatorily 0, or does the kernel
ignore it? (I think the answer is "ignored".)

Side note, we seem to allow this attribute to be read via
get_attr for gicv2, even though has_attr denies it exists there,
because the get code is in vgic_get_common_attr(). set_attr
is in the gicv3-only vgic_v3_attr_regs_access().

-- PMM

