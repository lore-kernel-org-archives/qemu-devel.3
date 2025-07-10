Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7135C83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZon2-00021V-Jc; Thu, 10 Jul 2025 06:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZomh-0001rC-DN
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:45:51 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZomZ-00078C-Ud
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:45:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso8982555e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752144338; x=1752749138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/kn+Nlme/iAkqffgZvptFY3jhjfV+Qi2QuRGeFFxrUg=;
 b=LJThjoHtyAsPT9vWMffJu8fRNU/Pq7r5LQnl25T451xatxofd13/CD3eE1pEhV6Jxw
 hVhsvfZZfrEYH3FgZWJpRBQGskfES20nzdZtWZztk4l0q7DXB/YQ8c9WVVQA/R0PjDa6
 ErMRlc/wYCz3x98UWfHCffD1bIFxcmK/1z6Fv4aGLmVnfZAQGG2G/QG3rqrQOgxnCuWK
 UcDUZPHAwDfqZLsFvhBDAv7LqewsOM48KKfQdry9lRHP5gvUgvEXoqJmMjkDYWpgL4CF
 uWexl2vO3CbM4OEQP16DDk6PL+snG52kjVNryU8k37kplRLacvFgiDHxleAawGWerEsM
 9RJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752144338; x=1752749138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/kn+Nlme/iAkqffgZvptFY3jhjfV+Qi2QuRGeFFxrUg=;
 b=l2Y2fT4Sth5xIDiwPm/1mfgFz40AYB6zgOSqSn+wb7m6HWIrdWJ384D/rRU5PN+f5u
 GdI7FD8pAaKSCAK1UGHd9d/7DuJVoKiL53ofiqz5vZYJ3BdrUAkEXvdUnsgrvg9yhmar
 zIS7EtlSnghkW+u01JXxEglkiiI/lAF2ErFhjg+dDWeXdhHhPV36ElXbubijYXM3PwPt
 2Sk0+NEvsD07Zd71jHsrxiyEmIfBWysUSIlY1obP3Pu90iya3/cuN3ITIAsQr3wbKxdi
 TlSyalZ8r2NiFpZXctzQXvrgrguGnoKBIa4H+YgCEogEo3YU2dn1dR5GMyH4Iom1Euyi
 LoJA==
X-Gm-Message-State: AOJu0YxJkT8jurUO9lvl5PaZcCtsjTmeGM5mWU/GhC4vgOICy8dpUmBF
 j/+K1rkQB58tX9sHTFdckTH0wcWvwmVHwQ+uHB6vk1eQPdKNskE2maLqfEijLeJRaZE=
X-Gm-Gg: ASbGncuBIUHC/PG2hig00lDUU9IG8cKK6+J3cM4Ol8r/9b5ISNkK8NskWyU+6RXiU9Z
 2jVT3bXW0sNNWq8h/4uM9lFFLG10VvqXjiiSmpzUXLaHHWJdUtsetQkYPvHmi6PzZJySnHJzhkA
 U3+vcM9Fd9npnCZjZWcIxzuAhMPtroL1fv9wEotfYzFe2qdhzl8fVMBT04ZLnt3y38oKS9aDapj
 3bUEl9mTbuSkLbPU8DYi+yEEgvH4z6MuhJuDeC5WylZ6eApylwKnhuh/ZgmCSOC7MNvNkfvd5Uf
 naargNiJScfuoUDpIYnrm1dnG4qBah3lVQqj0Jw67L1uQgk6D5OknM61NSfu+jw=
X-Google-Smtp-Source: AGHT+IHTgRA7pgf1Mh+2rw9zldooRzB6GIP2uUxDs22K2ZKN36igrTMdd6T74rRfvOJj+DKWSzGFZA==
X-Received: by 2002:a05:600c:a00c:b0:43c:f44c:72a6 with SMTP id
 5b1f17b1804b1-454dd1f3edbmr19383905e9.2.1752144337535; 
 Thu, 10 Jul 2025 03:45:37 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d511bd6dsm55989185e9.38.2025.07.10.03.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 03:45:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C71665F8CC;
 Thu, 10 Jul 2025 11:45:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 6/7] docs: use :kbd: role in sphinx docs
Date: Thu, 10 Jul 2025 11:45:29 +0100
Message-ID: <20250710104531.3099313-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710104531.3099313-1-alex.bennee@linaro.org>
References: <20250710104531.3099313-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 docs/devel/testing/main.rst     |  4 +--
 docs/system/images.rst          |  2 +-
 docs/system/keys.rst.inc        | 49 +++++++++++++++++----------------
 docs/system/linuxboot.rst       |  2 +-
 docs/system/mux-chardev.rst.inc | 38 ++++++++++++++-----------
 5 files changed, 51 insertions(+), 44 deletions(-)

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


