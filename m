Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06275FD377B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 18:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvJUz-0005UQ-Nt; Wed, 25 Feb 2026 13:20:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vvJUu-0005Tq-GT
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 13:20:32 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vvJUo-0005LD-Nl
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 13:20:29 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A70E05C074;
 Wed, 25 Feb 2026 18:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772043621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8xOYuiTL5FTuKOAyW3TK5VFVz2F8y4lK+sI5MQacP1w=;
 b=r1siILI6meUUarEndUu7r+1LXJajKTPASRsqzWrj5QalyI4q28QmFDPRaf9sEr6wwdzyEO
 hIfcpdzpByAc9o1B5b4lnp+65KkB9L78j5cpZC7a5eYH6wk4CuEXB/ArtNRz+z9b2U0Tbl
 kFSgd8uHEe055vb03PVWGJTWZgYWLGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772043621;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8xOYuiTL5FTuKOAyW3TK5VFVz2F8y4lK+sI5MQacP1w=;
 b=/XNfvWxC4dhjEKZvx/LXuC96/L+Loy5e/hqy8lRDdOvClGxm0yFJKW16hj5ZTShfF+S4S7
 8mTkAz//Fwqll5Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772043621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8xOYuiTL5FTuKOAyW3TK5VFVz2F8y4lK+sI5MQacP1w=;
 b=r1siILI6meUUarEndUu7r+1LXJajKTPASRsqzWrj5QalyI4q28QmFDPRaf9sEr6wwdzyEO
 hIfcpdzpByAc9o1B5b4lnp+65KkB9L78j5cpZC7a5eYH6wk4CuEXB/ArtNRz+z9b2U0Tbl
 kFSgd8uHEe055vb03PVWGJTWZgYWLGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772043621;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8xOYuiTL5FTuKOAyW3TK5VFVz2F8y4lK+sI5MQacP1w=;
 b=/XNfvWxC4dhjEKZvx/LXuC96/L+Loy5e/hqy8lRDdOvClGxm0yFJKW16hj5ZTShfF+S4S7
 8mTkAz//Fwqll5Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F35B3EA65;
 Wed, 25 Feb 2026 18:20:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CVBbNWQ9n2mdSgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 25 Feb 2026 18:20:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Aditya Gupta
 <adityag@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Harsh
 Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 4/4] tests/functional/ppc64: Remove custom migration
 routine
In-Reply-To: <eedee23c-39dd-4c1a-94e4-d7f1eb0c9d2e@redhat.com>
References: <20260204172332.21367-1-farosas@suse.de>
 <20260204172332.21367-5-farosas@suse.de> <aYOjJEG5paKOObnJ@x1.local>
 <eedee23c-39dd-4c1a-94e4-d7f1eb0c9d2e@redhat.com>
Date: Wed, 25 Feb 2026 15:20:18 -0300
Message-ID: <87ecm83ct9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,redhat.com,linux.ibm.com,gmail.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> On 04/02/2026 20.51, Peter Xu wrote:
>> On Wed, Feb 04, 2026 at 02:23:32PM -0300, Fabiano Rosas wrote:
>>> Don't implement a custom migration routine at PpcMigrationTest and
>>> instead reuse the generic one from MigrationTest.
>>>
>>> This removes the dependency of PpcMigrationTest from
>>> PseriesMachine. Having one test import another causes unittest code to
>>> instantiate the imported test, resulting in the setup and teardown
>>> methods being invoked for the imported test class, even if no test
>>> from that class will be executed.
>>>
>>> If run in parallel, the extra setup/teardown methods that result from
>>> importing can race with the ones from the actual test being executed
>>> and cause the following error:
>>>
>>> File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 238, in tearDown
>>> shutil.rmtree(self.workdir)
>>> ...
>>> FileNotFoundError: [Errno 2] No such file or directory:
>>> '<SRC_DIR>/build/tests/functional/ppc64/.../test_migration_with_exec/scratch'
>>>
>>> Fixes: f4e34d0fd5 ("tests/functional: Add a OS level migration test for pseries")
>>> Reported-by: Aditya Gupta <adityag@linux.ibm.com>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>>   tests/functional/migration.py            |  5 +++++
>>>   tests/functional/ppc64/test_migration.py | 11 -----------
>>>   tests/functional/ppc64/test_pseries.py   |  6 ++++--
>>>   3 files changed, 9 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/tests/functional/migration.py b/tests/functional/migration.py
>>> index 49347a30bb..e995328e83 100644
>>> --- a/tests/functional/migration.py
>>> +++ b/tests/functional/migration.py
>>> @@ -65,6 +65,11 @@ def _get_free_port(self, ports):
>>>               self.skipTest('Failed to find a free port')
>>>           return port
>>>   
>>> +    def migration_with_tcp_localhost_vms(self, dst_vm, src_vm):
>>> +        with Ports() as ports:
>>> +            uri = 'tcp:localhost:%u' % self._get_free_port(ports)
>>> +            self.migrate_vms(uri, uri, dst_vm, src_vm)
>>> +
>>>       def migration_with_tcp_localhost(self):
>>>           with Ports() as ports:
>>>               dst_uri = 'tcp:localhost:%u' % self._get_free_port(ports)
>>> diff --git a/tests/functional/ppc64/test_migration.py b/tests/functional/ppc64/test_migration.py
>>> index a3b819680b..7d49ee175b 100755
>>> --- a/tests/functional/ppc64/test_migration.py
>>> +++ b/tests/functional/ppc64/test_migration.py
>>> @@ -22,17 +22,6 @@ def test_migration_with_exec(self):
>>>           self.set_machine('mac99')
>>>           self.migration_with_exec()
>>>   
>>> -    def do_migrate_ppc64_linux(self, source_vm, dest_vm):
>>> -        with Ports() as ports:
>>> -            port = ports.find_free_port()
>>> -            if port is None:
>>> -                self.skipTest('Failed to find a free port')
>>> -            uri = 'tcp:localhost:%u' % port
>>> -
>>> -            dest_vm.qmp('migrate-incoming', uri=uri)
>>> -            source_vm.qmp('migrate', uri=uri)
>>> -            self.assert_migration(source_vm, dest_vm)
>>> -
>>>   
>>>   if __name__ == '__main__':
>>>       MigrationTest.main()
>>> diff --git a/tests/functional/ppc64/test_pseries.py b/tests/functional/ppc64/test_pseries.py
>>> index b45763c305..3996a4a878 100755
>>> --- a/tests/functional/ppc64/test_pseries.py
>>> +++ b/tests/functional/ppc64/test_pseries.py
>>> @@ -9,7 +9,7 @@
>>>   
>>>   from qemu_test import QemuSystemTest, Asset
>>>   from qemu_test import wait_for_console_pattern
>>> -from test_migration import PpcMigrationTest
>>> +from migration import MigrationTest
>>>   
>>>   class PseriesMachine(QemuSystemTest):
>> 
>> I wonder if PseriesMachine would be better to inherit directly from
>> MigrationTest, to avoid the timeout setup and temp QemuSystemTest to be
>> created on the fly (I'm not familiar with the test framework on side
>> effects).  But I don't see a major issue with it either so far.
>
> I think I'd also prefer to inherit directly from MigrationTest.
> You could put the test_ppc64_linux_migration() method into a separate class 
> that inherits from MigrationTest, while the other test_* methods stay in the 
> old class, so that there is for sure no impact on the other tests.
> (Having multiple test classes in one file is fine, we have that in a couple 
> of other places already).
>

A new class will make it cumbersome to access the class attributes from
PseriesMachine:

    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
    panic_message = 'Kernel panic - not syncing'
    good_message = 'VFS: Cannot open root device'
    ASSET_KERNEL = Asset(...

The "best" way is to make the whole class inherit from MigrationTest. If
you're ok with that I can send a v3.

>   Thomas
>
>
>>>   
>>> @@ -116,7 +116,9 @@ def test_ppc64_linux_migration(self):
>>>           wait_for_console_pattern(self, console_pattern, self.panic_message,
>>>                                    vm=source_vm)
>>>   
>>> -        PpcMigrationTest().do_migrate_ppc64_linux(source_vm, dest_vm);
>>> +        mt = MigrationTest()
>>> +        mt.timeout = self.timeout
>>> +        mt.migration_with_tcp_localhost_vms(dest_vm, source_vm);
>>>   
>>>           # ensure the boot proceeds after migration
>>>           wait_for_console_pattern(self, self.good_message, self.panic_message,
>>> -- 
>>> 2.51.0
>>>
>> 

