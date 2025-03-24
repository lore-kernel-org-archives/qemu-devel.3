Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40219C36001
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 06:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twawn-0006D7-7S; Mon, 24 Mar 2025 02:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1twawf-00069Z-1k
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 02:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1twawd-0001XM-Gc
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 02:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742796352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C7MyYCAPaEDrf8uVX/HciWma8sx81bkCIrIDqKSU6IQ=;
 b=X+gFgsAvTHMPkSxG8DakTTBkk2xxVtOEA++b9+eB+7JKJOnBNHjn8YKA/NjxCvPohuhxS5
 EowAjqDyI3Kan1E9byzMqr4qIO0qm9v9gwM5R4Rl2/g8iEKn0OU6RYjhC2AgiOcij1rhfD
 5BL2h0RTkJ7Uej2hbjzi4GEMBz3SyYQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-pU3DAI62OV2uPj36DDl57w-1; Mon,
 24 Mar 2025 02:05:47 -0400
X-MC-Unique: pU3DAI62OV2uPj36DDl57w-1
X-Mimecast-MFC-AGG-ID: pU3DAI62OV2uPj36DDl57w_1742796346
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63A4619560BB; Mon, 24 Mar 2025 06:05:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D7F119560AD; Mon, 24 Mar 2025 06:05:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 360A621E66C4; Mon, 24 Mar 2025 07:05:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v7 1/2] hw/loongarch/virt: Fix cpuslot::cpu set at last
 in virt_cpu_plug()
In-Reply-To: <20250324030145.3037408-2-maobibo@loongson.cn> (Bibo Mao's
 message of "Mon, 24 Mar 2025 11:01:44 +0800")
References: <20250324030145.3037408-1-maobibo@loongson.cn>
 <20250324030145.3037408-2-maobibo@loongson.cn>
Date: Mon, 24 Mar 2025 07:05:41 +0100
Message-ID: <875xjzvu8a.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

Bibo Mao <maobibo@loongson.cn> writes:

> In function virt_cpu_plug(), Object cpuslot::cpu is set at last
> only when there is no any error, otherwise it is problematic that
> cpuslot::cpu is set in advance however it returns because of error.
>
> Fixes: ab9935d2991e (hw/loongarch/virt: Implement cpu plug interface)
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  hw/loongarch/virt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index e25864214f..504f8755a0 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -973,8 +973,6 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>      LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
>      Error *err = NULL;
>  
> -    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
> -    cpu_slot->cpu = CPU(dev);
>      if (lvms->ipi) {
>          hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev, &err);
>          if (err) {
> @@ -998,6 +996,8 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>          }
>      }
>  
> +    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
> +    cpu_slot->cpu = CPU(dev);
>      return;
>  }

Reviewed-by: Markus Armbruster <armbru@redhat.com>


