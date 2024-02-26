Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290F8C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 22:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rejmH-00031P-CG; Mon, 26 Feb 2024 17:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rejmG-00031B-6t
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 17:48:52 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rejmD-0007pc-WD
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 17:48:51 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-412a4848f0dso10654435e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 14:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708987728; x=1709592528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lr70hukYTUDboowCyWGKx60eW3iN592u4eyWDlqcxq8=;
 b=KtpbcXQPXa9H1Ey7EHX16ifKv8awOuMGxsbYyHLUOe/BBnNQX1WlMZpe2gT21zUV23
 +LP4Sm0qi0DbNfxo0mxwpEsbK4qaWQ4QxMGBEQa8Tcw9+fWtPakRCQ1cW8miGUExf4VC
 k71CSp8Ok0QlVT7N/+76qDPnCZseMyjVzTgMTEyZGbgG+ZDweUiMIBBSF4S/LgDm0+zv
 qDL0ei9n+GcYaFgi8KFZl2JOm/J4Io/qt4n1U2Ve3FO/avPjjVIPgAsy7z+q8PJYYKDJ
 lvDhWjyPEW6xBuG3vPYREfMgCc3RYxJ/eUR6FrExVsv67lfDqU7eKnw6bQwRFc3YOYl7
 itjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708987728; x=1709592528;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lr70hukYTUDboowCyWGKx60eW3iN592u4eyWDlqcxq8=;
 b=jkI7dKM9iiBX6U4LMu3Zqo6bD/IReqMLPLO/dxLk9jcJHcnVePpGIrfWPlStWSgYyK
 uv1ri/8qNKpWwaWPd87GWIr6qrc5lpnHECULiAENu32fmQhm4AjhGvz0W+cAKsf8WsAa
 LXozs1klBO/oXXH3M7hTWtj3jWKlNnLbahs1wq9zYpMq2panbZdiAJL5G5EHGL2oWwsy
 nv+1vRQpVZzklqKxG20i4I11AALM6YjWC9EqtTo9RUTjJlJkbRv/8DbEzLf96ekcNWF7
 PM5ypFuFz+W8/mEKT/FXByFpZdLYxLXsgeS4lBg0W8jyY9qW5TzKtwi1p8RdyslCe3Bx
 el6w==
X-Gm-Message-State: AOJu0YyigdPtT5Jq+Ubl984QRNL5Rl0VFGuIuaXEFGZ3qQ9Xhg+65pTJ
 s/LnUOlgg58lzpPdwbmGI5SFmteAqoSwionl0OIe/HP1TjnzwONhlz1BbQZ3PEc=
X-Google-Smtp-Source: AGHT+IEAUj3/JhS9mTD2b8VqOA5v+h/2jaUDTbrLJyoxe9YCbKp9X0RJwTCSG7oCmSUaCqsaXKYPTg==
X-Received: by 2002:a05:600c:1f93:b0:412:96e4:4fcd with SMTP id
 je19-20020a05600c1f9300b0041296e44fcdmr5636518wmb.40.1708987728414; 
 Mon, 26 Feb 2024 14:48:48 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o25-20020a05600c379900b004129051a8f7sm12930745wmr.41.2024.02.26.14.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 14:48:48 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8BDF25F7AD;
 Mon, 26 Feb 2024 22:48:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>
Subject: [RFC PATCH] tests/vm: update openbsd image to 7.4
Date: Mon, 26 Feb 2024 22:48:43 +0000
Message-Id: <20240226224843.487256-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

The old links are dead so even if we have the ISO cached we can't
finish the install. Update to the current stable and tweak the install
strings.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2192
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/openbsd | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 85c5bb3536c..85c98636332 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
     name = "openbsd"
     arch = "x86_64"
 
-    link = "https://cdn.openbsd.org/pub/OpenBSD/7.2/amd64/install72.iso"
-    csum = "0369ef40a3329efcb978c578c7fdc7bda71e502aecec930a74b44160928c91d3"
+    link = "https://cdn.openbsd.org/pub/OpenBSD/7.4/amd64/install74.iso"
+    csum = "a1001736ed9fe2307965b5fcdb426ae11f9b80d26eb21e404a705144a0a224a0"
     size = "20G"
     pkgs = [
         # tools
@@ -99,10 +99,10 @@ class OpenBSDVM(basevm.BaseVM):
         self.console_wait_send("(I)nstall",               "i\n")
         self.console_wait_send("Terminal type",           "xterm\n")
         self.console_wait_send("System hostname",         "openbsd\n")
-        self.console_wait_send("Which network interface", "vio0\n")
+        self.console_wait_send("Network interface to configure", "vio0\n")
         self.console_wait_send("IPv4 address",            "autoconf\n")
         self.console_wait_send("IPv6 address",            "none\n")
-        self.console_wait_send("Which network interface", "done\n")
+        self.console_wait_send("Network interface to configure", "done\n")
         self.console_wait("Password for root account")
         self.console_send("%s\n" % self._config["root_pass"])
         self.console_wait("Password for root account")
@@ -124,6 +124,7 @@ class OpenBSDVM(basevm.BaseVM):
         self.console_wait_send("Allow root ssh login",    "yes\n")
         self.console_wait_send("timezone",                "UTC\n")
         self.console_wait_send("root disk",               "\n")
+        self.console_wait_send("Encrypt the root disk with a passphrase", "no\n")
         self.console_wait_send("(W)hole disk",            "\n")
         self.console_wait_send("(A)uto layout",           "c\n")
 
-- 
2.39.2


