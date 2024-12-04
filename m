Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAEDE7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 08:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIkjl-0007KV-5H; Wed, 04 Dec 2024 03:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIkjj-0007K5-Es
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:27:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIkjg-0001xs-5N
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:27:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733300870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gSKjYWZVoSOIivN7Op/1GLE6dzNts6ingsDI6kidN5c=;
 b=G6CGUMO/9bNTKRPT8kGPTCnhL9OVZ8KEEtIh2S0S2wv/aZKunWVgL1Go0JWHSDSOCsb6wr
 DO2xzcNZTkZAtKiur7VFMVfM2aTch7KHttqLqT93LbyiF/+offuG6/wrW6IT2frec6UxHT
 Aa5UMDNPwBdBIn0d98HRKfgEx12mO9E=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-A24qvsp3Nfaa-RU0_1sKdQ-1; Wed, 04 Dec 2024 03:27:49 -0500
X-MC-Unique: A24qvsp3Nfaa-RU0_1sKdQ-1
X-Mimecast-MFC-AGG-ID: A24qvsp3Nfaa-RU0_1sKdQ
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d895f91a7dso58263376d6.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 00:27:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733300868; x=1733905668;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gSKjYWZVoSOIivN7Op/1GLE6dzNts6ingsDI6kidN5c=;
 b=pdCsFjN4HtvYEGI+lArK7vb6/Bey+wPcWK3npuUpHPwqtayxuQV9tfn/rzt0cX88Yt
 uqasTJUyKOQxPieSoeg184tWKUllUHFBHPuPxbes8ruSymI41b3yTYzakQw5btxGZfs0
 crF3O6ThpxVD4YWIqRbMaY1FioPnvdQKpvACi3J2hK+GyZkWp7opH+Mf6dkhf5BlUVcR
 X6C/Ryf9qEaFP0JZwNuxZ7WjdPJx9c3ezLFK+IbTEV9YFwjAhxMsM77LqfyYg5PdFt2j
 TtAUGiRLGh0JunSKpj+aNkDqz/44mtYHvgMyFyKHwKwDu+oNFCToeGaO9K46f4vQy4Pj
 rTpA==
X-Gm-Message-State: AOJu0YyHHB+Szbm/wy7Gr7LZ2sH1J6sdlZyNcYQKCqHed91p5aiLRCiI
 IbtvS74z+sugWyjrwTiSFB6UHSouPfvByEGzYF3gGXPrBhsWzfYnp2or0v2SWhi8UsZH95OCsTD
 ecPGG5OMSvKsmn26nuUm8Cv1EuYq1cJTSkYt7vKf1NEJelqnt1DzfRRhN6kICSN6B7SAoD3T8zT
 FtJVVwISYAyhvk7JI7rsuuVmdd+V104tOf
X-Gm-Gg: ASbGncuS2KXf0QG77Ef1mrwNtWqOIxP1vX1f7GXpCg+MQVNzNL1kjSp7Hz5T6Y9JMIX
 pOngItxLSskVcWGBacsF61lt48R1iRyepihigAvZB9WZNVWzt8p0yiEpThYZDWR0a6/NUd3FIWU
 iqi/wyAzc4yo0TXwHMIpyaTNIxzo3wliB3FYH1P+NVpbv03P2m4GOLNWAqdqc5Av2E6tM7lAJ/q
 wm7L1ZaKY3r6r/gvv77sWWzIkv9fnK80UFDlgGSK1n720smn58GaqCkOK6w15CA5JR6BKGciLP6
 sXZVCw==
X-Received: by 2002:ad4:596c:0:b0:6d8:876e:ef41 with SMTP id
 6a1803df08f44-6d8b737d420mr82736276d6.21.1733300868502; 
 Wed, 04 Dec 2024 00:27:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiclN2pN+rRWd72nDektrrP7fPp0wPJdOUjfeMpf+PKSbLeMWfCePsabs6/ouiEXQP4vRqHA==
X-Received: by 2002:ad4:596c:0:b0:6d8:876e:ef41 with SMTP id
 6a1803df08f44-6d8b737d420mr82735986d6.21.1733300867978; 
 Wed, 04 Dec 2024 00:27:47 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-199.web.vodafone.de.
 [109.42.51.199]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b68492121esm592245585a.3.2024.12.04.00.27.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 00:27:47 -0800 (PST)
Message-ID: <7c4d2051-db47-420b-89a0-a985a662c415@redhat.com>
Date: Wed, 4 Dec 2024 09:27:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] tests/functional: Convert the migration avocado test
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241204071911.664057-1-thuth@redhat.com>
 <20241204071911.664057-6-thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241204071911.664057-6-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 04/12/2024 08.19, Thomas Huth wrote:
> Now that we've got a find_free_port() function in the functional
> test framework, we can convert the migration test, too.
> While the original avocado test was only meant to run on aarch64,
> ppc64 and x86, we can turn this into a more generic test by now
> and run it on all architectures that have a default machine that
> ships with a working firmware.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/migration.py         | 135 -----------------------------
>   tests/functional/meson.build       |  19 ++++
>   tests/functional/test_migration.py |  83 ++++++++++++++++++
>   3 files changed, 102 insertions(+), 135 deletions(-)
>   delete mode 100644 tests/avocado/migration.py
>   create mode 100755 tests/functional/test_migration.py
> 
> diff --git a/tests/avocado/migration.py b/tests/avocado/migration.py
> deleted file mode 100644
> index be6234b3c2..0000000000
> --- a/tests/avocado/migration.py
> +++ /dev/null
> @@ -1,135 +0,0 @@
> -# Migration test
> -#
> -# Copyright (c) 2019 Red Hat, Inc.
> -#
> -# Authors:
> -#  Cleber Rosa <crosa@redhat.com>
> -#  Caio Carrara <ccarrara@redhat.com>
> -#
> -# This work is licensed under the terms of the GNU GPL, version 2 or
> -# later.  See the COPYING file in the top-level directory.
> -
> -
> -import tempfile
> -import os
> -
> -from avocado_qemu import QemuSystemTest
> -from avocado import skipUnless
> -
> -from avocado.utils.network import ports
> -from avocado.utils import wait
> -from avocado.utils.path import find_command
> -
> -
> -class MigrationTest(QemuSystemTest):
> -    """
> -    :avocado: tags=migration
> -    """
> -
> -    timeout = 10
> -
> -    @staticmethod
> -    def migration_finished(vm):
> -        return vm.cmd('query-migrate')['status'] in ('completed', 'failed')
> -
> -    def assert_migration(self, src_vm, dst_vm):
> -        wait.wait_for(self.migration_finished,
> -                      timeout=self.timeout,
> -                      step=0.1,
> -                      args=(src_vm,))
> -        wait.wait_for(self.migration_finished,
> -                      timeout=self.timeout,
> -                      step=0.1,
> -                      args=(dst_vm,))
> -        self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
> -        self.assertEqual(dst_vm.cmd('query-migrate')['status'], 'completed')
> -        self.assertEqual(dst_vm.cmd('query-status')['status'], 'running')
> -        self.assertEqual(src_vm.cmd('query-status')['status'],'postmigrate')
> -
> -    def do_migrate(self, dest_uri, src_uri=None):
> -        dest_vm = self.get_vm('-incoming', dest_uri)
> -        dest_vm.add_args('-nodefaults')
> -        dest_vm.launch()
> -        if src_uri is None:
> -            src_uri = dest_uri
> -        source_vm = self.get_vm()
> -        source_vm.add_args('-nodefaults')
> -        source_vm.launch()
> -        source_vm.qmp('migrate', uri=src_uri)
> -        self.assert_migration(source_vm, dest_vm)
> -
> -    def _get_free_port(self):
> -        port = ports.find_free_port()
> -        if port is None:
> -            self.cancel('Failed to find a free port')
> -        return port
> -
> -    def migration_with_tcp_localhost(self):
> -        dest_uri = 'tcp:localhost:%u' % self._get_free_port()
> -        self.do_migrate(dest_uri)
> -
> -    def migration_with_unix(self):
> -        with tempfile.TemporaryDirectory(prefix='socket_') as socket_path:
> -            dest_uri = 'unix:%s/qemu-test.sock' % socket_path
> -            self.do_migrate(dest_uri)
> -
> -    @skipUnless(find_command('nc', default=False), "'nc' command not found")
> -    def migration_with_exec(self):
> -        """The test works for both netcat-traditional and netcat-openbsd packages."""
> -        free_port = self._get_free_port()
> -        dest_uri = 'exec:nc -l localhost %u' % free_port
> -        src_uri = 'exec:nc localhost %u' % free_port
> -        self.do_migrate(dest_uri, src_uri)
> -
> -
> -@skipUnless('aarch64' in os.uname()[4], "host != target")
> -class Aarch64(MigrationTest):
> -    """
> -    :avocado: tags=arch:aarch64
> -    :avocado: tags=machine:virt
> -    :avocado: tags=cpu:max
> -    """
> -
> -    def test_migration_with_tcp_localhost(self):
> -        self.migration_with_tcp_localhost()
> -
> -    def test_migration_with_unix(self):
> -        self.migration_with_unix()
> -
> -    def test_migration_with_exec(self):
> -        self.migration_with_exec()
> -
> -
> -@skipUnless('x86_64' in os.uname()[4], "host != target")
> -class X86_64(MigrationTest):
> -    """
> -    :avocado: tags=arch:x86_64
> -    :avocado: tags=machine:pc
> -    :avocado: tags=cpu:qemu64
> -    """
> -
> -    def test_migration_with_tcp_localhost(self):
> -        self.migration_with_tcp_localhost()
> -
> -    def test_migration_with_unix(self):
> -        self.migration_with_unix()
> -
> -    def test_migration_with_exec(self):
> -        self.migration_with_exec()
> -
> -
> -@skipUnless('ppc64le' in os.uname()[4], "host != target")
> -class PPC64(MigrationTest):
> -    """
> -    :avocado: tags=arch:ppc64
> -    :avocado: tags=machine:pseries
> -    """
> -
> -    def test_migration_with_tcp_localhost(self):
> -        self.migration_with_tcp_localhost()
> -
> -    def test_migration_with_unix(self):
> -        self.migration_with_unix()
> -
> -    def test_migration_with_exec(self):
> -        self.migration_with_exec()
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 3d29b8245a..0558d0aa4e 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -61,6 +61,10 @@ tests_aarch64_system_thorough = [
>     'multiprocess',
>   ]
>   
> +tests_alpha_system_quick = [
> +  'migration',
> +]
> +
>   tests_alpha_system_thorough = [
>     'alpha_clipper',
>   ]
> @@ -148,6 +152,10 @@ tests_ppc_system_thorough = [
>     'ppc_virtex_ml507',
>   ]
>   
> +tests_ppc64_system_quick = [
> +  'migration',
> +]
> +
>   tests_ppc64_system_thorough = [
>     'ppc64_e500',
>     'ppc64_hv',
> @@ -157,6 +165,7 @@ tests_ppc64_system_thorough = [
>   ]
>   
>   tests_riscv32_system_quick = [
> +  'migration',
>     'riscv_opensbi',
>   ]
>   
> @@ -165,6 +174,7 @@ tests_riscv32_system_thorough = [
>   ]
>   
>   tests_riscv64_system_quick = [
> +  'migration',
>     'riscv_opensbi',
>   ]
>   
> @@ -191,10 +201,18 @@ tests_sh4eb_system_thorough = [
>     'sh4eb_r2d',
>   ]
>   
> +tests_sparc_system_quick = [
> +  'migration',
> +]
> +
>   tests_sparc_system_thorough = [
>     'sparc_sun4m',
>   ]
>   
> +tests_sparc64_system_quick = [
> +  'migration',
> +]
> +
>   tests_sparc64_system_thorough = [
>     'sparc64_sun4u',
>     'sparc64_tuxrun',
> @@ -203,6 +221,7 @@ tests_sparc64_system_thorough = [
>   tests_x86_64_system_quick = [
>     'cpu_queries',
>     'mem_addr_space',
> +  'migration',
>     'pc_cpu_hotplug_props',
>     'virtio_version',
>     'x86_cpu_model_versions',
> diff --git a/tests/functional/test_migration.py b/tests/functional/test_migration.py
> new file mode 100755
> index 0000000000..9c78444f80
> --- /dev/null
> +++ b/tests/functional/test_migration.py
> @@ -0,0 +1,83 @@
> +#!/usr/bin/env python3
> +#
> +# Migration test
> +#
> +# Copyright (c) 2019 Red Hat, Inc.
> +#
> +# Authors:
> +#  Cleber Rosa <crosa@redhat.com>
> +#  Caio Carrara <ccarrara@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import os
> +import tempfile
> +import time
> +
> +from qemu_test import QemuSystemTest, has_cmd
> +from qemu_test.ports import Ports
> +from unittest import skipUnless
> +
> +class MigrationTest(QemuSystemTest):
> +
> +    timeout = 10
> +
> +    @staticmethod
> +    def migration_finished(vm):
> +        return vm.cmd('query-migrate')['status'] in ('completed', 'failed')
> +
> +    def assert_migration(self, src_vm, dst_vm):
> +
> +        end = time.monotonic() + self.timeout
> +        while time.monotonic() < end and not self.migration_finished(src_vm):
> +           time.sleep(0.1)
> +
> +        end = time.monotonic() + self.timeout
> +        while time.monotonic() < end and not self.migration_finished(dst_vm):
> +           time.sleep(0.1)
> +
> +        self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
> +        self.assertEqual(dst_vm.cmd('query-migrate')['status'], 'completed')
> +        self.assertEqual(dst_vm.cmd('query-status')['status'], 'running')
> +        self.assertEqual(src_vm.cmd('query-status')['status'],'postmigrate')
> +
> +    def do_migrate(self, dest_uri, src_uri=None):
> +        dest_vm = self.get_vm('-incoming', dest_uri, name="dest-qemu")
> +        dest_vm.add_args('-nodefaults')
> +        dest_vm.launch()
> +        if src_uri is None:
> +            src_uri = dest_uri
> +        source_vm = self.get_vm(name="source-qemu")
> +        source_vm.add_args('-nodefaults')
> +        source_vm.launch()
> +        source_vm.qmp('migrate', uri=src_uri)
> +        self.assert_migration(source_vm, dest_vm)
> +
> +    def _get_free_port(self, ports):
> +        port = ports.find_free_port()
> +        if port is None:
> +            self.skipTest('Failed to find a free port')
> +        return port
> +
> +    def test_migration_with_tcp_localhost(self):
> +        with Ports() as ports:
> +            dest_uri = 'tcp:localhost:%u' % self._get_free_port(ports)
> +            self.do_migrate(dest_uri)
> +
> +    def test_migration_with_unix(self):
> +        with tempfile.TemporaryDirectory(prefix='socket_') as socket_path:
> +            dest_uri = 'unix:%s/qemu-test.sock' % socket_path
> +            self.do_migrate(dest_uri)
> +
> +    @skipUnless(*has_cmd('nc'))

Note: The TemporaryDirectory socket stuff and the skipUnless should be 
adapted to Daniel's new functions (see 
https://lore.kernel.org/qemu-devel/20241129173120.761728-1-berrange@redhat.com/) 
if they go in first.

  Thomas


> +    def test_migration_with_exec(self):
> +        """The test works for both netcat-traditional and netcat-openbsd packages."""
> +        with Ports() as ports:
> +            free_port = self._get_free_port(ports)
> +            dest_uri = 'exec:nc -l localhost %u' % free_port
> +            src_uri = 'exec:nc localhost %u' % free_port
> +            self.do_migrate(dest_uri, src_uri)
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()


