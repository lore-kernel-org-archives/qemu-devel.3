Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A563FCC056
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 18:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyZtZ-0004Ug-IX; Fri, 06 Mar 2026 13:27:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyZtN-0004Tw-94
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:27:19 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyZtL-0004PV-D1
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:27:16 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64cb577e79cso10172072d50.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 10:27:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772821634; cv=none;
 d=google.com; s=arc-20240605;
 b=hQxHBqWQ5rzn1bHInjfh3NrihWg8o//CUE+iQGrwpc7x92yssBusfzbBCcqoh96Dsy
 2kBItXrPMqdZLszwxAn735BGYvM1v6r7ZwOtM7gTjJOMxaHqPokd/veDFc2NS8PpwjaB
 olRtK1miieO68Z8oihC1wceTPqbr+VfjmBzTMkmDY1FrCUWOMFp8GF/LTplHMvMtLlSc
 xYnHm1ToPgYgewbafhO0V9Nltaa99xAE8/CcvXXwXlhvfrUK0IKS6xmvgx9+W0omvE1P
 Lpipe4hiDmiFbYOBSPvWmbR9y3UGHhnnxg0ClOiOREMbk1/6YRiAl28TLBzIzDD3Zbwd
 6lMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vKznKg8kbE6VKmXiw/aLTPKUGyAueb2MWAi7kWLEtQw=;
 fh=8qier77ISpgIeRybWBZawZucBS26IYzAv1/HnRklQb0=;
 b=hwWOx/lWn8ZojJUD92ZsDBJPTdlY5zCki0EKTBeHhcm0tXzKKNM6uVTyfjfzIhS8jm
 wuMvmyyvVd5QEQ0IrfVSe+9p6xZqrIdk0aMh9aOa9OXtzY/NbNzD5wVBFV40pDQ2aiEV
 tOZizxuVXJdeY1Vmw1PkxFgooVqHbJV14S5jLMSVTWvsssrp2i9vcaHfBowgE1C52vub
 2l09HquGPbYVMo5AMFsnQ4C+Iqz873uYZURuwNSNCIBn/iqHcdW1EJhcY2WaqG6Qz0oy
 0Ee8K992a9+NOT+3jOYvTmZ7vs3VDOk6SdW7sIjVTOcrMTQJMQCECkPwJIkbHWC8h871
 VPZA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772821634; x=1773426434; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vKznKg8kbE6VKmXiw/aLTPKUGyAueb2MWAi7kWLEtQw=;
 b=XQZfkTQcRwhT3UKzS95CHpG6ghdHnkp7AHq4XsHHo6z112HzpJyigHTX9Rt7AiNTyo
 jl+2mcbZ7I+2mSziNnnyafYlMxDJNfPCk4nUiSQ48dhD+RQdSk1BrU3L0oRak5GxgHmt
 KBYBUmLJLmNJaJGrz4QbAi9I+inZYWiA+i2LiyGfgKo14zFnnZUVUvgGZSFrA4E65Tas
 6o61c+dvD41IbLJV2hayPe1WcGFGxANSQWAhSpMxeO5qqY0+29KuzDBizoZeLcAK80Po
 i6YcAe544hCNWS1ojU54JyBNz/nfULP2orlV9pA6hAx9SC+jl0ivpyC27BNDlOkBhtpF
 LPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772821634; x=1773426434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vKznKg8kbE6VKmXiw/aLTPKUGyAueb2MWAi7kWLEtQw=;
 b=Y07AMCHuTcGFMqPJHH5PMSMumgM4by9hSqwj2wZ6KjRZZ2xfeeObos0w2NVUiXicSV
 VhAI8BnpJ9aeSrEkjrC1HYGU/9gAtVZJGI+Gwu6fQXQKyaclQLrCN0mjVvbupU0jFnkZ
 xgLh8wwWuKaVaYryrxNKczGUROTqzUsoKFXle1fCqwjJuM1x5KTbL6BJAFhuutVAVGAy
 N/h00qCLGDd45fGzibYfyhW/bLsLWs2Ptx74polVT03qO6WWQH0Q1ELBMz4V8F6WYgNX
 I2s7pSmfecuMcJUDD1GXMIT/pXXkLkzrBmSQkpl50V2GgyYHvZ3GFouuFhBZ+jQgUDL+
 +1ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIdpSgg7b7UqrsoTPcVOGxQMBeKqsY8Fs2mjhyHg6Q18KN/ULSkCQFE2FyCqwFwb+VJrHyTIGzMYgU@nongnu.org
X-Gm-Message-State: AOJu0YyPYl3eYdqsOXadaeY1eIr6kmwV6eBwrV9/1D1A5H6MEOFiWApG
 AtQ7y2lgTuPICL6R/HQidiEdGzGOuitKqBYElZFNprDTDeTOQXCTxVcwlXXp3tROvyJ0rnvqqk2
 E0EBjVl8G9nElvkCvGzNY6Ssu0rX1N8D2ZwiHhkaPlw==
X-Gm-Gg: ATEYQzwDU898zGaeHGO2Lf5QclrZbpbW2OR2eApu6B8CdTXMW34TtujOYCQo5lcpod1
 PQABJZnY2+DSovOLnwhWPWGhKr+7RFbswwywtnIKm8tZybbRztrFUr/erYUeMRvh+Se/3qr79Rz
 qRmQXOQ+OchJPTmx0nG8+NTCIWL7Y6wMjbDEUEO4SE2h9y0GxNjynB3v0s0qDKh6dfMWbN61zCN
 G0XpHD+I9ymUhkF+sP7bLG1n5jV9IBLjhrfldsKgRThZxPvUgCETe8zgakUwuThGjRyQixDSvv3
 8rVtQWZ9TeanchGzrD3Cnj4JJ5bX72KjvwN+HyIb29K1h5Pyd/vouFqdzck+nrR/+qrJuo0qdhs
 H1Q==
X-Received: by 2002:a53:ee65:0:b0:64c:a63f:87a with SMTP id
 956f58d0204a3-64d14380ef5mr2295233d50.79.1772821633731; Fri, 06 Mar 2026
 10:27:13 -0800 (PST)
MIME-Version: 1.0
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-16-peter.maydell@linaro.org>
 <20260306173942.000008c8@huawei.com>
In-Reply-To: <20260306173942.000008c8@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 18:27:00 +0000
X-Gm-Features: AaiRm50fSEjeYjydGvMhaK5ACqlNoJO-h-h7DcbhZusj1LaYdFa1mVg7uB2dufI
Message-ID: <CAFEAcA_zOCDyHrZV6+JmU4pw_T5TTv9W5sZTL+aO10Mzf2cFvQ@mail.gmail.com>
Subject: Re: [PATCH 15/65] hw/intc/arm_gicv5: Implement IRS_IST_{BASER,
 STATUSR, CFGR}
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Fri, 6 Mar 2026 at 17:39, Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Mon, 23 Feb 2026 17:01:22 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > Implement the three registers that handle configuration of the
> > interrupt status table for physical LPIs:
> >
> >  * IRS_IST_BASER holds the base address of the table, and
> >    has the VALID bit that tells the IRS to start using the config
> >  * IRS_IST_CFGR has all the other config data for the table
> >  * IRS_IST_STATUSR has the IDLE bit that tells software when
> >    updates to IRS_IST_BASER have taken effect
> >
> > Implement these registers.  Note that neither BASER nor CFGR can be
> > written when VALID == 1, except to clear the VALID bit.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> One query inline but it'll probably become obvious later, so
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
> > diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
> > index 7db2c87ddc..2a49d58679 100644
> > --- a/include/hw/intc/arm_gicv5_common.h
> > +++ b/include/hw/intc/arm_gicv5_common.h
> > @@ -62,6 +62,9 @@ struct GICv5Common {
> >
> >      MemoryRegion iomem[NUM_GICV5_DOMAINS];
> >
> > +    uint64_t irs_ist_baser[NUM_GICV5_DOMAINS];
> > +    uint32_t irs_ist_cfgr[NUM_GICV5_DOMAINS];
>
> Feels like you are going to have a lot of these, why not an array of
> structures?

Six of them in total, at least in this series:

    uint64_t irs_ist_baser[NUM_GICV5_DOMAINS];
    uint32_t irs_ist_cfgr[NUM_GICV5_DOMAINS];
    uint32_t irs_spi_selr[NUM_GICV5_DOMAINS];
    uint32_t irs_cr0[NUM_GICV5_DOMAINS];
    uint32_t irs_cr1[NUM_GICV5_DOMAINS];
    uint32_t irs_pe_selr[NUM_GICV5_DOMAINS];

I tend to implement banked registers as separate arrays
because it's what I'm used to from how we've done the
target/arm/cpu.h banked registers, and because
 cs->irs_ist_baser[domain]
is a bit shorter and more straightforward
 cs->regs[domain].irs_ist_baser
and because you generally don't want "the struct with all
the regs for this domain" as a thing itself.

-- PMM

