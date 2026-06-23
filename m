Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A30DCDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wby7b-0001nB-Ji; Tue, 23 Jun 2026 06:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wby7Z-0001lp-JK
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:12:45 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wby7X-00073d-V7
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:12:45 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-45fd461e4a5so4047951f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 03:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782209562; x=1782814362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kFZ8oV2tKeVxBSuA92dpTIn1XLzgOP+YUAVL9W69Ca8=;
 b=QOxI6r1endIZ9XAlJyzVu/IUnVcUML4b7FGGWzPuDSQTQN0WOl/so6Ry+E7+jsV/NI
 T7Qqe/FJ34kHUKQgL3FrV4JlJyXgohY+5QxOjomOw/erx10X7i+JBf+VxG+cAbX9bccG
 b2EJeuEmkY0ntJSVWR0FdGVzz+IVWzC/8MmZjBKZP7uBPHHUG7WKKQ7bGQXjzXWHvG0j
 8nDtd7qx5ueZj/XJUkTy6j8kpl83WMcTyNIFAz3HgnsR54D71+Pl7BwPjAC/t/iL9DsY
 W+q7c+VLAf5jCGL0n6YNrJCc90U7c1zokLTSpIxgtFzl58/YwZsv8GOP8p096tdIaJEY
 dxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782209562; x=1782814362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kFZ8oV2tKeVxBSuA92dpTIn1XLzgOP+YUAVL9W69Ca8=;
 b=g/V+ogQZCE9/X6dtXyVT3k6ld+0hg1fl0gJJa52p6fbN3N++EUoQceJ4M1YTMv1Uk9
 2hVtFgEknxzdgHXxtfDmwNHzffhOTvzTJ78LHlaNayFEkbBke9kYi3lY4QIMOGr7pVAN
 xjcaGuQiJAWOhTBf6OPJZ61zZTUo0TB8Cj6D4MyXq5eHzmwcHAfOB1I6AOxXq1KilGlX
 YfCeg3cFt4KBijdNFDBmJgqlWbMPMN6B9D6RPo2BN8GtTP6k7Otiu6evqVxVxmcB5xxT
 3dtXI2VXlG+MB2RI4SEKiDN6pO9Ji2alZWCf0smCefstBa/39TYh5pzjPwRhHXzWTrCN
 RGxQ==
X-Gm-Message-State: AOJu0Yw/GYAY2kp7XD/zyd9zOMRVnyKPUvyO7+XJkD4T7eEOTnzxoeUx
 4Ra9qW5itbOKv2IxN6JO2ry5buVFOVl2VbjjzV/vRiKteLVWTuBKANrnKrY1DlXTWGo=
X-Gm-Gg: AfdE7ckxtAyOqyLQvYM60knJGxjHVAxZrwH4SN32QXJqTqcwTai+sbpHTFAWgyq3Ab4
 8bkens+t7PezoVrgeXQZCrWVOHdSymIP+MwQ53Q99PxSHgs1ofDmU8U+gQEEKzL17hJWXYmy3rS
 Osf62Eb7PzQpZk01QgTZb8gp0Ei610haUF8xKtI32an6N1r2/aHsrri8SI3jvTJiTUPfGDb3OV6
 NRJu+N88Psnj9rG+NcAUwlomJXrJvw5AWAkn9InYbak7lOOBb/VkE89qHU57/kIDsk/Q+6kqckl
 9rKd4BhrFj1KzyWMRHmuPQTpjJEHZkMldnh7nG1Hiufl9eoJfv3mpIaj/xpGmH/MSZt88mCXmK5
 scXSofjWC8lbaccq2Eoz/4ffqE+yhYs5khjADffgAFJpCH0/YdXXpm3StXsLUr3yGw3z+r5qGex
 jGwvPlBbtFzsfLf97slMYrlqc=
X-Received: by 2002:a05:6000:4715:b0:43f:ea25:20ff with SMTP id
 ffacd0b85a97d-46adb0b5c53mr3085369f8f.29.1782209562364; 
 Tue, 23 Jun 2026 03:12:42 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46667221da1sm34615377f8f.36.2026.06.23.03.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 03:12:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AF6385FA5C;
 Tue, 23 Jun 2026 11:12:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PULL v2 3/7] python/qemu: dump a developer friendly version of
 cmdline to logs
Date: Tue, 23 Jun 2026 11:12:34 +0100
Message-ID: <20260623101238.3806547-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623101238.3806547-1-alex.bennee@linaro.org>
References: <20260623101238.3806547-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

Now we have the arguments nicely split up we can make _console_args a
function call and present a slightly different version to the logs to
save developers manually hacking the command line up.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260619155657.944220-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index 18ee5ec0147..3670c8cd397 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -308,12 +308,15 @@ def _harness_args(self) -> List[str]:
                          'chardev=mon,mode=control'])
         return args
 
-    @property
-    def _console_args(self) -> List[str]:
+    def _console_args(self, interactive: bool = False) -> List[str]:
         args: List[str] = []
+        # redirect pre_console_index serials to null
         for _ in range(self._console_index):
             args.extend(['-serial', 'null'])
-        if self._console_set:
+
+        if interactive:
+            args.extend(['-serial', 'mon:stdio'])
+        elif self._console_set:
             assert self._cons_sock_pair is not None
             fd = self._cons_sock_pair[0].fileno()
             chardev = f"socket,id=console,fd={fd}"
@@ -376,7 +379,7 @@ def _pre_launch(self) -> None:
             self._wrapper,
             [self._binary],
             self._harness_args,
-            self._console_args,
+            self._console_args(),
             self._base_args,
             self._args
         ))
@@ -485,6 +488,14 @@ def _launch(self) -> None:
         """
         self._pre_launch()
         LOG.debug('VM launch command: %r', ' '.join(self._qemu_full_args))
+        # Log a simplified, developer-runnable command:
+        # Exclude harness-managed infrastructure args (harness_args)
+        # and wrapper.
+        debug_cmd = [self._binary]
+        debug_cmd.extend(self._console_args(interactive=True))
+        debug_cmd.extend(self._base_args)
+        debug_cmd.extend(self._args)
+        LOG.debug('Developer-runnable command: %r', ' '.join(debug_cmd))
 
         # Cleaning up of this subprocess is guaranteed by _do_shutdown.
         # pylint: disable=consider-using-with
-- 
2.47.3


