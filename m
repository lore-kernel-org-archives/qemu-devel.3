Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC40CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXDNn-0001O3-5o; Wed, 10 Jun 2026 03:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXDNl-0001Ni-IC
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:29:49 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXDNj-00036z-6M
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:29:48 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490af320e2aso69779745e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 00:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781076585; x=1781681385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LGyQYmG/YkOTpjwVkiBCXy9OpSXaLYNGWwD6griOt00=;
 b=fnxz4g1aOv/TWK5Z1aivs3p+7M1V9vlrzOpG90fmMrHEaSODV05QEYYtiEU8i/AKZk
 RBfefSGvCJfUaOJ3H9zqzI2f7z9fspIUetd2wWBAWl+SJoBw2+DXLIzA+ZUR1viiz3jC
 aQ/8FJ+b6Rrd8OsU+W2EP5ZbNHcXZ9mVvl/CR2yY7+SHkso4DHYp1Go3dxeUlKoxoS7l
 aDtcbCECUOkEeRzMyYCGYs2Mm+T5NUEc0wbQLZbfei7BVxqRyt10zDzS6yB96EK6h2HC
 tDYgI41gVj+Ls2pTL5m561zevyIuEtMfw0VtbCRCiB5qjsMu2nXFKsysQExsPvayrBtE
 QuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781076585; x=1781681385;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LGyQYmG/YkOTpjwVkiBCXy9OpSXaLYNGWwD6griOt00=;
 b=HjfL7iXVBXGqDki0k+nrGQNh3P8LGK4ZSN9veSFblKrJOU3Ej2Exm8ZqbLGUaDprM8
 WdT5bZSCwlJ+vVEjM3i0Vza1xWotsZBYSJrNEmD6ZvOmslKQ7croD4mW3G5I7czPPaS9
 qgF1xDptZ6q68SJ2Uoc5OSMYMpHny8UZwRwVqLXJoc+68VgzW6BUQYNnrmXaF66ffnjb
 edBgxebJ1woHgQT1jl4XTYNFCtMbAhdCsEmBQTCJ6O9r/MqkdBoxpBLdEHG+BngLz5Mt
 0MpuPoIdtxIYDY5LIG4PVk1UVF84U/AKCtDWiTXaJRprwQSQIhm/Y7/KG15/i7JjaJoA
 Q5WQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/X6CfCG2PQh1jXAS8F3cHnihVicfEuwvY9llNVlCAYavrCOw6UHVIINTL0REkahRPfMVpk06pO+FpS@nongnu.org
X-Gm-Message-State: AOJu0YyPXYzXUY3nAE3Qi5J634gXuwG1jE+HsrsRRQqvOXVwONWLwDzK
 FsJNXBVrXiz1n0wHTqn8MhFI+ixnJv6nIWWoq8EdJPT2tJyO4MM8cp5m0+0UxF1QiR0=
X-Gm-Gg: Acq92OGXbD1kLept7hkiuLDz+FU+z1h7MH8w59dXL5Kg7xDiDME+cvGhYxjO9xmvItR
 omWy05MRYgU6hc71ZUKn2pH5r3njI61/eG8ajcsez4hhHQy9d1mPVYJdZa+DwpJIgrhAojaB12e
 Bwjm0nrp2W49EsIq7IuCxWgZ/t5nAEAarvLDZ8QCwiwO+USPygJaNvgeh3m+OYiSGs30pNg5qvq
 XE0de9a4HkE8k/GdOJr0149CmpkEDs3cdinDwjLmQG3IgNYo5tt8ai5ZeR3DTrAbFTrtAI8R25V
 jR6eQ/NhRsUwKQQUvgSs78WfZg1Tp9QXWY7y+AAzU2x9iI+Qg2ywu1TfSVoMMQiiBSp3ZnbcWJt
 0rheAaLRqA9Zk2lcZgmeBQwqooe9px9R9aHMrM9GP5ojjEE4ZScUMBx500+fpC5/CJadSrJ5oJa
 4RDs1Uesm4wgyyQF3r7KPLRD/oaN4/W4YrvPEA55AgE9vzDnG2vwLqk908wmx0v6MIjsFshvm4j
 PPiObbXuSYnpZKz/RjwQuNkbP+3Tp1yEXr0AxTSSdm1xLk0e8s50QjdoyFSROgw
X-Received: by 2002:a05:600c:8216:b0:490:c2a3:23cf with SMTP id
 5b1f17b1804b1-490c2a323f0mr356502485e9.34.1781076585365; 
 Wed, 10 Jun 2026 00:29:45 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-144-251.home.otenet.gr. [2.86.144.251])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f345209sm74301947f8f.17.2026.06.10.00.29.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 00:29:45 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:28:59 +0300
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
Subject: Re: [PATCH 18/27] tests/tcg/meson.build: add wrapper run_with_input
User-Agent: meli/0.8.13
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-19-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260609214745.772536-19-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tgenhk.1crggx28eg1me@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32f.google.com
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
>Semihosting console tests require console interaction, and were flagged
>as manual because of this. This wrapper automates interaction, by
>sending a specific string on stdin.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Fyi there is also expect(1) https://packages.debian.org/trixie/expect 
but is kind of arcane.

> tests/tcg/meson.build               |  1 +
> tests/tcg/scripts/run_with_input.sh | 12 ++++++++++++
> 2 files changed, 13 insertions(+)
> create mode 100755 tests/tcg/scripts/run_with_input.sh
>
>diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>index f379449e582..7201a7809e1 100644
>--- a/tests/tcg/meson.build
>+++ b/tests/tcg/meson.build
>@@ -8,6 +8,7 @@ endif
> gdb = find_program(gdb_progs, required: false)
> prog_gdb_test = find_program('../guest-debug/run-test.py')
> prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
>+prog_run_with_input = find_program('./scripts/run_with_input.sh')
> prog_run_and_check_forbidden_output = find_program(
>   './scripts/run_and_check_forbidden_output.sh'
> )
>diff --git a/tests/tcg/scripts/run_with_input.sh b/tests/tcg/scripts/run_with_input.sh
>new file mode 100755
>index 00000000000..3d280547c3a
>--- /dev/null
>+++ b/tests/tcg/scripts/run_with_input.sh
>@@ -0,0 +1,12 @@
>+#!/usr/bin/env bash
>+# SPDX-License-Identifier: GPL-2.0-or-later
>+
>+set -euo pipefail
>+
>+if [ $# -lt 2 ]; then
>+    echo "run_with_input: input_string cmd [args]..." 1>&2
>+    exit 1
>+fi
>+input="$1";shift
>+set -x
>+echo "$input" | "$@"
>-- 
>2.43.0
>

