Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E63606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Al44IAZO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVxKi-0007Qi-Pe; Tue, 24 Nov 2026 15:41:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVxKc-0007QR-PV
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 15:41:38 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVxKb-0005IY-2U
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 15:41:38 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-67990a45e02so5151842d50.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 12:41:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795552895; cv=none;
 d=google.com; s=arc-20260327;
 b=iiXGlsBk0AEPMTdqIfj4w2GjsvSBxw5nIm9EMYwMIYCoBHb72NyHHWdM/iz3YVcuR8
 gQl1bqjB5bn6E3TIwpnYbI6JCWtLt1bwhU4e2b66XYReDWyvC64miBuTWm+CIWKL86qZ
 VCmFLx+pCS0jR+xr7EXHnGFn4Z8P8vFktW6oWzkFRUeaHbA7ezZYEC8qMd+uXD9rlTMB
 57qLBIoCzEx+DbJs3tB8t1f32mjtzg9plxd9UabuQSVyL2XwuQJoYZaMJECT71d5ab+8
 yGbRuZufWobXBd0iNJy9REXSfSfNvddSxGDURacJdtJxZ09f+JIwsvnHYGFL8P4dWHwd
 XwFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=msAxCGxCsh9OOkFFQaEorFCWTW/wUHreCroO1oGxpQ0=;
 fh=wgrKwobYrcDAFtJZSXFNQb22MEux66ZATtbqSMcAN7k=;
 b=bq9TVjcTkpHeDwRkmms4MHDvKOibcrAbyVRyOJ1d8Ljo7GiTr3s7fnDI+kbsHWBqQs
 nnbik9owUWBQAATKcjO5yO1ZqwLJq5Oiq5l/WonFBFdJBV5cwgKXOR9b3xaaKbssWoee
 7KSsS6rVfg2gF2oUQ0fxT0o9BDBGi9fKgHnYkaYGdwwdkBd0797gUoH0nbQuXot/XLWh
 FnFJoeYbUQCdWCCS1L0En5vv8B/pCUwKJgXklLCwZUq2+lLyqYxwgGl5nCm4je1cKlo/
 eR9hJM8o40AnYrYdoswQ9vTSl1KM1VdDvlrhx4yLJy1qhvGzPBMUQCx/ISV8y+J6S0s7
 0kxg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795552895; x=1796157695; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=msAxCGxCsh9OOkFFQaEorFCWTW/wUHreCroO1oGxpQ0=;
 b=Al44IAZOWISlWWEZ2iwgIYmMNqhIwUJz/xPUorXuyQbqEmsqYXLjCzHZVZ56mUXZll
 Itg2BwDWcxC2OSNAjxhexj84wX2LGVLGCN1/NfvX9bZVoaCP3GSWhs3Gs3t+fhnFXOT2
 uVmhFEJckdEMcpe+W2HbFEhIKwPGB6NskLK2DGzUvptgiqyyz/1+q+Ha5bdFdlJhrHdK
 bkSvi986dYvaqr0KeqJAsFMFi0ax2UaEERh1sVZdP4J4xXX6BHpMyEbrX8+8fWZg69Ih
 S2v0Si4p34UIyPsT6cgyDbvGsEPzKyBSj6YO80WVsR1aWMN1ulgr7/346YXM9MLU+6yP
 bi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795552895; x=1796157695;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=msAxCGxCsh9OOkFFQaEorFCWTW/wUHreCroO1oGxpQ0=;
 b=uRBMsqM5REmkKxc333NYlSHZana1Ep0dGVXu/vYUjxn0baH+Pg0qvOezXasKnTnFGW
 oqTxwQQyuBQ0tGW1cxxt/0nngrm4fX1wyiXgRgbVTi8O9/oeTUVrOr+AR04dSawPHok9
 869r3Q5ld1ROx6qnhq9J1uBqiys1oyq4dQRi1XodfpEw/BAKGGiat0L/3ZX1F+nNf3D9
 lUGJfauDfTN83sipbe0SH+WV9fvWQ7EFpDSCrtiaJKwbUy2mL0Sgn0RioE9DLjG0ecmB
 2VPHW2UuDOe9cDKoitrSMQ4+ZCg+ekp4AW5rOtMNIcS3HzwyP6WIVO2SDaWJlYInYSyK
 sNSA==
X-Gm-Message-State: APuU4Z/+TnViUfCzLQPb+nKZn/eLkByWRyvYB0rDoJCsbGqEgpYlUMlw
 Y/x/sWL5vD/6dgKWE+AuIW8RtrOajRq+iNQ6Xtb9mR2R9LEHnfkoPm/mpxxjSQBvrDQVGzqfRYd
 M8byAqCLCkFzhf5pxs+8vUDKDnB+Z74PYVUkn16ygIg==
X-Gm-Gg: AZFdTZdaTsA42W1ttClCEfI2LNDJ1tawEyLKJeMimyT1TBxnSumBGmrIJg2rGqtFapa
 nR2Ac9FLJP13JUcDEHlRXAb4WUh+ajLrg3DVGR36hAaZHd1ou53jV05ke5KCDpq1Bfg2Y0Kxpma
 ZCiyla37G7w3q9i7QyPnNTfxnSDcDmSt1ZM2le/NbfBReUq5TfD2PKXEBQR0XwaNLXbcX7T4Ss3
 BT4IpA/R78zm8GnycmcdlpxPnh9U67eQjV7mYOP7GL4cWMGhuQx5YVwCmVDWpqIXcrbA4tOsq+E
 v3mDN3Ss1ilqAIoPUAfyBS8yJjOBuJkbwAx+EAiwlnWbca+o24ndcIZBE/V8mt+KlLzq9+I8ymR
 EXO6rjdkyT/0+C/5dxaf/FWL4n/HX+c/gnPi9zAXfJ7oJu3CxCVlVVLzy/9bJZ0K/txytisalxm
 Se1cbmUZj4u/c2N0Hjslyx
X-Received: by 2002:a05:690e:4384:b0:679:2a5f:52e0 with SMTP id
 956f58d0204a3-67df4499489mr5084833d50.94.1795552895292; Tue, 24 Nov 2026
 12:41:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
 <20250325224403.4011975-11-richard.henderson@linaro.org>
In-Reply-To: <20250325224403.4011975-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 20:41:23 +0000
X-Gm-Features: Aa3M54pW0JRQ9zStzwpB1b9-QkUNKFfRTg_o6lgJ1OfuWg20TSPl1ebvXwlOU2o
Message-ID: <CAFEAcA8eCOeN5UA+DEbyFYVJPjW3zn6_C9gCGjsPWDHaJ0mYYA@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] hw/avr: Prepare for TARGET_PAGE_SIZE > 256
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mrolnik@gmail.com, philmd@linaro.org, 
 pierrick.bouvier@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 25 Mar 2025 at 22:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> If i/o does not cover the entire first page, allocate a portion
> of ram as an i/o device, so that the entire first page is i/o.
>
> While memory_region_init_ram_device_ptr is happy to allocate
> the RAMBlock, it does not register the ram for migration.
> Do this by hand.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

It turns out that this commit breaks migration for the atmega
board, because the migration code assumes that anything you
registered for migration as RAM is host-page aligned and sized,
and the little "sram-as-io" region here isn't.

What I don't understand is why we need to do this at all.
I thought the memory system had a "subpage" concept so you
could have a page which was in effect part RAM and part IO.
What would break if we reverted this commit ?

> @@ -240,11 +239,37 @@ static void atmega_realize(DeviceState *dev, Error **errp)
>      qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
>      cpudev = DEVICE(&s->cpu);
>
> -    /* SRAM */
> -    memory_region_init_ram(&s->sram, OBJECT(dev), "sram", mc->sram_size,
> -                           &error_abort);
> -    memory_region_add_subregion(get_system_memory(),
> -                                OFFSET_DATA + mc->io_size, &s->sram);
> +    /*
> +     * SRAM
> +     *
> +     * Softmmu is not able mix i/o and ram on the same page.
> +     * Therefore in all cases, the first page exclusively contains i/o.
> +     *
> +     * If the MCU's i/o region matches the page size, then we can simply
> +     * allocate all ram starting at the second page.  Otherwise, we must
> +     * allocate some ram as i/o to complete the first page.
> +     */
> +    assert(mc->io_size == 0x100 || mc->io_size == 0x200);
> +    if (mc->io_size >= TARGET_PAGE_SIZE) {
> +        memory_region_init_ram(&s->sram, OBJECT(dev), "sram", mc->sram_size,
> +                               &error_abort);
> +        memory_region_add_subregion(get_system_memory(),
> +                                    OFFSET_DATA + mc->io_size, &s->sram);
> +    } else {
> +        int sram_io_size = TARGET_PAGE_SIZE - mc->io_size;
> +        void *sram_io_mem = g_malloc0(sram_io_size);
> +
> +        memory_region_init_ram_device_ptr(&s->sram_io, OBJECT(dev), "sram-as-io",
> +                                          sram_io_size, sram_io_mem);
> +        memory_region_add_subregion(get_system_memory(),
> +                                    OFFSET_DATA + mc->io_size, &s->sram_io);
> +        vmstate_register_ram(&s->sram_io, dev);
> +
> +        memory_region_init_ram(&s->sram, OBJECT(dev), "sram",
> +                               mc->sram_size - sram_io_size, &error_abort);
> +        memory_region_add_subregion(get_system_memory(),
> +                                    OFFSET_DATA + TARGET_PAGE_SIZE, &s->sram);
> +    }
>
>      /* Flash */
>      memory_region_init_rom(&s->flash, OBJECT(dev),

thanks
-- PMM

