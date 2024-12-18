Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9570BE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuT0-0005JQ-17; Wed, 18 Dec 2024 08:51:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNuSx-0005EN-Do
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:51:55 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNuSr-0000Fq-Od
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:51:55 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0778F2115C;
 Wed, 18 Dec 2024 13:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734529906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b2G/V2micGkSHdn5/1FIz3gqJiin3SCpR/dhQVLb+bc=;
 b=yP8es6YJO9GqBclLhto8EOPozXCfePX+yicPUEkkZxrgKEcPECkSFd9aQoRNc9bmbMCgZO
 wQb4wdEFh/d3dhCll+11jlbbHNrNVNPObyrKROXWE/nfSABayIm71vES2JzUTtUeBLaTlR
 y1qOS41KVVYYx4HURVFS76o8fsHLhf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734529906;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b2G/V2micGkSHdn5/1FIz3gqJiin3SCpR/dhQVLb+bc=;
 b=/zfrp+12139OTQpn4bhZgNiyBm5Mt0bRO6B9KcVtObcKcfZlXRGvfYGrHbmSjhvycr+Jib
 HeIP4Nr4M75i3lCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yP8es6YJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/zfrp+12"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734529906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b2G/V2micGkSHdn5/1FIz3gqJiin3SCpR/dhQVLb+bc=;
 b=yP8es6YJO9GqBclLhto8EOPozXCfePX+yicPUEkkZxrgKEcPECkSFd9aQoRNc9bmbMCgZO
 wQb4wdEFh/d3dhCll+11jlbbHNrNVNPObyrKROXWE/nfSABayIm71vES2JzUTtUeBLaTlR
 y1qOS41KVVYYx4HURVFS76o8fsHLhf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734529906;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b2G/V2micGkSHdn5/1FIz3gqJiin3SCpR/dhQVLb+bc=;
 b=/zfrp+12139OTQpn4bhZgNiyBm5Mt0bRO6B9KcVtObcKcfZlXRGvfYGrHbmSjhvycr+Jib
 HeIP4Nr4M75i3lCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 822EC132EA;
 Wed, 18 Dec 2024 13:51:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id taDJEXHTYmeNGQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 18 Dec 2024 13:51:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, =?utf-8?Q?Daniel_P=2E?=
 =?utf-8?Q?_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 5/5] tests/functional: Convert the migration avocado
 test
In-Reply-To: <20241218131439.255841-6-thuth@redhat.com>
References: <20241218131439.255841-1-thuth@redhat.com>
 <20241218131439.255841-6-thuth@redhat.com>
Date: Wed, 18 Dec 2024 10:51:42 -0300
Message-ID: <87o719umj5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 0778F2115C
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> Now that we've got a find_free_port() function in the functional
> test framework, we can convert the migration test, too.
> While the original avocado test was only meant to run on aarch64,
> ppc64 and x86, we can turn this into a more generic test by now
> and run it on all architectures that have a default machine that
> ships with a working firmware.

I'd rather drop this test. I haven't looked at it in ages and it has
never been useful. I haven't been following the development of the
functional suite so this might not apply this time (fingers crossed),
but Python tests have always been a pain to work with.

About adding more architectures to the set, this is not simply enabling
more testing, it is also adding workload to maintain these other arches
that were never tested with migration. Is that something we want?

Also note that what is actually prone to break is compatibility between
versions, which is not covered by this test.

>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                                   |   1 +
>  tests/functional/meson.build                  |  19 +++
>  .../test_migration.py}                        | 121 +++++-------------
>  3 files changed, 54 insertions(+), 87 deletions(-)
>  rename tests/{avocado/migration.py => functional/test_migration.py} (41%)
>  mode change 100644 => 100755
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 389b390de1..704648d57a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3429,6 +3429,7 @@ F: include/migration/
>  F: include/qemu/userfaultfd.h
>  F: migration/
>  F: scripts/vmstate-static-checker.py
> +F: tests/functional/test_migration.py
>  F: tests/vmstate-static-checker-data/
>  F: tests/qtest/migration/
>  F: tests/qtest/migration-*
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 781bd7eae6..8c3d1c26da 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -70,6 +70,10 @@ tests_aarch64_system_thorough = [
>    'multiprocess',
>  ]
>  
> +tests_alpha_system_quick = [
> +  'migration',
> +]
> +
>  tests_alpha_system_thorough = [
>    'alpha_clipper',
>  ]
> @@ -167,6 +171,10 @@ tests_ppc_system_thorough = [
>    'ppc_virtex_ml507',
>  ]
>  
> +tests_ppc64_system_quick = [
> +  'migration',
> +]
> +
>  tests_ppc64_system_thorough = [
>    'ppc64_e500',
>    'ppc64_hv',
> @@ -176,6 +184,7 @@ tests_ppc64_system_thorough = [
>  ]
>  
>  tests_riscv32_system_quick = [
> +  'migration',
>    'riscv_opensbi',
>  ]
>  
> @@ -184,6 +193,7 @@ tests_riscv32_system_thorough = [
>  ]
>  
>  tests_riscv64_system_quick = [
> +  'migration',
>    'riscv_opensbi',
>  ]
>  
> @@ -210,10 +220,18 @@ tests_sh4eb_system_thorough = [
>    'sh4eb_r2d',
>  ]
>  
> +tests_sparc_system_quick = [
> +  'migration',
> +]
> +
>  tests_sparc_system_thorough = [
>    'sparc_sun4m',
>  ]
>  
> +tests_sparc64_system_quick = [
> +  'migration',
> +]
> +
>  tests_sparc64_system_thorough = [
>    'sparc64_sun4u',
>    'sparc64_tuxrun',
> @@ -222,6 +240,7 @@ tests_sparc64_system_thorough = [
>  tests_x86_64_system_quick = [
>    'cpu_queries',
>    'mem_addr_space',
> +  'migration',
>    'pc_cpu_hotplug_props',
>    'virtio_version',
>    'x86_cpu_model_versions',
> diff --git a/tests/avocado/migration.py b/tests/functional/test_migration.py
> old mode 100644
> new mode 100755
> similarity index 41%
> rename from tests/avocado/migration.py
> rename to tests/functional/test_migration.py
> index be6234b3c2..5607d601eb
> --- a/tests/avocado/migration.py
> +++ b/tests/functional/test_migration.py
> @@ -1,3 +1,5 @@
> +#!/usr/bin/env python3
> +#
>  # Migration test
>  #
>  # Copyright (c) 2019 Red Hat, Inc.
> @@ -9,22 +11,14 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>  
> -
> -import tempfile
>  import os
> +import tempfile
> +import time
>  
> -from avocado_qemu import QemuSystemTest
> -from avocado import skipUnless
> -
> -from avocado.utils.network import ports
> -from avocado.utils import wait
> -from avocado.utils.path import find_command
> -
> +from qemu_test import QemuSystemTest, skipIfMissingCommands
> +from qemu_test.ports import Ports
>  
>  class MigrationTest(QemuSystemTest):
> -    """
> -    :avocado: tags=migration
> -    """
>  
>      timeout = 10
>  
> @@ -33,103 +27,56 @@ def migration_finished(vm):
>          return vm.cmd('query-migrate')['status'] in ('completed', 'failed')
>  
>      def assert_migration(self, src_vm, dst_vm):
> -        wait.wait_for(self.migration_finished,
> -                      timeout=self.timeout,
> -                      step=0.1,
> -                      args=(src_vm,))
> -        wait.wait_for(self.migration_finished,
> -                      timeout=self.timeout,
> -                      step=0.1,
> -                      args=(dst_vm,))
> +
> +        end = time.monotonic() + self.timeout
> +        while time.monotonic() < end and not self.migration_finished(src_vm):
> +           time.sleep(0.1)
> +
> +        end = time.monotonic() + self.timeout
> +        while time.monotonic() < end and not self.migration_finished(dst_vm):
> +           time.sleep(0.1)
> +
>          self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
>          self.assertEqual(dst_vm.cmd('query-migrate')['status'], 'completed')
>          self.assertEqual(dst_vm.cmd('query-status')['status'], 'running')
>          self.assertEqual(src_vm.cmd('query-status')['status'],'postmigrate')
>  
>      def do_migrate(self, dest_uri, src_uri=None):
> -        dest_vm = self.get_vm('-incoming', dest_uri)
> +        dest_vm = self.get_vm('-incoming', dest_uri, name="dest-qemu")
>          dest_vm.add_args('-nodefaults')
>          dest_vm.launch()
>          if src_uri is None:
>              src_uri = dest_uri
> -        source_vm = self.get_vm()
> +        source_vm = self.get_vm(name="source-qemu")
>          source_vm.add_args('-nodefaults')
>          source_vm.launch()
>          source_vm.qmp('migrate', uri=src_uri)
>          self.assert_migration(source_vm, dest_vm)
>  
> -    def _get_free_port(self):
> +    def _get_free_port(self, ports):
>          port = ports.find_free_port()
>          if port is None:
> -            self.cancel('Failed to find a free port')
> +            self.skipTest('Failed to find a free port')
>          return port
>  
> -    def migration_with_tcp_localhost(self):
> -        dest_uri = 'tcp:localhost:%u' % self._get_free_port()
> -        self.do_migrate(dest_uri)
> +    def test_migration_with_tcp_localhost(self):
> +        with Ports() as ports:
> +            dest_uri = 'tcp:localhost:%u' % self._get_free_port(ports)
> +            self.do_migrate(dest_uri)
>  
> -    def migration_with_unix(self):
> +    def test_migration_with_unix(self):
>          with tempfile.TemporaryDirectory(prefix='socket_') as socket_path:
>              dest_uri = 'unix:%s/qemu-test.sock' % socket_path
>              self.do_migrate(dest_uri)
>  
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
> +    @skipIfMissingCommands('nc')
>      def test_migration_with_exec(self):
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
> +        """The test works for both netcat-traditional and netcat-openbsd packages."""
> +        with Ports() as ports:
> +            free_port = self._get_free_port(ports)
> +            dest_uri = 'exec:nc -l localhost %u' % free_port
> +            src_uri = 'exec:nc localhost %u' % free_port
> +            self.do_migrate(dest_uri, src_uri)
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()

