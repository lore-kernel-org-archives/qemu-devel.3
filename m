Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B52D10C11
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 13:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Pk1-00039P-4E; Mon, 28 Oct 2024 09:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5Pjz-000389-Q7
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 09:25:03 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5Pjx-0002pX-HV
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 09:25:03 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5cbb0900c86so3291478a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 06:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730121899; x=1730726699; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8ZVH5GxwAKibzog2TH5n/39WEZ0Rd/nXcfSMUNQhE0k=;
 b=TJHsFcDVuT5Ftw2gs6XLPnCfCqQB3EmnArLd1Id1KPoGGi76NfUaraD2H275VFVlrz
 o6qo6hJEaG1OBW5xzksqi12h7jJd0IFZLoGQFORg23EORR1wJzyrxjmmshGLR3jIJD8H
 dgV4dJeMe8snDJ4iTNSLA6u24AP0ziYvb/MzBSgrNU2HPIIh4jbXVT5D73NN/hmBC13D
 0UJAq6D8IAAHPeNOc4591VBUZNIu29N7L7YqH0o3fgtRABxyksjNMBWpi3dYPOehJQo/
 5T0aaMdmOp0Y+74J+bDAFLKDM6zmLQUh6JN7HdcluZLOc9Zv4AWTw8FyNcSCu7txKGFS
 iTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730121899; x=1730726699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8ZVH5GxwAKibzog2TH5n/39WEZ0Rd/nXcfSMUNQhE0k=;
 b=kTiAv9IJE/6V6sCPCAcr1SITcqqWlHhY21pwKR/fv08JfDDlCmvmGzYGFGMz7JZJlH
 95cToECPiYtO5+c/EcQO47AybJ5DFYlJqOpO+AIQB2n2JZAA/RpPw/iseLOhdG9AqPvx
 BHp1t83rhN7keZ0vs8kbA8J0jQm5KNznDHNK1C3CXAE2a20ZYMjRD13J5Hzf5yJiGUZW
 +mXKCI9cnQsGCyH9NvzOvqs0oS29KKGJ9v5Wey3Jin/dL2WhlkwOTek/tdxH7kRleNMn
 xu94M9Qk4QfG90m3iDmGNhC++37MCFBFmy+5Sz7avdccjusScgoXfK2JMRPwisDB6zq9
 6Plw==
X-Gm-Message-State: AOJu0Yz9AEA5pIIRp22qwze32psU1fSzQWjEni+EGFvAZuPaCbpa1yXT
 rvAoO0baao5qVmxGCs4SppU7baI80+hSlcTOCBoOqv9eYAMMqLLIh04L8g0+GCf3TDYud34QFSM
 /k23yDgssGV1q9MaY3GoKOiTXvBJBgxIsD+3hgQ==
X-Google-Smtp-Source: AGHT+IE2uv+pbb6s3IeZMiIDJur/VZgnyUoSior5kxQdu586SRDTnX4rTl9gEbhZOzduXbpfyQ/cr2yH6zVe9MJV9AQ=
X-Received: by 2002:a05:6402:348f:b0:5c9:709c:24ab with SMTP id
 4fb4d7f45d1cf-5cbbf8795aamr7511329a12.6.1730121898946; Mon, 28 Oct 2024
 06:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240813152054.2445099-1-peter.maydell@linaro.org>
 <20240813152054.2445099-5-peter.maydell@linaro.org>
 <b090fac1-85df-4727-a382-8a934bd02f33@redhat.com>
In-Reply-To: <b090fac1-85df-4727-a382-8a934bd02f33@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Oct 2024 13:24:47 +0000
Message-ID: <CAFEAcA_VWKkZyagd7aPWjAM8maJDZnXaR_aVjQ8MEkVUU9-=CQ@mail.gmail.com>
Subject: Re: [PULL 4/4] target/arm: Fix usage of MMU indexes when EL3 is
 AArch32
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Fri, 25 Oct 2024 at 13:54, Thomas Huth <thuth@redhat.com> wrote:
>
> On 13/08/2024 17.20, Peter Maydell wrote:
> > Our current usage of MMU indexes when EL3 is AArch32 is confused.
> > Architecturally, when EL3 is AArch32, all Secure code runs under the
> > Secure PL1&0 translation regime:
> >   * code at EL3, which might be Mon, or SVC, or any of the
> >     other privileged modes (PL1)
> >   * code at EL0 (Secure PL0)
> >
> > This is different from when EL3 is AArch64, in which case EL3 is its
> > own translation regime, and EL1 and EL0 (whether AArch32 or AArch64)
> > have their own regime.
> >
> > We claimed to be mapping Secure PL1 to our ARMMMUIdx_EL3, but didn't
> > do anything special about Secure PL0, which meant it used the same
> > ARMMMUIdx_EL10_0 that NonSecure PL0 does.  This resulted in a bug
> > where arm_sctlr() incorrectly picked the NonSecure SCTLR as the
> > controlling register when in Secure PL0, which meant we were
> > spuriously generating alignment faults because we were looking at the
> > wrong SCTLR control bits.
> >
> > The use of ARMMMUIdx_EL3 for Secure PL1 also resulted in the bug that
> > we wouldn't honour the PAN bit for Secure PL1, because there's no
> > equivalent _PAN mmu index for it.
> >
> > We could fix this in one of two ways:
> >   * The most straightforward is to add new MMU indexes EL30_0,
> >     EL30_3, EL30_3_PAN to correspond to "Secure PL1&0 at PL0",
> >     "Secure PL1&0 at PL1", and "Secure PL1&0 at PL1 with PAN".
> >     This matches how we use indexes for the AArch64 regimes, and
> >     preserves propirties like being able to determine the privilege
> >     level from an MMU index without any other information. However
> >     it would add two MMU indexes (we can share one with ARMMMUIdx_EL3),
> >     and we are already using 14 of the 16 the core TLB code permits.
> >
> >   * The more complicated approach is the one we take here. We use
> >     the same MMU indexes (E10_0, E10_1, E10_1_PAN) for Secure PL1&0
> >     than we do for NonSecure PL1&0. This saves on MMU indexes, but
> >     means we need to check in some places whether we're in the
> >     Secure PL1&0 regime or not before we interpret an MMU index.
> >
> > The changes in this commit were created by auditing all the places
> > where we use specific ARMMMUIdx_ values, and checking whether they
> > needed to be changed to handle the new index value usage.
>
>   Hi Peter,
>
> this commit caused a regression with one of the Avocado tests:
>
>   AVOCADO_ALLOW_LARGE_STORAGE=1 avocado run
> tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_bpim2u_openwrt_22_03_3
>
> is failing now. It works still fine before this commit. Could you please
> have a look?

Thanks for the report; I've investigated it. The cause of this specific
failure is that regime_el() doesn't return the right answer when code
is executing in the guest in Monitor mode. The effect is that because
regime_el() returns 1, not 3, we look at the wrong banked registers
and the page table walk fails when it should not. This is enough to fix:

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 203a2dae148..812487b9291 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -926,7 +926,7 @@ static inline uint32_t regime_el(CPUARMState *env,
ARMMMUIdx mmu_idx)
     case ARMMMUIdx_E10_1_PAN:
     case ARMMMUIdx_Stage1_E1:
     case ARMMMUIdx_Stage1_E1_PAN:
-        return arm_el_is_aa64(env, 3) || !arm_is_secure_below_el3(env) ? 1 : 3;
+        return arm_aa32_secure_pl1_0(env) ? 3 : 1;
     case ARMMMUIdx_MPrivNegPri:
     case ARMMMUIdx_MUserNegPri:
     case ARMMMUIdx_MPriv:

However, while I was thinking about this I realised that there
are some problems with the design change this commit is trying
to do. The idea is that we now use the same MMU indexes for
Secure PL1&0 as we do for NonSecure PL1&0.

Small problem:
 That means we need to flush the TLBs at any point where the CPU
 state flips from one to the other. We already flush the TLB when
 SCR.NS is changed, but we don't flush the TLB when we take an
 exception from NS PL1&0 into Mon or when we return from Mon to
 NS PL1&0. Now we need to do that, so any time we call up into
 Mon and back we'll dump the TLBs, which is a bit sad.
 (Also we could skip flushing all these TLBs when NS changes.)

Larger problem:
 the ATS12NS* address translate instructions allow Mon code
 (which is Secure) to do a stage 1+2 page table walk for NS.
 I thought this was OK because do_ats_write() does a page
 table walk which doesn't use the TLBs, so because it can
 pass both the MMU index and also an ARMSecuritySpace argument
 we can tell the table walk that we want NS stage1+2, not S.
 But that means that all the code within the ptw that needs
 to find e.g. the regime EL cannot do so only with an
 mmu_idx -- all these functions like regime_sctlr(), regime_el(),
 etc would need to pass both an mmu_idx and the security_space,
 so they can tell whether this is a translation regime
 controlled by EL1 or EL3 (and so whether to look at SCTLR.S
 or SCTLR.NS, etc).

So now I'm wondering if this merge was a good idea after all.
Should we do all that replumbing required, or should we
instead revert this and take the "straightforward" approach
described in the commit message above of adding some extra
MMU indexes?

(I suspect that this commit is likely also the cause of
https://gitlab.com/qemu-project/qemu/-/issues/2588 )

-- PMM

