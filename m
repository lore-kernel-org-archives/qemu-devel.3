Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C687DCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXDPc-0002Q1-61; Wed, 10 Jun 2026 03:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXDPa-0002PY-Iw
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:31:42 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXDPY-0006k0-Tw
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:31:42 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45eeba68948so4575217f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 00:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781076699; x=1781681499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UaztTtXKGjQvISAQdOR+p8Z5RioQFI+ci6eiPAPncNY=;
 b=FjJhw3HsrhmIuLhJyToEHbIVhsQlR2Ny4oxvzimDhLJeyIhdy6ZOpi1i2HXLoIxc07
 dnIEy4whyC2NeWIwCi9g9Oz8To0yKNeuQ8YZ/Lovj3eGw/4g/Rnqp2FnuUUgn0zU9ueY
 60VQJWHhsI0iWnG/RnCRZ09VA55BpQy9Yq2CNre5OjBVviV+FM2+5cGKGaHqdLp2me6V
 uG1Etftkq+IvodXMv33atqNPL3+5PJRZIUYYC1RDWyZTbLO87F6NtubhvqvAGm77DjRN
 9aaFOfoz9/sbVx/VBR8FsvmCyKEiKEq8AY8FCN8U9OI4YT7oxKzMmge3QM0tBlTz841N
 QPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781076699; x=1781681499;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UaztTtXKGjQvISAQdOR+p8Z5RioQFI+ci6eiPAPncNY=;
 b=mPbYEZj3r34Bfwx+/OG0cUne/WCgbSKNto5BvoqUMcLvmL9Mz1MZVOf6KgMYC56aD9
 33cVe75akdeJZy/FAEvol83AfUW6Iw7Rn+OhdydHxWH9UH3b+MibtGFEtqwrBC8GTpjW
 I5DxxvbFsXUU6edil1R/acQ87Rie+CErITuF3CisUQQV7k4InaU+bnn3bG05fxwr2iDD
 dPVGQZo/pAd4Ot9dUMbp7GPmAt4vqWfc00vT2tysgDoHdSZYs6kTMh0Y09i+mp4Tdw3U
 EKp+cUh5awOxotcZsGmfB4On+F8NQghJq34h5nNIZgDiioR4TaZ3grdxUFVb8Pglg66T
 TtqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hjLJQRB8h8UG1ePEIAlGIGv14K6u/DD8YrnjjrxbHEOSW8z6zzSMH1VJ+CjjXqFE8BvT2mNzp0Ztj@nongnu.org
X-Gm-Message-State: AOJu0YwQnUAgrKD5iQRH9MfQ5ThRglyQF0es2axU1YFbrcG098BqLRjt
 j0Jhgqa6u4xTVXaNIcQuv6gVg2GFw/ZOr5/apWUXwMDyfkgT2xC3RfjLVXtb6aLokhc=
X-Gm-Gg: Acq92OExjKJSIQ0e99WBQcKsH2yX1yqWYLaU2mVpY8jwcQFLPFdofgvJjj91DVKTFUF
 WLYfe+sXe+EyxhFJJpTFrrbub3dwpgRv1PK7RHHHzJYlTgZXqx8WK7a7eD/bjGbsd/YNPOGf2G1
 RXvaty/TdPyj+/5ru8G5q0sWhjHbHUzIrmuK69pneozxRlhoWBovMJ21R/2R23DiCxTMeODfi62
 9Zz0Y/g7Wa9GjNQq/kFHK4RPsvfeBlUOy8aJ8UZtKUP4VEXF3U78pmalJmeaEVPF+0z10M4Cz8b
 /vM3tay3w/jkMU6LFbixrsV0eWTOXlur5hbqiuMU3lcOTXeoi8BqGNnNAQXOht9Ga5j9iAipzgt
 9MBixbVTDgxaExJUAyFbZO3O6SMZJEdpBCy3O3co6Kq1hGtSPOScUlkQaNQaAj0cF3kyBdffdGg
 w/2J5Q5ha0q9YKB8GQka5W5L5AgdH3sVgszH/bmuD0i6unmeoib4pFQkUZmRbRFWQyaOgzjKeUb
 mfw11d5c/Dm7pjfj6/WMWw15lSOslLC5tRcyejz9jPIsfHEESJqN54zj3aRsmiu
X-Received: by 2002:a05:6000:178e:b0:460:3234:293e with SMTP id
 ffacd0b85a97d-46032342a79mr36036560f8f.41.1781076699136; 
 Wed, 10 Jun 2026 00:31:39 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-144-251.home.otenet.gr. [2.86.144.251])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm64829520f8f.8.2026.06.10.00.31.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 00:31:38 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:30:31 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 20/27] tests/tcg/meson.build: add wrapper
 check_plugin_output
User-Agent: meli/0.8.13
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-21-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260609214745.772536-21-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tgenkp.crsxljvbliqb@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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

On Wed, 10 Jun 2026 00:47, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>This wrapper runs a qemu command, record command output and plugin
>output, and forward both to a check script.
>We use this pattern in several plugin tests (for instance, with
>validate-memory-counts.py).
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---
> tests/tcg/meson.build                    |  1 +
> tests/tcg/scripts/check_plugin_output.sh | 19 +++++++++++++++++++
> 2 files changed, 20 insertions(+)
> create mode 100755 tests/tcg/scripts/check_plugin_output.sh
>
>diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>index f0efd46ee3e..6e46c121fda 100644
>--- a/tests/tcg/meson.build
>+++ b/tests/tcg/meson.build
>@@ -6,6 +6,7 @@ if config_host.has_key('GDB')
>   gdb_progs = [config_host['GDB'], gdb_progs]
> endif
> gdb = find_program(gdb_progs, required: false)
>+prog_check_plugin_output = find_program('./scripts/check_plugin_output.sh')
> prog_gdb_test = find_program('../guest-debug/run-test.py')
> prog_record_replay = find_program('./scripts/record_replay.sh')
> prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
>diff --git a/tests/tcg/scripts/check_plugin_output.sh b/tests/tcg/scripts/check_plugin_output.sh
>new file mode 100755
>index 00000000000..4d12e23ad60
>--- /dev/null
>+++ b/tests/tcg/scripts/check_plugin_output.sh
>@@ -0,0 +1,19 @@
>+#!/usr/bin/env bash
>+# SPDX-License-Identifier: GPL-2.0-or-later
>+
>+set -euo pipefail
>+
>+if [ $# -lt 3 ]; then
>+    echo "check_plugin_output: check_cmd qemu_bin [args]..." 1>&2
>+    exit 1
>+fi
>+check_cmd="$1"; shift
>+qemu="$1"; shift
>+tmp=$(mktemp -d)
>+trap "rm -rf $tmp" EXIT
>+
>+set -x
>+
>+$qemu -d plugin -D $tmp/plugin "$@" |& tee $tmp/output
>+cat $tmp/plugin
>+$check_cmd $tmp/output $tmp/plugin
>-- 

Could we write a single python script for all the shell script wrappers 
and use a different kind of wrapper depending on its command line 
flags/subcommand we invoke it with? 

Maybe this could be better? WDYT?

