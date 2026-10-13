Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458A3CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGaiE-0003R7-3t; Tue, 13 Oct 2026 07:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGaiC-0003Qx-5N
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 07:30:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGai9-0004m0-6T
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 07:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791891023;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=81VRL/8gkQvZ/2wjuy6mk4Sxms5XwA8iINKnSog8Tso=;
 b=G439Zj0P1VfLiqBQrfnU3xOSeLsasCLxTYbw9XTQ4ej2xUhIJo4EPZMQBMMDfAZ3NNdUr+
 Jmiymv+ifRVjkq/WodoK9PyNsVUPwrhSWeRzSlM0HYLRLFCsZ4r8sDeHle5E3mu4MqlwtY
 V1iMFs8B/5+M0JS77gfPw8bIaAeYGaY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-0ygGCcOGMH2n1fOP815MHg-1; Tue,
 13 Oct 2026 11:30:14 +0000
X-MC-Unique: 0ygGCcOGMH2n1fOP815MHg-1
X-Mimecast-MFC-AGG-ID: 0ygGCcOGMH2n1fOP815MHg_1791891012
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B4E019539B2; Tue, 13 Oct 2026 11:30:12 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 204891800473; Tue, 13 Oct 2026 11:30:09 +0000 (UTC)
Date: Tue, 13 Oct 2026 12:30:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anatol Belski <anbelski@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <th.huth+qemu@posteo.eu>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Philippe Mathieu-Daude <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC PATCH] tests/functional: Add virtio-villain fault injection
 test
Message-ID: <as4WPwzaIbw-298Y@redhat.com>
References: <20261001210916.1907716-1-anbelski@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261001210916.1907716-1-anbelski@linux.microsoft.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 01, 2026 at 11:09:16PM +0200, Anatol Belski wrote:
> Add a functional test that drives the virtio-villain harness against
> the QEMU under test. virtio-villain is a guest side fault injection
> tool that boots one short lived guest per case. Each case violates a
> driver rule from the virtio spec and checks that the device model
> handles the bad input without crashing, hanging, or corrupting state.
> 
> The harness is added as a git submodule under
> tests/functional/virtio-villain. The test builds the static guest init
> with the host compiler for a native guest, or an architecture cross
> compiler for a foreign guest, then runs the whole supported suite one
> guest per case and fails if any case reports FAIL, WEDGED, or XPASS.
> Cases that need host support which is absent, such as vhost-vsock or a
> virtiofs daemon, are skipped.
> 
> The guest kernel is fetched as a cached asset. The test lives in the
> generic directory and is registered in the x86_64 and aarch64 thorough
> suites, skipping any host that cannot provide a kernel or a compiler
> for the guest architecture.
> 
> Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
> ---
>  .gitmodules                                   |   3 +
>  MAINTAINERS                                   |   6 +
>  docs/devel/testing/functional.rst             |  27 +++
>  tests/functional/aarch64/meson.build          |   2 +
>  .../functional/generic/test_virtio_villain.py | 195 ++++++++++++++++++
>  tests/functional/virtio-villain               |   1 +
>  tests/functional/x86_64/meson.build           |   2 +
>  7 files changed, 236 insertions(+)
>  create mode 100755 tests/functional/generic/test_virtio_villain.py
>  create mode 160000 tests/functional/virtio-villain

> diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
> index f0881bed16..28563655ae 100644
> --- a/tests/functional/aarch64/meson.build
> +++ b/tests/functional/aarch64/meson.build
> @@ -18,6 +18,7 @@ test_aarch64_timeouts = {
>    'virt' : 360,
>    'virt_gpu' : 480,
>    'virt_vbsa' : 240,
> +  'virtio_villain' : 900,
>  }
>  
>  tests_aarch64_system_quick = [
> @@ -55,6 +56,7 @@ tests_aarch64_system_thorough = [
>    'virt_aarch64_off',
>    'virt_gpu',
>    'virt_vbsa',
> +  'virtio_villain',
>    'xen',
>    'xlnx_versal',
>  ]
> diff --git a/tests/functional/generic/test_virtio_villain.py b/tests/functional/generic/test_virtio_villain.py
> new file mode 100755
> index 0000000000..d4e656edc0
> --- /dev/null
> +++ b/tests/functional/generic/test_virtio_villain.py
> @@ -0,0 +1,195 @@
> +#!/usr/bin/env python3
> +#
> +# virtio-villain functional test
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# This test drives the virtio-villain harness, a git submodule under
> +# tests/functional/virtio-villain, against the QEMU under test. The
> +# harness boots one short lived guest per case. Each case violates one
> +# driver rule from the virtio spec and checks that the device model
> +# handles it without crashing, hanging, or corrupting state.
> +#
> +# virtio-villain targets x86_64 and aarch64. The guest init is built
> +# static with musl-gcc or the host compiler for a native guest, or with
> +# an architecture cross compiler when the guest differs from the host.
> +# The whole supported suite runs one guest per case and the test fails
> +# if any case is FAIL, WEDGED, or XPASS. Cases needing host support that
> +# is absent, such as vhost-vsock or a virtiofs daemon, are skipped by
> +# --skip-unsupported.
> +#
> +# Run it directly with meson test -C <build> --setup thorough
> +# func-<arch>-virtio_villain
> +
> +import ast
> +import json
> +import os
> +import platform
> +import re
> +import shutil
> +import subprocess
> +import unittest
> +from unittest import mock
> +
> +from qemu_test import Asset, QemuSystemTest, skipIfMissingCommands
> +
> +
> +ASSET_KERNEL_X86_64 = Asset(
> +    ('https://github.com/cloud-hypervisor/linux/releases/download/'
> +     'ch-release-v6.16.9-20260508/vmlinux-x86_64'),
> +    '9d3570b47d5abb069ca00edfbfcef4c68306a9c3d078a01f10082b258f1001b8')
> +
> +ASSET_KERNEL_AARCH64 = Asset(
> +    ('https://github.com/cloud-hypervisor/linux/releases/download/'
> +     'ch-release-v6.16.9-20260508/Image-arm64'),
> +    '69d1b1235381ec50f1b45cf771a7dff4a9013d452833ab34682d6283e2114010')
> +
> +KERNELS = {
> +    'x86_64': ASSET_KERNEL_X86_64,
> +    'aarch64': ASSET_KERNEL_AARCH64,
> +}
> +
> +
> +def _native_compiler():
> +    if shutil.which('musl-gcc'):
> +        return 'musl-gcc'
> +    build_root = os.environ.get('MESON_BUILD_ROOT')
> +    if build_root:
> +        cross = os.path.join(build_root, 'config-meson.cross')
> +        try:
> +            with open(cross) as f:
> +                for line in f:
> +                    if line.strip().startswith('c ='):
> +                        val = ast.literal_eval(line.split('=', 1)[1].strip())
> +                        return val[0] if isinstance(val, list) else val
> +        except OSError:
> +            pass
> +    return 'cc'
> +
> +
> +def _villain_compiler(arch):
> +    if arch == platform.machine():
> +        return _native_compiler()
> +    for cc in (arch + '-linux-musl-gcc', arch + '-linux-gnu-gcc'):
> +        if shutil.which(cc):
> +            return cc
> +    return None
> +
> +
> +_ANSI_RE = re.compile(r'\x1b\[[0-9;?]*[ -/]*[@-~]')
> +
> +
> +def _clean(text):
> +    return _ANSI_RE.sub('', text.replace('\r', ''))
> +
> +
> +class VirtioVillain(QemuSystemTest):
> +
> +    timeout = 900
> +
> +    @skipIfMissingCommands('make', 'strip', 'cpio', 'gzip')
> +    def test_suite(self):
> +        kernel = KERNELS.get(self.arch)
> +        if kernel is None:
> +            self.skipTest('no virtio-villain kernel for %s' % self.arch)
> +        cc = _villain_compiler(self.arch)
> +        if cc is None:
> +            self.skipTest('no compiler to build the %s guest init'
> +                          % self.arch)
> +
> +        villain_dir = os.path.join(os.path.dirname(__file__), '..',
> +                                   'virtio-villain')
> +        # The runner reads the initramfs from its own default target path.
> +        subprocess.run(['make', '-C', villain_dir, 'initramfs',
> +                        f'-j{os.cpu_count() or 1}',
> +                        f'CC={cc}',
> +                        'CFLAGS=-static -O2 -Wall -Wextra -Werror '
> +                        '-Wno-unused-but-set-variable'],
> +                       stdout=subprocess.DEVNULL, check=True)
> +
> +        report = self.scratch_file('villain-report.json')
> +        runner = os.path.join(villain_dir, 'run')
> +        result = subprocess.run(
> +            [runner, '-m', self.qemu_bin,
> +             '-k', kernel.fetch(),
> +             '--skip-unsupported',
> +             '-j', str(os.cpu_count() or 1),
> +             '--format', 'json', '--output', report],
> +            capture_output=True, text=True, check=False)
> +
> +        if not os.path.exists(report):
> +            self.fail('virtio-villain runner produced no report:\n'
> +                      + (result.stderr or result.stdout or '')[-2000:])
> +
> +        with open(report) as f:
> +            data = json.load(f)
> +        counts = data['counts']
> +        self.log.info('virtio-villain: %d tests, %s', data['total'], counts)
> +
> +        bad = [t for t in data['tests']
> +               if t['status'] in ('FAIL', 'WEDGED', 'XPASS')]
> +
> +        runlog = os.path.join(self.outputdir, 'villain-run.log')
> +        with open(runlog, 'w') as f:
> +            f.write(_clean(result.stdout or ''))
> +            for t in bad:
> +                f.write('\n===== %s %s (spec %s) %s =====\n'
> +                        % (t['status'], t['name'], t.get('spec_section'),
> +                           t.get('description')))
> +                f.write(_clean(t.get('output') or ''))
> +        self.log.info('virtio-villain full log: %s', runlog)
> +
> +        if bad:
> +            detail = '\n  '.join(
> +                '%s %s (spec %s) %s'
> +                % (t['status'], t['name'], t.get('spec_section'),
> +                   t.get('description'))
> +                for t in bad)
> +            self.fail('virtio-villain reported %d failing case(s):\n  %s\n'
> +                      'full guest output in %s'
> +                      % (len(bad), detail, runlog))

Looking at what you end up needing todo in this method, I think that
my advice to try integrating with the functional test suite was a
mistake.

The building of the initramfs  would work better as a custom_target()
rule in meson.build, where you have direct access to the native compiler
names to use.

We also have some cross compiler info available, though currently that
is scoped to only tests/tcg/meson.build. Making it available to the
villain test would need some re-factoring. Probably best to get the
native compiler integration with villain done first, and worry about
cross-builds as a followup once we're happy with the native tests.

The other issue is that when running the tests, it need to pass
'-j os-cpu_count()' to stop the tests being serialized, but that
introduces double parallelization, because meson itself already
runs other test jobs in parallel to the entire test_virtio_villain.py
test program.

I should have realized the latter problem would exist when making
my recommendation to use functional test harness, as we faced the
same issue already with the QEMU I/O test harness. Essentially
test harnesses calling test harnesses ends up creating problems.

The way we have to solve this is by exposing individual tests
directly to meson, so that it has full visibility of all individual
tests and can control parallel jobs directly, with minimal impact
from the secondary test harness underneath.

The only parts of the functional test suite you're benefitting
from are the kernel download caching, and helpers for temporary
scratch file paths. That isn't compelling enough to justify the
downsides.

So I'm inclined to say we should instead treat this as its own
standalone test suite, and control it all from meson directly.

Put submodule at tests/virtio-villain

A file tests/virtio-villain-list.py  that initializes
the git submodule and enumerates the tests.

We can't rely on running 'target/init --list-tsv' since it won't
be built yet, but it looks like you have a formal naming
convention for files under tests/, so we can get test names from
the first component of the filename.

A custom_target() that invokes the "initramfs" build process,
but with 'build_by_default: false', so we don't trigger that
slow build process every time.

Use run_command() to invoke the virtio-villain-list.py file
and iterate over the reported test names, creating a
meson  test() function for each one, using a meson suite
of "virtio-villain", invoking 'run' with the single test
name. The test() should depend on the custom_target() so
that the initramfs gets built-on-demand when the first
test is run.

There's an example of how we do this metadata driven test
creation in tests/qemu-iotests/meson.build



> +
> +
> +class VillainHelpers(unittest.TestCase):
> +
> +    def test_kernels_cover_both_arches(self):
> +        self.assertIn('x86_64', KERNELS)
> +        self.assertIn('aarch64', KERNELS)
> +
> +    def test_native_prefers_musl(self):
> +        with mock.patch.object(shutil, 'which',
> +                               side_effect=lambda c: c == 'musl-gcc'):
> +            self.assertEqual(_native_compiler(), 'musl-gcc')
> +
> +    def test_native_falls_back_to_cc(self):
> +        with mock.patch.object(shutil, 'which', return_value=None), \
> +             mock.patch.dict(os.environ, {}, clear=True):
> +            self.assertEqual(_native_compiler(), 'cc')
> +
> +    def test_native_arch_uses_native(self):
> +        with mock.patch.object(platform, 'machine', return_value='x86_64'), \
> +             mock.patch.object(shutil, 'which',
> +                               side_effect=lambda c: c == 'musl-gcc'):
> +            self.assertEqual(_villain_compiler('x86_64'), 'musl-gcc')
> +
> +    def test_foreign_arch_uses_cross(self):
> +        def which(cmd):
> +            if cmd == 'aarch64-linux-gnu-gcc':
> +                return '/usr/bin/' + cmd
> +            return None
> +        with mock.patch.object(platform, 'machine', return_value='x86_64'), \
> +             mock.patch.object(shutil, 'which', side_effect=which):
> +            self.assertEqual(_villain_compiler('aarch64'),
> +                             'aarch64-linux-gnu-gcc')
> +
> +    def test_foreign_arch_without_cross_is_none(self):
> +        with mock.patch.object(platform, 'machine', return_value='x86_64'), \
> +             mock.patch.object(shutil, 'which', return_value=None):
> +            self.assertIsNone(_villain_compiler('aarch64'))
> +
> +    def test_clean_strips_cr_and_escapes(self):
> +        self.assertEqual(_clean('a\r\n\x1b[32mok\x1b[0m\r'), 'a\nok')
> +
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()
> diff --git a/tests/functional/virtio-villain b/tests/functional/virtio-villain
> new file mode 160000
> index 0000000000..59d02ac357
> --- /dev/null
> +++ b/tests/functional/virtio-villain
> @@ -0,0 +1 @@
> +Subproject commit 59d02ac35766732247670ae608177a6fd7181d7f
> diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
> index 0353b2af8e..2a7c708ddb 100644
> --- a/tests/functional/x86_64/meson.build
> +++ b/tests/functional/x86_64/meson.build
> @@ -7,6 +7,7 @@ test_x86_64_timeouts = {
>    'netdev_ethtool' : 180,
>    'replay' : 480,
>    'virtio_balloon': 120,
> +  'virtio_villain' : 900,
>  }
>  
>  tests_x86_64_system_quick = [
> @@ -50,5 +51,6 @@ tests_x86_64_system_thorough = [
>    'vhost_user_bridge',
>    'virtio_balloon',
>    'virtio_gpu',
> +  'virtio_villain',
>    'rebuild_vmfd',
>  ]
> -- 
> 2.55.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


