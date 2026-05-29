Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C82CD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 09:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wStGh-0006jz-SD; Fri, 29 May 2026 05:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wStGg-0006jZ-Hc
 for qemu-devel@nongnu.org; Fri, 29 May 2026 05:12:38 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wStGd-0001MW-5i
 for qemu-devel@nongnu.org; Fri, 29 May 2026 05:12:38 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6804e24803bso1351564a12.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 02:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780045953; cv=none;
 d=google.com; s=arc-20240605;
 b=Ho16g5FXoQDxkPwkae2HgspbQNQKNF5O2o1jmSWEajVXfeB/qlMWRwGtdxXW0JsteR
 dtzN50UI9Lph44P/8p/Zf4NGrxvG6asizfiPbKm/EC2TkgjEjgNbVRj2EibZfjLC6Q9z
 1E//R1Op7uHt/J2jSCARViMXM+u1XNOcetZqVHjPvVdYgN0MIjG+uMmYqJotxDlJV18f
 zOGZJ93jhXHLlz9TcpEc14UOTeXb+LZl6/WY1amF5mGSu7KNSjY8X+ZVrzBRJGjnY1un
 ZtZjg2l9OoJsjldeeRQMP01sJsSaGNJpZJbboyu054XMSay12unPsischwWfxB/ZhGE1
 ZIIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qtCQR2z1HBeGEoJFtbxgUqwRdyhzaoV0GIg+kYKHcUo=;
 fh=waM909xNckwKm7pPQFH3nLBAWEC+k9YWzSA1XeTt6rM=;
 b=bCADvrle410VQyMEseb5FkJkGZRhwNKsqwh7+S1tj6P4T1jVbxUVQqPzYqDa4CLZtd
 wQOV9w3pR7MjROT5QbEFLt1tPrizQH5eWdoKWODEs87dmwvcqE3b46Zf2k8dOyPvOqeS
 0K9v3b+GheD+azGhBfzS5SDwnBez63qNoUbfHqlMKf/CpoI/9w6EwDZQHVWtjoYbTwKz
 P+zDeMerQLFxAQ8qM9XUk+uoTiuepYhl/pFPbH8lOsZbcrmT3XPmsP/s7uqDL8yPcbvU
 KoqzY3Sb7R4IIzTvf6DBYxDHm/ktDNGAVlDFRO6Khy19uInRsXSSxF38d2Mu23BPaD4V
 6Dtw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780045953; x=1780650753; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qtCQR2z1HBeGEoJFtbxgUqwRdyhzaoV0GIg+kYKHcUo=;
 b=f5D7raiEvY6Yeyaw716YmA11upPDJ0X0xlryoDoYSUx8aplwWDL747eZ0OgjO0jHew
 NPJ4O7QKtqKW+NUeLArTstqhM00MDhkvoeBDvSwb63WrtkB4QiVmjte6a2vNk59Aw3PJ
 h75MUQzxgUOzrBFXtYpGOrKZYIb427GVtrseuO3tXmd8LO+7ChHMq2LuBVNh+I+J+FOk
 Y6sg12uxHRMTW5JmNF4AVsSOWZvOpjYilZAeMVLcI4J10eodUooxl5PBhPGlQrq2mfR+
 KSJ72sOmJM2yQW5sjqind+076JmHLOCg7IeoFmvJ1o1bKmdPOC65Lc7hTMGPINaoxRDv
 dJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780045953; x=1780650753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qtCQR2z1HBeGEoJFtbxgUqwRdyhzaoV0GIg+kYKHcUo=;
 b=VIpzdpdH60rfq/ACXP6YlbukF71gIq5UzjNdPQqhdNke5OmkCPAbd+KpBcRzbf7wqZ
 RJtVwUzRnf/YbC59U2Lz4qzstyqH/1nr4Yi+T0j58CqvQ2Tvi7MTQxngSiWMUKSfU37t
 O7K1sX76sqxyY/bnF81JCZ/LUfHOkiAeOfM9TV8V6uAnnd9ZaHvfcXBX4xhMgWPfG3wT
 x0UTbH7W5MyRH6E0KSnW4v6n2HHZQin91wfpCyHibC+yEi5ybGt/4p3fsjGa9xK9rSdj
 BeydYeZWfcRerVxMKRyITV4qNDw0Th/X7fu2jkRYU4hFa9ABkqg3B+Ps8aZA7UJaW/hU
 3UqQ==
X-Gm-Message-State: AOJu0YyqQapbdd/U72MC37+x7IVfzpF2+PVD2HsHYeQd0BfORKCag0s5
 jVn6jc+OuMNdO82kx+52P/UaajQYKFGOLeYjFW90NubYD7nEuJddPOiH/nKVe2Z/1FYWuEaL8cQ
 3tne5fzBv7dUubhZeYGERxe0zpjT2/+12OFkPTWwS1g==
X-Gm-Gg: Acq92OFKWctBNUK0k19Fz+eik/gZCf6K5x5k9bOCmF6DsL0WYz2xQk0h1NWftlEMRBY
 xOSMK8IMCYQm2wauDmqbAXuf2GIWZ2nvqrwAjhuzDMe2aMpbo8BC5rKev81VDW7fRkQCI26hQ/7
 3I+FCpHYTQ37ibjqIrKW19sn0yFLnIoLJ5Mc9TZJRus60UVzJyHLw38sL7wtX93hoDaj4Y9bSbP
 qTlUdn9Apbiu6g/AjHfHwXMpEUqfvZmktf3HdJqRyEoYv776IO0PAxPoAzUqo4gr5S1+80IFGeQ
 Y0ydfSUBkd6oxSin1TnKdV61NznDgik6dBkNLmhxKsB+16pnAwRJZlJNaU3tNOKRWqUz93kODud
 55A==
X-Received: by 2002:a17:907:a46:b0:bc6:7238:bd57 with SMTP id
 a640c23a62f3a-be9c86942b9mr112136266b.7.1780045949264; Fri, 29 May 2026
 02:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1779986496.git.matyas.bobek@gmail.com>
In-Reply-To: <cover.1779986496.git.matyas.bobek@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2026 10:12:16 +0100
X-Gm-Features: AVHnY4KhEUSk7XrpZ3BKkDvyGLdiZKRjXxpeclgjJkw81EpXUhE9Gbsa7_piOWI
Message-ID: <CAFEAcA-diz0Bh1Ah87MPXxkDcvxF58tACTcxxJw68xtw8pTfLw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] hw/arm/sabrelite: Add FlexCAN support
To: =?UTF-8?B?TWF0ecOhxaEgQm9iZWs=?= <matyas.bobek@gmail.com>
Cc: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>, 
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>,
 qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Nikita Ostrenkov <n.ostrenkov@gmail.com>, Andrey Volkov <andrey@volkov.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Thu, 28 May 2026 at 18:17, Maty=C3=A1=C5=A1 Bobek <matyas.bobek@gmail.co=
m> wrote:
>
> This series adds emulation of the FlexCAN CAN controller, version 2,
> found in NXP i.MX6 series SoCs. The controller is integrated into
> fsl-imx6 and the Sabrelite ARM board.
>
> The chip has two FlexCAN controllers, but the Linux Sabrelite
> device tree enables only one by default. Linux kernel with both
> controllers enabled has been tested to work properly (using a custom
> device tree).
> See docs/system/devices/can.rst for an example of QEMU command line
> invocation.

If I run "make check" under a build with the clang sanitizers
enabled, the test fails with an array out of bounds access:

test:         qtest+qtest-arm - qemu:qtest-arm/flexcan-test
start time:   08:46:34
duration:     3.22s
result:       killed by signal 6 SIGABRT
command:      QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-stor=
age-daemon
QTEST_QEMU_VNC_BINARY=3D./tools/qemu-vnc/qemu-vnc MESON_TEST_ITERATION=3D1
MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print=
_stacktrace=3D1
QTEST_QEMU_BINARY=3D./qemu-system-arm RUST_BACKTRACE=3D1
PYTHON=3D/home/pm215/qemu/build/arm-clang/pyvenv/bin/python3
MALLOC_PERTURB_=3D136
UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:prin=
t_stacktrace=3D1
G_TEST_DBUS_DAEMON=3D/home/pm215/qemu/tests/dbus-daemon.sh
QTEST_QEMU_IMG=3D./qemu-img
ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1
/home/pm215/qemu/build/arm-clang/tests/qtest/flexcan-test --tap -k
----------------------------------- stdout --------------------------------=
---
TAP version 13
# random seed: R02S02bc6ca307d8afe2f7478a86cd8f0c6a
1..5
# Start of arm tests
# Start of net tests
# Start of flexcan tests
# starting QEMU: exec ./qemu-system-arm -qtest
unix:/tmp/qtest-3845367.sock -qtest-log /dev/null -chardev
socket,path=3D/tmp/qtest-3845367.qmp,id=3Dchar0 -mon
chardev=3Dchar0,mode=3Dcontrol -display none -audio none -run-with
exit-with-parent=3Don -nographic -M sabrelite -object can-bus,id=3Dqcan0
-machine canbus0=3Dqcan0 -machine canbus1=3Dqcan0  -accel qtest
ok 1 /arm/net/flexcan/linux_probe
# starting QEMU: exec ./qemu-system-arm -qtest
unix:/tmp/qtest-3845367.sock -qtest-log /dev/null -chardev
socket,path=3D/tmp/qtest-3845367.qmp,id=3Dchar0 -mon
chardev=3Dchar0,mode=3Dcontrol -display none -audio none -run-with
exit-with-parent=3Don -nographic -M sabrelite -object can-bus,id=3Dqcan0
-machine canbus0=3Dqcan0 -machine canbus1=3Dqcan0  -accel qtest
ok 2 /arm/net/flexcan/freeze_disable_interaction
# starting QEMU: exec ./qemu-system-arm -qtest
unix:/tmp/qtest-3845367.sock -qtest-log /dev/null -chardev
socket,path=3D/tmp/qtest-3845367.qmp,id=3Dchar0 -mon
chardev=3Dchar0,mode=3Dcontrol -display none -audio none -run-with
exit-with-parent=3Don -nographic -M sabrelite -object can-bus,id=3Dqcan0
-machine canbus0=3Dqcan0 -machine canbus1=3Dqcan0  -accel qtest
----------------------------------- stderr --------------------------------=
---
../../hw/net/can/flexcan.c:305:24: runtime error: index 80 out of
bounds for type 'FlexcanRegsMessageBuffer[64]' (aka 'struct
FlexcanRegsMessageBuffer[64]')
    #0 0x5b5c6378e3c9 in flexcan_get_last_enabled_mailbox
/home/pm215/qemu/build/arm-clang/../../hw/net/can/flexcan.c:305:24
    #1 0x5b5c6378a9a1 in flexcan_mb_write
/home/pm215/qemu/build/arm-clang/../../hw/net/can/flexcan.c:700:30
    #2 0x5b5c6378a9a1 in flexcan_mem_write
/home/pm215/qemu/build/arm-clang/../../hw/net/can/flexcan.c:1232:17
    #3 0x5b5c63c6de46 in memory_region_write_accessor
/home/pm215/qemu/build/arm-clang/../../system/memory.c:492:5
    #4 0x5b5c63c6d3cd in access_with_adjusted_size
/home/pm215/qemu/build/arm-clang/../../system/memory.c:568:18
    #5 0x5b5c63c6ce92 in memory_region_dispatch_write
/home/pm215/qemu/build/arm-clang/../../system/memory.c
    #6 0x5b5c63ca7008 in flatview_write_continue_step
/home/pm215/qemu/build/arm-clang/../../system/physmem.c:3263:18
    #7 0x5b5c63c9e5b6 in flatview_write_continue
/home/pm215/qemu/build/arm-clang/../../system/physmem.c:3293:19
    #8 0x5b5c63c9e5b6 in flatview_write
/home/pm215/qemu/build/arm-clang/../../system/physmem.c:3324:12
    #9 0x5b5c63c9e4a8 in address_space_write
/home/pm215/qemu/build/arm-clang/../../system/physmem.c:3444:18
    #10 0x5b5c63caf690 in qtest_process_command
/home/pm215/qemu/build/arm-clang/../../system/qtest.c
    #11 0x5b5c63cacb8d in qtest_process_inbuf
/home/pm215/qemu/build/arm-clang/../../system/qtest.c:778:9
    #12 0x5b5c646888b7 in tcp_chr_read
/home/pm215/qemu/build/arm-clang/../../chardev/char-socket.c:511:13
    #13 0x7d3004bd245d
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d45d) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #14 0x7d3004bd26cf in g_main_context_dispatch
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d6cf) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #15 0x5b5c64866a4b in glib_pollfds_poll
/home/pm215/qemu/build/arm-clang/../../util/main-loop.c:290:9
    #16 0x5b5c64866a4b in os_host_main_loop_wait
/home/pm215/qemu/build/arm-clang/../../util/main-loop.c:313:5
    #17 0x5b5c64866a4b in main_loop_wait
/home/pm215/qemu/build/arm-clang/../../util/main-loop.c:592:11
    #18 0x5b5c63cb5cd6 in qemu_main_loop
/home/pm215/qemu/build/arm-clang/../../system/runstate.c:950:9
    #19 0x5b5c647026bb in qemu_default_main
/home/pm215/qemu/build/arm-clang/../../system/main.c:50:14
    #20 0x5b5c64702693 in main
/home/pm215/qemu/build/arm-clang/../../system/main.c:93:9
    #21 0x7d300282a1c9 in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #23 0x5b5c63077684 in _start
(/home/pm215/qemu/build/arm-clang/qemu-system-arm+0x1546684) (BuildId:
46de6576c6cf821195d15a70a05dd4e75e97f22d)

SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
../../hw/net/can/flexcan.c:305:24
Broken pipe
../../tests/qtest/libqtest.c:210: kill_qemu() detected QEMU death from
signal 6 (Aborted) (core dumped)



You can do a sanitizer enabled build by running configure with options like=
:

'--cc=3Dclang' '--cxx=3Dclang++' '--enable-ubsan'

and then run 'make check' as normal.


You can also do a build with the address sanitizer enabled
as well, but it's a little bit more involved:

'../../configure' '--cc=3Dclang' '--cxx=3Dclang++' '--enable-ubsan'
'--enable-asan'
'--target-list=3Darm-softmmu,arm-linux-user,aarch64-softmmu,aarch64-linux-u=
ser'

For an asan build, you will need to set ASAN_OPTIONS and LSAN_OPTIONSwhen
running make check, like this:

TIMEOUT_MULTIPLIER=3D3 ASAN_OPTIONS=3D"fast_unwind_on_malloc=3D0"
LSAN_OPTIONS=3D"suppressions=3D$PWD/scripts/lsan_suppressions.txt" make -C
build/arm-san/ -j15 check

(Current head-of-git has a leak in the tpm-tis device which is
fixed by this patch:
https://patchew.org/QEMU/20260528093123.55403-1-mbawa@redhat.com/
That should get upstream shortly, but if you don't have it yet
you'll also see leak reports about that.)

thanks
-- PMM

