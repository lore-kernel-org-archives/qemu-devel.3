Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF29D42BAF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuKY-0005xX-JT; Tue, 12 Nov 2024 12:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tAuIY-0003Ug-BR
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:03:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tAuIV-0001ZE-VE
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:03:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731431001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qVlo8MFDWWxPC+9r6AmKTmietuGa8U+YVrW6FdiP3KI=;
 b=XdZtoPxiL70DhieJBsN0MG3C/Y2DoAuCPtl0yLV/P9DYERPFjFyJ35q+/c5jY8Vw2rxaj2
 FH3SRydiqdl854VhxzWYq0n9AmQrcyFcnsM7RbUswnTk8r6tgmanYR88984x8HHOgk1jmx
 wZEetBLM/vuyh+xslqGMU8Mr8fwYD3c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-32GpZeY2MaGxldT5xkGTtg-1; Tue,
 12 Nov 2024 12:03:19 -0500
X-MC-Unique: 32GpZeY2MaGxldT5xkGTtg-1
X-Mimecast-MFC-AGG-ID: 32GpZeY2MaGxldT5xkGTtg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CF821955EE7; Tue, 12 Nov 2024 17:03:15 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A6E65195607C; Tue, 12 Nov 2024 17:03:12 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: salil.mehta@huawei.com, mst@redhat.com, imammedo@redhat.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com, anisinha@redhat.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, gustavo.romero@linaro.org
Subject: [PATCH 3/7 for-9.2] Revert "hw/acpi: Make CPUs ACPI `presence`
 conditional during vCPU hot-unplug"
Date: Tue, 12 Nov 2024 18:02:54 +0100
Message-ID: <20241112170258.2996640-4-imammedo@redhat.com>
In-Reply-To: <20241112170258.2996640-1-imammedo@redhat.com>
References: <20241112170258.2996640-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.671,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This reverts commit 2d6cfbaf174b91dfa9a50065f7494634afb39c23.

The patch is supposed to be part of ARM CPU hotplug series and has not value
on its own without it. The series however is still in RFC stage and outside
of scope 9.2 release.

On top of that it introduces not needed callback that pokes directly into
CPU state without any need for that. Instead properties and AML generator
option should be used to configure static platform depended vCPU presence
state.

Drop the patch so that corrected version could be posted along with
ARM CPU hotplug series and properly reviewed in relevant context.
That also helps us to keep history cleaner with new patch being
against original code vs a string of fixups on top of current mess.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/core/cpu.h |  1 -
 hw/acpi/cpu.c         | 15 +--------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index e7de77dc6d..c3ca0babcb 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -158,7 +158,6 @@ struct CPUClass {
     void (*dump_state)(CPUState *cpu, FILE *, int flags);
     void (*query_cpu_fast)(CPUState *cpu, CpuInfoFast *value);
     int64_t (*get_arch_id)(CPUState *cpu);
-    bool (*cpu_persistent_status)(CPUState *cpu);
     void (*set_pc)(CPUState *cpu, vaddr value);
     vaddr (*get_pc)(CPUState *cpu);
     int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 9b03b4292e..5cb60ca8bc 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -233,17 +233,6 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
     memory_region_add_subregion(as, base_addr, &state->ctrl_reg);
 }
 
-static bool should_remain_acpi_present(DeviceState *dev)
-{
-    CPUClass *k = CPU_GET_CLASS(dev);
-    /*
-     * A system may contain CPUs that are always present on one die, NUMA node,
-     * or socket, yet may be non-present on another simultaneously. Check from
-     * architecture specific code.
-     */
-    return k->cpu_persistent_status && k->cpu_persistent_status(CPU(dev));
-}
-
 static AcpiCpuStatus *get_cpu_status(CPUHotplugState *cpu_st, DeviceState *dev)
 {
     CPUClass *k = CPU_GET_CLASS(dev);
@@ -300,9 +289,7 @@ void acpi_cpu_unplug_cb(CPUHotplugState *cpu_st,
         return;
     }
 
-    if (!should_remain_acpi_present(dev)) {
-        cdev->cpu = NULL;
-    }
+    cdev->cpu = NULL;
 }
 
 static const VMStateDescription vmstate_cpuhp_sts = {
-- 
2.43.0


