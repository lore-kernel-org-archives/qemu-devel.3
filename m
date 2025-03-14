Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBFEC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 09:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt14j-0007IW-TQ; Fri, 14 Mar 2025 05:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt14f-0007GO-Bl
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 05:11:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt14d-0002lY-9k
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 05:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741943480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kNGU6arLhw0u1FOzSbuAlNahpdDUX15gFlRyhqwPuzU=;
 b=bUenf+/P70iGY4ZVl1wZ7pm/4DWeXbq+k/Z9pmDqycCvAl00c2ECuEmEdr+qOCKf1oXxaX
 R27kXX4QKc2BK8DmyFudUU7TeOFoJwGswxKQ4L6yFP7URl/INibPDnaK5d1S4yL2JZfBX/
 osA/WWoh+QsTnY/dHiSJK5dcN3n45Hg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-kB_N-zldNNK5342sQo102A-1; Fri,
 14 Mar 2025 05:11:18 -0400
X-MC-Unique: kB_N-zldNNK5342sQo102A-1
X-Mimecast-MFC-AGG-ID: kB_N-zldNNK5342sQo102A_1741943477
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33FAF180AF4D; Fri, 14 Mar 2025 09:11:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 953FD1955BCB; Fri, 14 Mar 2025 09:11:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D0E1321E675F; Fri, 14 Mar 2025 10:11:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/3] hw/loongarch/virt: Remove unnecessary NULL
 pointer checking
In-Reply-To: <20250314084201.4182054-3-maobibo@loongson.cn> (Bibo Mao's
 message of "Fri, 14 Mar 2025 16:42:00 +0800")
References: <20250314084201.4182054-1-maobibo@loongson.cn>
 <20250314084201.4182054-3-maobibo@loongson.cn>
Date: Fri, 14 Mar 2025 10:11:10 +0100
Message-ID: <87plikrn81.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Bibo Mao <maobibo@loongson.cn> writes:

> There is NULL pointer checking function error_propagate() already,
> it is not necessary to add checking for function parameter. Here remove
> NULL pointer checking with function parameter.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  hw/loongarch/virt.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index a5840ff968..d82676d316 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -868,21 +868,24 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>              error_setg(&err,
>                         "Invalid thread-id %u specified, must be in range 1:%u",
>                         cpu->thread_id, ms->smp.threads - 1);
> -            goto out;
> +            error_propagate(errp, err);
> +            return;

Make this

               error_setg(&err, ...);
               return;

>          }
>  
>          if ((cpu->core_id < 0) || (cpu->core_id >= ms->smp.cores)) {
>              error_setg(&err,
>                         "Invalid core-id %u specified, must be in range 1:%u",
>                         cpu->core_id, ms->smp.cores - 1);
> -            goto out;
> +            error_propagate(errp, err);
> +            return;

Likewise.

>          }
>  
>          if ((cpu->socket_id < 0) || (cpu->socket_id >= ms->smp.sockets)) {
>              error_setg(&err,
>                         "Invalid socket-id %u specified, must be in range 1:%u",
>                         cpu->socket_id, ms->smp.sockets - 1);
> -            goto out;
> +            error_propagate(errp, err);
> +            return;

Likewise.

>          }
>  
>          topo.socket_id = cpu->socket_id;
> @@ -895,7 +898,8 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>                         "cpu(id%d=%d:%d:%d) with arch-id %" PRIu64 " exists",
>                         cs->cpu_index, cpu->socket_id, cpu->core_id,
>                         cpu->thread_id, cpu_slot->arch_id);
> -            goto out;
> +            error_propagate(errp, err);
> +            return;

Likewise.

>          }
>      } else {
>          /* For cold-add cpu, find empty cpu slot */
> @@ -912,10 +916,6 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      cpu->phy_id = cpu_slot->arch_id;
>      cs->cpu_index = cpu_slot - ms->possible_cpus->cpus;
>      numa_cpu_pre_plug(cpu_slot, dev, &err);

You need to pass errp instead of &err now.

> -out:
> -    if (err) {
> -        error_propagate(errp, err);
> -    }
>  }
>  
>  static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
> @@ -935,9 +935,7 @@ static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
>      }
>  
>      hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -    }
> +    error_propagate(errp, err);
>  }

Correct, but I'd recomment to go one step further:

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

>  
>  static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
> @@ -1001,9 +999,8 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
       cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
       cpu_slot->cpu = CPU(dev);
       if (lvms->ipi) {
           hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev, &err);
           if (err) {
               error_propagate(errp, err);
               return;
           }
       }

       if (lvms->extioi) {
           hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), dev, &err);
           if (err) {
               error_propagate(errp, err);
               return;
           }
       }
>  
>      if (lvms->acpi_ged) {
>          hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
> -        if (err) {
> -            error_propagate(errp, err);
> -        }
> +        error_propagate(errp, err);
> +        return;
>      }
>  
>      return;

Better make this work exactly like the other checks above, and drop the
final return, which serves no purpose:

           if (err) {
               error_propagate(errp, err);
               return;
           }
       }
   }


