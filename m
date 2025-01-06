Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC03E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 20:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUtK9-0002ld-1r; Mon, 06 Jan 2025 15:03:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUtK7-0002ja-2f
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:03:39 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUtK3-0003FX-6M
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:03:38 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385dece873cso5490594f8f.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 12:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736193813; x=1736798613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxJ3+xb03FIgQb6HyhO+0vTNSYN1GRLEa0EnbI36swA=;
 b=fi+mmOV6FpCWixDy/UGX6sSvUe51RRCle/PhRukH6wdUPnDYzo5O6GqGbFqrXsUgT4
 ErIw1js0sFnfGpRJeY3CrpxElC0EG2i5NJPPN7Bw0KRTspIh8jQlk1cuzP+up25QF/Ou
 gpLWTpU/zTqDWmRnZSms5h+/81azirWJOt0sbfUUK1hjqxhsqrIPCY+XrvBXUltN3wWd
 mrwwOG2bk4GvHz9MOAbkAz8plix/jy7x6u67/96EtALeJeOEj0HYP5E2M5+6CcUa87a7
 wCTRK/k4Zd6N2zA751tGOAq6WelbDkzSkmZE7Hlv1suwR9gEJbS+vKfQQ0P0IYPPHCkA
 tS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736193813; x=1736798613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zxJ3+xb03FIgQb6HyhO+0vTNSYN1GRLEa0EnbI36swA=;
 b=gHICRBblk2pnF6BL6l/qw8tzAmkloZLZWQgM6YkwuQ1i7qqhS9H99r7YffVezh6T8M
 gOEZAb6uOGAU0dkVyqzxTLOlUgQvkkFnRgQSnWLel2fwRpqdIYg0xkbjqIxbUFhbA+sX
 dAz1ruEmrgzKTkYWWRg4KUllGqwv1Aw/F2c1l5a+JMY1eBPsttvgv9IPggVeR9p7A9x5
 jVrd1WHy7epMjialxyGJkXk0FJ3m+zATzeud+HGIMcU1oBJLZAY1uqz02JjR5o0uwl/M
 vpMZm7ygR9G14h8/in6udMWuS4yS0TTnGloobQ5QQgFlgEnDAzp/iUpgaNZE+DBIS3pu
 5OqA==
X-Gm-Message-State: AOJu0YzpWaayFW2nSnbUiuO44gMYHU5+6gTWoK5+e1UvLa+qrxUBCGfe
 gYa59Ya09HNtJQySxHA0Zi7fpo9j+uTTs+NvVlLq8wCECw4ZCf4sfPNbGgXvTmkQnYRMDPzYF80
 wpaM=
X-Gm-Gg: ASbGncsx5R5jKP8laHfykcMZrLfVnGJfy/NhAea1DWa15jXNFdBrCzEcJyWXWjJ9ymb
 aj+pBxsCo6TI8xHZeYD7Rm4Cv+tP4n3Jco1LMzDbymYk6w57dJFcZHD5om8cKvg6rSKoKEV40nj
 9G5WBAPTQxnErkt119tAH0OREu6xgBa795oUdxzmGqM9bQWgfSYtv7QuWUMYdFyS7iTlTLiEp9I
 qOiPvVzyixh8aPzHKJsalX1RHHx8hYXDmzLNXk5W5mQbq+y+7pm2Mm5SSXmHjOYHaDNRdg3e3W6
 nqTDo6wIaOAQEjSfhstyIY61gEOgplw=
X-Google-Smtp-Source: AGHT+IGoS13s7EdoAdq3NUY+QaACk4mt67qvYvBPAyuPr3+V1znGvuXeRZNJwXBUnZIrDNw4J4+93w==
X-Received: by 2002:adf:a3d9:0:b0:38a:39ad:3e31 with SMTP id
 ffacd0b85a97d-38a39ad4128mr24752061f8f.57.1736193813254; 
 Mon, 06 Jan 2025 12:03:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6d02sm618987535e9.1.2025.01.06.12.03.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jan 2025 12:03:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Alexander Graf <agraf@csgraf.de>, Paul Durrant <paul@xen.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, Anthony PERARD <anthony@xenproject.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 David Woodhouse <dwmw2@infradead.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH 5/7] accel/hw: Implement hw_accel_get_cpus_queue()
Date: Mon,  6 Jan 2025 21:02:56 +0100
Message-ID: <20250106200258.37008-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106200258.37008-1-philmd@linaro.org>
References: <20250106200258.37008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We can only run a single hardware accelerator at a time,
so add a generic hw_accel_get_cpus_queue() helper in
accel-system.c, a file common to all HW accelerators.

Register AccelOpsClass::get_cpus_queue() for each HW
accelerator. Add a generic CPU_FOREACH_HWACCEL() macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/hw_accel.h         | 9 +++++++++
 accel/accel-system.c              | 8 ++++++++
 accel/kvm/kvm-accel-ops.c         | 1 +
 accel/xen/xen-all.c               | 1 +
 target/i386/nvmm/nvmm-accel-ops.c | 1 +
 target/i386/whpx/whpx-accel-ops.c | 1 +
 6 files changed, 21 insertions(+)

diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index 380e9e640b6..12664cac6f9 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -2,6 +2,7 @@
  * QEMU Hardware accelerators support
  *
  * Copyright 2016 Google, Inc.
+ * Copyright 2025 Linaro Ltd.
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
@@ -17,6 +18,14 @@
 #include "system/whpx.h"
 #include "system/nvmm.h"
 
+/* Guard with qemu_cpu_list_lock */
+extern CPUTailQ hw_accel_cpus_queue;
+
+#define CPU_FOREACH_HWACCEL(cpu) \
+            QTAILQ_FOREACH_RCU(cpu, &hw_accel_cpus_queue, node)
+
+CPUTailQ *hw_accel_get_cpus_queue(void);
+
 void cpu_synchronize_state(CPUState *cpu);
 void cpu_synchronize_post_reset(CPUState *cpu);
 void cpu_synchronize_post_init(CPUState *cpu);
diff --git a/accel/accel-system.c b/accel/accel-system.c
index a7596aef59d..60877ea7a28 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -27,9 +27,17 @@
 #include "qemu/accel.h"
 #include "hw/boards.h"
 #include "system/cpus.h"
+#include "system/hw_accel.h"
 #include "qemu/error-report.h"
 #include "accel-system.h"
 
+CPUTailQ hw_accel_cpus_queue = QTAILQ_HEAD_INITIALIZER(hw_accel_cpus_queue);
+
+CPUTailQ *hw_accel_get_cpus_queue(void)
+{
+    return &hw_accel_cpus_queue;
+}
+
 int accel_init_machine(AccelState *accel, MachineState *ms)
 {
     AccelClass *acc = ACCEL_GET_CLASS(accel);
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index a81e8f3b03b..5f4001860d5 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -93,6 +93,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
+    ops->get_cpus_queue = hw_accel_get_cpus_queue;
     ops->create_vcpu_thread = kvm_start_vcpu_thread;
     ops->cpu_thread_is_idle = kvm_vcpu_thread_is_idle;
     ops->cpus_are_resettable = kvm_cpus_are_resettable;
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index 852e9fbe5fe..ac5ed2dfb80 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -150,6 +150,7 @@ static void xen_accel_ops_class_init(ObjectClass *oc, void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
+    ops->get_cpus_queue = hw_accel_get_cpus_queue;
     ops->create_vcpu_thread = dummy_start_vcpu_thread;
 }
 
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index e7b56662fee..bb407c68e14 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -84,6 +84,7 @@ static void nvmm_accel_ops_class_init(ObjectClass *oc, void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
+    ops->get_cpus_queue = hw_accel_get_cpus_queue;
     ops->create_vcpu_thread = nvmm_start_vcpu_thread;
     ops->kick_vcpu_thread = nvmm_kick_vcpu_thread;
 
diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index ab2e014c9ea..191214ca81d 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -86,6 +86,7 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
+    ops->get_cpus_queue = hw_accel_get_cpus_queue;
     ops->create_vcpu_thread = whpx_start_vcpu_thread;
     ops->kick_vcpu_thread = whpx_kick_vcpu_thread;
     ops->cpu_thread_is_idle = whpx_vcpu_thread_is_idle;
-- 
2.47.1


