Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF90C35FF1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 06:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tumda-00055Y-IH; Wed, 19 Mar 2025 02:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tumcp-0004sY-5x
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 02:10:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tumcn-0000j9-EX
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 02:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742364595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CXEdEbumAbHfS8TWZj+a3mb09MkRGnYctUYwhUthSvY=;
 b=FpnZoJ5aSG11B3uQjJ4cdJtTAwzJQJTmaggZlzOUE9jEzoBa4I94M18LZalWC+MGryBQ2H
 jQIAbXkpBL+QRvSwbrNvDR0yvYWVQJ4RcJ2HHkK5/xHkQNR47oDJwpK9h7ikGwga+7VnKl
 +Sz6dC4H1ASa6ClzXf+lHT/DvfSVsqQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-5I_qgUMFP_SVARk4cXgcoA-1; Wed,
 19 Mar 2025 02:09:51 -0400
X-MC-Unique: 5I_qgUMFP_SVARk4cXgcoA-1
X-Mimecast-MFC-AGG-ID: 5I_qgUMFP_SVARk4cXgcoA_1742364590
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6A1518007E1; Wed, 19 Mar 2025 06:09:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D254180175E; Wed, 19 Mar 2025 06:09:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6C48F21E66C5; Wed, 19 Mar 2025 07:09:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 4/4] target/loongarch: Set dest error with
 error_abort in virt_cpu_irq_init
In-Reply-To: <20250319020847.1511759-5-maobibo@loongson.cn> (Bibo Mao's
 message of "Wed, 19 Mar 2025 10:08:47 +0800")
References: <20250319020847.1511759-1-maobibo@loongson.cn>
 <20250319020847.1511759-5-maobibo@loongson.cn>
Date: Wed, 19 Mar 2025 07:09:42 +0100
Message-ID: <877c4l4km1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

> In function virt_cpu_irq_init(), there is notification with ipi and extioi
> interrupt controller for cpu creation. Local variable with error type is
> used, however there is no check with its return value.

Good catch.

When the first call fails, we pass non-null @err to the second call,
which is wrong.  If that one also fails, it'll likely trip
error_setv()'s assertion.

> Here set dest error object with error_abort, rather than local variable, so
> application will abort to run if there is error.

Why is failure impossible there?

If failure is impossible, the code before the patch is harmlessly wrong.

If failure is possible, the code before the patch has a crash bug, and
the patch makes it crash harder, i.e. when either call fails instead of
when both fail.

> Fixes: 50ebc3fc47fe (hw/intc/loongarch_ipi: Notify ipi object when cpu is plugged)
> Fixes: 087a23a87c57 (hw/intc/loongarch_extioi: Use cpu plug notification)
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  hw/loongarch/virt.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index a9fab39dd8..f10a4704ab 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -327,7 +327,6 @@ static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
>      const CPUArchIdList *possible_cpus;
>      CPUState *cs;
> -    Error *err = NULL;
>  
>      /* cpu nodes */
>      possible_cpus = mc->possible_cpu_arch_ids(ms);
> @@ -337,8 +336,10 @@ static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
>              continue;
>          }
>  
> -        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), DEVICE(cs), &err);
> -        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), DEVICE(cs), &err);
> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), DEVICE(cs),
> +                             &error_abort);
> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), DEVICE(cs),
> +                             &error_abort);
>      }
>  }


