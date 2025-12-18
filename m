Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEDBD6D22A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 14:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWEcZ-0003E7-0E; Thu, 18 Dec 2025 09:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vWEcX-0003Dg-ME
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 09:04:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vWEcW-0006KN-44
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 09:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766066683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZa/LONa7ZGo/OqCKXVn4+AcaCSwo5WF//FIZlqUxgs=;
 b=XE1+dnErLjsbpLNK5qMOsTTDC+yNMwO7oY6zWgRYEd5H17j84moFAZjzrHxChayDK4Ub75
 3EIpP5loU1y3zd+JLol9RHaP/cJ1OH5oBqx2JNA70vsxC3/kM6VdbQgiO4Xt//7MxY1H0x
 hIqyIbC5ekONnJeRfaIzdRLiaswOFFM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-Iwpo7aMNNUK192lfysg5Jw-1; Thu, 18 Dec 2025 09:04:41 -0500
X-MC-Unique: Iwpo7aMNNUK192lfysg5Jw-1
X-Mimecast-MFC-AGG-ID: Iwpo7aMNNUK192lfysg5Jw_1766066681
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430ffa9fccaso591147f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 06:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766066680; x=1766671480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZa/LONa7ZGo/OqCKXVn4+AcaCSwo5WF//FIZlqUxgs=;
 b=kSnPBo2H4z4N3TpBphF6AvWe0oMOj0FRdtniIudDBZxJH3/RoROXl9xlL/4JkL2ift
 t5i+ZKPrnGGeFMB8Jg+fO487NN3I3mSKCjhIdcqtAFGOuKTux5y//Qu3nINphy8ZhgNc
 kg1HBMMGIYcJUCgWsi9W31/LFwQztvk+Gk4OZIC0sfQaCN3Nm4CpiXPbJ33tCR0OeswG
 oyR1FxFPJgr6rE76fdgcY60s6+m4ZP3Zgn6y9iYx+2A7ownn33LsNncftcVRrIs55OeP
 ypPZfzzT7Ijl7p+2OLz9BJPMqn4CPZgBoNRkMoOZFOgqdC8pECgUlpKwv1Z3hZ5l3hBx
 cTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766066680; x=1766671480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LZa/LONa7ZGo/OqCKXVn4+AcaCSwo5WF//FIZlqUxgs=;
 b=XqX6apbUb2x6OJ4a77tA951kM/0CrW3E0SEYr+0Ls+/5bQ/FUv4L9943EjGMfQo+NX
 xVy0qMZSO6Ajx4YcBD+RIVXfTo5L8EchODMQLkkAJ6UJOWej0VbkwojBiFfMuX8pd5Dy
 P0mE3D5FiXd9Z/VpLSh+WuAd7LMoCxd0zG0TNsSh53KMljfoTvSJpjwQKwtI64VDOVVm
 xmeZLw2KRMP/WW8bnVdeMI8/M09XNHsQpxrcQLx/kgoL1jYRaQfiwuNpS0Tnlm5oUSWL
 kdMGngt63sf+f65Ts5etLFHjsoGen2eKZ/3hUXThf52EBuUbidtOF/ExGhAh9iU0pRBK
 TA3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkIBA2pVFq7xP0Jh2WeBNsOa4aZKNOantZdfwBohRnju0YlPLnjypRKb9S2Ks3aWczCNHhSGErILyt@nongnu.org
X-Gm-Message-State: AOJu0Yz3Jbe0u6S8B7jcxdQGpI+4SxnALAx6XSGWbq2zKljYaZHBTVBR
 u7030kFv4o7L+R+xBqKKkjPOs4ebjkpBejNI+pFT+QNAcW2izn5FnbZxsloOX4X+Noi3jyv9nBi
 XNkupiqGJRk5xr0/IfIjMuOg+x17tpkqRhOtdJPwxNrs8RR/xdp6nYF6D
X-Gm-Gg: AY/fxX40/6dp/qJphUbfcQn0Vee5G58g1ER7CSrSkYg4im/Y9HkabDAO6WsU/AYYfX9
 02+hFBpGBc7fwZhjXnmVB/TzpnkWL9lgprV/8KdRs2H60ZSF6ColhWvU8Qxi/ygfIo+LrRwrzAt
 JEkvsL4pz5cY3MNt+0aZS3hwG5Ol283I6hizdzRVdVAYO/oNnDS2rUwyC36StXkNi4q0Qq5RMke
 harEpnUY0vn2qVNNMWQQvui1/+7JljATfHA7XZDtV0FMm9Kjv4aZrOPqb8EgE8RlTQjz/fF1cCY
 bkl2F73P8RIhdWblNYbTxqc8TG7Dik6J/p2JM84IVkGO6JfXmm5TY9ziSEJcF7PjNVnBLQ==
X-Received: by 2002:a05:6000:4024:b0:431:35a:4a8f with SMTP id
 ffacd0b85a97d-431035a4cdbmr13030554f8f.47.1766066680417; 
 Thu, 18 Dec 2025 06:04:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5sI4sfzxmpDw2vWdy5N6JNiW5EGUAYBc3RmsncYQrOquL+EF//rXIjYGO/naLgvGUOz66hg==
X-Received: by 2002:a05:6000:4024:b0:431:35a:4a8f with SMTP id
 ffacd0b85a97d-431035a4cdbmr13030504f8f.47.1766066679952; 
 Thu, 18 Dec 2025 06:04:39 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43244998c8asm5391292f8f.30.2025.12.18.06.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 06:04:39 -0800 (PST)
Date: Thu, 18 Dec 2025 15:04:36 +0100
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
Subject: Re: [PATCH v5 25/28] hw/core/machine: Remove hw_compat_2_7[] array
Message-ID: <20251218150436.5bb926cc@imammedo>
In-Reply-To: <20251202162835.3227894-26-zhao1.liu@intel.com>
References: <20251202162835.3227894-1-zhao1.liu@intel.com>
 <20251202162835.3227894-26-zhao1.liu@intel.com>
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

On Wed,  3 Dec 2025 00:28:32 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>=20
> The hw_compat_2_7[] array was only used by the pc-q35-2.7 and
> pc-i440fx-2.7 machines, which got removed. Remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/core/machine.c   | 9 ---------
>  include/hw/boards.h | 3 ---
>  2 files changed, 12 deletions(-)
>=20
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 0b10adb5d538..f3e9346965c3 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -281,15 +281,6 @@ GlobalProperty hw_compat_2_8[] =3D {
>  };
>  const size_t hw_compat_2_8_len =3D G_N_ELEMENTS(hw_compat_2_8);
> =20
> -GlobalProperty hw_compat_2_7[] =3D {
> -    { "virtio-pci", "page-per-vq", "on" },
> -    { "virtio-serial-device", "emergency-write", "off" },
> -    { "ioapic", "version", "0x11" },
> -    { "intel-iommu", "x-buggy-eim", "true" },
> -    { "virtio-pci", "x-ignore-backend-features", "on" },
> -};
> -const size_t hw_compat_2_7_len =3D G_N_ELEMENTS(hw_compat_2_7);
> -
>  MachineState *current_machine;
> =20
>  static char *machine_get_kernel(Object *obj, Error **errp)
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 5ddadbfd8a83..83b78b35f2bf 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -879,7 +879,4 @@ extern const size_t hw_compat_2_9_len;
>  extern GlobalProperty hw_compat_2_8[];
>  extern const size_t hw_compat_2_8_len;
> =20
> -extern GlobalProperty hw_compat_2_7[];
> -extern const size_t hw_compat_2_7_len;
> -
>  #endif


