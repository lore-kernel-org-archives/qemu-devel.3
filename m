Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1524D11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObsj-0004Ep-Jm; Thu, 27 Nov 2025 08:17:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObr4-0002ju-KY
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqv-0001IK-7h
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wpnrAdD3xbORyd8otri4oXizO/2tYcx3tnVtrMiGUzw=;
 b=Mr+Z37+V8bMLXRyEczvskYDqwEnrdqakmINHzJE96SJ1AAuS7uWdngKU/oCZcNzr9AhuVU
 PXBzsrGlFo6NTLWfhO7K8qDndoOjIyx0bngB6BLv7q3RyF4kwYmvXCN5uKTUnRNlXzVB8K
 +7gkFEb8vdYHDAg98f2hthBx6lBQPtI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-W96hsvx7MR2T009z7sh86g-1; Thu, 27 Nov 2025 08:15:59 -0500
X-MC-Unique: W96hsvx7MR2T009z7sh86g-1
X-Mimecast-MFC-AGG-ID: W96hsvx7MR2T009z7sh86g_1764249359
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6411e349b73so976421a12.2
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249357; x=1764854157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wpnrAdD3xbORyd8otri4oXizO/2tYcx3tnVtrMiGUzw=;
 b=RwHfkrr1MEfStor6b/9vZjLlIPGb3hjTFy/YWiSEyUobW2uxUeBELj7HQJUUrMIQwl
 6acyPpQHkOWwn8W3KH8VK+BmftWtFAXHwEgX9D9IE9tz8k1PYa8l+TSE8VmSH1qfyBwL
 zOCGcuapaASKGkF/u4MBiIhb5+fvcEEgtoMQPGGoBEhxzymD9f6KMEztbb7L19TNanho
 GdTRWBrCabP0pFpVFpxbZah9r23btEAci94mCLzFp3SH6cQ0+pgA5wyH7920OuMH1voP
 4skds282GPgBfC/FB4X7SNJiqXEOQduA9YcSLrwooBMMw6EhMOatRGzvFc9VGo8H+jqR
 TbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249357; x=1764854157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wpnrAdD3xbORyd8otri4oXizO/2tYcx3tnVtrMiGUzw=;
 b=AjyC7UOGk4LtHgrMMJZowmHDqaTODdcwzPeQFbn65HcWGbdn+VDHE076FXK9aDh43m
 vvX2XNUYfbMj8Br7d970UTi0D+wag5AzRZuTq9Y/cs9vKFu8LuX+YOm2p66cmJpwNyCb
 H2CyRr/Qt9PHJaqvWSXrlsaJdKGMOwmONHkv20j18PJs//f7kb7b15StLwGzwSNzaYJq
 I4eqEBK4odW4vjUu6SJKSWKh2EJ7iresbQhQH+At4wa9jDIq7i2BYvVagw1xbwRlWMbI
 x4VJ1dsfa3KE094X6s/j4FpoV6LgQ9KD5g6mw7pXErvlKLDY3vDoa6JxZ77BHdAsY3vQ
 6i0A==
X-Gm-Message-State: AOJu0Yzno+pxZorPiirYm0nxNVnu6QtBEJ+iuXZ4dXfpf4McFfGWUUl2
 +U5xUO1IgpXQHeHoOvsGpZOtfirj9VVihF2a0VbzlExvEOgMu1g0nlllePgdn52yGunhoHT+4kW
 Pz4Rpdy9HuPw8Fb3h3Je8j2+hss/YpL1GvXpuqS8Zj4ZvyXrJ+d25ZSTn2CsrQnzENTr4P/An7n
 jbUgMR0wrTj2KTJqakWRZUVQEJiu0JCLqOvFQSp9ml
X-Gm-Gg: ASbGncuKTaIOe4S7UI+/+NaF9Vlogm0XX3E0ogl+r9DFaRbQ/ckG2jvRKlP6B/wT3mC
 7UrVeLIwvOkvYqQVJbvQu+5bXTX5d81Ae432yHU2DocZW8rt7uCoo3unkPSCzrlvjnNIPBPmpA3
 vM1ATXhgvxtfn1J1egdal2FmQtDcu9ka/UPvT9G9wwqkTSFbc7KZKid2+K+zwGYgIkHKcoq/6M7
 SxROlnSZP8y5QMm/f35j185X1A5mofIcCZcTK4tQRfYzZ9wqa3WJDBOg5ohnefdswtSqxJxemLf
 aSSjLUXFLSFREP6B3nZ/DxtOQ5GWjzV6k82/oxKrI7dJp0YUa6yrTWTaOPibK4Ar0zOP3/nfncD
 L7VEgm90TrNjt4jMOeoFvCK4wMFD3vuuDYOxT9qsSssK1PDIUxfWlWvD+PeNUXI2Kl4H8V0RtCR
 Rc9fONXGc2BfB7GeQ=
X-Received: by 2002:a05:6402:51d0:b0:643:804a:fb5e with SMTP id
 4fb4d7f45d1cf-64555cd9f23mr18359581a12.21.1764249357460; 
 Thu, 27 Nov 2025 05:15:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtvP/aKYmrnE6TE/oxiPG4Vb8tq/H1pvd+sXdTz6EFwiIesJxKWOeZbT0wF3iJDkVZQ4e31A==
X-Received: by 2002:a05:6402:51d0:b0:643:804a:fb5e with SMTP id
 4fb4d7f45d1cf-64555cd9f23mr18359550a12.21.1764249356918; 
 Thu, 27 Nov 2025 05:15:56 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64751051313sm1529185a12.28.2025.11.27.05.15.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/28] include: move hw/resettable.h to hw/core/
Date: Thu, 27 Nov 2025 14:15:10 +0100
Message-ID: <20251127131516.80807-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127131516.80807-1-pbonzini@redhat.com>
References: <20251127131516.80807-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                        | 2 +-
 docs/devel/reset.rst               | 2 +-
 include/hw/core/boards.h           | 2 +-
 include/hw/core/qdev.h             | 2 +-
 include/hw/{ => core}/resettable.h | 0
 include/hw/virtio/virtio-balloon.h | 2 +-
 include/hw/virtio/virtio-mem.h     | 2 +-
 include/system/reset.h             | 2 +-
 hw/core/reset.c                    | 2 +-
 hw/core/resetcontainer.c           | 2 +-
 hw/core/resettable.c               | 2 +-
 hw/misc/xlnx-versal-crl.c          | 2 +-
 hw/net/lan9118_phy.c               | 2 +-
 hw/pci-host/fsl_imx8m_phy.c        | 2 +-
 hw/rtc/rs5c372.c                   | 2 +-
 system/runstate.c                  | 2 +-
 target/s390x/cpu.c                 | 2 +-
 17 files changed, 16 insertions(+), 16 deletions(-)
 rename include/hw/{ => core}/resettable.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index b9cc00a5582..e34c3e6dac2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3961,7 +3961,7 @@ F: docs/devel/clocks.rst
 Reset framework
 M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
-F: include/hw/resettable.h
+F: include/hw/core/resettable.h
 F: include/hw/core/resetcontainer.h
 F: include/system/reset.h
 F: hw/core/reset.c
diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
index c02fe0a405c..91e8c21189e 100644
--- a/docs/devel/reset.rst
+++ b/docs/devel/reset.rst
@@ -4,7 +4,7 @@ Reset in QEMU: the Resettable interface
 =======================================
 
 The reset of qemu objects is handled using the resettable interface declared
-in ``include/hw/resettable.h``.
+in ``include/hw/core/resettable.h``.
 
 This interface allows objects to be grouped (on a tree basis); so that the
 whole group can be reset consistently. Each individual member object does not
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index a48ed4f86a3..815845207b0 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -10,7 +10,7 @@
 #include "qemu/module.h"
 #include "qom/object.h"
 #include "hw/core/cpu.h"
-#include "hw/resettable.h"
+#include "hw/core/resettable.h"
 
 #define TYPE_MACHINE_SUFFIX "-machine"
 
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index da93611d373..0b62580a0fb 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -9,7 +9,7 @@
 #include "qom/object.h"
 #include "hw/core/hotplug.h"
 #include "hw/core/irq.h"
-#include "hw/resettable.h"
+#include "hw/core/resettable.h"
 
 /**
  * DOC: The QEMU Device API
diff --git a/include/hw/resettable.h b/include/hw/core/resettable.h
similarity index 100%
rename from include/hw/resettable.h
rename to include/hw/core/resettable.h
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 0456c211c6e..79ac194ccec 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -16,7 +16,7 @@
 #define QEMU_VIRTIO_BALLOON_H
 
 #include "standard-headers/linux/virtio_balloon.h"
-#include "hw/resettable.h"
+#include "hw/core/resettable.h"
 #include "hw/virtio/virtio.h"
 #include "system/iothread.h"
 #include "qom/object.h"
diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
index e0ab31b45a4..221cfd76bf9 100644
--- a/include/hw/virtio/virtio-mem.h
+++ b/include/hw/virtio/virtio-mem.h
@@ -14,7 +14,7 @@
 #define HW_VIRTIO_MEM_H
 
 #include "standard-headers/linux/virtio_mem.h"
-#include "hw/resettable.h"
+#include "hw/core/resettable.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/qapi-types-misc.h"
 #include "system/hostmem.h"
diff --git a/include/system/reset.h b/include/system/reset.h
index 97131d94cfc..62e9977e3c2 100644
--- a/include/system/reset.h
+++ b/include/system/reset.h
@@ -27,7 +27,7 @@
 #ifndef QEMU_SYSTEM_RESET_H
 #define QEMU_SYSTEM_RESET_H
 
-#include "hw/resettable.h"
+#include "hw/core/resettable.h"
 #include "qapi/qapi-events-run-state.h"
 
 typedef void QEMUResetHandler(void *opaque);
diff --git a/hw/core/reset.c b/hw/core/reset.c
index 65f82fa43d9..e7230b49b70 100644
--- a/hw/core/reset.c
+++ b/hw/core/reset.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "system/reset.h"
-#include "hw/resettable.h"
+#include "hw/core/resettable.h"
 #include "hw/core/resetcontainer.h"
 
 /*
diff --git a/hw/core/resetcontainer.c b/hw/core/resetcontainer.c
index 5ff17002e75..ef84aa2374a 100644
--- a/hw/core/resetcontainer.c
+++ b/hw/core/resetcontainer.c
@@ -15,7 +15,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/resettable.h"
+#include "hw/core/resettable.h"
 #include "hw/core/resetcontainer.h"
 
 struct ResettableContainer {
diff --git a/hw/core/resettable.c b/hw/core/resettable.c
index 5cdb4a4f8d3..86e16c8c6e4 100644
--- a/hw/core/resettable.c
+++ b/hw/core/resettable.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
-#include "hw/resettable.h"
+#include "hw/core/resettable.h"
 #include "trace.h"
 
 /**
diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index 072d6d98591..9bbf44def6b 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -13,7 +13,7 @@
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/register.h"
-#include "hw/resettable.h"
+#include "hw/core/resettable.h"
 
 #include "target/arm/arm-powerctl.h"
 #include "target/arm/multiprocessing.h"
diff --git a/hw/net/lan9118_phy.c b/hw/net/lan9118_phy.c
index f0f6e55d807..2fc027d112c 100644
--- a/hw/net/lan9118_phy.c
+++ b/hw/net/lan9118_phy.c
@@ -16,7 +16,7 @@
 #include "hw/net/lan9118_phy.h"
 #include "hw/net/mii.h"
 #include "hw/core/irq.h"
-#include "hw/resettable.h"
+#include "hw/core/resettable.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "trace.h"
diff --git a/hw/pci-host/fsl_imx8m_phy.c b/hw/pci-host/fsl_imx8m_phy.c
index 04da3f99a07..0afa6167e0d 100644
--- a/hw/pci-host/fsl_imx8m_phy.c
+++ b/hw/pci-host/fsl_imx8m_phy.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci-host/fsl_imx8m_phy.h"
-#include "hw/resettable.h"
+#include "hw/core/resettable.h"
 #include "migration/vmstate.h"
 
 #define CMN_REG075 0x1d4
diff --git a/hw/rtc/rs5c372.c b/hw/rtc/rs5c372.c
index 58f12b836d3..20015dd6c1e 100644
--- a/hw/rtc/rs5c372.c
+++ b/hw/rtc/rs5c372.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/resettable.h"
+#include "hw/core/resettable.h"
 #include "migration/vmstate.h"
 #include "qemu/bcd.h"
 #include "qom/object.h"
diff --git a/system/runstate.c b/system/runstate.c
index 89bbfe7fbf9..ed2db564806 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -32,7 +32,7 @@
 #include "exec/cpu-common.h"
 #include "gdbstub/syscalls.h"
 #include "hw/core/boards.h"
-#include "hw/resettable.h"
+#include "hw/core/resettable.h"
 #include "migration/misc.h"
 #include "migration/postcopy-ram.h"
 #include "monitor/monitor.h"
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index da536fb30ed..6c4198eb1b1 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -32,7 +32,7 @@
 #include "system/hw_accel.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
-#include "hw/resettable.h"
+#include "hw/core/resettable.h"
 #include "fpu/softfloat-helpers.h"
 #include "disas/capstone.h"
 #include "system/tcg.h"
-- 
2.51.1


