Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40996C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSIU-0003VP-Lk; Mon, 14 Jul 2025 19:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHN-0006GX-BC
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHL-0005eo-D3
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8cdFXXzqDzXY75EaUcrZ9O1kHGmzGq5u5QSMVPaWec=;
 b=Mag7cJDMAEbUvEF+CFvXdkMjlUXIWd0sStuQRRjYq0Cu9QpUphWa6iSFpq/Lx02bo32nIy
 290pJZi+NvBcxewvBjGKthcxOXMWawmCHbCse0NbEG4uiyCziWWVW4roxBGKP1NRf8v9jM
 0p0HRvExdAyy5kGImguqv71JFT7COp4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-F9nkDLxbMyCQGPDZAlEcFg-1; Mon, 14 Jul 2025 19:08:08 -0400
X-MC-Unique: F9nkDLxbMyCQGPDZAlEcFg-1
X-Mimecast-MFC-AGG-ID: F9nkDLxbMyCQGPDZAlEcFg_1752534487
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451ecc3be97so25168635e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534486; x=1753139286;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L8cdFXXzqDzXY75EaUcrZ9O1kHGmzGq5u5QSMVPaWec=;
 b=opFdr/pJHZh7lbkZ/qCMZBmT35SQkAayYPeHiiOC8cjRYxscGtHU0frdy7wWbplmLs
 C9mxZmRlMVo7UwAsw7Znvd0XobI2ZT6RiE4Xnff+oB7jGa4mzHdlHp8RSCeXoEpEqW2H
 ZajhDIo82eGDlMuepwFho6GknUUhw8UGb0KQs6JRo+ohQ5iV4/84wkOv9WbAZTVDz+u6
 Dy7aFNsE37ZzF5XBPYnQ0c1kZdtn1YpVbHICivXZMkl0/69ClXG5BuCKKCpSQmMAQ5ON
 mSwHNZkpuBaOc5D9vSIgKP9f8lFFtna9zzsrj6vt6ep1hJkfk1/ELGItztaUQSL9CjXz
 aoGg==
X-Gm-Message-State: AOJu0YzP57HkM1RDq4Yjg8OR8Kqoe6V/7EOjleYuDHmNMmQVjTCAiCuW
 QiDXyPloiET7OR1DMkT4HFgLqUw6XpCsqtwwOs36BZcyk1cAkFjdChZEUYQ8UYTvl5A9HSKbE0N
 kIxDoQMbH7o4u3MDs8sflJ0fcSd+/d7b60hcoPgbI3ady12cprD0UgCONd0P5uPiqvT2208vky8
 8lybJt1FrVPuFnZhuXH1eM3ef73a5WrCAR6Q==
X-Gm-Gg: ASbGncvieMqe7U6Anc0gazYghPXqPvvfd2K7dDRSCRIrRPimdJzNf9DslkqFqQXPJIr
 7+XvPm1FGdagMq7W59LhtLHN2C6YjtQtSmA4P+5fT5gYYP5fNAgXTvjxidjo+pNgBgmcluwRWtx
 Yo9Ij1M7dRUBUvahirvhsXrYw2LkZukExs68Y0r7aZjn1i8RaoXQw13J78fN4ScymwTBODOsTTA
 EeAuZEvlrhHd726SwOt/F5rL4dtZquoBOmVrXQ0+iEmWFZLpUYdRAqPux6Cpbn6s+pSJmP25HQD
 f9SopsSS6SgQKF17R/ndZqV8YYFn0KPw
X-Received: by 2002:a05:600c:5253:b0:456:2832:f98d with SMTP id
 5b1f17b1804b1-4562832fb91mr297795e9.27.1752534486239; 
 Mon, 14 Jul 2025 16:08:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3OpparMvz2Pa5t/Qp00j7WItFeMgA8/YeoeIXl+CQ0++ZSAtVKcrdnXcRGuDAXUYRpri18A==
X-Received: by 2002:a05:600c:5253:b0:456:2832:f98d with SMTP id
 5b1f17b1804b1-4562832fb91mr297495e9.27.1752534485742; 
 Mon, 14 Jul 2025 16:08:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-455f13ec67asm105439435e9.4.2025.07.14.16.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:08:05 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:08:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 43/97] qemu: Convert target_words_bigendian() to TargetInfo API
Message-ID: <bc6be29253932daa506d2211f45d28f096936bc4.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250708215320.70426-6-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/exec/tswap.h       | 13 +------------
 include/qemu/target-info.h | 12 ++++++++++++
 cpu-target.c               |  7 -------
 hw/core/cpu-system.c       |  2 +-
 hw/display/vga.c           |  2 +-
 hw/virtio/virtio.c         |  2 +-
 system/memory.c            |  1 +
 system/qtest.c             |  1 +
 target-info.c              |  5 +++++
 9 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index 49511f2611..55ffa63359 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -9,18 +9,7 @@
 #define TSWAP_H
 
 #include "qemu/bswap.h"
-
-/**
- * target_big_endian:
- * Returns true if the (default) endianness of the target is big endian,
- * false otherwise. Common code should normally never need to know about the
- * endianness of the target, so please do *not* use this function unless you
- * know very well what you are doing!
- */
-bool target_big_endian(void);
-#ifdef COMPILING_PER_TARGET
-#define target_big_endian()   TARGET_BIG_ENDIAN
-#endif
+#include "qemu/target-info.h"
 
 /*
  * If we're in target-specific code, we can hard-code the swapping
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index dde0e7d968..abcf25db6f 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -38,4 +38,16 @@ const char *target_machine_typename(void);
  */
 const char *target_cpu_type(void);
 
+/**
+ * target_big_endian:
+ *
+ * Returns: %true if the (default) endianness of the target is big endian,
+ *          %false otherwise.
+ *
+ * Common code should normally never need to know about the endianness of
+ * the target, so please do *not* use this function unless you  know very
+ * well what you are doing!
+ */
+bool target_big_endian(void);
+
 #endif
diff --git a/cpu-target.c b/cpu-target.c
index 1c90a30759..20db5ff310 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -22,7 +22,6 @@
 #include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "exec/cpu-common.h"
-#include "exec/tswap.h"
 #include "exec/replay-core.h"
 #include "exec/log.h"
 #include "hw/core/cpu.h"
@@ -85,9 +84,3 @@ void cpu_abort(CPUState *cpu, const char *fmt, ...)
 #endif
     abort();
 }
-
-#undef target_big_endian
-bool target_big_endian(void)
-{
-    return TARGET_BIG_ENDIAN;
-}
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 3c84176a0c..a975405d3a 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -24,7 +24,7 @@
 #include "exec/cputlb.h"
 #include "system/memory.h"
 #include "exec/tb-flush.h"
-#include "exec/tswap.h"
+#include "qemu/target-info.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "hw/core/sysemu-cpu-ops.h"
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 20475ebbd3..90b89cf404 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -26,7 +26,7 @@
 #include "qemu/units.h"
 #include "system/reset.h"
 #include "qapi/error.h"
-#include "exec/tswap.h"
+#include "qemu/target-info.h"
 #include "hw/display/vga.h"
 #include "hw/i386/x86.h"
 #include "hw/pci/pci.h"
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 82a285a31d..0f4d28033d 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -20,7 +20,7 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
-#include "exec/tswap.h"
+#include "qemu/target-info.h"
 #include "qom/object_interfaces.h"
 #include "hw/core/cpu.h"
 #include "hw/virtio/virtio.h"
diff --git a/system/memory.c b/system/memory.c
index e8d9b15b28..38da62f505 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -22,6 +22,7 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/qemu-print.h"
+#include "qemu/target-info.h"
 #include "qom/object.h"
 #include "trace.h"
 #include "system/ram_addr.h"
diff --git a/system/qtest.c b/system/qtest.c
index 301b03be2d..fa42c9f921 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/cutils.h"
+#include "qemu/target-info.h"
 #include "qom/object_interfaces.h"
 
 #define MAX_IRQ 256
diff --git a/target-info.c b/target-info.c
index a756c0714c..3110ab32f7 100644
--- a/target-info.c
+++ b/target-info.c
@@ -47,3 +47,8 @@ EndianMode target_endian_mode(void)
 {
     return target_info()->endianness;
 }
+
+bool target_big_endian(void)
+{
+    return target_endian_mode() == ENDIAN_MODE_BIG;
+}
-- 
MST


