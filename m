Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19915D6ACF5
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 13:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWEJf-0006nP-Hm; Thu, 18 Dec 2025 08:45:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vWEJY-0006jU-Kb
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 08:45:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vWEJV-0001Hs-NE
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 08:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766065504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OcGyhvdq0kxqwUU4NFVOHDluMCKeql1WmgcW9G4ZFcU=;
 b=V8hlKqG1nvnT4gbFBKnDpUphMXwqS1YlE+s1JHNxRkzibnyJpTJIZ/ASwNzeDRBXTOYepG
 cIqGtTHCZ4jKgjh/L+31Windj1uhTduW5EF8OMojE34KksZC5V/Zhnt041M1YljYG8THZF
 sasiOCscJHRtXBtobPHgoZeM4N67tfY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-Nj2AGrWwM3aXqf7mawvAwg-1; Thu, 18 Dec 2025 08:45:03 -0500
X-MC-Unique: Nj2AGrWwM3aXqf7mawvAwg-1
X-Mimecast-MFC-AGG-ID: Nj2AGrWwM3aXqf7mawvAwg_1766065502
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso9229025e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 05:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766065502; x=1766670302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OcGyhvdq0kxqwUU4NFVOHDluMCKeql1WmgcW9G4ZFcU=;
 b=NczxySt7d5YMRxPJzfPwPCFioCsQt5sYdU2oTXwtyRYLx0s0IM4Hi+MK69e/qTufa0
 jD+ijJ6LIbn1cyhYrVEuXIJnJ8p5/NoIOgwRC/rKUWn2fn4OK7a/J2Xq2wa0L08y+qui
 rGEq+q+ux1t/u+fO14jZw3u05M3oTPSK0Lzu3JQQrpuMDTsEAJ2B4B/Qayj3cW1AFmlj
 nEMnAAvq7yklpd5W17+Je5fFrwdQliSMPAr6HVZRZUdkp0jUFzjka7wPVwREfwFJ8YtF
 OpBXqF+HhlITv+OVM04dkMD8eFaNd7vN6zpG6Zafuxx8Av34SLX8562vUTgkbNf2K1El
 LdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766065502; x=1766670302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OcGyhvdq0kxqwUU4NFVOHDluMCKeql1WmgcW9G4ZFcU=;
 b=U/4Bzcys7+zTrXHqJokhKTJSp5KYpFchj+v94Gq9WdqX8TPMMb3Mkm+yIZpCm422Wz
 X1tbQxqLgFaHSCO4KoP1JNGxalTQkQSaVpQQwf/g5fDoPphJDw2VV0XoHEtpzUBToSZ6
 KBR5Gk3168civ/HszTysGuFn4HJOXPxOfhCZks7hD47tZP9B/YZCQvQHzhirDEMY58+3
 KhgX/2EgfPLoiiCW3sD9x+B2SB+7Fu7CweNVfNuCE1oCCBPOSM0FrOeL888vBXBTqLm1
 EYo26xJaoDMLyj5x7XX5gHmRkkneMJ6oKB1pxMjzEyreAd0yEUXrBf6SQYkGENYow6CG
 nXAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuhtgKxsKUiNn8BJAM0fIsTLxvbDRRbE4jSqjBCB8nHN34wDVNMOEnNCgKcNTiR+NecIqtJgrlV5sE@nongnu.org
X-Gm-Message-State: AOJu0YzRmgh5DimkgzXWsRWVOZnALUadUJZ0pY5u2Q39cuTk54mxxxgX
 rfDn0b6WB4gbnPp11m26EycRa9aN33x5bPm4pIfGFsBXHkVf12Xads6bgBMUr3cStTfqomoPqlE
 by+rQCIXSPQco7OYyaTetEPm0eG0zf/6uBgo+jV/e+d39Cc5eicOrHrnu
X-Gm-Gg: AY/fxX7daZjj0vpDXeinfQKIw8TOYjKlR7V5BfC70uIafHv1n9n/V7ywwps1ar/wCbk
 DHql0CTV1/MhwqDARm4PMMLVjJFZjkd383Qk6Yqgl9eo3twR35zU0sTEt+LT1NjMQtU1S+N3G2t
 HcOpi6nat9JZGSI9N8o1Dw5L6Am1H01VY/P/uryuEZJkMAmHNXWyVi2i4AiwDqc8pDhWa03n9cS
 tGveW/BBGXXYlJcfW8dNVjGh73uc257m5NWosVyEMUYiYea9f2twpiDn7hHvUbvzr8Jd3+WcoUf
 F2/k/9axTMyJ9P2Q4hbILyQ+NqwR9pI+GtJVHYHX10oKq5GLfFDbd2PDpf2HKwjbW6Hv4A==
X-Received: by 2002:a5d:64e8:0:b0:430:f6bc:2f8b with SMTP id
 ffacd0b85a97d-430f6bc3221mr18155872f8f.45.1766065502217; 
 Thu, 18 Dec 2025 05:45:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnEeHyuc3XOw+0zv5jgfMxc4yPA83Oi7haKTTABOLc0orXoBwjLhHFxyrb01vSj4hp1xkXJg==
X-Received: by 2002:a5d:64e8:0:b0:430:f6bc:2f8b with SMTP id
 ffacd0b85a97d-430f6bc3221mr18155764f8f.45.1766065501002; 
 Thu, 18 Dec 2025 05:45:01 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324493fda5sm5264021f8f.17.2025.12.18.05.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 05:45:00 -0800 (PST)
Date: Thu, 18 Dec 2025 14:44:58 +0100
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
Subject: Re: [PATCH v5 22/28] hw/i386/pc: Remove pc_compat_2_7[] array
Message-ID: <20251218144458.1b6b3b40@imammedo>
In-Reply-To: <20251202162835.3227894-23-zhao1.liu@intel.com>
References: <20251202162835.3227894-1-zhao1.liu@intel.com>
 <20251202162835.3227894-23-zhao1.liu@intel.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed,  3 Dec 2025 00:28:29 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>=20
> The pc_compat_2_7[] array was only used by the pc-q35-2.7
> and pc-i440fx-2.7 machines, which got removed. Remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  hw/i386/pc.c         | 10 ----------
>  include/hw/i386/pc.h |  3 ---
>  2 files changed, 13 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 85d12f8d0389..b88030bf50d0 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -253,16 +253,6 @@ GlobalProperty pc_compat_2_8[] =3D {
>  };
>  const size_t pc_compat_2_8_len =3D G_N_ELEMENTS(pc_compat_2_8);
> =20
> -GlobalProperty pc_compat_2_7[] =3D {
> -    { TYPE_X86_CPU, "l3-cache", "off" },
> -    { TYPE_X86_CPU, "full-cpuid-auto-level", "off" },
> -    { "Opteron_G3" "-" TYPE_X86_CPU, "family", "15" },
> -    { "Opteron_G3" "-" TYPE_X86_CPU, "model", "6" },
> -    { "Opteron_G3" "-" TYPE_X86_CPU, "stepping", "1" },
> -    { "isa-pcspk", "migrate", "off" },
> -};
> -const size_t pc_compat_2_7_len =3D G_N_ELEMENTS(pc_compat_2_7);
> -
>  /*
>   * @PC_FW_DATA:
>   * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index f8f317aee197..accd08cb666b 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -292,9 +292,6 @@ extern const size_t pc_compat_2_9_len;
>  extern GlobalProperty pc_compat_2_8[];
>  extern const size_t pc_compat_2_8_len;
> =20
> -extern GlobalProperty pc_compat_2_7[];
> -extern const size_t pc_compat_2_7_len;
> -
>  #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>      static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
>                                                   const void *data) \


