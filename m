Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB9EC25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 13:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9mI6-0002Ls-N7; Wed, 22 May 2024 09:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s9mI5-0002LJ-Fc
 for qemu-devel@nongnu.org; Wed, 22 May 2024 09:46:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s9mI3-0003dR-4V
 for qemu-devel@nongnu.org; Wed, 22 May 2024 09:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716385557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o/+NrXakzle7TKWw/7/3ieglmoXJcyuP2EUKglQYqqw=;
 b=WhDW6fH01KJ3YL0nPyeMpiPhU3LI5FHux1aB1Ro92b2tfj/eKNUU4uXpg2Q/OA92Y+5t4u
 F3JpJQfIjNJqCur9JDQOyjoe8rVdoQwiJikKbkP7X6KCU14HlTXOqBzj5e0O3lOsvPbcF4
 cD2u9Ofc20BmZRf5KmPElh79HRSIsSQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-nRunWJTLNpuRYR9yUabp1w-1; Wed, 22 May 2024 09:45:56 -0400
X-MC-Unique: nRunWJTLNpuRYR9yUabp1w-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-354e0805ef3so340121f8f.3
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 06:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716385554; x=1716990354;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o/+NrXakzle7TKWw/7/3ieglmoXJcyuP2EUKglQYqqw=;
 b=pwYgS6YRoH2Fr/Z7JIFs5kUhp8DH6RQvBxOOFmnhL6PmMMtrIuDgDaoTqVuHOGBAJk
 z8C6eUI8lt7tEbj66FlcIFLmsKqdA4mMjECUzfm4H2yUpxwU6Gk6CZg86HC8bqYPgGvY
 +oUBMrcOAC1MSOXtql14XT0ZARskNXBDa8hb1nK4aCq88cu1mjvq1tJ+OMHNw1Y6J31f
 QZOkzDtLG1tD567IGndOdPm3lm54c5NK4VIIX/kXuRU/BLdlsjrVT+rLjzHW8HTKh3XA
 8GmB0CZzCpAeoze1K+EmBQb7ogkF5LFLJIQhp3Xv+gmuOtOgBqyyvzpydzBK59y3XYZJ
 /Vig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs8QnA08MuT8wPyT01BVg/8wTCEiRULB7Q1SFZMM99zc/CBwYzvEKgGr55r4uJz74N76lquwF0sUtt00f15thcUQ/oN6Q=
X-Gm-Message-State: AOJu0Yxz6w1+cEwnLuBDCBC+sTyf7AXfdRnBRI+yl0DAXv8V2AP96ZLA
 0F9XGOytqfgf2onLBIbGZ2qD4lNIpeXflu+A0RUhPX+mUDHZ9jqDrtHQ/uf4RTdBWkdmVxqsldJ
 GN9/8vxfWHl/8KKT/NS175wkKH3G8+2Nsc99XN2NTqlUbPn5UFObZm0KmxvQkPOYDzaSVe9yL07
 G7WcVfCoEIH9jKcs0BCEphfSX7nLY=
X-Received: by 2002:adf:f4cb:0:b0:34d:ae55:9dbc with SMTP id
 ffacd0b85a97d-354d8c86160mr1936396f8f.16.1716385554092; 
 Wed, 22 May 2024 06:45:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL7R6UUxhzr6rACga5drzdUvQmRs5zn0E4EqnZb7/sW0V5s1wWF4S59KXq502/tr4hiREggWjobzadXvZUiAs=
X-Received: by 2002:adf:f4cb:0:b0:34d:ae55:9dbc with SMTP id
 ffacd0b85a97d-354d8c86160mr1936366f8f.16.1716385553598; Wed, 22 May 2024
 06:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240522-xkb-v3-0-c429de860fa1@daynix.com>
 <20240522-xkb-v3-3-c429de860fa1@daynix.com>
In-Reply-To: <20240522-xkb-v3-3-c429de860fa1@daynix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 22 May 2024 15:45:40 +0200
Message-ID: <CABgObfYoEFZsW-H4WJ7xW0B85OqFi932d3-DmNAb6zTohFn=Og@mail.gmail.com>
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

On Wed, May 22, 2024 at 12:49=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
> The non-standard .fa library prefix breaks the link source
> de-duplication done by Meson so drop it.

Can you show the difference in the command lines?

One possibility to force de-duplication of objects is to change
"link_whole: foo" to "objects: foo.extract_all_objects(recursive:
false)" in all the declare_dependency() invocations that involve a
'fa' archive.

This completely gets rid of the archives, which now become just a
dummy target. I have gotten reports of "ld" exhausting the limit of
open files when using thin archives (thin archives contain "symbolic
links" to the files with the actual object code, thus reducing disk
usage), and this would also be fixed.

The disadvantage is requiring a bump to Meson 1.1.x as the minimum
required version (the recommended version is 1.2.x because earlier
versions are incompatible with recent macOS). It could be done before
this patch (because then this patch is a total no-op), or after too to
fix the immediate issue with sanitizer builds.

Paolo

> The lack of link source de-duplication causes AddressSanitizer to
> complain ODR violations, and makes GNU ld abort when combined with
> clang's LTO.
>
> Previously, the non-standard prefix was necessary for fork-fuzzing.
> Meson wraps all standard-prefixed libraries with --start-group and
> --end-group. This made a fork-fuzz.ld linker script wrapped as well and
> broke builds. Commit d2e6f9272d33 ("fuzz: remove fork-fuzzing
> scaffolding") dropped fork-fuzzing so we can now restore the standard
> prefix.
>
> The occurences of the prefix were detected and removed by performing
> a tree-wide search with 'fa' and .fa (note the quotes and dot).
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  docs/devel/build-system.rst         |  5 -----
>  meson.build                         | 17 ++---------------
>  stubs/blk-exp-close-all.c           |  2 +-
>  .gitlab-ci.d/buildtest-template.yml |  2 --
>  .gitlab-ci.d/buildtest.yml          |  2 --
>  gdbstub/meson.build                 |  2 --
>  tcg/meson.build                     |  2 --
>  tests/Makefile.include              |  2 +-
>  tests/qtest/libqos/meson.build      |  1 -
>  9 files changed, 4 insertions(+), 31 deletions(-)
>
> diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
> index 09caf2f8e199..5baf027b7614 100644
> --- a/docs/devel/build-system.rst
> +++ b/docs/devel/build-system.rst
> @@ -236,15 +236,10 @@ Subsystem sourcesets:
>    are then turned into static libraries as follows::
>
>      libchardev =3D static_library('chardev', chardev_ss.sources(),
> -                                name_suffix: 'fa',
>                                  build_by_default: false)
>
>      chardev =3D declare_dependency(link_whole: libchardev)
>
> -  As of Meson 0.55.1, the special ``.fa`` suffix should be used for ever=
ything
> -  that is used with ``link_whole``, to ensure that the link flags are pl=
aced
> -  correctly in the command line.
> -
>  Target-independent emulator sourcesets:
>    Various general purpose helper code is compiled only once and
>    the .o files are linked into all output binaries that need it.
> diff --git a/meson.build b/meson.build
> index 3c3ad0d5f5eb..9eaf218609eb 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3462,14 +3462,12 @@ endif
>  qom_ss =3D qom_ss.apply({})
>  libqom =3D static_library('qom', qom_ss.sources() + genh,
>                          dependencies: [qom_ss.dependencies()],
> -                        name_suffix: 'fa',
>                          build_by_default: false)
>  qom =3D declare_dependency(link_whole: libqom)
>
>  event_loop_base =3D files('event-loop-base.c')
>  event_loop_base =3D static_library('event-loop-base',
>                                   sources: event_loop_base + genh,
> -                                 name_suffix: 'fa',
>                                   build_by_default: false)
>  event_loop_base =3D declare_dependency(link_whole: event_loop_base,
>                                       dependencies: [qom])
> @@ -3703,7 +3701,6 @@ qemu_syms =3D custom_target('qemu.syms', output: 'q=
emu.syms',
>  authz_ss =3D authz_ss.apply({})
>  libauthz =3D static_library('authz', authz_ss.sources() + genh,
>                            dependencies: [authz_ss.dependencies()],
> -                          name_suffix: 'fa',
>                            build_by_default: false)
>
>  authz =3D declare_dependency(link_whole: libauthz,
> @@ -3712,7 +3709,6 @@ authz =3D declare_dependency(link_whole: libauthz,
>  crypto_ss =3D crypto_ss.apply({})
>  libcrypto =3D static_library('crypto', crypto_ss.sources() + genh,
>                             dependencies: [crypto_ss.dependencies()],
> -                           name_suffix: 'fa',
>                             build_by_default: false)
>
>  crypto =3D declare_dependency(link_whole: libcrypto,
> @@ -3722,13 +3718,11 @@ io_ss =3D io_ss.apply({})
>  libio =3D static_library('io', io_ss.sources() + genh,
>                         dependencies: [io_ss.dependencies()],
>                         link_with: libqemuutil,
> -                       name_suffix: 'fa',
>                         build_by_default: false)
>
>  io =3D declare_dependency(link_whole: libio, dependencies: [crypto, qom]=
)
>
>  libmigration =3D static_library('migration', sources: migration_files + =
genh,
> -                              name_suffix: 'fa',
>                                build_by_default: false)
>  migration =3D declare_dependency(link_with: libmigration,
>                                 dependencies: [zlib, qom, io])
> @@ -3738,7 +3732,6 @@ block_ss =3D block_ss.apply({})
>  libblock =3D static_library('block', block_ss.sources() + genh,
>                            dependencies: block_ss.dependencies(),
>                            link_depends: block_syms,
> -                          name_suffix: 'fa',
>                            build_by_default: false)
>
>  block =3D declare_dependency(link_whole: [libblock],
> @@ -3748,7 +3741,6 @@ block =3D declare_dependency(link_whole: [libblock]=
,
>  blockdev_ss =3D blockdev_ss.apply({})
>  libblockdev =3D static_library('blockdev', blockdev_ss.sources() + genh,
>                               dependencies: blockdev_ss.dependencies(),
> -                             name_suffix: 'fa',
>                               build_by_default: false)
>
>  blockdev =3D declare_dependency(link_whole: [libblockdev],
> @@ -3757,13 +3749,11 @@ blockdev =3D declare_dependency(link_whole: [libb=
lockdev],
>  qmp_ss =3D qmp_ss.apply({})
>  libqmp =3D static_library('qmp', qmp_ss.sources() + genh,
>                          dependencies: qmp_ss.dependencies(),
> -                        name_suffix: 'fa',
>                          build_by_default: false)
>
>  qmp =3D declare_dependency(link_whole: [libqmp])
>
>  libchardev =3D static_library('chardev', chardev_ss.sources() + genh,
> -                            name_suffix: 'fa',
>                              dependencies: chardev_ss.dependencies(),
>                              build_by_default: false)
>
> @@ -3771,7 +3761,6 @@ chardev =3D declare_dependency(link_whole: libchard=
ev)
>
>  hwcore_ss =3D hwcore_ss.apply({})
>  libhwcore =3D static_library('hwcore', sources: hwcore_ss.sources() + ge=
nh,
> -                           name_suffix: 'fa',
>                             build_by_default: false)
>  hwcore =3D declare_dependency(link_whole: libhwcore)
>  common_ss.add(hwcore)
> @@ -3807,8 +3796,7 @@ common_all =3D static_library('common',
>                              sources: common_ss.all_sources() + genh,
>                              include_directories: common_user_inc,
>                              implicit_include_directories: false,
> -                            dependencies: common_ss.all_dependencies(),
> -                            name_suffix: 'fa')
> +                            dependencies: common_ss.all_dependencies())
>
>  feature_to_c =3D find_program('scripts/feature_to_c.py')
>
> @@ -3909,8 +3897,7 @@ foreach target : target_dirs
>                   objects: objects,
>                   include_directories: target_inc,
>                   c_args: c_args,
> -                 build_by_default: false,
> -                 name_suffix: 'fa')
> +                 build_by_default: false)
>
>    if target.endswith('-softmmu')
>      execs =3D [{
> diff --git a/stubs/blk-exp-close-all.c b/stubs/blk-exp-close-all.c
> index 1c7131676392..2f68e06d7d05 100644
> --- a/stubs/blk-exp-close-all.c
> +++ b/stubs/blk-exp-close-all.c
> @@ -1,7 +1,7 @@
>  #include "qemu/osdep.h"
>  #include "block/export.h"
>
> -/* Only used in programs that support block exports (libblockdev.fa) */
> +/* Only used in programs that support block exports (libblockdev.a) */
>  void blk_exp_close_all(void)
>  {
>  }
> diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest=
-template.yml
> index 22045add8064..69e468a576ba 100644
> --- a/.gitlab-ci.d/buildtest-template.yml
> +++ b/.gitlab-ci.d/buildtest-template.yml
> @@ -45,10 +45,8 @@
>      exclude:
>        - build/**/*.p
>        - build/**/*.a.p
> -      - build/**/*.fa.p
>        - build/**/*.c.o
>        - build/**/*.c.o.d
> -      - build/**/*.fa
>
>  .common_test_job_template:
>    extends: .base_job_template
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index cfdff175c389..c156e6f1d90e 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -178,10 +178,8 @@ build-previous-qemu:
>      exclude:
>        - build-previous/**/*.p
>        - build-previous/**/*.a.p
> -      - build-previous/**/*.fa.p
>        - build-previous/**/*.c.o
>        - build-previous/**/*.c.o.d
> -      - build-previous/**/*.fa
>    needs:
>      job: amd64-opensuse-leap-container
>    variables:
> diff --git a/gdbstub/meson.build b/gdbstub/meson.build
> index da5721d8452b..c91e398ae726 100644
> --- a/gdbstub/meson.build
> +++ b/gdbstub/meson.build
> @@ -19,13 +19,11 @@ gdb_system_ss =3D gdb_system_ss.apply({})
>
>  libgdb_user =3D static_library('gdb_user',
>                               gdb_user_ss.sources() + genh,
> -                             name_suffix: 'fa',
>                               c_args: '-DCONFIG_USER_ONLY',
>                               build_by_default: false)
>
>  libgdb_system =3D static_library('gdb_system',
>                                  gdb_system_ss.sources() + genh,
> -                                name_suffix: 'fa',
>                                  build_by_default: false)
>
>  gdb_user =3D declare_dependency(link_whole: libgdb_user)
> diff --git a/tcg/meson.build b/tcg/meson.build
> index 8251589fd4e9..f941413d5801 100644
> --- a/tcg/meson.build
> +++ b/tcg/meson.build
> @@ -31,7 +31,6 @@ tcg_ss =3D tcg_ss.apply({})
>
>  libtcg_user =3D static_library('tcg_user',
>                               tcg_ss.sources() + genh,
> -                             name_suffix: 'fa',
>                               c_args: '-DCONFIG_USER_ONLY',
>                               build_by_default: false)
>
> @@ -41,7 +40,6 @@ user_ss.add(tcg_user)
>
>  libtcg_system =3D static_library('tcg_system',
>                                  tcg_ss.sources() + genh,
> -                                name_suffix: 'fa',
>                                  c_args: '-DCONFIG_SOFTMMU',
>                                  build_by_default: false)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index c9d1674bd070..d39d5dd6a43e 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -87,7 +87,7 @@ distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
>  .PHONY: check-venv check-avocado check-acceptance check-acceptance-depre=
cated-warning
>
>  # Build up our target list from the filtered list of ninja targets
> -TARGETS=3D$(patsubst libqemu-%.fa, %, $(filter libqemu-%.fa, $(ninja-tar=
gets)))
> +TARGETS=3D$(patsubst libqemu-%.a, %, $(filter libqemu-%.a, $(ninja-targe=
ts)))
>
>  TESTS_VENV_TOKEN=3D$(BUILD_DIR)/pyvenv/tests.group
>  TESTS_RESULTS_DIR=3D$(BUILD_DIR)/tests/results
> diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.bu=
ild
> index 3aed6efcb8d1..45b81c83ade3 100644
> --- a/tests/qtest/libqos/meson.build
> +++ b/tests/qtest/libqos/meson.build
> @@ -68,7 +68,6 @@ if have_virtfs
>  endif
>
>  libqos =3D static_library('qos', libqos_srcs + genh,
> -                        name_suffix: 'fa',
>                          build_by_default: false)
>
>  qos =3D declare_dependency(link_whole: libqos)
>
> --
> 2.45.1
>


