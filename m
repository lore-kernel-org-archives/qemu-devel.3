Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EA6C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 05:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubumf-0007Fb-3M; Wed, 16 Jul 2025 01:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubumc-00074H-Ld
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 01:34:22 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubuma-0007se-1e
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 01:34:22 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-748e81d37a7so3773057b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 22:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752644058; x=1753248858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wasM4fPfefe8yCV5m/8wwSU7LP5OnhI1b90/+w6CwIM=;
 b=dAoPbp4od4qwcnwvLqWddaPVBUtSdFd/yItZRd6IjEDBv94+9YVj0FfPTr9+/VZ86j
 0AdbiTUN3d7wi7zdEuDgOa+opILf5LdYN0IeJh/cvovN487hgzzVxvWj9wk9vRTLjbmW
 rtr3POs9zqa2LOp5pbEJjVEiYcre44PUvKMOLjGOkQcWrAuQiu295JQEQYCF66QF0pjs
 drjKORnS/1c93wZjf3tZVUDoJ3QvurwqYirlcMouSd7CCfgraDP62d7v7DFFo9ERoeIb
 uHWUkVnFRK0SvY1taPazm7V4z05kx0A1o/JRVD3+asC1aiqRJYKKtj6qnYkgfirMzr2I
 LMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752644058; x=1753248858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wasM4fPfefe8yCV5m/8wwSU7LP5OnhI1b90/+w6CwIM=;
 b=igAn3gQHfjgKI+n19hdWs30y25PXi/r5IJXPR9AwawxCD+gM5aixkWluStcvWDhFMD
 437YgEYwyx+n/fA5FgkmiuSGNOBBBbyAX8480jJ/1kdORIYR7RIgH9GDY+sYYrd9coj+
 vUSafTospAP378vE/FdaBoPYTqISEpQqA8RcDDfFFEoSJZvpZHttVJTyyxCtUxfvctr0
 XXcJTbS/5GoRZJQgLa6RdinzDHihO/RoxR3Kq+MNfzJjeAHKuS5/X/4k+6zkVzBuh0OC
 vXDa7fW0YopdWWwANMs+vksjidRlJHp722hMSlZmkfPr0VqGU99GdXCUt9BzcOGEg3F+
 aHmw==
X-Gm-Message-State: AOJu0YzIKN2tIDu7b3wR8hPYXyaeL+1Tmo6uhdlp6N647OjEfXs0ntjT
 2OPbY1+o9cTD65UlKpeOWVIaeLN1u8fgRox9+Pusz/bN9utAdmQyd568DqW4Vws09bB20hVpWKv
 UXtp+
X-Gm-Gg: ASbGncunb/vm1mql8pi+YX86awxnO1lEa+5LdHvN5FzMsv6oMzEzLVyT1tFD3k4xlG9
 F7gUhIwUzCdbm3aPpJNbewk4Hn0ojYx6pnkpx2YxxQCT84Vq3Rk2zn2fsUCtcI/rNUlxNzRSgQ6
 RQJOBfE5bkN74j/OiBJQrYYEaN41KMYZ0GYPYxXJv/4f4v5KGA5J6uDCklpWcQKP+LrKu/+iDjP
 he87U/sAqdHhBMjqUeOudoFIzfL/D5lcNr18PMSL0YZujrAJrN2Wwa8IwCq44GJp/mkC/TxlSuy
 onlnQoCi10dh64k6E2zSOQpV0+v/KH0wFzCZ03yGJtKro8h5Ni/0ve5XVlKKCh0fBfrwOeW2l1N
 2lyQOb4nC7uSiFLJuMcVazQ/VX3XHQuxv
X-Google-Smtp-Source: AGHT+IFLwHudL9d9qW6U7bWLmI6I4KSEOMPOt2iTDvqWbbXbh9ySEdZpDRhRbczUuaEPDf7pHSTRgw==
X-Received: by 2002:a05:6a00:b70f:b0:748:e150:ac5c with SMTP id
 d2e1a72fcca58-756ea8b92dcmr2947582b3a.23.1752644058042; 
 Tue, 15 Jul 2025 22:34:18 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9e06aa6sm13790162b3a.62.2025.07.15.22.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 22:34:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 6/6] contrib/plugins/uftrace: add documentation
Date: Tue, 15 Jul 2025 22:34:07 -0700
Message-ID: <20250716053407.2814736-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250716053407.2814736-1-pierrick.bouvier@linaro.org>
References: <20250716053407.2814736-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

This documentation summarizes how to use the plugin, and present two
examples of the possibilities offered by it.

As well, it explains how to rebuild and reproduce easily the system boot
example.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/about/emulation.rst  | 184 ++++++++++++++++++++++++++++++++++++++
 contrib/plugins/uftrace.c |   2 +
 2 files changed, 186 insertions(+)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 456d01d5b08..93921b12ae9 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -816,6 +816,190 @@ This plugin can limit the number of Instructions Per Second that are executed::
       The lower the number the more accurate time will be, but the less efficient the plugin.
       Defaults to ips/10
 
+Uftrace
+.......
+
+``contrib/plugins/uftrace.c``
+
+This plugin generates a binary trace compatible with
+`uftrace <https://github.com/namhyung/uftrace>`_.
+
+Plugin supports aarch64 only (x64 support should be trivial to add), and works
+in user and system mode, allowing to trace a system boot, which is not something
+possible usually.
+
+In user mode, the memory mapping is directly copied from ``/proc/self/maps`` at
+the end of execution. Uftrace should be able to retrieve symbols by itself,
+without any additional step.
+In system mode, the default memory mapping is empty, and you can generate
+one (and associated symbols) using ``contrib/plugins/uftrace_symbols.py``.
+Symbols must be present in ELF binaries.
+
+It tracks the call stack (based on frame pointer analysis). Thus, your program
+and its dependencies must be compiled using ``-fno-omit-frame-pointer
+-mno-omit-leaf-frame-pointer``. In 2024, `Ubuntu and Fedora enabled it by
+default again on x64
+<https://www.brendangregg.com/blog/2024-03-17/the-return-of-the-frame-pointers.html>`_.
+On aarch64, this is less of a problem, as they are usually part of the ABI,
+except for leaf functions. That's true for user space applications, but not
+necessarily for bare metal code.
+
+Timestamps used for events are the number of instructions executed so far by
+default. As it's tracked per vcpu, each timeline should be considered
+separately. It's possible to use real timestamps by using option
+``timestamp-based-on-real-time``. This is not the default, as considering real
+time when doing emulation and instrumentation may not necessarily report correct
+things.
+
+Performance wise, overhead compared to normal tcg execution can vary from x2
+(sampling only) to x10-x15 (precise stack tracking).
+
+.. list-table:: Uftrace plugin arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - trace-privilege-level=[on|off]
+    - Generate one trace per privilege level (Exception Level + Security State
+      on aarch64).
+  * - trace-sample=N
+    - Instead of precise tracking, perform stack sampling every N instructions.
+      If combined with ``trace-privilege-level``, it will still contain precise
+      stacks for privilege level changes, and will sample stack between those.
+  * - timestamp-based-on-real-time=[on|off]
+    - Use real time for timestamps instead of number of instructions executed.
+
+.. list-table:: uftrace_symbols.py arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - elf_file [elf_file ...]
+    - path to an ELF file. Use /path/to/file:0xdeadbeef to add a mapping offset.
+  * - --prefix-symbols
+    - prepend binary name to symbols
+
+Example user trace
+++++++++++++++++++
+
+As an example, we can trace qemu itself running git::
+
+    $ ./build/qemu-aarch64 -plugin \
+      build/contrib/plugins/libuftrace.so,timestamp-based-on-real-time=on \
+      ./build/qemu-aarch64 /usr/bin/git --help
+
+    # and generate a chrome trace directly
+    $ uftrace dump --chrome | gzip > ~/qemu_aarch64_git_help.json.gz
+
+For convenience, you can download this trace `qemu_aarch64_git_help.json.gz
+<https://fileserver.linaro.org/s/N8X8fnZ5yGRZLsT/download/qemu_aarch64_git_help.json.gz>`_.
+Download it and open this trace on https://ui.perfetto.dev/. You can zoom in/out
+using w,a,s,d keys. Some sequences taken from this trace:
+
+- Loading program and its interpreter
+
+.. image:: https://fileserver.linaro.org/s/fie8JgX76yyL5cq/preview
+   :height: 200px
+
+- open syscall
+
+.. image:: https://fileserver.linaro.org/s/rsXPTeZZPza4PcE/preview
+   :height: 200px
+
+- TB creation
+
+.. image:: https://fileserver.linaro.org/s/GXY6NKMw5EeRCew/preview
+   :height: 200px
+
+It's usually better to use ``uftrace record`` directly. However, tracing
+binaries through qemu-user can be convenient when you don't want to recompile
+them (``uftrace record`` requires instrumentation), as long as symbols are
+present.
+
+Example system trace
+++++++++++++++++++++
+
+A full trace example (chrome trace, from instructions below) generated from a
+system boot can be found `here
+<https://fileserver.linaro.org/s/WsemLboPEzo24nw/download/aarch64_boot.json.gz>`_.
+Download it and open this trace on https://ui.perfetto.dev/. You can see code
+executed for all privilege levels, and zoom in/out using w,a,s,d keys. You can
+find below some sequences taken from this trace:
+
+- Two first stages of boot sequence in Arm Trusted Firmware (EL3 and S-EL1)
+
+.. image:: https://fileserver.linaro.org/s/kkxBS552W7nYESX/preview
+   :height: 200px
+
+- U-boot initialization (until code relocation, after which we can't track it)
+
+.. image:: https://fileserver.linaro.org/s/LKTgsXNZFi5GFNC/preview
+   :height: 200px
+
+- Stat and open syscalls in kernel
+
+.. image:: https://fileserver.linaro.org/s/dXe4MfraKg2F476/preview
+   :height: 200px
+
+- Timer interrupt
+
+.. image:: https://fileserver.linaro.org/s/TM5yobYzJtP7P3C/preview
+   :height: 200px
+
+- Poweroff sequence (from kernel back to firmware, NS-EL2 to EL3)
+
+.. image:: https://fileserver.linaro.org/s/oR2PtyGKJrqnfRf/preview
+   :height: 200px
+
+Build and run system example
+++++++++++++++++++++++++++++
+
+Building a full system image with frame pointers is not trivial.
+
+We provide a `simple way <https://github.com/pbo-linaro/qemu-linux-stack>`_ to
+build an aarch64 system, combining Arm Trusted firmware, U-boot, Linux kernel
+and debian userland. It's based on containers (``podman`` only) and
+``qemu-user-binfmt`` to make sure it's easily reproducible and does not depend
+on machine where you build it.
+
+To build the system::
+
+    # Install dependencies
+    $ sudo apt install -y podman qemu-user-binfmt
+
+    $ git clone https://github.com/pbo-linaro/qemu-linux-stack
+    $ cd qemu-linux-stack
+    $ ./build.sh
+
+    # system can be started using:
+    ./run.sh /path/to/qemu-system-aarch64
+
+To generate a uftrace for a system boot from that::
+
+    # run true and poweroff the system
+    $ env INIT=true ./run.sh path/to/qemu-system-aarch64 \
+      -plugin path/to/contrib/plugins/libuftrace.so,trace-privilege-level=on
+
+    # generate symbols and memory mapping
+    $ path/to/contrib/plugins/uftrace_symbols.py \
+      --prefix-symbols \
+      arm-trusted-firmware/build/qemu/debug/bl1/bl1.elf \
+      arm-trusted-firmware/build/qemu/debug/bl2/bl2.elf \
+      arm-trusted-firmware/build/qemu/debug/bl31/bl31.elf \
+      u-boot/u-boot:0x60000000 \
+      linux/vmlinux
+
+    # inspect trace with
+    $ uftrace replay
+
+Uftrace allows to filter the trace, and dump flamegraphs, or a chrome trace.
+This last one is very interesting to see visually the boot process::
+
+    $ uftrace dump --chrome > boot.json
+    # Open your browser, and load boot.json on https://ui.perfetto.dev/.
+
 Other emulation features
 ------------------------
 
diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 7bf658311b1..a040fc6ad1f 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -4,6 +4,8 @@
  * Generates a trace compatible with uftrace (similar to uftrace record).
  * https://github.com/namhyung/uftrace
  *
+ * See docs/about/emulation.rst|Uftrace for details and examples.
+ *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-- 
2.47.2


