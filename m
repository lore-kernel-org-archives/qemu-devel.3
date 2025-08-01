Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EE8C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 13:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhpvk-0005VR-5o; Fri, 01 Aug 2025 09:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerkolothum@gmail.com>)
 id 1uhkUc-00051W-Oy; Fri, 01 Aug 2025 03:47:55 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shameerkolothum@gmail.com>)
 id 1uhkUa-0007nu-QK; Fri, 01 Aug 2025 03:47:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4560cdf235cso9388605e9.1; 
 Fri, 01 Aug 2025 00:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754034470; x=1754639270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ov0CnZ6hllKCqiijw1Ug4lyN3JdBE3w2Bo15YiF82ag=;
 b=Iv/JO4yda5/XDvw/zVbC/X9JYvXyAfzu+qc5MTdjEJxrmvlzSCCTn9MGbbyvlCKB+M
 hMmkRISV3/63v0DTwwkZi4NJaWlP2HpFxC627gLDBDYIlzJ9QY6AJt9y3NS1iQS4SzBx
 FmOMVUeX6yctlC6Z9gMeqgy7mRAr9DAyn6lVRWdh6UdHd5kR6FYq1T4kDs/MoZF9YraY
 Q4cJzTULqm19pMl2JPoeMezmpJGmpybPIIjiQHQmlKhQZAR6Wfhko1OnBO/kWyPZ+aNr
 D38A3i3au344UVCKA3h8U5Wf8yj4AbwM8OclsblDpPO3oWpT6vYJnLDjz6UaYQRIbqjh
 14wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754034470; x=1754639270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ov0CnZ6hllKCqiijw1Ug4lyN3JdBE3w2Bo15YiF82ag=;
 b=sP7xM5+7doS4vbLRMI0jfOHUF5VWOCHswvX7JNY8a//rnuUmRSGcgBDM6b6/mjEe8O
 2UNv32J+2WbsMqYV6PK5LrfrBqliY1iDXEj3Yrj+gF4H38V49Wa2mA3X++TSkkCUM+Es
 zKVyGYzv9WSRpDtFFidcfJJoMzVO1FQajEqllzL7PJstCLg27D7UZxZ4/DXUC7GBtttH
 fr7zvhhH/2wyPg+SjXQ8+HRnQ0WANSoVSGKuYnSG7oIz24gKAaoEpPuHQU3VuzE3pSLa
 Yv3UDnRMm3jUzmfx851v0kSJ3wYG0WYZ813hPXnkdpsr2fNx4uWHJ25ZHt5pPvL7zOv4
 5s8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWivgs0LrxMTRB3N8KE0gcdV9XTND76Qhc5w7BveKSL//BV8/AGhBR8cBBbNty138zOX06RNkI5twx+@nongnu.org
X-Gm-Message-State: AOJu0YwKtnQa8kuf5VQg6v0h8P3DdYAZyD+YfNagTW04gkjVXfRwAhQl
 0P/YjL0Xvca0McqxY/d5pgbVaLc6hIon4puAbPljqitZ2ozH0gMvrwPDziMVug==
X-Gm-Gg: ASbGncsQFEU/OGYdtj+WcrEb4cAY4jcSCUaoo9tSYhju12pA8GBpPoJ5gMBvb81nSZJ
 svOc9sI8nrP1ATRZqacw+Y3asADpzvtwuE89da2SrIwLJnBZsxU5pAHmnzVC0AYbwo+SQJlVZQ8
 +6Fhe7lOyQ/mpEggsZyKxp4bPXUJsma46yq3H7ny5IS6a7854NNrPW+KWIUqpHOBjEMGankXS27
 VonYfkuWYdOfI14Y7NIbSMmqLz3Vgo9I3jQgeD1FSE6DBDBwoSn6Z8lOpnLM4gNG97DufXrukCA
 /k4z0Lkq7VQU+eM0RAnQqhf89p8N+mv+izd3VYxLN+37DMOt/cLq+jBG+/tg9tqilr48iOzHkZD
 gP0x3A2NrMy/8nEfjCRc/38rqEyIxI2Fn/A==
X-Google-Smtp-Source: AGHT+IHw0s5vRX9hiKIGqaNMqYOSZM+3EhnTkDB3mYJdCHKjAgVdM5kXkCqL09KKppw3GKkpwu2k8g==
X-Received: by 2002:a05:600c:1c92:b0:458:a5f9:aa68 with SMTP id
 5b1f17b1804b1-458a9aff5a8mr14716955e9.2.1754034469906; 
 Fri, 01 Aug 2025 00:47:49 -0700 (PDT)
Received: from shameer-ubuntu ([195.11.233.227])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453ab0sm5049185f8f.44.2025.08.01.00.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 00:47:49 -0700 (PDT)
From: Shameer Kolothum <shameerkolothum@gmail.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, berrange@redhat.com, maz@kernel.org,
 oliver.upton@linux.dev, armbru@redhat.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, salil.mehta@huawei.com,
 yangjinqian1@huawei.com, shameerkolothum@gmail.com,
 shameerali.kolothum.thodi@huawei.com
Subject: [RFC PATCH RESEND 4/4] hw/arm/virt: Add Target Implementation CPU
 support
Date: Fri,  1 Aug 2025 08:47:30 +0100
Message-ID: <20250801074730.28329-5-shameerkolothum@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801074730.28329-1-shameerkolothum@gmail.com>
References: <20250801074730.28329-1-shameerkolothum@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shameerkolothum@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 01 Aug 2025 09:35:51 -0400
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

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Add the impl-cpu property to virt machine. This will enable
user to specify the target implementation CPUs as the example
below:

...
-M impl-cpu.0.midr=1,impl-cpu.0.revidr=1,impl-cpu.0.aidr=1,\
impl-cpu.1.midr=2,impl-cpu.1.revidr=2,impl-cpu.1.aidr=2 \

Make use of helper functions to check the KVM support for target
Impl CPUs and if supported set the user specified target CPUs.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/virt.c         | 66 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h |  3 ++
 2 files changed, 69 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a96452f17a..72a0cd3ea8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -71,6 +71,7 @@
 #include "hw/firmware/smbios.h"
 #include "qapi/visitor.h"
 #include "qapi/qapi-visit-common.h"
+#include "qapi/qapi-visit-machine.h"
 #include "qobject/qlist.h"
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
@@ -2232,6 +2233,20 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
+    if (vms->target_cpus_num) {
+        if (!kvm_enabled()) {
+            error_report("Target Impl CPU requested, but not supported "
+                         "without  KVM");
+            exit(1);
+        }
+
+        if (!kvm_arm_target_impl_cpus_supported()) {
+            error_report("Target Impl CPU requested, but not supported by KVM");
+            exit(1);
+        }
+        kvm_arm_set_target_impl_cpus(vms->target_cpus_num, vms->target_cpus);
+    }
+
     create_fdt(vms);
 
     assert(possible_cpus->len == max_cpus);
@@ -2666,6 +2681,45 @@ static void virt_set_oem_table_id(Object *obj, const char *value,
     strncpy(vms->oem_table_id, value, 8);
 }
 
+static void virt_set_target_impl_cpus(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    ArmTargetImplCPUList *list = NULL;
+    ArmTargetImplCPUList *iter = NULL;
+    ArmTargetImplCPU *target_cpus;
+    uint64_t target_num = 0;
+    int i;
+
+    visit_type_ArmTargetImplCPUList(v, name, &list, errp);
+    if (!list) {
+        return;
+    }
+
+    for (iter = list; iter; iter = iter->next) {
+        target_num++;
+    }
+
+    target_cpus = g_new0(ArmTargetImplCPU, target_num);
+    for (i = 0, iter = list; iter; iter = iter->next, i++) {
+        target_cpus[i].midr = iter->value->midr;
+        target_cpus[i].revidr = iter->value->revidr;
+        target_cpus[i].aidr = iter->value->aidr;
+    }
+    vms->target_cpus_num = target_num;
+    vms->target_cpus = target_cpus;
+    vms->target_cpus_list = list;
+}
+
+static void virt_get_target_impl_cpus(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    ArmTargetImplCPUList **list = &vms->target_cpus_list;
+
+    visit_type_ArmTargetImplCPUList(v, name, list, errp);
+}
 
 bool virt_is_acpi_enabled(VirtMachineState *vms)
 {
@@ -3326,6 +3380,18 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
                                           "Override the default value of field OEM Table ID "
                                           "in ACPI table header."
                                           "The string may be up to 8 bytes in size");
+    object_class_property_add(oc, "impl-cpu", "ArmTargetImplCPU",
+                              virt_get_target_impl_cpus,
+                              virt_set_target_impl_cpus,
+                              NULL, NULL);
+    object_class_property_set_description(oc, "impl-cpu",
+                                          "Describe target implementation CPU in the format: "
+                                          "impl-cpu.0.midr=1,"
+                                          "impl-cpu.0.revidr=1,"
+                                          "impl-cpu.0.aidr=1,"
+                                          "impl-cpu.1.midr=2,"
+                                          "impl-cpu.1.revidr=2,"
+                                          "impl-cpu.1.aidr=2");
 
 }
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index c8e94e6aed..cf462fcb37 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -180,6 +180,9 @@ struct VirtMachineState {
     char *oem_id;
     char *oem_table_id;
     bool ns_el2_virt_timer_irq;
+    uint64_t target_cpus_num;
+    ArmTargetImplCPU *target_cpus;
+    ArmTargetImplCPUList *target_cpus_list;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
-- 
2.34.1


