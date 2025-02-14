Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B027C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 15:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tixjU-0005pY-9L; Fri, 14 Feb 2025 10:36:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tixjR-0005pC-P4
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:35:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tixjO-0002Xy-9B
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739547352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sShze56byqhGIWhVITOtwwr+tVfWOSbc9QEVIArpVus=;
 b=c5A2Mr9qBxHaeAiD5a9cidGRZhu/0aradx5EFlB+QP9QbSesFJ2ZubrsEVZUEO0zXyIrDu
 MyoPI5ZnbfStoiUGyRe0KddcqIiRC1qGqbQVrkzKrveGpwuS8xehuJZf5qSj8B1x+Wz96C
 pCYibewofHLkisNk6f+FORJFLPhIk6A=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-kmc1doJ6PnCgDIR6AtkMEA-1; Fri, 14 Feb 2025 10:35:51 -0500
X-MC-Unique: kmc1doJ6PnCgDIR6AtkMEA-1
X-Mimecast-MFC-AGG-ID: kmc1doJ6PnCgDIR6AtkMEA_1739547350
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-868de3849b3so285712241.0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 07:35:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739547349; x=1740152149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sShze56byqhGIWhVITOtwwr+tVfWOSbc9QEVIArpVus=;
 b=uAO2sdzfQCWxG98e8e9qHDU3kLzdVUdSVGn2VSUGTtqvFdmXNQs5jTnH3KZgVnhuHQ
 9nHjhbn/p1jAwnPNVYtLF/MfWfZ0t2EYT1v+6saobibc3S5DoZndiGsL9uE2J84kHkdD
 zS2x8K2gHWFPP43ncGZgJm2wAWsMGUHTmtPpzyQfE3ULVgRqGor5efYLT+z30c53/9tG
 8RxeY+QsGaFwrmLN3a2jBopVx44a4Xf5RxoxN8VOX5UKtoo0XfHlgn6ambTh8gM6ybeE
 CJ/M0eBtoMbAruPSE5lor7r2+7U59HNiFENsEiye9EWfahNQUMXckQBuAkl3Q/Lx+17Z
 ACcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW4arJP21AomXbSTMuFsFErNikiUC/8jPm8snTEu56duvrGM9o3qj6dFmooJUbtl6hZQ9pSz2r3rhM@nongnu.org
X-Gm-Message-State: AOJu0YwV/a/n8lbtl4UNQWXOeXcmsMa61eqyUxG2Gou73tfXjkyQYcr4
 evt8U4YoFCcDWKrCg+WgOYxYahEZjZiwD3RVTPnZ/QsZaiKnsGr0ArXJ9PgdNRyfrkhSRfHqzej
 1foBhMYYt1vpgI5Gk7bG+in9Ag7KpKU8qj6zhuRX8dFVxdv8BA1S25bc1IGebrACV+oLzkISdpi
 5Oa+TpwMkK7uTHRabD7jOkbMuJ18g=
X-Gm-Gg: ASbGncseErgkS7xlbeuIVR/xLmqDMFybV3Q8h2Co4geEVOen/hmPjRwq6HDH/ICQhhI
 1g7J+/hUFRQPq3gwri5waZ8EiIPMO4QDKZgJTXW2UqLx6C2nPttnUc8xc9VBn38E=
X-Received: by 2002:a05:6122:1d88:b0:520:5e9b:49b2 with SMTP id
 71dfb90a1353d-52077dfbf17mr6028416e0c.3.1739547349016; 
 Fri, 14 Feb 2025 07:35:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+iLboYc2ATmpjs8unr5WhO4NNrm55/noZ6KEDA4ZhSPEmYQuPNZ8Vn695mjOhSiP9syuDvateheGIq9azvN8=
X-Received: by 2002:a05:6122:1d88:b0:520:5e9b:49b2 with SMTP id
 71dfb90a1353d-52077dfbf17mr6028366e0c.3.1739547348567; Fri, 14 Feb 2025
 07:35:48 -0800 (PST)
MIME-Version: 1.0
References: <20250129063153.3967220-1-anisinha@redhat.com>
 <efbd2dce-b4c7-4c5e-b6b6-230761eefce8@amazon.com>
In-Reply-To: <efbd2dce-b4c7-4c5e-b6b6-230761eefce8@amazon.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Fri, 14 Feb 2025 21:05:35 +0530
X-Gm-Features: AWEUYZnSB3PDmqyDxseV5Hdt_hVPGQ-mfW5JpziF3Tgg_ASM6NTuNhuCEyYv_HI
Message-ID: <CAK3XEhMcScorAeRFjRmmt2Wx_ehvw3-Onq_VrJTc=pwD2HoVQw@mail.gmail.com>
Subject: Re: [PATCH v5] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Alexander Graf <graf@amazon.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Feb 3, 2025 at 3:50=E2=80=AFAM Alexander Graf <graf@amazon.com> wro=
te:
>
> Hey Ani!
>
> On 28.01.25 22:31, Ani Sinha wrote:
> > VM firmware update is a mechanism where the virtual machines can use th=
eir
> > preferred and trusted firmware image in their execution environment wit=
hout
> > having to depend on a untrusted party to provide the firmware bundle. T=
his is
> > particularly useful for confidential virtual machines that are deployed=
 in the
> > cloud where the tenant and the cloud provider are two different entitie=
s. In
> > this scenario, virtual machines can bring their own trusted firmware im=
age
> > bundled as a part of their filesystem (using UKIs for example[1]) and t=
hen use
> > this hypervisor interface to update to their trusted firmware image. Th=
is also
> > allows the guests to have a consistent measurements on the firmware ima=
ge.
> >
> > This change introduces support for the fw-cfg based hypervisor interfac=
e
> > and the corresponding device.The change also includes the
> > specification document for this interface. The interface is made generi=
c
> > enough so that guests are free to use their own ABI to pass required
> > information between initial and trusted execution contexts (where they =
are
> > running their own trusted firmware image) without the hypervisor gettin=
g
> > involved in between. For pc machines, it implements support for
> > copying firmware image from the guest source physical address specifiie=
d
> > by the guest where the guest loaded the next stage firmware.
> >
> > Currently, this device is only supported for pc machines. Hence, the de=
vice
> > is not initialized for other machine types. Trying to initialize it
> > for arm for example will lead to failure:
> >
> > $ ./qemu-system-arm -device vmfwupdate -machine virt
> > qemu-system-arm: -device vmfwupdate: This machine does not support vmfw=
update device
> >
> > Functional and qtests has been added to test basic device operations an=
d fw-cfg
> > files.
> >
> > [1] See systemd pull requests https://github.com/systemd/systemd/pull/3=
5091
> > and https://github.com/systemd/systemd/pull/35281 for some discussions =
on
> > how we can bundle firmware image within an UKI.
> >
> > CC: Alex Graf <graf@amazon.com>
> > CC: Paolo Bonzini <pbonzini@redhat.com>
> > CC: Gerd Hoffman <kraxel@redhat.com>
> > CC: Igor Mammedov <imammedo@redhat.com>
> > CC: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > ---
> >   MAINTAINERS                         |  11 ++
> >   docs/specs/index.rst                |   1 +
> >   docs/specs/vmfwupdate.rst           | 119 ++++++++++++++++
> >   hw/core/machine.c                   |   2 +
> >   hw/i386/pc.c                        |  55 ++++++++
> >   hw/misc/meson.build                 |   2 +
> >   hw/misc/vmfwupdate.c                | 212 +++++++++++++++++++++++++++=
+
> >   include/hw/misc/vmfwupdate.h        | 105 ++++++++++++++
> >   tests/functional/meson.build        |   2 +
> >   tests/functional/test_vmfwupdate.py |  82 +++++++++++
> >   tests/qtest/meson.build             |   1 +
> >   tests/qtest/vmfwupdate-test.c       |  67 +++++++++
> >   12 files changed, 659 insertions(+)
> >   create mode 100644 docs/specs/vmfwupdate.rst
> >   create mode 100644 hw/misc/vmfwupdate.c
> >   create mode 100644 include/hw/misc/vmfwupdate.h
> >   create mode 100644 tests/functional/test_vmfwupdate.py
> >   create mode 100644 tests/qtest/vmfwupdate-test.c
> >
> > changelogs:
> > v5: Alex's input, add qtest and functional test. guest reset full
> > support for x86. More testing is required but will need support of
> > DMA based fw-cfw file write capability. This has been added in the
> > patchset https://patchwork.ozlabs.org/project/qemu-devel/list/?series=
=3D441003
> > Cover letter: https://patchwork.ozlabs.org/project/qemu-devel/cover/202=
50120043847.954881-1-anisinha@redhat.com/ .
> > For more comprehensive testing of this patch, I am requesting inputs an=
d
> > suggestions.
> >
> > CI pipeline is green - so no regressions.
> > https://gitlab.com/anisinha/qemu/-/pipelines/1646036807
> >
> > v4: remove delay in functional test. Not needed now.
> > v3: inputs from Gerd and Phil taken into account. One basic functional
> > test added. Spec doc updated as per Gerd's suggestions.
> > v2: do not allow changing bios region if advertized size is 0 (non-pc
> > platforms).
>
>
> Thanks a lot for sending out this new version. It's exciting to see it
> slowly taking shape :). Now that we have the first user included, it's a
> lot easier to reason about the flow of the code.
>
>
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7be3d8f431..370bd4d16b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2559,6 +2559,17 @@ F: include/hw/acpi/vmgenid.h
> >   F: docs/specs/vmgenid.rst
> >   F: tests/qtest/vmgenid-test.c
> >
> > +VM Firmware Update
> > +M: Ani Sinha <anisinha@redhat.com>
> > +M: Alex Graf <graf@amazon.com>
> > +M: Paolo Bonzini <pbonzini@redhat.com>
> > +S: Maintained
> > +F: hw/misc/vmfwupdate.c
> > +F: include/hw/misc/vmfwupdate.h
> > +F: docs/specs/vmfwupdate.rst
> > +F: tests/qtest/vmfwupdate-test.c
> > +F: tests/functional/test_vmfwupdate.py
> > +
> >   LED
> >   M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >   S: Maintained
> > diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> > index d7675cebc2..8d78b647f2 100644
> > --- a/docs/specs/index.rst
> > +++ b/docs/specs/index.rst
> > @@ -34,6 +34,7 @@ guest hardware that is specific to QEMU.
> >      virt-ctlr
> >      vmcoreinfo
> >      vmgenid
> > +   vmfwupdate
> >      rapl-msr
> >      rocker
> >      riscv-iommu
> > diff --git a/docs/specs/vmfwupdate.rst b/docs/specs/vmfwupdate.rst
> > new file mode 100644
> > index 0000000000..fbe8f188c7
> > --- /dev/null
> > +++ b/docs/specs/vmfwupdate.rst
> > @@ -0,0 +1,119 @@
> > +VMFWUPDATE INTERFACE SPECIFICATION
> > +##################################
> > +
> > +Introduction
> > +************
> > +
> > +``Vmfwupdate`` is an extension to ``fw-cfg`` that allows guests to rep=
lace early boot
> > +code in their virtual machine. Through a combination of vmfwupdate and
> > +hypervisor stack knowledge, guests can deterministically replace the l=
aunch
> > +payload for guests. This is useful for environments like SEV-SNP where=
 the
> > +launch payload becomes the launch digest. Guests can use vmfwupdate to=
 provide
> > +a measured, full guest payload (BIOS image, kernel, initramfs, kernel
> > +command line) to the virtual machine which enables them to easily reas=
on about
> > +integrity of the resulting system.
> > +For more information, please see the `KVM Forum 2024 presentation <KVM=
FORUM_>`__
> > +about this work from the authors [1]_.
> > +
> > +
> > +.. _KVMFORUM: https://www.youtube.com/watch?v=3DVCMBxU6tAto
> > +
> > +Base Requirements
> > +*****************
> > +
> > +#. **fw-cfg**:
> > +     The target system must provide a ``fw-cfg`` interface. For x86 ba=
sed
> > +     environments, this ``fw-cfg`` interface must be accessible throug=
h PIO ports
> > +     0x510 and 0x511. The ``fw-cfg`` interface does not need to be ann=
ounced as part
> > +     of system device tables such as DSDT. The ``fw-cfg`` interface mu=
st support the
> > +     DMA interface. It may only support the DMA interface for write op=
erations.
> > +
> > +#. **BIOS region**:
> > +     The hypervisor must provide a BIOS region which may be
> > +     statically sized. Through vmfwupdate, the guest is able to atomic=
ally replace
> > +     its contents. The BIOS region must be mapped as read-write memory=
. In a
> > +     SEV-SNP environment, the BIOS region must be mapped as private me=
mory at
> > +     launch time.
> > +
> > +Fw-cfg Files
> > +************
> > +
> > +Guests drive vmfwupdate through special ``fw-cfg`` files that control =
its flow
> > +followed by a standard system reset operation. When vmfwupdate is avai=
lable,
> > +it provides the following ``fw-cfg`` files:
> > +
> > +* ``vmfwupdate/cap`` (``u64``) - Read-only Little Endian encoded bitma=
p of additional
> > +  capabilities the interface supports. List of available capabilities:
> > +
> > +     ``VMFWUPDATE_CAP_BIOS_RESIZE        0x0000000000000001``
> > +
> > +* ``vmfwupdate/bios-size`` (``u64``) - Little Endian encoded size of t=
he BIOS region.
> > +  Read-only by default. Optionally Read-write if ``vmfwupdate/cap`` co=
ntains
> > +  ``VMFWUPDATE_CAP_BIOS_RESIZE``. On write, the BIOS region may resize=
. Guests are
> > +  required to read the value after writing and compare it with the req=
uested size
> > +  to determine whether the resize was successful. Note, x86 BIOS regio=
ns always
> > +  start at 4GiB - bios-size.
> > +
> > +* ``vmfwupdate/opaque`` (``4096 bytes``) - A 4 KiB buffer that survive=
s the BIOS replacement
> > +  flow. Can be used by the guest to propagate guest physical addresses=
 of payloads
> > +  to its BIOS stage. It=EF=BF=BDEUR(tm)s recommended to make the new B=
IOS clear this file on boot
>
>
> Something seems to be off in the file encoding :)
>
>
> > +  if it exists. Contents of this file are under control by the hypervi=
sor. In an
> > +  environment that considers the hypervisor outside of its trust bound=
ary, guests
> > +  are advised to validate its contents before consumption.
> > +
> > +* ``vmfwupdate/disable`` (``u8``) - Indicates whether the interface is=
 disabled.
> > +  Returns 0 for enabled, 1 for disabled. Writing any value disables it=
. Writing is
> > +  only allowed if the value is 0. When the interface is disabled, the =
replace file
> > +  is ignored on reset. This value resets to 0 on system reset.
> > +
> > +* ``vmfwupdate/bios-addr`` (``u64``) - A 64bit Little Endian encoded g=
uest physical address
> > +  at the beginning of the replacement BIOS region. The provided payloa=
d must reside
> > +  in shared memory. 0 on system reset.
> > +
> > +
> > +Triggering the Firmware Update
> > +******************************
> > +
> > +To initiate the firmware update process, the guest issues a standard s=
ystem reset
> > +operation through any of the means implemented by the machine model.
> > +
> > +On reset, the hypervisor evaluates whether ``vmfwupdate/disable`` is `=
`1``. If it is, it ignores
> > +any other vmfwupdate values and performs a standard system reset.
> > +
> > +If ``vmfwupdate/disable`` is ``0``, the hypervisor checks if bios-addr=
 is ``0``. If it is, it
> > +performs a standard system reset.
> > +
> > +If ``vmfwupdate/bios-addr`` is ``non-0``, the hypervisor replaces the =
contents of the system=EF=BF=BDEUR(tm)s
> > +BIOS region with the guest physically contiguous ``vmfwupdate/bios-siz=
e`` sized payload at the
> > +guest physical address address vmfwupdate/bios-addr.
> > +
> > +The firmware update mechanism works both for confidential and non-conf=
idential
> > +guests. In confidential guests, as a part of the reset operation, all =
existing
> > +guest shared memory (shared with the hypervisor) as well as the ``vmfw=
update/opaque`` file
> > +are preserved. The reset causes recreation of the VM context which tri=
ggers a fresh
> > +measurement of the replaced BIOS region and reset CPU state [2]_ .
> > +For non-confidential guests, there is no concept of guest private memo=
ry and all the existing
> > +guest memory is preserved (this is the default behavior today - QEMU d=
oes not reset/clear
> > +guest memory upon reset).
> > +
> > +In both confidential and non-confidential cases, CPU and device state =
are reset to
> > +the default hypervisor specific reset states. In confidential environm=
ents, the guest
> > +always resumes operation in the highest privileged mode available to i=
t (VMPL0 in SEV-SNP).
> > +
> > +Closing Remarks
> > +***************
> > +The handover protocol (format of the ``vmwupdate/opaque`` file etc.) w=
ill be implemented by
> > +the firmware loader and firmware image, both provided by the guest.  T=
he hypervisor does
> > +not need to know these details, so it is not included in this specific=
ation.
> > +
> > +
> > +
> > +Footnotes:
> > +^^^^^^^^^^
> > +.. [1] Original author of the specification: *Alex Graf <graf@amazon.c=
om>*,
> > +       converted to re-structured-text (rst format) and slightly edite=
d
> > +       by *Ani Sinha <anisinha@redhat.com>*.
> > +.. [2] Currently SEV-SNP guests do not support reset. Upon reset, the =
instance is
> > +       terminated and a new instance must be created with new VM confi=
dential context.
> > +       Work is being done currently to support resetting SEV-SNP guest=
s with a new
> > +       confidential/SEV context after reset.
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index c23b399496..0eaf8aa3ba 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -34,6 +34,7 @@
> >   #include "hw/virtio/virtio-pci.h"
> >   #include "hw/virtio/virtio-net.h"
> >   #include "hw/virtio/virtio-iommu.h"
> > +#include "hw/misc/vmfwupdate.h"
> >   #include "audio/audio.h"
> >
> >   GlobalProperty hw_compat_9_2[] =3D {
> > @@ -252,6 +253,7 @@ GlobalProperty hw_compat_2_8[] =3D {
> >       { "virtio-pci", "x-pcie-pm-init", "off" },
> >       { "cirrus-vga", "vgamem_mb", "8" },
> >       { "isa-cirrus-vga", "vgamem_mb", "8" },
> > +    {TYPE_VMFWUPDATE, "disable", "1"},
>
>
> If vmfwupdate is opt-in anyway, why disable for older machines?

Some older machines does not have enough slots for new fw-cfg files.
For those machines, we cannot add this device. Unless we disable the
device, QEMU would crash on an assertion.
This particular case was caught because the CI pipeline was failing.
There might be other cases where we need to disable it but CI does not
have a test case for it.

>
>
> >   };
> >   const size_t hw_compat_2_8_len =3D G_N_ELEMENTS(hw_compat_2_8);
> >
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index b46975c8a4..5ae7d5614d 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -53,6 +53,7 @@
> >   #include "hw/usb.h"
> >   #include "hw/i386/intel_iommu.h"
> >   #include "hw/net/ne2000-isa.h"
> > +#include "hw/misc/vmfwupdate.h"
> >   #include "hw/virtio/virtio-iommu.h"
> >   #include "hw/virtio/virtio-md-pci.h"
> >   #include "hw/i386/kvm/xen_overlay.h"
> > @@ -1719,10 +1720,64 @@ static void pc_machine_initfn(Object *obj)
> >       qemu_add_machine_init_done_notifier(&pcms->machine_done);
> >   }
> >
> > +static void handle_vmfwupd_reset(MachineState *machine,
> > +                                 ResetType type, VMFwUpdateState *vmfw=
)
> > +{
> > +    X86MachineState *x86ms =3D X86_MACHINE(machine);
> > +    void *biosmem =3D memory_region_get_ram_ptr(&x86ms->bios);
> > +    uint64_t bios_size =3D memory_region_size(&x86ms->bios);
> > +
> > +    if (type !=3D RESET_TYPE_COLD) {
> > +        return;
> > +    }
> > +
> > +    if (vmfw->disable) {
> > +        return;
> > +    }
> > +
> > +    if (!vmfw->fw_blob.bios_paddr) {
> > +        return;
> > +    }
> > +
> > +    if (!vmfw->fw_blob.bios_size) {
> > +        return;
> > +    }
> > +
> > +    g_assert(!(vmfw->fw_blob.bios_size % 65536));
> > +    g_assert(vmfw->fw_blob.bios_size <=3D vmfw->plat_bios_size);
> > +
> > +    /*
> > +     * bios memory region initialization will need to be performed her=
e
> > +     * if bios_size < vfw->plat_bios_size. We may need to call
> > +     * memory_region_init_ram() or memory_region_init_ram_guest_memfd(=
)
> > +     * to initialize a new bios memory region.
> > +     */
> > +
> > +    /*
> > +     * Read new BIOS from guest RAM into the BIOS region.
> > +     */
> > +    cpu_physical_memory_read(vmfw->fw_blob.bios_paddr,
> > +                             biosmem + bios_size - vmfw->fw_blob.bios_=
size,
> > +                             vmfw->fw_blob.bios_size);
> > +    x86_firmware_configure(0x100000000ULL - vmfw->fw_blob.bios_size,
> > +                           biosmem, vmfw->fw_blob.bios_size);
> > +}
> > +
> >   static void pc_machine_reset(MachineState *machine, ResetType type)
> >   {
> >       CPUState *cs;
> >       X86CPU *cpu;
> > +    VMFwUpdateState *vmfw =3D vmfwupdate_find();
> > +
> > +    /*
> > +     * When vmfwupdate device is present, handle reset actions for
> > +     * this firmware update device. The reset operations are
> > +     * defined in the device specification document. See
> > +     * docs/specs/vmfwupdate.rst.
> > +     */
> > +    if (vmfw) {
> > +        handle_vmfwupd_reset(machine, type, vmfw);
> > +    }
> >
> >       qemu_devices_reset(type);
> >
> > diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> > index 55f493521b..e806bf48f5 100644
> > --- a/hw/misc/meson.build
> > +++ b/hw/misc/meson.build
> > @@ -150,6 +150,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: fi=
les('mac_via.c'))
> >   specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c=
', 'mips_cpc.c'))
> >   specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c')=
)
> >
> > +specific_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmfwupdate.=
c'))
> > +
> >   system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
> >
> >   # HPPA devices
> > diff --git a/hw/misc/vmfwupdate.c b/hw/misc/vmfwupdate.c
> > new file mode 100644
> > index 0000000000..93474ff571
> > --- /dev/null
> > +++ b/hw/misc/vmfwupdate.c
> > @@ -0,0 +1,212 @@
> > +/*
> > + * Guest driven VM boot component update device
> > + * For details and specification, please look at docs/specs/vmfwupdate=
.rst.
> > + *
> > + * Copyright (C) 2025 Red Hat, Inc.
> > + *
> > + * Authors: Ani Sinha <anisinha@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "qemu/module.h"
> > +#include "system/reset.h"
> > +#include "hw/nvram/fw_cfg.h"
> > +#include "hw/i386/pc.h"
> > +#include "hw/qdev-properties.h"
> > +#include "hw/misc/vmfwupdate.h"
> > +#include "qemu/error-report.h"
> > +
> > +/*
> > + * the following is the list of machines currently
> > + * supporting this device.
> > + * If a new machine is added in this list, the
> > + * corresponding vm/machine reset operations must also
> > + * be implemented. Please see pc_machine_reset() ->
> > + * handle_vmfwupd_reset() as an example. The reset
> > + * implementation must adhere to the device spec.
> > + */
> > +static const char *supported_machines[] =3D {
> > +    TYPE_X86_MACHINE,
>
>
> The split between "supported" as table, but "bios_size" as function is
> weird. Can you merge them?
>
> struct vmfwupdate_machine {
>      const char *type;
>      uint64_t (*bios_size)(MachineState *ms);
> };
>
> static uint64_t get_bios_size_x86(MachineState *ms)
> {
>      return memory_region_size(&X86_MACHINE(ms)->bios);
> }
>
> static const struct vmfwupdate_machine *supported_machines[] =3D {
>      { TYPE_X86_MACHINE, get_bios_size_x86 },
> }
>
> I'm still not super happy with the layering violation yet where this
> device file needs to know about machine internals, but I also can't
> think of a better way atm. Can we somehow make it a global config from
> the machine file into a property of this device?

Yes I see what you mean. Will try to fix in the next respin.

>
>
> > +    NULL,
> > +};
> > +
> > +static const char *vmfwupdate_supported(void)
> > +{
> > +    MachineState *ms =3D MACHINE(qdev_get_machine());
> > +    const char **machine =3D supported_machines;
> > +    while (*machine) {
> > +        if (object_dynamic_cast(OBJECT(ms), *machine)) {
> > +            return *machine;
> > +        }
> > +        machine++;
> > +    }
> > +    return NULL;
> > +}
> > +
> > +static uint64_t get_bios_size(void)
> > +{
> > +    Object *m_obj =3D qdev_get_machine();
> > +    MachineState *ms =3D MACHINE(m_obj);
> > +    X86MachineState *x86ms;
> > +
> > +    if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
> > +        x86ms =3D X86_MACHINE(ms);
> > +        /*
> > +         * for pc machines, return the current size of the bios memory=
 region.
> > +         */
> > +        return memory_region_size(&x86ms->bios);
> > +    } else {
> > +        /*
> > +         * for other machine types and platforms, return 0 for now.
> > +         * non-pc machines are currently not supported anyway.
> > +         */
> > +        return 0;
> > +    }
> > +}
> > +
> > +static void fw_blob_write(void *dev, off_t offset, size_t len)
> > +{
> > +    VMFwUpdateState *s =3D VMFWUPDATE(dev);
> > +
> > +    /* for non-pc platform, we do not allow changing bios_size yet */
> > +    if (!s->plat_bios_size) {
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * in order to change the bios size, appropriate capability
> > +     * must be enabled
> > +     */
> > +    if (s->fw_blob.bios_size &&
> > +        !(s->capability & VMFWUPDATE_CAP_BIOS_RESIZE)) {
> > +        warn_report("vmfwupdate: VMFWUPDATE_CAP_BIOS_RESIZE not enable=
d");
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * For now, we do not let the guest resize the bios size to a valu=
e
> > +     * larger than the size of the memory region that holds the curren=
t image.
> > +     * If the size is larger, we may have to reinitialize the bios
> > +     * memory region. For pc, see x86_bios_rom_init().
> > +     */
> > +    if (s->fw_blob.bios_size > get_bios_size()) {
> > +        warn_report("vmfwupdate: bios size cannot be larger than %" PR=
Iu64,
> > +                    get_bios_size());
> > +        return;
> > +    }
>
>
> I don't think the resize code does anything useful at the moment. You
> can just remove it.

yeah hmm ... maybe :-)

>
>
> > +
> > +    s->plat_bios_size =3D s->fw_blob.bios_size;
> > +
> > +    return;
> > +}
> > +
> > +static void vmfwupdate_realize(DeviceState *dev, Error **errp)
> > +{
> > +    VMFwUpdateState *s =3D VMFWUPDATE(dev);
> > +    FWCfgState *fw_cfg =3D fw_cfg_find();
> > +
> > +    /* multiple devices are not supported */
> > +    if (!vmfwupdate_find()) {
> > +        error_setg(errp, "at most one %s device is permitted",
> > +                   TYPE_VMFWUPDATE);
> > +        return;
> > +    }
> > +
> > +    /* if current machine is not supported, do not initialize */
> > +    if (!vmfwupdate_supported()) {
> > +        error_setg(errp, "This machine does not support vmfwupdate dev=
ice");
> > +        return;
> > +    }
> > +
> > +    /* fw_cfg with DMA support is necessary to support this device */
> > +    if (!fw_cfg || !fw_cfg_dma_enabled(fw_cfg)) {
> > +        error_setg(errp, "%s device requires fw_cfg",
> > +                   TYPE_VMFWUPDATE);
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * If the device is disabled on purpose, do not initialize.
> > +     * Old machines like pc-i440fx-2.8 does not have enough fw-cfg slo=
ts
> > +     * and hence this device is disabled for those machines.
> > +     */
> > +    if (s->disable) {
> > +        info_report("vmfwupdate device is disabled on the command-line=
");
> > +        return;
> > +    }
>
>
> I'm still confused. A disabled device that you manually add is a device
> you may as well not add, no?

See my comment above. If we do not do this, CI was failing for some
old machines. I forgot exactly what code path was hitting.

>
>
> > +
> > +    memset(&s->fw_blob, 0, sizeof(s->fw_blob));
> > +    memset(&s->opaque_blobs, 0, sizeof(s->opaque_blobs));
> > +
> > +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_OBLOB,
> > +                             NULL, NULL, s,
> > +                             &s->opaque_blobs,
> > +                             sizeof(s->opaque_blobs),
> > +                             false);
> > +
> > +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_FWBLOB,
> > +                             NULL, fw_blob_write, s,
> > +                             &s->fw_blob,
> > +                             sizeof(s->fw_blob),
> > +                             false);
> > +
> > +    /*
> > +     * Add global capability fw_cfg file. This will be used by the gue=
st to
> > +     * check capability of the hypervisor.
> > +     * We do not allow the guest to change bios size for now.
> > +     */
> > +    s->capability =3D cpu_to_le64(CAP_VMFWUPD_MASK | VMFWUPDATE_CAP_ED=
KROM);
> > +
> > +    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_CAP,
> > +                    &s->capability, sizeof(s->capability));
> > +
> > +    s->plat_bios_size =3D get_bios_size(); /* for non-pc, this is 0 */
> > +    /* size of bios region for the platform - read only by the guest *=
/
> > +    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_BIOS_SIZE,
> > +                    &s->plat_bios_size, sizeof(s->plat_bios_size));
> > +    /*
> > +     * add fw cfg control file to disable the hypervisor interface.
> > +     */
> > +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_CONTROL,
> > +                             NULL, NULL, s,
> > +                             &s->disable,
> > +                             sizeof(s->disable),
> > +                             false);
> > +    /*
> > +     * This device requires to register a global reset because it is
> > +     * not plugged to a bus (which, as its QOM parent, would reset it)=
.
> > +     */
> > +    qemu_register_resettable(OBJECT(s));
> > +}
> > +
> > +static const Property vmfwupdate_properties[] =3D {
> > +    DEFINE_PROP_UINT8("disable", VMFwUpdateState, disable, 0),
> > +};
> > +
> > +static void vmfwupdate_device_class_init(ObjectClass *klass, void *dat=
a)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    /* we are not interested in migration - so no need to populate dc-=
>vmsd */
> > +    dc->desc =3D "VM firmware update device";
> > +    dc->realize =3D vmfwupdate_realize;
> > +    dc->hotpluggable =3D false;
> > +    device_class_set_props(dc, vmfwupdate_properties);
> > +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> > +}
> > +
> > +static const TypeInfo vmfwupdate_device_types[] =3D {
> > +    {
> > +        .name          =3D TYPE_VMFWUPDATE,
> > +        .parent        =3D TYPE_DEVICE,
> > +        .instance_size =3D sizeof(VMFwUpdateState),
> > +        .class_init    =3D vmfwupdate_device_class_init,
> > +    },
> > +};
> > +
> > +DEFINE_TYPES(vmfwupdate_device_types)
> > diff --git a/include/hw/misc/vmfwupdate.h b/include/hw/misc/vmfwupdate.=
h
> > new file mode 100644
> > index 0000000000..adddb4cc23
> > --- /dev/null
> > +++ b/include/hw/misc/vmfwupdate.h
> > @@ -0,0 +1,105 @@
> > +/*
> > + * Guest driven VM boot component update device
> > + * For details and specification, please look at docs/specs/vmfwupdate=
.rst.
> > + *
> > + * Copyright (C) 2025 Red Hat, Inc.
> > + *
> > + * Authors: Ani Sinha <anisinha@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +#ifndef VMFWUPDATE_H
> > +#define VMFWUPDATE_H
> > +
> > +#include "hw/qdev-core.h"
> > +#include "qom/object.h"
> > +#include "qemu/units.h"
> > +
> > +#define TYPE_VMFWUPDATE "vmfwupdate"
> > +
> > +#define VMFWUPDCAPMSK  0xffff /* least significant 16 capability bits =
*/
> > +
> > +#define VMFWUPDATE_CAP_EDKROM 0x08 /* bit 4 represents support for EDK=
ROM */
>
>
> What does this CAP stand for? It's not mentioned in the documentation.

yes good catch. We do not need this anymore since hypervisor does not
care about the type of firmware (or whether it is a container like
IGVM instead of a firmware).

>
>
> > +#define VMFWUPDATE_CAP_BIOS_RESIZE 0x04 /* guests may resize bios regi=
on */
>
>
> This definition contradicts the documentation.

Will fix.

>
>
> > +#define CAP_VMFWUPD_MASK 0x80
>
>
> What is this for?

Will remove.


>
>
> Alex
>
>


