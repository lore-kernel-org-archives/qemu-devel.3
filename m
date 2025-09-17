Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3142DCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 21:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyzed-0002uo-Tf; Wed, 17 Sep 2025 17:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uyzec-0002uV-56
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 17:25:30 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uyzeZ-0003Ci-9i
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 17:25:29 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 45E381FFB2;
 Wed, 17 Sep 2025 21:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758144325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h4ZpNQ8BLmOn8Wr3K4U05A0TIzKaDpZcKd4B7CJQweI=;
 b=0le7OdpM89Lx3SK/RdFdjl+eoVBIHD7xnfmDL9RIBOLsagc1YNKkiHLgwPqA5dKxSz725e
 a3wepmYMWnh6K7GwdvwWAfelFbXaDLQPT2RUFPqNnfoGpKKveH3/oW+wtyRbRDqWtdlMY/
 CDs8XYOJKdfIzPLnrSzxKgFEg2QlChA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758144325;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h4ZpNQ8BLmOn8Wr3K4U05A0TIzKaDpZcKd4B7CJQweI=;
 b=pIw32ATc6pYqARtJP8Xv9W1oLM9LmFkqHPTcG+g/sXScT5tuTwhl1rK1PhNdWjWND7DWch
 Rrio0hGmRVSaT/BQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0le7OdpM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pIw32ATc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758144325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h4ZpNQ8BLmOn8Wr3K4U05A0TIzKaDpZcKd4B7CJQweI=;
 b=0le7OdpM89Lx3SK/RdFdjl+eoVBIHD7xnfmDL9RIBOLsagc1YNKkiHLgwPqA5dKxSz725e
 a3wepmYMWnh6K7GwdvwWAfelFbXaDLQPT2RUFPqNnfoGpKKveH3/oW+wtyRbRDqWtdlMY/
 CDs8XYOJKdfIzPLnrSzxKgFEg2QlChA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758144325;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h4ZpNQ8BLmOn8Wr3K4U05A0TIzKaDpZcKd4B7CJQweI=;
 b=pIw32ATc6pYqARtJP8Xv9W1oLM9LmFkqHPTcG+g/sXScT5tuTwhl1rK1PhNdWjWND7DWch
 Rrio0hGmRVSaT/BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA598137C3;
 Wed, 17 Sep 2025 21:25:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id njhIGUQny2jpBwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Sep 2025 21:25:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Xu
 <peterx@redhat.com>
Subject: Re: [PATCH v4 4/4] tests/functional: Use vmstate-static-checker.py
 to test data from v7.2
In-Reply-To: <20250912100755.316518-5-thuth@redhat.com>
References: <20250912100755.316518-1-thuth@redhat.com>
 <20250912100755.316518-5-thuth@redhat.com>
Date: Wed, 17 Sep 2025 18:25:21 -0300
Message-ID: <87o6r8vkji.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 45E381FFB2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Thomas Huth <thuth@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> We've got this nice vmstate-static-checker.py script that can help to
> detect screw-ups in the migration states. Unfortunately, it's currently
> only run manually, which can be cumbersome. Let's run it from a functional
> test automatically with the reference data from QEMU 7.2, so that we get
> at least a basic coverage here. Since the test can fail when the checker
> script detects a false positive, mark the test with a skipFlakyTest
> decorator for now, so that it is only run when the user also set the
> QEMU_TEST_FLAKY_TESTS environment variable.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                              |  1 +
>  tests/functional/aarch64/meson.build     |  1 +
>  tests/functional/generic/test_vmstate.py | 67 ++++++++++++++++++++++++
>  tests/functional/m68k/meson.build        |  4 ++
>  tests/functional/ppc64/meson.build       |  1 +
>  tests/functional/s390x/meson.build       |  4 ++
>  tests/functional/x86_64/meson.build      |  3 +-
>  7 files changed, 80 insertions(+), 1 deletion(-)
>  create mode 100755 tests/functional/generic/test_vmstate.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9c8bd7b1180..435155d2116 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3604,6 +3604,7 @@ F: migration/
>  F: scripts/vmstate-static-checker.py
>  F: tests/functional/migration.py
>  F: tests/functional/*/*migration.py
> +F: tests/functional/generic/test_vmstate.py
>  F: tests/functional/x86_64/test_bad_vmstate.py
>  F: tests/data/vmstate-static-checker/
>  F: tests/qtest/migration/
> diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
> index 04846c6eb18..5ad52f93e1d 100644
> --- a/tests/functional/aarch64/meson.build
> +++ b/tests/functional/aarch64/meson.build
> @@ -19,6 +19,7 @@ test_aarch64_timeouts = {
>  
>  tests_aarch64_system_quick = [
>    'migration',
> +  'vmstate',
>  ]
>  
>  tests_aarch64_system_thorough = [
> diff --git a/tests/functional/generic/test_vmstate.py b/tests/functional/generic/test_vmstate.py
> new file mode 100755
> index 00000000000..387ff542426
> --- /dev/null
> +++ b/tests/functional/generic/test_vmstate.py
> @@ -0,0 +1,67 @@
> +#!/usr/bin/env python3
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +'''This test runs the vmstate-static-checker script with the current QEMU'''
> +
> +import subprocess
> +
> +from qemu_test import QemuSystemTest, skipFlakyTest
> +
> +
> +@skipFlakyTest("vmstate-static-checker can produce false positives")
> +class VmStateTest(QemuSystemTest):
> +    '''
> +    This test helps to check whether there are problems between old
> +    reference data and the current QEMU
> +    '''
> +
> +    def test_vmstate_7_2(self):
> +        '''Check reference data from QEMU v7.2'''
> +
> +        target_machine = {
> +            'aarch64': 'virt-7.2',
> +            'm68k': 'virt-7.2',
> +            'ppc64': 'pseries-7.2',
> +            's390x': 's390-ccw-virtio-7.2',
> +            'x86_64': 'pc-q35-7.2',
> +        }
> +        self.set_machine(target_machine[self.arch])
> +
> +        # Run QEMU to get the current vmstate json file:
> +        dst_json = self.scratch_file('dest.json')
> +        self.log.info('Dumping vmstate from %s', self.qemu_bin)
> +        cp = subprocess.run([self.qemu_bin, '-nodefaults',
> +                             '-M', target_machine[self.arch],
> +                             '-dump-vmstate', dst_json],
> +                            stdout=subprocess.PIPE,
> +                            stderr=subprocess.STDOUT,
> +                            text=True, check=True)
> +        if cp.stdout:
> +            self.log.info('QEMU output: %s', cp.stdout)
> +
> +        # Check whether the old vmstate json file is still compatible:
> +        src_json = self.data_file('..', 'data', 'vmstate-static-checker',
> +                                  self.arch,
> +                                  target_machine[self.arch] + '.json')
> +        self.log.info('Comparing vmstate with %s', src_json)
> +        checkerscript = self.data_file('..', '..', 'scripts',
> +                                       'vmstate-static-checker.py')
> +        cp = subprocess.run([checkerscript, '-s', src_json, '-d', dst_json],
> +                            stdout=subprocess.PIPE,
> +                            stderr=subprocess.STDOUT,
> +                            text=True, check=False)
> +        if cp.returncode != 0:
> +            self.fail('Running vmstate-static-checker failed:\n' + cp.stdout +
> +                      '\nThis either means that there is a migration bug '
> +                      'that needs to be fixed, or\nvmstate-static-checker.py '
> +                      'needs to be improved (e.g. extend the changed_names\n'
> +                      'in case a field has been renamed), or drop the '
> +                      'problematic field from\n' + src_json +
> +                      '\nin case the script cannot be fixed easily.')
> +        if cp.stdout:
> +            self.log.warning('vmstate-static-checker output: %s', cp.stdout)
> +
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()
> diff --git a/tests/functional/m68k/meson.build b/tests/functional/m68k/meson.build
> index e29044a6d73..679faaf86d6 100644
> --- a/tests/functional/m68k/meson.build
> +++ b/tests/functional/m68k/meson.build
> @@ -1,5 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  
> +tests_m68k_system_quick = [
> +  'vmstate',
> +]
> +
>  tests_m68k_system_thorough = [
>    'mcf5208evb',
>    'nextcube',
> diff --git a/tests/functional/ppc64/meson.build b/tests/functional/ppc64/meson.build
> index 842fe0fc715..1fa0a70f7ed 100644
> --- a/tests/functional/ppc64/meson.build
> +++ b/tests/functional/ppc64/meson.build
> @@ -11,6 +11,7 @@ test_ppc64_timeouts = {
>  
>  tests_ppc64_system_quick = [
>    'migration',
> +  'vmstate',
>  ]
>  
>  tests_ppc64_system_thorough = [
> diff --git a/tests/functional/s390x/meson.build b/tests/functional/s390x/meson.build
> index 030b116039c..70cd36e2913 100644
> --- a/tests/functional/s390x/meson.build
> +++ b/tests/functional/s390x/meson.build
> @@ -4,6 +4,10 @@ test_s390x_timeouts = {
>    'ccw_virtio' : 420,
>  }
>  
> +tests_s390x_system_quick = [
> +  'vmstate',
> +]
> +
>  tests_s390x_system_thorough = [
>    'ccw_virtio',
>    'pxelinux',
> diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
> index ef12ac43b37..967426c30c3 100644
> --- a/tests/functional/x86_64/meson.build
> +++ b/tests/functional/x86_64/meson.build
> @@ -14,10 +14,11 @@ tests_x86_64_system_quick = [
>    'cpu_model_versions',
>    'cpu_queries',
>    'mem_addr_space',
> +  'memlock',
>    'migration',
>    'pc_cpu_hotplug_props',
>    'virtio_version',
> -  'memlock',
> +  'vmstate',
>  ]
>  
>  tests_x86_64_system_thorough = [

Acked-by: Fabiano Rosas <farosas@suse.de>

