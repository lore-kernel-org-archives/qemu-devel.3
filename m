Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E671C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 15:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDPV8-0000Af-GR; Fri, 09 May 2025 11:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uDPV7-0000AE-34
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:19:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uDPV3-0006dc-VH
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746803934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JWJim7G+Siwefyo++b2WmY1msvaLlI1d6zRqWaOxyzA=;
 b=bKN5BJABsK3hnGvwFkRLKrXqSM+TE2I39JPlLgw4Pg1h9QiCwLc/qm7WSjI3p4v/Iy9fJD
 foEQgLcC2hx7ZzcN7kVK3GoNIpBZW/+XdRYbaKioKzt9E/Aw4fPf1RbQuKv+fVZPZNrWcM
 ul7JIfoUqvd5MU+Ebmm0cI6hhMNSHb0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-YQZWVvxGOSCGHSVN04pYUQ-1; Fri, 09 May 2025 11:18:53 -0400
X-MC-Unique: YQZWVvxGOSCGHSVN04pYUQ-1
X-Mimecast-MFC-AGG-ID: YQZWVvxGOSCGHSVN04pYUQ_1746803932
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d733063cdso17705075e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 08:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746803932; x=1747408732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JWJim7G+Siwefyo++b2WmY1msvaLlI1d6zRqWaOxyzA=;
 b=t2uaDMAuxdYk2RXEiBEzQOOOv6Az/diFGA4+64amqC4GUVuz3geJ/TZN2jsyVHy0wb
 EOpyV8fYcMq44wopVroq661RF+J70/LSk0MC1VmcEVsGP4KiYawUziWrf/UzxWz1GWCH
 dWEO3IuNpk8xVgjX6LA9imBOxhyJXXy9hAwZg8oGW9H7QmnhqNdFG1AojPja2py6Z2uK
 gjwB7AjciUA7+SZdSNbIXsSmHGvJ02t/HKQCfkcJYjGTEa8YovODxfVE0D2MQv1SKduA
 h6S74eMrl56oZ0r0rEaevPbd51CZcTd20hkvICftN6wpolAfbrtydNlt4EJRYgHosFsL
 dmGA==
X-Gm-Message-State: AOJu0Yzslbd88f/R35cunj4QGE7/AiGtE2ErX1Dg4CVBIaRC+qut83/a
 ZG0SSEQeVqIS/GKElZbGmeCpECh8T8FqTV230i+82JP67MYhu0TXTBemGqYQfNUFwInYd8V2C3T
 VWCfE93wo1HEF92iNYxJaaXWE1aeFu61J45DeCAWSV1/MkpB1g6R0
X-Gm-Gg: ASbGncuMNrpaSO5P7t7c1BgEoj1yA+FNV05uAAk+WwfcBqiTTlZBBCxe3q5EtuW6HqW
 EU4b4hNpqpqEMkLTKLvLxgxhqZLJzuZ5bMM/XTlQBxayjKowuEzbDv6OoctD3jWjusvUBh/7VIx
 xaEqEfiieTMwPLUgJH9H6FGuTbkdswYgnPXxD51slbh2f6YuoNKNIDVRVNJKnktTzCGcpcqtvGV
 EBVxcFrL03e89gj3Cceli7ciuEDiLggilh7R4Uq76HzqZmldZTqe/FsqfnterPS/MsaTcCtxTq7
 4KIHBLU1bNTZN+TFSJfcxPh/BhWf8emg
X-Received: by 2002:a05:600c:6487:b0:43d:7a:471f with SMTP id
 5b1f17b1804b1-442d6d5d178mr32661475e9.18.1746803932410; 
 Fri, 09 May 2025 08:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWV3J6bpvPo+qOaKHJGbLAXu3HltVy9Aw1OV77LyApiIBOyXHQKhK2ndFIELG8bCn3yooizQ==
X-Received: by 2002:a05:600c:6487:b0:43d:7a:471f with SMTP id
 5b1f17b1804b1-442d6d5d178mr32660905e9.18.1746803931902; 
 Fri, 09 May 2025 08:18:51 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67d5c35sm33173825e9.5.2025.05.09.08.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 08:18:51 -0700 (PDT)
Date: Fri, 9 May 2025 17:18:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Sergio Lopez <slp@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laurent
 Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu
 <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-riscv@nongnu.org, Weiwei Li
 <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>, Zhao Liu
 <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>, Helge Deller
 <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>, Ani Sinha
 <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>, Paolo Bonzini
 <pbonzini@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, Jason
 Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 02/27] hw/i386/pc: Remove
 PCMachineClass::legacy_cpu_hotplug field
Message-ID: <20250509171847.0b505c96@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250508133550.81391-3-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-3-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu,  8 May 2025 15:35:25 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The PCMachineClass::legacy_cpu_hotplug boolean was only used
> by the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
> removed. Remove it and simplify build_dsdt(), removing
> build_legacy_cpu_hotplug_aml() altogether.
>=20
> Note, this field was added by commit 679dd1a957d ("pc: use
> new CPU hotplug interface since 2.7 machine type"):
>=20
>  >  For compatibility reasons PC/Q35 will start with legacy
>  >  CPU hotplug interface by default but with new CPU hotplug
>  >  AML code since 2.7 machine type. That way legacy firmware
>  >  that doesn't use QEMU generated ACPI tables will be
>  >  able to continue using legacy CPU hotplug interface.
>  >
>  >  While new machine type, with firmware supporting QEMU
>  >  provided ACPI tables, will generate new CPU hotplug AML,
>  >  which will switch to new CPU hotplug interface when
>  >  guest OS executes its _INI method on ACPI tables
>  >  loading. =20
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  include/hw/acpi/cpu_hotplug.h |   3 -
>  include/hw/i386/pc.h          |   3 -
>  hw/acpi/cpu_hotplug.c         | 230 ----------------------------------
>  hw/i386/acpi-build.c          |   4 +-
>  4 files changed, 1 insertion(+), 239 deletions(-)
>=20

...

> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 3fffa4a3328..625889783ec 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1465,9 +1465,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      }
>      aml_append(dsdt, scope);
> =20
> -    if (pcmc->legacy_cpu_hotplug) {
> -        build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
> -    } else {
> +    {
>          CPUHotplugFeatures opts =3D {
>              .acpi_1_compatible =3D true, .has_legacy_cphp =3D true,
                                           ^^^^^
that still leaves legacy CPU hotplug hardware around, which we should remove
at the same time as legacy AML.

i.e.:
  drop _INI in hw/acpi/cpu.c
  and at the same time replace legacy_acpi_cpu_hotplug_init() at call sites=
 with
  cpu_hotplug_hw_init()
  after that you can safely remove legacy_cpu_hotplug and no longer needed =
hw/acpi/cpu_hotplug.c && co


>              .smi_path =3D pm->smi_on_cpuhp ? "\\_SB.PCI0.SMI0.SMIC" : NU=
LL,


