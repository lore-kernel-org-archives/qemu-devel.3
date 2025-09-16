Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5923BCAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 09:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyRrV-0008Jb-3B; Tue, 16 Sep 2025 05:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyRrL-0008I3-GA
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 05:20:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyRrI-0002VJ-Uj
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 05:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758014419;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Th5a/qoS7ax4Ly/DFJ/PJrQQgjIksdSPnSmZvren+h0=;
 b=CLi32f98MpMLC/ZL0rfJVoxNi0L6IDDgvU8wxgyxBvXI8W4L6dVEjAM/gxW0ha8HPT+M5/
 rSyOnxvMM9vCw76fPrPO6Z3JnWLARcUB9annuFy0r0p8sGjujTK50nkYvlniYrhWB/kcwI
 b+tnuOsSZt0TZ1n4uxaxyCKqGGQHP5w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-vFBLBDjlOJy6h7irUc-4QA-1; Tue,
 16 Sep 2025 05:20:15 -0400
X-MC-Unique: vFBLBDjlOJy6h7irUc-4QA-1
X-Mimecast-MFC-AGG-ID: vFBLBDjlOJy6h7irUc-4QA_1758014414
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 376C91956096; Tue, 16 Sep 2025 09:20:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2656E300018D; Tue, 16 Sep 2025 09:20:11 +0000 (UTC)
Date: Tue, 16 Sep 2025 10:20:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 1/2] tests/functional: Provide GDB to the functional
 tests
Message-ID: <aMkryJH9-SWPKtzc@redhat.com>
References: <20250915124207.42053-1-thuth@redhat.com>
 <20250915124207.42053-2-thuth@redhat.com>
 <275a593b-18e1-461a-a416-aea50cb67dc8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <275a593b-18e1-461a-a416-aea50cb67dc8@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 15, 2025 at 07:02:24PM -0300, Gustavo Romero wrote:
> Hi Thomas,
> 
> On 9/15/25 09:42, Thomas Huth wrote:
> > From: Gustavo Romero <gustavo.romero@linaro.org>
> > 
> > The probe of gdb is done in 'configure' and the full path is passed
> > to meson.build via the -Dgdb=option.
> > 
> > meson then can pass the location of gdb to the test via an environment
> > variable.
> > 
> > This patch is based on an earlier patch ("Support tests that require a
> > runner") by Gustavo Romero.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   configure                     | 2 ++
> >   meson.build                   | 4 ++++
> >   meson_options.txt             | 2 ++
> >   scripts/meson-buildoptions.sh | 2 ++
> >   tests/functional/meson.build  | 7 +++++++
> >   5 files changed, 17 insertions(+)
> > 
> > diff --git a/configure b/configure
> > index 274a7787642..8e2e2cd562a 100755
> > --- a/configure
> > +++ b/configure
> > @@ -1978,6 +1978,8 @@ if test "$skip_meson" = no; then
> >     test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
> >     test "$plugins" = yes && meson_option_add "-Dplugins=true"
> >     test "$tcg" != enabled && meson_option_add "-Dtcg=$tcg"
> > +  test -n "$gdb_bin" && meson_option_add "-Dgdb=$gdb_bin"
> > +
> >     run_meson() {
> >       NINJA=$ninja $meson setup "$@" "$PWD" "$source_path"
> >     }
> > diff --git a/meson.build b/meson.build
> > index 3d738733566..4cbc3c8ac65 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -75,6 +75,10 @@ have_user = have_linux_user or have_bsd_user
> >   sh = find_program('sh')
> >   python = import('python').find_installation()
> > +# Meson python.get_path() on 'purelib' or 'platlib' doesn't properly return the
> > +# site-packages dir in pyvenv, so it is built manually.
> > +python_ver = python.language_version()
> > +python_site_packages = meson.build_root() / 'pyvenv/lib/python' + python_ver / 'site-packages'
> >   cc = meson.get_compiler('c')
> >   all_languages = ['c']
> > diff --git a/meson_options.txt b/meson_options.txt
> > index fff1521e580..5bb41bcbc43 100644
> > --- a/meson_options.txt
> > +++ b/meson_options.txt
> > @@ -36,6 +36,8 @@ option('trace_file', type: 'string', value: 'trace',
> >   option('coroutine_backend', type: 'combo',
> >          choices: ['ucontext', 'sigaltstack', 'windows', 'wasm', 'auto'],
> >          value: 'auto', description: 'coroutine backend to use')
> > +option('gdb', type: 'string', value: '',
> > +       description: 'Path to GDB')
> >   # Everything else can be set via --enable/--disable-* option
> >   # on the configure script command line.  After adding an option
> > diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> > index 0ebe6bc52a6..f4bd21220ee 100644
> > --- a/scripts/meson-buildoptions.sh
> > +++ b/scripts/meson-buildoptions.sh
> > @@ -58,6 +58,7 @@ meson_options_help() {
> >     printf "%s\n" '  --enable-ubsan           enable undefined behaviour sanitizer'
> >     printf "%s\n" '  --firmwarepath=VALUES    search PATH for firmware files [share/qemu-'
> >     printf "%s\n" '                           firmware]'
> > +  printf "%s\n" '  --gdb=VALUE              Path to GDB'
> >     printf "%s\n" '  --iasl=VALUE             Path to ACPI disassembler'
> >     printf "%s\n" '  --includedir=VALUE       Header file directory [include]'
> >     printf "%s\n" '  --interp-prefix=VALUE    where to find shared libraries etc., use %M for'
> > @@ -323,6 +324,7 @@ _meson_option_parse() {
> >       --disable-fuzzing) printf "%s" -Dfuzzing=false ;;
> >       --enable-gcrypt) printf "%s" -Dgcrypt=enabled ;;
> >       --disable-gcrypt) printf "%s" -Dgcrypt=disabled ;;
> > +    --gdb=*) quote_sh "-Dgdb=$2" ;;
> >       --enable-gettext) printf "%s" -Dgettext=enabled ;;
> >       --disable-gettext) printf "%s" -Dgettext=disabled ;;
> >       --enable-gio) printf "%s" -Dgio=enabled ;;
> > diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> > index 2a0c5aa1418..c822eb66309 100644
> > --- a/tests/functional/meson.build
> > +++ b/tests/functional/meson.build
> > @@ -77,6 +77,12 @@ foreach speed : ['quick', 'thorough']
> >       test_env.set('PYTHONPATH', meson.project_source_root() / 'python:' +
> >                                  meson.current_source_dir())
> 
> It's necessary to add the Python modules from pyvenv to the PYTHONPATH, otherwise
> when libpython from GDB looks for pycotap it cannot find it. We already have
> it in python_site_packages in Meson (introduced with this series) so adding
> python_site_packages to test_env.set() above, like:

This dovetails to the point I made on the cover letter.

The pyvenv is populated wrt the python version we selected for QEMU.
This cannot be assumed to be the same as the version that GDB was
built against. Pointing GDB to a venv for a different python version
is not a good idea.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


