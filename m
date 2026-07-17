Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA287C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkiw6-0003oY-HN; Fri, 17 Jul 2026 09:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wkiw3-0003ix-IA
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:49:04 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wkiw1-0001RW-Ta
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:49:03 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-81e8fa1b8d6so73725507b3.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:49:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784296141; cv=none;
 d=google.com; s=arc-20260327;
 b=mYtaOJ593j49DI+WSehQhf25dlppL1m4Qe1kTaIOx8CjxcngWOYTxkDvLvCPPGqTim
 Av8smAyFKqXxnhEHHP5SQA5RABKH+oow1vwW1+rt+09RaaSbvq9tWnQD5zP8ALwxl6Le
 WpjW7dFzYXEUk04AkTMMrz3GXpWUc9R16t/A73CtPjOUjTeZG9MpyuRHJHyK4TSdPZJ6
 QvWBtXS0Qq2NUqn17mb+lc8DY7vdi7aD7P2XJgkeTt7MykrJlwKpIvrnBWZAYycG3VHE
 CaenivQ+epq7jEl0DtBvWmxzFD3njZIFNVJm+Fzb55+MK9AbNQXRyyGLgF5GRt8pEFPe
 rPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Pau/hqnjfNhTDxxEOa+7xlzUJvLSNPTqET0lqCQpKHo=;
 fh=b73Juu8FZ0PLXL6YfPDAQXwDYgIVUN202sDzjg/x4UA=;
 b=HVojL18m9tn8OI4/dFaCINXlI92lc/aIN1Dqyc5PjU1c9CDukvBWqgc1NkICU59bXx
 ykC8pMS/TnmoK3lBnu/M42JfpwjS3s4LfcSRLv9G8itTzS+/BP5Wwat63QiGmXuOEbXS
 Gfm2cmYAQVz3quBq50zxSuQ+16XhL9ZGFVqYTyZwcuPVn0KdR2e9+Q+G4digPjLv80yy
 yX6eSpqYotCmon36E5IWwj2tov8zOMq2cAX8EM5lc4rz5gAG0y4uO3aTyKO6u5TDz/z6
 c710gjD0ioHVo0rbeddYspgBb+qhteHKz80PUEsGsm8E8OVsHAdNtfB+ZAZqvIqtcdQX
 bZ7A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784296141; x=1784900941; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Pau/hqnjfNhTDxxEOa+7xlzUJvLSNPTqET0lqCQpKHo=;
 b=h/gLhW2pH9tDBd7DQerlz+x5fK9/ld2n9Vgl4bkyaj6yqiQTaZ6D4K3x6+tPFPgxnd
 Q747KvHytsrmi3bF6qnYOBW0Dfc8VmCBIJ32jY8TW/iIsy3yBM2H1dbbPU6jI0uQCNNa
 YdlHehI5D6TnLvahTn+lWbxaVDTueN4MDNXh3d0Kng7Tc+oqXl/WgfQhGIJXI5La/YNk
 D1VDHQO6jmxeWihzk8V8PZu5HRiNH4bNzOmYndbYS3OJItQ9TmvG4RYupmG8phGNvRMl
 1CM6ZROGgZJi34OXf5MRx9lvEJDKZnI99TE5KuoY8q1tfoOG35jrD9KmZ5VSmGHB23KM
 fg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784296141; x=1784900941;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Pau/hqnjfNhTDxxEOa+7xlzUJvLSNPTqET0lqCQpKHo=;
 b=Gpa3YBeCdVjsE1tdP1ZalXxv2AkApynQ0eFYFRXWbR1d7HVCA9RvdX/9PHdZ9YDkeV
 MHhFDZBCJXSzYfEuGzdcfOtbX/d3p6jXmH1mYcrqEqxJUvSxPtgdkuq5dwecKvl3j0WS
 0AIkPuGxsk4LV3J5JoHYItXUnhv4q+gnL/ywFIjF+t6bSAC51FXYxTuX/DS82W4GiofX
 BFeJDneUkwaKjfKmVh9YwOfxeRuNkgQme9hnm10mRbjA35h0qDobexwKyCol8yJ9KFdP
 vLSZ0ogJnOZk4PSAGcyD2/j3ykgpNSB4CTsdjVFWXkIE3duUcn7s+t2u1HDyZD3/jPkK
 O5ZA==
X-Gm-Message-State: AOJu0YwJyfBn95CJMd7Qon6NsiVC2U4PN3rZldpTKrfMQu1qfIBseaWx
 ND5Sv5Id/BrQ0wdjto7jqDgGtX+TBYBNtKQzre7bGxzPLm9MEiuPQEl1/Kl9b4f0lW2x9FRuvi1
 siUhYyFAVNnzfRuWxwHtHuDfXpAyNnwsc4+5fLS3LTw==
X-Gm-Gg: AfdE7ckJ3ilu4uWSY5RdMt6WBbumE1j1ZypFq4uRd/d/G6ilNROig3saNqAi7yUrN4q
 5LHDIRQQkVF8fJmah1JsC3B3gKqhN7BfcpJWfCpoo5Ccmlba75FBS9e+0eyxGql0LGaOSkZ/U/f
 TOcvXplJABc5z32ekRfD8eQGMw4s/1VNJYiiADslM1YxIJDJSbCdJBBpN+d1RWA9ceErbNVhnpS
 tpkRzLGYNOUegDuXp0uDmUxvZMT2cHCeRtIKuK6IL/qjyYbCOsuBQOkcXG+W3LjYRW44jX8EmiB
 h9kx7Za33wRtl4mHM73PYbEFnec9SodhXs46b5dDw+6cpLHoiRVQaIac
X-Received: by 2002:a05:690c:6c8d:b0:81e:c016:5b48 with SMTP id
 00721157ae682-81ef28620a0mr8190717b3.64.1784296140520; Fri, 17 Jul 2026
 06:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260717113006.172612-1-thuth@redhat.com>
 <CAFEAcA_0q+3fi406hhVaj-W6e+XgkAU0jACVQvAS5FnSUnq+fA@mail.gmail.com>
 <7cd279e6-f79b-40e5-94a2-610a60d57fdc@redhat.com>
In-Reply-To: <7cd279e6-f79b-40e5-94a2-610a60d57fdc@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jul 2026 14:48:48 +0100
X-Gm-Features: AUfX_mxjyHd3ozq-HUy8XHvEbzGU8gjfuMJOzCJjeYcY5S69XNyzYlpBkydppfo
Message-ID: <CAFEAcA_9Ps1xWqnDan17D5uzxFKQ9g=r2pGRPjmHtubEbF4TCQ@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-xhci-sysbus: Fix OOB heap access in
 xhci_sysbus_intr_raise()
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-stable@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, 
 Mauro Matteo Cascella <mcascell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Fri, 17 Jul 2026 at 14:13, Thomas Huth <thuth@redhat.com> wrote:
>
> On 17/07/2026 15.02, Peter Maydell wrote:
> >
> > This doesn't seem right. If we've told the core XHCI code that
> > we only have one interrupt line, then it should not be calling
> > this function for a nonexistent interrupt line.
> >
> > In xhci_event() we have code that (a) has a special case
> > for numintrs == 1 that means all events go to interrupt 0,
> > and (b) have a bounds check for an out of range interrupt number.
> >
> > It looks like the call path via the ERDP register write
> > is missing an equivalent check.
> Yes, the ERDP write is the critical code path. I can move the check to that
> part of the code, fine for me! I'll send a v2...

In particular, looking at the xhci spec, the registers
involved here are a set of registers for each interrupter,
and the spec says that it's up to the implementation how
many interrupters it has.

So I think that in xhci_runtime_read() and xhci_runtime_write()
where we do:
        int v = (reg - 0x20) / 0x20;
        XHCIInterrupter *intr = &xhci->intr[v];

we should be checking v against xhci->numintrs, and make
the access RAZ/WI if it's out of bounds. Compare

https://docs.amd.com/r/en-US/am011-versal-acap-trm/Port-Status-Control-Host-Interrupter-Event-Ring-and-Doorbell-Registers

which is an implementation of xhci with 4 interrupters: there are
4 registers of each type, not 16 (XHCI_MAXINTRS).

thanks
-- PMM

