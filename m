Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B152EE0203
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagzn-000544-4f; Tue, 30 Dec 2025 16:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagzl-0004vL-HB
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:11:09 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagzj-0002qm-5y
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:11:09 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47d182a8c6cso46317115e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767129065; x=1767733865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5sapxdoJCIiWphE18QsmorB7fBOlZsGQoNSD08EFBC8=;
 b=xbpRysB2O1T/1H1t59cNF7uDICFsQJjEGmawSivYjtlzoycbR8l97+msSPvFS6xDqf
 i5mdSybEzkFXw9NJBE2giKXajoK7KHsrmN9T/bC6FAcPWSTs5YZYyc5tCgmTIO4+Dk5V
 4n3Ufhbl8byjvqDbUWjKwmXsK8TzmgaPj1jfIUxijSAltZ7pVh6hj0fB/uIeWj6cOSFq
 WNzE8DFNh92Xrq+KqqqvrKdneu19nVEi9038FyI6d/pGX0cglPzNjmfZ9y2dXEiZR7Su
 DubfP4jFZTEAp7hUzQxGuKIkg1KBp8EI0oUcMfrNzGqh4BKj9Azvb/ROrjR/Uc6BOHkp
 i7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767129065; x=1767733865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5sapxdoJCIiWphE18QsmorB7fBOlZsGQoNSD08EFBC8=;
 b=xJ7LsFMXWmCAqjppwMCWkxrMmkjZcRpNXV8ar+1TVZA5FlMBL60mG7Tc7Vw1xqqE0L
 6T/d1d0OzEn1awU7QyMEIN4+YVhTBYeRdCdCWXRV+JvyX4B/1++1NrlXZKrjG8PKBrCi
 uO3olpRLlgvT7FlyPI4T8YB6nOumnqlfLJlJQxM87jI4k/RSR0RYi7XKesO1YRV7nCcY
 lkYu3gbooQag9kwzcMm3Hqg+GyoA8kwKTa53s5nFXYXg2nS7eYgmITUvK65jZXSUlfsl
 LVY/rkHu4b8iOoLuSKP2/3EoEXrjkz6W80l5WBX+iJC8KKb/J4GwezPMwEpRDetayF7l
 4c0g==
X-Gm-Message-State: AOJu0YysvNOxwjYuupeV0hlLN9CdiUrY54w/Q/PpTlv+v16vAYtzmWed
 MwxKsDOUYUQ72C/ZUCorBj0qIsVptV3LNhp7b3qF6nxYoqcrQEQFIaf/yLNf/vzOfG9P9pqzNxb
 BpJBO+/c=
X-Gm-Gg: AY/fxX6i/McKH8gIl3PjxFv+JMnVu/NJ1kDVetDLb/EB8On4vZ6vXwHcidL0hT5G05p
 BJqYnQFB15t4C40L3XpBn1sTfR7rBwchqizMoU075iCMMLvcscjZf8W5E9Sa82t3R96Xu3ZOD+6
 ghU+/1e5k1wdi+/lruMxoUvfM12XCNeH12D++BIPBUBc8lzgtzsENuGhcuh14c2VcbkCst3cl97
 iyoPV5Q4oATwIL/TAwjLi+wO9zzWh5UAr2RRaEIy7gmgk4AJ4HFD8wwOElbOAah2CQdBdvBpG6c
 m4gWM2clMUozL8hakRXJsIGZjgLltaOKKF4KK/Nhyr3Ne321yqGyvBBS+Zmtz5guArnErcJsTKF
 5MGwaCB5+3dzjKviwmbuZXJGGgyhyMr4HyJ/j6fROwU9z7vXjN3+lLUBp2/0HxZ5km7hpZYhcl2
 rrk1AaRbzXQBo5k61c1UQZyrukC3nyAS07w+iHbZmphf+Xezgklx1phJZxpUde
X-Google-Smtp-Source: AGHT+IGRd4Y0tg5sJUgsALMktaVVj4c3IHKf6wnw3XwKFoAxWdn+7NW2tcMjDFX/yKRNwhRcm7LWRA==
X-Received: by 2002:a05:600c:45cf:b0:47a:7fdd:2906 with SMTP id
 5b1f17b1804b1-47d1954a550mr403244635e9.12.1767129065228; 
 Tue, 30 Dec 2025 13:11:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3acdb87sm261123515e9.16.2025.12.30.13.11.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:11:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/34] configs/targets: Mark targets not using legacy
 ldst_phys() API
Date: Tue, 30 Dec 2025 22:07:50 +0100
Message-ID: <20251230210757.13803-29-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

These targets were only using the legacy ldst_phys() API
via the virtio load/store helpers, which got cleaned up.

Mark them not using the legacy ldst_phys() API to avoid
further use, allowing to eventually remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251224151351.86733-10-philmd@linaro.org>
---
 configs/targets/mips-softmmu.mak     | 1 +
 configs/targets/mips64-softmmu.mak   | 1 +
 configs/targets/mips64el-softmmu.mak | 1 +
 configs/targets/mipsel-softmmu.mak   | 1 +
 configs/targets/or1k-softmmu.mak     | 1 +
 configs/targets/riscv32-softmmu.mak  | 1 +
 configs/targets/riscv64-softmmu.mak  | 1 +
 configs/targets/sh4-softmmu.mak      | 1 +
 configs/targets/sh4eb-softmmu.mak    | 1 +
 configs/targets/sparc64-softmmu.mak  | 1 +
 configs/targets/xtensa-softmmu.mak   | 1 +
 configs/targets/xtensaeb-softmmu.mak | 1 +
 12 files changed, 12 insertions(+)

diff --git a/configs/targets/mips-softmmu.mak b/configs/targets/mips-softmmu.mak
index c9588066b8d..95397af9442 100644
--- a/configs/targets/mips-softmmu.mak
+++ b/configs/targets/mips-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=mips
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/mips64-softmmu.mak b/configs/targets/mips64-softmmu.mak
index 7202655fcac..f9cc41b9ed4 100644
--- a/configs/targets/mips64-softmmu.mak
+++ b/configs/targets/mips64-softmmu.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=mips64
 TARGET_BASE_ARCH=mips
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/mips64el-softmmu.mak b/configs/targets/mips64el-softmmu.mak
index 3ebeadb29ea..4e7dedc5f30 100644
--- a/configs/targets/mips64el-softmmu.mak
+++ b/configs/targets/mips64el-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=mips64
 TARGET_BASE_ARCH=mips
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/mipsel-softmmu.mak b/configs/targets/mipsel-softmmu.mak
index 90e09bdc3e5..b0fba8a9d0a 100644
--- a/configs/targets/mipsel-softmmu.mak
+++ b/configs/targets/mipsel-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=mips
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/or1k-softmmu.mak b/configs/targets/or1k-softmmu.mak
index 0e47d9878b0..89f81b75bf7 100644
--- a/configs/targets/or1k-softmmu.mak
+++ b/configs/targets/or1k-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_BIG_ENDIAN=y
 # needed by boot.c and all boards
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/riscv32-softmmu.mak b/configs/targets/riscv32-softmmu.mak
index db55275b868..7476e596082 100644
--- a/configs/targets/riscv32-softmmu.mak
+++ b/configs/targets/riscv32-softmmu.mak
@@ -4,3 +4,4 @@ TARGET_XML_FILES= gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xm
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv64-softmmu.mak
index 2bdd4a62cd2..f836f08c5b9 100644
--- a/configs/targets/riscv64-softmmu.mak
+++ b/configs/targets/riscv64-softmmu.mak
@@ -5,3 +5,4 @@ TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xm
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/sh4-softmmu.mak b/configs/targets/sh4-softmmu.mak
index 787d349b501..e0b51f8108d 100644
--- a/configs/targets/sh4-softmmu.mak
+++ b/configs/targets/sh4-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=sh4
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/sh4eb-softmmu.mak b/configs/targets/sh4eb-softmmu.mak
index cdea2c61c58..7850dac8191 100644
--- a/configs/targets/sh4eb-softmmu.mak
+++ b/configs/targets/sh4eb-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=sh4
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index d9d51d21e59..8ee6d057682 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_BASE_ARCH=sparc
 TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES=gdb-xml/sparc64-core.xml
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/xtensa-softmmu.mak b/configs/targets/xtensa-softmmu.mak
index 2a9797338a6..6aad751e2ba 100644
--- a/configs/targets/xtensa-softmmu.mak
+++ b/configs/targets/xtensa-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=xtensa
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/xtensaeb-softmmu.mak b/configs/targets/xtensaeb-softmmu.mak
index 5204729af8b..537407e11ae 100644
--- a/configs/targets/xtensaeb-softmmu.mak
+++ b/configs/targets/xtensaeb-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=xtensa
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
-- 
2.52.0


