Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDC7C5DF66
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 10:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvYTS-0001Tp-Hp; Sun, 16 Aug 2026 06:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvYTQ-0001Ry-C0
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 06:52:16 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvYTO-0003UZ-N5
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 06:52:16 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-81f36179d72so37416957b3.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 03:52:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786877533; cv=none;
 d=google.com; s=arc-20260327;
 b=B+jotgRG/C79Krb1vBrU1ILbCBhyHszxXY4Gtq0tRoKVlIUHQ62UXxASviALDbdHjY
 P3Yfp/TYHPlRlsm2BnJj9wpusXL/L9aJNU165FdliNX7vTm/hU8om05mrECPKdOmH8Rd
 xFEOrkRaX8ZxbUtPTGRADMirRVQc7DNzb/lt27NA1baZJOG4Kv3sXh6X0N5QpHlalCwL
 IB71s5O6eRbzDmiMXFc6HpPTrTAvDiot1YxMo+KJbBZWMAsGO/+OJOJxs1E/VPQ/cVgd
 /KlflgolT6MsNB4lOTrbMEJrcdT9kE5cLS+HxN4K6k5bWNveZzDhJ7q/IFxZrNMEy3Vz
 CVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PqeRYrg3PrIaYtUYmtOa2SRBovFInGsZyhuU7JlXj9U=;
 fh=vE9mroPCwojMeyL7Rki+gZ+2836oHAtez0oUCr4h0qc=;
 b=Oaz4XPY+bQWyilMZtgnogJvF7W/IRyRl5zRaWcKhjYtI9rkYOLcZWE83hD5bck+AjN
 vAYr/SLAxekf1h11O5ysRBe39MoEkMbhrpaBo2k4FKtTuZZPrSzTZoLaMkEAgud4Qp0r
 Eo8jE29F2DkM8k7tahg9EGuQ+Z+jZek5vwgvWaSZDputPFWALjcWW6UtaI2e5trA6Xhm
 +OAgEku28ENmxcazHEMGyARrY76hOxIbxwsRGrwCi4cVMkuq6F1XKz9kMqyBh17pgYWi
 3gE8xPB007+Q+zPjoh5dq7vGkmqNQw+nRxhcjzj0gSlrxHexYh9n3EUh7E4qA2uqqwhs
 UDRg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786877533; x=1787482333; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PqeRYrg3PrIaYtUYmtOa2SRBovFInGsZyhuU7JlXj9U=;
 b=EKmmfn7sjqRimaq2C5UqIdmM4tYM9b9PvqTbHyEIimtiLi0c9+/zuTcEv+WoM6A4Is
 sqd+GNTZ7l0K0srObCxUsXyJ4wP0j9KJOLwOih4THud5VQwVcm9cE1XNngqbaA46DNBR
 ZWd9xToYGc9OCNiDzSK6fEzM3bYy3BN0OUmYa2vk+o4+ztMzCyntvAxfRLKmb3Og0+M9
 v0//s/lvFIFHSH1ORxmhZc2JviYN+/emUoTfoHU2zWjf0K/uFm3LQhCkn8L5tJqR16iy
 J6q3a74hhMFF26k9GH786+sRWG8eM0S88c4JalwLAI6aqrzfoHOMwYUy9YP9gUtV3cS8
 aOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786877533; x=1787482333;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PqeRYrg3PrIaYtUYmtOa2SRBovFInGsZyhuU7JlXj9U=;
 b=dZ5cELhP+jhuHG2AnCafM8iX5opOpKEnCpZ9fBfrPTaMCVAwWe2ytmH+JtMNivNBfB
 iK1uTjWEIfkKgavJ/B8SXnENLsK5YOIY+wmEh+CWzSQ4VKHD8VNmE5SjabYoWXp26ONZ
 mDY0F3fVukic6UafduvpWPHMfTg9+MEq2/T7OQqAEuWLn2gIuBL0z5aA3pdnaNCIv5i2
 n9qv5dROp4xytkOOSFfS3LyAC3N/Uiv79itE4cmu+KqPKK2GznpAvCvx4J6FQ69sb7NH
 A9o3gSmGNcUvNBs236wnnbeWrEI8PTBe7A9OcUsIg/9bt+Aizt9ozYXsfxtulyuMg+jK
 rCYw==
X-Gm-Message-State: AOJu0YwqgPnOzDE6ZfcBv7Q9nSJz5Tm7PX85KNxdMZEvapTzwiZ5hOEd
 83oUh+2074RhtXHVrCPwPqdZb9+wOm2fqk2E/RCB2xinnxlEReqazWdWRo2asNEff11gInH0CC4
 9VT9OTzPnuLP1ri5aGWYXfP/2gEamgtapbAJ+rMuFOg==
X-Gm-Gg: AR+sD12Qo8dCvyZ4KZ8mHQ5JJ6LEDRtOjY6nFIYPSYN7AVOjAw35rowsZcCkRNHzXUJ
 fShdMtJal6Pd6v7vIw4THI6HpXuRgP6FfRBOm5JToWMtuD0D++VE2tRkC7ASzxIYYGcD9vpA0/c
 bvYdVtn1y5eVFfPyrZ1AajZAeingQYxLpfC+q/MC6r7Hl+ouFA2GZeGMzMVb2DoAtwN1gYzPAnv
 VezcG9QxaTNoAwgp6wMi7+laQG/q79zw5X5z7XDEETFPBCv2eUU1c92jcoPKLdp4u3dcr3RNyOZ
 OJOt+idd7S4xeToBMpVe7Udk7wp9a4KV8fsIMScETRk9qm+v06uIrNASmzD/e8JAmHZv1bWmR2P
 iJQKZkvUTWXwZUqZ0lt/jjsu5Y2zj
X-Received: by 2002:a05:690c:e1d7:10b0:831:4071:da70 with SMTP id
 00721157ae682-83712cacf29mr47930107b3.32.1786877533141; Sun, 16 Aug 2026
 03:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260812220816.94034-1-philmd@oss.qualcomm.com>
 <CAFEAcA-NUOtTPuvxKja+bNU6wy6EQFVMfX9nmQ_LbtAPKHqMXA@mail.gmail.com>
 <351e6d2a-20bb-48a6-a1f6-0800cf2a969a@oss.qualcomm.com>
In-Reply-To: <351e6d2a-20bb-48a6-a1f6-0800cf2a969a@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 16 Aug 2026 11:52:00 +0100
X-Gm-Features: AcwNN1Uhj4niaA7rQZn1v_zCrGC7UOxqz0q01xaifXK6JFoe7mj2I_M_hGkw7C8
Message-ID: <CAFEAcA8x7QuxJcwzdJO29yQ7pkz9YFfUkc+2v2FyGhrHjFJCXg@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3: Have GIC kconfig select GICv3 for HVF
 and WHPX
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Sun, 16 Aug 2026 at 09:52, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 15/8/26 16:53, Peter Maydell wrote:
> > On Wed, 12 Aug 2026 at 23:08, Philippe Mathieu-Daud=C3=A9
> > <philmd@oss.qualcomm.com> wrote:
> >>
> >> While trying to fix the GICv3 dependency on KVM and WHPX in
> >> commit 39a8c3941eb, we missed the Kconfig ARM_GIC symbol only
> >> selects GICv3 for TCG, not HVF and WHPX. Fix that.
> >>
> >> Cc: qemu-stable@nongnu.org
> >> Fixes: 39a8c3941eb ("hw/intc/arm_gicv3: Fix ARM_GICV3 dependency for K=
VM / WHPX")
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> >> ---
> >>   hw/intc/Kconfig | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
> >> index 097de4efc5d..05e697967d0 100644
> >> --- a/hw/intc/Kconfig
> >> +++ b/hw/intc/Kconfig
> >> @@ -26,7 +26,7 @@ config APIC
> >>
> >>   config ARM_GIC
> >>       bool
> >> -    select ARM_GICV3 if TCG
> >> +    select ARM_GICV3 if TCG || HVF || WHPX
> >>       select ARM_GIC_KVM if KVM
> >>       select MSI_NONBROKEN
> >
> > Is this instead of RTH's patch "hw/intc: Fix arm kvm gicv3 selection",
> > or do we need both?
>
> Richard's patch only touch KVM, so we surely need both.

Thanks for clarifying.

> I haven't tested KVM but rth's reported error is the same error
> I'm having on HVF and WHPX. The ARM GIC Kconfig are confuse to
> me, so I don't feel confident to review his change. My gut feeling
> is what we have is too complex and could be simplified, but I
> haven't spent time thinking about it.

I definitely agree that what we have is confusing; I don't
understand it either :-)

-- PMM

