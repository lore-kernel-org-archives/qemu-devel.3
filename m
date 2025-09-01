Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450C0CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut20l-0008M9-S7; Mon, 01 Sep 2025 06:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut20k-0008Lq-Jo
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 06:43:42 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut20h-0007Kt-Qz
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 06:43:42 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-71d60157747so32112447b3.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 03:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756723414; x=1757328214; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rZ5RUoU+zgo8RlxpYoa2W3rVy6/6tax6/KyWZxnBNAc=;
 b=uvV2oCvNH/hO9BxkLcZdYgmrYPJxwkUxhu6sERamPt8XxSHaKJzeZ9fhXRnZoxK8kZ
 uoeIlkolvfpt9hRWGmcD/ZOq5arIFRaPsFim/OgKan5OZsc3AoSPiszRxhyvZpitezmv
 ZYfuY8R2OSzBrinw/q0KQTHM5qEluSK8bcHe2/PtHcPhYS0BmANGbUIki+dBSaHPt1IC
 U6RKWgqbVuJy+PPOsu7BbIudNfSEKWesNH5Z+w/OGRum+0rRHGB+I5OKFDBCyHPw3kW1
 WoeEa/91mPQrVF+RxC/Q6WY7tSE/yEQMWBDCPi9MfMVEBCCCxYFXaBVfWSUG/0hE0coE
 bYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756723414; x=1757328214;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rZ5RUoU+zgo8RlxpYoa2W3rVy6/6tax6/KyWZxnBNAc=;
 b=JsvWWTjB4ZmygmF5meN6f6eabrB/miA+qVq5ZTMluVGaICljjQ3ulAljeknsmHHk6K
 r4SZpC8weqWEykf2PqozdWyiBPX6RM1MDW6X3eWPwYwPtpJs1OtNvqFF+adj/1RlWPd7
 pMTRvx9sXyTnZTUjltpgnqvpLR7t4wTpIZbtFVJpKkeBunGBSR7IgJp3HZLAzULA+pIS
 KQhkzn5blAVP2Y5nWC/2Uw0WhpXqat1J7VixvXB+rR6VJSt62F2VEa0TcJClPrg39yTk
 IQ7ILn0QhR1nRvjgYfegTgdpxgIp/vo+zb4SYyR0f3wS5PS7POrOWF50Qu/3DBqmCNxz
 Fptg==
X-Gm-Message-State: AOJu0YwAD07GQGs2CD5NTXq8rfGlb54vl2fA11JMMeHhFhYWKQYwN6au
 aMs8q2WUXghrTwiDDpHeFRGfsRoLD+B3wuLJQ7mMWDyyl1nBhyHRwX49zEblQx9kALlpbApuuB4
 2OyI/ar9KVle+VxIbtG8YDv1ich1iTik9L4JpgSmF5Q==
X-Gm-Gg: ASbGncvUlPvj9NCUW2yXvMFU4/shvqg9Cr4vQyU9HvQzHkdj/+t4XHfDb4lRnorxS/x
 IeYbds/cFbo/SSDKF4BIs4es7f2kwMZrBiFRUwtaWdAaA0AidrOEWT3BXpq7fSBsuSa3ZqwU3L8
 JGPwuQBb3MyUlS17ey+GVRQ3sUYFmm/mPV0TuR/20iWIZ0h6FRt2/HAzCDaEE7i2rPZs2ch4kGO
 vR2CQ+z
X-Google-Smtp-Source: AGHT+IH9y0xweKMNzPFl/UhCz2pi8ugSywcFqS8woN0GYc/0W1RtfetnZNrqwOwwiTUt8zpUanHcEGF2qwENpGBnELU=
X-Received: by 2002:a05:690c:dc8:b0:721:1649:b041 with SMTP id
 00721157ae682-7227635c94amr64676047b3.2.1756723414037; Mon, 01 Sep 2025
 03:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250829125935.1526984-1-pbonzini@redhat.com>
 <20250829125935.1526984-16-pbonzini@redhat.com>
In-Reply-To: <20250829125935.1526984-16-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Sep 2025 11:43:22 +0100
X-Gm-Features: Ac12FXziklwxONgKokEyH739FqV5U8bamarVDaznuSicuXGJwEVGM43aH8f-I6g
Message-ID: <CAFEAcA-xknGH8H-1M7xtkWwQHfb47+f7MdBqrt5UmKsh3As6OA@mail.gmail.com>
Subject: Re: [PULL 15/28] hw/i386/pc_piix.c: assume pcmc->pci_enabled is
 always true in pc_init1()
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Sat, 30 Aug 2025 at 16:57, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>
> PCI is always enabled on the pc-i440fx machine so hardcode the relevant l=
ogic
> in pc_init1(). Add an assert() to ensure that this is always the case at
> runtime as already done in pc_q35_init().
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Link: https://lore.kernel.org/r/20250828111057.468712-16-mark.caveayland@=
nutanix.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Hi; Coverity points out (CID 1620557) that this change means
that an if() check later on in the function is no longer needed:

> @@ -195,38 +200,36 @@ static void pc_init1(MachineState *machine, const c=
har *pci_type)
>          kvmclock_create(pcmc->kvmclock_create_always);
>      }
>
> -    if (pcmc->pci_enabled) {
> -        pci_memory =3D g_new(MemoryRegion, 1);
> -        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
> -        rom_memory =3D pci_memory;
> +    pci_memory =3D g_new(MemoryRegion, 1);
> +    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
> +    rom_memory =3D pci_memory;
>
> -        phb =3D OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
> -        object_property_add_child(OBJECT(machine), "i440fx", phb);
> -        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
> -                                 OBJECT(ram_memory), &error_fatal);
> -        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
> -                                 OBJECT(pci_memory), &error_fatal);
> -        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
> -                                 OBJECT(system_memory), &error_fatal);
> -        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
> -                                 OBJECT(system_io), &error_fatal);
> -        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
> -                                 x86ms->below_4g_mem_size, &error_fatal)=
;
> -        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
> -                                 x86ms->above_4g_mem_size, &error_fatal)=
;
> -        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type=
,
> -                                &error_fatal);
> -        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
> +    phb =3D OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));

phb is now guaranteed not to be NULL (when before it might have
been NULL), so this bit of code near the bottom of pc_init1():

    if (phb) {
        ioapic_init_gsi(gsi_state, phb);
    }

can be simplified to unconditionally call ioapic_init_gsi().

Would you mind sending a followup patch to clean that up?

thanks
-- PMM

