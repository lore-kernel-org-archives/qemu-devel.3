Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E5FC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 06:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv9Cg-0000x8-UF; Thu, 20 Mar 2025 02:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tv9CW-0000wA-1Y
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:16:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tv9CT-00048g-G4
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742451375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xxIUMfnHHPNfybrEf3xwaSwihvV7/rupdWM1rEhzzmo=;
 b=JNg4f4Se9khEk3qPRIaPfU6hDY7MyzUaWlbQWlqUL55qLpWH5plrR/g5sL/39o8UmOz7Ug
 +6F859/Epvn/PfLwO6T8w6ESy4h6TdHG6Fv2j41RWpVhB1nYmnZLv/kf/x7NWtdFImqbw0
 v42kLHEe2T3zvaGZg8fATlFRRirt6+I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-HloP13THPCKoqBoBAOSc3A-1; Thu,
 20 Mar 2025 02:16:11 -0400
X-MC-Unique: HloP13THPCKoqBoBAOSc3A-1
X-Mimecast-MFC-AGG-ID: HloP13THPCKoqBoBAOSc3A_1742451370
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02F09180AF4C; Thu, 20 Mar 2025 06:16:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DD9D1800370; Thu, 20 Mar 2025 06:16:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9564621E66C4; Thu, 20 Mar 2025 07:16:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 2/6] hw/loongarch/virt: Fix error handling in cpu plug
In-Reply-To: <20250320032158.1762751-3-maobibo@loongson.cn> (Bibo Mao's
 message of "Thu, 20 Mar 2025 11:21:54 +0800")
References: <20250320032158.1762751-1-maobibo@loongson.cn>
 <20250320032158.1762751-3-maobibo@loongson.cn>
Date: Thu, 20 Mar 2025 07:16:04 +0100
Message-ID: <875xk4i5wb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

> In function virt_cpu_plug(), it will send cpu plug message to interrupt
> controller extioi and ipi irqchip. If there is problem in this function,
> system should continue to run and keep state the same before cpu is
> added.
>
> Object cpuslot::cpu is set at last only when there is no any error.
> If there is, send cpu unplug message to extioi and ipi irqchip, and then
> return immediately.
>
> Fixes: ab9935d2991e (hw/loongarch/virt: Implement cpu plug interface)
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  hw/loongarch/virt.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index a5840ff968..5118f01e4b 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -981,8 +981,6 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>      LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
>      Error *err = NULL;
>  
> -    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
> -    cpu_slot->cpu = CPU(dev);
>      if (lvms->ipi) {
>          hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev, &err);
>          if (err) {
> @@ -995,6 +993,10 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>          hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), dev, &err);
>          if (err) {
>              error_propagate(errp, err);
> +            if (lvms->ipi) {
> +                /* Send unplug message to restore, discard error here */
> +                hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->ipi), dev, NULL);
> +            }
>              return;
>          }
>      }
> @@ -1003,9 +1005,20 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>          hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
>          if (err) {
>              error_propagate(errp, err);
> +            if (lvms->ipi) {
> +                hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->ipi), dev, NULL);
> +            }
> +
> +            if (lvms->extioi) {
> +                hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->extioi),
> +                                       dev, NULL);
> +            }
> +            return;
>          }
>      }
>  
> +    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
> +    cpu_slot->cpu = CPU(dev);
>      return;
>  }

Hmm.

You're right about the problem: virt_cpu_plug() neglects to revert
changes when it fails.

You're probably right to move the assignment to cpu_slot->cpu to the
end.  Anything you can delay until success is assured you don't have to
revert.  I say "probably" because the code that now runs before the
assignment might theoretically "see" the assignment, and I didn't
examine it to exclude that.

Where I have doubts is the code to revert changes.

The hotplug_handler_plug() error checkign suggests it can fail.

Can hotplug_handler_unplug() fail, too?  The error checking in
virt_cpu_unplug() right above suggests it can.

What happens if it fails in virt_cpu_plug()?


