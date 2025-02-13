Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16F4C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 09:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiVj4-0001Aw-Ur; Thu, 13 Feb 2025 04:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1tiVir-000168-W5; Thu, 13 Feb 2025 04:41:31 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1tiVil-0002tx-H6; Thu, 13 Feb 2025 04:41:26 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id F26A9A41FAD;
 Thu, 13 Feb 2025 09:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04811C4CEE8;
 Thu, 13 Feb 2025 09:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739439680;
 bh=o/N8oMkwTbIVPvFK7iE9T8Rsfr+w+JUCkck6yXgZCf4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=oeqYpHrqnkMYttC78V23FikGWSPMrx10IqES3YjdoM0+nfGv1FMsyjDdkwTiD78Dj
 IcHRr0r3WW5bACihOlR0koYJrpjYc8Fruqc8cZ9cj4+awE/UqL+bd6BAZj/JEsgM+L
 vf5F+dlt+elpacSZtiyN+gPHFpC1GsVZC9wfJFjZuI1P/Uod5NQ7MIpAWFR/TlpCA/
 0jhfYP9EEhsEc+KryYy8hxu9xh6PeC1gygQsvN4kYWg6qBhGnIbq5cckINZ/mYWaV3
 gPkJqdpSaNm8mQOkPD0sqZzVZrtDC9+bKdaD4Ic3BkkX2oIsSZIXi1z8L/Q0qY7R3k
 3gH56pdyghx1g==
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-54504f29000so626002e87.1; 
 Thu, 13 Feb 2025 01:41:19 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU+hIbAWJiXgtFt3WPtDuQr7jvMseTT4ZXyCC+KodiQ9GclJ/QVxSjE8cXbe8we5ffg+104yC7B/A==@nongnu.org
X-Gm-Message-State: AOJu0YyDks4yoGWuSDkAeE5ERAmqFJvS0LgSuheGQmaesqMMrZk5W+0t
 bsc3QT+s0gVqYYSbLtkU5yHf2PKwxM1B2SNVi8bG1s3R3iRQVQYU7VfeKBogYbWSG2VUCFUR5xy
 goDi1q3WC6Jtb2k73l43ihxSJTks=
X-Google-Smtp-Source: AGHT+IGY/S2iCzYUyju8YC6+sMK5v7FRa8R6jpYoh8UBzZvPFurQ6tnmmZukMPtVF5xwmHvnGhpFFKmUk+XmaXu806k=
X-Received: by 2002:a05:6512:6cc:b0:540:1a40:ab0d with SMTP id
 2adb3069b0e04-54518290ed0mr1982823e87.28.1739439678314; Thu, 13 Feb 2025
 01:41:18 -0800 (PST)
MIME-Version: 1.0
References: <20250211092324.965440-1-kraxel@redhat.com>
In-Reply-To: <20250211092324.965440-1-kraxel@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 13 Feb 2025 10:41:07 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE289FkzV=GZSUARF7TFUyRuxYVX-090ic06Erb_RLGrg@mail.gmail.com>
X-Gm-Features: AWEUYZmmMCHQragD0IxxDaa0XntOeAXhPvdKxcdWG9snwxjy2tuHbJnaiYRI0As
Message-ID: <CAMj1kXE289FkzV=GZSUARF7TFUyRuxYVX-090ic06Erb_RLGrg@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] hw/uefi: add uefi variable service
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, Eric Blake <eblake@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=ardb@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Tue, 11 Feb 2025 at 10:23, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> This patch adds a virtual device to qemu which the uefi firmware can use
> to store variables.  This moves the UEFI variable management from
> privileged guest code (managing vars in pflash) to the host.  Main
> advantage is that the need to have privilege separation in the guest
> goes away.
>
> On x86 privileged guest code runs in SMM.  It's supported by kvm, but
> not liked much by various stakeholders in cloud space due to the
> complexity SMM emulation brings.
>
> On arm privileged guest code runs in el3 (aka secure world).  This is
> not supported by kvm, which is unlikely to change anytime soon given
> that even el2 support (nested virt) is being worked on for years and is
> not yet in mainline.
>

The secure counterpart of this would never execute at EL3 on ARM, but
at secure EL1 (or potentially at secure EL2 on more recent CPUs). But
the general point that this is difficult to virtualize stands; I've
contemplated doing something similar to SMM emulation using non-secure
EL1 in a separate VM to provide an execution context that could those
the secure EL1 payload (using standalone MM) but I never found the
time to work on this.

> The design idea is to reuse the request serialization protocol edk2 uses
> for communication between SMM and non-SMM code, so large chunks of the
> edk2 variable driver stack can be used unmodified.  Only the driver
> which traps into SMM mode must be replaced by a driver which talks to
> qemu instead.
>

I like this approach, but I will note that these protocols are not
standardized: it is basically an EDK2 implementation detail, but this
is fine, given that this targets firmware that is based on EDK2 (or
its derivatives).

Using a single shared communication buffer makes it feasible to
paravirtualize this even under confidential compute scenarios (where
the buffer needs special shared mapping semantics), and I think this
might be useful, even if in principle, the VMM is untrusted in such
scenarios. Paravirtualizing the individual variable services directly
creates a problem here, given that the firmware cannot share mappings
of arbitrary arguments passed via pointers.

For the record, I've already acked the OVMF counterpart of this, and
I've started working on adding support for this to my minimal EFI for
mach-virt [0], which is another scenario (i.e., minimal EFI compatible
firmware for micro VMs) where having this complexity in the VMM is
preferred.


[0] https://github.com/ardbiesheuvel/efilite



> A edk2 test branch can be found here (build with "-D QEMU_PV_VARS=TRUE").
> https://github.com/kraxel/edk2/commits/devel/secure-boot-external-vars
>
> The uefi-vars device re-implements the privileged edk2 protocols
> (i.e. the code running in SMM mode).
>
> v3 changes:
>  - switch sysbus device variant to use the qemu platform bus.
>  - misc minor changes.
> v2 changes:
>  - fully implement authenticated variables.
>  - various cleanups and fixes.
>
> enjoy & take care,
>   Gerd
>
> Gerd Hoffmann (23):
>   hw/uefi: add include/hw/uefi/var-service-api.h
>   hw/uefi: add include/hw/uefi/var-service-edk2.h
>   hw/uefi: add include/hw/uefi/var-service.h
>   hw/uefi: add var-service-guid.c
>   hw/uefi: add var-service-utils.c
>   hw/uefi: add var-service-vars.c
>   hw/uefi: add var-service-auth.c
>   hw/uefi: add var-service-policy.c
>   hw/uefi: add var-service-core.c
>   hw/uefi: add var-service-pkcs7.c
>   hw/uefi: add var-service-pkcs7-stub.c
>   hw/uefi: add var-service-siglist.c
>   hw/uefi: add var-service-json.c + qapi for NV vars.
>   hw/uefi: add trace-events
>   hw/uefi: add UEFI_VARS to Kconfig
>   hw/uefi: add to meson
>   hw/uefi: add uefi-vars-sysbus device
>   hw/uefi-vars-sysbus: qemu platform bus support
>   hw/uefi-vars-sysbus: allow for arm virt
>   hw/uefi: add uefi-vars-isa device
>   hw/uefi-vars-isa: add acpi device
>   docs: add uefi variable service documentation
>   hw/uefi: add MAINTAINERS entry
>
>  include/hw/uefi/var-service-api.h  |  43 ++
>  include/hw/uefi/var-service-edk2.h | 227 +++++++++
>  include/hw/uefi/var-service.h      | 186 ++++++++
>  hw/arm/virt.c                      |   2 +
>  hw/core/sysbus-fdt.c               |  24 +
>  hw/uefi/var-service-auth.c         | 361 ++++++++++++++
>  hw/uefi/var-service-core.c         | 237 ++++++++++
>  hw/uefi/var-service-guid.c         |  99 ++++
>  hw/uefi/var-service-isa.c          | 115 +++++
>  hw/uefi/var-service-json.c         | 242 ++++++++++
>  hw/uefi/var-service-pkcs7-stub.c   |  16 +
>  hw/uefi/var-service-pkcs7.c        | 436 +++++++++++++++++
>  hw/uefi/var-service-policy.c       | 370 +++++++++++++++
>  hw/uefi/var-service-siglist.c      | 212 +++++++++
>  hw/uefi/var-service-sysbus.c       |  90 ++++
>  hw/uefi/var-service-utils.c        | 241 ++++++++++
>  hw/uefi/var-service-vars.c         | 725 +++++++++++++++++++++++++++++
>  MAINTAINERS                        |   6 +
>  docs/devel/index-internals.rst     |   1 +
>  docs/devel/uefi-vars.rst           |  66 +++
>  hw/Kconfig                         |   1 +
>  hw/meson.build                     |   1 +
>  hw/uefi/Kconfig                    |   9 +
>  hw/uefi/LIMITATIONS.md             |   7 +
>  hw/uefi/meson.build                |  24 +
>  hw/uefi/trace-events               |  17 +
>  meson.build                        |   1 +
>  qapi/meson.build                   |   1 +
>  qapi/qapi-schema.json              |   1 +
>  qapi/uefi.json                     |  45 ++
>  30 files changed, 3806 insertions(+)
>  create mode 100644 include/hw/uefi/var-service-api.h
>  create mode 100644 include/hw/uefi/var-service-edk2.h
>  create mode 100644 include/hw/uefi/var-service.h
>  create mode 100644 hw/uefi/var-service-auth.c
>  create mode 100644 hw/uefi/var-service-core.c
>  create mode 100644 hw/uefi/var-service-guid.c
>  create mode 100644 hw/uefi/var-service-isa.c
>  create mode 100644 hw/uefi/var-service-json.c
>  create mode 100644 hw/uefi/var-service-pkcs7-stub.c
>  create mode 100644 hw/uefi/var-service-pkcs7.c
>  create mode 100644 hw/uefi/var-service-policy.c
>  create mode 100644 hw/uefi/var-service-siglist.c
>  create mode 100644 hw/uefi/var-service-sysbus.c
>  create mode 100644 hw/uefi/var-service-utils.c
>  create mode 100644 hw/uefi/var-service-vars.c
>  create mode 100644 docs/devel/uefi-vars.rst
>  create mode 100644 hw/uefi/Kconfig
>  create mode 100644 hw/uefi/LIMITATIONS.md
>  create mode 100644 hw/uefi/meson.build
>  create mode 100644 hw/uefi/trace-events
>  create mode 100644 qapi/uefi.json
>
> --
> 2.48.1
>

