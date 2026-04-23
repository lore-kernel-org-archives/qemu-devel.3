Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FC5FAD3EC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 02:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFjlE-0002t9-SJ; Wed, 22 Apr 2026 22:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wFjlB-0002rY-Ec
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:25:45 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wFjl9-0001Ul-Kr
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:25:45 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-799001d73bdso43744307b3.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 19:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776911142; cv=none;
 d=google.com; s=arc-20240605;
 b=PSvD+ZI5ifsjjGpVmpWGe9Cbg+0Jp6hTEN2NnTSTkag8wdrmENtjWsbKTOG2Xa4XBU
 RHWGvvXH0hHF7+NEfemGSP+/VUnstGieGj4z70X0VayM8N4tnPJ0KRY2NgkyDItSj7ph
 cLnVAijLbGXhMo5gq6YbLwEKyik34nyfF59BqiScwcnTzpjHwFIQVz8DdUEjOGpxhuIG
 lhET5U7YR/XJMEXBDODFeO0TIYWqdyN5y8urMHtzjmk+QUxz/B/LYtb4tpdsZha0Tckd
 Y1VWYKr/E61VDKUSquCrox/KRHpMJuvP2SM0RUnBhxvIS6sFcHNPt292WVpV0rJenQIx
 1NAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VLn3Fuy+S55qq5Y7iI7YlfV3HKtC4OgHGc0P8JqC+98=;
 fh=mznYpu65tKvpKsO6j4LQbbgTcALS8o/ugSfQAc+8LVg=;
 b=W1fXcWy8Rzqjw+zEvyT68oOmkGy24XPNshoyFaMVfoB7Q/DhBVtQy0QBUwrW/do0+g
 ro5aMdmrKJ2/5F1T6Tbnsv0C+MGA8B2VMBOrCHX0WOa88JicDQnjEQEVGxvbhfrPsOzH
 C5bGHqtAarFUPSRjpGbpZ+d45OLenYlAN45O4mhKeyFfR48K5t8D48LEQVkXF7G+9j+a
 DIOimFbq0K+I1j5Viuqz0qG+LFusGayxG0cb++h8qa/XycwwFwt9BUwwBbE0kcuXm4pq
 K3Hg7PP14ZqD2k1ttJP32akYwS9znv9d121P1qZ8xd0kKvt19ZdVIH6GAPKP4EoxS7B6
 QPQw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1776911142; x=1777515942; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VLn3Fuy+S55qq5Y7iI7YlfV3HKtC4OgHGc0P8JqC+98=;
 b=GIrGLokVvP5mcK+CkuySn7Ww6bd394CiL4iCDEFS5P1JPliuPhak0ByRwccimXMk7y
 2tJ83nC7UVXT0ipYfUKV+NpcQvwpKRjSrLePpExYnY7rkWF0tgGH65r/P6NER8lcM0DL
 UtgMFPFEp/KNl6iHCBJcg6DesSUBmItgIEVDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776911142; x=1777515942;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VLn3Fuy+S55qq5Y7iI7YlfV3HKtC4OgHGc0P8JqC+98=;
 b=SJGI+Gsb0/L/x4eCKDI8+pHlV2ucMWOQv8+6iVeSaW2vWGEglkvuqNvblMJ4nHNGOq
 4nKk1QVWXA5sgWSiyFuQ+0gX/HujHdYF57wIxInVDN9kmjXa6nyVK2yRQZsaz/RmmGmu
 tBfKzvxvagt1YkDe0lD60zOzrJKYxBbBWGAkY3/h8+baNpgIpL1yotwIFHTMjBDLsxZz
 yY/MLBZnva9rDI8slEJBSJiQe/pcDZ3wK9NZlP25n7ag3UBmH0187rT0bQzy9NSKtIjc
 clYblFsO2GrApKNOhcdYxjQMn5Fx445BLCqGSCpuvqay48PIhLpvOpGvIowWksml2YdU
 6SHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9XehQo2zCrv2bDLVIIKxJzvDop4W9ld0HM+B8Bt1/otFNr5zbVaWnCgBGlx2dv0dEWB43QWJ3BC10Y@nongnu.org
X-Gm-Message-State: AOJu0Yy8I+s+fcp/dlIB10CzU9pjnw/tKUDnt9aQEW4GbDemg+p6ajrN
 lEScK2bfUsHO57IvRSVkabr+Y9Z3KuQTVkZ7w0K5DCo9UdJoOzBOdgCsueKP/w+LXkB0ifLKA1O
 77u0ijrRyTMNSfEc2imf8tKqT1HK4Dfk=
X-Gm-Gg: AeBDietkR9pfaEiU2yekFN+AAm1oO6Ugz/telmjIPpyfW0CMklaXFpfqAgzOugbprDS
 f7a/6GLOYk4xnnBKnRzBDv4qCkEX+I4Hs6DGips0NfQturU1c4lFbzA0/OftL04AVJ1fc3LK6oo
 VnfB25IRJVwVuiNOjYjNxyOOsvgOvHze33epcTraiLK+jmVI+dtXQ1ewGe7+BKHxqDtijdpUZwu
 4DJi15XqeajS7wb/rLZy9arH8hz2PLSUUFpbkf1A1wz8yO7YSDKS+kilw0ScZfbGey/6ZjbKVE7
 WUE9dWMC1PBQazN/9jA6It1x7pNFQMsqHp+l6I+X5xRPJpGSSsAFyTLoRrOGTLROJZb+t+adtgX
 w
X-Received: by 2002:a05:690c:1d:b0:7b8:338d:7d6f with SMTP id
 00721157ae682-7b9ecf7aefbmr254393587b3.25.1776911142279; Wed, 22 Apr 2026
 19:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260421053140.752059-1-joel@jms.id.au>
 <20260421053140.752059-12-joel@jms.id.au>
 <87ba28f4-aeab-4015-8f9c-9d3a53c0cb7a@linaro.org>
 <aedEGxGq1qKhGI5d@lima-default>
 <c0fbd10c-9e6b-4d6d-8c5c-92645d2746d9@linaro.org>
In-Reply-To: <c0fbd10c-9e6b-4d6d-8c5c-92645d2746d9@linaro.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 23 Apr 2026 12:25:31 +1000
X-Gm-Features: AQROBzBAQwJtcWxJZRdWqaRm6Jh5SJGwqVM6PxSswy2X7YB8rSnTXuzJm6KeOEc
Message-ID: <CACPK8Xc5DSN9dCbFv=E1H9mKG2F40WYt39D5mLogOe1xekXuwA@mail.gmail.com>
Subject: Re: [PATCH v3 11/13] tests/functional/riscv64: Add tt-atlantis tests
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Michael Ellerman <mpe@kernel.org>, 
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=joel.stan@gmail.com; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 22 Apr 2026 at 01:35, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 21/4/26 11:45, Nicholas Piggin wrote:
> > On Tue, Apr 21, 2026 at 08:05:48AM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
> >> On 21/4/26 07:31, Joel Stanley wrote:
> >>> From: Nicholas Piggin <npiggin@gmail.com>
> >>>
> >>> Add OpenSBI and Linux boot tests for the tt-atlantis machine. Based o=
n
> >>> tests/functional/riscv64/test_sifive_u.py.
> >>>
> >>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >>> Signed-off-by: Joel Stanley <joel@jms.id.au>
> >>> ---
> >>> v3:
> >>>    - Fix path to test files
> >>>    - Dedupe command line root argument
> >>>    - Remove unused import
> >>> ---
> >>>    MAINTAINERS                                  |  1 +
> >>>    tests/functional/riscv64/meson.build         |  1 +
> >>>    tests/functional/riscv64/test_opensbi.py     |  4 ++
> >>>    tests/functional/riscv64/test_tt_atlantis.py | 63 ++++++++++++++++=
++++
> >>>    4 files changed, 69 insertions(+)
> >>>    create mode 100755 tests/functional/riscv64/test_tt_atlantis.py
> >>
> >>
> >>> diff --git a/tests/functional/riscv64/test_tt_atlantis.py b/tests/fun=
ctional/riscv64/test_tt_atlantis.py
> >>> new file mode 100755
> >>> index 000000000000..f6f4b7ceec34
> >>> --- /dev/null
> >>> +++ b/tests/functional/riscv64/test_tt_atlantis.py
> >>> @@ -0,0 +1,63 @@
> >>> +#!/usr/bin/env python3
> >>> +#
> >>> +# Functional test that boots a Linux kernel on a Tenstorrent Atlanti=
s machine
> >>> +# and checks the console
> >>> +#
> >>> +# Copyright (c) Linaro Ltd.
> >>> +# Copyright 2026 Tenstorrent
> >>> +#
> >>> +# SPDX-License-Identifier: GPL-2.0-or-later
> >>> +
> >>> +import os
> >>> +
> >>> +from qemu_test import Asset, LinuxKernelTest
> >>> +
> >>> +
> >>> +class TTAtlantis(LinuxKernelTest):
> >>> +
> >>> +    ASSET_KERNEL =3D Asset(
> >>> +        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
> >>> +        '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e98414=
90fb0')
> >>> +    ASSET_ROOTFS =3D Asset(
> >>> +        ('https://github.com/groeck/linux-build-test/raw/'
> >>> +         '9819da19e6eef291686fdd7b029ea00e764dc62f/rootfs/riscv64/'
> >>> +         'rootfs.ext2.gz'),
> >>> +        'b6ed95610310b7956f9bf20c4c9c0c05fea647900df441da9dfe767d24e=
8b28b')
> >>> +
> >>> +    def do_test_riscv64_tt_atlantis(self, connect_disk):
> >>> +        self.set_machine('tt-atlantis')
> >>> +        kernel_path =3D self.ASSET_KERNEL.fetch()
> >>> +        rootfs_path =3D self.uncompress(self.ASSET_ROOTFS)
> >>> +
> >>> +        self.vm.set_console()
> >>> +        kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'e=
arlycon=3Dsbi '
> >>> +
> >>> +        if connect_disk:
> >>> +            kernel_command_line +=3D 'root=3D/dev/vda panic=3D-1 nor=
eboot rootwait '
> >>> +            self.vm.add_args('-device',
> >>> +                             'virtio-blk,drive=3Ddrive0,serial=3D0x1=
234,bus=3Dpcie.0')
> >>> +            self.vm.add_args('-drive',
> >>> +                             f'file=3D{rootfs_path},if=3Dnone,id=3Dd=
rive0,format=3Draw')
> >>> +            pattern =3D 'Boot successful.'
> >>
> >> Should we run a full shutdown to test up to the halting payload
> >> (patch #4)?
> >
> > Halting payload is only used when there is no kernel given, not sure if
> > it's good cost/benefit to test that, it's just in case user screw up
> > they don't get blank screen apparent hang.
> >
> > A shutdown test all the way to machine halt would be good, although I
> > don't know if we model that properly in the atlantis machine yet. Maybe
> > something to expand on later.
>
> OK, then we are good.

Yep. I plan to add more to this test as we model more of the machine.

>
> >>> +        else:
> >>> +            kernel_command_line +=3D 'panic=3D0 noreboot '
> >>> +            pattern =3D 'Cannot open root device'
> >>> +
> >>> +        self.vm.add_args('-kernel', kernel_path,
> >>> +                         '-append', kernel_command_line,
> >>> +                         '-no-reboot')
> >>> +
> >>> +        self.vm.launch()
> >>> +        self.wait_for_console_pattern(pattern)
> >>> +
> >>> +        os.remove(rootfs_path)
> >>
> >> Since you call uncompress() with implicit @target=3DNone argument,
> >> scratch_file() is used:
> >>
> >>          Construct a path for accessing/creating a scratch file
> >>          located relative to a temporary directory dedicated to
> >>          this test case. The directory and its contents will be
> >>          purged upon completion of the test.
> >>
> >> So IIUC no need to remove manually. Do you have an issue with it
> >> to remove it manually?
> >
> > No, I just copied it from tests/functional/riscv64/test_sifive_u.py :)
> > and looks like same pattern exists in a couple of other tests as well.
>
> Good opportunity to clean it ;)

I dropped the os.remove from our test. I'll send a cleanup patch for
the sifive machine when I get a chance.

