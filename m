Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FF1C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 19:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkpfi-0003yF-3Q; Wed, 19 Feb 2025 14:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkpfg-0003xz-2u
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 14:23:48 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkpfd-0002Od-Gp
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 14:23:47 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43996e95114so626485e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 11:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739993023; x=1740597823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lyMSEWw4O34IZe8YNuqu9EXefQ7KPkJGawHI7O5vSGI=;
 b=a9CK/4i1rSCQ4Y+rAqdPOtnz12d36eGJqp0jUaC8dVSHtdwZIq+HIZvXwO+jyz69BM
 VlM0g5ufG98f0Y0slg9/VxASZG6Jzxox39CQ4PjYXGvgs8reEWUXDsFhlqpWkYe/8Hxs
 QXOrFcwGEaUGlPYWIbFbbeSyIDrhJWzzOuOYb/CrMwZ4S21BMC0GgLeztBFQPTdpP60p
 P0UL9LNQIKKt8nqMtQZ1+pEiST/nM5HHpX/ttUFPsCbJsTT9oTUqzQ+W8/aYaPGKrW8K
 bYFiCO5QoIEqYGz20v88SCRCSkgMZ+k52/Uoq8AKjA0BmMjQmH0Rg2KsOt4MbFmWBAPw
 SDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739993023; x=1740597823;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lyMSEWw4O34IZe8YNuqu9EXefQ7KPkJGawHI7O5vSGI=;
 b=YJSjneMl4h2vlNalPHG4d1wQ4IqKl5+Xb2pv711ZTwXGhRX4YS3S2MHnMDLPtrqVhR
 7IQ60ZdCmJ0ANTX7CFG2fUNreSVl5zd+OziBEL1xzNA6ZRR7xsMFNp9NS0OCuMjXlb0C
 us81JUCcB02EQAH7P4p2Wank0oHmZmMIiNRZ0r62b+4pDDkyc+5ocGuM8y1SiD/hL0HI
 0yyhk2UW47uqIn1TCcuJT9CU4Gaa1Bwzlr07Cg6P9a6ipUcgLJ67Sw86WBOQ91OsFNfI
 DcWpJCb6MQpWwUeXWhLAdPdMiEOhOOczOfgZ7gl4tEZ4liPcaZSrIgClKFppMMTvzG3V
 OoCQ==
X-Gm-Message-State: AOJu0YxbnA6WNrB6MaiJcZOsa3FPWRx+XQBEL7Z6AWBLOpvcJKScn3r4
 5pFvLdfhbhqRMJP/Q0cC0j4/37BTiO2s2R5bEOm4XXiPXWDTLB94Wxn8Eiv8i6Sf1E0IJ9lc9yM
 unjk=
X-Gm-Gg: ASbGnctIRWvedJ0mfqjmSjEJVjnfT0fA+o9d1jm0/9RFBSO4KOOiT2VC8PznNFt5zTM
 o1ClnFMYQZWJJBoRvpmfRhjSefmhwoSIwMCtmQNxJ3G+rEpy2xfqG6CX9xieQvPpKUS7bFs8oKa
 Isn9mqSGkAsvWcrK9gKpZMYu4mXwlRP2HIfUAMcZnL7zZVKjDaYQxwoJDeIlmH+OqlBkIsm1BPi
 VW4/ouaLDeLR0hDN6EW5xVe7lkBhedKm+McxujVHe87wZxWx+UKW7aZG3BNWXoF51qKXkeQwWva
 +TG5oCNgHIptpNy4Cm2Xb+1AX/zxoC26/jiel8MrP6/x6cMw4ZQoaMyYBRyoj6ZmBQ==
X-Google-Smtp-Source: AGHT+IEpzmsuLQeAJ8P+IFfFjryTMKFUBFzw8KRRAJYslp7ENaAwbdEK9JGQMXetiiKSrktklTkRIg==
X-Received: by 2002:a05:600c:5101:b0:439:9496:181c with SMTP id
 5b1f17b1804b1-43994961a51mr77372295e9.29.1739993022824; 
 Wed, 19 Feb 2025 11:23:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399c41022csm25419685e9.40.2025.02.19.11.23.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Feb 2025 11:23:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH 0/2] tests/functional: Allow running TCG plugins tests on macOS
Date: Wed, 19 Feb 2025 20:23:38 +0100
Message-ID: <20250219192340.92240-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Pierrick kindly helped me to resolve this issue which ended
being trivial (to him!). Not tested on Windows so far.

I'm still having some meson dependency problem, even on Linux:

  $ make check-functional-aarch64
  ...
  Traceback (most recent call last):
    File "python/qemu/qmp/protocol.py", line 834, in _bh_close_stream
      await wait_closed(self._writer)
    File "python/qemu/qmp/util.py", line 130, in wait_closed
      await writer.wait_closed()
    File "/usr/lib/python3.10/asyncio/streams.py", line 343, in wait_closed
      await self._protocol._get_close_waiter(self)
    File "/usr/lib/python3.10/asyncio/selector_events.py", line 862, in _read_ready__data_received
      data = self._sock.recv(self.max_size)
  ConnectionResetError: [Errno 104] Connection reset by peer

  The above exception was the direct cause of the following exception:

  Traceback (most recent call last):
    File "python/qemu/machine/machine.py", line 448, in launch
      self._launch()
    File "python/qemu/machine/machine.py", line 497, in _launch
      self._post_launch()
    File "python/qemu/machine/machine.py", line 381, in _post_launch
      self._qmp.connect()
    File "python/qemu/qmp/legacy.py", line 153, in connect
      self._sync(
    File "python/qemu/qmp/legacy.py", line 102, in _sync
      return self._aloop.run_until_complete(
    File "/usr/lib/python3.10/asyncio/base_events.py", line 649, in run_until_complete
      return future.result()
    File "/usr/lib/python3.10/asyncio/tasks.py", line 408, in wait_for
      return await fut
    File "python/qemu/qmp/protocol.py", line 382, in connect
      await self._session_guard(
    File "python/qemu/qmp/protocol.py", line 456, in _session_guard
      raise ConnectError(emsg, err) from err
  qemu.qmp.protocol.ConnectError: Failed to establish session: [Errno 104] Connection reset by peer

  The above exception was the direct cause of the following exception:

  Traceback (most recent call last):
    File "tests/functional/test_aarch64_tcg_plugins.py", line 80, in test_aarch64_virt_insn
      self.run_vm(kernel_path, kernel_command_line,
    File "tests/functional/test_aarch64_tcg_plugins.py", line 52, in run_vm
      raise excp
    File "tests/functional/test_aarch64_tcg_plugins.py", line 46, in run_vm
      vm.launch()
    File "python/qemu/machine/machine.py", line 461, in launch
      raise VMLaunchFailure(
  qemu.machine.machine.VMLaunchFailure: ConnectError: Failed to establish session: [Errno 104] Connection reset by peer
      Exit code: 1
      Command: build/plugins/qemu-system-aarch64 -display none -vga none -chardev socket,id=mon,fd=6 -mon chardev=mon,mode=control -machine virt -chardev socket,id=console,fd=11 -serial chardev:console -cpu cortex-a53 -kernel /home/philippe.mathieu-daude/.cache/qemu/download/ce95a7101a5fecebe0fe630deee6bd97b32ba41bc8754090e9ad8961ea8674c7 -append printk.time=1 panic=-1 console=ttyAMA0 -plugin tests/tcg/plugins/libinsn.so -d plugin -D /tmp/plugini36uailv.log -net none -no-reboot
      Output: qemu-system-aarch64: Could not load plugin tests/tcg/plugins/libinsn.so: tests/tcg/plugins/libinsn.so: cannot open shared object file: No such file or directory
  make[1]: *** [Makefile.mtest:26: do-meson-check] Error 1

I don't mind much building the plugins manually:

  $ make tests/tcg/plugins/libinsn.so
  [1/2] Compiling C object tests/tcg/plugins/libinsn.so.p/insn.c.o
  [2/2] Linking target tests/tcg/plugins/libinsn.so

Then tests pass.

Philippe Mathieu-Daudé (2):
  tests/functional: Introduce the dso_suffix() helper
  tests/functional: Allow running TCG plugins tests on non-Linux/BSD
    hosts

 tests/functional/qemu_test/__init__.py       |  2 +-
 tests/functional/qemu_test/cmd.py            |  6 ++++++
 tests/functional/test_aarch64_tcg_plugins.py | 10 +++++++---
 3 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.47.1


