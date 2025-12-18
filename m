Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C555CD68BE4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 13:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWE8y-0003MB-Lq; Thu, 18 Dec 2025 08:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vWE8x-0003Lu-It
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 08:34:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vWE8u-0006Wa-RB
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 08:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766064846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ygbAU5x3T384LKUGynR1xkO6dKCGM4SShqXTIGHAd/Y=;
 b=Xih7EEPvrV5nMzlU7WRRufcxy4DwBhbnBF7HFFWRu46EOx62XZBCcKSLwgJSLfCJqD2GAN
 D9P0JqRt9NMfIq7w7g+IBTIBxEPoiQ2Mdw06jqGdCNtX6ZubA3ekCpowCtoroEtdQ9c+Nn
 K/y9FmXyhqjNCbcDhDNt3CXWnW7sW/8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-OS7iT2CyM56FCLgKQB_fmQ-1; Thu, 18 Dec 2025 08:34:04 -0500
X-MC-Unique: OS7iT2CyM56FCLgKQB_fmQ-1
X-Mimecast-MFC-AGG-ID: OS7iT2CyM56FCLgKQB_fmQ_1766064844
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42fdbba545fso879475f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 05:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766064843; x=1766669643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ygbAU5x3T384LKUGynR1xkO6dKCGM4SShqXTIGHAd/Y=;
 b=dV1AbOF4ZgxyleousjG20YGCGutClSvsniwNAnOjqvkKJYXseXQum534NzHFAZb6zP
 vlTHWGaUiO2fGo3UKE/7qSOtt59QkJDxOlcIdS300BVUWXeQPS0Z8NTFKFzsxcfV1EjC
 BOP6lyaafLSH/dGMpJfaYK9yy4NzzACnw7v19Nr18VVVY+mOXhUEuLzbyD3fR14qNQhD
 nD1ohelwG31qey0EXBmz5MAAjPzQPCZpVG6ySE0pBwPKwcih6dPnx8VRhN+MzRHqYLX2
 v9zI/v6ifbl/4BWDt6stVRvZuoXgq42NvQV/EaF89Bo0mDT1MU5mtwIDEQ3r5JLbieiw
 YR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766064843; x=1766669643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ygbAU5x3T384LKUGynR1xkO6dKCGM4SShqXTIGHAd/Y=;
 b=r4HpIAWDpZ6GC2TnDDdMn8/a271+XMvVIqWsJTkHE7W0IcQ0y4kPYaGeF3RD70VMG7
 MBT+hOiuM7PTdU69gd6tCYpeDHgI0hdneqDpneui8+7HD0llDpn/sSrCEZVH5dTEDbb1
 i+Ifk5K6kz0+TM1/D4GwfsGdyfNO1p5/qRw++3fxLTgZcToU4O9SHrEVrgxc/GHJY1Jb
 CYmJHEgbRIaWWjeUNfxabyOZt5TEXvWYzRuLDOOIQ7GJ7cubTMIfw/KEGCOXA2wxItgU
 HwR1YbzRP9fjHqd3Z5cqB4KMkjS5JNIpfH21k69CUia2FEbwErxh+VtuMqPxV01b3zHb
 /C7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGZCMxyVL9LLVPOgp4FKz2uB2jrwhPZ1RJwHlUIdxyocmgf/2tSQgItC0H+6IvAayHRIoALWn/qTrJ@nongnu.org
X-Gm-Message-State: AOJu0YxgUJh3J4AGGwmGamRZ2KG7xCdFtoO11bWAlFpCTJ4n13Aawqi8
 61G1ldNQINdHiP+uk99WV6SoKyFOSH3nNzSb14WmL+GgdekHWuv5utwAMsL3639eKnp3OElnzbA
 oy03hpcgORn1Muw0xO7SiScuGDA52nQjCHpjtWHi3/IMYN+iINFpudMZe
X-Gm-Gg: AY/fxX4P4KrDKflRJOx8uq16g9uFh/rPblnDZApgqem+8UPpuWOGsaXKmVqhGRmRITE
 EkoxLUKZWRc7sFJ5xQHLHzH0TXR1jnbp/ofdTFNRNgHAFVZBfd+P9ipqsuHnGNS3sHrmgnhfwG0
 4GAA1VzLACJ4zVyA8Q7oG/tQfs1AhI9yFloGdF4I/CxXmxChk4SOyLwDNsll+FaAbsreiC88Gxj
 kCHYQDIuU3Z2tc/NYHuf5bUQNfvqnbOis3cLvOb0r1ohInjvDNxiyVJ1EK8EVu6wVnPVIv8Mfau
 FD42qjxhvPG2+wSFWh/6zMlBrW6vwTmW4PjBWkPsohWC8/IpSgbQDUFpFM4hZddxARrpMA==
X-Received: by 2002:a05:6000:230d:b0:429:b963:cdd5 with SMTP id
 ffacd0b85a97d-43244795a5amr3553253f8f.5.1766064843459; 
 Thu, 18 Dec 2025 05:34:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIIhtQ63uV7WOn8IreQo+ZbPmGD3G2VFSLJtwjjUHetMozKfXuRebRZihn0OnYhKPteoqFwQ==
X-Received: by 2002:a05:6000:230d:b0:429:b963:cdd5 with SMTP id
 ffacd0b85a97d-43244795a5amr3553201f8f.5.1766064842951; 
 Thu, 18 Dec 2025 05:34:02 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43244998c8asm5239848f8f.30.2025.12.18.05.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 05:34:02 -0800 (PST)
Date: Thu, 18 Dec 2025 14:33:59 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas
 Huth <thuth@redhat.com>, qemu-devel@nongnu.org, devel@lists.libvirt.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Richard
 Henderson <richard.henderson@linaro.org>, Sergio Lopez <slp@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Yi Liu <yi.l.liu@intel.com>, Eduardo
 Habkost <eduardo@habkost.net>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Weiwei Li <liwei1518@gmail.com>, Amit Shah
 <amit@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, Yanan Wang
 <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>, Palmer Dabbelt
 <palmer@dabbelt.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Ani Sinha <anisinha@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Huacai
 Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>, Mark
 Cave-Ayland <mark.caveayland@nutanix.com>, BALATON Zoltan
 <balaton@eik.bme.hu>, Peter Krempa <pkrempa@redhat.com>, Jiri Denemark
 <jdenemar@redhat.com>
Subject: Re: [PATCH v5 19/28] hw/core/machine: Remove hw_compat_2_6[] array
Message-ID: <20251218143359.2b3ee268@imammedo>
In-Reply-To: <20251202162835.3227894-20-zhao1.liu@intel.com>
References: <20251202162835.3227894-1-zhao1.liu@intel.com>
 <20251202162835.3227894-20-zhao1.liu@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed,  3 Dec 2025 00:28:26 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>=20
> The hw_compat_2_6[] array was only used by the pc-q35-2.6 and
> pc-i440fx-2.6 machines, which got removed. Remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/core/machine.c   | 8 --------
>  include/hw/boards.h | 3 ---
>  2 files changed, 11 deletions(-)
>=20
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 27372bb01ef4..0b10adb5d538 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -290,14 +290,6 @@ GlobalProperty hw_compat_2_7[] =3D {
>  };
>  const size_t hw_compat_2_7_len =3D G_N_ELEMENTS(hw_compat_2_7);
> =20
> -GlobalProperty hw_compat_2_6[] =3D {
> -    { "virtio-mmio", "format_transport_address", "off" },
> -    /* Optional because not all virtio-pci devices support legacy mode */
> -    { "virtio-pci", "disable-modern", "on",  .optional =3D true },
> -    { "virtio-pci", "disable-legacy", "off", .optional =3D true },
> -};
> -const size_t hw_compat_2_6_len =3D G_N_ELEMENTS(hw_compat_2_6);
> -
>  MachineState *current_machine;
> =20
>  static char *machine_get_kernel(Object *obj, Error **errp)
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index a48ed4f86a35..5ddadbfd8a83 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -882,7 +882,4 @@ extern const size_t hw_compat_2_8_len;
>  extern GlobalProperty hw_compat_2_7[];
>  extern const size_t hw_compat_2_7_len;
> =20
> -extern GlobalProperty hw_compat_2_6[];
> -extern const size_t hw_compat_2_6_len;
> -
>  #endif


