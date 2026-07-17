Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48C1C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkiCy-0001PF-HF; Fri, 17 Jul 2026 09:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wkiCm-0001KL-Nx
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:02:20 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wkiCk-00049p-5w
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:02:15 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-81e95760e42so10616677b3.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784293333; cv=none;
 d=google.com; s=arc-20260327;
 b=h18VUrwcuCAJhVE/viX8vx9s44UhrWxP/VyTt5/8v8EsRldqMdhrnrHRjSEGAgQKWH
 EKy5EaWnN07oKfM5d+Y89ph+ymVHOSfAD3QL5xpQ2DjzKnoaHJZ4qZjxLhdnj8x8rbAF
 gk09oXvNQT52IuQhmR01qz3AKDnMXvEBsLwGsElxIKYTujjAFaIoY3vfraHWtgjCMUIW
 FtAnmQLi7Xhnfq04E2WJ2d7wrXQHIDAD0oyKZqb1SblJ9iagbSB1SaP4mGvp4hpSp1ej
 0owgNdHrZPBSon+lMEs0K2cN2e/n5FsY3y6qlnExbXpTmTCkIUvm0eUbObTgjXXWv45V
 fX9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RYwIzByNUXlhb4UzUHw9YXC+VUrkWsAj6euNw8bGOrw=;
 fh=b73Juu8FZ0PLXL6YfPDAQXwDYgIVUN202sDzjg/x4UA=;
 b=JqUeCl3TyRxhW3vXbPIgs1v8Jzm1mHjSworJHOIfpZEpuxQ5ingJ1chkCH4M3wveOU
 AoJkEZBhVjaRMaEH4F1paX4X6Kr/z72yrHVhvlN3OG7K1j2YSPexYATsgtN3YNL/dIm6
 b1UTSGKhs6DShIveP0qQLUGgglHS5aMhKNbDRzWnhNheUJY4cObRunhdY/lN/4yzBOtj
 yUgnrKVk1XzBm75Wt1+YMPNUycUXcPoswNt7NdzEc4sjd06KHSTVF69T7ilabFyV1od2
 TT5Zk0fY8yNJoM7TXknri2nIfbqABxTNcN79a6hU4P90Tf92EDPGY+4BelApp9Y8wJp6
 Whrg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784293333; x=1784898133; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RYwIzByNUXlhb4UzUHw9YXC+VUrkWsAj6euNw8bGOrw=;
 b=l+KDx7urgrxO3z1GtJIJ+VCBpWkiHARDhJZHHppK9PhUFBzyJj+mpAzoP0x0AQQo91
 T1zz8ZbpUTZAmDLf0cSujB7t8B7u/UBDirQNQJ/OKFH7RQem453QswIiVll67ROmJCeL
 HnyBfkCARJxl4qgdC1Q8ZWINJyAaeIgt1XnDTpARNoCNgm6vaynUxfP0HzpzV63YHCmU
 pU3LpexCkP4vjop+5euqf2FpWZ9XBT7kFS/uo4h4c/ZG6c412cPkCaCtmm64mRgGfye8
 iPd0mRyYO5BIAE87WKxdrPCUDQRnj01ox1cMWfMMRTZbRlYgulPi1fxahewDi3q3svPl
 zlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784293333; x=1784898133;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RYwIzByNUXlhb4UzUHw9YXC+VUrkWsAj6euNw8bGOrw=;
 b=Mmkc+Jx8E8bHMZYRt4cUN8UATLi42HHoBK+4YqlN59Zc5HTMDg8Ja3H7Fqsqw+/O80
 zg4eLOePw3BP3caH6qHXayHfz5NrSuzO6VXFNEaYNl5yKHAQ2/6uXifjV5skWRkAXBTq
 douna79GwohUZ8ndsCf+0pcZxbDJFwxD28grmIDlC8u40KBFG7pgA4/nIChvPddtcltU
 oSy6JHa6DlzRHXN1ZIAiRhxLpdOxDQsNrS8M7KvtbYlHBTkEqwIXELUHX8fOQtpiZXgV
 VZJVgVIvbXQNjzJYJXmpIHrrr2U4b63F2SqHfnWxJoOC96/qOmq+nM4SGDmVaveNY40Y
 uyqQ==
X-Gm-Message-State: AOJu0YxyU/6WuOFrqlBnw+CIfH1qYcwzk3fYq/15+abXcazA33vpYISJ
 GHfLGwyVbmN1o0mTnSIMmxP7pJt5VT+zyu+LlK0VRfZ8UfvGTfAI8GjQZ+3oeCBTLP/qkmC9IKS
 mtA/rsnDCs+9/4w7csEvy5TWQzVHfjQ6bXoH4hrgTtg==
X-Gm-Gg: AfdE7cn7NxPADx4ndPOll+/okeoLbFogOfE9ITOTVZroFnFaw65mHmV5xc9saHnPvbu
 99/a4s7P7lEDjCY1HWL3/4rQnax7XStNaEsU/kOLg4vb+I5JKasL38/pqQz8hzjAEJlZXfESPUK
 6lcSc98rhoJFpTuchWr3Rd887oBNMuPnaHUac454Y8aubfjY4BCd79qNTbCd6MRz3RGRAVIYEl4
 9TymtcXqshovamd0fEAG60J0gS1QWaYZ+lST52qfC0NMOx3FCggY6FMDsS+MIMYoC1d+5dfbojt
 QdC+8vtvqCGdrdfmRlgII3dZTFuM3+MfdA8MKRW90sjOcd9a5axeR/sV
X-Received: by 2002:a05:690c:4d83:b0:80c:3848:bdf4 with SMTP id
 00721157ae682-81ef2671daamr7979147b3.41.1784293331000; Fri, 17 Jul 2026
 06:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260717113006.172612-1-thuth@redhat.com>
In-Reply-To: <20260717113006.172612-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jul 2026 14:02:00 +0100
X-Gm-Features: AUfX_myFxBBd2zp-LP5pUVQ_vKSDVhYG2_rhDPYG-0plqjYEONrGT8_wo5lk3Nk
Message-ID: <CAFEAcA_0q+3fi406hhVaj-W6e+XgkAU0jACVQvAS5FnSUnq+fA@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-xhci-sysbus: Fix OOB heap access in
 xhci_sysbus_intr_raise()
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-stable@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, 
 Mauro Matteo Cascella <mcascell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Fri, 17 Jul 2026 at 12:30, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> Some machines like the microvm machine instantiate a "sysbus-xhci"
> device with just 1 interrupt (by setting the "intrs" property to 1).
> xhci_sysbus_realize() then only allocates the s->irq array with one
> entry.
>
> Now the generic XHCI code has at least one code path that could call
> the xhci_sysbus_intr_raise() function with n > 1, so this function
> calls qemu_set_irq() with s->irq[n] pointing to a bad heap address.
> The qemu_set_irq() then tries to call an IRQ handler via a function
> pointer in that heap space - which either causes QEMU to die with
> a segmentation fault (if it's a bad address), or even worse runs
> some unexpected code if the destination of the pointer is executable
> code.
>
> Fix the problem by checking for valid interrupt numbers before
> calling qemu_set_irq().
>
> Fixes: CVE-2026-16043
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4001
> Reported-by: Tristan Madani <tristan@talencesecurity.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/usb/hcd-xhci-sysbus.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
> index 19664c5985e..7ab2f8527bd 100644
> --- a/hw/usb/hcd-xhci-sysbus.c
> +++ b/hw/usb/hcd-xhci-sysbus.c
> @@ -8,6 +8,7 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "hw/core/qdev-properties.h"
>  #include "migration/vmstate.h"
>  #include "trace.h"
> @@ -20,7 +21,12 @@ static bool xhci_sysbus_intr_raise(XHCIState *xhci, int n, bool level)
>  {
>      XHCISysbusState *s = container_of(xhci, XHCISysbusState, xhci);
>
> -    qemu_set_irq(s->irq[n], level);
> +    if (n < xhci->numintrs) {
> +        qemu_set_irq(s->irq[n], level);
> +    } else {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "unexpected IRQ #%i raised on xhci\n", n);

This doesn't seem right. If we've told the core XHCI code that
we only have one interrupt line, then it should not be calling
this function for a nonexistent interrupt line.

In xhci_event() we have code that (a) has a special case
for numintrs == 1 that means all events go to interrupt 0,
and (b) have a bounds check for an out of range interrupt number.

It looks like the call path via the ERDP register write
is missing an equivalent check.

-- PMM

