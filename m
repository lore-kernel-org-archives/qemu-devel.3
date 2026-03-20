Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046EB108B905
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 11:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3YMb-0000sL-Gt; Fri, 20 Mar 2026 07:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3YMY-0000s7-8w
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 07:49:58 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3YMW-0001GZ-OG
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 07:49:57 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64c9ebd1369so1941616d50.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 04:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774007395; cv=none;
 d=google.com; s=arc-20240605;
 b=XIHR66cua7LDKnqRkhLJnD3qQal3nH1XszBRpRg07u3mXNhOAofJHYG7i0xhq8R7Al
 iOLI2g2++mHPlhAc3SOkgA2xD9VfxkbmWkKskcDbhFT7DBR4KvE5E7+1loOW7F2hOKz1
 lKvXc0KiM5lGyg19PA+T+FJwD6ixCkqUSS9wwSFFsaMn/06Aia+v1WxCEzjJxSgc1w1n
 wV9UdAk6J1Q5rK8vt87h88h7CYpzSCjPxQGm/ddubBuHGSZ2aIoL07k/a+0DaKa0FdwR
 ypBhtUfQKTrxrmVcTf+uPNu9r99KHV69HHwmIhUgITmU3iyMLZr+ZW27we7lVjVW8XkO
 UiHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3lRlCLGGqJ+QwgvwG4OQjSUKkCfjRpyKWS7X3iLcv64=;
 fh=VrRgAIANS83fUzBVGHginIrjoV8M5NAm1xDFXlHW/Bc=;
 b=bUteAdepSV+fg+z2uzsoITq7oOYvt7lKW72W5xJatt3lnsci6ai9nJZN2nhkX2m8ri
 EVVmXhB+rds6rql7xD2A2iJK7ZzejkeEJcyPOvyMJ4F1gOtjJYCkLuUY0GVPxDYu01Ey
 rfkTflEVTtfuDxMcqjFZoGVxqg4ut+veT82A1cfRKpBVxs+AY93BpsnrUHdPppBrqLAv
 h5/fliRCH0N+T5WjQ9v3Qm1cnLXg8AQwYx0lZjE21FOOfYJq5Ckqmh9N/FQIYozJiFyA
 Yd3QOxee1uBCCIfYYF0rv5BYpHpicrjPkkr/swHQ3FLLXlnPVccDv/25dfDSRZITInT+
 z4og==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774007395; x=1774612195; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3lRlCLGGqJ+QwgvwG4OQjSUKkCfjRpyKWS7X3iLcv64=;
 b=KD/7Cr5HrW6/Yix6wJiu7Y70q+YGO4fEslrEWl9YYKf+oSePI4vHi5qnFd+RbRO0zh
 VHz0WfJzmArK+pYcjwB5FGE8DJYaLWICU/tsLm+OVp7GUAxJ/fGb0wpzOsjUaNLj5FTH
 1q/9se7xw5mqNG6GfAGy/CVN5AfPFTnmPj1D6efK7rm+U2i//bVR5eM0HhStyxU3la2T
 RHLYP/oqN2XzD+zjNIHn4WAcTir9bRw6HuBDlE+VFlyOrHezQEB+K9evxiQan+Ex1K2Z
 nPGi3NPSq7/IgSwJ8ltbyRQfbkLk/0wKomIM851AP3Cm3nnKeiTL8S2PquClzWnSVrZZ
 Olrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774007395; x=1774612195;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3lRlCLGGqJ+QwgvwG4OQjSUKkCfjRpyKWS7X3iLcv64=;
 b=gcFjnyCEvXWvTXKQ8/B4SaykD64dk168TZbOpIgHa5YQbIeXbqpkhBknW16Gfc0DXc
 wHMqDEkaQKhH8CwoDtS3C069a71gFpaH2gHn+EmihWuM0nwZa/C3u8jdjs+CMpV2Uplw
 OpvUDBsMCSiLrxeMD28pnv6BJj+F1TmfGqAazzjiIVLSLjDQhwwqm+cuiTpSrCOVZebc
 GKC351RYmxQLZR+sDxaG2phQhWAO8KEzMGScLTohI/gubfPU9tRwlaKOqILJaA1r8wyZ
 26iRvESc1xZu5z+r1FM03T/MKG/e+0SSoGAY7iQtbHGsiEsteEB3+/xSHxaIvgQSUdDf
 VWiA==
X-Gm-Message-State: AOJu0YzjrFtI3o1WUwT1HaPRbTtROTaHrRHlxzfPX71NyTmk0JKJvwJo
 QiN43ZojzdcwUVsebW2VIy6Y9w/tFVmSHsb3kYgiZp38RChdUAWMWe0UfnHnSxbO7H6yrU+JT1M
 h+LDwuyE9e6S6N/JqKZaLBNEaIdpA0bjoC4F+Y1NKuUdH4DULUM4B
X-Gm-Gg: ATEYQzwhHNPxBTDm50i/a5eCYIJqqQdGk8cpLJeqsXGYGOyoHWxS0mSYBhxxSoC0SRL
 OQy1PJQO1LukZzFdm21eUpEe4qHfKFskxA4XHMR9sUGIiza0dDvse5HrVpJpzO3RbtGpdgKdoW9
 26wEckXcO0zZvj7vtMcCleDk836/WgJSDlZDVmvZ90uzOXISSaC/8I4TMKQ9L6xc5kKAn7pWJTI
 /f9rpSLCreNvT8wQrC4LKEZShgHdzQ3Ej8jA5SxbKObPXP01ztC3BwRl5YpN9NzPUUTiOJtD8dZ
 JR0ET/sYdrJ35l9V4nWjYu7u5h/SA6BLOBjrlcmSr2k9lNbRPLgayIH4y3NBcRDa59Q=
X-Received: by 2002:a05:690e:14c4:b0:64a:d74f:258c with SMTP id
 956f58d0204a3-64eaa6a8e4emr2732510d50.5.1774007395345; Fri, 20 Mar 2026
 04:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260319232522.1867400-1-alistair.francis@wdc.com>
In-Reply-To: <20260319232522.1867400-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2026 11:49:43 +0000
X-Gm-Features: AaiRm51Ls9WFGYiIAbw1m7joC87z_ng6MAfWf5tzZK79o96yXYeT4BWWdIdEcpk
Message-ID: <CAFEAcA9j8SWc1WBZ5_Bw25HZ-AZJ8aXYf9WG2k462i--rtSv6w@mail.gmail.com>
Subject: Re: [PULL 00/17] riscv-to-apply queue
To: alistair23@gmail.com
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Thu, 19 Mar 2026 at 23:27, <alistair23@gmail.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> The following changes since commit 5a68a3add61208aad34d47134fdcfd3f407d2ce4:
>
>   Update version for v11.0.0-rc0 release (2026-03-18 15:56:51 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20260320
>
> for you to fetch changes up to 38937473da3ebdd89bbe6bbc3effc0b153ceb414:
>
>   target/riscv: Fix scountovf CSR behavior in VS-mode and M-mode (2026-03-20 08:41:15 +1000)
>
> ----------------------------------------------------------------
> RISC-V PR for 11.
>
> * Fix integer overflow in cm_base calculation
> * Fix null pointer dereference in cpu_set_exception_base
> * Update Daniel Henrique Barboza's email
> * Add Chao Liu as reviewer
> * Set SiFive PDMA done bit upon completion
> * Remove deprecated 'riscv, delegate' device-tree property
> * Fix OCP FP8 E4M3 conversion issues
> * Fix IOMMU instance_init allocations in instance_finalize
> * Support Smpmpmt extension
> * Fix SiFive UART spurious IRQ issue and misc updates
> * Fix missing flags merge in probe_pages for cross-page accesses
> * Fix page probe issues in vext_ldff
> * Fix scountovf CSR behavior in VS-mode and M-mode
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

