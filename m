Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E016CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrz7o-0001no-P0; Wed, 03 Apr 2024 07:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrz7k-0001me-Ny
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:49:49 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrz7j-0006GO-3o
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:49:48 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-516c11b6af9so120773e87.2
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 04:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712144984; x=1712749784; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q04MB9sbtDquxr5tfECR0Pc+WkFOv2d45d7auHnPkmA=;
 b=rTiKymSVsIfF0jepYx6m/kQe83jNR5mGrtY54lYY4QrHbOhr3c9jNhm6pBd1cDsNu2
 kJTUnEH55fY0RTyjBqcZbEnPJ2Wsz6aEOZVRyJJMQ85SMoHiJG26jnGHq9CsG1hTDI9t
 jdpypGuPQZKcbzGT8BXrqlfvQuPafI8CaT86f0su1N2sEUVXRfNPT5u5se9lvTtMcGXN
 T9Igj/aH7Z479P6wwHYk0c7iaJ27zApJPsY0SQIRyc/b96grSXhwAz5rId2qjFRuI7TA
 Z3hBrLeyJ7E3pyryHvci3dAWz+V0SlT5QHPk5jxaRjAhDlm/ApfLXvEgT0Yngrv4oTni
 YoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712144984; x=1712749784;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q04MB9sbtDquxr5tfECR0Pc+WkFOv2d45d7auHnPkmA=;
 b=p1o5t6tzL/cCEpnLEl+ublgrgLLjVnvmUzgBg2h2Aq0bGj2qz7zHrHIXnS099UwBzk
 KCpHlm9fkC1+FDlMtPQHht+GBCjAWtkin0zCrm+2py2YojHsX2aP2j16/oXvZ65piFlz
 UAJhyaSNrGpVkg6idCsPptqC4dYmiGV5bRIAn49bNXA3n/vc0fAaEorJLxgQRwMuahOu
 e5eV1ZJ59uxDZoxfXm4V89/StOgDV7ef/8yP5um8GiibYRWPgNZCVE371aTBdefbxEri
 TlJYfcfMwRgheB6vPCtg8Ndtn3LrKuYZ6MlKLNLcbOWnclVzHoBshLMH7x74yPioEW6D
 82AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDpQmWczGVDDwgWyTuycyxDfwIThjdBrr/61gFEPa4Fq8/PYsqOBGRSJPKKjjHFRvG2Lr3/WPKaP+hzuY//M9jlfuQWQs=
X-Gm-Message-State: AOJu0YzAcRCue6n2/RXM2GWnyPNeWtlNvBcx4s416b9bLNbkhC5D/1J5
 Y/WBgJfers/AzXx4zBib4YsIYakOwTracFTBQyLuj2qwBoCEgKOM3GCXtasmXSur0qD5jP9ooRj
 AGQSpqLkc0qViRgs/9XAjKKSpPI4YeY1FfYMAUg==
X-Google-Smtp-Source: AGHT+IHETg+DW7wEI7VIwC7RZgtjWqUJ1WfHhbJqO41hWKlSkU9VDL75XLotl9HvCb3CcX5971nuZYoChWpujPSYYXU=
X-Received: by 2002:ac2:5f49:0:b0:513:ba98:36a with SMTP id
 9-20020ac25f49000000b00513ba98036amr10290422lfz.10.1712144984208; Wed, 03 Apr
 2024 04:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240330103128.3185962-1-ruanjinjie@huawei.com>
 <20240330103128.3185962-19-ruanjinjie@huawei.com>
 <CAFEAcA_WY04voee07n6Ph606xqy=QvTkYdMyqYf5LMHUS5GcDw@mail.gmail.com>
 <6ff19301-8791-384e-bd40-5f58058f4234@huawei.com>
In-Reply-To: <6ff19301-8791-384e-bd40-5f58058f4234@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Apr 2024 12:49:32 +0100
Message-ID: <CAFEAcA_Y_0SSaX_mSAr5eZvuU2fxPUWMow-0=4Bb-+2ofY2pEA@mail.gmail.com>
Subject: Re: [PATCH v11 18/23] hw/intc/arm_gicv3: Handle icv_nmiar1_read() for
 icc_nmiar1_read()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
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

On Wed, 3 Apr 2024 at 04:16, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> On 2024/4/3 0:12, Peter Maydell wrote:
> >> @@ -776,7 +811,11 @@ static uint64_t icv_iar_read(CPUARMState *env, const ARMCPRegInfo *ri)
> >>          if (thisgrp == grp && icv_hppi_can_preempt(cs, lr)) {
> >>              intid = ich_lr_vintid(lr);
> >>              if (!gicv3_intid_is_special(intid)) {
> >> -                icv_activate_irq(cs, idx, grp);
> >> +                if (!(lr & ICH_LR_EL2_NMI)) {
> >
> > This is missing checks on both whether the GIC has NMI support and
> > on whether the SCTLR NMI bit is set (compare pseudocode
> > VirtualReadIAR1()). I suggest defining a
> >
> >         bool nmi = cs->gic->nmi_support &&
> >             (env->cp15.sctlr_el[arm_current_el(env)] & SCTLR_NMI) &&
> >             (lr & ICH_LR_EL2_NMI);
>
> The nmi_support check is redundant, as if FEAT_GICv3_NMI is unsupported,
> the ICH_LR_EL2.NMI is RES0, so if ICH_LR_EL2.NMI is 1, FEAT_GICv3_NMI
> has been surely realized.

As far as I can see you haven't changed ich_lr_write() to enforce
that, though, so the guest can write 1 to the NMI bit even if the
GIC doesn't support FEAT_GICv3_NMI. If you want to skip checking
nmi_support here you need to enforce that the NMI bit in the LR
is 0 in ich_lr_write().

thanks
-- PMM

