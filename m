Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E36C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thR1F-0004ST-1a; Mon, 10 Feb 2025 05:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thR0t-00046i-J9
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:27:39 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thR0r-0002Ay-9q
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:27:39 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e5b1c4d14f2so3501641276.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739183256; x=1739788056; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8Lw06BOrYsNQ4AYM+lwVkVkT2+9W/2UtsjCWofhmopk=;
 b=w7aU2EcVOmslh65VZYjGIYktrAz1vX99IZicGKWNwTJlKgUcce9UTBdbfZ5ycAhIMT
 dVCs98uDRnRKoRW2LP3rPri7MSVXFTjgSDYBZojzH84mb22rDGG/rOedsFsqjmIkni9M
 wkJCj0dG3e5W8QvYKeYJS+qSdH8E/AWbUm9itH8/SZgW5Et4tFxQiG7Bwe4dj7g/jDh0
 RUzUpVjTzee8K72VtS6WvN2RJ5ltsHWW/wRLcVNZChOhTHpWG48kYfWbo8rITAnTw8vQ
 kYDcX1PtyPSAAJfO+7oFt/VFDsLO8od5SST8EnGYKyZ5ihFYhWHQu2D4L9/yUCxaQTm5
 yf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739183256; x=1739788056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Lw06BOrYsNQ4AYM+lwVkVkT2+9W/2UtsjCWofhmopk=;
 b=njQExJ+PsLInGNZa2p4A8nxqAZ9cG60E2FkQf1738ifDgejB0/OClN/9aX5BIrgxzK
 XE+S8uCSSrDuINy8wKvDlfZUvwOE+NEzQ/AoH9mBumtEXHjuKVoL6PoetaHUSS9bmJkK
 XJUAwi6hf3UJdHvTfBxVKY6BpjnIuSrC6Yc9tzoumoYdNOk5/5UZ7l0scRELWOI7jHiH
 L6alvUEDssuv7NEkvMbzSjmNbvYm4MR1I3ng06nXtLgYYCUUGj0y5kNxMW//D99spWgD
 t+ygNrH3GVDaj7A8y1Ja6oZ7fwH3HwNWfmFd7GEt+Zmspd2CtKPc20yhjXwUKoahHnAE
 QnWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDQmFInWXmKWApR5DhFNxdwWLdjp9OXmRVNvKops0piCQz3+s/6KnnaoppY0Oi3p1JYmYJWru184Fh@nongnu.org
X-Gm-Message-State: AOJu0Ywwj2Tkq/44QLZ69xrxYzpCt/vV7eFuEnmnrxJQoM7NyXhnXlvQ
 uS9YG0pNZT1tFl4QQdm9lQ/oIxmO8FHLTVpQFERqcxiNd6PyB6Awn9+y4ZLoEix+Ek2DEY8vPhA
 6+aTjw0Qz0m7VWuVbu56z4hVtALY9yrAO8F4qLStcdU7Es/gI
X-Gm-Gg: ASbGncs9btFiugBgO1nD7GcvQEzhdDMYaciqvC+eogJw6gckQSBmZoJXasxoBV7CFcv
 yqRImM7zfa5w54oBJBjOgn+2joJBrJ57znAGx40fmWBNVg0OUyZOq6S0ce915G4d1NPYXO57H1g
 ==
X-Google-Smtp-Source: AGHT+IF+artVKxhqv46vV7sWzB7uOCL7Hx6x0PeGwPVt6FAOxTwT5zoev8H+x/5cWKexKZxrj7C6xVALcqGyHv5E/AA=
X-Received: by 2002:a05:6902:1586:b0:e39:85e3:1069 with SMTP id
 3f1490d57ef6-e5b4628c5ffmr11112327276.47.1739183255777; Mon, 10 Feb 2025
 02:27:35 -0800 (PST)
MIME-Version: 1.0
References: <20250130182309.717346-1-peter.maydell@linaro.org>
In-Reply-To: <20250130182309.717346-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2025 10:27:24 +0000
X-Gm-Features: AWEUYZlm3rU8fdHUwBPlkvkks2uJDnMpswY0qMxJXIWvubDGFwHv6Go_NBfm2ic
Message-ID: <CAFEAcA_+9tVJaV4EpdfYvBx=bBL1KFzdGAD28TAvjct0x28KcQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] target/arm: Clean up some corner cases of sysreg
 traps
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

Ping for review on patches 2, 3, 9, 10, 12, 14, please?

thanks
-- PMM

On Thu, 30 Jan 2025 at 18:23, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> While reviewing Alex's recent secure timer patchset, I noticed a
> bug where it was using CP_ACCESS_TRAP when CP_ACCESS_TRAP_UNCATEGORIZED
> was wanted, and that we were making the same mistake elsewhere in
> our existing code. This series started out as an attempt to fix
> that and also rearrange the API so that it's harder to introduce
> other instances of this bug in future. In the process I noticed
> a different bug, where we weren't handling traps to AArch32
> Monitor mode correctly, so the series fixes those as well.
>
> The first four patches are fixes for the places where we were
> using CP_ACCESS_TRAP when we wanted CP_ACCESS_TRAP_UNCATEGORIZED.
> These are all situations where an attempt to access a sysreg
> should UNDEF and we were incorrectly reporting it with a
> syndrome value for a system register access trap. I've cc'd
> these to stable as they are technically bugs, but really the impact
> s very limited because I can't see a reason why any code except
> test code would deliberately attempt a sysreg access that they
> knew would take an exception and then look at the syndrome
> value for it.
>
> Patches 5, 6 and 7 together fix bugs in our handling of sysreg
> traps that should go to AArch32 Monitor mode:
>  * we were incorrectly triggering an UNDEF exception for these
>    rather than a Monitor Trap, so the exception would go to
>    the wrong vector table and the wrong CPU mode
>  * in most cases we weren't trapping accesses from EL3
>    non-Monitor modes to Monitor mode
> This affects only:
>  * trapping of ERRIDR via SCR.TERR
>  * trapping of the debug channel registers via SDCR.TDCC
>  * trapping of GICv3 registers via SCR.IRQ and SCR.FIQ
> because most "trap sysreg access to EL3" situations are either for
> AArch64 only registers or for trap bits that are AArch64 only.
>
> Patch 8 is a trivial one removing an unnecessary clause in
> an if() condition in the GIC cpuif access functions.
>
> Patches 9-13 are the API change that tries to make the bug harder to
> write: we add CP_ACCESS_TRAP_EL1 for "trap a sysreg access direct to
> EL1". After all the bugfixes in the first half of the series, the
> remaining uses of CP_ACCESS_TRAP are all in contexts where we know the
> current EL is 0, so we can directly replace them with
> CP_ACCESS_TRAP_EL1, and remove CP_ACCESS_TRAP entirely. We also rename
> CP_ACCESS_TRAP_UNCATEGORIZED to CP_ACCESS_UNDEFINED, to be a clearer
> parallel with the pseudocode's use of "UNDEFINED" in this situation.
> The resulting
> API is that an accessfn can only return:
>  CP_ACCESS_OK for a success
>  CP_ACCESS_UNDEFINED for an UNDEF
>  CP_ACCESS_TRAP_EL{1,2,3} for a sysreg trap direct to an EL
> and everything else is invalid. UNCATEGORIZED traps never go to a
> specified target EL, and sysreg-traps always go to a specified target
> EL, matching the pseudocode which either uses "UNDEFINED" or some kind
> of SystemAccessTrap(ELx, ...).
>
> Patch 14 fixes some issues with the WFI/WFX trap code, some of
> which are like the above sysreg access check bugs (not using
> Monitor Trap, not honouring traps in EL3 not-Monitor-mode),
> plus one which I noticed while working on the code (it doesn't
> use arm_sctlr() so will look at the wrong SCTLR when in EL2&0).
>
> I've cc'd the relevant patches to stable, but I don't think
> it's very likely that anybody ever ran into these bugs, because
> they're all cases of "we did the wrong thing if code at an EL
> below EL3 tried to do something it shouldn't". I don't think that
> EL3 code generally uses the trap bits for trap-and-emulate
> of functionality, only to prevent the lower ELs messing with
> state it should not, and everything here with the exception of
> SCR.IRQ and SCR.FIQ is pretty obscure anyway.
>
> (Tested somewhat lightly, because I don't have any test images
> that test AArch32 EL3 really.)
>
> thanks
> -- PMM
>
> Peter Maydell (14):
>   target/arm: Report correct syndrome for UNDEFINED CNTPS_*_EL1 from EL2
>     and NS EL1
>   target/arm: Report correct syndrome for UNDEFINED AT ops with wrong
>     NSE,NS
>   target/arm: Report correct syndrome for UNDEFINED S1E2 AT ops at EL3
>   target/arm: Report correct syndrome for UNDEFINED LOR sysregs when
>     NS=0
>   target/arm: Make CP_ACCESS_TRAPs to AArch32 EL3 be Monitor traps
>   hw/intc/arm_gicv3_cpuif: Don't downgrade monitor traps for AArch32 EL3
>   target/arm: Honour SDCR.TDCC and SCR.TERR in AArch32 EL3 non-Monitor
>     modes
>   hw/intc/arm_gicv3_cpuif(): Remove redundant tests of is_a64()
>   target/arm: Support CP_ACCESS_TRAP_EL1 as a CPAccessResult
>   target/arm: Use CP_ACCESS_TRAP_EL1 for traps that are always to EL1
>   target/arm: Use TRAP_UNCATEGORIZED for XScale CPAR traps
>   target/arm: Remove CP_ACCESS_TRAP handling
>   target/arm: Rename CP_ACCESS_TRAP_UNCATEGORIZED to CP_ACCESS_UNDEFINED
>   target/arm: Correct errors in WFI/WFE trapping
>
>  target/arm/cpregs.h        | 15 +++++---
>  target/arm/cpu.h           |  6 +++
>  hw/intc/arm_gicv3_cpuif.c  | 15 ++------
>  target/arm/debug_helper.c  |  5 ++-
>  target/arm/helper.c        | 75 ++++++++++++++++++++++----------------
>  target/arm/tcg/op_helper.c | 71 ++++++++++++++++++++++--------------
>  6 files changed, 107 insertions(+), 80 deletions(-)
>
> --

