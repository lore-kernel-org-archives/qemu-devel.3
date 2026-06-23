Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930D6CDB47C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0YS-0004W7-73; Tue, 23 Jun 2026 08:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YO-0004VG-Cx
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YI-0006za-Dg
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782218909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJtx2znA2d/l9+h2Q+gjbVY5u+1PyMSw9GQjwFQZoeM=;
 b=JtllMbJvlFExVkguJ7HoGfUDxI1JUCXv5u1SE1+J1FaVE1ZmbIV/bKXLPdjcweaCHzcAc3
 OkTEHKjzv9fRA1BMAvuxMhtF+01oBvTXNHhv5Ix1p1QA3sRqx2vFUbFrmhdTjX5MIC7tcY
 Lb+eccsDXgG46ArC/VSXDdOa/PDKISk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-uIXF4D1_Omisy02cu5la2w-1; Tue, 23 Jun 2026 08:48:28 -0400
X-MC-Unique: uIXF4D1_Omisy02cu5la2w-1
X-Mimecast-MFC-AGG-ID: uIXF4D1_Omisy02cu5la2w_1782218908
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-517878a92c5so100456011cf.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 05:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782218908; x=1782823708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rJtx2znA2d/l9+h2Q+gjbVY5u+1PyMSw9GQjwFQZoeM=;
 b=kLS30ncyea6fgYI7zTs0AVr47UwMYnElB8Mpg/LQvd0GbGXy4A2lSHiiQHk9FJsKT9
 1sJX+DCaO5HUSrokTicqUbG1GIiTSvO9TwuyPaPyAFZtu1IIsdKgJCAxomr/99WRQMol
 2Ly4GumRqDub6hNTYI2pDbzo1OoGLkB3lTuiYcsFTtdkjFCpv7JM1+X9NfVwx1JKDs/W
 4E5PvhEsGogMMyY0H7PokFxTgdZ6eerxNhiHRIG+uBLsSaUELt+49/Ctj31AnTmdqgUp
 WeLeve2esFIU1yWbEkAC5BxAViC0ixcCHLnscGzfA/tZA+/rLXctbqqKhbMt0UdZkSYv
 vGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782218908; x=1782823708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rJtx2znA2d/l9+h2Q+gjbVY5u+1PyMSw9GQjwFQZoeM=;
 b=E+qgst0jGbM0qpODkTXqr3d4qaZbZm0EKeP9xtzGCqRY1hoahqLGLRcA2Zj0PZbG+L
 iTfzDvhy7wEoykRWUNYJX9P3D4ehFskz3M+C8f8IeOF2jjgaqPmdE6tXRGrjT64ISuOb
 JybxfX9oxKYYS5dawTOCpMviZ9M95Tb5iCq3UOoe8lXLGQTjTPSgbrCFJsN8UO3dsaD/
 F/lIcpX/zmPp3Y6WYtYzAo9EtjUf/A6EYKc3be8nAKpitBgxnB8j2Lbqq9rXywXZkzHD
 YBQ2ZIsJyQMBUljfIqqTw1koqc055rB2iBHfNT+UdFi/kqYfV+Wj5jPO3grK0YlNcEkS
 aGdQ==
X-Gm-Message-State: AOJu0Yxt1+jKocuPgKZXZsi3v/Nec1EFt5GIoAbeHPcHa/jt0F9skjWc
 k9xKZ8dig9BkmNkAnPa2tFJTBJdotX1C6lxa68XXEdqP6A9WVAdQmoEmb7Ida3mjUt03onfGh7N
 c1z7DYTXiFC+03jEZwxWecmZagogyZWfM509xVl16Q7OczsrM9RmRtoz3OIOyLCc0WVY24oJ2/G
 XWJjBcj+BS9ZrSvfbSRYeOSB+yRApKbxBLRJvMQQ==
X-Gm-Gg: AfdE7clD95/xqxt37LRRb1OMGaHdsaFdTzelwHN5D4w7/v5kfktYfKHGXiSmSJnbRPp
 DM3bKZWzPXmMgrDRFgjUOLmYGR3JVR/gOR3jTCi9KWDnZO0Wdl6wF518jvbHO+kQLYeNExBgLJB
 jW46vmmLkHJ7wY8x8GMjnf8E0OFS34+DYSN/rRm9KmjaVKtBtTGB48SkHwlnzg+mg2CPVGJPgHM
 pibxDt+PmP0pqyfVZFVSeJXX0EffOgegkLQq6IDL0KtXJJAK3fJnsnA3bO2TlGj28t2Wt4UJDsx
 pQrAAxRxUuaYzSsyM07rfkqbpk42Ec35IZJnV6R7Ov8jll70NbPHrlZWJqcDG+4sn2geSim/E2c
 1AA==
X-Received: by 2002:a05:622a:1c0f:b0:50d:7c18:c66e with SMTP id
 d75a77b69052e-519e4a4307bmr288597891cf.13.1782218907487; 
 Tue, 23 Jun 2026 05:48:27 -0700 (PDT)
X-Received: by 2002:a05:622a:1c0f:b0:50d:7c18:c66e with SMTP id
 d75a77b69052e-519e4a4307bmr288597271cf.13.1782218906854; 
 Tue, 23 Jun 2026 05:48:26 -0700 (PDT)
Received: from x1.com ([174.91.117.157]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51106a09sm22288351cf.0.2026.06.23.05.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:48:25 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 06/18] tests/qtest/migration: Add migration test on loongarch
Date: Tue, 23 Jun 2026 08:47:47 -0400
Message-ID: <20260623124759.125399-7-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623124759.125399-1-peterx@redhat.com>
References: <20260623124759.125399-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bibo Mao <maobibo@loongson.cn>

Add migration qtest on loongarch64 system, the test passes to run with
the following result:
  qemu:qtest+qtest-loongarch64/qtest-loongarch64/migration-test OK 15.94s 9 subtests passed

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260611084312.70042-1-maobibo@loongson.cn
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 MAINTAINERS                                   |  1 +
 tests/qtest/migration/bootfile.h              |  4 ++
 .../qtest/migration/loongarch64/a-b-kernel.h  | 20 ++++++++
 tests/qtest/migration/bootfile.c              |  4 ++
 tests/qtest/migration/framework.c             |  6 +++
 tests/qtest/meson.build                       |  3 +-
 tests/qtest/migration/Makefile                |  4 +-
 tests/qtest/migration/loongarch64/Makefile    | 20 ++++++++
 .../qtest/migration/loongarch64/a-b-kernel.S  | 46 +++++++++++++++++++
 9 files changed, 106 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/migration/loongarch64/a-b-kernel.h
 create mode 100644 tests/qtest/migration/loongarch64/Makefile
 create mode 100644 tests/qtest/migration/loongarch64/a-b-kernel.S

diff --git a/MAINTAINERS b/MAINTAINERS
index 93df53d87f..d609692d9a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1359,6 +1359,7 @@ F: hw/intc/loongarch_*.c
 F: hw/intc/loongson_ipi_common.c
 F: hw/rtc/ls7a_rtc.c
 F: gdbstub/gdb-xml/loongarch*.xml
+F: tests/qtest/migration/loongarch64/
 
 M68K Machines
 -------------
diff --git a/tests/qtest/migration/bootfile.h b/tests/qtest/migration/bootfile.h
index 0ce5b34433..a4060ea4f7 100644
--- a/tests/qtest/migration/bootfile.h
+++ b/tests/qtest/migration/bootfile.h
@@ -42,6 +42,10 @@
  */
 #define ARM_TEST_MAX_KERNEL_SIZE (512 * 1024)
 
+/* LoongArch64 */
+#define LOONGARCH_TEST_MEM_START (32 * 1024 * 1024)
+#define LOONGARCH_TEST_MEM_END   (100 * 1024 * 1024)
+
 #ifndef MIGRATION_GUEST_CODE
 void bootfile_delete(void);
 char *bootfile_create(const char *arch, const char *dir, bool suspend_me);
diff --git a/tests/qtest/migration/loongarch64/a-b-kernel.h b/tests/qtest/migration/loongarch64/a-b-kernel.h
new file mode 100644
index 0000000000..6d5d811f79
--- /dev/null
+++ b/tests/qtest/migration/loongarch64/a-b-kernel.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * This file is automatically generated from the assembly file in
+ * tests/qtest/migration/loongarch64. Edit that file and then run "make"
+ * inside tests/qtest/migration to update, and then remember to send both
+ * the header and the assembler differences in your patch submission.
+ */
+unsigned char loongarch64_kernel[] = {
+  0x0c, 0xc0, 0x3f, 0x14, 0x8c, 0x81, 0x87, 0x03, 0x0d, 0x04, 0x81, 0x03,
+  0x8d, 0x01, 0x00, 0x29, 0x0c, 0x00, 0x04, 0x14, 0x0d, 0x80, 0x0c, 0x14,
+  0x2e, 0x00, 0x00, 0x14, 0x10, 0xc0, 0x3f, 0x14, 0x10, 0x82, 0x87, 0x03,
+  0x11, 0x08, 0x81, 0x03, 0x80, 0x01, 0x00, 0x29, 0x8c, 0xb9, 0x10, 0x00,
+  0x8d, 0xf9, 0xff, 0x5f, 0x12, 0x00, 0xc0, 0x02, 0x0c, 0x00, 0x04, 0x14,
+  0x8f, 0x01, 0x00, 0x2a, 0xef, 0x05, 0x80, 0x02, 0xef, 0x5d, 0x00, 0x00,
+  0x8f, 0x01, 0x00, 0x29, 0x8c, 0xb9, 0x10, 0x00, 0x8d, 0xed, 0xff, 0x5f,
+  0x52, 0x06, 0xc0, 0x02, 0x52, 0x7e, 0x40, 0x03, 0x5f, 0xde, 0xff, 0x47,
+  0x11, 0x02, 0x00, 0x29, 0xff, 0xd7, 0xff, 0x53
+};
+
diff --git a/tests/qtest/migration/bootfile.c b/tests/qtest/migration/bootfile.c
index 479c43231d..e46ad09de7 100644
--- a/tests/qtest/migration/bootfile.c
+++ b/tests/qtest/migration/bootfile.c
@@ -19,6 +19,7 @@
 #include "bootfile.h"
 #include "i386/a-b-bootblock.h"
 #include "aarch64/a-b-kernel.h"
+#include "loongarch64/a-b-kernel.h"
 #include "ppc64/a-b-kernel.h"
 #include "s390x/a-b-bios.h"
 
@@ -57,6 +58,9 @@ char *bootfile_create(const char *arch, const char *dir, bool suspend_me)
         content = aarch64_kernel;
         len = sizeof(aarch64_kernel);
         g_assert(sizeof(aarch64_kernel) <= ARM_TEST_MAX_KERNEL_SIZE);
+    } else if (strcmp(arch, "loongarch64") == 0) {
+        content = loongarch64_kernel;
+        len = sizeof(loongarch64_kernel);
     } else {
         g_assert_not_reached();
     }
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index a9b58d03aa..a830b96f41 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -360,6 +360,12 @@ int migrate_args(char **from, char **to, MigrateStart *args)
         arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
         start_address = ARM_TEST_MEM_START;
         end_address = ARM_TEST_MEM_END;
+    } else if (strcmp(arch, "loongarch64") == 0) {
+        memory_size = "256M";
+        machine_alias = "virt";
+        arch_opts = g_strdup_printf("-bios %s", bootpath);
+        start_address = LOONGARCH_TEST_MEM_START;
+        end_address = LOONGARCH_TEST_MEM_END;
     } else {
         g_assert_not_reached();
     }
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 4897325d84..e154abb05d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -155,7 +155,8 @@ qtests_loongarch64 = qtests_filter + \
   (config_all_devices.has_key('CONFIG_LOONGARCH_VIRT') ? ['numa-test'] : []) + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
   ['boot-serial-test',
-   'cpu-plug-test']
+   'cpu-plug-test',
+   'migration-test']
 
 qtests_m68k = ['boot-serial-test'] + \
   qtests_filter
diff --git a/tests/qtest/migration/Makefile b/tests/qtest/migration/Makefile
index c183b69941..626e3974f7 100644
--- a/tests/qtest/migration/Makefile
+++ b/tests/qtest/migration/Makefile
@@ -5,7 +5,7 @@
 # See the COPYING file in the top-level directory.
 #
 
-TARGET_LIST = i386 aarch64 s390x ppc64
+TARGET_LIST = i386 aarch64 s390x ppc64 loongarch64
 
 SRC_PATH = ../../../..
 
@@ -23,6 +23,8 @@ help:
 	@echo " Possible targets are: $(TARGET_LIST)"
 
 override define __note
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
 /*
  * This file is automatically generated from the assembly file in
  * tests/qtest/migration/$@. Edit that file and then run "make"
diff --git a/tests/qtest/migration/loongarch64/Makefile b/tests/qtest/migration/loongarch64/Makefile
new file mode 100644
index 0000000000..3c8cfeee86
--- /dev/null
+++ b/tests/qtest/migration/loongarch64/Makefile
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# To specify cross compiler prefix, use CROSS_PREFIX=
+#   $ make CROSS_PREFIX=loongarch64-linux-gnu-
+
+.PHONY: all clean
+all: a-b-kernel.h
+
+a-b-kernel.h: loongarch64.kernel
+	echo "$$__note" > $@
+	xxd -i $< | sed -e 's/.*int.*//' >> $@
+
+loongarch64.kernel: loongarch64.elf
+	$(CROSS_PREFIX)objcopy -j .text -O binary $< $@
+
+loongarch64.elf: a-b-kernel.S
+	$(CROSS_PREFIX)gcc -o $@ -nostdlib -Wl,--build-id=none $<
+
+clean:
+	$(RM) *.kernel *.elf
diff --git a/tests/qtest/migration/loongarch64/a-b-kernel.S b/tests/qtest/migration/loongarch64/a-b-kernel.S
new file mode 100644
index 0000000000..577d4b238c
--- /dev/null
+++ b/tests/qtest/migration/loongarch64/a-b-kernel.S
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "../bootfile.h"
+
+#define LOONGARCH_CSR_CRMD          0
+#define LOONGARCH_VIRT_UART         0x1FE001E0
+.section .text
+
+    .globl  _start
+_start:
+    /* output char 'A' to UART16550 */
+    li.d    $t0, LOONGARCH_VIRT_UART
+    li.w    $t1, 'A'
+    st.b    $t1, $t0, 0
+
+    /* traverse test memory region */
+    li.d    $t0, LOONGARCH_TEST_MEM_START
+    li.d    $t1, LOONGARCH_TEST_MEM_END
+    li.d    $t2, TEST_MEM_PAGE_SIZE
+    li.d    $t4, LOONGARCH_VIRT_UART
+    li.w    $t5, 'B'
+
+clean:
+    st.b    $zero, $t0, 0
+    add.d   $t0,   $t0, $t2
+    bne     $t0,   $t1, clean
+    /* keeps a counter so we can limit the output speed */
+    addi.d  $t6,   $zero, 0
+
+mainloop:
+    li.d    $t0, LOONGARCH_TEST_MEM_START
+
+innerloop:
+    ld.bu   $t3, $t0, 0
+    addi.w  $t3, $t3, 1
+    ext.w.b $t3, $t3
+    st.b    $t3, $t0, 0
+    add.d   $t0, $t0, $t2
+    bne     $t0, $t1, innerloop
+
+    addi.d  $t6, $t6, 1
+    andi    $t6, $t6, 31
+    bnez    $t6, mainloop
+
+    st.b    $t5, $t4, 0
+    b       mainloop
-- 
2.54.0


