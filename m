Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C43CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 07:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utLnQ-00077T-F4; Tue, 02 Sep 2025 03:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLnJ-00075t-GW
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:51:11 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLnH-0001vh-4q
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:51:09 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-77256200f1bso1374371b3a.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 00:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756799465; x=1757404265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DBrgRzoZK/flg18sYa71Nd0Qxl3OyImP8+lDbDt1BL8=;
 b=or3t34lKPfugCa+JELM6RBKRqzPsSwbhyTMPldUrNADEq4MlYE3OVZXm8cRUoPNR5j
 fKEkKCV0IVgvPxlBiCYn9BYNWv0Cq/yw3bKrL8B89RawiyCKEn0HQwmXtAgU7mbzcSrS
 E7Hh2nrCU8gXscnGQZIIgcb/jyYziqYq5g/tFJdA3NyxjooBeaFXoPs3h5oKmFRSnA1t
 NvCwQ1Eko/sdbeRLlZrSJBA+WyRl96lrfTn/jasmcrEazHYMAlD8y9mDjWmkzQmzFJW5
 wpt2Q4pPsnJOM9ogRQs6m4dWyWSrXDHlVxNSwc0FHu/sdX+nPEePfyq4ZB48v1xpy16A
 9eEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756799465; x=1757404265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DBrgRzoZK/flg18sYa71Nd0Qxl3OyImP8+lDbDt1BL8=;
 b=kVYl4CUmS7aTdTBWfWSyRaIOccIX0dxghngf8UKvYdzuhdOiFEsu/P2kgCUNUkqAS4
 dcn1aYnzqhVgNJX+G132lXz1SF7Tz3H4WrQnS5KgUFwsY1XU4gfI8pUY4sXEqVisH8p6
 HmgZtfJGLSZkUKkyb3ViDmiixCP9LtmItgBWI1QW6bOdC5carxjXs0dyGuG71s44kday
 ZiGh3Kfv3GoEAPwsRrQYNT42QSzH6GFkZbIB3QHPl6nKW2HSWIZog9QBHlJoGFIPqTBd
 bsmUzqUx+444jZU8sVlXKq08wZjP158ngGUGE0woWMaxLoW4WJQfHAcMvzLpzR7zMSr8
 8oAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbnnkLE2C1+8K8uhDAeqQSG4kC4vaoDrPAZSMjrhFSN4oSYxLxVZj6dK9qDkq4TKmJP0oDU3biGVdz@nongnu.org
X-Gm-Message-State: AOJu0Yx9jphbv/4YLwGMUugEraF3dIK/11gAr7WMXRjYZlvAruYAsk9t
 kZo3ikiutL3M/wg1PxW7GnSZRbY/EEIRG1ZxoSpdjG+dU+4g388QswLKq+kkSVKuyfI=
X-Gm-Gg: ASbGncuudiJ9bCWlVXlfYFIJwQRWXvO5c4P9EHiYqZfGdvKrLOtPnvl8toKaa6L565P
 FdXC9sN/sSNqm+kO0tq14jpqPAQVMkGbTQs+r1aQxpSBc0WTst0ciDZudPllm8HQ5BGJrSdFGku
 CnMT95F59CnOKkt3PHEqXPVEZKrhCUqvugwl/heuTIlcsoCd2VTy7gXIeoJLPfBESiJZII4q9Wr
 OjyZzQOGAojT6TY883AdbLux9k8/5XaB7RUwA1WkVnx8Zm7Hb1tgfn8WIfIkHaoGfLfDklMXf9k
 wz8LmoouI5QHXblMtDJHcNVV366P61Rz7gguKUWd6wDRmQ5lCAyrceRSvh8fwTg3Ypc5377wIxO
 /hgN+YtT/YEWkgScGrhz7ut6YrPmGHOmkxOp4g7XO0tA=
X-Google-Smtp-Source: AGHT+IGR4sHy8t2PnRVc23rwX8Q8qGI/pwUIR6Ijnt7tTtygvwtYy8LNLkv5rohjxEjfuAmQ+Pw0Jg==
X-Received: by 2002:a05:6a00:2306:b0:748:eedb:902a with SMTP id
 d2e1a72fcca58-7723e362814mr13297381b3a.17.1756799464561; 
 Tue, 02 Sep 2025 00:51:04 -0700 (PDT)
Received: from pc.taild8403c.ts.net ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7723d79fcfesm9642766b3a.16.2025.09.02.00.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 00:51:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: pierrick.bouvier@linaro.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v7 9/9] contrib/plugins/uftrace: add documentation
Date: Tue,  2 Sep 2025 00:50:42 -0700
Message-ID: <20250902075042.223990-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250902075042.223990-1-pierrick.bouvier@linaro.org>
References: <20250902075042.223990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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
examples of the possibilities offered by it, in system and user mode.

As well, it explains how to rebuild and reproduce those examples.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/about/emulation.rst | 199 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 456d01d5b08..8a5e128f677 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -816,6 +816,205 @@ This plugin can limit the number of Instructions Per Second that are executed::
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
+Plugin supports aarch64 and x64, and works in user and system mode, allowing to
+trace a system boot, which is not something possible usually.
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
+necessarily for bare metal code. You can read this `section
+<uftrace_build_system_example>` to easily build a system with frame pointers.
+
+When tracing long scenarios (> 1 min), the generated trace can become very long,
+making it hard to extract data from it. In this case, a simple solution is to
+trace execution while generating a timestamped output log using
+``qemu-system-aarch64 ... | ts "%s"``. Then, ``uftrace --time-range=start~end``
+can be used to reduce trace for only this part of execution.
+
+Performance wise, overhead compared to normal tcg execution is around x5-x15.
+
+.. list-table:: Uftrace plugin arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - trace-privilege-level=[on|off]
+    - Generate separate traces for each privilege level (Exception Level +
+      Security State on aarch64, Rings on x64).
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
+      build/contrib/plugins/libuftrace.so \
+      ./build/qemu-aarch64 /usr/bin/git --help
+
+    # and generate a chrome trace directly
+    $ uftrace dump --chrome | gzip > ~/qemu_aarch64_git_help.json.gz
+
+For convenience, you can download this trace `qemu_aarch64_git_help.json.gz
+<https://fileserver.linaro.org/s/N8X8fnZ5yGRZLsT/download/qemu_aarch64_git_help.json.gz>`_.
+Download it and open this trace on https://ui.perfetto.dev/. You can zoom in/out
+using :kbd:`W`, :kbd:`A`, :kbd:`S`, :kbd:`D` keys.
+Some sequences taken from this trace:
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
+executed for all privilege levels, and zoom in/out using
+:kbd:`W`, :kbd:`A`, :kbd:`S`, :kbd:`D` keys. You can find below some sequences
+taken from this trace:
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
+.. _uftrace_build_system_example:
+
+Building a full system image with frame pointers is not trivial.
+
+We provide a `simple way <https://github.com/pbo-linaro/qemu-linux-stack>`_ to
+build an aarch64 system, combining Arm Trusted firmware, U-boot, Linux kernel
+and debian userland. It's based on containers (``podman`` only) and
+``qemu-user-static (binfmt)`` to make sure it's easily reproducible and does not depend
+on machine where you build it.
+
+You can follow the exact same instructions for a x64 system, combining edk2,
+Linux, and Ubuntu, simply by switching to
+`x86_64 <https://github.com/pbo-linaro/qemu-linux-stack/tree/x86_64>`_ branch.
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
+      -plugin path/to/contrib/plugins/libuftrace.so,trace-privilege-level=on |&
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
 
-- 
2.47.2


