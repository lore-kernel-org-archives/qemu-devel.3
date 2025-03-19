Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9849CC35FF1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 06:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tunG9-0002EK-6p; Wed, 19 Mar 2025 02:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tunG7-0002E7-Nc
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 02:50:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tunG5-0007uu-2r
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 02:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742367031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cAYG9zY2LBGvLrbCZZO1l00joI+QSfROI0w3FWaht+g=;
 b=hDXwvgYxTtmj8rvYjtDlUoz+oHz6muwBp7CrfSn1nVLOvX+4gy+cTkfuS/he3wY2Nz+UQ5
 ysvlSHeulOXfP+qdnRTWSXlPxY2keYQzfiG1BeM2BRyaqkxwVRLg/pkvFeuPstWD3nI+GP
 rsVoYNqImenTmmTlNGQ4xZ4Qgus2+Tc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-LTsdUfkvMcGeuPLM2oVjWg-1; Wed,
 19 Mar 2025 02:50:24 -0400
X-MC-Unique: LTsdUfkvMcGeuPLM2oVjWg-1
X-Mimecast-MFC-AGG-ID: LTsdUfkvMcGeuPLM2oVjWg_1742367024
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B90619560B0; Wed, 19 Mar 2025 06:50:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40FC3180174E; Wed, 19 Mar 2025 06:50:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 302C321E66C5; Wed, 19 Mar 2025 07:50:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 2/4] hw/loongarch/virt: Remove unnecessary NULL pointer
In-Reply-To: <20250319020847.1511759-3-maobibo@loongson.cn> (Bibo Mao's
 message of "Wed, 19 Mar 2025 10:08:45 +0800")
References: <20250319020847.1511759-1-maobibo@loongson.cn>
 <20250319020847.1511759-3-maobibo@loongson.cn>
Date: Wed, 19 Mar 2025 07:50:17 +0100
Message-ID: <87v7s5345y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

I believe the title "Remove unnecessary NULL pointer" and this paragraph
are remnants of your initial version, which transformed

    if (err) {
        error_propagate(errp, err);
    }

to just

    error_propagate(errp, err);

However, the patch doesn't do that anymore.

I think you should drop the paragraph, and replace the title.

I apologize for not noticing this earlier.

> Since function will return directly when there is error report, this
> patch removes combination about error_setg() and error_propagate(),
> error_setg() with dest error object is used directly such as:
>
>   error_setg(err);                 -------->      error_setg(errp);
>   error_propagate(errp, err);                     return;
>   return;

Yes, much of the patch does this or equivalent transformations.
However, there's more; see [*] below.

> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  hw/loongarch/virt.c | 33 ++++++++++++---------------------
>  1 file changed, 12 insertions(+), 21 deletions(-)
>
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index a5840ff968..a9fab39dd8 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -859,30 +859,29 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>      CPUState *cs = CPU(dev);
>      CPUArchId *cpu_slot;
> -    Error *err = NULL;
>      LoongArchCPUTopo topo;
>      int arch_id;
>  
>      if (lvms->acpi_ged) {
>          if ((cpu->thread_id < 0) || (cpu->thread_id >= ms->smp.threads)) {
> -            error_setg(&err,
> +            error_setg(errp,
>                         "Invalid thread-id %u specified, must be in range 1:%u",
>                         cpu->thread_id, ms->smp.threads - 1);
> -            goto out;
> +            return;
>          }
>  
>          if ((cpu->core_id < 0) || (cpu->core_id >= ms->smp.cores)) {
> -            error_setg(&err,
> +            error_setg(errp,
>                         "Invalid core-id %u specified, must be in range 1:%u",
>                         cpu->core_id, ms->smp.cores - 1);
> -            goto out;
> +            return;
>          }
>  
>          if ((cpu->socket_id < 0) || (cpu->socket_id >= ms->smp.sockets)) {
> -            error_setg(&err,
> +            error_setg(errp,
>                         "Invalid socket-id %u specified, must be in range 1:%u",
>                         cpu->socket_id, ms->smp.sockets - 1);
> -            goto out;
> +            return;
>          }
>  
>          topo.socket_id = cpu->socket_id;
> @@ -891,11 +890,11 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>          arch_id =  virt_get_arch_id_from_topo(ms, &topo);
>          cpu_slot = virt_find_cpu_slot(ms, arch_id);
>          if (CPU(cpu_slot->cpu)) {
> -            error_setg(&err,
> +            error_setg(errp,
>                         "cpu(id%d=%d:%d:%d) with arch-id %" PRIu64 " exists",
>                         cs->cpu_index, cpu->socket_id, cpu->core_id,
>                         cpu->thread_id, cpu_slot->arch_id);
> -            goto out;
> +            return;
>          }
>      } else {
>          /* For cold-add cpu, find empty cpu slot */
> @@ -911,33 +910,24 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      cpu->env.address_space_iocsr = &lvms->as_iocsr;
>      cpu->phy_id = cpu_slot->arch_id;
>      cs->cpu_index = cpu_slot - ms->possible_cpus->cpus;
> -    numa_cpu_pre_plug(cpu_slot, dev, &err);
> -out:
> -    if (err) {
> -        error_propagate(errp, err);
> -    }
> +    numa_cpu_pre_plug(cpu_slot, dev, errp);
>  }
>  
>  static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
>                                      DeviceState *dev, Error **errp)
>  {
>      LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
> -    Error *err = NULL;
>      LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>      CPUState *cs = CPU(dev);
>  
>      if (cs->cpu_index == 0) {
> -        error_setg(&err, "hot-unplug of boot cpu(id%d=%d:%d:%d) not supported",
> +        error_setg(errp, "hot-unplug of boot cpu(id%d=%d:%d:%d) not supported",
>                     cs->cpu_index, cpu->socket_id,
>                     cpu->core_id, cpu->thread_id);
> -        error_propagate(errp, err);
>          return;
>      }
>  
> -    hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -    }
> +    hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev, errp);
>  }
>  
>  static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
> @@ -1003,6 +993,7 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>          hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
>          if (err) {
>              error_propagate(errp, err);
> +            return;
>          }
>      }

       cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
       cpu_slot->cpu = NULL;
       return;
   }

[*] This is something else.  Before the patch, we clear cpu_slot->cpu
evem when the last hotplug_handler() fails.  Afterwards, we don't.
Looks like a bug fix to me.  Either mention the fix in the commit
message, or split it off into a separate patch.  I'd do the latter.


