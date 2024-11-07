Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EBDD43374
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 16:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t95Dj-0004MU-MR; Thu, 07 Nov 2024 11:18:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t95Dh-0004M5-Hm
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:18:53 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t95Df-0001Q4-Of
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:18:53 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5cec8c4e2f6so1346068a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 08:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730996330; x=1731601130; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CyTyZXSBge0gLnnJ+ig0YMMZ3ykpH8242V/Q48guLo4=;
 b=VR9gyxjHAesOrqMneJoEzv2oM5x7h0tKhs7e6b0nOL4inP06beP0zhLtct+Vwb43hd
 Phs4uUIUIg1lJP0mkPZdiiM+A7a77IRXTo0mhIccf1L2ymxz1uggQIxeD45RiDmJrLAj
 9cBBjCEry/6+tGNaKQAVeyDi080CO6KapnE0PeJdsAK1hD0RWXsdyw6uoGbJBXpgwsM+
 h8lVt58d4pN9YxLj/HRTaqFx4Q/+uuFk1Ck8RXfMBT9gsmx8TG00mNLY+aMo8q62K3QY
 Tmr7HPKp28FTtanfj2YHITIQTBPUMQqC+LkktnKFq4wspeFdBZ9tOoQgJgEqbBJWDeFp
 6QWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730996330; x=1731601130;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CyTyZXSBge0gLnnJ+ig0YMMZ3ykpH8242V/Q48guLo4=;
 b=cUlZED3C6pc/1hhmU7bZ+1vPDwIcpVv7DK30aAPfuBf9397asfEE5ZgOIdlQ3L796t
 cRxcY7VzKpM46N6wVA8aPCZKPDHDA19713CcScCeWBx0mX/KtLkscyT0hlDP4amhPkne
 BAvXDw0DaqY+vFdlTzXC+w/4HfkBnZJH6XOTE5yv94nCCctOYktYlvdFjvPmia1hZzoy
 nh1/F+3Sh8ngWHkcW/GeKnwwnCpIX4eNguG0HiTXoid34BjSeI0pH0jr16J0xcCA/i2K
 wp6F836wzPK4LC9CnQgkN1WMz+C4uQxx2SXys6ZPqdXMoH6eXMjrwJp+1ZJvMOLccRO1
 u5Eg==
X-Gm-Message-State: AOJu0YzKQ+aI7NBesZS7uhlV0tGf1b7pPEuoBVOnhOKuT2k8hsoIUSrS
 6Nev+VqMgzzP3mYpbqAxUWPOD3cyeQvh5qak5pe4Cowuiv3zBhlMGIga7DIyIIqx0jIxDJbe09L
 15z+RNuW08KABjzoDAzdtsYoOlNOgUoLfs1NlZfK63WZj/uND
X-Google-Smtp-Source: AGHT+IHZxRaP5tkmFtlzWcIETW9ofeQvleVLdGtYAn+37VWSIqL6prCyioZnGaLTEqA+xGRLVBNlUvPEZwjsWIXj1DI=
X-Received: by 2002:a05:6402:5186:b0:5ce:d3a9:ae76 with SMTP id
 4fb4d7f45d1cf-5cf098485c7mr3957a12.3.1730996329809; Thu, 07 Nov 2024 08:18:49
 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-4cf+yub8bsgtsdFOJD_9HziY3tekCN5s=+JcWEpw3Nw@mail.gmail.com>
In-Reply-To: <CAFEAcA-4cf+yub8bsgtsdFOJD_9HziY3tekCN5s=+JcWEpw3Nw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2024 16:18:39 +0000
Message-ID: <CAFEAcA8mPFGX-aUUvJ5NXyyb2a9LFo=k+fBigHKdpoNj32QtCw@mail.gmail.com>
Subject: Re: test harness hang running functional test
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Thu, 7 Nov 2024 at 16:09, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> I was trying to track down why one of the functional tests was
> hanging, so I tried running it directly:
>
> UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1
> QEMU_TEST_QEMU_BINARY=build/clang/qemu-system-loongarch64
> PYTHONPATH=./build/clang/pyvenv:./python time
> ./build/clang/pyvenv/bin/python3
> ./tests/functional/test_loongarch64_virt.py
>
> (This is with a QEMU built with the undefined-behaviour
> sanitizer.)
>
> Mostly this seems to succeed, but this time it's hung. Looking
> at the process tree:
>
> petmay01 3616444  0.0  0.0   4768  1124 pts/2    S+   15:53   0:00
>  \_ time ./build/clang/pyvenv/bin/python3
> ./tests/functional/test_loongarch64_virt.py
> petmay01 3616445 99.8  0.0  38480 23620 pts/2    R+   15:53  13:20
>      \_ ./build/clang/pyvenv/bin/python3
> ./tests/functional/test_loongarch64_virt.py
> petmay01 3616448  0.0  0.0      0     0 pts/2    Z+   15:53   0:00
>          \_ [qemu-system-loo] <defunct>
>
> The QEMU process itself has exited, but the test harness has
> not yet noticed or reaped the zombie process. Instead it's sitting
> there eating CPU. Presumably this is a bug in the test harness?

Eventually I hit ^C and got this backtrace:

  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/./tests/functional/test_loongarch64_virt.py",
line 62, in <module>
    QemuSystemTest.main()
  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/qemu_test/testcase.py",
line 71, in main
    unittest.main(module = None, testRunner = tr, argv=["__dummy__", path])
  File "/usr/lib/python3.10/unittest/main.py", line 101, in __init__
    self.runTests()
  File "/usr/lib/python3.10/unittest/main.py", line 271, in runTests
    self.result = testRunner.run(self.test)
  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/pyvenv/lib/python3.10/site-packages/pycotap/__init__.py",
line 156, in run
    test(result)
  File "/usr/lib/python3.10/unittest/suite.py", line 84, in __call__
    return self.run(*args, **kwds)
  File "/usr/lib/python3.10/unittest/suite.py", line 122, in run
    test(result)
  File "/usr/lib/python3.10/unittest/suite.py", line 84, in __call__
    return self.run(*args, **kwds)
  File "/usr/lib/python3.10/unittest/suite.py", line 122, in run
    test(result)
  File "/usr/lib/python3.10/unittest/suite.py", line 84, in __call__
    return self.run(*args, **kwds)
  File "/usr/lib/python3.10/unittest/suite.py", line 122, in run
    test(result)
  File "/usr/lib/python3.10/unittest/case.py", line 650, in __call__
    return self.run(*args, **kwds)
  File "/usr/lib/python3.10/unittest/case.py", line 591, in run
    self._callTestMethod(testMethod)
  File "/usr/lib/python3.10/unittest/case.py", line 549, in _callTestMethod
    method()
  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/test_loongarch64_virt.py",
line 57, in test_loongarch64_devices
    self.wait_for_console_pattern('Run /sbin/init as init process')
  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/test_loongarch64_virt.py",
line 33, in wait_for_console_pattern
    wait_for_console_pattern(self, success_message,
  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/qemu_test/cmd.py",
line 152, in wait_for_console_pattern
    _console_interaction(test, success_message, failure_message, None, vm=vm)
  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/qemu_test/cmd.py",
line 101, in _console_interaction
    msg = console.readline().decode().strip()
  File "/usr/lib/python3.10/socket.py", line 705, in readinto
    return self._sock.recv_into(b)


Something has gone wrong if we can be blocked waiting for
guest input when the QEMU process has already exited...

-- PMM

