Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D26C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqEIA-0000vO-R6; Thu, 06 Mar 2025 11:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEHw-0000iQ-J6
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:41:38 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEHu-0005PX-T0
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:41:36 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6fd8be1e534so8431087b3.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741279293; x=1741884093; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tuE7sAT+n3xPBCauhqafEUU/Z7tC+IuzsmyDxqxYy8g=;
 b=tyHbUL4rlx98W5EgQ0sj5oW3mGJJLm0fA4QmbIOcBm9XQ1i3ldISatUGC4+LO1dfsp
 98veupZrN5t+B9/z3q/mU4z69sVYLyXxR1Fhd1l7yhqWX/vudFgZSNKsFw/WjlKkIJqz
 ulWhskTiCHjCBwqn264BdZFXAS51B6GCPjYvgRAC19EmA8pHGuRzivmwwET7QVgg660l
 tbGLwqy8g4y6cDiJaJcciQ0iqj5uQZTmP+T/09hl3626UYA657WePHxcxfb3WiHobyxq
 asX2kUeulBXZk5Cuq/vFJ81HDWX/yNoFyP168LNfCzUterfuqxC7e1W+Dmqg4qqK1gt7
 YTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741279293; x=1741884093;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tuE7sAT+n3xPBCauhqafEUU/Z7tC+IuzsmyDxqxYy8g=;
 b=lBqGPFJr/DpJJpxjcBDX6NgT2N7df6TN5v2HDfUrQAx8N0NAtuCeKVW1SBrXpfdMZE
 i0mXSyxblVj12lOObhnLm5i23ni/rifbw+cSoB61n1WrrO8xVUGJOyUiXiRWJtgAGEy4
 6keDKXm3qZ7k7lFH8XAiRrDbWRQX/3NlQyXsk7YQOKkz1s6qu6qbHvM/R5IdBy/AMIAa
 sNHV7lxpLzlYEZUOyIn/ZMdVOKDxDc6WA642C6AeH1/lu9qDJ3dWuO6zliAuqmCuUN2q
 g8GwWoEXzFJO3eD4JfYYvDuK8SCYzuNPZ3GlRpZoE3xnreaBfH8AXVyU+SIHcnJuvkKj
 bAqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOQvxT4ONC8GvAaF36dZjnLuE4pawnxva5YyHDtQWM1PYNIHplc98ZssiBPWDuAjtXzn8SeqWYyi6w@nongnu.org
X-Gm-Message-State: AOJu0Yyx4+qLOFmf06lc5tqCnAhIXlFPDlNCTqT+BtF6eDWKRRql7VZB
 GfVzO08B+qhFKtDUXpoWgI6e6Dzs5dyqkp9mryFoKebQ2vhxNlzVXUqZS44MZCfz7ABQ/jlklWh
 pk7wv1XpAUq8R+Mx5fhRm0UEwTxrBLwyzhNUb5w==
X-Gm-Gg: ASbGnctMHaSyjtd8Z1fjp/KxCW/oA+ZMOOQBPjMOgzC+DmK593WHNiejh+h6HqtiDac
 kXL5HGYp7bA85SrtBgqMkoR3ve3m731pHjzUuZt3LURMd8qof9o85IKr8vR5ZkRHQz29etxv4+n
 tKpCkcCVqIJ8QDtRNJUVVC/ws9+Jc=
X-Google-Smtp-Source: AGHT+IGrIld9lFINAvm3RbCjtTvZCDPufYXALDYiM29oLzWtQOIB4YLIVElw8MjUe8w+rRSXeChP8kYPHrLO0Z1LBhw=
X-Received: by 2002:a05:690c:6009:b0:6f9:48c6:6a17 with SMTP id
 00721157ae682-6fda3018933mr98932527b3.26.1741279293570; Thu, 06 Mar 2025
 08:41:33 -0800 (PST)
MIME-Version: 1.0
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
In-Reply-To: <20250306163925.2940297-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Mar 2025 16:41:22 +0000
X-Gm-Features: AQ5f1JoDreMEI4B7qV2l_bTBhgXgesld--17niqj2WiZlEgRMn5BhszwrB0rMwg
Message-ID: <CAFEAcA8g0D_TyRyBGjjC=RaPjp-aNQb-P5K7bUcvDACDpWFFyA@mail.gmail.com>
Subject: [PATCH 00/10] target/arm: Forbid exception returns to unimplemented
 AArch32 ELs
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

Apologies for the bogus subject line in the cover letter:
I accidentally put a leading ' ' into the file and then
git send-email interpreted that From line as the subject.
Intended subject line was:
[PATCH 00/10] target/arm: Forbid exception returns to unimplemented AArch32 ELs

-- PMM

On Thu, 6 Mar 2025 at 16:39, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Newer Arm CPUs need not implement AArch32 at all exception levels
> (and Armv9 forbids implementing AArch32 at any EL except EL0).
> All our current CPU models implement both AArch32 and AArch64
> at every exception levels, so we currently get away with failing
> to enforce that the guest isn't trying to do an exception return
> to AArch32 when the target EL doesn't support AArch32.
>
> This patchset adds the missing checks:
>  * SCR_EL3.RW has an effective value of 1 if EL2 is AArch64-only
>  * HCR_EL2.RW is RAO/WI if EL1 is AArch64-only
>  * return to AArch32 when no EL supports AArch32 is an illegal
>    exception return
>
> To do this it needs to start off with some cleanup. This is
> because we need to add a cpu_isar_feature() check to
> arm_el_is_aa64(), but we don't want to include cpu-features.h
> in cpu.h. arm_el_is_aa64() is really an internal part of the
> CPU implementation, so we can move it to internals.h; this
> means also moving some other functions in cpu.h that are
> defined as inline functions and which call arm_el_is_aa64().
> Removing some unused macros from linux-user allows us to
> avoid having linux-user include internals.h.
>
> (No doubt there are other functions that could be moved out
> of cpu.h, but I stuck to only the ones that I actually needed
> to move.)
>
> thanks
> -- PMM
>
> Peter Maydell (10):
>   target/arm: Move A32_BANKED_REG_{GET,SET} macros to cpregs.h
>   target/arm: Un-inline access_secure_reg()
>   linux-user/aarch64: Remove unused get/put_user macros
>   linux-user/arm: Remove unused get_put_user macros
>   target/arm: Move arm_cpu_data_is_big_endian() etc to internals.h
>   target/arm: Move arm_current_el() and arm_el_is_aa64() to internals.h
>   target/arm: SCR_EL3.RW should be treated as 1 if EL2 doesn't support
>     AArch32
>   target/arm: HCR_EL2.RW should be RAO/WI if EL1 doesn't support AArch32
>   target/arm: Add cpu local variable to exception_return helper
>   target/arm: Forbid return to AArch32 when CPU is AArch64-only
>
>  target/arm/cpregs.h           |  28 +++++++
>  target/arm/cpu.h              | 153 +---------------------------------
>  target/arm/internals.h        | 133 +++++++++++++++++++++++++++++
>  hw/intc/arm_gicv3_cpuif.c     |   1 +
>  linux-user/aarch64/cpu_loop.c |  48 -----------
>  linux-user/arm/cpu_loop.c     |  43 +---------
>  target/arm/arch_dump.c        |   1 +
>  target/arm/helper.c           |  16 +++-
>  target/arm/tcg/helper-a64.c   |  12 ++-
>  target/arm/tcg/hflags.c       |   9 ++
>  10 files changed, 202 insertions(+), 242 deletions(-)

