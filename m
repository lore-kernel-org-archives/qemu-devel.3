Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774BEC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggju-0002BV-2q; Mon, 06 Jul 2026 06:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggjs-00023K-7f
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:39:48 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggjq-0003vK-8y
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:39:47 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-664c7dc6830so2127698d50.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:39:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783334385; cv=none;
 d=google.com; s=arc-20260327;
 b=oCQMgAs6cA8HuI/pKuIdjvR9q8Ti6/qtgdUEoS2j7A0vEBLizOqGcfIOzYAHwLpsyx
 LB883FlOYWIx9mEyS28K0nZ058qI37PihS6AWx7Nne8qCPg4niEheEdYrKDIMPGlj9ze
 K2/6kIUemXBPckmIMZ2j/Kp494Sw70M2DUF5nYVoo7V6lQs+W4gGrNV8z7x7DEJzQCdc
 M0+3YJ9MIvuQk/+tp0ALTySJ7kKkrWS8Xl8zxHWVOGUHm4czxUNreu6khvYLubHy2lvi
 NHN6KfJ95SUnR1ydAZDVQbqhjxPB4GJrmVugH4qezpmCKtIT2HYNWAcpO+mCkF/VH6A6
 Vssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3Mjb9mX869EBGtrKsAmi8SRPr2VxURoFvZfrQyutlSk=;
 fh=yNpAJAiJFxM9jaY/7wWb6zKDIRoN7oDZYQ1Tc5d+UTI=;
 b=PAHIJ++gLPWG8kKAhoKs0JuxijVXI3/sqosYpbM659/4xbSpVQI4NBqTdjWgEBj0NE
 kohk6R6QAHjFkYP+2U5v6/0WAf8aQ+DdRZShYNNCW64Mjhn5J8L9mPI2nD7xBsEpDLIf
 Ox6CV08uPsLDyZmlKR9/8JTZJuVpQquniKacLsTwu5WZm9kvj0gWequzGiDc5rM6LeiD
 IIcF1Xx1D8hu0Q9qwsHl9HeZhB6uygHKmIKDLCBlZZAnMSQm9l06osvSYqq9+JQgvsxF
 UxRgWubkKQRXr1V4zVs/go0O5yeP+pvJcUafO6ml62K2uHbmHOQ9K3myumemRE4eby3J
 PSeA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334385; x=1783939185; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Mjb9mX869EBGtrKsAmi8SRPr2VxURoFvZfrQyutlSk=;
 b=esPMjE6cqQuKr/PlBmbFM4BpfY5xaTe0hluEFhAhREeAIk8Tn9LuvMjco8zvahTz6U
 j7/nfRSuZjvuBBD6rcZKI6HcsxDsz8dHEkczY1G4QBusxaLFZKrqse7FvgLiHglWjUkt
 71jwtMDL51Xs/sheFCGwt0KhiRvY36cT3MCiPav9zmNdNtx1RW+/9ZAhlBHCQzZuZlvh
 rnt9p8jUQL3s8OxOrxIjn2byaKucQn9Ub+d87OHF8ych1htgufG0V2bluI9YjuxPS6Yu
 CDywdLPHm9hBydOV6k8r1e/IkFfKKy735KrKaMPh8H8tgmd+splU6sE8zvQQGKA54Mpn
 7FSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334385; x=1783939185;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3Mjb9mX869EBGtrKsAmi8SRPr2VxURoFvZfrQyutlSk=;
 b=c9+9T5OQIxUROWyO2GyX3J0mo9bDhhMVnCguDHI9i8swteWS7IIPSCArko7MnaY35v
 +6R1UFoNm2wYPBQdfKiZ7aggLFAGhqSjm5Ogv5T4DsW4lNC0K4oKYBHOLBApYghRM96B
 zhtyHuWBeQDPg/K6Xld8skN40nqfXIER/JMCeksuan33zOC0D7aOHcpkzLX4Yj5Pz7wT
 7wLslvCt/6v0+ZZ6pkXMnzJP0KvZpvyXdhgOQ190KA3CgM7+/H/mHjzQEaG5P4jVvLf1
 80SHzfZuzpLWWGpmugYaYe5AmGtA2mTQ1nNUP0+s536YlszP3byIRi3IJAYsOAjUN5Yn
 QS8A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2En6W3xb264NBv0uiuJAgw9d22D8z9yY98Ey+SSkcEe89LCxIodibMS1Phv9/FxRVh5EzlarJQLJY@nongnu.org
X-Gm-Message-State: AOJu0YwyOqloySzJIaWg/D7HpXsZSjjHU7paBDx3qIrrxO0BkBDNqN8S
 YO1GVGRzGYGBbeG7kgxDWYMpzF1+IW51f+5V5BINLivm8glF2FGuwLDfeu/3KDPhX/7+whZsC/h
 Cbu3Gc6l91jK6KArLD0F8CO7t8sZ2pTDzrf7MAHQSew==
X-Gm-Gg: AfdE7ckwChYNj7GURvTnIQe5+22cF2Gksk4TNxGd8KGQ9ZmgOjmBpzk7MsThxfE8ftz
 sM4jCuoyr+tNFg7xz7QBFeQfQlhr1r7USurBmM8uMWPkRpKcL0VR9jpJmFp93h+C6IM/9pV9rHm
 voOPMvt+ywxKS1IQlEBILowQIZnBCLuScxrTGmhexY4NkojZy5hJsTOMhwgT5dg4xkb+iok4EWG
 DpANQxgK2xkT5V82sEUq+hJjAC+L9H1bWI0R64grbNk52INox1FYrpado6aJ0viprMNYZklCIXn
 j8eGyqK/NaEayWJ0oOWskz+VaZs7TeDhMSVPDuxAPA3Z4qUFi5GDDxyfjQoFQjHYyC8=
X-Received: by 2002:a05:690e:4083:b0:65d:dca1:ff89 with SMTP id
 956f58d0204a3-6677fa0c67fmr69497d50.12.1783334384869; Mon, 06 Jul 2026
 03:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260705224407.32464-1-gilles.grimaud@univ-lille.fr>
 <CAFEAcA9Heev=ydTzO2u3EzeF_2q7dytOF8=67qF8ZMMY6Ky2Tw@mail.gmail.com>
 <877bn8wgou.fsf@draig.linaro.org>
In-Reply-To: <877bn8wgou.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jul 2026 11:39:33 +0100
X-Gm-Features: AVVi8Cdd5HhGK9IEOKZ6VhKNHcrP0xdbz80OPDfZcXClq3e3sKicAlLn9WjK3Vw
Message-ID: <CAFEAcA_2G-CogeB=8cFs37PNdYL88_PcsD6eNehev8A3XNH82w@mail.gmail.com>
Subject: Re: [RFC PATCH] target/arm: report M-profile BKPT to gdbstub when
 attached
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Gilles Grimaud <gilles.grimaud@univ-lille.fr>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Mon, 6 Jul 2026 at 11:33, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Sun, 5 Jul 2026 at 23:44, Gilles Grimaud
> > <gilles.grimaud@univ-lille.fr> wrote:
> >>
> >> While working on Raspberry Pi Pico/RP2040 support, I noticed that Pico=
 SDK
> >> programs deliberately execute BKPT from _exit(). On real hardware this=
 is
> >> useful when a debug probe is attached: returning from main() stops the
> >> debugger at the program exit point.
> >>
> >> Under QEMU this currently does not behave like the debug-probe case. F=
or
> >> M-profile guests, the BKPT instruction is routed through the architect=
ural
> >> guest debug exception path. Without halting debug, that path should re=
main a
> >> guest-visible DebugMonitor exception when DebugMonitor is enabled, or =
escalate
> >> towards HardFault otherwise. This patch deliberately leaves that no-de=
bugger
> >> architectural path unchanged.
> >>
> >> The problem addressed here is the case where GDB is connected to QEMU'=
s
> >> gdbstub. In that situation, firmware that uses BKPT as a debugger stop=
 point
> >> should stop in the attached debugger. Instead, the M-profile guest cur=
rently
> >> continues down the guest exception path and may end in HardFault/locku=
p rather
> >> than reporting a clean trap to GDB.
> >>
> >> This is not specific to the RP2040 machine model. It is a generic
> >> Cortex-M/gdbstub interaction: firmware that uses BKPT as a debugger st=
op point
> >> should be reported to the attached debugger, while keeping the guest
> >> architectural exception path when no debugger is attached.

> > No other architecture, CPU or board in QEMU needs to do this,
> > so my instinct is to say that M-profile should not be special here.
> > Richard, Alex: how do we usually handle breakpoint insns for the
> > gdbstub ?
>
> For TCG guests we never insert BKPT instructions and treat the system as
> having infinite hardware breakpoints.

This isn't about gdbstub-inserted breakpoints, it's about
what happens when the guest code has a breakpoint insn in it
already (either hardcoded, or also could happen if we're running
gdb inside the guest). That's something that can happen for any
CPU type.

thanks
-- PMM

