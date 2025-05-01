Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326CBC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 14:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAUtZ-0000Cp-T1; Thu, 01 May 2025 10:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAUtX-0000Ce-Qg
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:28:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAUtV-0006tV-5C
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746109687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RrNiRMaORMW1L2xdzJRhqBsOfJBaOKONV0yU5vF1IWc=;
 b=D92DkxRQ5yNsTsF6ZttuVzt4i6HZaMsA191T9MuiADy8v80xlHLVc8Zr9H1Eu+o/azOdIg
 Nctv1ry0aDx43I6HNKLb2YAwWuG3ok4PUIv7Cm3M6daRbuzQF0E8bwPKuGyOalqMxbAyID
 bnDtudHg4Emu//LDhDb3Ds1ObXaIxn4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-J4OK7GjZMIGhJGUBfUVqvQ-1; Thu, 01 May 2025 10:28:05 -0400
X-MC-Unique: J4OK7GjZMIGhJGUBfUVqvQ-1
X-Mimecast-MFC-AGG-ID: J4OK7GjZMIGhJGUBfUVqvQ_1746109685
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c9305d29abso168754485a.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 07:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746109685; x=1746714485;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RrNiRMaORMW1L2xdzJRhqBsOfJBaOKONV0yU5vF1IWc=;
 b=A6hgAYznL0Ew463+EJIPilLofZJYFSpBH8/RNcLTaRae+94cs2ane/DEnnOkzvcnl+
 IGPC8udG9op9/Aa9v9az/cxuiIAWL1o+d5pjenPF1/sEQwjs0zK3a7DvePORi8PVTZx6
 UpHoBkI2drcIGuYrED4dQJgNsZ0gEy0gWQD9qXFVWPUIa3iSe7WlLG6wAv5KEabTk854
 3ysYEz3BFhr35VzzIjskhz//8ECkCE/OL/1XIE92GxcHXSAzMLGS4+1msznBdP79SREj
 iHu9G75G29YQIYbyBOzNdr6VeXQFU94qo8famfDZPzw3dlbHDdY59ssDYQWy4uPUCZrc
 koaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUapjRPa2hA1hwHYvFroTzIMhCIQUnXyCtICmpYR3RsRmplLGYM5F8yzobh25geVXWfrSP+lFZSQoAU@nongnu.org
X-Gm-Message-State: AOJu0YwWR9pza/902Pwt61O/XhVWgBg04wSKehNbP5RjN+Y5YBmcYr0K
 OtCRD0PT5KU1l14xj7ZRDzpjBpWCUOFnKb7+KnN+dRiU9WnP8b4y4JYuoKQRdK96OviCUc1OriS
 UGCgyCLbMZD4j/AwHRrJVKqrxfRl/KdnsEritUtAl0mW/LrQloh2o
X-Gm-Gg: ASbGncsjnf5G+4meaF0ju0A9eUei6dM2lrBzqZsfZr7c51AydJO5bx8g4Yzo+ty6TO0
 yo+8vHq0oZZAU4LXJwXcgSU8r7udOaLO2+SAGLAoG7JiBabNjTgvLt2rsCKTXkdEEWGBBWyrTY1
 kFVXPYFSRxXMcOcEJdNhc2bHmi9S9oaFEJytJ31H7O1JIfjk5OyybVyjYY17cPPlWnu6AGDJBav
 4NdFLuwrwbwHiqhPncs6Hm3hzUekK0e1htHH3opvP/Q8CjqmfTNr0E0C3qNNWRKblQanhZzzgX+
 bwo=
X-Received: by 2002:a05:620a:459f:b0:7c7:ba67:38a with SMTP id
 af79cd13be357-7cac740f15amr1029691285a.6.1746109685124; 
 Thu, 01 May 2025 07:28:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEA9dmKlMlPIDTDRwC1QFZ5vyprYRd8xC6kzmXtYJyZQgh1jRF5i/2F8mSHahR7uj+1zXkXA==
X-Received: by 2002:a05:620a:459f:b0:7c7:ba67:38a with SMTP id
 af79cd13be357-7cac740f15amr1029688485a.6.1746109684738; 
 Thu, 01 May 2025 07:28:04 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cad23c48ffsm48548985a.45.2025.05.01.07.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 07:28:04 -0700 (PDT)
Date: Thu, 1 May 2025 10:28:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 4/4] tests/functional: Test with
 scripts/vmstate-static-checker.py
Message-ID: <aBOE8iwN0oIVfwTi@x1.local>
References: <20250429152141.294380-1-thuth@redhat.com>
 <20250429152141.294380-5-thuth@redhat.com>
 <d47d36db-f94c-45ee-bdf0-477607703461@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d47d36db-f94c-45ee-bdf0-477607703461@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Apr 30, 2025 at 09:10:30AM -0700, Pierrick Bouvier wrote:
> On 4/29/25 8:21 AM, Thomas Huth wrote:
> > From: Thomas Huth <thuth@redhat.com>
> > 
> > We've got this nice vmstate-static-checker.py script that can help
> > to detect screw-ups in the migration states. Unfortunately, it's
> > currently only run manually, so there could be regressions that nobody
> > notices immediately. Let's run it from a functional test automatically
> > so that we got at least a basic coverage in each CI run.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   MAINTAINERS                      |  1 +
> >   tests/functional/meson.build     | 13 +++++++-
> >   tests/functional/test_vmstate.py | 56 ++++++++++++++++++++++++++++++++
> >   3 files changed, 69 insertions(+), 1 deletion(-)
> >   create mode 100755 tests/functional/test_vmstate.py
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 65fb61844b3..6a8d81458ad 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3525,6 +3525,7 @@ F: migration/
> >   F: scripts/vmstate-static-checker.py
> >   F: tests/data/vmstate-static-checker/
> >   F: tests/functional/test_migration.py
> > +F: tests/functional/test_vmstate.py
> >   F: tests/qtest/migration/
> >   F: tests/qtest/migration-*
> >   F: docs/devel/migration/
> > diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> > index b317ad42c5a..9f339e626f6 100644
> > --- a/tests/functional/meson.build
> > +++ b/tests/functional/meson.build
> > @@ -76,6 +76,7 @@ tests_generic_bsduser = [
> >   tests_aarch64_system_quick = [
> >     'migration',
> > +  'vmstate',
> >   ]
> >   tests_aarch64_system_thorough = [
> > @@ -164,6 +165,10 @@ tests_loongarch64_system_thorough = [
> >     'loongarch64_virt',
> >   ]
> > +tests_m68k_system_quick = [
> > +  'vmstate',
> > +]
> > +
> >   tests_m68k_system_thorough = [
> >     'm68k_mcf5208evb',
> >     'm68k_nextcube',
> > @@ -230,6 +235,7 @@ tests_ppc_system_thorough = [
> >   tests_ppc64_system_quick = [
> >     'migration',
> > +  'vmstate',
> >   ]
> >   tests_ppc64_system_thorough = [
> > @@ -265,6 +271,10 @@ tests_rx_system_thorough = [
> >     'rx_gdbsim',
> >   ]
> > +tests_s390x_system_quick = [
> > +  'vmstate',
> > +]
> > +
> >   tests_s390x_system_thorough = [
> >     's390x_ccw_virtio',
> >     's390x_replay',
> > @@ -305,8 +315,9 @@ tests_x86_64_system_quick = [
> >     'migration',
> >     'pc_cpu_hotplug_props',
> >     'virtio_version',
> > -  'x86_cpu_model_versions',
> > +  'vmstate',
> >     'vnc',
> > +  'x86_cpu_model_versions',
> >   ]
> >   tests_x86_64_system_thorough = [
> > diff --git a/tests/functional/test_vmstate.py b/tests/functional/test_vmstate.py
> > new file mode 100755
> > index 00000000000..3ba56d580db
> > --- /dev/null
> > +++ b/tests/functional/test_vmstate.py
> > @@ -0,0 +1,56 @@
> > +#!/usr/bin/env python3
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +#
> > +# This test runs the vmstate-static-checker script with the current QEMU
> > +
> > +import subprocess
> > +
> > +from qemu_test import QemuSystemTest
> > +
> > +
> > +class VmStateTest(QemuSystemTest):
> > +
> > +    def test_vmstate(self):
> > +        target_machine = {
> > +            'aarch64': 'virt-7.2',
> > +            'm68k': 'virt-7.2',
> > +            'ppc64': 'pseries-7.2',
> > +            's390x': 's390-ccw-virtio-7.2',
> > +            'x86_64': 'pc-q35-7.2',
> > +        }
> > +        self.set_machine(target_machine[self.arch])
> > +
> > +        # Run QEMU to get the current vmstate json file:
> > +        dst_json = self.scratch_file('dest.json')
> > +        self.log.info('Dumping vmstate from ' + self.qemu_bin)
> > +        cp = subprocess.run([self.qemu_bin, '-nodefaults',
> > +                             '-M', target_machine[self.arch],
> > +                             '-dump-vmstate', dst_json],
> > +                            stdout=subprocess.PIPE,
> > +                            stderr=subprocess.STDOUT,
> > +                            text=True)
> > +        if cp.returncode != 0:
> > +            self.fail('Running QEMU failed:\n' + cp.stdout)
> > +        if cp.stdout:
> > +            self.log.info('QEMU output: ' + cp.stdout)
> > +
> > +        # Check whether the old vmstate json file is still compatible:
> > +        src_json = self.data_file('..', 'data', 'vmstate-static-checker',
> > +                                  self.arch,
> > +                                  target_machine[self.arch] + '.json')
> > +        vmstate_checker = self.data_file('..', '..', 'scripts',
> > +                                         'vmstate-static-checker.py')
> > +        self.log.info('Comparing vmstate with ' + src_json)
> > +        cp = subprocess.run([vmstate_checker, '-s', src_json, '-d', dst_json],
> > +                            stdout=subprocess.PIPE,
> > +                            stderr=subprocess.STDOUT,
> > +                            text=True)
> > +        if cp.returncode != 0:
> > +            self.fail('Running vmstate-static-checker failed:\n' + cp.stdout)
> > +        if cp.stdout:
> > +            self.log.warning('vmstate-static-checker output: ' + cp.stdout)
> > +
> > +
> > +if __name__ == '__main__':
> > +    QemuSystemTest.main()
> 
> Thanks for this series Thomas, it's very useful.
> Could we extend this automatically to test migration on all combinations:
> {qemu-system-*} x {machine}?
> We could generate a single list of references, containing hashes of all
> outputs, and a simple and clean command to regenerate all those, and
> associated jsons, so we don't pollute qemu code with tons of json.

I think a major challenge would be false positives, and how to filter
them.. when we put anything into CI.

Side note: yesterday I just wrote a script to do exactly this, by auto
build binaries and check all relevant archs over all machine types
supported.  It looks like this:

https://gitlab.com/peterx/qemu/-/commit/c4abfa39f8943cd62f0d982ecb36537df398ae70

The plan is I can run this at the end of each release, though.. not yet for
CI.  I also don't have plan to upstream this script, maybe I'll keep it
myself as of now unless someone thinks we should have it.

PS: I just ran it over v9.2..v10.0 over the default 4 archs
(x86,arm,ppc,s390) and a huge list was generated..  I believe most of them
are false positives, I'll delay walking the list for some time..  I
attached the result at the end in case anyone is interested.

> 
> This way, we can automatically detect that we never regress, not only from
> release to release, but commit to commit.
> 
> In case we need to update reference, people can point what's the actual
> difference in the commit message.
> 
> As well, since I took a look into that before, this check is not enough
> regarding migration. Beyonds the VMDstate, we should check as well that the
> default values of every field are not changed. For instance, we recently
> changed the default pauth property of arm cpus, and without a careful
> backcompat, it would have break migration. It's a bit more tricky, since
> there is nothing available now to dump this (I hacked that using a custom
> trace). And definitely not something in the scope of your series, just worth
> mentioning.
> 
> I hope we can one day get rid of all "Is this change safe regarding
> migration?" comments because we know we can trust our CI instead.

IMHO it's extremely hard (if not impossible) to guarantee that, because
some migration bug may only trigger in special paths that not always
happen, e.g. it can even involve guest driver behavior.

Said that, Fabiano used to work on supporting device-specific tests in
qtests/migration-test.c.  I don't think it landed but maybe we have room
for specific device tests using qtests/migration-test.c framework.

https://lore.kernel.org/all/20240523201922.28007-1-farosas@suse.de/

Thanks,

-- 
Peter Xu


