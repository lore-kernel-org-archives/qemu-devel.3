Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CBAC2A099
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 11:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcies-0007c4-Fc; Mon, 05 Jan 2026 06:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vcieq-0007bO-5t
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 06:21:56 -0500
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vcien-0007zI-TQ
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 06:21:55 -0500
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-8888a444300so147456116d6.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 03:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767612112; x=1768216912; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3IY/4h8hOmpD/NmuU1B6RZVCmUs30QIazaoiI3F+iqM=;
 b=Cc0/+lTCdin5JYnMru/03mS8NpqyEdvZIHfVp+au9tAqNmrXPuO//lTmBN6cuWMiPE
 a0o42tN/3xtkjBMGkb4MOLwGedtfPvDeWhjOtkLHM9JiPXl4z/743xyorYGraBOwJxuT
 Q8URYmrNQ30POArsJTc0Imrf/5ejldRUW1M2t49h5DFPP2r9FVjwKJPCLrztNrRnk08e
 bzC4m6CfPefNfA/FOp+pgFlJyKgVnGF2L7z78AvZHgQ1yPPFilfZFiH2gWaUlchuRq1+
 piwEBszYfyUyoj2G5091/Vx/AuusdshpvdjsdKhusbsiMQiYfFWnFlHxFD9y7KGUd8ge
 8jSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767612112; x=1768216912;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3IY/4h8hOmpD/NmuU1B6RZVCmUs30QIazaoiI3F+iqM=;
 b=naHiCe9Ly3K0TXCLEL0P5k+zq2uDimlApJNqWurOEx1eIZPZBfcP8bQRpR/j3acxRd
 U5ZFBb3B/uCVQTZNewFDHzfvhoO7TNxDeA4uUl7y9ezpbhlWv2/HJRo0sK1W33hm8Slr
 lDVHH2DvzIV1RETFSmbbqexhzYEb1Vo8B5+bk7Cp4IZsChq0+1G3Q2GkKJ+OYpsRoRMI
 CILOfvjFmYb8LTqf+4bDUWnVJmyOykLXTsoiIXIcMuXwtrY34VPnZlLCnGFzSozSs6nW
 Zxv3A5xcEkh+3T1IlNxYkNPvkkHx/SO3fxq5oWNCWWzx77bP4Bx48k9bHSvg+RUfe2dE
 MjJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUpjiE0/eph4jGtRK1BityhFRZwWCWOmrBYrFtcdGfTbptDPHDzeJnCkclLLpG3vol5JOUFCNXfIsR@nongnu.org
X-Gm-Message-State: AOJu0YzU5wPbPWW2bcGjXOOrMV9MUtLm9Cu+arBXZNsQpUKXVzAQnHIn
 jQdXJ590RSeqJt0tZUqKma1ShB4IZdsZSeV5oSbKAIVcJC66uRpvCaPQaW1t3Ly2Flfub72dzT+
 u5Uv/3qES9/AxS0+6PfHIPhoHOM969go=
X-Gm-Gg: AY/fxX53B/C574H5kAUJjvDUDPYDg2RHZwAjnXdpEgXud5aiKtWta1CdNjt3oPaLY1b
 gnvfW5i5LwcdzNWKXBMaqXubOI+dp3AOocCwecK0FSPiu6KTOp77jhK0EkRVOjKPiGhGh0UhzFW
 Fyz/6DcegscJ3U4zRBTNZtouyh905eWC1hjJqfaIjYxxAJ4Zsh7/Zw0aKX7X3ICxlUmF/W/YP0w
 FyATX1LUPdHBcq+eFmmXGc2Q3yq4d/RFTSDblzzAr8iymUUh7QW/pYB2pwDbp6kZ0MgcrbsCM2F
 aKsInid27KYV+vdVW+3WIJ1kPBu4PhvYtfhnOg==
X-Google-Smtp-Source: AGHT+IFQEoJeRFcVlRTe0IugHjuEVCGmWttsVVHCqXFDsur85rJHyrlrVRx8DU6nrLOL2Z5aa9i5Tfvwc4RTrdljieU=
X-Received: by 2002:a05:6214:43c3:b0:88f:cc0f:481d with SMTP id
 6a1803df08f44-88fcc0f48b3mr758967276d6.37.1767612112303; Mon, 05 Jan 2026
 03:21:52 -0800 (PST)
MIME-Version: 1.0
References: <20251230002604.113632-1-yodel.eldar@yodel.dev>
 <648af3ee-5a5b-4c50-9135-6eae776d37a8@redhat.com>
In-Reply-To: <648af3ee-5a5b-4c50-9135-6eae776d37a8@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 5 Jan 2026 15:21:40 +0400
X-Gm-Features: AQt7F2rktl4FPq0SgGeEFqwyqxIRegUj5DUEaviGGPi199vwMVQBWRvBEiV3tOo
Message-ID: <CAJ+F1CK78wLaYcjZPoU-9rufDM8pa6wWntn0hToQoF7syA2r3w@mail.gmail.com>
Subject: Re: [RFC PATCH] tests/functional/x86_64: Add vhost-user-bridge test
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Mon, Jan 5, 2026 at 2:36=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.co=
m> wrote:
>
> + Marc-Andr=C3=A9
>
> (I don't know who maintains this test)

oh vhost-user-bridge is unmaintained...

> Thanks,
>
> C.
>
>
> On 12/30/25 01:25, Yodel Eldar wrote:
> > This introduces a functional test of vhost-user-bridge.
> >
> > The test runs vhost-user-bridge and launches a guest VM that connects
> > to the internet through it. The test succeeds if and only if an attempt
> > to connect to a hard-coded well-known URL succeeds.
> >
> > Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> > ---
> >
> > This patch introduces a functional test of vhost-user-bridge by
> > automating the testing described in its initial commit, 8e3b0cbb72,
> > with adjustments like using hubports (formerly the vlan parameter) and
> > memfd for the memory backend; hugepages are also omitted to avoid
> > requiring root privileges on the host.
> >
> > The test configures networking within the guest by invoking udhcpc, the=
n
> > makes an http request via wget to a well-known URL, example.org, that
> > has a low risk of requiring https for connections (a limitation of the
> > the test). An assert on the retcode of wget determines success/failure.
> >
> > Please let me know if there are objections to the use of wget's retcode
> > as the test's condition; determining wget success through its output is
> > straightforward ("remote file exists"), but out of concern of some
> > unknown failure message (besides "bad address") locking up the test,
> > I've resorted to checking the retcode instead; perhaps, this violates
> > some convention?

Imho, the test shouldn't need internet connectivity. It could possibly
send custom crafted IP packets instead. wdyt?


> >
> > Also, I figured checking for memfd support on the host was unnecessary
> > in 2026 for the intended users of the test, but perhaps not?
> >
> > The guest's kernel contains an integrated initramfs and was built with
> > buildroot; an attempt to ensure bit-for-bit reproducibility was made by
> > building it via Containerfile based on a snapshot container image and
> > use of the BR2_REPRODUCIBLE option of buildroot, but the latter feature
> > is "experimental," so future builds may differ slightly (though the
> > image in the repo will be left untouched). The image and associated
> > build files are hosted on my personal account here:
> >       https://github.com/yodel/vhost-user-bridge-test
> > and will continue to be well into the future, but if there's some other
> > preferred location for the asset, please let me know?

Do we need a new kernel asset? I like the reproducible from scratch
way, maybe we should try to consolidate other tests around it. That's
just some thoughts.

> >
> > Lastly, special thanks to C=C3=A9dric for inspiring me to write the tes=
t in
> > "<11454796-30d2-4a57-85a5-d42ff0dce2e6@redhat.com>".
> >
> > Thanks,
> > Yodel
> >
> >   .../x86_64/test_vhost_user_bridge.py          | 124 +++++++++++++++++=
+
> >   1 file changed, 124 insertions(+)
> >   create mode 100755 tests/functional/x86_64/test_vhost_user_bridge.py
> >
> > diff --git a/tests/functional/x86_64/test_vhost_user_bridge.py b/tests/=
functional/x86_64/test_vhost_user_bridge.py
> > new file mode 100755
> > index 0000000000..61afdbceec
> > --- /dev/null
> > +++ b/tests/functional/x86_64/test_vhost_user_bridge.py
> > @@ -0,0 +1,124 @@
> > +#!/usr/bin/env python3
> > +#
> > +# Copyright (c) 2025 Software Freedom Conservancy, Inc.
> > +#
> > +# Author: Yodel Eldar <yodel.eldar@yodel.dev>
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +"""
> > +Test vhost-user-bridge (vubr) functionality:
> > +
> > +    1) Run vhost-user-bridge on the host.
> > +    2) Launch a guest VM:
> > +        a) Instantiate a unix domain socket to the vubr-created path
> > +        b) Instantiate a vhost-user net backend on top of that socket
> > +        c) Expose vhost-user with a virtio-net-pci interface
> > +        d) Instantiate UDP socket and user-mode net backends
> > +        e) Hub the UDP and user-mode backends
> > +    3) Run udhcpc in the guest to auto-configure networking.
> > +    4) Run wget in the guest and check its retcode to test internet co=
nnectivity
> > +
> > +The test fails if wget returns 1 and succeeds on 0.
> > +"""
> > +
> > +import os
> > +import subprocess
> > +from qemu_test import Asset, QemuSystemTest, which
> > +from qemu_test import exec_command_and_wait_for_pattern
> > +from qemu_test import is_readable_executable_file
> > +from qemu_test import wait_for_console_pattern
> > +from qemu_test.ports import Ports
> > +
> > +class VhostUserBridge(QemuSystemTest):
> > +
> > +    ASSET_KERNEL_INITRAMFS =3D Asset(
> > +        "https://github.com/yodel/vhost-user-bridge-test/raw/refs/head=
s/main/bzImage",
> > +        "3790bf35e4ddfe062425bca45e923df5a5ee4de44e456d6b00cf47f04991d=
549")
> > +
> > +    def configure_vm(self, ud_socket_path, lport, rport):
> > +        kernel_path =3D self.ASSET_KERNEL_INITRAMFS.fetch()
> > +
> > +        self.require_accelerator("kvm")
> > +        self.require_netdev("vhost-user")
> > +        self.require_netdev("socket")
> > +        self.require_netdev("hubport")
> > +        self.require_netdev("user")
> > +        self.require_device("virtio-net-pci")
> > +        self.set_machine("q35")
> > +        self.vm.set_console()
> > +        self.vm.add_args(
> > +            "-cpu",      "host",
> > +            "-accel",    "kvm",
> > +            "-kernel",   kernel_path,
> > +            "-append",   "console=3DttyS0",
> > +            "-smp",      "2",
> > +            "-m",        "128M",
> > +            "-object",   "memory-backend-memfd,id=3Dmem0,"
> > +                         "size=3D128M,share=3Don,prealloc=3Don",
> > +            "-numa",     "node,memdev=3Dmem0",
> > +            "-chardev", f"socket,id=3Dchar0,path=3D{ud_socket_path}",
> > +            "-netdev",   "vhost-user,id=3Dvhost0,chardev=3Dchar0,vhost=
force=3Don",
> > +            "-device",   "virtio-net-pci,netdev=3Dvhost0",
> > +            "-netdev",  f"socket,id=3Dudp0,udp=3Dlocalhost:{lport},"
> > +                        f"localaddr=3Dlocalhost:{rport}",
> > +            "-netdev",   "hubport,id=3Dhub0,hubid=3D0,netdev=3Dudp0",
> > +            "-netdev",   "user,id=3Duser0",
> > +            "-netdev",   "hubport,id=3Dhub1,hubid=3D0,netdev=3Duser0"
> > +        )
> > +
> > +    def assemble_vubr_args(self, vubr_path, ud_socket_path, lport, rpo=
rt):
> > +        vubr_args =3D []
> > +
> > +        if (stdbuf_path :=3D which("stdbuf")) is None:
> > +            self.log.info("Could not find stdbuf: vhost-user-bridge "
> > +                          "log lines may appear out of order")
> > +        else:
> > +            vubr_args +=3D [stdbuf_path, "-o0", "-e0"]
> > +
> > +        vubr_args +=3D [vubr_path, "-u", f"{ud_socket_path}",
> > +                      "-l", f"127.0.0.1:{lport}", "-r", f"127.0.0.1:{r=
port}"]
> > +
> > +        return vubr_args
> > +
> > +    def test_vhost_user_bridge(self):
> > +        prompt =3D "~ # "
> > +
> > +        vubr_path =3D self.build_file("tests", "vhost-user-bridge")
> > +        if is_readable_executable_file(vubr_path) is None:
> > +            self.skipTest("Could not find a readable and executable "
> > +                          "vhost-user-bridge")
> > +
> > +        with Ports() as ports:
> > +            sock_dir =3D self.socket_dir()
> > +            ud_socket_path =3D os.path.join(sock_dir.name, "vubr-test.=
sock")
> > +            lport, rport =3D ports.find_free_ports(2)
> > +
> > +            self.configure_vm(ud_socket_path, lport, rport)
> > +
> > +            vubr_log_path =3D self.log_file("vhost-user-bridge.log")
> > +            self.log.info("For the vhost-user-bridge application log,"
> > +                         f" see: {vubr_log_path}")
> > +
> > +            vubr_args =3D self.assemble_vubr_args(vubr_path, ud_socket=
_path,
> > +                                                lport, rport)
> > +
> > +            with open(vubr_log_path, "w") as vubr_log, \
> > +                 subprocess.Popen(vubr_args, stdin=3Dsubprocess.DEVNUL=
L,
> > +                                  stdout=3Dvubr_log, stderr=3Dsubproce=
ss.STDOUT):
> > +                self.vm.launch()
> > +
> > +                wait_for_console_pattern(self, prompt)
> > +                exec_command_and_wait_for_pattern(self, "udhcpc -nt 1"=
, prompt)
> > +                exec_command_and_wait_for_pattern(self,
> > +                    "wget -qT 2 --spider example.org", prompt)
> > +
> > +                try:
> > +                    exec_command_and_wait_for_pattern(self, "echo $?",=
 "0", "1")
> > +                except AssertionError:
> > +                    self.log.error("Unable to confirm internet connect=
ivity")
> > +                    raise
> > +                finally:
> > +                    self.vm.shutdown()
> > +
> > +if __name__ =3D=3D '__main__':
> > +    QemuSystemTest.main()
>
>


--=20
Marc-Andr=C3=A9 Lureau

