Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C223FD3C907
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 14:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKlM-00051G-On; Wed, 10 Dec 2025 09:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vTKku-0004yW-0M
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:01:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vTKkr-0006iA-V8
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765375280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j6O14IgCI996JZsx0l90XqR/9ZXCFZHWkgAIKqs9gec=;
 b=PlsiKOULTdyX6/7GeHXgMiiAlRWNHoeL8LNoxa4gBYbMgsDYSEwnNHW/bJl7yr4Izf9jrq
 YMbxsCwgdcRAxa7YalFIGW9vuD7w1CRjstCUx8Etm7vkyc5q3HWKy/6+umtZWFHthpcREy
 zSQFjEJ53jaFXccW7KU7r4DifM7nnlk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-P1TATcuDPHK5_a4mUQGAnw-1; Wed, 10 Dec 2025 09:01:19 -0500
X-MC-Unique: P1TATcuDPHK5_a4mUQGAnw-1
X-Mimecast-MFC-AGG-ID: P1TATcuDPHK5_a4mUQGAnw_1765375278
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47775585257so44704185e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 06:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765375278; x=1765980078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6O14IgCI996JZsx0l90XqR/9ZXCFZHWkgAIKqs9gec=;
 b=rMN9nsOCJJGk4fY1tpQ0jbCbrznyiYwyVvhnNJ8X9mhIB7/dkMWqP8EIm9Ezej1FJn
 E6b0+VfS6bAgHdFf/+VVQRmFB/80Zzr0uZw56NgnHgdyIfP1lN2SOHQ1/OvSUC9q8n2G
 1FlcLagO3HCCS27tSeg299qzPRCRbx2y9eIOR45ToS/I+huH+McVU9yCpEcu5iiwGGrB
 uHHNwfD9VcZx8Cu6oblKaF4dYmioy45LbRGmeHPQOfPLTmriZeYwbYHTWWSIkz8tPyCP
 wlNZWGoviL05jrhhbFJCZXsuAha34IamqARTw8MWzW3SGnpCfTpqQhcCMpZUE/Ti1iu8
 oMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765375278; x=1765980078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j6O14IgCI996JZsx0l90XqR/9ZXCFZHWkgAIKqs9gec=;
 b=uXoiVWz3elxSyDD9E0QE1m19S0/TwWFti9bDU9GoLYgWVJSv3POTQCu4RXOxqltgcq
 aedFqUKv12QJYQry41+1hd3wqFZcLSn1lwWu/Ig2wouVTny9S0bt8ghiOgo6sp5NtRxt
 rEpCmxiJVS+SExrKFTOcq+pCGRQ2bi+2mxcorNIL8i0g4l0hXn/GIKP1Twv41xN0kgZv
 mj/Ug4Qp6XCoME9JVawQhzbSNRDdrA/H46MMMWW8oyfIltnMfCpM2amScUIDRNrvKsVU
 JLd2qhELgS2l0bgG4p3itLVEP76bd7KAVlKQSZZhiI7MtKeImch3dj8Fuv49oSAk+Yqi
 mJrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqC3KGdF1HuEuz7Zi/4QTFnLdb/UnPpsBIbzOmZWsFBpnA+hhfIlnupuS0291NOrrlFJasSa57jezT@nongnu.org
X-Gm-Message-State: AOJu0Yy4xyQPcqfkWOPdsiUUjbWg/v0gPbB5k3ltZKLlaf1nvxCkNWp6
 U78OTVFg1/kRipo+uH0+NjZz5HvEw5CfGvmGBour0rJT5cDwm74OggLJgIBBm3vcDgpZmuQT8tW
 b9XE69AdZuN2/AE/orzBo6lFnzoe28S8dRT5CKroZy0mbnh7Bepf13wJ3
X-Gm-Gg: ASbGncvG79XErsqgSJ/1Ludi1IXGvvuXwDXBzn1bRDTj9EBlTWrQ8j9D+DfhM+2gJ1l
 1NZ25wdkyHfZoPNiRDiu7jyF1o6D9b+FF+CT9JihbGB0+4KU+XQCs8Tn0Qahj22CUCyXVU630U0
 OvQIY02FJ43aCxR0qMKUnA0Oplxe0CouHemwcW9fbEudpiDujYxgNgyiBDIJ/4oohYblvJ0MlqC
 IFtI5Ss02SoyLdB+4qBVsn6bhCLqlSBczbeIbC22iEwN/o4Pi2FaoNao0K66VFGfXen08cRHvXJ
 zGOvnMFhfLy3FUgcSf4RJaYdzy8+O7jJAI2yYm3zHVjSoftOXEm89sbDc+hycS+TETkJMw==
X-Received: by 2002:a05:600c:3113:b0:477:7768:8da4 with SMTP id
 5b1f17b1804b1-47a856249c2mr13338545e9.7.1765375278089; 
 Wed, 10 Dec 2025 06:01:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFj/M79GqEHYM3DvJC6z3KKGc/jcvumRsPxQHknr/rdPhfB8kOLZa6+TISA54HNeWcCceufRw==
X-Received: by 2002:a05:600c:3113:b0:477:7768:8da4 with SMTP id
 5b1f17b1804b1-47a856249c2mr13337925e9.7.1765375277520; 
 Wed, 10 Dec 2025 06:01:17 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d9bec74sm44288345e9.8.2025.12.10.06.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:01:16 -0800 (PST)
Date: Wed, 10 Dec 2025 15:01:15 +0100
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
Subject: Re: [PATCH v5 01/28] hw/i386/pc: Remove deprecated pc-q35-2.6 and
 pc-i440fx-2.6 machines
Message-ID: <20251210150115.5f9dc169@imammedo>
In-Reply-To: <20251202162835.3227894-2-zhao1.liu@intel.com>
References: <20251202162835.3227894-1-zhao1.liu@intel.com>
 <20251202162835.3227894-2-zhao1.liu@intel.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed,  3 Dec 2025 00:28:08 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>=20
> These machines has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") they can now be removed.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc_piix.c | 14 --------------
>  hw/i386/pc_q35.c  | 14 --------------
>  2 files changed, 28 deletions(-)
>=20
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 7b3611e973cd..4628d491d5b5 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -733,20 +733,6 @@ static void pc_i440fx_machine_2_7_options(MachineCla=
ss *m)
> =20
>  DEFINE_I440FX_MACHINE(2, 7);
> =20
> -static void pc_i440fx_machine_2_6_options(MachineClass *m)
> -{
> -    X86MachineClass *x86mc =3D X86_MACHINE_CLASS(m);
> -    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> -
> -    pc_i440fx_machine_2_7_options(m);
> -    pcmc->legacy_cpu_hotplug =3D true;
> -    x86mc->fwcfg_dma_enabled =3D false;
> -    compat_props_add(m->compat_props, hw_compat_2_6, hw_compat_2_6_len);
> -    compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
> -}
> -
> -DEFINE_I440FX_MACHINE(2, 6);
> -
>  #ifdef CONFIG_XEN
>  static void xenfv_machine_4_2_options(MachineClass *m)
>  {
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 6015e639d7bc..0ae19eb9f1e4 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -681,17 +681,3 @@ static void pc_q35_machine_2_7_options(MachineClass =
*m)
>  }
> =20
>  DEFINE_Q35_MACHINE(2, 7);
> -
> -static void pc_q35_machine_2_6_options(MachineClass *m)
> -{
> -    X86MachineClass *x86mc =3D X86_MACHINE_CLASS(m);
> -    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> -
> -    pc_q35_machine_2_7_options(m);
> -    pcmc->legacy_cpu_hotplug =3D true;
> -    x86mc->fwcfg_dma_enabled =3D false;
> -    compat_props_add(m->compat_props, hw_compat_2_6, hw_compat_2_6_len);
> -    compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
> -}
> -
> -DEFINE_Q35_MACHINE(2, 6);


