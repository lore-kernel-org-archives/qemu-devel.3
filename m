Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0694EC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 18:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhYTk-0000z8-JT; Thu, 31 Jul 2025 14:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhWdP-0003Wz-Hd
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 13:00:03 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhWdN-000848-2Z
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 13:00:02 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-718409593b9so7273527b3.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753981200; x=1754586000; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I/QdUExyxeoIn3Ie7jtOvGkz9OaEB1WD4HVsvBIJL6c=;
 b=vKmOvicfqemAiuGchsqTJlDntB6+6KNZuw6J1/R6oFKabzK44W/IcCbEu4+b5MQQJi
 bmgfVy95tk+sWOti75MiqaZlMov/vBMzqhjFuNkUWZ7wiW+FUHgmSXg+y/+RwPgE43y8
 dDDJLbmGa65+uluTcOxrOt31KCNZhgVIDA8BiahPFn/R0VkIIs+uZPl1LmkQqyxh0GYZ
 VQBOENLcqtUBOtu3txPMVOFg4k5LWdjRAL8nnyYfaNorkGGWJOw/uSzTAqLSDUEdJz1o
 SA4P/BIyj9J8Ecw4HMp+MrxHnqSj7jmcjI/L0GK1eXqdHSBfOoCbUX4hX7Wo2CIGTZVz
 oliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753981200; x=1754586000;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I/QdUExyxeoIn3Ie7jtOvGkz9OaEB1WD4HVsvBIJL6c=;
 b=lPKV0XXY+UNDuw507W6GKL14QfHjqVbKsjyfHEznodmCGqIk34NNeyuUS2z0q91kjd
 vLrYNm/WhXaBNLPTwYTxbkmCTwsHhat5WGxHTzWrW54+yBFN1/t/R1F0Zgz2kJRglHLk
 wIPiFk0CGfru8XJ9p24XsD0mOpKy5njvkak80a1Jel+siS1noJ6sC57AyQpv+H9ACi2E
 wjPLzRh4iUAZ+3DP7Qg14vdOXo/O8wPM/xvKoAxsgQkjdW5QK5VX+YULsjCduT9cjvMj
 N9awv6kvJmgN6dX8Ujj+HJY3a3rSuuji355n1cCsqmNDrHHa+kW386JT9hv0H5K9JDOV
 J1IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU7YKFUJnihFL5IcA+/yO7X/6tS8I361Iu60Ps5ZRk696+ne93qCITABAVUoDwuR3acOop3Eh9s/aS@nongnu.org
X-Gm-Message-State: AOJu0Yxl5a8DPuvAs69CH7fYkM8mfBuokLl+Ymqb3XlOEaz8ROMNx9MB
 NA47VG2JOSKTqoqeDQy3RDoF57PnVPsDjWu4j52WbMpFcVV+hm/HnfQ1CWauEjzG/YoX4mtTYEb
 lFpuseRhNg8I3mh/iSvmBzZqOxLOIixQQRCwogMHXHQ==
X-Gm-Gg: ASbGncuVx0F0LOAexO/8lrt+O2ginMdUC68U6Mq/6rNaUv9G9+ODmTQmNHXdAZTKTrl
 rovPTAqkHmfZrRYzEbIrAsaL7WingJV9ZgOR1Mcd9+izU4bUv5e6ZCH7kT4N4L9wOPumX4kWhFt
 HMA5akhKaPPXZ9N3Jojx3VxoKEUcZk6qJg7VI0v05PYgwCFBFGk0HQxTbEjiko1RzcRw8RHCr3J
 cI44lQZe4rJQzw4kC0=
X-Google-Smtp-Source: AGHT+IEHeCi154ufw8n/JziqK5XigPSaPokLE2oYkC8ZJofg5wIbQm/SV2srA35RF+QA0lLRVyK5gHjMT5bMIMuN+Rg=
X-Received: by 2002:a05:690c:6e04:b0:712:d54e:2209 with SMTP id
 00721157ae682-71a46574fe7mr106734067b3.14.1753981199605; Thu, 31 Jul 2025
 09:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250729161650.43758-1-zenghui.yu@linux.dev>
 <20250729161650.43758-3-zenghui.yu@linux.dev>
In-Reply-To: <20250729161650.43758-3-zenghui.yu@linux.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jul 2025 17:59:48 +0100
X-Gm-Features: Ac12FXzfWvpsNFEbAGpVtqbT0mFTyZWcgVM6W8aO7oR0WgJBzaM2UJx7cYzV5WE
Message-ID: <CAFEAcA_xS6fy+rWt5g_uAgG0nBwEGFts1GZfqSLF0T668WLuiw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/intc/arm_gicv3_kvm: Write all 1's to clear
 enable/active
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Tue, 29 Jul 2025 at 17:17, Zenghui Yu <zenghui.yu@linux.dev> wrote:
>
> Writing 0 to GICD_IC{ENABLE,ACTIVE}R architecturally has no effect on
> interrupt status (all writes are simply ignored by KVM) and doesn't comply
> with the intention of "first write to the clear-reg to clear all bits".
>
> Write all 1's to actually clear the enable/active status.
>
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
> ---
>  hw/intc/arm_gicv3_kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index f798a6e28c..6166283cd1 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -295,7 +295,7 @@ static void kvm_dist_putbmp(GICv3State *s, uint32_t offset,
>           * the 1 bits.
>           */
>          if (clroffset != 0) {
> -            reg = 0;
> +            reg = ~0;
>              kvm_gicd_access(s, clroffset, &reg, true);
>              clroffset += 4;
>          }

I guess given what the kernel has implemented that this
is the correct change, so on that basis
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I don't understand what the kernel ABI is trying to do here,
though...

My expectation for user access for all these registers
where there's a "set" and a "clear" register pair would
be that they behave the same way. But looking at the
implementation, GICD_ICPENDR seems to be implemented
as "reads zero, writes ignored", whereas GICD_ICACTIVER
implements the "write-1-to-clear" semantics.

This seems to match what is documented, but I don't
understand why we implemented and documented that:
https://docs.kernel.org/virt/kvm/devices/arm-vgic-v3.html
rather than a more straightforward "for userspace, you
can just read and write the state".

thanks
-- PMM

