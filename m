Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75798C87FCF
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 02:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukCVz-0008JS-QB; Thu, 07 Aug 2025 22:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukCVv-0008A5-Ab
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 22:07:23 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukCVt-0003VK-0R
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 22:07:23 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7682560a2f2so1861081b3a.1
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 19:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754618838; x=1755223638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ARdLG0RyBcqXqMc7SaUdtHrarx6Ntm3n+KKS568/t4=;
 b=sZMC7yu408y5I/brtnkx58T8cQsz9g65j029wbKUOSzRM4XnLfiUy6QbRjIe+S+N/H
 0T8RuJfRaCmkSCoC/a18sudSIRR9d2T2CJxx4earurrXzW/ag0BvrZKprq709pWt8fkK
 kpB+bPs1UKhmFDk6QXe2KmG/ttqIcrOhYvwmU//Ihd3ONwnD/C8gAJ4xuM/RlHCNX+FF
 zh9CQq6eRNtPz36sq+qH0Jhe+D3DTZZBiuoF9lX3Zw+chSDsGOc3eytHFlq4hZm3HsKv
 +eLotnl90M3Hh6dJvOjGGghoVmSU+1bERZVA9GyKSe5beAPKfcByDge+Cirxfr0WIzv/
 FHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754618838; x=1755223638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ARdLG0RyBcqXqMc7SaUdtHrarx6Ntm3n+KKS568/t4=;
 b=tVjlVmf3UEopTbeHocO6hTD6GMosOfLj9hwSewFLJ6hQVIMeZGjsAY1j1luuC2MIFk
 kKhk8g74sSZ5MgcZJA//f/Adlqg/kV6I1ZYTQrgvqe28lIKHptOvI7aQCOskWX6j8xrB
 KwleC8T6c2TyhG37AKAE5F1WXflBjV/T5gP7V9ZiudEFns8ZcHh9CxH3eYvnIYJSmx5F
 bEGCEn4LH14dO9xb/kz8SvivdhNhwU4I5LAODD/LYIZD1zQX2mngALkWwI9znoDhuzab
 c+/C9iD83sRjyH1ASdN4xRqx42jQt/xXzkybwl7wPw14ubnbMsFzrpauuzd/7Xxfkds1
 9gHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgoteLelM5Dcvw444pIhPXfGx1+kDJP3kSq4GGsChJfGxiY344ptJPEi7t8lCvbaGH7PNnF9sn/R2h@nongnu.org
X-Gm-Message-State: AOJu0YxZKDTJHRcGhCWv2RAhhaCb3Psh2sIB4n2XNysCM/8byDy23s/l
 1pRIn5yGZHV43ZT3MAxMZ5UcYB051IMRXmhhNQuYAEs2JuLl14FksVsiniBIpil9reE=
X-Gm-Gg: ASbGncuCIyZH9gpMmtUpEY9TlPQ1F6+Cf2yTZqWwvdbnPlC1Rs+9k6xz6MYlOtIXgjE
 AlwljbEndReIUONEQOou6k5Ou0dU1MKMfpjjJmLqz0ThwSrkWiMQbvN4mGxA7HNPz8bkR6em9qQ
 ID4mSHx19Hs44yrYI+7VRfdo/1ulOwyon4CoIXKqg30zn49ZYqSwLJy+9JCwqqvxhwyq1gDIyMx
 KX9oURA1Cw5hRj5pgDlXdqDSPcWvXZlL1a+YsoOr1Ydq0eitGAJJaHWcXVXnSAcqER7FGLoo9Xw
 9qmFS4dqXGbUsAiGFO/PlLaOdKBUIWiwJvtJkj8acH74Z30QhlBTLWLVoMtX69CMeYZJqM5x6ew
 LT53vkohEUNZFv3MXVNT51A==
X-Google-Smtp-Source: AGHT+IHd3ivCqaR1MQax7iSHr8Y+34lWcIn9f7N4VqL28+f0ITqBaF1B1eiktZmQ3uw5aUkiJcK77A==
X-Received: by 2002:a05:6a20:258c:b0:240:f4c:cde6 with SMTP id
 adf61e73a8af0-2404117b827mr8617498637.5.1754618837922; 
 Thu, 07 Aug 2025 19:07:17 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b428ba4cf35sm3705433a12.14.2025.08.07.19.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 19:07:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: pierrick.bouvier@linaro.org,
	qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 9/9] contrib/plugins/uftrace: add documentation
Date: Thu,  7 Aug 2025 19:07:02 -0700
Message-ID: <20250808020702.410109-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/about/emulation.rst | 197 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 456d01d5b08..9ce47ac2712 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -816,6 +816,203 @@ This plugin can limit the number of Instructions Per Second that are executed::
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


