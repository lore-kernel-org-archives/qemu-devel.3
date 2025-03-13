Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3BBC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslHo-0004Hg-Il; Thu, 13 Mar 2025 12:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tslHl-0004Gl-Qy
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:19:53 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tslHk-0002L7-7s
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:19:53 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e589c258663so1099739276.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741882791; x=1742487591; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fniIDk5AwucmYSwZ8t05YroxXwdwrFZK5pOSjV98Isc=;
 b=rSBtRpSUG2aB0ai4pEg4Sf0GU8cVVVQxqzwl/C9DuCLMJKJ3vBLYO/SqMlDsqKQ/Ay
 Kga1SAripQJLBJ76PeM382NDF5rETZ00PTSsVBFvIqwpfMR8xnEVvyggR5JB9XnkZxO2
 QZ9N8RxdwDPo3YGoWY1sX4lD4f9+UQZqLCRwbHXmWQ8M35Vm3TJZ9lHC/dNWAFZbKGED
 AOFa5gQNax9/byOu/iS3iH/QeCnFwZT0L/povnAZK+3wzgvk1ACLIZlCq83X6HM37pJv
 nQPBgunXoX8DmiTldshREU+xh/ezpPWMUibVbjenKp4iW2Ap2dxEM6qoUC1SwzhJ+lCQ
 VOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741882791; x=1742487591;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fniIDk5AwucmYSwZ8t05YroxXwdwrFZK5pOSjV98Isc=;
 b=rAttSd5MKs9bafunDrgneew8wzTOCUzMXBcCW9apDJfEHXWWCekOrup6LziytEwMUB
 mSNcQ/oUjke2aR6afqtO+gRjjXsxT+/5YDT6LNdAUSmJmc3pAsjjO8Vuj6TigGErLFsH
 x4ILeOmHqKWwqnFKK9k4oHlret6texEKJjiucSZyrOw/Vi6lgqcJaz9Eb+Kltj+PLz5w
 rimTE6ywF4EUR/ZIgONDD4GFKC+S8vs5HO5Yu+Mw1e8vQWrQBTol1RQXSUR2UdXsR7H0
 9vyJwg3VrS3a9oxHk811zC2wmLduVnsTLmREHuqgWHRFCBOlxc+aAguI/9EyFkIBIrFk
 9PIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4nGMEXchqrZyDyqz0kSFMe/UkJjB/FarunbcEEhJeHbK/CFXjebBpN4ilyRNhRYHpckgaB+pJ7FYy@nongnu.org
X-Gm-Message-State: AOJu0YyvqL3Rld+dRihhAogtixzYzWuRK12Xh90g/SMBJ7t+XilgDlTl
 FMN2XTUsHdE8hrBxwGd/YlZ0LaQRHCjyvH9lxwyReJQ6o/1gooHPBvQqLdlVk2ea4kAYgJEB8Ss
 mtMwJJFNYH3Rq+yTvqYrkKlH2cN76EOMAfogSfCjFjOc4IOjk
X-Gm-Gg: ASbGncviTjb95oTn18jCwlyNLYl5wVsMJwaKgL8Q5WoMIvR+eHbrMgYrbiIJDgxr6ta
 BhGHdDqFASJGZGB7GZ9P1FpnJCf5KMw7PbHJyumsqJQMML6uWvG70rSwPlh7HQCni0XK+VmBpk3
 UhqCQig3gU4GrHEhSrbRBYjbFWI2I=
X-Google-Smtp-Source: AGHT+IGLLVyjALewS4JzS95tNyG3cUkFkqiAxDbJE4baSrvRU0zHxeM+x3YiwJ+wXAi89hoUWl4OBB/05fGZ7gfIgWo=
X-Received: by 2002:a05:6902:2842:b0:e58:8e82:5345 with SMTP id
 3f1490d57ef6-e63f3a180aamr71319276.4.1741882790629; Thu, 13 Mar 2025 09:19:50
 -0700 (PDT)
MIME-Version: 1.0
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
 <20250306163925.2940297-11-peter.maydell@linaro.org>
In-Reply-To: <20250306163925.2940297-11-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Mar 2025 16:19:39 +0000
X-Gm-Features: AQ5f1JrpsG8YGw6A5coVaLGbTXvjqAf_G3KtIOSSkn8M7Ja4KELjrgelACIxahU
Message-ID: <CAFEAcA-h4faw-g8Q2cWrPCH75fDeFBZ_J2s1FdVpjkUuJ8yH2Q@mail.gmail.com>
Subject: Re: [PATCH 10/10] target/arm: Forbid return to AArch32 when CPU is
 AArch64-only
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Thu, 6 Mar 2025 at 16:39, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In the Arm ARM, rule R_TYTWB states that returning to AArch32
> is an illegal exception return if:
>  * AArch32 is not supported at any exception level
>  * the target EL is configured for AArch64 via SCR_EL3.RW
>    or HCR_EL2.RW or via CPU state at reset
>
> We check the second of these, but not the first (which can only be
> relevant for the case of a return to EL0, because if AArch32 is not
> supported at one of the higher ELs then the RW bits will have an
> effective value of 1 and the the "configured for AArch64" condition
> will hold also).
>
> Add the missing condition. This isn't currently a bug because
> all our CPUs support AArch32 at EL0, but future CPUs we add
> might be 64-bit only.

I noticed today that actually we do already have a pure AArch64
CPU: a64fx. What saves us is that guests aren't silly enough
to deliberately try to return to nonexistent execution states.
I'll tweak the commit message to suit.

-- PMM

