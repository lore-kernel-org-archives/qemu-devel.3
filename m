Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222D7D41177
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLkc-0001jT-9D; Thu, 15 Jan 2026 06:42:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vgLkX-0001gl-Rt
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:42:49 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vgLkW-0007pK-1P
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:42:49 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so4934075e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 03:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768477366; x=1769082166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NN+nTi3z6PsBK3uMRjzL/HTd/b5De+UW+l7/dnIMMzQ=;
 b=uwM0TS9mfLm/RLnR8oaiEHxKHf5c3/26QLKXxRnbn4cU2wOjQxICmpBsXKT0vdryUl
 ZSLUYf91gijL1PoJEWpSe21K5h1A+rAkBitHSGY9+VuUkCJU7N4WgSN527qUmkXT1LNY
 nWkMnlbtTKK2nfOVQgdoj67+1AqpS354IQgkvsUNjlk8nCSnTPLtVk17EgbyiwlJ1ZY9
 ZrHz8AOXLQqc3xzfYv/rc27DTcxCOPUmGaALatWHtrF4XuIgiW9LGQgWlMB2BhwQcSgW
 7a+OjCDmty2aUn1nbxCMz28UIDl/GCTFpVOxzWUCuGF1jCHA4+ErdIeyJ9BuitCvpD1L
 nA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768477366; x=1769082166;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NN+nTi3z6PsBK3uMRjzL/HTd/b5De+UW+l7/dnIMMzQ=;
 b=QAmlH39gfYfKQEA9Gk2KbijGMgddevWB+XspQRqnbTp/b51hMDwt0dtMtNlTQUeG57
 255HJ9lIwtTfZOp1BqNykd1y3ZB4iGbNOIng58KlHbwIbz7CDC2Tk6+SEuBkrqM7oMlT
 uR2b6xG+y3KrHjFdtqftKfVOVvd7hY6Vg8BzbT3qjjqCjz/g4jGVhLYfbb1peGAbQbqR
 sHGNLkBwJI9Yt9R/6oE0+0BBoKYL6Hx+1G110AxiUmIw7bB3kvjvpfpRQgeq4kAEVMkL
 rrelwCSB2EuSfrrAjpEpUnNyup/XjD7ZlaX7xA+kHjexWl+uPD3k/5fV+EEct0s9jmKv
 /y5w==
X-Gm-Message-State: AOJu0YxUWqdzvid170PQbNh/fMAECvoEmTP5z3F3CPKE6aZbo7gte7Ea
 y0jr9GZ96F0fPmnZuNMjsGtJZHh85ODTjh888pQyPzwdQ16dCH/XVZU34E0ZxRiItyU=
X-Gm-Gg: AY/fxX4eHSSvZ02c00sTLQYFbzi9lpeooxSYuW3qZmR1HLh96BFDOh8Ngrg3GcIZaqX
 puemZHhCt7zgHGMaF1I0kh2Ug7SeDHORJr4mzLSL2FQDR/jBB9H2KReFYhMrNxptRG84x1bjFDw
 5kY/0JBps/tuSF5BlIhNqTXmvknX5+W/D/WAbJ8po+MKKycbNmUGViaHyUXA2Y2K2TREBQxfjmn
 DETe7wcZh60AI6KUzE85rA4xCnjfyjrvTpkrDfKLHrq+LzyQUIP77hKFro2MS98Oq4QCgwqvrvq
 nZ6Ndm7clxHC1/Jkyj1oTGwp/rOQpYzKNgg6Ks1GzC16vF8J/m+xWjDnhZ9wi1PIbRCGmRIifaF
 KaGs6ppTb/F5Or4a+lu/w6N0rAGuykDNiG+5dUWob1pSPqJUyVpn/VDx+l64YoK7dHp1nrHcZEi
 UlpSlugA9QpNg=
X-Received: by 2002:a05:600c:46cc:b0:47e:df86:e83d with SMTP id
 5b1f17b1804b1-47ee337a086mr72627855e9.31.1768477365832; 
 Thu, 15 Jan 2026 03:42:45 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428cb5f4sm43093315e9.10.2026.01.15.03.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 03:42:45 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6EABD5F7DD;
 Thu, 15 Jan 2026 11:42:44 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Corvin =?utf-8?Q?K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org,  "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Alistair Francis
 <alistair@alistair23.me>,  qemu-arm@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,  Corvin =?utf-8?Q?K=C3=B6hne?=
 <c.koehne@beckhoff.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Yannick =?utf-8?Q?Vo=C3=9Fen?=
 <y.vossen@beckhoff.com>
Subject: Re: [PATCH v5 00/15] hw/arm: add Beckhoff CX7200 board
In-Reply-To: <20251204093502.50582-1-corvin.koehne@gmail.com> ("Corvin
 =?utf-8?Q?K=C3=B6hne=22's?= message of "Thu, 4 Dec 2025 10:34:47 +0100")
References: <20251204093502.50582-1-corvin.koehne@gmail.com>
User-Agent: mu4e 1.12.15-pre1; emacs 30.1
Date: Thu, 15 Jan 2026 11:42:44 +0000
Message-ID: <87wm1jhzkb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Corvin K=C3=B6hne <corvin.koehne@gmail.com> writes:

> From: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
>
> Hi,
>
> Beckhoff has build a board, called CX7200, based on the Xilinx Zynq A9
> platform. This commit series adds the Beckhoff CX7200 as new board varian=
t to
> QEMU.
>
> The emulation is able to successfully boot an CX7200 image. The image inc=
ludes
> some self tests executed on every boot. Only the cache self test fails du=
e to
> QEMU emulating the cache as always being coherent. The self tests include=
 f.e.:
>
> * Network
> * Flash
> * CCAT DMA + EEPROM [1]
> * TwinCAT (Beckhoff's automation control software [2])
>
> [1] https://github.com/beckhoff/ccat
> [2] https://www.beckhoff.com/en-us/products/automation/

Is it possible to host a binary build somewhere so there can be a
functional test?

>
> YannickV (15):
>   hw/timer: Make frequency configurable
>   hw/timer: Make PERIPHCLK divider configurable
>   hw/dma/zynq-devcfg: Handle bitstream loading via DMA to 0xffffffff
>   hw/arm/zynq-devcfg: Prevent unintended unlock during initialization
>   hw/dma/zynq: Ensure PCFG_DONE bit remains set to indicate PL is in
>     user mode
>   hw/dma/zynq-devcfg: Simulate dummy PL reset
>   hw/dma/zynq-devcfg: Indicate power-up status of PL
>   hw/misc: Add dummy ZYNQ DDR controller
>   hw/misc/zynq_slcr: Add logic for DCI configuration
>   hw/misc: Add Beckhoff CCAT device
>   hw/block/m25p80: Add HAS_SR_TB flag for is25lp016d
>   hw/arm/xilinx_zynq: Split xilinx_zynq into header and implementation
>     files
>   hw/arm/xilinx_zynq: Add flash-type property
>   hw/arm: Add new machine based on xilinx-zynq-a9 for Beckhoff CX7200
>   docs/system/arm: Add support for Beckhoff CX7200
>
>  docs/system/arm/beckhoff-cx7200.rst |  57 ++++
>  docs/system/target-arm.rst          |   1 +
>  hw/arm/Kconfig                      |   7 +
>  hw/arm/beckhoff_CX7200.c            | 104 +++++++
>  hw/arm/meson.build                  |   1 +
>  hw/arm/xilinx_zynq.c                |  54 ++--
>  hw/block/m25p80.c                   |   3 +-
>  hw/dma/xlnx-zynq-devcfg.c           |  27 +-
>  hw/misc/Kconfig                     |   6 +
>  hw/misc/beckhoff_ccat.c             | 339 +++++++++++++++++++++++
>  hw/misc/meson.build                 |   2 +
>  hw/misc/xlnx-zynq-ddrc.c            | 413 ++++++++++++++++++++++++++++
>  hw/misc/zynq_slcr.c                 |  31 +++
>  hw/timer/a9gtimer.c                 |  26 +-
>  hw/timer/arm_mptimer.c              |  32 ++-
>  include/hw/arm/xilinx_zynq.h        |  37 +++
>  include/hw/misc/xlnx-zynq-ddrc.h    | 148 ++++++++++
>  include/hw/timer/a9gtimer.h         |   2 +
>  include/hw/timer/arm_mptimer.h      |   4 +
>  19 files changed, 1263 insertions(+), 31 deletions(-)
>  create mode 100644 docs/system/arm/beckhoff-cx7200.rst
>  create mode 100644 hw/arm/beckhoff_CX7200.c
>  create mode 100644 hw/misc/beckhoff_ccat.c
>  create mode 100644 hw/misc/xlnx-zynq-ddrc.c
>  create mode 100644 include/hw/arm/xilinx_zynq.h
>  create mode 100644 include/hw/misc/xlnx-zynq-ddrc.h

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

