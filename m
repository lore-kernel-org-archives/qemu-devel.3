Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6080D21274
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 10:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Nns-0006Cl-DT; Thu, 17 Oct 2024 06:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1Nnm-0006CI-1z
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 06:32:19 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1Nnj-0006KZ-3X
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 06:32:17 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c9634c9160so936208a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 03:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729161132; x=1729765932; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pces13t/DUB53Wq2QHtofpvVVgUrfTIzZRUy1PindXs=;
 b=tYOMOTK2MGjOyQF/5oXh5bLKpgEaUYACFgZ59/XbisZeC9mxvpwcZcsFRWL/+yhZ3/
 rF8ubLiiLkSIjvZR/xlIEDz5jTMulBO/APF2stmrpj8YSAkD2V1J0JWV2C2GLn42Tx9V
 zSQXmUG8R0pJnLjy/iQy0SlEWbJR7qtMkpp4maMEpOU8JjR8/W0ZliEILt6Gk8cZcyoB
 dvteKLRxMFf/jnx1cvAH1Az15YK5YJQNR4ZcTsywZ5rJFWsIivujI11s0PxbeLELD9Pu
 uf7axovLuteKpASfBsjidXFsGieNJRG5PG1IovlbifsobRDDzGHEu+NJfpxGvg5hz2h2
 xYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729161132; x=1729765932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pces13t/DUB53Wq2QHtofpvVVgUrfTIzZRUy1PindXs=;
 b=lkIxNgy25TO/jKwM99C3jQbGLif4U2e5VPmFO02ceZ2qXiIjYmDDjTL/zAreQS+nA9
 jzpLrL5L+EfO+hzrxliWbiYQEN7SpBgi3mUSJ4KzegDKUN1bKie35/EaZgsZHsz3Cf3m
 1v/O4u3yj9KftlR74MFliOi7pHK/qzrm7zXuxcFh58AirnBo/PaLqtOOBI0bV45MBhCU
 5naeRm+Gg8WX40fnrulm3kVa6rMiXPRddJNWcW67f7Flhz7yji5WVm/LZxUUj8zqwZME
 XsS+pDfa5qDF88uGWy5FvZ4vJuk+qus5m/+gphJs9O4JYqe5WI6kG6+wL0wZwNBjmkj6
 3soA==
X-Gm-Message-State: AOJu0YwJc77WWjfNGhQVADhJZUJsWciU6nJ6nEziRal5Fv7KxKN1mpX0
 4B9rFe078aw+ElvtZpcVQ6MFJd+QHRpbFQ2VyvxLrqW5OsIj7fvBmEfjj4vY8bmr5qILkwapCJm
 ZDoElW//V8ITz8iTUkAsfI1Klx4aq5HY1I41PWg==
X-Google-Smtp-Source: AGHT+IHq9HyXjc6KS8iecTRwwnFWQvi88uzSwlf6dwMu5EHnETF2ly/zNrdWuncFLe1BdqdNSiFx6Q15ae/8Lxpc3a4=
X-Received: by 2002:a05:6402:3591:b0:5c9:8ab0:2975 with SMTP id
 4fb4d7f45d1cf-5c9950b94e9mr5333590a12.6.1729161131736; Thu, 17 Oct 2024
 03:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20241015141711.528342-1-pbonzini@redhat.com>
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2024 11:32:00 +0100
Message-ID: <CAFEAcA9L6t3xtw9BNGKyuzjZ-ugkO-o47RbH2X=JU8T6HHeDwA@mail.gmail.com>
Subject: Re: [PULL 00/25] x86 and KVM patches for 2024-10-15
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Tue, 15 Oct 2024 at 15:17, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit aa54f5be44be786636a5d51cc1612ad208a24849:
>
>   tests: update lcitool to fix freebsd py311-yaml rename (2024-10-14 15:54:24 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 4bfdcb24fa5dc0844d0e4ab2cebb6687a233c0ff:
>
>   target/i386: Use only 16 and 32-bit operands for IN/OUT (2024-10-15 16:15:47 +0200)
>
> ----------------------------------------------------------------
> * target/i386: Fixes for IN and OUT with REX prefix
> * target/i386: New CPUID features and logic fixes
> * target/i386: Add support save/load HWCR MSR
> * target/i386: Move more instructions to new decoder; separate decoding
>   and IR generation
> * target/i386/tcg: Use DPL-level accesses for interrupts and call gates
> * accel/kvm: perform capability checks on VM file descriptor when necessary
> * accel/kvm: dynamically sized kvm memslots array
> * target/i386: fixes for Hyper-V
> * docs/system: Add recommendations to Hyper-V enlightenments doc
>
> ----------------------------------------------------------------

As discussed on irc, this (maybe?) runs into the s390 host bug
you posted a patch for, so I'll wait for a v2 of this.

-- PMM

