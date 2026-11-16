Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2310606A32C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KzMwwpP0;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ENcCiAXB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT03u-0005nx-Dw; Mon, 16 Nov 2026 12:00:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xT03n-0005nL-P5
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 12:00:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xT03l-0005YI-3G
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 12:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794848400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jcdMzwH05vEglK+FDJ0LdhdOwh/SUlmxD/Prh2rJE78=;
 b=KzMwwpP0i+bokxV1izMSIhdacPf+nVC7pYN9ih+EpX1I4GHp1u2MbzI6XYeMGfXDTzrjIo
 Tx5PT8PwfWyd/73at2VyGBP6WBnm/5w4sveN7WRbjqZbDZt4LL4TUguBruv5bn5QhVO1TL
 u6i8O2SAH8QRZb4dkqmUCMWVXXf4oaY=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-PTu_OpihO1iM_w4kPi89LA-1; Mon, 16 Nov 2026 11:59:58 -0500
X-MC-Unique: PTu_OpihO1iM_w4kPi89LA-1
X-Mimecast-MFC-AGG-ID: PTu_OpihO1iM_w4kPi89LA_1794848398
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-677deb12bceso5785608d50.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 08:59:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794848398; cv=none;
 d=google.com; s=arc-20260327;
 b=nGKyzPvA576rguKHUcIDhNbmyOkPpVBwFZEJoINRfK3nxPftC1lC5ZKt8rikBrxKvn
 Y0FmD5hgh0z+LSvMc6cgAQxm9njOdtLFBvY6s6RRnD5oUKQ9V8hQUDaZzMfCQcJpg++b
 t0ulnJ/IHgsH7HwMXo3q5obVcgpezhamZi1vJ72R25JQOI+TdG7mxMIHPnZbqlgQ0IQ6
 GPHa6DbCt6n2gg6m9iRhhoplfDFcUsu/DftcvwYCNmHtYtQAMIa3uTRaE26siLF9o8s1
 KpdMhhj7DNNhZsSTCj3mjFTILsDvwTkECoYgse9fRGSiVdZXCduzi3PDfIDf7yztIvuo
 mpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jcdMzwH05vEglK+FDJ0LdhdOwh/SUlmxD/Prh2rJE78=;
 fh=b1DpNd/Juw7w841x4GpvvSch3Np+ovauu20gkpQSVvg=;
 b=EvEmC7CAKRuwKSUwyNwf/EqMmtCEAlKzzbNVZodXeGHynLfXOvjcqc36TNNgQ8uGSl
 70m3dBY0SMTOvuCl2NqW5DffsxaNAhzAx70S0S24eTmLnVmbuuDp9XIyHftdvMPWxQlH
 Tr1HnzKOuBonVfvV/kGuudee+wLo6A1RCpjXpi1BV2gkL39QExX8nTNL3W8FRO8Zq4GU
 8hfK9JiHz5CgqgbcL1m3IUScyqd2ZE6AE6a2o1hspcnjSGTdOUQBqQc+6kZyfP1UfNfF
 f57AqmNjan7tkTylm0ehW9wNv6ee0ScrcVGZ+mUQ6KOQPjyPgz1A6uIEKYCLuEbOPC/O
 okvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794848398; x=1795453198; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jcdMzwH05vEglK+FDJ0LdhdOwh/SUlmxD/Prh2rJE78=;
 b=ENcCiAXBNiVLZsJKSO8xzuUYjoN2qH6yDbyA/DSt0vxPHnEISjOY6QI27zVKAjkXZ+
 98/tFoO0YKVvX+o65GdzDGMPoOz0zcZOnoz6xWHkjpI39N+SpFSu727NwI6A0B7GJUb1
 1yKaCW+xGv4IllTXnB6iE1gUYYXemal5iWqG7IyLCZZENFiZsD8ULwCmRtxUTfWkPvDn
 lX6oqZ00l96pH6LmEdEvlJYaYIx0CDpb1Wf6qAnfbqF/d2Xj/rm5skBFT1Pdw++3w+17
 FlupfNMEr4hFr8hKpCMm2xML42J7APwO/bKXHn19n9cPMhizObYSOBysNuSw2lmqxJ3G
 7GLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794848398; x=1795453198;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jcdMzwH05vEglK+FDJ0LdhdOwh/SUlmxD/Prh2rJE78=;
 b=yfaV+5SjE2+zD8fgh51Oo6Rr5P9qrZx0UkazqRBEyH6LiI4eTVn3lvNinM2MWGJ7KS
 jy1bMEHrLuqlCDhivmZA9sNc9KmDW6Ol6VC+PfCYGBsH0cS0FMDBMsB4Ug9IMAMuAXCO
 1Hv1QVBk9Iv9DE/XUoWK5yW7DRDmnq53d8XZitEtHP7jWLS0aIZzczBy6mfOMCL295OB
 ti5UHcCTiH1+MLP57AcOyIFTXK7tMC+QJaSyC7RIu+rdZR6l0lowkt7TwZk2EzBzPEZi
 x3Ebiuqt1dkGdjIWyzqE9J1dzSYDKPW1Sh4ACv/9nnW0DGPA2iYgZQ/MVzxZPlbL6kA3
 L+kg==
X-Gm-Message-State: APuU4Z8gB8KfM02QH3csOaaXXJV7CBJbGX6xHavh+P+3v2Phvw1J5vIb
 BNg4AqnTCiWlATxIhD02o8b252dvAFExcewkh8Miklzqg1BVL4yRJnAVDKt316JZeIFFNmNIHjp
 ejJb9sKjJalbJY4SvquxltE/Qvz4SsXQg14UKPPTj3A/SMcExAQzUKpdLqJAj7DZPd++rMWio2T
 3MxM5tEJfzCkmWS6JigLbW8k+razgwmot06iqCHMo=
X-Gm-Gg: AZFdTZdO8zA6LmwKzDsZnlTbbQAmxP9b+YsUJwJiBSn2zXrh0QtcMaxKh0IxoKX44zM
 rpOTrcPvjobCf+ub0Ps3jKcjtKUTYOyNLwyKVFe3haDHeQiYiSZJ0Hv6FjgTqSjjy1t7iCJZY8o
 rEqQhwFH5Jw0D6oYkCS+A/7FRqzkdd03JKRyAKMu+P2kpArx6HbnNJ8JvcpkE6+QrhFMbfL7VnF
 rrty3houYw4AnDC
X-Received: by 2002:a05:690e:4504:10b0:677:c671:56f2 with SMTP id
 956f58d0204a3-67d896aaa68mr3508120d50.65.1794848397716; 
 Mon, 16 Nov 2026 08:59:57 -0800 (PST)
X-Received: by 2002:a05:690e:4504:10b0:677:c671:56f2 with SMTP id
 956f58d0204a3-67d896aaa68mr3508115d50.65.1794848397166; Mon, 16 Nov 2026
 08:59:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106191356.1207295-1-jsnow@redhat.com>
In-Reply-To: <20261106191356.1207295-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 16 Nov 2026 11:59:45 -0500
X-Gm-Features: AclHuK_OHt_U2Y5egd4wN4XvySQZblaGV2_egoAegAuOJYFYw-vM8AmwKLSOrd0
Message-ID: <CAFn=p-ZycqTSMe1JnvDCWKPKLXpmo5OdMJ3BV63YrTucV0fPKA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/i386: move bios functions into x86-bios.c
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ping, I think we do want this for 11.2 as it fixes a build failure.

--js

On Fri, Nov 6, 2026 at 2:14=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
> Currently, these functions are located in x86-common.c. However, when
> configuring QEMU with `--without-default-devices`, we encounter a
> linking error at final assembly time where these functions cannot be
> located.
>
> Split these functions out into a new x86-bios.c module to allow
> defaultless compilations of x86_64 to succeed.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  hw/i386/x86-bios.c   | 143 +++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/x86-common.c | 125 -------------------------------------
>  hw/i386/x86.c        |   1 -
>  hw/i386/meson.build  |   1 +
>  4 files changed, 144 insertions(+), 126 deletions(-)
>  create mode 100644 hw/i386/x86-bios.c
>
> diff --git a/hw/i386/x86-bios.c b/hw/i386/x86-bios.c
> new file mode 100644
> index 00000000000..525e42e7252
> --- /dev/null
> +++ b/hw/i386/x86-bios.c
> @@ -0,0 +1,143 @@
> +/*
> + * x86 bios loading functions
> + *
> + * Copyright (c) 2003-2004 Fabrice Bellard
> + * Copyright (c) 2019, 2024-2026 Red Hat, Inc.
> + *
> + * SPDX-License-Identifier: MIT
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/datadir.h"
> +#include "qapi/error.h"
> +#include "qemu/units.h"
> +
> +#include "hw/core/loader.h"
> +#include "hw/i386/x86.h"
> +#include "kvm/tdx.h"
> +#include "target/i386/sev.h"
> +
> +void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
> +                       MemoryRegion *bios, bool read_only)
> +{
> +    uint64_t bios_size =3D memory_region_size(bios);
> +    uint64_t isa_bios_size =3D MIN(bios_size, 128 * KiB);
> +
> +    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
> +                             bios_size - isa_bios_size, isa_bios_size);
> +    memory_region_add_subregion_overlap(isa_memory, 1 * MiB - isa_bios_s=
ize,
> +                                        isa_bios, 1);
> +    memory_region_set_readonly(isa_bios, read_only);
> +}
> +
> +static int get_bios_size(X86MachineState *x86ms,
> +                         const char *bios_name, char *filename)
> +{
> +    int bios_size;
> +
> +    if (filename) {
> +        bios_size =3D get_image_size(filename, NULL);
> +    } else {
> +        bios_size =3D -1;
> +    }
> +    if (bios_size <=3D 0 ||
> +        (bios_size % 65536) !=3D 0) {
> +        goto bios_error;
> +    }
> +
> +    return bios_size;
> +
> + bios_error:
> +    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
> +    exit(1);
> +}
> +
> +static void load_bios_from_file(X86MachineState *x86ms, const char *bios=
_name,
> +                                char *filename, int bios_size,
> +                                bool isapc_ram_fw)
> +{
> +    ssize_t ret;
> +
> +    /* BIOS load */
> +    if (machine_require_guest_memfd_private(MACHINE(x86ms))) {
> +        memory_region_init_ram_guest_memfd_private(
> +            &x86ms->bios, NULL, "pc.bios", bios_size, &error_fatal);
> +        if (is_tdx_vm()) {
> +            tdx_set_tdvf_region(&x86ms->bios);
> +        }
> +    } else {
> +        memory_region_init_ram(&x86ms->bios, NULL, "pc.bios",
> +                               bios_size, &error_fatal);
> +    }
> +    if (sev_enabled() || is_tdx_vm()) {
> +        /*
> +         * The concept of a "reset" simply doesn't exist for
> +         * confidential computing guests, we have to destroy and
> +         * re-launch them instead.  So there is no need to register
> +         * the firmware as rom to properly re-initialize on reset.
> +         * Just go for a straight file load instead.
> +         */
> +        void *ptr =3D memory_region_get_ram_ptr(&x86ms->bios);
> +        load_image_size(filename, ptr, bios_size);
> +        x86_firmware_configure(0x100000000ULL - bios_size, ptr, bios_siz=
e);
> +    } else {
> +        memory_region_set_readonly(&x86ms->bios, !isapc_ram_fw);
> +        ret =3D rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1=
);
> +        if (ret !=3D 0) {
> +            goto bios_error;
> +        }
> +    }
> +
> +    return;
> +
> + bios_error:
> +    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
> +    exit(1);
> +}
> +
> +void x86_bios_rom_reload(X86MachineState *x86ms)
> +{
> +    int bios_size;
> +    const char *bios_name;
> +    char *filename;
> +
> +    if (memory_region_size(&x86ms->bios) =3D=3D 0) {
> +        /* if -bios is not used */
> +        return;
> +    }
> +
> +    bios_name =3D MACHINE(x86ms)->firmware ?: "bios.bin";
> +    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +
> +    bios_size =3D get_bios_size(x86ms, bios_name, filename);
> +
> +    void *ptr =3D memory_region_get_ram_ptr(&x86ms->bios);
> +    load_image_size(filename, ptr, bios_size);
> +    x86_firmware_configure(0x100000000ULL - bios_size, ptr, bios_size);
> +}
> +
> +void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmw=
are,
> +                       MemoryRegion *rom_memory, bool isapc_ram_fw)
> +{
> +    int bios_size;
> +    const char *bios_name;
> +    g_autofree char *filename;
> +
> +    bios_name =3D MACHINE(x86ms)->firmware ?: default_firmware;
> +    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +
> +    bios_size =3D get_bios_size(x86ms, bios_name, filename);
> +    load_bios_from_file(x86ms, bios_name, filename, bios_size, isapc_ram=
_fw);
> +
> +    if (!machine_require_guest_memfd_private(MACHINE(x86ms))) {
> +        /* map the last 128KB of the BIOS in ISA space */
> +        x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
> +                          !isapc_ram_fw);
> +    }
> +
> +    /* map all the bios at the top of memory */
> +    memory_region_add_subregion(rom_memory,
> +                                (uint32_t)(-bios_size),
> +                                &x86ms->bios);
> +    return;
> +}
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index dcd4fa8eb79..350fcbc20e1 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -995,128 +995,3 @@ void x86_load_linux(X86MachineState *x86ms,
>      option_rom[nb_option_roms].name =3D "linuxboot_dma.bin";
>      nb_option_roms++;
>  }
> -
> -void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
> -                       MemoryRegion *bios, bool read_only)
> -{
> -    uint64_t bios_size =3D memory_region_size(bios);
> -    uint64_t isa_bios_size =3D MIN(bios_size, 128 * KiB);
> -
> -    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
> -                             bios_size - isa_bios_size, isa_bios_size);
> -    memory_region_add_subregion_overlap(isa_memory, 1 * MiB - isa_bios_s=
ize,
> -                                        isa_bios, 1);
> -    memory_region_set_readonly(isa_bios, read_only);
> -}
> -
> -static int get_bios_size(X86MachineState *x86ms,
> -                         const char *bios_name, char *filename)
> -{
> -    int bios_size;
> -
> -    if (filename) {
> -        bios_size =3D get_image_size(filename, NULL);
> -    } else {
> -        bios_size =3D -1;
> -    }
> -    if (bios_size <=3D 0 ||
> -        (bios_size % 65536) !=3D 0) {
> -        goto bios_error;
> -    }
> -
> -    return bios_size;
> -
> - bios_error:
> -    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
> -    exit(1);
> -}
> -
> -static void load_bios_from_file(X86MachineState *x86ms, const char *bios=
_name,
> -                                char *filename, int bios_size,
> -                                bool isapc_ram_fw)
> -{
> -    ssize_t ret;
> -
> -    /* BIOS load */
> -    if (machine_require_guest_memfd_private(MACHINE(x86ms))) {
> -        memory_region_init_ram_guest_memfd_private(
> -            &x86ms->bios, NULL, "pc.bios", bios_size, &error_fatal);
> -        if (is_tdx_vm()) {
> -            tdx_set_tdvf_region(&x86ms->bios);
> -        }
> -    } else {
> -        memory_region_init_ram(&x86ms->bios, NULL, "pc.bios",
> -                               bios_size, &error_fatal);
> -    }
> -    if (sev_enabled() || is_tdx_vm()) {
> -        /*
> -         * The concept of a "reset" simply doesn't exist for
> -         * confidential computing guests, we have to destroy and
> -         * re-launch them instead.  So there is no need to register
> -         * the firmware as rom to properly re-initialize on reset.
> -         * Just go for a straight file load instead.
> -         */
> -        void *ptr =3D memory_region_get_ram_ptr(&x86ms->bios);
> -        load_image_size(filename, ptr, bios_size);
> -        x86_firmware_configure(0x100000000ULL - bios_size, ptr, bios_siz=
e);
> -    } else {
> -        memory_region_set_readonly(&x86ms->bios, !isapc_ram_fw);
> -        ret =3D rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1=
);
> -        if (ret !=3D 0) {
> -            goto bios_error;
> -        }
> -    }
> -
> -    return;
> -
> - bios_error:
> -    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
> -    exit(1);
> -}
> -
> -void x86_bios_rom_reload(X86MachineState *x86ms)
> -{
> -    int bios_size;
> -    const char *bios_name;
> -    char *filename;
> -
> -    if (memory_region_size(&x86ms->bios) =3D=3D 0) {
> -        /* if -bios is not used */
> -        return;
> -    }
> -
> -    bios_name =3D MACHINE(x86ms)->firmware ?: "bios.bin";
> -    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> -
> -    bios_size =3D get_bios_size(x86ms, bios_name, filename);
> -
> -    void *ptr =3D memory_region_get_ram_ptr(&x86ms->bios);
> -    load_image_size(filename, ptr, bios_size);
> -    x86_firmware_configure(0x100000000ULL - bios_size, ptr, bios_size);
> -}
> -
> -void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmw=
are,
> -                       MemoryRegion *rom_memory, bool isapc_ram_fw)
> -{
> -    int bios_size;
> -    const char *bios_name;
> -    g_autofree char *filename;
> -
> -    bios_name =3D MACHINE(x86ms)->firmware ?: default_firmware;
> -    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> -
> -    bios_size =3D get_bios_size(x86ms, bios_name, filename);
> -    load_bios_from_file(x86ms, bios_name, filename, bios_size, isapc_ram=
_fw);
> -
> -    if (!machine_require_guest_memfd_private(MACHINE(x86ms))) {
> -        /* map the last 128KB of the BIOS in ISA space */
> -        x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
> -                          !isapc_ram_fw);
> -    }
> -
> -    /* map all the bios at the top of memory */
> -    memory_region_add_subregion(rom_memory,
> -                                (uint32_t)(-bios_size),
> -                                &x86ms->bios);
> -    return;
> -}
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 4b75b7406a8..5f842351daf 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -35,7 +35,6 @@
>  #include "hw/acpi/aml-build.h"
>  #include "hw/i386/x86.h"
>  #include "hw/i386/topology.h"
> -
>  #include "hw/core/nmi.h"
>  #include "kvm/kvm_i386.h"
>
> diff --git a/hw/i386/meson.build b/hw/i386/meson.build
> index e16930c4319..6bb73b8731c 100644
> --- a/hw/i386/meson.build
> +++ b/hw/i386/meson.build
> @@ -5,6 +5,7 @@ i386_ss.add(files(
>    'monitor.c',
>    'multiboot.c',
>    'x86.c',
> +  'x86-bios.c',
>    'x86-cpu.c',
>  ))
>
> --
> 2.56.0
>


