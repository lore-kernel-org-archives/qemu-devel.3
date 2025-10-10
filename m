Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEB7CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7FIl-0001xR-Sk; Fri, 10 Oct 2025 11:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7FIh-0001wC-VH
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:45:01 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7FIQ-0000jU-GT
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:44:57 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6361a421b67so2473222d50.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760111075; x=1760715875; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IP2dGjhuwFJFn+3sjgH5vSPw/PJB0rjZ/XVicG18xoo=;
 b=M2i2rfblzqRwcfEkmKkPaFvgdLAmJXqYyJr3gHJU/OAL3HWicdIu5fTSz0LgM06ZmA
 DRSPTDazpX51D3gtZL15taehmFOENZSHg2O5Wfux0SJUiWYMjP9TCXzJ71FWDxHRBjp7
 ktErCyR+NZ/1agCoG5ESu54Hn7EsEaB92IwZp4c4E/W/jHR0aYrkask2vAT+xtaTuBXW
 fA2wTRQPDGd713ECisNrgvdydqCNnbSEH/1Xh8bhGiMON9lIaPWDv+q8ZhTzwkHQLZMy
 82vd2/6PtryrsDtPr0oLyppWw77MtG5kiUWWYmb/xKMZzxOn4EYNAzUaNH7S4Ha6N1yc
 RsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760111075; x=1760715875;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IP2dGjhuwFJFn+3sjgH5vSPw/PJB0rjZ/XVicG18xoo=;
 b=BnY9Njkwybo9JxtrS95u7tQrs+NN5NRUWdc1LHyXl2u71RxI9LqqwRXZkpxow5SFLC
 kKASy2K9OhSuMNUvkM6SIUIfd32cH2Z82YKWVPTT4DvsQyH32+Er7+gczdmgA8jsJfO1
 FThEQwIUFdbS6TfvXD9XvqMA+DEMl3Y7kzYTl+QTRGJKbud0GD0JzONiksJSfMzlKoXb
 uzhQeOdwbgEoFFsZzwuzN26DV0Z3A75pzQcZUrbZu2G5F4CacIELiS+tyAA4lq9vzSNd
 r2WTdn1GC6PbSml5KGIfDZkexCHEP55xgkfMsYV70BduzOtF4fZZknCwfPuFZRAkdFKC
 Sang==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgN5aSgJoGFowJdMBhLbB+BoreYqOVY4bxr26EadahyLh07RYs8CQy2D6osEs4t4CTjLrDdMuvLrJy@nongnu.org
X-Gm-Message-State: AOJu0Yy8vke2oSaPrUOl5Vad2PVM8vR5o9atZzy1T1F3v+Nwm2HqBg+8
 PFGEgz3ZUOugHY1lQht2qA3gLVivL4a164maJYexpSlRJFZXXcbMlZ2cSATfd5VtmGctxOdS8Mt
 eLbQazBgYRZGiFORFg5xvHmb97e5LJgEHAFIZQIBSlA==
X-Gm-Gg: ASbGncvl6woALBxFCOQJXc9/EQM7v1ru+8ccRM53BVtNyYab/TvwDIoKAfqvMkDxn7t
 4LURhtb5H0b7pWs7vRn3AAA4BfnYwjl8qU2nNUEcGGbSiZwWq9Ancpule95U8QrojBus7XhdeHd
 QN4ZCfu9+sR8hfaJUFAx36OfohICbmlWp5fubvrM3piV+NhyPODKJK8k44LubWxCf2S2jatGaoo
 K1TQNfpaP5NdPT6vJA+Ht6kOiRtskkdU3dwJ037vPgjmRlcwWcb
X-Google-Smtp-Source: AGHT+IHO4ewkA+9g6jWKXpJ15gM4a/0n6dmGfiwqbSa4M6jlsTksPUxclAN6yW7rcjkJocahdWuPiH5L3vvyY0HJrTo=
X-Received: by 2002:a53:a6c1:0:b0:636:18cc:fefb with SMTP id
 956f58d0204a3-63ccb825876mr8510929d50.5.1760111075536; Fri, 10 Oct 2025
 08:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20251002101648.2455374-1-peter.maydell@linaro.org>
 <20251002101648.2455374-2-peter.maydell@linaro.org>
In-Reply-To: <20251002101648.2455374-2-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Oct 2025 16:44:24 +0100
X-Gm-Features: AS18NWBh81MNJYEunPEjuMZf4QRINO3lJ1eQmWgu3B40N7y5FIYWQRMT08Au7Cw
Message-ID: <CAFEAcA9KeO2r+jNont_2Jpvi5MgViH3nXO7TcbANe+3nS_PF-A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] target/arm: Clear AArch64 ID regs from
 ARMISARegisters if AArch64 disabled
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 2 Oct 2025 at 11:16, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> If we create a normally-AArch64 CPU and configure it with
> aarch64=off, this will by default leave all the AArch64 ID register
> values in its ARMISARegisters struct untouched.  That in turn means
> that tests of cpu_isar_feature(aa64_something, cpu) will return true.
>
> Until now we have had a design policy that you shouldn't check an
> aa64_ feature unless you know that the CPU has AArch64; but this is
> quite fragile as it's easy to forget and only causes a problem in the
> corner case where AArch64 was turned off.  In particular, when we
> extend the ability to disable AArch64 from only KVM to also TCG there
> are many more aa64 feature check points which we would otherwise have
> to audit for whether they needed to be guarded with a check on
> ARM_FEATURE_AARCH64.
>
> Instead, make the CPU realize function zero out all the 64-bit ID
> registers if the CPU doesn't have AArch64; this will make aa64_
> feature tests generally return false.

I did some testing, and this doesn't break a KVM AArch32
vcpu, so in that sense it's OK, but it is a bit odd, because
from KVM's point of view the 64-bit ID registers still exist
and must have their correct values (especially, for VM
state load/save). This works because save/load goes through
the cpreg arrays, and doesn't affect cpu->isar. But it
means that QEMU has a different idea of the ID regs than
KVM does.

So I think the better approach here is that we do only
clear these ID registers for the TCG case. For TCG, an
aarch64=off CPU really does not have any aarch64 at all.
For the other accelerators (which is probably only ever
going to be KVM), an aarch64=off CPU is one which has
AArch64 at a higher EL, it's just the VM can never get
to that higher EL. That seems like enough of a difference
to justify treating them differently here (i.e. only
call arm_clear_aarch64_idregs() if tcg_enabled().)

thanks
-- PMM

