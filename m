Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318EAD7830F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 12:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI56k-0006mZ-7b; Mon, 02 Dec 2024 07:00:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI56e-0006ih-2Q
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 07:00:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI56Z-0003xm-TW
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 07:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733140841;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KtmcQqnXfD/xz3f5KqVk3d2Vkbikpx/CUv8HVIk1GW8=;
 b=daYnucsvRc+8shawZhmjXxvaTjkrOakTdC3C2WIl85Q4z61anf1gVTwfaRWbzA/0o6zJ2r
 dvWLaU6oefcA8JHmHBCdZGLmPkotIlSo4AFdJGcKOHQ5DgxY4l84/gUr32KIb2gTAo9yG3
 MpV3tCaXjMyfIZBboPeKPTZAC8UBuFE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-Hez5tZeWOxi4UYH5-ERtSQ-1; Mon,
 02 Dec 2024 07:00:39 -0500
X-MC-Unique: Hez5tZeWOxi4UYH5-ERtSQ-1
X-Mimecast-MFC-AGG-ID: Hez5tZeWOxi4UYH5-ERtSQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 935541964CD1; Mon,  2 Dec 2024 12:00:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.143])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06A531955EA7; Mon,  2 Dec 2024 12:00:35 +0000 (UTC)
Date: Mon, 2 Dec 2024 12:00:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 10/22] tests/functional: switch over to using
 self.build_file(...)
Message-ID: <Z02hYLmpdNoenJkr@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-11-berrange@redhat.com>
 <a3e41776-4253-4c1d-b3bf-37d4702a871a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3e41776-4253-4c1d-b3bf-37d4702a871a@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Dec 02, 2024 at 10:26:59AM +0100, Thomas Huth wrote:
> On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> > This removes direct access of the 'BUILD_DIR' variable.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/functional/qemu_test/testcase.py | 4 ++--
> >   tests/functional/test_aarch64_virt.py  | 6 +++---
> >   tests/functional/test_virtio_gpu.py    | 9 ++++-----
> >   3 files changed, 9 insertions(+), 10 deletions(-)
> > 
> > diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> > index 5b1e6ba04f..2f32742387 100644
> > --- a/tests/functional/qemu_test/testcase.py
> > +++ b/tests/functional/qemu_test/testcase.py
> > @@ -127,8 +127,8 @@ def setUp(self, bin_prefix):
> >           self.arch = self.qemu_bin.split('-')[-1]
> >           self.socketdir = None
> > -        self.outputdir = os.path.join(BUILD_DIR, 'tests', 'functional',
> > -                                      self.arch, self.id())
> > +        self.outputdir = self.build_file('tests', 'functional',
> > +                                         self.arch, self.id())
> >           self.workdir = os.path.join(self.outputdir, 'scratch')
> >           os.makedirs(self.workdir, exist_ok=True)
> > diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
> > index 07b78f6a84..29eeb8e32d 100755
> > --- a/tests/functional/test_aarch64_virt.py
> > +++ b/tests/functional/test_aarch64_virt.py
> > @@ -14,7 +14,7 @@
> >   import os
> >   import logging
> > -from qemu_test import (BUILD_DIR, QemuSystemTest, Asset, exec_command,
> > +from qemu_test import (QemuSystemTest, Asset, exec_command,
> >                          wait_for_console_pattern, get_qemu_img, run_cmd)
> > @@ -52,8 +52,8 @@ def test_alpine_virt_tcg_gic_max(self):
> >                            "mte=on,"
> >                            "gic-version=max,iommu=smmuv3")
> >           self.vm.add_args("-smp", "2", "-m", "1024")
> > -        self.vm.add_args('-bios', os.path.join(BUILD_DIR, 'pc-bios',
> > -                                               'edk2-aarch64-code.fd'))
> > +        self.vm.add_args('-bios', self.build_file('pc-bios',
> > +                                                  'edk2-aarch64-code.fd'))
> >           self.vm.add_args("-drive", f"file={iso_path},media=cdrom,format=raw")
> >           self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0')
> >           self.vm.add_args('-object', 'rng-random,id=rng0,filename=/dev/urandom')
> > diff --git a/tests/functional/test_virtio_gpu.py b/tests/functional/test_virtio_gpu.py
> > index c4562618d9..39dcf376dd 100755
> > --- a/tests/functional/test_virtio_gpu.py
> > +++ b/tests/functional/test_virtio_gpu.py
> > @@ -6,8 +6,7 @@
> >   # later.  See the COPYING file in the top-level directory.
> > -from qemu_test import (BUILD_DIR, QemuSystemTest, Asset,
> > -                       wait_for_console_pattern,
> > +from qemu_test import (QemuSystemTest, Asset, wait_for_console_pattern,
> >                          exec_command_and_wait_for_pattern,
> >                          is_readable_executable_file)
> >   from qemu.utils import kvm_available
> > @@ -17,12 +16,12 @@
> >   import subprocess
> > -def pick_default_vug_bin():
> > +def pick_default_vug_bin(test):
> >       relative_path = "./contrib/vhost-user-gpu/vhost-user-gpu"
> >       if is_readable_executable_file(relative_path):
> >           return relative_path
> 
> I wonder whether we should drop the above two lines of special casing and
> always use the code below instead?
> 
> > -    bld_dir_path = os.path.join(BUILD_DIR, relative_path)
> > +    bld_dir_path = test.build_file(relative_path)
> 
> ... then you could also get rid of the hard-coded slashes in relative_path?

Hmmm, yes, the first check is rather redundant, will cull it.

> 
> >       if is_readable_executable_file(bld_dir_path):
> >           return bld_dir_path
> > @@ -85,7 +84,7 @@ def test_vhost_user_vga_virgl(self):
> >           # FIXME: should check presence of vhost-user-gpu, virgl, memfd etc
> >           self.require_accelerator('kvm')
> > -        vug = pick_default_vug_bin()
> > +        vug = pick_default_vug_bin(self)
> >           if not vug:
> >               self.skipTest("Could not find vhost-user-gpu")
> 
> Anyway:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


