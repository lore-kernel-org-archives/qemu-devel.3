Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB887FCC056
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 18:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vya1w-0000IW-RF; Fri, 06 Mar 2026 13:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vya1u-0000IL-CQ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:36:06 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vya1s-0005oZ-5R
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:36:06 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so82017515e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 10:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772822162; x=1773426962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YiCX6ga24zD3RmkJYcZJqji3xTxNrBSaoqg/AAeKEyw=;
 b=PXnzf6E1GD9few5ZJtd6FwYTsBh9c6zmvVRm0LTbsFUmCnhapUyBpiLirYnn73B/PQ
 zDJB9YCJKSsaTDUeWIqTk4AUWQAzxyO4tTZjJm8m24BwGRS65aCYFZFzAZzMILt0NS+0
 zh38E4dnX73skXa8hXUFohrEEhUWRcylgtLxa2E9QRMT0cFZ0GRh1NNha4NGYaiWZXok
 AlApnZGyvuhhOWrlkTwZ/Xe2o4k3wr3OZYwykMROTE/XoUwQntvUZASZUp4UHlvDOlVr
 SBozjyBupv/WC1EP6tKJOArLKjgxqwMweH3Mf4Eku6zoP4gfZ4ZHN122rHC0o0Ta/zZp
 k7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772822162; x=1773426962;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YiCX6ga24zD3RmkJYcZJqji3xTxNrBSaoqg/AAeKEyw=;
 b=MYt+OrvxYmt07dn52+OHv9BRY7FCxkKpj8I7fOoeLYQxTNKw/rn2Qr7D/2RIft6E2V
 Bl33wp+hS/9uYf2JdesrVnSvb/4T5EWVZ2EK/XygxbmUQduENe4SomkuYMhzl3P/BBI6
 wnHOdTmcR7ezNX7NRZfTXR62ciJEyYOZT6HNn6B0M1XQFooMQgGko4pzKB5Wi1QKSdwQ
 WJB/B/M1m0HnimE9tImfgH+RMzcYsUcAhqbfOeOF4W4pPpfsolc2P9A8ULx3FRa0INK5
 RiIlPWaIoHb3NrnwZdbjAW0m7L9AtUyrj1g+6a2Dq4dEDPSIZ5aBR5MytQCQKwOAqh18
 KB5A==
X-Gm-Message-State: AOJu0Yy3Tx0S5Q1HFJFtQBOGCK7rEZTXmX2oJiCZPy6QtAr4kyHCOLIv
 ZNZZKP2aonz4U9wIo9qRvOO5k1/gqA8beZfjwSAEHrdkDC2GV+vQ9cq/CjtIHg+9E1s=
X-Gm-Gg: ATEYQzx5HDVD3jgffuPmdnf4aI3vtnmMLrp+DFgkYezKVRvbTRQKGIQmWQBJoAMGfON
 c77ZXLuOBJtMSvH6TSJkyGxazfMJgTvHLiAYsmIqJ2+aD919+sbMzoAKISIvuCVPML58JMOPFvz
 HiSuFZo0+vdnnonSmLtf+Uqazy6TAVAqywQ+3Ot3T6aeGc+N9UEWuKxJJSk9N9TBhC/4dUDtAcR
 XYm6/sQZMNILMBoPiQT/zwBHO3FeLibNB3XxfKe4wMD+/5+9ozsCBmkYl1ROzCiQ+F6jyJjfSU0
 gCWWS4cobdDm10u8mC2jgOd9n8eAJ8mApsTTCR0R23NOB6KX/MrRBLK8SZnckyMZUzFMy7kvkpL
 7MQ5nG5rGD8h1JzK8cx9+rup2nb9il/WPpqsNeUIJNbRqzi29nHxd9L+waquZqXp+Pzee1P9dEk
 7DqKGrM6Pe39wY7xb1X0yHos5Qyh9/1sgd/Q==
X-Received: by 2002:a05:600c:698d:b0:483:acd9:bd18 with SMTP id
 5b1f17b1804b1-48526917263mr59113965e9.1.1772822162237; 
 Fri, 06 Mar 2026 10:36:02 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527681a3esm118051075e9.4.2026.03.06.10.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:36:01 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9DA34689CF;
 Fri, 06 Mar 2026 18:36:00 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Brad Smith <brad@comstyle.com>,
 qemu-arm@nongnu.org,  Kyle Evans <kevans@freebsd.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter
 Maydell <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 2/7] tests/tcg: allow filtering of TCG tests
In-Reply-To: <5342a38e-ee34-4d52-928c-e60028848e2b@linaro.org> (Pierrick
 Bouvier's message of "Fri, 6 Mar 2026 09:34:44 -0800")
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
 <20260306161728.2657486-3-alex.bennee@linaro.org>
 <5342a38e-ee34-4d52-928c-e60028848e2b@linaro.org>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Fri, 06 Mar 2026 18:36:00 +0000
Message-ID: <87v7f8n6un.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 3/6/26 8:17 AM, Alex Benn=C3=A9e wrote:
>> We have a lot of TCG tests now which can be fiddly if we just want to
>> check one particular test type across the targets. Introduce
>> TCG_TEST_FILTER to allow this:
>>    make check-tcg TCG_TEST_FILTER=3Dgdb
>> to run all the gdb tests across the suites.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   tests/Makefile.include    |  8 +++++---
>>   tests/tcg/Makefile.target | 12 +++++++++++-
>>   2 files changed, 16 insertions(+), 4 deletions(-)
>>=20
>
> Ideally, we should have a list command available also, so we don't
> have to guess what magic pattern names follow.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

If you run "make help" in one of the TCG test dirs you will get a list:

  =E2=9E=9C  cd tests/tcg/aarch64-softmmu/
  =F0=9F=95=9918:35:48 alex@draig:tests/tcg/aarch64-softmmu  on =EE=82=A0 p=
r/060326-11.0-virtio-gpu-updates-1:master [$?=E2=87=A1]=20
  =E2=9E=9C  make help
  tests/tcg/aarch64-softmmu: -march=3Darmv8.3-a detected
  tests/tcg/aarch64-softmmu: -march=3Darmv8.5-a+memtag detected
  TCG tests help aarch64
  Built with aarch64-linux-gnu-gcc
  Available tests:
    run-asid2
    run-feat-xs
    run-pauth-3
    run-semiconsole
    run-semiheap
    run-vtimer
    run-mte
    run-hello
    run-interrupt
    run-memory-sve
    run-plugin-hello-with-libdiscons.so
    run-plugin-interrupt-with-libempty.so
    run-gdbstub-memory
    run-gdbstub-interrupt
    run-gdbstub-untimely-packet
    run-gdbstub-registers
    run-memory-replay
    run-gdbstub-mte
    run-plugin-memory-with-libmem.so

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

