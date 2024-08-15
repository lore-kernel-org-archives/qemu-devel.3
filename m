Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFC5C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebu0-00086G-1D; Thu, 15 Aug 2024 10:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebts-0007ao-5R
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:56:29 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebtp-00014d-5z
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:56:27 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ef23d04541so12992931fa.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723733783; x=1724338583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFH+GkIlDVHJtYZuDNv3/msjkfbYLWmbwCbvi/sSR+0=;
 b=KrQEufhKRNyhwVSMMCLcGiz0NYaED/gHsP1iwLplhy/vWzvPg94sRtAqrCLBKo+hDp
 aQGKpxo0wlbZRZo7RB1n4jtWZoUd7UzRwK3+4tLpF1Yoj764f8JfvHnTNFiE8rEAQ4Wb
 YmAfgA6FDOQcNlxJ3ydIW6P7C70w+QF5mHiUCqt9Su39v6QdqIzrFQ+4zZ2sXAnR1XFg
 oNOmrdP1+fOyOVoHXnqthUg+0Ay/t2kX7oY6P2BOXUi4LLoVBIIeX1vZp2hs9p6JXdM8
 SvK6F7kdhK9ZGQfNU4KuqZGPLsz9QxnvWCiXXAZX/AuHfnyDlW+CCgM/o5IdeBRZTiHy
 FYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723733783; x=1724338583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFH+GkIlDVHJtYZuDNv3/msjkfbYLWmbwCbvi/sSR+0=;
 b=s7iVuBGsA/nmvc/7qvAYxF6N9ZQF3NjOZ0zTX5xQPybxSNfhZdi9KiB4Rw6gcaF1+5
 fStOLCcYKOxUdXHzhbUGUVm3glINS2MnHYf5NQSa+dPBmkkLrDB+m4xMKXj7DRRsOkOB
 nv8z8IT2xnFQcIN+o7iT+w7iYRj4OP7UayZBOHwGehwlNiGaf3NjeaG4QlFLjQHYb0FZ
 DotsFZGJB4dzSamn8bAVEbJX//sT1rqEHHSifuz//hqs/yBB985bRjZ8BNIG0cKRQqeK
 Y+zN5pXOHgjBose9nRATmZ5aNMPOGDjgMa3BJ2ttzPDwcz8VcBckF925mEAfQNXaxRz5
 RjMQ==
X-Gm-Message-State: AOJu0Yz12iWy6syOYp6Pb+w1dyFJYDF4jQNIEAZdOrlxW668OWaejnwi
 ojG++i8eT+aLYNqGcL2xpNzqqsH3UdRAsH/2AEEzA2dDfYDoD1rguZ3I9NE0QNA=
X-Google-Smtp-Source: AGHT+IE1ph4ENd3E3Jpbv4/dfKcC0wUpbZDAwbOHvz52a/E8yhgb5iyPFXca786dBiq6wpBdq+kbig==
X-Received: by 2002:a2e:510a:0:b0:2f1:a7f8:810f with SMTP id
 38308e7fff4ca-2f3aa1f4cffmr38727451fa.36.1723733779403; 
 Thu, 15 Aug 2024 07:56:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebbde4b42sm994961a12.35.2024.08.15.07.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:56:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9EDED6067B;
 Thu, 15 Aug 2024 15:49:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 20/21] docs/devel: update tcg-plugins page
Date: Thu, 15 Aug 2024 15:49:10 +0100
Message-Id: <20240815144911.1931487-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815144911.1931487-1-alex.bennee@linaro.org>
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Message-Id: <20240813202329.1237572-21-alex.bennee@linaro.org>

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


