Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9480EC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEONt-0007m8-1w; Mon, 12 May 2025 04:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uEONg-0007gq-KL
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uEONd-00087u-L1
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747037958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2fvSZBSz7SW+rN/UmgDYVlAuf9XOlhIq2nJC4JEI3cs=;
 b=BJ9V0/OMdwJUs5GDKQuX1TO8YIEiDxkd5hDcGN6/JnQCIQX3fDjTdoD8wx5eG4IHcXAb5L
 ZcuDZNlxjRO9KDm8EtZBMYv9pkjrstYGrXxVZABpjQ63kigq8ozM/KLjoggeVxIwTzp+El
 XiMhUNVPrHcSbVdcp3N+m117ZDOvNWM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-qYPI1ncuMoWSmGDKD3Xmfw-1; Mon, 12 May 2025 04:19:16 -0400
X-MC-Unique: qYPI1ncuMoWSmGDKD3Xmfw-1
X-Mimecast-MFC-AGG-ID: qYPI1ncuMoWSmGDKD3Xmfw_1747037955
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a0b9bbfa5dso1340479f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747037955; x=1747642755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2fvSZBSz7SW+rN/UmgDYVlAuf9XOlhIq2nJC4JEI3cs=;
 b=SoIdbY6tXQ4cSVE6vdypF7bJXPgMPTqcPEHh6lWVmfTYRTZz8cY0zrn0xgAc5OOApT
 4TGXRWBCLT/42KcRD43rlswxdLVbI1nJFg8TA0DZo0y8tKL5EKtBAZb6ezNbDLw2+X0H
 WY/WKTUoBQxv9unx08Ioci2f7P+p0soFEC1UrC8wVhoItCl9RAnvLMui6FWH4lgee2Xo
 rrbmvVvSMALSPXax7oSJsRhKSntySkydLYCp/li6hs12EtzPIzjy2f8IgJsU9LyjzyWT
 saHMJz9X94iUn87cjtoQ/rKJW8fYdelz5qhkFB1+tENtKdw7inZNIN4kDiDB4R/zDBmn
 MhCg==
X-Gm-Message-State: AOJu0YzASKjtjrebQzaOJVZJGG5+Lbh1s2904lLQxfdJ9C6ju+a+WACe
 UAajuJ4ZpSSJWWK40uXyDMfFpxHZyqF2zryu4HK0fMgcmJ52/qsMxvmFQiB7129PV2Dhll4sqGJ
 qNbuS9MZbW5ZuK1eircXHJIeq8k8OTmcDuI7OhbrRhg+OlMleGoI9
X-Gm-Gg: ASbGncs/KCPrVYdfSTEC2whENkAugF/iOaSzUjbVGYKuBhB1sQ87MKH6N1dJZJfv3AL
 5rLZKnoTC584cZm+XTFtIvoQMdzjVMI8lxenSMZzC5FfaDr7OPHzUz7hWrqqx3Js4tNVnoEuZt2
 A151DgiGwsXHQ5E01LbloL2LCaHF88V8ZjjB1059789ld31ER1Mv7oC7myr9f13xejBjnaZnk4U
 LUMuFVejuEK2CHqDUD1M5Py/0a8qxbNeYPQ835i3sooGfk1QOTLh0hCpBS+CmTa/a70m4XUmxS6
 /V9VXBU8Uqn2SfF7csoFO8vhBNU9hefb
X-Received: by 2002:a05:6000:401e:b0:3a0:aee0:c647 with SMTP id
 ffacd0b85a97d-3a1f64374e1mr9506406f8f.17.1747037955348; 
 Mon, 12 May 2025 01:19:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgHeilnFjVtlzQeFAWYCb/Ncwx/SQ6IkBm/EN6BrcPThYXSIr2QrCJWo6KgNXFdjoS9BV4Tg==
X-Received: by 2002:a05:6000:401e:b0:3a0:aee0:c647 with SMTP id
 ffacd0b85a97d-3a1f64374e1mr9506370f8f.17.1747037954950; 
 Mon, 12 May 2025 01:19:14 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d6858626sm118499335e9.27.2025.05.12.01.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 01:19:14 -0700 (PDT)
Date: Mon, 12 May 2025 10:19:12 +0200
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
Subject: Re: [PATCH v4 11/27] hw/i386/pc: Remove pc_compat_2_6[] array
Message-ID: <20250512101912.6900beaf@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250508133550.81391-12-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-12-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu,  8 May 2025 15:35:34 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The pc_compat_2_6[] array was only used by the pc-q35-2.6
> and pc-i440fx-2.6 machines, which got removed. Remove it.

see my comment in 1/27

>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  include/hw/i386/pc.h | 3 ---
>  hw/i386/pc.c         | 8 --------
>  2 files changed, 11 deletions(-)
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index a3de3e9560d..4fb2033bc54 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -292,9 +292,6 @@ extern const size_t pc_compat_2_8_len;
>  extern GlobalProperty pc_compat_2_7[];
>  extern const size_t pc_compat_2_7_len;
> =20
> -extern GlobalProperty pc_compat_2_6[];
> -extern const size_t pc_compat_2_6_len;
> -
>  #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>      static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
>                                                   const void *data) \
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 4e6fe68e2e0..65a11ea8f99 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -251,14 +251,6 @@ GlobalProperty pc_compat_2_7[] =3D {
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


