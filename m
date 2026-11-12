Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55AF606A882
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gtU4BI1G;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=uA+OV6SL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRURO-0008Vt-Gm; Thu, 12 Nov 2026 08:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xRUR4-0008JE-BJ
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:01:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xRUR1-0005KZ-L3
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794488505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UHQkWKHi24ETaBgrS9DU//2QPz2lkclM7vZqrU625VU=;
 b=gtU4BI1GW20fvRPRxTN5fzBDlIkEEEZFKID+V7Nw09ep3cj6UFy//3N7AugSDMcZg0x6un
 72RP2DlecF6RavqIaLGktyh1/jfGPEzCQ7j8vUKyq5FagKep4/v33g2vZ9tJe5fVwvCM2o
 8YhyUySrv9xuzHT1v6e9nCWmyfiXhb0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-uC65tRtGM5C1CSoXMwJ5Bw-1; Thu, 12 Nov 2026 08:01:42 -0500
X-MC-Unique: uC65tRtGM5C1CSoXMwJ5Bw-1
X-Mimecast-MFC-AGG-ID: uC65tRtGM5C1CSoXMwJ5Bw_1794488502
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ea381ce04fso15133555ad.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 05:01:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794488502; cv=none;
 d=google.com; s=arc-20260327;
 b=gcc8IUW9DuUYFe0WKmkWAOcGJc+7anxkypXbkmzx1sWogdasrc96qeUf6RMH0KRd8s
 OYp1QmhE+AQ/LuCaaEBzibiO46Y+TJ7X7/o3qEavS9WmrU7sdNN/rKlG2O4/kH4Df6RM
 33Ad1O1VPXwMX78OgCk3MTltgEVBlFGFNsO7lfTwenjGqago7CLtEwnVpBxRtqhpaQiR
 r4/YQJeNBFBTxOoVa9jttHn7OEpSz0Zf0rV/kU8h1sWV5DN4cYHuL+mTXouEQ9PsJEoz
 sGwnbOs56GuXWb490+maE+39iyeM6qkivMGq9n7FaO6k+Dvc0ktDCwk/c71ucoESYzYF
 Zozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UHQkWKHi24ETaBgrS9DU//2QPz2lkclM7vZqrU625VU=;
 fh=6KN3gJI+IDvs7KnrTvUIdbZOaA+eVltlqMU3GB3Fgis=;
 b=RXBWYKqyiUO1WIrlr9h6BP0d0IPJep3aBBFniwdzN6Y4XLSaA880WwMeIkgNtBYHrU
 317JBkWDyPwmFQYl7sKm0H53erYkw5nQxYETJHFKbs11jUTP/EAqpQnHZz6TgGtlBxky
 LZAPn9tgT3EJMabnVUp3EMQf1axChSb48zXbdMQ8Cg9+4Frj6wIKtssChJ/oPjaYNC/V
 ncHSW+IDOy+j2lHulpvXhMtywLrmkYoBksWmsKkAoZ2/NkZB+FD6R0ZVAhG4kZNcguSq
 2xfh66iYfhn0N5AJX6SVSrsRuqj+z+VPAIY2uz3MWGI0lqQnqzF2LDI9493vFVjb9R7h
 SltQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794488502; x=1795093302; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UHQkWKHi24ETaBgrS9DU//2QPz2lkclM7vZqrU625VU=;
 b=uA+OV6SLSukBWFrpp32FzBw8FfmEGNJuUt8GUGthq4nPCDCLAW8g/UXQMs5bDTFM5a
 idq69RiwDqiqt93HQoQmEOz+0JZyB0mInOMKLCa400oPgo8xcHuBD1p5HfzzNbmBLtmW
 c8FnQAgnQSWObyABeTMU6Z/trd6Tr5k2u7TJtAAoUTa74g+SjWBkezS0a1/C0g4VV6My
 sBK1YtZoLMx3C33OvwmRiLsR2kibyOUvR1nOQ+hf0DylzLwq4QCqireZbTIstEjrrJ+D
 VoSeQaFlH7Wgk7QI0cW6okkPDzQM8368x7q9rMOgtd3R4U1nouOI5Es/Lbc0kUKcUIee
 uhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794488502; x=1795093302;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UHQkWKHi24ETaBgrS9DU//2QPz2lkclM7vZqrU625VU=;
 b=VnMjeYGyl9fi791aowYWRfOxfUHKRS5KnyDdijjQOeln16pmCKqQlRyopHzpQqk5TY
 SgMbmu9iWSb5RNIKlMGX/YjyHJk1sFRO0PL1kg8NTHonN4b7fflhuoBs1RN5++CE1aSR
 TBFxBttdkqx9cGLRQm9JLGp4bNQV3/NJGGZOmHpu4U4RAXGPSdMOPGDSRK99owjbrKmQ
 3/cXfp4g97+sxELF2BCXgniQXIxs3LNjqIiFHjBaNktl7gwEKA2Zcb1BsQ14pfCMpmM+
 GmKeQbC4TexhPAUWN40fGSzsCy8zzuznywb1aB2DERC1vRF67NIl4hlf0gH75ZKgOXgb
 2A0w==
X-Gm-Message-State: APuU4Z9DcWz3lDjd0+4KodO0ePQ6cMRUJ4qKs9JYbcTbLxbX9GUt+HFG
 a6AJJSxxi6PDZz0Cdg0PXrMgrBxCIvLohqrh/xYVCOlb00wUjbZeT5hEpI9TYLYzhJhi6lOObBJ
 jj3nyLyx3/+tU4UPbclrJj5ddIqrzBUBjrdqvUsXYuBKIkOgkqlUS8flloxziZEmoicLZThERgg
 I+w5ET2s9pZ+HUQvApjGcwFWgOpJgWqzk=
X-Gm-Gg: AYBFou0VZ6LjNcQkD8sryIS9Cfd4IPwjtDQnSGYchfnU8hLgudaRUriLNav1BmiLOXN
 a8NH0kDc3UpQ8ynTPou0YelH+9nNxfnyXMkPM7HyF4NYbe3RADJnvKflSgGOf0cQPiNDrOoIvA2
 VGLa5csftJRQFA8P0xVg25kALsTSQcD1GmZiy2k1axhVfEBMWZTVMNF03BHcVlzcumXz5ih1mxV
 2b/7g/xgC34FWmnWSOG2kNjhbTtVqsM3kFlAb/p+k9cEnA3SM1NIg4p7GcKsIe5nlkcj00gTYZR
 yw==
X-Received: by 2002:a17:902:eccd:b0:2e9:5e06:3345 with SMTP id
 d9443c01a7336-2edf1632507mr19960535ad.2.1794488501682; 
 Thu, 12 Nov 2026 05:01:41 -0800 (PST)
X-Received: by 2002:a17:902:eccd:b0:2e9:5e06:3345 with SMTP id
 d9443c01a7336-2edf1632507mr19960235ad.2.1794488501049; Thu, 12 Nov 2026
 05:01:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110134845.1770151-1-peter.maydell@linaro.org>
In-Reply-To: <20261110134845.1770151-1-peter.maydell@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 12 Nov 2026 17:01:29 +0400
X-Gm-Features: AclHuK_J6xepm2hAQ8SqU20G47LOcH2x44weiDZzKwyNBwHdLUhK9FlC3VgbcLQ
Message-ID: <CAMxuvayZYH6_pSWunRYmQQmD2hOC2xLSyciMob2dieozAYhFUA@mail.gmail.com>
Subject: Re: [PATCH] tests/functional/x86_64: Add test for ccid-card-emulated
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 10, 2026 at 5:48=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> Add a functional test for ccid-card-emulated.  This roughly follows
> the usage procedure we document in system/devices/ccid.rst of
> creating some fake certificates, pointing the device at them, and
> then inside the guest querying the smartcard for the certificates and
> checking they validate.  It deviates slightly from the suggested
> commands in the docs because the buildroot based rootfs doesn't have
> glibc and so "NSS-based smartcard integration with coolkey plus
> certutil" doesn't work.  Instead we use opensc's pkcs15-tool to read
> the certs off the card and check them with openssl.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

minor style nits below

> ---
> Here's the functional test I mentioned when I sent my other
> patch for ccid-card-emulated.
> ---
>  tests/functional/x86_64/meson.build           |   1 +
>  tests/functional/x86_64/test_ccid_emulated.py | 169 ++++++++++++++++++
>  2 files changed, 170 insertions(+)
>  create mode 100755 tests/functional/x86_64/test_ccid_emulated.py
>
> diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_6=
4/meson.build
> index bcda07620ff..9ed55fa99b3 100644
> --- a/tests/functional/x86_64/meson.build
> +++ b/tests/functional/x86_64/meson.build
> @@ -35,6 +35,7 @@ endif
>
>  tests_x86_64_system_thorough =3D [
>    'acpi_bits',
> +  'ccid_emulated',
>    'hotplug_blk',
>    'hotplug_scsi',
>    'hotplug_cpu',
> diff --git a/tests/functional/x86_64/test_ccid_emulated.py b/tests/functi=
onal/x86_64/test_ccid_emulated.py
> new file mode 100755
> index 00000000000..0c2d02fb3de
> --- /dev/null
> +++ b/tests/functional/x86_64/test_ccid_emulated.py
> @@ -0,0 +1,169 @@
> +#!/usr/bin/env python3
> +#
> +# Test of the ccid-emulated device. This roughly follows the lines
> +# suggested in our documentation of it, but deviates a bit because
> +# the buildroot-based rootfs we use doesn't have glibc to use the
> +# certutil + NSS validation process. Instead we use opensc's
> +# pkcs15-tool to read the certs off the card and openssl to check them.
> +#
> +# Copyright (c) 2026 Linaro Ltd
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +import shutil
> +import subprocess
> +
> +from qemu_test import (Asset, exec_command_and_wait_for_pattern,
> +                       skipIfMissingCommands)
> +from qemu_test.tuxruntest import TuxRunBaselineTest
> +
> +
> +class CCIDEmulatedTest(TuxRunBaselineTest):
> +
> +    ASSET_KERNEL =3D Asset(
> +        'https://storage.tuxboot.com/kernels/20261110/6.18.54/x86_64/bzI=
mage',
> +        'ba98a8a07d5f3f3e20119341059c0f0096fda499d30e30049c1ea64553b7e7c=
2')
> +    ASSET_ROOTFS =3D Asset(
> +        'https://storage.tuxboot.com/buildroot/20261110/x86_64/rootfs.ex=
t4.zst',
> +        '267172d47dc9594a8f07ec7fec05dc17b0fc21c64d5b635fccd6455128a2eb5=
8')
> +
> +    DEFAULT_KERNEL_PARAMS =3D ('console=3DttyS0')
> +
> +    def create_certs(self):
> +        # Create a CA and certificates in a dir under our test's
> +        # working dir (removing any stale contents it had first). We
> +        # return the db_spec that the ccid-card-emulated options need,
> +        # plus the filename of the exported CA cert
> +
> +        certdir =3D self.scratch_file("certs")
> +        shutil.rmtree(certdir, ignore_errors=3DTrue)
> +        os.mkdir(certdir)
> +
> +        db_spec =3D f'sql:{certdir}'
> +
> +        # certutil will by default block asking for some keyboard
> +        # input to get randomness; create a noise-file to pass to it
> +        # instead so it will work non-interactively
> +        noise_file=3Dself.scratch_file("noise.bin")

missing spaces

> +        with open(noise_file, 'wb') as f:
> +            f.write(os.urandom(2048))
> +
> +        subprocess.check_call(['certutil', '-N', '-d', db_spec,
> +                               '--empty-password'])
> +
> +        # We explicitly specify serial numbers (420, 421, 422, 423),
> +        # because certutil's default is to generate a serial based on
> +        # the current time, and when run from a script it will end up
> +        # repeating the same serial for two certificates, which causes
> +        # it to error out.
> +        subprocess.check_call(['certutil', '-S', '-d', db_spec,
> +                               '-z', noise_file,
> +                               '-s', "CN=3DFake Smart Card CA",
> +                               '-x', '-t', 'TC,TC,TC',
> +                               '-m', '420',
> +                               '--keyUsage',
> +                               'certSigning,crlSigning,critical',
> +                               '-n', 'fake-smartcard-ca'],
> +                              stdout=3Dsubprocess.DEVNULL,
> +                              stderr=3Dsubprocess.DEVNULL)
> +
> +        subprocess.check_call(['certutil', '-S', '-d', db_spec,
> +                               '-z', noise_file,
> +                               '-t', ',,',
> +                               '-s', "CN=3DJohn Doe",
> +                               '-n', 'id-cert',
> +                               '-m', '421',
> +                               '-c', 'fake-smartcard-ca'],
> +                              stdout=3Dsubprocess.DEVNULL,
> +                              stderr=3Dsubprocess.DEVNULL)
> +
> +        subprocess.check_call(['certutil', '-S', '-d', db_spec,
> +                               '-z', noise_file,
> +                               '-t', ',,',
> +                               '-s', "CN=3DJohn Doe (signing)",
> +                               '--nsCertType', 'smime',
> +                               '-n', 'signing-cert',
> +                               '-m', '422',
> +                               '-c', 'fake-smartcard-ca'],
> +                              stdout=3Dsubprocess.DEVNULL,
> +                              stderr=3Dsubprocess.DEVNULL)
> +
> +        subprocess.check_call(['certutil', '-S', '-d', db_spec,
> +                               '-z', noise_file,
> +                               '-t', ',,',
> +                               '-s', "CN=3DJohn Doe (encryption)",
> +                               '--nsCertType', 'sslClient',
> +                               '-n', 'encryption-cert',
> +                               '-m', '423',
> +                               '-c', 'fake-smartcard-ca'],
> +                              stdout=3Dsubprocess.DEVNULL,
> +                              stderr=3Dsubprocess.DEVNULL)
> +
> +        # Now export the CA cert to a file
> +        ca_cert =3D self.scratch_file("fake-smartcard-ca.pem")
> +        subprocess.check_call(['certutil', '-L', '-a', '-d', db_spec,
> +                               '-o', ca_cert, '-n', 'fake-smartcard-ca']=
)
> +
> +        return (db_spec, ca_cert)
> +
> +    def run_cmd(self, cmd):
> +        # Run a command, and wait for the following prompt
> +        exec_command_and_wait_for_pattern(self, cmd, '# ')
> +
> +    @skipIfMissingCommands('certutil')
> +    def test_ccid(self):
> +        self.set_machine('q35')
> +        self.require_device('usb-ccid')
> +        self.require_device('ccid-card-emulated')
> +        self.cpu =3D 'Nehalem'
> +        self.root =3D 'sda'
> +
> +        (kernel, disk, _, _) =3D self.fetch_tuxrun_assets(self.ASSET_KER=
NEL,
> +                                                        self.ASSET_ROOTF=
S)
> +
> +        (db_spec, ca_cert) =3D self.create_certs()
> +
> +        certspec =3D f'db=3D{db_spec},cert1=3Did-cert,cert2=3Dsigning-ce=
rt,cert3=3Dencryption-cert'
> +
> +        self.vm.add_args('-m', '1G', '-usb',
> +                         '-device', 'usb-ccid',
> +                         '-device',
> +                         f'ccid-card-emulated,backend=3Dcertificates,{ce=
rtspec}',
> +                         '-fw_cfg', f'opt/org.qemu/ccid-test,file=3D{ca_=
cert}')
> +
> +        self.prepare_run(None, kernel, disk,
> +                         drive=3D"driver=3Dide-hd,bus=3Dide.0,unit=3D0")
> +        self.vm.launch()
> +
> +        ps1=3D'root@tuxtest:~#'

same

> +        self.wait_for_console_pattern(self.kcmd_line)
> +        self.wait_for_console_pattern('tuxtest login:')
> +        exec_command_and_wait_for_pattern(self, 'root', ps1)
> +
> +        self.run_cmd('cp '
> +                     '/sys/firmware/qemu_fw_cfg/by_name/opt/org.qemu/cci=
d-test/raw '
> +                     '/tmp/fake-smartcard-ca.pem')
> +
> +        # Start the daemon which actually talks to the smartcard
> +        self.run_cmd('pcscd -d')
> +
> +        # list the certs; having this in the console log may help debugg=
ing
> +        self.run_cmd('pkcs15-tool --list-certificates')
> +
> +        # Read each cert off the card, and get openssl to check that it
> +        # validates against our fake CA cert
> +        for cert in ('0001', '0002', '0003'):
> +            self.run_cmd('pkcs15-tool '
> +                         f'--read-certificate {cert} -o /tmp/cert-{cert}=
.pem')
> +            exec_command_and_wait_for_pattern(self,
> +                                              'openssl verify '
> +                                              '-CAfile '
> +                                              '/tmp/fake-smartcard-ca.pe=
m '
> +                                              f'/tmp/cert-{cert}.pem',
> +                                              f'/tmp/cert-{cert}.pem: OK=
',
> +                                              failure_message=3D'# ')
> +            self.wait_for_console_pattern('# ')
> +
> +
> +if __name__ =3D=3D '__main__':
> +    CCIDEmulatedTest.main()
> --
> 2.43.0
>


