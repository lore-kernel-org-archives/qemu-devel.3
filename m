Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF315E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQH-0002YZ-Je; Sat, 27 Dec 2025 04:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQF-0002XV-Lr
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQC-0002Ps-7j
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bivrVV7bo5oZF3dxfEhb6DoI+Vn3TCKqB0VgafCU4Bs=;
 b=Qg+0UHncyMumpPoHkkHx3bIZpuh827z7K+MfBzXfxW8JJuQT+xlImtRb4zq29hLlMa5AlK
 zzWIEEDviIJLkHB4S1hUakYrdVGc2Zde2FHqINRdpwQz1jGpnsNrLN9l1qH5zlILOtLlNk
 xCLOwOWLI3qGHmlmN6Dc0ywdG2YS6wo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-yVZdGz5FNmevDNDV-94M0g-1; Sat, 27 Dec 2025 04:17:09 -0500
X-MC-Unique: yVZdGz5FNmevDNDV-94M0g-1
X-Mimecast-MFC-AGG-ID: yVZdGz5FNmevDNDV-94M0g_1766827028
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-431026b6252so7782809f8f.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827027; x=1767431827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bivrVV7bo5oZF3dxfEhb6DoI+Vn3TCKqB0VgafCU4Bs=;
 b=mHhWVcgZ0wZLAONcl3oOkREFf+XV2T8ODq7k78+OcJmnFgDYVtxyBFB9GkfpRrO5Xc
 aFzVjbcwELRSr9jhFnOxX6Vks3V2vXKZlsfOj7uVMSLjw/8lF77Afb6zct1dUwjvksAA
 u9Z4QjuU7V+41wqSl1anItIZrnVjNyXms01Vjn853AA/0ZehQRkhKOwYmFlwTnAGA4kL
 luhG/mEIqAR49xNF3rZ37h3BQMCxCJxRyIh0HitoH98Yscj0XUNTe4Kbd9hWlooQI5pc
 JGLE5hb++ghqzHjNwYWFTkQpjNWL8j+wqh4yz08Rm/2LzigTrDSO1pbuti6OHb5AiMUn
 X1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827027; x=1767431827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bivrVV7bo5oZF3dxfEhb6DoI+Vn3TCKqB0VgafCU4Bs=;
 b=K0beE0wv9JJr6AorjBTKGwB24RBNgbjAgQrE+33ubLHTFCjRF4x24XI4cycIDgBVR+
 q/vea25/YjEfPRgovHideWy13bywejO7HzI+0vwVvDLvoCdOBH9ZX85oP4zCnO4j+h5X
 v0pTobin90AnmCjuBw5BCI01uh936d6cqHcbf/TruqceEr77tIDB6mNrs1ohacLNd5oG
 cIrkzMeIKA9e8Duk3JVUI3aDOnn90BM/98458whgaj0/K/ECZw7RIfDTVr0vAkxGB0pw
 E1lwAAFXEregev7rB3aOXrgvePhJlzjdCnAMVa6Bb0mBLsdwiIsRa3oNnYLhxoUoEuF3
 0nsQ==
X-Gm-Message-State: AOJu0Yz5FdlytP4x59mxrVKtElIIKrsVQXq4WYOtisW0LLHxf+bxeTxS
 /vTcBQ4psPNQ546xcIW58ZIStOnqR8ZehNZVDvRHV80ugiUNxnqoXMV4YGtvGZIoTR50py5eiJd
 gq1Fgms6cgQfxrKu3YYpto0JLnr6ZwKCEkLIzyIRoZikuaL3GKOpHI5Bq5hx2RNOyXYcZHfebY4
 epHn2iBygDp8fn6jznyh0S9j9kitOWWXKzNerzb1/E
X-Gm-Gg: AY/fxX5dgnnIRynJ5BKs1DDabvK/BLF3HFK/G/HP5l/L+PdAKrNe/tc17Bydskg5Aoq
 E49xrHcm7A5H2O9eGfbbdZRZN4uh3XGK5N/ZOWNE2K4cTvQpLxa1umYj3MRK2N5jNUUF6YPxGjn
 zmaIaZlMU9EJ3g9uYtPCtNLHhPnuOZaEigM+DLAglLsoIu64jv/1AgOkgc/fD27cGDlRsDVGug3
 XmMnhM8ZTNnLPcX4tb+9Zf3HEboGEEmbk13kKT4IC9OIKBv49/RMbeBPOJYN3Fcbc39Hx0ML6RE
 XWy3OcFIy5JvmCxix9613lg6v60SxyT+AZas979aEt6KvdP7JhXDRpyYeIu98a4ov7TygJTEnTv
 1xlzgKXzspbrNk9gE3JnCAXjyyNlFso9MqiCUcXMbw6vSMotjkVEN9euGFl6W5Ygk9QNWqbji0z
 LITwLGLRoS0jeXXa4=
X-Received: by 2002:a05:6000:1a8e:b0:430:f68f:ee7d with SMTP id
 ffacd0b85a97d-4324e50d9demr31585681f8f.47.1766827027569; 
 Sat, 27 Dec 2025 01:17:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6CCcTXCqFuWmLd+GdnOHv8EEzir1jdeFJkhQXbgxOsTaNN7TajTmHTbMVka7wAY8QL2Pdvg==
X-Received: by 2002:a05:6000:1a8e:b0:430:f68f:ee7d with SMTP id
 ffacd0b85a97d-4324e50d9demr31585651f8f.47.1766827027005; 
 Sat, 27 Dec 2025 01:17:07 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea8311fsm50394695f8f.28.2025.12.27.01.17.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 024/153] include: move hw/resettable.h to hw/core/
Date: Sat, 27 Dec 2025 10:14:11 +0100
Message-ID: <20251227091622.20725-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index b38215954a2..e241690bdce 100644
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
index f0ef2dc3aa8..e211d807e82 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -8,7 +8,7 @@
 #include "qemu/rcu_queue.h"
 #include "qom/object.h"
 #include "hw/core/hotplug.h"
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
2.52.0


