Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98E4CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 10:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYhmC-0002WD-Mo; Sun, 14 Jun 2026 06:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wYhm8-0002Uu-KK
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 06:09:08 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wYhm6-0005cB-VS
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 06:09:08 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45ef1198766so1212751f8f.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 03:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781431745; x=1782036545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XmgzCfVVVkblYVceCs+S/fgmwHRncvIcrxSqKC/ybkk=;
 b=t5GzaauruU0xxM51Ohjat1HCrk3n4Oi8OJjcTWHNj7gQcBFKKzMJIig7t33rnYScR9
 jl4nr514q6KmwpYqWpJyqxe3NFw40H+OQo/A73iQ1tLJW1mjEjQYbQAueQMkt5ibf2vl
 gWH1E3IfL9f8OwuzlBBFbkVTFxYB7l1dMYxreg2WWUmJvD/+TVqCClJw7agbvrefTUA6
 3+C2RFEBqwTLrOF5XZxXyQRNn2DLQxOUJ6sPNcjSgJlwRAs9z5/YHlSFOb7HcWtIP/vu
 e3SsRzOyxBBOweOwdcg1INO11SgsMLqiXYYn6pkfPwM0MaMXwsME7PMl4eyGiEJInMRG
 qptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781431745; x=1782036545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XmgzCfVVVkblYVceCs+S/fgmwHRncvIcrxSqKC/ybkk=;
 b=BLKxX9MsoUZDM22fo1+zPKNMMxMowv6U4/6QtGH6Jy6qHzxLh96sFgqymU04uhtg21
 T0oOawyAmChxPerYh54X0CZoIIqfM00Txxb00v+/zuFW1ruzHvF1UFOwdWwk+xEj7BvF
 qOSNQ1whXweOjg54uTyiwbOKK0e2vAKiTDUvxXTym9DSPjgBemseMlMTPtR6KWxX0Gew
 cfAZRK7ecs7Dz56YRRyXzVjkdwn71DFqLS8lWsmzg9TmLa8w6nZ3n44zZE71h7rzKP2x
 xCuGuJbxOIpeARuIEyN5wk5/J5SRLYSiKKRw8zswRKs7Yiwj5DeQn8fNAgFAga4oehxJ
 yANg==
X-Gm-Message-State: AOJu0Yx0kb7X95q8rdZE0MP5WUqduTHi28Nb5vtzRHoxqrdAkua03MyK
 wOTjS1irmLMUYcfUQGxuydDUUHABMHd+Zf+F3PdClMZybub3vJRuqIvV6Yfs+xSRh5o=
X-Gm-Gg: Acq92OFyN6NWulwK6zwQ4jIOh/Lvj3Qrm28K7okETNUNzqhZyItTJ6qtvLJ2JGC+EAU
 FS4ZkL8PVNXenOYy5Qb2O7npXikGvHVuVsvyFsbLp1waiV2+1yOKirGEqBaRlji0PhqAHC+TPeh
 Zey3aRvjHulOVhNzQPrV85qtLV8q7zCj3G4zmbZt9uKGpW4fvmJWI9sUN5QVkQbMCXR6f+JEw+g
 qvkK81nb0QQXhBNLb+We1vBbrciqK97zTd9/fQr5Pykp3dpT6HAI5tCMHr16t8H58EtvRB1BdQf
 lSjNMvxYlSkx7P2KZ87zfsQNngK1nS15HILfFjewt7brwPTJIlfSYByW6ubKgPA9sXlrHKW2pPh
 +Z+qRLgb/YbnZ1xQ/m3+OcxZ0cHbTF9Y1we6H0ab0l7XQ0hk2pgFV5Pulj2ZCmq/Sbs2P58P2x3
 ddBcE8DGwaKwjhDncQI/UE2Xb8BYafLu7Fig==
X-Received: by 2002:a5d:64e7:0:b0:460:3210:950d with SMTP id
 ffacd0b85a97d-4606f25dd82mr11948620f8f.21.1781431744610; 
 Sun, 14 Jun 2026 03:09:04 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d70sm23866561f8f.19.2026.06.14.03.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 03:09:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1BC575FA43;
 Sun, 14 Jun 2026 11:09:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 3/4] python/qemu: dump a developer friendly version of cmdline
 to logs
Date: Sun, 14 Jun 2026 11:09:01 +0100
Message-ID: <20260614100902.885698-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260614100902.885698-1-alex.bennee@linaro.org>
References: <20260614100902.885698-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 python/qemu/machine/machine.py | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index 18ee5ec0147..26a7bf5948f 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -308,12 +308,15 @@ def _harness_args(self) -> List[str]:
                          'chardev=mon,mode=control'])
         return args
 
-    @property
-    def _console_args(self) -> List[str]:
+    def _console_args(self, interactive=False) -> List[str]:
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
@@ -485,6 +488,11 @@ def _launch(self) -> None:
         """
         self._pre_launch()
         LOG.debug('VM launch command: %r', ' '.join(self._qemu_full_args))
+        # Log a simplified, developer-runnable command:
+        # Exclude harness-managed infrastructure args (harness_args)
+        # and wrapper.
+        debug_cmd = [self._binary] + self._console_args(interactive=True) + self._base_args + self._args
+        LOG.debug('Developer-runnable command: %r', ' '.join(debug_cmd))
 
         # Cleaning up of this subprocess is guaranteed by _do_shutdown.
         # pylint: disable=consider-using-with
-- 
2.47.3


