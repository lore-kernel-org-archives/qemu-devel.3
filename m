Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DFBCC6B29
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGuCb-00074b-Ko; Wed, 14 Oct 2026 04:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1xGuCV-000740-SX
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:19:03 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1xGuCS-0001kT-3c
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:19:02 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c2e36c3478aso102971866b.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 01:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791965937; cv=none;
 d=google.com; s=arc-20260327;
 b=FoFxwD5+CTofpqGw6JnLJJTCqC2+OBmMKrN+jSL9HJBtSSHFQdnEusjfnDjfJMIl25
 irsG30rgB7vpJd7o1plNegpS9VQF2yTCg92xg/ZXivWTV0NnW2lrBaljjrMpvHKCqHse
 kEwwkSY/2NZgz9gcC1KIPHqjqdqVfXL+LIaBHquN/3Ci2p/bAkRlPuWVcBgeBNR3a5Sd
 goYVaY8gBV3rUMd4KlAV0qwaMxdrMt3EI2oTandWmDqy0W7ceBbcoFQo1XvYu8SPdUzO
 CiiN2ZGFsaTVfsAi/jMbykxoAfRk4/EG+vQ/il5aG7OIXCyiowN6ABD2nFyB/2aVFtDc
 t1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OLx5P/M3pqDyZohIbG83RbVvO9ARqfNNjPvtClMdPhQ=;
 fh=sFYMio8LqRQV9YnnwXunP9DFVHGjzsuO09vzDnhjtng=;
 b=jwmOaBWcOCZ3AmnwlK3KWJiCJEU/gXx4y1bRdykqDwS8pT0WzDd4Csg7DGBAL0qRts
 VnMFxL/+/kRRbeMu+6UnKYIblhOaV8sA1NpDszPFX1kozel2jlH8a0B3r3dydMIpTPZw
 e3CKdNs4D+42WwaccImGJHs4psPUmfOsjXdGbjc+//t93Nj+901htGDBWhDLbYaaaoHA
 u4khU7rYIYIVi3D5e4vrS583pTjFniim4iTCe1nMX2VAl+4pzanUa0G2G5ZUcUjcdfXc
 wyMKTABUiieGY1l/aBccyeU9m65nOW1hi/btL1LpVMYIxPzMnM5jxbg8cDaP2zn+7G6r
 w5tA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1791965937; x=1792570737; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OLx5P/M3pqDyZohIbG83RbVvO9ARqfNNjPvtClMdPhQ=;
 b=CEl7NH2FdmQAiJDakb2T5tjXtrmO2Rhstbh1ORnzpfjUKIKUHsRlRh7WqLTDOMrPq9
 lk9dycIgVZJ7116TBxMnDCOAKu2s509ObVHf6uAJ+YzRxEF4DNHjJlzgdXNaWdL946Dv
 A17OzQ+548dIzCzCeFc1Hx2IINwtBMOyFzWyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791965937; x=1792570737;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OLx5P/M3pqDyZohIbG83RbVvO9ARqfNNjPvtClMdPhQ=;
 b=T84sPyv42C+n2CFaEBRpzNzzu2nrAc8wxvZz2/jVCrnFWx05vdp8GIR45NC8Sql3mM
 sjTNHJmx5XNISPm+cO4vwba2y98UfZKMpZBtaLgzcKkjazNz98Y8QktZOf72p4zRFrLU
 ujDHMPtRFKQt5q6oUWVZgQgvRFA6X0nL2yT7BFfJQNNiomfVDMynJpFF4i3tz1D2Ch1k
 5Tl7HWJDZwnCqAUOdQbrnoLO8jeFw/D3aiqGbNUA+3w16cWoKDBDZhLFlNa1bA2Melcg
 RNAVdeQhqDC2zg1kuPnnG211dc9RGKUnUHdGfnSP6CEdAjQqMrMp/tcmb8sH5NrGH7JS
 3XtA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz05WMjZohVxrA+xFF1270qK9FtCL3WGf1rMunnk58IrA+AagEW0EkjOYtYYNtfvVlI0o1ZzKR5U6fn@nongnu.org
X-Gm-Message-State: AFq9FYI8jhXB9hOmLBYJ7RFsJwfyazawgIiHTHOkxm8phcsNT1pAB+KG
 5D0mhvd+o+/2WxE4ec8LPkmfyJSrGvyr6mk3huC8V333N5CoCRmLLqweQ5YjEkcSXkLwETBxK3J
 MLMI2qZbGE+h84lGTOVTsFt3viUXzPTKHzIKTJ552CQ==
X-Gm-Gg: AYBFou2JimN9cx2bQ894uh+HUOHgijFQl6+39NYybuF91w8vwYL822It1XQvkFgQ/8T
 cTmAYdlqT3UcPL2258m25Az9ZFPP7vecHBkG5PqVIq1gpkGVX0iNzu/mv1c1IzV9AuEBN1S9e3N
 TvBPEsCP3n/u/0DU+gdb57vDU8yO8W3RLxY9bOWPki8ZWZBms8FnBwgwtXF4xI/PtSKVYqf8H+6
 6rDGJZfHQui0c3+vjCNRQgCa/HRTBCExi2AVy35qvb8gv2mupXm0gri7Cbn2fecalEzN/H1M6NJ
 Q21Uot5+8SGb+3hdIU03fxHdAOJm3ebXk/kvcakH6NdPE6Lk6mwPEODHJjHVuVAWSU5LRNWG4K/
 Qg4gmNmAAosQN9sEnC9Fp2A==
X-Received: by 2002:a17:907:7246:b0:c20:53c7:488d with SMTP id
 a640c23a62f3a-c31a9ff4f3amr1393297266b.14.1791965936146; Wed, 14 Oct 2026
 01:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260921190345.1709227-1-alex.bennee@linaro.org>
 <asZIy2Rm8QF4TSca@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAJqdLrqxJF4tgfRYrm27rGivP-HyLUX=YCNUiaFqq4nDq0a5pQ@mail.gmail.com>
 <as6RsuZP6jkZ8twC@zhexu-thinkpadt14gen5.rmtcaon.csb>
In-Reply-To: <as6RsuZP6jkZ8twC@zhexu-thinkpadt14gen5.rmtcaon.csb>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 14 Oct 2026 10:18:45 +0200
X-Gm-Features: AclHuK88tm2JRtAuutXFE3QwbJL27TS09ikQOHowy7Lwi2VLxkfnZlcw-G-TBDA
Message-ID: <CAJqdLrpQLJtXptSURtnT4xo4LJTduhksqAKnoPHCHbbfdVhW0w@mail.gmail.com>
Subject: Re: [RFC PATCH] tests/functional: add migration diagnostics and pace
 nvme activity (HACK!)
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 "open list:nvme" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Am Di., 13. Okt. 2026 um 22:16 Uhr schrieb Peter Xu <peterx@redhat.com>:
>
> On Fri, Oct 09, 2026 at 07:52:29PM +0200, Alexander Mikhalitsyn wrote:
> > Am Mi., 7. Okt. 2026 um 15:27 Uhr schrieb Peter Xu <peterx@redhat.com>:
> > >
> > > On Mon, Sep 21, 2026 at 08:03:45PM +0100, Alex Benn=C3=A9e wrote:
> > > > This is a hacky patch for comment but I've included the diagnostic
> > > > hacks to the migration test as well as my workaround to get itworki=
ng.
> > > >
> > > > This test was failing on my KVM system. On investigation I found th=
e
> > > > nVME activity meant the migration never completed. I ended up
> > > > inserting some sleeps into the workload script until I was able to
> > > > get it to run.
> > >
> > > Indeed, I can reproduce it too:
> >
> > Hi Peter,
>
> Hi, Alexander,

Hi Peter,

>
> Thanks for loooking into this, and sorry for a late update.  Before sayin=
g
> this is a right fix, I have some questions inline.

No problem at all! ;-)

>
> >
> > thank you checking on your system and sharing a stacktrace.
> > Unfortunately, I wasn't able to reproduce this failure on my system,
> > but I think I have a good theory what's going on there. I think it is
> > because we use `snapshot=3Don` for a disk device and at the same time
> > keep important stuff like `/tmp/test_nvme_mig_workload.pid` on a root
> > filesystem. Easy fix is to use tmpfs for /tmp, so all data is actually
> > migrated.
> >
> > Please, can you try the following patch and let me know if this fixes
> > the issue or not:
> >
> > --- a/tests/functional/x86_64/test_nvme_migration.py
> > +++ b/tests/functional/x86_64/test_nvme_migration.py
> > @@ -75,6 +75,11 @@ def configure_machine(self, vm):
> >      def launch_source_vm(self, vm):
> >          vm.launch()
> >
> > +        vm.cmd('migrate-set-parameters', **{
> > +            'downtime-limit': 2000000,
>
> One thing to mention is downtime-limit is in milliseconds, this is 2000se=
c,
> so I would expect whatever guest runs, this converges in the 1st second..

yeah, probably I've got a bit too far with this parameter :-)

>
> > +            'max-bandwidth': 10 * 1024**3,
>
> Yes we want some sane bandwidth maybe, indeed, default is normally too
> small.

My experiments show, that with these parameters test passes like in 20
seconds, while
without it takes ~35 seconds.

Actually, this change is not a fix. It's a tweak I should make
initially when adding a test.

>
> > +        })
> > +
> >          self.wait_for_console_pattern('Entering emergency mode.', vm)
> >          prompt =3D '# '
> >          self.wait_for_console_pattern(prompt, vm)
> > @@ -94,6 +99,8 @@ def launch_source_vm(self, vm):
> >                                            prompt, vm=3Dvm)
> >          exec_command_and_wait_for_pattern(self, 'mount -t sysfs sysfs =
/sys',
> >                                            prompt, vm=3Dvm)
> > +        exec_command_and_wait_for_pattern(self, 'mount -t tmpfs tmpfs =
/tmp',
> > +                                          prompt, vm=3Dvm)
>
> Why this is needed?  I was expecting /tmp normally is already mounted wit=
h
> tmpfs, no?

Unfortunately, not. Cause first of all, we boot in a rescue mode
*from* initrd (not from the disk!) and then we:

        exec_command_and_wait_for_pattern(self, 'mount /dev/nvme0n1p1
/sysroot', // << manually mount root disk with the system
                                          prompt, vm=3Dvm)
        exec_command_and_wait_for_pattern(self, 'chroot /sysroot',
                        // << chroot, so there is no mounts other than
"/" in "/" subtree
                                          prompt, vm=3Dvm)
        exec_command_and_wait_for_pattern(self, 'mount -t proc proc /proc',
                                          prompt, vm=3Dvm)
        exec_command_and_wait_for_pattern(self, 'mount -t sysfs sysfs /sys'=
,
                                          prompt, vm=3Dvm)
        exec_command_and_wait_for_pattern(self, 'mount -t tmpfs tmpfs /tmp'=
,
                                          prompt, vm=3Dvm)

>
> One thing that might be relevant is the use of snapshot=3Don on the drive=
s,
> which means, IIUC, there's a top layer qcow2 overlay on the image file
> specified.

yes, this is what I've mentioned earlier. My theory is the following:
- we run some workload inside the VM to produce some I/O. We put PID of it
  in `/tmp/test_nvme_mig_workload.pid`
- later we expect to see PID in that file to kill it. And here we fail
(in accordance with your stacktrace)

My explanation is that it's because `/tmp` leaves on NVMe device,
which is backed by the drive with
`snapshot=3Don` which means that after migration all the changes
*written* to the disk disappear.

In this test we don't really care about anything written to the disk,
cause our test is R/O and it's job is
to make NVMe device I/O path busy with requests.

>
> Now thinking about it, if snapshot=3Don implies an anon invisible overlay=
, it
> should not support migration at all?  It means, this QEMU instance contai=
ns
> some anonymous qcow2 overlay that can never (am I right?) be migrated,
> since it's neither part of device state, nor guest memory (unlike /tmp
> mount in guest).

yes, I think so.

>
> So I feel like there's still something is off, e.g. I wonder if we should=
:
>
> - add a migration blocker for snapshot=3Don whenever used.. because I can=
't
>   see how it can work at all...

yeah, initially when I was writing this test I was heavily inspired by
`test_virtio_balloon.py` (`snapshot=3Don` is used there too),
so this was basically an accidental choice. I made sure that test
works just fine, creates I/O stress and forget. But now
we see that there is a bit of a problem.

>
> - for this test, should we remove snapshot=3Don but instead create an
>   explicit overlay that will be used on both src/dst qemu?

This should solve the issue too, at the same time if test is R/O I'm
not sure if we really need this.
But I'm happy to pick any way you suggest ;-)

Kind regards,
Alex

>
> Thanks,
>
> >
> >          # Run workload before migration to check if it continues
> >          # to run properly after migration.
> >
> > Kind regards,
> > Alex
> >
> > >
> > > $ ./run ../tests/functional/x86_64/test_nvme_migration.py X8664NVMeMi=
grationTest.test_migration_with_unix
> > > TAP version 13
> > > Traceback (most recent call last):
> > >   File "/home/zhexu/git/qemu/tests/functional/x86_64/test_nvme_migrat=
ion.py", line 162, in test_migration_with_unix
> > >     self.migration_with_unix()
> > >     ~~~~~~~~~~~~~~~~~~~~~~~~^^
> > >   File "/home/zhexu/git/qemu/tests/functional/migration.py", line 98,=
 in migration_with_unix
> > >     self.migrate(dst_uri)
> > >     ~~~~~~~~~~~~^^^^^^^^^
> > >   File "/home/zhexu/git/qemu/tests/functional/migration.py", line 78,=
 in migrate
> > >     self.migrate_vms(dst_uri, src_uri, dst_vm, src_vm)
> > >     ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >   File "/home/zhexu/git/qemu/tests/functional/migration.py", line 63,=
 in migrate_vms
> > >     self.assert_dest_vm(dst_vm)
> > >     ~~~~~~~~~~~~~~~~~~~^^^^^^^^
> > >   File "/home/zhexu/git/qemu/tests/functional/x86_64/test_nvme_migrat=
ion.py", line 128, in assert_dest_vm
> > >     self.exec_command_and_check(
> > >     ~~~~~~~~~~~~~~~~~~~~~~~~~~~^
> > >         "kill -0 $(cat /tmp/test_nvme_mig_workload.pid)", vm)
> > >         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >   File "/home/zhexu/git/qemu/tests/functional/x86_64/test_nvme_migrat=
ion.py", line 48, in exec_command_and_check
> > >     wait_for_console_pattern(self, 'OK', failure_message=3D"FAIL", vm=
=3Dvm)
> > >     ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^
> > >   File "/home/zhexu/git/qemu/tests/functional/qemu_test/cmd.py", line=
 191, in wait_for_console_pattern
> > >     return _console_interaction(test, success_message, failure_messag=
e,
> > >                                 None, vm=3Dvm)
> > >   File "/home/zhexu/git/qemu/tests/functional/qemu_test/cmd.py", line=
 134, in _console_interaction
> > >     done, line =3D _console_read_line_until_match(test, vm,
> > >                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
> > >                                                 success_message_b,
> > >                                                 ^^^^^^^^^^^^^^^^^^
> > >                                                 failure_message_b)
> > >                                                 ^^^^^^^^^^^^^^^^^^
> > >   File "/home/zhexu/git/qemu/tests/functional/qemu_test/cmd.py", line=
 70, in _console_read_line_until_match
> > >     test.fail(
> > >     ~~~~~~~~~^
> > >         f"'{failure}' found in console, expected '{success}'")
> > >         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > AssertionError: 'b'FAIL'' found in console, expected 'b'OK''
> > >
> > > not ok 1 test_nvme_migration.X8664NVMeMigrationTest.test_migration_wi=
th_unix
> > > 1..1
> > >
> > > Copy the author too (Alexander).
> > >
> > > >
> > > > *NOTE*: obviously this can't be merged as is but I think we could
> > > > certainly do with more tracking in the test to see when things aren=
't
> > > > working with possibly the sleep as another patch.
> > > >
> > > > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > > > ---
> > > >  tests/functional/migration.py                 | 37 +++++++++++++++=
----
> > > >  .../functional/x86_64/test_nvme_migration.py  |  1 +
> > > >  2 files changed, 31 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/tests/functional/migration.py b/tests/functional/migra=
tion.py
> > > > index 8d2428efc24..e51a82c22f4 100644
> > > > --- a/tests/functional/migration.py
> > > > +++ b/tests/functional/migration.py
> > > > @@ -22,18 +22,41 @@ class MigrationTest(QemuSystemTest):
> > > >      timeout =3D 10
> > > >
> > > >      @staticmethod
> > > > -    def migration_finished(vm):
> > > > -        return vm.cmd('query-migrate')['status'] in ('completed', =
'failed')
> > > > +    def migration_finished(query):
> > > > +        return query['status'] in ('completed', 'failed')
> > > >
> > > > -    def assert_migration(self, src_vm, dst_vm):
> > > > +    def wait_for_vm(self, src_or_dst, vm):
> > > > +        "Track the state of one VM in the migration"
> > > > +        current_state =3D last_state =3D vm.cmd('query-migrate')
> > > >
> > > > -        end =3D time.monotonic() + self.timeout
> > > > -        while time.monotonic() < end and not self.migration_finish=
ed(src_vm):
> > > > -            time.sleep(0.1)
> > > > +        self.log.info(f"waiting for {src_or_dst} to complete")
> > > >
> > > >          end =3D time.monotonic() + self.timeout
> > > > -        while time.monotonic() < end and not self.migration_finish=
ed(dst_vm):
> > > > +        while time.monotonic() < end:
> > > > +            if self.migration_finished(current_state):
> > > > +                break
> > > > +            else:
> > > > +                last_remain =3D last_state['remaining']
> > > > +                current_remain =3D current_state['remaining']
> > > > +
> > > > +                if current_remain > last_remain:
> > > > +                    self.log.warning(f"slow migration {current_rem=
ain} > {last_remain}")
> > > > +
> > > >              time.sleep(0.1)
> > > > +            last_state =3D current_state
> > > > +            current_state =3D vm.cmd('query-migrate')
> > > > +
> > > > +
> > > > +    def assert_migration(self, src_vm, dst_vm):
> > > > +
> > > > +        self.wait_for_vm("src", src_vm)
> > > > +
> > > > +        # if we hit this we never completed...
> > > > +        self.assertEqual(src_vm.cmd('query-migrate')['status'], 'c=
ompleted')
> > > > +
> > > > +        self.wait_for_vm("dst", dst_vm)
> > > > +
> > > > +        self.log.info("checking everything is OK")
> > > >
> > > >          self.assertEqual(src_vm.cmd('query-migrate')['status'], 'c=
ompleted')
> > > >          self.assertEqual(dst_vm.cmd('query-migrate')['status'], 'c=
ompleted')
> > > > diff --git a/tests/functional/x86_64/test_nvme_migration.py b/tests=
/functional/x86_64/test_nvme_migration.py
> > > > index 890f0aab6d6..58596f63cd3 100755
> > > > --- a/tests/functional/x86_64/test_nvme_migration.py
> > > > +++ b/tests/functional/x86_64/test_nvme_migration.py
> > > > @@ -109,6 +109,7 @@ def launch_source_vm(self, vm):
> > > >                  rm -f /tmp/test_nvme_mig_workload.iter_finished; \
> > > >                  echo 3 > /proc/sys/vm/drop_caches; \
> > > >                  find /usr/bin -type f -exec cksum {} \\;; \
> > > > +                sleep 0.3; \
> > > >                  touch /tmp/test_nvme_mig_workload.iter_finished; \
> > > >              done) > /dev/null 2> /tmp/test_nvme_mig_workload.error=
s &",
> > > >              prompt, vm=3Dvm)
> > > > --
> > > > 2.47.3
> > > >
> > >
> > > --
> > > Peter Xu
> > >
> >
>
> --
> Peter Xu
>

