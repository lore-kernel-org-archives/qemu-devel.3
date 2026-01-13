Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5A5D29DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 05:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfXLb-00011L-NP; Tue, 13 Jan 2026 00:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfXLa-000109-G3
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 00:53:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfXLY-0003L4-If
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 00:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768283619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iwDtBG4DSdGTYGX7C7i9PdDuObgOaMm8Dc3l5HZo0fQ=;
 b=Z0mFS9/c2rxtXNbnjks/rSZRapOu7/RLcGyxv7rx1//vsQmKI+dlegaY7woGIbfG6JqQ0a
 9a0AlH3GYAp1btXBe9dqCHlYrIMj021bPfD5wgeGmZjZEz60bWaWvR2e8ju2joxt7DM+et
 We1HYEvI40I63VxP9QpsohDrpvCizNg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-AxCq1ZZ1Pzyw2uObkb86DQ-1; Tue, 13 Jan 2026 00:53:37 -0500
X-MC-Unique: AxCq1ZZ1Pzyw2uObkb86DQ-1
X-Mimecast-MFC-AGG-ID: AxCq1ZZ1Pzyw2uObkb86DQ_1768283617
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8887c0d3074so188831366d6.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 21:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768283617; x=1768888417; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iwDtBG4DSdGTYGX7C7i9PdDuObgOaMm8Dc3l5HZo0fQ=;
 b=gC8CBFA4KxSNiZK5MT0QFDPfDYMfL8761qT02QlQ2Yr3WVh23qObWgYXQkEYtrqI0s
 M3bAGoABHfV9pnuZyuo14nzH+K3E2HsdT74q7vfD/X/AJ8pSz8z5J7Txn8Z7uC8cfwiF
 CNieBSQxiO7QzZxDo68ar+7V4yy77Ex+MnlwHgCAdFktnQeXQY8U0tSYPmTBnZAFdbeL
 NlFIsihKTkvhY8FH/ZEaNBRcQSqaEr0to7OBfyD7CCwSHgwLj7+Nz5OkbkcpQP7+9Y1E
 Gg4OoAdfXL1Kw88M7uIYQys1EWI46Y93GB6ECUqlKxip1kVV7y8QvNyoVYgdUkNpSwrU
 PYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768283617; x=1768888417;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iwDtBG4DSdGTYGX7C7i9PdDuObgOaMm8Dc3l5HZo0fQ=;
 b=NgnzPCvpioCizByz9DhOwVm4j2JAk5h2DQ/6hyZbJPhy77E38+iC77ogciGVZeg9za
 RBsZNNbgop9xdas21bBiG7g0NAyn0MwtIm0daZsW1oDbPvSaYBe3AI0onCod43FfIWUx
 3CIzi4oD1ShfKo4Pdv1ZNuo+OuKr4oNRdi+EQyoCct2R1sS4DKnRoGPL6mwKiZQIowmt
 0FzS87JZsO23g/t0EyiLmqAa0ortXHdLHEOdu7X1eMuArz//cNTn0Lb6nVUd3qO6pf3y
 G+Dz3VSk3E4jno1NTBwMYFkcwD88QkfaM9gXKKB6MttTt5NLsm1IXDIKp7ENt2HKZzVd
 CX3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUaRfxANi0m0hrWQDshVYeY9nO33qJAoig5T5CMFBSfMJ7J6d9poAXjf1hF9opqAr+6nYlu9X5gMHm@nongnu.org
X-Gm-Message-State: AOJu0YzmkA8mB25N3y2w5Tl9U4VS7w7nUuxZBkoJKovTa/0wshxPmwun
 FRyP4ZT/0JPrYfoGdhRWZOt6wNqQC3e7s98dfwnv1WpmlL8MO2EVqatjbiTXgrPQAHkRlWiuqDy
 cBniG8VcQPAebnkH7dMNznTv+V2zawZRB2GYSlx+Q0wCmUr9UQ+Fz/SnH9AHuHe+sdkHA1zj5w3
 EHowtqIpx239F+kGwlKufKYApwnmaMozY=
X-Gm-Gg: AY/fxX66oa17BUPcgrTdTfWYAGhjLo9Q86pPFTWacDg7oAg0+hUv70bkQvIJf1W5nZf
 FAR2hQu9YeLr0GWWmHIu7JqiK4seU2uxkrP8sPdWme+o6dIGIeHlERV0lw6CVO3eTzTykRngMhr
 7U1l5ewEHYxjm39JfCsMAO2iaxJ2fr7aShmXvbmK5ySPY+vNut34ZQdHfN1m3cdF2ORlsfJKDCP
 2WcnCjIFsN0tApq93lfzTMTNsw=
X-Received: by 2002:a05:6214:3d98:b0:890:5841:8554 with SMTP id
 6a1803df08f44-8908417515amr246894046d6.9.1768283617049; 
 Mon, 12 Jan 2026 21:53:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhl3ZG/pcyEq8PEqQ2r22cHyiOaqf0de41i4z6HOPEWmMqJw6Ud76loYV8CtL20JUPpMhbVs4ZhhJd30ernPo=
X-Received: by 2002:a05:6214:3d98:b0:890:5841:8554 with SMTP id
 6a1803df08f44-8908417515amr246893916d6.9.1768283616631; Mon, 12 Jan 2026
 21:53:36 -0800 (PST)
MIME-Version: 1.0
References: <20260112132259.76855-1-anisinha@redhat.com>
 <20260112132259.76855-33-anisinha@redhat.com>
 <aWUDCR5EQmWDWrob@redhat.com>
In-Reply-To: <aWUDCR5EQmWDWrob@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 13 Jan 2026 11:23:25 +0530
X-Gm-Features: AZwV_Qhqqtbui-nhR2ePTrUc1IV4Torb5e4d0T0Wmwlg-JK3_yBD9bBQqn-wfcg
Message-ID: <CAK3XEhOs2=yL6UM6hBxs9Z6gzrCUVWSuYM5TE9COJpxqFC-1_A@mail.gmail.com>
Subject: Re: [PATCH v2 32/32] tests/functional/x86_64: add functional test to
 exercise vm fd change on reset
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jan 12, 2026 at 8:06=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Mon, Jan 12, 2026 at 06:52:45PM +0530, Ani Sinha wrote:
> > A new functional test is added that exercises the code changes related =
to
> > closing of the old KVM VM file descriptor and opening a new one upon VM=
 reset.
> > This normally happens when confidential guests are resetted but for
> > non-confidential guests, we use a special machine specific debug/test p=
arameter
> > 'x-change-vmfd-on-reset' to enable this behavior.
> > Only specific code changes related to re-initialization of SEV-ES, SEV-=
SNP and
> > TDX platforms are not exercized in this test as they require hardware t=
hat
> > supports running confidential guests.
> >
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > ---
> >  MAINTAINERS                                   |  6 ++
> >  tests/functional/x86_64/meson.build           |  1 +
> >  .../x86_64/test_vmfd_change_reboot.py         | 75 +++++++++++++++++++
> >  3 files changed, 82 insertions(+)
> >  create mode 100755 tests/functional/x86_64/test_vmfd_change_reboot.py
>
>
> > diff --git a/tests/functional/x86_64/test_vmfd_change_reboot.py b/tests=
/functional/x86_64/test_vmfd_change_reboot.py
> > new file mode 100755
> > index 0000000000..3b33322880
> > --- /dev/null
> > +++ b/tests/functional/x86_64/test_vmfd_change_reboot.py
> > @@ -0,0 +1,75 @@
> > +#!/usr/bin/env python3
> > +#
> > +# KVM VM file descriptor change on reset test
> > +#
> > +# Copyright =C2=A9 2026 Red Hat, Inc.
> > +#
> > +# Author:
> > +#  Ani Sinha <anisinha@redhat.com>
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +import os
> > +from qemu.machine import machine
> > +
> > +from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for=
_pattern
> > +from qemu_test import wait_for_console_pattern
> > +
> > +class KVMGuest(QemuSystemTest):
> > +
> > +    ASSET_UKI =3D Asset('https://gitlab.com/anisinha/misc-artifacts/'
> > +                      '-/raw/main/uki.x86-64.efi?ref_type=3Dheads',
> > +                      'e0f806bd1fa24111312e1fe849d2ee69808d4343930a5'
> > +                      'dc8c1688da17c65f576')
> > +    ASSET_OVMF =3D Asset('https://gitlab.com/anisinha/misc-artifacts/'
> > +                       '-/raw/main/OVMF.stateless.fd?ref_type=3Dheads'=
,
> > +                       '58a4275aafa8774bd6b1540adceae4ea434b8db75b476'
> > +                       '11839ff47be88cfcf22')
>
> What is the source of these two binaries - the repo doesn't show any
> source code or references ?

For ASSET_UKI, it was built using
https://gitlab.com/kraxel/edk2-tests/-/blob/unittest/tools/make-supermin.sh
Maybe I can add a comment in the test as such.

ASSET_OVMF is a little more complicated ...

> Is there no way we can use standard distro
> images for this test ?

ASSET_OVMF comes from /usr/share/edk2/ovmf/OVMF.stateless.fd of a fc43
VM. It comes from edk2-ovmf-20251119-3.fc43.noarch rpm.
This rpm must be installed in the container where the test is run. I
checked that CI images we use do not have this rpm or the edk2 binary.
In fact, we do not have OVMF.amdsev.fd or its TDX variant or any of
OVMF_CODE.secboot.fd etc either. OVMF packages are simply not in the
container images generated.

There are two reasons why I did it this way -
a) I know the long path to adding a package into all CI container
images and I wanted to avoid doing that just as yet since ...
b) as we spoke offline, even if we did add the package, since /dev/kvm
is not available, this test will be skipped and not run in CI.

So for this test to run successfully, we must enable kvm tests in CI
(have /dev/kvm available). Then we can add the above package and
remove this. Also skip the test where OVMF.stateless.fd is not
available.

For now, I wanted to make sure at least everyone can run this test
manually where kvm is available even if they do not have the package
installed or if the package is not available for their host OS (for
example RHEL-9.6 does not have the stateless variant).


>
> > +
> > +    def common_vm_setup(self):
> > +        self.require_accelerator("kvm")
> > +
> > +        self.vm.set_console()
> > +
> > +        self.vm.add_args("-accel", "kvm")
> > +        self.vm.add_args("-smp", "2")
> > +        self.vm.add_args("-cpu", "host")
> > +        self.vm.add_args("-m", "2G")
> > +        self.vm.add_args("-nographic", "-nodefaults")
> > +
> > +        self.uki_path =3D self.ASSET_UKI.fetch()
> > +        self.ovmf_path =3D self.ASSET_OVMF.fetch()
> > +
> > +    def run_and_check(self):
> > +        self.vm.add_args('-kernel', self.uki_path)
> > +        self.vm.add_args("-bios", self.ovmf_path)
> > +        # enable KVM VMFD change on reset for a non-coco VM
> > +        self.vm.add_args("-machine", "q35,x-change-vmfd-on-reset=3Don"=
)
> > +        # enable tracing
> > +        self.vm.add_args("-d", "trace:kvm_reset_vmfd")
> > +
> > +        try:
> > +            self.vm.launch()
> > +        except machine.VMLaunchFailure as e:
> > +            raise e
> > +
> > +        self.log.info('VM launched')
> > +        console_pattern =3D 'bash-5.1#'
> > +        wait_for_console_pattern(self, console_pattern)
> > +        self.log.info('VM ready with a bash prompt')
> > +
> > +        exec_command_and_wait_for_pattern(self, '/usr/sbin/reboot -f',
> > +                                          'reboot: machine restart')
> > +        console_pattern =3D '# --- Hello world ---'
> > +        wait_for_console_pattern(self, console_pattern)
> > +        self.vm.shutdown()
> > +        self.assertRegex(self.vm.get_log(),
> > +                         r'kvm_reset_vmfd \nINFO: virtual machine acce=
l file '
> > +                         'descriptor has changed')
> > +
> > +    def test_vmfd_change_on_reset(self):
> > +        self.common_vm_setup()
> > +        self.run_and_check()
> > +
> > +if __name__ =3D=3D '__main__':
> > +    QemuSystemTest.main()
> > --
> > 2.42.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


