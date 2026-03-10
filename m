Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A63EFCD9F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzttj-0006AS-Ig; Tue, 10 Mar 2026 06:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzttQ-00067G-12
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:00:48 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzttO-00053d-Cw
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:00:47 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64ad79df972so12262395d50.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:00:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773136844; cv=none;
 d=google.com; s=arc-20240605;
 b=U4AzPyllXBeCqc/FA2t6dwPbUdbj6WwatpUsrP/FMDqYMs3kanyxETRpeRLe0dNU71
 0zx4CB3JED4u1RWZ0pNiWaiNF82f2zobHRhgMF3EfnWAEQVG5SjEYSDzDepDaAKx2fVy
 yRDH88nrvfbgQZJfqny6sNGRNZcJweRm7AmKYKfQP42wUUudjx265vAvs/TqkGnn1Szj
 3CtuKggp4tayzChdBDKTxerjPXPYjDcFe2i588q5q8UuTcntZZgcX/Hgh5dqt1TBPNQW
 dMJv+DDHs0meFU95MwgpOqjCuKyMvdxZwLE8QDSUsMkmjr/y87WEbKn7S1YmJr/LgTKP
 eJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vA538xkBYu+c5ZewwjzFctB957ziu1EwWSk+8q4qAS8=;
 fh=BBXXBmZbsnh1iUcPA7aYGot0GnoKedpL6BO7ZAJRQVM=;
 b=EkUrmbD0S6bZvw6d1gpe8sxKk7d/+nAY6RniDkHKCWFPb0wYhNA5KHtFLqFST+v7th
 oWn8QNDlMobLJ8mpiwmsf56NjeP75HzHogaDhj5ZCg9k/xcuA5iiBhb4rsE831dMlVOP
 CaIeb+wXeUpEeYhapB5E+w5oWyRnCoS0o//e07In2jtI8fnWFfuOkyBgMFW/NnZ4+/6X
 AUDQ1UvACsabzMTkZ1Z9a9b9gzpyRhnOgiEqtE0hpHCKoPcr0eVD4c0M8vUpCoPRBdeo
 gUKVLbRB+mm2a/kC10FtnpLHMJBWoFS3jkP1aW+yXuiZx0ldpZIkIBigy2NGuGAVDooj
 TcqQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773136844; x=1773741644; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vA538xkBYu+c5ZewwjzFctB957ziu1EwWSk+8q4qAS8=;
 b=FbDOiIlA3TbIu1f/Bq3GAGhxnMGb8sp/aoCNjH/ZelBaLLFXmTl6d4nAQuwQUs+QEr
 59V36LMiTjEnEJI1/BeZoPm11qBftCNAju4APeipebtvYYCJLKhaptGqSw+NwT6HeWl+
 M240jq6Q7fvZnnYpoL0aPgh28jEZb7+flGefdCyFvmb9GnMA/3g0FDFnBUQ2IAz03AbF
 0VsYG9ztoHtYDfDodBpYubEkBDTa1xCyu2Ng7XBeiD/Za7SAJgOecwVGRjzBidpiI+Ro
 f+NPP3lfI+HZ0Ss/4bWqSmVYofCXRpzI8s7B5vRqY4m/sCYf2tkJJ/gl5QHphH5v/X5D
 PQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773136844; x=1773741644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vA538xkBYu+c5ZewwjzFctB957ziu1EwWSk+8q4qAS8=;
 b=hZqWVRP3pex1vM11iv7PyXaqLx3Bh5FK2gxDweSh74QAF7v3R4NbruvCVICPQsYthk
 2UIX7XYswVDsskFC/hl+JlaJ1qQraUvek6yLdck5BCWr2Zytub34xGCAqWhllr8HWVSH
 bmCXchFfijIYQJKAX56BDAB8H3dyZ+hdf05Js5GDVY1o+qepFBuwR7kIxB1PJcCrD5Dc
 e8lFEfON0Ytu+g4XHHlRIiATxIs6tVAxEsQZU0W01SLv81BEkZLQxXXwmHUgDbRdrgz6
 XmNV9vbpR0ovViioZxufhO7Y6r7Lo9yMwgBKbGadHhtAesDcK/PnWz6Ngbe7iAIM4jyi
 MHyQ==
X-Gm-Message-State: AOJu0YwLezt+KhEdO1EFMiUIr/gwhOCvw3PHprspBOOcf4gYmZR6Wyfo
 0//69ZeYCTeRN4YxFCA+yNdrznwvBuLkmm67zwuwSRHo1SIEk3ukMkQFad2KYoDShmUlDiBC3c9
 /tIsF2K2kCrYSZST0/iqDmhWcIT+6kG++Cnexq2QszQ==
X-Gm-Gg: ATEYQzwuYhkj8uHn7cEv9tGbRwG8YyERhnvNwhD1JlhLtKQ+PjQ4TYVU19fQJ0ltexX
 TG3FOhu9auL1LEAZ85W9zLWKQycbjaBp6cNqeHXVb/YyhlIz/iWyTmZ8o60rnwW8ii2ptg5lkJt
 lddZT+bhRd4rrzJk6hyxrRvSkKHJtybpAcaf2VYVmkP/gFFx6+EavXoygL5WabqZEmX0mdRTSwZ
 00zTmwnQqqfN8SE5c/R+w8B+RYfSkIQBgt0bODLqc3Glvkfm1EMUwUWcYLCMorjJ9pLSOgVpqr5
 JgCFd+yyR03a3iGPzcN9/3uk7lO6Yu5dCmRGMW4XRXAmLBLePPwe3HguPY6AYSeM0ls=
X-Received: by 2002:a05:690e:4105:b0:64c:a2a4:476a with SMTP id
 956f58d0204a3-64d1414c8c6mr14466003d50.32.1773136842691; Tue, 10 Mar 2026
 03:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260308203516.160103-1-shentey@gmail.com>
 <20260308203516.160103-3-shentey@gmail.com>
In-Reply-To: <20260308203516.160103-3-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 10:00:31 +0000
X-Gm-Features: AaiRm521S2O4yW12FYeF5vn5OVw-337c587GtbvWBH-2aPT1g1EoBsPEuS4-f5M
Message-ID: <CAFEAcA9cfiDB3+=K+MsHptujVhcPexwaf+1y8kHaV692ORAdgQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] hw/arm/fsl-imx8mp: Fix parent of ocram memory region
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org, 
 qemu-arm@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Sun, 8 Mar 2026 at 20:35, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Rather than having a NULL parent, let the containing SoC object be the
> parent. This cleans up the QOM composition tree a bit.
>
> Fixes:  ("hw/arm/fsl-imx8mp: Add on-chip RAM")
> cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/fsl-imx8mp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
> index 0119a18416..839c925e4a 100644
> --- a/hw/arm/fsl-imx8mp.c
> +++ b/hw/arm/fsl-imx8mp.c
> @@ -671,7 +671,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
>                      fsl_imx8mp_memmap[FSL_IMX8MP_PCIE_PHY1].addr);
>
>      /* On-Chip RAM */
> -    if (!memory_region_init_ram(&s->ocram, NULL, "imx8mp.ocram",
> +    if (!memory_region_init_ram(&s->ocram, OBJECT(dev), "imx8mp.ocram",
>                                  fsl_imx8mp_memmap[FSL_IMX8MP_OCRAM].size,
>                                  errp)) {
>          return;


This is a migration break, because qemu_ram_set_idstr()
includes the qdev path of the owning device when it
creates the name of the ramblock for migrating it.
But since we haven't released anything with this change in
it and this board isn't versioned either, that's not a problem.

-- PMM

