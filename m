Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3619C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 08:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHIyQ-00005Z-0w; Wed, 12 Jun 2024 04:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHIyL-00004q-IR
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHIyI-0004ip-DA
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718179480;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zQrFEe7W4sI09VOobip/BVk5fiOKKKkN3S6RFtH+sMI=;
 b=R6RjeSpiHKLpCKFcq8/6bEFCHv94Co2CCDXR+KbPKvQzE5YuF+lDHat1U2IZHdApgRajU0
 qzlHcsE14qSe5LCeMeOYPkD53xu+cyszX7Kb2wE1p3cVeEaTFbL9UftOYaJM6AXlpw+Gp4
 1pJ7RkxYhMlW6HucCduZogTdIvDUpiI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-v5k5eKsmO6Kj2geOKLER6g-1; Wed,
 12 Jun 2024 04:04:32 -0400
X-MC-Unique: v5k5eKsmO6Kj2geOKLER6g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE48A19560A7; Wed, 12 Jun 2024 08:04:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.115])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6646E1956087; Wed, 12 Jun 2024 08:04:23 +0000 (UTC)
Date: Wed, 12 Jun 2024 09:04:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v1 1/6] build-sys: Add rust feature option
Message-ID: <ZmlWbsG9edD4GgSZ@redhat.com>
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <0933b669c8e47e1a78d21e56881e0933ef910461.1718040303.git.manos.pitsidianakis@linaro.org>
 <20240610192517.GA350256@fedora>
 <CAAjaMXZ9bBtNyrjhUy=ypFeVYuo7ctHbaro6VCKins7-3M9e=g@mail.gmail.com>
 <CAJSP0QVvU2Vta6gcdBbDiV8a5wQf64HbYrJj_UOduhQynLyzNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QVvU2Vta6gcdBbDiV8a5wQf64HbYrJj_UOduhQynLyzNg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Jun 11, 2024 at 02:25:39PM -0400, Stefan Hajnoczi wrote:
> On Tue, 11 Jun 2024 at 13:54, Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
> >
> > On Tue, 11 Jun 2024 at 17:05, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > >
> > > On Mon, Jun 10, 2024 at 09:22:36PM +0300, Manos Pitsidianakis wrote:
> > > > Add options for Rust in meson_options.txt, meson.build, configure to
> > > > prepare for adding Rust code in the followup commits.
> > > >
> > > > `rust` is a reserved meson name, so we have to use an alternative.
> > > > `with_rust` was chosen.
> > > >
> > > > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > > > ---
> > > > The cargo wrapper script hardcodes some rust target triples. This is
> > > > just temporary.
> > > > ---
> > > >  .gitignore               |   2 +
> > > >  configure                |  12 +++
> > > >  meson.build              |  11 ++
> > > >  meson_options.txt        |   4 +
> > > >  scripts/cargo_wrapper.py | 211 +++++++++++++++++++++++++++++++++++++++
> > > >  5 files changed, 240 insertions(+)
> > > >  create mode 100644 scripts/cargo_wrapper.py

> > > > diff --git a/configure b/configure
> > > > index 38ee257701..c195630771 100755
> > > > --- a/configure
> > > > +++ b/configure

snip

> > > > +  test "$with_rust_target_triple" != "" && meson_option_add "-Dwith_rust_target_triple=$with_rust_target_triple"

So the --rust-target-triple is only needed when cross compiling,
but this is not the way we normally handle passing cross compiler
info to meson. Instead we create a meson cross compiler options
file containing the target info.

eg for ./configure --cross-prefix=x86_64-w64-mingw32-

we end up creating:

$ cat build/config-meson.cross 
# Automatically generated by configure - do not modify
[properties]
[built-in options]
c_args = []
cpp_args = []
objc_args = []
c_link_args = []
cpp_link_args = []
# environment defaults, can still be overridden on 
# the command line
werror = true
[project options]

[binaries]
c = ['x86_64-w64-mingw32-gcc','-m64']
cpp = ['x86_64-w64-mingw32-g++','-m64']
objc = ['x86_64-w64-mingw32-clang','-m64']
ar = ['x86_64-w64-mingw32-ar']
dlltool = ['x86_64-w64-mingw32-dlltool']
nm = ['x86_64-w64-mingw32-nm']
pkgconfig = ['x86_64-w64-mingw32-pkg-config']
pkg-config = ['x86_64-w64-mingw32-pkg-config']
ranlib = ['x86_64-w64-mingw32-ranlib']
strip = ['x86_64-w64-mingw32-strip']
widl = ['x86_64-w64-mingw32-widl']
windres = ['x86_64-w64-mingw32-windres']
windmc = ['x86_64-w64-mingw32-windmc']
[host_machine]
system = 'windows'
cpu_family = 'x86_64'
cpu = 'x86_64'
endian = 'little'


Should we not be passing the rust compiler target through
this meson options file by setting something like this

  rust = ['rustc', '--target', '$target_target_triple']


Also I don't think we should be requiring --rust-target-triple
to be passed by the user. For all the combinations we know &
test, we should have configure "do the right thing" and set a
suitable rust target triple based on the --cross-prefix argument
that is given, so there is no extra burden on users cross
compiling. Users should then only use --rust-target-triple
if our default logic is wrong for some reason.

> > > >    run_meson() {
> > > >      NINJA=$ninja $meson setup "$@" "$PWD" "$source_path"
> > > >    }
> > > > diff --git a/scripts/cargo_wrapper.py b/scripts/cargo_wrapper.py
> > > > new file mode 100644
> > > > index 0000000000..d338effdaa
> > > > --- /dev/null
> > > > +++ b/scripts/cargo_wrapper.py
> > > > @@ -0,0 +1,211 @@
> > > > +#!/usr/bin/env python3
> > > > +# Copyright (c) 2020 Red Hat, Inc.
> > > > +# Copyright (c) 2023 Linaro Ltd.
> > > > +#
> > > > +# Authors:
> > > > +#  Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > > > +#  Marc-André Lureau <marcandre.lureau@redhat.com>
> > > > +#
> > > > +# This work is licensed under the terms of the GNU GPL, version 2 or
> > > > +# later.  See the COPYING file in the top-level directory.
> > > > +
> > > > +import argparse
> > > > +import configparser
> > > > +import distutils.file_util
> > > > +import json
> > > > +import logging
> > > > +import os
> > > > +import os.path
> > > > +import re
> > > > +import subprocess
> > > > +import sys
> > > > +import pathlib
> > > > +import shutil
> > > > +import tomllib
> > > > +
> > > > +from pathlib import Path
> > > > +from typing import Any, Dict, List, Tuple
> > > > +
> > > > +RUST_TARGET_TRIPLES = (
> > > > +    "aarch64-unknown-linux-gnu",
> > > > +    "x86_64-unknown-linux-gnu",
> > > > +    "x86_64-apple-darwin",
> > > > +    "aarch64-apple-darwin",
> > > > +)
> > >
> > > Is this hardcoded to avoid calling `rustc --print target-list`?
> > >
> > > Or is this the support matrix? In that case it would be interesting to
> > > figure out the target triples for all host OSes and CPUs that QEMU is
> > > supported on.
> >
> > Yes, it's what I tested it on (the x86-64-apple-darwin part through rosetta).
> >
> > Do you think running -print target-list would be a better choice here?
> > This is only for providing the valid choices for the target triplet
> > CLI argument in argparse.
> 
> How about not restricting choices? If the user specifies an invalid
> choice then the compiler will fail with an error message. That seems
> okay and avoids the issue altogether.

Yes, we should not artifically limit the choices of target at all, as
we don't do that for existing cross compiler targets.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


