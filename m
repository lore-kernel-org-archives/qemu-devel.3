Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BF2C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 12:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubIgf-0000zC-EX; Mon, 14 Jul 2025 08:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubHtT-0007AC-4D
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:02:54 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubHtL-0003s9-42
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:02:50 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-60c60f7eeaaso6523372a12.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 05:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752494561; x=1753099361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OYoWcuxiMWJ8Rae1ld8RgNow2XtJPy/ataGh1UigGU=;
 b=ZEuPsEXsLtcfH3qe0tVRcxTSUONppqNKPFGwVNxNmqgHFuWM+J4PbxTht8Q+v4lZL5
 7HMUoQYy4Fy9Ka4jvZv8Wu/Jawhu2EeCzcwnok5lJaR7RTutK94QLZkruzf+AeORfE/0
 qg5AKVN9R1zwG98IZCpLpqorLq9XiFx175uV6qxkJDiJ7tQkzPnE7IrccKyJDR9miWKw
 sk1DPw4RlXPnutNj0lJqDnoydowrScj8VMKCqLynikcc5wh4B6ucW/HTj6wlkj6cRvKU
 wtFGe+G2vOgz5eBK6/Inwk+ONMQ2gmXxVOEUth4mVY5sZ27C1zn/pP0oMLWVWRF8SI6k
 xxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752494561; x=1753099361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6OYoWcuxiMWJ8Rae1ld8RgNow2XtJPy/ataGh1UigGU=;
 b=KhWMib2UGV9r8pQ/TbxDWi22n7G+RIvwKDBo9hiE95h1nyxPf86vS2O41G7r2MA/zL
 dAYlDrtFTYrVoKGZ+cE8h3XHlDQNWnGMBJhKhrgpHu08DNdjyXHQEj7TLn+WbPPXhBK0
 909pfuLbBq/7Jp/e6xculd1NpovRFTXfVAxrG4sLoaNBnBUJWuWzjgH0OvVZbtrymn8X
 gz/RWgAxe3TzntJNy8yoBhS3J3f52GO4bpojJLqtMqNpW7f5wbfoCBvbB1be39zjRcyh
 A47jaVTFUUx6YzP7e5QNDKc+g/wHGy8dlpsmO2gIiiLLLmJMkLd0yKdIb4T4uVOt9xR2
 FO0g==
X-Gm-Message-State: AOJu0Ywwuwdeg1xKF92h7WkTZOVEOtDoJF2UbzNHCY+ecX3eN5+JHlSo
 PHP5wcZg29MCiukfA00pDoqFfzuiyGhfgPQgKjemAOeaMQaO+fsztS27i16A8+WBk2U=
X-Gm-Gg: ASbGncseZAKcBuPN/UY6jSLnSOh9paVqm2DlZ3eFX8bLNN3rfohvo4altg/ZsvjAdzC
 zz/5Peb/Fd2J2x2Q9Nf8YjSsPo6NZtz1HjuME1IDBiDtu+zHAnjxu4KsDO7YQA/HDWYCJR7gKlM
 u2II98kjhsBfs0cBd1+F51I9v6jGNjqo1cWEQSX4FGdTZydmP3o/Ox6gWl+VfItzCVwfcwCfkrG
 dlHpYtl6IgRFekZh3664/mGQjxomyfyJf8EJadI+Jnv8cBgQ68LErW3DE7hDi80HUsjcZUQD35f
 8A/EhWXemUYTDexkrSOkkgNTWxxx1LwwZtuEcldFQ+51+tRgyqOCF9sgOo8pSIZnO59XiIMc363
 yCftV+QE31hz4MQYpYZJCoNJMC23hkR+Qfg==
X-Google-Smtp-Source: AGHT+IHTjnP1EwGeIENOfxAxmDLF0XL0xxOUUZIf8lTb9DHWxYwkM7kSbjdJ28WukOqZnwaSEqCZBA==
X-Received: by 2002:a17:907:3da3:b0:ae0:b46b:decd with SMTP id
 a640c23a62f3a-ae6fbf7143cmr1357447866b.31.1752494560980; 
 Mon, 14 Jul 2025 05:02:40 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e82df641sm818261266b.170.2025.07.14.05.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 05:02:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4E6B55F8C8;
 Mon, 14 Jul 2025 13:02:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 6/8] docs: use :kbd: role in sphinx docs
Date: Mon, 14 Jul 2025 13:02:32 +0100
Message-ID: <20250714120234.1524401-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250714120234.1524401-1-alex.bennee@linaro.org>
References: <20250714120234.1524401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Sphinx supports the :kbd: role for notating keyboard input. They get
formatted as <kbd> HTML elements in the readthedocs theme we currently
use for Sphinx.

Besides the better visual formatting, it also helps with accessibility
as screen readers can announce the semantics of the <kbd> element to the
user.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20250709-docs_rst_improvements-v2-1-cb5096ad0022@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250710104531.3099313-7-alex.bennee@linaro.org>

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index 6b18ed875c..2b5cb0c148 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -604,9 +604,9 @@ below steps to debug it:
 2. Add "V=1" to the command line, try again, to see the verbose output.
 3. Further add "DEBUG=1" to the command line. This will pause in a shell prompt
    in the container right before testing starts. You could either manually
-   build QEMU and run tests from there, or press Ctrl-D to let the Docker
+   build QEMU and run tests from there, or press :kbd:`Ctrl+d` to let the Docker
    testing continue.
-4. If you press Ctrl-D, the same building and testing procedure will begin, and
+4. If you press :kbd:`Ctrl+d`, the same building and testing procedure will begin, and
    will hopefully run into the error again. After that, you will be dropped to
    the prompt for debug.
 
diff --git a/docs/system/images.rst b/docs/system/images.rst
index a5551173c9..43706969fd 100644
--- a/docs/system/images.rst
+++ b/docs/system/images.rst
@@ -30,7 +30,7 @@ Snapshot mode
 If you use the option ``-snapshot``, all disk images are considered as
 read only. When sectors in written, they are written in a temporary file
 created in ``/tmp``. You can however force the write back to the raw
-disk images by using the ``commit`` monitor command (or C-a s in the
+disk images by using the ``commit`` monitor command (or :kbd:`Ctrl+a s` in the
 serial console).
 
 .. _vm_005fsnapshots:
diff --git a/docs/system/keys.rst.inc b/docs/system/keys.rst.inc
index 59966a3fe7..c28ae1a227 100644
--- a/docs/system/keys.rst.inc
+++ b/docs/system/keys.rst.inc
@@ -1,36 +1,37 @@
 During the graphical emulation, you can use special key combinations from
-the following table to change modes. By default the modifier is Ctrl-Alt
+the following table to change modes. By default the modifier is :kbd:`Ctrl+Alt`
 (used in the table below) which can be changed with ``-display`` suboption
 ``mod=`` where appropriate. For example, ``-display sdl,
-grab-mod=lshift-lctrl-lalt`` changes the modifier key to Ctrl-Alt-Shift,
-while ``-display sdl,grab-mod=rctrl`` changes it to the right Ctrl key.
+grab-mod=lshift-lctrl-lalt`` changes the modifier key to :kbd:`Ctrl+Alt+Shift`,
+while ``-display sdl,grab-mod=rctrl`` changes it to the right :kbd:`Ctrl` key.
 
-Ctrl-Alt-f
-   Toggle full screen
+.. list-table:: Multiplexer Keys
+  :widths: 10 90
+  :header-rows: 1
 
-Ctrl-Alt-+
-   Enlarge the screen
+  * - Key Sequence
+    - Action
 
-Ctrl-Alt\--
-   Shrink the screen
+  * - :kbd:`Ctrl+Alt+f`
+    - Toggle full screen
 
-Ctrl-Alt-u
-   Restore the screen's un-scaled dimensions
+  * - :kbd:`Ctrl+Alt++`
+    - Enlarge the screen
 
-Ctrl-Alt-n
-   Switch to virtual console 'n'. Standard console mappings are:
+  * - :kbd:`Ctrl+Alt+-`
+    - Shrink the screen
 
-   *1*
-      Target system display
+  * - :kbd:`Ctrl+Alt+u`
+    - Restore the screen's un-scaled dimensions
 
-   *2*
-      Monitor
+  * - :kbd:`Ctrl+Alt+n`
+    - Switch to virtual console 'n'. Standard console mappings are:
 
-   *3*
-      Serial port
+      - *1*: Target system display
+      - *2*: Monitor
+      - *3*: Serial port
+  * - :kbd:`Ctrl+Alt+g`
+    - Toggle mouse and keyboard grab.
 
-Ctrl-Alt-g
-   Toggle mouse and keyboard grab.
-
-In the virtual consoles, you can use Ctrl-Up, Ctrl-Down, Ctrl-PageUp and
-Ctrl-PageDown to move in the back log.
+In the virtual consoles, you can use :kbd:`Ctrl+Up`, :kbd:`Ctrl+Down`, :kbd:`Ctrl+PageUp` and
+:kbd:`Ctrl+PageDown` to move in the back log.
diff --git a/docs/system/linuxboot.rst b/docs/system/linuxboot.rst
index 2328b4a73d..f7573ab80a 100644
--- a/docs/system/linuxboot.rst
+++ b/docs/system/linuxboot.rst
@@ -26,5 +26,5 @@ virtual serial port and the QEMU monitor to the console with the
    |qemu_system| -kernel bzImage -drive file=rootdisk.img,format=raw \
                     -append "root=/dev/sda console=ttyS0" -nographic
 
-Use Ctrl-a c to switch between the serial console and the monitor (see
+Use :kbd:`Ctrl+a c` to switch between the serial console and the monitor (see
 :ref:`GUI_keys`).
diff --git a/docs/system/mux-chardev.rst.inc b/docs/system/mux-chardev.rst.inc
index 84ea12cbf5..c87ba31362 100644
--- a/docs/system/mux-chardev.rst.inc
+++ b/docs/system/mux-chardev.rst.inc
@@ -1,27 +1,33 @@
 During emulation, if you are using a character backend multiplexer
 (which is the default if you are using ``-nographic``) then several
 commands are available via an escape sequence. These key sequences all
-start with an escape character, which is Ctrl-a by default, but can be
+start with an escape character, which is :kbd:`Ctrl+a` by default, but can be
 changed with ``-echr``. The list below assumes you're using the default.
 
-Ctrl-a h
-   Print this help
+.. list-table:: Multiplexer Keys
+  :widths: 20 80
+  :header-rows: 1
 
-Ctrl-a x
-   Exit emulator
+  * - Key Sequence
+    - Action
 
-Ctrl-a s
-   Save disk data back to file (if -snapshot)
+  * - :kbd:`Ctrl+a h`
+    - Print this help
 
-Ctrl-a t
-   Toggle console timestamps
+  * - :kbd:`Ctrl+a x`
+    - Exit emulator
 
-Ctrl-a b
-   Send break (magic sysrq in Linux)
+  * - :kbd:`Ctrl+a s`
+    - Save disk data back to file (if -snapshot)
 
-Ctrl-a c
-   Rotate between the frontends connected to the multiplexer (usually
-   this switches between the monitor and the console)
+  * - :kbd:`Ctrl+a t`
+    - Toggle console timestamps
 
-Ctrl-a Ctrl-a
-   Send the escape character to the frontend
+  * - :kbd:`Ctrl+a b`
+    - Send break (magic sysrq in Linux)
+
+  * - :kbd:`Ctrl+a c`
+    - Rotate between the frontends connected to the multiplexer (usually this switches between the monitor and the console)
+
+  * - :kbd:`Ctrl+a Ctrl+a`
+    - Send the escape character to the frontend
-- 
2.47.2


