Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30423C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 14:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udrca-00021e-O1; Mon, 21 Jul 2025 10:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udrcZ-00020m-J4
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 10:36:03 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udrcX-00058m-9f
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 10:36:03 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e8bcbe46cf1so4092323276.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753108559; x=1753713359; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FKMKfoNobkFKlR+DZI2fsfanMBT8kVrWK3SWFxeyOIg=;
 b=c1IotuxJ4RuK7flNn4GPcWf0HHdJK7u1vbc1ElZ1EjOyeo6ncwrVjSCKgpxg31sCZp
 l119mNoUGT0/XCymSfl55NpaIlbhYX+VRrJwu1sdYiSEmtIzGSmUtzNpYJGEeLBT14y0
 n+lWaAHzKSEePLWMsBnCR9H4u9l83i2s2nOsZE/F7KIS33KrUqTJonwxrTNYKWjcNc6i
 lQPN0YpIcjHGslNDXukeaE2qODfK4YNhEUgAJGkFg5JDbHFXfSGM0qEFSHJOgMnLFSJa
 CFX+RGm6eDbZFmpnR0G0b4Df1ZCM11CNdeIm+XeeAmik4w80nUnU37Fgdnphk4jmoPQE
 ZQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753108559; x=1753713359;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FKMKfoNobkFKlR+DZI2fsfanMBT8kVrWK3SWFxeyOIg=;
 b=G5awIZbnysfj9GHGX0j9CIK3mDMNzmT+s9mahmNHskxvkvSxr4KhVYHkOAPpcsCYbm
 uRn2xvMAeXL/UMQy6adJPJ5/tvuCAE7kfycpX6ri5k0BOLwL3nYXJEC4VFX37UhQS1wa
 V8HOJuOEUsEQjows1uk5Clmtuv4b4zAIULzpBZKVhEzCCny3HwjBEoinnkQVxLLIrh6d
 nnbgTUAaqjuUAmLKIhRDxKrCBHBNSQLV5MIxEuZ/ROgwdx8ebRSQmSyQ7547/7QLOA/A
 GIMXFcpcevVZD+QsahP+xPWefpNqI0qFPO/q/KnTg12qbg85mSJ+L8d0GEO9MkgiBPex
 qEJw==
X-Gm-Message-State: AOJu0YywJGWzLWnwx2LYGWXbWFy3DpyuGXW2x9SrJtcwu/f3pjxBgRaP
 HpLsKNcwfVP5329kv715f4gOfw7tZui4s0vo+XCFEMaa0KDo/ihZ7ybvGKoeKts4Ac89mfYNIf9
 883ZE4ZIWQKXP10U8xVu1g+0/rWxWmIqQ/NcyEZ1ZfA==
X-Gm-Gg: ASbGncvUfbQZdxUN2uNVVWUiNk1eiahjjVXgsEXcIwiNu+um2c0Kn6QbzdlKaj+96xq
 b3rIsYawG6GxdWgcKsvTJEZfBpoSxWYIx/idJArM63ZigHTQMmWYozrhnEhMG4BiY+JubF3Eg+u
 1EytdAuTCBO4j00kJnggS4UAe3gf8XkbHaivBmKe9iv7n4EKO6Zb/spefLBIrf3u2c35qxuuZjl
 G5CMdpz4QAmdWQet/0=
X-Google-Smtp-Source: AGHT+IGSCw2nk1oumQT0MZkKahHLdPKcaEWtbJ8kYwFq+yxYGmnLzRuiBdBf+L+l7Ce281ZWO4J/ULcvKBeMvu+fAmA=
X-Received: by 2002:a05:690c:25c5:b0:712:c295:d013 with SMTP id
 00721157ae682-718375459d4mr271282337b3.34.1753108559046; Mon, 21 Jul 2025
 07:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAEWVDmuS0RSwZiDGNZg4cT1jXp7Xfu97YZL7hDfTvha2TOgS1g@mail.gmail.com>
In-Reply-To: <CAEWVDmuS0RSwZiDGNZg4cT1jXp7Xfu97YZL7hDfTvha2TOgS1g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jul 2025 15:35:47 +0100
X-Gm-Features: Ac12FXwjq3osECUnJ_Y3R6ut9F-kEzWjAtYknz7BUCApMaFgk0-ZfTa7dpPhEH4
Message-ID: <CAFEAcA9u2N2GsWZ+eFuqezqCPj9hWGT=qGnwjjG3M5NYO9Jb5A@mail.gmail.com>
Subject: Re: [RFC] target/arm: Concerns about mixed endian support for remote
 GDB
To: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Fri, 18 Jul 2025 at 20:20, Vacha Bhavsar
<vacha.bhavsar@oss.qualcomm.com> wrote:
>
> Upon examining the current implementation for getting/setting SIMD
> and SVE registers via remote GDB, there is a concern about mixed
> endian support.

Yes, we discussed this on a different thread.

> The current implementation for the SIMD functionality for getting and setting
> registers via the gdbstub is implemented as follows:
>
> aarch64_gdb_set_fpu_reg:
> <omitted code>
> uint64_t *q = aa64_vfp_qreg(env, reg);
> q[0] = ldq_le_p(buf);
> q[1] = ldq_le_p(buf + 8);
> return 16;
> <omitted code>
>
> The following code is a suggested fix for the current implementation that
> should allow for mixed endian support for getting/setting SIMD registers
> via the remote GDB protocol.
>
> aarch64_gdb_set_fpu_reg:
> <omitted code>
> // case 0...31

It would be easier to review your proposed changes if you'd
sent them in a proper patch format...

> uint64_t *q = aa64_vfp_qreg(env, reg);
> if (target_big_endian()){

What config are you using to test this "target big endian"
code path? On system emulation target/arm is *always*
target_big_endian() == false (even if CPSR.E is set).
The QEMU "target endianness" is a compile-time property of the
system, not a runtime property of the CPU. CPSR.E just causes us to
byteswap values as they go out from the CPU to the memory subsystem.

I think for the user mode emulator aarch64_be-linux-user
we may have target_big_endian() true, but I forget. BE
linux-user is pretty unmaintained...

> q[1] = ldq_p(buf);
>         q[0] = ldq_p(buf + 8);
> }
> else{
> q[0] = ldq_p(buf);
>         q[1] = ldq_p(buf);

(You're loading q[0] and q[1] from the same buffer address here.)

> }> return 16;
> <omitted code>
>
> This use of ldq_p rather than ldq_le_p (which the current implementation
> uses) to load bytes into host endian struct is inspired by the current
> implementation for getting/setting general purpose registers via remote
> GDB (which works appropriately regardless of target endianness), as well
> as the current implementation for getting/setting gprs via GDB with ppc
> as a target (refer to ppc_cpu_gdb_write_register() for example).

Note that for PPC, we build both ppc64-softmmu and ppc64le-softmmu configs,
so for PPC target_endianness() really can be either LE or BE even
in system emulation mode.

> For SVE, the current implementation is as follows for the zregs:
>
> aarch64_gdb_set_sve_reg:
> <omitted code>
> // case 0...31
> int vq, len = 0;
> uint64_t *p = (uint64_t *) buf;
> for (vq = 0; vq < cpu->sve_max_vq; vq++) {
> env->vfp.zregs[reg].d[vq * 2 + 1] = *p++;
>         env->vfp.zregs[reg].d[vq * 2] = *p++;
>         len += 16;
> }

This code definitely is wrong, because the gdbstub protocol buffer
is target-endianness and the env->vfp.zregs values are host-endianness.

thanks
-- PMM

