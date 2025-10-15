Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67B4CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 02:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8rSa-0000mH-2o; Tue, 14 Oct 2025 22:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v8rSW-0000lX-BS
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:41:48 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v8rSP-0005g8-W6
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:41:47 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59F2fJuN061330
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 15 Oct 2025 11:41:19 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=wA2nkoAjrw2F42nkelDD0ZtqCBF9pYTxn8ZInFXqjVA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1760496079; v=1;
 b=LinuVxETo6DrZDPrRTEPlUJGZ8xi6dz4XmjrHiiWeaQNBqwgT50QwMgthPP6tfO1
 Ttryt628yyjuNp6YFA3ry6ilLYZXPmssl5IFQ3o7U6bhFbbjBF3Op1ztil9YclgY
 HrHKmRMHNyHnVs0bCNMpd275dzaMH/bV7CBU+ertLml5+Bcysc5ZCNowWF4cHm9l
 YL34/mOw/9wRPAWBS3WnQXKCuLzXdjS8YX9+DkEbWrSdzNBg8v0WktHe32P3U1cF
 N+1X1e4R6zMKYXm+etTi+lmzWDkGa2qH2l/nRr3JPk5MEj7zTG9rw+BVNj0oIRvH
 wz4j9lNrZbMvgP5sa4Rbqg==
Message-ID: <eea555b4-879c-4fd8-b837-1a8c1e1c76fa@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 15 Oct 2025 11:41:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] tests/functional: add GPU blob allocation test
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20251014111234.3190346-1-alex.bennee@linaro.org>
 <20251014111234.3190346-9-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251014111234.3190346-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/10/14 20:12, Alex Bennée wrote:
> This is a very short microkernel test that initialises and then maps
> and unmaps a blob resource.
> 
> Without the other fixes in this series it causes QEMU to hang on the
> unhandled unmap.

Thank you for the reproduction case.

I don't have time to look into it this and the next week due to 
attendance to a conference (MICRO-58), but I'll definitely do so after that.

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/aarch64/meson.build      |  1 +
>   tests/functional/aarch64/test_gpu_blob.py | 73 +++++++++++++++++++++++
>   2 files changed, 74 insertions(+)
>   create mode 100755 tests/functional/aarch64/test_gpu_blob.py
> 
> diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
> index 5ad52f93e1d..f6ca33b2be4 100644
> --- a/tests/functional/aarch64/meson.build
> +++ b/tests/functional/aarch64/meson.build
> @@ -26,6 +26,7 @@ tests_aarch64_system_thorough = [
>     'aspeed_ast2700',
>     'aspeed_ast2700fc',
>     'device_passthrough',
> +  'gpu_blob',
>     'hotplug_pci',
>     'imx8mp_evk',
>     'kvm',
> diff --git a/tests/functional/aarch64/test_gpu_blob.py b/tests/functional/aarch64/test_gpu_blob.py
> new file mode 100755
> index 00000000000..a913d3b29c8
> --- /dev/null
> +++ b/tests/functional/aarch64/test_gpu_blob.py
> @@ -0,0 +1,73 @@
> +#!/usr/bin/env python3
> +#
> +# Functional tests for GPU blob support. This is a directed test to
> +# exercise the blob creation and removal features of virtio-gpu. You
> +# can find the source code for microkernel test here:
> +#   https://gitlab.com/epilys/qemu-880-repro

Nice. I appreciate the effort to creat the microkernel; hopefully it 
will be useful also to exercise this part of virtio-gpu for debugging in 
the future.

> +#
> +# Copyright (c) 2025 Linaro Ltd.
> +#
> +# Authors:
> +#  Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +#  Alex Bennée <alex.bennee@linaro.org>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu.machine.machine import VMLaunchFailure
> +
> +from qemu_test import Asset
> +from qemu_test import wait_for_console_pattern
> +from qemu_test.linuxkernel import LinuxKernelTest
> +
> +class Aarch64VirtBlobTest(LinuxKernelTest):
> +
> +    ASSET_BLOB = Asset('https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/'
> +                       'download?path=%2Fblob-test&files=qemu-880.bin',
> +                       '2f6ab85d0b156c94fcedd2c4c821c5cbd52925a2de107f8e2d569ea2e34e42eb')
> +
> +    def test_virtio_gpu_blob(self):
> +
> +        self.set_machine('virt')
> +        self.require_accelerator("tcg")
> +
> +        blob = self.ASSET_BLOB.fetch()
> +
> +        self.vm.set_console()
> +
> +        self.vm.add_args("-machine", "virt,memory-backend=mem0,accel=tcg",
> +                         '-m', '4G',
> +                         '-cpu', 'max',
> +                         '-kernel', blob,
> +                         '-object', 'memory-backend-memfd,share=on,id=mem0,size=4G',
> +                         '-global', 'virtio-mmio.force-legacy=false',
> +                         '-nic', 'none',
> +                         '-device',
> +                         'virtio-gpu-gl,hostmem=128M,blob=true,venus=true',

venus is not exercised with this test case so can be removed.

This test somehow hung on my laptop even with the all other patches in 
this series applied, and removing venus=true fixed the hung.

I suppose the hang is unrelated to the problem fixed in this series and 
but rather is a problem specific to my environment (Asahi Linux). 
Anyway, I think removing venus=true is a safer option to avoid problems 
with the host graphics stack.

Below is a part of build/meson-logs/testlog.txt:

==================================== 1/1 
=====================================
test:         qemu:func-thorough+func-aarch64-thorough+thorough / 
func-aarch64-gpu_blob
start time:   02:25:49
duration:     90.01s
result:       killed by signal 15 SIGTERM
command: 
MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 
MALLOC_PERTURB_=12 RUST_BACKTRACE=1 
QEMU_TEST_QEMU_BINARY=/home/me/q/var/qemu/build/qemu-system-aarch64 
UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 
PYTHONPATH=/home/me/q/var/qemu/python:/home/me/q/var/qemu/tests/functional 
ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 
MESON_TEST_ITERATION=1 QEMU_BUILD_ROOT=/home/me/q/var/qemu/build 
QEMU_TEST_QEMU_IMG=/home/me/q/var/qemu/build/qemu-img 
LD_LIBRARY_PATH=/home/me/q/var/qemu/build/contrib/plugins:/home/me/q/var/qemu/build/tests/tcg/plugins 
/home/me/q/var/qemu/build/pyvenv/bin/python3 
/home/me/q/var/qemu/tests/functional/aarch64/test_gpu_blob.py
----------------------------------- stderr 
-----------------------------------
==31639==WARNING: ASan doesn't fully support makecontext/swapcontext 
functions and may produce false positives in some cases!
==============================================================================


Summary of Failures:

1/1 qemu:func-thorough+func-aarch64-thorough+thorough / 
func-aarch64-gpu_blob TIMEOUT        90.01s   killed by signal 15 SIGTERM

Ok:                 0
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            0
Timeout:            1

> +                         '-display', 'egl-headless,gl=on',
> +                         '-d', 'guest_errors')
> +
> +        try:
> +            self.vm.launch()
> +        except VMLaunchFailure as excp:
> +            if "old virglrenderer, blob resources unsupported" in excp.output:
> +                self.skipTest("No blob support for virtio-gpu")
> +            elif "old virglrenderer, venus unsupported" in excp.output:
> +                self.skipTest("No venus support for virtio-gpu")
> +            elif "egl: no drm render node available" in excp.output:
> +                self.skipTest("Can't access host DRM render node")

This condition is unnecessary as DRM render node is not used.

> +            elif "'type' does not accept value 'egl-headless'" in excp.output:
> +                self.skipTest("egl-headless support is not available")
> +            elif "'type' does not accept value 'dbus'" in excp.output:
> +                self.skipTest("dbus display support is not available")

This can be removed too.

> +            elif "eglInitialize failed: EGL_NOT_INITIALIZED" in excp.output:
> +                self.skipTest("EGL failed to initialize on this host")
> +            else:
> +                self.log.info("unhandled launch failure: %s", excp.output)
> +                raise excp
> +
> +        self.wait_for_console_pattern('[INFO] virtio-gpu test finished')
> +        # the test should cleanly exit
> +
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()


