Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9285CD3000F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1nja-0000yF-Uq; Fri, 18 Oct 2024 10:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1njY-0000w7-D5
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:13:40 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1njV-0006xK-VY
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:13:40 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso6479485e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729260816; x=1729865616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/CHgIXie95gPd8mgM7wMcsIUcDpBmAMsOaaghgDk4m8=;
 b=OD6JZv4KtqY/RyUqrW/NoTMzKgtK5FJ6DbSQPbPQ4ijTqpBGfS3JdzVFjDndoywkEm
 ZRDcS0KKU5ESVB6R8pXOXSTga7s37BNM2j6E4NkD+2zm/xzZpN0sUxFb3KmVlIkVd00e
 x4ZZDAZJeO44/fv6rgx36f8rcz1cxonGzi0XlqdCSmas9V/1wCdoEVI+KENnOcGV4S5h
 5JuKE9Bpf+H1DHiCBSjbTbDKYAWzh8jIzb14ScRZkxMVeIrCOAPLVwbwnGA7ZT/5jbzc
 8I6b3V3uilk6uoNm1lDaTqO12hM6uUmdYkPMXNitiycoJG91vaxT+uZNfc2CqKHpUf5G
 vNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729260816; x=1729865616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/CHgIXie95gPd8mgM7wMcsIUcDpBmAMsOaaghgDk4m8=;
 b=hlYbjzRpYydklCGPcIvycLuVe06QiWIbu+QMH5SXvzwtyn8LkYL5x2nh6H8oMsnvk1
 D3f7fOZnkmhnXW1jOBlr7jcPoYi0EeN+sbqzZktps+dS8mUDHVsbmijOTC4Pl/1f5yI2
 VcJV8t/gG9EerF73XYoHakbOY7OElSRlRdoH5UWW34e/WChoY2UmxkHQOD9x0ck/yXpf
 OnK2WTA2UL9czmZPK2VzYviD4PZ/MQu5cCRhnb4f3v4aL2C0V333wIH8Qa6vcUAkePPw
 9xCUK+NwSYFrU+xVKLANVtQ5ucD0iNRFJmB6YSfCF9DhBC8YvUP8BHjihyrnPBn9B1J1
 9xNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9kVsnSNRmLpDYW6mtuwcjA61JP/Z7pVSkUySBuutw6oAgFotkLGaC7g8SY33yXywGKTZ2cH5PpGVF@nongnu.org
X-Gm-Message-State: AOJu0YzaEg3qziC/HpA5hLPCUAFpuDaXIvilyeV0eFq+r9VamBmCQg3g
 490Qy+dTRY39ELLaHZc8F/BwcLKmogdpPrajY5pBmNFAW1MV/F2akOu6cBxN+vk=
X-Google-Smtp-Source: AGHT+IE/LHxjua8FHvmPZ3dzgmWfOdxer9v+JSj3UH/Q2gqOnSUPFRgTmiKM8aKTdYIOlY9xFwSaoA==
X-Received: by 2002:adf:ec12:0:b0:37d:50e7:8c56 with SMTP id
 ffacd0b85a97d-37ea213ffd2mr1768853f8f.11.1729260816407; 
 Fri, 18 Oct 2024 07:13:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf0ecd89sm2040086f8f.78.2024.10.18.07.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:13:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 3/7] docs/system/arm: Split fby35 out from aspeed.rst
Date: Fri, 18 Oct 2024 15:13:28 +0100
Message-Id: <20241018141332.942844-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018141332.942844-1-peter.maydell@linaro.org>
References: <20241018141332.942844-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

The fby35 machine is not implemented in hw/arm/aspeed.c,
but its documentation is currently stuck at the end of aspeed.rst,
formatted in a way that it gets its own heading in the top-level
list of boards in target-arm.html.

We don't have any other boards that we document like this; split it
out into its own rst file. This improves consistency with other
board docs and means we can have the entry in the target-arm
list be in the correct alphabetical order.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                |  1 +
 docs/system/arm/aspeed.rst | 48 --------------------------------------
 docs/system/arm/fby35.rst  | 47 +++++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst |  1 +
 4 files changed, 49 insertions(+), 48 deletions(-)
 create mode 100644 docs/system/arm/fby35.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index c21d6a2f9e1..dff8073c5bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1121,6 +1121,7 @@ F: include/hw/*/*aspeed*
 F: hw/net/ftgmac100.c
 F: include/hw/net/ftgmac100.h
 F: docs/system/arm/aspeed.rst
+F: docs/system/arm/fby35.rst
 F: tests/*/*aspeed*
 F: hw/arm/fby35.c
 
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 968ba88b997..63910d382fe 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -257,51 +257,3 @@ To boot a kernel directly from a Zephyr build tree:
 
   $ qemu-system-arm -M ast1030-evb -nographic \
         -kernel zephyr.elf
-
-Facebook Yosemite v3.5 Platform and CraterLake Server (``fby35``)
-==================================================================
-
-Facebook has a series of multi-node compute server designs named
-Yosemite. The most recent version released was
-`Yosemite v3 <https://www.opencompute.org/documents/ocp-yosemite-v3-platform-design-specification-1v16-pdf>`__.
-
-Yosemite v3.5 is an iteration on this design, and is very similar: there's a
-baseboard with a BMC, and 4 server slots. The new server board design termed
-"CraterLake" includes a Bridge IC (BIC), with room for expansion boards to
-include various compute accelerators (video, inferencing, etc). At the moment,
-only the first server slot's BIC is included.
-
-Yosemite v3.5 is itself a sled which fits into a 40U chassis, and 3 sleds
-can be fit into a chassis. See `here <https://www.opencompute.org/products/423/wiwynn-yosemite-v3-server>`__
-for an example.
-
-In this generation, the BMC is an AST2600 and each BIC is an AST1030. The BMC
-runs `OpenBMC <https://github.com/facebook/openbmc>`__, and the BIC runs
-`OpenBIC <https://github.com/facebook/openbic>`__.
-
-Firmware images can be retrieved from the Github releases or built from the
-source code, see the README's for instructions on that. This image uses the
-"fby35" machine recipe from OpenBMC, and the "yv35-cl" target from OpenBIC.
-Some reference images can also be found here:
-
-.. code-block:: bash
-
-    $ wget https://github.com/facebook/openbmc/releases/download/openbmc-e2294ff5d31d/fby35.mtd
-    $ wget https://github.com/peterdelevoryas/OpenBIC/releases/download/oby35-cl-2022.13.01/Y35BCL.elf
-
-Since this machine has multiple SoC's, each with their own serial console, the
-recommended way to run it is to allocate a pseudoterminal for each serial
-console and let the monitor use stdio. Also, starting in a paused state is
-useful because it allows you to attach to the pseudoterminals before the boot
-process starts.
-
-.. code-block:: bash
-
-    $ qemu-system-arm -machine fby35 \
-        -drive file=fby35.mtd,format=raw,if=mtd \
-        -device loader,file=Y35BCL.elf,addr=0,cpu-num=2 \
-        -serial pty -serial pty -serial mon:stdio \
-        -display none -S
-    $ screen /dev/tty0 # In a separate TMUX pane, terminal window, etc.
-    $ screen /dev/tty1
-    $ (qemu) c		   # Start the boot process once screen is setup.
diff --git a/docs/system/arm/fby35.rst b/docs/system/arm/fby35.rst
new file mode 100644
index 00000000000..742b887d44c
--- /dev/null
+++ b/docs/system/arm/fby35.rst
@@ -0,0 +1,47 @@
+Facebook Yosemite v3.5 Platform and CraterLake Server (``fby35``)
+==================================================================
+
+Facebook has a series of multi-node compute server designs named
+Yosemite. The most recent version released was
+`Yosemite v3 <https://www.opencompute.org/documents/ocp-yosemite-v3-platform-design-specification-1v16-pdf>`__.
+
+Yosemite v3.5 is an iteration on this design, and is very similar: there's a
+baseboard with a BMC, and 4 server slots. The new server board design termed
+"CraterLake" includes a Bridge IC (BIC), with room for expansion boards to
+include various compute accelerators (video, inferencing, etc). At the moment,
+only the first server slot's BIC is included.
+
+Yosemite v3.5 is itself a sled which fits into a 40U chassis, and 3 sleds
+can be fit into a chassis. See `here <https://www.opencompute.org/products/423/wiwynn-yosemite-v3-server>`__
+for an example.
+
+In this generation, the BMC is an AST2600 and each BIC is an AST1030. The BMC
+runs `OpenBMC <https://github.com/facebook/openbmc>`__, and the BIC runs
+`OpenBIC <https://github.com/facebook/openbic>`__.
+
+Firmware images can be retrieved from the Github releases or built from the
+source code, see the README's for instructions on that. This image uses the
+"fby35" machine recipe from OpenBMC, and the "yv35-cl" target from OpenBIC.
+Some reference images can also be found here:
+
+.. code-block:: bash
+
+    $ wget https://github.com/facebook/openbmc/releases/download/openbmc-e2294ff5d31d/fby35.mtd
+    $ wget https://github.com/peterdelevoryas/OpenBIC/releases/download/oby35-cl-2022.13.01/Y35BCL.elf
+
+Since this machine has multiple SoC's, each with their own serial console, the
+recommended way to run it is to allocate a pseudoterminal for each serial
+console and let the monitor use stdio. Also, starting in a paused state is
+useful because it allows you to attach to the pseudoterminals before the boot
+process starts.
+
+.. code-block:: bash
+
+    $ qemu-system-arm -machine fby35 \
+        -drive file=fby35.mtd,format=raw,if=mtd \
+        -device loader,file=Y35BCL.elf,addr=0,cpu-num=2 \
+        -serial pty -serial pty -serial mon:stdio \
+        -display none -S
+    $ screen /dev/tty0 # In a separate TMUX pane, terminal window, etc.
+    $ screen /dev/tty1
+    $ (qemu) c		   # Start the boot process once screen is setup.
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 3c0a5848453..9c01e66ffa9 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -90,6 +90,7 @@ undocumented; you can get a complete list by running
    arm/digic
    arm/cubieboard
    arm/emcraft-sf2
+   arm/fby35
    arm/musicpal
    arm/kzm
    arm/nrf
-- 
2.34.1


