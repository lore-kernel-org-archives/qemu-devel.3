Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53002C369A1
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 10:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Sjm-0004wh-5H; Wed, 09 Apr 2025 06:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u2Sjk-0004wI-35
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 06:32:52 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u2Sjf-0004HV-VM
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 06:32:51 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e5e8274a74so10513006a12.1
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 03:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744194766; x=1744799566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SKAe/FLZCd7G7pIX5jO1rZcrkrVBWPALDqy+HiwZR9I=;
 b=UklPVl6q8DGTwJrBeaCZU9Wn8C8ufnj/765hU3OmBgpyL+lziOWHsg6H29qKAiuJka
 hqlDFKoNl9seRzq4QS8D+C24GoYD1ow8Ry9NIh6a/yzbrFDnxP5R9fEIlldnOIG39vYA
 7oq1H+WMbBKiU6jFa8EGxIW9uuG3UgDTcROG9u6T52IMTi6q823OwjvYu+oGAXbcHIPi
 1xkxhuNc8R8u2Cv2kS9zZr4lE6Yhpjq7VDtMCajwvh507zckzbOeAKs1m+yGQpvgigk8
 6VwUsPhu6+i38hE6+5SLsXLPrpRq3guJgYR3n0NuZzDfkmKaq4TuLIr0OjtS8F+IuAHA
 h5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744194766; x=1744799566;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SKAe/FLZCd7G7pIX5jO1rZcrkrVBWPALDqy+HiwZR9I=;
 b=fi4TeQu02jarmvdL1k0WeaGUMvhQdIMfLUowGavkFleI+5IAkfAwJfp28oyti2roZm
 gX98LrpksU1XfJjPoBmz2NfwYmHDA84PWMUYT7gbaOcQ9D7qD7NJX7ybdHV+LtfySDfx
 eW6Prc1xOyWTppaRk+LQZJikn/xuIi/DOHoNKFiPc6i2iNosr8w1edKHnrduvcebzCwt
 tFkg2T6RGj0Ox12zpVOnmS5R9//krhRzLGDZ1nUTnyj9010UAW5ZnLvBYYD2RMl4fCU3
 HpVd8i8YG3pqbCdHaS6g8JN2GUic5rRgt8+N4kcQvDT2hCZCMySUEpvaQK9rMDBZDbGS
 V6Jw==
X-Gm-Message-State: AOJu0Yz8W+rJqtu9c+n2Ql5AlayLq+91o6KUH8sspcDm7t7caGTulHnu
 8SwBQpnoACBpE1g8chvMQvickXti8NNTCYNNAJCScAaDmi6t0W73lizkExal3P8=
X-Gm-Gg: ASbGnctECp/FtF00tirEOqN2+zsnNlUPgsblVQBKz2IXGg0HOwPoTs5SPYzjf6tunly
 NWgjxC+ssOmmyY9zTbuFl3ivJeASB8zXAAfFJo1yGO1hMICO5RdsmF3KQbHgptqD5ympLtgwdQ9
 Pld7uPI4mokevKoi9iBp+XOtfXAFefNvD0tVQ4e1K4W0L/RIk8gEnrdxU4ioOBig7WaBTFWXeO2
 NFnC64SAHte/aHV6IS+njtcEgKX2IpcPuFaspYUkVVq10094kMtn/O41CYydxEUdv4/wVu9TIoh
 RNnPCwngnZFCVckX2f5FpOMfP+bP+yHz9t4s7tTV13Q=
X-Google-Smtp-Source: AGHT+IFCOAFMlE7JF97JeKie4NtZdb7lVyV2V2DQLC+TRGop2/zLiKGKk7/ylQ/cKqf1ofnzCabfQw==
X-Received: by 2002:a05:6402:27cb:b0:5e5:be7f:a1f6 with SMTP id
 4fb4d7f45d1cf-5f2f85ca2d0mr1381239a12.1.1744194765521; 
 Wed, 09 Apr 2025 03:32:45 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f2fbd3d9fesm560769a12.72.2025.04.09.03.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 03:32:45 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 08D475F8B7;
 Wed,  9 Apr 2025 11:32:44 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v1 0/2] virtio-gpu: fix blob unmapping sequence
In-Reply-To: <20250403121704.2754589-1-manos.pitsidianakis@linaro.org> (Manos
 Pitsidianakis's message of "Thu, 3 Apr 2025 15:17:00 +0300")
References: <20250403121704.2754589-1-manos.pitsidianakis@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 09 Apr 2025 11:32:43 +0100
Message-ID: <87zfgpfwvo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> A hang was observed when running a small kernel that exercised VIRTIO=20
> GPU under TCG. This is an edge-case and won't happen under typical=20
> conditions.
>
> When unmapping a blob object, its MemoryRegion's freeing is deferred to=20
> the RCU thread. The hang's cause was determined to be a busy main loop=20
> not allowing for the RCU thread to run because the kernel did not setup=20
> any timers or had any interrupts on the way. While fixing the RCU thread=
=20
> to run even if the guest CPU spins is a solution, it's easier to fix the=
=20
> reason why the MemoryRegion isn't freed from the main loop instead.
>
> While at it, also restructure the 3 stage cleanup to immediately respond=
=20
> to the guest if the MR happened to have had no other reference.
>
> PS: The hang can be reproduced by running this unikernel with TCG=20
>
> https://git.codelinaro.org/manos.pitsidianakis/virtio-tests/-/tree/8c0ebe=
9395827e24aa5711186d499bf5de87cf63/virtio-test-suite

Hmm these seems to regress the virtio-gpu tests:

=F0=9F=95=9910:18:49 alex@toolbox:qemu.git/builds/virtio-gpu  on =EE=82=A0 =
HEAD (ae021f8) (REBASING 4/9) [$+?] took 7s
=E2=9E=9C  echo $LD_LIBRARY_PATH
/home/alex/lsrc/qemu.git/builds/extra.libs/install/lib /home/alex/lsrc/qemu=
.git/builds/extra.libs/install/lib/x86_64-linux-gnu
=F0=9F=95=9910:18:54 alex@toolbox:qemu.git/builds/virtio-gpu  on =EE=82=A0 =
HEAD (ae021f8) (REBASING 4/9) [$+?]
=E2=9E=9C  echo $PKG_CONFIG_PATH
/home/alex/lsrc/qemu.git/builds/extra.libs/install/lib/pkgconfig /home/alex=
/lsrc/qemu.git/builds/extra.libs/install/lib/x86_64-linux-gnu/pkgconfig/
=F0=9F=95=9910:18:58 alex@toolbox:qemu.git/builds/virtio-gpu  on =EE=82=A0 =
HEAD (ae021f8) (REBASING 4/9) [$+?]
=E2=9E=9C  head config.log
# QEMU configure log Wed Apr  9 10:01:50 UTC 2025
# Configured with: '../../configure' '--disable-docs' '--enable-virglrender=
er' '--target-list=3Daarch64-softmmu,x86_64-softmmu' '--enable-debug' '--sk=
ip-meson'

#
cc -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
cc -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
config-temp/qemu-conf.c:2:2: error: #error __i386__ not defined
    2 | #error __i386__ not defined
      |  ^~~~~
cc -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
=F0=9F=95=9910:19:02 alex@toolbox:qemu.git/builds/virtio-gpu  on =EE=82=A0 =
HEAD (ae021f8) (REBASING 4/9) [$+?]
=E2=9E=9C  make -j30
/home/alex/lsrc/qemu.git/builds/virtio-gpu/pyvenv/bin/meson introspect --ta=
rgets --tests --benchmarks | /home/alex/lsrc/qemu.git/builds/virtio-gpu/pyv=
env/bin/python3 -B scripts/mtest2make.py > Makefile.mtest
[1/19] Generating qemu-version.h with a custom command (wrapped by meson to=
 capture output)
=F0=9F=95=9910:19:09 alex@toolbox:qemu.git/builds/virtio-gpu  on =EE=82=A0 =
HEAD (ae021f8) (REBASING 4/9) [$+?]
=E2=9E=9C  ./pyvenv/bin/meson test --setup thorough --suite func-thorough f=
unc-aarch64-aarch64_virt_gpu -v
ninja: Entering directory `/home/alex/lsrc/qemu.git/builds/virtio-gpu'
[1/6] Generating qemu-version.h with a custom command (wrapped by meson to =
capture output)
1/1 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch6=
4_virt_gpu        RUNNING
>>> QEMU_BUILD_ROOT=3D/home/alex/lsrc/qemu.git/builds/virtio-gpu G_TEST_SLO=
W=3D1 QEMU_TEST_QEMU_BINARY=3D/home/alex/lsrc/qemu.git/builds/virtio-gpu/qe=
mu-system-aarch64 MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print=
_summary=3D1:print_stacktrace=3D1 UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_o=
n_error=3D1:print_summary=3D1:print_stacktrace=3D1 MALLOC_PERTURB_=3D52 PYT=
HONPATH=3D/home/alex/lsrc/qemu.git/python:/home/alex/lsrc/qemu.git/tests/fu=
nctional RUST_BACKTRACE=3D1 LD_LIBRARY_PATH=3D/home/alex/lsrc/qemu.git/buil=
ds/virtio-gpu/tests/tcg/plugins:/home/alex/lsrc/qemu.git/builds/virtio-gpu/=
contrib/plugins:/home/alex/lsrc/qemu.git/builds/extra.libs/install/lib:/hom=
e/alex/lsrc/qemu.git/builds/extra.libs/install/lib/x86_64-linux-gnu SPEED=
=3Dthorough ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summa=
ry=3D1 QEMU_TEST_QEMU_IMG=3D/home/alex/lsrc/qemu.git/builds/virtio-gpu/qemu=
-img MESON_TEST_ITERATION=3D1 /home/alex/lsrc/qemu.git/builds/virtio-gpu/py=
venv/bin/python3 /home/alex/lsrc/qemu.git/tests/functional/test_aarch64_vir=
t_gpu.py
=E2=96=B6 1/1 test_aarch64_virt_gpu.Aarch64VirtGPUMachine.test_aarch64_virt=
_with_virgl_blobs_gpu     OK
=E2=96=B6 1/1 test_aarch64_virt_gpu.Aarch64VirtGPUMachine.test_aarch64_virt=
_with_virgl_gpu           OK
=E2=96=B6 1/1 test_aarch64_virt_gpu.Aarch64VirtGPUMachine.test_aarch64_virt=
_with_vulkan_gpu          OK
1/1 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch6=
4_virt_gpu        OK             207.15s   3 subtests passed


Ok:                 1
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            0
Timeout:            0

Full log written to /home/alex/lsrc/qemu.git/builds/virtio-gpu/meson-logs/t=
estlog-thorough.txt
=F0=9F=95=9910:22:41 alex@toolbox:qemu.git/builds/virtio-gpu  on =EE=82=A0 =
HEAD (ae021f8) (REBASING 4/9) [$+?] took 3m27s
=E2=9E=9C  make -j30
[1/21] Generating qemu-version.h with a custom command (wrapped by meson to=
 capture output)
[2/21] Compiling C object libcommon.a.p/hw_display_virtio-gpu-virgl.c.o
[3/21] Compiling C object libcommon.a.p/hw_virtio_virtio-pci.c.o
[4/21] Compiling C object qemu-vmsr-helper.p/tools_i386_qemu-vmsr-helper.c.o
[5/21] Compiling C object qemu-pr-helper.p/scsi_qemu-pr-helper.c.o
[6/21] Compiling C object qemu-io.p/qemu-io.c.o
[7/21] Linking target qemu-vmsr-helper
[8/21] Compiling C object qga/qemu-ga.p/main.c.o
[9/21] Compiling C object qemu-nbd.p/qemu-nbd.c.o
[10/21] Compiling C object libqmp.a.p/monitor_qmp-cmds-control.c.o
[11/21] Compiling C object storage-daemon/qemu-storage-daemon.p/qemu-storag=
e-daemon.c.o
[12/21] Linking target qemu-pr-helper
[13/21] Linking target qga/qemu-ga
[14/21] Linking target qemu-io
[15/21] Linking target qemu-nbd
[16/21] Linking target storage-daemon/qemu-storage-daemon
[17/21] Compiling C object qemu-img.p/qemu-img.c.o
[18/21] Compiling C object libcommon.a.p/system_vl.c.o
[19/21] Linking target qemu-img
[20/21] Linking target qemu-system-x86_64
[21/21] Linking target qemu-system-aarch64
=F0=9F=95=9910:23:08 alex@toolbox:qemu.git/builds/virtio-gpu  on =EE=82=A0 =
virtio/virtio-blk-fallback [$?]
=E2=9E=9C  ./pyvenv/bin/meson test --setup thorough --suite func-thorough f=
unc-aarch64-aarch64_virt_gpu -v
ninja: Entering directory `/home/alex/lsrc/qemu.git/builds/virtio-gpu'
[1/6] Generating qemu-version.h with a custom command (wrapped by meson to =
capture output)
1/1 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch6=
4_virt_gpu        RUNNING
>>> PYTHONPATH=3D/home/alex/lsrc/qemu.git/python:/home/alex/lsrc/qemu.git/t=
ests/functional QEMU_BUILD_ROOT=3D/home/alex/lsrc/qemu.git/builds/virtio-gp=
u ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1 MES=
ON_TEST_ITERATION=3D1 SPEED=3Dthorough QEMU_TEST_QEMU_BINARY=3D/home/alex/l=
src/qemu.git/builds/virtio-gpu/qemu-system-aarch64 G_TEST_SLOW=3D1 UBSAN_OP=
TIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_stackt=
race=3D1 MALLOC_PERTURB_=3D7 MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_erro=
r=3D1:print_summary=3D1:print_stacktrace=3D1 RUST_BACKTRACE=3D1 LD_LIBRARY_=
PATH=3D/home/alex/lsrc/qemu.git/builds/virtio-gpu/tests/tcg/plugins:/home/a=
lex/lsrc/qemu.git/builds/virtio-gpu/contrib/plugins:/home/alex/lsrc/qemu.gi=
t/builds/extra.libs/install/lib:/home/alex/lsrc/qemu.git/builds/extra.libs/=
install/lib/x86_64-linux-gnu QEMU_TEST_QEMU_IMG=3D/home/alex/lsrc/qemu.git/=
builds/virtio-gpu/qemu-img /home/alex/lsrc/qemu.git/builds/virtio-gpu/pyven=
v/bin/python3 /home/alex/lsrc/qemu.git/tests/functional/test_aarch64_virt_g=
pu.py
qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch64_vi=
rt_gpu time out (After 480 seconds)
1/1 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch6=
4_virt_gpu        TIMEOUT        480.01s   killed by signal 15 SIGTERM


Summary of Failures:

1/1 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch6=
4_virt_gpu TIMEOUT        480.01s   killed by signal 15 SIGTERM

Ok:                 0
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            0
Timeout:            1

Full log written to /home/alex/lsrc/qemu.git/builds/virtio-gpu/meson-logs/t=
estlog-thorough.txt
=F0=9F=95=9910:31:12 alex@toolbox:qemu.git/builds/virtio-gpu  on =EE=82=A0 =
virtio/virtio-blk-fallback [$?] took 8m [=F0=9F=94=B4 ERROR]


>
> Manos Pitsidianakis (2):
>   virtio-gpu: fix hang under TCG when unmapping blob
>   virtio-gpu: refactor async blob unmapping
>
>  hw/display/virtio-gpu-virgl.c | 37 ++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>
>
> base-commit: 0adf626718bc0ca9c46550249a76047f8e45da15

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

