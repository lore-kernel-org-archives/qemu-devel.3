Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C41CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 13:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruYEX-0008RH-99; Wed, 10 Apr 2024 09:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruYEN-0008Nt-8j
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 09:43:17 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruYEL-0002Ro-Ju
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 09:43:14 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a51f9ad7684so116653266b.2
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 06:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712756588; x=1713361388; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DnxyDTR4kmo/baA+YoznkeHdPKwF1AjfD/5h5u8oovg=;
 b=MCQVOASnaRmxh0q9lpIPkqT2KY5K5rypFX0uNCTffT8+TzOQJqaj+GInCUfLEYTtXV
 lcBfJN7TMWgZ3/xj91ftsIb34lESZdwHOzK/H9GdPT7tBYBffXUxCJRfhpe7ZTFEV6QJ
 pIIAopIDjjcTzJADc+uD1Y7dkHMgvYkRqhrZTxcACphmumpZyS5HVMUWyFr+s4qgJYfC
 iLcKpBm3hc4dflCDTMg7LXsC81E34mJBbDDUQRUAjp7HUp7Sq5Hju5A8qtiLDjIbDkPa
 j+iHvwNCnkSgBBJAuGykjVa7TKm7fRH/7PtU4fTLtT3cqyO4ymvg6eJ0wxBQXgCmYYe2
 TFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712756588; x=1713361388;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DnxyDTR4kmo/baA+YoznkeHdPKwF1AjfD/5h5u8oovg=;
 b=eXrhVDTr96dUi1C7nY94A0ApY5y5lk7eNKILKb1s9y+UIvyMCsMWiznbenWEYHBWyI
 yyrG94i51Ymz6MSJm+zZXstFiWzUuHJnsNDrGIMgZo88pyvW9QUVd3/BsbvYY2mGVlcU
 ttJpbHmKMmIcLvyfMQ/hlwGZiSEe0Xz1pzBEpaAlxBIjlTGS+V48M2R8+j3AxL6b2lbx
 My1K70sBiPEoY7OgVcCiS6kq4zZm2ZX4nu9SHt8uz3s0x5coNOqEBhqZnJTq245/lH75
 rM1CbOkOvGHIaXfGP3u5j/ZcWQ2HouTN6rm/8gWkgOz/BK15XP+hi04HdZ+JK+na9Qqp
 PnUQ==
X-Gm-Message-State: AOJu0Yzn4Cn7Z78v8nptH/owtj1/y7CSgQT6C/nUzwR/aym6Bigb+z4k
 15aMCmO5xTQqVZFSLT3vicI1CTEIXWwTpSbS9C4WiUdgGlRgDaYShz/8QqeNjhIf6YeSGQrKtt5
 CVDtmJ/bBrUulSssSpgze65NxuTOedfD+rn6XijtTs6NbuGIG
X-Google-Smtp-Source: AGHT+IF8EV9jXeIncg0dEt2WCkVebisgGPTHDoNJK6Gb7wuO2dDNU5FAZeNqdehj6nn5Q2ckIauzQGj8mNM0MYwW8qA=
X-Received: by 2002:a50:9f65:0:b0:568:d7fe:a768 with SMTP id
 b92-20020a509f65000000b00568d7fea768mr2150766edf.25.1712756587626; Wed, 10
 Apr 2024 06:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240409193603.1703216-1-richard.henderson@linaro.org>
In-Reply-To: <20240409193603.1703216-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Apr 2024 14:42:56 +0100
Message-ID: <CAFEAcA-7DU1QmPVUq50khzdv2hvbikEhpLcFoCQ4RCCaveQy0Q@mail.gmail.com>
Subject: Re: [PULL v2 00/20] misc patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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

On Tue, 9 Apr 2024 at 20:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Defer 16 patches to 9.1; add fix for -strace.
>
> r~
>
>
> The following changes since commit bc0cd4ae881dff47e81581a8fea93a50b1d1dbe7:
>
>   Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2024-04-09 09:51:07 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-misc-20240409
>
> for you to fetch changes up to 143bcc1d59f174b6c6743bd4ca8f99415ed1aba2:
>
>   linux-user: Preserve unswapped siginfo_t for strace (2024-04-09 07:47:11 -1000)
>
> ----------------------------------------------------------------
> target/m68k: Fix fp accrued exception reporting
> target/hppa: Fix IIAOQ, IIASQ for pa2.0
> target/sh4: Fixes to mac.l and mac.w saturation
> target/sh4: Fixes to illegal delay slot reporting
> linux-user: Fix waitid return of siginfo_t and rusage
> linux-user: Preserve unswapped siginfo_t for strace
> tcg/optimize: Do not attempt to constant fold neg_vec
> accel/tcg: Improve can_do_io management, mmio bug fix
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

