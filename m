Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5484DD7830F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 12:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI5A5-0007dY-BJ; Mon, 02 Dec 2024 07:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI59j-0007by-0q
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 07:04:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI59R-0004tR-Cy
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 07:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733141019;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gFDNTItaEnqXT9FN7hhRwZRXDcAmHOyms/sOo8zvA9U=;
 b=dtDRlsrJIhQ08iY+12hpYbVTeT+EHWmNbHceEiwIXa+4LLIaP42Ti66PP9YkkKRymjRTzw
 NJc3+RobrvhcBpBxzrdFIMtHLSq364rGci/zLGUwtpP21YuRRhp/bNVvnaDHZd93Z0lvmp
 yLUC0Rjd6u4/RzV1hbmnU8dUuILINyc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-4V9XZHFEMbSGNhkUSEroxA-1; Mon,
 02 Dec 2024 07:03:36 -0500
X-MC-Unique: 4V9XZHFEMbSGNhkUSEroxA-1
X-Mimecast-MFC-AGG-ID: 4V9XZHFEMbSGNhkUSEroxA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5B021955DE0; Mon,  2 Dec 2024 12:03:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.143])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B2B91956089; Mon,  2 Dec 2024 12:03:33 +0000 (UTC)
Date: Mon, 2 Dec 2024 12:03:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 12/22] tests/functional: switch over to using
 self.scratch_file()
Message-ID: <Z02iEnx_abqr6PL_@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-13-berrange@redhat.com>
 <575eb674-7b07-40c0-a537-da34549edcd2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <575eb674-7b07-40c0-a537-da34549edcd2@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Dec 02, 2024 at 10:56:32AM +0100, Thomas Huth wrote:
> On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> > Replace any instances of
> > 
> >    os.path.join(self.workdir, ".../...")
> >    self.workdir + "/.../..."
> > 
> > with
> > 
> >    self.scratch_file("...", "...")
> > 
> > which is more compact and portable
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> ...
> > diff --git a/tests/functional/qemu_test/linuxkernel.py b/tests/functional/qemu_test/linuxkernel.py
> > index 2b5b9a5fda..a6525f9dd6 100644
> > --- a/tests/functional/qemu_test/linuxkernel.py
> > +++ b/tests/functional/qemu_test/linuxkernel.py
> > @@ -46,8 +46,7 @@ def extract_from_deb(self, deb_path, path):
> >           os.chdir(cwd)
> >           # Return complete path to extracted file.  Because callers to
> >           # extract_from_deb() specify 'path' with a leading slash, it is
> > -        # necessary to use os.path.relpath() as otherwise os.path.join()
> > -        # interprets it as an absolute path and drops the self.workdir part.
> > -        return os.path.normpath(os.path.join(self.workdir,
> > -                                             os.path.relpath(path, '/')))
> > +        # necessary to use 'relative_to()' to turn it into a relative
> 
> Here you mention "relative_to()" ....

Opps, traces of an aborted switch to pathlib there.

> 
> > +        # path for joining to the scratch dir
> > +        return os.path.normpath(self.scratch_file(os.path.relpath(path, '/')))
> 
> ... but the code still uses relpath() instead?
> 
> > diff --git a/tests/functional/test_aarch64_aspeed.py b/tests/functional/test_aarch64_aspeed.py
> > index 59916efd71..c6c6b74acc 100644
> > --- a/tests/functional/test_aarch64_aspeed.py
> > +++ b/tests/functional/test_aarch64_aspeed.py
> > @@ -39,26 +39,28 @@ def test_aarch64_ast2700_evb_sdk_v09_02(self):
> >           archive_extract(image_path, self.workdir)
> >           num_cpu = 4
> > -        image_dir = self.workdir + '/ast2700-default/'
> 
> I'd maybe just change image_dir and keep the code below as it is, so you can
> avoid specifying 'ast2700-default' again and again.

Yeah, there's a little repetititon, but I was aiming to avoid doing
manual path concatenatation

> 
> > -        uboot_size = os.path.getsize(image_dir + 'u-boot-nodtb.bin')
> > +        uboot_size = os.path.getsize(self.scratch_file('ast2700-default',
> > +                                                       'u-boot-nodtb.bin'))
> >           uboot_dtb_load_addr = hex(0x400000000 + uboot_size)
> >           load_images_list = [
> >               {
> >                   'addr': '0x400000000',
> > -                'file': image_dir + 'u-boot-nodtb.bin'
> > +                'file': self.scratch_file('ast2700-default',
> > +                                          'u-boot-nodtb.bin')
> >               },
> >               {
> >                   'addr': str(uboot_dtb_load_addr),
> > -                'file': image_dir + 'u-boot.dtb'
> > +                'file': self.scratch_file('ast2700-default', 'u-boot.dtb')
> >               },
> >               {
> >                   'addr': '0x430000000',
> > -                'file': image_dir + 'bl31.bin'
> > +                'file': self.scratch_file('ast2700-default', 'bl31.bin')
> >               },
> >               {
> >                   'addr': '0x430080000',
> > -                'file': image_dir + 'optee/tee-raw.bin'
> > +                'file': self.scratch_file('ast2700-default', 'optee',
> > +                                          'tee-raw.bin')
> >               }
> >           ]



> > diff --git a/tests/functional/test_aarch64_raspi3.py b/tests/functional/test_aarch64_raspi3.py
> > index 369f95a3d9..98ed6f9d56 100755
> > --- a/tests/functional/test_aarch64_raspi3.py
> > +++ b/tests/functional/test_aarch64_raspi3.py
> > @@ -7,7 +7,6 @@
> >   #
> >   # SPDX-License-Identifier: GPL-2.0-or-later
> > -import os
> >   from zipfile import ZipFile
> >   from qemu_test import LinuxKernelTest, Asset
> > @@ -26,7 +25,7 @@ def test_aarch64_raspi3_atf(self):
> >           with ZipFile(zip_path, 'r') as zf:
> >                        zf.extract(efi_name, path=self.workdir)
> 
> Should that self.workdir above get replaced with self.scratch_file(), too?

This comes later in the series, when I add helpers for archive extraction
that avoid ned to refer to paths directly.


> > @@ -226,14 +226,16 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
> >           image_path = self.ASSET_BR2_202302_AST2600_TPM_FLASH.fetch()
> > -        tpmstate_dir = tempfile.TemporaryDirectory(prefix="qemu_")
> > +        tpmstate_dir = self.scratch_file('swtpmstate')
> > +        os.mkdir(tpmstate_dir)
> > +        socket_dir = tempfile.TemporaryDirectory(prefix="qemu_")
> 
> You don't seem to use socket_dir in any of your changes below?
> 
> Also, shouldn't this rather be using self.socket_dir() now?
> (maybe rather something for a separate patch?)
> 
> >           socket = os.path.join(tpmstate_dir.name, 'swtpm-socket')

This should have been 'socket_dir.name'

> >           # We must put the TPM state dir in /tmp/, not the build dir,
> >           # because some distros use AppArmor to lock down swtpm and
> >           # restrict the set of locations it can access files in.
> >           subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
> > -                        '--tpmstate', f'dir={tpmstate_dir.name}',
> > +                        '--tpmstate', f'dir={tpmstate_dir}',
> >                           '--ctrl', f'type=unixio,path={socket}'])
> >           self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
> > @@ -274,7 +276,7 @@ def test_arm_ast2500_evb_sdk(self):
> >           archive_extract(image_path, self.workdir)
> >           self.do_test_arm_aspeed_sdk_start(
> > -            self.workdir + '/ast2500-default/image-bmc')
> > +            self.scratch_file('ast2500-default', 'image-bmc'))
> >           self.wait_for_console_pattern('ast2500-default login:')
> > @@ -294,7 +296,7 @@ def test_arm_ast2600_evb_sdk(self):
> >           self.vm.add_args('-device',
> >               'ds1338,bus=aspeed.i2c.bus.5,address=0x32');
> >           self.do_test_arm_aspeed_sdk_start(
> > -            self.workdir + '/ast2600-a2/image-bmc')
> > +            self.scratch_file('ast2600-a2', 'image-bmc'))
> >           self.wait_for_console_pattern('ast2600-a2 login:')
> ...
> 
>  Thomas
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


