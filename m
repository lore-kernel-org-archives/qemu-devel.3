Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5063CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbgmP-0004gU-O7; Mon, 22 Jun 2026 11:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wbgmJ-0004f4-8m
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:41:39 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wbgmG-00067G-6L
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:41:39 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-45ef6565cfdso2016639f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 08:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782142895; x=1782747695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XyFTcbhQDZYaY5meXl7J2sf0pQmdQAX+1DQKPv4jWu4=;
 b=k+AFPKeS6LLuZw0Br1xtlGV9ScosUPAwKtQ/3beEKMaIJcMVFgSZf3PE7vi1bJbxOz
 YUIlisHkxZBuhMj/8UnaQlBXdUtkibUFlLQBhYFcQR2X7W9gYfjH7TVYtJdwLRo9aNik
 9E/L9fvC3MaojMn65vWUL5pvXZI5XKv01fPmGGdviFyaRO77kW1bIHMYJH+xM+B2AQ4G
 tcJMBbGrEjzgE//2hp2UkATwH9E4Y/ko99WvLoHhA/FnqwCq4nkrevYG9WzlWJakC6eu
 PUDAvdabkOgV+Raws0e+UBGh9sV0nCHDrPCbAtCUNspYV3nblN0eUsriD2H0glINJyPR
 NC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142895; x=1782747695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XyFTcbhQDZYaY5meXl7J2sf0pQmdQAX+1DQKPv4jWu4=;
 b=FRqRRxJ12Kfc4SihJuqWJo2p43kuPLUXCE3UFYMe2a8/df0EyRGCyoMvwPCyE8c9Ff
 z8Xn4fG/80aVPzYOs8ueTrtTigzjpQbRzo3tU7hZF+YXEio4lBA9LnaORX/0X2fioEMB
 72Ta8GwyQ5RA3xZ07ANbhwe7bXBBNW22mJO0nAztze9Nm/Tj1W3bf2326QGd1ikE7rvs
 MkLbsX4tzve0CxQ7iB4yw6a9sLrjYXii/isMJHj1fGmPZV6jmlprnoEHYp7COpagkFuI
 oukt2RoNC9YTApNDRySFwoN49neFyczcGoJZ+tsS6Yp61XZPyfMEpFhXJ0BsIsg5ZdSI
 ibkw==
X-Gm-Message-State: AOJu0Ywyf1ZoGTA0MXtAqGHfUh5sN+EliKEBU+hTfK+ZX23Wclaktys7
 txF3yZtuCWxGfBbIKawmrOwBga1FcRxgbteKFn2kZAGKXpB685zMu2DFaIwAiRcPQs8=
X-Gm-Gg: AfdE7cndv3diOSLxIwfKwhuh0WrGPDgGxM9Fxfo4ASlKekTqR/nIX8ukhzvBxNFrp3X
 spKIBDoekt5pHWCV6TWgnGOIo4/AUbP3Znxbi20G4uSutLkv6ywhBaqjU5bb5tiWrDBof0K+Vjz
 AdGyT7aa97E4KXg9qJLJo45mDBXaMnB82xfAdwlJZBmT5ymqnJ5bHrNWkWFSpLmoVCKiaue2QAP
 u43loW7ifCxFaa3GkQrsNnXDrThBrvw5nsIUmLxl/OoUd5Kbv+gtzqVFsTjv+OMA1cO0LRpz6C3
 UVqzpZW11jROyIro0FK6HvFbWwhapplgs9J+UhZm0lGH3xaR5KZrL9nayZ8zho2Mz06NmVcZtFx
 6o02OjFh5ty/vhRozTOQISQllHLBnjCQNZF297pfz/n5SfO/IYQDiMKFiKsSt5NIk0pUiJ4HcMl
 k8YGDO/D3Sex1t
X-Received: by 2002:a5d:584e:0:b0:45e:f631:2c73 with SMTP id
 ffacd0b85a97d-46660743f4cmr17043747f8f.9.1782142894560; 
 Mon, 22 Jun 2026 08:41:34 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f563dsm24823440f8f.3.2026.06.22.08.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:41:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 826CC5F9E2;
 Mon, 22 Jun 2026 16:41:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PULL 3/7] python/qemu: dump a developer friendly version of cmdline
 to logs
Date: Mon, 22 Jun 2026 16:41:27 +0100
Message-ID: <20260622154132.3166748-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622154132.3166748-1-alex.bennee@linaro.org>
References: <20260622154132.3166748-1-alex.bennee@linaro.org>
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


