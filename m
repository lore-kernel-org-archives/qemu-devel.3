Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FEDC3ABD7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV1K-0005C2-8H; Mon, 12 May 2025 11:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uEV1I-00058r-Ad
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:24:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uEV1G-0005UF-ED
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747063481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uPxPAlbokCBFELfvxkftEEGEGO3nEqu1EeO7daiHGU=;
 b=QiM6zOCvn+gjK3h6rbADrk4chqyPE4rGjH6g9+UajnGUgkzP9Uv22tha0a8Xf7bd+dh+u7
 HUd+Rvp4/Jw8kG8FbivpEhpdjj2LW9WCh2shyWP5R+TEmjqFZD6mxCMxuZ5jo7JgoiUenE
 L7ojPFyzOm4C18ja4wg3oCH0r0GJ5BM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-CgnMmhI3MhOEhkBwcbKauw-1; Mon, 12 May 2025 11:24:40 -0400
X-MC-Unique: CgnMmhI3MhOEhkBwcbKauw-1
X-Mimecast-MFC-AGG-ID: CgnMmhI3MhOEhkBwcbKauw_1747063479
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a0b7ceaa20so1487599f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 08:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747063479; x=1747668279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0uPxPAlbokCBFELfvxkftEEGEGO3nEqu1EeO7daiHGU=;
 b=QId0r7FHyogpgVpbjHMBW13Khc2CQvEJtVnBknYvMnD2AFZrnT+gYEUArzqYAKeK+Y
 j3W6xXXYwmVPtCq8zGP5dfzcUQUHseYunoOlzwJr1seFeltRCdX6To5h/0KNfUB8UrzA
 9jHAH/7hJTBA7IvGPEOZPVi2TsBEj6ydPA4KpS+mGGkPVNEB5LnaYlNjzZ+NhqXxcuBA
 QebizoEcDOSbwdeCA4pxYtxuEwyJJQZmrGpZjUHRs/a4j3dsco/3scJhEUmg9OHp/Ayg
 10XfGKrkjMhkpryc7FaMVz41XwcRJF99pcc+Yjzc+diHEDsrAqhd7BncKkC5q2stNT2r
 U6+Q==
X-Gm-Message-State: AOJu0Ywn9diGhMLfoQappi5rVeLOi7A45NjdGLcT//UEHpz04NrhqKfQ
 9NzhTbCmoZDdwitFIjCMdWq5DtItHjH/auZ8zwKjjZ/3qwVVfaQqqIznx/YyHhLHoZnTlR1yszT
 MwtvtQJlUg22LRXsmQ0d5BxQJXRZA0uDxjgvSJXyKSxwJK9CfJEXf
X-Gm-Gg: ASbGncu3ZToZl7FHv8LlaqontJBIIaihesVOQw4QFfDL913U2y4eCE6l96K8oGrHTGS
 XV2nWpuPU9gSEjFy2lqMMRSLVJxJKmPYyN6xWZvIIyRTljV2gPkebr/zjLPXurCns4bNAXmTyc9
 POi7n+QPikEamikNrZ+cNy7HCvqK7jmsfXRrvJebOMG0l3tX215JnTdLOG9kzzX45+AYz+QoOHN
 gffwkXVpbxKtev2ao8ZzvbPSlIUFF3NRWF8DUCgAdNOFu5QuEyXozQj3uE+wwBljv6pj28Sk00z
 dSkmIGG9DEq10wR5dLU1XlbG3V39S4J3
X-Received: by 2002:a05:6000:1868:b0:3a0:b392:c2f with SMTP id
 ffacd0b85a97d-3a1f648782cmr10140794f8f.44.1747063479013; 
 Mon, 12 May 2025 08:24:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRwsDfeYtYF+7qmQcCxF1BK6h492q4dwhfvDuSeqqhilSyAsRupcamC17OhxBDNUZGCm4Q8g==
X-Received: by 2002:a05:6000:1868:b0:3a0:b392:c2f with SMTP id
 ffacd0b85a97d-3a1f648782cmr10140783f8f.44.1747063478678; 
 Mon, 12 May 2025 08:24:38 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3aeb26sm173676635e9.29.2025.05.12.08.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 08:24:38 -0700 (PDT)
Date: Mon, 12 May 2025 17:24:35 +0200
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
 Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4 13/27] target/i386/cpu: Remove
 CPUX86State::fill_mtrr_mask field
Message-ID: <20250512172435.6ad4cbbc@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250508133550.81391-14-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-14-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

On Thu,  8 May 2025 15:35:36 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The CPUX86State::fill_mtrr_mask boolean was only disabled
> for the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
> removed. Being now always %true, we can remove it and simplify
> kvm_get_msrs().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/i386/cpu.h     |  3 ---
>  target/i386/cpu.c     |  1 -
>  target/i386/kvm/kvm.c | 10 +++-------
>  3 files changed, 3 insertions(+), 11 deletions(-)
>=20
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 06817a31cf9..7585407da54 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2253,9 +2253,6 @@ struct ArchCPU {
>      /* Enable auto level-increase for Intel Processor Trace leave */
>      bool intel_pt_auto_level;
> =20
> -    /* if true fill the top bits of the MTRR_PHYSMASKn variable range */
> -    bool fill_mtrr_mask;
> -
>      /* if true override the phys_bits value with a value read from the h=
ost */
>      bool host_phys_bits;
> =20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 6fe37f71b1e..fb505d13122 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8810,7 +8810,6 @@ static const Property x86_cpu_properties[] =3D {
>      DEFINE_PROP_UINT32("guest-phys-bits", X86CPU, guest_phys_bits, -1),
>      DEFINE_PROP_BOOL("host-phys-bits", X86CPU, host_phys_bits, false),
>      DEFINE_PROP_UINT8("host-phys-bits-limit", X86CPU, host_phys_bits_lim=
it, 0),
> -    DEFINE_PROP_BOOL("fill-mtrr-mask", X86CPU, fill_mtrr_mask, true),

same as previous patch, deprecate 1st then remove

>      DEFINE_PROP_UINT32("level-func7", X86CPU, env.cpuid_level_func7,
>                         UINT32_MAX),
>      DEFINE_PROP_UINT32("level", X86CPU, env.cpuid_level, UINT32_MAX),
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index c9a3c02e3e3..87edce99e85 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -4635,13 +4635,9 @@ static int kvm_get_msrs(X86CPU *cpu)
>       * we're migrating to.
>       */
> =20
> -    if (cpu->fill_mtrr_mask) {
> -        QEMU_BUILD_BUG_ON(TARGET_PHYS_ADDR_SPACE_BITS > 52);
> -        assert(cpu->phys_bits <=3D TARGET_PHYS_ADDR_SPACE_BITS);
> -        mtrr_top_bits =3D MAKE_64BIT_MASK(cpu->phys_bits, 52 - cpu->phys=
_bits);
> -    } else {
> -        mtrr_top_bits =3D 0;
> -    }
> +    QEMU_BUILD_BUG_ON(TARGET_PHYS_ADDR_SPACE_BITS > 52);
> +    assert(cpu->phys_bits <=3D TARGET_PHYS_ADDR_SPACE_BITS);
> +    mtrr_top_bits =3D MAKE_64BIT_MASK(cpu->phys_bits, 52 - cpu->phys_bit=
s);
> =20
>      for (i =3D 0; i < ret; i++) {
>          uint32_t index =3D msrs[i].index;


