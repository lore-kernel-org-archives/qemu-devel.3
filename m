Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D91FD4115E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 10:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgKPB-0000ZG-CG; Thu, 15 Jan 2026 05:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgKOx-0000XJ-6S
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 05:16:30 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgKOv-0005rs-Gw
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 05:16:26 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-792768a0cd3so6536827b3.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 02:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768472184; x=1769076984; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KbDjkZE+DRIN3rMtdRZHNhQRuCYWbOmG1xmVKoOjFNA=;
 b=iao7D7ulnapLDiA0nW3dS22a3Vdbi4iB4B0oLWZog2EL+D6/EnJS9vaGZ3vPHJTUIp
 t4KaBWT4ZB0/B9fTKctFgRDK5h/kD8x0A5Hz07VgVLELbIrXu1SPBKPlLxw5tE/G5gP6
 jHZyQhrScYdaJ19YqWOghnaazjSNuH/58ujITLfocwewo7ROlvKfhyegMY1dXd6Wx07n
 pg+kjnH0BxYuxfVBKQpXNMBmzuSq1WCJ8e6x+Lp9dru3p4Q/o54K/87mhKtO2uGvVk+l
 SYYbgAVoFYMLSga4oS/P28HFqNPVu9iJ5xYx8q2tZh70DzXiL1QlmSGV2/r3g4lD8lHr
 Z5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768472184; x=1769076984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbDjkZE+DRIN3rMtdRZHNhQRuCYWbOmG1xmVKoOjFNA=;
 b=wxg/8nUv7zwpRge2rF65BHxcjiV0wp4YKN+gPgFMn4aTzm/FX+AbokESITjvcZEXe0
 rJvwGNBeUmzXQsOP2mfFkbL0Hg4kRQ0f8UW5/Dp4XY3CtV618DvcTU0TeCXhorL/17Dh
 RcrIoNUrOhnzf4rfHWfTReMHTzNhYOQrG4/RAkV6SZXrZTd0K2nFizzIuDeiHWg4p1BP
 jQlnEEK35+3f4TQoSb3OA16V/mcEgJHbFcwwN58Li6M1SA9RQawUMz+zt+V6A4LUzA5E
 XzKCN89Y/no+rAdvT8pwdqgJpMLvpJxNuuKQsSBJk+R6cNfcZWdGtbtP5S8EbDPbaBix
 X08g==
X-Gm-Message-State: AOJu0Yz9GP8MH7tqFTEjPUCVPQxuDwEfiA8qpDfUJee5Qe6uMs/ssbom
 at7sH8yhUUGkuuv3zCb6erKoZ9GnwgKc390mfzKfJ6bGjoZYkD3fVkLi6hZZezDoFMV1kH31UTS
 uUOZpnGeTF8MwbZi7P2TlQa2nwkt1SHXq+lbuokATcA==
X-Gm-Gg: AY/fxX7i15/RT6eClsohY6meMgSGi90ZUoVc6m6Svscr3FGrgnrhCKwXHYrSrPfbTEz
 6SIpNeedHOL3ipDcMn82SJbB15StJh4IVz4HrqYnaPyuRFH5yzJlDDKtwgBYLiU7eSI1EXt4ntr
 EgW7s4c6E7SM/G1e5TngYt7aJiQgxxEWwHg+HSaqA+bU+hWcI+lTffd5pfcY/UnqnrNlgUM1IqC
 GDQOgtSpcyZqM+sfjJvbWfhmphxTNgHe+AVSjj4wNp1eoP0dlOlaqXX/qSceZlW3/dSRA3nB3/Q
 Bv2gUw8iVBOorg3Rn+WepBM=
X-Received: by 2002:a05:690e:4007:b0:646:7b87:753 with SMTP id
 956f58d0204a3-64901b17308mr4015733d50.74.1768472183334; Thu, 15 Jan 2026
 02:16:23 -0800 (PST)
MIME-Version: 1.0
References: <CGME20251223120242epcas5p44b454df5afd0d517a4562a545ad11218@epcas5p4.samsung.com>
 <20251223120012.541777-1-ashish.a6@samsung.com>
 <CAFEAcA-UFgxLx8uYM10DoLXutMMNVQaq9xWBjZS5BY6RL1eRnw@mail.gmail.com>
 <tixhu4eob36aeq5cbbvtudkpzvdvigiztii4bycwuj622m5ngn@vt7rf2iln6jz>
In-Reply-To: <tixhu4eob36aeq5cbbvtudkpzvdvigiztii4bycwuj622m5ngn@vt7rf2iln6jz>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Jan 2026 10:16:11 +0000
X-Gm-Features: AZwV_QhZDHFYhuHm42QtfoldJKCbRtu3YKzbJ7tvGFpmY0i5eB_LgoBqLF9O4ns
Message-ID: <CAFEAcA-DtfMjEg2SUNeMNRHfxmyYBuJ9tn2fR0LQxfNVrVoyUA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Implement WFE, SEV and SEVONPEND for Cortex-M
To: Ashish Anand <ashish.a6@samsung.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, saurabh@samsung.com, 
 y.kaushal@samsung.com, vishwa.mg@samsung.com, ashish.anand202@gmail.com
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

On Wed, 14 Jan 2026 at 14:20, Ashish Anand <ashish.a6@samsung.com> wrote:
>
> >It looks like there's a missing piece here: R_BPBR in the v8M
> >Arm ARM says that the event register is also set on exception
> >entry and exception return.
> >
>
> You're right that I'm missing this. Looking at DDI0403E_B & DDI0419E (ARMv7-M & ARMv6-M)
> Section B1.5.18:
> - "An asynchronous exception at a priority that preempts any currently
>    active exception" is a WFE wakeup event
> - "Any WFE wakeup event, or the execution of an exception return instruction, sets the Event Register"
>
> So does this imply that even in ARMv7-M/ARMv6-M (not just ARMv8-M), the event register should
> be set on:
> 1. Exception entry (when exception is taken/preempts)
> 2. Exception return

I hadn't looked at the v7M documentation. Looking at the v7M Arm ARM,
the text doesn't mention the exception-entry case, but the pseudocode
ExceptionTaken() function unconditionally calls SetEventRegister().
So I think this is likely a case where the manual text was wrong and
it got corrected for v8M, rather than being a divergence in behaviour.
For QEMU we should set the event register in both these cases
regardless of M-profile version.

v7M's text is also a bit confused about whether the SEVONPEND
bit affects only interrupts, or all exceptions. v8M seems to
consistently say "interrupts". I guess we go with "assume this
was a mistake in the v7M text". If you happen to have convenient
access to real hardware we could test the actual behaviour, but
if not I would go with "only interrupts" for both v7M and v8M.

> >>          case DISAS_WFE:
> >>              gen_helper_wfe(tcg_env);
> >> +            tcg_gen_exit_tb(NULL, 0);
> >
> >Why is this necessary ?
> >
>
> I think this is necessary because helper_wfe() can conditionally return (when
> event register is set), following the same pattern as WFI.
>
> WFI helper can return if cpu_has_work(), so it needs tcg_gen_exit_tb()
> for that return path. WFE helper can return if event_register is set,
> so it also needs tcg_gen_exit_tb() for that return path

Ah, I see -- currently the wfe helper calls the yield helper,
and that always calls cpu_loop_exit(), so the helper never
returns. (I'd assumed that because WFE is conceptually a NOP
for us at the moment that the helper would return.)

We should add a comment similar to the one we have for the
DISAS_WFI case:
    /* Go back to the main loop to check for interrupts */

thanks
-- PMM

