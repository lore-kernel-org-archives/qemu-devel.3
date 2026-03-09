Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8063F3C242
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 12:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzZVz-0006R1-F0; Mon, 09 Mar 2026 08:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzZVs-0006QP-PL
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:15:10 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzZVq-0007h0-2z
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:15:07 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64ca1ba0089so10505545d50.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 05:15:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773058505; cv=none;
 d=google.com; s=arc-20240605;
 b=ULi+cnu7sBoTgXuYcuM86E3TPhy7Hn0XOoIrBjIHfe2GbJIU1dcR0Un/462/dkCDd+
 w6je5F78ONJXQmK3hmfJ/C17Tcs4f7yzjNvLBDzk7F0Wh5pYzclrauRt7y2tGnX4xXGR
 4G4ZD84sdt/a2h9zyD55yrGbMbzdn+Ye+Pw6UdL3uKGv24hJGF1hxjR/qNdZtN+hvFnw
 SLTT7U/rA8zVTZA6d0/pu684gPP+mNPRl7Y/YiDlGKcjFOXw644IvDg+Bo0YkvPJSfYZ
 O2kbxEiZgZFFQQ8oM5aH8Y2RQHPZcpC8+u5atF8qS7JftD0ut3aM1UOCrpF/XY99sUcE
 FWxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FT3bMKAfKYX5wJya+RpLJyA30xxPqNTFZD5++m6u/z8=;
 fh=zpiKzW8LH3ELwKzluQ3AheUCgrr23INy4hQ6ZjBUBr4=;
 b=H2e7pSRNGjfFf3kZ/7orW8ghkKTeqfLBjw1Z4Sa1iQu+Aw3NVOhuAPtBRYVK7gEycE
 Na0MoEreKwE22SRUSRCuDdmveKhSUeP0pRzDNwo1IM4P2tlW4dPfPSAzq/DZ0C9QZoa+
 PmoxqaGXT/geXYuX/hXowQ0zkiEEk+8O9NmEldn5yDR4rlOGp3hkTNyl+u0HHHxy0xyy
 /ksx3PoRJIOvjkMpWRSIuVedovmKB/icvBckHmPhRnXKOm2JfRf1VLHwUkM1KUKjlxqA
 KVa+YZlpoQYZJO/16Cbs1dgd5PRVWCbej7fCamfI5PAbd9onmBVmGP3IpP92hX7Tqxy1
 nFnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773058505; x=1773663305; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FT3bMKAfKYX5wJya+RpLJyA30xxPqNTFZD5++m6u/z8=;
 b=b//E1+9F8lCRXcjBuhFt2jWAMSj3DBw9KslBNESLBaMEYyKB0ITtC0nheIrYy5Y1NQ
 5GSiXChRnyqtBx1k2hBtIbNxxST5hepYiiygGDCVSSsQR+k6UM6CxGjM5A0iBQHtaE3I
 Pa+qlJhPKa7jYhCWwETs9k37Bk1TkKYn1d+GyuqitreSMHgqq/xthQ4TEGNO+jdyp5PD
 ssm0tucSeZRztmIc/JmufdsrAHZ2MupUkLOgb0mBHJX/WyGT02smnC3z0ZuxtYC0UU7/
 yOysiAXMW5t/Nv5zHFHOpZzAdV2wJDFx6A31NP+ILwefMbfgqfmO5I++qe2hxclhxes1
 cneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773058505; x=1773663305;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FT3bMKAfKYX5wJya+RpLJyA30xxPqNTFZD5++m6u/z8=;
 b=jLo4o1uiWF7lthOAb0cMXSUoVthBgl2vZxVpl42m8eK8mOHRLf3pxxIjS/HOo+LGxB
 nf/DbswoPhxdU2Xjh8DVxOyZoiBd2wHTsJp0pv/i3ZUEnGTAeG+pLPJd0vHsqyB8DjzW
 OzgauEX+yMqHsjnvWhW6IistWf21LEm7mUk6Lp8dTHbieYEQaK0C4LyOxeuiOaCSrP8K
 2/ktFfYiQU9wTQyw/9vb/inw9QS+Hvdg51DUyIWgM6KIOtjUtgEej5wyhO37czlbYOcr
 /JBCqcEQBkEH3BMM8pgEelmpxL4LLsinP5+gymTcNlsYThe/ertoxFyp39noPxJ3yCRy
 ubcw==
X-Gm-Message-State: AOJu0YwQCe/7mOvmc3WaoeIrXDcDDlJ9WlSKAPUCFZZo98DaYjACElXE
 ZzkmlTH/RRseHsW27Cl5+xhohcGeorvCDVboRglxwZnFQ0TMv7Gr/s5UKARnCU7YVpTYQqKJZ7X
 lpZRT7M8+kSVT8MDRAx8FgSfCHbN6Ap/eC6gRty1O/VZFDonBnfzE
X-Gm-Gg: ATEYQzy+Xbyl1+beSRLgC5ifgwsoJSszMVMznkF3N8avUT53KbelE8ms8GZFh8NnLd8
 xpmqM16J4AFYQi4z07LlxblYDQSTy7tb4WywnAozjMl4b69CJJ+f6gwwPp+sczMbrFi8tJfVjoi
 hhrNDAluLS3X0CZy9Lyp2S7SsVT9+gYp4EEldrIK+e/dXyWr1oZz0XuGTHm8XFrSY1XBfgrVxPn
 eFtKVQdaLnijbiSZ0i0NG6bA1lhlIlE8/QZx9JOy7aI/wuvODtzsgFhX+Uqf15QYYsvRRq/eUAG
 tSpGGXn0Vfex1t+V6VxEhNOLVXJoc0G8eEN+ncOsDVirmw7OMn+6q1LyGx77WHdtKPY=
X-Received: by 2002:a53:b186:0:b0:64c:cfae:a9fa with SMTP id
 956f58d0204a3-64d14304a58mr7300945d50.62.1773058504701; Mon, 09 Mar 2026
 05:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260308223433.25503-1-philmd@linaro.org>
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 12:14:52 +0000
X-Gm-Features: AaiRm52DJCxCGxdhZBnIsao7qIsPGAwA8udVoDaBNrsLkjGA_cP6JE4u6Xj8_dg
Message-ID: <CAFEAcA9+87WY59=v0N1wkUANZy-B1unEhjjS7Z2bbr5p8Q5QZQ@mail.gmail.com>
Subject: Re: [PULL 00/49] Misc HW patches for 2026-03-08
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, 8 Mar 2026 at 22:35, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> The following changes since commit 1ae4271ab8dbfbf5dc28b36baa7f3fd5fd2215=
e1:
>
>   Merge tag 'pull-11.0-virtio-gpu-updates-060326-1' of https://gitlab.com=
/stsquad/qemu into staging (2026-03-07 11:22:16 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20260308
>
> for you to fetch changes up to 27c64fa59d1b14c4656908e1dfca49482a96df61:
>
>   hw/char: Drop disable property of Diva GSP card (2026-03-08 23:11:14 +0=
100)
>
> Following checkpatch errors ignored (first spurious, other ones pre-exist=
ing):
>
> ERROR: "foo * bar" should be "foo *bar"
> #40: FILE: hw/display/ati_2d.c:60:
> +                                                    + dst_y * surface_st=
ride(ds),
>
> ERROR: switch and case should be at the same indent
> #27: FILE: hw/net/xilinx_axienet.c:143:
>      switch (regnum) {
> +        case 2:
> +        case 3:
>
> ERROR: braces {} are necessary for all arms of this statement
> #43: FILE: hw/char/serial.c:164:
> +        if (s->lcr & UART_LCR_EPS)
> [...]
>          else
> [...]
>
> ----------------------------------------------------------------
> Misc HW patches
>
> - Remove versioned machines released in QEMU 3.0
> - Build various stubs and ACPI objects once
> - Pair of bug fixes in ATI VGA model
> - Cleanups in 16550A UART model
> - Clarify PA-RISC CPU models (adding the PA-8500)
> - Various memory leaks / overflows fixed
> - MAINTAINERS updates
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

