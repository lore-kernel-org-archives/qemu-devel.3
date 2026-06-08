Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9A3CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWWRE-0005nK-2e; Mon, 08 Jun 2026 05:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWWR3-0005dZ-Bi
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWWQz-0005UJ-3t
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780911496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lERmOCsXaBThSpmPhBAc5PHRI8A4GCkVr7Qr8Mu3kfI=;
 b=FMLoKgMQhOetEZ+kjvJjJfPeMvXwGmFLNR3AUT9JA9pvj2eDVmT6QwqR9Fg1ZPnqENsibZ
 bJpOZEdj8cWdAHBmafyWwxULxyN+cz5IhLybucKWYBkjC43k/9RZhJiLDlKqrEkRMFZ/1v
 xTFQNs2eNCVPYz75UMRsBlJ/F0O4lbA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-KhfdSu42MKqzQj8nSojGCQ-1; Mon, 08 Jun 2026 05:38:14 -0400
X-MC-Unique: KhfdSu42MKqzQj8nSojGCQ-1
X-Mimecast-MFC-AGG-ID: KhfdSu42MKqzQj8nSojGCQ_1780911494
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45eecec7667so2989109f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 02:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780911494; x=1781516294; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lERmOCsXaBThSpmPhBAc5PHRI8A4GCkVr7Qr8Mu3kfI=;
 b=GH0uHflIXK4MrX6aJU6SH4v7rG8BpyIO/7NXTn3W1/UeVQYGF8zcunY3LlxomkpHF6
 afuLduhM4nmn2VWbR5DiKiVJWxCCYB8mMD4H6rKeBpnRZh2YoGGJl0YctjKO68peH1ha
 nIQbkKqD698fmAGOs/w6FD97RwpW2J4WpLbP0kcqPQLuwDGVEKCn2ybIdDWs3WNw7peH
 AZovkdromu4s+TttKOx65NKksCiSsZpDStzvtUhL8wN9aOj+DVVq7+mrwVXzr2kF7q7o
 Ydz0Npx/VAK26JJ8aD487bKOYCCDTP0mk2do9nlWInAIiwzPUwYb0n6F7aQ8Tspo3owP
 UDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780911494; x=1781516294;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lERmOCsXaBThSpmPhBAc5PHRI8A4GCkVr7Qr8Mu3kfI=;
 b=G3nRkv4IZyQYWoYeZZfxZjAn1KWOZj5eoNlzWSMaawKaBtM2CzEs8reHMTik2jdxas
 8mcy9S0g6ddw8JPnHL6vo9qOzMHPeNFyfRwPoXtsNjSSuP+ObuT2fIOajIC0cyz+PF0O
 f/czFfnBjZvw1Nwjdb0fQYsbbctRrfL2uBGWA/Jh05XZp/ZZATvk9OBEmF7vjoLVbqO3
 fD6hQhSSYSvjMFqxdghJV1m5QFoZ6mmkEPPgnuHbxNPigZPvPo63oCZeJI5Xu7Lv9nl/
 EzhsaAqPWZKblyoMFJZE1D0hT0o6uKbea827+N9+wroW+vKBkCq5bNPO+u4idFvPCAGm
 UB8Q==
X-Gm-Message-State: AOJu0YzNFqR44+YqARpkXNsumAyc45Sj3l8AivC6Di1r24M2RmZjM/PZ
 gyavv+eCnZuA8A2CPXqoYqpSoIqIwgSQeiHCZT0Jc0DMWgMB0fLbelmMiVj6xlMNm94F+R0l1P9
 iPfm080W9nuS9in9qYv930SwhMOZTtOzZiIG0f2LxL3hFYG/jLbagHScF
X-Gm-Gg: Acq92OGego51e2jyjwAKIGPDGzBfYKxDXaaP0p4pTarrNrutYSTOIhx/3cI/pMLLLh4
 1OQi7eGEUVI4+S42AeWEI/pUOqf0v6VuIPlwW5QH1VsDtmQlT/t87a9UCUR0dONULusQFA2of6l
 O1UuldnhIAvu4ODcRrYSCWotRViIpmc31jLmoEQegHi2h/F0WMdM7JBPatDd57YF+3U00UUliQl
 vcK7mHIcu4+Tf4d2JbTN9RK41/oSkn+2JTQsj0mj2rtEP2zTzREVcJuZAXIf0mUoePu7VDbsjpW
 LXKtD1JreK2MSBhxtdJojR7XqbjX9BvBXR1BCVbwHUSS1tptEyuAnxCWTDLrfQZATfhEr1Z8gcD
 8omUJsSDWhHUZCl6o+ntKrYRVuaFhRQCUIqp9PTaK8sXTiewoM+ti1fsm1IhvQxZEwKKsB6r6jW
 sbWltWDrgPKlZOw2wjhhG/Oi2VmyA=
X-Received: by 2002:a05:6000:178e:b0:460:3234:293e with SMTP id
 ffacd0b85a97d-46032342a79mr22510145f8f.41.1780911493622; 
 Mon, 08 Jun 2026 02:38:13 -0700 (PDT)
X-Received: by 2002:a05:6000:178e:b0:460:3234:293e with SMTP id
 ffacd0b85a97d-46032342a79mr22510096f8f.41.1780911493230; 
 Mon, 08 Jun 2026 02:38:13 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f34413csm50144923f8f.21.2026.06.08.02.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 02:38:12 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 08 Jun 2026 11:37:47 +0200
Subject: [PATCH 2/2] igvm: Fill device tree IGVM parameter field on x86_64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-microvm_device_tree-v1-2-730874ad0008@redhat.com>
References: <20260608-microvm_device_tree-v1-0-730874ad0008@redhat.com>
In-Reply-To: <20260608-microvm_device_tree-v1-0-730874ad0008@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Oliver Steffen <osteffen@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
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

Coconut SVSM, with the upcoming device tree support[1], will use
the IGVM device tree parameter to discover virtio-mmio and ISA serial
devices instead of relying on the fw_cfg interface, which is
QEMU-specific.

The IGVM parameter handler is implemented for the i386 machine
target and stubbed for all others.

[1] https://github.com/coconut-svsm/svsm/pull/1006

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c       |  2 ++
 include/system/igvm.h |  2 ++
 stubs/igvm.c          |  6 ++++++
 target/i386/igvm.c    | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/backends/igvm.c b/backends/igvm.c
index c347d0c17e..9c6bee4add 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -130,6 +130,8 @@ static struct QIGVMHandler handlers[] = {
       qigvm_initialization_guest_policy },
     { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
       qigvm_directive_madt },
+    { IGVM_VHT_DEVICE_TREE, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_device_tree },
 };
 
 static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
diff --git a/include/system/igvm.h b/include/system/igvm.h
index 64d3542311..d39f3d55f1 100644
--- a/include/system/igvm.h
+++ b/include/system/igvm.h
@@ -32,5 +32,7 @@ int qigvm_x86_set_vp_context(void *data, int index,
  *  IGVM parameter handlers
  */
 int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp);
+int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
+                                Error **errp);
 
 #endif
diff --git a/stubs/igvm.c b/stubs/igvm.c
index 9e9f683fc9..b4d533ad24 100644
--- a/stubs/igvm.c
+++ b/stubs/igvm.c
@@ -29,3 +29,9 @@ int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
 {
     return -1;
 }
+
+int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
+                                Error **errp)
+{
+    return -1;
+}
diff --git a/target/i386/igvm.c b/target/i386/igvm.c
index f41b498b89..13db6e9be0 100644
--- a/target/i386/igvm.c
+++ b/target/i386/igvm.c
@@ -11,6 +11,8 @@
 
 #include "qemu/osdep.h"
 
+#include <libfdt.h>
+
 #include "cpu.h"
 #include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/acpi-build.h"
@@ -210,3 +212,37 @@ int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
     g_array_free(madt, true);
     return result;
 }
+
+/*
+ * Process device tree IGVM parameter
+ */
+int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
+                                Error **errp)
+{
+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
+    QIgvmParameterData *param_entry;
+    uint32_t fdt_size;
+
+    /* Find the parameter area that should hold the device tree data */
+    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    if (param_entry == NULL) {
+        return 0;
+    }
+
+    if (ctx->machine_state->fdt == NULL) {
+        error_setg(errp, "IGVM: device tree not available");
+        return -1;
+    }
+
+    fdt_size = fdt_totalsize(ctx->machine_state->fdt);
+    if (fdt_size > param_entry->size) {
+        error_setg(errp,
+                   "IGVM: device tree size exceeds parameter area"
+                   " defined in IGVM file");
+        return -1;
+    }
+
+    memcpy(param_entry->data, ctx->machine_state->fdt, fdt_size);
+
+    return 0;
+}

-- 
2.54.0


