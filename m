Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B7DC35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 06:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvWAJ-0005xH-7f; Fri, 21 Mar 2025 02:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvWAH-0005wl-7M
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 02:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvWAF-00067j-HO
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 02:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742539649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UX93a6LydHJg68wZ+2Yiv6aOAz3lPbFCuSwXV8rehu8=;
 b=NYNwzQTWXA/KfTwblzzNFDKEXO3zNwpN43Y38ObbbEK7RmfGngK5pKplodHc2Y5JlLfkOy
 Y5HKy+Rf5+l+j/1ggZljkYPWnpO6HawBey2/ZxdlGAKRTa5UI9Zc0exvDMtIuPW5o6QFb7
 IGSEQMSo6ZwFNqyOF1N7bLo999hdJaU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392--Nrn-csCMoOFyYqbnfqAKA-1; Fri,
 21 Mar 2025 02:47:25 -0400
X-MC-Unique: -Nrn-csCMoOFyYqbnfqAKA-1
X-Mimecast-MFC-AGG-ID: -Nrn-csCMoOFyYqbnfqAKA_1742539644
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FB311944F0A; Fri, 21 Mar 2025 06:47:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C38021828A93; Fri, 21 Mar 2025 06:47:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0BD3721E66C4; Fri, 21 Mar 2025 07:47:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 3/6] hw/loongarch/virt: Fix error handling in cpu unplug
In-Reply-To: <20250321031259.2419842-4-maobibo@loongson.cn> (Bibo Mao's
 message of "Fri, 21 Mar 2025 11:12:56 +0800")
References: <20250321031259.2419842-1-maobibo@loongson.cn>
 <20250321031259.2419842-4-maobibo@loongson.cn>
Date: Fri, 21 Mar 2025 07:47:18 +0100
Message-ID: <87ecyq98y1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

> In function virt_cpu_unplug(), it will send cpu unplug message to
> interrupt controller extioi and ipi irqchip. If there is problem in
> this function, system should continue to run and keep state the same
> before cpu is removed.
>
> If error happends in cpu unplug stage, send cpu plug message to extioi
> and ipi irqchip to restore to previous stage, and then return immediately.
>
> Fixes: 2cd6857f6f5b (hw/loongarch/virt: Implement cpu unplug interface)
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  hw/loongarch/virt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 8563967c8b..503362a69e 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -958,6 +958,8 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
>      hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->extioi), dev, &err);
>      if (err) {
>          error_propagate(errp, err);
> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev,
> +                             &error_abort);
>          return;
>      }
>  
> @@ -965,6 +967,10 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
>      hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
>      if (err) {
>          error_propagate(errp, err);
> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev,
> +                             &error_abort);
> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), dev,
> +                             &error_abort);
>          return;
>      }

virt_cpu_unplug() calls hotplug_handler_unplug() three times to notify
ipi, extioi, and acpi_get.  If any notification fails, virt_cpu_unplug()
calls hotplug_handler_plug() to "un-notify" the preceeding ones, if any.
This must not fail.

virt_cpu_plug() does it the other way round (see previous patch).

So, hotplug_handler_plug() must not fail in virt_cpu_unplug(), yet we
check for it to fail in virt_cpu_plug().

Can it really fail in virt_cpu_plug()?

If yes, why can't it fail in virt_cpu_unplug()?

Same questions for hotplug_handler_unplug().


