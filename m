Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6189C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 14:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCKKs-0006fz-7P; Wed, 29 May 2024 10:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKKq-0006ej-NN
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKKo-0001Lb-W4
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716993081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GSh6WNvJJzWDKUE/EwLvy2tmXvoSaK77mg2CiJsoQHE=;
 b=GQfROfl02lQFfnVMlrKOir+Hh6LXjWU1QPb0Liq/gcHof2srf8fG0YMltjPRkV2TXOBWQr
 cOsog9MMtwCmW1+h5C4gkgH5kf1W9XA5mnMHBsrT3W9zzajH6Qjhh9ItTgGbtinvZeQmrG
 VSAyqmgvCx0QN3aweyiNU7aUQt0jaJ0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-eBymGIrvOkuJUrdA2xJSew-1; Wed, 29 May 2024 10:31:19 -0400
X-MC-Unique: eBymGIrvOkuJUrdA2xJSew-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2e95a73c99eso18193111fa.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 07:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716993078; x=1717597878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GSh6WNvJJzWDKUE/EwLvy2tmXvoSaK77mg2CiJsoQHE=;
 b=sFiaRxs+bkMrQBsFXk99cdhh0/R0tPCzY7ZuqEl/Fej7SNKcBYttzgzut8X4VU3YYs
 p6De3tSBojDwTFP8IRw18VvtEGYTd3L0LFRHYeZrqBWg0Iw56dQdM3XCCraOPJbdmkD2
 XpqTIQ+f24hLbZFxg4Jf0jhiuhxeAt1NSCcTzhwQBR0mdMjnbbf2v/q9ORL42oRZ8hdA
 +pJkwqQKkQZroZ8Q5EGHTYzXFWjyu+ZAmnFzjDyk0agGv02c+JhZzgA+auRmouO1Nq0J
 Ok+c2b7yK8vwG5oNWey0LEUY/kkXLtvuxeCy1yNesqC+QQj2OkmkNSXANL+greqBuyiB
 oZKw==
X-Gm-Message-State: AOJu0YybmJE7I0UBD398i8czXLvaQSvZRXFe9y5hTk/gf4I/H2rYfAP+
 h1sIdqr9k0UYRvFbw/oeoW2vDgZrhbVF9cxy1NJCB6ApnivFW8PCzikkJA0cGVPkuomiC+0u0Eh
 GejFNNmwmeLBLdXk4wGJXlI4i02q7MdMCBQ1b9kJXRc0/Okp3fTyN
X-Received: by 2002:a2e:944d:0:b0:2da:7944:9547 with SMTP id
 38308e7fff4ca-2e95b042c3fmr143163861fa.5.1716993078387; 
 Wed, 29 May 2024 07:31:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUio3qpMjGucXk8Ll5rddXpRugABYaAB/H5/041aVCHkovhjAvMT9pwGErLsMoBXKLUA1fGA==
X-Received: by 2002:a2e:944d:0:b0:2da:7944:9547 with SMTP id
 38308e7fff4ca-2e95b042c3fmr143163691fa.5.1716993077907; 
 Wed, 29 May 2024 07:31:17 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4210896fc7fsm179471085e9.12.2024.05.29.07.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:31:17 -0700 (PDT)
Date: Wed, 29 May 2024 16:31:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, David Hildenbrand
 <david@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 14/23] hw/mem/pc-dimm: Remove legacy_align argument
 from pc_dimm_pre_plug()
Message-ID: <20240529163116.3c7a1780@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-15-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-15-philmd@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 29 May 2024 07:15:30 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> 'legacy_align' is always NULL, remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/mem/pc-dimm.h | 3 +--
>  hw/arm/virt.c            | 2 +-
>  hw/i386/pc.c             | 2 +-
>  hw/loongarch/virt.c      | 2 +-
>  hw/mem/pc-dimm.c         | 6 ++----
>  hw/ppc/spapr.c           | 2 +-
>  6 files changed, 7 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index 322bebe555..fe0f3ea963 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -66,8 +66,7 @@ struct PCDIMMDeviceClass {
>      void (*unrealize)(PCDIMMDevice *dimm);
>  };
> =20
> -void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
> -                      const uint64_t *legacy_align, Error **errp);
> +void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine, Error *=
*errp);
>  void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine);
>  void pc_dimm_unplug(PCDIMMDevice *dimm, MachineState *machine);
>  #endif
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 268b25e332..c7a1f754e7 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2763,7 +2763,7 @@ static void virt_memory_pre_plug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
>          return;
>      }
> =20
> -    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
> +    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), errp);
>  }
> =20
>  static void virt_memory_plug(HotplugHandler *hotplug_dev,
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 9cb5083f8f..08d38a1dcc 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1321,7 +1321,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>          return;
>      }
> =20
> -    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
> +    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), errp);
>  }
> =20
>  static void pc_memory_plug(HotplugHandler *hotplug_dev,
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 6a12659583..c8f16d9d6c 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -1133,7 +1133,7 @@ static bool memhp_type_supported(DeviceState *dev)
>  static void virt_mem_pre_plug(HotplugHandler *hotplug_dev, DeviceState *=
dev,
>                                   Error **errp)
>  {
> -    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
> +    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), errp);
>  }
> =20
>  static void virt_device_pre_plug(HotplugHandler *hotplug_dev,
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 37f1f4ccfd..836384a90f 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -44,8 +44,7 @@ static MemoryRegion *pc_dimm_get_memory_region(PCDIMMDe=
vice *dimm, Error **errp)
>      return host_memory_backend_get_memory(dimm->hostmem);
>  }
> =20
> -void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
> -                      const uint64_t *legacy_align, Error **errp)
> +void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine, Error *=
*errp)
>  {
>      Error *local_err =3D NULL;
>      int slot;
> @@ -70,8 +69,7 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState =
*machine,
>                              &error_abort);
>      trace_mhp_pc_dimm_assigned_slot(slot);
> =20
> -    memory_device_pre_plug(MEMORY_DEVICE(dimm), machine, legacy_align,
> -                           errp);
> +    memory_device_pre_plug(MEMORY_DEVICE(dimm), machine, NULL, errp);
>  }
> =20
>  void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine)
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4345764bce..e7a5b7ce8c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3700,7 +3700,7 @@ static void spapr_memory_pre_plug(HotplugHandler *h=
otplug_dev, DeviceState *dev,
>          return;
>      }
> =20
> -    pc_dimm_pre_plug(dimm, MACHINE(hotplug_dev), NULL, errp);
> +    pc_dimm_pre_plug(dimm, MACHINE(hotplug_dev), errp);
>  }
> =20
>  struct SpaprDimmState {


