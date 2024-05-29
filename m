Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129F0C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 14:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJrO-0004k7-Qr; Wed, 29 May 2024 10:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCJrN-0004jb-0R
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:00:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCJrL-0004j3-4h
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716991253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZIZuqgK2s8o1ZpqDBwBxeTJ9oP1AWDVn8B1j5ZI0cbk=;
 b=dIGnofeVbdy4oQQ7LiWgkA9/RWDeHNq55eDCljLjhx4MaFaFJEojbChBWvACiBgAaHrIL0
 AEr1pAz6uqFhjOcnQeb5y3FdBDyiTSqdFBW9BcW88azqaIzZS3G/nT9bVc7pFpTK4qAeTQ
 raVQMT6zY83fkkTstZ8505PFYo6n0f4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-R05S_5nQPieN40Dn5Deaog-1; Wed, 29 May 2024 10:00:51 -0400
X-MC-Unique: R05S_5nQPieN40Dn5Deaog-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-354f34e0ab0so1339917f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 07:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716991250; x=1717596050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZIZuqgK2s8o1ZpqDBwBxeTJ9oP1AWDVn8B1j5ZI0cbk=;
 b=W8jajNsPw9TFOSDWE7f75q0w1nI2IE7pu/KB3vA4lZDbEvpz+xxql46cbovgM7hezf
 JR5UVkKbn8DXBf1LdGD99GlpSrynXsQr2+tDNgNIkq3Bf/jvwt8dV2DBeUqF0LGt9QlG
 pb6L4fZ30FygWnJJYKxApbuTPPtMVkP1WA1hz5FPfjYDNhF8UbY6tInfP6w3+QzfJE2F
 A68dIgImPuC+IS7pRBvWDSCxDg6lHUPxR1Mg8yjkiHbph+Kef6pn1ASBhKnFRcLtqpD3
 lCzPzRMzKsLH2UxBNkjNFNR4b8ieacV1NhMTt+FutG7m41rauBSNMhMknY9C8EXvLo8K
 S+2Q==
X-Gm-Message-State: AOJu0YzeXJrAh/UK9ORh3r5GqUhyrVNo1sgR6BYi+ALT+jxnQAK1FRer
 mBfEwaYhvEcGi9oKHY9I4TRx2fItc2vPZDmduqdqJm1rFkEvwNtxmctknsV5KYKt0BIus1hqC2u
 eebcyPLggjPaITGoCeGh1rhyNCT+BoxjpzKgA0yiqeKRuwGK+VZW4
X-Received: by 2002:a05:6000:d0a:b0:354:f2b0:ebdb with SMTP id
 ffacd0b85a97d-35526c3d65amr10866716f8f.12.1716991249790; 
 Wed, 29 May 2024 07:00:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcqLc4wlFF3GWxiSwVA2TsbakEoJphwlG9nQ0rKTjQpWO/Jgmv/jmm2lVFHXUY79QMCI7AnA==
X-Received: by 2002:a05:6000:d0a:b0:354:f2b0:ebdb with SMTP id
 ffacd0b85a97d-35526c3d65amr10866690f8f.12.1716991249191; 
 Wed, 29 May 2024 07:00:49 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a0907fasm14878318f8f.57.2024.05.29.07.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:00:48 -0700 (PDT)
Date: Wed, 29 May 2024 16:00:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 08/23] hw/i386/pc: Remove deprecated pc-i440fx-2.1
 machine
Message-ID: <20240529160047.1aba8882@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-9-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-9-philmd@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Wed, 29 May 2024 07:15:24 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The pc-i440fx-2.1 machine was deprecated for the 8.2
> release (see commit c7437f0ddb "docs/about: Mark the
> old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
> time to remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  docs/about/deprecated.rst       |  2 +-
>  docs/about/removed-features.rst |  2 +-
>  include/hw/i386/pc.h            |  3 ---
>  hw/i386/pc.c                    |  7 -------
>  hw/i386/pc_piix.c               | 23 -----------------------
>  5 files changed, 2 insertions(+), 35 deletions(-)
>=20
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 629f6a1566..5b4753e5dc 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -228,7 +228,7 @@ deprecated; use the new name ``dtb-randomness`` inste=
ad. The new name
>  better reflects the way this property affects all random data within
>  the device tree blob, not just the ``kaslr-seed`` node.
> =20
> -``pc-i440fx-2.1`` up to ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.=
4`` up to ``pc-i440fx-2.12`` (since 9.1)
> +``pc-i440fx-2.2`` up to ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.=
4`` up to ``pc-i440fx-2.12`` (since 9.1)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''=
''''''''''''''''''''''''''''''''''''''''
> =20
>  These old machine types are quite neglected nowadays and thus might have
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-feature=
s.rst
> index 5f0c2d8ec2..9b0e2f11de 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -925,7 +925,7 @@ mips ``fulong2e`` machine alias (removed in 6.0)
> =20
>  This machine has been renamed ``fuloong2e``.
> =20
> -``pc-0.10`` up to ``pc-i440fx-2.0`` (removed in 4.0 up to 9.0)
> +``pc-0.10`` up to ``pc-i440fx-2.1`` (removed in 4.0 up to 9.0)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> =20
>  These machine types were very old and likely could not be used for live
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 01fdcfaeb6..db0f8e0e36 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -286,9 +286,6 @@ extern const size_t pc_compat_2_3_len;
>  extern GlobalProperty pc_compat_2_2[];
>  extern const size_t pc_compat_2_2_len;
> =20
> -extern GlobalProperty pc_compat_2_1[];
> -extern const size_t pc_compat_2_1_len;
> -
>  #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>      static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *=
data) \
>      { \
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 11182e09ce..f27c9fd98c 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -312,13 +312,6 @@ GlobalProperty pc_compat_2_2[] =3D {
>  };
>  const size_t pc_compat_2_2_len =3D G_N_ELEMENTS(pc_compat_2_2);
> =20
> -GlobalProperty pc_compat_2_1[] =3D {
> -    PC_CPU_MODEL_IDS("2.1.0")
> -    { "coreduo" "-" TYPE_X86_CPU, "vmx", "on" },
> -    { "core2duo" "-" TYPE_X86_CPU, "vmx", "on" },
> -};
> -const size_t pc_compat_2_1_len =3D G_N_ELEMENTS(pc_compat_2_1);
> -
>  GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
>  {
>      GSIState *s;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index a750a0e6ab..e0b421dd51 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -66,7 +66,6 @@
>  #include "hw/hyperv/vmbus-bridge.h"
>  #include "hw/mem/nvdimm.h"
>  #include "hw/i386/acpi-build.h"
> -#include "kvm/kvm-cpu.h"
>  #include "target/i386/cpu.h"
> =20
>  #define XEN_IOAPIC_NUM_PIRQS 128ULL
> @@ -435,12 +434,6 @@ static void pc_compat_2_2_fn(MachineState *machine)
>      pc_compat_2_3_fn(machine);
>  }
> =20
> -static void pc_compat_2_1_fn(MachineState *machine)
> -{
> -    pc_compat_2_2_fn(machine);
> -    x86_cpu_change_kvm_default("svm", NULL);
> -}
> -
>  #ifdef CONFIG_ISAPC
>  static void pc_init_isa(MachineState *machine)
>  {
> @@ -866,22 +859,6 @@ static void pc_i440fx_2_2_machine_options(MachineCla=
ss *m)
>  DEFINE_I440FX_MACHINE(v2_2, "pc-i440fx-2.2", pc_compat_2_2_fn,
>                        pc_i440fx_2_2_machine_options);
> =20
> -static void pc_i440fx_2_1_machine_options(MachineClass *m)
> -{
> -    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> -
> -    pc_i440fx_2_2_machine_options(m);
> -    m->hw_version =3D "2.1.0";
> -    m->default_display =3D NULL;
> -    compat_props_add(m->compat_props, hw_compat_2_1, hw_compat_2_1_len);
> -    compat_props_add(m->compat_props, pc_compat_2_1, pc_compat_2_1_len);
> -    pcmc->smbios_uuid_encoded =3D false;
> -    pcmc->enforce_aligned_dimm =3D false;
> -}
> -
> -DEFINE_I440FX_MACHINE(v2_1, "pc-i440fx-2.1", pc_compat_2_1_fn,
> -                      pc_i440fx_2_1_machine_options);
> -
>  #ifdef CONFIG_ISAPC
>  static void isapc_machine_options(MachineClass *m)
>  {


