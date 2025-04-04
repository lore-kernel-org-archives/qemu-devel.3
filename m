Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C32C3601E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 12:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0foy-0002Lh-Ef; Fri, 04 Apr 2025 08:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1u0fov-0002Jl-Qq
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:06:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1u0fos-00058L-Kp
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743768405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cliCMCG3vkwg2B6kUktVbTfqwyfmXDpitKOIuRcUsXo=;
 b=NOfq4y82GX3MKOhIXcfEghqXK8xxw+/QJZHfKXzqNtSWESO4lsicTAJs1OvJ3Hlv0f3kMW
 7NpNsifvogH/N2B1Guh035bLMTDr78Js0oNn5z2wTz1+nSXHa0KZ4e885WdxZKsh5sNdGR
 BUXA6wiaEXXFYSL0+yu4RCb18GFEOro=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-Kz150g_LNiS-uO6YQAcbVg-1; Fri, 04 Apr 2025 08:06:44 -0400
X-MC-Unique: Kz150g_LNiS-uO6YQAcbVg-1
X-Mimecast-MFC-AGG-ID: Kz150g_LNiS-uO6YQAcbVg_1743768403
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d007b2c79so15295305e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 05:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743768403; x=1744373203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cliCMCG3vkwg2B6kUktVbTfqwyfmXDpitKOIuRcUsXo=;
 b=wIfQmbeHk2B7TYgDjx2gS6HffcxHm31IzwAGAlofszX9tv7lugmWdUxC1i/eymqxdi
 zUB1kfV0Qy9AWI3kT9i25NnoLEoIpwyOfgAd3w25rMsBMOwIp7+y0yzc18k9hv6JguAK
 og9lFNsY1LfXDbigwPXgO/tVUtwvPbrbSLpPlT5dl0lQvCxEVFibzm/8UI5d/K3W+JJl
 8MPE1rtJ9HhRiRNTHU3I8jp7iRjXWcIQFUjKBuc75E5nV5vUwUDGZVp6Q4cyRN2l3lJU
 MJRdNQZDpRW7rEWQDlevKPQb8w5ysd+BX1NMF+rUZ1VZTHEg3f6BBOgeGpD4tYPTbmmq
 kbRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViAnTvf9NVT4oumPhPvgdKvUbTyY1VA+vy5tFw9+nhMbkLVEvGyyj73qw3+ZH157wDjTN5LivrBq9+@nongnu.org
X-Gm-Message-State: AOJu0YzoWT8VCOw71vzxCHG4rHk24JnBEg8yVEj9iY8aQeJCWMvrlQiu
 sOMCPXyLIPxPZk/NkBmHWVZdb6oH/o4GLlCF2VdmgliHiAQAF9wF4TvgvNIoKzMwI+6km5izC1D
 CWisTYpP02dztfF1gyqXr8IhIDN0PIJgW/cOJI1ZGwlRI6Er/8uz6
X-Gm-Gg: ASbGncuXhlcxkA5g4K/g1jPeKHmL4aw3dSD5vzTJ/34/5KvpyY6i4Z7gyW2tZHFyQ6k
 W42e1XqUfDWfDvZC1G2A8JvyFttIp3OMyikvhaWMmRP2Aqet5Q8PN7sDBYxISMlj1phfp19n3zT
 ELL5tyYTstb9J3ABM2/CtUESBX+HoT4b/CzWdHL11c/0Y+22boII4qz/cidVt6H3MRvUCxxfui6
 WubHaHF/uQWZ7nZ21glNj2pEZwuASlBIV3W3Fmr+sXgfX4TJy6ZazvB90n8JxXUsIvMWcdkXUYf
 /VseLIwFl/bBR9h2OjBATe/sfNFmURu5pPtw
X-Received: by 2002:a5d:59ac:0:b0:39a:c80b:8288 with SMTP id
 ffacd0b85a97d-39cb35b388emr2580054f8f.33.1743768402959; 
 Fri, 04 Apr 2025 05:06:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIp+uEMYnrz5LVbGRwvrigkv69ko8g7HNEfGTct995X+cDKuanG2XUUPzVi+s54y54qpidpA==
X-Received: by 2002:a5d:59ac:0:b0:39a:c80b:8288 with SMTP id
 ffacd0b85a97d-39cb35b388emr2580018f8f.33.1743768402411; 
 Fri, 04 Apr 2025 05:06:42 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34a8952sm44208695e9.10.2025.04.04.05.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 05:06:41 -0700 (PDT)
Date: Fri, 4 Apr 2025 14:06:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v6 2/6] hw/loongarch/virt: Fix error handling in cpu plug
Message-ID: <20250404140641.4e9493e8@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250321031259.2419842-3-maobibo@loongson.cn>
References: <20250321031259.2419842-1-maobibo@loongson.cn>
 <20250321031259.2419842-3-maobibo@loongson.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 21 Mar 2025 11:12:55 +0800
Bibo Mao <maobibo@loongson.cn> wrote:

> In function virt_cpu_plug(), it will send cpu plug message to interrupt
> controller extioi and ipi irqchip. If there is problem in this function,
> system should continue to run and keep state the same before cpu is
> added.


_plug is not supposed to fail ever,
hence we are using error_abort.

so I'd drop those chunks 

> Object cpuslot::cpu is set at last only when there is no any error.
> If there is, send cpu unplug message to extioi and ipi irqchip, and then
> return immediately.

it doesn't matter when it's set since you are already in _plug() handler.
both way are correct.

(I'd set it as the last if calls to chained handlers do not depend on it)

> 
> Fixes: ab9935d2991e (hw/loongarch/virt: Implement cpu plug interface)
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  hw/loongarch/virt.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index a5840ff968..8563967c8b 100644
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
> +                hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->ipi), dev,
> +                                       &error_abort);
> +            }
>              return;
>          }
>      }
> @@ -1003,9 +1005,21 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>          hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
>          if (err) {
>              error_propagate(errp, err);
> +            if (lvms->ipi) {
> +                hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->ipi), dev,
> +                                       &error_abort);
> +            }
> +
> +            if (lvms->extioi) {
> +                hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->extioi), dev,
> +                                       &error_abort);
> +            }
> +            return;
>          }
>      }
>  
> +    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
> +    cpu_slot->cpu = CPU(dev);
>      return;
>  }
>  


