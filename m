Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059E5C87FC5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 20:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf2pD-0005Cs-EJ; Thu, 24 Jul 2025 16:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uf2p7-00057E-88
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:45:53 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uf2p2-0007N3-KM
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:45:52 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-311e46d38ddso1282608a91.0
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 13:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753389941; x=1753994741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+l8Oaz4ADqnYHLgGIIAMGhUfDq/S7zi6obmicPSjKAo=;
 b=YcfgBV1H4t6U0cCCzwqLA+qzQDiQi6PD2yPh/VCK2+l2KDG5Wo7A3nJCI3ybTj3gh5
 dU5dAIfC5BPDU3YePUndBncEsjtX4GROjztY41X7vXl9kl7xsIJd1We1GgJ4NgVi432a
 UAfL2flmCKGNIzJ/yUHBmSXK9v7gL4RD3b5QVpl7adPV6pSXr8bjrEedpZ6+ty58cshz
 cKRe3rMKj3/XhBYbUQEzzqA/9RSUr91joG6Rv/5w4c6CBavM1Al5U1dscpT682MIErNB
 1l3hyb1AgngDY+6taiJcJ9x3wgxl15QjVRQbXhTnzObfNCf3Z2sGHTI7styLs6vudCEE
 6ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753389941; x=1753994741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+l8Oaz4ADqnYHLgGIIAMGhUfDq/S7zi6obmicPSjKAo=;
 b=txxITtowpeHSLLyN3AkXWyOa41IP7TwKaIGUCMqjRoO8EIUh8Fbis3M5BYUX/fi35o
 HzUZvPamMDZdGl0g6rTh0+gRbr3cCWaXmSUQt3qAFr+CHE6XpI37LzNYIfjHICKTdsnc
 msXdqRE1nlbNu1so6HdR963v2PL30JJhdlD2C6MTgefW7/veq+ejrUn6nsqjwUz1vldx
 wOo8mG1t53dn7oeZne1qat+473YeuQvLf86rBtfz2LgJ2ND7T8B02M9UahQbdQepipPy
 esWTvzduEWhWwb2P5wd/kicf6D8l2WqAWGUV7JAwGPI0u3M9aLbFg8EkkZVyTNgALwLW
 o2bQ==
X-Gm-Message-State: AOJu0YxWCPbOgVrGlcoRIY97XPU/xwyHPFOWUsF5l0XFWQi4Cf5jHrAC
 CTQuL/skSlhHLEb1AhXpcAU8HhOWIH2fVxTlXNIEWXdqDv0Eu7I0ozJELUsamq4FWWVTfuXECEU
 WYnCx
X-Gm-Gg: ASbGncu+hsLG4gyyYpPmj6er0BkHjcMpLPt485wn8MyOzSErSBTVquQUUn+Nqfj6iTw
 GU+ru7zbfMdSkqjLYDmINFqq6XVFOkkO+4JH4kUXDNMw315/KJFP8q+hbV749iHGKWsnVhfsM19
 bkSzroUp8dW/wRxeowPA1wCxG+QJXWW5MQBcL/CX8seeYS5J8vtvDYrnAbClqPnEkPJcBg3Lj8z
 B8cH2KI/NIqVdYwHmbXUP+tVfGawxz/i5+62NPWm4OabxUQ1E4eGp0ryJE5yJ7KThOyNX70ip2Y
 uP6at5/B8L5nXFSGbxV8RDF2p8iCxB/8p/K6ylMi0zrtgtrR2lK3YSo6R6uQqt/PfEdN2e4V2oC
 cH+G6DaCPsV6NbhWsMQgDnb4lRBH89Gwo
X-Google-Smtp-Source: AGHT+IFFjHy0WonHo6fbF213MWhnJoKlLeWshrqQEjSYxnp6EyodoFCh25ypMPywGDU7rnypd86J3A==
X-Received: by 2002:a17:90b:4b0f:b0:311:d258:3473 with SMTP id
 98e67ed59e1d1-31e5076a94emr10724866a91.13.1753389940493; 
 Thu, 24 Jul 2025 13:45:40 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662f6be0sm2008849a91.35.2025.07.24.13.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 13:45:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, rowan Hart <rowanbhart@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 6/7] contrib/plugins/uftrace: add documentation
Date: Thu, 24 Jul 2025 13:45:25 -0700
Message-ID: <20250724204527.3175839-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724204527.3175839-1-pierrick.bouvier@linaro.org>
References: <20250724204527.3175839-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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
 docs/about/emulation.rst  | 207 ++++++++++++++++++++++++++++++++++++++
 contrib/plugins/uftrace.c |   2 +
 2 files changed, 209 insertions(+)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 456d01d5b08..118f059711f 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -816,6 +816,213 @@ This plugin can limit the number of Instructions Per Second that are executed::
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
+things. However, it is quite useful when running multiple cpus scenarios, or if
+you want to generate a trace around a particular time of the execution.
+
+When tracing long scenarios (> 1 min), the generated trace can become very long,
+making it hard to extract data from it. In this case, a simple solution is to
+trace execution using ``timestamp-based-on-real-time=on``, and generate a
+timestamped output log using ``qemu-system-aarch64 ... | ts "%s"``. Then,
+``uftrace --time-range=start~end`` can be used to reduce trace for only this
+part of execution.
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
+``qemu-user-static (binfmt)`` to make sure it's easily reproducible and does not depend
+on machine where you build it.
+
+To build the system::
+
+    # Install dependencies
+    $ sudo apt install -y podman qemu-user-static
+
+    $ git clone https://github.com/pbo-linaro/qemu-linux-stack
+    $ cd qemu-linux-stack
+    $ ./build.sh
+
+    # system can be started using:
+    $ ./run.sh /path/to/qemu-system-aarch64
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
+Long visual chrome traces can't be easily opened, thus, it might be
+interesting to generate them around a particular point of execution::
+
+    # execute qemu and timestamp output log
+    $ env INIT=true ./run.sh path/to/qemu-system-aarch64 \
+      -plugin path/to/contrib/plugins/libuftrace.so,trace-privilege-level=on,timestamp-based-on-real-time=on |&
+      ts "%s" | tee exec.log
+
+    $ cat exec.log  | grep 'Run /init'
+      1753122320 [   11.834391] Run /init as init process
+      # init was launched at 1753122320
+
+    # generate trace around init execution (2 seconds):
+    $ uftrace dump --chrome --time-range=1753122320~1753122322 > init.json
+
 Other emulation features
 ------------------------
 
diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 9211f273700..9cbadda0aae 100644
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


