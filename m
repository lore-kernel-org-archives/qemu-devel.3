Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2BDC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 20:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdy9y-0008BP-UN; Tue, 13 Aug 2024 16:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy9t-0007rA-Tm
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:30:21 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy9p-0007hO-Sj
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:30:21 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5af326eddb2so363823a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723581010; x=1724185810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/qnItM0U27UVVqG1z6IvgJtaIK4Kvloy70lZ6Kixi0=;
 b=fIJ4SzX1zihH4tIRKCBshNOqk7omZiJZ20vilw0ItpslrStbGTol7GysE7T8NsKwS9
 jNT3EoN1mB1rkMOSyLfx3AGKa+PDYuFIpQ0WaQ27shVdm2fMlT0G404F8y85cjE0kxMM
 67XHfnpvZT2k67jM4k2ljJ5jY79ydIh7TkSXG+zZuy5hyvzH80h/ouzdlaX955ibz7az
 6m4odo+YZltSbcU2P3MgH3HzCnm6qeR7NgVtjcZbTlMUAuwzpDsUrUNl3b6u7nt1Jz6o
 cRvX5KZ9Wcz7YC2lgzd8x7ztMAAE5OoQmNGDuo4a5wfy2ShPxetno7MLyqnPt4z0U5C6
 8t0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723581010; x=1724185810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U/qnItM0U27UVVqG1z6IvgJtaIK4Kvloy70lZ6Kixi0=;
 b=D81K6Cs/4NV4H6FfFLXiiaBpLolr2nhIZ1ABebYrBaXKmQHZPtxPS34gMytK6FLNXi
 FJfCd++22Ygjua6R3txz0lrRvV4kZMo2/qYi4FLk1rajQuJOXfVtLmXO1aCZ8TZL1GBh
 cUKedyXKC0H73rlCI3XlWsZTTDkVmpZoxYz/PbWRFjdAPrCR66+AGKCtXZ8Pv/WfIrLj
 udlt1kONOx5Rqwk0YKStIRIXZfhcnU58txSJyhwOkOQY8juVQDUaXF7y8krtLe6MYaiv
 IO4N0sDXAeKY1JQnKvLj1hXnwKCWfbzlkQhjqzMu+uoS30tywhrMuyERLbRXNPgcDMFI
 eyxQ==
X-Gm-Message-State: AOJu0YyXRvxfy7OIupxQzcARual9jRvTCPW/MwDuhuCthAimyJfp9OqP
 mpxcDKYNqh4g2uYcivyIDHoH63o1cjR7Q34a+XIYD7MC2+itaoawX2lJ2/IXdx4=
X-Google-Smtp-Source: AGHT+IH9uzjvTYPVpT3Br+bjN6brxJD3Redqyexys/XEKFirexgpF1o3kViF9C5go3TtT0azwtoqOA==
X-Received: by 2002:a17:907:f729:b0:a7d:c352:c502 with SMTP id
 a640c23a62f3a-a8362d64c1emr74542666b.30.1723581009952; 
 Tue, 13 Aug 2024 13:30:09 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3fb3581sm95891166b.88.2024.08.13.13.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 13:30:09 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 61C4060642;
 Tue, 13 Aug 2024 21:23:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Michael Roth <michael.roth@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Weiwei Li <liwei1518@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eric Auger <eric.auger@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Peter Xu <peterx@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH v2 20/21] docs/devel: update tcg-plugins page
Date: Tue, 13 Aug 2024 21:23:28 +0100
Message-Id: <20240813202329.1237572-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813202329.1237572-1-alex.bennee@linaro.org>
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reflect recent changes on API (inline ops) and new plugins.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240812231945.169310-1-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/about/emulation.rst   | 49 ++++++++++++++++++++++++++++++++------
 docs/devel/tcg-plugins.rst | 13 ++++++----
 2 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index c03033e4e9..eea1261baa 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -207,8 +207,8 @@ Once built a program can be run with multiple plugins loaded each with
 their own arguments::
 
   $QEMU $OTHER_QEMU_ARGS \
-      -plugin contrib/plugin/libhowvec.so,inline=on,count=hint \
-      -plugin contrib/plugin/libhotblocks.so
+      -plugin contrib/plugins/libhowvec.so,inline=on,count=hint \
+      -plugin contrib/plugins/libhotblocks.so
 
 Arguments are plugin specific and can be used to modify their
 behaviour. In this case the howvec plugin is being asked to use inline
@@ -219,6 +219,14 @@ Linux user-mode emulation also evaluates the environment variable
 
   QEMU_PLUGIN="file=contrib/plugins/libhowvec.so,inline=on,count=hint" $QEMU
 
+QEMU plugins avoid to write directly to stdin/stderr, and use the log provided
+by the API (see function ``qemu_plugin_outs``).
+To show output, you may use this additional parameter::
+
+  $QEMU $OTHER_QEMU_ARGS \
+    -d plugin \
+    -plugin contrib/plugins/libhowvec.so,inline=on,count=hint
+
 Example Plugins
 ~~~~~~~~~~~~~~~
 
@@ -260,8 +268,7 @@ Behaviour can be tweaked with the following arguments:
   * - Option
     - Description
   * - inline=true|false
-    - Use faster inline addition of a single counter. Not per-cpu and not
-      thread safe.
+    - Use faster inline addition of a single counter.
   * - idle=true|false
     - Dump the current execution stats whenever the guest vCPU idles
 
@@ -381,6 +388,15 @@ run::
   160          1      0
   135          1      0
 
+Test inline operations
+......................
+
+``tests/plugins/inline.c``
+
+This plugin is used for testing all inline operations, conditional callbacks and
+scoreboard. It prints a per-cpu summary of all events.
+
+
 Hot Blocks
 ..........
 
@@ -394,9 +410,6 @@ with linux-user execution as system emulation tends to generate
 re-translations as blocks from different programs get swapped in and
 out of system memory.
 
-If your program is single-threaded you can use the ``inline`` option for
-slightly faster (but not thread safe) counters.
-
 Example::
 
   $ qemu-aarch64 \
@@ -736,6 +749,28 @@ The plugin will log the reason of exit, for example::
 
   0xd4 reached, exiting
 
+Limit instructions per second
+.............................
+
+This plugin can limit the number of Instructions Per Second that are executed::
+
+    # get number of instructions
+    $ num_insn=$(./build/qemu-x86_64 -plugin ./build/tests/plugin/libinsn.so -d plugin /bin/true |& grep total | sed -e 's/.*: //')
+    # limit speed to execute in 10 seconds
+    $ time ./build/qemu-x86_64 -plugin ./build/contrib/plugins/libips.so,ips=$(($num_insn/10)) /bin/true
+    real 10.000s
+
+
+.. list-table:: IPS arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - ips=N
+    - Maximum number of instructions per cpu that can be executed in one second.
+      The plugin will sleep when the given number of instructions is reached.
+
 Other emulation features
 ------------------------
 
diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index d8725c2854..9463692c41 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -61,11 +61,14 @@ translation event the plugin has an option to enumerate the
 instructions in a block of instructions and optionally register
 callbacks to some or all instructions when they are executed.
 
-There is also a facility to add an inline event where code to
-increment a counter can be directly inlined with the translation.
-Currently only a simple increment is supported. This is not atomic so
-can miss counts. If you want absolute precision you should use a
-callback which can then ensure atomicity itself.
+There is also a facility to add inline instructions doing various operations,
+like adding or storing an immediate value. It is also possible to execute a
+callback conditionally, with condition being evaluated inline. All those inline
+operations are associated to a ``scoreboard``, which is a thread-local storage
+automatically expanded when new cores/threads are created and that can be
+accessed/modified in a thread-safe way without any lock needed. Combining inline
+operations and conditional callbacks offer a more efficient way to instrument
+binaries, compared to classic callbacks.
 
 Finally when QEMU exits all the registered *atexit* callbacks are
 invoked.
-- 
2.39.2


