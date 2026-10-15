Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B8FCC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIsk-0005cr-5H; Thu, 15 Oct 2026 06:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHIsW-0005QR-QP
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:40:06 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHIsQ-0006J0-T4
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:40:01 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8aca68653e3so8528657b3.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792060789; cv=none;
 d=google.com; s=arc-20260327;
 b=FA4HjmMtPtl935p2cPFgzAll9McS3eLNy/F9jbjnc4v4dqO+xaDtD3/dDGwX7qYx+i
 zguKTKGU81I7BP4hcZ/cvm68DF8YDygumNYw6IXZFAvpGLpuORxidJ1ZEs1bO1EI5NeX
 9BnBrWjuoJFVsMrHIJQZhcGyptueFpJL33QvVEh21kp5f+xriX5ha/1QJkecnCWc46A4
 TAbYmVcaVqZ+TzFZIjpryqv5gYgTTJKuBqOJ3uGeKSiv3VuRW/wX81Ty68GzLy/uVKez
 1wEl/axhSt5mgApBI1QHkld1QiYg36vhIt4VHSXSr4yXsrG2zR6hWLsOZ1FJYOjxnHoo
 lOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=V/znOodw9ZtSRrxHNh4pka25Q+ZzciVoG0oKJ7iCvkI=;
 fh=FmWorL7/Upx2lVgq4aNDBsFB3fvRuUJ8rEVJeou0fYg=;
 b=ANeqziyUY1G4bLJJVDaU4O8h/UWFHR1h6eMF3KPioDpdYHlluIcQrIRv/B2fmhN0v+
 dAW9BLwymSp9MfImXLU4kY4f+RC+NxorAMW87Hp10aTpeFlmcXRYu18xW4H/MDP98FXu
 1RcHAmGG6OVfMsT9HVass4kVjb3uPWIjuYUf93vYmmJU9Oj3zESwqwwVIYnV8AcaqwBS
 O5+Ze4nBAKYNvMMJxutRU8yrE6GkOiA3TRSNLnj1iLxz7IFLbHW9jHF5i8dlxVjz1pWV
 H6HGNyj/R0QfJPP3pld3M0T/cmESXH58JSdPk9SvLA4BRzJZSv0vBIvA/Qaowt83250R
 hs9w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792060789; x=1792665589; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=V/znOodw9ZtSRrxHNh4pka25Q+ZzciVoG0oKJ7iCvkI=;
 b=vOiPTq/hw+siiTVtfkb8VqqI0ebEb71G37BFSmARqsX8kKnhp6CJ1zBEpLLLunxf5Z
 DxCGbH5gF3VKdJKQhTEPA9TROyaSLSQe8c+Ly2vSQ6H8k7VLrwjTRoj47DdubQ5HjuKg
 TuzySFBTRvTbyD9DSkCPrcn8dJtLUPIq5Hhv9zMUHxJzzVjlu3qwKvQ9GrsLr1IaesA/
 L4hYmsqZkFCYDorGhxgIpDR1UytwkPBpMEbw3V5Al8TQW4IqztMgFbhisQdp3IlhLNwz
 nl+lTFp2Na4IJu2bQL08qbrxZppF5nGdnvLrFF8ATfoZFQ9OQiCb/qfqo+qCtAuc9Uvp
 0ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060789; x=1792665589;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V/znOodw9ZtSRrxHNh4pka25Q+ZzciVoG0oKJ7iCvkI=;
 b=BIK0BZq1JGVs/dwil0/ERPrha2xfwNwuxNVil6M0SCpUU6wtgS1/jVNkIkzjbKrN+Z
 YLbpqQkGm54LCoqgHK4Pd7TXSXoymR16ZEc9Xjqn/du5P+X/D3bUUIY4eqkALQE1qczP
 Je5JqE/gH5KN+dPGiJLBk58biLtOscwiX0IjcbPg+H4dfJ4SOa2hB1dsjvu1aNseWO2S
 BV7VVm3MOoxZgMv6oCjERvqKzMdTG3M9bxk2E2vWC8/sn9clK4pj+6KJvNS6zG4hp7Cl
 puXEFvUmevokfYHEgouN+3JyQLteoJ9yyDskms5e5hK5RzQFo89Z8bj9Eoxd4ACAr8vr
 NV1g==
X-Forwarded-Encrypted: i=1;
 AKwUvByCNbF5/el7lEVYaYFDhMjVHsNvQvXYFDgPb6IHUPTrhjIFTJQO0/aHFU8C3h/J//ygULZG2jKK9a2c@nongnu.org
X-Gm-Message-State: AFq9FYKXdJv63oVIc+nK/Lmg64R310gN7UQqoy40KEoEcEpWnnOf/I0L
 UlE0qj/KpjENnnJgyuYF3svfG0CjNpN7DF7cLdrWfu/bYjwh8z8MVPRaXRgj4BOygLIHW2HKiUv
 8q0+T7YrovaOPW6XHr4auH/cr0jtdjRY9+XUMABVt8wBfzhKpIqAJ6k4=
X-Gm-Gg: AYBFou2GPTd+DbwLxPJbeTy3QgHNPjY9/qZkCUgokqlIAKvMNLOiVG4u6cO2WyAipTi
 XolxUrqrYvuSgN7MHptxiENf8E2LlloSueUCYoYIW/3AlVZ6/0ihJGok8tKzoWMsI5JQc3XmIw7
 c+6cBnlDEeCO48oK76vVTVBaE5dnUJCh5ypS4VyFj42H7GM8V95ozcKVmPc9GxzVVBQVy4AcjRF
 6K7IIelzKvjr+MJOR+/3o2k4jB1HJB893tmz1Z6hSfC0rqG+slZxwPypiwXAbko+8odQV7Qs9/6
 XQUYL3/4hBVcciUC629BqWXWfaHhp7gDWgBZN0YRLX2qIiv+QcfmjQVYKHR6Q4lnSBPgPp4rcJs
 0FRiGzIDau6biMU+OBII9Mw4iTsd3PIOIwmlg0AY=
X-Received: by 2002:a05:690c:289:b0:8b0:9e27:fcd0 with SMTP id
 00721157ae682-8b09e27fd6dmr57410827b3.21.1792060788749; Thu, 15 Oct 2026
 03:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
 <20261013083933.1024405-36-peter.maydell@linaro.org>
In-Reply-To: <20261013083933.1024405-36-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2026 11:39:37 +0100
X-Gm-Features: AclHuK9aHktjF_CMh96v8m_Vq8kpnwQFwVtLPlfmgQDJvfdwCQ_F51h_zqRg0B8
Message-ID: <CAFEAcA8UdkDPneWVVBXQ0HS1SdvRvJVqJYA8RN7giT8fX1fh7g@mail.gmail.com>
Subject: Re: [PATCH 35/86] target/arm: GICv5 cpuif: Implement ICH_CONTEXTR_EL2
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Tue, 13 Oct 2026 at 09:40, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The ICH_CONTEXTR_EL2 register is how the hypervisor tells the GICv5
> to make a VCPU for a VM resident on a CPU, so that the IRS will
> forward virtual interrupts for that VCPU to this CPU. We implement
> this similarly to the GICv5 stream protocol, which uses a
> SetResident command to tell the IRS to make the VCPU resident.
> This will always fail until we have implemented the IRS's
> end of virtualization support.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

> +    /*
> +     * Changing V definitely causes us to make a new VPE resident, or
> +     * remove the old one.
> +     *
> +     * Changing VPE or VM while V=1 is CONSTRAINED UNPREDICTABLE
> +     * (R_VFKHN): we choose to make the new VPE resident so that we
> +     * can trust that the information we have in the register matches
> +     * what the IRS thinks the resident VPE is.
> +     *
> +     * For writes that don't trigger a change of resident VPE, we only
> +     * need to update our copy of the register, and recalculate
> +     * interrupts if IIRICHPPIDIS changed.
> +     *
> +     * If we do change the resident VPE, the interrupt recalculation
> +     * will happen when the IRS calls gicv5_forward_interrupt().
> +     */
> +    if (!(valid_changed || (valid && vm_vpe_changed))) {
> +        if ((oldval & value) & R_ICH_CONTEXTR_EL2_IRICHPPIDIS_MASK) {

This is supposed to be the usual "did a bit change?" check,
which should be "oldval ^ value", not "&"...

-- PMM

