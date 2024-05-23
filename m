Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABBDC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 09:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA4dA-0003EA-FM; Thu, 23 May 2024 05:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sA4d9-0003Cx-9T
 for qemu-devel@nongnu.org; Thu, 23 May 2024 05:20:59 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sA4d0-0004V9-1q
 for qemu-devel@nongnu.org; Thu, 23 May 2024 05:20:59 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-572669fd9f9so11223021a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 02:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716456047; x=1717060847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=EcZ+0me2F/K1mHM/s3g9751tvdNYFctFe1UFp8CvXdU=;
 b=RyS48uzKQxH9MWq/WpLAKCRyLXKMDk/lYKP/lWy7tcW3y5ZMyclj1Z82IFNVqu1L7q
 MZyYcHBBCnvRegD4n9zmypOuf7nWF+BibWBU21iZ1NTYWIwVJpnAe1/VJOmHx+toayYZ
 yJAv/hT02NpOMjzQzM8ZoNqV8QiOsIoGFdt0MPg7f1t06Ud5L5xTClLO524zeK+aEUyE
 /nG+WinUHEUUY5AHr6244rBltcvYA7+ujlfAVh/iHjw44LtKFFlIPJCxq9nt3syCmOnn
 OCQy2zk10X64xqZfiWMkqH0+l+ODF8x8hkT9WiCdy2wxA7qLAnjBO2hW9z3Vb+/NSrVj
 q6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716456047; x=1717060847;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EcZ+0me2F/K1mHM/s3g9751tvdNYFctFe1UFp8CvXdU=;
 b=Ch5Bclrgfs5QYbU1vJoisIEccLNKw5Prz+x6USu7uzsvh5YDQ+W0aaOVTag1/WBBr5
 7s4hduis8V8uS46BE1s0Amu8M8LKi4Z1o05ya9dhlBiNY+YMqGjHDDuZ8G88nnk+zBsU
 g7z2mZuohfM65Y+J/xTAGpkAx9bPi4zvD9VJtA1aU/oKbYOAM+aW0u685VCEYYzObtxP
 46vc/Srbh17d147ibwTroInLhl73Ik2U8IRRVRKObx7P9y+SlmJ4S5y39MVvNjEl0g/k
 3krkIJc+CXpB67vFUzWdjFVzM3XK1ZN3HZWsfePr13uo/CuTaK2bnr7wugXk1IN3uieI
 OF2w==
X-Gm-Message-State: AOJu0YzH691qvTQiN6ro7ZKdc2DjL1LSVZge1kyOSbhZrsLO67QdKxs8
 xc7txF6dC+9FvXJMGbH5U6vEo3FLn859Oo/CWO3owSBE3vDo4w221xC3zA==
X-Google-Smtp-Source: AGHT+IER4+KGNb7jyOf2/LNUZccE/GlZDhkE/PbYEJtpEiFOg7WYDR1uLBOMLsrGmLmgsr0kp4eY5A==
X-Received: by 2002:a17:906:f6d8:b0:a59:a431:f951 with SMTP id
 a640c23a62f3a-a622816909amr262555166b.48.1716456046343; 
 Thu, 23 May 2024 02:20:46 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781d1fcsm1901226666b.35.2024.05.23.02.20.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 02:20:45 -0700 (PDT)
Date: Thu, 23 May 2024 08:44:57 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?ISO-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v2 3/3] meson: Drop the .fa library prefix
In-Reply-To: <20240522-xkb-v2-3-67b54fa7c98f@daynix.com>
References: <20240522-xkb-v2-0-67b54fa7c98f@daynix.com>
 <20240522-xkb-v2-3-67b54fa7c98f@daynix.com>
Message-ID: <0F153196-AA69-4407-A161-C2565B48C5FE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 22=2E Mai 2024 10:43:04 UTC schrieb Akihiko Odaki <akihiko=2Eodaki@dayn=
ix=2Ecom>:
>The non-standard =2Efa library prefix breaks the link source

s/prefix/suffix/ in the commit message and subject=2E

Best regards,
Bernhard

>de-duplication done by Meson so drop it=2E
>
>The lack of link source de-duplication causes AddressSanitizer to
>complain ODR violations, and makes GNU ld abort when combined with
>clang's LTO=2E
>
>Previously, the non-standard prefix was necessary for fork-fuzzing=2E
>Meson wraps all standard-prefixed libraries with --start-group and
>--end-group=2E This made a fork-fuzz=2Eld linker script wrapped as well a=
nd
>broke builds=2E Commit d2e6f9272d33 ("fuzz: remove fork-fuzzing
>scaffolding") dropped fork-fuzzing so we can now restore the standard
>prefix=2E
>
>The occurances of the prefix was detected and removed by performing
>a tree-wide search with 'fa' and =2Efa (note the quotes and dot)=2E
>
>Signed-off-by: Akihiko Odaki <akihiko=2Eodaki@daynix=2Ecom>
>---
> docs/devel/build-system=2Erst         | 5 -----
> stubs/blk-exp-close-all=2Ec           | 2 +-
> =2Egitlab-ci=2Ed/buildtest-template=2Eyml | 2 --
> =2Egitlab-ci=2Ed/buildtest=2Eyml          | 2 --
> gdbstub/meson=2Ebuild                 | 2 --
> tcg/meson=2Ebuild                     | 2 --
> tests/Makefile=2Einclude              | 2 +-
> tests/qtest/libqos/meson=2Ebuild      | 1 -
> 8 files changed, 2 insertions(+), 16 deletions(-)
>
>diff --git a/docs/devel/build-system=2Erst b/docs/devel/build-system=2Ers=
t
>index 09caf2f8e199=2E=2E5baf027b7614 100644
>--- a/docs/devel/build-system=2Erst
>+++ b/docs/devel/build-system=2Erst
>@@ -236,15 +236,10 @@ Subsystem sourcesets:
>   are then turned into static libraries as follows::
>=20
>     libchardev =3D static_library('chardev', chardev_ss=2Esources(),
>-                                name_suffix: 'fa',
>                                 build_by_default: false)
>=20
>     chardev =3D declare_dependency(link_whole: libchardev)
>=20
>-  As of Meson 0=2E55=2E1, the special ``=2Efa`` suffix should be used fo=
r everything
>-  that is used with ``link_whole``, to ensure that the link flags are pl=
aced
>-  correctly in the command line=2E
>-
> Target-independent emulator sourcesets:
>   Various general purpose helper code is compiled only once and
>   the =2Eo files are linked into all output binaries that need it=2E
>diff --git a/stubs/blk-exp-close-all=2Ec b/stubs/blk-exp-close-all=2Ec
>index 1c7131676392=2E=2E2f68e06d7d05 100644
>--- a/stubs/blk-exp-close-all=2Ec
>+++ b/stubs/blk-exp-close-all=2Ec
>@@ -1,7 +1,7 @@
> #include "qemu/osdep=2Eh"
> #include "block/export=2Eh"
>=20
>-/* Only used in programs that support block exports (libblockdev=2Efa) *=
/
>+/* Only used in programs that support block exports (libblockdev=2Ea) */
> void blk_exp_close_all(void)
> {
> }
>diff --git a/=2Egitlab-ci=2Ed/buildtest-template=2Eyml b/=2Egitlab-ci=2Ed=
/buildtest-template=2Eyml
>index 22045add8064=2E=2E69e468a576ba 100644
>--- a/=2Egitlab-ci=2Ed/buildtest-template=2Eyml
>+++ b/=2Egitlab-ci=2Ed/buildtest-template=2Eyml
>@@ -45,10 +45,8 @@
>     exclude:
>       - build/**/*=2Ep
>       - build/**/*=2Ea=2Ep
>-      - build/**/*=2Efa=2Ep
>       - build/**/*=2Ec=2Eo
>       - build/**/*=2Ec=2Eo=2Ed
>-      - build/**/*=2Efa
>=20
> =2Ecommon_test_job_template:
>   extends: =2Ebase_job_template
>diff --git a/=2Egitlab-ci=2Ed/buildtest=2Eyml b/=2Egitlab-ci=2Ed/buildtes=
t=2Eyml
>index cfdff175c389=2E=2Ec156e6f1d90e 100644
>--- a/=2Egitlab-ci=2Ed/buildtest=2Eyml
>+++ b/=2Egitlab-ci=2Ed/buildtest=2Eyml
>@@ -178,10 +178,8 @@ build-previous-qemu:
>     exclude:
>       - build-previous/**/*=2Ep
>       - build-previous/**/*=2Ea=2Ep
>-      - build-previous/**/*=2Efa=2Ep
>       - build-previous/**/*=2Ec=2Eo
>       - build-previous/**/*=2Ec=2Eo=2Ed
>-      - build-previous/**/*=2Efa
>   needs:
>     job: amd64-opensuse-leap-container
>   variables:
>diff --git a/gdbstub/meson=2Ebuild b/gdbstub/meson=2Ebuild
>index da5721d8452b=2E=2Ec91e398ae726 100644
>--- a/gdbstub/meson=2Ebuild
>+++ b/gdbstub/meson=2Ebuild
>@@ -19,13 +19,11 @@ gdb_system_ss =3D gdb_system_ss=2Eapply({})
>=20
> libgdb_user =3D static_library('gdb_user',
>                              gdb_user_ss=2Esources() + genh,
>-                             name_suffix: 'fa',
>                              c_args: '-DCONFIG_USER_ONLY',
>                              build_by_default: false)
>=20
> libgdb_system =3D static_library('gdb_system',
>                                 gdb_system_ss=2Esources() + genh,
>-                                name_suffix: 'fa',
>                                 build_by_default: false)
>=20
> gdb_user =3D declare_dependency(link_whole: libgdb_user)
>diff --git a/tcg/meson=2Ebuild b/tcg/meson=2Ebuild
>index 8251589fd4e9=2E=2Ef941413d5801 100644
>--- a/tcg/meson=2Ebuild
>+++ b/tcg/meson=2Ebuild
>@@ -31,7 +31,6 @@ tcg_ss =3D tcg_ss=2Eapply({})
>=20
> libtcg_user =3D static_library('tcg_user',
>                              tcg_ss=2Esources() + genh,
>-                             name_suffix: 'fa',
>                              c_args: '-DCONFIG_USER_ONLY',
>                              build_by_default: false)
>=20
>@@ -41,7 +40,6 @@ user_ss=2Eadd(tcg_user)
>=20
> libtcg_system =3D static_library('tcg_system',
>                                 tcg_ss=2Esources() + genh,
>-                                name_suffix: 'fa',
>                                 c_args: '-DCONFIG_SOFTMMU',
>                                 build_by_default: false)
>=20
>diff --git a/tests/Makefile=2Einclude b/tests/Makefile=2Einclude
>index c9d1674bd070=2E=2Ed39d5dd6a43e 100644
>--- a/tests/Makefile=2Einclude
>+++ b/tests/Makefile=2Einclude
>@@ -87,7 +87,7 @@ distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
> =2EPHONY: check-venv check-avocado check-acceptance check-acceptance-dep=
recated-warning
>=20
> # Build up our target list from the filtered list of ninja targets
>-TARGETS=3D$(patsubst libqemu-%=2Efa, %, $(filter libqemu-%=2Efa, $(ninja=
-targets)))
>+TARGETS=3D$(patsubst libqemu-%=2Ea, %, $(filter libqemu-%=2Ea, $(ninja-t=
argets)))
>=20
> TESTS_VENV_TOKEN=3D$(BUILD_DIR)/pyvenv/tests=2Egroup
> TESTS_RESULTS_DIR=3D$(BUILD_DIR)/tests/results
>diff --git a/tests/qtest/libqos/meson=2Ebuild b/tests/qtest/libqos/meson=
=2Ebuild
>index 3aed6efcb8d1=2E=2E45b81c83ade3 100644
>--- a/tests/qtest/libqos/meson=2Ebuild
>+++ b/tests/qtest/libqos/meson=2Ebuild
>@@ -68,7 +68,6 @@ if have_virtfs
> endif
>=20
> libqos =3D static_library('qos', libqos_srcs + genh,
>-                        name_suffix: 'fa',
>                         build_by_default: false)
>=20
> qos =3D declare_dependency(link_whole: libqos)
>

