Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19916E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 08:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOYiL-0005oD-Gr; Fri, 20 Dec 2024 03:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tOYiJ-0005nj-Dz
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 03:50:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tOYiG-0001NL-EF
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 03:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734684623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bfsy+DprmXywkw+uDyl5a1KBJUfg5bpr3NHlBEfQ5LU=;
 b=U4lU5M/WM2iMMMmrN6BZFHA1kxQkjX/71XX2kOxJIywrm2O2u2ibMyUG/+d9f9o0ngQHDg
 nr/iSKE9K2bnnJTi5Ro67CMM0h3lhOQCi3RjN02r5G2COkHzDTLNvLmsOGqLhaL3q8H9Id
 VAK39TKSIzYPzaCIvn7jm0Rj77R2UAo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-hdiwCPOYPh6BdC1m2KQIEQ-1; Fri, 20 Dec 2024 03:50:21 -0500
X-MC-Unique: hdiwCPOYPh6BdC1m2KQIEQ-1
X-Mimecast-MFC-AGG-ID: hdiwCPOYPh6BdC1m2KQIEQ
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b6eeef7c38so316525285a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 00:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734684620; x=1735289420;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bfsy+DprmXywkw+uDyl5a1KBJUfg5bpr3NHlBEfQ5LU=;
 b=w/13rwldlcCfopykbwv8CGKxzeHrGG+GaHznq/ERjuj0oO5ceSEFeKxDh2PD3D/PtZ
 seqON3lGWd9ESzH0AM49CNGUb976QvG0S1LxJreoIl9ArF6/6xXuBuKtL63L9EAiBQtE
 YiMhtSrhdGPi9EHgNtq50+VcFh8o8x66DpdSdVlpdGfcy5MzTqifg6Il74t1p6ML7Gkh
 kCS32ja9EVuAPcJ7OT4hiq7BjP3EjkL6M+ytVjq27LFU7fvifKlMsQRVmEshLevX54YC
 a1nWqrM4sPnKjc3vkLH+O7SwYsFVAU4Xa3GVyJAdwgMcCdEz7x1qeuHxENTnqW1MSsRz
 UM5g==
X-Gm-Message-State: AOJu0YzwmnRAj8CzzgN2kKyGaSBShYp62k7eiddAQrQNPumiPwLEHFy4
 Ao73RR/aQLFqa+fjqAl3chZ6dfmAD3lgdSJ6fJfR8e/QJivhtAeVyzY1qWBtgdL06EpSoMITGMX
 Au4z/ndnyDfQpELCb+IswaM8VoFizOC3Ov7xhjMpUh8cqfE7JQ/tVMBwOEpjsoXRYpc17QmJKy0
 PVtBKe76h3exzePGOV4zkhzUwjtQO6+ns20rD2jg==
X-Gm-Gg: ASbGncvPPw6DzXKSKSTIvzkSxUcyPvEm5FBabAujWuoL4q9Mt06IusgJkDjkVOSEWiy
 H3fsFfAse9ClIAgs+H/WdHp74P/zV7KcWQGaa2EiJpMnHFss38VRDpmG0NV4Y7g9HzGIl4ms=
X-Received: by 2002:a05:620a:31a2:b0:7b7:142d:53d2 with SMTP id
 af79cd13be357-7b9ba83640cmr284331185a.41.1734684620118; 
 Fri, 20 Dec 2024 00:50:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCpeJbvbbCgWwQSbbtUNmLU+UvY/Kjb4FkrtWVjAwhlXA3WoDZ9ysHf8mtIM5F39DU4m2qbDQWM7AVgOcOks0=
X-Received: by 2002:a05:620a:31a2:b0:7b7:142d:53d2 with SMTP id
 af79cd13be357-7b9ba83640cmr284329885a.41.1734684619760; Fri, 20 Dec 2024
 00:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20241219153857.57450-1-philmd@linaro.org>
 <20241219153857.57450-9-philmd@linaro.org>
In-Reply-To: <20241219153857.57450-9-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 20 Dec 2024 12:50:08 +0400
Message-ID: <CAMxuvayAVM4UvDjnSKEMD59YZpCgYVQHMVXkBrbTf3S79zRQ7g@mail.gmail.com>
Subject: Re: [RFC PATCH 08/10] hw/misc/vmcoreinfo: Implement 'vmcore-info'
 object
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 devel@lists.libvirt.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Hi

On Thu, Dec 19, 2024 at 7:39=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> 'vmcore-info' object allow to transition from '-device'
> to 'object', following the deprecation process.
>

Is there a strong motivation behind this? just replacing -device with
-object doesn't really give anything, does it?

Also I'd rather keep the name "vmcoreinfo" since that's how it used to
be, and also the name used by the kernel ELF etc.

> No need to modify VMCoreInfoState since DeviceState
> already inherits from Object state.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/misc/vmcoreinfo.h |  4 ++-
>  hw/misc/vmcoreinfo.c         | 48 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 50 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/misc/vmcoreinfo.h b/include/hw/misc/vmcoreinfo.h
> index 122c69686b0..d4cce42cee6 100644
> --- a/include/hw/misc/vmcoreinfo.h
> +++ b/include/hw/misc/vmcoreinfo.h
> @@ -16,8 +16,10 @@
>  #include "standard-headers/linux/qemu_fw_cfg.h"
>  #include "qom/object.h"
>
> +#define TYPE_VMCOREINFO "vmcore-info"
> +OBJECT_DECLARE_SIMPLE_TYPE(VMCoreInfoState, VMCOREINFO)
> +
>  #define TYPE_VMCOREINFO_DEVICE "vmcoreinfo"
> -typedef struct VMCoreInfoState VMCoreInfoState;
>  DECLARE_INSTANCE_CHECKER(VMCoreInfoState, VMCOREINFO_DEVICE,
>                           TYPE_VMCOREINFO_DEVICE)
>
> diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
> index a0511ea0da4..e2258e08fb1 100644
> --- a/hw/misc/vmcoreinfo.c
> +++ b/hw/misc/vmcoreinfo.c
> @@ -12,11 +12,11 @@
>
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> -#include "qemu/module.h"
>  #include "sysemu/reset.h"
>  #include "hw/nvram/fw_cfg.h"
>  #include "migration/vmstate.h"
>  #include "hw/misc/vmcoreinfo.h"
> +#include "qom/object_interfaces.h"
>
>  static const VMStateDescription vmstate_vmcoreinfo =3D {
>      .name =3D "vmcoreinfo",
> @@ -32,6 +32,11 @@ static const VMStateDescription vmstate_vmcoreinfo =3D=
 {
>      },
>  };
>
> +static char *vmcoreinfo_get_vmstate_id(VMStateIf *vmif)
> +{
> +    return g_strdup(TYPE_VMCOREINFO);
> +}
> +
>  static void fw_cfg_vmci_write(void *opaque, off_t offset, size_t len)
>  {
>      VMCoreInfoState *s =3D opaque;
> @@ -88,6 +93,32 @@ static void vmcoreinfo_device_realize(DeviceState *dev=
, Error **errp)
>      vmcoreinfo_realize(VMCOREINFO_DEVICE(dev), errp);
>  }
>
> +static bool vmcoreinfo_can_be_deleted(UserCreatable *uc)
> +{
> +    return false;
> +}
> +
> +static void vmcoreinfo_complete(UserCreatable *uc, Error **errp)
> +{
> +    if (vmstate_register_any(VMSTATE_IF(uc), &vmstate_vmcoreinfo, uc) < =
0) {
> +        error_setg(errp, "%s: Failed to register vmstate", TYPE_VMCOREIN=
FO);
> +    }
> +
> +    vmcoreinfo_realize(VMCOREINFO(uc), errp);
> +}
> +
> +static void vmcoreinfo_class_init(ObjectClass *oc, void *data)
> +{
> +    UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
> +    VMStateIfClass *vc =3D VMSTATE_IF_CLASS(oc);
> +    ResettableClass *rc =3D RESETTABLE_CLASS(oc);
> +
> +    ucc->complete =3D vmcoreinfo_complete;
> +    ucc->can_be_deleted =3D vmcoreinfo_can_be_deleted;
> +    vc->get_id =3D vmcoreinfo_get_vmstate_id;
> +    rc->phases.hold =3D vmcoreinfo_reset_hold;
> +}
> +
>  static void vmcoreinfo_device_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -106,6 +137,18 @@ static const TypeInfo vmcoreinfo_types[] =3D {
>          .parent         =3D TYPE_DEVICE,
>          .instance_size  =3D sizeof(VMCoreInfoState),
>          .class_init     =3D vmcoreinfo_device_class_init,
> +    },
> +    {
> +        .name           =3D TYPE_VMCOREINFO,
> +        .parent         =3D TYPE_OBJECT,
> +        .instance_size  =3D sizeof(VMCoreInfoState),
> +        .class_init     =3D vmcoreinfo_class_init,
> +        .interfaces =3D (InterfaceInfo[]) {
> +            { TYPE_RESETTABLE_INTERFACE },
> +            { TYPE_USER_CREATABLE },
> +            { TYPE_VMSTATE_IF },
> +            { }
> +        }
>      }
>  };
>
> @@ -116,6 +159,9 @@ VMCoreInfoState *vmcoreinfo_find(void)
>      Object *obj;
>
>      obj =3D object_resolve_path_type("", TYPE_VMCOREINFO_DEVICE, NULL);
> +    if (!obj) {
> +        obj =3D object_resolve_path_type("", TYPE_VMCOREINFO, NULL);
> +    }
>
>      return obj ? (VMCoreInfoState *)obj : NULL;
>  }
> --
> 2.47.1
>


