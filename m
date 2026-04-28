Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5836AFF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 10:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHfu5-0004QG-JX; Tue, 28 Apr 2026 06:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHfu4-0004Q5-Jc
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 06:42:56 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHfu1-0001G8-Mm
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 06:42:55 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-79ea87af213so172298947b3.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 03:42:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777372972; cv=none;
 d=google.com; s=arc-20240605;
 b=igSmtO+NnVf9j7zk9d0QlH47jUPN+R4rpqp5FBzlYkLleO6PQtuht9ZPxajNiMprnm
 6Zx03trpvPqGiMPMK+Dv7U8FZNz2XdecruE4mZIKBDE4hoh0gm8PMTrQf7fS44uCPGg4
 osP6mGSjgqWG0cxFMsVKGGWRHizfO7SxiJjhklhotUG6WweS139A/For/4N0Vug7a6IV
 G4DmIs4fj7RG3L1vh6S6LF4Ea6g2Gx5Q18MatXBA4lO148mElYYyXSKPWYR1F8/xpElU
 2rTYblhPMsoLLp4nfMD9X6y059yGp2BejnYCD2032ld7qlh0JYlkVSMTboZYbgLdI1iL
 0fmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XyuLJ2acgigc4inJToIhuacAWML7bwST1UsRNbAvs/s=;
 fh=TK+7bdEh4JGidnUcE46pZZLNEUolwuPWo5yppnwsEfw=;
 b=TiOpMNikLV/zdOt3uQPztYxug4ZTktr06P6xw9neqyi+FndsDKJYiiWPTHgEgBmVQe
 Ewn1lnRynVTVCYpdez8s+1wRo7H4iMsgk+4tYJWjNfbX3u0iroozIMO0jL+M+X/rG2ys
 Uh3kb+c1JYZUlM9k/5CWcFQ282HLKFZoB1pSnpDw0TX+oTy37jt0I/OJxAEG/Fvn4R4/
 r+WupY2nPWVXxH2SI5c417FgBNo+NdWrQvhN+Me7/rVAib3MP7N3BBVaOc2SrxTPQvcl
 tALeAQwHB0YKQ37k+MHsbO8fYBGMr9mXHpYENqC0NJlVT3JzqUcLtD2WwpebojujY6kq
 lDhQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777372972; x=1777977772; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XyuLJ2acgigc4inJToIhuacAWML7bwST1UsRNbAvs/s=;
 b=IcOhjG9ZK6rGFrvlItPtUUA/UhBRqOwRjTRoPRhq1alHOc8mkKthJVSI6DdIkIbcnM
 nZL1vhvrUZRRNCvB+89SFufdf/PuWmSwetgh4kisx7hJjqxnUXLHLlcq+azb50Jgkx/T
 GFxS5tDevdMQGl/jhP1zFRrvQbdekerapbcxbztMTObIHJ+P223uURVrA1q5mXDqdO99
 2pCX47C4Bq4pFLKSRWXNz49H2vFX9xzBMY2fn/1N6oKu8T4VzEP/uovyr5h5PLB1LxPc
 3uT9qEwMYHWGSp0PUPazUr1mlrbMG+QylbkITtiJPRJLNJZnnMT2O5YaCWPZueumDzi5
 98mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777372972; x=1777977772;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XyuLJ2acgigc4inJToIhuacAWML7bwST1UsRNbAvs/s=;
 b=LxQN/HPTC3sE4AqHDYTocl0mdrrKFlCd+Z7v0zuS/Nt4JrfWQRP0N7kRaWo1gHnnbF
 jCjon6143wGIDGL9KHF/K3yfTJMK+40vwXyZI10BScTMcScIlIqnW8jsxpUdB35oGHwA
 v2gwL2nz5QvTN3BEy5lPVsjuqbAc0VIbmaa+zODLgSePf/B7zQoQn5hqnck8cMn5/H8v
 uQzzdbHzOUYA5efPcSoN0ei3O5VEVllQACnynE4tDmXvaaIGbp3iO159kwuUShfY5tNC
 VmGATcP5qDxPYVtJTd/K8SyhU1slOk4WqVRxN9E74ejv9VKUgcTsi8Z/swmxfPC4xEX5
 k6ig==
X-Forwarded-Encrypted: i=1;
 AFNElJ/V3hBPdgRyZFLocvpY0Rjbys8TgpSLSAS8MqVOaVrsxvHxU+lP3TGYzyliXapgtACH2uD72IbeFM5F@nongnu.org
X-Gm-Message-State: AOJu0Ywy3o5WF5oHKnjY+wMRzR0ovs7R+YMsrfMP2gl7tOk/UJl41RaD
 sLsO1c7Miv33eauX7g5ZJP706j+alxIqFmwkgRYyG+66utHgbVNCryjdmdPOE/us/xXZNGKQIup
 +vf3WcR68jKB2Kpfwt/Tgwv4vz1qgI+w+By5n29q5ZA==
X-Gm-Gg: AeBDietlSj/qJhrQ/Ete1QVtlhU2Ea/lro1w64dHt5sMU0L/Ds9moFDBxLYQPeeuLe1
 x8Q3Pd2+fz0zFJ4AyqUb9VhaWjbTD3t+979nBW0vsCKv11aHxkP/gglRDyOQ2CfAm8m116cGvcO
 sQNIV2vfKGW4CVZLYrEkS9Enwh4OAd1LedH5GvNfA/jaYzhxKMg1sTHGVKu8tgTsSuv3xewvtkG
 7YoNTwF5R5q2+Ibl/ejyXUq3g6PHVHhuQp81mmJZwQU9K0K1pr+X5CsEQuXyVHpoWC/qF4UaPC3
 242dT1LrN5eyrTBqBP9Aotq90Dq6Mh6SNA8sH0zpb2LZ06gm+4f3x0rdyrqBt6s6BuRX1oEBnSF
 S+A==
X-Received: by 2002:a05:690e:140f:b0:651:c221:9649 with SMTP id
 956f58d0204a3-65bee79ad34mr1754987d50.19.1777372972016; Tue, 28 Apr 2026
 03:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-15-peter.maydell@linaro.org>
 <09da5690-5b9a-4930-8fd5-cecf1e3b8eb2@linaro.org>
In-Reply-To: <09da5690-5b9a-4930-8fd5-cecf1e3b8eb2@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Apr 2026 11:42:38 +0100
X-Gm-Features: AVHnY4JtrHZuJtxqxJ4E0rMQpdCF9R8l3F06nd1BOiw9dHd2UWWMt4DHF_H2XTo
Message-ID: <CAFEAcA9-HLzGBFpZu58Z+Y9PNEGQFVBAYiM8Y3oCcYRHdGhsTg@mail.gmail.com>
Subject: Re: [PATCH 14/17] hw/core: Implement new cpu_translate_for_debug()
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Thu, 23 Apr 2026 at 04:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/18/26 03:31, Peter Maydell wrote:
> > In cpu_memory_rw_debug() we need to do a virtual-to-physical address
> > translation for debug access.  Currently we assume that the
> > translation is valid for an entire guest page, but this may not be
> > true if the target implements some protection regions that have
> > sub-page granularity. (Currently the only such target is the Arm
> > CPUs when using an MPU, as in R-profile and M-profile.)
>
> RISC-V has sub-page granularity via Physical Memory Protection (target/riscv/pmp.c).

If it does, it isn't implementing it properly, because nothing
in target/riscv sets CPUTLBEntryFull::lg_page_size as far as
I can see.

> > +bool cpu_translate_for_debug(CPUState *cpu, vaddr addr,
> > +                             TranslateForDebugResult *result)
>
> Whee!  Thanks for the new API to address my comment vs patch 10.
>
> > +{
> > +    if (cpu->cc->sysemu_ops->translate_for_debug) {
> > +        return cpu->cc->sysemu_ops->translate_for_debug(cpu, addr, result);
> > +    } else {
> > +        /* Fallbacks for CPUs which don't implement translate_for_debug */
> > +        if (cpu->cc->sysemu_ops->get_phys_addr_attrs_debug) {
> > +            result->physaddr =
> > +                cpu->cc->sysemu_ops->get_phys_addr_attrs_debug(cpu, addr,
> > +                                                               &result->attrs);
> > +        } else {
> > +            result->physaddr
> > +                = cpu->cc->sysemu_ops->get_phys_addr_debug(cpu, addr);
> > +            result->attrs = MEMTXATTRS_UNSPECIFIED;
> > +        }
>
> We should really make a point of getting rid of the fallbacks.

Yeah; as I mention in the cover letter I think that would
be a good idea, but I wanted feedback on this API before I
went to the effort of converting other targets to it.

> Would it be less churn to drop the get_phys_page_debug to get_phys_addr_debug rename, and
> OR in the page offset here?  That plugs the -1 ambiguity in the short term.

My preference I think would be to take this series basically
as-is (as you say, -1 isn't actually a valid address for
our current targets) and then update things to use this new API.
A corner-case problem with the old API is less important if we
are going to get rid of it / limit it to targets where we
know -1 isn't valid.

> I realize that microblaze must be converted to the new hook, because of its tlb oddity.
>
> With arm and microblaze converted, only x86 still has get_phys_page_attrs_debug, so that's
> an easy hook to eliminate.  We can be slower about converting the others if you prefer.
>
>
> > +        if (result->physaddr == -1) {
> > +            return false;
> > +        }
> > +        /* Indicate that this is a debug access. */
> > +        result->attrs.debug = 1;
>
> Does MEMTXATTRS_UNSPECIFIED.debug make sense?

It's what cpu_get_phys_page_attrs_debug() already does for the
"CPU only has get_phys_page_debug()" hook; this is just inlining
that existing code so I don't call cpu_get_phys_page_attrs_debug()
directly. It's a bit odd but really the only thing that we use
the .unspecified field for is that the IOMMUs check it to see if
they can look at attrs.requester_id etc. Debug accesses are not
going to be going through an IOMMU.

> > +        /*
> > +         * Assume memory access permissions are valid for the whole page.
> > +         * Targets where this isn't true should implement the
> > +         * translate_for_debug method.
> > +         */
> > +        result->lg_page_size = TARGET_PAGE_SIZE;
>
> TARGET_PAGE_BITS.

Whoops.

-- PMM

