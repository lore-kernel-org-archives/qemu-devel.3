Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AE3C88E6E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62r3-0001yg-Bx; Mon, 14 Sep 2026 05:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x62r2-0001yY-5z
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:20:00 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x62r0-0006TL-BF
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:19:59 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e4ab20a32so1417800d50.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 02:19:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789377597; cv=none;
 d=google.com; s=arc-20260327;
 b=eoliS/SiF1BbJrykceI3yiJn+Jbs5NM5mLWL9U0nVQFrHpqAsuKyejwtVmWkINkU6X
 tD3+reBSyX8Cwa6y5TIqUwR/hoNxWWAYA7QGVbnn+/OpZ4ptOkSvRA39qbO8O6D7mayb
 ATpbR67AHnNI7EX9ygRv7usF2KDtOWtKWHvcXUi5oqaFHkq91mdoXrwCMJHj9EWfXFwM
 Da4+iDmJxl/AbIAKxFb7w6xJYxSztgOI2soUwPDMwVINwLxvzdZQ9rTLMHDUFLVG7Cj6
 n1lOtQ6meRXoMEB71GufnU34HdoUIMmJg21wR9T7lF9Ogae4D30ZmzeQnToQfeVo6ujH
 ldrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ChMphz73oEhFFunIG6+zJrLDiaHO4nPJODvJSHKWxV8=;
 fh=LDYgnM9zs3WY7aoG/mFZMxwAWWVD8OSYQ5z7zYAXk+Q=;
 b=jqQj4t4onULg0b5Oh3p9gqyAK0fbal+uMkpePqHVIH88EfrWnsedhweolUGf3w1/RG
 UVpA/rXB3a7Qk2CCxvqsFByERMPQhCt690RlWJprJKnF+zsJ541+/Ba09L98BBTDPxWc
 RA+tI7A7544+G2GP/bQD4OhJuQdIU3KSPFk8Ew3JVZg3fzyPF5Suq8NFF411iULztmEj
 zbVcSoU8DbHFV3viC2ksm0PehkEytno/oNQotc7CnSoI8eJK2MsKiqM2V+ZcmzGhLhTN
 lZMFfrjHChmmRCoLoKYguSZEDCIDKRPlen1a9N+5h/5fwDbwPOQbE59q60Yzln1BlUJ4
 paHg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789377597; x=1789982397; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ChMphz73oEhFFunIG6+zJrLDiaHO4nPJODvJSHKWxV8=;
 b=J2xz7GVfh82f9zYnZ+TUEo1cdM8NwLSqpogxWwafviMOsZPri7XkCacfcICB1fT5zn
 FQog6lySBnetcSuf+eYkS9cardkjqDB+VjoMW2mHAaAb4W57Azw8EvfJbXeMAeS7XOvu
 vIWYfOzTowxVzT2o7d5ugR+Ck8p8Mnj2aR0PYqN5OvGxTEDWCR4ziwxnsiavamG5XU8F
 KsqiN8bGbCh8YJ/LaKv8UErV+aADir2g6ICxwff23fk7IeLM90inIMgTLcXvPbesWoFI
 AjoSE8/Inx+Hc09nv/6JlP/BPvdnRm7Hi/sMfaAX0v1cF+yJhYTVKNEo9zIjCQnYDJHQ
 cXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789377597; x=1789982397;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ChMphz73oEhFFunIG6+zJrLDiaHO4nPJODvJSHKWxV8=;
 b=RQmFvOr3Wxgr6+cuU5vPWAL87AzYsKh7qqcBUE4M0QXFz498Pdv6f3ubwIoujT93IC
 D8HrhuLnl2XgfwQCS6+wEwfCYVUAzvY1p50JKskiG0y8YgLfAq+ZLj48NdOMkfVG/h8u
 MVAn6eZk8xdpXpGYIK0rMVqVpi/SgYo4wowQ+JcPkY/Oj8QaOmaPnIigYwdeTurrSNzJ
 AxoI0miGNfNhQ3O/kDBj0FyUKkB1Z53hQaXm8ZZFwYMifNChFJk+ebjkK8ovE9hHZU+m
 e6j1BVJLKnpBQ01UKsSOmJ4RU1mTrsrnS9bGfvp/fELNWaOVjd/aMMqO4LqJ7nrupj22
 hEvw==
X-Gm-Message-State: AFuF++kbtQUoPrNxMMZSSvlUe2zTjmn3ZlW+GqMG1J4EC0ylVHsQ5vQH
 SrNKlkdiNl+TQmA9QwBjMAlmguY+bumZmcoLRXztDoMpOjmqYnkaPYGpF6fk794zZ3td4Mmu6+b
 TgyF03aQrRvjMqce5krF45fvLlWfCLTwyu0gSGQffig==
X-Gm-Gg: AYBFou0CUYIAfyiKnMlPKjMQhM6Vz46lqZOGD2fnE2LjhhWAHCiUzs0Z+BSvELH0Hf7
 06Tu6LJkklAKi9XIsQlpUn9DpudzQ2XBP50bwbgJ+hcQ9+/XcRxLxwBW6z78lD6COl/N6fhDVJN
 IlEMp7GLZ/1mwQFVj++baFWRt6mJ8KrbumBAMKQbl0TXtkBYiTs+sKOlEaeT8nCVuC40JaTEho2
 1t5Brp1tPpxEtUfyK0GrMvKdaD474DYHo1YaDL4Bu87lvnwDOhuOCU+3YCcIHwTT4uZwxaTz0s3
 KYkkKOJ7yyKW+5JA64iz8ZIFIqNpY1WLuMJhL0iChrayC7WDGFqAm0/5/IgrtFp+cXZvUDXyT5W
 WrTRij1N3eBsb2066wUMj+tkhicWqNlopO0PO8cw=
X-Received: by 2002:a05:690e:4882:10b0:66f:c1bc:4086 with SMTP id
 956f58d0204a3-6714e07b20bmr167358d50.73.1789377596759; Mon, 14 Sep 2026
 02:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260904161438.3838261-1-bin.meng@processmission.com>
 <20260904161438.3838261-2-bin.meng@processmission.com>
In-Reply-To: <20260904161438.3838261-2-bin.meng@processmission.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 10:19:44 +0100
X-Gm-Features: AcwNN1XoQo60WGsTHuz10GYgcVA4-gqaXOKPsU1Sp-WlezIu1ocG451tdbpPBak
Message-ID: <CAFEAcA-p=UaNk-Qddid99o7zeGS4WqmvqAugxtjtBKZwv9ie8Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] hw/arm: fsl-imx6ul: Add SCU compatibility window
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Fri, 4 Sept 2026 at 17:15, Bin Meng <bin.meng@processmission.com> wrote:
>
> U-Boot's common i.MX6 CPU identification code reads the Cortex-A9
> SCU configuration register at PERIPHBASE + 0x4 even on i.MX6UL.
> The value is only used to distinguish Cortex-A9 i.MX6 variants.
>
> Cortex-A7 reserves this address and reading it causes data abort.
>
> The same U-Boot abort was discussed on qemu-arm in September 2024:
> https://lists.gnu.org/archive/html/qemu-arm/2024-09/msg00072.html
>
> Map only the four-byte configuration-register address as an
> unimplemented device. Its zero read result gives U-Boot the
> single-CPU encoding after the low two bits are masked, while
> the remainder of the reserved Cortex-A7 page stays unmapped.
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
>
> (no changes since v1)
>
>  hw/arm/fsl-imx6ul.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
> index 1863558a0d..d6f662efe4 100644
> --- a/hw/arm/fsl-imx6ul.c
> +++ b/hw/arm/fsl-imx6ul.c
> @@ -187,6 +187,15 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
>      sysbus_realize(SYS_BUS_DEVICE(mpcore), &error_abort);
>      sysbus_mmio_map(SYS_BUS_DEVICE(mpcore), 0, FSL_IMX6UL_A7MPCORE_ADDR);
>
> +    /*
> +     * U-Boot's shared i.MX6 CPU identification code reads the
> +     * Cortex-A9 SCU configuration register on i.MX6UL. Cortex-A7
> +     * reserves this address, so provide only the compatibility word
> +     * needed before the console is initialized.
> +     */
> +    create_unimplemented_device("a7mpcore-scu-compat",
> +                                FSL_IMX6UL_A7MPCORE_ADDR + 0x4, 4);

What is actually going on here, though? Why is u-boot reading
an address that's only here for the A9? Has this been reported
to u-boot as a bug? What does the real hardware do?

Whatever the answers are, I expect the correct fix is not going
to be "fake up this specific 4 bytes to ignore accesses in the
imx6 SoC model".

thanks
-- PMM

