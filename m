Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F87AD6ACFB
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 13:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWDsT-00079p-Dt; Thu, 18 Dec 2025 08:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vWDsR-00079a-VD
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 08:17:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vWDsM-0001Nj-1X
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 08:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766063821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D6j7TiY365GJDQffnjJjAGK4FQJdyrblUZ9cP/4dJY4=;
 b=Vtr/CkOb92a8K+wT8pxE/lmMTzY0KIKSB35M1E2u0pocTpLNwkycrT5BL5E6F/KP09IxoA
 1WFE7XnYL/HUfPJbudRdEj8vRbWvRqrU9W6urHwAiqhLtNOAmBYX23vCviH61jkbrr0BWf
 o3AMgDYFjCfUoRRm+lynFvM9XQsWvXU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-gDt93ECFNxalZ7188bGTIw-1; Thu, 18 Dec 2025 08:16:59 -0500
X-MC-Unique: gDt93ECFNxalZ7188bGTIw-1
X-Mimecast-MFC-AGG-ID: gDt93ECFNxalZ7188bGTIw_1766063818
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430857e8450so445259f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 05:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766063818; x=1766668618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D6j7TiY365GJDQffnjJjAGK4FQJdyrblUZ9cP/4dJY4=;
 b=T4/rG0r+YKNpI1aoQNaH0C/78gkBJPXOpu3xFCYaXdRK/Lw+xCiV1pBIlFP60x+vtV
 bMZwy2XCdcDRMypcGOCWMIiPT8MSYnKky83UyiW6ey2t5XIJDk8wJOGjFHoyyrSIWSbC
 sB5tC//nPLQ/plyKpZTC5m7KreCz15MSSfDnnXDLrRN2QnWM0jvS9/x+tJC7JemSrjdP
 enoJyYXzutkgFFUL5EzSV7lk6w0s+P6cuPtnTshiqRFN7cQ8wTFfj0Ekpl+1rpKEfeCA
 +mtNNh1qOwEyvPx37HqtG32z39nikS+j7vXhA9xHTGoFv/63XNHmggw+emytutJ5XfJj
 4mgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766063818; x=1766668618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D6j7TiY365GJDQffnjJjAGK4FQJdyrblUZ9cP/4dJY4=;
 b=am08NOREiWNMUbRCia5FzhPd28Uarom7Wz0GAe5aUGpmcyRKy54k0An8tj/pFjOfOj
 IRmmgJdfHKahj9vmyDGe+bWbiBEzmfFvfn32IwMeyoUr2eAzuW046nLmAwvHP6GpwWmq
 pdN5lPjHKgp4aevLIYv/q2BFjQrpC1k/QviIgtv5j3qsT4tBtqhnMK5nwjA+ibw3hJwE
 X7S1FlG7jkU+qNM4O4RyGTXvCfLXmdMdXv8//jpcOVDbbvmuaa4+kULSs4iyVAwmWc83
 wfF4ckSnVj4MbbRgbVPe4VqsFPmEMTJT/YTN272SjEzBMKk1/F8J2cquHxjMorgZ95o6
 QYrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqorFs0ghgwZWKQuXg30ulyJF7uCxjUxVgd2AmwsrZXwvA6KzAcvbnw38Wo+Qref6g5P97W300Ni/D@nongnu.org
X-Gm-Message-State: AOJu0YxSCKaTx8nZuxrUqgViWdz58aMujaqTieFHJqfUwsmQ1tns3mqb
 M9iwX0jQKTyyEKCnyNdTvJD24ao1Mc9vkp4EdACy9t87Bo1IN6xY/UUuZXr6ctL4qs/kzfewxCY
 CB4ny491E/7IkBWMxMk4Ni4uspprLb05G0sInUjZmUB9bow1cXW4li/eI
X-Gm-Gg: AY/fxX5cer8oTSBo0NrjXc7TSEoeKLdPIFGR1Hs6ONB6guW3/kxcMmKWLmbCoky3/Jg
 sE97ooKiESwe0vB/s81V8TjQe2Bm3OXafMZwIFbY/UaLHrD9P+sSf6mW5gT3HpZCTEag3Drgcin
 Z41SfxOJ4PlYBfTRkFJ+jrRtvvSTOyIm3paP37XJnDFs7wjFJl2oDAxrdCZ3k+pUAeENgxn6V7w
 Tq5cgh0Pca6h3+dHAQXzlWoYx+8PfFMNmBLOQ5CzKcQ10G4Mj9QkxAuNuxa4jtbnLCOpGJ7nohd
 hEwMGd8Dm42CB+qYPkM5OyVjWTqn3kiELGJHbLquHNb9axYnik9Heh9uqm7W7nMsY5OYKA==
X-Received: by 2002:a05:6000:1848:b0:431:cf0:2e8b with SMTP id
 ffacd0b85a97d-432448ac61dmr3316975f8f.29.1766063818307; 
 Thu, 18 Dec 2025 05:16:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzPRYLdA9aqkfme3vftsM2x6w3AnDICmu456zKjmpq+1pcYRrN040I6jJAyyDJQTi4+yLLEw==
X-Received: by 2002:a05:6000:1848:b0:431:cf0:2e8b with SMTP id
 ffacd0b85a97d-432448ac61dmr3316909f8f.29.1766063817795; 
 Thu, 18 Dec 2025 05:16:57 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432449986f1sm5011202f8f.29.2025.12.18.05.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 05:16:57 -0800 (PST)
Date: Thu, 18 Dec 2025 14:16:54 +0100
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
Subject: Re: [PATCH v5 17/28] hw/i386/pc: Remove pc_compat_2_6[] array
Message-ID: <20251218141654.5862533b@imammedo>
In-Reply-To: <20251202162835.3227894-18-zhao1.liu@intel.com>
References: <20251202162835.3227894-1-zhao1.liu@intel.com>
 <20251202162835.3227894-18-zhao1.liu@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed,  3 Dec 2025 00:28:24 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>=20
> The pc_compat_2_6[] array was only used by the pc-q35-2.6
> and pc-i440fx-2.6 machines, which got removed. Remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc.c         | 8 --------
>  include/hw/i386/pc.h | 3 ---
>  2 files changed, 11 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2e315414aeaf..85d12f8d0389 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -263,14 +263,6 @@ GlobalProperty pc_compat_2_7[] =3D {
>  };
>  const size_t pc_compat_2_7_len =3D G_N_ELEMENTS(pc_compat_2_7);
> =20
> -GlobalProperty pc_compat_2_6[] =3D {
> -    { TYPE_X86_CPU, "cpuid-0xb", "off" },
> -    { "vmxnet3", "romfile", "" },
> -    { TYPE_X86_CPU, "fill-mtrr-mask", "off" },
> -    { "apic-common", "legacy-instance-id", "on", }
> -};
> -const size_t pc_compat_2_6_len =3D G_N_ELEMENTS(pc_compat_2_6);
> -
>  /*
>   * @PC_FW_DATA:
>   * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 698e3fb84af0..f8f317aee197 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -295,9 +295,6 @@ extern const size_t pc_compat_2_8_len;
>  extern GlobalProperty pc_compat_2_7[];
>  extern const size_t pc_compat_2_7_len;
> =20
> -extern GlobalProperty pc_compat_2_6[];
> -extern const size_t pc_compat_2_6_len;
> -
>  #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>      static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
>                                                   const void *data) \


