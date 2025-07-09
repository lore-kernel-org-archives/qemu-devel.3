Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0756BC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 14:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZVrV-0002gN-8B; Wed, 09 Jul 2025 10:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZVrF-0001sa-UF
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 10:33:14 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZVrD-0003NE-OA
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 10:33:13 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ae0d7b32322so879766166b.2
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752071588; x=1752676388; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+hfjAWXDxvM+VpfM6oeM6qtXCYmcXh46AAcGxUC9QOA=;
 b=UupkUFgO4Uj0fG7UEnuMtmsl0K76PDwF8uV0hrS/XJA5+CgYY/eUZsiUYTfIZ3MBlI
 n2U+bEm4Fc7maaJe6t2Ifbr41bWe0soqIfP52yCs1DDYMgEpDV+mPno+iPO4zeABWPBP
 hOscwQbjQ1/NGcoRNulAyi2rS9Ifgjm+Iy5QFqqJdCbIJoJcglqNH/OG20Xa+K3HkY0O
 5gT97yuZ2Bq66UbXR4wy4b+YQeVFXGbyqL8DEF8TYF3snOk+TzVVaPXHObCKX4lYxXIc
 W4f7LP6z3iHmMfXyWLD6j3v6xUnMFWGnXc55V2CUqaSO4GjGNAfq/LxjWwpZS6JdKNta
 e1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752071588; x=1752676388;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+hfjAWXDxvM+VpfM6oeM6qtXCYmcXh46AAcGxUC9QOA=;
 b=arTOfD0pgDoQe1ZwoHePTmNf8vuBuaXv1wutVbhkpioNHt7xTATlB9SUg3pO2vWMOK
 1c2aS+Kyl+hAPOKh2Mmj5e1rXeCQatmcrkX3ViUS3hLjALBbpfA01W1rW2x5aqUNByeu
 e7SBRPorLgqFQGw4ItTSWQ8gjUlByK8GTHLcoprANlM+qRnIt2zHs8Arde/5Gs3Hj1Kh
 N9FpNRCvhWxTVqdytKRrCmrzng9T9yc8p5QeLMQ6gFdtkMz6iMS/UElBfUYk7afT+xFp
 axJi1rcg5SQs240Bo82SWJyx2bvRJ/FkVlcieTf1DToROZYxmK1243om/kzmYyTHqmpj
 UfaA==
X-Gm-Message-State: AOJu0YxTyMg82F70bteFmP2mU2L2c61kE84/Wj+oet75C+Qo96WmxazU
 E+2NYrUtQvJHpVXxIgRre19gRXjh3giCTQ5fCr8u+04Tle5dwSlf7ZlpOYlFcBbNFWE=
X-Gm-Gg: ASbGncvVqYpax3Jj2mrUf3ljqC+tlHLTgaEq3V9PNn0kRBO7q8monTrAE+KsTs9rgzh
 Eov8jyRPNS6kOKah1taffEXRMkd5mVVS+5mZSBsXCLSmBUm8EyauqxtR2gM7SjP97q4jPUAlPKB
 1PqsfdBOkAwc4lOGtUJKiI0cbq9/P577O5sfyfTxa3cBZfmxjehQvkIeZDaMG65srzu2Hi80l/J
 UVQV2MmBNEVHuqg5cauCt/X8/aSo4aywDAkixWKQlQBu2AyLfCexRpOm4LTjBVCoO6WP7RNkBzj
 Gxy05TCR1pHE2ZqU+B9WCHSvUQTGPjS5SzCcoERjJjXdHEQk2foZYV+wIsrjlad+N+IpEP6vvJb
 VqFDkAYKWMpdcH3tqDa2EtS4SWbRwK3g=
X-Google-Smtp-Source: AGHT+IGuJRkx58XYJSwoC3GcXMJsC2DZQX9DuyjYXkAEMq7sLEiU7+5ssBWm+tv0kWbp2kOf6LYufQ==
X-Received: by 2002:a17:907:7245:b0:ae1:f1e3:ccea with SMTP id
 a640c23a62f3a-ae6cf589165mr316549466b.7.1752071588044; 
 Wed, 09 Jul 2025 07:33:08 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4440352.home.otenet.gr. [79.129.177.16])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f691a084sm1121551966b.38.2025.07.09.07.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 07:33:07 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 09 Jul 2025 17:32:59 +0300
Subject: [PATCH v2] docs: use :kbd: role in sphinx docs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250709-docs_rst_improvements-v2-1-cb5096ad0022@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJp9bmgC/4WNQQqDMBBFryJZNyWJpEpXvUcRMcmoAzWRGQkt4
 t2beoEu34P//i4YCIHFvdoFQUbGFAuYSyX8PMQJJIbCwihjVaNqGZLnnnjrcVkpZVggbiz1qLy
 rvW3acBNluxKM+D67z67wjLwl+pw3Wf/sv2LWUksVnPMWnG0b/XhhHChdE02iO47jCyWRj3W7A
 AAA
X-Change-ID: 20250703-docs_rst_improvements-1f0cb3c578d6
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7359;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=F5VBliLP0naRNk5ALatyooY5uATa0waQzUCGrASX5Ms=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9ibjJpa3JJOUNvQU1WZWdwekxKUWlBMCtzc2NKCjVZcnlaS3RMS1pRZ1V3WENp
 aDZKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUc1OW9nQUt
 DUkIzS2Nkd2YzNEowRllLRC85aWFCcjd5Y1dPUk9YSkhWc1d5Q3N3akZHUDRLaFVUakpIZ2R4eQ
 pnWjV3bUtBZDZFU1FkREZRSUJoclQzZk43ZDA2VkEwd2t3NTZ3dU1iMmFKaWtxcmZ5SmFia0tFS
 WVuNmE4WHE5CkV5c3hoY2VDMjM5SEhsWCsyTkRIMzJQbmdEYzNlT2ZKQVJJMG1CRVpsekhzQ3Rt
 QmwwTSs2L2tQak50bVhySkoKbWdwWG9rMDVUalEwZUxjZUJCTGtGbkpXMmIyMitWaEI2M09Xc3R
 HcElMclZMZG02cjB6SVR0a00xVzdaWEVDcgpDRkhaaGhHS05YejdHR25iUWRxbGNqdGtTdFhMck
 5XN2U0SFFqR2p2VzFXK1ZUODJoSmttVXkxbzY1eGtsUHV1CjFPbVovOGVhKzViYmtHZWxUSXhGZ
 U9OQzM5VmZJY3BmOEZMaXBEcGordlQzdkcrcTNydDg1NHhVV0F1TXlaYzAKeHZEM09qK3RUVjVO
 VGFGaEF6RDhCSkY4QU82MHQ2MzhJVWoyOUJEZ3ExVlhQejh3ZUhtamk3NWkzcmRjdmZXMQpCRnB
 3azRYT3kyaDRCaEpoOGN4NzBkaWNnSVV4UUxTMWUzR0tyZzVRZXB4dXE4NDU0Wi9ycXUwWW00U3
 AyYjA3ClFmZS9CaVdwNCtURHUyeWJiR21UWVVQa1hoM09rMUYzTTRWclhHMDJSNXdKUk9qWnlNN
 jV4clN2ZDNzbXo1Wi8KMlArVGxrMmJaUEJrYU80aGVvUXQzOHdSazhwRVl2VHRZZW9PcmdWWHM4
 R1FmL001MG1EUE1wVUxvQlE0TmVibgpWektva0pOTXg2aFdSdmRHZmRvelRlN244NWVtTjZvTWp
 ZTmUxQ2xSejRRU2htcWo2NU5xVFRQZkNybzBCdkw2Cks0Z3FBQT09Cj1NQTBFCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x632.google.com
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

Sphinx supports the :kbd: role for notating keyboard input. They get
formatted as <kbd> HTML elements in the readthedocs theme we currently
use for Sphinx.

Besides the better visual formatting, it also helps with accessibility
as screen readers can announce the semantics of the <kbd> element to the
user.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Changes in v2:
- Formatted multiplexer key list as a table (suggested by Alex)
- Link to v1: https://lore.kernel.org/qemu-devel/20250703-docs_rst_improvements-v1-1-0dbbc5eb5871@linaro.org
---
 docs/devel/testing/main.rst     |  4 ++--
 docs/system/images.rst          |  2 +-
 docs/system/keys.rst.inc        | 49 +++++++++++++++++++++--------------------
 docs/system/linuxboot.rst       |  2 +-
 docs/system/mux-chardev.rst.inc | 38 ++++++++++++++++++--------------
 5 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index 6b18ed875cd91e961d07b3afa3179c7fba0e5fe3..2b5cb0c148048e3a81d2db8c4a9500591880997f 100644
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
index a5551173c9789323ceb150c51fd68c6d4ef80d71..43706969fddae7bcb83de172b1a04b5c6cffe0f1 100644
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
index 59966a3fe7cf2cbb6a19dacd48612b768b7a1e96..c28ae1a2272707d292a159c2650bd6bf6a4c1e19 100644
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
index 2328b4a73d55b47d731497d57ddb1a837ef5d7dd..f7573ab80aa269bac870d7e6e5596a8f02fbd5f3 100644
--- a/docs/system/linuxboot.rst
+++ b/docs/system/linuxboot.rst
@@ -26,5 +26,5 @@ virtual serial port and the QEMU monitor to the console with the
    |qemu_system| -kernel bzImage -drive file=rootdisk.img,format=raw \
                     -append "root=/dev/sda console=ttyS0" -nographic
 
-Use Ctrl-a c to switch between the serial console and the monitor (see
+Use :kbd:`Ctrl+a c` to switch between the serial console and the monitor (see
 :ref:`GUI_keys`).
diff --git a/docs/system/mux-chardev.rst.inc b/docs/system/mux-chardev.rst.inc
index 84ea12cbf58f9550154411f8951e6f608179a091..c87ba31362965c4e06d892217df7fedebcb3092c 100644
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

---
base-commit: df6fe2abf2e990f767ce755d426bc439c7bba336
change-id: 20250703-docs_rst_improvements-1f0cb3c578d6

--
γαῖα πυρί μιχθήτω


