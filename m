Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDC8CC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGiw1-0004bp-PG; Tue, 13 Oct 2026 16:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xGivj-0004ai-Si
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 16:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xGivh-0004Zg-J3
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 16:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791922615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sOYkf3pvlTjYQ09UWu0pgZLYNjp8arh5Xzu10pz50KY=;
 b=HsyhRN9rATpOAiVWHvO0ZSGyHzzShhYYgvRczZ129m08VMywmI0hPWCm/LFJ7p21XPbgtA
 iNHrABL71mj/flWcDtF6YbbhZusABu/tTFgGRCxG+ZR/5M6dpf2aEpNtPVDbtSVIq99Jn1
 il2yKidTbE8cE7DVzheqZpuEKNAAvUw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-fjMU9685MymSEZEBr6GvEQ-1; Tue, 13 Oct 2026 20:16:54 +0000
X-MC-Unique: fjMU9685MymSEZEBr6GvEQ-1
X-Mimecast-MFC-AGG-ID: fjMU9685MymSEZEBr6GvEQ_1791922614
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5358515b4easo64315661cf.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 13:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791922614; x=1792527414; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sOYkf3pvlTjYQ09UWu0pgZLYNjp8arh5Xzu10pz50KY=;
 b=X71r4ndMmi1+Hb40J5iBpmgLkzjmiTSdkQg6ebTQcy5fGtzjtcwgIhWEtCWSYbMLgT
 vUDOe7lPM+j/Q546/WubbAPY4txTyAOIjO574FylUYcIXWrWt4XDtpbcY/U3V/jEnPpB
 WbwgZC8PZqBl3WO4DErLVpi75TV6D9Qa8Ros6XncjTWEaot2FgOJUP7bWg00U1TmtiGf
 OANTzQxSIuVf2mjRdw83UwsROt+MS12Qcj5v7RL8k5tRZ67ha0F2KgslFDrDeavXV/h4
 pSSVc2BPRjg27HDywHdxnVgBWgMjDyqAeJdDDp1UFOLNjUyR13JfDxNS55cQl4JtBD+T
 rDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791922614; x=1792527414;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sOYkf3pvlTjYQ09UWu0pgZLYNjp8arh5Xzu10pz50KY=;
 b=PJxbsx1pDVw2fEvm0EHXJDr03Hxg+1u97e9Agky9kut0dWe9PFT+nNPSfi26sgQzBi
 JNocd0/zQfjdm/zP1dXXvvIbGlSkUEu+afKUehYlGAqHgfQ+/PDfOw41fSgjCAYIIg2z
 mmdURb980UO5GvN/3H2wpRDNIOLkF0d0NwYWufAqa6lWpVbRxFY9YgWGncP6cRzib1/3
 ZwK5ZfKUfk1jNN4DTcyK4CJtxkkRFNTCLqNNjsybhL28ztI8v62cuU+qca2eDB7fF7F+
 bs7Q5g0KMzD33/vvN7gbUpOIf7NWvRzTbc61yeO2JlYe6FPYRsGt6ddiDbsDhLk4BzNV
 ajpg==
X-Forwarded-Encrypted: i=1;
 AKwUvByP7maacSilN8ZZ6zMhtUIgD73Lj+6JSSAufhwh8Oqdjf+7PacxVLxGhEQj7BM+7IOESmzf0XI4mP0E@nongnu.org
X-Gm-Message-State: AFq9FYIyBmKXU9ltyDBkA/W0THVMXD01JRZ+SJ1VC4IVGJRbJj10wJ9V
 5g+O6chcY3uoxdr3AoQLSVkGvyF7VzL8i0TSFWNeMXHmPdc7lfQWaTOIRf8U8fhZ9+s6FG2cYXH
 Xvkf4rBb5brrP+YuXKULpehh7SlEwkdfN9RAIBmpv7UfGJtKjCqceSnhj
X-Gm-Gg: AYBFou0kOAIFLOuQWyqW82a34ZPfQRlLHzsm5Vevbyv//QVRCVQ++0Qao8kI4hAJ9Mg
 Gcix1J8A4VXIn/R4CBmU51slrLofizVWUtdtx+c2E61p3oFUO8QGdljPy7jyUSvumTFCnL+UwNn
 Lmebe9HCli2gRyyqfEvmABuubRvgsFgYT8Yrq0t8HSfPrx7EYOoSvkwWdvs6nNnMVJNdKtqUOeW
 bhxHN4l1PmcFv+GFASe3RUQJ+vebjjDVmLfIRM60pK24gRu2sIhCJ3siIE7fWmXCqxIi/Phb7iK
 SyMoAtHUDgjAO44/GIVp0W93NRlIU3ZTc2l+do4UzDnruFWQRHygGrok7iCFzeL5gFbkgu4=
X-Received: by 2002:a05:622a:a0d:b0:535:1d94:5889 with SMTP id
 d75a77b69052e-5359fb31598mr206499101cf.33.1791922613695; 
 Tue, 13 Oct 2026 13:16:53 -0700 (PDT)
X-Received: by 2002:a05:622a:a0d:b0:535:1d94:5889 with SMTP id
 d75a77b69052e-5359fb31598mr206498521cf.33.1791922613144; 
 Tue, 13 Oct 2026 13:16:53 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b97c39482sm33602236d6.45.2026.10.13.13.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 13:16:52 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:16:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "open list:nvme" <qemu-block@nongnu.org>
Subject: Re: [RFC PATCH] tests/functional: add migration diagnostics and pace
 nvme activity (HACK!)
Message-ID: <as6RsuZP6jkZ8twC@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260921190345.1709227-1-alex.bennee@linaro.org>
 <asZIy2Rm8QF4TSca@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAJqdLrqxJF4tgfRYrm27rGivP-HyLUX=YCNUiaFqq4nDq0a5pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJqdLrqxJF4tgfRYrm27rGivP-HyLUX=YCNUiaFqq4nDq0a5pQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 09, 2026 at 07:52:29PM +0200, Alexander Mikhalitsyn wrote:
> Am Mi., 7. Okt. 2026 um 15:27 Uhr schrieb Peter Xu <peterx@redhat.com>:
> >
> > On Mon, Sep 21, 2026 at 08:03:45PM +0100, Alex Bennée wrote:
> > > This is a hacky patch for comment but I've included the diagnostic
> > > hacks to the migration test as well as my workaround to get itworking.
> > >
> > > This test was failing on my KVM system. On investigation I found the
> > > nVME activity meant the migration never completed. I ended up
> > > inserting some sleeps into the workload script until I was able to
> > > get it to run.
> >
> > Indeed, I can reproduce it too:
> 
> Hi Peter,

Hi, Alexander,

Thanks for loooking into this, and sorry for a late update.  Before saying
this is a right fix, I have some questions inline.

> 
> thank you checking on your system and sharing a stacktrace.
> Unfortunately, I wasn't able to reproduce this failure on my system,
> but I think I have a good theory what's going on there. I think it is
> because we use `snapshot=on` for a disk device and at the same time
> keep important stuff like `/tmp/test_nvme_mig_workload.pid` on a root
> filesystem. Easy fix is to use tmpfs for /tmp, so all data is actually
> migrated.
> 
> Please, can you try the following patch and let me know if this fixes
> the issue or not:
> 
> --- a/tests/functional/x86_64/test_nvme_migration.py
> +++ b/tests/functional/x86_64/test_nvme_migration.py
> @@ -75,6 +75,11 @@ def configure_machine(self, vm):
>      def launch_source_vm(self, vm):
>          vm.launch()
> 
> +        vm.cmd('migrate-set-parameters', **{
> +            'downtime-limit': 2000000,

One thing to mention is downtime-limit is in milliseconds, this is 2000sec,
so I would expect whatever guest runs, this converges in the 1st second..

> +            'max-bandwidth': 10 * 1024**3,

Yes we want some sane bandwidth maybe, indeed, default is normally too
small.

> +        })
> +
>          self.wait_for_console_pattern('Entering emergency mode.', vm)
>          prompt = '# '
>          self.wait_for_console_pattern(prompt, vm)
> @@ -94,6 +99,8 @@ def launch_source_vm(self, vm):
>                                            prompt, vm=vm)
>          exec_command_and_wait_for_pattern(self, 'mount -t sysfs sysfs /sys',
>                                            prompt, vm=vm)
> +        exec_command_and_wait_for_pattern(self, 'mount -t tmpfs tmpfs /tmp',
> +                                          prompt, vm=vm)

Why this is needed?  I was expecting /tmp normally is already mounted with
tmpfs, no?

One thing that might be relevant is the use of snapshot=on on the drives,
which means, IIUC, there's a top layer qcow2 overlay on the image file
specified.

Now thinking about it, if snapshot=on implies an anon invisible overlay, it
should not support migration at all?  It means, this QEMU instance contains
some anonymous qcow2 overlay that can never (am I right?) be migrated,
since it's neither part of device state, nor guest memory (unlike /tmp
mount in guest).

So I feel like there's still something is off, e.g. I wonder if we should:

- add a migration blocker for snapshot=on whenever used.. because I can't
  see how it can work at all...

- for this test, should we remove snapshot=on but instead create an
  explicit overlay that will be used on both src/dst qemu?

Thanks,

> 
>          # Run workload before migration to check if it continues
>          # to run properly after migration.
> 
> Kind regards,
> Alex
> 
> >
> > $ ./run ../tests/functional/x86_64/test_nvme_migration.py X8664NVMeMigrationTest.test_migration_with_unix
> > TAP version 13
> > Traceback (most recent call last):
> >   File "/home/zhexu/git/qemu/tests/functional/x86_64/test_nvme_migration.py", line 162, in test_migration_with_unix
> >     self.migration_with_unix()
> >     ~~~~~~~~~~~~~~~~~~~~~~~~^^
> >   File "/home/zhexu/git/qemu/tests/functional/migration.py", line 98, in migration_with_unix
> >     self.migrate(dst_uri)
> >     ~~~~~~~~~~~~^^^^^^^^^
> >   File "/home/zhexu/git/qemu/tests/functional/migration.py", line 78, in migrate
> >     self.migrate_vms(dst_uri, src_uri, dst_vm, src_vm)
> >     ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "/home/zhexu/git/qemu/tests/functional/migration.py", line 63, in migrate_vms
> >     self.assert_dest_vm(dst_vm)
> >     ~~~~~~~~~~~~~~~~~~~^^^^^^^^
> >   File "/home/zhexu/git/qemu/tests/functional/x86_64/test_nvme_migration.py", line 128, in assert_dest_vm
> >     self.exec_command_and_check(
> >     ~~~~~~~~~~~~~~~~~~~~~~~~~~~^
> >         "kill -0 $(cat /tmp/test_nvme_mig_workload.pid)", vm)
> >         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "/home/zhexu/git/qemu/tests/functional/x86_64/test_nvme_migration.py", line 48, in exec_command_and_check
> >     wait_for_console_pattern(self, 'OK', failure_message="FAIL", vm=vm)
> >     ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "/home/zhexu/git/qemu/tests/functional/qemu_test/cmd.py", line 191, in wait_for_console_pattern
> >     return _console_interaction(test, success_message, failure_message,
> >                                 None, vm=vm)
> >   File "/home/zhexu/git/qemu/tests/functional/qemu_test/cmd.py", line 134, in _console_interaction
> >     done, line = _console_read_line_until_match(test, vm,
> >                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
> >                                                 success_message_b,
> >                                                 ^^^^^^^^^^^^^^^^^^
> >                                                 failure_message_b)
> >                                                 ^^^^^^^^^^^^^^^^^^
> >   File "/home/zhexu/git/qemu/tests/functional/qemu_test/cmd.py", line 70, in _console_read_line_until_match
> >     test.fail(
> >     ~~~~~~~~~^
> >         f"'{failure}' found in console, expected '{success}'")
> >         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > AssertionError: 'b'FAIL'' found in console, expected 'b'OK''
> >
> > not ok 1 test_nvme_migration.X8664NVMeMigrationTest.test_migration_with_unix
> > 1..1
> >
> > Copy the author too (Alexander).
> >
> > >
> > > *NOTE*: obviously this can't be merged as is but I think we could
> > > certainly do with more tracking in the test to see when things aren't
> > > working with possibly the sleep as another patch.
> > >
> > > Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> > > ---
> > >  tests/functional/migration.py                 | 37 +++++++++++++++----
> > >  .../functional/x86_64/test_nvme_migration.py  |  1 +
> > >  2 files changed, 31 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tests/functional/migration.py b/tests/functional/migration.py
> > > index 8d2428efc24..e51a82c22f4 100644
> > > --- a/tests/functional/migration.py
> > > +++ b/tests/functional/migration.py
> > > @@ -22,18 +22,41 @@ class MigrationTest(QemuSystemTest):
> > >      timeout = 10
> > >
> > >      @staticmethod
> > > -    def migration_finished(vm):
> > > -        return vm.cmd('query-migrate')['status'] in ('completed', 'failed')
> > > +    def migration_finished(query):
> > > +        return query['status'] in ('completed', 'failed')
> > >
> > > -    def assert_migration(self, src_vm, dst_vm):
> > > +    def wait_for_vm(self, src_or_dst, vm):
> > > +        "Track the state of one VM in the migration"
> > > +        current_state = last_state = vm.cmd('query-migrate')
> > >
> > > -        end = time.monotonic() + self.timeout
> > > -        while time.monotonic() < end and not self.migration_finished(src_vm):
> > > -            time.sleep(0.1)
> > > +        self.log.info(f"waiting for {src_or_dst} to complete")
> > >
> > >          end = time.monotonic() + self.timeout
> > > -        while time.monotonic() < end and not self.migration_finished(dst_vm):
> > > +        while time.monotonic() < end:
> > > +            if self.migration_finished(current_state):
> > > +                break
> > > +            else:
> > > +                last_remain = last_state['remaining']
> > > +                current_remain = current_state['remaining']
> > > +
> > > +                if current_remain > last_remain:
> > > +                    self.log.warning(f"slow migration {current_remain} > {last_remain}")
> > > +
> > >              time.sleep(0.1)
> > > +            last_state = current_state
> > > +            current_state = vm.cmd('query-migrate')
> > > +
> > > +
> > > +    def assert_migration(self, src_vm, dst_vm):
> > > +
> > > +        self.wait_for_vm("src", src_vm)
> > > +
> > > +        # if we hit this we never completed...
> > > +        self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
> > > +
> > > +        self.wait_for_vm("dst", dst_vm)
> > > +
> > > +        self.log.info("checking everything is OK")
> > >
> > >          self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
> > >          self.assertEqual(dst_vm.cmd('query-migrate')['status'], 'completed')
> > > diff --git a/tests/functional/x86_64/test_nvme_migration.py b/tests/functional/x86_64/test_nvme_migration.py
> > > index 890f0aab6d6..58596f63cd3 100755
> > > --- a/tests/functional/x86_64/test_nvme_migration.py
> > > +++ b/tests/functional/x86_64/test_nvme_migration.py
> > > @@ -109,6 +109,7 @@ def launch_source_vm(self, vm):
> > >                  rm -f /tmp/test_nvme_mig_workload.iter_finished; \
> > >                  echo 3 > /proc/sys/vm/drop_caches; \
> > >                  find /usr/bin -type f -exec cksum {} \\;; \
> > > +                sleep 0.3; \
> > >                  touch /tmp/test_nvme_mig_workload.iter_finished; \
> > >              done) > /dev/null 2> /tmp/test_nvme_mig_workload.errors &",
> > >              prompt, vm=vm)
> > > --
> > > 2.47.3
> > >
> >
> > --
> > Peter Xu
> >
> 

-- 
Peter Xu


