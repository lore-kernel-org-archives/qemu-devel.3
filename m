Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A27CC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIYm-0005on-FX; Wed, 28 Feb 2024 06:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIYj-0005mg-VG
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:57:13 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIYe-0005iU-37
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:57:13 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33d32f74833so2962240f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709121426; x=1709726226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zu0/8AOzvmmeDKRaP7W/OXKcr7paiZGUbKkGoq3Xhmw=;
 b=dTYrz3vRS6wA533WHSNhsGJwAOQYNp+rPtcYQqAkYBtcy/L1eMJHRFf3h7b5LXT3V9
 O8SChwl3g0PjB1TeSsgwAeLfHlVsd73EePEbxU83PKW/MU1ptq70mIjXqt2wW9WF/l/y
 ZgWovKVNnad61MMSCAY0c0hV5Hwk9bA4gudeEIlyrpmjAqHArw7kQU8scgwmHj0Xqn/3
 qe8eVoOP+QhwmTXaJ1iStpxhMBacMsnMW1qZRrd2coZygnMBj7kE6do2pjk0CfSUhHuc
 HdyGwwVOCnFwr2ceVDzygulOvYigELbbZvhTRIPHZ+zfA5x6ld9N3YJgg0xnnBwldcPt
 qm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709121426; x=1709726226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zu0/8AOzvmmeDKRaP7W/OXKcr7paiZGUbKkGoq3Xhmw=;
 b=hvd6I4c/eXyVHMnUexbHla0WWYwlksIPhTXLUUggCQD4w/HS7StSdSk/x3uR5WKg1L
 94/W6C3UM6OryJmf6ucuBr95n9ciXm3ytEUg1tlONyCow7KIwVCl1MdPWffh/sclkOsJ
 lT/RT1tTVFwd5HCjdgM+NUrJ50PVqXF8eRPH3u981HjJuHnEdcbLX7qoxGa0jtbjOHdD
 RHc6X+NhTWWKNvH1njGasq4pKCqdOOHGMvV/p/udAALmud4yb1mQ/IePg/8ggba0F6Fs
 7zsXjvSF8AThF87qqQtDe/kBqoLafWdPuZk/xCbVvVvDedlKdEK6T8xmBDgDUDjg0Utu
 yEhw==
X-Gm-Message-State: AOJu0YwKjVQ5WUeidQrYhMaG7mZNuVUfLTMlHs8leCLk9jhUWuexIj9e
 RVbwQ2J5b109kkkzguGC9Sk/DHt1w2bFYaRCDDvEU4SbE4PMAgnbCINrIhbkjM8=
X-Google-Smtp-Source: AGHT+IGToOIjlGSWVjFi6oFrOJm7QyyO+GkJgvD85cVVif8vS2eOVJdj1jVoK9M0Q1G42Oh25X7hYQ==
X-Received: by 2002:adf:cd89:0:b0:33d:3830:769c with SMTP id
 q9-20020adfcd89000000b0033d3830769cmr9030460wrj.65.1709121426495; 
 Wed, 28 Feb 2024 03:57:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bt21-20020a056000081500b0033b48190e5esm14789920wrb.67.2024.02.28.03.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:57:02 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 417345F8FC;
 Wed, 28 Feb 2024 11:57:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>
Subject: [PULL 04/29] tests/vm: update openbsd image to 7.4
Date: Wed, 28 Feb 2024 11:56:36 +0000
Message-Id: <20240228115701.1416107-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228115701.1416107-1-alex.bennee@linaro.org>
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240227144335.1196131-5-alex.bennee@linaro.org>

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


