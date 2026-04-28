Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EE9FF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 10:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHfvC-0004dT-JT; Tue, 28 Apr 2026 06:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHfvB-0004ab-IL
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 06:44:05 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHfvA-0001Ty-5W
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 06:44:05 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-651c5d525f6so10220070d50.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 03:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777373043; cv=none;
 d=google.com; s=arc-20240605;
 b=CPCQhhLClXliL7ToZdcNqx3A9/xP5JaoME0TWEu62udRbXftKEmtSFTBhx1wjUs5Qm
 QnbjDD45+zkjS+LG7vb/fiOQMYmf6h0bTbMnql1mhwn9Ran3YZrFKsNIVhHuP0zRF7CC
 RIStILp7kgdC5Pw8W1theDycCdrh6sJzU+S5bd8d+D+dL+fpU2LksPpjzZskVaqBftcW
 yOKCcV+ESMFyq6GBI4ELcq1dS2sqUeDA7FKccZ6MfbgWbS0/1+IK4/ijSso9tfOG+dLZ
 +P77wLtQl+PenFO15WLlT4Z6l8QOGxAW3HMHu46nrKjSbz71WTykr+F6TXhkO90rnxK3
 +21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tGn/7ofAJkPeLznmcMGIZw4zwGjdtj37UuvN0GXBlAE=;
 fh=1PNb5bAuBY7pUYShNHxe+USp1zBkQ/9i6CgFUG9bMRs=;
 b=AFu4H9JQNU2BaQJDs/04hQa2KF2Cs/EMwNpCWng+ZrajEvH65xobpuptraPGU1YrWV
 BXTOr4w5qRSacPZ8tJkmkEfEfCdxWaPNfxO3ccjbMgdexqxGeNG01KEDSWN+cUKkv5qJ
 sRA6/421wxOiPauDpvqhg2FsNYd5xE00xo8tk22jsfVkC1DMeSJy7YQCMvHwLYAsQ/e/
 Sn7JuEe+ZI24/mF4f9nJnY+6LVVNOqHdzSlXV7tVQ8biD0AuQgYaFVH3bu31IQVy+KmX
 tEw4coCdCwE8473bdda6XteA5uBwasgeA8X/0nLBgu2oyI4wxo0lQXIJmd/0uQJQljJT
 kNog==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777373043; x=1777977843; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tGn/7ofAJkPeLznmcMGIZw4zwGjdtj37UuvN0GXBlAE=;
 b=hFxFTrt+oNZTAARCTybAJaonN0A0/JE0jIT26sgufrCfgV1G2tWzwWbELmw9G79Fod
 9DaiT4BAZImZYCUE1NCdHo0FyGD1/TiY5uBbab35rAB9bWOXr0sM4Yq/oPnLmZGwqs9c
 wOwWntDdKZw/DvYT98Or7U1fQxvMNV5PXTw0tB+eMS8BmFypQ2P7MpoZxX0foS413adH
 rMatyR1+Xf3IV3YA1UCoOJ07wvXA/tyRe+6l9ikRCYE5Na6UngQbGBu+hhvdLHOb6CGT
 3O99rmqcIhh3mkKSj8wNke8DcIendbtLC30eX4xAmx5ar+XCJATUOCtQY+jYBWiWcHEz
 0G9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777373043; x=1777977843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGn/7ofAJkPeLznmcMGIZw4zwGjdtj37UuvN0GXBlAE=;
 b=h0AoLzALi6cLLJpMFa9nW4jByNaegXOq6dGA78doT7YM2AtKhwpCU7ZXXpYJOvLFUv
 Tqy/d/KzysL2zkha6q3OLlz2HkCD63e+Tui6kRt3zKevaoKXMqPhPni3NJADAnYpws7k
 k0dQ2cCmLNVZrvTx6FCgXbV0253kTUJ4vx1Z9jBsHyQDKj60GPZfX+hvKXYBvAbA8qM6
 irD29kunO7+dWYN+nV/ZYhUU1tOoC5v+nik2yWX6BRNBw4k1egxDUZwcBXiuIJJQAzG/
 tvycGnket4LvRqe6OrsCJgtqlLx7zjpfFqHK1gDG/Z0yuYa5Yxp7jqAlXm0hMYfnw1MB
 jvBA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9BCIY6B08KoEIM+xGCzgopcIhv1/4hPyC3QcmjNAmSxGjcY8Jb87WlLJ7cZlAauAqpMDdHwRyR7TrQ@nongnu.org
X-Gm-Message-State: AOJu0YzSlCXz3sWjNaRd/W18OxoUK526quJinhFIK3HDhCKby3ZBc6tK
 lFy+t2fixmWYjO+nZdOtrD0eWPDFg+Kq/3gjmI9Bu889GSlSjNYC12pSW27PsKbINLDa5SUOhlv
 +3DtyOrWV0MlLOx80T1M/mqAKEWtYD4y6N4CMH26ja4bqRi4+3SJk
X-Gm-Gg: AeBDies7DPSl6AVqoCUHaoAfBNL7Skj9JjodWt1UCtjt9TbonfD1KYng99mL3bADNTS
 e7GYp0e/OMYt0w0UGKaoOtkUPjx0TWw+qCvJDe62GDcw9EZmqx7bi6DzkNtkL73tCj9Af5fEKzg
 HFWS61iKLEy5b2gUN6BFEJxj8N2ozA7X9FvbbpWSnIkbjw/30uQnOrSMqxHkND7b927XZwV1fla
 D3Ci7xEezAY6oVS62wFdcSCRyPsSr9WzDcIeW+YyC5YiV6lOHqOEH553Yyy3aLNfKs+7mqAqEOA
 EuBLewXvrEXkdfwz0FLle3h7f/StH/2BnfLab4Ezigykyb1Ayip5TMtQamkpCyC1CzK5lEP/2C+
 y0A==
X-Received: by 2002:a05:690e:1446:b0:649:b31e:8f54 with SMTP id
 956f58d0204a3-65beedaa291mr1973392d50.24.1777373042916; Tue, 28 Apr 2026
 03:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-16-peter.maydell@linaro.org>
 <fdbef0ff-453f-4e3b-b7bd-a164cc38b341@linaro.org>
In-Reply-To: <fdbef0ff-453f-4e3b-b7bd-a164cc38b341@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Apr 2026 11:43:51 +0100
X-Gm-Features: AVHnY4I6hwEL6bXLon5c6h0njHnXsyV6uR9XuiWD8HTaCYkJfs3dnGzw-4SDK-o
Message-ID: <CAFEAcA9hD1tCrJCdKcy9zw5p8gwobQGuaKDQaBLyVm7kdx=Dxg@mail.gmail.com>
Subject: Re: [PATCH 15/17] hw/core: Implement cpu_get_phys_addr_attrs_debug()
 with cpu_translate_for_debug()
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Thu, 23 Apr 2026 at 04:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/18/26 03:31, Peter Maydell wrote:
> > Implement cpu_get_phys_addr_attrs_debug() with
> > cpu_translate_for_debug(), so that CPUs can implement only the
> > translate_for_debug method and have all of the wrapper functions
> > cpu_translate_for_debug(), cpu_get_phys_addr_attrs_debug() and
> > cpu_get_phys_addr_debug() work.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/core/cpu-system.c | 17 ++++++-----------
> >   1 file changed, 6 insertions(+), 11 deletions(-)
> >
> > diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
> > index cab65d549a..be5cb48126 100644
> > --- a/hw/core/cpu-system.c
> > +++ b/hw/core/cpu-system.c
> > @@ -90,19 +90,14 @@ bool cpu_translate_for_debug(CPUState *cpu, vaddr addr,
> >   hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
> >                                        MemTxAttrs *attrs)
> >   {
> > -    hwaddr paddr;
> > +    TranslateForDebugResult result;
> >
> > -    if (cpu->cc->sysemu_ops->get_phys_addr_attrs_debug) {
> > -        paddr = cpu->cc->sysemu_ops->get_phys_addr_attrs_debug(cpu, addr,
> > -                                                               attrs);
> > -    } else {
> > -        /* Fallback for CPUs which don't implement the _attrs_ hook */
> > -        *attrs = MEMTXATTRS_UNSPECIFIED;
> > -        paddr = cpu->cc->sysemu_ops->get_phys_addr_debug(cpu, addr);
> > +    if (!cpu_translate_for_debug(cpu, addr, &result)) {
> > +        return -1;
> >       }
> > -    /* Indicate that this is a debug access. */
> > -    attrs->debug = 1;
> > -    return paddr;
> > +
> > +    *attrs = result.attrs;
> > +    return result.physaddr;
> >   }
> >
> >   hwaddr cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr)
>
> As far as it goes,
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> But I'll note there's exactly one user in system/physmem.c, so it'd be better to drop this
> function entirely.

Yes; I note this in the cover letter :-)

-- PMM

