Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2C3C4451C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 08:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wl0NN-0001ib-Gp; Sat, 18 Jul 2026 04:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wl0NL-0001iH-3N
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 04:26:23 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wl0NJ-0007nt-At
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 04:26:22 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-81062fdeaf5so23017887b3.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2026 01:26:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784363179; cv=none;
 d=google.com; s=arc-20260327;
 b=AFeu7NI+GJOejUSA/8HBK5G17p7NPPmn8jdAx36qtxzK5UgGyJREaBql7JLsB+KBBS
 f7Yet7CdHxBeqfJcvhnC8Y3+HX7hF7XvP8jHC41TrA8UadPVQdGWiSHN05RzzrK+XJhU
 zdqSJPS5tc85Zz0SlgV2c2VFEAoy4UoKbQBIMRi/5xjcfOHY+c02KgWkG8Yjat9E5ffS
 wxdzElZHlINrcVZfkDKo6VHiUIkyLmN2rz+RA4O33zt3kOnVlJLCqIK9eB3bzTHyZEq+
 tApc6NvTt1XmHjasV6HoUBWSQ2H3YvNgWhuBqiprXEtziT3eYteEkVjmTvEHmXn4UOih
 /keA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YuR22fjDlUsw3AQzPl6B68oIYVRuajoftYthIhXp7r4=;
 fh=al5FSA0QDJIfPMoyjfWiwC7oXFj+LfcBdbFSSZtoaSQ=;
 b=Wl7ENHbymZJhAuh6MbIkSrOyIWlAh7VKx7Jm+mWiotaU4gZqzhYHlckqnHpoHc3N/H
 fnji13NsiXzMn8+8ic/bPgMJP06Spm7OhUC9zoLehmgmq9M8fBS0WEilKmpIfCuPV6cs
 hsk/NOsXI9CLyDTEoQfUQ/J2BYAIHPo2mM9KqMzgInyUDGfTvyhLDjdSfGs82W0cu3W/
 yWLFXOkKy4LIWQ5oC0MTPFlhvo0ZAYAHi1J4MUn6jyyMWiL/bP5dfMGlsuv6TChvNL9T
 vOfIKqkdfR2zoBC19B/+fBmI8Dz9TmJCE18FCM5c5aeL5YHHKvBOdNNii5MgsqZwKS2e
 ma9g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784363179; x=1784967979; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YuR22fjDlUsw3AQzPl6B68oIYVRuajoftYthIhXp7r4=;
 b=etyaUup9ZnhJwliutkMdRIiECykswKHSXXcV6x810oYU/loOeGYkaEDglcSN7Ce6zF
 y0N+7sQxUC8QnitNgcQLrC32prbVkgR/bWVuY6kxtoOv9mr57oc8uFB4/gOE6+AW1UQR
 F0TbV0Nx2wLnbhulbd1A47PD94hQ4A7PTfJe7aWlwrIJsuiDXPQOD4xzVSHzqAk1NqCD
 fp1k67Aysta7c+k7Mh8vkggh6PUCjVA+XDpJ8wK5ecdIIrMa2J52XRNd9KBLUyhHgeEK
 czyFwFO8FXMiJqiXqK6cZDqZLsBECzPhV4nVdRxxbRTeTds7r9kR0aERqqF+oRBaz/2a
 uh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784363179; x=1784967979;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YuR22fjDlUsw3AQzPl6B68oIYVRuajoftYthIhXp7r4=;
 b=iR0YjsR8oE5Ih6GZsz6QmFINQmWUKRj8+rKVrkPPZHmt5v0DzqBsNWjiiwYjMTlqGn
 KiT8gQdaZzXLvtHw7zZUFQuiG2GzSKx9MBZfdOIgC3YK/j/5861GDyboPoboTxoZ8ia7
 QH9MwwhQ5FbmXyrysCfvRzdFGoUyD9hf8cvv/ygkMu7jR1jX5U+zA2Jq0UXj7kXU50K4
 C58eJtH/sqiBr1hqLoI8+tp1N4xur8zR84ySOgKhjHO+9rkr5gJExXog2fPq35Zq5CaM
 qw2wQQhOvckzUm+7jERuw3jj/4+ai/4oozGkNE0r01VJf2geffWV8t2RzDRHOUcN8QFy
 dfUw==
X-Gm-Message-State: AOJu0YxuW7gj3Ru/JNS2TDNBgG5wYRirRbDhdlO225g6TbumDb4RtVb7
 HyBwmJBM+cJsZjT4ZAU+1gGy8OwyBKGEQ8aS6zjDOXwfAOGgKfFqNNL334eFN+QDjrpps8yUC+5
 yYUP21pL1yr+lrh7JAa8md5K9GzQbyZVYz+6pyrLh6g==
X-Gm-Gg: AfdE7cnSjCnizBFLyQL371YT4OqjlxblgTZgcO6cVW1C6HdsvPe/d3R/HDT595NfY3X
 nPvOAFLnsPf0NEMfROJRLXcFli9tF7rVhT9lMHi5ENVgcWeBFm0ZAyRcnRLitbCO4rtov6O6se/
 uzYSuv186JM0oeVLeD95J12v9TwdkrdM4WoEtYqF7ur6OSEp9igyNcfNmyH+hwzxo2HvKnFidky
 OlWzq4LC0gJucMUZpdeMjGdZ7lpZk5RbISDjIDCL63VG+RFji8VyY35Lg2scXi0KnC07lNhkUdd
 GjhFxACZOgUnvhQO6wY7b+KfLCALJpuUY2/aOFN8WC+h8PH6BH7fE3Ks
X-Received: by 2002:a05:690c:f06:b0:81e:b78d:688b with SMTP id
 00721157ae682-81ee280f13dmr56999437b3.12.1784363179412; Sat, 18 Jul 2026
 01:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260717203249.682144-1-thuth@redhat.com>
In-Reply-To: <20260717203249.682144-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Jul 2026 09:26:07 +0100
X-Gm-Features: AUfX_mxPHGzMGb-qDCQhJPJ2bcfjbYrWhFKacrSoO4kdVhy-mEZDvPxKCwJLIss
Message-ID: <CAFEAcA9gT4mM2LQTkuuv4+H8F_Jy1HccT4Z5sTbXgEoQY-TNmA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/usb/hcd-xhci-sysbus: Fix OOB heap access in
 xhci_sysbus_intr_raise()
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-stable@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Fri, 17 Jul 2026 at 21:32, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> Some machines like the microvm machine instantiate a "sysbus-xhci"
> device with just 1 interrupt (by setting the "intrs" property to 1).
> xhci_sysbus_realize() then only allocates the s->irq array with one
> entry.
>
> When the guest writes to the ERDP register of a corresponding XHCI
> "interrupter", the generic XHCI code calls the xhci_sysbus_intr_raise()
> function with n > 1, and this function then calls qemu_set_irq() with
> s->irq[n] pointing to a bad heap address. The qemu_set_irq() then tries
> to call an IRQ handler via a function pointer in that heap space. This
> either causes QEMU to die with a segmentation fault (if it's a bad
> address), or even worse runs some unexpected code if the destination
> of the pointer is executable code.
>
> Looking at the xHCI spec, it is up to the implementation of the host
> controller how many interrupters are available. So if we only support
> one or some few interrupters, the registers of the other interrupters
> should not do anything, i.e. reads should result in zeros and writes
> should be completely ignored. (big thanks to Peter Maydell for helping
> with the analyzation of the correct way to fix this here)
>
> This way, the xhci_sysbus_intr_raise() function cannot be called with
> an invalid interrupt number anymore. But for good measure, also add an
> assert() statement to the xhci_sysbus_intr_raise() function to prevent
> that similar problems with calling arbitrary function pointers on the
> heap could occur again.
>
> Fixes: CVE-2026-16043
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4001
> Reported-by: Tristan Madani <tristan@talencesecurity.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/usb/hcd-xhci-sysbus.c |  1 +
>  hw/usb/hcd-xhci.c        | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
> index 19664c5985e..bbdd5fd64ab 100644
> --- a/hw/usb/hcd-xhci-sysbus.c
> +++ b/hw/usb/hcd-xhci-sysbus.c
> @@ -20,6 +20,7 @@ static bool xhci_sysbus_intr_raise(XHCIState *xhci, int n, bool level)
>  {
>      XHCISysbusState *s = container_of(xhci, XHCISysbusState, xhci);
>
> +    assert(n < xhci->numintrs);
>      qemu_set_irq(s->irq[n], level);
>
>      return false;
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index ae8add4227e..dedce34f432 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -3044,6 +3044,12 @@ static uint64_t xhci_runtime_read(void *ptr, hwaddr reg,
>          }
>      } else {
>          int v = (reg - 0x20) / 0x20;
> +
> +        if (v >= xhci->numintrs) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "xhci: read from non-existing interrupter %i\n", v);

"nonexistent"

> +            return 0;
> +        }

This early return skips the trace_usb_xhci_runtime_read()
tracepoint. A 'goto out' is probably the least invasive way
to arrange to still go through that.

>          XHCIInterrupter *intr = &xhci->intr[v];
>          switch (reg & 0x1f) {
>          case 0x00: /* IMAN */
> @@ -3087,7 +3093,13 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
>          trace_usb_xhci_unimplemented("runtime write", reg);
>          return;
>      }
> +
>      v = (reg - 0x20) / 0x20;
> +    if (v >= xhci->numintrs) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "xhci: write to non-existing interrupter %i\n", v);
> +        return;
> +    }

Early return in the write is fine because we do the trace at the
start of the function.

(I've occasionally thought that it would be nice if there was
some way to have MemoryRegionOps read/write fns have "automatic"
tracepoints, so you could e.g. set ".tracepoint_name = usb_xhci_runtime"
in the MemoryRegionOps struct and have it automatically interpose
tracing. Putting them in manually in the read/write functions is
always a little awkward and boilerplate-y.)

thanks
-- PMM

