Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2D0C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 13:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9mLg-0005BU-Ve; Wed, 22 May 2024 09:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s9mLf-0005BG-EO
 for qemu-devel@nongnu.org; Wed, 22 May 2024 09:49:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s9mLb-00049J-Rp
 for qemu-devel@nongnu.org; Wed, 22 May 2024 09:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716385778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f+kNQCjAeAhTGnH8e6WtDMZwj/z6irOmW8Lw83gQHus=;
 b=PiMGeH/woWJJoN4AUCHRNCGZudW7tAlRHnPheToHyDXETgTm+PwknrQkHW5fvR3Yjj/VQ+
 8JXh09a9CEoAFjv+JoBxfQs/MtGLAyKkc3jjWeXDfoC+g/a1EUTA2Fq1IIUuBeDK+/m1yv
 Rd5ckaky3Yq4rrpPal5b9V5T8hrgY94=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-tKi7Eg9WN3m7tMC-nqE4Lg-1; Wed, 22 May 2024 09:49:37 -0400
X-MC-Unique: tKi7Eg9WN3m7tMC-nqE4Lg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-351cb5b7649so6404058f8f.3
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 06:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716385776; x=1716990576;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f+kNQCjAeAhTGnH8e6WtDMZwj/z6irOmW8Lw83gQHus=;
 b=XEF+okavYuRwWcJQ3vk+XdxkAmj0SsolGsNBJY1IrdmDYq5pHH+jEqWTgypMm6I2YH
 xH1GEc07Oa34j0b8AUz0xwRo76MTAEqXo1iif2Om2WqrH0E7AxsvlUFw2IFvXy3S30O4
 wXbiahTGsF07e03e5+50YR2cumj3tnw6mjD9IIKaXP97nIVPD3xajxY7SOvMZxTdAISO
 4UGCJP3GPH9FQHay3QR7k4vD2gVCRn3X8PZjtpgVqI9hgz8oAqJpGwjaUok3GLI1egQN
 1c9dImurS+lyvFKU4OGGbdfZRW5bGRQ5UA09GeQtwF/mwZQLwoI/8gudx09BiAfmeQRe
 +OqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA5+ITGansU2WMx7wWDF1924C7smQGksa1FDfIWsJjOaVzLGdNjk8ArOfmj30Xm9f7m2mjxtJLc3q0e7jYNpy3xnOyfqk=
X-Gm-Message-State: AOJu0Yz555OS7Eu3iUbi1zZhN+qZe2YqIxh6qJb2TmC1hqFjOF19h8Px
 hfXRrSUDZFouvZtfP2p4/TZ8mAxDZ/O1QVgzAtZ1+Fnn6bIKME3jnxZiWY94Grqux3TXrKzOKfw
 xRO1NPZRLmJbxBKsYXivyMQP8eP9tD9C57b7J9NPt9imDtgCczGZFiBTpJ35V+pjePEYo5OsZ1a
 eS5OtDENxWeO9gEnbQ+XRXPgJgm4A=
X-Received: by 2002:adf:ea83:0:b0:351:ce05:7a30 with SMTP id
 ffacd0b85a97d-354d8d8bad7mr1542102f8f.52.1716385775617; 
 Wed, 22 May 2024 06:49:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgY5LYMZJ+P2eInAmHudhndS5lhHsVP3y4JuXlgBHBTI88UZW8wjkVmv114mCLtUaQU+BK/8mZhqpsqprK9UQ=
X-Received: by 2002:adf:ea83:0:b0:351:ce05:7a30 with SMTP id
 ffacd0b85a97d-354d8d8bad7mr1542080f8f.52.1716385775104; Wed, 22 May 2024
 06:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240522-xkb-v3-0-c429de860fa1@daynix.com>
 <20240522-xkb-v3-3-c429de860fa1@daynix.com>
 <CABgObfYoEFZsW-H4WJ7xW0B85OqFi932d3-DmNAb6zTohFn=Og@mail.gmail.com>
In-Reply-To: <CABgObfYoEFZsW-H4WJ7xW0B85OqFi932d3-DmNAb6zTohFn=Og@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 22 May 2024 15:49:23 +0200
Message-ID: <CABgObfYeT5ScLmf=GszrU6cm4V7NR51iN2QPC7LH--nXRsxPxw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] meson: Drop the .fa library prefix
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, 
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 22, 2024 at 3:45=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On Wed, May 22, 2024 at 12:49=E2=80=AFPM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> > The non-standard .fa library prefix breaks the link source
> > de-duplication done by Meson so drop it.
>
> Can you show the difference in the command lines?
>
> One possibility to force de-duplication of objects is to change
> "link_whole: foo" to "objects: foo.extract_all_objects(recursive:
> false)" in all the declare_dependency() invocations that involve a
> 'fa' archive.
>
> This completely gets rid of the archives, which now become just a
> dummy target. I have gotten reports of "ld" exhausting the limit of
> open files when using thin archives (thin archives contain "symbolic
> links" to the files with the actual object code, thus reducing disk
> usage), and this would also be fixed.

Ah, I forgot that this would also fix an issue with link_whole
dependencies (https://github.com/mesonbuild/meson/pull/8151). It would
be possible to revert 3eacf70bb5a83e4775ad8003cbca63a40f70c8c2 and
instead just add gnutls to the crypto variable.

Paolo

> The disadvantage is requiring a bump to Meson 1.1.x as the minimum
> required version (the recommended version is 1.2.x because earlier
> versions are incompatible with recent macOS). It could be done before
> this patch (because then this patch is a total no-op), or after too to
> fix the immediate issue with sanitizer builds.
>
> Paolo
>
> > The lack of link source de-duplication causes AddressSanitizer to
> > complain ODR violations, and makes GNU ld abort when combined with
> > clang's LTO.
> >
> > Previously, the non-standard prefix was necessary for fork-fuzzing.
> > Meson wraps all standard-prefixed libraries with --start-group and
> > --end-group. This made a fork-fuzz.ld linker script wrapped as well and
> > broke builds. Commit d2e6f9272d33 ("fuzz: remove fork-fuzzing
> > scaffolding") dropped fork-fuzzing so we can now restore the standard
> > prefix.
> >
> > The occurences of the prefix were detected and removed by performing
> > a tree-wide search with 'fa' and .fa (note the quotes and dot).
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> >  docs/devel/build-system.rst         |  5 -----
> >  meson.build                         | 17 ++---------------
> >  stubs/blk-exp-close-all.c           |  2 +-
> >  .gitlab-ci.d/buildtest-template.yml |  2 --
> >  .gitlab-ci.d/buildtest.yml          |  2 --
> >  gdbstub/meson.build                 |  2 --
> >  tcg/meson.build                     |  2 --
> >  tests/Makefile.include              |  2 +-
> >  tests/qtest/libqos/meson.build      |  1 -
> >  9 files changed, 4 insertions(+), 31 deletions(-)
> >
> > diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
> > index 09caf2f8e199..5baf027b7614 100644
> > --- a/docs/devel/build-system.rst
> > +++ b/docs/devel/build-system.rst
> > @@ -236,15 +236,10 @@ Subsystem sourcesets:
> >    are then turned into static libraries as follows::
> >
> >      libchardev =3D static_library('chardev', chardev_ss.sources(),
> > -                                name_suffix: 'fa',
> >                                  build_by_default: false)
> >
> >      chardev =3D declare_dependency(link_whole: libchardev)
> >
> > -  As of Meson 0.55.1, the special ``.fa`` suffix should be used for ev=
erything
> > -  that is used with ``link_whole``, to ensure that the link flags are =
placed
> > -  correctly in the command line.
> > -
> >  Target-independent emulator sourcesets:
> >    Various general purpose helper code is compiled only once and
> >    the .o files are linked into all output binaries that need it.
> > diff --git a/meson.build b/meson.build
> > index 3c3ad0d5f5eb..9eaf218609eb 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -3462,14 +3462,12 @@ endif
> >  qom_ss =3D qom_ss.apply({})
> >  libqom =3D static_library('qom', qom_ss.sources() + genh,
> >                          dependencies: [qom_ss.dependencies()],
> > -                        name_suffix: 'fa',
> >                          build_by_default: false)
> >  qom =3D declare_dependency(link_whole: libqom)
> >
> >  event_loop_base =3D files('event-loop-base.c')
> >  event_loop_base =3D static_library('event-loop-base',
> >                                   sources: event_loop_base + genh,
> > -                                 name_suffix: 'fa',
> >                                   build_by_default: false)
> >  event_loop_base =3D declare_dependency(link_whole: event_loop_base,
> >                                       dependencies: [qom])
> > @@ -3703,7 +3701,6 @@ qemu_syms =3D custom_target('qemu.syms', output: =
'qemu.syms',
> >  authz_ss =3D authz_ss.apply({})
> >  libauthz =3D static_library('authz', authz_ss.sources() + genh,
> >                            dependencies: [authz_ss.dependencies()],
> > -                          name_suffix: 'fa',
> >                            build_by_default: false)
> >
> >  authz =3D declare_dependency(link_whole: libauthz,
> > @@ -3712,7 +3709,6 @@ authz =3D declare_dependency(link_whole: libauthz=
,
> >  crypto_ss =3D crypto_ss.apply({})
> >  libcrypto =3D static_library('crypto', crypto_ss.sources() + genh,
> >                             dependencies: [crypto_ss.dependencies()],
> > -                           name_suffix: 'fa',
> >                             build_by_default: false)
> >
> >  crypto =3D declare_dependency(link_whole: libcrypto,
> > @@ -3722,13 +3718,11 @@ io_ss =3D io_ss.apply({})
> >  libio =3D static_library('io', io_ss.sources() + genh,
> >                         dependencies: [io_ss.dependencies()],
> >                         link_with: libqemuutil,
> > -                       name_suffix: 'fa',
> >                         build_by_default: false)
> >
> >  io =3D declare_dependency(link_whole: libio, dependencies: [crypto, qo=
m])
> >
> >  libmigration =3D static_library('migration', sources: migration_files =
+ genh,
> > -                              name_suffix: 'fa',
> >                                build_by_default: false)
> >  migration =3D declare_dependency(link_with: libmigration,
> >                                 dependencies: [zlib, qom, io])
> > @@ -3738,7 +3732,6 @@ block_ss =3D block_ss.apply({})
> >  libblock =3D static_library('block', block_ss.sources() + genh,
> >                            dependencies: block_ss.dependencies(),
> >                            link_depends: block_syms,
> > -                          name_suffix: 'fa',
> >                            build_by_default: false)
> >
> >  block =3D declare_dependency(link_whole: [libblock],
> > @@ -3748,7 +3741,6 @@ block =3D declare_dependency(link_whole: [libbloc=
k],
> >  blockdev_ss =3D blockdev_ss.apply({})
> >  libblockdev =3D static_library('blockdev', blockdev_ss.sources() + gen=
h,
> >                               dependencies: blockdev_ss.dependencies(),
> > -                             name_suffix: 'fa',
> >                               build_by_default: false)
> >
> >  blockdev =3D declare_dependency(link_whole: [libblockdev],
> > @@ -3757,13 +3749,11 @@ blockdev =3D declare_dependency(link_whole: [li=
bblockdev],
> >  qmp_ss =3D qmp_ss.apply({})
> >  libqmp =3D static_library('qmp', qmp_ss.sources() + genh,
> >                          dependencies: qmp_ss.dependencies(),
> > -                        name_suffix: 'fa',
> >                          build_by_default: false)
> >
> >  qmp =3D declare_dependency(link_whole: [libqmp])
> >
> >  libchardev =3D static_library('chardev', chardev_ss.sources() + genh,
> > -                            name_suffix: 'fa',
> >                              dependencies: chardev_ss.dependencies(),
> >                              build_by_default: false)
> >
> > @@ -3771,7 +3761,6 @@ chardev =3D declare_dependency(link_whole: libcha=
rdev)
> >
> >  hwcore_ss =3D hwcore_ss.apply({})
> >  libhwcore =3D static_library('hwcore', sources: hwcore_ss.sources() + =
genh,
> > -                           name_suffix: 'fa',
> >                             build_by_default: false)
> >  hwcore =3D declare_dependency(link_whole: libhwcore)
> >  common_ss.add(hwcore)
> > @@ -3807,8 +3796,7 @@ common_all =3D static_library('common',
> >                              sources: common_ss.all_sources() + genh,
> >                              include_directories: common_user_inc,
> >                              implicit_include_directories: false,
> > -                            dependencies: common_ss.all_dependencies()=
,
> > -                            name_suffix: 'fa')
> > +                            dependencies: common_ss.all_dependencies()=
)
> >
> >  feature_to_c =3D find_program('scripts/feature_to_c.py')
> >
> > @@ -3909,8 +3897,7 @@ foreach target : target_dirs
> >                   objects: objects,
> >                   include_directories: target_inc,
> >                   c_args: c_args,
> > -                 build_by_default: false,
> > -                 name_suffix: 'fa')
> > +                 build_by_default: false)
> >
> >    if target.endswith('-softmmu')
> >      execs =3D [{
> > diff --git a/stubs/blk-exp-close-all.c b/stubs/blk-exp-close-all.c
> > index 1c7131676392..2f68e06d7d05 100644
> > --- a/stubs/blk-exp-close-all.c
> > +++ b/stubs/blk-exp-close-all.c
> > @@ -1,7 +1,7 @@
> >  #include "qemu/osdep.h"
> >  #include "block/export.h"
> >
> > -/* Only used in programs that support block exports (libblockdev.fa) *=
/
> > +/* Only used in programs that support block exports (libblockdev.a) */
> >  void blk_exp_close_all(void)
> >  {
> >  }
> > diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildte=
st-template.yml
> > index 22045add8064..69e468a576ba 100644
> > --- a/.gitlab-ci.d/buildtest-template.yml
> > +++ b/.gitlab-ci.d/buildtest-template.yml
> > @@ -45,10 +45,8 @@
> >      exclude:
> >        - build/**/*.p
> >        - build/**/*.a.p
> > -      - build/**/*.fa.p
> >        - build/**/*.c.o
> >        - build/**/*.c.o.d
> > -      - build/**/*.fa
> >
> >  .common_test_job_template:
> >    extends: .base_job_template
> > diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> > index cfdff175c389..c156e6f1d90e 100644
> > --- a/.gitlab-ci.d/buildtest.yml
> > +++ b/.gitlab-ci.d/buildtest.yml
> > @@ -178,10 +178,8 @@ build-previous-qemu:
> >      exclude:
> >        - build-previous/**/*.p
> >        - build-previous/**/*.a.p
> > -      - build-previous/**/*.fa.p
> >        - build-previous/**/*.c.o
> >        - build-previous/**/*.c.o.d
> > -      - build-previous/**/*.fa
> >    needs:
> >      job: amd64-opensuse-leap-container
> >    variables:
> > diff --git a/gdbstub/meson.build b/gdbstub/meson.build
> > index da5721d8452b..c91e398ae726 100644
> > --- a/gdbstub/meson.build
> > +++ b/gdbstub/meson.build
> > @@ -19,13 +19,11 @@ gdb_system_ss =3D gdb_system_ss.apply({})
> >
> >  libgdb_user =3D static_library('gdb_user',
> >                               gdb_user_ss.sources() + genh,
> > -                             name_suffix: 'fa',
> >                               c_args: '-DCONFIG_USER_ONLY',
> >                               build_by_default: false)
> >
> >  libgdb_system =3D static_library('gdb_system',
> >                                  gdb_system_ss.sources() + genh,
> > -                                name_suffix: 'fa',
> >                                  build_by_default: false)
> >
> >  gdb_user =3D declare_dependency(link_whole: libgdb_user)
> > diff --git a/tcg/meson.build b/tcg/meson.build
> > index 8251589fd4e9..f941413d5801 100644
> > --- a/tcg/meson.build
> > +++ b/tcg/meson.build
> > @@ -31,7 +31,6 @@ tcg_ss =3D tcg_ss.apply({})
> >
> >  libtcg_user =3D static_library('tcg_user',
> >                               tcg_ss.sources() + genh,
> > -                             name_suffix: 'fa',
> >                               c_args: '-DCONFIG_USER_ONLY',
> >                               build_by_default: false)
> >
> > @@ -41,7 +40,6 @@ user_ss.add(tcg_user)
> >
> >  libtcg_system =3D static_library('tcg_system',
> >                                  tcg_ss.sources() + genh,
> > -                                name_suffix: 'fa',
> >                                  c_args: '-DCONFIG_SOFTMMU',
> >                                  build_by_default: false)
> >
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index c9d1674bd070..d39d5dd6a43e 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -87,7 +87,7 @@ distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
> >  .PHONY: check-venv check-avocado check-acceptance check-acceptance-dep=
recated-warning
> >
> >  # Build up our target list from the filtered list of ninja targets
> > -TARGETS=3D$(patsubst libqemu-%.fa, %, $(filter libqemu-%.fa, $(ninja-t=
argets)))
> > +TARGETS=3D$(patsubst libqemu-%.a, %, $(filter libqemu-%.a, $(ninja-tar=
gets)))
> >
> >  TESTS_VENV_TOKEN=3D$(BUILD_DIR)/pyvenv/tests.group
> >  TESTS_RESULTS_DIR=3D$(BUILD_DIR)/tests/results
> > diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.=
build
> > index 3aed6efcb8d1..45b81c83ade3 100644
> > --- a/tests/qtest/libqos/meson.build
> > +++ b/tests/qtest/libqos/meson.build
> > @@ -68,7 +68,6 @@ if have_virtfs
> >  endif
> >
> >  libqos =3D static_library('qos', libqos_srcs + genh,
> > -                        name_suffix: 'fa',
> >                          build_by_default: false)
> >
> >  qos =3D declare_dependency(link_whole: libqos)
> >
> > --
> > 2.45.1
> >


