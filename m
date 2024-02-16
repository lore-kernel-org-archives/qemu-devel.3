Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A063C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 10:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ravw0-0004ch-Om; Fri, 16 Feb 2024 05:59:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ravvz-0004cD-42
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 05:59:11 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ravvw-0008QE-VL
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 05:59:10 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-563f675be29so419052a12.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 02:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708081146; x=1708685946; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nwrTLl9Rhe9S8NFQhj+umjI1WgFRS9rGA/2Oq2GfJAc=;
 b=QTxVsiqeLPf1yNSsd/RP09UcIk+uG/tMI60SP30V+RgeSoArkV+wQjGSaYnFTqKgTY
 JtNEo4xQ4IYoVAvX303ZRMQFmrnQbxGnFFNheOK6Mvh6LcK+XN9qrvz9/tIrNhpkXxAd
 VrU8cWGB2lPpaLM4djlHXCbFhGrqfccfGrctuwGQozGe2WQFqXhBsF06lJnGv5bKRr/0
 PlF1u62DXuelhIvcnFdRwMHSEErrruskoM59VxfejdC/ueJHA5BNImPZdRQ70uGRW39c
 k5CC+J5GI3smX3Ptp/UifwIEHdXx8XVyvf5eoBZU0WNsdUtGoaV1xzDc4Hok3j1vEwVF
 r8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708081146; x=1708685946;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nwrTLl9Rhe9S8NFQhj+umjI1WgFRS9rGA/2Oq2GfJAc=;
 b=bo6/0VAdB0v2qgXrfk3WnmX45WscEpXhjaKhrDfSQZkjks40UsQcX1vPcFZ5q80NVF
 g+3daPe3c8aKIgcNl3VllzeMxCP7rgtSwUdQ9xAUc0noKZtPfSwnWtylRYD7pve7Xsxw
 o/yECkIB1LC3KB6NDUiokWeWVhkDt5utNFttWvtIdDQClXKVJGgKX3QUJzAqPm8nAKGW
 f+FHU3764MepqVMS+WOX/8tk7yTBu2LLKGVHAPmsjyf+0SHOjQA7RVtJoAtyDxHr2lEK
 HcxfpSVZy/FpdtylrdJwkCw7gzLPuZ0AsAj1ChEj3Fgf2kWkI77l9wmNkZrq6vK4BFB/
 57/g==
X-Gm-Message-State: AOJu0YzL5bQ3ZMVDdIEFutTbus7Jfswqkc3z+yai6cWgL5G05uTopDPk
 5CXFZIxWcV4eGBUXg9gGehV+Q/IJCPzARF+PVfCa4nczJLxyQPt69UnnFh+vfL/M63XvFuCk6YJ
 p3SXRgmRAdWjDsfWCpt7YIxpF9w+lGJW1fMj+yZInLukhFfTg
X-Google-Smtp-Source: AGHT+IHYjBQfxpQoocbbYeLOWG5AWlXc8h0B28v27+VYiFhTS9w56/LMmYeA+6Xa9PQGEFjmOvqJZYZ9yZ1ly/XEWjo=
X-Received: by 2002:a05:6402:38a:b0:563:dd8f:996d with SMTP id
 o10-20020a056402038a00b00563dd8f996dmr1538626edv.9.1708081145706; Fri, 16 Feb
 2024 02:59:05 -0800 (PST)
MIME-Version: 1.0
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Feb 2024 10:58:54 +0000
Message-ID: <CAFEAcA8CCAh4hcG7dhnK8etjXJf2jkjUyqvnKMXuGoxRHgVKVA@mail.gmail.com>
Subject: Re: [PULL 00/35] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 15 Feb 2024 at 17:35, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The following changes since commit 5767815218efd3cbfd409505ed824d5f356044ae:
>
>   Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2024-02-14 15:45:52 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240215
>
> for you to fetch changes up to f780e63fe731b058fe52d43653600d8729a1b5f2:
>
>   docs: Add documentation for the mps3-an536 board (2024-02-15 14:32:39 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * hw/arm/xilinx_zynq: Wire FIQ between CPU <> GIC
>  * linux-user/aarch64: Choose SYNC as the preferred MTE mode
>  * Fix some errors in SVE/SME handling of MTE tags
>  * hw/pci-host/raven.c: Mark raven_io_ops as implementing unaligned accesses
>  * hw/block/tc58128: Don't emit deprecation warning under qtest
>  * tests/qtest: Fix handling of npcm7xx and GMAC tests
>  * hw/arm/virt: Wire up non-secure EL2 virtual timer IRQ
>  * tests/qtest/npcm7xx_emc-test: Connect all NICs to a backend
>  * Don't assert on vmload/vmsave of M-profile CPUs
>  * hw/arm/smmuv3: add support for stage 1 access fault
>  * hw/arm/stellaris: QOM cleanups
>  * Use new CBAR encoding for all v8 CPUs, not all aarch64 CPUs
>  * Improve Cortex_R52 IMPDEF sysreg modelling
>  * Allow access to SPSR_hyp from hyp mode
>  * New board model mps3-an536 (Cortex-R52)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

