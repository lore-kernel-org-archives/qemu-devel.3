Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8E6D5CC99
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 09:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6oQi-0004I0-Lq; Fri, 01 Nov 2024 05:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6oQg-0004Ho-Pf
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 05:58:55 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6oQe-0004D0-SF
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 05:58:54 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c948c41edeso2192780a12.1
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 02:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730455130; x=1731059930; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FmmAWmwH2QSrvE86xYXCpZ43vaQIawGhu8gRk/PLDko=;
 b=Comr7N+Xy9A5oaU1kj+ABbtVj2s+SEYYtjcEnqfrDNRaODMzty5AR2aKKwyeXOMLS3
 7EBGs1c954ExIoRFfETycx6BmHEDfR1qGg++eHeq3nX7Z7MbZyEpd+tjHtN4CpynvmZZ
 ZOqbH+6m35rJXebiXU5nMdjmttawr0qa7Srlpq4z9Vq++TavE72Ps+uEc5GtsvfKsTiz
 PIEI7BYdrHM9oxU3QAkqwON9aS+0QlqFwCNYv0RS2xVmn6eKe07oz2VvnR2oIRi7cxSs
 mNhbDeKPWoYFTM2qt3s27DiRPbEidQbdd+ZH6DDGdar8Od4BhmzOQgcpEcCsObVA+yty
 FTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730455130; x=1731059930;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FmmAWmwH2QSrvE86xYXCpZ43vaQIawGhu8gRk/PLDko=;
 b=OF32MQ0hUHetLeNGAPDi0hft/jYYseeKQNuLGR4vad2RMbPs0Uw8WnoSe3py0g5nYU
 qA95ZRnSTXhB4qkIvEpIaQtNK/p/4v+w+c3o4oKjP+Dxjl2IoKjcvrAG6QdfiMxQDpQs
 /rQnMfispNPYi+eDHfE8l7MDt2nAzwEX6OWVHmsM6wuzyR9qqX2jBIxRjmP9w1oh+s/5
 a7aaF33wedT6trQB8I3M0k1WJ5RvT9vFdZpnopHkWYsAjqASR99aBpSiS92BBv08Od5r
 bw1+Co+rfQ+GMBKDb+T2GzC+PS7V0IjRMpFfskntWByVYzWBEAOOP21MbcQwHy3q9PLz
 STNA==
X-Gm-Message-State: AOJu0YwZ1IT0GFRTjYveWY7ooghhAng4ufTwer/hLJRJojr6PVNcnyMQ
 F+Y+4aVmNPSDP8nNhWqmjRnAYipx7XB63EzFM7xDul5YGcNRbRFkIVYdr06ZlJ8FV5EVR6Pc9Vd
 375jARJ6LcfMCwmnbwWQ91FZdoQW87vfqx6YT7A==
X-Google-Smtp-Source: AGHT+IHnqCVV+dhpRmVkKs+wz4J3JZHBb6FOZots0c+tn2ODTc0/G/95sijg3DjAGpNdlamersXW0tRarv8bNq2tDbk=
X-Received: by 2002:a05:6402:4402:b0:5c9:5584:ddb8 with SMTP id
 4fb4d7f45d1cf-5cea96780fbmr4878326a12.12.1730455130151; Fri, 01 Nov 2024
 02:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241031035319.731906-1-alistair.francis@wdc.com>
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Nov 2024 09:58:38 +0000
Message-ID: <CAFEAcA9UmcyHOBNcEe+7aXqO_f3cVvaLNLqTSTQFV5AvCG6F-A@mail.gmail.com>
Subject: Re: [PULL 00/50] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Thu, 31 Oct 2024 at 03:54, Alistair Francis <alistair23@gmail.com> wrote:
>
> The following changes since commit 58d49b5895f2e0b5cfe4b2901bf24f3320b74f29:
>
>   Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-10-29 14:00:43 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20241031-1
>
> for you to fetch changes up to c128d39edeff337220fc536a3e935bcba01ecb49:
>
>   target/riscv: Fix vcompress with rvv_ta_all_1s (2024-10-31 13:51:24 +1000)
>
> ----------------------------------------------------------------
> RISC-V PR for 9.2
>
> * Fix an access to VXSAT
> * Expose RV32 cpu to RV64 QEMU
> * Don't clear PLIC pending bits on IRQ lowering
> * Make PLIC zeroth priority register read-only
> * Set vtype.vill on CPU reset
> * Check and update APLIC pending when write sourcecfg
> * Avoid dropping charecters with HTIF
> * Apply FIFO backpressure to guests using SiFive UART
> * Support for control flow integrity extensions
> * Support for the IOMMU with the virt machine
> * set 'aia_mode' to default in error path
> * clarify how 'riscv-aia' default works


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

