Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7524BC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whq6t-0003tj-5Y; Thu, 09 Jul 2026 10:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whq6n-0003tI-4i
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:52:13 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whq6l-0005VC-2F
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:52:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so8402215e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 07:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783608729; x=1784213529; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JSog4/gIwPe7men8EganxU6G5vloKbhYBFWM/k8HUz4=;
 b=ayXZ5AAbKwE3kVXSusPXquN/boPswTIA2gct+ISpwMq5tWPKb8K1+lRoi8Rfl1iG5R
 ssjldXrveYVQEr5N5+Ud1pDvRlK32Yf6sSmCzPlckItj6O4oubyXmHq89Qsqw6+q64f6
 Oyk8HpQGxluTIAIAeR9Qvlu9G1F89zSnYDfd8tlgh5+fOvLz2HmO2hpEEWiAS2B96od7
 0fGkLaP50YHohxmKI7I3K4ZIAyCG4HiV+Voe/NH3Ea+FDGEPUPOCf0w51LgbZCGSDzD3
 Tf4s/O/sFTcesAZmpvS7QXCpCAjLDziJXj1AwPX1XHaElLf8Dg3wAJW4kpCjQDSCCDxu
 OUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783608729; x=1784213529;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JSog4/gIwPe7men8EganxU6G5vloKbhYBFWM/k8HUz4=;
 b=AyQFPPn1E4VbNSbEM3/kZMZISW0D3gfzhSLy8JAadMk9f/6xsC1icPW8h2uol/2Q6G
 CoAI/5uZLLe7izKCXy4ozVf2SemaLM/i/7HkMzEOyT1FB1SEmr9oGRgjKVxfnUl08UQT
 6hXn0aMApXfCpCA/QduIJ9RHfrYyyvgSpCo9IpiNaVACJT7/7Ow02+Vfo1qB8Vld6JIb
 Zx7drxppUMoi/0nDCKAUe5dgEIprQcdx/yi7KI5x1qV6kNKD0vEpofarslHBJcv04zV8
 3pThEGbBxb5QPTVTkbLxQbDODZoltQOy38Tam4tW9vZ4cEqwDbmB7oZBgEQ4p+n/b5dV
 338g==
X-Gm-Message-State: AOJu0Yx4eUCmj51k2sqoXFcKFSbHsEi8aEW1pdk2LSz2btF658F00f5t
 gdZBXzukGJJHDEup8sndH8C8ziA+MrdTgD9A+D5Eu8mYbkSqVvoodersNVubzZ+WEnI=
X-Gm-Gg: AfdE7ckYU9nrr8QL4BiAc4peqpHaZD1xKMAB3AHn2Bk9IawQGCInGYFCzg/yClrZO9C
 3Ju6RXaxPwvVLr0blJLmOgjvghFKbphwbK0vMaDIJhmsZ5qFioBWvRsPmd99yN5V5+7scfZ2oJP
 gQK1YUjrix2yG3SeqOv+27AdNHjhEJylAE4OIvaNSgvoH95OhZ86mVrZt12t0Ch8KlihrUx6C/d
 5AOZzqNJTtrU3NBQovmS809qfBEPg7XZqIzJk4cKqHv85CRjj31m8pUk2Mu9/ir5jl4EuCyQkLu
 R9boiCn8rqVI/B7H5kn3/D2HyCMaAjVUj9Zp5GRlLrCRSgRAGBiThI8353iEAtRc/UEsSkBrqXO
 2c0K7wW1DpZ5BtFQ5fRXh6C2Jp1ypsvfZNNgJ+gttW1Kl0VIol5Jlk5b+h+QbdzLY4Tdu0w71nO
 L0jxvt0cP24Jk4
X-Received: by 2002:a05:600d:8444:20b0:492:66fb:5dc5 with SMTP id
 5b1f17b1804b1-493e68df9c2mr55897825e9.24.1783608729182; 
 Thu, 09 Jul 2026 07:52:09 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e5a58853sm114165545e9.1.2026.07.09.07.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 07:52:08 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 69A965F82D;
 Thu, 09 Jul 2026 15:52:06 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Ilya Leoshkevich
 <iii@linux.ibm.com>,  Brian Cain <brian.cain@oss.qualcomm.com>,  Gustavo
 Romero <gustavo.romero@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Helge Deller
 <deller@gmx.de>,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 19/91] tests/tcg/meson.build: add wrapper record_replay
In-Reply-To: <20260706223343.988769-20-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Mon, 6 Jul 2026 15:32:31 -0700")
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-20-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Thu, 09 Jul 2026 15:52:06 +0100
Message-ID: <87echcrzah.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Runs a record and replay test, and make sure the output produced by
> both runs is the same.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/tcg/meson.build              |  1 +
>  tests/tcg/scripts/record_replay.sh | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
>  create mode 100755 tests/tcg/scripts/record_replay.sh
>
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index 30178df0f7a..e610ce30f40 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -7,6 +7,7 @@ if config_host.has_key('GDB')
>  endif
>  gdb =3D find_program(gdb_progs, required: false)
>  prog_gdb_test =3D find_program('../guest-debug/run-test.py')
> +prog_record_replay =3D find_program('./scripts/record_replay.sh')
>  prog_run_and_diff =3D find_program('./scripts/run_and_diff.sh')
>  prog_run_with_input =3D find_program('./scripts/run_with_input.sh')
>  prog_run_and_check_forbidden_output =3D find_program(
> diff --git a/tests/tcg/scripts/record_replay.sh b/tests/tcg/scripts/recor=
d_replay.sh
> new file mode 100755
> index 00000000000..57775a2d4c1
> --- /dev/null
> +++ b/tests/tcg/scripts/record_replay.sh
> @@ -0,0 +1,16 @@
> +#!/usr/bin/env bash

While at it is there any reason this couldn't be plain POSIX shell. I
don't think we explicitly require bash although its super likely to be
on most systems. configure is all POSIX shell.

> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +set -euo pipefail
> +
> +if [ $# -lt 2 ]; then
> +    echo "record_replay: qemu_bin [args]..." 1>&2
> +    exit 1
> +fi
> +qemu=3D"$1";shift
> +tmp=3D$(mktemp -d)
> +trap "rm -rf $tmp" EXIT
> +set -x
> +$qemu -icount shift=3D5,rr=3Drecord,rrfile=3D$tmp/rr.bin "$@" |& tee $tm=
p/record
> +$qemu -icount shift=3D5,rr=3Dreplay,rrfile=3D$tmp/rr.bin "$@" |& tee $tm=
p/replay
> +diff $tmp/record $tmp/replay

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

