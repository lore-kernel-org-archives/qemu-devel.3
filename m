Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169A2C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 10:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfsa-0005wk-PC; Thu, 13 Mar 2025 06:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsfsC-0005rr-Kx
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:33:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsfs7-00041s-BJ
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741861978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KWTtAl7Cger4pI6b0NSAPM3zByA8TZhh+5aVq9JQaP8=;
 b=GDFDm+dlSSMlsC/JG8zHMZQCxdJMuyIgnJfMR+1mDLFfqrSZzrO5Kfb/1sZ/Y+y8PCLy5B
 jrjDypKg2g3FUtW6HrjIEA0TZtaIQkupYiL3Uu5c9xb2w4Q859Weln8SV6qthhvHV1E+Sf
 kHi4nm1sJd7KxfgffAPdK95Cc7vxKS8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-ZUySDBaNN3CS1kTp_BU6Fg-1; Thu,
 13 Mar 2025 06:32:57 -0400
X-MC-Unique: ZUySDBaNN3CS1kTp_BU6Fg-1
X-Mimecast-MFC-AGG-ID: ZUySDBaNN3CS1kTp_BU6Fg_1741861976
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E651E19560B7; Thu, 13 Mar 2025 10:32:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BAEA19373D7; Thu, 13 Mar 2025 10:32:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 799B221E66C4; Thu, 13 Mar 2025 11:32:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/3] hw/loongarch/virt: Remove unnecessary NULL pointer
 checking
In-Reply-To: <20250313091350.3770394-3-maobibo@loongson.cn> (Bibo Mao's
 message of "Thu, 13 Mar 2025 17:13:49 +0800")
References: <20250313091350.3770394-1-maobibo@loongson.cn>
 <20250313091350.3770394-3-maobibo@loongson.cn>
Date: Thu, 13 Mar 2025 11:32:50 +0100
Message-ID: <875xkdb4q5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Bibo Mao <maobibo@loongson.cn> writes:

> There is NULL pointer checking function error_propagate() already,
> it is not necessary to add checking for function parameter. Here remove
> NULL pointer checking with function parameter.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  hw/loongarch/virt.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index a5840ff968..ab951fc642 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -913,9 +913,7 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      cs->cpu_index = cpu_slot - ms->possible_cpus->cpus;
>      numa_cpu_pre_plug(cpu_slot, dev, &err);
>  out:
> -    if (err) {
> -        error_propagate(errp, err);
> -    }
> +    error_propagate(errp, err);
>  }
>  
>  static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
> @@ -935,9 +933,7 @@ static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
>      }
>  
>      hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -    }
> +    error_propagate(errp, err);
>  }

This looks correct.  But I believe we can eliminate error propagation
here.  Untested patch appended.

>  
>  static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
> @@ -1001,9 +997,7 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>  
>      if (lvms->acpi_ged) {
>          hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
> -        if (err) {
> -            error_propagate(errp, err);
> -        }
> +        error_propagate(errp, err);
>      }
>  
>      return;

Here, I'd recommend

       if (lvms->acpi_ged) {
           hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
           if (err) {
               error_propagate(errp, err);
  +            return;
           }

because it makes future screwups harder.


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


