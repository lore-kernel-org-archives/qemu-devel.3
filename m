Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963A9D41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 09:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV5CH-0005Ah-6p; Mon, 15 Dec 2025 04:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vV5CB-0005A9-H8
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 04:48:48 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vV5C7-0001oL-KB
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 04:48:46 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so36995315e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 01:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765792120; x=1766396920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SAx3ENHaV9JRcdq0peONXwra7099CJO3M9OJCqRp4S8=;
 b=OIkFNG/c0VUTUO9vW57AH09ZZGARbiREE3pCG0LWV2AxeVdbFq0kzgbmeWGcs7zXZX
 SkKngctqj6VuG/gv/imDDqzrD5R/LwDJfpWqMHnMP+NFiN0x9GtZoE7Vo/s22D42SQ16
 cqX9c2HUNn2AkQ+Zd/QVwHxRd/qvFd2Mihpqets6D81qhTYJ+HDwmxGYWiv/ydyHXoig
 MFIpAbDL4p8+mSb0GzpU4XoYvVGQxQ+pkR3eZWUUSQZNPjOvM579OdT8E7F0aCBmT5qF
 /15/1hcybZU4DhyCUcpUPVGpRC62mPH3bfXXjPyf+gi2VP7P3j4+xvlRHmOE9J4KhJfp
 TOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765792120; x=1766396920;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SAx3ENHaV9JRcdq0peONXwra7099CJO3M9OJCqRp4S8=;
 b=junHZpc8n9wJa6SG6gX/kt4KHAPf5Kg6miy5cKwTkKoNayUbuUKwrfxw99k6/ApvYK
 3dU/6qtkyQNr66pwAqnfDA2mwXOqz8GY4wYNrzzJmRiR44aF5TIXA/7/AfIwSVU58XjB
 ZvIdzbUCoL8K1YJichAsNBCW0xcTEwDgnqMzxnC9H4I6hZiIX6V3zv7R2H2Fu8/5NI8Z
 epmnxjMqJ+xiMYJG3ih4B/gzLFlkF9/UuG0L4J1kq7hyIKVWedC0aF/zleB8rtqySAd2
 IH2Zff3G+Jilgj3Bu8+0A5MK080jMSsBLhboYYWYhDtniXUHrstmRsMdS5Zh8yBMd/lm
 1H9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD3mgBWhpAQzqrd8s8JCTWgGBvCvZLIlqCk/kZ7lCLWo2xMFtGgHSxDCDQIakseUrGWQqijX3OwUcX@nongnu.org
X-Gm-Message-State: AOJu0YylN/Qu6tuFEQJI9qWUenySKlrowutq6sksnnpi/WHTtTN2DglQ
 1K4mAYYx3w/keCvulG4kH0GnFuer9SnrBYs5RYcRcPnmpHxf4Zvf6YM5S9VxfzA3jkY=
X-Gm-Gg: AY/fxX6rtkzmKy3/H9CtvIeMUfR2u1pLz9Zu3Eh28aDKTwuRx3MR6tMvWrOBH0FCTwc
 THTYmjQbXE73Ec2y+jPUW9WCNu0CWXk6f5WupiFvqRGi+GLeni3sszBaCO87ZFknqGZhP5D4M9E
 XFR053h5pmUaLHXfbeYnPejdHfQpELuiUUepO9kNOK7gTBImF3BCp+2i9zuB9/HyFaWLe4TChvh
 Pka7BDRo5pPHs/PdxuubrXWCSUyHGS723LQuAHEWpU7sDWAn3auM/I5ckKC6tAWep3M2E0+hs4n
 i2JFPUyTdtI3Vpm6Ye8vmGUnZWxCYbNjU+mA68tawP4swoT9fVPIC2vhUUg8XvOQP6ycCVkjt4t
 ryKvsA+mktpf+81e8XExKi7M7VNBpSKj53wvNBt01y/ZmxNejHJ5BIsWYTnJs5mB+qK9J35k7xP
 rHVEFju+94dBk=
X-Google-Smtp-Source: AGHT+IGbjRoFCjMvOeGXu9RK0gRf9Ijwuald6ht6i+Npc7dk1q3jzJElM+UQai3QIsIybXRrn5wOLg==
X-Received: by 2002:a05:600c:8b16:b0:477:7975:30ea with SMTP id
 5b1f17b1804b1-47a8f90e81fmr110425585e9.29.1765792119940; 
 Mon, 15 Dec 2025 01:48:39 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-430f6e78a7csm10539636f8f.34.2025.12.15.01.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 01:48:39 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 719E95F7F9;
 Mon, 15 Dec 2025 09:48:38 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Marc Morcos <marcmorcos@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Markus
 Armbruster <armbru@redhat.com>,  Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org,  kvm@vger.kernel.org
Subject: Re: [PATCH 1/4] apic: Resize APICBASE
In-Reply-To: <20251213001443.2041258-2-marcmorcos@google.com> (Marc Morcos's
 message of "Sat, 13 Dec 2025 00:14:40 +0000")
References: <20251213001443.2041258-1-marcmorcos@google.com>
 <20251213001443.2041258-2-marcmorcos@google.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Mon, 15 Dec 2025 09:48:38 +0000
Message-ID: <875xa8nki1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Marc Morcos <marcmorcos@google.com> writes:

>  APICBASE is 36-bits wide, so this commit resizes it to hold the full dat=
a.
>
> Signed-off-by: Marc Morcos <marcmorcos@google.com>
> ---
>  hw/intc/apic_common.c           | 4 ++--
>  include/hw/i386/apic_internal.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> index ec9e978b0b..1e9aba2e48 100644
> --- a/hw/intc/apic_common.c
> +++ b/hw/intc/apic_common.c
> @@ -233,7 +233,7 @@ static void apic_reset_common(DeviceState *dev)
>  {
>      APICCommonState *s =3D APIC_COMMON(dev);
>      APICCommonClass *info =3D APIC_COMMON_GET_CLASS(s);
> -    uint32_t bsp;
> +    uint64_t bsp;
>=20=20
>      bsp =3D s->apicbase & MSR_IA32_APICBASE_BSP;

This seems overkill for something considering MSR_IA32_APICBASE_BSP is a
single bit (1<<8) and the reset never overflows as APIC_DEFAULT_ADDRESS
is within the 32 bit range.

>      s->apicbase =3D APIC_DEFAULT_ADDRESS | bsp | MSR_IA32_APICBASE_ENABL=
E;
> @@ -363,7 +363,7 @@ static const VMStateDescription vmstate_apic_common =
=3D {
>      .post_load =3D apic_dispatch_post_load,
>      .priority =3D MIG_PRI_APIC,
>      .fields =3D (const VMStateField[]) {
> -        VMSTATE_UINT32(apicbase, APICCommonState),
> +        VMSTATE_UINT64(apicbase, APICCommonState),

Changing this is problematic as you now have to deal with migration
between older and current QEMU's.

>          VMSTATE_UINT8(id, APICCommonState),
>          VMSTATE_UINT8(arb_id, APICCommonState),
>          VMSTATE_UINT8(tpr, APICCommonState),
> diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_inter=
nal.h
> index 4a62fdceb4..c7ee65ce1d 100644
> --- a/include/hw/i386/apic_internal.h
> +++ b/include/hw/i386/apic_internal.h
> @@ -158,7 +158,7 @@ struct APICCommonState {
>=20=20
>      MemoryRegion io_memory;
>      X86CPU *cpu;
> -    uint32_t apicbase;
> +    uint64_t apicbase;
>      uint8_t id; /* legacy APIC ID */
>      uint32_t initial_apic_id;
>      uint8_t version;

I'll defer to the x86 experts here but perhaps an alternative would be
to clamp kvm_apic_set_base() which seems to be the only place where you
can set it and not get clamped like in apic_set_base()?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

