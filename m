Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0E3CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBXT-0002Wn-Ci; Wed, 27 May 2026 06:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBXN-0002WK-3B
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:30:57 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBXL-0000Va-Bb
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:30:56 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-449de065cb3so11343840f8f.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877854; x=1780482654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FJ8ak+0/XSX/wIzO+MXBzVbVY4iJXA3Z+okdJxd6QFU=;
 b=dpbVudN+tA5HSNKxCURrdBc1IOfltym9v1dr0vMqO7QAGWmoqRY61GTB29YPftZ2bm
 WM1VmCXn/ndquRo6N87MEGcligQg5waWnr2L8JsWEJ8y9KmrVbBSMbolE932BWvhGPuP
 T3UHuwSBBKRMUkdl7ApiTXNsVHklbG1+JEo/uFaiBdX1xP2lgFDU3EEPTLVtoQhl8z7e
 +r3Ko/c9wkk4tsKlvBZZq7TZEsbkaEcrUkq6NtZ8p191vgxtW2jMjnVod3tJ3pRWB7es
 YyyGO5GCQGYktNHCDexkeSPIsrmFUhEpplLvW1sYzkLqnVrSjL8CIZmCpROjVTnIHUqA
 X9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877854; x=1780482654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FJ8ak+0/XSX/wIzO+MXBzVbVY4iJXA3Z+okdJxd6QFU=;
 b=gkG3Uh81nLC/esB3tw7wIJc0rwx9A5OGJWJcejZ3f2whO3wNJGXsEYMdYTHOPGMNy4
 RA+Ctzl0+vZvGUSMJew8mD9Jzv4uJ93J0OPJMljxEIU0DIfH2oBXKQd0xddAHZ+kpxpt
 QE5tzxN2bB9fsBjaXT0sR0NpVzNZ4gylq0b1Ku1eOIfvGlEML7ISynH+u+QFmDO604pL
 xiUOYNNhINyQEB8guqibJ7Jsvu2/zmkvK08ilT4mMHb6Py0pA5sEfipMLKg+cLHoP7Ux
 5BgJCvSCKCBoh8Vf7nOwNKVMQQ/okdhDrOCqfhbczi0WnyLGzGjaFLQnOLWk0bCInPH0
 uk8g==
X-Gm-Message-State: AOJu0YwyCOk776/oHCjCCmxeKbtWW701mCk6dQeiFH1WDCD4NGi9BGgn
 b1+uVO9UFXWOF4h/TGXvZredpKnB0ZW+D3F9YV7G5vO9/4Bg2DSA5vRrMEcihZB34tc3oyy/LxS
 03ocN8qPUnA==
X-Gm-Gg: Acq92OElExfAcVIxDvLx4ZOPIjGr+MhiU6pSwQat8lMNkSOJzbjfV8ctidv2YFn5hzE
 rzP3hbsMswQU25RfK8rNpBCeWE33WVidKYpn/FrA4YS+X22ze8Al45AvbBscTJ33l+fw3Xk8/j6
 FR8XcRilo7mj+IGMICrEk/if4Y4dIeeiy0FjbUbf8pd/6WswWXjrxi/l0wrQsEdbs+C8GmENbf4
 C/wC0YIOzaHBDzbZV30VxU29Ued4ISh5HRjVtvnHJ7+LKeGZUU9rtSoT9jD9J4E66I0OWtW8HVB
 5Oz+2gG3zXfNPm57gCD7hIQ27gfVElzYM6yDyoqvEhnhGAgDDai9Soy2yQmHfNjXdSyx7Q52htM
 ReBsq+aqGvoquck0ICm7YcewEGIJt9X0Q5PgohDkXidjsfahUusuiKLNzaGb0mB0/OsdfYKRclp
 gEmCJ5TiDk4PeOg53CoHM37mw4BhgVbQPFYAddTuu7kJmJ6nHd6g8nb60=
X-Received: by 2002:a5d:5e8c:0:b0:43c:f90b:5668 with SMTP id
 ffacd0b85a97d-45eb36acd72mr36118042f8f.23.1779877853251; 
 Wed, 27 May 2026 03:30:53 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb54a432sm7149104f8f.3.2026.05.27.03.30.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:30:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/32] hw/riscv: Add macros and globals for simplifying machine
 definitions
Date: Wed, 27 May 2026 12:30:06 +0200
Message-ID: <20260527103037.4461-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

From: Anton Johansson <anjo@rev.ng>

Adds macros and global interfaces for defining machines available only
in qemu-system-riscv32, qemu-system-riscv64, or both.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20260520-hw-riscv-cpu-int-v3-3-d1123ea63d9c@rev.ng>
[PMD: Constify InterfaceInfo]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/riscv/machines-qom.h | 26 ++++++++++++++++++++++++++
 target/riscv/machine.c          | 19 ++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/hw/riscv/machines-qom.h b/include/hw/riscv/machines-qom.h
index 69fcf61fd72..ee346227bb2 100644
--- a/include/hw/riscv/machines-qom.h
+++ b/include/hw/riscv/machines-qom.h
@@ -17,4 +17,30 @@
 #define TYPE_TARGET_RISCV64_MACHINE \
         "target-info-riscv64-machine"
 
+/*
+ * Interfaces specifying whether a given QOM object is available in
+ * qemu-system-riscv32, qemu-system-riscv64, or both.
+ */
+
+extern const InterfaceInfo riscv32_machine_interfaces[];
+extern const InterfaceInfo riscv64_machine_interfaces[];
+extern const InterfaceInfo riscv32_64_machine_interfaces[];
+
+/*
+ * Helper macros for defining machines available in qemu-system-riscv32,
+ * qemu-system-riscv64, or both.
+ */
+
+#define DEFINE_MACHINE_RISCV32(namestr, machine_initfn) \
+        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
+                                            riscv32_machine_interfaces)
+
+#define DEFINE_MACHINE_RISCV64(namestr, machine_initfn) \
+        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
+                                            riscv64_machine_interfaces)
+
+#define DEFINE_MACHINE_RISCV32_64(namestr, machine_initfn) \
+        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
+                                            riscv32_64_machine_interfaces)
+
 #endif
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 6776e7bf5a1..b92e38b11a7 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -22,7 +22,8 @@
 #include "system/kvm.h"
 #include "migration/cpu.h"
 #include "exec/icount.h"
-#include "debug.h"
+#include "target/riscv/debug.h"
+#include "hw/riscv/machines-qom.h"
 
 static bool pmp_needed(void *opaque)
 {
@@ -522,3 +523,19 @@ const VMStateDescription vmstate_riscv_cpu = {
         NULL
     }
 };
+
+const InterfaceInfo riscv32_machine_interfaces[] = {
+    { TYPE_TARGET_RISCV32_MACHINE },
+    { }
+};
+
+const InterfaceInfo riscv64_machine_interfaces[] = {
+    { TYPE_TARGET_RISCV64_MACHINE },
+    { }
+};
+
+const InterfaceInfo riscv32_64_machine_interfaces[] = {
+    { TYPE_TARGET_RISCV32_MACHINE },
+    { TYPE_TARGET_RISCV64_MACHINE },
+    { }
+};
-- 
2.53.0


