Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90208D65C5A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 14:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVst9-0004sv-6J; Wed, 17 Dec 2025 09:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vVst7-0004sn-Ni
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:52:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vVst6-0002Db-46
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765983143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gL5F3xHBPmKGkcE8K+DR/FS+dwcTcYAQDkDaOW4jcUU=;
 b=Jut4lZTfo/EXpElAQbNynwRqzulXWc7B6t024dbYxwI6FPDQETxydiX4UVUV31u5JUHXNR
 svpVk6qqOmKAaG5tjFW6eo+HpouacxOFEzNC2+RU2kfCEJePqIR4rof4U7QU33ozZ1RxOz
 xOLKY7i5nB0RQEOzOLPFGt1Y145OLwg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-6oC_RDV8P1W5w2IO8I8_HQ-1; Wed, 17 Dec 2025 09:52:21 -0500
X-MC-Unique: 6oC_RDV8P1W5w2IO8I8_HQ-1
X-Mimecast-MFC-AGG-ID: 6oC_RDV8P1W5w2IO8I8_HQ_1765983140
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430f4609e80so2461534f8f.3
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 06:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765983140; x=1766587940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gL5F3xHBPmKGkcE8K+DR/FS+dwcTcYAQDkDaOW4jcUU=;
 b=D2MiQMtDTv0iwgxR/tULUkLA1KKOj6amTTt698ck2b9uXPSHJhWwWovnF1QD7a9ldu
 v36vfxmSwGQ+bYsopXRlbGMDvvRrAna3cNH6+oucuYYg5+tWoHpmV82UV5y1+135ouLN
 Mp/2MkcqYGd8JJmzQsio9cYVs/MVfwC/WoobB8CAyIMeJGAY+bjFKC4Mj8sv05e/BNPa
 QLuApBZzn+wSTgXui0o2wp2kzJZ1YIQpjOh8ndGgbFMZN04xdjOSGVjUsnNtYJq/vOxA
 xO36sZ9eIHMIbdrh6V9ik2t1mhBDPLAHfOEtsv9KtzaS1gKkDpSSuyntsmfKCPRhU2vW
 ZStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765983140; x=1766587940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gL5F3xHBPmKGkcE8K+DR/FS+dwcTcYAQDkDaOW4jcUU=;
 b=L49GcU3GiyZ1awER6fTGEoW1sT/S/MPpCj5AEUMt/tupNrTO+z3GBQH7yEN3+jTMnt
 7tTFQw69LccpsLZNnxJuL0suIZY/K1H4OxZtkfhWTrFB1oEgAYUVtRKHIGE8BiosMRUs
 QqSJ4EawZDZNjGyJviPU/nYwDb2nucOBoDCZoryZ5jHyFb1zXtuZOYKH/w1a3wejnhgP
 f6SNmcCo47S6S09BRVZ77Y67IBGjJwZz9pcYksC3XzHuTPqbAnJmI+QFpEiiogC2wGB9
 T7uIKW2F83bHUE1ZP+j7o1xkYCDdldce2pxFco7955b9mXRcV/O/YVDqaeFQvenKL4O3
 Q+Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcvBQzrXFHKLiv44s3oMPd12cBaklmO1QV1uuOClVL5CuyY9bianGCCduIkCMZRzzVX7nMV3K7QURx@nongnu.org
X-Gm-Message-State: AOJu0YxCzUpX379Dbk5Dh1ezfnG+PumymW3109BDGyPgWRAxar9gX/VW
 aBXg03GpGI19WyCkhvK75sG1YUtwvmiIIW6wPK8FWQHnlRSJISePd51N58CthFrfFf1qypP6Ymu
 sPeP3F6vtsdMWq6Lxd29Ku8EqbmexFd2wSAOoMlhy0E9u0aqDhEXzaJcJ
X-Gm-Gg: AY/fxX4K1iJZOnjqOnlpJ3XKDiuLlgi7rKqn6316bKfp1+8ZHtce8RDk/Af5N0F1UbE
 /5EUHrD+bjUkx/287lQexmt7UTiuMf8mk+/knZiFX+rPUtB18DWqOt4n/+vcgYIMhyquV5h5LfK
 5fFmcr4p0OMdAzLP/E0KVydUl3FKltixuS1+lqHk+lvOQVEClPOBMMNCfngAMqhyECBeNE3f7Lf
 FU228HFepJty9cysd2yHBhrOTSIqqc9RzSJ2Rm1YgCcbWVMhrnnkQLcdnCilcyunowdSITkT460
 Gm0PCh09PmI0JkMfDJj1s+3SilGilW2ZcmkTBanqgZmDPOssZjkbVD9rhK9LI/9Wlp+J5w==
X-Received: by 2002:a05:6000:178e:b0:430:f449:5f18 with SMTP id
 ffacd0b85a97d-430f44963b3mr14983559f8f.46.1765983140144; 
 Wed, 17 Dec 2025 06:52:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+T+nY6wdecLEHnqIBz7uHvoT/b3jDw2zvtR6NcYuLs8ihAOzxrKiDhxv5l3pTSsf/IxR8dQ==
X-Received: by 2002:a05:6000:178e:b0:430:f449:5f18 with SMTP id
 ffacd0b85a97d-430f44963b3mr14983519f8f.46.1765983139554; 
 Wed, 17 Dec 2025 06:52:19 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4310adeee0esm5283851f8f.29.2025.12.17.06.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 06:52:19 -0800 (PST)
Date: Wed, 17 Dec 2025 15:52:14 +0100
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
Subject: Re: [PATCH v5 15/28] hw/i386: Assume fw_cfg DMA is always enabled
Message-ID: <20251217155214.71be5008@imammedo>
In-Reply-To: <20251202162835.3227894-16-zhao1.liu@intel.com>
References: <20251202162835.3227894-1-zhao1.liu@intel.com>
 <20251202162835.3227894-16-zhao1.liu@intel.com>
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

On Wed,  3 Dec 2025 00:28:22 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>=20
> Now all calls of x86 machines to fw_cfg_init_io_dma() pass DMA
> arguments, so the FWCfgState (FWCfgIoState) created by x86 machines
> enables DMA by default.
>=20
> Although other callers of fw_cfg_init_io_dma() besides x86 also pass
> DMA arguments to create DMA-enabled FwCfgIoState, the "dma_enabled"
> property of FwCfgIoState cannot yet be removed, because Sun4u and Sun4v
> still create DMA-disabled FwCfgIoState (bypass fw_cfg_init_io_dma()) in
> sun4uv_init() (hw/sparc64/sun4u.c).
>=20
> Maybe reusing fw_cfg_init_io_dma() for them would be a better choice, or
> adding fw_cfg_init_io_nodma(). However, before that, first simplify the
> handling of FwCfgState in x86.
>=20
> Considering that FwCfgIoState in x86 enables DMA by default, remove the
> handling for DMA-disabled cases and replace DMA checks with assertions
> to ensure that the default DMA-enabled setting is not broken.
>=20
> Then 'linuxboot.bin' isn't used anymore, and it will be removed in the
> next commit.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes since v4:
>  * Keep "dma_enabled" property in fw_cfg_io_properties[].
>  * Replace DMA checks with assertions for x86 machines.
> ---
>  hw/i386/fw_cfg.c     | 16 ++++++++--------
>  hw/i386/x86-common.c |  6 ++----
>  2 files changed, 10 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index 5c0bcd5f8a9f..5670e8553eaa 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -215,18 +215,18 @@ void fw_cfg_build_feature_control(MachineState *ms,=
 FWCfgState *fw_cfg)
>  #ifdef CONFIG_ACPI
>  void fw_cfg_add_acpi_dsdt(Aml *scope, FWCfgState *fw_cfg)
>  {
> +    uint8_t io_size;
> +    Aml *dev =3D aml_device("FWCF");
> +    Aml *crs =3D aml_resource_template();
> +
>      /*
>       * when using port i/o, the 8-bit data register *always* overlaps
>       * with half of the 16-bit control register. Hence, the total size
> -     * of the i/o region used is FW_CFG_CTL_SIZE; when using DMA, the
> -     * DMA control register is located at FW_CFG_DMA_IO_BASE + 4
> +     * of the i/o region used is FW_CFG_CTL_SIZE; And the DMA control
> +     * register is located at FW_CFG_DMA_IO_BASE + 4
>       */
> -    Object *obj =3D OBJECT(fw_cfg);
> -    uint8_t io_size =3D object_property_get_bool(obj, "dma_enabled", NUL=
L) ?
> -        ROUND_UP(FW_CFG_CTL_SIZE, 4) + sizeof(dma_addr_t) :
> -        FW_CFG_CTL_SIZE;
> -    Aml *dev =3D aml_device("FWCF");
> -    Aml *crs =3D aml_resource_template();
> +    assert(fw_cfg_dma_enabled(fw_cfg));

this was supposed to be machine agnostic, but given that it only used by x86
it shouldn't cause issues, so

Acked-by: Igor Mammedov <imammedo@redhat.com>


> +    io_size =3D ROUND_UP(FW_CFG_CTL_SIZE, 4) + sizeof(dma_addr_t);
> =20
>      aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0002")));
> =20
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index 1ee55382dab8..e8dc4d903bd6 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -1002,10 +1002,8 @@ void x86_load_linux(X86MachineState *x86ms,
>      }
> =20
>      option_rom[nb_option_roms].bootindex =3D 0;
> -    option_rom[nb_option_roms].name =3D "linuxboot.bin";
> -    if (fw_cfg_dma_enabled(fw_cfg)) {
> -        option_rom[nb_option_roms].name =3D "linuxboot_dma.bin";
> -    }
> +    assert(fw_cfg_dma_enabled(fw_cfg));
> +    option_rom[nb_option_roms].name =3D "linuxboot_dma.bin";
>      nb_option_roms++;
>  }
> =20


