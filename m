Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7D7C3601E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 11:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1l7J-00076J-79; Mon, 07 Apr 2025 07:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u1l7D-00074U-Ie
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 07:58:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u1l74-0004w2-L2
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 07:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744027073;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QLTqoNvl23SPEqwiQTNp78t1+GL63UOXJlzTp5U/2II=;
 b=NSDYP/OsL7kF20DB0ElZxCuQ9gcg5jxpBGDpmxJCFAVwPoCJ2InELZjRcyXtCyiO7a0mr3
 cQ3QqU/5w4NOBKqmPio9u1qI8tzW5Swq+iUNeKzXUJzT9pzlMNGpaQsfmwmIJXXZKZno5U
 X+NPHkVlvA2hMiogXl/+X9Z0TJFQL3o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-0N7WM4M5NfunQ3RPtsJYvQ-1; Mon, 07 Apr 2025 07:57:52 -0400
X-MC-Unique: 0N7WM4M5NfunQ3RPtsJYvQ-1
X-Mimecast-MFC-AGG-ID: 0N7WM4M5NfunQ3RPtsJYvQ_1744027071
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ced8c2eb7so32965025e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 04:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744027071; x=1744631871;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QLTqoNvl23SPEqwiQTNp78t1+GL63UOXJlzTp5U/2II=;
 b=Ls1Lp9TmpgBe1zwh16NxLcIecMd+4GZaXmyxt41DkIyuF+AEjfezibrwku7mporUrM
 Q93Uu+vdaCprD9PAz0ubimX83TWrLymr3wPITTwgFcWzOjlxCUhxrObYH9fn5Sgo5uNd
 dm+eQvFJCksCxA3m/BBv302c1iA4NDtKdm6LQJ2jeO10QJ/lWlnWCQqTVj3DRpZRuCBo
 E8P2guEnryknCOpgVihqaC7SNyErP7rTpSm++qhZ4AOeeEWpKbSecUvUEOH/S3hmfqji
 nE4bEYBH28AqspLJ8d7o+X6SzNZL2PtFKnt2vCennH4idBMzkXVUkdaYzHKKaPz3UW8l
 zw9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqGM9aPugVtfWRf3XpD40vvda2XtfnIyrHSX/ZdBT4Y0TKp166agx5Xcr/+MQjyQZPXAw70+MSGu9d@nongnu.org
X-Gm-Message-State: AOJu0Yxuln/p6IoxstVNtuNkmRWUxAYaaLPNvlLZ9zOCr3s2ttdOWGD8
 4aS8hQ7XkeinkpwX8zUMumOMGtHENV2jWTThgoz3ahXGb2i+dMXVU4qCT9qPGMKgQTqWGfFsooa
 v8/k13WsEodUAkM8bagRYFW4S6Ywgm8Qu/mwK3kPXx/oDHOlC/j8e
X-Gm-Gg: ASbGncue/8E0hmN8yH3ZDtlNP8Esnb/zoZD4SeCqVsjuTwxsLdD0oT8yswgS/QHLQXM
 C2cXD8LBLo/8a4LXKnE0qO8Cn6cuHuop5O8/olO0bNGGSoLsjQmotHyHiMYoA8VUdra3hsmX8KH
 HbmwpC6qoAyEftb30nM9GxJedNU3VqqgUXm5YFzFrrJvAzXqRl7TizCngWj/wj5CHkPSsDzDsAe
 Qs4khTzodpD6TIQs6lAZiuQQZT4PdZ7A7cVjsWSjYzXp9XwgqfTNLbrdvZZzWU4fFeHQkupJ50X
 wvYDwV1SgzFnj6Hpo3QL+HOWIlBkq+NxtKa95gN8Fi9A2ApDJrGhasRfpgNjRYI=
X-Received: by 2002:a5d:5f81:0:b0:391:456b:6ab7 with SMTP id
 ffacd0b85a97d-39d0de2d38emr8443501f8f.34.1744027071331; 
 Mon, 07 Apr 2025 04:57:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoX20it3skUe5zNT2TA7QGpq8PFKbr6dN7xw9zEgKcp35T+JsMbcumu5vxRmRGeWG3m8PacA==
X-Received: by 2002:a5d:5f81:0:b0:391:456b:6ab7 with SMTP id
 ffacd0b85a97d-39d0de2d38emr8443476f8f.34.1744027070887; 
 Mon, 07 Apr 2025 04:57:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec36699e0sm128003355e9.35.2025.04.07.04.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 04:57:50 -0700 (PDT)
Message-ID: <b3b8fe3b-1974-4098-8f44-ea197e85b36b@redhat.com>
Date: Mon, 7 Apr 2025 13:57:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v3 1/9] hw/arm/virt: Remove pointless
 VirtMachineState::tcg_its field
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>
References: <20250403204029.47958-1-philmd@linaro.org>
 <20250403204029.47958-2-philmd@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250403204029.47958-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Philippe,

On 4/3/25 10:40 PM, Philippe Mathieu-Daudé wrote:
> VirtMachineState::tcg_its has the negated logic value of
> VirtMachineClass::no_tcg_its. Directly use the latter,
> removing the former.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/hw/arm/virt.h |  1 -
>  hw/arm/virt.c         | 13 +++++--------
>  2 files changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index c8e94e6aedc..17c160429ea 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -150,7 +150,6 @@ struct VirtMachineState {
>      bool highmem_mmio;
>      bool highmem_redists;
>      bool its;
> -    bool tcg_its;
>      bool virt;
>      bool ras;
>      bool mte;
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a96452f17a4..177e9e0eadb 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -710,11 +710,12 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>  
>  static void create_its(VirtMachineState *vms)
>  {
> +    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>      const char *itsclass = its_class_name();
>      DeviceState *dev;
>  
>      if (!strcmp(itsclass, "arm-gicv3-its")) {
> -        if (!vms->tcg_its) {
> +        if (vmc->no_tcg_its) {
>              itsclass = NULL;
>          }
>      }
> @@ -831,7 +832,9 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
>                              redist_region_count);
>  
>          if (!kvm_irqchip_in_kernel()) {
> -            if (vms->tcg_its) {
> +            VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> +
> +            if (!vmc->no_tcg_its) {
>                  object_property_set_link(OBJECT(vms->gic), "sysmem",
>                                           OBJECT(mem), &error_fatal);
>                  qdev_prop_set_bit(vms->gic, "has-lpi", true);
> @@ -3357,12 +3360,6 @@ static void virt_instance_init(Object *obj)
>      } else {
>          /* Default allows ITS instantiation */
>          vms->its = true;
> -
> -        if (vmc->no_tcg_its) {
> -            vms->tcg_its = false;
> -        } else {
> -            vms->tcg_its = true;
> -        }
>      }
>  
>      /* Default disallows iommu instantiation */


