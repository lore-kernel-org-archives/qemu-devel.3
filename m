Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18AEC87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 16:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujKSW-0004Nk-Pd; Tue, 05 Aug 2025 12:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujKR2-0003E6-Ip
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 12:22:44 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujKR0-0003dR-IZ
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 12:22:44 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6157b5d0cc2so6361579a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 09:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754410961; x=1755015761; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++cEYbaawf2T0DuNz4NFmETE0GCsQEmrbz338e4ahFE=;
 b=rhaz+3nAFHvawJZkXgknaKe+Iw3GK5XFnXjaXabwyKoCFTaq8AwWl2ouwtrSvYW6IB
 Ms5AlbC8P8NUXPlB7ARyDkNKSux8k4Vw4IFMOnsYAZiJvcWV3Usn7XBVxuwLalNJ9NX9
 bbAx+9BE0NzBxQfDIiGsh5EhrVsyGXm14d2b+hOU1tw0gWnJKpvV/3nN0ruAq73G4MB1
 Lv/a1fhFOGJgM1vqtaWpeOFrQ3NHIa7xPR7fJjhP7z7/GCHnrncTwXzMM4S3YWG+cuDm
 /hxZeKapDkd8rAL5JUzRUKQQzY+qrBIthlA/0RUX/rz3UbmDe3AUGOnjQMJ42CrHXg2s
 t0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754410961; x=1755015761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=++cEYbaawf2T0DuNz4NFmETE0GCsQEmrbz338e4ahFE=;
 b=GMTtDO8CEMj+pvhDWQwmLuDrfx2IwXTp5fWMfabve8qUMsSlgID1C0pM8VYh3I/jnA
 oH/y1W6bgAnGrwbaYWmzYEi0P5+siJABM3Hinhn1m7Cm5P9RiknYsCTUoMwBumITEthN
 nAKleorP2nd7OUIp8ugCkDXz9EdQWQ8AFJEk1J0WLc6sobjJZOv+E8vKQ/U//WpRJTvc
 Ob2c9kcM8N49i7Yr4PeiCyKjCh6ntWsTtuZC4v7u1gc/4xi/VEDV6AJr2O5X+pFs0Njb
 52zZHdNT6lJrJp44EbqyfVX1wWYCy8yPFRHwFJAzwMX4GXxAh/7gj5KIUKNBaZEppBNI
 EaDA==
X-Gm-Message-State: AOJu0YzOi7TZuux1j8oClbFkYMNJV5OR5IiwhmJP43jCiPxSFwIAhssV
 S1pzaRgJL9AyPvbFJHz7HzVRLt17ewnRMdohzKha+itajZV2I6PoaJYEzDq4CGBAHZmwLy55OkB
 TCbY26xaqEaFWglMMTiVsHrZVfrJpAO6G3xLKChRqZw==
X-Gm-Gg: ASbGncsqiLSJaNzQSRqxeR8U/kgiNJKAvgH2nFfANRegFF+Oh4re5EHpEEnJY9zUh3/
 3UBdsvplCerRzZSgsDtuzbvlCNZSEi4IBFqBQn/RbXgnw2R1X0KXGfN7yJhL0nhq7Hhz31zOExv
 2vikY+Wouy4nM4qKStbxsQqfLvbo/V+vpvJeM8+DXXNYbuMHubMowqmBPK5iiUMmwt73WoTs1yQ
 lsGlYFu2wLBt+TQdNQ=
X-Google-Smtp-Source: AGHT+IH5q5nA9iaKa5Jxz4ryUrE43Wp+xzKDDAUUPB84T0+2YLQo/pX+EjqpqxufmSQZPNcGT4HhjJ+ZS9N9y6yhsuE=
X-Received: by 2002:a05:6402:26cf:b0:615:920d:4de5 with SMTP id
 4fb4d7f45d1cf-615e6ed63a5mr10518670a12.12.1754410960781; Tue, 05 Aug 2025
 09:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250805-backtrace-v1-1-d189d09b1e92@linaro.org>
 <aJIqdQSYXO4K6lCJ@redhat.com>
In-Reply-To: <aJIqdQSYXO4K6lCJ@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 5 Aug 2025 19:22:14 +0300
X-Gm-Features: Ac12FXwXyL5I_1kHSEpFuRGcJncA-WhGXMVCkdBzUx9u_y6_n9Q8AtPzxazWpKA
Message-ID: <CAAjaMXY1ytnhp+APdwM39-K=Mu=5p8W=MEUVvLers3M=rLS6Qw@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, Aug 5, 2025 at 7:00=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Tue, Aug 05, 2025 at 12:19:26PM +0300, Manos Pitsidianakis wrote:
> > Add a backtrace_on_error meson feature (enabled with
> > --enable-backtrace-on-error) that compiles system binaries with
> > -rdynamic option and prints a function backtrace on error to stderr.
> >
> > Example output by adding an unconditional error_setg on error_abort in =
hw/arm/boot.c:
> >
> >   ./qemu-system-aarch64(+0x13b4a2c) [0x55d015406a2c]
> >   ./qemu-system-aarch64(+0x13b4abd) [0x55d015406abd]
> >   ./qemu-system-aarch64(+0x13b4d49) [0x55d015406d49]
> >   ./qemu-system-aarch64(error_setg_internal+0xe7) [0x55d015406f62]
> >   ./qemu-system-aarch64(arm_load_dtb+0xbf) [0x55d014d7686f]
> >   ./qemu-system-aarch64(+0xd2f1d8) [0x55d014d811d8]
> >   ./qemu-system-aarch64(notifier_list_notify+0x44) [0x55d01540a282]
> >   ./qemu-system-aarch64(qdev_machine_creation_done+0xa0) [0x55d01476ae1=
7]
> >   ./qemu-system-aarch64(+0xaa691e) [0x55d014af891e]
> >   ./qemu-system-aarch64(qmp_x_exit_preconfig+0x72) [0x55d014af8a5d]
> >   ./qemu-system-aarch64(qemu_init+0x2a89) [0x55d014afb657]
> >   ./qemu-system-aarch64(main+0x2f) [0x55d01521e836]
> >   /lib/x86_64-linux-gnu/libc.so.6(+0x29ca8) [0x7f3033d67ca8]
> >   /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x85) [0x7f3033d67d=
65]
> >   ./qemu-system-aarch64(_start+0x21) [0x55d0146814f1]
> >
> >   Unexpected error in arm_load_dtb() at ../hw/arm/boot.c:529:
>
> From an end-user POV, IMHO the error messages need to be good enough
> that such backtraces aren't needed to understand the problem. For
> developers, GDB can give much better backtraces (file+line numbers,
> plus parameters plus local variables) in the ideally rare cases that
> the error message alone has insufficient info. So I'm not really
> convinced that programs (in general, not just QEMU) should try to
> create backtraces themselves.

Hi Daniel,

I don't think there's value in replacing gdb debugging with this, I
agree. I think it has value for "fire and forget" uses, when errors
happen unexpectedly and are hard to replicate and you only end up with
log entries and no easy way to debug it.

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

