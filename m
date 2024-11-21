Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44283D78793
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 16:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAFH-00067k-KK; Thu, 21 Nov 2024 11:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAFC-000671-S8
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:41:26 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAFA-0005ns-R5
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:41:26 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so6552675e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 08:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732207282; x=1732812082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zRSHpS5mArv737GoSpxyuAlftPzlSnF23/QwowOdgac=;
 b=eJct1/Jc778eNMfisS/Ile4cBF7sVgfjuduKufjcv9Ukg8faX6P38JyWAeFUfVAltm
 ZvD/C0Mpk4SFoYQLDv2iArqIP3NMsgwLEOmO9T35CeuhqvblHCWaGuRRLZOxuk5UyERK
 8GvOHI37R/HWf0NU6KaZRtflgGPvcekKFOe7BcafaMaI2Xny+GBMY8YzGufwkTXx23I8
 GmQAhoyHizMD7+PZWSll8m7dmk/89KElPlGYakKNJwmCa8g1pV8himVFZPVsoj/WhMMM
 kB15rSg3b7lkN59Sg5AOgFgOkxFTkTGq6sB/XxMbtYml788GjS1QMQ3Co1k4fCDWxhgy
 xUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732207282; x=1732812082;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zRSHpS5mArv737GoSpxyuAlftPzlSnF23/QwowOdgac=;
 b=tj3H5jjaeDfJOe+OqhRd3UVkDvnX+8J6b52vHi9OYb9yw3X/BBp9Q4cYK9QPE+QWMN
 cO/ckynR5MxgdAj9735cZ763Jz5ykn/zJEFmjPoYivUuuNIAQq3JRZ45Z46mf6N2OJpO
 4A9eIPyiKzQxnayK3ZcXPOvRIXDi2AYAI1cNZHgMlr7yoqySyR7DqgWaUEq0p5AO0rBH
 IPKr9uSZLnFfWs1EJzGo6HF9Cp+FNLvfsa2kIkWGB+jcIqhTZYsEBk3RbGj9YDk9YUVa
 /CvzQxy6Zf2G8vzHwNpYJ0ElBwJYkuM8lgiSqqtiwGdMxgbiuByyf87umo1aZajil71Y
 JTVQ==
X-Gm-Message-State: AOJu0Yz47D2YSjCQ5bRAs8NqUu8+YoqGP7NfhRwsKh03xuNvf6asGutN
 1MS4RWGPc6q1e1DWm3EYjNVxJLmMTQsVo/vMJ7JVqegqrEjtW1ZXvxbUkauWXy8=
X-Gm-Gg: ASbGncvotzKTr0wPzYLLjXRD6GZzp4im2UrQuIkhnU4+sdUfmRtf5qOCIlNariIEcOV
 9Bvc1ZFWixO9JMjt/4pEdZ2z4ReADK85Zpm8j5WEWdios1Qpu1Yd/UtYmC/D4tLcnH62V78g8fB
 0sWBs7y5joMT112vbF6Tq8kShL2AhhAXbd/pc7NkbtmqG9QMENwgF71I/dQBdFdwufJiq2GhrSV
 6LhnpeOv1zoftpuKFh/pgmS1hLglsMIgOB2yvidalmFwbcS
X-Google-Smtp-Source: AGHT+IHo6kAGICz4cq5dWnn6Eg7daJ18wu9cabEhpGawBzV1fhdt9y5gsDd2NZd43QqlNTnIan2pzg==
X-Received: by 2002:a05:600c:a401:b0:433:c76d:d56b with SMTP id
 5b1f17b1804b1-433c76dd67fmr25099375e9.12.1732207282081; 
 Thu, 21 Nov 2024 08:41:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b4616843sm60798385e9.20.2024.11.21.08.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 08:41:21 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 69E2B5F77B;
 Thu, 21 Nov 2024 16:41:20 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 00/18] test/functional: improve functional test
 debugging & fix tuxrun
In-Reply-To: <20241121154218.1423005-1-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 21 Nov 2024 15:42:00
 +0000")
References: <20241121154218.1423005-1-berrange@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 21 Nov 2024 16:41:20 +0000
Message-ID: <87v7wgletr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> This started out as a series to get rid of the many GBs of temp
> files the functional tests leave behind. Then it expanded into
> improving the functional test debugging by ensuring we preserve
> the QEMU stdout/stderr log file created by the QEMUMachine class.
> In the course of doing that I encountered some other minor points
> worth fixing, and then got side tracked into looking at the tuxrun
> hangs with aarch64be. Investigating the latter exposed some further
> holes in the debugging story prompting yet more patches, as well as
> a final solution for tuxrun. So this series does:
>
>  * Purge all scratch files created by tests
>  * Preserve the stdout/stderr log file
>  * Capture debug log messages on QEMUMachine
>  * Provide a QMP backdoor for debugging stuck QEMUs
>  * Enhance console handling for partial line matches
>  * Fix the tuxrun tests by eliminating sleeps
>
> There's quite alot of code here, but at the same time it feels like
> the kind of stuff that'll be valuable either in the 9.2 release, or
> in the soon to exist 9.2 stable branch.
>
> NB, with this series applied Thomas' tuxrun conversion to functional
> testing survives 200 iterations on my machine, whereas it would
> reliably hang in < 20, and often in < 10, before.

Queued to testing/next, thanks.

I'll combine with plugins/next and some other misc fixes and post a
pre-PR for next week.

>
> Changed in v2:
>
>  - Changed console interaction to forbid 'failure_message'
>    without 'success_message'
>  - Reword console interaction log messages
>  - Avoid stack trace when seeing early failure
>  - Rewrote comment in acpi bits test
>  - Avoid duplicate os.environ access
>
> Daniel P. Berrang=C3=A9 (18):
>   tests/functional: fix mips64el test to honour workdir
>   tests/functional: automatically clean up scratch files after tests
>   tests/functional: remove "AVOCADO" from env variable name
>   tests/functional: remove todo wrt avocado.utils.wait_for
>   tests/functional: remove leftover :avocado: tags
>   tests/functional: remove obsolete reference to avocado bug
>   tests/functional: remove comments talking about avocado
>   tests/functional: honour self.workdir in ACPI bits tests
>   tests/functional: put QEMUMachine logs in testcase log directory
>   tests/functional: honour requested test VM name in QEMUMachine
>   tests/functional: enable debug logging for QEMUMachine
>   tests/functional: logs details of console interaction operations
>   tests/functional: don't try to wait for the empty string
>   tests/functional: require non-NULL success_message for console wait
>   tests/functional: rewrite console handling to be bytewise
>   tests/functional: remove time.sleep usage from tuxrun tests
>   tests/functional: add a QMP backdoor for debugging stalled tests
>   tests/functional: avoid accessing log_filename on earlier failures
>
>  docs/devel/testing/functional.rst        | 16 +++++
>  tests/functional/qemu_test/cmd.py        | 89 +++++++++++++++++++-----
>  tests/functional/qemu_test/testcase.py   | 43 +++++++++---
>  tests/functional/qemu_test/tuxruntest.py | 17 ++---
>  tests/functional/test_acpi_bits.py       | 57 +++++----------
>  tests/functional/test_arm_bpim2u.py      | 20 ------
>  tests/functional/test_arm_orangepi.py    | 27 -------
>  tests/functional/test_m68k_nextcube.py   |  3 +-
>  tests/functional/test_mips64el_malta.py  |  4 +-
>  tests/functional/test_virtio_gpu.py      |  3 +-
>  10 files changed, 150 insertions(+), 129 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

