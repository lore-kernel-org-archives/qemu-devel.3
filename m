Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C43CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wby7a-0001me-Dc; Tue, 23 Jun 2026 06:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wby7Y-0001lK-53
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:12:44 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wby7W-000738-7s
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:12:43 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490c0c92cffso37426615e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 03:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782209560; x=1782814360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3Yi9+MPHMQjD4aJnRDYATn1twRvsUXBItVVQx5bTo0=;
 b=F2bx0/3ICzzoaZN9XdlFYCR8XgnvyyLqGXE6uyyWKMSyw+ArofgttAYBPuZtrnSKxf
 ma+cCKhvxiZcJ3VYfohfHp90UbO4BikhMfvBMptM2BU5B1LmPpKVwZ2DN0zWZEUTKiGu
 dEO57/8c4p40nBPJUoB+vrfqNyy2MYkn/Vc/6gkaReP51FsYifOy4q+rhezgHcxssFK+
 sHagXopsqERfgN6JITNBSj67kqL4Aop3wcXo/y2rnO64MA/V0xWwLS0mwH0y+uA22wCo
 20br9XJXwSu4rz0OA74bjt4OhS10aUelF3vLQFaKD95kRI95R8OIIVAbOxaNhyy49Htt
 HiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782209560; x=1782814360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W3Yi9+MPHMQjD4aJnRDYATn1twRvsUXBItVVQx5bTo0=;
 b=kFqrtB4Jh+kJwbseOJmtQP0S+K9kESEV/k8cUHWMBVxuZULuruiCXdiXgW69qLm+jq
 3pWu93koCS8wrk96F5NMMc+hYC4pmsf5Y8uukPhKQWNyf4DrUmfCPZ0rJZlUu1j3A3TO
 GTnKzNADnAQenPzTyIaitRmLsPiTlJiSvod0Ti8ODraZ6ev5cpsuGQxWnAbJ7aCbNx7G
 ocGeDkJDlxaY8QK68YGAA4hObxqVOhwMWgLOBhWCguyU80EzmFolPzXxb4UrJ5qQkEGE
 X9NnSgE1SCG0ox5Q07QV35sQ9hZXBpGijOL1JYMuoPLx/qK6n0XZKuSUryYblMykk+8A
 880w==
X-Gm-Message-State: AOJu0Yw2Ff0CqvwiNiCu4T37IH6mjYzTB6adNAAhcWfFRpl0HFMgjDDb
 ykXpOkScu05HPTBujj+gKVeN7afME9qkgMgcFXoyZab9mlvmP1GF7wGJ8GK8TTLFGUs=
X-Gm-Gg: AfdE7cndxC22CT96lqRCQ/1HxYAcgYc6Hqdv4Ng47hM7qnDFcyM0hH8FJVjrKQUhmCK
 gwgz9Lkq5aemNm2a/0IXapAUQdgPglU2pG/7F97EUO/q4aTpOrM2T+PyIOpt02bWreMVAhLTNcE
 sf3bMDRRrRtKBnXCvzgmcsD1i+M5aa2d5rvHQsNkDvmz/+jqHn5W7VMNxn3FN1TwkT/Rr8Cw5BB
 622wCSOHLKIaDdC+6xKJ1aZQP1QvrsmZDqyyseWTHqBhgd7S6ODtaSEOx8vBaErTo4Tg7ACyTIj
 Jgg8WaqLmND4RYdwGs6en+jjG+r1r/WgJBF378BlOAx6eA2vGBfVG7wu3PhNrBd9cQFxQT3+4eM
 uP/as9wI7zrsh9PXdjRsHqjKevQH5VJBy0xjjS+uriPFmf0C0inGDx/0v55ZEcerCQ+8hqgPLJU
 s8E4B5vhIBl0wn
X-Received: by 2002:a05:600c:48a2:b0:490:bd1d:472a with SMTP id
 5b1f17b1804b1-49240e4473dmr192747035e9.15.1782209560309; 
 Tue, 23 Jun 2026 03:12:40 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49249238900sm270185065e9.4.2026.06.23.03.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 03:12:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 842155F9CD;
 Tue, 23 Jun 2026 11:12:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PULL v2 1/7] python/qemu: split arg between base and harness lists
Date: Tue, 23 Jun 2026 11:12:32 +0100
Message-ID: <20260623101238.3806547-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623101238.3806547-1-alex.bennee@linaro.org>
References: <20260623101238.3806547-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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


