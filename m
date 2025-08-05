Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F57C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 16:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujKzM-0003Wt-7Y; Tue, 05 Aug 2025 12:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujKzK-0003VO-P3
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 12:58:10 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujKzJ-0003mM-2U
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 12:58:10 -0400
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4fd6c638f20so1821485137.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 09:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754413087; x=1755017887; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NkLF256/k/JGYweK3pK3K1cwo00E5cuWulYA3pVhOp0=;
 b=vMqj2nrD2Mxu8ZrpwmsJvGxt++CIukprHMHjQleWSjd/IQw8SMqiUanKxIK8XNm/D9
 /wTe96ubmCWUpSyfVeaSpgqho7AGFvoXhHA10H8nxpKK59mQQ95jX9hpzu3ObwfkwnNG
 FxOSuRaqnTKT+oxAZc813jifFadov8ztTOAPiVcmAbfd45xTa7GYhRxyFPFWWjdU+4K0
 KVT4jDGFYcKCuwVGZvhE6wK217ii2tNr2BU3c4exLPgkMBKeM8CWwt3/fUCwrfcLXQc9
 SXFxC/c8I3HykUCVd47xAqLg1sWPM5z/PHPgZtiHFxDIm5PDjCkLH2SPJ1FMHF5CbKdf
 xzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754413087; x=1755017887;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NkLF256/k/JGYweK3pK3K1cwo00E5cuWulYA3pVhOp0=;
 b=SoXnKGGAvoW0/aZpsL7IiQsuafJ/UY0k7/GtSvbm6cgNZL6vm/2HjDarn4qiHmP3/8
 hCYVbCi09UCZEm1jw8yrcoJmJf2Npf6eN7Mrd7FTKo+FLTTfSgtG0q0iFILy5QS+GsJF
 r539eWU2LijASjB6XxrhFmrAiSmZ2AK2UmQTlGJllhW+f9D4pwD7IQcL+fe5s2G/zXX+
 XwaVAhZuUkYyp7r8WntunzwAMRx/bngzHT6arT1xY1oR3aXBhbxTwMVo09PD50oLLuuZ
 EJFYVdJE2w4dqVh9Qhbjd0ThcvsVHNT4K7+v236TKIMuhxUOSqNkhRAus1pnQA3IrDEL
 npbw==
X-Gm-Message-State: AOJu0Yx1MsqmNJOgljtYbtAboJs0cRpyTRsA3ovSlZR85QvENlFHLokx
 tUhhIlCJw8y1BkvyFbxxhGsWJxl+bOx103ccHB0vhYfOt6t73xpwSKxz/kzAE/QRJT/TGf4B5GR
 VdRX7v+x305eWMyAHNyk0wzs4v6hPFk3kf+vJXiTKcw==
X-Gm-Gg: ASbGncuIzaEwyA8eLyOv1nKJXl4yRmk/G+rWKTw/EYYB6vk86cOjsNPjFmrBDPCFPBK
 5Q9G0cuCS7oFn5m71vGYHo8r8idjZxOz7dH/IUAtfen/zQRJOTr+N2TjpJunuZ4WnVk/RVMBwjs
 NOJDrL6Da32rheOS7d78zt2QHZrdrt2drxhepRdiApoyxIbnHPe4D2+xCr0+uzTRaSJ1/0USG6+
 5qBmXWtkuK78FCLNz4=
X-Google-Smtp-Source: AGHT+IGRx+fxTQwqSHCioYzOcoO3MYSy8/aK2dD5+Ft/K/ljzf6foehudMZnwDC/HPJU0RLUBPy7xR6Dp8ZPktLwsRY=
X-Received: by 2002:a05:6102:dcb:b0:4e2:ecd8:a27 with SMTP id
 ada2fe7eead31-4fdc1c4aef8mr5248840137.4.1754413086853; Tue, 05 Aug 2025
 09:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250805-backtrace-v1-1-d189d09b1e92@linaro.org>
 <aJIqdQSYXO4K6lCJ@redhat.com>
 <CAAjaMXY1ytnhp+APdwM39-K=Mu=5p8W=MEUVvLers3M=rLS6Qw@mail.gmail.com>
 <aJI18an38eBkVL-Q@redhat.com>
In-Reply-To: <aJI18an38eBkVL-Q@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 5 Aug 2025 19:57:38 +0300
X-Gm-Features: Ac12FXw7_3_E86JrEm-WCbf1Nr4ibme7D5D0Bw2CsB4Cu55IM1naEpWIb83CA4Y
Message-ID: <CAAjaMXZhFM7keE1abmhQqehsZn7LaJXwYvUAuOvd-MdNTYtw1Q@mail.gmail.com>
Subject: Re: [PATCH RFC] util/error.c: Print backtrace on error
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-vs1-xe31.google.com
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

On Tue, Aug 5, 2025 at 7:49=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Tue, Aug 05, 2025 at 07:22:14PM +0300, Manos Pitsidianakis wrote:
> > On Tue, Aug 5, 2025 at 7:00=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com> wrote:
> > >
> > > On Tue, Aug 05, 2025 at 12:19:26PM +0300, Manos Pitsidianakis wrote:
> > > > Add a backtrace_on_error meson feature (enabled with
> > > > --enable-backtrace-on-error) that compiles system binaries with
> > > > -rdynamic option and prints a function backtrace on error to stderr=
.
> > > >
> > > > Example output by adding an unconditional error_setg on error_abort=
 in hw/arm/boot.c:
> > > >
> > > >   ./qemu-system-aarch64(+0x13b4a2c) [0x55d015406a2c]
> > > >   ./qemu-system-aarch64(+0x13b4abd) [0x55d015406abd]
> > > >   ./qemu-system-aarch64(+0x13b4d49) [0x55d015406d49]
> > > >   ./qemu-system-aarch64(error_setg_internal+0xe7) [0x55d015406f62]
> > > >   ./qemu-system-aarch64(arm_load_dtb+0xbf) [0x55d014d7686f]
> > > >   ./qemu-system-aarch64(+0xd2f1d8) [0x55d014d811d8]
> > > >   ./qemu-system-aarch64(notifier_list_notify+0x44) [0x55d01540a282]
> > > >   ./qemu-system-aarch64(qdev_machine_creation_done+0xa0) [0x55d0147=
6ae17]
> > > >   ./qemu-system-aarch64(+0xaa691e) [0x55d014af891e]
> > > >   ./qemu-system-aarch64(qmp_x_exit_preconfig+0x72) [0x55d014af8a5d]
> > > >   ./qemu-system-aarch64(qemu_init+0x2a89) [0x55d014afb657]
> > > >   ./qemu-system-aarch64(main+0x2f) [0x55d01521e836]
> > > >   /lib/x86_64-linux-gnu/libc.so.6(+0x29ca8) [0x7f3033d67ca8]
> > > >   /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x85) [0x7f3033=
d67d65]
> > > >   ./qemu-system-aarch64(_start+0x21) [0x55d0146814f1]
> > > >
> > > >   Unexpected error in arm_load_dtb() at ../hw/arm/boot.c:529:
> > >
> > > From an end-user POV, IMHO the error messages need to be good enough
> > > that such backtraces aren't needed to understand the problem. For
> > > developers, GDB can give much better backtraces (file+line numbers,
> > > plus parameters plus local variables) in the ideally rare cases that
> > > the error message alone has insufficient info. So I'm not really
> > > convinced that programs (in general, not just QEMU) should try to
> > > create backtraces themselves.
> >
> > I don't think there's value in replacing gdb debugging with this, I
> > agree. I think it has value for "fire and forget" uses, when errors
> > happen unexpectedly and are hard to replicate and you only end up with
> > log entries and no easy way to debug it.
>
> If the log entry with the error message is useless for devs, then it
> is even worse for end users... who will be copying that message into
> bug reports anyway. This patch doesn't feel like something we could
> enable in formal builds in the distro, so we still need better error
> reporting without it, such that user bug reports are actionable.
>
> Was there a specific place where you found things hard to debug
> from the error message alone ?  I'm sure we have plenty of examples
> of errors that can be improved, but wondering if there are some
> general patterns we're doing badly that would be a good win
> to improve ?

Some months ago I was debugging a MemoryRegion use-after-free and used
this code to figure out that the free was called from RCU context
instead of the main thread.

For problems where the error can happen from multiple contexts and
places in the code-base, a backtrace can provide additional insight
that might be helpful in a few cases. Again, the intented usecase is
not developers with gdb that can reproduce a bug. People ask on IRC
about bugs they have that happen rarely over the timespan of a few
months and they only have logs to go with. Considering that this
feature can be off by default (as it is in this RFC) I don't think
there's potential for distro end users to be confused.

Thanks,

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

