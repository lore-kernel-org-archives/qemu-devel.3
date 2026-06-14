Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0057CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 10:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYhmD-0002X1-O7; Sun, 14 Jun 2026 06:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wYhmA-0002VK-45
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 06:09:11 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wYhm8-0005ce-BH
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 06:09:09 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4600ddc4017so1687234f8f.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 03:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781431747; x=1782036547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ip09JP+AWJu43CooVYcaHOAYsyo50ssO3NlA13nZ4z8=;
 b=AIrhFWwsz1bPg4N24jW0ZoyOv840p8GyN4ICO98vwaPEWZ9kJp8GA7RjDmzgj4QKeF
 ixsebrHgAtHQRB+BAddUqwKFKpZT23gLvvO2LqoCysDEUXHbzvwIlhFMAu1uBc2IE2Ez
 e2uQ3gV1ZPFJqf45y5lX4Gjb/TdtY4coMiGzK6EGdXDMomPDd6Zh3lv++AYE+LAFNpoY
 qhHBD8qmiInZmdF7u6rTlKD/t9B44J3SsGxQiH1ACX0Cp09KQ1gQomV8aJ4OOe8flTrY
 2tuH61DfIwvwB6q/HLvclPVqrNVhKy+c1MSNoOQ51Z6o1qHiSMr66HhXVuZ7aJBs9rP5
 zxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781431747; x=1782036547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ip09JP+AWJu43CooVYcaHOAYsyo50ssO3NlA13nZ4z8=;
 b=ZYMhkQVWtx9/SLUVvQN0lsyEsjA4o9ibLfDlDO/jLfvM012vQPfAgvQU8TyzBrdQtw
 489GiwEhppgZ2AHG85jsRjaEVkzJWS/phEJmBg5XEsnjgyD9zXOgMr7zYHaLsNt0VVjY
 +ifRI8CHhLI6nD9xtiIiUpZ2Y6F+Q0XEFZBANb+c27LgMtTQ+x1tOIIo4Pdpv0p7UoHA
 qFhDnvVljHizaOQdiGm+l+KDl7zdgCCsR4HT3KHko1DVATVNI8WX76kcnH77sLOejHjH
 rdxG7tCBn47VLQncB0BORhH2eaPWke+RDnu1cxaOjDKJMh9sznVCh8akaBxkrETQIEOz
 uXRg==
X-Gm-Message-State: AOJu0YwngNyykPTDoBmRLNk+egyd5vNF7Sk3XTrm9othtzRUxhIb36IF
 lq8c6NdXc9wtvQJlMxUJYo3r+gwhGVMXypwk9fs3Apk+AceXyZDvMPqyAVduAwshO00=
X-Gm-Gg: Acq92OGiFn8drHwq2vQANuoYRmVyA1nVz6yPFNGtO1tQC3ecJ9T9iJ2R1eFIvTPQb1T
 uLfIVVdfFTrdu1dDYPO1OaHoF50BXcyPTHmwQmGeGWrQ+soHEqMji3pKDgBDhvsa6g9YaMJ7YE5
 5oBuXNA+3KWDCHFG9idN24g5igvUIPIq1rMlwNApIHA1B0YGeBrrhqbLgyvWrl10E3NUHbEg9Et
 doKTVyUX1Ag4mdo3Gh0KoyBHkZkIiaujmcxv1tf980HVF9Q9P8wac01az3hCp1fPTVrZBAmAyzQ
 1SsYga2uqHsrXEZbnk27rfD6Pg3coe33EhlZVlQlXf+1BJUG/s8tGsNrvhps1coKFsseoOBune4
 /8RnDWBIgeK4a3SL0BlyKAYcYSFVUDsvojMkcF6SH/zjYWSVgQewgLpLOB8DST/xAEiBaMGa62M
 DDa0nk9CgWBjQuOtinUpmrXKw=
X-Received: by 2002:a05:6000:250f:b0:460:3234:293e with SMTP id
 ffacd0b85a97d-4606dbd3b1bmr13222526f8f.41.1781431746705; 
 Sun, 14 Jun 2026 03:09:06 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263945sm23642708f8f.8.2026.06.14.03.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 03:09:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E80C05F9E2;
 Sun, 14 Jun 2026 11:09:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/4] python/qemu: split arg between base and harness lists
Date: Sun, 14 Jun 2026 11:08:59 +0100
Message-ID: <20260614100902.885698-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260614100902.885698-1-alex.bennee@linaro.org>
References: <20260614100902.885698-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 python/qemu/machine/machine.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

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


