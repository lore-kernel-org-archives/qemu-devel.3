Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E38FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIVNX-0006eo-8O; Thu, 30 Apr 2026 13:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIVNH-0006Rm-6x
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:40:33 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIVNB-0001QP-QR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:40:29 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-65c24be9e4bso709898d50.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777570819; cv=none;
 d=google.com; s=arc-20240605;
 b=Os1wQ9E9e055e37vQaueB8rP4N8AFQkHHJWBDWVa1X3Vd6WlEgDIRzGnyJtYIGDDqL
 SZvGYmGiR4Q6waAFILf9jEPH65zUI7JkrONu0zimR3x6pcO5f1N2sqr+StSMonqv+yTZ
 EJvMhWDJplpWsgvYVmcBMBui2WkOXW4IZkvWpmsq/LBOT7FRcQXyYv+lU0/8EmAaY83z
 5S1bcfe/CrEw8wDi00tjW8GPbqLcyXQ9b/hch8NEzpxOgcnUjs36RzEp6gNU6ODMMacb
 wnuejRl92NFzB+M2Vv3p5N4BE6ryMMJ3c0Xdc6CG44hzu0cEgc2YzQuJcB4O4eXYpMQY
 1yYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wRNqp1a791PplT4I6/Q+eQ0RRbtFxylwW9MjMq9JYVU=;
 fh=tRYG3J0syKrOgrZM9zTCfNNsl9RE5uVwf9Dzqk2n/EA=;
 b=dENjquP99GUZnzdCgZRXNCCkrio29hZ8ot4QXSuFmIw10lOi34YK4+iFKoiljdbc9G
 zfbrQQcOaLfhptl6qnSRqRyoR0Ha1aUKA8A+SJhm9rZc5ZeBvSYpXy9C7nFtX+wXI64R
 +fpEN0cdd4TPKHpcWuXdbfWes8g9bIVIsboeZbNq6B/tD1pMifrsW9ELyJRf8MMa1EIS
 NqEGSueIeXozsEyDBWDuSid2Pg6y9K1FYA9suCBKJHBCJwbWo077RbLYMw17c4/YHP/P
 g+SJ+tiwnpfmN8aC9CaznS6c1iMuTEENxqf+fPDioiZH4JtTZ+ZSTF/ZJ+DXrcxfYRNN
 Vqdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777570819; x=1778175619; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wRNqp1a791PplT4I6/Q+eQ0RRbtFxylwW9MjMq9JYVU=;
 b=gZRFeiEmbtFGVqDfmSRFE3o61wCOt4HPC8s/iCG//wSjRmKWl6rAFitO3QjlQ8Ii1e
 HVK11m+9siAsxxx7AOz6jYZ6zxggiMCczKJnTCuIINJgIaclZQe3ApXQipnlhybDhFdM
 /zyJOMELBjpq6IFLvAeNL/crKUsAjoFZ3H04wDs5hkiQ7vQ5hzNX8NaxBmevxTT2VazZ
 4RLPqB+7lGk1GJ5kv0A9Hev1fhOD53IeXH/C4rE1VCKE59E66+CcLECOKjqjl8moBGhi
 +3+1WJaUzyoXNi5vSE6RvyZuM24dbzJ6+8ZW26sJs7npOgzO0tG4NFSm6fBvr3Qe3QhJ
 Xhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777570819; x=1778175619;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wRNqp1a791PplT4I6/Q+eQ0RRbtFxylwW9MjMq9JYVU=;
 b=DiWWOt7GcQ/gUoONaxpGkmXevrMgwl+gWS8/+2Vh19FzmVbT7eQzs8aJxPpd+B0eda
 lTVqrE5jV7uslFjFj1ZVvkU9q6ym89fEzzOYwDQySFyoSC7RTD/U0CwdiX541iw2Ctrt
 X1+D5kXkjQpPVhlL+oGianyT9G7w6+ciLbcNNUX3KnwXqQ8juv2VlYIbuNkCd5qCve/W
 /l8ohh6NTrLywedmXmGfDT7zq2XER1Sm75aI8t76e5tqv6XWoZ0NLQllpTa7ybpxW78i
 NVtR6Wfbi6BqWrA/BakXrcHYH+33eiFIHMwUZmwnkLgr6qW+zf4wX46LUxRGZgmf6Qdt
 69YQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/cDw3+d4V40EDRU2Ts43glVpBrpNLNPPNnQyEr0vK3+LppJx4S7UeEbvtwuHTRf+lK9W/wuoDjqj1L@nongnu.org
X-Gm-Message-State: AOJu0YwkXban8Enh4lC8ynXcv55OTpzSt+/1xHJ1T108JrxcfGK1XgRt
 DH0Hd32dSGJSQR6eFzj8tM+f1xZIVZMtaknc+Q6NvOCZlQNmhJqQBDISJVxztyQkNCAcdT8NCRc
 ZxC0tDEnYivH7PBMGKHKy++eBYtvtRBoiXHa5oPGCKA==
X-Gm-Gg: AeBDiesnRyLh+lSmngaUvXHSKDDIOa6mdFWOnMbR0S1ppqSBcaobkGaDhC+TEYfu+mb
 qPs2KS2ysTPsL/U83/9fRhBkun5ChmUynLThRKe/+R5PI59Rc9Na66MPkF3MPdHQ+wlUAsGzWp7
 Cbia1VwZLN+weR9Z+miDD+Il8QOXv3Smi+psKYR/2R7I8GHpby1qpeg2a7yRYLZjXf45pojI1/j
 UcN8BKPessTegpqakZuAxlS3RTW0/7WB0JmtIMQf1zlyqfkuo2tBm8RIhYuoTEGvrR6wKNZFAjE
 f/bilXGRSDKONL703n0qSGp1iaRk2waPN5BphAIqpNcDAjr/2P3+McryfB/ZUn9m6ltf2gm6CIp
 NUHo2s8EJX3Iu
X-Received: by 2002:a05:690e:4092:b0:649:6b96:8025 with SMTP id
 956f58d0204a3-65c18b04cfemr3212339d50.9.1777570818956; Thu, 30 Apr 2026
 10:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260420064933.64765-1-thuth@redhat.com>
 <c51c87a7-e224-4785-8f64-f4c59af0d066@tls.msk.ru>
In-Reply-To: <c51c87a7-e224-4785-8f64-f4c59af0d066@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 18:40:06 +0100
X-Gm-Features: AVHnY4IExqn23MVcz5gIFdch2_2WomB86JJbwsWg5gPi572yXRiM0muQ21qYRbI
Message-ID: <CAFEAcA_brmxEaxR+fzNFCaC+n0TnJg_5vF8vrpuah7PvWPD8fQ@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Remove hw_error() for the unimplemented
 CM_LMBUSCNT register
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Thu, 30 Apr 2026 at 17:50, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 20.04.2026 09:49, Thomas Huth wrote:
> > From: Thomas Huth <thuth@redhat.com>
> >
> > When writing to this register, QEMU currently aborts:
> >
> >   $ echo "readl 0x10000018" | ./qemu-system-arm -audiodev none,id=snd0 \
> >      -M integratorcp,accel=qtest,audiodev=snd0 -display none -qtest stdio
> >   [I 0.000000] OPENED
> >   [R +0.001907] readl 0x10000018
> >   qemu: hardware error: integratorcm_read: CM_LMBUSCNT
> >   [...]
> >   Aborted                    (core dumped)
> >
> > This is bad, a guest should ideally never be able to kill QEMU like this.
> >
> > Now, according to the "Intergrator/CP User Guide" from:
> >
> >   https://developer.arm.com/documentation/dui0159/b/porting-integrator-ap-and-im-pd1/registers
> >
> >   "The Integrator/AP CM_LMBUSCNT has been removed."
> >
> > That means this register does not seem to be implemented on real CP boards
> > at all, only for older AP boards. Thus it should be fine if we simply
> > ignore this register in QEMU and handle it like all other unimplemented
> > registers in the "default" handler of the case statement.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3407
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
>
> Not sure how important it is, but from the bug report it seems this is
> a real issue which triggers for real use cases

No, it absolutely isn't. It's just somebody who's been pointing
an LLM at the codebase and asking it to find cases where the
guest can do things like triggering asserts or aborts. No
real guest is going to touch this register, because (as the
commit message notes) it doesn't exist on the real hardware.
It's a harmless change to pick to stable if you want to, though.

-- PMM

