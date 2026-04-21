Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A483F327CF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 09:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF7fn-00048D-7m; Tue, 21 Apr 2026 05:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wF7fl-00047A-Ah
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 05:45:37 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wF7fj-0001ja-Gn
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 05:45:37 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c70fb6aa323so1360231a12.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 02:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776764734; x=1777369534; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1jVL1LNffz2XuEwtsS228+wq1RvyVcmr3CNu77pcIF4=;
 b=XSySg0RmkkG2nCy6iKPIlqCqUHFxYnji6f1x4IiH3vBP5Hitih9IjUuCch7/3W+q9r
 9QGTphV0l1ZxFeaCtVb93KLhTT15z6v4fGYvY+GfI6CzTSo0Vj2xBxgCeLB0WOIjmmMl
 YQTQCqKboLLO6QjqrOmafpJSC8uMImsKaqSCfmHJpioFFUhm57zoTXk3wvIe7nCM6hbz
 oi58VC/EURBGv8h7uC/FwEwn9Uc7RQJ4hCyTg+1DmRl0YPE/o46iXNrghibQQkgfJGVW
 Ko9jmwDk7kdqTezwuDvmfbedEPH9FT+GvmLv0Mr3MWkTS3Qs8VnO7LVanogVnaTrTIsL
 wWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776764734; x=1777369534;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1jVL1LNffz2XuEwtsS228+wq1RvyVcmr3CNu77pcIF4=;
 b=Loal1bvKhLA9jlgUFjLmOchU4PKWaDWpZb+MpUTJ8gAJQahSQ5Mr6eZ8C9jMlMyod8
 DzvzxyZNtyvilXJzaRxamI4yX2tCefuAjsqSYiBXxEe2uiBWaUFgpeAfgVzWXV3hpbGT
 MclpRoSjZ3A4sM6gBvCSofF0hXZUQi9r+3KN94Hwf46NU0XKyLpzy939bpIQml5LnoLx
 j5msFCKMm5YvePvkOczxZbr6uio4DesoREDYpAOWCjfrj+shoC1FpGRsNr/Lt01voEZ/
 utPLKotAvaXgbmWq8btT2M9wX7GztWv73I9/iVEtd46QWY5hLR+XPTAZ6TMGS0Ghm6gF
 CP8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3+NWjX6qYxrRs/cBat8e2AaNGdJgnnvczrTq+71bANHPI8FVrR/LzgA7zAhY7BWQEwcIVntMa9I8h@nongnu.org
X-Gm-Message-State: AOJu0YyUTIVlymWkUxJlQUkkcAAX/Ahc1hA5cJ6cRZC0z3JtAIc2D/K8
 oRevSGL2n6uCzLThFshUwkpnVDbgoSnMT5IlWDd/lYkgfAuktU/0cob+
X-Gm-Gg: AeBDieuRgckpExwJIkzPw/nak57YDeO8FoHcmczA+sl5ErZWEanFAE+r6OrcqZXSxOw
 7TwcE4OESIIncp651Rjv5eeitzLcnKOs/8A5cTDeYykYrMj0IxG5jdXw6WWL5abW7UVLyYFPkU3
 Pp9qU5OiVNNRyhU6I4R/CqKzSWEqxkJwOYGPZn7ZFgVG/bRRBlEIcqKyWBd+OCydNwdLwvJJmfq
 eyaIuO2SP+whxLv27Bidl+j7Yc7NFkKnYJq8QRnx9XXXlCW9jbHCfT4asD19E5rjtTlrVRCbx96
 rUaHLI/wVyhW/8mCJHVQcKRabXgSjZ5xQrpiJn/a04pFDHJ6bvs3Q6QCTgS3EnDZZzmtqwt10bc
 BB8DtobFVqwX/d4YcbAZOQ1ghKqeibQ4EzudShBwDi9IRh/z8Um5xNr3lsSyex9SB5ZI1X8Zo6n
 7N6Wxo89zup+KbFjCwlnUY5unwI6BBVRosGAtBvbWMQdE2dVs4aZy8ASITvgE/u59jDZ6dqfCUI
 g==
X-Received: by 2002:aa7:8892:0:b0:82a:190b:2225 with SMTP id
 d2e1a72fcca58-82f8c8bb677mr18417373b3a.31.1776764733824; 
 Tue, 21 Apr 2026 02:45:33 -0700 (PDT)
Received: from localhost (203-214-45-63.dyn.iinet.net.au. [203.214.45.63])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e981a0asm13845521b3a.3.2026.04.21.02.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 02:45:33 -0700 (PDT)
Date: Tue, 21 Apr 2026 19:45:30 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Joel Stanley <joel@jms.id.au>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 11/13] tests/functional/riscv64: Add tt-atlantis tests
Message-ID: <aedEGxGq1qKhGI5d@lima-default>
References: <20260421053140.752059-1-joel@jms.id.au>
 <20260421053140.752059-12-joel@jms.id.au>
 <87ba28f4-aeab-4015-8f9c-9d3a53c0cb7a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ba28f4-aeab-4015-8f9c-9d3a53c0cb7a@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Apr 21, 2026 at 08:05:48AM +0200, Philippe Mathieu-Daudé wrote:
> On 21/4/26 07:31, Joel Stanley wrote:
> > From: Nicholas Piggin <npiggin@gmail.com>
> > 
> > Add OpenSBI and Linux boot tests for the tt-atlantis machine. Based on
> > tests/functional/riscv64/test_sifive_u.py.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> > v3:
> >   - Fix path to test files
> >   - Dedupe command line root argument
> >   - Remove unused import
> > ---
> >   MAINTAINERS                                  |  1 +
> >   tests/functional/riscv64/meson.build         |  1 +
> >   tests/functional/riscv64/test_opensbi.py     |  4 ++
> >   tests/functional/riscv64/test_tt_atlantis.py | 63 ++++++++++++++++++++
> >   4 files changed, 69 insertions(+)
> >   create mode 100755 tests/functional/riscv64/test_tt_atlantis.py
> 
> 
> > diff --git a/tests/functional/riscv64/test_tt_atlantis.py b/tests/functional/riscv64/test_tt_atlantis.py
> > new file mode 100755
> > index 000000000000..f6f4b7ceec34
> > --- /dev/null
> > +++ b/tests/functional/riscv64/test_tt_atlantis.py
> > @@ -0,0 +1,63 @@
> > +#!/usr/bin/env python3
> > +#
> > +# Functional test that boots a Linux kernel on a Tenstorrent Atlantis machine
> > +# and checks the console
> > +#
> > +# Copyright (c) Linaro Ltd.
> > +# Copyright 2026 Tenstorrent
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +import os
> > +
> > +from qemu_test import Asset, LinuxKernelTest
> > +
> > +
> > +class TTAtlantis(LinuxKernelTest):
> > +
> > +    ASSET_KERNEL = Asset(
> > +        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
> > +        '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0')
> > +    ASSET_ROOTFS = Asset(
> > +        ('https://github.com/groeck/linux-build-test/raw/'
> > +         '9819da19e6eef291686fdd7b029ea00e764dc62f/rootfs/riscv64/'
> > +         'rootfs.ext2.gz'),
> > +        'b6ed95610310b7956f9bf20c4c9c0c05fea647900df441da9dfe767d24e8b28b')
> > +
> > +    def do_test_riscv64_tt_atlantis(self, connect_disk):
> > +        self.set_machine('tt-atlantis')
> > +        kernel_path = self.ASSET_KERNEL.fetch()
> > +        rootfs_path = self.uncompress(self.ASSET_ROOTFS)
> > +
> > +        self.vm.set_console()
> > +        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'earlycon=sbi '
> > +
> > +        if connect_disk:
> > +            kernel_command_line += 'root=/dev/vda panic=-1 noreboot rootwait '
> > +            self.vm.add_args('-device',
> > +                             'virtio-blk,drive=drive0,serial=0x1234,bus=pcie.0')
> > +            self.vm.add_args('-drive',
> > +                             f'file={rootfs_path},if=none,id=drive0,format=raw')
> > +            pattern = 'Boot successful.'
> 
> Should we run a full shutdown to test up to the halting payload
> (patch #4)?

Halting payload is only used when there is no kernel given, not sure if
it's good cost/benefit to test that, it's just in case user screw up
they don't get blank screen apparent hang.

A shutdown test all the way to machine halt would be good, although I
don't know if we model that properly in the atlantis machine yet. Maybe
something to expand on later.

> 
> > +        else:
> > +            kernel_command_line += 'panic=0 noreboot '
> > +            pattern = 'Cannot open root device'
> > +
> > +        self.vm.add_args('-kernel', kernel_path,
> > +                         '-append', kernel_command_line,
> > +                         '-no-reboot')
> > +
> > +        self.vm.launch()
> > +        self.wait_for_console_pattern(pattern)
> > +
> > +        os.remove(rootfs_path)
> 
> Since you call uncompress() with implicit @target=None argument,
> scratch_file() is used:
> 
>         Construct a path for accessing/creating a scratch file
>         located relative to a temporary directory dedicated to
>         this test case. The directory and its contents will be
>         purged upon completion of the test.
> 
> So IIUC no need to remove manually. Do you have an issue with it
> to remove it manually?

No, I just copied it from tests/functional/riscv64/test_sifive_u.py :)
and looks like same pattern exists in a couple of other tests as well.

> 
> Otherwise,
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks,
Nick

> 
> > +
> > +    def test_riscv64_tt_atlantis(self):
> > +        self.do_test_riscv64_tt_atlantis(False)
> > +
> > +    def test_riscv64_tt_atlantis_disk(self):
> > +        self.do_test_riscv64_tt_atlantis(True)
> > +
> > +
> > +if __name__ == '__main__':
> > +    LinuxKernelTest.main()
> 
> 

