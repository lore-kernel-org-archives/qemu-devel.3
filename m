Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159D7C36001
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 14:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvdjm-0001kF-Tc; Fri, 21 Mar 2025 10:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvdjQ-0001TL-1M
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvdjM-0006wG-On
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742568735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=db9wHzRcobb29GKZw+mNtoerBkhoPENHgzYniQYfu2U=;
 b=eEBVBOpQBu1WqeqdDeDOeZ1L7eXLW4ed7XrO7MVBc/cVX3yRbk0evHBLbIkZfRDHg5/W7S
 y3/7oGOz4CMVzUq/0tZWrHt+uPN/sa8gdva5f00vcLYCYWunA7WHpo/xX0NCJxsDMVMtr/
 PgNe5L+qkpM97X6aHhOcI5QVihEn2P4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-D2s88yHRMA-0N8cAC1mcGw-1; Fri,
 21 Mar 2025 10:52:11 -0400
X-MC-Unique: D2s88yHRMA-0N8cAC1mcGw-1
X-Mimecast-MFC-AGG-ID: D2s88yHRMA-0N8cAC1mcGw_1742568731
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE4621801A00; Fri, 21 Mar 2025 14:52:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 437451800946; Fri, 21 Mar 2025 14:52:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D910B21E65D0; Fri, 21 Mar 2025 15:51:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 6/8] hw/loongarch/virt: Eliminate error_propagate()
Date: Fri, 21 Mar 2025 15:51:56 +0100
Message-ID: <20250321145158.3896812-7-armbru@redhat.com>
In-Reply-To: <20250321145158.3896812-1-armbru@redhat.com>
References: <20250321145158.3896812-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Bibo Mao <maobibo@loongson.cn>

When there is an error, it is put into a local variable and then
propagated to somewhere else. Instead the error can be set right
away, error propagation can be removed.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20250320032158.1762751-5-maobibo@loongson.cn>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/loongarch/virt.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index a5840ff968..4674bd9163 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -859,30 +859,29 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
     LoongArchCPU *cpu = LOONGARCH_CPU(dev);
     CPUState *cs = CPU(dev);
     CPUArchId *cpu_slot;
-    Error *err = NULL;
     LoongArchCPUTopo topo;
     int arch_id;
 
     if (lvms->acpi_ged) {
         if ((cpu->thread_id < 0) || (cpu->thread_id >= ms->smp.threads)) {
-            error_setg(&err,
+            error_setg(errp,
                        "Invalid thread-id %u specified, must be in range 1:%u",
                        cpu->thread_id, ms->smp.threads - 1);
-            goto out;
+            return;
         }
 
         if ((cpu->core_id < 0) || (cpu->core_id >= ms->smp.cores)) {
-            error_setg(&err,
+            error_setg(errp,
                        "Invalid core-id %u specified, must be in range 1:%u",
                        cpu->core_id, ms->smp.cores - 1);
-            goto out;
+            return;
         }
 
         if ((cpu->socket_id < 0) || (cpu->socket_id >= ms->smp.sockets)) {
-            error_setg(&err,
+            error_setg(errp,
                        "Invalid socket-id %u specified, must be in range 1:%u",
                        cpu->socket_id, ms->smp.sockets - 1);
-            goto out;
+            return;
         }
 
         topo.socket_id = cpu->socket_id;
@@ -891,11 +890,11 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
         arch_id =  virt_get_arch_id_from_topo(ms, &topo);
         cpu_slot = virt_find_cpu_slot(ms, arch_id);
         if (CPU(cpu_slot->cpu)) {
-            error_setg(&err,
+            error_setg(errp,
                        "cpu(id%d=%d:%d:%d) with arch-id %" PRIu64 " exists",
                        cs->cpu_index, cpu->socket_id, cpu->core_id,
                        cpu->thread_id, cpu_slot->arch_id);
-            goto out;
+            return;
         }
     } else {
         /* For cold-add cpu, find empty cpu slot */
@@ -911,33 +910,24 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
     cpu->env.address_space_iocsr = &lvms->as_iocsr;
     cpu->phy_id = cpu_slot->arch_id;
     cs->cpu_index = cpu_slot - ms->possible_cpus->cpus;
-    numa_cpu_pre_plug(cpu_slot, dev, &err);
-out:
-    if (err) {
-        error_propagate(errp, err);
-    }
+    numa_cpu_pre_plug(cpu_slot, dev, errp);
 }
 
 static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
                                     DeviceState *dev, Error **errp)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
-    Error *err = NULL;
     LoongArchCPU *cpu = LOONGARCH_CPU(dev);
     CPUState *cs = CPU(dev);
 
     if (cs->cpu_index == 0) {
-        error_setg(&err, "hot-unplug of boot cpu(id%d=%d:%d:%d) not supported",
+        error_setg(errp, "hot-unplug of boot cpu(id%d=%d:%d:%d) not supported",
                    cs->cpu_index, cpu->socket_id,
                    cpu->core_id, cpu->thread_id);
-        error_propagate(errp, err);
         return;
     }
 
-    hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
-    if (err) {
-        error_propagate(errp, err);
-    }
+    hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev, errp);
 }
 
 static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
-- 
2.48.1


