Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07975CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xES1B-0006Gz-7Z; Wed, 07 Oct 2026 09:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1xERxE-0005eY-2c
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:45:21 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1xERxB-0003o3-R5
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:45:07 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c2acc1e170cso290035966b.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 06:45:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791380703; cv=none;
 d=google.com; s=arc-20260327;
 b=L1Z+u5vIcCLQhJumGFySl1VRy2OancOQ0bvz8tLJ3nsSossXShHmSy4Gc2EeF7Dg0c
 JyVirVRM0i3Ep6gJANBXi1SXvs3iTMvqKN/btqpYsOJNsRPyKuwIfPoZ1SVmramVkNDd
 bQs+mGbyrMXV0E953neple1z1O1Yoi/KfiMDKPxPEaSLHAGGnZ6/fpSYR4iDWHl3X82E
 lX1GB0Q4bkuo37BU4ag+slf/ebqscoXQ0iZOknH80Wd3Tdpnplxm4wPVYAc7SJSt1BuE
 u+hD3gqwOIC9J0JjhKhnO5VEPI7QfWLgksGjFX/gYqSh3zUT+HM+wr1cfZBx+LpH4Ph9
 o7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S8QEjrXeKu85zsL+RxfOzjkLkGKEc9MJdUwU0Y5QmUE=;
 fh=h4+hB1CRQelAzq5+3cgvsibVVlcz1iaWhF2tYEcxGf0=;
 b=luKYf7XQybi4pUzmqWlNrzXurYolJ4Savw1MOpuZGO2uEwE1z/mtZFBRh6NtjXX4fr
 y0M1t5LXIBI8S7fXan5iiuDMhBIw/jPRcTf7iwmEkGBcM6i8V7Difj1jp94SdoABHo1L
 HVzFmA558sOqbmtHfiMHEFDlX6Vu8hAfdfF3QkLzaeaulVbHQCwyFrClT6UWRApkO2Yo
 HD9gtwZWJ09kM4eEqjFqHgAz2qzwST8MeVnBeBzMEs/+PgKTy1E2evqpR61avx371e9a
 cZKj1ovtTqjUNNqJKn7KVBeUw8U0qunsBojXYmFxDqcEXI9HVZWbvjwwYAI0O/TIMYaX
 YfMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1791380703; x=1791985503; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S8QEjrXeKu85zsL+RxfOzjkLkGKEc9MJdUwU0Y5QmUE=;
 b=Uc/sViqWx1bMRtfl1C0Z4cIDeR/ipRuhethN3oj8zlc2aPzRTmJTs8Bf5E3DkXi8ld
 UHaM0EwiV2VhAK0iGFJ7cilSnys0PqWD8+WVBvCGiLa/0fEXepX/ctdmRqabUqTva/9R
 MuFfmixE8MeIbkH72YtEjQIDYTVFnCslBfY2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791380703; x=1791985503;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S8QEjrXeKu85zsL+RxfOzjkLkGKEc9MJdUwU0Y5QmUE=;
 b=bnyKFuCOFcOSLacB1FuMYQO6UDgS1AZM55J+6SzgblAulcOuSaGAVpWZTiIv1GArq9
 elZ8IM+tqyrIBUhqHnsJLd9upyfU7Kf+3TM///PINKi2c6XVbTxbGEWek4luPqeEan/f
 W+WpibYgbGlXz7gQYwG2sd+tbTiy5qSHHtHnnP0bcJAjwbzlaISnPNkU/3/vSm/dMv8R
 1fP9hsnoHW1S8bkNizKIGSzO/YRKztulBQBdT22IxFe1O3dutjbue+ie5zaA9MDiuU91
 k8lHbRPyVCm7MQ3Ik6dq2DJEwRZ0cb95r7uH27eoVDazsQcQJPfhab0qQ2koXz1/MLPy
 rtoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByuxz99U4MBXpDJNQZadYl1k7WxKqbTWkxfvTuVyOg3yGVmJCl4jqCaFl1d8rv357hgfquvNSS3Rri9@nongnu.org
X-Gm-Message-State: AFuF++lBcexwf1evYvtC/w+jHkYayGhzgMrn2riKROd09bBSj1A7fxsh
 XDJ+pdkPt0YQwC+icsijoNjLNX2AHtQKYHDwsbYcZgxUHf73A2SaPQ5P2pnbGJ4PsaJa3518eb7
 lmYCSuObIiWzRo3nLSaHcGdDfiCkQy8lzUAGLhPAaug==
X-Gm-Gg: AYBFou2kJLDGnsKhMaEivqUEoPG7axeNCh3wbo/GVKrviUYJ/5Ni+QHhLjLsioZh+xE
 Twl3AjJH70nGDny9KKzR85/BKal/pAlm8bTobzW9j6uWTRAACf8/MsKM3WZHM1M8QxY8cw9gpo9
 L+8SliySEBnSQ5yq6i4BWPzgHqnMQeb88aGH2jAuxYI59k2ePEB8J4eUvPM/DTa6uw52gGBnBp8
 0pGYUJsBPYcmzK0mgqyr3UZYaXdJEplfPa4TACTtzIEsETzMun/HvLzFk5jKXKobwKLyeL5DVqw
 8BF3NpHuUQk1bU0BR27zKulr0Ofdrp+wLWcv74dHTOfbFdqXLSNH3A==
X-Received: by 2002:a17:907:2d07:b0:c2e:7fe7:288e with SMTP id
 a640c23a62f3a-c317c0d8e13mr223656966b.32.1791380702767; Wed, 07 Oct 2026
 06:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260921190345.1709227-1-alex.bennee@linaro.org>
 <asZIy2Rm8QF4TSca@zhexu-thinkpadt14gen5.rmtcaon.csb>
In-Reply-To: <asZIy2Rm8QF4TSca@zhexu-thinkpadt14gen5.rmtcaon.csb>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 7 Oct 2026 15:44:50 +0200
X-Gm-Features: AclHuK89j-63j6M7kk340-48Vn1AdkFrQFw2gKtVjkxqKMVmHCKhgYkJ6TeuSKg
Message-ID: <CAJqdLro71eWZzUfia69GVGy8gFUqXH3Jo2N+Fmq+nW3p-5GiRg@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x62f.google.com
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

Am Mi., 7. Okt. 2026 um 15:27 Uhr schrieb Peter Xu <peterx@redhat.com>:
>
> On Mon, Sep 21, 2026 at 08:03:45PM +0100, Alex Benn=C3=A9e wrote:
> > This is a hacky patch for comment but I've included the diagnostic
> > hacks to the migration test as well as my workaround to get itworking.
> >
> > This test was failing on my KVM system. On investigation I found the
> > nVME activity meant the migration never completed. I ended up
> > inserting some sleeps into the workload script until I was able to
> > get it to run.
>
> Indeed, I can reproduce it too:
>
> $ ./run ../tests/functional/x86_64/test_nvme_migration.py X8664NVMeMigrat=
ionTest.test_migration_with_unix
> TAP version 13
> Traceback (most recent call last):
>   File "/home/zhexu/git/qemu/tests/functional/x86_64/test_nvme_migration.=
py", line 162, in test_migration_with_unix
>     self.migration_with_unix()
>     ~~~~~~~~~~~~~~~~~~~~~~~~^^
>   File "/home/zhexu/git/qemu/tests/functional/migration.py", line 98, in =
migration_with_unix
>     self.migrate(dst_uri)
>     ~~~~~~~~~~~~^^^^^^^^^
>   File "/home/zhexu/git/qemu/tests/functional/migration.py", line 78, in =
migrate
>     self.migrate_vms(dst_uri, src_uri, dst_vm, src_vm)
>     ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/home/zhexu/git/qemu/tests/functional/migration.py", line 63, in =
migrate_vms
>     self.assert_dest_vm(dst_vm)
>     ~~~~~~~~~~~~~~~~~~~^^^^^^^^
>   File "/home/zhexu/git/qemu/tests/functional/x86_64/test_nvme_migration.=
py", line 128, in assert_dest_vm
>     self.exec_command_and_check(
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~^
>         "kill -0 $(cat /tmp/test_nvme_mig_workload.pid)", vm)
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/home/zhexu/git/qemu/tests/functional/x86_64/test_nvme_migration.=
py", line 48, in exec_command_and_check
>     wait_for_console_pattern(self, 'OK', failure_message=3D"FAIL", vm=3Dv=
m)
>     ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/home/zhexu/git/qemu/tests/functional/qemu_test/cmd.py", line 191=
, in wait_for_console_pattern
>     return _console_interaction(test, success_message, failure_message,
>                                 None, vm=3Dvm)
>   File "/home/zhexu/git/qemu/tests/functional/qemu_test/cmd.py", line 134=
, in _console_interaction
>     done, line =3D _console_read_line_until_match(test, vm,
>                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
>                                                 success_message_b,
>                                                 ^^^^^^^^^^^^^^^^^^
>                                                 failure_message_b)
>                                                 ^^^^^^^^^^^^^^^^^^
>   File "/home/zhexu/git/qemu/tests/functional/qemu_test/cmd.py", line 70,=
 in _console_read_line_until_match
>     test.fail(
>     ~~~~~~~~~^
>         f"'{failure}' found in console, expected '{success}'")
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> AssertionError: 'b'FAIL'' found in console, expected 'b'OK''
>
> not ok 1 test_nvme_migration.X8664NVMeMigrationTest.test_migration_with_u=
nix
> 1..1

Dear friends,

>
> Copy the author too (Alexander).

thanks for letting me know. This is definitely something I *must* look
into and fix then.
Probably I messed up with synchronization in this test... :-)

I'll take a closer look after get back from the Linux Plumbers (by any
chance, if somebody
at LPC too it would be great to say hi to each other in person :-) )

Kind regards,
Alex

>
> >
> > *NOTE*: obviously this can't be merged as is but I think we could
> > certainly do with more tracking in the test to see when things aren't
> > working with possibly the sleep as another patch.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > ---
> >  tests/functional/migration.py                 | 37 +++++++++++++++----
> >  .../functional/x86_64/test_nvme_migration.py  |  1 +
> >  2 files changed, 31 insertions(+), 7 deletions(-)
> >
> > diff --git a/tests/functional/migration.py b/tests/functional/migration=
.py
> > index 8d2428efc24..e51a82c22f4 100644
> > --- a/tests/functional/migration.py
> > +++ b/tests/functional/migration.py
> > @@ -22,18 +22,41 @@ class MigrationTest(QemuSystemTest):
> >      timeout =3D 10
> >
> >      @staticmethod
> > -    def migration_finished(vm):
> > -        return vm.cmd('query-migrate')['status'] in ('completed', 'fai=
led')
> > +    def migration_finished(query):
> > +        return query['status'] in ('completed', 'failed')
> >
> > -    def assert_migration(self, src_vm, dst_vm):
> > +    def wait_for_vm(self, src_or_dst, vm):
> > +        "Track the state of one VM in the migration"
> > +        current_state =3D last_state =3D vm.cmd('query-migrate')
> >
> > -        end =3D time.monotonic() + self.timeout
> > -        while time.monotonic() < end and not self.migration_finished(s=
rc_vm):
> > -            time.sleep(0.1)
> > +        self.log.info(f"waiting for {src_or_dst} to complete")
> >
> >          end =3D time.monotonic() + self.timeout
> > -        while time.monotonic() < end and not self.migration_finished(d=
st_vm):
> > +        while time.monotonic() < end:
> > +            if self.migration_finished(current_state):
> > +                break
> > +            else:
> > +                last_remain =3D last_state['remaining']
> > +                current_remain =3D current_state['remaining']
> > +
> > +                if current_remain > last_remain:
> > +                    self.log.warning(f"slow migration {current_remain}=
 > {last_remain}")
> > +
> >              time.sleep(0.1)
> > +            last_state =3D current_state
> > +            current_state =3D vm.cmd('query-migrate')
> > +
> > +
> > +    def assert_migration(self, src_vm, dst_vm):
> > +
> > +        self.wait_for_vm("src", src_vm)
> > +
> > +        # if we hit this we never completed...
> > +        self.assertEqual(src_vm.cmd('query-migrate')['status'], 'compl=
eted')
> > +
> > +        self.wait_for_vm("dst", dst_vm)
> > +
> > +        self.log.info("checking everything is OK")
> >
> >          self.assertEqual(src_vm.cmd('query-migrate')['status'], 'compl=
eted')
> >          self.assertEqual(dst_vm.cmd('query-migrate')['status'], 'compl=
eted')
> > diff --git a/tests/functional/x86_64/test_nvme_migration.py b/tests/fun=
ctional/x86_64/test_nvme_migration.py
> > index 890f0aab6d6..58596f63cd3 100755
> > --- a/tests/functional/x86_64/test_nvme_migration.py
> > +++ b/tests/functional/x86_64/test_nvme_migration.py
> > @@ -109,6 +109,7 @@ def launch_source_vm(self, vm):
> >                  rm -f /tmp/test_nvme_mig_workload.iter_finished; \
> >                  echo 3 > /proc/sys/vm/drop_caches; \
> >                  find /usr/bin -type f -exec cksum {} \\;; \
> > +                sleep 0.3; \
> >                  touch /tmp/test_nvme_mig_workload.iter_finished; \
> >              done) > /dev/null 2> /tmp/test_nvme_mig_workload.errors &"=
,
> >              prompt, vm=3Dvm)
> > --
> > 2.47.3
> >
>
> --
> Peter Xu
>

