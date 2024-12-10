Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8997CE77182
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL3HI-0003gt-W7; Tue, 10 Dec 2024 11:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tL3HG-0003ei-Ed
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:40:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tL3HE-00029L-QW
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733848800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F+Pfc7rn2iLs0BkcvqcbQ1BgYvYFW9KRmaWnTbFjiyE=;
 b=YhAI4WtU0S8bDqlFpnqHwuWZpdLos+QmmpY8D6hJ0whVa7mP7ovCK+5lsRMFLXz72kMEOJ
 cKzzOniYhf2OHUK2IgAkTAag23DEwpe9aBFTrUAs0CgM13pPOgMEYYUrJK265g7euWQzGr
 7Lns60oDxw5M7vLH5bac4TFMAbQl80M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-dqb6VGQEPsaTppXpV1CHlA-1; Tue,
 10 Dec 2024 11:39:57 -0500
X-MC-Unique: dqb6VGQEPsaTppXpV1CHlA-1
X-Mimecast-MFC-AGG-ID: dqb6VGQEPsaTppXpV1CHlA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4F071954B3B; Tue, 10 Dec 2024 16:39:56 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 759B2300019F; Tue, 10 Dec 2024 16:39:53 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, eric.mackay@oracle.com,
 anisinha@redhat.com
Subject: [PATCH 2/3] cpuhp: make sure that remove events are handled within
 the same SCI
Date: Tue, 10 Dec 2024 17:39:44 +0100
Message-ID: <20241210163945.3422623-3-imammedo@redhat.com>
In-Reply-To: <20241210163945.3422623-1-imammedo@redhat.com>
References: <20241210163945.3422623-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

CPU_SCAN_METHOD was processing insert events first and only if insert event was
not present then it would check remove event.

Normally it's not an issue as it doesn't make much sense tho hotplug and
immediately unplug it. In this corner case, which can be reproduced with:

   qemu -smp 1,maxcpus=2 -cpu host -monitor stdio \
        -drive if=pflash,format=raw,readonly,file=edk2-x86_64-code.fd

   * boot till GRUB prompt and pause guest (either via monitor or stop GRUB
     from automatic boot)
   * at monitor prompt add CPU:
         device_add host-x86_64-cpu,socket-id=0,core-id=1,thread-id=0,id=foo
   * let guest OS boot completely, and unplug CPU from monitor prompt:
         device_del foo
     which triggers GPE event that leads to CPU_SCAN_METHOD on guest side

as result of above cpu 'foo' will not be hotunplugged, since QEMU sees
insert event and ignores remove event (leaving it in pending state) for
the GPE event.

Any follow up CPU hotplug/unplug action from QEMU side will handle
previously ignored event, so as workaround user can repeat device_del.

Fix this corner-case by queuing remove events independently from insert
events, aka the same way as we do with insert events. And then go over remove
queue to send eject notify events to OSPM within the same GPE event.

PS:
Process remove queue after the cpu add queue has been processed 1st
to ensure that OSPM gets hotadd evets after hotremove ones.

PS2:
Case where it's still borken happens when guest OS is Linux and
device_del happens before guest OS initializes ACPI subsystem.
Culprit in this case though is the guest kernel, which mangles GPE.sts
(by clearing them up) and thus pending SCI turns to NOP leaving
insert/remove events in pending state.
That is the guest bug and should be fixed there.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reported-by: Eric Mackay <eric.mackay@oracle.com>
---
 hw/acpi/cpu.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 5cb60ca8bc..f6a5680b4d 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -327,6 +327,7 @@ const VMStateDescription vmstate_cpu_hotplug = {
 #define CPU_EJECT_METHOD  "CEJ0"
 #define CPU_OST_METHOD    "COST"
 #define CPU_ADDED_LIST    "CNEW"
+#define CPU_EJ_LIST       "CEJL"
 
 #define CPU_ENABLED       "CPEN"
 #define CPU_SELECTOR      "CSEL"
@@ -488,7 +489,6 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         method = aml_method(CPU_SCAN_METHOD, 0, AML_SERIALIZED);
         {
             const uint8_t max_cpus_per_pass = 255;
-            Aml *else_ctx;
             Aml *while_ctx, *while_ctx2;
             Aml *has_event = aml_local(0);
             Aml *dev_chk = aml_int(1);
@@ -499,6 +499,8 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
             Aml *uid = aml_local(3);
             Aml *has_job = aml_local(4);
             Aml *new_cpus = aml_name(CPU_ADDED_LIST);
+            Aml *ej_cpus = aml_name(CPU_EJ_LIST);
+            Aml *num_ej_cpus = aml_local(5);
 
             aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
 
@@ -513,6 +515,8 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
              */
             aml_append(method, aml_name_decl(CPU_ADDED_LIST,
                                              aml_package(max_cpus_per_pass)));
+            aml_append(method, aml_name_decl(CPU_EJ_LIST,
+                                             aml_package(max_cpus_per_pass)));
 
             aml_append(method, aml_store(zero, uid));
             aml_append(method, aml_store(one, has_job));
@@ -527,6 +531,7 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
 
                 aml_append(while_ctx2, aml_store(one, has_event));
                 aml_append(while_ctx2, aml_store(zero, num_added_cpus));
+                aml_append(while_ctx2, aml_store(zero, num_ej_cpus));
 
                 /*
                  * Scan CPUs, till there are CPUs with events or
@@ -559,8 +564,10 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
                       * if CPU_ADDED_LIST is full, exit inner loop and process
                       * collected CPUs
                       */
-                     ifctx = aml_if(
-                         aml_equal(num_added_cpus, aml_int(max_cpus_per_pass)));
+                     ifctx = aml_if(aml_lor(
+                         aml_equal(num_added_cpus, aml_int(max_cpus_per_pass)),
+                         aml_equal(num_ej_cpus, aml_int(max_cpus_per_pass))
+                         ));
                      {
                          aml_append(ifctx, aml_store(one, has_job));
                          aml_append(ifctx, aml_break());
@@ -577,16 +584,16 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
                          aml_append(ifctx, aml_store(one, has_event));
                      }
                      aml_append(while_ctx, ifctx);
-                     else_ctx = aml_else();
+
                      ifctx = aml_if(aml_equal(rm_evt, one));
                      {
-                         aml_append(ifctx,
-                             aml_call2(CPU_NOTIFY_METHOD, uid, eject_req));
-                         aml_append(ifctx, aml_store(one, rm_evt));
+                         /* cache to be removed CPUs to Notify later */
+                         aml_append(ifctx, aml_store(uid,
+                             aml_index(ej_cpus, num_ej_cpus)));
+                         aml_append(ifctx, aml_increment(num_ej_cpus));
                          aml_append(ifctx, aml_store(one, has_event));
                      }
-                     aml_append(else_ctx, ifctx);
-                     aml_append(while_ctx, else_ctx);
+                     aml_append(while_ctx, ifctx);
                      aml_append(while_ctx, aml_increment(uid));
                 }
                 aml_append(while_ctx2, while_ctx);
@@ -620,6 +627,24 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
                     aml_append(while_ctx, aml_increment(cpu_idx));
                 }
                 aml_append(while_ctx2, while_ctx);
+
+                /*
+                 * Notify OSPM about to be removed CPUs and clear remove flag
+                 */
+                aml_append(while_ctx2, aml_store(zero, cpu_idx));
+                while_ctx = aml_while(aml_lless(cpu_idx, num_ej_cpus));
+                {
+                    aml_append(while_ctx,
+                        aml_store(aml_derefof(aml_index(ej_cpus, cpu_idx)),
+                                  uid));
+                    aml_append(while_ctx,
+                        aml_call2(CPU_NOTIFY_METHOD, uid, eject_req));
+                    aml_append(while_ctx, aml_store(uid, cpu_selector));
+                    aml_append(while_ctx, aml_store(one, rm_evt));
+                    aml_append(while_ctx, aml_increment(cpu_idx));
+                }
+                aml_append(while_ctx2, while_ctx);
+
                 /*
                  * If another batch is needed, then it will resume scanning
                  * exactly at -- and not after -- the last CPU that's currently
-- 
2.43.0


