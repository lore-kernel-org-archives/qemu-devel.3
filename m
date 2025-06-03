Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192D7C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 15:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMTYM-0000n3-Vs; Tue, 03 Jun 2025 11:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMTYK-0000m4-BL
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMTYE-00085X-LV
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748964461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/d6Io9ph36zkUjwLcBUqbdlZKWHJ7OXy71zCW8+CATo=;
 b=AWJsYs0EuxaTsqMDpy4dpYwFkqpPU2cA4PsiyNt8Ljs7Qo0whEFM6+UoSF2lYPmXlUXEtY
 34Sb2ay5MVLEA+QpoIUplKQhjSVGCeayf1fwp06uN7MWnzQHXOy+Uhw+DbEGfuqT30hOuf
 PZSGTFDhbV4/Bsq+m4P19wEaH7TL2cg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-rgEJtBKRPMKyefBJwVYVbw-1; Tue, 03 Jun 2025 11:27:39 -0400
X-MC-Unique: rgEJtBKRPMKyefBJwVYVbw-1
X-Mimecast-MFC-AGG-ID: rgEJtBKRPMKyefBJwVYVbw_1748964458
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43eed325461so39584275e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 08:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748964458; x=1749569258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/d6Io9ph36zkUjwLcBUqbdlZKWHJ7OXy71zCW8+CATo=;
 b=rulw2O0BjpNa1xZgPyySLyZztqfTMUJVPPauPCLjShy0TV5+37yu4/GO/PwNpMDD6r
 +b2bs5nFTU4Iw4SPubuiFOAq3sDIaU/zqjjmkNsLvN5GEWoz+CkfCo4MfVmU2E8+5kgQ
 HVPy49dd/Sls3nFQPI11r2yuz3lG5WKd/AWokQut7kpHI0Ap6yIJmd3mcV/W5QQBpao9
 0rP44lu93sj7XQnUCdXyGdSIjdL5w0OL/nSgprbMN44n2Rs4d27dae6i+XSssG0pNVyI
 r0Dc8ZL4uUbOaj9Ua+jIeIcCXBi6Tj+XjbmtUHBXuz4Rm1MAGlitAtIm4diAOUacIcsr
 QE8A==
X-Gm-Message-State: AOJu0YwbUUknDx4ettmMddIY54YRyuxemEJXohHHr7Cbq0swCuH/Q9TW
 putinc4hC9/UGyYDZWqidGilcZuMwHh8EtsHcu8WNL6P5eXYObKmUxgm+y/3aMfFlEJwn+Lhns4
 CFDtFkzYoP3oxUSxGpqdPfMk1Y0nTHDWv1PlWKpC2hQvMASrA0uz9iEcJ
X-Gm-Gg: ASbGncvnEE1Xw1u2a1SK7bWSWqE37yDwWDl/eWCBHNRJKMZef5L9nm8883ysesEKX9L
 yihb081rqCbhfOZm4dZNGloa4A09g97KXTD+yjfpos57GiQmPia4MiO577k0VRDywvL4ox+RqAC
 iJuMY96j9KPl+Z25v6sBSgssvWZKDAdaAsOcznWRsr2nEIDbJFpkYPMyFWZD7cDKuX+q9gyOATr
 Gtu+mMPAAI2Tqjpl7KOsrnhDDSWX+GZqOfcTJYu9Q3tL/aPh/EZK1age6pkJR0ePcbsthX6Dl0E
 lq10ZjG9gOBnHgz60G95pGpSycO666Ol
X-Received: by 2002:a05:6000:25ca:b0:3a4:edad:2a59 with SMTP id
 ffacd0b85a97d-3a4f89a5d36mr13663881f8f.1.1748964457712; 
 Tue, 03 Jun 2025 08:27:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT8gvB0SoI7ZTvzA6zj+u27c/t814L+JCG/lS1MN/y3lj4049N9/VVRNeU5iJsQf4Hxyhlww==
X-Received: by 2002:a05:6000:25ca:b0:3a4:edad:2a59 with SMTP id
 ffacd0b85a97d-3a4f89a5d36mr13663856f8f.1.1748964457332; 
 Tue, 03 Jun 2025 08:27:37 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009fd7csm18519295f8f.88.2025.06.03.08.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 08:27:36 -0700 (PDT)
Date: Tue, 3 Jun 2025 17:27:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>, Hanna
 Reitz <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Ani
 Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas
 Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 04/18] hw/i386/kvm: Remove
 KVMClockState::mach_use_reliable_get_clock field
Message-ID: <20250603172735.2dae3bac@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250501210456.89071-5-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-5-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu,  1 May 2025 23:04:42 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The KVMClockState::mach_use_reliable_get_clock boolean was only
> used by the pc-q35-2.8 and pc-i440fx-2.8 machines, which got removed.
> Remove it, along with the 'x-mach-use-reliable-get-clock' property.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/kvm/clock.c | 18 ------------------
>  1 file changed, 18 deletions(-)
>=20
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> index f56382717f7..726ebfcb0cb 100644
> --- a/hw/i386/kvm/clock.c
> +++ b/hw/i386/kvm/clock.c
> @@ -23,7 +23,6 @@
>  #include "migration/vmstate.h"
>  #include "hw/sysbus.h"
>  #include "hw/i386/kvm/clock.h"
> -#include "hw/qdev-properties.h"
>  #include "qapi/error.h"
> =20
>  #include <linux/kvm.h>
> @@ -43,9 +42,6 @@ struct KVMClockState {
>      /* whether the 'clock' value was obtained in the 'paused' state */
>      bool runstate_paused;
> =20
> -    /* whether machine type supports reliable KVM_GET_CLOCK */
> -    bool mach_use_reliable_get_clock;
> -
>      /* whether the 'clock' value was obtained in a host with
>       * reliable KVM_GET_CLOCK */
>      bool clock_is_reliable;
> @@ -232,18 +228,10 @@ static void kvmclock_realize(DeviceState *dev, Erro=
r **errp)
>      qemu_add_vm_change_state_handler(kvmclock_vm_state_change, s);
>  }
> =20
> -static bool kvmclock_clock_is_reliable_needed(void *opaque)
> -{
> -    KVMClockState *s =3D opaque;
> -
> -    return s->mach_use_reliable_get_clock;
> -}
> -
>  static const VMStateDescription kvmclock_reliable_get_clock =3D {
>      .name =3D "kvmclock/clock_is_reliable",
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
> -    .needed =3D kvmclock_clock_is_reliable_needed,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_BOOL(clock_is_reliable, KVMClockState),
>          VMSTATE_END_OF_LIST()
> @@ -304,18 +292,12 @@ static const VMStateDescription kvmclock_vmsd =3D {
>      }
>  };
> =20
> -static const Property kvmclock_properties[] =3D {
> -    DEFINE_PROP_BOOL("x-mach-use-reliable-get-clock", KVMClockState,
> -                      mach_use_reliable_get_clock, true),
> -};
> -
>  static void kvmclock_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
>      dc->realize =3D kvmclock_realize;
>      dc->vmsd =3D &kvmclock_vmsd;
> -    device_class_set_props(dc, kvmclock_properties);
>  }
> =20
>  static const TypeInfo kvmclock_info =3D {


