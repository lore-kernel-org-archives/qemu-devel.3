Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E828C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 16:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgR6o-0000xj-O1; Fri, 07 Feb 2025 11:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tgR6g-0000vQ-UQ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:21:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tgR6f-0007ki-7O
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738945288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ozque1Q1JsvWH7VH9T2T7K5SjPUWPfN8XmpcXVaU0IM=;
 b=aU17UzYUyldBHm5xQoFyQJ6MY4lY7nCnNFiPfQUd1S9xeNJn1wFvJoCXX23DHeCSSR1xCb
 Wvitwfg+C4qCApn4E5IsFGhW4/6EZGFPtj1uXOBpG5fdp46rc0wziKgrWx2gS+zp2WURqS
 UbneDJ6IvpqyPQWTQjEh9xDh1HwXIfk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-LH0Id2_4P1CHEETs5uTrVA-1; Fri,
 07 Feb 2025 11:21:20 -0500
X-MC-Unique: LH0Id2_4P1CHEETs5uTrVA-1
X-Mimecast-MFC-AGG-ID: LH0Id2_4P1CHEETs5uTrVA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F36F1801A22; Fri,  7 Feb 2025 16:21:14 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 549DD1800879; Fri,  7 Feb 2025 16:21:12 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 08/10] cpus: expose only realized vCPUs to global
 &cpus_queue
Date: Fri,  7 Feb 2025 17:20:46 +0100
Message-ID: <20250207162048.1890669-9-imammedo@redhat.com>
In-Reply-To: <20250207162048.1890669-1-imammedo@redhat.com>
References: <20250207162048.1890669-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

cpu_list_add() was doing 2 distinct things:
- assign some index to vCPU
- add unrealized (thus in inconsistent state) vCPU to &cpus_queue

Code using CPU_FOREACH() macro would iterate over possibly
unrealized vCPUs, often dealt with special casing.

Instead of working around of vCPU existence in cpus_queue,
split out cpu_index assignment from cpu_list_add(),
and move the later to the end of realize stage,
right before vCPU is let run.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Yanan Wang <wangyanan55@huawei.com>
CC: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/core/cpu.h |  6 ++++++
 cpu-common.c          | 23 ++++++++++++++---------
 cpu-target.c          |  2 +-
 hw/core/cpu-common.c  |  2 ++
 4 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index fb397cdfc5..c338fd31bd 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -750,6 +750,12 @@ bool cpu_virtio_is_big_endian(CPUState *cpu);
 
 #endif /* CONFIG_USER_ONLY */
 
+/**
+ * cpu_auto_assign_cpu_index:
+ * @cpu: The CPU to be assigned a cpu_index
+ */
+void cpu_auto_assign_cpu_index(CPUState *cpu);
+
 /**
  * cpu_list_add:
  * @cpu: The CPU to be added to the list of CPUs.
diff --git a/cpu-common.c b/cpu-common.c
index 4248b2d727..92f3d00e56 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -71,15 +71,7 @@ int cpu_get_free_index(void)
     return max_cpu_index;
 }
 
-CPUTailQ cpus_queue = QTAILQ_HEAD_INITIALIZER(cpus_queue);
-static unsigned int cpu_list_generation_id;
-
-unsigned int cpu_list_generation_id_get(void)
-{
-    return cpu_list_generation_id;
-}
-
-void cpu_list_add(CPUState *cpu)
+void cpu_auto_assign_cpu_index(CPUState *cpu)
 {
     static bool cpu_index_auto_assigned;
 
@@ -91,6 +83,19 @@ void cpu_list_add(CPUState *cpu)
     } else {
         assert(!cpu_index_auto_assigned);
     }
+}
+
+CPUTailQ cpus_queue = QTAILQ_HEAD_INITIALIZER(cpus_queue);
+static unsigned int cpu_list_generation_id;
+
+unsigned int cpu_list_generation_id_get(void)
+{
+    return cpu_list_generation_id;
+}
+
+void cpu_list_add(CPUState *cpu)
+{
+    QEMU_LOCK_GUARD(&qemu_cpu_list_lock);
     QTAILQ_INSERT_TAIL_RCU(&cpus_queue, cpu, node);
     cpu_list_generation_id++;
 }
diff --git a/cpu-target.c b/cpu-target.c
index 667688332c..0c86c18a50 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -142,7 +142,7 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
     }
 
     /* Wait until cpu initialization complete before exposing cpu. */
-    cpu_list_add(cpu);
+    cpu_auto_assign_cpu_index(cpu);
 
 #ifdef CONFIG_USER_ONLY
     assert(qdev_get_vmsd(DEVICE(cpu)) == NULL ||
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index cb79566cc5..c29737e5e3 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -211,6 +211,8 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
+    cpu_list_add(cpu);
+
     if (dev->hotplugged) {
         cpu_synchronize_post_init(cpu);
         cpu_resume(cpu);
-- 
2.43.0


