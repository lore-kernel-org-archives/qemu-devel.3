Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D950FC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 17:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6uX-0007Ld-No; Wed, 15 Jan 2025 12:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6uS-0007FI-Mp
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:30 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6uR-0006XD-0R
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:28 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so22167285e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 09:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736961025; x=1737565825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KxP4KhsAoIrkijG1kO5uGQ16mZCFRr5vQmqFMkBbKho=;
 b=bUzX4RRfcRFBpDxZOruj8TseBkNkL9m9X5j58p1HMr5yg7S5g4UeN8u9RqcdMF3hQJ
 p4xyqRer14BRBJ8WV/JJpnQlkZothot5pR4Ksfsz2dwbjRbi3b4Q53AGk2pwWB45cRIf
 /9ICOML6iIKKzzwFeOjxlju3//kJbLkeRQYpBE71NCMQLCOUNEsT0Lkz9BDc/RRQGWXM
 JE8mb8sE4XLq2lK2jcby4VvYDatWMLtOYdPOwWWNs0R1JAZkEJTRJTlCUV2kJ0cssGO/
 KGuF1J5Fr9p5ooK+dL+UG9mxQbUWQRv3pL2k+yvlKxh9yXkweMUImum9cL+wnTKkEHh/
 wtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736961025; x=1737565825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KxP4KhsAoIrkijG1kO5uGQ16mZCFRr5vQmqFMkBbKho=;
 b=OnFFardvWzRHv04LXKRikMxNdjZ1wYzmAhwIrMUV+WAH2kZZM2241yQ1K6DoI0JxUU
 gHDbwW+KVCeTxVZ7cAYoSYoJFe5IrAwXAc5C4m51alMXCB6q0sVJ3cIbPImKTTE/vPJw
 gwS7OJEHhgfQyqpDC6y5MVE6jrCVTUSvOLTs8mpiHEFIdk3NUoYYaYqmaPlvyBdJc2OW
 zopmKJ1XQq4TQRTHBfhYixOTeZkKIkqaL7iW5HIcAqve00AGHe0SlkJvAD10iciKdqRz
 tIP6LD2NW/dJWueu3UhbVcHCT9JVN7dExRUnWX+7hdW64qGdP42eMJCDzbHFQqub1LkM
 iUOw==
X-Gm-Message-State: AOJu0YxzcPxwdW2a204haXedxoiwZ3MMr7A56ntWoODiTLuW94KnlC0k
 tNaIGKkrWqqcnXBg4x62nURbAjp0SoBqYHMHZY5saNaDcg08dsL16uzOgYrKKexATHspMazkGGW
 8pN8=
X-Gm-Gg: ASbGnct5XWjk7olG4NlLcuHIrNBtKY8now70wJ7DOkxVxsN2gWRfYTc20T3zRH02foS
 pS0/yRcxcNkqWeoXHFsoteKvKB4Qt/xU9v7ur0gzwR2vdAKWx5tmSipa9urSfYRinn1PcvmZO5W
 yxqWfwxazPyLibtCv2JtMbmP6Zv88mfJiuZDfXbICEZgV1Qb8W3TNPvdl68TFp3w5N7jZFpFLtv
 FeHRIpI67T8IViNEhVOiRCGkWlhJrZbpZ4pqUyeKRIhlqvtDwY4qL7wFXFwxlxdpTbjamQ0a5Tp
 GZYKkQIi+lwAkW1CALoBTiw7ZiEta8d5ryLM
X-Google-Smtp-Source: AGHT+IFgYAldhXNjIPEym55kT+EMyHeyOv6QYpJ/yAVxasdL+K3HD8c/cP6DvQLSMsrp/P/2YjL9DA==
X-Received: by 2002:a05:600c:4586:b0:434:edcf:7461 with SMTP id
 5b1f17b1804b1-436e26f135bmr299719435e9.30.1736961025128; 
 Wed, 15 Jan 2025 09:10:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74ace90sm30491535e9.16.2025.01.15.09.10.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 09:10:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/13] hw/arm/virt: Remove
 VirtMachineClass::disallow_affinity_adjustment
Date: Wed, 15 Jan 2025 18:09:59 +0100
Message-ID: <20250115171009.19302-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115171009.19302-1-philmd@linaro.org>
References: <20250115171009.19302-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

The VirtMachineClass::disallow_affinity_adjustment
field was only used by virt-2.6 machine, which got
removed. Remove it along with the GIC*_TARGETLIST_BITS
definitions, and simplify virt_cpu_mp_affinity().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/virt.h              |  1 -
 include/hw/intc/arm_gic.h          |  1 -
 include/hw/intc/arm_gicv3_common.h |  3 ---
 hw/arm/virt.c                      | 16 ----------------
 4 files changed, 21 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 27c5bb585cb..5d3b25509ff 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -117,7 +117,6 @@ typedef enum VirtGICType {
 
 struct VirtMachineClass {
     MachineClass parent;
-    bool disallow_affinity_adjustment;
     bool no_its;
     bool no_tcg_its;
     bool claim_edge_triggered_timers;
diff --git a/include/hw/intc/arm_gic.h b/include/hw/intc/arm_gic.h
index 48f6a51a70a..f5e6e5e70b4 100644
--- a/include/hw/intc/arm_gic.h
+++ b/include/hw/intc/arm_gic.h
@@ -68,7 +68,6 @@
 #include "qom/object.h"
 
 /* Number of SGI target-list bits */
-#define GIC_TARGETLIST_BITS 8
 #define GIC_MAX_PRIORITY_BITS 8
 #define GIC_MIN_PRIORITY_BITS 4
 
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index a3d6a0e5077..fff5e55a97d 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -45,9 +45,6 @@
 #define GICV3_REDIST_SIZE 0x20000
 #define GICV4_REDIST_SIZE 0x40000
 
-/* Number of SGI target-list bits */
-#define GICV3_TARGETLIST_BITS 16
-
 /* Maximum number of list registers (architectural limit) */
 #define GICV3_LR_MAX 16
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0080577e1a9..2a2a0bd9154 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1760,23 +1760,7 @@ void virt_machine_done(Notifier *notifier, void *data)
 static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
 {
     uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
 
-    if (!vmc->disallow_affinity_adjustment) {
-        /* Adjust MPIDR like 64-bit KVM hosts, which incorporate the
-         * GIC's target-list limitations. 32-bit KVM hosts currently
-         * always create clusters of 4 CPUs, but that is expected to
-         * change when they gain support for gicv3. When KVM is enabled
-         * it will override the changes we make here, therefore our
-         * purposes are to make TCG consistent (with 64-bit KVM hosts)
-         * and to improve SGI efficiency.
-         */
-        if (vms->gic_version == VIRT_GIC_VERSION_2) {
-            clustersz = GIC_TARGETLIST_BITS;
-        } else {
-            clustersz = GICV3_TARGETLIST_BITS;
-        }
-    }
     return arm_build_mp_affinity(idx, clustersz);
 }
 
-- 
2.47.1


