Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0E2C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdUj-0002fO-63; Tue, 04 Mar 2025 20:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdTb-0000Cw-K5
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:14 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdTZ-00072K-R2
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:11 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43bc0b8520cso18283125e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137788; x=1741742588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aeQ4l2OYCtamyJNS0OGrQ+B6RH9yuhSbCm/kTfeIjFw=;
 b=sHuL/NuiwUnmUgf9vSd4+e4dcqwHfNMzS6WvPuHPb5ejnVnN5XQmK3zgpgdPCYza8w
 cb9GIEWiYDocMNlYsU+ioQOC+d6Dl7UYQ1iaukqBcXQKF9IrcVIlSaeOpxycxE3+SM4Z
 QQ4hlWDrCSirRxNxUaV9EBevQCmuBr7yKdVUtgD4I2eeGZ2KmZoLH0Xlw7spr7seMhRY
 cgV18xqB3rkgIrusf+zebm6DZKCtQ5eSjKCHYXdHnALbfucC1FtyfO8UOerluP82MQS3
 yjqY4nQco/DrhEjU6+PrczvfyQNDgJkSptbDCroEwQ2yWWVompncH+2d3GKw0VtXVS/p
 aLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137788; x=1741742588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aeQ4l2OYCtamyJNS0OGrQ+B6RH9yuhSbCm/kTfeIjFw=;
 b=b/Xvp0kmG6AtPxP1L0Fy+5qBCtbAqbjiN4UbxUgNW+mJiJex3Bh7fPyaedGgp4wHhm
 UeniYTynt/scGhkaYVsf1+U3bdc1mSHHZrVBjQSNvaane3LzZIlF5ty2zP5qzegRt1S3
 cMgFqWJ3sni0U4cZc5r0VJ4rHwEkRNFZEd6SYhB56DBvXnmskSNHc8HpiSbn6w+gzUBR
 Udl34SW1YYSKn5gaG8TRfx1JMdIUTsosHxHgOH5oaUfIbLYRxp6seoilb8GtZfL43i/p
 fVXec9IHGcgONS5j/+ZlM/xqZOUofvVGtcm1H75oSy9qCSlj2rHS4Pk51cQZswxT8iUG
 1aCQ==
X-Gm-Message-State: AOJu0YzYLaGak6KNVWP+UidJ6xv1OPMaiImSSU4u5P6uTSL2pQAA0dZH
 aanws5d+ezeWlDVnRKIPbsNITeQafWAt6Ibj+FVS9GTNA8+JLiHFa+UvhOPX3IowVR8/OFKhQ84
 YDH8=
X-Gm-Gg: ASbGnctUXlZfv7xtIRHgWxIBJx47+zklkWhedEVwx3X+5w20aSBTxtvNrH44TwvfxH3
 X8U335nKxNn270hG5SgHJVKCcXGDIUjxjahBN9Ao1EDjbUa3NMt0VgiVfYnEaqlX9ywen3pn/qp
 OAm93dB4pgz+uQ6LgFT/5VugR3beQePXiDjF4bbPlBzrySsZ77ywjTjo+/qjhugkty9p/FNevQM
 cEYom2BrDR7MkvvXQlTwOgXjb8oOvBUkCEvtEHBCoajW2Bwff0htaGfOnnv6oUj//UAEMhD69+J
 JbLqHGK57XojhHDFqPVlIVkekoNdua5GVsbxRWkyO5cTnjGxhobaiRwtsXM00ZkAvQqpzYAkppf
 P8f9D+aOSbLCb/N0wGis=
X-Google-Smtp-Source: AGHT+IEz9bELYNHsjKK2F/BgmQWXnXhLASFYyS27hnCY1gOJJavUIwFuGaRJcYLARH10q7J9vflpNg==
X-Received: by 2002:a05:6000:1448:b0:391:ab2:9e87 with SMTP id
 ffacd0b85a97d-3911f7264e3mr616606f8f.6.1741137787876; 
 Tue, 04 Mar 2025 17:23:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4847fe5sm19388500f8f.73.2025.03.04.17.23.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:23:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 14/41] hw/xen/xen-pvh: Reduce included headers
Date: Wed,  5 Mar 2025 02:21:29 +0100
Message-ID: <20250305012157.96463-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Have "hw/xen/xen-pvh-common.h" include the bare minimal set
of headers. Adapt sources to avoid errors when refactoring
unrelated headers such:

    hw/i386/xen/xen-pvh.c: In function ‘xen_pvh_machine_class_init’:
    hw/i386/xen/xen-pvh.c:84:28: error: ‘TARGET_DEFAULT_CPU_TYPE’ undeclared (first use in this function)
       84 |     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
          |                            ^~~~~~~~~~~~~~~~~~~~~~~
    hw/xen/xen-pvh-common.c: In function ‘xen_pvh_init’:
    hw/xen/xen-pvh-common.c:217:43: error: ‘MiB’ undeclared (first use in this function)
      217 |         if (s->cfg.pci_ecam.size != 256 * MiB) {
          |                                           ^~~
    hw/xen/xen-hvm-common.c:18:6: error: no previous prototype for ‘xen_mr_is_memory’ [-Werror=missing-prototypes]
       18 | bool xen_mr_is_memory(MemoryRegion *mr)
          |      ^~~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20250218162618.46167-5-philmd@linaro.org>
---
 include/hw/xen/xen-pvh-common.h | 8 ++++----
 hw/i386/xen/xen-pvh.c           | 1 +
 hw/xen/xen-pvh-common.c         | 5 ++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/xen/xen-pvh-common.h b/include/hw/xen/xen-pvh-common.h
index 5cdd23c2f4d..17c5a58a5a4 100644
--- a/include/hw/xen/xen-pvh-common.h
+++ b/include/hw/xen/xen-pvh-common.h
@@ -9,11 +9,11 @@
 #ifndef XEN_PVH_COMMON_H__
 #define XEN_PVH_COMMON_H__
 
-#include <assert.h>
-#include "hw/sysbus.h"
-#include "hw/hw.h"
-#include "hw/xen/xen-hvm-common.h"
+#include "exec/memory.h"
+#include "qom/object.h"
+#include "hw/boards.h"
 #include "hw/pci-host/gpex.h"
+#include "hw/xen/xen-hvm-common.h"
 
 #define TYPE_XEN_PVH_MACHINE MACHINE_TYPE_NAME("xen-pvh-base")
 OBJECT_DECLARE_TYPE(XenPVHMachineState, XenPVHMachineClass,
diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
index 33c10279763..f6356f2a7ed 100644
--- a/hw/i386/xen/xen-pvh.c
+++ b/hw/i386/xen/xen-pvh.c
@@ -14,6 +14,7 @@
 #include "hw/xen/arch_hvm.h"
 #include <xen/hvm/hvm_info_table.h>
 #include "hw/xen/xen-pvh-common.h"
+#include "target/i386/cpu.h"
 
 #define TYPE_XEN_PVH_X86  MACHINE_TYPE_NAME("xenpvh")
 OBJECT_DECLARE_SIMPLE_TYPE(XenPVHx86State, XEN_PVH_X86)
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 9c21fa858d3..d675f7a8aeb 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -8,14 +8,13 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "qapi/error.h"
+#include "qemu/units.h"
 #include "qapi/visitor.h"
 #include "hw/boards.h"
 #include "hw/irq.h"
-#include "hw/sysbus.h"
-#include "system/system.h"
 #include "system/tpm.h"
 #include "system/tpm_backend.h"
+#include "system/runstate.h"
 #include "hw/xen/xen-pvh-common.h"
 #include "trace.h"
 
-- 
2.47.1


