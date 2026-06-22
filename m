Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0FFCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbgmK-0004fp-77; Mon, 22 Jun 2026 11:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wbgmJ-0004f2-6P
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:41:39 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wbgmG-00067M-EX
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:41:38 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-45ef41adbc1so3585240f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782142895; x=1782747695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3Yi9+MPHMQjD4aJnRDYATn1twRvsUXBItVVQx5bTo0=;
 b=OCRi3JvZuFxCy1tjKuU3Dibmw/2GS1SdMNmD5f8hQnEEkp5N9QwhIYX8psnw4q6bLO
 qpvg1YkJsbgsYN8S0hi1qL1zbQTIBW57Eq0uNy8iZGs3ZXhqH7v2TVf+WYBf8xShCi3t
 aXIo2KsgBFOCJLk0V6zQqeZrpITXsC11eRReJPZSte9vTRLV9ox/7EIBynHrZYZamifC
 aTErRTZgFL9Up0RNJaNqKNapMQztERuTybE8OnreT8eCtk+vr19C1saZC9W4r9lStLt6
 UH5kWlo/r++YVDFbOghmXyp43t0KFcWh4HrgD3lGH2ha/2F9F0YLufCjUMq65BoCPv6A
 i7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142895; x=1782747695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W3Yi9+MPHMQjD4aJnRDYATn1twRvsUXBItVVQx5bTo0=;
 b=U2zpL9uelMULNAf/Jo2NosjQwOVF2Plh932SjqHsCd5Do9l3DtSPmqSWxa3BEFfM2T
 Qh82zSEYaUu4wrlJ0SOBhvSJv3L3BsxLzheKS/gf9yy+eAjJLE6fviM4ttVpF27vRSab
 h4Vz5dRQX8jvSfOjt6JdVDme24V/XSqeiPTqV4jL0XFHTkz6NF+H4OFkr1Rv97EXicCf
 vwRnPtS3rJvwuxzDvHVi/GWW9rQmu2/hw7jjWvPFUgeVK1YA5y2IfMucgSo4kWxiTeSM
 +0SuzlEO8OoyasqPsvQGkYtEdoF0MizGafBGqgYDfxiwiFbU9ruiFEKqCU4L3hS9WorP
 ta1Q==
X-Gm-Message-State: AOJu0YzUv6/0zdSu8CxrZqjNfW4ogp+wEvzu372cLwGJqLknPzorDVOa
 bSAWBwo4fc0XD4YSEbju9KjWH0UIkxtl7dqkzHHf9egPL3bAwBNrcTsBUleGEX6Bel8=
X-Gm-Gg: AfdE7cl9L9XYfGlKCGzbCB33cx4+3CLIqgs03N2LVLViysdURqd5I+YmfPTlGTxei7y
 /K+owdxw/oTaRgztB1fd2Cfa0Nd1hZm+9p+uHW5+RnZsinlDjSIlu7hdk2xZZBgybbHdhAWUZaB
 8SVe5Y8bTa5F3zjeRQJQ3DOMNyHfQfYN28ZapyUDlfLL3HE+YaQW2X1RELtOiUEzSHep+jAr0cE
 3HMwDzoxapiG4bS696wKpYlRBZxrruGo8Vscqv9rz7hDDOcoN9prU2u6AqDPxQrq5fI3qHkO7uv
 3Umade7dt0EmDGSzXTJkxEEKRuFECcw1AjM85ptNZ4hK639hYuGo40ExbvATvjfeYRszZywMFOQ
 MhJvElVPGlLS/r/vP/VwJzoKRWXmCUTqydDVRdGUG1sWQnTdG+rK9sZj1JSTIQWH93RDtlPJBDL
 8DxGsl7FPG9wiQ
X-Received: by 2002:adf:fc8c:0:b0:43f:e934:50ac with SMTP id
 ffacd0b85a97d-464fff62e1emr21036428f8f.7.1782142894999; 
 Mon, 22 Jun 2026 08:41:34 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666788547sm28720822f8f.18.2026.06.22.08.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:41:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 572055F845;
 Mon, 22 Jun 2026 16:41:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PULL 1/7] python/qemu: split arg between base and harness lists
Date: Mon, 22 Jun 2026 16:41:25 +0100
Message-ID: <20260622154132.3166748-2-alex.bennee@linaro.org>
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

There are argument we add because we want the test harness to control
QEMU and arguments we default for handling the display and machine
type. Split the obvious ones between base_args and a new list called
harness_args.

We will leave the complexity of the serial ports for now.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260619155657.944220-2-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index ebb58d5b68c..e8973a87394 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -292,8 +292,8 @@ def _load_io_log(self) -> None:
                 self._iolog = iolog.read()
 
     @property
-    def _base_args(self) -> List[str]:
-        args = ['-display', 'none', '-vga', 'none']
+    def _harness_args(self) -> List[str]:
+        args: List[str] = []
 
         if self._qmp_set:
             if self._sock_pair:
@@ -307,8 +307,6 @@ def _base_args(self) -> List[str]:
             args.extend(['-chardev', moncdev, '-mon',
                          'chardev=mon,mode=control'])
 
-        if self._machine is not None:
-            args.extend(['-machine', self._machine])
         for _ in range(self._console_index):
             args.extend(['-serial', 'null'])
         if self._console_set:
@@ -323,6 +321,13 @@ def _base_args(self) -> List[str]:
                 args.extend(['-device', device])
         return args
 
+    @property
+    def _base_args(self) -> List[str]:
+        args: List[str] = ['-display', 'none', '-vga', 'none']
+        if self._machine is not None:
+            args.extend(['-machine', self._machine])
+        return args
+
     @property
     def args(self) -> List[str]:
         """Returns the list of arguments given to the QEMU binary."""
@@ -366,6 +371,7 @@ def _pre_launch(self) -> None:
         self._qemu_full_args = tuple(chain(
             self._wrapper,
             [self._binary],
+            self._harness_args,
             self._base_args,
             self._args
         ))
-- 
2.47.3


