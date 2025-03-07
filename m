Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCCAC28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqd3w-0000XA-Ks; Fri, 07 Mar 2025 14:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqd3v-0000WQ-0s
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:08:47 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqd3t-0005Y8-AG
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:08:46 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e60b81c29c5so3071321276.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374523; x=1741979323; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W9za7FoIblYZ77VGeJVDolMlTEwL+Oss5QLjfRGcMj0=;
 b=bQUdzS35AwaEZ2b0bW3/ufZ4/cRmkOzwxOwkzsOuzoj8SMTC2+5A6sQf/cAGY4z4L2
 30qLpim7AgtxAF8tteFtbqWiLBI6hYBtXjEjPc6lINr+B1oAkk/OFAQJhQSoyBb8wXdY
 w+UAVG02FqQXj1aPYEL2BO1cZS0EPqCBJJ+CXXL+dSIL/1MxHvG6qmSDR5L3NzG8jwKi
 DmABJG4Zz3tXSjbyZ70uit5YaGSmrMxj04THxgl+1cd2AXTVb/7A203pfwgnGUn4e93s
 aaoV7+7ZCBnNgxwXA5dNtgoyZpZz8WTT8HmE4wvkbFBjRzoPJd8wE0Z7aNfEAFmmifsC
 ffEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374523; x=1741979323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W9za7FoIblYZ77VGeJVDolMlTEwL+Oss5QLjfRGcMj0=;
 b=Oi1tgX4y6WfbfOCVSGs2oMHfxACJ41OY6Zf9KNENN2YY63PbbXYOD2Y4kx2kiJTrc4
 Wgd7h/pMk1iHsjo0hr/NVRaCfATR0B9d/Q0zaTXT+ZCGvvjNwN7D+1mubX4afFXesmi5
 fIqMpY+Rw2IMJQLMFNdMb3J3eMLEd3Av05zlJkOQ9pP1b18i6PYCp8EU7y1aTbDOdOIi
 9sG9+2L2KR7skRsvA0nFppcR1zBKQgHFEm3ZxrmUFMQbLvRdWNAW2T7H30AlGYe1x3L5
 Bt06mF35RDkbvh6wd//X/1J9KdBA9EaHed/jKUZZd/+PiTLindQmiZYRaTHSAh4e6Ml+
 1Ydg==
X-Gm-Message-State: AOJu0YxmDMR+Z7lDe9yAzDkXJtWHtbQiEYnfl1lStEOF68oQNMJBYdis
 ReWIcIIX9z3awSVa9zrUxRJOpWb1gX1hAM7Tngl2/4MB1zsiiOyx/xd2a2xYHU6H3UIPdbOjLhU
 ZSwknxcTw1hF+7sUqFc6IHYgG0OvioVWib/TSpw==
X-Gm-Gg: ASbGncvmVBgMPVB6rftVXM3DvtCjjWPNaOn6s2+fh9a/VUEjJdPGSOUj8J3+XldDOUX
 4aLFmPRSU+GHGgfh99RX2Xr/Ftq6R4o/+iYA6MUFB4MNr1nkv0HrXVD9z9JGpYS+ZyzdhZHarSj
 oZfwQtu9LiwBko07QXEsnrFo+0bsU=
X-Google-Smtp-Source: AGHT+IHMx+CSkryOdcjWbTFRgipya44aVO6R4d8DecMT5MiJTmculyV0dv4fHilR4zNaszOpsVA4HqzV5NkREGdDrcI=
X-Received: by 2002:a05:6902:2493:b0:e63:6b50:5cdf with SMTP id
 3f1490d57ef6-e636f584da4mr884026276.9.1741374523467; Fri, 07 Mar 2025
 11:08:43 -0800 (PST)
MIME-Version: 1.0
References: <20250226095731.1172375-1-thuth@redhat.com>
 <20250226095731.1172375-12-thuth@redhat.com>
In-Reply-To: <20250226095731.1172375-12-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Mar 2025 19:08:31 +0000
X-Gm-Features: AQ5f1JpumHNa5PxtgdPO5nt3rHtnTvv5Ze1AanAHSAMPms8OxEcnNenyvgEcOCc
Message-ID: <CAFEAcA9buXVY0UmfVVQc1Jzq_aF6mhzDHmViRuj2b8X9PM08Gw@mail.gmail.com>
Subject: Re: [PULL 11/18] tests/functional: Convert the arm replay avocado
 tests
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Wed, 26 Feb 2025 at 10:00, Thomas Huth <thuth@redhat.com> wrote:
>
> Put the tests into a separate file now (since in the functional
> framework, each file is run with one specific qemu-system-* binary).
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-ID: <20250218152744.228335-10-thuth@redhat.com>
> ---
>  tests/avocado/replay_kernel.py      | 74 -----------------------------
>  tests/functional/meson.build        |  1 +
>  tests/functional/test_arm_replay.py | 69 +++++++++++++++++++++++++++
>  3 files changed, 70 insertions(+), 74 deletions(-)
>  create mode 100755 tests/functional/test_arm_replay.py


> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 995cea4f305..a46c4e89464 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -113,6 +113,7 @@ tests_arm_system_thorough = [
>    'arm_orangepi',
>    'arm_quanta_gsj',
>    'arm_raspi2',
> +  'arm_replay',
>    'arm_smdkc210',
>    'arm_sx1',
>    'arm_vexpress',

The default 90s on this one seems to be insufficient.
On a debug build with rust enabled on my local machine,
running just this test takes over 2 minutes:

$ time (cd build/rust ; PYTHONPATH=../../python:../../tests/functional
QEMU_TEST_QEMU_BINARY=./qemu-system-arm ./pyvenv/bin/python3
../../tests/functional/test_arm_replay.py)
TAP version 13
ok 1 test_arm_replay.ArmReplay.test_cubieboard
ok 2 test_arm_replay.ArmReplay.test_vexpressa9
ok 3 test_arm_replay.ArmReplay.test_virt
1..3

real    2m16.564s
user    2m13.461s
sys     0m3.523s

I'll send a patch to bump up the timeout.

thanks
-- PMM

